library component_test;

import 'package:alkali/alkali.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

/// Main entry point for [Component] testing.
main() {
  group('Component', () {
    test('has a default constructor that sets props', () {
      var props = {'key': 'value'};
      var component = new TestComponent(props);

      expect(component.props, equals(props));
    });

    test('has a `fromChildren` constructor that sets props[\'children\']', () {
      var child = 'Test Child';
      var component = new TestComponent.fromChildren(child);

      expect(component.props['children'], equals('Test Child'));
    });

    test('cannot modify its own `props`', () {
      var component = new TestComponent();

      expect((() => component.props = null), throws);
    });

    test('cannot modify its own `state` (outside of `setState`)', () {
      var component = new TestComponent();

      expect((() => component.state = null), throws);
    });

    test('`shouldUpdate` returns true by default', () {
      var component = new TestComponent();

      expect(component.shouldUpdate(null, null), isTrue);
    });

    test('`needsUpdate.listen` is not called when redraw is not called', () {
      var component = new TestComponent();
      var called = false;

      component.needsUpdate.listen(expectAsync((_) {}, count: 0));
    });

    test('`needsUpdate.listen` is called when redraw is called', () {
      var component = new TestComponent();
      var called = false;

      component.needsUpdate.listen(expectAsync((_) {}, count: 1));

      component.redraw();
    });
  });
}

class TestComponent extends Component {
  TestComponent([Map props]) : super(props);

  TestComponent.fromChildren(dynamic child) : super.fromChildren(child);
}
