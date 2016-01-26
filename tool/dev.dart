library tool.dev;

import 'package:dart_dev/dart_dev.dart' show dev, config;

main(List<String> args) async {
  config.test
    ..platforms = [
      'content-shell'
    ]
    ..unitTests = [
      'test/core_test.dart'
    ];

  config.coverage
    ..html = false
    ..reportOn = [
      'lib/'
    ];

    await dev(args);
}
