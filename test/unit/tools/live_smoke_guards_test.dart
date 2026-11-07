import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../tool/live_media_smoke.dart' as smoke;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final cases = <Map<String, String>>[
    {},
    {'N42_TEST_USERNAME': 'qa_fixture'},
    {'N42_TEST_PASSWORD': 'explicit-test-secret'},
  ];
  for (var index = 0; index < cases.length; index++) {
    test(
      'invalid live media credentials stop before network case $index',
      () async {
        var openedNetwork = false;
        await HttpOverrides.runZoned(
          () async {
            await expectLater(
              smoke.runLiveMediaSmoke(environment: cases[index]),
              throwsStateError,
            );
          },
          createHttpClient: (_) {
            openedNetwork = true;
            throw StateError('Unexpected live server access');
          },
        );
        expect(openedNetwork, isFalse);
      },
    );
  }
}
