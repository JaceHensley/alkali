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

  Map _newProps;

  Map _prevProps;

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

  void componentNeedsUpdate(bool now) {
    this.isDirty = true;
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

    this.component._props = appliedProps;
    this.component._state.addAll(this.component.getInitialState());

    _initChildren(this);

    this._wasNeverInitialized = false;
  }

  void _initChildren(Node node) {
    List<Node> newChildren = [];
    List<ComponentDescription> descriptions = _getComponentChildren(node.component);

    for(var index = 0; index < descriptions.length; index++) {
      var description = descriptions[index];
      Node newChild = new Node.fromDescription(node, description);

      newChild.init();

      newChildren.add(newChild);
    }

    node.children = newChildren;
  }

  void update({bool force: false}) {
    if ((this.isDirty || force) && this.component.shouldUpdate(this._newProps, this.component._nextState)) {
      this.component.willUpdate(this._newProps, this.component._nextState);

      var prevProps = new Map.from(this.component._props);
      if (this._newProps != null) {
        this.component._props = new Map.from(this._newProps);
      }

      this.component._prevState = new Map.from(this.component._state);
      if (this.component._nextState != null) {
        this.component._state = new Map.from(this.component._nextState);
      }

      _updateChildren(this);

      this.component.didUpdate(prevProps, this.component._prevState);

      this.isDirty = this.hasDirtyDescendant = false;
    } else if (this.hasDirtyDescendant) {
      this.children.forEach((Node child) => child.update());

      this.hasDirtyDescendant = false;
    }
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

        newChild._applyUpdatedChange(newChild.component.props, newChild._prevProps);

        if (index != oldChildren.values.toList().indexOf(node.children[index])) {
          newChild._applyMovedChange();
        }
        newChild.update(force: true);
        oldChildren.remove(index);
      } else {
        newChild = new Node.fromDescription(node, description);
        newChild.update();
        newChild._applyCreatedChange();

        if (oldChild != null) {
          oldChild._applyDeletedChange();
          oldChildren.remove(index);
        }
      }

      newChildren.add(newChild);
    }

    oldChildren.forEach((int key, Node child) {
      child._applyDeletedChange();
    });

    node.children = newChildren;
  }

  void apply({ComponentDescription description}) {
    this.component.willReceiveProps(description.props);
    this._prevProps = this.component._props;
    this.component._props = description.props;
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

  void _applyCreatedChange() {
    html.Element mountRoot = this.parent.domNode;
    mountNode(this, mountRoot);
  }

  void _applyUpdatedChange(Map newProps, Map oldProps) {
    if (this.component is DomComponent) {
      parseProps(this, this.domNode, newProps, oldProps: oldProps);
    } else if (this.component is DomTextComponent) {
      this.domNode.text = this.component.props['children'];
    }
  }

  void _applyDeletedChange() {

  }

  void _applyMovedChange() {
    if (this.component is DomComponent) {
      html.Element mountRoot = this.parent.domNode;
      Node nextNode = _findFirstDomDescendant(this.parent);

      html.Element element = this.parent.domNode;
      html.Element nextElement = nextNode.parent.domNode;
      mountRoot.insertBefore(element, nextElement);
    } else {
      this.children.reversed.forEach((Node child) => child._applyMovedChange());
    }
  }

  Node _findFirstDomDescendant(Node parent) {
    Node descendant;
    Node result;
    for (var index = parent.children.length - 1; index >= 0; index--) {
      Node child = parent.children[index];
      if (child != this) {
        if (child.component is DomComponent && child.domNode != null) {
          result = child;
        } else if (!(child.component is DomComponent)) {
          result = this._findFirstDomDescendant(child);
        }
      }
    }

    if (result != null) {
      return result;
    }

    if (parent.component is DomComponent) {
      return null;
    }

    if (parent.parent != null) {
      return parent._findFirstDomDescendant(parent.parent);
    }
  }

  void _removeNodeFromDom() {
    if (this.component is DomComponent || this.component is DomTextComponent) {
      this.component.willUnmount();

      elementToNode.remove(this.domNode);
      this.domNode.remove();
      this.domNode = null;
    } else {
      this.component.willUnmount();
      this.children.forEach((Node child) {
        child._removeNodeFromDom();
      });
    }
  }
}
