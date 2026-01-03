import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/matrix_utils.dart' as mx_utils;
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../widgets/common/common_widgets.dart';
import '../favorite/favorite_list_page.dart';
import '../qrcode/my_qrcode_page.dart';
import '../settings/settings_page.dart';
import 'profile_edit_page.dart';
import 'status_page.dart';

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
  String? _statusText; // 当前状态

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
            final avatarHttpUrl = mx_utils.MatrixUtils.mxcToHttp(
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
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
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

          const SizedBox(height: 8),

          // 服务
          _buildGroupCard(
            context,
            isDark,
            children: [
              _buildMenuItem(
                context,
                isDark: isDark,
                icon: Icons.verified_outlined,
                iconColor: AppColors.primary,
                title: '服务',
                onTap: () => _showComingSoon(context, '服务'),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 收藏、朋友圈、订单与卡包、表情
          _buildGroupCard(
            context,
            isDark,
            children: [
              _buildMenuItem(
                context,
                isDark: isDark,
                icon: Icons.inventory_2_outlined,
                iconColor: const Color(0xFFFF9F0A),
                title: '收藏',
                onTap: () => _openFavorites(context),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                icon: Icons.photo_library_outlined,
                iconColor: const Color(0xFF007AFF),
                title: '朋友圈',
                onTap: () => _showComingSoon(context, '朋友圈'),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                icon: Icons.card_giftcard_outlined,
                iconColor: const Color(0xFFFF6B6B),
                title: '订单与卡包',
                onTap: () => _showComingSoon(context, '订单与卡包'),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                icon: Icons.emoji_emotions_outlined,
                iconColor: const Color(0xFFFFCC00),
                title: '表情',
                onTap: () => _showComingSoon(context, '表情'),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 设置
          _buildGroupCard(
            context,
            isDark,
            children: [
              _buildMenuItem(
                context,
                isDark: isDark,
                icon: Icons.settings_outlined,
                iconColor: const Color(0xFF5E97F6),
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
    final n42Id = _userId?.split(':').first.replaceFirst('@', '') ?? '--';
    
    return Container(
      color: cardColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _openEditProfile(context),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 头像 - 使用 N42Avatar 组件
                N42Avatar(
                  imageUrl: _avatarUrl,
                  name: _displayName,
                  size: 64,
                  borderRadius: 6,
                ),
                const SizedBox(width: 16),
                // 用户信息
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 用户名
                      Text(
                        _displayName ?? '未登录',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // N42号
                      Text(
                        'N42号：$n42Id',
                        style: TextStyle(
                          fontSize: 15,
                          color: subtitleColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // 状态和好友
                      Row(
                        children: [
                          // + 状态 按钮
                          GestureDetector(
                            onTap: () => _showStatusPicker(context, isDark),
                            onLongPress: _statusText != null ? () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('清除状态'),
                                  content: const Text('确定要清除当前状态吗？'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text('取消'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        setState(() => _statusText = null);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('状态已清除'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        '清除',
                                        style: TextStyle(color: AppColors.error),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } : null,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isDark 
                                    ? Colors.white.withOpacity(0.1) 
                                    : Colors.black.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_statusText == null) ...[
                                    Icon(
                                      Icons.add,
                                      size: 14,
                                      color: subtitleColor,
                                    ),
                                    const SizedBox(width: 2),
                                  ],
                                  Text(
                                    _statusText ?? '状态',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: subtitleColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 右侧二维码图标和箭头
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => _openMyQRCode(context),
                      child: Icon(
                        Icons.qr_code_2,
                        size: 20,
                        color: subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Icon(
                      Icons.chevron_right,
                      color: subtitleColor,
                      size: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, bool isDark, {required List<Widget> children}) {
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
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    String? badge,
    VoidCallback? onTap,
  }) {
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // 透明背景的图标
              SizedBox(
                width: 28,
                height: 28,
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
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

  Widget _buildDivider(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 58),
      child: Divider(
        height: 1,
        color: isDark ? AppColors.dividerDark : AppColors.divider,
      ),
    );
  }

  /// 显示状态选择器
  void _showStatusPicker(BuildContext context, bool isDark) async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => StatusPage(currentStatus: _statusText),
      ),
    );
    
    if (result != null && mounted) {
      setState(() {
        _statusText = result;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('状态已设置为：$result'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
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

  void _openFavorites(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const FavoriteListPage()),
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
