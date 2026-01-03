import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  bool _rememberMe = true;

  @override
  void dispose() {
    _homeserverController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(AuthLoginRequested(
            homeserver: _homeserverController.text.trim(),
            username: _usernameController.text.trim(),
            password: _passwordController.text,
            rememberMe: _rememberMe,
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
          '登录',
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
                content: Text(state.errorMessage ?? '登录失败'),
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

                  const SizedBox(height: 16),

                  // 记住登录
                  _buildRememberMe(isDarkMode),

                  const SizedBox(height: 32),

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
          '安全、去中心化的即时通讯',
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
          '服务器地址',
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
              return '请输入服务器地址';
            }
            if (!value.startsWith('http://') && !value.startsWith('https://')) {
              return '请输入有效的服务器地址';
            }
            return null;
          },
        ),
        if (state.isHomeserverValid && state.homeserverInfo != null) ...[
          const SizedBox(height: 4),
          Text(
            '✓ 已连接到 ${state.homeserverInfo!.serverName}',
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
          '用户名',
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
            hintText: '请输入用户名',
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
              return '请输入用户名';
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
          '密码',
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
            hintText: '请输入密码',
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
              return '请输入密码';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRememberMe(bool isDark) {
    final textColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _rememberMe,
            onChanged: (value) {
              setState(() {
                _rememberMe = value ?? true;
              });
            },
            activeColor: AppColors.primary,
            checkColor: Colors.white,
            side: BorderSide(color: textColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              _rememberMe = !_rememberMe;
            });
          },
          child: Text(
            '记住登录状态',
            style: TextStyle(
              fontSize: 14,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

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
            : const Text(
                '登录',
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
              child: const Text(
                '注册账号',
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
              child: const Text(
                '忘记密码',
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
            '其他登录方式',
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
              label: '邮箱验证码',
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
        const SnackBar(
          content: Text('请先输入服务器地址'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    
    // TODO: 实现真正的 Passkey 登录
    // 目前显示提示
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Passkey 登录需要服务端支持'),
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
        const SnackBar(
          content: Text('请先输入服务器地址'),
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
        const SnackBar(
          content: Text('请先输入服务器地址'),
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
        const SnackBar(
          content: Text('请先输入服务器地址'),
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
          text: '登录即表示同意',
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
          children: [
            TextSpan(
              text: '《服务协议》',
              style: TextStyle(
                color: AppColors.textLink.withValues(alpha: 0.8),
              ),
            ),
            const TextSpan(text: '和'),
            TextSpan(
              text: '《隐私政策》',
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

