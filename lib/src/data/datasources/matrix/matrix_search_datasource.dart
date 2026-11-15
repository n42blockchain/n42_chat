import 'dart:convert';

import 'package:matrix/matrix.dart' as matrix;
import 'package:shared_preferences/shared_preferences.dart';

import 'matrix_client_manager.dart';
import '../../../core/utils/debug_log.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/entities/search_result_entity.dart';

const _kSearchHistoryKey = 'n42_chat_search_history';
const _kSearchHistoryLimit = 20;

/// Matrix搜索数据源
///
/// 封装Matrix SDK的搜索相关操作
class MatrixSearchDataSource {
  final MatrixClientManager _clientManager;

  MatrixSearchDataSource(this._clientManager);

  /// 获取Matrix客户端
  matrix.Client? get _client => _clientManager.client;

  bool Function() _captureSearchSession() {
    final client = _client;
    final user = client?.userID;
    final token = client?.accessToken;
    final device = client?.deviceID;
    final server = client?.homeserver;
    return () =>
        identical(_client, client) &&
        client?.userID == user &&
        client?.accessToken == token &&
        client?.deviceID == device &&
        client?.homeserver == server;
  }

  // ============================================
  // 全局搜索
  // ============================================

  /// 搜索用户
  Future<List<matrix.Profile>> searchUsers(
    String query, {
    int limit = 20,
  }) async {
    if (_client == null || query.trim().isEmpty) return [];

    final current = _captureSearchSession();
    try {
      final result = await _client!.searchUserDirectory(query, limit: limit);
      return current() ? result.results : [];
    } catch (e) {
      return [];
    }
  }

  /// 搜索公开房间
  Future<List<matrix.PublishedRoomsChunk>> searchPublicRooms(
    String query, {
    int limit = 20,
  }) async {
    if (_client == null) return [];

    final current = _captureSearchSession();
    try {
      final result = await _client!.queryPublicRooms(
        limit: limit,
        filter: matrix.PublicRoomQueryFilter(genericSearchTerm: query),
      );
      return current() ? result.chunk : [];
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
      final topic = room.topic.toLowerCase();

      return name.contains(lowerQuery) || topic.contains(lowerQuery);
    }).toList();
  }

  /// 搜索本地会话（私聊）
  List<matrix.Room> searchLocalConversations(String query) {
    if (_client == null || query.trim().isEmpty) return [];

    final lowerQuery = query.toLowerCase();

    return _client!.rooms.where((room) {
      if (room.membership != matrix.Membership.join) return false;
      if (!room.isDirectChat) return false;

      final name = room.getLocalizedDisplayname().toLowerCase();
      final topic = room.topic.toLowerCase();

      // 检查最后一条消息
      final lastEvent = room.lastEvent;
      final lastMessage = lastEvent?.body.toLowerCase() ?? '';

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
    MessageSearchFilter? filter,
    int limit = 50,
  }) async {
    final current = _captureSearchSession();
    final room = _client?.getRoomById(roomId);
    if (room == null || query.trim().isEmpty || limit <= 0) return [];

    final lowerQuery = query.toLowerCase();
    final results = <matrix.Event>[];

    matrix.Timeline? timeline;
    try {
      timeline = await room.getTimeline();
      if (!current()) return [];

      // 遍历时间线中的消息
      for (final event in timeline.events) {
        if (!_isMessageEvent(event)) continue;

        if (_matchesMessageSearch(event, lowerQuery, filter)) {
          results.add(event);
          if (results.length >= limit) break;
        }
      }

      // 如果结果不够，尝试加载更多历史
      if (results.length < limit) {
        await timeline.requestHistory(historyCount: 100);
        if (!current()) return [];

        for (final event in timeline.events) {
          if (!_isMessageEvent(event)) continue;
          if (results.any((e) => e.eventId == event.eventId)) continue;

          if (_matchesMessageSearch(event, lowerQuery, filter)) {
            results.add(event);
            if (results.length >= limit) break;
          }
        }
      }
    } catch (e) {
      // 搜索失败
      debugLog('Error: $e');
    } finally {
      timeline?.cancelSubscriptions();
    }

    return current() ? results : [];
  }

  /// 全局搜索消息（所有房间）
  Future<List<MessageSearchResult>> searchMessagesGlobally(
    String query, {
    MessageSearchFilter? filter,
    int limit = 50,
    int limitPerRoom = 10,
  }) async {
    final current = _captureSearchSession();
    final client = _client;
    if (client == null ||
        query.trim().isEmpty ||
        limit <= 0 ||
        limitPerRoom <= 0) {
      return [];
    }

    final results = <MessageSearchResult>[];
    final lowerQuery = query.toLowerCase();

    for (final room in List<matrix.Room>.of(client.rooms)) {
      if (!current()) return [];
      if (room.membership != matrix.Membership.join) continue;

      matrix.Timeline? timeline;
      try {
        timeline = await room.getTimeline();
        if (!current()) return [];
        var roomResultCount = 0;

        for (final event in timeline.events) {
          if (!_isMessageEvent(event)) continue;

          if (_matchesMessageSearch(event, lowerQuery, filter)) {
            results.add(MessageSearchResult(event: event, room: room));
            roomResultCount++;

            if (roomResultCount >= limitPerRoom) break;
          }
        }

        if (results.length >= limit) break;
      } catch (e) {
        // 继续搜索其他房间
        debugLog('Error: $e');
      } finally {
        timeline?.cancelSubscriptions();
      }
    }

    if (!current()) return [];
    // 按时间排序
    results.sort((a, b) {
      final aTime = a.event.originServerTs;
      final bTime = b.event.originServerTs;
      return bTime.compareTo(aTime);
    });

    return results.take(limit).toList();
  }

  /// 检查是否是消息事件
  bool _isMessageEvent(matrix.Event event) {
    return event.type == matrix.EventTypes.Message &&
        !event.redacted &&
        event.status != matrix.EventStatus.error;
  }

  bool _matchesMessageSearch(
    matrix.Event event,
    String lowerQuery,
    MessageSearchFilter? filter,
  ) {
    final body = event.body.toLowerCase();
    if (!body.contains(lowerQuery)) {
      return false;
    }

    if (filter == null || filter.isEmpty) {
      return true;
    }

    final senderId = event.senderId;
    if (filter.onlyFromMe && senderId != _client?.userID) {
      return false;
    }
    if (filter.senderId != null &&
        filter.senderId!.isNotEmpty &&
        senderId != filter.senderId) {
      return false;
    }

    final timestamp = event.originServerTs;
    if (filter.sentAfter != null && timestamp.isBefore(filter.sentAfter!)) {
      return false;
    }
    if (filter.sentBefore != null && timestamp.isAfter(filter.sentBefore!)) {
      return false;
    }

    final messageType = _mapMatrixMessageType(event);
    if (filter.messageType != null && messageType != filter.messageType) {
      return false;
    }
    if (filter.hasMediaOnly && !_isMediaType(messageType)) {
      return false;
    }

    return true;
  }

  MessageType _mapMatrixMessageType(matrix.Event event) {
    switch (event.messageType) {
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
      default:
        final contentMsgType = event.content['msgtype'] as String?;
        switch (contentMsgType) {
          case 'org.matrix.msc1767.text':
          case 'm.text':
            return MessageType.text;
          case 'n42.contact_card':
            return MessageType.contactCard;
          case 'org.matrix.msc3381.poll.start':
            return MessageType.poll;
          default:
            return MessageType.text;
        }
    }
  }

  bool _isMediaType(MessageType type) {
    return type == MessageType.image ||
        type == MessageType.video ||
        type == MessageType.audio ||
        type == MessageType.voice ||
        type == MessageType.file;
  }

  // ============================================
  // 搜索历史
  // ============================================

  // Shared across data-source instances in this isolate. Reads join the queue
  // so they cannot observe the optimistic cache of an unfinished mutation.
  static Future<void> _historyQueue = Future<void>.value();

  Future<T> _withHistory<T>(
    T empty,
    Future<T> Function(SharedPreferences prefs, String key) operation,
  ) {
    final client = _client;
    final user = client?.userID;
    final server = client?.homeserver;
    final token = client?.accessToken;
    final device = client?.deviceID;
    if (client == null || user == null || server == null || token == null) {
      return Future.value(empty);
    }
    // Never adopt the legacy unowned key into the first account that logs in.
    final key =
        '${_kSearchHistoryKey}_v2_${base64Url.encode(utf8.encode(jsonEncode([server.toString(), user])))}';
    bool current() =>
        identical(_client, client) &&
        client.userID == user &&
        client.homeserver == server &&
        client.accessToken == token &&
        client.deviceID == device;
    final result = _historyQueue.then((_) async {
      if (!current()) return empty;
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      if (!current()) return empty;
      final value = await operation(prefs, key);
      return current() ? value : empty;
    });
    _historyQueue = result.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return result;
  }

  List<String> _readHistory(SharedPreferences prefs, String key) {
    final raw = prefs.getString(key);
    if (raw == null) return [];
    final decoded = jsonDecode(raw);
    if (decoded is! List || decoded.any((value) => value is! String)) {
      throw const FormatException('Invalid search history');
    }
    return decoded.cast<String>().toList();
  }

  Future<void> _writeHistory(
    SharedPreferences prefs,
    String key,
    List<String>? values,
  ) async {
    try {
      final saved = values == null
          ? await prefs.remove(key)
          : await prefs.setString(key, jsonEncode(values));
      if (!saved) throw StateError('Search history write failed');
    } catch (_) {
      // SharedPreferences changes its cache before platform acknowledgement.
      await prefs.reload();
      rethrow;
    }
  }

  /// Account-scoped recent searches; unauthenticated callers see no history.
  Future<List<String>> getRecentSearches({int limit = 10}) => _withHistory(
    <String>[],
    (prefs, key) async =>
        _readHistory(prefs, key).take(limit < 0 ? 0 : limit).toList(),
  );

  Future<void> saveSearchQuery(String query) {
    if (query.trim().isEmpty) return Future.value();
    return _withHistory<void>(null, (prefs, key) async {
      final list = _readHistory(prefs, key)..remove(query);
      list.insert(0, query);
      await _writeHistory(prefs, key, list.take(_kSearchHistoryLimit).toList());
    });
  }

  Future<void> clearSearchHistory() =>
      _withHistory<void>(null, (prefs, key) => _writeHistory(prefs, key, null));

  Future<void> deleteSearchQuery(String query) {
    if (query.trim().isEmpty) return Future.value();
    return _withHistory<void>(null, (prefs, key) async {
      final list = _readHistory(prefs, key)..remove(query);
      await _writeHistory(prefs, key, list);
    });
  }
}

/// 消息搜索结果
class MessageSearchResult {
  final matrix.Event event;
  final matrix.Room room;

  MessageSearchResult({required this.event, required this.room});
}
