import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/matrix_utils.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../widgets/common/common_widgets.dart';
import '../qrcode/my_qrcode_page.dart';
import '../settings/settings_page.dart';
import 'profile_edit_page.dart';

/// 我的页面
class ProfilePage extends StatefulWidget {
  /// 是否显示 AppBar（嵌入到主框架时可设为 false）
  final bool showAppBar;
  
  const ProfilePage({
    super.key,
    this.showAppBar = true,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _userId;
  String? _displayName;
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;

      if (client != null && client.isLogged()) {
        setState(() {
          _userId = client.userID;
          _displayName = client.userID?.split(':').first.replaceFirst('@', '') ?? 'User';
        });
        
        // 异步获取头像
        try {
          final profile = await client.ownProfile;
          if (mounted) {
            // 将 mxc:// URL 转换为 HTTP URL
            final avatarMxc = profile.avatarUrl?.toString();
            final avatarHttpUrl = MatrixUtils.mxcToHttp(
              avatarMxc,
              client: client,
              width: 128,
              height: 128,
            );
            setState(() {
              _displayName = profile.displayName ?? _displayName;
              _avatarUrl = avatarHttpUrl;
            });
          }
        } catch (e) {
          debugPrint('Failed to get avatar: $e');
        }
      }
    } catch (e) {
      debugPrint('Failed to load user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;
    final cardColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? Colors.white : AppColors.textPrimary;
    final subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: widget.showAppBar ? N42AppBar(
        title: '我',
        showBackButton: false,
      ) : null,
      body: ListView(
        children: [
          // 个人资料卡片
          _buildProfileCard(context, isDark, cardColor, textColor, subtitleColor),

          const SizedBox(height: 12),

          // 服务
          _buildGroupCard(
            context,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.account_balance_wallet_rounded,
                iconColor: const Color(0xFF07C160),
                title: '服务',
                onTap: () => _showComingSoon(context, '服务'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 收藏、朋友圈等
          _buildGroupCard(
            context,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.star_rounded,
                iconColor: const Color(0xFFFF9500),
                title: '收藏',
                onTap: () => _showComingSoon(context, '收藏'),
              ),
              _buildDivider(context),
              _buildMenuItem(
                context,
                icon: Icons.photo_library_rounded,
                iconColor: const Color(0xFF3D7EFF),
                title: '朋友圈',
                onTap: () => _showComingSoon(context, '朋友圈'),
              ),
              _buildDivider(context),
              _buildMenuItem(
                context,
                icon: Icons.video_library_rounded,
                iconColor: const Color(0xFFFF3B30),
                title: '视频号',
                onTap: () => _showComingSoon(context, '视频号'),
              ),
              _buildDivider(context),
              _buildMenuItem(
                context,
                icon: Icons.emoji_emotions_rounded,
                iconColor: const Color(0xFFFF9500),
                title: '表情',
                onTap: () => _showComingSoon(context, '表情'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 设置
          _buildGroupCard(
            context,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.settings_rounded,
                iconColor: const Color(0xFF5856D6),
                title: '设置',
                onTap: () => _openSettings(context),
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    bool isDark,
    Color cardColor,
    Color textColor,
    Color subtitleColor,
  ) {
    return Container(
      color: cardColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _openEditProfile(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // 头像
                N42Avatar(
                  imageUrl: _avatarUrl,
                  name: _displayName ?? 'U',
                  size: 64,
                ),
                const SizedBox(width: 16),
                // 名字和ID
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayName ?? '未登录',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            'ID: ${_userId?.split(':').first.replaceFirst('@', '') ?? '--'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: subtitleColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // 二维码图标
                          GestureDetector(
                            onTap: () => _openMyQRCode(context),
                            child: Icon(
                              Icons.qr_code,
                              size: 16,
                              color: subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: subtitleColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, {required List<Widget> children}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    String? badge,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              Icon(
                Icons.chevron_right,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 58),
      child: Divider(
        height: 1,
        color: isDark ? AppColors.dividerDark : AppColors.divider,
      ),
    );
  }

  void _openEditProfile(BuildContext context) {
    // 获取当前的 AuthBloc
    final authBloc = context.read<AuthBloc>();
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: authBloc,
          child: const ProfileEditPage(),
        ),
      ),
    ).then((_) {
      // 返回后刷新用户信息
      _loadUserInfo();
    });
  }

  void _openMyQRCode(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const MyQRCodePage()),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsPage(
          onLogout: () {
            Navigator.of(context).pop();
            _logout(context);
          },
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('退出登录'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthBloc>().add(const AuthLogoutRequested());
            },
            child: const Text('退出', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature 功能即将推出'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

