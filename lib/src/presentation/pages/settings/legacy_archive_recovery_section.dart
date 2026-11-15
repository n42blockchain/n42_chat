import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/services/legacy_archive_recovery_service.dart';

/// Explicit recovery for history whose original account cannot be verified.
class LegacyArchiveRecoverySection extends StatefulWidget {
  final LegacyArchiveRecoveryService service;
  final bool Function()? tryBegin;
  final bool Function()? isAccountCurrent;
  final VoidCallback? onEnd;
  const LegacyArchiveRecoverySection({
    super.key,
    required this.service,
    this.tryBegin,
    this.isAccountCurrent,
    this.onEnd,
  });

  @override
  State<LegacyArchiveRecoverySection> createState() =>
      _LegacyArchiveRecoverySectionState();
}

class _LegacyArchiveRecoverySectionState
    extends State<LegacyArchiveRecoverySection> {
  bool _busy = false;
  double? _progress;

  Future<void> _recover() async {
    if (_busy || widget.tryBegin?.call() == false) return;
    setState(() {
      _busy = true;
      _progress = null;
    });
    LegacyArchivePreview? preview;
    try {
      preview = await widget.service.preview();
      if (!mounted ||
          widget.isAccountCurrent?.call() == false ||
          !preview.isCurrent) {
        return;
      }
      setState(() => _progress = 0);
      final labels = S.of(context)!;
      final selected = <String>{};
      final rooms = preview.roomMessageCounts.keys.toList()..sort();
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => StatefulBuilder(
          builder: (context, update) => AlertDialog(
            scrollable: true,
            title: Text(labels.backupRecoverLegacyArchive),
            content: SizedBox(
              width: 480,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(labels.backupLegacyArchiveWarning),
                  const SizedBox(height: 12),
                  Text(preview!.targetUserId),
                  if (rooms.isEmpty)
                    Text(labels.backupNoBackups)
                  else
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.35,
                      child: ListView.builder(
                        itemCount: rooms.length,
                        itemBuilder: (_, index) {
                          final room = rooms[index];
                          return CheckboxListTile(
                            value: selected.contains(room),
                            title: Text(room),
                            subtitle: Text(
                              '${preview!.roomMessageCounts[room]}',
                            ),
                            onChanged: (checked) => update(() {
                              if (checked == true) {
                                selected.add(room);
                              } else {
                                selected.remove(room);
                              }
                            }),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(labels.commonCancel),
              ),
              FilledButton(
                onPressed: selected.isEmpty
                    ? null
                    : () => Navigator.pop(dialogContext, true),
                child: Text(labels.commonConfirm),
              ),
            ],
          ),
        ),
      );
      if (confirmed != true ||
          !mounted ||
          widget.isAccountCurrent?.call() == false ||
          !preview.isCurrent) {
        return;
      }
      await widget.service.recover(
        preview,
        roomIds: selected,
        ownershipConfirmed: true,
        isCurrent: () => mounted && widget.isAccountCurrent?.call() != false,
        onProgress: (value) {
          if (!mounted ||
              widget.isAccountCurrent?.call() == false ||
              !preview!.isCurrent) {
            throw StateError('Legacy recovery view changed');
          }
          setState(() => _progress = value);
        },
      );
      if (!mounted ||
          widget.isAccountCurrent?.call() == false ||
          !preview.isCurrent) {
        return;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(labels.commonDone)));
    } catch (error) {
      if (mounted &&
          widget.isAccountCurrent?.call() != false &&
          (preview == null || preview.isCurrent)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context)!.backupFailed(error.toString())),
          ),
        );
      }
    } finally {
      widget.onEnd?.call();
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Material(
    child: Column(
      children: [
        ListTile(
          leading: const Icon(Icons.history),
          title: Text(S.of(context)!.backupRecoverLegacyArchive),
          onTap: _busy ? null : _recover,
        ),
        if (_busy) LinearProgressIndicator(value: _progress),
      ],
    ),
  );
}
