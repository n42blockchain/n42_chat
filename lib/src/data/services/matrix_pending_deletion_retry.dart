import 'matrix_account_deletion_operation.dart';
import 'matrix_account_deletion_session.dart';
import 'matrix_pending_deletion_store.dart';

/// Retries only a still-live, originally confirmed operation. After restart or
/// account replacement there is no proof that a user-scoped cache belongs to
/// the deleted generation, so the entry remains pending.
class MatrixPendingDeletionRetry {
  const MatrixPendingDeletionRetry(this.journal);

  final MatrixPendingDeletionStore journal;

  Future<DeletionCleanupStatus> retry(
    MatrixPendingDeletionEntry entry, {
    IMatrixAccountDeletionSession? originalSession,
  }) async {
    final recorded = (await journal.list()).any(
      (candidate) =>
          candidate.userId == entry.userId &&
          candidate.homeserver == entry.homeserver &&
          candidate.deviceId == entry.deviceId,
    );
    if (!recorded) throw StateError('No matching pending Matrix cleanup');

    final receipt = originalSession?.confirmedDeletion;
    final generation = originalSession?.generation;
    if (originalSession == null ||
        !originalSession.isOriginalGeneration ||
        receipt == null ||
        receipt.userId != entry.userId ||
        receipt.homeserver != entry.homeserver ||
        generation == null ||
        generation.userId != entry.userId ||
        generation.homeserver != entry.homeserver ||
        generation.deviceId != entry.deviceId) {
      return DeletionCleanupStatus.deferredClientClear;
    }
    return originalSession.cleanupConfirmed();
  }
}
