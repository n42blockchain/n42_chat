import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/message_action_repository.dart';
import '../../../domain/entities/saved_message_favorite.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';
import '../../../core/utils/debug_log.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final IMessageActionRepository _repository;

  FavoriteBloc({required IMessageActionRepository repository})
    : _repository = repository,
      super(const FavoriteState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<SearchFavorites>(_onSearchFavorites);
    on<DeleteFavorite>(_onDeleteFavorite);
    on<EditFavoriteTags>(_onEditFavoriteTags);
    on<EditFavoriteRemark>(_onEditFavoriteRemark);
    on<ChangeFavoriteFilter>(_onChangeFavoriteFilter);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final repository = _repository;
      final entries = repository is IFavoriteDetailsRepository
          ? await (repository as IFavoriteDetailsRepository)
                .getSavedMessageFavorites()
          : null;
      final favorites = entries == null
          ? await repository.getSavedMessages()
          : entries.map((entry) => entry.message).toList();
      emit(
        state.copyWith(
          favorites: favorites,
          details: Map<String, SavedMessageFavorite>.unmodifiable({
            for (final entry in entries ?? <SavedMessageFavorite>[])
              entry.message.id: entry,
          }),
          isLoading: false,
          filterType: event.filterType,
        ),
      );
    } catch (e) {
      debugLog('FavoriteBloc: Failed to load favorites: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onSearchFavorites(SearchFavorites event, Emitter<FavoriteState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  Future<void> _onDeleteFavorite(
    DeleteFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      await _repository.unsaveMessage(event.favoriteId);
      final updated = state.favorites
          .where((f) => f.id != event.favoriteId)
          .toList();
      emit(
        state.copyWith(
          favorites: updated,
          details: Map.unmodifiable(
            {...state.details}..remove(event.favoriteId),
          ),
        ),
      );
    } catch (e) {
      debugLog('FavoriteBloc: Failed to delete favorite: $e');
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onEditFavoriteTags(
    EditFavoriteTags event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      await _repository.editFavoriteTags(event.favoriteId, event.tags);
      // 重新加载
      add(LoadFavorites(filterType: state.filterType));
    } catch (e) {
      debugLog('FavoriteBloc: Failed to edit tags: $e');
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onEditFavoriteRemark(
    EditFavoriteRemark event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      await _repository.editFavoriteRemark(event.favoriteId, event.remark);
      // 重新加载
      add(LoadFavorites(filterType: state.filterType));
    } catch (e) {
      debugLog('FavoriteBloc: Failed to edit remark: $e');
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onChangeFavoriteFilter(
    ChangeFavoriteFilter event,
    Emitter<FavoriteState> emit,
  ) {
    emit(state.copyWith(filterType: event.filterType));
  }
}
