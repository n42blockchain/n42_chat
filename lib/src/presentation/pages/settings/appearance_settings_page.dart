import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/user_profile_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 外观设置页面
class AppearanceSettingsPage extends StatefulWidget {
  final AppearanceSettings settings;
  final void Function(AppearanceSettings)? onSave;

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
    final isDark = context.isDarkMode;
    final l10n = S.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: l10n?.settingsAppearance ?? 'Appearance',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // 深色模式设置
          _buildSectionHeader(l10n?.settingsDarkMode ?? 'Dark Mode', isDark),
          _buildThemeModeSection(context, isDark),

          const SizedBox(height: 24),

          // 字体大小设置
          _buildSectionHeader(l10n?.settingsFontSize ?? 'Font Size', isDark),
          _buildFontSizeSection(context, isDark),

          const SizedBox(height: 24),

          // 气泡样式设置
          _buildSectionHeader(l10n?.settingsBubbleStyle ?? 'Bubble Style', isDark),
          _buildBubbleStyleSection(context, isDark),
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

  Widget _buildThemeModeSection(BuildContext context, bool isDark) {
    final l10n = S.of(context);
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: [
          _buildThemeModeItem(
            title: l10n?.settingsFollowSystem ?? 'Follow System',
            subtitle: l10n?.settingsAutoSwitchBySystem ?? 'Auto switch by system settings',
            value: ThemeMode.system,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildThemeModeItem(
            title: l10n?.settingsLightMode ?? 'Light Mode',
            subtitle: l10n?.settingsAlwaysUseLightTheme ?? 'Always use light theme',
            value: ThemeMode.light,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildThemeModeItem(
            title: l10n?.settingsDarkModeOption ?? 'Dark Mode',
            subtitle: l10n?.settingsAlwaysUseDarkTheme ?? 'Always use dark theme',
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
          ? const Icon(
              Icons.check,
              color: AppColors.primary,
            )
          : null,
      onTap: () {
        _updateSettings(_settings.copyWith(themeMode: value));
      },
    );
  }

  Widget _buildFontSizeSection(BuildContext context, bool isDark) {
    final l10n = S.of(context);
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: [
          _buildFontSizeItem(
            title: l10n?.settingsFontSizeSmall ?? 'Small',
            value: FontSize.small,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildFontSizeItem(
            title: l10n?.settingsFontSizeStandard ?? 'Standard',
            value: FontSize.medium,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildFontSizeItem(
            title: l10n?.settingsFontSizeLarge ?? 'Large',
            value: FontSize.large,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildFontSizeItem(
            title: l10n?.settingsFontSizeExtraLarge ?? 'Extra Large',
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
          ? const Icon(
              Icons.check,
              color: AppColors.primary,
            )
          : null,
      onTap: () {
        _updateSettings(_settings.copyWith(fontSize: value));
      },
    );
  }

  Widget _buildBubbleStyleSection(BuildContext context, bool isDark) {
    final l10n = S.of(context);
    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      child: Column(
        children: [
          _buildBubbleStyleItem(
            title: l10n?.settingsBubbleStyleWechat ?? 'WeChat Style',
            subtitle: l10n?.settingsBubbleStyleWechatDesc ?? 'Classic WeChat bubble style',
            value: BubbleStyle.wechat,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildBubbleStyleItem(
            title: l10n?.settingsBubbleStyleModern ?? 'Modern Style',
            subtitle: l10n?.settingsBubbleStyleModernDesc ?? 'Clean modern bubble style',
            value: BubbleStyle.modern,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          _buildBubbleStyleItem(
            title: l10n?.settingsBubbleStyleClassic ?? 'Classic Style',
            subtitle: l10n?.settingsBubbleStyleClassicDesc ?? 'Traditional bubble style',
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
          ? const Icon(
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

