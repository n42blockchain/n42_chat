import 'package:flutter/material.dart';

/// 转账消息组件
///
/// 特点：
/// - 显示转账金额
/// - 显示转账状态（待接收、已接收、已退还、已过期）
/// - 支持多种加密货币
class TransferMessageWidget extends StatelessWidget {
  /// 转账金额
  final String amount;

  /// 货币符号
  final String currency;

  /// 转账状态
  final TransferStatus status;

  /// 转账备注
  final String? note;

  /// 是否是自己发送的
  final bool isSelf;

  /// 点击回调
  final VoidCallback? onTap;

  const TransferMessageWidget({
    super.key,
    required this.amount,
    required this.currency,
    required this.status,
    this.note,
    required this.isSelf,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 主体内容
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // 货币图标
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getIconBackgroundColor(),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: _buildCurrencyIcon(),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // 金额和备注
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$amount $currency',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _getTextColor(),
                          ),
                        ),
                        if (note != null && note!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            note!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: _getTextColor().withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 底部状态栏
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.05),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    _getStatusText(),
                    style: TextStyle(
                      fontSize: 12,
                      color: _getTextColor().withValues(alpha: 0.6),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '加密转账',
                    style: TextStyle(
                      fontSize: 12,
                      color: _getTextColor().withValues(alpha: 0.6),
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

  Color _getBackgroundColor() {
    switch (status) {
      case TransferStatus.pending:
        return const Color(0xFFF9A825); // 橙黄色
      case TransferStatus.received:
        return const Color(0xFFFAEBCD); // 浅黄色（已领取）
      case TransferStatus.refunded:
      case TransferStatus.expired:
        return const Color(0xFFE0E0E0); // 灰色
    }
  }

  Color _getIconBackgroundColor() {
    switch (status) {
      case TransferStatus.pending:
        return Colors.white.withValues(alpha: 0.2);
      case TransferStatus.received:
        return const Color(0xFFF9A825).withValues(alpha: 0.2);
      case TransferStatus.refunded:
      case TransferStatus.expired:
        return Colors.grey.withValues(alpha: 0.2);
    }
  }

  Color _getTextColor() {
    switch (status) {
      case TransferStatus.pending:
        return Colors.white;
      case TransferStatus.received:
        return const Color(0xFF8B6914);
      case TransferStatus.refunded:
      case TransferStatus.expired:
        return const Color(0xFF666666);
    }
  }

  Widget _buildCurrencyIcon() {
    // 根据货币类型显示不同图标
    IconData icon;
    switch (currency.toUpperCase()) {
      case 'BTC':
        icon = Icons.currency_bitcoin;
        break;
      case 'ETH':
        icon = Icons.diamond_outlined;
        break;
      case 'USDT':
        icon = Icons.attach_money;
        break;
      default:
        icon = Icons.monetization_on_outlined;
    }

    return Icon(
      icon,
      size: 24,
      color: _getTextColor(),
    );
  }

  String _getStatusText() {
    switch (status) {
      case TransferStatus.pending:
        return isSelf ? '待对方接收' : '点击领取';
      case TransferStatus.received:
        return isSelf ? '对方已领取' : '已领取';
      case TransferStatus.refunded:
        return '已退还';
      case TransferStatus.expired:
        return '已过期';
    }
  }
}

/// 转账状态
enum TransferStatus {
  /// 待接收
  pending,

  /// 已接收
  received,

  /// 已退还
  refunded,

  /// 已过期
  expired,
}

/// 红包消息组件
class RedPacketMessageWidget extends StatelessWidget {
  /// 红包备注
  final String? note;

  /// 红包状态
  final RedPacketStatus status;

  /// 是否是自己发送的
  final bool isSelf;

  /// 点击回调
  final VoidCallback? onTap;

  const RedPacketMessageWidget({
    super.key,
    this.note,
    required this.status,
    required this.isSelf,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isOpened = status != RedPacketStatus.pending;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          gradient: isOpened
              ? null
              : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFA9D3B),
                    Color(0xFFE64340),
                  ],
                ),
          color: isOpened ? const Color(0xFFE8D5B5) : null,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 主体内容
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // 红包图标
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isOpened
                          ? const Color(0xFFD4A853).withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.redeem,
                      size: 24,
                      color: isOpened
                          ? const Color(0xFF8B6914)
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // 备注
                  Expanded(
                    child: Text(
                      note ?? '恭喜发财，大吉大利',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: isOpened
                            ? const Color(0xFF8B6914)
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 底部状态栏
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.05),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Text(
                _getStatusText(),
                style: TextStyle(
                  fontSize: 12,
                  color: isOpened
                      ? const Color(0xFF8B6914).withValues(alpha: 0.6)
                      : Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText() {
    switch (status) {
      case RedPacketStatus.pending:
        return isSelf ? '发出红包，等待领取' : '红包';
      case RedPacketStatus.opened:
        return '已领取';
      case RedPacketStatus.expired:
        return '已过期';
      case RedPacketStatus.empty:
        return '已被领完';
    }
  }
}

/// 红包状态
enum RedPacketStatus {
  /// 待领取
  pending,

  /// 已领取
  opened,

  /// 已过期
  expired,

  /// 已被领完
  empty,
}

