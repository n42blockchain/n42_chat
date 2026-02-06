import 'dart:async';
import 'dart:typed_data';

import '../../domain/entities/moment_entity.dart';
import '../../domain/repositories/moment_repository.dart';
import '../datasources/local/secure_storage_datasource.dart';
import '../datasources/matrix/matrix_moment_datasource.dart';

/// 动态仓库实现
class MomentRepositoryImpl implements IMomentRepository {
  final MatrixMomentDataSource _momentDataSource;
  final SecureStorageDataSource _storageDataSource;

  /// 动态缓存
  final List<MomentEntity> _momentsCache = [];

  /// 未读数量
  int _unreadCount = 0;

  MomentRepositoryImpl(this._momentDataSource, this._storageDataSource);

  @override
  Future<List<MomentEntity>> getMoments({
    int limit = 20,
    String? beforeId,
  }) async {
    final moments = await _momentDataSource.getMoments(
      limit: limit,
      beforeId: beforeId,
    );

    // 填充点赞和评论
    final enrichedMoments = <MomentEntity>[];
    for (final moment in moments) {
      final likes = await _momentDataSource.getMomentLikes(moment.id);
      final comments = await _momentDataSource.getMomentComments(moment.id);

      enrichedMoments.add(moment.copyWith(
        likes: likes,
        comments: comments,
        isLikedByMe: likes.any((l) => l.userId == _getCurrentUserId()),
      ));
    }

    // 更新缓存
    if (beforeId == null) {
      _momentsCache.clear();
    }
    _momentsCache.addAll(enrichedMoments);

    return enrichedMoments;
  }

  @override
  Stream<List<MomentEntity>> watchMoments() {
    final stream = _momentDataSource.watchMoments();
    if (stream == null) {
      return Stream.value([]);
    }

    return stream.asyncMap((moments) async {
      final enrichedMoments = <MomentEntity>[];
      for (final moment in moments) {
        final likes = await _momentDataSource.getMomentLikes(moment.id);
        final comments = await _momentDataSource.getMomentComments(moment.id);

        enrichedMoments.add(moment.copyWith(
          likes: likes,
          comments: comments,
          isLikedByMe: likes.any((l) => l.userId == _getCurrentUserId()),
        ));
      }
      return enrichedMoments;
    });
  }

  @override
  Future<List<MomentEntity>> getUserMoments(
    String userId, {
    int limit = 20,
    String? beforeId,
  }) async {
    final moments = await _momentDataSource.getUserMoments(
      userId,
      limit: limit,
      beforeId: beforeId,
    );

    final enrichedMoments = <MomentEntity>[];
    for (final moment in moments) {
      final likes = await _momentDataSource.getMomentLikes(moment.id);
      final comments = await _momentDataSource.getMomentComments(moment.id);

      enrichedMoments.add(moment.copyWith(
        likes: likes,
        comments: comments,
        isLikedByMe: likes.any((l) => l.userId == _getCurrentUserId()),
      ));
    }

    return enrichedMoments;
  }

  @override
  Future<MomentEntity?> getMomentById(String momentId) async {
    final moment = await _momentDataSource.getMomentById(momentId);
    if (moment == null) return null;

    final likes = await _momentDataSource.getMomentLikes(momentId);
    final comments = await _momentDataSource.getMomentComments(momentId);

    return moment.copyWith(
      likes: likes,
      comments: comments,
      isLikedByMe: likes.any((l) => l.userId == _getCurrentUserId()),
    );
  }

  @override
  Future<MomentEntity> postTextMoment({
    required String content,
    MomentLocation? location,
    MomentVisibility visibility = MomentVisibility.public,
    List<String> visibilityUserIds = const [],
  }) async {
    final momentId = await _momentDataSource.postMoment(
      content: content,
      location: location,
      visibility: visibility,
      visibilityUserIds: visibilityUserIds,
    );

    final moment = await getMomentById(momentId);
    if (moment == null) {
      throw Exception('Failed to retrieve posted moment');
    }

    return moment;
  }

  @override
  Future<MomentEntity> postImageMoment({
    String? content,
    required List<MomentMediaInput> images,
    MomentLocation? location,
    MomentVisibility visibility = MomentVisibility.public,
    List<String> visibilityUserIds = const [],
  }) async {
    final mediaData = images
        .map((img) => MomentMediaData(
              bytes: img.bytes,
              filename: img.filename,
              mimeType: img.mimeType,
              width: img.width,
              height: img.height,
            ))
        .toList();

    final momentId = await _momentDataSource.postMoment(
      content: content,
      media: mediaData,
      location: location,
      visibility: visibility,
      visibilityUserIds: visibilityUserIds,
    );

    final moment = await getMomentById(momentId);
    if (moment == null) {
      throw Exception('Failed to retrieve posted moment');
    }

    return moment;
  }

  @override
  Future<MomentEntity> postVideoMoment({
    String? content,
    required MomentMediaInput video,
    Uint8List? thumbnailBytes,
    MomentLocation? location,
    MomentVisibility visibility = MomentVisibility.public,
    List<String> visibilityUserIds = const [],
  }) async {
    final mediaData = [
      MomentMediaData(
        bytes: video.bytes,
        filename: video.filename,
        mimeType: video.mimeType,
        width: video.width,
        height: video.height,
        duration: video.duration,
      ),
    ];

    final momentId = await _momentDataSource.postMoment(
      content: content,
      media: mediaData,
      location: location,
      visibility: visibility,
      visibilityUserIds: visibilityUserIds,
    );

    final moment = await getMomentById(momentId);
    if (moment == null) {
      throw Exception('Failed to retrieve posted moment');
    }

    return moment;
  }

  @override
  Future<void> deleteMoment(String momentId) async {
    await _momentDataSource.deleteMoment(momentId);
    _momentsCache.removeWhere((m) => m.id == momentId);
  }

  @override
  Future<void> likeMoment(String momentId) async {
    await _momentDataSource.likeMoment(momentId);

    // 更新缓存
    final index = _momentsCache.indexWhere((m) => m.id == momentId);
    if (index >= 0) {
      final moment = _momentsCache[index];
      _momentsCache[index] = moment.copyWith(isLikedByMe: true);
    }
  }

  @override
  Future<void> unlikeMoment(String momentId) async {
    await _momentDataSource.unlikeMoment(momentId);

    // 更新缓存
    final index = _momentsCache.indexWhere((m) => m.id == momentId);
    if (index >= 0) {
      final moment = _momentsCache[index];
      _momentsCache[index] = moment.copyWith(isLikedByMe: false);
    }
  }

  @override
  Future<MomentComment> commentMoment({
    required String momentId,
    required String content,
    String? replyToCommentId,
    String? replyToUserId,
  }) async {
    final commentId = await _momentDataSource.commentMoment(
      momentId: momentId,
      content: content,
      replyToCommentId: replyToCommentId,
      replyToUserId: replyToUserId,
    );

    // 获取最新评论
    final comments = await _momentDataSource.getMomentComments(momentId);
    final comment = comments.firstWhere((c) => c.id == commentId);

    return comment;
  }

  @override
  Future<void> deleteComment(String momentId, String commentId) async {
    await _momentDataSource.deleteComment(momentId, commentId);
  }

  @override
  Future<List<MomentLike>> getMomentLikes(String momentId) async {
    return await _momentDataSource.getMomentLikes(momentId);
  }

  @override
  Future<List<MomentComment>> getMomentComments(String momentId) async {
    return await _momentDataSource.getMomentComments(momentId);
  }

  @override
  Future<void> setMomentVisibilitySettings({
    bool allowStrangers = false,
    int visibleDays = 0,
  }) async {
    await _storageDataSource.saveMomentSettings(
      allowStrangers: allowStrangers,
      visibleDays: visibleDays,
    );
  }

  @override
  Future<Map<String, dynamic>> getMomentVisibilitySettings() async {
    return await _storageDataSource.getMomentSettings() ??
        {'allowStrangers': false, 'visibleDays': 0};
  }

  @override
  Future<void> hideMomentsFromUser(String userId) async {
    final hiddenUsers = await getHiddenMomentUsers();
    if (!hiddenUsers.contains(userId)) {
      hiddenUsers.add(userId);
      await _storageDataSource.saveHiddenMomentUsers(hiddenUsers);
    }
  }

  @override
  Future<void> showMomentsFromUser(String userId) async {
    final hiddenUsers = await getHiddenMomentUsers();
    hiddenUsers.remove(userId);
    await _storageDataSource.saveHiddenMomentUsers(hiddenUsers);
  }

  @override
  Future<List<String>> getHiddenMomentUsers() async {
    return await _storageDataSource.getHiddenMomentUsers() ?? [];
  }

  @override
  Future<void> hideMyMomentsFromUser(String userId) async {
    final blockedUsers = await getBlockedMomentUsers();
    if (!blockedUsers.contains(userId)) {
      blockedUsers.add(userId);
      await _storageDataSource.saveBlockedMomentUsers(blockedUsers);
    }
  }

  @override
  Future<void> showMyMomentsToUser(String userId) async {
    final blockedUsers = await getBlockedMomentUsers();
    blockedUsers.remove(userId);
    await _storageDataSource.saveBlockedMomentUsers(blockedUsers);
  }

  @override
  Future<List<String>> getBlockedMomentUsers() async {
    return await _storageDataSource.getBlockedMomentUsers() ?? [];
  }

  @override
  Future<int> getUnreadMomentCount() async {
    return _unreadCount;
  }

  @override
  Future<void> markMomentsAsRead() async {
    _unreadCount = 0;
    await _storageDataSource.saveMomentLastReadTime(DateTime.now());
  }

  @override
  Future<void> refreshMoments() async {
    _momentsCache.clear();
    await getMoments();
  }

  String? _getCurrentUserId() {
    // 从 datasource 获取当前用户ID
    return null; // 需要从 client 获取
  }
}
