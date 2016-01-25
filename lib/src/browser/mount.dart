part of alkali.browser;

final List<Node> _rootNodes = [];

final Map<html.Node, Node> elementToNode = {};

Node mountComponent(ComponentDescription description, html.HtmlElement mountRoot) {
  if (_isMounted(description, mountRoot)) {
    return _remountComponent(description, mountRoot);
  }

  Node node = new Node.fromDescription(null, description);

  _rootNodes.add(node);

  node.init();

  mountRoot.children.clear();

  mountNode(node, mountRoot);

  elementToNode[mountRoot] = node;

  return node;
}

Node _remountComponent(ComponentDescription description, html.HtmlElement mountRoot) {
  Node node = elementToNode[mountRoot];
  node.apply(description: description);
  node.isDirty = true;

  return node;
}

bool _isMounted(ComponentDescription description, html.HtmlElement mountRoot) {
  return elementToNode[mountRoot] != null && elementToNode[mountRoot].factory == description.factory;
}

void mountNode(Node node, html.HtmlElement mountRoot) {
  node.component.willMount();

  if (node.component is DomTextComponent) {
    html.Text text = new html.Text(node.component.props['children']);
    mountRoot.appendText(text.wholeText);
    node.domNode = mountRoot;
    elementToNode[mountRoot] = node;
  } else if (node.component is DomComponent) {
    DomComponent component = node.component;
    html.Element element = new html.Element.tag(component.tagName);
    node.domNode = element;
    elementToNode[element] = node;

    parseProps(node, element, component.props);

    node.children.forEach((Node child) {
      mountNode(child, element);
    });

    mountRoot.append(element);
  } else {
    node.children.forEach((Node child) {
      mountNode(child, mountRoot);
    });

    if (node.children.length > 1) {
      assert(() {
        html.window.console.warn('If a Component renders a list of children `domNode` will not be set.');
        return true;
      });
    } else {
      node.domNode = node.children.first.domNode;
    }
  }

  node.component.didMount(mountRoot);
}
