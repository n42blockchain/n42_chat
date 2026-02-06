import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/local/secure_storage_datasource.dart';
import '../../../n42_chat.dart';
import '../../widgets/common/common_widgets.dart';

/// 语言设置页面
class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  static const _languageSettingKey = 'n42_chat_language';

  Locale _currentLocale = N42Chat.locale;

  /// 支持的语言列表及其显示名称
  static const List<LanguageOption> _languages = [
    LanguageOption(locale: Locale('zh'), name: '简体中文', nativeName: '简体中文'),
    LanguageOption(locale: Locale('en'), name: 'English', nativeName: 'English'),
    LanguageOption(locale: Locale('ja'), name: 'Japanese', nativeName: '日本語'),
    LanguageOption(locale: Locale('ko'), name: 'Korean', nativeName: '한국어'),
    LanguageOption(locale: Locale('fr'), name: 'French', nativeName: 'Français'),
    LanguageOption(locale: Locale('de'), name: 'German', nativeName: 'Deutsch'),
    LanguageOption(locale: Locale('es'), name: 'Spanish', nativeName: 'Español'),
    LanguageOption(locale: Locale('pt'), name: 'Portuguese', nativeName: 'Português'),
    LanguageOption(locale: Locale('it'), name: 'Italian', nativeName: 'Italiano'),
    LanguageOption(locale: Locale('ru'), name: 'Russian', nativeName: 'Русский'),
    LanguageOption(locale: Locale('tr'), name: 'Turkish', nativeName: 'Türkçe'),
    LanguageOption(locale: Locale('vi'), name: 'Vietnamese', nativeName: 'Tiếng Việt'),
    LanguageOption(locale: Locale('id'), name: 'Indonesian', nativeName: 'Bahasa Indonesia'),
    LanguageOption(locale: Locale('pl'), name: 'Polish', nativeName: 'Polski'),
  ];

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    final storage = getIt<SecureStorageDataSource>();
    final savedLanguage = await storage.getSetting(_languageSettingKey);
    if (savedLanguage != null && mounted) {
      setState(() {
        _currentLocale = Locale(savedLanguage);
      });
    }
  }

  Future<void> _setLanguage(Locale locale) async {
    if (_currentLocale == locale) return;

    setState(() {
      _currentLocale = locale;
    });

    // 保存到本地存储
    final storage = getIt<SecureStorageDataSource>();
    await storage.saveSetting(_languageSettingKey, locale.languageCode);

    // 更新 N42Chat 的语言设置
    N42Chat.setLocale(locale);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.settingsLanguageChanged ?? 'Language changed'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: N42AppBar(
        title: S.of(context)?.settingsLanguage ?? 'Language',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final language = _languages[index];
          final isSelected = _currentLocale.languageCode == language.locale.languageCode;

          return _LanguageItem(
            language: language,
            isSelected: isSelected,
            isDark: isDark,
            onTap: () => _setLanguage(language.locale),
          );
        },
      ),
    );
  }
}

/// 语言选项数据类
class LanguageOption {
  final Locale locale;
  final String name;
  final String nativeName;

  const LanguageOption({
    required this.locale,
    required this.name,
    required this.nativeName,
  });
}

/// 语言列表项
class _LanguageItem extends StatelessWidget {
  final LanguageOption language;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _LanguageItem({
    required this.language,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // 语言图标/标识
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : (isDark ? AppColors.backgroundDark : AppColors.background),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      language.locale.languageCode.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.primary : subtitleColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // 语言名称
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language.nativeName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? AppColors.primary : textColor,
                        ),
                      ),
                      if (language.name != language.nativeName)
                        Text(
                          language.name,
                          style: TextStyle(
                            fontSize: 13,
                            color: subtitleColor,
                          ),
                        ),
                    ],
                  ),
                ),
                // 选中标识
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
