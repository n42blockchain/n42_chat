import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/utils/payment_request_uri.dart';

void main() {
  test('accepts the payment QR emitted by the host wallet bridge', () {
    final value = PaymentRequestUri.tryParse(
      'n42://pay?address=0xABC&amount=0.11&token=ETH&memo=Lunch',
    );
    expect(value?.receiverAddress, '0xABC');
    expect(value?.amount, '0.11');
    expect(value?.token, 'ETH');
    expect(value?.memo, 'Lunch');
    expect(PaymentRequestUri.tryParse('n42://profile?address=0xABC'), isNull);
    expect(PaymentRequestUri.tryParse('n42://pay?to=0xABC'), isNull);
  });
  group('encode/parse round-trip', () {
    test('full data round-trips', () {
      const data = PaymentRequestData(
        receiverAddress: ' 0xABC123 ',
        amount: '12.5',
        token: 'USDT',
        memo: 'order #42',
        chain: 'n42',
      );
      final encoded = PaymentRequestUri.encode(data);
      expect(PaymentRequestUri.isPaymentUri(encoded), isTrue);
      final parsed = PaymentRequestUri.tryParse(encoded);
      expect(parsed?.receiverAddress, '0xABC123');
      expect(parsed?.amount, data.amount);
      expect(parsed?.token, data.token);
      expect(parsed?.memo, data.memo);
      expect(parsed?.chain, data.chain);
    });

    test('open amount (no amount) round-trips', () {
      const data = PaymentRequestData(receiverAddress: '0xABC', token: 'ETH');
      final parsed = PaymentRequestUri.tryParse(PaymentRequestUri.encode(data));
      expect(parsed?.receiverAddress, '0xABC');
      expect(parsed?.hasAmount, isFalse);
      expect(parsed?.token, 'ETH');
    });

    test('memo with special characters survives url encoding', () {
      const data = PaymentRequestData(
        receiverAddress: '0x1',
        amount: '1',
        token: 'N42',
        memo: 'a & b = c? 你好',
      );
      final parsed = PaymentRequestUri.tryParse(PaymentRequestUri.encode(data));
      expect(parsed?.memo, 'a & b = c? 你好');
    });
  });

  group('tryParse', () {
    test('returns null for non-payment scheme', () {
      expect(PaymentRequestUri.tryParse('https://example.com'), isNull);
      expect(PaymentRequestUri.tryParse('n42chat://user/@a:b'), isNull);
    });

    test('returns null for wrong host or path', () {
      expect(PaymentRequestUri.tryParse('n42pay://evil?to=0x1'), isNull);
      expect(PaymentRequestUri.tryParse('n42pay://pay/extra?to=0x1'), isNull);
    });

    test('returns null when receiver address missing', () {
      expect(
        PaymentRequestUri.tryParse('n42pay://pay?amount=1&token=ETH'),
        isNull,
      );
    });

    test('returns null for blank/garbage', () {
      expect(PaymentRequestUri.tryParse(''), isNull);
      expect(PaymentRequestUri.tryParse('   '), isNull);
    });

    test('parses real-world uri string', () {
      final parsed = PaymentRequestUri.tryParse(
        'n42pay://pay?to=0xdead&amount=9&token=USDC',
      );
      expect(parsed?.receiverAddress, '0xdead');
      expect(parsed?.amount, '9');
      expect(parsed?.token, 'USDC');
      expect(parsed?.memo, isNull);
    });
  });

  group('isPaymentUri', () {
    test('matches scheme case-insensitively', () {
      expect(PaymentRequestUri.isPaymentUri('N42PAY://pay?to=0x1'), isTrue);
      expect(PaymentRequestUri.isPaymentUri('n42pay://pay?to=0x1'), isTrue);
      expect(PaymentRequestUri.isPaymentUri('other://x'), isFalse);
    });

    test('rejects malformed payment-like uri', () {
      expect(PaymentRequestUri.isPaymentUri('n42pay://evil?to=0x1'), isFalse);
      expect(PaymentRequestUri.isPaymentUri('n42pay://pay?amount=1'), isFalse);
    });
  });

  group('versioned exact payment URI', () {
    test(
      'parses the current host v1 token request without losing amount text',
      () {
        final parsed = PaymentRequestUri.tryParseExact(
          'n42pay://v1/pay?chain=ETH&network=testnet&type=token&to=0xreceiver'
          '&contract=0xABCDEF0123456789ABCDEF0123456789ABCDEF01'
          '&amount=9007199254.123456',
        );

        expect(parsed?.receiverAddress, '0xreceiver');
        expect(parsed?.chain, 'ETH');
        expect(parsed?.network, 'testnet');
        expect(parsed?.assetType, 'token');
        expect(parsed?.assetId, '0xABCDEF0123456789ABCDEF0123456789ABCDEF01');
        expect(parsed?.amount, '9007199254.123456');
        expect(parsed?.token, isEmpty);
        expect(parsed?.memo, isNull);
        expect(parsed?.hasExactIdentity, isTrue);
      },
    );

    test('encodes only host-accepted keys and round-trips native identity', () {
      const request = PaymentRequestData(
        receiverAddress: 'N42Receiver',
        chain: 'N',
        network: 'mainnet',
        assetType: 'native',
      );

      final encoded = PaymentRequestUri.encode(request);
      expect(
        encoded,
        'n42pay://v1/pay?chain=N&network=mainnet&type=native&to=N42Receiver',
      );
      expect(PaymentRequestUri.tryParseExact(encoded), request);
      expect(PaymentRequestUri.tryParse(encoded), isNull);
    });

    test(
      'encodes host token identity with percent-escaped receiver and ID',
      () {
        const request = PaymentRequestData(
          receiverAddress: 'wallet&one',
          chain: 'SOL',
          network: 'testnet',
          assetType: 'token',
          assetId: 'Mint+One',
          amount: '0.25',
        );

        final encoded = PaymentRequestUri.encode(request);
        expect(encoded, contains('to=wallet%26one'));
        expect(encoded, contains('contract=Mint%2BOne'));
        expect(PaymentRequestUri.tryParseExact(encoded), request);
      },
    );

    test('rejects unknown versions, keys, repeated keys and malformed escapes', () {
      for (final uri in [
        'n42pay://v2/pay?chain=N&network=mainnet&type=native&to=addr',
        'n42pay://v1/pay?chain=N&network=mainnet&type=native&to=addr&memo=x',
        'n42pay://v1/pay?chain=N&chain=ETH&network=mainnet&type=native&to=addr',
        'n42pay://v1/pay?chain=N&%63hain=ETH&network=mainnet&type=native&to=addr',
        'n42pay://v1/pay?chain=N&network=mainnet&type=native&to=%zz',
        'n42pay://v1/pay?chain=N&network=mainnet&type=native&to=addr%2',
        'n42pay://user@v1/pay?chain=N&network=mainnet&type=native&to=addr',
        'n42pay://v1:44/pay?chain=N&network=mainnet&type=native&to=addr',
        'n42pay://v1/pay?chain=N&network=mainnet&type=native&to=addr#frag',
      ]) {
        expect(PaymentRequestUri.tryParseExact(uri), isNull, reason: uri);
      }
    });

    test('rejects partial identity and native-contract confusion', () {
      for (final uri in [
        'n42pay://v1/pay?network=mainnet&type=native&to=addr',
        'n42pay://v1/pay?chain=N&type=native&to=addr',
        'n42pay://v1/pay?chain=N&network=mainnet&to=addr',
        'n42pay://v1/pay?chain=N&network=mainnet&type=token&to=addr',
        'n42pay://v1/pay?chain=N&network=mainnet&type=native&to=addr&contract=mint',
        'n42pay://v1/pay?chain=N&network=devnet&type=native&to=addr',
      ]) {
        expect(PaymentRequestUri.tryParseExact(uri), isNull, reason: uri);
      }
    });

    test('rejects malformed, zero, negative and non-decimal v1 amounts', () {
      for (final amount in [
        '0',
        '0.000',
        '-1',
        '+1',
        '1e2',
        '1,000',
        '1.',
        '.5',
      ]) {
        expect(
          PaymentRequestUri.tryParseExact(
            'n42pay://v1/pay?chain=N&network=mainnet&type=native'
            '&to=addr&amount=$amount',
          ),
          isNull,
          reason: amount,
        );
      }
    });

    test(
      'rejects incomplete or extended v1 encoding instead of dropping data',
      () {
        expect(
          () => PaymentRequestUri.encode(
            const PaymentRequestData(
              receiverAddress: 'addr',
              chain: 'ETH',
              network: 'mainnet',
            ),
          ),
          throwsArgumentError,
        );
        expect(
          () => PaymentRequestUri.encode(
            const PaymentRequestData(
              receiverAddress: 'addr',
              chain: 'ETH',
              network: 'mainnet',
              assetType: 'native',
              token: 'ETH',
            ),
          ),
          throwsArgumentError,
        );
      },
    );

    test('legacy chain-only requests keep their existing route', () {
      const request = PaymentRequestData(
        receiverAddress: 'addr',
        token: 'ETH',
        chain: 'ETH',
      );
      final encoded = PaymentRequestUri.encode(request);
      expect(encoded, startsWith('n42pay://pay?'));
      expect(PaymentRequestUri.tryParse(encoded), request);
      expect(PaymentRequestUri.tryParseExact(encoded), isNull);
    });

    test('legacy parser rejects v1 and partial identity hints', () {
      expect(
        PaymentRequestUri.tryParse(
          'n42pay://v1/pay?chain=ETH&network=mainnet&type=native&to=addr',
        ),
        isNull,
      );
      expect(
        PaymentRequestUri.tryParse('n42pay://pay?to=addr&network=mainnet'),
        isNull,
      );
      expect(
        PaymentRequestUri.tryParse('n42pay://pay?to=addr&to=other'),
        isNull,
      );
    });
  });
}
