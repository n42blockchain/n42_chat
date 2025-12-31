import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/entities/message_entity.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../blocs/chat/chat_state.dart';
import '../../blocs/search/search_bloc.dart';
import '../../widgets/chat/chat_widgets.dart';
import '../../widgets/common/common_widgets.dart';
import '../search/chat_search_bar.dart';
import 'message_item.dart';

/// 聊天页面
class ChatPage extends StatefulWidget {
  /// 会话实体
  final ConversationEntity conversation;

  /// 返回回调
  final VoidCallback? onBack;

  /// 更多按钮点击回调
  final VoidCallback? onMorePressed;

  const ChatPage({
    super.key,
    required this.conversation,
    this.onBack,
    this.onMorePressed,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();

  bool _showScrollToBottom = false;
  bool _showSearchBar = false;
  String? _highlightedMessageId;

  @override
  void initState() {
    super.initState();

    // 初始化聊天室
    context.read<ChatBloc>().add(InitializeChat(widget.conversation.id));

    // 监听滚动
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _inputController.dispose();
    _inputFocusNode.dispose();

    // 清理聊天室
    context.read<ChatBloc>().add(const DisposeChat());

    super.dispose();
  }

  void _onScroll() {
    // 检查是否需要加载更多
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ChatBloc>().add(const LoadMoreMessages());
    }

    // 显示/隐藏回到底部按钮
    final shouldShow = _scrollController.position.pixels > 500;
    if (_showScrollToBottom != shouldShow) {
      setState(() {
        _showScrollToBottom = shouldShow;
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    context.read<ChatBloc>().add(SendTextMessage(text));
    _inputController.clear();
  }

  void _onInputChanged(String text) {
    // 发送正在输入状态
    context.read<ChatBloc>().add(SendTypingNotification(text.isNotEmpty));
  }

  void _onMessageLongPress(MessageEntity message) {
    _showMessageMenu(message);
  }

  void _onMessageTap(MessageEntity message) {
    // 处理消息点击（如查看图片、播放语音等）
    // TODO: 实现具体的消息点击处理
  }

  void _onAvatarTap(MessageEntity message) {
    // 点击头像查看用户资料
    // TODO: 跳转到用户资料页
  }

  void _onResend(MessageEntity message) {
    context.read<ChatBloc>().add(ResendMessage(message.id));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: _buildAppBar(isDark),
      body: Column(
        children: [
          // 聊天内搜索栏
          if (_showSearchBar)
            BlocProvider(
              create: (_) => getIt<SearchBloc>(),
              child: ChatSearchBar(
                roomId: widget.conversation.id,
                onClose: _toggleSearch,
                onNavigateToMessage: _navigateToMessage,
              ),
            ),

          // 消息列表
          Expanded(
            child: Stack(
              children: [
                _buildMessageList(),

                // 回到底部按钮
                if (_showScrollToBottom)
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: _buildScrollToBottomButton(),
                  ),
              ],
            ),
          ),

          // 回复预览
          _buildReplyPreview(),

          // 输入栏
          if (!_showSearchBar) _buildInputBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDark) {
    return N42AppBar(
      titleWidget: Column(
        children: [
          Text(
            widget.conversation.name,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
          if (widget.conversation.type == ConversationType.group)
            Text(
              '${widget.conversation.memberCount}人',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
      onBackPressed: widget.onBack ?? () => Navigator.of(context).pop(),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _toggleSearch,
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: widget.onMorePressed,
        ),
      ],
    );
  }

  void _toggleSearch() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      if (!_showSearchBar) {
        _highlightedMessageId = null;
      }
    });
  }

  void _navigateToMessage(String eventId) {
    setState(() {
      _highlightedMessageId = eventId;
    });

    // 滚动到指定消息
    final chatBloc = context.read<ChatBloc>();
    final state = chatBloc.state;
    final index = state.messages.indexWhere((m) => m.id == eventId);

    if (index != -1) {
      // 使用 jumpTo 滚动到消息位置
      _scrollController.animateTo(
        index * 80.0, // 估算每条消息高度
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Widget _buildMessageList() {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
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
            title: '暂无消息',
            description: '发送第一条消息开始聊天',
          );
        }

        return ListView.builder(
          controller: _scrollController,
          reverse: true, // 从底部开始显示
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: state.messages.length + (state.isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            // 加载更多指示器
            if (state.isLoadingMore && index == state.messages.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: N42Loading(),
              );
            }

            final message = state.messages[index];
            final previousMessage =
                index < state.messages.length - 1 ? state.messages[index + 1] : null;

            // 判断是否显示时间分隔器
            final showTimeSeparator = _shouldShowTimeSeparator(
              message,
              previousMessage,
            );

            return Column(
              children: [
                if (showTimeSeparator)
                  TimeSeparator(dateTime: message.timestamp),
                MessageItem(
                  message: message,
                  isHighlighted: message.id == _highlightedMessageId,
                  onTap: () => _onMessageTap(message),
                  onLongPress: () => _onMessageLongPress(message),
                  onAvatarTap: () => _onAvatarTap(message),
                  onResend: () => _onResend(message),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildReplyPreview() {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (prev, curr) => prev.replyTarget != curr.replyTarget,
      builder: (context, state) {
        if (state.replyTarget == null) {
          return const SizedBox.shrink();
        }

        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            border: Border(
              top: BorderSide(
                color: isDark ? AppColors.dividerDark : AppColors.divider,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '回复 ${state.replyTarget!.senderName}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      state.replyTarget!.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                onPressed: () {
                  context.read<ChatBloc>().add(const SetReplyTarget(null));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInputBar() {
    return ChatInputBar(
      controller: _inputController,
      focusNode: _inputFocusNode,
      onSendText: _sendMessage,
      onChanged: _onInputChanged,
      onVoicePressed: _onVoicePressed,
      onEmojiPressed: _onEmojiPressed,
      onMorePressed: _onMorePressed,
    );
  }

  Widget _buildScrollToBottomButton() {
    return FloatingActionButton.small(
      onPressed: _scrollToBottom,
      backgroundColor: AppColors.surface,
      child: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.textSecondary,
      ),
    );
  }

  bool _shouldShowTimeSeparator(
    MessageEntity current,
    MessageEntity? previous,
  ) {
    if (previous == null) return true;

    final diff = current.timestamp.difference(previous.timestamp).abs();
    return diff.inMinutes >= 5;
  }

  void _showMessageMenu(MessageEntity message) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _MessageMenuSheet(
        message: message,
        onCopy: () {
          Navigator.pop(ctx);
          // TODO: 复制消息
        },
        onReply: () {
          Navigator.pop(ctx);
          context.read<ChatBloc>().add(SetReplyTarget(message));
        },
        onForward: () {
          Navigator.pop(ctx);
          // TODO: 转发消息
        },
        onDelete: message.isFromMe
            ? () {
                Navigator.pop(ctx);
                context.read<ChatBloc>().add(RedactMessage(message.id));
              }
            : null,
      ),
    );
  }

  void _onVoicePressed() {
    // TODO: 实现语音录制
  }

  void _onEmojiPressed() {
    // TODO: 实现表情选择器
  }

  void _onMorePressed() {
    // TODO: 实现更多功能菜单
  }
}

/// 消息操作菜单
class _MessageMenuSheet extends StatelessWidget {
  final MessageEntity message;
  final VoidCallback? onCopy;
  final VoidCallback? onReply;
  final VoidCallback? onForward;
  final VoidCallback? onDelete;

  const _MessageMenuSheet({
    required this.message,
    this.onCopy,
    this.onReply,
    this.onForward,
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (message.type == MessageType.text)
              _buildMenuItem(
                context,
                icon: Icons.copy,
                title: '复制',
                onTap: onCopy,
              ),
            _buildMenuItem(
              context,
              icon: Icons.reply,
              title: '回复',
              onTap: onReply,
            ),
            _buildMenuItem(
              context,
              icon: Icons.forward,
              title: '转发',
              onTap: onForward,
            ),
            if (onDelete != null)
              _buildMenuItem(
                context,
                icon: Icons.delete_outline,
                title: '撤回',
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

