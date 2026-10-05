import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/message_archive_service.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';

class _ClientManager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Room extends Mock implements matrix.Room {}

class _Timeline extends Mock implements matrix.Timeline {}

ArchivedMessagesCompanion _entry({
  required String eventId,
  required String roomId,
  required int timestamp,
  required String body,
}) => ArchivedMessagesCompanion.insert(
  eventId: eventId,
  roomId: roomId,
  senderId: '@alice:hs.test',
  originServerTs: timestamp,
  type: 'm.room.message',
  body: Value(body),
  msgtype: const Value('m.text'),
  quarter: 202601,
  archivedAt: DateTime.utc(2026),
);

void main() {
  late ArchiveDatabase database;
  late MessageArchiveService service;

  setUp(() {
    database = ArchiveDatabase.forTesting(NativeDatabase.memory());
    service = MessageArchiveService(
      db: database,
      clientManager: _ClientManager(),
    );
  });

  tearDown(() => database.close());

  test('imports archive entries once and reports room history', () async {
    final entries = [
      _entry(
        eventId: r'$old',
        roomId: '!room:hs.test',
        timestamp: DateTime.utc(2026, 1, 2).millisecondsSinceEpoch,
        body: 'First message',
      ),
      _entry(
        eventId: r'$new',
        roomId: '!room:hs.test',
        timestamp: DateTime.utc(2026, 2, 2).millisecondsSinceEpoch,
        body: 'Second message',
      ),
    ];

    expect(await service.importArchivedMessages('!room:hs.test', entries), 2);
    expect(await service.importArchivedMessages('!room:hs.test', entries), 0);
    expect(await service.isEventArchived(r'$new'), isTrue);
    expect(await service.getArchivedRoomIds(), ['!room:hs.test']);
    expect(await service.getQuarterlyStats('!room:hs.test'), {202601: 2});

    final messages = await service.getArchivedMessages(
      '!room:hs.test',
      limit: 1,
    );
    expect(messages.map((message) => message.eventId), [r'$new']);

    final roomStatus = await service.getArchiveStatus('!room:hs.test');
    expect(roomStatus.totalArchived, 2);
    expect(roomStatus.lastArchivedEventId, r'$new');
    expect(roomStatus.lastArchiveTime, isNotNull);
    final total = await service.getTotalStats();
    expect(total.totalMessages, 2);
    expect(total.totalRooms, 1);
  });

  test(
    'deleting an archived message also removes its searchable text',
    () async {
      await service.importArchivedMessages('!room:hs.test', [
        _entry(
          eventId: r'$redacted',
          roomId: '!room:hs.test',
          timestamp: DateTime.utc(2026, 1, 2).millisecondsSinceEpoch,
          body: 'private redacted phrase',
        ),
      ]);

      expect(
        (await database.searchMessages(
          'redacted',
        )).map((message) => message.eventId),
        [r'$redacted'],
      );

      await service.deleteArchivedMessage(r'$redacted');

      expect(await service.isEventArchived(r'$redacted'), isFalse);
      expect(await database.searchMessages('redacted'), isEmpty);
    },
  );

  test('empty archive import does not create metadata', () async {
    expect(await service.importArchivedMessages('!empty:hs.test', []), 0);
    expect(await database.getMetadata('!empty:hs.test'), isNull);
    expect(await service.getArchivedRoomIds(), isEmpty);
  });

  test(
    'archives chat text and skips ephemeral, edited, and locked events',
    () async {
      final manager = _ClientManager();
      final client = _Client();
      final room = _Room();
      final timeline = _Timeline();
      when(() => manager.client).thenReturn(client);
      when(() => client.getRoomById('!room:hs.test')).thenReturn(room);
      when(() => room.getTimeline()).thenAnswer((_) async => timeline);
      when(() => room.id).thenReturn('!room:hs.test');
      final ordinary = matrix.Event(
        type: matrix.EventTypes.Message,
        content: {'body': 'ordinary searchable message'},
        senderId: '@alice:hs.test',
        eventId: r'$ordinary',
        room: room,
        originServerTs: DateTime.utc(2026, 1, 1),
      );
      final events = [
        ordinary,
        matrix.Event(
          type: matrix.EventTypes.Message,
          content: {'body': 'ephemeral text', 'n42.self_destruct': 30},
          senderId: '@alice:hs.test',
          eventId: r'$ephemeral',
          room: room,
          originServerTs: DateTime.utc(2026, 1, 2),
        ),
        matrix.Event(
          type: matrix.EventTypes.Message,
          content: {
            'body': 'edited replacement',
            'm.relates_to': {'rel_type': 'm.replace'},
          },
          senderId: '@alice:hs.test',
          eventId: r'$edit',
          room: room,
          originServerTs: DateTime.utc(2026, 1, 3),
        ),
        matrix.Event(
          type: matrix.EventTypes.Encrypted,
          content: {'algorithm': 'm.megolm.v1.aes-sha2'},
          senderId: '@alice:hs.test',
          eventId: r'$locked',
          room: room,
          originServerTs: DateTime.utc(2026, 1, 4),
        ),
      ];
      when(() => timeline.events).thenReturn(events);
      when(
        () => timeline.requestHistory(historyCount: any(named: 'historyCount')),
      ).thenAnswer((_) async {});
      service = MessageArchiveService(db: database, clientManager: manager);

      final result = await service.archiveRoom('!room:hs.test', batchSize: 10);

      expect(result.archivedCount, 1);
      expect(result.skippedCount, 0);
      expect(await service.isEventArchived(r'$ordinary'), isTrue);
      expect(await service.isEventArchived(r'$ephemeral'), isFalse);
      expect(await service.isEventArchived(r'$edit'), isFalse);
      expect(await service.isEventArchived(r'$locked'), isFalse);
      verify(() => timeline.cancelSubscriptions()).called(1);
    },
  );
}
