import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/search_result_entity.dart';

ArchivedMessagesCompanion _message({
  required String id,
  required String room,
  required String sender,
  required int timestamp,
  required int quarter,
  required String body,
  String type = 'm.room.message',
  String? msgtype = 'm.text',
  bool encrypted = false,
}) => ArchivedMessagesCompanion.insert(
  eventId: id,
  roomId: room,
  senderId: sender,
  originServerTs: timestamp,
  type: type,
  body: Value(body),
  formattedBody: Value('<p>$body</p>'),
  msgtype: Value(msgtype),
  relatesTo: const Value('{"rel_type":"m.thread"}'),
  mediaInfo: const Value('{"mxcUrl":"mxc://hs.test/media"}'),
  isEncrypted: Value(encrypted),
  decryptedBody: encrypted ? Value(body) : const Value.absent(),
  quarter: quarter,
  archivedAt: DateTime.utc(2026, 3, 1),
);

void main() {
  late ArchiveDatabase database;

  setUp(() {
    database = ArchiveDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  test('inserts, queries, filters, and removes archived messages', () async {
    final firstTime = DateTime.utc(2026, 1, 2).millisecondsSinceEpoch;
    final secondTime = DateTime.utc(2026, 2, 2).millisecondsSinceEpoch;
    final thirdTime = DateTime.utc(2026, 4, 2).millisecondsSinceEpoch;
    final entries = [
      _message(
        id: r'$plain',
        room: '!room:hs.test',
        sender: '@alice:hs.test',
        timestamp: firstTime,
        quarter: 202601,
        body: 'needle from me',
      ),
      _message(
        id: r'$image',
        room: '!room:hs.test',
        sender: '@bob:hs.test',
        timestamp: secondTime,
        quarter: 202601,
        body: 'needle image',
        msgtype: 'm.image',
      ),
      _message(
        id: r'$encrypted',
        room: '!private:hs.test',
        sender: '@alice:hs.test',
        timestamp: thirdTime,
        quarter: 202602,
        body: 'needle secret',
        type: 'm.room.encrypted',
        msgtype: null,
        encrypted: true,
      ),
    ];

    expect(await database.insertMessages(entries), 3);
    expect(await database.insertMessages([entries.first]), 0);
    await database.updateMetadata(
      ArchiveMetadataCompanion.insert(
        roomId: '!room:hs.test',
        lastArchivedEventId: const Value(r'$image'),
        lastArchivedTs: Value(secondTime),
        totalArchived: const Value(2),
        lastArchiveTime: Value(DateTime.utc(2026, 3, 2)),
      ),
    );

    final page = await database.getMessages(
      '!room:hs.test',
      beforeTimestamp: thirdTime,
      limit: 1,
    );
    expect(page.single.eventId, r'$image');
    expect(page.single.formattedBody, '<p>needle image</p>');
    expect(page.single.relatesTo, '{"rel_type":"m.thread"}');
    expect(page.single.mediaInfo, '{"mxcUrl":"mxc://hs.test/media"}');
    expect(await database.getMetadata('!room:hs.test'), isNotNull);
    expect(await database.getMessageCount('!room:hs.test'), 2);
    expect(
      await database.getArchivedRoomIds(),
      unorderedEquals(['!room:hs.test', '!private:hs.test']),
    );
    expect(await database.getQuarterlyStats('!room:hs.test'), {202601: 2});
    expect(await database.isEventArchived(r'$encrypted'), isTrue);
    final stats = await database.getTotalStats();
    expect(stats.totalMessages, 3);
    expect(stats.totalRooms, 2);

    expect(
      (await database.searchMessages(
        'needle',
        roomId: '!room:hs.test',
      )).map((message) => message.eventId),
      [r'$image', r'$plain'],
    );
    expect(
      (await database.searchMessages(
        'needle',
        excludeRoomIds: {'!private:hs.test'},
      )).length,
      2,
    );
    expect(
      (await database.searchMessages(
        'needle',
        afterTimestamp: secondTime,
        beforeTimestamp: thirdTime,
      )).map((message) => message.eventId),
      [r'$encrypted', r'$image'],
    );
    expect(
      (await database.searchMessages(
        'needle',
        filter: const MessageSearchFilter(onlyFromMe: true),
        currentUserId: '@alice:hs.test',
      )).map((message) => message.eventId),
      [r'$encrypted', r'$plain'],
    );
    expect(
      (await database.searchMessages(
        'needle',
        filter: MessageSearchFilter(
          senderId: '@bob:hs.test',
          messageType: MessageType.image,
          sentAfter: DateTime.utc(2026, 2),
          hasMediaOnly: true,
        ),
      )).map((message) => message.eventId),
      [r'$image'],
    );
    expect(
      await database.searchMessages(
        'needle',
        filter: const MessageSearchFilter(onlyFromMe: true),
      ),
      isEmpty,
    );
    expect(await database.searchMessages('  '), isEmpty);
    expect(await database.searchCount('needle'), 3);
    expect(await database.searchCount('needle', roomId: '!room:hs.test'), 2);

    await database.deleteByEventId(r'$encrypted');
    expect(await database.isEventArchived(r'$encrypted'), isFalse);
    expect(await database.searchCount('secret'), 0);
    await database.rebuildFtsIndex();
    expect(await database.deleteQuarter(202601), 2);
    final emptyStats = await database.getTotalStats();
    expect(emptyStats.totalMessages, 0);
    expect(emptyStats.totalRooms, 0);
  });
}
