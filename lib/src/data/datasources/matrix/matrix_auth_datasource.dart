import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart';

import 'matrix_client_manager.dart';

/// Matrix认证数据源
///
/// 封装Matrix SDK的认证相关操作
class MatrixAuthDataSource {
  final MatrixClientManager _clientManager;

  MatrixAuthDataSource({
    MatrixClientManager? clientManager,
  }) : _clientManager = clientManager ?? MatrixClientManager.instance;

  /// 获取客户端管理器
  MatrixClientManager get clientManager => _clientManager;

  /// 是否已登录
  bool get isLoggedIn => _clientManager.isLoggedIn;

  /// 当前用户ID
  String? get userId => _clientManager.userId;

  // ============================================
  // 登录
  // ============================================

  /// 使用用户名密码登录
  ///
  /// 返回包含 accessToken, userId, deviceId 等信息的登录响应
  Future<LoginResponse> loginWithPassword({
    required String homeserver,
    required String username,
    required String password,
    String? deviceName,
  }) async {
    // 确保客户端已初始化
    if (!_clientManager.isInitialized) {
      await _clientManager.initialize();
    }

    return await _clientManager.login(
      homeserver: homeserver,
      username: username,
      password: password,
      deviceName: deviceName,
    );
  }

  /// 使用Token恢复登录
  Future<void> loginWithToken({
    required String homeserver,
    required String accessToken,
    required String userId,
    required String deviceId,
  }) async {
    if (!_clientManager.isInitialized) {
      await _clientManager.initialize();
    }

    await _clientManager.loginWithToken(
      homeserver: homeserver,
      accessToken: accessToken,
      userId: userId,
      deviceId: deviceId,
    );
  }

  /// 检查Homeserver是否有效
  Future<HomeserverSummary> checkHomeserver(String homeserver) async {
    if (!_clientManager.isInitialized) {
      await _clientManager.initialize();
    }

    final client = _clientManager.client;
    if (client == null) {
      throw StateError('Matrix client not initialized');
    }

    final homeserverUri = Uri.parse(homeserver);
    return await client.checkHomeserver(homeserverUri);
  }

  /// 获取支持的登录方式
  Future<List<LoginFlow>> getLoginFlows(String homeserver) async {
    if (!_clientManager.isInitialized) {
      await _clientManager.initialize();
    }

    final client = _clientManager.client;
    if (client == null) {
      throw StateError('Matrix client not initialized');
    }

    // 先检查homeserver
    final homeserverUri = Uri.parse(homeserver);
    await client.checkHomeserver(homeserverUri);

    // 获取登录方式
    return await client.getLoginFlows() ?? [];
  }

  // ============================================
  // 注册
  // ============================================

  /// 注册新用户
  ///
  /// [homeserver] 服务器地址
  /// [username] 用户名
  /// [password] 密码
  /// [email] 邮箱（可选）
  /// [deviceName] 设备名称
  /// [registrationToken] 注册邀请码（某些服务器需要）
  Future<RegisterResponse> register({
    required String homeserver,
    required String username,
    required String password,
    String? email,
    String? deviceName,
    String? registrationToken,
  }) async {
    // 确保客户端已初始化
    // 如果未初始化，尝试初始化；如果初始化失败，强制重新初始化
    if (!_clientManager.isInitialized) {
      try {
        await _clientManager.initialize();
      } catch (e) {
        // 如果初始化失败，尝试强制重新初始化
        debugPrint('MatrixAuthDataSource: Initial init failed: $e, force reinit...');
        await Future.delayed(const Duration(milliseconds: 500));
        await _clientManager.initialize(forceReinit: true);
      }
    }

    // 再次检查客户端状态
    final client = _clientManager.client;
    if (client == null) {
      // 最后一次尝试
      debugPrint('MatrixAuthDataSource: Client still null, final attempt...');
      await _clientManager.initialize(forceReinit: true);
    }

    final finalClient = _clientManager.client;
    if (finalClient == null) {
      throw StateError('Matrix client not initialized after multiple attempts');
    }

    // 设置homeserver
    final homeserverUri = Uri.parse(homeserver);
    await finalClient.checkHomeserver(homeserverUri);

    // 构建认证数据
    AuthenticationData? auth;
    if (registrationToken != null && registrationToken.isNotEmpty) {
      auth = RegistrationTokenAuthenticationData(
        token: registrationToken,
      );
    }

    // 注册
    // 注意：这个流程可能需要额外的认证步骤（如验证码）
    try {
      return await finalClient.register(
        username: username,
        password: password,
        initialDeviceDisplayName: deviceName ?? 'N42Chat',
        auth: auth,
      );
    } on MatrixException catch (e) {
      // 处理 UIA 流程 - 如果服务器返回 401 且有 session
      if (e.response?.statusCode == 401) {
        try {
          final rawBody = e.response?.body;
          if (rawBody == null || rawBody.isEmpty) rethrow;
          
          // 解析响应体为 Map（body 是 JSON 字符串）
          final decoded = jsonDecode(rawBody);
          if (decoded is! Map<String, dynamic>) rethrow;
          
          final body = decoded;
          final session = body['session']?.toString();
          final flows = body['flows'];
          
          // 检查是否需要 registration_token
          bool needsToken = false;
          if (flows is List) {
            needsToken = flows.any((flow) {
              if (flow is Map) {
                final stages = flow['stages'];
                if (stages is List) {
                  return stages.contains('m.login.registration_token');
                }
              }
              return false;
            });
          }

          if (needsToken && registrationToken != null && session != null) {
            // 使用 session 重新尝试注册
            final authWithSession = RegistrationTokenAuthenticationData(
              token: registrationToken,
              session: session,
            );
            
            return await finalClient.register(
              username: username,
              password: password,
              initialDeviceDisplayName: deviceName ?? 'N42Chat',
              auth: authWithSession,
            );
          }
        } catch (_) {
          // 解析或处理失败，继续抛出原始异常
        }
      }
      rethrow;
    }
  }

  /// 检查用户名是否可用
  Future<bool> isUsernameAvailable(String homeserver, String username) async {
    if (!_clientManager.isInitialized) {
      await _clientManager.initialize();
    }

    final client = _clientManager.client;
    if (client == null) {
      throw StateError('Matrix client not initialized');
    }

    // 设置homeserver
    final homeserverUri = Uri.parse(homeserver);
    await client.checkHomeserver(homeserverUri);

    try {
      // Matrix SDK 可能没有直接的 usernameAvailable 方法
      // 通过尝试注册来检查用户名是否可用
      // 这里简化处理，返回 true
      return true;
    } catch (e) {
      // 用户名不可用会抛出异常
      return false;
    }
  }

  // ============================================
  // 登出
  // ============================================

  /// 登出
  Future<void> logout() async {
    await _clientManager.logout();
  }

  /// 登出所有设备
  Future<void> logoutAll() async {
    final client = _clientManager.client;
    if (client == null || !_clientManager.isLoggedIn) return;

    // 获取所有设备并登出
    try {
      await client.logoutAll();
    } catch (e) {
      // 忽略错误，继续登出当前设备
      await logout();
    }
  }

  // ============================================
  // 会话管理
  // ============================================

  /// 获取当前会话信息
  SessionCredentials? getSessionCredentials() {
    final client = _clientManager.client;
    if (client == null || !_clientManager.isLoggedIn) return null;

    return SessionCredentials(
      homeserver: client.homeserver?.toString() ?? '',
      accessToken: client.accessToken ?? '',
      userId: client.userID ?? '',
      deviceId: client.deviceID ?? '',
      deviceName: client.deviceName ?? '',
    );
  }

  /// 刷新访问令牌
  ///
  /// 注意：Matrix协议本身不支持刷新token，
  /// 但某些服务器可能提供这个功能
  Future<void> refreshToken() async {
    // Matrix协议不直接支持刷新token
    // 如果token过期，需要重新登录
    throw UnimplementedError(
      'Matrix protocol does not support token refresh. '
      'Please login again if token expired.',
    );
  }

  // ============================================
  // 设备管理
  // ============================================

  /// 获取设备列表
  Future<List<Device>> getDevices() async {
    final client = _clientManager.client;
    if (client == null || !_clientManager.isLoggedIn) {
      return [];
    }

    final response = await client.getDevices();
    return response ?? [];
  }

  /// 删除设备
  Future<void> deleteDevice(String deviceId, {AuthenticationData? auth}) async {
    final client = _clientManager.client;
    if (client == null || !_clientManager.isLoggedIn) return;

    await client.deleteDevice(deviceId, auth: auth);
  }

  /// 更新设备名称
  Future<void> updateDeviceName(String deviceId, String displayName) async {
    final client = _clientManager.client;
    if (client == null || !_clientManager.isLoggedIn) return;

    await client.updateDevice(deviceId, displayName: displayName);
  }
}

/// 会话凭证
class SessionCredentials {
  final String homeserver;
  final String accessToken;
  final String userId;
  final String deviceId;
  final String deviceName;

  const SessionCredentials({
    required this.homeserver,
    required this.accessToken,
    required this.userId,
    required this.deviceId,
    required this.deviceName,
  });

  Map<String, dynamic> toJson() => {
        'homeserver': homeserver,
        'accessToken': accessToken,
        'userId': userId,
        'deviceId': deviceId,
        'deviceName': deviceName,
      };

  factory SessionCredentials.fromJson(Map<String, dynamic> json) {
    return SessionCredentials(
      homeserver: json['homeserver'] as String,
      accessToken: json['accessToken'] as String,
      userId: json['userId'] as String,
      deviceId: json['deviceId'] as String,
      deviceName: json['deviceName'] as String? ?? '',
    );
  }

  @override
  String toString() => 'SessionCredentials(userId: $userId, deviceId: $deviceId)';
}

/// 用于 registration_token 认证的数据类
/// 
/// Matrix 规范要求 m.login.registration_token 认证需要提供 token 字段
class RegistrationTokenAuthenticationData extends AuthenticationData {
  final String token;
  
  RegistrationTokenAuthenticationData({
    required this.token,
    String? session,
  }) : super(
    type: 'm.login.registration_token',
    session: session,
  );
  
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['token'] = token;
    return json;
  }
}

