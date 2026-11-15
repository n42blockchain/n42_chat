import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/utils/event_message_data.dart';

/// Sends only a generic title and the previewed time to the native editor.
/// Android's successful result means editor opened, not event saved.
class LocalCalendarSuggestionButton extends StatefulWidget {
  final DateTime startsAt;
  const LocalCalendarSuggestionButton({super.key, required this.startsAt});
  @override
  State<LocalCalendarSuggestionButton> createState() =>
      _LocalCalendarSuggestionButtonState();
}

class _LocalCalendarSuggestionButtonState
    extends State<LocalCalendarSuggestionButton> {
  bool _busy = false;
  @override
  Widget build(BuildContext context) => TextButton.icon(
    onPressed: _busy ? null : _preview,
    icon: const Icon(Icons.event_outlined, size: 16),
    label: Text(S.of(context)!.chatActionSuggestion),
  );

  Future<void> _preview() async {
    setState(() => _busy = true);
    final l10n = S.of(context)!;
    final start = widget.startsAt;
    final event = EventMessageData(
      title: l10n.chatActionTitle,
      startsAt: start,
      endsAt: start.add(const Duration(hours: 1)),
    );
    try {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.chatActionPreview),
          content: Text(
            '${event.title}\n${start.toUtc().toIso8601String()}\n'
            '${start.toLocal()} (${start.toLocal().timeZoneName})\n'
            '${event.endsAt!.toLocal()} (${event.endsAt!.toLocal().timeZoneName})\n\n${l10n.chatActionPrivacy}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.commonCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.commonConfirm),
            ),
          ],
        ),
      );
      if (!mounted || confirmed != true || start != widget.startsAt) return;
      await const MethodChannel('n42.chat/calendar')
          .invokeMethod<bool>('addEvent', event.toContent());
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.commonFailedToSave)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}
