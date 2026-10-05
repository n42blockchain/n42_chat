import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/notifications/push_recipient_binding_store.dart';

class _Storage extends Mock implements FlutterSecureStorage {}

void main() {
  late _Storage storage;
  late Map<String, String> values;
  late DateTime now;
  late PushRecipientBindingStore bindings;

  setUp(() {
    storage = _Storage();
    values = {};
    now = DateTime.utc(2026, 9, 26);
    when(
      () => storage.read(key: any(named: 'key')),
    ).thenAnswer((call) async => values[call.namedArguments[#key] as String]);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((call) async {
      values[call.namedArguments[#key] as String] =
          call.namedArguments[#value] as String;
    });
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((call) async {
      values.remove(call.namedArguments[#key] as String);
    });
    bindings = PushRecipientBindingStore(storage: storage, now: () => now);
  });

  test(
    'only the exact account and generation matches after recreation',
    () async {
      expect(await bindings.activate('@a:hs', 'generation-a'), isTrue);
      final restored = PushRecipientBindingStore(
        storage: storage,
        now: () => now,
      );
      expect(await restored.matches('@a:hs', 'generation-a'), isTrue);
      expect(await restored.matches('@b:hs', 'generation-a'), isFalse);
      expect(await restored.matches('@a:hs', 'generation-b'), isFalse);
      expect(await restored.matches('', 'generation-a'), isFalse);
      expect(await restored.matches('@a:hs', ''), isFalse);
    },
  );

  test('replacement, expiry and storage errors fail closed', () async {
    await bindings.activate('@a:hs', 'old');
    await bindings.activate('@a:hs', 'new');
    expect(await bindings.matches('@a:hs', 'old'), isFalse);
    now = now.add(const Duration(days: 31));
    expect(await bindings.matches('@a:hs', 'new'), isFalse);
    when(
      () => storage.read(key: any(named: 'key')),
    ).thenThrow(StateError('locked'));
    expect(await bindings.matches('@a:hs', 'new'), isFalse);
  });

  test('revoking one account leaves another account binding intact', () async {
    await bindings.activate('@a:hs', 'generation-a');
    await bindings.activate('@b:hs', 'generation-b');
    expect(await bindings.revokeAccount('@a:hs'), isTrue);
    expect(await bindings.matches('@a:hs', 'generation-a'), isFalse);
    expect(await bindings.matches('@b:hs', 'generation-b'), isTrue);
  });

  test('a blocked write never exposes a binding before completion', () async {
    final gate = Completer<void>();
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((call) async {
      await gate.future;
      values[call.namedArguments[#key] as String] =
          call.namedArguments[#value] as String;
    });
    final activation = bindings.activate('@a:hs', 'generation-a');
    expect(await bindings.matches('@a:hs', 'generation-a'), isFalse);
    gate.complete();
    expect(await activation, isTrue);
  });
}
