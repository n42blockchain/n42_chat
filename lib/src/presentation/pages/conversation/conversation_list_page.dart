import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../blocs/conversation/conversation_event.dart';
import '../../blocs/conversation/conversation_state.dart';
import '../../blocs/group/group_bloc.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/animations/fade_animation.dart';
import '../contact/add_friend_page.dart';
import '../group/create_group_page.dart';
import 'conversation_tile.dart';

/// 会话列表页面
class ConversationListPage extends StatefulWidget {
  /// 点击会话回调
  final void Function(ConversationEntity conversation)? onConversationTap;

  /// 添加按钮点击回调
  final VoidCallback? onAddPressed;

  /// 搜索点击回调
  final VoidCallback? onSearchTap;

  const ConversationListPage({
    super.key,
    this.onConversationTap,
    this.onAddPressed,
    this.onSearchTap,
  });

  @override
  State<ConversationListPage> createState() => _ConversationListPageState();
}

class _ConversationListPageState extends State<ConversationListPage> {
  @override
  void initState() {
    super.initState();
    // 加载并订阅会话列表
    context.read<ConversationBloc>()
      ..add(const LoadConversations())
      ..add(const SubscribeConversations());
  }

  @override
  void dispose() {
    // 取消订阅
    context.read<ConversationBloc>().add(const UnsubscribeConversations());
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<ConversationBloc>().add(const RefreshConversations());
    // 等待刷新完成
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void _onConversationTap(ConversationEntity conversation) {
    // 标记已读
    context
        .read<ConversationBloc>()
        .add(MarkConversationAsRead(conversation.id));

    widget.onConversationTap?.call(conversation);
  }

  void _onConversationLongPress(
      BuildContext context, ConversationEntity conversation) {
    _showConversationMenu(context, conversation);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: _buildAppBar(isDark),
      body: Column(
        children: [
          // 搜索栏
          N42SearchBarContainer(
            child: N42SearchBar(
              hintText: '搜索',
              onTap: widget.onSearchTap,
            ),
          ),

          // 会话列表
          Expanded(
            child: BlocConsumer<ConversationBloc, ConversationState>(
              listener: (context, state) {
                // 处理新建会话导航
                if (state.newConversationId != null) {
                  final conversation = state.conversations.firstWhere(
                    (c) => c.id == state.newConversationId,
                    orElse: () => state.conversations.first,
                  );
                  widget.onConversationTap?.call(conversation);
                }

                // 显示错误
                if (state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error!),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.isLoading) {
                  return const N42Loading(message: '加载中...');
                }

                if (state.isEmpty) {
                  return N42EmptyState.noData(
                    title: '暂无会话',
                    description: '点击右上角开始聊天',
                  );
                }

                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: AppColors.primary,
                  child: _buildConversationList(state, isDark),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDark) {
    return N42AppBar(
      title: '消息',
      showBackButton: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: widget.onAddPressed ?? _showAddMenu,
        ),
      ],
    );
  }

  Widget _buildConversationList(ConversationState state, bool isDark) {
    return CustomScrollView(
      slivers: [
        // 置顶会话
        if (state.pinnedConversations.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Container(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              child: Column(
                children: state.pinnedConversations.asMap().entries.map((entry) {
                  return ListItemAnimation(
                    index: entry.key,
                    child: ConversationTile(
                      conversation: entry.value,
                      onTap: () => _onConversationTap(entry.value),
                      onLongPress: () =>
                          _onConversationLongPress(context, entry.value),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // 分隔
          SliverToBoxAdapter(
            child: Container(
              height: 8,
              color: isDark ? AppColors.backgroundDark : AppColors.background,
            ),
          ),
        ],

        // 普通会话
        SliverToBoxAdapter(
          child: Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            child: Column(
              children: state.normalConversations.asMap().entries.map((entry) {
                return ListItemAnimation(
                  index: entry.key,
                  child: ConversationTile(
                    conversation: entry.value,
                    onTap: () => _onConversationTap(entry.value),
                    onLongPress: () =>
                        _onConversationLongPress(context, entry.value),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AddMenuSheet(
        onCreateGroup: () => _navigateToCreateGroup(ctx),
        onAddFriend: () => _navigateToAddFriend(ctx),
        onScanQR: () {
          Navigator.pop(ctx);
          _showScanQRNotAvailable();
        },
      ),
    );
  }

  void _navigateToCreateGroup(BuildContext sheetContext) {
    Navigator.pop(sheetContext);
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<GroupBloc>()),
            BlocProvider(create: (_) => getIt<ContactBloc>()),
          ],
          child: const CreateGroupPage(),
        ),
      ),
    ).then((roomId) {
      if (roomId != null && roomId is String) {
        // 刷新会话列表
        context.read<ConversationBloc>().add(const RefreshConversations());
      }
    });
  }

  void _navigateToAddFriend(BuildContext sheetContext) {
    Navigator.pop(sheetContext);
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AddFriendPage(),
      ),
    ).then((roomId) {
      if (roomId != null && roomId is String) {
        // 刷新会话列表
        context.read<ConversationBloc>().add(const RefreshConversations());
      }
    });
  }

  void _showScanQRNotAvailable() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('扫一扫功能即将推出'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showConversationMenu(
      BuildContext context, ConversationEntity conversation) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _ConversationMenuSheet(
        conversation: conversation,
        onMarkAsRead: () {
          Navigator.pop(ctx);
          context
              .read<ConversationBloc>()
              .add(MarkConversationAsRead(conversation.id));
        },
        onToggleMute: () {
          Navigator.pop(ctx);
          context.read<ConversationBloc>().add(SetConversationMuted(
                conversationId: conversation.id,
                muted: !conversation.isMuted,
              ));
        },
        onTogglePin: () {
          Navigator.pop(ctx);
          context.read<ConversationBloc>().add(SetConversationPinned(
                conversationId: conversation.id,
                pinned: !conversation.isPinned,
              ));
        },
        onDelete: () {
          Navigator.pop(ctx);
          _confirmDeleteConversation(conversation);
        },
      ),
    );
  }

  void _confirmDeleteConversation(ConversationEntity conversation) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除会话'),
        content: Text('确定要删除与"${conversation.name}"的会话吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<ConversationBloc>()
                  .add(DeleteConversation(conversation.id));
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}

/// 添加菜单
class _AddMenuSheet extends StatelessWidget {
  final VoidCallback? onCreateGroup;
  final VoidCallback? onAddFriend;
  final VoidCallback? onScanQR;

  const _AddMenuSheet({
    this.onCreateGroup,
    this.onAddFriend,
    this.onScanQR,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 拖动指示器
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // 菜单项
            _buildMenuItem(
              context,
              icon: Icons.group_add,
              title: '发起群聊',
              onTap: onCreateGroup,
            ),
            _buildMenuItem(
              context,
              icon: Icons.person_add,
              title: '添加好友',
              onTap: onAddFriend,
            ),
            _buildMenuItem(
              context,
              icon: Icons.qr_code_scanner,
              title: '扫一扫',
              onTap: onScanQR,
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
    );
  }
}

/// 会话操作菜单
class _ConversationMenuSheet extends StatelessWidget {
  final ConversationEntity conversation;
  final VoidCallback? onMarkAsRead;
  final VoidCallback? onToggleMute;
  final VoidCallback? onTogglePin;
  final VoidCallback? onDelete;

  const _ConversationMenuSheet({
    required this.conversation,
    this.onMarkAsRead,
    this.onToggleMute,
    this.onTogglePin,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 拖动指示器
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // 标记已读
            if (conversation.unreadCount > 0)
              _buildMenuItem(
                context,
                icon: Icons.done_all,
                title: '标记已读',
                onTap: onMarkAsRead,
              ),

            // 免打扰
            _buildMenuItem(
              context,
              icon: conversation.isMuted
                  ? Icons.notifications_active
                  : Icons.notifications_off,
              title: conversation.isMuted ? '取消免打扰' : '消息免打扰',
              onTap: onToggleMute,
            ),

            // 置顶
            _buildMenuItem(
              context,
              icon: conversation.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
              title: conversation.isPinned ? '取消置顶' : '置顶',
              onTap: onTogglePin,
            ),

            // 删除
            _buildMenuItem(
              context,
              icon: Icons.delete_outline,
              title: '删除会话',
              color: AppColors.error,
              onTap: onDelete,
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Color? color,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = color ??
        (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary);

    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textSecondary),
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: onTap,
    );
  }
}

