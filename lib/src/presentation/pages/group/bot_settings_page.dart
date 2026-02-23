import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/bot_config_entity.dart';
import '../../blocs/group/group_bloc.dart';
import '../../blocs/group/group_event.dart';
import '../../blocs/group/group_state.dart';
import '../../widgets/common/common_widgets.dart';

/// Bot 设置页面
class BotSettingsPage extends StatefulWidget {
  final String roomId;

  const BotSettingsPage({super.key, required this.roomId});

  @override
  State<BotSettingsPage> createState() => _BotSettingsPageState();
}

class _BotSettingsPageState extends State<BotSettingsPage> {
  bool _enabled = false;
  final TextEditingController _welcomeController = TextEditingController();

  @override
  void dispose() {
    _welcomeController.dispose();
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
              content: Text(l10n?.groupBotConfigUpdated ?? 'Bot settings updated'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: N42AppBar(
          title: l10n?.groupBotSettings ?? 'Bot Settings',
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
                title: Text(l10n?.groupBotEnabled ?? 'Enable Bot'),
                value: _enabled,
                onChanged: (v) => setState(() => _enabled = v),
              ),
            ),
            if (_enabled) ...[
              const SizedBox(height: 10),
              Container(
                color: isDark ? AppColors.surfaceDark : AppColors.surface,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.groupBotWelcomeMessage ?? 'Welcome Message Template',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _welcomeController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: l10n?.groupBotWelcomeHint ?? 'Use {name} as placeholder',
                        border: const OutlineInputBorder(),
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

  void _save() {
    context.read<GroupBloc>().add(SetBotConfig(
          widget.roomId,
          BotConfig(
            enabled: _enabled,
            welcomeMessage: _welcomeController.text.trim().isEmpty
                ? null
                : _welcomeController.text.trim(),
          ),
        ));
    Navigator.of(context).pop();
  }
}
