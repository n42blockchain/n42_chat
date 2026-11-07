import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';

import '../../../tool/local_e2ee_smoke.dart' as smoke;

void main() {
  test('server retry delay is preserved before retry succeeds', () async {
    var calls = 0;
    final waits = <Duration>[];
    final result = await smoke.retryRateLimited(
      () async {
        if (calls++ == 0) {
          throw MatrixException.fromJson({
            'errcode': 'M_LIMIT_EXCEEDED',
            'retry_after_ms': 75000,
          });
        }
        return 'done';
      },
      wait: (delay) async {
        waits.add(delay);
      },
    );
    expect(result, 'done');
    expect(calls, 2);
    expect(waits, [const Duration(seconds: 75)]);
  });
  test('authorization failure never retries', () async {
    var calls = 0;
    await expectLater(
      smoke.retryRateLimited(
        () async {
          calls++;
          throw MatrixException.fromJson({'errcode': 'M_FORBIDDEN'});
        },
        wait: (_) async {
          fail('Unexpected wait');
        },
      ),
      throwsA(isA<MatrixException>()),
    );
    expect(calls, 1);
  });
  test('rate-limit retries have a finite budget', () async {
    var calls = 0;
    var waits = 0;
    await expectLater(
      smoke.retryRateLimited(
        () async {
          calls++;
          throw MatrixException.fromJson({'errcode': 'M_LIMIT_EXCEEDED'});
        },
        maxRetries: 2,
        wait: (delay) async {
          expect(delay, const Duration(minutes: 1));
          waits++;
        },
      ),
      throwsA(isA<MatrixException>()),
    );
    expect(calls, 3);
    expect(waits, 2);
  });
}
