import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:n42_chat/src/core/di/archive_registration.dart';
import 'package:n42_chat/src/core/services/message_archive_service.dart';
import 'package:n42_chat/src/core/services/archive_search_service.dart';
import 'package:n42_chat/src/core/services/archive_integrity_service.dart';
import 'package:n42_chat/src/core/services/legacy_archive_recovery_service.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';

class _Documents extends PathProviderPlatform {
  final String path;
  _Documents(this.path);
  @override
  Future<String?> getApplicationDocumentsPath() async => path;
}

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory directory;
  late PathProviderPlatform previous;
  final server = Uri.parse('https://example.org');
  const storage = FlutterSecureStorage();
  String scope(String user) =>
      ArchiveDatabase.accountStorageId(userId: user, homeserver: server);
  String keyName(String user) => 'n42_chat_archive_db_key_${scope(user)}';
  File file(String user) =>
      File('${directory.path}/n42_chat_storage/archive_${scope(user)}.db');
  Future<ArchiveDatabase> open(String user) =>
      ArchiveDatabase.getForAccount(userId: user, homeserver: server);
  const alice = '@alice:example.org';
  const bob = '@bob:example.org';

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('n42-owned-cipher-');
    previous = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _Documents(directory.path);
    FlutterSecureStorage.setMockInitialValues({});
  });
  tearDown(() async {
    try {
      await ArchiveDatabase.closeAccountInstances();
    } finally {
      PathProviderPlatform.instance = previous;
      await directory.delete(recursive: true);
    }
  });

  Future<void> seed() async {
    for (final user in [alice, bob]) {
      final database = await open(user);
      expect(
        await database.customSelect('PRAGMA cipher_version').get(),
        isNotEmpty,
      );
      await database.customStatement(
        'INSERT INTO archived_messages(event_id,room_id,sender_id,origin_server_ts,type,body,quarter,archived_at) VALUES(?,?,?,?,?,?,?,?)',
        [
          'shared-event',
          '!shared:example.org',
          user,
          100,
          'm.room.message',
          'private $user',
          202601,
          1,
        ],
      );
    }
    await ArchiveDatabase.closeAccountInstances();
  }

  test('production account files use separate keys and survive reopen without claiming legacy history', () async {
    final legacy = File('${directory.path}/n42_chat_storage/archive.db');
    await legacy.parent.create(recursive: true);
    await File('test/fixtures/archive/sqlcipher-4.10-archive.db')
        .copy(legacy.path);
    final original = await legacy.readAsBytes();
    await seed();
    final aliceKey = await storage.read(key: keyName(alice));
    final bobKey = await storage.read(key: keyName(bob));
    expect(aliceKey, matches(RegExp(r'^[a-f0-9]{64}$')));
    expect(bobKey, matches(RegExp(r'^[a-f0-9]{64}$')));
    expect(aliceKey, isNot(bobKey));
    for (final user in [alice, bob]) {
      final bytes = await file(user).readAsBytes();
      expect(
        String.fromCharCodes(bytes.take(16)),
        isNot(startsWith('SQLite format 3')),
      );
      expect(String.fromCharCodes(bytes), isNot(contains('private $user')));
      final database = await open(user);
      expect(
        (await database.getMessages('!shared:example.org')).single.body,
        'private $user',
      );
      expect(await database.searchCount(user == alice ? 'bob' : 'alice'), 0);
    }
    expect(await legacy.readAsBytes(), original);
    expect(await storage.read(key: 'n42_chat_archive_db_key'), isNull);
  });

  test(
    'registered production services use encrypted account files together',
    () async {
      await seed();
      final dependencies = GetIt.asNewInstance();
      addTearDown(() => dependencies.reset());
      final manager = _Manager();
      final client = _Client();
      when(() => manager.client).thenReturn(client);
      when(() => client.userID).thenReturn(alice);
      when(() => client.homeserver).thenReturn(server);
      when(() => client.accessToken).thenReturn('fixture-token');
      when(() => client.deviceID).thenReturn('fixture-device');
      dependencies.registerSingleton<MatrixClientManager>(manager);
      registerAccountArchiveServices(dependencies);
      final messages = dependencies<MessageArchiveService>();
      final search = dependencies<ArchiveSearchService>();
      final integrity = dependencies<ArchiveIntegrityService>();
      expect(dependencies.isRegistered<LegacyArchiveRecoveryService>(), isTrue);
      expect(
        (await messages.getArchivedMessages('!shared:example.org')).single.body,
        'private $alice',
      );
      expect(await search.searchCount('bob'), 0);
      final exported = await integrity.exportQuarterlyArchive(202601);
      when(() => client.userID).thenReturn(bob);
      expect(
        (await messages.getArchivedMessages('!shared:example.org')).single.body,
        'private $bob',
      );
      expect(await search.searchCount('alice'), 0);
      expect(await integrity.listExportedArchives(), isEmpty);
      expect((await integrity.importArchive(exported.file)).success, isFalse);
      when(() => client.userID).thenReturn(alice);
      expect(
        (await integrity.listExportedArchives()).single.path,
        exported.file.path,
      );
      expect(await search.searchCount('alice'), 1);
      await dependencies.reset();
      expect(
        (await (await open(alice)).getMessages('!shared:example.org'))
            .single
            .body,
        'private $alice',
      );
    },
  );

  for (final missing in [false, true]) {
    test(
      'owned ciphertext fails closed with ${missing ? 'missing' : 'other account'} key',
      () async {
        await seed();
        final before = await file(alice).readAsBytes();
        final bobKey = (await storage.read(key: keyName(bob)))!;
        FlutterSecureStorage.setMockInitialValues({
          keyName(bob): bobKey,
          if (!missing) keyName(alice): bobKey,
        });
        final database = await open(alice);
        await expectLater(
          database.getMessages('!shared:example.org'),
          throwsA(anything),
        );
        if (missing) {
          await expectLater(
            ArchiveDatabase.closeAccountInstances(),
            throwsA(isA<StateError>()),
          );
          expect(await storage.read(key: keyName(alice)), isNull);
        } else {
          await ArchiveDatabase.closeAccountInstances();
        }
        expect(await file(alice).readAsBytes(), before);
        final other = await open(bob);
        expect(
          (await other.getMessages('!shared:example.org')).single.body,
          'private $bob',
        );
      },
    );
  }
}
