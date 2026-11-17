import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/event_message_data.dart';
import '../../../core/theme/app_dimensions.dart';

/// 弹出日程/事件编辑面板，返回填好的 [EventMessageData]（取消返回 null）。
Future<EventMessageData?> showEventComposerSheet(BuildContext context) {
  return showModalBottomSheet<EventMessageData>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _EventComposerSheet(),
  );
}

class _EventComposerSheet extends StatefulWidget {
  const _EventComposerSheet();

  @override
  State<_EventComposerSheet> createState() => _EventComposerSheetState();
}

class _EventComposerSheetState extends State<_EventComposerSheet> {
  final _titleC = TextEditingController();
  final _locationC = TextEditingController();
  final _descC = TextEditingController();

  DateTime _start = _roundedNow();
  DateTime? _end;
  String? _error;

  static DateTime _roundedNow() {
    final now = DateTime.now().add(const Duration(hours: 1));
    return DateTime(now.year, now.month, now.day, now.hour);
  }

  @override
  void dispose() {
    _titleC.dispose();
    _locationC.dispose();
    _descC.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDateTime(DateTime initial) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(initial.year - 1),
      lastDate: DateTime(initial.year + 5),
    );
    if (date == null || !mounted) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null || !mounted) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void _submit() {
    final title = _titleC.text.trim();
    if (title.isEmpty) {
      setState(
        () => _error =
            S.of(context)?.ui3EventTitleRequired ?? 'Title is required',
      );
      return;
    }
    if (_end != null && !_end!.isAfter(_start)) {
      setState(
        () => _error =
            S.of(context)?.ui3EventEndAfterStart ??
            'End time must be after start',
      );
      return;
    }
    Navigator.pop(
      context,
      EventMessageData(
        title: title,
        startsAt: _start,
        endsAt: _end,
        location: _locationC.text.trim(),
        description: _descC.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 16 + bottom),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.event, color: AppColors.primaryOf(context)),
                const SizedBox(width: AppDimensions.spacingS),
                Text(
                  s?.ui3EventNew ?? 'New Event',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spacing),
            TextField(
              controller: _titleC,
              autofocus: true,
              style: TextStyle(color: context.textPrimary),
              decoration: InputDecoration(
                labelText: s?.ui3EventTitleLabel ?? 'Title',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            _dateTile(
              label: s?.settingsStartTime ?? 'Start Time',
              value: EventMessageData.formatLocal(_start),
              onTap: () async {
                final picked = await _pickDateTime(_start);
                if (picked != null) {
                  setState(() {
                    _start = picked;
                    if (_end != null && !_end!.isAfter(_start)) _end = null;
                  });
                }
              },
            ),
            _dateTile(
              label: s?.settingsEndTime ?? 'End Time',
              value: _end != null
                  ? EventMessageData.formatLocal(_end!)
                  : (s?.authOptional ?? 'Optional'),
              onTap: () async {
                final picked = await _pickDateTime(
                  _end ?? _start.add(const Duration(hours: 1)),
                );
                if (picked != null) setState(() => _end = picked);
              },
              onClear: _end != null ? () => setState(() => _end = null) : null,
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextField(
              controller: _locationC,
              style: TextStyle(color: context.textPrimary),
              decoration: InputDecoration(
                labelText:
                    s?.ui3EventLocationOptional ?? 'Location (optional)',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextField(
              controller: _descC,
              maxLines: 3,
              style: TextStyle(color: context.textPrimary),
              decoration: InputDecoration(
                labelText:
                    s?.ui3EventDescriptionOptional ?? 'Description (optional)',
                border: const OutlineInputBorder(),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: AppDimensions.spacingS),
              Text(
                _error!,
                // errorFill keeps the message at 4.5:1 on the light sheet.
                style: TextStyle(
                  color: context.isDarkMode
                      ? AppColors.error
                      : AppColors.errorFill,
                  fontSize: 13,
                ),
              ),
            ],
            const SizedBox(height: AppDimensions.spacing),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text(s?.ui3EventSend ?? 'Send Event'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateTile({
    required String label,
    required String value,
    required VoidCallback onTap,
    VoidCallback? onClear,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        // 24 + 20 padding keeps the row at the 44pt minimum when no clear
        // button is shown.
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 24),
          child: Row(
            children: [
              Icon(Icons.schedule, size: 18, color: context.textSecondary),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(fontSize: 15, color: context.textPrimary),
              ),
              const Spacer(),
              Text(
                value,
                style: TextStyle(fontSize: 14, color: context.textSupporting),
              ),
              if (onClear != null)
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 16,
                    color: context.textSecondary,
                  ),
                  tooltip: S.of(context)?.commonClear ?? 'Clear',
                  onPressed: onClear,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
