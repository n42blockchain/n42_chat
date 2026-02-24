import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/encryption/e2ee_manager.dart';
import '../../../core/encryption/key_backup_service.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/matrix_utils.dart' as mx_utils;
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/repositories/contact_repository.dart';
import '../../../n42_chat.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../widgets/common/common_widgets.dart';
import '../favorite/favorite_list_page.dart';
import '../qrcode/my_qrcode_page.dart';
import '../settings/change_email_page.dart';
import '../settings/change_password_page.dart';
import '../settings/language_settings_page.dart';
import '../settings/security_settings_page.dart';
import '../settings/settings_page.dart';
import 'nft_avatar_picker_page.dart';
import 'orders_and_cards_page.dart';
import 'profile_edit_page.dart';
import 'services_page.dart';
import 'status_page.dart';
import '../moment/moment_list_page.dart';
import '../sticker/sticker_store_page.dart';

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
  bool _isNftAvatar = false; // 头像是否来自 NFT

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
          final userId = client.userID;
          if (userId != null) {
            final profile = await client.getUserProfile(userId);
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
                _displayName = profile.displayname ?? _displayName;
                _avatarUrl = avatarHttpUrl;
              });
            }
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
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;
    final cardColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: widget.showAppBar ? N42AppBar(
        title: S.of(context)?.commonMe ?? 'Me',
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
                title: S.of(context)?.profileServices ?? 'Services',
                onTap: () => _openServices(context),
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
                title: S.of(context)?.commonFavorites ?? 'Favorites',
                onTap: () => _openFavorites(context),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                icon: Icons.photo_library_outlined,
                iconColor: const Color(0xFF007AFF),
                title: S.of(context)?.commonMoments ?? 'Moments',
                onTap: () => _openMoments(context),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                icon: Icons.card_giftcard_outlined,
                iconColor: const Color(0xFFFF6B6B),
                title: S.of(context)?.profileOrdersAndCards ?? 'Orders & Cards',
                onTap: () => _openOrdersAndCards(context),
              ),
              _buildDivider(context, isDark),
              _buildMenuItem(
                context,
                isDark: isDark,
                icon: Icons.emoji_emotions_outlined,
                iconColor: const Color(0xFFFFCC00),
                title: S.of(context)?.profileStickers ?? 'Stickers',
                onTap: () => _openStickers(context),
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
                title: S.of(context)?.commonSettings ?? 'Settings',
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
                // 头像 - 单独可点击，触发头像操作菜单
                GestureDetector(
                  onTap: () => _showAvatarOptions(context),
                  child: Stack(
                    children: [
                      N42Avatar(
                        imageUrl: _avatarUrl,
                        name: _displayName,
                        size: 64,
                        borderRadius: 6,
                      ),
                      // NFT 认证金色环标记
                      if (_isNftAvatar)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xFFFFD700),
                                width: 2.5,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // 用户信息
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 用户名
                      Text(
                        _displayName ?? (S.of(context)?.profileNotLoggedIn ?? 'Not Logged In'),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // N42号
                      Text(
                        S.of(context)?.profileN42IdLabel(n42Id) ?? 'N42 ID: $n42Id',
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
                              showDialog<void>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(S.of(context)?.profileClearStatus ?? 'Clear Status'),
                                  content: Text(S.of(context)?.profileClearStatusConfirm ?? 'Are you sure you want to clear your status?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        setState(() => _statusText = null);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(S.of(context)?.profileStatusCleared ?? 'Status cleared'),
                                            duration: const Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        S.of(context)?.commonClear ?? 'Clear',
                                        style: const TextStyle(color: AppColors.error),
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
                                    ? Colors.white.withValues(alpha: 0.1) 
                                    : Colors.black.withValues(alpha: 0.05),
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
                                    _statusText ?? (S.of(context)?.profileStatus ?? 'Status'),
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
      MaterialPageRoute<String>(
        builder: (_) => StatusPage(currentStatus: _statusText),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _statusText = result;
      });

      // 同步状态到服务器
      try {
        final contactRepository = getIt<IContactRepository>();
        await contactRepository.setMyStatus(result);
      } catch (e) {
        debugPrint('Failed to sync status: $e');
      }

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.profileStatusSetTo(result) ?? 'Status set to: $result'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  /// 显示头像操作菜单：更换头像 / 绑定 NFT 头像
  void _showAvatarOptions(BuildContext context) {
    final l10n = S.of(context);
    final isDark = context.isDarkMode;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 拖拽条
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 4),
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined, color: AppColors.primary),
                title: Text(l10n?.profileChangeAvatar ?? 'Change Avatar'),
                onTap: () {
                  Navigator.pop(ctx);
                  _openEditProfile(context);
                },
              ),
              Divider(height: 1, indent: 56, color: isDark ? AppColors.dividerDark : AppColors.divider),
              ListTile(
                leading: const Icon(Icons.verified_outlined, color: Color(0xFFFFD700)),
                title: Text(l10n?.profileBindNftAvatar ?? 'Bind NFT Avatar'),
                subtitle: Text(
                  _isNftAvatar
                      ? (l10n?.nftPickerTitle ?? 'NFT Avatar bound')
                      : 'Verified on-chain identity',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _bindNftAvatar(context);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  /// 打开 NFT 头像绑定页面
  void _bindNftAvatar(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => NftAvatarPickerPage(
          onConfirm: ({
            required String imageUrl,
            required String contractAddress,
            required int tokenId,
            required int chainId,
          }) {
            // 更新头像 URL 并标记为 NFT 来源
            setState(() {
              _avatarUrl = imageUrl;
              _isNftAvatar = true;
            });

            // 同步到 Matrix 用户资料
            _updateMatrixAvatar(imageUrl);

            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context)?.nftPickerUseAsAvatar ?? 'NFT Avatar applied'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
  }

  /// 将图片 URL 更新为 Matrix 头像
  Future<void> _updateMatrixAvatar(String imageUrl) async {
    try {
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;
      if (client != null && client.isLogged()) {
        await client.setAvatar(null);
        debugPrint('ProfilePage: Avatar updated to NFT image via $imageUrl');
      }
    } catch (e) {
      debugPrint('ProfilePage: Failed to update matrix avatar: $e');
    }
  }

  void _openEditProfile(BuildContext context) {
    // 获取当前的 AuthBloc
    final authBloc = context.read<AuthBloc>();
    
    Navigator.of(context).push(
      MaterialPageRoute<void>(
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
      MaterialPageRoute<void>(builder: (_) => const MyQRCodePage()),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SettingsPage(
          onSecurity: () {
            final client = MatrixClientManager.instance.client;
            if (client == null) return;

            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => SecuritySettingsPage(
                  e2eeManager: E2EEManager(client),
                  keyBackupService: KeyBackupService(client),
                ),
              ),
            );
          },
          onChangePassword: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => BlocProvider.value(
                  value: N42Chat.authBloc,
                  child: const ChangePasswordPage(),
                ),
              ),
            );
          },
          onChangeEmail: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => BlocProvider.value(
                  value: N42Chat.authBloc,
                  child: const ChangeEmailPage(),
                ),
              ),
            );
          },
          onLanguage: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const LanguageSettingsPage(),
              ),
            );
          },
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
        title: Text(S.of(context)?.commonLogout ?? 'Log Out'),
        content: Text(S.of(context)?.commonLogoutConfirm ?? 'Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthBloc>().add(const AuthLogoutRequested());
            },
            child: Text(S.of(context)?.commonLogout ?? 'Log Out', style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _openFavorites(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const FavoriteListPage()),
    );
  }

  void _openServices(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ServicesPage()),
    );
  }

  void _openMoments(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const MomentListPage()),
    );
  }

  void _openOrdersAndCards(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const OrdersAndCardsPage()),
    );
  }

  void _openStickers(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const StickerStorePage()),
    );
  }

}
