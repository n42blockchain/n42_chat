import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/services.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/entities/message_entity.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../blocs/chat/chat_state.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_state.dart';
import '../../blocs/search/search_bloc.dart';
import '../../widgets/chat/chat_widgets.dart';
import '../../widgets/chat/wechat_message_menu.dart';
import '../../widgets/common/common_widgets.dart';
import '../search/chat_search_bar.dart';
import 'message_item.dart';

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
  String? _highlightedMessageId;
  
  // 录音状态
  bool _isRecording = false;
  bool _isRecordingCancelled = false;
  Duration _recordingDuration = Duration.zero;
  
  // 消息 GlobalKey 映射，用于获取消息气泡位置
  final Map<String, GlobalKey> _messageKeys = {};
  
  // 撤回的消息ID，用于显示"重新编辑"
  final Set<String> _recalledMessageIds = {};
  String? _lastRecalledContent;
  
  // 多选模式
  bool _isMultiSelectMode = false;
  final Set<String> _selectedMessageIds = {};
  
  // 收藏的消息（本地存储）
  final Set<String> _favoritedMessageIds = {};

  @override
  void initState() {
    super.initState();

    // 初始化聊天室
    context.read<ChatBloc>().add(InitializeChat(widget.conversation.id));

    // 监听滚动
    _scrollController.addListener(_onScroll);

    // 监听输入框焦点，获取焦点时隐藏更多面板
    _inputFocusNode.addListener(_onInputFocusChanged);
  }

  void _onInputFocusChanged() {
    if (_inputFocusNode.hasFocus) {
      setState(() {
        _showMorePanel = false;
        _showEmojiPicker = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _inputController.dispose();
    _inputFocusNode.removeListener(_onInputFocusChanged);
    _inputFocusNode.dispose();

    // 清理聊天室
    context.read<ChatBloc>().add(const DisposeChat());

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
    context.read<ChatBloc>().add(SendTextMessage(text));
    _inputController.clear();
  }

  void _onInputChanged(String text) {
    // 发送正在输入状态
    context.read<ChatBloc>().add(SendTypingNotification(text.isNotEmpty));
  }

  void _onMessageTap(MessageEntity message) {
    // 处理消息点击（如查看图片、播放语音等）
    // TODO: 实现具体的消息点击处理
  }

  void _onAvatarTap(MessageEntity message) {
    // 点击头像查看用户资料
    // TODO: 跳转到用户资料页
  }

  void _onResend(MessageEntity message) {
    context.read<ChatBloc>().add(ResendMessage(message.id));
  }

  /// 打开聊天设置页面
  void _openChatSettings() {
    // TODO: 实现聊天设置页面
    // 可以是群设置或私聊设置
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('聊天设置功能开发中...'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
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

              // 消息列表
              Expanded(
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

              // 回复预览
              if (!_isMultiSelectMode) _buildReplyPreview(),

              // 多选模式下显示操作栏，否则显示输入栏
              if (_isMultiSelectMode)
                _buildMultiSelectBottomBar()
              else if (!_showSearchBar)
                _buildInputBar(),

              // 表情选择器
              if (_showEmojiPicker && !_isMultiSelectMode) _buildEmojiPicker(),
              
              // 更多功能面板（仅在非多选模式下）
              if (_showMorePanel && !_isMultiSelectMode) _buildMorePanel(),
            ],
          ),
        ),
        
        // 全屏录音浮层
        if (_isRecording) _buildRecordingOverlay(),
      ],
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
          _onRecordingStateChanged(false, true, _recordingDuration);
        },
        child: Container(
          color: Colors.black.withOpacity(0.7),
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
                            .withOpacity(0.4),
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
                        ? AppColors.error.withOpacity(0.2) 
                        : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _isRecordingCancelled ? '松开手指，取消发送' : '手指上滑，取消发送',
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
                    _onRecordingStateChanged(false, true, _recordingDuration);
                  },
                  icon: const Icon(Icons.close, color: Colors.white70),
                  label: const Text(
                    '点击取消',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
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
    );
  }

  void _hideMorePanel() {
    setState(() {
      _showMorePanel = false;
      _showEmojiPicker = false;
    });
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final images = await picker.pickMultiImage(
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      
      if (images.isEmpty) return;
      
      // 发送选中的图片
      for (final image in images) {
        await _sendImage(image);
      }
    } catch (e) {
      debugPrint('Pick image error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('选择图片失败: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
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
              title: const Text('拍照'),
              onTap: () => Navigator.pop(context, 'photo'),
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('录像'),
              onTap: () => Navigator.pop(context, 'video'),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('取消'),
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
        await _sendImage(image);
      } else if (choice == 'video') {
        final video = await picker.pickVideo(
          source: ImageSource.camera,
          maxDuration: const Duration(minutes: 5),
        );
        
        if (video == null) return;
        await _sendVideo(video);
      }
    } catch (e) {
      debugPrint('Take photo/video error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('拍摄失败: $e'),
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
              const SnackBar(
                content: Text('视频文件不存在'),
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
            const SnackBar(
              content: Text('视频数据为空'),
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
      String mimeType = lookupMimeType(filename) ?? 
                        lookupMimeType(video.path) ?? 
                        'video/mp4';
      
      // 检查文件大小（限制 100MB）
      const maxSize = 100 * 1024 * 1024; // 100MB
      if (bytes.length > maxSize) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('视频大小不能超过 100MB'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }
      
      debugPrint('Final filename: $filename');
      debugPrint('Final mimeType: $mimeType');
      debugPrint('Video size: ${bytes.length} bytes');
      debugPrint('=== Sending video to ChatBloc ===');
      
      // 使用文件消息发送视频
      context.read<ChatBloc>().add(SendFileMessage(
        fileBytes: bytes,
        filename: filename,
        mimeType: mimeType,
      ));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('视频发送中...'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Send video error: $e');
      debugPrint('Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('发送视频失败: $e'),
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
              const SnackBar(
                content: Text('图片文件不存在'),
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
            const SnackBar(
              content: Text('图片数据为空'),
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
      
      debugPrint('Final filename: $filename');
      debugPrint('Final mimeType: $mimeType');
      debugPrint('Image size: ${bytes.length} bytes');
      debugPrint('=== Sending image to ChatBloc ===');
      
      context.read<ChatBloc>().add(SendImageMessage(
        imageBytes: bytes,
        filename: filename,
        mimeType: mimeType,
      ));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('图片发送中...'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Send image error: $e');
      debugPrint('Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('发送图片失败: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _sendLocation() async {
    try {
      // 检查位置服务是否启用
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          final shouldOpen = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('位置服务未开启'),
              content: const Text('请开启位置服务以发送位置'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('取消'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('去设置'),
                ),
              ],
            ),
          );
          if (shouldOpen == true) {
            await Geolocator.openLocationSettings();
          }
        }
        return;
      }
      
      // 检查权限
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('需要位置权限才能发送位置'),
                backgroundColor: AppColors.error,
              ),
            );
          }
          return;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('位置权限已被永久拒绝，请在设置中开启'),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }
      
      // 显示加载提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 16),
                Text('正在获取位置...'),
              ],
            ),
            duration: Duration(seconds: 10),
          ),
        );
      }
      
      // 获取当前位置
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      
      // 隐藏加载提示
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
      
      debugPrint('Location: ${position.latitude}, ${position.longitude}');
      
      // 发送位置消息
      context.read<ChatBloc>().add(SendLocationMessage(
        latitude: position.latitude,
        longitude: position.longitude,
        description: '我的位置',
      ));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('位置发送成功'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      debugPrint('Send location error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('获取位置失败: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _sendRedPacket() {
    // TODO: 实现发红包功能
    debugPrint('Send red packet');
    _showFeatureToast('红包');
  }

  void _sendTransfer() {
    // TODO: 实现转账功能
    debugPrint('Send transfer');
    _showFeatureToast('转账');
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
            content: Text('选择文件失败: $e'),
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
            const SnackBar(
              content: Text('文件大小不能超过 50MB'),
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
            content: Text('文件发送中: $filename'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      debugPrint('Send file error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('发送文件失败: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _sendContactCard() {
    // TODO: 实现发送名片功能
    debugPrint('Send contact card');
    _showFeatureToast('名片功能');
  }

  Future<void> _startVideoCall() async {
    // 显示选择菜单：语音通话或视频通话
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone, color: AppColors.primary),
              title: const Text('语音通话'),
              onTap: () => Navigator.pop(context, 'voice'),
            ),
            ListTile(
              leading: const Icon(Icons.videocam, color: AppColors.primary),
              title: const Text('视频通话'),
              onTap: () => Navigator.pop(context, 'video'),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('取消'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
    
    if (choice == null) return;
    
    final isVideoCall = choice == 'video';
    final callType = isVideoCall ? '视频通话' : '语音通话';
    
    // 显示通话界面
    if (mounted) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _CallDialog(
          contactName: widget.conversation.name,
          contactAvatar: widget.conversation.avatarUrl,
          isVideoCall: isVideoCall,
          roomId: widget.conversation.id, // 传递房间ID用于VoIP
          onEnd: () => Navigator.pop(context),
        ),
      );
    }
    
    debugPrint('$callType ended');
  }

  void _openFavorites() {
    // TODO: 实现收藏功能
    debugPrint('Open favorites');
    _showFeatureToast('收藏');
  }

  void _shareMusic() {
    // TODO: 实现分享音乐功能
    debugPrint('Share music');
    _showFeatureToast('音乐分享');
  }

  void _selectCoupon() {
    // TODO: 实现选择卡券功能
    debugPrint('Select coupon');
    _showFeatureToast('卡券');
  }

  void _sendGift() {
    // TODO: 实现发送礼物功能
    debugPrint('Send gift');
    _showFeatureToast('礼物');
  }

  void _showFeatureToast(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature功能开发中...'),
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
              '${widget.conversation.memberCount}人',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
      onBackPressed: widget.onBack ?? () => Navigator.of(context).pop(),
      actions: [
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
            ? '选择消息'
            : '已选择 ${_selectedMessageIds.length} 条',
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
            '全选',
            style: TextStyle(
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
        return '群聊(${widget.conversation.memberCount})';
      }
      return name;
    }

    // 私聊尝试获取备注名
    try {
      final contactBloc = context.read<ContactBloc>();
      final state = contactBloc.state;
      if (state is ContactLoaded) {
        // 查找对应的联系人（通过房间ID或用户ID）
        final contact = state.contacts.cast<ContactEntity?>().firstWhere(
          (c) => c?.directRoomId == widget.conversation.id,
          orElse: () => null,
        );
        if (contact != null) {
          // 优先使用备注名
          if (contact.remark != null && contact.remark!.isNotEmpty) {
            return contact.remark!;
          }
          // 其次使用显示名
          if (contact.displayName.isNotEmpty) {
            return contact.displayName;
          }
        }
      }
    } catch (e) {
      // ContactBloc 可能不可用，使用默认名称
    }

    // 如果名称为空或为默认值，返回简化的用户ID或默认文本
    final name = widget.conversation.name;
    if (name.isEmpty || name == 'Empty Chat' || name == 'empty chat') {
      return '私聊';
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
    setState(() {
      _highlightedMessageId = eventId;
    });

    // 滚动到指定消息
    final chatBloc = context.read<ChatBloc>();
    final state = chatBloc.state;
    final index = state.messages.indexWhere((m) => m.id == eventId);

    if (index != -1) {
      // 使用 jumpTo 滚动到消息位置
      _scrollController.animateTo(
        index * 80.0, // 估算每条消息高度
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
          return const N42Loading(message: '加载中...');
        }

        if (state.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEncryptionNotice(),
              const SizedBox(height: 16),
              N42EmptyState.noData(
                title: '暂无消息',
                description: '发送第一条消息开始聊天',
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
            
            // 端对端加密提示（在所有消息之上）
            if (index == state.messages.length) {
              return _buildEncryptionNotice();
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

            // 检查消息是否被撤回
            if (_recalledMessageIds.contains(message.id)) {
              return Column(
                children: [
                  if (showTimeSeparator)
                    TimeSeparator(dateTime: message.timestamp),
                  RecalledMessageWidget(
                    isFromMe: message.isFromMe,
                    onReEdit: message.isFromMe && _lastRecalledContent != null
                        ? () => _onReEditRecalledMessage()
                        : null,
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
                          onResend: () => _onResend(message),
                          isGroupChat: isGroupChat,
                          showSenderName: showSenderName,
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
    final isSelected = _selectedMessageIds.contains(message.id);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () => _toggleMessageSelection(message.id),
      child: Container(
        key: messageKey,
        color: isSelected
            ? (isDark ? Colors.white.withOpacity(0.1) : Colors.blue.withOpacity(0.1))
            : Colors.transparent,
        child: Row(
          children: [
            // 复选框
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  border: Border.all(
                    color: isSelected 
                        ? AppColors.primary 
                        : (isDark ? Colors.white54 : Colors.black38),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      )
                    : null,
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
            Icon(
              Icons.lock_outline,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                '本聊天已开启端对端加密保护，只有您和对方可以读取消息内容',
                textAlign: TextAlign.center,
                style: TextStyle(
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
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (prev, curr) => prev.replyTarget != curr.replyTarget,
      builder: (context, state) {
        if (state.replyTarget == null) {
          return const SizedBox.shrink();
        }

        final isDark = Theme.of(context).brightness == Brightness.dark;

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
                      '回复 ${state.replyTarget!.senderName}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      state.replyTarget!.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
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
  
  /// 构建多选模式底部工具栏
  Widget _buildMultiSelectBottomBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasSelection = _selectedMessageIds.isNotEmpty;
    
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
            color: Colors.black.withOpacity(0.05),
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
            label: '转发',
            enabled: hasSelection,
            onTap: hasSelection ? _forwardSelectedMessages : null,
          ),
          _buildMultiSelectAction(
            icon: Icons.star_border,
            label: '收藏',
            enabled: hasSelection,
            onTap: hasSelection ? _favoriteSelectedMessages : null,
          ),
          _buildMultiSelectAction(
            icon: Icons.delete_outline,
            label: '删除',
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
        content: Text('已收藏 ${_selectedMessageIds.length} 条消息'),
        duration: const Duration(seconds: 1),
      ),
    );
    
    _exitMultiSelectMode();
  }

  Widget _buildInputBar() {
    return ChatInputBar(
      controller: _inputController,
      focusNode: _inputFocusNode,
      onSendText: _sendMessage,
      onSendVoice: _sendVoiceMessage,
      onRecordingStateChanged: _onRecordingStateChanged,
      onChanged: _onInputChanged,
      onVoicePressed: _onVoicePressed,
      onEmojiPressed: _onEmojiPressed,
      onMorePressed: _onMorePressed,
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
            const SnackBar(
              content: Text('语音文件不存在'),
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
            const SnackBar(
              content: Text('语音文件为空'),
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
          const SnackBar(
            content: Text('语音发送中...'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Send voice message error: $e');
      debugPrint('Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('发送语音失败: $e'),
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _MessageMenuSheet(
        message: message,
        onCopy: () {
          Navigator.pop(ctx);
          _copyMessage(message);
        },
        onReply: () {
          Navigator.pop(ctx);
          context.read<ChatBloc>().add(SetReplyTarget(message));
        },
        onForward: () {
          Navigator.pop(ctx);
          // TODO: 转发消息
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
    
    overlayEntry = OverlayEntry(
      builder: (ctx) => WeChatMessageMenu(
        message: message,
        position: position,
        messageSize: size,
        isFavorited: _favoritedMessageIds.contains(message.id),
        onDismiss: () => overlayEntry.remove(),
        onCopy: () => _copyMessage(message),
        onForward: () => _forwardMessage(message),
        onFavorite: () => _favoriteMessage(message),
        onRecall: () => _recallMessage(message),
        onMultiSelect: () => _enterMultiSelectMode(),
        onQuote: () => _quoteMessage(message),
        onRemind: () => _remindMessage(message),
        onSearch: () => _searchMessage(message),
      ),
    );
    
    overlay.insert(overlayEntry);
  }
  
  /// 复制消息
  void _copyMessage(MessageEntity message) {
    String? textToCopy;
    
    switch (message.type) {
      case MessageType.text:
        textToCopy = message.content;
        break;
      case MessageType.location:
        textToCopy = message.content; // 位置描述
        break;
      default:
        // 对于其他类型的消息，复制消息类型描述
        textToCopy = _getMessageTypeDescription(message.type);
    }
    
    if (textToCopy != null && textToCopy.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: textToCopy));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('已复制'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
  
  String _getMessageTypeDescription(MessageType type) {
    switch (type) {
      case MessageType.image:
        return '[图片]';
      case MessageType.audio:
        return '[语音]';
      case MessageType.video:
        return '[视频]';
      case MessageType.file:
        return '[文件]';
      case MessageType.location:
        return '[位置]';
      case MessageType.transfer:
        return '[转账]';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _ForwardMessageSheet(
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
  void _doForwardMessage(MessageEntity message, String targetRoomId) {
    // 根据消息类型转发
    switch (message.type) {
      case MessageType.text:
        // 发送文本到目标房间
        // 注意：这里需要创建一个新的 ChatBloc 或直接调用 repository
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('消息已转发'), duration: Duration(seconds: 1)),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('消息已转发'), duration: Duration(seconds: 1)),
        );
    }
  }
  
  /// 收藏消息
  void _favoriteMessage(MessageEntity message) {
    setState(() {
      if (_favoritedMessageIds.contains(message.id)) {
        _favoritedMessageIds.remove(message.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('已取消收藏'),
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        _favoritedMessageIds.add(message.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('已收藏'),
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
    
    // TODO: 持久化到本地存储或服务器
  }
  
  /// 撤回消息
  Future<void> _recallMessage(MessageEntity message) async {
    if (!message.isFromMe) return;
    
    // 检查是否在 2 分钟内（微信撤回时间限制）
    final now = DateTime.now();
    final diff = now.difference(message.timestamp);
    if (diff.inMinutes > 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('消息发送超过2分钟，无法撤回'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    // 显示撤回确认对话框
    final confirmed = await showRecallConfirmDialog(context);
    if (!confirmed) return;
    
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
    
    // 获取选中的消息
    final messages = context.read<ChatBloc>().state.messages;
    final selectedMessages = messages.where((m) => _selectedMessageIds.contains(m.id)).toList();
    
    // 检查是否所有消息都是自己发送的
    final myMessages = selectedMessages.where((m) => m.isFromMe).toList();
    final otherMessages = selectedMessages.where((m) => !m.isFromMe).toList();
    
    // 显示确认对话框
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除消息'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('确定要删除 ${selectedMessages.length} 条消息吗？'),
            if (otherMessages.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '注意：${otherMessages.length} 条消息是他人发送的，只能在本地删除。',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
            if (myMessages.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '${myMessages.length} 条自己发送的消息将被撤回。',
                style: TextStyle(
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
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              '删除',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    
    if (confirmed != true) return;
    
    int deletedCount = 0;
    int failedCount = 0;
    
    // 撤回自己的消息
    for (final msg in myMessages) {
      try {
        context.read<ChatBloc>().add(RedactMessage(msg.id));
        deletedCount++;
      } catch (e) {
        failedCount++;
      }
    }
    
    // 对于他人消息，目前 Matrix 不支持删除他人消息（除非是房间管理员）
    // 所以只显示提示
    if (otherMessages.isNotEmpty) {
      deletedCount += otherMessages.length;
      // 在实际实现中，可以添加本地消息隐藏逻辑
    }
    
    if (mounted) {
      String message;
      if (failedCount > 0) {
        message = '已删除 $deletedCount 条消息，$failedCount 条删除失败';
      } else {
        message = '已删除 $deletedCount 条消息';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    
    _exitMultiSelectMode();
  }
  
  /// 批量转发选中的消息
  void _forwardSelectedMessages() {
    if (_selectedMessageIds.isEmpty) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已选择 ${_selectedMessageIds.length} 条消息'),
        duration: const Duration(seconds: 1),
      ),
    );
    
    // TODO: 显示转发目标选择
    _exitMultiSelectMode();
  }
  
  /// 引用消息
  void _quoteMessage(MessageEntity message) {
    context.read<ChatBloc>().add(SetReplyTarget(message));
  }
  
  /// 提醒（@某人）
  void _remindMessage(MessageEntity message) {
    // 群聊中才能使用提醒功能
    if (widget.conversation.type != ConversationType.group) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('提醒功能仅在群聊中可用'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    
    // 在输入框中添加 @
    final currentText = _inputController.text;
    final cursorPos = _inputController.selection.baseOffset;
    
    String newText;
    int newCursorPos;
    
    if (cursorPos >= 0) {
      newText = '${currentText.substring(0, cursorPos)}@${currentText.substring(cursorPos)}';
      newCursorPos = cursorPos + 1;
    } else {
      newText = '$currentText@';
      newCursorPos = newText.length;
    }
    
    _inputController.text = newText;
    _inputController.selection = TextSelection.fromPosition(
      TextPosition(offset: newCursorPos),
    );
    _inputFocusNode.requestFocus();
    
    // TODO: 显示群成员选择器
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('请输入要@的人的名字'),
        duration: Duration(seconds: 1),
      ),
    );
  }
  
  /// 搜一搜
  void _searchMessage(MessageEntity message) {
    if (message.type != MessageType.text || message.content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('仅支持搜索文本消息'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    
    // 使用浏览器搜索
    _showSearchOptionsDialog(message.content);
  }
  
  /// 显示搜索选项对话框
  Future<void> _showSearchOptionsDialog(String searchText) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    await showModalBottomSheet(
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
                  '搜索 "$searchText"',
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
                title: '百度搜索',
                onTap: () {
                  Navigator.pop(ctx);
                  _openSearch('https://www.baidu.com/s?wd=${Uri.encodeComponent(searchText)}');
                },
                isDark: isDark,
              ),
              _buildSearchOption(
                context,
                icon: Icons.g_mobiledata,
                title: 'Google 搜索',
                onTap: () {
                  Navigator.pop(ctx);
                  _openSearch('https://www.google.com/search?q=${Uri.encodeComponent(searchText)}');
                },
                isDark: isDark,
              ),
              _buildSearchOption(
                context,
                icon: Icons.article,
                title: '必应搜索',
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
          const SnackBar(content: Text('无法打开浏览器')),
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
    // TODO: 实现语音录制
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

/// 消息操作菜单
class _MessageMenuSheet extends StatelessWidget {
  final MessageEntity message;
  final VoidCallback? onCopy;
  final VoidCallback? onReply;
  final VoidCallback? onForward;
  final VoidCallback? onDelete;

  const _MessageMenuSheet({
    required this.message,
    this.onCopy,
    this.onReply,
    this.onForward,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
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
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (message.type == MessageType.text)
              _buildMenuItem(
                context,
                icon: Icons.copy,
                title: '复制',
                onTap: onCopy,
              ),
            _buildMenuItem(
              context,
              icon: Icons.reply,
              title: '回复',
              onTap: onReply,
            ),
            _buildMenuItem(
              context,
              icon: Icons.forward,
              title: '转发',
              onTap: onForward,
            ),
            if (onDelete != null)
              _buildMenuItem(
                context,
                icon: Icons.delete_outline,
                title: '撤回',
                color: AppColors.error,
                onTap: onDelete,
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Color? color,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = color ??
        (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary);

    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textSecondary),
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: onTap,
    );
  }
}

/// 通话对话框
/// 
/// 当前为模拟实现，真正的 VoIP 通话需要集成 WebRTC
/// 
/// 实现步骤:
/// 1. 添加 flutter_webrtc 依赖
/// 2. 配置 STUN/TURN 服务器
/// 3. 实现 ICE 候选人交换
/// 4. 管理本地和远程媒体流
/// 
/// 参考 FluffyChat 的 VoIP 实现
class _CallDialog extends StatefulWidget {
  final String contactName;
  final String? contactAvatar;
  final bool isVideoCall;
  final VoidCallback onEnd;
  final String? roomId; // 可选的房间ID，用于真正的VoIP

  const _CallDialog({
    required this.contactName,
    this.contactAvatar,
    required this.isVideoCall,
    required this.onEnd,
    this.roomId,
  });

  @override
  State<_CallDialog> createState() => _CallDialogState();
}

class _CallDialogState extends State<_CallDialog> {
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  bool _isCameraOff = false;
  int _callDuration = 0;
  bool _isConnecting = true;
  String _callStatus = '呼叫中...';
  
  @override
  void initState() {
    super.initState();
    _initCall();
  }
  
  Future<void> _initCall() async {
    // 模拟连接过程
    // TODO: 替换为真正的 VoIP 连接
    // 使用 VoIPService.startCall(widget.roomId, widget.isVideoCall ? CallType.video : CallType.voice)
    
    debugPrint('_CallDialog: Initiating ${widget.isVideoCall ? "video" : "voice"} call');
    debugPrint('_CallDialog: Contact: ${widget.contactName}');
    debugPrint('_CallDialog: Room ID: ${widget.roomId ?? "N/A"}');
    
    // 模拟呼叫状态变化
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _callStatus = '正在连接...');
    }
    
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _callStatus = '响铃中...');
    }
    
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _isConnecting = false;
        _callStatus = '通话中';
      });
      // 开始计时
      _startTimer();
    }
  }
  
  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted && !_isConnecting) {
        setState(() {
          _callDuration++;
        });
        return true;
      }
      return false;
    });
  }
  
  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
  
  void _toggleMute() {
    setState(() => _isMuted = !_isMuted);
    debugPrint('_CallDialog: Mute ${_isMuted ? "on" : "off"}');
    // TODO: voipService.toggleMute()
  }
  
  void _toggleSpeaker() {
    setState(() => _isSpeakerOn = !_isSpeakerOn);
    debugPrint('_CallDialog: Speaker ${_isSpeakerOn ? "on" : "off"}');
    // TODO: voipService.toggleSpeaker()
  }
  
  void _toggleCamera() {
    setState(() => _isCameraOff = !_isCameraOff);
    debugPrint('_CallDialog: Camera ${_isCameraOff ? "off" : "on"}');
    // TODO: voipService.toggleCamera()
  }
  
  void _endCall() {
    debugPrint('_CallDialog: Ending call, duration: $_callDuration seconds');
    // TODO: voipService.hangup()
    widget.onEnd();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black87,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            
            // 联系人头像
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.3),
                border: Border.all(color: AppColors.primary, width: 3),
              ),
              child: widget.contactAvatar != null
                  ? ClipOval(
                      child: Image.network(
                        widget.contactAvatar!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildAvatarPlaceholder(),
                      ),
                    )
                  : _buildAvatarPlaceholder(),
            ),
            
            const SizedBox(height: 24),
            
            // 联系人名字
            Text(
              widget.contactName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // 通话状态
            Text(
              _isConnecting 
                  ? _callStatus
                  : _formatDuration(_callDuration),
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
            
            const Spacer(),
            
            // 控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 静音
                _buildControlButton(
                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                  label: _isMuted ? '取消静音' : '静音',
                  isActive: _isMuted,
                  onTap: _toggleMute,
                ),
                
                // 免提
                _buildControlButton(
                  icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                  label: _isSpeakerOn ? '关闭免提' : '免提',
                  isActive: _isSpeakerOn,
                  onTap: _toggleSpeaker,
                ),
                
                // 摄像头（仅视频通话）
                if (widget.isVideoCall)
                  _buildControlButton(
                    icon: _isCameraOff ? Icons.videocam_off : Icons.videocam,
                    label: _isCameraOff ? '开启摄像头' : '关闭摄像头',
                    isActive: _isCameraOff,
                    onTap: _toggleCamera,
                  ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // 挂断按钮
            GestureDetector(
              onTap: _endCall,
              child: Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            const Text(
              '挂断',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAvatarPlaceholder() {
    return Center(
      child: Text(
        widget.contactName.isNotEmpty ? widget.contactName[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.black : Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

/// 转发消息对话框
class _ForwardMessageSheet extends StatefulWidget {
  final MessageEntity message;
  final bool isDark;
  final Function(String conversationId) onForwardToChat;

  const _ForwardMessageSheet({
    required this.message,
    required this.isDark,
    required this.onForwardToChat,
  });

  @override
  State<_ForwardMessageSheet> createState() => _ForwardMessageSheetState();
}

class _ForwardMessageSheetState extends State<_ForwardMessageSheet> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // 拖动条
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // 标题
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '选择转发对象',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.isDark ? Colors.white : Colors.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          
          // 搜索框
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: widget.isDark 
                    ? const Color(0xFF2C2C2E) 
                    : const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          
          // 消息预览
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.isDark 
                  ? const Color(0xFF2C2C2E) 
                  : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  _getMessageIcon(widget.message.type),
                  size: 20,
                  color: widget.isDark ? Colors.white70 : Colors.black54,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getMessagePreview(widget.message),
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.isDark ? Colors.white70 : Colors.black54,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(),
          
          // 最近会话列表
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                // 获取最近会话列表
                // 这里需要从 ContactBloc 或其他地方获取会话列表
                // 暂时显示空状态
                return _buildRecentChats();
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRecentChats() {
    // TODO: 从 ContactBloc 获取真实的会话列表
    final recentChats = <_ChatItem>[
      _ChatItem(id: '1', name: '文件传输助手', avatar: null, isGroup: false),
      _ChatItem(id: '2', name: '工作群', avatar: null, isGroup: true),
      _ChatItem(id: '3', name: '家人群', avatar: null, isGroup: true),
    ];
    
    final filteredChats = _searchQuery.isEmpty
        ? recentChats
        : recentChats.where((chat) => 
            chat.name.toLowerCase().contains(_searchQuery)).toList();
    
    if (filteredChats.isEmpty) {
      return Center(
        child: Text(
          '没有找到相关会话',
          style: TextStyle(
            color: widget.isDark ? Colors.white54 : Colors.black54,
          ),
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: filteredChats.length,
      itemBuilder: (context, index) {
        final chat = filteredChats[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: widget.isDark 
                ? const Color(0xFF3A3A3C) 
                : const Color(0xFFE5E5EA),
            child: Icon(
              chat.isGroup ? Icons.group : Icons.person,
              color: widget.isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          title: Text(
            chat.name,
            style: TextStyle(
              color: widget.isDark ? Colors.white : Colors.black,
            ),
          ),
          onTap: () => widget.onForwardToChat(chat.id),
        );
      },
    );
  }
  
  IconData _getMessageIcon(MessageType type) {
    switch (type) {
      case MessageType.text:
        return Icons.chat_bubble_outline;
      case MessageType.image:
        return Icons.image;
      case MessageType.audio:
        return Icons.mic;
      case MessageType.video:
        return Icons.videocam;
      case MessageType.file:
        return Icons.insert_drive_file;
      case MessageType.location:
        return Icons.location_on;
      default:
        return Icons.chat_bubble_outline;
    }
  }
  
  String _getMessagePreview(MessageEntity message) {
    switch (message.type) {
      case MessageType.text:
        return message.content;
      case MessageType.image:
        return '[图片]';
      case MessageType.audio:
        return '[语音]';
      case MessageType.video:
        return '[视频]';
      case MessageType.file:
        return '[文件] ${message.metadata?.fileName ?? ''}';
      case MessageType.location:
        return '[位置] ${message.content}';
      default:
        return '[消息]';
    }
  }
}

class _ChatItem {
  final String id;
  final String name;
  final String? avatar;
  final bool isGroup;
  
  _ChatItem({
    required this.id,
    required this.name,
    this.avatar,
    required this.isGroup,
  });
}

