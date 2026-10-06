import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Keeps both panes mounted while a selected conversation crosses the compact
/// breakpoint. Hidden panes still receive valid, nonzero layout constraints.
class AdaptiveChatSplitLayout extends StatelessWidget {
  const AdaptiveChatSplitLayout({
    super.key,
    required this.master,
    required this.detail,
    required this.showDetail,
    required this.dividerColor,
  });

  final Widget master;
  final Widget detail;
  final bool showDetail;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final expanded = constraints.maxWidth >= 600;
      final masterWidth = expanded
          ? math.min(320.0, constraints.maxWidth * .4)
          : constraints.maxWidth;
      return Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: masterWidth,
            child: Visibility(
              visible: expanded || !showDetail,
              maintainState: true,
              child: master,
            ),
          ),
          Positioned(
            left: expanded ? masterWidth + 1 : 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Visibility(
              visible: expanded || showDetail,
              maintainState: true,
              child: detail,
            ),
          ),
          if (expanded)
            Positioned(
              left: masterWidth,
              top: 0,
              bottom: 0,
              width: 1,
              child: ColoredBox(color: dividerColor),
            ),
        ],
      );
    },
  );
}
