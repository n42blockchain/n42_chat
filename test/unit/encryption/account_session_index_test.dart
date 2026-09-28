import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';
import 'package:n42_chat/src/core/encryption/account_session_index.dart';

class _PausingStore extends InMemorySharedPreferencesStore {
  _PausingStore(super.data) : super.withData();

  final entered = Completer<void>();
  final release = Completer<void>();
  bool pauseNextWrite = true;

  @override
  Future<bool> setValue(String valueType, String key, Object value) async {
    if (pauseNextWrite && key.endsWith('n42_chat_account_session_index_v1')) {
      pauseNextWrite = false;
      entered.complete();
      await release.future;
    }
    return super.setValue(valueType, key, value);
  }
}

void main() {
  late AccountSessionIndex index;
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    index = AccountSessionIndex();
  });

  test(
    'legacy session is registered without moving or replacing its database',
    () async {
      expect(await index.activeDatabaseName(), 'N42Chat');
      await index.remember(
        Uri.parse('https://hs.test'),
        '@a:hs',
        'A',
        'N42Chat',
      );
      expect(
        await index.lookup(Uri.parse('https://hs.test/'), '@a:hs', 'A'),
        'N42Chat',
      );
      expect(
        await index.lookup(Uri.parse('https://other.test'), '@a:hs', 'A'),
        isNull,
      );
      expect(
        await index.lookup(Uri.parse('https://hs.test'), '@b:hs', 'A'),
        isNull,
      );
      expect(
        await index.lookup(Uri.parse('https://hs.test'), '@a:hs', 'B'),
        isNull,
      );
    },
  );

  test(
    'account databases survive switching and reconstructing the index',
    () async {
      final server = Uri.parse('https://hs.test');
      final a = index.newDatabaseName();
      final b = index.newDatabaseName();
      expect(a, isNot(b));
      await index.remember(server, '@a:hs', 'A', a);
      await index.remember(server, '@b:hs', 'B', b);
      final reopened = AccountSessionIndex();
      expect(await reopened.activeDatabaseName(), b);
      expect(await reopened.lookup(server, '@a:hs', 'A'), a);
      await reopened.remember(server, '@a:hs', 'A', a);
      expect(await reopened.activeDatabaseName(), a);
      await reopened.forget(server, '@a:hs', 'A');
      expect(await reopened.lookup(server, '@a:hs', 'A'), isNull);
      expect(await reopened.lookup(server, '@b:hs', 'B'), b);
    },
  );

  test(
    'cannot map a second account or device onto an owned SDK database',
    () async {
      final server = Uri.parse('https://hs.test');
      await index.remember(server, '@a:hs', 'A', 'N42Chat');
      await expectLater(
        index.remember(server, '@b:hs', 'B', 'N42Chat'),
        throwsStateError,
      );
      expect(await index.lookup(server, '@b:hs', 'B'), isNull);
      await expectLater(
        index.remember(server, '@a:hs', 'NEW', 'N42Chat'),
        throwsStateError,
      );
    },
  );

  test('rejects database paths outside the managed directory', () async {
    await expectLater(
      index.remember(Uri.parse('https://hs.test'), '@a:hs', 'A', '../other'),
      throwsArgumentError,
    );
  });

  test('concurrent A forget and B remember retain only B mapping', () async {
    final server = Uri.parse('https://hs.test');
    await index.remember(server, '@a:hs', 'A', 'N42Chat_A');
    await Future.wait([
      index.forget(server, '@a:hs', 'A'),
      AccountSessionIndex().remember(server, '@b:hs', 'B', 'N42Chat_B'),
    ]);
    expect(await index.lookup(server, '@a:hs', 'A'), isNull);
    expect(await index.lookup(server, '@b:hs', 'B'), 'N42Chat_B');
  });

  test('old A cannot forget a newer same-device database mapping', () async {
    final server = Uri.parse('https://hs.test');
    await index.remember(server, '@a:hs', 'A', 'N42Chat_oldA');
    await index.remember(server, '@a:hs', 'A', 'N42Chat_newA');
    await index.forget(
      server,
      '@a:hs',
      'A',
      expectedDatabaseName: 'N42Chat_oldA',
    );
    expect(await index.lookup(server, '@a:hs', 'A'), 'N42Chat_newA');
  });

  test('new A mapping saved during old forget remains mapped', () async {
    final server = Uri.parse('https://hs.test');
    await index.remember(server, '@a:hs', 'A', 'N42Chat_oldA');
    final platform = _PausingStore(
      await SharedPreferencesStorePlatform.instance.getAll(),
    );
    SharedPreferencesStorePlatform.instance = platform;

    final oldForget = index.forget(
      server,
      '@a:hs',
      'A',
      expectedDatabaseName: 'N42Chat_oldA',
      canForget: () => true,
    );
    await platform.entered.future;
    final newSave = AccountSessionIndex().remember(
      server,
      '@a:hs',
      'A',
      'N42Chat_newA',
    );
    platform.release.complete();
    await Future.wait([oldForget, newSave]);
    expect(await index.lookup(server, '@a:hs', 'A'), 'N42Chat_newA');
  });
}
