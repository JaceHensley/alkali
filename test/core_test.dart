@TestOn('content-shell || dartium')
library core_test;

import 'package:test/test.dart';

import 'core/component_description_test.dart' as component_description_test;
import 'core/component_test.dart' as component_test;

main() {
  component_description_test.main();
  component_test.main();
}
