import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/channel_entity.dart';
import '../../blocs/group/group_bloc.dart';
import '../../blocs/group/group_event.dart';
import '../../blocs/group/group_state.dart';
import '../../widgets/common/common_widgets.dart';
import 'group_channels_page.dart';
import '../../../n42_chat.dart';

/// 群话题列表页面（用户视角，Telegram Topics 风格）
///
/// 展示群内所有话题频道，支持点击进入对应话题聊天。
/// 管理员可从此页进入频道管理（[GroupChannelsPage]）和新建话题。
class GroupTopicsPage extends StatefulWidget {
  final String roomId;

  const GroupTopicsPage({super.key, required this.roomId});

  @override
  State<GroupTopicsPage> createState() => _GroupTopicsPageState();
}

class _GroupTopicsPageState extends State<GroupTopicsPage> {
  late GroupBloc _groupBloc;

  @override
  void initState() {
    super.initState();
    _groupBloc = getIt<GroupBloc>()
      ..add(LoadGroupDetails(widget.roomId))
      ..add(LoadChannels(widget.roomId));
  }

  @override
  void dispose() {
    _groupBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupBloc>.value(
      value: _groupBloc,
      child: _GroupTopicsBody(roomId: widget.roomId),
    );
  }
}

class _GroupTopicsBody extends StatelessWidget {
  final String roomId;

  const _GroupTopicsBody({required this.roomId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = S.of(context);

    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        final canManage = state.currentGroup?.canChangeSettings ?? false;
        final channels = state.channels;

        // 分区：置顶（order == 0 或名称含 announcement）+ 普通
        final pinned = channels
            .where(
              (c) => c.order == 0 || c.name.toLowerCase().contains('announce'),
            )
            .toList();
        final regular = channels.where((c) => !pinned.contains(c)).toList()
          ..sort((a, b) => a.order.compareTo(b.order));

        return Scaffold(
          backgroundColor: isDark
              ? AppColors.backgroundDark
              : AppColors.background,
          appBar: N42AppBar(
            title: l10n?.groupTopics ?? 'Topics',
            actions: [
              if (canManage)
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => GroupChannelsPage(roomId: roomId),
                    ),
                  ),
                  child: Text(
                    l10n?.commonEdit ?? 'Edit',
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
            ],
          ),
          floatingActionButton: canManage
              ? FloatingActionButton(
                  onPressed: () => _showCreateTopicSheet(context),
                  backgroundColor: AppColors.primary,
                  tooltip: l10n?.groupChannelCreate ?? 'New Topic',
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : null,
          body: state.isLoading
              ? const N42Loading()
              : Builder(
                  builder: (context) {
                    // 始终插入 General 条目作为父房间入口
                    final effectivePinned = pinned;
                    final effectiveRegular = [
                      ChannelEntity.general(roomId),
                      ...regular,
                    ];

                    return ListView(
                      children: [
                        // 置顶话题
                        if (effectivePinned.isNotEmpty) ...[
                          _buildSectionHeader(
                            context,
                            isDark,
                            Icons.push_pin_outlined,
                            l10n?.groupChannels ?? 'Pinned',
                          ),
                          ...effectivePinned.map(
                            (c) => _buildTopicTile(
                              context,
                              c,
                              isDark,
                              isPinned: true,
                            ),
                          ),
                        ],

                        // 普通话题
                        if (effectiveRegular.isNotEmpty) ...[
                          if (effectivePinned.isNotEmpty)
                            _buildSectionHeader(
                              context,
                              isDark,
                              Icons.tag,
                              l10n?.groupTopics ?? 'Topics',
                            ),
                          ...effectiveRegular.map(
                            (c) => _buildTopicTile(context, c, isDark),
                          ),
                        ],

                        const SizedBox(height: 80), // FAB 间距
                      ],
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    bool isDark,
    IconData icon,
    String label,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicTile(
    BuildContext context,
    ChannelEntity channel,
    bool isDark, {
    bool isPinned = false,
  }) {
    final lastMsg = channel.lastMessage;
    final unread = channel.unreadCount;

    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isPinned
                    ? Colors.orange.withValues(alpha: 0.15)
                    : AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isPinned ? Icons.campaign_outlined : Icons.tag,
                color: isPinned ? Colors.orange : AppColors.primary,
                size: 22,
              ),
            ),
            title: Text(
              channel.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
            ),
            subtitle: lastMsg != null
                ? Text(
                    lastMsg.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                    ),
                  )
                : (channel.topic != null
                      ? Text(
                          channel.topic!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary,
                          ),
                        )
                      : null),
            trailing: unread > 0
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      unread > 99 ? '99+' : '$unread',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                : null,
            onTap: () {
              N42Chat.openConversation(channel.roomId, context: context);
            },
          ),
          Divider(
            height: 1,
            indent: 76,
            color: isDark ? AppColors.dividerDark : AppColors.divider,
          ),
        ],
      ),
    );
  }

  void _showCreateTopicSheet(BuildContext context) {
    final l10n = S.of(context);
    final nameController = TextEditingController();
    final topicController = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        final isDark = Theme.of(sheetCtx).brightness == Brightness.dark;
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 标题行
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n?.groupChannelCreate ?? 'New Topic',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () => Navigator.pop(sheetCtx),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: nameController,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: l10n?.groupChannelName ?? 'Topic Name',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.tag),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: topicController,
                      decoration: InputDecoration(
                        labelText:
                            l10n?.groupChannelTopic ?? 'Description (optional)',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          final name = nameController.text.trim();
                          if (name.isEmpty) return;
                          Navigator.pop(sheetCtx);
                          context.read<GroupBloc>().add(
                            CreateChannel(
                              parentRoomId: roomId,
                              name: name,
                              topic: topicController.text.trim().isEmpty
                                  ? null
                                  : topicController.text.trim(),
                            ),
                          );
                        },
                        child: Text(
                          l10n?.commonConfirm ?? 'Create',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      nameController.dispose();
      topicController.dispose();
    });
  }
}
