import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/chat_colors.dart';
import '../../../core/theme/app_dimensions.dart';

/// 翻译结果显示组件（微信风格）
///
/// 显示在消息气泡正下方，与气泡内容区域对齐（跳过头像位置）。
/// 布局：翻译文本 + 底部 "✓ Translated by N42" 标签。
class TranslatedMessageWidget extends StatelessWidget {
  final String translatedText;
  final String? detectedSourceLanguage;
  final bool isTranslating;
  final VoidCallback? onClearTranslation;
  final bool isFromMe;

  /// 是否为原文显示模式（智能回复翻译的原文）
  final bool isOriginalDisplay;

  // 头像宽度(40) + 间距(8) + 外边距(12) = 60
  static const double _avatarOffset = 60.0;
  static const double _outerPadding = 12.0;

  const TranslatedMessageWidget({
    super.key,
    required this.translatedText,
    this.detectedSourceLanguage,
    this.isTranslating = false,
    this.onClearTranslation,
    this.isFromMe = false,
    this.isOriginalDisplay = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    if (isTranslating) {
      return _buildTranslatingIndicator(context, l10n);
    }

    // 微信风格：翻译块紧贴消息气泡下方，与气泡内容区域对齐
    return Container(
      margin: EdgeInsets.only(
        top: 2,
        left: isFromMe ? _outerPadding : _avatarOffset,
        right: isFromMe ? _avatarOffset : _outerPadding,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingM,
        vertical: AppDimensions.spacingS,
      ),
      decoration: BoxDecoration(
        color: ChatColors.of(context).insetFill,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Column(
        crossAxisAlignment: isFromMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // 翻译内容
          Text(
            translatedText,
            style: TextStyle(
              fontSize: 15,
              color: ChatColors.of(context).translatedText,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          // 底部标签
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isOriginalDisplay ? Icons.edit : Icons.check_circle,
                size: 12,
                color: isOriginalDisplay
                    ? context.textSupporting
                    : ChatColors.of(context).translatedAccent,
              ),
              const SizedBox(width: AppDimensions.spacingXS),
              Text(
                isOriginalDisplay
                    ? (l10n?.chatOriginalMessage ?? 'Original text')
                    : _getTranslationLabel(l10n),
                // textTertiary measured 1.6-1.9:1 (HIG color).
                style: TextStyle(fontSize: 11, color: context.textSupporting),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTranslatingIndicator(BuildContext context, S? l10n) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppDimensions.spacingXS,
        left: isFromMe ? _outerPadding : _avatarOffset,
        right: isFromMe ? _avatarOffset : _outerPadding,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: AppDimensions.spacingM,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(context.textSupporting),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            l10n?.commonTranslating ?? 'Translating...',
            style: TextStyle(fontSize: 12, color: context.textSupporting),
          ),
        ],
      ),
    );
  }

  String _getTranslationLabel(S? l10n) {
    if (detectedSourceLanguage != null) {
      final langName = _getLanguageName(detectedSourceLanguage!);
      return l10n?.ui3TranslatedFromByN42(langName) ??
          'Translated from $langName by N42';
    }
    return l10n?.ui3TranslatedByN42 ?? 'Translated by N42';
  }

  static String _getLanguageName(String code) {
    const languageNames = {
      'ar': 'Arabic',
      'bn': 'Bengali',
      'cs': 'Czech',
      'de': 'German',
      'en': 'English',
      'es': 'Spanish',
      'fr': 'French',
      'hi': 'Hindi',
      'id': 'Indonesian',
      'it': 'Italian',
      'ja': 'Japanese',
      'ko': 'Korean',
      'mr': 'Marathi',
      'pl': 'Polish',
      'pt': 'Portuguese',
      'pt-BR': 'Portuguese (Brazil)',
      'pt_BR': 'Portuguese (Brazil)',
      'ru': 'Russian',
      'sw': 'Swahili',
      'ta': 'Tamil',
      'te': 'Telugu',
      'tr': 'Turkish',
      'uk': 'Ukrainian',
      'ur': 'Urdu',
      'vi': 'Vietnamese',
      'zh': 'Chinese',
      'zh-CN': 'Chinese',
      'zh-TW': 'Traditional Chinese',
      'zh_TW': 'Traditional Chinese',
    };
    return languageNames[code] ?? code;
  }
}
