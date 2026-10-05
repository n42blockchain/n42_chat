import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/repositories/message_action_repository.dart';
import '../../blocs/favorite/favorite_bloc.dart';
import '../../blocs/favorite/favorite_event.dart';
import '../../blocs/favorite/favorite_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 收藏列表页面
class FavoriteListPage extends StatelessWidget {
  const FavoriteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          FavoriteBloc(repository: GetIt.instance<IMessageActionRepository>())
            ..add(const LoadFavorites()),
      child: const _FavoriteListView(),
    );
  }
}

class _FavoriteListView extends StatelessWidget {
  const _FavoriteListView();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor = context.pageBackground;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: N42AppBar(
        title: S.of(context)?.commonFavorites ?? 'Favorites',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddOptions(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // 类型筛选
          _buildFilterBar(context, isDark),

          // 收藏列表
          Expanded(
            child: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: N42Loading());
                }

                if (state.error != null) {
                  return Center(
                    child: N42EmptyState.error(
                      title: S.of(context)?.commonLoadFailed ?? 'Load failed',
                      description: state.error,
                      buttonText: S.of(context)?.commonRetry ?? 'Retry',
                      onButtonPressed: () {
                        context.read<FavoriteBloc>().add(const LoadFavorites());
                      },
                    ),
                  );
                }

                final favorites = state.filteredFavorites;
                if (favorites.isEmpty) {
                  return _buildEmptyState(context, isDark);
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<FavoriteBloc>().add(const LoadFavorites());
                  },
                  child: ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      return _buildFavoriteItem(
                        context,
                        favorites[index],
                        isDark,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context, bool isDark) {
    final filters = [
      (null, S.of(context)?.commonAll ?? 'All'),
      ('text', S.of(context)?.favoriteText ?? 'Text'),
      ('image', S.of(context)?.commonImage ?? 'Image'),
      ('link', S.of(context)?.favoriteLinkLabel ?? 'Link'),
      ('file', S.of(context)?.commonFile ?? 'File'),
      ('video', 'Video'),
    ];

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      buildWhen: (prev, curr) => prev.filterType != curr.filterType,
      builder: (context, state) {
        return Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            border: Border(
              bottom: BorderSide(color: context.dividerColor, width: 0.5),
            ),
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final (type, label) = filters[index];
              final isSelected = state.filterType == type;

              return GestureDetector(
                onTap: () {
                  context.read<FavoriteBloc>().add(ChangeFavoriteFilter(type));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected
                          ? AppColors.primary
                          : context.textSecondary,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFavoriteItem(
    BuildContext context,
    MessageEntity favorite,
    bool isDark,
  ) {
    final cardColor = context.surfaceColor;
    final textColor = context.textPrimary;
    final subtitleColor = context.textSecondary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onLongPress: () => _showFavoriteOptions(context, favorite),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 内容
                Text(
                  favorite.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: textColor, height: 1.4),
                ),

                const SizedBox(height: 8),

                // 来源和时间
                Row(
                  children: [
                    Icon(
                      _getTypeIcon(favorite.type),
                      size: 14,
                      color: subtitleColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      favorite.senderName,
                      style: TextStyle(fontSize: 12, color: subtitleColor),
                    ),
                    const Spacer(),
                    Text(
                      _formatTime(context, favorite.timestamp),
                      style: TextStyle(fontSize: 12, color: subtitleColor),
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

  IconData _getTypeIcon(MessageType type) {
    switch (type) {
      case MessageType.text:
        return Icons.text_fields;
      case MessageType.image:
        return Icons.image;
      case MessageType.video:
        return Icons.videocam;
      case MessageType.file:
        return Icons.insert_drive_file;
      case MessageType.voice:
      case MessageType.audio:
        return Icons.mic;
      default:
        return Icons.star;
    }
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star_border, size: 64, color: context.textSecondary),
          const SizedBox(height: 16),
          Text(
            S.of(context)?.favoriteNoFavorites ?? 'No favorites yet',
            style: TextStyle(fontSize: 16, color: context.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context)?.favoriteLongPressToFavorite ??
                'Long press message to favorite',
            style: const TextStyle(fontSize: 14, color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => _FavoriteSearchDialog(
        l10n: S.of(context),
        onSearch: (query) =>
            context.read<FavoriteBloc>().add(SearchFavorites(query)),
      ),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.note_add_outlined),
              title: Text(S.of(context)?.favoriteNewNote ?? 'New Note'),
              onTap: () {
                Navigator.pop(sheetContext);
                _createNote(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.link_outlined),
              title: Text(S.of(context)?.favoriteLink ?? 'Favorite Link'),
              onTap: () {
                Navigator.pop(sheetContext);
                _addLink(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createNote(BuildContext context) async {
    final l10n = S.of(context);

    await showDialog<void>(
      context: context,
      builder: (_) => _FavoriteNoteDialog(
        l10n: l10n,
        onSave: (content) => _saveFavoriteMessage(
          context,
          _buildLocalFavoriteMessage(
            senderName: l10n?.favoriteMyNotes ?? 'My Notes',
            content: content,
          ),
          successMessage: l10n?.favoriteNoteAdded ?? 'Note added',
        ),
      ),
    );
  }

  Future<void> _addLink(BuildContext context) async {
    final l10n = S.of(context);

    await showDialog<void>(
      context: context,
      builder: (_) => _FavoriteLinkDialog(
        l10n: l10n,
        onSave: (title, normalizedUrl) {
          final content = title.isEmpty
              ? normalizedUrl
              : '$title\n$normalizedUrl';
          return _saveFavoriteMessage(
            context,
            _buildLocalFavoriteMessage(
              senderName: l10n?.commonMe ?? 'Me',
              content: content,
              metadata: MessageMetadata(httpUrl: normalizedUrl),
            ),
            successMessage: l10n?.favoriteLinkAdded ?? 'Link added',
          );
        },
      ),
    );
  }

  MessageEntity _buildLocalFavoriteMessage({
    required String senderName,
    required String content,
    MessageMetadata? metadata,
  }) {
    final now = DateTime.now();
    return MessageEntity(
      id: 'favorite_local_${now.microsecondsSinceEpoch}',
      roomId: '__favorite_local__',
      senderId: '@favorite:local',
      senderName: senderName,
      content: content,
      type: MessageType.text,
      timestamp: now,
      isFromMe: true,
      metadata: metadata,
    );
  }

  Future<void> _saveFavoriteMessage(
    BuildContext context,
    MessageEntity message, {
    required String successMessage,
  }) async {
    final repository = GetIt.instance<IMessageActionRepository>();
    final favoriteBloc = context.read<FavoriteBloc>();
    final currentFilter = favoriteBloc.state.filterType;

    await repository.saveMessage(message);
    if (!context.mounted) {
      return;
    }

    favoriteBloc.add(LoadFavorites(filterType: currentFilter));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(successMessage)));
  }

  void _showFavoriteOptions(BuildContext context, MessageEntity favorite) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: Text(S.of(context)?.commonForward ?? 'Forward'),
              onTap: () {
                Navigator.pop(sheetContext);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: AppColors.error),
              title: Text(
                S.of(context)?.commonDelete ?? 'Delete',
                style: const TextStyle(color: AppColors.error),
              ),
              onTap: () {
                Navigator.pop(sheetContext);
                context.read<FavoriteBloc>().add(DeleteFavorite(favorite.id));
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(BuildContext context, DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inDays == 0) {
      return S.of(context)?.favoriteToday ?? 'Today';
    } else if (diff.inDays == 1) {
      return S.of(context)?.favoriteYesterday ?? 'Yesterday';
    } else if (diff.inDays < 7) {
      return S.of(context)?.favoriteDaysAgoText(diff.inDays) ??
          '${diff.inDays} days ago';
    } else {
      return S.of(context)?.favoriteDateFormat(time.month, time.day) ??
          '${time.month}/${time.day}';
    }
  }
}

class _FavoriteSearchDialog extends StatefulWidget {
  final S? l10n;
  final ValueChanged<String> onSearch;

  const _FavoriteSearchDialog({required this.l10n, required this.onSearch});

  @override
  State<_FavoriteSearchDialog> createState() => _FavoriteSearchDialogState();
}

class _FavoriteSearchDialogState extends State<_FavoriteSearchDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return AlertDialog(
      title: Text(l10n?.commonSearch ?? 'Search'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: l10n?.commonSearch ?? 'Search',
          border: const OutlineInputBorder(),
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n?.commonCancel ?? 'Cancel'),
        ),
        TextButton(
          onPressed: () {
            final query = _controller.text;
            Navigator.pop(context);
            widget.onSearch(query);
          },
          child: Text(l10n?.commonConfirm ?? 'OK'),
        ),
      ],
    );
  }
}

class _FavoriteNoteDialog extends StatefulWidget {
  final S? l10n;
  final Future<void> Function(String content) onSave;

  const _FavoriteNoteDialog({required this.l10n, required this.onSave});

  @override
  State<_FavoriteNoteDialog> createState() => _FavoriteNoteDialogState();
}

class _FavoriteNoteDialogState extends State<_FavoriteNoteDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return AlertDialog(
      title: Text(l10n?.favoriteNewNote ?? 'New Note'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        minLines: 3,
        maxLines: 6,
        decoration: InputDecoration(
          hintText: l10n?.favoriteEnterNoteContent ?? 'Enter note content',
          border: const OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n?.commonCancel ?? 'Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final content = _controller.text.trim();
            if (content.isEmpty) return;
            Navigator.pop(context);
            await widget.onSave(content);
          },
          child: Text(l10n?.commonConfirm ?? 'OK'),
        ),
      ],
    );
  }
}

class _FavoriteLinkDialog extends StatefulWidget {
  final S? l10n;
  final Future<void> Function(String title, String normalizedUrl) onSave;

  const _FavoriteLinkDialog({required this.l10n, required this.onSave});

  @override
  State<_FavoriteLinkDialog> createState() => _FavoriteLinkDialogState();
}

class _FavoriteLinkDialogState extends State<_FavoriteLinkDialog> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return AlertDialog(
      title: Text(l10n?.favoriteLink ?? 'Favorite Link'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: l10n?.favoriteLinkTitle ?? 'Link title',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _urlController,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              hintText: l10n?.favoriteLinkUrl ?? 'https://',
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n?.commonCancel ?? 'Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final normalizedUrl = _normalizeFavoriteUrl(_urlController.text);
            if (normalizedUrl == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a valid URL')),
              );
              return;
            }
            Navigator.pop(context);
            await widget.onSave(_titleController.text.trim(), normalizedUrl);
          },
          child: Text(l10n?.commonConfirm ?? 'OK'),
        ),
      ],
    );
  }
}

String? _normalizeFavoriteUrl(String rawUrl) {
  final trimmed = rawUrl.trim();
  if (trimmed.isEmpty) return null;
  final candidate = trimmed.contains('://') ? trimmed : 'https://$trimmed';
  final uri = Uri.tryParse(candidate);
  if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
    return null;
  }
  return candidate;
}
