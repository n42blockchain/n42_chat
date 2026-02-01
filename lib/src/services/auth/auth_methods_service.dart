/// 多种认证方式服务
///
/// 支持 Passkey、邮箱 OTP、第三方登录等认证方式
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluwx/fluwx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

// Passkey 相关类型定义（简化版，实际需要使用 passkeys 包）
// 由于 passkeys 包在某些环境下可能有兼容性问题，这里使用简化实现

/// 认证方式
enum AuthMethod {
  password,     // 密码登录
  passkey,      // Passkey / WebAuthn
  emailOtp,     // 邮箱验证码
  google,       // Google 登录
  apple,        // Apple 登录
  facebook,     // Facebook 登录
  twitter,      // Twitter 登录
  wechat,       // 微信登录
  sso,          // Matrix SSO
}

/// 第三方登录结果
class SocialLoginResult {
  final String provider;
  final String? idToken;
  final String? accessToken;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final Map<String, dynamic>? extra;
  
  SocialLoginResult({
    required this.provider,
    this.idToken,
    this.accessToken,
    this.email,
    this.displayName,
    this.photoUrl,
    this.extra,
  });
}

/// Passkey 凭证
class PasskeyCredential {
  final String credentialId;
  final String publicKey;
  final String userId;
  final String? displayName;
  
  PasskeyCredential({
    required this.credentialId,
    required this.publicKey,
    required this.userId,
    this.displayName,
  });
  
  Map<String, dynamic> toJson() => {
    'credentialId': credentialId,
    'publicKey': publicKey,
    'userId': userId,
    'displayName': displayName,
  };
  
  factory PasskeyCredential.fromJson(Map<String, dynamic> json) {
    return PasskeyCredential(
      credentialId: json['credentialId'] as String,
      publicKey: json['publicKey'] as String,
      userId: json['userId'] as String,
      displayName: json['displayName'] as String?,
    );
  }
}

/// SSO 提供商信息
///
/// Matrix 服务器支持的 SSO 身份提供商
class SsoProvider {
  /// 提供商唯一标识
  final String id;

  /// 提供商显示名称
  final String name;

  /// 提供商图标 URL（mxc:// 或 https://）
  final String? icon;

  /// 提供商品牌（如 google, apple, github, gitlab, facebook, twitter）
  final String? brand;

  const SsoProvider({
    required this.id,
    required this.name,
    this.icon,
    this.brand,
  });

  /// 是否为 Google 登录
  bool get isGoogle => brand == 'google' || name.toLowerCase().contains('google');

  /// 是否为 Apple 登录
  bool get isApple => brand == 'apple' || name.toLowerCase().contains('apple');

  /// 是否为 GitHub 登录
  bool get isGitHub => brand == 'github' || name.toLowerCase().contains('github');

  /// 是否为 GitLab 登录
  bool get isGitLab => brand == 'gitlab' || name.toLowerCase().contains('gitlab');

  /// 是否为 Facebook 登录
  bool get isFacebook => brand == 'facebook' || name.toLowerCase().contains('facebook');

  /// 是否为 Twitter 登录
  bool get isTwitter => brand == 'twitter' || name.toLowerCase().contains('twitter');

  /// 是否为微信登录
  bool get isWeChat => brand == 'wechat' || name.toLowerCase().contains('wechat');

  @override
  String toString() => 'SsoProvider(id: $id, name: $name, brand: $brand)';
}

/// 多认证方式服务
class AuthMethodsService {
  static final AuthMethodsService _instance = AuthMethodsService._internal();
  factory AuthMethodsService() => _instance;
  AuthMethodsService._internal();

  // Passkey 配置
  String? _passkeyRpId;
  String? _passkeyOrigin;
  bool _passkeyInitialized = false;

  // Google Sign In
  GoogleSignIn? _googleSignIn;

  // Twitter 配置
  String? _twitterApiKey;
  String? _twitterApiSecret;
  String? _twitterRedirectUri;

  // WeChat 配置
  String? _weChatAppId;
  String? _weChatUniversalLink;
  bool _weChatInitialized = false;
  Completer<SocialLoginResult?>? _weChatLoginCompleter;
  
  // ============================================
  // 初始化
  // ============================================
  
  Future<void> initialize({
    String? googleClientId,
    String? googleServerClientId,
    String? passkeyRpId,
    String? passkeyOrigin,
    String? twitterApiKey,
    String? twitterApiSecret,
    String? twitterRedirectUri,
    String? weChatAppId,
    String? weChatUniversalLink,
  }) async {
    // 初始化 Passkey 配置
    _passkeyRpId = passkeyRpId ?? 'm.si46.world';
    _passkeyOrigin = passkeyOrigin ?? 'https://m.si46.world';
    _passkeyInitialized = true;
    debugPrint('AuthMethodsService: Passkey config initialized');

    // 初始化 Google Sign In
    if (googleClientId != null || !kIsWeb) {
      _googleSignIn = GoogleSignIn(
        clientId: googleClientId,
        serverClientId: googleServerClientId,
        scopes: [
          'email',
          'profile',
          'openid',
        ],
      );
      debugPrint('AuthMethodsService: Google Sign In initialized');
    }

    // 初始化 Twitter 配置
    _twitterApiKey = twitterApiKey;
    _twitterApiSecret = twitterApiSecret;
    _twitterRedirectUri = twitterRedirectUri ?? 'n42chat://';
    if (_twitterApiKey != null && _twitterApiSecret != null) {
      debugPrint('AuthMethodsService: Twitter config initialized');
    }

    // 初始化微信 SDK
    if (weChatAppId != null) {
      _weChatAppId = weChatAppId;
      _weChatUniversalLink = weChatUniversalLink ?? 'https://n42.network/app/';
      try {
        await Fluwx().registerApi(
          appId: _weChatAppId!,
          universalLink: _weChatUniversalLink!,
        );
        _weChatInitialized = await Fluwx().isWeChatInstalled;
        if (_weChatInitialized) {
          // 监听微信登录响应
          Fluwx().addSubscriber((response) {
            if (response is WeChatAuthResponse) {
              _handleWeChatAuthResponse(response);
            }
          });
          debugPrint('AuthMethodsService: WeChat SDK initialized');
        } else {
          debugPrint('AuthMethodsService: WeChat not installed');
        }
      } catch (e) {
        debugPrint('AuthMethodsService: WeChat init failed - $e');
      }
    }

    debugPrint('AuthMethodsService: Initialized');
  }
  
  // ============================================
  // Passkey / WebAuthn
  // ============================================
  
  /// 检查是否支持 Passkey
  Future<bool> isPasskeySupported() async {
    try {
      // 简单检查平台支持
      return Platform.isAndroid || Platform.isIOS || kIsWeb;
    } catch (e) {
      return false;
    }
  }
  
  /// 注册 Passkey
  /// 
  /// [userId] 用户 ID
  /// [username] 用户名
  /// [displayName] 显示名
  /// [challenge] 从服务端获取的挑战
  /// 
  /// 注意：此方法需要使用 passkeys 包的原生实现
  /// 当前为占位实现，实际使用时需要集成 passkeys 包
  Future<PasskeyCredential?> registerPasskey({
    required String userId,
    required String username,
    String? displayName,
    required String challenge,
  }) async {
    if (!_passkeyInitialized) {
      throw Exception('Passkey 未初始化');
    }
    
    try {
      debugPrint('AuthMethodsService: Registering passkey for $username');
      debugPrint('AuthMethodsService: RP ID: $_passkeyRpId');
      debugPrint('AuthMethodsService: Challenge: $challenge');
      
      // TODO: 集成 passkeys 包进行实际的 WebAuthn 注册
      // 这里需要调用平台原生的 WebAuthn API
      // 在 Android 上使用 FIDO2 API
      // 在 iOS 上使用 ASAuthorizationController
      
      throw UnimplementedError(
        'Passkey 注册需要集成 passkeys 包。\n'
        '请参考 https://pub.dev/packages/passkeys 进行集成。'
      );
    } catch (e, stackTrace) {
      debugPrint('AuthMethodsService: Passkey registration failed: $e');
      debugPrint('Stack: $stackTrace');
      rethrow;
    }
  }
  
  /// 使用 Passkey 登录
  /// 
  /// [challenge] 从服务端获取的挑战
  /// [allowedCredentials] 允许的凭证 ID 列表
  /// 
  /// 注意：此方法需要使用 passkeys 包的原生实现
  /// 当前为占位实现，实际使用时需要集成 passkeys 包
  Future<Map<String, dynamic>?> authenticateWithPasskey({
    required String challenge,
    List<String>? allowedCredentials,
  }) async {
    if (!_passkeyInitialized) {
      throw Exception('Passkey 未初始化');
    }
    
    try {
      debugPrint('AuthMethodsService: Authenticating with passkey');
      debugPrint('AuthMethodsService: RP ID: $_passkeyRpId');
      
      // TODO: 集成 passkeys 包进行实际的 WebAuthn 认证
      // 这里需要调用平台原生的 WebAuthn API
      
      throw UnimplementedError(
        'Passkey 认证需要集成 passkeys 包。\n'
        '请参考 https://pub.dev/packages/passkeys 进行集成。'
      );
    } catch (e, stackTrace) {
      debugPrint('AuthMethodsService: Passkey authentication failed: $e');
      debugPrint('Stack: $stackTrace');
      rethrow;
    }
  }
  
  // ============================================
  // 邮箱 OTP
  // ============================================
  
  /// 请求发送邮箱验证码
  /// 
  /// [email] 邮箱地址
  /// [homeserver] Matrix 服务器地址
  Future<bool> requestEmailOtp({
    required String email,
    required String homeserver,
  }) async {
    try {
      debugPrint('AuthMethodsService: Requesting email OTP for $email');
      
      // TODO: 调用服务端 API 发送验证码
      // 这需要 Matrix 服务器支持邮箱登录流程
      // 或者自定义的邮箱验证 API
      
      // 示例：调用 Matrix 邮箱验证 API
      // POST /_matrix/client/v3/register/email/requestToken
      // {
      //   "client_secret": "unique_client_secret",
      //   "email": "email@example.com",
      //   "send_attempt": 1
      // }
      
      // 暂时返回 true 表示成功发送
      await Future<void>.delayed(const Duration(seconds: 1)); // 模拟网络延迟
      
      debugPrint('AuthMethodsService: Email OTP sent');
      return true;
    } catch (e) {
      debugPrint('AuthMethodsService: Request email OTP failed: $e');
      rethrow;
    }
  }
  
  /// 验证邮箱验证码
  /// 
  /// [email] 邮箱地址
  /// [otp] 验证码
  /// [homeserver] Matrix 服务器地址
  Future<Map<String, dynamic>?> verifyEmailOtp({
    required String email,
    required String otp,
    required String homeserver,
  }) async {
    try {
      debugPrint('AuthMethodsService: Verifying email OTP');
      
      // TODO: 调用服务端 API 验证验证码
      // 验证成功后返回登录凭证
      
      // 暂时返回模拟数据
      await Future<void>.delayed(const Duration(seconds: 1));
      
      // 如果验证成功，返回登录所需的信息
      return {
        'verified': true,
        'email': email,
        'session': 'email_session_token',
      };
    } catch (e) {
      debugPrint('AuthMethodsService: Verify email OTP failed: $e');
      rethrow;
    }
  }
  
  // ============================================
  // Google 登录
  // ============================================
  
  /// 检查是否支持 Google 登录
  bool isGoogleSignInAvailable() {
    return _googleSignIn != null;
  }
  
  /// Google 登录
  Future<SocialLoginResult?> signInWithGoogle() async {
    if (_googleSignIn == null) {
      throw Exception('Google Sign In 未配置');
    }
    
    try {
      debugPrint('AuthMethodsService: Starting Google Sign In');
      
      final account = await _googleSignIn!.signIn();
      if (account == null) {
        debugPrint('AuthMethodsService: Google Sign In cancelled');
        return null;
      }
      
      final auth = await account.authentication;
      
      debugPrint('AuthMethodsService: Google Sign In success: ${account.email}');
      
      return SocialLoginResult(
        provider: 'google',
        idToken: auth.idToken,
        accessToken: auth.accessToken,
        email: account.email,
        displayName: account.displayName,
        photoUrl: account.photoUrl,
      );
    } catch (e, stackTrace) {
      debugPrint('AuthMethodsService: Google Sign In failed: $e');
      debugPrint('Stack: $stackTrace');
      rethrow;
    }
  }
  
  /// Google 登出
  Future<void> signOutGoogle() async {
    await _googleSignIn?.signOut();
  }
  
  // ============================================
  // Apple 登录
  // ============================================
  
  /// 检查是否支持 Apple 登录
  Future<bool> isAppleSignInAvailable() async {
    if (!Platform.isIOS && !Platform.isMacOS) {
      return false;
    }
    return await SignInWithApple.isAvailable();
  }
  
  /// Apple 登录
  Future<SocialLoginResult?> signInWithApple() async {
    try {
      debugPrint('AuthMethodsService: Starting Apple Sign In');
      
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      
      debugPrint('AuthMethodsService: Apple Sign In success');
      
      return SocialLoginResult(
        provider: 'apple',
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
        email: credential.email,
        displayName: credential.givenName != null 
            ? '${credential.givenName} ${credential.familyName ?? ''}'.trim()
            : null,
        extra: {
          'userIdentifier': credential.userIdentifier,
          'state': credential.state,
        },
      );
    } catch (e, stackTrace) {
      debugPrint('AuthMethodsService: Apple Sign In failed: $e');
      debugPrint('Stack: $stackTrace');
      rethrow;
    }
  }
  
  // ============================================
  // Facebook 登录
  // ============================================

  /// 检查 Facebook 登录是否可用
  bool isFacebookSignInAvailable() {
    // Facebook 登录在所有平台都可用
    return true;
  }

  /// Facebook 登录
  Future<SocialLoginResult?> signInWithFacebook() async {
    try {
      debugPrint('AuthMethodsService: Starting Facebook Sign In');

      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;
        if (accessToken == null) {
          debugPrint('AuthMethodsService: Facebook access token is null');
          return null;
        }

        // 获取用户信息
        final userData = await FacebookAuth.instance.getUserData(
          fields: 'email,name,picture.width(200)',
        );

        debugPrint('AuthMethodsService: Facebook Sign In success');

        return SocialLoginResult(
          provider: 'facebook',
          accessToken: accessToken.tokenString,
          email: userData['email'] as String?,
          displayName: userData['name'] as String?,
          photoUrl: userData['picture']?['data']?['url'] as String?,
        );
      } else if (result.status == LoginStatus.cancelled) {
        debugPrint('AuthMethodsService: Facebook Sign In cancelled');
        return null;
      } else {
        debugPrint('AuthMethodsService: Facebook Sign In failed: ${result.message}');
        throw Exception(result.message ?? 'Facebook login failed');
      }
    } catch (e, stackTrace) {
      debugPrint('AuthMethodsService: Facebook Sign In failed: $e');
      debugPrint('Stack: $stackTrace');
      rethrow;
    }
  }

  /// Facebook 登出
  Future<void> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
  }

  // ============================================
  // Twitter 登录
  // ============================================

  /// 检查 Twitter 登录是否可用
  bool isTwitterSignInAvailable() {
    return _twitterApiKey != null && _twitterApiSecret != null;
  }

  /// Twitter 登录
  Future<SocialLoginResult?> signInWithTwitter() async {
    if (!isTwitterSignInAvailable()) {
      throw Exception('Twitter 登录未配置');
    }

    try {
      debugPrint('AuthMethodsService: Starting Twitter Sign In');

      final twitterLogin = TwitterLogin(
        apiKey: _twitterApiKey!,
        apiSecretKey: _twitterApiSecret!,
        redirectURI: _twitterRedirectUri!,
      );

      final authResult = await twitterLogin.login();

      switch (authResult.status) {
        case TwitterLoginStatus.loggedIn:
          final user = authResult.user;
          debugPrint('AuthMethodsService: Twitter Sign In success');

          return SocialLoginResult(
            provider: 'twitter',
            accessToken: authResult.authToken,
            email: user?.email,
            displayName: user?.name,
            photoUrl: user?.thumbnailImage,
            extra: {
              'authTokenSecret': authResult.authTokenSecret,
              'screenName': user?.screenName,
              'userId': user?.id.toString(),
            },
          );

        case TwitterLoginStatus.cancelledByUser:
          debugPrint('AuthMethodsService: Twitter Sign In cancelled');
          return null;

        case TwitterLoginStatus.error:
          debugPrint('AuthMethodsService: Twitter Sign In error: ${authResult.errorMessage}');
          throw Exception(authResult.errorMessage ?? 'Twitter login failed');

        default:
          return null;
      }
    } catch (e, stackTrace) {
      debugPrint('AuthMethodsService: Twitter Sign In failed: $e');
      debugPrint('Stack: $stackTrace');
      rethrow;
    }
  }

  // ============================================
  // 微信登录
  // ============================================

  /// 检查微信登录是否可用
  Future<bool> isWeChatSignInAvailable() async {
    if (!_weChatInitialized) return false;
    try {
      return await Fluwx().isWeChatInstalled;
    } catch (e) {
      return false;
    }
  }

  /// 微信登录
  Future<SocialLoginResult?> signInWithWeChat() async {
    if (!_weChatInitialized) {
      throw Exception('微信 SDK 未初始化');
    }

    final isInstalled = await Fluwx().isWeChatInstalled;
    if (!isInstalled) {
      throw Exception('请先安装微信');
    }

    try {
      debugPrint('AuthMethodsService: Starting WeChat Sign In');

      _weChatLoginCompleter = Completer<SocialLoginResult?>();

      // 发起微信授权请求
      final result = await Fluwx().authBy(
        which: NormalAuth(
          scope: 'snsapi_userinfo',
          state: 'n42_chat_${DateTime.now().millisecondsSinceEpoch}',
        ),
      );

      if (!result) {
        debugPrint('AuthMethodsService: WeChat auth request failed');
        _weChatLoginCompleter?.complete(null);
        return null;
      }

      // 等待微信回调
      final loginResult = await _weChatLoginCompleter!.future.timeout(
        const Duration(minutes: 2),
        onTimeout: () {
          debugPrint('AuthMethodsService: WeChat login timeout');
          return null;
        },
      );

      return loginResult;
    } catch (e, stackTrace) {
      debugPrint('AuthMethodsService: WeChat Sign In failed: $e');
      debugPrint('Stack: $stackTrace');
      // 只有在 Completer 未完成时才调用 completeError
      if (_weChatLoginCompleter != null && !_weChatLoginCompleter!.isCompleted) {
        _weChatLoginCompleter!.completeError(e);
      }
      rethrow;
    }
  }

  /// 处理微信授权响应
  void _handleWeChatAuthResponse(WeChatAuthResponse response) {
    if (_weChatLoginCompleter == null || _weChatLoginCompleter!.isCompleted) {
      return;
    }

    if (response.code != null && response.code!.isNotEmpty) {
      debugPrint('AuthMethodsService: WeChat auth success');

      // 微信登录成功，返回 code 供后端换取 access_token
      _weChatLoginCompleter!.complete(SocialLoginResult(
        provider: 'wechat',
        accessToken: response.code,  // 这是授权码，需要后端换取 access_token
        extra: {
          'code': response.code,
          'state': response.state,
          'country': response.country,
          'lang': response.lang,
        },
      ));
    } else {
      debugPrint('AuthMethodsService: WeChat auth failed: ${response.errStr}');
      if (response.errCode == -2) {
        // 用户取消
        _weChatLoginCompleter!.complete(null);
      } else {
        _weChatLoginCompleter!.completeError(
          Exception(response.errStr ?? 'WeChat auth failed'),
        );
      }
    }
  }

  // ============================================
  // Matrix SSO
  // ============================================
  
  /// 获取 Matrix SSO 登录 URL
  /// 
  /// [homeserver] Matrix 服务器地址
  /// [redirectUrl] 回调 URL
  String getSsoLoginUrl({
    required String homeserver,
    required String redirectUrl,
  }) {
    final encodedRedirect = Uri.encodeComponent(redirectUrl);
    return '$homeserver/_matrix/client/v3/login/sso/redirect?redirectUrl=$encodedRedirect';
  }
  
  /// 获取支持的 SSO 提供商列表
  ///
  /// [homeserver] Matrix 服务器地址
  ///
  /// 返回 SSO 提供商列表，每个提供商包含:
  /// - id: 提供商 ID
  /// - name: 提供商名称
  /// - icon: 提供商图标 URL（如果有）
  /// - brand: 提供商品牌（如 google, apple, github 等）
  Future<List<SsoProvider>> getSsoProviders(String homeserver) async {
    try {
      final uri = Uri.parse('$homeserver/_matrix/client/v3/login');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final flows = data['flows'] as List<dynamic>?;

        if (flows == null) return [];

        final providers = <SsoProvider>[];

        for (final flow in flows) {
          if (flow['type'] == 'm.login.sso') {
            final identityProviders =
                flow['identity_providers'] as List<dynamic>?;
            if (identityProviders != null) {
              for (final provider in identityProviders) {
                providers.add(SsoProvider(
                  id: provider['id'] as String? ?? '',
                  name: provider['name'] as String? ?? 'SSO',
                  icon: provider['icon'] as String?,
                  brand: provider['brand'] as String?,
                ));
              }
            }
            // 如果没有 identity_providers，说明是单一 SSO 登录
            if (identityProviders == null || identityProviders.isEmpty) {
              providers.add(const SsoProvider(
                id: 'sso',
                name: 'SSO Login',
              ));
            }
          }
        }

        debugPrint(
            'AuthMethodsService: Found ${providers.length} SSO providers');
        return providers;
      }

      return [];
    } catch (e) {
      debugPrint('AuthMethodsService: Get SSO providers failed: $e');
      return [];
    }
  }

  /// 获取特定 SSO 提供商的登录 URL
  ///
  /// [homeserver] Matrix 服务器地址
  /// [providerId] SSO 提供商 ID
  /// [redirectUrl] 回调 URL
  String getSsoProviderLoginUrl({
    required String homeserver,
    required String providerId,
    required String redirectUrl,
  }) {
    final encodedRedirect = Uri.encodeComponent(redirectUrl);
    return '$homeserver/_matrix/client/v3/login/sso/redirect/$providerId?redirectUrl=$encodedRedirect';
  }
  
  // ============================================
  // 工具方法
  // ============================================
  
  /// 清理所有登录状态
  Future<void> signOutAll() async {
    await signOutGoogle();
    await signOutFacebook();
  }

  /// 释放资源
  void dispose() {
    _passkeyInitialized = false;
    _passkeyRpId = null;
    _passkeyOrigin = null;
    _googleSignIn = null;
    _twitterApiKey = null;
    _twitterApiSecret = null;
    _twitterRedirectUri = null;
    _weChatAppId = null;
    _weChatUniversalLink = null;
    _weChatInitialized = false;
    _weChatLoginCompleter = null;
  }
}

