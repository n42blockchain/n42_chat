import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_event.dart';
import '../../blocs/contact/contact_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 用户资料页面
class UserProfilePage extends StatefulWidget {
  final String userId;

  const UserProfilePage({
    super.key,
    required this.userId,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  ContactEntity? _contact;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // 从BLoC状态中获取联系人信息，或者直接从仓库加载
      final bloc = context.read<ContactBloc>();
      final state = bloc.state;

      if (state is ContactLoaded) {
        // 首先从本地联系人中查找
        final contact = state.contacts.cast<ContactEntity?>().firstWhere(
          (c) => c?.userId == widget.userId,
          orElse: () => null,
        );

        if (contact != null) {
          setState(() {
            _contact = contact;
            _isLoading = false;
          });
          return;
        }
      }

      // 如果本地没有，则需要从仓库获取
      // 这里简化处理，创建一个基本的ContactEntity
      setState(() {
        _contact = ContactEntity(
          userId: widget.userId,
          displayName: widget.userId.split(':').first.replaceFirst('@', ''),
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ChatStarted && state.userId == widget.userId) {
            // 导航到聊天页面
            Navigator.of(context).pushReplacementNamed('/chat/${state.roomId}');
          } else if (state is ContactError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: _buildBody(isDark),
      ),
    );
  }

  Widget _buildBody(bool isDark) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!, style: TextStyle(color: AppColors.error)),
            const SizedBox(height: 16),
            N42Button(
              text: S.of(context)?.retry ?? 'Retry',
              onPressed: _loadUserProfile,
            ),
          ],
        ),
      );
    }

    if (_contact == null) {
      return Center(child: Text(S.of(context)?.userNotExist ?? 'User does not exist'));
    }

    return CustomScrollView(
      slivers: [
        // 个人资料头部
        SliverToBoxAdapter(
          child: _buildProfileHeader(isDark),
        ),

        // 信息区块
        SliverToBoxAdapter(
          child: _buildInfoSection(isDark),
        ),

        // 操作按钮
        SliverToBoxAdapter(
          child: _buildActionButtons(isDark),
        ),

        // 更多选项
        SliverToBoxAdapter(
          child: _buildMoreOptions(isDark),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(bool isDark) {
    final contact = _contact!;

    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: [
          // 顶部返回栏
          SafeArea(
            bottom: false,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                    onPressed: _showMoreOptions,
                  ),
                ],
              ),
            ),
          ),

          // 头像和基本信息
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // 大头像
                Stack(
                  children: [
                    N42Avatar(
                      imageUrl: contact.avatarUrl,
                      name: contact.effectiveDisplayName,
                      size: 64,
                    ),
                    if (contact.isOnline)
                      Positioned(
                        right: 2,
                        bottom: 2,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark ? AppColors.surfaceDark : AppColors.surface,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(width: 16),

                // 名称和用户名
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.effectiveDisplayName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: contact.userId));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(S.of(context)?.userIdCopied ?? 'User ID copied')),
                          );
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                contact.userId,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.copy,
                              size: 14,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(bool isDark) {
    final contact = _contact!;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 状态消息
          if (contact.statusMessage?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context)?.bio ?? 'Bio',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    contact.statusMessage!,
                    style: TextStyle(
                      fontSize: 15,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

          // 在线状态
          _buildInfoTile(
            S.of(context)?.status ?? 'Status',
            contact.isOnline
                ? (S.of(context)?.online ?? 'Online')
                : (contact.formattedLastActive.isNotEmpty
                    ? contact.formattedLastActive
                    : (S.of(context)?.offline ?? 'Offline')),
            isDark,
            statusColor: contact.isOnline ? AppColors.success : null,
          ),

          // 服务器
          _buildInfoTile(
            S.of(context)?.homeServer ?? 'Server',
            contact.server,
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, bool isDark,
      {Color? statusColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          if (statusColor != null)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isDark) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(20),
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Row(
        children: [
          // 发消息按钮
          Expanded(
            child: N42Button(
              text: S.of(context)?.sendMessage ?? 'Message',
              onPressed: _startChat,
              icon: Icons.chat_bubble_outline,
            ),
          ),

          const SizedBox(width: 16),

          // 语音/视频通话按钮（可选）
          Expanded(
            child: N42Button(
              text: S.of(context)?.voiceCall ?? 'Voice Call',
              type: N42ButtonType.secondary,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context)?.voiceCallFeatureInDev ?? 'Voice call feature in development...')),
                );
              },
              icon: Icons.call_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreOptions(bool isDark) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: [
          // 设置备注
          ListTile(
            title: Text(S.of(context)?.setRemark ?? 'Set remark'),
            trailing: Icon(
              Icons.chevron_right,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
            onTap: _setRemark,
          ),

          Divider(
            height: 1,
            indent: 16,
            color: isDark ? AppColors.dividerDark : AppColors.divider,
          ),

          // 加入黑名单
          ListTile(
            title: Text(
              context.read<ContactBloc>().state is ContactLoaded &&
                      (context.read<ContactBloc>().state as ContactLoaded)
                          .contacts
                          .any((c) => c.userId == widget.userId && c.isBlocked)
                  ? (S.of(context)?.removeFromBlacklist ?? 'Remove from Blacklist')
                  : (S.of(context)?.addToBlacklist ?? 'Add to Blacklist'),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
            onTap: _toggleBlock,
          ),

          Divider(
            height: 1,
            indent: 16,
            color: isDark ? AppColors.dividerDark : AppColors.divider,
          ),

          // 举报
          ListTile(
            title: Text(S.of(context)?.report ?? 'Report'),
            trailing: Icon(
              Icons.chevron_right,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
            onTap: _report,
          ),
        ],
      ),
    );
  }

  void _startChat() {
    context.read<ContactBloc>().add(StartChat(widget.userId));
  }

  void _setRemark() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final controller = TextEditingController(text: _contact?.remark);
        return AlertDialog(
          title: Text(S.of(context)?.setRemark ?? 'Set remark'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: S.of(context)?.enterRemark ?? 'Enter remark',
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(S.of(context)?.cancel ?? 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                final remark = controller.text.trim();
                Navigator.pop(dialogContext);

                // 保存备注
                context.read<ContactBloc>().add(SetContactRemark(
                  widget.userId,
                  remark.isEmpty ? null : remark,
                ));

                // 更新本地状态
                setState(() {
                  _contact = _contact?.copyWith(remark: remark.isEmpty ? null : remark);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(remark.isEmpty
                      ? (S.of(context)?.remarkCleared ?? 'Remark cleared')
                      : (S.of(context)?.remarkSaved ?? 'Remark saved'))),
                );
              },
              child: Text(S.of(context)?.confirm ?? 'Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _toggleBlock() {
    final isBlocked = context.read<ContactBloc>().state is ContactLoaded &&
        (context.read<ContactBloc>().state as ContactLoaded)
            .contacts
            .any((c) => c.userId == widget.userId && c.isBlocked);

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isBlocked
            ? (S.of(context)?.removeFromBlacklist ?? 'Remove from Blacklist')
            : (S.of(context)?.addToBlacklist ?? 'Add to Blacklist')),
        content: Text(isBlocked
            ? (S.of(context)?.confirmRemoveBlacklist ?? 'Are you sure you want to remove this user from blacklist?')
            : (S.of(context)?.confirmAddBlacklist ?? 'Are you sure you want to add this user to blacklist? You will not receive messages from them.')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              if (isBlocked) {
                context.read<ContactBloc>().add(UnignoreUser(widget.userId));
              } else {
                context.read<ContactBloc>().add(IgnoreUser(widget.userId));
              }
            },
            child: Text(isBlocked
                ? (S.of(context)?.remove ?? 'Remove')
                : (S.of(context)?.add ?? 'Add')),
          ),
        ],
      ),
    );
  }

  void _report() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context)?.reportFeatureInDev ?? 'Report feature in development...')),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: Text(S.of(context)?.shareContactCard ?? 'Share Contact Card'),
              onTap: () {
                Navigator.pop(sheetContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context)?.shareFeatureInDev ?? 'Share feature in development...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: Text(S.of(context)?.qrCode ?? 'QR Code'),
              onTap: () {
                Navigator.pop(sheetContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context)?.qrCodeFeatureInDev ?? 'QR code feature in development...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

