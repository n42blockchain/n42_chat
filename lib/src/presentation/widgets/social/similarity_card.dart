import 'package:flutter/material.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/chat_contrast.dart';
import '../../../domain/entities/social/social_connection.dart';
import '../../../domain/entities/social/social_recommendation.dart';
import '../../../core/theme/app_dimensions.dart';

/// Card widget for displaying a social graph recommendation.
///
/// Shows:
/// - Jazzicon-style avatar derived from the address hash
/// - Display name (ENS or shortened address)
/// - Similarity percentage badge
/// - Connection type icons
/// - Brief reason text
class SimilarityCard extends StatelessWidget {
  /// The recommendation data to display.
  final SocialRecommendation recommendation;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  /// Called when the "Connect" button is pressed.
  final VoidCallback? onConnect;

  const SimilarityCard({
    super.key,
    required this.recommendation,
    this.onTap,
    this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profile = recommendation.profile;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing,
          vertical: 6,
        ),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Avatar
            _buildAvatar(profile.address),
            const SizedBox(width: AppDimensions.spacingM),

            // Name + reason
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          profile.displayName,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacingS),
                      _buildSimilarityBadge(context),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacingXS),
                  Text(
                    recommendation.reason,
                    style: TextStyle(
                      fontSize: 13,
                      color: context.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDimensions.spacingS),
                  Row(
                    children: [
                      // Connection type icons
                      ..._buildConnectionIcons(context),
                      const Spacer(),
                      // Connect button
                      if (onConnect != null) _buildConnectButton(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String address) {
    // Generate a deterministic color from the address
    final color = _addressColor(address);
    final initials = address.length >= 4
        ? address.substring(2, 4).toUpperCase()
        : address.toUpperCase();

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildSimilarityBadge(BuildContext context) {
    final percent = recommendation.similarityPercent;
    final badgeColor = percent >= 60
        ? AppColors.primary
        : percent >= 30
        ? AppColors.warning
        : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingS,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$percent%',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          // Shade of the badge color that reaches 4.5:1 on its 12% tint.
          color: ChatContrast.onTint(
            badgeColor,
            [context.surfaceColor],
            dark: context.isDarkMode,
            alpha: 0.12,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildConnectionIcons(BuildContext context) {
    final types = recommendation.topConnectionTypes;
    final iconColor = context.textSecondary;

    return types.take(4).map((type) {
      final icon = _iconForType(type);
      return Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Tooltip(
          message: _labelForType(context, type),
          child: Icon(icon, size: 16, color: iconColor),
        ),
      );
    }).toList();
  }

  Widget _buildConnectButton(BuildContext context) {
    // Visual pill stays 28pt tall; the padded tap target keeps the hit
    // area at 48pt.
    return TextButton(
      onPressed: onConnect,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primaryOf(context).withValues(alpha: 0.1),
        foregroundColor: AppColors.primaryOnTintOf(context),
        minimumSize: const Size(0, 28),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        tapTargetSize: MaterialTapTargetSize.padded,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      child: Text(S.of(context)?.ui3Connect ?? 'Connect'),
    );
  }

  /// Generate a deterministic color from an Ethereum address.
  Color _addressColor(String address) {
    if (address.length < 6) return AppColors.primary;
    final hash = address.codeUnits.fold<int>(0, (sum, c) => sum + c);
    return AppColorPalettes.avatarColors[hash %
        AppColorPalettes.avatarColors.length];
  }

  IconData _iconForType(ConnectionType type) {
    switch (type) {
      case ConnectionType.commonTokens:
        return Icons.token_outlined;
      case ConnectionType.commonNfts:
        return Icons.collections_outlined;
      case ConnectionType.transactionHistory:
        return Icons.swap_horiz;
      case ConnectionType.commonDaos:
        return Icons.groups_outlined;
      case ConnectionType.commonChains:
        return Icons.link;
    }
  }

  String _labelForType(BuildContext context, ConnectionType type) {
    final l10n = S.of(context);
    switch (type) {
      case ConnectionType.commonTokens:
        return l10n?.ui3CommonTokens ?? 'Common tokens';
      case ConnectionType.commonNfts:
        return l10n?.ui3SharedNfts ?? 'Shared NFTs';
      case ConnectionType.transactionHistory:
        return l10n?.ui3TransactionHistory ?? 'Transaction history';
      case ConnectionType.commonDaos:
        return l10n?.ui3CommonDaos ?? 'Common DAOs';
      case ConnectionType.commonChains:
        return l10n?.ui3SameChains ?? 'Same chains';
    }
  }
}
