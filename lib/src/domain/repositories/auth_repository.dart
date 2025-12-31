import '../entities/user_entity.dart';

/// 认证仓库接口
///
/// 定义认证相关的所有操作，由 Data 层实现
abstract class IAuthRepository {
  /// 是否已登录
  bool get isLoggedIn;

  /// 当前用户
  UserEntity? get currentUser;

  /// 登录状态流
  Stream<bool> get loginStateStream;

  /// 使用用户名密码登录
  ///
  /// [homeserver] Matrix服务器地址
  /// [username] 用户名
  /// [password] 密码
  ///
  /// 返回登录结果
  Future<AuthResult> login({
    required String homeserver,
    required String username,
    required String password,
  });

  /// 使用Token恢复登录
  Future<AuthResult> loginWithToken({
    required String homeserver,
    required String accessToken,
    required String userId,
    required String deviceId,
  });

  /// 自动恢复会话
  ///
  /// 从本地存储恢复上次的登录状态
  Future<AuthResult> restoreSession();

  /// 登出
  Future<void> logout();

  /// 注册新用户
  Future<AuthResult> register({
    required String homeserver,
    required String username,
    required String password,
    String? email,
  });

  /// 检查Homeserver是否有效
  Future<HomeserverInfo> checkHomeserver(String homeserver);

  /// 检查用户名是否可用
  Future<bool> isUsernameAvailable(String homeserver, String username);

  /// 获取当前用户资料
  Future<UserEntity?> getCurrentUserProfile();

  /// 更新用户资料
  Future<void> updateProfile({
    String? displayName,
    String? avatarPath,
  });
}

/// 认证结果
class AuthResult {
  final bool success;
  final UserEntity? user;
  final String? errorMessage;
  final AuthErrorType? errorType;

  const AuthResult._({
    required this.success,
    this.user,
    this.errorMessage,
    this.errorType,
  });

  /// 创建成功结果
  factory AuthResult.success(UserEntity user) => AuthResult._(
        success: true,
        user: user,
      );

  /// 创建失败结果
  factory AuthResult.failure(
    String message, {
    AuthErrorType type = AuthErrorType.unknown,
  }) =>
      AuthResult._(
        success: false,
        errorMessage: message,
        errorType: type,
      );

  /// 未登录
  factory AuthResult.notLoggedIn() => const AuthResult._(
        success: false,
        errorMessage: '未登录',
        errorType: AuthErrorType.notLoggedIn,
      );

  @override
  String toString() => success
      ? 'AuthResult.success(${user?.userId})'
      : 'AuthResult.failure($errorMessage)';
}

/// 认证错误类型
enum AuthErrorType {
  /// 未知错误
  unknown,

  /// 未登录
  notLoggedIn,

  /// 服务器无效
  invalidHomeserver,

  /// 用户名或密码错误
  invalidCredentials,

  /// 用户名已存在
  usernameExists,

  /// 用户名不可用
  usernameUnavailable,

  /// 网络错误
  networkError,

  /// 服务器错误
  serverError,

  /// Token过期
  tokenExpired,

  /// 设备验证失败
  deviceVerificationFailed,

  /// 需要额外验证
  additionalAuthRequired,

  /// 速率限制
  rateLimited,
}

/// Homeserver信息
class HomeserverInfo {
  final String serverName;
  final String serverVersion;
  final List<String> supportedLoginTypes;
  final bool supportsRegistration;

  const HomeserverInfo({
    required this.serverName,
    required this.serverVersion,
    required this.supportedLoginTypes,
    this.supportsRegistration = false,
  });

  /// 是否支持密码登录
  bool get supportsPasswordLogin =>
      supportedLoginTypes.contains('m.login.password');

  /// 是否支持SSO登录
  bool get supportsSsoLogin => supportedLoginTypes.contains('m.login.sso');

  @override
  String toString() =>
      'HomeserverInfo($serverName, v$serverVersion, types: $supportedLoginTypes)';
}

