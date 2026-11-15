import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';

void main() {
  tearDown(ArchiveDatabase.closeAccountInstances);

  test(
    'owned archive handles reuse only the same server and account',
    () async {
      final server = Uri.parse('https://example.org');
      final first = await ArchiveDatabase.getForAccount(
        userId: '@alice:example.org',
        homeserver: server,
      );
      final same = await ArchiveDatabase.getForAccount(
        userId: '@alice:example.org',
        homeserver: server,
      );
      final otherUser = await ArchiveDatabase.getForAccount(
        userId: '@bob:example.org',
        homeserver: server,
      );
      final otherServer = await ArchiveDatabase.getForAccount(
        userId: '@alice:example.org',
        homeserver: Uri.parse('https://other.example.org'),
      );
      expect(identical(first, same), isTrue);
      expect(identical(first, otherUser), isFalse);
      expect(identical(first, otherServer), isFalse);
    },
  );

  test('storage scope is stable and contains no account or URL text', () {
    final scope = ArchiveDatabase.accountStorageId(
      userId: '@alice:example.org',
      homeserver: Uri.parse('https://example.org/path'),
    );
    expect(scope, matches(RegExp(r'^[a-f0-9]{64}$')));
    expect(
      scope,
      ArchiveDatabase.accountStorageId(
        userId: '@alice:example.org',
        homeserver: Uri.parse('https://example.org/path'),
      ),
    );
    expect(scope, isNot(contains('alice')));
  });

  for (final user in [
    '',
    '@:',
    'alice',
    '@alice:example.org ',
    '@ali ce:example.org',
  ]) {
    test('rejects invalid account before opening: $user', () {
      expect(
        () => ArchiveDatabase.getForAccount(
          userId: user,
          homeserver: Uri.parse('https://example.org'),
        ),
        throwsArgumentError,
      );
    });
  }
  for (final server in [
    'example.org',
    'ftp://example.org',
    'https://user:secret@example.org',
    'https://example.org?token=secret',
    'https://example.org#fragment',
  ]) {
    test('rejects invalid homeserver before opening: $server', () {
      expect(
        () => ArchiveDatabase.getForAccount(
          userId: '@alice:example.org',
          homeserver: Uri.parse(server),
        ),
        throwsArgumentError,
      );
    });
  }
}
