import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';

ArchivedMessagesCompanion entry(String id) => ArchivedMessagesCompanion.insert(
  eventId: id,
  roomId: 'room',
  senderId: 'sender',
  originServerTs: 1,
  type: 'm.room.message',
  body: const Value('secret payload'),
  quarter: 202601,
  archivedAt: DateTime.utc(2026),
);

void main() {
  late Directory dir;
  late File file;
  late ArchiveDatabase db;
  setUp(() async {
    dir = await Directory.systemTemp.createTemp('n42-redaction-test-');
    file = File('${dir.path}/archive.db');
    db = ArchiveDatabase.forTesting(NativeDatabase(file));
  });
  tearDown(() async {
    await db.close();
    await dir.delete(recursive: true);
  });
  test('marker survives reopen and blocks API and raw SQL insertion', () async {
    await db.insertMessages([entry('old'), entry('keep')]);
    await db.redactByEventId('old');
    await db.close();
    db = ArchiveDatabase.forTesting(NativeDatabase(file));
    expect(await db.insertMessages([entry('old')]), 0);
    await db.customStatement(
      "INSERT INTO archived_messages(event_id,room_id,sender_id,origin_server_ts,type,body,quarter,archived_at) VALUES('old','room','sender',1,'m.room.message','secret payload',202601,1)",
    );
    expect(await db.isEventArchived('old'), isFalse);
    expect((await db.searchMessages('secret')).map((row) => row.eventId), [
      'keep',
    ]);
  });
  test(
    'unloaded events are protected and repeated redactions are idempotent',
    () async {
      await db.redactByEventId('future');
      await db.redactByEventId('future');
      expect(await db.insertMessages([entry('future'), entry('keep')]), 1);
      expect(
        (await db.customSelect('SELECT * FROM archive_redactions').get())
            .length,
        1,
      );
    },
  );
  test(
    'failed deletion rolls back marker with plaintext transaction',
    () async {
      await db.insertMessages([entry('old')]);
      await db.customStatement(
        "CREATE TRIGGER reject_delete BEFORE DELETE ON archived_messages BEGIN SELECT RAISE(ABORT, 'test failure'); END",
      );
      await expectLater(db.redactByEventId('old'), throwsA(anything));
      expect(await db.isEventArchived('old'), isTrue);
      expect(
        await db.customSelect('SELECT * FROM archive_redactions').get(),
        isEmpty,
      );
      await db.customStatement('DROP TRIGGER reject_delete');
      await db.redactByEventId('old');
      expect(await db.searchMessages('secret'), isEmpty);
    },
  );
  test(
    'v1 upgrade preserves history and installs durable protection',
    () async {
      await db.insertMessages([entry('keep')]);
      await db.customStatement('DROP TRIGGER archive_reject_redacted_insert');
      await db.customStatement('DROP TABLE archive_redactions');
      await db.customStatement('PRAGMA user_version = 1');
      await db.close();
      db = ArchiveDatabase.forTesting(NativeDatabase(file));
      expect(await db.isEventArchived('keep'), isTrue);
      expect((await db.searchMessages('secret')).single.eventId, 'keep');
      expect(
        (await db.customSelect('PRAGMA user_version').getSingle()).read<int>(
          'user_version',
        ),
        2,
      );
      await db.redactByEventId('keep');
      expect(await db.insertMessages([entry('keep')]), 0);
      expect(await db.searchMessages('secret'), isEmpty);
    },
  );
}
