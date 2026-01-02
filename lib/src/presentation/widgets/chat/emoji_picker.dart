import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 表情选择器
/// 
/// 微信风格的表情选择面板，支持：
/// - 常用表情
/// - emoji 表情
/// - 分类切换
class EmojiPicker extends StatefulWidget {
  /// 表情选中回调
  final void Function(String emoji) onEmojiSelected;
  
  /// 删除按钮回调
  final VoidCallback? onBackspace;
  
  /// 发送按钮回调
  final VoidCallback? onSend;
  
  /// 高度
  final double height;

  const EmojiPicker({
    super.key,
    required this.onEmojiSelected,
    this.onBackspace,
    this.onSend,
    this.height = 260,
  });

  @override
  State<EmojiPicker> createState() => _EmojiPickerState();
}

class _EmojiPickerState extends State<EmojiPicker> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentCategory = 0;

  // 表情分类
  static const List<_EmojiCategory> _categories = [
    _EmojiCategory(
      icon: Icons.emoji_emotions_outlined,
      name: '表情',
      emojis: _faceEmojis,
    ),
    _EmojiCategory(
      icon: Icons.favorite_outline,
      name: '爱心',
      emojis: _heartEmojis,
    ),
    _EmojiCategory(
      icon: Icons.pets,
      name: '动物',
      emojis: _animalEmojis,
    ),
    _EmojiCategory(
      icon: Icons.restaurant,
      name: '食物',
      emojis: _foodEmojis,
    ),
    _EmojiCategory(
      icon: Icons.directions_car_outlined,
      name: '交通',
      emojis: _transportEmojis,
    ),
    _EmojiCategory(
      icon: Icons.celebration_outlined,
      name: '活动',
      emojis: _activityEmojis,
    ),
    _EmojiCategory(
      icon: Icons.lightbulb_outline,
      name: '物品',
      emojis: _objectEmojis,
    ),
    _EmojiCategory(
      icon: Icons.flag_outlined,
      name: '符号',
      emojis: _symbolEmojis,
    ),
  ];

  // 常用表情
  static const List<String> _faceEmojis = [
    '😀', '😃', '😄', '😁', '😆', '😅', '🤣', '😂',
    '🙂', '🙃', '😉', '😊', '😇', '🥰', '😍', '🤩',
    '😘', '😗', '☺️', '😚', '😙', '🥲', '😋', '😛',
    '😜', '🤪', '😝', '🤑', '🤗', '🤭', '🤫', '🤔',
    '🤐', '🤨', '😐', '😑', '😶', '😏', '😒', '🙄',
    '😬', '🤥', '😌', '😔', '😪', '🤤', '😴', '😷',
    '🤒', '🤕', '🤢', '🤮', '🤧', '🥵', '🥶', '🥴',
    '😵', '🤯', '🤠', '🥳', '🥸', '😎', '🤓', '🧐',
    '😕', '😟', '🙁', '☹️', '😮', '😯', '😲', '😳',
    '🥺', '😦', '😧', '😨', '😰', '😥', '😢', '😭',
    '😱', '😖', '😣', '😞', '😓', '😩', '😫', '🥱',
    '😤', '😡', '😠', '🤬', '😈', '👿', '💀', '☠️',
    '💩', '🤡', '👹', '👺', '👻', '👽', '👾', '🤖',
    '😺', '😸', '😹', '😻', '😼', '😽', '🙀', '😿',
    '😾', '🙈', '🙉', '🙊', '💋', '💌', '💘', '💝',
    '💖', '💗', '💓', '💞', '💕', '💟', '❣️', '💔',
  ];

  // 爱心表情
  static const List<String> _heartEmojis = [
    '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍',
    '🤎', '💔', '❣️', '💕', '💞', '💓', '💗', '💖',
    '💘', '💝', '💟', '♥️', '💌', '💋', '😍', '🥰',
    '😘', '😻', '💑', '👩‍❤️‍👨', '👨‍❤️‍👨', '👩‍❤️‍👩', '💏', '👩‍❤️‍💋‍👨',
  ];

  // 动物表情
  static const List<String> _animalEmojis = [
    '🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻', '🐼',
    '🐻‍❄️', '🐨', '🐯', '🦁', '🐮', '🐷', '🐽', '🐸',
    '🐵', '🙈', '🙉', '🙊', '🐒', '🐔', '🐧', '🐦',
    '🐤', '🐣', '🐥', '🦆', '🦅', '🦉', '🦇', '🐺',
    '🐗', '🐴', '🦄', '🐝', '🪱', '🐛', '🦋', '🐌',
    '🐞', '🐜', '🪰', '🪲', '🪳', '🦟', '🦗', '🕷️',
    '🕸️', '🦂', '🐢', '🐍', '🦎', '🦖', '🦕', '🐙',
    '🦑', '🦐', '🦞', '🦀', '🐡', '🐠', '🐟', '🐬',
    '🐳', '🐋', '🦈', '🐊', '🐅', '🐆', '🦓', '🦍',
    '🦧', '🦣', '🐘', '🦛', '🦏', '🐪', '🐫', '🦒',
    '🦘', '🦬', '🐃', '🐂', '🐄', '🐎', '🐖', '🐏',
    '🐑', '🦙', '🐐', '🦌', '🐕', '🐩', '🦮', '🐕‍🦺',
  ];

  // 食物表情
  static const List<String> _foodEmojis = [
    '🍎', '🍐', '🍊', '🍋', '🍌', '🍉', '🍇', '🍓',
    '🫐', '🍈', '🍒', '🍑', '🥭', '🍍', '🥥', '🥝',
    '🍅', '🍆', '🥑', '🥦', '🥬', '🥒', '🌶️', '🫑',
    '🌽', '🥕', '🫒', '🧄', '🧅', '🥔', '🍠', '🥐',
    '🥯', '🍞', '🥖', '🥨', '🧀', '🥚', '🍳', '🧈',
    '🥞', '🧇', '🥓', '🥩', '🍗', '🍖', '🦴', '🌭',
    '🍔', '🍟', '🍕', '🫓', '🥪', '🥙', '🧆', '🌮',
    '🌯', '🫔', '🥗', '🥘', '🫕', '🍝', '🍜', '🍲',
    '🍛', '🍣', '🍱', '🥟', '🦪', '🍤', '🍙', '🍚',
    '🍘', '🍥', '🥠', '🥮', '🍢', '🍡', '🍧', '🍨',
    '🍦', '🥧', '🧁', '🍰', '🎂', '🍮', '🍭', '🍬',
    '🍫', '🍿', '🍩', '🍪', '🌰', '🥜', '🍯', '🥛',
    '🍼', '☕', '🫖', '🍵', '🧃', '🥤', '🧋', '🍶',
    '🍺', '🍻', '🥂', '🍷', '🥃', '🍸', '🍹', '🧉',
  ];

  // 交通表情
  static const List<String> _transportEmojis = [
    '🚗', '🚕', '🚙', '🚌', '🚎', '🏎️', '🚓', '🚑',
    '🚒', '🚐', '🛻', '🚚', '🚛', '🚜', '🏍️', '🛵',
    '🚲', '🛴', '🛹', '🛼', '🚁', '🛩️', '✈️', '🛫',
    '🛬', '🪂', '💺', '🚀', '🛸', '🚂', '🚃', '🚄',
    '🚅', '🚆', '🚇', '🚈', '🚉', '🚊', '🚝', '🚞',
    '🚋', '🚌', '🚍', '🚎', '🚐', '🚑', '🚒', '🚓',
    '⛵', '🚤', '🛥️', '🛳️', '⛴️', '🚢', '⚓', '🪝',
    '⛽', '🚧', '🚦', '🚥', '🚏', '🗺️', '🗿', '🗽',
  ];

  // 活动表情
  static const List<String> _activityEmojis = [
    '⚽', '🏀', '🏈', '⚾', '🥎', '🎾', '🏐', '🏉',
    '🥏', '🎱', '🪀', '🏓', '🏸', '🏒', '🏑', '🥍',
    '🏏', '🪃', '🥅', '⛳', '🪁', '🏹', '🎣', '🤿',
    '🥊', '🥋', '🎽', '🛹', '🛼', '🛷', '⛸️', '🥌',
    '🎿', '⛷️', '🏂', '🪂', '🏋️', '🤼', '🤸', '⛹️',
    '🤺', '🤾', '🏌️', '🏇', '⛑️', '🧘', '🏄', '🏊',
    '🤽', '🚣', '🧗', '🚵', '🚴', '🏆', '🥇', '🥈',
    '🥉', '🏅', '🎖️', '🏵️', '🎗️', '🎫', '🎟️', '🎪',
    '🎭', '🎨', '🎬', '🎤', '🎧', '🎼', '🎹', '🥁',
    '🪘', '🎷', '🎺', '🪗', '🎸', '🪕', '🎻', '🎲',
    '♟️', '🎯', '🎳', '🎮', '🎰', '🧩', '🪄', '🎭',
  ];

  // 物品表情
  static const List<String> _objectEmojis = [
    '⌚', '📱', '📲', '💻', '⌨️', '🖥️', '🖨️', '🖱️',
    '🖲️', '🕹️', '🗜️', '💽', '💾', '💿', '📀', '📼',
    '📷', '📸', '📹', '🎥', '📽️', '🎞️', '📞', '☎️',
    '📟', '📠', '📺', '📻', '🎙️', '🎚️', '🎛️', '🧭',
    '⏱️', '⏲️', '⏰', '🕰️', '⌛', '⏳', '📡', '🔋',
    '🔌', '💡', '🔦', '🕯️', '🧯', '🛢️', '💸', '💵',
    '💴', '💶', '💷', '🪙', '💰', '💳', '💎', '⚖️',
    '🪜', '🧰', '🪛', '🔧', '🔨', '⚒️', '🛠️', '⛏️',
    '🪚', '🔩', '⚙️', '🪤', '🧱', '⛓️', '🧲', '🔫',
    '💣', '🧨', '🪓', '🔪', '🗡️', '⚔️', '🛡️', '🚬',
  ];

  // 符号表情
  static const List<String> _symbolEmojis = [
    '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍',
    '🤎', '💔', '❣️', '💕', '💞', '💓', '💗', '💖',
    '💘', '💝', '💟', '☮️', '✝️', '☪️', '🕉️', '☸️',
    '✡️', '🔯', '🕎', '☯️', '☦️', '🛐', '⛎', '♈',
    '♉', '♊', '♋', '♌', '♍', '♎', '♏', '♐',
    '♑', '♒', '♓', '🆔', '⚛️', '🉑', '☢️', '☣️',
    '📴', '📳', '🈶', '🈚', '🈸', '🈺', '🈷️', '✴️',
    '🆚', '💮', '🉐', '㊙️', '㊗️', '🈴', '🈵', '🈹',
    '🈲', '🅰️', '🅱️', '🆎', '🆑', '🅾️', '🆘', '❌',
    '⭕', '🛑', '⛔', '📛', '🚫', '💯', '💢', '♨️',
    '🚷', '🚯', '🚳', '🚱', '🔞', '📵', '🚭', '❗',
    '❕', '❓', '❔', '‼️', '⁉️', '🔅', '🔆', '〽️',
    '⚠️', '🚸', '🔱', '⚜️', '🔰', '♻️', '✅', '🈯',
    '💹', '❇️', '✳️', '❎', '🌐', '💠', 'Ⓜ️', '🌀',
    '💤', '🏧', '🚾', '♿', '🅿️', '🛗', '🈳', '🈂️',
    '🛂', '🛃', '🛄', '🛅', '🚹', '🚺', '🚼', '⚧️',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentCategory = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      height: widget.height,
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
        child: Column(
          children: [
            // 表情网格
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _categories.map((category) {
                  return _buildEmojiGrid(category.emojis, isDark);
                }).toList(),
              ),
            ),
            
            // 底部工具栏
            Container(
              height: 44,
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
                  // 分类 Tab
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: isDark 
                          ? AppColors.textSecondaryDark 
                          : AppColors.textSecondary,
                      indicatorColor: AppColors.primary,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: _categories.map((category) {
                        return Tab(
                          icon: Icon(category.icon, size: 20),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  // 删除按钮
                  if (widget.onBackspace != null)
                    GestureDetector(
                      onTap: widget.onBackspace,
                      onLongPress: () {
                        // 长按连续删除
                        widget.onBackspace?.call();
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: isDark ? AppColors.dividerDark : AppColors.divider,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.backspace_outlined,
                          size: 20,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  
                  // 发送按钮
                  if (widget.onSend != null)
                    GestureDetector(
                      onTap: widget.onSend,
                      child: Container(
                        width: 60,
                        height: 44,
                        color: AppColors.primary,
                        child: const Center(
                          child: Text(
                            '发送',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiGrid(List<String> emojis, bool isDark) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: emojis.length,
      itemBuilder: (context, index) {
        final emoji = emojis[index];
        return GestureDetector(
          onTap: () => widget.onEmojiSelected(emoji),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmojiCategory {
  final IconData icon;
  final String name;
  final List<String> emojis;

  const _EmojiCategory({
    required this.icon,
    required this.name,
    required this.emojis,
  });
}

