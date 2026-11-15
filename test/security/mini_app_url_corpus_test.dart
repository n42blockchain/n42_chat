import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/services/mini_app_bridge_service.dart';
import 'package:n42_chat/src/core/utils/secure_uri.dart';

void main() {
  const host = 'shop.n42.world';
  final attacks = <String Function(int)>[
    (i) => 'http://$host/item/$i',
    (i) => 'javascript:alert($i)',
    (i) => 'https://$host.evil.test/$i',
    (i) => 'https://evil.test/$host/$i',
    (i) => 'https://user@$host/$i',
    (i) => 'https://@$host/$i',
    (i) => 'https://$host\\@evil.test/$i',
    (i) => 'https://$host/$i?x=1&x=2',
    (i) => 'https://$host/$i?x=1&%78=2',
    (i) => 'https://$host/$i?X=1&x=2',
    (i) => 'https://$host/$i?x=%252fadmin',
    (i) => 'https://$host/$i?x=%0d%0aAuthorization',
    (i) => 'https://$host/$i?redirect_uri=https://evil.test',
    (i) => 'https://$host/$i?access_token=secret',
    (i) => 'https://$host/%2fadmin/$i',
    (i) => 'https://$host/x/../$i',
    (i) => 'https://$host/x/%2e%2e/$i',
    (i) => 'https://$host./$i',
    (i) => 'https://$host:444/$i',
    (i) => 'https://$host/$i?x=%GG',
    (i) => 'https://$host/$i\n',
    (i) => 'https://%73hop.n42.world/$i',
    (i) => 'https://$host/$i?x=${'a' * 8192}',
    (i) => '//${host}/$i',
  ];
  for (var type = 0; type < attacks.length; type++) {
    for (var variant = 0; variant < 10; variant++) {
      test('reject URL attack family $type variant $variant', () {
        expect(
          isTrustedMiniAppNavigationUrl(
            appUrl: 'https://$host',
            candidateUrl: attacks[type](variant),
          ),
          isFalse,
        );
      });
    }
  }
  test('220 valid navigation samples are not blocked', () {
    for (var i = 0; i < 220; i++) {
      expect(
        isTrustedMiniAppNavigationUrl(
          appUrl: 'https://$host',
          candidateUrl:
              'https://$host/products/$i?lang=zh&name=%E4%B8%AD%E6%96%87',
        ),
        isTrue,
      );
    }
  });
  test('OAuth redirect must match complete endpoint and unique parameters', () {
    for (final endpoint in [
      'n42app://oauth/callback',
      'https://auth.n42.world/callback',
    ]) {
      expect(
        matchesOAuthRedirect('$endpoint?code=ok&state=nonce', endpoint),
        isTrue,
      );
      expect(
        matchesOAuthRedirect('$endpoint#tgAuthResult=abc', endpoint),
        isTrue,
      );
      for (final suffix in [
        '/evil?code=x',
        '.evil?code=x',
        '?code=x&code=y',
        '?state=x&%73tate=y',
        '?code=%250a',
      ]) {
        expect(matchesOAuthRedirect('$endpoint$suffix', endpoint), isFalse);
      }
    }
    expect(
      matchesOAuthRedirect(
        'https://auth.n42.world.evil/callback?code=x',
        'https://auth.n42.world/callback',
      ),
      isFalse,
    );
  });
}
