import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/theme/app_colors.dart';
import 'package:n42_chat/src/core/theme/chat_contrast.dart';
import 'package:n42_chat/src/core/theme/n42_chat_theme.dart';

const _white = Color(0xFFFFFFFF);

double _hue(Color c) => HSLColor.fromColor(c).hue;

void main() {
  test('fillForWhiteText reaches 4.5:1 and keeps the hue', () {
    for (final color in [
      AppColors.primary,
      AppColors.primaryDark,
      AppColors.error,
      const Color(0xFF5B6CFF),
    ]) {
      final fill = ChatContrast.fillForWhiteText(color);
      expect(ChatContrast.ratio(fill, _white), greaterThanOrEqualTo(4.5));
      expect(_hue(fill), closeTo(_hue(color), 1.0));
    }
    // System blue and red alone are the failing patterns.
    expect(ChatContrast.ratio(AppColors.primary, _white), lessThan(4.5));
    expect(ChatContrast.ratio(AppColors.error, _white), lessThan(4.5));
    expect(
      ChatContrast.ratio(AppColors.errorFill, _white),
      greaterThanOrEqualTo(4.5),
    );
  });

  for (final theme in [
    N42ChatTheme.wechatLight(),
    N42ChatTheme.wechatDark(),
  ]) {
    testWidgets('filled and elevated buttons carry white at 4.5:1 '
        '(${theme.isDark ? 'dark' : 'light'})', (tester) async {
      late ThemeData data;
      late Color primaryFill;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme.toThemeData(),
          home: Builder(
            builder: (context) {
              data = Theme.of(context);
              primaryFill = AppColors.primaryFillOf(context);
              return const SizedBox();
            },
          ),
        ),
      );
      for (final style in [
        data.filledButtonTheme.style!,
        data.elevatedButtonTheme.style!,
      ]) {
        final bg = style.backgroundColor!.resolve(<WidgetState>{})!;
        final fg = style.foregroundColor!.resolve(<WidgetState>{})!;
        expect(ChatContrast.ratio(bg, fg), greaterThanOrEqualTo(4.5));
      }
      expect(
        ChatContrast.ratio(primaryFill, _white),
        greaterThanOrEqualTo(4.5),
      );
    });
  }
}
