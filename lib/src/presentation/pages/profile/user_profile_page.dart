import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              text: '重试',
              onPressed: _loadUserProfile,
            ),
          ],
        ),
      );
    }

    if (_contact == null) {
      return const Center(child: Text('用户不存在'));
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
                            const SnackBar(content: Text('用户ID已复制')),
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
                    '个性签名',
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
            '状态',
            contact.isOnline
                ? '在线'
                : (contact.formattedLastActive.isNotEmpty
                    ? contact.formattedLastActive
                    : '离线'),
            isDark,
            statusColor: contact.isOnline ? AppColors.success : null,
          ),

          // 服务器
          _buildInfoTile(
            '服务器',
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
              text: '发消息',
              onPressed: _startChat,
              icon: Icons.chat_bubble_outline,
            ),
          ),

          const SizedBox(width: 16),

          // 语音/视频通话按钮（可选）
          Expanded(
            child: N42Button(
              text: '语音通话',
              type: N42ButtonType.secondary,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('语音通话功能开发中...')),
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
            title: const Text('设置备注'),
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
                  ? '移出黑名单'
                  : '加入黑名单',
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
            title: const Text('举报'),
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
          title: const Text('设置备注'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: '输入备注名',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('取消'),
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
                  SnackBar(content: Text(remark.isEmpty ? '已清除备注' : '备注已保存')),
                );
              },
              child: const Text('确定'),
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
      builder: (context) => AlertDialog(
        title: Text(isBlocked ? '移出黑名单' : '加入黑名单'),
        content: Text(isBlocked
            ? '确定将该用户移出黑名单吗？'
            : '加入黑名单后，你将不再收到对方的消息'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (isBlocked) {
                this.context.read<ContactBloc>().add(UnignoreUser(widget.userId));
              } else {
                this.context.read<ContactBloc>().add(IgnoreUser(widget.userId));
              }
            },
            child: Text(isBlocked ? '移出' : '加入'),
          ),
        ],
      ),
    );
  }

  void _report() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('举报功能开发中...')),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('分享名片'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('分享功能开发中...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('二维码'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('二维码功能开发中...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

