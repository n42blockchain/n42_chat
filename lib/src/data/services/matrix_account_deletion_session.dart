import '../../core/encryption/account_session_index.dart';
import '../../core/encryption/local_room_key_store.dart';
import '../../core/utils/matrix_deletion_uia_coordinator.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/secure_storage_datasource.dart';
import '../datasources/matrix/matrix_client_manager.dart';
import 'matrix_account_deletion_operation.dart';
import 'matrix_pending_deletion_store.dart';

abstract interface class IMatrixAccountDeletionSession {
  AuthSessionInvalidation get generation;
  bool get isOriginalGeneration;
  String get userId;
  Uri get homeserver;
  bool get erase;
  DeletionUiaStatus get status;
  DeletionUiaReceipt? get confirmedDeletion;
  List<String> get nextStages;
  String? get session;

  Future<DeletionUiaStatus> start();
  Future<DeletionUiaStatus> submitPassword(String password);
  Uri fallbackUri(String stage);
  Future<DeletionUiaStatus> retryAfterExternalFallback({
    required String stage,
    required String session,
  });
  Future<DeletionCleanupStatus> cleanupConfirmed();
  void cancel();
}

/// One frozen Matrix deletion operation and its server UIA challenge.
/// The journal is written only after the coordinator has a server receipt.
class MatrixAccountDeletionSession implements IMatrixAccountDeletionSession {
  MatrixAccountDeletionSession({
    required this.operation,
    required this.generation,
    required this.journal,
  }) : _coordinator = MatrixDeletionUiaCoordinator(
         userId: operation.userId,
         homeserver: operation.homeserver,
         isCurrentAccount: () =>
             operation.isCurrentAccount ||
             (operation.serverConfirmed && operation.isSameAccountGeneration),
         request: operation.request,
       );

  factory MatrixAccountDeletionSession.capture({
    required IAccountBoundDeletionLifecycle lifecycle,
    required MatrixClientManager manager,
    required SecureStorageDataSource storage,
    required LocalRoomKeyStore roomKeys,
    required AccountSessionIndex accountSessions,
    required MatrixPendingDeletionStore journal,
    required bool erase,
  }) {
    final generation = lifecycle.currentAccountGeneration;
    if (generation == null) {
      throw StateError('No stable Matrix account generation to deactivate');
    }
    final operation = MatrixAccountDeletionOperation.capture(
      manager: manager,
      storage: storage,
      roomKeys: roomKeys,
      accountSessions: accountSessions,
      erase: erase,
      generationIsCurrent: () => generation.isCurrent,
      generationIsSame: () => generation.isSameGeneration,
      runBoundRequest: (request) =>
          lifecycle.runAccountDeletionRequest(generation, request),
    );
    if (!generation.matchesClient(operation.client) ||
        generation.userId != operation.userId ||
        generation.homeserver != operation.homeserver ||
        generation.deviceId != operation.deviceId) {
      throw StateError('Matrix account generation does not match client');
    }
    return MatrixAccountDeletionSession(
      operation: operation,
      generation: generation,
      journal: journal,
    );
  }

  final MatrixAccountDeletionOperation operation;
  @override
  final AuthSessionInvalidation generation;
  final MatrixPendingDeletionStore journal;
  final MatrixDeletionUiaCoordinator _coordinator;

  @override
  bool get isOriginalGeneration => generation.isSameGeneration;
  @override
  String get userId => operation.userId;
  @override
  Uri get homeserver => operation.homeserver;
  @override
  bool get erase => operation.erase;
  @override
  DeletionUiaStatus get status => _coordinator.status;
  @override
  DeletionUiaReceipt? get confirmedDeletion => _coordinator.confirmedDeletion;
  @override
  List<String> get nextStages => _coordinator.nextStages;
  @override
  String? get session => _coordinator.session;

  @override
  Future<DeletionUiaStatus> start() => _coordinator.start();

  @override
  Future<DeletionUiaStatus> submitPassword(String password) =>
      _coordinator.submitPassword(password);

  @override
  Uri fallbackUri(String stage) => _coordinator.fallbackUri(stage);

  @override
  Future<DeletionUiaStatus> retryAfterExternalFallback({
    required String stage,
    required String session,
  }) => _coordinator.retryAfterExternalFallback(stage: stage, session: session);

  @override
  Future<DeletionCleanupStatus> cleanupConfirmed() async {
    final receipt = _coordinator.confirmedDeletion;
    if (receipt == null) {
      throw StateError('No confirmed Matrix deletion to clean up');
    }
    await journal.markPending(
      userId: operation.userId,
      homeserver: operation.homeserver,
      deviceId: operation.deviceId,
    );
    final result = await operation.cleanup(receipt);
    if (result == DeletionCleanupStatus.complete) {
      await journal.complete(
        userId: operation.userId,
        homeserver: operation.homeserver,
        deviceId: operation.deviceId,
      );
    }
    return result;
  }

  @override
  void cancel() => _coordinator.cancel();
}
