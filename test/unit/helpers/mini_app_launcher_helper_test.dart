import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:n42_chat/src/domain/entities/mini_app_entity.dart';
import 'package:n42_chat/src/presentation/helpers/mini_app_launcher_helper.dart';

void main() {
  testWidgets(
    'external entry displays registered provider and can be cancelled before opening',
    (tester) async {
      final app = BuiltInMiniApps.all.first;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () => MiniAppLauncherHelper.openApp<void>(
                context,
                app: app,
                roomId: '',
                initialUrl: '${app.url}/offer',
              ),
              child: const Text('Scan result'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Scan result'));
      await tester.pumpAndSettle();
      expect(find.text('Open ${app.name}?'), findsOneWidget);
      expect(
        find.text('${app.developer}\n${Uri.parse(app.url).host}'),
        findsOneWidget,
      );
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Scan result'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    },
  );
  group('MiniAppLauncherHelper', () {
    test('finds built-in shop and creator mini apps by id', () {
      final shop = MiniAppLauncherHelper.findBuiltInAppById(
        MiniAppLauncherHelper.shopAppId,
      );
      final creatorPass = MiniAppLauncherHelper.findBuiltInAppById(
        MiniAppLauncherHelper.creatorPassAppId,
      );

      expect(shop, isNotNull);
      expect(shop!.category, MiniAppCategory.commerce);
      expect(creatorPass, isNotNull);
      expect(creatorPass!.category, MiniAppCategory.commerce);
    });

    test('returns commerce quick launch apps in stable order', () {
      final apps = MiniAppLauncherHelper.commerceQuickLaunchApps();

      expect(apps.map((app) => app.id).toList(), [
        MiniAppLauncherHelper.shopAppId,
        MiniAppLauncherHelper.creatorPassAppId,
      ]);
    });
  });
}
