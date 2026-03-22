import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/local/preferences_datasource.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';

class ScheduledMessagesPage extends StatefulWidget {
  final String roomId;
  final String roomName;

  const ScheduledMessagesPage({
    super.key,
    required this.roomId,
    required this.roomName,
  });

  @override
  State<ScheduledMessagesPage> createState() => _ScheduledMessagesPageState();
}

class _ScheduledMessagesPageState extends State<ScheduledMessagesPage> {
  final PreferencesDataSource _preferences = getIt<PreferencesDataSource>();

  bool _isLoading = true;
  List<_ScheduledMessageDraft> _drafts = const [];

  @override
  void initState() {
    super.initState();
    _loadDrafts();
  }

  Future<void> _loadDrafts() async {
    setState(() => _isLoading = true);
    final rawDrafts = await _preferences.getScheduledMessages(widget.roomId);
    final drafts =
        rawDrafts.map(_ScheduledMessageDraft.fromJson).toList(growable: false)
          ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

    if (!mounted) return;
    setState(() {
      _drafts = drafts;
      _isLoading = false;
    });
  }

  Future<void> _cancelDraft(_ScheduledMessageDraft draft) async {
    try {
      context.read<ChatBloc>().add(CancelScheduledMessage(draft.messageId));
    } catch (_) {
      await _preferences.removeScheduledMessage(widget.roomId, draft.messageId);
    }

    if (!mounted) return;
    setState(() {
      _drafts = _drafts
          .where((item) => item.messageId != draft.messageId)
          .toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Scheduled message cancelled')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        elevation: 0,
        title: Text(
          'Scheduled Messages',
          style: TextStyle(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadDrafts,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : (_drafts.isEmpty
                  ? _buildEmptyState(isDark)
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _drafts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final draft = _drafts[index];
                        return _buildDraftCard(draft, isDark);
                      },
                    )),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.18),
        Icon(
          Icons.schedule_send_outlined,
          size: 56,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'No scheduled messages yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'Long press Send in chat to schedule follow-ups, reminders, or meeting notes.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDraftCard(_ScheduledMessageDraft draft, bool isDark) {
    final cardColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final secondaryColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, size: 18, color: Colors.blue[700]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _formatScheduledAt(draft.scheduledAt),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _cancelDraft(draft),
                child: const Text('Cancel'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            draft.text,
            style: TextStyle(
              fontSize: 15,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
          if (draft.mentionsRoom || draft.mentionedUserIds.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (draft.mentionsRoom)
                  _buildChip(label: '@all', isDark: isDark),
                if (draft.mentionedUserIds.isNotEmpty)
                  _buildChip(
                    label: '@${draft.mentionedUserIds.length} members',
                    isDark: isDark,
                  ),
                if (draft.selfDestructAfter != null)
                  _buildChip(
                    label: 'Auto-delete ${draft.selfDestructAfter}s',
                    isDark: isDark,
                  ),
              ],
            ),
          ],
          const SizedBox(height: 10),
          Text(
            'Created ${DateFormat('yyyy-MM-dd HH:mm').format(draft.createdAt)}',
            style: TextStyle(fontSize: 12, color: secondaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildChip({required String label, required bool isDark}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }

  String _formatScheduledAt(DateTime scheduledAt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final scheduledDay = DateTime(
      scheduledAt.year,
      scheduledAt.month,
      scheduledAt.day,
    );

    if (scheduledDay == today) {
      return 'Today ${DateFormat('HH:mm').format(scheduledAt)}';
    }
    if (scheduledDay == today.add(const Duration(days: 1))) {
      return 'Tomorrow ${DateFormat('HH:mm').format(scheduledAt)}';
    }
    return DateFormat('yyyy-MM-dd HH:mm').format(scheduledAt);
  }
}

class _ScheduledMessageDraft {
  final String messageId;
  final String text;
  final DateTime scheduledAt;
  final DateTime createdAt;
  final List<String> mentionedUserIds;
  final bool mentionsRoom;
  final int? selfDestructAfter;

  const _ScheduledMessageDraft({
    required this.messageId,
    required this.text,
    required this.scheduledAt,
    required this.createdAt,
    required this.mentionedUserIds,
    required this.mentionsRoom,
    this.selfDestructAfter,
  });

  factory _ScheduledMessageDraft.fromJson(Map<String, dynamic> json) {
    return _ScheduledMessageDraft(
      messageId: json['messageId'] as String? ?? '',
      text: json['text'] as String? ?? '',
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      mentionedUserIds:
          (json['mentionedUserIds'] as List<dynamic>?)?.cast<String>() ??
          const [],
      mentionsRoom: json['mentionsRoom'] as bool? ?? false,
      selfDestructAfter: json['selfDestructAfter'] as int?,
    );
  }
}
