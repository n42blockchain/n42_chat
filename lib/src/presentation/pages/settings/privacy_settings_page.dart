import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/user_profile_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 隐私设置页面
class PrivacySettingsPage extends StatefulWidget {
  final PrivacySettings settings;
  final Function(PrivacySettings)? onSave;

  const PrivacySettingsPage({
    super.key,
    required this.settings,
    this.onSave,
  });

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  late PrivacySettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.settings;
  }

  void _updateSettings(PrivacySettings newSettings) {
    setState(() => _settings = newSettings);
    widget.onSave?.call(newSettings);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: '隐私',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // 可见性设置
          _buildSectionHeader('谁可以查看', isDark),
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            child: Column(
              children: [
                _buildVisibilityItem(
                  '头像',
                  Icons.account_circle_outlined,
                  _settings.avatarVisibility,
                  (value) => _updateSettings(
                    _settings.copyWith(avatarVisibility: value),
                  ),
                  isDark,
                ),
                _buildDivider(isDark),
                _buildVisibilityItem(
                  '状态',
                  Icons.info_outline,
                  _settings.statusVisibility,
                  (value) => _updateSettings(
                    _settings.copyWith(statusVisibility: value),
                  ),
                  isDark,
                ),
                _buildDivider(isDark),
                _buildVisibilityItem(
                  '最后上线时间',
                  Icons.access_time,
                  _settings.lastSeenVisibility,
                  (value) => _updateSettings(
                    _settings.copyWith(lastSeenVisibility: value),
                  ),
                  isDark,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 消息设置
          _buildSectionHeader('消息', isDark),
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            child: Column(
              children: [
                _buildSwitchTile(
                  title: '允许陌生人私聊',
                  subtitle: '接收非联系人的消息',
                  icon: Icons.person_add_outlined,
                  value: _settings.allowStrangerMessage,
                  onChanged: (value) => _updateSettings(
                    _settings.copyWith(allowStrangerMessage: value),
                  ),
                  isDark: isDark,
                ),
                _buildDivider(isDark),
                _buildSwitchTile(
                  title: '已读回执',
                  subtitle: '让对方知道你已阅读消息',
                  icon: Icons.done_all,
                  value: _settings.showReadReceipts,
                  onChanged: (value) => _updateSettings(
                    _settings.copyWith(showReadReceipts: value),
                  ),
                  isDark: isDark,
                ),
                _buildDivider(isDark),
                _buildSwitchTile(
                  title: '输入状态',
                  subtitle: '让对方知道你正在输入',
                  icon: Icons.keyboard,
                  value: _settings.showTypingIndicator,
                  onChanged: (value) => _updateSettings(
                    _settings.copyWith(showTypingIndicator: value),
                  ),
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          color:
              isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
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

  Widget _buildSwitchTile({
    required String title,
    String? subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
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
                if (subtitle != null)
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityItem(
    String title,
    IconData icon,
    VisibilityLevel value,
    Function(VisibilityLevel) onChanged,
    bool isDark,
  ) {
    return InkWell(
      onTap: () => _showVisibilityPicker(title, value, onChanged),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              _getVisibilityLabel(value),
              style: TextStyle(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  String _getVisibilityLabel(VisibilityLevel level) {
    switch (level) {
      case VisibilityLevel.everyone:
        return '所有人';
      case VisibilityLevel.contacts:
        return '仅联系人';
      case VisibilityLevel.nobody:
        return '无人';
    }
  }

  Future<void> _showVisibilityPicker(
    String title,
    VisibilityLevel currentValue,
    Function(VisibilityLevel) onChanged,
  ) async {
    final result = await showModalBottomSheet<VisibilityLevel>(
      context: context,
      builder: (context) => _VisibilityPickerSheet(
        title: title,
        currentValue: currentValue,
      ),
    );

    if (result != null) {
      onChanged(result);
    }
  }
}

class _VisibilityPickerSheet extends StatelessWidget {
  final String title;
  final VisibilityLevel currentValue;

  const _VisibilityPickerSheet({
    required this.title,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '谁可以查看$title',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
            const Divider(height: 1),
            ...VisibilityLevel.values.map((level) => ListTile(
                  title: Text(_getLabel(level)),
                  trailing: currentValue == level
                      ? Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () => Navigator.pop(context, level),
                )),
          ],
        ),
      ),
    );
  }

  String _getLabel(VisibilityLevel level) {
    switch (level) {
      case VisibilityLevel.everyone:
        return '所有人';
      case VisibilityLevel.contacts:
        return '仅联系人';
      case VisibilityLevel.nobody:
        return '无人';
    }
  }
}
