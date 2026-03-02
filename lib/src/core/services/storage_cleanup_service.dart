
import '../constants/app_constants.dart';
import 'media_lifecycle_service.dart';
import 'storage_manager_service.dart';
import '../utils/debug_log.dart';

/// 清理建议类型
enum CleanupRecommendationType {
  /// 90天以上未访问的旧媒体
  oldMedia,

  /// 10MB以上的大文件
  largeFiles,

  /// 应用缓存
  cache,

  /// 按房间清理
  roomSpecific,
}

/// 清理建议
class CleanupRecommendation {
  final CleanupRecommendationType type;
  final String title;
  final String description;
  final int estimatedBytes;
  final int fileCount;

  /// 关联的房间 ID（仅 roomSpecific 类型）
  final String? roomId;

  /// 关联的文件路径列表
  final List<String> filePaths;

  /// 关联的文件分类
  final List<String>? fileCategories;

  const CleanupRecommendation({
    required this.type,
    required this.title,
    required this.description,
    required this.estimatedBytes,
    required this.fileCount,
    this.roomId,
    this.filePaths = const [],
    this.fileCategories,
  });

  String get formattedSize => StorageInfo.formatSize(estimatedBytes);
}

/// 智能清理建议引擎
class StorageCleanupService {
  final MediaLifecycleService _lifecycleService;
  final StorageManagerService _storageManager;

  StorageCleanupService({
    required MediaLifecycleService lifecycleService,
    required StorageManagerService storageManager,
  })  : _lifecycleService = lifecycleService,
        _storageManager = storageManager;

  /// 生成清理建议列表（按可释放空间排序）
  Future<List<CleanupRecommendation>> getRecommendations() async {
    final recommendations = <CleanupRecommendation>[];

    try {
      // 1. 旧媒体建议（90天以上未访问）
      final oldFiles = await _lifecycleService.getCleanableFiles(
        olderThanDays: StorageConstants.defaultCleanupDays,
      );
      if (oldFiles.isNotEmpty) {
        int totalSize = 0;
        for (final f in oldFiles) {
          totalSize += f.fileSize;
        }
        recommendations.add(CleanupRecommendation(
          type: CleanupRecommendationType.oldMedia,
          title: 'Old Media Files',
          description:
              '${oldFiles.length} files not accessed in ${StorageConstants.defaultCleanupDays}+ days',
          estimatedBytes: totalSize,
          fileCount: oldFiles.length,
          filePaths: oldFiles.map((f) => f.filePath).toList(),
        ));
      }

      // 2. 大文件建议（10MB+）
      final largeFiles = await _lifecycleService.getCleanableFiles(
        minFileSizeBytes: StorageConstants.largeFileThreshold,
      );
      if (largeFiles.isNotEmpty) {
        int totalSize = 0;
        for (final f in largeFiles) {
          totalSize += f.fileSize;
        }
        recommendations.add(CleanupRecommendation(
          type: CleanupRecommendationType.largeFiles,
          title: 'Large Files',
          description:
              '${largeFiles.length} files larger than 10MB',
          estimatedBytes: totalSize,
          fileCount: largeFiles.length,
          filePaths: largeFiles.map((f) => f.filePath).toList(),
        ));
      }

      // 3. 缓存建议
      final storageInfo = await _storageManager.getStorageUsage();
      if (storageInfo.cacheSize > 0) {
        recommendations.add(CleanupRecommendation(
          type: CleanupRecommendationType.cache,
          title: 'App Cache',
          description: 'Temporary files and cached data',
          estimatedBytes: storageInfo.cacheSize,
          fileCount: 0,
        ));
      }

      // 4. 房间维度建议（占用前5的房间）
      final roomStats = await _lifecycleService.getAllRoomStats();
      for (final stat in roomStats.take(5)) {
        if (stat.totalSize > 1024 * 1024) {
          // 至少 1MB
          recommendations.add(CleanupRecommendation(
            type: CleanupRecommendationType.roomSpecific,
            title: stat.roomId,
            description: '${stat.totalCount} files',
            estimatedBytes: stat.totalSize,
            fileCount: stat.totalCount,
            roomId: stat.roomId,
          ));
        }
      }

      // 按可释放空间降序排列
      recommendations.sort(
          (a, b) => b.estimatedBytes.compareTo(a.estimatedBytes));
    } catch (e) {
      debugLog('StorageCleanupService: Failed to get recommendations: $e');
    }

    return recommendations;
  }

  /// 执行单条建议
  Future<CleanupResult> executeRecommendation(
      CleanupRecommendation recommendation) async {
    switch (recommendation.type) {
      case CleanupRecommendationType.oldMedia:
      case CleanupRecommendationType.largeFiles:
        return _lifecycleService.cleanupFiles(recommendation.filePaths);
      case CleanupRecommendationType.cache:
        await _storageManager.clearCache();
        return CleanupResult(
          filesDeleted: 0,
          bytesFreed: recommendation.estimatedBytes,
        );
      case CleanupRecommendationType.roomSpecific:
        if (recommendation.roomId != null) {
          return cleanupByRoom(roomId: recommendation.roomId!);
        }
        return const CleanupResult();
    }
  }

  /// 按房间清理（指定类型+日期范围）
  Future<CleanupResult> cleanupByRoom({
    required String roomId,
    List<String>? fileCategories,
    DateTime? olderThan,
  }) async {
    var result = const CleanupResult();

    if (fileCategories != null && fileCategories.isNotEmpty) {
      for (final category in fileCategories) {
        final files = await _lifecycleService.getCleanableFiles(
          roomId: roomId,
          fileCategory: category,
          olderThanDays: olderThan != null
              ? DateTime.now().difference(olderThan).inDays
              : null,
        );
        if (files.isNotEmpty) {
          result = result +
              await _lifecycleService
                  .cleanupFiles(files.map((f) => f.filePath).toList());
        }
      }
    } else {
      final files = await _lifecycleService.getCleanableFiles(
        roomId: roomId,
        olderThanDays: olderThan != null
            ? DateTime.now().difference(olderThan).inDays
            : null,
      );
      if (files.isNotEmpty) {
        result = await _lifecycleService
            .cleanupFiles(files.map((f) => f.filePath).toList());
      }
    }

    return result;
  }

  /// 按日期批量清理
  Future<CleanupResult> cleanupByDateRange({
    DateTime? startDate,
    DateTime? endDate,
    List<String>? fileCategories,
  }) async {
    final olderThanDays =
        endDate != null ? DateTime.now().difference(endDate).inDays : null;

    if (fileCategories != null && fileCategories.isNotEmpty) {
      var result = const CleanupResult();
      for (final category in fileCategories) {
        final files = await _lifecycleService.getCleanableFiles(
          olderThanDays: olderThanDays,
          fileCategory: category,
        );
        if (files.isNotEmpty) {
          result = result +
              await _lifecycleService
                  .cleanupFiles(files.map((f) => f.filePath).toList());
        }
      }
      return result;
    }

    final files = await _lifecycleService.getCleanableFiles(
      olderThanDays: olderThanDays,
    );
    if (files.isEmpty) return const CleanupResult();
    return _lifecycleService
        .cleanupFiles(files.map((f) => f.filePath).toList());
  }
}
