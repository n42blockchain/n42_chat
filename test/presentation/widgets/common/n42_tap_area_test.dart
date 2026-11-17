import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/presentation/widgets/common/n42_tap_area.dart';

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  testWidgets('small icon gets a 44pt hit area with an unchanged visual', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      _wrap(
        N42TapArea(
          onTap: () => taps++,
          tooltip: 'Close',
          child: const Icon(Icons.close, size: 16),
        ),
      ),
    );
    final rect = tester.getRect(find.byType(InkWell));
    expect(rect.width, greaterThanOrEqualTo(44));
    expect(rect.height, greaterThanOrEqualTo(44));
    expect(tester.getSize(find.byIcon(Icons.close)), const Size(16, 16));
    await tester.tapAt(rect.topLeft + const Offset(2, 2));
    expect(taps, 1);
  });

  testWidgets('tooltip doubles as the screen-reader label', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _wrap(
        N42TapArea(
          onTap: () {},
          tooltip: 'Close',
          child: const Icon(Icons.close, size: 16),
        ),
      ),
    );
    expect(
      find.semantics.byPredicate(
        (node) =>
            node.tooltip == 'Close' &&
            node.getSemanticsData().hasAction(SemanticsAction.tap),
      ),
      findsOne,
    );
    handle.dispose();
  });

  testWidgets('semanticLabel labels an icon without a tooltip', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _wrap(
        N42TapArea(
          onTap: () {},
          semanticLabel: 'Copy link',
          child: const Icon(Icons.copy, size: 16),
        ),
      ),
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel('Copy link')),
      matchesSemantics(
        label: 'Copy link',
        isButton: true,
        hasEnabledState: true,
        isEnabled: true,
        hasTapAction: true,
      ),
    );
    handle.dispose();
  });
}
