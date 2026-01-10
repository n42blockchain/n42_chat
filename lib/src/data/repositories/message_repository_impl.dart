import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart' as matrix;

import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasources/matrix/matrix_client_manager.dart';
import '../datasources/matrix/matrix_message_datasource.dart';

/// 消息仓库实现
class MessageRepositoryImpl implements IMessageRepository {
  final MatrixMessageDataSource _messageDataSource;
  final MatrixClientManager _clientManager;

  // 缓存时间线，避免重复创建
  final Map<String, matrix.Timeline> _timelines = {};

  MessageRepositoryImpl(this._messageDataSource, this._clientManager);

  matrix.Client? get _client => _clientManager.client;

  @override
  Future<List<MessageEntity>> getMessages(
    String roomId, {
    int limit = 50,
    String? beforeEventId,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return [];

    final timeline = await _getOrCreateTimeline(roomId);
    if (timeline == null) return [];

    // 如果当前事件数量不足，请求更多历史
    var displayableEvents = timeline.events.where((e) => _isDisplayableEvent(e)).toList();
    
    if (displayableEvents.length < limit) {
      debugPrint('MessageRepositoryImpl: Only ${displayableEvents.length} displayable events, requesting more...');
      try {
        await timeline.requestHistory(historyCount: limit * 2);
        displayableEvents = timeline.events.where((e) => _isDisplayableEvent(e)).toList();
        debugPrint('MessageRepositoryImpl: After requestHistory, ${displayableEvents.length} displayable events');
      } catch (e) {
        debugPrint('MessageRepositoryImpl: Failed to request more history: $e');
      }
    }

    final events = displayableEvents.take(limit).toList();
    return events.map((e) => _messageDataSource.mapEventToMessage(e, room)).toList();
  }

  @override
  Stream<List<MessageEntity>> watchMessages(String roomId) async* {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;

    final timeline = await _getOrCreateTimeline(roomId);
    if (timeline == null) return;

    // 初始消息
    yield _getMessagesFromTimeline(timeline, room);

    // 通过 client 的同步事件监听更新
    final syncStream = _client?.onSync.stream;
    if (syncStream != null) {
      await for (final _ in syncStream) {
        yield _getMessagesFromTimeline(timeline, room);
      }
    }
  }

  @override
  Stream<MessageEntity?> watchMessage(String roomId, String messageId) async* {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;

    final timeline = await _getOrCreateTimeline(roomId);
    if (timeline == null) return;

    // 通过 client 的同步事件监听更新
    final syncStream = _client?.onSync.stream;
    if (syncStream != null) {
      await for (final _ in syncStream) {
        try {
          final event = timeline.events.firstWhere(
            (e) => e.eventId == messageId,
          );
          yield _messageDataSource.mapEventToMessage(event, room);
        } catch (_) {
          // 事件未找到，跳过
        }
      }
    }
  }

  @override
  Future<List<MessageEntity>> loadMoreMessages(
    String roomId, {
    int limit = 50,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return [];

    final timeline = await _getOrCreateTimeline(roomId, requestHistory: false);
    if (timeline == null) return [];

    final beforeCount = timeline.events.length;
    debugPrint('MessageRepositoryImpl: loadMoreMessages - before: $beforeCount events');
    
    await timeline.requestHistory(historyCount: limit);
    
    final afterCount = timeline.events.length;
    debugPrint('MessageRepositoryImpl: loadMoreMessages - after: $afterCount events (+${afterCount - beforeCount})');

    return _getMessagesFromTimeline(timeline, room);
  }

  @override
  Future<MessageEntity?> sendTextMessage(String roomId, String text) async {
    final eventId = await _messageDataSource.sendTextMessage(roomId, text);
    if (eventId == null) return null;

    return _getMessageById(roomId, eventId);
  }

  @override
  Future<MessageEntity?> sendImageMessage(
    String roomId, {
    required Uint8List imageBytes,
    required String filename,
    String? mimeType,
  }) async {
    final eventId = await _messageDataSource.sendImageMessage(
      roomId,
      imageBytes: imageBytes,
      filename: filename,
      mimeType: mimeType,
    );
    if (eventId == null) return null;

    return _getMessageById(roomId, eventId);
  }

  @override
  Future<MessageEntity?> sendVoiceMessage(
    String roomId, {
    required Uint8List audioBytes,
    required String filename,
    required int duration,
    String? mimeType,
  }) async {
    final eventId = await _messageDataSource.sendVoiceMessage(
      roomId,
      audioBytes: audioBytes,
      filename: filename,
      duration: duration,
      mimeType: mimeType,
    );
    if (eventId == null) return null;

    return _getMessageById(roomId, eventId);
  }

  @override
  Future<MessageEntity?> sendVideoMessage(
    String roomId, {
    required Uint8List videoBytes,
    required String filename,
    String? mimeType,
    Uint8List? thumbnailBytes,
  }) async {
    final eventId = await _messageDataSource.sendVideoMessage(
      roomId,
      videoBytes: videoBytes,
      filename: filename,
      mimeType: mimeType,
      thumbnailBytes: thumbnailBytes,
    );
    if (eventId == null) return null;

    return _getMessageById(roomId, eventId);
  }

  @override
  Future<MessageEntity?> sendFileMessage(
    String roomId, {
    required Uint8List fileBytes,
    required String filename,
    String? mimeType,
  }) async {
    final eventId = await _messageDataSource.sendFileMessage(
      roomId,
      fileBytes: fileBytes,
      filename: filename,
      mimeType: mimeType,
    );
    if (eventId == null) return null;

    return _getMessageById(roomId, eventId);
  }

  @override
  Future<MessageEntity?> sendLocationMessage(
    String roomId, {
    required double latitude,
    required double longitude,
    String? description,
  }) async {
    final eventId = await _messageDataSource.sendLocationMessage(
      roomId,
      latitude: latitude,
      longitude: longitude,
      description: description,
    );
    if (eventId == null) return null;

    return _getMessageById(roomId, eventId);
  }

  @override
  Future<bool> resendMessage(String roomId, String messageId) async {
    return await _messageDataSource.resendMessage(roomId, messageId);
  }

  @override
  Future<bool> redactMessage(String roomId, String messageId, {String? reason}) async {
    return await _messageDataSource.redactMessage(roomId, messageId, reason: reason);
  }
  
  @override
  Future<bool> deleteFailedMessage(String roomId, String messageId) async {
    return await _messageDataSource.deleteFailedMessage(roomId, messageId);
  }

  @override
  Future<MessageEntity?> replyToMessage(
    String roomId,
    String replyToMessageId,
    String text,
  ) async {
    final eventId = await _messageDataSource.replyToMessage(
      roomId,
      replyToMessageId,
      text,
    );
    if (eventId == null) return null;

    return _getMessageById(roomId, eventId);
  }

  @override
  Future<MessageEntity?> editMessage(
    String roomId,
    String messageId,
    String newText,
  ) async {
    final eventId = await _messageDataSource.editMessage(
      roomId,
      messageId,
      newText,
    );
    if (eventId == null) return null;

    return _getMessageById(roomId, eventId);
  }

  @override
  Future<bool> addReaction(String roomId, String messageId, String emoji) async {
    return await _messageDataSource.addReaction(roomId, messageId, emoji);
  }

  @override
  Future<bool> removeReaction(String roomId, String messageId, String emoji) async {
    // Matrix SDK 暂不直接支持移除单个回应
    // 通常需要发送取消回应的事件
    return false;
  }

  @override
  Future<void> markAsRead(String roomId, String messageId) async {
    await _messageDataSource.markMessageAsRead(roomId, messageId);
  }

  @override
  Future<void> sendTypingNotification(String roomId, bool isTyping) async {
    await _messageDataSource.sendTypingNotification(roomId, isTyping);
  }

  @override
  String? getMediaUrl(String? mxcUrl, {int? width, int? height}) {
    final uri = _messageDataSource.getMediaUrl(mxcUrl, width: width, height: height);
    return uri?.toString();
  }

  @override
  Future<Uint8List?> downloadMedia(String mxcUrl) async {
    try {
      debugPrint('downloadMedia: Attempting to download from $mxcUrl');
      if (_client == null) {
        debugPrint('downloadMedia: Client is null');
        return null;
      }

      // 解析 mxc:// URL
      if (!mxcUrl.startsWith('mxc://')) {
        debugPrint('downloadMedia: Invalid mxc URL: $mxcUrl');
        return null;
      }

      final uri = Uri.parse(mxcUrl);
      final serverName = uri.host;
      final mediaId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';

      if (serverName.isEmpty || mediaId.isEmpty) {
        debugPrint('downloadMedia: Invalid mxc URL components: server=$serverName, mediaId=$mediaId');
        return null;
      }

      // 使用 Matrix 1.11+ 认证媒体端点
      final homeserver = _client!.homeserver?.toString().replaceAll(RegExp(r'/$'), '') ?? '';
      final authenticatedUrl = '$homeserver/_matrix/client/v1/media/download/$serverName/$mediaId';
      debugPrint('downloadMedia: Using authenticated URL: $authenticatedUrl');

      // 使用 Matrix 客户端的 httpClient（自动包含认证信息）
      final response = await _client!.httpClient.get(Uri.parse(authenticatedUrl));
      debugPrint('downloadMedia: Response status: ${response?.statusCode}');
      debugPrint('downloadMedia: Response body size: ${response?.bodyBytes.length ?? 0}');

      if (response != null && response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        return response.bodyBytes;
      }

      // 如果认证端点失败，尝试旧的 SDK 方法作为后备
      debugPrint('downloadMedia: Authenticated endpoint failed, trying SDK fallback');
      final downloadLink = uri.getDownloadLink(_client!);
      debugPrint('downloadMedia: SDK download link: $downloadLink');

      final fallbackResponse = await _client!.httpClient.get(downloadLink);
      debugPrint('downloadMedia: Fallback response status: ${fallbackResponse?.statusCode}');
      debugPrint('downloadMedia: Fallback response body size: ${fallbackResponse?.bodyBytes.length ?? 0}');

      if (fallbackResponse != null && fallbackResponse.statusCode == 200 && fallbackResponse.bodyBytes.isNotEmpty) {
        return fallbackResponse.bodyBytes;
      }

      debugPrint('downloadMedia: Both methods failed');
      return null;
    } catch (e, stackTrace) {
      debugPrint('downloadMedia: Error downloading media: $e');
      debugPrint('downloadMedia: Stack trace: $stackTrace');
      return null;
    }
  }
  
  @override
  Future<MessageEntity?> sendNoticeMessage({
    required String roomId,
    required String notice,
  }) async {
    try {
      return await _messageDataSource.sendNoticeMessage(
        roomId: roomId,
        notice: notice,
      );
    } catch (e) {
      debugPrint('MessageRepositoryImpl: Failed to send notice: $e');
      return null;
    }
  }
  
  @override
  Future<String?> getMemberPokeText({
    required String roomId,
    required String userId,
  }) async {
    try {
      return await _messageDataSource.getMemberPokeText(
        roomId: roomId,
        userId: userId,
      );
    } catch (e) {
      debugPrint('MessageRepositoryImpl: Failed to get member pokeText: $e');
      return null;
    }
  }
  
  @override
  Future<String?> getCurrentUserId() async {
    return _client?.userID;
  }
  
  @override
  Future<MessageEntity?> sendPollMessage(
    String roomId, {
    required String question,
    required List<String> options,
    int maxSelections = 1,
  }) async {
    try {
      debugPrint('MessageRepositoryImpl: Sending poll - question: $question, options: $options');
      final eventId = await _messageDataSource.sendPollMessage(
        roomId,
        question: question,
        options: options,
        maxSelections: maxSelections,
      );
      if (eventId != null) {
        debugPrint('MessageRepositoryImpl: Poll sent successfully - eventId: $eventId');
        
        // 获取发送者名称
        String senderName = '';
        try {
          final profile = await _client?.ownProfile;
          senderName = profile?.displayName ?? _client?.userID?.split(':').first.replaceFirst('@', '') ?? '';
        } catch (e) {
          senderName = _client?.userID?.split(':').first.replaceFirst('@', '') ?? '';
        }
        
        // 返回一个临时消息实体
        return MessageEntity(
          id: eventId,
          roomId: roomId,
          senderId: _client?.userID ?? '',
          senderName: senderName,
          content: question,
          type: MessageType.poll,
          timestamp: DateTime.now(),
          status: MessageStatus.sent,
          metadata: MessageMetadata(
            pollQuestion: question,
            pollOptions: options,
          ),
        );
      }
      return null;
    } catch (e) {
      debugPrint('MessageRepositoryImpl: Failed to send poll: $e');
      rethrow;
    }
  }
  
  @override
  Future<bool> voteOnPoll(
    String roomId, {
    required String pollEventId,
    required List<String> selectedOptionIds,
  }) async {
    try {
      debugPrint('MessageRepositoryImpl: Voting on poll - pollEventId: $pollEventId, options: $selectedOptionIds');
      return await _messageDataSource.voteOnPoll(
        roomId,
        pollEventId: pollEventId,
        selectedOptionIds: selectedOptionIds,
      );
    } catch (e) {
      debugPrint('MessageRepositoryImpl: Failed to vote on poll: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getPollAggregations(
    String roomId,
    String pollEventId,
  ) async {
    try {
      return await _messageDataSource.getPollAggregations(roomId, pollEventId);
    } catch (e) {
      debugPrint('MessageRepositoryImpl: Failed to get poll aggregations: $e');
      return null;
    }
  }

  @override
  Stream<Map<String, dynamic>>? watchPollResponses(String roomId) {
    return _messageDataSource.watchPollResponses(roomId);
  }

  @override
  Future<Map<String, dynamic>?> getReactionAggregations(
    String roomId,
    String eventId,
  ) async {
    try {
      return await _messageDataSource.getReactionAggregations(roomId, eventId);
    } catch (e) {
      debugPrint('MessageRepositoryImpl: Failed to get reaction aggregations: $e');
      return null;
    }
  }

  @override
  Future<String?> sendCustomMessage(
    String roomId, {
    required String msgType,
    required String content,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      debugPrint('MessageRepositoryImpl: Sending custom message - type: $msgType');
      
      // 构建消息内容
      final messageContent = <String, dynamic>{
        'msgtype': msgType,
        'body': content,
        ...?additionalData,
      };
      
      return await _messageDataSource.sendCustomMessage(
        roomId: roomId,
        msgType: msgType,
        content: messageContent,
      );
    } catch (e) {
      debugPrint('MessageRepositoryImpl: Failed to send custom message: $e');
      rethrow;
    }
  }

  // ============================================
  // 辅助方法
  // ============================================

  Future<matrix.Timeline?> _getOrCreateTimeline(String roomId, {bool requestHistory = true}) async {
    if (_timelines.containsKey(roomId)) {
      return _timelines[roomId];
    }

    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    final timeline = await room.getTimeline();
    _timelines[roomId] = timeline;
    
    // 自动请求历史消息以确保有足够的消息显示
    if (requestHistory && timeline.events.length < 50) {
      debugPrint('MessageRepositoryImpl: Timeline has ${timeline.events.length} events, requesting more history...');
      try {
        await timeline.requestHistory(historyCount: 100);
        debugPrint('MessageRepositoryImpl: After requestHistory, timeline has ${timeline.events.length} events');
      } catch (e) {
        debugPrint('MessageRepositoryImpl: Failed to request history: $e');
      }
    }
    
    return timeline;
  }

  List<MessageEntity> _getMessagesFromTimeline(
    matrix.Timeline timeline,
    matrix.Room room,
  ) {
    return timeline.events
        .where((e) => _isDisplayableEvent(e))
        .map((e) => _messageDataSource.mapEventToMessage(e, room))
        .toList();
  }

  Future<MessageEntity?> _getMessageById(String roomId, String eventId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    final event = await room.getEventById(eventId);
    if (event == null) return null;

    return _messageDataSource.mapEventToMessage(event, room);
  }

  bool _isDisplayableEvent(matrix.Event event) {
    // 过滤出可显示的消息类型
    return event.type == matrix.EventTypes.Message ||
        event.type == matrix.EventTypes.Encrypted ||
        event.type == matrix.EventTypes.Sticker ||
        event.type == 'org.matrix.msc3381.poll.start';
  }

  /// 清理时间线缓存
  void disposeTimeline(String roomId) {
    _timelines.remove(roomId);
  }

  /// 清理所有时间线缓存
  void disposeAllTimelines() {
    _timelines.clear();
  }
}

