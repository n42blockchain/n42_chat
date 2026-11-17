import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/encryption/key_backup_service.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';

/// 恢复密钥导入对话框
///
/// 提供文本输入和粘贴功能，验证格式后调用 KeyBackupService 恢复。
class RecoveryKeyImportDialog extends StatefulWidget {
  final KeyBackupService keyBackupService;

  const RecoveryKeyImportDialog({super.key, required this.keyBackupService});

  /// 展示恢复密钥导入对话框
  static Future<bool?> show(
    BuildContext context,
    KeyBackupService keyBackupService,
  ) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          RecoveryKeyImportDialog(keyBackupService: keyBackupService),
    );
  }

  @override
  State<RecoveryKeyImportDialog> createState() =>
      _RecoveryKeyImportDialogState();
}

class _RecoveryKeyImportDialogState extends State<RecoveryKeyImportDialog> {
  final _controller = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final client = MatrixClientManager.instance.client;
    final accountId =
        client?.userID ?? l10n?.ui3UnknownAccount ?? 'Unknown account';
    final homeserver =
        client?.homeserver?.host ??
        l10n?.ui3UnknownHomeserver ??
        'Unknown homeserver';
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.key, color: AppColors.primaryOf(context)),
          const SizedBox(width: AppDimensions.spacingS),
          Expanded(
            child: Text(
              l10n?.ui3ImportRecoveryKey ?? 'Import Recovery Key',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 说明文字
            Text(
              l10n?.ui3ImportRecoveryKeyDesc ??
                  'Enter or paste your recovery key to restore room keys for encrypted message history.',
              style: TextStyle(
                fontSize: 13,
                color: context.textSupporting,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing),
            Text(
              l10n?.ui3RecoveryKeyAccountInfo(accountId, homeserver) ??
                  'Account: $accountId\nHomeserver: $homeserver',
              style: TextStyle(
                fontSize: 12,
                color: context.textSupporting,
                height: 1.35,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing),

            // 输入框
            TextField(
              controller: _controller,
              maxLines: 4,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                letterSpacing: 0.5,
              ),
              decoration: InputDecoration(
                hintText: 'EsTX xxxx xxxx ...',
                hintStyle: TextStyle(
                  fontFamily: 'monospace',
                  color: context.textTertiary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  borderSide: BorderSide(color: AppColors.primaryOf(context)),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.paste, size: 20),
                  tooltip: l10n?.a11yPaste ?? 'Paste',
                  onPressed: _pasteFromClipboard,
                ),
              ),
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
            ),

            // 错误消息
            if (_error != null) ...[
              const SizedBox(height: AppDimensions.spacingS),
              Text(
                _error!,
                style: TextStyle(
                  fontSize: 12,
                  // errorFill reads at 4.5:1 on the light dialog surface.
                  color: context.isDarkMode
                      ? AppColors.error
                      : AppColors.errorFill,
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(false),
          child: Text(l10n?.commonCancel ?? 'Cancel'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _importKey,
          child: _isLoading
              ? const SizedBox(
                  width: AppDimensions.spacing,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(l10n?.ui3Import ?? 'Import'),
        ),
      ],
    );
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (!mounted) return;
    if (data?.text != null && data!.text!.isNotEmpty) {
      _controller.text = data.text!.trim();
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  Future<void> _importKey() async {
    final key = _controller.text.trim();
    if (key.isEmpty) {
      setState(
        () => _error =
            S.of(context)?.settingsEnterRecoveryKey ??
            'Please enter a recovery key',
      );
      return;
    }

    // 基本格式验证：恢复密钥通常以 "Es" 开头并由空格分隔的 4 字符块组成
    if (key.length < 20 || !key.startsWith('Es')) {
      setState(
        () => _error =
            S.of(context)?.ui3InvalidRecoveryKeyFormat ??
            'Invalid recovery key format',
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final report = await widget.keyBackupService
          .restoreFromRecoveryKeyWithReport(key);

      if (mounted) {
        if (!report.isComplete) {
          setState(() {
            _isLoading = false;
            _error =
                S
                    .of(context)
                    ?.ui3RecoveryKeyPartialRestore(
                      report.restoredSessions,
                      report.totalSessions,
                      report.failures.length,
                    ) ??
                'Restored ${report.restoredSessions} of ${report.totalSessions} keys. '
                    '${report.failures.length} keys failed. Check the account, '
                    'network, and backup, then retry. Some history may remain unreadable.';
          });
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S
                      .of(context)
                      ?.ui3RecoveryKeyRestoreSuccess(
                        report.restoredSessions,
                        report.totalSessions,
                      ) ??
                  'Restored ${report.restoredSessions} of ${report.totalSessions} keys successfully',
            ),
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          final reason = e.toString().replaceFirst('Exception: ', '');
          _error =
              S.of(context)?.ui3ImportFailed(reason) ??
              'Import failed: $reason';
        });
      }
    }
  }
}
