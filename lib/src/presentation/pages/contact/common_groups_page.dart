import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/group_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 共同群组页面
///
/// 显示当前用户与指定用户的共同群组列表
class CommonGroupsPage extends StatefulWidget {
  /// 目标用户ID
  final String userId;

  /// 目标用户显示名称
  final String displayName;

  /// 群组点击回调
  final void Function(GroupEntity group)? onGroupTap;

  const CommonGroupsPage({
    super.key,
    required this.userId,
    required this.displayName,
    this.onGroupTap,
  });

  @override
  State<CommonGroupsPage> createState() => _CommonGroupsPageState();
}

class _CommonGroupsPageState extends State<CommonGroupsPage> {
  List<GroupEntity>? _groups;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCommonGroups();
  }

  Future<void> _loadCommonGroups() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    // TODO: implement getCommonGroups in IGroupRepository
    if (mounted) {
      setState(() {
        _groups = [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;
    final cardColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryTextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0,
        title: Text(
          S.of(context)?.contactCommonGroups ?? 'Groups in common',
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
      ),
      body: _buildBody(cardColor, textColor, secondaryTextColor),
    );
  }

  Widget _buildBody(Color cardColor, Color textColor, Color secondaryTextColor) {
    if (_isLoading) {
      return Center(
        child: N42Loading(message: S.of(context)?.commonLoading ?? 'Loading...'),
      );
    }

    if (_error != null) {
      return Center(
        child: N42EmptyState.error(
          title: S.of(context)?.commonLoadFailed ?? 'Load failed',
          description: _error,
          buttonText: S.of(context)?.commonRetry ?? 'Retry',
          onButtonPressed: _loadCommonGroups,
        ),
      );
    }

    if (_groups == null || _groups!.isEmpty) {
      return Center(
        child: N42EmptyState.noData(
          title: S.of(context)?.contactNoCommonGroups ?? 'No common groups',
          description: S.of(context)?.contactNoCommonGroupsDescription ??
              'You don\'t have any groups in common',
        ),
      );
    }

    return ListView.builder(
      itemCount: _groups!.length,
      itemBuilder: (context, index) {
        final group = _groups![index];
        return _buildGroupTile(group, cardColor, textColor, secondaryTextColor);
      },
    );
  }

  Widget _buildGroupTile(
    GroupEntity group,
    Color cardColor,
    Color textColor,
    Color secondaryTextColor,
  ) {
    return Container(
      color: cardColor,
      child: ListTile(
        leading: _buildGroupAvatar(group),
        title: Text(
          group.name,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          S.of(context)?.commonMemberCount(group.memberCount) ??
              '${group.memberCount} members',
          style: TextStyle(
            color: secondaryTextColor,
            fontSize: 13,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: secondaryTextColor,
          size: 20,
        ),
        onTap: () {
          if (widget.onGroupTap != null) {
            widget.onGroupTap!(group);
          } else {
            Navigator.pop(context, group);
          }
        },
      ),
    );
  }

  Widget _buildGroupAvatar(GroupEntity group) {
    if (group.avatarUrl != null && group.avatarUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          group.avatarUrl!,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildDefaultAvatar(group.name),
        ),
      );
    }
    return _buildDefaultAvatar(group.name);
  }

  Widget _buildDefaultAvatar(String name) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColorPalettes.getAvatarColor(name),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
