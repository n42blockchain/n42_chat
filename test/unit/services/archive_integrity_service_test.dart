import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/services/archive_integrity_service.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class _TemporaryDocuments extends PathProviderPlatform {
  _TemporaryDocuments(this.path);

  final String path;

  @override
  Future<String?> getApplicationDocumentsPath() async => path;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory directory;
  late ArchiveDatabase sourceDb;
  late PathProviderPlatform originalPaths;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('n42-archive-integrity-');
    originalPaths = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _TemporaryDocuments(directory.path);
    sourceDb = ArchiveDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    PathProviderPlatform.instance = originalPaths;
    await sourceDb.close();
    await directory.delete(recursive: true);
  });

  test('quarter export and import preserve Unicode message bodies', () async {
    const body = '你好，归档 👋';
    await sourceDb.insertMessages([
      ArchivedMessagesCompanion.insert(
        eventId: r'$unicode-event',
        roomId: '!archive:example.org',
        senderId: '@alice:example.org',
        originServerTs: 1790000000000,
        type: 'm.room.message',
        body: const Value(body),
        msgtype: const Value('m.text'),
        decryptedBody: const Value(body),
        quarter: 202604,
        archivedAt: DateTime.utc(2026, 10, 1),
      ),
    ]);

    final export = await ArchiveIntegrityService(
      db: sourceDb,
    ).exportQuarterlyArchive(202604);
    await sourceDb.delete(sourceDb.archivedMessages).go();
    final result = await ArchiveIntegrityService(
      db: sourceDb,
    ).importArchive(export.file, expectedChecksum: export.checksum);

    expect(result.success, isTrue);
    expect(result.messagesImported, 1);
    final imported = await sourceDb.getMessages('!archive:example.org');
    expect(imported.single.body, body);
    expect(imported.single.decryptedBody, body);
  });

  test('quarter export rejects a quarter with no messages', () async {
    final service = ArchiveIntegrityService(db: sourceDb);

    await expectLater(
      service.exportQuarterlyArchive(202601),
      throwsA(isA<StateError>()),
    );
  });

  test(
    'checksum verification rejects missing and modified archive files',
    () async {
      final service = ArchiveIntegrityService(db: sourceDb);
      final file = File('${directory.path}/fixture.db.gz');
      await file.writeAsBytes([1, 2, 3]);

      final expectedChecksum = await service.computeChecksum(file);
      expect(await service.verifyArchive(file, expectedChecksum), isTrue);
      await file.writeAsBytes([4, 5, 6]);
      expect(await service.verifyArchive(file, expectedChecksum), isFalse);
      expect(
        await service.verifyArchive(
          File('${directory.path}/missing.db.gz'),
          '',
        ),
        isFalse,
      );
    },
  );

  test(
    'import reports a missing archive without touching the database',
    () async {
      final result = await ArchiveIntegrityService(
        db: sourceDb,
      ).importArchive(File('${directory.path}/missing.db.gz'));

      expect(result.success, isFalse);
      expect(result.messagesImported, 0);
      expect(result.error, 'File not found');
      expect(await sourceDb.getMessageCount('!archive:example.org'), 0);
    },
  );

  test('import rejects checksum mismatches and malformed gzip data', () async {
    final service = ArchiveIntegrityService(db: sourceDb);
    final file = File('${directory.path}/invalid.db.gz');
    await file.writeAsBytes([1, 2, 3]);

    final mismatch = await service.importArchive(
      file,
      expectedChecksum: 'wrong-checksum',
    );
    expect(mismatch.success, isFalse);
    expect(mismatch.error, 'Checksum verification failed');

    final malformed = await service.importArchive(file);
    expect(malformed.success, isFalse);
    expect(malformed.messagesImported, 0);
    expect(malformed.error, isNotNull);
  });

  test(
    'import ignores malformed lines and reports archives with no valid rows',
    () async {
      final service = ArchiveIntegrityService(db: sourceDb);
      final file = File('${directory.path}/no-messages.db.gz');
      await file.writeAsBytes(gzip.encode(utf8.encode('not-json\n{}\n')));

      final result = await service.importArchive(file);

      expect(result.success, isFalse);
      expect(result.messagesImported, 0);
      expect(result.error, 'No valid messages in archive');
    },
  );

  test(
    'listExportedArchives sorts archives and excludes other files',
    () async {
      final archiveDirectory = Directory('${directory.path}/n42_chat_archives')
        ..createSync(recursive: true);
      await File('${archiveDirectory.path}/archive_Q2.db.gz').writeAsBytes([1]);
      await File('${archiveDirectory.path}/archive_Q1.db.gz').writeAsBytes([1]);
      await File('${archiveDirectory.path}/notes.txt').writeAsString('ignore');
      await Directory('${archiveDirectory.path}/nested.db.gz').create();

      final archives = await ArchiveIntegrityService(
        db: sourceDb,
      ).listExportedArchives();

      expect(archives.map((file) => file.path.split('/').last), [
        'archive_Q1.db.gz',
        'archive_Q2.db.gz',
      ]);
    },
  );
}
