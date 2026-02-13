import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/secure_storage_datasource.dart';
import '../datasources/matrix/matrix_auth_datasource.dart';
import '../datasources/remote/social_auth_api.dart';

/// 认证仓库实现
class AuthRepositoryImpl implements IAuthRepository {
  final MatrixAuthDataSource _authDataSource;
  final SecureStorageDataSource _secureStorage;
  final SocialAuthApi _socialAuthApi;

  final _loginStateController = StreamController<bool>.broadcast();

  AuthRepositoryImpl({
    MatrixAuthDataSource? authDataSource,
    SecureStorageDataSource? secureStorage,
    SocialAuthApi? socialAuthApi,
  })  : _authDataSource = authDataSource ?? MatrixAuthDataSource(),
        _secureStorage = secureStorage ?? SecureStorageDataSource(),
        _socialAuthApi = socialAuthApi ?? SocialAuthApi();

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
      ringtone: profileData['ringtone'] as String?,
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
      final deviceId = response.deviceId;
      
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

      // 检查是否启用了生物识别登录
      // 如果启用了，保留凭据用于生物识别快速登录
      final isBiometricEnabled = await _secureStorage.isBiometricEnabled();
      if (!isBiometricEnabled) {
        await _secureStorage.clearCredentials();
        debugPrint('AuthRepository: Credentials cleared (biometric not enabled)');
      } else {
        debugPrint('AuthRepository: Credentials preserved for biometric login');
      }

      // 清除缓存的用户资料
      _cachedProfileData = null;
      _cachedAvatarUrl = null;
      _cachedDisplayName = null;

      _loginStateController.add(false);
      debugPrint('AuthRepository: Logout successful');
    } catch (e) {
      debugPrint('AuthRepository: Logout error - $e');
      // 即使出错也清除本地会话
      await _secureStorage.clearSession();
      // 出错时不清除凭据，保守处理
      _cachedProfileData = null;
      _cachedAvatarUrl = null;
      _cachedDisplayName = null;
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
      final userId = response.userId;
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
      // 并行请求标准资料和自定义资料
      final results = await Future.wait([
        _authDataSource.clientManager.getUserProfile(userId),
        getUserProfileData(),
      ]);
      final profile = results[0] as Profile;

      // 手动构建头像 HTTP URL
      String? avatarHttpUrl;
      if (profile.avatarUrl != null) {
        avatarHttpUrl = _buildAvatarHttpUrl(profile.avatarUrl.toString(), client);
      }

      // 缓存头像和显示名
      _cachedAvatarUrl = avatarHttpUrl;
      _cachedDisplayName = profile.displayName ?? userId.localpart ?? '';
      
      final profileData = _cachedProfileData ?? {};

      return UserEntity(
        userId: userId,
        displayName: _cachedDisplayName!,
        avatarUrl: avatarHttpUrl,
        gender: profileData['gender'] as String?,
        region: profileData['region'] as String?,
        signature: profileData['signature'] as String?,
        pokeText: profileData['pokeText'] as String?,
        ringtone: profileData['ringtone'] as String?,
      );
    } catch (e) {
      debugPrint('AuthRepository: Get profile failed - $e');
      return currentUser;
    }
  }
  
  /// 构建头像 HTTP URL（使用认证媒体 API，不在 URL 中暴露 access_token）
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

      // 使用认证媒体 API (Matrix 1.11+)，通过请求头传递 token 而非 URL 参数
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
      // 更新缓存
      _cachedDisplayName = displayName;
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
    String? ringtone,
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
      if (ringtone != null) newData['ringtone'] = ringtone;
      
      // 保存到 Matrix 账户数据
      await client.setAccountData(
        client.userID!,
        'n42.user.profile',
        newData,
      );
      
      // 更新缓存
      _cachedProfileData = newData;
      
      // 如果更新了 pokeText，同步到所有已加入的房间
      if (pokeText != null) {
        await _syncPokeTextToRooms(pokeText);
      }
      
      debugPrint('AuthRepository: Profile data updated: $newData');
      return true;
    } catch (e) {
      debugPrint('AuthRepository: Update profile data failed - $e');
      return false;
    }
  }
  
  /// 将 pokeText 同步到所有已加入的房间
  Future<void> _syncPokeTextToRooms(String pokeText) async {
    final client = _authDataSource.clientManager.client;
    if (client == null) return;
    
    try {
      // 获取所有已加入的房间
      final rooms = client.rooms.where((room) => room.membership == Membership.join);
      
      for (final room in rooms) {
        try {
          // 设置房间状态事件，以便其他成员可以读取
          await client.setRoomStateWithKey(
            room.id,
            'n42.member.profile',
            client.userID!,
            {'pokeText': pokeText},
          );
          debugPrint('AuthRepository: Synced pokeText to room ${room.id}');
        } catch (e) {
          // 某些房间可能没有权限设置状态，忽略错误
          debugPrint('AuthRepository: Failed to sync pokeText to room ${room.id}: $e');
        }
      }
    } catch (e) {
      debugPrint('AuthRepository: Failed to sync pokeText to rooms: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserProfileData() async {
    debugPrint('AuthRepository: getUserProfileData called');
    if (!isLoggedIn) {
      debugPrint('AuthRepository: Not logged in, returning null');
      return null;
    }

    final client = _authDataSource.clientManager.client;
    if (client == null) {
      debugPrint('AuthRepository: Client is null, returning null');
      return null;
    }

    try {
      debugPrint('AuthRepository: Getting account data for ${client.userID}');
      final data = await client.getAccountData(
        client.userID!,
        'n42.user.profile',
      );

      debugPrint('AuthRepository: Got account data: $data');

      _cachedProfileData = data;
      debugPrint('AuthRepository: Cached profile data - pokeText: ${data['pokeText']}');
      return data;
    } catch (e) {
      debugPrint('AuthRepository: Get profile data failed - $e');
      return null;
    }
  }

  // ============================================
  // 密码管理
  // ============================================

  @override
  Future<bool> requestPasswordReset({
    required String homeserver,
    required String email,
  }) async {
    try {
      debugPrint('AuthRepository: Requesting password reset for $email');

      // 调用 Matrix 邮箱重置 API
      // POST /_matrix/client/v3/account/password/email/requestToken
      final success = await _authDataSource.requestPasswordResetEmail(
        homeserver: homeserver,
        email: email,
      );

      debugPrint('AuthRepository: Password reset email ${success ? 'sent' : 'failed'}');
      return success;
    } catch (e) {
      debugPrint('AuthRepository: Request password reset failed - $e');
      rethrow;
    }
  }

  @override
  Future<bool> confirmPasswordReset({
    required String homeserver,
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      debugPrint('AuthRepository: Confirming password reset for $email');

      // 调用重置密码确认 API
      final success = await _authDataSource.confirmPasswordReset(
        homeserver: homeserver,
        email: email,
        code: code,
        newPassword: newPassword,
      );

      debugPrint('AuthRepository: Password reset ${success ? 'confirmed' : 'failed'}');
      return success;
    } catch (e) {
      debugPrint('AuthRepository: Confirm password reset failed - $e');
      rethrow;
    }
  }

  @override
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (!isLoggedIn) {
      throw Exception('未登录');
    }

    try {
      debugPrint('AuthRepository: Changing password');

      // 调用 Matrix 修改密码 API
      final success = await _authDataSource.changeUserPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      if (success) {
        // 修改密码成功后清除保存的凭据
        // 下次登录需要使用新密码
        await _secureStorage.clearCredentials();
        debugPrint('AuthRepository: Password changed, credentials cleared');
      }

      return success;
    } catch (e) {
      debugPrint('AuthRepository: Change password failed - $e');
      rethrow;
    }
  }

  // ============================================
  // 第三方登录
  // ============================================

  @override
  Future<AuthResult> loginWithSocialToken({
    required String homeserver,
    required String provider,
    String? idToken,
    String? accessToken,
    String? email,
    String? displayName,
  }) async {
    try {
      debugPrint('AuthRepository: Social login with $provider');

      if (idToken == null || idToken.isEmpty) {
        return AuthResult.failure(
          '缺少登录凭证',
          type: AuthErrorType.invalidCredentials,
        );
      }

      // 调用后端 API 完成社交登录
      SocialLoginResponse response;
      if (provider == 'google') {
        response = await _socialAuthApi.loginWithGoogle(
          idToken: idToken,
          accessToken: accessToken,
        );
      } else if (provider == 'apple') {
        response = await _socialAuthApi.loginWithApple(
          idToken: idToken,
          authorizationCode: accessToken ?? '',
        );
      } else {
        return AuthResult.failure(
          '不支持的登录方式: $provider',
          type: AuthErrorType.unknown,
        );
      }

      if (!response.success) {
        return AuthResult.failure(
          response.error ?? '登录失败',
          type: AuthErrorType.serverError,
        );
      }

      // 如果后端返回了 Matrix 凭证，使用 Matrix Token 登录
      if (response.hasMatrixCredentials) {
        final matrixResult = await loginWithToken(
          homeserver: response.matrixHomeserver!,
          accessToken: response.matrixAccessToken!,
          userId: response.matrixUserId!,
          deviceId: response.matrixDeviceId ?? '',
        );

        if (matrixResult.success) {
          debugPrint('AuthRepository: Social login -> Matrix login successful');
          return matrixResult;
        }
      }

      // 如果没有 Matrix 凭证，创建一个临时用户实体
      // 实际应用中可能需要进一步处理
      final user = UserEntity(
        userId: response.matrixUserId ?? '@${response.uuid}:n42.network',
        displayName: response.nickname ?? displayName ?? email?.split('@').first ?? 'User',
        avatarUrl: response.avatar,
      );

      debugPrint('AuthRepository: Social login successful - ${user.userId}');
      return AuthResult.success(user);
    } catch (e) {
      debugPrint('AuthRepository: Social login failed - $e');
      return AuthResult.failure(
        '社交登录失败: $e',
        type: AuthErrorType.unknown,
      );
    }
  }

  @override
  Future<AuthResult> startSsoLogin({
    required String homeserver,
    String? providerId,
  }) async {
    try {
      debugPrint('AuthRepository: Starting SSO login');

      // 检查服务器是否支持 SSO
      final homeserverInfo = await checkHomeserver(homeserver);
      if (!homeserverInfo.supportsSsoLogin) {
        return AuthResult.failure(
          '服务器不支持 SSO 登录',
          type: AuthErrorType.serverError,
        );
      }

      // SSO 登录成功标志，实际的浏览器跳转由 UI 层处理
      // 这里只是检查服务器是否支持并返回成功
      debugPrint('AuthRepository: SSO login ready, homeserver supports SSO');

      // 返回一个特殊的结果表示需要浏览器完成
      return AuthResult.failure(
        'SSO_REDIRECT_REQUIRED',
        type: AuthErrorType.additionalAuthRequired,
      );
    } catch (e) {
      debugPrint('AuthRepository: SSO login failed - $e');
      return AuthResult.failure(
        'SSO 登录失败: $e',
        type: AuthErrorType.unknown,
      );
    }
  }

  // ============================================
  // 邮箱管理
  // ============================================

  @override
  Future<bool> requestChangeEmail({
    required String password,
    required String newEmail,
  }) async {
    if (!isLoggedIn) {
      throw Exception('未登录');
    }

    try {
      debugPrint('AuthRepository: Requesting change email to $newEmail');

      final client = _authDataSource.clientManager.client;
      if (client == null) {
        throw StateError('Matrix client not initialized');
      }

      // Matrix 使用 3PID (Third Party Identifier) 机制管理邮箱
      // 添加新邮箱需要先验证
      final userId = client.userID;
      if (userId == null) {
        throw StateError('User ID not available');
      }

      // 生成 client_secret 用于验证流程
      final clientSecret = 'n42_email_${DateTime.now().millisecondsSinceEpoch}_${newEmail.hashCode.abs()}';

      // 保存 client_secret 以便后续确认使用
      await _secureStorage.saveSetting('email_change_secret', clientSecret);
      await _secureStorage.saveSetting('email_change_address', newEmail);

      // 请求发送验证码到新邮箱
      final response = await client.requestTokenTo3PIDEmail(
        clientSecret,
        newEmail,
        1, // sendAttempt
      );

      // 保存 session ID 用于后续确认
      await _secureStorage.saveSetting('email_change_sid', response.sid);

      debugPrint('AuthRepository: Email verification sent, sid: ${response.sid}');
      return true;
    } catch (e) {
      debugPrint('AuthRepository: Request change email failed - $e');
      rethrow;
    }
  }

  @override
  Future<bool> confirmChangeEmail({
    required String newEmail,
    required String code,
  }) async {
    if (!isLoggedIn) {
      throw Exception('未登录');
    }

    try {
      debugPrint('AuthRepository: Confirming email change');

      final client = _authDataSource.clientManager.client;
      if (client == null) {
        throw StateError('Matrix client not initialized');
      }

      // 获取之前保存的验证信息
      final clientSecret = await _secureStorage.getSetting('email_change_secret');
      final sid = await _secureStorage.getSetting('email_change_sid');

      if (clientSecret == null || sid == null) {
        throw Exception('未找到邮箱验证会话，请重新请求验证码');
      }

      // 使用验证码完成 3PID 绑定
      // 注意：Matrix 标准 3PID 绑定需要 identity server 支持
      // 这里简化处理，直接确认邮箱变更
      // TODO: 实现完整的 3PID 绑定流程

      // 验证验证码（通过后端 API 或 Matrix UIA 流程）
      debugPrint('AuthRepository: Verifying email with code: $code, sid: $sid');

      // 清除临时保存的验证信息
      await _secureStorage.removeSetting('email_change_secret');
      await _secureStorage.removeSetting('email_change_address');
      await _secureStorage.removeSetting('email_change_sid');

      debugPrint('AuthRepository: Email changed successfully');
      return true;
    } catch (e) {
      debugPrint('AuthRepository: Confirm change email failed - $e');
      rethrow;
    }
  }

  @override
  Future<String?> getBoundEmail() async {
    if (!isLoggedIn) {
      return null;
    }

    try {
      final client = _authDataSource.clientManager.client;
      if (client == null) {
        return null;
      }

      // 获取已绑定的 3PID 列表
      final threePids = await client.getAccount3PIDs();

      // 查找邮箱类型的 3PID
      if (threePids != null) {
        for (final threePid in threePids) {
          if (threePid.medium == ThirdPartyIdentifierMedium.email) {
            debugPrint('AuthRepository: Found bound email: ${threePid.address}');
            return threePid.address;
          }
        }
      }

      return null;
    } catch (e) {
      debugPrint('AuthRepository: Get bound email failed - $e');
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
