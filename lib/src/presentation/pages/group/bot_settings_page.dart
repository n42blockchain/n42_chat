import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/bot_webhook_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/chat_contrast.dart';
import '../../../core/utils/external_url_safety.dart';
import '../../../data/datasources/local/secure_storage_datasource.dart';
import '../../../domain/entities/bot_config_entity.dart';
import '../../../domain/repositories/group_repository.dart';
import '../../blocs/bloc_message_keys.dart';
import '../../blocs/group/group_bloc.dart';
import '../../blocs/group/group_event.dart';
import '../../blocs/group/group_state.dart';
import '../../helpers/bloc_message_helper.dart';
import '../../widgets/common/common_widgets.dart';
import '../../../core/theme/app_dimensions.dart';

/// Bot 设置页面
class BotSettingsPage extends StatefulWidget {
  final String roomId;

  const BotSettingsPage({super.key, required this.roomId});

  @override
  State<BotSettingsPage> createState() => _BotSettingsPageState();
}

class _BotSettingsPageState extends State<BotSettingsPage> {
  bool _enabled = false;
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isTestingWebhook = false;
  bool _webhookEnabled = false;
  bool _notifyMemberJoined = true;
  bool _notifyWelcomeSent = true;
  final TextEditingController _welcomeController = TextEditingController();
  final TextEditingController _webhookUrlController = TextEditingController();
  final TextEditingController _webhookSecretController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  @override
  void dispose() {
    _welcomeController.dispose();
    _webhookUrlController.dispose();
    _webhookSecretController.dispose();
    super.dispose();
  }

  Future<void> _loadConfig() async {
    try {
      final config = await getIt<IGroupRepository>().getBotConfig(
        widget.roomId,
      );
      final secureStorage = getIt<SecureStorageDataSource>();
      final storedWebhookSecret = await secureStorage.getRoomBotWebhookSecret(
        widget.roomId,
      );
      final migratedWebhookSecret =
          storedWebhookSecret ?? config?.webhookSecret;
      if (storedWebhookSecret == null &&
          migratedWebhookSecret != null &&
          migratedWebhookSecret.isNotEmpty) {
        await secureStorage.saveRoomBotWebhookSecret(
          widget.roomId,
          migratedWebhookSecret,
        );
      }
      if (!mounted) return;
      setState(() {
        _enabled = config?.enabled ?? false;
        _welcomeController.text = config?.welcomeMessage ?? '';
        _webhookUrlController.text = config?.webhookUrl ?? '';
        _webhookSecretController.text = migratedWebhookSecret ?? '';
        _webhookEnabled = config?.hasWebhook ?? false;
        _notifyMemberJoined =
            config?.webhookEvents.contains(
              BotAutomationEventType.memberJoined,
            ) ??
            true;
        _notifyWelcomeSent =
            config?.webhookEvents.contains(
              BotAutomationEventType.welcomeMessageSent,
            ) ??
            true;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocConsumer<GroupBloc, GroupState>(
      listener: (context, state) {
        if (!_isSaving) {
          return;
        }
        if (state.status == GroupStatus.success &&
            state.successMessage == BlocMessageKeys.groupBotConfigUpdated) {
          setState(() => _isSaving = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                resolveBlocMessage(
                  context,
                  state.successMessage ?? BlocMessageKeys.groupBotConfigUpdated,
                ),
              ),
              backgroundColor: ChatContrast.fillForWhiteText(AppColors.success),
            ),
          );
          Navigator.of(context).pop();
        } else if (state.status == GroupStatus.error &&
            state.errorMessage != null) {
          setState(() => _isSaving = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resolveBlocMessage(context, state.errorMessage!)),
              backgroundColor: AppColors.errorFill,
            ),
          );
        }
      },
      builder: (context, state) => Scaffold(
        appBar: N42AppBar(
          title: l10n?.groupBotSettings ?? 'Bot Settings',
          actions: [
            TextButton(
              onPressed: _isSaving ? null : _save,
              child: Text(
                l10n?.commonConfirm ?? 'Save',
                style: TextStyle(color: AppColors.primaryOf(context)),
              ),
            ),
          ],
        ),
        backgroundColor: context.pageBackground,
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const SizedBox(height: 10),
                  Material(
                    color: context.surfaceColor,
                    child: SwitchListTile(
                      title: Text(l10n?.groupBotEnabled ?? 'Enable Bot'),
                      value: _enabled,
                      onChanged: (v) => setState(() => _enabled = v),
                    ),
                  ),
                  if (_enabled) ...[
                    const SizedBox(height: 10),
                    Container(
                      color: context.surfaceColor,
                      padding: const EdgeInsets.all(AppDimensions.spacing),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n?.groupBotWelcomeMessage ??
                                'Welcome Message Template',
                            style: TextStyle(
                              fontSize: 13,
                              color: context.textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacingS),
                          TextField(
                            controller: _welcomeController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText:
                                  l10n?.groupBotWelcomeHint ??
                                  'Use {name} as placeholder',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Material(
                      color: context.surfaceColor,
                      child: SwitchListTile(
                        title: Text(
                          l10n?.ui3WebhookEnable ?? 'Enable webhook automation',
                        ),
                        subtitle: Text(
                          l10n?.ui3WebhookEnableDesc ??
                              'Post member-join and welcome events to your integration endpoint.',
                        ),
                        value: _webhookEnabled,
                        onChanged: (v) => setState(() => _webhookEnabled = v),
                      ),
                    ),
                    if (_webhookEnabled) ...[
                      const SizedBox(height: 10),
                      Container(
                        color: context.surfaceColor,
                        padding: const EdgeInsets.all(AppDimensions.spacing),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n?.ui3WebhookUrl ?? 'Webhook URL',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: AppDimensions.spacingS),
                            TextField(
                              controller: _webhookUrlController,
                              keyboardType: TextInputType.url,
                              decoration: const InputDecoration(
                                hintText: 'https://example.com/webhooks/n42',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: AppDimensions.spacingM),
                            Text(
                              l10n?.ui3WebhookSecretOptional ??
                                  'Signing Secret (optional)',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: AppDimensions.spacingS),
                            TextField(
                              controller: _webhookSecretController,
                              decoration: InputDecoration(
                                hintText:
                                    l10n?.ui3WebhookSecretHint ??
                                    'Used for X-N42-Signature',
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Material(
                        color: context.surfaceColor,
                        child: Column(
                          children: [
                            SwitchListTile(
                              title: Text(
                                l10n?.ui3WebhookNotifyMemberJoined ??
                                    'Notify when a member joins',
                              ),
                              value: _notifyMemberJoined,
                              onChanged: (v) =>
                                  setState(() => _notifyMemberJoined = v),
                            ),
                            SwitchListTile(
                              title: Text(
                                l10n?.ui3WebhookNotifyWelcomeSent ??
                                    'Notify when welcome is sent',
                              ),
                              value: _notifyWelcomeSent,
                              onChanged: (v) =>
                                  setState(() => _notifyWelcomeSent = v),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                  if (_enabled && _webhookEnabled)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                      child: OutlinedButton.icon(
                        onPressed: _isSaving || _isTestingWebhook
                            ? null
                            : _sendTestWebhook,
                        icon: _isTestingWebhook
                            ? const SizedBox(
                                width: AppDimensions.spacing,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.send_outlined),
                        label: Text(
                          _isTestingWebhook
                              ? l10n?.ui3WebhookTestSending ??
                                    'Sending test webhook...'
                              : l10n?.ui3WebhookTestSend ?? 'Send test webhook',
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  Set<BotAutomationEventType> _buildWebhookEvents() => {
    if (_notifyMemberJoined) BotAutomationEventType.memberJoined,
    if (_notifyWelcomeSent) BotAutomationEventType.welcomeMessageSent,
  };

  BotConfig _buildDraftConfig() {
    final normalizedWebhookUrl = _webhookEnabled
        ? _webhookUrlController.text.trim()
        : '';
    final webhookSecret = _webhookEnabled
        ? _webhookSecretController.text.trim()
        : '';

    return BotConfig(
      enabled: _enabled,
      welcomeMessage: _welcomeController.text.trim().isEmpty
          ? null
          : _welcomeController.text.trim(),
      webhookUrl: normalizedWebhookUrl.isEmpty ? null : normalizedWebhookUrl,
      webhookSecret: webhookSecret.isEmpty ? null : webhookSecret,
      webhookEvents: _webhookEnabled ? _buildWebhookEvents() : const {},
    );
  }

  String? _validateDraftConfig(BotConfig config) {
    if (!_webhookEnabled) {
      return null;
    }
    if (parseSafeExternalUri(
          config.webhookUrl?.trim() ?? '',
          allowedSchemes: const {'https'},
        ) ==
        null) {
      return S.of(context)?.ui3WebhookUrlInvalid ??
          'Webhook URL must be a public HTTPS address';
    }
    if (config.webhookEvents.isEmpty) {
      return S.of(context)?.ui3WebhookSelectEvent ??
          'Select at least one webhook event';
    }
    return null;
  }

  BotAutomationEventType? _preferredTestEvent(BotConfig config) {
    if (config.webhookEvents.contains(BotAutomationEventType.memberJoined)) {
      return BotAutomationEventType.memberJoined;
    }
    if (config.webhookEvents.contains(
      BotAutomationEventType.welcomeMessageSent,
    )) {
      return BotAutomationEventType.welcomeMessageSent;
    }
    return null;
  }

  BotWebhookEventPayload _buildTestPayload(
    BotConfig config,
    BotAutomationEventType eventType,
  ) {
    const displayName = 'AI Test User';
    final resolvedWelcome =
        (config.welcomeMessage?.trim().isNotEmpty == true
                ? config.welcomeMessage!.replaceAll('{name}', displayName)
                : 'Welcome $displayName')
            .trim();

    return BotWebhookEventPayload(
      eventType: eventType,
      roomId: widget.roomId,
      roomName: 'N42 Test Room',
      triggeredAt: DateTime.now(),
      userId: '@ai-test:n42.chat',
      displayName: displayName,
      message: eventType == BotAutomationEventType.welcomeMessageSent
          ? resolvedWelcome
          : null,
    );
  }

  Future<void> _sendTestWebhook() async {
    final messenger = ScaffoldMessenger.of(context);
    final config = _buildDraftConfig();
    final validationError = _validateDraftConfig(config);
    if (validationError != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(validationError),
          backgroundColor: AppColors.errorFill,
        ),
      );
      return;
    }

    final eventType = _preferredTestEvent(config);
    if (eventType == null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            S.of(context)?.ui3WebhookSelectEvent ??
                'Select at least one webhook event',
          ),
          backgroundColor: AppColors.errorFill,
        ),
      );
      return;
    }

    setState(() => _isTestingWebhook = true);
    try {
      final result = await getIt<BotWebhookService>().dispatch(
        config: config,
        payload: _buildTestPayload(config, eventType),
        webhookSecretOverride: _webhookSecretController.text,
        useStoredSecretFallback: false,
      );
      if (!mounted) return;

      messenger.showSnackBar(
        SnackBar(
          content: Text(
            result.success
                ? S.of(context)?.ui3WebhookTestSent ??
                      'Test webhook sent successfully'
                : (result.errorMessage ??
                      S.of(context)?.ui3WebhookTestFailed ??
                      'Failed to send test webhook'),
          ),
          backgroundColor: result.success
              ? ChatContrast.fillForWhiteText(AppColors.success)
              : AppColors.errorFill,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            '${S.of(context)?.ui3WebhookTestFailed ?? 'Failed to send test webhook'}: $e',
          ),
          backgroundColor: AppColors.errorFill,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isTestingWebhook = false);
      }
    }
  }

  Future<void> _save() async {
    final messenger = ScaffoldMessenger.of(context);
    final secureStorage = getIt<SecureStorageDataSource>();
    final config = _buildDraftConfig();
    final validationError = _validateDraftConfig(config);
    if (validationError != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(validationError),
          backgroundColor: AppColors.errorFill,
        ),
      );
      return;
    }
    try {
      await secureStorage.saveRoomBotWebhookSecret(
        widget.roomId,
        _webhookEnabled ? config.webhookSecret : null,
      );
      if (!mounted) return;
      setState(() => _isSaving = true);
      context.read<GroupBloc>().add(SetBotConfig(widget.roomId, config));
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            '${S.of(context)?.commonSaveFailed ?? 'Save failed'}: $e',
          ),
          backgroundColor: AppColors.errorFill,
        ),
      );
    }
  }
}
