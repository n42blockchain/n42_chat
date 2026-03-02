import 'dart:async';


import '../../domain/entities/voice_room_entity.dart';
import '../../domain/repositories/voice_room_repository.dart';
import '../../core/utils/debug_log.dart';

/// 语音房间服务
///
/// 在 LiveKitService 之上封装语音房间特殊逻辑。
/// 管理音频流、角色切换和静音状态。
class VoiceRoomService {
  final IVoiceRoomRepository _repository;

  bool _isConnected = false;
  bool _isMuted = true;
  VoiceRoomRole _myRole = VoiceRoomRole.listener;
  String? _currentRoomId;

  final _stateController = StreamController<VoiceRoomServiceState>.broadcast();

  VoiceRoomService({
    required IVoiceRoomRepository repository,
  }) : _repository = repository;

  /// 当前是否已连接
  bool get isConnected => _isConnected;

  /// 当前是否静音
  bool get isMuted => _isMuted;

  /// 当前角色
  VoiceRoomRole get myRole => _myRole;

  /// 状态流
  Stream<VoiceRoomServiceState> get stateStream => _stateController.stream;

  /// 加入语音房间
  ///
  /// 听众模式：不启用音频发送
  /// 发言者模式：启用音频发送，不启用视频
  Future<bool> joinRoom(String roomId, {VoiceRoomRole role = VoiceRoomRole.listener}) async {
    try {
      _currentRoomId = roomId;
      _myRole = role;

      final joined = await _repository.joinVoiceRoom(roomId);
      if (!joined) return false;

      // 根据角色决定是否启用音频
      _isMuted = role == VoiceRoomRole.listener;
      _isConnected = true;

      _emitState();
      debugLog('VoiceRoomService: Joined room $roomId as ${role.name}');
      return true;
    } catch (e) {
      debugLog('VoiceRoomService: Failed to join room: $e');
      return false;
    }
  }

  /// 离开语音房间
  Future<void> leaveRoom() async {
    if (_currentRoomId == null) return;

    try {
      await _repository.leaveVoiceRoom(_currentRoomId!);
    } catch (e) {
      debugLog('VoiceRoomService: Failed to leave room: $e');
    } finally {
      _isConnected = false;
      _isMuted = true;
      _myRole = VoiceRoomRole.listener;
      _currentRoomId = null;
      _emitState();
    }
  }

  /// 举手请求发言
  Future<bool> raiseHand() async {
    if (_currentRoomId == null) return false;
    return _repository.raiseHand(_currentRoomId!);
  }

  /// 放下手
  Future<bool> lowerHand() async {
    if (_currentRoomId == null) return false;
    return _repository.lowerHand(_currentRoomId!);
  }

  /// 批准发言（主持人操作）
  Future<bool> approveSpeaker(String userId) async {
    if (_currentRoomId == null) return false;
    return _repository.approveSpeaker(_currentRoomId!, userId);
  }

  /// 降为听众（主持人操作）
  Future<bool> demoteToListener(String userId) async {
    if (_currentRoomId == null) return false;
    return _repository.demoteToListener(_currentRoomId!, userId);
  }

  /// 切换静音
  Future<void> toggleMute() async {
    if (_currentRoomId == null || _myRole == VoiceRoomRole.listener) return;

    _isMuted = !_isMuted;
    await _repository.toggleMute(_currentRoomId!, _isMuted);
    _emitState();
  }

  /// 更新角色（当 power_level 变化时调用）
  void updateRole(VoiceRoomRole newRole) {
    final oldRole = _myRole;
    _myRole = newRole;

    // 角色变化时自动调整音频
    if (newRole == VoiceRoomRole.listener && oldRole != VoiceRoomRole.listener) {
      // 降为听众 → 静音
      _isMuted = true;
    } else if (newRole != VoiceRoomRole.listener && oldRole == VoiceRoomRole.listener) {
      // 升为发言者 → 默认取消静音
      _isMuted = false;
    }

    _emitState();
  }

  void _emitState() {
    _stateController.add(VoiceRoomServiceState(
      isConnected: _isConnected,
      isMuted: _isMuted,
      myRole: _myRole,
      roomId: _currentRoomId,
    ));
  }

  /// 释放资源
  void dispose() {
    _stateController.close();
  }
}

/// 语音房间服务状态
class VoiceRoomServiceState {
  final bool isConnected;
  final bool isMuted;
  final VoiceRoomRole myRole;
  final String? roomId;

  const VoiceRoomServiceState({
    this.isConnected = false,
    this.isMuted = true,
    this.myRole = VoiceRoomRole.listener,
    this.roomId,
  });
}
