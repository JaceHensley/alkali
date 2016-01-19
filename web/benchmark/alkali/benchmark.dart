import 'dart:html';
import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:alkali/alkali.dart' as alkali;

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


class AlkaliListOneChild extends BenchmarkBase {
  final Function componentFactory;
  AlkaliListOneChild(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) Alkali children as list: 1 child', emitter: emitter);
  void run() {
    componentFactory({})([
      alkali.div({'children': '1'})
    ]);
  }
}
class AlkaliVariadicOneChild extends BenchmarkBase {
  final Function componentFactory;
  AlkaliVariadicOneChild(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) Alkali children as variadic: 1 child', emitter: emitter);
  void run() {
    componentFactory({})(
      alkali.div({'children': '1'})
    );
  }
}

class AlkaliListTwoChildren extends BenchmarkBase {
  final Function componentFactory;
  AlkaliListTwoChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) Alkali children as list: 2 children', emitter: emitter);
  void run() {
    componentFactory({})([
      alkali.div({'children': '1'}),
      alkali.div({'children': '2'})
    ]);
  }
}
class AlkaliVariadicTwoChildren extends BenchmarkBase {
  final Function componentFactory;
  AlkaliVariadicTwoChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) Alkali children as variadic: 2 children', emitter: emitter);
  void run() {
    componentFactory({})(
      alkali.div({'children': '1'}),
      alkali.div({'children': '2'})
    );
  }
}


class AlkaliListThreeChildren extends BenchmarkBase {
  final Function componentFactory;
  AlkaliListThreeChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) Alkali children as list: 3 children', emitter: emitter);
  void run() {
    componentFactory({})([
      alkali.div({'children': '1'}),
      alkali.div({'children': '2'}),
      alkali.div({'children': '3'})
    ]);
  }
}
class AlkaliVariadicThreeChildren extends BenchmarkBase {
  final Function componentFactory;
  AlkaliVariadicThreeChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) Alkali children as variadic: 3 children', emitter: emitter);
  void run() {
    componentFactory({})(
      alkali.div({'children': '1'}),
      alkali.div({'children': '2'}),
      alkali.div({'children': '3'}),
      alkali.div({'children': '4'})
    );
  }
}


class AlkaliListFourChildren extends BenchmarkBase {
  final Function componentFactory;
  AlkaliListFourChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) Alkali children as list: 4 children', emitter: emitter);
  void run() {
    componentFactory({})([
      alkali.div({'children': '1'}),
      alkali.div({'children': '2'}),
      alkali.div({'children': '3'}),
      alkali.div({'children': '4'})
    ]);
  }
}
class AlkaliVariadicFourChildren extends BenchmarkBase {
  final Function componentFactory;
  AlkaliVariadicFourChildren(String factoryName, this.componentFactory, {ScoreEmitter emitter}) : super('($factoryName) Alkali children as variadic: 4 children', emitter: emitter);
  void run() {
    componentFactory({})(
      alkali.div({'children': '1'}),
      alkali.div({'children': '2'}),
      alkali.div({'children': '3'}),
      alkali.div({'children': '4'})
    );
  }
}


Function CustomComponent = alkali.registerComponent(([props]) => new _CustomComponent());
class _CustomComponent extends alkali.Component {
  _CustomComponent([props]): super(props);

  render() => alkali.div(props);
}


// Main function runs the benchmark.
main() async {
  String headingText = 'alkali element construction performance benchmark';

  document.body.children.insert(0, new HeadingElement.h1()..text = headingText);

  alkali.initAlkaliBrowserConfiguration();
  var emitter = new HtmlEmitter();

  emitter.addDivider();

  await new AlkaliListOneChild('alkali.div', alkali.div, emitter: emitter).report();
  await new AlkaliVariadicOneChild('alkali.div', alkali.div, emitter: emitter).report();

  emitter.addDivider();

  await new AlkaliListTwoChildren('alkali.div', alkali.div, emitter: emitter).report();
  await new AlkaliVariadicTwoChildren('alkali.div', alkali.div, emitter: emitter).report();

  emitter.addDivider();

  await new AlkaliListThreeChildren('alkali.div', alkali.div, emitter: emitter).report();
  await new AlkaliVariadicThreeChildren('alkali.div', alkali.div, emitter: emitter).report();

  emitter.addDivider();

  await new AlkaliListFourChildren('alkali.div', alkali.div, emitter: emitter).report();
  await new AlkaliVariadicFourChildren('alkali.div', alkali.div, emitter: emitter).report();

  emitter.addDivider();
  emitter.addDivider();

  await new AlkaliListOneChild('CustomComponent', CustomComponent, emitter: emitter).report();
  await new AlkaliVariadicOneChild('CustomComponent', CustomComponent, emitter: emitter).report();

  emitter.addDivider();

  await new AlkaliListTwoChildren('CustomComponent', CustomComponent, emitter: emitter).report();
  await new AlkaliVariadicTwoChildren('CustomComponent', CustomComponent, emitter: emitter).report();

  emitter.addDivider();

  await new AlkaliListThreeChildren('CustomComponent', CustomComponent, emitter: emitter).report();
  await new AlkaliVariadicThreeChildren('CustomComponent', CustomComponent, emitter: emitter).report();

  emitter.addDivider();

  await new AlkaliListFourChildren('CustomComponent', CustomComponent, emitter: emitter).report();
  await new AlkaliVariadicFourChildren('CustomComponent', CustomComponent, emitter: emitter).report();


  document.body.classes.add('benchmark-complete');
}
