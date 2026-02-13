import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/entities/space_entity.dart';
import '../../widgets/common/common_widgets.dart';
import 'space_detail_page.dart';

/// 社区/Space 列表页面
///
/// 展示用户已加入的所有 Space（社区）和可发现的公共 Space
class SpaceListPage extends StatefulWidget {
  /// 已加入的 Space 列表
  final List<SpaceEntity> joinedSpaces;

  /// 发现的公共 Space 列表
  final List<SpaceEntity> publicSpaces;

  /// 加入 Space 回调
  final Future<bool> Function(String spaceId)? onJoinSpace;

  /// 创建 Space 回调
  final VoidCallback? onCreateSpace;

  const SpaceListPage({
    super.key,
    this.joinedSpaces = const [],
    this.publicSpaces = const [],
    this.onJoinSpace,
    this.onCreateSpace,
  });

  @override
  State<SpaceListPage> createState() => _SpaceListPageState();
}

class _SpaceListPageState extends State<SpaceListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: S.of(context)?.spacesTitle ?? 'Communities',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: widget.onCreateSpace,
            tooltip: S.of(context)?.spacesCreate ?? 'Create Community',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(text: S.of(context)?.spacesJoined ?? 'Joined'),
                Tab(text: S.of(context)?.spacesDiscover ?? 'Discover'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildJoinedList(isDark),
                _buildDiscoverList(isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinedList(bool isDark) {
    if (widget.joinedSpaces.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.groups_outlined, size: 64, color: isDark ? Colors.white24 : Colors.black26),
            const SizedBox(height: 16),
            Text(
              S.of(context)?.spacesNoJoined ?? 'No communities joined yet',
              style: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => _tabController.animateTo(1),
              icon: const Icon(Icons.explore),
              label: Text(S.of(context)?.spacesExplore ?? 'Explore Communities'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.joinedSpaces.length,
      itemBuilder: (context, index) {
        return _buildSpaceItem(widget.joinedSpaces[index], isDark, showJoinButton: false);
      },
    );
  }

  Widget _buildDiscoverList(bool isDark) {
    if (widget.publicSpaces.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.explore_outlined, size: 64, color: isDark ? Colors.white24 : Colors.black26),
            const SizedBox(height: 16),
            Text(
              S.of(context)?.spacesNoPublic ?? 'No public communities found',
              style: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.publicSpaces.length,
      itemBuilder: (context, index) {
        return _buildSpaceItem(widget.publicSpaces[index], isDark, showJoinButton: true);
      },
    );
  }

  Widget _buildSpaceItem(SpaceEntity space, bool isDark, {required bool showJoinButton}) {
    final accessToken = MatrixClientManager.instance.client?.accessToken;
    final headers = <String, String>{};
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColorPalettes.getAvatarColor(space.name),
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: space.avatarUrl != null
            ? CachedNetworkImage(
                imageUrl: space.avatarUrl!,
                fit: BoxFit.cover,
                httpHeaders: headers,
                errorWidget: (_, _, _) => _buildSpaceIcon(space),
              )
            : _buildSpaceIcon(space),
      ),
      title: Text(
        space.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : AppColors.textPrimary,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (space.description != null)
            Text(
              space.description!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
            ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.people_outline, size: 14, color: isDark ? Colors.white38 : Colors.black38),
              const SizedBox(width: 4),
              Text(
                '${space.memberCount}',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.tag, size: 14, color: isDark ? Colors.white38 : Colors.black38),
              const SizedBox(width: 4),
              Text(
                S.of(context)?.spacesChannelsCount(space.channelCount) ?? '${space.channelCount} channels',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: showJoinButton && !space.isJoined
          ? TextButton(
              onPressed: () async {
                if (widget.onJoinSpace != null) {
                  await widget.onJoinSpace!(space.id);
                }
              },
              child: Text(S.of(context)?.spacesJoin ?? 'Join'),
            )
          : Icon(
              Icons.chevron_right,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SpaceDetailPage(space: space),
          ),
        );
      },
    );
  }

  Widget _buildSpaceIcon(SpaceEntity space) {
    return Center(
      child: Text(
        space.name.isNotEmpty ? space.name[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
