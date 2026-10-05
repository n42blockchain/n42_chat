import 'package:matrix/matrix.dart';

/// Returns an OAuth account-management link or null only when the server
/// explicitly lacks the OAuth metadata API for a legacy Matrix session.
/// Opening the link never confirms deactivation or permits local cleanup.
class MatrixDeletionAccountManagement {
  const MatrixDeletionAccountManagement();

  Future<Uri?> resolve(Client client) async {
    final stored = await client.database.getClient(client.clientName);
    final oidcClientId = stored?['oidc_client_id'];
    if (oidcClientId != null &&
        (oidcClientId is! String || oidcClientId.isEmpty)) {
      throw StateError('Invalid Matrix native OIDC session metadata');
    }
    final nativeOidc = oidcClientId != null;
    if (!nativeOidc) return null;

    GetAuthMetadataResponse metadata;
    try {
      metadata = await client.getAuthMetadata(
        cacheLifetime: Duration.zero,
        throwOnUpdateFailure: true,
      );
    } on MatrixException catch (error) {
      if (error.error == MatrixError.M_UNRECOGNIZED) {
        throw StateError('Native Matrix OIDC account management unavailable');
      }
      rethrow;
    }

    final uri = metadata.accountManagementUri;
    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty) {
      throw StateError('Matrix account management URL unavailable');
    }
    final actions = metadata.accountManagementActionsSupported;
    if (actions?.contains(
          AccountManagementActionsSupported.orgMatrixAccountDeactivate,
        ) !=
        true) {
      return uri;
    }
    return uri.replace(
      queryParameters: {
        ...uri.queryParameters,
        'action':
            AccountManagementActionsSupported.orgMatrixAccountDeactivate.name,
      },
    );
  }
}
