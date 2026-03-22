import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/datasources/local/preferences_datasource.dart';
import 'translation_service.dart';
import '../utils/debug_log.dart';

/// MyMemory 免费翻译服务实现
///
/// API: https://api.mymemory.translated.net/get?q={text}&langpair={source}|{target}
/// 免费、无需 API key，每日 5000 字符限额。
/// 作为 Google Translate / AI Translation 不可用时的最终 fallback。
class MyMemoryTranslationService with TranslationServiceMixin {
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
    final cacheKey = generateCacheKey(text);
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
      debugLog('MyMemoryTranslationService: Translation error: $e');
      return TranslationResult.error('Translation failed: $e');
    }
  }
}
