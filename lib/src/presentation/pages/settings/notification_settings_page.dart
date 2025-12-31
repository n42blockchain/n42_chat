import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/user_profile_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 通知设置页面
class NotificationSettingsPage extends StatefulWidget {
  final NotificationSettings settings;
  final Function(NotificationSettings)? onSave;

  const NotificationSettingsPage({
    super.key,
    required this.settings,
    this.onSave,
  });

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  late NotificationSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.settings;
  }

  void _updateSettings(NotificationSettings newSettings) {
    setState(() => _settings = newSettings);
    widget.onSave?.call(newSettings);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: '消息通知',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // 通知开关
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            child: Column(
              children: [
                _buildSwitchTile(
                  title: '消息通知',
                  subtitle: '接收新消息通知',
                  icon: Icons.notifications_outlined,
                  value: _settings.enabled,
                  onChanged: (value) => _updateSettings(
                    _settings.copyWith(enabled: value),
                  ),
                  isDark: isDark,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 通知详情设置
          if (_settings.enabled) ...[
            Container(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              child: Column(
                children: [
                  _buildSwitchTile(
                    title: '显示消息预览',
                    subtitle: '在通知中显示消息内容',
                    icon: Icons.visibility_outlined,
                    value: _settings.showPreview,
                    onChanged: (value) => _updateSettings(
                      _settings.copyWith(showPreview: value),
                    ),
                    isDark: isDark,
                  ),
                  _buildDivider(isDark),
                  _buildSwitchTile(
                    title: '通知声音',
                    subtitle: '收到消息时播放声音',
                    icon: Icons.volume_up_outlined,
                    value: _settings.playSound,
                    onChanged: (value) => _updateSettings(
                      _settings.copyWith(playSound: value),
                    ),
                    isDark: isDark,
                  ),
                  _buildDivider(isDark),
                  _buildSwitchTile(
                    title: '震动',
                    subtitle: '收到消息时震动',
                    icon: Icons.vibration,
                    value: _settings.vibrate,
                    onChanged: (value) => _updateSettings(
                      _settings.copyWith(vibrate: value),
                    ),
                    isDark: isDark,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 免打扰设置
            Container(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              child: Column(
                children: [
                  _buildSwitchTile(
                    title: '免打扰模式',
                    subtitle: '在指定时间段内不接收通知',
                    icon: Icons.do_not_disturb_on_outlined,
                    value: _settings.doNotDisturb,
                    onChanged: (value) => _updateSettings(
                      _settings.copyWith(doNotDisturb: value),
                    ),
                    isDark: isDark,
                  ),
                  if (_settings.doNotDisturb) ...[
                    _buildDivider(isDark),
                    _buildTimeTile(
                      title: '开始时间',
                      value: _settings.doNotDisturbStart ?? '22:00',
                      icon: Icons.access_time,
                      onTap: () => _selectTime(true),
                      isDark: isDark,
                    ),
                    _buildDivider(isDark),
                    _buildTimeTile(
                      title: '结束时间',
                      value: _settings.doNotDisturbEnd ?? '07:00',
                      icon: Icons.access_time,
                      onTap: () => _selectTime(false),
                      isDark: isDark,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
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

  Widget _buildTimeTile({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
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
              value,
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

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 56),
      child: Divider(
        height: 1,
        color: isDark ? AppColors.dividerDark : AppColors.divider,
      ),
    );
  }

  Future<void> _selectTime(bool isStart) async {
    final currentTime = isStart
        ? _settings.doNotDisturbStart ?? '22:00'
        : _settings.doNotDisturbEnd ?? '07:00';
    final parts = currentTime.split(':');
    final initialTime = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );

    final time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (time != null) {
      final formatted =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      _updateSettings(
        isStart
            ? _settings.copyWith(doNotDisturbStart: formatted)
            : _settings.copyWith(doNotDisturbEnd: formatted),
      );
    }
  }
}
