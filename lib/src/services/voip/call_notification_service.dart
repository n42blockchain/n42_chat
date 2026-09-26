/// 来电推送服务
///
/// 处理来电通知，包括 iOS CallKit 和 Android 前台通知
library;

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart' as callkit;
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:uuid/uuid.dart';
import '../../core/utils/debug_log.dart';
import 'incoming_call_ringtone_preference.dart';

/// 来电动作类型
enum CallAction { accept, decline, timeout, callback, ended }

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
      callerId:
          map['extra']?['callerId'] as String? ??
          map['callerId'] as String? ??
          map['handle'] as String? ??
          '',
      callerName: map['nameCaller'] as String? ?? 'Unknown',
      callerAvatarUrl: map['avatar'] as String?,
      isVideo: map['type'] == 1,
      roomId: map['extra']?['roomId'] as String?,
      extra: map['extra'] is Map
          ? Map<String, dynamic>.from(map['extra'] as Map)
          : null,
    );
  }
}

/// 来电通知服务
class CallNotificationService {
  static final CallNotificationService _instance =
      CallNotificationService._internal();
  factory CallNotificationService() => _instance;

  /// 构造函数中立即开始监听 CallKit 事件，防止 app 从锁屏/冷启动时丢失
  /// action_call_accept 事件（用户在通知中点击接听但 Flutter 引擎尚未就绪的情况）
  CallNotificationService._internal() {
    _callKitSubscription = FlutterCallkitIncoming.onEvent.listen(
      _handleCallKitEvent,
    );
    debugLog('CallNotificationService: Event listener attached in constructor');
  }

  StreamSubscription<callkit.CallEvent?>? _callKitSubscription;
  final Map<String, IncomingCallInfo> _knownCalls = {};

  final _uuid = const Uuid();

  // 事件流
  final _callActionController =
      StreamController<(CallAction, IncomingCallInfo)>.broadcast();
  Stream<(CallAction, IncomingCallInfo)> get callActions =>
      _callActionController.stream;

  // 当前 CallKit 通话 ID
  String? _currentCallId;
  final Set<String> _dismissedCallIds = {};

  /// 获取当前 CallKit 通话 ID
  String? get currentCallId => _currentCallId;

  // 锁屏接听缓存：当用户从通知栏/锁屏点击"接听"时，app 可能尚未初始化，
  // 在此暂存该动作，CallManager.initialize() 完成后取出并自动接听。
  (CallAction, IncomingCallInfo)? _pendingAcceptAction;
  DateTime? _pendingAcceptTime;
  static const Duration _kPendingActionTtl = Duration(seconds: 90);

  /// 取出并清除待处理的接听动作（TTL 内有效）
  (CallAction, IncomingCallInfo)? consumePendingAcceptAction() {
    final action = _pendingAcceptAction;
    final time = _pendingAcceptTime;
    _pendingAcceptAction = null;
    _pendingAcceptTime = null;
    if (action == null || time == null) return null;
    if (DateTime.now().difference(time) > _kPendingActionTtl) {
      debugLog(
        'CallNotificationService: Pending accept action expired (TTL exceeded)',
      );
      return null;
    }
    return action;
  }

  /// 初始化（事件监听已在构造函数中设置，此处仅作日志标记）
  Future<void> initialize() async {
    _callKitSubscription ??= FlutterCallkitIncoming.onEvent.listen(
      _handleCallKitEvent,
    );
    debugLog(
      'CallNotificationService: Initialized (listener was attached in constructor)',
    );
  }

  /// 处理 CallKit 事件
  void _handleCallKitEvent(callkit.CallEvent? event) {
    if (event == null) return;
    debugLog('CallNotificationService: Event - ${event.eventName}');
    final params = switch (event) {
      callkit.CallEventActionCallIncoming(:final callKitParams) =>
        callKitParams,
      callkit.CallEventActionCallStart(:final callKitParams) => callKitParams,
      callkit.CallEventActionCallAccept(:final callKitParams) => callKitParams,
      callkit.CallEventActionCallDecline(:final callKitParams) => callKitParams,
      callkit.CallEventActionCallEnded(:final callKitParams) => callKitParams,
      _ => null,
    };
    if (params != null) {
      final info = IncomingCallInfo.fromMap(params.toJson());
      _knownCalls[info.callId] = info;
      // Keep metadata for id-only timeout/callback events without unbounded growth.
      if (_knownCalls.length > 64) _knownCalls.remove(_knownCalls.keys.first);
    }
    final id =
        params?.id ??
        switch (event) {
          callkit.CallEventActionCallTimeout(:final id) => id,
          callkit.CallEventActionCallCallback(:final id) => id,
          _ => null,
        };
    final info = id == null
        ? null
        : _knownCalls[id] ??
              IncomingCallInfo(callId: id, callerId: '', callerName: 'Unknown');
    switch (event) {
      case callkit.CallEventActionCallIncoming():
        _currentCallId ??= info!.callId;
      case callkit.CallEventActionCallAccept():
        _pendingAcceptAction = (CallAction.accept, info!);
        _pendingAcceptTime = DateTime.now();
        _callActionController.add((CallAction.accept, info));
      case callkit.CallEventActionCallDecline():
        _callActionController.add((CallAction.decline, info!));
        _currentCallId = null;
        _knownCalls.remove(info.callId);
      case callkit.CallEventActionCallTimeout():
        _callActionController.add((CallAction.timeout, info!));
        _currentCallId = null;
        _knownCalls.remove(info.callId);
      case callkit.CallEventActionCallCallback():
        _callActionController.add((CallAction.callback, info!));
      case callkit.CallEventActionCallEnded():
        if (_dismissedCallIds.contains(info!.callId)) return;
        if (_currentCallId != null && _currentCallId != info.callId) return;
        _pendingAcceptAction = null;
        _pendingAcceptTime = null;
        _currentCallId = null;
        _callActionController.add((CallAction.ended, info));
        _knownCalls.remove(info.callId);
      default:
        break;
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
    // 本地化字符串参数
    String textAccept = 'Answer',
    String textDecline = 'Decline',
    String missedCallText = 'Missed call',
    String callbackText = 'Call back',
    String incomingCallChannelName = 'Incoming call',
    String missedCallChannelName = 'Missed call',
  }) async {
    final callId = _uuid.v4();
    _currentCallId = callId;
    final ringtonePreference = await IncomingCallRingtonePreference.load();

    final params = CallKitParams(
      id: callId,
      nameCaller: callerName,
      appName: 'N42 Chat',
      avatar: callerAvatarUrl,
      handle: callerId,
      type: isVideo ? 1 : 0, // 1 = video, 0 = audio
      missedCallNotification: NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: missedCallText,
        callbackText: callbackText,
      ),
      duration: durationSeconds * 1000,
      extra: <String, dynamic>{
        'callerId': callerId,
        'roomId': roomId,
        ...?extra,
      },
      headers: <String, dynamic>{
        'platform': Platform.isIOS ? 'ios' : 'android',
      },
      android: buildIncomingCallAndroidParams(
        ringtonePreference: ringtonePreference,
        textAccept: textAccept,
        textDecline: textDecline,
        avatarUrl: callerAvatarUrl,
        incomingCallChannelName: incomingCallChannelName,
        missedCallChannelName: missedCallChannelName,
      ),
      ios: buildIncomingCallIOSParams(ringtonePreference: ringtonePreference),
    );

    _knownCalls[callId] = IncomingCallInfo.fromMap(params.toJson());
    if (_knownCalls.length > 64) _knownCalls.remove(_knownCalls.keys.first);
    await FlutterCallkitIncoming.showCallkitIncoming(params);

    debugLog(
      'CallNotificationService: Showing incoming call $callId from $callerName',
    );

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
      extra: <String, dynamic>{'calleeId': calleeId, 'roomId': roomId},
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: true,
        backgroundColor: '#0955fa',
        actionColor: '#4CAF50',
        textColor: '#ffffff',
      ),
      ios: const IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
      ),
    );

    await FlutterCallkitIncoming.startCall(params);

    debugLog(
      'CallNotificationService: Starting outgoing call $callId to $calleeName',
    );

    return callId;
  }

  /// 更新通话状态为已连接
  Future<void> setCallConnected(String callId) async {
    // Android's connected event only updates the ongoing notification; it does
    // not stop the incoming sound/vibrator when answered from the Flutter UI.
    if (defaultTargetPlatform == TargetPlatform.android) {
      await FlutterCallkitIncoming.hideCallkitIncoming(
        CallKitParams(id: callId),
      );
    }
    await FlutterCallkitIncoming.setCallConnected(callId);
    debugLog('CallNotificationService: Call $callId connected');
  }

  /// 结束通话
  Future<void> endCall(String callId) async {
    _rememberDismissed(callId);
    if (_currentCallId == callId) _currentCallId = null;
    await FlutterCallkitIncoming.endCall(callId);
    debugLog('CallNotificationService: Call $callId ended');
  }

  /// 结束所有通话
  Future<void> endAllCalls() async {
    _rememberDismissed(_currentCallId);
    _currentCallId = null;
    await FlutterCallkitIncoming.endAllCalls();
    debugLog('CallNotificationService: All calls ended');
  }

  void _rememberDismissed(String? id) {
    if (id == null) return;
    _dismissedCallIds.add(id);
    _knownCalls.remove(id);
    if (_dismissedCallIds.length > 64)
      _dismissedCallIds.remove(_dismissedCallIds.first);
  }

  /// 获取当前活动通话
  Future<List<dynamic>> getActiveCalls() async {
    final calls = await FlutterCallkitIncoming.activeCalls();
    return (calls as List<dynamic>?) ?? [];
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
    // 本地化字符串参数
    String? missedVideoCallText,
    String? missedVoiceCallText,
    String callbackText = 'Call back',
  }) async {
    final subtitle = isVideo
        ? (missedVideoCallText ?? 'Missed video call')
        : (missedVoiceCallText ?? 'Missed voice call');

    final params = CallKitParams(
      id: _uuid.v4(),
      nameCaller: callerName,
      avatar: callerAvatarUrl,
      handle: callerId,
      type: isVideo ? 1 : 0,
      missedCallNotification: NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: subtitle,
        callbackText: callbackText,
      ),
    );

    await FlutterCallkitIncoming.showMissCallNotification(params);
    debugLog('CallNotificationService: Showing missed call from $callerName');
  }

  /// 清除未接来电通知
  Future<void> clearMissedCalls() async {
    // 实现清除未接来电通知的逻辑
    debugLog('CallNotificationService: Cleared missed calls');
  }

  /// 释放资源
  void dispose() {
    // 单例在同一进程内会被重复复用，不能把事件流永久关闭。
    _callKitSubscription?.cancel();
    _callKitSubscription = null;
    _currentCallId = null;
    _pendingAcceptAction = null;
    _pendingAcceptTime = null;
    _knownCalls.clear();
  }
}
