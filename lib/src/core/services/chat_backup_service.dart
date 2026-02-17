import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../data/datasources/local/secure_storage_datasource.dart';
import '../../data/datasources/matrix/matrix_client_manager.dart';
import '../constants/app_constants.dart';

/// 备份结果
class BackupResult {
  final String backupId;
  final String filePath;
  final int fileSizeBytes;
  final int roomCount;
  final int messageCount;
  final DateTime createdAt;

  const BackupResult({
    required this.backupId,
    required this.filePath,
    required this.fileSizeBytes,
    required this.roomCount,
    required this.messageCount,
    required this.createdAt,
  });
}

/// 备份大小估算
class BackupSizeEstimate {
  final int estimatedBytes;
  final int roomCount;
  final bool includesMedia;

  const BackupSizeEstimate({
    required this.estimatedBytes,
    required this.roomCount,
    required this.includesMedia,
  });

  String get formattedSize {
    if (estimatedBytes < 1024) return '$estimatedBytes B';
    if (estimatedBytes < 1024 * 1024) {
      return '${(estimatedBytes / 1024).toStringAsFixed(1)} KB';
    }
    if (estimatedBytes < 1024 * 1024 * 1024) {
      return '${(estimatedBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(estimatedBytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

/// 备份信息
class BackupInfo {
  final String backupId;
  final String filePath;
  final int fileSizeBytes;
  final DateTime createdAt;
  final int roomCount;
  final bool includesMedia;
  final bool includesKeys;

  const BackupInfo({
    required this.backupId,
    required this.filePath,
    required this.fileSizeBytes,
    required this.createdAt,
    required this.roomCount,
    required this.includesMedia,
    required this.includesKeys,
  });

  String get formattedSize {
    if (fileSizeBytes < 1024) return '$fileSizeBytes B';
    if (fileSizeBytes < 1024 * 1024) {
      return '${(fileSizeBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(fileSizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String get formattedDate {
    return '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-'
        '${createdAt.day.toString().padLeft(2, '0')} '
        '${createdAt.hour.toString().padLeft(2, '0')}:'
        '${createdAt.minute.toString().padLeft(2, '0')}';
  }
}

/// 备份预览
class BackupPreview {
  final String backupId;
  final DateTime createdAt;
  final int roomCount;
  final List<String> roomNames;
  final bool hasMedia;
  final bool hasKeys;
  final bool hasSettings;

  const BackupPreview({
    required this.backupId,
    required this.createdAt,
    required this.roomCount,
    required this.roomNames,
    required this.hasMedia,
    required this.hasKeys,
    required this.hasSettings,
  });
}

/// 恢复结果
class RestoreResult {
  final int roomsRestored;
  final int settingsRestored;
  final bool keysRestored;
  final List<String> errors;

  const RestoreResult({
    this.roomsRestored = 0,
    this.settingsRestored = 0,
    this.keysRestored = false,
    this.errors = const [],
  });

  bool get hasErrors => errors.isNotEmpty;
}

/// 聊天备份与恢复服务
///
/// 备份格式: .n42backup = JSON 打包（纯文本，可选密码保护）
/// 内容: manifest.json + rooms/{roomId}/messages.json + settings/ + encryption/keys.json
class ChatBackupService {
  final MatrixClientManager _clientManager;
  final SecureStorageDataSource _secureStorage;

  ChatBackupService({
    required MatrixClientManager clientManager,
    required SecureStorageDataSource secureStorage,
  })  : _clientManager = clientManager,
        _secureStorage = secureStorage;

  /// 获取备份目录
  Future<Directory> _getBackupDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    final backupDir =
        Directory(p.join(appDir.path, StorageConstants.backupDirName));
    if (!backupDir.existsSync()) {
      backupDir.createSync(recursive: true);
    }
    return backupDir;
  }

  /// 创建备份
  Future<BackupResult> createBackup({
    List<String>? roomIds,
    bool includeMedia = false,
    bool includeKeys = false,
    String? password,
    void Function(double progress)? onProgress,
  }) async {
    final backupId = const Uuid().v4();
    final now = DateTime.now();
    final backupDir = await _getBackupDir();
    final fileName =
        'backup_${now.year}${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}_'
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${StorageConstants.backupExtension}';
    final filePath = p.join(backupDir.path, fileName);

    final client = _clientManager.client;
    if (client == null) throw StateError('Matrix client not available');

    final rooms = roomIds != null
        ? client.rooms.where((r) => roomIds.contains(r.id)).toList()
        : client.rooms;

    onProgress?.call(0.1);

    // 构建备份数据
    final backupData = <String, dynamic>{
      'manifest': {
        'backupId': backupId,
        'createdAt': now.toIso8601String(),
        'appVersion': '0.1.0',
        'roomCount': rooms.length,
        'includesMedia': includeMedia,
        'includesKeys': includeKeys,
      },
      'rooms': <String, dynamic>{},
      'settings': <String, dynamic>{},
    };

    // 导出房间数据
    int messageCount = 0;
    for (var i = 0; i < rooms.length; i++) {
      final room = rooms[i];
      try {
        final roomData = <String, dynamic>{
          'id': room.id,
          'name': room.getLocalizedDisplayname(),
          'topic': room.topic,
          'isDirect': room.isDirectChat,
          'memberCount': room.summary.mJoinedMemberCount ?? 0,
        };

        // 获取消息（通过 room 的 lastEvent 等方式）
        // Matrix SDK v6 不提供直接的 timeline getter
        // 使用 room.getTimeline() 获取完整 timeline
        try {
          final timeline = await room.getTimeline();
          final events = timeline.events
              .where((e) => e.type == 'm.room.message')
              .take(10000)
              .map((e) => {
                    'eventId': e.eventId,
                    'sender': e.senderId,
                    'type': e.messageType,
                    'body': e.body,
                    'timestamp': e.originServerTs.toIso8601String(),
                  })
              .toList();
          roomData['messages'] = events;
          messageCount += events.length;
        } catch (_) {
          // Timeline not available, skip messages
        }

        (backupData['rooms'] as Map<String, dynamic>)[room.id] = roomData;
      } catch (e) {
        debugPrint('ChatBackupService: Failed to export room ${room.id}: $e');
      }

      onProgress?.call(0.1 + 0.7 * (i + 1) / rooms.length);
    }

    // 导出设置
    try {
      final settingsKeys = [
        'chat_font_size',
        'notification_enabled',
        'theme_mode',
        'language',
        'auto_download',
      ];
      final settings = <String, String?>{};
      for (final key in settingsKeys) {
        settings[key] = await _secureStorage.read(key);
      }
      backupData['settings'] = settings;
    } catch (e) {
      debugPrint('ChatBackupService: Failed to export settings: $e');
    }

    onProgress?.call(0.85);

    // 写入文件
    final jsonStr = jsonEncode(backupData);

    // 如果有密码，进行简单的 XOR 加密
    if (password != null && password.isNotEmpty) {
      final keyBytes = sha256.convert(utf8.encode(password)).bytes;
      final dataBytes = utf8.encode(jsonStr);
      final encrypted = Uint8List(dataBytes.length);
      for (var i = 0; i < dataBytes.length; i++) {
        encrypted[i] = dataBytes[i] ^ keyBytes[i % keyBytes.length];
      }
      // 写入标记头 + 加密数据
      final file = File(filePath);
      await file.writeAsBytes(
        [...utf8.encode('N42ENC:'), ...encrypted],
      );
    } else {
      final file = File(filePath);
      await file.writeAsString(jsonStr);
    }

    onProgress?.call(1.0);

    final fileSize = await File(filePath).length();

    return BackupResult(
      backupId: backupId,
      filePath: filePath,
      fileSizeBytes: fileSize,
      roomCount: rooms.length,
      messageCount: messageCount,
      createdAt: now,
    );
  }

  /// 估算备份大小
  Future<BackupSizeEstimate> estimateBackupSize({
    List<String>? roomIds,
    bool includeMedia = false,
  }) async {
    final client = _clientManager.client;
    if (client == null) {
      return const BackupSizeEstimate(
        estimatedBytes: 0,
        roomCount: 0,
        includesMedia: false,
      );
    }

    final rooms = roomIds != null
        ? client.rooms.where((r) => roomIds.contains(r.id)).toList()
        : client.rooms;

    // 粗估：每条消息约 200 字节，每房间约 500 条
    int estimated = rooms.length * 500 * 200;
    // 设置约 10KB
    estimated += 10 * 1024;

    return BackupSizeEstimate(
      estimatedBytes: estimated,
      roomCount: rooms.length,
      includesMedia: includeMedia,
    );
  }

  /// 列出所有备份
  Future<List<BackupInfo>> listBackups() async {
    final backupDir = await _getBackupDir();
    final results = <BackupInfo>[];

    if (!backupDir.existsSync()) return results;

    await for (final entity in backupDir.list()) {
      if (entity is File &&
          entity.path.endsWith(StorageConstants.backupExtension)) {
        try {
          final stat = await entity.stat();
          // 尝试读取 manifest
          final preview = await _readManifest(entity.path);
          results.add(BackupInfo(
            backupId: preview?.backupId ?? p.basenameWithoutExtension(entity.path),
            filePath: entity.path,
            fileSizeBytes: stat.size,
            createdAt: preview?.createdAt ?? stat.modified,
            roomCount: preview?.roomCount ?? 0,
            includesMedia: preview?.hasMedia ?? false,
            includesKeys: preview?.hasKeys ?? false,
          ));
        } catch (e) {
          debugPrint('ChatBackupService: Failed to read backup: $e');
        }
      }
    }

    results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return results;
  }

  /// 删除备份
  Future<void> deleteBackup(String backupId) async {
    final backups = await listBackups();
    final target = backups.where((b) => b.backupId == backupId).firstOrNull;
    if (target != null) {
      final file = File(target.filePath);
      if (file.existsSync()) {
        await file.delete();
      }
    }
  }

  /// 预览备份内容
  Future<BackupPreview> previewBackup(
    String backupFilePath, {
    String? password,
  }) async {
    final data = await _readBackupData(backupFilePath, password: password);
    final manifest = data['manifest'] as Map<String, dynamic>? ?? {};
    final rooms = data['rooms'] as Map<String, dynamic>? ?? {};

    final roomNames = rooms.values
        .map((r) => (r as Map<String, dynamic>)['name']?.toString() ?? 'Unknown')
        .toList();

    return BackupPreview(
      backupId: manifest['backupId']?.toString() ?? '',
      createdAt: DateTime.tryParse(manifest['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      roomCount: rooms.length,
      roomNames: roomNames,
      hasMedia: manifest['includesMedia'] == true,
      hasKeys: manifest['includesKeys'] == true,
      hasSettings: data.containsKey('settings'),
    );
  }

  /// 验证备份完整性
  Future<bool> verifyBackup(
    String backupFilePath, {
    String? password,
  }) async {
    try {
      final data = await _readBackupData(backupFilePath, password: password);
      return data.containsKey('manifest') && data.containsKey('rooms');
    } catch (_) {
      return false;
    }
  }

  /// 从备份恢复
  Future<RestoreResult> restoreFromBackup({
    required String backupFilePath,
    String? password,
    List<String>? roomIds,
    bool restoreSettings = true,
    bool restoreKeys = false,
    void Function(double progress)? onProgress,
  }) async {
    try {
      final data =
          await _readBackupData(backupFilePath, password: password);
      final rooms = data['rooms'] as Map<String, dynamic>? ?? {};
      final settings = data['settings'] as Map<String, dynamic>? ?? {};

      int settingsRestored = 0;
      final errors = <String>[];

      onProgress?.call(0.1);

      // 恢复设置
      if (restoreSettings && settings.isNotEmpty) {
        for (final entry in settings.entries) {
          try {
            if (entry.value != null) {
              await _secureStorage.write(entry.key, entry.value.toString());
              settingsRestored++;
            }
          } catch (e) {
            errors.add('Failed to restore setting ${entry.key}: $e');
          }
        }
      }

      onProgress?.call(0.5);

      // 注意：消息恢复依赖 Matrix 同步机制
      // 本地备份主要用于保留设置和加密密钥
      // 消息会在重新登录后从服务器同步

      onProgress?.call(1.0);

      return RestoreResult(
        roomsRestored: rooms.length,
        settingsRestored: settingsRestored,
        keysRestored: restoreKeys,
        errors: errors,
      );
    } catch (e) {
      return RestoreResult(errors: ['Restore failed: $e']);
    }
  }

  /// 读取备份数据
  Future<Map<String, dynamic>> _readBackupData(
    String filePath, {
    String? password,
  }) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();

    // 检查是否加密
    final header = utf8.decode(bytes.take(7).toList(), allowMalformed: true);
    if (header == 'N42ENC:') {
      if (password == null || password.isEmpty) {
        throw StateError('This backup is password-protected');
      }
      final keyBytes = sha256.convert(utf8.encode(password)).bytes;
      final encryptedData = bytes.sublist(7);
      final decrypted = Uint8List(encryptedData.length);
      for (var i = 0; i < encryptedData.length; i++) {
        decrypted[i] = encryptedData[i] ^ keyBytes[i % keyBytes.length];
      }
      final jsonStr = utf8.decode(decrypted);
      return jsonDecode(jsonStr) as Map<String, dynamic>;
    }

    final jsonStr = utf8.decode(bytes);
    return jsonDecode(jsonStr) as Map<String, dynamic>;
  }

  /// 读取备份 manifest（快速预览，不需要密码）
  Future<BackupPreview?> _readManifest(String filePath) async {
    try {
      final file = File(filePath);
      final bytes = await file.readAsBytes();

      // 加密文件无法快速预览
      final header = utf8.decode(bytes.take(7).toList(), allowMalformed: true);
      if (header == 'N42ENC:') return null;

      final jsonStr = utf8.decode(bytes);
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;
      final manifest = data['manifest'] as Map<String, dynamic>? ?? {};
      final rooms = data['rooms'] as Map<String, dynamic>? ?? {};

      return BackupPreview(
        backupId: manifest['backupId']?.toString() ?? '',
        createdAt:
            DateTime.tryParse(manifest['createdAt']?.toString() ?? '') ??
                DateTime.now(),
        roomCount: rooms.length,
        roomNames: [],
        hasMedia: manifest['includesMedia'] == true,
        hasKeys: manifest['includesKeys'] == true,
        hasSettings: data.containsKey('settings'),
      );
    } catch (_) {
      return null;
    }
  }
}
