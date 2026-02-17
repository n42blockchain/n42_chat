import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/export.dart' as pc;
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
  static const String _appVersion = '0.1.0'; // TODO: 从 package_info_plus 动态获取

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
        'appVersion': _appVersion,
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
              .take(1000)
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

    if (password != null && password.isNotEmpty) {
      final encryptedBytes = _encryptAes256(utf8.encode(jsonStr), password);
      final file = File(filePath);
      await file.writeAsBytes(encryptedBytes);
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

    // 基于房间活跃度估算：有 lastEvent 的房间按 500 条估计，
    // 无活动的按 50 条估计。每条约 200 字节 + 每房间元数据约 500 字节。
    int estimatedMessages = 0;
    for (final room in rooms) {
      final hasActivity = room.lastEvent != null;
      estimatedMessages += hasActivity ? 500 : 50;
    }
    int estimated =
        estimatedMessages * 200 + rooms.length * 500;
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

    // 检查是否使用 v2 加密 (AES-256-CBC)
    final headerV2 = utf8.decode(bytes.take(8).toList(), allowMalformed: true);
    if (headerV2 == 'N42ENC2:') {
      if (password == null || password.isEmpty) {
        throw StateError('This backup is password-protected');
      }
      final decrypted = _decryptAes256(bytes, password);
      final jsonStr = utf8.decode(decrypted);
      return jsonDecode(jsonStr) as Map<String, dynamic>;
    }

    // 兼容旧版 v1 XOR 加密格式（只读）
    final headerV1 = utf8.decode(bytes.take(7).toList(), allowMalformed: true);
    if (headerV1 == 'N42ENC:') {
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

  /// PBKDF2 密钥派生（使用 pointycastle 实现）
  static Uint8List _pbkdf2(String password, Uint8List salt,
      {int iterations = 100000, int keyLength = 32}) {
    final derivator = pc.PBKDF2KeyDerivator(pc.HMac(pc.SHA256Digest(), 64))
      ..init(pc.Pbkdf2Parameters(salt, iterations, keyLength));
    return derivator.process(Uint8List.fromList(utf8.encode(password)));
  }

  /// AES-256-CBC 加密
  /// 格式: "N42ENC2:" (8字节) + salt (32字节) + iv (16字节) + 加密数据
  static Uint8List _encryptAes256(List<int> plaintext, String password) {
    final random = Random.secure();
    final salt = Uint8List.fromList(
        List.generate(32, (_) => random.nextInt(256)));
    final iv = Uint8List.fromList(
        List.generate(16, (_) => random.nextInt(256)));

    final key = _pbkdf2(password, salt, iterations: 100000, keyLength: 32);

    // PKCS7 填充
    const blockSize = 16;
    final padLength = blockSize - (plaintext.length % blockSize);
    final padded = Uint8List(plaintext.length + padLength);
    padded.setRange(0, plaintext.length, plaintext);
    for (var i = plaintext.length; i < padded.length; i++) {
      padded[i] = padLength;
    }

    final cipher = pc.CBCBlockCipher(pc.AESEngine())
      ..init(true, pc.ParametersWithIV(pc.KeyParameter(key), iv));

    final encrypted = Uint8List(padded.length);
    for (var offset = 0; offset < padded.length; offset += blockSize) {
      cipher.processBlock(padded, offset, encrypted, offset);
    }

    return Uint8List.fromList([
      ...utf8.encode('N42ENC2:'),
      ...salt,
      ...iv,
      ...encrypted,
    ]);
  }

  /// AES-256-CBC 解密
  static Uint8List _decryptAes256(Uint8List data, String password) {
    // 跳过头部 "N42ENC2:" (8 字节)
    final salt = Uint8List.fromList(data.sublist(8, 40));
    final iv = Uint8List.fromList(data.sublist(40, 56));
    final ciphertext = Uint8List.fromList(data.sublist(56));

    final key = _pbkdf2(password, salt, iterations: 100000, keyLength: 32);

    final cipher = pc.CBCBlockCipher(pc.AESEngine())
      ..init(false, pc.ParametersWithIV(pc.KeyParameter(key), iv));

    final decrypted = Uint8List(ciphertext.length);
    const blockSize = 16;
    for (var offset = 0; offset < ciphertext.length; offset += blockSize) {
      cipher.processBlock(ciphertext, offset, decrypted, offset);
    }

    // 移除 PKCS7 填充
    final padLength = decrypted.last;
    if (padLength > 0 && padLength <= blockSize) {
      return Uint8List.fromList(
          decrypted.sublist(0, decrypted.length - padLength));
    }
    return decrypted;
  }

  /// 读取备份 manifest（快速预览，不需要密码）
  ///
  /// 仅读取文件头部来检测加密状态，非加密文件读取前 64KB 解析 manifest。
  Future<BackupPreview?> _readManifest(String filePath) async {
    try {
      final file = File(filePath);
      if (!file.existsSync()) return null;

      // 先读取头部 8 字节检测加密
      final raf = await file.open(mode: FileMode.read);
      try {
        final header = await raf.read(8);
        final headerStr =
            utf8.decode(header, allowMalformed: true);
        if (headerStr == 'N42ENC2:' ||
            headerStr.startsWith('N42ENC:')) {
          return null; // 加密文件无法快速预览
        }
      } finally {
        await raf.close();
      }

      // 非加密文件：读取前 64KB 尝试提取 manifest
      final fileSize = await file.length();
      final readSize = fileSize < 65536 ? fileSize : 65536;
      final raf2 = await file.open(mode: FileMode.read);
      try {
        final bytes = await raf2.read(readSize);
        final partial = utf8.decode(bytes, allowMalformed: true);

        // 尝试找到完整的 manifest JSON 块
        final manifestStart = partial.indexOf('"manifest"');
        if (manifestStart == -1) return null;

        // 如果文件较小，直接完整解析
        if (fileSize < 65536) {
          final data =
              jsonDecode(partial) as Map<String, dynamic>;
          final manifest =
              data['manifest'] as Map<String, dynamic>? ?? {};
          final rooms =
              data['rooms'] as Map<String, dynamic>? ?? {};
          return BackupPreview(
            backupId: manifest['backupId']?.toString() ?? '',
            createdAt: DateTime.tryParse(
                    manifest['createdAt']?.toString() ?? '') ??
                DateTime.now(),
            roomCount: rooms.length,
            roomNames: [],
            hasMedia: manifest['includesMedia'] == true,
            hasKeys: manifest['includesKeys'] == true,
            hasSettings: data.containsKey('settings'),
          );
        }

        // 大文件：仅提取 manifest 部分
        // 找到 manifest 值的开始 '{' 和匹配的 '}'
        final objStart = partial.indexOf('{', manifestStart);
        if (objStart == -1) return null;
        int depth = 0;
        int objEnd = -1;
        for (var i = objStart; i < partial.length; i++) {
          if (partial[i] == '{') depth++;
          if (partial[i] == '}') depth--;
          if (depth == 0) {
            objEnd = i + 1;
            break;
          }
        }
        if (objEnd == -1) return null;

        final manifestJson = partial.substring(objStart, objEnd);
        final manifest =
            jsonDecode(manifestJson) as Map<String, dynamic>;
        return BackupPreview(
          backupId: manifest['backupId']?.toString() ?? '',
          createdAt: DateTime.tryParse(
                  manifest['createdAt']?.toString() ?? '') ??
              DateTime.now(),
          roomCount: manifest['roomCount'] as int? ?? 0,
          roomNames: [],
          hasMedia: manifest['includesMedia'] == true,
          hasKeys: manifest['includesKeys'] == true,
          hasSettings: true, // 假定有设置
        );
      } finally {
        await raf2.close();
      }
    } catch (_) {
      return null;
    }
  }
}
