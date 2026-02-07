import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';

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

  /// 是否是 View Once（阅后即焚）消息
  final bool isViewOnce;

  /// View Once 消息是否已过期
  final bool isExpired;

  /// View Once 消息是否已查看
  final bool isViewed;

  /// 是否是自己发送的
  final bool isFromMe;

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
    this.isViewOnce = false,
    this.isExpired = false,
    this.isViewed = false,
    this.isFromMe = false,
  });

  @override
  State<ImageMessageWidget> createState() => _ImageMessageWidgetState();
}

class _ImageMessageWidgetState extends State<ImageMessageWidget> {
  int _retryCount = 0;
  static const int _maxRetries = 3;

  /// 将 mxc:// URL 转换为 HTTP URL
  String? _convertMxcToHttp(String? mxcUrl) {
    if (mxcUrl == null || mxcUrl.isEmpty) return null;

    // 如果已经是 HTTP URL，直接返回
    if (mxcUrl.startsWith('http://') || mxcUrl.startsWith('https://')) {
      return mxcUrl;
    }

    // 如果不是 mxc:// URL，返回 null
    if (!mxcUrl.startsWith('mxc://')) {
      debugPrint('ImageMessageWidget: Invalid URL format: $mxcUrl');
      return null;
    }

    try {
      final client = MatrixClientManager.instance.client;
      if (client == null) {
        debugPrint('ImageMessageWidget: Client is null, cannot convert mxc URL');
        return null;
      }

      final homeserver = client.homeserver?.toString().replaceAll(RegExp(r'/$'), '') ?? '';
      if (homeserver.isEmpty) {
        debugPrint('ImageMessageWidget: No homeserver configured');
        return null;
      }

      // 解析 mxc://server/mediaId
      final uri = Uri.parse(mxcUrl);
      final serverName = uri.host;
      final mediaId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';

      if (serverName.isEmpty || mediaId.isEmpty) {
        debugPrint('ImageMessageWidget: Invalid mxc URL format: $mxcUrl');
        return null;
      }

      // 构建认证媒体 URL (Matrix 1.11+)
      final httpUrl = '$homeserver/_matrix/client/v1/media/download/$serverName/$mediaId';
      debugPrint('ImageMessageWidget: Converted mxc URL to: $httpUrl');
      return httpUrl;
    } catch (e) {
      debugPrint('ImageMessageWidget: Error converting mxc URL: $e');
      return null;
    }
  }

  String get _effectiveUrl {
    // 获取原始 URL
    var url = widget.thumbnailUrl ?? widget.imageUrl;

    // 如果是 mxc:// URL，转换为 HTTP URL
    if (url.startsWith('mxc://')) {
      final httpUrl = _convertMxcToHttp(url);
      if (httpUrl != null) {
        url = httpUrl;
      } else {
        // 转换失败，返回空字符串触发错误状态
        debugPrint('ImageMessageWidget: Failed to convert mxc URL, will show error state');
        return '';
      }
    }

    // 添加时间戳以强制刷新（仅在重试时）
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

    // View Once 消息特殊显示
    if (widget.isViewOnce && !widget.isFromMe) {
      return _buildViewOnceOverlay(context, size);
    }

    final url = _effectiveUrl;

    // 如果 URL 为空，显示占位符
    if (url.isEmpty) {
      return _buildError(size);
    }

    // 获取认证头（用于需要认证的 Matrix 媒体）
    final accessToken = MatrixClientManager.instance.client?.accessToken;
    final headers = <String, String>{};
    if (accessToken != null && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    Widget imageWidget = GestureDetector(
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
            httpHeaders: headers,
            fadeInDuration: const Duration(milliseconds: 200),
            fadeOutDuration: const Duration(milliseconds: 200),
            placeholder: (context, url) => _buildPlaceholder(size),
            errorWidget: (context, url, error) {
              debugPrint('ImageMessageWidget: Failed to load image: $url, error: $error');
              return _buildError(size, canRetry: _retryCount < _maxRetries);
            },
          ),
        ),
      ),
    );

    // 发送方的 View Once 消息显示标记
    if (widget.isViewOnce && widget.isFromMe) {
      imageWidget = Stack(
        children: [
          imageWidget,
          Positioned(
            left: 6,
            bottom: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer, size: 12, color: Colors.white),
                  const SizedBox(width: 3),
                  Text(
                    S.of(context)?.chatViewOnce ?? 'View Once',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return imageWidget;
  }

  /// View Once 消息蒙版（接收方）
  Widget _buildViewOnceOverlay(BuildContext context, Size size) {
    final s = S.of(context);

    // 已过期或已查看
    if (widget.isExpired || widget.isViewed) {
      return GestureDetector(
        onTap: null, // 已过期/已查看不可再点击
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Container(
            width: size.width,
            height: size.height * 0.6,
            color: AppColors.placeholder,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.isExpired ? Icons.timer_off : Icons.visibility,
                    color: AppColors.textTertiary,
                    size: 28,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.isExpired
                        ? (s?.chatViewOnceExpired ?? 'Expired')
                        : (s?.chatViewOnceViewed ?? 'Viewed'),
                    style: const TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // 未查看 — 模糊蒙版
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          width: size.width,
          height: size.height * 0.6,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[400]!,
                Colors.grey[600]!,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  s?.chatViewOncePhoto ?? 'View Once Photo',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  s?.chatViewOnceTap ?? 'Tap to view',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
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
                Text(
                  S.of(context)?.commonTapToRetry ?? 'Tap to retry',
                  style: const TextStyle(
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

  /// 将 mxc:// URL 转换为 HTTP URL
  String _convertMxcToHttp(String url) {
    // 如果已经是 HTTP URL，直接返回
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }

    // 如果不是 mxc:// URL，返回原始 URL
    if (!url.startsWith('mxc://')) {
      return url;
    }

    try {
      final client = MatrixClientManager.instance.client;
      if (client == null) return url;

      final homeserver = client.homeserver?.toString().replaceAll(RegExp(r'/$'), '') ?? '';
      if (homeserver.isEmpty) return url;

      // 解析 mxc://server/mediaId
      final uri = Uri.parse(url);
      final serverName = uri.host;
      final mediaId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';

      if (serverName.isEmpty || mediaId.isEmpty) return url;

      // 构建认证媒体 URL (Matrix 1.11+)
      return '$homeserver/_matrix/client/v1/media/download/$serverName/$mediaId';
    } catch (e) {
      debugPrint('ImageGridWidget: Error converting mxc URL: $e');
      return url;
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayImages = images.take(maxCount).toList();
    final columns = _getColumns(displayImages.length);
    final itemSize = (200 - spacing * (columns - 1)) / columns;

    // 获取认证头（用于需要认证的 Matrix 媒体）
    final accessToken = MatrixClientManager.instance.client?.accessToken;
    final headers = <String, String>{};
    if (accessToken != null && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return SizedBox(
      width: 200,
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: List.generate(displayImages.length, (index) {
          final image = displayImages[index];
          final isLast = index == maxCount - 1 && images.length > maxCount;
          // 获取图片 URL，确保转换 mxc:// URL
          final imageUrl = _convertMxcToHttp(image.thumbnailUrl ?? image.url);

          return GestureDetector(
            onTap: () => onTap?.call(index),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: itemSize,
                    height: itemSize,
                    fit: BoxFit.cover,
                    httpHeaders: headers,
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

