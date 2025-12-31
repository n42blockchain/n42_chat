import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 图片消息组件
///
/// 特点：
/// - 自适应尺寸
/// - 加载进度
/// - 点击查看大图
/// - 支持长图预览
class ImageMessageWidget extends StatelessWidget {
  /// 图片URL
  final String imageUrl;

  /// 缩略图URL
  final String? thumbnailUrl;

  /// 图片宽度
  final int? width;

  /// 图片高度
  final int? height;

  /// 点击回调
  final VoidCallback? onTap;

  /// 最大宽度
  final double maxWidth;

  /// 最大高度
  final double maxHeight;

  /// 最小尺寸
  final double minSize;

  /// 圆角
  final double borderRadius;

  const ImageMessageWidget({
    super.key,
    required this.imageUrl,
    this.thumbnailUrl,
    this.width,
    this.height,
    this.onTap,
    this.maxWidth = 200,
    this.maxHeight = 300,
    this.minSize = 100,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    final size = _calculateSize();

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: CachedNetworkImage(
            imageUrl: thumbnailUrl ?? imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => _buildPlaceholder(size),
            errorWidget: (context, url, error) => _buildError(size),
          ),
        ),
      ),
    );
  }

  Size _calculateSize() {
    if (width == null || height == null || width == 0 || height == 0) {
      // 未知尺寸，使用默认正方形
      return Size(minSize, minSize);
    }

    final aspectRatio = width! / height!;
    double w, h;

    if (aspectRatio > 1) {
      // 横图
      w = maxWidth;
      h = w / aspectRatio;
      if (h < minSize) {
        h = minSize;
        w = h * aspectRatio;
      }
    } else {
      // 竖图或方图
      h = maxHeight;
      w = h * aspectRatio;
      if (w < minSize) {
        w = minSize;
        h = w / aspectRatio;
      }
    }

    return Size(w.clamp(minSize, maxWidth), h.clamp(minSize, maxHeight));
  }

  Widget _buildPlaceholder(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      color: AppColors.placeholder,
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildError(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      color: AppColors.placeholder,
      child: const Center(
        child: Icon(
          Icons.broken_image,
          color: AppColors.textTertiary,
          size: 32,
        ),
      ),
    );
  }
}

/// 多图消息组件（九宫格）
class ImageGridWidget extends StatelessWidget {
  /// 图片列表
  final List<ImageInfo> images;

  /// 点击回调
  final void Function(int index)? onTap;

  /// 网格间距
  final double spacing;

  /// 最大显示数量
  final int maxCount;

  const ImageGridWidget({
    super.key,
    required this.images,
    this.onTap,
    this.spacing = 4,
    this.maxCount = 9,
  });

  @override
  Widget build(BuildContext context) {
    final displayImages = images.take(maxCount).toList();
    final columns = _getColumns(displayImages.length);
    final itemSize = (200 - spacing * (columns - 1)) / columns;

    return SizedBox(
      width: 200,
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: List.generate(displayImages.length, (index) {
          final image = displayImages[index];
          final isLast = index == maxCount - 1 && images.length > maxCount;

          return GestureDetector(
            onTap: () => onTap?.call(index),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: image.thumbnailUrl ?? image.url,
                    width: itemSize,
                    height: itemSize,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: itemSize,
                      height: itemSize,
                      color: AppColors.placeholder,
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: itemSize,
                      height: itemSize,
                      color: AppColors.placeholder,
                      child: const Icon(
                        Icons.broken_image,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
                // 显示更多数量
                if (isLast)
                  Container(
                    width: itemSize,
                    height: itemSize,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '+${images.length - maxCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  int _getColumns(int count) {
    if (count <= 1) return 1;
    if (count <= 4) return 2;
    return 3;
  }
}

/// 图片信息
class ImageInfo {
  final String url;
  final String? thumbnailUrl;
  final int? width;
  final int? height;

  const ImageInfo({
    required this.url,
    this.thumbnailUrl,
    this.width,
    this.height,
  });
}

