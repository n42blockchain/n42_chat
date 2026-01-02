import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/entities/message_entity.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../blocs/chat/chat_state.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_state.dart';
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
  bool _showMorePanel = false;
  String? _highlightedMessageId;

  @override
  void initState() {
    super.initState();

    // 初始化聊天室
    context.read<ChatBloc>().add(InitializeChat(widget.conversation.id));

    // 监听滚动
    _scrollController.addListener(_onScroll);

    // 监听输入框焦点，获取焦点时隐藏更多面板
    _inputFocusNode.addListener(_onInputFocusChanged);
  }

  void _onInputFocusChanged() {
    if (_inputFocusNode.hasFocus && _showMorePanel) {
      setState(() {
        _showMorePanel = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _inputController.dispose();
    _inputFocusNode.removeListener(_onInputFocusChanged);
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

          // 更多功能面板
          if (_showMorePanel) _buildMorePanel(),
        ],
      ),
    );
  }

  Widget _buildMorePanel() {
    return ChatMorePanel(
      onPhotoPressed: () {
        _hideMorePanel();
        _pickImage();
      },
      onCameraPressed: () {
        _hideMorePanel();
        _takePhoto();
      },
      onLocationPressed: () {
        _hideMorePanel();
        _sendLocation();
      },
      onRedPacketPressed: () {
        _hideMorePanel();
        _sendRedPacket();
      },
      onTransferPressed: () {
        _hideMorePanel();
        _sendTransfer();
      },
      onFilePressed: () {
        _hideMorePanel();
        _pickFile();
      },
      onContactCardPressed: () {
        _hideMorePanel();
        _sendContactCard();
      },
    );
  }

  void _hideMorePanel() {
    setState(() {
      _showMorePanel = false;
    });
  }

  void _pickImage() {
    // TODO: 实现选择照片功能
    debugPrint('Pick image');
  }

  void _takePhoto() {
    // TODO: 实现拍摄功能
    debugPrint('Take photo');
  }

  void _sendLocation() {
    // TODO: 实现发送位置功能
    debugPrint('Send location');
  }

  void _sendRedPacket() {
    // TODO: 实现发红包功能
    debugPrint('Send red packet');
  }

  void _sendTransfer() {
    // TODO: 实现转账功能
    debugPrint('Send transfer');
  }

  void _pickFile() {
    // TODO: 实现选择文件功能
    debugPrint('Pick file');
  }

  void _sendContactCard() {
    // TODO: 实现发送名片功能
    debugPrint('Send contact card');
  }

  PreferredSizeWidget _buildAppBar(bool isDark) {
    return N42AppBar(
      titleWidget: Column(
        children: [
          Text(
            _getDisplayName(),
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

  /// 获取显示名称，私聊优先使用备注名
  String _getDisplayName() {
    // 群聊直接返回群名称
    if (widget.conversation.type == ConversationType.group) {
      final name = widget.conversation.name;
      // 如果群名为空或为默认值，显示成员数
      if (name.isEmpty || name == 'Empty Chat' || name == 'empty chat') {
        return '群聊(${widget.conversation.memberCount})';
      }
      return name;
    }

    // 私聊尝试获取备注名
    try {
      final contactBloc = context.read<ContactBloc>();
      final state = contactBloc.state;
      if (state is ContactLoaded) {
        // 查找对应的联系人（通过房间ID或用户ID）
        final contact = state.contacts.cast<ContactEntity?>().firstWhere(
          (c) => c?.directRoomId == widget.conversation.id,
          orElse: () => null,
        );
        if (contact != null) {
          // 优先使用备注名
          if (contact.remark != null && contact.remark!.isNotEmpty) {
            return contact.remark!;
          }
          // 其次使用显示名
          if (contact.displayName.isNotEmpty) {
            return contact.displayName;
          }
        }
      }
    } catch (e) {
      // ContactBloc 可能不可用，使用默认名称
    }

    // 如果名称为空或为默认值，返回简化的用户ID或默认文本
    final name = widget.conversation.name;
    if (name.isEmpty || name == 'Empty Chat' || name == 'empty chat') {
      return '私聊';
    }
    return name;
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEncryptionNotice(),
              const SizedBox(height: 16),
              N42EmptyState.noData(
                title: '暂无消息',
                description: '发送第一条消息开始聊天',
              ),
            ],
          );
        }

        // 额外项数：加密提示(1) + 加载更多指示器(可选)
        final extraItems = 1 + (state.isLoadingMore ? 1 : 0);
        
        return ListView.builder(
          controller: _scrollController,
          reverse: true, // 从底部开始显示
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: state.messages.length + extraItems,
          itemBuilder: (context, index) {
            // 加载更多指示器（列表顶部，index 最大）
            if (state.isLoadingMore && index == state.messages.length + 1) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: N42Loading(),
              );
            }
            
            // 端对端加密提示（在所有消息之上）
            if (index == state.messages.length) {
              return _buildEncryptionNotice();
            }

            final message = state.messages[index];
            final previousMessage =
                index < state.messages.length - 1 ? state.messages[index + 1] : null;

            // 判断是否显示时间分隔器
            final showTimeSeparator = _shouldShowTimeSeparator(
              message,
              previousMessage,
            );

            // 群聊中判断是否需要显示发送者名称
            // 如果与上一条消息发送者不同，或者时间间隔较大，则显示名称
            final isGroupChat = widget.conversation.type == ConversationType.group;
            final showSenderName = isGroupChat && !message.isFromMe && (
              previousMessage == null ||
              previousMessage.senderId != message.senderId ||
              _shouldShowTimeSeparator(message, previousMessage)
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
                  isGroupChat: isGroupChat,
                  showSenderName: showSenderName,
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// 构建端对端加密提示
  Widget _buildEncryptionNotice() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primaryWithOpacity,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                '本聊天已开启端对端加密保护，只有您和对方可以读取消息内容',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
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
      onSendVoice: _sendVoiceMessage,
      onChanged: _onInputChanged,
      onVoicePressed: _onVoicePressed,
      onEmojiPressed: _onEmojiPressed,
      onMorePressed: _onMorePressed,
    );
  }

  Future<void> _sendVoiceMessage(String path, Duration duration) async {
    try {
      final file = File(path);
      if (!await file.exists()) {
        debugPrint('Voice file not found: $path');
        return;
      }
      
      final bytes = await file.readAsBytes();
      final filename = path.split('/').last;
      
      context.read<ChatBloc>().add(SendVoiceMessage(
        audioBytes: bytes,
        filename: filename,
        duration: duration.inMilliseconds,
        mimeType: 'audio/mp4',
      ));
      
      // 删除临时文件
      await file.delete();
    } catch (e) {
      debugPrint('Send voice message error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('发送语音失败: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
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
    // 隐藏键盘
    _inputFocusNode.unfocus();
    // 切换更多功能面板
    setState(() {
      _showMorePanel = !_showMorePanel;
    });
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

