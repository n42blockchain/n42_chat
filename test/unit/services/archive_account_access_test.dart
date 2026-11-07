import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:drift/native.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/archive_account_access.dart';
import 'package:n42_chat/src/core/services/archive_search_service.dart';
import 'package:n42_chat/src/core/services/archive_integrity_service.dart';
import 'package:n42_chat/src/core/services/message_archive_service.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Database extends Mock implements ArchiveDatabase {}

void main() {
  late _Manager manager;
  late _Client client;
  late ArchiveDatabase alice;
  late ArchiveDatabase bob;
  late ArchiveAccountAccess access;

  void identify(String user) {
    when(() => client.userID).thenReturn(user);
    when(() => client.homeserver).thenReturn(Uri.parse('https://example.org'));
    when(() => client.accessToken).thenReturn('test-token');
    when(() => client.deviceID).thenReturn('test-device');
  }

  setUp(() async {
    manager = _Manager();
    client = _Client();
    when(() => manager.client).thenReturn(client);
    identify('@alice:example.org');
    alice = ArchiveDatabase.forTesting(NativeDatabase.memory());
    bob = ArchiveDatabase.forTesting(NativeDatabase.memory());
    for (final pair in [(alice, 'alice'), (bob, 'bob')]) {
      await pair.$1.insertMessages([
        ArchivedMessagesCompanion.insert(
          eventId: 'event-${pair.$2}',
          roomId: '!shared:example.org',
          senderId: '@${pair.$2}:example.org',
          originServerTs: 100,
          type: 'm.room.message',
          quarter: 202601,
          archivedAt: DateTime(2026),
        ),
      ]);
      await pair.$1.customStatement(
        'UPDATE archived_messages SET body = ? WHERE event_id = ?',
        ['private ${pair.$2}', 'event-${pair.$2}'],
      );
      await pair.$1.rebuildFtsIndex();
    }
    access = ArchiveAccountAccess(
      clientManager: manager,
      open: (user, server) async => user == '@alice:example.org' ? alice : bob,
    );
  });
  tearDown(() async {
    await alice.close();
    await bob.close();
  });

  test(
    'search and count follow account while preserving separate histories',
    () async {
      final search = ArchiveSearchService.accountScoped(access: access);
      expect((await search.search('private')).single.message.id, 'event-alice');
      expect(await search.searchCount('bob'), 0);
      identify('@bob:example.org');
      expect((await search.search('private')).single.message.id, 'event-bob');
      expect(await search.searchCount('alice'), 0);
      identify('@alice:example.org');
      expect((await search.search('private')).single.message.id, 'event-alice');
    },
  );

  for (final change in ['client', 'user', 'server', 'token', 'device']) {
    test(
      'database open cannot complete into changed session: $change',
      () async {
        final opened = Completer<ArchiveDatabase>();
        final delayed = ArchiveAccountAccess(
          clientManager: manager,
          open: (_, _) => opened.future,
        );
        final pending = delayed.capture();
        final rejected = expectLater(pending, throwsStateError);
        switch (change) {
          case 'client':
            when(() => manager.client).thenReturn(_Client());
          case 'user':
            when(() => client.userID).thenReturn('@bob:example.org');
          case 'server':
            when(() => client.homeserver)
                .thenReturn(Uri.parse('https://other.example.org'));
          case 'token':
            when(() => client.accessToken).thenReturn('replacement');
          case 'device':
            when(() => client.deviceID).thenReturn('replacement');
        }
        opened.complete(alice);
        await rejected;
      },
    );
  }

  test(
    'archive reads writes and deletion stay within the selected account',
    () async {
      final service = MessageArchiveService.accountScoped(
        access: access,
        clientManager: manager,
      );
      final entry = ArchivedMessagesCompanion.insert(
        eventId: 'shared-event',
        roomId: '!shared:example.org',
        senderId: '@alice:example.org',
        originServerTs: 200,
        type: 'm.room.message',
        body: const Value('alice only'),
        quarter: 202601,
        archivedAt: DateTime(2026),
      );
      expect(
        await service.importArchivedMessages('!shared:example.org', [entry]),
        1,
      );
      expect(await service.isEventArchived('shared-event'), isTrue);
      identify('@bob:example.org');
      expect(await service.isEventArchived('shared-event'), isFalse);
      expect(
        (await service.getArchivedMessages('!shared:example.org'))
            .single
            .eventId,
        'event-bob',
      );
      expect(
        (await service.getArchiveStatus('!shared:example.org')).totalArchived,
        1,
      );
      await service.deleteArchivedMessage('shared-event');
      identify('@alice:example.org');
      expect(await service.isEventArchived('shared-event'), isTrue);
      expect(
        (await service.getArchiveStatus('!shared:example.org')).totalArchived,
        2,
      );
      expect(await service.getQuarterlyStats('!shared:example.org'), {
        202601: 2,
      });
      expect(await service.getArchivedRoomIds(), ['!shared:example.org']);
      expect((await service.getTotalStats()).totalMessages, 2);
    },
  );

  test(
    'account change during metadata write rolls back the complete import',
    () async {
      final database = ArchiveDatabase.forTesting(
        NativeDatabase.memory(
          setup: (db) {
            db.createFunction(
              functionName: 'switch_account',
              directOnly: false,
              function: (_) {
                identify('@bob:example.org');
                return 0;
              },
            );
          },
        ),
      );
      addTearDown(database.close);
      await database.customStatement('''
      CREATE TRIGGER change_account BEFORE INSERT ON archive_metadata
      BEGIN SELECT switch_account(); END
    ''');
      final scoped = ArchiveAccountAccess(
        clientManager: manager,
        open: (_, _) async => database,
      );
      final service = MessageArchiveService.accountScoped(
        access: scoped,
        clientManager: manager,
      );
      await expectLater(
        service.importArchivedMessages('!shared:example.org', [
          ArchivedMessagesCompanion.insert(
            eventId: 'rollback',
            roomId: '!shared:example.org',
            senderId: '@alice:example.org',
            originServerTs: 300,
            type: 'm.room.message',
            body: const Value('rollback text'),
            quarter: 202601,
            archivedAt: DateTime(2026),
          ),
        ]),
        throwsStateError,
      );
      expect(await database.getMessageCount('!shared:example.org'), 0);
      expect(await database.searchMessages('rollback'), isEmpty);
      expect(await database.getMetadata('!shared:example.org'), isNull);
    },
  );

  test(
    'quarter exports isolate files and preserve Unicode across restore',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'n42-integrity-scope-',
      );
      addTearDown(() => directory.delete(recursive: true));
      await alice.insertMessages([
        ArchivedMessagesCompanion.insert(
          eventId: 'unicode',
          roomId: '!shared:example.org',
          senderId: '@alice:example.org',
          originServerTs: 200,
          type: 'm.room.message',
          body: const Value('中文 😀 café'),
          quarter: 202601,
          archivedAt: DateTime(2026),
        ),
      ]);
      final service = ArchiveIntegrityService.accountScoped(
        access: access,
        documentsDirectory: () async => directory,
      );
      final exported = await service.exportQuarterlyArchive(202601);
      expect(
        utf8.decode(gzip.decode(await exported.file.readAsBytes())),
        contains('中文 😀 café'),
      );
      expect(
        await service.verifyArchive(exported.file, exported.checksum),
        isTrue,
      );
      expect(
        (await service.listExportedArchives()).single.path,
        exported.file.path,
      );
      identify('@bob:example.org');
      expect(await service.listExportedArchives(), isEmpty);
      final rejected = await service.importArchive(exported.file);
      expect(rejected.success, isFalse);
      expect(rejected.error, contains('owner'));
      expect(await bob.getMessageCount('!shared:example.org'), 1);
      identify('@alice:example.org');
      await alice.deleteByEventId('unicode');
      expect((await service.importArchive(exported.file)).success, isTrue);
      expect(
        (await alice.getMessages('!shared:example.org')).first.body,
        '中文 😀 café',
      );
      final metadata = await alice.getMetadata('!shared:example.org');
      expect(metadata, isNotNull);
      expect(metadata!.totalArchived, 2);
      expect(metadata.lastArchivedEventId, 'unicode');
      expect(metadata.lastArchivedTs, 200);
    },
  );

  test(
    'quarter import metadata failure rolls back messages and search text',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'n42-quarter-rollback-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final source = ArchiveIntegrityService(
        db: alice,
        documentsDirectory: () async => directory,
      );
      final exported = await source.exportQuarterlyArchive(202601);
      await bob.customStatement('''
      CREATE TRIGGER fail_quarter_metadata BEFORE INSERT ON archive_metadata
      BEGIN SELECT RAISE(ABORT, 'fixture metadata failure'); END
    ''');
      final target = ArchiveIntegrityService(
        db: bob,
        documentsDirectory: () async => directory,
      );
      final imported = await target.importArchive(exported.file);
      expect(imported.success, isFalse);
      expect(imported.messagesImported, 0);
      expect(await bob.isEventArchived('event-alice'), isFalse);
      expect(await bob.searchMessages('alice'), isEmpty);
      expect(await bob.getMessageCount('!shared:example.org'), 1);
    },
  );

  test(
    'quarter metadata uses persisted rows across rooms and duplicate imports',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'n42-quarter-rooms-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final file = File('${directory.path}/legacy.db.gz');
      final rows = [
        {
          'eid': 'old',
          'rid': '!shared:example.org',
          'sid': '@alice:example.org',
          'ts': 50,
          'tp': 'm.room.message',
          'bd': 'old',
          'q': 202601,
        },
        {
          'eid': 'second',
          'rid': '!second:example.org',
          'sid': '@alice:example.org',
          'ts': 200,
          'tp': 'm.room.message',
          'bd': 'second',
          'q': 202601,
        },
      ];
      await file.writeAsBytes(
        gzip.encode(utf8.encode(rows.map(jsonEncode).join('\n'))),
      );
      final service = ArchiveIntegrityService.accountScoped(
        access: access,
        documentsDirectory: () async => directory,
      );
      expect(
        (await service.importArchive(
          file,
          allowUnownedLegacy: true,
        )).messagesImported,
        2,
      );
      final first = (await alice.getMetadata('!shared:example.org'))!;
      expect(first.lastArchivedEventId, 'event-alice');
      expect(first.lastArchivedTs, 100);
      expect(first.totalArchived, 2);
      final second = (await alice.getMetadata('!second:example.org'))!;
      expect(second.lastArchivedEventId, 'second');
      expect(second.lastArchivedTs, 200);
      expect(second.totalArchived, 1);
      expect(
        (await service.importArchive(
          file,
          allowUnownedLegacy: true,
        )).messagesImported,
        0,
      );
      expect(
        (await alice.getMetadata('!shared:example.org'))!.totalArchived,
        2,
      );
    },
  );

  test(
    'legacy quarter import requires explicit confirmation in scoped mode',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'n42-legacy-scope-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final legacy = ArchiveIntegrityService(
        db: alice,
        documentsDirectory: () async => directory,
      );
      final exported = await legacy.exportQuarterlyArchive(202601);
      final service = ArchiveIntegrityService.accountScoped(
        access: access,
        documentsDirectory: () async => directory,
      );
      expect((await service.importArchive(exported.file)).success, isFalse);
      expect(
        (await service.importArchive(
          exported.file,
          allowUnownedLegacy: true,
        )).success,
        isTrue,
      );
    },
  );

  test(
    'export stops if account changes while resolving its directory',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'n42-export-race-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final started = Completer<void>();
      final release = Completer<Directory>();
      final service = ArchiveIntegrityService.accountScoped(
        access: access,
        documentsDirectory: () {
          started.complete();
          return release.future;
        },
      );
      final pending = service.exportQuarterlyArchive(202601);
      final rejected = expectLater(pending, throwsStateError);
      await started.future;
      identify('@bob:example.org');
      release.complete(directory);
      await rejected;
      expect(directory.listSync(recursive: true).whereType<File>(), isEmpty);
    },
  );

  test('count completed after account switch is suppressed', () async {
    final database = _Database();
    final started = Completer<void>();
    final result = Completer<int>();
    when(() => database.searchCount('private', roomId: null)).thenAnswer((_) {
      started.complete();
      return result.future;
    });
    final scoped = ArchiveAccountAccess(
      clientManager: manager,
      open: (_, _) async => database,
    );
    final pending = ArchiveSearchService.accountScoped(access: scoped)
        .searchCount('private');
    await started.future;
    identify('@bob:example.org');
    result.complete(23);
    expect(await pending, 0);
  });

  test(
    'lease rejects use after logout and search exposes no history',
    () async {
      final lease = await access.capture();
      when(() => manager.client).thenReturn(null);
      expect(lease.ensureCurrent, throwsStateError);
      final search = ArchiveSearchService.accountScoped(access: access);
      expect(await search.search('private'), isEmpty);
      expect(await search.searchCount('private'), 0);
    },
  );
}
