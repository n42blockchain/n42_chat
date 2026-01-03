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

          const SizedBox(height: 8),

          // 服务
          _buildGroupCard(
            context,
            children: [
              _buildMenuItem(
                context,
                iconWidget: _buildServiceIcon(),
                title: '服务',
                onTap: () => _showComingSoon(context, '服务'),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 收藏、朋友圈、订单与卡包、表情
          _buildGroupCard(
            context,
            children: [
              _buildMenuItem(
                context,
                iconWidget: _buildFavoriteIcon(),
                title: '收藏',
                onTap: () => _openFavorites(context),
              ),
              _buildDivider(context),
              _buildMenuItem(
                context,
                iconWidget: _buildMomentsIcon(),
                title: '朋友圈',
                onTap: () => _showComingSoon(context, '朋友圈'),
              ),
              _buildDivider(context),
              _buildMenuItem(
                context,
                iconWidget: _buildOrderIcon(),
                title: '订单与卡包',
                onTap: () => _showComingSoon(context, '订单与卡包'),
              ),
              _buildDivider(context),
              _buildMenuItem(
                context,
                iconWidget: _buildEmojiIcon(),
                title: '表情',
                onTap: () => _showComingSoon(context, '表情'),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 设置
          _buildGroupCard(
            context,
            children: [
              _buildMenuItem(
                context,
                iconWidget: _buildSettingsIcon(),
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

  /// 服务图标 - 绿色勾选
  Widget _buildServiceIcon() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  /// 收藏图标 - 橙黄色立方体
  Widget _buildFavoriteIcon() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFFFF9F0A),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Icon(
          Icons.view_in_ar,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  /// 朋友圈图标 - 蓝色图片
  Widget _buildMomentsIcon() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFF007AFF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Icon(
          Icons.photo_library_outlined,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  /// 订单与卡包图标 - 橙红色表情
  Widget _buildOrderIcon() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B6B),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Icon(
          Icons.sentiment_satisfied_alt,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  /// 表情图标 - 黄色笑脸
  Widget _buildEmojiIcon() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFFFFCC00),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Icon(
          Icons.sentiment_very_satisfied,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  /// 设置图标 - 蓝色齿轮
  Widget _buildSettingsIcon() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFF5E97F6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Icon(
          Icons.settings,
          color: Colors.white,
          size: 18,
        ),
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
                // 头像 - 圆角矩形
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _avatarUrl != null && _avatarUrl!.isNotEmpty
                      ? Image.network(
                          _avatarUrl!,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildDefaultAvatar(),
                        )
                      : _buildDefaultAvatar(),
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
                          Container(
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
                                Icon(
                                  Icons.add,
                                  size: 14,
                                  color: subtitleColor,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  '状态',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: subtitleColor,
                                  ),
                                ),
                              ],
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

  Widget _buildDefaultAvatar() {
    return Container(
      width: 64,
      height: 64,
      color: AppColors.placeholder,
      child: Center(
        child: Text(
          (_displayName ?? 'U').substring(0, 1).toUpperCase(),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
    required Widget iconWidget,
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
              iconWidget,
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
