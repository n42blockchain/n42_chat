import 'package:matrix/matrix.dart' as matrix;

import 'matrix_client_manager.dart';

/// Matrix搜索数据源
///
/// 封装Matrix SDK的搜索相关操作
class MatrixSearchDataSource {
  final MatrixClientManager _clientManager;

  MatrixSearchDataSource(this._clientManager);

  /// 获取Matrix客户端
  matrix.Client? get _client => _clientManager.client;

  // ============================================
  // 全局搜索
  // ============================================

  /// 搜索用户
  Future<List<matrix.Profile>> searchUsers(String query, {int limit = 20}) async {
    if (_client == null || query.trim().isEmpty) return [];

    try {
      final result = await _client!.searchUserDirectory(
        query,
        limit: limit,
      );
      return result.results;
    } catch (e) {
      return [];
    }
  }

  /// 搜索公开房间
  Future<List<matrix.PublicRoomsChunk>> searchPublicRooms(
    String query, {
    int limit = 20,
  }) async {
    if (_client == null) return [];

    try {
      final result = await _client!.queryPublicRooms(
        limit: limit,
        filter: matrix.PublicRoomQueryFilter(genericSearchTerm: query),
      );
      return result.chunk;
    } catch (e) {
      return [];
    }
  }

  // ============================================
  // 本地搜索
  // ============================================

  /// 搜索本地联系人（私聊对象）
  List<matrix.User> searchLocalContacts(String query) {
    if (_client == null || query.trim().isEmpty) return [];

    final lowerQuery = query.toLowerCase();
    final contacts = <String, matrix.User>{};

    for (final room in _client!.rooms) {
      if (room.isDirectChat && room.membership == matrix.Membership.join) {
        final partnerId = room.directChatMatrixID;
        if (partnerId != null && partnerId != _client!.userID) {
          final user = room.unsafeGetUserFromMemoryOrFallback(partnerId);
          final displayName = user.calcDisplayname().toLowerCase();
          final userId = user.id.toLowerCase();

          if (displayName.contains(lowerQuery) || userId.contains(lowerQuery)) {
            contacts[partnerId] = user;
          }
        }
      }
    }

    return contacts.values.toList();
  }

  /// 搜索本地群聊
  List<matrix.Room> searchLocalGroups(String query) {
    if (_client == null || query.trim().isEmpty) return [];

    final lowerQuery = query.toLowerCase();

    return _client!.rooms.where((room) {
      if (room.isDirectChat || room.membership != matrix.Membership.join) {
        return false;
      }

      final name = room.getLocalizedDisplayname().toLowerCase();
      final topic = (room.topic ?? '').toLowerCase();

      return name.contains(lowerQuery) || topic.contains(lowerQuery);
    }).toList();
  }

  /// 搜索本地会话（包括私聊和群聊）
  List<matrix.Room> searchLocalConversations(String query) {
    if (_client == null || query.trim().isEmpty) return [];

    final lowerQuery = query.toLowerCase();

    return _client!.rooms.where((room) {
      if (room.membership != matrix.Membership.join) return false;

      final name = room.getLocalizedDisplayname().toLowerCase();
      final topic = (room.topic ?? '').toLowerCase();

      // 检查最后一条消息
      final lastEvent = room.lastEvent;
      final lastMessage = lastEvent?.body?.toLowerCase() ?? '';

      return name.contains(lowerQuery) ||
          topic.contains(lowerQuery) ||
          lastMessage.contains(lowerQuery);
    }).toList();
  }

  // ============================================
  // 消息搜索
  // ============================================

  /// 在指定房间搜索消息
  Future<List<matrix.Event>> searchMessagesInRoom(
    String roomId,
    String query, {
    int limit = 50,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null || query.trim().isEmpty) return [];

    final lowerQuery = query.toLowerCase();
    final results = <matrix.Event>[];

    try {
      final timeline = await room.getTimeline();

      // 遍历时间线中的消息
      for (final event in timeline.events) {
        if (!_isMessageEvent(event)) continue;

        final body = event.body.toLowerCase();
        if (body.contains(lowerQuery)) {
          results.add(event);
          if (results.length >= limit) break;
        }
      }

      // 如果结果不够，尝试加载更多历史
      if (results.length < limit) {
        await timeline.requestHistory(historyCount: 100);

        for (final event in timeline.events) {
          if (!_isMessageEvent(event)) continue;
          if (results.any((e) => e.eventId == event.eventId)) continue;

          final body = event.body.toLowerCase();
          if (body.contains(lowerQuery)) {
            results.add(event);
            if (results.length >= limit) break;
          }
        }
      }
    } catch (e) {
      // 搜索失败
    }

    return results;
  }

  /// 全局搜索消息（所有房间）
  Future<List<MessageSearchResult>> searchMessagesGlobally(
    String query, {
    int limit = 50,
    int limitPerRoom = 10,
  }) async {
    if (_client == null || query.trim().isEmpty) return [];

    final results = <MessageSearchResult>[];
    final lowerQuery = query.toLowerCase();

    for (final room in _client!.rooms) {
      if (room.membership != matrix.Membership.join) continue;

      try {
        final timeline = await room.getTimeline();
        var roomResultCount = 0;

        for (final event in timeline.events) {
          if (!_isMessageEvent(event)) continue;

          final body = event.body.toLowerCase();
          if (body.contains(lowerQuery)) {
            results.add(MessageSearchResult(
              event: event,
              room: room,
            ));
            roomResultCount++;

            if (roomResultCount >= limitPerRoom) break;
          }
        }

        if (results.length >= limit) break;
      } catch (e) {
        // 继续搜索其他房间
      }
    }

    // 按时间排序
    results.sort((a, b) {
      final aTime = a.event.originServerTs ?? DateTime.now();
      final bTime = b.event.originServerTs ?? DateTime.now();
      return bTime.compareTo(aTime);
    });

    return results.take(limit).toList();
  }

  /// 检查是否是消息事件
  bool _isMessageEvent(matrix.Event event) {
    return event.type == matrix.EventTypes.Message &&
        event.messageType != null &&
        event.status != matrix.EventStatus.error;
  }

  // ============================================
  // 搜索历史
  // ============================================

  /// 获取最近的搜索记录
  /// 注：这需要本地存储实现，这里只是接口定义
  Future<List<String>> getRecentSearches({int limit = 10}) async {
    // TODO: 从本地存储读取
    return [];
  }

  /// 保存搜索记录
  Future<void> saveSearchQuery(String query) async {
    // TODO: 保存到本地存储
  }

  /// 清除搜索历史
  Future<void> clearSearchHistory() async {
    // TODO: 清除本地存储
  }
}

/// 消息搜索结果
class MessageSearchResult {
  final matrix.Event event;
  final matrix.Room room;

  MessageSearchResult({
    required this.event,
    required this.room,
  });
}

