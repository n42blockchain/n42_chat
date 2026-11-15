import 'package:flutter_test/flutter_test.dart';

import '../../../tool/live_smoke_credentials.dart';

void main() {
  LiveSmokeCredentials parse(Map<String, String> environment) =>
      LiveSmokeCredentials.fromEnvironment(
        environment,
        temporaryUsername: () => 'disposable_qa_user',
      );

  test('explicit reusable credentials preserve exact password bytes', () {
    final value = parse({
      'N42_TEST_USERNAME': '  qa_user  ',
      'N42_TEST_PASSWORD': ' pass with spaces ',
    });
    expect(value.username, 'qa_user');
    expect(value.password, ' pass with spaces ');
    expect(value.isTemporary, isFalse);
  });

  for (final extra in <Map<String, String>>[
    {},
    {'N42_TEST_INVITE_CODE': 'qa'},
  ]) {
    test(
      'existing username never falls back or registers when password absent $extra',
      () {
        var generated = false;
        expect(
          () => LiveSmokeCredentials.fromEnvironment(
            {'N42_TEST_USERNAME': 'qa_user', ...extra},
            temporaryUsername: () {
              generated = true;
              return 'unexpected';
            },
          ),
          throwsStateError,
        );
        expect(generated, isFalse);
      },
    );
  }

  for (final environment in <Map<String, String>>[
    {},
    {'N42_TEST_INVITE_CODE': '   '},
    {'N42_TEST_PASSWORD': 'explicit-secret'},
    {'N42_TEST_USERNAME': 'qa', 'N42_TEST_PASSWORD': ''},
    {'N42_TEST_INVITE_CODE': 'qa', 'N42_TEST_PASSWORD': ''},
  ]) {
    test('incomplete configuration fails before generating an account', () {
      var generated = false;
      expect(
        () => LiveSmokeCredentials.fromEnvironment(
          environment,
          temporaryUsername: () {
            generated = true;
            return 'unexpected';
          },
        ),
        throwsStateError,
      );
      expect(generated, isFalse);
    });
  }

  test('temporary accounts get independent 256-bit URL-safe secrets', () {
    final first = parse({'N42_TEST_INVITE_CODE': 'qa'});
    final second = parse({'N42_TEST_INVITE_CODE': 'qa'});
    expect(first.isTemporary, isTrue);
    expect(first.username, 'disposable_qa_user');
    expect(first.password, matches(RegExp(r'^[A-Za-z0-9_-]{43}$')));
    expect(first.password, isNot(second.password));
    expect(first.toString(), isNot(contains(first.password)));
  });

  test('explicit temporary-account password remains supported', () {
    final value = parse({
      'N42_TEST_INVITE_CODE': 'qa',
      'N42_TEST_PASSWORD': ' explicit QA secret ',
    });
    expect(value.password, ' explicit QA secret ');
    expect(value.isTemporary, isTrue);
  });

  test('validation errors never interpolate supplied secrets', () {
    const secret = 'not-for-error-output';
    try {
      parse({'N42_TEST_PASSWORD': secret});
      fail('Expected validation failure');
    } on StateError catch (error) {
      expect(error.toString(), isNot(contains(secret)));
    }
  });
}
