import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/theme/app_colors.dart';

void main() {
  test('semantic palette uses explicit ARGB values', () {
    final source = File('lib/src/core/theme/app_colors.dart')
        .readAsStringSync();
    expect(
      RegExp(r'Color\(0x[0-9a-fA-F]{6}\)').allMatches(source),
      isEmpty,
      reason: 'Six-digit RGB values become fully transparent in Flutter',
    );
    for (final dark in [false, true]) {
      expect(AppColors.textPrimaryOf(dark).a, 1);
      expect(AppColors.surfaceOf(dark).a, 1);
      expect(AppColors.selfBubble(dark).a, 1);
    }
  });
}
