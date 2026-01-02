import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart' as matrix;

/// Matrix 工具类
///
/// 提供 Matrix 相关的通用工具方法
class MatrixUtils {
  MatrixUtils._();

  /// 将 mxc:// URL 转换为 HTTP URL
  ///
  /// [mxcUrl] Matrix 内容 URL (mxc://server/media_id)
  /// [client] Matrix 客户端实例
  /// [width] 缩略图宽度（可选）
  /// [height] 缩略图高度（可选）
  /// [method] 缩略图方法（默认 scale）
  /// [animated] 是否保留动画（GIF等）
  static String? mxcToHttp(
    String? mxcUrl, {
    required matrix.Client? client,
    int? width,
    int? height,
    matrix.ThumbnailMethod method = matrix.ThumbnailMethod.scale,
    bool animated = false,
  }) {
    if (mxcUrl == null || mxcUrl.isEmpty || client == null) {
      return null;
    }

    // 如果已经是 HTTP URL，直接返回
    if (mxcUrl.startsWith('http://') || mxcUrl.startsWith('https://')) {
      return mxcUrl;
    }

    // 验证是否是有效的 mxc:// URL
    if (!mxcUrl.startsWith('mxc://')) {
      debugPrint('MatrixUtils: Invalid mxc URL: $mxcUrl');
      return null;
    }

    try {
      final uri = Uri.parse(mxcUrl);

      // 如果需要缩略图
      if (width != null && height != null) {
        return uri
            .getThumbnail(
              client,
              width: width,
              height: height,
              method: method,
              animated: animated,
            )
            .toString();
      }

      // 返回完整下载链接
      return uri.getDownloadLink(client).toString();
    } catch (e) {
      debugPrint('MatrixUtils: Error converting mxc URL: $e');
      return null;
    }
  }

  /// 获取头像 HTTP URL
  ///
  /// 专门用于头像的 URL 转换，默认使用裁剪方式
  static String? getAvatarUrl(
    Uri? avatarMxc, {
    required matrix.Client? client,
    int size = 80,
  }) {
    if (avatarMxc == null || client == null) {
      return null;
    }

    try {
      return avatarMxc
          .getThumbnail(
            client,
            width: size,
            height: size,
            method: matrix.ThumbnailMethod.crop,
          )
          .toString();
    } catch (e) {
      debugPrint('MatrixUtils: Error getting avatar URL: $e');
      return null;
    }
  }

  /// 获取媒体预览 URL（用于图片/视频缩略图）
  static String? getMediaPreviewUrl(
    String? mxcUrl, {
    required matrix.Client? client,
    int maxWidth = 400,
    int maxHeight = 400,
  }) {
    return mxcToHttp(
      mxcUrl,
      client: client,
      width: maxWidth,
      height: maxHeight,
      method: matrix.ThumbnailMethod.scale,
      animated: true,
    );
  }

  /// 获取媒体完整下载 URL
  static String? getMediaDownloadUrl(
    String? mxcUrl, {
    required matrix.Client? client,
  }) {
    return mxcToHttp(mxcUrl, client: client);
  }

  /// 解析 Matrix 用户 ID 获取用户名
  ///
  /// @user:server.com -> user
  static String? getUsernameFromUserId(String? userId) {
    if (userId == null || !userId.startsWith('@')) {
      return null;
    }
    final colonIndex = userId.indexOf(':');
    if (colonIndex == -1) {
      return userId.substring(1);
    }
    return userId.substring(1, colonIndex);
  }

  /// 解析 Matrix 用户 ID 获取服务器
  ///
  /// @user:server.com -> server.com
  static String? getServerFromUserId(String? userId) {
    if (userId == null || !userId.contains(':')) {
      return null;
    }
    return userId.substring(userId.indexOf(':') + 1);
  }

  /// 生成默认头像文字（用户首字母）
  static String getAvatarInitials(String? displayName, String? userId) {
    final name = displayName ?? getUsernameFromUserId(userId) ?? '?';
    if (name.isEmpty) return '?';

    final words = name.trim().split(RegExp(r'\s+'));
    if (words.length == 1) {
      return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
    }
    return words
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0].toUpperCase())
        .join();
  }

  /// 格式化文件大小
  static String formatFileSize(int? bytes) {
    if (bytes == null || bytes <= 0) return '';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// 格式化时长（毫秒）
  static String formatDuration(int? milliseconds) {
    if (milliseconds == null || milliseconds <= 0) return '0:00';
    final seconds = (milliseconds / 1000).round();
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// 格式化语音时长（秒）
  static String formatVoiceDuration(int seconds) {
    if (seconds < 60) return '$seconds"';
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (remainingSeconds == 0) return "$minutes'";
    return "$minutes'$remainingSeconds\"";
  }

  /// 检测 MIME 类型
  static String getMimeType(String filename) {
    final ext = filename.toLowerCase().split('.').last;
    switch (ext) {
      // 图片
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'heic':
      case 'heif':
        return 'image/heic';
      case 'bmp':
        return 'image/bmp';
      case 'svg':
        return 'image/svg+xml';
      // 音频
      case 'm4a':
      case 'aac':
        return 'audio/mp4';
      case 'mp3':
        return 'audio/mpeg';
      case 'ogg':
      case 'opus':
        return 'audio/ogg';
      case 'wav':
        return 'audio/wav';
      case 'webm':
        return 'audio/webm';
      // 视频
      case 'mp4':
        return 'video/mp4';
      case 'mov':
        return 'video/quicktime';
      case 'avi':
        return 'video/x-msvideo';
      case 'mkv':
        return 'video/x-matroska';
      // 文档
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'ppt':
        return 'application/vnd.ms-powerpoint';
      case 'pptx':
        return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
      case 'txt':
        return 'text/plain';
      case 'json':
        return 'application/json';
      case 'xml':
        return 'application/xml';
      case 'zip':
        return 'application/zip';
      case 'rar':
        return 'application/x-rar-compressed';
      case '7z':
        return 'application/x-7z-compressed';
      default:
        return 'application/octet-stream';
    }
  }

  /// 根据 MIME 类型获取消息类型
  static String getMessageTypeFromMime(String? mimeType) {
    if (mimeType == null) return 'm.file';
    if (mimeType.startsWith('image/')) return 'm.image';
    if (mimeType.startsWith('audio/')) return 'm.audio';
    if (mimeType.startsWith('video/')) return 'm.video';
    return 'm.file';
  }

  /// 检查文件名是否有扩展名，如果没有则添加
  static String ensureFileExtension(String filename, String path) {
    if (filename.contains('.')) return filename;

    final pathExt = path.split('.').last.toLowerCase();
    if (pathExt.isNotEmpty && pathExt.length <= 5) {
      return '$filename.$pathExt';
    }

    return filename;
  }

  /// 生成唯一的临时文件名
  static String generateTempFilename(String extension) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'temp_$timestamp.$extension';
  }
}

