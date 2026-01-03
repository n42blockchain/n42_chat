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

    final events = timeline.events
        .where((e) => _isDisplayableEvent(e))
        .take(limit)
        .toList();

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

    final timeline = await _getOrCreateTimeline(roomId);
    if (timeline == null) return [];

    await timeline.requestHistory(historyCount: limit);

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
      final uri = Uri.parse(mxcUrl);
      final response = await _client?.httpClient.get(
        uri.getDownloadLink(_client!),
      );
      return response?.bodyBytes;
    } catch (e) {
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
        // 返回一个临时消息实体
        return MessageEntity(
          id: eventId,
          roomId: roomId,
          senderId: _client?.userID ?? '',
          senderName: _client?.ownProfile?.displayName ?? '',
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

  // ============================================
  // 辅助方法
  // ============================================

  Future<matrix.Timeline?> _getOrCreateTimeline(String roomId) async {
    if (_timelines.containsKey(roomId)) {
      return _timelines[roomId];
    }

    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    final timeline = await room.getTimeline();
    _timelines[roomId] = timeline;
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
        event.type == matrix.EventTypes.Sticker;
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

