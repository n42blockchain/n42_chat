import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart' as matrix;

import '../matrix_client_manager.dart';

/// Matrix 媒体文件上传器
///
/// 封装认证媒体上传、传统上传和 SDK 上传等多种上传策略
class MatrixMediaUploader {
  final MatrixClientManager _clientManager;

  MatrixMediaUploader(this._clientManager);

  matrix.Client? get _client => _clientManager.client;

  /// 检查服务器是否支持认证媒体上传
  Future<bool> supportsAuthenticatedMedia() async {
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
  Future<Uri?> uploadContentAuthenticated(
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

    final supportsAuth = await supportsAuthenticatedMedia();
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
  }
}
