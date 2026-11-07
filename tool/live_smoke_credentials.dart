import 'dart:convert';
import 'dart:math';

/// Credentials for explicitly configured live QA, never a public fallback.
class LiveSmokeCredentials {
  const LiveSmokeCredentials._(this.username, this.password, this.isTemporary);

  final String username;
  final String password;
  final bool isTemporary;

  factory LiveSmokeCredentials.fromEnvironment(
    Map<String, String> environment, {
    required String Function() temporaryUsername,
  }) {
    final username = environment['N42_TEST_USERNAME']?.trim();
    final password = environment['N42_TEST_PASSWORD'];
    if (password != null && password.isEmpty) {
      throw StateError('N42_TEST_PASSWORD must not be empty.');
    }
    if (username != null && username.isNotEmpty) {
      if (password == null) {
        throw StateError(
          'N42_TEST_USERNAME requires an explicit N42_TEST_PASSWORD.',
        );
      }
      // Password whitespace can be significant; never trim it.
      return LiveSmokeCredentials._(username, password, false);
    }
    if (environment['N42_TEST_INVITE_CODE']?.trim().isNotEmpty != true) {
      throw StateError(
        'Missing N42_TEST_INVITE_CODE. Provide an invite code or an explicit '
        'N42_TEST_USERNAME/N42_TEST_PASSWORD pair.',
      );
    }
    final secret = password ?? _randomPassword();
    return LiveSmokeCredentials._(temporaryUsername(), secret, true);
  }

  static String _randomPassword() {
    final random = Random.secure();
    return base64Url
        .encode(List<int>.generate(32, (_) => random.nextInt(256)))
        .replaceAll('=', '');
  }
}
