import 'package:matrix/matrix.dart';

import '../../core/encryption/account_session_index.dart';
import '../../core/encryption/local_room_key_store.dart';
import '../../core/utils/matrix_deletion_uia_coordinator.dart';
import '../datasources/local/secure_storage_datasource.dart';
import '../datasources/matrix/matrix_client_manager.dart';

enum DeletionCleanupStatus { complete, deferredClientClear }

/// Retains the confirmed account identity when device-local cleanup fails.
class MatrixDeletionCleanupException implements Exception {
  final DeletionUiaReceipt receipt;
  final Object cause;

  const MatrixDeletionCleanupException(this.receipt, this.cause);

  @override
  String toString() => 'Matrix account was deactivated; local cleanup failed';
}

/// One account's legacy Matrix deactivation and subsequent local cleanup.
///
/// The request is always sent through the captured client. SDK/session cleanup
/// never calls ordinary logout (which preserves room keys) or a global purge.
class MatrixAccountDeletionOperation {
  MatrixAccountDeletionOperation._(
    this.client,
    this.userId,
    this.homeserver,
    this.deviceId,
    this.erase,
    this.generationIsCurrent,
    this._manager,
    this._storage,
    this._roomKeys,
    this._accountSessions,
  );

  factory MatrixAccountDeletionOperation.capture({
    required MatrixClientManager manager,
    required SecureStorageDataSource storage,
    required LocalRoomKeyStore roomKeys,
    required AccountSessionIndex accountSessions,
    required bool erase,
    required bool Function() generationIsCurrent,
  }) {
    final client = manager.client;
    final userId = client?.userID;
    final homeserver = client?.homeserver;
    final deviceId = client?.deviceID;
    if (client == null ||
        !manager.isLoggedIn ||
        !client.isLogged() ||
        userId == null ||
        userId.isEmpty ||
        homeserver == null ||
        deviceId == null ||
        deviceId.isEmpty ||
        !generationIsCurrent()) {
      throw StateError('No stable Matrix account to deactivate');
    }
    return MatrixAccountDeletionOperation._(
      client,
      userId,
      homeserver,
      deviceId,
      erase,
      generationIsCurrent,
      manager,
      storage,
      roomKeys,
      accountSessions,
    );
  }

  final Client client;
  final String userId;
  final Uri homeserver;
  final String deviceId;
  final bool erase;
  final bool Function() generationIsCurrent;
  final MatrixClientManager _manager;
  final SecureStorageDataSource _storage;
  final LocalRoomKeyStore _roomKeys;
  final AccountSessionIndex _accountSessions;

  bool serverConfirmed = false;
  bool _requestInProgress = false;
  bool _cleanupInProgress = false;
  bool _clientCleared = false;

  bool get isCurrentAccount =>
      generationIsCurrent() &&
      identical(_manager.client, client) &&
      client.userID == userId &&
      client.homeserver == homeserver &&
      client.deviceID == deviceId;

  Future<void> request(AuthenticationData? auth) async {
    if (serverConfirmed || _requestInProgress || !isCurrentAccount) {
      throw StateError('Matrix deletion account changed or request is busy');
    }
    _requestInProgress = true;
    try {
      await client.deactivateAccount(auth: auth, erase: erase);
      // A successful server response remains true even if the active account
      // switches or the user dismisses the UI while this Future is pending.
      serverConfirmed = true;
    } finally {
      _requestInProgress = false;
    }
  }

  Future<DeletionCleanupStatus> cleanup(DeletionUiaReceipt receipt) async {
    if (!serverConfirmed ||
        receipt.userId != userId ||
        receipt.homeserver != homeserver) {
      throw StateError('No matching confirmed Matrix deletion');
    }
    if (_cleanupInProgress) throw StateError('Matrix cleanup already running');
    _cleanupInProgress = true;
    try {
      // SDK clear deletes this account's database without preserving inbound
      // keys or making a second server request. Never clear the current B SDK.
      if (!_clientCleared && isCurrentAccount) {
        await client.clear(reason: SessionClearReason.logout);
        _clientCleared = true;
      }
      await _roomKeys.deleteForIdentity(homeserver, userId);
      // Keep the A database mapping while its SDK data still needs a scoped
      // clear; otherwise a later retry loses the only path to that database.
      if (_clientCleared) {
        await _accountSessions.forget(homeserver, userId, deviceId);
      }
      await _storage.removeAccountIfMatches(userId, homeserver);
      await _storage.clearSessionIfMatches(userId, homeserver);
      return _clientCleared
          ? DeletionCleanupStatus.complete
          : DeletionCleanupStatus.deferredClientClear;
    } catch (error) {
      throw MatrixDeletionCleanupException(receipt, error);
    } finally {
      _cleanupInProgress = false;
    }
  }
}
