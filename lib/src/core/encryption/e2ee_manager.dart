import 'package:matrix/matrix.dart' as matrix;

/// 端到端加密管理器
///
/// 封装Matrix SDK的加密功能，提供统一的加密接口
class E2EEManager {
  final matrix.Client _client;

  E2EEManager(this._client);

  /// 是否支持加密
  bool get isEncryptionSupported => _client.encryptionEnabled;

  /// 是否已初始化加密
  bool get isEncryptionInitialized => _client.encryption != null;

  /// 初始化加密
  Future<void> initializeEncryption() async {
    if (!isEncryptionSupported) {
      throw E2EEException('Encryption is not supported');
    }

    // Matrix SDK会自动初始化加密
  }

  /// 获取加密状态
  E2EEStatus get status {
    if (!isEncryptionSupported) {
      return E2EEStatus.notSupported;
    }
    if (!isEncryptionInitialized) {
      return E2EEStatus.notInitialized;
    }
    return E2EEStatus.ready;
  }

  // ============================================
  // 密钥管理
  // ============================================

  /// 导出房间密钥
  Future<String> exportRoomKeys(String password) async {
    if (!isEncryptionInitialized) {
      throw E2EEException('Encryption not initialized');
    }

    final encryption = _client.encryption;
    if (encryption == null) {
      throw E2EEException('Encryption not available');
    }

    // 简化实现：返回空字符串
    // 实际导出需要更复杂的处理
    return '';
  }

  /// 导入房间密钥
  Future<int> importRoomKeys(String exportedKeys, String password) async {
    if (!isEncryptionInitialized) {
      throw E2EEException('Encryption not initialized');
    }

    // 简化实现：返回导入的密钥数量
    return 0;
  }

  /// 获取恢复密钥（用于跨设备恢复）
  Future<String?> getRecoveryKey() async {
    // SSSS恢复密钥需要通过开启流程获取
    return null;
  }

  /// 创建新的恢复密钥
  Future<String?> createRecoveryKey() async {
    final encryption = _client.encryption;
    if (encryption == null) return null;

    // 使用SSSS（安全秘密存储）创建恢复密钥
    try {
      // 简化实现
      return null;
    } catch (e) {
      throw E2EEException('Failed to create recovery key: $e');
    }
  }

  // ============================================
  // 设备验证
  // ============================================

  /// 获取当前设备ID
  String? get currentDeviceId => _client.deviceID;

  /// 获取所有已知设备
  List<matrix.DeviceKeys> getDevicesForUser(String userId) {
    final encryption = _client.encryption;
    if (encryption == null) return [];

    final userKeys = _client.userDeviceKeys[userId];
    return userKeys?.deviceKeys.values.toList() ?? [];
  }

  /// 验证设备
  Future<void> verifyDevice(
    String userId,
    String deviceId, {
    bool verified = true,
  }) async {
    final userKeys = _client.userDeviceKeys[userId];
    if (userKeys == null) {
      throw E2EEException('User not found');
    }

    final device = userKeys.deviceKeys[deviceId];
    if (device == null) {
      throw E2EEException('Device not found');
    }

    await device.setVerified(verified);
  }

  /// 检查设备是否已验证
  bool isDeviceVerified(String userId, String deviceId) {
    final userKeys = _client.userDeviceKeys[userId];
    if (userKeys == null) return false;

    final device = userKeys.deviceKeys[deviceId];
    return device?.verified ?? false;
  }

  /// 获取所有未验证的设备
  List<DeviceInfo> getUnverifiedDevices(String userId) {
    final devices = getDevicesForUser(userId);
    return devices
        .where((d) => !d.verified)
        .map((d) => DeviceInfo(
              deviceId: d.deviceId ?? '',
              deviceName: d.unsigned?['device_display_name'] as String? ?? 'Unknown',
              isVerified: d.verified,
              lastSeenTs: d.unsigned?['last_seen_ts'] as int?,
            ))
        .toList();
  }

  // ============================================
  // 房间加密
  // ============================================

  /// 检查房间是否加密
  bool isRoomEncrypted(String roomId) {
    final room = _client.getRoomById(roomId);
    return room?.encrypted ?? false;
  }

  /// 在房间启用加密
  Future<void> enableEncryptionInRoom(String roomId) async {
    final room = _client.getRoomById(roomId);
    if (room == null) {
      throw E2EEException('Room not found');
    }

    if (room.encrypted) {
      return; // 已启用
    }

    await room.enableEncryption();
  }

  /// 获取房间加密状态
  RoomEncryptionStatus getRoomEncryptionStatus(String roomId) {
    final room = _client.getRoomById(roomId);
    if (room == null) return RoomEncryptionStatus.unknown;

    if (!room.encrypted) {
      return RoomEncryptionStatus.unencrypted;
    }

    // 检查是否有未验证的设备
    final members = room.getParticipants();
    for (final member in members) {
      final unverified = getUnverifiedDevices(member.id);
      if (unverified.isNotEmpty) {
        return RoomEncryptionStatus.encryptedWithUnverifiedDevices;
      }
    }

    return RoomEncryptionStatus.encrypted;
  }

  // ============================================
  // 跨设备签名验证 (Cross-Signing)
  // ============================================

  /// 是否已设置跨设备签名
  bool get isCrossSigningEnabled {
    return _client.encryption?.crossSigning.enabled ?? false;
  }

  /// 初始化跨设备签名
  Future<void> initializeCrossSigning() async {
    final encryption = _client.encryption;
    if (encryption == null) {
      throw E2EEException('Encryption not initialized');
    }

    try {
      await encryption.crossSigning.selfSign();
    } catch (e) {
      throw E2EEException('Failed to initialize cross-signing: $e');
    }
  }

  /// 使用恢复密钥恢复跨设备签名
  Future<void> recoverCrossSigning(String recoveryKey) async {
    final encryption = _client.encryption;
    if (encryption == null) {
      throw E2EEException('Encryption not initialized');
    }

    try {
      encryption.ssss.open(recoveryKey);
      await encryption.crossSigning.selfSign(recoveryKey: recoveryKey);
    } catch (e) {
      throw E2EEException('Failed to recover cross-signing: $e');
    }
  }

  // ============================================
  // 密钥请求处理
  // ============================================

  /// 处理传入的密钥请求
  void handleKeyRequests(void Function(KeyRequest request)? onKeyRequest) {
    // Matrix SDK自动处理密钥请求，这里提供回调接口
  }
}

/// E2EE状态
enum E2EEStatus {
  /// 不支持加密
  notSupported,

  /// 未初始化
  notInitialized,

  /// 已就绪
  ready,
}

/// 房间加密状态
enum RoomEncryptionStatus {
  /// 未知
  unknown,

  /// 未加密
  unencrypted,

  /// 已加密
  encrypted,

  /// 已加密但有未验证设备
  encryptedWithUnverifiedDevices,
}

/// 设备信息
class DeviceInfo {
  final String deviceId;
  final String deviceName;
  final bool isVerified;
  final int? lastSeenTs;

  DeviceInfo({
    required this.deviceId,
    required this.deviceName,
    required this.isVerified,
    this.lastSeenTs,
  });

  DateTime? get lastSeen =>
      lastSeenTs != null ? DateTime.fromMillisecondsSinceEpoch(lastSeenTs!) : null;
}

/// 密钥请求
class KeyRequest {
  final String requesterId;
  final String deviceId;
  final String roomId;
  final String sessionId;

  KeyRequest({
    required this.requesterId,
    required this.deviceId,
    required this.roomId,
    required this.sessionId,
  });
}

/// E2EE异常
class E2EEException implements Exception {
  final String message;

  E2EEException(this.message);

  @override
  String toString() => 'E2EEException: $message';
}
