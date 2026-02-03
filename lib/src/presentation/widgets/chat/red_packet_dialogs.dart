import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';

/// 发红包页面（全屏，仿微信）
class SendRedPacketPage extends StatefulWidget {
  /// 接收者名称
  final String receiverName;
  
  /// 是否是群聊
  final bool isGroup;
  
  /// 群成员数量
  final int memberCount;
  
  /// 发送回调
  final void Function(String amount, String token, String greeting, int count, bool isLucky) onSend;
  
  const SendRedPacketPage({
    super.key,
    required this.receiverName,
    this.isGroup = false,
    this.memberCount = 1,
    required this.onSend,
  });
  
  @override
  State<SendRedPacketPage> createState() => _SendRedPacketPageState();
}

class _SendRedPacketPageState extends State<SendRedPacketPage> {
  final _amountController = TextEditingController();
  final _countController = TextEditingController(text: '1');
  late final TextEditingController _greetingController;
  
  String _selectedToken = 'CNY';
  bool _isLucky = false;
  int _selectedCoverIndex = 0;

  final List<String> _tokens = ['CNY', 'ETH', 'USDT', 'BTC'];

  /// 可用的红包封面
  static const List<_RedPacketCover> _covers = [
    _RedPacketCover(
      id: 'default',
      colors: [Color(0xFFE64340), Color(0xFFD63030)],
      name: 'Classic Red',
    ),
    _RedPacketCover(
      id: 'gold',
      colors: [Color(0xFFFFB800), Color(0xFFFF8C00)],
      name: 'Golden',
    ),
    _RedPacketCover(
      id: 'purple',
      colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
      name: 'Purple',
    ),
    _RedPacketCover(
      id: 'blue',
      colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
      name: 'Ocean Blue',
    ),
    _RedPacketCover(
      id: 'green',
      colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
      name: 'Nature Green',
    ),
    _RedPacketCover(
      id: 'pink',
      colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
      name: 'Rose Pink',
    ),
  ];

  /// 常用表情列表
  static const List<String> _emojis = [
    '🎉', '🎊', '💰', '🧧', '💵', '💴', '💶', '💷',
    '🤑', '💸', '🏆', '🎁', '🎈', '🎀', '✨', '⭐',
    '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍',
    '😊', '😄', '🥳', '😎', '🤩', '😍', '🙏', '👍',
    '🐉', '🐅', '🐇', '🐕', '🐖', '🐂', '🐏', '🐔',
  ];
  
  double get _amount {
    final text = _amountController.text.trim();
    if (text.isEmpty) return 0.0;
    return double.tryParse(text) ?? 0.0;
  }
  
  /// 获取当前币种的小数位数限制
  int get _decimalPlaces {
    switch (_selectedToken) {
      case 'BTC':
        return 8;  // BTC 最多 8 位小数
      case 'ETH':
        return 18; // ETH 最多 18 位小数
      case 'CNY':
      case 'USDT':
      default:
        return 2;  // CNY/USDT 最多 2 位小数
    }
  }
  
  /// 获取金额输入的正则表达式
  String get _amountPattern => r'^\d*\.?\d{0,' + _decimalPlaces.toString() + r'}';
  
  String get _currencySymbol {
    switch (_selectedToken) {
      case 'CNY':
        return '¥';
      case 'ETH':
        return 'Ξ';
      case 'BTC':
        return '₿';
      default:
        return '\$';
    }
  }
  
  /// 切换币种时验证并截断金额小数位
  void _validateAmountDecimals() {
    final text = _amountController.text;
    if (text.isEmpty) return;
    
    final dotIndex = text.indexOf('.');
    if (dotIndex == -1) return; // 没有小数点，不需要处理
    
    final decimals = text.length - dotIndex - 1;
    if (decimals > _decimalPlaces) {
      // 截断多余的小数位
      _amountController.text = text.substring(0, dotIndex + 1 + _decimalPlaces);
      _amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _amountController.text.length),
      );
    }
  }
  
  @override
  void initState() {
    super.initState();
    _greetingController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_greetingController.text.isEmpty) {
      _greetingController.text = S.of(context)?.redPacketDefaultGreeting ?? 'Best wishes';
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _countController.dispose();
    _greetingController.dispose();
    super.dispose();
  }
  
  void _send() {
    final amount = _amountController.text.trim();
    if (amount.isEmpty || _amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.enterAmount ?? 'Enter amount')),
      );
      return;
    }

    final count = int.tryParse(_countController.text) ?? 1;
    if (widget.isGroup && _isLucky && count < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.redPacketCountMin ?? 'At least 1 red packet required')),
      );
      return;
    }
    
    widget.onSend(
      amount,
      _selectedToken,
      _greetingController.text.trim(),
      count,
      _isLucky,
    );
    Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryTextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: textColor, size: 32),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          S.of(context)?.sendRedPacket ?? 'Send Red Packet',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottomInset > 0 ? bottomInset : 48),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 
                       MediaQuery.of(context).padding.top - 
                       kToolbarHeight - 
                       (bottomInset > 0 ? bottomInset : 48),
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                const SizedBox(height: 16),
                
                // 金额输入
                _buildMenuItem(
                  context: context,
                  label: S.of(context)?.amount ?? 'Amount',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 代币选择
                      GestureDetector(
                        onTap: _showTokenPicker,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _selectedToken,
                                style: TextStyle(color: secondaryTextColor, fontSize: 14),
                              ),
                              Icon(Icons.arrow_drop_down, color: secondaryTextColor, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 140,
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(_amountPattern)),
                          ],
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: _decimalPlaces > 2 ? '0.0' : '0.00',
                            hintStyle: TextStyle(color: secondaryTextColor.withValues(alpha: 0.5)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // 祝福语输入
                _buildMenuItem(
                  context: context,
                  child: TextField(
                    controller: _greetingController,
                    maxLength: 30,
                    style: TextStyle(color: textColor, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: S.of(context)?.redPacketDefaultGreeting ?? 'Best wishes',
                      hintStyle: TextStyle(color: secondaryTextColor.withValues(alpha: 0.5)),
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.emoji_emotions_outlined, color: secondaryTextColor),
                        onPressed: _showEmojiPicker,
                      ),
                    ),
                  ),
                ),
                
                // 红包封面
                _buildMenuItem(
                  context: context,
                  onTap: _showCoverPicker,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context)?.redPacketCover ?? 'Red Packet Cover',
                              style: TextStyle(color: textColor, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _covers[_selectedCoverIndex].name,
                              style: TextStyle(color: secondaryTextColor, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      // 封面预览
                      Container(
                        width: 60,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: _covers[_selectedCoverIndex].colors,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: _buildRedPacketIcon(28, Colors.white70),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.chevron_right, color: secondaryTextColor),
                    ],
                  ),
                ),
                
                // 群聊选项
                if (widget.isGroup) ...[
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    context: context,
                    label: S.of(context)?.redPacketType ?? 'Red Packet Type',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTypeChip(context, S.of(context)?.normalRedPacket ?? 'Normal', !_isLucky, () {
                          setState(() => _isLucky = false);
                        }),
                        const SizedBox(width: 8),
                        _buildTypeChip(context, S.of(context)?.luckyRedPacket ?? 'Lucky', _isLucky, () {
                          setState(() => _isLucky = true);
                        }),
                      ],
                    ),
                  ),
                  if (_isLucky)
                    _buildMenuItem(
                      context: context,
                      label: S.of(context)?.redPacketCount ?? 'Red Packet Count',
                      trailing: SizedBox(
                        width: 80,
                        child: TextField(
                          controller: _countController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          textAlign: TextAlign.right,
                          style: TextStyle(color: textColor, fontSize: 16),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            suffixText: S.of(context)?.pieces ?? 'pcs',
                            suffixStyle: TextStyle(color: secondaryTextColor, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                ],
                
                const Spacer(),
                
                const SizedBox(height: 24),

                // 金额显示
                Text(
                  '$_currencySymbol ${_amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                const SizedBox(height: 24),

                // 发送按钮
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _amount > 0 ? _send : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE85D04),
                        disabledBackgroundColor: isDark ? const Color(0xFF4A3020) : const Color(0xFFE8D0C0),
                        foregroundColor: Colors.white,
                        disabledForegroundColor: isDark ? Colors.white38 : Colors.white60,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        S.of(context)?.putMoneyInRedPacket ?? 'Put money in',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // 底部提示
                Text(
                  S.of(context)?.redPacketRefundNotice ?? 'Unclaimed red packets will be refunded after 24 hours',
                  style: TextStyle(
                    color: secondaryTextColor.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  /// 红包图标（红色方形背景，金色¥符号）
  Widget _buildRedPacketIcon(double size, Color symbolColor) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 金色圆形背景
          Container(
            width: size * 0.6,
            height: size * 0.6,
            decoration: const BoxDecoration(
              color: Color(0xFFFFD700),
              shape: BoxShape.circle,
            ),
          ),
          // ¥符号
          Text(
            '¥',
            style: TextStyle(
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFD4380D),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMenuItem({
    required BuildContext context,
    String? label,
    Widget? trailing,
    Widget? child,
    VoidCallback? onTap,
  }) {
    final isDark = context.isDarkMode;
    final surfaceColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child ?? Row(
          children: [
            if (label != null)
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(color: textColor, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            const SizedBox(width: 8),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
  
  Widget _buildTypeChip(BuildContext context, String label, bool selected, VoidCallback onTap) {
    final isDark = context.isDarkMode;
    final secondaryTextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFE85D04)
              : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : secondaryTextColor,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
  
  void _showTokenPicker() {
    final isDark = context.isDarkMode;
    final surfaceColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

    showModalBottomSheet(
      context: context,
      backgroundColor: surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                S.of(ctx)?.selectCurrency ?? 'Select currency',
                style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            ..._tokens.map((token) => ListTile(
              title: Text(token, style: TextStyle(color: textColor)),
              trailing: _selectedToken == token
                  ? const Icon(Icons.check, color: Color(0xFFE85D04))
                  : null,
              onTap: () {
                setState(() {
                  _selectedToken = token;
                  // 切换币种时验证金额小数位
                  _validateAmountDecimals();
                });
                Navigator.pop(ctx);
              },
            )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// 显示表情选择器
  void _showEmojiPicker() {
    final isDark = context.isDarkMode;
    final surfaceColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

    showModalBottomSheet(
      context: context,
      backgroundColor: surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      S.of(ctx)?.selectEmoji ?? 'Select Emoji',
                      style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: _emojis.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // 在当前光标位置插入表情
                      final text = _greetingController.text;
                      final selection = _greetingController.selection;
                      final newText = text.replaceRange(
                        selection.start,
                        selection.end,
                        _emojis[index],
                      );
                      _greetingController.text = newText;
                      _greetingController.selection = TextSelection.fromPosition(
                        TextPosition(offset: selection.start + _emojis[index].length),
                      );
                      Navigator.pop(ctx);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          _emojis[index],
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// 显示红包封面选择器
  void _showCoverPicker() {
    final isDark = context.isDarkMode;
    final surfaceColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryTextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    showModalBottomSheet(
      context: context,
      backgroundColor: surfaceColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Container(
          height: MediaQuery.of(ctx).size.height * 0.6,
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              // 标题
              Text(
                S.of(ctx)?.selectRedPacketCover ?? 'Select Cover',
                style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              // 封面网格
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: _covers.length,
                    itemBuilder: (context, index) {
                      final cover = _covers[index];
                      final isSelected = _selectedCoverIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCoverIndex = index;
                          });
                          Navigator.pop(ctx);
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: cover.colors,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: isSelected
                                      ? Border.all(color: const Color(0xFFE85D04), width: 3)
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    // 红包图标
                                    Center(
                                      child: _buildRedPacketIcon(36, Colors.white70),
                                    ),
                                    // 选中标记
                                    if (isSelected)
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFE85D04),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              cover.name,
                              style: TextStyle(
                                color: isSelected ? const Color(0xFFE85D04) : secondaryTextColor,
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/// 红包封面数据
class _RedPacketCover {
  final String id;
  final List<Color> colors;
  final String name;

  const _RedPacketCover({
    required this.id,
    required this.colors,
    required this.name,
  });
}

/// 发红包弹窗（保留兼容性）
class SendRedPacketDialog extends StatelessWidget {
  final String receiverName;
  final bool isGroup;
  final int memberCount;
  final void Function(String amount, String token, String greeting, int count, bool isLucky) onSend;
  
  const SendRedPacketDialog({
    super.key,
    required this.receiverName,
    this.isGroup = false,
    this.memberCount = 1,
    required this.onSend,
  });
  
  @override
  Widget build(BuildContext context) {
    // 使用全屏页面代替弹窗
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => SendRedPacketPage(
            receiverName: receiverName,
            isGroup: isGroup,
            memberCount: memberCount,
            onSend: onSend,
          ),
        ),
      );
    });
    return const SizedBox.shrink();
  }
}

/// 开红包弹窗
class OpenRedPacketDialog extends StatefulWidget {
  final String senderName;
  final String? senderAvatar;
  final String? greeting;
  final OpenRedPacketStatus status;
  final String? claimedAmount;
  final String token;
  final VoidCallback? onOpen;
  final VoidCallback? onViewDetails;
  
  const OpenRedPacketDialog({
    super.key,
    required this.senderName,
    this.senderAvatar,
    this.greeting,
    this.status = OpenRedPacketStatus.canOpen,
    this.claimedAmount,
    this.token = 'CNY',
    this.onOpen,
    this.onViewDetails,
  });
  
  @override
  State<OpenRedPacketDialog> createState() => _OpenRedPacketDialogState();
}

class _OpenRedPacketDialogState extends State<OpenRedPacketDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isOpening = false;
  bool _showResult = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    if (widget.status == OpenRedPacketStatus.opened) {
      _showResult = true;
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _openRedPacket() async {
    if (_isOpening) return;
    
    setState(() => _isOpening = true);
    await _controller.forward();
    widget.onOpen?.call();
    setState(() => _showResult = true);
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _showResult ? _buildResultView() : _buildOpenView(),
    );
  }
  
  Widget _buildOpenView() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE64340), Color(0xFFD63030)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.close, color: Colors.white70, size: 24),
              ),
            ),
          ),
          
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white24,
            backgroundImage: widget.senderAvatar != null
                ? NetworkImage(widget.senderAvatar!)
                : null,
            child: widget.senderAvatar == null
                ? Text(
                    widget.senderName.isNotEmpty ? widget.senderName[0] : '?',
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  )
                : null,
          ),
          const SizedBox(height: 12),
          
          Text(
            S.of(context)?.senderRedPacket(widget.senderName) ?? '${widget.senderName}\'s Red Packet',
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),

          Text(
            widget.greeting ?? S.of(context)?.redPacketDefaultGreeting ?? 'Best wishes',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 32),
          
          if (widget.status == OpenRedPacketStatus.canOpen)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: GestureDetector(
                    onTap: _openRedPacket,
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFD700),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          S.of(context)?.openRedPacket ?? 'Open',
                          style: const TextStyle(color: Color(0xFFB8860B), fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          else
            _buildStatusMessage(),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }
  
  Widget _buildStatusMessage() {
    String message;
    switch (widget.status) {
      case OpenRedPacketStatus.opened:
        message = S.of(context)?.claimed ?? 'Claimed';
        break;
      case OpenRedPacketStatus.empty:
        message = S.of(context)?.redPacketAllClaimed ?? 'Red packet all claimed';
        break;
      case OpenRedPacketStatus.expired:
        message = S.of(context)?.redPacketExpired ?? 'Red packet expired';
        break;
      default:
        message = '';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(message, style: const TextStyle(color: Colors.white70, fontSize: 16)),
    );
  }
  
  Widget _buildResultView() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE64340), Color(0xFFD63030)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, color: Colors.white70, size: 24),
                  ),
                ),
                
                Text(
                  S.of(context)?.senderRedPacket(widget.senderName) ?? '${widget.senderName}\'s Red Packet',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),

                // 金额显示 - 使用 FittedBox 自适应
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.claimedAmount ?? '0',
                          style: const TextStyle(
                            color: Colors.white, 
                            fontSize: 48, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            ' ${widget.token}',
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton(
              onPressed: widget.onViewDetails,
              child: Text(S.of(context)?.viewRedPacketDetails ?? 'View Red Packet Details'),
            ),
          ),
        ],
      ),
    );
  }
}

enum OpenRedPacketStatus {
  canOpen,
  opened,
  empty,
  expired,
}

/// 发转账页面（全屏，解决溢出问题）
class SendTransferPage extends StatefulWidget {
  final String receiverName;
  final String? receiverAvatar;
  final Function(String amount, String token, String? memo) onSend;
  
  const SendTransferPage({
    super.key,
    required this.receiverName,
    this.receiverAvatar,
    required this.onSend,
  });
  
  @override
  State<SendTransferPage> createState() => _SendTransferPageState();
}

class _SendTransferPageState extends State<SendTransferPage> {
  final _amountController = TextEditingController();
  final _memoController = TextEditingController();
  
  String _selectedToken = 'CNY';
  final List<String> _tokens = ['CNY', 'ETH', 'USDT', 'BTC'];
  
  /// 获取当前币种的小数位数限制
  int get _decimalPlaces {
    switch (_selectedToken) {
      case 'BTC':
        return 8;  // BTC 最多 8 位小数
      case 'ETH':
        return 18; // ETH 最多 18 位小数
      case 'CNY':
      case 'USDT':
      default:
        return 2;  // CNY/USDT 最多 2 位小数
    }
  }
  
  /// 获取金额输入的正则表达式
  String get _amountPattern => r'^\d*\.?\d{0,' + _decimalPlaces.toString() + r'}';
  
  /// 切换币种时验证并截断金额小数位
  void _validateAmountDecimals() {
    final text = _amountController.text;
    if (text.isEmpty) return;
    
    final dotIndex = text.indexOf('.');
    if (dotIndex == -1) return; // 没有小数点，不需要处理
    
    final decimals = text.length - dotIndex - 1;
    if (decimals > _decimalPlaces) {
      // 截断多余的小数位
      _amountController.text = text.substring(0, dotIndex + 1 + _decimalPlaces);
      _amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _amountController.text.length),
      );
    }
  }
  
  @override
  void dispose() {
    _amountController.dispose();
    _memoController.dispose();
    super.dispose();
  }
  
  void _send() {
    final amount = _amountController.text.trim();
    if (amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.enterTransferAmount ?? 'Please enter transfer amount')),
      );
      return;
    }
    
    widget.onSend(
      amount,
      _selectedToken,
      _memoController.text.trim().isNotEmpty ? _memoController.text.trim() : null,
    );
    Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.backgroundDark : const Color(0xFFF5F5F5);
    final surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryTextColor = isDark ? AppColors.textSecondaryDark : Colors.grey;
    final chipBgColor = isDark ? Colors.white10 : Colors.grey[100];
    final dividerColor = isDark ? AppColors.dividerDark : AppColors.divider;

    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9A825),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          S.of(context)?.transfer ?? 'Transfer',
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 接收者信息
            Container(
              color: surfaceColor,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: isDark ? Colors.grey[700] : Colors.grey[200],
                    backgroundImage: widget.receiverAvatar != null
                        ? NetworkImage(widget.receiverAvatar!)
                        : null,
                    child: widget.receiverAvatar == null
                        ? Text(
                            widget.receiverName.isNotEmpty ? widget.receiverName[0] : '?',
                            style: TextStyle(color: isDark ? Colors.grey[300] : Colors.grey[600], fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context)?.transferTo ?? 'Transfer to', style: TextStyle(fontSize: 13, color: secondaryTextColor)),
                        const SizedBox(height: 2),
                        Text(widget.receiverName, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: textColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 金额输入卡片
            Container(
              color: surfaceColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context)?.transferAmount ?? 'Transfer Amount', style: TextStyle(fontSize: 14, color: secondaryTextColor)),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 币种选择
                      GestureDetector(
                        onTap: _showTokenPicker,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: chipBgColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(_selectedToken, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor)),
                              Icon(Icons.arrow_drop_down, size: 20, color: textColor),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // 金额输入
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(_amountPattern)),
                          ],
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: textColor),
                          decoration: InputDecoration(
                            hintText: '0.00',
                            hintStyle: TextStyle(color: secondaryTextColor),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Divider(height: 1, color: dividerColor),
                  const SizedBox(height: 16),

                  // 转账说明
                  TextField(
                    controller: _memoController,
                    maxLength: 50,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: S.of(context)?.addTransferNote ?? 'Add transfer note',
                      hintStyle: TextStyle(color: secondaryTextColor.withAlpha(153)),
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 转账按钮
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _send,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF9A825),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: Text(S.of(context)?.confirmTransfer ?? 'Confirm Transfer', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTokenPicker() {
    final isDark = context.isDarkMode;
    final surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

    showModalBottomSheet(
      context: context,
      backgroundColor: surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(S.of(ctx)?.selectCurrency ?? 'Select currency', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor)),
            ),
            ..._tokens.map((token) => ListTile(
              title: Text(token, style: TextStyle(color: textColor)),
              trailing: _selectedToken == token
                  ? const Icon(Icons.check, color: Color(0xFFF9A825))
                  : null,
              onTap: () {
                setState(() {
                  _selectedToken = token;
                  // 切换币种时验证金额小数位
                  _validateAmountDecimals();
                });
                Navigator.pop(ctx);
              },
            )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// 发转账弹窗（兼容性包装，自动跳转到全屏页面）
class SendTransferDialog extends StatelessWidget {
  final String receiverName;
  final String? receiverAvatar;
  final Function(String amount, String token, String? memo) onSend;
  
  const SendTransferDialog({
    super.key,
    required this.receiverName,
    this.receiverAvatar,
    required this.onSend,
  });
  
  @override
  Widget build(BuildContext context) {
    // 自动跳转到全屏页面
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => SendTransferPage(
            receiverName: receiverName,
            receiverAvatar: receiverAvatar,
            onSend: onSend,
          ),
        ),
      );
    });
    return const SizedBox.shrink();
  }
}

/// 红包详情页面（仿微信）
class RedPacketDetailPage extends StatelessWidget {
  /// 发送者名称
  final String senderName;
  
  /// 发送者头像
  final String? senderAvatar;
  
  /// 红包祝福语
  final String? greeting;
  
  /// 领取金额
  final String? claimedAmount;
  
  /// 代币类型
  final String token;
  
  /// 是否已领取
  final bool isClaimed;
  
  /// 领取者列表
  final List<RedPacketClaimer>? claimers;
  
  const RedPacketDetailPage({
    super.key,
    required this.senderName,
    this.senderAvatar,
    this.greeting,
    this.claimedAmount,
    this.token = 'CNY',
    this.isClaimed = false,
    this.claimers,
  });
  
  String _currencyUnit(BuildContext context) {
    switch (token) {
      case 'CNY':
        return S.of(context)?.yuan ?? 'CNY';
      case 'ETH':
        return 'ETH';
      case 'BTC':
        return 'BTC';
      default:
        return token;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // 顶部红色区域
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFE64340), Color(0xFFD63030), Colors.black],
                  stops: [0.0, 0.4, 1.0],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // AppBar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.chevron_left, color: Colors.white, size: 32),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // 发送者信息
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white24,
                          backgroundImage: senderAvatar != null
                              ? NetworkImage(senderAvatar!)
                              : null,
                          child: senderAvatar == null
                              ? Text(
                                  senderName.isNotEmpty ? senderName[0] : '?',
                                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                )
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          S.of(context)?.senderSentRedPacket(senderName) ?? '$senderName sent a red packet',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // 祝福语
                    Text(
                      greeting ?? S.of(context)?.redPacketDefaultGreeting ?? 'Best wishes',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 15,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // 金额显示
                    if (isClaimed && claimedAmount != null) ...[
                      // 金额显示 - 使用 FittedBox 自适应长数字
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                claimedAmount!,
                                style: const TextStyle(
                                  color: Color(0xFFFFD700),
                                  fontSize: 56,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  _currencyUnit(context),
                                  style: const TextStyle(
                                    color: Color(0xFFFFD700),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context)?.savedToBalance ?? 'Saved to balance, can transfer directly',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white.withValues(alpha: 0.7),
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // 表情回复按钮
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.orange.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Center(child: Text('🐕', style: TextStyle(fontSize: 20))),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              S.of(context)?.replyWithEmoji ?? 'Reply with this emoji',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Text(
                        S.of(context)?.redPacketExpiredOrEmpty ?? 'Red packet expired/all claimed',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          
          // 领取记录
          if (claimers != null && claimers!.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 1, color: Colors.white10),
                    ...claimers!.map((claimer) => _buildClaimerItem(context, claimer)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildClaimerItem(BuildContext context, RedPacketClaimer claimer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white24,
            backgroundImage: claimer.avatarUrl != null
                ? NetworkImage(claimer.avatarUrl!)
                : null,
            child: claimer.avatarUrl == null
                ? Text(
                    claimer.name.isNotEmpty ? claimer.name[0] : '?',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  claimer.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                if (claimer.claimTime != null)
                  Text(
                    claimer.claimTime!,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            '${claimer.amount}${_currencyUnit(context)}',
            style: const TextStyle(
              color: Color(0xFFFFD700),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// 红包领取者信息
class RedPacketClaimer {
  final String name;
  final String? avatarUrl;
  final String amount;
  final String? claimTime;
  
  const RedPacketClaimer({
    required this.name,
    this.avatarUrl,
    required this.amount,
    this.claimTime,
  });
}

/// 确认收款弹窗
class ConfirmReceiveDialog extends StatelessWidget {
  final String senderName;
  final String amount;
  final String token;
  final String? memo;
  final VoidCallback onConfirm;
  
  const ConfirmReceiveDialog({
    super.key,
    required this.senderName,
    required this.amount,
    required this.token,
    this.memo,
    required this.onConfirm,
  });
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF9A825).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.account_balance_wallet, size: 32, color: Color(0xFFF9A825)),
            ),
            const SizedBox(height: 16),
            
            Text(S.of(context)?.receivedTransfer ?? 'Received Transfer', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            Text(S.of(context)?.fromSender(senderName, senderName) ?? 'From $senderName', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const SizedBox(height: 24),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(amount, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFFF9A825))),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(' $token', style: const TextStyle(fontSize: 16, color: Color(0xFFF9A825))),
                ),
              ],
            ),
            
            if (memo != null && memo!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(memo!, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ),
            ],
            
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9A825),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: Text(S.of(context)?.confirmReceive ?? 'Confirm Receipt', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
