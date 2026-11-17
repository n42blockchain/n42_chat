import 'dart:math' as math;

import 'package:flutter/material.dart';

/// WCAG 2.x contrast helpers for brand-colored labels. The brand follows
/// the host accent, so text-safe shades are derived at runtime: hue and
/// saturation stay, only HSL lightness moves in 0.5% steps.
abstract final class ChatContrast {
  /// Minimum ratio for body-size text (WCAG 1.4.3 AA).
  static const double minText = 4.5;

  /// Highest brand tint alpha that [onTint] covers by default (8%-15%
  /// tints are used for tags and chips).
  static const double maxTintAlpha = 0.15;

  /// WCAG contrast ratio between two opaque colors (1.0 - 21.0).
  static double ratio(Color a, Color b) {
    final la = a.computeLuminance();
    final lb = b.computeLuminance();
    return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
  }

  /// Fill shade of [color] that carries white text at >= 4.5:1: same hue,
  /// HSL lightness lowered in 0.5% steps. System blue + white is about
  /// 4.0:1 (light) / 3.65:1 (dark), system red about 3.55:1.
  static Color fillForWhiteText(Color color) {
    const white = Color(0xFFFFFFFF);
    var hsl = HSLColor.fromColor(color);
    var result = color;
    while (ratio(result, white) < minText && hsl.lightness > 0) {
      hsl = hsl.withLightness(math.max(0, hsl.lightness - 0.005));
      result = hsl.toColor();
    }
    return result;
  }

  /// Shade of [brand] for text on a [brand] tint of up to [alpha] over any
  /// of [surfaces]: darker for light surfaces, lighter for dark ones.
  static Color onTint(
    Color brand,
    List<Color> surfaces, {
    required bool dark,
    double alpha = maxTintAlpha,
  }) {
    final tint = brand.withValues(alpha: alpha);
    final backgrounds = [
      for (final surface in surfaces) Color.alphaBlend(tint, surface),
    ];
    bool passes(Color c) => backgrounds.every((b) => ratio(c, b) >= minText);
    var hsl = HSLColor.fromColor(brand);
    var result = brand;
    while (!passes(result)) {
      final lightness = hsl.lightness + (dark ? 0.005 : -0.005);
      if (lightness < 0 || lightness > 1) break;
      hsl = hsl.withLightness(lightness);
      result = hsl.toColor();
    }
    return result;
  }
}
