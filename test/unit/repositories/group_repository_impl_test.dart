// Tests for GroupRepositoryImpl — group creation, member management.

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_group_datasource.dart';
import 'package:n42_chat/src/data/repositories/group_repository_impl.dart';

class MockMatrixGroupDataSource extends Mock
    implements MatrixGroupDataSource {}

class MockMatrixClientManager extends Mock implements MatrixClientManager {}

class MockClient extends Mock implements matrix.Client {}

class MockRoom extends Mock implements matrix.Room {}

class MockUser extends Mock implements matrix.User {}

void main() {
  late GroupRepositoryImpl repository;
  late MockMatrixGroupDataSource mockGroupDS;
  late MockMatrixClientManager mockClientMgr;
  late MockClient mockClient;

  const testRoomId = '!group1:matrix.org';

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
  });

  setUp(() {
    mockGroupDS = MockMatrixGroupDataSource();
    mockClientMgr = MockMatrixClientManager();
    mockClient = MockClient();
    repository = GroupRepositoryImpl(mockGroupDS, mockClientMgr);

    when(() => mockClientMgr.client).thenReturn(mockClient);
    when(() => mockClient.userID).thenReturn('@me:matrix.org');
  });

  group('createGroup', () {
    test('creates group and returns roomId', () async {
      const name = 'Test Group';
      final inviteIds = ['@alice:matrix.org', '@bob:matrix.org'];

      when(() => mockGroupDS.createGroup(
            name: name,
            inviteUserIds: inviteIds,
          )).thenAnswer((_) async => testRoomId);

      final result = await repository.createGroup(
        name: name,
        inviteUserIds: inviteIds,
      );

      expect(result, testRoomId);
      verify(() => mockGroupDS.createGroup(
            name: name,
            inviteUserIds: inviteIds,
          )).called(1);
    });

    test('propagates exception on failure', () async {
      when(() => mockGroupDS.createGroup(
            name: any(named: 'name'),
            inviteUserIds: any(named: 'inviteUserIds'),
          )).thenThrow(Exception('Server error'));

      expect(
        () => repository.createGroup(name: 'Fail Group'),
        throwsException,
      );
    });
  });

  group('getGroupMembers', () {
    test('returns mapped member list', () async {
      final mockUser1 = MockUser();
      final mockUser2 = MockUser();

      when(() => mockUser1.id).thenReturn('@alice:matrix.org');
      when(() => mockUser1.displayName).thenReturn('Alice');
      when(() => mockUser1.calcDisplayname()).thenReturn('Alice');
      when(() => mockUser1.avatarUrl).thenReturn(null);
      when(() => mockUser1.powerLevel).thenReturn(100);
      when(() => mockUser1.membership).thenReturn(matrix.Membership.join);
      when(() => mockGroupDS.getUserPowerLevel(testRoomId, '@alice:matrix.org'))
          .thenReturn(100);
      when(() => mockGroupDS.getGroupAvatarUrl(testRoomId)).thenReturn(null);

      when(() => mockUser2.id).thenReturn('@bob:matrix.org');
      when(() => mockUser2.displayName).thenReturn('Bob');
      when(() => mockUser2.calcDisplayname()).thenReturn('Bob');
      when(() => mockUser2.avatarUrl).thenReturn(null);
      when(() => mockUser2.powerLevel).thenReturn(0);
      when(() => mockUser2.membership).thenReturn(matrix.Membership.join);
      when(() => mockGroupDS.getUserPowerLevel(testRoomId, '@bob:matrix.org'))
          .thenReturn(0);

      when(() => mockGroupDS.getGroupMembers(testRoomId))
          .thenAnswer((_) async => [mockUser1, mockUser2]);

      final members = await repository.getGroupMembers(testRoomId);

      expect(members, hasLength(2));
      expect(members[0].userId, '@alice:matrix.org');
      expect(members[1].userId, '@bob:matrix.org');
    });

    test('returns empty list for empty group', () async {
      when(() => mockGroupDS.getGroupMembers(testRoomId))
          .thenAnswer((_) async => []);

      final members = await repository.getGroupMembers(testRoomId);

      expect(members, isEmpty);
    });
  });

  group('getGroups', () {
    test('returns empty list when no groups exist', () async {
      when(() => mockGroupDS.getAllGroups()).thenReturn([]);

      final groups = await repository.getGroups();

      expect(groups, isEmpty);
    });
  });

  group('leaveGroup', () {
    test('delegates to datasource', () async {
      when(() => mockGroupDS.leaveGroup(testRoomId))
          .thenAnswer((_) async {});

      await repository.leaveGroup(testRoomId);

      verify(() => mockGroupDS.leaveGroup(testRoomId)).called(1);
    });
  });
}
