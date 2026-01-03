/// 邮箱验证码登录页面
///
/// 通过邮箱接收验证码进行登录或密码重置
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../core/theme/app_colors.dart';
import '../../../services/auth/auth_methods_service.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';

/// 邮箱验证码页面
class EmailOtpPage extends StatefulWidget {
  final String homeserver;
  
  const EmailOtpPage({
    super.key,
    required this.homeserver,
  });

  @override
  State<EmailOtpPage> createState() => _EmailOtpPageState();
}

class _EmailOtpPageState extends State<EmailOtpPage> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _pinputFocusNode = FocusNode();
  
  bool _isEmailSent = false;
  bool _isSending = false;
  bool _isVerifying = false;
  int _resendCountdown = 0;
  Timer? _countdownTimer;
  
  final AuthMethodsService _authService = AuthMethodsService();

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _pinputFocusNode.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _resendCountdown = 60;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  Future<void> _sendOtp() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请输入有效的邮箱地址'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isSending = true;
    });

    try {
      final success = await _authService.requestEmailOtp(
        email: email,
        homeserver: widget.homeserver,
      );
      
      if (success && mounted) {
        setState(() {
          _isEmailSent = true;
          _isSending = false;
        });
        _startCountdown();
        _pinputFocusNode.requestFocus();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('验证码已发送到 $email'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('发送验证码失败: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _verifyOtp(String otp) async {
    if (otp.length < 6) return;
    
    setState(() {
      _isVerifying = true;
    });

    try {
      final result = await _authService.verifyEmailOtp(
        email: _emailController.text.trim(),
        otp: otp,
        homeserver: widget.homeserver,
      );
      
      if (result != null && result['verified'] == true && mounted) {
        // 验证成功，进行登录
        // 这里需要根据服务端返回的 session 进行实际登录
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('验证成功'),
            backgroundColor: AppColors.success,
          ),
        );
        
        // 返回登录页面或直接登录
        Navigator.of(context).pop(result);
      } else {
        throw Exception('验证失败');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
        _otpController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('验证码错误: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
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
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '邮箱验证',
          style: TextStyle(
            color: textColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            
            // 图标
            _buildIcon(isDark),
            
            const SizedBox(height: 32),
            
            // 说明文字
            _buildDescription(isDark),
            
            const SizedBox(height: 40),
            
            // 邮箱输入或验证码输入
            if (!_isEmailSent)
              _buildEmailInput(isDark)
            else
              _buildOtpInput(isDark),
            
            const SizedBox(height: 32),
            
            // 按钮
            if (!_isEmailSent)
              _buildSendButton()
            else
              _buildResendButton(),
            
            const SizedBox(height: 24),
            
            // 其他选项
            if (_isEmailSent) _buildBackToEmail(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(bool isDark) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.email_outlined,
        color: AppColors.primary,
        size: 40,
      ),
    );
  }

  Widget _buildDescription(bool isDark) {
    final textColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    
    return Column(
      children: [
        Text(
          _isEmailSent ? '输入验证码' : '输入邮箱',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          _isEmailSent
              ? '我们已向 ${_emailController.text} 发送了\n6位验证码'
              : '输入您的邮箱地址，我们将发送验证码',
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailInput(bool isDark) {
    final inputBgColor = isDark ? AppColors.surfaceDark : AppColors.inputBackground;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final hintColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return TextFormField(
      controller: _emailController,
      style: TextStyle(color: textColor, fontSize: 16),
      decoration: InputDecoration(
        hintText: 'example@email.com',
        hintStyle: TextStyle(color: hintColor),
        filled: true,
        fillColor: inputBgColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        prefixIcon: Icon(Icons.email_outlined, color: hintColor),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _sendOtp(),
    );
  }

  Widget _buildOtpInput(bool isDark) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.black12,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColors.primary.withOpacity(0.1),
        border: Border.all(color: AppColors.primary),
      ),
    );

    return Pinput(
      length: 6,
      controller: _otpController,
      focusNode: _pinputFocusNode,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      showCursor: true,
      cursor: Container(
        width: 2,
        height: 24,
        color: AppColors.primary,
      ),
      onCompleted: _verifyOtp,
      enabled: !_isVerifying,
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: _isSending ? null : _sendOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isSending
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                '发送验证码',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildResendButton() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canResend = _resendCountdown == 0 && !_isVerifying;

    return Column(
      children: [
        if (_isVerifying)
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          )
        else
          TextButton(
            onPressed: canResend ? _sendOtp : null,
            child: Text(
              canResend
                  ? '重新发送验证码'
                  : '${_resendCountdown}秒后可重新发送',
              style: TextStyle(
                fontSize: 14,
                color: canResend
                    ? AppColors.textLink
                    : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBackToEmail() {
    return TextButton(
      onPressed: () {
        setState(() {
          _isEmailSent = false;
          _otpController.clear();
        });
      },
      child: const Text(
        '更换邮箱',
        style: TextStyle(
          fontSize: 14,
          color: AppColors.textLink,
        ),
      ),
    );
  }
}

