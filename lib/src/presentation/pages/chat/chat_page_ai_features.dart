// ignore_for_file: invalid_use_of_protected_member
part of 'chat_page.dart';

/// AI 功能相关方法（改写、翻译、摘要、助手）
extension _ChatPageAiFeaturesMethods on _ChatPageState {
  String _smartReplyLanguageTag() =>
      Localizations.localeOf(context).toLanguageTag();

  void _resetAiSmartReplyState() {
    _smartReplySuggestions = const [];
    _isLoadingSmartReplySuggestions = false;
  }

  Widget _buildAiRewriteBar() {
    return AiRewriteBar(
      originalText: _rewriteOriginalText,
      rewrittenText: _rewriteResult,
      isRewriting: _isRewriting,
      selectedTone: _selectedTone,
      onToneSelected: _onRewriteTone,
      onAccept: (text) {
        _inputController.text = text;
        _inputController.selection = TextSelection.fromPosition(
          TextPosition(offset: text.length),
        );
        setState(() {
          _showRewriteBar = false;
          _rewriteResult = null;
          _selectedTone = null;
        });
      },
      onDismiss: () {
        setState(() {
          _showRewriteBar = false;
          _rewriteResult = null;
          _selectedTone = null;
        });
      },
    );
  }

  void _onRewriteTone(AiTone tone) {
    if (!aiServiceAvailable()) return;
    setState(() {
      _selectedTone = tone;
      _isRewriting = true;
      _rewriteResult = null;
    });
    getIt<AiService>()
        .rewriteMessage(_rewriteOriginalText, tone)
        .then((result) {
          if (mounted) {
            setState(() {
              _rewriteResult = result;
              _isRewriting = false;
            });
          }
        })
        .catchError((Object e) {
          if (mounted) {
            setState(() => _isRewriting = false);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('AI rewrite failed: $e')));
          }
        });
  }

  void _showAiRewriteBar() {
    final text = _inputController.text.trim();
    if (text.isEmpty || !aiServiceAvailable()) return;
    setState(() {
      _resetAiSmartReplyState();
      _rewriteOriginalText = text;
      _showRewriteBar = true;
      _rewriteResult = null;
      _selectedTone = null;
    });
  }

  void _openAiAssistant() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const AiAssistantPage()));
  }

  /// 群聊消息摘要。消息离开设备前，用户必须逐条选择本次授权内容。
  Future<void> _summarizeRecentMessages() async {
    if (!aiServiceAvailable() || _isAiSummarizing || _isAiSummaryConsentOpen) {
      return;
    }
    final initialState = context.read<ChatBloc>().state;
    final candidates = initialState.messages
        .where(
          (m) =>
              m.type == MessageType.text &&
              m.content.trim().isNotEmpty &&
              // Summaries go to an external AI endpoint; self-destruct content
              // must not be part of the payload.
              !m.isSelfDestructing,
        )
        .take(50)
        .toList()
        .reversed
        .toList();
    if (candidates.isEmpty) return;

    final manager = MatrixClientManager.instance;
    final approvedClient = manager.client;
    final approvedUserId = manager.userId;
    final approvedRoomId = widget.conversation.id;
    _isAiSummaryConsentOpen = true;
    final selectedIds = await showDialog<Set<String>>(
      context: context,
      builder: (_) => AiMessageConsentDialog(
        messages: candidates
            .map(
              (message) => AiMessageConsentItem(
                id: message.id,
                sender: message.senderName.isEmpty
                    ? (message.isFromMe ? 'Me' : 'Other')
                    : message.senderName,
                content: message.content,
              ),
            )
            .toList(),
      ),
    );
    _isAiSummaryConsentOpen = false;
    if (!mounted || selectedIds == null || selectedIds.isEmpty) return;

    final currentState = context.read<ChatBloc>().state;
    final currentMessagesById = {
      for (final message in currentState.messages) message.id: message,
    };
    final selectedMessages = candidates
        .where((message) => selectedIds.contains(message.id))
        .toList();
    final selectionIsUnchanged =
        selectedMessages.length == selectedIds.length &&
        selectedMessages.every((message) {
          final current = currentMessagesById[message.id];
          return current != null &&
              current.roomId == message.roomId &&
              current.content == message.content &&
              current.senderId == message.senderId &&
              !current.isSelfDestructing;
        });
    if (!selectionIsUnchanged ||
        manager.userId != approvedUserId ||
        !identical(manager.client, approvedClient) ||
        widget.conversation.id != approvedRoomId ||
        currentState.roomId != approvedRoomId) {
      return;
    }

    final texts = selectedMessages
        .map((m) => '${m.senderName}: ${m.content}')
        .join('\n');
    setState(() {
      _isAiSummarizing = true;
      _aiSummaryResult = null;
      _aiSummaryMessageCount = selectedMessages.length;
    });
    try {
      final result = await getIt<AiService>().summarize(texts);
      if (!mounted) return;
      final latestState = context.read<ChatBloc>().state;
      final latestMessagesById = {
        for (final message in latestState.messages) message.id: message,
      };
      final stillAuthorized = selectedMessages.every((message) {
        final current = latestMessagesById[message.id];
        return current != null &&
            current.content == message.content &&
            current.senderId == message.senderId &&
            !current.isSelfDestructing;
      });
      if (stillAuthorized &&
          manager.userId == approvedUserId &&
          identical(manager.client, approvedClient) &&
          widget.conversation.id == approvedRoomId &&
          latestState.roomId == approvedRoomId) {
        setState(() => _aiSummaryResult = result);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e is AiServiceException && e.accessDenied
                  ? S.of(context)!.aiServiceUnavailable
                  : S.of(context)!.aiSummarizeError,
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isAiSummarizing = false);
    }
  }

  Widget _buildAiSmartReplyBar() {
    return AiSmartReplyBar(
      suggestions: _smartReplySuggestions,
      isLoading: _isLoadingSmartReplySuggestions,
      onSelect: (reply) {
        _dismissAiSmartReplyBar();
        _sendMessage(reply);
      },
      onRefresh: _isLoadingSmartReplySuggestions
          ? null
          : () => unawaited(_refreshAiSmartReplies()),
      onDismiss: _dismissAiSmartReplyBar,
    );
  }

  void _handleSmartReplyStateChanged() {
    // Incoming messages never leave the device for AI automatically. The user
    // must open Quick Reply and choose the exact messages to share.
    if (!mounted ||
        _smartReplySuggestions.isEmpty && !_isLoadingSmartReplySuggestions) {
      return;
    }
    setState(_resetAiSmartReplyState);
  }

  Future<void> _refreshAiSmartReplies() async {
    if (!mounted || !aiServiceAvailable()) {
      return;
    }
    setState(() {
      _isLoadingSmartReplySuggestions = true;
      _smartReplySuggestions = const [];
    });
    try {
      final replies = await _loadAiSmartReplies();
      if (!mounted) return;
      setState(() {
        _smartReplySuggestions = replies;
        _isLoadingSmartReplySuggestions = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _resetAiSmartReplyState();
      });
    }
  }

  Future<List<String>> _loadAiSmartReplies() async {
    if (!aiServiceAvailable()) {
      return const [];
    }

    final initialState = context.read<ChatBloc>().state;
    final candidates = initialState.messages
        .where(
          (message) =>
              message.type == MessageType.text &&
              message.content.trim().isNotEmpty &&
              !message.isSelfDestructing,
        )
        .take(6)
        .toList()
        .reversed
        .toList();
    if (candidates.isEmpty || candidates.last.isFromMe) {
      return const [];
    }

    final manager = MatrixClientManager.instance;
    final approvedClient = manager.client;
    final approvedUserId = manager.userId;
    final approvedRoomId = widget.conversation.id;
    final selectedIds = <String>{};
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Share messages with AI?'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text('Select the messages AI may use for this reply.'),
                for (final message in candidates)
                  CheckboxListTile(
                    value: selectedIds.contains(message.id),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      message.senderName.isEmpty
                          ? (message.isFromMe ? 'Me' : 'Other')
                          : message.senderName,
                    ),
                    subtitle: Text(
                      message.content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onChanged: (selected) => setDialogState(() {
                      if (selected == true) {
                        selectedIds.add(message.id);
                      } else {
                        selectedIds.remove(message.id);
                      }
                    }),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: selectedIds.contains(candidates.last.id)
                  ? () => Navigator.pop(dialogContext, true)
                  : null,
              child: const Text('Share selected'),
            ),
          ],
        ),
      ),
    );
    if (approved != true || selectedIds.isEmpty || !mounted) {
      return const [];
    }

    final currentState = context.read<ChatBloc>().state;
    final currentMessagesById = {
      for (final message in currentState.messages) message.id: message,
    };
    final selectionIsUnchanged = candidates
        .where((message) => selectedIds.contains(message.id))
        .every((message) {
          final current = currentMessagesById[message.id];
          return current != null &&
              current.roomId == message.roomId &&
              current.content == message.content &&
              current.senderId == message.senderId &&
              !current.isSelfDestructing;
        });
    if (!selectionIsUnchanged ||
        manager.userId != approvedUserId ||
        !identical(manager.client, approvedClient) ||
        widget.conversation.id != approvedRoomId ||
        currentState.roomId != approvedRoomId) {
      return const [];
    }
    final suggestionContext = AiReplySuggestionHelper.buildContext(
      currentState.messages,
      authorizedMessageIds: selectedIds,
    );
    if (suggestionContext == null ||
        suggestionContext.anchorMessageId != candidates.last.id) {
      return const [];
    }
    final replies = await AiReplySuggestionHelper.loadSuggestions(
      aiService: getIt<AiService>(),
      context: suggestionContext,
      language: _smartReplyLanguageTag(),
    );
    if (!mounted) return const [];
    final latestState = context.read<ChatBloc>().state;
    final latestContext = AiReplySuggestionHelper.buildContext(
      latestState.messages,
    );
    // A grant is one request only. Do not display a result after switching
    // account or conversation, or after the selected conversation advanced.
    if (manager.userId != approvedUserId ||
        !identical(manager.client, approvedClient) ||
        widget.conversation.id != approvedRoomId ||
        latestState.roomId != approvedRoomId ||
        latestContext?.anchorMessageId != suggestionContext.anchorMessageId) {
      return const [];
    }
    return replies;
  }

  void _dismissAiSmartReplyBar() {
    setState(() {
      _resetAiSmartReplyState();
    });
  }
}
