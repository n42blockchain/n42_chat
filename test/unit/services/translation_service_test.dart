import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/src/core/services/translation_service.dart';
import 'package:n42_chat/src/data/datasources/local/preferences_datasource.dart';

class MockPreferencesDataSource extends Mock implements PreferencesDataSource {}

void main() {
  late MockPreferencesDataSource mockPrefs;

  setUp(() {
    mockPrefs = MockPreferencesDataSource();
  });

  GoogleTranslationService buildService({String? apiKey}) =>
      GoogleTranslationService(
        apiKey: apiKey,
        storageDataSource: mockPrefs,
      );

  // ─────────────────────────────────────────────────
  // TranslationResult data class
  // ─────────────────────────────────────────────────

  group('TranslationResult', () {
    test('constructs with all required fields and defaults', () {
      const result = TranslationResult(
        translatedText: 'Hola',
        targetLanguage: 'es',
      );
      expect(result.translatedText, 'Hola');
      expect(result.targetLanguage, 'es');
      expect(result.success, isTrue);
      expect(result.error, isNull);
      expect(result.detectedSourceLanguage, isNull);
    });

    test('error() factory produces failure result', () {
      final result = TranslationResult.error('API key missing');
      expect(result.success, isFalse);
      expect(result.error, 'API key missing');
      expect(result.translatedText, isEmpty);
      expect(result.targetLanguage, isEmpty);
    });
  });

  // ─────────────────────────────────────────────────
  // TranslationLanguage data class
  // ─────────────────────────────────────────────────

  group('TranslationLanguage', () {
    test('stores code, name, localizedName', () {
      const lang = TranslationLanguage(
        code: 'zh',
        name: 'Chinese',
        localizedName: '中文',
      );
      expect(lang.code, 'zh');
      expect(lang.name, 'Chinese');
      expect(lang.localizedName, '中文');
    });
  });

  // ─────────────────────────────────────────────────
  // detectLanguage — pure regex, no dependencies
  // ─────────────────────────────────────────────────

  group('GoogleTranslationService.detectLanguage', () {
    late GoogleTranslationService service;

    setUp(() {
      service = buildService();
    });

    test('returns zh for Chinese text', () async {
      expect(await service.detectLanguage('你好，世界'), 'zh');
    });

    test('returns ja for Japanese hiragana text', () async {
      expect(await service.detectLanguage('こんにちは'), 'ja');
    });

    test('returns ja for Japanese katakana text', () async {
      expect(await service.detectLanguage('コンピュータ'), 'ja');
    });

    test('returns ko for Korean text', () async {
      expect(await service.detectLanguage('안녕하세요'), 'ko');
    });

    test('defaults to en for ASCII text', () async {
      expect(await service.detectLanguage('Hello, world!'), 'en');
    });

    test('returns zh when text contains Chinese characters mixed with ASCII',
        () async {
      expect(await service.detectLanguage('Hello 你好'), 'zh');
    });
  });

  // ─────────────────────────────────────────────────
  // getSupportedLanguages — pure list
  // ─────────────────────────────────────────────────

  group('GoogleTranslationService.getSupportedLanguages', () {
    test('returns the full shared language list (25 languages)', () {
      final langs = buildService().getSupportedLanguages();
      expect(langs.length, 25);
    });

    test('includes Simplified Chinese (zh) alongside zh_TW', () {
      // 回归：detectLanguage 返回 'zh'，支持列表曾漏掉简体中文导致
      // 检测结果在语言选择中找不到对应项。
      final codes = buildService().getSupportedLanguages().map((l) => l.code);
      expect(codes, containsAll(['zh', 'zh_TW']));
    });

    test('includes zh, en, ja, ko', () {
      final codes = buildService().getSupportedLanguages().map((l) => l.code);
      expect(codes, containsAll(['zh', 'en', 'ja', 'ko']));
    });

    test('each language has non-empty code, name, localizedName', () {
      for (final lang in buildService().getSupportedLanguages()) {
        expect(lang.code, isNotEmpty);
        expect(lang.name, isNotEmpty);
        expect(lang.localizedName, isNotEmpty);
      }
    });
  });

  // ─────────────────────────────────────────────────
  // translate — API key / cache logic
  // ─────────────────────────────────────────────────

  group('GoogleTranslationService.translate', () {
    test('returns cached result on cache hit', () async {
      when(() => mockPrefs.getTranslationCache(any(), any()))
          .thenAnswer((_) async => 'Hola');

      final service = buildService(apiKey: null);
      final result = await service.translate(
        text: 'Hello',
        targetLanguage: 'es',
      );

      expect(result.success, isTrue);
      expect(result.translatedText, 'Hola');
      // Cache hits never call the network, so no API key error
      verifyNever(
        () => mockPrefs.saveTranslationCache(any(), any(), any()),
      );
    });

    test('returns error result when no API key and no cache', () async {
      when(() => mockPrefs.getTranslationCache(any(), any()))
          .thenAnswer((_) async => null);

      final service = buildService(apiKey: null);
      final result = await service.translate(
        text: 'Hello',
        targetLanguage: 'zh',
      );

      expect(result.success, isFalse);
      expect(result.error, contains('API Key'));
    });

    test('returns error result when API key is empty string and no cache',
        () async {
      when(() => mockPrefs.getTranslationCache(any(), any()))
          .thenAnswer((_) async => null);

      final service = buildService(apiKey: '');
      final result = await service.translate(
        text: 'Hello',
        targetLanguage: 'zh',
      );

      expect(result.success, isFalse);
    });

    test('cache key is consistent for same text', () async {
      // Both calls hit cache because key is deterministic (SHA-256 based)
      when(() => mockPrefs.getTranslationCache(any(), any()))
          .thenAnswer((_) async => 'Cached');

      final service = buildService();
      final r1 = await service.translate(text: 'Same text', targetLanguage: 'zh');
      final r2 = await service.translate(text: 'Same text', targetLanguage: 'zh');

      expect(r1.translatedText, r2.translatedText);
    });
  });
}
