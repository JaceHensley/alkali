part of alkali.browser;

void unmountComponent(html.Element mountRoot) {
  Node node = _elementToNode[mountRoot];

  if (node == null && mountRoot.children.length == 1) {
    node = _elementToNode[mountRoot.firstChild];

    while (node.parent != null) {
      node = node.parent;
    }
  }

  if (node != null) {
    _unmountNode(node);
    mountRoot.children.clear();
  }
}

void _unmountNode(Node node) {
  node.component.willUnmount();
  node.children.forEach((Node child) {
    _unmountNode(child);
  });
  node.domNode = null;
  _elementToNode.remove(node.domNode);
}
