import 'package:equatable/equatable.dart';

import 'contact_entity.dart';
import 'conversation_entity.dart';
import 'message_entity.dart';

/// 搜索结果类型
enum SearchResultType {
  /// 联系人
  contact,
  /// 群聊
  group,
  /// 会话
  conversation,
  /// 消息
  message,
  /// 全部
  all,
}

/// 搜索结果项
class SearchResultItem extends Equatable {
  /// 结果类型
  final SearchResultType type;

  /// 唯一标识符
  final String id;

  /// 标题（联系人名/群名/会话名）
  final String title;

  /// 副标题/描述
  final String? subtitle;

  /// 头像URL
  final String? avatarUrl;

  /// 匹配的关键词
  final String? matchedKeyword;

  /// 匹配的内容（用于消息搜索）
  final String? matchedContent;

  /// 时间戳
  final DateTime? timestamp;

  /// 关联的房间ID
  final String? roomId;

  /// 原始数据
  final dynamic rawData;

  const SearchResultItem({
    required this.type,
    required this.id,
    required this.title,
    this.subtitle,
    this.avatarUrl,
    this.matchedKeyword,
    this.matchedContent,
    this.timestamp,
    this.roomId,
    this.rawData,
  });

  /// 从联系人创建
  factory SearchResultItem.fromContact(ContactEntity contact, {String? matchedKeyword}) {
    return SearchResultItem(
      type: SearchResultType.contact,
      id: contact.userId,
      title: contact.effectiveDisplayName,
      subtitle: contact.statusMessage ?? contact.userId,
      avatarUrl: contact.avatarUrl,
      matchedKeyword: matchedKeyword,
      rawData: contact,
    );
  }

  /// 从会话创建
  factory SearchResultItem.fromConversation(ConversationEntity conversation, {String? matchedKeyword}) {
    return SearchResultItem(
      type: conversation.isGroup ? SearchResultType.group : SearchResultType.conversation,
      id: conversation.id,
      title: conversation.name,
      subtitle: conversation.lastMessage,
      avatarUrl: conversation.avatarUrl,
      matchedKeyword: matchedKeyword,
      timestamp: conversation.lastMessageTime,
      roomId: conversation.id,
      rawData: conversation,
    );
  }

  /// 从消息创建
  factory SearchResultItem.fromMessage(
    MessageEntity message, {
    required String roomId,
    required String roomName,
    String? roomAvatarUrl,
    String? matchedKeyword,
  }) {
    return SearchResultItem(
      type: SearchResultType.message,
      id: message.id,
      title: roomName,
      subtitle: message.senderName ?? message.senderId,
      avatarUrl: roomAvatarUrl,
      matchedKeyword: matchedKeyword,
      matchedContent: message.content,
      timestamp: message.timestamp ?? DateTime.now(),
      roomId: roomId,
      rawData: message,
    );
  }

  @override
  List<Object?> get props => [
        type,
        id,
        title,
        subtitle,
        avatarUrl,
        matchedKeyword,
        matchedContent,
        timestamp,
        roomId,
      ];
}

/// 搜索结果集合
class SearchResults extends Equatable {
  /// 联系人结果
  final List<SearchResultItem> contacts;

  /// 群聊结果
  final List<SearchResultItem> groups;

  /// 会话结果
  final List<SearchResultItem> conversations;

  /// 消息结果
  final List<SearchResultItem> messages;

  /// 搜索关键词
  final String query;

  /// 是否正在搜索
  final bool isSearching;

  /// 是否有更多结果
  final bool hasMore;

  const SearchResults({
    this.contacts = const [],
    this.groups = const [],
    this.conversations = const [],
    this.messages = const [],
    this.query = '',
    this.isSearching = false,
    this.hasMore = false,
  });

  /// 所有结果
  List<SearchResultItem> get allResults => [
        ...contacts,
        ...groups,
        ...conversations,
        ...messages,
      ];

  /// 总结果数
  int get totalCount =>
      contacts.length + groups.length + conversations.length + messages.length;

  /// 是否为空
  bool get isEmpty => totalCount == 0;

  /// 是否有联系人结果
  bool get hasContacts => contacts.isNotEmpty;

  /// 是否有群聊结果
  bool get hasGroups => groups.isNotEmpty;

  /// 是否有会话结果
  bool get hasConversations => conversations.isNotEmpty;

  /// 是否有消息结果
  bool get hasMessages => messages.isNotEmpty;

  @override
  List<Object?> get props => [
        contacts,
        groups,
        conversations,
        messages,
        query,
        isSearching,
        hasMore,
      ];

  SearchResults copyWith({
    List<SearchResultItem>? contacts,
    List<SearchResultItem>? groups,
    List<SearchResultItem>? conversations,
    List<SearchResultItem>? messages,
    String? query,
    bool? isSearching,
    bool? hasMore,
  }) {
    return SearchResults(
      contacts: contacts ?? this.contacts,
      groups: groups ?? this.groups,
      conversations: conversations ?? this.conversations,
      messages: messages ?? this.messages,
      query: query ?? this.query,
      isSearching: isSearching ?? this.isSearching,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

/// 聊天内搜索结果
class ChatSearchResults extends Equatable {
  /// 消息结果
  final List<MessageEntity> messages;

  /// 搜索关键词
  final String query;

  /// 房间ID
  final String roomId;

  /// 当前索引（用于导航）
  final int currentIndex;

  /// 是否正在搜索
  final bool isSearching;

  /// 是否有更多结果
  final bool hasMore;

  const ChatSearchResults({
    this.messages = const [],
    this.query = '',
    this.roomId = '',
    this.currentIndex = 0,
    this.isSearching = false,
    this.hasMore = false,
  });

  /// 总结果数
  int get totalCount => messages.length;

  /// 是否为空
  bool get isEmpty => messages.isEmpty;

  /// 当前消息
  MessageEntity? get currentMessage {
    if (messages.isEmpty || currentIndex < 0 || currentIndex >= messages.length) {
      return null;
    }
    return messages[currentIndex];
  }

  /// 是否有上一条
  bool get hasPrevious => currentIndex > 0;

  /// 是否有下一条
  bool get hasNext => currentIndex < messages.length - 1;

  @override
  List<Object?> get props => [
        messages,
        query,
        roomId,
        currentIndex,
        isSearching,
        hasMore,
      ];

  ChatSearchResults copyWith({
    List<MessageEntity>? messages,
    String? query,
    String? roomId,
    int? currentIndex,
    bool? isSearching,
    bool? hasMore,
  }) {
    return ChatSearchResults(
      messages: messages ?? this.messages,
      query: query ?? this.query,
      roomId: roomId ?? this.roomId,
      currentIndex: currentIndex ?? this.currentIndex,
      isSearching: isSearching ?? this.isSearching,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

