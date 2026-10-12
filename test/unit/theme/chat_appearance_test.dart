import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/theme/chat_appearance.dart';

class _NonlinearScaler extends TextScaler {
  const _NonlinearScaler();
  @override
  double scale(double size) => size < 20 ? size * 3 : size * 2;
  @override
  double get textScaleFactor => 3;
}

void main() {
  test('chat preserves host custom colors and component themes', () {
    const custom = Color(0xFF8B5CF6);
    final host = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: custom),
      scaffoldBackgroundColor: const Color(0xFF010203),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 17, letterSpacing: -0.41),
      ),
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(44, 44))),
      ),
    );
    final chat = buildChatAppearanceTheme(host);
    expect(chat.scaffoldBackgroundColor, host.scaffoldBackgroundColor);
    expect(chat.colorScheme, host.colorScheme);
    expect(chat.textTheme, host.textTheme);
    expect(chat.filledButtonTheme, host.filledButtonTheme);
    expect(chat.appBarTheme.toolbarHeight, 44);
  });

  test('OS accessibility scales are neither reduced nor capped', () {
    for (final scale in [1.0, 1.6, 2.0, 3.0]) {
      final scaler = ChatPreferenceTextScaler(TextScaler.linear(scale), 1);
      expect(scaler.scale(17), 17 * scale);
    }
  });

  test('chat preference preserves the shape of nonlinear OS scaling', () {
    const scaler = ChatPreferenceTextScaler(_NonlinearScaler(), 1.12);
    expect(scaler.scale(17), 51 * 1.12);
    expect(scaler.scale(28), 56 * 1.12);
  });
}
