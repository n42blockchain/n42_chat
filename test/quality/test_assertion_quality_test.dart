import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Chat tests contain no constant tautological assertions', () {
    final tautology = RegExp(
      'ex' +
          'pect\\s*\\(\\s*(?:' +
          'tr' +
          'ue\\s*,\\s*(?:tr' +
          'ue|isTr' +
          'ue)|fa' +
          'lse\\s*,\\s*(?:fa' +
          'lse|isFa' +
          'lse))\\s*\\)',
    );
    final violations = Directory('test')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('_test.dart'))
        .where(
          (file) => !file.path.endsWith('test_assertion_quality_test.dart'),
        )
        .where((file) => tautology.hasMatch(file.readAsStringSync()))
        .map((file) => file.path)
        .toList(growable: false);

    expect(
      violations,
      isEmpty,
      reason:
          'Tests must assert observable behavior, not a constant that always '
          'matches itself.',
    );
  });

  test('live account-switch skip explains its environment requirements', () {
    final source = File(
      'test/live/account_switch_encryption_test.dart',
    ).readAsStringSync();

    expect(source, contains('Requires macOS with the native crypto library.'));
    expect(
      source,
      contains('Requires an N42_QA_STATE file with disposable QA accounts.'),
    );
  });
}
