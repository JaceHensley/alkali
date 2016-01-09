part of alkali.core;

class NodeChange {
  final NodeChangeType type;
  final Map oldProps;
  final Map newProps;

  NodeChange(NodeChangeType this.type, {Map this.oldProps, Map this.newProps});
}

/// Different ways a [Node] can change.
class NodeChangeType {
  const NodeChangeType._(this.value);

  final String value;

  static const created = const NodeChangeType._('created');
  static const updated = const NodeChangeType._('updated');
  static const moved = const NodeChangeType._('moved');
  static const deleted = const NodeChangeType._('deleted');

  static List<NodeChangeType> get values => [
    created,
    updated,
    moved,
    deleted
  ];

  String toString() => this.value;
}
