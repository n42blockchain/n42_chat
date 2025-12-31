import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/auth_repository.dart';

/// 认证状态
enum AuthStatus {
  /// 初始状态
  initial,

  /// 检查中
  checking,

  /// 加载中
  loading,

  /// 已认证
  authenticated,

  /// 未认证
  unauthenticated,

  /// 错误
  error,
}

/// Homeserver检查状态
enum HomeserverStatus {
  /// 未检查
  unknown,

  /// 检查中
  checking,

  /// 有效
  valid,

  /// 无效
  invalid,
}

/// 认证状态
class AuthState extends Equatable {
  /// 认证状态
  final AuthStatus status;

  /// 当前用户
  final UserEntity? user;

  /// 错误消息
  final String? errorMessage;

  /// 错误类型
  final AuthErrorType? errorType;

  /// Homeserver检查状态
  final HomeserverStatus homeserverStatus;

  /// Homeserver信息
  final HomeserverInfo? homeserverInfo;

  /// 上次检查的Homeserver
  final String? lastCheckedHomeserver;

  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
    this.errorType,
    this.homeserverStatus = HomeserverStatus.unknown,
    this.homeserverInfo,
    this.lastCheckedHomeserver,
  });

  /// 初始状态
  const AuthState.initial()
      : status = AuthStatus.initial,
        user = null,
        errorMessage = null,
        errorType = null,
        homeserverStatus = HomeserverStatus.unknown,
        homeserverInfo = null,
        lastCheckedHomeserver = null;

  /// 是否正在加载
  bool get isLoading =>
      status == AuthStatus.loading || status == AuthStatus.checking;

  /// 是否已登录
  bool get isAuthenticated => status == AuthStatus.authenticated;

  /// 是否有错误
  bool get hasError => status == AuthStatus.error && errorMessage != null;

  /// Homeserver是否有效
  bool get isHomeserverValid => homeserverStatus == HomeserverStatus.valid;

  /// 是否正在检查Homeserver
  bool get isCheckingHomeserver => homeserverStatus == HomeserverStatus.checking;

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
    AuthErrorType? errorType,
    HomeserverStatus? homeserverStatus,
    HomeserverInfo? homeserverInfo,
    String? lastCheckedHomeserver,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
      errorType: errorType,
      homeserverStatus: homeserverStatus ?? this.homeserverStatus,
      homeserverInfo: homeserverInfo ?? this.homeserverInfo,
      lastCheckedHomeserver:
          lastCheckedHomeserver ?? this.lastCheckedHomeserver,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        errorMessage,
        errorType,
        homeserverStatus,
        homeserverInfo,
        lastCheckedHomeserver,
      ];

  @override
  String toString() => 'AuthState(status: $status, user: ${user?.userId})';
}

