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
      onResend: onResend,
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

    switch (message.type) {
      case MessageType.text:
        return _buildTextMessage(isDark);
      case MessageType.image:
        return _buildImageMessage();
      case MessageType.audio:
        return _buildVoiceMessage();
      case MessageType.video:
        return _buildVideoMessage();
      case MessageType.file:
        return _buildFileMessage(isDark);
      case MessageType.location:
        return _buildLocationMessage(isDark);
      case MessageType.transfer:
        return _buildTransferMessage();
      case MessageType.encrypted:
        return _buildEncryptedMessage(isDark);
      default:
        return _buildTextMessage(isDark);
    }
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

    return ImageMessageWidget(
      imageUrl: metadata?.mediaUrl ?? '',
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

    return VoiceMessageWidget(
      duration: durationSec > 0 ? durationSec : 1,
      isSelf: message.isFromMe,
      voiceUrl: metadata?.mediaUrl,
      // 语音转文字功能（需要接入语音识别API）
      onConvertToText: metadata?.mediaUrl != null ? _convertVoiceToText : null,
    );
  }

  /// 语音转文字（待接入语音识别服务）
  Future<String?> _convertVoiceToText(String voiceUrl) async {
    // TODO: 接入语音识别API（如讯飞、百度、阿里云等）
    // 这里返回模拟数据作为演示
    await Future.delayed(const Duration(seconds: 2));
    return '【语音转文字功能开发中，请稍后...】';
  }

  Widget _buildVideoMessage() {
    final metadata = message.metadata;
    final thumbnailUrl = metadata?.thumbnailUrl;
    final durationMs = metadata?.duration;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (thumbnailUrl != null)
          ImageMessageWidget(
            imageUrl: thumbnailUrl,
            onTap: onTap,
          )
        else
          Container(
            width: 200,
            height: 150,
            color: AppColors.placeholder,
          ),
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 32,
          ),
        ),
        if (durationMs != null)
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                _formatDuration((durationMs / 1000).round()),
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
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

