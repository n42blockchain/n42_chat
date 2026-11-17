import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class AiMessageConsentItem {
  const AiMessageConsentItem({
    required this.id,
    required this.sender,
    required this.content,
  });

  final String id;
  final String sender;
  final String content;
}

/// Requires an explicit, per-message grant before content is shared with AI.
class AiMessageConsentDialog extends StatefulWidget {
  const AiMessageConsentDialog({super.key, required this.messages});

  final List<AiMessageConsentItem> messages;

  @override
  State<AiMessageConsentDialog> createState() => _AiMessageConsentDialogState();
}

class _AiMessageConsentDialogState extends State<AiMessageConsentDialog> {
  final Set<String> _selectedIds = {};

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return AlertDialog(
      title: Text(l10n?.ui3AiShareMessagesTitle ?? 'Share messages with AI?'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              l10n?.ui3AiConsentMessage ??
                  'Select the messages AI may use for this summary. '
                      'This one-request approval expires after two minutes. '
                      'It does not permit payments or exports.',
            ),
            for (final message in widget.messages)
              CheckboxListTile(
                value: _selectedIds.contains(message.id),
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(message.sender),
                subtitle: Text(
                  message.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                onChanged: (selected) => setState(() {
                  if (selected == true) {
                    _selectedIds.add(message.id);
                  } else {
                    _selectedIds.remove(message.id);
                  }
                }),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n?.commonCancel ?? 'Cancel'),
        ),
        FilledButton(
          onPressed: _selectedIds.isEmpty
              ? null
              : () => Navigator.pop(context, Set<String>.of(_selectedIds)),
          child: Text(l10n?.ui3ShareSelected ?? 'Share selected'),
        ),
      ],
    );
  }
}
