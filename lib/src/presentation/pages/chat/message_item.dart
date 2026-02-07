import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/remark_service.dart';
import '../../../core/services/url_preview_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/entities/message_reaction_entity.dart';
import '../../widgets/chat/message_status_indicator.dart' as indicator;
import '../../widgets/chat/chat_widgets.dart';
import '../../widgets/chat/contact_card_message_widget.dart';
import '../../widgets/chat/url_preview_widget.dart';
import '../../widgets/chat/wechat_message_menu.dart';
import '../../widgets/chat/message_reaction_bar.dart';
import '../../widgets/chat/edit_history_sheet.dart';
import '../../widgets/chat/thread_indicator.dart';

/// 消息列表项
class MessageItem extends StatelessWidget {
  /// 消息实体
  final MessageEntity message;

  /// 是否高亮显示（搜索结果）
  final bool isHighlighted;

  /// 点击回调
  final VoidCallback? onTap;

  /// 长按回调
  final VoidCallback? onLongPress;

  /// 头像点击回调
  final VoidCallback? onAvatarTap;
  
  /// 头像双击回调（拍一拍）
  final VoidCallback? onAvatarDoubleTap;

  /// 重发回调
  final VoidCallback? onResend;

  /// 是否是群聊消息
  final bool isGroupChat;

  /// 是否显示发送者名称
  final bool showSenderName;
  
  /// 当前用户ID（用于表情回应高亮）
  final String? currentUserId;

  /// 表情回应点击回调
  final void Function(String emoji)? onReactionTap;

  /// 投票回调 (pollEventId, optionId, currentVotes, maxSelections)
  final void Function(String pollEventId, String optionId, List<String> currentVotes, int maxSelections)? onPollVote;

  /// 结束投票回调
  final void Function(String pollEventId)? onEndPoll;

  /// 红包点击回调
  final void Function(MessageEntity message)? onRedPacketTap;

  /// 名片点击回调
  final void Function(String contactId, String contactName, String? avatarUrl)? onContactCardTap;

  /// 回拨通话回调
  final void Function(MessageEntity message)? onCallBack;

  /// 引用块点击回调 - 用于跳转到被引用的消息
  final void Function(String messageId)? onReplyQuoteTap;

  /// 线程点击回调 - 用于导航到线程详情页
  final void Function(MessageEntity message)? onThreadTap;

  const MessageItem({
    super.key,
    required this.message,
    this.isHighlighted = false,
    this.onTap,
    this.onLongPress,
    this.onAvatarTap,
    this.onAvatarDoubleTap,
    this.onResend,
    this.isGroupChat = false,
    this.showSenderName = false,
    this.currentUserId,
    this.onReactionTap,
    this.onPollVote,
    this.onEndPoll,
    this.onRedPacketTap,
    this.onContactCardTap,
    this.onCallBack,
    this.onReplyQuoteTap,
    this.onThreadTap,
  });

  @override
  Widget build(BuildContext context) {
    // 系统消息
    if (message.type == MessageType.system ||
        message.type == MessageType.notice) {
      return SystemMessageWidget(message: message.content);
    }

    // 通话消息 - 微信风格
    if (message.type == MessageType.voiceCall ||
        message.type == MessageType.videoCall) {
      return _buildCallMessage(context);
    }

    // 已撤回的消息 - 显示微信风格的撤回提示
    if (message.type == MessageType.redacted) {
      return RecalledMessageWidget(
        isFromMe: message.isFromMe,
        onReEdit: null, // 服务器撤回的消息无法重新编辑
      );
    }

    // 普通消息
    return _buildMessageBubble(context);
  }

  /// 获取发送者显示名称（优先使用备注名）
  String _getSenderDisplayName(BuildContext context) {
    if (message.isFromMe) {
      return message.senderName;
    }

    // 使用 RemarkService 获取备注名
    return RemarkService.instance.getDisplayName(message.senderId, message.senderName);
  }

  Widget _buildMessageBubble(BuildContext context) {
    final status = _mapStatus(message.status);
    final isDark = context.isDarkMode;
    final displayName = _getSenderDisplayName(context);

    // 是否显示发送者名称（群聊中非自己的消息）
    final shouldShowSenderName = isGroupChat && !message.isFromMe && showSenderName;

    // 图片、视频、红包、转账消息不需要气泡背景（微信风格）
    final noBubbleMessage = message.type == MessageType.image || 
                            message.type == MessageType.video ||
                            message.type == MessageType.redPacket ||
                            message.type == MessageType.transfer;
    
    // 红包和转账消息有自己的点击处理，不需要外层的 onTap
    final hasOwnTapHandler = message.type == MessageType.redPacket ||
                             message.type == MessageType.transfer;

    Widget bubble = MessageBubble(
      isSelf: message.isFromMe,
      status: status,
      timestamp: message.timestamp,
      showTimestamp: false,
      avatarUrl: message.senderAvatarUrl,
      avatarName: displayName,
      onTap: hasOwnTapHandler ? null : onTap,
      onLongPress: onLongPress,
      onAvatarTap: onAvatarTap,
      onAvatarDoubleTap: onAvatarDoubleTap,
      onResend: onResend,
      // 图片/视频/红包/转账消息不需要气泡背景
      noBubble: noBubbleMessage,
      child: _buildMessageContent(context),
    );

    // 如果需要显示发送者名称，添加名称标签
    if (shouldShowSenderName) {
      bubble = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 56, bottom: 2),
            child: Text(
              displayName,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
            ),
          ),
          bubble,
        ],
      );
    }

    // 高亮显示搜索结果
    if (isHighlighted) {
      bubble = Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: bubble,
      );
    }
    
    // 如果有表情回应，显示在消息下方
    if (message.reactions.isNotEmpty) {
      return Column(
        crossAxisAlignment: message.isFromMe 
            ? CrossAxisAlignment.end 
            : CrossAxisAlignment.start,
        children: [
          bubble,
          _buildReactionBar(context),
        ],
      );
    }

    return bubble;
  }
  
  /// 构建表情回应栏
  Widget _buildReactionBar(BuildContext context) {
    // 转换 MessageReaction 到 MessageReactionEntity
    final reactionEntities = message.reactions.map((r) {
      return MessageReactionEntity(
        emoji: r.key,
        userIds: r.userIds,
      );
    }).toList();
    
    return Padding(
      padding: EdgeInsets.only(
        left: message.isFromMe ? 0 : 56, // 头像宽度 + 间距
        right: message.isFromMe ? 56 : 0,
        top: 4,
      ),
      child: MessageReactionBar(
        reactions: reactionEntities,
        currentUserId: currentUserId ?? '',
        onReactionTap: onReactionTap,
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    final isDark = context.isDarkMode;

    Widget content;
    switch (message.type) {
      case MessageType.text:
        content = _buildTextMessage(isDark, context);
        break;
      case MessageType.image:
        content = _buildImageMessage();
        break;
      case MessageType.audio:
        content = _buildVoiceMessage();
        break;
      case MessageType.video:
        content = _buildVideoMessage(context);
        break;
      case MessageType.file:
        content = _buildFileMessage(isDark);
        break;
      case MessageType.location:
        content = _buildLocationMessage(isDark, context);
        break;
      case MessageType.transfer:
        content = _buildTransferMessage();
        break;
      case MessageType.redPacket:
        content = _buildRedPacketMessage(context);
        break;
      case MessageType.poll:
        content = _buildPollMessage(isDark, context);
        break;
      case MessageType.music:
        content = _buildMusicMessage(isDark, context);
        break;
      case MessageType.contactCard:
        content = _buildContactCardWidget(context);
        break;
      case MessageType.encrypted:
        content = _buildEncryptedMessage(isDark);
        break;
      default:
        content = _buildTextMessage(isDark, context);
    }
    
    // 如果有回复，添加回复引用块
    if (message.hasReply && message.replyToContent != null) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildReplyQuote(isDark),
          const SizedBox(height: 4),
          content,
        ],
      );
    }

    // 如果是线程根消息，在内容下方显示线程指示器
    if (message.isThreadRoot) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          content,
          ThreadIndicator(
            message: message,
            onTap: () => onThreadTap?.call(message),
          ),
        ],
      );
    }

    return content;
  }
  
  /// 构建回复引用块
  Widget _buildReplyQuote(bool isDark) {
    final bgColor = message.isFromMe
        ? Colors.black.withValues(alpha: 0.1)
        : (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05));

    final textColor = message.isFromMe
        ? AppColors.messageTextSent.withValues(alpha: 0.8)
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary);

    // 包装 GestureDetector 以支持点击跳转到原消息
    return GestureDetector(
      onTap: () {
        if (message.replyToId != null && onReplyQuoteTap != null) {
          onReplyQuoteTap!(message.replyToId!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
          border: const Border(
            left: BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (message.replyToSender != null)
              Text(
                message.replyToSender!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            Text(
              message.replyToContent ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextMessage(bool isDark, BuildContext context) {
    // 检测是否是名片消息
    if (_isContactCardMessage(message.content)) {
      return _buildContactCardMessage(isDark, context);
    }

    // 微信中绿色气泡的文字是黑色，灰色气泡的文字也是黑色
    // 深色模式下，对方的灰色气泡文字是白色
    final textColor = message.isFromMe
        ? AppColors.messageTextSent  // 黑色
        : (isDark ? AppColors.textPrimaryDark : AppColors.messageTextReceived);

    final textWidget = Text(
      message.content,
      style: TextStyle(
        fontSize: 16,
        color: textColor,
        height: 1.4,
      ),
    );

    // 检测消息中的 URL，用于显示预览
    final urlMatch = RegExp(r'https?://\S+').firstMatch(message.content);

    // 如果消息被编辑过，在文字下方显示 "已编辑" 标签
    if (message.isEdited) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          textWidget,
          const SizedBox(height: 2),
          GestureDetector(
            onTap: () => _showEditHistory(context),
            child: Text(
              S.of(context)?.chatEdited ?? 'Edited',
              style: TextStyle(
                fontSize: 10,
                color: message.isFromMe
                    ? AppColors.messageTextSent.withValues(alpha: 0.5)
                    : (isDark ? Colors.grey[500] : Colors.grey),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          if (urlMatch != null)
            UrlPreviewWidget(
              url: urlMatch.group(0)!,
              previewService: getIt<UrlPreviewService>(),
            ),
        ],
      );
    }

    // 如果有 URL，在文本下方显示 URL 预览
    if (urlMatch != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          textWidget,
          UrlPreviewWidget(
            url: urlMatch.group(0)!,
            previewService: getIt<UrlPreviewService>(),
          ),
        ],
      );
    }

    return textWidget;
  }

  /// 显示编辑历史
  void _showEditHistory(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => EditHistorySheet(
        roomId: message.roomId,
        messageId: message.id,
      ),
    );
  }

  /// 检测是否是名片消息
  bool _isContactCardMessage(String content) {
    // 检查多种可能的名片消息格式
    // 支持不同语言的本地化标题
    if (content.startsWith('[')) {
      final firstLine = content.split('\n').first.toLowerCase();
      return firstLine.contains('名片') ||
             firstLine.contains('contact') ||
             firstLine.contains('card') ||
             firstLine.contains('personal');
    }
    return false;
  }

  /// 解析名片消息内容
  Map<String, String>? _parseContactCard(String content) {
    try {
      final lines = content.split('\n');
      if (lines.length < 3) return null;

      String? contactName;
      String? contactId;
      String? contactAvatar;

      for (final line in lines) {
        // 支持普通冒号 : 和全角冒号 ：
        // 新格式使用 "Name:" 前缀
        // 同时支持旧格式的 "联系人" 和 "Contact"
        if (line.startsWith('Name:') || line.startsWith('Name：') ||
            line.startsWith('联系人：') || line.startsWith('联系人:') ||
            line.startsWith('Contact：') || line.startsWith('Contact:')) {
          contactName = line.replaceFirst(RegExp(r'^(Name[：:]|联系人[：:]|Contact[：:])'), '').trim();
        } else if (line.startsWith('ID：') || line.startsWith('ID:')) {
          contactId = line.replaceFirst(RegExp(r'^ID[：:]'), '').trim();
        } else if (line.startsWith('头像：') || line.startsWith('头像:') ||
                   line.startsWith('Avatar：') || line.startsWith('Avatar:')) {
          contactAvatar = line.replaceFirst(RegExp(r'^(头像[：:]|Avatar[：:])'), '').trim();
        }
      }

      if (contactName != null && contactId != null) {
        return {
          'name': contactName,
          'id': contactId,
          if (contactAvatar != null && contactAvatar.isNotEmpty) 'avatar': contactAvatar,
        };
      }
    } catch (e) {
      debugPrint('Parse contact card error: $e');
    }
    return null;
  }

  /// 构建名片消息（使用 ContactCardMessageWidget）
  /// 用于 MessageType.contactCard 类型消息
  Widget _buildContactCardWidget(BuildContext context) {
    // 优先从多行格式解析（兼容旧格式）
    final cardInfo = _parseContactCard(message.content);

    String contactId;
    String displayName;
    String? avatarUrl;

    if (cardInfo != null) {
      contactId = cardInfo['id'] ?? '';
      displayName = cardInfo['name'] ?? (S.of(context)?.chatUnknownContact ?? 'Unknown Contact');
      avatarUrl = cardInfo['avatar'];
    } else {
      // 从 body 格式 "[Contact Card] displayName" 中解析
      final body = message.content;
      if (body.startsWith('[Contact Card] ')) {
        displayName = body.substring('[Contact Card] '.length).trim();
      } else if (body.startsWith('[')) {
        // 其他本地化格式，尝试提取 ] 之后的内容
        final bracketEnd = body.indexOf(']');
        displayName = bracketEnd >= 0 && bracketEnd < body.length - 1
            ? body.substring(bracketEnd + 1).trim()
            : body;
      } else {
        displayName = body.isNotEmpty ? body : (S.of(context)?.chatUnknownContact ?? 'Unknown Contact');
      }
      contactId = '';
      avatarUrl = null;
    }

    return ContactCardMessageWidget(
      userId: contactId,
      displayName: displayName,
      avatarUrl: avatarUrl,
      isFromMe: message.isFromMe,
      onTap: () {
        if (contactId.isNotEmpty && onContactCardTap != null) {
          onContactCardTap!(contactId, displayName, avatarUrl);
        }
      },
    );
  }

  /// 构建名片消息（微信风格）
  Widget _buildContactCardMessage(bool isDark, BuildContext context) {
    final cardInfo = _parseContactCard(message.content);
    final contactName = cardInfo?['name'] ?? (S.of(context)?.chatUnknownContact ?? 'Unknown Contact');
    final contactId = cardInfo?['id'] ?? '';
    final contactAvatar = cardInfo?['avatar'];

    return GestureDetector(
      onTap: () {
        if (contactId.isNotEmpty && onContactCardTap != null) {
          onContactCardTap!(contactId, contactName, contactAvatar);
        }
      },
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: message.isFromMe
              ? AppColors.bubbleSelf
              : (isDark ? AppColors.bubbleOtherDark : AppColors.bubbleOther),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 名片内容
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // 头像 - 如果有头像URL则显示网络图片，否则显示首字母
                  _buildContactAvatar(contactName, contactAvatar),
                  const SizedBox(width: 10),
                  // 名称
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contactName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: message.isFromMe
                                ? AppColors.messageTextSent
                                : (isDark ? AppColors.textPrimaryDark : AppColors.messageTextReceived),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ID: ${contactId.length > 12 ? '${contactId.substring(0, 12)}...' : contactId}',
                          style: TextStyle(
                            fontSize: 12,
                            color: message.isFromMe
                                ? AppColors.messageTextSent.withValues(alpha: 0.6)
                                : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 底部分隔线和标签
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: message.isFromMe
                        ? Colors.black.withValues(alpha: 0.1)
                        : (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05)),
                    width: 0.5,
                  ),
                ),
              ),
              child: Text(
                S.of(context)?.chatPersonalCard ?? 'Contact Card',
                style: TextStyle(
                  fontSize: 11,
                  color: message.isFromMe
                      ? AppColors.messageTextSent.withValues(alpha: 0.5)
                      : (isDark ? AppColors.textSecondaryDark : AppColors.textTertiary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 根据名称生成颜色
  Color _getColorFromName(String name) {
    return AppColorPalettes.getAvatarColor(name);
  }

  /// 构建联系人头像（名片消息用）
  Widget _buildContactAvatar(String name, String? avatarUrl) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      // 有头像URL，显示网络图片
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          avatarUrl,
          width: 44,
          height: 44,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // 加载失败时显示首字母
            return _buildAvatarPlaceholder(name);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildAvatarPlaceholder(name);
          },
        ),
      );
    }
    // 无头像URL，显示首字母
    return _buildAvatarPlaceholder(name);
  }

  /// 构建头像占位符（首字母）
  Widget _buildAvatarPlaceholder(String name) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _getColorFromName(name),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildImageMessage() {
    final metadata = message.metadata;
    // 优先使用 httpUrl，如果没有则使用 mediaUrl
    final imageUrl = metadata?.httpUrl ?? metadata?.mediaUrl ?? '';

    return ImageMessageWidget(
      imageUrl: imageUrl,
      thumbnailUrl: metadata?.thumbnailUrl,
      width: metadata?.width,
      height: metadata?.height,
      onTap: onTap,
      isViewOnce: message.isSelfDestructing,
      isExpired: message.isExpired,
      isViewed: message.isDestructionStarted && !message.isExpired,
      isFromMe: message.isFromMe,
    );
  }

  Widget _buildVoiceMessage() {
    final metadata = message.metadata;
    // 转换毫秒到秒
    final durationSec = ((metadata?.duration ?? 0) / 1000).round();
    // 优先使用 httpUrl
    final voiceUrl = metadata?.httpUrl ?? metadata?.mediaUrl;

    return VoiceMessageWidget(
      duration: durationSec > 0 ? durationSec : 1,
      isSelf: message.isFromMe,
      voiceUrl: voiceUrl,
      // 语音转文字功能（需要接入语音识别API）
      onConvertToText: voiceUrl != null ? _convertVoiceToText : null,
    );
  }

  /// 语音转文字
  Future<String?> _convertVoiceToText(String voiceUrl) async {
    // 尝试使用语音识别服务
    // 注意：需要先配置 API Key
    // SpeechToTextService().configureGoogle('your-api-key');
    // 或
    // SpeechToTextService().configureWhisper('http://localhost:8000');

    // 如果服务已配置，则使用真实的语音识别
    // final text = await SpeechToTextService().transcribe(voiceUrl);
    // if (text != null) return text;

    // Speech-to-text API not configured
    await Future<void>.delayed(const Duration(seconds: 1));
    return '[Speech-to-text requires API configuration]';
  }

  Widget _buildVideoMessage(BuildContext context) {
    final metadata = message.metadata;
    final thumbnailUrl = metadata?.thumbnailUrl;
    final durationMs = metadata?.duration;
    final fileSize = metadata?.size;
    final s = S.of(context);

    // View Once 视频消息（接收方）
    if (message.isSelfDestructing && !message.isFromMe) {
      if (message.isExpired || message.isDestructionStarted) {
        // 已过期或已查看
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 200,
            height: 120,
            color: AppColors.placeholder,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    message.isExpired ? Icons.timer_off : Icons.visibility,
                    color: AppColors.textTertiary,
                    size: 28,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    message.isExpired
                        ? (s?.chatViewOnceExpired ?? 'Expired')
                        : (s?.chatViewOnceViewed ?? 'Viewed'),
                    style: const TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      // 未查看 — 模糊蒙版
      return GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 200,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[400]!,
                  Colors.grey[600]!,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s?.chatViewOnceVideo ?? 'View Once Video',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    s?.chatViewOnceTap ?? 'Tap to view',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 视频缩略图或占位图
            if (thumbnailUrl != null && thumbnailUrl.isNotEmpty)
              ImageMessageWidget(
                imageUrl: thumbnailUrl,
                onTap: onTap,
              )
            else
              // 无缩略图时显示渐变背景和视频图标
              Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey[800]!,
                      Colors.grey[900]!,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.videocam,
                      color: Colors.white.withValues(alpha: 0.6),
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context)?.chatVideoTitle ?? 'Video',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 14,
                      ),
                    ),
                    if (fileSize != null)
                      Text(
                        _formatFileSize(fileSize),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            // 播放按钮
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 36,
              ),
            ),
            // 时长标签
            if (durationMs != null)
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _formatDuration((durationMs / 1000).round()),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            // 视频图标标识（左上角）
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.videocam,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            // View Once 标记（发送方）
            if (message.isSelfDestructing && message.isFromMe)
              Positioned(
                left: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.timer, size: 12, color: Colors.white),
                      const SizedBox(width: 3),
                      Text(
                        s?.chatViewOnce ?? 'View Once',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  Widget _buildFileMessage(bool isDark) {
    final metadata = message.metadata;
    final filename = metadata?.fileName ?? message.content;
    final size = metadata?.size;

    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.insert_drive_file,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filename,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: message.isFromMe
                        ? AppColors.messageTextSent
                        : (isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.messageTextReceived),
                  ),
                ),
                if (size != null)
                  Text(
                    _formatFileSize(size),
                    style: TextStyle(
                      fontSize: 12,
                      color: message.isFromMe
                          ? AppColors.textSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationMessage(bool isDark, BuildContext context) {
    final metadata = message.metadata;
    final latitude = metadata?.latitude;
    final longitude = metadata?.longitude;

    // 解析位置名称
    String locationName = message.content;
    if (locationName.isEmpty ||
        locationName.startsWith('geo:') ||
        locationName.contains('Location was shared')) {
      locationName = S.of(context)?.chatMyLocation ?? 'My Location';
    }

    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 地图预览区域 - 微信/WhatsApp风格
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Color(0xFFE8EEF0),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Stack(
              children: [
                // 地图网格背景
                CustomPaint(
                  size: const Size(220, 100),
                  painter: _MapGridPainter(),
                ),
                // 中心位置标记
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ),
                      // 位置标记阴影
                      Container(
                        width: 8,
                        height: 4,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 位置信息区域
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: message.isFromMe
                  ? AppColors.messageSent
                  : (isDark ? AppColors.messageReceivedDark : AppColors.messageReceived),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
            child: Row(
              children: [
                // 位置图标
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                // 位置文字
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locationName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: message.isFromMe
                              ? AppColors.messageTextSent
                              : (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.messageTextReceived),
                        ),
                      ),
                      if (latitude != null && longitude != null)
                        Text(
                          '${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}',
                          style: TextStyle(
                            fontSize: 11,
                            color: message.isFromMe
                                ? AppColors.messageTextSent.withValues(alpha: 0.7)
                                : AppColors.textSecondary,
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

  Widget _buildTransferMessage() {
    final metadata = message.metadata;
    final amount = metadata?.amount ?? '0';
    final currency = metadata?.token ?? 'ETH';
    final status = metadata?.transferStatus ?? 'pending';

    TransferStatus transferStatus;
    switch (status) {
      case 'received':
        transferStatus = TransferStatus.received;
        break;
      case 'refunded':
        transferStatus = TransferStatus.refunded;
        break;
      case 'expired':
        transferStatus = TransferStatus.expired;
        break;
      default:
        transferStatus = TransferStatus.pending;
    }

    return TransferMessageWidget(
      amount: amount,
      currency: currency,
      status: transferStatus,
      note: message.content,
      isSelf: message.isFromMe,
      onTap: onTap,
    );
  }
  
  Widget _buildRedPacketMessage(BuildContext context) {
    final metadata = message.metadata;
    final status = metadata?.transferStatus ?? 'pending';
    
    RedPacketStatus redPacketStatus;
    switch (status) {
      case 'opened':
        redPacketStatus = RedPacketStatus.opened;
        break;
      case 'expired':
        redPacketStatus = RedPacketStatus.expired;
        break;
      case 'empty':
        redPacketStatus = RedPacketStatus.empty;
        break;
      default:
        redPacketStatus = RedPacketStatus.pending;
    }
    
    return RedPacketMessageWidget(
      note: message.content.isNotEmpty ? message.content : (S.of(context)?.chatDefaultRedPacketGreeting ?? 'Best wishes'),
      status: redPacketStatus,
      isSelf: message.isFromMe,
      onTap: () => onRedPacketTap?.call(message),
    );
  }

  Widget _buildMusicMessage(bool isDark, BuildContext context) {
    final metadata = message.metadata;
    final title = metadata?.musicTitle ?? (S.of(context)?.chatUnknownSong ?? 'Unknown Song');
    final artist = metadata?.musicArtist ?? (S.of(context)?.chatUnknownArtist ?? 'Unknown Artist');
    final cover = metadata?.musicCover;
    final url = metadata?.musicUrl;

    return GestureDetector(
      onTap: () {
        if (url != null && url.isNotEmpty) {
          onTap?.call();
        }
      },
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isFromMe
              ? AppColors.messageSent
              : (isDark ? AppColors.messageReceivedDark : AppColors.messageReceived),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // 专辑封面
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: cover != null && cover.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        cover,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.music_note,
                          size: 24,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.music_note,
                      size: 24,
                      color: AppColors.primary,
                    ),
            ),
            const SizedBox(width: 12),
            // 歌曲信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: message.isFromMe
                          ? AppColors.messageTextSent
                          : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    artist,
                    style: TextStyle(
                      fontSize: 12,
                      color: message.isFromMe
                          ? AppColors.messageTextSent.withValues(alpha: 0.7)
                          : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // 播放图标
            const Icon(
              Icons.play_circle_filled,
              size: 32,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollMessage(bool isDark, BuildContext context) {
    final metadata = message.metadata;
    final question = metadata?.pollQuestion ?? message.content;
    final options = metadata?.pollOptions ?? [];
    final optionIds = metadata?.pollOptionIds ?? [];
    final myVotes = metadata?.myVotes ?? [];
    final voteCounts = metadata?.voteCounts ?? {};
    final totalVoters = metadata?.totalVoters ?? 0;
    final maxSelections = metadata?.maxSelections ?? 1;
    final pollEnded = metadata?.pollEnded ?? false;
    
    return Container(
      width: 260,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: message.isFromMe
            ? AppColors.messageSent
            : (isDark ? AppColors.messageReceivedDark : AppColors.messageReceived),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 投票标题
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.poll,
                      size: 12,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      maxSelections == 1
                          ? (S.of(context)?.chatSingleChoice ?? 'Single')
                          : (S.of(context)?.chatMultiChoice ?? 'Multi'),
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (pollEnded)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    S.of(context)?.chatEnded ?? 'Ended',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          
          // 问题
          Text(
            question,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: message.isFromMe
                  ? AppColors.messageTextSent
                  : (isDark ? AppColors.textPrimaryDark : AppColors.messageTextReceived),
            ),
          ),
          const SizedBox(height: 12),
          
          // 选项
          ...List.generate(options.length, (index) {
            final optionText = options[index];
            final optionId = index < optionIds.length ? optionIds[index] : '$index';
            final isSelected = myVotes.contains(optionId);
            final voteCount = voteCounts[optionId] ?? 0;
            final percentage = totalVoters > 0 ? (voteCount / totalVoters * 100) : 0.0;

            // 检查是否可以投票或更改投票
            // 1. 投票已结束，不能投票
            // 2. 单选时，可以点击其他选项更改投票
            // 3. 多选时，可以取消已选项或选择新选项（未达最大值时）
            final canChangeVote = !pollEnded && (
              isSelected ||  // 可以取消已选的
              myVotes.length < maxSelections ||  // 可以添加新选择
              (maxSelections == 1 && myVotes.isNotEmpty)  // 单选可以更改
            );

            return GestureDetector(
              onTap: canChangeVote ? () => onPollVote?.call(message.id, optionId, myVotes, maxSelections) : null,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : (isDark ? Colors.grey[800] : Colors.grey[100]),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            optionText,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            size: 18,
                            color: AppColors.primary,
                          ),
                      ],
                    ),
                    if (totalVoters > 0) ...[
                      const SizedBox(height: 6),
                      // 投票进度条
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: percentage / 100,
                          backgroundColor: isDark ? Colors.grey[700] : Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isSelected ? AppColors.primary : Colors.grey,
                          ),
                          minHeight: 4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        S.of(context)?.chatPollVotesFormat(voteCount, percentage.toStringAsFixed(0)) ?? '$voteCount votes (${percentage.toStringAsFixed(0)}%)',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
          
          // 底部统计
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context)?.chatPollParticipantsFormat(totalVoters) ?? '$totalVoters participants',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              if (!pollEnded && message.isFromMe)
                GestureDetector(
                  onTap: () => onEndPoll?.call(message.id),
                  child: Text(
                    S.of(context)?.chatEndPollButton ?? 'End Poll',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.error,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEncryptedMessage(bool isDark) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.lock,
          size: 16,
          color: AppColors.textSecondary,
        ),
        SizedBox(width: 4),
        Text(
          '[加密消息]',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  /// 构建通话消息（微信风格）
  Widget _buildCallMessage(BuildContext context) {
    final isDark = context.isDarkMode;
    final metadata = message.metadata;
    final isVideo = message.type == MessageType.videoCall;
    final isMissed = metadata?.isMissedCall ?? false;
    final callDuration = metadata?.callDuration;
    final displayName = _getSenderDisplayName(context);

    // 构建通话状态文本（微信风格）
    String callText;
    if (isMissed) {
      // 未接来电
      callText = message.isFromMe
          ? (S.of(context)?.chatCallNotAnswered ?? '对方未接听')
          : (isVideo
              ? (S.of(context)?.chatMissedVideoCall ?? '未接视频通话')
              : (S.of(context)?.chatMissedVoiceCall ?? '未接语音通话'));
    } else if (callDuration != null && callDuration > 0) {
      // 成功通话 - 微信风格："通话时长 00:55"
      final minutes = callDuration ~/ 60;
      final seconds = callDuration % 60;
      final durationStr = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      callText = '${S.of(context)?.chatCallDurationLabel ?? '通话时长'} $durationStr';
    } else {
      // 已取消
      callText = isVideo
          ? (S.of(context)?.chatVideoCallCancelled ?? '视频通话已取消')
          : (S.of(context)?.chatVoiceCallCancelled ?? '语音通话已取消');
    }

    // 未接来电显示红色
    final textColor = isMissed && !message.isFromMe
        ? AppColors.error
        : (message.isFromMe
            ? AppColors.messageTextSent
            : (isDark ? AppColors.textPrimaryDark : AppColors.messageTextReceived));

    final iconColor = isMissed && !message.isFromMe
        ? AppColors.error
        : (isDark ? Colors.white70 : Colors.black54);

    return MessageBubble(
      isSelf: message.isFromMe,
      status: _mapStatus(message.status),
      timestamp: message.timestamp,
      showTimestamp: false,
      avatarUrl: message.senderAvatarUrl,
      avatarName: displayName,
      onAvatarTap: onAvatarTap,
      onAvatarDoubleTap: onAvatarDoubleTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 通话图标
          Icon(
            isVideo ? Icons.videocam : Icons.phone,
            size: 18,
            color: iconColor,
          ),
          const SizedBox(width: 6),
          // 通话文本
          Flexible(
            child: Text(
              callText,
              style: TextStyle(
                fontSize: 15,
                color: textColor,
              ),
            ),
          ),
          // 未接来电显示回拨按钮
          if (isMissed && !message.isFromMe && onCallBack != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => onCallBack?.call(message),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isVideo ? Icons.videocam : Icons.phone,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      S.of(context)?.chatCallBack ?? '回拨',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  indicator.MessageStatus _mapStatus(MessageStatus status) {
    switch (status) {
      case MessageStatus.sending:
        return indicator.MessageStatus.sending;
      case MessageStatus.sent:
        return indicator.MessageStatus.sent;
      case MessageStatus.delivered:
        return indicator.MessageStatus.delivered;
      case MessageStatus.read:
        return indicator.MessageStatus.read;
      case MessageStatus.failed:
        return indicator.MessageStatus.failed;
    }
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

/// 地图网格背景绘制器 - 模拟地图预览效果
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4DDE0)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // 绘制水平线（模拟道路）
    const spacing = 20.0;
    for (double y = spacing; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // 绘制垂直线
    for (double x = spacing; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // 绘制一些"主干道"（较粗的线）
    final mainRoadPaint = Paint()
      ..color = const Color(0xFFC0CDD2)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // 水平主干道
    canvas.drawLine(
      Offset(0, size.height * 0.5),
      Offset(size.width, size.height * 0.5),
      mainRoadPaint,
    );

    // 垂直主干道
    canvas.drawLine(
      Offset(size.width * 0.5, 0),
      Offset(size.width * 0.5, size.height),
      mainRoadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

