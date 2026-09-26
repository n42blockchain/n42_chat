import 'dart:io';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';

class _Documents extends PathProviderPlatform {
  _Documents(this.path);
  final String path;
  @override
  Future<String?> getApplicationDocumentsPath() async => path;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Failed lazy opens are deliberately exercised with independent executors.
  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);
  tearDownAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = false);
  late Directory directory;
  late File archive;
  late PathProviderPlatform original;
  final key = List.filled(64, 'a').join();
  setUp(() async {
    directory = await Directory.systemTemp.createTemp(
      'chat-archive-migration-',
    );
    final parent = Directory('${directory.path}/n42_chat_storage')
      ..createSync();
    archive = File('${parent.path}/archive.db');
    original = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _Documents(directory.path);
    FlutterSecureStorage.setMockInitialValues({'n42_chat_archive_db_key': key});
  });
  tearDown(() async {
    await ArchiveDatabase.closeInstance();
    PathProviderPlatform.instance = original;
    await directory.delete(recursive: true);
  });
  Future<void> copyLegacy() => File(
    'test/fixtures/archive/sqlcipher-4.10-archive.db',
  ).copy(archive.path);
  Future<List<String?>> bodies() async {
    final db = await ArchiveDatabase.getInstance();
    final rows = await db
        .customSelect('SELECT body FROM archived_messages')
        .get();
    return rows.map((row) => row.readNullable<String>('body')).toList();
  }

  test(
    'production connection reads historical SQLCipher 4.10 fixture with retained key',
    () async {
      await copyLegacy();
      expect(await bodies(), ['Historical encrypted archive fixture']);
      final db = await ArchiveDatabase.getInstance();
      final matches = await db
          .customSelect(
            "SELECT body FROM archive_fts WHERE archive_fts MATCH 'Historical'",
          )
          .get();
      expect(matches, hasLength(1));
    },
  );
  for (final stored in [null, List.filled(64, 'b').join()]) {
    test(
      'historical archive fails closed for ${stored == null ? 'missing' : 'wrong'} key',
      () async {
        await copyLegacy();
        final before = await archive.readAsBytes();
        FlutterSecureStorage.setMockInitialValues({
          'n42_chat_archive_db_key': ?stored,
        });
        await expectLater(bodies(), throwsA(anything));
        if (stored == null) {
          await expectLater(
            ArchiveDatabase.closeInstance(),
            throwsA(isA<StateError>()),
          );
        } else {
          await ArchiveDatabase.closeInstance();
        }
        expect(await archive.readAsBytes(), before);
        expect(
          await const FlutterSecureStorage().read(
            key: 'n42_chat_archive_db_key',
          ),
          stored,
        );
        FlutterSecureStorage.setMockInitialValues({
          'n42_chat_archive_db_key': key,
        });
        expect(await bodies(), ['Historical encrypted archive fixture']);
      },
    );
  }
  for (final stored in [null, List.filled(64, 'b').join()]) {
    test(
      'aged plaintext backup survives ${stored == null ? 'missing' : 'wrong'} key until verified recovery',
      () async {
        await copyLegacy();
        final backup = File('${archive.path}.plaintext.bak');
        final plaintext = ArchiveDatabase.forTesting(NativeDatabase(backup));
        await plaintext.customStatement(
          "INSERT INTO archived_messages(event_id,room_id,sender_id,origin_server_ts,type,body,quarter,archived_at) VALUES('backup','!room:hs','@me:hs',1,'m.room.message','Recoverable plaintext history',202601,1)",
        );
        await plaintext.close();
        backup.setLastModifiedSync(
          DateTime.now().subtract(const Duration(days: 30)),
        );
        final encryptedBefore = await archive.readAsBytes();
        final backupBefore = await backup.readAsBytes();
        FlutterSecureStorage.setMockInitialValues({
          'n42_chat_archive_db_key': ?stored,
        });
        await expectLater(bodies(), throwsA(anything));
        if (stored == null) {
          await expectLater(
            ArchiveDatabase.closeInstance(),
            throwsA(isA<StateError>()),
          );
        } else {
          await ArchiveDatabase.closeInstance();
        }
        expect(await archive.readAsBytes(), encryptedBefore);
        expect(backup.existsSync(), isTrue);
        expect(await backup.readAsBytes(), backupBefore);
        FlutterSecureStorage.setMockInitialValues({
          'n42_chat_archive_db_key': key,
        });
        expect(await bodies(), ['Historical encrypted archive fixture']);
        expect(
          backup.existsSync(),
          isFalse,
          reason: 'Only successful keyed verification permits cleanup',
        );
      },
    );
  }
  test(
    'production plaintext migration preserves schema version and search history',
    () async {
      final plaintext = ArchiveDatabase.forTesting(NativeDatabase(archive));
      await plaintext.customStatement(
        "INSERT INTO archived_messages(event_id,room_id,sender_id,origin_server_ts,type,body,quarter,archived_at) VALUES('plain','!room:hs','@me:hs',1,'m.room.message','Legacy plaintext archive',202601,1)",
      );
      await plaintext.close();
      expect(
        String.fromCharCodes((await archive.readAsBytes()).take(16)),
        startsWith('SQLite format 3'),
      );
      expect(await bodies(), ['Legacy plaintext archive']);
      final migrated = await ArchiveDatabase.getInstance();
      expect(
        (await migrated
            .customSelect(
              "SELECT body FROM archive_fts WHERE archive_fts MATCH 'Legacy'",
            )
            .get()),
        hasLength(1),
      );
      expect(
        (await migrated.customSelect('PRAGMA user_version').get()).single
            .read<int>('user_version'),
        1,
      );
      await ArchiveDatabase.closeInstance();
      expect(
        String.fromCharCodes((await archive.readAsBytes()).take(16)),
        isNot(startsWith('SQLite format 3')),
      );
      expect(File('${archive.path}.plaintext.bak').existsSync(), isFalse);
      expect(await bodies(), ['Legacy plaintext archive']);
    },
  );
  test('failed plaintext export preserves the original source', () async {
    await archive.writeAsBytes([
      ...'SQLite format 3\x00'.codeUnits,
      ...List.filled(256, 0),
    ]);
    final before = await archive.readAsBytes();
    await expectLater(bodies(), throwsA(anything));
    await expectLater(ArchiveDatabase.closeInstance(), throwsA(anything));
    expect(await archive.readAsBytes(), before);
    expect(File('${archive.path}.enc').existsSync(), isFalse);
  });
}
