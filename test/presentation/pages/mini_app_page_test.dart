import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/entities/mini_app_entity.dart';
import 'package:n42_chat/src/presentation/pages/mini_app/mini_app_page.dart';

MiniAppEntity _buildApp(String url) {
  return MiniAppEntity(
    id: 'mini-app',
    name: 'Mini App',
    description: 'desc',
    url: url,
    iconUrl: 'icon',
    category: MiniAppCategory.tools,
  );
}

void main() {
  testWidgets('shows error state for invalid mini app URL', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        locale: const Locale('en'),
        home: MiniAppPage(app: _buildApp('notaurl'), roomId: '!room:server'),
      ),
    );
    await tester.pump();

    expect(find.text('Invalid mini app URL'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('shows error state for non-https mini app URL', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        locale: const Locale('en'),
        home: MiniAppPage(
          app: _buildApp('http://mini.n42.world'),
          roomId: '!room:server',
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Invalid mini app URL'), findsOneWidget);
  });
  testWidgets(
    'unsigned business launch shows recovery message before creating WebView',
    (tester) async {
      final app = BuiltInMiniApps.all.first;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: MiniAppPage(
            app: app,
            roomId: '!room:server',
            initialUrl: '${app.url}/offer?item=1',
          ),
        ),
      );
      await tester.pump();
      expect(
        find.text(
          'This link is not signed. Open the Mini App from Apps instead.',
        ),
        findsOneWidget,
      );
      expect(find.text('Retry'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
