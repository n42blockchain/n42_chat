// ignore_for_file: invalid_use_of_protected_member
part of 'chat_page.dart';

/// 输入栏、表情选择器、贴纸选择器、更多面板、录音浮层相关方法
extension _ChatPageInputMethods on _ChatPageState {
  Widget _buildInputBar() {
    return ChatInputBar(
      key: _inputBarKey,
      controller: _inputController,
      focusNode: _inputFocusNode,
      onSendText: _sendMessage,
      onSendVoice: _sendVoiceMessage,
      onRecordingStateChanged: _onRecordingStateChanged,
      onChanged: _onInputChanged,
      onVoicePressed: _onVoicePressed,
      onEmojiPressed: _onEmojiPressed,
      onMorePressed: _onMorePressed,
      onQuickReplyPressed: _onQuickReplyPressed,
      onScheduledSend: (scheduledAt) {
        final text = _inputController.text.trim();
        if (text.isNotEmpty) {
          context.read<ChatBloc>().add(SendScheduledMessage(
            text: text,
            scheduledAt: scheduledAt,
          ));
        }
      },
    );
  }

  /// 录音状态变化处理
  void _onRecordingStateChanged(bool isRecording, bool isCancelled, Duration duration) {
    setState(() {
      _isRecording = isRecording;
      _isRecordingCancelled = isCancelled;
      _recordingDuration = duration;
    });
  }

  /// 构建录音浮层
  Widget _buildRecordingOverlay() {
    return Positioned.fill(
      child: GestureDetector(
        // 点击空白区域可以取消录音（作为紧急退出方式）
        onTap: () {
          _inputBarKey.currentState?.cancelRecording();
        },
        child: Container(
          color: Colors.black.withValues(alpha: 0.7),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 录音指示器
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: _isRecordingCancelled ? AppColors.error : AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isRecordingCancelled ? AppColors.error : AppColors.primary)
                            .withValues(alpha: 0.4),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isRecordingCancelled ? Icons.delete : Icons.mic,
                        size: 56,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatDuration(_recordingDuration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // 提示文字
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: _isRecordingCancelled
                        ? AppColors.error.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _isRecordingCancelled
                        ? (S.of(context)?.chatReleaseToCancel ?? 'Release to cancel')
                        : (S.of(context)?.chatReleaseToSend ?? 'Release to send, swipe up to cancel'),
                    style: TextStyle(
                      color: _isRecordingCancelled ? AppColors.error : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // 取消按钮（紧急退出）
                TextButton.icon(
                  onPressed: () {
                    _inputBarKey.currentState?.cancelRecording();
                  },
                  icon: const Icon(Icons.close, color: Colors.white70),
                  label: Text(
                    S.of(context)?.chatTapToCancel ?? 'Tap to cancel',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 构建贴纸选择器面板
  Widget _buildStickerPicker() {
    return StickerPicker(
      onStickerSelected: _onStickerSelected,
      onOpenStore: _openStickerStore,
    );
  }

  /// View Once 提示条
  Widget _buildViewOnceIndicator() {
    final s = S.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.primary.withValues(alpha: 0.1),
      child: Row(
        children: [
          const Icon(Icons.timer, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              s?.chatViewOnce ?? 'View Once',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isViewOnce = false;
              });
            },
            child: const Icon(Icons.close, size: 18, color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildMorePanel() {
    return ChatMorePanel(
      onPhotoPressed: () {
        _hideMorePanel();
        _pickImage();
      },
      onCameraPressed: () {
        _hideMorePanel();
        _takePhoto();
      },
      onVideoCallPressed: () {
        _hideMorePanel();
        _startVideoCall();
      },
      onLocationPressed: () {
        _hideMorePanel();
        _sendLocation();
      },
      onRedPacketPressed: () {
        _hideMorePanel();
        _sendRedPacket();
      },
      onTransferPressed: () {
        _hideMorePanel();
        _sendTransfer();
      },
      onFilePressed: () {
        _hideMorePanel();
        _pickFile();
      },
      onContactCardPressed: () {
        _hideMorePanel();
        _sendContactCard();
      },
      onFavoritePressed: () {
        _hideMorePanel();
        _openFavorites();
      },
      onMusicPressed: () {
        _hideMorePanel();
        _shareMusic();
      },
      onCouponPressed: () {
        _hideMorePanel();
        _selectCoupon();
      },
      onGiftPressed: () {
        _hideMorePanel();
        _sendGift();
      },
      onPollPressed: () {
        _hideMorePanel();
        _createPoll();
      },
      onGifPressed: () {
        _hideMorePanel();
        _showGifPicker();
      },
      onStickerPressed: () {
        _hideMorePanel();
        _toggleStickerPicker();
      },
      isViewOnce: _isViewOnce,
      onViewOncePressed: () {
        setState(() {
          _isViewOnce = !_isViewOnce;
        });
      },
      onLiveLocationPressed: () {
        _hideMorePanel();
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => LiveLocationPage(
              roomId: widget.conversation.id,
            ),
          ),
        );
      },
      isFaceBlur: _autoFaceBlur,
      onFaceBlurPressed: _toggleFaceBlur,
      onAiAssistantPressed: getIt.isRegistered<IAiRepository>() ? () {
        _hideMorePanel();
        _openAiAssistant();
      } : null,
    );
  }

  void _hideMorePanel() {
    setState(() {
      _showMorePanel = false;
      _showEmojiPicker = false;
      _showStickerPicker = false;
    });
  }

  void _onVoicePressed() {
    // 语音录制由 ChatInputBar 内部处理（长按录音模式）
    // 此回调仅用于接收模式切换通知
  }

  void _onEmojiPressed() {
    // 隐藏键盘
    _inputFocusNode.unfocus();
    // 切换表情选择器
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
      _showMorePanel = false;
    });
  }

  void _onMorePressed() {
    // 隐藏键盘
    _inputFocusNode.unfocus();
    // 切换更多功能面板
    setState(() {
      _showMorePanel = !_showMorePanel;
      _showEmojiPicker = false;
    });
  }

  Widget _buildEmojiPicker() {
    return EmojiPicker(
      height: 260,
      onEmojiSelected: (emoji) {
        // 在当前光标位置插入表情
        final text = _inputController.text;
        final selection = _inputController.selection;

        String newText;
        int newCursorPos;

        if (selection.isValid && selection.isCollapsed) {
          // 有光标位置
          final cursorPos = selection.baseOffset;
          newText = text.substring(0, cursorPos) + emoji + text.substring(cursorPos);
          newCursorPos = cursorPos + emoji.length;
        } else if (selection.isValid && !selection.isCollapsed) {
          // 有选中文本，替换选中的文本
          newText = text.substring(0, selection.start) + emoji + text.substring(selection.end);
          newCursorPos = selection.start + emoji.length;
        } else {
          // 没有光标，添加到末尾
          newText = text + emoji;
          newCursorPos = newText.length;
        }

        _inputController.text = newText;
        _inputController.selection = TextSelection.fromPosition(
          TextPosition(offset: newCursorPos),
        );
      },
      onBackspace: () {
        // 删除光标前的字符（包括表情）
        final text = _inputController.text;
        final selection = _inputController.selection;

        if (text.isEmpty) return;

        if (selection.isValid && selection.isCollapsed) {
          final cursorPos = selection.baseOffset;
          if (cursorPos > 0) {
            // 处理 emoji（可能是多个代码单元）
            final beforeCursor = text.substring(0, cursorPos);
            final runes = beforeCursor.runes.toList();
            if (runes.isNotEmpty) {
              runes.removeLast();
              final newBeforeCursor = String.fromCharCodes(runes);
              final newText = newBeforeCursor + text.substring(cursorPos);
              _inputController.text = newText;
              _inputController.selection = TextSelection.fromPosition(
                TextPosition(offset: newBeforeCursor.length),
              );
            }
          }
        } else if (selection.isValid && !selection.isCollapsed) {
          // 有选中文本，删除选中的文本
          final newText = text.substring(0, selection.start) + text.substring(selection.end);
          _inputController.text = newText;
          _inputController.selection = TextSelection.fromPosition(
            TextPosition(offset: selection.start),
          );
        }
      },
      onSend: _inputController.text.isNotEmpty
          ? () {
              _sendMessage(_inputController.text);
              setState(() {
                _showEmojiPicker = false;
              });
            }
          : null,
    );
  }

  /// 构建 @ 提醒成员选择器
  Widget _buildMentionPicker() {
    final isDark = context.isDarkMode;
    final bgColor = isDark ? const Color(0xFF2C2C2E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtextColor = isDark ? Colors.white54 : Colors.black54;
    final borderColor = isDark ? Colors.white10 : Colors.grey[300]!;

    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(color: borderColor, width: 0.5),
        ),
      ),
      child: FutureBuilder<List<Map<String, String>>>(
        future: _loadGroupMembers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final members = snapshot.data ?? [];

          // 过滤成员
          final filteredMembers = _mentionSearchQuery.isEmpty
              ? members
              : members.where((m) {
                  final name = m['name']?.toLowerCase() ?? '';
                  return name.contains(_mentionSearchQuery.toLowerCase());
                }).toList();

          if (filteredMembers.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _mentionSearchQuery.isEmpty
                    ? (S.of(context)?.chatNoMembers ?? 'No members')
                    : (S.of(context)?.chatMemberNotFound ?? 'Member not found'),
                style: TextStyle(color: subtextColor),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: filteredMembers.length,
            itemBuilder: (context, index) {
              final member = filteredMembers[index];
              final name = member['name'] ?? '';
              final avatarUrl = member['avatarUrl'] ?? '';
              final userId = member['id'] ?? '';

              // 排除自己
              if (userId == _currentUserId) {
                return const SizedBox.shrink();
              }

              return InkWell(
                onTap: () => _onMentionMemberSelected(name, userId),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: borderColor, width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      // 头像
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: avatarUrl.isNotEmpty
                            ? NetworkImage(avatarUrl)
                            : null,
                        child: avatarUrl.isEmpty
                            ? Text(
                                name.isNotEmpty ? name[0].toUpperCase() : '?',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      // 名称
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _onQuickReplyPressed() {
    showQuickReplySheet(
      context: context,
      onSelect: (content) {
        _sendMessage(content);
      },
      onManage: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => QuickRepliesPage(
              storageDataSource: getIt<PreferencesDataSource>(),
            ),
          ),
        );
      },
      storageDataSource: getIt<PreferencesDataSource>(),
    );
  }
}
