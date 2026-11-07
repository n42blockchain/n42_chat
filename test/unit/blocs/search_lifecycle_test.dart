import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/search_result_entity.dart';
import 'package:n42_chat/src/domain/repositories/search_repository.dart';
import 'package:n42_chat/src/presentation/blocs/search/search_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/search/search_event.dart';
import 'package:n42_chat/src/presentation/blocs/search/search_state.dart';

class Repository extends Mock implements ISearchRepository {}

Future<void> settle() =>
    Future<void>.delayed(const Duration(milliseconds: 350));
void main() {
  late Repository repo;
  late SearchBloc bloc;
  setUp(() {
    repo = Repository();
    when(() => repo.getRecentSearches()).thenAnswer((_) async => []);
    bloc = SearchBloc(repo);
  });
  tearDown(() async {
    if (!bloc.isClosed) await bloc.close();
  });
  for (final fail in [false, true]) {
    test('clear prevents old global completion failure=$fail', () async {
      final pending = Completer<SearchResults>();
      when(() => repo.searchGlobal('old', type: null))
          .thenAnswer((_) => pending.future);
      bloc.add(const PerformSearch('old'));
      await settle();
      expect(bloc.state, isA<SearchLoading>());
      bloc.add(const ClearSearch());
      await settle();
      if (fail) {
        pending.completeError(StateError('old'));
      } else {
        pending.complete(const SearchResults(query: 'old'));
      }
      await settle();
      expect(bloc.state, isA<SearchInitial>());
    });
    test(
      'global request supersedes old room completion failure=$fail',
      () async {
        final pending = Completer<ChatSearchResults>();
        when(() => repo.searchInChat('room', 'old'))
            .thenAnswer((_) => pending.future);
        when(() => repo.searchGlobal('new', type: null))
            .thenAnswer((_) async => const SearchResults(query: 'new'));
        bloc.add(const SearchInChat('room', 'old'));
        await settle();
        bloc.add(const PerformSearch('new'));
        await settle();
        if (fail) {
          pending.completeError(StateError('old'));
        } else {
          pending.complete(
            const ChatSearchResults(roomId: 'room', query: 'old'),
          );
        }
        await settle();
        expect((bloc.state as SearchLoaded).results.query, 'new');
      },
    );
  }
  test('clear invalidates a debounced request', () async {
    bloc.add(const PerformSearch('old'));
    bloc.add(const ClearSearch());
    await settle();
    expect(bloc.state, isA<SearchInitial>());
    verifyNever(() => repo.searchGlobal('old', type: null));
  });
  test('old history cannot replace newer results', () async {
    final history = Completer<List<String>>();
    when(() => repo.getRecentSearches()).thenAnswer((_) => history.future);
    bloc.add(const LoadSearchHistory());
    await Future<void>.delayed(Duration.zero);
    when(() => repo.searchInChat('room', 'new')).thenAnswer(
      (_) async => const ChatSearchResults(roomId: 'room', query: 'new'),
    );
    bloc.add(const SearchInChat('room', 'new'));
    await settle();
    history.complete(['old']);
    await settle();
    expect((bloc.state as ChatSearchState).results.query, 'new');
  });
  test('paging is single flight and cannot revive cleared results', () async {
    const initial = ChatSearchResults(
      roomId: 'room',
      query: 'q',
      hasMore: true,
    );
    final pending = Completer<ChatSearchResults>();
    when(() => repo.searchInChat('room', 'q')).thenAnswer((_) async => initial);
    when(() => repo.loadMoreChatSearchResults(initial))
        .thenAnswer((_) => pending.future);
    bloc.add(const SearchInChat('room', 'q'));
    await settle();
    bloc.add(const LoadMoreChatResults());
    bloc.add(const LoadMoreChatResults());
    await Future<void>.delayed(Duration.zero);
    verify(() => repo.loadMoreChatSearchResults(initial)).called(1);
    bloc.add(const ClearSearch());
    await settle();
    pending.complete(
      const ChatSearchResults(roomId: 'room', query: 'old-page'),
    );
    await settle();
    expect(bloc.state, isA<SearchInitial>());
  });
  test('clear removes visible results before history lookup settles', () async {
    when(() => repo.searchGlobal('old', type: null))
        .thenAnswer((_) async => const SearchResults(query: 'old'));
    bloc.add(const PerformSearch('old'));
    await settle();
    expect(bloc.state, isA<SearchLoaded>());
    final history = Completer<List<String>>();
    when(() => repo.getRecentSearches()).thenAnswer((_) => history.future);
    bloc.add(const ClearSearch());
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state, isA<SearchInitial>());
    history.completeError(StateError('disk failure'));
    await settle();
    expect(bloc.state, isA<SearchError>());
  });
  for (final clear in [false, true]) {
    for (final fail in [false, true]) {
      test(
        'stale history mutation clear=$clear failure=$fail preserves new search',
        () async {
          final pending = Completer<void>();
          when(() => repo.deleteSearchQuery('old'))
              .thenAnswer((_) => pending.future);
          when(() => repo.clearSearchHistory())
              .thenAnswer((_) => pending.future);
          bloc.add(
            clear
                ? const ClearSearchHistory()
                : const DeleteSearchHistoryItem('old'),
          );
          await Future<void>.delayed(Duration.zero);
          when(() => repo.searchGlobal('new', type: null))
              .thenAnswer((_) async => const SearchResults(query: 'new'));
          when(() => repo.getRecentSearches()).thenAnswer((_) async => ['new']);
          bloc.add(const PerformSearch('new'));
          await settle();
          when(() => repo.getRecentSearches())
              .thenAnswer((_) async => ['stale']);
          if (fail) {
            pending.completeError(StateError('old failure'));
          } else {
            pending.complete();
          }
          await settle();
          final state = bloc.state as SearchLoaded;
          expect(state.results.query, 'new');
          expect(state.recentSearches, ['new']);
        },
      );
    }
  }
  test('delayed history read cannot restore cleared history', () async {
    final history = Completer<List<String>>();
    when(() => repo.getRecentSearches()).thenAnswer((_) => history.future);
    when(() => repo.clearSearchHistory()).thenAnswer((_) async {});
    bloc.add(const LoadSearchHistory());
    await Future<void>.delayed(Duration.zero);
    bloc.add(const ClearSearchHistory());
    await Future<void>.delayed(Duration.zero);
    history.complete(['deleted']);
    await settle();
    expect((bloc.state as SearchInitial).recentSearches, isEmpty);
  });
}
