import 'dart:math' as math;
import 'dart:typed_data';

import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/markdown_resource_loader.dart';

import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:markdown/markdown.dart' as md;

/// No WebView, HTML execution, automatic resource fetch or link opening. Large documents are paged to bound synchronous parser/layout work.
class SafeMarkdownDocument extends StatefulWidget {
  final String data;
  final Future<bool> Function(Uri)? openLink;
  const SafeMarkdownDocument({super.key, required this.data, this.openLink});
  static const pageCharacters = 16384;
  @override
  State<SafeMarkdownDocument> createState() => _SafeMarkdownDocumentState();
}

class _SafeMarkdownDocumentState extends State<SafeMarkdownDocument> {
  int _page = 0;
  bool _source = false;
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
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            icon: Icon(_source ? Icons.preview : Icons.code),
            label: Text(_source ? 'Preview' : 'View source'),
            onPressed: () => setState(() => _source = !_source),
          ),
        ),
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
          child: _source
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: SelectableText(widget.data.substring(start, end)),
                )
              : Markdown(
                  key: ValueKey(_page),
                  data: widget.data.substring(start, end),
                  selectable: true,
                  extensionSet: md.ExtensionSet.gitHubFlavored,
                  imageBuilder: (uri, title, alt) => ConsentedMarkdownImage(
                    key: ValueKey(uri.toString()),
                    uri: uri,
                    alt: alt,
                  ),
                  onTapLink: (_, href, _) async {
                    final uri = href == null ? null : markdownResourceUri(href);
                    if (uri == null) return;
                    final accepted = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Open external link?'),
                        content: SelectableText(uri.toString()),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(dialogContext, false),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(dialogContext, true),
                            child: const Text('Open'),
                          ),
                        ],
                      ),
                    );
                    if (accepted == true && context.mounted) {
                      await (widget.openLink?.call(uri) ??
                          launchUrl(uri, mode: LaunchMode.externalApplication));
                    }
                  },
                ),
        ),
      ],
    );
  }
}

Widget blockedMarkdownImage(Uri uri, String? title, String? alt) => Text(
  alt == null || alt.isEmpty ? '[Image blocked]' : '[Image blocked: $alt]',
);

class ConsentedMarkdownImage extends StatefulWidget {
  final Uri uri;
  final String? alt;
  final Future<Uint8List> Function(Uri)? loadImage;
  const ConsentedMarkdownImage({
    super.key,
    required this.uri,
    this.alt,
    this.loadImage,
  });
  @override
  State<ConsentedMarkdownImage> createState() => _ConsentedMarkdownImageState();
}

class _ConsentedMarkdownImageState extends State<ConsentedMarkdownImage> {
  final _loader = MarkdownResourceLoader();
  Uint8List? _bytes;
  bool _loading = false;
  bool _failed = false;
  int _generation = 0;
  @override
  void didUpdateWidget(covariant ConsentedMarkdownImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uri != widget.uri) {
      _generation++;
      _bytes = null;
      _loading = false;
      _failed = false;
    }
  }

  @override
  void dispose() {
    _generation++;
    _loader.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    if (_loading) return;
    final generation = ++_generation;
    setState(() {
      _loading = true;
      _failed = false;
    });
    try {
      final bytes =
          await (widget.loadImage?.call(widget.uri) ??
              _loader.load(widget.uri));
      if (mounted && generation == _generation) setState(() => _bytes = bytes);
    } catch (_) {
      if (mounted && generation == _generation) setState(() => _failed = true);
    } finally {
      if (mounted && generation == _generation) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (markdownResourceUri(widget.uri.toString()) == null) {
      return blockedMarkdownImage(widget.uri, null, widget.alt);
    }
    if (_bytes != null) {
      return Image.memory(
        _bytes!,
        cacheWidth: 1024,
        cacheHeight: 1024,
        fit: BoxFit.contain,
        semanticLabel: widget.alt,
        errorBuilder: (_, _, _) => const Text('Image unavailable'),
      );
    }
    return TextButton.icon(
      onPressed: _loading ? null : _load,
      icon: const Icon(Icons.image_outlined),
      label: Text(
        _loading
            ? 'Loading image…'
            : '${_failed ? 'Retry image' : 'Load image'} from ${widget.uri.host}',
      ),
    );
  }
}
