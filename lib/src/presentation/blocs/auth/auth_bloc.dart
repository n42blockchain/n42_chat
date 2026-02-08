import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/biometric_service.dart';
import '../../../data/datasources/local/secure_storage_datasource.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../n42_chat.dart' show N42Chat;
import '../../../services/auth/auth_methods_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// 认证BLoC
///
/// 管理用户认证状态
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  final BiometricService _biometricService;
  final SecureStorageDataSource _secureStorage;
  StreamSubscription<bool>? _loginStateSubscription;

  AuthBloc({
    required IAuthRepository authRepository,
    BiometricService? biometricService,
    SecureStorageDataSource? secureStorage,
  })  : _authRepository = authRepository,
        _biometricService = biometricService ?? BiometricService(),
        _secureStorage = secureStorage ?? SecureStorageDataSource(),
        super(const AuthState.initial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthHomeserverCheckRequested>(_onHomeserverCheckRequested);
    on<AuthRestoreSessionRequested>(_onRestoreSessionRequested);
    on<UpdateAvatar>(_onUpdateAvatar);
    on<UpdateDisplayName>(_onUpdateDisplayName);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<LoadUserProfileData>(_onLoadUserProfileData);
    on<AuthRequestPasswordResetRequested>(_onRequestPasswordReset);
    on<AuthConfirmPasswordResetRequested>(_onConfirmPasswordReset);
    on<AuthChangePasswordRequested>(_onChangePassword);
    on<AuthGoogleLoginRequested>(_onGoogleLogin);
    on<AuthAppleLoginRequested>(_onAppleLogin);
    on<AuthSsoLoginRequested>(_onSsoLogin);
    on<AuthFacebookLoginRequested>(_onFacebookLogin);
    on<AuthTwitterLoginRequested>(_onTwitterLogin);
    on<AuthWeChatLoginRequested>(_onWeChatLogin);
    on<AuthRequestChangeEmailRequested>(_onRequestChangeEmail);
    on<AuthConfirmChangeEmailRequested>(_onConfirmChangeEmail);
    on<AuthGetBoundEmailRequested>(_onGetBoundEmail);
    on<AuthBiometricLoginRequested>(_onBiometricLogin);
    on<AuthCheckBiometricAvailability>(_onCheckBiometricAvailability);
    on<AuthEnableBiometricLogin>(_onEnableBiometricLogin);
    on<AuthDisableBiometricLogin>(_onDisableBiometricLogin);

    // 监听登录状态变化
    _loginStateSubscription = _authRepository.loginStateStream.listen(
      (isLoggedIn) {
        if (!isLoggedIn && state.status == AuthStatus.authenticated) {
          add(const AuthLogoutRequested());
        }
      },
    );
  }

  /// 检查当前认证状态
  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.checking));

    if (_authRepository.isLoggedIn) {
      final user = _authRepository.currentUser;
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
      // 已登录状态，注册推送通知并初始化通话管理器
      await _registerPushNotifications();
      await _initializeCallManager();
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  /// 登录
  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    ));

    final result = await _authRepository.login(
      homeserver: event.homeserver,
      username: event.username,
      password: event.password,
      rememberMe: event.rememberMe,
    );

    if (result.success && result.user != null) {
      // 保存登录凭据（用于生物识别登录）
      debugPrint('AuthBloc: Saving credentials for biometric login...');
      final credentialsSaved = await _secureStorage.saveCredentials(
        homeserver: event.homeserver,
        username: event.username,
        password: event.password,
      );
      if (credentialsSaved) {
        debugPrint('AuthBloc: Credentials saved and verified successfully');
      } else {
        debugPrint('AuthBloc: WARNING - Credentials save verification failed!');
      }

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: result.user,
      ));
      // 通知主应用用户信息变化
      N42Chat.notifyUserChanged();
      // 登录成功后自动加载完整用户资料（包括 pokeText 等自定义字段）
      add(const LoadUserProfileData());
      // 登录成功后注册推送通知和初始化通话管理器
      await _registerPushNotifications();
      await _initializeCallManager();
    } else {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.errorMessage ?? 'Login failed',
        errorType: result.errorType,
      ));
    }
  }

  /// 登出
  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    // 登出前取消推送注册
    await _unregisterPushNotifications();

    await _authRepository.logout();

    emit(const AuthState.initial().copyWith(
      status: AuthStatus.unauthenticated,
    ));
  }

  /// 注册
  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    ));

    final result = await _authRepository.register(
      homeserver: event.homeserver,
      username: event.username,
      password: event.password,
      email: event.email,
      registrationToken: event.registrationToken,
    );

    if (result.success && result.user != null) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: result.user,
      ));
      // 注册成功后自动加载完整用户资料
      add(const LoadUserProfileData());
      // 注册成功后注册推送通知和初始化通话管理器
      await _registerPushNotifications();
      await _initializeCallManager();
    } else {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.errorMessage ?? 'Registration failed',
        errorType: result.errorType,
      ));
    }
  }

  /// 注册推送通知
  Future<void> _registerPushNotifications() async {
    try {
      await N42Chat.registerPushNotifications();
      debugPrint('AuthBloc: Push notifications registered');
    } catch (e) {
      debugPrint('AuthBloc: Failed to register push notifications: $e');
    }
  }

  /// 初始化通话管理器（登录成功后调用）
  Future<void> _initializeCallManager() async {
    try {
      await N42Chat.initializeCallManager();
      debugPrint('AuthBloc: Call manager initialized');
    } catch (e) {
      debugPrint('AuthBloc: Failed to initialize call manager: $e');
    }
  }

  /// 取消注册推送通知
  Future<void> _unregisterPushNotifications() async {
    try {
      await N42Chat.unregisterPushNotifications();
      debugPrint('AuthBloc: Push notifications unregistered');
    } catch (e) {
      debugPrint('AuthBloc: Failed to unregister push notifications: $e');
    }
  }

  /// 检查Homeserver
  Future<void> _onHomeserverCheckRequested(
    AuthHomeserverCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      homeserverStatus: HomeserverStatus.checking,
      homeserverInfo: null,
    ));

    try {
      final info = await _authRepository.checkHomeserver(event.homeserver);
      emit(state.copyWith(
        homeserverStatus: HomeserverStatus.valid,
        homeserverInfo: info,
        lastCheckedHomeserver: event.homeserver,
      ));
    } catch (e) {
      emit(state.copyWith(
        homeserverStatus: HomeserverStatus.invalid,
        errorMessage: e.toString(),
      ));
    }
  }

  /// 恢复会话
  Future<void> _onRestoreSessionRequested(
    AuthRestoreSessionRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.checking));

    final result = await _authRepository.restoreSession();

    if (result.success && result.user != null) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: result.user,
      ));
      // 恢复会话成功后自动加载完整用户资料（包括 pokeText 等自定义字段）
      add(const LoadUserProfileData());
      // 恢复会话成功后注册推送通知并初始化通话管理器
      await _registerPushNotifications();
      await _initializeCallManager();
    } else {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
      ));
    }
  }

  /// 更新头像
  Future<void> _onUpdateAvatar(
    UpdateAvatar event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      
      final success = await _authRepository.updateAvatar(
        event.avatarBytes,
        event.filename,
      );
      
      if (success) {
        // 刷新用户信息
        final user = _authRepository.currentUser;
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Avatar upload failed',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Avatar upload failed: $e',
      ));
    }
  }

  /// 更新显示名
  Future<void> _onUpdateDisplayName(
    UpdateDisplayName event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      
      final success = await _authRepository.updateDisplayName(event.displayName);
      
      if (success) {
        // 刷新用户信息
        final user = _authRepository.currentUser;
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Update nickname failed',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Update nickname failed: $e',
      ));
    }
  }

  /// 更新用户资料
  Future<void> _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      
      // 更新显示名（如果有）
      if (event.displayName != null) {
        await _authRepository.updateDisplayName(event.displayName!);
      }
      
      // 更新自定义资料数据（性别、地区、签名、拍一拍、来电铃声）
      final hasProfileChanges = event.gender != null || 
                                 event.region != null || 
                                 event.signature != null ||
                                 event.pokeText != null ||
                                 event.ringtone != null;
      
      if (hasProfileChanges) {
        await _authRepository.updateUserProfileData(
          gender: event.gender,
          region: event.region,
          signature: event.signature,
          pokeText: event.pokeText,
          ringtone: event.ringtone,
        );
      }
      
      // 重新加载用户资料以获取最新数据
      await _authRepository.getUserProfileData();
      
      // 刷新用户信息
      final user = _authRepository.currentUser;
      debugPrint('AuthBloc: Updated user profile - pokeText: ${user?.pokeText}, ringtone: ${user?.ringtone}');
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Update profile failed: $e',
      ));
    }
  }
  
  /// 加载用户资料数据
  Future<void> _onLoadUserProfileData(
    LoadUserProfileData event,
    Emitter<AuthState> emit,
  ) async {
    try {
      debugPrint('AuthBloc: Loading user profile data...');
      
      // 获取最新的用户资料（包含头像和显示名）
      final user = await _authRepository.getCurrentUserProfile();
      
      if (user != null) {
        debugPrint('AuthBloc: User profile loaded - displayName: ${user.displayName}, avatarUrl: ${user.avatarUrl}');
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        ));
        // 通知主应用用户信息变化（头像/昵称更新）
        N42Chat.notifyUserChanged();
      } else {
        debugPrint('AuthBloc: Failed to load user profile, user is null');
      }
    } catch (e) {
      // 加载失败不影响整体状态
      debugPrint('AuthBloc: Load profile data failed - $e');
    }
  }

  // ============================================
  // 密码管理
  // ============================================

  /// 请求重置密码验证码
  Future<void> _onRequestPasswordReset(
    AuthRequestPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      passwordResetStatus: PasswordResetStatus.sendingCode,
      errorMessage: null,
    ));

    try {
      final success = await _authRepository.requestPasswordReset(
        homeserver: event.homeserver,
        email: event.email,
      );

      if (success) {
        emit(state.copyWith(
          passwordResetStatus: PasswordResetStatus.codeSent,
        ));
      } else {
        emit(state.copyWith(
          passwordResetStatus: PasswordResetStatus.failed,
          errorMessage: '发送验证码失败',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        passwordResetStatus: PasswordResetStatus.failed,
        errorMessage: '发送验证码失败: $e',
      ));
    }
  }

  /// 确认重置密码
  Future<void> _onConfirmPasswordReset(
    AuthConfirmPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      passwordResetStatus: PasswordResetStatus.resetting,
      errorMessage: null,
    ));

    try {
      final success = await _authRepository.confirmPasswordReset(
        homeserver: event.homeserver,
        email: event.email,
        code: event.code,
        newPassword: event.newPassword,
      );

      if (success) {
        emit(state.copyWith(
          passwordResetStatus: PasswordResetStatus.success,
        ));
      } else {
        emit(state.copyWith(
          passwordResetStatus: PasswordResetStatus.failed,
          errorMessage: '重置密码失败',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        passwordResetStatus: PasswordResetStatus.failed,
        errorMessage: '重置密码失败: $e',
      ));
    }
  }

  /// 修改密码
  Future<void> _onChangePassword(
    AuthChangePasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      changePasswordStatus: ChangePasswordStatus.changing,
      errorMessage: null,
    ));

    try {
      final success = await _authRepository.changePassword(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      );

      if (success) {
        emit(state.copyWith(
          changePasswordStatus: ChangePasswordStatus.success,
        ));
        // 修改密码成功后自动登出
        add(const AuthLogoutRequested());
      } else {
        emit(state.copyWith(
          changePasswordStatus: ChangePasswordStatus.failed,
          errorMessage: '修改密码失败',
        ));
      }
    } catch (e) {
      String errorMessage = '修改密码失败';
      if (e.toString().contains('M_FORBIDDEN') ||
          e.toString().contains('M_UNAUTHORIZED')) {
        errorMessage = '原密码错误';
      }
      emit(state.copyWith(
        changePasswordStatus: ChangePasswordStatus.failed,
        errorMessage: errorMessage,
      ));
    }
  }

  // ============================================
  // 第三方登录
  // ============================================

  /// Google 登录
  Future<void> _onGoogleLogin(
    AuthGoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    ));

    try {
      final authService = AuthMethodsService();
      final googleResult = await authService.signInWithGoogle();

      if (googleResult == null) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: '登录已取消',
        ));
        return;
      }

      // 尝试使用 Google token 进行 Matrix SSO 登录
      final result = await _authRepository.loginWithSocialToken(
        homeserver: event.homeserver,
        provider: 'google',
        idToken: googleResult.idToken,
        accessToken: googleResult.accessToken,
        email: googleResult.email,
        displayName: googleResult.displayName,
      );

      if (result.success && result.user != null) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: result.user,
        ));
        add(const LoadUserProfileData());
        // Google 登录成功后注册推送通知
        _registerPushNotifications();
        // Google 登录成功后初始化通话管理器
        _initializeCallManager();
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: result.errorMessage ?? 'Google 登录失败',
          errorType: result.errorType,
        ));
      }
    } catch (e) {
      debugPrint('AuthBloc: Google login failed - $e');
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Google 登录失败: $e',
      ));
    }
  }

  /// Apple 登录
  Future<void> _onAppleLogin(
    AuthAppleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    ));

    try {
      final authService = AuthMethodsService();
      final appleResult = await authService.signInWithApple();

      if (appleResult == null) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: '登录已取消',
        ));
        return;
      }

      // 尝试使用 Apple token 进行 Matrix SSO 登录
      final result = await _authRepository.loginWithSocialToken(
        homeserver: event.homeserver,
        provider: 'apple',
        idToken: appleResult.idToken,
        accessToken: appleResult.accessToken,
        email: appleResult.email,
        displayName: appleResult.displayName,
      );

      if (result.success && result.user != null) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: result.user,
        ));
        add(const LoadUserProfileData());
        // Apple 登录成功后注册推送通知
        _registerPushNotifications();
        // Apple 登录成功后初始化通话管理器
        _initializeCallManager();
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: result.errorMessage ?? 'Apple 登录失败',
          errorType: result.errorType,
        ));
      }
    } catch (e) {
      debugPrint('AuthBloc: Apple login failed - $e');
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Apple 登录失败: $e',
      ));
    }
  }

  /// SSO 登录
  Future<void> _onSsoLogin(
    AuthSsoLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    ));

    try {
      // 获取 SSO 登录 URL 并启动浏览器
      final result = await _authRepository.startSsoLogin(
        homeserver: event.homeserver,
        providerId: event.providerId,
      );

      if (result.success) {
        // SSO 登录需要在浏览器中完成，状态会在回调中更新
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: result.errorMessage ?? 'SSO 登录失败',
          errorType: result.errorType,
        ));
      }
    } catch (e) {
      debugPrint('AuthBloc: SSO login failed - $e');
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'SSO 登录失败: $e',
      ));
    }
  }

  /// Facebook 登录
  Future<void> _onFacebookLogin(
    AuthFacebookLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    ));

    try {
      final authService = AuthMethodsService();
      final facebookResult = await authService.signInWithFacebook();

      if (facebookResult == null) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: '登录已取消',
        ));
        return;
      }

      // 使用 Facebook token 进行登录
      final result = await _authRepository.loginWithSocialToken(
        homeserver: event.homeserver,
        provider: 'facebook',
        idToken: facebookResult.accessToken,
        accessToken: facebookResult.accessToken,
        email: facebookResult.email,
        displayName: facebookResult.displayName,
      );

      if (result.success && result.user != null) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: result.user,
        ));
        add(const LoadUserProfileData());
        // Facebook 登录成功后注册推送通知
        _registerPushNotifications();
        // Facebook 登录成功后初始化通话管理器
        _initializeCallManager();
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: result.errorMessage ?? 'Facebook 登录失败',
          errorType: result.errorType,
        ));
      }
    } catch (e) {
      debugPrint('AuthBloc: Facebook login failed - $e');
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Facebook 登录失败',
      ));
    }
  }

  /// Twitter 登录
  Future<void> _onTwitterLogin(
    AuthTwitterLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    ));

    try {
      final authService = AuthMethodsService();
      final twitterResult = await authService.signInWithTwitter();

      if (twitterResult == null) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: '登录已取消',
        ));
        return;
      }

      // 使用 Twitter token 进行登录
      final result = await _authRepository.loginWithSocialToken(
        homeserver: event.homeserver,
        provider: 'twitter',
        idToken: twitterResult.accessToken,
        accessToken: twitterResult.extra?['authTokenSecret'] as String?,
        email: twitterResult.email,
        displayName: twitterResult.displayName,
      );

      if (result.success && result.user != null) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: result.user,
        ));
        add(const LoadUserProfileData());
        // Twitter 登录成功后注册推送通知
        _registerPushNotifications();
        // Twitter 登录成功后初始化通话管理器
        _initializeCallManager();
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: result.errorMessage ?? 'Twitter 登录失败',
          errorType: result.errorType,
        ));
      }
    } catch (e) {
      debugPrint('AuthBloc: Twitter login failed - $e');
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Twitter 登录失败',
      ));
    }
  }

  /// 微信登录
  Future<void> _onWeChatLogin(
    AuthWeChatLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    ));

    try {
      final authService = AuthMethodsService();
      final weChatResult = await authService.signInWithWeChat();

      if (weChatResult == null) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: '登录已取消',
        ));
        return;
      }

      // 使用微信授权码进行登录
      final result = await _authRepository.loginWithSocialToken(
        homeserver: event.homeserver,
        provider: 'wechat',
        idToken: weChatResult.accessToken,  // 这是授权码
        accessToken: null,
        email: null,
        displayName: null,
      );

      if (result.success && result.user != null) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: result.user,
        ));
        add(const LoadUserProfileData());
        // 微信登录成功后注册推送通知
        _registerPushNotifications();
        // 微信登录成功后初始化通话管理器
        _initializeCallManager();
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: result.errorMessage ?? '微信登录失败',
          errorType: result.errorType,
        ));
      }
    } catch (e) {
      debugPrint('AuthBloc: WeChat login failed - $e');
      // 对于微信特定错误提供更友好的提示
      String errorMsg = '微信登录失败';
      if (e.toString().contains('未初始化')) {
        errorMsg = '微信登录未配置';
      } else if (e.toString().contains('安装微信')) {
        errorMsg = '请先安装微信';
      }
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: errorMsg,
      ));
    }
  }

  // ============================================
  // 邮箱管理
  // ============================================

  /// 请求修改邮箱
  Future<void> _onRequestChangeEmail(
    AuthRequestChangeEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      changeEmailStatus: ChangeEmailStatus.sendingCode,
      errorMessage: null,
    ));

    try {
      final success = await _authRepository.requestChangeEmail(
        password: event.password,
        newEmail: event.newEmail,
      );

      if (success) {
        emit(state.copyWith(
          changeEmailStatus: ChangeEmailStatus.codeSent,
        ));
      } else {
        emit(state.copyWith(
          changeEmailStatus: ChangeEmailStatus.failed,
          errorMessage: '发送验证码失败',
        ));
      }
    } catch (e) {
      String errorMessage = '发送验证码失败';
      if (e.toString().contains('M_FORBIDDEN') ||
          e.toString().contains('M_UNAUTHORIZED')) {
        errorMessage = '密码错误';
      } else if (e.toString().contains('M_THREEPID_IN_USE')) {
        errorMessage = '该邮箱已被其他账号绑定';
      }
      emit(state.copyWith(
        changeEmailStatus: ChangeEmailStatus.failed,
        errorMessage: errorMessage,
      ));
    }
  }

  /// 确认修改邮箱
  Future<void> _onConfirmChangeEmail(
    AuthConfirmChangeEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      changeEmailStatus: ChangeEmailStatus.confirming,
      errorMessage: null,
    ));

    try {
      final success = await _authRepository.confirmChangeEmail(
        newEmail: event.newEmail,
        code: event.code,
      );

      if (success) {
        emit(state.copyWith(
          changeEmailStatus: ChangeEmailStatus.success,
          boundEmail: event.newEmail,
        ));
      } else {
        emit(state.copyWith(
          changeEmailStatus: ChangeEmailStatus.failed,
          errorMessage: '修改邮箱失败',
        ));
      }
    } catch (e) {
      String errorMessage = '修改邮箱失败';
      if (e.toString().contains('M_THREEPID_AUTH_FAILED')) {
        errorMessage = '验证码错误或已过期';
      }
      emit(state.copyWith(
        changeEmailStatus: ChangeEmailStatus.failed,
        errorMessage: errorMessage,
      ));
    }
  }

  /// 获取绑定邮箱
  Future<void> _onGetBoundEmail(
    AuthGetBoundEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final email = await _authRepository.getBoundEmail();
      emit(state.copyWith(
        boundEmail: email,
      ));
    } catch (e) {
      debugPrint('AuthBloc: Get bound email failed - $e');
    }
  }

  // ============================================
  // 生物识别登录
  // ============================================

  /// 检查生物识别可用性
  Future<void> _onCheckBiometricAvailability(
    AuthCheckBiometricAvailability event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final isAvailable = await _biometricService.isAvailable();
      final isEnabled = await _secureStorage.isBiometricEnabled();
      final typeDescription = isAvailable
          ? await _biometricService.getBiometricTypeDescription()
          : null;

      emit(state.copyWith(
        isBiometricAvailable: isAvailable,
        isBiometricEnabled: isEnabled,
        biometricTypeDescription: typeDescription,
      ));

      debugPrint('AuthBloc: Biometric availability - available: $isAvailable, enabled: $isEnabled, type: $typeDescription');
    } catch (e) {
      debugPrint('AuthBloc: Check biometric availability failed - $e');
    }
  }

  /// 生物识别登录
  Future<void> _onBiometricLogin(
    AuthBiometricLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    ));

    try {
      // 检查生物识别是否可用
      final isAvailable = await _biometricService.isAvailable();
      if (!isAvailable) {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Biometric authentication not available',
        ));
        return;
      }

      // 检查是否已启用生物识别
      final isEnabled = await _secureStorage.isBiometricEnabled();
      if (!isEnabled) {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Biometric login not enabled',
        ));
        return;
      }

      // 获取保存的凭据
      final credentials = await _secureStorage.getCredentials();
      if (credentials == null) {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'No saved credentials found',
        ));
        return;
      }

      // 执行生物识别认证
      final biometricResult = await _biometricService.authenticate(
        reason: 'Authenticate to login',
      );

      if (!biometricResult.success) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: biometricResult.errorMessage,
        ));
        return;
      }

      // 生物识别成功，使用保存的凭据登录
      final homeserver = credentials['homeserver']!;
      final username = credentials['username']!;
      final password = credentials['password']!;

      final result = await _authRepository.login(
        homeserver: homeserver,
        username: username,
        password: password,
        rememberMe: true,
      );

      if (result.success && result.user != null) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: result.user,
        ));
        // 登录成功后自动加载完整用户资料
        add(const LoadUserProfileData());
        // 登录成功后注册推送通知
        _registerPushNotifications();
        // 登录成功后初始化通话管理器
        _initializeCallManager();
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: result.errorMessage ?? 'Login failed',
          errorType: result.errorType,
        ));
      }
    } catch (e) {
      debugPrint('AuthBloc: Biometric login failed - $e');
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Biometric login failed: $e',
      ));
    }
  }

  /// 启用生物识别登录
  Future<void> _onEnableBiometricLogin(
    AuthEnableBiometricLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // 检查生物识别是否可用
      final isAvailable = await _biometricService.isAvailable();
      if (!isAvailable) {
        emit(state.copyWith(
          errorMessage: 'Biometric authentication not available on this device',
        ));
        return;
      }

      // 获取当前保存的凭据
      final credentials = await _secureStorage.getCredentials();
      if (credentials == null) {
        emit(state.copyWith(
          errorMessage: 'Please login first to enable biometric login',
        ));
        return;
      }

      // 执行生物识别验证
      final result = await _biometricService.authenticate(
        reason: 'Authenticate to enable biometric login',
      );

      if (result.success) {
        // 启用生物识别
        await _secureStorage.enableBiometricLogin(
          homeserver: credentials['homeserver']!,
          username: credentials['username']!,
        );

        emit(state.copyWith(
          isBiometricEnabled: true,
        ));

        debugPrint('AuthBloc: Biometric login enabled');
      } else {
        emit(state.copyWith(
          errorMessage: result.errorMessage ?? 'Biometric authentication failed',
        ));
      }
    } catch (e) {
      debugPrint('AuthBloc: Enable biometric login failed - $e');
      emit(state.copyWith(
        errorMessage: 'Failed to enable biometric login: $e',
      ));
    }
  }

  /// 禁用生物识别登录
  Future<void> _onDisableBiometricLogin(
    AuthDisableBiometricLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _secureStorage.disableBiometricLogin();

      emit(state.copyWith(
        isBiometricEnabled: false,
      ));

      debugPrint('AuthBloc: Biometric login disabled');
    } catch (e) {
      debugPrint('AuthBloc: Disable biometric login failed - $e');
      emit(state.copyWith(
        errorMessage: 'Failed to disable biometric login: $e',
      ));
    }
  }

  @override
  Future<void> close() {
    _loginStateSubscription?.cancel();
    return super.close();
  }
}

