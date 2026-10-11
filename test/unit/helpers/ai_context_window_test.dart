import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/presentation/helpers/ai_context_window.dart';

void main() {
  test('consent expires at two minutes, including time in the dialog', () {
    var elapsed = Duration.zero;
    final window = AiContextWindow(elapsed: () => elapsed);
    expect(window.isValid, isTrue);
    elapsed = const Duration(minutes: 2) - const Duration(microseconds: 1);
    expect(window.isValid, isTrue);
    elapsed = const Duration(minutes: 2);
    expect(window.isValid, isFalse);
    elapsed = const Duration(minutes: 3);
    expect(window.isValid, isFalse);
  });

  test('revocation permanently rejects a pending result', () {
    final window = AiContextWindow(elapsed: () => Duration.zero);
    expect(window.isValid, isTrue);
    window.revoke();
    expect(window.isValid, isFalse);
    window.revoke();
    expect(window.isValid, isFalse);
    expect(AiContextWindow().isValid, isTrue);
  });

  test('a fresh window starts valid with the monotonic clock', () {
    expect(AiContextWindow().isValid, isTrue);
  });
}
