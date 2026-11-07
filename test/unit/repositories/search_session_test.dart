import 'package:n42_chat/src/core/services/chat_lock_service.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_search_datasource.dart';
import 'package:n42_chat/src/data/repositories/search_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/search_result_entity.dart';

class Manager extends Mock implements MatrixClientManager {}

class Client extends Mock implements matrix.Client {}

class Source extends Mock implements MatrixSearchDataSource {}

class Preferences extends Mock implements PreferencesDataSource {}

class Locks extends Mock implements ChatLockService {}

class StagedRepository extends SearchRepositoryImpl {
  StagedRepository(super.source, super.manager, this.pause);
  final String pause;
  final gate = Completer<void>();
  final entered = Completer<void>();
  final calls = <String>[];
  Future<List<SearchResultItem>> stage(String name) async {
    calls.add(name);
    if (name == pause) {
      entered.complete();
      await gate.future;
    }
    return [
      SearchResultItem(type: SearchResultType.contact, id: name, title: name),
    ];
  }

  @override
  Future<void> saveSearchQuery(String query) async {
    await stage('history');
  }

  @override
  Future<List<SearchResultItem>> searchContacts(
    String query, {
    int limit = 20,
  }) => stage('contacts');
  @override
  Future<List<SearchResultItem>> searchGroups(String query, {int limit = 20}) =>
      stage('groups');
  @override
  Future<List<SearchResultItem>> searchConversations(
    String query, {
    int limit = 20,
  }) => stage('conversations');
  @override
  Future<List<SearchResultItem>> searchMessages(
    String query, {
    int limit = 50,
    String? roomId,
    MessageSearchFilter? filter,
  }) => stage('messages');
}

void main() {
  for (final groups in [false, true]) {
    test(
      'privacy lookup cannot continue into new account groups=$groups',
      () async {
        final manager = Manager();
        final client = Client();
        final source = Source();
        final preferences = Preferences();
        final locks = Locks();
        when(() => manager.client).thenReturn(client);
        when(() => client.userID).thenReturn('@a:test');
        final hidden = Completer<Set<String>>();
        when(() => preferences.getHiddenChatIdsStrict())
            .thenAnswer((_) => hidden.future);
        final repo = SearchRepositoryImpl(
          source,
          manager,
          preferences: preferences,
          chatLockService: locks,
        );
        final pending = groups
            ? repo.searchGroups('secret')
            : repo.searchConversations('secret');
        when(() => client.userID).thenReturn('@b:test');
        hidden.complete({});
        expect(await pending, isEmpty);
        verifyNever(() => locks.getLockedChatIdsStrict());
        verifyNever(() => source.searchLocalGroups(any()));
        verifyNever(() => source.searchLocalConversations(any()));
      },
    );
  }
  test(
    'room response does not resolve metadata through a replacement client',
    () async {
      final manager = Manager();
      final client = Client();
      final source = Source();
      when(() => manager.client).thenReturn(client);
      when(() => client.userID).thenReturn('@a:test');
      final events = Completer<List<matrix.Event>>();
      when(() => source.searchMessagesInRoom('room', 'secret', limit: 50))
          .thenAnswer((_) => events.future);
      final repo = SearchRepositoryImpl(source, manager);
      final pending = repo.searchMessages('secret', roomId: 'room');
      when(() => client.userID).thenReturn('@b:test');
      events.complete([]);
      expect(await pending, isEmpty);
      verifyNever(() => client.getRoomById(any()));
    },
  );
  const stages = ['history', 'contacts', 'groups', 'conversations', 'messages'];
  for (final stage in stages) {
    for (final field in ['user', 'token', 'device', 'server', 'client']) {
      test('stops after $stage when $field changes', () async {
        final manager = Manager();
        final original = Client();
        matrix.Client client = original;
        var user = '@a:example.org';
        var token = 'test';
        var device = 'one';
        var server = Uri.parse('https://example.org');
        when(() => manager.client).thenAnswer((_) => client);
        when(() => original.userID).thenAnswer((_) => user);
        when(() => original.accessToken).thenAnswer((_) => token);
        when(() => original.deviceID).thenAnswer((_) => device);
        when(() => original.homeserver).thenAnswer((_) => server);
        final repo = StagedRepository(Source(), manager, stage);
        final pending = repo.searchGlobal('secret');
        await repo.entered.future;
        switch (field) {
          case 'user':
            user = '@b:example.org';
          case 'token':
            token = 'replacement';
          case 'device':
            device = 'two';
          case 'server':
            server = Uri.parse('https://other.example.org');
          case 'client':
            client = Client();
        }
        repo.gate.complete();
        expect((await pending).isEmpty, isTrue);
        expect(repo.calls, stages.take(stages.indexOf(stage) + 1).toList());
      });
    }
  }
  test('unchanged session retains all categories', () async {
    final manager = Manager();
    final repo = StagedRepository(Source(), manager, 'messages');
    final pending = repo.searchGlobal('query');
    await repo.entered.future;
    repo.gate.complete();
    final result = await pending;
    expect(result.contacts.single.id, 'contacts');
    expect(result.groups.single.id, 'groups');
    expect(result.conversations.single.id, 'conversations');
    expect(result.messages.single.id, 'messages');
  });
}
