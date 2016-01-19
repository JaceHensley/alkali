part of alkali.core;

abstract class Component {
  Component(this._props): this._updateController = new StreamController<bool>();

  Component.fromChildren(dynamic child): this._updateController = new StreamController<bool>() {
    this.props['children'] = child;
  }

  Map _props = {};
  Map _state = {};

  Map get props => _props;
  Map get state => _state;

  Map _prevState;
  Map _nextState;

  final StreamController _updateController;

  Stream<bool> get needsUpdate => _updateController.stream;

  /// Should return ComponentDescription or List<ComponentDescription>.
  dynamic render() => null;
  void willMount() {}
  void didMount(html.Element rootNode) {}
  void willReceiveProps(Map nextProps) {}
  bool shouldUpdate(Map nextProps, Map nextState) => true;
  void willUpdate(Map nextProps, Map nextState) {}
  void didUpdate(Map prevProps, Map prevState, html.Element rootNode) {}
  void willUnmount() {}

  Map getDefaultProps() => {};
  Map getInitialState() => {};

  html.Element get domNode => _domNode;

  html.Element _domNode;

  void setState(Map newState) {
    if (newState != null) {
      if (_nextState == null) {
        _nextState = {};
      }
      _nextState.addAll(newState);
    }

    redraw();
  }

  redraw(){
    _updateController.add(true);
  }
}
