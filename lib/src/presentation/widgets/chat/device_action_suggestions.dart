import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../domain/entities/message_entity.dart';

class DeviceActionSuggestions extends StatefulWidget {
  final MessageEntity message;
  const DeviceActionSuggestions({super.key, required this.message});
  @override
  State<DeviceActionSuggestions> createState() =>
      _DeviceActionSuggestionsState();
}

class _DeviceActionSuggestionsState extends State<DeviceActionSuggestions> {
  static const channel = MethodChannel('n42.chat/suggested_actions');
  late final Future<bool> _available;
  bool _open = false;
  @override
  void initState() {
    super.initState();
    _available = _check();
  }

  Future<bool> _check() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.iOS) return false;
    try {
      return await channel.invokeMethod<bool>('isAvailable') == true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.message;
    if (!m.isText ||
        m.isSelfDestructing ||
        m.content.length > 4096 ||
        m.content.isEmpty) {
      return const SizedBox.shrink();
    }
    return FutureBuilder<bool>(
      future: _available,
      builder: (_, snapshot) => snapshot.data != true
          ? const SizedBox.shrink()
          : TextButton.icon(
              onPressed: _open ? null : _preview,
              icon: const Icon(Icons.bolt_outlined, size: 16),
              label: Text(S.of(context)!.chatDeviceActions),
            ),
    );
  }

  Future<void> _preview() async {
    setState(() => _open = true);
    final m = widget.message;
    final l = S.of(context)!;
    try {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l.chatDeviceActions),
          content: SingleChildScrollView(
            child: Text('${l.chatDeviceActionsReview}\n\n${m.content}'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l.commonCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l.commonConfirm),
            ),
          ],
        ),
      );
      if (!mounted || confirmed != true || !identical(m, widget.message)) {
        return;
      }
      await showModalBottomSheet<void>(
        context: context,
        builder: (_) => SafeArea(
          child: SizedBox(
            height: 180,
            child: UiKitView(
              viewType: 'n42.chat/suggested_actions_view',
              creationParamsCodec: const StandardMessageCodec(),
              creationParams: {
                'id': m.id,
                'body': m.content,
                'timestamp': m.timestamp.millisecondsSinceEpoch,
                'senderIsUser': m.isFromMe,
              },
            ),
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _open = false);
    }
  }
}
