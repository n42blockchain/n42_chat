import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart' as matrix;

import '../../../domain/entities/moment_entity.dart';
import 'matrix_client_manager.dart';

/// Matrix 动态数据源
///
/// 使用 Matrix 协议实现朋友圈功能
/// 动态存储在用户的个人状态房间中，使用自定义事件类型
class MatrixMomentDataSource {
  final MatrixClientManager _clientManager;

  /// 动态事件类型
  static const String momentEventType = 'n42.moment';

  /// 动态点赞事件类型
  static const String momentLikeEventType = 'n42.moment.like';

  /// 动态评论事件类型
  static const String momentCommentEventType = 'n42.moment.comment';

  /// 动态房间标签
  static const String momentRoomTag = 'n42.moments';

  /// 缓存的动态列表
  final List<MomentEntity> _cachedMoments = [];

  MatrixMomentDataSource(this._clientManager);

  matrix.Client? get _client => _clientManager.client;

  String? get _currentUserId => _client?.userID;

  /// 缓存的动态房间引用
  matrix.Room? _cachedMomentRoom;

  /// 获取或创建用户的动态房间
  Future<matrix.Room?> _getOrCreateMomentRoom() async {
    if (_client == null) {
      debugPrint('MatrixMomentDataSource: Client is null');
      return null;
    }

    // 先检查缓存
    if (_cachedMomentRoom != null) {
      return _cachedMomentRoom;
    }

    debugPrint('MatrixMomentDataSource: Looking for moment room, '
        'total rooms: ${_client!.rooms.length}');

    // 查找现有的动态房间
    for (final room in _client!.rooms) {
      final tags = room.tags;
      if (tags.containsKey(momentRoomTag)) {
        debugPrint('MatrixMomentDataSource: Found existing moment room: ${room.id}');
        _cachedMomentRoom = room;
        return room;
      }
    }

    // 如果房间列表为空，可能同步尚未完成，等待同步
    if (_client!.rooms.isEmpty) {
      debugPrint('MatrixMomentDataSource: No rooms found, waiting for sync...');
      try {
        await _client!.onSync.stream.first.timeout(
          const Duration(seconds: 15),
        );
        debugPrint('MatrixMomentDataSource: Sync completed, '
            'rooms: ${_client!.rooms.length}');

        // 同步后再次查找
        for (final room in _client!.rooms) {
          final tags = room.tags;
          if (tags.containsKey(momentRoomTag)) {
            debugPrint('MatrixMomentDataSource: Found moment room after sync: ${room.id}');
            _cachedMomentRoom = room;
            return room;
          }
        }
      } on TimeoutException {
        debugPrint('MatrixMomentDataSource: Sync timeout, proceeding to create room');
      }
    }

    // 创建新的动态房间
    debugPrint('MatrixMomentDataSource: Creating new moment room...');
    try {
      final roomId = await _client!.createRoom(
        name: 'My Moments',
        visibility: matrix.Visibility.private,
        preset: matrix.CreateRoomPreset.privateChat,
      );

      debugPrint('MatrixMomentDataSource: Room created with id: $roomId');

      // 等待房间出现在本地存储中
      matrix.Room? room = _client!.getRoomById(roomId);

      if (room == null) {
        debugPrint('MatrixMomentDataSource: Room not in local store yet, waiting...');
        // 等待同步将房间带入本地
        for (var i = 0; i < 10; i++) {
          await Future<void>.delayed(const Duration(milliseconds: 500));
          room = _client!.getRoomById(roomId);
          if (room != null) break;
        }
      }

      if (room == null) {
        debugPrint('MatrixMomentDataSource: Room still null after waiting, '
            'trying sync...');
        try {
          await _client!.onSync.stream.first.timeout(
            const Duration(seconds: 10),
          );
          room = _client!.getRoomById(roomId);
        } on TimeoutException {
          debugPrint('MatrixMomentDataSource: Sync timeout after room creation');
        }
      }

      // 添加标签
      if (room != null) {
        await room.addTag(momentRoomTag);
        _cachedMomentRoom = room;
        debugPrint('MatrixMomentDataSource: Moment room ready: ${room.id}');
      } else {
        debugPrint('MatrixMomentDataSource: Failed to get room after creation');
      }

      return room;
    } catch (e) {
      debugPrint('MatrixMomentDataSource: Error creating moment room: $e');
      return null;
    }
  }

  /// 获取好友的动态房间列表
  Future<List<matrix.Room>> _getFriendMomentRooms() async {
    if (_client == null) return [];

    final rooms = <matrix.Room>[];

    // 获取所有已加入的动态房间
    for (final room in _client!.rooms) {
      if (room.membership != matrix.Membership.join) continue;

      final tags = room.tags;
      if (tags.containsKey(momentRoomTag)) {
        rooms.add(room);
      }
    }

    return rooms;
  }

  /// 发布动态
  Future<String> postMoment({
    String? content,
    List<MomentMediaData>? media,
    MomentLocation? location,
    MomentVisibility visibility = MomentVisibility.public,
    List<String> visibilityUserIds = const [],
  }) async {
    final room = await _getOrCreateMomentRoom();
    if (room == null) {
      final isLoggedIn = _client?.isLogged() ?? false;
      final roomCount = _client?.rooms.length ?? 0;
      throw Exception(
        'Failed to get moment room '
        '(logged_in=$isLoggedIn, rooms=$roomCount)',
      );
    }

    final momentId = 'moment_${DateTime.now().millisecondsSinceEpoch}';

    // 上传媒体文件
    final uploadedMedia = <Map<String, dynamic>>[];
    if (media != null) {
      for (final m in media) {
        final uri = await _client!.uploadContent(
          m.bytes,
          filename: m.filename,
          contentType: m.mimeType,
        );
        uploadedMedia.add({
          'url': uri.toString(),
          'type': m.isVideo ? 'video' : 'image',
          'width': m.width,
          'height': m.height,
          'duration': m.duration,
          'mimeType': m.mimeType,
          'size': m.bytes.length,
        });
      }
    }

    // 发送动态事件
    final eventContent = {
      'moment_id': momentId,
      'content': content,
      'media': uploadedMedia,
      'location': location != null
          ? {
              'latitude': location.latitude,
              'longitude': location.longitude,
              'name': location.name,
              'address': location.address,
            }
          : null,
      'visibility': visibility.name,
      'visibility_user_ids': visibilityUserIds,
      'timestamp': DateTime.now().toIso8601String(),
    };

    await room.sendEvent(eventContent, type: momentEventType);

    return momentId;
  }

  /// 获取动态列表
  Future<List<MomentEntity>> getMoments({
    int limit = 20,
    String? beforeId,
  }) async {
    final rooms = await _getFriendMomentRooms();
    final moments = <MomentEntity>[];

    for (final room in rooms) {
      // 使用 getTimeline() 获取时间线
      try {
        final timeline = await room.getTimeline();

        for (final event in timeline.events) {
          if (event.type != momentEventType) continue;

          final moment = _parseEventToMoment(event, room);
          if (moment != null && !moment.isDeleted) {
            moments.add(moment);
          }
        }
      } catch (e) {
        // 如果获取时间线失败，继续处理下一个房间
        continue;
      }
    }

    // 按时间排序
    moments.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    // 分页
    int startIndex = 0;
    if (beforeId != null) {
      startIndex = moments.indexWhere((m) => m.id == beforeId) + 1;
    }

    _cachedMoments.clear();
    _cachedMoments.addAll(moments);

    return moments.skip(startIndex).take(limit).toList();
  }

  /// 获取用户的动态
  Future<List<MomentEntity>> getUserMoments(
    String userId, {
    int limit = 20,
    String? beforeId,
  }) async {
    final moments = await getMoments(limit: limit * 2, beforeId: beforeId);
    return moments.where((m) => m.userId == userId).take(limit).toList();
  }

  /// 获取单条动态
  Future<MomentEntity?> getMomentById(String momentId) async {
    // 先从缓存查找
    final cached = _cachedMoments.where((m) => m.id == momentId).firstOrNull;
    if (cached != null) return cached;

    // 从房间查找
    final rooms = await _getFriendMomentRooms();

    for (final room in rooms) {
      try {
        final timeline = await room.getTimeline();

        for (final event in timeline.events) {
          if (event.type != momentEventType) continue;

          final content = event.content;
          if (content['moment_id'] == momentId) {
            return _parseEventToMoment(event, room);
          }
        }
      } catch (e) {
        continue;
      }
    }

    return null;
  }

  /// 删除动态
  Future<void> deleteMoment(String momentId) async {
    final room = await _getOrCreateMomentRoom();
    if (room == null) return;

    try {
      final timeline = await room.getTimeline();

      for (final event in timeline.events) {
        if (event.type != momentEventType) continue;

        final content = event.content;
        if (content['moment_id'] == momentId) {
          await room.redactEvent(event.eventId);
          _cachedMoments.removeWhere((m) => m.id == momentId);
          break;
        }
      }
    } catch (e) {
      // 忽略错误
    }
  }

  /// 点赞动态
  Future<void> likeMoment(String momentId) async {
    final rooms = await _getFriendMomentRooms();

    for (final room in rooms) {
      try {
        final timeline = await room.getTimeline();

        for (final event in timeline.events) {
          if (event.type != momentEventType) continue;

          final content = event.content;
          if (content['moment_id'] == momentId) {
            // 发送点赞事件
            await room.sendEvent({
              'moment_id': momentId,
              'moment_event_id': event.eventId,
              'action': 'like',
              'timestamp': DateTime.now().toIso8601String(),
            }, type: momentLikeEventType);
            return;
          }
        }
      } catch (e) {
        continue;
      }
    }
  }

  /// 取消点赞
  Future<void> unlikeMoment(String momentId) async {
    final rooms = await _getFriendMomentRooms();

    for (final room in rooms) {
      try {
        final timeline = await room.getTimeline();

        for (final event in timeline.events) {
          if (event.type != momentLikeEventType) continue;

          final content = event.content;
          if (content['moment_id'] == momentId &&
              event.senderId == _currentUserId) {
            await room.redactEvent(event.eventId);
            return;
          }
        }
      } catch (e) {
        continue;
      }
    }
  }

  /// 评论动态
  Future<String> commentMoment({
    required String momentId,
    required String content,
    String? replyToCommentId,
    String? replyToUserId,
  }) async {
    final rooms = await _getFriendMomentRooms();

    for (final room in rooms) {
      try {
        final timeline = await room.getTimeline();

        for (final event in timeline.events) {
          if (event.type != momentEventType) continue;

          final eventContent = event.content;
          if (eventContent['moment_id'] == momentId) {
            final commentId = 'comment_${DateTime.now().millisecondsSinceEpoch}';

            await room.sendEvent({
              'moment_id': momentId,
              'moment_event_id': event.eventId,
              'comment_id': commentId,
              'content': content,
              'reply_to_comment_id': replyToCommentId,
              'reply_to_user_id': replyToUserId,
              'timestamp': DateTime.now().toIso8601String(),
            }, type: momentCommentEventType);

            return commentId;
          }
        }
      } catch (e) {
        continue;
      }
    }

    throw Exception('Moment not found');
  }

  /// 删除评论
  Future<void> deleteComment(String momentId, String commentId) async {
    final rooms = await _getFriendMomentRooms();

    for (final room in rooms) {
      try {
        final timeline = await room.getTimeline();

        for (final event in timeline.events) {
          if (event.type != momentCommentEventType) continue;

          final content = event.content;
          if (content['moment_id'] == momentId &&
              content['comment_id'] == commentId) {
            await room.redactEvent(event.eventId);
            return;
          }
        }
      } catch (e) {
        continue;
      }
    }
  }

  /// 获取动态的点赞列表
  Future<List<MomentLike>> getMomentLikes(String momentId) async {
    final likes = <MomentLike>[];
    final rooms = await _getFriendMomentRooms();

    for (final room in rooms) {
      try {
        final timeline = await room.getTimeline();

        for (final event in timeline.events) {
          if (event.type != momentLikeEventType) continue;

          final content = event.content;
          if (content['moment_id'] == momentId) {
            final user = room.unsafeGetUserFromMemoryOrFallback(event.senderId);
            likes.add(MomentLike(
              userId: event.senderId,
              userName: user.displayName ?? event.senderId,
              userAvatarUrl: user.avatarUrl?.toString(),
              timestamp: event.originServerTs,
            ));
          }
        }
      } catch (e) {
        continue;
      }
    }

    return likes;
  }

  /// 获取动态的评论列表
  Future<List<MomentComment>> getMomentComments(String momentId) async {
    final comments = <MomentComment>[];
    final rooms = await _getFriendMomentRooms();

    for (final room in rooms) {
      try {
        final timeline = await room.getTimeline();

        for (final event in timeline.events) {
          if (event.type != momentCommentEventType) continue;

          final content = event.content;
          if (content['moment_id'] == momentId) {
            final user = room.unsafeGetUserFromMemoryOrFallback(event.senderId);

            String? replyToUserName;
            if (content['reply_to_user_id'] != null) {
              final replyToUser = room.unsafeGetUserFromMemoryOrFallback(
                content['reply_to_user_id'] as String,
              );
              replyToUserName = replyToUser.displayName;
            }

            comments.add(MomentComment(
              id: content['comment_id'] as String,
              userId: event.senderId,
              userName: user.displayName ?? event.senderId,
              userAvatarUrl: user.avatarUrl?.toString(),
              content: content['content'] as String,
              timestamp: event.originServerTs,
              replyToCommentId: content['reply_to_comment_id'] as String?,
              replyToUserId: content['reply_to_user_id'] as String?,
              replyToUserName: replyToUserName,
            ));
          }
        }
      } catch (e) {
        continue;
      }
    }

    // 按时间排序
    comments.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return comments;
  }

  /// 监听动态更新
  Stream<List<MomentEntity>>? watchMoments() {
    if (_client == null) return null;

    return _client!.onSync.stream.asyncMap((_) async {
      return await getMoments();
    });
  }

  /// 解析事件为动态实体
  MomentEntity? _parseEventToMoment(matrix.Event event, matrix.Room room) {
    try {
      final content = event.content;
      final user = room.unsafeGetUserFromMemoryOrFallback(event.senderId);

      // 解析媒体
      final mediaList = <MomentMedia>[];
      final mediaContent = content['media'];
      if (mediaContent is List) {
        for (final m in mediaContent) {
          if (m is Map) {
            final mxcUrl = m['url'] as String?;
            mediaList.add(MomentMedia(
              url: mxcUrl ?? '',
              httpUrl: mxcUrl != null ? _getHttpUrlFromMxc(mxcUrl) : null,
              type: m['type'] == 'video'
                  ? MomentMediaType.video
                  : MomentMediaType.image,
              width: m['width'] as int?,
              height: m['height'] as int?,
              duration: m['duration'] as int?,
              mimeType: m['mimeType'] as String?,
              size: m['size'] as int?,
            ));
          }
        }
      }

      // 解析位置
      MomentLocation? location;
      final locationContent = content['location'];
      if (locationContent is Map) {
        location = MomentLocation(
          latitude: (locationContent['latitude'] as num).toDouble(),
          longitude: (locationContent['longitude'] as num).toDouble(),
          name: locationContent['name'] as String?,
          address: locationContent['address'] as String?,
        );
      }

      // 解析可见性
      MomentVisibility visibility = MomentVisibility.public;
      final visibilityStr = content['visibility'] as String?;
      if (visibilityStr != null) {
        visibility = MomentVisibility.values.firstWhere(
          (v) => v.name == visibilityStr,
          orElse: () => MomentVisibility.public,
        );
      }

      return MomentEntity(
        id: content['moment_id'] as String? ?? event.eventId,
        userId: event.senderId,
        userName: user.displayName ?? event.senderId,
        userAvatarUrl: user.avatarUrl?.toString(),
        content: content['content'] as String?,
        media: mediaList,
        location: location,
        timestamp: event.originServerTs,
        visibility: visibility,
        visibilityUserIds: (content['visibility_user_ids'] as List?)
                ?.cast<String>() ??
            [],
        isDeleted: event.redacted,
        isFromMe: event.senderId == _currentUserId,
      );
    } catch (e) {
      return null;
    }
  }

  /// 获取 HTTP URL
  String? _getHttpUrlFromMxc(String mxcUrl) {
    if (!mxcUrl.startsWith('mxc://')) return null;
    if (_client?.homeserver == null) return null;

    final uri = Uri.parse(mxcUrl);
    final serverName = uri.host;
    final mediaId = uri.path.startsWith('/') ? uri.path.substring(1) : uri.path;
    final homeserver = _client!.homeserver.toString().replaceAll(RegExp(r'/+$'), '');
    return '$homeserver/_matrix/client/v1/media/download/$serverName/$mediaId';
  }

  /// 上传文件
  Future<String> uploadMedia(
      Uint8List bytes, String filename, String? mimeType) async {
    if (_client == null) throw Exception('Client not initialized');

    final uri = await _client!.uploadContent(
      bytes,
      filename: filename,
      contentType: mimeType,
    );
    return uri.toString();
  }
}

/// 动态媒体数据
class MomentMediaData {
  final Uint8List bytes;
  final String filename;
  final String? mimeType;
  final int? width;
  final int? height;
  final int? duration;

  const MomentMediaData({
    required this.bytes,
    required this.filename,
    this.mimeType,
    this.width,
    this.height,
    this.duration,
  });

  bool get isVideo {
    final mime = mimeType?.toLowerCase() ?? '';
    return mime.startsWith('video/') ||
        filename.toLowerCase().endsWith('.mp4') ||
        filename.toLowerCase().endsWith('.mov');
  }
}
