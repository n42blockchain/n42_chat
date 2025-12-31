import 'package:equatable/equatable.dart';

import '../../../domain/entities/contact_entity.dart';
import '../../../domain/repositories/contact_repository.dart';

/// 联系人状态基类
abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object?> get props => [];
}

/// 联系人初始状态
class ContactInitial extends ContactState {
  const ContactInitial();
}

/// 联系人加载中
class ContactLoading extends ContactState {
  const ContactLoading();
}

/// 联系人加载完成
class ContactLoaded extends ContactState {
  /// 所有联系人
  final List<ContactEntity> contacts;

  /// 过滤后的联系人（搜索结果）
  final List<ContactEntity> filteredContacts;

  /// 搜索结果（全局搜索）
  final List<ContactEntity> searchResults;

  /// 好友请求列表
  final List<FriendRequest> friendRequests;

  /// 按字母分组的联系人
  final Map<String, List<ContactEntity>> groupedContacts;

  /// 索引字母列表
  final List<String> indexLetters;

  /// 搜索关键词
  final String searchQuery;

  /// 是否正在搜索
  final bool isSearching;

  /// 是否正在全局搜索
  final bool isGlobalSearching;

  const ContactLoaded({
    required this.contacts,
    this.filteredContacts = const [],
    this.searchResults = const [],
    this.friendRequests = const [],
    this.groupedContacts = const {},
    this.indexLetters = const [],
    this.searchQuery = '',
    this.isSearching = false,
    this.isGlobalSearching = false,
  });

  @override
  List<Object?> get props => [
        contacts,
        filteredContacts,
        searchResults,
        friendRequests,
        groupedContacts,
        indexLetters,
        searchQuery,
        isSearching,
        isGlobalSearching,
      ];

  ContactLoaded copyWith({
    List<ContactEntity>? contacts,
    List<ContactEntity>? filteredContacts,
    List<ContactEntity>? searchResults,
    List<FriendRequest>? friendRequests,
    Map<String, List<ContactEntity>>? groupedContacts,
    List<String>? indexLetters,
    String? searchQuery,
    bool? isSearching,
    bool? isGlobalSearching,
  }) {
    return ContactLoaded(
      contacts: contacts ?? this.contacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      searchResults: searchResults ?? this.searchResults,
      friendRequests: friendRequests ?? this.friendRequests,
      groupedContacts: groupedContacts ?? this.groupedContacts,
      indexLetters: indexLetters ?? this.indexLetters,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
      isGlobalSearching: isGlobalSearching ?? this.isGlobalSearching,
    );
  }
}

/// 联系人加载失败
class ContactError extends ContactState {
  final String message;

  const ContactError(this.message);

  @override
  List<Object?> get props => [message];
}

/// 开始聊天成功
class ChatStarted extends ContactState {
  final String roomId;
  final String userId;

  const ChatStarted({
    required this.roomId,
    required this.userId,
  });

  @override
  List<Object?> get props => [roomId, userId];
}

