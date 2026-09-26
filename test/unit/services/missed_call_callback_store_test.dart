import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/notifications/push_recipient_binding_store.dart';
import 'package:n42_chat/src/services/voip/missed_call_callback_store.dart';

class _Storage extends Mock implements FlutterSecureStorage {}

void main() {
  late _Storage storage;
  late Map<String, String> values;
  late String? account;
  late DateTime now;
  late MissedCallCallbackStore store;
  const route = MissedCallRoute(
    callId: 'call',
    roomId: '!room:hs',
    callerId: '@alice:hs',
    isVideo: false,
  );

  setUp(() {
    storage = _Storage();
    values = {};
    account = '@me:hs';
    now = DateTime.utc(2026, 9, 26);
    when(
      () => storage.read(key: any(named: 'key')),
    ).thenAnswer((i) async => values[i.namedArguments[#key] as String]);
    when(() => storage.readAll()).thenAnswer((_) async => Map.of(values));
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((i) async {
      values.remove(i.namedArguments[#key] as String);
    });
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((i) async {
      values[i.namedArguments[#key] as String] =
          i.namedArguments[#value] as String;
    });
    store = MissedCallCallbackStore(
      storage: storage,
      bindingStore: PushRecipientBindingStore(storage: storage, now: () => now),
      currentAccountId: () => account,
      now: () => now,
    );
  });

  test('recreated store restores minimal routing and consumes once', () async {
    expect(await store.remember(route), isTrue);
    final record = jsonDecode(values.values.single) as Map;
    expect(record.keys.toSet(), {
      'accountId',
      'callId',
      'roomId',
      'callerId',
      'isVideo',
      'expiresAt',
    });
    final restored = MissedCallCallbackStore(
      storage: storage,
      currentAccountId: () => account,
      now: () => now,
    );
    expect((await restored.consume('call'))?.roomId, '!room:hs');
    expect(await restored.consume('call'), isNull);
  });

  test(
    'another account cannot consume the original account callback',
    () async {
      await store.remember(route);
      account = '@other:hs';
      expect(await store.consume('call'), isNull);
      account = '@me:hs';
      expect((await store.consume('call'))?.callerId, '@alice:hs');
    },
  );

  test('account change during storage access fails closed', () async {
    await store.remember(route);
    when(() => storage.read(key: any(named: 'key'))).thenAnswer((i) async {
      account = '@other:hs';
      return values[i.namedArguments[#key] as String];
    });
    expect(await store.consume('call'), isNull);
  });

  test('expiry and capacity evict stale routes for this account', () async {
    await store.remember(route);
    now = now.add(const Duration(hours: 24));
    expect(await store.consume('call'), isNull);
    for (var i = 0; i < 65; i++) {
      await store.remember(
        MissedCallRoute(
          callId: '$i',
          roomId: '!room:hs',
          callerId: '@alice:hs',
          isVideo: false,
        ),
      );
    }
    expect(values, hasLength(64));
    expect(await store.consume('0'), isNull);
    expect((await store.consume('64'))?.callId, '64');
  });

  test('read and consume-delete errors never return a route', () async {
    await store.remember(route);
    when(
      () => storage.read(key: any(named: 'key')),
    ).thenThrow(StateError('locked'));
    expect(await store.consume('call'), isNull);
    when(
      () => storage.read(key: any(named: 'key')),
    ).thenAnswer((i) async => values[i.namedArguments[#key] as String]);
    when(
      () => storage.delete(key: any(named: 'key')),
    ).thenThrow(StateError('locked'));
    expect(await store.consume('call'), isNull);
  });

  test('missing account and malformed record fail closed', () async {
    account = null;
    expect(await store.remember(route), isFalse);
    expect(await store.consume('call'), isNull);
    account = '@me:hs';
    await store.remember(route);
    final key = values.keys.single;
    values[key] = '{broken';
    expect(await store.consume('call'), isNull);
  });

  test('two isolated writers retain different call records', () async {
    final bothRead = Completer<void>();
    var reads = 0;
    when(() => storage.readAll()).thenAnswer((_) async {
      reads++;
      final snapshot = Map<String, String>.of(values);
      if (reads == 2) bothRead.complete();
      await bothRead.future;
      return snapshot;
    });
    final other = MissedCallCallbackStore(
      storage: storage,
      currentAccountId: () => account,
      now: () => now,
    );
    final outcomes = await Future.wait([
      store.remember(route),
      other.remember(
        const MissedCallRoute(
          callId: 'other',
          roomId: '!other:hs',
          callerId: '@bob:hs',
          isVideo: true,
        ),
      ),
    ]);
    expect(outcomes, [isTrue, isTrue]);
    expect((await store.consume('call'))?.roomId, '!room:hs');
    expect((await other.consume('other'))?.roomId, '!other:hs');
  });

  test('bound route rejects wrong, replaced and expired generation', () async {
    final bindings = PushRecipientBindingStore(
      storage: storage,
      now: () => now,
    );
    expect(
      await store.rememberBound(route, accountId: '@me:hs', bindingId: 'gen'),
      isFalse,
    );
    await bindings.activate('@me:hs', 'gen');
    expect(
      await store.rememberBound(route, accountId: '@me:hs', bindingId: 'gen'),
      isTrue,
    );
    account = '@other:hs';
    expect(await store.consume('call'), isNull);
    account = '@me:hs';
    await bindings.activate('@me:hs', 'replacement');
    expect(await store.consume('call'), isNull);
    await bindings.activate('@me:hs', 'gen');
    now = now.add(const Duration(hours: 24));
    expect(await store.consume('call'), isNull);
  });

  test('background accept lookup requires a live retained route', () async {
    final bindings = PushRecipientBindingStore(
      storage: storage,
      now: () => now,
    );
    await bindings.activate('@me:hs', 'gen');
    expect(
      await store.lookupBound('call', accountId: '@me:hs', bindingId: 'gen'),
      isNull,
    );
    await store.rememberBound(route, accountId: '@me:hs', bindingId: 'gen');
    expect(
      (await store.lookupBound(
        'call',
        accountId: '@me:hs',
        bindingId: 'gen',
      ))?.roomId,
      '!room:hs',
    );
    now = now.add(const Duration(hours: 24));
    expect(
      await store.lookupBound('call', accountId: '@me:hs', bindingId: 'gen'),
      isNull,
    );
  });

  test('one account cleanup cannot remove another account new route', () async {
    await store.remember(route);
    account = '@other:hs';
    await store.remember(
      const MissedCallRoute(
        callId: 'new',
        roomId: '!other:hs',
        callerId: '@bob:hs',
        isVideo: false,
      ),
    );
    account = '@me:hs';
    for (var i = 0; i < 65; i++) {
      await store.remember(
        MissedCallRoute(
          callId: '$i',
          roomId: '!room:hs',
          callerId: '@alice:hs',
          isVideo: false,
        ),
      );
    }
    account = '@other:hs';
    expect((await store.consume('new'))?.roomId, '!other:hs');
  });
}
