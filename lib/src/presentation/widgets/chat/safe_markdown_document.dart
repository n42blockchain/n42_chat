import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:markdown/markdown.dart' as md;

/// No WebView, HTML execution, image decoding, resource fetch or automatic link
/// opening. Large documents are paged to bound synchronous parser/layout work.
class SafeMarkdownDocument extends StatefulWidget {
  final String data;
  const SafeMarkdownDocument({super.key, required this.data});
  static const pageCharacters = 16384;
  @override
  State<SafeMarkdownDocument> createState() => _SafeMarkdownDocumentState();
}

class _SafeMarkdownDocumentState extends State<SafeMarkdownDocument> {
  int _page = 0;
  @override
  void didUpdateWidget(covariant SafeMarkdownDocument oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) _page = 0;
  }

  @override
  Widget build(BuildContext context) {
    final pages = math.max(
      1,
      (widget.data.length / SafeMarkdownDocument.pageCharacters).ceil(),
    );
    final start = _page * SafeMarkdownDocument.pageCharacters;
    final end = math.min(
      widget.data.length,
      start + SafeMarkdownDocument.pageCharacters,
    );
    return Column(
      children: [
        if (pages > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                tooltip: 'Previous page',
                onPressed: _page > 0 ? () => setState(() => _page--) : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Text('${_page + 1} / $pages'),
              IconButton(
                tooltip: 'Next page',
                onPressed: _page + 1 < pages
                    ? () => setState(() => _page++)
                    : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        Expanded(
          child: Markdown(
            key: ValueKey(_page),
            data: widget.data.substring(start, end),
            selectable: true,
            extensionSet: md.ExtensionSet.gitHubFlavored,
            imageBuilder: blockedMarkdownImage,
          ),
        ),
      ],
    );
  }
}

Widget blockedMarkdownImage(Uri uri, String? title, String? alt) => Text(
  alt == null || alt.isEmpty ? '[Image blocked]' : '[Image blocked: $alt]',
);
