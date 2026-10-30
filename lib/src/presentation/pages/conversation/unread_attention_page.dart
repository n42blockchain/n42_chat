import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/repositories/chat_catch_up_repository.dart';

class UnreadAttentionPage extends StatefulWidget {
  final IChatCatchUpRepository repository;
  final List<ConversationEntity> conversations;
  final void Function(ConversationEntity) onOpen;
  const UnreadAttentionPage({
    super.key,
    required this.repository,
    required this.conversations,
    required this.onOpen,
  });
  @override
  State<UnreadAttentionPage> createState() => _UnreadAttentionPageState();
}

class _UnreadAttentionPageState extends State<UnreadAttentionPage> {
  final _results = <String, UnreadAttention>{};
  bool _loading = true;
  int _run = 0;
  @override
  void initState() {
    super.initState();
    _scan();
  }

  Future<void> _scan() async {
    final run = ++_run;
    setState(() {
      _loading = true;
      _results.clear();
    });
    for (final room in widget.conversations.where(
      (c) => c.isGroup && !c.isInvite && !c.isHidden,
    )) {
      if (!mounted || run != _run) return;
      UnreadAttention result;
      try {
        result = await widget.repository.unreadAttention(
          room.id,
          isCancelled: () => !mounted || run != _run,
        );
      } catch (_) {
        result = const UnreadAttention();
      }
      if (!mounted || run != _run) return;
      setState(() => _results[room.id] = result);
    }
    if (mounted && run == _run) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context)!;
    final visible = widget.conversations.where((c) {
      final r = _results[c.id];
      return r != null &&
          (!r.complete || r.mentions.isNotEmpty || r.replies.isNotEmpty);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(l.chatUnreadAttention),
        actions: [
          IconButton(
            onPressed: _loading ? null : _scan,
            icon: const Icon(Icons.refresh),
            tooltip: l.chatScanAgain,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_loading) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l.chatUnreadScope),
          ),
          if (!_loading && visible.isEmpty)
            Expanded(child: Center(child: Text(l.chatNoMessages))),
          if (visible.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: visible.length,
                itemBuilder: (_, index) {
                  final room = visible[index], r = _results[visible[index].id]!;
                  return ListTile(
                    title: Text(room.name),
                    subtitle: Text(
                      '${l.chatCatchUpMentions}: ${r.mentions.length} · ${l.chatCatchUpReplies}: ${r.replies.length}'
                      '${r.complete ? '' : '\n${l.chatScanIncomplete}'}',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      widget.onOpen(room);
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
