import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/archive_account_access.dart';
import 'package:n42_chat/src/core/services/archive_search_service.dart';
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
