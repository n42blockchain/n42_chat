import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/services/matrix_deletion_account_management.dart';

class _Client extends Mock implements Client {}

class _Database extends Mock implements DatabaseApi {}

GetAuthMetadataResponse metadata({
  Uri? management,
  List<AccountManagementActionsSupported>? actions,
}) => GetAuthMetadataResponse(
  accountManagementUri: management,
  accountManagementActionsSupported: actions,
  authorizationEndpoint: Uri.parse('https://auth.test/authorize'),
  codeChallengeMethodsSupported: ['S256'],
  grantTypesSupported: ['authorization_code'],
  issuer: Uri.parse('https://auth.test'),
  registrationEndpoint: Uri.parse('https://auth.test/register'),
  responseModesSupported: ['query'],
  responseTypesSupported: ['code'],
  revocationEndpoint: Uri.parse('https://auth.test/revoke'),
  tokenEndpoint: Uri.parse('https://auth.test/token'),
);

void main() {
  late _Client client;
  late _Database database;
  setUp(() {
    client = _Client();
    database = _Database();
    when(() => client.clientName).thenReturn('N42Chat_A');
    when(() => client.database).thenReturn(database);
    when(
      () => database.getClient('N42Chat_A'),
    ).thenAnswer((_) async => {'oidc_client_id': null});
  });

  test('legacy Matrix login with absent OAuth API uses UIA deletion', () async {
    when(
      () => client.getAuthMetadata(
        cacheLifetime: Duration.zero,
        throwOnUpdateFailure: true,
      ),
    ).thenThrow(MatrixException.fromJson({'errcode': 'M_UNRECOGNIZED'}));
    expect(
      await const MatrixDeletionAccountManagement().resolve(client),
      isNull,
    );
    verifyNever(
      () => client.getAuthMetadata(
        cacheLifetime: Duration.zero,
        throwOnUpdateFailure: true,
      ),
    );
  });

  test(
    'legacy Matrix session stays on UIA when OAuth metadata exists',
    () async {
      when(
        () => client.getAuthMetadata(
          cacheLifetime: Duration.zero,
          throwOnUpdateFailure: true,
        ),
      ).thenAnswer(
        (_) async =>
            metadata(management: Uri.parse('https://auth.test/manage')),
      );
      expect(
        await const MatrixDeletionAccountManagement().resolve(client),
        isNull,
      );
      verifyNever(
        () => client.getAuthMetadata(
          cacheLifetime: Duration.zero,
          throwOnUpdateFailure: true,
        ),
      );
    },
  );

  test(
    'native OIDC cannot fall through to legacy deletion on missing metadata',
    () async {
      when(
        () => database.getClient('N42Chat_A'),
      ).thenAnswer((_) async => {'oidc_client_id': 'native-client'});
      when(
        () => client.getAuthMetadata(
          cacheLifetime: Duration.zero,
          throwOnUpdateFailure: true,
        ),
      ).thenThrow(MatrixException.fromJson({'errcode': 'M_UNRECOGNIZED'}));
      await expectLater(
        const MatrixDeletionAccountManagement().resolve(client),
        throwsStateError,
      );
    },
  );

  test(
    'discovered account management uses declared deactivation action',
    () async {
      when(
        () => database.getClient('N42Chat_A'),
      ).thenAnswer((_) async => {'oidc_client_id': 'native-client'});
      when(
        () => client.getAuthMetadata(
          cacheLifetime: Duration.zero,
          throwOnUpdateFailure: true,
        ),
      ).thenAnswer(
        (_) async => metadata(
          management: Uri.parse('https://auth.test/manage?lang=en'),
          actions: [
            AccountManagementActionsSupported.orgMatrixAccountDeactivate,
          ],
        ),
      );
      expect(
        await const MatrixDeletionAccountManagement().resolve(client),
        Uri.parse(
          'https://auth.test/manage?lang=en&action=org.matrix.account_deactivate',
        ),
      );
    },
  );

  test(
    'management link without advertised action keeps its base URL',
    () async {
      when(
        () => database.getClient('N42Chat_A'),
      ).thenAnswer((_) async => {'oidc_client_id': 'native-client'});
      when(
        () => client.getAuthMetadata(
          cacheLifetime: Duration.zero,
          throwOnUpdateFailure: true,
        ),
      ).thenAnswer(
        (_) async => metadata(
          management: Uri.parse('https://auth.test/manage'),
          actions: [],
        ),
      );
      expect(
        await const MatrixDeletionAccountManagement().resolve(client),
        Uri.parse('https://auth.test/manage'),
      );
    },
  );

  for (final invalid in [
    null,
    Uri.parse('http://auth.test/manage'),
    Uri.parse('https://user:secret@auth.test/manage'),
  ]) {
    test('unsafe or missing management link cannot claim deletion', () async {
      when(
        () => database.getClient('N42Chat_A'),
      ).thenAnswer((_) async => {'oidc_client_id': 'native-client'});
      when(
        () => client.getAuthMetadata(
          cacheLifetime: Duration.zero,
          throwOnUpdateFailure: true,
        ),
      ).thenAnswer((_) async => metadata(management: invalid));
      await expectLater(
        const MatrixDeletionAccountManagement().resolve(client),
        throwsStateError,
      );
    });
  }
}
