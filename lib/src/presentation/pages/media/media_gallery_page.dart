import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/entities/media_folder_entity.dart';
import '../../../domain/entities/message_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 媒体画廊页面
///
/// 展示某个房间内所有分享的媒体文件
/// 支持按类型过滤（图片、视频、文件、音频）
/// 按日期分组展示
class MediaGalleryPage extends StatefulWidget {
  /// 房间名称
  final String roomName;

  /// 房间 ID
  final String roomId;

  /// 所有媒体消息（由外部传入）
  final List<MessageEntity> mediaMessages;

  const MediaGalleryPage({
    super.key,
    required this.roomName,
    required this.roomId,
    this.mediaMessages = const [],
  });

  @override
  State<MediaGalleryPage> createState() => _MediaGalleryPageState();
}

class _MediaGalleryPageState extends State<MediaGalleryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  MediaFilterType _currentFilter = MediaFilterType.all;

  static const _filters = [
    MediaFilterType.all,
    MediaFilterType.images,
    MediaFilterType.videos,
    MediaFilterType.files,
    MediaFilterType.audio,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _filters.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _currentFilter = _filters[_tabController.index]);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<MessageEntity> get _filteredMessages {
    switch (_currentFilter) {
      case MediaFilterType.all:
        return widget.mediaMessages;
      case MediaFilterType.images:
        return widget.mediaMessages.where((m) => m.type == MessageType.image).toList();
      case MediaFilterType.videos:
        return widget.mediaMessages.where((m) => m.type == MessageType.video).toList();
      case MediaFilterType.files:
        return widget.mediaMessages.where((m) => m.type == MessageType.file).toList();
      case MediaFilterType.audio:
        return widget.mediaMessages
            .where((m) => m.type == MessageType.audio || m.type == MessageType.voice)
            .toList();
    }
  }

  List<MediaDateGroup> get _groupedByDate {
    final messages = _filteredMessages;
    final groups = <String, List<MessageEntity>>{};

    for (final msg in messages) {
      final key = DateFormat('yyyy-MM-dd').format(msg.timestamp);
      groups.putIfAbsent(key, () => []).add(msg);
    }

    return groups.entries.map((e) {
      return MediaDateGroup(
        date: DateTime.parse(e.key),
        items: e.value,
      );
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: S.of(context)?.chatMediaGallery ?? 'Media Gallery',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          // 类型过滤 Tab
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: AppColors.primary,
              unselectedLabelColor: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(text: S.of(context)?.mediaAll ?? 'All'),
                Tab(text: S.of(context)?.mediaImages ?? 'Images'),
                Tab(text: S.of(context)?.mediaVideos ?? 'Videos'),
                Tab(text: S.of(context)?.mediaFiles ?? 'Files'),
                Tab(text: S.of(context)?.mediaAudio ?? 'Audio'),
              ],
            ),
          ),

          // 统计
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  S.of(context)?.mediaItemsCount(_filteredMessages.length) ?? '${_filteredMessages.length} items',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // 内容
          Expanded(
            child: _filteredMessages.isEmpty
                ? _buildEmptyState(isDark)
                : _buildContent(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getFilterIcon(),
            size: 64,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context)?.mediaNoMediaFound ?? 'No media found',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFilterIcon() {
    switch (_currentFilter) {
      case MediaFilterType.all:
        return Icons.perm_media_outlined;
      case MediaFilterType.images:
        return Icons.image_outlined;
      case MediaFilterType.videos:
        return Icons.videocam_outlined;
      case MediaFilterType.files:
        return Icons.insert_drive_file_outlined;
      case MediaFilterType.audio:
        return Icons.audiotrack_outlined;
    }
  }

  Widget _buildContent(bool isDark) {
    final isGridView = _currentFilter == MediaFilterType.all ||
        _currentFilter == MediaFilterType.images ||
        _currentFilter == MediaFilterType.videos;

    if (isGridView) {
      return _buildGridView(isDark);
    } else {
      return _buildListView(isDark);
    }
  }

  /// Build auth headers only for homeserver URLs
  Map<String, String> _buildAuthHeaders(String? url) {
    if (url == null) return const {};
    final client = MatrixClientManager.instance.client;
    if (client == null) return const {};
    final accessToken = client.accessToken;
    if (accessToken == null) return const {};
    // Only send token to the homeserver
    final homeserver = client.homeserver;
    if (homeserver != null && Uri.tryParse(url)?.host == homeserver.host) {
      return {'Authorization': 'Bearer $accessToken'};
    }
    return const {};
  }

  Widget _buildGridView(bool isDark) {
    final groups = _groupedByDate;

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: groups.length,
      itemBuilder: (context, groupIndex) {
        final group = groups[groupIndex];
        final dateStr = _formatDateHeader(group.date);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 日期分隔
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                dateStr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : AppColors.textPrimary,
                ),
              ),
            ),
            // 媒体网格
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: group.items.length,
              itemBuilder: (context, index) {
                return _buildMediaGridItem(group.items[index], isDark);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildMediaGridItem(
    MessageEntity message,
    bool isDark,
  ) {
    final thumbnailUrl = message.metadata?.thumbnailUrl ?? message.metadata?.httpUrl;
    final headers = _buildAuthHeaders(thumbnailUrl);
    final isVideo = message.type == MessageType.video;

    return GestureDetector(
      onTap: () {
        // 打开对应的预览器
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (thumbnailUrl != null)
              CachedNetworkImage(
                imageUrl: thumbnailUrl,
                fit: BoxFit.cover,
                httpHeaders: headers,
                placeholder: (_, __) => Container(
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                ),
                errorWidget: (_, __, ___) => Icon(
                  isVideo ? Icons.videocam : Icons.image,
                  color: Colors.white54,
                ),
              )
            else
              Icon(
                isVideo ? Icons.videocam : Icons.image,
                color: isDark ? Colors.white38 : Colors.black26,
                size: 32,
              ),
            // 视频标记
            if (isVideo)
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.play_arrow, size: 12, color: Colors.white),
                      if (message.metadata?.formattedDuration.isNotEmpty == true) ...[
                        const SizedBox(width: 2),
                        Text(
                          message.metadata!.formattedDuration,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(bool isDark) {
    final groups = _groupedByDate;

    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, groupIndex) {
        final group = groups[groupIndex];
        final dateStr = _formatDateHeader(group.date);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                dateStr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : AppColors.textPrimary,
                ),
              ),
            ),
            ...group.items.map((msg) => _buildFileListItem(msg, isDark)),
          ],
        );
      },
    );
  }

  Widget _buildFileListItem(MessageEntity message, bool isDark) {
    final meta = message.metadata;
    final fileName = meta?.fileName ?? 'Unknown file';
    final fileSize = meta?.formattedSize ?? '';
    final icon = _getFileIcon(meta?.mimeType);

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        fileName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: isDark ? Colors.white : AppColors.textPrimary,
          fontSize: 15,
        ),
      ),
      subtitle: Row(
        children: [
          Text(
            fileSize,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            message.senderName,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
        ],
      ),
      onTap: () {
        // 打开文件预览
      },
    );
  }

  IconData _getFileIcon(String? mimeType) {
    if (mimeType == null) return Icons.insert_drive_file;
    if (mimeType.startsWith('audio/')) return Icons.audiotrack;
    if (mimeType.startsWith('video/')) return Icons.videocam;
    if (mimeType.startsWith('image/')) return Icons.image;
    if (mimeType.contains('pdf')) return Icons.picture_as_pdf;
    if (mimeType.contains('word') || mimeType.contains('document')) return Icons.description;
    if (mimeType.contains('sheet') || mimeType.contains('excel')) return Icons.table_chart;
    if (mimeType.contains('zip') || mimeType.contains('rar') || mimeType.contains('tar')) {
      return Icons.folder_zip;
    }
    return Icons.insert_drive_file;
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) return 'Today';
    if (dateOnly == today.subtract(const Duration(days: 1))) return 'Yesterday';
    if (date.year == now.year) return DateFormat('MMM d').format(date);
    return DateFormat('MMM d, yyyy').format(date);
  }
}
