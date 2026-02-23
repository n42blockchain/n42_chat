import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../pages/red_packet/send_red_packet_page.dart';

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
            S.of(context)?.commonSenderRedPacket(widget.senderName) ?? '${widget.senderName}\'s Red Packet',
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),

          Text(
            widget.greeting ?? S.of(context)?.commonRedPacketDefaultGreeting ?? 'Best wishes',
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
                          S.of(context)?.commonOpenRedPacket ?? 'Open',
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
        message = S.of(context)?.commonClaimed ?? 'Claimed';
        break;
      case OpenRedPacketStatus.empty:
        message = S.of(context)?.commonRedPacketAllClaimed ?? 'Red packet all claimed';
        break;
      case OpenRedPacketStatus.expired:
        message = S.of(context)?.commonRedPacketExpired ?? 'Red packet expired';
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
                  S.of(context)?.commonSenderRedPacket(widget.senderName) ?? '${widget.senderName}\'s Red Packet',
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
              child: Text(S.of(context)?.commonViewRedPacketDetails ?? 'View Red Packet Details'),
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
