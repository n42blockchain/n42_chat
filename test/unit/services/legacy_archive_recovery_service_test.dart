import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/archive_account_access.dart';
import 'package:n42_chat/src/core/services/legacy_archive_recovery_service.dart';
import 'package:n42_chat/src/data/datasources/local/archive_database.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';

class _Manager extends Mock implements MatrixClientManager {}

class _Client extends Mock implements matrix.Client {}

ArchivedMessagesCompanion entry(
  String id,
  String room, {
  int timestamp = 100,
}) => ArchivedMessagesCompanion.insert(
  eventId: id,
  roomId: room,
  senderId: '@alice:example.org',
  originServerTs: timestamp,
  type: 'm.room.message',
  body: Value('legacy text $id'),
  quarter: 202601,
  archivedAt: DateTime(2026),
);

void main() {
  late ArchiveDatabase legacy;
  late ArchiveDatabase account;
  late _Client client;
  late LegacyArchiveRecoveryService recovery;
  const room = '!selected:example.org';

  setUp(() async {
    legacy = ArchiveDatabase.forTesting(NativeDatabase.memory());
    account = ArchiveDatabase.forTesting(NativeDatabase.memory());
    final manager = _Manager();
    client = _Client();
    when(() => manager.client).thenReturn(client);
    when(() => client.userID).thenReturn('@alice:example.org');
    when(() => client.homeserver).thenReturn(Uri.parse('https://example.org'));
    when(() => client.accessToken).thenReturn('fixture-token');
    when(() => client.deviceID).thenReturn('fixture-device');
    final access = ArchiveAccountAccess(
      clientManager: manager,
      open: (_, _) async => account,
    );
    recovery = LegacyArchiveRecoveryService(
      access: access,
      openLegacy: () async => legacy,
    );
    await legacy.insertMessages([
      entry('old-1', room),
      entry('old-2', room),
      entry('other', '!other:example.org'),
    ]);
    await account.insertMessages([entry('newer', room, timestamp: 300)]);
  });
  tearDown(() async {
    await legacy.close();
    await account.close();
  });

  test(
    'copies only confirmed selected rooms and preserves original history',
    () async {
      final preview = await recovery.preview();
      expect(preview.targetUserId, '@alice:example.org');
      expect(preview.roomMessageCounts[room], 2);
      expect(() => preview.roomMessageCounts.clear(), throwsUnsupportedError);
      expect(
        await recovery.recover(
          preview,
          roomIds: {room},
          ownershipConfirmed: true,
        ),
        2,
      );
      expect(await account.isEventArchived('other'), isFalse);
      expect(await legacy.getMessageCount(room), 2);
      final metadata = (await account.getMetadata(room))!;
      expect(metadata.totalArchived, 3);
      expect(metadata.lastArchivedEventId, 'newer');
      expect(
        await recovery.recover(
          preview,
          roomIds: {room},
          ownershipConfirmed: true,
        ),
        0,
      );
      expect((await account.searchMessages('legacy')).length, 3);
    },
  );

  test(
    'requires confirmation and a nonempty selection from the preview',
    () async {
      final preview = await recovery.preview();
      await expectLater(
        recovery.recover(preview, roomIds: {room}, ownershipConfirmed: false),
        throwsArgumentError,
      );
      for (final rooms in [
        <String>{},
        {'!unknown:example.org'},
      ]) {
        await expectLater(
          recovery.recover(preview, roomIds: rooms, ownershipConfirmed: true),
          throwsArgumentError,
        );
      }
      expect(await account.getMessageCount(room), 1);
    },
  );

  test('rejects source changes after preview before copying', () async {
    final preview = await recovery.preview();
    await legacy.insertMessages([entry('arrived-later', room)]);
    await expectLater(
      recovery.recover(preview, roomIds: {room}, ownershipConfirmed: true),
      throwsStateError,
    );
    expect(await account.getMessageCount(room), 1);
  });

  test(
    'account switch during copying rolls back rows metadata and search',
    () async {
      final preview = await recovery.preview();
      await expectLater(
        recovery.recover(
          preview,
          roomIds: {room},
          ownershipConfirmed: true,
          onProgress: (_) =>
              when(() => client.userID).thenReturn('@bob:example.org'),
        ),
        throwsStateError,
      );
      expect(await account.getMessageCount(room), 1);
      expect(await account.isEventArchived('old-1'), isFalse);
      expect(await account.searchMessages('old'), isEmpty);
      expect(await account.getMetadata(room), isNull);
      expect(await legacy.getMessageCount(room), 2);
    },
  );

  test(
    'paginates more than 1000 equal timestamp events without loss',
    () async {
      await legacy.insertMessages(
        List.generate(1005, (index) => entry('tie-$index', room)),
      );
      final preview = await recovery.preview();
      final progress = <double>[];
      expect(
        await recovery.recover(
          preview,
          roomIds: {room},
          ownershipConfirmed: true,
          onProgress: progress.add,
        ),
        1007,
      );
      expect(await account.getMessageCount(room), 1008);
      expect(progress.last, 1);
      expect(await legacy.getMessageCount(room), 1007);
    },
  );
}
