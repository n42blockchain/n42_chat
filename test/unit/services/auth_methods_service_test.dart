import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/services/auth/auth_methods_service.dart';

void main() {
  group('AuthMethodsService', () {
    late AuthMethodsService service;

    setUp(() {
      service = AuthMethodsService();
    });

    test('should be a singleton', () {
      final service1 = AuthMethodsService();
      final service2 = AuthMethodsService();
      expect(identical(service1, service2), isTrue);
    });

    group('Passkey Support', () {
      test('isPasskeySupported should return platform check result', () async {
        final result = await service.isPasskeySupported();
        // 在测试环境中可能返回 false
        expect(result, isA<bool>());
      });
    });

    group('Email OTP', () {
      test('requestEmailOtp should return success', () async {
        final result = await service.requestEmailOtp(
          email: 'test@example.com',
          homeserver: 'https://m.si46.world',
        );
        expect(result, isTrue);
      });

      test('verifyEmailOtp should return verification result', () async {
        final result = await service.verifyEmailOtp(
          email: 'test@example.com',
          otp: '123456',
          homeserver: 'https://m.si46.world',
        );
        expect(result, isNotNull);
        expect(result!['verified'], isTrue);
      });
    });

    group('SSO', () {
      test('getSsoLoginUrl should return valid URL', () {
        final url = service.getSsoLoginUrl(
          homeserver: 'https://m.si46.world',
          redirectUrl: 'https://app.n42.chat/callback',
        );
        
        expect(url, contains('/_matrix/client/v3/login/sso/redirect'));
        expect(url, contains('redirectUrl='));
      });
    });
  });

  group('SocialLoginResult', () {
    test('should create with required fields', () {
      final result = SocialLoginResult(
        provider: 'google',
        email: 'test@gmail.com',
        displayName: 'Test User',
      );

      expect(result.provider, equals('google'));
      expect(result.email, equals('test@gmail.com'));
      expect(result.displayName, equals('Test User'));
    });

    test('should handle optional fields', () {
      final result = SocialLoginResult(
        provider: 'apple',
        idToken: 'token123',
        accessToken: 'access123',
      );

      expect(result.provider, equals('apple'));
      expect(result.idToken, equals('token123'));
      expect(result.email, isNull);
    });
  });

  group('PasskeyCredential', () {
    test('should serialize to JSON', () {
      final credential = PasskeyCredential(
        credentialId: 'cred123',
        publicKey: 'pubkey123',
        userId: '@user:server.com',
        displayName: 'Test User',
      );

      final json = credential.toJson();
      
      expect(json['credentialId'], equals('cred123'));
      expect(json['publicKey'], equals('pubkey123'));
      expect(json['userId'], equals('@user:server.com'));
      expect(json['displayName'], equals('Test User'));
    });

    test('should deserialize from JSON', () {
      final json = {
        'credentialId': 'cred123',
        'publicKey': 'pubkey123',
        'userId': '@user:server.com',
        'displayName': 'Test User',
      };

      final credential = PasskeyCredential.fromJson(json);
      
      expect(credential.credentialId, equals('cred123'));
      expect(credential.publicKey, equals('pubkey123'));
      expect(credential.userId, equals('@user:server.com'));
      expect(credential.displayName, equals('Test User'));
    });
  });
  
  group('AuthMethod Enum', () {
    test('should have all expected auth methods', () {
      expect(AuthMethod.values, contains(AuthMethod.password));
      expect(AuthMethod.values, contains(AuthMethod.passkey));
      expect(AuthMethod.values, contains(AuthMethod.emailOtp));
      expect(AuthMethod.values, contains(AuthMethod.google));
      expect(AuthMethod.values, contains(AuthMethod.apple));
      expect(AuthMethod.values, contains(AuthMethod.sso));
    });
  });
}
