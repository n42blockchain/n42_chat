import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/content_filter_entity.dart';
import '../../blocs/group/group_bloc.dart';
import '../../blocs/group/group_event.dart';
import '../../blocs/group/group_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 关键词过滤设置页面
class ContentFilterSettingsPage extends StatefulWidget {
  final String roomId;

  const ContentFilterSettingsPage({super.key, required this.roomId});

  @override
  State<ContentFilterSettingsPage> createState() => _ContentFilterSettingsPageState();
}

class _ContentFilterSettingsPageState extends State<ContentFilterSettingsPage> {
  bool _enabled = false;
  FilterAction _action = FilterAction.replace;
  final List<String> _forbiddenWords = [];
  final TextEditingController _wordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 从 GroupBloc 中读取当前配置
    final group = context.read<GroupBloc>().state.currentGroup;
    if (group != null) {
      _loadCurrentConfig();
    }
  }

  void _loadCurrentConfig() {
    // 通过 datasource 同步读取（需要通过 GroupRepository）
    // 这里先尝试从 GroupBloc state 的 currentGroup 中没有 filter，
    // 所以需要单独读取，暂时用 empty 初始值，保存时会完整更新
  }

  @override
  void dispose() {
    _wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = S.of(context);

    return BlocListener<GroupBloc, GroupState>(
      listener: (context, state) {
        if (state.status == GroupStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n?.groupContentFilterUpdated ?? 'Content filter updated'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: N42AppBar(
          title: l10n?.groupContentFilter ?? 'Content Filter',
          actions: [
            TextButton(
              onPressed: _save,
              child: Text(
                l10n?.commonConfirm ?? 'Save',
                style: const TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
        body: ListView(
          children: [
            const SizedBox(height: 10),
            Container(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              child: SwitchListTile(
                title: Text(l10n?.groupContentFilterEnabled ?? 'Enable Keyword Filter'),
                value: _enabled,
                onChanged: (v) => setState(() => _enabled = v),
              ),
            ),
            if (_enabled) ...[
              const SizedBox(height: 10),
              Container(
                color: isDark ? AppColors.surfaceDark : AppColors.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Text(
                        l10n?.groupContentFilterReplace ?? 'Action',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    RadioListTile<FilterAction>(
                      title: Text(l10n?.groupContentFilterReplace ?? 'Replace with ***'),
                      value: FilterAction.replace,
                      groupValue: _action,
                      onChanged: (v) => setState(() => _action = v!),
                    ),
                    RadioListTile<FilterAction>(
                      title: Text(l10n?.groupContentFilterHide ?? 'Hide Message'),
                      value: FilterAction.hide,
                      groupValue: _action,
                      onChanged: (v) => setState(() => _action = v!),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: isDark ? AppColors.surfaceDark : AppColors.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Text(
                        l10n?.groupContentFilterAddWord ?? 'Keywords',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _wordController,
                              decoration: InputDecoration(
                                hintText: l10n?.groupContentFilterAddWord ?? 'Add Keyword',
                                border: const OutlineInputBorder(),
                                isDense: true,
                              ),
                              onSubmitted: (_) => _addWord(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
                            onPressed: _addWord,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_forbiddenWords.isEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Text(
                          '—',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary,
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _forbiddenWords.map((word) {
                            return Chip(
                              label: Text(word),
                              onDeleted: () => setState(() => _forbiddenWords.remove(word)),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _addWord() {
    final word = _wordController.text.trim();
    if (word.isEmpty || _forbiddenWords.contains(word)) return;
    setState(() {
      _forbiddenWords.add(word);
      _wordController.clear();
    });
  }

  void _save() {
    context.read<GroupBloc>().add(SetContentFilter(
          widget.roomId,
          ContentFilterConfig(
            enabled: _enabled,
            forbiddenWords: List.from(_forbiddenWords),
            action: _action,
          ),
        ));
    Navigator.of(context).pop();
  }
}
