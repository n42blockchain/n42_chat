import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';

void main() {
  for (final code in ['ar', 'bn', 'hi', 'pl', 'ru', 'tr', 'ur']) {
    test('SSO configuration warning is localized in $code', () async {
      final translated = await S.delegate.load(Locale(code));
      final english = await S.delegate.load(const Locale('en'));
      expect(translated.authSsoNotConfigured.trim(), isNotEmpty);
      expect(
        translated.authSsoNotConfigured,
        isNot(english.authSsoNotConfigured),
      );
      expect(translated.authSsoNotConfigured, contains('SSO'));
    });
  }
}
