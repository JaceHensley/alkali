library alkali.dom.dom_component;

import 'package:alkali/src/core.dart';

class DomComponent extends Component {
  DomComponent(Map props, this.tagName) : super(props);

  final String tagName;

  @override
  List<ComponentDescription> render() {
    return this.props['children'];
  }
}
