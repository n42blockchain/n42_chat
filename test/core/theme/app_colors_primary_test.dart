import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/theme/app_colors.dart';
import 'package:n42_chat/src/core/theme/chat_contrast.dart';
import 'package:n42_chat/src/core/theme/n42_chat_theme.dart';

Future<Color> _primaryUnder(WidgetTester tester, ThemeData? theme) async {
  late Color resolved;
  await tester.pumpWidget(
    MaterialApp(
      theme: theme,
      home: Builder(
        builder: (context) {
          resolved = AppColors.primaryOf(context);
          return const SizedBox();
        },
      ),
    ),
  );
  return resolved;
}

void main() {
  testWidgets('follows the host accent', (tester) async {
    const accent = Color(0xFF5B6CFF);
    final resolved = await _primaryUnder(
      tester,
      ThemeData(colorScheme: const ColorScheme.light(primary: accent)),
    );
    expect(resolved, accent);
  });

  testWidgets('falls back to AppColors.primary without a host theme', (
    tester,
  ) async {
    expect(await _primaryUnder(tester, null), AppColors.primary);
    expect(
      await _primaryUnder(tester, ThemeData(brightness: Brightness.dark)),
      AppColors.primary,
    );
  });

  testWidgets('uses the chat fallback theme primary', (tester) async {
    expect(
      await _primaryUnder(tester, N42ChatTheme.wechatLight().toThemeData()),
      AppColors.primary,
    );
  });

  for (final dark in [false, true]) {
    testWidgets('primaryOnTintOf reaches 4.5:1 on brand tints (dark: $dark)', (
      tester,
    ) async {
      final theme = dark
          ? N42ChatTheme.wechatDark().toThemeData()
          : N42ChatTheme.wechatLight().toThemeData();
      late Color brand;
      late Color text;
      const bubble = Color(0xFF2C2C2E);
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Builder(
            builder: (context) {
              brand = AppColors.primaryOf(context);
              text = AppColors.primaryOnTintOf(
                context,
                over: dark ? bubble : null,
              );
              return const SizedBox();
            },
          ),
        ),
      );
      final surfaces = [
        theme.scaffoldBackgroundColor,
        theme.colorScheme.surface,
        if (dark) bubble,
      ];
      var plainFails = false;
      for (final surface in surfaces) {
        for (final alpha in [0.08, 0.1, 0.12, 0.15]) {
          final bg = Color.alphaBlend(brand.withValues(alpha: alpha), surface);
          expect(ChatContrast.ratio(text, bg), greaterThanOrEqualTo(4.5));
          if (ChatContrast.ratio(brand, bg) < 4.5) plainFails = true;
        }
      }
      expect(plainFails, isTrue);
    });
  }
}
