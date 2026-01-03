/// 通话管理器
/// 
/// 统一管理 1对1 通话和多人会议，提供简化的 API
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart' as matrix;

import 'voip_config.dart';
import 'webrtc_service.dart';
import 'livekit_service.dart';
import 'call_notification_service.dart';
import '../../presentation/pages/call/call_screen.dart';
import '../../presentation/pages/call/group_call_screen.dart';

/// 通话管理器
/// 
/// 提供以下功能：
/// - 1对1 语音/视频通话（WebRTC）
/// - 多人视频会议（LiveKit）
/// - 来电推送通知
/// - 通话记录
class CallManager {
  static final CallManager _instance = CallManager._internal();
  factory CallManager() => _instance;
  CallManager._internal();
  
  // 服务实例
  WebRTCService? _webRTCService;
  LiveKitService? _liveKitService;
  final CallNotificationService _notificationService = CallNotificationService();
  final VoIPConfig _config = VoIPConfig();
  
  // Matrix 客户端
  matrix.Client? _client;
  
  // 导航键
  GlobalKey<NavigatorState>? _navigatorKey;
  
  // 是否已初始化
  bool _isInitialized = false;
  
  // 事件回调
  Function(CallSession)? onIncomingCall;
  Function(CallState)? onCallStateChanged;
  Function(String error)? onError;
  
  // ============================================
  // Getters
  // ============================================
  
  VoIPConfig get config => _config;
  WebRTCService? get webRTCService => _webRTCService;
  LiveKitService? get liveKitService => _liveKitService;
  bool get isInitialized => _isInitialized;
  bool get isInCall => _webRTCService?.isInCall ?? false;
  bool get isInMeeting => _liveKitService?.isInMeeting ?? false;
  
  // ============================================
  // 初始化
  // ============================================
  
  /// 初始化通话管理器
  /// 
  /// [client] Matrix 客户端实例
  /// [navigatorKey] 用于导航到通话页面的 GlobalKey
  Future<void> initialize({
    required matrix.Client client,
    GlobalKey<NavigatorState>? navigatorKey,
  }) async {
    if (_isInitialized) {
      debugPrint('CallManager: Already initialized');
      return;
    }
    
    _client = client;
    _navigatorKey = navigatorKey;
    
    // 初始化通知服务
    await _notificationService.initialize();
    
    // 监听来电通知动作
    _notificationService.callActions.listen((event) {
      final (action, callInfo) = event;
      _handleNotificationAction(action, callInfo);
    });
    
    // 初始化 WebRTC 服务
    _webRTCService = WebRTCService(client);
    await _webRTCService!.initialize();
    
    // 设置 WebRTC 回调
    _webRTCService!.onIncomingCall = _handleIncomingCall;
    _webRTCService!.onStateChanged = _handleCallStateChanged;
    _webRTCService!.onError = (error) => onError?.call(error);
    
    // 初始化 LiveKit 服务
    _liveKitService = LiveKitService();
    
    _isInitialized = true;
    debugPrint('CallManager: Initialized');
  }
  
  /// 配置 TURN 服务器
  void configureTurn({
    required List<String> uris,
    String? username,
    String? password,
    int? ttl,
  }) {
    _config.turnUris = uris;
    _config.turnUsername = username;
    _config.turnPassword = password;
    if (ttl != null) _config.turnTtl = ttl;
    debugPrint('CallManager: TURN configured with ${uris.length} URIs');
  }
  
  /// 配置 LiveKit
  void configureLiveKit({
    required String url,
    String? apiKey,
    String? apiSecret,
  }) {
    _config.configureLiveKit(
      url: url,
      apiKey: apiKey,
      apiSecret: apiSecret,
    );
  }
  
  // ============================================
  // 1对1 通话
  // ============================================
  
  /// 发起语音通话
  Future<bool> startVoiceCall({
    required String roomId,
    required String peerId,
    required String peerName,
    String? peerAvatarUrl,
  }) async {
    return _startCall(
      roomId: roomId,
      peerId: peerId,
      peerName: peerName,
      peerAvatarUrl: peerAvatarUrl,
      type: CallType.voice,
    );
  }
  
  /// 发起视频通话
  Future<bool> startVideoCall({
    required String roomId,
    required String peerId,
    required String peerName,
    String? peerAvatarUrl,
  }) async {
    return _startCall(
      roomId: roomId,
      peerId: peerId,
      peerName: peerName,
      peerAvatarUrl: peerAvatarUrl,
      type: CallType.video,
    );
  }
  
  Future<bool> _startCall({
    required String roomId,
    required String peerId,
    required String peerName,
    String? peerAvatarUrl,
    required CallType type,
  }) async {
    if (_webRTCService == null) {
      onError?.call('通话服务未初始化');
      return false;
    }
    
    if (isInCall || isInMeeting) {
      onError?.call('当前正在通话中');
      return false;
    }
    
    // 显示去电通知
    await _notificationService.showOutgoingCall(
      calleeId: peerId,
      calleeName: peerName,
      calleeAvatarUrl: peerAvatarUrl,
      isVideo: type == CallType.video,
      roomId: roomId,
    );
    
    // 发起通话
    final success = await _webRTCService!.startCall(
      roomId: roomId,
      type: type,
      peerId: peerId,
      peerName: peerName,
      peerAvatarUrl: peerAvatarUrl,
    );
    
    if (success) {
      // 导航到通话页面
      _navigateToCallScreen();
    } else {
      await _notificationService.endAllCalls();
    }
    
    return success;
  }
  
  /// 接听来电
  Future<bool> answerCall() async {
    if (_webRTCService == null) return false;
    
    final success = await _webRTCService!.answerCall();
    if (success) {
      _navigateToCallScreen();
    }
    return success;
  }
  
  /// 拒绝来电
  Future<void> rejectCall() async {
    await _webRTCService?.rejectCall();
    await _notificationService.endAllCalls();
  }
  
  /// 挂断通话
  Future<void> hangupCall() async {
    await _webRTCService?.hangup();
    await _notificationService.endAllCalls();
  }
  
  // ============================================
  // 多人会议
  // ============================================
  
  /// 创建会议
  /// 
  /// [roomName] 会议名称
  /// [participantName] 参与者名称
  /// [token] LiveKit 访问令牌（从服务端获取）
  Future<bool> createMeeting({
    required String roomName,
    required String participantName,
    required String token,
    String? participantAvatarUrl,
    bool enableVideo = true,
    bool enableAudio = true,
  }) async {
    return joinMeeting(
      roomName: roomName,
      participantName: participantName,
      token: token,
      participantAvatarUrl: participantAvatarUrl,
      enableVideo: enableVideo,
      enableAudio: enableAudio,
    );
  }
  
  /// 加入会议
  Future<bool> joinMeeting({
    required String roomName,
    required String participantName,
    required String token,
    String? participantAvatarUrl,
    bool enableVideo = true,
    bool enableAudio = true,
  }) async {
    if (_liveKitService == null) {
      onError?.call('会议服务未初始化');
      return false;
    }
    
    if (!_config.hasLiveKitConfig) {
      onError?.call('LiveKit 未配置');
      return false;
    }
    
    if (isInCall || isInMeeting) {
      onError?.call('当前正在通话中');
      return false;
    }
    
    final success = await _liveKitService!.joinMeeting(
      roomName: roomName,
      token: token,
      participantName: participantName,
      participantAvatarUrl: participantAvatarUrl,
      enableVideo: enableVideo,
      enableAudio: enableAudio,
    );
    
    if (success) {
      _navigateToGroupCallScreen(roomName);
    }
    
    return success;
  }
  
  /// 离开会议
  Future<void> leaveMeeting() async {
    await _liveKitService?.leaveMeeting();
  }
  
  // ============================================
  // 私有方法
  // ============================================
  
  void _handleIncomingCall(CallSession session) async {
    debugPrint('CallManager: Incoming call from ${session.peerName}');
    
    // 显示来电通知
    await _notificationService.showIncomingCall(
      callerId: session.peerId,
      callerName: session.peerName,
      callerAvatarUrl: session.peerAvatarUrl,
      isVideo: session.type == CallType.video,
      roomId: session.roomId,
    );
    
    onIncomingCall?.call(session);
  }
  
  void _handleCallStateChanged(CallState state) {
    debugPrint('CallManager: Call state changed to $state');
    
    if (state == CallState.connected) {
      final callId = _webRTCService?.currentSession?.callId;
      if (callId != null) {
        _notificationService.setCallConnected(callId);
      }
    } else if (state == CallState.ended || state == CallState.failed) {
      _notificationService.endAllCalls();
    }
    
    onCallStateChanged?.call(state);
  }
  
  void _handleNotificationAction(CallAction action, IncomingCallInfo callInfo) {
    switch (action) {
      case CallAction.accept:
        answerCall();
        break;
      case CallAction.decline:
        rejectCall();
        break;
      case CallAction.timeout:
        // 显示未接来电
        _notificationService.showMissedCall(
          callerId: callInfo.callerId,
          callerName: callInfo.callerName,
          callerAvatarUrl: callInfo.callerAvatarUrl,
          isVideo: callInfo.isVideo,
        );
        break;
      case CallAction.callback:
        // 回拨
        if (callInfo.roomId != null) {
          startVoiceCall(
            roomId: callInfo.roomId!,
            peerId: callInfo.callerId,
            peerName: callInfo.callerName,
            peerAvatarUrl: callInfo.callerAvatarUrl,
          );
        }
        break;
    }
  }
  
  void _navigateToCallScreen() {
    final context = _navigatorKey?.currentContext;
    if (context == null || _webRTCService == null) return;
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CallScreen(
          webRTCService: _webRTCService!,
        ),
      ),
    );
  }
  
  void _navigateToGroupCallScreen(String roomName) {
    final context = _navigatorKey?.currentContext;
    if (context == null || _liveKitService == null) return;
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GroupCallScreen(
          liveKitService: _liveKitService!,
          roomName: roomName,
        ),
      ),
    );
  }
  
  // ============================================
  // 资源释放
  // ============================================
  
  /// 释放资源
  Future<void> dispose() async {
    await _webRTCService?.dispose();
    await _liveKitService?.dispose();
    _notificationService.dispose();
    _isInitialized = false;
    debugPrint('CallManager: Disposed');
  }
}

