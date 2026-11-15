import '../entities/message_entity.dart';

/// A Matrix thread page retains its opaque continuation even when it is empty.
class ThreadMessagePage {
  final List<MessageEntity> messages;
  final String? nextBatch;
  const ThreadMessagePage({this.messages = const [], this.nextBatch});
  bool get hasMore => nextBatch != null;
}

/// Optional capability for hosts retaining the legacy list-only repository API.
abstract interface class IThreadPaginationRepository {
  Future<ThreadMessagePage> getThreadMessagePage(
    String roomId,
    String threadRootEventId, {
    int limit = 50,
    String? fromToken,
  });
}

/// Revalidates retained thread history against the local account/clear boundary.
abstract interface class IThreadHistoryVisibilityRepository {
  bool Function() captureThreadSession();
  Future<List<MessageEntity>> filterThreadHistory(
    String roomId,
    List<MessageEntity> messages,
  );
}

abstract interface class IThreadHistoryChangesRepository {
  Stream<void> watchThreadHistoryChanges(String roomId);
}
