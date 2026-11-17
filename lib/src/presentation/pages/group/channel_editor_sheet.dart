import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';

class ChannelEditorDraft {
  final String name;
  final String? topic;
  final String? category;

  const ChannelEditorDraft({required this.name, this.topic, this.category});
}

Future<ChannelEditorDraft?> showChannelEditorSheet(
  BuildContext context, {
  required String title,
  required String confirmLabel,
  String? initialName,
  String? initialTopic,
  String? initialCategory,
}) {
  return showModalBottomSheet<ChannelEditorDraft>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return _ChannelEditorSheet(
        title: title,
        confirmLabel: confirmLabel,
        initialName: initialName,
        initialTopic: initialTopic,
        initialCategory: initialCategory,
      );
    },
  );
}

class _ChannelEditorSheet extends StatefulWidget {
  final String title;
  final String confirmLabel;
  final String? initialName;
  final String? initialTopic;
  final String? initialCategory;

  const _ChannelEditorSheet({
    required this.title,
    required this.confirmLabel,
    this.initialName,
    this.initialTopic,
    this.initialCategory,
  });

  @override
  State<_ChannelEditorSheet> createState() => _ChannelEditorSheetState();
}

class _ChannelEditorSheetState extends State<_ChannelEditorSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _topicController;
  late final TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _topicController = TextEditingController(text: widget.initialTopic ?? '');
    _categoryController = TextEditingController(
      text: widget.initialCategory ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _topicController.dispose();
    _categoryController.dispose();
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      tooltip: MaterialLocalizations.of(
                        context,
                      ).closeButtonTooltip,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacing),
                TextField(
                  controller: _nameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: l10n?.groupChannelName ?? 'Channel Name',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.tag),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingM),
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText:
                        l10n?.ui3ChannelCategoryOptional ??
                        'Category (optional)',
                    hintText:
                        l10n?.ui3ChannelCategoryHint ??
                        'Announcements / Product / Support',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.folder_outlined),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingM),
                TextField(
                  controller: _topicController,
                  decoration: InputDecoration(
                    labelText:
                        l10n?.ui3DescriptionOptional ??
                        'Description (optional)',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingL),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryFillOf(context),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _submit,
                    child: Text(
                      widget.confirmLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      return;
    }

    final topic = _topicController.text.trim();
    final category = _categoryController.text.trim();

    Navigator.of(context).pop(
      ChannelEditorDraft(
        name: name,
        topic: topic.isEmpty ? null : topic,
        category: category.isEmpty ? null : category,
      ),
    );
  }
}
