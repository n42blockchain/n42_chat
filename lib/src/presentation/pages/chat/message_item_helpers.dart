import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../core/services/ai_service.dart';
import '../../widgets/chat/ai_link_summary_card.dart';

/// 地图网格背景绘制器 - 模拟地图预览效果
class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4DDE0)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // 绘制水平线（模拟道路）
    const spacing = 20.0;
    for (double y = spacing; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // 绘制垂直线
    for (double x = spacing; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // 绘制一些"主干道"（较粗的线）
    final mainRoadPaint = Paint()
      ..color = const Color(0xFFC0CDD2)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // 水平主干道
    canvas.drawLine(
      Offset(0, size.height * 0.5),
      Offset(size.width, size.height * 0.5),
      mainRoadPaint,
    );

    // 垂直主干道
    canvas.drawLine(
      Offset(size.width * 0.5, 0),
      Offset(size.width * 0.5, size.height),
      mainRoadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// AI 链接摘要包装器
///
/// 自管理 loading/result 状态，内嵌在 UrlPreviewWidget 下方
class AiLinkSummaryWrapper extends StatefulWidget {
  final String url;
  const AiLinkSummaryWrapper({super.key, required this.url});
  @override
  State<AiLinkSummaryWrapper> createState() => _AiLinkSummaryWrapperState();
}

class _AiLinkSummaryWrapperState extends State<AiLinkSummaryWrapper> {
  String? _summary;
  bool _isLoading = false;

  void _generate() async {
    setState(() => _isLoading = true);
    try {
      final result = await getIt<AiService>().summarizeUrl(widget.url, '');
      if (mounted) setState(() { _summary = result; _isLoading = false; });
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AiLinkSummaryCard(
      url: widget.url,
      summary: _summary,
      isLoading: _isLoading,
      onGenerate: _generate,
    );
  }
}

