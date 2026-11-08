import 'dart:typed_data';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/message_entity.dart';
import '../../../domain/repositories/message_repository.dart';
import '../../../domain/repositories/thread_pagination_repository.dart';
import 'thread_event.dart';
import 'thread_state.dart';
import '../../../core/utils/debug_log.dart';

/// 消息线程 BLoC
///
/// 独立管理线程消息的加载、发送、订阅。
/// 与 ChatBloc 解耦，避免进一步增加 ChatBloc 复杂度。
class ThreadBloc extends Bloc<ThreadEvent, ThreadState> {
  final IMessageRepository _messageRepository;
  int _generation = 0;
  int _streamRevision = 0;
  int _historyRevision = 0;
  bool _hasLoadedOlderPages = false;
  StreamSubscription<void>? _historyChangesSubscription;
  bool Function()? _threadSessionGuard;

  bool Function() _context(Emitter<ThreadState>? emit) {
    final generation = _generation;
    final sessionGuard = _threadSessionGuard;
    final room = state.roomId;
    final root = state.threadRootEventId;
    return () =>
        !isClosed &&
        !(emit?.isDone ?? false) &&
        (sessionGuard?.call() ?? true) &&
        generation == _generation &&
        state.roomId == room &&
        state.threadRootEventId == root;
  }

  void _detachSubscription() {
    final subscription = _threadMessagesSubscription;
    _threadMessagesSubscription = null;
    final historySubscription = _historyChangesSubscription;
    _historyChangesSubscription = null;
    if (historySubscription != null) {
      unawaited(
        historySubscription.cancel().catchError((Object error) {
          debugLog('ThreadBloc: history listener cleanup failed: $error');
        }),
      );
    }
    if (subscription != null) {
      unawaited(
        subscription.cancel().catchError((Object error) {
          debugLog('ThreadBloc: subscription cleanup failed: $error');
        }),
      );
    }
  }

  StreamSubscription<List<MessageEntity>>? _threadMessagesSubscription;

  ThreadBloc({required IMessageRepository messageRepository})
    : _messageRepository = messageRepository,
      super(ThreadState.initial()) {
    on<InitializeThread>(_onInitializeThread);
    on<LoadThreadMessages>(_onLoadThreadMessages);
    on<LoadMoreThreadMessages>(_onLoadMoreThreadMessages);
    on<SendThreadTextMessage>(_onSendThreadTextMessage);
    on<SendThreadImageMessage>(_onSendThreadImageMessage);
    on<SendThreadFileMessage>(_onSendThreadFileMessage);
    on<SetThreadReplyTarget>(_onSetThreadReplyTarget);
    on<ThreadMessagesUpdated>(_onThreadMessagesUpdated);
    on<DisposeThread>(_onDisposeThread);
  }

  Future<({List<MessageEntity> messages, bool hasMore, String? nextBatch})>
  _loadPage(
    String room,
    String root, {
    String? fromEventId,
    String? fromToken,
  }) async {
    final repository = _messageRepository;
    if (repository is IThreadPaginationRepository) {
      final page = await (repository as IThreadPaginationRepository)
          .getThreadMessagePage(room, root, fromToken: fromToken);
      return (
        messages: page.messages,
        hasMore: page.hasMore,
        nextBatch: page.nextBatch,
      );
    }
    final messages = await repository.getThreadMessages(
      room,
      root,
      limit: 50,
      fromEventId: fromEventId,
    );
    return (
      messages: messages,
      hasMore: messages.length >= 50,
      nextBatch: null,
    );
  }

  Future<void> _onInitializeThread(
    InitializeThread event,
    Emitter<ThreadState> emit,
  ) async {
    if (event.isRetry &&
        (state.isLoading ||
            !_context(emit)() ||
            event.roomId != state.roomId ||
            event.threadRootEventId != state.threadRootEventId)) {
      return;
    }
    _generation++;
    _hasLoadedOlderPages = false;
    _detachSubscription();
    final repository = _messageRepository;
    _threadSessionGuard = repository is IThreadHistoryVisibilityRepository
        ? (repository as IThreadHistoryVisibilityRepository)
              .captureThreadSession()
        : null;
    emit(
      ThreadState(
        isLoading: true,
        roomId: event.roomId,
        threadRootEventId: event.threadRootEventId,
      ),
    );
    final isCurrent = _context(emit);

    try {
      _subscribeToHistoryChanges(event.roomId);
      // 加载线程消息
      final page = await _loadPage(event.roomId, event.threadRootEventId);

      if (!isCurrent()) return;
      final messages = page.messages;
      // 分离根消息和回复
      MessageEntity? rootMessage;
      final replies = <MessageEntity>[];

      for (final msg in messages) {
        if (msg.id == event.threadRootEventId) {
          rootMessage = msg;
        } else {
          replies.add(msg);
        }
      }

      // 如果根消息不在返回结果中，单独获取
      rootMessage ??= await _loadRootMessage(
        event.roomId,
        event.threadRootEventId,
      );

      if (!isCurrent()) return;
      // Root lookup can await after the page was filtered. Revalidate the
      // complete result and repeat if a clear notification arrived meanwhile.
      if (repository is IThreadHistoryVisibilityRepository) {
        final candidates = [if (rootMessage != null) rootMessage, ...replies];
        while (isCurrent()) {
          final revision = _historyRevision;
          final visible =
              await (repository as IThreadHistoryVisibilityRepository)
                  .filterThreadHistory(event.roomId, candidates);
          if (!isCurrent()) return;
          if (revision != _historyRevision) continue;
          rootMessage = null;
          replies.clear();
          for (final message in visible) {
            if (message.id == event.threadRootEventId) {
              rootMessage = message;
            } else {
              replies.add(message);
            }
          }
          break;
        }
      }
      // 计算参与者
      final participantIds = <String>{};
      if (rootMessage != null) participantIds.add(rootMessage.senderId);
      for (final reply in replies) {
        participantIds.add(reply.senderId);
      }

      emit(
        state.copyWith(
          rootMessage: rootMessage,
          replies: replies,
          isLoading: false,
          participantCount: participantIds.length,
          hasMore: page.hasMore,
          nextBatch: page.nextBatch,
          clearNextBatch: page.nextBatch == null,
        ),
      );

      // 订阅线程消息更新
      _subscribeToThreadMessages(event.roomId, event.threadRootEventId);
    } catch (e) {
      if (!isCurrent()) return;
      debugLog('ThreadBloc: Failed to initialize thread: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<MessageEntity?> _loadRootMessage(String roomId, String eventId) async {
    try {
      // 尝试通过 watchMessage 获取根消息
      final stream = _messageRepository.watchMessage(roomId, eventId);
      final msg = await stream.first.timeout(
        const Duration(seconds: 5),
        onTimeout: () => null,
      );
      return msg;
    } catch (e) {
      debugLog('ThreadBloc: Failed to load root message: $e');
      return null;
    }
  }

  void _subscribeToThreadMessages(String roomId, String threadRootEventId) {
    final isCurrent = _context(null);
    _threadMessagesSubscription = _messageRepository
        .watchThreadMessages(roomId, threadRootEventId)
        .listen(
          (messages) {
            if (isCurrent()) {
              add(ThreadMessagesUpdated(messages, isCurrent: isCurrent));
            }
          },
          onError: (Object e) {
            debugLog('ThreadBloc: Thread messages stream error: $e');
          },
        );
  }

  void _subscribeToHistoryChanges(String roomId) {
    final isCurrent = _context(null);
    final repository = _messageRepository;
    if (repository is IThreadHistoryChangesRepository) {
      _historyChangesSubscription =
          (repository as IThreadHistoryChangesRepository)
              .watchThreadHistoryChanges(roomId)
              .listen(
                (_) {
                  if (isCurrent()) {
                    _historyRevision++;
                    add(ThreadMessagesUpdated(const [], isCurrent: isCurrent));
                  }
                },
                onError: (Object error) {
                  debugLog('ThreadBloc: history listener failed: $error');
                },
              );
    }
  }

  Future<void> _onLoadThreadMessages(
    LoadThreadMessages event,
    Emitter<ThreadState> emit,
  ) async {
    if (state.roomId == null ||
        state.threadRootEventId == null ||
        state.isLoading)
      return;

    final isCurrent = _context(emit);
    if (!isCurrent()) return;
    final roomId = state.roomId!;
    final rootId = state.threadRootEventId!;

    final before = {
      if (state.rootMessage != null) state.rootMessage!.id: state.rootMessage!,
      for (final message in state.replies) message.id: message,
    };
    final retainCursor = _hasLoadedOlderPages;
    var checkingVisibility = false;
    emit(state.copyWith(isLoading: true));
    try {
      final page = await _loadPage(roomId, rootId);
      final repository = _messageRepository;
      while (isCurrent()) {
        final snapshot = state;
        final current = [
          if (snapshot.rootMessage != null) snapshot.rootMessage!,
          ...snapshot.replies,
        ];
        final merged = <String, MessageEntity>{
          for (final message in current) message.id: message,
          for (final message in page.messages) message.id: message,
          // Live edits and arrivals after refresh began beat its response.
          for (final message in current)
            if (!identical(before[message.id], message)) message.id: message,
        }.values.toList();
        checkingVisibility = true;
        final visible = repository is IThreadHistoryVisibilityRepository
            ? await (repository as IThreadHistoryVisibilityRepository)
                  .filterThreadHistory(roomId, merged)
            : merged;
        checkingVisibility = false;
        if (!isCurrent()) return;
        // A stream update or clear can complete during the visibility read.
        if (!identical(snapshot, state)) continue;
        final root = visible.where((m) => m.id == rootId).firstOrNull;
        final replies = visible.where((m) => m.id != rootId).toList();
        final order = {
          for (var i = 0; i < replies.length; i++) replies[i].id: i,
        };
        replies.sort((a, b) {
          final time = a.timestamp.compareTo(b.timestamp);
          return time != 0 ? time : order[a.id]!.compareTo(order[b.id]!);
        });
        emit(
          state.copyWith(
            rootMessage: root,
            clearRootMessage: root == null,
            replies: replies,
            participantCount: {
              if (root != null) root.senderId,
              for (final message in replies) message.senderId,
            }.length,
            isLoading: false,
            clearError: true,
            hasMore: retainCursor ? snapshot.hasMore : page.hasMore,
            nextBatch: retainCursor ? snapshot.nextBatch : page.nextBatch,
            clearNextBatch:
                (retainCursor ? snapshot.nextBatch : page.nextBatch) == null,
          ),
        );
        return;
      }
    } catch (e) {
      if (!isCurrent()) return;
      // Hidden pages must be fetched again after a failed visibility check.
      if (checkingVisibility) {
        _hasLoadedOlderPages = false;
      }
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString(),
          clearRootMessage: checkingVisibility,
          replies: checkingVisibility ? const [] : null,
          participantCount: checkingVisibility ? 0 : null,
          clearReplyTarget: checkingVisibility,
        ),
      );
    }
  }

  Future<void> _onLoadMoreThreadMessages(
    LoadMoreThreadMessages event,
    Emitter<ThreadState> emit,
  ) async {
    if (state.roomId == null ||
        state.threadRootEventId == null ||
        !state.hasMore ||
        state.isLoading)
      return;

    final isCurrent = _context(emit);
    if (!isCurrent()) return;
    final roomId = state.roomId!;
    final rootId = state.threadRootEventId!;

    emit(state.copyWith(isLoading: true));
    try {
      final beforeEventId = state.replies.isNotEmpty
          ? state.replies.first.id
          : null;
      final page = await _loadPage(
        roomId,
        rootId,
        fromEventId: beforeEventId,
        fromToken: state.nextBatch,
      );

      if (!isCurrent()) return;
      final messages = page.messages;
      final newReplies = messages
          .where((m) => m.id != state.threadRootEventId)
          .toList();

      _hasLoadedOlderPages = true;
      emit(
        state.copyWith(
          // Current entries win over overlapping older-page data, preserving
          // updates that arrived while the request was in flight.
          replies: {
            for (final message in newReplies) message.id: message,
            for (final message in state.replies) message.id: message,
          }.values.toList(),
          isLoading: false,
          hasMore: page.hasMore,
          nextBatch: page.nextBatch,
          clearNextBatch: page.nextBatch == null,
        ),
      );
    } catch (e) {
      if (!isCurrent()) return;
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSendThreadTextMessage(
    SendThreadTextMessage event,
    Emitter<ThreadState> emit,
  ) async {
    if (state.roomId == null ||
        state.threadRootEventId == null ||
        state.isSending ||
        !(_threadSessionGuard?.call() ?? true)) {
      if (event.completion?.isCompleted == false)
        event.completion!.complete(false);
      return;
    }

    var accepted = false;
    final replyTarget = state.replyTarget;
    final isCurrent = _context(emit);
    if (!isCurrent()) return;
    final roomId = state.roomId!;
    final rootId = state.threadRootEventId!;

    emit(state.copyWith(isSending: true, clearError: true));
    try {
      final receipt = await _messageRepository.sendThreadTextMessage(
        roomId,
        rootId,
        event.text,
      );
      if (!isCurrent()) return;
      if (receipt == null || receipt.id.trim().isEmpty) {
        throw StateError('Thread message was not acknowledged');
      }
      accepted = true;
      emit(
        state.copyWith(
          isSending: false,
          clearReplyTarget: identical(state.replyTarget, replyTarget),
        ),
      );
    } catch (e) {
      if (!isCurrent()) return;
      debugLog('ThreadBloc: Failed to send thread message: $e');
      emit(state.copyWith(isSending: false, error: e.toString()));
    } finally {
      if (event.completion?.isCompleted == false) {
        event.completion!.complete(accepted);
      }
    }
  }

  Future<void> _onSendThreadImageMessage(
    SendThreadImageMessage event,
    Emitter<ThreadState> emit,
  ) async {
    if (state.roomId == null ||
        state.threadRootEventId == null ||
        state.isSending ||
        !(_threadSessionGuard?.call() ?? true)) {
      return;
    }

    final isCurrent = _context(emit);
    if (!isCurrent()) return;
    final roomId = state.roomId!;
    final rootId = state.threadRootEventId!;

    emit(state.copyWith(isSending: true, clearError: true));
    try {
      final receipt = await _messageRepository.sendThreadImageMessage(
        roomId,
        rootId,
        imageBytes: Uint8List.fromList(event.imageBytes),
        filename: event.filename,
        mimeType: event.mimeType,
      );
      if (!isCurrent()) return;
      if (receipt == null || receipt.id.trim().isEmpty) {
        throw StateError('Thread message was not acknowledged');
      }
      emit(state.copyWith(isSending: false));
    } catch (e) {
      if (!isCurrent()) return;
      emit(state.copyWith(isSending: false, error: e.toString()));
    }
  }

  Future<void> _onSendThreadFileMessage(
    SendThreadFileMessage event,
    Emitter<ThreadState> emit,
  ) async {
    if (state.roomId == null ||
        state.threadRootEventId == null ||
        state.isSending ||
        !(_threadSessionGuard?.call() ?? true)) {
      return;
    }

    final isCurrent = _context(emit);
    if (!isCurrent()) return;
    final roomId = state.roomId!;
    final rootId = state.threadRootEventId!;

    emit(state.copyWith(isSending: true, clearError: true));
    try {
      final receipt = await _messageRepository.sendThreadFileMessage(
        roomId,
        rootId,
        fileBytes: Uint8List.fromList(event.fileBytes),
        filename: event.filename,
        mimeType: event.mimeType,
      );
      if (!isCurrent()) return;
      if (receipt == null || receipt.id.trim().isEmpty) {
        throw StateError('Thread message was not acknowledged');
      }
      emit(state.copyWith(isSending: false));
    } catch (e) {
      if (!isCurrent()) return;
      emit(state.copyWith(isSending: false, error: e.toString()));
    }
  }

  void _onSetThreadReplyTarget(
    SetThreadReplyTarget event,
    Emitter<ThreadState> emit,
  ) {
    if (event.target == null) {
      emit(state.copyWith(clearReplyTarget: true));
    } else {
      emit(state.copyWith(replyTarget: event.target));
    }
  }

  Future<void> _onThreadMessagesUpdated(
    ThreadMessagesUpdated event,
    Emitter<ThreadState> emit,
  ) async {
    final isCurrent = _context(emit);
    if (!isCurrent() || (event.isCurrent != null && !event.isCurrent!()))
      return;
    final revision = ++_streamRevision;
    final repository = _messageRepository;
    while (isCurrent() && revision == _streamRevision) {
      final snapshot = state;
      final merged = <String, MessageEntity>{
        if (snapshot.rootMessage != null)
          snapshot.rootMessage!.id: snapshot.rootMessage!,
        for (final message in snapshot.replies) message.id: message,
        for (final message in event.messages) message.id: message,
      }.values.toList();
      List<MessageEntity> visible;
      try {
        visible =
            repository is IThreadHistoryVisibilityRepository &&
                snapshot.roomId != null
            ? await (repository as IThreadHistoryVisibilityRepository)
                  .filterThreadHistory(snapshot.roomId!, merged)
            : merged;
      } catch (error) {
        if (!isCurrent() || revision != _streamRevision) return;
        emit(
          state.copyWith(
            clearRootMessage: true,
            replies: const [],
            clearReplyTarget: true,
            participantCount: 0,
            error: error.toString(),
          ),
        );
        return;
      }
      if (!isCurrent() ||
          revision != _streamRevision ||
          (event.isCurrent != null && !event.isCurrent!()))
        return;
      // A page/send may complete while visibility is read. Rebuild from that
      // newer state rather than losing its messages or resurrecting its root.
      if (!identical(state, snapshot)) continue;
      final root = visible
          .where((m) => m.id == snapshot.threadRootEventId)
          .firstOrNull;
      final replies = visible
          .where((m) => m.id != snapshot.threadRootEventId)
          .toList();
      final order = {for (var i = 0; i < replies.length; i++) replies[i].id: i};
      replies.sort((a, b) {
        final time = a.timestamp.compareTo(b.timestamp);
        return time != 0 ? time : order[a.id]!.compareTo(order[b.id]!);
      });
      final participants = {
        if (root != null) root.senderId,
        for (final reply in replies) reply.senderId,
      };
      emit(
        state.copyWith(
          rootMessage: root,
          clearRootMessage: root == null,
          replies: replies,
          participantCount: participants.length,
        ),
      );
      return;
    }
  }

  void _onDisposeThread(DisposeThread event, Emitter<ThreadState> emit) {
    _generation++;
    _detachSubscription();
    emit(ThreadState.initial());
  }

  @override
  Future<void> close() {
    _generation++;
    _detachSubscription();
    return super.close();
  }
}
