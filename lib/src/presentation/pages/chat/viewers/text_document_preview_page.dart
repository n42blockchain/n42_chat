import 'package:flutter/material.dart';

import '../../../../core/services/text_document_loader.dart';
import '../../../../core/services/media_telemetry.dart';
import '../../../widgets/chat/safe_markdown_document.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../widgets/common/common_widgets.dart';
import '../../../../core/theme/app_dimensions.dart';

class TextDocumentPreviewPage extends StatefulWidget {
  final String fileName;
  final String url;
  final Map<String, String>? headers;
  final String? encryptKey;
  final String? encryptIv;
  final String? encryptSha256;

  const TextDocumentPreviewPage({
    super.key,
    required this.fileName,
    required this.url,
    this.headers,
    this.encryptKey,
    this.encryptIv,
    this.encryptSha256,
  });

  @override
  State<TextDocumentPreviewPage> createState() =>
      _TextDocumentPreviewPageState();
}

class _TextDocumentPreviewPageState extends State<TextDocumentPreviewPage> {
  final _loader = TextDocumentLoader();

  @override
  void dispose() {
    _loader.dispose();
    super.dispose();
  }

  bool _isLoading = true;
  String? _error;
  String _content = '';

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    try {
      final content = await _loader.load(
        widget.url,
        headers: widget.headers,
        encryptKey: widget.encryptKey,
        encryptIv: widget.encryptIv,
        encryptSha256: widget.encryptSha256,
      );
      if (!mounted) return;
      final preview = MediaTelemetry.start(
        MediaStage.preview,
        operationId: _loader.operationId,
      );
      setState(() {
        _content = content;
        _isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => preview.finish(
          mounted ? MediaOutcome.succeeded : MediaOutcome.cancelled,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Unable to preview this document safely. Check the connection and file size (max 2MB).';
        _isLoading = false;
      });
    }
  }

  bool get _isMarkdown {
    final lowerName = widget.fileName.toLowerCase();
    return lowerName.endsWith('.md') || lowerName.endsWith('.markdown');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: N42AppBar(
        title: widget.fileName,
        showBackButton: true,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingXL,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.description_outlined,
                size: 56,
                color: context.textSecondary,
              ),
              const SizedBox(height: AppDimensions.spacing),
              Text(
                'Preview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingS),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: context.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    const padding = EdgeInsets.all(AppDimensions.spacing);
    if (_isMarkdown) {
      return SafeMarkdownDocument(data: _content);
    }

    return SingleChildScrollView(
      padding: padding,
      child: SelectableText(
        _content,
        style: TextStyle(fontSize: 14, height: 1.5, color: context.textPrimary),
      ),
    );
  }
}
