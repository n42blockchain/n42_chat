import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// SnackBar utility class for consistent, user-friendly notifications
///
/// Features:
/// - Auto-dismiss after a short duration (no manual swipe needed)
/// - Clears previous SnackBar before showing new one (no queue buildup)
/// - Floating behavior to avoid iPhone home indicator gesture conflicts
class SnackBarUtils {
  /// Show a standard info/success message
  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    Color? backgroundColor,
    SnackBarAction? action,
  }) {
    _showSnackBar(
      context,
      message,
      duration: duration,
      backgroundColor: backgroundColor,
      action: action,
    );
  }

  /// Show a success message (green background)
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    _showSnackBar(
      context,
      message,
      duration: duration,
      backgroundColor: AppColors.success,
    );
  }

  /// Show an error message (red background)
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackBar(
      context,
      message,
      duration: duration,
      backgroundColor: AppColors.error,
    );
  }

  /// Show a warning message (orange background)
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackBar(
      context,
      message,
      duration: duration,
      backgroundColor: Colors.orange,
    );
  }

  /// Internal method to show SnackBar with consistent settings
  static void _showSnackBar(
    BuildContext context,
    String message, {
    required Duration duration,
    Color? backgroundColor,
    SnackBarAction? action,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    // Clear any existing SnackBar to prevent queue buildup
    messenger.clearSnackBars();

    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        // Add margin to keep it away from edges
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // Rounded corners for modern look
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        action: action,
        // Allow dismissal by tapping (in addition to auto-dismiss)
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  /// Hide the current SnackBar immediately
  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// Clear all queued SnackBars
  static void clearAll(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
