import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import 'group_album_page.dart';
import 'group_files_page.dart';

/// 群媒体中心页面
///
/// 统一入口：相册 | 文件 | 链接
class GroupMediaHubPage extends StatefulWidget {
  final String roomId;
  final String groupName;
  final int initialTab;

  const GroupMediaHubPage({
    super.key,
    required this.roomId,
    required this.groupName,
    this.initialTab = 0,
  });

  @override
  State<GroupMediaHubPage> createState() => _GroupMediaHubPageState();
}

class _GroupMediaHubPageState extends State<GroupMediaHubPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTab,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          S.of(context)?.groupChatFiles ?? 'Chat Files',
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
          unselectedLabelColor:
              isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: [
            Tab(text: S.of(context)?.groupAlbum ?? 'Album'),
            Tab(text: S.of(context)?.groupFiles ?? 'Files'),
            Tab(text: S.of(context)?.groupLinks ?? 'Links'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 相册 Tab
          GroupAlbumPage(
            roomId: widget.roomId,
            groupName: widget.groupName,
            embedded: true,
          ),
          // 文件 Tab
          GroupFilesPage(
            roomId: widget.roomId,
            groupName: widget.groupName,
            embedded: true,
          ),
          // 链接 Tab
          _LinksTab(roomId: widget.roomId),
        ],
      ),
    );
  }
}

/// 链接 Tab
class _LinksTab extends StatelessWidget {
  final String roomId;

  const _LinksTab({required this.roomId});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.link,
            size: 48,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context)?.groupNoLinks ?? 'No links',
            style: TextStyle(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
