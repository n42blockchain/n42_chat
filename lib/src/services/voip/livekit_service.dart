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

/// 会议错误类型（用于国际化）
enum MeetingErrorType {
  /// LiveKit 服务器未配置
  serverNotConfigured,
  /// 加入会议失败
  joinFailed,
  /// 屏幕共享失败
  screenShareFailed,
  /// 连接断开
  connectionLost,
  /// 未知错误
  unknown,
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
class LiveKitService extends ChangeNotifier {
  final VoIPConfig _config;

  Room? _room;
  LocalParticipant? _localParticipant;
  EventsListener<RoomEvent>? _roomListener;

  MeetingState _state = MeetingState.idle;
  MeetingInfo? _currentMeeting;
  final Map<String, MeetingParticipant> _participants = {};

  // 本地控制状态
  bool _isMuted = false;
  bool _isVideoEnabled = true;
  bool _isScreenSharing = false;

  // 事件回调
  void Function(MeetingState state)? onStateChanged;
  void Function(List<MeetingParticipant> participants)? onParticipantsChanged;
  void Function(MeetingParticipant participant)? onParticipantJoined;
  void Function(MeetingParticipant participant)? onParticipantLeft;
  void Function(MeetingParticipant participant)? onActiveSpeakerChanged;
  /// 错误回调，传递错误类型和可选的详细信息
  /// 调用方应根据 [MeetingErrorType] 显示国际化的错误消息
  void Function(MeetingErrorType type, [String? details])? onError;
  void Function(bool isRecording)? onRecordingStateChanged;

  // 通话时长
  Timer? _durationTimer;
  Duration _duration = Duration.zero;
  void Function(Duration duration)? onDurationUpdate;

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
  Room? get room => _room;

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
      onError?.call(MeetingErrorType.serverNotConfigured);
      return false;
    }

    try {
      _setState(MeetingState.connecting);

      // 获取音频处理配置
      final audioConfig = _config.audioProcessing;

      // 创建房间实例
      _room = Room(
        roomOptions: RoomOptions(
          adaptiveStream: true,
          dynacast: true,
          defaultAudioPublishOptions: const AudioPublishOptions(
            audioBitrate: AudioPreset.music,
          ),
          defaultVideoPublishOptions: const VideoPublishOptions(
            simulcast: true,
            videoCodec: 'VP8',
          ),
          defaultScreenShareCaptureOptions: const ScreenShareCaptureOptions(
            useiOSBroadcastExtension: true,
            maxFrameRate: 15.0,
          ),
          // 音频处理配置
          defaultAudioCaptureOptions: AudioCaptureOptions(
            echoCancellation: audioConfig.echoCancellation,
            noiseSuppression: audioConfig.noiseSuppression,
            autoGainControl: audioConfig.autoGainControl,
            highPassFilter: audioConfig.highPassFilter,
          ),
        ),
      );
      debugPrint('LiveKitService: Room created with audio processing: $audioConfig');

      // 设置事件监听
      _setupRoomListeners();

      // 连接到房间
      await _room!.connect(
        _config.liveKitUrl!,
        token,
        fastConnectOptions: FastConnectOptions(
          microphone: TrackOption(enabled: enableAudio),
          camera: TrackOption(enabled: enableVideo),
        ),
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

      _isMuted = !enableAudio;
      _isVideoEnabled = enableVideo;

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
      onError?.call(MeetingErrorType.joinFailed, e.toString());
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
    final publication = _localParticipant?.videoTrackPublications
        .where((pub) => pub.source == TrackSource.camera)
        .firstOrNull;

    final videoTrack = publication?.track;
    if (videoTrack is LocalVideoTrack) {
      // 切换摄像头
      final captureOptions = videoTrack.currentOptions;
      if (captureOptions is CameraCaptureOptions) {
        final newPosition = captureOptions.cameraPosition == CameraPosition.front
            ? CameraPosition.back
            : CameraPosition.front;
        await videoTrack.setCameraPosition(newPosition);
        debugPrint('LiveKitService: Camera switched to $newPosition');
      }
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
      onError?.call(MeetingErrorType.screenShareFailed, e.toString());
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
  // 音频处理控制
  // ============================================

  /// 切换降噪功能
  Future<void> toggleNoiseSuppression() async {
    _config.enableNoiseSuppression = !_config.enableNoiseSuppression;
    await _updateAudioProcessing();
  }

  /// 切换回声消除
  Future<void> toggleEchoCancellation() async {
    _config.enableEchoCancellation = !_config.enableEchoCancellation;
    await _updateAudioProcessing();
  }

  /// 切换自动增益控制
  Future<void> toggleAutoGainControl() async {
    _config.enableAutoGainControl = !_config.enableAutoGainControl;
    await _updateAudioProcessing();
  }

  /// 切换增强模式
  Future<void> toggleEnhancedMode() async {
    _config.enableEnhancedAudioMode = !_config.enableEnhancedAudioMode;
    await _updateAudioProcessing();
  }

  /// 获取当前音频处理配置
  AudioProcessingConfig get audioProcessingConfig => _config.audioProcessing;

  /// 更新音频处理设置
  Future<void> _updateAudioProcessing() async {
    if (_localParticipant == null) return;

    final audioConfig = _config.audioProcessing;
    debugPrint('LiveKitService: Updating audio processing: $audioConfig');

    // LiveKit 需要重新发布音轨来应用新的音频处理设置
    // 先禁用麦克风，再重新启用
    try {
      await _localParticipant!.setMicrophoneEnabled(false);
      await Future.delayed(const Duration(milliseconds: 100));
      await _localParticipant!.setMicrophoneEnabled(!_isMuted);
      debugPrint('LiveKitService: Audio processing updated successfully');
    } catch (e) {
      debugPrint('LiveKitService: Failed to update audio processing: $e');
    }

    notifyListeners();
  }

  // ============================================
  // 背景处理控制
  // ============================================

  /// 获取当前背景处理配置
  BackgroundProcessingConfig get backgroundProcessingConfig => _config.backgroundProcessing;

  /// 是否启用了背景处理
  bool get isBackgroundProcessingEnabled => _config.backgroundMode != BackgroundMode.none;

  /// 启用背景模糊
  ///
  /// [radius] 模糊半径 (0.0 - 1.0)
  Future<void> enableBackgroundBlur({double radius = 0.5}) async {
    _config.backgroundMode = BackgroundMode.blur;
    _config.backgroundBlurRadius = radius.clamp(0.0, 1.0);
    await _updateBackgroundProcessing();
  }

  /// 设置虚拟背景
  ///
  /// [imageUrl] 背景图片的 URL 或本地路径
  Future<void> setVirtualBackground(String imageUrl) async {
    _config.backgroundMode = BackgroundMode.virtualBackground;
    _config.virtualBackgroundUrl = imageUrl;
    await _updateBackgroundProcessing();
  }

  /// 禁用背景处理
  Future<void> disableBackgroundProcessing() async {
    _config.backgroundMode = BackgroundMode.none;
    await _updateBackgroundProcessing();
  }

  /// 切换背景模糊
  Future<void> toggleBackgroundBlur() async {
    if (_config.backgroundMode == BackgroundMode.blur) {
      await disableBackgroundProcessing();
    } else {
      await enableBackgroundBlur();
    }
  }

  /// 调整背景模糊强度
  Future<void> setBackgroundBlurRadius(double radius) async {
    if (_config.backgroundMode != BackgroundMode.blur) return;

    _config.backgroundBlurRadius = radius.clamp(0.0, 1.0);
    await _updateBackgroundProcessing();
  }

  /// 更新背景处理设置
  ///
  /// 注意：LiveKit 的背景处理需要使用视频处理器（Video Processor）
  /// 这里提供了配置更新的框架，实际的视频处理需要配合 UI 层实现
  Future<void> _updateBackgroundProcessing() async {
    final bgConfig = _config.backgroundProcessing;
    debugPrint('LiveKitService: Updating background processing: $bgConfig');

    // LiveKit 背景模糊通过 LocalVideoTrack 的处理器实现
    // 需要重新设置视频轨道来应用新设置
    if (_localParticipant == null || !_isVideoEnabled) {
      debugPrint('LiveKitService: No active video to apply background processing');
      notifyListeners();
      return;
    }

    try {
      // 获取当前的视频轨道
      final publication = _localParticipant?.videoTrackPublications
          .where((pub) => pub.source == TrackSource.camera)
          .firstOrNull;

      final videoTrack = publication?.track;
      if (videoTrack is LocalVideoTrack) {
        // 根据背景模式应用不同的处理
        switch (_config.backgroundMode) {
          case BackgroundMode.blur:
            debugPrint('LiveKitService: Background blur enabled with radius: ${_config.backgroundBlurRadius}');
            // 实际的模糊处理需要通过 VideoProcessor 实现
            // 这里记录配置，由 UI 层应用实际的视觉效果
            break;
          case BackgroundMode.virtualBackground:
            debugPrint('LiveKitService: Virtual background set: ${_config.virtualBackgroundUrl}');
            // 虚拟背景需要使用人像分割和图像合成
            break;
          case BackgroundMode.solidColor:
            debugPrint('LiveKitService: Solid color background applied');
            break;
          case BackgroundMode.none:
            debugPrint('LiveKitService: Background processing disabled');
            break;
        }
      }

      notifyListeners();
    } catch (e) {
      debugPrint('LiveKitService: Failed to update background processing: $e');
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

    _roomListener = _room!.createListener();

    // 参与者加入
    _roomListener!.on<ParticipantConnectedEvent>((event) {
      _addRemoteParticipant(event.participant);
      _notifyParticipantsChanged();
    });

    // 参与者离开
    _roomListener!.on<ParticipantDisconnectedEvent>((event) {
      final participant = _participants.remove(event.participant.identity);
      if (participant != null) {
        onParticipantLeft?.call(participant);
      }
      _notifyParticipantsChanged();
    });

    // 轨道订阅
    _roomListener!.on<TrackSubscribedEvent>((event) {
      _updateRemoteParticipant(event.participant);
      _notifyParticipantsChanged();
    });

    // 轨道取消订阅
    _roomListener!.on<TrackUnsubscribedEvent>((event) {
      _updateRemoteParticipant(event.participant);
      _notifyParticipantsChanged();
    });

    // 轨道静音状态变化
    _roomListener!.on<TrackMutedEvent>((event) {
      if (event.participant is RemoteParticipant) {
        _updateRemoteParticipant(event.participant as RemoteParticipant);
      }
      _notifyParticipantsChanged();
    });

    _roomListener!.on<TrackUnmutedEvent>((event) {
      if (event.participant is RemoteParticipant) {
        _updateRemoteParticipant(event.participant as RemoteParticipant);
      }
      _notifyParticipantsChanged();
    });

    // 活跃说话人变化
    _roomListener!.on<ActiveSpeakersChangedEvent>((event) {
      for (final speaker in event.speakers) {
        final participant = _participants[speaker.identity];
        if (participant != null) {
          _participants[speaker.identity] = participant.copyWith(isSpeaking: true);
          onActiveSpeakerChanged?.call(_participants[speaker.identity]!);
        }
      }
      _notifyParticipantsChanged();
    });

    // 连接状态变化
    _roomListener!.on<RoomDisconnectedEvent>((event) {
      debugPrint('LiveKitService: Room disconnected: ${event.reason}');
      _setState(MeetingState.disconnected);
    });

    _roomListener!.on<RoomReconnectingEvent>((event) {
      debugPrint('LiveKitService: Room reconnecting');
      _setState(MeetingState.reconnecting);
    });

    _roomListener!.on<RoomReconnectedEvent>((event) {
      debugPrint('LiveKitService: Room reconnected');
      _setState(MeetingState.connected);
    });

    // 录制状态变化
    _roomListener!.on<RoomRecordingStatusChanged>((event) {
      onRecordingStateChanged?.call(event.activeRecording);
    });
  }

  /// 添加远程参与者
  void _addRemoteParticipant(RemoteParticipant participant) {
    final meetingParticipant = MeetingParticipant(
      id: participant.identity,
      name: participant.name.isNotEmpty ? participant.name : participant.identity,
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

    _notifyParticipantsChanged();
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
    notifyListeners();
  }

  /// 设置状态
  void _setState(MeetingState newState) {
    if (_state == newState) return;
    _state = newState;
    onStateChanged?.call(_state);
    notifyListeners();
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

    // 异步释放资源
    await _roomListener?.dispose();
    _roomListener = null;

    await _room?.dispose();
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
  @override
  void dispose() {
    // 注意: dispose 必须是同步的（ChangeNotifier 要求）
    // 如果需要异步清理，应在调用 dispose 前手动调用 leaveMeeting
    _durationTimer?.cancel();
    _roomListener?.dispose();
    _room?.dispose();
    super.dispose();
  }
}
