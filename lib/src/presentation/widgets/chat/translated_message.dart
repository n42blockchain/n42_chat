import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';

/// 翻译结果显示组件
///
/// 显示在消息气泡下方，展示翻译后的文本
class TranslatedMessageWidget extends StatelessWidget {
  /// 翻译后的文本
  final String translatedText;

  /// 检测到的源语言
  final String? detectedSourceLanguage;

  /// 是否正在翻译
  final bool isTranslating;

  /// 清除翻译回调
  final VoidCallback? onClearTranslation;

  /// 是否显示在自己发送的消息下方
  final bool isFromMe;

  const TranslatedMessageWidget({
    super.key,
    required this.translatedText,
    this.detectedSourceLanguage,
    this.isTranslating = false,
    this.onClearTranslation,
    this.isFromMe = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = S.of(context);

    if (isTranslating) {
      return _buildTranslatingIndicator(isDark, l10n);
    }

    return Container(
      margin: EdgeInsets.only(
        top: 4,
        left: isFromMe ? 60 : 0,
        right: isFromMe ? 0 : 60,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.08),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isFromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // 翻译标签和语言
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.translate,
                size: 12,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
              const SizedBox(width: 4),
              Text(
                _getTranslationLabel(l10n),
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
              ),
              if (onClearTranslation != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onClearTranslation,
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          // 翻译内容
          Text(
            translatedText,
            style: TextStyle(
              fontSize: 15,
              color: isDark ? Colors.white.withValues(alpha: 0.9) : AppColors.textPrimary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslatingIndicator(bool isDark, S? l10n) {
    return Container(
      margin: EdgeInsets.only(
        top: 4,
        left: isFromMe ? 60 : 0,
        right: isFromMe ? 0 : 60,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                isDark ? Colors.white54 : Colors.black45,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            l10n?.commonTranslating ?? 'Translating...',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  String _getTranslationLabel(S? l10n) {
    if (detectedSourceLanguage != null) {
      final langName = _getLanguageName(detectedSourceLanguage!);
      return '${l10n?.commonTranslatedFrom ?? 'Translated from'} $langName';
    }
    return l10n?.commonTranslation ?? 'Translation';
  }

  String _getLanguageName(String code) {
    const languageNames = {
      'zh': 'Chinese',
      'en': 'English',
      'ja': 'Japanese',
      'ko': 'Korean',
      'fr': 'French',
      'de': 'German',
      'es': 'Spanish',
      'pt': 'Portuguese',
      'ru': 'Russian',
      'ar': 'Arabic',
    };
    return languageNames[code] ?? code;
  }
}

/// 翻译失败提示组件
class TranslationErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetry;
  final bool isFromMe;

  const TranslationErrorWidget({
    super.key,
    this.errorMessage,
    this.onRetry,
    this.isFromMe = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = S.of(context);

    return Container(
      margin: EdgeInsets.only(
        top: 4,
        left: isFromMe ? 60 : 0,
        right: isFromMe ? 0 : 60,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 14,
            color: AppColors.error.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 4),
          Text(
            l10n?.commonTranslationFailed ?? 'Translation failed',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white54 : Colors.black54,
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onRetry,
              child: Text(
                l10n?.commonRetry ?? 'Retry',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
