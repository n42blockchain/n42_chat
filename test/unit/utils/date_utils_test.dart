// Tests for N42DateUtils and DateLocaleStrings.
// Uses clock-based time arithmetic — results compared against known offsets.
// No Flutter / platform dependencies.

import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/utils/date_utils.dart';

// ─────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────

/// Returns a DateTime that is [seconds] seconds before now.
DateTime _secsAgo(int seconds) =>
    DateTime.now().subtract(Duration(seconds: seconds));

/// Returns a DateTime that is [minutes] minutes before now.
DateTime _minsAgo(int minutes) =>
    DateTime.now().subtract(Duration(minutes: minutes));

/// Returns a DateTime that is [hours] hours before now.
DateTime _hoursAgo(int hours) =>
    DateTime.now().subtract(Duration(hours: hours));

/// Returns a DateTime that is [days] days before now.
DateTime _daysAgo(int days) =>
    DateTime.now().subtract(Duration(days: days));

void main() {
  // ─────────────────────────────────────────────────
  // DateLocaleStrings defaults
  // ─────────────────────────────────────────────────

  group('DateLocaleStrings defaults (English)', () {
    const locale = DateLocaleStrings();

    test('yesterday is "Yesterday"', () {
      expect(locale.yesterday, 'Yesterday');
    });

    test('justNow is "Just now"', () {
      expect(locale.justNow, 'Just now');
    });

    test('minutesAgo format', () {
      expect(locale.minutesAgo(5), '5 min ago');
    });

    test('hoursAgo format', () {
      expect(locale.hoursAgo(3), '3h ago');
    });

    test('daysAgo format', () {
      expect(locale.daysAgo(4), '4d ago');
    });

    test('online is "Online"', () {
      expect(locale.online, 'Online');
    });

    test('offline is "Offline"', () {
      expect(locale.offline, 'Offline');
    });

    test('minutesAgoOnline format', () {
      expect(locale.minutesAgoOnline(10), '10 min ago');
    });

    test('hoursAgoOnline format', () {
      expect(locale.hoursAgoOnline(2), '2h ago');
    });

    test('monthDay default format', () {
      expect(locale.monthDay(12, 25), '12/25');
    });

    test('yearMonthDay default format', () {
      expect(locale.yearMonthDay(2023, 12, 25), '2023/12/25');
    });
  });

  // ─────────────────────────────────────────────────
  // DateLocaleStrings.chinese
  // ─────────────────────────────────────────────────

  group('DateLocaleStrings.chinese', () {
    const locale = DateLocaleStrings.chinese;

    test('yesterday is "昨天"', () {
      expect(locale.yesterday, '昨天');
    });

    test('justNow is "刚刚"', () {
      expect(locale.justNow, '刚刚');
    });

    test('minutesAgo format', () {
      expect(locale.minutesAgo(5), '5分钟前');
    });

    test('hoursAgo format', () {
      expect(locale.hoursAgo(2), '2小时前');
    });

    test('daysAgo format', () {
      expect(locale.daysAgo(3), '3天前');
    });

    test('minutesAgoOnline format', () {
      expect(locale.minutesAgoOnline(10), '10分钟前在线');
    });

    test('hoursAgoOnline format', () {
      expect(locale.hoursAgoOnline(1), '1小时前在线');
    });

    test('daysAgoOnline format', () {
      expect(locale.daysAgoOnline(2), '2天前在线');
    });

    test('monthDay Chinese format', () {
      expect(locale.monthDay(12, 25), '12月25日');
    });

    test('yearMonthDay Chinese format', () {
      expect(locale.yearMonthDay(2023, 12, 25), '2023年12月25日');
    });

    test('weekdays list has 8 entries (index 0 empty, 1-7 Mon-Sun)', () {
      expect(locale.weekdays, isNotNull);
      expect(locale.weekdays!.length, 8);
      expect(locale.weekdays![1], '周一');
      expect(locale.weekdays![7], '周日');
    });
  });

  // ─────────────────────────────────────────────────
  // DateLocaleStrings.fromLocaleCode
  // ─────────────────────────────────────────────────

  group('DateLocaleStrings.fromLocaleCode', () {
    test('zh returns Chinese locale', () {
      final locale = DateLocaleStrings.fromLocaleCode('zh');
      expect(locale.yesterday, '昨天');
    });

    test('zh_CN returns Chinese locale', () {
      final locale = DateLocaleStrings.fromLocaleCode('zh_CN');
      expect(locale.justNow, '刚刚');
    });

    test('en returns default English locale', () {
      final locale = DateLocaleStrings.fromLocaleCode('en');
      expect(locale.yesterday, 'Yesterday');
    });

    test('unknown code returns default English locale', () {
      final locale = DateLocaleStrings.fromLocaleCode('fr');
      expect(locale.yesterday, 'Yesterday');
    });
  });

  // ─────────────────────────────────────────────────
  // N42DateUtils.formatVoiceDuration
  // ─────────────────────────────────────────────────

  group('N42DateUtils.formatVoiceDuration', () {
    test('0 seconds shows 0"', () {
      expect(N42DateUtils.formatVoiceDuration(Duration.zero), '0"');
    });

    test('30 seconds shows 30"', () {
      expect(N42DateUtils.formatVoiceDuration(const Duration(seconds: 30)), '30"');
    });

    test('59 seconds shows 59"', () {
      expect(N42DateUtils.formatVoiceDuration(const Duration(seconds: 59)), '59"');
    });

    test('exactly 60 seconds shows 1\'', () {
      expect(N42DateUtils.formatVoiceDuration(const Duration(seconds: 60)), "1'");
    });

    test('90 seconds shows 1\'30"', () {
      expect(N42DateUtils.formatVoiceDuration(const Duration(seconds: 90)), "1'30\"");
    });

    test('exactly 2 minutes shows 2\'', () {
      expect(N42DateUtils.formatVoiceDuration(const Duration(minutes: 2)), "2'");
    });

    test('2 minutes 15 seconds shows 2\'15"', () {
      expect(N42DateUtils.formatVoiceDuration(const Duration(seconds: 135)), "2'15\"");
    });
  });

  // ─────────────────────────────────────────────────
  // N42DateUtils.shouldShowTimeSeparator
  // ─────────────────────────────────────────────────

  group('N42DateUtils.shouldShowTimeSeparator', () {
    test('null prev always shows separator', () {
      expect(N42DateUtils.shouldShowTimeSeparator(null, DateTime.now()), isTrue);
    });

    test('same timestamp (0 min diff) does NOT show separator', () {
      final now = DateTime.now();
      expect(N42DateUtils.shouldShowTimeSeparator(now, now), isFalse);
    });

    test('4 min diff does NOT show separator', () {
      final now = DateTime.now();
      final prev = now.subtract(const Duration(minutes: 4));
      expect(N42DateUtils.shouldShowTimeSeparator(prev, now), isFalse);
    });

    test('exactly 5 min diff shows separator', () {
      final now = DateTime.now();
      final prev = now.subtract(const Duration(minutes: 5));
      expect(N42DateUtils.shouldShowTimeSeparator(prev, now), isTrue);
    });

    test('10 min diff shows separator', () {
      final now = DateTime.now();
      final prev = now.subtract(const Duration(minutes: 10));
      expect(N42DateUtils.shouldShowTimeSeparator(prev, now), isTrue);
    });
  });

  // ─────────────────────────────────────────────────
  // N42DateUtils.isSameDay
  // ─────────────────────────────────────────────────

  group('N42DateUtils.isSameDay', () {
    test('same DateTime is same day', () {
      final now = DateTime.now();
      expect(N42DateUtils.isSameDay(now, now), isTrue);
    });

    test('different times on same calendar day are same day', () {
      final morning = DateTime(2024, 3, 15, 8, 0);
      final evening = DateTime(2024, 3, 15, 22, 30);
      expect(N42DateUtils.isSameDay(morning, evening), isTrue);
    });

    test('consecutive days are NOT same day', () {
      final today = DateTime(2024, 3, 15);
      final tomorrow = DateTime(2024, 3, 16);
      expect(N42DateUtils.isSameDay(today, tomorrow), isFalse);
    });

    test('same day in different months are NOT same day', () {
      final march = DateTime(2024, 3, 15);
      final april = DateTime(2024, 4, 15);
      expect(N42DateUtils.isSameDay(march, april), isFalse);
    });

    test('same day in different years are NOT same day', () {
      final y2023 = DateTime(2023, 3, 15);
      final y2024 = DateTime(2024, 3, 15);
      expect(N42DateUtils.isSameDay(y2023, y2024), isFalse);
    });
  });

  // ─────────────────────────────────────────────────
  // N42DateUtils.formatRelativeTime
  // ─────────────────────────────────────────────────

  group('N42DateUtils.formatRelativeTime', () {
    const en = DateLocaleStrings();

    test('< 60 seconds shows justNow', () {
      expect(N42DateUtils.formatRelativeTime(_secsAgo(30), en), 'Just now');
    });

    test('exactly 59 seconds shows justNow', () {
      expect(N42DateUtils.formatRelativeTime(_secsAgo(59), en), 'Just now');
    });

    test('2 minutes ago shows minutesAgo', () {
      final result = N42DateUtils.formatRelativeTime(_minsAgo(2), en);
      expect(result, contains('min'));
    });

    test('30 minutes ago shows minutesAgo', () {
      final result = N42DateUtils.formatRelativeTime(_minsAgo(30), en);
      expect(result, contains('min'));
    });

    test('2 hours ago shows hoursAgo', () {
      final result = N42DateUtils.formatRelativeTime(_hoursAgo(2), en);
      expect(result, contains('h ago'));
    });

    test('25 hours ago (1 day diff) shows yesterday', () {
      final result = N42DateUtils.formatRelativeTime(_daysAgo(1), en);
      expect(result, 'Yesterday');
    });

    test('3 days ago shows daysAgo', () {
      final result = N42DateUtils.formatRelativeTime(_daysAgo(3), en);
      expect(result, contains('d ago'));
    });

    test('Chinese locale shows Chinese strings', () {
      const zh = DateLocaleStrings.chinese;
      final result = N42DateUtils.formatRelativeTime(_secsAgo(10), zh);
      expect(result, '刚刚');
    });

    test('Chinese minutesAgo', () {
      const zh = DateLocaleStrings.chinese;
      final result = N42DateUtils.formatRelativeTime(_minsAgo(5), zh);
      expect(result, '5分钟前');
    });
  });

  // ─────────────────────────────────────────────────
  // N42DateUtils.formatLastSeen
  // ─────────────────────────────────────────────────

  group('N42DateUtils.formatLastSeen', () {
    const en = DateLocaleStrings();

    test('null lastSeen returns offline', () {
      expect(N42DateUtils.formatLastSeen(null, en), 'Offline');
    });

    test('< 5 minutes ago shows Online', () {
      expect(N42DateUtils.formatLastSeen(_minsAgo(2), en), 'Online');
    });

    test('exactly 4 min ago shows Online', () {
      expect(N42DateUtils.formatLastSeen(_minsAgo(4), en), 'Online');
    });

    test('5+ minutes ago shows minutesAgoOnline', () {
      final result = N42DateUtils.formatLastSeen(_minsAgo(10), en);
      expect(result, contains('min ago'));
    });

    test('1 hour ago shows hoursAgoOnline', () {
      final result = N42DateUtils.formatLastSeen(_hoursAgo(2), en);
      expect(result, contains('h ago'));
    });

    test('3 days ago shows daysAgoOnline', () {
      final result = N42DateUtils.formatLastSeen(_daysAgo(3), en);
      expect(result, contains('d ago'));
    });

    test('7+ days ago shows offline', () {
      expect(N42DateUtils.formatLastSeen(_daysAgo(10), en), 'Offline');
    });

    test('Chinese locale — < 5 min shows 在线', () {
      const zh = DateLocaleStrings.chinese;
      expect(N42DateUtils.formatLastSeen(_minsAgo(1), zh), '在线');
    });

    test('Chinese locale — 10 min shows 10分钟前在线', () {
      const zh = DateLocaleStrings.chinese;
      final result = N42DateUtils.formatLastSeen(_minsAgo(10), zh);
      expect(result, '10分钟前在线');
    });
  });

  // ─────────────────────────────────────────────────
  // N42DateUtils.formatMessageDetailTime
  // ─────────────────────────────────────────────────

  group('N42DateUtils.formatMessageDetailTime', () {
    test('formats as year/month/day HH:mm', () {
      const en = DateLocaleStrings();
      final dt = DateTime(2024, 3, 15, 14, 30);
      final result = N42DateUtils.formatMessageDetailTime(dt, en);
      expect(result, contains('2024'));
      expect(result, contains('14:30'));
    });

    test('Chinese format includes 年月日', () {
      const zh = DateLocaleStrings.chinese;
      final dt = DateTime(2024, 3, 15, 9, 5);
      final result = N42DateUtils.formatMessageDetailTime(dt, zh);
      expect(result, contains('2024年'));
      expect(result, contains('09:05'));
    });
  });
}
