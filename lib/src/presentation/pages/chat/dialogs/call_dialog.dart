// Copyright 2021-2026 N42 Inc. All rights reserved.
// Use of this source code is governed by a dual license:
// Apache License 2.0 and MIT License.
// See LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

/// 通话对话框
///
/// 当前为模拟实现，真正的 VoIP 通话需要集成 WebRTC
///
/// 实现步骤:
/// 1. 添加 flutter_webrtc 依赖
/// 2. 配置 STUN/TURN 服务器
/// 3. 实现 ICE 候选人交换
/// 4. 管理本地和远程媒体流
///
/// 参考 FluffyChat 的 VoIP 实现
class CallDialog extends StatefulWidget {
  final String contactName;
  final String? contactAvatar;
  final bool isVideoCall;
  final VoidCallback onEnd;
  final String? roomId;

  const CallDialog({
    super.key,
    required this.contactName,
    this.contactAvatar,
    required this.isVideoCall,
    required this.onEnd,
    this.roomId,
  });

  @override
  State<CallDialog> createState() => _CallDialogState();
}

class _CallDialogState extends State<CallDialog> {
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  bool _isCameraOff = false;
  int _callDuration = 0;
  bool _isConnecting = true;
  String? _callStatusKey;

  @override
  void initState() {
    super.initState();
    _initCall();
  }

  Future<void> _initCall() async {
    debugPrint('CallDialog: Initiating ${widget.isVideoCall ? "video" : "voice"} call');
    debugPrint('CallDialog: Contact: ${widget.contactName}');
    debugPrint('CallDialog: Room ID: ${widget.roomId ?? "N/A"}');

    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _callStatusKey = 'connecting');
    }

    await Future<void>.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _callStatusKey = 'ringing');
    }

    await Future<void>.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _isConnecting = false;
        _callStatusKey = 'inCall';
      });
      _startTimer();
    }
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (mounted && !_isConnecting) {
        setState(() {
          _callDuration++;
        });
        return true;
      }
      return false;
    });
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _getCallStatusText(BuildContext context) {
    switch (_callStatusKey) {
      case 'connecting':
        return S.of(context)?.connectingCall ?? 'Connecting...';
      case 'ringing':
        return S.of(context)?.ringing ?? 'Ringing...';
      case 'inCall':
        return S.of(context)?.inCall ?? 'In call';
      default:
        return S.of(context)?.calling ?? 'Calling...';
    }
  }

  void _toggleMute() {
    setState(() => _isMuted = !_isMuted);
    debugPrint('CallDialog: Mute ${_isMuted ? "on" : "off"}');
  }

  void _toggleSpeaker() {
    setState(() => _isSpeakerOn = !_isSpeakerOn);
    debugPrint('CallDialog: Speaker ${_isSpeakerOn ? "on" : "off"}');
  }

  void _toggleCamera() {
    setState(() => _isCameraOff = !_isCameraOff);
    debugPrint('CallDialog: Camera ${_isCameraOff ? "off" : "on"}');
  }

  void _endCall() {
    debugPrint('CallDialog: Ending call, duration: $_callDuration seconds');
    widget.onEnd();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black87,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),

            // 联系人头像
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.3),
                border: Border.all(color: AppColors.primary, width: 3),
              ),
              child: widget.contactAvatar != null
                  ? ClipOval(
                      child: Image.network(
                        widget.contactAvatar!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildAvatarPlaceholder(),
                      ),
                    )
                  : _buildAvatarPlaceholder(),
            ),

            const SizedBox(height: 24),

            // 联系人名字
            Text(
              widget.contactName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // 通话状态
            Text(
              _isConnecting
                  ? _getCallStatusText(context)
                  : _formatDuration(_callDuration),
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),

            const Spacer(),

            // 控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                  label: _isMuted
                      ? (S.of(context)?.unmute ?? 'Unmute')
                      : (S.of(context)?.muteCall ?? 'Mute'),
                  isActive: _isMuted,
                  onTap: _toggleMute,
                ),
                _buildControlButton(
                  icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                  label: _isSpeakerOn
                      ? (S.of(context)?.speakerOff ?? 'Speaker Off')
                      : (S.of(context)?.speakerOn ?? 'Speaker'),
                  isActive: _isSpeakerOn,
                  onTap: _toggleSpeaker,
                ),
                if (widget.isVideoCall)
                  _buildControlButton(
                    icon: _isCameraOff ? Icons.videocam_off : Icons.videocam,
                    label: _isCameraOff
                        ? (S.of(context)?.cameraOn ?? 'Camera On')
                        : (S.of(context)?.cameraOff ?? 'Camera Off'),
                    isActive: _isCameraOff,
                    onTap: _toggleCamera,
                  ),
              ],
            ),

            const SizedBox(height: 40),

            // 挂断按钮
            GestureDetector(
              onTap: _endCall,
              child: Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              S.of(context)?.hangUp ?? 'Hang Up',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Center(
      child: Text(
        widget.contactName.isNotEmpty ? widget.contactName[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.black : Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
