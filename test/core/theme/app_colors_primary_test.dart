import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/theme/app_colors.dart';
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
}
