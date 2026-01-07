import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/auth/auth_methods_service.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import 'register_page.dart';
import 'email_otp_page.dart';

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

  bool _obscurePassword = true;
  // 微信策略：同一设备登录一次后自动保持登录状态，无需用户选择
  // 登出时才会清除登录凭据

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
          S.of(context)?.login ?? 'Log In',
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
                content: Text(state.errorMessage ?? S.of(context)?.loginFailed('') ?? 'Login failed'),
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
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),

                  // Logo
                  _buildLogo(isDarkMode),

                  const SizedBox(height: 48),

                  // 服务器输入
                  _buildServerInput(state, isDarkMode),

                  const SizedBox(height: 16),

                  // 用户名输入
                  _buildUsernameInput(isDarkMode),

                  const SizedBox(height: 16),

                  // 密码输入
                  _buildPasswordInput(isDarkMode),

                  const SizedBox(height: 32),
                  
                  // 微信策略：移除"记住登录"复选框，默认始终保持登录

                  // 登录按钮
                  _buildLoginButton(state),

                  const SizedBox(height: 24),

                  // 其他选项
                  _buildOtherOptions(),

                  const SizedBox(height: 48),

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
          S.of(context)?.secureDecentralizedChat ?? 'Secure, decentralized instant messaging',
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
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
          S.of(context)?.serverAddress ?? 'Server Address',
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
            hintText: 'https://m.si46.world',
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
              return S.of(context)?.enterServerAddress ?? 'Please enter server address';
            }
            if (!value.startsWith('http://') && !value.startsWith('https://')) {
              return S.of(context)?.enterValidServerAddress ?? 'Please enter a valid server address';
            }
            return null;
          },
        ),
        if (state.isHomeserverValid && state.homeserverInfo != null) ...[
          const SizedBox(height: 4),
          Text(
            '✓ ${S.of(context)?.connectedTo(state.homeserverInfo!.serverName) ?? 'Connected to ${state.homeserverInfo!.serverName}'}',
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
          S.of(context)?.username ?? 'Username',
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
            hintText: S.of(context)?.enterUsername ?? 'Enter username',
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
              return S.of(context)?.enterUsername ?? 'Please enter username';
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
          S.of(context)?.password ?? 'Password',
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
            hintText: S.of(context)?.enterPassword ?? 'Enter password',
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
              return S.of(context)?.enterPassword ?? 'Please enter password';
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
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                S.of(context)?.login ?? 'Log In',
                style: TextStyle(
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
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: authBloc,
                      child: const RegisterPage(),
                    ),
                  ),
                );
              },
              child: Text(
                S.of(context)?.registerAccount ?? 'Sign Up',
                style: TextStyle(
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
                // 跳转到邮箱验证码登录
                final authBloc = context.read<AuthBloc>();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: authBloc,
                      child: EmailOtpPage(
                        homeserver: _homeserverController.text.trim(),
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                S.of(context)?.forgotPassword ?? 'Forgot Password',
                style: TextStyle(
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark ? Colors.white24 : Colors.black12;
    final textColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    
    return Row(
      children: [
        Expanded(child: Divider(color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            S.of(context)?.otherLoginMethods ?? 'Other login methods',
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
        // 第一行：Passkey 和 邮箱验证码
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLoginMethodButton(
              icon: Icons.fingerprint,
              label: 'Passkey',
              onTap: _loginWithPasskey,
            ),
            const SizedBox(width: 32),
            _buildLoginMethodButton(
              icon: Icons.email_outlined,
              label: S.of(context)?.emailOtp ?? 'Email OTP',
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
              label: 'Google',
              onTap: _loginWithGoogle,
            ),
            const SizedBox(width: 24),
            if (!kIsWeb && (Platform.isIOS || Platform.isMacOS))
              _buildSocialLoginButton(
                iconPath: null,
                icon: Icons.apple,
                color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : Colors.black,
                label: 'Apple',
                onTap: _loginWithApple,
              ),
            if (!kIsWeb && (Platform.isIOS || Platform.isMacOS))
              const SizedBox(width: 24),
            _buildSocialLoginButton(
              iconPath: null,
              icon: Icons.login,
              color: AppColors.primary,
              label: 'SSO',
              onTap: _loginWithSso,
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildLoginMethodButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDark ? Colors.white12 : Colors.black12;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
            // const SizedBox(height: 2),
            // Text(
            //   label,
            //   style: TextStyle(
            //     fontSize: 10,
            //     color: isDark ? Colors.white54 : Colors.black45,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  
  // ============================================
  // 登录方法
  // ============================================
  
  void _loginWithPasskey() async {
    final homeserver = _homeserverController.text.trim();
    if (homeserver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.enterServerAddressFirst ?? 'Please enter server address first'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // TODO: 实现真正的 Passkey 登录
    // 目前显示提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context)?.passkeyRequiresServer ?? 'Passkey login requires server support'),
        backgroundColor: Colors.orange,
      ),
    );
    
    // context.read<AuthBloc>().add(AuthPasskeyLoginRequested(homeserver: homeserver));
  }
  
  void _loginWithEmailOtp() {
    final authBloc = context.read<AuthBloc>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: authBloc,
          child: EmailOtpPage(
            homeserver: _homeserverController.text.trim(),
          ),
        ),
      ),
    );
  }
  
  void _loginWithGoogle() async {
    final homeserver = _homeserverController.text.trim();
    if (homeserver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.enterServerAddressFirst ?? 'Please enter server address first'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    
    try {
      final authService = AuthMethodsService();
      final result = await authService.signInWithGoogle();
      
      if (result != null && mounted) {
        // 使用 Google 登录结果进行 Matrix SSO
        debugPrint('Google login success: ${result.email}');
        
        // TODO: 将 Google token 发送到 Matrix 服务器进行验证
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google 登录成功: ${result.email}'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google 登录失败: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
  
  void _loginWithApple() async {
    final homeserver = _homeserverController.text.trim();
    if (homeserver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.enterServerAddressFirst ?? 'Please enter server address first'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    
    try {
      final authService = AuthMethodsService();
      final result = await authService.signInWithApple();
      
      if (result != null && mounted) {
        debugPrint('Apple login success');
        
        // TODO: 将 Apple token 发送到 Matrix 服务器进行验证
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Apple 登录成功'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Apple 登录失败: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
  
  void _loginWithSso() async {
    final homeserver = _homeserverController.text.trim();
    if (homeserver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.enterServerAddressFirst ?? 'Please enter server address first'),
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
          text: S.of(context)?.loginAgreement ?? 'By logging in, you agree to ',
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
          children: [
            TextSpan(
              text: S.of(context)?.termsOfService ?? 'Terms of Service',
              style: TextStyle(
                color: AppColors.textLink.withValues(alpha: 0.8),
              ),
            ),
            TextSpan(text: S.of(context)?.and ?? ' and '),
            TextSpan(
              text: S.of(context)?.privacyPolicy ?? 'Privacy Policy',
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

