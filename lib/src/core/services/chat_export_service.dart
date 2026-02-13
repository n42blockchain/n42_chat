import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/entities/message_entity.dart';

/// 导出格式
enum ExportFormat {
  html,
  json,
}

/// 日期范围选项
enum ExportDateRange {
  all,
  lastWeek,
  lastMonth,
  last3Months,
  custom,
}

/// 聊天记录导出服务
class ChatExportService {
  ChatExportService._();
  static final ChatExportService instance = ChatExportService._();

  /// 导出聊天记录
  ///
  /// [messages] 消息列表
  /// [roomName] 房间/对话名称
  /// [format] 导出格式
  /// [dateRange] 日期范围
  /// [customStart] 自定义开始日期
  /// [customEnd] 自定义结束日期
  Future<File> exportChat({
    required List<MessageEntity> messages,
    required String roomName,
    required ExportFormat format,
    ExportDateRange dateRange = ExportDateRange.all,
    DateTime? customStart,
    DateTime? customEnd,
  }) async {
    // 过滤日期范围
    final filteredMessages = _filterByDateRange(
      messages,
      dateRange,
      customStart,
      customEnd,
    );

    // 生成内容
    final content = switch (format) {
      ExportFormat.html => _generateHtml(filteredMessages, roomName),
      ExportFormat.json => _generateJson(filteredMessages, roomName),
    };

    // 写入临时文件
    final dir = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final extension = format == ExportFormat.html ? 'html' : 'json';
    final sanitizedName = roomName.replaceAll(RegExp(r'[^\w\s-]'), '_');
    final file = File('${dir.path}/chat_${sanitizedName}_$timestamp.$extension');
    await file.writeAsString(content);

    return file;
  }

  /// 导出并分享
  Future<void> exportAndShare({
    required List<MessageEntity> messages,
    required String roomName,
    required ExportFormat format,
    ExportDateRange dateRange = ExportDateRange.all,
    DateTime? customStart,
    DateTime? customEnd,
  }) async {
    final file = await exportChat(
      messages: messages,
      roomName: roomName,
      format: format,
      dateRange: dateRange,
      customStart: customStart,
      customEnd: customEnd,
    );

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        subject: 'Chat export - $roomName',
      ),
    );
  }

  List<MessageEntity> _filterByDateRange(
    List<MessageEntity> messages,
    ExportDateRange range,
    DateTime? customStart,
    DateTime? customEnd,
  ) {
    final now = DateTime.now();
    DateTime? start;

    switch (range) {
      case ExportDateRange.all:
        return messages;
      case ExportDateRange.lastWeek:
        start = now.subtract(const Duration(days: 7));
      case ExportDateRange.lastMonth:
        start = DateTime(now.year, now.month - 1, now.day);
      case ExportDateRange.last3Months:
        start = DateTime(now.year, now.month - 3, now.day);
      case ExportDateRange.custom:
        start = customStart;
    }

    return messages.where((m) {
      if (start != null && m.timestamp.isBefore(start)) return false;
      if (customEnd != null && m.timestamp.isAfter(customEnd)) return false;
      return true;
    }).toList();
  }

  String _generateJson(List<MessageEntity> messages, String roomName) {
    final data = {
      'roomName': roomName,
      'exportedAt': DateTime.now().toIso8601String(),
      'messageCount': messages.length,
      'messages': messages.map((m) => {
        'id': m.id,
        'sender': m.senderName,
        'senderId': m.senderId,
        'content': m.content,
        'type': m.type.name,
        'timestamp': m.timestamp.toIso8601String(),
        'isEdited': m.isEdited,
        if (m.replyToId != null) 'replyTo': {
          'id': m.replyToId,
          'content': m.replyToContent,
          'sender': m.replyToSender,
        },
        if (m.metadata != null) 'metadata': {
          if (m.metadata!.fileName != null) 'fileName': m.metadata!.fileName,
          if (m.metadata!.mimeType != null) 'mimeType': m.metadata!.mimeType,
          if (m.metadata!.size != null) 'size': m.metadata!.size,
          if (m.metadata!.duration != null) 'duration': m.metadata!.duration,
        },
      }).toList(),
    };

    return const JsonEncoder.withIndent('  ').convert(data);
  }

  String _generateHtml(List<MessageEntity> messages, String roomName) {
    final dateFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final buf = StringBuffer();

    buf.writeln('<!DOCTYPE html>');
    buf.writeln('<html lang="en">');
    buf.writeln('<head>');
    buf.writeln('<meta charset="UTF-8">');
    buf.writeln('<meta name="viewport" content="width=device-width, initial-scale=1.0">');
    buf.writeln('<title>Chat Export - ${_escapeHtml(roomName)}</title>');
    buf.writeln('<style>');
    buf.writeln(_htmlStyle);
    buf.writeln('</style>');
    buf.writeln('</head>');
    buf.writeln('<body>');
    buf.writeln('<div class="container">');
    buf.writeln('<h1>${_escapeHtml(roomName)}</h1>');
    buf.writeln('<p class="meta">Exported: ${dateFormatter.format(DateTime.now())} | ${messages.length} messages</p>');
    buf.writeln('<div class="messages">');

    String? lastDate;
    for (final msg in messages) {
      final dateStr = DateFormat('yyyy-MM-dd').format(msg.timestamp);
      if (dateStr != lastDate) {
        buf.writeln('<div class="date-separator">$dateStr</div>');
        lastDate = dateStr;
      }

      final timeStr = DateFormat('HH:mm').format(msg.timestamp);
      final bubbleClass = msg.isFromMe ? 'self' : 'other';

      buf.writeln('<div class="message $bubbleClass">');
      buf.writeln('<div class="sender">${_escapeHtml(msg.senderName)}</div>');
      buf.writeln('<div class="bubble">');

      if (msg.hasReply && msg.replyToContent != null) {
        buf.writeln('<div class="reply">');
        buf.writeln('<span class="reply-sender">${_escapeHtml(msg.replyToSender ?? '')}</span>');
        buf.writeln('<span class="reply-content">${_escapeHtml(msg.replyToContent!)}</span>');
        buf.writeln('</div>');
      }

      buf.writeln('<div class="content">${_formatContent(msg)}</div>');
      buf.writeln('<div class="time">$timeStr${msg.isEdited ? " (edited)" : ""}</div>');
      buf.writeln('</div>');
      buf.writeln('</div>');
    }

    buf.writeln('</div>');
    buf.writeln('</div>');
    buf.writeln('</body>');
    buf.writeln('</html>');

    return buf.toString();
  }

  String _formatContent(MessageEntity msg) {
    switch (msg.type) {
      case MessageType.text:
        return _escapeHtml(msg.content);
      case MessageType.image:
        return '[Image${msg.metadata?.fileName != null ? ": ${_escapeHtml(msg.metadata!.fileName!)}" : ""}]';
      case MessageType.video:
        return '[Video${msg.metadata?.formattedDuration.isNotEmpty == true ? " (${msg.metadata!.formattedDuration})" : ""}]';
      case MessageType.voice:
      case MessageType.audio:
        return '[Voice${msg.metadata?.formattedDuration.isNotEmpty == true ? " (${msg.metadata!.formattedDuration})" : ""}]';
      case MessageType.file:
        return '[File: ${_escapeHtml(msg.metadata?.fileName ?? "unknown")} (${msg.metadata?.formattedSize ?? ""})]';
      case MessageType.location:
        return '[Location: ${_escapeHtml(msg.metadata?.locationName ?? "Unknown")}]';
      case MessageType.sticker:
        return '[Sticker]';
      case MessageType.poll:
        return '[Poll: ${_escapeHtml(msg.metadata?.pollQuestion ?? "")}]';
      case MessageType.transfer:
        return '[Transfer: ${msg.metadata?.amount ?? ""} ${msg.metadata?.token ?? ""}]';
      default:
        return _escapeHtml(msg.content);
    }
  }

  String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }

  static const _htmlStyle = '''
body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; margin: 0; padding: 0; background: #ededed; }
.container { max-width: 800px; margin: 0 auto; padding: 20px; }
h1 { text-align: center; color: #333; }
.meta { text-align: center; color: #999; font-size: 13px; margin-bottom: 20px; }
.messages { display: flex; flex-direction: column; gap: 8px; }
.date-separator { text-align: center; padding: 8px; color: #999; font-size: 12px; }
.message { display: flex; flex-direction: column; max-width: 70%; }
.message.self { align-self: flex-end; }
.message.other { align-self: flex-start; }
.sender { font-size: 12px; color: #999; margin-bottom: 2px; padding: 0 8px; }
.message.self .sender { text-align: right; }
.bubble { padding: 10px 14px; border-radius: 12px; word-break: break-word; }
.message.self .bubble { background: #95ec69; border-top-right-radius: 4px; }
.message.other .bubble { background: #fff; border-top-left-radius: 4px; }
.content { font-size: 15px; line-height: 1.5; color: #333; }
.time { font-size: 11px; color: #999; margin-top: 4px; text-align: right; }
.reply { background: rgba(0,0,0,0.05); border-radius: 6px; padding: 6px 8px; margin-bottom: 6px; font-size: 13px; }
.reply-sender { font-weight: 600; display: block; color: #576b95; }
.reply-content { color: #666; }
''';
}
