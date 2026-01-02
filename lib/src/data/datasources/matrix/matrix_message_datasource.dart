import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart' as matrix;

import '../../../domain/entities/message_entity.dart';
import 'matrix_client_manager.dart';

/// Matrix消息数据源
///
/// 封装Matrix SDK的消息相关操作
class MatrixMessageDataSource {
  final MatrixClientManager _clientManager;

  MatrixMessageDataSource(this._clientManager);

  /// 获取Matrix客户端
  matrix.Client? get _client => _clientManager.client;

  // ============================================
  // 消息获取
  // ============================================

  /// 获取房间的时间线
  Future<matrix.Timeline?> getTimeline(String roomId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    return await room.getTimeline();
  }

  /// 获取房间消息历史
  Future<List<matrix.Event>> getMessages(
    String roomId, {
    int limit = 50,
    String? fromEventId,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return [];

    final timeline = await room.getTimeline();
    
    // 如果需要加载更多历史消息
    if (fromEventId != null) {
      await timeline.requestHistory(historyCount: limit);
    }

    // 过滤出消息事件
    return timeline.events
        .where((event) => _isMessageEvent(event))
        .take(limit)
        .toList();
  }

  /// 加载更多历史消息
  Future<bool> loadMoreMessages(
    String roomId, {
    int count = 50,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return false;

    final timeline = await room.getTimeline();
    
    try {
      await timeline.requestHistory(historyCount: count);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 根据事件ID获取消息
  Future<matrix.Event?> getMessageById(String roomId, String eventId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    return await room.getEventById(eventId);
  }

  // ============================================
  // 消息发送
  // ============================================

  /// 发送文本消息
  Future<String?> sendTextMessage(String roomId, String text) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    return await room.sendTextEvent(text);
  }

  /// 发送图片消息
  Future<String?> sendImageMessage(
    String roomId, {
    required Uint8List imageBytes,
    required String filename,
    String? mimeType,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    // 上传图片
    final matrixFile = matrix.MatrixImageFile(
      bytes: imageBytes,
      name: filename,
      mimeType: mimeType ?? 'image/jpeg',
    );

    return await room.sendFileEvent(matrixFile);
  }

  /// 发送语音消息
  Future<String?> sendVoiceMessage(
    String roomId, {
    required Uint8List audioBytes,
    required String filename,
    required int duration,
    String? mimeType,
  }) async {
    try {
      final room = _client?.getRoomById(roomId);
      if (room == null) {
        debugPrint('Room not found: $roomId');
        return null;
      }

      // 确定正确的 MIME 类型
      String actualMimeType = mimeType ?? 'audio/mp4';
      if (filename.endsWith('.m4a')) {
        actualMimeType = 'audio/mp4';
      } else if (filename.endsWith('.ogg')) {
        actualMimeType = 'audio/ogg';
      } else if (filename.endsWith('.mp3')) {
        actualMimeType = 'audio/mpeg';
      }

      final matrixFile = matrix.MatrixAudioFile(
        bytes: audioBytes,
        name: filename,
        mimeType: actualMimeType,
        duration: duration,
      );

      debugPrint('Sending voice message: $filename, size: ${audioBytes.length}, duration: $duration ms');
      final result = await room.sendFileEvent(matrixFile);
      debugPrint('Voice message sent: $result');
      return result;
    } catch (e, stackTrace) {
      debugPrint('Send voice message error: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// 发送视频消息
  Future<String?> sendVideoMessage(
    String roomId, {
    required Uint8List videoBytes,
    required String filename,
    String? mimeType,
    Uint8List? thumbnailBytes,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    final matrixFile = matrix.MatrixVideoFile(
      bytes: videoBytes,
      name: filename,
      mimeType: mimeType ?? 'video/mp4',
    );

    return await room.sendFileEvent(matrixFile);
  }

  /// 发送文件消息
  Future<String?> sendFileMessage(
    String roomId, {
    required Uint8List fileBytes,
    required String filename,
    String? mimeType,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    final matrixFile = matrix.MatrixFile(
      bytes: fileBytes,
      name: filename,
      mimeType: mimeType ?? 'application/octet-stream',
    );

    return await room.sendFileEvent(matrixFile);
  }

  /// 发送位置消息
  Future<String?> sendLocationMessage(
    String roomId, {
    required double latitude,
    required double longitude,
    String? description,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    final geoUri = 'geo:$latitude,$longitude';
    
    return await room.sendEvent({
      'msgtype': matrix.MessageTypes.Location,
      'body': description ?? '位置',
      'geo_uri': geoUri,
      'info': {
        'latitude': latitude,
        'longitude': longitude,
      },
    });
  }

  /// 发送自定义消息
  Future<String> sendCustomMessage({
    required String roomId,
    required String msgType,
    required Map<String, dynamic> content,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) {
      throw Exception('房间不存在');
    }

    final eventId = await room.sendEvent(content);
    return eventId ?? '';
  }

  /// 重发消息
  Future<bool> resendMessage(String roomId, String eventId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return false;

    final event = await room.getEventById(eventId);
    if (event == null) return false;

    // 获取原始内容并重新发送
    try {
      await room.sendEvent(event.content);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ============================================
  // 消息操作
  // ============================================

  /// 撤回消息
  Future<bool> redactMessage(String roomId, String eventId, {String? reason}) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return false;

    try {
      await room.redactEvent(eventId, reason: reason);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 回复消息
  Future<String?> replyToMessage(
    String roomId,
    String replyToEventId,
    String text,
  ) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    final replyEvent = await room.getEventById(replyToEventId);
    if (replyEvent == null) return null;

    return await room.sendTextEvent(
      text,
      inReplyTo: replyEvent,
    );
  }

  /// 编辑消息
  Future<String?> editMessage(
    String roomId,
    String originalEventId,
    String newText,
  ) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    final originalEvent = await room.getEventById(originalEventId);
    if (originalEvent == null) return null;

    return await room.sendTextEvent(
      newText,
      editEventId: originalEventId,
    );
  }

  /// 添加消息表情回应
  Future<bool> addReaction(
    String roomId,
    String eventId,
    String emoji,
  ) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return false;

    try {
      await room.sendReaction(eventId, emoji);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ============================================
  // 消息已读状态
  // ============================================

  /// 标记消息已读
  Future<void> markMessageAsRead(String roomId, String eventId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;

    await room.setReadMarker(eventId, mRead: eventId);
  }

  /// 发送正在输入状态
  Future<void> sendTypingNotification(String roomId, bool isTyping) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;

    await room.setTyping(isTyping);
  }

  // ============================================
  // 消息监听
  // ============================================

  /// 监听房间消息更新
  Stream<matrix.Event>? watchRoomMessages(String roomId) {
    return _client?.onEvent.stream.where((eventUpdate) {
      return eventUpdate.roomID == roomId &&
          _isMessageEvent(eventUpdate.content);
    }).map((eventUpdate) {
      final room = _client!.getRoomById(roomId)!;
      return matrix.Event.fromJson(eventUpdate.content, room);
    });
  }

  /// 监听消息发送状态
  Stream<matrix.SyncUpdate>? get onSyncUpdate => _client?.onSync.stream;

  // ============================================
  // 工具方法
  // ============================================

  /// 判断是否是消息事件
  bool _isMessageEvent(dynamic event) {
    if (event is matrix.Event) {
      return event.type == matrix.EventTypes.Message ||
          event.type == matrix.EventTypes.Encrypted ||
          event.type == matrix.EventTypes.Sticker;
    }
    if (event is Map<String, dynamic>) {
      final type = event['type'] as String?;
      return type == matrix.EventTypes.Message ||
          type == matrix.EventTypes.Encrypted ||
          type == matrix.EventTypes.Sticker;
    }
    return false;
  }

  /// 将Matrix事件转换为消息实体
  MessageEntity mapEventToMessage(matrix.Event event, matrix.Room room) {
    final sender = room.unsafeGetUserFromMemoryOrFallback(event.senderId);
    
    return MessageEntity(
      id: event.eventId,
      roomId: room.id,
      senderId: event.senderId,
      senderName: sender.calcDisplayname(),
      senderAvatarUrl: sender.avatarUrl?.toString(),
      content: event.body,
      type: _mapMessageType(event),
      timestamp: event.originServerTs,
      status: _mapMessageStatus(event),
      isFromMe: event.senderId == _client?.userID,
      replyToId: event.relationshipEventId,
      isEdited: false, // 简化处理，后续可通过检查编辑事件实现
      reactions: _extractReactions(event),
      metadata: _extractMetadata(event),
    );
  }

  /// 映射消息类型
  MessageType _mapMessageType(matrix.Event event) {
    if (event.type == matrix.EventTypes.Encrypted) {
      return MessageType.encrypted;
    }

    final msgType = event.messageType;
    switch (msgType) {
      case matrix.MessageTypes.Text:
        return MessageType.text;
      case matrix.MessageTypes.Image:
        return MessageType.image;
      case matrix.MessageTypes.Video:
        return MessageType.video;
      case matrix.MessageTypes.Audio:
        return MessageType.audio;
      case matrix.MessageTypes.File:
        return MessageType.file;
      case matrix.MessageTypes.Location:
        return MessageType.location;
      case matrix.MessageTypes.Notice:
        return MessageType.notice;
      case matrix.MessageTypes.Emote:
        return MessageType.text;
      default:
        // 检查是否是转账消息
        if (event.content['msgtype'] == 'n42.transfer') {
          return MessageType.transfer;
        }
        return MessageType.text;
    }
  }

  /// 映射消息状态
  MessageStatus _mapMessageStatus(matrix.Event event) {
    if (event.status == matrix.EventStatus.error) {
      return MessageStatus.failed;
    }
    if (event.status == matrix.EventStatus.sending) {
      return MessageStatus.sending;
    }
    if (event.status == matrix.EventStatus.sent) {
      return MessageStatus.sent;
    }
    // 检查已读回执
    return MessageStatus.sent;
  }

  /// 提取表情回应
  List<MessageReaction> _extractReactions(matrix.Event event) {
    // TODO: 实现表情回应提取
    return [];
  }

  /// 提取消息元数据
  MessageMetadata? _extractMetadata(matrix.Event event) {
    final info = event.content['info'] as Map<String, dynamic>?;
    
    // 图片信息
    if (event.messageType == matrix.MessageTypes.Image) {
      return MessageMetadata(
        mediaUrl: event.content['url'] as String?,
        width: info?['w'] as int?,
        height: info?['h'] as int?,
        size: info?['size'] as int?,
        mimeType: info?['mimetype'] as String?,
        thumbnailUrl: (info?['thumbnail_info'] as Map<String, dynamic>?)?['thumbnail_url'] as String?,
      );
    }

    // 音频信息
    if (event.messageType == matrix.MessageTypes.Audio) {
      return MessageMetadata(
        mediaUrl: event.content['url'] as String?,
        duration: info?['duration'] as int?,
        size: info?['size'] as int?,
        mimeType: info?['mimetype'] as String?,
      );
    }

    // 视频信息
    if (event.messageType == matrix.MessageTypes.Video) {
      return MessageMetadata(
        mediaUrl: event.content['url'] as String?,
        width: info?['w'] as int?,
        height: info?['h'] as int?,
        duration: info?['duration'] as int?,
        size: info?['size'] as int?,
        mimeType: info?['mimetype'] as String?,
        thumbnailUrl: (info?['thumbnail_info'] as Map<String, dynamic>?)?['thumbnail_url'] as String?,
      );
    }

    // 文件信息
    if (event.messageType == matrix.MessageTypes.File) {
      return MessageMetadata(
        mediaUrl: event.content['url'] as String?,
        fileName: (event.content['filename'] as String?) ?? event.body,
        size: info?['size'] as int?,
        mimeType: info?['mimetype'] as String?,
      );
    }

    // 位置信息
    if (event.messageType == matrix.MessageTypes.Location) {
      return MessageMetadata(
        latitude: info?['latitude'] as double?,
        longitude: info?['longitude'] as double?,
        locationName: event.body,
      );
    }

    return null;
  }

  /// 获取媒体下载URL
  Uri? getMediaUrl(String? mxcUrl, {int? width, int? height}) {
    if (mxcUrl == null || _client == null) return null;

    try {
      final uri = Uri.parse(mxcUrl);
      if (width != null && height != null) {
        return uri.getThumbnail(
          _client!,
          width: width,
          height: height,
          method: matrix.ThumbnailMethod.scale,
        );
      }
      return uri.getDownloadLink(_client!);
    } catch (e) {
      return null;
    }
  }
}

