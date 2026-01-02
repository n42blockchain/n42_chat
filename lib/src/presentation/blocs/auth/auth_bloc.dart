import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// 认证BLoC
///
/// 管理用户认证状态
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  StreamSubscription<bool>? _loginStateSubscription;

  AuthBloc({
    required IAuthRepository authRepository,
  })  : _authRepository = authRepository,
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
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: result.user,
      ));
    } else {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.errorMessage ?? '登录失败',
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
    } else {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.errorMessage ?? '注册失败',
        errorType: result.errorType,
      ));
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
          errorMessage: '头像上传失败',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: '头像上传失败: $e',
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
          errorMessage: '更新昵称失败',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: '更新昵称失败: $e',
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
      debugPrint('AuthBloc: Updated user profile - ringtone: ${user?.ringtone}');
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: '更新资料失败: $e',
      ));
    }
  }
  
  /// 加载用户资料数据
  Future<void> _onLoadUserProfileData(
    LoadUserProfileData event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // 先加载 Matrix 账户数据中的自定义资料
      await _authRepository.getUserProfileData();
      
      // 刷新用户信息
      final user = _authRepository.currentUser;
      if (user != null) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        ));
      }
    } catch (e) {
      // 加载失败不影响整体状态
      debugPrint('AuthBloc: Load profile data failed - $e');
    }
  }

  @override
  Future<void> close() {
    _loginStateSubscription?.cancel();
    return super.close();
  }
}

