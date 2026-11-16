import 'package:flutter/material.dart';

import 'app_colors.dart';

/// A brightness-dependent tint of a brand color.
///
/// The brand color itself is supplied by the caller (normally
/// `AppColors.primary` or the host's `colorScheme.primary`), so it is never
/// baked into [ChatColors]. When [fixed] is set, it wins over the brand color
/// (e.g. a neutral surface in dark mode).
@immutable
class BrandTint {
  const BrandTint({required this.alpha, this.fixed});

  /// Alpha applied to the brand color.
  final double alpha;

  /// Optional color used instead of the brand tint.
  final Color? fixed;

  /// Resolves this tint against [brand].
  Color call(Color brand) => fixed ?? brand.withValues(alpha: alpha);

  /// Interpolates alphas; tints with a [fixed] color switch at the midpoint.
  static BrandTint lerp(BrandTint a, BrandTint b, double t) {
    if (a.fixed == null && b.fixed == null) {
      return BrandTint(alpha: a.alpha + (b.alpha - a.alpha) * t);
    }
    return t < 0.5 ? a : b;
  }

  @override
  bool operator ==(Object other) =>
      other is BrandTint && other.alpha == alpha && other.fixed == fixed;

  @override
  int get hashCode => Object.hash(alpha, fixed);
}

/// Semantic, brightness-aware colors for chat UI.
///
/// Replaces scattered `isDark ? a : b` color picks. Hosts may register a
/// customized instance via `ThemeData.extensions`; otherwise [of] falls back
/// to [ChatColors.light] / [ChatColors.dark] by the ambient brightness.
@immutable
class ChatColors extends ThemeExtension<ChatColors> {
  const ChatColors({
    required this.bubbleOther,
    required this.receivedText,
    required this.messageSelectedBg,
    required this.senderNameText,
    required this.timeSeparatorText,
    required this.translatedText,
    required this.translatedAccent,
    required this.pollTrack,
    required this.subtleFill,
    required this.subtleFillWeak,
    required this.chipFill,
    required this.insetFill,
    required this.codeInlineBg,
    required this.meterTrack,
    required this.tileFillFaint,
    required this.selectedTileFill,
    required this.cardFillSubtle,
    required this.placeholderTile,
    required this.verificationCellBg,
    required this.searchFieldFill,
    required this.linkFieldFill,
    required this.sheetDivider,
    required this.chipBg,
    required this.trackBg,
    required this.optionTileBg,
    required this.disabledFill,
    required this.buttonDisabledBg,
    required this.formFieldFill,
    required this.secondaryButtonBg,
    required this.recessedFill,
    required this.welcomeBg,
    required this.avatarPlaceholderBg,
    required this.avatarPlaceholderFg,
    required this.dragHandle,
    required this.selfDestructBg,
    required this.selfDestructBorder,
    required this.mutedIcon,
    required this.emptyStateIcon,
    required this.graphEdge,
    required this.mutedBadge,
    required this.captionText,
    required this.dateHeaderText,
    required this.chipLabelText,
    required this.warningText,
    required this.menuAccentText,
    required this.menuLinkText,
    required this.codeKeyword,
    required this.codeString,
    required this.codeComment,
    required this.codeLiteral,
    required this.codeText,
    required this.codeBlockBg,
    required this.redPacketFieldBg,
    required this.redPacketDisabledBg,
    required this.redPacketDisabledFg,
    required this.qrPresetN42,
    required this.qrPresetClassic,
    required this.qrPresetOcean,
    required this.qrPresetBerry,
    required this.momentCoverStart,
    required this.momentCoverEnd,
    required this.appleButtonBg,
    required this.appleButtonFg,
    required this.brandTintFaint,
    required this.brandTintSoft,
    required this.brandTint,
    required this.brandChipTint,
    required this.brandTintStrong,
    required this.brandSelectedTint,
    required this.brandBannerTint,
    required this.brandHeaderBg,
  });

  /// Resolves the chat colors for [context].
  static ChatColors of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<ChatColors>() ??
        (theme.brightness == Brightness.dark ? dark : light);
  }

  /// Default light palette.
  static final ChatColors light = ChatColors(
    bubbleOther: AppColors.bubbleOther,
    receivedText: AppColors.messageTextReceived,
    messageSelectedBg: AppColors.info.withValues(alpha: 0.1),
    senderNameText: AppColors.textSecondary,
    timeSeparatorText: const Color(0xFF999999),
    translatedText: AppColors.textPrimary,
    translatedAccent: const Color(0xFF43A047),
    pollTrack: Colors.grey.shade300,
    subtleFill: Colors.black.withValues(alpha: 0.05),
    subtleFillWeak: Colors.black.withValues(alpha: 0.06),
    chipFill: Colors.black.withValues(alpha: 0.05),
    insetFill: Colors.black.withValues(alpha: 0.04),
    codeInlineBg: Colors.black.withValues(alpha: 0.06),
    meterTrack: Colors.black.withValues(alpha: 0.06),
    tileFillFaint: Colors.black.withValues(alpha: 0.03),
    selectedTileFill: Colors.black.withValues(alpha: 0.03),
    cardFillSubtle: Colors.black.withValues(alpha: 0.05),
    placeholderTile: Colors.grey.shade100,
    verificationCellBg: Colors.grey.withValues(alpha: 0.1),
    searchFieldFill: Colors.grey.shade200,
    linkFieldFill: const Color(0xFFF7F7F7),
    sheetDivider: Colors.white.withValues(alpha: 0.08),
    chipBg: const Color(0xFFF7F7F7),
    trackBg: const Color(0xFFE0E0E0),
    optionTileBg: const Color(0xFFF7F7F7),
    disabledFill: const Color(0xFFE0E0E0),
    buttonDisabledBg: const Color(0xFFE0E0E0),
    formFieldFill: const Color(0xFFF7F7F7),
    secondaryButtonBg: const Color(0xFFF7F7F7),
    recessedFill: AppColors.inputBackground,
    welcomeBg: Colors.white,
    avatarPlaceholderBg: Colors.grey.shade200,
    avatarPlaceholderFg: Colors.grey.shade600,
    dragHandle: Colors.grey.shade300,
    selfDestructBg: Colors.grey.shade200.withValues(alpha: 0.7),
    selfDestructBorder: Colors.grey.shade300.withValues(alpha: 0.5),
    mutedIcon: AppColors.muted,
    emptyStateIcon: Colors.grey.shade300,
    graphEdge: Colors.black12,
    mutedBadge: AppColors.muted,
    captionText: AppColors.textTertiary,
    dateHeaderText: AppColors.textPrimary,
    chipLabelText: AppColors.textPrimary,
    warningText: Colors.orange.shade800,
    menuAccentText: const Color(0xFF007AFF),
    menuLinkText: const Color(0xFF576B95),
    codeKeyword: const Color(0xFF1A73E8),
    codeString: const Color(0xFFC5221F),
    codeComment: const Color(0xFF188038),
    codeLiteral: const Color(0xFFB06000),
    codeText: Colors.green.shade800,
    codeBlockBg: Colors.grey.shade100,
    redPacketFieldBg: AppColors.dividerThin.withValues(alpha: 0.05),
    redPacketDisabledBg: const Color(0xFFE8D0C0),
    redPacketDisabledFg: Colors.white60,
    qrPresetN42: Colors.white,
    qrPresetClassic: Colors.white,
    qrPresetOcean: const Color(0xFFE3EFFD),
    qrPresetBerry: const Color(0xFFF7F7F7),
    momentCoverStart: const Color(0xFF667eea),
    momentCoverEnd: const Color(0xFF764ba2),
    appleButtonBg: Colors.black,
    appleButtonFg: Colors.white,
    brandTintFaint: const BrandTint(alpha: 0.04),
    brandTintSoft: const BrandTint(alpha: 0.05),
    brandTint: const BrandTint(alpha: 0.08),
    brandChipTint: const BrandTint(alpha: 0.10),
    brandTintStrong: const BrandTint(alpha: 0.1),
    brandSelectedTint: const BrandTint(alpha: 0.08),
    brandBannerTint: const BrandTint(alpha: 0.08),
    brandHeaderBg: const BrandTint(alpha: 1.0),
  );

  /// Default dark palette.
  static final ChatColors dark = ChatColors(
    bubbleOther: AppColors.bubbleOtherDark,
    receivedText: AppColors.textPrimaryDark,
    messageSelectedBg: Colors.white.withValues(alpha: 0.1),
    senderNameText: const Color(0xFF999999),
    timeSeparatorText: const Color(0xFF888888),
    translatedText: Colors.white.withValues(alpha: 0.9),
    translatedAccent: const Color(0xFF66BB6A),
    pollTrack: Colors.grey.shade700,
    subtleFill: Colors.white.withValues(alpha: 0.1),
    subtleFillWeak: Colors.white.withValues(alpha: 0.06),
    chipFill: Colors.white12,
    insetFill: Colors.white.withValues(alpha: 0.08),
    codeInlineBg: Colors.white.withValues(alpha: 0.1),
    meterTrack: Colors.white.withValues(alpha: 0.08),
    tileFillFaint: Colors.white.withValues(alpha: 0.04),
    selectedTileFill: Colors.white.withValues(alpha: 0.05),
    cardFillSubtle: Colors.white.withValues(alpha: 0.06),
    placeholderTile: Colors.white.withValues(alpha: 0.08),
    verificationCellBg: Colors.white.withValues(alpha: 0.08),
    searchFieldFill: Colors.white.withValues(alpha: 0.1),
    linkFieldFill: Colors.white.withValues(alpha: 0.06),
    sheetDivider: Colors.white.withValues(alpha: 0.10),
    chipBg: const Color(0xFF2A2A2A),
    trackBg: const Color(0xFF3D3D3D),
    optionTileBg: const Color(0xFF3D3D3D),
    disabledFill: const Color(0xFF2A2A2A),
    buttonDisabledBg: AppColors.dividerDark,
    formFieldFill: AppColors.dividerThinDark,
    secondaryButtonBg: AppColors.surfaceDark.withValues(alpha: 0.5),
    recessedFill: AppColors.backgroundDark,
    welcomeBg: AppColors.backgroundDark,
    avatarPlaceholderBg: Colors.grey.shade700,
    avatarPlaceholderFg: Colors.grey.shade300,
    dragHandle: Colors.grey.shade600,
    selfDestructBg: Colors.grey.shade800.withValues(alpha: 0.5),
    selfDestructBorder: Colors.grey.shade700.withValues(alpha: 0.3),
    mutedIcon: Colors.white24,
    emptyStateIcon: Colors.white24,
    graphEdge: Colors.white24,
    mutedBadge: AppColors.textTertiaryDark,
    captionText: AppColors.textSecondaryDark,
    dateHeaderText: Colors.white70,
    chipLabelText: AppColors.textSecondaryDark,
    warningText: Colors.orange.shade200,
    menuAccentText: Colors.white,
    menuLinkText: const Color(0xFF57A5FF),
    codeKeyword: const Color(0xFF8AB4F8),
    codeString: const Color(0xFFF28B82),
    codeComment: const Color(0xFF81C995),
    codeLiteral: const Color(0xFFFDD663),
    codeText: Colors.greenAccent.shade200,
    codeBlockBg: Colors.black26,
    redPacketFieldBg: AppColors.dividerThinDark,
    redPacketDisabledBg: const Color(0xFF4A3020),
    redPacketDisabledFg: Colors.white38,
    qrPresetN42: const Color(0xFF2A2A2A),
    qrPresetClassic: const Color(0xFF181818),
    qrPresetOcean: const Color(0xFF1A252F),
    qrPresetBerry: const Color(0xFF2A1727),
    momentCoverStart: const Color(0xFF2C3E50),
    momentCoverEnd: const Color(0xFF1A252F),
    appleButtonBg: Colors.white,
    appleButtonFg: Colors.black,
    brandTintFaint: const BrandTint(alpha: 0.08),
    brandTintSoft: const BrandTint(alpha: 0.1),
    brandTint: const BrandTint(alpha: 0.15),
    brandChipTint: const BrandTint(alpha: 0.16),
    brandTintStrong: const BrandTint(alpha: 0.2),
    brandSelectedTint: const BrandTint(fixed: Colors.white10, alpha: 0.08),
    brandBannerTint: BrandTint(
      fixed: AppColors.surfaceDark.withValues(alpha: 0.85),
      alpha: 0.08,
    ),
    brandHeaderBg: const BrandTint(fixed: AppColors.surfaceDark, alpha: 1.0),
  );

  // Chat bubbles and message text

  /// Received message bubble fill.
  final Color bubbleOther;

  /// Body text inside a received bubble.
  final Color receivedText;

  /// Row highlight for a selected message in multi-select mode.
  final Color messageSelectedBg;

  /// Sender display name above group messages.
  final Color senderNameText;

  /// Time separator label between messages.
  final Color timeSeparatorText;

  /// Translated message body text.
  final Color translatedText;

  /// Translation badge / accent.
  final Color translatedAccent;

  /// Track behind poll vote progress bars inside messages.
  final Color pollTrack;

  // Translucent fills (overlay on the current surface)

  /// Generic low-contrast fill: reaction chips, index-bar press, link previews.
  final Color subtleFill;

  /// Weaker fill for tab pills and input containers.
  final Color subtleFillWeak;

  /// Quick-reply chip fill.
  final Color chipFill;

  /// Inset blocks such as quotes and translated message panels.
  final Color insetFill;

  /// Inline code background in markdown.
  final Color codeInlineBg;

  /// Track behind similarity meters and score rings.
  final Color meterTrack;

  /// Faint tile fill in call enhancement sheets.
  final Color tileFillFaint;

  /// Selected list tile fill.
  final Color selectedTileFill;

  /// Subtle card fill (avatar studio).
  final Color cardFillSubtle;

  /// Placeholder tile behind loading media/NFT thumbnails.
  final Color placeholderTile;

  /// Emoji verification cell background.
  final Color verificationCellBg;

  /// Search field fill inside picker sheets.
  final Color searchFieldFill;

  /// Read-only link field fill.
  final Color linkFieldFill;

  /// Divider on always-dark call sheets.
  final Color sheetDivider;

  // Opaque neutral fills

  /// Neutral chip / inactive cell background.
  final Color chipBg;

  /// Progress track background.
  final Color trackBg;

  /// Unselected option tile background.
  final Color optionTileBg;

  /// Disabled / unavailable item fill.
  final Color disabledFill;

  /// Disabled filled button background.
  final Color buttonDisabledBg;

  /// Filled form field background.
  final Color formFieldFill;

  /// Secondary (tonal) button background.
  final Color secondaryButtonBg;

  /// Recessed fill that sits below the surface (inputs on cards).
  final Color recessedFill;

  /// Welcome page background.
  final Color welcomeBg;

  /// Avatar placeholder circle background.
  final Color avatarPlaceholderBg;

  /// Avatar placeholder initial.
  final Color avatarPlaceholderFg;

  /// Bottom sheet drag handle.
  final Color dragHandle;

  /// Self-destructed message placeholder fill.
  final Color selfDestructBg;

  /// Self-destructed message placeholder border.
  final Color selfDestructBorder;

  // Icons and secondary text

  /// Muted (do-not-disturb) indicator icon.
  final Color mutedIcon;

  /// Large empty-state illustration icon.
  final Color emptyStateIcon;

  /// Edges in the social graph visualization.
  final Color graphEdge;

  /// Fallback fill for muted badges.
  final Color mutedBadge;

  /// Low-emphasis caption text (footers, secondary meta).
  final Color captionText;

  /// Date group headers in media galleries.
  final Color dateHeaderText;

  /// Unselected filter chip label.
  final Color chipLabelText;

  /// Inline warning text.
  final Color warningText;

  /// Accent action label in message menus / confirm sheets.
  final Color menuAccentText;

  /// Link-style label in the message menu.
  final Color menuLinkText;

  // Code and markdown

  /// Syntax highlight: keywords.
  final Color codeKeyword;

  /// Syntax highlight: strings.
  final Color codeString;

  /// Syntax highlight: comments.
  final Color codeComment;

  /// Syntax highlight: literals.
  final Color codeLiteral;

  /// Monospace code text in AI replies.
  final Color codeText;

  /// Code block background in AI replies.
  final Color codeBlockBg;

  // Red packet / transfer

  /// Field / tag background on red packet forms.
  final Color redPacketFieldBg;

  /// Disabled send button background.
  final Color redPacketDisabledBg;

  /// Disabled send button foreground.
  final Color redPacketDisabledFg;

  // QR code card presets

  /// QR card: N42 preset.
  final Color qrPresetN42;

  /// QR card: classic preset.
  final Color qrPresetClassic;

  /// QR card: ocean preset.
  final Color qrPresetOcean;

  /// QR card: berry preset.
  final Color qrPresetBerry;

  // Moments

  /// Moment cover default gradient start.
  final Color momentCoverStart;

  /// Moment cover default gradient end.
  final Color momentCoverEnd;

  // Sign in with Apple (inverted against the page)

  /// Fallback Apple sign-in button background.
  final Color appleButtonBg;

  /// Fallback Apple sign-in button foreground.
  final Color appleButtonFg;

  // Brand tints: resolve with the brand color, e.g.
  // `ChatColors.of(context).brandTint(AppColors.primary)`.

  /// Faint brand wash (cards, unread rows).
  final BrandTint brandTintFaint;

  /// Soft brand wash (suggestion chips, banners).
  final BrandTint brandTintSoft;

  /// Standard brand wash (AI chips, pills).
  final BrandTint brandTint;

  /// Brand wash for smart-reply chips.
  final BrandTint brandChipTint;

  /// Strong brand wash (badges, avatars).
  final BrandTint brandTintStrong;

  /// Unselected chip: neutral in dark, brand wash in light.
  final BrandTint brandSelectedTint;

  /// Info banner: surface in dark, brand wash in light.
  final BrandTint brandBannerTint;

  /// Header bar: surface in dark, solid brand in light.
  final BrandTint brandHeaderBg;

  @override
  ChatColors copyWith({
    Color? bubbleOther,
    Color? receivedText,
    Color? messageSelectedBg,
    Color? senderNameText,
    Color? timeSeparatorText,
    Color? translatedText,
    Color? translatedAccent,
    Color? pollTrack,
    Color? subtleFill,
    Color? subtleFillWeak,
    Color? chipFill,
    Color? insetFill,
    Color? codeInlineBg,
    Color? meterTrack,
    Color? tileFillFaint,
    Color? selectedTileFill,
    Color? cardFillSubtle,
    Color? placeholderTile,
    Color? verificationCellBg,
    Color? searchFieldFill,
    Color? linkFieldFill,
    Color? sheetDivider,
    Color? chipBg,
    Color? trackBg,
    Color? optionTileBg,
    Color? disabledFill,
    Color? buttonDisabledBg,
    Color? formFieldFill,
    Color? secondaryButtonBg,
    Color? recessedFill,
    Color? welcomeBg,
    Color? avatarPlaceholderBg,
    Color? avatarPlaceholderFg,
    Color? dragHandle,
    Color? selfDestructBg,
    Color? selfDestructBorder,
    Color? mutedIcon,
    Color? emptyStateIcon,
    Color? graphEdge,
    Color? mutedBadge,
    Color? captionText,
    Color? dateHeaderText,
    Color? chipLabelText,
    Color? warningText,
    Color? menuAccentText,
    Color? menuLinkText,
    Color? codeKeyword,
    Color? codeString,
    Color? codeComment,
    Color? codeLiteral,
    Color? codeText,
    Color? codeBlockBg,
    Color? redPacketFieldBg,
    Color? redPacketDisabledBg,
    Color? redPacketDisabledFg,
    Color? qrPresetN42,
    Color? qrPresetClassic,
    Color? qrPresetOcean,
    Color? qrPresetBerry,
    Color? momentCoverStart,
    Color? momentCoverEnd,
    Color? appleButtonBg,
    Color? appleButtonFg,
    BrandTint? brandTintFaint,
    BrandTint? brandTintSoft,
    BrandTint? brandTint,
    BrandTint? brandChipTint,
    BrandTint? brandTintStrong,
    BrandTint? brandSelectedTint,
    BrandTint? brandBannerTint,
    BrandTint? brandHeaderBg,
  }) {
    return ChatColors(
      bubbleOther: bubbleOther ?? this.bubbleOther,
      receivedText: receivedText ?? this.receivedText,
      messageSelectedBg: messageSelectedBg ?? this.messageSelectedBg,
      senderNameText: senderNameText ?? this.senderNameText,
      timeSeparatorText: timeSeparatorText ?? this.timeSeparatorText,
      translatedText: translatedText ?? this.translatedText,
      translatedAccent: translatedAccent ?? this.translatedAccent,
      pollTrack: pollTrack ?? this.pollTrack,
      subtleFill: subtleFill ?? this.subtleFill,
      subtleFillWeak: subtleFillWeak ?? this.subtleFillWeak,
      chipFill: chipFill ?? this.chipFill,
      insetFill: insetFill ?? this.insetFill,
      codeInlineBg: codeInlineBg ?? this.codeInlineBg,
      meterTrack: meterTrack ?? this.meterTrack,
      tileFillFaint: tileFillFaint ?? this.tileFillFaint,
      selectedTileFill: selectedTileFill ?? this.selectedTileFill,
      cardFillSubtle: cardFillSubtle ?? this.cardFillSubtle,
      placeholderTile: placeholderTile ?? this.placeholderTile,
      verificationCellBg: verificationCellBg ?? this.verificationCellBg,
      searchFieldFill: searchFieldFill ?? this.searchFieldFill,
      linkFieldFill: linkFieldFill ?? this.linkFieldFill,
      sheetDivider: sheetDivider ?? this.sheetDivider,
      chipBg: chipBg ?? this.chipBg,
      trackBg: trackBg ?? this.trackBg,
      optionTileBg: optionTileBg ?? this.optionTileBg,
      disabledFill: disabledFill ?? this.disabledFill,
      buttonDisabledBg: buttonDisabledBg ?? this.buttonDisabledBg,
      formFieldFill: formFieldFill ?? this.formFieldFill,
      secondaryButtonBg: secondaryButtonBg ?? this.secondaryButtonBg,
      recessedFill: recessedFill ?? this.recessedFill,
      welcomeBg: welcomeBg ?? this.welcomeBg,
      avatarPlaceholderBg: avatarPlaceholderBg ?? this.avatarPlaceholderBg,
      avatarPlaceholderFg: avatarPlaceholderFg ?? this.avatarPlaceholderFg,
      dragHandle: dragHandle ?? this.dragHandle,
      selfDestructBg: selfDestructBg ?? this.selfDestructBg,
      selfDestructBorder: selfDestructBorder ?? this.selfDestructBorder,
      mutedIcon: mutedIcon ?? this.mutedIcon,
      emptyStateIcon: emptyStateIcon ?? this.emptyStateIcon,
      graphEdge: graphEdge ?? this.graphEdge,
      mutedBadge: mutedBadge ?? this.mutedBadge,
      captionText: captionText ?? this.captionText,
      dateHeaderText: dateHeaderText ?? this.dateHeaderText,
      chipLabelText: chipLabelText ?? this.chipLabelText,
      warningText: warningText ?? this.warningText,
      menuAccentText: menuAccentText ?? this.menuAccentText,
      menuLinkText: menuLinkText ?? this.menuLinkText,
      codeKeyword: codeKeyword ?? this.codeKeyword,
      codeString: codeString ?? this.codeString,
      codeComment: codeComment ?? this.codeComment,
      codeLiteral: codeLiteral ?? this.codeLiteral,
      codeText: codeText ?? this.codeText,
      codeBlockBg: codeBlockBg ?? this.codeBlockBg,
      redPacketFieldBg: redPacketFieldBg ?? this.redPacketFieldBg,
      redPacketDisabledBg: redPacketDisabledBg ?? this.redPacketDisabledBg,
      redPacketDisabledFg: redPacketDisabledFg ?? this.redPacketDisabledFg,
      qrPresetN42: qrPresetN42 ?? this.qrPresetN42,
      qrPresetClassic: qrPresetClassic ?? this.qrPresetClassic,
      qrPresetOcean: qrPresetOcean ?? this.qrPresetOcean,
      qrPresetBerry: qrPresetBerry ?? this.qrPresetBerry,
      momentCoverStart: momentCoverStart ?? this.momentCoverStart,
      momentCoverEnd: momentCoverEnd ?? this.momentCoverEnd,
      appleButtonBg: appleButtonBg ?? this.appleButtonBg,
      appleButtonFg: appleButtonFg ?? this.appleButtonFg,
      brandTintFaint: brandTintFaint ?? this.brandTintFaint,
      brandTintSoft: brandTintSoft ?? this.brandTintSoft,
      brandTint: brandTint ?? this.brandTint,
      brandChipTint: brandChipTint ?? this.brandChipTint,
      brandTintStrong: brandTintStrong ?? this.brandTintStrong,
      brandSelectedTint: brandSelectedTint ?? this.brandSelectedTint,
      brandBannerTint: brandBannerTint ?? this.brandBannerTint,
      brandHeaderBg: brandHeaderBg ?? this.brandHeaderBg,
    );
  }

  @override
  ChatColors lerp(ThemeExtension<ChatColors>? other, double t) {
    if (other is! ChatColors) return this;
    return ChatColors(
      bubbleOther: Color.lerp(bubbleOther, other.bubbleOther, t)!,
      receivedText: Color.lerp(receivedText, other.receivedText, t)!,
      messageSelectedBg: Color.lerp(
        messageSelectedBg,
        other.messageSelectedBg,
        t,
      )!,
      senderNameText: Color.lerp(senderNameText, other.senderNameText, t)!,
      timeSeparatorText: Color.lerp(
        timeSeparatorText,
        other.timeSeparatorText,
        t,
      )!,
      translatedText: Color.lerp(translatedText, other.translatedText, t)!,
      translatedAccent: Color.lerp(
        translatedAccent,
        other.translatedAccent,
        t,
      )!,
      pollTrack: Color.lerp(pollTrack, other.pollTrack, t)!,
      subtleFill: Color.lerp(subtleFill, other.subtleFill, t)!,
      subtleFillWeak: Color.lerp(subtleFillWeak, other.subtleFillWeak, t)!,
      chipFill: Color.lerp(chipFill, other.chipFill, t)!,
      insetFill: Color.lerp(insetFill, other.insetFill, t)!,
      codeInlineBg: Color.lerp(codeInlineBg, other.codeInlineBg, t)!,
      meterTrack: Color.lerp(meterTrack, other.meterTrack, t)!,
      tileFillFaint: Color.lerp(tileFillFaint, other.tileFillFaint, t)!,
      selectedTileFill: Color.lerp(
        selectedTileFill,
        other.selectedTileFill,
        t,
      )!,
      cardFillSubtle: Color.lerp(cardFillSubtle, other.cardFillSubtle, t)!,
      placeholderTile: Color.lerp(placeholderTile, other.placeholderTile, t)!,
      verificationCellBg: Color.lerp(
        verificationCellBg,
        other.verificationCellBg,
        t,
      )!,
      searchFieldFill: Color.lerp(searchFieldFill, other.searchFieldFill, t)!,
      linkFieldFill: Color.lerp(linkFieldFill, other.linkFieldFill, t)!,
      sheetDivider: Color.lerp(sheetDivider, other.sheetDivider, t)!,
      chipBg: Color.lerp(chipBg, other.chipBg, t)!,
      trackBg: Color.lerp(trackBg, other.trackBg, t)!,
      optionTileBg: Color.lerp(optionTileBg, other.optionTileBg, t)!,
      disabledFill: Color.lerp(disabledFill, other.disabledFill, t)!,
      buttonDisabledBg: Color.lerp(
        buttonDisabledBg,
        other.buttonDisabledBg,
        t,
      )!,
      formFieldFill: Color.lerp(formFieldFill, other.formFieldFill, t)!,
      secondaryButtonBg: Color.lerp(
        secondaryButtonBg,
        other.secondaryButtonBg,
        t,
      )!,
      recessedFill: Color.lerp(recessedFill, other.recessedFill, t)!,
      welcomeBg: Color.lerp(welcomeBg, other.welcomeBg, t)!,
      avatarPlaceholderBg: Color.lerp(
        avatarPlaceholderBg,
        other.avatarPlaceholderBg,
        t,
      )!,
      avatarPlaceholderFg: Color.lerp(
        avatarPlaceholderFg,
        other.avatarPlaceholderFg,
        t,
      )!,
      dragHandle: Color.lerp(dragHandle, other.dragHandle, t)!,
      selfDestructBg: Color.lerp(selfDestructBg, other.selfDestructBg, t)!,
      selfDestructBorder: Color.lerp(
        selfDestructBorder,
        other.selfDestructBorder,
        t,
      )!,
      mutedIcon: Color.lerp(mutedIcon, other.mutedIcon, t)!,
      emptyStateIcon: Color.lerp(emptyStateIcon, other.emptyStateIcon, t)!,
      graphEdge: Color.lerp(graphEdge, other.graphEdge, t)!,
      mutedBadge: Color.lerp(mutedBadge, other.mutedBadge, t)!,
      captionText: Color.lerp(captionText, other.captionText, t)!,
      dateHeaderText: Color.lerp(dateHeaderText, other.dateHeaderText, t)!,
      chipLabelText: Color.lerp(chipLabelText, other.chipLabelText, t)!,
      warningText: Color.lerp(warningText, other.warningText, t)!,
      menuAccentText: Color.lerp(menuAccentText, other.menuAccentText, t)!,
      menuLinkText: Color.lerp(menuLinkText, other.menuLinkText, t)!,
      codeKeyword: Color.lerp(codeKeyword, other.codeKeyword, t)!,
      codeString: Color.lerp(codeString, other.codeString, t)!,
      codeComment: Color.lerp(codeComment, other.codeComment, t)!,
      codeLiteral: Color.lerp(codeLiteral, other.codeLiteral, t)!,
      codeText: Color.lerp(codeText, other.codeText, t)!,
      codeBlockBg: Color.lerp(codeBlockBg, other.codeBlockBg, t)!,
      redPacketFieldBg: Color.lerp(
        redPacketFieldBg,
        other.redPacketFieldBg,
        t,
      )!,
      redPacketDisabledBg: Color.lerp(
        redPacketDisabledBg,
        other.redPacketDisabledBg,
        t,
      )!,
      redPacketDisabledFg: Color.lerp(
        redPacketDisabledFg,
        other.redPacketDisabledFg,
        t,
      )!,
      qrPresetN42: Color.lerp(qrPresetN42, other.qrPresetN42, t)!,
      qrPresetClassic: Color.lerp(qrPresetClassic, other.qrPresetClassic, t)!,
      qrPresetOcean: Color.lerp(qrPresetOcean, other.qrPresetOcean, t)!,
      qrPresetBerry: Color.lerp(qrPresetBerry, other.qrPresetBerry, t)!,
      momentCoverStart: Color.lerp(
        momentCoverStart,
        other.momentCoverStart,
        t,
      )!,
      momentCoverEnd: Color.lerp(momentCoverEnd, other.momentCoverEnd, t)!,
      appleButtonBg: Color.lerp(appleButtonBg, other.appleButtonBg, t)!,
      appleButtonFg: Color.lerp(appleButtonFg, other.appleButtonFg, t)!,
      brandTintFaint: BrandTint.lerp(brandTintFaint, other.brandTintFaint, t),
      brandTintSoft: BrandTint.lerp(brandTintSoft, other.brandTintSoft, t),
      brandTint: BrandTint.lerp(brandTint, other.brandTint, t),
      brandChipTint: BrandTint.lerp(brandChipTint, other.brandChipTint, t),
      brandTintStrong: BrandTint.lerp(
        brandTintStrong,
        other.brandTintStrong,
        t,
      ),
      brandSelectedTint: BrandTint.lerp(
        brandSelectedTint,
        other.brandSelectedTint,
        t,
      ),
      brandBannerTint: BrandTint.lerp(
        brandBannerTint,
        other.brandBannerTint,
        t,
      ),
      brandHeaderBg: BrandTint.lerp(brandHeaderBg, other.brandHeaderBg, t),
    );
  }
}
