import 'package:flutter/material.dart';

import '../../../core/encryption/e2ee_manager.dart';
import '../../../core/encryption/key_backup_service.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/biometric_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/local/secure_storage_datasource.dart';
import '../../../n42_chat.dart';
import '../../blocs/auth/auth_event.dart';
import '../../widgets/common/common_widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../security/sas_verification_page.dart';

/// 安全设置页面
class SecuritySettingsPage extends StatefulWidget {
  final E2EEManager e2eeManager;
  final KeyBackupService keyBackupService;

  const SecuritySettingsPage({
    super.key,
    required this.e2eeManager,
    required this.keyBackupService,
  });

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  bool _isLoading = false;
  KeyBackupInfo? _backupInfo;
  List<DeviceInfo> _devices = [];

  // 生物识别状态
  bool _isBiometricAvailable = false;
  bool _isBiometricEnabled = false;
  String? _biometricTypeDescription;
  final BiometricService _biometricService = BiometricService();
  final SecureStorageDataSource _secureStorage = SecureStorageDataSource();

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadBiometricStatus();
  }

  Future<void> _loadBiometricStatus() async {
    final isAvailable = await _biometricService.isAvailable();
    if (isAvailable) {
      final typeDescription = await _biometricService.getBiometricTypeDescription();
      final isEnabled = await _secureStorage.isBiometricEnabled();
      setState(() {
        _isBiometricAvailable = true;
        _biometricTypeDescription = typeDescription;
        _isBiometricEnabled = isEnabled;
      });
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final backupInfo = await widget.keyBackupService.getBackupInfo();
      // 获取当前用户的设备列表
      // 注：需要当前用户ID
      
      setState(() {
        _backupInfo = backupInfo;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: S.of(context)?.settingsSecurityTitle ?? 'Security',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const SizedBox(height: 16),

                // 加密状态
                _buildEncryptionStatus(isDark),

                const SizedBox(height: 16),

                // 生物识别登录
                if (_isBiometricAvailable) ...[
                  _buildBiometricSection(isDark),
                  const SizedBox(height: 16),
                ],

                // 密钥备份
                _buildKeyBackupSection(isDark),

                const SizedBox(height: 16),

                // 设备管理
                _buildDevicesSection(isDark),

                const SizedBox(height: 16),

                // 高级选项
                _buildAdvancedSection(isDark),
              ],
            ),
    );
  }

  Widget _buildBiometricSection(bool isDark) {
    final biometricIcon = _biometricTypeDescription?.contains('Face') == true
        ? Icons.face
        : Icons.fingerprint;

    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              S.of(context)?.settingsBiometricLogin ?? 'Biometric Login',
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                biometricIcon,
                color: Colors.green,
              ),
            ),
            title: Text(
              _biometricTypeDescription ?? 'Biometric',
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
            ),
            subtitle: Text(
              _isBiometricEnabled
                  ? (S.of(context)?.settingsBiometricEnabled ?? 'Enabled - Use biometric to login')
                  : (S.of(context)?.settingsBiometricDisabled ?? 'Disabled - Tap to enable'),
              style: TextStyle(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
            trailing: Switch(
              value: _isBiometricEnabled,
              onChanged: _onBiometricToggle,
              activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
              activeThumbColor: AppColors.primary,
            ),
            onTap: () => _onBiometricToggle(!_isBiometricEnabled),
          ),
        ],
      ),
    );
  }

  Future<void> _onBiometricToggle(bool enable) async {
    if (enable) {
      // 首先检查是否有保存的凭据
      final hasCredentials = await _secureStorage.hasCredentials();
      if (!hasCredentials) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                S.of(context)?.settingsBiometricNeedRelogin ??
                'Please log out and log in again to enable biometric login',
              ),
              duration: const Duration(seconds: 4),
            ),
          );
        }
        return;
      }

      // 执行生物识别验证
      final result = await _biometricService.authenticate(
        reason: S.of(context)?.settingsEnableBiometricLogin ?? 'Verify to enable biometric login',
      );

      if (result.success) {
        // 获取凭据信息
        final credentials = await _secureStorage.getCredentials();
        if (credentials != null) {
          await _secureStorage.enableBiometricLogin(
            homeserver: credentials['homeserver']!,
            username: credentials['username']!,
          );
          setState(() => _isBiometricEnabled = true);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context)?.settingsBiometricLoginEnabled ?? 'Biometric login enabled'),
              ),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.errorMessage ?? 'Authentication failed'),
            ),
          );
        }
      }
    } else {
      // 禁用生物识别
      await _secureStorage.disableBiometricLogin();
      setState(() => _isBiometricEnabled = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)?.settingsBiometricLoginDisabled ?? 'Biometric login disabled'),
          ),
        );
      }
    }
  }

  Widget _buildEncryptionStatus(bool isDark) {
    final status = widget.e2eeManager.status;
    final statusText = _getStatusText(status);
    final statusColor = _getStatusColor(status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              Icons.lock,
              color: statusColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context)?.commonEndToEndEncryption ?? 'End-to-End Encryption',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 13,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyBackupSection(bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              S.of(context)?.settingsKeyBackup ?? 'Key Backup',
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
          ),
          _buildListItem(
            icon: Icons.cloud_upload,
            title: S.of(context)?.settingsBackupEncryptionKeys ?? 'Backup Encryption Keys',
            subtitle: _backupInfo != null
                ? S.of(context)?.settingsKeysBackedUp(_backupInfo!.count) ?? '${_backupInfo!.count} keys backed up'
                : S.of(context)?.settingsBackupNotSet ?? 'Backup not set',
            onTap: _showBackupDialog,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildListItem(
            icon: Icons.cloud_download,
            title: S.of(context)?.settingsRestoreKeys ?? 'Restore Keys',
            subtitle: S.of(context)?.settingsRestoreKeysFromBackup ?? 'Restore encryption keys from backup',
            onTap: _showRestoreDialog,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildListItem(
            icon: Icons.key,
            title: S.of(context)?.settingsExportKeys ?? 'Export Keys',
            subtitle: S.of(context)?.settingsExportKeysToFile ?? 'Export keys to file',
            onTap: _showExportDialog,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildDevicesSection(bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              S.of(context)?.settingsLoggedInDevices ?? 'Logged In Devices',
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
          ),
          if (_devices.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                S.of(context)?.settingsNoOtherDevices ?? 'No other devices',
                style: TextStyle(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
            )
          else
            ..._devices.map((device) => _buildDeviceItem(device, isDark)),
        ],
      ),
    );
  }

  Widget _buildDeviceItem(DeviceInfo device, bool isDark) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: device.isVerified
              ? Colors.green.withValues(alpha: 0.1)
              : Colors.orange.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.phone_android,
          color: device.isVerified ? Colors.green : Colors.orange,
        ),
      ),
      title: Text(
        device.deviceName,
        style: TextStyle(
          color: isDark ? Colors.white : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        device.isVerified ? (S.of(context)?.settingsVerified ?? 'Verified') : (S.of(context)?.settingsUnverified ?? 'Unverified'),
        style: TextStyle(
          color: device.isVerified ? Colors.green : Colors.orange,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color:
            isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
      ),
      onTap: () => _showDeviceDetails(device),
    );
  }

  Widget _buildAdvancedSection(bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              S.of(context)?.settingsAdvanced ?? 'Advanced',
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
          ),
          _buildListItem(
            icon: Icons.verified_user,
            title: S.of(context)?.settingsCrossSigning ?? 'Cross-Signing',
            subtitle: widget.e2eeManager.isCrossSigningEnabled
                ? S.of(context)?.settingsEnabled ?? 'Enabled'
                : S.of(context)?.settingsNotEnabled ?? 'Not enabled',
            onTap: _setupCrossSigning,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildListItem(
            icon: Icons.delete_forever,
            title: S.of(context)?.settingsResetEncryption ?? 'Reset Encryption',
            subtitle: S.of(context)?.settingsDeleteAllEncryptionKeys ?? 'Delete all encryption keys',
            onTap: _showResetConfirmation,
            isDark: isDark,
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    required bool isDark,
    bool isDestructive = false,
  }) {
    final color = isDestructive
        ? AppColors.error
        : (isDark ? Colors.white : AppColors.textPrimary);

    return ListTile(
      leading: Icon(icon, color: isDestructive ? AppColors.error : AppColors.primary),
      title: Text(title, style: TextStyle(color: color)),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            )
          : null,
      trailing: Icon(
        Icons.chevron_right,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 56),
      child: Divider(
        height: 1,
        color: isDark ? AppColors.dividerDark : AppColors.divider,
      ),
    );
  }

  String _getStatusText(E2EEStatus status) {
    switch (status) {
      case E2EEStatus.notSupported:
        return S.of(context)?.settingsEncryptionNotSupported ?? 'Encryption not supported';
      case E2EEStatus.notInitialized:
        return S.of(context)?.settingsNotInitialized ?? 'Not initialized';
      case E2EEStatus.ready:
        return S.of(context)?.settingsEnabled ?? 'Enabled';
    }
  }

  Color _getStatusColor(E2EEStatus status) {
    switch (status) {
      case E2EEStatus.notSupported:
        return AppColors.error;
      case E2EEStatus.notInitialized:
        return Colors.orange;
      case E2EEStatus.ready:
        return Colors.green;
    }
  }

  void _showBackupDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.settingsBackupKeyTitle ?? 'Backup Keys'),
        content: Text(S.of(context)?.settingsBackupKeyMessage ?? 'Create a new key backup? This will help you restore encrypted messages on a new device.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _performBackup();
            },
            child: Text(S.of(context)?.settingsBackup ?? 'Backup'),
          ),
        ],
      ),
    );
  }

  Future<void> _performBackup() async {
    setState(() => _isLoading = true);
    try {
      // 1. 创建恢复密钥
      final recoveryKey = await widget.e2eeManager.createRecoveryKey();

      // 2. 上传所有房间密钥到服务端备份
      await widget.keyBackupService.backupAllKeys();

      // 3. 刷新备份信息
      final backupInfo = await widget.keyBackupService.getBackupInfo();
      setState(() {
        _backupInfo = backupInfo;
        _isLoading = false;
      });

      // 4. 展示恢复密钥给用户保存
      if (mounted && recoveryKey != null) {
        _showRecoveryKeyDialog(recoveryKey);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.settingsBackupSuccess ?? 'Keys backed up successfully')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${S.of(context)?.settingsBackupFailed ?? 'Backup failed'}: $e')),
        );
      }
    }
  }

  void _showRecoveryKeyDialog(String recoveryKey) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.settingsRecoveryKey ?? 'Recovery Key'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context)?.settingsRecoveryKeySaveWarning ??
                  'Please save this recovery key in a safe place. You will need it to restore your encrypted messages on a new device.',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
              ),
              child: SelectableText(
                recoveryKey,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context)?.settingsRecoveryKeySaved ?? 'I have saved it'),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog() {
    final controller = TextEditingController();
    var isRecoveryKey = true;

    showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(S.of(context)?.settingsRestoreKeyTitle ?? 'Restore Keys'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context)?.settingsRestoreKeyMessage ??
                    'Enter your recovery password or recovery key to restore encrypted messages.',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ChoiceChip(
                    label: Text(S.of(context)?.settingsRecoveryKey ?? 'Recovery Key'),
                    selected: isRecoveryKey,
                    onSelected: (v) => setDialogState(() => isRecoveryKey = true),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text(S.of(context)?.settingsPassword ?? 'Password'),
                    selected: !isRecoveryKey,
                    onSelected: (v) => setDialogState(() => isRecoveryKey = false),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                obscureText: !isRecoveryKey,
                decoration: InputDecoration(
                  hintText: isRecoveryKey
                      ? (S.of(context)?.settingsEnterRecoveryKey ?? 'Enter recovery key')
                      : (S.of(context)?.settingsEnterPassword ?? 'Enter password'),
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                maxLines: isRecoveryKey ? 3 : 1,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.dispose();
                Navigator.pop(ctx);
              },
              child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final input = controller.text.trim();
                if (input.isEmpty) return;
                controller.dispose();
                Navigator.pop(ctx);
                await _performRestore(input, isRecoveryKey: isRecoveryKey);
              },
              child: Text(S.of(context)?.settingsRestore ?? 'Restore'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performRestore(String input, {required bool isRecoveryKey}) async {
    setState(() => _isLoading = true);
    try {
      if (isRecoveryKey) {
        await widget.e2eeManager.unlockWithRecoveryKey(input);
      } else {
        await widget.e2eeManager.unlockWithPassphrase(input);
      }

      // 从服务端备份恢复所有密钥
      if (isRecoveryKey) {
        await widget.keyBackupService.restoreFromRecoveryKey(input);
      } else {
        await widget.keyBackupService.restoreFromPassword(input);
      }

      // 刷新备份信息
      final backupInfo = await widget.keyBackupService.getBackupInfo();
      setState(() {
        _backupInfo = backupInfo;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.settingsRestoreSuccess ?? 'Keys restored successfully')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${S.of(context)?.settingsRestoreFailed ?? 'Restore failed'}: $e')),
        );
      }
    }
  }

  void _showExportDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.settingsExportKeyTitle ?? 'Export Keys'),
        content: Text(S.of(context)?.settingsExportKeyMessage ?? 'The exported key file contains all your encryption keys. Please keep it safe.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _performExport();
            },
            child: Text(S.of(context)?.settingsExport ?? 'Export'),
          ),
        ],
      ),
    );
  }

  Future<void> _performExport() async {
    setState(() => _isLoading = true);
    try {
      // 上传所有密钥到服务端备份
      await widget.keyBackupService.backupAllKeys();

      // 获取当前恢复密钥（如果有）
      final recoveryKey = await widget.e2eeManager.getRecoveryKey();

      setState(() => _isLoading = false);

      if (mounted) {
        if (recoveryKey != null) {
          _showRecoveryKeyDialog(recoveryKey);
        } else if (widget.e2eeManager.hasSsssDefaultKey) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context)?.settingsExportSuccess ?? 'Keys exported to server backup successfully')),
          );
        } else {
          // 没有恢复密钥，提示先创建
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context)?.settingsExportNeedBackupFirst ?? 'Please create a key backup first')),
          );
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${S.of(context)?.settingsExportFailed ?? 'Export failed'}: $e')),
        );
      }
    }
  }

  void _showDeviceDetails(DeviceInfo device) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              device.deviceName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context)?.settingsDeviceIdLabel(device.deviceId) ?? 'Device ID: ${device.deviceId}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(device.isVerified
                ? (S.of(context)?.settingsDeviceStatusVerified ?? 'Status: Verified')
                : (S.of(context)?.settingsDeviceStatusUnverified ?? 'Status: Unverified')),
            if (device.lastSeen != null) Text(S.of(context)?.settingsLastActiveLabel(device.lastSeen!.toIso8601String()) ?? 'Last active: ${device.lastSeen}'),
            const SizedBox(height: 16),
            if (!device.isVerified)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  _startSasVerification(device);
                },
                child: Text(S.of(context)?.settingsVerifyThisDevice ?? 'Verify this device'),
              ),
          ],
        ),
      ),
    );
  }

  void _setupCrossSigning() async {
    if (widget.e2eeManager.isCrossSigningEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.settingsCrossSigningAlreadyEnabled ?? 'Cross-signing is already enabled')),
      );
      return;
    }

    try {
      await widget.e2eeManager.initializeCrossSigning();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.settingsCrossSigningSetupSuccess ?? 'Cross-signing setup successful')),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.settingsSetupFailed(e.toString()) ?? 'Setup failed: $e')),
      );
    }
  }

  void _showResetConfirmation() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.settingsResetEncryptionTitle ?? 'Reset Encryption'),
        content: Text(
          S.of(context)?.settingsResetEncryptionWarning ?? 'Warning: This will delete all your encryption keys. You will not be able to decrypt previous encrypted messages. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              setState(() => _isLoading = true);
              try {
                await widget.keyBackupService.deleteKeyBackup();
                final backupInfo = await widget.keyBackupService.getBackupInfo();
                setState(() {
                  _backupInfo = backupInfo;
                  _isLoading = false;
                });
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context)?.settingsResetSuccess ?? 'Encryption reset successful')),
                  );
                }
              } catch (e) {
                setState(() => _isLoading = false);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${S.of(context)?.settingsResetFailed ?? 'Reset failed'}: $e')),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(S.of(context)?.settingsReset ?? 'Reset'),
          ),
        ],
      ),
    );
  }

  /// 启动 SAS 验证流程
  void _startSasVerification(DeviceInfo device) {
    // 获取当前用户 ID
    final userId = widget.e2eeManager.client.userID;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => SasVerificationPage(
          e2eeManager: widget.e2eeManager,
          userId: userId,
          deviceId: device.deviceId,
          deviceName: device.deviceName,
        ),
      ),
    ).then((verified) {
      if (verified == true) {
        // 验证成功，刷新设备列表
        _loadData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.securityDeviceVerifiedTrusted ?? 'Device verified successfully')),
        );
      }
    });
  }
}

