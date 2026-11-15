/// A non-blocking lease shared by scheduled senders and cancellation pages in
/// this isolate. It spans persistence and transport awaits, not just a BLoC.
/// Cross-isolate/process delivery still requires durable coordination.
class ScheduledDraftOperation {
  static final Set<(String, String, String)> _active = {};
  static final Set<String> _accountRecovery = {};
  // Retain receipts across controller disposal and lease release. Only a
  // confirmed local cleanup can discard them. This is not restart durability.
  static final Map<(String, String, String), String> _receipts = {};

  static String? acceptedReceipt({
    required String ownerUserId,
    required String roomId,
    required String messageId,
  }) => _receipts[(ownerUserId, roomId, messageId)];

  String? get receipt => _receipts[_key];

  void rememberAcceptance(String eventId) {
    if (_released || eventId.isEmpty) throw StateError('Invalid receipt lease');
    _receipts[_key] = eventId;
  }

  void confirmCleanup() {
    if (_released) throw StateError('Released receipt lease');
    _receipts.remove(_key);
  }

  final (String, String, String) _key;
  bool _released = false;

  ScheduledDraftOperation._(this._key);

  /// Recovery excludes active transports/cancellations across this account.
  /// Existing in-memory receipts are retained, never treated as cancelled.
  static ScheduledAccountRecovery? tryAcquireRecovery(String ownerUserId) {
    if (_accountRecovery.contains(ownerUserId) ||
        _active.any((key) => key.$1 == ownerUserId)) {
      return null;
    }
    _accountRecovery.add(ownerUserId);
    return ScheduledAccountRecovery._(
      () => _accountRecovery.remove(ownerUserId),
    );
  }

  static ScheduledDraftOperation? tryAcquire({
    required String ownerUserId,
    required String roomId,
    required String messageId,
  }) {
    if (_accountRecovery.contains(ownerUserId)) return null;
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

/// Same-isolate account-wide exclusion for explicit queue recovery.
class ScheduledAccountRecovery {
  final void Function() _release;
  bool _released = false;
  ScheduledAccountRecovery._(this._release);

  void release() {
    if (_released) return;
    _released = true;
    _release();
  }
}
