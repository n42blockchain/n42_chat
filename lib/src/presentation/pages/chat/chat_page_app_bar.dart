// ignore_for_file: invalid_use_of_protected_member
part of 'chat_page.dart';

/// Minimum tappable size for each top bar button (iOS 44pt).
const double _chatAppBarButtonSize = 44;

/// AppBar 构建相关方法
extension _ChatPageAppBarMethods on _ChatPageState {
  PreferredSizeWidget _buildAppBar() {
    // 多选模式下显示特殊的工具栏
    if (_isMultiSelectMode) {
      return _buildMultiSelectAppBar();
    }

    // 检测桥接平台
    final bridgePlatform = BridgeDetectionUtils.detectFromConversation(
      widget.conversation,
    );
    final memberCount =
        _groupMemberCountOverride ?? widget.conversation.memberCount;

    return N42AppBar(
      titleWidget: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (prev, curr) => prev.isChannel != curr.isChannel,
        builder: (context, chatState) {
          return Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (chatState.isChannel)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: AppDimensions.spacingXS,
                      ),
                      child: Icon(
                        Icons.campaign,
                        size: 18,
                        color: context.textPrimary,
                      ),
                    ),
                  // 桥接平台小图标
                  if (bridgePlatform != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: AppDimensions.spacingXS,
                      ),
                      child: Icon(
                        BridgePlatformRegistry.getInfo(bridgePlatform).icon,
                        size: 16,
                        color: BridgePlatformRegistry.getInfo(bridgePlatform)
                            .brandColor,
                      ),
                    ),
                  Flexible(
                    child: Text(
                      _getDisplayName(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: context.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.conversation.type == ConversationType.group)
                Text(
                  chatState.isChannel
                      ? '$memberCount ${S.of(context)?.channelSubscribers ?? 'subscribers'}'
                      : (S.of(context)?.commonMemberCount(memberCount) ??
                            '$memberCount members'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.captionSmall.copyWith(
                    color: context.textSecondary,
                    fontSize: 12,
                  ),
                ),
            ],
          );
        },
      ),
      // Always let N42AppBar build the back button (shown only when the route
      // can pop) so it is left-aligned in the leading slot.
      showBackButton: true,
      onBackPressed: widget.onBack ?? () => Navigator.of(context).pop(),
      // Group chats center the title between equal 44pt slots (back button vs.
      // the "..." menu). Direct chats keep the call buttons on the right and let
      // the title fill the space between the back button and the actions, like a
      // normal left-anchored AppBar title, so it stays usable at narrow widths.
      centerTitle: widget.conversation.isGroup,
      leadingWidth: widget.conversation.isGroup ? _chatAppBarButtonSize : null,
      actions: _buildAppBarActions(),
    );
  }

  /// Private chats keep voice and video in the top bar; group chats have none.
  /// Everything else lives in the "..." menu.
  List<Widget> _buildAppBarActions() {
    final s = S.of(context);
    return [
      if (!widget.conversation.isGroup) ...[
        _buildAppBarCallButton(
          icon: Icons.phone_outlined,
          tooltip: s?.commonVoiceCall ?? 'Voice Call',
          onPressed: _startVoiceCall,
        ),
        _buildAppBarCallButton(
          icon: Icons.videocam_outlined,
          tooltip: s?.chatVideoCall ?? 'Video Call',
          onPressed: _startVideoCall,
        ),
      ],
      _buildAppBarMoreButton(),
    ];
  }

  Widget _buildAppBarCallButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    // IconButton enforces a 48pt minimum on its own, so the 44pt size is set by
    // the tight SizedBox around it.
    return SizedBox(
      width: _chatAppBarButtonSize,
      height: _chatAppBarButtonSize,
      child: IconButton(
        icon: Icon(icon),
        tooltip: tooltip,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }

  /// Single "..." menu for the secondary actions. Sized to 44pt explicitly
  /// because PopupMenuButton's own minimum is 48pt.
  Widget _buildAppBarMoreButton() {
    final isGroup = widget.conversation.isGroup;
    final s = S.of(context);
    return SizedBox(
      width: _chatAppBarButtonSize,
      height: _chatAppBarButtonSize,
      child: PopupMenuButton<VoidCallback>(
        icon: const Icon(Icons.more_horiz),
        // 24pt icon + 2 x 10pt padding = 44pt.
        padding: const EdgeInsets.all(10),
        tooltip: s?.commonMore ?? 'More',
        onSelected: (action) => action(),
        itemBuilder: (context) => [
          if (isGroup) ...[
            PopupMenuItem<VoidCallback>(
              value: _openCatchUp,
              child: Text(s?.chatCatchUp ?? 'Catch up'),
            ),
            PopupMenuItem<VoidCallback>(
              value: _openGroupTopics,
              child: Text(s?.groupTopics ?? 'Topics'),
            ),
          ],
          PopupMenuItem<VoidCallback>(
            value: _toggleSearch,
            child: Text(s?.commonSearch ?? 'Search'),
          ),
          if (getIt.isRegistered<IAiRepository>())
            PopupMenuItem<VoidCallback>(
              value: _onAiAppBarPressed,
              child: Text(s?.aiAssistant ?? 'AI Assistant'),
            ),
          PopupMenuItem<VoidCallback>(
            value: widget.onMorePressed ?? _openChatSettings,
            child: Text(s?.commonSettings ?? 'Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _openCatchUp() async {
    final id = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<ChatBloc>(),
        child: ChatCatchUpSheet(
          roomId: widget.conversation.id,
          userId: _currentUserId,
          onShareHistory: getIt.isRegistered<IChatCatchUpRepository>()
              ? () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => HistorySharePage(
                        roomId: widget.conversation.id,
                        messages: context.read<ChatBloc>().state.messages,
                        repository: getIt<IChatCatchUpRepository>(),
                        conversations: getIt<IConversationRepository>(),
                      ),
                    ),
                  );
                }
              : null,
        ),
      ),
    );
    if (mounted && id != null) await _scrollToMessage(id);
  }

  void _openGroupTopics() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => GroupTopicsPage(roomId: widget.conversation.id),
      ),
    );
  }

  void _onAiAppBarPressed() {
    if (_inputController.text.trim().isNotEmpty) {
      _showAiRewriteBar();
    } else {
      _openAiAssistant();
    }
  }

  /// 构建多选模式下的 AppBar
  PreferredSizeWidget _buildMultiSelectAppBar() {
    final fgColor = context.textPrimary;
    return AppBar(
      backgroundColor: context.surfaceColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(AppIcons.close, color: fgColor),
        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
        onPressed: _exitMultiSelectMode,
      ),
      title: Text(
        _selectedMessageIds.isEmpty
            ? (S.of(context)?.chatSelectMessages ?? 'Select messages')
            : (S.of(context)?.chatSelectedCount(_selectedMessageIds.length) ??
                  'Selected ${_selectedMessageIds.length}'),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.headlineSmall.copyWith(color: fgColor),
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: _selectAllMessages,
          child: Text(
            S.of(context)?.chatSelectAll ?? 'Select All',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primaryOnTintOf(context),
            ),
          ),
        ),
      ],
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
