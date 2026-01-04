import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/user_profile_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 外观设置页面
class AppearanceSettingsPage extends StatefulWidget {
  final AppearanceSettings settings;
  final Function(AppearanceSettings)? onSave;

  const AppearanceSettingsPage({
    super.key,
    required this.settings,
    this.onSave,
  });

  @override
  State<AppearanceSettingsPage> createState() => _AppearanceSettingsPageState();
}

class _AppearanceSettingsPageState extends State<AppearanceSettingsPage> {
  late AppearanceSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.settings;
  }

  void _updateSettings(AppearanceSettings newSettings) {
    setState(() => _settings = newSettings);
    widget.onSave?.call(newSettings);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: '外观',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // 深色模式设置
          _buildSectionHeader('深色模式', isDark),
          _buildThemeModeSection(isDark),

          const SizedBox(height: 24),

          // 字体大小设置
          _buildSectionHeader('字体大小', isDark),
          _buildFontSizeSection(isDark),

          const SizedBox(height: 24),

          // 气泡样式设置
          _buildSectionHeader('气泡样式', isDark),
          _buildBubbleStyleSection(isDark),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildThemeModeSection(bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: [
          _buildThemeModeItem(
            title: '跟随系统',
            subtitle: '自动根据系统设置切换',
            value: ThemeMode.system,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildThemeModeItem(
            title: '普通模式',
            subtitle: '始终使用浅色主题',
            value: ThemeMode.light,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildThemeModeItem(
            title: '深色模式',
            subtitle: '始终使用深色主题',
            value: ThemeMode.dark,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeModeItem({
    required String title,
    required String subtitle,
    required ThemeMode value,
    required bool isDark,
  }) {
    final isSelected = _settings.themeMode == value;

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: AppColors.primary,
            )
          : null,
      onTap: () {
        _updateSettings(_settings.copyWith(themeMode: value));
      },
    );
  }

  Widget _buildFontSizeSection(bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: [
          _buildFontSizeItem(
            title: '小',
            value: FontSize.small,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildFontSizeItem(
            title: '标准',
            value: FontSize.medium,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildFontSizeItem(
            title: '大',
            value: FontSize.large,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildFontSizeItem(
            title: '特大',
            value: FontSize.extraLarge,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeItem({
    required String title,
    required FontSize value,
    required bool isDark,
  }) {
    final isSelected = _settings.fontSize == value;
    
    // 根据字体大小调整预览文字大小
    double previewFontSize;
    switch (value) {
      case FontSize.small:
        previewFontSize = 14;
        break;
      case FontSize.medium:
        previewFontSize = 16;
        break;
      case FontSize.large:
        previewFontSize = 18;
        break;
      case FontSize.extraLarge:
        previewFontSize = 20;
        break;
    }

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: previewFontSize,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: AppColors.primary,
            )
          : null,
      onTap: () {
        _updateSettings(_settings.copyWith(fontSize: value));
      },
    );
  }

  Widget _buildBubbleStyleSection(bool isDark) {
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: [
          _buildBubbleStyleItem(
            title: '经典风格',
            subtitle: '经典的消息气泡样式',
            value: BubbleStyle.wechat,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildBubbleStyleItem(
            title: '现代风格',
            subtitle: '简洁的现代消息气泡样式',
            value: BubbleStyle.modern,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildBubbleStyleItem(
            title: '经典风格',
            subtitle: '传统的消息气泡样式',
            value: BubbleStyle.classic,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildBubbleStyleItem({
    required String title,
    required String subtitle,
    required BubbleStyle value,
    required bool isDark,
  }) {
    final isSelected = _settings.bubbleStyle == value;

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: AppColors.primary,
            )
          : null,
      onTap: () {
        _updateSettings(_settings.copyWith(bubbleStyle: value));
      },
    );
  }

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Divider(
        height: 1,
        color: isDark ? AppColors.dividerDark : AppColors.divider,
      ),
    );
  }
}

