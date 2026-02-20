// Extended tests for StoryBloc — covers handlers NOT in existing tests:
//   SubscribeStories, UnsubscribeStories,
//   PostStory (success / story=null / failure)

import 'dart:async';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/domain/entities/story_entity.dart';
import 'package:n42_chat/src/domain/repositories/story_repository.dart';
import 'package:n42_chat/src/presentation/blocs/story/story_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/story/story_event.dart';
import 'package:n42_chat/src/presentation/blocs/story/story_state.dart';

class MockStoryRepository extends Mock implements IStoryRepository {}

StoryEntity _makeStory({String id = 's-1'}) => StoryEntity(
      id: id,
      eventId: 'ev-$id',
      userId: '@alice:server',
      userName: 'Alice',
      createdAt: DateTime(2025, 6, 1),
      expiresAt: DateTime(2025, 6, 2),
    );

void main() {
  late MockStoryRepository mockRepo;

  setUp(() {
    mockRepo = MockStoryRepository();
    when(() => mockRepo.getStories()).thenAnswer((_) async => []);
    when(() => mockRepo.getMyStories()).thenAnswer((_) async => []);
  });

  setUpAll(() {
    registerFallbackValue(_makeStory());
    registerFallbackValue(<UserStories>[]);
    registerFallbackValue(<StoryMediaData>[]);
  });

  StoryBloc buildBloc() => StoryBloc(mockRepo);

  // ─────────────────────────────────────────────────
  // SubscribeStories
  // ─────────────────────────────────────────────────

  group('SubscribeStories', () {
    test('subscribes to watchStories and triggers StoriesUpdated', () async {
      final controller = StreamController<List<UserStories>>();
      when(() => mockRepo.watchStories())
          .thenAnswer((_) => controller.stream);

      final bloc = buildBloc();

      bloc.add(const SubscribeStories());
      await Future<void>.delayed(const Duration(milliseconds: 30));

      // Emit from stream
      final userStories = UserStories(
        userId: 'u1',
        userName: 'Alice',
        stories: [_makeStory()],
        lastUpdated: DateTime(2025, 6, 1),
      );
      controller.add([userStories]);
      await Future<void>.delayed(const Duration(milliseconds: 30));

      expect(bloc.state.userStories, hasLength(1));
      await bloc.close();
      await controller.close();
    });
  });

  // ─────────────────────────────────────────────────
  // UnsubscribeStories
  // ─────────────────────────────────────────────────

  group('UnsubscribeStories', () {
    test('cancels watchStories subscription', () async {
      final controller = StreamController<List<UserStories>>();
      when(() => mockRepo.watchStories())
          .thenAnswer((_) => controller.stream);

      final bloc = buildBloc();

      bloc.add(const SubscribeStories());
      await Future<void>.delayed(const Duration(milliseconds: 30));

      bloc.add(const UnsubscribeStories());
      await Future<void>.delayed(const Duration(milliseconds: 30));

      // Stream emits after unsubscribe — should be ignored
      controller.add([
        UserStories(
          userId: 'u2',
          userName: 'Bob',
          stories: [_makeStory(id: 's-2')],
          lastUpdated: DateTime(2025, 6, 2),
        ),
      ]);
      await Future<void>.delayed(const Duration(milliseconds: 30));

      // userStories should still be empty (initial)
      expect(bloc.state.userStories, isEmpty);
      await bloc.close();
      await controller.close();
    });
  });

  // ─────────────────────────────────────────────────
  // PostStory — success (story returned)
  // ─────────────────────────────────────────────────

  group('PostStory — success', () {
    blocTest<StoryBloc, StoryState>(
      'emits isPosting=false and triggers LoadStories on success',
      build: () {
        when(() => mockRepo.postStory(
              content: any(named: 'content'),
              media: any(named: 'media'),
              backgroundColor: any(named: 'backgroundColor'),
              textColor: any(named: 'textColor'),
            )).thenAnswer((_) async => _makeStory());
        return buildBloc();
      },
      act: (bloc) => bloc.add(PostStory(
        content: 'Hello world',
        media: const [],
      )),
      expect: () => [
        isA<StoryState>()
            .having((s) => s.isPosting, 'isPosting', isTrue)
            .having((s) => s.error, 'error', isNull),
        // After success, LoadStories triggered → loading=true
        isA<StoryState>()
            .having((s) => s.isPosting, 'isPosting', isFalse),
        isA<StoryState>()
            .having((s) => s.isLoading, 'isLoading', isTrue),
        isA<StoryState>()
            .having((s) => s.isLoading, 'isLoading', isFalse),
      ],
    );
  });

  // ─────────────────────────────────────────────────
  // PostStory — story returns null
  // ─────────────────────────────────────────────────

  group('PostStory — null result', () {
    blocTest<StoryBloc, StoryState>(
      'emits error when postStory returns null',
      build: () {
        when(() => mockRepo.postStory(
              content: any(named: 'content'),
              media: any(named: 'media'),
              backgroundColor: any(named: 'backgroundColor'),
              textColor: any(named: 'textColor'),
            )).thenAnswer((_) async => null);
        return buildBloc();
      },
      act: (bloc) => bloc.add(PostStory(
        content: 'My story',
        media: const [],
      )),
      expect: () => [
        isA<StoryState>()
            .having((s) => s.isPosting, 'isPosting', isTrue),
        isA<StoryState>()
            .having((s) => s.isPosting, 'isPosting', isFalse)
            .having((s) => s.error, 'error', 'Failed to post story'),
      ],
    );
  });

  // ─────────────────────────────────────────────────
  // PostStory — failure (throws)
  // ─────────────────────────────────────────────────

  group('PostStory — failure', () {
    blocTest<StoryBloc, StoryState>(
      'emits error when postStory throws',
      build: () {
        when(() => mockRepo.postStory(
              content: any(named: 'content'),
              media: any(named: 'media'),
              backgroundColor: any(named: 'backgroundColor'),
              textColor: any(named: 'textColor'),
            )).thenThrow(Exception('Upload failed'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(PostStory(
        content: 'Story content',
        media: const [],
      )),
      expect: () => [
        isA<StoryState>()
            .having((s) => s.isPosting, 'isPosting', isTrue),
        isA<StoryState>()
            .having((s) => s.isPosting, 'isPosting', isFalse)
            .having((s) => s.error, 'error', isNotNull),
      ],
    );
  });
}
