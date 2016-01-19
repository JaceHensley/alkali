part of alkali.browser;

bool _browserConfigurationInitialized = false;

var scheduler;

void initAlkaliBrowserConfiguration() {
  if (!_browserConfigurationInitialized) {
    html.window.animationFrame.then(_update);
    _browserConfigurationInitialized = true;
  }
}

void _update(num data) {
  try {
    _updateTrees(data);
  } finally {
    html.window.animationFrame.then(_update);
  }
}

void _updateTrees(_) {
  _rootNodes.forEach((Node node) {
    _updateTree(node);
  });
}

void _updateTree(Node rootNode) {
  if (rootNode.isDirty || rootNode.hasDirtyDescendant || rootNode.change != NodeChangeType.none) {
    rootNode.update();
    rootNode.isDirty = false;
    rootNode.children.reversed.forEach(_applyChanges);
    rootNode.hasDirtyDescendant = false;
  }
}

void _applyChanges(Node node) {
  if (node.isDirty || node.hasDirtyDescendant || node.change != NodeChangeType.none) {
    _applyChange(node);
    node.isDirty = false;
    node.children.reversed.forEach(_applyChanges);
    node.hasDirtyDescendant = false;
  }
}

void _applyChange(Node node) {
  var change = node.change;
  switch (change.type) {
    case NodeChangeType.created:
      _applyCreatedChange(node);
      break;
    case NodeChangeType.updated:
      _applyUpdatedChange(node);
      break;
    case NodeChangeType.deleted:
      _applyDeletedChange(node);
      break;
    case NodeChangeType.moved:
      _applyMovedChange(node);
      break;
  }

  node.change = new NodeChange(NodeChangeType.none);
}

void _applyCreatedChange(Node node) {
  html.Element mountRoot = node.parent.domNode;
  _mountNode(node, mountRoot);
}

void _applyUpdatedChange(Node node) {
  node.component.willUpdate(node.change.newProps, node.component.nextState);

  if (node.component is DomComponent) {
    _parseProps(node, node.domNode, node.change.newProps, oldProps: node.change.oldProps);
  } else if (node.component is DomTextComponent) {
    node.domNode.text = node.component.props['children'];
  }

  node.component.didUpdate(node.change.oldProps, node.component.prevState, node.domNode);
}

void _applyDeletedChange(Node node) {
  _removeNodeFromDom(node);
}

void _applyMovedChange(Node node) {
  _moveNode(node);
}

void _moveNode(Node node) {
  if (node.component is DomComponent) {
    html.Element mountRoot = node.parent.domNode;
    Node nextNode = _findFirstDomDescendant(node.parent, node);

    html.Element element = node.parent.domNode;
    html.Element nextElement = nextNode.parent.domNode;
    mountRoot.insertBefore(element, nextElement);
  } else {
    node.children.reversed.forEach((Node child) => _moveNode(child));
  }
}

void _removeNodeFromDom(Node node) {
  if (node.component is DomComponent || node.component is DomTextComponent) {
    html.Node element = node.domNode;
    node.component.willUnmount();

    _elementToNode.remove(node.domNode);
    node.domNode.remove();
    node.domNode = null;
  } else {
    node.component.willUnmount();
    node.children.forEach((Node child) {
      _removeNodeFromDom(child);
    });
  }
}

Node _findFirstDomDescendant(Node parent, Node node) {
  Node descendant;
  Node result;
  for (var index = parent.children.length - 1; index >= 0; index--) {
    Node child = parent.children[index];
    if (child != node) {
      if (child.component is DomComponent && child.domNode != null) {
        result = child;
      } else if (!(child.component is DomComponent)) {
        result = _findFirstDomDescendant(child, node);
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
    return _findFirstDomDescendant(parent.parent, parent);
  }
}
