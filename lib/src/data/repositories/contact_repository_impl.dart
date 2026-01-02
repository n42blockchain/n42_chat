import 'dart:async';

import 'package:matrix/matrix.dart' as matrix;

import '../../domain/entities/contact_entity.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/local/secure_storage_datasource.dart';
import '../datasources/matrix/matrix_contact_datasource.dart';

/// 联系人仓库实现
class ContactRepositoryImpl implements IContactRepository {
  final MatrixContactDataSource _contactDataSource;
  final SecureStorageDataSource _storageDataSource;

  /// 备注缓存
  Map<String, String> _remarkCache = {};

  ContactRepositoryImpl(this._contactDataSource, this._storageDataSource);

  /// 加载备注缓存
  Future<void> _loadRemarkCache() async {
    _remarkCache = await _storageDataSource.getContactRemarks();
  }

  @override
  Future<List<ContactEntity>> getContacts() async {
    // 先加载备注缓存
    await _loadRemarkCache();
    
    final users = _contactDataSource.getDirectChatContacts();
    return users.map(_mapUserToEntity).toList()
      ..sort((a, b) => a.sortKey.compareTo(b.sortKey));
  }

  @override
  Stream<List<ContactEntity>> watchContacts() async* {
    // 初始数据
    yield await getContacts();

    // 监听变化
    final stream = _contactDataSource.onContactsChanged;
    if (stream != null) {
      await for (final _ in stream) {
        yield await getContacts();
      }
    }
  }

  @override
  Future<ContactEntity?> getContactById(String userId) async {
    final profile = await _contactDataSource.getUserProfile(userId);
    if (profile == null) return null;

    return _mapProfileToEntity(userId, profile);
  }

  @override
  Future<List<ContactEntity>> searchContacts(String query) async {
    if (query.trim().isEmpty) return getContacts();

    final contacts = await getContacts();
    final lowerQuery = query.toLowerCase();

    return contacts.where((contact) {
      return contact.displayName.toLowerCase().contains(lowerQuery) ||
          contact.userId.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<List<ContactEntity>> searchUsers(String query, {int limit = 20}) async {
    if (query.trim().isEmpty) return [];

    final profiles = await _contactDataSource.searchUsers(query, limit: limit);

    // 在线状态需要异步获取，这里先返回离线状态，后续可以单独更新
    return profiles.map((profile) {
      final avatarUrl = _contactDataSource.getProfileAvatarUrl(profile);
      return ContactEntity(
        userId: profile.userId,
        displayName: profile.displayName ?? profile.userId,
        avatarUrl: avatarUrl,
        // 默认离线，实际在线状态可以在UI层异步更新
        presence: PresenceStatus.offline,
      );
    }).toList();
  }

  @override
  Future<String> startDirectChat(String userId) async {
    return await _contactDataSource.startDirectChat(userId);
  }

  @override
  String? getDirectChatRoomId(String userId) {
    return _contactDataSource.getDirectChatRoomId(userId);
  }

  @override
  Future<void> ignoreUser(String userId) async {
    await _contactDataSource.ignoreUser(userId);
  }

  @override
  Future<void> unignoreUser(String userId) async {
    await _contactDataSource.unignoreUser(userId);
  }

  @override
  bool isUserIgnored(String userId) {
    return _contactDataSource.isUserIgnored(userId);
  }

  @override
  Future<List<ContactEntity>> getIgnoredUsers() async {
    final ignoredIds = _contactDataSource.ignoredUsers;
    final contacts = <ContactEntity>[];

    for (final userId in ignoredIds) {
      final profile = await _contactDataSource.getUserProfile(userId);
      if (profile != null) {
        contacts.add(_mapProfileToEntity(userId, profile));
      }
    }

    return contacts;
  }

  @override
  Future<List<FriendRequest>> getPendingFriendRequests() async {
    final invites = _contactDataSource.getPendingInvites();

    return invites.map((room) {
      final inviter = room.getState(matrix.EventTypes.RoomMember)?.senderId;
      final user = inviter != null
          ? room.unsafeGetUserFromMemoryOrFallback(inviter)
          : null;
      
      // 手动构建头像 URL
      String? avatarUrl;
      if (user?.avatarUrl != null) {
        avatarUrl = _contactDataSource.getUserAvatarUrl(user!);
      }

      return FriendRequest(
        id: room.id,
        userId: inviter ?? '',
        userName: user?.calcDisplayname() ?? inviter ?? '未知用户',
        userAvatarUrl: avatarUrl,
        requestTime: null, // StrippedStateEvent doesn't have originServerTs
      );
    }).toList();
  }

  @override
  Future<void> acceptFriendRequest(String requestId) async {
    await _contactDataSource.acceptInvite(requestId);
  }

  @override
  Future<void> rejectFriendRequest(String requestId) async {
    await _contactDataSource.rejectInvite(requestId);
  }

  @override
  bool isUserOnline(String userId) {
    // 同步版本，返回false，实际使用需要异步调用
    return false;
  }

  @override
  DateTime? getLastActiveTime(String userId) {
    // 同步版本，返回null，实际使用需要异步调用
    return null;
  }

  /// 异步获取用户是否在线
  Future<bool> isUserOnlineAsync(String userId) async {
    return await _contactDataSource.isUserOnline(userId);
  }

  /// 异步获取用户最后活动时间
  Future<DateTime?> getLastActiveTimeAsync(String userId) async {
    return await _contactDataSource.getLastActiveTime(userId);
  }

  @override
  Stream<Map<String, bool>> watchOnlineStatus() async* {
    final stream = _contactDataSource.onPresenceChanged;
    if (stream == null) return;

    final statusMap = <String, bool>{};

    await for (final presence in stream) {
      statusMap[presence.userid] =
          presence.presence == matrix.PresenceType.online;
      yield Map.from(statusMap);
    }
  }

  // ============================================
  // 辅助方法
  // ============================================

  ContactEntity _mapUserToEntity(matrix.User user) {
    final avatarUrl = _contactDataSource.getUserAvatarUrl(user);
    final remark = _remarkCache[user.id];

    return ContactEntity(
      userId: user.id,
      displayName: _contactDataSource.getUserDisplayName(user),
      avatarUrl: avatarUrl,
      // 在线状态需要异步获取，这里默认离线
      presence: PresenceStatus.offline,
      remark: remark,
    );
  }

  ContactEntity _mapProfileToEntity(String userId, matrix.Profile profile) {
    final avatarUrl = _contactDataSource.getProfileAvatarUrl(profile);
    final remark = _remarkCache[userId];

    return ContactEntity(
      userId: userId,
      displayName: profile.displayName ?? userId,
      avatarUrl: avatarUrl,
      // 在线状态需要异步获取，这里默认离线
      presence: PresenceStatus.offline,
      remark: remark,
    );
  }

  @override
  Future<void> setContactRemark(String userId, String? remark) async {
    await _storageDataSource.setContactRemark(userId, remark);
    // 更新缓存
    if (remark == null || remark.isEmpty) {
      _remarkCache.remove(userId);
    } else {
      _remarkCache[userId] = remark;
    }
  }

  @override
  Future<String?> getContactRemark(String userId) async {
    // 先检查缓存
    if (_remarkCache.containsKey(userId)) {
      return _remarkCache[userId];
    }
    // 从存储中读取
    return await _storageDataSource.getContactRemark(userId);
  }

  @override
  Future<Map<String, String>> getContactRemarks() async {
    await _loadRemarkCache();
    return Map.from(_remarkCache);
  }
}

