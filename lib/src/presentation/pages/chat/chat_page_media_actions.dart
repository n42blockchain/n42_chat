// ignore_for_file: invalid_use_of_protected_member
part of 'chat_page.dart';

/// 媒体操作相关方法（图片、视频、文件、语音的选择与发送）
extension _ChatPageMediaActionsMethods on _ChatPageState {
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
}
