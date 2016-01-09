library alkali.dom.dom_text_component;

import 'package:alkali/src/core.dart';
import 'package:alkali/src/dom.dart';

class DomTextComponent extends Component {
  DomTextComponent(String child): super.fromChildren(child);
}

ComponentDescriptionFactory domTextComponentDescriptionFactory =
    _registerDomTextComponent(([Map props]) => new DomTextComponent(props['children']));

ComponentDescriptionFactory _registerDomTextComponent(ComponentFactory factory) {
  return ([Map props]) {
    if (props == null) {
      props = {};
    }

    return new ComponentDescription(factory, props);
  };
}
