import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// URL 预览数据
class UrlPreviewData {
  final String url;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? siteName;
  final String? faviconUrl;

  const UrlPreviewData({
    required this.url,
    this.title,
    this.description,
    this.imageUrl,
    this.siteName,
    this.faviconUrl,
  });
}

/// URL 预览服务
///
/// 客户端直接 HTTP GET 目标 URL 的 HTML head
/// 解析 og:* meta 标签
/// 内存 LRU 缓存（100 条，TTL 1h）
class UrlPreviewService {
  static const int _maxCacheSize = 100;
  static const Duration _cacheTtl = Duration(hours: 1);

  final LinkedHashMap<String, _CachedPreview> _cache = LinkedHashMap();
  final Map<String, Future<UrlPreviewData?>> _pending = {};

  /// 获取 URL 预览
  Future<UrlPreviewData?> getPreview(String url) async {
    // 检查缓存
    final cached = _cache[url];
    if (cached != null && !cached.isExpired) {
      // 移到末尾（LRU）
      _cache.remove(url);
      _cache[url] = cached;
      return cached.data;
    }

    // 检查是否正在请求
    if (_pending.containsKey(url)) {
      return _pending[url];
    }

    // 发起请求
    final future = _fetchPreview(url);
    _pending[url] = future;

    try {
      final result = await future;
      // 存入缓存
      if (result != null) {
        _addToCache(url, result);
      }
      return result;
    } finally {
      _pending.remove(url);
    }
  }

  /// 检查 URL 是否指向私有/内网地址，防止 SSRF 攻击
  bool _isPrivateUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final host = uri.host.toLowerCase();

      // 检查 scheme，只允许 http/https
      if (uri.scheme != 'http' && uri.scheme != 'https') return true;

      // 检查 localhost
      if (host == 'localhost' || host == '127.0.0.1' || host == '::1') {
        return true;
      }

      // 检查保留域名
      if (host.endsWith('.local') || host.endsWith('.internal')) return true;

      // 检查私有 IPv4 地址段
      final parts = host.split('.');
      if (parts.length == 4) {
        final first = int.tryParse(parts[0]);
        final second = int.tryParse(parts[1]);
        if (first == 10) return true; // 10.0.0.0/8
        if (first == 172 && second != null && second >= 16 && second <= 31) {
          return true; // 172.16.0.0/12
        }
        if (first == 192 && second == 168) return true; // 192.168.0.0/16
        if (first == 169 && second == 254) return true; // 169.254.0.0/16 link-local
        if (first == 0) return true; // 0.0.0.0/8
      }

      // 检查 IPv6 私有地址
      if (host.startsWith('fe80:') || // link-local
          host.startsWith('fc') || // unique local (fc00::/7)
          host.startsWith('fd')) {
        return true;
      }

      return false;
    } catch (_) {
      return true; // 解析失败视为私有地址，拒绝请求
    }
  }

  Future<UrlPreviewData?> _fetchPreview(String url) async {
    // SSRF 防护：拒绝对私有/内网地址的请求
    if (_isPrivateUrl(url)) return null;

    try {
      final uri = Uri.parse(url);
      final request = http.Request('GET', uri);
      request.headers['User-Agent'] = 'Mozilla/5.0 (compatible; N42Bot/1.0)';
      request.headers['Range'] = 'bytes=0-51200'; // 限 50KB

      final client = http.Client();
      try {
        final response = await client.send(request).timeout(
          const Duration(seconds: 5),
        );

        if (response.statusCode != 200 && response.statusCode != 206) {
          return null;
        }

        final body = await response.stream.bytesToString();
        return _parseHtml(url, body);
      } finally {
        client.close();
      }
    } catch (e) {
      debugPrint('UrlPreviewService: Failed to fetch preview for $url: $e');
      return null;
    }
  }

  UrlPreviewData? _parseHtml(String url, String html) {
    String? title;
    String? description;
    String? imageUrl;
    String? siteName;

    // 解析 og:* meta 标签
    final metaRegex = RegExp(
      r'<meta\s+[^>]*(?:property|name)\s*=\s*"([^"]*)"[^>]*content\s*=\s*"([^"]*)"[^>]*/?>',
      caseSensitive: false,
    );
    // 也匹配 content 在前的情况
    final metaRegex2 = RegExp(
      r'<meta\s+[^>]*content\s*=\s*"([^"]*)"[^>]*(?:property|name)\s*=\s*"([^"]*)"[^>]*/?>',
      caseSensitive: false,
    );

    for (final match in metaRegex.allMatches(html)) {
      final prop = match.group(1)?.toLowerCase();
      final content = match.group(2);
      _setProperty(prop, content, (t) => title = t, (d) => description = d,
          (i) => imageUrl = i, (s) => siteName = s);
    }

    for (final match in metaRegex2.allMatches(html)) {
      final content = match.group(1);
      final prop = match.group(2)?.toLowerCase();
      _setProperty(prop, content, (t) => title ??= t, (d) => description ??= d,
          (i) => imageUrl ??= i, (s) => siteName ??= s);
    }

    // 回退到 <title> 标签
    if (title == null) {
      final titleMatch = RegExp(r'<title[^>]*>([^<]+)</title>', caseSensitive: false)
          .firstMatch(html);
      title = titleMatch?.group(1)?.trim();
    }

    if (title == null && description == null) return null;

    // 处理相对 URL
    final baseUri = Uri.parse(url);
    if (imageUrl != null && !imageUrl!.startsWith('http')) {
      imageUrl = baseUri.resolve(imageUrl!).toString();
    }

    return UrlPreviewData(
      url: url,
      title: title,
      description: description,
      imageUrl: imageUrl,
      siteName: siteName,
      faviconUrl: '${baseUri.scheme}://${baseUri.host}/favicon.ico',
    );
  }

  void _setProperty(
    String? prop,
    String? content,
    void Function(String) setTitle,
    void Function(String) setDescription,
    void Function(String) setImage,
    void Function(String) setSiteName,
  ) {
    if (prop == null || content == null) return;
    switch (prop) {
      case 'og:title':
      case 'twitter:title':
        setTitle(content);
        break;
      case 'og:description':
      case 'twitter:description':
      case 'description':
        setDescription(content);
        break;
      case 'og:image':
      case 'twitter:image':
        setImage(content);
        break;
      case 'og:site_name':
        setSiteName(content);
        break;
    }
  }

  void _addToCache(String url, UrlPreviewData data) {
    if (_cache.length >= _maxCacheSize) {
      _cache.remove(_cache.keys.first);
    }
    _cache[url] = _CachedPreview(data: data, cachedAt: DateTime.now());
  }

  /// 从文本中提取第一个 URL
  static String? extractFirstUrl(String text) {
    final regex = RegExp(
      r'https?://[^\s<>\[\](){}"\u4e00-\u9fff]+',
      caseSensitive: false,
    );
    final match = regex.firstMatch(text);
    return match?.group(0);
  }

  /// 清除缓存
  void clearCache() {
    _cache.clear();
  }
}

class _CachedPreview {
  final UrlPreviewData data;
  final DateTime cachedAt;

  _CachedPreview({required this.data, required this.cachedAt});

  bool get isExpired =>
      DateTime.now().difference(cachedAt) > UrlPreviewService._cacheTtl;
}
