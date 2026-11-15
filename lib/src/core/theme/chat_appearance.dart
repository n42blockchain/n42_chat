import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'app_text_styles.dart';

/// Keep the host's palette, typography, spacing and control themes intact.
/// Chat-specific colors belong to message content, not navigation or forms.
ThemeData buildChatAppearanceTheme(
  ThemeData base, {
  TextScaler textScaler = TextScaler.noScaling,
}) => base.copyWith(
  appBarTheme: base.appBarTheme.copyWith(
    centerTitle: true,
    toolbarHeight: math.max(44, textScaler.scale(17) * 22 / 17 + 12),
    titleTextStyle: AppTextStyles.headlineSmall.copyWith(
      color: base.colorScheme.onSurface,
    ),
  ),
  materialTapTargetSize: MaterialTapTargetSize.padded,
  visualDensity: VisualDensity.standard,
);

/// Compose the chat preference with the OS scaler without reducing or capping
/// accessibility sizes. Calling the parent at each size preserves nonlinear
/// scaling on platforms that provide it.
class ChatPreferenceTextScaler extends TextScaler {
  const ChatPreferenceTextScaler(this.parent, this.factor);

  final TextScaler parent;
  final double factor;

  @override
  double scale(double fontSize) => parent.scale(fontSize) * factor;

  @override
  double get textScaleFactor => parent.scale(14) / 14 * factor;

  @override
  bool operator ==(Object other) =>
      other is ChatPreferenceTextScaler &&
      other.parent == parent &&
      other.factor == factor;

  @override
  int get hashCode => Object.hash(parent, factor);
}
