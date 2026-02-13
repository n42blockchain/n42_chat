import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/chat_export_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/message_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 聊天记录导出页面
class ChatExportPage extends StatefulWidget {
  final String roomName;
  final String? roomId;
  final List<MessageEntity> messages;

  const ChatExportPage({
    super.key,
    required this.roomName,
    this.roomId,
    this.messages = const [],
  });

  @override
  State<ChatExportPage> createState() => _ChatExportPageState();
}

class _ChatExportPageState extends State<ChatExportPage> {
  ExportFormat _format = ExportFormat.html;
  ExportDateRange _dateRange = ExportDateRange.all;
  bool _isExporting = false;

  int get _filteredCount {
    final now = DateTime.now();
    DateTime? start;
    switch (_dateRange) {
      case ExportDateRange.all:
        return widget.messages.length;
      case ExportDateRange.lastWeek:
        start = now.subtract(const Duration(days: 7));
      case ExportDateRange.lastMonth:
        start = DateTime(now.year, now.month - 1, now.day);
      case ExportDateRange.last3Months:
        start = DateTime(now.year, now.month - 3, now.day);
      case ExportDateRange.custom:
        return widget.messages.length;
    }
    return widget.messages.where((m) => m.timestamp.isAfter(start!)).length;
  }

  Future<void> _export() async {
    setState(() => _isExporting = true);

    try {
      await ChatExportService.instance.exportAndShare(
        messages: widget.messages,
        roomName: widget.roomName,
        format: _format,
        dateRange: _dateRange,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.chatExportSuccess ?? 'Export successful')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.chatExportFailed(e.toString()) ?? 'Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: S.of(context)?.chatExportTitle ?? 'Export Chat',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // 导出格式
          _buildSection(
            title: S.of(context)?.chatExportFormat ?? 'Export Format',
            isDark: isDark,
            child: RadioGroup<ExportFormat>(
              groupValue: _format,
              onChanged: (v) => setState(() => _format = v!),
              child: Column(
                children: [
                  _buildRadioTile(
                    title: 'HTML',
                    subtitle: S.of(context)?.chatExportHtmlDesc ?? 'Readable in any browser with styled layout',
                    value: ExportFormat.html,
                    isDark: isDark,
                  ),
                  Divider(height: 1, indent: 56, color: isDark ? AppColors.dividerDark : AppColors.divider),
                  _buildRadioTile(
                    title: 'JSON',
                    subtitle: S.of(context)?.chatExportJsonDesc ?? 'Machine-readable structured data format',
                    value: ExportFormat.json,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 日期范围
          _buildSection(
            title: S.of(context)?.chatExportDateRange ?? 'Date Range',
            isDark: isDark,
            child: RadioGroup<ExportDateRange>(
              groupValue: _dateRange,
              onChanged: (v) => setState(() => _dateRange = v!),
              child: Column(
                children: [
                  for (final range in [
                    (ExportDateRange.all, S.of(context)?.chatExportAll ?? 'All Messages'),
                    (ExportDateRange.lastWeek, S.of(context)?.chatExportLastWeek ?? 'Last 7 Days'),
                    (ExportDateRange.lastMonth, S.of(context)?.chatExportLastMonth ?? 'Last Month'),
                    (ExportDateRange.last3Months, S.of(context)?.chatExportLast3Months ?? 'Last 3 Months'),
                  ]) ...[
                    _buildRadioTile(
                      title: range.$2,
                      value: range.$1,
                      isDark: isDark,
                    ),
                    if (range.$1 != ExportDateRange.last3Months)
                      Divider(height: 1, indent: 56, color: isDark ? AppColors.dividerDark : AppColors.divider),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 统计信息
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 20, color: Colors.blue[700]),
                const SizedBox(width: 12),
                Text(
                  '${S.of(context)?.chatExportMessageCount ?? "Messages to export"}: $_filteredCount',
                  style: TextStyle(fontSize: 14, color: Colors.blue[700]),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // 导出按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: _isExporting || _filteredCount == 0 ? null : _export,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isExporting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Text(
                      S.of(context)?.chatExportButton ?? 'Export & Share',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required bool isDark,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
        ),
        Container(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          child: child,
        ),
      ],
    );
  }

  Widget _buildRadioTile<T>({
    required String title,
    String? subtitle,
    required T value,
    required bool isDark,
  }) {
    return RadioListTile<T>(
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : AppColors.textPrimary,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
            )
          : null,
      value: value,
      activeColor: AppColors.primary,
    );
  }
}
