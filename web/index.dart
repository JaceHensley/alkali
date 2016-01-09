import 'dart:html';

import 'package:alkali/alkali.dart';


void main() {
  initAlkaliBrowserConfiguration();

  mountComponent(CustomComponent()('Text'), querySelector('#alkali-content'));
}

ComponentDescription CustomComponent() => _CustomComponentFactory();

ComponentDescriptionFactory _CustomComponentFactory = registerComponent(([Map props]) => new _CustomComponent(props));

class _CustomComponent extends Component {
  _CustomComponent([props]): super(props);
  @override
  Map getDefaultProps() => {
    'custom.colors': [
      'red',
      'blue',
      'green'
    ]
  };


  @override
  Map getInitialState() => {
    'custom.colorIndex': 0
  };

  _handleClick(_) {
    var nextIndex = ++state['custom.colorIndex'];
    nextIndex = nextIndex % props['custom.colors'].length;
    setState({
      'custom.colorIndex': nextIndex
    });
  }

  @override
  render() {
    return div({
      'id': 'text',
      'style': {
        'color': props['custom.colors'][state['custom.colorIndex']]
      },
      'onClick': _handleClick,
      'children': props['children']
    });
  }
}
