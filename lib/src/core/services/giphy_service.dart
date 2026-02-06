import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Giphy API 响应中的 GIF 数据
class GiphyGif {
  final String id;
  final String title;
  final String originalUrl;
  final String previewUrl;
  final int width;
  final int height;
  final int previewWidth;
  final int previewHeight;
  final String? mp4Url;

  const GiphyGif({
    required this.id,
    required this.title,
    required this.originalUrl,
    required this.previewUrl,
    required this.width,
    required this.height,
    required this.previewWidth,
    required this.previewHeight,
    this.mp4Url,
  });

  factory GiphyGif.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as Map<String, dynamic>;
    final original = images['original'] as Map<String, dynamic>;
    final fixedWidth = images['fixed_width'] as Map<String, dynamic>;
    final mp4 = images['original_mp4'] as Map<String, dynamic>?;

    return GiphyGif(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      originalUrl: original['url'] as String,
      previewUrl: fixedWidth['url'] as String,
      width: int.tryParse(original['width']?.toString() ?? '0') ?? 0,
      height: int.tryParse(original['height']?.toString() ?? '0') ?? 0,
      previewWidth: int.tryParse(fixedWidth['width']?.toString() ?? '0') ?? 0,
      previewHeight: int.tryParse(fixedWidth['height']?.toString() ?? '0') ?? 0,
      mp4Url: mp4?['mp4'] as String?,
    );
  }

  double get aspectRatio {
    if (height == 0) return 1.0;
    return width / height;
  }
}

/// Giphy 搜索结果
class GiphySearchResult {
  final List<GiphyGif> gifs;
  final int totalCount;
  final int offset;

  const GiphySearchResult({
    required this.gifs,
    required this.totalCount,
    required this.offset,
  });

  bool get hasMore => offset + gifs.length < totalCount;
}

/// Giphy API 服务
///
/// 提供 GIF 搜索和热门 GIF 获取功能
class GiphyService {
  /// Giphy API Key
  /// 注意：生产环境中应该使用环境变量或安全存储
  static const String _apiKey = 'YOUR_GIPHY_API_KEY';

  /// API Base URL
  static const String _baseUrl = 'https://api.giphy.com/v1/gifs';

  /// 每页数量
  static const int _pageSize = 25;

  final http.Client _client;

  GiphyService({http.Client? client}) : _client = client ?? http.Client();

  /// 搜索 GIF
  ///
  /// [query] 搜索关键词
  /// [offset] 分页偏移量
  /// [limit] 每页数量
  /// [rating] 内容评级 (g, pg, pg-13, r)
  /// [lang] 语言代码
  Future<GiphySearchResult> searchGifs({
    required String query,
    int offset = 0,
    int limit = _pageSize,
    String rating = 'g',
    String lang = 'en',
  }) async {
    if (query.trim().isEmpty) {
      return const GiphySearchResult(gifs: [], totalCount: 0, offset: 0);
    }

    try {
      final uri = Uri.parse('$_baseUrl/search').replace(
        queryParameters: {
          'api_key': _apiKey,
          'q': query,
          'limit': limit.toString(),
          'offset': offset.toString(),
          'rating': rating,
          'lang': lang,
        },
      );

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return _parseResponse(json, offset);
      } else {
        debugPrint('Giphy search failed: ${response.statusCode}');
        return GiphySearchResult(gifs: const [], totalCount: 0, offset: offset);
      }
    } catch (e) {
      debugPrint('Giphy search error: $e');
      return GiphySearchResult(gifs: const [], totalCount: 0, offset: offset);
    }
  }

  /// 获取热门 GIF
  ///
  /// [offset] 分页偏移量
  /// [limit] 每页数量
  /// [rating] 内容评级
  Future<GiphySearchResult> getTrendingGifs({
    int offset = 0,
    int limit = _pageSize,
    String rating = 'g',
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/trending').replace(
        queryParameters: {
          'api_key': _apiKey,
          'limit': limit.toString(),
          'offset': offset.toString(),
          'rating': rating,
        },
      );

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return _parseResponse(json, offset);
      } else {
        debugPrint('Giphy trending failed: ${response.statusCode}');
        return GiphySearchResult(gifs: const [], totalCount: 0, offset: offset);
      }
    } catch (e) {
      debugPrint('Giphy trending error: $e');
      return GiphySearchResult(gifs: const [], totalCount: 0, offset: offset);
    }
  }

  /// 通过 ID 获取 GIF
  Future<GiphyGif?> getGifById(String id) async {
    try {
      final uri = Uri.parse('$_baseUrl/$id').replace(
        queryParameters: {
          'api_key': _apiKey,
        },
      );

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final data = json['data'] as Map<String, dynamic>?;
        if (data != null) {
          return GiphyGif.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Giphy get by id error: $e');
      return null;
    }
  }

  /// 获取随机 GIF
  ///
  /// [tag] 可选的标签过滤
  Future<GiphyGif?> getRandomGif({String? tag}) async {
    try {
      final queryParams = <String, String>{
        'api_key': _apiKey,
        'rating': 'g',
      };
      if (tag != null && tag.isNotEmpty) {
        queryParams['tag'] = tag;
      }

      final uri = Uri.parse('$_baseUrl/random').replace(
        queryParameters: queryParams,
      );

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final data = json['data'] as Map<String, dynamic>?;
        if (data != null && data.isNotEmpty) {
          return GiphyGif.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Giphy random error: $e');
      return null;
    }
  }

  GiphySearchResult _parseResponse(Map<String, dynamic> json, int offset) {
    final data = json['data'] as List<dynamic>? ?? [];
    final pagination = json['pagination'] as Map<String, dynamic>? ?? {};

    final gifs = data
        .whereType<Map<String, dynamic>>()
        .map((item) => GiphyGif.fromJson(item))
        .toList();

    final totalCount = pagination['total_count'] as int? ?? 0;

    return GiphySearchResult(
      gifs: gifs,
      totalCount: totalCount,
      offset: offset,
    );
  }

  /// 释放资源
  void dispose() {
    _client.close();
  }
}
