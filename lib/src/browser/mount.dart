part of alkali.browser;

final List<Node> _rootNodes = [];

final Map<html.Node, Node> _elementToNode = {};

void mountComponent(ComponentDescription description, html.HtmlElement mountRoot) {
  if (_isMounted(description, mountRoot)) {
    return _remountComponent(description, mountRoot);
  }

  Node node = new Node.fromDescription(null, description);

  _rootNodes.add(node);

  node.init();

  mountRoot.children.clear();

  _mountNode(node, mountRoot);

  _elementToNode[mountRoot] = node;
}

void _remountComponent(ComponentDescription description, html.HtmlElement mountRoot) {
  Node node = _elementToNode[mountRoot];
  node.apply(description: description);
  node.isDirty = true;
}

bool _isMounted(ComponentDescription description, html.HtmlElement mountRoot) {
  return _elementToNode[mountRoot] != null && _elementToNode[mountRoot].factory == description.factory;
}

void _mountNode(Node node, html.HtmlElement mountRoot) {
  node.component.willMount();

  if (node.component is DomTextComponent) {
    html.Text text = new html.Text(node.component.props['children']);
    mountRoot.appendText(text.wholeText);
    node.domNode = mountRoot;
    _elementToNode[mountRoot] = node;
  } else if (node.component is DomComponent) {
    DomComponent component = node.component;
    html.Element element = new html.Element.tag(component.tagName);
    node.domNode = element;
    _elementToNode[element] = node;

    _parseProps(node, element, component.props);

    node.children.forEach((Node child) {
      _mountNode(child, element);
    });

    mountRoot.append(element);
  } else {
    node.children.forEach((Node child) {
      _mountNode(child, mountRoot);
    });
    node.domNode = node.children.first.domNode;
    _applyEventListeners(node, node.component.props);
  }

  node.component.didMount(mountRoot);
}
