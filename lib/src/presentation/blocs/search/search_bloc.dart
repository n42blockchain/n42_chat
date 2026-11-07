import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/search_result_entity.dart';
import '../../../domain/repositories/search_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

/// 搜索BLoC
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ISearchRepository _searchRepository;

  SearchBloc(this._searchRepository) : super(const SearchInitial()) {
    on<PerformSearch>(
      _onPerformSearch,
      transformer: _debounce(const Duration(milliseconds: 300)),
    );
    on<SearchContacts>(_onSearchContacts);
    on<SearchGroups>(_onSearchGroups);
    on<SearchMessages>(_onSearchMessages);
    on<ClearSearch>(_onClearSearch);
    on<LoadSearchHistory>(_onLoadSearchHistory);
    on<DeleteSearchHistoryItem>(_onDeleteSearchHistoryItem);
    on<ClearSearchHistory>(_onClearSearchHistory);
    on<ChangeSearchType>(_onChangeSearchType);
    on<SearchInChat>(
      _onSearchInChat,
      transformer: _debounce(const Duration(milliseconds: 300)),
    );
    on<NavigateToNextResult>(_onNavigateToNextResult);
    on<NavigateToPreviousResult>(_onNavigateToPreviousResult);
    on<NavigateToResultIndex>(_onNavigateToResultIndex);
    on<LoadMoreChatResults>(_onLoadMoreChatResults);
  }

  int _generation = 0;
  int _historyRevision = 0;
  final Expando<int> _eventGenerations = Expando<int>();
  final Expando<int> _historyRevisions = Expando<int>();

  @override
  void onEvent(SearchEvent event) {
    if (event is PerformSearch ||
        event is SearchInChat ||
        event is SearchContacts ||
        event is SearchGroups ||
        event is SearchMessages ||
        event is ClearSearch ||
        event is LoadSearchHistory) {
      _generation++;
    }
    if (event is DeleteSearchHistoryItem || event is ClearSearchHistory) {
      _historyRevision++;
    }
    _eventGenerations[event] = _generation;
    _historyRevisions[event] = _historyRevision;
    super.onEvent(event);
  }

  bool _isCurrent(
    SearchEvent event,
    Emitter<SearchState> emit,
    int generation,
  ) =>
      !isClosed &&
      !emit.isDone &&
      generation == _generation &&
      _eventGenerations[event] == generation;

  @override
  Future<void> close() {
    _generation++;
    return super.close();
  }

  /// 防抖转换器
  EventTransformer<T> _debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  Future<void> _onPerformSearch(
    PerformSearch event,
    Emitter<SearchState> emit,
  ) async {
    final generation = _eventGenerations[event] ?? _generation;
    bool current() => _isCurrent(event, emit, generation);
    if (!current()) return;

    final query = event.query.trim();

    if (query.isEmpty) {
      final history = await _searchRepository.getRecentSearches();
      if (!current()) return;
      emit(SearchInitial(recentSearches: history));
      return;
    }

    emit(SearchLoading(query, type: event.type));

    try {
      final results = event.filter == null || event.filter!.isEmpty
          ? await _searchRepository.searchGlobal(query, type: event.type)
          : await _searchRepository.searchGlobal(
              query,
              type: event.type,
              filter: event.filter,
            );
      if (!current()) return;
      final history = await _searchRepository.getRecentSearches();

      if (!current()) return;
      emit(
        SearchLoaded(
          results: results,
          selectedType: event.type ?? SearchResultType.all,
          recentSearches: history,
        ),
      );
    } catch (e) {
      if (!current()) return;
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onSearchContacts(
    SearchContacts event,
    Emitter<SearchState> emit,
  ) async {
    if (_eventGenerations[event] != _generation || emit.isDone) return;

    add(PerformSearch(event.query, type: SearchResultType.contact));
  }

  Future<void> _onSearchGroups(
    SearchGroups event,
    Emitter<SearchState> emit,
  ) async {
    if (_eventGenerations[event] != _generation || emit.isDone) return;

    add(PerformSearch(event.query, type: SearchResultType.group));
  }

  Future<void> _onSearchMessages(
    SearchMessages event,
    Emitter<SearchState> emit,
  ) async {
    if (_eventGenerations[event] != _generation || emit.isDone) return;

    if (event.roomId != null) {
      add(SearchInChat(event.roomId!, event.query, filter: event.filter));
    } else {
      add(
        PerformSearch(
          event.query,
          type: SearchResultType.message,
          filter: event.filter,
        ),
      );
    }
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) async {
    final generation = _eventGenerations[event] ?? _generation;
    bool current() => _isCurrent(event, emit, generation);
    if (!current()) return;

    if (state is! SearchInitial ||
        (state as SearchInitial).recentSearches.isNotEmpty) {
      emit(const SearchInitial());
    }
    final revision = _historyRevisions[event] ?? _historyRevision;
    try {
      final history = await _searchRepository.getRecentSearches();
      if (!current() || revision != _historyRevision) return;
      emit(SearchInitial(recentSearches: history));
    } catch (error) {
      if (current() && revision == _historyRevision) {
        emit(SearchError(error.toString()));
      }
    }
  }

  Future<void> _onLoadSearchHistory(
    LoadSearchHistory event,
    Emitter<SearchState> emit,
  ) async {
    final generation = _eventGenerations[event] ?? _generation;
    bool current() => _isCurrent(event, emit, generation);
    if (!current()) return;

    final revision = _historyRevisions[event] ?? _historyRevision;
    try {
      final history = await _searchRepository.getRecentSearches();
      if (!current() || revision != _historyRevision) return;
      emit(SearchInitial(recentSearches: history));
    } catch (error) {
      if (current() && revision == _historyRevision) {
        emit(SearchError(error.toString()));
      }
    }
  }

  Future<void> _onDeleteSearchHistoryItem(
    DeleteSearchHistoryItem event,
    Emitter<SearchState> emit,
  ) async {
    final generation = _eventGenerations[event] ?? _generation;
    final revision = _historyRevisions[event] ?? _historyRevision;
    bool current() =>
        _isCurrent(event, emit, generation) && revision == _historyRevision;
    try {
      await _searchRepository.deleteSearchQuery(event.query);
      final history = await _searchRepository.getRecentSearches();

      if (!current()) return;
      if (state is SearchInitial) {
        emit(SearchInitial(recentSearches: history));
      } else if (state is SearchLoaded) {
        emit((state as SearchLoaded).copyWith(recentSearches: history));
      }
    } catch (error) {
      if (current()) emit(SearchError(error.toString()));
    }
  }

  Future<void> _onClearSearchHistory(
    ClearSearchHistory event,
    Emitter<SearchState> emit,
  ) async {
    final generation = _eventGenerations[event] ?? _generation;
    final revision = _historyRevisions[event] ?? _historyRevision;
    bool current() =>
        _isCurrent(event, emit, generation) && revision == _historyRevision;
    try {
      await _searchRepository.clearSearchHistory();

      if (!current()) return;
      if (state is SearchInitial) {
        emit(const SearchInitial());
      } else if (state is SearchLoaded) {
        emit((state as SearchLoaded).copyWith(recentSearches: []));
      }
    } catch (error) {
      if (current()) emit(SearchError(error.toString()));
    }
  }

  void _onChangeSearchType(ChangeSearchType event, Emitter<SearchState> emit) {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      emit(currentState.copyWith(selectedType: event.type));
    }
  }

  Future<void> _onSearchInChat(
    SearchInChat event,
    Emitter<SearchState> emit,
  ) async {
    final generation = _eventGenerations[event] ?? _generation;
    bool current() => _isCurrent(event, emit, generation);
    if (!current()) return;

    final query = event.query.trim();

    if (query.isEmpty) {
      if (!current()) return;
      emit(ChatSearchState(results: ChatSearchResults(roomId: event.roomId)));
      return;
    }

    emit(
      ChatSearchState(
        results: ChatSearchResults(
          roomId: event.roomId,
          query: query,
          filter: event.filter == null || event.filter!.isEmpty
              ? null
              : event.filter,
        ),
        isSearching: true,
      ),
    );

    try {
      final results = event.filter == null || event.filter!.isEmpty
          ? await _searchRepository.searchInChat(event.roomId, query)
          : await _searchRepository.searchInChat(
              event.roomId,
              query,
              filter: event.filter,
            );
      if (!current()) return;
      emit(ChatSearchState(results: results));
    } catch (e) {
      if (!current()) return;
      emit(SearchError(e.toString()));
    }
  }

  void _onNavigateToNextResult(
    NavigateToNextResult event,
    Emitter<SearchState> emit,
  ) {
    if (state is ChatSearchState) {
      final currentState = state as ChatSearchState;
      if (currentState.results.hasNext) {
        emit(
          currentState.copyWith(
            results: currentState.results.copyWith(
              currentIndex: currentState.results.currentIndex + 1,
            ),
          ),
        );
      }
    }
  }

  void _onNavigateToPreviousResult(
    NavigateToPreviousResult event,
    Emitter<SearchState> emit,
  ) {
    if (state is ChatSearchState) {
      final currentState = state as ChatSearchState;
      if (currentState.results.hasPrevious) {
        emit(
          currentState.copyWith(
            results: currentState.results.copyWith(
              currentIndex: currentState.results.currentIndex - 1,
            ),
          ),
        );
      }
    }
  }

  void _onNavigateToResultIndex(
    NavigateToResultIndex event,
    Emitter<SearchState> emit,
  ) {
    if (state is ChatSearchState) {
      final currentState = state as ChatSearchState;
      if (event.index >= 0 && event.index < currentState.results.totalCount) {
        emit(
          currentState.copyWith(
            results: currentState.results.copyWith(currentIndex: event.index),
          ),
        );
      }
    }
  }

  Future<void> _onLoadMoreChatResults(
    LoadMoreChatResults event,
    Emitter<SearchState> emit,
  ) async {
    final generation = _eventGenerations[event] ?? _generation;
    bool current() => _isCurrent(event, emit, generation);
    if (!current()) return;

    if (state is! ChatSearchState) return;

    final currentState = state as ChatSearchState;
    if (currentState.isSearching || !currentState.results.hasMore) return;

    emit(currentState.copyWith(isSearching: true));

    try {
      final results = await _searchRepository.loadMoreChatSearchResults(
        currentState.results,
      );
      if (!current()) return;
      emit(ChatSearchState(results: results));
    } catch (e) {
      if (!current()) return;
      emit(currentState.copyWith(isSearching: false));
    }
  }
}
