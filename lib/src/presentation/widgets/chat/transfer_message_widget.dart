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
    
    // 已领取的红包使用浅棕色背景（类似微信）
    final bgColor = isOpened 
        ? const Color(0xFFD4B896) // 已领取：浅棕色/米色
        : const Color(0xFFE64340); // 未领取：红色
    
    final textColor = isOpened 
        ? const Color(0xFF8B7355) // 已领取：深棕色文字
        : Colors.white; // 未领取：白色文字

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 主体内容
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 红包图标
                      _buildRedPacketIcon(isOpened),
                      const SizedBox(width: 12),

                      // 祝福语和状态
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              note ?? '恭喜发财，大吉大利',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                            ),
                            if (isOpened) ...[
                              const SizedBox(height: 2),
                              Text(
                                _getStatusText(),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: textColor.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 底部标签区域
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                  ),
                  child: Text(
                    'N42红包',
                    style: TextStyle(
                      fontSize: 12,
                      color: textColor.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
            
            // 封面图片覆盖层（仅未领取时显示）
            if (coverImageUrl != null && !isOpened)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.25,
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
  
  /// 红包图标（圆形勾选或红包图标）
  Widget _buildRedPacketIcon(bool isOpened) {
    // 已领取：显示勾选图标（类似转账消息）
    if (isOpened) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          size: 22,
          color: Color(0xFF8B7355),
        ),
      );
    }
    
    // 未领取：显示红包图标
    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFD4380D),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: Color(0xFFFFD700),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '¥',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4380D),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getStatusText() {
    switch (status) {
      case RedPacketStatus.pending:
        return '领个好彩头';
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
