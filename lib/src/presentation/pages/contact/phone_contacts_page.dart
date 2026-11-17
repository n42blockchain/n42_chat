import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/contact_sync_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/repositories/contact_repository.dart';
import '../../widgets/common/common_widgets.dart';
import '../../../core/theme/app_dimensions.dart';

/// 手机通讯录匹配页面
///
/// 从手机通讯录中查找已注册的 Matrix 用户
class PhoneContactsPage extends StatefulWidget {
  const PhoneContactsPage({super.key});

  @override
  State<PhoneContactsPage> createState() => _PhoneContactsPageState();
}

class _PhoneContactsPageState extends State<PhoneContactsPage> {
  late final ContactSyncService _syncService;

  bool _isLoading = true;
  bool _hasPermission = false;
  String? _errorMessage;
  List<MatchedContact> _matchedContacts = [];
  List<PhoneContact> _allPhoneContacts = [];

  @override
  void initState() {
    super.initState();
    _syncService = ContactSyncService(getIt<MatrixClientManager>());
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _syncService.syncContacts(
        onProgress: (current, total) {
          // 可以用于显示进度
        },
      );
      if (!mounted) return;

      if (!result.success) {
        setState(() {
          _hasPermission = false;
          _errorMessage = result.error;
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _hasPermission = true;
        _allPhoneContacts = result.phoneContacts;
        _matchedContacts = result.matchedContacts;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _startDirectChat(String userId) async {
    try {
      final roomId = await getIt<IContactRepository>().startDirectChat(userId);
      if (!mounted) return;
      Navigator.of(context).pop(roomId);
    } catch (e) {
      if (!mounted) return;
      _showError(
        S.of(context)?.contactCreateChatFailed(e.toString()) ??
            'Failed to create chat: $e',
      );
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: AppColors.errorFill),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: N42AppBar(
        title: S.of(context)?.ui3FromContacts ?? 'From Contacts',
      ),
      body: _buildBody(isDark),
    );
  }

  Widget _buildBody(bool isDark) {
    if (_isLoading) {
      return N42Loading(
        message: S.of(context)?.ui3LoadingContacts ?? 'Loading contacts...',
      );
    }

    if (!_hasPermission) {
      return _buildPermissionRequest(isDark);
    }

    if (_errorMessage != null) {
      return _buildError(isDark);
    }

    if (_matchedContacts.isEmpty) {
      return _buildNoMatches(isDark);
    }

    return _buildMatchedList();
  }

  Widget _buildPermissionRequest(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingXXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.contacts,
              size: 72,
              color: AppColors.textTertiaryOf(isDark),
            ),
            const SizedBox(height: AppDimensions.spacingXL),
            Text(
              S.of(context)?.ui3ContactsPermissionRequired ??
                  'Contacts Permission Required',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                height: 1.3,
                fontWeight: FontWeight.w600,
                color: context.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            Text(
              S.of(context)?.ui3ContactsPermissionMessage ??
                  'To find friends from your contacts, please allow access to your contacts.',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: context.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingXXL),
            ElevatedButton(
              onPressed: _loadContacts,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryFillOf(context),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingXXL,
                  vertical: AppDimensions.spacingM,
                ),
              ),
              child: Text(S.of(context)?.ui3AllowAccess ?? 'Allow Access'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingXXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: AppDimensions.spacing),
            Text(
              _errorMessage ??
                  S.of(context)?.qrcodeUnknownError ??
                  'Unknown error',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(height: 1.4, color: context.textSecondary),
            ),
            const SizedBox(height: AppDimensions.spacingXL),
            TextButton(
              onPressed: _loadContacts,
              child: Text(S.of(context)?.commonRetry ?? 'Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoMatches(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingXXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_search,
              size: 72,
              color: AppColors.textTertiaryOf(isDark),
            ),
            const SizedBox(height: AppDimensions.spacingXL),
            Text(
              S.of(context)?.ui3NoContactMatches ?? 'No Matches Found',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                height: 1.3,
                fontWeight: FontWeight.w600,
                color: context.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            Text(
              S.of(context)?.ui3NoContactMatchesMessage ??
                  'None of your contacts are using this app yet. Invite them to join!',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: context.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing),
            Text(
              S.of(context)?.ui3ScannedContacts(_allPhoneContacts.length) ??
                  'Scanned ${_allPhoneContacts.length} contacts',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                height: 1.3,
                color: context.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchedList() {
    return Column(
      children: [
        // 统计信息
        Container(
          padding: const EdgeInsets.all(AppDimensions.spacing),
          color: context.surfaceColor,
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: AppColors.primaryOf(context),
                size: 20,
              ),
              const SizedBox(width: AppDimensions.spacingS),
              Flexible(
                child: Text(
                  S.of(context)?.ui3FoundContactMatches(
                        _matchedContacts.length,
                      ) ??
                      'Found ${_matchedContacts.length} matches from your contacts',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    color: context.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 匹配列表
        Expanded(
          child: ListView.builder(
            itemCount: _matchedContacts.length,
            itemBuilder: (context, index) {
              final match = _matchedContacts[index];
              return _buildMatchTile(match);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMatchTile(MatchedContact match) {
    final phoneContact = match.phoneContact;
    final displayName = match.matrixDisplayName ?? phoneContact.displayName;

    return ListTile(
      leading: Stack(
        children: [
          N42Avatar(
            imageUrl: match.matrixAvatarUrl,
            name: displayName,
            size: 48,
          ),
          // 手机通讯录标识
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.primaryOf(context),
                shape: BoxShape.circle,
                border: Border.all(color: context.surfaceColor, width: 2),
              ),
              child: const Icon(Icons.contacts, size: 12, color: Colors.white),
            ),
          ),
        ],
      ),
      title: Text(
        displayName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          height: 1.3,
          color: context.textPrimary,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            match.matrixUserId,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              height: 1.3,
              color: context.textSecondary,
            ),
          ),
          if (phoneContact.displayName != displayName)
            Text(
              S.of(context)?.ui3InContactsAs(phoneContact.displayName) ??
                  'In Contacts: ${phoneContact.displayName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                height: 1.3,
                color: context.textSecondary,
              ),
            ),
        ],
      ),
      isThreeLine: phoneContact.displayName != displayName,
      trailing: OutlinedButton(
        onPressed: () => _startDirectChat(match.matrixUserId),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryOf(context),
          side: BorderSide(color: AppColors.primaryOf(context)),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing,
          ),
        ),
        child: Text(S.of(context)?.commonChat ?? 'Chat'),
      ),
    );
  }
}
