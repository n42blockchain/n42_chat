import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/secure_storage_datasource.dart';
import '../datasources/matrix/matrix_auth_datasource.dart';

/// 认证仓库实现
class AuthRepositoryImpl implements IAuthRepository {
  final MatrixAuthDataSource _authDataSource;
  final SecureStorageDataSource _secureStorage;

  final _loginStateController = StreamController<bool>.broadcast();

  AuthRepositoryImpl({
    MatrixAuthDataSource? authDataSource,
    SecureStorageDataSource? secureStorage,
  })  : _authDataSource = authDataSource ?? MatrixAuthDataSource(),
        _secureStorage = secureStorage ?? SecureStorageDataSource();

  @override
  bool get isLoggedIn => _authDataSource.isLoggedIn;

  // 缓存用户资料数据
  Map<String, dynamic>? _cachedProfileData;
  // 缓存的头像 URL 和显示名
  String? _cachedAvatarUrl;
  String? _cachedDisplayName;
  
  @override
  UserEntity? get currentUser {
    if (!isLoggedIn) return null;

    final client = _authDataSource.clientManager.client;
    if (client == null) return null;

    final userId = client.userID;
    if (userId == null) return null;
    
    // 从缓存的资料数据中获取额外字段
    final profileData = _cachedProfileData ?? {};

    return UserEntity(
      userId: userId,
      displayName: _cachedDisplayName ?? userId.localpart ?? '',
      avatarUrl: _cachedAvatarUrl,
      gender: profileData['gender'] as String?,
      region: profileData['region'] as String?,
      signature: profileData['signature'] as String?,
      pokeText: profileData['pokeText'] as String?,
    );
  }

  @override
  Stream<bool> get loginStateStream => _loginStateController.stream;

  @override
  Future<AuthResult> login({
    required String homeserver,
    required String username,
    required String password,
    bool rememberMe = true,
  }) async {
    try {
      // 登录
      final response = await _authDataSource.loginWithPassword(
        homeserver: homeserver,
        username: username,
        password: password,
      );

      final accessToken = response.accessToken;
      final userId = response.userId;
      final deviceId = response.deviceId ?? '';
      
      if (accessToken.isEmpty || userId.isEmpty) {
        return AuthResult.failure(
          '登录响应无效',
          type: AuthErrorType.serverError,
        );
      }

      // 保存会话
      await _saveSession(
        homeserver: homeserver,
        accessToken: accessToken,
        userId: userId,
        deviceId: deviceId,
      );

      // 如果勾选了"记住我"，保存登录凭据用于自动登录
      if (rememberMe) {
        await _secureStorage.saveCredentials(
          homeserver: homeserver,
          username: username,
          password: password,
        );
        debugPrint('AuthRepository: Credentials saved for auto-login');
      } else {
        // 清除之前保存的凭据
        await _secureStorage.clearCredentials();
      }

      // 启动同步
      await _authDataSource.clientManager.startSync();

      // 通知登录状态变化
      _loginStateController.add(true);

      // 加载用户资料（包括头像）
      final userProfile = await getCurrentUserProfile();
      final user = userProfile ?? UserEntity(
        userId: userId,
        displayName: username,
      );

      debugPrint('AuthRepository: Login successful - ${user.userId}');
      return AuthResult.success(user);
    } on MatrixException catch (e) {
      debugPrint('AuthRepository: Login failed - ${e.errorMessage}');
      return _handleMatrixError(e);
    } catch (e) {
      debugPrint('AuthRepository: Login error - $e');
      return AuthResult.failure(
        '登录失败: ${e.toString()}',
        type: AuthErrorType.unknown,
      );
    }
  }

  @override
  Future<AuthResult> loginWithToken({
    required String homeserver,
    required String accessToken,
    required String userId,
    required String deviceId,
  }) async {
    try {
      await _authDataSource.loginWithToken(
        homeserver: homeserver,
        accessToken: accessToken,
        userId: userId,
        deviceId: deviceId,
      );

      // 保存会话
      await _saveSession(
        homeserver: homeserver,
        accessToken: accessToken,
        userId: userId,
        deviceId: deviceId,
      );

      // 启动同步
      await _authDataSource.clientManager.startSync();

      _loginStateController.add(true);

      final user = UserEntity(
        userId: userId,
        displayName: userId.split(':').first.replaceFirst('@', ''),
      );

      return AuthResult.success(user);
    } catch (e) {
      debugPrint('AuthRepository: Token login failed - $e');
      return AuthResult.failure(
        '会话恢复失败',
        type: AuthErrorType.tokenExpired,
      );
    }
  }

  @override
  Future<AuthResult> restoreSession() async {
    try {
      // 首先尝试使用保存的 token 恢复会话
      final session = await _secureStorage.getSession();
      if (session != null) {
        final homeserver = session['homeserver'];
        final accessToken = session['accessToken'];
        final userId = session['userId'];
        final deviceId = session['deviceId'];

        if (homeserver != null &&
            accessToken != null &&
            userId != null &&
            deviceId != null) {
          debugPrint('AuthRepository: Trying to restore with token...');
          final result = await loginWithToken(
            homeserver: homeserver,
            accessToken: accessToken,
            userId: userId,
            deviceId: deviceId,
          );

          if (result.success) {
            debugPrint('AuthRepository: Session restored with token');
            return result;
          }
          
          debugPrint('AuthRepository: Token restore failed, trying credentials...');
        }
      }

      // Token 恢复失败，尝试使用保存的凭据重新登录
      final credentials = await _secureStorage.getCredentials();
      if (credentials != null) {
        final homeserver = credentials['homeserver'];
        final username = credentials['username'];
        final password = credentials['password'];

        if (homeserver != null && username != null && password != null) {
          debugPrint('AuthRepository: Trying auto-login with credentials...');
          final result = await login(
            homeserver: homeserver,
            username: username,
            password: password,
            rememberMe: true, // 保持记住状态
          );

          if (result.success) {
            debugPrint('AuthRepository: Auto-login successful');
            return result;
          }
          
          debugPrint('AuthRepository: Auto-login failed: ${result.errorMessage}');
        }
      }

      // 既没有有效的 token，也没有有效的凭据
      debugPrint('AuthRepository: No valid session or credentials found');
      return AuthResult.notLoggedIn();
    } catch (e) {
      debugPrint('AuthRepository: Restore session failed - $e');
      return AuthResult.failure(
        '会话恢复失败',
        type: AuthErrorType.tokenExpired,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      // 停止同步
      _authDataSource.clientManager.stopSync();

      // 登出
      await _authDataSource.logout();

      // 清除保存的会话
      await _secureStorage.clearSession();

      _loginStateController.add(false);
      debugPrint('AuthRepository: Logout successful');
    } catch (e) {
      debugPrint('AuthRepository: Logout error - $e');
      // 即使出错也清除本地会话
      await _secureStorage.clearSession();
      _loginStateController.add(false);
    }
  }

  @override
  Future<AuthResult> register({
    required String homeserver,
    required String username,
    required String password,
    String? email,
    String? registrationToken,
  }) async {
    try {
      final response = await _authDataSource.register(
        homeserver: homeserver,
        username: username,
        password: password,
        email: email,
        registrationToken: registrationToken,
      );

      final accessToken = response.accessToken ?? '';
      final userId = response.userId ?? '';
      final deviceId = response.deviceId ?? '';

      // 如果注册成功并自动登录
      if (accessToken.isNotEmpty && userId.isNotEmpty) {
        await _saveSession(
          homeserver: homeserver,
          accessToken: accessToken,
          userId: userId,
          deviceId: deviceId,
        );

        await _authDataSource.clientManager.startSync();
        _loginStateController.add(true);

        final user = UserEntity(
          userId: userId,
          displayName: username,
        );

        return AuthResult.success(user);
      }

      // 需要额外验证（如邮箱验证）
      return AuthResult.failure(
        '需要完成额外验证',
        type: AuthErrorType.additionalAuthRequired,
      );
    } on MatrixException catch (e) {
      return _handleMatrixError(e);
    } catch (e) {
      return AuthResult.failure(
        '注册失败: ${e.toString()}',
        type: AuthErrorType.unknown,
      );
    }
  }

  @override
  Future<HomeserverInfo> checkHomeserver(String homeserver) async {
    try {
      final (discoveryInfo, versionsResponse, loginFlows) = 
          await _authDataSource.checkHomeserver(homeserver);

      final baseUrl = discoveryInfo?.mHomeserver?.baseUrl.toString() ?? homeserver;

      return HomeserverInfo(
        serverName: baseUrl,
        serverVersion: versionsResponse.versions.isNotEmpty 
            ? versionsResponse.versions.last 
            : '',
        supportedLoginTypes:
            loginFlows.map((f) => f.type).whereType<String>().toList(),
        supportsRegistration: true, // 假设支持，实际需要检查
      );
    } catch (e) {
      debugPrint('AuthRepository: Check homeserver failed - $e');
      throw HomeserverCheckException('无法连接到服务器: $e');
    }
  }

  @override
  Future<bool> isUsernameAvailable(String homeserver, String username) async {
    return await _authDataSource.isUsernameAvailable(homeserver, username);
  }

  @override
  Future<UserEntity?> getCurrentUserProfile() async {
    if (!isLoggedIn) return null;

    final client = _authDataSource.clientManager.client;
    if (client == null) return null;

    final userId = client.userID;
    if (userId == null) return null;

    try {
      final profile =
          await _authDataSource.clientManager.getUserProfile(userId);

      // 手动构建头像 HTTP URL
      String? avatarHttpUrl;
      if (profile.avatarUrl != null) {
        avatarHttpUrl = _buildAvatarHttpUrl(profile.avatarUrl.toString(), client);
      }
      
      // 缓存头像和显示名
      _cachedAvatarUrl = avatarHttpUrl;
      _cachedDisplayName = profile.displayName ?? userId.localpart ?? '';
      
      // 加载自定义资料数据
      await getUserProfileData();
      
      final profileData = _cachedProfileData ?? {};

      return UserEntity(
        userId: userId,
        displayName: _cachedDisplayName!,
        avatarUrl: avatarHttpUrl,
        gender: profileData['gender'] as String?,
        region: profileData['region'] as String?,
        signature: profileData['signature'] as String?,
        pokeText: profileData['pokeText'] as String?,
      );
    } catch (e) {
      debugPrint('AuthRepository: Get profile failed - $e');
      return currentUser;
    }
  }
  
  /// 构建头像 HTTP URL（不再在 URL 中添加 access_token，改用请求头认证）
  String? _buildAvatarHttpUrl(String? mxcUrl, Client client) {
    if (mxcUrl == null || mxcUrl.isEmpty) return null;
    if (!mxcUrl.startsWith('mxc://')) return mxcUrl;
    
    try {
      final uri = Uri.parse(mxcUrl);
      final serverName = uri.host;
      final mediaId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';
      
      if (serverName.isEmpty || mediaId.isEmpty) return null;
      
      final homeserver = client.homeserver?.toString().replaceAll(RegExp(r'/$'), '') ?? '';
      if (homeserver.isEmpty) return null;
      
      // 使用认证媒体 API (Matrix 1.11+)
      return '$homeserver/_matrix/client/v1/media/thumbnail/$serverName/$mediaId?width=96&height=96&method=crop';
    } catch (e) {
      debugPrint('AuthRepository: Error building avatar URL: $e');
      return null;
    }
  }

  @override
  Future<void> updateProfile({
    String? displayName,
    String? avatarPath,
  }) async {
    if (!isLoggedIn) return;

    if (displayName != null) {
      await _authDataSource.clientManager.setDisplayName(displayName);
    }
  }

  @override
  Future<bool> updateAvatar(Uint8List avatarBytes, String filename) async {
    if (!isLoggedIn) return false;

    try {
      await _authDataSource.clientManager.setAvatar(avatarBytes, filename);
      debugPrint('AuthRepository: Avatar updated successfully');
      
      // 刷新用户资料以更新缓存的头像 URL
      await getCurrentUserProfile();
      
      return true;
    } catch (e) {
      debugPrint('AuthRepository: Update avatar failed - $e');
      return false;
    }
  }

  @override
  Future<bool> updateDisplayName(String displayName) async {
    if (!isLoggedIn) return false;

    try {
      await _authDataSource.clientManager.setDisplayName(displayName);
      debugPrint('AuthRepository: Display name updated to: $displayName');
      return true;
    } catch (e) {
      debugPrint('AuthRepository: Update display name failed - $e');
      return false;
    }
  }

  @override
  Future<bool> updateUserProfileData({
    String? gender,
    String? region,
    String? signature,
    String? pokeText,
  }) async {
    if (!isLoggedIn) return false;

    final client = _authDataSource.clientManager.client;
    if (client == null) return false;

    try {
      // 获取现有数据
      final existingData = await getUserProfileData() ?? {};
      
      // 合并新数据
      final newData = Map<String, dynamic>.from(existingData);
      if (gender != null) newData['gender'] = gender;
      if (region != null) newData['region'] = region;
      if (signature != null) newData['signature'] = signature;
      if (pokeText != null) newData['pokeText'] = pokeText;
      
      // 保存到 Matrix 账户数据
      await client.setAccountData(
        client.userID!,
        'n42.user.profile',
        newData,
      );
      
      // 更新缓存
      _cachedProfileData = newData;
      
      debugPrint('AuthRepository: Profile data updated: $newData');
      return true;
    } catch (e) {
      debugPrint('AuthRepository: Update profile data failed - $e');
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserProfileData() async {
    if (!isLoggedIn) return null;

    final client = _authDataSource.clientManager.client;
    if (client == null) return null;

    try {
      final data = await client.getAccountData(
        client.userID!,
        'n42.user.profile',
      );
      
      if (data is Map<String, dynamic>) {
        _cachedProfileData = data;
        return data;
      }
      return null;
    } catch (e) {
      debugPrint('AuthRepository: Get profile data failed - $e');
      return null;
    }
  }

  // ============================================
  // 私有方法
  // ============================================

  Future<void> _saveSession({
    required String homeserver,
    required String accessToken,
    required String userId,
    required String deviceId,
  }) async {
    await _secureStorage.saveSession(
      homeserver: homeserver,
      accessToken: accessToken,
      userId: userId,
      deviceId: deviceId,
    );
  }

  AuthResult _handleMatrixError(MatrixException e) {
    final errorCode = e.errorMessage;

    if (errorCode.contains('M_FORBIDDEN') ||
        errorCode.contains('M_UNAUTHORIZED')) {
      return AuthResult.failure(
        '用户名或密码错误',
        type: AuthErrorType.invalidCredentials,
      );
    }

    if (errorCode.contains('M_USER_IN_USE')) {
      return AuthResult.failure(
        '用户名已被使用',
        type: AuthErrorType.usernameExists,
      );
    }

    if (errorCode.contains('M_INVALID_USERNAME')) {
      return AuthResult.failure(
        '用户名格式无效',
        type: AuthErrorType.usernameUnavailable,
      );
    }

    if (errorCode.contains('M_LIMIT_EXCEEDED')) {
      return AuthResult.failure(
        '请求过于频繁，请稍后再试',
        type: AuthErrorType.rateLimited,
      );
    }

    if (errorCode.contains('M_UNKNOWN_TOKEN')) {
      return AuthResult.failure(
        '登录已过期',
        type: AuthErrorType.tokenExpired,
      );
    }

    return AuthResult.failure(
      e.errorMessage,
      type: AuthErrorType.serverError,
    );
  }

  void dispose() {
    _loginStateController.close();
  }
}

/// Homeserver检查异常
class HomeserverCheckException implements Exception {
  final String message;

  HomeserverCheckException(this.message);

  @override
  String toString() => message;
}
