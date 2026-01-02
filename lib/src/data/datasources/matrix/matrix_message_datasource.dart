import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart' as matrix;

import '../../../domain/entities/message_entity.dart';
import 'matrix_client_manager.dart';

/// Matrix消息数据源
///
/// 封装Matrix SDK的消息相关操作
class MatrixMessageDataSource {
  final MatrixClientManager _clientManager;

  MatrixMessageDataSource(this._clientManager);

  /// 获取Matrix客户端
  matrix.Client? get _client => _clientManager.client;

  // ============================================
  // 消息获取
  // ============================================

  /// 获取房间的时间线
  Future<matrix.Timeline?> getTimeline(String roomId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    return await room.getTimeline();
  }

  /// 获取房间消息历史
  Future<List<matrix.Event>> getMessages(
    String roomId, {
    int limit = 50,
    String? fromEventId,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return [];

    final timeline = await room.getTimeline();
    
    // 如果需要加载更多历史消息
    if (fromEventId != null) {
      await timeline.requestHistory(historyCount: limit);
    }

    // 过滤出消息事件
    return timeline.events
        .where((event) => _isMessageEvent(event))
        .take(limit)
        .toList();
  }

  /// 加载更多历史消息
  Future<bool> loadMoreMessages(
    String roomId, {
    int count = 50,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return false;

    final timeline = await room.getTimeline();
    
    try {
      await timeline.requestHistory(historyCount: count);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 根据事件ID获取消息
  Future<matrix.Event?> getMessageById(String roomId, String eventId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    return await room.getEventById(eventId);
  }

  // ============================================
  // 消息发送
  // ============================================

  /// 检查服务器是否支持认证媒体上传
  Future<bool> _supportsAuthenticatedMedia() async {
    try {
      final versionsResponse = await _client!.getVersions();
      // 检查 Matrix 版本是否 >= v1.11 (支持认证媒体)
      final supportsV111 = versionsResponse.versions.any(
        (v) => _isVersionGreaterThanOrEqualTo(v, 'v1.11'),
      );
      // 或者检查 unstable feature
      final hasUnstableFeature = 
          versionsResponse.unstableFeatures?['org.matrix.msc3916.stable'] == true;
      
      debugPrint('MatrixMessageDataSource: supportsV111=$supportsV111, hasUnstableFeature=$hasUnstableFeature');
      return supportsV111 || hasUnstableFeature;
    } catch (e) {
      debugPrint('MatrixMessageDataSource: Error checking authenticated media support: $e');
      return false;
    }
  }
  
  bool _isVersionGreaterThanOrEqualTo(String version, String target) {
    // 简单的版本比较，假设格式为 "vX.Y"
    try {
      final vParts = version.replaceAll('v', '').split('.');
      final tParts = target.replaceAll('v', '').split('.');
      
      final vMajor = int.tryParse(vParts[0]) ?? 0;
      final vMinor = vParts.length > 1 ? (int.tryParse(vParts[1]) ?? 0) : 0;
      final tMajor = int.tryParse(tParts[0]) ?? 0;
      final tMinor = tParts.length > 1 ? (int.tryParse(tParts[1]) ?? 0) : 0;
      
      if (vMajor > tMajor) return true;
      if (vMajor < tMajor) return false;
      return vMinor >= tMinor;
    } catch (e) {
      return false;
    }
  }

  /// 使用认证端点上传文件
  /// 
  /// 这是一个 workaround，因为 Matrix SDK 0.32.x 没有正确实现
  /// MSC3916 的认证媒体上传端点 (_matrix/client/v1/media/upload)
  Future<Uri?> _uploadContentAuthenticated(
    Uint8List content, {
    String? filename,
    String? contentType,
  }) async {
    final client = _client;
    if (client == null) {
      throw Exception('Matrix client not initialized');
    }
    if (client.accessToken == null) {
      throw Exception('No access token available');
    }
    if (client.homeserver == null) {
      throw Exception('No homeserver configured');
    }

    final supportsAuth = await _supportsAuthenticatedMedia();
    debugPrint('MatrixMessageDataSource: supportsAuthenticatedMedia=$supportsAuth');
    
    // 根据服务器能力选择端点
    final path = supportsAuth 
        ? '_matrix/client/v1/media/upload'  // 认证媒体端点 (MSC3916)
        : '_matrix/media/v3/upload';         // 传统端点
    
    final uri = Uri.parse('${client.homeserver}/$path').replace(
      queryParameters: filename != null ? {'filename': filename} : null,
    );
    
    debugPrint('MatrixMessageDataSource: Uploading to: $uri');
    debugPrint('MatrixMessageDataSource: Content size: ${content.length} bytes');
    debugPrint('MatrixMessageDataSource: Content type: $contentType');
    
    final request = http.Request('POST', uri);
    request.headers['Authorization'] = 'Bearer ${client.accessToken}';
    if (contentType != null) {
      request.headers['Content-Type'] = contentType;
    }
    request.bodyBytes = content;
    
    try {
      final streamedResponse = await http.Client().send(request);
      final response = await http.Response.fromStream(streamedResponse);
      
      debugPrint('MatrixMessageDataSource: Upload response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final contentUri = json['content_uri'] as String?;
        if (contentUri != null) {
          debugPrint('MatrixMessageDataSource: Upload successful: $contentUri');
          return Uri.parse(contentUri);
        }
      }
      
      // 上传失败，尝试显示错误信息
      debugPrint('MatrixMessageDataSource: Upload failed: ${response.body}');
      
      // 如果使用认证端点失败 (403/404)，尝试传统端点
      if (supportsAuth && (response.statusCode == 403 || response.statusCode == 404)) {
        debugPrint('MatrixMessageDataSource: Auth endpoint failed (${response.statusCode}), trying legacy endpoint...');
        return _uploadContentLegacy(content, filename: filename, contentType: contentType);
      }
      
      // 如果传统端点也失败，再尝试一次不同的上传方式
      if (!supportsAuth && (response.statusCode == 403 || response.statusCode == 404)) {
        debugPrint('MatrixMessageDataSource: Legacy endpoint failed, trying SDK upload...');
        // 使用 SDK 自带的上传方法
        try {
          final mxcUri = await client.uploadContent(content, filename: filename, contentType: contentType);
          return mxcUri;
        } catch (sdkError) {
          debugPrint('MatrixMessageDataSource: SDK upload also failed: $sdkError');
        }
      }
      
      // 解析错误信息
      try {
        final errorJson = jsonDecode(response.body);
        final errcode = errorJson['errcode'] as String?;
        final error = errorJson['error'] as String?;
        throw Exception('Upload failed: $errcode - $error');
      } catch (e) {
        if (e is Exception && e.toString().contains('Upload failed:')) {
          rethrow;
        }
        throw Exception('Upload failed with status ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('MatrixMessageDataSource: Upload error: $e');
      // 如果是我们抛出的异常，直接重新抛出
      if (e is Exception && e.toString().contains('Upload failed')) {
        rethrow;
      }
      // 否则尝试使用 SDK 自带的上传方法
      debugPrint('MatrixMessageDataSource: Trying SDK upload as last resort...');
      try {
        final mxcUri = await client.uploadContent(content, filename: filename, contentType: contentType);
        return mxcUri;
      } catch (sdkError) {
        debugPrint('MatrixMessageDataSource: SDK upload failed: $sdkError');
        rethrow;
      }
    }
  }
  
  /// 使用传统端点上传文件（作为 fallback）
  Future<Uri?> _uploadContentLegacy(
    Uint8List content, {
    String? filename,
    String? contentType,
  }) async {
    final client = _client;
    if (client == null) return null;
    
    final uri = Uri.parse('${client.homeserver}/_matrix/media/v3/upload').replace(
      queryParameters: filename != null ? {'filename': filename} : null,
    );
    
    debugPrint('MatrixMessageDataSource: Uploading (legacy) to: $uri');
    
    try {
      final request = http.Request('POST', uri);
      request.headers['Authorization'] = 'Bearer ${client.accessToken}';
      if (contentType != null) {
        request.headers['Content-Type'] = contentType;
      }
      request.bodyBytes = content;
      
      final streamedResponse = await http.Client().send(request);
      final response = await http.Response.fromStream(streamedResponse);
      
      debugPrint('MatrixMessageDataSource: Legacy upload response: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final contentUri = json['content_uri'] as String?;
        if (contentUri != null) {
          debugPrint('MatrixMessageDataSource: Legacy upload successful: $contentUri');
          return Uri.parse(contentUri);
        }
      }
      
      debugPrint('MatrixMessageDataSource: Legacy upload failed: ${response.body}');
      
      // 如果传统端点也失败，使用 SDK 内置方法
      debugPrint('MatrixMessageDataSource: Trying SDK uploadContent...');
      final mxcUri = await client.uploadContent(content, filename: filename, contentType: contentType);
      debugPrint('MatrixMessageDataSource: SDK upload successful: $mxcUri');
      return mxcUri;
    } catch (e) {
      debugPrint('MatrixMessageDataSource: Legacy upload error: $e');
      // 最后尝试 SDK 方法
      try {
        debugPrint('MatrixMessageDataSource: Last resort - SDK uploadContent...');
        final mxcUri = await client.uploadContent(content, filename: filename, contentType: contentType);
        debugPrint('MatrixMessageDataSource: SDK upload successful: $mxcUri');
        return mxcUri;
      } catch (sdkError) {
        debugPrint('MatrixMessageDataSource: All upload methods failed: $sdkError');
        rethrow;
      }
    }
    return null;
  }

  /// 发送文本消息
  Future<String?> sendTextMessage(String roomId, String text) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    return await room.sendTextEvent(text);
  }

  /// 发送图片消息
  /// 
  /// 简化的实现：直接使用 SDK 的 uploadContent + sendEvent
  Future<String?> sendImageMessage(
    String roomId, {
    required Uint8List imageBytes,
    required String filename,
    String? mimeType,
  }) async {
    debugPrint('=== sendImageMessage start ===');
    debugPrint('roomId: $roomId, filename: $filename, size: ${imageBytes.length}');
    
    try {
      if (_client == null || !_client!.isLogged()) {
        throw Exception('未登录或客户端未初始化');
      }
      
      final room = _client!.getRoomById(roomId);
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
      } else if (lowerFilename.endsWith('.heic') || lowerFilename.endsWith('.heif')) {
        actualMimeType = 'image/jpeg';
      }

      debugPrint('MIME type: $actualMimeType');

      // 直接使用 SDK 的 uploadContent 方法（最可靠）
      debugPrint('Uploading with SDK uploadContent...');
      Uri? mxcUri;
      
      try {
        mxcUri = await _client!.uploadContent(
          imageBytes,
          filename: filename,
          contentType: actualMimeType,
        );
        debugPrint('SDK upload successful: $mxcUri');
      } catch (sdkUploadError) {
        debugPrint('SDK uploadContent failed: $sdkUploadError');
        // 尝试手动上传
        debugPrint('Trying manual upload...');
        mxcUri = await _uploadContentAuthenticated(
          imageBytes,
          filename: filename,
          contentType: actualMimeType,
        );
      }
      
      if (mxcUri == null) {
        throw Exception('上传图片失败');
      }
      
      debugPrint('Upload successful: $mxcUri');
      
      // 发送消息事件
      final content = <String, dynamic>{
        'msgtype': 'm.image',
        'body': filename,
        'url': mxcUri.toString(),
        'info': {
          'mimetype': actualMimeType,
          'size': imageBytes.length,
        },
      };
      
      final result = await room.sendEvent(content);
      debugPrint('sendEvent result: $result');
      debugPrint('=== sendImageMessage completed ===');
      return result;
    } catch (e, stackTrace) {
      debugPrint('=== sendImageMessage ERROR: $e ===');
      debugPrint('Stack: $stackTrace');
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
  }) async {
    debugPrint('=== MatrixMessageDataSource.sendVoiceMessage start ===');
    debugPrint('roomId: $roomId');
    debugPrint('filename: $filename');
    debugPrint('duration: $duration ms');
    debugPrint('audioBytes.length: ${audioBytes.length}');
    
    try {
      if (_client == null) {
        throw Exception('Matrix 客户端未初始化');
      }
      
      if (!_client!.isLogged()) {
        throw Exception('未登录');
      }
      
      final room = _client!.getRoomById(roomId);
      if (room == null) {
        throw Exception('房间不存在: $roomId');
      }

      // 确定正确的 MIME 类型
      String actualMimeType = mimeType ?? 'audio/mp4';
      final lowerFilename = filename.toLowerCase();
      if (lowerFilename.endsWith('.m4a')) {
        actualMimeType = 'audio/mp4';
      } else if (lowerFilename.endsWith('.ogg') || lowerFilename.endsWith('.opus')) {
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

      debugPrint('Final mimeType: $actualMimeType');

      // 方法1: 使用 SDK 内置的 sendFileEvent
      debugPrint('Trying SDK sendFileEvent for audio...');
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
            'org.matrix.msc3245.voice': {},
            // MSC1767 音频消息扩展
            'org.matrix.msc1767.audio': {
              'duration': duration,
            },
          },
        );
        
        debugPrint('sendFileEvent result: $result');
        debugPrint('=== sendVoiceMessage completed successfully (SDK method) ===');
        return result;
      } catch (sdkError, sdkStack) {
        debugPrint('SDK sendFileEvent for audio failed: $sdkError');
        debugPrint('Stack: $sdkStack');
        debugPrint('Falling back to manual upload...');
      }

      // 方法2: 手动上传
      final mxcUri = await _uploadContentAuthenticated(
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
        'org.matrix.msc3245.voice': {},
        'org.matrix.msc1767.audio': {
          'duration': duration,
        },
      };
      
      final result = await room.sendEvent(content);
      debugPrint('=== sendVoiceMessage completed successfully (manual method) ===');
      return result;
    } catch (e, stackTrace) {
      debugPrint('=== sendVoiceMessage ERROR ===');
      debugPrint('Error: $e');
      debugPrint('Stack trace: $stackTrace');
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
  }) async {
    debugPrint('=== MatrixMessageDataSource.sendVideoMessage start ===');
    debugPrint('roomId: $roomId');
    debugPrint('filename: $filename');
    debugPrint('videoBytes.length: ${videoBytes.length}');
    
    try {
      if (_client == null) {
        throw Exception('Matrix 客户端未初始化');
      }
      if (!_client!.isLogged()) {
        throw Exception('未登录');
      }
      
      final room = _client!.getRoomById(roomId);
      if (room == null) {
        throw Exception('房间不存在: $roomId');
      }

      final actualMimeType = mimeType ?? 'video/mp4';
      
      // 方法1: 使用 SDK 内置的 sendFileEvent
      debugPrint('Trying SDK sendFileEvent for video...');
      try {
        final matrixFile = matrix.MatrixVideoFile(
          bytes: videoBytes,
          name: filename,
          mimeType: actualMimeType,
        );
        
        final result = await room.sendFileEvent(matrixFile);
        
        debugPrint('sendFileEvent result: $result');
        debugPrint('=== sendVideoMessage completed successfully (SDK method) ===');
        return result;
      } catch (sdkError, sdkStack) {
        debugPrint('SDK sendFileEvent for video failed: $sdkError');
        debugPrint('Stack: $sdkStack');
        debugPrint('Falling back to manual upload...');
      }
      
      // 方法2: 手动上传
      final mxcUri = await _uploadContentAuthenticated(
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
        thumbnailUri = await _uploadContentAuthenticated(
          thumbnailBytes,
          filename: 'thumbnail_$filename.jpg',
          contentType: 'image/jpeg',
        );
      }
      
      final content = <String, dynamic>{
        'msgtype': 'm.video',
        'body': filename,
        'url': mxcUri.toString(),
        'info': {
          'mimetype': actualMimeType,
          'size': videoBytes.length,
        },
      };
      
      if (thumbnailUri != null) {
        content['info']['thumbnail_url'] = thumbnailUri.toString();
      }
      
      final result = await room.sendEvent(content);
      debugPrint('=== sendVideoMessage completed successfully (manual method) ===');
      return result;
    } catch (e, stackTrace) {
      debugPrint('=== sendVideoMessage ERROR ===');
      debugPrint('Error: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// 发送文件消息
  /// 
  /// 使用 Matrix SDK 内置方法或手动上传
  Future<String?> sendFileMessage(
    String roomId, {
    required Uint8List fileBytes,
    required String filename,
    String? mimeType,
  }) async {
    debugPrint('=== MatrixMessageDataSource.sendFileMessage start ===');
    debugPrint('roomId: $roomId');
    debugPrint('filename: $filename');
    debugPrint('fileBytes.length: ${fileBytes.length}');
    
    try {
      if (_client == null) {
        throw Exception('Matrix 客户端未初始化');
      }
      if (!_client!.isLogged()) {
        throw Exception('未登录');
      }
      
      final room = _client!.getRoomById(roomId);
      if (room == null) {
        throw Exception('房间不存在: $roomId');
      }

      final actualMimeType = mimeType ?? 'application/octet-stream';
      
      // 方法1: 使用 SDK 内置的 sendFileEvent
      debugPrint('Trying SDK sendFileEvent for file...');
      try {
        final matrixFile = matrix.MatrixFile(
          bytes: fileBytes,
          name: filename,
          mimeType: actualMimeType,
        );
        
        final result = await room.sendFileEvent(matrixFile);
        
        debugPrint('sendFileEvent result: $result');
        debugPrint('=== sendFileMessage completed successfully (SDK method) ===');
        return result;
      } catch (sdkError, sdkStack) {
        debugPrint('SDK sendFileEvent for file failed: $sdkError');
        debugPrint('Stack: $sdkStack');
        debugPrint('Falling back to manual upload...');
      }
      
      // 方法2: 手动上传
      final mxcUri = await _uploadContentAuthenticated(
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
          'size': fileBytes.length,
        },
      };
      
      final result = await room.sendEvent(content);
      debugPrint('=== sendFileMessage completed successfully (manual method) ===');
      return result;
    } catch (e, stackTrace) {
      debugPrint('=== sendFileMessage ERROR ===');
      debugPrint('Error: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// 发送位置消息
  /// 
  /// Matrix 位置消息格式参考:
  /// https://spec.matrix.org/latest/client-server-api/#mlocation
  Future<String?> sendLocationMessage(
    String roomId, {
    required double latitude,
    required double longitude,
    String? description,
  }) async {
    debugPrint('=== MatrixMessageDataSource.sendLocationMessage start ===');
    debugPrint('roomId: $roomId');
    debugPrint('latitude: $latitude');
    debugPrint('longitude: $longitude');
    debugPrint('description: $description');
    
    try {
      // 检查客户端
      if (_client == null) {
        debugPrint('ERROR: Matrix client is null');
        throw Exception('Matrix 客户端未初始化');
      }
      
      // 检查登录状态
      if (!_client!.isLogged()) {
        debugPrint('ERROR: Not logged in');
        throw Exception('未登录');
      }
      
      // 获取房间
      final room = _client!.getRoomById(roomId);
      if (room == null) {
        debugPrint('ERROR: Room not found: $roomId');
        throw Exception('房间不存在: $roomId');
      }
      debugPrint('Room found: ${room.getLocalizedDisplayname()}');

      // 构建 geo URI (标准格式)
      final geoUri = 'geo:$latitude,$longitude';
      
      // 构建位置消息内容 (遵循 Matrix 规范)
      final content = {
        'msgtype': matrix.MessageTypes.Location,
        'body': description ?? '位置: $latitude, $longitude',
        'geo_uri': geoUri,
        'info': {
          // Matrix org.matrix.msc3488 扩展
          'latitude': latitude,
          'longitude': longitude,
        },
        // Matrix 规范的 m.location 扩展 (可选)
        'org.matrix.msc3488.location': {
          'uri': geoUri,
          'description': description ?? '位置',
        },
        // 资产类型
        'org.matrix.msc3488.asset': {
          'type': 'm.self', // 表示这是用户自己的位置
        },
      };
      
      debugPrint('Location content: $content');
      debugPrint('Calling room.sendEvent...');
      
      final result = await room.sendEvent(content);
      debugPrint('sendEvent result: $result');
      
      if (result == null || result.isEmpty) {
        debugPrint('WARNING: sendEvent returned null or empty result');
      }
      
      debugPrint('=== sendLocationMessage completed successfully ===');
      return result;
    } catch (e, stackTrace) {
      debugPrint('=== sendLocationMessage ERROR ===');
      debugPrint('Error: $e');
      debugPrint('Error type: ${e.runtimeType}');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// 发送自定义消息
  Future<String> sendCustomMessage({
    required String roomId,
    required String msgType,
    required Map<String, dynamic> content,
  }) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) {
      throw Exception('房间不存在');
    }

    final eventId = await room.sendEvent(content);
    return eventId ?? '';
  }

  /// 重发消息
  Future<bool> resendMessage(String roomId, String eventId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return false;

    final event = await room.getEventById(eventId);
    if (event == null) return false;

    // 获取原始内容并重新发送
    try {
      await room.sendEvent(event.content);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ============================================
  // 消息操作
  // ============================================

  /// 撤回消息
  Future<bool> redactMessage(String roomId, String eventId, {String? reason}) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return false;

    try {
      await room.redactEvent(eventId, reason: reason);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 回复消息
  Future<String?> replyToMessage(
    String roomId,
    String replyToEventId,
    String text,
  ) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    final replyEvent = await room.getEventById(replyToEventId);
    if (replyEvent == null) return null;

    return await room.sendTextEvent(
      text,
      inReplyTo: replyEvent,
    );
  }

  /// 编辑消息
  Future<String?> editMessage(
    String roomId,
    String originalEventId,
    String newText,
  ) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return null;

    final originalEvent = await room.getEventById(originalEventId);
    if (originalEvent == null) return null;

    return await room.sendTextEvent(
      newText,
      editEventId: originalEventId,
    );
  }

  /// 添加消息表情回应
  Future<bool> addReaction(
    String roomId,
    String eventId,
    String emoji,
  ) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return false;

    try {
      await room.sendReaction(eventId, emoji);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ============================================
  // 消息已读状态
  // ============================================

  /// 标记消息已读
  Future<void> markMessageAsRead(String roomId, String eventId) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;
    
    // 验证 eventId 格式（Matrix 事件 ID 以 $ 开头）
    if (eventId.isEmpty || !eventId.startsWith('\$')) {
      debugPrint('MatrixMessageDataSource: Invalid eventId format: $eventId');
      return;
    }

    try {
      await room.setReadMarker(eventId, mRead: eventId);
    } catch (e) {
      debugPrint('MatrixMessageDataSource: markMessageAsRead error: $e');
      // 忽略标记已读失败，不影响用户体验
    }
  }

  /// 发送正在输入状态
  Future<void> sendTypingNotification(String roomId, bool isTyping) async {
    final room = _client?.getRoomById(roomId);
    if (room == null) return;

    await room.setTyping(isTyping);
  }

  // ============================================
  // 消息监听
  // ============================================

  /// 监听房间消息更新
  Stream<matrix.Event>? watchRoomMessages(String roomId) {
    return _client?.onEvent.stream.where((eventUpdate) {
      return eventUpdate.roomID == roomId &&
          _isMessageEvent(eventUpdate.content);
    }).map((eventUpdate) {
      final room = _client!.getRoomById(roomId)!;
      return matrix.Event.fromJson(eventUpdate.content, room);
    });
  }

  /// 监听消息发送状态
  Stream<matrix.SyncUpdate>? get onSyncUpdate => _client?.onSync.stream;

  // ============================================
  // 工具方法
  // ============================================

  /// 判断是否是消息事件
  bool _isMessageEvent(dynamic event) {
    if (event is matrix.Event) {
      return event.type == matrix.EventTypes.Message ||
          event.type == matrix.EventTypes.Encrypted ||
          event.type == matrix.EventTypes.Sticker;
    }
    if (event is Map<String, dynamic>) {
      final type = event['type'] as String?;
      return type == matrix.EventTypes.Message ||
          type == matrix.EventTypes.Encrypted ||
          type == matrix.EventTypes.Sticker;
    }
    return false;
  }

  /// 将Matrix事件转换为消息实体
  MessageEntity mapEventToMessage(matrix.Event event, matrix.Room room) {
    final sender = room.unsafeGetUserFromMemoryOrFallback(event.senderId);
    
    // 解析消息内容，处理回复格式
    final parsedContent = _parseMessageContent(event, room);
    
    // 转换头像 mxc:// URL 为 HTTP URL（使用手动构建方式）
    final avatarHttpUrl = _buildHttpUrl(
      sender.avatarUrl?.toString(),
      width: 80,
      height: 80,
      method: 'crop',
    );
    
    return MessageEntity(
      id: event.eventId,
      roomId: room.id,
      senderId: event.senderId,
      senderName: sender.calcDisplayname(),
      senderAvatarUrl: avatarHttpUrl,
      content: parsedContent.content,
      type: _mapMessageType(event),
      timestamp: event.originServerTs,
      status: _mapMessageStatus(event),
      isFromMe: event.senderId == _client?.userID,
      replyToId: event.relationshipEventId,
      replyToContent: parsedContent.replyToContent,
      replyToSender: parsedContent.replyToSender,
      isEdited: false, // 简化处理，后续可通过检查编辑事件实现
      reactions: _extractReactions(event),
      metadata: _extractMetadataWithHttpUrl(event),
    );
  }
  
  /// 解析消息内容，处理回复格式
  /// Matrix 回复格式: "> <@user:server> 原消息内容\n\n实际回复内容"
  _ParsedContent _parseMessageContent(matrix.Event event, matrix.Room room) {
    String body = event.body;
    String? replyToContent;
    String? replyToSender;
    
    // 检查是否是回复消息（有 m.relates_to 或以 > 开头）
    if (event.relationshipEventId != null || body.startsWith('> ')) {
      // 尝试从 body 解析回复格式
      final lines = body.split('\n');
      final List<String> quotedLines = [];
      int contentStartIndex = 0;
      
      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.startsWith('> ')) {
          quotedLines.add(line);
          contentStartIndex = i + 1;
        } else if (line.isEmpty && quotedLines.isNotEmpty) {
          // 空行分隔引用和实际内容
          contentStartIndex = i + 1;
          break;
        } else if (quotedLines.isNotEmpty) {
          // 遇到非引用行，停止
          break;
        }
      }
      
      // 如果找到了引用内容
      if (quotedLines.isNotEmpty) {
        // 解析引用的发送者和内容
        final firstQuoteLine = quotedLines.first;
        // 格式: "> <@user:server> 内容" 或 "> * <@user:server> 内容"
        final userMatch = RegExp(r'> \*? ?<(@[^>]+)>(.*)').firstMatch(firstQuoteLine);
        if (userMatch != null) {
          final userId = userMatch.group(1);
          replyToContent = userMatch.group(2)?.trim();
          
          // 如果有多行引用，合并
          if (quotedLines.length > 1) {
            final restQuotes = quotedLines.skip(1).map((l) => l.replaceFirst('> ', '')).join('\n');
            replyToContent = '${replyToContent ?? ''}\n$restQuotes'.trim();
          }
          
          // 获取发送者名称
          if (userId != null) {
            try {
              final replyUser = room.unsafeGetUserFromMemoryOrFallback(userId);
              replyToSender = replyUser.calcDisplayname();
            } catch (_) {
              // 如果获取用户失败，使用 userId 的用户名部分
              replyToSender = userId.split(':').first.replaceFirst('@', '');
            }
          }
        }
        
        // 提取实际回复内容
        if (contentStartIndex < lines.length) {
          body = lines.sublist(contentStartIndex).join('\n').trim();
        }
      }
    }
    
    return _ParsedContent(
      content: body,
      replyToContent: replyToContent,
      replyToSender: replyToSender,
    );
  }

  /// 映射消息类型
  MessageType _mapMessageType(matrix.Event event) {
    if (event.type == matrix.EventTypes.Encrypted) {
      return MessageType.encrypted;
    }

    final msgType = event.messageType;
    switch (msgType) {
      case matrix.MessageTypes.Text:
        return MessageType.text;
      case matrix.MessageTypes.Image:
        return MessageType.image;
      case matrix.MessageTypes.Video:
        return MessageType.video;
      case matrix.MessageTypes.Audio:
        return MessageType.audio;
      case matrix.MessageTypes.File:
        return MessageType.file;
      case matrix.MessageTypes.Location:
        return MessageType.location;
      case matrix.MessageTypes.Notice:
        return MessageType.notice;
      case matrix.MessageTypes.Emote:
        return MessageType.text;
      default:
        // 检查是否是转账消息
        if (event.content['msgtype'] == 'n42.transfer') {
          return MessageType.transfer;
        }
        return MessageType.text;
    }
  }

  /// 映射消息状态
  MessageStatus _mapMessageStatus(matrix.Event event) {
    if (event.status == matrix.EventStatus.error) {
      return MessageStatus.failed;
    }
    if (event.status == matrix.EventStatus.sending) {
      return MessageStatus.sending;
    }
    if (event.status == matrix.EventStatus.sent) {
      return MessageStatus.sent;
    }
    // 检查已读回执
    return MessageStatus.sent;
  }

  /// 提取表情回应
  List<MessageReaction> _extractReactions(matrix.Event event) {
    // TODO: 实现表情回应提取
    return [];
  }

  /// 手动构建 HTTP URL（参考 FluffyChat 实现）
  /// 
  /// 格式: https://homeserver/_matrix/media/v3/download/server/mediaId
  /// 或缩略图: https://homeserver/_matrix/media/v3/thumbnail/server/mediaId?width=x&height=y&method=crop
  /// 
  /// 对于需要认证的服务器，添加 access_token 参数
  String? _buildHttpUrl(String? mxcUrl, {int? width, int? height, String method = 'scale'}) {
    if (mxcUrl == null || mxcUrl.isEmpty || _client == null) return null;
    
    // 如果已经是 HTTP URL，直接返回
    if (mxcUrl.startsWith('http://') || mxcUrl.startsWith('https://')) {
      return mxcUrl;
    }
    
    // 验证是否是有效的 mxc:// URL
    if (!mxcUrl.startsWith('mxc://')) {
      debugPrint('Invalid mxc URL: $mxcUrl');
      return null;
    }
    
    try {
      // 解析 mxc://server/mediaId
      final uri = Uri.parse(mxcUrl);
      final serverName = uri.host;
      final mediaId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';
      
      if (serverName.isEmpty || mediaId.isEmpty) {
        debugPrint('Invalid mxc URL format: $mxcUrl');
        return null;
      }
      
      final homeserver = _client!.homeserver?.toString().replaceAll(RegExp(r'/$'), '') ?? '';
      if (homeserver.isEmpty) {
        debugPrint('No homeserver configured');
        return null;
      }
      
      // 获取 access_token（用于认证媒体访问）
      final accessToken = _client!.accessToken;
      
      // 构建 HTTP URL
      String url;
      if (width != null && height != null) {
        // 缩略图 URL
        url = '$homeserver/_matrix/media/v3/thumbnail/$serverName/$mediaId?width=$width&height=$height&method=$method';
      } else {
        // 完整下载 URL
        url = '$homeserver/_matrix/media/v3/download/$serverName/$mediaId';
      }
      
      // 如果有 access_token，添加到 URL 以支持认证媒体
      if (accessToken != null && accessToken.isNotEmpty) {
        final separator = url.contains('?') ? '&' : '?';
        url = '$url${separator}access_token=$accessToken';
      }
      
      debugPrint('Built media URL: $url');
      return url;
    } catch (e) {
      debugPrint('Error building HTTP URL: $e');
      return null;
    }
  }
  
  /// 转换 mxc:// URL 为 HTTP URL（兼容旧接口）
  String? _convertMxcToHttp(String? mxcUrl, {int? width, int? height}) {
    return _buildHttpUrl(mxcUrl, width: width, height: height, method: 'scale');
  }

  /// 提取消息元数据（带 HTTP URL 转换）
  MessageMetadata? _extractMetadataWithHttpUrl(matrix.Event event) {
    final info = event.content['info'] as Map<String, dynamic>?;
    final mxcUrl = event.content['url'] as String?;
    final thumbnailMxc = info?['thumbnail_url'] as String?;
    
    // 图片信息
    if (event.messageType == matrix.MessageTypes.Image) {
      return MessageMetadata(
        mediaUrl: mxcUrl,
        httpUrl: _convertMxcToHttp(mxcUrl),
        width: info?['w'] as int?,
        height: info?['h'] as int?,
        size: info?['size'] as int?,
        mimeType: info?['mimetype'] as String?,
        thumbnailUrl: _convertMxcToHttp(thumbnailMxc, width: 400, height: 400),
      );
    }

    // 音频信息
    if (event.messageType == matrix.MessageTypes.Audio) {
      return MessageMetadata(
        mediaUrl: mxcUrl,
        httpUrl: _convertMxcToHttp(mxcUrl),
        duration: info?['duration'] as int?,
        size: info?['size'] as int?,
        mimeType: info?['mimetype'] as String?,
      );
    }

    // 视频信息
    if (event.messageType == matrix.MessageTypes.Video) {
      return MessageMetadata(
        mediaUrl: mxcUrl,
        httpUrl: _convertMxcToHttp(mxcUrl),
        width: info?['w'] as int?,
        height: info?['h'] as int?,
        duration: info?['duration'] as int?,
        size: info?['size'] as int?,
        mimeType: info?['mimetype'] as String?,
        thumbnailUrl: _convertMxcToHttp(thumbnailMxc, width: 400, height: 400),
      );
    }

    // 文件信息
    if (event.messageType == matrix.MessageTypes.File) {
      return MessageMetadata(
        mediaUrl: mxcUrl,
        httpUrl: _convertMxcToHttp(mxcUrl),
        fileName: (event.content['filename'] as String?) ?? event.body,
        size: info?['size'] as int?,
        mimeType: info?['mimetype'] as String?,
      );
    }

    // 位置信息
    if (event.messageType == matrix.MessageTypes.Location) {
      // 解析 geo URI
      final geoUri = event.content['geo_uri'] as String?;
      double? latitude;
      double? longitude;
      
      if (geoUri != null && geoUri.startsWith('geo:')) {
        final coords = geoUri.replaceFirst('geo:', '').split(',');
        if (coords.length >= 2) {
          latitude = double.tryParse(coords[0]);
          longitude = double.tryParse(coords[1].split(';').first);
        }
      }
      
      // 如果 geo URI 没有坐标，尝试从 info 获取
      latitude ??= info?['latitude'] as double?;
      longitude ??= info?['longitude'] as double?;
      
      return MessageMetadata(
        latitude: latitude,
        longitude: longitude,
        locationName: event.body,
      );
    }

    return null;
  }
  
  /// 提取消息元数据（旧版，保留兼容）
  MessageMetadata? _extractMetadata(matrix.Event event) {
    return _extractMetadataWithHttpUrl(event);
  }

  /// 获取媒体下载URL
  Uri? getMediaUrl(String? mxcUrl, {int? width, int? height}) {
    if (mxcUrl == null || _client == null) return null;

    try {
      final uri = Uri.parse(mxcUrl);
      if (width != null && height != null) {
        return uri.getThumbnail(
          _client!,
          width: width,
          height: height,
          method: matrix.ThumbnailMethod.scale,
        );
      }
      return uri.getDownloadLink(_client!);
    } catch (e) {
      return null;
    }
  }
}

/// 解析后的消息内容
class _ParsedContent {
  final String content;
  final String? replyToContent;
  final String? replyToSender;
  
  _ParsedContent({
    required this.content,
    this.replyToContent,
    this.replyToSender,
  });
}

