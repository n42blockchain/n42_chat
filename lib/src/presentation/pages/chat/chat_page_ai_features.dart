// ignore_for_file: invalid_use_of_protected_member
part of 'chat_page.dart';

/// AI 功能相关方法（改写、翻译、摘要、助手）
extension _ChatPageAiFeaturesMethods on _ChatPageState {
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
    if (!getIt.isRegistered<AiService>()) return;
    setState(() {
      _selectedTone = tone;
      _isRewriting = true;
      _rewriteResult = null;
    });
    getIt<AiService>().rewriteMessage(_rewriteOriginalText, tone).then((result) {
      if (mounted) {
        setState(() {
          _rewriteResult = result;
          _isRewriting = false;
        });
      }
    }).catchError((Object e) {
      if (mounted) {
        setState(() => _isRewriting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('AI rewrite failed: $e')),
        );
      }
    });
  }

  void _showAiRewriteBar() {
    final text = _inputController.text.trim();
    if (text.isEmpty || !getIt.isRegistered<AiService>()) return;
    setState(() {
      _rewriteOriginalText = text;
      _showRewriteBar = true;
      _rewriteResult = null;
      _selectedTone = null;
    });
  }

  void _translateMessage(MessageEntity message) {
    if (!getIt.isRegistered<AiService>()) return;
    final text = message.type == MessageType.text ? message.content : '';
    if (text.isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context)?.aiSummarizeLoading ?? 'Translating...')),
    );

    final targetLang = Localizations.localeOf(context).languageCode == 'zh' ? 'English' : '中文';
    getIt<AiService>().translateMessage(text, targetLang).then((result) {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(S.of(context)?.commonTranslate ?? 'Translate'),
            content: SelectableText(result),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(S.of(context)?.commonConfirm ?? 'OK'),
              ),
            ],
          ),
        );
      }
    }).catchError((Object e) {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Translate failed: $e')),
        );
      }
    });
  }

  void _openAiAssistant() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const AiAssistantPage(),
      ),
    );
  }

  /// 群聊消息摘要
  void _summarizeRecentMessages() {
    if (!getIt.isRegistered<AiService>() || _isAiSummarizing) return;
    final messages = context.read<ChatBloc>().state.messages;
    final textMessages = messages
        .where((m) => m.type == MessageType.text && m.content.trim().isNotEmpty)
        .take(50)
        .toList()
        .reversed;
    if (textMessages.isEmpty) return;
    final texts = textMessages.map((m) => '${m.senderName}: ${m.content}').join('\n');
    setState(() { _isAiSummarizing = true; _aiSummaryResult = null; });
    getIt<AiService>().summarize(texts).then((result) {
      if (mounted) setState(() { _aiSummaryResult = result; _isAiSummarizing = false; });
    }).catchError((Object e) {
      if (mounted) {
        setState(() => _isAiSummarizing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Summarize failed: $e')),
        );
      }
    });
  }
}
