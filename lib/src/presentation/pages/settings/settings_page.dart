import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/user_profile_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 设置页面
class SettingsPage extends StatelessWidget {
  final UserProfileEntity? profile;
  final VoidCallback? onEditProfile;
  final VoidCallback? onNotification;
  final VoidCallback? onPrivacy;
  final VoidCallback? onAppearance;
  final VoidCallback? onChat;
  final VoidCallback? onAbout;
  final VoidCallback? onLogout;

  const SettingsPage({
    super.key,
    this.profile,
    this.onEditProfile,
    this.onNotification,
    this.onPrivacy,
    this.onAppearance,
    this.onChat,
    this.onAbout,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: S.of(context)?.settings ?? 'Settings',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          // 个人资料卡片
          if (profile != null) _buildProfileCard(context, isDark),

          const SizedBox(height: 16),

          // 设置组1：通知与隐私
          _SettingsGroup(
            children: [
              _SettingsItem(
                icon: Icons.notifications_outlined,
                iconColor: Colors.red,
                title: S.of(context)?.notificationSettings ?? 'Notifications',
                onTap: onNotification,
                isDark: isDark,
              ),
              _SettingsItem(
                icon: Icons.lock_outline,
                iconColor: Colors.blue,
                title: S.of(context)?.privacy ?? 'Privacy',
                onTap: onPrivacy,
                isDark: isDark,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 设置组2：外观与聊天
          _SettingsGroup(
            children: [
              _SettingsItem(
                icon: Icons.palette_outlined,
                iconColor: Colors.purple,
                title: S.of(context)?.appearance ?? 'Appearance',
                onTap: onAppearance,
                isDark: isDark,
              ),
              _SettingsItem(
                icon: Icons.chat_outlined,
                iconColor: Colors.green,
                title: S.of(context)?.chat ?? 'Chat',
                onTap: onChat,
                isDark: isDark,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 设置组3：关于
          _SettingsGroup(
            children: [
              _SettingsItem(
                icon: Icons.info_outline,
                iconColor: Colors.orange,
                title: S.of(context)?.about ?? 'About',
                onTap: onAbout,
                isDark: isDark,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // 退出登录按钮
          if (onLogout != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: N42Button.danger(
                text: S.of(context)?.logout ?? 'Log Out',
                onPressed: () => _showLogoutConfirmDialog(context),
              ),
            ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onEditProfile,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                N42Avatar(
                  imageUrl: profile!.avatarUrl,
                  name: profile!.effectiveDisplayName,
                  size: 64,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile!.effectiveDisplayName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profile!.userId,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                      if (profile!.statusMessage != null &&
                          profile!.statusMessage!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          profile!.statusMessage!,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context)?.logout ?? 'Log Out'),
        content: Text(S.of(context)?.logoutConfirm ?? 'Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onLogout?.call();
            },
            child: Text(
              S.of(context)?.logout ?? 'Log Out',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

/// 设置组
class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;

  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: List.generate(
          children.length * 2 - 1,
          (index) {
            if (index.isOdd) {
              return Padding(
                padding: const EdgeInsets.only(left: 56),
                child: Divider(
                  height: 1,
                  color: isDark ? AppColors.dividerDark : AppColors.divider,
                ),
              );
            }
            return children[index ~/ 2];
          },
        ),
      ),
    );
  }
}

/// 设置项
class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDark;

  const _SettingsItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              trailing ??
                  Icon(
                    Icons.chevron_right,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

