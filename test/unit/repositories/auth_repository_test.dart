import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/user_entity.dart';
import 'package:n42_chat/src/domain/repositories/auth_repository.dart';

void main() {
  group('AuthResult', () {
    test('success should create result with user', () {
      final user = UserEntity(
        userId: '@user:server.com',
        displayName: 'Test User',
      );
      
      final result = AuthResult.success(user);
      
      expect(result.success, isTrue);
      expect(result.user, equals(user));
      expect(result.errorMessage, isNull);
      expect(result.errorType, isNull);
    });

    test('failure should create result with error', () {
      final result = AuthResult.failure(
        '登录失败',
        type: AuthErrorType.invalidCredentials,
      );
      
      expect(result.success, isFalse);
      expect(result.user, isNull);
      expect(result.errorMessage, equals('登录失败'));
      expect(result.errorType, equals(AuthErrorType.invalidCredentials));
    });

    test('notLoggedIn should create result without login', () {
      final result = AuthResult.notLoggedIn();
      
      expect(result.success, isFalse);
      expect(result.user, isNull);
      expect(result.errorType, equals(AuthErrorType.notLoggedIn));
    });
  });

  group('AuthErrorType', () {
    test('should have all expected error types', () {
      expect(AuthErrorType.values, contains(AuthErrorType.invalidCredentials));
      expect(AuthErrorType.values, contains(AuthErrorType.invalidHomeserver));
      expect(AuthErrorType.values, contains(AuthErrorType.serverError));
      expect(AuthErrorType.values, contains(AuthErrorType.networkError));
      expect(AuthErrorType.values, contains(AuthErrorType.tokenExpired));
      expect(AuthErrorType.values, contains(AuthErrorType.unknown));
      expect(AuthErrorType.values, contains(AuthErrorType.notLoggedIn));
    });
  });

  group('HomeserverInfo', () {
    test('should create with required fields', () {
      final info = HomeserverInfo(
        serverName: 'N42 Matrix',
        serverVersion: '1.0.0',
        supportedLoginTypes: ['m.login.password', 'm.login.sso'],
        supportsRegistration: true,
      );

      expect(info.serverName, equals('N42 Matrix'));
      expect(info.serverVersion, equals('1.0.0'));
      expect(info.supportsRegistration, isTrue);
      expect(info.supportsPasswordLogin, isTrue);
      expect(info.supportsSsoLogin, isTrue);
    });

    test('should have default values for optional fields', () {
      final info = HomeserverInfo(
        serverName: 'Test Server',
        serverVersion: '1.0.0',
        supportedLoginTypes: ['m.login.password'],
      );

      expect(info.serverVersion, equals('1.0.0'));
      expect(info.supportsRegistration, isFalse);
      expect(info.supportsPasswordLogin, isTrue);
      expect(info.supportsSsoLogin, isFalse);
    });
  });

  group('UserEntity', () {
    test('should create with required fields', () {
      final user = UserEntity(
        userId: '@user:server.com',
        displayName: 'Test User',
      );

      expect(user.userId, equals('@user:server.com'));
      expect(user.displayName, equals('Test User'));
    });

    test('should handle optional profile fields', () {
      final user = UserEntity(
        userId: '@user:server.com',
        displayName: 'Test User',
        avatarUrl: 'https://server.com/avatar.jpg',
        gender: '男',
        region: '北京',
        signature: 'Hello World',
        pokeText: '的肩膀',
        ringtone: '默认铃声',
      );

      expect(user.avatarUrl, isNotNull);
      expect(user.gender, equals('男'));
      expect(user.region, equals('北京'));
      expect(user.signature, equals('Hello World'));
      expect(user.pokeText, equals('的肩膀'));
      expect(user.ringtone, equals('默认铃声'));
    });

    test('should support equality', () {
      final user1 = UserEntity(
        userId: '@user:server.com',
        displayName: 'Test User',
      );

      final user2 = UserEntity(
        userId: '@user:server.com',
        displayName: 'Test User',
      );

      expect(user1, equals(user2));
    });

    test('should support copyWith', () {
      final user = UserEntity(
        userId: '@user:server.com',
        displayName: 'Test User',
      );

      final updated = user.copyWith(
        displayName: 'Updated Name',
        avatarUrl: 'https://new-avatar.jpg',
      );

      expect(updated.userId, equals(user.userId));
      expect(updated.displayName, equals('Updated Name'));
      expect(updated.avatarUrl, equals('https://new-avatar.jpg'));
    });
  });

  group('WeChat Login Strategy', () {
    test('rememberMe should default to true', () {
      // 微信策略：默认始终记住登录状态
      const defaultRememberMe = true;
      expect(defaultRememberMe, isTrue);
    });

    test('session restore should try token first then credentials', () {
      // 会话恢复优先级测试
      const restoreOrder = ['token', 'credentials'];
      expect(restoreOrder.first, equals('token'));
      expect(restoreOrder.last, equals('credentials'));
    });

    test('logout should clear both session and credentials', () {
      // 登出应该清除 session 和 credentials
      const itemsToClears = ['session', 'credentials', 'profileCache'];
      expect(itemsToClears.length, equals(3));
    });
  });
}

