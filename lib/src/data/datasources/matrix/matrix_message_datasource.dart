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
    debugPrint('=== MatrixMessageDataSource.sendImageMessage start ===');
    debugPrint('roomId: $roomId');
    debugPrint('filename: $filename');
    debugPrint('mimeType (input): $mimeType');
    debugPrint('imageBytes.length: ${imageBytes.length}');
    
    try {
      // 检查客户端
      if (_client == null) {
        debugPrint('ERROR: Matrix client is null');
        throw Exception('Matrix 客户端未初始化');
      }
      
      // 检查登录状态
      if (!_client!.isLogged()) {
        debugPrint('ERROR: Not logged in');
        throw Exception('未登录');
      }
      
      // 获取房间
      final room = _client!.getRoomById(roomId);
      if (room == null) {
        debugPrint('ERROR: Room not found: $roomId');
        debugPrint('Available rooms: ${_client!.rooms.map((r) => r.id).toList()}');
        throw Exception('房间不存在: $roomId');
      }
      debugPrint('Room found: ${room.getLocalizedDisplayname()}');

      // 确定正确的 MIME 类型
      String actualMimeType = mimeType ?? 'image/jpeg';
      final lowerFilename = filename.toLowerCase();
      if (lowerFilename.endsWith('.png')) {
        actualMimeType = 'image/png';
      } else if (lowerFilename.endsWith('.gif')) {
        actualMimeType = 'image/gif';
      } else if (lowerFilename.endsWith('.webp')) {
        actualMimeType = 'image/webp';
      } else if (lowerFilename.endsWith('.heic') || lowerFilename.endsWith('.heif')) {
        // HEIC/HEIF 需要服务器支持，某些服务器可能不支持，尝试作为 jpeg
        actualMimeType = 'image/jpeg';
      }

      debugPrint('Final mimeType: $actualMimeType');

      // 创建 Matrix 图片文件
      final matrixFile = matrix.MatrixImageFile(
        bytes: imageBytes,
        name: filename,
        mimeType: actualMimeType,
      );
      debugPrint('MatrixImageFile created: name=${matrixFile.name}, mimeType=${matrixFile.mimeType}');

      // 发送文件事件
      debugPrint('Calling room.sendFileEvent...');
      final result = await room.sendFileEvent(matrixFile);
      debugPrint('sendFileEvent result: $result');
      
      if (result == null || result.isEmpty) {
        debugPrint('WARNING: sendFileEvent returned null or empty result');
      }
      
      debugPrint('=== sendImageMessage completed successfully ===');
      return result;
    } catch (e, stackTrace) {
      debugPrint('=== sendImageMessage ERROR ===');
      debugPrint('Error: $e');
      debugPrint('Error type: ${e.runtimeType}');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// 发送语音消息
  Future<String?> sendVoiceMessage(
    String roomId, {
    required Uint8List audioBytes,
    required String filename,
    required int duration,
    String? mimeType,
  }) async {
    debugPrint('=== MatrixMessageDataSource.sendVoiceMessage start ===');
    debugPrint('roomId: $roomId');
    debugPrint('filename: $filename');
    debugPrint('duration: $duration ms');
    debugPrint('mimeType (input): $mimeType');
    debugPrint('audioBytes.length: ${audioBytes.length}');
    
    try {
      // 检查客户端
      if (_client == null) {
        debugPrint('ERROR: Matrix client is null');
        throw Exception('Matrix 客户端未初始化');
      }
      
      // 检查登录状态
      if (!_client!.isLogged()) {
        debugPrint('ERROR: Not logged in');
        throw Exception('未登录');
      }
      
      // 获取房间
      final room = _client!.getRoomById(roomId);
      if (room == null) {
        debugPrint('ERROR: Room not found: $roomId');
        throw Exception('房间不存在: $roomId');
      }
      debugPrint('Room found: ${room.getLocalizedDisplayname()}');

      // 确定正确的 MIME 类型
      String actualMimeType = mimeType ?? 'audio/mp4';
      final lowerFilename = filename.toLowerCase();
      if (lowerFilename.endsWith('.m4a')) {
        actualMimeType = 'audio/mp4';
      } else if (lowerFilename.endsWith('.ogg') || lowerFilename.endsWith('.opus')) {
        actualMimeType = 'audio/ogg';
      } else if (lowerFilename.endsWith('.mp3')) {
        actualMimeType = 'audio/mpeg';
      } else if (lowerFilename.endsWith('.wav')) {
        actualMimeType = 'audio/wav';
      } else if (lowerFilename.endsWith('.aac')) {
        actualMimeType = 'audio/aac';
      } else if (lowerFilename.endsWith('.webm')) {
        actualMimeType = 'audio/webm';
      }

      debugPrint('Final mimeType: $actualMimeType');

      // 创建 Matrix 音频文件
      final matrixFile = matrix.MatrixAudioFile(
        bytes: audioBytes,
        name: filename,
        mimeType: actualMimeType,
        duration: duration,
      );
      debugPrint('MatrixAudioFile created: name=${matrixFile.name}, mimeType=${matrixFile.mimeType}');

      // 发送文件事件
      debugPrint('Calling room.sendFileEvent...');
      final result = await room.sendFileEvent(matrixFile);
      debugPrint('sendFileEvent result: $result');
      
      if (result == null || result.isEmpty) {
        debugPrint('WARNING: sendFileEvent returned null or empty result');
      }
      
      debugPrint('=== sendVoiceMessage completed successfully ===');
      return result;
    } catch (e, stackTrace) {
      debugPrint('=== sendVoiceMessage ERROR ===');
      debugPrint('Error: $e');
      debugPrint('Error type: ${e.runtimeType}');
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
  /// 
  /// Matrix 位置消息格式参考:
  /// https://spec.matrix.org/latest/client-server-api/#mlocation
  Future<String?> sendLocationMessage(
    String roomId, {
    required double latitude,
    required double longitude,
    String? description,
  }) async {
    debugPrint('=== MatrixMessageDataSource.sendLocationMessage start ===');
    debugPrint('roomId: $roomId');
    debugPrint('latitude: $latitude');
    debugPrint('longitude: $longitude');
    debugPrint('description: $description');
    
    try {
      // 检查客户端
      if (_client == null) {
        debugPrint('ERROR: Matrix client is null');
        throw Exception('Matrix 客户端未初始化');
      }
      
      // 检查登录状态
      if (!_client!.isLogged()) {
        debugPrint('ERROR: Not logged in');
        throw Exception('未登录');
      }
      
      // 获取房间
      final room = _client!.getRoomById(roomId);
      if (room == null) {
        debugPrint('ERROR: Room not found: $roomId');
        throw Exception('房间不存在: $roomId');
      }
      debugPrint('Room found: ${room.getLocalizedDisplayname()}');

      // 构建 geo URI (标准格式)
      final geoUri = 'geo:$latitude,$longitude';
      
      // 构建位置消息内容 (遵循 Matrix 规范)
      final content = {
        'msgtype': matrix.MessageTypes.Location,
        'body': description ?? '位置: $latitude, $longitude',
        'geo_uri': geoUri,
        'info': {
          // Matrix org.matrix.msc3488 扩展
          'latitude': latitude,
          'longitude': longitude,
        },
        // Matrix 规范的 m.location 扩展 (可选)
        'org.matrix.msc3488.location': {
          'uri': geoUri,
          'description': description ?? '位置',
        },
        // 资产类型
        'org.matrix.msc3488.asset': {
          'type': 'm.self', // 表示这是用户自己的位置
        },
      };
      
      debugPrint('Location content: $content');
      debugPrint('Calling room.sendEvent...');
      
      final result = await room.sendEvent(content);
      debugPrint('sendEvent result: $result');
      
      if (result == null || result.isEmpty) {
        debugPrint('WARNING: sendEvent returned null or empty result');
      }
      
      debugPrint('=== sendLocationMessage completed successfully ===');
      return result;
    } catch (e, stackTrace) {
      debugPrint('=== sendLocationMessage ERROR ===');
      debugPrint('Error: $e');
      debugPrint('Error type: ${e.runtimeType}');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
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
    
    // 解析消息内容，处理回复格式
    final parsedContent = _parseMessageContent(event, room);
    
    return MessageEntity(
      id: event.eventId,
      roomId: room.id,
      senderId: event.senderId,
      senderName: sender.calcDisplayname(),
      senderAvatarUrl: sender.avatarUrl?.toString(),
      content: parsedContent.content,
      type: _mapMessageType(event),
      timestamp: event.originServerTs,
      status: _mapMessageStatus(event),
      isFromMe: event.senderId == _client?.userID,
      replyToId: event.relationshipEventId,
      replyToContent: parsedContent.replyToContent,
      replyToSender: parsedContent.replyToSender,
      isEdited: false, // 简化处理，后续可通过检查编辑事件实现
      reactions: _extractReactions(event),
      metadata: _extractMetadata(event),
    );
  }
  
  /// 解析消息内容，处理回复格式
  /// Matrix 回复格式: "> <@user:server> 原消息内容\n\n实际回复内容"
  _ParsedContent _parseMessageContent(matrix.Event event, matrix.Room room) {
    String body = event.body;
    String? replyToContent;
    String? replyToSender;
    
    // 检查是否是回复消息（有 m.relates_to 或以 > 开头）
    if (event.relationshipEventId != null || body.startsWith('> ')) {
      // 尝试从 body 解析回复格式
      final lines = body.split('\n');
      final List<String> quotedLines = [];
      int contentStartIndex = 0;
      
      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.startsWith('> ')) {
          quotedLines.add(line);
          contentStartIndex = i + 1;
        } else if (line.isEmpty && quotedLines.isNotEmpty) {
          // 空行分隔引用和实际内容
          contentStartIndex = i + 1;
          break;
        } else if (quotedLines.isNotEmpty) {
          // 遇到非引用行，停止
          break;
        }
      }
      
      // 如果找到了引用内容
      if (quotedLines.isNotEmpty) {
        // 解析引用的发送者和内容
        final firstQuoteLine = quotedLines.first;
        // 格式: "> <@user:server> 内容" 或 "> * <@user:server> 内容"
        final userMatch = RegExp(r'> \*? ?<(@[^>]+)>(.*)').firstMatch(firstQuoteLine);
        if (userMatch != null) {
          final userId = userMatch.group(1);
          replyToContent = userMatch.group(2)?.trim();
          
          // 如果有多行引用，合并
          if (quotedLines.length > 1) {
            final restQuotes = quotedLines.skip(1).map((l) => l.replaceFirst('> ', '')).join('\n');
            replyToContent = '${replyToContent ?? ''}\n$restQuotes'.trim();
          }
          
          // 获取发送者名称
          if (userId != null) {
            try {
              final replyUser = room.unsafeGetUserFromMemoryOrFallback(userId);
              replyToSender = replyUser.calcDisplayname();
            } catch (_) {
              // 如果获取用户失败，使用 userId 的用户名部分
              replyToSender = userId.split(':').first.replaceFirst('@', '');
            }
          }
        }
        
        // 提取实际回复内容
        if (contentStartIndex < lines.length) {
          body = lines.sublist(contentStartIndex).join('\n').trim();
        }
      }
    }
    
    return _ParsedContent(
      content: body,
      replyToContent: replyToContent,
      replyToSender: replyToSender,
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

/// 解析后的消息内容
class _ParsedContent {
  final String content;
  final String? replyToContent;
  final String? replyToSender;
  
  _ParsedContent({
    required this.content,
    this.replyToContent,
    this.replyToSender,
  });
}

