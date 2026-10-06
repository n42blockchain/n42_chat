import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/presentation/widgets/common/adaptive_chat_split_layout.dart';

void main() {
  testWidgets('selected conversation and list draft survive fold and resize', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(800, 720);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AdaptiveChatSplitLayout(
            master: TextField(key: ValueKey('search')),
            detail: TextField(key: ValueKey('draft')),
            showDetail: true,
            dividerColor: Colors.grey,
          ),
        ),
      ),
    );
    await tester.enterText(find.byKey(const ValueKey('search')), 'search term');
    await tester.enterText(
      find.byKey(const ValueKey('draft')),
      'unsent message',
    );
    final detailState = tester.state(find.byKey(const ValueKey('draft')));
    final masterState = tester.state(find.byKey(const ValueKey('search')));
    for (final size in [
      const Size(390, 844),
      const Size(600, 720),
      const Size(800, 720),
      const Size(320, 720),
      const Size(844, 390),
    ]) {
      tester.view.physicalSize = size;
      await tester.pump();
      expect(
        tester.state(find.byKey(const ValueKey('draft'))),
        same(detailState),
      );
      expect(
        tester.state(find.byKey(const ValueKey('search'), skipOffstage: false)),
        same(masterState),
      );
      expect(find.text('unsent message'), findsOneWidget);
      if (size.width < 600) {
        expect(find.byKey(const ValueKey('search')), findsNothing);
      } else {
        expect(
          tester.getSize(find.byKey(const ValueKey('draft'))).width,
          greaterThan(320),
        );
      }
      expect(tester.takeException(), isNull);
    }
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'compact list remains visible before a conversation is selected',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(320, 720);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AdaptiveChatSplitLayout(
              master: Text('conversations'),
              detail: Text('detail'),
              showDetail: false,
              dividerColor: Colors.grey,
            ),
          ),
        ),
      );
      expect(find.text('conversations'), findsOneWidget);
      expect(find.text('detail'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}
