import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Compact provider icons beside the wider Apple control. At accessibility
/// sizes or narrow widths, Apple gets its own row instead of being truncated.
class SocialSignInRow extends StatelessWidget {
  const SocialSignInRow({super.key, this.google, this.facebook, this.apple});
  final Widget? google;
  final Widget? facebook;
  final Widget? apple;

  @override
  Widget build(BuildContext context) {
    final width = math.max(
      60.0,
      MediaQuery.textScalerOf(context).scale(11) * 5.5,
    );
    final small = [
      if (google != null) google!,
      if (facebook != null) facebook!,
    ];
    final compact = small.map((w) => SizedBox(width: width, child: w)).toList();
    return LayoutBuilder(
      builder: (context, constraints) {
        final need = width * small.length + 8 * small.length + 140;
        if (apple != null && small.isNotEmpty && constraints.maxWidth < need) {
          return Column(
            children: [
              Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                children: compact,
              ),
              const SizedBox(height: 8),
              SizedBox(width: double.infinity, height: 44, child: apple),
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final w in compact) ...[w, const SizedBox(width: 8)],
            if (apple != null)
              Expanded(child: SizedBox(height: 44, child: apple)),
          ],
        );
      },
    );
  }
}

class CompactSocialSignInButton extends StatelessWidget {
  const CompactSocialSignInButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.loading = false,
  });
  final String label;
  final Widget icon;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onPressed != null,
    label: label,
    onTap: onPressed,
    child: ExcludeSemantics(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 44),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading)
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              icon,
            const SizedBox(height: 3),
            Text(label, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    ),
  );
}
