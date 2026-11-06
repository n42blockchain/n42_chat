/// Explicitly reviewed text for an existing room's composer, not a send event.
/// Attachments, mentions, timers and previous delivery state are never copied.
class RecoveredComposerText {
  final String ownerUserId;
  final String roomId;
  final String text;
  const RecoveredComposerText({
    required this.ownerUserId,
    required this.roomId,
    required this.text,
  });
}
