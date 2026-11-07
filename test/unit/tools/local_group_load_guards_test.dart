import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../tool/local_group_load.dart' as load;

void main() {
  final cases = <Map<String, String>>[
    {},
    {'N42_TEST_HOMESERVER': 'https://m.si46.world'},
    {'N42_TEST_HOMESERVER': 'http://example.com'},
    {'N42_TEST_HOMESERVER': 'http://user:secret@localhost'},
    {'N42_TEST_HOMESERVER': 'http://localhost:18948'},
    for (final size in ['0', '2', '21', 'invalid'])
      {
        'N42_TEST_HOMESERVER': 'http://localhost:18948',
        'N42_TEST_INVITE_CODE': 'fixture',
        'N42_QA_GROUP_MEMBERS': size,
      },
    for (final size in ['0', '9', '10001', 'invalid'])
      {
        'N42_TEST_HOMESERVER': 'http://localhost:18948',
        'N42_TEST_INVITE_CODE': 'fixture',
        'N42_QA_GROUP_MESSAGES': size,
      },
    {
      'N42_TEST_HOMESERVER': 'http://localhost:18948',
      'N42_TEST_INVITE_CODE': 'fixture',
      'N42_TEST_USERNAME': 'existing',
    },
  ];
  for (var i = 0; i < cases.length; i++) {
    test('unsafe or incomplete group load stops before IO $i', () async {
      var network = false;
      await HttpOverrides.runZoned(
        () async {
          await expectLater(
            load.runLocalGroupLoad(environment: cases[i]),
            throwsStateError,
          );
        },
        createHttpClient: (_) {
          network = true;
          throw StateError('Unexpected network');
        },
      );
      expect(network, isFalse);
    });
  }
}
