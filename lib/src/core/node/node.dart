part of alkali.core;

class Node {
  Node(this.parent, this.component, this.factory) {
    this.isDirty = true;
    this.children = [];
    if (this.component.needsUpdate != null) {
      component.needsUpdate.listen(componentNeedsUpdate);
    }
  }

  factory Node.fromDescription(Node parent, ComponentDescription description) {
    return new Node(parent, description.createComponent(), description.factory);
  }

  final Component component;

  final Node parent;

  List<Node> children;

  Map _oldProps;

  final ComponentFactory factory;

  bool _isDirty = true;

  bool _hasDirtyDescendant = true;

  bool _wasNeverInitialized = true;

  bool get isDirty => _isDirty;

  set isDirty(bool value) {
    bool changed = !this._isDirty;
    this._isDirty = value;

    if (parent != null && changed && !_hasDirtyDescendant) {
      parent.hasDirtyDescendant = true;
    }
  }

  bool get hasDirtyDescendant => _hasDirtyDescendant;

  set hasDirtyDescendant(bool value) {
    bool changed = !this._hasDirtyDescendant;
    this._hasDirtyDescendant = value;

    if (parent != null && changed) {
      parent.hasDirtyDescendant = true;
    }
  }

  html.Element get domNode => this.component.domNode;

  set domNode(html.Element value) {
    this.component._domNode = value;
  }

  NodeChange change;

  void componentNeedsUpdate(bool now) {
    this.isDirty = true;
  }

  void update({bool force: false}) {
    if ((this.isDirty || force) && this.component.shouldUpdate(component.props, this._oldProps)) {
      this.change = new NodeChange(NodeChangeType.updated, oldProps: this._oldProps, newProps: this.component.props);
      this.component.state = new Map.from(this.component.nextState);
      _updateChildren(this);
    } else if (this.hasDirtyDescendant) {
      this.children.forEach((Node child) => child.update());
    }
  }

  void init() {
    if (!this._wasNeverInitialized) {
      return;
    }

    Map appliedProps = new Map.from(this.component.props);
    this.component.getDefaultProps().forEach((key, value) {
      if (!appliedProps.containsKey(key)) {
        appliedProps[key] = value;
      }
    });

    this.component.props = appliedProps;
    this.component.state.addAll(this.component.getInitialState());

    _initChildren(this);

    this._wasNeverInitialized = false;
  }

  void _initChildren(Node node) {
    List<Node> newChildren = [];
    List<ComponentDescription> descriptions = _getComponentChildren(node.component);

    for(var index = 0; index < descriptions.length; index++) {
      var description = descriptions[index];
      Node newChild = new Node.fromDescription(node, description);
      newChild.change = new NodeChange(NodeChangeType.created);

      newChild.init();

      newChildren.add(newChild);
    }

    node.children = newChildren;
  }

  void apply({ComponentDescription description}) {
    this.component.willReceiveProps(description.props);
    this._oldProps = this.component.props;
    this.component.props = description.props;
  }

  void _updateChildren(Node node) {
    Map<int, Node> oldChildren = _getOldChildrenMap(node);
    Map<dynamic, num> oldChildrenPositions = _getOldChildrenPostions(oldChildren.keys);
    List<Node> newChildren = [];
    List<ComponentDescription> descriptions = _getComponentChildren(node.component);

    for(var index = 0; index < descriptions.length; index++) {
      ComponentDescription description = descriptions[index];
      Node oldChild = oldChildren[index];
      Node newChild;

      if (oldChild != null && oldChild.factory == description.factory) {
        newChild = oldChild;
        newChild.apply(description: description);

        if (index != oldChildren.values.toList().indexOf(node.children[index])) {
          newChild.change = new NodeChange(NodeChangeType.moved);
        }
        newChild.update(force: true);
        oldChildren.remove(index);
      } else {
        newChild = new Node.fromDescription(node, description);
        newChild.update();
        newChild.change = new NodeChange(NodeChangeType.created);

        if (oldChild != null) {
          oldChild.change = new NodeChange(NodeChangeType.deleted);
          oldChildren.remove(index);
        }
      }

      newChildren.add(newChild);
    }

    oldChildren.forEach((int key, Node child) {
      child.change = new NodeChange(NodeChangeType.deleted);
    });

    node.children = newChildren;
  }

  Map<int, Node> _getOldChildrenMap(Node parent) {
    Map<int, Node> children = {};

    for(var index = 0; index < parent.children.length; index++) {
      children[index] = parent.children[index];
    }

    return children;
  }

  Map<int, int> _getOldChildrenPostions(Iterable<int> input) {
    Map<int, int> result = {};

    for (var i = 0; i < input.length; i++) {
      result[input.elementAt(i)] = i;
    }

    return result;
  }

  List<ComponentDescription> _getComponentChildren(Component component) {
    var rawChildren = component.render();
    if (rawChildren is ComponentDescription) {
      return [rawChildren];
    } else if (rawChildren is List<ComponentDescription>) {
      return rawChildren;
    } else if (rawChildren == null) {
      return [];
    } else {
      throw 'Component.render should return ComponentDescription of List<ComponentDescription>.';
    }
  }
}
