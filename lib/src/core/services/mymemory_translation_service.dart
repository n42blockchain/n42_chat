import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/local/preferences_datasource.dart';
import 'translation_service.dart';

/// MyMemory 免费翻译服务实现
///
/// API: https://api.mymemory.translated.net/get?q={text}&langpair={source}|{target}
/// 免费、无需 API key，每日 5000 字符限额。
/// 作为 Google Translate / AI Translation 不可用时的最终 fallback。
class MyMemoryTranslationService implements ITranslationService {
  final PreferencesDataSource _storageDataSource;

  static const String _baseUrl =
      'https://api.mymemory.translated.net/get';

  MyMemoryTranslationService({
    required PreferencesDataSource storageDataSource,
  }) : _storageDataSource = storageDataSource;

  @override
  Future<TranslationResult> translate({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  }) async {
    // Check cache first
    final cacheKey = _generateCacheKey(text);
    final cached = await _storageDataSource.getTranslationCache(
      cacheKey,
      targetLanguage,
    );
    if (cached != null) {
      return TranslationResult(
        translatedText: cached,
        detectedSourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      );
    }

    try {
      final source = sourceLanguage ?? (await detectLanguage(text)) ?? 'en';
      final uri = Uri.parse(_baseUrl).replace(queryParameters: {
        'q': text,
        'langpair': '$source|$targetLanguage',
      });

      final response = await http.get(uri).timeout(
            const Duration(seconds: 8),
            onTimeout: () => http.Response('', 408),
          );

      if (response.statusCode != 200) {
        return TranslationResult.error(
          'MyMemory: HTTP ${response.statusCode}',
        );
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final responseData = data['responseData'] as Map<String, dynamic>?;
      if (responseData == null) {
        return TranslationResult.error('MyMemory: invalid response');
      }

      final translatedText =
          responseData['translatedText']?.toString() ?? '';
      if (translatedText.isEmpty) {
        return TranslationResult.error('MyMemory: empty translation');
      }

      // Save to cache
      await _storageDataSource.saveTranslationCache(
        cacheKey,
        targetLanguage,
        translatedText,
      );

      final detectedLang =
          responseData['detectedLanguage']?.toString() ?? source;

      return TranslationResult(
        translatedText: translatedText,
        detectedSourceLanguage: detectedLang,
        targetLanguage: targetLanguage,
      );
    } catch (e) {
      debugPrint('MyMemoryTranslationService: Translation error: $e');
      return TranslationResult.error('Translation failed: $e');
    }
  }

  String _generateCacheKey(String text) {
    return sha256.convert(utf8.encode(text)).toString().substring(0, 16);
  }

  @override
  Future<String?> detectLanguage(String text) async {
    final containsChinese = RegExp(r'[\u4e00-\u9fff]').hasMatch(text);
    final containsJapanese =
        RegExp(r'[\u3040-\u309f\u30a0-\u30ff]').hasMatch(text);
    final containsKorean = RegExp(r'[\uac00-\ud7af]').hasMatch(text);

    if (containsChinese) return 'zh';
    if (containsJapanese) return 'ja';
    if (containsKorean) return 'ko';
    return 'en';
  }

  @override
  List<TranslationLanguage> getSupportedLanguages() {
    return const [
      TranslationLanguage(code: 'zh', name: 'Chinese', localizedName: '中文'),
      TranslationLanguage(
          code: 'en', name: 'English', localizedName: 'English'),
      TranslationLanguage(
          code: 'ja', name: 'Japanese', localizedName: '日本語'),
      TranslationLanguage(
          code: 'ko', name: 'Korean', localizedName: '한국어'),
      TranslationLanguage(
          code: 'fr', name: 'French', localizedName: 'Français'),
      TranslationLanguage(
          code: 'de', name: 'German', localizedName: 'Deutsch'),
      TranslationLanguage(
          code: 'es', name: 'Spanish', localizedName: 'Español'),
      TranslationLanguage(
          code: 'pt', name: 'Portuguese', localizedName: 'Português'),
      TranslationLanguage(
          code: 'ru', name: 'Russian', localizedName: 'Русский'),
      TranslationLanguage(
          code: 'ar', name: 'Arabic', localizedName: 'العربية'),
    ];
  }
}
