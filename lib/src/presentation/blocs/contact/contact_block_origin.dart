import 'package:matrix/matrix.dart' as matrix;

import '../../../core/di/injection.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/repositories/auth_repository.dart';

/// The account that opened a block control, including its login generation.
class ContactBlockOrigin {
  ContactBlockOrigin._(
    this.manager,
    this.lifecycle,
    this.client,
    this.generation,
  ) : userId = client.userID!,
      homeserver = client.homeserver!,
      token = client.accessToken!,
      deviceId = client.deviceID;

  final MatrixClientManager manager;
  final IAccountBoundDeletionLifecycle lifecycle;
  final matrix.Client client;
  final AuthSessionInvalidation generation;
  final String userId;
  final Uri homeserver;
  final String token;
  final String? deviceId;

  static ContactBlockOrigin? capture() {
    if (!getIt.isRegistered<MatrixClientManager>() ||
        !getIt.isRegistered<IAuthRepository>()) {
      return null;
    }
    final manager = getIt<MatrixClientManager>();
    final auth = getIt<IAuthRepository>();
    if (auth is! IAccountBoundDeletionLifecycle) return null;
    final lifecycle = auth as IAccountBoundDeletionLifecycle;
    final client = manager.client;
    final generation = lifecycle.currentAccountGeneration;
    if (client == null ||
        generation == null ||
        !client.isLogged() ||
        client.userID == null ||
        client.homeserver == null ||
        client.accessToken == null ||
        !generation.isCurrent ||
        !generation.matchesClient(client) ||
        generation.userId != client.userID ||
        generation.homeserver != client.homeserver ||
        generation.deviceId != client.deviceID) {
      return null;
    }
    return ContactBlockOrigin._(manager, lifecycle, client, generation);
  }

  bool get isCurrent =>
      identical(lifecycle.currentAccountGeneration, generation) &&
      generation.isCurrent &&
      generation.matchesClient(client) &&
      identical(manager.client, client) &&
      client.isLogged() &&
      client.userID == userId &&
      client.homeserver == homeserver &&
      client.accessToken == token &&
      client.deviceID == deviceId;
}
