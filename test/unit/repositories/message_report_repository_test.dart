import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_message_datasource.dart';
import 'package:n42_chat/src/data/repositories/message_repository_impl.dart';

class _Messages extends Mock implements MatrixMessageDataSource {}

class _Manager extends Mock implements MatrixClientManager {}

class _Preferences extends Mock implements PreferencesDataSource {}

class _Client extends Mock implements matrix.Client {}

class _Room extends Mock implements matrix.Room {}

void main() {
  const roomId = '!actual:hs.test';
  const eventId = r'$actual-event';
  const reason = 'Spam';
  late _Manager manager;
  late _Client a;
  late _Room room;
  late MessageRepositoryImpl repository;
  late matrix.Client? current;
  late String token;

  setUp(() {
    manager = _Manager();
    a = _Client();
    room = _Room();
    current = a;
    token = 'token-A';
    when(() => manager.client).thenAnswer((_) => current);
    when(() => a.userID).thenReturn('@a:hs.test');
    when(() => a.homeserver).thenReturn(Uri.parse('https://hs.test'));
    when(() => a.accessToken).thenAnswer((_) => token);
    when(() => a.deviceID).thenReturn(null);
    when(() => a.getRoomById(roomId)).thenReturn(room);
    repository = MessageRepositoryImpl(_Messages(), manager, _Preferences());
  });

  test(
    'sends exact room, event and reason without message plaintext',
    () async {
      when(
        () => a.reportEvent(roomId, eventId, reason: reason),
      ).thenAnswer((_) async {});
      await repository.reportMessage(roomId, eventId, reason: reason);
      verify(() => a.reportEvent(roomId, eventId, reason: reason)).called(1);
    },
  );

  test('missing client rejects without sending', () async {
    current = null;
    await expectLater(
      repository.reportMessage(roomId, eventId, reason: reason),
      throwsA(isA<Exception>()),
    );
    verifyNever(() => a.reportEvent(roomId, eventId, reason: reason));
  });

  test('missing room rejects without sending', () async {
    when(() => a.getRoomById(roomId)).thenReturn(null);
    await expectLater(
      repository.reportMessage(roomId, eventId, reason: reason),
      throwsA(isA<Exception>()),
    );
    verifyNever(() => a.reportEvent(roomId, eventId, reason: reason));
  });

  test('same-account transport failure is preserved', () async {
    final failure = StateError('Transport failed');
    when(
      () => a.reportEvent(roomId, eventId, reason: reason),
    ).thenThrow(failure);
    await expectLater(
      repository.reportMessage(roomId, eventId, reason: reason),
      throwsA(same(failure)),
    );
  });

  test('late A acknowledgement cannot be accepted for B', () async {
    final pending = Completer<void>();
    when(
      () => a.reportEvent(roomId, eventId, reason: reason),
    ).thenAnswer((_) => pending.future);
    final result = repository.reportMessage(roomId, eventId, reason: reason);
    final b = _Client();
    current = b;
    final check = expectLater(result, throwsStateError);
    pending.complete();
    await check;
    verifyNever(() => b.reportEvent(roomId, eventId, reason: reason));
  });

  test(
    'late A transport failure after a token change is account stale',
    () async {
      final pending = Completer<void>();
      when(() => a.reportEvent(roomId, eventId, reason: reason)).thenAnswer((
        _,
      ) async {
        await pending.future;
        throw StateError('Transport failed');
      });
      final result = repository.reportMessage(roomId, eventId, reason: reason);
      token = 'token-B';
      final check = expectLater(
        result,
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            contains('Account changed'),
          ),
        ),
      );
      pending.complete();
      await check;
    },
  );
}
