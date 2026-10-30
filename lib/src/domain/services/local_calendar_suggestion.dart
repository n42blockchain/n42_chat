import '../entities/message_entity.dart';

/// Deliberately narrow local rule: one explicit ISO timestamp with a time zone.
/// No network, natural-language date guessing, contacts, or wallet capabilities.
DateTime? localCalendarSuggestion(MessageEntity message) {
  if (message.type != MessageType.text ||
      message.isSelfDestructing ||
      message.content.length > 4096) {
    return null;
  }
  final matches = RegExp(
    r'(?<![\w/])([0-9]{4})-([0-9]{2})-([0-9]{2})T([0-9]{2}):([0-9]{2})(?::([0-9]{2}))?(Z|[+-][0-9]{2}:[0-9]{2})(?![\w:])',
  ).allMatches(message.content).toList();
  if (matches.length != 1) return null;
  final m = matches.single;
  final year = int.parse(m[1]!);
  final month = int.parse(m[2]!);
  final day = int.parse(m[3]!);
  final hour = int.parse(m[4]!);
  final minute = int.parse(m[5]!);
  final second = int.parse(m[6] ?? '0');
  final date = DateTime.utc(year, month, day);
  if (year < 1970 ||
      date.year != year ||
      date.month != month ||
      date.day != day ||
      hour > 23 ||
      minute > 59 ||
      second > 59) {
    return null;
  }
  final zone = m[7]!;
  if (zone != 'Z') {
    final h = int.parse(zone.substring(1, 3));
    final min = int.parse(zone.substring(4));
    if (h > 14 || min > 59 || (h == 14 && min != 0)) return null;
  }
  return DateTime.tryParse(m[0]!);
}
