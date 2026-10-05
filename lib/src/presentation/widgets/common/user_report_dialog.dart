import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/content_report_repository.dart';

/// Opens a user report bound to the account generation that opened the dialog.
Future<void> showUserReportDialog(
  BuildContext context, {
  required String userId,
}) => _showReportDialog(context, userId: userId);

/// Opens a room report using the exact Matrix room ID.
Future<void> showRoomReportDialog(
  BuildContext context, {
  required String roomId,
}) => _showReportDialog(context, roomId: roomId);

Future<void> _showReportDialog(
  BuildContext context, {
  String? userId,
  String? roomId,
}) {
  assert((userId == null) != (roomId == null));
  final origin = _ReportOrigin.capture();
  final repository = getIt.isRegistered<IContentReportRepository>()
      ? getIt<IContentReportRepository>()
      : null;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _ContentReportDialog(
      userId: userId,
      roomId: roomId,
      repository: repository,
      origin: origin,
    ),
  );
}

class _ReportOrigin {
  const _ReportOrigin({
    required this.manager,
    required this.client,
    required this.generation,
    required this.userId,
    required this.homeserver,
    required this.token,
    required this.deviceId,
  });

  final MatrixClientManager manager;
  final Client client;
  final AuthSessionInvalidation generation;
  final String userId;
  final Uri homeserver;
  final String token;
  final String? deviceId;

  static _ReportOrigin? capture() {
    if (!getIt.isRegistered<MatrixClientManager>() ||
        !getIt.isRegistered<IAuthRepository>()) {
      return null;
    }
    final manager = getIt<MatrixClientManager>();
    final auth = getIt<IAuthRepository>();
    if (auth is! IAccountBoundDeletionLifecycle) return null;
    final generation =
        (auth as IAccountBoundDeletionLifecycle).currentAccountGeneration;
    final client = manager.client;
    final userId = client?.userID;
    final homeserver = client?.homeserver;
    final token = client?.accessToken;
    if (generation == null ||
        client == null ||
        !client.isLogged() ||
        userId == null ||
        homeserver == null ||
        token == null ||
        !generation.isCurrent ||
        !generation.matchesClient(client) ||
        generation.userId != userId ||
        generation.homeserver != homeserver ||
        generation.deviceId != client.deviceID) {
      return null;
    }
    return _ReportOrigin(
      manager: manager,
      client: client,
      generation: generation,
      userId: userId,
      homeserver: homeserver,
      token: token,
      deviceId: client.deviceID,
    );
  }

  bool get isCurrent =>
      generation.isCurrent &&
      generation.matchesClient(client) &&
      identical(manager.client, client) &&
      client.isLogged() &&
      client.userID == userId &&
      client.homeserver == homeserver &&
      client.accessToken == token &&
      client.deviceID == deviceId;
}

class _ContentReportDialog extends StatefulWidget {
  const _ContentReportDialog({
    required this.userId,
    required this.roomId,
    required this.repository,
    required this.origin,
  });

  final String? userId;
  final String? roomId;
  final IContentReportRepository? repository;
  final _ReportOrigin? origin;

  @override
  State<_ContentReportDialog> createState() => _ContentReportDialogState();
}

class _ContentReportDialogState extends State<_ContentReportDialog> {
  final _description = TextEditingController();
  String? _reason;
  String? _error;
  bool _submitting = false;

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting) return;
    final l10n = S.of(context);
    final reason = _reason;
    if (reason == null) {
      setState(
        () => _error = l10n?.reportSelectReason ?? 'Please select a reason',
      );
      return;
    }
    final origin = widget.origin;
    final repository = widget.repository;
    if (origin == null || repository == null) {
      setState(
        () => _error = l10n?.reportUnavailable ?? 'Sign in to send a report.',
      );
      return;
    }
    if (!origin.isCurrent) {
      setState(
        () => _error =
            l10n?.reportAccountChanged ??
            'Account changed. Open this report again to send it.',
      );
      return;
    }

    final description = _description.text.trim();
    final details = description.isEmpty ? reason : '$reason\n$description';
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      if (widget.roomId case final roomId?) {
        await repository.reportRoom(roomId: roomId, reason: details);
      } else {
        await repository.reportUser(userId: widget.userId!, reason: details);
      }
    } on ContentReportException catch (error) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _error = !origin.isCurrent
            ? (l10n?.reportAccountChanged ??
                  'Account changed. Open this report again to send it.')
            : _messageFor(error, l10n);
      });
      return;
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _error = !origin.isCurrent
            ? (l10n?.reportAccountChanged ??
                  'Account changed. Open this report again to send it.')
            : (l10n?.reportCouldNotSend ??
                  'Could not send report. Please try again.');
      });
      return;
    }
    if (!mounted) return;
    if (!origin.isCurrent) {
      setState(() {
        _submitting = false;
        _error =
            l10n?.reportAccountChanged ??
            'Account changed. Open this report again to send it.';
      });
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n?.reportSubmitted ?? 'Report submitted'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _messageFor(
    ContentReportException error,
    S? l10n,
  ) => switch (error.kind) {
    ContentReportFailure.accountChanged =>
      l10n?.reportAccountChanged ??
          'Account changed. Open this report again to send it.',
    ContentReportFailure.unavailable || ContentReportFailure.unauthorized =>
      l10n?.reportUnavailable ?? 'Sign in to send a report.',
    ContentReportFailure.unsupported =>
      widget.roomId == null
          ? (l10n?.reportUnsupported ??
                'This homeserver does not support user reports.')
          : (l10n?.reportRoomUnsupported ??
                'This homeserver does not support room reports.'),
    ContentReportFailure.rateLimited =>
      l10n?.reportRateLimited ?? 'Too many reports. Please try again later.',
    _ => l10n?.reportCouldNotSend ?? 'Could not send report. Please try again.',
  };

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final reasons = [
      l10n?.reportReasonSpam ?? 'Spam',
      l10n?.reportReasonHarassment ?? 'Harassment',
      l10n?.reportReasonFraud ?? 'Fraud',
      l10n?.reportReasonOther ?? 'Other',
    ];
    final dialog = AlertDialog(
      backgroundColor: context.surfaceColor,
      title: Text(
        l10n?.reportTitle ?? 'Report',
        style: TextStyle(color: context.textPrimary),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioGroup<String>(
              groupValue: _reason,
              onChanged: (value) {
                if (_submitting) return;
                setState(() {
                  _reason = value;
                  _error = null;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final reason in reasons)
                    RadioListTile<String>(
                      title: Text(
                        reason,
                        style: TextStyle(color: context.textPrimary),
                      ),
                      value: reason,
                      enabled: !_submitting,
                      activeColor: AppColors.primary,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _description,
              enabled: !_submitting,
              maxLines: 2,
              style: TextStyle(color: context.textPrimary),
              decoration: InputDecoration(
                hintText:
                    l10n?.reportDescription ??
                    'Additional description (optional)',
                hintStyle: TextStyle(color: context.textSecondary),
                border: const OutlineInputBorder(),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: const TextStyle(color: AppColors.error)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: Text(l10n?.commonCancel ?? 'Cancel'),
        ),
        TextButton(
          onPressed: _submitting ? null : _submit,
          child: Text(l10n?.commonConfirm ?? 'Submit'),
        ),
      ],
    );
    return PopScope(
      canPop: !_submitting,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _submitting ? null : () => Navigator.of(context).pop(),
            ),
          ),
          Center(child: dialog),
        ],
      ),
    );
  }
}
