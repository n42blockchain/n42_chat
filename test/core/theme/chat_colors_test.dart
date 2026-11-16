import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/theme/app_colors.dart';
import 'package:n42_chat/src/core/theme/chat_colors.dart';

Future<ChatColors> _resolve(WidgetTester tester, ThemeData theme) async {
  late ChatColors resolved;
  await tester.pumpWidget(
    MaterialApp(
      theme: theme,
      home: Builder(
        builder: (context) {
          resolved = ChatColors.of(context);
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return resolved;
}

void main() {
  group('ChatColors.of', () {
    testWidgets('falls back to the light palette without an extension', (
      tester,
    ) async {
      final colors = await _resolve(tester, ThemeData.light());
      expect(colors, same(ChatColors.light));
      expect(colors.bubbleOther, AppColors.bubbleOther);
      expect(colors.receivedText, AppColors.messageTextReceived);
    });

    testWidgets('falls back to the dark palette without an extension', (
      tester,
    ) async {
      final colors = await _resolve(tester, ThemeData.dark());
      expect(colors, same(ChatColors.dark));
      expect(colors.bubbleOther, AppColors.bubbleOtherDark);
      expect(colors.receivedText, AppColors.textPrimaryDark);
    });

    testWidgets('uses the registered theme extension', (tester) async {
      final custom = ChatColors.light.copyWith(
        bubbleOther: const Color(0xFF123456),
      );
      final colors = await _resolve(
        tester,
        ThemeData.dark().copyWith(extensions: [custom]),
      );
      expect(colors, same(custom));
      expect(colors.bubbleOther, const Color(0xFF123456));
    });
  });

  group('BrandTint', () {
    test('applies alpha to the supplied brand color', () {
      const brand = Color(0xFF5B6CFF);
      expect(ChatColors.light.brandTint(brand), brand.withValues(alpha: 0.08));
      expect(ChatColors.dark.brandTint(brand), brand.withValues(alpha: 0.15));
    });

    test('a fixed color overrides the brand color', () {
      const brand = Color(0xFF5B6CFF);
      expect(ChatColors.dark.brandHeaderBg(brand), AppColors.surfaceDark);
      expect(ChatColors.light.brandHeaderBg(brand), brand);
    });
  });

  test('lerp interpolates between palettes', () {
    final mid = ChatColors.light.lerp(ChatColors.dark, 0.5);
    expect(
      mid.chipBg,
      Color.lerp(ChatColors.light.chipBg, ChatColors.dark.chipBg, 0.5),
    );
    expect(ChatColors.light.lerp(null, 0.5), same(ChatColors.light));
    expect(
      ChatColors.light.lerp(ChatColors.dark, 1).trackBg,
      ChatColors.dark.trackBg,
    );
  });
}
