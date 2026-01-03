/// 1对1 语音/视频通话页面
/// 
/// 支持语音通话和视频通话，包含完整的通话控制功能
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../services/voip/webrtc_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/n42_avatar.dart';

/// 通话页面
class CallScreen extends StatefulWidget {
  final WebRTCService webRTCService;
  final CallSession? session;
  final bool isIncoming;
  
  const CallScreen({
    super.key,
    required this.webRTCService,
    this.session,
    this.isIncoming = false,
  });
  
  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;
  
  CallState _state = CallState.idle;
  Duration _duration = Duration.zero;
  bool _isMuted = false;
  bool _isVideoEnabled = true;
  bool _isSpeakerOn = false;
  bool _showControls = true;
  
  Timer? _hideControlsTimer;
  
  @override
  void initState() {
    super.initState();
    
    // 脉冲动画（等待接听时）
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    // 保持屏幕常亮
    WakelockPlus.enable();
    
    // 监听通话状态
    widget.webRTCService.onStateChanged = _onStateChanged;
    widget.webRTCService.onDurationUpdate = _onDurationUpdate;
    widget.webRTCService.onError = _onError;
    
    _state = widget.webRTCService.state;
    
    if (_state == CallState.ringing || _state == CallState.incoming) {
      _pulseController.repeat(reverse: true);
    }
    
    // 隐藏系统 UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  
  @override
  void dispose() {
    _pulseController.dispose();
    _hideControlsTimer?.cancel();
    WakelockPlus.disable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }
  
  void _onStateChanged(CallState state) {
    setState(() {
      _state = state;
    });
    
    if (state == CallState.connected) {
      _pulseController.stop();
      _startHideControlsTimer();
    } else if (state == CallState.ended || state == CallState.failed) {
      // 延迟关闭页面
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.of(context).pop();
      });
    }
  }
  
  void _onDurationUpdate(Duration duration) {
    setState(() {
      _duration = duration;
    });
  }
  
  void _onError(String error) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
    }
  }
  
  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    if (_isVideoCall) {
      _hideControlsTimer = Timer(const Duration(seconds: 5), () {
        if (mounted && _state == CallState.connected) {
          setState(() {
            _showControls = false;
          });
        }
      });
    }
  }
  
  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startHideControlsTimer();
    }
  }
  
  bool get _isVideoCall => 
      widget.session?.type == CallType.video ||
      widget.webRTCService.currentSession?.type == CallType.video;
  
  CallSession? get _session =>
      widget.session ?? widget.webRTCService.currentSession;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _isVideoCall && _state == CallState.connected ? _toggleControls : null,
        child: Stack(
          children: [
            // 背景
            _buildBackground(),
            
            // 远程视频（全屏）
            if (_isVideoCall) _buildRemoteVideo(),
            
            // 本地视频（画中画）
            if (_isVideoCall && _state == CallState.connected)
              _buildLocalVideo(),
            
            // 通话信息
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _buildCallInfo(),
            ),
            
            // 控制按钮
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _buildControls(),
            ),
            
            // 来电时的接听/拒绝按钮
            if (_state == CallState.incoming) _buildIncomingControls(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBackground() {
    if (_isVideoCall && _state == CallState.connected) {
      return const SizedBox.shrink();
    }
    
    // 语音通话或等待时显示渐变背景
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withOpacity(0.8),
            AppColors.primary.withOpacity(0.4),
            Colors.black,
          ],
        ),
      ),
    );
  }
  
  Widget _buildRemoteVideo() {
    return Positioned.fill(
      child: RTCVideoView(
        widget.webRTCService.remoteRenderer,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        mirror: false,
      ),
    );
  }
  
  Widget _buildLocalVideo() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 80,
      right: 16,
      child: GestureDetector(
        onTap: () {
          // 可以拖动本地视频窗口
        },
        child: Container(
          width: 120,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _isVideoEnabled
                ? RTCVideoView(
                    widget.webRTCService.localRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    mirror: true,
                  )
                : Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: Icon(
                        Icons.videocam_off,
                        color: Colors.white54,
                        size: 32,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildCallInfo() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 60,
      left: 0,
      right: 0,
      child: Column(
        children: [
          // 头像（语音通话或等待时显示）
          if (!_isVideoCall || _state != CallState.connected) ...[
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _state == CallState.ringing || _state == CallState.incoming
                      ? _pulseAnimation.value
                      : 1.0,
                  child: child,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: N42Avatar(
                  name: _session?.peerName ?? '',
                  imageUrl: _session?.peerAvatarUrl,
                  size: 100,
                  borderRadius: 50,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
          
          // 名称
          Text(
            _session?.peerName ?? '未知',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          
          // 状态文字
          Text(
            _getStatusText(),
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          
          // 通话时长
          if (_state == CallState.connected) ...[
            const SizedBox(height: 8),
            Text(
              _formatDuration(_duration),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildControls() {
    if (_state == CallState.incoming) {
      return const SizedBox.shrink();
    }
    
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      child: Column(
        children: [
          // 主控制按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 静音
              _buildControlButton(
                icon: _isMuted ? Icons.mic_off : Icons.mic,
                label: _isMuted ? '取消静音' : '静音',
                isActive: _isMuted,
                onPressed: _toggleMute,
              ),
              
              // 扬声器（语音通话时显示）
              if (!_isVideoCall)
                _buildControlButton(
                  icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                  label: _isSpeakerOn ? '听筒' : '扬声器',
                  isActive: _isSpeakerOn,
                  onPressed: _toggleSpeaker,
                ),
              
              // 视频开关（视频通话时显示）
              if (_isVideoCall)
                _buildControlButton(
                  icon: _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                  label: _isVideoEnabled ? '关闭视频' : '开启视频',
                  isActive: !_isVideoEnabled,
                  onPressed: _toggleVideo,
                ),
              
              // 切换摄像头（视频通话时显示）
              if (_isVideoCall)
                _buildControlButton(
                  icon: Icons.cameraswitch,
                  label: '切换',
                  onPressed: _switchCamera,
                ),
            ],
          ),
          
          const SizedBox(height: 40),
          
          // 挂断按钮
          _buildHangupButton(),
        ],
      ),
    );
  }
  
  Widget _buildIncomingControls() {
    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 拒绝
          _buildCircleButton(
            icon: Icons.call_end,
            color: Colors.red,
            label: '拒绝',
            onPressed: _rejectCall,
          ),
          
          // 接听
          _buildCircleButton(
            icon: _isVideoCall ? Icons.videocam : Icons.call,
            color: AppColors.primary,
            label: '接听',
            onPressed: _answerCall,
          ),
        ],
      ),
    );
  }
  
  Widget _buildControlButton({
    required IconData icon,
    required String label,
    bool isActive = false,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
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
  
  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required String label,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHangupButton() {
    return GestureDetector(
      onTap: _hangup,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.call_end,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
  
  String _getStatusText() {
    switch (_state) {
      case CallState.ringing:
        return '正在呼叫...';
      case CallState.incoming:
        return _isVideoCall ? '视频来电' : '语音来电';
      case CallState.connecting:
        return '连接中...';
      case CallState.connected:
        return _isVideoCall ? '视频通话中' : '语音通话中';
      case CallState.reconnecting:
        return '重新连接中...';
      case CallState.ended:
        return '通话已结束';
      case CallState.failed:
        return '通话失败';
      case CallState.idle:
      default:
        return '';
    }
  }
  
  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
  
  void _toggleMute() {
    widget.webRTCService.toggleMute();
    setState(() {
      _isMuted = widget.webRTCService.isMuted;
    });
  }
  
  void _toggleSpeaker() {
    widget.webRTCService.toggleSpeaker();
    setState(() {
      _isSpeakerOn = widget.webRTCService.isSpeakerOn;
    });
  }
  
  void _toggleVideo() {
    widget.webRTCService.toggleVideo();
    setState(() {
      _isVideoEnabled = widget.webRTCService.isVideoEnabled;
    });
  }
  
  void _switchCamera() {
    widget.webRTCService.switchCamera();
  }
  
  void _answerCall() {
    widget.webRTCService.answerCall();
  }
  
  void _rejectCall() {
    widget.webRTCService.rejectCall();
    Navigator.of(context).pop();
  }
  
  void _hangup() {
    widget.webRTCService.hangup();
  }
}

