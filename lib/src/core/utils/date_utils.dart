import 'package:intl/intl.dart';

/// 日期时间工具类
///
/// 提供微信风格的时间格式化
abstract class N42DateUtils {
  N42DateUtils._();

  /// 格式化会话列表时间
  ///
  /// - 今天: 显示时:分 (如 14:30)
  /// - 昨天: 显示"昨天"
  /// - 本周: 显示星期几
  /// - 今年: 显示月-日 (如 12-25)
  /// - 更早: 显示年-月-日 (如 2023-12-25)
  static String formatConversationTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (targetDate == today) {
      // 今天，显示时间
      return DateFormat('HH:mm').format(dateTime);
    } else if (targetDate == yesterday) {
      // 昨天
      return '昨天';
    } else if (now.difference(dateTime).inDays < 7 &&
        dateTime.weekday < now.weekday) {
      // 本周（且在今天之前）
      return _getWeekdayName(dateTime.weekday);
    } else if (dateTime.year == now.year) {
      // 今年
      return DateFormat('M月d日').format(dateTime);
    } else {
      // 更早
      return DateFormat('yyyy年M月d日').format(dateTime);
    }
  }

  /// 格式化消息时间（完整格式）
  ///
  /// 用于消息详情页的时间分隔线
  static String formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    String dateStr;
    if (targetDate == today) {
      dateStr = '';
    } else if (targetDate == yesterday) {
      dateStr = '昨天 ';
    } else if (now.difference(dateTime).inDays < 7 &&
        dateTime.weekday < now.weekday) {
      dateStr = '${_getWeekdayName(dateTime.weekday)} ';
    } else if (dateTime.year == now.year) {
      dateStr = '${DateFormat('M月d日').format(dateTime)} ';
    } else {
      dateStr = '${DateFormat('yyyy年M月d日').format(dateTime)} ';
    }

    return '$dateStr${DateFormat('HH:mm').format(dateTime)}';
  }

  /// 格式化消息详情时间（用于消息详情）
  static String formatMessageDetailTime(DateTime dateTime) {
    return DateFormat('yyyy年M月d日 HH:mm').format(dateTime);
  }

  /// 格式化相对时间
  ///
  /// - 刚刚 (< 1分钟)
  /// - x分钟前 (< 1小时)
  /// - x小时前 (< 24小时)
  /// - 昨天
  /// - x天前 (< 7天)
  /// - 日期
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '刚刚';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays == 1) {
      return '昨天';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return formatConversationTime(dateTime);
    }
  }

  /// 格式化语音消息时长
  ///
  /// 返回格式：x" 或 x'y"
  static String formatVoiceDuration(Duration duration) {
    final seconds = duration.inSeconds;
    if (seconds < 60) {
      return '$seconds"';
    } else {
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      if (remainingSeconds == 0) {
        return "$minutes'";
      }
      return "$minutes'$remainingSeconds\"";
    }
  }

  /// 格式化在线状态时间
  static String formatLastSeen(DateTime? lastSeen) {
    if (lastSeen == null) return '离线';

    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    if (difference.inMinutes < 5) {
      return '在线';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前在线';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}小时前在线';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前在线';
    } else {
      return '离线';
    }
  }

  /// 判断两条消息是否需要显示时间分隔
  ///
  /// 超过5分钟显示时间
  static bool shouldShowTimeSeparator(DateTime? prev, DateTime current) {
    if (prev == null) return true;
    return current.difference(prev).inMinutes >= 5;
  }

  /// 判断是否同一天
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// 获取星期几名称
  static String _getWeekdayName(int weekday) {
    const names = ['', '周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return names[weekday];
  }
}

