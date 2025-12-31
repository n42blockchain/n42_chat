import 'dart:async';

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

  @override
  Future<void> close() {
    _loginStateSubscription?.cancel();
    return super.close();
  }
}

