import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';

/// 发红包弹窗
class SendRedPacketDialog extends StatefulWidget {
  /// 接收者名称
  final String receiverName;
  
  /// 是否是群聊
  final bool isGroup;
  
  /// 群成员数量
  final int memberCount;
  
  /// 发送回调
  final Function(String amount, String token, String greeting, int count, bool isLucky) onSend;
  
  const SendRedPacketDialog({
    super.key,
    required this.receiverName,
    this.isGroup = false,
    this.memberCount = 1,
    required this.onSend,
  });
  
  @override
  State<SendRedPacketDialog> createState() => _SendRedPacketDialogState();
}

class _SendRedPacketDialogState extends State<SendRedPacketDialog> {
  final _amountController = TextEditingController();
  final _countController = TextEditingController(text: '1');
  final _greetingController = TextEditingController(text: '恭喜发财，大吉大利');
  
  String _selectedToken = 'ETH';
  bool _isLucky = false;
  
  final List<String> _tokens = ['ETH', 'USDT', 'BTC', 'N'];
  
  @override
  void dispose() {
    _amountController.dispose();
    _countController.dispose();
    _greetingController.dispose();
    super.dispose();
  }
  
  void _send() {
    final amount = _amountController.text.trim();
    if (amount.isEmpty) {
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
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE64340),
              Color(0xFFD63030),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 头部
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, color: Colors.white70, size: 24),
                  ),
                  const Expanded(
                    child: Text(
                      '发红包',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            
            // 内容区域
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 接收者
                  Text(
                    widget.isGroup ? '发给群聊' : '发给 ${widget.receiverName}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 金额输入
                  Row(
                    children: [
                      // 代币选择
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
                              return DropdownMenuItem(
                                value: token,
                                child: Text(token),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedToken = value);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // 金额
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                          ],
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            hintText: '0.00',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // 群聊选项：红包数量和类型
                  if (widget.isGroup) ...[
                    const Divider(height: 24),
                    
                    // 红包类型切换
                    Row(
                      children: [
                        _buildTypeChip('普通红包', !_isLucky, () {
                          setState(() => _isLucky = false);
                        }),
                        const SizedBox(width: 12),
                        _buildTypeChip('拼手气红包', _isLucky, () {
                          setState(() => _isLucky = true);
                        }),
                      ],
                    ),
                    
                    if (_isLucky) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text('红包个数'),
                          const Spacer(),
                          SizedBox(
                            width: 80,
                            child: TextField(
                              controller: _countController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('个'),
                        ],
                      ),
                    ],
                  ],
                  
                  const Divider(height: 24),
                  
                  // 祝福语
                  TextField(
                    controller: _greetingController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      hintText: '恭喜发财，大吉大利',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            
            // 发送按钮
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _send,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: const Color(0xFFB8860B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    '塞钱进红包',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
  
  Widget _buildTypeChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE64340) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey[600],
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

/// 开红包弹窗
class OpenRedPacketDialog extends StatefulWidget {
  /// 发送者名称
  final String senderName;
  
  /// 发送者头像
  final String? senderAvatar;
  
  /// 祝福语
  final String greeting;
  
  /// 红包状态
  final OpenRedPacketStatus status;
  
  /// 已领取金额（如果已领取）
  final String? claimedAmount;
  
  /// 代币符号
  final String token;
  
  /// 开红包回调
  final VoidCallback? onOpen;
  
  /// 查看详情回调
  final VoidCallback? onViewDetails;
  
  const OpenRedPacketDialog({
    super.key,
    required this.senderName,
    this.senderAvatar,
    this.greeting = '恭喜发财，大吉大利',
    this.status = OpenRedPacketStatus.canOpen,
    this.claimedAmount,
    this.token = 'ETH',
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
  late Animation<double> _rotateAnimation;
  bool _isOpening = false;
  bool _showResult = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _rotateAnimation = Tween<double>(begin: 0, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    
    // 如果已经领取过，直接显示结果
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
    
    // 播放开红包动画
    await _controller.forward();
    
    // 调用开红包回调
    widget.onOpen?.call();
    
    // 显示结果
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
          colors: [
            Color(0xFFE64340),
            Color(0xFFD63030),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 关闭按钮
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
          
          // 发送者信息
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white24,
            backgroundImage: widget.senderAvatar != null
                ? NetworkImage(widget.senderAvatar!)
                : null,
            child: widget.senderAvatar == null
                ? Text(
                    widget.senderName.isNotEmpty ? widget.senderName[0] : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 12),
          
          Text(
            '${widget.senderName}的红包',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          
          Text(
            widget.greeting,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 32),
          
          // 开红包按钮
          if (widget.status == OpenRedPacketStatus.canOpen)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation.value,
                    child: GestureDetector(
                      onTap: _openRedPacket,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFD700),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            '開',
                            style: TextStyle(
                              color: Color(0xFFB8860B),
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
        ),
      ),
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
          // 红色头部
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE64340),
                  Color(0xFFD63030),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                // 关闭按钮
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                
                // 金额
                Row(
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 底部操作
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

/// 开红包状态
enum OpenRedPacketStatus {
  /// 可以开
  canOpen,
  /// 已领取
  opened,
  /// 已被领完
  empty,
  /// 已过期
  expired,
}

/// 发转账弹窗
class SendTransferDialog extends StatefulWidget {
  /// 接收者名称
  final String receiverName;
  
  /// 接收者头像
  final String? receiverAvatar;
  
  /// 发送回调
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
  
  String _selectedToken = 'ETH';
  final List<String> _tokens = ['ETH', 'USDT', 'BTC', 'N'];
  
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
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
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
                            widget.receiverName.isNotEmpty
                                ? widget.receiverName[0]
                                : '?',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '转账给',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.receiverName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                  const Text(
                    '转账金额',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 代币选择
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
                              return DropdownMenuItem(
                                value: token,
                                child: Text(token),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedToken = value);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // 金额
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                          ],
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
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
                  
                  // 备注
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
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
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    '确认转账',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

/// 确认收款弹窗
class ConfirmReceiveDialog extends StatelessWidget {
  /// 发送者名称
  final String senderName;
  
  /// 金额
  final String amount;
  
  /// 代币符号
  final String token;
  
  /// 备注
  final String? memo;
  
  /// 确认收款回调
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
            // 图标
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF9A825).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                size: 32,
                color: Color(0xFFF9A825),
              ),
            ),
            const SizedBox(height: 16),
            
            // 标题
            const Text(
              '收到转账',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            
            Text(
              '来自 $senderName',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            
            // 金额
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF9A825),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    ' $token',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFF9A825),
                    ),
                  ),
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
                child: Text(
                  memo!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 24),
            
            // 确认按钮
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  '确认收款',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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

