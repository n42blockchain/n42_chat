import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n42_chat/src/data/datasources/local/chat_history_clear_store.dart';
import 'package:n42_chat/src/domain/entities/search_result_entity.dart';
import 'package:n42_chat/src/domain/repositories/search_repository.dart';
import 'package:n42_chat/src/presentation/blocs/search/search_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/search/search_event.dart';
import 'package:n42_chat/src/presentation/blocs/search/search_state.dart';

class Repository extends Mock implements ISearchRepository {}

Future<void> settle() =>
    Future<void>.delayed(const Duration(milliseconds: 350));
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Repository repo;
  late StreamController<void> changes;
  late SearchBloc bloc;
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    repo = Repository();
    changes = StreamController<void>.broadcast(sync: true);
    when(() => repo.getRecentSearches()).thenAnswer((_) async => ['private']);
    when(() => repo.searchGlobal('secret', type: null))
        .thenAnswer((_) async => const SearchResults(query: 'secret'));
    bloc = SearchBloc(repo, invalidationStreams: [changes.stream]);
  });
  tearDown(() async {
    await bloc.close();
    await changes.close();
  });
  test('invalidation clears visible results without reading another account history', () async {
    bloc.add(const PerformSearch('secret'));
    await settle();
    expect(bloc.state, isA<SearchLoaded>());
    clearInteractions(repo);
    changes.add(null);
    await pumpEventQueue();
    expect(bloc.state, const SearchInitial());
    verifyNever(() => repo.getRecentSearches());
  });
  for (final fail in [false, true]) {
    test('invalidation rejects pending result failure=$fail', () async {
      final gate = Completer<SearchResults>();
      when(() => repo.searchGlobal('secret', type: null))
          .thenAnswer((_) => gate.future);
      bloc.add(const PerformSearch('secret'));
      await settle();
      changes.add(null);
      await pumpEventQueue();
      if (fail) {
        gate.completeError(StateError('old session'));
      } else {
        gate.complete(const SearchResults(query: 'old'));
      }
      await pumpEventQueue();
      expect(bloc.state, const SearchInitial());
      verifyNever(() => repo.getRecentSearches());
    });
  }
  test(
    'invalidation cancels queued debounce and close releases listener',
    () async {
      bloc.add(const PerformSearch('secret'));
      changes.add(null);
      await settle();
      verifyNever(() => repo.searchGlobal('secret', type: null));
      expect(changes.hasListener, isTrue);
      await bloc.close();
      expect(changes.hasListener, isFalse);
      changes.add(null);
    },
  );
  test(
    'durable clear from another store invalidates only the selected owner',
    () async {
      await bloc.close();
      final store = ChatHistoryClearStore();
      bloc = SearchBloc(
        repo,
        invalidationStreams: [
          store.changedOwners
              .where((owner) => owner == '@a:test')
              .map<void>((_) {}),
        ],
      );
      bloc.add(const PerformSearch('secret'));
      await settle();
      await ChatHistoryClearStore().clearThrough(
        ownerUserId: '@b:test',
        roomId: 'room',
        boundary: DateTime.now(),
        isCurrent: () => true,
      );
      await pumpEventQueue();
      expect(bloc.state, isA<SearchLoaded>());
      await ChatHistoryClearStore().clearThrough(
        ownerUserId: '@a:test',
        roomId: 'room',
        boundary: DateTime.now(),
        isCurrent: () => true,
      );
      await pumpEventQueue();
      expect(bloc.state, const SearchInitial());
    },
  );
  test('stream error clears visible private results', () async {
    bloc.add(const PerformSearch('secret'));
    await settle();
    expect(bloc.state, isA<SearchLoaded>());
    clearInteractions(repo);
    changes.addError(StateError('session observer failed'));
    await pumpEventQueue();
    expect(bloc.state, const SearchInitial());
    verifyNever(() => repo.getRecentSearches());
  });

  test(
    'stream error cancels pending search before its late completion',
    () async {
      final gate = Completer<SearchResults>();
      when(() => repo.searchGlobal('secret', type: null))
          .thenAnswer((_) => gate.future);
      bloc.add(const PerformSearch('secret'));
      await settle();
      changes.addError(StateError('session observer failed'));
      await pumpEventQueue();
      gate.complete(const SearchResults(query: 'old private result'));
      await pumpEventQueue();
      expect(bloc.state, const SearchInitial());
      verifyNever(() => repo.getRecentSearches());
    },
  );

  test('new search still works after invalidation', () async {
    changes.add(null);
    await pumpEventQueue();
    bloc.add(const PerformSearch('secret'));
    await settle();
    expect((bloc.state as SearchLoaded).results.query, 'secret');
  });
}
