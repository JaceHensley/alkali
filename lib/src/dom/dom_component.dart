library alkali.dom.dom_component;

import 'package:alkali/src/core.dart';
import 'dom_elements.dart';

class DomComponent extends Component {
  DomComponent(Map props, this.tagName) : super(props);

  final String tagName;

  List<ComponentDescription> render() {
    return this.props['children'];
  }
}
