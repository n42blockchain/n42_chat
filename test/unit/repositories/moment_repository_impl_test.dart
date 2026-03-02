// Tests for MomentRepositoryImpl — moments CRUD and filtering.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_moment_datasource.dart';
import 'package:n42_chat/src/data/repositories/moment_repository_impl.dart';
import 'package:n42_chat/src/domain/entities/moment_entity.dart';

class MockMatrixMomentDataSource extends Mock
    implements MatrixMomentDataSource {}

class MockPreferencesDataSource extends Mock implements PreferencesDataSource {}

void main() {
  late MomentRepositoryImpl repository;
  late MockMatrixMomentDataSource mockMomentDS;
  late MockPreferencesDataSource mockStorageDS;

  setUp(() {
    mockMomentDS = MockMatrixMomentDataSource();
    mockStorageDS = MockPreferencesDataSource();
    repository = MomentRepositoryImpl(mockMomentDS, mockStorageDS);
  });

  MomentEntity _makeMoment(String id, {String? userId, DateTime? time}) {
    return MomentEntity(
      id: id,
      userId: userId ?? '@user:matrix.org',
      userName: 'User',
      content: 'Test moment $id',
      timestamp: time ?? DateTime.now(),
    );
  }

  group('getMoments', () {
    test('returns moments from datasource', () async {
      final moments = [_makeMoment('m1'), _makeMoment('m2')];

      when(() => mockMomentDS.getMoments(limit: 20))
          .thenAnswer((_) async => moments);
      when(() => mockMomentDS.getMomentLikes(any()))
          .thenAnswer((_) async => []);
      when(() => mockMomentDS.getMomentComments(any()))
          .thenAnswer((_) async => []);
      when(() => mockStorageDS.getHiddenMomentUsers())
          .thenAnswer((_) async => []);
      when(() => mockStorageDS.getBlockedMomentUsers())
          .thenAnswer((_) async => []);
      when(() => mockStorageDS.getMomentSettings())
          .thenAnswer((_) async => null);

      final result = await repository.getMoments();

      expect(result, isNotEmpty);
      verify(() => mockMomentDS.getMoments(limit: 20)).called(1);
    });

    test('returns empty list when no moments', () async {
      when(() => mockMomentDS.getMoments(limit: 20))
          .thenAnswer((_) async => []);
      when(() => mockStorageDS.getHiddenMomentUsers())
          .thenAnswer((_) async => []);
      when(() => mockStorageDS.getBlockedMomentUsers())
          .thenAnswer((_) async => []);
      when(() => mockStorageDS.getMomentSettings())
          .thenAnswer((_) async => null);

      final result = await repository.getMoments();

      expect(result, isEmpty);
    });
  });

  group('postTextMoment', () {
    test('posts moment and returns entity', () async {
      const momentId = '\$moment1';
      final moment = _makeMoment(momentId);

      when(() => mockMomentDS.postMoment(content: 'Hello world'))
          .thenAnswer((_) async => momentId);
      when(() => mockMomentDS.getMomentById(momentId))
          .thenAnswer((_) async => moment);
      when(() => mockMomentDS.getMomentLikes(momentId))
          .thenAnswer((_) async => []);
      when(() => mockMomentDS.getMomentComments(momentId))
          .thenAnswer((_) async => []);

      final result = await repository.postTextMoment(content: 'Hello world');

      expect(result.id, momentId);
      verify(() => mockMomentDS.postMoment(content: 'Hello world')).called(1);
    });
  });

  group('likeMoment', () {
    test('delegates to datasource', () async {
      const momentId = '\$moment1';
      when(() => mockMomentDS.likeMoment(momentId))
          .thenAnswer((_) async {});

      await repository.likeMoment(momentId);

      verify(() => mockMomentDS.likeMoment(momentId)).called(1);
    });
  });

  group('deleteMoment', () {
    test('delegates to datasource', () async {
      const momentId = '\$moment1';
      when(() => mockMomentDS.deleteMoment(momentId))
          .thenAnswer((_) async {});

      await repository.deleteMoment(momentId);

      verify(() => mockMomentDS.deleteMoment(momentId)).called(1);
    });
  });
}
