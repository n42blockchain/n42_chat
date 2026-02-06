import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/user_profile_entity.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../blocs/conversation/conversation_event.dart';
import '../../widgets/common/common_widgets.dart';
import 'hidden_chats_page.dart';

/// 隐私设置页面
class PrivacySettingsPage extends StatefulWidget {
  final PrivacySettings settings;
  final void Function(PrivacySettings)? onSave;
  final void Function(dynamic conversation)? onConversationTap;

  const PrivacySettingsPage({
    super.key,
    required this.settings,
    this.onSave,
    this.onConversationTap,
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
    final isDark = context.isDarkMode;
    final l10n = S.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: l10n?.settingsPrivacy ?? 'Privacy',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // 可见性设置
          _buildSectionHeader(l10n?.settingsWhoCanSee ?? 'Who can see', isDark),
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            child: Column(
              children: [
                _buildVisibilityItem(
                  context,
                  l10n?.profileAvatar ?? 'Avatar',
                  Icons.account_circle_outlined,
                  _settings.avatarVisibility,
                  (value) => _updateSettings(
                    _settings.copyWith(avatarVisibility: value),
                  ),
                  isDark,
                ),
                _buildDivider(isDark),
                _buildVisibilityItem(
                  context,
                  l10n?.profileStatus ?? 'Status',
                  Icons.info_outline,
                  _settings.statusVisibility,
                  (value) => _updateSettings(
                    _settings.copyWith(statusVisibility: value),
                  ),
                  isDark,
                ),
                _buildDivider(isDark),
                _buildVisibilityItem(
                  context,
                  l10n?.settingsLastSeen ?? 'Last Seen',
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

          // 隐藏聊天入口
          _buildSectionHeader(l10n?.commonChat ?? 'Chat', isDark),
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            child: Column(
              children: [
                _buildNavigationItem(
                  context,
                  l10n?.settingsHiddenChats ?? 'Hidden Chats',
                  Icons.visibility_off_outlined,
                  () => _navigateToHiddenChats(context),
                  isDark,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 消息设置
          _buildSectionHeader(l10n?.settingsMessagesLabel ?? 'Messages', isDark),
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            child: Column(
              children: [
                _buildSwitchTile(
                  title: l10n?.settingsAllowStrangerMessages ?? 'Allow Stranger Messages',
                  subtitle: l10n?.settingsReceiveMessagesFromNonContacts ?? 'Receive messages from non-contacts',
                  icon: Icons.person_add_outlined,
                  value: _settings.allowStrangerMessage,
                  onChanged: (value) => _updateSettings(
                    _settings.copyWith(allowStrangerMessage: value),
                  ),
                  isDark: isDark,
                ),
                _buildDivider(isDark),
                _buildSwitchTile(
                  title: l10n?.settingsReadReceipts ?? 'Read Receipts',
                  subtitle: l10n?.settingsLetOthersKnowYouRead ?? 'Let others know you read their messages',
                  icon: Icons.done_all,
                  value: _settings.showReadReceipts,
                  onChanged: (value) => _updateSettings(
                    _settings.copyWith(showReadReceipts: value),
                  ),
                  isDark: isDark,
                ),
                _buildDivider(isDark),
                _buildSwitchTile(
                  title: l10n?.settingsTypingIndicator ?? 'Typing Indicator',
                  subtitle: l10n?.settingsLetOthersKnowYouTyping ?? 'Let others know you are typing',
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
            activeTrackColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityItem(
    BuildContext context,
    String title,
    IconData icon,
    VisibilityLevel value,
    Function(VisibilityLevel) onChanged,
    bool isDark,
  ) {
    return InkWell(
      onTap: () => _showVisibilityPicker(context, title, value, onChanged),
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
              _getVisibilityLabel(context, value),
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

  String _getVisibilityLabel(BuildContext context, VisibilityLevel level) {
    final l10n = S.of(context);
    switch (level) {
      case VisibilityLevel.everyone:
        return l10n?.settingsEveryone ?? 'Everyone';
      case VisibilityLevel.contacts:
        return l10n?.settingsContactsOnly ?? 'Contacts Only';
      case VisibilityLevel.nobody:
        return l10n?.settingsNobody ?? 'Nobody';
    }
  }

  Widget _buildNavigationItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
    bool isDark,
  ) {
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
                color: Colors.grey,
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

  void _navigateToHiddenChats(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
          create: (_) => getIt<ConversationBloc>()
            ..add(const LoadHiddenConversations()),
          child: HiddenChatsPage(
            onConversationTap: widget.onConversationTap != null
                ? (conversation) => widget.onConversationTap!(conversation)
                : null,
          ),
        ),
      ),
    );
  }

  Future<void> _showVisibilityPicker(
    BuildContext context,
    String title,
    VisibilityLevel currentValue,
    Function(VisibilityLevel) onChanged,
  ) async {
    final result = await showModalBottomSheet<VisibilityLevel>(
      context: context,
      builder: (ctx) => _VisibilityPickerSheet(
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
    final isDark = context.isDarkMode;
    final l10n = S.of(context);

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
                l10n?.settingsWhoCanSeeTitle(title) ?? 'Who can see $title',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
            const Divider(height: 1),
            ...VisibilityLevel.values.map((level) => ListTile(
                  title: Text(_getLabel(context, level)),
                  trailing: currentValue == level
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () => Navigator.pop(context, level),
                )),
          ],
        ),
      ),
    );
  }

  String _getLabel(BuildContext context, VisibilityLevel level) {
    final l10n = S.of(context);
    switch (level) {
      case VisibilityLevel.everyone:
        return l10n?.settingsEveryone ?? 'Everyone';
      case VisibilityLevel.contacts:
        return l10n?.settingsContactsOnly ?? 'Contacts Only';
      case VisibilityLevel.nobody:
        return l10n?.settingsNobody ?? 'Nobody';
    }
  }
}
