import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import 'message_status_indicator.dart';

/// 消息气泡组件
///
/// 支持：
/// - 左侧（接收）/ 右侧（发送）气泡
/// - 多种消息类型（文本、图片、语音、视频、文件、转账等）
/// - 消息状态指示器
/// - 长按菜单
class MessageBubble extends StatelessWidget {
  /// 消息内容Widget
  final Widget child;

  /// 是否是自己发送的消息
  final bool isSelf;

  /// 消息状态
  final MessageStatus status;

  /// 发送时间
  final DateTime? timestamp;

  /// 是否显示时间
  final bool showTimestamp;

  /// 点击回调
  final VoidCallback? onTap;

  /// 长按回调
  final VoidCallback? onLongPress;

  /// 头像URL
  final String? avatarUrl;

  /// 头像名称（用于默认头像）
  final String? avatarName;

  /// 是否显示头像
  final bool showAvatar;

  /// 头像点击回调
  final VoidCallback? onAvatarTap;
  
  /// 头像双击回调（拍一拍）
  final VoidCallback? onAvatarDoubleTap;

  /// 最大宽度占比
  final double maxWidthFactor;

  /// 气泡颜色
  final Color? bubbleColor;

  /// 重发回调
  final VoidCallback? onResend;

  /// 是否不显示气泡背景（用于图片/视频消息）
  final bool noBubble;

  const MessageBubble({
    super.key,
    required this.child,
    required this.isSelf,
    this.status = MessageStatus.sent,
    this.timestamp,
    this.showTimestamp = false,
    this.onTap,
    this.onLongPress,
    this.avatarUrl,
    this.avatarName,
    this.showAvatar = true,
    this.onAvatarTap,
    this.onAvatarDoubleTap,
    this.maxWidthFactor = 0.7,
    this.bubbleColor,
    this.onResend,
    this.noBubble = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth * maxWidthFactor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisAlignment:
            isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧头像（对方消息）
          if (!isSelf && showAvatar) _buildAvatar(isDark),
          if (!isSelf && showAvatar) const SizedBox(width: 8),

          // 消息内容
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // 时间戳
                if (showTimestamp && timestamp != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      _formatTime(timestamp!),
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),

                // 气泡 + 状态
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 发送失败图标（自己的消息，在气泡左侧）
                    if (isSelf && status == MessageStatus.failed) ...[
                      _buildFailedIndicator(),
                      const SizedBox(width: 4),
                    ],

                    // 气泡或无气泡内容
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: noBubble ? _buildNoBubbleContent() : _buildBubble(isDark),
                    ),

                    // 发送中指示器（自己的消息，在气泡右侧）
                    if (isSelf && status == MessageStatus.sending) ...[
                      const SizedBox(width: 4),
                      _buildSendingIndicator(),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // 右侧头像（自己的消息）
          if (isSelf && showAvatar) const SizedBox(width: 8),
          if (isSelf && showAvatar) _buildAvatar(isDark),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isDark) {
    // 获取认证头（用于需要认证的 Matrix 媒体）
    final accessToken = MatrixClientManager.instance.client?.accessToken;
    final headers = <String, String>{};
    if (accessToken != null && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    
    return GestureDetector(
      onTap: onAvatarTap,
      onDoubleTap: onAvatarDoubleTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.placeholder,
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAlias,
        child: avatarUrl != null && avatarUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: avatarUrl!,
                fit: BoxFit.cover,
                memCacheWidth: 80,
                memCacheHeight: 80,
                httpHeaders: headers,
                placeholder: (context, url) => _buildDefaultAvatar(),
                errorWidget: (context, url, error) {
                  debugPrint('MessageBubble: Failed to load avatar: $url, error: $error');
                  return _buildDefaultAvatar();
                },
              )
            : _buildDefaultAvatar(),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    final initial =
        avatarName?.isNotEmpty == true ? avatarName![0].toUpperCase() : '?';
    return Container(
      color: _getColorFromName(avatarName ?? ''),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// 无气泡内容（用于图片/视频消息）
  Widget _buildNoBubbleContent() {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
  }

  Widget _buildBubble(bool isDark) {
    final bgColor = bubbleColor ??
        (isSelf
            ? AppColors.bubbleSelf
            : (isDark ? AppColors.bubbleOtherDark : AppColors.bubbleOther));

    // 微信风格的气泡圆角 - 发送方右上角小圆角，接收方左上角小圆角
    final borderRadius = isSelf
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(4),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }

  Widget _buildSendingIndicator() {
    return const SizedBox(
      width: 14,
      height: 14,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }

  Widget _buildFailedIndicator() {
    return GestureDetector(
      onTap: onResend,
      child: Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: AppColors.error,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.priority_high,
          size: 14,
          color: Colors.white,
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Color _getColorFromName(String name) {
    final colors = [
      const Color(0xFF1AAD19),
      const Color(0xFF576B95),
      const Color(0xFFFA9D3B),
      const Color(0xFFE64340),
    ];
    if (name.isEmpty) return colors[0];
    final index = name.codeUnits.fold<int>(0, (sum, c) => sum + c) % colors.length;
    return colors[index];
  }
}

/// 文本消息气泡
class TextMessageBubble extends StatelessWidget {
  final String text;
  final bool isSelf;
  final MessageStatus status;
  final DateTime? timestamp;
  final bool showTimestamp;
  final VoidCallback? onLongPress;
  final String? avatarUrl;
  final String? avatarName;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onResend;

  const TextMessageBubble({
    super.key,
    required this.text,
    required this.isSelf,
    this.status = MessageStatus.sent,
    this.timestamp,
    this.showTimestamp = false,
    this.onLongPress,
    this.avatarUrl,
    this.avatarName,
    this.onAvatarTap,
    this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // 微信中绿色气泡的文字是黑色，深色模式下对方的灰色气泡文字是白色
    final textColor = isSelf
        ? AppColors.messageTextSent  // 黑色
        : (isDark ? AppColors.textPrimaryDark : AppColors.messageTextReceived);

    return MessageBubble(
      isSelf: isSelf,
      status: status,
      timestamp: timestamp,
      showTimestamp: showTimestamp,
      onLongPress: onLongPress,
      avatarUrl: avatarUrl,
      avatarName: avatarName,
      onAvatarTap: onAvatarTap,
      onResend: onResend,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
          height: 1.4,
        ),
      ),
    );
  }
}

