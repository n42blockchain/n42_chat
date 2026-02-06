import 'package:flutter/foundation.dart' show kIsWeb;

/// Web 平台适配器
///
/// 提供 Web 平台特有功能的抽象和降级处理
class WebAdapter {
  WebAdapter._();

  /// 是否支持本地存储
  static bool get supportsLocalStorage => true;

  /// 是否支持 IndexedDB
  static bool get supportsIndexedDB => kIsWeb;

  /// 是否支持通知 API
  static bool get supportsNotifications => kIsWeb;

  /// 是否支持 Service Worker
  static bool get supportsServiceWorker => kIsWeb;

  /// 是否支持 WebRTC
  static bool get supportsWebRTC => true;

  /// 是否支持媒体设备（摄像头、麦克风）
  static bool get supportsMediaDevices => true;

  /// 是否支持屏幕共享
  static bool get supportsScreenShare => kIsWeb;

  /// 是否支持全屏
  static bool get supportsFullscreen => kIsWeb;

  /// 是否支持剪贴板
  static bool get supportsClipboard => true;

  /// 是否支持拖放
  static bool get supportsDragDrop => true;

  /// 是否支持文件上传
  static bool get supportsFileUpload => true;

  /// 是否支持文件下载
  static bool get supportsFileDownload => true;

  /// 是否支持后台同步
  static bool get supportsBackgroundSync => kIsWeb;

  /// 是否支持 PWA 安装
  static bool get supportsPWAInstall => kIsWeb;

  /// 获取推荐的存储方式
  static StorageType get recommendedStorage {
    if (kIsWeb) {
      return StorageType.indexedDB;
    }
    return StorageType.sqlite;
  }

  /// 获取推荐的缓存策略
  static CacheStrategy get recommendedCacheStrategy {
    if (kIsWeb) {
      return CacheStrategy.serviceWorker;
    }
    return CacheStrategy.fileSystem;
  }

  /// 获取最大上传文件大小（字节）
  static int get maxUploadSize {
    if (kIsWeb) {
      return 100 * 1024 * 1024; // 100MB for web
    }
    return 2 * 1024 * 1024 * 1024; // 2GB for native
  }

  /// 获取最大并发上传数
  static int get maxConcurrentUploads {
    if (kIsWeb) {
      return 3; // Limited for web
    }
    return 5; // More for native
  }

  /// 获取推荐的图片质量
  static int get recommendedImageQuality {
    if (kIsWeb) {
      return 75; // Lower quality for web to reduce bandwidth
    }
    return 85;
  }

  /// 获取推荐的视频质量
  static VideoQuality get recommendedVideoQuality {
    if (kIsWeb) {
      return VideoQuality.hd720;
    }
    return VideoQuality.hd1080;
  }

  /// 检查是否为移动端 Web
  static bool get isMobileWeb {
    if (!kIsWeb) return false;
    // 在 Web 上需要通过 JS 检查 user agent
    return false; // 需要 JS interop 实现
  }

  /// 检查是否支持触摸
  static bool get supportsTouchInput {
    if (kIsWeb) {
      return true; // Web 默认支持触摸
    }
    return false; // 需要平台检测
  }
}

/// 存储类型
enum StorageType {
  /// SQLite 数据库
  sqlite,

  /// IndexedDB (Web)
  indexedDB,

  /// SharedPreferences
  sharedPreferences,

  /// 内存存储
  memory,
}

/// 缓存策略
enum CacheStrategy {
  /// 文件系统缓存
  fileSystem,

  /// Service Worker 缓存
  serviceWorker,

  /// 内存缓存
  memory,

  /// 无缓存
  none,
}

/// 视频质量
enum VideoQuality {
  /// 360p
  sd360,

  /// 480p
  sd480,

  /// 720p HD
  hd720,

  /// 1080p Full HD
  hd1080,

  /// 4K UHD
  uhd4k,
}

/// Web 通知适配器
class WebNotificationAdapter {
  WebNotificationAdapter._();

  /// 请求通知权限
  static Future<NotificationPermission> requestPermission() async {
    if (!kIsWeb) {
      return NotificationPermission.granted; // Native handles differently
    }
    // Web implementation would use JS interop
    return NotificationPermission.default_;
  }

  /// 发送通知
  static Future<void> showNotification({
    required String title,
    String? body,
    String? icon,
    String? tag,
    Map<String, dynamic>? data,
  }) async {
    if (!kIsWeb) {
      return; // Use native notification system
    }
    // Web implementation would use JS interop
  }

  /// 关闭通知
  static Future<void> closeNotification(String tag) async {
    if (!kIsWeb) {
      return;
    }
    // Web implementation
  }
}

/// 通知权限状态
enum NotificationPermission {
  /// 默认（未请求）
  default_,

  /// 已授权
  granted,

  /// 已拒绝
  denied,
}

/// Web 存储适配器
class WebStorageAdapter {
  WebStorageAdapter._();

  /// 保存到本地存储
  static Future<void> setItem(String key, String value) async {
    if (!kIsWeb) {
      return; // Use SharedPreferences on native
    }
    // Web implementation would use JS interop for localStorage
  }

  /// 从本地存储读取
  static Future<String?> getItem(String key) async {
    if (!kIsWeb) {
      return null; // Use SharedPreferences on native
    }
    // Web implementation
    return null;
  }

  /// 从本地存储删除
  static Future<void> removeItem(String key) async {
    if (!kIsWeb) {
      return;
    }
    // Web implementation
  }

  /// 清空本地存储
  static Future<void> clear() async {
    if (!kIsWeb) {
      return;
    }
    // Web implementation
  }

  /// 获取存储使用量（字节）
  static Future<StorageUsage> getStorageUsage() async {
    return const StorageUsage(
      used: 0,
      quota: 0,
      available: 0,
    );
  }
}

/// 存储使用情况
class StorageUsage {
  /// 已使用字节
  final int used;

  /// 配额字节
  final int quota;

  /// 可用字节
  final int available;

  const StorageUsage({
    required this.used,
    required this.quota,
    required this.available,
  });

  /// 使用百分比
  double get usagePercent {
    if (quota == 0) return 0;
    return (used / quota) * 100;
  }

  /// 格式化已使用空间
  String get formattedUsed => _formatBytes(used);

  /// 格式化配额
  String get formattedQuota => _formatBytes(quota);

  /// 格式化可用空间
  String get formattedAvailable => _formatBytes(available);

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

/// Web 全屏适配器
class WebFullscreenAdapter {
  WebFullscreenAdapter._();

  /// 是否全屏
  static bool get isFullscreen => false; // Need JS interop

  /// 进入全屏
  static Future<void> enterFullscreen() async {
    if (!kIsWeb) {
      return;
    }
    // Web implementation
  }

  /// 退出全屏
  static Future<void> exitFullscreen() async {
    if (!kIsWeb) {
      return;
    }
    // Web implementation
  }

  /// 切换全屏
  static Future<void> toggleFullscreen() async {
    if (isFullscreen) {
      await exitFullscreen();
    } else {
      await enterFullscreen();
    }
  }
}

/// Web 剪贴板适配器
class WebClipboardAdapter {
  WebClipboardAdapter._();

  /// 复制文本到剪贴板
  static Future<bool> copyText(String text) async {
    // Implementation using Clipboard.setData
    return true;
  }

  /// 从剪贴板读取文本
  static Future<String?> readText() async {
    // Implementation using Clipboard.getData
    return null;
  }

  /// 复制图片到剪贴板（仅 Web 支持）
  static Future<bool> copyImage(List<int> imageBytes) async {
    if (!kIsWeb) {
      return false; // Not all native platforms support this
    }
    // Web implementation
    return false;
  }
}

/// Web 文件适配器
class WebFileAdapter {
  WebFileAdapter._();

  /// 选择文件
  static Future<List<WebFile>> pickFiles({
    List<String>? allowedExtensions,
    bool multiple = false,
  }) async {
    // Implementation would use file_picker or html input
    return [];
  }

  /// 下载文件
  static Future<void> downloadFile({
    required String url,
    required String filename,
  }) async {
    if (!kIsWeb) {
      return; // Native uses different download mechanism
    }
    // Web implementation using anchor element
  }

  /// 从 URL 创建 Blob 下载
  static Future<void> downloadBlob({
    required List<int> bytes,
    required String filename,
    required String mimeType,
  }) async {
    if (!kIsWeb) {
      return;
    }
    // Web implementation
  }
}

/// Web 文件信息
class WebFile {
  /// 文件名
  final String name;

  /// 文件大小
  final int size;

  /// MIME 类型
  final String mimeType;

  /// 文件内容（字节）
  final List<int>? bytes;

  /// 文件路径（仅非 Web 平台）
  final String? path;

  const WebFile({
    required this.name,
    required this.size,
    required this.mimeType,
    this.bytes,
    this.path,
  });

  /// 文件扩展名
  String get extension {
    final lastDot = name.lastIndexOf('.');
    if (lastDot == -1) return '';
    return name.substring(lastDot + 1).toLowerCase();
  }

  /// 是否是图片
  bool get isImage => mimeType.startsWith('image/');

  /// 是否是视频
  bool get isVideo => mimeType.startsWith('video/');

  /// 是否是音频
  bool get isAudio => mimeType.startsWith('audio/');
}
