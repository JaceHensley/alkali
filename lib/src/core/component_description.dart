part of alkali.core;

class ComponentDescription {
  ComponentDescription(this.factory, this.props);

  ComponentFactory factory;

  Map props = {};

  Component createComponent() => this.factory(this.props);

  ComponentDescription build([dynamic children]) {
    if (this.props['children'] == null) {
      this.props['children'] = [];
    }

    this.props['children'].addAll(parseChildren(children));

    return this;
  }

  ComponentDescription call([dynamic children]) {
    return build(children);
  }

  dynamic noSuchMethod(Invocation i) {
    if (i.memberName == #call && i.isMethod) {
      return build(i.positionalArguments);
    }

    return super.noSuchMethod(i);
  }
}
