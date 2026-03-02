// ignore_for_file: invalid_use_of_protected_member
part of 'chat_page.dart';

/// 更多功能相关方法（红包、转账、位置、名片、音乐、投票、GIF、贴纸、通话等）
extension _ChatPageMoreFeaturesMethods on _ChatPageState {
  /// 显示位置选项菜单（微信风格）
  Future<void> _sendLocation() async {
    final isDark = context.isDarkMode;
    unawaited(showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 发送位置
              ListTile(
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                title: Text(
                  S.of(context)?.chatSendLocation ?? 'Send Location',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
                subtitle: Text(
                  S.of(context)?.chatSelectLocationAndSend ?? 'Select location and send',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _openLocationPicker();
                },
              ),
              Divider(height: 1, color: isDark ? AppColors.dividerDark : AppColors.divider),
              // 共享实时位置
              ListTile(
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.share_location,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
                title: Text(
                  S.of(context)?.chatShareRealTimeLocation ?? 'Share Real-time Location',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
                subtitle: Text(
                  S.of(context)?.chatShareLocationForOneHour ?? 'Share real-time location with friend for 1 hour',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _shareRealTimeLocation();
                },
              ),
              const SizedBox(height: 8),
              // 取消按钮
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: isDark ? AppColors.backgroundDark : Colors.grey[100],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    S.of(context)?.commonCancel ?? 'Cancel',
                    style: TextStyle(
                      color: isDark ? AppColors.textPrimaryDark : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    ));
  }

  /// 打开位置选择页面
  Future<void> _openLocationPicker() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute<Map<String, dynamic>>(
        builder: (context) => const ChatLocationPickerPage(),
      ),
    );

    if (result != null && mounted) {
      final latitude = result['latitude'] as double;
      final longitude = result['longitude'] as double;
      final address = result['address'] as String? ?? (S.of(context)?.chatMyLocation ?? 'My location');
      final name = result['name'] as String?;

      // 发送位置消息
      context.read<ChatBloc>().add(SendLocationMessage(
        latitude: latitude,
        longitude: longitude,
        description: name ?? address,
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatLocationSent ?? 'Location sent'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  /// 共享实时位置
  Future<void> _shareRealTimeLocation() async {
    // 检查位置服务和权限
    if (!await _checkLocationPermission()) return;

    if (!mounted) return;
    // 显示共享确认对话框
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.chatShareRealTimeLocation ?? 'Share Real-time Location'),
        content: Text(
          S.of(context)?.chatRealTimeLocationShareMessage ?? 'After sharing, the other party can see your real-time location for 1 hour.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(S.of(context)?.chatStartSharing ?? 'Start Sharing'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      // 导航到实时位置共享页面
      unawaited(Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder: (_) => LiveLocationPage(roomId: widget.conversation.id),
        ),
      ));
    }
  }

  void _sendRedPacket() {
    showDialog<void>(
      context: context,
      builder: (context) => SendRedPacketDialog(
        receiverName: _getDisplayName(),
        isGroup: widget.conversation.isGroup,
        memberCount: widget.conversation.memberCount,
        onSend: (amount, token, greeting, count, isLucky) {
          _doSendRedPacket(amount, token, greeting, count, isLucky);
        },
      ),
    );
  }

  Future<void> _doSendRedPacket(String amount, String token, String greeting, int count, bool isLucky) async {
    final l10n = S.of(context);
    final walletBridge = getIt<IWalletBridge>();

    // 余额校验
    try {
      final balance = await walletBridge.getBalance(token);
      final balanceNum = double.tryParse(balance) ?? 0;
      final amountNum = double.tryParse(amount) ?? 0;
      if (balanceNum < amountNum) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n?.redPacketInsufficientBalance ?? 'Insufficient balance'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
    } catch (e) {
      debugLog('Red packet balance check failed: $e');
    }

    // 创建红包
    try {
      final redPacketService = getIt<IRedPacketService>();
      final currentUserId = await getIt<IMessageRepository>().getCurrentUserId() ?? '';
      await redPacketService.createRedPacket(
        roomId: context.read<ChatBloc>().state.roomId ?? '',
        totalAmount: double.tryParse(amount) ?? 0,
        totalCount: count,
        token: token,
        type: isLucky ? RedPacketType.lucky : RedPacketType.normal,
        greeting: greeting,
        senderId: currentUserId,
        senderName: _getDisplayName(),
      );
    } catch (e) {
      debugLog('Red packet creation failed: $e');
    }

    // 发送红包消息
    final metadata = MessageMetadata(
      amount: amount,
      token: token,
      transferStatus: 'pending',
    );

    if (!mounted) return;
    context.read<ChatBloc>().add(SendCustomMessage(
      content: greeting,
      type: MessageType.redPacket,
      metadata: metadata,
    ));

    // 显示发送成功提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.chatRedPacketSent(amount, token) ?? 'Sent $amount $token red packet'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _sendTransfer() {
    showDialog<void>(
      context: context,
      builder: (context) => SendTransferDialog(
        receiverName: _getDisplayName(),
        receiverAvatar: widget.conversation.avatarUrl,
        onSend: (amount, token, memo) {
          _doSendTransfer(amount, token, memo);
        },
      ),
    );
  }

  void _doSendTransfer(String amount, String token, String? memo) {
    // 发送转账消息
    final metadata = MessageMetadata(
      amount: amount,
      token: token,
      transferStatus: 'pending',
    );

    context.read<ChatBloc>().add(SendCustomMessage(
      content: memo ?? (S.of(context)?.chatTransferDefault ?? 'Transfer'),
      type: MessageType.transfer,
      metadata: metadata,
    ));

    // 显示发送成功提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context)?.chatTransferSent(amount, token) ?? 'Sent $amount $token transfer'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  /// 发送名片
  Future<void> _sendContactCard() async {
    debugLog('Send contact card');

    // 预先获取本地化字符串，确保使用正确的语言
    final l10n = S.of(context);
    final selectContactText = l10n?.chatSelectContact ?? 'Select Contact';
    final searchContactHintText = l10n?.chatSearchContactHint ?? 'Search contacts';
    final noContactsFoundText = l10n?.contactNoContactsFound ?? 'No contacts found';
    final isDark = context.isDarkMode;

    // 显示联系人选择对话框
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ContactCardSelectSheet(
        isDark: isDark,
        selectContactText: selectContactText,
        searchContactHintText: searchContactHintText,
        noContactsFoundText: noContactsFoundText,
      ),
    );

    if (result != null && mounted) {
      final contactId = result['id'] as String;
      final contactName = result['name'] as String;
      final contactAvatar = result['avatar'] as String?;

      // 发送名片消息（作为自定义消息类型）
      // 名片消息格式使用固定英文键名便于解析，显示时再本地化
      // Format: [Contact Card]\nName: xxx\nID: xxx\nAvatar: xxx
      final cardContent = '''[Contact Card]
Name: $contactName
ID: $contactId
Avatar: ${contactAvatar ?? ''}''';

      // 使用文本消息发送名片信息（后续可改为专门的名片消息类型）
      context.read<ChatBloc>().add(SendTextMessage(cardContent));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatContactCardSent(contactName) ?? 'Sent $contactName\'s contact card'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _startVideoCall() async {
    await _startCall(isVideo: true);
  }

  Future<void> _startVoiceCall() async {
    await _startCall(isVideo: false);
  }

  Future<void> _startCall({required bool isVideo}) async {
    final callManager = N42Chat.callManager;

    if (callManager == null || !callManager.isInitialized) {
      // 尝试初始化
      await N42Chat.initializeCallManager();
      if (N42Chat.callManager == null) {
        if (mounted) {
          WeChatToast.warning(
            context,
            S.of(context)?.chatCallServiceNotInitialized ?? 'Call service not available',
          );
        }
        return;
      }
    }

    // 设置错误回调（确保在发起通话前设置）
    N42Chat.callManager?.onError = _handleCallError;

    // 获取对方信息（私聊）
    if (!widget.conversation.isGroup) {
      final peerId = widget.conversation.directUserId;
      if (peerId == null) {
        if (mounted) {
          WeChatToast.warning(
            context,
            S.of(context)?.chatError ?? 'Cannot start call',
          );
        }
        return;
      }

      // 发起通话，错误会通过 onError 回调处理
      if (isVideo) {
        await N42Chat.callManager!.startVideoCall(
          roomId: widget.conversation.id,
          peerId: peerId,
          peerName: widget.conversation.name,
          peerAvatarUrl: widget.conversation.avatarUrl,
        );
      } else {
        await N42Chat.callManager!.startVoiceCall(
          roomId: widget.conversation.id,
          peerId: peerId,
          peerName: widget.conversation.name,
          peerAvatarUrl: widget.conversation.avatarUrl,
        );
      }
    } else {
      // 群组通话需要 LiveKit 支持
      if (mounted) {
        WeChatToast.info(
          context,
          S.of(context)?.commonFeatureComingSoon('Group Call') ?? 'Group calls coming soon',
        );
      }
    }
  }

  void _openFavorites() {
    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (_) => const FavoriteListPage()),
    );
  }

  /// 分享音乐
  Future<void> _shareMusic() async {
    debugLog('Share music');

    // 显示音乐选择对话框
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MusicSelectSheet(
        isDark: context.isDarkMode,
      ),
    );

    if (result != null && mounted) {
      final songName = result['name'] as String;
      final artist = result['artist'] as String;
      final url = result['url'] as String?;
      final cover = result['cover'] as String?;
      final isLocal = result['isLocal'] == true;

      if (isLocal && url != null && url.isNotEmpty) {
        // 本地音频文件 - 作为文件发送，同时发送音乐卡片
        try {
          final file = File(url);
          if (await file.exists()) {
            final bytes = await file.readAsBytes();
            final mimeType = lookupMimeType(url) ?? 'audio/mpeg';
            final filename = url.split('/').last.split('\\').last;

            if (!mounted) return;
            // 先发送音频文件
            context.read<ChatBloc>().add(SendFileMessage(
              fileBytes: bytes,
              filename: filename,
              mimeType: mimeType,
            ));

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context)?.chatSharedMusic(songName) ?? 'Shared $songName'),
                duration: const Duration(seconds: 1),
              ),
            );
          } else {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context)?.chatFileNotExist ?? 'File does not exist'), backgroundColor: Colors.red),
            );
          }
        } catch (e) {
          debugLog('Error sending local music: $e');
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context)?.chatSendFailed(e.toString()) ?? 'Send failed: $e'), backgroundColor: Colors.red),
          );
        }
      } else {
        // 网络链接或推荐歌曲 - 发送音乐卡片消息
        context.read<ChatBloc>().add(SendCustomMessage(
          type: MessageType.music,
          content: '🎵 $songName - $artist',
          metadata: MessageMetadata(
            musicTitle: songName,
            musicArtist: artist,
            musicUrl: url,
            musicCover: cover,
          ),
        ));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatSharedMusic(songName) ?? 'Shared $songName'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    }
  }

  void _selectCoupon() {
    // TODO(backend): 实现选择卡券功能 — 需要卡券系统集成
    debugLog('Select coupon');
    _showFeatureToast(S.of(context)?.chatCouponsFeature ?? 'Coupons');
  }

  void _sendGift() {
    // TODO(backend): 实现发送礼物功能 — 需要礼物系统集成
    debugLog('Send gift');
    _showFeatureToast(S.of(context)?.chatGiftFeature ?? 'Gift');
  }

  /// 创建投票
  void _createPoll() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PollCreateSheet(),
    );

    if (result != null && mounted) {
      final question = result['question'] as String;
      final options = result['options'] as List<String>;
      final maxSelections = result['maxSelections'] as int? ?? 1;

      debugLog('ChatPage: Creating poll - question: $question, options: $options, maxSelections: $maxSelections');

      context.read<ChatBloc>().add(SendPollMessage(
        question: question,
        options: options,
        maxSelections: maxSelections,
      ));
    }
  }

  /// 显示 GIF 选择器
  Future<void> _showGifPicker() async {
    final gif = await showGifPicker(context);
    if (gif != null && mounted) {
      debugLog('ChatPage: Sending GIF - ${gif.title}');
      context.read<ChatBloc>().add(SendGifMessage(
        gifUrl: gif.originalUrl,
        previewUrl: gif.previewUrl,
        width: gif.width,
        height: gif.height,
        title: gif.title,
      ));
    }
  }

  /// 显示/隐藏贴纸选择器面板
  void _toggleStickerPicker() {
    setState(() {
      _showStickerPicker = !_showStickerPicker;
      _showMorePanel = false;
      _showEmojiPicker = false;
      if (_showStickerPicker) {
        _inputFocusNode.unfocus();
      }
    });
  }

  /// 发送贴纸消息
  void _onStickerSelected(Sticker sticker, String packId) {
    debugLog('ChatPage: Sending sticker ${sticker.id} from pack $packId');
    context.read<ChatBloc>().add(SendStickerMessage(
      stickerId: sticker.id,
      packId: packId,
      url: sticker.url,
      httpUrl: sticker.httpUrl,
      name: sticker.name,
      emoji: sticker.emoji,
      width: sticker.width,
      height: sticker.height,
      mimeType: sticker.mimeType,
      size: sticker.size,
    ));

    // 发送后隐藏贴纸面板
    setState(() {
      _showStickerPicker = false;
    });
  }

  /// 打开贴纸商店
  void _openStickerStore() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const StickerStorePage(),
      ),
    );
  }

  /// 投票选项点击
  void _onPollVote(String pollEventId, String optionId, List<String> currentVotes, int maxSelections) {
    // 防止重复投票 - 如果正在处理投票，忽略新的点击
    if (_votingPollIds.contains(pollEventId)) {
      debugLog('ChatPage: Ignoring duplicate vote on poll $pollEventId');
      return;
    }

    // 计算新的投票选项列表
    List<String> newVotes;
    String actionMessage;
    final s = S.of(context);

    if (currentVotes.contains(optionId)) {
      // 点击已选选项 -> 取消投票
      newVotes = currentVotes.where((id) => id != optionId).toList();
      actionMessage = s?.chatVoteRemoved ?? 'Vote removed';
    } else if (maxSelections == 1) {
      // 单选 -> 直接替换为新选项
      newVotes = [optionId];
      actionMessage = s?.chatVoteChanged ?? 'Vote changed';
    } else {
      // 多选 -> 添加新选项
      newVotes = [...currentVotes, optionId];
      actionMessage = s?.chatVoted ?? 'Voted';
    }

    debugLog('ChatPage: Voting on poll $pollEventId, new votes: $newVotes');

    // 标记正在投票
    setState(() {
      _votingPollIds.add(pollEventId);
    });

    context.read<ChatBloc>().add(VoteOnPoll(
      pollEventId: pollEventId,
      selectedOptionIds: newVotes,
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(actionMessage),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // 延迟后解除投票锁定
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _votingPollIds.remove(pollEventId);
        });
      }
    });
  }

  /// 结束投票
  void _onEndPoll(String pollEventId) async {
    debugLog('ChatPage: Ending poll $pollEventId');

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.chatEndPollTitle ?? 'End Poll'),
        content: Text(S.of(context)?.chatEndPollConfirmMessage ?? 'Are you sure you want to end this poll? Voting will be closed after ending.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(S.of(context)?.commonConfirm ?? 'Confirm', style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      // 调用 Bloc 结束投票
      context.read<ChatBloc>().add(EndPoll(pollEventId: pollEventId));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatPollEndedMessage ?? 'Poll ended'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  void _showFeatureToast(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context)?.chatFeatureInDev(feature) ?? '$feature feature in development...'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
