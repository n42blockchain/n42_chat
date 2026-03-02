// Tests for ContactRepositoryImpl — contacts retrieval and friend requests.

import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_contact_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_moment_datasource.dart';
import 'package:n42_chat/src/data/repositories/contact_repository_impl.dart';

class MockMatrixContactDataSource extends Mock
    implements MatrixContactDataSource {}

class MockPreferencesDataSource extends Mock implements PreferencesDataSource {}

class MockMatrixMomentDataSource extends Mock
    implements MatrixMomentDataSource {}

class MockUser extends Mock implements matrix.User {}

class MockRoom extends Mock implements matrix.Room {}

void main() {
  late ContactRepositoryImpl repository;
  late MockMatrixContactDataSource mockContactDS;
  late MockPreferencesDataSource mockStorageDS;
  late MockMatrixMomentDataSource mockMomentDS;

  setUp(() {
    mockContactDS = MockMatrixContactDataSource();
    mockStorageDS = MockPreferencesDataSource();
    mockMomentDS = MockMatrixMomentDataSource();
    repository = ContactRepositoryImpl(
      mockContactDS,
      mockStorageDS,
      mockMomentDS,
    );
  });

  group('getContacts', () {
    test('returns empty list when no contacts', () async {
      when(() => mockContactDS.getDirectChatContacts()).thenReturn([]);
      when(() => mockContactDS.getDirectChatRoomIdMap()).thenReturn({});
      when(() => mockStorageDS.getContactRemarks())
          .thenAnswer((_) async => {});

      final contacts = await repository.getContacts();

      expect(contacts, isEmpty);
    });

    test('returns mapped contacts sorted by name', () async {
      final user1 = MockUser();
      final user2 = MockUser();

      when(() => user1.id).thenReturn('@bob:matrix.org');
      when(() => user1.displayName).thenReturn('Bob');
      when(() => user1.avatarUrl).thenReturn(null);
      when(() => mockContactDS.getUserDisplayName(user1)).thenReturn('Bob');
      when(() => mockContactDS.getUserAvatarUrl(user1)).thenReturn(null);

      when(() => user2.id).thenReturn('@alice:matrix.org');
      when(() => user2.displayName).thenReturn('Alice');
      when(() => user2.avatarUrl).thenReturn(null);
      when(() => mockContactDS.getUserDisplayName(user2)).thenReturn('Alice');
      when(() => mockContactDS.getUserAvatarUrl(user2)).thenReturn(null);

      when(() => mockContactDS.getDirectChatContacts())
          .thenReturn([user1, user2]);
      when(() => mockContactDS.getDirectChatRoomIdMap()).thenReturn({
        '@bob:matrix.org': '!r1:matrix.org',
        '@alice:matrix.org': '!r2:matrix.org',
      });
      when(() => mockStorageDS.getContactRemarks())
          .thenAnswer((_) async => {});

      final contacts = await repository.getContacts();

      expect(contacts, hasLength(2));
      // Sorted alphabetically: Alice before Bob
      expect(contacts[0].displayName, 'Alice');
      expect(contacts[1].displayName, 'Bob');
    });
  });

  group('startDirectChat', () {
    test('creates chat and invites to moment room', () async {
      const userId = '@alice:matrix.org';
      const roomId = '!dm1:matrix.org';

      when(() => mockContactDS.startDirectChat(userId))
          .thenAnswer((_) async => roomId);
      when(() => mockMomentDS.inviteFriendToMomentRoom(userId))
          .thenAnswer((_) async {});

      final result = await repository.startDirectChat(userId);

      expect(result, roomId);
      verify(() => mockContactDS.startDirectChat(userId)).called(1);
      verify(() => mockMomentDS.inviteFriendToMomentRoom(userId)).called(1);
    });

    test('still returns roomId even if moment invite fails', () async {
      const userId = '@alice:matrix.org';
      const roomId = '!dm1:matrix.org';

      when(() => mockContactDS.startDirectChat(userId))
          .thenAnswer((_) async => roomId);
      when(() => mockMomentDS.inviteFriendToMomentRoom(userId))
          .thenThrow(Exception('Moment room error'));

      final result = await repository.startDirectChat(userId);

      expect(result, roomId);
    });
  });

  group('getPendingFriendRequests', () {
    test('returns empty list when no invites', () async {
      when(() => mockContactDS.getPendingInvites())
          .thenReturn([]);

      final requests = await repository.getPendingFriendRequests();

      expect(requests, isEmpty);
    });
  });

  group('acceptFriendRequest', () {
    test('delegates to datasource', () async {
      const roomId = '!invite1:matrix.org';
      when(() => mockContactDS.acceptInvite(roomId))
          .thenAnswer((_) async {});

      await repository.acceptFriendRequest(roomId);

      verify(() => mockContactDS.acceptInvite(roomId)).called(1);
    });
  });
}
