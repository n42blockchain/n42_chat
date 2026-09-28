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
    this.generationIsSame,
    this._runBoundRequest,
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
    bool Function()? generationIsSame,
    Future<void> Function(Future<void> Function() request)? runBoundRequest,
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
        (deviceId?.isEmpty ?? false) ||
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
      generationIsSame ?? generationIsCurrent,
      runBoundRequest,
      manager,
      storage,
      roomKeys,
      accountSessions,
    );
  }

  final Client client;
  final String userId;
  final Uri homeserver;
  final String? deviceId;
  final bool erase;
  final bool Function() generationIsCurrent;
  final bool Function() generationIsSame;
  final Future<void> Function(Future<void> Function() request)?
  _runBoundRequest;
  final MatrixClientManager _manager;
  final SecureStorageDataSource _storage;
  final LocalRoomKeyStore _roomKeys;
  final AccountSessionIndex _accountSessions;

  bool serverConfirmed = false;
  bool _requestInProgress = false;
  bool _cleanupInProgress = false;
  bool _clientCleared = false;

  bool get _matchesCapturedClient =>
      identical(_manager.client, client) &&
      client.userID == userId &&
      client.homeserver == homeserver &&
      client.deviceID == deviceId;

  bool get isCurrentAccount => generationIsCurrent() && _matchesCapturedClient;

  bool get isSameAccountGeneration =>
      generationIsSame() && _matchesCapturedClient;

  // Client.clear removes the SDK identity fields, so the captured client's
  // object identity and the auth generation are the stable cleanup boundary.
  bool get _ownsOriginalGeneration =>
      generationIsSame() && identical(_manager.client, client);

  Future<void> request(AuthenticationData? auth) async {
    if (serverConfirmed || _requestInProgress || !isCurrentAccount) {
      throw StateError('Matrix deletion account changed or request is busy');
    }
    _requestInProgress = true;
    var acceptingCallback = true;
    Future<void>? launchedRequest;
    try {
      Future<void> sendCapturedRequest() {
        if (!acceptingCallback || launchedRequest != null) {
          return Future<void>.error(
            StateError('Matrix deletion request callback is unavailable'),
          );
        }
        final request = Future<void>.sync(() async {
          await client.deactivateAccount(auth: auth, erase: erase);
          // The actual server response remains authoritative even if the
          // wrapper returns early or the active account switches.
          serverConfirmed = true;
        });
        launchedRequest = request;
        // An early-returning wrapper may not attach its own error listener.
        request.ignore();
        return request;
      }

      final runBoundRequest = _runBoundRequest;
      Object? wrapperError;
      StackTrace? wrapperStack;
      try {
        if (runBoundRequest == null) {
          await sendCapturedRequest();
        } else {
          await runBoundRequest(sendCapturedRequest);
        }
      } catch (error, stack) {
        wrapperError = error;
        wrapperStack = stack;
      }
      acceptingCallback = false;
      final request = launchedRequest;
      if (request == null) {
        if (wrapperError != null) {
          Error.throwWithStackTrace(wrapperError, wrapperStack!);
        }
        throw StateError('Matrix deletion request was not sent');
      }
      // Keep the operation busy until the real request settles. A server
      // failure wins over a wrapper's unrelated failure; a server success
      // cannot be rolled back by local wrapper work.
      await request;
    } finally {
      acceptingCallback = false;
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
      // Shared local records cannot be attributed to an old generation once
      // another login has begun, even if the current account is B again.
      if (!_ownsOriginalGeneration) {
        return DeletionCleanupStatus.deferredClientClear;
      }
      // Capture the old mapping before SDK clear erases its device identity.
      // A later mapping for this device must not be forgotten.
      final databaseName = deviceId == null
          ? null
          : await _accountSessions.lookup(homeserver, userId, deviceId!);
      if (!_ownsOriginalGeneration) {
        return DeletionCleanupStatus.deferredClientClear;
      }
      // SDK clear deletes this account's database without preserving inbound
      // keys or making a second server request. Never clear the current B SDK.
      if (!_clientCleared) {
        await client.clear(reason: SessionClearReason.logout);
        _clientCleared = true;
      }
      if (!_ownsOriginalGeneration) {
        return DeletionCleanupStatus.deferredClientClear;
      }
      await _roomKeys.deleteForIdentity(
        homeserver,
        userId,
        canDelete: () => _ownsOriginalGeneration,
      );
      if (!_ownsOriginalGeneration) {
        return DeletionCleanupStatus.deferredClientClear;
      }
      // Keep the A database mapping while its SDK data still needs a scoped
      // clear; otherwise a later retry loses the only path to that database.
      if (databaseName != null && deviceId != null) {
        await _accountSessions.forget(
          homeserver,
          userId,
          deviceId!,
          expectedDatabaseName: databaseName,
          canForget: () => _ownsOriginalGeneration,
        );
      }
      if (!_ownsOriginalGeneration) {
        return DeletionCleanupStatus.deferredClientClear;
      }
      await _storage.removeAccountIfMatches(
        userId,
        homeserver,
        canDelete: () => _ownsOriginalGeneration,
      );
      if (!_ownsOriginalGeneration) {
        return DeletionCleanupStatus.deferredClientClear;
      }
      await _storage.clearSessionIfMatches(
        userId,
        homeserver,
        canDelete: () => _ownsOriginalGeneration,
      );
      if (!_ownsOriginalGeneration) {
        return DeletionCleanupStatus.deferredClientClear;
      }
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
