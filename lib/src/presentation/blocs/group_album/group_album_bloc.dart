import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/group_album_entity.dart';
import 'group_album_event.dart';
import 'group_album_state.dart';

/// 群相册 BLoC
class GroupAlbumBloc extends Bloc<GroupAlbumEvent, GroupAlbumState> {
  // TODO: add IMessageRepository dependency when getRoomMedia is implemented

  GroupAlbumBloc() : super(GroupAlbumState.initial()) {
    on<LoadGroupAlbum>(_onLoadGroupAlbum);
    on<LoadMoreAlbum>(_onLoadMoreAlbum);
    on<ChangeAlbumFilter>(_onChangeAlbumFilter);
    on<RefreshGroupAlbum>(_onRefreshGroupAlbum);
  }

  Future<void> _onLoadGroupAlbum(
    LoadGroupAlbum event,
    Emitter<GroupAlbumState> emit,
  ) async {
    emit(state.copyWith(
      roomId: event.roomId,
      isLoading: true,
      clearError: true,
    ));

    // TODO: implement getRoomMedia in IMessageRepository
    emit(state.copyWith(
      media: [],
      dateGroups: [],
      stats: const GroupAlbumStats(),
      isLoading: false,
      hasMore: false,
    ));
  }

  Future<void> _onLoadMoreAlbum(
    LoadMoreAlbum event,
    Emitter<GroupAlbumState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore || state.roomId == null) return;

    emit(state.copyWith(isLoadingMore: true));

    // TODO: implement getRoomMedia in IMessageRepository for pagination
    emit(state.copyWith(
      isLoadingMore: false,
      hasMore: false,
    ));
  }

  void _onChangeAlbumFilter(
    ChangeAlbumFilter event,
    Emitter<GroupAlbumState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _onRefreshGroupAlbum(
    RefreshGroupAlbum event,
    Emitter<GroupAlbumState> emit,
  ) async {
    if (state.roomId == null) return;
    add(LoadGroupAlbum(roomId: state.roomId!));
  }
}
