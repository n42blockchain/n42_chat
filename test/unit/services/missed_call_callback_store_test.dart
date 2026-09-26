import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/services/voip/missed_call_callback_store.dart';

class _Storage extends Mock implements FlutterSecureStorage {}

void main() {
  late _Storage storage;
  late String? value;
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
    value = null;
    account = '@me:hs';
    now = DateTime.utc(2026, 9, 26);
    when(
      () => storage.read(key: any(named: 'key')),
    ).thenAnswer((_) async => value);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((i) async {
      value = i.namedArguments[#value] as String?;
    });
    store = MissedCallCallbackStore(
      storage: storage,
      currentAccountId: () => account,
      now: () => now,
    );
  });
  test('recreated store restores minimal routing and consumes once', () async {
    expect(await store.remember(route), isTrue);
    final records = jsonDecode(value!) as List;
    expect((records.single as Map).keys.toSet(), {
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
    when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async {
      account = '@other:hs';
      return value;
    });
    expect(await store.consume('call'), isNull);
  });
  test('expiry and capacity evict stale routes', () async {
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
    expect((jsonDecode(value!) as List), hasLength(64));
    expect(await store.consume('0'), isNull);
    expect((await store.consume('64'))?.callId, '64');
  });
  test('read and consume-write errors never return a route', () async {
    await store.remember(route);
    when(
      () => storage.read(key: any(named: 'key')),
    ).thenThrow(StateError('locked'));
    expect(await store.consume('call'), isNull);
    when(
      () => storage.read(key: any(named: 'key')),
    ).thenAnswer((_) async => value);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenThrow(StateError('locked'));
    expect(await store.consume('call'), isNull);
  });
  test('missing account and malformed storage fail closed', () async {
    account = null;
    expect(await store.remember(route), isFalse);
    expect(await store.consume('call'), isNull);
    account = '@me:hs';
    value = '{broken';
    expect(await store.consume('call'), isNull);
  });
}
