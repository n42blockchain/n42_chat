import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// 下载任务状态
enum DownloadStatus {
  pending,
  downloading,
  completed,
  failed,
  cancelled,
}

/// 下载任务
class DownloadTask {
  final String id;
  final String url;
  final String savePath;
  final String? fileName;
  double progress;
  DownloadStatus status;
  int totalBytes;
  int receivedBytes;
  String? error;

  DownloadTask({
    required this.id,
    required this.url,
    required this.savePath,
    this.fileName,
    this.progress = 0.0,
    this.status = DownloadStatus.pending,
    this.totalBytes = 0,
    this.receivedBytes = 0,
    this.error,
  });
}

/// 统一下载服务
///
/// 使用 http 包 + StreamedResponse 实现进度跟踪
/// 最大并发数: 3
class DownloadService {
  static const int _maxConcurrent = 3;

  final Map<String, DownloadTask> _tasks = {};
  final Map<String, StreamController<DownloadTask>> _taskControllers = {};
  int _activeCount = 0;
  int _taskIdCounter = 0;

  /// 所有活跃的下载任务
  List<DownloadTask> get activeTasks =>
      _tasks.values.where((t) => t.status == DownloadStatus.downloading || t.status == DownloadStatus.pending).toList();

  /// 下载文件
  ///
  /// 返回下载任务 ID
  Future<String> download({
    required String url,
    required String savePath,
    String? fileName,
  }) async {
    final taskId = 'download_${_taskIdCounter++}';
    final task = DownloadTask(
      id: taskId,
      url: url,
      savePath: savePath,
      fileName: fileName,
    );

    _tasks[taskId] = task;
    _taskControllers[taskId] = StreamController<DownloadTask>.broadcast();

    _startDownload(task);
    return taskId;
  }

  /// 监听下载任务进度
  Stream<DownloadTask> watchTask(String taskId) {
    return _taskControllers[taskId]?.stream ?? const Stream.empty();
  }

  /// 取消下载任务
  void cancelTask(String taskId) {
    final task = _tasks[taskId];
    if (task != null && task.status == DownloadStatus.downloading) {
      task.status = DownloadStatus.cancelled;
      _notifyTask(task);
      _activeCount--;
      _processQueue();
    }
  }

  /// 暂停下载任务（标记为取消，后续可通过 resumeTask 重新下载）
  void pauseTask(String taskId) {
    cancelTask(taskId);
  }

  /// 恢复下载任务
  void resumeTask(String taskId) {
    final task = _tasks[taskId];
    if (task != null && task.status == DownloadStatus.cancelled) {
      task.status = DownloadStatus.pending;
      task.progress = 0.0;
      task.receivedBytes = 0;
      _startDownload(task);
    }
  }

  void _startDownload(DownloadTask task) {
    if (_activeCount >= _maxConcurrent) {
      task.status = DownloadStatus.pending;
      _notifyTask(task);
      return;
    }

    _activeCount++;
    _executeDownload(task);
  }

  Future<void> _executeDownload(DownloadTask task) async {
    task.status = DownloadStatus.downloading;
    _notifyTask(task);

    try {
      final request = http.Request('GET', Uri.parse(task.url));
      final client = http.Client();
      final response = await client.send(request);

      if (response.statusCode != 200) {
        throw HttpException('HTTP ${response.statusCode}');
      }

      task.totalBytes = response.contentLength ?? 0;
      final file = File(task.savePath);
      await file.parent.create(recursive: true);
      final sink = file.openWrite();

      await for (final chunk in response.stream) {
        if (task.status == DownloadStatus.cancelled) {
          await sink.close();
          client.close();
          return;
        }

        sink.add(chunk);
        task.receivedBytes += chunk.length;
        if (task.totalBytes > 0) {
          task.progress = task.receivedBytes / task.totalBytes;
        }
        _notifyTask(task);
      }

      await sink.close();
      client.close();

      task.status = DownloadStatus.completed;
      task.progress = 1.0;
      _notifyTask(task);
    } catch (e) {
      task.status = DownloadStatus.failed;
      task.error = e.toString();
      _notifyTask(task);
    } finally {
      _activeCount--;
      _processQueue();
    }
  }

  void _processQueue() {
    // 找到等待中的任务并启动
    for (final task in _tasks.values) {
      if (task.status == DownloadStatus.pending && _activeCount < _maxConcurrent) {
        _activeCount++;
        _executeDownload(task);
      }
    }
  }

  void _notifyTask(DownloadTask task) {
    _taskControllers[task.id]?.add(task);
  }

  /// 获取默认下载目录
  static Future<String> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      final dir = await getExternalStorageDirectory();
      return '${dir?.path ?? '/storage/emulated/0/Download'}/N42';
    } else {
      final dir = await getApplicationDocumentsDirectory();
      return '${dir.path}/Downloads';
    }
  }

  /// 清理已完成的任务
  void clearCompleted() {
    final completedIds = _tasks.entries
        .where((e) => e.value.status == DownloadStatus.completed)
        .map((e) => e.key)
        .toList();

    for (final id in completedIds) {
      _taskControllers[id]?.close();
      _taskControllers.remove(id);
      _tasks.remove(id);
    }
  }

  /// 释放资源
  void dispose() {
    for (final controller in _taskControllers.values) {
      controller.close();
    }
    _taskControllers.clear();
    _tasks.clear();
  }
}
