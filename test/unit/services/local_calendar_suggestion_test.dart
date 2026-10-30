import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/services/local_calendar_suggestion.dart';

MessageEntity message(
  String text, {
  MessageType type = MessageType.text,
  int? ttl,
}) => MessageEntity(
  id: 'id',
  roomId: 'room',
  senderId: 'peer',
  senderName: 'Peer',
  content: text,
  type: type,
  timestamp: DateTime.utc(2026),
  selfDestructAfter: ttl,
);
void main() {
  test('parses one explicit time zone to the correct instant', () {
    expect(
      localCalendarSuggestion(message('Meet 2026-11-01T10:30-05:00.')),
      DateTime.utc(2026, 11, 1, 15, 30),
    );
    expect(
      localCalendarSuggestion(message('2028-02-29T10:30:45Z')),
      DateTime.utc(2028, 2, 29, 10, 30, 45),
    );
  });
  test('rejects ambiguity, rollover, invalid zones and relative dates', () {
    for (final text in [
      'tomorrow at 3',
      '2026-11-01T10:30',
      '2026-02-29T10:30Z',
      '2026-13-01T10:30Z',
      '2026-11-01T24:30Z',
      '2026-11-01T10:60Z',
      '2026-11-01T10:30+14:01',
      '2026-11-01T10:30+00:99',
      '2026-11-01T10:30Z to 2026-11-01T11:30Z',
      'x2026-11-01T10:30Z',
    ]) {
      expect(localCalendarSuggestion(message(text)), isNull, reason: text);
    }
  });
  test(
    'does not export ephemeral, redacted, payment or oversized messages',
    () {
      const text = '2026-11-01T10:30Z';
      expect(localCalendarSuggestion(message(text, ttl: 10)), isNull);
      for (final type in [
        MessageType.redacted,
        MessageType.transfer,
        MessageType.paymentRequest,
      ]) {
        expect(localCalendarSuggestion(message(text, type: type)), isNull);
      }
      expect(localCalendarSuggestion(message('$text${'x' * 4096}')), isNull);
    },
  );
}
