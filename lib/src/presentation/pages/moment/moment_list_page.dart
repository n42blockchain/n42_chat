import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/entities/moment_entity.dart';
import '../../blocs/moment/moment_bloc.dart';
import '../../blocs/moment/moment_event.dart';
import '../../blocs/moment/moment_state.dart';
import '../../widgets/common/n42_avatar.dart';
import 'create_moment_page.dart';
import 'moment_detail_page.dart';

/// 朋友圈列表页面
class MomentListPage extends StatelessWidget {
  const MomentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MomentBloc>()..add(const LoadMoments()),
      child: const _MomentListView(),
    );
  }
}

class _MomentListView extends StatefulWidget {
  const _MomentListView();

  @override
  State<_MomentListView> createState() => _MomentListViewState();
}

class _MomentListViewState extends State<_MomentListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<MomentBloc>().add(const LoadMoreMoments());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = S.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // 顶部封面和头像
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildCoverSection(context, isDark),
            ),
            title: Text(
              s?.commonMoments ?? 'Moments',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.camera_alt_outlined),
                onPressed: () => _openCreateMoment(context),
              ),
            ],
          ),

          // 动态列表
          BlocBuilder<MomentBloc, MomentState>(
            builder: (context, state) {
              if (state.isLoading && state.moments.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state.moments.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          size: 64,
                          color: isDark ? Colors.grey[600] : Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No moments yet',
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index >= state.moments.length) {
                      if (state.isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return const SizedBox.shrink();
                    }

                    return _MomentTile(
                      moment: state.moments[index],
                      isDark: isDark,
                    );
                  },
                  childCount: state.moments.length + (state.hasMore ? 1 : 0),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreateMoment(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCoverSection(BuildContext context, bool isDark) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 封面图片
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      const Color(0xFF2C3E50),
                      const Color(0xFF1A252F),
                    ]
                  : [
                      const Color(0xFF667eea),
                      const Color(0xFF764ba2),
                    ],
            ),
          ),
        ),

        // 用户信息
        Positioned(
          right: 16,
          bottom: 50,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'My Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const N42Avatar(
                  name: 'My Name',
                  size: 64,
                  borderRadius: 6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openCreateMoment(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: context.read<MomentBloc>(),
          child: const CreateMomentPage(),
        ),
      ),
    );
  }
}

/// 单条动态组件
class _MomentTile extends StatelessWidget {
  final MomentEntity moment;
  final bool isDark;

  const _MomentTile({
    required this.moment,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.divider,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像
          N42Avatar(
            name: moment.userName,
            imageUrl: moment.userAvatarUrl,
            size: 44,
          ),

          const SizedBox(width: 12),

          // 内容区域
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 用户名
                Text(
                  moment.userName,
                  style: TextStyle(
                    color: isDark ? Colors.blue[300] : Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                // 文字内容
                if (moment.hasContent) ...[
                  Text(
                    moment.content!,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                // 媒体内容
                if (moment.hasMedia) ...[
                  _buildMediaGrid(context),
                  const SizedBox(height: 8),
                ],

                // 位置信息
                if (moment.hasLocation) ...[
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        moment.location!.displayText,
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],

                // 时间和操作
                Row(
                  children: [
                    Text(
                      moment.formattedTime,
                      style: TextStyle(
                        color: isDark ? Colors.grey[500] : Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    _buildActionButton(context),
                  ],
                ),

                // 点赞和评论
                if (moment.likeCount > 0 || moment.commentCount > 0) ...[
                  const SizedBox(height: 8),
                  _buildLikesAndComments(context),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaGrid(BuildContext context) {
    final mediaCount = moment.media.length;
    final crossAxisCount = mediaCount == 1
        ? 1
        : mediaCount <= 4
            ? 2
            : 3;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: mediaCount > 9 ? 9 : mediaCount,
      itemBuilder: (context, index) {
        final media = moment.media[index];
        return GestureDetector(
          onTap: () => _openMediaViewer(context, index),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (media.httpUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: media.httpUrl!,
                      fit: BoxFit.cover,
                      httpHeaders: _getAuthHeaders(),
                      placeholder: (_, __) => Container(
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                      ),
                      errorWidget: (_, __, ___) => const Icon(Icons.image),
                    ),
                  )
                else
                  const Icon(Icons.image),
                if (media.isVideo)
                  const Center(
                    child: Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                if (index == 8 && mediaCount > 9)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: Text(
                        '+${mediaCount - 9}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_horiz,
        color: isDark ? Colors.grey[400] : Colors.grey[600],
        size: 20,
      ),
      onSelected: (value) {
        switch (value) {
          case 'like':
            if (moment.isLikedByMe) {
              context.read<MomentBloc>().add(UnlikeMoment(moment.id));
            } else {
              context.read<MomentBloc>().add(LikeMoment(moment.id));
            }
            break;
          case 'comment':
            _showCommentDialog(context);
            break;
          case 'delete':
            _showDeleteConfirmation(context);
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'like',
          child: Row(
            children: [
              Icon(
                moment.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(moment.isLikedByMe ? 'Unlike' : 'Like'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'comment',
          child: Row(
            children: [
              Icon(Icons.comment_outlined, size: 20),
              SizedBox(width: 8),
              Text('Comment'),
            ],
          ),
        ),
        if (moment.isFromMe)
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete_outline, size: 20, color: Colors.red),
                SizedBox(width: 8),
                Text('Delete', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildLikesAndComments(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 点赞列表
          if (moment.likeCount > 0) ...[
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  size: 14,
                  color: isDark ? Colors.red[300] : Colors.red,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    moment.likes.map((l) => l.userName).join(', '),
                    style: TextStyle(
                      color: isDark ? Colors.blue[300] : Colors.blue[700],
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (moment.commentCount > 0)
              Divider(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
                height: 16,
              ),
          ],

          // 评论列表
          ...moment.comments.map((comment) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: comment.userName,
                        style: TextStyle(
                          color: isDark ? Colors.blue[300] : Colors.blue[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (comment.isReply) ...[
                        const TextSpan(text: ' reply '),
                        TextSpan(
                          text: comment.replyToUserName,
                          style: TextStyle(
                            color: isDark ? Colors.blue[300] : Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      TextSpan(text: ': ${comment.content}'),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Map<String, String> _getAuthHeaders() {
    final accessToken = MatrixClientManager.instance.client?.accessToken;
    if (accessToken != null && accessToken.isNotEmpty) {
      return {'Authorization': 'Bearer $accessToken'};
    }
    return {};
  }

  void _openMediaViewer(BuildContext context, int index) {
    // TODO: 打开媒体查看器
  }

  void _showCommentDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Comment'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Write a comment...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context.read<MomentBloc>().add(CommentMoment(
                      momentId: moment.id,
                      content: controller.text.trim(),
                    ));
                Navigator.pop(ctx);
              }
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Moment'),
        content: const Text('Are you sure you want to delete this moment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<MomentBloc>().add(DeleteMoment(moment.id));
              Navigator.pop(ctx);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
