// ignore_for_file: invalid_use_of_protected_member
part of 'chat_page.dart';

/// 消息菜单相关方法（长按菜单、举报、搜索选项）
extension _ChatPageMessageMenuMethods on _ChatPageState {
  void _showMessageMenu(MessageEntity message) {
    // 使用旧的底部菜单作为 fallback
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ChatMessageMenuSheet(
        message: message,
        onCopy: () {
          Navigator.pop(ctx);
          _copyMessage(message);
        },
        onReply: () {
          Navigator.pop(ctx);
          context.read<ChatBloc>().add(SetReplyTarget(message));
        },
        onForward: (message.type == MessageType.redPacket || message.type == MessageType.transfer)
            ? null
            : () {
                Navigator.pop(ctx);
                _forwardMessage(message);
              },
        onDelete: message.isFromMe
            ? () {
                Navigator.pop(ctx);
                _recallMessage(message);
              }
            : null,
      ),
    );
  }

  /// 显示微信风格的消息菜单
  void _showWeChatMessageMenu(MessageEntity message, GlobalKey messageKey) {
    // 已撤回的消息不显示菜单
    if (message.type == MessageType.redacted) {
      return;
    }

    // 获取消息气泡的位置和大小
    final RenderBox? renderBox = messageKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      // fallback 到旧菜单
      _showMessageMenu(message);
      return;
    }

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    // 震动反馈
    HapticFeedback.mediumImpact();

    // 显示菜单
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    // 获取置顶状态
    final chatState = context.read<ChatBloc>().state;
    final isPinned = chatState.pinnedMessages.any((m) => m.id == message.id);
    final canPin = chatState.canPinMessages;

    overlayEntry = OverlayEntry(
      builder: (ctx) => WeChatMessageMenu(
        message: message,
        position: position,
        messageSize: size,
        isFavorited: _favoritedMessageIds.contains(message.id),
        isPinned: isPinned,
        canPin: canPin,
        onDismiss: () {
          debugPrint('Menu dismissed');
          overlayEntry.remove();
        },
        onCopy: () {
          debugPrint('Copy clicked');
          _copyMessage(message);
        },
        // 红包和转账消息不能转发
        onForward: (message.type == MessageType.redPacket || message.type == MessageType.transfer)
            ? null
            : () {
                debugPrint('Forward clicked');
                _forwardMessage(message);
              },
        onFavorite: () {
          debugPrint('Favorite clicked');
          _favoriteMessage(message);
        },
        onRecall: () {
          debugPrint('Recall clicked');
          _recallMessage(message);
        },
        onMultiSelect: () {
          debugPrint('MultiSelect clicked');
          _enterMultiSelectMode();
        },
        onQuote: () {
          debugPrint('Quote clicked');
          _quoteMessage(message);
        },
        onRemind: () {
          debugPrint('Remind clicked');
          _remindMessage(message);
        },
        onSearch: () {
          debugPrint('Search clicked');
          _searchMessage(message);
        },
        onDelete: () {
          debugPrint('Delete message locally clicked');
          _deleteMessageLocally(message);
        },
        onResend: () {
          debugPrint('Resend clicked');
          _onResend(message);
        },
        onSave: () {
          debugPrint('Save clicked');
          _saveMedia(message);
        },
        onReaction: (emoji) {
          debugPrint('Reaction clicked: $emoji');
          _addReaction(message, emoji);
        },
        onPin: () {
          debugPrint('Pin clicked');
          context.read<ChatBloc>().add(PinMessage(message.id));
        },
        onUnpin: () {
          debugPrint('Unpin clicked');
          context.read<ChatBloc>().add(UnpinMessage(message.id));
        },
        onViewEditHistory: message.isEdited ? () {
          debugPrint('View edit history clicked');
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) => EditHistorySheet(
              roomId: message.roomId,
              messageId: message.id,
            ),
          );
        } : null,
        onReplyInThread: () {
          debugPrint('Reply in thread clicked');
          _navigateToThread(message);
        },
        onEdit: () {
          debugPrint('Edit clicked');
          _enterEditMode(message);
        },
        onTranslate: (getIt.isRegistered<AiService>() && message.type == MessageType.text) ? () {
          debugPrint('Translate clicked');
          _translateMessage(message);
        } : null,
        onReport: message.isFromMe ? null : () {
          debugPrint('Report clicked');
          _showReportDialog(message);
        },
      ),
    );

    overlay.insert(overlayEntry);
  }

  void _showReportDialog(MessageEntity message) {
    final l10n = S.of(context);
    String? selectedReason;
    final reasons = [
      l10n?.chatReportSpam ?? 'Spam',
      l10n?.chatReportHarassment ?? 'Harassment',
      l10n?.chatReportInappropriate ?? 'Inappropriate Content',
      l10n?.chatReportOther ?? 'Other',
    ];
    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n?.chatReportMessage ?? 'Report'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: reasons.map((reason) {
              return RadioListTile<String>(
                title: Text(reason),
                value: reason,
                groupValue: selectedReason,
                onChanged: (v) => setDialogState(() => selectedReason = v),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n?.commonCancel ?? 'Cancel'),
            ),
            TextButton(
              onPressed: selectedReason == null
                  ? null
                  : () {
                      Navigator.pop(dialogContext);
                      context.read<ChatBloc>().add(
                            ReportMessage(message.id, selectedReason!),
                          );
                    },
              child: Text(l10n?.commonConfirm ?? 'OK'),
            ),
          ],
        ),
      ),
    );
  }

  /// 搜一搜
  void _searchMessage(MessageEntity message) {
    if (message.type != MessageType.text || message.content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatOnlyTextSearchable ?? 'Only text messages can be searched'),
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }

    // 使用浏览器搜索
    _showSearchOptionsDialog(message.content);
  }

  /// 显示搜索选项对话框
  Future<void> _showSearchOptionsDialog(String searchText) async {
    final isDark = context.isDarkMode;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  S.of(context)?.chatSearchFor(searchText) ?? 'Search "$searchText"',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildSearchOption(
                context,
                icon: Icons.search,
                title: S.of(context)?.chatBaiduSearch ?? 'Baidu Search',
                onTap: () {
                  Navigator.pop(ctx);
                  _openSearch('https://www.baidu.com/s?wd=${Uri.encodeComponent(searchText)}');
                },
                isDark: isDark,
              ),
              _buildSearchOption(
                context,
                icon: Icons.g_mobiledata,
                title: S.of(context)?.chatGoogleSearch ?? 'Google Search',
                onTap: () {
                  Navigator.pop(ctx);
                  _openSearch('https://www.google.com/search?q=${Uri.encodeComponent(searchText)}');
                },
                isDark: isDark,
              ),
              _buildSearchOption(
                context,
                icon: Icons.article,
                title: S.of(context)?.chatBingSearch ?? 'Bing Search',
                onTap: () {
                  Navigator.pop(ctx);
                  _openSearch('https://www.bing.com/search?q=${Uri.encodeComponent(searchText)}');
                },
                isDark: isDark,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDark ? Colors.white70 : Colors.black54),
      title: Text(
        title,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
      ),
      onTap: onTap,
    );
  }

  Future<void> _openSearch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.chatCannotOpenBrowser ?? 'Cannot open browser')),
        );
      }
    }
  }
}
