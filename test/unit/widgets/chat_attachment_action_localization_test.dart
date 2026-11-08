import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart' as intl;
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/widgets/chat/chat_more_panel.dart';

Widget localized(Locale locale, Widget child) => MaterialApp(
  locale: locale,
  supportedLocales: S.supportedLocales,
  localizationsDelegates: S.localizationsDelegates,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context)
        .copyWith(textScaler: const TextScaler.linear(1.6)),
    child: child!,
  ),
  home: Scaffold(
    body: Align(alignment: Alignment.bottomCenter, child: child),
  ),
);

void main() {
  for (final locale in S.supportedLocales) {
    testWidgets('localized attachment actions remain reachable in $locale', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(320, 640));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final s = await S.delegate.load(locale);
      final selected = <String>{};
      final labels = {
        'tip': s.chatAttachmentTip,
        'whiteboard': s.chatAttachmentWhiteboard,
        'video': s.chatAttachmentVideoNote,
        'code': s.chatAttachmentCode,
        'shop': s.chatAttachmentShop,
      };
      await tester.pumpWidget(
        localized(
          locale,
          ChatMorePanel(
            onTipPressed: () => selected.add('tip'),
            onWhiteboardPressed: () => selected.add('whiteboard'),
            onVideoNotePressed: () => selected.add('video'),
            onCodePressed: () => selected.add('code'),
            onShopPressed: () => selected.add('shop'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final rtl =
          Directionality.of(tester.element(find.byType(ChatMorePanel))) ==
          TextDirection.rtl;
      for (var page = 0; page < 5 && selected.length < labels.length; page++) {
        final grid = find
            .descendant(
              of: find.byType(PageView),
              matching: find.byType(GridView),
            )
            .hitTestable()
            .first;
        for (var row = 0; row < 4; row++) {
          for (final entry in labels.entries) {
            final target = find.descendant(
              of: grid,
              matching: find.text(entry.value),
            );
            if (selected.contains(entry.key) || target.evaluate().isEmpty) {
              continue;
            }
            await tester.scrollUntilVisible(
              target,
              70,
              scrollable: find
                  .descendant(of: grid, matching: find.byType(Scrollable))
                  .first,
            );
            await tester.pumpAndSettle();
            expect(target.hitTestable(), findsOneWidget);
            await tester.tap(
              find.ancestor(of: target, matching: find.byType(InkWell)).first,
            );
            await tester.pump();
          }
          await tester.drag(grid, const Offset(0, -85));
          await tester.pumpAndSettle();
        }
        if (selected.length < labels.length) {
          await tester.fling(
            find.byType(PageView),
            Offset(rtl ? 260 : -260, 0),
            1000,
          );
          await tester.pumpAndSettle();
        }
      }
      expect(selected, labels.keys.toSet());
      expect(tester.takeException(), isNull);
    });

    testWidgets(
      'recent media selection limit uses locale formatting in $locale',
      (tester) async {
        final s = await S.delegate.load(locale);
        final thumbnail = base64Decode(
          'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=',
        );
        await tester.pumpWidget(
          localized(
            locale,
            ChatMorePanel(
              maxRecentMediaSelection: 1,
              recentMediaLoader: () async => ChatRecentMediaSnapshot(
                access: ChatRecentMediaAccess.available,
                items: [
                  ChatRecentMediaItem(id: 'a', thumbnailBytes: thumbnail),
                  ChatRecentMediaItem(id: 'b', thumbnailBytes: thumbnail),
                ],
              ),
              onRecentMediaSend: (_) async {},
            ),
          ),
        );
        await tester.pumpAndSettle();
        final photos = find.bySemanticsLabel(
          RegExp('^${RegExp.escape(s.chatRecentPhoto)}(?:\\n|\$)'),
        );
        expect(photos, findsNWidgets(2));
        await tester.tap(photos.at(0));
        await tester.pump();
        await tester.tap(photos.at(1));
        await tester.pump();
        expect(find.text(s.chatSelectionLimit(1)), findsOneWidget);
        expect(
          s.chatSelectionLimit(12345),
          contains(
            intl.NumberFormat.decimalPattern(s.localeName).format(12345),
          ),
        );
        expect(tester.takeException(), isNull);
        await tester.pump(const Duration(seconds: 5));
      },
    );
  }

  testWidgets('explicit shop branding overrides the translated default', (
    tester,
  ) async {
    var selected = false;
    await tester.pumpWidget(
      localized(
        const Locale('zh'),
        ChatMorePanel(
          shopLabel: 'Owned shop',
          onShopPressed: () {
            selected = true;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.fling(find.byType(PageView), const Offset(-640, 0), 1000);
    await tester.pumpAndSettle();
    final grid = find
        .descendant(of: find.byType(PageView), matching: find.byType(GridView))
        .hitTestable()
        .first;
    await tester.scrollUntilVisible(
      find.text('Owned shop'),
      70,
      scrollable: find
          .descendant(of: grid, matching: find.byType(Scrollable))
          .first,
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find
          .ancestor(of: find.text('Owned shop'), matching: find.byType(InkWell))
          .first,
    );
    await tester.pump();
    expect(selected, isTrue);
    expect(find.text('商店'), findsNothing);
  });
}
