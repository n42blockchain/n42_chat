// ignore_for_file: invalid_use_of_protected_member
part of 'chat_page.dart';

/// 消息事件处理相关方法（消息点击、头像、红包、名片、位置、媒体查看等）
extension _ChatPageEventHandlersMethods on _ChatPageState {
  void _onMessageTap(MessageEntity message) {
    // 阅后即焚消息：接收方首次查看时触发销毁倒计时
    if (message.isSelfDestructing && !message.isDestructionStarted && !message.isFromMe) {
      context.read<ChatBloc>().add(StartMessageDestruction(message.id));
    }

    // 处理消息点击（如查看图片、播放视频、播放语音等）
    switch (message.type) {
      case MessageType.image:
        _viewImage(message);
        break;
      case MessageType.video:
        _playVideo(message);
        break;
      case MessageType.audio:
        // 语音消息在 MessageItem 内部处理
        break;
      case MessageType.file:
        _openFile(message);
        break;
      case MessageType.location:
        _viewLocation(message);
        break;
      case MessageType.music:
        _playMusic(message);
        break;
      default:
        break;
    }
  }

  /// 播放音乐
  void _playMusic(MessageEntity message) {
    final url = message.metadata?.musicUrl;
    if (url != null && url.isNotEmpty) {
      // 打开音乐链接
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  /// 红包消息点击
  void _onRedPacketTap(MessageEntity message) {
    final metadata = message.metadata;
    final status = metadata?.transferStatus ?? 'pending';
    final greeting = message.content.isNotEmpty ? message.content : (S.of(context)?.chatRedPacketGreeting ?? 'Best wishes');
    final amount = metadata?.amount;
    final token = metadata?.token ?? 'CNY';

    // 获取发送者显示名称（优先使用备注名）
    final senderName = RemarkService.instance.getDisplayName(
      message.senderId,
      message.senderName,
    );

    // 判断红包状态
    OpenRedPacketStatus redPacketStatus;
    switch (status) {
      case 'opened':
        redPacketStatus = OpenRedPacketStatus.opened;
        break;
      case 'expired':
        redPacketStatus = OpenRedPacketStatus.expired;
        break;
      case 'empty':
        redPacketStatus = OpenRedPacketStatus.empty;
        break;
      default:
        redPacketStatus = OpenRedPacketStatus.canOpen;
    }

    // 如果已经领取，直接显示红包详情页
    if (redPacketStatus == OpenRedPacketStatus.opened) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => RedPacketDetailPage(
            senderName: senderName,
            senderAvatar: message.senderAvatarUrl,
            greeting: greeting,
            claimedAmount: amount,
            token: token,
            isClaimed: true,
            claimers: [
              // 当前用户作为领取者
              RedPacketClaimer(
                name: _getDisplayName(),
                amount: amount ?? '0',
                claimTime: _formatTime(DateTime.now()),
              ),
            ],
          ),
        ),
      );
      return;
    }

    // 显示开红包弹窗
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => OpenRedPacketDialog(
        senderName: senderName,
        senderAvatar: message.senderAvatarUrl,
        greeting: greeting,
        status: redPacketStatus,
        claimedAmount: amount,
        token: token,
        onOpen: () {
          // TODO(backend): 调用后端API领取红包
          debugPrint('Opening red packet: ${message.id}');
        },
        onViewDetails: () {
          Navigator.of(ctx).pop();
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => RedPacketDetailPage(
                senderName: senderName,
                senderAvatar: message.senderAvatarUrl,
                greeting: greeting,
                claimedAmount: amount,
                token: token,
                isClaimed: true,
                claimers: [
                  RedPacketClaimer(
                    name: _getDisplayName(),
                    amount: amount ?? '0',
                    claimTime: _formatTime(DateTime.now()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// 名片消息点击 - 跳转到用户资料页添加好友
  void _onContactCardTap(String contactId, String contactName, String? avatarUrl) {
    debugPrint('Contact card tapped: $contactName ($contactId), avatar: $avatarUrl');

    // 获取当前的 ContactBloc
    ContactBloc? contactBloc;
    try {
      contactBloc = context.read<ContactBloc>();
    } catch (e) {
      // ContactBloc 可能不可用
      debugPrint('Error: $e');
    }

    // 跳转到联系人详情页面
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) {
          final page = ContactDetailPage(
            userId: contactId,
            displayName: contactName,
            avatarUrl: avatarUrl,
            onSendMessage: () {
              Navigator.of(ctx).pop();
            },
          );

          // 如果有 ContactBloc，传递它
          if (contactBloc != null) {
            return BlocProvider.value(
              value: contactBloc,
              child: page,
            );
          }
          return page;
        },
      ),
    );
  }

  /// 查看图片
  void _viewImage(MessageEntity message) {
    String? imageUrl = message.metadata?.httpUrl;

    // 如果 httpUrl 为空，尝试从 mediaUrl 转换
    if (imageUrl == null || imageUrl.isEmpty) {
      final mxcUrl = message.metadata?.mediaUrl;
      if (mxcUrl != null && mxcUrl.startsWith('mxc://')) {
        imageUrl = _convertMxcToHttpUrl(mxcUrl);
      }
    }

    if (imageUrl == null || imageUrl.isEmpty) {
      debugPrint('_viewImage: No valid URL found for image');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ChatImageViewerPage(
          imageUrl: imageUrl!,
          heroTag: message.id,
        ),
      ),
    );
  }

  /// 播放视频
  void _playVideo(MessageEntity message) {
    debugPrint('=== _playVideo called ===');
    debugPrint('Message ID: ${message.id}');
    debugPrint('Message type: ${message.type}');
    debugPrint('Metadata httpUrl: ${message.metadata?.httpUrl}');
    debugPrint('Metadata mediaUrl: ${message.metadata?.mediaUrl}');
    debugPrint('Metadata thumbnailUrl: ${message.metadata?.thumbnailUrl}');

    String? videoUrl = message.metadata?.httpUrl;

    // 如果 httpUrl 为空，尝试从 mediaUrl 转换
    if (videoUrl == null || videoUrl.isEmpty) {
      final mxcUrl = message.metadata?.mediaUrl;
      debugPrint('httpUrl is empty, trying to convert from mxcUrl: $mxcUrl');
      if (mxcUrl != null && mxcUrl.startsWith('mxc://')) {
        videoUrl = _convertMxcToHttpUrl(mxcUrl);
        debugPrint('Converted to httpUrl: $videoUrl');
      }
    }

    if (videoUrl == null || videoUrl.isEmpty) {
      debugPrint('ERROR: Video URL is still empty after conversion attempt');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatInvalidVideoUrl ?? 'Invalid video URL'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // 也转换缩略图 URL
    String? thumbnailUrl = message.metadata?.thumbnailUrl;
    if (thumbnailUrl != null && thumbnailUrl.startsWith('mxc://')) {
      thumbnailUrl = _convertMxcToHttpUrl(thumbnailUrl);
    }
    debugPrint('Final videoUrl: $videoUrl');
    debugPrint('Final thumbnailUrl: $thumbnailUrl');

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ChatVideoPlayerPage(
          videoUrl: videoUrl!,
          thumbnailUrl: thumbnailUrl,
        ),
      ),
    );
  }

  /// 打开文件
  void _openFile(MessageEntity message) {
    String? fileUrl = message.metadata?.httpUrl;

    // 如果 httpUrl 为空，尝试从 mediaUrl 转换
    if (fileUrl == null || fileUrl.isEmpty) {
      final mxcUrl = message.metadata?.mediaUrl;
      if (mxcUrl != null && mxcUrl.startsWith('mxc://')) {
        fileUrl = _convertMxcToHttpUrl(mxcUrl);
      }
    }

    final fileName = message.metadata?.fileName ?? (S.of(context)?.chatUnknownFile ?? 'Unknown file');
    final mimeType = message.metadata?.mimeType ?? '';

    // PDF 文件使用内置预览器（检查文件名后缀和 MIME 类型）
    final isPdf = fileName.toLowerCase().endsWith('.pdf') ||
        mimeType == 'application/pdf';
    if (isPdf && fileUrl != null) {
      // 构建认证头用于下载受保护的媒体
      final accessToken = MatrixClientManager.instance.client?.accessToken;
      final headers = accessToken != null
          ? <String, String>{'Authorization': 'Bearer $accessToken'}
          : null;

      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => PdfViewerPage(
            fileName: fileName,
            url: fileUrl,
            headers: headers,
          ),
        ),
      );
      return;
    }

    if (fileUrl == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${S.of(context)?.chatDownloadFile ?? 'Download file'}: $fileName'),
        action: SnackBarAction(
          label: S.of(context)?.chatDownload ?? 'Download',
          onPressed: () async {
            try {
              final downloadService = getIt<DownloadService>();
              final downloadDir = await DownloadService.getDownloadDirectory();
              final savePath = '$downloadDir/$fileName';

              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context)?.downloading ?? 'Downloading...'),
                  duration: const Duration(seconds: 1),
                ),
              );

              await downloadService.download(
                url: fileUrl!,
                savePath: savePath,
                fileName: fileName,
              );

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context)?.downloadComplete ?? 'Download complete'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${S.of(context)?.downloadFailed ?? 'Download failed'}: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  /// 查看位置
  void _viewLocation(MessageEntity message) {
    final metadata = message.metadata;
    final lat = metadata?.latitude;
    final lng = metadata?.longitude;

    if (lat == null || lng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatInvalidLocation ?? 'Invalid location'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // 解析位置名称
    String locationName = message.content;
    if (locationName.isEmpty ||
        locationName.startsWith('geo:') ||
        locationName.contains('Location was shared')) {
      locationName = S.of(context)?.chatMyLocation ?? 'My Location';
    }

    // 打开微信风格的位置详情页面
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (ctx) => ChatLocationDetailPage(
          latitude: lat,
          longitude: lng,
          locationName: locationName,
        ),
      ),
    );
  }

  void _onAvatarTap(MessageEntity message) {
    // 点击头像查看用户资料
    if (message.isFromMe) {
      // 点击自己的头像，可以跳转到个人资料页
      return;
    }

    // 获取当前的 ContactBloc
    ContactBloc? contactBloc;
    try {
      contactBloc = context.read<ContactBloc>();
    } catch (e) {
      // ContactBloc 可能不可用
      debugPrint('Error: $e');
    }

    // 获取备注名
    String displayName = message.senderName;
    if (contactBloc != null) {
      final state = contactBloc.state;
      if (state.isLoaded) {
        final contact = state.contacts.cast<ContactEntity?>().firstWhere(
          (c) => c?.userId == message.senderId,
          orElse: () => null,
        );
        if (contact != null) {
          displayName = contact.effectiveDisplayName;
        }
      }
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) {
          final page = ContactDetailPage(
            userId: message.senderId,
            displayName: displayName,
            avatarUrl: message.senderAvatarUrl,
            onSendMessage: () {
              Navigator.of(ctx).pop();
            },
          );

          // 如果有 ContactBloc，传递它
          if (contactBloc != null) {
            return BlocProvider.value(
              value: contactBloc,
              child: page,
            );
          }
          return page;
        },
      ),
    );
  }

  /// 双击头像拍一拍
  void _onAvatarDoubleTap(MessageEntity message) async {
    try {
      String myDisplayName = S.of(context)?.commonMe ?? 'Me';
      String? myPokeText;
      String? myUserId;

      // 直接从仓库获取用户资料（更可靠，不依赖 AuthBloc Provider）
      try {
        final authRepository = getIt<IAuthRepository>();

        // 获取当前用户基本信息
        final currentUser = authRepository.currentUser;
        myDisplayName = currentUser?.displayName ?? (S.of(context)?.commonMe ?? 'Me');
        myUserId = currentUser?.userId;

        debugPrint('Poke: currentUser.displayName=$myDisplayName, userId=$myUserId');

        // 从仓库获取 pokeText
        final profileData = await authRepository.getUserProfileData();
        myPokeText = profileData?['pokeText'] as String?;
        debugPrint('Poke from repository: pokeText=$myPokeText, fullData=$profileData');
      } catch (e) {
        debugPrint('Poke: Failed to get user info: $e');
      }

      // 获取被拍用户的显示名（优先使用备注名）
      final targetName = RemarkService.instance.getDisplayName(message.senderId, message.senderName);
      final targetUserId = message.senderId;

      debugPrint('Poke: targetName=$targetName, targetUserId=$targetUserId, finalPokeText=$myPokeText');

      // 微信风格的拍一拍效果
      // 1. 触发震动反馈
      unawaited(HapticFeedback.mediumImpact());

      // 2. 发送拍一拍系统消息
      // 微信规则：使用拍人者自己设置的后缀
      // 例如：我设置了"的头"，我拍星驰，显示"我 拍了拍 星驰的头"
      _sendPokeMessage(
        pokerName: myDisplayName,
        targetName: targetName,
        targetUserId: targetUserId,
        pokeText: myPokeText,
      );

      // 3. 显示拍一拍动画效果（SnackBar）
      _showPokeAnimation(message, myPokeText: myPokeText);
    } catch (e) {
      debugPrint('Poke error: $e');
    }
  }

  /// 发送拍一拍消息
  void _sendPokeMessage({
    required String pokerName,
    required String targetName,
    required String targetUserId,
    String? pokeText,
  }) {
    debugPrint('Sending poke message: pokerName=$pokerName, targetName=$targetName, pokeText=$pokeText');

    // 使用新的 SendPokeMessage 事件，让 ChatBloc 处理 pokeText 的获取
    context.read<ChatBloc>().add(SendPokeMessage(
      pokerName: pokerName,
      targetUserId: targetUserId,
      targetName: targetName,
      pokerPokeText: pokeText,
    ));
  }

  /// 显示拍一拍动画效果
  void _showPokeAnimation(MessageEntity message, {String? myPokeText}) {
    // 显示一个简短的提示（使用自己设置的后缀）
    // 格式：拍了拍「星驰」的头（如果设置了后缀"的头"）
    // 优先使用备注名
    final targetDisplayName = RemarkService.instance.getDisplayName(message.senderId, message.senderName);
    debugPrint('ShowPokeAnimation: targetName=$targetDisplayName, myPokeText=$myPokeText');

    final displayText = S.of(context)?.chatPokedSomeone(targetDisplayName, myPokeText ?? '')
        ?? 'poked $targetDisplayName${myPokeText ?? ''}';

    debugPrint('ShowPokeAnimation: displayText=$displayText');

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.touch_app, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Flexible(child: Text(displayText)),
          ],
        ),
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black87,
        margin: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
      ),
    );
  }

  void _onResend(MessageEntity message) {
    context.read<ChatBloc>().add(ResendMessage(message.id));
  }

  /// 导航到线程详情页
  void _navigateToThread(MessageEntity message) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ThreadDetailPage(
          roomId: widget.conversation.id,
          threadRootEventId: message.id,
        ),
      ),
    );
  }

  /// 打开聊天设置页面
  void _openChatSettings() async {
    // 获取当前的 ContactBloc
    ContactBloc? contactBloc;
    try {
      contactBloc = context.read<ContactBloc>();
    } catch (e) {
      // ContactBloc 可能不可用
      debugPrint('Error: $e');
    }

    // 检查是否可以踢人和修改群设置（群主/管理员）
    bool canKickMembers = false;
    bool canChangeSettings = false;
    if (widget.conversation.isGroup) {
      try {
        final groupRepository = getIt<IGroupRepository>();
        final group = await groupRepository.getGroup(widget.conversation.id);
        canKickMembers = group?.canKick ?? false;
        canChangeSettings = group?.canChangeSettings ?? false;
        debugPrint('ChatPage: Group permissions - canKick=$canKickMembers, canChangeSettings=$canChangeSettings');
      } catch (e) {
        debugPrint('Failed to get group info: $e');
      }
    }

    if (!mounted) return;

    unawaited(Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) {
          final page = ChatDetailPage(
            conversation: widget.conversation,
            canKickMembers: canKickMembers,
            canChangeSettings: canChangeSettings,
            onAddMember: () => _showAddMemberDialog(ctx),
            onRemoveMember: (userId) => _removeMemberFromGroup(userId),
            onMemberTap: (userId, displayName, avatarUrl) {
              _openMemberProfile(ctx, userId, displayName, avatarUrl);
            },
            onClearHistory: () {
              context.read<ChatBloc>().add(const ClearChatHistory());
            },
          );

          if (contactBloc != null) {
            return BlocProvider.value(
              value: contactBloc,
              child: page,
            );
          }
          return page;
        },
      ),
    ).then((_) {
      // 返回时刷新背景（用户可能在详情页修改了聊天背景）
      _loadBackground();
    }));
  }

  /// 显示添加成员对话框
  void _showAddMemberDialog(BuildContext ctx) async {
    // 获取联系人列表
    List<ContactEntity> contacts = [];
    try {
      final contactState = context.read<ContactBloc>().state;
      if (contactState.isLoaded) {
        contacts = contactState.contacts;
      }
    } catch (e) {
      debugPrint('Failed to get contacts: $e');
    }

    if (contacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.chatNoContactsToAdd ?? 'No contacts available to add')),
      );
      return;
    }

    // 显示联系人选择对话框
    final selectedIds = await showDialog<List<String>>(
      context: context,
      builder: (dialogCtx) => ContactSelectDialog(
        contacts: contacts,
        title: S.of(context)?.chatAddMembers ?? 'Add Members',
      ),
    );

    if (selectedIds != null && selectedIds.isNotEmpty) {
      try {
        final groupRepository = getIt<IGroupRepository>();
        await groupRepository.inviteUsers(widget.conversation.id, selectedIds);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context)?.chatInvitedMembers(selectedIds.length) ?? 'Invited ${selectedIds.length} members')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context)?.chatInviteFailed(e.toString()) ?? 'Invite failed: $e')),
          );
        }
      }
    }
  }

  /// 从群中移除成员
  void _removeMemberFromGroup(String userId) async {
    try {
      final groupRepository = getIt<IGroupRepository>();
      await groupRepository.kickMember(widget.conversation.id, userId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.chatMemberRemoved ?? 'Member removed')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.chatRemoveFailed(e.toString()) ?? 'Remove failed: $e')),
        );
      }
    }
  }

  /// 打开成员资料页
  void _openMemberProfile(BuildContext ctx, String userId, String displayName, String? avatarUrl) {
    // 获取当前的 ContactBloc
    ContactBloc? contactBloc;
    try {
      contactBloc = context.read<ContactBloc>();
    } catch (e) {
      // ContactBloc 可能不可用
      debugPrint('Error: $e');
    }

    Navigator.of(ctx).push(
      MaterialPageRoute<void>(
        builder: (navCtx) {
          final page = ContactDetailPage(
            userId: userId,
            displayName: displayName,
            avatarUrl: avatarUrl,
            onSendMessage: () {
              Navigator.of(navCtx).pop();
              Navigator.of(ctx).pop();
            },
          );

          if (contactBloc != null) {
            return BlocProvider.value(
              value: contactBloc,
              child: page,
            );
          }
          return page;
        },
      ),
    );
  }
}
