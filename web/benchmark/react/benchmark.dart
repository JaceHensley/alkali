import 'dart:html';
import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';

class HtmlEmitter implements ScoreEmitter {
  final TableElement _table;

  HtmlEmitter() : _table = new TableElement() {
    _table.createTHead().addRow()
      ..addCell().text = 'Test'
      ..addCell().text = 'Runtime';

    document.body.append(_table);
  }

  void emit(String testName, double value) {
    _table.addRow()
      ..addCell().text = testName
      ..addCell().text = '${value.toStringAsPrecision(5)} μs';
  }

  void addDivider() {
    _table.addRow().className = 'divider';
  }
}


class ReactListOneChild extends BenchmarkBase {
  final Function componentFactory;
  ReactListOneChild(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) React children as list: 1 child', emitter: emitter);
  void run() {
    componentFactory({}, [
      react.div({}, '1')
    ]);
  }
}
class ReactVariadicOneChild extends BenchmarkBase {
  final Function componentFactory;
  ReactVariadicOneChild(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) React children as variadic: 1 child', emitter: emitter);
  void run() {
    componentFactory({},
      react.div({}, '1')
    );
  }
}

class ReactListTwoChildren extends BenchmarkBase {
  final Function componentFactory;
  ReactListTwoChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) React children as list: 2 children', emitter: emitter);
  void run() {
    componentFactory({}, [
      react.div({}, '1'),
      react.div({}, '2')
    ]);
  }
}
class ReactVariadicTwoChildren extends BenchmarkBase {
  final Function componentFactory;
  ReactVariadicTwoChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) React children as variadic: 2 children', emitter: emitter);
  void run() {
    componentFactory({},
      react.div({}, '1'),
      react.div({}, '2')
    );
  }
}


class ReactListThreeChildren extends BenchmarkBase {
  final Function componentFactory;
  ReactListThreeChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) React children as list: 3 children', emitter: emitter);
  void run() {
    componentFactory({}, [
      react.div({}, '1'),
      react.div({}, '2'),
      react.div({}, '3')
    ]);
  }
}
class ReactVariadicThreeChildren extends BenchmarkBase {
  final Function componentFactory;
  ReactVariadicThreeChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) React children as variadic: 3 children', emitter: emitter);
  void run() {
    componentFactory({},
      react.div({}, '1'),
      react.div({}, '2'),
      react.div({}, '3')
    );
  }
}


class ReactListFourChildren extends BenchmarkBase {
  final Function componentFactory;
  ReactListFourChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) React children as list: 4 children', emitter: emitter);
  void run() {
    componentFactory({}, [
      react.div({}, '1'),
      react.div({}, '2'),
      react.div({}, '3'),
      react.div({}, '4')
    ]);
  }
}
class ReactVariadicFourChildren extends BenchmarkBase {
  final Function componentFactory;
  ReactVariadicFourChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) React children as variadic: 4 children', emitter: emitter);
  void run() {
    componentFactory({},
      react.div({}, '1'),
      react.div({}, '2'),
      react.div({}, '3'),
      react.div({}, '4')
    );
  }
}


Function CustomComponent = react.registerComponent(() => new _CustomComponent());
class _CustomComponent extends react.Component {
  render() => react.div({}, props['children']);
}


// Main function runs the benchmark.
main() async {
  String headingText = 'React element construction performance benchmark';

  document.body.children.insert(0, new HeadingElement.h1()..text = headingText);

  setClientConfiguration();
  var emitter = new HtmlEmitter();

  emitter.addDivider();

  await new ReactListOneChild('react.div', react.div, emitter: emitter).report();
  await new ReactVariadicOneChild('react.div', react.div, emitter: emitter).report();

  emitter.addDivider();

  await new ReactListTwoChildren('react.div', react.div, emitter: emitter).report();
  await new ReactVariadicTwoChildren('react.div', react.div, emitter: emitter).report();

  emitter.addDivider();

  await new ReactListThreeChildren('react.div', react.div, emitter: emitter).report();
  await new ReactVariadicThreeChildren('react.div', react.div, emitter: emitter).report();

  emitter.addDivider();

  await new ReactListFourChildren('react.div', react.div, emitter: emitter).report();
  await new ReactVariadicFourChildren('react.div', react.div, emitter: emitter).report();

  emitter.addDivider();
  emitter.addDivider();

  await new ReactListOneChild('CustomComponent', CustomComponent, emitter: emitter).report();
  await new ReactVariadicOneChild('CustomComponent', CustomComponent, emitter: emitter).report();

  emitter.addDivider();

  await new ReactListTwoChildren('CustomComponent', CustomComponent, emitter: emitter).report();
  await new ReactVariadicTwoChildren('CustomComponent', CustomComponent, emitter: emitter).report();

  emitter.addDivider();

  await new ReactListThreeChildren('CustomComponent', CustomComponent, emitter: emitter).report();
  await new ReactVariadicThreeChildren('CustomComponent', CustomComponent, emitter: emitter).report();

  emitter.addDivider();

  await new ReactListFourChildren('CustomComponent', CustomComponent, emitter: emitter).report();
  await new ReactVariadicFourChildren('CustomComponent', CustomComponent, emitter: emitter).report();


  document.body.classes.add('benchmark-complete');
}
