import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/encryption/e2ee_manager.dart';
import '../../../core/encryption/key_backup_service.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/username_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_auth_datasource.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/entities/stored_account_entity.dart';
import '../../../domain/entities/user_profile_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../integration/bridge/bridge_manager.dart';
import '../../../n42_chat.dart';
import '../../helpers/system_account_summary_helper.dart';
import '../../widgets/common/common_widgets.dart';
import '../bridge/bridge_list_page.dart';
import '../profile/set_username_page.dart';
import 'account_switch_page.dart';
import 'notification_settings_page.dart';
import 'security_settings_page.dart';

class SystemAccountsPage extends StatefulWidget {
  const SystemAccountsPage({super.key});

  @override
  State<SystemAccountsPage> createState() => _SystemAccountsPageState();
}

class _SystemAccountsPageState extends State<SystemAccountsPage> {
  final IAuthRepository _authRepository = getIt<IAuthRepository>();
  final UsernameService _usernameService = getIt<UsernameService>();
  final MatrixAuthDataSource _authDataSource = MatrixAuthDataSource();

  bool _isLoading = true;
  List<StoredAccountEntity> _accounts = const [];
  NotificationSettings _notificationSettings = const NotificationSettings();
  String? _username;
  String? _currentUserId;
  String? _currentHomeserver;
  String? _currentDeviceId;
  int _deviceCount = 0;
  int _loadVersion = 0;

  @override
  void initState() {
    super.initState();
    unawaited(_loadSummary());
  }

  Future<void> _loadSummary() async {
    final loadVersion = ++_loadVersion;
    setState(() => _isLoading = true);

    final client = MatrixClientManager.instance.client;
    final currentUserId = client?.userID;
    final currentHomeserver = client?.homeserver?.host;
    final currentDeviceId = client?.deviceID;

    final results = await Future.wait<Object?>([
      _safeLoad(
        _authRepository.getStoredAccounts(),
        const <StoredAccountEntity>[],
      ),
      _safeLoad(
        N42Chat.getSavedNotificationSettings(),
        const NotificationSettings(),
      ),
      _safeLoad<String?>(_usernameService.getMyUsername(), null),
      _safeLoad(_loadDeviceCount(client != null && client.isLogged()), 0),
    ]);

    if (!mounted || loadVersion != _loadVersion) {
      return;
    }

    setState(() {
      _accounts = results[0] as List<StoredAccountEntity>;
      _notificationSettings = results[1] as NotificationSettings;
      _username = results[2] as String?;
      _deviceCount = results[3] as int;
      _currentUserId = currentUserId;
      _currentHomeserver = currentHomeserver;
      _currentDeviceId = currentDeviceId;
      _isLoading = false;
    });
  }

  Future<T> _safeLoad<T>(Future<T> future, T fallback) async {
    try {
      return await future;
    } catch (_) {
      return fallback;
    }
  }

  Future<int> _loadDeviceCount(bool isLoggedIn) async {
    if (!isLoggedIn) {
      return 0;
    }
    try {
      final devices = await _authDataSource.getDevices();
      return devices.length;
    } catch (_) {
      return 0;
    }
  }

  Future<void> _openAccounts() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const AccountSwitchPage()));
    if (!mounted) {
      return;
    }
    await _loadSummary();
  }

  Future<void> _openNotifications() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => NotificationSettingsPage(
          settings: _notificationSettings,
          onSave: (settings) {
            _notificationSettings = settings;
            unawaited(N42Chat.applyNotificationSettings(settings));
          },
        ),
      ),
    );
    if (!mounted) {
      return;
    }
    await _loadSummary();
  }

  Future<void> _openUsername() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const SetUsernamePage()));
    if (!mounted) {
      return;
    }
    await _loadSummary();
  }

  Future<void> _openSecurity() async {
    final client = MatrixClientManager.instance.client;
    if (client == null) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Security settings require an active session'),
        ),
      );
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SecuritySettingsPage(
          e2eeManager: E2EEManager(client),
          keyBackupService: KeyBackupService(client),
        ),
      ),
    );
    if (!mounted) {
      return;
    }
    await _loadSummary();
  }

  Future<void> _openBridges() async {
    final client = MatrixClientManager.instance.client;
    if (client == null) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connected accounts require an active session'),
        ),
      );
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            BridgeListPage(bridgeManager: BridgeManager(client: client)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = S.of(context);
    final backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.background;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: N42AppBar(
        title: 'System & Accounts',
        showBackButton: true,
        onBackPressed: () => Navigator.of(context).pop(),
        actions: [
          IconButton(
            onPressed: _isLoading ? null : _loadSummary,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadSummary,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 16),
            _buildOverviewCard(context, isDark),
            const SizedBox(height: 16),
            _Section(
              title: 'Account & Identity',
              children: [
                _ActionTile(
                  icon: Icons.manage_accounts_outlined,
                  iconColor: Colors.indigo,
                  title: 'Accounts',
                  subtitle: SystemAccountSummaryHelper.accountSummary(
                    _accounts,
                  ),
                  onTap: _isLoading ? null : _openAccounts,
                ),
                _ActionTile(
                  icon: Icons.devices_outlined,
                  iconColor: Colors.teal,
                  title: 'Devices & Sessions',
                  subtitle: SystemAccountSummaryHelper.deviceSummary(
                    deviceCount: _deviceCount,
                    currentDeviceId: _currentDeviceId,
                  ),
                  onTap: _isLoading ? null : _openSecurity,
                ),
                _ActionTile(
                  icon: Icons.alternate_email,
                  iconColor: Colors.orange,
                  title: 'Username',
                  subtitle: SystemAccountSummaryHelper.usernameSummary(
                    _username,
                  ),
                  onTap: _isLoading ? null : _openUsername,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _Section(
              title: l10n?.settingsNotificationSettings ?? 'Notifications',
              children: [
                _ActionTile(
                  icon: Icons.notifications_outlined,
                  iconColor: Colors.red,
                  title:
                      l10n?.settingsMessageNotifications ??
                      'Message Notifications',
                  subtitle: SystemAccountSummaryHelper.notificationSummary(
                    _notificationSettings,
                  ),
                  onTap: _isLoading ? null : _openNotifications,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _Section(
              title: 'Integrations',
              children: [
                _ActionTile(
                  icon: Icons.hub_outlined,
                  iconColor: Colors.deepPurple,
                  title: 'Connected Accounts',
                  subtitle:
                      'Telegram, WhatsApp, Discord, and API bridge integrations',
                  onTap: _isLoading ? null : _openBridges,
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context, bool isDark) {
    final cardColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final titleColor = isDark ? Colors.white : AppColors.textPrimary;
    final subtitleColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;
    final effectiveDeviceCount = _deviceCount > 0
        ? _deviceCount
        : (_currentUserId == null ? 0 : 1);
    final currentAccount = _accounts.cast<StoredAccountEntity?>().firstWhere(
      (account) => account?.isCurrent == true,
      orElse: () => null,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          N42Avatar(
            imageUrl: currentAccount?.avatarUrl,
            name: currentAccount?.effectiveDisplayName ?? _currentUserId,
            size: 56,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentAccount?.effectiveDisplayName ??
                      (_currentUserId?.split(':').first.replaceFirst('@', '') ??
                          'System overview'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  SystemAccountSummaryHelper.currentAccountLabel(
                    userId: _currentUserId,
                    homeserver: _currentHomeserver,
                  ),
                  style: TextStyle(fontSize: 13, color: subtitleColor),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _SummaryChip(
                      label: _isLoading
                          ? 'Loading...'
                          : '${_accounts.length} account${_accounts.length == 1 ? '' : 's'}',
                    ),
                    _SummaryChip(
                      label:
                          '$effectiveDeviceCount device${effectiveDeviceCount == 1 ? '' : 's'}',
                    ),
                    if ((_username?.trim().isNotEmpty ?? false))
                      _SummaryChip(label: '@${_username!.trim()}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
          ),
          ...List.generate(children.length * 2 - 1, (index) {
            if (index.isOdd) {
              return Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Divider(
                  height: 1,
                  color: isDark ? AppColors.dividerDark : AppColors.divider,
                ),
              );
            }
            return children[index ~/ 2];
          }),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Opacity(
                  opacity: onTap == null ? 0.55 : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;

  const _SummaryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}
