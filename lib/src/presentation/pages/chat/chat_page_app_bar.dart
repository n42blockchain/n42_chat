// ignore_for_file: invalid_use_of_protected_member
part of 'chat_page.dart';

/// AppBar 构建相关方法
extension _ChatPageAppBarMethods on _ChatPageState {
  PreferredSizeWidget _buildAppBar(bool isDark) {
    // 多选模式下显示特殊的工具栏
    if (_isMultiSelectMode) {
      return _buildMultiSelectAppBar(isDark);
    }

    return N42AppBar(
      titleWidget: Column(
        children: [
          Text(
            _getDisplayName(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
          if (widget.conversation.type == ConversationType.group)
            Text(
              S.of(context)?.commonMemberCount(widget.conversation.memberCount) ?? '${widget.conversation.memberCount} members',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
      showBackButton: widget.onBack != null,
      onBackPressed: widget.onBack ?? () => Navigator.of(context).pop(),
      actions: [
        // 私聊显示通话按钮
        if (!widget.conversation.isGroup) ...[
          IconButton(
            icon: const Icon(Icons.phone_outlined),
            onPressed: _startVoiceCall,
            tooltip: S.of(context)?.commonVoiceCall ?? 'Voice Call',
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: _startVideoCall,
            tooltip: S.of(context)?.chatVideoCall ?? 'Video Call',
          ),
        ],
        if (getIt.isRegistered<IAiRepository>())
          IconButton(
            icon: const Icon(Icons.auto_awesome_outlined),
            onPressed: () {
              if (_inputController.text.trim().isNotEmpty) {
                _showAiRewriteBar();
              } else {
                _openAiAssistant();
              }
            },
            tooltip: S.of(context)?.aiAssistant ?? 'AI Assistant',
          ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _toggleSearch,
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: widget.onMorePressed ?? _openChatSettings,
        ),
      ],
    );
  }

  /// 构建多选模式下的 AppBar
  PreferredSizeWidget _buildMultiSelectAppBar(bool isDark) {
    return AppBar(
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: isDark ? Colors.white : Colors.black,
        ),
        onPressed: _exitMultiSelectMode,
      ),
      title: Text(
        _selectedMessageIds.isEmpty
            ? (S.of(context)?.chatSelectMessages ?? 'Select messages')
            : (S.of(context)?.chatSelectedCount(_selectedMessageIds.length) ?? 'Selected ${_selectedMessageIds.length}'),
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        // 全选按钮
        TextButton(
          onPressed: _selectAllMessages,
          child: Text(
            S.of(context)?.chatSelectAll ?? 'Select All',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 14,
            ),
          ),
        ),
      ],
      elevation: 0.5,
    );
  }

  /// 全选消息
  void _selectAllMessages() {
    final state = context.read<ChatBloc>().state;
    setState(() {
      if (_selectedMessageIds.length == state.messages.length) {
        // 如果全部已选中，则取消全选
        _selectedMessageIds.clear();
      } else {
        // 全选
        _selectedMessageIds.clear();
        for (final message in state.messages) {
          _selectedMessageIds.add(message.id);
        }
      }
    });
  }
}
