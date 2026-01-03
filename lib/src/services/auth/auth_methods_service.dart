/// 多种认证方式服务
/// 
/// 支持 Passkey、邮箱 OTP、第三方登录等认证方式
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passkeys/passkeys.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// 认证方式
enum AuthMethod {
  password,     // 密码登录
  passkey,      // Passkey / WebAuthn
  emailOtp,     // 邮箱验证码
  google,       // Google 登录
  apple,        // Apple 登录
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

/// 多认证方式服务
class AuthMethodsService {
  static final AuthMethodsService _instance = AuthMethodsService._internal();
  factory AuthMethodsService() => _instance;
  AuthMethodsService._internal();
  
  // Passkeys
  PasskeyAuth? _passkeyAuth;
  
  // Google Sign In
  GoogleSignIn? _googleSignIn;
  
  // ============================================
  // 初始化
  // ============================================
  
  Future<void> initialize({
    String? googleClientId,
    String? googleServerClientId,
  }) async {
    // 初始化 Passkey
    try {
      _passkeyAuth = PasskeyAuth(
        RelyingPartyServer(
          // 这些将从服务端获取
          name: 'N42 Chat',
          id: 'm.si46.world',
          origin: 'https://m.si46.world',
        ),
      );
      debugPrint('AuthMethodsService: Passkey initialized');
    } catch (e) {
      debugPrint('AuthMethodsService: Passkey init failed: $e');
    }
    
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
  Future<PasskeyCredential?> registerPasskey({
    required String userId,
    required String username,
    String? displayName,
    required String challenge,
  }) async {
    if (_passkeyAuth == null) {
      throw Exception('Passkey 未初始化');
    }
    
    try {
      debugPrint('AuthMethodsService: Registering passkey for $username');
      
      final registerRequest = RegisterRequestType(
        challenge: challenge,
        relyingParty: RelyingPartyType(
          name: 'N42 Chat',
          id: 'm.si46.world',
        ),
        user: UserType(
          id: userId,
          name: username,
          displayName: displayName ?? username,
        ),
        authSelectionType: AuthenticatorSelectionType(
          authenticatorAttachment: 'platform',
          residentKey: 'required',
          requireResidentKey: true,
          userVerification: 'required',
        ),
        pubKeyCredParams: [
          PubKeyCredParamType(type: 'public-key', alg: -7),  // ES256
          PubKeyCredParamType(type: 'public-key', alg: -257), // RS256
        ],
        timeout: 60000,
        attestation: 'none',
      );
      
      final response = await _passkeyAuth!.register(registerRequest);
      
      debugPrint('AuthMethodsService: Passkey registered: ${response.id}');
      
      return PasskeyCredential(
        credentialId: response.id,
        publicKey: response.rawId,
        userId: userId,
        displayName: displayName ?? username,
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
  Future<Map<String, dynamic>?> authenticateWithPasskey({
    required String challenge,
    List<String>? allowedCredentials,
  }) async {
    if (_passkeyAuth == null) {
      throw Exception('Passkey 未初始化');
    }
    
    try {
      debugPrint('AuthMethodsService: Authenticating with passkey');
      
      final authRequest = AuthenticateRequestType(
        challenge: challenge,
        timeout: 60000,
        rpId: 'm.si46.world',
        userVerification: 'required',
        allowCredentials: allowedCredentials?.map((id) => 
          AllowCredentialType(type: 'public-key', id: id)
        ).toList(),
      );
      
      final response = await _passkeyAuth!.authenticate(authRequest);
      
      debugPrint('AuthMethodsService: Passkey authentication success');
      
      return {
        'credentialId': response.id,
        'rawId': response.rawId,
        'clientDataJSON': response.clientDataJSON,
        'authenticatorData': response.authenticatorData,
        'signature': response.signature,
        'userHandle': response.userHandle,
      };
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
      await Future.delayed(const Duration(seconds: 1)); // 模拟网络延迟
      
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
      await Future.delayed(const Duration(seconds: 1));
      
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
  Future<List<Map<String, dynamic>>> getSsoProviders(String homeserver) async {
    try {
      // TODO: 调用 /_matrix/client/v3/login 获取支持的登录方式
      // 返回 type: "m.login.sso" 的 identity_providers
      
      return [];
    } catch (e) {
      debugPrint('AuthMethodsService: Get SSO providers failed: $e');
      return [];
    }
  }
  
  // ============================================
  // 工具方法
  // ============================================
  
  /// 清理所有登录状态
  Future<void> signOutAll() async {
    await signOutGoogle();
  }
  
  /// 释放资源
  void dispose() {
    _passkeyAuth = null;
    _googleSignIn = null;
  }
}

