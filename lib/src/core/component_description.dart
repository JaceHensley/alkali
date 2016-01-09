part of alkali.core;

class ComponentDescription implements Map {
  ComponentDescription(this.factory, this.props);

  ComponentFactory factory;

  Map props = {};

  Component createComponent() => this.factory(this.props);

  ComponentDescription call({dynamic children}) {
    if (this.props['children'] == null) {
      this.props['children'] = [];
    }

    this.props['children'].addAll(parseChildren(children));

    return this;
  }

  dynamic noSuchMethod(Invocation i) {
    if (i.memberName == #call && i.isMethod) {
      if (this.props['children'] == null) {
        this.props['children'] = [];
      }

      if (i.positionalArguments != null) {
        this.props['children'].addAll(parseChildren(i.positionalArguments));
      }

      return this;
    }

    return super.noSuchMethod(i);
  }
}
