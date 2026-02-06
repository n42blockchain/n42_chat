import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/local/secure_storage_datasource.dart';

/// 翻译服务接口
abstract class ITranslationService {
  /// 翻译文本
  Future<TranslationResult> translate({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  });

  /// 检测语言
  Future<String?> detectLanguage(String text);

  /// 获取支持的语言列表
  List<TranslationLanguage> getSupportedLanguages();
}

/// 翻译结果
class TranslationResult {
  /// 翻译后的文本
  final String translatedText;

  /// 检测到的源语言
  final String? detectedSourceLanguage;

  /// 目标语言
  final String targetLanguage;

  /// 是否成功
  final bool success;

  /// 错误信息
  final String? error;

  const TranslationResult({
    required this.translatedText,
    this.detectedSourceLanguage,
    required this.targetLanguage,
    this.success = true,
    this.error,
  });

  factory TranslationResult.error(String error) {
    return TranslationResult(
      translatedText: '',
      targetLanguage: '',
      success: false,
      error: error,
    );
  }
}

/// 支持的翻译语言
class TranslationLanguage {
  /// 语言代码
  final String code;

  /// 语言名称
  final String name;

  /// 本地化名称
  final String localizedName;

  const TranslationLanguage({
    required this.code,
    required this.name,
    required this.localizedName,
  });
}

/// Google 翻译服务实现
class GoogleTranslationService implements ITranslationService {
  final String? apiKey;
  final SecureStorageDataSource _storageDataSource;

  GoogleTranslationService({
    this.apiKey,
    required SecureStorageDataSource storageDataSource,
  }) : _storageDataSource = storageDataSource;

  static const String _baseUrl =
      'https://translation.googleapis.com/language/translate/v2';

  @override
  Future<TranslationResult> translate({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  }) async {
    // 首先检查缓存
    final cachedTranslation = await _storageDataSource.getTranslationCache(
      _generateCacheKey(text),
      targetLanguage,
    );
    if (cachedTranslation != null) {
      return TranslationResult(
        translatedText: cachedTranslation,
        detectedSourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      );
    }

    // 如果没有 API Key，使用模拟翻译
    if (apiKey == null || apiKey!.isEmpty) {
      return _mockTranslate(text, targetLanguage, sourceLanguage);
    }

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'q': text,
          'target': targetLanguage,
          if (sourceLanguage != null) 'source': sourceLanguage,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translations = data['data']['translations'] as List;
        if (translations.isNotEmpty) {
          final translation = translations.first;
          final translatedText = translation['translatedText'] as String;
          final detectedSource =
              translation['detectedSourceLanguage'] as String?;

          // 保存到缓存
          await _storageDataSource.saveTranslationCache(
            _generateCacheKey(text),
            targetLanguage,
            translatedText,
          );

          return TranslationResult(
            translatedText: translatedText,
            detectedSourceLanguage: detectedSource ?? sourceLanguage,
            targetLanguage: targetLanguage,
          );
        }
      }

      return TranslationResult.error('Translation failed: ${response.statusCode}');
    } catch (e) {
      debugPrint('Translation error: $e');
      return TranslationResult.error('Translation failed: $e');
    }
  }

  /// 模拟翻译（用于开发和测试）
  Future<TranslationResult> _mockTranslate(
    String text,
    String targetLanguage,
    String? sourceLanguage,
  ) async {
    // 简单的模拟：添加翻译标记
    await Future<void>.delayed(const Duration(milliseconds: 500));

    String translatedText;
    String detectedSource;

    // 检测是否包含中文字符
    final containsChinese = RegExp(r'[\u4e00-\u9fff]').hasMatch(text);

    if (containsChinese && targetLanguage == 'en') {
      // 中文翻译成英文（模拟）
      translatedText = '[EN] $text';
      detectedSource = 'zh';
    } else if (!containsChinese && targetLanguage == 'zh') {
      // 英文翻译成中文（模拟）
      translatedText = '[中文] $text';
      detectedSource = 'en';
    } else {
      // 其他情况
      translatedText = '[$targetLanguage] $text';
      detectedSource = sourceLanguage ?? 'auto';
    }

    // 保存到缓存
    await _storageDataSource.saveTranslationCache(
      _generateCacheKey(text),
      targetLanguage,
      translatedText,
    );

    return TranslationResult(
      translatedText: translatedText,
      detectedSourceLanguage: detectedSource,
      targetLanguage: targetLanguage,
    );
  }

  String _generateCacheKey(String text) {
    // 使用文本的哈希作为缓存键
    return text.hashCode.toString();
  }

  @override
  Future<String?> detectLanguage(String text) async {
    // 简单的语言检测
    final containsChinese = RegExp(r'[\u4e00-\u9fff]').hasMatch(text);
    final containsJapanese = RegExp(r'[\u3040-\u309f\u30a0-\u30ff]').hasMatch(text);
    final containsKorean = RegExp(r'[\uac00-\ud7af]').hasMatch(text);

    if (containsChinese) return 'zh';
    if (containsJapanese) return 'ja';
    if (containsKorean) return 'ko';

    // 默认假设是英文
    return 'en';
  }

  @override
  List<TranslationLanguage> getSupportedLanguages() {
    return const [
      TranslationLanguage(code: 'zh', name: 'Chinese', localizedName: '中文'),
      TranslationLanguage(code: 'en', name: 'English', localizedName: 'English'),
      TranslationLanguage(code: 'ja', name: 'Japanese', localizedName: '日本語'),
      TranslationLanguage(code: 'ko', name: 'Korean', localizedName: '한국어'),
      TranslationLanguage(code: 'fr', name: 'French', localizedName: 'Français'),
      TranslationLanguage(code: 'de', name: 'German', localizedName: 'Deutsch'),
      TranslationLanguage(code: 'es', name: 'Spanish', localizedName: 'Español'),
      TranslationLanguage(code: 'pt', name: 'Portuguese', localizedName: 'Português'),
      TranslationLanguage(code: 'ru', name: 'Russian', localizedName: 'Русский'),
      TranslationLanguage(code: 'ar', name: 'Arabic', localizedName: 'العربية'),
    ];
  }
}

/// 获取设备语言代码
String getDeviceLanguageCode() {
  final locale = PlatformDispatcher.instance.locale;
  return locale.languageCode;
}

/// 获取翻译目标语言（基于设备语言）
String getTargetLanguage(String? sourceLanguage) {
  final deviceLang = getDeviceLanguageCode();

  // 如果源语言和设备语言相同，翻译成英文
  if (sourceLanguage == deviceLang) {
    return deviceLang == 'en' ? 'zh' : 'en';
  }

  return deviceLang;
}
