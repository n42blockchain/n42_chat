import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/data/services/matrix_pending_deletion_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final server = Uri.parse('https://hs.test');

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test(
    'confirmed A cleanup survives a new store instance without secrets',
    () async {
      final store = MatrixPendingDeletionStore();
      await store.markPending(
        userId: '@a:hs',
        homeserver: server,
        deviceId: 'device-A',
      );

      final pending = await MatrixPendingDeletionStore().list();
      expect(pending, hasLength(1));
      expect(pending.single.userId, '@a:hs');
      expect(pending.single.homeserver, server);
      expect(pending.single.deviceId, 'device-A');
      expect(pending.single.version, 1);
      final raw = (await SharedPreferences.getInstance()).getString(
        'n42_chat_pending_deletion_cleanup_v1',
      )!;
      expect(raw, isNot(contains('accessToken')));
      expect(raw, isNot(contains('password')));
    },
  );

  test('completing A retains unrelated B pending cleanup', () async {
    final store = MatrixPendingDeletionStore();
    await store.markPending(
      userId: '@a:hs',
      homeserver: server,
      deviceId: 'device-A',
    );
    await store.markPending(
      userId: '@b:hs',
      homeserver: server,
      deviceId: 'device-B',
    );

    await store.complete(
      userId: '@a:hs',
      homeserver: server,
      deviceId: 'device-A',
    );

    expect((await store.list()).map((entry) => entry.userId), ['@b:hs']);
  });

  test('concurrent marks retain both identities', () async {
    final store = MatrixPendingDeletionStore();
    await Future.wait([
      store.markPending(
        userId: '@a:hs',
        homeserver: server,
        deviceId: 'device-A',
      ),
      MatrixPendingDeletionStore().markPending(
        userId: '@b:hs',
        homeserver: server,
        deviceId: 'device-B',
      ),
    ]);

    expect((await store.list()).map((entry) => entry.userId), [
      '@a:hs',
      '@b:hs',
    ]);
  });

  test('rejects credential-bearing homeserver URLs before writing', () async {
    final store = MatrixPendingDeletionStore();
    for (final uri in [
      'https://name:secret@hs.test/base',
      'https://hs.test/base?access_token=secret',
      'https://hs.test/base#secret',
    ]) {
      await expectLater(
        store.markPending(
          userId: '@a:hs',
          homeserver: Uri.parse(uri),
          deviceId: 'device-A',
        ),
        throwsArgumentError,
      );
    }
    expect((await store.list()), isEmpty);
    expect(
      (await SharedPreferences.getInstance()).getString(
        MatrixPendingDeletionStore.key,
      ),
      isNull,
    );
  });

  test('rejects unsafe stored URI without modifying its raw journal', () async {
    final preferences = await SharedPreferences.getInstance();
    for (final uri in [
      'https://name:secret@hs.test/base',
      'https://hs.test/base?access_token=secret',
      'https://hs.test/base#secret',
    ]) {
      final raw = jsonEncode({
        'version': 1,
        'entries': [
          {'userId': '@a:hs', 'homeserver': uri, 'deviceId': 'device-A'},
        ],
      });
      await preferences.setString(MatrixPendingDeletionStore.key, raw);
      await expectLater(
        MatrixPendingDeletionStore().list(),
        throwsFormatException,
      );
      expect(preferences.getString(MatrixPendingDeletionStore.key), raw);
    }
  });

  test('legitimate homeserver base path survives round trip', () async {
    final pathServer = Uri.parse('https://hs.test/matrix/base');
    final store = MatrixPendingDeletionStore();
    await store.markPending(
      userId: '@a:hs',
      homeserver: pathServer,
      deviceId: 'device-A',
    );
    expect(
      (await MatrixPendingDeletionStore().list()).single.homeserver,
      pathServer,
    );
  });
}
