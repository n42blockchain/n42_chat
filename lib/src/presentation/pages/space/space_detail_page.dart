import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/entities/space_entity.dart';

/// 社区详情页面
///
/// 展示社区信息和内部的频道/子 Space 层级结构
class SpaceDetailPage extends StatelessWidget {
  final SpaceEntity space;

  /// 点击频道的回调
  final void Function(SpaceChild child)? onChannelTap;

  /// 加入频道的回调
  final Future<bool> Function(String roomId)? onJoinChannel;

  const SpaceDetailPage({
    super.key,
    required this.space,
    this.onChannelTap,
    this.onJoinChannel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    final channels = space.children
        .where((c) => c.type == SpaceChildType.channel)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));

    final subSpaces = space.children
        .where((c) => c.type == SpaceChildType.subSpace)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: CustomScrollView(
        slivers: [
          // 头部
          _buildHeader(context, isDark),

          // 描述
          if (space.description != null)
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: isDark ? AppColors.surfaceDark : AppColors.surface,
                child: Text(
                  space.description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ),

          // 标签
          if (space.topics.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: isDark ? AppColors.surfaceDark : AppColors.surface,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: space.topics.map((topic) {
                    return Chip(
                      label: Text(topic, style: const TextStyle(fontSize: 12)),
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: isDark
                          ? AppColors.primary.withValues(alpha: 0.2)
                          : AppColors.primary.withValues(alpha: 0.1),
                    );
                  }).toList(),
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // 子 Space 区域
          if (subSpaces.isNotEmpty) ...[
            _buildSectionHeader(
              context,
              isDark,
              icon: Icons.folder_outlined,
              title: S.of(context)?.spacesSubSpaces ?? 'Sub-Communities',
              count: subSpaces.length,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildSubSpaceItem(context, subSpaces[index], isDark),
                childCount: subSpaces.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],

          // 频道区域
          _buildSectionHeader(
            context,
            isDark,
            icon: Icons.tag,
            title: S.of(context)?.spacesChannels ?? 'Channels',
            count: channels.length,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildChannelItem(context, channels[index], isDark),
              childCount: channels.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    final accessToken = MatrixClientManager.instance.client?.accessToken;
    final headers = <String, String>{};
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          space.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (space.avatarUrl != null)
              CachedNetworkImage(
                imageUrl: space.avatarUrl!,
                fit: BoxFit.cover,
                httpHeaders: headers,
                errorWidget: (_, __, ___) => Container(
                  color: AppColorPalettes.getAvatarColor(space.name),
                ),
              )
            else
              Container(
                color: AppColorPalettes.getAvatarColor(space.name),
                child: Center(
                  child: Text(
                    space.name.isNotEmpty ? space.name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            // 渐变覆盖层
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
            ),
            // 成员信息
            Positioned(
              bottom: 56,
              left: 16,
              child: Row(
                children: [
                  const Icon(Icons.people, size: 16, color: Colors.white70),
                  const SizedBox(width: 4),
                  Text(
                    S.of(context)?.spacesMembersCount(space.memberCount) ?? '${space.memberCount} members',
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    space.type == SpaceType.public ? Icons.public : Icons.lock,
                    size: 16,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    space.type == SpaceType.public
                        ? (S.of(context)?.spacesPublic ?? 'Public')
                        : (S.of(context)?.spacesPrivate ?? 'Private'),
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    bool isDark, {
    required IconData icon,
    required String title,
    required int count,
  }) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isDark ? Colors.white54 : AppColors.textSecondary),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white54 : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '($count)',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelItem(BuildContext context, SpaceChild child, bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.tag, color: AppColors.primary, size: 20),
        ),
        title: Text(
          child.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Row(
          children: [
            if (child.description != null) ...[
              Expanded(
                child: Text(
                  child.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
            Text(
              S.of(context)?.spacesMembersCount(child.memberCount) ?? '${child.memberCount} members',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
          ],
        ),
        trailing: child.isSuggested
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  S.of(context)?.spacesSuggested ?? 'Suggested',
                  style: const TextStyle(fontSize: 10, color: Colors.green),
                ),
              )
            : Icon(
                Icons.chevron_right,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
        onTap: () => onChannelTap?.call(child),
      ),
    );
  }

  Widget _buildSubSpaceItem(BuildContext context, SpaceChild child, bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.purple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.folder_outlined, color: Colors.purple, size: 20),
        ),
        title: Text(
          child.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: child.description != null
            ? Text(
                child.description!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                ),
              )
            : null,
        trailing: Icon(
          Icons.chevron_right,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
        onTap: () {
          // 进入子 Space
        },
      ),
    );
  }
}
