import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../tool/local_e2ee_smoke.dart' as smoke;

void main() {
  final cases = <Map<String, String>>[
    {},
    {'N42_TEST_HOMESERVER': 'https://m.si46.world'},
    {'N42_TEST_HOMESERVER': 'http://example.com'},
    {'N42_TEST_HOMESERVER': 'http://127.0.0.1:18948'},
    {
      'N42_TEST_HOMESERVER': 'http://127.0.0.1:18948',
      'N42_TEST_USERNAME': 'existing',
      'N42_TEST_PASSWORD': 'fixture',
    },
    {'N42_TEST_HOMESERVER': 'http://user:fixture@127.0.0.1:18948'},
  ];
  for (var i = 0; i < cases.length; i++) {
    test(
      'unsafe or incomplete E2EE QA configuration stops before IO $i',
      () async {
        var openedNetwork = false;
        await HttpOverrides.runZoned(
          () async {
            await expectLater(
              smoke.runLocalE2eeSmoke(environment: cases[i]),
              throwsStateError,
            );
          },
          createHttpClient: (_) {
            openedNetwork = true;
            throw StateError('Unexpected network access');
          },
        );
        expect(openedNetwork, isFalse);
      },
    );
  }
}
