import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/entities/message_reaction_entity.dart';

/// 快速表情列表（类似微信/WhatsApp/Element）
const List<String> _quickReactions = ['😀', '🎁', '❤️', '👍', '😂', '😮'];

/// 微信风格的消息长按菜单
/// 
/// 完美复刻微信的消息操作菜单，包括：
/// - 气泡上方/下方的弹出菜单
/// - 表情快速回应栏（类似WhatsApp/Element）
/// - 两行图标按钮布局
/// - 撤回确认对话框
class WeChatMessageMenu extends StatelessWidget {
  final MessageEntity message;
  final Offset position;
  final Size messageSize;
  final VoidCallback onDismiss;
  
  // 状态
  final bool isFavorited;
  
  // 回调函数
  final VoidCallback? onCopy;
  final VoidCallback? onForward;
  final VoidCallback? onFavorite;
  final VoidCallback? onRecall;
  final VoidCallback? onMultiSelect;
  final VoidCallback? onQuote;
  final VoidCallback? onRemind;
  final VoidCallback? onSearch;
  final VoidCallback? onDelete; // 删除发送失败的消息
  final VoidCallback? onResend; // 重新发送失败的消息
  
  /// 表情回应回调
  final Function(String emoji)? onReaction;

  const WeChatMessageMenu({
    super.key,
    required this.message,
    required this.position,
    required this.messageSize,
    required this.onDismiss,
    this.isFavorited = false,
    this.onCopy,
    this.onForward,
    this.onFavorite,
    this.onRecall,
    this.onMultiSelect,
    this.onQuote,
    this.onRemind,
    this.onSearch,
    this.onDelete,
    this.onResend,
    this.onReaction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      behavior: HitTestBehavior.opaque,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // 半透明背景
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
            // 菜单
            Positioned(
              left: _calculateLeft(context),
              top: _calculateTop(context),
              child: _buildMenuContent(context),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateLeft(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const menuWidth = 320.0;
    
    // 居中或根据消息位置调整
    double left = (screenWidth - menuWidth) / 2;
    
    // 如果消息在屏幕左侧，菜单稍微偏右
    if (position.dx < screenWidth / 3) {
      left = position.dx;
    }
    // 如果消息在屏幕右侧，菜单稍微偏左
    else if (position.dx > screenWidth * 2 / 3) {
      left = position.dx - menuWidth + messageSize.width;
    }
    
    // 确保不超出屏幕
    if (left < 16) left = 16;
    if (left + menuWidth > screenWidth - 16) left = screenWidth - menuWidth - 16;
    
    return left;
  }

  double _calculateTop(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    // 菜单高度增加表情栏的高度（约60）
    const menuHeight = 190.0;
    const padding = 8.0;
    
    // 可用高度（减去键盘高度和安全区域）
    final availableHeight = screenHeight - keyboardHeight - bottomPadding;
    
    // 默认显示在消息上方
    double top = position.dy - menuHeight - padding;
    
    // 如果上方空间不够，显示在下方
    if (top < topPadding + 60) {
      top = position.dy + messageSize.height + padding;
    }
    
    // 如果下方被键盘遮挡，调整到键盘上方
    if (top + menuHeight > availableHeight - 20) {
      // 优先显示在消息上方
      top = position.dy - menuHeight - padding;
      
      // 如果上方还是不够，显示在可用区域中央
      if (top < topPadding + 60) {
        top = (topPadding + 60 + availableHeight - menuHeight) / 2;
      }
    }
    
    // 最终确保不超出可见区域
    top = top.clamp(topPadding + 20, availableHeight - menuHeight - 20);
    
    return top;
  }

  Widget _buildMenuContent(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: const Color(0xFF4C4C4C), // 微信深灰色
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 表情快速回应栏（类似WhatsApp/Element风格）
          _buildReactionBar(),
          
          // 分隔线
          Container(
            height: 0.5,
            color: Colors.white.withOpacity(0.1),
          ),
          
          // 第一行按钮
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (message.type == MessageType.text)
                  _buildMenuItem(
                    icon: Icons.content_copy_outlined,
                    label: '复制',
                    onTap: () {
                      onDismiss();
                      onCopy?.call();
                    },
                  ),
                _buildMenuItem(
                  icon: Icons.shortcut_outlined,
                  label: '转发',
                  onTap: () {
                    onDismiss();
                    onForward?.call();
                  },
                ),
                _buildMenuItem(
                  icon: isFavorited ? Icons.star : Icons.star_border_outlined,
                  label: isFavorited ? '取消收藏' : '收藏',
                  isHighlighted: isFavorited,
                  onTap: () {
                    onDismiss();
                    onFavorite?.call();
                  },
                ),
                // 发送失败的消息显示"重发"和"删除"
                if (message.isFromMe && message.status == MessageStatus.failed) ...[
                  _buildMenuItem(
                    icon: Icons.refresh,
                    label: '重发',
                    onTap: () {
                      onDismiss();
                      onResend?.call();
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.delete_outline,
                    label: '删除',
                    isHighlighted: true,
                    onTap: () {
                      onDismiss();
                      onDelete?.call();
                    },
                  ),
                ] else if (message.isFromMe)
                  _buildMenuItem(
                    icon: Icons.undo_outlined,
                    label: '撤回',
                    onTap: () {
                      onDismiss();
                      onRecall?.call();
                    },
                  ),
                _buildMenuItem(
                  icon: Icons.checklist_outlined,
                  label: '多选',
                  onTap: () {
                    onDismiss();
                    onMultiSelect?.call();
                  },
                ),
              ],
            ),
          ),
          
          // 分隔线
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 0.5,
            color: Colors.white.withOpacity(0.1),
          ),
          
          // 第二行按钮
          Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 8),
                _buildMenuItem(
                  icon: Icons.format_quote_outlined,
                  label: '引用',
                  onTap: () {
                    onDismiss();
                    onQuote?.call();
                  },
                ),
                const SizedBox(width: 20),
                _buildMenuItem(
                  icon: Icons.notifications_outlined,
                  label: '提醒',
                  onTap: () {
                    onDismiss();
                    onRemind?.call();
                  },
                ),
                const SizedBox(width: 20),
                _buildMenuItem(
                  icon: Icons.search,
                  label: '搜一搜',
                  onTap: () {
                    onDismiss();
                    onSearch?.call();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建表情快速回应栏
  Widget _buildReactionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ..._quickReactions.map((emoji) => _buildReactionItem(emoji)),
          // 更多表情按钮
          _buildMoreReactionButton(),
        ],
      ),
    );
  }

  /// 构建单个表情项
  Widget _buildReactionItem(String emoji) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onDismiss();
        onReaction?.call(emoji);
      },
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 26),
        ),
      ),
    );
  }

  /// 构建更多表情按钮
  Widget _buildMoreReactionButton() {
    return GestureDetector(
      onTap: () {
        // TODO: 显示完整表情选择器
        HapticFeedback.lightImpact();
      },
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white70,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    bool isHighlighted = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isHighlighted ? Colors.amber : Colors.white,
              size: 22,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: isHighlighted ? Colors.amber : Colors.white,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 显示微信风格的撤回确认对话框
Future<bool> showRecallConfirmDialog(BuildContext context) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (ctx) => const _RecallConfirmSheet(),
  );
  return result ?? false;
}

/// 微信风格的撤回确认底部弹窗
class _RecallConfirmSheet extends StatelessWidget {
  const _RecallConfirmSheet();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF2C2C2E) : Colors.white;
    final separatorColor = isDark ? const Color(0xFF38383A) : const Color(0xFFE5E5EA);
    
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 主要内容
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 标题
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      '撤回该条消息？',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ),
                  
                  // 分隔线
                  Container(height: 0.5, color: separatorColor),
                  
                  // 撤回按钮
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context, true),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: const Text(
                          '撤回',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFFF3B30), // iOS 红色
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // 取消按钮
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.pop(context, false),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      '取消',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: isDark ? Colors.white : const Color(0xFF007AFF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 微信风格的撤回消息提示
class RecalledMessageWidget extends StatelessWidget {
  final bool isFromMe;
  final VoidCallback? onReEdit;
  
  const RecalledMessageWidget({
    super.key,
    this.isFromMe = true,
    this.onReEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.grey[500] : Colors.grey[600];
    
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              isFromMe ? '你撤回了一条消息' : '对方撤回了一条消息',
              style: TextStyle(
                fontSize: 12,
                color: textColor,
              ),
            ),
            if (isFromMe && onReEdit != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onReEdit,
                child: Text(
                  '重新编辑',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? const Color(0xFF57A5FF) : const Color(0xFF576B95),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 消息菜单助手类
class MessageMenuHelper {
  /// 显示微信风格的消息菜单
  static void showMenu({
    required BuildContext context,
    required MessageEntity message,
    required GlobalKey messageKey,
    VoidCallback? onCopy,
    VoidCallback? onForward,
    VoidCallback? onFavorite,
    VoidCallback? onRecall,
    VoidCallback? onMultiSelect,
    VoidCallback? onQuote,
    VoidCallback? onRemind,
    VoidCallback? onSearch,
    VoidCallback? onDelete,
    VoidCallback? onResend,
    Function(String emoji)? onReaction,
    bool isFavorited = false,
  }) {
    // 获取消息气泡的位置和大小
    final RenderBox? renderBox = messageKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    
    // 震动反馈
    HapticFeedback.mediumImpact();
    
    // 显示菜单
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    
    overlayEntry = OverlayEntry(
      builder: (ctx) => WeChatMessageMenu(
        message: message,
        position: position,
        messageSize: size,
        isFavorited: isFavorited,
        onDismiss: () => overlayEntry.remove(),
        onCopy: onCopy,
        onForward: onForward,
        onFavorite: onFavorite,
        onRecall: onRecall,
        onMultiSelect: onMultiSelect,
        onQuote: onQuote,
        onRemind: onRemind,
        onSearch: onSearch,
        onDelete: onDelete,
        onResend: onResend,
        onReaction: onReaction,
      ),
    );
    
    overlay.insert(overlayEntry);
  }
  
  /// 复制文本消息
  static void copyMessage(BuildContext context, MessageEntity message) {
    if (message.type == MessageType.text) {
      Clipboard.setData(ClipboardData(text: message.content));
      _showToast(context, '已复制');
    }
  }
  
  /// 显示轻提示
  static void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}

