import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/chat_colors.dart';
import '../../../core/utils/a11y_l10n.dart';
import '../../../core/theme/app_dimensions.dart';
import '../common/n42_tap_area.dart';

/// AI 链接摘要卡片
///
/// 显示在 URL 预览下方，提供链接内容的 AI 摘要
class AiLinkSummaryCard extends StatefulWidget {
  /// 摘要文本
  final String? summary;

  /// 是否正在加载
  final bool isLoading;

  /// 生成摘要回调
  final VoidCallback? onGenerate;

  /// URL
  final String url;

  const AiLinkSummaryCard({
    super.key,
    this.summary,
    this.isLoading = false,
    this.onGenerate,
    required this.url,
  });

  @override
  State<AiLinkSummaryCard> createState() => _AiLinkSummaryCardState();
}

class _AiLinkSummaryCardState extends State<AiLinkSummaryCard> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = S.of(context);

    // 尚未生成摘要 → 显示触发按钮
    if (widget.summary == null && !widget.isLoading) {
      return _buildTriggerButton(isDark, l10n: l10n);
    }

    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ChatColors.of(context)
            .brandTintFaint(AppColors.primaryOf(context)),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: AppColors.primaryOf(context).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Semantics(
            button: true,
            label: A11yL10n.of(context).aiSummary,
            hint: _isExpanded
                ? A11yL10n.of(context).collapse
                : A11yL10n.of(context).expand,
            child: InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              // Header row grows to the 44pt minimum hit height.
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: N42TapArea.minTarget,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 14,
                      color: AppColors.primaryOf(context),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        l10n?.aiLinkSummary ?? 'AI Summary',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryOnTintOf(context),
                        ),
                      ),
                    ),
                    Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 16,
                      color: AppColors.textSecondaryOf(isDark),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (_isExpanded) ...[
            const SizedBox(height: 6),
            if (widget.isLoading)
              Row(
                children: [
                  SizedBox(
                    width: AppDimensions.spacingM,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primaryOf(context),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingS),
                  Text(
                    l10n?.aiLinkSummaryAnalyzing ?? 'Analyzing...',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryOnTintOf(context),
                    ),
                  ),
                ],
              )
            else
              SelectableText(
                widget.summary ?? '',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondaryOf(isDark),
                  height: 1.4,
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildTriggerButton(bool isDark, {S? l10n}) {
    return Semantics(
      button: true,
      label: l10n?.aiLinkSummary ?? 'AI Summary',
      // Keeps the tap action that excludeSemantics drops.
      onTap: widget.onGenerate,
      excludeSemantics: true,
      // 44pt hit area around the unchanged pill.
      child: N42TapArea(
        onTap: widget.onGenerate,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        child: Container(
          margin: const EdgeInsets.only(top: 6),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: ChatColors.of(context)
                .brandTintFaint(AppColors.primaryOf(context)),
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            border: Border.all(
              color: AppColors.primaryOf(context).withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome,
                size: 12,
                color: AppColors.primaryOf(context),
              ),
              const SizedBox(width: AppDimensions.spacingXS),
              Text(
                l10n?.aiLinkSummary ?? 'AI Summary',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.primaryOnTintOf(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
