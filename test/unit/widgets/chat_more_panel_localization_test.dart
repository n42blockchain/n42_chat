import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/widgets/chat/chat_more_panel.dart';

void main() {
  for (final locale in S.supportedLocales) {
    testWidgets('recent media states use $locale copy on a narrow screen', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(320, 640));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final strings = await S.delegate.load(locale);
      for (final state in ['empty', 'denied', 'failed']) {
        await tester.pumpWidget(
          MaterialApp(
            locale: locale,
            supportedLocales: S.supportedLocales,
            localizationsDelegates: S.localizationsDelegates,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.6)),
              child: child!,
            ),
            home: Scaffold(
              body: Align(
                alignment: Alignment.bottomCenter,
                child: ChatMorePanel(
                  key: ValueKey('$locale-$state'),
                  onPhotoPressed: () {},
                  onEventPressed: () {},
                  recentMediaLoader: () async {
                    if (state == 'failed') {
                      throw StateError('test media failure');
                    }
                    return ChatRecentMediaSnapshot(
                      access: state == 'denied'
                          ? ChatRecentMediaAccess.denied
                          : ChatRecentMediaAccess.available,
                    );
                  },
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text(strings.chatRecentMedia), findsOneWidget);
        final expected = switch (state) {
          'empty' => strings.chatRecentMediaEmpty,
          'denied' => strings.chatRecentMediaPermission,
          _ => strings.chatRecentMediaLoadFailed,
        };
        expect(find.text(expected), findsOneWidget);
        final grid = find
            .descendant(
              of: find.byType(PageView),
              matching: find.byType(GridView),
            )
            .first;
        await tester.scrollUntilVisible(
          find.text(strings.chatAttachmentEvent),
          70,
          scrollable: find
              .descendant(of: grid, matching: find.byType(Scrollable))
              .first,
        );
        await tester.pumpAndSettle();
        expect(find.text(strings.chatAttachmentEvent), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    });
  }
}
