import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:saver_gallery/saver_gallery.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/services/in_app_notification_service.dart';
import '../../../core/utils/face_blur_util.dart';
import '../../../core/theme/chat_background_presets.dart';
import '../../../data/datasources/local/preferences_datasource.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../n42_chat.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/download_service.dart';
import '../media/media_editor_page.dart';
import '../../../core/services/remark_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/group_repository.dart';
import '../../../domain/repositories/message_repository.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../blocs/chat/chat_state.dart';
import '../../blocs/message_action/message_action_bloc.dart';
import '../../blocs/message_action/message_action_event.dart' as action_event;
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_state.dart';
import '../../blocs/search/search_bloc.dart';
import '../../widgets/chat/chat_widgets.dart';
import '../../widgets/chat/gif_picker.dart';
import '../../widgets/chat/sticker_picker.dart';
import '../../widgets/chat/red_packet_dialogs.dart';
import '../sticker/sticker_store_page.dart';
import '../../widgets/chat/edit_history_sheet.dart';
import '../../widgets/wechat_toast.dart';
import '../../../domain/entities/sticker_pack_entity.dart';
import '../../widgets/common/common_widgets.dart';
import '../contact/contact_detail_page.dart';
import '../search/chat_search_bar.dart';
import 'chat_detail_page.dart';
import '../favorite/favorite_list_page.dart';
import 'message_item.dart';
import 'live_location_page.dart';
import 'thread_detail_page.dart';
import '../../widgets/chat/quick_reply_sheet.dart';
import '../settings/quick_replies_page.dart';
import '../ai/ai_assistant_page.dart';
import '../../../core/services/ai_service.dart';
import '../../widgets/chat/ai_summary_bubble.dart';
import '../../../domain/repositories/ai_repository.dart';
import '../../widgets/chat/ai_rewrite_bar.dart';
import 'viewers/pdf_viewer_page.dart';
import 'image_viewer_page.dart';
import 'location_picker_page.dart';
import 'video_player_page.dart';
import '../../widgets/chat/chat_confirm_sheets.dart';
import '../../widgets/chat/contact_card_select_sheet.dart';
import '../../widgets/chat/contact_select_dialog.dart';
import '../../widgets/chat/forward_message_sheet.dart';
import '../../widgets/chat/member_picker_sheet.dart';
import '../../widgets/chat/multi_forward_sheet.dart';
import '../../widgets/chat/music_select_sheet.dart';
import '../../widgets/chat/poll_create_sheet.dart';

/// 聊天页面
class ChatPage extends StatefulWidget {
  /// 会话实体
  final ConversationEntity conversation;

  /// 返回回调
  final VoidCallback? onBack;

  /// 更多按钮点击回调
  final VoidCallback? onMorePressed;

  const ChatPage({
    super.key,
    required this.conversation,
    this.onBack,
    this.onMorePressed,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();

  bool _showScrollToBottom = false;
  bool _showSearchBar = false;
  bool _showMorePanel = false;
  bool _showEmojiPicker = false;
  bool _showStickerPicker = false;
  String? _highlightedMessageId;
  
  // 录音状态
  bool _isRecording = false;
  bool _isRecordingCancelled = false;
  Duration _recordingDuration = Duration.zero;
  
  // 消息 GlobalKey 映射，用于获取消息气泡位置
  final Map<String, GlobalKey> _messageKeys = {};

  // ChatInputBar 的 GlobalKey，用于调用取消录音方法
  final GlobalKey<ChatInputBarState> _inputBarKey = GlobalKey<ChatInputBarState>();
  
  // 撤回的消息ID，用于显示"重新编辑"
  final Set<String> _recalledMessageIds = {};
  String? _lastRecalledContent;
  
  // 多选模式
  bool _isMultiSelectMode = false;
  final Set<String> _selectedMessageIds = {};
  
  // 收藏的消息（本地存储）
  final Set<String> _favoritedMessageIds = {};
  
  // 当前用户ID（用于表情回应高亮）
  String? _currentUserId;
  
  // @ 提醒相关状态
  bool _showMentionPicker = false;
  int _mentionTriggerPosition = -1; // @ 符号的位置
  String _mentionSearchQuery = ''; // @ 后面输入的搜索关键词
  
  // View Once 模式（阅后即焚媒体）
  bool _isViewOnce = false;

  // 自动人脸模糊设置
  bool _autoFaceBlur = false;

  // 备注更新订阅
  StreamSubscription<RemarkUpdateEvent>? _remarkSubscription;

  // 私聊对方的用户ID（用于获取备注名）
  String? _otherUserId;

  // 投票防抖 - 正在投票的pollId集合
  final Set<String> _votingPollIds = {};

  // AI 改写状态
  bool _showRewriteBar = false;
  String _rewriteOriginalText = '';
  String? _rewriteResult;
  bool _isRewriting = false;
  AiTone? _selectedTone;

  // AI 群聊消息摘要状态
  String? _aiSummaryResult;
  bool _isAiSummarizing = false;

  // 聊天背景 key（如 solid_0, gradient_1, default 等）
  String? _backgroundKey;

  // 消息字体大小
  double _messageFontSize = 16.0;

  @override
  void initState() {
    super.initState();

    // 设置当前活跃房间（避免弹出通知）
    N42Chat.pushService?.setActiveRoom(widget.conversation.id);

    // 清除该房间的通知
    N42Chat.clearNotificationsForRoom(widget.conversation.id);

    // 初始化聊天室
    context.read<ChatBloc>().add(InitializeChat(widget.conversation.id));

    // 获取当前用户ID
    _loadCurrentUserId();

    // 加载人脸模糊设置
    _loadFaceBlurSetting();

    // 获取私聊对方的用户ID
    _loadOtherUserId();

    // 监听滚动
    _scrollController.addListener(_onScroll);

    // 监听输入框焦点，获取焦点时隐藏更多面板
    _inputFocusNode.addListener(_onInputFocusChanged);
    
    // 监听备注更新
    _remarkSubscription = RemarkService.instance.onRemarkUpdated.listen((event) {
      // 如果是当前会话的联系人备注更新，刷新界面
      final targetUserId = _otherUserId ?? widget.conversation.id;
      if (event.userId == targetUserId && mounted) {
        debugPrint('ChatPage: Remark updated for $targetUserId, refreshing UI');
        setState(() {});
      }
    });

    // 加载聊天背景
    _loadBackground();

    // 加载字体大小
    _loadFontSize();

    // 加载草稿
    _loadDraft();

    // 设置当前聊天房间（应用内通知过滤）
    InAppNotificationService.instance.setCurrentChatRoom(widget.conversation.id);

    // 设置通话错误回调
    N42Chat.callManager?.onError = _handleCallError;
  }

  /// 处理通话错误
  void _handleCallError(String errorCode) {
    if (!mounted) return;

    final l10n = S.of(context);
    String message;

    switch (errorCode) {
      case 'call_not_initialized':
        message = l10n?.chatCallServiceNotInitialized ?? 'Call service not initialized';
        break;
      case 'already_in_call':
        message = l10n?.chatAlreadyInCall ?? 'Already in a call';
        break;
      case 'call_failed':
        message = l10n?.commonConnectionFailed ?? 'Call failed';
        break;
      case 'answer_failed':
        message = l10n?.commonConnectionFailed ?? 'Failed to answer';
        break;
      case 'connection_failed':
        message = l10n?.commonConnectionFailed ?? 'Connection failed';
        break;
      case 'call_rejected':
        message = l10n?.chatCallRejected ?? 'Call rejected';
        break;
      case 'no_answer':
        message = l10n?.chatNoAnswer ?? 'No answer';
        break;
      default:
        message = errorCode;
    }

    WeChatToast.show(context, message, type: ToastType.warning);
  }
  
  /// 获取私聊对方的用户ID
  void _loadOtherUserId() {
    if (widget.conversation.type == ConversationType.group) {
      return;
    }
    
    // 直接使用 conversation.directUserId
    _otherUserId = widget.conversation.directUserId;
    debugPrint('ChatPage: directUserId=$_otherUserId for room ${widget.conversation.id}');
  }

  void _onInputFocusChanged() {
    if (_inputFocusNode.hasFocus) {
      setState(() {
        _showMorePanel = false;
        _showEmojiPicker = false;
      });
    }
  }
  
  /// 加载当前用户ID
  void _loadCurrentUserId() {
    try {
      final authRepository = getIt<IAuthRepository>();
      _currentUserId = authRepository.currentUser?.userId;
      debugPrint('ChatPage: Loaded current user ID: $_currentUserId');
    } catch (e) {
      debugPrint('ChatPage: Failed to load current user ID: $e');
    }
  }

  /// 加载人脸模糊设置
  Future<void> _loadFaceBlurSetting() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final enabled = prefs.getBool('auto_face_blur') ?? false;
      if (mounted && enabled != _autoFaceBlur) {
        setState(() {
          _autoFaceBlur = enabled;
        });
      }
    } catch (e) {
      debugPrint('ChatPage: Failed to load face blur setting: $e');
    }
  }

  /// 加载聊天背景设置
  Future<void> _loadBackground() async {
    final storage = getIt<PreferencesDataSource>();
    // 先尝试获取房间特定背景
    var bg = await storage.getChatBackground(widget.conversation.id);
    // 如果没有，尝试默认背景
    bg ??= await storage.getDefaultChatBackground();
    if (mounted && bg != null) {
      setState(() => _backgroundKey = bg);
    }
  }

  /// 加载消息字体大小
  Future<void> _loadFontSize() async {
    final storage = getIt<PreferencesDataSource>();
    final size = await storage.getMessageFontSize();
    if (mounted) {
      setState(() => _messageFontSize = size);
    }
  }

  /// 加载草稿
  Future<void> _loadDraft() async {
    final storage = getIt<PreferencesDataSource>();
    final draft = await storage.getDraft(widget.conversation.id);
    if (mounted && draft != null && draft.isNotEmpty) {
      _inputController.text = draft;
      _inputController.selection = TextSelection.fromPosition(
        TextPosition(offset: draft.length),
      );
    }
  }

  /// 保存草稿
  void _saveDraft() {
    final storage = getIt<PreferencesDataSource>();
    storage.saveDraft(widget.conversation.id, _inputController.text);
  }

  /// 构建聊天背景装饰
  BoxDecoration? _buildBackgroundDecoration() {
    return ChatBackgroundPresets.resolveDecoration(_backgroundKey);
  }

  /// 切换人脸模糊设置
  Future<void> _toggleFaceBlur() async {
    final newValue = !_autoFaceBlur;
    setState(() {
      _autoFaceBlur = newValue;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auto_face_blur', newValue);
    } catch (e) {
      debugPrint('ChatPage: Failed to save face blur setting: $e');
    }
  }

  @override
  void dispose() {
    // 清除当前活跃房间
    N42Chat.pushService?.setActiveRoom(null);

    // 清除当前聊天房间（应用内通知过滤）
    InAppNotificationService.instance.setCurrentChatRoom(null);

    // 清除通话错误回调
    if (N42Chat.callManager?.onError == _handleCallError) {
      N42Chat.callManager?.onError = null;
    }

    // 取消备注更新订阅
    _remarkSubscription?.cancel();

    // 先清理聊天室（在 super.dispose 之前）
    try {
      context.read<ChatBloc>().add(const DisposeChat());
    } catch (e) {
      debugPrint('ChatPage: Error disposing ChatBloc: $e');
    }

    // 保存草稿
    _saveDraft();

    // 移除监听器（必须在 dispose 之前）
    _scrollController.removeListener(_onScroll);
    _inputFocusNode.removeListener(_onInputFocusChanged);

    // 释放人脸检测器资源
    FaceBlurUtil.dispose();

    // 释放资源
    _scrollController.dispose();
    _inputController.dispose();
    _inputFocusNode.dispose();

    super.dispose();
  }

  void _onScroll() {
    // 检查是否需要加载更多
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ChatBloc>().add(const LoadMoreMessages());
    }

    // 显示/隐藏回到底部按钮
    final shouldShow = _scrollController.position.pixels > 500;
    if (_showScrollToBottom != shouldShow) {
      setState(() {
        _showScrollToBottom = shouldShow;
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final chatBloc = context.read<ChatBloc>();
    final editingMsg = chatBloc.state.editingMessage;

    if (editingMsg != null) {
      // 编辑模式：通过 MessageActionBloc 发送编辑
      final actionBloc = getIt<MessageActionBloc>();
      actionBloc.add(action_event.EditMessage(
        widget.conversation.id,
        editingMsg.id,
        text,
      ));
      // 退出编辑模式
      chatBloc.add(const SetEditTarget(null));
    } else {
      chatBloc.add(SendTextMessage(text));
    }
    _inputController.clear();
  }

  void _onInputChanged(String text) {
    // 发送正在输入状态
    context.read<ChatBloc>().add(SendTypingNotification(text.isNotEmpty));
    
    // 检测 @ 提醒（仅群聊）
    if (widget.conversation.isGroup) {
      _checkMentionTrigger(text);
    }
  }
  
  /// 检测 @ 触发
  void _checkMentionTrigger(String text) {
    final cursorPos = _inputController.selection.baseOffset;
    
    if (cursorPos < 0) {
      _hideMentionPicker();
      return;
    }
    
    // 获取光标前的文本
    final textBeforeCursor = cursorPos <= text.length 
        ? text.substring(0, cursorPos) 
        : text;
    
    // 查找最后一个 @ 符号
    final lastAtIndex = textBeforeCursor.lastIndexOf('@');
    
    if (lastAtIndex >= 0) {
      // 检查 @ 前面是否是空格或行首（确保是新的 @ 提醒）
      final isValidTrigger = lastAtIndex == 0 || 
          textBeforeCursor[lastAtIndex - 1] == ' ' || 
          textBeforeCursor[lastAtIndex - 1] == '\n';
      
      if (isValidTrigger) {
        // 获取 @ 后面的搜索关键词（不包含空格）
        final searchPart = textBeforeCursor.substring(lastAtIndex + 1);
        
        // 如果 @ 后面没有空格，说明用户还在输入中，显示选择器
        if (!searchPart.contains(' ')) {
          setState(() {
            _showMentionPicker = true;
            _mentionTriggerPosition = lastAtIndex;
            _mentionSearchQuery = searchPart;
          });
          return;
        }
      }
    }
    
    // 没有有效的 @ 触发，隐藏选择器
    _hideMentionPicker();
  }
  
  /// 隐藏 @ 选择器
  void _hideMentionPicker() {
    if (_showMentionPicker) {
      setState(() {
        _showMentionPicker = false;
        _mentionTriggerPosition = -1;
        _mentionSearchQuery = '';
      });
    }
  }
  
  /// 选择要 @ 的成员
  void _onMentionMemberSelected(String memberName, String memberId) {
    if (_mentionTriggerPosition < 0) return;
    
    final text = _inputController.text;
    final cursorPos = _inputController.selection.baseOffset;
    
    // 替换 @搜索词 为 @成员名 
    final beforeAt = text.substring(0, _mentionTriggerPosition);
    final afterCursor = cursorPos <= text.length ? text.substring(cursorPos) : '';
    
    final mention = '@$memberName ';
    final newText = beforeAt + mention + afterCursor;
    final newCursorPos = beforeAt.length + mention.length;
    
    _inputController.text = newText;
    _inputController.selection = TextSelection.fromPosition(
      TextPosition(offset: newCursorPos),
    );
    
    _hideMentionPicker();
    _inputFocusNode.requestFocus();
  }

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
  
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (now.difference(time).inMinutes < 1) {
      return S.of(context)?.chatJustNow ?? 'Just now';
    } else if (now.day == time.day) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      return '${time.month}/${time.day} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
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

  /// 将 mxc:// URL 转换为 HTTP URL
  String? _convertMxcToHttpUrl(String? mxcUrl) {
    if (mxcUrl == null || mxcUrl.isEmpty) return null;
    if (!mxcUrl.startsWith('mxc://')) return mxcUrl;

    try {
      final client = MatrixClientManager.instance.client;
      if (client == null) return null;

      final homeserver = client.homeserver?.toString().replaceAll(RegExp(r'/$'), '') ?? '';
      if (homeserver.isEmpty) return null;

      final uri = Uri.parse(mxcUrl);
      final serverName = uri.host;
      final mediaId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';

      if (serverName.isEmpty || mediaId.isEmpty) return null;

      return '$homeserver/_matrix/client/v1/media/download/$serverName/$mediaId';
    } catch (e) {
      debugPrint('_convertMxcToHttpUrl error: $e');
      return null;
    }
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

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    
    // 检查 ContactBloc 是否可用
    bool hasContactBloc = false;
    try {
      context.read<ContactBloc>();
      hasContactBloc = true;
    } catch (e) {
      // ContactBloc 不可用
      debugPrint('Error: $e');
    }

    final Widget content = Stack(
      children: [
        Scaffold(
          backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
          appBar: _buildAppBar(isDark),
          body: Column(
            children: [
              // 聊天内搜索栏
              if (_showSearchBar)
                BlocProvider(
                  create: (_) => getIt<SearchBloc>(),
                  child: ChatSearchBar(
                    roomId: widget.conversation.id,
                    onClose: _toggleSearch,
                    onNavigateToMessage: _navigateToMessage,
                  ),
                ),

              // 置顶消息横幅
              _buildPinnedMessageBanner(),

              // 消息列表
              Expanded(
                child: Container(
                  decoration: _buildBackgroundDecoration(),
                  child: Stack(
                    children: [
                      _buildMessageList(),

                      // 回到底部按钮
                      if (_showScrollToBottom)
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: _buildScrollToBottomButton(),
                        ),
                    ],
                  ),
                ),
              ),

              // 回复预览
              if (!_isMultiSelectMode) _buildReplyPreview(),

              // 编辑预览
              if (!_isMultiSelectMode) _buildEditPreview(),

              // @ 提醒成员选择器（群聊时）
              if (_showMentionPicker && !_isMultiSelectMode) _buildMentionPicker(),

              // AI 改写栏
              if (_showRewriteBar && !_isMultiSelectMode)
                _buildAiRewriteBar(),

              // View Once 提示条
              if (_isViewOnce && !_isMultiSelectMode && !_showSearchBar)
                _buildViewOnceIndicator(),

              // 多选模式下显示操作栏，否则显示输入栏
              if (_isMultiSelectMode)
                _buildMultiSelectBottomBar()
              else if (!_showSearchBar)
                _buildInputBar(),

              // 表情选择器
              if (_showEmojiPicker && !_isMultiSelectMode) _buildEmojiPicker(),

              // 贴纸选择器
              if (_showStickerPicker && !_isMultiSelectMode) _buildStickerPicker(),

              // 更多功能面板（仅在非多选模式下）
              if (_showMorePanel && !_isMultiSelectMode) _buildMorePanel(),
            ],
          ),
        ),
        
        // 全屏录音浮层
        if (_isRecording) _buildRecordingOverlay(),
      ],
    );
    
    // 如果有 ContactBloc，用 BlocListener 包装来监听备注更新
    if (hasContactBloc) {
      return BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state.status == ContactStatus.loaded) {
            // 联系人加载完成，重新获取对方用户ID
            _loadOtherUserId();
            if (mounted) setState(() {});
          } else if (state.status == ContactStatus.remarkUpdated) {
            if (mounted) setState(() {});
          }
        },
        child: content,
      );
    }
    
    return content;
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
  
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
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

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final mediaFiles = await picker.pickMultipleMedia(
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (mediaFiles.isEmpty) return;

      for (final file in mediaFiles) {
        final mimeType = lookupMimeType(file.path) ?? '';
        if (mimeType.startsWith('video/')) {
          await _sendVideo(file);
        } else {
          // 单张图片时提供编辑选项
          if (mediaFiles.length == 1) {
            await _editAndSendImage(file);
          } else {
            await _sendImage(file);
          }
        }
      }
    } catch (e) {
      debugPrint('Pick media error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.commonSelectImageFailed(e.toString()) ?? 'Failed to select media: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  /// 打开编辑器编辑图片后发送
  ///
  /// 编辑器中确认发送编辑后的图片，取消则不发送。
  Future<void> _editAndSendImage(XFile image) async {
    try {
      final bytes = await image.readAsBytes();
      if (!mounted) return;

      final editedBytes = await MediaEditorPage.open(
        context,
        imageBytes: bytes,
        filename: image.name,
      );

      // 用户取消编辑，不发送
      if (editedBytes == null || !mounted) return;

      final filename = image.name.isNotEmpty ? image.name : 'edited_image.jpg';
      final mimeType = lookupMimeType(filename) ?? 'image/jpeg';

      context.read<ChatBloc>().add(SendImageMessage(
        imageBytes: editedBytes,
        filename: filename,
        mimeType: mimeType,
        selfDestructAfter: _isViewOnce ? 1 : null,
      ));

      if (_isViewOnce) {
        setState(() => _isViewOnce = false);
      }
    } catch (e) {
      debugPrint('Edit image error: $e');
      // 编辑器出错时回退到直接发送
      await _sendImage(image);
    }
  }

  Future<void> _takePhoto() async {
    // 显示选择菜单：拍照或录像
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(S.of(context)?.commonTakePhoto ?? 'Take Photo'),
              onTap: () => Navigator.pop(context, 'photo'),
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: Text(S.of(context)?.chatRecording ?? 'Recording'),
              onTap: () => Navigator.pop(context, 'video'),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.close),
              title: Text(S.of(context)?.commonCancel ?? 'Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
    
    if (choice == null) return;
    
    try {
      final picker = ImagePicker();
      
      if (choice == 'photo') {
        final image = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 85,
          maxWidth: 1920,
          maxHeight: 1920,
        );
        
        if (image == null) return;
        await _editAndSendImage(image);
      } else if (choice == 'video') {
        debugPrint('Starting video recording...');
        final video = await picker.pickVideo(
          source: ImageSource.camera,
          maxDuration: const Duration(minutes: 5),
        );

        debugPrint('Video picker returned: ${video?.path ?? "null"}');

        if (video == null) {
          debugPrint('Video is null - user may have cancelled or recording failed');
          return;
        }

        // 验证视频文件存在
        final videoFile = File(video.path);
        if (!await videoFile.exists()) {
          debugPrint('Video file does not exist at path: ${video.path}');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context)?.chatVideoRecordingFailed ?? 'Video recording failed'),
                backgroundColor: AppColors.error,
              ),
            );
          }
          return;
        }

        final fileSize = await videoFile.length();
        debugPrint('Video file exists, size: $fileSize bytes');

        if (fileSize == 0) {
          debugPrint('Video file is empty');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context)?.chatVideoRecordingFailed ?? 'Video recording failed'),
                backgroundColor: AppColors.error,
              ),
            );
          }
          return;
        }

        await _sendVideo(video);
      }
    } catch (e) {
      debugPrint('Take photo/video error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatCaptureFailed(e.toString()) ?? 'Capture failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
  
  Future<void> _sendVideo(XFile video) async {
    try {
      debugPrint('=== _sendVideo start ===');
      debugPrint('Video path: ${video.path}');
      debugPrint('Video name: ${video.name}');
      
      // 显示发送中提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatProcessingVideo ?? 'Processing video...'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      
      // 读取视频字节 - 优先使用 XFile.readAsBytes()
      Uint8List bytes;
      try {
        bytes = await video.readAsBytes();
      } catch (e) {
        debugPrint('XFile.readAsBytes failed, trying File: $e');
        final file = File(video.path);
        if (!await file.exists()) {
          debugPrint('Video file not found: ${video.path}');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context)?.chatVideoFileNotExist ?? 'Video file does not exist'),
                backgroundColor: AppColors.error,
              ),
            );
          }
          return;
        }
        bytes = await file.readAsBytes();
      }
      
      if (bytes.isEmpty) {
        debugPrint('Video bytes is empty');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context)?.chatVideoDataEmpty ?? 'Video data is empty'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }
      
      // 处理文件名
      String filename = video.name;
      if (filename.isEmpty) {
        filename = 'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      }
      
      // 从路径获取扩展名
      final pathExt = video.path.split('.').last.toLowerCase();
      final hasExtInName = filename.contains('.');
      
      if (!hasExtInName && pathExt.isNotEmpty && pathExt.length <= 5) {
        filename = '$filename.$pathExt';
      }
      
      // 确保文件名有扩展名
      if (!filename.toLowerCase().endsWith('.mp4') && 
          !filename.toLowerCase().endsWith('.mov') &&
          !filename.toLowerCase().endsWith('.avi') &&
          !filename.toLowerCase().endsWith('.mkv') &&
          !filename.toLowerCase().endsWith('.webm')) {
        filename = '$filename.mp4';
      }
      
      // 确定 MIME 类型
      final String mimeType = lookupMimeType(filename) ?? 
                        lookupMimeType(video.path) ?? 
                        'video/mp4';
      
      // 检查文件大小（限制 100MB）
      const maxSize = 100 * 1024 * 1024; // 100MB
      if (bytes.length > maxSize) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context)?.chatVideoTooLarge ?? 'Video size cannot exceed 100MB'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }
      
      // 生成视频缩略图（第一帧）
      Uint8List? thumbnailBytes;
      try {
        debugPrint('Generating video thumbnail...');
        final thumbnailPath = await VideoThumbnail.thumbnailFile(
          video: video.path,
          thumbnailPath: (await Directory.systemTemp.createTemp()).path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: 320,
          quality: 75,
        );
        
        if (thumbnailPath != null) {
          final thumbnailFile = File(thumbnailPath);
          if (await thumbnailFile.exists()) {
            thumbnailBytes = await thumbnailFile.readAsBytes();
            debugPrint('Thumbnail generated: ${thumbnailBytes.length} bytes');
            // 清理临时文件
            await thumbnailFile.delete();
          }
        }
      } catch (e) {
        debugPrint('Failed to generate thumbnail: $e');
        // 缩略图生成失败不阻止视频发送
      }
      
      debugPrint('Final filename: $filename');
      debugPrint('Final mimeType: $mimeType');
      debugPrint('Video size: ${bytes.length} bytes');
      debugPrint('Thumbnail size: ${thumbnailBytes?.length ?? 0} bytes');
      debugPrint('=== Sending video to ChatBloc ===');

      if (!mounted) return;
      // 使用视频消息发送（带缩略图）
      context.read<ChatBloc>().add(SendVideoMessage(
        videoBytes: bytes,
        filename: filename,
        mimeType: mimeType,
        thumbnailBytes: thumbnailBytes,
        selfDestructAfter: _isViewOnce ? 1 : null,
      ));

      // 发送后重置 View Once 模式
      if (_isViewOnce) {
        setState(() {
          _isViewOnce = false;
        });
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatSendingVideo ?? 'Sending video...'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Send video error: $e');
      debugPrint('Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatSendVideoFailed(e.toString()) ?? 'Failed to send video: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
  
  Future<void> _sendImage(XFile image) async {
    try {
      debugPrint('=== _sendImage start ===');
      debugPrint('Image path: ${image.path}');
      debugPrint('Image name: ${image.name}');
      
      // 读取图片字节 - 优先使用 XFile.readAsBytes() 因为它支持所有平台
      Uint8List bytes;
      try {
        bytes = await image.readAsBytes();
      } catch (e) {
        // 如果 XFile.readAsBytes 失败，尝试使用 File
        debugPrint('XFile.readAsBytes failed, trying File: $e');
        final file = File(image.path);
        if (!await file.exists()) {
          debugPrint('Image file not found: ${image.path}');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context)?.chatImageFileNotExist ?? 'Image file does not exist'),
                backgroundColor: AppColors.error,
              ),
            );
          }
          return;
        }
        bytes = await file.readAsBytes();
      }
      
      if (bytes.isEmpty) {
        debugPrint('Image bytes is empty');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context)?.commonImageDataEmpty ?? 'Image data is empty'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }
      
      // 处理文件名 - iOS 相机拍照可能没有扩展名
      String filename = image.name;
      if (filename.isEmpty) {
        filename = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      }
      
      // 从路径获取扩展名（更可靠）
      final pathExt = image.path.split('.').last.toLowerCase();
      final hasExtInName = filename.contains('.');
      
      if (!hasExtInName && pathExt.isNotEmpty && pathExt.length <= 5) {
        filename = '$filename.$pathExt';
      }
      
      // 确保文件名有扩展名
      if (!filename.toLowerCase().endsWith('.jpg') && 
          !filename.toLowerCase().endsWith('.jpeg') &&
          !filename.toLowerCase().endsWith('.png') &&
          !filename.toLowerCase().endsWith('.gif') &&
          !filename.toLowerCase().endsWith('.webp') &&
          !filename.toLowerCase().endsWith('.heic') &&
          !filename.toLowerCase().endsWith('.heif')) {
        filename = '$filename.jpg';
      }
      
      // 确定 MIME 类型
      String mimeType = lookupMimeType(filename) ?? 
                        lookupMimeType(image.path) ?? 
                        'image/jpeg';
      
      // 特殊处理 HEIC/HEIF（iOS Live Photo）
      if (mimeType.contains('heic') || mimeType.contains('heif')) {
        mimeType = 'image/jpeg';
        if (!filename.toLowerCase().endsWith('.jpg') && 
            !filename.toLowerCase().endsWith('.jpeg')) {
          filename = filename.replaceAll(RegExp(r'\.(heic|heif)$', caseSensitive: false), '.jpg');
        }
      }
      
      // 自动检测人脸并模糊
      if (_autoFaceBlur && !kIsWeb) {
        debugPrint('FaceBlur: Auto face blur enabled, processing image...');
        bytes = await FaceBlurUtil.blurFaces(bytes);
        debugPrint('FaceBlur: Processing complete, image size: ${bytes.length} bytes');
      }

      debugPrint('Final filename: $filename');
      debugPrint('Final mimeType: $mimeType');
      debugPrint('Image size: ${bytes.length} bytes');
      debugPrint('=== Sending image to ChatBloc ===');

      if (!mounted) return;
      context.read<ChatBloc>().add(SendImageMessage(
        imageBytes: bytes,
        filename: filename,
        mimeType: mimeType,
        selfDestructAfter: _isViewOnce ? 1 : null,
      ));

      // 发送后重置 View Once 模式
      if (_isViewOnce) {
        setState(() {
          _isViewOnce = false;
        });
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatSendingImage ?? 'Sending image...'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Send image error: $e');
      debugPrint('Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatSendImageFailed(e.toString()) ?? 'Failed to send image: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

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

  /// 检查位置权限
  Future<bool> _checkLocationPermission() async {
    try {
      // 检查位置服务是否启用
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          final shouldOpen = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(S.of(context)?.chatLocationServiceNotEnabled ?? 'Location service is not enabled'),
              content: Text(S.of(context)?.chatEnableLocationService ?? 'Please enable location service to use this feature'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text(S.of(context)?.chatGoToSettings ?? 'Go to Settings'),
                ),
              ],
            ),
          );
          if (shouldOpen == true) {
            await Geolocator.openLocationSettings();
          }
        }
        return false;
      }
      
      // 检查权限
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context)?.chatLocationPermissionRequired ?? 'Location permission is required for this feature'),
                backgroundColor: AppColors.error,
              ),
            );
          }
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context)?.chatLocationPermissionDeniedPermanent ?? 'Location permission has been permanently denied. Please enable it in settings.'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return false;
      }
      
      return true;
    } catch (e) {
      debugPrint('Check location permission error: $e');
      return false;
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
  
  void _doSendRedPacket(String amount, String token, String greeting, int count, bool isLucky) {
    // 发送红包消息
    final metadata = MessageMetadata(
      amount: amount,
      token: token,
      transferStatus: 'pending',
    );
    
    context.read<ChatBloc>().add(SendCustomMessage(
      content: greeting,
      type: MessageType.redPacket,
      metadata: metadata,
    ));
    
    // 显示发送成功提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context)?.chatRedPacketSent(amount, token) ?? 'Sent $amount $token red packet'),
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

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
        withData: true,
      );
      
      if (result == null || result.files.isEmpty) return;
      
      // 发送选中的文件
      for (final file in result.files) {
        if (file.bytes == null || file.bytes!.isEmpty) {
          debugPrint('File bytes is empty: ${file.name}');
          continue;
        }
        
        await _sendFile(file);
      }
    } catch (e) {
      debugPrint('Pick file error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatPickFileFailed(e.toString()) ?? 'Failed to pick file: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _sendFile(PlatformFile file) async {
    try {
      final bytes = file.bytes;
      if (bytes == null || bytes.isEmpty) {
        debugPrint('File bytes is null or empty');
        return;
      }

      final filename = file.name;
      final mimeType = lookupMimeType(filename) ?? 'application/octet-stream';
      final fileSize = bytes.length;

      // 检查文件大小（限制 50MB）
      const maxSize = 50 * 1024 * 1024; // 50MB
      if (fileSize > maxSize) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context)?.chatFileSizeLimit ?? 'File size cannot exceed 50MB'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }

      debugPrint('Sending file: $filename, size: $fileSize bytes, mimeType: $mimeType');

      context.read<ChatBloc>().add(SendFileMessage(
        fileBytes: bytes,
        filename: filename,
        mimeType: mimeType,
      ));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatFileSending(filename) ?? 'Sending file: $filename'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      debugPrint('Send file error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatSendFileFailed(e.toString()) ?? 'Failed to send file: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  /// 发送名片
  Future<void> _sendContactCard() async {
    debugPrint('Send contact card');

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
    debugPrint('Share music');
    
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
          debugPrint('Error sending local music: $e');
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
    debugPrint('Select coupon');
    _showFeatureToast(S.of(context)?.chatCouponsFeature ?? 'Coupons');
  }

  void _sendGift() {
    // TODO(backend): 实现发送礼物功能 — 需要礼物系统集成
    debugPrint('Send gift');
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

      debugPrint('ChatPage: Creating poll - question: $question, options: $options, maxSelections: $maxSelections');

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
      debugPrint('ChatPage: Sending GIF - ${gif.title}');
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
    debugPrint('ChatPage: Sending sticker ${sticker.id} from pack $packId');
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
      debugPrint('ChatPage: Ignoring duplicate vote on poll $pollEventId');
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

    debugPrint('ChatPage: Voting on poll $pollEventId, new votes: $newVotes');

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
    debugPrint('ChatPage: Ending poll $pollEventId');

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

  /// 获取显示名称，私聊优先使用备注名
  String _getDisplayName() {
    // 群聊直接返回群名称
    if (widget.conversation.type == ConversationType.group) {
      final name = widget.conversation.name;
      // 如果群名为空或为默认值，显示成员数
      if (name.isEmpty || name == 'Empty Chat' || name == 'empty chat') {
        return S.of(context)?.chatGroupChatCount(widget.conversation.memberCount) ?? 'Group Chat(${widget.conversation.memberCount})';
      }
      return name;
    }

    // 私聊：直接使用 conversation.directUserId 获取备注名
    final otherUserId = widget.conversation.directUserId;
    if (otherUserId != null) {
      return RemarkService.instance.getDisplayName(otherUserId, widget.conversation.name);
    }

    // 如果名称为空或为默认值，返回简化的用户ID或默认文本
    final name = widget.conversation.name;
    if (name.isEmpty || name == 'Empty Chat' || name == 'empty chat') {
      return S.of(context)?.chatPrivateChat ?? 'Private Chat';
    }
    return name;
  }

  void _toggleSearch() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      if (!_showSearchBar) {
        _highlightedMessageId = null;
      }
    });
  }

  void _navigateToMessage(String eventId) {
    _scrollToMessage(eventId);
  }

  /// 滚动到指定消息并高亮显示
  void _scrollToMessage(String eventId) async {
    // 先检查消息是否在当前视图中
    final messageKey = _messageKeys[eventId];
    if (messageKey?.currentContext != null) {
      // 消息已加载，使用 Scrollable.ensureVisible 精确滚动
      await Scrollable.ensureVisible(
        messageKey!.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        alignment: 0.5, // 滚动到屏幕中间
      );
      _highlightMessage(eventId);
    } else {
      // 消息可能还没加载，尝试使用索引估算滚动
      final chatBloc = context.read<ChatBloc>();
      final state = chatBloc.state;
      final index = state.messages.indexWhere((m) => m.id == eventId);

      if (index != -1) {
        // 使用估算位置滚动
        unawaited(_scrollController.animateTo(
          index * 80.0, // 估算每条消息高度
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ));
        // 滚动后延迟设置高亮
        Future.delayed(const Duration(milliseconds: 350), () {
          if (mounted) {
            _highlightMessage(eventId);
          }
        });
      }
    }
  }

  /// 高亮显示指定消息（2秒后自动取消）
  void _highlightMessage(String eventId) {
    setState(() {
      _highlightedMessageId = eventId;
    });
    // 2秒后自动取消高亮
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && _highlightedMessageId == eventId) {
        setState(() {
          _highlightedMessageId = null;
        });
      }
    });
  }

  /// 构建置顶消息横幅
  Widget _buildPinnedMessageBanner() {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (prev, curr) =>
          prev.pinnedMessages != curr.pinnedMessages ||
          prev.currentPinnedIndex != curr.currentPinnedIndex,
      builder: (context, state) {
        if (state.pinnedMessages.isEmpty) {
          return const SizedBox.shrink();
        }

        final msg = state.currentPinnedMessage;
        if (msg == null) return const SizedBox.shrink();

        final isDark = context.isDarkMode;
        final bgColor = isDark ? AppColors.surfaceDark : AppColors.surface;
        final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
        final secondaryTextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

        return GestureDetector(
          onTap: () => _scrollToMessage(msg.id),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.dividerDark : AppColors.divider,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                // 置顶图标
                const Icon(
                  Icons.push_pin,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                // 消息内容预览
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        msg.senderName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        _getPinnedMessagePreview(msg),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // 多条置顶时显示计数和导航
                if (state.pinnedMessages.length > 1) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      context.read<ChatBloc>().add(const NavigatePinnedMessage(1));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${state.currentPinnedIndex + 1}/${state.pinnedMessages.length}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
                // 关闭按钮（如果有权限可以取消置顶）
                if (state.canPinMessages)
                  IconButton(
                    icon: Icon(Icons.close, size: 16, color: secondaryTextColor),
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context.read<ChatBloc>().add(UnpinMessage(msg.id));
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 获取置顶消息预览文本
  String _getPinnedMessagePreview(MessageEntity msg) {
    switch (msg.type) {
      case MessageType.text:
        return msg.content;
      case MessageType.image:
        return '[${S.of(context)?.commonImage ?? 'Image'}]';
      case MessageType.video:
        return '[${S.of(context)?.chatVideoTitle ?? 'Video'}]';
      case MessageType.audio:
        return '[${S.of(context)?.chatVoiceMessage ?? 'Voice'}]';
      case MessageType.file:
        return '[${S.of(context)?.commonFile ?? 'File'}] ${msg.metadata?.fileName ?? ''}';
      case MessageType.location:
        return '[${S.of(context)?.chatLocation ?? 'Location'}]';
      default:
        return msg.content.isNotEmpty ? msg.content : '[${S.of(context)?.chatMessage ?? 'Message'}]';
    }
  }

  Widget _buildMessageList() {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        // 显示错误
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return N42Loading(message: S.of(context)?.commonLoading ?? 'Loading...');
        }

        if (state.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEncryptionNotice(),
              const SizedBox(height: 16),
              N42EmptyState.noData(
                title: S.of(context)?.chatNoMessages ?? 'No messages',
                description: S.of(context)?.chatSendFirstMessage ?? 'Send first message to start chatting',
              ),
            ],
          );
        }

        // 额外项数：加密提示(1) + 加载更多指示器(可选)
        final extraItems = 1 + (state.isLoadingMore ? 1 : 0);
        
        return ListView.builder(
          controller: _scrollController,
          reverse: true, // 从底部开始显示
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: state.messages.length + extraItems,
          itemBuilder: (context, index) {
            // 加载更多指示器（列表顶部，index 最大）
            if (state.isLoadingMore && index == state.messages.length + 1) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: N42Loading(),
              );
            }
            
            // 端对端加密提示 + 群聊 AI 摘要（在所有消息之上）
            if (index == state.messages.length) {
              final isGroup = widget.conversation.type == ConversationType.group;
              final aiAvailable = getIt.isRegistered<AiService>();
              return Column(
                children: [
                  _buildEncryptionNotice(),
                  if (isGroup && aiAvailable) ...[
                    if (_aiSummaryResult != null || _isAiSummarizing)
                      AiSummaryBubble(
                        summary: _aiSummaryResult ?? '',
                        messageCount: state.messages.where((m) => m.type == MessageType.text).take(50).length,
                        isLoading: _isAiSummarizing,
                        onDismiss: () => setState(() { _aiSummaryResult = null; }),
                      )
                    else
                      AiSummarizeButton(
                        unreadCount: state.messages.where((m) => m.type == MessageType.text).take(50).length,
                        onTap: _summarizeRecentMessages,
                      ),
                  ],
                ],
              );
            }

            final message = state.messages[index];
            final previousMessage =
                index < state.messages.length - 1 ? state.messages[index + 1] : null;

            // 判断是否显示时间分隔器
            final showTimeSeparator = _shouldShowTimeSeparator(
              message,
              previousMessage,
            );

            // 群聊中判断是否需要显示发送者名称
            // 如果与上一条消息发送者不同，或者时间间隔较大，则显示名称
            final isGroupChat = widget.conversation.type == ConversationType.group;
            final showSenderName = isGroupChat && !message.isFromMe && (
              previousMessage == null ||
              previousMessage.senderId != message.senderId ||
              _shouldShowTimeSeparator(message, previousMessage)
            );

            // 检查消息是否被撤回：
            // 1. BLoC state 中已是 redacted 类型（服务端确认或乐观更新）
            // 2. 本会话中通过长按菜单撤回的消息（_recalledMessageIds 追踪）
            // 两个条件满足任意一个即显示"已撤回"提示；
            // 长按菜单撤回的消息（最后一条）额外显示"重新编辑"按钮。
            final isRecalled = message.type == MessageType.redacted ||
                _recalledMessageIds.contains(message.id);
            if (isRecalled) {
              // 仅对本会话内通过长按菜单撤回的最后一条消息提供"重新编辑"
              final canReEdit = message.isFromMe &&
                  _recalledMessageIds.contains(message.id) &&
                  _lastRecalledContent != null;
              return Column(
                children: [
                  if (showTimeSeparator)
                    TimeSeparator(dateTime: message.timestamp),
                  RecalledMessageWidget(
                    isFromMe: message.isFromMe,
                    onReEdit: canReEdit ? () => _onReEditRecalledMessage() : null,
                  ),
                ],
              );
            }

            // 为消息创建/获取 GlobalKey
            _messageKeys.putIfAbsent(message.id, () => GlobalKey());
            final messageKey = _messageKeys[message.id]!;

            return Column(
              children: [
                if (showTimeSeparator)
                  TimeSeparator(dateTime: message.timestamp),
                // 多选模式下显示复选框
                _isMultiSelectMode
                    ? _buildMultiSelectMessageItem(
                        message: message,
                        messageKey: messageKey,
                        isGroupChat: isGroupChat,
                        showSenderName: showSenderName,
                      )
                    : Container(
                        key: messageKey,
                        child: MessageItem(
                          message: message,
                          isHighlighted: message.id == _highlightedMessageId,
                          onTap: () => _onMessageTap(message),
                          onLongPress: () => _showWeChatMessageMenu(message, messageKey),
                          onAvatarTap: () => _onAvatarTap(message),
                          onAvatarDoubleTap: () => _onAvatarDoubleTap(message),
                          onResend: () => _onResend(message),
                          isGroupChat: isGroupChat,
                          showSenderName: showSenderName,
                          currentUserId: _currentUserId,
                          onReactionTap: (emoji) => _addReaction(message, emoji),
                          onPollVote: (pollEventId, optionId, currentVotes, maxSelections) => _onPollVote(pollEventId, optionId, currentVotes, maxSelections),
                          onEndPoll: (pollEventId) => _onEndPoll(pollEventId),
                          onRedPacketTap: _onRedPacketTap,
                          onContactCardTap: _onContactCardTap,
                          onReplyQuoteTap: _scrollToMessage,
                          onThreadTap: _navigateToThread,
                          messageFontSize: _messageFontSize,
                        ),
                      ),
              ],
            );
          },
        );
      },
    );
  }
  
  /// 构建多选模式下的消息项
  Widget _buildMultiSelectMessageItem({
    required MessageEntity message,
    required GlobalKey messageKey,
    required bool isGroupChat,
    required bool showSenderName,
  }) {
    final isRedacted = message.type == MessageType.redacted;
    final isSelected = !isRedacted && _selectedMessageIds.contains(message.id);
    final isDark = context.isDarkMode;

    return GestureDetector(
      onTap: isRedacted ? null : () => _toggleMessageSelection(message.id),
      child: Container(
        key: messageKey,
        color: isSelected
            ? (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.blue.withValues(alpha: 0.1))
            : Colors.transparent,
        child: Row(
          children: [
            // 复选框（已撤回的消息显示禁用状态）
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isRedacted
                      ? (isDark ? Colors.grey.shade800 : Colors.grey.shade300)
                      : (isSelected ? AppColors.primary : Colors.transparent),
                  border: Border.all(
                    color: isRedacted
                        ? (isDark ? Colors.grey.shade600 : Colors.grey.shade400)
                        : (isSelected
                            ? AppColors.primary
                            : (isDark ? Colors.white54 : Colors.black38)),
                    width: 2,
                  ),
                ),
                child: isRedacted
                    ? Icon(
                        Icons.block,
                        size: 14,
                        color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                      )
                    : (isSelected
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                        : null),
              ),
            ),
            // 消息内容
            Expanded(
              child: IgnorePointer(
                child: MessageItem(
                  message: message,
                  isHighlighted: message.id == _highlightedMessageId,
                  onTap: () {},
                  onLongPress: () {},
                  onAvatarTap: () {},
                  onResend: () {},
                  isGroupChat: isGroupChat,
                  showSenderName: showSenderName,
                  currentUserId: _currentUserId,
                  onReactionTap: null, // 多选模式下不响应表情点击
                  onRedPacketTap: null, // 多选模式下不响应红包点击
                  messageFontSize: _messageFontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建端对端加密提示
  Widget _buildEncryptionNotice() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primaryWithOpacity,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_outline,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                S.of(context)?.chatEncryptionNotice ?? 'This chat is end-to-end encrypted. Only you and the recipient can read the messages.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplyPreview() {
    // 预先从父级 context 获取本地化，避免 BlocBuilder 内部 context 语言不正确
    final l10n = S.of(context);
    final isDark = context.isDarkMode;

    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (prev, curr) => prev.replyTarget != curr.replyTarget,
      builder: (_, state) {
        if (state.replyTarget == null) {
          return const SizedBox.shrink();
        }

        final replyToText = l10n?.chatReplyTo(state.replyTarget!.senderName) ?? 'Reply to ${state.replyTarget!.senderName}';

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            border: Border(
              top: BorderSide(
                color: isDark ? AppColors.dividerDark : AppColors.divider,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      replyToText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      state.replyTarget!.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                onPressed: () {
                  context.read<ChatBloc>().add(const SetReplyTarget(null));
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildEditPreview() {
    final l10n = S.of(context);
    final isDark = context.isDarkMode;

    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (prev, curr) => prev.editingMessage != curr.editingMessage,
      builder: (_, state) {
        if (state.editingMessage == null) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            border: Border(
              top: BorderSide(
                color: isDark ? AppColors.dividerDark : AppColors.divider,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.commonEdit ?? 'Edit',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      state.editingMessage!.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                onPressed: () {
                  context.read<ChatBloc>().add(const SetEditTarget(null));
                  _inputController.clear();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// 构建多选模式底部工具栏
  Widget _buildMultiSelectBottomBar() {
    final isDark = context.isDarkMode;
    final hasSelection = _selectedMessageIds.isNotEmpty;

    // 是否有可撤回的消息（自己发的、未被撤回的）
    final stateMessages = context.read<ChatBloc>().state.messages;
    final hasOwnSelection = hasSelection &&
        stateMessages.any((m) =>
            _selectedMessageIds.contains(m.id) &&
            m.isFromMe &&
            m.type != MessageType.redacted);

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMultiSelectAction(
            icon: Icons.forward,
            label: S.of(context)?.chatMultiForward ?? 'Forward',
            enabled: hasSelection,
            onTap: hasSelection ? _forwardSelectedMessages : null,
          ),
          _buildMultiSelectAction(
            icon: Icons.star_border,
            label: S.of(context)?.chatCollect ?? 'Collect',
            enabled: hasSelection,
            onTap: hasSelection ? _favoriteSelectedMessages : null,
          ),
          _buildMultiSelectAction(
            icon: Icons.undo,
            label: '撤回',
            enabled: hasOwnSelection,
            onTap: hasOwnSelection ? _recallSelectedMessages : null,
            isDestructive: true,
          ),
          _buildMultiSelectAction(
            icon: Icons.delete_outline,
            label: S.of(context)?.commonDelete ?? 'Delete',
            enabled: hasSelection,
            onTap: hasSelection ? _deleteSelectedMessages : null,
            isDestructive: true,
          ),
        ],
      ),
    );
  }
  
  Widget _buildMultiSelectAction({
    required IconData icon,
    required String label,
    required bool enabled,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    final isDark = context.isDarkMode;
    final color = !enabled
        ? (isDark ? Colors.white38 : Colors.black26)
        : isDestructive
            ? AppColors.error
            : (isDark ? Colors.white : Colors.black87);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// 收藏选中的消息
  void _favoriteSelectedMessages() {
    if (_selectedMessageIds.isEmpty) return;
    
    setState(() {
      _favoritedMessageIds.addAll(_selectedMessageIds);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context)?.chatCollectMessages(_selectedMessageIds.length) ?? 'Collected ${_selectedMessageIds.length} messages'),
        duration: const Duration(seconds: 1),
      ),
    );
    
    _exitMultiSelectMode();
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
  
  /// 加载群成员
  Future<List<Map<String, String>>> _loadGroupMembers() async {
    try {
      final groupRepository = getIt<IGroupRepository>();
      final members = await groupRepository.getGroupMembers(widget.conversation.id);
      
      return members.map((m) => {
        'id': m.userId,
        'name': m.displayName.isNotEmpty ? m.displayName : m.userId,
        'avatarUrl': m.avatarUrl ?? '',
      }).toList();
    } catch (e) {
      debugPrint('Error loading group members: $e');
      return [];
    }
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

  Future<void> _sendVoiceMessage(String path, Duration duration) async {
    debugPrint('Sending voice message: path=$path, duration=${duration.inSeconds}s');
    
    try {
      final file = File(path);
      if (!await file.exists()) {
        debugPrint('Voice file not found: $path');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context)?.chatVoiceFileNotExist ?? 'Voice file does not exist'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }
      
      final fileSize = await file.length();
      debugPrint('Voice file size: $fileSize bytes');
      
      if (fileSize == 0) {
        debugPrint('Voice file is empty');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context)?.chatVoiceFileEmpty ?? 'Voice file is empty'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }
      
      final bytes = await file.readAsBytes();
      final filename = path.split(Platform.pathSeparator).last;
      
      // 根据文件扩展名确定 MIME 类型
      String mimeType = 'audio/mp4';
      if (filename.endsWith('.m4a')) {
        mimeType = 'audio/mp4';
      } else if (filename.endsWith('.ogg')) {
        mimeType = 'audio/ogg';
      } else if (filename.endsWith('.wav')) {
        mimeType = 'audio/wav';
      } else if (filename.endsWith('.mp3')) {
        mimeType = 'audio/mpeg';
      }
      
      debugPrint('Sending voice: filename=$filename, mimeType=$mimeType, size=${bytes.length}');

      if (!mounted) return;
      context.read<ChatBloc>().add(SendVoiceMessage(
        audioBytes: bytes,
        filename: filename,
        duration: duration.inMilliseconds,
        mimeType: mimeType,
      ));
      
      // 删除临时文件
      try {
        await file.delete();
        debugPrint('Temporary voice file deleted');
      } catch (e) {
        debugPrint('Failed to delete temp file: $e');
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatSendingVoice ?? 'Sending voice...'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Send voice message error: $e');
      debugPrint('Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatSendVoiceFailed(e.toString()) ?? 'Failed to send voice: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Widget _buildScrollToBottomButton() {
    return FloatingActionButton.small(
      onPressed: _scrollToBottom,
      backgroundColor: AppColors.surface,
      child: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.textSecondary,
      ),
    );
  }

  bool _shouldShowTimeSeparator(
    MessageEntity current,
    MessageEntity? previous,
  ) {
    if (previous == null) return true;

    final diff = current.timestamp.difference(previous.timestamp).abs();
    return diff.inMinutes >= 5;
  }

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

  /// 保存媒体文件（图片/视频）
  Future<void> _saveMedia(MessageEntity message) async {
    final imageUrl = message.metadata?.httpUrl ?? message.content;
    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.chatNoMediaUrlAvailable ?? 'No media URL available')),
      );
      return;
    }

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.chatSaving ?? 'Saving...')),
      );

      // 下载文件
      final response = await http.get(
        Uri.parse(imageUrl),
        headers: {
          if (MatrixClientManager.instance.client?.accessToken != null)
            'Authorization': 'Bearer ${MatrixClientManager.instance.client!.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        // 保存到相册
        final result = await SaverGallery.saveImage(
          response.bodyBytes,
          fileName: 'n42_${DateTime.now().millisecondsSinceEpoch}.jpg',
          skipIfExists: false,
        );

        if (mounted) {
          if (result.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context)?.commonSavedToGallery ?? 'Saved to gallery')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context)?.commonFailedToSave ?? 'Failed to save')),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context)?.chatDownloadFailed(response.statusCode.toString()) ?? 'Download failed: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      debugPrint('Save media error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.chatErrorWithMessage(e.toString()) ?? 'Error: $e')),
        );
      }
    }
  }
  
  /// 复制消息
  void _copyMessage(MessageEntity message) {
    final String textToCopy;

    switch (message.type) {
      case MessageType.text:
        textToCopy = message.content;
      case MessageType.location:
        textToCopy = message.content; // 位置描述
      default:
        // 对于其他类型的消息，复制消息类型描述
        textToCopy = _getMessageTypeDescription(message.type);
    }

    if (textToCopy.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: textToCopy));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatCopied ?? 'Copied'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
  
  String _getMessageTypeDescription(MessageType type) {
    switch (type) {
      case MessageType.image:
        return S.of(context)?.commonImage ?? '[Image]';
      case MessageType.audio:
        return S.of(context)?.chatVoice ?? '[Voice]';
      case MessageType.video:
        return S.of(context)?.chatVideo ?? '[Video]';
      case MessageType.file:
        return S.of(context)?.commonFile ?? '[File]';
      case MessageType.location:
        return S.of(context)?.chatLocation ?? '[Location]';
      case MessageType.transfer:
        return S.of(context)?.commonTransfer ?? '[Transfer]';
      case MessageType.music:
        return '[Music]';
      default:
        return '';
    }
  }
  
  /// 转发消息
  void _forwardMessage(MessageEntity message) {
    _showForwardDialog(message);
  }
  
  /// 显示转发对话框
  Future<void> _showForwardDialog(MessageEntity message) async {
    final isDark = context.isDarkMode;
    
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => ForwardMessageSheet(
        message: message,
        isDark: isDark,
        onForwardToChat: (conversationId) {
          Navigator.pop(ctx);
          _doForwardMessage(message, conversationId);
        },
      ),
    );
  }
  
  /// 执行转发
  Future<void> _doForwardMessage(MessageEntity message, String targetRoomId) async {
    debugPrint('Forward message: ${message.id} from ${widget.conversation.id} to $targetRoomId');
    debugPrint('Message type: ${message.type}, content: ${message.content}');

    // 直接使用简单转发，避免重复发送问题
    // （之前的 repository.forwardMessage 可能发送成功但返回 null，导致 fallback 再次发送）
    try {
      await _simpleForwardMessage(message, targetRoomId);
    } catch (e) {
      debugPrint('Forward message error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatForwardFailed(e.toString()) ?? 'Forward failed: $e'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  
  /// 简单转发消息（作为备用方案）
  /// 对于媒体消息，下载后重新发送以确保正确转发
  Future<void> _simpleForwardMessage(MessageEntity message, String targetRoomId) async {
    final messageRepository = getIt<IMessageRepository>();

    try {
      switch (message.type) {
        case MessageType.text:
          await messageRepository.sendTextMessage(targetRoomId, message.content);
          break;

        case MessageType.image:
          // 优先使用直接转发 mxc URL 的方式（Matrix SDK 推荐方式）
          final mediaUrl = message.metadata?.mediaUrl;
          if (mediaUrl != null) {
            debugPrint('Forward image: Using direct mxc URL forward (recommended)');
            final result = await messageRepository.forwardMediaMessage(
              targetRoomId,
              mxcUrl: mediaUrl,
              msgType: 'm.image',
              filename: message.content.isNotEmpty ? message.content : 'image.jpg',
              mimeType: message.metadata?.mimeType,
              width: message.metadata?.width,
              height: message.metadata?.height,
              size: message.metadata?.size,
              thumbnailUrl: message.metadata?.thumbnailUrl,
            );
            if (result == null) {
              // 直接转发失败，尝试下载后重新上传
              debugPrint('Forward image: Direct forward failed, trying download and re-upload');
              final imageBytes = await messageRepository.downloadMedia(mediaUrl);
              if (imageBytes != null) {
                await messageRepository.sendImageMessage(
                  targetRoomId,
                  imageBytes: imageBytes,
                  filename: message.content.isNotEmpty ? message.content : 'image.jpg',
                  mimeType: message.metadata?.mimeType,
                );
              } else {
                // 两种方法都失败，抛出异常
                throw Exception('Image forward failed: Cannot download original image');
              }
            }
          } else {
            throw Exception('Image forward failed: Missing image URL');
          }
          break;

        case MessageType.video:
          // 优先使用直接转发 mxc URL 的方式
          final videoUrl = message.metadata?.mediaUrl;
          if (videoUrl != null) {
            debugPrint('Forward video: Using direct mxc URL forward (recommended)');
            final result = await messageRepository.forwardMediaMessage(
              targetRoomId,
              mxcUrl: videoUrl,
              msgType: 'm.video',
              filename: message.content.isNotEmpty ? message.content : 'video.mp4',
              mimeType: message.metadata?.mimeType,
              width: message.metadata?.width,
              height: message.metadata?.height,
              size: message.metadata?.size,
              duration: message.metadata?.duration,
              thumbnailUrl: message.metadata?.thumbnailUrl,
            );
            if (result == null) {
              // 直接转发失败，尝试下载后重新上传
              debugPrint('Forward video: Direct forward failed, trying download and re-upload');
              final videoBytes = await messageRepository.downloadMedia(videoUrl);
              if (videoBytes != null) {
                await messageRepository.sendVideoMessage(
                  targetRoomId,
                  videoBytes: videoBytes,
                  filename: message.content.isNotEmpty ? message.content : 'video.mp4',
                  mimeType: message.metadata?.mimeType,
                );
              } else {
                throw Exception('Video forward failed: Cannot download original video');
              }
            }
          } else {
            throw Exception('Video forward failed: Missing video URL');
          }
          break;

        case MessageType.audio:
          // 优先使用直接转发 mxc URL 的方式
          final audioUrl = message.metadata?.mediaUrl;
          if (audioUrl != null) {
            debugPrint('Forward audio: Using direct mxc URL forward (recommended)');
            final result = await messageRepository.forwardMediaMessage(
              targetRoomId,
              mxcUrl: audioUrl,
              msgType: 'm.audio',
              filename: message.content.isNotEmpty ? message.content : 'audio.m4a',
              mimeType: message.metadata?.mimeType,
              size: message.metadata?.size,
              duration: message.metadata?.duration,
            );
            if (result == null) {
              // 直接转发失败，尝试下载后重新上传
              debugPrint('Forward audio: Direct forward failed, trying download and re-upload');
              final audioBytes = await messageRepository.downloadMedia(audioUrl);
              if (audioBytes != null) {
                await messageRepository.sendVoiceMessage(
                  targetRoomId,
                  audioBytes: audioBytes,
                  filename: message.content.isNotEmpty ? message.content : 'audio.m4a',
                  duration: message.metadata?.duration ?? 0,
                  mimeType: message.metadata?.mimeType,
                );
              } else {
                throw Exception('Voice forward failed: Cannot download original voice');
              }
            }
          } else {
            throw Exception('Voice forward failed: Missing voice URL');
          }
          break;

        case MessageType.file:
          // 下载文件并重新发送
          final fileUrl = message.metadata?.mediaUrl;
          final httpUrl = message.metadata?.httpUrl;
          final fileName = message.metadata?.fileName ?? message.content;
          final originalSize = message.metadata?.size;
          debugPrint('Forward file: mediaUrl=$fileUrl, httpUrl=$httpUrl, fileName=$fileName, originalSize=$originalSize');

          // 尝试使用 mediaUrl 或 httpUrl 下载
          Uint8List? fileBytes;
          if (fileUrl != null && fileUrl.isNotEmpty) {
            debugPrint('Downloading file from mxc URL: $fileUrl');
            fileBytes = await messageRepository.downloadMedia(fileUrl);
            debugPrint('Download result from mxc: ${fileBytes?.length ?? 0} bytes');
          }

          if (fileBytes == null && httpUrl != null && httpUrl.isNotEmpty) {
            debugPrint('Fallback: downloading from HTTP URL: $httpUrl');
            try {
              // Matrix 1.11+ 需要认证的媒体访问，需要添加 Authorization header
              final headers = <String, String>{};
              // 尝试获取 access token
              try {
                final matrixClient = getIt<MatrixClientManager>().client;
                if (matrixClient?.accessToken != null) {
                  headers['Authorization'] = 'Bearer ${matrixClient!.accessToken}';
                }
              } catch (e) {
                debugPrint('Could not get access token: $e');
              }

              final response = await http.get(Uri.parse(httpUrl), headers: headers);
              if (response.statusCode == 200) {
                fileBytes = response.bodyBytes;
                debugPrint('Download result from http: ${fileBytes.length} bytes');
              } else {
                debugPrint('HTTP download failed with status: ${response.statusCode}');
              }
            } catch (e) {
              debugPrint('HTTP download failed: $e');
            }
          }

          if (fileBytes != null && fileBytes.isNotEmpty) {
            debugPrint('File downloaded successfully, size: ${fileBytes.length}');
            // 验证文件大小是否正确
            if (originalSize != null && fileBytes.length != originalSize) {
              debugPrint('Warning: Downloaded file size (${fileBytes.length}) differs from original ($originalSize)');
            }
            await messageRepository.sendFileMessage(
              targetRoomId,
              fileBytes: fileBytes,
              filename: fileName,
              mimeType: message.metadata?.mimeType,
            );
          } else {
            debugPrint('File download failed, cannot forward file');
            // 不再发送文本替代，而是抛出异常让用户知道转发失败
            throw Exception('Unable to download file for forwarding');
          }
          break;

        case MessageType.location:
          // 转发位置消息
          final lat = message.metadata?.latitude;
          final lon = message.metadata?.longitude;
          if (lat != null && lon != null) {
            await messageRepository.sendLocationMessage(
              targetRoomId,
              latitude: lat,
              longitude: lon,
              description: message.content,
            );
          } else {
            throw Exception('Location forward failed: Missing location info');
          }
          break;

        case MessageType.poll:
          // 转发投票消息 - 发送投票快照（包含投票结果，不可再投票）
          final question = message.metadata?.pollQuestion;
          final options = message.metadata?.pollOptions;
          final optionIds = message.metadata?.pollOptionIds;
          final maxSelections = message.metadata?.maxSelections ?? 1;

          if (question != null && options != null && options.isNotEmpty) {
            // 主动获取最新的投票聚合数据，确保转发的投票包含最新结果
            var voteCounts = message.metadata?.voteCounts ?? <String, int>{};
            var totalVoters = message.metadata?.totalVoters ?? 0;

            try {
              final aggregations = await messageRepository.getPollAggregations(
                message.roomId,
                message.id,
              );
              if (aggregations != null) {
                voteCounts = (aggregations['voteCounts'] as Map<String, dynamic>?)
                    ?.cast<String, int>() ?? voteCounts;
                totalVoters = aggregations['totalVoters'] as int? ?? totalVoters;
                debugPrint('Forward poll: fetched latest aggregations - voteCounts=$voteCounts, totalVoters=$totalVoters');
              }
            } catch (e) {
              debugPrint('Forward poll: failed to fetch aggregations, using cached data: $e');
            }

            debugPrint('Forward poll snapshot: question=$question, options=$options, voteCounts=$voteCounts');

            // 确保有optionIds，如果没有则生成
            final effectiveOptionIds = optionIds ?? List.generate(options.length, (i) => 'option_$i');

            await messageRepository.sendForwardedPollSnapshot(
              targetRoomId,
              question: question,
              options: options,
              optionIds: effectiveOptionIds,
              voteCounts: voteCounts,
              totalVoters: totalVoters,
              maxSelections: maxSelections,
            );
          } else {
            throw Exception('Poll forward failed: Missing poll info');
          }
          break;

        case MessageType.music:
          // 转发音乐分享消息
          final title = message.metadata?.musicTitle;
          final artist = message.metadata?.musicArtist;
          final url = message.metadata?.musicUrl;
          final cover = message.metadata?.musicCover;

          if (title != null) {
            await messageRepository.sendCustomMessage(
              targetRoomId,
              msgType: 'n42.music',
              content: '🎵 $title - ${artist ?? ''}',
              additionalData: {
                'title': title,
                'artist': artist ?? '',
                'url': url ?? '',
                'cover': cover ?? '',
              },
            );
          } else {
            throw Exception('Music forward failed: Missing music info');
          }
          break;

        default:
          // 未知类型消息，直接发送文本内容
          await messageRepository.sendTextMessage(targetRoomId, message.content);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.chatMessageForwarded ?? 'Message forwarded'),
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Simple forward error: $e');
      // 重新抛出异常，让上层处理
      rethrow;
    }
  }

  /// 收藏消息
  void _favoriteMessage(MessageEntity message) {
    final actionBloc = getIt<MessageActionBloc>();

    if (_favoritedMessageIds.contains(message.id)) {
      actionBloc.add(action_event.UnsaveMessage(message.id));
      setState(() => _favoritedMessageIds.remove(message.id));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatUnfavorited ?? 'Unfavorited'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      actionBloc.add(action_event.SaveMessage(message));
      setState(() => _favoritedMessageIds.add(message.id));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatFavorited ?? 'Favorited'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
  
  /// 添加或移除表情回应
  void _addReaction(MessageEntity message, String emoji) {
    // 检查当前用户是否已经对这个表情做出了回应
    final existingReaction = message.reactions.where((r) => r.key == emoji).firstOrNull;
    final isRemoving = existingReaction != null && existingReaction.isMe;

    debugPrint('${isRemoving ? "Removing" : "Adding"} reaction $emoji to message ${message.id}');

    // 通过 ChatBloc 发送表情回应（toggle 逻辑在 bloc 中处理）
    context.read<ChatBloc>().add(AddReaction(
      messageId: message.id,
      emoji: emoji,
    ));

    // 显示反馈 - 根据是添加还是移除显示不同消息
    final feedbackText = isRemoving
        ? (S.of(context)?.chatReactionRemoved ?? 'Reaction removed')
        : (S.of(context)?.chatReactionAdded ?? 'Reaction added');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(feedbackText),
          ],
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 本地删除消息（仅从本地移除，对方仍可见）
  Future<void> _deleteMessageLocally(MessageEntity message) async {
    // 显示确认对话框
    final confirmed = await _showDeleteConfirmDialog();
    if (!confirmed) return;

    if (!mounted) return;
    // 本地删除
    context.read<ChatBloc>().add(DeleteMessagesLocally([message.id]));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatMessageDeleted ?? 'Message deleted'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  /// 显示删除确认对话框
  Future<bool> _showDeleteConfirmDialog() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ChatDeleteConfirmSheet(),
    );
    return result ?? false;
  }

  /// 撤回消息
  Future<void> _recallMessage(MessageEntity message) async {
    if (!message.isFromMe) return;
    
    // 显示撤回确认对话框
    final confirmed = await showRecallConfirmDialog(context);
    if (!confirmed) return;

    if (!mounted) return;
    // 保存撤回的消息内容，用于"重新编辑"
    if (message.type == MessageType.text) {
      _lastRecalledContent = message.content;
    }

    // 记录撤回的消息 ID
    setState(() {
      _recalledMessageIds.add(message.id);
    });

    // 调用撤回 API
    context.read<ChatBloc>().add(RedactMessage(message.id));
  }
  
  /// 进入多选模式
  void _enterMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = true;
      _selectedMessageIds.clear();
    });
  }
  
  /// 退出多选模式
  void _exitMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = false;
      _selectedMessageIds.clear();
    });
  }
  
  /// 切换消息选中状态
  void _toggleMessageSelection(String messageId) {
    setState(() {
      if (_selectedMessageIds.contains(messageId)) {
        _selectedMessageIds.remove(messageId);
      } else {
        _selectedMessageIds.add(messageId);
      }
    });
  }
  
  /// 批量删除选中的消息
  Future<void> _deleteSelectedMessages() async {
    if (_selectedMessageIds.isEmpty) return;

    // 获取选中的消息（过滤掉已撤回的消息）
    final messages = context.read<ChatBloc>().state.messages;
    final selectedMessages = messages.where((m) =>
      _selectedMessageIds.contains(m.id) && m.type != MessageType.redacted
    ).toList();

    // 如果过滤后没有可删除的消息，直接返回
    if (selectedMessages.isEmpty) {
      _exitMultiSelectMode();
      return;
    }
    
    // 检查是否所有消息都是自己发送的
    final myMessages = selectedMessages.where((m) => m.isFromMe).toList();
    final otherMessages = selectedMessages.where((m) => !m.isFromMe).toList();
    
    // 显示确认对话框
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.chatDeleteMessages ?? 'Delete messages'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context)?.chatDeleteMessagesConfirm(selectedMessages.length) ?? 'Are you sure you want to delete ${selectedMessages.length} messages?'),
            if (otherMessages.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                S.of(context)?.chatNoteOtherMessages(otherMessages.length) ?? 'Note: ${otherMessages.length} messages are from others, can only delete locally.',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
            if (myMessages.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                S.of(context)?.chatMyMessagesWillBeRecalled(myMessages.length) ?? '${myMessages.length} messages from you will be recalled.',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              S.of(context)?.commonDelete ?? 'Delete',
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    
    if (confirmed != true) return;

    if (!mounted) return;
    final chatBloc = context.read<ChatBloc>();
    int redactedCount = 0;
    int localDeletedCount = 0;
    
    // 撤回自己的消息（服务器端删除）
    for (final msg in myMessages) {
      chatBloc.add(RedactMessage(msg.id));
      redactedCount++;
    }
    
    // 对于他人消息，从本地删除（仅在本地 UI 中移除）
    if (otherMessages.isNotEmpty) {
      final otherMessageIds = otherMessages.map((m) => m.id).toList();
      chatBloc.add(DeleteMessagesLocally(otherMessageIds));
      localDeletedCount = otherMessages.length;
    }
    
    if (mounted) {
      String message;
      if (redactedCount > 0 && localDeletedCount > 0) {
        message = S.of(context)?.chatRecalledCount(redactedCount, localDeletedCount) ?? 'Recalled $redactedCount messages, deleted $localDeletedCount locally';
      } else if (redactedCount > 0) {
        message = S.of(context)?.chatRecalledMessages(redactedCount) ?? 'Recalled $redactedCount messages';
      } else {
        message = S.of(context)?.chatDeletedLocally(localDeletedCount) ?? 'Deleted $localDeletedCount messages (locally)';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }

    _exitMultiSelectMode();
  }

  /// 撤回选中的消息（仅限自己发送的、未撤回的消息）
  Future<void> _recallSelectedMessages() async {
    if (_selectedMessageIds.isEmpty) return;

    final messages = context.read<ChatBloc>().state.messages;
    final myMessages = messages
        .where((m) =>
            _selectedMessageIds.contains(m.id) &&
            m.isFromMe &&
            m.type != MessageType.redacted)
        .toList();

    if (myMessages.isEmpty) {
      _exitMultiSelectMode();
      return;
    }

    // 显示确认对话框
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.chatRecall ?? '撤回消息'),
        content: Text(
          '确定撤回 ${myMessages.length} 条消息？撤回后所有人将无法看到这些消息。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              S.of(context)?.chatRecall ?? 'Recall',
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!mounted) return;

    final chatBloc = context.read<ChatBloc>();
    for (final msg in myMessages) {
      chatBloc.add(RedactMessage(msg.id));
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context)?.chatRecalledMessages(myMessages.length) ??
                '已撤回 ${myMessages.length} 条消息',
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }

    _exitMultiSelectMode();
  }

  /// 批量转发选中的消息
  Future<void> _forwardSelectedMessages() async {
    if (_selectedMessageIds.isEmpty) return;
    
    // 获取选中的消息（过滤掉红包和转账消息，这些不能转发）
    final messages = context.read<ChatBloc>().state.messages;
    final selectedMessages = messages
        .where((m) => _selectedMessageIds.contains(m.id) &&
            m.type != MessageType.redPacket &&
            m.type != MessageType.transfer)
        .toList();

    if (selectedMessages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatRedPacketTransferCannotForward ?? 'Red envelopes and transfers cannot be forwarded'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    final isDark = context.isDarkMode;
    
    // 显示转发目标选择对话框
    final targetRoomId = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => MultiForwardSheet(
        selectedCount: selectedMessages.length,
        isDark: isDark,
      ),
    );
    
    if (targetRoomId == null || !mounted) return;
    
    // 执行批量转发
    int successCount = 0;
    int failCount = 0;
    
    for (final message in selectedMessages) {
      try {
        await _simpleForwardMessage(message, targetRoomId);
        successCount++;
      } catch (e) {
        debugPrint('Forward message failed: $e');
        failCount++;
      }
    }
    
    if (mounted) {
      String resultMsg;
      if (failCount == 0) {
        resultMsg = S.of(context)?.chatForwardedCount(successCount) ?? 'Forwarded $successCount messages';
      } else {
        resultMsg = S.of(context)?.chatForwardComplete(successCount, failCount) ?? 'Forward complete: $successCount succeeded, $failCount failed';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultMsg),
          duration: const Duration(seconds: 2),
          backgroundColor: failCount == 0 ? Colors.green : Colors.orange,
        ),
      );
    }

    _exitMultiSelectMode();
  }
  
  /// 引用消息
  void _quoteMessage(MessageEntity message) {
    context.read<ChatBloc>().add(SetReplyTarget(message));
  }

  /// 进入编辑模式
  void _enterEditMode(MessageEntity message) {
    // 仅文本消息可编辑
    if (message.type != MessageType.text || !message.isFromMe) return;
    context.read<ChatBloc>().add(SetEditTarget(message));
    _inputController.text = message.content;
    _inputController.selection = TextSelection.fromPosition(
      TextPosition(offset: message.content.length),
    );
    _inputFocusNode.requestFocus();
  }
  
  /// 提醒（@某人）
  void _remindMessage(MessageEntity message) {
    // 群聊中才能使用提醒功能
    if (widget.conversation.type != ConversationType.group) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.chatRemindOnlyInGroup ?? 'Remind feature is only available in group chat'),
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }
    
    // 显示群成员选择器
    _showMemberPicker(message);
  }
  
  /// 显示群成员选择器（@某人）
  Future<void> _showMemberPicker(MessageEntity message) async {
    final isDark = context.isDarkMode;
    
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => MemberPickerSheet(
        roomId: widget.conversation.id,
        isDark: isDark,
        onMemberSelected: (memberName, memberId) {
          Navigator.pop(ctx);
          _insertMention(memberName, memberId);
        },
      ),
    );
  }
  
  /// 插入@提及
  void _insertMention(String memberName, String memberId) {
    final currentText = _inputController.text;
    final cursorPos = _inputController.selection.baseOffset;
    
    // 微信风格：@用户名 后面有空格
    final mention = '@$memberName ';
    
    String newText;
    int newCursorPos;
    
    if (cursorPos >= 0) {
      newText = '${currentText.substring(0, cursorPos)}$mention${currentText.substring(cursorPos)}';
      newCursorPos = cursorPos + mention.length;
    } else {
      newText = '$currentText$mention';
      newCursorPos = newText.length;
    }
    
    _inputController.text = newText;
    _inputController.selection = TextSelection.fromPosition(
      TextPosition(offset: newCursorPos),
    );
    _inputFocusNode.requestFocus();
  }
  
  /// 搜一搜
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
  
  /// 重新编辑撤回的消息
  void _onReEditRecalledMessage() {
    if (_lastRecalledContent != null) {
      _inputController.text = _lastRecalledContent!;
      _inputFocusNode.requestFocus();
      // 移动光标到末尾
      _inputController.selection = TextSelection.fromPosition(
        TextPosition(offset: _inputController.text.length),
      );
      _lastRecalledContent = null;
    }
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
}

/// 删除确认底部弹窗（微信风格）
