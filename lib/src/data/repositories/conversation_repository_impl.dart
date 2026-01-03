import 'dart:async';

import 'package:matrix/matrix.dart' as matrix;

import '../../core/utils/matrix_utils.dart';
import '../../domain/entities/conversation_entity.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../datasources/matrix/matrix_room_datasource.dart';

/// 会话仓库实现
class ConversationRepositoryImpl implements IConversationRepository {
  final MatrixRoomDataSource _roomDataSource;

  ConversationRepositoryImpl(this._roomDataSource);

  @override
  Future<List<ConversationEntity>> getConversations() async {
    final rooms = _roomDataSource.getSortedRooms();
    return rooms.map(_mapRoomToEntity).toList();
  }

  @override
  Stream<List<ConversationEntity>> watchConversations() {
    return _roomDataSource.onRoomsChanged?.map(
          (rooms) => rooms.map(_mapRoomToEntity).toList(),
        ) ??
        const Stream.empty();
  }

  @override
  Future<ConversationEntity?> getConversationById(String id) async {
    final room = _roomDataSource.getRoomById(id);
    if (room == null) return null;
    return _mapRoomToEntity(room);
  }

  @override
  Stream<ConversationEntity?> watchConversation(String id) {
    return _roomDataSource.watchRoom(id)?.map((room) {
          if (room == null) return null;
          return _mapRoomToEntity(room);
        }) ??
        const Stream.empty();
  }

  @override
  Future<ConversationEntity> createDirectChat(String userId) async {
    final roomId = await _roomDataSource.createDirectChat(userId);
    final room = _roomDataSource.getRoomById(roomId);
    if (room == null) {
      throw Exception('Failed to create direct chat');
    }
    return _mapRoomToEntity(room);
  }

  @override
  Future<ConversationEntity> createGroupChat({
    required String name,
    String? topic,
    List<String>? memberIds,
    bool encrypted = true,
  }) async {
    final roomId = await _roomDataSource.createGroupChat(
      name: name,
      topic: topic,
      inviteUserIds: memberIds,
      encrypted: encrypted,
    );
    final room = _roomDataSource.getRoomById(roomId);
    if (room == null) {
      throw Exception('Failed to create group chat');
    }
    return _mapRoomToEntity(room);
  }

  @override
  Future<void> joinConversation(String conversationIdOrAlias) async {
    await _roomDataSource.joinRoom(conversationIdOrAlias);
  }

  @override
  Future<void> leaveConversation(String conversationId) async {
    await _roomDataSource.leaveRoom(conversationId);
  }

  @override
  Future<void> deleteConversation(String conversationId) async {
    // Matrix中离开房间即为删除
    await _roomDataSource.leaveRoom(conversationId);
  }

  @override
  Future<void> setMuted(String conversationId, bool muted) async {
    await _roomDataSource.setRoomMuted(conversationId, muted);
  }

  @override
  Future<void> setPinned(String conversationId, bool pinned) async {
    await _roomDataSource.setRoomPinned(conversationId, pinned);
  }

  @override
  Future<void> markAsRead(String conversationId) async {
    await _roomDataSource.markRoomAsRead(conversationId);
  }

  @override
  Future<int> getTotalUnreadCount() async {
    final rooms = _roomDataSource.getJoinedRooms();
    return rooms.fold<int>(0, (sum, room) {
      return sum + _roomDataSource.getUnreadCount(room);
    });
  }

  @override
  Stream<int> watchTotalUnreadCount() {
    return watchConversations().map((conversations) {
      return conversations.fold<int>(0, (sum, conv) => sum + conv.unreadCount);
    });
  }

  @override
  Future<List<ConversationEntity>> searchConversations(String query) async {
    if (query.isEmpty) return getConversations();

    final lowerQuery = query.toLowerCase();
    final rooms = _roomDataSource.getJoinedRooms();

    return rooms
        .where((room) {
          final name = _roomDataSource.getRoomDisplayName(room).toLowerCase();
          return name.contains(lowerQuery);
        })
        .map(_mapRoomToEntity)
        .toList();
  }

  // ============================================
  // 辅助方法
  // ============================================

  /// 将Matrix Room转换为ConversationEntity
  ConversationEntity _mapRoomToEntity(matrix.Room room) {
    final avatarUrl = _roomDataSource.getRoomAvatarUrl(room);
    final lastMessageTime = _roomDataSource.getLastMessageTime(room);
    
    // 获取群成员头像列表（用于九宫格头像）
    List<String?>? memberAvatarUrls;
    List<String>? memberNames;
    
    if (!room.isDirectChat) {
      final members = _getGroupMemberInfo(room);
      memberAvatarUrls = members.$1;
      memberNames = members.$2;
    }

    return ConversationEntity(
      id: room.id,
      name: _roomDataSource.getRoomDisplayName(room),
      avatarUrl: avatarUrl,
      type: room.isDirectChat
          ? ConversationType.direct
          : ConversationType.group,
      lastMessage: _roomDataSource.getLastMessagePreview(room),
      lastMessageTime: lastMessageTime,
      lastMessageSenderId: room.lastEvent?.senderId,
      unreadCount: _roomDataSource.getUnreadCount(room),
      highlightCount: _roomDataSource.getHighlightCount(room),
      isMuted: _roomDataSource.isMuted(room),
      isPinned: room.isFavourite,
      isEncrypted: _roomDataSource.isEncrypted(room),
      memberCount: _roomDataSource.getMemberCount(room),
      memberAvatarUrls: memberAvatarUrls,
      memberNames: memberNames,
    );
  }
  
  /// 获取群成员头像和名称列表（最多9个，用于九宫格头像）
  /// 参照微信：包含自己，按加入顺序排列
  (List<String?>, List<String>) _getGroupMemberInfo(matrix.Room room) {
    final client = room.client;
    
    final avatarUrls = <String?>[];
    final names = <String>[];
    
    // 获取已加入的成员（包括自己，最多取9个）
    final participants = room.getParticipants();
    
    int count = 0;
    for (final member in participants) {
      if (count >= 9) break;
      if (member.membership != matrix.Membership.join) continue; // 只取已加入的成员
      
      // 获取头像 URL
      final mxcUri = member.avatarUrl;
      String? httpUrl;
      if (mxcUri != null) {
        httpUrl = MatrixUtils.mxcToHttp(
          mxcUri.toString(),
          client: client,
          width: 64,
          height: 64,
        );
      }
      
      avatarUrls.add(httpUrl);
      names.add(member.displayName ?? member.id.localpart ?? '');
      count++;
    }
    
    return (avatarUrls, names);
  }
}

