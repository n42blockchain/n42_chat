import 'package:matrix/matrix.dart' as matrix;

import '../../domain/entities/contact_entity.dart';
import '../../domain/entities/conversation_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/entities/search_result_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/matrix/matrix_search_datasource.dart';
import '../datasources/matrix/matrix_client_manager.dart';

/// 搜索仓库实现
class SearchRepositoryImpl implements ISearchRepository {
  final MatrixSearchDataSource _searchDataSource;
  final MatrixClientManager _clientManager;

  // 本地搜索历史
  final List<String> _searchHistory = [];

  SearchRepositoryImpl(this._searchDataSource, this._clientManager);

  @override
  Future<SearchResults> searchGlobal(
    String query, {
    SearchResultType? type,
    int limit = 50,
  }) async {
    if (query.trim().isEmpty) {
      return const SearchResults();
    }

    // 保存搜索记录
    await saveSearchQuery(query);

    List<SearchResultItem> contacts = [];
    List<SearchResultItem> groups = [];
    List<SearchResultItem> conversations = [];
    List<SearchResultItem> messages = [];

    // 根据类型搜索
    if (type == null || type == SearchResultType.all) {
      contacts = await searchContacts(query, limit: limit ~/ 4);
      groups = await searchGroups(query, limit: limit ~/ 4);
      conversations = await searchConversations(query, limit: limit ~/ 4);
      messages = await searchMessages(query, limit: limit ~/ 4);
    } else {
      switch (type) {
        case SearchResultType.contact:
          contacts = await searchContacts(query, limit: limit);
          break;
        case SearchResultType.group:
          groups = await searchGroups(query, limit: limit);
          break;
        case SearchResultType.conversation:
          conversations = await searchConversations(query, limit: limit);
          break;
        case SearchResultType.message:
          messages = await searchMessages(query, limit: limit);
          break;
        case SearchResultType.all:
          break;
      }
    }

    return SearchResults(
      contacts: contacts,
      groups: groups,
      conversations: conversations,
      messages: messages,
      query: query,
    );
  }

  @override
  Future<List<SearchResultItem>> searchContacts(String query, {int limit = 20}) async {
    final users = _searchDataSource.searchLocalContacts(query);

    return users.take(limit).map((user) {
      final contact = _mapUserToContact(user);
      return SearchResultItem.fromContact(contact, matchedKeyword: query);
    }).toList();
  }

  @override
  Future<List<SearchResultItem>> searchGroups(String query, {int limit = 20}) async {
    final rooms = _searchDataSource.searchLocalGroups(query);

    return rooms.take(limit).map((room) {
      final conversation = _mapRoomToConversation(room);
      return SearchResultItem.fromConversation(conversation, matchedKeyword: query);
    }).toList();
  }

  @override
  Future<List<SearchResultItem>> searchConversations(String query, {int limit = 20}) async {
    final rooms = _searchDataSource.searchLocalConversations(query);

    return rooms.take(limit).map((room) {
      final conversation = _mapRoomToConversation(room);
      return SearchResultItem.fromConversation(conversation, matchedKeyword: query);
    }).toList();
  }

  @override
  Future<List<SearchResultItem>> searchMessages(
    String query, {
    int limit = 50,
    String? roomId,
  }) async {
    if (roomId != null) {
      // 在指定房间搜索
      final events = await _searchDataSource.searchMessagesInRoom(
        roomId,
        query,
        limit: limit,
      );

      final room = _clientManager.client?.getRoomById(roomId);
      final roomName = room?.getLocalizedDisplayname() ?? '未知会话';
      final roomAvatar = _getRoomAvatarUrl(room);

      return events.map((event) {
        final message = _mapEventToMessage(event);
        return SearchResultItem.fromMessage(
          message,
          roomId: roomId,
          roomName: roomName,
          roomAvatarUrl: roomAvatar,
          matchedKeyword: query,
        );
      }).toList();
    } else {
      // 全局搜索消息
      final results = await _searchDataSource.searchMessagesGlobally(
        query,
        limit: limit,
      );

      return results.map((result) {
        final message = _mapEventToMessage(result.event);
        final roomAvatar = _getRoomAvatarUrl(result.room);

        return SearchResultItem.fromMessage(
          message,
          roomId: result.room.id,
          roomName: result.room.getLocalizedDisplayname(),
          roomAvatarUrl: roomAvatar,
          matchedKeyword: query,
        );
      }).toList();
    }
  }

  @override
  Future<ChatSearchResults> searchInChat(
    String roomId,
    String query, {
    int limit = 50,
  }) async {
    if (query.trim().isEmpty) {
      return ChatSearchResults(roomId: roomId);
    }

    final events = await _searchDataSource.searchMessagesInRoom(
      roomId,
      query,
      limit: limit,
    );

    final messages = events.map(_mapEventToMessage).toList();

    return ChatSearchResults(
      messages: messages,
      query: query,
      roomId: roomId,
      currentIndex: messages.isNotEmpty ? 0 : -1,
      hasMore: messages.length >= limit,
    );
  }

  @override
  Future<ChatSearchResults> loadMoreChatSearchResults(
    ChatSearchResults currentResults, {
    int limit = 50,
  }) async {
    // 加载更多结果
    final events = await _searchDataSource.searchMessagesInRoom(
      currentResults.roomId,
      currentResults.query,
      limit: currentResults.messages.length + limit,
    );

    final messages = events.map(_mapEventToMessage).toList();

    return currentResults.copyWith(
      messages: messages,
      hasMore: messages.length >= currentResults.messages.length + limit,
    );
  }

  @override
  Future<List<String>> getRecentSearches({int limit = 10}) async {
    return _searchHistory.take(limit).toList();
  }

  @override
  Future<void> saveSearchQuery(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    // 移除重复项
    _searchHistory.remove(trimmed);

    // 添加到开头
    _searchHistory.insert(0, trimmed);

    // 保持最多20条
    if (_searchHistory.length > 20) {
      _searchHistory.removeLast();
    }
  }

  @override
  Future<void> deleteSearchQuery(String query) async {
    _searchHistory.remove(query);
  }

  @override
  Future<void> clearSearchHistory() async {
    _searchHistory.clear();
  }

  // ============================================
  // 辅助方法
  // ============================================

  ContactEntity _mapUserToContact(matrix.User user) {
    String? avatarUrl;
    final client = _clientManager.client;
    if (user.avatarUrl != null && client != null) {
      avatarUrl = _buildAvatarHttpUrl(user.avatarUrl.toString(), client);
    }

    return ContactEntity(
      userId: user.id,
      displayName: user.calcDisplayname(),
      avatarUrl: avatarUrl,
    );
  }
  
  /// 构建头像 HTTP URL
  String? _buildAvatarHttpUrl(String? mxcUrl, matrix.Client client) {
    if (mxcUrl == null || mxcUrl.isEmpty) return null;
    if (!mxcUrl.startsWith('mxc://')) return mxcUrl;
    
    try {
      final uri = Uri.parse(mxcUrl);
      final serverName = uri.host;
      final mediaId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';
      
      if (serverName.isEmpty || mediaId.isEmpty) return null;
      
      final homeserver = client.homeserver?.toString().replaceAll(RegExp(r'/$'), '') ?? '';
      if (homeserver.isEmpty) return null;
      
      return '$homeserver/_matrix/media/v3/thumbnail/$serverName/$mediaId?width=96&height=96&method=crop';
    } catch (e) {
      return null;
    }
  }

  ConversationEntity _mapRoomToConversation(matrix.Room room) {
    final avatarUrl = _getRoomAvatarUrl(room);
    final lastEvent = room.lastEvent;

    return ConversationEntity(
      id: room.id,
      name: room.getLocalizedDisplayname(),
      avatarUrl: avatarUrl,
      lastMessage: lastEvent?.body,
      lastMessageTime: lastEvent?.originServerTs,
      unreadCount: room.notificationCount,
      type: room.isDirectChat ? ConversationType.direct : ConversationType.group,
      memberCount: room.summary.mJoinedMemberCount ?? 0,
    );
  }

  MessageEntity _mapEventToMessage(matrix.Event event) {
    return MessageEntity(
      id: event.eventId,
      roomId: event.roomId ?? '',
      senderId: event.senderId,
      senderName: event.senderFromMemoryOrFallback.calcDisplayname(),
      content: event.body,
      timestamp: event.originServerTs,
      type: _mapMessageType(event.messageType),
      status: MessageStatus.sent,
    );
  }

  MessageType _mapMessageType(String? msgType) {
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
      default:
        return MessageType.text;
    }
  }

  String? _getRoomAvatarUrl(matrix.Room? room) {
    if (room == null) return null;
    final client = _clientManager.client;
    final avatarMxc = room.avatar?.toString();
    if (avatarMxc == null || client == null) return null;

    return _buildAvatarHttpUrl(avatarMxc, client);
  }
}

/// 消息搜索结果
class MessageSearchResult {
  final matrix.Event event;
  final matrix.Room room;

  MessageSearchResult({required this.event, required this.room});
}
