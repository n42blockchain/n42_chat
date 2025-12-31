import 'package:flutter/material.dart';

import '../../../core/encryption/e2ee_manager.dart';
import '../../../core/encryption/key_backup_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/common_widgets.dart';

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
        title: '安全',
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
                  '端到端加密',
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
              '密钥备份',
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
            title: '备份加密密钥',
            subtitle: _backupInfo != null
                ? '已备份 ${_backupInfo!.count} 个密钥'
                : '未设置备份',
            onTap: _showBackupDialog,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildListItem(
            icon: Icons.cloud_download,
            title: '恢复密钥',
            subtitle: '从备份恢复加密密钥',
            onTap: _showRestoreDialog,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildListItem(
            icon: Icons.key,
            title: '导出密钥',
            subtitle: '导出密钥到文件',
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
              '已登录设备',
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
                '暂无其他设备',
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
        device.isVerified ? '已验证' : '未验证',
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
              '高级',
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
            title: '跨设备签名',
            subtitle: widget.e2eeManager.isCrossSigningEnabled
                ? '已启用'
                : '未启用',
            onTap: _setupCrossSigning,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildListItem(
            icon: Icons.delete_forever,
            title: '重置加密',
            subtitle: '删除所有加密密钥',
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
        return '不支持加密';
      case E2EEStatus.notInitialized:
        return '未初始化';
      case E2EEStatus.ready:
        return '已启用';
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
      builder: (context) => AlertDialog(
        title: const Text('备份密钥'),
        content: const Text('是否创建新的密钥备份？这将帮助您在新设备上恢复加密消息。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // 实现备份逻辑
            },
            child: const Text('备份'),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('恢复密钥'),
        content: const Text('输入您的恢复密码或恢复密钥来恢复加密消息。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // 实现恢复逻辑
            },
            child: const Text('恢复'),
          ),
        ],
      ),
    );
  }

  void _showExportDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('导出密钥'),
        content: const Text('导出的密钥文件包含您的所有加密密钥，请妥善保管。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // 实现导出逻辑
            },
            child: const Text('导出'),
          ),
        ],
      ),
    );
  }

  void _showDeviceDetails(DeviceInfo device) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Container(
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
            ),
            const SizedBox(height: 8),
            Text('设备ID: ${device.deviceId}'),
            Text('状态: ${device.isVerified ? "已验证" : "未验证"}'),
            if (device.lastSeen != null) Text('最后活跃: ${device.lastSeen}'),
            const SizedBox(height: 16),
            if (!device.isVerified)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // 验证设备
                },
                child: const Text('验证此设备'),
              ),
          ],
        ),
      ),
    );
  }

  void _setupCrossSigning() async {
    if (widget.e2eeManager.isCrossSigningEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('跨设备签名已启用')),
      );
      return;
    }

    try {
      await widget.e2eeManager.initializeCrossSigning();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('跨设备签名设置成功')),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('设置失败: $e')),
      );
    }
  }

  void _showResetConfirmation() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('重置加密'),
        content: const Text(
          '警告：这将删除您所有的加密密钥。您将无法解密之前的加密消息。此操作不可撤销。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // 实现重置逻辑
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('重置'),
          ),
        ],
      ),
    );
  }
}

