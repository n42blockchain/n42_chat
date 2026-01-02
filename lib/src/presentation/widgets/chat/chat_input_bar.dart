import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/services/voice_service.dart';
import '../../../core/theme/app_colors.dart';

/// 语音录音结果回调
typedef VoiceRecordCallback = void Function(String path, Duration duration);

/// 聊天输入栏
///
/// 特点：
/// - 语音/键盘切换
/// - 按住录音，松开发送
/// - 表情按钮
/// - 更多功能按钮
/// - 发送按钮（有内容时显示）
/// - 自动增高
class ChatInputBar extends StatefulWidget {
  /// 发送文本回调
  final ValueChanged<String>? onSendText;

  /// 发送语音回调
  final VoiceRecordCallback? onSendVoice;

  /// 语音按钮点击回调（用于切换模式）
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
    this.onSendVoice,
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
  
  // 录音状态
  bool _isRecording = false;
  bool _cancelRecording = false;
  Duration _recordingDuration = Duration.zero;
  StreamSubscription<RecordingState>? _recordingSubscription;
  
  final VoiceService _voiceService = VoiceService();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _hasText = _controller.text.isNotEmpty;

    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
    
    // 监听录音状态
    _recordingSubscription = _voiceService.recordingStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _recordingDuration = state.duration;
        });
      }
    });
  }

  @override
  void dispose() {
    _recordingSubscription?.cancel();
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
    }
    widget.onVoicePressed?.call();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSendText?.call(text);
      _controller.clear();
    }
  }

  Future<void> _startRecording() async {
    final started = await _voiceService.startRecording();
    if (started) {
      setState(() {
        _isRecording = true;
        _cancelRecording = false;
        _recordingDuration = Duration.zero;
      });
    } else {
      // 显示权限提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('请允许使用麦克风权限'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _stopRecording() async {
    if (!_isRecording) return;
    
    if (_cancelRecording) {
      await _voiceService.cancelRecording();
      setState(() {
        _isRecording = false;
        _cancelRecording = false;
      });
      return;
    }
    
    final result = await _voiceService.stopRecording();
    setState(() {
      _isRecording = false;
    });
    
    if (result != null && result.duration.inSeconds >= 1) {
      widget.onSendVoice?.call(result.path, result.duration);
    } else if (result != null) {
      // 录音时间太短
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('录音时间太短'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  void _updateCancelState(Offset localPosition, Size size) {
    // 如果手指向上滑动超过一定距离，标记为取消
    final shouldCancel = localPosition.dy < -50;
    if (_cancelRecording != shouldCancel) {
      setState(() {
        _cancelRecording = shouldCancel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // 主输入栏
        Container(
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
        ),
        
        // 录音浮层
        if (_isRecording) _buildRecordingOverlay(isDark),
      ],
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
    return GestureDetector(
      onLongPressStart: (_) => _startRecording(),
      onLongPressEnd: (_) => _stopRecording(),
      onLongPressMoveUpdate: (details) {
        _updateCancelState(details.localPosition, context.size ?? Size.zero);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 40,
        decoration: BoxDecoration(
          color: _isRecording
              ? AppColors.primary.withOpacity(0.1)
              : (isDark ? AppColors.surfaceDark : AppColors.surface),
          borderRadius: BorderRadius.circular(4),
          border: _isRecording
              ? Border.all(color: AppColors.primary, width: 1)
              : null,
        ),
        child: Center(
          child: Text(
            _isRecording ? '松开发送，上滑取消' : '按住 说话',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _isRecording
                  ? AppColors.primary
                  : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
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

  Widget _buildRecordingOverlay(bool isDark) {
    return Positioned.fill(
      child: Container(
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 录音指示器
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: _cancelRecording ? AppColors.error : AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _cancelRecording ? Icons.delete : Icons.mic,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatDuration(_recordingDuration),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _cancelRecording ? '松开手指，取消发送' : '手指上滑，取消发送',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
