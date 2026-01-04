import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final Function(String amount, String token, String greeting, int count, bool isLucky) onSend;
  
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
  final _greetingController = TextEditingController(text: '恭喜发财，大吉大利');
  
  String _selectedToken = 'CNY';
  bool _isLucky = false;
  
  final List<String> _tokens = ['CNY', 'ETH', 'USDT', 'BTC'];
  
  double get _amount {
    final text = _amountController.text.trim();
    if (text.isEmpty) return 0.0;
    return double.tryParse(text) ?? 0.0;
  }
  
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
        const SnackBar(content: Text('请输入金额')),
      );
      return;
    }
    
    final count = int.tryParse(_countController.text) ?? 1;
    if (widget.isGroup && _isLucky && count < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('红包个数至少为1')),
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 32),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '发红包',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          
          // 金额输入
          _buildMenuItem(
            label: '金额',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 代币选择
                GestureDetector(
                  onTap: _showTokenPicker,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedToken,
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.white70, size: 18),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: '0.00',
                      hintStyle: TextStyle(color: Colors.white38),
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
            child: TextField(
              controller: _greetingController,
              maxLength: 30,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                hintText: '恭喜发财，大吉大利',
                hintStyle: const TextStyle(color: Colors.white38),
                border: InputBorder.none,
                counterText: '',
                contentPadding: EdgeInsets.zero,
                isDense: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.white54),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          
          // 红包封面
          _buildMenuItem(
            onTap: () {},
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '红包封面',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '领个好彩头',
                        style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),
                      ),
                    ],
                  ),
                ),
                // 封面预览
                Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFE64340), Color(0xFFD63030)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Icon(Icons.card_giftcard, color: Colors.white70, size: 24),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.white38),
              ],
            ),
          ),
          
          // 群聊选项
          if (widget.isGroup) ...[
            const SizedBox(height: 16),
            _buildMenuItem(
              label: '红包类型',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTypeChip('普通红包', !_isLucky, () {
                    setState(() => _isLucky = false);
                  }),
                  const SizedBox(width: 8),
                  _buildTypeChip('拼手气', _isLucky, () {
                    setState(() => _isLucky = true);
                  }),
                ],
              ),
            ),
            if (_isLucky)
              _buildMenuItem(
                label: '红包个数',
                trailing: SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _countController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      suffixText: '个',
                      suffixStyle: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                  ),
                ),
              ),
          ],
          
          const Spacer(),
          
          // 金额显示
          Text(
            '$_currencySymbol ${_amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
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
                  disabledBackgroundColor: const Color(0xFF4A3020),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white38,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  '塞钱进红包',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // 底部提示
          Text(
            '未领取的红包，将于24小时后发起退款',
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 12,
            ),
          ),
          
          const SizedBox(height: 48),
        ],
      ),
    );
  }
  
  Widget _buildMenuItem({
    String? label,
    Widget? trailing,
    Widget? child,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child ?? Row(
          children: [
            if (label != null)
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            const Spacer(),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
  
  Widget _buildTypeChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE85D04) : Colors.white10,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white54,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
  
  void _showTokenPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '选择币种',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            ..._tokens.map((token) => ListTile(
              title: Text(token, style: const TextStyle(color: Colors.white)),
              trailing: _selectedToken == token
                  ? const Icon(Icons.check, color: Color(0xFFE85D04))
                  : null,
              onTap: () {
                setState(() => _selectedToken = token);
                Navigator.pop(context);
              },
            )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// 发红包弹窗（保留兼容性）
class SendRedPacketDialog extends StatelessWidget {
  final String receiverName;
  final bool isGroup;
  final int memberCount;
  final Function(String amount, String token, String greeting, int count, bool isLucky) onSend;
  
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
        MaterialPageRoute(
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
  final String greeting;
  final OpenRedPacketStatus status;
  final String? claimedAmount;
  final String token;
  final VoidCallback? onOpen;
  final VoidCallback? onViewDetails;
  
  const OpenRedPacketDialog({
    super.key,
    required this.senderName,
    this.senderAvatar,
    this.greeting = '恭喜发财，大吉大利',
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
            '${widget.senderName}的红包',
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          
          Text(
            widget.greeting,
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
                      child: const Center(
                        child: Text(
                          '開',
                          style: TextStyle(color: Color(0xFFB8860B), fontSize: 28, fontWeight: FontWeight.bold),
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
        message = '已领取';
        break;
      case OpenRedPacketStatus.empty:
        message = '红包已被领完';
        break;
      case OpenRedPacketStatus.expired:
        message = '红包已过期';
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
            padding: const EdgeInsets.symmetric(vertical: 24),
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
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, color: Colors.white70, size: 24),
                    ),
                  ),
                ),
                
                Text(
                  '${widget.senderName}的红包',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 16),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.claimedAmount ?? '0',
                      style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
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
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton(
              onPressed: widget.onViewDetails,
              child: const Text('查看红包详情'),
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

/// 发转账弹窗
class SendTransferDialog extends StatefulWidget {
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
  State<SendTransferDialog> createState() => _SendTransferDialogState();
}

class _SendTransferDialogState extends State<SendTransferDialog> {
  final _amountController = TextEditingController();
  final _memoController = TextEditingController();
  
  String _selectedToken = 'CNY';
  final List<String> _tokens = ['CNY', 'ETH', 'USDT', 'BTC'];
  
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
        const SnackBar(content: Text('请输入转账金额')),
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
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 头部
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFF9A825),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, color: Colors.white70, size: 24),
                  ),
                  const Expanded(
                    child: Text(
                      '转账',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            
            // 接收者信息
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: widget.receiverAvatar != null
                        ? NetworkImage(widget.receiverAvatar!)
                        : null,
                    child: widget.receiverAvatar == null
                        ? Text(
                            widget.receiverName.isNotEmpty ? widget.receiverName[0] : '?',
                            style: TextStyle(color: Colors.grey[600], fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('转账给', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Text(widget.receiverName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const Divider(height: 1),
            
            // 金额输入
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('转账金额', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedToken,
                            isDense: true,
                            items: _tokens.map((token) {
                              return DropdownMenuItem(value: token, child: Text(token));
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) setState(() => _selectedToken = value);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                          ],
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            hintText: '0.00',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  TextField(
                    controller: _memoController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      hintText: '添加转账说明',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
            
            // 转账按钮
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _send,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF9A825),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text('确认转账', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
                color: const Color(0xFFF9A825).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.account_balance_wallet, size: 32, color: Color(0xFFF9A825)),
            ),
            const SizedBox(height: 16),
            
            const Text('收到转账', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            
            Text('来自 $senderName', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
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
                child: const Text('确认收款', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
