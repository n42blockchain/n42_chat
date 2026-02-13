import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 安全存储数据源
///
/// 使用 flutter_secure_storage 加密存储敏感数据
class SecureStorageDataSource {
  static const String _keySession = 'n42_chat_session';
  static const String _keyCredentials = 'n42_chat_credentials';
  static const String _keyAccounts = 'n42_chat_accounts';
  static const String _keySettings = 'n42_chat_settings';
  static const String _keyContactRemarks = 'n42_chat_contact_remarks';
  static const String _keyAppearanceSettings = 'n42_chat_appearance_settings';
  static const String _keyStrongReminders = 'n42_chat_strong_reminders';
  static const String _keyBiometricSettings = 'n42_chat_biometric_settings';
  static const String _keyLocallyDeletedMessages = 'n42_chat_locally_deleted_messages';
  static const String _keyMessageDestructionTimes = 'n42_chat_message_destruction_times';
  static const String _keyPrivacySettings = 'n42_chat_privacy_settings';
  static const String _keyScheduledMessages = 'n42_chat_scheduled_messages';
  static const String _keyMomentSettings = 'n42_chat_moment_settings';
  static const String _keyHiddenMomentUsers = 'n42_chat_hidden_moment_users';
  static const String _keyBlockedMomentUsers = 'n42_chat_blocked_moment_users';
  static const String _keyMomentLastReadTime = 'n42_chat_moment_last_read_time';
  static const String _keyHiddenChats = 'n42_chat_hidden_chats';
  static const String _keyQuickReplies = 'n42_chat_quick_replies';
  static const String _keyTranslationCache = 'n42_chat_translation_cache';
  static const String _keyTranslationSettings = 'n42_chat_translation_settings';
  static const String _keyFavoriteMessages = 'n42_chat_favorite_messages';
  static const String _keyFavoriteMeta = 'n42_chat_favorite_meta';
  static const String _keyDrafts = 'n42_chat_drafts';

  final FlutterSecureStorage _storage;

  SecureStorageDataSource({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(),
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
  // 登录凭据管理（用于自动登录）
  // ============================================

  /// 保存登录凭据（用于自动登录）
  Future<bool> saveCredentials({
    required String homeserver,
    required String username,
    required String password,
  }) async {
    final credentialsData = {
      'homeserver': homeserver,
      'username': username,
      'password': password,
      'savedAt': DateTime.now().toIso8601String(),
    };

    final jsonValue = jsonEncode(credentialsData);
    debugPrint('SecureStorage: Saving credentials for $username with key: $_keyCredentials');

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

      debugPrint('SecureStorage: Credentials saved and verified for $username');
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
      debugPrint('SecureStorage: Parsed credentials for ${json['username']}');
      return {
        'homeserver': json['homeserver'] as String,
        'username': json['username'] as String,
        'password': json['password'] as String,
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
  // 强提醒设置
  // ============================================

  /// 获取所有强提醒设置
  Future<Map<String, bool>> getStrongReminders() async {
    try {
      final data = await _storage.read(key: _keyStrongReminders);
      if (data == null) return {};

      final json = jsonDecode(data) as Map<String, dynamic>;
      return json.map((key, value) => MapEntry(key, value == true || value == 'true'));
    } catch (e) {
      debugPrint('SecureStorage: Failed to read strong reminders - $e');
      return {};
    }
  }

  /// 设置强提醒
  Future<void> setStrongReminder(String roomId, bool enabled) async {
    final reminders = await getStrongReminders();

    if (!enabled) {
      reminders.remove(roomId);
    } else {
      reminders[roomId] = true;
    }

    await _storage.write(
      key: _keyStrongReminders,
      value: jsonEncode(reminders),
    );

    debugPrint('SecureStorage: Strong reminder set for $roomId: $enabled');
  }

  /// 获取强提醒状态
  Future<bool> getStrongReminderStatus(String roomId) async {
    final reminders = await getStrongReminders();
    return reminders[roomId] ?? false;
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
  // 本地删除消息管理
  // ============================================

  /// 获取房间的本地删除消息ID列表
  Future<Set<String>> getLocallyDeletedMessageIds(String roomId) async {
    try {
      final data = await _storage.read(key: _keyLocallyDeletedMessages);
      if (data == null) return {};

      final json = jsonDecode(data) as Map<String, dynamic>;
      final roomData = json[roomId] as List<dynamic>?;
      if (roomData == null) return {};

      return roomData.cast<String>().toSet();
    } catch (e) {
      debugPrint('SecureStorage: Failed to read locally deleted messages - $e');
      return {};
    }
  }

  /// 标记消息为本地删除
  Future<void> markMessagesAsLocallyDeleted(String roomId, List<String> messageIds) async {
    try {
      final data = await _storage.read(key: _keyLocallyDeletedMessages);
      Map<String, dynamic> allData = {};

      if (data != null) {
        allData = jsonDecode(data) as Map<String, dynamic>;
      }

      // 获取当前房间的已删除消息列表
      final currentIds = (allData[roomId] as List<dynamic>?)?.cast<String>().toSet() ?? <String>{};
      currentIds.addAll(messageIds);

      // 限制每个房间最多保存 1000 个删除记录
      final limitedIds = currentIds.toList();
      if (limitedIds.length > 1000) {
        limitedIds.removeRange(0, limitedIds.length - 1000);
      }

      allData[roomId] = limitedIds;

      await _storage.write(
        key: _keyLocallyDeletedMessages,
        value: jsonEncode(allData),
      );

      debugPrint('SecureStorage: Marked ${messageIds.length} messages as locally deleted in $roomId');
    } catch (e) {
      debugPrint('SecureStorage: Failed to mark messages as locally deleted - $e');
    }
  }

  /// 清除房间的本地删除消息记录
  Future<void> clearLocallyDeletedMessages(String roomId) async {
    try {
      final data = await _storage.read(key: _keyLocallyDeletedMessages);
      if (data == null) return;

      final allData = jsonDecode(data) as Map<String, dynamic>;
      allData.remove(roomId);

      if (allData.isEmpty) {
        await _storage.delete(key: _keyLocallyDeletedMessages);
      } else {
        await _storage.write(
          key: _keyLocallyDeletedMessages,
          value: jsonEncode(allData),
        );
      }

      debugPrint('SecureStorage: Cleared locally deleted messages for $roomId');
    } catch (e) {
      debugPrint('SecureStorage: Failed to clear locally deleted messages - $e');
    }
  }

  // ============================================
  // 阅后即焚消息销毁时间管理
  // ============================================

  /// 设置消息的销毁时间
  Future<void> setMessageDestroyedAt(
    String roomId,
    String messageId,
    DateTime destroyedAt,
  ) async {
    try {
      final data = await _storage.read(key: _keyMessageDestructionTimes);
      Map<String, dynamic> allData = {};

      if (data != null) {
        allData = jsonDecode(data) as Map<String, dynamic>;
      }

      // 获取当前房间的销毁时间记录
      final roomData = (allData[roomId] as Map<String, dynamic>?) ?? {};
      roomData[messageId] = destroyedAt.toIso8601String();
      allData[roomId] = roomData;

      await _storage.write(
        key: _keyMessageDestructionTimes,
        value: jsonEncode(allData),
      );

      debugPrint('SecureStorage: Set destruction time for message $messageId in $roomId');
    } catch (e) {
      debugPrint('SecureStorage: Failed to set message destruction time - $e');
    }
  }

  /// 获取房间所有消息的销毁时间
  Future<Map<String, DateTime>> getMessageDestructionTimes(String roomId) async {
    try {
      final data = await _storage.read(key: _keyMessageDestructionTimes);
      if (data == null) return {};

      final allData = jsonDecode(data) as Map<String, dynamic>;
      final roomData = allData[roomId] as Map<String, dynamic>?;
      if (roomData == null) return {};

      return roomData.map((key, value) {
        return MapEntry(key, DateTime.parse(value as String));
      });
    } catch (e) {
      debugPrint('SecureStorage: Failed to read message destruction times - $e');
      return {};
    }
  }

  /// 获取单条消息的销毁时间
  Future<DateTime?> getMessageDestroyedAt(String roomId, String messageId) async {
    final times = await getMessageDestructionTimes(roomId);
    return times[messageId];
  }

  /// 清除指定消息的销毁时间记录
  Future<void> clearMessageDestructionTimes(
    String roomId,
    List<String> messageIds,
  ) async {
    try {
      final data = await _storage.read(key: _keyMessageDestructionTimes);
      if (data == null) return;

      final allData = jsonDecode(data) as Map<String, dynamic>;
      final roomData = allData[roomId] as Map<String, dynamic>?;
      if (roomData == null) return;

      for (final messageId in messageIds) {
        roomData.remove(messageId);
      }

      if (roomData.isEmpty) {
        allData.remove(roomId);
      } else {
        allData[roomId] = roomData;
      }

      if (allData.isEmpty) {
        await _storage.delete(key: _keyMessageDestructionTimes);
      } else {
        await _storage.write(
          key: _keyMessageDestructionTimes,
          value: jsonEncode(allData),
        );
      }

      debugPrint('SecureStorage: Cleared ${messageIds.length} destruction time records in $roomId');
    } catch (e) {
      debugPrint('SecureStorage: Failed to clear message destruction times - $e');
    }
  }

  /// 清除房间所有消息的销毁时间记录
  Future<void> clearAllMessageDestructionTimes(String roomId) async {
    try {
      final data = await _storage.read(key: _keyMessageDestructionTimes);
      if (data == null) return;

      final allData = jsonDecode(data) as Map<String, dynamic>;
      allData.remove(roomId);

      if (allData.isEmpty) {
        await _storage.delete(key: _keyMessageDestructionTimes);
      } else {
        await _storage.write(
          key: _keyMessageDestructionTimes,
          value: jsonEncode(allData),
        );
      }

      debugPrint('SecureStorage: Cleared all destruction time records in $roomId');
    } catch (e) {
      debugPrint('SecureStorage: Failed to clear all destruction times - $e');
    }
  }

  // ============================================
  // 隐私设置
  // ============================================

  /// 保存隐私设置
  ///
  /// [avatarVisibility] 头像可见性 (everyone, contacts, nobody)
  /// [statusVisibility] 状态可见性 (everyone, contacts, nobody)
  /// [lastSeenVisibility] 最后上线时间可见性 (everyone, contacts, nobody)
  /// [allowStrangerMessage] 是否允许陌生人私聊
  /// [showReadReceipts] 是否显示已读回执
  /// [showTypingIndicator] 是否显示输入状态
  Future<void> savePrivacySettings({
    String avatarVisibility = 'everyone',
    String statusVisibility = 'everyone',
    String lastSeenVisibility = 'everyone',
    bool allowStrangerMessage = true,
    bool showReadReceipts = true,
    bool showTypingIndicator = true,
  }) async {
    final data = {
      'avatarVisibility': avatarVisibility,
      'statusVisibility': statusVisibility,
      'lastSeenVisibility': lastSeenVisibility,
      'allowStrangerMessage': allowStrangerMessage,
      'showReadReceipts': showReadReceipts,
      'showTypingIndicator': showTypingIndicator,
      'savedAt': DateTime.now().toIso8601String(),
    };

    await _storage.write(
      key: _keyPrivacySettings,
      value: jsonEncode(data),
    );

    debugPrint('SecureStorage: Privacy settings saved');
  }

  /// 获取隐私设置
  Future<Map<String, dynamic>?> getPrivacySettings() async {
    try {
      final data = await _storage.read(key: _keyPrivacySettings);
      if (data == null) return null;

      return jsonDecode(data) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('SecureStorage: Failed to read privacy settings - $e');
      return null;
    }
  }

  /// 检查是否应该显示已读回执
  Future<bool> shouldShowReadReceipts() async {
    final settings = await getPrivacySettings();
    return (settings?['showReadReceipts'] as bool?) ?? true;
  }

  /// 检查是否应该显示输入状态
  Future<bool> shouldShowTypingIndicator() async {
    final settings = await getPrivacySettings();
    return (settings?['showTypingIndicator'] as bool?) ?? true;
  }

  /// 更新单个隐私设置项
  Future<void> updatePrivacySetting(String key, dynamic value) async {
    final current = await getPrivacySettings() ?? {};
    current[key] = value;
    current['savedAt'] = DateTime.now().toIso8601String();

    await _storage.write(
      key: _keyPrivacySettings,
      value: jsonEncode(current),
    );

    debugPrint('SecureStorage: Privacy setting updated - $key: $value');
  }

  // ============================================
  // 定时消息管理
  // ============================================

  /// 保存定时消息
  ///
  /// [roomId] 房间ID
  /// [messageId] 本地临时消息ID
  /// [text] 消息内容
  /// [scheduledAt] 预定发送时间
  /// [selfDestructAfter] 阅后即焚秒数（可选）
  /// [mentionedUserIds] 提及的用户ID列表（可选）
  /// [mentionsRoom] 是否 @全体成员
  Future<void> saveScheduledMessage({
    required String roomId,
    required String messageId,
    required String text,
    required DateTime scheduledAt,
    int? selfDestructAfter,
    List<String>? mentionedUserIds,
    bool mentionsRoom = false,
  }) async {
    try {
      final data = await _storage.read(key: _keyScheduledMessages);
      Map<String, dynamic> allData = {};

      if (data != null) {
        allData = jsonDecode(data) as Map<String, dynamic>;
      }

      // 获取当前房间的定时消息列表
      final roomMessages = (allData[roomId] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];

      // 添加新的定时消息
      roomMessages.add({
        'messageId': messageId,
        'text': text,
        'scheduledAt': scheduledAt.toIso8601String(),
        'selfDestructAfter': selfDestructAfter,
        'mentionedUserIds': mentionedUserIds,
        'mentionsRoom': mentionsRoom,
        'createdAt': DateTime.now().toIso8601String(),
      });

      allData[roomId] = roomMessages;

      await _storage.write(
        key: _keyScheduledMessages,
        value: jsonEncode(allData),
      );

      debugPrint('SecureStorage: Scheduled message saved - $messageId for $scheduledAt');
    } catch (e) {
      debugPrint('SecureStorage: Failed to save scheduled message - $e');
    }
  }

  /// 获取房间的所有定时消息
  Future<List<Map<String, dynamic>>> getScheduledMessages(String roomId) async {
    try {
      final data = await _storage.read(key: _keyScheduledMessages);
      if (data == null) return [];

      final allData = jsonDecode(data) as Map<String, dynamic>;
      final roomMessages = allData[roomId] as List<dynamic>?;
      if (roomMessages == null) return [];

      return roomMessages.cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('SecureStorage: Failed to read scheduled messages - $e');
      return [];
    }
  }

  /// 获取所有房间的到期定时消息
  Future<List<Map<String, dynamic>>> getDueScheduledMessages() async {
    try {
      final data = await _storage.read(key: _keyScheduledMessages);
      if (data == null) return [];

      final allData = jsonDecode(data) as Map<String, dynamic>;
      final now = DateTime.now();
      final dueMessages = <Map<String, dynamic>>[];

      for (final entry in allData.entries) {
        final roomId = entry.key;
        final messages = (entry.value as List<dynamic>).cast<Map<String, dynamic>>();

        for (final msg in messages) {
          final scheduledAt = DateTime.parse(msg['scheduledAt'] as String);
          if (now.isAfter(scheduledAt) || now.isAtSameMomentAs(scheduledAt)) {
            dueMessages.add({
              ...msg,
              'roomId': roomId,
            });
          }
        }
      }

      return dueMessages;
    } catch (e) {
      debugPrint('SecureStorage: Failed to get due scheduled messages - $e');
      return [];
    }
  }

  /// 删除定时消息
  Future<void> removeScheduledMessage(String roomId, String messageId) async {
    try {
      final data = await _storage.read(key: _keyScheduledMessages);
      if (data == null) return;

      final allData = jsonDecode(data) as Map<String, dynamic>;
      final roomMessages = (allData[roomId] as List<dynamic>?)?.cast<Map<String, dynamic>>();
      if (roomMessages == null) return;

      roomMessages.removeWhere((msg) => msg['messageId'] == messageId);

      if (roomMessages.isEmpty) {
        allData.remove(roomId);
      } else {
        allData[roomId] = roomMessages;
      }

      if (allData.isEmpty) {
        await _storage.delete(key: _keyScheduledMessages);
      } else {
        await _storage.write(
          key: _keyScheduledMessages,
          value: jsonEncode(allData),
        );
      }

      debugPrint('SecureStorage: Scheduled message removed - $messageId');
    } catch (e) {
      debugPrint('SecureStorage: Failed to remove scheduled message - $e');
    }
  }

  /// 清除房间所有定时消息
  Future<void> clearScheduledMessages(String roomId) async {
    try {
      final data = await _storage.read(key: _keyScheduledMessages);
      if (data == null) return;

      final allData = jsonDecode(data) as Map<String, dynamic>;
      allData.remove(roomId);

      if (allData.isEmpty) {
        await _storage.delete(key: _keyScheduledMessages);
      } else {
        await _storage.write(
          key: _keyScheduledMessages,
          value: jsonEncode(allData),
        );
      }

      debugPrint('SecureStorage: Cleared all scheduled messages for $roomId');
    } catch (e) {
      debugPrint('SecureStorage: Failed to clear scheduled messages - $e');
    }
  }

  // ============================================
  // 朋友圈设置
  // ============================================

  /// 保存朋友圈设置
  Future<void> saveMomentSettings({
    bool allowStrangers = false,
    int visibleDays = 0,
  }) async {
    final data = {
      'allowStrangers': allowStrangers,
      'visibleDays': visibleDays,
    };
    await _storage.write(
      key: _keyMomentSettings,
      value: jsonEncode(data),
    );
  }

  /// 获取朋友圈设置
  Future<Map<String, dynamic>?> getMomentSettings() async {
    try {
      final data = await _storage.read(key: _keyMomentSettings);
      if (data == null) return null;
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('SecureStorage: Failed to read moment settings - $e');
      return null;
    }
  }

  /// 保存不看谁的朋友圈列表
  Future<void> saveHiddenMomentUsers(List<String> userIds) async {
    await _storage.write(
      key: _keyHiddenMomentUsers,
      value: jsonEncode(userIds),
    );
  }

  /// 获取不看谁的朋友圈列表
  Future<List<String>?> getHiddenMomentUsers() async {
    try {
      final data = await _storage.read(key: _keyHiddenMomentUsers);
      if (data == null) return null;
      return (jsonDecode(data) as List).cast<String>();
    } catch (e) {
      debugPrint('SecureStorage: Failed to read hidden moment users - $e');
      return null;
    }
  }

  /// 保存不让谁看我的朋友圈列表
  Future<void> saveBlockedMomentUsers(List<String> userIds) async {
    await _storage.write(
      key: _keyBlockedMomentUsers,
      value: jsonEncode(userIds),
    );
  }

  /// 获取不让谁看我的朋友圈列表
  Future<List<String>?> getBlockedMomentUsers() async {
    try {
      final data = await _storage.read(key: _keyBlockedMomentUsers);
      if (data == null) return null;
      return (jsonDecode(data) as List).cast<String>();
    } catch (e) {
      debugPrint('SecureStorage: Failed to read blocked moment users - $e');
      return null;
    }
  }

  /// 保存朋友圈最后阅读时间
  Future<void> saveMomentLastReadTime(DateTime time) async {
    await _storage.write(
      key: _keyMomentLastReadTime,
      value: time.toIso8601String(),
    );
  }

  /// 获取朋友圈最后阅读时间
  Future<DateTime?> getMomentLastReadTime() async {
    try {
      final data = await _storage.read(key: _keyMomentLastReadTime);
      if (data == null) return null;
      return DateTime.parse(data);
    } catch (e) {
      debugPrint('SecureStorage: Failed to read moment last read time - $e');
      return null;
    }
  }

  // ============================================
  // 隐藏聊天管理
  // ============================================

  /// 获取隐藏的聊天 ID 集合
  Future<Set<String>> getHiddenChatIds() async {
    try {
      final data = await _storage.read(key: _keyHiddenChats);
      if (data == null) return {};
      return (jsonDecode(data) as List).cast<String>().toSet();
    } catch (e) {
      debugPrint('SecureStorage: Failed to read hidden chats - $e');
      return {};
    }
  }

  /// 隐藏聊天
  Future<void> hideChat(String roomId) async {
    try {
      final ids = await getHiddenChatIds();
      ids.add(roomId);
      await _storage.write(
        key: _keyHiddenChats,
        value: jsonEncode(ids.toList()),
      );
      debugPrint('SecureStorage: Chat hidden - $roomId');
    } catch (e) {
      debugPrint('SecureStorage: Failed to hide chat - $e');
    }
  }

  /// 取消隐藏聊天
  Future<void> unhideChat(String roomId) async {
    try {
      final ids = await getHiddenChatIds();
      ids.remove(roomId);
      await _storage.write(
        key: _keyHiddenChats,
        value: jsonEncode(ids.toList()),
      );
      debugPrint('SecureStorage: Chat unhidden - $roomId');
    } catch (e) {
      debugPrint('SecureStorage: Failed to unhide chat - $e');
    }
  }

  /// 检查聊天是否被隐藏
  Future<bool> isChatHidden(String roomId) async {
    final ids = await getHiddenChatIds();
    return ids.contains(roomId);
  }

  // ============================================
  // 快捷回复模板管理
  // ============================================

  /// 获取快捷回复模板列表
  Future<List<Map<String, dynamic>>> getQuickReplies() async {
    try {
      final data = await _storage.read(key: _keyQuickReplies);
      if (data == null) {
        // 返回默认模板
        return _getDefaultQuickReplies();
      }
      return (jsonDecode(data) as List).cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('SecureStorage: Failed to read quick replies - $e');
      return _getDefaultQuickReplies();
    }
  }

  List<Map<String, dynamic>> _getDefaultQuickReplies() {
    const defaults = ['好的', '收到', '稍等', '在忙，稍后回复', '谢谢', '没问题'];
    return defaults.asMap().entries.map((e) => {
      'id': 'default_${e.key}',
      'content': e.value,
      'order': e.key,
      'isSystem': true,
    }).toList();
  }

  /// 保存快捷回复模板列表
  Future<void> saveQuickReplies(List<Map<String, dynamic>> replies) async {
    try {
      await _storage.write(
        key: _keyQuickReplies,
        value: jsonEncode(replies),
      );
      debugPrint('SecureStorage: Quick replies saved');
    } catch (e) {
      debugPrint('SecureStorage: Failed to save quick replies - $e');
    }
  }

  /// 添加快捷回复模板
  Future<void> addQuickReply(String content) async {
    try {
      final replies = await getQuickReplies();
      final newReply = {
        'id': 'custom_${DateTime.now().millisecondsSinceEpoch}',
        'content': content,
        'order': replies.length,
        'isSystem': false,
      };
      replies.add(newReply);
      await saveQuickReplies(replies);
    } catch (e) {
      debugPrint('SecureStorage: Failed to add quick reply - $e');
    }
  }

  /// 删除快捷回复模板
  Future<void> removeQuickReply(String id) async {
    try {
      final replies = await getQuickReplies();
      replies.removeWhere((r) => r['id'] == id);
      await saveQuickReplies(replies);
    } catch (e) {
      debugPrint('SecureStorage: Failed to remove quick reply - $e');
    }
  }

  /// 更新快捷回复使用时间
  Future<void> updateQuickReplyLastUsed(String id) async {
    try {
      final replies = await getQuickReplies();
      final index = replies.indexWhere((r) => r['id'] == id);
      if (index != -1) {
        replies[index]['lastUsed'] = DateTime.now().toIso8601String();
        await saveQuickReplies(replies);
      }
    } catch (e) {
      debugPrint('SecureStorage: Failed to update quick reply last used - $e');
    }
  }

  // ============================================
  // 翻译缓存管理
  // ============================================

  /// 获取翻译缓存
  Future<String?> getTranslationCache(String messageId, String targetLanguage) async {
    try {
      final data = await _storage.read(key: _keyTranslationCache);
      if (data == null) return null;

      final cache = jsonDecode(data) as Map<String, dynamic>;
      final key = '${messageId}_$targetLanguage';
      return cache[key] as String?;
    } catch (e) {
      debugPrint('SecureStorage: Failed to read translation cache - $e');
      return null;
    }
  }

  /// 保存翻译缓存
  Future<void> saveTranslationCache(String messageId, String targetLanguage, String translation) async {
    try {
      final data = await _storage.read(key: _keyTranslationCache);
      Map<String, dynamic> cache = {};
      if (data != null) {
        cache = jsonDecode(data) as Map<String, dynamic>;
      }

      final key = '${messageId}_$targetLanguage';
      cache[key] = translation;

      // 限制缓存大小，最多保存 500 条
      if (cache.length > 500) {
        final keys = cache.keys.toList();
        for (var i = 0; i < 100; i++) {
          cache.remove(keys[i]);
        }
      }

      await _storage.write(
        key: _keyTranslationCache,
        value: jsonEncode(cache),
      );
    } catch (e) {
      debugPrint('SecureStorage: Failed to save translation cache - $e');
    }
  }

  /// 获取翻译设置
  Future<Map<String, dynamic>?> getTranslationSettings() async {
    try {
      final data = await _storage.read(key: _keyTranslationSettings);
      if (data == null) return null;
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('SecureStorage: Failed to read translation settings - $e');
      return null;
    }
  }

  /// 保存翻译设置
  Future<void> saveTranslationSettings({
    String? defaultTargetLanguage,
    bool? autoTranslate,
  }) async {
    try {
      final current = await getTranslationSettings() ?? {};
      if (defaultTargetLanguage != null) {
        current['defaultTargetLanguage'] = defaultTargetLanguage;
      }
      if (autoTranslate != null) {
        current['autoTranslate'] = autoTranslate;
      }
      current['updatedAt'] = DateTime.now().toIso8601String();

      await _storage.write(
        key: _keyTranslationSettings,
        value: jsonEncode(current),
      );
    } catch (e) {
      debugPrint('SecureStorage: Failed to save translation settings - $e');
    }
  }

  // ============================================
  // 聊天背景
  // ============================================

  /// 设置聊天背景
  Future<void> setChatBackground(String roomId, String backgroundPath) async {
    await _storage.write(key: 'n42_chat_background_$roomId', value: backgroundPath);
  }

  /// 获取聊天背景
  Future<String?> getChatBackground(String roomId) async {
    return await _storage.read(key: 'n42_chat_background_$roomId');
  }

  /// 设置默认聊天背景
  Future<void> setDefaultChatBackground(String backgroundPath) async {
    await _storage.write(key: 'n42_chat_default_background', value: backgroundPath);
  }

  /// 获取默认聊天背景
  Future<String?> getDefaultChatBackground() async {
    return await _storage.read(key: 'n42_chat_default_background');
  }

  // ============================================
  // 字体大小
  // ============================================

  /// 设置消息字体大小
  Future<void> setMessageFontSize(double size) async {
    await _storage.write(key: 'n42_chat_message_font_size', value: size.toString());
  }

  /// 获取消息字体大小
  Future<double> getMessageFontSize() async {
    final value = await _storage.read(key: 'n42_chat_message_font_size');
    return double.tryParse(value ?? '') ?? 16.0;
  }

  // ============================================
  // 自动下载设置
  // ============================================

  /// 保存自动下载设置
  Future<void> saveAutoDownloadSettings(Map<String, dynamic> settings) async {
    await _storage.write(
      key: 'n42_chat_auto_download_settings',
      value: jsonEncode(settings),
    );
  }

  /// 获取自动下载设置
  Future<Map<String, dynamic>> getAutoDownloadSettings() async {
    final value = await _storage.read(key: 'n42_chat_auto_download_settings');
    if (value == null || value.isEmpty) return {};

    try {
      return (jsonDecode(value) as Map<String, dynamic>);
    } catch (e) {
      // 兼容旧的 key=value 格式
      final map = <String, dynamic>{};
      for (final pair in value.split(',')) {
        final parts = pair.split('=');
        if (parts.length == 2) {
          map[parts[0]] = parts[1] == 'true' ? true : (parts[1] == 'false' ? false : parts[1]);
        }
      }
      return map;
    }
  }

  // ============================================
  // 收藏消息持久化
  // ============================================

  /// 保存收藏消息列表（JSON）
  Future<void> saveFavoriteMessages(String json) async {
    await _storage.write(key: _keyFavoriteMessages, value: json);
  }

  /// 获取收藏消息列表（JSON）
  Future<String?> getFavoriteMessages() async {
    return await _storage.read(key: _keyFavoriteMessages);
  }

  /// 保存收藏元数据（标签+备注）
  Future<void> saveFavoriteMeta(String json) async {
    await _storage.write(key: _keyFavoriteMeta, value: json);
  }

  /// 获取收藏元数据
  Future<String?> getFavoriteMeta() async {
    return await _storage.read(key: _keyFavoriteMeta);
  }

  // ============================================
  // 草稿持久化
  // ============================================

  /// 保存房间草稿
  Future<void> saveDraft(String roomId, String text) async {
    try {
      final data = await _storage.read(key: _keyDrafts);
      Map<String, dynamic> drafts = {};
      if (data != null) {
        drafts = jsonDecode(data) as Map<String, dynamic>;
      }
      if (text.isEmpty) {
        drafts.remove(roomId);
      } else {
        drafts[roomId] = text;
      }
      if (drafts.isEmpty) {
        await _storage.delete(key: _keyDrafts);
      } else {
        await _storage.write(key: _keyDrafts, value: jsonEncode(drafts));
      }
    } catch (e) {
      debugPrint('SecureStorage: Failed to save draft - $e');
    }
  }

  /// 获取房间草稿
  Future<String?> getDraft(String roomId) async {
    try {
      final data = await _storage.read(key: _keyDrafts);
      if (data == null) return null;
      final drafts = jsonDecode(data) as Map<String, dynamic>;
      return drafts[roomId] as String?;
    } catch (e) {
      debugPrint('SecureStorage: Failed to read draft - $e');
      return null;
    }
  }

  // ============================================
  // 通用键值存储（供扩展模块使用）
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
  // 聊天文件夹管理
  // ============================================

  static const String _keyChatFolders = 'n42_chat_folders';

  /// 保存聊天文件夹列表
  Future<void> saveChatFolders(List<Map<String, dynamic>> folders) async {
    await _storage.write(
      key: _keyChatFolders,
      value: jsonEncode(folders),
    );
  }

  /// 获取聊天文件夹列表
  Future<List<Map<String, dynamic>>> getChatFolders() async {
    try {
      final data = await _storage.read(key: _keyChatFolders);
      if (data == null) return [];
      final list = jsonDecode(data) as List<dynamic>;
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('SecureStorage: Failed to load chat folders: $e');
      return [];
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

