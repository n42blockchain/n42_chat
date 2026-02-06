/// 格式化工具类
///
/// 提供通用的格式化功能，如文件大小、时间等
class FormatUtils {
  FormatUtils._();

  /// 格式化文件大小
  ///
  /// 自动选择合适的单位（B, KB, MB, GB）
  static String formatFileSize(int bytes) {
    if (bytes < 0) return '0 B';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// 格式化时长（秒）
  ///
  /// 返回格式如 "01:30" 或 "1:23:45"
  static String formatDuration(int seconds) {
    if (seconds < 0) seconds = 0;

    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}';
  }

  /// 格式化人类可读时长
  ///
  /// 返回格式如 "5s", "2m 30s", "1h 5m", "2d 3h"
  static String formatHumanDuration(int seconds) {
    if (seconds < 0) seconds = 0;

    if (seconds < 60) {
      return '${seconds}s';
    } else if (seconds < 3600) {
      final minutes = seconds ~/ 60;
      final secs = seconds % 60;
      return secs > 0 ? '${minutes}m ${secs}s' : '${minutes}m';
    } else if (seconds < 86400) {
      final hours = seconds ~/ 3600;
      final minutes = (seconds % 3600) ~/ 60;
      return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
    } else {
      final days = seconds ~/ 86400;
      final hours = (seconds % 86400) ~/ 3600;
      return hours > 0 ? '${days}d ${hours}h' : '${days}d';
    }
  }

  /// 格式化相对时间
  ///
  /// [timestamp] 目标时间
  /// [locale] 语言环境 ('zh' 为中文，其他为英文)
  static String formatRelativeTime(DateTime timestamp, {String locale = 'en'}) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    final isZh = locale.startsWith('zh');

    if (difference.inSeconds < 60) {
      return isZh ? '刚刚' : 'Just now';
    } else if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return isZh ? '$mins分钟前' : '$mins minutes ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return isZh ? '$hours小时前' : '$hours hours ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return isZh ? '$days天前' : '$days days ago';
    } else if (difference.inDays < 30) {
      final weeks = difference.inDays ~/ 7;
      return isZh ? '$weeks周前' : '$weeks weeks ago';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return isZh ? '$months个月前' : '$months months ago';
    } else {
      final years = difference.inDays ~/ 365;
      return isZh ? '$years年前' : '$years years ago';
    }
  }

  /// 截断字符串
  ///
  /// 超过 [maxLength] 时添加省略号
  static String truncate(String text, int maxLength, {String ellipsis = '...'}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// 格式化数字（添加千分位分隔符）
  static String formatNumber(int number) {
    final str = number.toString();
    final buffer = StringBuffer();
    final length = str.length;

    for (var i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(str[i]);
    }

    return buffer.toString();
  }

  /// 格式化紧凑数字（如 1.2K, 3.5M）
  static String formatCompactNumber(int number) {
    if (number < 1000) return number.toString();
    if (number < 1000000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    if (number < 1000000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }
    return '${(number / 1000000000).toStringAsFixed(1)}B';
  }
}
