// Tests for UrlPreviewData and UrlPreviewService.extractFirstUrl.
// No network calls — only the pure-logic static method and the data class
// are tested here.  _isPrivateUrl and _fetchPreview are private and exercised
// indirectly; we test only the publicly accessible surface.

import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/services/url_preview_service.dart';

void main() {
  // ─────────────────────────────────────────────────
  // UrlPreviewData — pure data class
  // ─────────────────────────────────────────────────

  group('UrlPreviewData', () {
    test('required url field is set', () {
      const data = UrlPreviewData(url: 'https://example.com');
      expect(data.url, 'https://example.com');
    });

    test('optional fields default to null', () {
      const data = UrlPreviewData(url: 'https://example.com');
      expect(data.title, isNull);
      expect(data.description, isNull);
      expect(data.imageUrl, isNull);
      expect(data.siteName, isNull);
      expect(data.faviconUrl, isNull);
    });

    test('all fields can be set', () {
      const data = UrlPreviewData(
        url: 'https://example.com/article',
        title: 'Example Article',
        description: 'A description',
        imageUrl: 'https://example.com/img.png',
        siteName: 'Example Site',
        faviconUrl: 'https://example.com/favicon.ico',
      );
      expect(data.url, 'https://example.com/article');
      expect(data.title, 'Example Article');
      expect(data.description, 'A description');
      expect(data.imageUrl, 'https://example.com/img.png');
      expect(data.siteName, 'Example Site');
      expect(data.faviconUrl, 'https://example.com/favicon.ico');
    });
  });

  // ─────────────────────────────────────────────────
  // UrlPreviewService.extractFirstUrl — static, pure
  // ─────────────────────────────────────────────────

  group('UrlPreviewService.extractFirstUrl', () {
    test('extracts http URL from text', () {
      final url = UrlPreviewService.extractFirstUrl('visit http://example.com today');
      expect(url, 'http://example.com');
    });

    test('extracts https URL from text', () {
      final url = UrlPreviewService.extractFirstUrl('check https://example.com now');
      expect(url, 'https://example.com');
    });

    test('returns first URL when multiple URLs present', () {
      final url = UrlPreviewService.extractFirstUrl(
          'https://first.com and https://second.com');
      expect(url, 'https://first.com');
    });

    test('returns null when no URL present', () {
      expect(UrlPreviewService.extractFirstUrl('no links here'), isNull);
    });

    test('returns null for empty string', () {
      expect(UrlPreviewService.extractFirstUrl(''), isNull);
    });

    test('extracts URL with path', () {
      final url = UrlPreviewService.extractFirstUrl(
          'go to https://example.com/path/to/page');
      expect(url, 'https://example.com/path/to/page');
    });

    test('extracts URL with query parameters', () {
      final url = UrlPreviewService.extractFirstUrl(
          'see https://example.com/search?q=test&page=1 for results');
      expect(url, contains('https://example.com/search'));
    });

    test('URL stops at whitespace', () {
      final url =
          UrlPreviewService.extractFirstUrl('https://example.com next word');
      expect(url, 'https://example.com');
    });

    test('URL stops at Chinese character boundary', () {
      final url = UrlPreviewService.extractFirstUrl(
          'https://example.com/page 这是中文');
      expect(url, 'https://example.com/page');
    });

    test('URL at start of string is extracted', () {
      final url =
          UrlPreviewService.extractFirstUrl('https://example.com is a site');
      expect(url, 'https://example.com');
    });

    test('URL at end of string is extracted', () {
      final url =
          UrlPreviewService.extractFirstUrl('the link is https://example.com');
      expect(url, 'https://example.com');
    });

    test('bare URL with no surrounding text', () {
      final url = UrlPreviewService.extractFirstUrl('https://example.com');
      expect(url, 'https://example.com');
    });

    test('non-http scheme (ftp) is not extracted', () {
      final url = UrlPreviewService.extractFirstUrl('ftp://example.com/file');
      expect(url, isNull);
    });

    test('is case-insensitive for scheme', () {
      // The regex uses caseSensitive: false, so HTTP:// also matches
      final url = UrlPreviewService.extractFirstUrl('HTTP://example.com');
      expect(url, isNotNull);
    });
  });
}
