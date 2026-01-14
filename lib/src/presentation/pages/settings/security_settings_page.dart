import 'package:flutter/material.dart';

import '../../../core/encryption/e2ee_manager.dart';
import '../../../core/encryption/key_backup_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/common_widgets.dart';
import '../../../../l10n/app_localizations.dart';

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

  @override
  void initState() {
    super.initState();
    _loadData();
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: S.of(context)?.securityTitle ?? 'Security',
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
                  S.of(context)?.endToEndEncryption ?? 'End-to-End Encryption',
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
              S.of(context)?.keyBackup ?? 'Key Backup',
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
            title: S.of(context)?.backupEncryptionKeys ?? 'Backup Encryption Keys',
            subtitle: _backupInfo != null
                ? S.of(context)?.keysBackedUp(_backupInfo!.count) ?? '${_backupInfo!.count} keys backed up'
                : S.of(context)?.backupNotSet ?? 'Backup not set',
            onTap: _showBackupDialog,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildListItem(
            icon: Icons.cloud_download,
            title: S.of(context)?.restoreKeys ?? 'Restore Keys',
            subtitle: S.of(context)?.restoreKeysFromBackup ?? 'Restore encryption keys from backup',
            onTap: _showRestoreDialog,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildListItem(
            icon: Icons.key,
            title: S.of(context)?.exportKeys ?? 'Export Keys',
            subtitle: S.of(context)?.exportKeysToFile ?? 'Export keys to file',
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
              S.of(context)?.loggedInDevices ?? 'Logged In Devices',
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
                S.of(context)?.noOtherDevices ?? 'No other devices',
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
        device.isVerified ? (S.of(context)?.verified ?? 'Verified') : (S.of(context)?.unverified ?? 'Unverified'),
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
              S.of(context)?.advanced ?? 'Advanced',
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
            title: S.of(context)?.crossSigning ?? 'Cross-Signing',
            subtitle: widget.e2eeManager.isCrossSigningEnabled
                ? S.of(context)?.enabled ?? 'Enabled'
                : S.of(context)?.notEnabled ?? 'Not enabled',
            onTap: _setupCrossSigning,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildListItem(
            icon: Icons.delete_forever,
            title: S.of(context)?.resetEncryption ?? 'Reset Encryption',
            subtitle: S.of(context)?.deleteAllEncryptionKeys ?? 'Delete all encryption keys',
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
        return S.of(context)?.encryptionNotSupported ?? 'Encryption not supported';
      case E2EEStatus.notInitialized:
        return S.of(context)?.notInitialized ?? 'Not initialized';
      case E2EEStatus.ready:
        return S.of(context)?.enabled ?? 'Enabled';
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
        title: Text(S.of(context)?.backupKeyTitle ?? 'Backup Keys'),
        content: Text(S.of(context)?.backupKeyMessage ?? 'Create a new key backup? This will help you restore encrypted messages on a new device.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              // 实现备份逻辑
            },
            child: Text(S.of(context)?.backup ?? 'Backup'),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.restoreKeyTitle ?? 'Restore Keys'),
        content: Text(S.of(context)?.restoreKeyMessage ?? 'Enter your recovery password or recovery key to restore encrypted messages.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              // 实现恢复逻辑
            },
            child: Text(S.of(context)?.restore ?? 'Restore'),
          ),
        ],
      ),
    );
  }

  void _showExportDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.exportKeyTitle ?? 'Export Keys'),
        content: Text(S.of(context)?.exportKeyMessage ?? 'The exported key file contains all your encryption keys. Please keep it safe.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              // 实现导出逻辑
            },
            child: Text(S.of(context)?.export ?? 'Export'),
          ),
        ],
      ),
    );
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
              S.of(context)?.deviceIdLabel(device.deviceId) ?? 'Device ID: ${device.deviceId}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(device.isVerified
                ? (S.of(context)?.deviceStatusVerified ?? 'Status: Verified')
                : (S.of(context)?.deviceStatusUnverified ?? 'Status: Unverified')),
            if (device.lastSeen != null) Text(S.of(context)?.lastActiveLabel(device.lastSeen!) ?? 'Last active: ${device.lastSeen}'),
            const SizedBox(height: 16),
            if (!device.isVerified)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  // 验证设备
                },
                child: Text(S.of(context)?.verifyThisDevice ?? 'Verify this device'),
              ),
          ],
        ),
      ),
    );
  }

  void _setupCrossSigning() async {
    if (widget.e2eeManager.isCrossSigningEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.crossSigningAlreadyEnabled ?? 'Cross-signing is already enabled')),
      );
      return;
    }

    try {
      await widget.e2eeManager.initializeCrossSigning();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.crossSigningSetupSuccess ?? 'Cross-signing setup successful')),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)?.setupFailed(e.toString()) ?? 'Setup failed: $e')),
      );
    }
  }

  void _showResetConfirmation() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.resetEncryptionTitle ?? 'Reset Encryption'),
        content: Text(
          S.of(context)?.resetEncryptionWarning ?? 'Warning: This will delete all your encryption keys. You will not be able to decrypt previous encrypted messages. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // 实现重置逻辑
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(S.of(context)?.reset ?? 'Reset'),
          ),
        ],
      ),
    );
  }
}

