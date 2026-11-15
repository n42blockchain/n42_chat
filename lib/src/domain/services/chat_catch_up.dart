import '../entities/message_entity.dart';

/// Operates on the caller's decrypted snapshot; never fetches history or keys.
enum CatchUpFilter { pinned, mentions, replies }

List<MessageEntity> catchUpMessages({
  required String roomId,
  required String? userId,
  required List<MessageEntity> messages,
  required List<MessageEntity> pinned,
  required CatchUpFilter filter,
}) {
  final ownIds = messages
      .where((m) => m.roomId == roomId && m.senderId == userId)
      .map((m) => m.id)
      .toSet();
  final seen = <String>{};
  final result = (filter == CatchUpFilter.pinned ? pinned : messages).where((
    m,
  ) {
    if (m.roomId != roomId ||
        m.type == MessageType.redacted ||
        m.isSelfDestructing ||
        !seen.add(m.id)) {
      return false;
    }
    if (filter == CatchUpFilter.pinned) return true;
    if (userId == null || userId.isEmpty || m.senderId == userId) return false;
    return switch (filter) {
      CatchUpFilter.mentions => m.mentionsRoom || m.mentionsUser(userId),
      // Display names in replyToSender are not reliable identity evidence.
      CatchUpFilter.replies => ownIds.contains(m.replyToId),
      CatchUpFilter.pinned => true,
    };
  }).toList();
  result.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  return result;
}
