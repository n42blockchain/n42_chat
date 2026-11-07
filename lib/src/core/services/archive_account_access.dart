import '../../data/datasources/local/archive_database.dart';
import '../../data/datasources/matrix/matrix_client_manager.dart';

/// Captures a database and the exact session allowed to use its results.
class ArchiveAccountLease {
  final ArchiveDatabase database;
  final String storageId;
  final String userId;
  final void Function() ensureCurrent;

  const ArchiveAccountLease({
    required this.database,
    required this.storageId,
    required this.userId,
    required this.ensureCurrent,
  });
}

typedef ArchiveAccountOpener = Future<ArchiveDatabase> Function(
  String userId,
  Uri homeserver,
);

/// Resolves only explicitly owned archives; never adopts the legacy archive.db.
class ArchiveAccountAccess {
  final MatrixClientManager _manager;
  final ArchiveAccountOpener _open;

  ArchiveAccountAccess({
    required MatrixClientManager clientManager,
    ArchiveAccountOpener? open,
  }) : _manager = clientManager,
       _open =
           open ??
           ((user, server) =>
               ArchiveDatabase.getForAccount(userId: user, homeserver: server));

  Future<ArchiveAccountLease> capture() async {
    final client = _manager.client;
    final user = client?.userID;
    final server = client?.homeserver;
    final token = client?.accessToken;
    final device = client?.deviceID;
    if (client == null ||
        user == null ||
        server == null ||
        token == null ||
        token.isEmpty ||
        device == null ||
        device.isEmpty) {
      throw StateError('An authenticated archive session is required');
    }
    final storageId = ArchiveDatabase.accountStorageId(
      userId: user,
      homeserver: server,
    );
    void ensureCurrent() {
      if (!identical(_manager.client, client) ||
          client.userID != user ||
          client.homeserver != server ||
          client.accessToken != token ||
          client.deviceID != device) {
        throw StateError('Archive account session changed');
      }
    }

    final database = await _open(user, server);
    ensureCurrent();
    return ArchiveAccountLease(
      database: database,
      storageId: storageId,
      userId: user,
      ensureCurrent: ensureCurrent,
    );
  }
}
