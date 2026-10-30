import 'package:matrix/matrix.dart' as matrix;

import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_catch_up_repository.dart';

/// Walks server order to an exact read marker. No timestamp-based unread guess.
class MatrixUnreadAttention {
  static Future<UnreadAttention> scan(
    matrix.Room room,
    bool Function() isCurrent,
  ) async {
    final marker = room.fullyRead;
    final head = room.lastEvent?.eventId;
    final user = room.client.userID;
    bool current() =>
        isCurrent() &&
        room.fullyRead == marker &&
        room.lastEvent?.eventId == head;
    if (user == null || !current()) return const UnreadAttention();
    final mentions = <MessageEntity>[];
    final replies = <MessageEntity>[];
    final seen = <String>{};
    final tokens = <String>{};
    final originals = <String, matrix.Event?>{};
    String? from;
    var decoded = true;
    while (current()) {
      final page = await room.client.getRoomEvents(
        room.id,
        matrix.Direction.b,
        from: from,
        limit: 100,
      );
      if (!current()) return const UnreadAttention();
      for (final raw in page.chunk) {
        if (raw.eventId == marker) {
          return UnreadAttention(
            mentions: mentions,
            replies: replies,
            complete: decoded && current(),
          );
        }
        if (!seen.add(raw.eventId)) continue;
        var event = matrix.Event.fromMatrixEvent(raw, room);
        if (event.type == matrix.EventTypes.Encrypted) {
          event =
              await room.client.encryption?.decryptRoomEvent(event) ?? event;
          if (!current()) return const UnreadAttention();
          if (event.type == matrix.EventTypes.Encrypted) {
            decoded = false;
            continue;
          }
        }
        if (event.senderId == user ||
            event.redacted ||
            event.type != matrix.EventTypes.Message ||
            event.content.containsKey('n42.self_destruct')) {
          continue;
        }
        final relation = event.content['m.relates_to'];
        if (relation is Map && relation['rel_type'] == 'm.replace') continue;
        final entity = attentionMessage(event);
        final mention = event.content['m.mentions'];
        if (mention is Map &&
            (mention['room'] == true ||
                (mention['user_ids'] is List &&
                    (mention['user_ids'] as List).contains(user)))) {
          mentions.add(entity);
        }
        final reply = relation is Map ? relation['m.in_reply_to'] : null;
        final originalId = reply is Map ? reply['event_id'] : null;
        // Thread fallback relations are not direct replies.
        if (originalId is String &&
            !(relation is Map && relation['is_falling_back'] == true)) {
          if (!originals.containsKey(originalId)) {
            originals[originalId] = await room.getEventById(originalId);
          }
          if (!current()) return const UnreadAttention();
          final original = originals[originalId];
          if (original == null) {
            decoded = false;
          } else if (original.senderId == user && original.room.id == room.id) {
            replies.add(entity);
          }
        }
      }
      if (page.end == null) {
        return UnreadAttention(
          mentions: mentions,
          replies: replies,
          complete: marker.isEmpty && decoded && current(),
        );
      }
      if (!tokens.add(page.end!)) {
        return UnreadAttention(mentions: mentions, replies: replies);
      }
      from = page.end;
    }
    return const UnreadAttention();
  }
}

MessageEntity attentionMessage(matrix.Event event) => MessageEntity(
  id: event.eventId,
  roomId: event.room.id,
  senderId: event.senderId,
  senderName: event.senderId,
  content: event.content['body'] is String
      ? event.content['body'] as String
      : '',
  type: MessageType.text,
  timestamp: event.originServerTs,
);
