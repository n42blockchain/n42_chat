/// 通话录音服务
///
/// 提供通话期间的录音功能，支持：
/// - 开始/停止/暂停/恢复录音
/// - 本地音频录制
/// - 录音文件管理
library;

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// 录音状态
enum RecordingState {
  /// 空闲（未录音）
  idle,

  /// 正在录音
  recording,

  /// 已暂停
  paused,

  /// 已停止（录音完成）
  stopped,

  /// 错误
  error,
}

/// 录音信息
class RecordingInfo {
  /// 录音 ID
  final String id;

  /// 录音文件路径
  final String filePath;

  /// 开始时间
  final DateTime startTime;

  /// 结束时间
  DateTime? endTime;

  /// 录音时长
  Duration get duration {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  /// 文件大小（字节）
  int? fileSize;

  /// 通话 ID
  final String? callId;

  /// 房间 ID
  final String? roomId;

  /// 是否是视频通话录制
  final bool isVideo;

  RecordingInfo({
    required this.id,
    required this.filePath,
    required this.startTime,
    this.endTime,
    this.fileSize,
    this.callId,
    this.roomId,
    this.isVideo = false,
  });

  RecordingInfo copyWith({
    DateTime? endTime,
    int? fileSize,
  }) {
    return RecordingInfo(
      id: id,
      filePath: filePath,
      startTime: startTime,
      endTime: endTime ?? this.endTime,
      fileSize: fileSize ?? this.fileSize,
      callId: callId,
      roomId: roomId,
      isVideo: isVideo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filePath': filePath,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'fileSize': fileSize,
      'callId': callId,
      'roomId': roomId,
      'isVideo': isVideo,
      'durationSeconds': duration.inSeconds,
    };
  }
}

/// 录音配置
class RecordingConfig {
  /// 音频采样率
  final int sampleRate;

  /// 音频比特率
  final int bitRate;

  /// 音频通道数
  final int channels;

  /// 音频编码格式
  final AudioEncoder encoder;

  /// 最大录音时长（秒），0 表示无限制
  final int maxDuration;

  /// 自动保存间隔（秒），0 表示不自动保存
  final int autoSaveInterval;

  const RecordingConfig({
    this.sampleRate = 44100,
    this.bitRate = 128000,
    this.channels = 2,
    this.encoder = AudioEncoder.aac,
    this.maxDuration = 0,
    this.autoSaveInterval = 0,
  });

  /// 默认配置
  static const RecordingConfig defaultConfig = RecordingConfig();

  /// 高质量配置
  static const RecordingConfig highQuality = RecordingConfig(
    sampleRate: 48000,
    bitRate: 256000,
    channels: 2,
    encoder: AudioEncoder.aac,
  );

  /// 低质量配置（节省空间）
  static const RecordingConfig lowQuality = RecordingConfig(
    sampleRate: 22050,
    bitRate: 64000,
    channels: 1,
    encoder: AudioEncoder.aac,
  );
}

/// 音频编码格式
enum AudioEncoder {
  /// AAC 编码
  aac,

  /// Opus 编码
  opus,

  /// WAV 格式（无压缩）
  wav,

  /// MP3 编码
  mp3,
}

/// 通话录音服务
class CallRecordingService extends ChangeNotifier {
  // 录音状态
  RecordingState _state = RecordingState.idle;
  RecordingInfo? _currentRecording;

  // 配置
  RecordingConfig _config = RecordingConfig.defaultConfig;

  // 录音时长计时器
  Timer? _durationTimer;
  Duration _currentDuration = Duration.zero;

  // 回调
  void Function(RecordingState state)? onStateChanged;
  void Function(Duration duration)? onDurationUpdate;
  void Function(RecordingInfo recording)? onRecordingCompleted;
  void Function(String error)? onError;

  // ============================================
  // Getters
  // ============================================

  /// 当前录音状态
  RecordingState get state => _state;

  /// 是否正在录音
  bool get isRecording => _state == RecordingState.recording;

  /// 是否已暂停
  bool get isPaused => _state == RecordingState.paused;

  /// 当前录音信息
  RecordingInfo? get currentRecording => _currentRecording;

  /// 当前录音时长
  Duration get currentDuration => _currentDuration;

  /// 当前配置
  RecordingConfig get config => _config;

  // ============================================
  // 配置
  // ============================================

  /// 设置录音配置
  void setConfig(RecordingConfig config) {
    if (_state != RecordingState.idle) {
      debugPrint('CallRecordingService: Cannot change config while recording');
      return;
    }
    _config = config;
  }

  // ============================================
  // 录音控制
  // ============================================

  /// 开始录音
  ///
  /// [callId] 通话 ID
  /// [roomId] 房间 ID
  /// [isVideo] 是否是视频通话
  Future<bool> startRecording({
    String? callId,
    String? roomId,
    bool isVideo = false,
  }) async {
    if (_state == RecordingState.recording) {
      debugPrint('CallRecordingService: Already recording');
      return false;
    }

    try {
      // 生成录音文件路径
      final filePath = await _generateRecordingPath(isVideo);

      // 生成录音 ID
      final recordingId = 'rec_${DateTime.now().millisecondsSinceEpoch}';

      // 创建录音信息
      _currentRecording = RecordingInfo(
        id: recordingId,
        filePath: filePath,
        startTime: DateTime.now(),
        callId: callId,
        roomId: roomId,
        isVideo: isVideo,
      );

      // 开始录音（实际录音逻辑需要平台特定实现）
      await _startNativeRecording(filePath);

      _setState(RecordingState.recording);
      _startDurationTimer();

      debugPrint('CallRecordingService: Started recording to $filePath');
      return true;
    } catch (e) {
      debugPrint('CallRecordingService: Failed to start recording: $e');
      _setState(RecordingState.error);
      onError?.call('Failed to start recording: $e');
      return false;
    }
  }

  /// 停止录音
  Future<RecordingInfo?> stopRecording() async {
    if (_state != RecordingState.recording && _state != RecordingState.paused) {
      debugPrint('CallRecordingService: Not recording');
      return null;
    }

    try {
      // 停止原生录音
      await _stopNativeRecording();

      // 更新录音信息
      _currentRecording = _currentRecording?.copyWith(
        endTime: DateTime.now(),
        fileSize: await _getFileSize(_currentRecording!.filePath),
      );

      _stopDurationTimer();
      _setState(RecordingState.stopped);

      final recording = _currentRecording;
      onRecordingCompleted?.call(recording!);

      debugPrint('CallRecordingService: Stopped recording, duration: ${recording?.duration}');

      return recording;
    } catch (e) {
      debugPrint('CallRecordingService: Failed to stop recording: $e');
      _setState(RecordingState.error);
      onError?.call('Failed to stop recording: $e');
      return null;
    }
  }

  /// 暂停录音
  Future<void> pauseRecording() async {
    if (_state != RecordingState.recording) {
      debugPrint('CallRecordingService: Not recording');
      return;
    }

    try {
      await _pauseNativeRecording();
      _stopDurationTimer();
      _setState(RecordingState.paused);
      debugPrint('CallRecordingService: Paused recording');
    } catch (e) {
      debugPrint('CallRecordingService: Failed to pause recording: $e');
      onError?.call('Failed to pause recording: $e');
    }
  }

  /// 恢复录音
  Future<void> resumeRecording() async {
    if (_state != RecordingState.paused) {
      debugPrint('CallRecordingService: Not paused');
      return;
    }

    try {
      await _resumeNativeRecording();
      _startDurationTimer();
      _setState(RecordingState.recording);
      debugPrint('CallRecordingService: Resumed recording');
    } catch (e) {
      debugPrint('CallRecordingService: Failed to resume recording: $e');
      onError?.call('Failed to resume recording: $e');
    }
  }

  /// 取消录音（删除录音文件）
  Future<void> cancelRecording() async {
    if (_state == RecordingState.idle) {
      return;
    }

    try {
      await _stopNativeRecording();
      _stopDurationTimer();

      // 删除录音文件
      if (_currentRecording != null) {
        final file = File(_currentRecording!.filePath);
        if (await file.exists()) {
          await file.delete();
          debugPrint('CallRecordingService: Deleted recording file');
        }
      }

      _currentRecording = null;
      _currentDuration = Duration.zero;
      _setState(RecordingState.idle);

      debugPrint('CallRecordingService: Cancelled recording');
    } catch (e) {
      debugPrint('CallRecordingService: Failed to cancel recording: $e');
    }
  }

  // ============================================
  // 录音文件管理
  // ============================================

  /// 获取录音文件列表
  Future<List<RecordingInfo>> getRecordings() async {
    final dir = await _getRecordingsDirectory();
    final files = await dir.list().toList();

    final recordings = <RecordingInfo>[];
    for (final file in files) {
      if (file is File && _isRecordingFile(file.path)) {
        final stat = await file.stat();
        recordings.add(RecordingInfo(
          id: file.path.split('/').last.split('.').first,
          filePath: file.path,
          startTime: stat.modified,
          fileSize: stat.size,
        ));
      }
    }

    // 按时间倒序排列
    recordings.sort((a, b) => b.startTime.compareTo(a.startTime));
    return recordings;
  }

  /// 删除录音文件
  Future<bool> deleteRecording(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        debugPrint('CallRecordingService: Deleted recording: $filePath');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('CallRecordingService: Failed to delete recording: $e');
      return false;
    }
  }

  /// 获取录音目录大小（字节）
  Future<int> getRecordingsSize() async {
    final dir = await _getRecordingsDirectory();
    int totalSize = 0;

    await for (final file in dir.list(recursive: true)) {
      if (file is File) {
        totalSize += await file.length();
      }
    }

    return totalSize;
  }

  /// 清理所有录音
  Future<void> clearAllRecordings() async {
    final dir = await _getRecordingsDirectory();
    await for (final file in dir.list()) {
      if (file is File && _isRecordingFile(file.path)) {
        await file.delete();
      }
    }
    debugPrint('CallRecordingService: Cleared all recordings');
  }

  // ============================================
  // 私有方法
  // ============================================

  /// 生成录音文件路径
  Future<String> _generateRecordingPath(bool isVideo) async {
    final dir = await _getRecordingsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = _getFileExtension();
    return '${dir.path}/call_$timestamp.$extension';
  }

  /// 获取录音目录
  Future<Directory> _getRecordingsDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final recordingsDir = Directory('${appDir.path}/call_recordings');
    if (!await recordingsDir.exists()) {
      await recordingsDir.create(recursive: true);
    }
    return recordingsDir;
  }

  /// 获取文件扩展名
  String _getFileExtension() {
    switch (_config.encoder) {
      case AudioEncoder.aac:
        return 'm4a';
      case AudioEncoder.opus:
        return 'opus';
      case AudioEncoder.wav:
        return 'wav';
      case AudioEncoder.mp3:
        return 'mp3';
    }
  }

  /// 判断是否是录音文件
  bool _isRecordingFile(String path) {
    final ext = path.split('.').last.toLowerCase();
    return ['m4a', 'opus', 'wav', 'mp3', 'aac'].contains(ext);
  }

  /// 获取文件大小
  Future<int?> _getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
    } catch (e) {
      debugPrint('CallRecordingService: Failed to get file size: $e');
    }
    return null;
  }

  /// 开始原生录音
  ///
  /// 注意：实际实现需要使用平台特定的录音插件
  /// 例如：record、flutter_sound 等
  Future<void> _startNativeRecording(String filePath) async {
    // TODO: 集成实际的录音插件
    // 示例代码（使用 record 包）：
    // await _recorder.start(
    //   path: filePath,
    //   encoder: AudioEncoder.aacLc,
    //   bitRate: _config.bitRate,
    //   sampleRate: _config.sampleRate,
    // );
    debugPrint('CallRecordingService: Native recording started (stub)');
  }

  /// 停止原生录音
  Future<void> _stopNativeRecording() async {
    // TODO: 集成实际的录音插件
    // await _recorder.stop();
    debugPrint('CallRecordingService: Native recording stopped (stub)');
  }

  /// 暂停原生录音
  Future<void> _pauseNativeRecording() async {
    // TODO: 集成实际的录音插件
    // await _recorder.pause();
    debugPrint('CallRecordingService: Native recording paused (stub)');
  }

  /// 恢复原生录音
  Future<void> _resumeNativeRecording() async {
    // TODO: 集成实际的录音插件
    // await _recorder.resume();
    debugPrint('CallRecordingService: Native recording resumed (stub)');
  }

  /// 设置状态
  void _setState(RecordingState newState) {
    if (_state == newState) return;
    _state = newState;
    onStateChanged?.call(_state);
    notifyListeners();
    debugPrint('CallRecordingService: State changed to $_state');
  }

  /// 开始时长计时器
  void _startDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _currentDuration += const Duration(seconds: 1);
      onDurationUpdate?.call(_currentDuration);
      notifyListeners();

      // 检查最大时长限制
      if (_config.maxDuration > 0 &&
          _currentDuration.inSeconds >= _config.maxDuration) {
        debugPrint('CallRecordingService: Max duration reached');
        stopRecording();
      }
    });
  }

  /// 停止时长计时器
  void _stopDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = null;
  }

  /// 重置状态
  void reset() {
    _stopDurationTimer();
    _currentRecording = null;
    _currentDuration = Duration.zero;
    _state = RecordingState.idle;
    notifyListeners();
  }

  @override
  void dispose() {
    _stopDurationTimer();
    super.dispose();
  }
}
