import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 聊天输入栏
///
/// 特点：
/// - 语音/键盘切换
/// - 表情按钮
/// - 更多功能按钮
/// - 发送按钮（有内容时显示）
/// - 自动增高
class ChatInputBar extends StatefulWidget {
  /// 发送文本回调
  final ValueChanged<String>? onSendText;

  /// 语音按钮点击回调
  final VoidCallback? onVoicePressed;

  /// 表情按钮点击回调
  final VoidCallback? onEmojiPressed;

  /// 更多按钮点击回调
  final VoidCallback? onMorePressed;

  /// 输入变化回调
  final ValueChanged<String>? onChanged;

  /// 焦点变化回调
  final ValueChanged<bool>? onFocusChanged;

  /// 占位文字
  final String hintText;

  /// 是否显示语音按钮
  final bool showVoiceButton;

  /// 是否显示表情按钮
  final bool showEmojiButton;

  /// 是否显示更多按钮
  final bool showMoreButton;

  /// 是否禁用
  final bool enabled;

  /// 最大行数
  final int maxLines;

  /// 文本控制器
  final TextEditingController? controller;

  /// 焦点节点
  final FocusNode? focusNode;

  const ChatInputBar({
    super.key,
    this.onSendText,
    this.onVoicePressed,
    this.onEmojiPressed,
    this.onMorePressed,
    this.onChanged,
    this.onFocusChanged,
    this.hintText = '发送消息',
    this.showVoiceButton = true,
    this.showEmojiButton = true,
    this.showMoreButton = true,
    this.enabled = true,
    this.maxLines = 5,
    this.controller,
    this.focusNode,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isVoiceMode = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _hasText = _controller.text.isNotEmpty;

    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (_hasText != hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
    widget.onChanged?.call(_controller.text);
  }

  void _onFocusChanged() {
    widget.onFocusChanged?.call(_focusNode.hasFocus);
  }

  void _toggleVoiceMode() {
    setState(() {
      _isVoiceMode = !_isVoiceMode;
    });
    if (_isVoiceMode) {
      _focusNode.unfocus();
      widget.onVoicePressed?.call();
    }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSendText?.call(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.inputBarDark : AppColors.inputBar,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.divider,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 语音/键盘切换按钮
              if (widget.showVoiceButton)
                _buildIconButton(
                  icon: _isVoiceMode ? Icons.keyboard : Icons.mic,
                  onPressed: _toggleVoiceMode,
                  isDark: isDark,
                ),

              // 输入区域
              Expanded(
                child: _isVoiceMode
                    ? _buildVoiceButton(isDark)
                    : _buildTextField(isDark),
              ),

              // 表情按钮
              if (widget.showEmojiButton)
                _buildIconButton(
                  icon: Icons.emoji_emotions_outlined,
                  onPressed: widget.onEmojiPressed,
                  isDark: isDark,
                ),

              // 更多/发送按钮
              _hasText
                  ? _buildSendButton()
                  : (widget.showMoreButton
                      ? _buildIconButton(
                          icon: Icons.add_circle_outline,
                          onPressed: widget.onMorePressed,
                          isDark: isDark,
                        )
                      : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isDark,
  }) {
    return IconButton(
      icon: Icon(icon, size: 26),
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
      onPressed: widget.enabled ? onPressed : null,
      padding: const EdgeInsets.all(6),
      constraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 40,
      ),
    );
  }

  Widget _buildTextField(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        minLines: 1,
        textInputAction: TextInputAction.send,
        onSubmitted: (_) => _sendMessage(),
        style: TextStyle(
          fontSize: 16,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: AppColors.textTertiary,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildVoiceButton(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 40,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            // 触发语音录制
            widget.onVoicePressed?.call();
          },
          child: Center(
            child: Text(
              '按住 说话',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      child: ElevatedButton(
        onPressed: widget.enabled ? _sendMessage : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(60, 36),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 0,
        ),
        child: const Text(
          '发送',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

