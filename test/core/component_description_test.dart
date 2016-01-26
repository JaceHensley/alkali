library component_description_test;

import 'package:alkali/alkali.dart';
import 'package:test/test.dart';

/// Main entry point for [ComponentDescription] testing.
main() {
  group('ComponentDescription', () {
    test('is created with a ComponentFactory and props', () {
      ComponentFactory factory = ([Map props]) => null;
      var props = {'key': 'value'};

      var description = new ComponentDescription(factory, props);

      expect(description.factory, equals(factory));
      expect(description.props, equals(props));
    });

    test('returns a component that has given props', () {
      ComponentFactory factory = ([Map props]) => new TestComponent(props);
      var props = {'key': 'value'};
      var description = new ComponentDescription(factory, props);

      expect(description.createComponent().props, equals(props));
    });

    group('sets props[\'children\'] to the', () {
      test('value passed in during a call to the object', () {
        ComponentFactory factory = ([Map props]) => new TestComponent(props);
        var props = {'key': 'value'};
        var description = new ComponentDescription(factory, props);

        description('Test Children');

        var newProps = description.props;

        expect(newProps['key'], equals('value'));
        expect(newProps['children'], new isInstanceOf<List<ComponentDescription>>());
        expect(newProps['children'].length, equals(1));
      });

      test('value passed in during a call to the object when children already exsist in the props map', () {
        ComponentFactory factory = ([Map props]) => new TestComponent(props);
        var props = {
          'key': 'value',
          'children': ['Test Child 1']
        };
        var description = new ComponentDescription(factory, props);

        description('Test Child 2');

        var newProps = description.props;

        expect(newProps['key'], equals('value'));
        expect(newProps['children'], new isInstanceOf<List<ComponentDescription>>());
        expect(newProps['children'].length, equals(2));
      });

      test('values passed in variadically to the object', () {
        ComponentFactory factory = ([Map props]) => new TestComponent(props);
        var props = {'key': 'value'};
        var description = new ComponentDescription(factory, props);

        description('Test Child 1', 'Test Child 2');

        var newProps = description.props;

        expect(newProps['key'], equals('value'));
        expect(newProps['children'], new isInstanceOf<List<ComponentDescription>>());
        expect(newProps['children'].length, equals(2));
      });

      test('values passed in variadically to the object when children already exsist in the props map', () {
        ComponentFactory factory = ([Map props]) => new TestComponent(props);
        var props = {
          'key': 'value',
          'children': ['Test Child 1']
        };
        var description = new ComponentDescription(factory, props);

        description('Test Child 2', 'Test Child 3');

        var newProps = description.props;

        expect(newProps['key'], equals('value'));
        expect(newProps['children'], new isInstanceOf<List<ComponentDescription>>());
        expect(newProps['children'].length, equals(3));
      });
    });
  });
}

class TestComponent extends Component {
  TestComponent(props) : super(props);
}
