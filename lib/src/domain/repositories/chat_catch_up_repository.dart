import '../entities/message_entity.dart';

class UnreadAttention {
  final List<MessageEntity> mentions;
  final List<MessageEntity> replies;
  final bool complete;
  const UnreadAttention({
    this.mentions = const [],
    this.replies = const [],
    this.complete = false,
  });
}

class HistoryShareDraft {
  final String id, roomId, targetRoomId, recipient, fingerprint;
  final List<MessageEntity> messages;
  final DateTime expiresAt;
  const HistoryShareDraft({
    required this.id,
    required this.roomId,
    required this.targetRoomId,
    required this.recipient,
    required this.fingerprint,
    required this.messages,
    required this.expiresAt,
  });
}

enum HistoryShareStatus {
  prepared,
  auditPending,
  auditSent,
  contentPending,
  contentSent,
  completionPending,
  completed,
}

abstract interface class IChatCatchUpRepository {
  Future<List<HistoryShareRecovery>> pendingHistory(String roomId);
  Future<HistoryShareStatus> reconcileBatch(HistoryShareRecovery record);
  Future<UnreadAttention> unreadAttention(
    String roomId, {
    bool Function()? isCancelled,
  });
  Future<void> setHistorySharing(
    String roomId, {
    required bool enabled,
    int maxMessages = 20,
    int maxAgeHours = 168,
  });
  Future<HistoryShareDraft> previewHistory({
    required String roomId,
    required String targetRoomId,
    required String recipient,
    required List<String> eventIds,
  });
  Future<HistoryShareStatus> shareHistory(HistoryShareDraft draft);
  Future<HistoryShareStatus> reconcileHistory(HistoryShareDraft draft);
}

class HistoryShareRecovery {
  final String id, roomId, targetRoomId, recipient;
  final HistoryShareStatus status;
  const HistoryShareRecovery({
    required this.id,
    required this.roomId,
    required this.targetRoomId,
    required this.recipient,
    required this.status,
  });
}
