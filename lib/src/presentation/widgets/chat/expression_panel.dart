import 'package:flutter/material.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import 'emoji_picker.dart';
import 'sticker_picker.dart';
import 'gif_picker.dart';

/// 统一表情面板分页
enum ExpressionTab { emoji, sticker, gif }

/// 统一「表情 / 贴纸 / GIF」面板
///
/// 将原先分散的入口（emoji 在输入栏表情按钮、sticker/gif 埋在"+"菜单）
/// 合并为一个分页面板（竞品标准布局：底部分页切换）。各分页直接复用既有的
/// [EmojiPicker] / [StickerPicker] / [GifPicker]，发送回调由宿主透传，
/// 用 [IndexedStack] 保活避免切页重载。
class ExpressionPanel extends StatefulWidget {
  final double height;
  final ExpressionTab initialTab;

  // Emoji
  final ValueChanged<String> onEmojiSelected;
  final VoidCallback? onBackspace;
  final VoidCallback? onSend;

  // Sticker
  final StickerSelectedCallback onStickerSelected;
  final StickerLongPressedCallback? onStickerLongPressed;
  final VoidCallback? onOpenStickerStore;

  // GIF
  final GifSelectedCallback onGifSelected;
  final GifLongPressedCallback? onGifLongPressed;

  const ExpressionPanel({
    super.key,
    this.height = 300,
    this.initialTab = ExpressionTab.emoji,
    required this.onEmojiSelected,
    this.onBackspace,
    this.onSend,
    required this.onStickerSelected,
    this.onStickerLongPressed,
    this.onOpenStickerStore,
    required this.onGifSelected,
    this.onGifLongPressed,
  });

  @override
  State<ExpressionPanel> createState() => _ExpressionPanelState();
}

class _ExpressionPanelState extends State<ExpressionPanel> {
  late ExpressionTab _tab = widget.initialTab;

  static const double _tabBarHeight = 44;

  @override
  void didUpdateWidget(covariant ExpressionPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 宿主从"+"菜单以指定分页重新打开时同步
    if (oldWidget.initialTab != widget.initialTab) {
      _tab = widget.initialTab;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = (widget.height - _tabBarHeight).clamp(0.0, widget.height);
    return Container(
      height: widget.height,
      color: context.inputBarColor,
      child: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _tab.index,
              sizing: StackFit.expand,
              children: [
                EmojiPicker(
                  height: bodyHeight,
                  onEmojiSelected: widget.onEmojiSelected,
                  onBackspace: widget.onBackspace,
                  onSend: widget.onSend,
                ),
                StickerPicker(
                  height: bodyHeight,
                  onStickerSelected: widget.onStickerSelected,
                  onStickerLongPressed: widget.onStickerLongPressed,
                  onOpenStore: widget.onOpenStickerStore,
                ),
                GifPicker(
                  height: bodyHeight,
                  onGifSelected: widget.onGifSelected,
                  onGifLongPressed: widget.onGifLongPressed,
                ),
              ],
            ),
          ),
          _buildTabBar(context),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      height: _tabBarHeight,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          top: BorderSide(color: context.dividerColor, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          _tabButton(context, ExpressionTab.emoji, Icons.emoji_emotions_outlined),
          _tabButton(context, ExpressionTab.sticker, Icons.auto_awesome_outlined),
          _tabButton(context, ExpressionTab.gif, Icons.gif_box_outlined),
        ],
      ),
    );
  }

  Widget _tabButton(BuildContext context, ExpressionTab tab, IconData icon) {
    final selected = _tab == tab;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _tab = tab),
        child: Container(
          alignment: Alignment.center,
          color: selected
              ? AppColors.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          child: Icon(
            icon,
            size: 24,
            color: selected ? AppColors.primary : context.textSecondary,
          ),
        ),
      ),
    );
  }
}
