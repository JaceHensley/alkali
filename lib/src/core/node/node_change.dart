part of alkali.core;

class NodeChange {
  final NodeChangeType type;

  final Map oldProps;
  final Map newProps;

  final Map prevState;
  final Map nextState;

  NodeChange(NodeChangeType this.type, {Map this.oldProps, Map this.newProps, Map this.prevState, Map this.nextState});
}

/// Different ways a [Node] can change.
class NodeChangeType {
  const NodeChangeType._(this.value);

  final String value;

  static const created = const NodeChangeType._('created');
  static const updated = const NodeChangeType._('updated');
  static const moved = const NodeChangeType._('moved');
  static const deleted = const NodeChangeType._('deleted');
  static const none = const NodeChangeType._('none');

  static List<NodeChangeType> get values => [
    created,
    updated,
    moved,
    deleted,
    none
  ];

  String toString() => this.value;
}
