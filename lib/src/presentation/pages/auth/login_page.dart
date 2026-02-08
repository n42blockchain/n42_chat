import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/biometric_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/local/secure_storage_datasource.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../../services/auth/auth_methods_service.dart';
import 'register_page.dart';
import 'email_otp_page.dart';
import 'reset_password_page.dart';

/// 登录页面
///
/// 微信风格的登录界面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _homeserverController = TextEditingController(text: 'https://m.si46.world');
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _biometricService = BiometricService();
  final _secureStorage = SecureStorageDataSource();

  bool _obscurePassword = true;
  bool _isBiometricAvailable = false;
  bool _isBiometricEnabled = false;
  bool _hasCredentials = false;
  String _biometricTypeDescription = '';
  // 微信策略：同一设备登录一次后自动保持登录状态，无需用户选择
  // 登出时才会清除登录凭据

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    final isAvailable = await _biometricService.isAvailable();
    final isEnabled = await _secureStorage.isBiometricEnabled();
    final hasCredentials = await _secureStorage.hasCredentials();
    final typeDescription = isAvailable
        ? await _biometricService.getBiometricTypeDescription()
        : '';

    // 调试日志
    debugPrint('LoginPage: Biometric check - available: $isAvailable, enabled: $isEnabled, hasCredentials: $hasCredentials');

    if (mounted) {
      setState(() {
        _isBiometricAvailable = isAvailable;
        _isBiometricEnabled = isEnabled;
        _hasCredentials = hasCredentials;
        _biometricTypeDescription = typeDescription;
      });

      // 如果生物识别已启用且有保存的凭据，自动触发生物识别
      if (isAvailable && isEnabled && hasCredentials) {
        // 延迟一点再触发，让UI先渲染
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            _loginWithBiometric();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _homeserverController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // 微信策略：始终保持登录状态
      context.read<AuthBloc>().add(AuthLoginRequested(
            homeserver: _homeserverController.text.trim(),
            username: _usernameController.text.trim(),
            password: _passwordController.text,
            rememberMe: true, // 始终记住登录
          ));
    }
  }

  void _checkHomeserver() {
    final homeserver = _homeserverController.text.trim();
    if (homeserver.isNotEmpty) {
      context.read<AuthBloc>().add(AuthHomeserverCheckRequested(homeserver));
    }
  }

  void _showForgotPasswordHelp() {
    final homeserver = _homeserverController.text.trim();
    if (homeserver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.authEnterServerAddressFirst ?? 'Please enter server address first'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // 跳转到重置密码页面
    final authBloc = context.read<AuthBloc>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: authBloc,
          child: ResetPasswordPage(homeserver: homeserver),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.backgroundDark : Colors.white;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          S.of(context)?.authLogin ?? 'Log In',
          style: TextStyle(
            color: textColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? S.of(context)?.authLoginFailed('') ?? 'Login failed'),
                backgroundColor: AppColors.error,
              ),
            );
          }

          if (state.isAuthenticated) {
            // 登录成功，返回上一页或跳转到主页
            Navigator.of(context).maybePop(true);
          }
        },
        builder: (context, state) {
          final isDarkMode = context.isDarkMode;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // Logo（紧凑版）
                  _buildCompactLogo(isDarkMode),

                  const SizedBox(height: 24),

                  // 服务器输入
                  _buildServerInput(state, isDarkMode),

                  const SizedBox(height: 12),

                  // 用户名输入
                  _buildUsernameInput(isDarkMode),

                  const SizedBox(height: 12),

                  // 密码输入
                  _buildPasswordInput(isDarkMode),

                  const SizedBox(height: 20),

                  // 生物识别快捷登录（如果已启用且有凭据）- 显示在登录按钮上方
                  if (_isBiometricAvailable && _isBiometricEnabled && _hasCredentials) ...[
                    _buildBiometricQuickLogin(),
                    const SizedBox(height: 12),
                    _buildOrDivider(),
                    const SizedBox(height: 12),
                  ],

                  // 登录按钮
                  _buildLoginButton(state),

                  const SizedBox(height: 16),

                  // 注册和忘记密码链接
                  _buildQuickLinks(),

                  const SizedBox(height: 16),

                  // 第三方登录
                  _buildSocialLogins(),

                  const SizedBox(height: 16),

                  // 底部协议
                  _buildAgreement(isDarkMode),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo(bool isDark) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.chat_bubble_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'N42 Chat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          S.of(context)?.authSecureDecentralizedChat ?? 'Secure, decentralized instant messaging',
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  /// 紧凑版 Logo
  Widget _buildCompactLogo(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.chat_bubble_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'N42 Chat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            Text(
              S.of(context)?.authSecureDecentralizedChat ?? 'Secure, decentralized messaging',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 第三方登录
  Widget _buildSocialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          icon: Icons.g_mobiledata,
          color: const Color(0xFFDB4437),
          onTap: _loginWithGoogle,
        ),
        if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) ...[
          const SizedBox(width: 20),
          _buildSocialButton(
            icon: Icons.apple,
            color: context.isDarkMode ? Colors.white : Colors.black,
            onTap: _loginWithApple,
          ),
        ],
        const SizedBox(width: 20),
        _buildSocialButton(
          icon: Icons.login,
          color: Colors.blue,
          onTap: _loginWithSso,
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }

  /// 快速链接（注册和忘记密码）
  Widget _buildQuickLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            final authBloc = context.read<AuthBloc>();
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => BlocProvider.value(
                  value: authBloc,
                  child: const RegisterPage(),
                ),
              ),
            );
          },
          child: Text(
            S.of(context)?.authRegisterAccount ?? 'Sign Up',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textLink,
            ),
          ),
        ),
        const Text(
          '|',
          style: TextStyle(color: AppColors.textTertiary),
        ),
        TextButton(
          onPressed: _showForgotPasswordHelp,
          child: Text(
            S.of(context)?.authForgotPassword ?? 'Forgot Password',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textLink,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServerInput(AuthState state, bool isDark) {
    final labelColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final inputBgColor = isDark ? AppColors.surfaceDark : AppColors.inputBackground;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final hintColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context)?.authServerAddress ?? 'Server Address',
          style: TextStyle(
            fontSize: 14,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _homeserverController,
          style: TextStyle(color: textColor, fontSize: 16),
          decoration: InputDecoration(
            hintText: S.of(context)?.authServerAddressHint ?? 'https://m.si46.world',
            hintStyle: TextStyle(color: hintColor),
            filled: true,
            fillColor: inputBgColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: state.isCheckingHomeserver
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  )
                : state.isHomeserverValid
                    ? const Icon(Icons.check_circle, color: AppColors.success)
                    : IconButton(
                        icon: Icon(Icons.refresh, color: hintColor),
                        onPressed: _checkHomeserver,
                      ),
          ),
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.next,
          onEditingComplete: _checkHomeserver,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context)?.authEnterServerAddress ?? 'Please enter server address';
            }
            if (!value.startsWith('http://') && !value.startsWith('https://')) {
              return S.of(context)?.authEnterValidServerAddress ?? 'Please enter a valid server address';
            }
            return null;
          },
        ),
        if (state.isHomeserverValid && state.homeserverInfo != null) ...[
          const SizedBox(height: 4),
          Text(
            '✓ ${S.of(context)?.authConnectedTo(state.homeserverInfo!.serverName) ?? 'Connected to ${state.homeserverInfo!.serverName}'}',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.success,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildUsernameInput(bool isDark) {
    final labelColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final inputBgColor = isDark ? AppColors.surfaceDark : AppColors.inputBackground;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final hintColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context)?.authUsername ?? 'Username',
          style: TextStyle(
            fontSize: 14,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _usernameController,
          style: TextStyle(color: textColor, fontSize: 16),
          decoration: InputDecoration(
            hintText: S.of(context)?.authEnterUsername ?? 'Enter username',
            hintStyle: TextStyle(color: hintColor),
            filled: true,
            fillColor: inputBgColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            prefixIcon: Icon(
              Icons.person_outline,
              color: hintColor,
            ),
          ),
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context)?.authEnterUsername ?? 'Please enter username';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordInput(bool isDark) {
    final labelColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final inputBgColor = isDark ? AppColors.surfaceDark : AppColors.inputBackground;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final hintColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context)?.authPassword ?? 'Password',
          style: TextStyle(
            fontSize: 14,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          style: TextStyle(color: textColor, fontSize: 16),
          decoration: InputDecoration(
            hintText: S.of(context)?.authEnterPassword ?? 'Enter password',
            hintStyle: TextStyle(color: hintColor),
            filled: true,
            fillColor: inputBgColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: hintColor,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: hintColor,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _onLogin(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context)?.authEnterPassword ?? 'Please enter password';
            }
            return null;
          },
        ),
      ],
    );
  }

  // _buildRememberMe 已移除 - 微信策略默认始终保持登录

  Widget _buildLoginButton(AuthState state) {
    final isEnabled = !state.isLoading;

    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: isEnabled ? _onLogin : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: state.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                S.of(context)?.authLogin ?? 'Log In',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildOtherOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                final authBloc = context.read<AuthBloc>();
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => BlocProvider.value(
                      value: authBloc,
                      child: const RegisterPage(),
                    ),
                  ),
                );
              },
              child: Text(
                S.of(context)?.authRegisterAccount ?? 'Sign Up',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textLink,
                ),
              ),
            ),
            const Text(
              '|',
              style: TextStyle(
                color: AppColors.textTertiary,
              ),
            ),
            TextButton(
              onPressed: () {
                _showForgotPasswordHelp();
              },
              child: Text(
                S.of(context)?.authForgotPassword ?? 'Forgot Password',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textLink,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 32),
        
        // 分隔线
        _buildDivider(),
        
        const SizedBox(height: 24),
        
        // 其他登录方式
        _buildAlternativeLoginMethods(),
      ],
    );
  }
  
  Widget _buildDivider() {
    final isDark = context.isDarkMode;
    final dividerColor = isDark ? Colors.white24 : Colors.black12;
    final textColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    
    return Row(
      children: [
        Expanded(child: Divider(color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            S.of(context)?.authOtherLoginMethods ?? 'Other login methods',
            style: TextStyle(
              fontSize: 12,
              color: textColor,
            ),
          ),
        ),
        Expanded(child: Divider(color: dividerColor)),
      ],
    );
  }
  
  Widget _buildAlternativeLoginMethods() {
    return Column(
      children: [
        // 生物识别登录按钮（如果可用且已启用）
        if (_isBiometricAvailable && _isBiometricEnabled && _hasCredentials) ...[
          _buildBiometricLoginButton(),
          const SizedBox(height: 20),
        ],

        // 第一行：Passkey 和 邮箱验证码
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLoginMethodButton(
              icon: Icons.fingerprint,
              label: S.of(context)?.authPasskeyLabel ?? 'Passkey',
              onTap: _loginWithPasskey,
            ),
            const SizedBox(width: 32),
            _buildLoginMethodButton(
              icon: Icons.email_outlined,
              label: S.of(context)?.authEmailOtp ?? 'Email OTP',
              onTap: _loginWithEmailOtp,
            ),
          ],
        ),

        const SizedBox(height: 20),

        // 第二行：第三方登录
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialLoginButton(
              iconPath: null,
              icon: Icons.g_mobiledata,
              color: const Color(0xFFDB4437),
              label: S.of(context)?.authGoogleLabel ?? 'Google',
              onTap: _loginWithGoogle,
            ),
            const SizedBox(width: 24),
            if (!kIsWeb && (Platform.isIOS || Platform.isMacOS))
              _buildSocialLoginButton(
                iconPath: null,
                icon: Icons.apple,
                color: context.isDarkMode
                    ? Colors.white
                    : Colors.black,
                label: S.of(context)?.authAppleLabel ?? 'Apple',
                onTap: _loginWithApple,
              ),
            if (!kIsWeb && (Platform.isIOS || Platform.isMacOS))
              const SizedBox(width: 24),
            _buildSocialLoginButton(
              iconPath: null,
              icon: Icons.login,
              color: AppColors.primary,
              label: S.of(context)?.authSsoLabel ?? 'SSO',
              onTap: _loginWithSso,
            ),
          ],
        ),
      ],
    );
  }

  /// 生物识别快捷登录按钮（显示在登录按钮上方）
  Widget _buildBiometricQuickLogin() {
    // 根据生物识别类型选择图标
    IconData biometricIcon;
    if (_biometricTypeDescription.contains('Face')) {
      biometricIcon = Icons.face;
    } else if (_biometricTypeDescription.contains('Touch') ||
        _biometricTypeDescription.contains('Fingerprint')) {
      biometricIcon = Icons.fingerprint;
    } else {
      biometricIcon = Icons.security;
    }

    return ElevatedButton.icon(
      onPressed: _loginWithBiometric,
      icon: Icon(biometricIcon, size: 24),
      label: Text(
        S.of(context)?.authLoginWithBiometric(_biometricTypeDescription) ??
            'Login with $_biometricTypeDescription',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    final isDark = context.isDarkMode;
    final dividerColor = isDark ? Colors.white24 : Colors.black12;
    final textColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Row(
      children: [
        Expanded(child: Divider(color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            S.of(context)?.authOr ?? 'OR',
            style: TextStyle(color: textColor, fontSize: 12),
          ),
        ),
        Expanded(child: Divider(color: dividerColor)),
      ],
    );
  }

  Widget _buildBiometricLoginButton() {
    final bgColor = AppColors.primary.withValues(alpha: 0.1);
    const iconColor = AppColors.primary;

    // 根据生物识别类型选择图标
    IconData biometricIcon;
    if (_biometricTypeDescription.contains('Face')) {
      biometricIcon = Icons.face;
    } else if (_biometricTypeDescription.contains('Touch') ||
        _biometricTypeDescription.contains('Fingerprint')) {
      biometricIcon = Icons.fingerprint;
    } else {
      biometricIcon = Icons.security;
    }

    return InkWell(
      onTap: _loginWithBiometric,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(biometricIcon, color: iconColor, size: 28),
            const SizedBox(width: 12),
            Text(
              S.of(context)?.authLoginWithBiometric(_biometricTypeDescription) ??
                  'Login with $_biometricTypeDescription',
              style: const TextStyle(
                fontSize: 16,
                color: iconColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLoginMethodButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.surfaceDark : Colors.grey[100];
    final iconColor = isDark ? Colors.white70 : Colors.black54;
    final textColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSocialLoginButton({
    String? iconPath,
    IconData? icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDark ? Colors.white12 : Colors.black12;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(12),
        splashColor: color.withValues(alpha: 0.2),
        highlightColor: color.withValues(alpha: 0.1),
        child: Ink(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(icon, color: color, size: 28),
            ],
          ),
        ),
      ),
    );
  }
  
  // ============================================
  // 登录方法
  // ============================================
  
  void _loginWithBiometric() async {
    // 直接触发生物识别登录
    context.read<AuthBloc>().add(const AuthBiometricLoginRequested());
  }

  void _loginWithPasskey() async {
    final homeserver = _homeserverController.text.trim();
    if (homeserver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.authEnterServerAddressFirst ?? 'Please enter server address first'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    try {
      final authService = AuthMethodsService();

      // 1. Check platform support
      final isSupported = await authService.isPasskeySupported();
      if (!isSupported) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context)?.authPasskeyNotSupported ?? 'Passkey is not supported on this device'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }

      // 2. Request authentication challenge from server
      final challengeData = await authService.requestPasskeyAuthChallenge(
        homeserver: homeserver,
      );

      if (challengeData == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context)?.authPasskeyRequiresServer ?? 'Passkey login requires server support (MSC3824)'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }

      // 3. Authenticate with passkey
      final challenge = challengeData['challenge'] as String? ?? '';
      final allowedCredentials = (challengeData['allowed_credentials'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList();

      final result = await authService.authenticateWithPasskey(
        challenge: challenge,
        allowedCredentials: allowedCredentials,
        homeserver: homeserver,
      );

      if (result == null) {
        // User canceled
        return;
      }

      // 4. Use the login token from the result to authenticate with Matrix
      final loginToken = result['access_token'] as String?;
      final userId = result['user_id'] as String?;
      final deviceId = result['device_id'] as String?;
      if (loginToken != null && userId != null && deviceId != null && mounted) {
        context.read<AuthBloc>().add(AuthTokenLoginRequested(
          homeserver: homeserver,
          accessToken: loginToken,
          userId: userId,
          deviceId: deviceId,
        ));
      }
    } on PlatformException catch (e) {
      if (e.code == 'USER_CANCELED') return;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passkey error: ${e.message}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passkey login failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
  
  void _loginWithEmailOtp() {
    final authBloc = context.read<AuthBloc>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: authBloc,
          child: EmailOtpPage(
            homeserver: _homeserverController.text.trim(),
          ),
        ),
      ),
    );
  }
  
  void _loginWithGoogle() {
    final homeserver = _homeserverController.text.trim();
    if (homeserver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.authEnterServerAddressFirst ?? 'Please enter server address first'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // 触发 AuthBloc 的 Google 登录事件
    context.read<AuthBloc>().add(AuthGoogleLoginRequested(homeserver: homeserver));
  }

  void _loginWithApple() {
    final homeserver = _homeserverController.text.trim();
    if (homeserver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.authEnterServerAddressFirst ?? 'Please enter server address first'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // 触发 AuthBloc 的 Apple 登录事件
    context.read<AuthBloc>().add(AuthAppleLoginRequested(homeserver: homeserver));
  }

  void _loginWithSso() async {
    final homeserver = _homeserverController.text.trim();
    if (homeserver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.authEnterServerAddressFirst ?? 'Please enter server address first'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    
    context.read<AuthBloc>().add(AuthSsoLoginRequested(homeserver: homeserver));
  }

  Widget _buildAgreement(bool isDark) {
    final textColor = isDark ? AppColors.textSecondaryDark : AppColors.textTertiary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text.rich(
        TextSpan(
          text: S.of(context)?.authLoginAgreement ?? 'By logging in, you agree to ',
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
          children: [
            TextSpan(
              text: S.of(context)?.authTermsOfService ?? 'Terms of Service',
              style: TextStyle(
                color: AppColors.textLink.withValues(alpha: 0.8),
              ),
            ),
            TextSpan(text: S.of(context)?.authAnd ?? ' and '),
            TextSpan(
              text: S.of(context)?.authPrivacyPolicy ?? 'Privacy Policy',
              style: TextStyle(
                color: AppColors.textLink.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

