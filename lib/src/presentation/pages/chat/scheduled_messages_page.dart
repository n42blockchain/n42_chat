import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:n42_chat/l10n/app_localizations.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../data/datasources/local/preferences_datasource.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/repositories/message_repository.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/entities/scheduled_message_draft.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../../core/theme/app_dimensions.dart';

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

  final IMessageRepository _messages = getIt<IMessageRepository>();
  StreamSubscription<bool>? _accountSubscription;
  String? _ownerUserId;
  int _loadVersion = 0;
  bool _isLoading = true;
  final Set<String> _cancelling = {};
  List<ScheduledMessageDraft> _drafts = const [];

  @override
  void initState() {
    super.initState();
    if (getIt.isRegistered<IAuthRepository>()) {
      _accountSubscription = getIt<IAuthRepository>().loginStateStream.listen((
        _,
      ) {
        if (!mounted) return;
        setState(() {
          _ownerUserId = null;
          _drafts = const [];
        });
        _loadDrafts();
      });
    }
    _loadDrafts();
  }

  @override
  void dispose() {
    _accountSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadDrafts() async {
    final version = ++_loadVersion;
    setState(() => _isLoading = true);
    try {
      final owner = await _messages.getCurrentUserId();
      final drafts =
          owner == null || owner.isEmpty
                ? <ScheduledMessageDraft>[]
                : (await _preferences.getScheduledMessages(
                    widget.roomId,
                    ownerUserId: owner,
                  )).toList()
            ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
      final stillOwner = await _messages.getCurrentUserId();
      if (!mounted || version != _loadVersion) return;
      setState(() {
        _ownerUserId = stillOwner == owner ? owner : null;
        _drafts = stillOwner == owner ? drafts : const [];
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('ScheduledMessagesPage._loadDrafts error: $e');
      if (!mounted || version != _loadVersion) return;
      setState(() {
        _isLoading = false;
        _ownerUserId = null;
        _drafts = const [];
      });
    }
  }

  Future<void> _cancelDraft(ScheduledMessageDraft draft) async {
    if (!_cancelling.add(draft.messageId)) return;
    setState(() {});
    final owner = _ownerUserId;
    try {
      if (owner == null || owner != await _messages.getCurrentUserId()) {
        await _loadDrafts();
        return;
      }
      if (!mounted) return;
      final bloc = context.read<ChatBloc?>();
      if (bloc != null) {
        final completion = Completer<bool>();
        bloc.add(
          CancelScheduledMessage(
            draft.messageId,
            roomId: widget.roomId,
            ownerUserId: owner,
            completion: completion,
          ),
        );
        final cancelled = await completion.future.timeout(
          const Duration(seconds: 30),
          onTimeout: () => false,
        );
        if (!cancelled) throw StateError('Cancellation was not confirmed');
      } else {
        await _preferences.removeScheduledMessage(
          widget.roomId,
          draft.messageId,
          ownerUserId: owner,
        );
      }
      if (owner != await _messages.getCurrentUserId() ||
          !mounted ||
          owner != _ownerUserId) {
        return;
      }
      setState(() {
        _drafts = _drafts
            .where((item) => item.messageId != draft.messageId)
            .toList();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Scheduled message cancelled')),
      );
    } catch (e) {
      if (!mounted ||
          owner != _ownerUserId ||
          owner != await _messages.getCurrentUserId() ||
          !mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.commonFailedToSave ?? 'Failed to save'),
        ),
      );
    } finally {
      _cancelling.remove(draft.messageId);
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Scheduled Messages',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: context.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
        ),
        leading: IconButton(
          icon: Icon(AppIcons.back, color: context.textPrimary, size: 20),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadDrafts,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : (_drafts.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.all(AppDimensions.spacing),
                      itemCount: _drafts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppDimensions.spacingM),
                      itemBuilder: (context, index) {
                        final draft = _drafts[index];
                        return _buildDraftCard(draft);
                      },
                    )),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.18),
        Icon(
          Icons.schedule_send_outlined,
          size: 56,
          color: context.textSecondary,
        ),
        const SizedBox(height: AppDimensions.spacing),
        Center(
          child: Text(
            'No scheduled messages yet',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.3,
              color: context.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacingS),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingXXL,
          ),
          child: Text(
            'Long press Send, Photos, Files, a GIF, or a sticker to schedule follow-ups and reminders.',
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: context.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDraftCard(ScheduledMessageDraft draft) {
    final cardColor = context.surfaceColor;
    final secondaryColor = context.textSecondary;

    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_iconForDraft(draft), size: 18, color: AppColors.info),
              const SizedBox(width: AppDimensions.spacingS),
              Expanded(
                child: Text(
                  _formatScheduledAt(draft.scheduledAt),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                ),
              ),
              TextButton(
                onPressed: _cancelling.contains(draft.messageId)
                    ? null
                    : () => _cancelDraft(draft),
                child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildChip(label: draft.typeLabel),
          const SizedBox(height: 10),
          Text(
            draft.text,
            style: TextStyle(fontSize: 15, color: context.textPrimary),
          ),
          if (draft.pollOptions.isNotEmpty ||
              draft.mentionsRoom ||
              draft.mentionedUserIds.isNotEmpty ||
              draft.selfDestructAfter != null) ...[
            const SizedBox(height: AppDimensions.spacingM),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (draft.pollOptions.isNotEmpty)
                  _buildChip(label: '${draft.pollOptions.length} options'),
                if (draft.mentionsRoom) _buildChip(label: '@all'),
                if (draft.mentionedUserIds.isNotEmpty)
                  _buildChip(
                    label: '@${draft.mentionedUserIds.length} members',
                  ),
                if (draft.selfDestructAfter != null)
                  _buildChip(label: 'Auto-delete ${draft.selfDestructAfter}s'),
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

  IconData _iconForDraft(ScheduledMessageDraft draft) {
    if (draft.isGif) {
      return Icons.gif_box_outlined;
    }

    switch (draft.type) {
      case MessageType.poll:
        return Icons.poll_outlined;
      case MessageType.sticker:
        return Icons.emoji_emotions_outlined;
      default:
        return Icons.schedule;
    }
  }

  Widget _buildChip({required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, color: context.textPrimary),
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
