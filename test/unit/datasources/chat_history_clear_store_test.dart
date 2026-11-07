import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/chat_history_clear_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Preferences extends Mock implements SharedPreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final boundary = DateTime.utc(2026, 11, 6, 12);
  const owner = '@alice:example.test';
  const room = '!room:example.test';
  bool current() => true;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('rejected platform writes emit no clear notification', () async {
    final preferences = _Preferences();
    when(() => preferences.reload()).thenAnswer((_) async {});
    when(() => preferences.getString(any())).thenReturn(null);
    when(() => preferences.setString(any(), any()))
        .thenAnswer((_) async => false);
    final store = ChatHistoryClearStore(preferences: () async => preferences);
    var changes = 0;
    final subscription = store
        .watch(ownerUserId: owner, roomId: room)
        .listen((_) => changes++);
    await expectLater(
      store.clearThrough(
        ownerUserId: owner,
        roomId: room,
        boundary: boundary,
        isCurrent: current,
      ),
      throwsA(isA<StateError>()),
    );
    await pumpEventQueue();
    expect(changes, 0);
    await subscription.cancel();
  });

  test('survives recreated store and isolates owner and room', () async {
    final store = ChatHistoryClearStore();
    await store.clearThrough(
      ownerUserId: owner,
      roomId: room,
      boundary: boundary,
      isCurrent: current,
    );
    final reopened = ChatHistoryClearStore();
    expect(
      await reopened.read(ownerUserId: owner, roomId: room, isCurrent: current),
      boundary,
    );
    expect(
      await reopened.read(
        ownerUserId: '@bob:example.test',
        roomId: room,
        isCurrent: current,
      ),
      isNull,
    );
    expect(
      await reopened.read(
        ownerUserId: owner,
        roomId: '!other:example.test',
        isCurrent: current,
      ),
      isNull,
    );
  });

  test('concurrent stores never move the boundary backwards', () async {
    await Future.wait(
      List.generate(
        20,
        (index) => ChatHistoryClearStore().clearThrough(
          ownerUserId: owner,
          roomId: room,
          boundary: boundary.add(Duration(seconds: 20 - index)),
          isCurrent: current,
        ),
      ),
    );
    expect(
      await ChatHistoryClearStore().read(
        ownerUserId: owner,
        roomId: room,
        isCurrent: current,
      ),
      boundary.add(const Duration(seconds: 20)),
    );
  });

  test('corrupt records fail closed without overwriting bytes', () async {
    final store = ChatHistoryClearStore();
    await store.clearThrough(
      ownerUserId: owner,
      roomId: room,
      boundary: boundary,
      isCurrent: current,
    );
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.getKeys().single;
    await prefs.setString(key, '{broken');
    await expectLater(
      store.read(ownerUserId: owner, roomId: room, isCurrent: current),
      throwsFormatException,
    );
    await expectLater(
      store.clearThrough(
        ownerUserId: owner,
        roomId: room,
        boundary: boundary,
        isCurrent: current,
      ),
      throwsFormatException,
    );
    expect(prefs.getString(key), '{broken');
  });

  test('rejected write is reported and queue remains usable', () async {
    final prefs = _Preferences();
    when(() => prefs.reload()).thenAnswer((_) async {});
    when(() => prefs.getString(any())).thenReturn(null);
    when(() => prefs.setString(any(), any())).thenAnswer((_) async => false);
    final store = ChatHistoryClearStore(preferences: () async => prefs);
    await expectLater(
      store.clearThrough(
        ownerUserId: owner,
        roomId: room,
        boundary: boundary,
        isCurrent: current,
      ),
      throwsStateError,
    );
    when(() => prefs.setString(any(), any())).thenAnswer((_) async => true);
    expect(
      await store.clearThrough(
        ownerUserId: owner,
        roomId: room,
        boundary: boundary,
        isCurrent: current,
      ),
      boundary,
    );
  });

  test('session changes during preference loading prevent writes', () async {
    final prefs = _Preferences();
    when(() => prefs.reload()).thenAnswer((_) async {});
    final loading = Completer<SharedPreferences>();
    final store = ChatHistoryClearStore(preferences: () => loading.future);
    var active = true;
    final result = store.clearThrough(
      ownerUserId: owner,
      roomId: room,
      boundary: boundary,
      isCurrent: () => active,
    );
    await Future<void>.delayed(Duration.zero);
    active = false;
    loading.complete(prefs);
    await expectLater(result, throwsStateError);
    verifyNever(() => prefs.setString(any(), any()));
  });

  test(
    'session changes during write cannot report success to new owner',
    () async {
      final prefs = _Preferences();
      when(() => prefs.reload()).thenAnswer((_) async {});
      when(() => prefs.getString(any())).thenReturn(null);
      final writing = Completer<bool>();
      final started = Completer<void>();
      when(() => prefs.setString(any(), any())).thenAnswer((_) {
        started.complete();
        return writing.future;
      });
      var active = true;
      final result = ChatHistoryClearStore(preferences: () async => prefs)
          .clearThrough(
            ownerUserId: owner,
            roomId: room,
            boundary: boundary,
            isCurrent: () => active,
          );
      await started.future;
      active = false;
      writing.complete(true);
      await expectLater(result, throwsStateError);
      verify(() => prefs.setString(any(), any())).called(1);
    },
  );
}
