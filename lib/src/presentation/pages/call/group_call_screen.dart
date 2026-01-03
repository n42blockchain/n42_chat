/// 多人视频会议页面
/// 
/// 支持多人音视频会议，包含网格布局、屏幕共享、参与者管理等功能
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:livekit_client/livekit_client.dart'; // 暂时禁用
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../services/voip/livekit_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/n42_avatar.dart';

/// 多人会议页面
class GroupCallScreen extends StatefulWidget {
  final LiveKitService liveKitService;
  final String roomName;
  
  const GroupCallScreen({
    super.key,
    required this.liveKitService,
    required this.roomName,
  });
  
  @override
  State<GroupCallScreen> createState() => _GroupCallScreenState();
}

class _GroupCallScreenState extends State<GroupCallScreen> {
  MeetingState _state = MeetingState.idle;
  List<MeetingParticipant> _participants = [];
  Duration _duration = Duration.zero;
  
  bool _isMuted = false;
  bool _isVideoEnabled = true;
  bool _isScreenSharing = false;
  bool _showControls = true;
  bool _showParticipantsList = false;
  
  // 当前焦点参与者（全屏显示）
  MeetingParticipant? _focusedParticipant;
  
  Timer? _hideControlsTimer;
  
  @override
  void initState() {
    super.initState();
    
    WakelockPlus.enable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    
    // 监听状态
    widget.liveKitService.onStateChanged = _onStateChanged;
    widget.liveKitService.onParticipantsChanged = _onParticipantsChanged;
    widget.liveKitService.onDurationUpdate = _onDurationUpdate;
    widget.liveKitService.onError = _onError;
    
    _state = widget.liveKitService.state;
    _participants = widget.liveKitService.participants;
    _isMuted = widget.liveKitService.isMuted;
    _isVideoEnabled = widget.liveKitService.isVideoEnabled;
    _isScreenSharing = widget.liveKitService.isScreenSharing;
    
    _startHideControlsTimer();
  }
  
  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    WakelockPlus.disable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }
  
  void _onStateChanged(MeetingState state) {
    setState(() {
      _state = state;
    });
    
    if (state == MeetingState.disconnected || state == MeetingState.failed) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.of(context).pop();
      });
    }
  }
  
  void _onParticipantsChanged(List<MeetingParticipant> participants) {
    setState(() {
      _participants = participants;
    });
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
    _hideControlsTimer = Timer(const Duration(seconds: 5), () {
      if (mounted && _state == MeetingState.connected) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }
  
  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startHideControlsTimer();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            // 参与者视频网格
            _buildVideoGrid(),
            
            // 屏幕共享覆盖层
            if (_hasScreenShare) _buildScreenShareOverlay(),
            
            // 顶部栏
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _buildTopBar(),
            ),
            
            // 底部控制栏
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _buildBottomBar(),
            ),
            
            // 参与者列表
            if (_showParticipantsList) _buildParticipantsList(),
            
            // 连接中状态
            if (_state == MeetingState.connecting) _buildConnectingOverlay(),
          ],
        ),
      ),
    );
  }
  
  bool get _hasScreenShare {
    return _participants.any((p) => p.isScreenSharing);
  }
  
  Widget _buildVideoGrid() {
    final videoParticipants = _participants
        .where((p) => p.isVideoEnabled || p.isLocal)
        .toList();
    
    if (videoParticipants.isEmpty) {
      return Container(
        color: Colors.grey[900],
        child: const Center(
          child: Text(
            '等待参与者加入...',
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
        ),
      );
    }
    
    // 焦点模式：一个大视频 + 小视频条
    if (_focusedParticipant != null) {
      return _buildFocusedLayout(videoParticipants);
    }
    
    // 网格布局
    final crossAxisCount = _getGridColumns(videoParticipants.length);
    
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 16 / 9,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: videoParticipants.length,
      itemBuilder: (context, index) {
        return _buildParticipantTile(videoParticipants[index]);
      },
    );
  }
  
  Widget _buildFocusedLayout(List<MeetingParticipant> participants) {
    final others = participants.where((p) => p.id != _focusedParticipant!.id).toList();
    
    return Column(
      children: [
        // 焦点视频
        Expanded(
          child: GestureDetector(
            onDoubleTap: () {
              setState(() {
                _focusedParticipant = null;
              });
            },
            child: _buildParticipantTile(_focusedParticipant!, showName: true),
          ),
        ),
        
        // 其他参与者横向列表
        if (others.isNotEmpty)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: others.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 160,
                  child: _buildParticipantTile(others[index], compact: true),
                );
              },
            ),
          ),
      ],
    );
  }
  
  Widget _buildParticipantTile(
    MeetingParticipant participant, {
    bool showName = true,
    bool compact = false,
  }) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _focusedParticipant = participant;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          border: participant.isSpeaking
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
        ),
        child: Stack(
          children: [
            // 视频
            if (participant.isVideoEnabled && participant.videoTrack != null)
              Positioned.fill(
                child: VideoTrackRenderer(
                  participant.videoTrack!,
                  fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              )
            else
              // 无视频时显示头像
              Positioned.fill(
                child: Container(
                  color: Colors.grey[850],
                  child: Center(
                    child: N42Avatar(
                      name: participant.name,
                      imageUrl: participant.avatarUrl,
                      size: compact ? 40 : 80,
                      borderRadius: compact ? 20 : 40,
                    ),
                  ),
                ),
              ),
            
            // 名称和状态
            if (showName)
              Positioned(
                left: 8,
                bottom: 8,
                right: 8,
                child: Row(
                  children: [
                    // 静音图标
                    if (participant.isMuted)
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.mic_off,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    
                    const SizedBox(width: 4),
                    
                    // 名称
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          participant.isLocal ? '${participant.name}（我）' : participant.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            
            // 屏幕共享标识
            if (participant.isScreenSharing)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.screen_share, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        '共享中',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildScreenShareOverlay() {
    final sharer = _participants.firstWhere(
      (p) => p.isScreenSharing,
      orElse: () => _participants.first,
    );
    
    return Positioned.fill(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            // 屏幕共享内容
            if (sharer.screenTrack != null)
              Positioned.fill(
                child: VideoTrackRenderer(
                  sharer.screenTrack!,
                  fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
                ),
              ),
            
            // 共享者信息
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.screen_share, color: AppColors.primary, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      '${sharer.name} 正在共享屏幕',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            
            // 小视频窗口（右下角）
            Positioned(
              bottom: 120,
              right: 16,
              child: SizedBox(
                width: 120,
                height: 80,
                child: _buildParticipantTile(sharer, compact: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          right: 16,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          children: [
            // 返回按钮
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => _showLeaveDialog(),
            ),
            
            // 房间信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.roomName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        '${_participants.length} 人',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDuration(_duration),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // 切换布局
            IconButton(
              icon: Icon(
                _focusedParticipant != null ? Icons.grid_view : Icons.fullscreen,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (_focusedParticipant != null) {
                    _focusedParticipant = null;
                  } else if (_participants.isNotEmpty) {
                    _focusedParticipant = _participants.first;
                  }
                });
              },
            ),
            
            // 参与者列表
            IconButton(
              icon: const Icon(Icons.people, color: Colors.white),
              onPressed: () {
                setState(() {
                  _showParticipantsList = !_showParticipantsList;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16,
          left: 24,
          right: 24,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 静音
            _buildControlButton(
              icon: _isMuted ? Icons.mic_off : Icons.mic,
              label: _isMuted ? '解除静音' : '静音',
              isActive: _isMuted,
              activeColor: Colors.red,
              onPressed: _toggleMute,
            ),
            
            // 视频
            _buildControlButton(
              icon: _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
              label: _isVideoEnabled ? '关闭视频' : '开启视频',
              isActive: !_isVideoEnabled,
              activeColor: Colors.red,
              onPressed: _toggleVideo,
            ),
            
            // 屏幕共享
            _buildControlButton(
              icon: Icons.screen_share,
              label: _isScreenSharing ? '停止共享' : '共享屏幕',
              isActive: _isScreenSharing,
              activeColor: AppColors.primary,
              onPressed: _toggleScreenShare,
            ),
            
            // 切换摄像头
            _buildControlButton(
              icon: Icons.cameraswitch,
              label: '切换',
              onPressed: _switchCamera,
            ),
            
            // 离开
            _buildControlButton(
              icon: Icons.call_end,
              label: '离开',
              backgroundColor: Colors.red,
              onPressed: _showLeaveDialog,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildControlButton({
    required IconData icon,
    required String label,
    bool isActive = false,
    Color? activeColor,
    Color? backgroundColor,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor ?? 
                  (isActive ? (activeColor ?? Colors.white) : Colors.white.withOpacity(0.2)),
            ),
            child: Icon(
              icon,
              color: backgroundColor != null || isActive ? Colors.white : Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildParticipantsList() {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        width: 280,
        color: Colors.black.withOpacity(0.9),
        child: Column(
          children: [
            // 标题栏
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    '参与者',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_participants.length}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _showParticipantsList = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            // 参与者列表
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _participants.length,
                itemBuilder: (context, index) {
                  final participant = _participants[index];
                  return _buildParticipantListItem(participant);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildParticipantListItem(MeetingParticipant participant) {
    return ListTile(
      leading: N42Avatar(
        name: participant.name,
        imageUrl: participant.avatarUrl,
        size: 40,
        borderRadius: 20,
      ),
      title: Text(
        participant.isLocal ? '${participant.name}（我）' : participant.name,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (participant.isMuted)
            const Icon(Icons.mic_off, color: Colors.red, size: 18),
          if (!participant.isVideoEnabled)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.videocam_off, color: Colors.red, size: 18),
            ),
          if (participant.isScreenSharing)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.screen_share, color: AppColors.primary, size: 18),
            ),
        ],
      ),
      onTap: () {
        setState(() {
          _focusedParticipant = participant;
          _showParticipantsList = false;
        });
      },
    );
  }
  
  Widget _buildConnectingOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              SizedBox(height: 24),
              Text(
                '正在加入会议...',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  int _getGridColumns(int count) {
    if (count <= 1) return 1;
    if (count <= 4) return 2;
    if (count <= 9) return 3;
    return 4;
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
  
  void _toggleMute() async {
    await widget.liveKitService.toggleMicrophone();
    setState(() {
      _isMuted = widget.liveKitService.isMuted;
    });
  }
  
  void _toggleVideo() async {
    await widget.liveKitService.toggleCamera();
    setState(() {
      _isVideoEnabled = widget.liveKitService.isVideoEnabled;
    });
  }
  
  void _toggleScreenShare() async {
    await widget.liveKitService.toggleScreenShare();
    setState(() {
      _isScreenSharing = widget.liveKitService.isScreenSharing;
    });
  }
  
  void _switchCamera() {
    widget.liveKitService.switchCamera();
  }
  
  void _showLeaveDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('离开会议'),
        content: const Text('确定要离开会议吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _leaveMeeting();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('离开'),
          ),
        ],
      ),
    );
  }
  
  void _leaveMeeting() {
    widget.liveKitService.leaveMeeting();
    Navigator.of(context).pop();
  }
}

