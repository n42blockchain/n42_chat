import 'package:equatable/equatable.dart';

import '../../../domain/entities/story_entity.dart';

/// Story 状态
class StoryState extends Equatable {
  /// 按用户分组的 Stories 列表
  final List<UserStories> userStories;

  /// 当前用户的 Stories
  final List<StoryEntity> myStories;

  /// 是否正在加载
  final bool isLoading;

  /// 是否正在发布
  final bool isPosting;

  /// 错误信息
  final String? error;

  /// 当前用户 ID
  final String? currentUserId;

  const StoryState({
    this.userStories = const [],
    this.myStories = const [],
    this.isLoading = false,
    this.isPosting = false,
    this.error,
    this.currentUserId,
  });

  /// 初始状态
  factory StoryState.initial() => const StoryState();

  @override
  List<Object?> get props => [
        userStories,
        myStories,
        isLoading,
        isPosting,
        error,
        currentUserId,
      ];

  StoryState copyWith({
    List<UserStories>? userStories,
    List<StoryEntity>? myStories,
    bool? isLoading,
    bool? isPosting,
    String? error,
    bool clearError = false,
    String? currentUserId,
  }) {
    return StoryState(
      userStories: userStories ?? this.userStories,
      myStories: myStories ?? this.myStories,
      isLoading: isLoading ?? this.isLoading,
      isPosting: isPosting ?? this.isPosting,
      error: clearError ? null : (error ?? this.error),
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }

  /// 是否有 Stories
  bool get hasStories => userStories.isNotEmpty;

  /// 我的 Stories 数量
  int get myStoriesCount => myStories.length;

  /// 未查看的 Stories 数量
  int get unviewedStoriesCount {
    int count = 0;
    for (final userStory in userStories) {
      count += userStory.unviewedCount;
    }
    return count;
  }

  /// 是否有错误
  bool get hasError => error != null;

  /// 是否为空
  bool get isEmpty => userStories.isEmpty && myStories.isEmpty;
}
