import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 安全存储数据源
///
/// 使用 flutter_secure_storage 加密存储敏感数据。
/// 仅保留会话、凭据、多账号、生物识别等真正需要加密的方法。
/// 非敏感数据（外观、备注、草稿等）已迁移至 PreferencesDataSource。
class SecureStorageDataSource {
  static const String _keySession = 'n42_chat_session';
  static const String _keyCredentials = 'n42_chat_credentials';
  static const String _keyAccounts = 'n42_chat_accounts';
  static const String _keyBiometricSettings = 'n42_chat_biometric_settings';

  final FlutterSecureStorage _storage;

  SecureStorageDataSource({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock_this_device,
              ),
            );

  // ============================================
  // 会话管理
  // ============================================

  /// 保存会话
  Future<void> saveSession({
    required String homeserver,
    required String accessToken,
    required String userId,
    required String deviceId,
  }) async {
    final sessionData = {
      'homeserver': homeserver,
      'accessToken': accessToken,
      'userId': userId,
      'deviceId': deviceId,
      'savedAt': DateTime.now().toIso8601String(),
    };

    await _storage.write(
      key: _keySession,
      value: jsonEncode(sessionData),
    );

    debugPrint('SecureStorage: Session saved for $userId');
  }

  /// 获取保存的会话
  Future<Map<String, String>?> getSession() async {
    try {
      final data = await _storage.read(key: _keySession);
      if (data == null) return null;

      final json = jsonDecode(data) as Map<String, dynamic>;
      return {
        'homeserver': json['homeserver'] as String,
        'accessToken': json['accessToken'] as String,
        'userId': json['userId'] as String,
        'deviceId': json['deviceId'] as String,
      };
    } catch (e) {
      debugPrint('SecureStorage: Failed to read session - $e');
      return null;
    }
  }

  /// 清除会话
  Future<void> clearSession() async {
    await _storage.delete(key: _keySession);
    debugPrint('SecureStorage: Session cleared');
  }

  /// 检查是否有保存的会话
  Future<bool> hasSession() async {
    final session = await getSession();
    return session != null;
  }

  // ============================================
  // 登录凭据管理（用于自动登录）
  // ============================================

  /// 保存登录凭据（用于自动登录，仿微信策略：仅记住 homeserver + username）
  Future<bool> saveCredentials({
    required String homeserver,
    required String username,
  }) async {
    final credentialsData = {
      'homeserver': homeserver,
      'username': username,
      'savedAt': DateTime.now().toIso8601String(),
    };

    final jsonValue = jsonEncode(credentialsData);
    debugPrint('SecureStorage: Saving credentials for [user]...');

    try {
      await _storage.write(
        key: _keyCredentials,
        value: jsonValue,
      );

      // 验证保存是否成功 - 立即读取回来
      final verifyData = await _storage.read(key: _keyCredentials);
      if (verifyData == null) {
        debugPrint('SecureStorage: ERROR - Credentials verification failed, read returned null');
        return false;
      }

      debugPrint('SecureStorage: Credentials saved and verified');
      return true;
    } catch (e) {
      debugPrint('SecureStorage: ERROR saving credentials - $e');
      return false;
    }
  }

  /// 获取保存的登录凭据
  Future<Map<String, String>?> getCredentials() async {
    try {
      debugPrint('SecureStorage: Reading credentials with key: $_keyCredentials');
      final data = await _storage.read(key: _keyCredentials);
      debugPrint('SecureStorage: Read data: ${data != null ? "found" : "null"}');
      if (data == null) return null;

      final json = jsonDecode(data) as Map<String, dynamic>;
      debugPrint('SecureStorage: Credentials loaded');
      return {
        'homeserver': json['homeserver'] as String,
        'username': json['username'] as String,
      };
    } catch (e) {
      debugPrint('SecureStorage: Failed to read credentials - $e');
      return null;
    }
  }

  /// 清除登录凭据
  Future<void> clearCredentials() async {
    await _storage.delete(key: _keyCredentials);
    debugPrint('SecureStorage: Credentials cleared');
  }

  /// 检查是否有保存的凭据
  Future<bool> hasCredentials() async {
    final credentials = await getCredentials();
    return credentials != null;
  }

  // ============================================
  // 多账号管理
  // ============================================

  /// 保存账号到账号列表
  Future<void> addAccount({
    required String userId,
    required String homeserver,
    required String accessToken,
    required String deviceId,
    String? displayName,
    String? avatarUrl,
  }) async {
    final accounts = await getAccounts();

    accounts[userId] = {
      'userId': userId,
      'homeserver': homeserver,
      'accessToken': accessToken,
      'deviceId': deviceId,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'addedAt': DateTime.now().toIso8601String(),
    };

    await _storage.write(
      key: _keyAccounts,
      value: jsonEncode(accounts),
    );

    debugPrint('SecureStorage: Account added - $userId');
  }

  /// 获取所有账号
  Future<Map<String, Map<String, dynamic>>> getAccounts() async {
    try {
      final data = await _storage.read(key: _keyAccounts);
      if (data == null) return {};

      final json = jsonDecode(data) as Map<String, dynamic>;
      return json.map(
        (key, value) => MapEntry(key, value as Map<String, dynamic>),
      );
    } catch (e) {
      debugPrint('SecureStorage: Failed to read accounts - $e');
      return {};
    }
  }

  /// 删除账号
  Future<void> removeAccount(String userId) async {
    final accounts = await getAccounts();
    accounts.remove(userId);

    if (accounts.isEmpty) {
      await _storage.delete(key: _keyAccounts);
    } else {
      await _storage.write(
        key: _keyAccounts,
        value: jsonEncode(accounts),
      );
    }

    debugPrint('SecureStorage: Account removed - $userId');
  }

  /// 获取账号数量
  Future<int> getAccountCount() async {
    final accounts = await getAccounts();
    return accounts.length;
  }

  // ============================================
  // 生物识别设置
  // ============================================

  /// 保存生物识别设置
  Future<void> saveBiometricSettings({
    required bool enabled,
    String? homeserver,
    String? username,
  }) async {
    final data = {
      'enabled': enabled,
      'homeserver': homeserver,
      'username': username,
      'savedAt': DateTime.now().toIso8601String(),
    };

    await _storage.write(
      key: _keyBiometricSettings,
      value: jsonEncode(data),
    );

    debugPrint('SecureStorage: Biometric settings saved - enabled: $enabled');
  }

  /// 获取生物识别设置
  Future<Map<String, dynamic>?> getBiometricSettings() async {
    try {
      final data = await _storage.read(key: _keyBiometricSettings);
      if (data == null) return null;

      return jsonDecode(data) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('SecureStorage: Failed to read biometric settings - $e');
      return null;
    }
  }

  /// 检查生物识别是否启用
  Future<bool> isBiometricEnabled() async {
    final settings = await getBiometricSettings();
    return settings?['enabled'] == true;
  }

  /// 启用生物识别登录
  Future<void> enableBiometricLogin({
    required String homeserver,
    required String username,
  }) async {
    await saveBiometricSettings(
      enabled: true,
      homeserver: homeserver,
      username: username,
    );
  }

  /// 禁用生物识别登录
  Future<void> disableBiometricLogin() async {
    await _storage.delete(key: _keyBiometricSettings);
    debugPrint('SecureStorage: Biometric settings cleared');
  }

  /// 获取生物识别绑定的用户名
  Future<String?> getBiometricUsername() async {
    final settings = await getBiometricSettings();
    return settings?['username'] as String?;
  }

  /// 获取生物识别绑定的服务器
  Future<String?> getBiometricHomeserver() async {
    final settings = await getBiometricSettings();
    return settings?['homeserver'] as String?;
  }

  // ============================================
  // 通用键值存储
  // ============================================

  /// 通用读取
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      debugPrint('SecureStorage: Read failed for key $key: $e');
      return null;
    }
  }

  /// 通用写入
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// 通用删除
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // ============================================
  // 清理
  // ============================================

  /// 清除所有数据
  Future<void> clearAll() async {
    await _storage.deleteAll();
    debugPrint('SecureStorage: All data cleared');
  }

  /// 检查存储是否可用
  Future<bool> isAvailable() async {
    try {
      const testKey = '_test_availability';
      await _storage.write(key: testKey, value: 'test');
      await _storage.delete(key: testKey);
      return true;
    } catch (e) {
      debugPrint('SecureStorage: Storage not available - $e');
      return false;
    }
  }
}
