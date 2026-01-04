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
import '../qrcode/scan_qr_page.dart';
import 'conversation_tile.dart';

/// 会话列表页面（仿微信）
class ConversationListPage extends StatefulWidget {
  /// 点击会话回调
  final void Function(ConversationEntity conversation)? onConversationTap;

  /// 添加按钮点击回调
  final VoidCallback? onAddPressed;

  /// 搜索点击回调
  final VoidCallback? onSearchTap;

  /// 是否显示 AppBar（嵌入到主框架时可设为 false）
  final bool showAppBar;

  const ConversationListPage({
    super.key,
    this.onConversationTap,
    this.onAddPressed,
    this.onSearchTap,
    this.showAppBar = true,
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
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: widget.showAppBar ? _buildAppBar(isDark) : null,
      body: Column(
        children: [
          // 搜索栏（微信风格）
          _buildSearchBar(isDark),

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
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: AppBar(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.star_border,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
          onPressed: () => _showComingSoon('星标消息'),
        ),
        title: Text(
          '微信',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
            onPressed: widget.onAddPressed ?? _showAddMenu,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: widget.onSearchTap,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF3A3A3C) : const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 20,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
              const SizedBox(width: 6),
              Text(
                '搜索',
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
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

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature 功能即将推出'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAddMenu() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
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
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // 发起群聊
              _buildAddMenuItem(
                ctx,
                icon: Icons.group_add,
                iconColor: const Color(0xFF57BE6A),
                title: '发起群聊',
                onTap: () => _navigateToCreateGroup(ctx),
              ),
              
              // 添加朋友
              _buildAddMenuItem(
                ctx,
                icon: Icons.person_add,
                iconColor: const Color(0xFF576B95),
                title: '添加朋友',
                onTap: () => _navigateToAddFriend(ctx),
              ),
              
              // 扫一扫
              _buildAddMenuItem(
                ctx,
                icon: Icons.qr_code_scanner,
                iconColor: const Color(0xFF10AEFF),
                title: '扫一扫',
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ScanQRPage()),
                  );
                },
              ),
              
              // 收付款
              _buildAddMenuItem(
                ctx,
                icon: Icons.payment,
                iconColor: const Color(0xFF09BB07),
                title: '收付款',
                onTap: () {
                  Navigator.pop(ctx);
                  _showComingSoon('收付款');
                },
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddMenuItem(
    BuildContext ctx, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      onTap: onTap,
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

  void _showConversationMenu(
      BuildContext context, ConversationEntity conversation) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
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
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // 标记已读
              if (conversation.unreadCount > 0)
                _buildMenuTile(
                  ctx,
                  icon: Icons.done_all,
                  title: '标记已读',
                  onTap: () {
                    Navigator.pop(ctx);
                    context
                        .read<ConversationBloc>()
                        .add(MarkConversationAsRead(conversation.id));
                  },
                ),

              // 免打扰
              _buildMenuTile(
                ctx,
                icon: conversation.isMuted
                    ? Icons.notifications_active
                    : Icons.notifications_off,
                title: conversation.isMuted ? '取消免打扰' : '消息免打扰',
                onTap: () {
                  Navigator.pop(ctx);
                  context.read<ConversationBloc>().add(SetConversationMuted(
                        conversationId: conversation.id,
                        muted: !conversation.isMuted,
                      ));
                },
              ),

              // 置顶
              _buildMenuTile(
                ctx,
                icon: conversation.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
                title: conversation.isPinned ? '取消置顶' : '置顶',
                onTap: () {
                  Navigator.pop(ctx);
                  context.read<ConversationBloc>().add(SetConversationPinned(
                        conversationId: conversation.id,
                        pinned: !conversation.isPinned,
                      ));
                },
              ),

              // 删除
              _buildMenuTile(
                ctx,
                icon: Icons.delete_outline,
                title: '删除会话',
                isDestructive: true,
                onTap: () {
                  Navigator.pop(ctx);
                  _confirmDeleteConversation(conversation);
                },
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext ctx, {
    required IconData icon,
    required String title,
    bool isDestructive = false,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDestructive 
        ? AppColors.error 
        : (isDark ? Colors.white : Colors.black);
    final iconColor = isDestructive 
        ? AppColors.error 
        : (isDark ? Colors.white54 : Colors.black54);
    
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: onTap,
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
