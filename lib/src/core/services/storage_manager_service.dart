import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// 存储使用信息
class StorageInfo {
  final int totalSize;
  final int mediaSize;
  final int fileSize;
  final int cacheSize;
  final int otherSize;

  const StorageInfo({
    this.totalSize = 0,
    this.mediaSize = 0,
    this.fileSize = 0,
    this.cacheSize = 0,
    this.otherSize = 0,
  });

  String get formattedTotal => _formatSize(totalSize);
  String get formattedMedia => _formatSize(mediaSize);
  String get formattedFile => _formatSize(fileSize);
  String get formattedCache => _formatSize(cacheSize);
  String get formattedOther => _formatSize(otherSize);

  static String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

/// 房间存储使用信息
class RoomStorageInfo {
  final String roomId;
  final String roomName;
  final int totalSize;
  final int mediaCount;
  final int fileCount;

  const RoomStorageInfo({
    required this.roomId,
    required this.roomName,
    this.totalSize = 0,
    this.mediaCount = 0,
    this.fileCount = 0,
  });

  String get formattedSize => StorageInfo._formatSize(totalSize);
}

/// 存储管理服务
class StorageManagerService {
  /// 获取存储使用情况
  Future<StorageInfo> getStorageUsage() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = await getTemporaryDirectory();

      int mediaSize = 0;
      int fileSize = 0;
      int otherSize = 0;
      final cacheSize = await _directorySize(cacheDir);

      // 扫描应用目录
      await for (final entity in appDir.list(recursive: true)) {
        if (entity is File) {
          final size = await entity.length();
          final ext = entity.path.split('.').last.toLowerCase();

          if (['jpg', 'jpeg', 'png', 'gif', 'webp', 'mp4', 'mov', 'avi', 'mp3', 'ogg', 'wav']
              .contains(ext)) {
            mediaSize += size;
          } else if (['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'txt', 'zip', 'rar']
              .contains(ext)) {
            fileSize += size;
          } else {
            otherSize += size;
          }
        }
      }

      return StorageInfo(
        totalSize: mediaSize + fileSize + cacheSize + otherSize,
        mediaSize: mediaSize,
        fileSize: fileSize,
        cacheSize: cacheSize,
        otherSize: otherSize,
      );
    } catch (e) {
      debugPrint('StorageManagerService: Failed to get storage usage: $e');
      return const StorageInfo();
    }
  }

  /// 获取房间存储排行
  Future<List<RoomStorageInfo>> getRoomStorageRanking() async {
    // 实际实现需要遍历 Matrix 本地缓存
    // 这里返回空列表，等待与 Matrix SDK 集成
    return [];
  }

  /// 清理缓存
  Future<void> clearCache() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      if (cacheDir.existsSync()) {
        await for (final entity in cacheDir.list()) {
          try {
            if (entity is File) {
              await entity.delete();
            } else if (entity is Directory) {
              await entity.delete(recursive: true);
            }
          } catch (e) {
            debugPrint('StorageManagerService: Failed to delete ${entity.path}: $e');
          }
        }
      }
    } catch (e) {
      debugPrint('StorageManagerService: Failed to clear cache: $e');
    }
  }

  /// 清理指定房间的媒体
  Future<void> clearRoomMedia(String roomId) async {
    // 需要与 Matrix SDK 集成，清理指定房间的缓存文件
    debugPrint('StorageManagerService: clearRoomMedia not yet implemented for $roomId');
  }

  Future<int> _directorySize(Directory dir) async {
    int size = 0;
    try {
      await for (final entity in dir.list(recursive: true)) {
        if (entity is File) {
          size += await entity.length();
        }
      }
    } catch (e) {
      debugPrint('StorageManagerService: Failed to calculate directory size: $e');
    }
    return size;
  }
}
