import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/ai_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';

/// AI 消息改写建议栏
///
/// 在输入框上方展示，提供语气选项和改写预览
class AiRewriteBar extends StatelessWidget {
  /// 原始文本
  final String originalText;

  /// 改写结果
  final String? rewrittenText;

  /// 是否正在改写
  final bool isRewriting;

  /// 语气选择回调
  final void Function(AiTone tone)? onToneSelected;

  /// 确认使用改写结果
  final void Function(String rewrittenText)? onAccept;

  /// 取消改写
  final VoidCallback? onDismiss;

  /// 当前选择的语气
  final AiTone? selectedTone;

  const AiRewriteBar({
    super.key,
    required this.originalText,
    this.rewrittenText,
    this.isRewriting = false,
    this.onToneSelected,
    this.onAccept,
    this.onDismiss,
    this.selectedTone,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = S.of(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceOf(isDark),
        border: Border(
          top: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 标题栏
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
            child: Row(
              children: [
                const Icon(Icons.auto_fix_high, size: 16, color: AppColors.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    l10n?.aiRewrite ?? 'AI Rewrite',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Semantics(
                  button: true,
                  label: MaterialLocalizations.of(context).closeButtonTooltip,
                  excludeSemantics: true,
                  child: GestureDetector(
                    onTap: onDismiss,
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: AppColors.textTertiaryOf(isDark),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 语气选项
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingM, vertical: AppDimensions.spacingXS),
            child: Row(
              children: AiTone.values.map((tone) {
                final isSelected = selectedTone == tone;
                return Padding(
                  padding: const EdgeInsets.only(right: AppDimensions.spacingS),
                  child: _ToneChip(
                    tone: tone,
                    isSelected: isSelected,
                    onTap: () => onToneSelected?.call(tone),
                  ),
                );
              }).toList(),
            ),
          ),

          // 改写结果预览
          if (isRewriting)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
              child: Row(
                children: [
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingS),
                  Text(
                    l10n?.aiRewriteLoading ?? 'Rewriting...',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textTertiaryOf(isDark),
                    ),
                  ),
                ],
              ),
            )
          else if (rewrittenText != null) ...[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingM),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: isDark ? 0.1 : 0.05),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Text(
                rewrittenText!,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimaryOf(isDark),
                  height: 1.4,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // 确认/取消按钮
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onDismiss,
                    child: Text(
                      l10n?.aiRewriteCancel ?? 'Cancel',
                      style: TextStyle(
                        color: AppColors.textTertiaryOf(isDark),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingS),
                  ElevatedButton(
                    onPressed: () => onAccept?.call(rewrittenText!),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingL, vertical: AppDimensions.spacingS),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(l10n?.aiRewriteAccept ?? 'Use this', style: const TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ToneChip extends StatelessWidget {
  final AiTone tone;
  final bool isSelected;
  final VoidCallback? onTap;

  const _ToneChip({
    required this.tone,
    required this.isSelected,
    this.onTap,
  });

  String _label(S? l10n) => switch (tone) {
    AiTone.formal => '📝 ${l10n?.aiRewriteFormal ?? "Formal"}',
    AiTone.casual => '😊 ${l10n?.aiRewriteCasual ?? "Casual"}',
    AiTone.playful => '🎉 ${l10n?.aiRewritePlayful ?? "Playful"}',
    AiTone.professional => '💼 ${l10n?.aiRewriteProfessional ?? "Professional"}',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = S.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingM, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : AppColors.inputBgOf(isDark),
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          border: isSelected
              ? null
              : Border.all(
                  color: AppColors.dividerOf(isDark),
                ),
        ),
        child: Text(
          _label(l10n),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? Colors.white
                : AppColors.textSecondaryOf(isDark),
          ),
        ),
      ),
    );
  }
}
