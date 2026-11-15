import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../domain/services/chat_catch_up.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../blocs/chat/chat_state.dart';

class ChatCatchUpSheet extends StatefulWidget {
  final String roomId;
  final String? userId;
  final VoidCallback? onShareHistory;
  const ChatCatchUpSheet({
    super.key,
    required this.roomId,
    required this.userId,
    this.onShareHistory,
  });
  @override
  State<ChatCatchUpSheet> createState() => _ChatCatchUpSheetState();
}

class _ChatCatchUpSheetState extends State<ChatCatchUpSheet> {
  CatchUpFilter _filter = CatchUpFilter.pinned;
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                l10n.chatCatchUp,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (widget.onShareHistory != null)
              TextButton(
                onPressed: widget.onShareHistory,
                child: Text(l10n.chatHistoryShare),
              ),
            Wrap(
              spacing: 8,
              children: CatchUpFilter.values
                  .map(
                    (filter) => ChoiceChip(
                      label: Text(switch (filter) {
                        CatchUpFilter.pinned => l10n.chatCatchUpPinned,
                        CatchUpFilter.mentions => l10n.chatCatchUpMentions,
                        CatchUpFilter.replies => l10n.chatCatchUpReplies,
                      }),
                      selected: filter == _filter,
                      onSelected: (_) => setState(() => _filter = filter),
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(l10n.chatCatchUpScope),
            ),
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  final messages = catchUpMessages(
                    roomId: widget.roomId,
                    userId: widget.userId,
                    messages: state.messages,
                    pinned: state.pinnedMessages,
                    filter: _filter,
                  );
                  return Column(
                    children: [
                      Expanded(
                        child: messages.isEmpty
                            ? Center(child: Text(l10n.chatNoMessages))
                            : ListView.builder(
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  final m = messages[index];
                                  return ListTile(
                                    title: Text(
                                      m.content,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      '${m.senderName} · ${m.timestamp.toLocal()}',
                                    ),
                                    onTap: () => Navigator.pop(context, m.id),
                                  );
                                },
                              ),
                      ),
                      if (state.hasMore)
                        TextButton(
                          onPressed: state.isLoadingMore
                              ? null
                              : () => context.read<ChatBloc>().add(
                                  const LoadMoreMessages(),
                                ),
                          child: Text(l10n.chatCatchUpLoadMore),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
