import 'package:flutter/material.dart';

/// 转账消息组件（仿微信）
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

  String get _currencySymbol {
    switch (currency.toUpperCase()) {
      case 'CNY':
        return '¥';
      case 'ETH':
        return 'Ξ';
      case 'BTC':
        return '₿';
      case 'USDT':
        return '\$';
      default:
        return '';
    }
  }

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
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // 勾选图标
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _getIconBackgroundColor(),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      status == TransferStatus.received ? Icons.check : Icons.access_time,
                      size: 20,
                      color: _getTextColor().withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // 金额和状态
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_currencySymbol$amount',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _getTextColor(),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _getStatusText(),
                          style: TextStyle(
                            fontSize: 12,
                            color: _getTextColor().withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 底部标签
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Text(
                '转账',
                style: TextStyle(
                  fontSize: 11,
                  color: _getTextColor().withOpacity(0.5),
                ),
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
        return const Color(0xFFF9A825);
      case TransferStatus.received:
        return const Color(0xFFF9A825);
      case TransferStatus.refunded:
      case TransferStatus.expired:
        return const Color(0xFFE0E0E0);
    }
  }

  Color _getIconBackgroundColor() {
    switch (status) {
      case TransferStatus.pending:
      case TransferStatus.received:
        return Colors.white.withOpacity(0.25);
      case TransferStatus.refunded:
      case TransferStatus.expired:
        return Colors.grey.withOpacity(0.2);
    }
  }

  Color _getTextColor() {
    switch (status) {
      case TransferStatus.pending:
      case TransferStatus.received:
        return Colors.white;
      case TransferStatus.refunded:
      case TransferStatus.expired:
        return const Color(0xFF666666);
    }
  }

  String _getStatusText() {
    switch (status) {
      case TransferStatus.pending:
        return isSelf ? '待对方接收' : '点击领取';
      case TransferStatus.received:
        return isSelf ? '已被接收' : '已收款';
      case TransferStatus.refunded:
        return '已退还';
      case TransferStatus.expired:
        return '已过期';
    }
  }
}

/// 转账状态
enum TransferStatus {
  pending,
  received,
  refunded,
  expired,
}

/// 红包消息组件（仿微信）
class RedPacketMessageWidget extends StatelessWidget {
  /// 红包备注/祝福语
  final String? note;

  /// 红包状态
  final RedPacketStatus status;

  /// 是否是自己发送的
  final bool isSelf;

  /// 点击回调
  final VoidCallback? onTap;
  
  /// 红包封面背景图URL
  final String? coverImageUrl;

  const RedPacketMessageWidget({
    super.key,
    this.note,
    required this.status,
    required this.isSelf,
    this.onTap,
    this.coverImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isOpened = status != RedPacketStatus.pending;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // 背景
            Container(
              decoration: BoxDecoration(
                gradient: isOpened
                    ? null
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFA9D3B), Color(0xFFE64340)],
                      ),
                color: isOpened ? const Color(0xFFE8D5B5) : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 主体内容
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // 红包图标
                        Container(
                          width: 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isOpened
                                ? const Color(0xFFD4A853).withOpacity(0.3)
                                : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/red_packet_icon.png',
                              width: 28,
                              height: 28,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.card_giftcard,
                                size: 24,
                                color: isOpened ? const Color(0xFF8B6914) : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // 祝福语
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                note ?? '恭喜发财，大吉大利',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: isOpened
                                      ? const Color(0xFF8B6914)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 底部标签
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '红包',
                          style: TextStyle(
                            fontSize: 11,
                            color: isOpened
                                ? const Color(0xFF8B6914).withOpacity(0.5)
                                : Colors.white.withOpacity(0.6),
                          ),
                        ),
                        if (isOpened) ...[
                          const Spacer(),
                          Text(
                            _getStatusText(),
                            style: TextStyle(
                              fontSize: 11,
                              color: const Color(0xFF8B6914).withOpacity(0.5),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // 封面图片覆盖层（如果有）
            if (coverImageUrl != null && !isOpened)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.3,
                  child: Image.network(
                    coverImageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
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
        return '';
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
  pending,
  opened,
  expired,
  empty,
}
