/// 来电推送服务
/// 
/// 处理来电通知，包括 iOS CallKit 和 Android 前台通知
library;

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:uuid/uuid.dart';

/// 来电动作类型
enum CallAction {
  accept,
  decline,
  timeout,
  callback,
}

/// 来电信息
class IncomingCallInfo {
  final String callId;
  final String callerId;
  final String callerName;
  final String? callerAvatarUrl;
  final bool isVideo;
  final String? roomId;
  final Map<String, dynamic>? extra;
  
  IncomingCallInfo({
    required this.callId,
    required this.callerId,
    required this.callerName,
    this.callerAvatarUrl,
    this.isVideo = false,
    this.roomId,
    this.extra,
  });
  
  factory IncomingCallInfo.fromMap(Map<String, dynamic> map) {
    return IncomingCallInfo(
      callId: map['id'] as String? ?? '',
      callerId: map['callerId'] as String? ?? '',
      callerName: map['nameCaller'] as String? ?? 'Unknown',
      callerAvatarUrl: map['avatar'] as String?,
      isVideo: map['type'] == 1,
      roomId: map['extra']?['roomId'] as String?,
      extra: map['extra'] as Map<String, dynamic>?,
    );
  }
}

/// 来电通知服务
class CallNotificationService {
  static final CallNotificationService _instance = CallNotificationService._internal();
  factory CallNotificationService() => _instance;
  CallNotificationService._internal();
  
  final _uuid = const Uuid();
  
  // 事件流
  final _callActionController = StreamController<(CallAction, IncomingCallInfo)>.broadcast();
  Stream<(CallAction, IncomingCallInfo)> get callActions => _callActionController.stream;
  
  // 当前通话 ID
  String? _currentCallId;
  
  /// 初始化
  Future<void> initialize() async {
    // 监听 CallKit 事件
    FlutterCallkitIncoming.onEvent.listen((event) {
      _handleCallKitEvent(event);
    });
    
    debugPrint('CallNotificationService: Initialized');
  }
  
  /// 处理 CallKit 事件
  void _handleCallKitEvent(dynamic event) {
    if (event == null) return;
    
    final eventName = event.event as String?;
    debugPrint('CallNotificationService: Event - $eventName');
    
    final body = event.body;
    if (body == null) return;
    
    final callInfo = IncomingCallInfo.fromMap(body as Map<String, dynamic>);
    
    if (eventName == 'com.hiennv.flutter_callkit_incoming.action_call_incoming') {
      debugPrint('CallNotificationService: Incoming call from ${callInfo.callerName}');
    } else if (eventName == 'com.hiennv.flutter_callkit_incoming.action_call_accept') {
      debugPrint('CallNotificationService: Call accepted');
      _callActionController.add((CallAction.accept, callInfo));
    } else if (eventName == 'com.hiennv.flutter_callkit_incoming.action_call_decline') {
      debugPrint('CallNotificationService: Call declined');
      _callActionController.add((CallAction.decline, callInfo));
      _currentCallId = null;
    } else if (eventName == 'com.hiennv.flutter_callkit_incoming.action_call_timeout') {
      debugPrint('CallNotificationService: Call timeout');
      _callActionController.add((CallAction.timeout, callInfo));
      _currentCallId = null;
    } else if (eventName == 'com.hiennv.flutter_callkit_incoming.action_call_callback') {
      debugPrint('CallNotificationService: Callback');
      _callActionController.add((CallAction.callback, callInfo));
    } else if (eventName == 'com.hiennv.flutter_callkit_incoming.action_call_ended') {
      debugPrint('CallNotificationService: Call ended');
      _currentCallId = null;
    } else if (eventName == 'com.hiennv.flutter_callkit_incoming.action_call_start') {
      debugPrint('CallNotificationService: Call started');
    }
  }
  
  /// 显示来电通知
  Future<String> showIncomingCall({
    required String callerId,
    required String callerName,
    String? callerAvatarUrl,
    bool isVideo = false,
    String? roomId,
    int durationSeconds = 60,
    Map<String, dynamic>? extra,
  }) async {
    final callId = _uuid.v4();
    _currentCallId = callId;
    
    final params = CallKitParams(
      id: callId,
      nameCaller: callerName,
      appName: 'N42 Chat',
      avatar: callerAvatarUrl,
      handle: callerId,
      type: isVideo ? 1 : 0, // 1 = video, 0 = audio
      textAccept: '接听',
      textDecline: '拒绝',
      missedCallNotification: NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: '未接来电',
        callbackText: '回拨',
      ),
      duration: durationSeconds * 1000,
      extra: <String, dynamic>{
        'callerId': callerId,
        'roomId': roomId,
        ...?extra,
      },
      headers: <String, dynamic>{
        'apiKey': 'YOUR_API_KEY',
        'platform': Platform.isIOS ? 'ios' : 'android',
      },
      android: AndroidParams(
        isCustomNotification: true,
        isShowLogo: true,
        ringtonePath: 'ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: callerAvatarUrl,
        actionColor: '#4CAF50',
        textColor: '#ffffff',
        incomingCallNotificationChannelName: '来电',
        missedCallNotificationChannelName: '未接来电',
        isShowCallID: false,
      ),
      ios: IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: false,
        supportsHolding: false,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'ringtone_default',
      ),
    );
    
    await FlutterCallkitIncoming.showCallkitIncoming(params);
    
    debugPrint('CallNotificationService: Showing incoming call $callId from $callerName');
    
    return callId;
  }
  
  /// 显示正在通话（对于去电）
  Future<String> showOutgoingCall({
    required String calleeId,
    required String calleeName,
    String? calleeAvatarUrl,
    bool isVideo = false,
    String? roomId,
  }) async {
    final callId = _uuid.v4();
    _currentCallId = callId;
    
    final params = CallKitParams(
      id: callId,
      nameCaller: calleeName,
      appName: 'N42 Chat',
      avatar: calleeAvatarUrl,
      handle: calleeId,
      type: isVideo ? 1 : 0,
      extra: <String, dynamic>{
        'calleeId': calleeId,
        'roomId': roomId,
      },
      android: AndroidParams(
        isCustomNotification: true,
        isShowLogo: true,
        backgroundColor: '#0955fa',
        actionColor: '#4CAF50',
        textColor: '#ffffff',
      ),
      ios: IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
      ),
    );
    
    await FlutterCallkitIncoming.startCall(params);
    
    debugPrint('CallNotificationService: Starting outgoing call $callId to $calleeName');
    
    return callId;
  }
  
  /// 更新通话状态为已连接
  Future<void> setCallConnected(String callId) async {
    await FlutterCallkitIncoming.setCallConnected(callId);
    debugPrint('CallNotificationService: Call $callId connected');
  }
  
  /// 结束通话
  Future<void> endCall(String callId) async {
    await FlutterCallkitIncoming.endCall(callId);
    _currentCallId = null;
    debugPrint('CallNotificationService: Call $callId ended');
  }
  
  /// 结束所有通话
  Future<void> endAllCalls() async {
    await FlutterCallkitIncoming.endAllCalls();
    _currentCallId = null;
    debugPrint('CallNotificationService: All calls ended');
  }
  
  /// 获取当前活动通话
  Future<List<dynamic>> getActiveCalls() async {
    return await FlutterCallkitIncoming.activeCalls() ?? [];
  }
  
  /// 检查是否有来电权限（主要用于 iOS）
  Future<bool> checkPermissions() async {
    // flutter_callkit_incoming 会自动处理权限
    return true;
  }
  
  /// 显示未接来电通知
  Future<void> showMissedCall({
    required String callerId,
    required String callerName,
    String? callerAvatarUrl,
    bool isVideo = false,
  }) async {
    final params = CallKitParams(
      id: _uuid.v4(),
      nameCaller: callerName,
      avatar: callerAvatarUrl,
      handle: callerId,
      type: isVideo ? 1 : 0,
      missedCallNotification: NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: isVideo ? '未接视频通话' : '未接语音通话',
        callbackText: '回拨',
      ),
    );
    
    await FlutterCallkitIncoming.showMissCallNotification(params);
    debugPrint('CallNotificationService: Showing missed call from $callerName');
  }
  
  /// 清除未接来电通知
  Future<void> clearMissedCalls() async {
    // 实现清除未接来电通知的逻辑
    debugPrint('CallNotificationService: Cleared missed calls');
  }
  
  /// 释放资源
  void dispose() {
    _callActionController.close();
  }
}

