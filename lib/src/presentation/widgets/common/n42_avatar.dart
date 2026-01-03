import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';

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
      // 获取认证头（用于需要认证的 Matrix 媒体）
      final accessToken = MatrixClientManager.instance.client?.accessToken;
      final headers = <String, String>{};
      if (accessToken != null && accessToken.isNotEmpty) {
        headers['Authorization'] = 'Bearer $accessToken';
      }
      
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        httpHeaders: headers,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) {
          debugPrint('N42Avatar: Failed to load image: $url, error: $error');
          return _buildDefaultAvatar();
        },
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

/// 群组头像（微信风格九宫格样式）
/// 
/// 布局规则：
/// - 1人：居中显示
/// - 2人：水平并排
/// - 3人：上1下2
/// - 4人：2x2网格
/// - 5人：上2下3
/// - 6人：上2中2下2
/// - 7人：上1中3下3
/// - 8人：上2中3下3
/// - 9人：3x3网格
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
  
  /// 背景色
  final Color? backgroundColor;
  
  /// 间距
  final double spacing;

  const N42GroupAvatar({
    super.key,
    required this.memberAvatars,
    this.memberNames,
    this.size = 48,
    this.borderRadius = 4,
    this.onTap,
    this.backgroundColor,
    this.spacing = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xFFE8E8E8), // 微信灰色背景
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.all(spacing),
        child: _buildWeChatGrid(),
      ),
    );
  }

  /// 构建微信风格的九宫格布局
  Widget _buildWeChatGrid() {
    final count = memberAvatars.length.clamp(1, 9);
    final innerSize = size - spacing * 2;
    
    // 根据人数计算布局
    final layout = _getLayout(count);
    final rows = layout.length;
    final itemSize = (innerSize - spacing * (rows - 1)) / rows;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(rows, (rowIndex) {
        final rowItems = layout[rowIndex];
        final rowWidth = rowItems * itemSize + (rowItems - 1) * spacing;
        
        return Padding(
          padding: EdgeInsets.only(top: rowIndex > 0 ? spacing : 0),
          child: SizedBox(
            width: innerSize,
            height: itemSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(rowItems, (colIndex) {
                final index = _getAvatarIndex(layout, rowIndex, colIndex);
                if (index >= count) return const SizedBox.shrink();
                
                final avatarUrl = index < memberAvatars.length ? memberAvatars[index] : null;
                final name = memberNames != null && index < memberNames!.length
                    ? memberNames![index]
                    : null;
                
                return Padding(
                  padding: EdgeInsets.only(left: colIndex > 0 ? spacing : 0),
                  child: SizedBox(
                    width: itemSize,
                    height: itemSize,
                    child: N42Avatar(
                      imageUrl: avatarUrl,
                      name: name,
                      size: itemSize,
                      borderRadius: 2,
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      }),
    );
  }

  /// 获取每行的成员数量布局
  /// 返回一个列表，每个元素表示该行的成员数
  List<int> _getLayout(int count) {
    switch (count) {
      case 1:
        return [1];
      case 2:
        return [2];
      case 3:
        return [1, 2];
      case 4:
        return [2, 2];
      case 5:
        return [2, 3];
      case 6:
        return [3, 3];
      case 7:
        return [1, 3, 3];
      case 8:
        return [2, 3, 3];
      case 9:
      default:
        return [3, 3, 3];
    }
  }

  /// 根据行列索引获取成员在 memberAvatars 中的索引
  int _getAvatarIndex(List<int> layout, int rowIndex, int colIndex) {
    int index = 0;
    for (int i = 0; i < rowIndex; i++) {
      index += layout[i];
    }
    return index + colIndex;
  }
}

