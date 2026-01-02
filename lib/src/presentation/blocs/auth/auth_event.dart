import 'package:equatable/equatable.dart';

/// 认证事件基类
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// 检查认证状态
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// 登录请求
class AuthLoginRequested extends AuthEvent {
  final String homeserver;
  final String username;
  final String password;
  final bool rememberMe;

  const AuthLoginRequested({
    required this.homeserver,
    required this.username,
    required this.password,
    this.rememberMe = true,
  });

  @override
  List<Object?> get props => [homeserver, username, password, rememberMe];
}

/// 登出请求
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

/// 注册请求
class AuthRegisterRequested extends AuthEvent {
  final String homeserver;
  final String username;
  final String password;
  final String? email;
  final String? registrationToken;

  const AuthRegisterRequested({
    required this.homeserver,
    required this.username,
    required this.password,
    this.email,
    this.registrationToken,
  });

  @override
  List<Object?> get props => [homeserver, username, password, email, registrationToken];
}

/// 检查Homeserver
class AuthHomeserverCheckRequested extends AuthEvent {
  final String homeserver;

  const AuthHomeserverCheckRequested(this.homeserver);

  @override
  List<Object?> get props => [homeserver];
}

/// 恢复会话请求
class AuthRestoreSessionRequested extends AuthEvent {
  const AuthRestoreSessionRequested();
}

/// Token登录请求
class AuthTokenLoginRequested extends AuthEvent {
  final String homeserver;
  final String accessToken;
  final String userId;
  final String deviceId;

  const AuthTokenLoginRequested({
    required this.homeserver,
    required this.accessToken,
    required this.userId,
    required this.deviceId,
  });

  @override
  List<Object?> get props => [homeserver, accessToken, userId, deviceId];
}

/// 清除错误
class AuthErrorCleared extends AuthEvent {
  const AuthErrorCleared();
}

