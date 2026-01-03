import 'dart:typed_data';

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

/// 更新头像
class UpdateAvatar extends AuthEvent {
  final Uint8List avatarBytes;
  final String filename;

  const UpdateAvatar({
    required this.avatarBytes,
    required this.filename,
  });

  @override
  List<Object?> get props => [avatarBytes, filename];
}

/// 更新显示名
class UpdateDisplayName extends AuthEvent {
  final String displayName;

  const UpdateDisplayName(this.displayName);

  @override
  List<Object?> get props => [displayName];
}

/// 更新用户资料
class UpdateUserProfile extends AuthEvent {
  final String? displayName;
  final String? signature;
  final String? gender;
  final String? region;
  final String? pokeText;
  final String? ringtone;

  const UpdateUserProfile({
    this.displayName,
    this.signature,
    this.gender,
    this.region,
    this.pokeText,
    this.ringtone,
  });

  @override
  List<Object?> get props => [displayName, signature, gender, region, pokeText, ringtone];
}

/// 加载用户资料数据
class LoadUserProfileData extends AuthEvent {
  const LoadUserProfileData();
}

// ============================================
// 多种登录方式事件
// ============================================

/// Passkey 登录请求
class AuthPasskeyLoginRequested extends AuthEvent {
  final String homeserver;
  
  const AuthPasskeyLoginRequested({required this.homeserver});
  
  @override
  List<Object?> get props => [homeserver];
}

/// 注册 Passkey
class AuthRegisterPasskeyRequested extends AuthEvent {
  const AuthRegisterPasskeyRequested();
}

/// 请求邮箱验证码
class AuthRequestEmailOtpRequested extends AuthEvent {
  final String homeserver;
  final String email;
  
  const AuthRequestEmailOtpRequested({
    required this.homeserver,
    required this.email,
  });
  
  @override
  List<Object?> get props => [homeserver, email];
}

/// 邮箱验证码登录请求
class AuthEmailOtpLoginRequested extends AuthEvent {
  final String homeserver;
  final String email;
  final String otp;
  
  const AuthEmailOtpLoginRequested({
    required this.homeserver,
    required this.email,
    required this.otp,
  });
  
  @override
  List<Object?> get props => [homeserver, email, otp];
}

/// Google 登录请求
class AuthGoogleLoginRequested extends AuthEvent {
  final String homeserver;
  
  const AuthGoogleLoginRequested({required this.homeserver});
  
  @override
  List<Object?> get props => [homeserver];
}

/// Apple 登录请求
class AuthAppleLoginRequested extends AuthEvent {
  final String homeserver;
  
  const AuthAppleLoginRequested({required this.homeserver});
  
  @override
  List<Object?> get props => [homeserver];
}

/// SSO 登录请求
class AuthSsoLoginRequested extends AuthEvent {
  final String homeserver;
  final String? providerId;
  
  const AuthSsoLoginRequested({
    required this.homeserver,
    this.providerId,
  });
  
  @override
  List<Object?> get props => [homeserver, providerId];
}

