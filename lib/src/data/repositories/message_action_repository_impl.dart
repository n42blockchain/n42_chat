import '../../domain/entities/message_entity.dart';
import '../../domain/entities/message_reaction_entity.dart';
import '../../domain/repositories/message_action_repository.dart';
import '../datasources/matrix/matrix_client_manager.dart';
import '../datasources/matrix/matrix_reaction_datasource.dart';

/// 消息操作仓库实现
class MessageActionRepositoryImpl implements IMessageActionRepository {
  final MatrixReactionDataSource _reactionDataSource;
  final MatrixClientManager _clientManager;

  // 本地收藏消息存储（实际应用中应该使用数据库）
  final List<MessageEntity> _savedMessages = [];

  MessageActionRepositoryImpl(
    this._reactionDataSource,
    this._clientManager,
  );

  @override
  Future<void> addReaction(String roomId, String eventId, String emoji) async {
    await _reactionDataSource.addReaction(roomId, eventId, emoji);
  }

  @override
  Future<void> removeReaction(String roomId, String eventId, String emoji) async {
    await _reactionDataSource.removeReaction(roomId, eventId, emoji);
  }

  @override
  Future<void> toggleReaction(String roomId, String eventId, String emoji) async {
    final reactions = await _reactionDataSource.getReactions(roomId, eventId);
    final currentUserId = _clientManager.client?.userID;

    if (currentUserId == null) return;

    final hasReacted = reactions[emoji]?.contains(currentUserId) ?? false;

    if (hasReacted) {
      await removeReaction(roomId, eventId, emoji);
    } else {
      await addReaction(roomId, eventId, emoji);
    }
  }

  @override
  Future<List<MessageReactionEntity>> getReactions(
    String roomId,
    String eventId,
  ) async {
    final reactionsMap = await _reactionDataSource.getReactions(roomId, eventId);
    final client = _clientManager.client;
    final room = client?.getRoomById(roomId);

    final reactions = <MessageReactionEntity>[];

    for (final entry in reactionsMap.entries) {
      final emoji = entry.key;
      final userIds = entry.value;

      // 获取用户名
      final userNames = userIds.map((userId) {
        if (room != null) {
          final user = room.unsafeGetUserFromMemoryOrFallback(userId);
          return user.calcDisplayname();
        }
        return userId;
      }).toList();

      reactions.add(MessageReactionEntity(
        emoji: emoji,
        userIds: userIds,
        userNames: userNames,
      ));
    }

    return reactions;
  }

  @override
  Future<MessageEntity?> replyToMessage(
    String roomId,
    String originalEventId,
    String content,
  ) async {
    final eventId = await _reactionDataSource.sendReply(
      roomId,
      originalEventId,
      content,
    );

    if (eventId == null) return null;

    // 返回新创建的消息实体
    return MessageEntity(
      id: eventId,
      roomId: roomId,
      senderId: _clientManager.client?.userID ?? '',
      senderName: '',
      content: content,
      timestamp: DateTime.now(),
      type: MessageType.text,
      status: MessageStatus.sending,
      replyToId: originalEventId,
    );
  }

  @override
  Future<MessageEntity?> editMessage(
    String roomId,
    String originalEventId,
    String newContent,
  ) async {
    final eventId = await _reactionDataSource.editMessage(
      roomId,
      originalEventId,
      newContent,
    );

    if (eventId == null) return null;

    return MessageEntity(
      id: eventId,
      roomId: roomId,
      senderId: _clientManager.client?.userID ?? '',
      senderName: '',
      content: newContent,
      timestamp: DateTime.now(),
      type: MessageType.text,
      status: MessageStatus.sending,
      isEdited: true,
    );
  }

  @override
  bool canEdit(String roomId, String senderId) {
    return _reactionDataSource.canEdit(roomId, senderId);
  }

  @override
  Future<void> redactMessage(
    String roomId,
    String eventId, {
    String? reason,
  }) async {
    await _reactionDataSource.redactMessage(roomId, eventId, reason: reason);
  }

  @override
  bool canRedact(String roomId, String senderId) {
    return _reactionDataSource.canRedact(roomId, senderId);
  }

  @override
  Future<MessageEntity?> forwardMessage(
    String fromRoomId,
    String eventId,
    String toRoomId,
  ) async {
    final newEventId = await _reactionDataSource.forwardMessage(
      fromRoomId,
      eventId,
      toRoomId,
    );

    if (newEventId == null) return null;

    return MessageEntity(
      id: newEventId,
      roomId: toRoomId,
      senderId: _clientManager.client?.userID ?? '',
      senderName: '',
      content: '',
      timestamp: DateTime.now(),
      type: MessageType.text,
      status: MessageStatus.sending,
    );
  }

  @override
  Future<Map<String, bool>> forwardToMultipleRooms(
    String fromRoomId,
    String eventId,
    List<String> toRoomIds,
  ) async {
    final results = <String, bool>{};

    for (final toRoomId in toRoomIds) {
      try {
        await forwardMessage(fromRoomId, eventId, toRoomId);
        results[toRoomId] = true;
      } catch (e) {
        results[toRoomId] = false;
      }
    }

    return results;
  }

  @override
  Future<void> saveMessage(MessageEntity message) async {
    if (!_savedMessages.any((m) => m.id == message.id)) {
      _savedMessages.add(message);
    }
  }

  @override
  Future<void> unsaveMessage(String messageId) async {
    _savedMessages.removeWhere((m) => m.id == messageId);
  }

  @override
  Future<List<MessageEntity>> getSavedMessages() async {
    return List.unmodifiable(_savedMessages);
  }

  @override
  Future<bool> isMessageSaved(String messageId) async {
    return _savedMessages.any((m) => m.id == messageId);
  }
}

