import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/secure_storage_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_auth_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/remote/social_auth_api.dart';
import 'package:n42_chat/src/data/repositories/auth_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/user_entity.dart';

class MockMatrixAuthDataSource extends Mock implements MatrixAuthDataSource {}

class MockSecureStorageDataSource extends Mock
    implements SecureStorageDataSource {}

class MockMatrixClientManager extends Mock implements MatrixClientManager {}

class MockSocialAuthApi extends Mock implements SocialAuthApi {}

class SpyAuthRepositoryImpl extends AuthRepositoryImpl {
  SpyAuthRepositoryImpl({
    required super.authDataSource,
    required super.secureStorage,
    required super.socialAuthApi,
  });

  bool updateUserProfileDataResult = true;
  int clearNftAvatarCalls = 0;
  int profileReads = 0;
  Future<bool>? profileWrite;

  @override
  Future<bool> updateUserProfileData({
    String? gender,
    String? region,
    String? signature,
    String? pokeText,
    String? ringtone,
    String? avatarDecorationPreset,
    String? nftContractAddress,
    int? nftTokenId,
    int? nftChainId,
    String? nftImageUrl,
    bool clearNftAvatar = false,
  }) async {
    if (clearNftAvatar) {
      clearNftAvatarCalls++;
    }
    return profileWrite ?? updateUserProfileDataResult;
  }

  @override
  Future<UserEntity?> getCurrentUserProfile() async {
    profileReads++;
    return null;
  }
}

void main() {
  late MockMatrixAuthDataSource mockAuthDataSource;
  late MockSecureStorageDataSource mockSecureStorage;
  late MockMatrixClientManager mockClientManager;
  late MockSocialAuthApi mockSocialAuthApi;
  late AuthRepositoryImpl repository;

  test('display name completion rejects a replaced account', () async {
    var userId = '@first:example';
    final pending = Completer<void>();
    when(() => mockAuthDataSource.userId).thenAnswer((_) => userId);
    when(() => mockClientManager.setDisplayName(any()))
        .thenAnswer((_) => pending.future);
    final update = repository.updateDisplayName('First account name');
    userId = '@second:example';
    pending.complete();
    expect(await update, isFalse);
  });

  test('display name completion rejects logout', () async {
    var loggedIn = true;
    final pending = Completer<void>();
    when(() => mockAuthDataSource.isLoggedIn).thenAnswer((_) => loggedIn);
    when(() => mockClientManager.setDisplayName(any()))
        .thenAnswer((_) => pending.future);
    final update = repository.updateDisplayName('Old session name');
    loggedIn = false;
    pending.complete();
    expect(await update, isFalse);
  });

  for (final logout in [false, true]) {
    test(
      'avatar upload stops follow-up writes after ${logout ? 'logout' : 'account switch'}',
      () async {
        var userId = '@first:example';
        var loggedIn = true;
        final pending = Completer<void>();
        when(() => mockAuthDataSource.userId).thenAnswer((_) => userId);
        when(() => mockAuthDataSource.isLoggedIn).thenAnswer((_) => loggedIn);
        when(() => mockClientManager.setAvatar(any(), any()))
            .thenAnswer((_) => pending.future);
        final spy = SpyAuthRepositoryImpl(
          authDataSource: mockAuthDataSource,
          secureStorage: mockSecureStorage,
          socialAuthApi: mockSocialAuthApi,
        );
        final update = spy.updateAvatar(Uint8List.fromList([1]), 'avatar.png');
        if (logout) {
          loggedIn = false;
        } else {
          userId = '@second:example';
        }
        pending.complete();
        expect(await update, isFalse);
        expect(spy.clearNftAvatarCalls, 0);
        expect(spy.profileReads, 0);
      },
    );
  }

  test(
    'avatar metadata completion does not refresh a replacement account',
    () async {
      var userId = '@first:example';
      final pending = Completer<bool>();
      when(() => mockAuthDataSource.userId).thenAnswer((_) => userId);
      final spy = SpyAuthRepositoryImpl(
        authDataSource: mockAuthDataSource,
        secureStorage: mockSecureStorage,
        socialAuthApi: mockSocialAuthApi,
      )..profileWrite = pending.future;
      final update = spy.updateAvatar(Uint8List.fromList([1]), 'avatar.png');
      await Future<void>.delayed(Duration.zero);
      expect(spy.clearNftAvatarCalls, 1);
      userId = '@second:example';
      pending.complete(true);
      expect(await update, isFalse);
      expect(spy.profileReads, 0);
    },
  );

  test(
    'avatar update retains metadata clear and refresh for the same account',
    () async {
      final spy = SpyAuthRepositoryImpl(
        authDataSource: mockAuthDataSource,
        secureStorage: mockSecureStorage,
        socialAuthApi: mockSocialAuthApi,
      );
      expect(
        await spy.updateAvatar(Uint8List.fromList([1]), 'avatar.png'),
        isTrue,
      );
      expect(spy.clearNftAvatarCalls, 1);
      expect(spy.profileReads, 1);
    },
  );

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
  });

  setUp(() {
    mockAuthDataSource = MockMatrixAuthDataSource();
    mockSecureStorage = MockSecureStorageDataSource();
    mockClientManager = MockMatrixClientManager();
    mockSocialAuthApi = MockSocialAuthApi();

    when(() => mockAuthDataSource.clientManager).thenReturn(mockClientManager);
    when(() => mockAuthDataSource.isLoggedIn).thenReturn(true);
    when(
      () => mockClientManager.setDisplayName(any()),
    ).thenAnswer((_) async {});
    when(
      () => mockClientManager.setAvatar(any(), any()),
    ).thenAnswer((_) async {});
    when(() => mockClientManager.startSync()).thenAnswer((_) async {});
    when(
      () => mockAuthDataSource.loginWithToken(
        homeserver: any(named: 'homeserver'),
        accessToken: any(named: 'accessToken'),
        userId: any(named: 'userId'),
        deviceId: any(named: 'deviceId'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockSecureStorage.saveSession(
        homeserver: any(named: 'homeserver'),
        accessToken: any(named: 'accessToken'),
        userId: any(named: 'userId'),
        deviceId: any(named: 'deviceId'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockSecureStorage.addAccount(
        userId: any(named: 'userId'),
        homeserver: any(named: 'homeserver'),
        accessToken: any(named: 'accessToken'),
        deviceId: any(named: 'deviceId'),
        displayName: any(named: 'displayName'),
        avatarUrl: any(named: 'avatarUrl'),
      ),
    ).thenAnswer((_) async {});

    repository = AuthRepositoryImpl(
      authDataSource: mockAuthDataSource,
      secureStorage: mockSecureStorage,
      socialAuthApi: mockSocialAuthApi,
    );
  });

  test(
    'loginWithToken clears stale cached profile before storing account metadata',
    () async {
      final displayNameUpdated = await repository.updateDisplayName('Old Name');
      expect(displayNameUpdated, isTrue);

      final result = await repository.loginWithToken(
        homeserver: 'https://hs.example',
        accessToken: 'token-1',
        userId: '@new:hs.example',
        deviceId: 'device-1',
      );

      expect(result.success, isTrue);
      verify(
        () => mockSecureStorage.addAccount(
          userId: '@new:hs.example',
          homeserver: 'https://hs.example',
          accessToken: 'token-1',
          deviceId: 'device-1',
          displayName: 'new',
          avatarUrl: null,
        ),
      ).called(1);
    },
  );

  test(
    'updateAvatar fails when NFT metadata cannot be cleared after upload',
    () async {
      final spyRepository = SpyAuthRepositoryImpl(
        authDataSource: mockAuthDataSource,
        secureStorage: mockSecureStorage,
        socialAuthApi: mockSocialAuthApi,
      )..updateUserProfileDataResult = false;

      final result = await spyRepository.updateAvatar(
        Uint8List.fromList([1, 2, 3]),
        'avatar.png',
      );

      expect(result, isFalse);
      expect(spyRepository.clearNftAvatarCalls, 1);
      verify(() => mockClientManager.setAvatar(any(), 'avatar.png')).called(1);
    },
  );
}
