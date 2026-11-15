import '../../domain/entities/account_action_origin.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/matrix/matrix_client_manager.dart';

AccountActionOrigin? captureAccountAction(
  MatrixClientManager manager,
  IAuthRepository auth,
) {
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
  final user = client.userID,
      server = client.homeserver,
      token = client.accessToken,
      device = client.deviceID;
  return AccountActionOrigin(
    manager,
    () =>
        identical(lifecycle.currentAccountGeneration, generation) &&
        generation.isCurrent &&
        generation.matchesClient(client) &&
        identical(manager.client, client) &&
        client.isLogged() &&
        client.userID == user &&
        client.homeserver == server &&
        client.accessToken == token &&
        client.deviceID == device,
  );
}
