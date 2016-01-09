part of alkali.core;

ComponentDescriptionFactory registerComponent(ComponentFactory factory) {
  return ([Map props]) {
    if (props == null) {
      props = {};
    }

    if (props.containsKey('children')) {
      props['children'] = parseChildren(props['children']);
    }
    return new ComponentDescription(factory, props);
  };
}
