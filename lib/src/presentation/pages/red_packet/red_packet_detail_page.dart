import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';

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
        return S.of(context)?.commonYuan ?? 'CNY';
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
                          S.of(context)?.commonSenderSentRedPacket(senderName) ?? '$senderName sent a red packet',
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
                      greeting ?? S.of(context)?.commonRedPacketDefaultGreeting ?? 'Best wishes',
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
                              S.of(context)?.commonSavedToBalance ?? 'Saved to balance, can transfer directly',
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
                              S.of(context)?.commonReplyWithEmoji ?? 'Reply with this emoji',
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
                        S.of(context)?.commonRedPacketExpiredOrEmpty ?? 'Red packet expired/all claimed',
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
            
            Text(S.of(context)?.commonReceivedTransfer ?? 'Received Transfer', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            Text(S.of(context)?.commonFromSender(senderName, senderName) ?? 'From $senderName', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
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
                child: Text(S.of(context)?.commonConfirmReceive ?? 'Confirm Receipt', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
