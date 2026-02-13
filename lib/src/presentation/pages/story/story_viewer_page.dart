import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/entities/story_entity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../widgets/common/n42_avatar.dart';
import '../../widgets/story/story_progress_bar.dart';
import 'story_viewers_page.dart';

/// Story 查看器页面
///
/// 全屏查看 Stories，类似 Instagram/WhatsApp 风格：
/// - 支持多用户间滑动切换
/// - 支持单用户多个 Story 点击切换
/// - 自动播放进度（5秒自动切换）
/// - 支持暂停/恢复
class StoryViewerPage extends StatefulWidget {
  /// 所有用户的 Stories 列表
  final List<UserStories> allUserStories;

  /// 初始用户索引
  final int initialUserIndex;

  /// 初始 Story 索引（在该用户的 Stories 中）
  final int initialStoryIndex;

  /// Story 被查看时的回调
  final VoidCallback? onStoryViewed;

  /// 回复 Story 的回调
  final void Function(String userId, String storyId, String message)? onReply;

  /// 当前用户 ID（用于判断是否是自己的 Story）
  final String? currentUserId;

  const StoryViewerPage({
    super.key,
    required this.allUserStories,
    this.initialUserIndex = 0,
    this.initialStoryIndex = 0,
    this.onStoryViewed,
    this.onReply,
    this.currentUserId,
  });

  @override
  State<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends State<StoryViewerPage> {
  /// 用户切换 PageView 控制器
  late PageController _pageController;

  /// 当前用户索引
  late int _currentUserIndex;

  /// 每个用户当前的 Story 索引
  late List<int> _userStoryIndices;

  /// 是否暂停播放
  bool _isPaused = false;

  /// Story 播放时长
  static const Duration _storyDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();

    _currentUserIndex = widget.initialUserIndex.clamp(
      0,
      widget.allUserStories.length - 1,
    );

    // 初始化每个用户的 Story 索引
    _userStoryIndices = List.filled(widget.allUserStories.length, 0);
    if (_currentUserIndex < _userStoryIndices.length) {
      final userStories = widget.allUserStories[_currentUserIndex];
      _userStoryIndices[_currentUserIndex] = widget.initialStoryIndex.clamp(
        0,
        userStories.stories.length - 1,
      );
    }

    _pageController = PageController(initialPage: _currentUserIndex);

    // 设置状态栏样式为亮色内容（用于深色背景）
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    // 触发初始 Story 的查看回调
    _notifyStoryViewed();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // 恢复状态栏样式
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.dispose();
  }

  /// 获取当前用户的 Stories
  UserStories get _currentUserStories =>
      widget.allUserStories[_currentUserIndex];

  /// 获取当前用户的当前 Story 索引
  int get _currentStoryIndex => _userStoryIndices[_currentUserIndex];

  /// 通知 Story 被查看
  void _notifyStoryViewed() {
    widget.onStoryViewed?.call();
  }

  /// 切换到下一个 Story
  void _goToNextStory() {
    final currentUserStories = _currentUserStories;
    final currentIndex = _currentStoryIndex;

    if (currentIndex < currentUserStories.stories.length - 1) {
      // 当前用户还有下一个 Story
      setState(() {
        _userStoryIndices[_currentUserIndex] = currentIndex + 1;
      });
      _notifyStoryViewed();
    } else {
      // 切换到下一个用户
      _goToNextUser();
    }
  }

  /// 切换到上一个 Story
  void _goToPreviousStory() {
    final currentIndex = _currentStoryIndex;

    if (currentIndex > 0) {
      // 当前用户还有上一个 Story
      setState(() {
        _userStoryIndices[_currentUserIndex] = currentIndex - 1;
      });
      _notifyStoryViewed();
    } else {
      // 切换到上一个用户
      _goToPreviousUser();
    }
  }

  /// 切换到下一个用户
  void _goToNextUser() {
    if (_currentUserIndex < widget.allUserStories.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // 最后一个用户的最后一个 Story，关闭查看器
      _close();
    }
  }

  /// 切换到上一个用户
  void _goToPreviousUser() {
    if (_currentUserIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// 跳转到指定 Story
  void _jumpToStory(int index) {
    if (index >= 0 && index < _currentUserStories.stories.length) {
      setState(() {
        _userStoryIndices[_currentUserIndex] = index;
      });
      _notifyStoryViewed();
    }
  }

  /// 用户页面切换回调
  void _onUserPageChanged(int index) {
    setState(() {
      _currentUserIndex = index;
      // 切换用户时从第一个 Story 开始（如果之前没看过）
      // 保持之前的索引（如果用户滑动回来）
    });
    _notifyStoryViewed();
  }

  /// 当前 Story 播放完成
  void _onStoryComplete() {
    _goToNextStory();
  }

  /// 关闭查看器
  void _close() {
    Navigator.of(context).pop();
  }

  /// 显示查看者列表
  void _showViewers(StoryEntity story) {
    // 暂停播放
    setState(() {
      _isPaused = true;
    });

    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => StoryViewersPage(
          storyId: story.id,
          viewers: story.viewedBy,
        ),
      ),
    ).then((_) {
      // 恢复播放
      if (mounted) {
        setState(() {
          _isPaused = false;
        });
      }
    });
  }

  /// 发送回复
  void _sendReply(String userId, String storyId, String message) {
    widget.onReply?.call(userId, storyId, message);
  }

  /// 处理点击事件（左侧/右侧区域）
  void _handleTap(TapUpDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tapX = details.globalPosition.dx;

    // 左侧 1/3 区域：上一个 Story
    // 右侧 2/3 区域：下一个 Story
    if (tapX < screenWidth / 3) {
      _goToPreviousStory();
    } else {
      _goToNextStory();
    }
  }

  /// 处理长按开始（暂停播放）
  void _handleLongPressStart(LongPressStartDetails details) {
    setState(() {
      _isPaused = true;
    });
  }

  /// 处理长按结束（恢复播放）
  void _handleLongPressEnd(LongPressEndDetails details) {
    setState(() {
      _isPaused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.allUserStories.length,
        onPageChanged: _onUserPageChanged,
        itemBuilder: (context, userIndex) {
          final userStories = widget.allUserStories[userIndex];
          final storyIndex = _userStoryIndices[userIndex];
          final story = userStories.stories[storyIndex];
          final isCurrentUser = userIndex == _currentUserIndex;

          final isMyStory = widget.currentUserId != null &&
              userStories.userId == widget.currentUserId;

          return _StoryContent(
            userStories: userStories,
            story: story,
            storyIndex: storyIndex,
            storyDuration: _storyDuration,
            isPaused: _isPaused || !isCurrentUser,
            isMyStory: isMyStory,
            onTap: _handleTap,
            onLongPressStart: _handleLongPressStart,
            onLongPressEnd: _handleLongPressEnd,
            onStoryComplete: _onStoryComplete,
            onProgressTap: _jumpToStory,
            onClose: _close,
            onViewersPressed: isMyStory ? () => _showViewers(story) : null,
            onReply: !isMyStory ? (message) => _sendReply(userStories.userId, story.id, message) : null,
          );
        },
      ),
    );
  }
}

/// Story 内容组件
class _StoryContent extends StatefulWidget {
  final UserStories userStories;
  final StoryEntity story;
  final int storyIndex;
  final Duration storyDuration;
  final bool isPaused;
  final bool isMyStory;
  final void Function(TapUpDetails) onTap;
  final void Function(LongPressStartDetails) onLongPressStart;
  final void Function(LongPressEndDetails) onLongPressEnd;
  final VoidCallback onStoryComplete;
  final void Function(int) onProgressTap;
  final VoidCallback onClose;
  final VoidCallback? onViewersPressed;
  final void Function(String)? onReply;

  const _StoryContent({
    required this.userStories,
    required this.story,
    required this.storyIndex,
    required this.storyDuration,
    required this.isPaused,
    this.isMyStory = false,
    required this.onTap,
    required this.onLongPressStart,
    required this.onLongPressEnd,
    required this.onStoryComplete,
    required this.onProgressTap,
    required this.onClose,
    this.onViewersPressed,
    this.onReply,
  });

  @override
  State<_StoryContent> createState() => _StoryContentState();
}

class _StoryContentState extends State<_StoryContent> {
  final TextEditingController _replyController = TextEditingController();
  final FocusNode _replyFocusNode = FocusNode();
  AudioPlayer? _musicPlayer;
  StreamSubscription<void>? _musicCompleteSubscription;
  bool _isMusicPlaying = false;

  @override
  void initState() {
    super.initState();
    _startMusicIfAvailable();
  }

  @override
  void didUpdateWidget(covariant _StoryContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Story 切换时重新处理音乐
    if (oldWidget.story.id != widget.story.id) {
      _stopMusic();
      _startMusicIfAvailable();
    }
    // 暂停/恢复
    if (oldWidget.isPaused != widget.isPaused && _musicPlayer != null) {
      if (widget.isPaused) {
        _musicPlayer!.pause();
      } else if (_isMusicPlaying) {
        _musicPlayer!.resume();
      }
    }
  }

  void _startMusicIfAvailable() {
    if (!widget.story.hasMusic) return;

    final musicUrl = widget.story.musicUrl;
    if (musicUrl == null || musicUrl.isEmpty) return;

    _musicPlayer = AudioPlayer();

    // Determine the source based on URL scheme
    Source source;
    if (musicUrl.startsWith('mxc://')) {
      // Convert MXC URL to HTTP URL
      final httpUrl = _getMusicHttpUrl(musicUrl);
      if (httpUrl == null) return;
      source = UrlSource(httpUrl);
    } else if (musicUrl.startsWith('http')) {
      source = UrlSource(musicUrl);
    } else {
      // Local file path
      source = DeviceFileSource(musicUrl);
    }

    _musicPlayer!.play(source).then((_) {
      if (mounted) setState(() => _isMusicPlaying = true);
    }).catchError((Object e) {
      debugPrint('StoryViewer: Music playback failed: $e');
    });

    // Seek to start position if specified
    final startAt = widget.story.musicStartAt;
    if (startAt != null && startAt > 0) {
      _musicPlayer!.seek(Duration(seconds: startAt));
    }

    _musicCompleteSubscription?.cancel();
    _musicCompleteSubscription = _musicPlayer!.onPlayerComplete.listen((_) {
      if (mounted) setState(() => _isMusicPlaying = false);
    });
  }

  String? _getMusicHttpUrl(String mxcUrl) {
    final client = MatrixClientManager.instance.client;
    if (client?.homeserver == null) return null;
    final uri = Uri.parse(mxcUrl);
    return client!.homeserver!
        .resolve('/_matrix/media/v3/download/${uri.host}${uri.path}')
        .toString();
  }

  void _stopMusic() {
    _musicCompleteSubscription?.cancel();
    _musicCompleteSubscription = null;
    _musicPlayer?.stop();
    _musicPlayer?.dispose();
    _musicPlayer = null;
    _isMusicPlaying = false;
  }

  @override
  void dispose() {
    _stopMusic();
    _replyController.dispose();
    _replyFocusNode.dispose();
    super.dispose();
  }

  UserStories get userStories => widget.userStories;
  StoryEntity get story => widget.story;
  int get storyIndex => widget.storyIndex;
  Duration get storyDuration => widget.storyDuration;
  bool get isPaused => widget.isPaused;
  void Function(TapUpDetails) get onTap => widget.onTap;
  void Function(LongPressStartDetails) get onLongPressStart => widget.onLongPressStart;
  void Function(LongPressEndDetails) get onLongPressEnd => widget.onLongPressEnd;
  VoidCallback get onStoryComplete => widget.onStoryComplete;
  void Function(int) get onProgressTap => widget.onProgressTap;
  VoidCallback get onClose => widget.onClose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: onTap,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 背景/内容
          _buildStoryBackground(context),

          // 渐变遮罩（顶部和底部）
          _buildGradientOverlay(),

          // 前景 UI
          SafeArea(
            child: Column(
              children: [
                // 顶部：进度条 + 用户信息
                _buildTopSection(context),

                // 中间内容区域：文字（如果是纯文字 Story）
                if (story.isTextOnly) ...[
                  const Spacer(),
                  _buildTextContent(context),
                  const Spacer(),
                ],

                // 占位（非纯文字 Story 时）
                if (!story.isTextOnly) const Spacer(),

                // 底部区域（可选：回复输入框）
                _buildBottomSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建 Story 背景
  Widget _buildStoryBackground(BuildContext context) {
    if (story.isTextOnly) {
      // 纯文字 Story：显示背景颜色
      final bgColor = story.backgroundColor != null
          ? Color(story.backgroundColor!)
          : AppColors.primary;
      return Container(color: bgColor);
    }

    if (story.hasMedia) {
      final media = story.media.first;

      // 图片类型
      if (media.type == StoryMediaType.image) {
        final imageUrl = media.httpUrl ?? media.url;

        // 获取认证头
        final accessToken = MatrixClientManager.instance.client?.accessToken;
        final headers = <String, String>{};
        if (accessToken != null && accessToken.isNotEmpty) {
          headers['Authorization'] = 'Bearer $accessToken';
        }

        return CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          httpHeaders: headers,
          placeholder: (context, url) => Container(
            color: Colors.grey[900],
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[900],
            child: const Center(
              child: Icon(
                Icons.broken_image,
                color: Colors.white54,
                size: 64,
              ),
            ),
          ),
        );
      }

      // 视频类型：显示缩略图和播放图标
      if (media.type == StoryMediaType.video) {
        final thumbnailUrl = media.thumbnailUrl ?? media.httpUrl ?? media.url;

        // 获取认证头
        final accessToken = MatrixClientManager.instance.client?.accessToken;
        final headers = <String, String>{};
        if (accessToken != null && accessToken.isNotEmpty) {
          headers['Authorization'] = 'Bearer $accessToken';
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: thumbnailUrl,
              fit: BoxFit.cover,
              httpHeaders: headers,
              placeholder: (context, url) => Container(
                color: Colors.grey[900],
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[900],
              ),
            ),
            // 视频播放图标
            const Center(
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.white70,
                size: 80,
              ),
            ),
          ],
        );
      }
    }

    // 默认背景
    return Container(color: Colors.grey[900]);
  }

  /// 构建渐变遮罩
  Widget _buildGradientOverlay() {
    return Column(
      children: [
        // 顶部渐变
        Container(
          height: 150,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black54,
                Colors.transparent,
              ],
            ),
          ),
        ),
        const Spacer(),
        // 底部渐变
        Container(
          height: 100,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black38,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 构建顶部区域（进度条 + 用户信息）
  Widget _buildTopSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 进度条
          AnimatedStoryProgressBar(
            storyCount: userStories.stories.length,
            currentIndex: storyIndex,
            storyDuration: storyDuration,
            isPaused: isPaused,
            onStoryComplete: onStoryComplete,
            onTap: onProgressTap,
            height: 2.5,
            segmentGap: 4,
          ),

          const SizedBox(height: 12),

          // 用户信息行
          _buildUserInfoRow(context),
        ],
      ),
    );
  }

  /// 构建用户信息行
  Widget _buildUserInfoRow(BuildContext context) {
    return Row(
      children: [
        // 头像
        N42Avatar(
          imageUrl: userStories.avatarUrl,
          name: userStories.userName,
          size: 36,
          borderRadius: 18, // 圆形
        ),

        const SizedBox(width: 10),

        // 用户名和时间
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userStories.userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                _formatTimeAgo(story.createdAt),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        // 音乐指示器
        if (story.hasMusic) ...[
          GestureDetector(
            onTap: () {
              if (_musicPlayer == null) return;
              if (_isMusicPlaying) {
                _musicPlayer!.pause();
                setState(() => _isMusicPlaying = false);
              } else {
                _musicPlayer!.resume();
                setState(() => _isMusicPlaying = true);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isMusicPlaying ? Icons.music_note : Icons.music_off,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 80),
                    child: Text(
                      story.musicTitle ?? 'Music',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],

        // 关闭按钮
        IconButton(
          onPressed: onClose,
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 28,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  /// 构建纯文字内容
  Widget _buildTextContent(BuildContext context) {
    final textColor = story.textColor != null
        ? Color(story.textColor!)
        : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        story.content ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.4,
          shadows: const [
            Shadow(
              color: Colors.black26,
              offset: Offset(1, 1),
              blurRadius: 4,
            ),
          ],
        ),
      ),
    );
  }

  /// 构建底部区域
  Widget _buildBottomSection(BuildContext context) {
    final l10n = S.of(context);

    // 自己的 Story：显示查看者按钮
    if (widget.isMyStory) {
      final viewCount = story.viewCount;
      return GestureDetector(
        onTap: widget.onViewersPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                Icons.visibility_outlined,
                color: Colors.white.withValues(alpha: 0.8),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                viewCount > 0
                    ? '$viewCount ${l10n?.storyViewers ?? "viewers"}'
                    : (l10n?.storyNoViewers ?? 'No viewers yet'),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withValues(alpha: 0.6),
                size: 20,
              ),
            ],
          ),
        ),
      );
    }

    // 别人的 Story：显示回复输入框
    if (widget.onReply != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 0.5,
                  ),
                ),
                child: TextField(
                  controller: _replyController,
                  focusNode: _replyFocusNode,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: l10n?.storyReplyToStory ?? 'Reply to story...',
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    isDense: true,
                  ),
                  textInputAction: TextInputAction.send,
                  onSubmitted: _handleReplySubmit,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _handleReplySubmit(_replyController.text),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 22,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      );
    }

    return const SizedBox(height: 16);
  }

  void _handleReplySubmit(String text) {
    final message = text.trim();
    if (message.isEmpty) return;

    widget.onReply?.call(message);
    _replyController.clear();
    _replyFocusNode.unfocus();
  }

  /// 格式化时间为 "X 小时前" 等格式
  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }
}
