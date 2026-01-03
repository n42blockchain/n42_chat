import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../../domain/entities/message_entity.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_state.dart';
import '../../widgets/chat/message_status_indicator.dart' as indicator;
import '../../widgets/chat/chat_widgets.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    // 系统消息
    if (message.type == MessageType.system ||
        message.type == MessageType.notice) {
      return SystemMessageWidget(message: message.content);
    }

    // 普通消息
    return _buildMessageBubble(context);
  }

  /// 获取发送者显示名称（优先使用备注名）
  String _getSenderDisplayName(BuildContext context) {
    if (message.isFromMe) {
      return message.senderName;
    }

    try {
      final contactBloc = context.read<ContactBloc>();
      final state = contactBloc.state;
      if (state is ContactLoaded) {
        final contact = state.contacts.cast<ContactEntity?>().firstWhere(
          (c) => c?.userId == message.senderId,
          orElse: () => null,
        );
        if (contact != null && contact.remark != null && contact.remark!.isNotEmpty) {
          return contact.remark!;
        }
      }
    } catch (e) {
      // ContactBloc 可能不可用，使用原始名称
    }

    return message.senderName;
  }

  Widget _buildMessageBubble(BuildContext context) {
    final status = _mapStatus(message.status);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final displayName = _getSenderDisplayName(context);

    // 是否显示发送者名称（群聊中非自己的消息）
    final shouldShowSenderName = isGroupChat && !message.isFromMe && showSenderName;

    // 图片、视频消息不需要气泡背景（微信风格）
    final isMediaMessage = message.type == MessageType.image || 
                          message.type == MessageType.video;

    Widget bubble = MessageBubble(
      isSelf: message.isFromMe,
      status: status,
      timestamp: message.timestamp,
      showTimestamp: false,
      avatarUrl: message.senderAvatarUrl,
      avatarName: displayName,
      onTap: onTap,
      onLongPress: onLongPress,
      onAvatarTap: onAvatarTap,
      onAvatarDoubleTap: onAvatarDoubleTap,
      onResend: onResend,
      // 图片/视频消息不需要气泡背景
      noBubble: isMediaMessage,
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
      return Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: bubble,
      );
    }

    return bubble;
  }

  Widget _buildMessageContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget content;
    switch (message.type) {
      case MessageType.text:
        content = _buildTextMessage(isDark);
        break;
      case MessageType.image:
        content = _buildImageMessage();
        break;
      case MessageType.audio:
        content = _buildVoiceMessage();
        break;
      case MessageType.video:
        content = _buildVideoMessage();
        break;
      case MessageType.file:
        content = _buildFileMessage(isDark);
        break;
      case MessageType.location:
        content = _buildLocationMessage(isDark);
        break;
      case MessageType.transfer:
        content = _buildTransferMessage();
        break;
      case MessageType.encrypted:
        content = _buildEncryptedMessage(isDark);
        break;
      default:
        content = _buildTextMessage(isDark);
    }
    
    // 如果有回复，添加回复引用块
    if (message.hasReply && message.replyToContent != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildReplyQuote(isDark),
          const SizedBox(height: 4),
          content,
        ],
      );
    }
    
    return content;
  }
  
  /// 构建回复引用块
  Widget _buildReplyQuote(bool isDark) {
    final bgColor = message.isFromMe
        ? Colors.black.withOpacity(0.1)
        : (isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05));
    
    final textColor = message.isFromMe
        ? AppColors.messageTextSent.withOpacity(0.8)
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        border: Border(
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
              style: TextStyle(
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
    );
  }

  Widget _buildTextMessage(bool isDark) {
    // 微信中绿色气泡的文字是黑色，灰色气泡的文字也是黑色
    // 深色模式下，对方的灰色气泡文字是白色
    final textColor = message.isFromMe
        ? AppColors.messageTextSent  // 黑色
        : (isDark ? AppColors.textPrimaryDark : AppColors.messageTextReceived);

    return Text(
      message.content,
      style: TextStyle(
        fontSize: 16,
        color: textColor,
        height: 1.4,
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
    
    // 暂时返回提示信息
    await Future.delayed(const Duration(seconds: 1));
    return '【语音转文字需配置API密钥，详见 SpeechToTextService】';
  }

  Widget _buildVideoMessage() {
    final metadata = message.metadata;
    final thumbnailUrl = metadata?.thumbnailUrl;
    final durationMs = metadata?.duration;
    final fileSize = metadata?.size;

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
                      color: Colors.white.withOpacity(0.6),
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '视频',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                    if (fileSize != null)
                      Text(
                        _formatFileSize(fileSize),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
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
                color: Colors.black.withOpacity(0.5),
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
                    color: Colors.black.withOpacity(0.7),
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
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.videocam,
                  color: Colors.white,
                  size: 16,
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

  Widget _buildLocationMessage(bool isDark) {
    final metadata = message.metadata;
    final latitude = metadata?.latitude;
    final longitude = metadata?.longitude;

    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 地图预览占位
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.placeholder,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Icon(
                Icons.location_on,
                size: 40,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message.content.isNotEmpty ? message.content : '位置',
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
          if (latitude != null && longitude != null)
            Text(
              '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
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

  Widget _buildEncryptedMessage(bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.lock,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
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

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
  }
}

