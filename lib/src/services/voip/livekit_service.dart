/// LiveKit 多人会议服务
/// 
/// 封装 livekit_client，提供多人音视频会议功能
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:livekit_client/livekit_client.dart';

import 'voip_config.dart';

/// 会议状态
enum MeetingState {
  idle,
  connecting,
  connected,
  reconnecting,
  disconnected,
  failed,
}

/// 参与者信息
class MeetingParticipant {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isLocal;
  final bool isSpeaking;
  final bool isMuted;
  final bool isVideoEnabled;
  final bool isScreenSharing;
  final VideoTrack? videoTrack;
  final AudioTrack? audioTrack;
  final VideoTrack? screenTrack;
  
  MeetingParticipant({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.isLocal = false,
    this.isSpeaking = false,
    this.isMuted = false,
    this.isVideoEnabled = true,
    this.isScreenSharing = false,
    this.videoTrack,
    this.audioTrack,
    this.screenTrack,
  });
  
  MeetingParticipant copyWith({
    bool? isSpeaking,
    bool? isMuted,
    bool? isVideoEnabled,
    bool? isScreenSharing,
    VideoTrack? videoTrack,
    AudioTrack? audioTrack,
    VideoTrack? screenTrack,
  }) {
    return MeetingParticipant(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      isLocal: isLocal,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      isMuted: isMuted ?? this.isMuted,
      isVideoEnabled: isVideoEnabled ?? this.isVideoEnabled,
      isScreenSharing: isScreenSharing ?? this.isScreenSharing,
      videoTrack: videoTrack ?? this.videoTrack,
      audioTrack: audioTrack ?? this.audioTrack,
      screenTrack: screenTrack ?? this.screenTrack,
    );
  }
}

/// 会议信息
class MeetingInfo {
  final String roomId;
  final String roomName;
  final DateTime startTime;
  final int maxParticipants;
  final bool isRecording;
  
  MeetingInfo({
    required this.roomId,
    required this.roomName,
    required this.startTime,
    this.maxParticipants = 50,
    this.isRecording = false,
  });
}

/// LiveKit 服务
class LiveKitService {
  final VoIPConfig _config;
  
  Room? _room;
  LocalParticipant? _localParticipant;
  
  MeetingState _state = MeetingState.idle;
  MeetingInfo? _currentMeeting;
  final Map<String, MeetingParticipant> _participants = {};
  
  // 本地控制状态
  bool _isMuted = false;
  bool _isVideoEnabled = true;
  bool _isScreenSharing = false;
  
  // 事件回调
  Function(MeetingState state)? onStateChanged;
  Function(List<MeetingParticipant> participants)? onParticipantsChanged;
  Function(MeetingParticipant participant)? onParticipantJoined;
  Function(MeetingParticipant participant)? onParticipantLeft;
  Function(MeetingParticipant participant)? onActiveSpeakerChanged;
  Function(String error)? onError;
  Function(bool isRecording)? onRecordingStateChanged;
  
  // 通话时长
  Timer? _durationTimer;
  Duration _duration = Duration.zero;
  Function(Duration duration)? onDurationUpdate;
  
  LiveKitService() : _config = VoIPConfig();
  
  // ============================================
  // Getters
  // ============================================
  
  MeetingState get state => _state;
  MeetingInfo? get currentMeeting => _currentMeeting;
  List<MeetingParticipant> get participants => _participants.values.toList();
  bool get isMuted => _isMuted;
  bool get isVideoEnabled => _isVideoEnabled;
  bool get isScreenSharing => _isScreenSharing;
  bool get isInMeeting => _state == MeetingState.connected;
  LocalParticipant? get localParticipant => _localParticipant;
  Duration get duration => _duration;
  
  // ============================================
  // 加入/离开会议
  // ============================================
  
  /// 加入会议
  /// 
  /// [roomName] 房间名称
  /// [token] LiveKit 访问令牌（从服务端获取）
  /// [participantName] 参与者名称
  /// [enableVideo] 是否开启视频
  /// [enableAudio] 是否开启音频
  Future<bool> joinMeeting({
    required String roomName,
    required String token,
    required String participantName,
    String? participantAvatarUrl,
    bool enableVideo = true,
    bool enableAudio = true,
  }) async {
    if (_state != MeetingState.idle) {
      debugPrint('LiveKitService: Already in a meeting');
      return false;
    }
    
    if (_config.liveKitUrl == null) {
      onError?.call('LiveKit 服务器未配置');
      return false;
    }
    
    try {
      _setState(MeetingState.connecting);
      
      // 连接选项
      final roomOptions = RoomOptions(
        adaptiveStream: true,
        dynacast: true,
        defaultAudioPublishOptions: const AudioPublishOptions(
          audioBitrate: AudioPresets.music.maxBitrate,
        ),
        defaultVideoPublishOptions: VideoPublishOptions(
          videoEncoding: VideoParametersPresets.h720_169.encoding,
          simulcast: true,
        ),
        defaultScreenShareCaptureOptions: const ScreenShareCaptureOptions(
          useiOSBroadcastExtension: true,
          maxFrameRate: 15.0,
        ),
      );
      
      // 连接到房间
      _room = Room();
      
      // 设置事件监听
      _setupRoomListeners();
      
      await _room!.connect(
        _config.liveKitUrl!,
        token,
        roomOptions: roomOptions,
      );
      
      _localParticipant = _room!.localParticipant;
      
      // 创建会议信息
      _currentMeeting = MeetingInfo(
        roomId: _room!.name ?? roomName,
        roomName: roomName,
        startTime: DateTime.now(),
      );
      
      // 添加本地参与者
      _participants[_localParticipant!.identity] = MeetingParticipant(
        id: _localParticipant!.identity,
        name: participantName,
        avatarUrl: participantAvatarUrl,
        isLocal: true,
        isMuted: !enableAudio,
        isVideoEnabled: enableVideo,
      );
      
      // 发布本地媒体
      if (enableAudio) {
        await _localParticipant!.setMicrophoneEnabled(true);
        _isMuted = false;
      }
      
      if (enableVideo) {
        await _localParticipant!.setCameraEnabled(true);
        _isVideoEnabled = true;
      }
      
      // 添加已有参与者
      for (final participant in _room!.remoteParticipants.values) {
        _addRemoteParticipant(participant);
      }
      
      _setState(MeetingState.connected);
      _startDurationTimer();
      _notifyParticipantsChanged();
      
      debugPrint('LiveKitService: Joined meeting $roomName');
      return true;
    } catch (e, stackTrace) {
      debugPrint('LiveKitService: Join meeting failed: $e');
      debugPrint('Stack: $stackTrace');
      _setState(MeetingState.failed);
      onError?.call('加入会议失败: $e');
      await _cleanup();
      return false;
    }
  }
  
  /// 离开会议
  Future<void> leaveMeeting() async {
    if (_room == null) return;
    
    try {
      await _room!.disconnect();
    } catch (e) {
      debugPrint('LiveKitService: Leave meeting failed: $e');
    }
    
    await _cleanup();
    _setState(MeetingState.disconnected);
    debugPrint('LiveKitService: Left meeting');
  }
  
  // ============================================
  // 媒体控制
  // ============================================
  
  /// 切换麦克风
  Future<void> toggleMicrophone() async {
    if (_localParticipant == null) return;
    
    _isMuted = !_isMuted;
    await _localParticipant!.setMicrophoneEnabled(!_isMuted);
    
    _updateLocalParticipant();
    debugPrint('LiveKitService: Microphone ${_isMuted ? "muted" : "unmuted"}');
  }
  
  /// 切换摄像头
  Future<void> toggleCamera() async {
    if (_localParticipant == null) return;
    
    _isVideoEnabled = !_isVideoEnabled;
    await _localParticipant!.setCameraEnabled(_isVideoEnabled);
    
    _updateLocalParticipant();
    debugPrint('LiveKitService: Camera ${_isVideoEnabled ? "enabled" : "disabled"}');
  }
  
  /// 切换前后摄像头
  Future<void> switchCamera() async {
    final videoTrack = _localParticipant?.videoTrackPublications
        .firstOrNull?.track as LocalVideoTrack?;
    
    if (videoTrack != null) {
      await videoTrack.switchCamera();
      debugPrint('LiveKitService: Camera switched');
    }
  }
  
  /// 开始屏幕共享
  Future<bool> startScreenShare() async {
    if (_localParticipant == null) return false;
    
    try {
      await _localParticipant!.setScreenShareEnabled(true);
      _isScreenSharing = true;
      _updateLocalParticipant();
      debugPrint('LiveKitService: Screen share started');
      return true;
    } catch (e) {
      debugPrint('LiveKitService: Start screen share failed: $e');
      onError?.call('屏幕共享失败: $e');
      return false;
    }
  }
  
  /// 停止屏幕共享
  Future<void> stopScreenShare() async {
    if (_localParticipant == null) return;
    
    try {
      await _localParticipant!.setScreenShareEnabled(false);
      _isScreenSharing = false;
      _updateLocalParticipant();
      debugPrint('LiveKitService: Screen share stopped');
    } catch (e) {
      debugPrint('LiveKitService: Stop screen share failed: $e');
    }
  }
  
  /// 切换屏幕共享
  Future<void> toggleScreenShare() async {
    if (_isScreenSharing) {
      await stopScreenShare();
    } else {
      await startScreenShare();
    }
  }
  
  // ============================================
  // 录制控制
  // ============================================
  
  /// 开始录制（需要服务端支持）
  Future<bool> startRecording() async {
    // TODO: 实现服务端录制 API 调用
    debugPrint('LiveKitService: Recording requires server-side implementation');
    return false;
  }
  
  /// 停止录制
  Future<void> stopRecording() async {
    // TODO: 实现服务端录制 API 调用
    debugPrint('LiveKitService: Stop recording requires server-side implementation');
  }
  
  // ============================================
  // 私有方法
  // ============================================
  
  /// 设置房间事件监听
  void _setupRoomListeners() {
    if (_room == null) return;
    
    // 参与者加入
    _room!.addListener(_onRoomEvent);
  }
  
  void _onRoomEvent() {
    final room = _room;
    if (room == null) return;
    
    // 更新参与者列表
    final currentIds = <String>{};
    
    // 检查新加入的参与者
    for (final participant in room.remoteParticipants.values) {
      currentIds.add(participant.identity);
      
      if (!_participants.containsKey(participant.identity)) {
        _addRemoteParticipant(participant);
      } else {
        _updateRemoteParticipant(participant);
      }
    }
    
    // 检查离开的参与者
    final leftIds = _participants.keys
        .where((id) => id != _localParticipant?.identity && !currentIds.contains(id))
        .toList();
    
    for (final id in leftIds) {
      final participant = _participants.remove(id);
      if (participant != null) {
        onParticipantLeft?.call(participant);
      }
    }
    
    // 更新本地参与者的轨道
    _updateLocalParticipant();
    
    _notifyParticipantsChanged();
  }
  
  /// 添加远程参与者
  void _addRemoteParticipant(RemoteParticipant participant) {
    final meetingParticipant = MeetingParticipant(
      id: participant.identity,
      name: participant.name ?? participant.identity,
      avatarUrl: participant.metadata,
      isLocal: false,
      isMuted: !participant.isMicrophoneEnabled(),
      isVideoEnabled: participant.isCameraEnabled(),
      isScreenSharing: participant.isScreenShareEnabled(),
      videoTrack: _getVideoTrack(participant),
      audioTrack: _getAudioTrack(participant),
      screenTrack: _getScreenTrack(participant),
    );
    
    _participants[participant.identity] = meetingParticipant;
    onParticipantJoined?.call(meetingParticipant);
    
    debugPrint('LiveKitService: Participant joined: ${participant.name}');
  }
  
  /// 更新远程参与者
  void _updateRemoteParticipant(RemoteParticipant participant) {
    final existing = _participants[participant.identity];
    if (existing == null) return;
    
    _participants[participant.identity] = existing.copyWith(
      isMuted: !participant.isMicrophoneEnabled(),
      isVideoEnabled: participant.isCameraEnabled(),
      isScreenSharing: participant.isScreenShareEnabled(),
      videoTrack: _getVideoTrack(participant),
      audioTrack: _getAudioTrack(participant),
      screenTrack: _getScreenTrack(participant),
    );
  }
  
  /// 更新本地参与者
  void _updateLocalParticipant() {
    if (_localParticipant == null) return;
    
    final existing = _participants[_localParticipant!.identity];
    if (existing == null) return;
    
    _participants[_localParticipant!.identity] = existing.copyWith(
      isMuted: _isMuted,
      isVideoEnabled: _isVideoEnabled,
      isScreenSharing: _isScreenSharing,
      videoTrack: _getLocalVideoTrack(),
      screenTrack: _getLocalScreenTrack(),
    );
  }
  
  /// 获取视频轨道
  VideoTrack? _getVideoTrack(RemoteParticipant participant) {
    for (final pub in participant.videoTrackPublications) {
      if (pub.source == TrackSource.camera && pub.track != null) {
        return pub.track as VideoTrack;
      }
    }
    return null;
  }
  
  /// 获取音频轨道
  AudioTrack? _getAudioTrack(RemoteParticipant participant) {
    for (final pub in participant.audioTrackPublications) {
      if (pub.track != null) {
        return pub.track as AudioTrack;
      }
    }
    return null;
  }
  
  /// 获取屏幕共享轨道
  VideoTrack? _getScreenTrack(RemoteParticipant participant) {
    for (final pub in participant.videoTrackPublications) {
      if (pub.source == TrackSource.screenShareVideo && pub.track != null) {
        return pub.track as VideoTrack;
      }
    }
    return null;
  }
  
  /// 获取本地视频轨道
  VideoTrack? _getLocalVideoTrack() {
    for (final pub in _localParticipant?.videoTrackPublications ?? []) {
      if (pub.source == TrackSource.camera && pub.track != null) {
        return pub.track as VideoTrack;
      }
    }
    return null;
  }
  
  /// 获取本地屏幕共享轨道
  VideoTrack? _getLocalScreenTrack() {
    for (final pub in _localParticipant?.videoTrackPublications ?? []) {
      if (pub.source == TrackSource.screenShareVideo && pub.track != null) {
        return pub.track as VideoTrack;
      }
    }
    return null;
  }
  
  /// 通知参与者变化
  void _notifyParticipantsChanged() {
    onParticipantsChanged?.call(participants);
  }
  
  /// 设置状态
  void _setState(MeetingState newState) {
    if (_state == newState) return;
    _state = newState;
    onStateChanged?.call(_state);
    debugPrint('LiveKitService: State changed to $_state');
  }
  
  /// 启动通话时长计时器
  void _startDurationTimer() {
    _durationTimer?.cancel();
    _duration = Duration.zero;
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _duration += const Duration(seconds: 1);
      onDurationUpdate?.call(_duration);
    });
  }
  
  /// 清理资源
  Future<void> _cleanup() async {
    _durationTimer?.cancel();
    _durationTimer = null;
    _duration = Duration.zero;
    
    _room?.removeListener(_onRoomEvent);
    _room?.dispose();
    _room = null;
    
    _localParticipant = null;
    _participants.clear();
    _currentMeeting = null;
    
    _isMuted = false;
    _isVideoEnabled = true;
    _isScreenSharing = false;
    
    debugPrint('LiveKitService: Cleaned up');
  }
  
  /// 释放资源
  Future<void> dispose() async {
    await leaveMeeting();
  }
}

