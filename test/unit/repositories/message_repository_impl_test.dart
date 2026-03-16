// Tests for MessageRepositoryImpl — send, redact, and message retrieval.

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_message_datasource.dart';
import 'package:n42_chat/src/data/repositories/message_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';

class MockMatrixMessageDataSource extends Mock
    implements MatrixMessageDataSource {}

class MockMatrixClientManager extends Mock implements MatrixClientManager {}

class MockPreferencesDataSource extends Mock implements PreferencesDataSource {}

class MockClient extends Mock implements matrix.Client {}

class MockRoom extends Mock implements matrix.Room {}

class MockTimeline extends Mock implements matrix.Timeline {}

class MockEvent extends Mock implements matrix.Event {}

void main() {
  late MessageRepositoryImpl repository;
  late MockMatrixMessageDataSource mockMsgDS;
  late MockMatrixClientManager mockClientMgr;
  late MockPreferencesDataSource mockStorageDS;
  late MockClient mockClient;
  late MockRoom mockRoom;
  late MockTimeline mockTimeline;
  late MockEvent mockEvent;

  const testRoomId = '!room1:matrix.org';
  const testEventId = '\$event1';
  const testText = 'Hello, World!';

  setUp(() {
    mockMsgDS = MockMatrixMessageDataSource();
    mockClientMgr = MockMatrixClientManager();
    mockStorageDS = MockPreferencesDataSource();
    mockClient = MockClient();
    mockRoom = MockRoom();
    mockTimeline = MockTimeline();
    mockEvent = MockEvent();
    repository = MessageRepositoryImpl(mockMsgDS, mockClientMgr, mockStorageDS);

    when(() => mockClientMgr.client).thenReturn(mockClient);
    when(() => mockClient.getRoomById(any())).thenReturn(mockRoom);
    when(() => mockRoom.getTimeline()).thenAnswer((_) async => mockTimeline);
    when(() => mockRoom.getEventById(any())).thenAnswer((_) async => null);
    when(() => mockTimeline.events).thenReturn(<matrix.Event>[]);
    when(
      () =>
          mockTimeline.requestHistory(historyCount: any(named: 'historyCount')),
    ).thenAnswer((_) async {});
    when(
      () => mockStorageDS.getLocallyDeletedMessageIds(any()),
    ).thenAnswer((_) async => {});
  });

  group('sendTextMessage', () {
    test('delegates to datasource', () async {
      when(
        () => mockMsgDS.sendTextMessage(testRoomId, testText),
      ).thenAnswer((_) async => testEventId);
      when(
        () => mockMsgDS.getMessageById(testRoomId, testEventId),
      ).thenAnswer((_) async => null);
      when(
        () => mockStorageDS.getLocallyDeletedMessageIds(testRoomId),
      ).thenAnswer((_) async => {});

      // sendTextMessage tries to get the message after sending; if the event
      // hasn't synced yet it falls back. We test the delegation path here.
      await repository.sendTextMessage(testRoomId, testText);

      verify(() => mockMsgDS.sendTextMessage(testRoomId, testText)).called(1);
      // Result may be null if event hasn't synced yet — that's acceptable
    });

    test('returns null when send fails', () async {
      when(
        () => mockMsgDS.sendTextMessage(testRoomId, testText),
      ).thenAnswer((_) async => null);

      final result = await repository.sendTextMessage(testRoomId, testText);

      expect(result, isNull);
    });
  });

  group('replyToMessage', () {
    test('delegates reply metadata to datasource', () async {
      when(
        () => mockMsgDS.replyToMessage(
          testRoomId,
          testEventId,
          testText,
          selfDestructAfter: 15,
          mentionedUserIds: ['@bob:matrix.org'],
          mentionsRoom: true,
        ),
      ).thenAnswer((_) async => '\$reply-event');
      when(
        () => mockRoom.getEventById('\$reply-event'),
      ).thenAnswer((_) async => null);

      await repository.replyToMessage(
        testRoomId,
        testEventId,
        testText,
        selfDestructAfter: 15,
        mentionedUserIds: ['@bob:matrix.org'],
        mentionsRoom: true,
      );

      verify(
        () => mockMsgDS.replyToMessage(
          testRoomId,
          testEventId,
          testText,
          selfDestructAfter: 15,
          mentionedUserIds: ['@bob:matrix.org'],
          mentionsRoom: true,
        ),
      ).called(1);
    });
  });

  group('redactMessage', () {
    test('delegates to datasource and returns success', () async {
      when(
        () => mockMsgDS.redactMessage(testRoomId, testEventId),
      ).thenAnswer((_) async => true);

      final result = await repository.redactMessage(testRoomId, testEventId);

      expect(result, isTrue);
      verify(() => mockMsgDS.redactMessage(testRoomId, testEventId)).called(1);
    });

    test('returns false on failure', () async {
      when(
        () => mockMsgDS.redactMessage(testRoomId, testEventId),
      ).thenAnswer((_) async => false);

      final result = await repository.redactMessage(testRoomId, testEventId);

      expect(result, isFalse);
    });
  });

  group('deleteFailedMessage', () {
    test('delegates correctly', () async {
      when(
        () => mockMsgDS.deleteFailedMessage(testRoomId, testEventId),
      ).thenAnswer((_) async => true);

      final result = await repository.deleteFailedMessage(
        testRoomId,
        testEventId,
      );

      expect(result, isTrue);
    });
  });

  group('watchMessage', () {
    test(
      'emits initial message immediately when timeline already contains event',
      () async {
        final mappedMessage = MessageEntity(
          id: testEventId,
          roomId: testRoomId,
          senderId: '@alice:matrix.org',
          senderName: 'Alice',
          content: 'hello',
          timestamp: DateTime(2026, 1, 1),
          type: MessageType.text,
          status: MessageStatus.sent,
        );

        when(() => mockEvent.eventId).thenReturn(testEventId);
        when(() => mockTimeline.events).thenReturn(<matrix.Event>[mockEvent]);
        when(
          () => mockMsgDS.mapEventToMessage(mockEvent, mockRoom),
        ).thenReturn(mappedMessage);

        final result = await repository
            .watchMessage(testRoomId, testEventId)
            .first;

        expect(result, isNotNull);
        expect(result!.id, testEventId);
        verify(
          () => mockMsgDS.mapEventToMessage(mockEvent, mockRoom),
        ).called(1);
      },
    );
  });
}
