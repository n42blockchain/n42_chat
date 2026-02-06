import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/group_album_entity.dart';
import '../../blocs/group_album/group_album_bloc.dart';
import '../../blocs/group_album/group_album_event.dart';
import '../../blocs/group_album/group_album_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 群相册页面
class GroupAlbumPage extends StatelessWidget {
  final String roomId;
  final String groupName;

  const GroupAlbumPage({
    super.key,
    required this.roomId,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupAlbumBloc()
        ..add(LoadGroupAlbum(roomId: roomId)),
      child: _GroupAlbumView(groupName: groupName),
    );
  }
}

class _GroupAlbumView extends StatefulWidget {
  final String groupName;

  const _GroupAlbumView({required this.groupName});

  @override
  State<_GroupAlbumView> createState() => _GroupAlbumViewState();
}

class _GroupAlbumViewState extends State<_GroupAlbumView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      final bloc = context.read<GroupAlbumBloc>();
      switch (_tabController.index) {
        case 0:
          bloc.add(const ChangeAlbumFilter(AlbumFilter.none));
          break;
        case 1:
          bloc.add(const ChangeAlbumFilter(AlbumFilter.imagesOnly));
          break;
        case 2:
          bloc.add(const ChangeAlbumFilter(AlbumFilter.videosOnly));
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;
    final cardColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0,
        title: Text(
          S.of(context)?.groupAlbum ?? 'Group Album',
          style: TextStyle(
            color: textColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: [
            Tab(text: S.of(context)?.commonAll ?? 'All'),
            Tab(text: S.of(context)?.groupImages ?? 'Images'),
            Tab(text: S.of(context)?.groupVideos ?? 'Videos'),
          ],
        ),
      ),
      body: BlocBuilder<GroupAlbumBloc, GroupAlbumState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: N42Loading(message: S.of(context)?.commonLoading ?? 'Loading...'),
            );
          }

          if (state.error != null) {
            return Center(
              child: N42EmptyState.error(
                title: S.of(context)?.commonLoadFailed ?? 'Load failed',
                description: state.error,
                buttonText: S.of(context)?.commonRetry ?? 'Retry',
                onButtonPressed: () {
                  context.read<GroupAlbumBloc>().add(const RefreshGroupAlbum());
                },
              ),
            );
          }

          final filteredGroups = state.filteredDateGroups;
          if (filteredGroups.isEmpty) {
            return Center(
              child: N42EmptyState.noData(
                title: S.of(context)?.groupNoMedia ?? 'No media',
                description: S.of(context)?.groupNoMediaDescription ??
                    'No photos or videos in this group yet',
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<GroupAlbumBloc>().add(const RefreshGroupAlbum());
            },
            child: CustomScrollView(
              slivers: [
                // 统计信息
                SliverToBoxAdapter(
                  child: _buildStats(context, state),
                ),
                // 按日期分组显示
                ...filteredGroups.map((group) => _buildDateGroup(context, group)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStats(BuildContext context, GroupAlbumState state) {
    final stats = state.stats;
    final isDark = context.isDarkMode;
    final textColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            '${stats.totalCount}',
            S.of(context)?.groupTotal ?? 'Total',
            textColor,
          ),
          _buildStatItem(
            context,
            '${stats.imageCount}',
            S.of(context)?.groupImages ?? 'Images',
            textColor,
          ),
          _buildStatItem(
            context,
            '${stats.videoCount}',
            S.of(context)?.groupVideos ?? 'Videos',
            textColor,
          ),
          _buildStatItem(
            context,
            stats.formattedTotalSize,
            S.of(context)?.groupSize ?? 'Size',
            textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    Color textColor,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDateGroup(BuildContext context, AlbumDateGroup group) {
    final isDark = context.isDarkMode;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 日期标题
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              group.displayTitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
          // 媒体网格
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: group.media.length,
              itemBuilder: (context, index) {
                final media = group.media[index];
                return _buildMediaItem(context, media);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaItem(BuildContext context, AlbumMediaEntity media) {
    return GestureDetector(
      onTap: () => _viewMedia(context, media),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 缩略图
          CachedNetworkImage(
            imageUrl: media.thumbnailUrl ?? media.httpUrl ?? '',
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              color: Colors.grey[300],
              child: const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
            errorWidget: (_, __, ___) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image, color: Colors.grey),
            ),
          ),
          // 视频标识
          if (media.isVideo)
            Positioned(
              right: 4,
              bottom: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.play_arrow, color: Colors.white, size: 12),
                    if (media.formattedDuration != null) ...[
                      const SizedBox(width: 2),
                      Text(
                        media.formattedDuration!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _viewMedia(BuildContext context, AlbumMediaEntity media) {
    // TODO: 实现媒体预览
    debugPrint('View media: ${media.eventId}');
  }
}
