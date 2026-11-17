import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/totp_2fa_store.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/totp.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../widgets/common/common_widgets.dart';
import '../../../core/theme/app_dimensions.dart';

/// App 级 TOTP 二步验证设置页
///
/// 启用：生成 Base32 密钥 → 用认证器 App 扫码/手输 → 回填一次验证码确认 → 存密钥。
/// 关闭：删除密钥。验证码现算（[Totp]），不落盘。
class Totp2faSetupPage extends StatefulWidget {
  const Totp2faSetupPage({super.key});

  @override
  State<Totp2faSetupPage> createState() => _Totp2faSetupPageState();
}

class _Totp2faSetupPageState extends State<Totp2faSetupPage> {
  final Totp2faStore _store = Totp2faStore();
  final TextEditingController _codeController = TextEditingController();

  bool _loading = true;
  bool _busy = false;
  bool _enabled = false;
  String _secret = '';
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final enabled = await _store.isEnabled();
    if (!mounted) return;
    setState(() {
      _enabled = enabled;
      if (!enabled) _secret = Totp.randomSecret();
      _loading = false;
    });
  }

  String get _accountName {
    if (getIt.isRegistered<MatrixClientManager>()) {
      final id = getIt<MatrixClientManager>().client?.userID;
      if (id != null && id.isNotEmpty) return id;
    }
    return 'account';
  }

  int get _nowSeconds => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  Future<void> _enable() async {
    if (_busy) return;
    final code = _codeController.text.trim();
    if (!Totp.verify(_secret, code, unixSeconds: _nowSeconds)) {
      setState(
        () => _error =
            S.of(context)?.ui3TotpIncorrectCode ?? 'Incorrect code, try again',
      );
      return;
    }
    setState(() => _busy = true);
    try {
      await _store.enable(_secret);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
    if (!mounted) return;
    setState(() {
      _enabled = true;
      _error = null;
      _codeController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          S.of(context)?.ui3TwoFactorEnabled ??
              'Two-factor authentication enabled',
        ),
      ),
    );
  }

  Future<void> _disable() async {
    if (_busy) return;
    final l10n = S.of(context);
    // Turning 2FA off weakens account security: confirm first.
    final confirmed = await context.showConfirmDialog(
      title:
          l10n?.ui3TwoFactorTurnOffTitle ??
          'Turn off two-factor authentication?',
      content:
          l10n?.ui3TwoFactorTurnOffMessage ??
          'Your authenticator app will no longer be required. You can set it up again later with a new key.',
      confirmText: l10n?.ui3TurnOff ?? 'Turn off',
      isDanger: true,
    );
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    try {
      await _store.disable();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
    if (!mounted) return;
    setState(() {
      _enabled = false;
      _secret = Totp.randomSecret();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          S.of(context)?.ui3TwoFactorDisabled ??
              'Two-factor authentication disabled',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: N42AppBar(
        title: S.of(context)?.ui3TwoFactorTotpTitle ?? 'Two-Factor (TOTP)',
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _enabled
          ? _buildEnabled()
          : _buildSetup(),
    );
  }

  Widget _buildEnabled() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.verified_user, size: 64, color: AppColors.success),
            const SizedBox(height: AppDimensions.spacing),
            Text(
              S.of(context)?.ui3TwoFactorIsOn ??
                  'Two-factor authentication is on',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: context.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingS),
            Text(
              S.of(context)?.ui3TwoFactorCodeRequired ??
                  'A code from your authenticator app is required.',
              textAlign: TextAlign.center,
              style: TextStyle(color: context.textSecondary),
            ),
            const SizedBox(height: AppDimensions.spacingXXL),
            N42Button(
              text: S.of(context)?.ui3TurnOff ?? 'Turn off',
              type: N42ButtonType.secondary,
              isLoading: _busy,
              onPressed: _disable,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetup() {
    final uri = Totp.provisioningUri(
      secret: _secret,
      accountName: _accountName,
      issuer: 'N42 Chat',
    );
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spacingXL),
      children: [
        Text(
          S.of(context)?.ui3TotpStepScan ??
              '1. Scan this QR with an authenticator app (Google Authenticator, '
                  'Authy, 1Password…), or enter the key manually.',
          style: TextStyle(color: context.textSecondary, height: 1.4),
        ),
        const SizedBox(height: AppDimensions.spacing),
        Center(
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.spacing),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            ),
            child: QrImageView(
              data: uri,
              version: QrVersions.auto,
              size: 200,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacing),
        // Surface color on the Material (not a child Container) so the
        // ink ripple stays visible; row keeps a 44pt minimum height.
        Material(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: _secret));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    S.of(context)?.ui3TotpKeyCopied ?? 'Key copied',
                  ),
                ),
              );
            },
            child: Container(
              constraints: const BoxConstraints(minHeight: 44),
              padding: const EdgeInsets.all(AppDimensions.spacingM),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      _secret,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.copy,
                    size: 18,
                    semanticLabel: S.of(context)?.chatCopy ?? 'Copy',
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacingXL),
        Text(
          S.of(context)?.ui3TotpStepConfirm ??
              '2. Enter the 6-digit code to confirm.',
          style: TextStyle(color: context.textSecondary),
        ),
        const SizedBox(height: AppDimensions.spacingM),
        TextField(
          controller: _codeController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          style: const TextStyle(fontSize: 22, letterSpacing: 8),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: '',
            hintText: '000000',
            border: const OutlineInputBorder(),
            errorText: _error,
          ),
          onChanged: (_) {
            if (_error != null) setState(() => _error = null);
          },
        ),
        const SizedBox(height: AppDimensions.spacingXL),
        N42Button(
          text: S.of(context)?.ui3Enable ?? 'Enable',
          isLoading: _busy,
          onPressed: _enable,
        ),
      ],
    );
  }
}
