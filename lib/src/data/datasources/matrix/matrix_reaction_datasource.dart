import 'package:matrix/matrix.dart' as matrix;

import 'matrix_client_manager.dart';

/// Matrix消息反应数据源
class MatrixReactionDataSource {
  final MatrixClientManager _clientManager;

  MatrixReactionDataSource(this._clientManager);

  matrix.Client? get _client => _clientManager.client;

  /// 添加emoji反应
  Future<void> addReaction(
    String roomId,
    String eventId,
    String emoji,
  ) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) throw Exception('Room not found');

    // Matrix使用 m.annotation 类型发送反应
    await room.sendEvent({
      'm.relates_to': {
        'rel_type': 'm.annotation',
        'event_id': eventId,
        'key': emoji,
      },
    }, type: 'm.reaction');
  }

  /// 移除emoji反应
  Future<void> removeReaction(
    String roomId,
    String eventId,
    String emoji,
  ) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) throw Exception('Room not found');

    // 查找用户自己的反应事件
    final timeline = await room.getTimeline();
    final currentUserId = _client!.userID;

    for (final event in timeline.events) {
      if (event.type == 'm.reaction' && event.senderId == currentUserId) {
        final relatesTo = event.content['m.relates_to'] as Map<String, dynamic>?;
        if (relatesTo != null &&
            relatesTo['event_id'] == eventId &&
            relatesTo['key'] == emoji) {
          // 撤回反应事件
          await room.redactEvent(event.eventId, reason: 'Remove reaction');
          return;
        }
      }
    }
  }

  /// 获取消息的所有反应
  Future<Map<String, List<String>>> getReactions(
    String roomId,
    String eventId,
  ) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return {};

    final timeline = await room.getTimeline();
    final reactions = <String, List<String>>{};

    for (final event in timeline.events) {
      if (event.type == 'm.reaction') {
        final relatesTo = event.content['m.relates_to'] as Map<String, dynamic>?;
        if (relatesTo != null && relatesTo['event_id'] == eventId) {
          final emoji = relatesTo['key'] as String?;
          if (emoji != null) {
            reactions.putIfAbsent(emoji, () => []);
            reactions[emoji]!.add(event.senderId);
          }
        }
      }
    }

    return reactions;
  }

  /// 回复消息
  Future<String?> sendReply(
    String roomId,
    String originalEventId,
    String content, {
    String? formattedContent,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) throw Exception('Room not found');

    // 获取原消息
    final timeline = await room.getTimeline();
    matrix.Event? originalEvent;
    for (final event in timeline.events) {
      if (event.eventId == originalEventId) {
        originalEvent = event;
        break;
      }
    }

    if (originalEvent == null) {
      throw Exception('Original message not found');
    }

    // 构建回复格式
    final senderName = originalEvent.senderFromMemoryOrFallback.calcDisplayname();
    final originalBody = originalEvent.body;

    // 富文本格式的回复
    final formattedBody = formattedContent ??
        '<mx-reply><blockquote><a href="https://matrix.to/#/${room.id}/$originalEventId">In reply to</a> <a href="https://matrix.to/#/${originalEvent.senderId}">$senderName</a><br/>$originalBody</blockquote></mx-reply>$content';

    // 纯文本格式的回复
    final plainBody = '> <${originalEvent.senderId}> $originalBody\n\n$content';

    final eventId = await room.sendEvent({
      'msgtype': 'm.text',
      'body': plainBody,
      'format': 'org.matrix.custom.html',
      'formatted_body': formattedBody,
      'm.relates_to': {
        'm.in_reply_to': {
          'event_id': originalEventId,
        },
      },
    });

    return eventId;
  }

  /// 编辑消息
  Future<String?> editMessage(
    String roomId,
    String originalEventId,
    String newContent, {
    String? formattedContent,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) throw Exception('Room not found');

    final eventId = await room.sendEvent({
      'msgtype': 'm.text',
      'body': '* $newContent',
      'm.new_content': {
        'msgtype': 'm.text',
        'body': newContent,
        if (formattedContent != null) ...{
          'format': 'org.matrix.custom.html',
          'formatted_body': formattedContent,
        },
      },
      'm.relates_to': {
        'rel_type': 'm.replace',
        'event_id': originalEventId,
      },
    });

    return eventId;
  }

  /// 撤回消息
  Future<void> redactMessage(
    String roomId,
    String eventId, {
    String? reason,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) throw Exception('Room not found');

    await room.redactEvent(eventId, reason: reason);
  }

  /// 转发消息
  Future<String?> forwardMessage(
    String fromRoomId,
    String eventId,
    String toRoomId,
  ) async {
    final fromRoom = _client?.getRoomById(fromRoomId);
    final toRoom = _client?.getRoomById(toRoomId);
    if (fromRoom == null || toRoom == null) {
      throw Exception('Room not found');
    }

    // 获取原消息
    final timeline = await fromRoom.getTimeline();
    matrix.Event? originalEvent;
    for (final event in timeline.events) {
      if (event.eventId == eventId) {
        originalEvent = event;
        break;
      }
    }

    if (originalEvent == null) {
      throw Exception('Original message not found');
    }

    // 根据消息类型转发
    final msgType = originalEvent.messageType;
    String? newEventId;

    switch (msgType) {
      case matrix.MessageTypes.Text:
        newEventId = await toRoom.sendTextEvent(originalEvent.body);
        break;
      case matrix.MessageTypes.Image:
      case matrix.MessageTypes.Video:
      case matrix.MessageTypes.Audio:
      case matrix.MessageTypes.File:
        // 复制媒体消息
        newEventId = await toRoom.sendEvent({
          'msgtype': msgType,
          'body': originalEvent.body,
          'url': originalEvent.content['url'],
          'info': originalEvent.content['info'],
        });
        break;
      default:
        // 作为文本转发
        newEventId = await toRoom.sendTextEvent(originalEvent.body);
    }

    return newEventId;
  }

  /// 检查用户是否可以撤回消息
  bool canRedact(String roomId, String senderId) {
    final room = _client?.getRoomById(roomId);
    if (room == null) return false;

    // 自己的消息可以撤回
    if (senderId == _client!.userID) return true;

    // 检查是否有管理员权限
    final powerLevels = room.getState('m.room.power_levels')?.content;
    if (powerLevels == null) return false;

    final userPowerLevel = room.ownPowerLevel;
    final redactLevel = (powerLevels['redact'] as num?) ?? 50;

    return userPowerLevel >= redactLevel.toInt();
  }

  /// 检查用户是否可以编辑消息
  bool canEdit(String roomId, String senderId) {
    // 只能编辑自己的消息
    return senderId == _client?.userID;
  }
}

