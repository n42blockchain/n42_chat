import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 安全存储数据源
///
/// 使用 flutter_secure_storage 加密存储敏感数据
class SecureStorageDataSource {
  static const String _keySession = 'n42_chat_session';
  static const String _keyAccounts = 'n42_chat_accounts';
  static const String _keySettings = 'n42_chat_settings';
  static const String _keyContactRemarks = 'n42_chat_contact_remarks';
  static const String _keyAppearanceSettings = 'n42_chat_appearance_settings';

  final FlutterSecureStorage _storage;

  SecureStorageDataSource({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                encryptedSharedPreferences: true,
              ),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock,
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
  // 外观设置
  // ============================================

  /// 保存外观设置
  Future<void> saveAppearanceSettings({
    required String themeMode,
    required String fontSize,
    String? chatBackground,
    required String bubbleStyle,
  }) async {
    final data = {
      'themeMode': themeMode,
      'fontSize': fontSize,
      'chatBackground': chatBackground,
      'bubbleStyle': bubbleStyle,
      'savedAt': DateTime.now().toIso8601String(),
    };

    await _storage.write(
      key: _keyAppearanceSettings,
      value: jsonEncode(data),
    );

    debugPrint('SecureStorage: Appearance settings saved');
  }

  /// 获取外观设置
  Future<Map<String, String?>?> getAppearanceSettings() async {
    try {
      final data = await _storage.read(key: _keyAppearanceSettings);
      if (data == null) return null;

      final json = jsonDecode(data) as Map<String, dynamic>;
      return {
        'themeMode': json['themeMode'] as String?,
        'fontSize': json['fontSize'] as String?,
        'chatBackground': json['chatBackground'] as String?,
        'bubbleStyle': json['bubbleStyle'] as String?,
      };
    } catch (e) {
      debugPrint('SecureStorage: Failed to read appearance settings - $e');
      return null;
    }
  }

  /// 保存主题模式
  Future<void> saveThemeMode(String themeMode) async {
    final current = await getAppearanceSettings();
    await saveAppearanceSettings(
      themeMode: themeMode,
      fontSize: current?['fontSize'] ?? 'medium',
      chatBackground: current?['chatBackground'],
      bubbleStyle: current?['bubbleStyle'] ?? 'wechat',
    );
  }

  /// 获取主题模式
  Future<String?> getThemeMode() async {
    final settings = await getAppearanceSettings();
    return settings?['themeMode'];
  }

  // ============================================
  // 联系人备注
  // ============================================

  /// 获取所有联系人备注
  Future<Map<String, String>> getContactRemarks() async {
    try {
      final data = await _storage.read(key: _keyContactRemarks);
      if (data == null) return {};

      final json = jsonDecode(data) as Map<String, dynamic>;
      return json.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      debugPrint('SecureStorage: Failed to read contact remarks - $e');
      return {};
    }
  }

  /// 设置联系人备注
  Future<void> setContactRemark(String userId, String? remark) async {
    final remarks = await getContactRemarks();

    if (remark == null || remark.isEmpty) {
      remarks.remove(userId);
    } else {
      remarks[userId] = remark;
    }

    await _storage.write(
      key: _keyContactRemarks,
      value: jsonEncode(remarks),
    );

    debugPrint('SecureStorage: Contact remark set for $userId');
  }

  /// 获取联系人备注
  Future<String?> getContactRemark(String userId) async {
    final remarks = await getContactRemarks();
    return remarks[userId];
  }

  /// 删除联系人备注
  Future<void> removeContactRemark(String userId) async {
    await setContactRemark(userId, null);
  }

  // ============================================
  // 设置存储
  // ============================================

  /// 保存设置项
  Future<void> saveSetting(String key, String value) async {
    final settings = await _getSettings();
    settings[key] = value;
    await _storage.write(
      key: _keySettings,
      value: jsonEncode(settings),
    );
  }

  /// 获取设置项
  Future<String?> getSetting(String key) async {
    final settings = await _getSettings();
    return settings[key];
  }

  /// 删除设置项
  Future<void> removeSetting(String key) async {
    final settings = await _getSettings();
    settings.remove(key);
    await _storage.write(
      key: _keySettings,
      value: jsonEncode(settings),
    );
  }

  Future<Map<String, String>> _getSettings() async {
    try {
      final data = await _storage.read(key: _keySettings);
      if (data == null) return {};

      final json = jsonDecode(data) as Map<String, dynamic>;
      return json.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      return {};
    }
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

