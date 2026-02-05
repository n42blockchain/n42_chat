/// WebRTC 服务
/// 
/// 封装 flutter_webrtc，提供 1对1 音视频通话功能
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:matrix/matrix.dart' as matrix;

import 'voip_config.dart';

/// 内部通话事件数据（用于统一处理不同来源的事件）
class _CallEventData {
  final String type;
  final String senderId;
  final String roomId;
  final Map<String, dynamic> content;

  _CallEventData({
    required this.type,
    required this.senderId,
    required this.roomId,
    required this.content,
  });
}

/// 通话类型
enum CallType {
  voice,
  video,
}

/// 通话状态
enum CallState {
  idle,
  ringing,     // 响铃中（等待对方接听）
  incoming,    // 来电中
  connecting,  // 连接中
  connected,   // 已连接
  reconnecting, // 重连中
  ended,       // 已结束
  failed,      // 失败
}

/// 通话方向
enum CallDirection {
  outgoing,  // 呼出
  incoming,  // 呼入
}

/// 通话信息
class CallSession {
  final String callId;
  final String roomId;
  final String peerId;
  final String peerName;
  final String? peerAvatarUrl;
  final CallType type;
  final CallDirection direction;
  final DateTime startTime;
  DateTime? connectedTime;
  DateTime? endTime;
  
  CallSession({
    required this.callId,
    required this.roomId,
    required this.peerId,
    required this.peerName,
    this.peerAvatarUrl,
    required this.type,
    required this.direction,
    required this.startTime,
  });
  
  /// 通话时长
  Duration get duration {
    if (connectedTime == null) return Duration.zero;
    final end = endTime ?? DateTime.now();
    return end.difference(connectedTime!);
  }
  
  CallSession copyWith({
    DateTime? connectedTime,
    DateTime? endTime,
  }) {
    return CallSession(
      callId: callId,
      roomId: roomId,
      peerId: peerId,
      peerName: peerName,
      peerAvatarUrl: peerAvatarUrl,
      type: type,
      direction: direction,
      startTime: startTime,
    )
      ..connectedTime = connectedTime ?? this.connectedTime
      ..endTime = endTime ?? this.endTime;
  }
}

/// WebRTC 服务
class WebRTCService {
  final matrix.Client _client;
  final VoIPConfig _config;
  
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;
  
  CallState _state = CallState.idle;
  CallSession? _currentSession;
  
  // 渲染器
  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer remoteRenderer = RTCVideoRenderer();
  
  // 控制状态
  bool _isMuted = false;
  bool _isVideoEnabled = true;
  bool _isSpeakerOn = false;
  bool _isFrontCamera = true;
  
  // 事件回调
  Function(CallState state)? onStateChanged;
  Function(CallSession session)? onIncomingCall;
  Function(MediaStream stream)? onLocalStream;
  Function(MediaStream stream)? onRemoteStream;
  Function(String error)? onError;
  Function(Duration duration)? onDurationUpdate;
  
  // 通话计时器
  Timer? _durationTimer;
  
  // ICE 候选缓存
  final List<RTCIceCandidate> _pendingCandidates = [];
  
  WebRTCService(this._client) : _config = VoIPConfig();
  
  // ============================================
  // Getters
  // ============================================
  
  CallState get state => _state;
  CallSession? get currentSession => _currentSession;
  bool get isMuted => _isMuted;
  bool get isVideoEnabled => _isVideoEnabled;
  bool get isSpeakerOn => _isSpeakerOn;
  bool get isFrontCamera => _isFrontCamera;
  bool get isInCall => _state != CallState.idle && _state != CallState.ended && _state != CallState.failed;
  
  // ============================================
  // 初始化
  // ============================================
  
  /// 初始化渲染器
  Future<void> initialize() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();
    debugPrint('WebRTCService: Renderers initialized');
    
    // 监听 Matrix VoIP 事件
    _setupMatrixEventListeners();
  }
  
  /// 释放资源
  Future<void> dispose() async {
    await hangup();
    await localRenderer.dispose();
    await remoteRenderer.dispose();
    _durationTimer?.cancel();
    debugPrint('WebRTCService: Disposed');
  }
  
  /// 设置 Matrix 事件监听
  ///
  /// 使用 Matrix SDK 的 onCallEvents 流处理通话事件
  void _setupMatrixEventListeners() {
    debugPrint('WebRTCService: Setting up Matrix event listeners');

    // 监听所有通话事件
    _client.onCallEvents.stream.listen((events) {
      debugPrint('WebRTCService: Received ${events.length} call events');
      for (final event in events) {
        final type = event.type;
        final senderId = event.senderId;

        debugPrint('WebRTCService: Received $type from $senderId, content=${event.content}');

        switch (type) {
          case matrix.EventTypes.CallInvite:
            _handleCallInvite(event);
            break;
          case matrix.EventTypes.CallAnswer:
            _handleCallAnswer(event);
            break;
          case matrix.EventTypes.CallCandidates:
            _handleCallCandidates(event);
            break;
          case matrix.EventTypes.CallHangup:
            _handleCallHangup(event);
            break;
          case matrix.EventTypes.CallReject:
            _handleCallReject(event);
            break;
        }
      }
    });

    // 同时监听房间事件（用于接收房间内的通话事件）
    _client.onEvent.stream.listen((eventUpdate) {
      // 只处理 timeline 和 decryptedTimelineQueue 类型的事件
      if (eventUpdate.type != matrix.EventUpdateType.timeline &&
          eventUpdate.type != matrix.EventUpdateType.decryptedTimelineQueue) {
        return;
      }

      // 从 content 中获取事件类型
      final eventType = eventUpdate.content['type'] as String?;

      // 只处理通话相关事件
      if (eventType == null || !eventType.startsWith('m.call.')) return;

      // 从 EventUpdate 构造简化的事件数据
      _handleRoomCallEvent(eventUpdate, eventType);
    });
  }

  /// 处理房间内的通话事件
  void _handleRoomCallEvent(matrix.EventUpdate eventUpdate, String eventType) {
    final content = eventUpdate.content;
    final roomId = eventUpdate.roomID;

    // 获取发送者 ID（在 room timeline 事件中）
    final senderId = content['sender'] as String? ?? '';

    debugPrint('WebRTCService: Room call event $eventType from $senderId in $roomId');

    // 创建一个简化的事件对象用于处理
    final eventData = _CallEventData(
      type: eventType,
      senderId: senderId,
      roomId: roomId,
      content: content['content'] as Map<String, dynamic>? ?? content,
    );

    switch (eventType) {
      case 'm.call.invite':
        _handleCallInviteFromRoom(eventData);
        break;
      case 'm.call.answer':
        _handleCallAnswerFromRoom(eventData);
        break;
      case 'm.call.candidates':
        _handleCallCandidatesFromRoom(eventData);
        break;
      case 'm.call.hangup':
        _handleCallHangupFromRoom(eventData);
        break;
      case 'm.call.reject':
        _handleCallRejectFromRoom(eventData);
        break;
    }
  }
  
  // ============================================
  // 发起通话
  // ============================================
  
  /// 发起通话
  Future<bool> startCall({
    required String roomId,
    required CallType type,
    required String peerId,
    required String peerName,
    String? peerAvatarUrl,
  }) async {
    // 允许在 idle、ended、failed 状态时发起新通话
    if (_state != CallState.idle && _state != CallState.ended && _state != CallState.failed) {
      debugPrint('WebRTCService: Already in a call, state: $_state');
      return false;
    }

    // 如果是从 ended/failed 状态发起，先清理旧资源再重置
    if (_state == CallState.ended || _state == CallState.failed) {
      debugPrint('WebRTCService: Cleaning up from $_state state before new call');
      await _cleanup();
    }
    
    try {
      _setState(CallState.ringing);
      
      // 获取 TURN 配置
      await _loadTurnServers();
      
      // 生成通话 ID
      final callId = 'call_${DateTime.now().millisecondsSinceEpoch}';
      
      // 创建会话
      _currentSession = CallSession(
        callId: callId,
        roomId: roomId,
        peerId: peerId,
        peerName: peerName,
        peerAvatarUrl: peerAvatarUrl,
        type: type,
        direction: CallDirection.outgoing,
        startTime: DateTime.now(),
      );
      
      // 获取本地媒体流
      await _getUserMedia(type);
      
      // 创建 PeerConnection
      await _createPeerConnection();
      
      // 添加本地轨道
      _addLocalTracks();
      
      // 创建 Offer
      final offer = await _peerConnection!.createOffer({
        'offerToReceiveAudio': true,
        'offerToReceiveVideo': type == CallType.video,
      });
      await _peerConnection!.setLocalDescription(offer);
      
      // 发送 m.call.invite
      final room = _client.getRoomById(roomId);
      if (room == null) {
        throw Exception('Room not found');
      }
      
      await room.sendEvent({
        'call_id': callId,
        'party_id': _client.deviceID,
        'version': '1',
        'lifetime': _config.callTimeout * 1000,
        'offer': {
          'type': 'offer',
          'sdp': offer.sdp,
        },
      }, type: 'm.call.invite');
      
      debugPrint('WebRTCService: Call invite sent');
      
      // 启动超时计时器
      _startCallTimeout();
      
      return true;
    } catch (e, stackTrace) {
      debugPrint('WebRTCService: Start call failed: $e');
      debugPrint('Stack: $stackTrace');
      _setState(CallState.failed);
      onError?.call('call_failed');
      await _cleanup();
      return false;
    }
  }
  
  // ============================================
  // 接听/拒绝来电
  // ============================================
  
  /// 接听来电
  Future<bool> answerCall() async {
    debugPrint('WebRTCService: answerCall - state=$_state, session=$_currentSession, peerConnection=$_peerConnection');

    if (_state != CallState.incoming || _currentSession == null) {
      debugPrint('WebRTCService: No incoming call to answer - state=$_state, session=${_currentSession != null}');
      return false;
    }

    if (_peerConnection == null) {
      debugPrint('WebRTCService: ERROR - PeerConnection is null!');
      onError?.call('answer_failed');
      return false;
    }

    try {
      _setState(CallState.connecting);

      // 获取本地媒体流
      debugPrint('WebRTCService: Getting user media for ${_currentSession!.type}');
      await _getUserMedia(_currentSession!.type);

      // 添加本地轨道
      debugPrint('WebRTCService: Adding local tracks');
      _addLocalTracks();

      // 创建 Answer
      debugPrint('WebRTCService: Creating answer');
      final answer = await _peerConnection!.createAnswer();
      debugPrint('WebRTCService: Setting local description');
      await _peerConnection!.setLocalDescription(answer);

      // 发送 m.call.answer
      final room = _client.getRoomById(_currentSession!.roomId);
      if (room == null) {
        throw Exception('Room not found: ${_currentSession!.roomId}');
      }

      debugPrint('WebRTCService: Sending m.call.answer');
      await room.sendEvent({
        'call_id': _currentSession!.callId,
        'party_id': _client.deviceID,
        'version': '1',
        'answer': {
          'type': 'answer',
          'sdp': answer.sdp,
        },
      }, type: 'm.call.answer');

      // 处理缓存的 ICE 候选
      debugPrint('WebRTCService: Processing pending candidates');
      await _processPendingCandidates();

      debugPrint('WebRTCService: Call answered successfully');
      return true;
    } catch (e, stackTrace) {
      debugPrint('WebRTCService: Answer call failed: $e');
      debugPrint('WebRTCService: Stack trace: $stackTrace');
      _setState(CallState.failed);
      onError?.call('answer_failed');
      await _cleanup();
      return false;
    }
  }
  
  /// 拒绝来电
  Future<void> rejectCall() async {
    if (_currentSession == null) return;

    try {
      final room = _client.getRoomById(_currentSession!.roomId);
      if (room != null) {
        await room.sendEvent({
          'call_id': _currentSession!.callId,
          'party_id': _client.deviceID,
          'version': '1',
          'reason': 'user_busy',
        }, type: 'm.call.reject');
      }
    } catch (e) {
      debugPrint('WebRTCService: Reject call failed: $e');
    }

    // 先通知 UI 通话结束
    onStateChanged?.call(CallState.ended);
    // 然后清理资源（会将状态重置为 idle）
    await _cleanup();
  }
  
  // ============================================
  // 挂断通话
  // ============================================
  
  /// 挂断通话
  Future<void> hangup({String reason = 'user_hangup'}) async {
    if (_currentSession == null) return;

    // 计算通话时长（秒）
    final durationSeconds = _currentSession!.duration.inSeconds;
    final isVideo = _currentSession!.type == CallType.video;
    final roomId = _currentSession!.roomId;

    try {
      final room = _client.getRoomById(roomId);
      if (room != null) {
        // 发送 m.call.hangup 控制事件
        await room.sendEvent({
          'call_id': _currentSession!.callId,
          'party_id': _client.deviceID,
          'version': '1',
          'reason': reason,
          'duration': durationSeconds,
          'call_type': isVideo ? 'video' : 'voice',
        }, type: 'm.call.hangup');

        // 发送通话记录消息（作为普通消息显示在聊天中）
        final isMissed = reason == 'invite_timeout' || reason == 'no_answer';
        await _sendCallRecordMessage(
          room: room,
          isVideo: isVideo,
          durationSeconds: durationSeconds,
          isMissed: isMissed,
        );
      }
    } catch (e) {
      debugPrint('WebRTCService: Hangup failed: $e');
    }

    // 先通知 UI 通话结束
    onStateChanged?.call(CallState.ended);
    // 然后清理资源（会将状态重置为 idle）
    await _cleanup();
  }

  /// 发送通话记录消息
  Future<void> _sendCallRecordMessage({
    required matrix.Room room,
    required bool isVideo,
    required int durationSeconds,
    required bool isMissed,
  }) async {
    try {
      // 构建人类可读的消息文本
      String body;
      if (isMissed) {
        body = isVideo ? '未接视频通话' : '未接语音通话';
      } else if (durationSeconds > 0) {
        final minutes = durationSeconds ~/ 60;
        final seconds = durationSeconds % 60;
        final durationStr = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        body = '通话时长 $durationStr';
      } else {
        body = isVideo ? '视频通话已取消' : '语音通话已取消';
      }

      await room.sendEvent({
        'msgtype': 'n42.call.record',
        'body': body,
        'call_type': isVideo ? 'video' : 'voice',
        'duration': durationSeconds,
        'missed': isMissed,
      }, type: matrix.EventTypes.Message);

      debugPrint('WebRTCService: Sent call record message: $body');
    } catch (e) {
      debugPrint('WebRTCService: Failed to send call record message: $e');
    }
  }
  
  // ============================================
  // 通话控制
  // ============================================
  
  /// 静音/取消静音
  void toggleMute() {
    if (_localStream == null) return;
    
    _isMuted = !_isMuted;
    _localStream!.getAudioTracks().forEach((track) {
      track.enabled = !_isMuted;
    });
    debugPrint('WebRTCService: Mute ${_isMuted ? "enabled" : "disabled"}');
  }
  
  /// 开启/关闭视频
  void toggleVideo() {
    if (_localStream == null) return;
    
    _isVideoEnabled = !_isVideoEnabled;
    _localStream!.getVideoTracks().forEach((track) {
      track.enabled = _isVideoEnabled;
    });
    debugPrint('WebRTCService: Video ${_isVideoEnabled ? "enabled" : "disabled"}');
  }
  
  /// 切换扬声器
  Future<void> toggleSpeaker() async {
    _isSpeakerOn = !_isSpeakerOn;
    await Helper.setSpeakerphoneOn(_isSpeakerOn);
    debugPrint('WebRTCService: Speaker ${_isSpeakerOn ? "on" : "off"}');
  }
  
  /// 切换前后摄像头
  Future<void> switchCamera() async {
    if (_localStream == null) return;
    
    final videoTrack = _localStream!.getVideoTracks().firstOrNull;
    if (videoTrack != null) {
      await Helper.switchCamera(videoTrack);
      _isFrontCamera = !_isFrontCamera;
      debugPrint('WebRTCService: Camera switched to ${_isFrontCamera ? "front" : "back"}');
    }
  }
  
  // ============================================
  // 私有方法
  // ============================================
  
  /// 获取 TURN 服务器配置
  Future<void> _loadTurnServers() async {
    try {
      final response = await _client.request(
        matrix.RequestType.GET,
        '/client/v3/voip/turnServer',
      );
      _config.updateFromTurnResponse(response);
    } catch (e) {
      debugPrint('WebRTCService: Failed to load TURN servers: $e');
      // 使用公共 STUN 作为降级方案
    }
  }
  
  /// 获取本地媒体流
  Future<void> _getUserMedia(CallType type) async {
    final constraints = {
      'audio': true,
      'video': type == CallType.video ? {
        'facingMode': 'user',
        ..._config.maxVideoResolution.toConstraints(),
        'frameRate': {'ideal': _config.maxFrameRate},
      } : false,
    };
    
    _localStream = await navigator.mediaDevices.getUserMedia(constraints);
    localRenderer.srcObject = _localStream;
    onLocalStream?.call(_localStream!);
    
    debugPrint('WebRTCService: Got local stream with ${_localStream!.getTracks().length} tracks');
  }
  
  /// 创建 PeerConnection
  Future<void> _createPeerConnection() async {
    final configuration = {
      'iceServers': _config.getIceServers(),
      'sdpSemantics': 'unified-plan',
    };
    
    _peerConnection = await createPeerConnection(configuration);
    
    // 监听 ICE 连接状态
    _peerConnection!.onIceConnectionState = (state) {
      debugPrint('WebRTCService: ICE connection state: $state');
      
      switch (state) {
        case RTCIceConnectionState.RTCIceConnectionStateConnected:
        case RTCIceConnectionState.RTCIceConnectionStateCompleted:
          if (_state == CallState.connecting || _state == CallState.ringing) {
            _setState(CallState.connected);
            _currentSession?.connectedTime = DateTime.now();
            _startDurationTimer();
          }
          break;
        case RTCIceConnectionState.RTCIceConnectionStateFailed:
          _setState(CallState.failed);
          onError?.call('connection_failed');
          break;
        case RTCIceConnectionState.RTCIceConnectionStateDisconnected:
          _setState(CallState.reconnecting);
          break;
        default:
          break;
      }
    };
    
    // 监听 ICE 候选
    _peerConnection!.onIceCandidate = (candidate) {
      _sendIceCandidate(candidate);
    };
    
    // 监听远程流
    _peerConnection!.onTrack = (event) {
      debugPrint('WebRTCService: Got remote track: ${event.track.kind}');
      if (event.streams.isNotEmpty) {
        _remoteStream = event.streams[0];
        remoteRenderer.srcObject = _remoteStream;
        onRemoteStream?.call(_remoteStream!);
      }
    };
    
    debugPrint('WebRTCService: PeerConnection created');
  }
  
  /// 添加本地轨道
  void _addLocalTracks() {
    if (_localStream == null || _peerConnection == null) return;
    
    _localStream!.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });
    
    debugPrint('WebRTCService: Added ${_localStream!.getTracks().length} local tracks');
  }
  
  /// 发送 ICE 候选
  Future<void> _sendIceCandidate(RTCIceCandidate candidate) async {
    if (_currentSession == null) return;
    
    try {
      final room = _client.getRoomById(_currentSession!.roomId);
      if (room != null) {
        await room.sendEvent({
          'call_id': _currentSession!.callId,
          'party_id': _client.deviceID,
          'version': '1',
          'candidates': [
            {
              'candidate': candidate.candidate,
              'sdpMid': candidate.sdpMid,
              'sdpMLineIndex': candidate.sdpMLineIndex,
            }
          ],
        }, type: 'm.call.candidates');
      }
    } catch (e) {
      debugPrint('WebRTCService: Failed to send ICE candidate: $e');
    }
  }
  
  /// 处理缓存的 ICE 候选
  Future<void> _processPendingCandidates() async {
    for (final candidate in _pendingCandidates) {
      await _peerConnection?.addCandidate(candidate);
    }
    _pendingCandidates.clear();
  }
  
  /// 处理来电邀请（来自 to-device 事件）
  Future<void> _handleCallInvite(matrix.BasicEventWithSender event) async {
    // 尝试从多个位置获取 room_id
    final roomId = event.content['room_id'] as String? ??
        event.content['roomId'] as String? ??
        '';
    debugPrint('WebRTCService: _handleCallInvite to-device event, content keys: ${event.content.keys}, room_id=$roomId');

    // 如果 roomId 为空，跳过（房间事件会有正确的 roomId）
    if (roomId.isEmpty) {
      debugPrint('WebRTCService: Skipping to-device call invite without room_id');
      return;
    }

    final eventData = _CallEventData(
      type: event.type,
      senderId: event.senderId,
      roomId: roomId,
      content: event.content,
    );
    await _handleCallInviteFromRoom(eventData);
  }

  /// 处理来电邀请（统一处理）
  Future<void> _handleCallInviteFromRoom(_CallEventData event) async {
    debugPrint('WebRTCService: _handleCallInviteFromRoom called - state=$_state, senderId=${event.senderId}, roomId=${event.roomId}');

    // 允许在 idle、ended、failed 状态时接收来电
    if (_state != CallState.idle && _state != CallState.ended && _state != CallState.failed) {
      debugPrint('WebRTCService: Already in a call (state: $_state), rejecting');
      // 自动拒绝
      return;
    }

    // 如果是从 ended/failed 状态接收来电，先清理旧资源再重置
    if (_state == CallState.ended || _state == CallState.failed) {
      debugPrint('WebRTCService: Cleaning up from $_state state for incoming call');
      await _cleanup();
    }

    final senderId = event.senderId;
    final roomId = event.roomId;
    final content = event.content;

    final callId = content['call_id'] as String?;
    final offer = content['offer'] as Map<String, dynamic>?;

    debugPrint('WebRTCService: Call invite - callId: $callId, senderId: $senderId, roomId: $roomId');

    if (callId == null || offer == null || senderId.isEmpty) {
      debugPrint('WebRTCService: Invalid call invite - missing required fields');
      return;
    }

    // 忽略自己发起的通话
    if (senderId == _client.userID) {
      debugPrint('WebRTCService: Ignoring own call invite');
      return;
    }

    try {
      // 获取 TURN 配置
      await _loadTurnServers();

      // 创建 PeerConnection
      await _createPeerConnection();

      // 设置远程 SDP
      final sdp = offer['sdp'] as String?;
      final sdpType = offer['type'] as String?;

      if (sdp == null || sdpType == null) {
        debugPrint('WebRTCService: Invalid SDP in offer');
        return;
      }

      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(sdp, sdpType),
      );

      // 获取对方信息
      final room = _client.getRoomById(roomId);
      final sender = room?.unsafeGetUserFromMemoryOrFallback(senderId);

      // 判断是否是视频通话
      final isVideo = sdp.contains('m=video');

      // 创建会话
      _currentSession = CallSession(
        callId: callId,
        roomId: roomId,
        peerId: senderId,
        peerName: sender?.displayName ?? senderId.split(':').first.replaceFirst('@', ''),
        peerAvatarUrl: sender?.avatarUrl?.toString(),
        type: isVideo ? CallType.video : CallType.voice,
        direction: CallDirection.incoming,
        startTime: DateTime.now(),
      );

      _setState(CallState.incoming);
      debugPrint('WebRTCService: About to call onIncomingCall callback, callback is ${onIncomingCall != null ? "SET" : "NULL"}');
      onIncomingCall?.call(_currentSession!);

      debugPrint('WebRTCService: Incoming ${isVideo ? "video" : "voice"} call from ${_currentSession!.peerName}');
    } catch (e, stackTrace) {
      debugPrint('WebRTCService: Failed to handle call invite: $e');
      debugPrint('Stack: $stackTrace');
    }
  }
  
  /// 处理通话应答（来自 to-device 事件）
  Future<void> _handleCallAnswer(matrix.BasicEventWithSender event) async {
    final eventData = _CallEventData(
      type: event.type,
      senderId: event.senderId,
      roomId: event.content['room_id'] as String? ?? '',
      content: event.content,
    );
    await _handleCallAnswerFromRoom(eventData);
  }

  /// 处理通话应答（统一处理）
  Future<void> _handleCallAnswerFromRoom(_CallEventData event) async {
    final content = event.content;
    final callId = content['call_id'] as String?;
    final answer = content['answer'] as Map<String, dynamic>?;

    debugPrint('WebRTCService: Call answer - callId: $callId, currentCallId: ${_currentSession?.callId}');

    if (callId != _currentSession?.callId || answer == null) {
      debugPrint('WebRTCService: Ignoring call answer - callId mismatch or no answer');
      return;
    }

    // 忽略自己的应答
    if (event.senderId == _client.userID) {
      debugPrint('WebRTCService: Ignoring own call answer');
      return;
    }

    try {
      final sdp = answer['sdp'] as String?;
      final sdpType = answer['type'] as String?;

      if (sdp == null || sdpType == null) {
        debugPrint('WebRTCService: Invalid SDP in answer');
        return;
      }

      await _peerConnection?.setRemoteDescription(
        RTCSessionDescription(sdp, sdpType),
      );

      // 处理缓存的 ICE 候选
      await _processPendingCandidates();

      _setState(CallState.connecting);
      debugPrint('WebRTCService: Call answered successfully');
    } catch (e, stackTrace) {
      debugPrint('WebRTCService: Failed to handle call answer: $e');
      debugPrint('Stack: $stackTrace');
    }
  }
  
  /// 处理 ICE 候选（来自 to-device 事件）
  Future<void> _handleCallCandidates(matrix.BasicEventWithSender event) async {
    final eventData = _CallEventData(
      type: event.type,
      senderId: event.senderId,
      roomId: event.content['room_id'] as String? ?? '',
      content: event.content,
    );
    await _handleCallCandidatesFromRoom(eventData);
  }

  /// 处理 ICE 候选（统一处理）
  Future<void> _handleCallCandidatesFromRoom(_CallEventData event) async {
    final content = event.content;
    final callId = content['call_id'] as String?;
    final candidates = content['candidates'] as List?;

    if (callId != _currentSession?.callId || candidates == null) {
      return;
    }

    // 忽略自己的候选
    if (event.senderId == _client.userID) {
      return;
    }

    debugPrint('WebRTCService: Processing ${candidates.length} ICE candidates');

    for (final candidateData in candidates) {
      if (candidateData is! Map<String, dynamic>) continue;

      final candidate = RTCIceCandidate(
        candidateData['candidate'] as String?,
        candidateData['sdpMid'] as String?,
        candidateData['sdpMLineIndex'] as int?,
      );

      try {
        if (_peerConnection?.getRemoteDescription() != null) {
          await _peerConnection?.addCandidate(candidate);
          debugPrint('WebRTCService: Added ICE candidate');
        } else {
          _pendingCandidates.add(candidate);
          debugPrint('WebRTCService: Cached ICE candidate (no remote description yet)');
        }
      } catch (e) {
        debugPrint('WebRTCService: Failed to add ICE candidate: $e');
      }
    }
  }
  
  /// 处理挂断（来自 to-device 事件）
  void _handleCallHangup(matrix.BasicEventWithSender event) {
    final eventData = _CallEventData(
      type: event.type,
      senderId: event.senderId,
      roomId: event.content['room_id'] as String? ?? '',
      content: event.content,
    );
    _handleCallHangupFromRoom(eventData);
  }

  /// 处理挂断（统一处理）
  Future<void> _handleCallHangupFromRoom(_CallEventData event) async {
    final content = event.content;
    final callId = content['call_id'] as String?;
    final reason = content['reason'] as String?;

    debugPrint('WebRTCService: Call hangup - callId: $callId, reason: $reason, senderId: ${event.senderId}, currentCallId: ${_currentSession?.callId}, state: $_state');

    // 忽略自己的挂断事件
    if (event.senderId == _client.userID) {
      debugPrint('WebRTCService: Ignoring own hangup event');
      return;
    }

    // 如果当前没有通话或者 callId 不匹配，但状态是 incoming，也应该处理
    // 这处理了 answerCall 失败后对方挂断的情况
    if (_currentSession == null) {
      // 没有当前会话，但如果状态不是 idle，也需要清理
      if (_state != CallState.idle) {
        debugPrint('WebRTCService: No current session but state is $_state, cleaning up');
        onStateChanged?.call(CallState.ended);
        await _cleanup();
      }
      return;
    }

    if (callId != _currentSession!.callId) {
      debugPrint('WebRTCService: Ignoring hangup - callId mismatch');
      return;
    }

    debugPrint('WebRTCService: Remote party hung up');

    // 发送通话记录消息
    final durationSeconds = _currentSession!.duration.inSeconds;
    final isVideo = _currentSession!.type == CallType.video;
    // 如果是来电状态（还没接听）且对方取消，视为未接来电
    final isMissed = _state == CallState.incoming;
    final room = _client.getRoomById(_currentSession!.roomId);
    if (room != null) {
      await _sendCallRecordMessage(
        room: room,
        isVideo: isVideo,
        durationSeconds: durationSeconds,
        isMissed: isMissed,
      );
    }

    // 先通知 UI 通话结束
    onStateChanged?.call(CallState.ended);
    // 然后清理资源
    await _cleanup();
  }

  /// 处理拒绝（来自 to-device 事件）
  void _handleCallReject(matrix.BasicEventWithSender event) {
    final eventData = _CallEventData(
      type: event.type,
      senderId: event.senderId,
      roomId: event.content['room_id'] as String? ?? '',
      content: event.content,
    );
    _handleCallRejectFromRoom(eventData);
  }

  /// 处理拒绝（统一处理）
  Future<void> _handleCallRejectFromRoom(_CallEventData event) async {
    final content = event.content;
    final callId = content['call_id'] as String?;
    final reason = content['reason'] as String?;

    debugPrint('WebRTCService: Call reject - callId: $callId, reason: $reason, senderId: ${event.senderId}');

    if (callId != _currentSession?.callId) {
      debugPrint('WebRTCService: Ignoring reject - callId mismatch');
      return;
    }

    // 忽略自己的拒绝事件
    if (event.senderId == _client.userID) {
      debugPrint('WebRTCService: Ignoring own reject event');
      return;
    }

    debugPrint('WebRTCService: Call rejected by remote party');

    // 发送通话记录消息（对方拒绝 = 未接通）
    if (_currentSession != null) {
      final isVideo = _currentSession!.type == CallType.video;
      final room = _client.getRoomById(_currentSession!.roomId);
      if (room != null) {
        await _sendCallRecordMessage(
          room: room,
          isVideo: isVideo,
          durationSeconds: 0,
          isMissed: true,  // 对方拒绝视为未接
        );
      }
    }

    // 先通知 UI 通话结束
    onStateChanged?.call(CallState.ended);
    onError?.call('call_rejected');
    // 然后清理资源
    await _cleanup();
  }
  
  /// 清理资源
  Future<void> _cleanup() async {
    debugPrint('WebRTCService: Starting cleanup...');

    _durationTimer?.cancel();
    _durationTimer = null;

    // 停止所有本地媒体轨道
    try {
      _localStream?.getTracks().forEach((track) {
        track.stop();
      });
      _localStream?.dispose();
    } catch (e) {
      debugPrint('WebRTCService: Error disposing local stream: $e');
    }
    _localStream = null;

    // 释放远程流
    try {
      _remoteStream?.dispose();
    } catch (e) {
      debugPrint('WebRTCService: Error disposing remote stream: $e');
    }
    _remoteStream = null;

    // 清空渲染器
    localRenderer.srcObject = null;
    remoteRenderer.srcObject = null;

    // 关闭 PeerConnection
    try {
      await _peerConnection?.close();
    } catch (e) {
      debugPrint('WebRTCService: Error closing peer connection: $e');
    }
    _peerConnection = null;

    _pendingCandidates.clear();

    _currentSession?.endTime = DateTime.now();
    _currentSession = null;

    _isMuted = false;
    _isVideoEnabled = true;
    _isSpeakerOn = false;
    _isFrontCamera = true;

    // 立即重置状态为 idle
    _state = CallState.idle;

    debugPrint('WebRTCService: Cleanup completed, state reset to idle');
  }
  
  /// 设置状态
  void _setState(CallState newState) {
    if (_state == newState) return;
    debugPrint('WebRTCService: State changing from $_state to $newState');
    _state = newState;
    onStateChanged?.call(_state);
  }
  
  /// 启动通话超时计时器
  void _startCallTimeout() {
    Future.delayed(Duration(seconds: _config.callTimeout), () {
      if (_state == CallState.ringing) {
        debugPrint('WebRTCService: Call timeout');
        hangup(reason: 'invite_timeout');
        onError?.call('no_answer');
      }
    });
  }
  
  /// 启动通话时长计时器
  void _startDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_currentSession != null) {
        onDurationUpdate?.call(_currentSession!.duration);
      }
    });
  }
}

