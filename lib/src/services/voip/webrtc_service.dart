/// WebRTC 服务
/// 
/// 封装 flutter_webrtc，提供 1对1 音视频通话功能
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:matrix/matrix.dart' as matrix;

import 'voip_config.dart';

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
  bool get isInCall => _state != CallState.idle && _state != CallState.ended;
  
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
  void _setupMatrixEventListeners() {
    // 监听房间事件
    _client.onEvent.stream.listen((eventUpdate) {
      final event = eventUpdate.content;
      final type = event['type'] as String?;
      
      switch (type) {
        case 'm.call.invite':
          _handleCallInvite(eventUpdate);
          break;
        case 'm.call.answer':
          _handleCallAnswer(eventUpdate);
          break;
        case 'm.call.candidates':
          _handleCallCandidates(eventUpdate);
          break;
        case 'm.call.hangup':
          _handleCallHangup(eventUpdate);
          break;
        case 'm.call.reject':
          _handleCallReject(eventUpdate);
          break;
      }
    });
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
    if (_state != CallState.idle) {
      debugPrint('WebRTCService: Already in a call');
      return false;
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
      onError?.call('发起通话失败: $e');
      await _cleanup();
      return false;
    }
  }
  
  // ============================================
  // 接听/拒绝来电
  // ============================================
  
  /// 接听来电
  Future<bool> answerCall() async {
    if (_state != CallState.incoming || _currentSession == null) {
      debugPrint('WebRTCService: No incoming call to answer');
      return false;
    }
    
    try {
      _setState(CallState.connecting);
      
      // 获取本地媒体流
      await _getUserMedia(_currentSession!.type);
      
      // 添加本地轨道
      _addLocalTracks();
      
      // 创建 Answer
      final answer = await _peerConnection!.createAnswer();
      await _peerConnection!.setLocalDescription(answer);
      
      // 发送 m.call.answer
      final room = _client.getRoomById(_currentSession!.roomId);
      if (room == null) {
        throw Exception('Room not found');
      }
      
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
      await _processPendingCandidates();
      
      debugPrint('WebRTCService: Call answered');
      return true;
    } catch (e) {
      debugPrint('WebRTCService: Answer call failed: $e');
      _setState(CallState.failed);
      onError?.call('接听失败: $e');
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
    
    await _cleanup();
    _setState(CallState.ended);
  }
  
  // ============================================
  // 挂断通话
  // ============================================
  
  /// 挂断通话
  Future<void> hangup({String reason = 'user_hangup'}) async {
    if (_currentSession == null) return;
    
    try {
      final room = _client.getRoomById(_currentSession!.roomId);
      if (room != null) {
        await room.sendEvent({
          'call_id': _currentSession!.callId,
          'party_id': _client.deviceID,
          'version': '1',
          'reason': reason,
        }, type: 'm.call.hangup');
      }
    } catch (e) {
      debugPrint('WebRTCService: Hangup failed: $e');
    }
    
    await _cleanup();
    _setState(CallState.ended);
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
          onError?.call('连接失败');
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
  
  /// 处理来电邀请
  Future<void> _handleCallInvite(matrix.EventUpdate eventUpdate) async {
    if (_state != CallState.idle) {
      debugPrint('WebRTCService: Already in a call, rejecting');
      // 自动拒绝
      return;
    }
    
    final content = eventUpdate.content;
    final callId = content['call_id'] as String?;
    final offer = content['offer'] as Map<String, dynamic>?;
    final senderId = content['sender'] as String?;
    
    if (callId == null || offer == null || senderId == null) return;
    
    // 忽略自己发起的通话
    if (senderId == _client.userID) return;
    
    try {
      // 获取 TURN 配置
      await _loadTurnServers();
      
      // 创建 PeerConnection
      await _createPeerConnection();
      
      // 设置远程 SDP
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(offer['sdp'] as String, offer['type'] as String),
      );
      
      // 获取对方信息
      final room = _client.getRoomById(eventUpdate.roomID);
      final sender = room?.unsafeGetUserFromMemoryOrFallback(senderId);
      
      // 判断是否是视频通话
      final sdp = offer['sdp'] as String;
      final isVideo = sdp.contains('m=video');
      
      // 创建会话
      _currentSession = CallSession(
        callId: callId,
        roomId: eventUpdate.roomID,
        peerId: senderId,
        peerName: sender?.displayName ?? senderId,
        peerAvatarUrl: sender?.avatarUrl?.toString(),
        type: isVideo ? CallType.video : CallType.voice,
        direction: CallDirection.incoming,
        startTime: DateTime.now(),
      );
      
      _setState(CallState.incoming);
      onIncomingCall?.call(_currentSession!);
      
      debugPrint('WebRTCService: Incoming ${isVideo ? "video" : "voice"} call from ${_currentSession!.peerName}');
    } catch (e) {
      debugPrint('WebRTCService: Failed to handle call invite: $e');
    }
  }
  
  /// 处理通话应答
  Future<void> _handleCallAnswer(matrix.EventUpdate eventUpdate) async {
    final content = eventUpdate.content;
    final callId = content['call_id'] as String?;
    final answer = content['answer'] as Map<String, dynamic>?;
    
    if (callId != _currentSession?.callId || answer == null) return;
    
    try {
      await _peerConnection?.setRemoteDescription(
        RTCSessionDescription(answer['sdp'] as String, answer['type'] as String),
      );
      
      // 处理缓存的 ICE 候选
      await _processPendingCandidates();
      
      _setState(CallState.connecting);
      debugPrint('WebRTCService: Call answered');
    } catch (e) {
      debugPrint('WebRTCService: Failed to handle call answer: $e');
    }
  }
  
  /// 处理 ICE 候选
  Future<void> _handleCallCandidates(matrix.EventUpdate eventUpdate) async {
    final content = eventUpdate.content;
    final callId = content['call_id'] as String?;
    final candidates = content['candidates'] as List?;
    
    if (callId != _currentSession?.callId || candidates == null) return;
    
    for (final candidateData in candidates) {
      final candidate = RTCIceCandidate(
        candidateData['candidate'] as String?,
        candidateData['sdpMid'] as String?,
        candidateData['sdpMLineIndex'] as int?,
      );
      
      if (_peerConnection?.getRemoteDescription() != null) {
        await _peerConnection?.addCandidate(candidate);
      } else {
        _pendingCandidates.add(candidate);
      }
    }
  }
  
  /// 处理挂断
  void _handleCallHangup(matrix.EventUpdate eventUpdate) {
    final content = eventUpdate.content;
    final callId = content['call_id'] as String?;
    
    if (callId != _currentSession?.callId) return;
    
    debugPrint('WebRTCService: Remote party hung up');
    _cleanup();
    _setState(CallState.ended);
  }
  
  /// 处理拒绝
  void _handleCallReject(matrix.EventUpdate eventUpdate) {
    final content = eventUpdate.content;
    final callId = content['call_id'] as String?;
    
    if (callId != _currentSession?.callId) return;
    
    debugPrint('WebRTCService: Call rejected');
    _cleanup();
    _setState(CallState.ended);
    onError?.call('对方已拒绝');
  }
  
  /// 清理资源
  Future<void> _cleanup() async {
    _durationTimer?.cancel();
    _durationTimer = null;
    
    _localStream?.getTracks().forEach((track) => track.stop());
    _localStream?.dispose();
    _localStream = null;
    
    _remoteStream?.dispose();
    _remoteStream = null;
    
    localRenderer.srcObject = null;
    remoteRenderer.srcObject = null;
    
    await _peerConnection?.close();
    _peerConnection = null;
    
    _pendingCandidates.clear();
    
    _currentSession?.endTime = DateTime.now();
    _currentSession = null;
    
    _isMuted = false;
    _isVideoEnabled = true;
    _isSpeakerOn = false;
    _isFrontCamera = true;
    
    debugPrint('WebRTCService: Cleaned up');
  }
  
  /// 设置状态
  void _setState(CallState newState) {
    if (_state == newState) return;
    _state = newState;
    onStateChanged?.call(_state);
    debugPrint('WebRTCService: State changed to $_state');
    
    if (newState == CallState.ended || newState == CallState.failed) {
      // 延迟重置为 idle
      Future.delayed(const Duration(seconds: 2), () {
        if (_state == CallState.ended || _state == CallState.failed) {
          _state = CallState.idle;
        }
      });
    }
  }
  
  /// 启动通话超时计时器
  void _startCallTimeout() {
    Future.delayed(Duration(seconds: _config.callTimeout), () {
      if (_state == CallState.ringing) {
        debugPrint('WebRTCService: Call timeout');
        hangup(reason: 'invite_timeout');
        onError?.call('对方无应答');
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

