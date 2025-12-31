import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 微信风格头像组件
///
/// 特点：
/// - 圆角方形（微信风格）
/// - 支持网络图片、本地图片、默认头像
/// - 支持显示名字首字母
/// - 支持在线状态指示器
/// - 支持群组九宫格头像
class N42Avatar extends StatelessWidget {
  /// 头像URL
  final String? imageUrl;

  /// 显示名称（用于生成首字母头像）
  final String? name;

  /// 头像大小
  final double size;

  /// 圆角半径
  final double borderRadius;

  /// 是否显示在线状态
  final bool showOnlineStatus;

  /// 是否在线
  final bool isOnline;

  /// 背景色（默认头像时使用）
  final Color? backgroundColor;

  /// 点击回调
  final VoidCallback? onTap;

  /// 本地图片路径
  final String? localImagePath;

  /// 占位图标
  final IconData placeholderIcon;

  const N42Avatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = 48,
    this.borderRadius = 4,
    this.showOnlineStatus = false,
    this.isOnline = false,
    this.backgroundColor,
    this.onTap,
    this.localImagePath,
    this.placeholderIcon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          _buildAvatar(),
          if (showOnlineStatus) _buildOnlineIndicator(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? _getDefaultColor(),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    // 优先显示网络图片
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildDefaultAvatar(),
      );
    }

    // 本地图片
    if (localImagePath != null && localImagePath!.isNotEmpty) {
      return Image.asset(
        localImagePath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
      );
    }

    // 显示名称首字母
    if (name != null && name!.isNotEmpty) {
      return _buildInitialsAvatar();
    }

    // 默认头像
    return _buildDefaultAvatar();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.placeholder,
      child: Center(
        child: SizedBox(
          width: size * 0.4,
          height: size * 0.4,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: backgroundColor ?? AppColors.placeholder,
      child: Icon(
        placeholderIcon,
        size: size * 0.5,
        color: Colors.white.withValues(alpha: 0.8),
      ),
    );
  }

  Widget _buildInitialsAvatar() {
    final initials = _getInitials(name!);
    return Container(
      color: backgroundColor ?? _getColorFromName(name!),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildOnlineIndicator() {
    final indicatorSize = size * 0.25;
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        width: indicatorSize,
        height: indicatorSize,
        decoration: BoxDecoration(
          color: isOnline ? AppColors.online : AppColors.offline,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  Color _getDefaultColor() {
    return AppColors.placeholder;
  }

  Color _getColorFromName(String name) {
    // 根据名称生成固定颜色
    final colors = [
      const Color(0xFF1AAD19), // 绿
      const Color(0xFF576B95), // 蓝
      const Color(0xFFFA9D3B), // 橙
      const Color(0xFFE64340), // 红
      const Color(0xFF9B59B6), // 紫
      const Color(0xFF3498DB), // 浅蓝
      const Color(0xFF1ABC9C), // 青
      const Color(0xFFF39C12), // 黄
    ];

    final index = name.codeUnits.fold<int>(0, (sum, c) => sum + c) % colors.length;
    return colors[index];
  }
}

/// 群组头像（九宫格样式）
class N42GroupAvatar extends StatelessWidget {
  /// 成员头像URL列表（最多显示9个）
  final List<String?> memberAvatars;

  /// 成员名称列表（用于生成默认头像）
  final List<String>? memberNames;

  /// 头像大小
  final double size;

  /// 圆角半径
  final double borderRadius;

  /// 点击回调
  final VoidCallback? onTap;

  const N42GroupAvatar({
    super.key,
    required this.memberAvatars,
    this.memberNames,
    this.size = 48,
    this.borderRadius = 4,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.placeholder,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: _buildGrid(),
      ),
    );
  }

  Widget _buildGrid() {
    final count = memberAvatars.length.clamp(1, 9);
    final columns = count <= 1 ? 1 : (count <= 4 ? 2 : 3);
    final itemSize = size / columns - 1;

    return Wrap(
      spacing: 1,
      runSpacing: 1,
      children: List.generate(count.clamp(0, 9), (index) {
        final avatarUrl = index < memberAvatars.length ? memberAvatars[index] : null;
        final name = memberNames != null && index < memberNames!.length
            ? memberNames![index]
            : null;

        return SizedBox(
          width: itemSize,
          height: itemSize,
          child: N42Avatar(
            imageUrl: avatarUrl,
            name: name,
            size: itemSize,
            borderRadius: 0,
          ),
        );
      }),
    );
  }
}

