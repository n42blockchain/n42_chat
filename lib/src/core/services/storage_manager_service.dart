import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/datasources/matrix/matrix_client_manager.dart';

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

  String get formattedTotal => formatSize(totalSize);
  String get formattedMedia => formatSize(mediaSize);
  String get formattedFile => formatSize(fileSize);
  String get formattedCache => formatSize(cacheSize);
  String get formattedOther => formatSize(otherSize);

  static String formatSize(int bytes) {
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

  String get formattedSize => StorageInfo.formatSize(totalSize);
}

/// 存储管理服务
class StorageManagerService {
  final MatrixClientManager? _clientManager;

  StorageManagerService({MatrixClientManager? clientManager})
      : _clientManager = clientManager;

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
    try {
      final client = _clientManager?.client;
      if (client == null) return [];

      final rooms = client.rooms;
      final appDir = await getApplicationDocumentsDirectory();
      final results = <RoomStorageInfo>[];

      for (final room in rooms) {
        // 检查房间对应的本地缓存目录
        final roomCacheDir = Directory('${appDir.path}/matrix_cache/${room.id}');
        int totalSize = 0;
        int mediaCount = 0;
        int fileCount = 0;

        if (roomCacheDir.existsSync()) {
          await for (final entity in roomCacheDir.list(recursive: true)) {
            if (entity is File) {
              totalSize += await entity.length();
              final ext = entity.path.split('.').last.toLowerCase();
              if (['jpg', 'jpeg', 'png', 'gif', 'webp', 'mp4', 'mov', 'mp3', 'ogg'].contains(ext)) {
                mediaCount++;
              } else {
                fileCount++;
              }
            }
          }
        }

        if (totalSize > 0) {
          results.add(RoomStorageInfo(
            roomId: room.id,
            roomName: room.getLocalizedDisplayname(),
            totalSize: totalSize,
            mediaCount: mediaCount,
            fileCount: fileCount,
          ));
        }
      }

      // 按大小降序排列
      results.sort((a, b) => b.totalSize.compareTo(a.totalSize));
      return results.take(20).toList();
    } catch (e) {
      debugPrint('StorageManagerService: Failed to get room ranking: $e');
      return [];
    }
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

  /// 清理指定房间的媒体缓存
  Future<void> clearRoomMedia(String roomId) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final roomCacheDir = Directory('${appDir.path}/matrix_cache/$roomId');
      if (roomCacheDir.existsSync()) {
        await roomCacheDir.delete(recursive: true);
        debugPrint('StorageManagerService: Cleared media cache for $roomId');
      }
    } catch (e) {
      debugPrint('StorageManagerService: Failed to clear room media for $roomId: $e');
    }
  }

  /// 获取所有房间存储信息（不限 20 条）
  Future<List<RoomStorageInfo>> getAllRoomStorage() async {
    try {
      final client = _clientManager?.client;
      if (client == null) return [];

      final rooms = client.rooms;
      final appDir = await getApplicationDocumentsDirectory();
      final results = <RoomStorageInfo>[];

      for (final room in rooms) {
        final roomCacheDir =
            Directory('${appDir.path}/matrix_cache/${room.id}');
        int totalSize = 0;
        int mediaCount = 0;
        int fileCount = 0;

        if (roomCacheDir.existsSync()) {
          await for (final entity in roomCacheDir.list(recursive: true)) {
            if (entity is File) {
              totalSize += await entity.length();
              final ext = entity.path.split('.').last.toLowerCase();
              if ([
                'jpg', 'jpeg', 'png', 'gif', 'webp',
                'mp4', 'mov', 'mp3', 'ogg',
              ].contains(ext)) {
                mediaCount++;
              } else {
                fileCount++;
              }
            }
          }
        }

        if (totalSize > 0) {
          results.add(RoomStorageInfo(
            roomId: room.id,
            roomName: room.getLocalizedDisplayname(),
            totalSize: totalSize,
            mediaCount: mediaCount,
            fileCount: fileCount,
          ));
        }
      }

      results.sort((a, b) => b.totalSize.compareTo(a.totalSize));
      return results;
    } catch (e) {
      debugPrint('StorageManagerService: Failed to get all room storage: $e');
      return [];
    }
  }

  /// 清理房间媒体（按文件类型）
  Future<void> clearRoomMediaByCategory(
    String roomId,
    List<String> categories,
  ) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final roomCacheDir =
          Directory('${appDir.path}/matrix_cache/$roomId');
      if (!roomCacheDir.existsSync()) return;

      final categoryExts = <String>{};
      for (final cat in categories) {
        switch (cat) {
          case 'image':
            categoryExts.addAll(
                ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'svg']);
            break;
          case 'video':
            categoryExts.addAll(['mp4', 'mov', 'avi', 'mkv', 'webm']);
            break;
          case 'audio':
            categoryExts.addAll(['mp3', 'ogg', 'wav', 'm4a', 'aac']);
            break;
          case 'document':
            categoryExts.addAll([
              'pdf', 'doc', 'docx', 'xls', 'xlsx',
              'ppt', 'pptx', 'txt', 'zip', 'rar',
            ]);
            break;
        }
      }

      await for (final entity in roomCacheDir.list(recursive: true)) {
        if (entity is File) {
          final ext = entity.path.split('.').last.toLowerCase();
          if (categoryExts.contains(ext)) {
            try {
              await entity.delete();
            } catch (_) {}
          }
        }
      }
    } catch (e) {
      debugPrint(
          'StorageManagerService: Failed to clear room media by category: $e');
    }
  }

  /// 清理指定日期之前的媒体文件
  Future<void> clearMediaOlderThan(
    DateTime date, {
    String? roomId,
  }) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final baseDir = roomId != null
          ? Directory('${appDir.path}/matrix_cache/$roomId')
          : Directory('${appDir.path}/matrix_cache');

      if (!baseDir.existsSync()) return;

      await for (final entity in baseDir.list(recursive: true)) {
        if (entity is File) {
          final stat = await entity.stat();
          if (stat.modified.isBefore(date)) {
            try {
              await entity.delete();
            } catch (_) {}
          }
        }
      }
    } catch (e) {
      debugPrint(
          'StorageManagerService: Failed to clear old media: $e');
    }
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
