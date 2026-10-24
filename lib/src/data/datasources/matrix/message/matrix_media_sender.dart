import '../../../../core/services/media_telemetry.dart';
import '../../../../core/services/attachment_size_policy.dart';
import '../../../../core/services/streaming_attachment_encryptor.dart';
import 'direct_chat_send_guard.dart';
import 'encrypted_send_guard.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:matrix/matrix.dart' as matrix;

import '../matrix_client_manager.dart';
import 'matrix_media_uploader.dart';
import '../../../../core/utils/debug_log.dart';
import '../../../../core/constants/app_constants.dart';

/// Matrix 媒体消息发送器
///
/// 封装图片、语音、视频、文件等媒体消息的发送逻辑
class MatrixMediaSender {
  final MatrixClientManager _clientManager;
  final MatrixMediaUploader _uploader;

  final int maxAttachmentBytes;
  MatrixMediaSender(
    this._clientManager,
    this._uploader, {
    this.maxAttachmentBytes = AttachmentSizePolicy.conservativeLimit,
  });

  matrix.Client? get _client => _clientManager.client;

  /// 发送图片消息
  ///
  /// 简化的实现：直接使用 SDK 的 uploadContent + sendEvent
  Future<String?> sendImageMessage(
    String roomId, {
    required Uint8List imageBytes,
    required String filename,
    String? mimeType,
    int? selfDestructAfter,
  }) => MediaTelemetry.trace(
    MediaStage.send,
    () => _sendImageMessage(
      roomId,
      imageBytes: imageBytes,
      filename: filename,
      mimeType: mimeType,
      selfDestructAfter: selfDestructAfter,
    ),
    bytes: imageBytes.length,
  );

  Future<String?> _sendImageMessage(
    String roomId, {
    required Uint8List imageBytes,
    required String filename,
    String? mimeType,
    int? selfDestructAfter,
  }) async {
    debugLog('=== sendImageMessage start ===');
    debugLog(
      'roomId: $roomId, filename: $filename, size: ${imageBytes.length}',
    );

    try {
      if (_client == null || !_client!.isLogged()) {
        throw Exception('未登录或客户端未初始化');
      }

      final room = await prepareRoomForSending(_client, roomId);
      if (room == null) {
        throw Exception('房间不存在: $roomId');
      }

      // 确定 MIME 类型
      String actualMimeType = mimeType ?? 'image/jpeg';
      final lowerFilename = filename.toLowerCase();
      if (lowerFilename.endsWith('.png')) {
        actualMimeType = 'image/png';
      } else if (lowerFilename.endsWith('.gif')) {
        actualMimeType = 'image/gif';
      } else if (lowerFilename.endsWith('.webp')) {
        actualMimeType = 'image/webp';
      } else if (lowerFilename.endsWith('.heic')) {
        actualMimeType = 'image/heic';
      } else if (lowerFilename.endsWith('.heif')) {
        actualMimeType = 'image/heif';
      }

      if (room.encrypted) {
        if (!_client!.fileEncryptionEnabled) {
          throw StateError('Attachment encryption is unavailable');
        }
        return await room.sendFileEvent(
          matrix.MatrixImageFile(
            bytes: imageBytes,
            name: filename,
            mimeType: actualMimeType,
          ),
          extraContent: {
            if (selfDestructAfter != null && selfDestructAfter > 0)
              'n42.self_destruct': {'after': selfDestructAfter},
          },
        );
      }

      debugLog('MIME type: $actualMimeType');

      // 直接使用 SDK 的 uploadContent 方法（最可靠）
      debugLog('Uploading with SDK uploadContent...');
      Uri? mxcUri;

      try {
        mxcUri = await MediaTelemetry.trace(
          MediaStage.upload,
          () => _client!.uploadContent(
            imageBytes,
            filename: filename,
            contentType: actualMimeType,
          ),
          bytes: imageBytes.length,
        );
        debugLog('SDK upload successful: $mxcUri');
      } catch (sdkUploadError) {
        debugLog('SDK uploadContent failed: $sdkUploadError');
        // 尝试手动上传
        debugLog('Trying manual upload...');
        mxcUri = await _uploader.uploadContentAuthenticated(
          imageBytes,
          filename: filename,
          contentType: actualMimeType,
        );
      }

      if (mxcUri == null) {
        throw Exception('上传图片失败');
      }

      debugLog('Upload successful: $mxcUri');

      // 发送消息事件
      final content = <String, dynamic>{
        'msgtype': 'm.image',
        'body': filename,
        'url': mxcUri.toString(),
        'info': {'mimetype': actualMimeType, 'size': imageBytes.length},
      };

      // View Once / 阅后即焚支持
      if (selfDestructAfter != null && selfDestructAfter > 0) {
        content['n42.self_destruct'] = {'after': selfDestructAfter};
      }

      final result = await room.sendEvent(content);
      debugLog('sendEvent result: $result');
      debugLog('=== sendImageMessage completed ===');
      return result;
    } catch (e, stackTrace) {
      debugLog('=== sendImageMessage ERROR: $e ===');
      debugLog('Stack: $stackTrace');
      rethrow;
    }
  }

  /// 发送语音消息
  ///
  /// 使用 Matrix SDK 内置方法或手动上传
  Future<String?> sendVoiceMessage(
    String roomId, {
    required Uint8List audioBytes,
    required String filename,
    required int duration,
    String? mimeType,
    int? selfDestructAfter,
  }) => MediaTelemetry.trace(
    MediaStage.send,
    () => _sendVoiceMessage(
      roomId,
      audioBytes: audioBytes,
      filename: filename,
      duration: duration,
      mimeType: mimeType,
      selfDestructAfter: selfDestructAfter,
    ),
    bytes: audioBytes.length,
  );

  Future<String?> _sendVoiceMessage(
    String roomId, {
    required Uint8List audioBytes,
    required String filename,
    required int duration,
    String? mimeType,
    int? selfDestructAfter,
  }) async {
    debugLog('=== MatrixMessageDataSource.sendVoiceMessage start ===');
    debugLog('roomId: $roomId');
    debugLog('filename: $filename');
    debugLog('duration: $duration ms');
    debugLog('audioBytes.length: ${audioBytes.length}');

    try {
      if (_client == null) {
        throw Exception('Matrix 客户端未初始化');
      }

      if (!_client!.isLogged()) {
        throw Exception('未登录');
      }

      final room = await prepareRoomForSending(_client, roomId);
      if (room == null) {
        throw Exception('房间不存在: $roomId');
      }

      // 确定正确的 MIME 类型
      String actualMimeType = mimeType ?? 'audio/mp4';
      final lowerFilename = filename.toLowerCase();
      if (lowerFilename.endsWith('.m4a')) {
        actualMimeType = 'audio/mp4';
      } else if (lowerFilename.endsWith('.ogg') ||
          lowerFilename.endsWith('.opus')) {
        actualMimeType = 'audio/ogg';
      } else if (lowerFilename.endsWith('.mp3')) {
        actualMimeType = 'audio/mpeg';
      } else if (lowerFilename.endsWith('.wav')) {
        actualMimeType = 'audio/wav';
      } else if (lowerFilename.endsWith('.aac')) {
        actualMimeType = 'audio/aac';
      } else if (lowerFilename.endsWith('.webm')) {
        actualMimeType = 'audio/webm';
      }

      debugLog('Final mimeType: $actualMimeType');

      // 方法1: 使用 SDK 内置的 sendFileEvent
      debugLog('Trying SDK sendFileEvent for audio...');
      try {
        final matrixFile = matrix.MatrixAudioFile(
          bytes: audioBytes,
          name: filename,
          mimeType: actualMimeType,
          duration: duration,
        );

        final result = await room.sendFileEvent(
          matrixFile,
          extraContent: {
            // MSC3245 语音消息标记
            'org.matrix.msc3245.voice': <String, dynamic>{},
            // MSC1767 音频消息扩展
            'org.matrix.msc1767.audio': {'duration': duration},
            if (selfDestructAfter != null)
              'n42.self_destruct': {'seconds': selfDestructAfter},
          },
        );

        debugLog('sendFileEvent result: $result');
        debugLog(
          '=== sendVoiceMessage completed successfully (SDK method) ===',
        );
        return result;
      } catch (sdkError, sdkStack) {
        if (room.encrypted) rethrow;
        debugLog('SDK sendFileEvent for audio failed: $sdkError');
        debugLog('Stack: $sdkStack');
        debugLog('Falling back to manual upload...');
      }

      // 方法2: 手动上传
      final mxcUri = await _uploader.uploadContentAuthenticated(
        audioBytes,
        filename: filename,
        contentType: actualMimeType,
      );

      if (mxcUri == null) {
        throw Exception('上传语音失败：无法获取 MXC URI');
      }

      final content = <String, dynamic>{
        'msgtype': 'm.audio',
        'body': filename,
        'url': mxcUri.toString(),
        'info': {
          'mimetype': actualMimeType,
          'size': audioBytes.length,
          'duration': duration,
        },
        'org.matrix.msc3245.voice': <String, dynamic>{},
        'org.matrix.msc1767.audio': {'duration': duration},
        if (selfDestructAfter != null)
          'n42.self_destruct': {'seconds': selfDestructAfter},
      };

      final result = await room.sendEvent(content);
      debugLog(
        '=== sendVoiceMessage completed successfully (manual method) ===',
      );
      return result;
    } catch (e, stackTrace) {
      debugLog('=== sendVoiceMessage ERROR ===');
      debugLog('Error: $e');
      debugLog('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// 发送视频消息
  ///
  /// 使用 Matrix SDK 内置方法或手动上传
  Future<String?> sendVideoMessage(
    String roomId, {
    required Uint8List videoBytes,
    required String filename,
    String? mimeType,
    Uint8List? thumbnailBytes,
    int? selfDestructAfter,
  }) => MediaTelemetry.trace(
    MediaStage.send,
    () => _sendVideoMessage(
      roomId,
      videoBytes: videoBytes,
      filename: filename,
      mimeType: mimeType,
      thumbnailBytes: thumbnailBytes,
      selfDestructAfter: selfDestructAfter,
    ),
    bytes: videoBytes.length,
  );

  Future<String?> _sendVideoMessage(
    String roomId, {
    required Uint8List videoBytes,
    required String filename,
    String? mimeType,
    Uint8List? thumbnailBytes,
    int? selfDestructAfter,
  }) async {
    debugLog('=== MatrixMessageDataSource.sendVideoMessage start ===');
    debugLog('roomId: $roomId');
    debugLog('filename: $filename');
    debugLog('videoBytes.length: ${videoBytes.length}');

    try {
      if (_client == null) {
        throw Exception('Matrix 客户端未初始化');
      }
      if (!_client!.isLogged()) {
        throw Exception('未登录');
      }

      final room = await prepareRoomForSending(_client, roomId);
      if (room == null) {
        throw Exception('房间不存在: $roomId');
      }

      final actualMimeType = mimeType ?? 'video/mp4';

      if (room.encrypted) {
        if (!_client!.fileEncryptionEnabled) {
          throw StateError('Attachment encryption is unavailable');
        }
        return await room.sendFileEvent(
          matrix.MatrixVideoFile(
            bytes: videoBytes,
            name: filename,
            mimeType: actualMimeType,
          ),
          thumbnail: thumbnailBytes == null || thumbnailBytes.isEmpty
              ? null
              : matrix.MatrixImageFile(
                  bytes: thumbnailBytes,
                  name: 'thumbnail.jpg',
                  mimeType: 'image/jpeg',
                ),
          extraContent: {
            if (selfDestructAfter != null && selfDestructAfter > 0)
              'n42.self_destruct': {'after': selfDestructAfter},
          },
        );
      }

      // Unencrypted rooms retain the existing upload transport.
      debugLog('Using manual upload for video with thumbnail support...');

      // 手动上传视频
      final mxcUri = await _uploader.uploadContentAuthenticated(
        videoBytes,
        filename: filename,
        contentType: actualMimeType,
      );

      if (mxcUri == null) {
        throw Exception('上传视频失败：无法获取 MXC URI');
      }

      // 上传缩略图（如果有）
      Uri? thumbnailUri;
      if (thumbnailBytes != null && thumbnailBytes.isNotEmpty) {
        thumbnailUri = await _uploader.uploadContentAuthenticated(
          thumbnailBytes,
          filename: 'thumbnail_$filename.jpg',
          contentType: 'image/jpeg',
        );
      }

      final content = <String, dynamic>{
        'msgtype': 'm.video',
        'body': filename,
        'url': mxcUri.toString(),
        'info': {'mimetype': actualMimeType, 'size': videoBytes.length},
      };

      if (thumbnailUri != null) {
        content['info']['thumbnail_url'] = thumbnailUri.toString();
        content['info']['thumbnail_info'] = {
          'mimetype': 'image/jpeg',
          'w': 400,
          'h': 400,
        };
      }

      // View Once / 阅后即焚支持
      if (selfDestructAfter != null && selfDestructAfter > 0) {
        content['n42.self_destruct'] = {'after': selfDestructAfter};
      }

      final result = await room.sendEvent(content);
      debugLog(
        '=== sendVideoMessage completed successfully (manual method) ===',
      );
      return result;
    } catch (e, stackTrace) {
      debugLog('=== sendVideoMessage ERROR ===');
      debugLog('Error: $e');
      debugLog('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// 发送文件消息
  ///
  /// 使用 Matrix SDK 内置方法或手动上传
  Future<String?> sendFileMessage(
    String roomId, {
    Uint8List? fileBytes,
    required String filename,
    String? mimeType,
    int? selfDestructAfter,
    String? filePath,
    Stream<List<int>>? fileStream,
    int? fileSize,
  }) => MediaTelemetry.trace(
    MediaStage.send,
    () => _sendFileMessage(
      roomId,
      fileBytes: fileBytes,
      filename: filename,
      mimeType: mimeType,
      selfDestructAfter: selfDestructAfter,
      filePath: filePath,
      fileStream: fileStream,
      fileSize: fileSize,
    ),
    bytes: fileSize ?? fileBytes?.length ?? 0,
  );

  Future<String?> _sendFileMessage(
    String roomId, {
    Uint8List? fileBytes,
    required String filename,
    String? mimeType,
    int? selfDestructAfter,
    String? filePath,
    Stream<List<int>>? fileStream,
    int? fileSize,
  }) async {
    debugLog('=== MatrixMessageDataSource.sendFileMessage start ===');
    debugLog('roomId: $roomId');
    debugLog('filename: $filename');
    debugLog('fileSize: ${fileSize ?? fileBytes?.length ?? 0}');

    try {
      if (_client == null) {
        throw Exception('Matrix 客户端未初始化');
      }
      if (!_client!.isLogged()) {
        throw Exception('未登录');
      }

      final room = await resolveRoomForSending(_client, roomId);
      if (room == null) {
        throw Exception('房间不存在: $roomId');
      }

      final actualMimeType = mimeType ?? 'application/octet-stream';
      final effectiveSize =
          fileSize ??
          fileBytes?.length ??
          (filePath != null ? await File(filePath).length() : null);

      final client = _client!;
      final userId = client.userID;
      final token = client.accessToken;
      bool isActive() =>
          identical(_client, client) &&
          client.userID == userId &&
          client.accessToken == token &&
          client.isLogged();
      final limit = await AttachmentSizePolicy.effectiveLimit(
        client,
        configuredLimit: maxAttachmentBytes,
      );
      if (effectiveSize != null &&
          (effectiveSize <= 0 || effectiveSize > limit)) {
        throw StateError(
          'File exceeds the ${(limit / (1024 * 1024)).toStringAsFixed(1)} MiB upload limit.',
        );
      }
      if (fileBytes != null &&
          (fileBytes.length > limit || effectiveSize != fileBytes.length)) {
        throw StateError(
          'Attachment size changed or exceeds the upload limit.',
        );
      }
      if (room.encrypted && !client.fileEncryptionEnabled) {
        throw StateError('Attachment encryption is unavailable');
      }
      if (room.encrypted && (filePath != null || fileStream != null)) {
        await EncryptedSendGuard.prepare(room);
        final encrypted = await StreamingAttachmentEncryptor().encrypt(
          filePath != null ? File(filePath).openRead() : fileStream!,
          maxBytes: limit,
          expectedBytes: effectiveSize,
          isActive: isActive,
        );
        try {
          if (!isActive() || !room.encrypted) {
            throw StateError('Attachment session ended.');
          }
          final mxc = await _uploader.uploadFileAuthenticated(
            encrypted.file.path,
            contentLength: encrypted.size,
            contentType: 'application/octet-stream',
          );
          if (mxc == null || !isActive()) {
            throw StateError('Encrypted upload could not be completed.');
          }
          await EncryptedSendGuard.prepare(room);
          if (!isActive() || !room.encrypted) {
            throw StateError('Attachment session ended.');
          }
          return await room.sendEvent({
            'msgtype': 'm.file',
            'body': filename,
            'filename': filename,
            'file': encrypted.descriptor(mxc),
            'info': {'mimetype': actualMimeType, 'size': encrypted.size},
            if (selfDestructAfter != null)
              'n42.self_destruct': {'seconds': selfDestructAfter},
          });
        } finally {
          await encrypted.dispose();
        }
      }
      // Byte-backed callers keep the existing memory bound. Large attachments
      // must supply a file path/stream so they never allocate the entire file.
      if (fileBytes != null && fileBytes.length > AppConstants.maxFileSize) {
        throw StateError('Large attachments require a file source.');
      }

      await EncryptedSendGuard.prepare(room);
      if (!isActive()) throw StateError('Attachment session ended.');
      if (filePath != null || fileStream != null) {
        if (room.encrypted) {
          throw StateError('Room encryption changed. Retry the attachment.');
        }
        Uri? mxcUri;
        if (filePath != null) {
          mxcUri = await _uploader.uploadFileAuthenticated(
            filePath,
            contentLength: effectiveSize ?? await File(filePath).length(),
            filename: filename,
            contentType: actualMimeType,
          );
        } else if (fileStream != null && effectiveSize != null) {
          mxcUri = await _uploader.uploadStreamAuthenticated(
            fileStream,
            contentLength: effectiveSize,
            filename: filename,
            contentType: actualMimeType,
          );
        }

        if (mxcUri == null) {
          throw Exception('上传文件失败：无法获取 MXC URI');
        }

        final content = <String, dynamic>{
          'msgtype': 'm.file',
          'body': filename,
          'filename': filename,
          'url': mxcUri.toString(),
          'info': {'mimetype': actualMimeType, 'size': ?effectiveSize},
          if (selfDestructAfter != null)
            'n42.self_destruct': {'seconds': selfDestructAfter},
        };

        final result = await room.sendEvent(content);
        debugLog(
          '=== sendFileMessage completed successfully (streaming method) ===',
        );
        return result;
      }

      if (fileBytes == null) {
        throw Exception('文件内容为空');
      }

      // 方法1: 使用 SDK 内置的 sendFileEvent
      debugLog('Trying SDK sendFileEvent for file...');
      try {
        final matrixFile = matrix.MatrixFile(
          bytes: fileBytes,
          name: filename,
          mimeType: actualMimeType,
        );

        final result = await room.sendFileEvent(
          matrixFile,
          extraContent: selfDestructAfter != null
              ? {
                  'n42.self_destruct': {'seconds': selfDestructAfter},
                }
              : null,
        );

        debugLog('sendFileEvent result: $result');
        debugLog('=== sendFileMessage completed successfully (SDK method) ===');
        return result;
      } catch (sdkError, sdkStack) {
        if (room.encrypted) rethrow;
        debugLog('SDK sendFileEvent for file failed: $sdkError');
        debugLog('Stack: $sdkStack');
        debugLog('Falling back to manual upload...');
      }

      // 方法2: 手动上传
      final mxcUri = await _uploader.uploadContentAuthenticated(
        fileBytes,
        filename: filename,
        contentType: actualMimeType,
      );

      if (mxcUri == null) {
        throw Exception('上传文件失败：无法获取 MXC URI');
      }

      final content = <String, dynamic>{
        'msgtype': 'm.file',
        'body': filename,
        'filename': filename,
        'url': mxcUri.toString(),
        'info': {
          'mimetype': actualMimeType,
          'size': effectiveSize ?? fileBytes.length,
        },
        if (selfDestructAfter != null)
          'n42.self_destruct': {'seconds': selfDestructAfter},
      };

      final result = await room.sendEvent(content);
      debugLog(
        '=== sendFileMessage completed successfully (manual method) ===',
      );
      return result;
    } catch (e, stackTrace) {
      debugLog('=== sendFileMessage ERROR ===');
      debugLog('Error: $e');
      debugLog('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
