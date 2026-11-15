import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/repositories/chat_catch_up_repository.dart';
import '../../../domain/repositories/conversation_repository.dart';

class HistorySharePage extends StatefulWidget {
  final String roomId;
  final List<MessageEntity> messages;
  final IChatCatchUpRepository repository;
  final IConversationRepository conversations;
  const HistorySharePage({
    super.key,
    required this.roomId,
    required this.messages,
    required this.repository,
    required this.conversations,
  });
  @override
  State<HistorySharePage> createState() => _HistorySharePageState();
}

class _HistorySharePageState extends State<HistorySharePage> {
  final _selected = <String>{};
  final _maxMessages = TextEditingController(text: '20');
  final _maxHours = TextEditingController(text: '168');
  @override
  void dispose() {
    _maxMessages.dispose();
    _maxHours.dispose();
    super.dispose();
  }

  ConversationEntity? _target;
  late final Future<List<ConversationEntity>> _rooms;
  bool _busy = false;
  late Future<List<HistoryShareRecovery>> _recoveries;
  String? _result;
  HistoryShareDraft? _draft;
  HistoryShareStatus? _status;
  @override
  void initState() {
    super.initState();
    _rooms = widget.conversations.getConversations();
    _recoveries = widget.repository.pendingHistory(widget.roomId);
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _result = null;
    });
    try {
      await action();
    } catch (_) {
      if (mounted) setState(() => _result = S.of(context)!.chatHistoryFailed);
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _recoveries = widget.repository.pendingHistory(widget.roomId);
        });
      }
    }
  }

  Future<void> _policy(bool enabled) => _run(() async {
    final l = S.of(context)!;
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.chatHistoryPolicy),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l.chatHistoryPolicyDetail),
            TextField(
              controller: _maxMessages,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: l.chatHistoryMaxMessages),
            ),
            TextField(
              controller: _maxHours,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: l.chatHistoryMaxHours),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.commonConfirm),
          ),
        ],
      ),
    );
    if (yes != true || !mounted) return;
    await widget.repository.setHistorySharing(
      widget.roomId,
      enabled: enabled,
      maxMessages: int.tryParse(_maxMessages.text) ?? 0,
      maxAgeHours: int.tryParse(_maxHours.text) ?? 0,
    );
    if (mounted) setState(() => _result = l.chatHistoryPolicySaved);
  });
  Future<void> _preview() => _run(() async {
    final target = _target!;
    final draft = await widget.repository.previewHistory(
      roomId: widget.roomId,
      targetRoomId: target.id,
      recipient: target.directUserId!,
      eventIds: _selected.toList(),
    );
    if (mounted) {
      setState(() {
        _draft = draft;
        _status = null;
      });
    }
  });
  Future<void> _send() => _run(() async {
    final result = await widget.repository.shareHistory(_draft!);
    if (mounted) {
      setState(() {
        _status = result;
        _result = result == HistoryShareStatus.completed
            ? S.of(context)!.chatHistoryCompleted
            : S.of(context)!.chatHistoryPending;
      });
    }
  });
  @override
  Widget build(BuildContext context) {
    final l = S.of(context)!;
    final draft = _draft;
    final times = draft?.messages.map((m) => m.timestamp).toList()?..sort();
    final messages = widget.messages
        .where(
          (m) => m.roomId == widget.roomId && m.isText && !m.isSelfDestructing,
        )
        .toList();
    return PopScope(
      canPop: !_busy,
      child: Scaffold(
        appBar: AppBar(title: Text(l.chatHistoryShare)),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l.chatHistoryExplanation),
            FutureBuilder<List<HistoryShareRecovery>>(
              future: _recoveries,
              builder: (_, snapshot) {
                return Column(
                  children: [
                    for (final record
                        in snapshot.data ?? <HistoryShareRecovery>[])
                      ListTile(
                        title: Text(record.recipient),
                        subtitle: Text(l.chatHistoryPending),
                        trailing: TextButton(
                          onPressed: _busy
                              ? null
                              : () => _run(() async {
                                  final result = await widget.repository
                                      .reconcileBatch(record);
                                  if (mounted) {
                                    setState(
                                      () => _result =
                                          result == HistoryShareStatus.completed
                                          ? l.chatHistoryCompleted
                                          : l.chatHistoryPending,
                                    );
                                  }
                                }),
                          child: Text(l.chatHistoryReconcile),
                        ),
                      ),
                  ],
                );
              },
            ),
            Wrap(
              spacing: 8,
              children: [
                TextButton(
                  onPressed: _busy ? null : () => _policy(true),
                  child: Text(l.chatHistoryEnable),
                ),
                TextButton(
                  onPressed: _busy ? null : () => _policy(false),
                  child: Text(l.chatHistoryDisable),
                ),
              ],
            ),
            if (draft == null) ...[
              FutureBuilder<List<ConversationEntity>>(
                future: _rooms,
                builder: (_, snapshot) {
                  if (snapshot.hasError) return Text(l.chatHistoryFailed);
                  if (!snapshot.hasData) return const LinearProgressIndicator();
                  final rooms = snapshot.data!
                      .where(
                        (r) =>
                            r.isDirect &&
                            r.isEncrypted &&
                            r.directUserId != null &&
                            r.id != widget.roomId,
                      )
                      .toList();
                  return DropdownButton<ConversationEntity>(
                    isExpanded: true,
                    value: _target,
                    hint: Text(l.chatHistoryRecipient),
                    items: rooms
                        .map(
                          (r) => DropdownMenuItem(
                            value: r,
                            child: Text(
                              '${r.name} (${r.directUserId})',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: _busy
                        ? null
                        : (r) => setState(() => _target = r),
                  );
                },
              ),
              for (final m in messages)
                CheckboxListTile(
                  value: _selected.contains(m.id),
                  title: Text(
                    m.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('${m.senderId} · ${m.timestamp.toLocal()}'),
                  onChanged: _busy
                      ? null
                      : (value) => setState(() {
                          if (value == true) {
                            _selected.add(m.id);
                          } else {
                            _selected.remove(m.id);
                          }
                        }),
                ),
              FilledButton(
                onPressed: _busy || _target == null || _selected.isEmpty
                    ? null
                    : _preview,
                child: Text(l.chatHistoryReview),
              ),
            ] else ...[
              Text(
                '${draft.recipient}\n${draft.messages.length} ${l.chatHistoryMessages}',
              ),
              Text('${times!.first.toLocal()} – ${times.last.toLocal()}'),
              for (final m in draft.messages)
                ListTile(
                  title: Text(m.content),
                  subtitle: Text('${m.senderId} · ${m.timestamp.toLocal()}'),
                ),
              Text(l.chatHistoryConfirmDetail),
              FilledButton(
                onPressed: _busy || _status == HistoryShareStatus.completed
                    ? null
                    : _send,
                child: Text(l.commonConfirm),
              ),
              TextButton(
                onPressed: _busy
                    ? null
                    : () => _run(() async {
                        final status = await widget.repository.reconcileHistory(
                          draft,
                        );
                        if (mounted) {
                          setState(() {
                            _status = status;
                            _result = status == HistoryShareStatus.completed
                                ? l.chatHistoryCompleted
                                : l.chatHistoryPending;
                          });
                        }
                      }),
                child: Text(l.chatHistoryReconcile),
              ),
              TextButton(
                onPressed: _busy
                    ? null
                    : () => setState(() {
                        _draft = null;
                        _status = null;
                      }),
                child: Text(l.commonCancel),
              ),
            ],
            if (_busy) const LinearProgressIndicator(),
            if (_result != null) Text(_result!),
          ],
        ),
      ),
    );
  }
}
