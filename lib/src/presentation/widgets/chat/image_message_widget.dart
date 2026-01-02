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
/// - 错误重试
class ImageMessageWidget extends StatefulWidget {
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
  State<ImageMessageWidget> createState() => _ImageMessageWidgetState();
}

class _ImageMessageWidgetState extends State<ImageMessageWidget> {
  int _retryCount = 0;
  static const int _maxRetries = 3;

  String get _effectiveUrl {
    // 添加时间戳以强制刷新（仅在重试时）
    final url = widget.thumbnailUrl ?? widget.imageUrl;
    if (_retryCount > 0 && url.isNotEmpty) {
      final separator = url.contains('?') ? '&' : '?';
      return '$url${separator}_retry=$_retryCount';
    }
    return url;
  }

  void _retry() {
    if (_retryCount < _maxRetries) {
      setState(() {
        _retryCount++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = _calculateSize();
    final url = _effectiveUrl;

    // 如果 URL 为空，显示占位符
    if (url.isEmpty) {
      return _buildError(size);
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: CachedNetworkImage(
            key: ValueKey('$url-$_retryCount'),
            imageUrl: url,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 200),
            fadeOutDuration: const Duration(milliseconds: 200),
            placeholder: (context, url) => _buildPlaceholder(size),
            errorWidget: (context, url, error) => _buildError(size, canRetry: _retryCount < _maxRetries),
          ),
        ),
      ),
    );
  }

  Size _calculateSize() {
    if (widget.width == null || widget.height == null || widget.width == 0 || widget.height == 0) {
      // 未知尺寸，使用默认正方形
      return Size(widget.minSize, widget.minSize);
    }

    final aspectRatio = widget.width! / widget.height!;
    double w, h;

    if (aspectRatio > 1) {
      // 横图
      w = widget.maxWidth;
      h = w / aspectRatio;
      if (h < widget.minSize) {
        h = widget.minSize;
        w = h * aspectRatio;
      }
    } else {
      // 竖图或方图
      h = widget.maxHeight;
      w = h * aspectRatio;
      if (w < widget.minSize) {
        w = widget.minSize;
        h = w / aspectRatio;
      }
    }

    return Size(w.clamp(widget.minSize, widget.maxWidth), h.clamp(widget.minSize, widget.maxHeight));
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

  Widget _buildError(Size size, {bool canRetry = false}) {
    return GestureDetector(
      onTap: canRetry ? _retry : null,
      child: Container(
        width: size.width,
        height: size.height,
        color: AppColors.placeholder,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.broken_image,
                color: AppColors.textTertiary,
                size: 32,
              ),
              if (canRetry) ...[
                const SizedBox(height: 8),
                const Text(
                  '点击重试',
                  style: TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
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

