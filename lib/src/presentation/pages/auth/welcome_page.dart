import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 欢迎页面
///
/// 首次打开应用显示的欢迎/引导页面
class WelcomePage extends StatelessWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onRegister;

  const WelcomePage({
    super.key,
    this.onLogin,
    this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Logo和标题
              _buildHeader(),

              const Spacer(flex: 3),

              // 特性列表
              _buildFeatures(),

              const Spacer(flex: 2),

              // 按钮
              _buildButtons(context),

              const SizedBox(height: 32),

              // 协议
              _buildAgreement(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primaryLight,
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.chat_bubble_rounded,
            color: Colors.white,
            size: 50,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'N42 Chat',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '安全、去中心化的即时通讯',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures() {
    return const Column(
      children: [
        _FeatureItem(
          icon: Icons.security,
          title: '端对端加密',
          description: '消息仅你和对方可见',
        ),
        SizedBox(height: 20),
        _FeatureItem(
          icon: Icons.public,
          title: '去中心化',
          description: '基于Matrix开放协议',
        ),
        SizedBox(height: 20),
        _FeatureItem(
          icon: Icons.account_balance_wallet,
          title: '钱包集成',
          description: '轻松进行加密货币转账',
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        // 登录按钮
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: onLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
            ),
            child: const Text(
              '登录',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // 注册按钮
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: onRegister,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              '注册',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAgreement() {
    return Text.rich(
      TextSpan(
        text: '登录即表示同意',
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.textTertiary,
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
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

