import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../tool/local_sdk_upgrade_smoke.dart' as upgrade;

void main() {
  final cases = <Map<String, String>>[
    {},
    {'N42_QA_UPGRADE_MODE': 'other'},
    {
      'N42_QA_UPGRADE_MODE': 'seed',
      'N42_TEST_HOMESERVER': 'https://m.si46.world',
    },
    {
      'N42_QA_UPGRADE_MODE': 'seed',
      'N42_TEST_HOMESERVER': 'http://example.com',
    },
    {
      'N42_QA_UPGRADE_MODE': 'seed',
      'N42_TEST_HOMESERVER': 'http://u:secret@localhost',
    },
    {
      'N42_QA_UPGRADE_MODE': 'seed',
      'N42_TEST_HOMESERVER': 'http://localhost',
      'N42_QA_UPGRADE_DIR': 'relative',
    },
    {
      'N42_QA_UPGRADE_MODE': 'verify',
      'N42_TEST_HOMESERVER': 'http://localhost',
      'N42_QA_UPGRADE_DIR': '/tmp/not-an-owned-fixture',
    },
    {
      'N42_QA_UPGRADE_MODE': 'seed',
      'N42_TEST_HOMESERVER': 'http://localhost',
      'N42_QA_UPGRADE_DIR': '/tmp/n42-sdk-upgrade-missing-guard',
      'N42_TEST_USERNAME': 'existing',
    },
  ];
  for (var i = 0; i < cases.length; i++) {
    test(
      'unsafe upgrade fixture configuration stops before network $i',
      () async {
        var opened = false;
        await HttpOverrides.runZoned(
          () async {
            await expectLater(
              upgrade.runLocalSdkUpgrade(environment: cases[i]),
              throwsStateError,
            );
          },
          createHttpClient: (_) {
            opened = true;
            throw StateError('Unexpected network');
          },
        );
        expect(opened, isFalse);
      },
    );
  }
}
