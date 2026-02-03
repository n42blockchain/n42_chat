import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart' as matrix;

import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasources/local/secure_storage_datasource.dart';
import '../datasources/matrix/matrix_client_manager.dart';
import '../datasources/matrix/matrix_message_datasource.dart';

/// 消息仓库实现
class MessageRepositoryImpl implements IMessageRepository {
  final MatrixMessageDataSource _messageDataSource;
  final MatrixClientManager _clientManager;
  final SecureStorageDataSource _secureStorage;

  // 缓存时间线，避免重复创建
  final Map<String, matrix.Timeline> _timelines = {};

  MessageRepositoryImpl(
    this._messageDataSource,
    this._clientManager,
    this._secureStorage,
  );

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

      final homeserver = _client!.homeserver?.toString().replaceAll(RegExp(r'/$'), '') ?? '';
      final accessToken = _client!.accessToken;

      // 方法1: 使用 Matrix 1.11+ 认证媒体端点 (直接 HTTP 请求)
      final authenticatedUrl = '$homeserver/_matrix/client/v1/media/download/$serverName/$mediaId';
      debugPrint('downloadMedia: Trying authenticated URL: $authenticatedUrl');

      try {
        final response = await http.get(
          Uri.parse(authenticatedUrl),
          headers: {
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ).timeout(const Duration(seconds: 30));

        debugPrint('downloadMedia: Auth endpoint response: ${response.statusCode}, size: ${response.bodyBytes.length}');

        if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
          return response.bodyBytes;
        }
      } catch (e) {
        debugPrint('downloadMedia: Auth endpoint error: $e');
      }

      // 方法2: 使用传统媒体端点 v3
      final legacyUrl = '$homeserver/_matrix/media/v3/download/$serverName/$mediaId';
      debugPrint('downloadMedia: Trying legacy v3 URL: $legacyUrl');

      try {
        final response = await http.get(
          Uri.parse(legacyUrl),
          headers: {
            if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          },
        ).timeout(const Duration(seconds: 30));

        debugPrint('downloadMedia: Legacy v3 response: ${response.statusCode}, size: ${response.bodyBytes.length}');

        if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
          return response.bodyBytes;
        }
      } catch (e) {
        debugPrint('downloadMedia: Legacy v3 error: $e');
      }

      // 方法3: 使用 SDK 的 getDownloadLink (无认证，适用于公开媒体)
      debugPrint('downloadMedia: Trying SDK getDownloadLink');
      try {
        final downloadLink = uri.getDownloadLink(_client!);
        debugPrint('downloadMedia: SDK download link: $downloadLink');

        final response = await http.get(downloadLink).timeout(const Duration(seconds: 30));
        debugPrint('downloadMedia: SDK link response: ${response.statusCode}, size: ${response.bodyBytes.length}');

        if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
          return response.bodyBytes;
        }
      } catch (e) {
        debugPrint('downloadMedia: SDK link error: $e');
      }

      // 方法4: 使用 Matrix SDK httpClient (带自动认证)
      debugPrint('downloadMedia: Trying Matrix SDK httpClient');
      try {
        final sdkResponse = await _client!.httpClient.get(Uri.parse(authenticatedUrl));
        debugPrint('downloadMedia: SDK httpClient response: ${sdkResponse.statusCode}, size: ${sdkResponse.bodyBytes.length}');

        if (sdkResponse.statusCode == 200 && sdkResponse.bodyBytes.isNotEmpty) {
          return sdkResponse.bodyBytes;
        }
      } catch (e) {
        debugPrint('downloadMedia: SDK httpClient error: $e');
      }

      debugPrint('downloadMedia: All methods failed');
      return null;
    } catch (e, stackTrace) {
      debugPrint('downloadMedia: Error downloading media: $e');
      debugPrint('downloadMedia: Stack trace: $stackTrace');
      return null;
    }
  }

  @override
  Future<MessageEntity?> forwardMediaMessage(
    String roomId, {
    required String mxcUrl,
    required String msgType,
    required String filename,
    String? mimeType,
    int? width,
    int? height,
    int? size,
    int? duration,
    String? thumbnailUrl,
  }) async {
    try {
      debugPrint('forwardMediaMessage: roomId=$roomId, mxcUrl=$mxcUrl, msgType=$msgType');

      final room = _client?.getRoomById(roomId);
      if (room == null) {
        debugPrint('forwardMediaMessage: Room not found');
        return null;
      }

      // 构建媒体消息内容
      final content = <String, dynamic>{
        'msgtype': msgType,
        'body': filename,
        'url': mxcUrl,
      };

      // 添加 info 字段
      final info = <String, dynamic>{};
      if (mimeType != null) info['mimetype'] = mimeType;
      if (width != null) info['w'] = width;
      if (height != null) info['h'] = height;
      if (size != null) info['size'] = size;
      if (duration != null) info['duration'] = duration;
      if (thumbnailUrl != null) info['thumbnail_url'] = thumbnailUrl;

      if (info.isNotEmpty) {
        content['info'] = info;
      }

      // 对于文件类型，添加 filename
      if (msgType == 'm.file') {
        content['filename'] = filename;
      }

      debugPrint('forwardMediaMessage: Sending content: $content');
      final eventId = await room.sendEvent(content);
      debugPrint('forwardMediaMessage: Event sent: $eventId');

      if (eventId == null) return null;
      return _getMessageById(roomId, eventId);
    } catch (e, stackTrace) {
      debugPrint('forwardMediaMessage: Error: $e');
      debugPrint('forwardMediaMessage: Stack trace: $stackTrace');
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
  Future<MessageEntity?> sendForwardedPollSnapshot(
    String roomId, {
    required String question,
    required List<String> options,
    required List<String> optionIds,
    required Map<String, int> voteCounts,
    required int totalVoters,
    int maxSelections = 1,
  }) async {
    try {
      debugPrint('MessageRepositoryImpl: Sending forwarded poll snapshot - question: $question');
      final eventId = await _messageDataSource.sendForwardedPollSnapshot(
        roomId,
        question: question,
        options: options,
        optionIds: optionIds,
        voteCounts: voteCounts,
        totalVoters: totalVoters,
        maxSelections: maxSelections,
      );
      if (eventId != null) {
        debugPrint('MessageRepositoryImpl: Forwarded poll sent successfully - eventId: $eventId');

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
            pollOptionIds: optionIds,
            voteCounts: voteCounts,
            totalVoters: totalVoters,
            maxSelections: maxSelections,
            pollEnded: true,
          ),
        );
      }
      return null;
    } catch (e) {
      debugPrint('MessageRepositoryImpl: Failed to send forwarded poll snapshot: $e');
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

  // ============================================
  // 本地删除消息管理
  // ============================================

  @override
  Future<Set<String>> getLocallyDeletedMessageIds(String roomId) async {
    return _secureStorage.getLocallyDeletedMessageIds(roomId);
  }

  @override
  Future<void> markMessagesAsLocallyDeleted(String roomId, List<String> messageIds) async {
    await _secureStorage.markMessagesAsLocallyDeleted(roomId, messageIds);
  }

  @override
  Future<void> clearLocallyDeletedMessages(String roomId) async {
    await _secureStorage.clearLocallyDeletedMessages(roomId);
  }
}

