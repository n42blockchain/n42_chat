import 'package:flutter/foundation.dart';
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
    debugPrint('MatrixReactionDataSource: redactMessage called - roomId=$roomId, eventId=$eventId, reason=$reason');

    final room = _client?.getRoomById(roomId);
    if (room == null) {
      debugPrint('MatrixReactionDataSource: Room not found: $roomId');
      throw Exception('Room not found');
    }

    try {
      debugPrint('MatrixReactionDataSource: Calling room.redactEvent...');
      final result = await room.redactEvent(eventId, reason: reason);
      debugPrint('MatrixReactionDataSource: redactEvent completed, result=$result');
    } catch (e, stackTrace) {
      debugPrint('MatrixReactionDataSource: redactEvent failed: $e');
      debugPrint('MatrixReactionDataSource: Stack: $stackTrace');
      rethrow;
    }
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

    // 使用 getEventById 获取原消息（比遍历 timeline 更可靠）
    matrix.Event? originalEvent = await fromRoom.getEventById(eventId);

    // 如果 getEventById 失败，尝试从 timeline 获取
    if (originalEvent == null) {
      final timeline = await fromRoom.getTimeline();
      for (final event in timeline.events) {
        if (event.eventId == eventId) {
          originalEvent = event;
          break;
        }
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
        // 复制媒体消息 - 确保包含所有必要的字段
        final content = <String, dynamic>{
          'msgtype': msgType,
          'body': originalEvent.body,
        };

        // 添加 URL（必须）
        final url = originalEvent.content['url'];
        if (url != null) {
          content['url'] = url;
        }

        // 添加 info（包含媒体元数据）
        final info = originalEvent.content['info'];
        if (info != null) {
          content['info'] = info;
        }

        // 对于文件类型，添加 filename
        if (msgType == matrix.MessageTypes.File) {
          final filename = originalEvent.content['filename'];
          if (filename != null) {
            content['filename'] = filename;
          }
        }

        newEventId = await toRoom.sendEvent(content);
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

  /// 获取消息的编辑历史
  ///
  /// 通过 Matrix 的 /relations API 获取指定消息的所有 m.replace 事件，
  /// 返回按时间排序的编辑记录列表（从旧到新）
  Future<List<EditHistoryEntry>> getEditHistory(
    String roomId,
    String eventId,
  ) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return [];

    try {
      // 获取原始事件
      final originalEvent = await room.getEventById(eventId);
      if (originalEvent == null) return [];

      final entries = <EditHistoryEntry>[];

      // 添加原始版本
      entries.add(EditHistoryEntry(
        content: originalEvent.body,
        editedAt: originalEvent.originServerTs,
        editorId: originalEvent.senderId,
        isOriginal: true,
      ));

      // 通过 timeline 查找所有编辑事件
      final timeline = await room.getTimeline();
      for (final event in timeline.events) {
        // 查找 m.replace 类型的关系事件，并且目标是我们的消息
        final relatesTo = event.content['m.relates_to'] as Map<String, dynamic>?;
        if (relatesTo == null) continue;

        final relType = relatesTo['rel_type'] as String?;
        final targetEventId = relatesTo['event_id'] as String?;

        if (relType == 'm.replace' && targetEventId == eventId) {
          // 提取编辑后的内容
          final newContent = event.content['m.new_content'] as Map<String, dynamic>?;
          final body = newContent?['body'] as String? ?? event.body;

          entries.add(EditHistoryEntry(
            content: body,
            editedAt: event.originServerTs,
            editorId: event.senderId,
            isOriginal: false,
          ));
        }
      }

      // 按时间排序（从旧到新）
      entries.sort((a, b) => a.editedAt.compareTo(b.editedAt));
      return entries;
    } catch (e) {
      debugPrint('MatrixReactionDataSource: getEditHistory error: $e');
      return [];
    }
  }
}

/// 编辑历史条目
class EditHistoryEntry {
  /// 消息内容
  final String content;

  /// 编辑时间
  final DateTime editedAt;

  /// 编辑者用户ID
  final String editorId;

  /// 是否是原始版本
  final bool isOriginal;

  const EditHistoryEntry({
    required this.content,
    required this.editedAt,
    required this.editorId,
    this.isOriginal = false,
  });
}

