import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/chat_contrast.dart';

class GameScaffold extends StatelessWidget {
  final String title;
  final int score;
  final Widget child;
  final VoidCallback? onPause;
  final VoidCallback? onRestart;
  final bool isPaused;
  final Widget? topWidget;

  const GameScaffold({
    super.key,
    required this.title,
    required this.score,
    required this.child,
    this.onPause,
    this.onRestart,
    this.isPaused = false,
    this.topWidget,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    // Orange shade that reaches 4.5:1 on its 15% tint over the app bar.
    final scoreColor = ChatContrast.onTint(
      Colors.orange,
      [theme.appBarTheme.backgroundColor ?? theme.colorScheme.surface],
      dark: theme.brightness == Brightness.dark,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: l10n?.a11yBack ?? 'Back',
          onPressed: () => _confirmExit(context, l10n),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            const SizedBox(width: AppDimensions.spacingM),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingS,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Text(
                '$score',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (onRestart != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: l10n?.a11yRefresh ?? 'Refresh',
              onPressed: onRestart,
            ),
          if (onPause != null)
            IconButton(
              icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
              tooltip: isPaused
                  ? (l10n?.a11yPlay ?? 'Play')
                  : (l10n?.a11yPause ?? 'Pause'),
              onPressed: onPause,
            ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ?topWidget,
              Expanded(child: child),
            ],
          ),
          if (isPaused)
            GestureDetector(
              onTap: onPause,
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.pause_circle_outline,
                        size: 64,
                        color: Colors.white,
                      ),
                      const SizedBox(height: AppDimensions.spacing),
                      Text(
                        l10n?.gamePause ?? 'Paused',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingS),
                      Text(
                        l10n?.gameResume ?? 'Tap to resume',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _confirmExit(BuildContext context, S? l10n) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.gameConfirmExit ?? 'Quit this game?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx, true);
              Navigator.pop(context);
            },
            child: Text(l10n?.commonConfirm ?? 'OK'),
          ),
        ],
      ),
    );
  }
}
