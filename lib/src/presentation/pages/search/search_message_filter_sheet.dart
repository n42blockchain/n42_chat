import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/entities/search_result_entity.dart';
import '../../../core/theme/app_dimensions.dart';

Future<MessageSearchFilter?> showMessageSearchFilterSheet(
  BuildContext context, {
  required MessageSearchFilter currentFilter,
}) {
  return showModalBottomSheet<MessageSearchFilter?>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return _SearchMessageFilterSheet(currentFilter: currentFilter);
    },
  );
}

class _SearchMessageFilterSheet extends StatefulWidget {
  final MessageSearchFilter currentFilter;

  const _SearchMessageFilterSheet({required this.currentFilter});

  @override
  State<_SearchMessageFilterSheet> createState() =>
      _SearchMessageFilterSheetState();
}

class _SearchMessageFilterSheetState extends State<_SearchMessageFilterSheet> {
  late final TextEditingController _senderController;
  late MessageType? _messageType;
  late bool _onlyFromMe;
  late bool _hasMediaOnly;
  late _RelativeDateFilter _relativeDate;

  @override
  void initState() {
    super.initState();
    _senderController = TextEditingController(
      text: widget.currentFilter.senderId ?? '',
    );
    _messageType = widget.currentFilter.messageType;
    _onlyFromMe = widget.currentFilter.onlyFromMe;
    _hasMediaOnly = widget.currentFilter.hasMediaOnly;
    _relativeDate = _RelativeDateFilter.fromSentAfter(
      widget.currentFilter.sentAfter,
    );
  }

  @override
  void dispose() {
    _senderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n?.ui3MessageFilters ?? 'Message Filters',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _clearAll,
                        child: Text(l10n?.commonClear ?? 'Clear'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacingM),
                  TextField(
                    controller: _senderController,
                    decoration: InputDecoration(
                      labelText: l10n?.ui3SenderUserId ?? 'Sender User ID',
                      hintText: '@alice:example.com',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.alternate_email),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n?.ui3FilterType ?? 'Type',
                    style: TextStyle(
                      fontSize: 13,
                      color: context.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingS),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildTypeChip(
                        context,
                        null,
                        l10n?.ui3FilterAny ?? 'Any',
                      ),
                      _buildTypeChip(
                        context,
                        MessageType.text,
                        l10n?.favoriteText ?? 'Text',
                      ),
                      _buildTypeChip(
                        context,
                        MessageType.image,
                        l10n?.ui3FilterImage ?? 'Image',
                      ),
                      _buildTypeChip(
                        context,
                        MessageType.video,
                        l10n?.chatVideoTitle ?? 'Video',
                      ),
                      _buildTypeChip(
                        context,
                        MessageType.audio,
                        l10n?.mediaAudio ?? 'Audio',
                      ),
                      _buildTypeChip(
                        context,
                        MessageType.file,
                        l10n?.commonFileLabel ?? 'File',
                      ),
                      _buildTypeChip(
                        context,
                        MessageType.poll,
                        l10n?.commonPoll ?? 'Poll',
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n?.ui3FilterTime ?? 'Time',
                    style: TextStyle(
                      fontSize: 13,
                      color: context.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingS),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _RelativeDateFilter.values.map((value) {
                      final selected = value == _relativeDate;
                      return ChoiceChip(
                        label: Text(
                          value == _RelativeDateFilter.anytime
                              ? l10n?.ui3AnyTime ?? value.label
                              : value.label,
                        ),
                        selected: selected,
                        onSelected: (_) =>
                            setState(() => _relativeDate = value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppDimensions.spacingS),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n?.ui3OnlyMyMessages ?? 'Only my messages'),
                    value: _onlyFromMe,
                    onChanged: (value) => setState(() => _onlyFromMe = value),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n?.ui3MediaOnly ?? 'Media only'),
                    value: _hasMediaOnly,
                    onChanged: (value) => setState(() => _hasMediaOnly = value),
                  ),
                  const SizedBox(height: AppDimensions.spacingS),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryFillOf(context),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _apply,
                      child: Text(
                        l10n?.ui3Apply ?? 'Apply',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeChip(BuildContext context, MessageType? type, String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _messageType == type,
      onSelected: (_) => setState(() => _messageType = type),
    );
  }

  void _clearAll() {
    setState(() {
      _senderController.clear();
      _messageType = null;
      _onlyFromMe = false;
      _hasMediaOnly = false;
      _relativeDate = _RelativeDateFilter.anytime;
    });
  }

  void _apply() {
    final now = DateTime.now();
    DateTime? sentAfter;
    switch (_relativeDate) {
      case _RelativeDateFilter.anytime:
        sentAfter = null;
        break;
      case _RelativeDateFilter.last24Hours:
        sentAfter = now.subtract(const Duration(hours: 24));
        break;
      case _RelativeDateFilter.last7Days:
        sentAfter = now.subtract(const Duration(days: 7));
        break;
      case _RelativeDateFilter.last30Days:
        sentAfter = now.subtract(const Duration(days: 30));
        break;
    }

    final senderId = _senderController.text.trim();
    final filter = MessageSearchFilter(
      senderId: senderId.isEmpty ? null : senderId,
      messageType: _messageType,
      sentAfter: sentAfter,
      onlyFromMe: _onlyFromMe,
      hasMediaOnly: _hasMediaOnly,
    );

    Navigator.of(context).pop(filter.isEmpty ? null : filter);
  }
}

enum _RelativeDateFilter {
  anytime('Any time'),
  last24Hours('24h'),
  last7Days('7d'),
  last30Days('30d');

  final String label;

  const _RelativeDateFilter(this.label);

  static _RelativeDateFilter fromSentAfter(DateTime? sentAfter) {
    if (sentAfter == null) {
      return _RelativeDateFilter.anytime;
    }

    final delta = DateTime.now().difference(sentAfter);
    if (delta <= const Duration(hours: 24)) {
      return _RelativeDateFilter.last24Hours;
    }
    if (delta <= const Duration(days: 7)) {
      return _RelativeDateFilter.last7Days;
    }
    if (delta <= const Duration(days: 30)) {
      return _RelativeDateFilter.last30Days;
    }
    return _RelativeDateFilter.anytime;
  }
}
