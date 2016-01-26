part of alkali.core;

abstract class Component {
  Component([this._props]): this._updateController = new StreamController<bool>();

  Component.fromChildren(dynamic child): this._updateController = new StreamController<bool>() {
    this._props['children'] = child;
  }

  Map _props = {};
  Map _state = {};

  UnmodifiableMapView get props => new UnmodifiableMapView(_props);
  UnmodifiableMapView get state => new UnmodifiableMapView(_state);

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
  void didUpdate(Map prevProps, Map prevState) {}
  void willUnmount() {}

  Map getDefaultProps() => {};
  Map getInitialState() => {};

  html.Element _domNode;

  html.Element get domNode => _domNode;

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
