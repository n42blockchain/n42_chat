import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';

/// Markdown 内容检测正则
final _markdownPatterns = [
  RegExp(r'\*\*.+?\*\*'),           // **bold**
  RegExp(r'__.+?__'),                // __bold__
  RegExp(r'\*.+?\*'),                // *italic*
  RegExp(r'_.+?_'),                  // _italic_
  RegExp(r'~~.+?~~'),               // ~~strikethrough~~
  RegExp(r'`[^`]+`'),               // `inline code`
  RegExp(r'```[\s\S]*?```'),         // ```code block```
  RegExp(r'^#{1,6}\s', multiLine: true),  // # heading
  RegExp(r'^\s*[-*+]\s', multiLine: true), // - list item
  RegExp(r'^\s*\d+\.\s', multiLine: true), // 1. ordered list
  RegExp(r'\[.+?\]\(.+?\)'),        // [link](url)
  RegExp(r'^\s*>\s', multiLine: true),    // > blockquote
  RegExp(r'^\s*---\s*$', multiLine: true), // --- horizontal rule
];

/// 检测文本是否包含 Markdown 语法
bool containsMarkdown(String text) {
  // 至少匹配一个 Markdown 模式才认为是 Markdown
  for (final pattern in _markdownPatterns) {
    if (pattern.hasMatch(text)) return true;
  }
  return false;
}

/// Markdown 消息渲染组件
///
/// 当消息内容包含 Markdown 语法时使用此组件渲染
/// 否则回退为普通文本
class MarkdownMessageWidget extends StatelessWidget {
  final String text;
  final bool isSelf;
  final double fontSize;

  const MarkdownMessageWidget({
    super.key,
    required this.text,
    required this.isSelf,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final textColor = isSelf
        ? AppColors.sentText(isDark)
        : (isDark ? AppColors.textPrimaryDark : AppColors.messageTextReceived);

    final linkColor = isSelf
        ? Colors.blue[800]!
        : Colors.blue;

    return MarkdownBody(
      data: text,
      selectable: false,
      softLineBreak: true,
      onTapLink: (text, href, title) {
        if (href == null) return;
        final uri = Uri.tryParse(href);
        if (uri == null) return;
        // Only allow http/https to prevent malicious protocol attacks
        if (uri.scheme == 'http' || uri.scheme == 'https') {
          launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      styleSheet: MarkdownStyleSheet(
        // 基础文字样式
        p: TextStyle(
          fontSize: fontSize,
          color: textColor,
          height: 1.4,
        ),
        // 标题
        h1: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
        h2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        h3: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
        h4: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        h5: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
        h6: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
        // 内联代码
        code: TextStyle(
          fontSize: fontSize - 1,
          color: textColor,
          backgroundColor: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.06),
          fontFamily: 'monospace',
        ),
        // 代码块
        codeblockDecoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8),
        ),
        codeblockPadding: const EdgeInsets.all(12),
        // 引用块
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: textColor.withValues(alpha: 0.4),
              width: 3,
            ),
          ),
        ),
        blockquotePadding: const EdgeInsets.only(left: 12),
        // 链接
        a: TextStyle(
          color: linkColor,
          decoration: TextDecoration.underline,
        ),
        // 删除线
        del: TextStyle(
          color: textColor.withValues(alpha: 0.6),
          decoration: TextDecoration.lineThrough,
        ),
        // 分隔线
        horizontalRuleDecoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: textColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
        ),
        // 列表
        listBullet: TextStyle(fontSize: fontSize, color: textColor),
        // 表格
        tableHead: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        tableBody: TextStyle(color: textColor),
        tableBorder: TableBorder.all(
          color: textColor.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
    );
  }
}
