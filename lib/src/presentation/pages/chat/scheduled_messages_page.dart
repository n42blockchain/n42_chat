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
import '../../../data/services/scheduled_draft_operation.dart';
import '../../../domain/repositories/message_repository.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/entities/scheduled_message_draft.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../blocs/chat/scheduled_message_origin.dart';
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
  final ScheduledMessageOrigin? _origin = ScheduledMessageOrigin.capture();
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
    if (!mounted) return;
    final version = ++_loadVersion;
    setState(() => _isLoading = true);
    try {
      final owner = _origin?.isCurrent == true
          ? await _messages.getCurrentUserId()
          : null;
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
        _ownerUserId = stillOwner == owner && _origin?.isCurrent == true
            ? owner
            : null;
        _drafts = stillOwner == owner && _origin?.isCurrent == true
            ? drafts
            : const [];
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
    ScheduledDraftOperation? operation;
    try {
      if (_origin?.isCurrent != true ||
          owner == null ||
          owner != await _messages.getCurrentUserId() ||
          _origin?.isCurrent != true) {
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
            origin: _origin,
            completion: completion,
          ),
        );
        final cancelled = await completion.future.timeout(
          const Duration(seconds: 30),
          onTimeout: () => false,
        );
        if (!cancelled) {
          await _loadDrafts();
          throw StateError('Cancellation was not confirmed');
        }
      } else {
        operation = ScheduledDraftOperation.tryAcquire(
          ownerUserId: owner,
          roomId: widget.roomId,
          messageId: draft.messageId,
        );
        if (operation == null) throw StateError('Scheduled message is busy');
        final remaining = await _preferences.getScheduledMessages(
          widget.roomId,
          ownerUserId: owner,
        );
        if (!remaining.any((item) => item.messageId == draft.messageId)) {
          await _loadDrafts();
          throw StateError('Scheduled draft is no longer pending');
        }
        if (!mounted || _origin?.isCurrent != true) return;
        await _preferences.removeScheduledMessage(
          widget.roomId,
          draft.messageId,
          ownerUserId: owner,
        );
      }
      if (_origin?.isCurrent != true ||
          owner != await _messages.getCurrentUserId() ||
          !mounted ||
          owner != _ownerUserId ||
          _origin?.isCurrent != true) {
        return;
      }
      setState(() {
        _drafts = _drafts
            .where((item) => item.messageId != draft.messageId)
            .toList();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context)?.scheduledMessageCancelled ??
                'Scheduled message cancelled',
          ),
        ),
      );
    } catch (e) {
      if (_origin?.isCurrent != true ||
          !mounted ||
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
      operation?.release();
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
          S.of(context)?.scheduledMessagesTitle ?? 'Scheduled messages',
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
                      physics: const AlwaysScrollableScrollPhysics(),
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
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing),
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
            S.of(context)?.scheduledMessagesEmpty ??
                'No scheduled messages yet',
            textAlign: TextAlign.center,
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
            S.of(context)?.scheduledMessagesHint ?? 'Long press Send, Photos, Files, a GIF or a sticker to schedule a message.',
            textAlign: TextAlign.center,

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
            ],
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: _cancelling.contains(draft.messageId)
                  ? null
                  : () => _cancelDraft(draft),
              child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
            ),
          ),
          const SizedBox(height: 10),
          _buildChip(label: _localizedType(draft)),
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
                  _buildChip(
                    label:
                        '${S.of(context)?.chatPollOptionsLabel ?? 'Poll Options'}: ${_formatCount(draft.pollOptions.length)}',
                  ),
                if (draft.mentionsRoom) _buildChip(label: '@all'),
                if (draft.mentionedUserIds.isNotEmpty)
                  _buildChip(
                    label:
                        '@${S.of(context)?.commonGroupMembers(draft.mentionedUserIds.length) ?? 'Members (${draft.mentionedUserIds.length})'}',
                  ),
                if (draft.selfDestructAfter != null)
                  _buildChip(
                    label:
                        '${S.of(context)?.chatSelfDestructTimer ?? 'Self-destruct'}: ${S.of(context)?.secondsRemaining(draft.selfDestructAfter!) ?? '${draft.selfDestructAfter}s'}',
                  ),
              ],
            ),
          ],
          const SizedBox(height: 10),
          Text(
            S
                    .of(context)
                    ?.scheduledMessageCreatedAt(
                      _formatScheduledAt(draft.createdAt),
                    ) ??
                'Created ${_formatScheduledAt(draft.createdAt)}',
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

  String _localizedType(ScheduledMessageDraft draft) {
    final l10n = S.of(context);
    if (l10n == null) return draft.typeLabel;
    if (draft.isGif) return 'GIF';
    return switch (draft.type) {
      MessageType.image => l10n.contactPhotos,
      MessageType.video => l10n.video,
      MessageType.file => l10n.commonFileLabel,
      MessageType.poll => l10n.commonPoll,
      MessageType.sticker => l10n.profileStickers,
      _ => l10n.searchMessageLabel,
    };
  }

  String _formatCount(int value) =>
      NumberFormat.decimalPattern(Localizations.localeOf(context).toString())
          .format(value);

  String _formatScheduledAt(DateTime value) {
    final local = value.toLocal();
    final material = MaterialLocalizations.of(context);
    final date = material.formatFullDate(local);
    final time = material.formatTimeOfDay(
      TimeOfDay.fromDateTime(local),
      alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
    );
    return '$date $time';
  }
}
