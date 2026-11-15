import 'package:flutter_test/flutter_test.dart';
// Test the pinned SDK boundary without introducing a production dependency.
// ignore: depend_on_referenced_packages
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:n42_chat/src/services/auth/auth_methods_service.dart';

class GooglePlatform extends GoogleSignInPlatform {
  int initializations = 0;
  int logins = 0;
  String? code = 'one-use-code';
  bool cancel = false;
  @override
  Future<void> init(InitParameters params) async {
    initializations++;
  }

  @override
  Future<void> signOut(SignOutParams params) async {}
  @override
  Future<AuthenticationResults> authenticate(
    AuthenticateParameters params,
  ) async {
    logins++;
    if (cancel)
      throw const GoogleSignInException(
        code: GoogleSignInExceptionCode.canceled,
      );
    return const AuthenticationResults(
      user: GoogleSignInUserData(email: 'ignored@example.test', id: 'subject'),
      authenticationTokens: AuthenticationTokenData(
        idToken: 'must-not-use-as-code',
      ),
    );
  }

  @override
  Future<ServerAuthorizationTokenData?> serverAuthorizationTokensForScopes(
    ServerAuthorizationTokensForScopesParameters params,
  ) async {
    expect(params.request.scopes, ['openid', 'email', 'profile']);
    return code == null
        ? null
        : ServerAuthorizationTokenData(serverAuthCode: code!);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'native server-code login uses SDK authorization without reinitializing',
    () async {
      final original = GoogleSignInPlatform.instance;
      final platform = GooglePlatform();
      GoogleSignInPlatform.instance = platform;
      try {
        final service = AuthMethodsService();
        await service.initialize(googleServerClientId: 'test-server');
        final result = await service.signInWithGoogle(requireServerCode: true);
        expect(result?.extra?['serverAuthCode'], 'one-use-code');
        expect(result?.idToken, isNull);
        expect(result?.accessToken, isNull);
        platform.code = null;
        await expectLater(
          service.signInWithGoogle(requireServerCode: true),
          throwsStateError,
        );
        platform.cancel = true;
        expect(await service.signInWithGoogle(requireServerCode: true), isNull);
        expect(platform.initializations, 1);
        expect(platform.logins, 3);
      } finally {
        GoogleSignInPlatform.instance = original;
      }
    },
  );
}
