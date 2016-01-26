library node_test;

import 'package:alkali/alkali.dart';
import 'package:test/test.dart';

/// Main entry point for [Node] testing
main() {
  group('Node', () {
    test('has a constuctor that sets `parent`, `component`, `factory`, `isDirty`.', () {
      var parent = new Node(null, null, null);
      var component = new TestComponent();
      ComponentFactory factory = ([Map props]) => new TestComponent();
      var node = new Node(parent, component, factory);

      expect(node.parent, equals(parent));
      expect(node.component, equals(component));
      expect(node.factory, equals(factory));
      expect(node.isDirty, isTrue);
    });


  });
}

class TestComponent extends Component {
  TestComponent([Map props]) : super(props);

  TestComponent.fromChildren(dynamic child) : super.fromChildren(child);
}
