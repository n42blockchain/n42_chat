import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/favorite_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 收藏列表页面
class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({super.key});

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  // 模拟收藏数据
  final List<FavoriteEntity> _favorites = [
    FavoriteEntity(
      id: '1',
      type: FavoriteType.text,
      content: '这是一条收藏的文本消息，可以是任何重要的信息内容，方便以后查看。',
      sourceSenderName: '张三',
      sourceRoomName: '工作群',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    FavoriteEntity(
      id: '2',
      type: FavoriteType.image,
      content: '图片',
      mediaUrl: 'https://picsum.photos/400/300',
      thumbnailUrl: 'https://picsum.photos/200/150',
      sourceSenderName: '李四',
      sourceRoomName: '朋友圈',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    FavoriteEntity(
      id: '3',
      type: FavoriteType.link,
      content: 'Flutter官方文档 - 构建漂亮的原生应用',
      mediaUrl: 'https://flutter.dev',
      sourceSenderName: '技术分享',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    FavoriteEntity(
      id: '4',
      type: FavoriteType.file,
      content: '项目需求文档.pdf',
      fileName: '项目需求文档.pdf',
      fileSize: 2048000,
      sourceSenderName: '王五',
      sourceRoomName: '项目组',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    FavoriteEntity(
      id: '5',
      type: FavoriteType.note,
      content: '个人笔记：\n1. 完成首页UI设计\n2. 对接API接口\n3. 测试和修复Bug',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    FavoriteEntity(
      id: '6',
      type: FavoriteType.voice,
      content: '语音消息 0:15',
      sourceSenderName: '赵六',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];
  
  FavoriteType? _filterType;
  String _searchQuery = '';
  
  List<FavoriteEntity> get _filteredFavorites {
    var list = _favorites;
    
    if (_filterType != null) {
      list = list.where((f) => f.type == _filterType).toList();
    }
    
    if (_searchQuery.isNotEmpty) {
      list = list.where((f) => 
        f.content.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        (f.sourceSenderName?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
      ).toList();
    }
    
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;
    
    return Scaffold(
      backgroundColor: bgColor,
      appBar: N42AppBar(
        title: '收藏',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearch,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // 类型筛选
          _buildFilterBar(isDark),
          
          // 收藏列表
          Expanded(
            child: _filteredFavorites.isEmpty
                ? _buildEmptyState(isDark)
                : ListView.builder(
                    itemCount: _filteredFavorites.length,
                    itemBuilder: (context, index) {
                      return _buildFavoriteItem(
                        context,
                        _filteredFavorites[index],
                        isDark,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterBar(bool isDark) {
    final types = [
      null, // 全部
      FavoriteType.text,
      FavoriteType.image,
      FavoriteType.link,
      FavoriteType.file,
      FavoriteType.note,
    ];
    
    final typeLabels = {
      null: '全部',
      FavoriteType.text: '文本',
      FavoriteType.image: '图片',
      FavoriteType.link: '链接',
      FavoriteType.file: '文件',
      FavoriteType.note: '笔记',
    };
    
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.divider,
            width: 0.5,
          ),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final type = types[index];
          final isSelected = _filterType == type;
          
          return GestureDetector(
            onTap: () {
              setState(() => _filterType = type);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                typeLabels[type] ?? '全部',
                style: TextStyle(
                  fontSize: 13,
                  color: isSelected
                      ? AppColors.primary
                      : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildFavoriteItem(BuildContext context, FavoriteEntity favorite, bool isDark) {
    final cardColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? Colors.white : AppColors.textPrimary;
    final subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _openFavoriteDetail(favorite),
          onLongPress: () => _showFavoriteOptions(favorite),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 内容
                _buildFavoriteContent(favorite, textColor, isDark),
                
                const SizedBox(height: 8),
                
                // 来源和时间
                Row(
                  children: [
                    // 类型图标
                    Text(
                      favorite.typeIcon,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    
                    // 来源
                    if (favorite.sourceSenderName != null) ...[
                      Text(
                        favorite.sourceSenderName!,
                        style: TextStyle(
                          fontSize: 12,
                          color: subtitleColor,
                        ),
                      ),
                      if (favorite.sourceRoomName != null) ...[
                        Text(
                          ' · ',
                          style: TextStyle(color: subtitleColor),
                        ),
                        Text(
                          favorite.sourceRoomName!,
                          style: TextStyle(
                            fontSize: 12,
                            color: subtitleColor,
                          ),
                        ),
                      ],
                    ] else
                      Text(
                        '我的笔记',
                        style: TextStyle(
                          fontSize: 12,
                          color: subtitleColor,
                        ),
                      ),
                    
                    const Spacer(),
                    
                    // 时间
                    Text(
                      _formatTime(favorite.createdAt),
                      style: TextStyle(
                        fontSize: 12,
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildFavoriteContent(FavoriteEntity favorite, Color textColor, bool isDark) {
    switch (favorite.type) {
      case FavoriteType.image:
        return Row(
          children: [
            if (favorite.thumbnailUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: favorite.thumbnailUrl!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: Colors.grey[300],
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, color: Colors.grey),
                  ),
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                favorite.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        );
        
      case FavoriteType.file:
        return Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.insert_drive_file,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favorite.fileName ?? favorite.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (favorite.fileSize != null)
                    Text(
                      _formatFileSize(favorite.fileSize!),
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
        
      case FavoriteType.link:
        return Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.link,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favorite.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: textColor),
                  ),
                  if (favorite.mediaUrl != null)
                    Text(
                      favorite.mediaUrl!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
        
      case FavoriteType.voice:
        return Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.mic,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              favorite.content,
              style: TextStyle(color: textColor),
            ),
          ],
        );
        
      case FavoriteType.note:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBE6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            favorite.content,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF8B7355),
              height: 1.5,
            ),
          ),
        );
        
      default:
        return Text(
          favorite.content,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textColor,
            height: 1.4,
          ),
        );
    }
  }
  
  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star_border,
            size: 64,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无收藏内容',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '长按聊天消息可收藏',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showSearch() {
    showSearch(
      context: context,
      delegate: _FavoriteSearchDelegate(_favorites),
    );
  }
  
  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.note_add),
              title: const Text('新建笔记'),
              onTap: () {
                Navigator.pop(context);
                _createNote();
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('收藏链接'),
              onTap: () {
                Navigator.pop(context);
                _addLink();
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void _openFavoriteDetail(FavoriteEntity favorite) {
    // TODO: 实现详情页面
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('打开: ${favorite.content}')),
    );
  }
  
  void _showFavoriteOptions(FavoriteEntity favorite) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('编辑标签'),
              onTap: () {
                Navigator.pop(context);
                // TODO: 编辑标签
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('转发'),
              onTap: () {
                Navigator.pop(context);
                // TODO: 转发
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('删除', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _deleteFavorite(favorite);
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void _createNote() {
    // TODO: 实现新建笔记
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('新建笔记功能即将推出')),
    );
  }
  
  void _addLink() {
    // TODO: 实现添加链接
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('添加链接功能即将推出')),
    );
  }
  
  void _deleteFavorite(FavoriteEntity favorite) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除收藏'),
        content: const Text('确定要删除这条收藏吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _favorites.removeWhere((f) => f.id == favorite.id);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('已删除')),
              );
            },
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    
    if (diff.inDays == 0) {
      return '今天';
    } else if (diff.inDays == 1) {
      return '昨天';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}天前';
    } else {
      return '${time.month}月${time.day}日';
    }
  }
  
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class _FavoriteSearchDelegate extends SearchDelegate<FavoriteEntity?> {
  final List<FavoriteEntity> favorites;
  
  _FavoriteSearchDelegate(this.favorites);
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }
  
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }
  
  Widget _buildSearchResults() {
    final results = favorites.where((f) =>
      f.content.toLowerCase().contains(query.toLowerCase()) ||
      (f.sourceSenderName?.toLowerCase().contains(query.toLowerCase()) ?? false)
    ).toList();
    
    if (results.isEmpty) {
      return const Center(
        child: Text('没有找到相关收藏'),
      );
    }
    
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final favorite = results[index];
        return ListTile(
          leading: Text(favorite.typeIcon, style: const TextStyle(fontSize: 24)),
          title: Text(
            favorite.content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: favorite.sourceSenderName != null
              ? Text(favorite.sourceSenderName!)
              : null,
          onTap: () => close(context, favorite),
        );
      },
    );
  }
}

