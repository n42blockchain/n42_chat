import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/chat_backup_service.dart';
import 'package:n42_chat/src/core/services/message_archive_service.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/chat_backup_v3_interop.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

class _Secure extends Mock implements SecureStorageDataSource {}

class _Room extends Mock implements matrix.Room {}

class _Archive extends Mock implements MessageArchiveService {}

class _Summary extends Mock implements matrix.RoomSummary {}

class _Timeline extends Mock implements matrix.Timeline {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory directory;
  late _Manager manager;
  late _Secure secure;
  late _Client client;
  late PreferencesDataSource preferences;
  late ChatBackupService service;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    directory = await Directory.systemTemp.createTemp('n42-backup-files-');
    manager = _Manager();
    secure = _Secure();
    final stored = <String, String?>{};
    when(() => secure.read(any()))
        .thenAnswer((i) async => stored[i.positionalArguments[0]]);
    when(() => secure.write(any(), any())).thenAnswer((i) async {
      stored[i.positionalArguments[0] as String] =
          i.positionalArguments[1] as String?;
    });
    client = _Client();
    when(() => client.userID).thenReturn('@alice:example.org');
    when(() => client.homeserver).thenReturn(Uri.parse('https://example.org'));
    when(() => manager.client).thenReturn(client);
    when(() => client.rooms).thenReturn([]);
    preferences = PreferencesDataSource();
    service = ChatBackupService(
      clientManager: manager,
      secureStorage: secure,
      preferencesStorage: preferences,
      backupDirProvider: () async => directory,
    );
  });
  tearDown(() async => directory.delete(recursive: true));

  (_Room, _Timeline) roomFixture(String id) {
    final room = _Room();
    final timeline = _Timeline();
    when(() => room.id).thenReturn(id);
    when(() => room.getLocalizedDisplayname()).thenReturn(id);
    when(() => room.getTimeline()).thenAnswer((_) async => timeline);
    when(() => timeline.events).thenReturn([
      matrix.Event(
        eventId: 'event-$id',
        senderId: '@alice:example.org',
        originServerTs: DateTime.utc(2020),
        type: 'm.room.message',
        content: {'msgtype': 'm.text', 'body': 'historical message'},
        room: room,
      ),
    ]);
    return (room, timeline);
  }

  for (final incremental in [false, true]) {
    for (final broken in [false, true]) {
      test(
        'export releases timeline: incremental=$incremental broken=$broken',
        () async {
          final (room, timeline) = roomFixture('!cleanup:example.org');
          when(() => client.rooms).thenReturn([room]);
          when(() => room.name).thenReturn('Cleanup');
          when(() => room.topic).thenReturn('');
          when(() => room.isDirectChat).thenReturn(false);
          when(() => room.summary).thenReturn(_Summary());
          if (broken)
            when(() => timeline.events).thenThrow(StateError('read failed'));
          if (incremental) {
            await service.createIncrementalBackup();
          } else {
            final result = await service.createBackup();
            final data = jsonDecode(await File(result.filePath).readAsString()) as Map;
            expect(data['manifest']['hasReadErrors'], broken);
            if (broken) {
              expect(result.warnings, isNotEmpty);
              expect((await service.previewBackup(result.filePath)).warnings, isNotEmpty);
              expect((await service.restoreFromBackup(backupFilePath: result.filePath, restoreSettings: false)).hasWarnings, isTrue);
            }
          }
          verify(() => timeline.cancelSubscriptions()).called(1);
        },
      );
    }
  }

  for (final progress in [0.1, 0.5, 1.0]) {
    test('restore rejects account change at progress $progress', () async {
      final backup = await service.createBackup();
      final result = await service.restoreFromBackup(
        backupFilePath: backup.filePath,
        restoreSettings: false,
        onProgress: (value) {
          if (value == progress) when(() => client.accessToken).thenReturn('replacement');
        },
      );
      expect(result.hasErrors, isTrue);
    });
  }

  test(
    'incremental archive pagination exports every equal-timestamp event',
    () async {
      final database = ArchiveDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);
      final (room, timeline) = roomFixture('!dense:example.org');
      when(() => timeline.events).thenReturn([]);
      when(() => client.rooms).thenReturn([room]);
      service.setArchiveService(
        MessageArchiveService(db: database, clientManager: manager),
      );
      final expected = <String>{};
      final entries = <ArchivedMessagesCompanion>[];
      for (var i = 0; i < 1203; i++) {
        final id = 'event-${i.toString().padLeft(4, '0')}';
        expected.add(id);
        entries.add(
          ArchivedMessagesCompanion.insert(
            eventId: id,
            roomId: room.id,
            senderId: '@alice:example.org',
            originServerTs: i == 0
                ? 999
                : i == 1202
                ? 1001
                : 1000,
            type: 'm.room.message',
            body: Value('message $i'),
            quarter: 197001,
            archivedAt: DateTime.utc(2026),
          ),
        );
      }
      await database.insertMessages(entries);
      final result = await service.createIncrementalBackup();
      expect(result.warnings, isEmpty);
      expect(result.messageCount, expected.length);
      final data =
          jsonDecode(await File(result.filePath).readAsString()) as Map;
      final messages =
          ((data['rooms'] as Map)[room.id] as Map)['messages'] as List;
      expect(messages.map((e) => (e as Map)['eventId']).toSet(), expected);
      expect(messages.length, expected.length);
    },
  );

  for (final scope in [
    'different subset',
    'new room',
    'same reordered scope',
  ]) {
    test('incremental history survives $scope', () async {
      final (firstRoom, _) = roomFixture('!first:example.org');
      final (secondRoom, _) = roomFixture('!second:example.org');
      when(
        () => client.rooms,
      ).thenReturn(scope == 'new room' ? [firstRoom] : [firstRoom, secondRoom]);
      final first = await service.createIncrementalBackup(
        roomIds: scope == 'different subset' ? [firstRoom.id] : null,
      );
      when(() => client.rooms).thenReturn([secondRoom, firstRoom]);
      final second = await service.createIncrementalBackup(
        roomIds: scope == 'different subset' ? [secondRoom.id] : null,
      );
      final data =
          jsonDecode(await File(second.filePath).readAsString()) as Map;
      expect(
        (data['manifest'] as Map)['lastBackupTimestamp'],
        scope == 'same reordered scope'
            ? first.createdAt.millisecondsSinceEpoch
            : 0,
      );
      expect(
        second.messageCount,
        scope == 'same reordered scope'
            ? 0
            : scope == 'new room'
            ? 2
            : 1,
      );
    });
  }
  for (final source in ['timeline', 'archive', 'metadata']) {
    test(
      'failed $source export warns and preserves the incremental cursor',
      () async {
        final (room, timeline) = roomFixture('!failure:example.org');
        when(() => client.rooms).thenReturn([room]);
        final archive = _Archive();
        if (source == 'timeline') {
          when(() => room.getTimeline())
              .thenThrow(StateError('fixture timeline failed'));
        } else if (source == 'metadata') {
          when(() => room.getLocalizedDisplayname())
              .thenThrow(StateError('fixture metadata failed'));
        } else {
          service.setArchiveService(archive);
          when(
            () => archive.getArchivedMessages(
              '!failure:example.org',
              beforeTimestamp: null,
              limit: 500,
            ),
          ).thenThrow(StateError('fixture archive failed'));
        }
        final failed = await service.createIncrementalBackup();
        expect(failed.warnings, isNotEmpty);
        final data =
            jsonDecode(await File(failed.filePath).readAsString()) as Map;
        expect((data['manifest'] as Map)['hasReadErrors'], isTrue);
        expect((data['manifest'] as Map)['warnings'], failed.warnings);
        verifyNever(() => secure.write(any(), any()));
        when(() => room.getTimeline()).thenAnswer((_) async => timeline);
        when(() => room.getLocalizedDisplayname()).thenReturn(room.id);
        if (source == 'archive') {
          when(
            () => archive.getArchivedMessages(
              '!failure:example.org',
              beforeTimestamp: null,
              limit: 500,
            ),
          ).thenAnswer((_) async => []);
        }
        final recovered = await service.createIncrementalBackup();
        expect(recovered.messageCount, 1);
        expect(recovered.warnings, isEmpty);
        expect(await service.verifyBackup(recovered.filePath), isTrue);
      },
    );
  }

  for (final change in ['user', 'server', 'unknown', 'legacy']) {
    test('incremental cursor does not cross $change ownership', () async {
      final first = await service.createIncrementalBackup();
      if (change == 'user') {
        when(() => client.userID).thenReturn('@bob:example.org');
      } else if (change == 'server') {
        when(() => client.homeserver)
            .thenReturn(Uri.parse('https://other.org'));
      } else if (change == 'unknown') {
        when(() => client.userID).thenReturn(null);
      } else {
        when(() => client.userID).thenReturn('@new:example.org');
        await secure.write(
          'n42_chat_last_incremental_backup_ts',
          first.createdAt.millisecondsSinceEpoch.toString(),
        );
      }
      final next = await service.createIncrementalBackup();
      final data = jsonDecode(await File(next.filePath).readAsString()) as Map;
      expect((data['manifest'] as Map)['lastBackupTimestamp'], 0);
      if (change == 'user') {
        when(() => client.userID).thenReturn('@alice:example.org');
        final resumed = await service.createIncrementalBackup();
        final restored =
            jsonDecode(await File(resumed.filePath).readAsString()) as Map;
        expect(
          (restored['manifest'] as Map)['lastBackupTimestamp'],
          first.createdAt.millisecondsSinceEpoch,
        );
      }
    });
  }
  for (final incremental in [false, true]) {
    for (final phase in [0.1, 0.85]) {
      for (final mutation in ['user', 'server', 'token', 'device', 'client']) {
        test(
          'backup rejects session changes at $phase incremental=$incremental mutation=$mutation',
          () async {
            void progress(double value) {
              if (value == phase) {
                switch (mutation) {
                  case 'user':
                    when(() => client.userID).thenReturn('@other:example.org');
                  case 'server':
                    when(() => client.homeserver)
                        .thenReturn(Uri.parse('https://other.org'));
                  case 'token':
                    when(() => client.accessToken)
                        .thenReturn('changed-fixture-token');
                  case 'device':
                    when(() => client.deviceID).thenReturn('changed-device');
                  case 'client':
                    when(() => manager.client).thenReturn(_Client());
                }
              }
            }

            await expectLater(
              incremental
                  ? service.createIncrementalBackup(onProgress: progress)
                  : service.createBackup(onProgress: progress),
              throwsStateError,
            );
            expect(await directory.list().toList(), isEmpty);
            verifyNever(() => secure.write(any(), any()));
          },
        );
      }
    }
  }
  for (final incremental in [false, true]) {
    test(
      '${incremental ? 'incremental' : 'full'} consecutive backups preserve both files',
      () async {
        Future<BackupResult> create() => incremental
            ? service.createIncrementalBackup()
            : service.createBackup();
        final first = await create();
        final originalBytes = await File(first.filePath).readAsBytes();
        final second = await create();
        expect(second.backupId, isNot(first.backupId));
        expect(second.filePath, isNot(first.filePath));
        expect(await File(first.filePath).readAsBytes(), originalBytes);
        expect((await service.listBackups()).map((b) => b.backupId).toSet(), {
          first.backupId,
          second.backupId,
        });
      },
    );
  }
  test(
    'full backup progress finishes only after a verifiable file exists',
    () async {
      final progress = <double>[];
      final result = await service.createBackup(onProgress: progress.add);
      expect(progress, [0.1, 0.85, 1.0]);
      expect(result.messageCount, 0);
      expect(result.roomCount, 0);
      expect(result.fileSizeBytes, await File(result.filePath).length());
      expect(await service.verifyBackup(result.filePath), isTrue);
      expect(
        (await service.previewBackup(result.filePath)).backupId,
        result.backupId,
      );
      verifyNever(() => secure.read(any()));
    },
  );
  test(
    'missing client rejects creation and does not leave a backup file',
    () async {
      when(() => manager.client).thenReturn(null);
      await expectLater(service.createBackup(), throwsStateError);
      await expectLater(service.createIncrementalBackup(), throwsStateError);
      expect(await directory.list().toList(), isEmpty);
      final estimate = await service.estimateBackupSize(includeMedia: true);
      expect(estimate.estimatedBytes, 0);
      expect(estimate.roomCount, 0);
    },
  );
  test(
    'empty backup estimate includes settings and increases for media',
    () async {
      final plain = await service.estimateBackupSize();
      final media = await service.estimateBackupSize(includeMedia: true);
      expect(plain.estimatedBytes, greaterThan(0));
      expect(media.estimatedBytes, greaterThanOrEqualTo(plain.estimatedBytes));
      expect(media.includesMedia, isTrue);
    },
  );
  test(
    'AES-GCM round trip protects content and restores supported settings',
    () async {
      await preferences.write(
        'n42_chat_settings',
        '{"fixture":"confidential-value"}',
      );
      final result = await service.createBackup(password: 'fixture-password');
      final raw = await File(result.filePath).readAsBytes();
      expect(utf8.decode(raw.take(8).toList()), 'N42ENC3:');
      expect(
        utf8.decode(raw, allowMalformed: true),
        isNot(contains('confidential-value')),
      );
      expect(
        (await service.previewBackup(
          result.filePath,
          password: 'fixture-password',
        )).backupId,
        result.backupId,
      );
      expect(
        await service.verifyBackup(
          result.filePath,
          password: 'fixture-password',
        ),
        isTrue,
      );
      await preferences.write('n42_chat_settings', '{}');
      final restored = await service.restoreFromBackup(
        backupFilePath: result.filePath,
        password: 'fixture-password',
      );
      expect(restored.errors, isEmpty);
      expect(restored.settingsRestored, 1);
      expect(
        await preferences.read('n42_chat_settings'),
        contains('confidential-value'),
      );
    },
  );
  test(
    'wrong password fails verification and leaves settings untouched',
    () async {
      await preferences.write('n42_chat_settings', '{"fixture":"original"}');
      final result = await service.createBackup(password: 'right-password');
      await preferences.write('n42_chat_settings', '{"fixture":"current"}');
      expect(
        await service.verifyBackup(result.filePath, password: 'wrong-password'),
        isFalse,
      );
      final restored = await service.restoreFromBackup(
        backupFilePath: result.filePath,
        password: 'wrong-password',
      );
      expect(restored.errors, isNotEmpty);
      expect(restored.settingsRestored, 0);
      expect(await preferences.read('n42_chat_settings'), contains('current'));
    },
  );
  test(
    'protected backup requires a password for both preview and restore',
    () async {
      final result = await service.createBackup(password: 'fixture-password');
      await expectLater(
        service.previewBackup(result.filePath),
        throwsStateError,
      );
      expect(await service.verifyBackup(result.filePath), isFalse);
      expect(
        (await service.restoreFromBackup(
          backupFilePath: result.filePath,
        )).errors,
        isNotEmpty,
      );
    },
  );
  test('ciphertext tampering is rejected before restore writes', () async {
    final result = await service.createBackup(password: 'fixture-password');
    final file = File(result.filePath);
    final raw = await file.readAsBytes();
    raw[raw.length - 1] ^= 1;
    await file.writeAsBytes(raw);
    expect(
      await service.verifyBackup(result.filePath, password: 'fixture-password'),
      isFalse,
    );
    expect(
      (await service.restoreFromBackup(
        backupFilePath: result.filePath,
        password: 'fixture-password',
      )).settingsRestored,
      0,
    );
  });
  test('incremental password protection remains verifiable', () async {
    final result = await service.createIncrementalBackup(
      password: 'fixture-password',
    );
    expect(
      await service.verifyBackup(result.filePath, password: 'fixture-password'),
      isTrue,
    );
    expect(
      (await service.previewBackup(
        result.filePath,
        password: 'fixture-password',
      )).hasSettings,
      isFalse,
    );
    final next = await service.createIncrementalBackup();
    final manifest = jsonDecode(
      await File(next.filePath).readAsString(),
    )['manifest'];
    expect(
      manifest['lastBackupTimestamp'],
      result.createdAt.millisecondsSinceEpoch,
    );
  });
  test(
    'restoring without settings does not change current preferences',
    () async {
      await preferences.write('n42_chat_settings', '{"fixture":"old"}');
      final result = await service.createBackup();
      await preferences.write('n42_chat_settings', '{"fixture":"current"}');
      final progress = <double>[];
      final restored = await service.restoreFromBackup(
        backupFilePath: result.filePath,
        restoreSettings: false,
        restoreKeys: true,
        onProgress: progress.add,
      );
      expect(restored.settingsRestored, 0);
      expect(restored.keysRestored, isFalse);
      expect(restored.warnings, isNotEmpty);
      expect(await preferences.read('n42_chat_settings'), contains('current'));
      expect(progress, [0.1, 0.5, 1.0]);
      verifyNever(() => secure.write(any(), any()));
    },
  );
  test('empty password uses the ordinary readable backup format', () async {
    final result = await service.createBackup(password: '');
    expect(
      jsonDecode(await File(result.filePath).readAsString()),
      isA<Map<String, dynamic>>(),
    );
    expect(await service.verifyBackup(result.filePath), isTrue);
  });
  test('list ignores unrelated files and directories', () async {
    await File('${directory.path}/notes.txt').writeAsString('ignore');
    await Directory('${directory.path}/folder.n42backup').create();
    expect(await service.listBackups(), isEmpty);
    final result = await service.createBackup(includeMedia: true);
    final listed = (await service.listBackups()).single;
    expect(listed.backupId, result.backupId);
    expect(listed.includesMedia, isTrue);
    expect(listed.includesKeys, isFalse);
    expect(listed.fileSizeBytes, result.fileSizeBytes);
  });
  test('encrypted file can be listed and deleted without decrypting', () async {
    final result = await service.createBackup(password: 'fixture-password');
    final listed = (await service.listBackups()).single;
    expect(listed.filePath, result.filePath);
    await service.deleteBackup(listed.backupId);
    expect(await File(result.filePath).exists(), isFalse);
  });
  test('deleting an unknown backup preserves an existing one', () async {
    final result = await service.createBackup();
    await service.deleteBackup('not-present');
    expect(await File(result.filePath).exists(), isTrue);
    await service.deleteBackup(result.backupId);
    expect(await service.listBackups(), isEmpty);
  });
  for (final content in ['not json', '[]', 'N42ENC3:', 'N42ENC2:', 'N42ENC:']) {
    test('malformed backup $content cannot restore settings', () async {
      final file = File('${directory.path}/bad.n42backup');
      await file.writeAsString(content);
      expect(
        await service.verifyBackup(file.path, password: 'fixture-password'),
        isFalse,
      );
      expect(
        (await service.restoreFromBackup(
          backupFilePath: file.path,
          password: 'fixture-password',
        )).errors,
        isNotEmpty,
      );
    });
  }
  test('missing archive service returns an explicit restore failure', () async {
    final result = await service.createBackup();
    final restored = await service.restoreToArchive(
      backupFilePath: result.filePath,
    );
    expect(restored.errors, contains('Archive service not available'));
  });

  for (final format in ['v3', 'legacyRoundedV3']) {
    test(
      'independent Python AES-GCM $format fixture restores correctly',
      () async {
        const fixture = chatBackupV3Interop;
        final file = File('${directory.path}/interop.n42backup');
        await file.writeAsBytes(base64Decode(fixture[format]!));
        final password = fixture['fixturePassword']!;
        final preview = await service.previewBackup(
          file.path,
          password: password,
        );
        expect(preview.backupId, fixture['backupId']);
        final restored = await service.restoreFromBackup(
          backupFilePath: file.path,
          password: password,
        );
        expect(restored.errors, isEmpty);
        expect(
          jsonDecode((await preferences.read('n42_chat_settings'))!)['theme'],
          'fixture-dark',
        );
      },
    );
  }

  for (final length in [1, 15, 16, 17, 31]) {
    test(
      'encrypted payload length $length survives block boundaries',
      () async {
        final value = List.filled(length, 'x').join();
        await preferences.write(
          'n42_chat_settings',
          jsonEncode({'value': value}),
        );
        final result = await service.createBackup(
          password: 'boundary-password',
        );
        await preferences.write('n42_chat_settings', '{}');
        final restored = await service.restoreFromBackup(
          backupFilePath: result.filePath,
          password: 'boundary-password',
        );
        expect(restored.errors, isEmpty);
        expect(
          jsonDecode((await preferences.read('n42_chat_settings'))!)['value'],
          value,
        );
      },
    );
  }
  test(
    'legacy rounded v3 output is recoverable only with a valid authentication tag',
    () async {
      BackupResult? result;
      List<int>? wire;
      var padding = 0;
      for (var length = 1; length <= 16 && padding == 0; length++) {
        await preferences.write(
          'n42_chat_settings',
          jsonEncode({'value': List.filled(length, 'x').join()}),
        );
        result = await service.createBackup(password: 'legacy-password');
        wire = await File(result.filePath).readAsBytes();
        padding = (16 - (wire.length - 52) % 16) % 16;
      }
      expect(padding, greaterThan(0));
      // Recreate the old writer's rounded ciphertext+tag buffer and split its
      // last 16 bytes as the tag, exactly as that on-disk v3 layout did.
      final rounded = [
        ...wire!.sublist(68),
        ...wire.sublist(52, 68),
        ...List.filled(padding, 0),
      ];
      final legacy = [
        ...wire.sublist(0, 52),
        ...rounded.sublist(rounded.length - 16),
        ...rounded.sublist(0, rounded.length - 16),
      ];
      final file = File(result!.filePath);
      await file.writeAsBytes(legacy);
      expect(
        (await service.previewBackup(
          file.path,
          password: 'legacy-password',
        )).backupId,
        result.backupId,
      );
      expect(
        await service.verifyBackup(file.path, password: 'wrong-password'),
        isFalse,
      );
      legacy[68] ^= 1;
      await file.writeAsBytes(legacy);
      expect(
        await service.verifyBackup(file.path, password: 'legacy-password'),
        isFalse,
      );
    },
  );

  for (final position in [8, 40, 52, 68]) {
    test(
      'modifying protected byte $position rejects salt nonce tag or ciphertext changes',
      () async {
        final result = await service.createBackup(password: 'tamper-password');
        final file = File(result.filePath);
        final wire = await file.readAsBytes();
        wire[position] ^= 1;
        await file.writeAsBytes(wire);
        expect(
          await service.verifyBackup(file.path, password: 'tamper-password'),
          isFalse,
        );
      },
    );
  }
  test('missing backup file is not reported as verified or restored', () async {
    final path = '${directory.path}/missing.n42backup';
    expect(await service.verifyBackup(path), isFalse);
    expect(
      (await service.restoreFromBackup(backupFilePath: path)).errors,
      isNotEmpty,
    );
  });
}
