import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/repositories/conversation_repository.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';

/// 会话列表BLoC
class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final IConversationRepository _conversationRepository;

  StreamSubscription<List<ConversationEntity>>? _conversationsSubscription;

  ConversationBloc({
    required IConversationRepository conversationRepository,
  })  : _conversationRepository = conversationRepository,
        super(ConversationState.initial()) {
    on<LoadConversations>(_onLoadConversations);
    on<RefreshConversations>(_onRefreshConversations);
    on<SubscribeConversations>(_onSubscribeConversations);
    on<UnsubscribeConversations>(_onUnsubscribeConversations);
    on<SearchConversations>(_onSearchConversations);
    on<ClearSearch>(_onClearSearch);
    on<SetConversationMuted>(_onSetMuted);
    on<SetConversationPinned>(_onSetPinned);
    on<MarkConversationAsRead>(_onMarkAsRead);
    on<DeleteConversation>(_onDeleteConversation);
    on<CreateDirectChat>(_onCreateDirectChat);
    on<CreateGroupChat>(_onCreateGroupChat);
    on<ConversationsUpdated>(_onConversationsUpdated);
  }

  @override
  Future<void> close() {
    _conversationsSubscription?.cancel();
    return super.close();
  }

  /// 加载会话列表
  Future<void> _onLoadConversations(
    LoadConversations event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final conversations = await _conversationRepository.getConversations();
      final totalUnread = await _conversationRepository.getTotalUnreadCount();

      final (pinned, normal) = _separateConversations(conversations);

      emit(state.copyWith(
        conversations: conversations,
        pinnedConversations: pinned,
        normalConversations: normal,
        isLoading: false,
        totalUnreadCount: totalUnread,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: '加载会话列表失败: ${e.toString()}',
      ));
    }
  }

  /// 刷新会话列表
  Future<void> _onRefreshConversations(
    RefreshConversations event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true, clearError: true));

    try {
      final conversations = await _conversationRepository.getConversations();
      final totalUnread = await _conversationRepository.getTotalUnreadCount();

      final (pinned, normal) = _separateConversations(conversations);

      emit(state.copyWith(
        conversations: conversations,
        pinnedConversations: pinned,
        normalConversations: normal,
        isRefreshing: false,
        totalUnreadCount: totalUnread,
      ));
    } catch (e) {
      emit(state.copyWith(
        isRefreshing: false,
        error: '刷新失败: ${e.toString()}',
      ));
    }
  }

  /// 订阅会话列表实时更新
  Future<void> _onSubscribeConversations(
    SubscribeConversations event,
    Emitter<ConversationState> emit,
  ) async {
    await _conversationsSubscription?.cancel();

    _conversationsSubscription = _conversationRepository
        .watchConversations()
        .listen((conversations) {
      add(ConversationsUpdated(conversations));
    });
  }

  /// 取消订阅
  Future<void> _onUnsubscribeConversations(
    UnsubscribeConversations event,
    Emitter<ConversationState> emit,
  ) async {
    await _conversationsSubscription?.cancel();
    _conversationsSubscription = null;
  }

  /// 会话列表更新
  void _onConversationsUpdated(
    ConversationsUpdated event,
    Emitter<ConversationState> emit,
  ) {
    final conversations = event.conversations.cast<ConversationEntity>();
    final (pinned, normal) = _separateConversations(conversations);

    final totalUnread = conversations.fold<int>(
      0,
      (sum, conv) => sum + conv.unreadCount,
    );

    emit(state.copyWith(
      conversations: conversations,
      pinnedConversations: pinned,
      normalConversations: normal,
      totalUnreadCount: totalUnread,
    ));
  }

  /// 搜索会话
  Future<void> _onSearchConversations(
    SearchConversations event,
    Emitter<ConversationState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(state.copyWith(
        isSearching: false,
        searchQuery: null,
        clearFilteredConversations: true,
      ));
      return;
    }

    emit(state.copyWith(isSearching: true, searchQuery: query));

    try {
      final results = await _conversationRepository.searchConversations(query);
      emit(state.copyWith(filteredConversations: results));
    } catch (e) {
      emit(state.copyWith(
        error: '搜索失败: ${e.toString()}',
      ));
    }
  }

  /// 清除搜索
  void _onClearSearch(
    ClearSearch event,
    Emitter<ConversationState> emit,
  ) {
    emit(state.copyWith(
      isSearching: false,
      searchQuery: null,
      clearFilteredConversations: true,
    ));
  }

  /// 设置免打扰
  Future<void> _onSetMuted(
    SetConversationMuted event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      await _conversationRepository.setMuted(event.conversationId, event.muted);

      // 乐观更新本地状态
      final updatedConversations = state.conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return conv.copyWith(isMuted: event.muted);
        }
        return conv;
      }).toList();

      final (pinned, normal) = _separateConversations(updatedConversations);

      emit(state.copyWith(
        conversations: updatedConversations,
        pinnedConversations: pinned,
        normalConversations: normal,
      ));
    } catch (e) {
      emit(state.copyWith(error: '设置失败: ${e.toString()}'));
    }
  }

  /// 设置置顶
  Future<void> _onSetPinned(
    SetConversationPinned event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      await _conversationRepository.setPinned(
          event.conversationId, event.pinned);

      // 乐观更新本地状态
      final updatedConversations = state.conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return conv.copyWith(isPinned: event.pinned);
        }
        return conv;
      }).toList();

      final (pinned, normal) = _separateConversations(updatedConversations);

      emit(state.copyWith(
        conversations: updatedConversations,
        pinnedConversations: pinned,
        normalConversations: normal,
      ));
    } catch (e) {
      emit(state.copyWith(error: '设置失败: ${e.toString()}'));
    }
  }

  /// 标记已读
  Future<void> _onMarkAsRead(
    MarkConversationAsRead event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      await _conversationRepository.markAsRead(event.conversationId);

      // 乐观更新本地状态
      final updatedConversations = state.conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return conv.copyWith(unreadCount: 0, highlightCount: 0);
        }
        return conv;
      }).toList();

      final totalUnread = updatedConversations.fold<int>(
        0,
        (sum, conv) => sum + conv.unreadCount,
      );

      emit(state.copyWith(
        conversations: updatedConversations,
        totalUnreadCount: totalUnread,
      ));
    } catch (e) {
      emit(state.copyWith(error: '标记已读失败: ${e.toString()}'));
    }
  }

  /// 删除会话
  Future<void> _onDeleteConversation(
    DeleteConversation event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      await _conversationRepository.deleteConversation(event.conversationId);

      // 从本地状态移除
      final updatedConversations = state.conversations
          .where((conv) => conv.id != event.conversationId)
          .toList();

      final (pinned, normal) = _separateConversations(updatedConversations);

      emit(state.copyWith(
        conversations: updatedConversations,
        pinnedConversations: pinned,
        normalConversations: normal,
      ));
    } catch (e) {
      emit(state.copyWith(error: '删除失败: ${e.toString()}'));
    }
  }

  /// 创建私聊
  Future<void> _onCreateDirectChat(
    CreateDirectChat event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      final conversation =
          await _conversationRepository.createDirectChat(event.userId);

      emit(state.copyWith(newConversationId: conversation.id));

      // 触发刷新
      add(const RefreshConversations());
    } catch (e) {
      emit(state.copyWith(error: '创建会话失败: ${e.toString()}'));
    }
  }

  /// 创建群聊
  Future<void> _onCreateGroupChat(
    CreateGroupChat event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      final conversation = await _conversationRepository.createGroupChat(
        name: event.name,
        topic: event.topic,
        memberIds: event.memberIds,
        encrypted: event.encrypted,
      );

      emit(state.copyWith(newConversationId: conversation.id));

      // 触发刷新
      add(const RefreshConversations());
    } catch (e) {
      emit(state.copyWith(error: '创建群聊失败: ${e.toString()}'));
    }
  }

  /// 分离置顶和普通会话
  (List<ConversationEntity>, List<ConversationEntity>) _separateConversations(
    List<ConversationEntity> conversations,
  ) {
    final pinned = conversations.where((c) => c.isPinned).toList();
    final normal = conversations.where((c) => !c.isPinned).toList();
    return (pinned, normal);
  }
}

