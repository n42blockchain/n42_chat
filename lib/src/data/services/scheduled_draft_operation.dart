/// A non-blocking lease shared by scheduled senders and cancellation pages in
/// this isolate. It spans persistence and transport awaits, not just a BLoC.
/// Cross-isolate/process delivery still requires durable coordination.
class ScheduledDraftOperation {
  static final Set<(String, String, String)> _active = {};
  final (String, String, String) _key;
  bool _released = false;

  ScheduledDraftOperation._(this._key);

  static ScheduledDraftOperation? tryAcquire({
    required String ownerUserId,
    required String roomId,
    required String messageId,
  }) {
    final key = (ownerUserId, roomId, messageId);
    if (!_active.add(key)) return null;
    return ScheduledDraftOperation._(key);
  }

  void release() {
    if (_released) return;
    _released = true;
    _active.remove(_key);
  }
}
