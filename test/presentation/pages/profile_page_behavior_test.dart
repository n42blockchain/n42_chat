import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/core/theme/n42_chat_theme.dart';
import 'package:n42_chat/src/data/datasources/matrix/matrix_client_manager.dart';
import 'package:n42_chat/src/n42_chat.dart';
import 'package:n42_chat/src/presentation/pages/profile/profile_page.dart';

class _ClientManager extends Mock implements MatrixClientManager {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await getIt.reset();
    final clientManager = _ClientManager();
    when(() => clientManager.client).thenReturn(null);
    getIt.registerSingleton<MatrixClientManager>(clientManager);
  });

  tearDown(() => getIt.reset());

  Future<void> open(
    WidgetTester tester, {
    bool showAppBar = true,
    bool dark = false,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: dark
            ? N42ChatTheme.wechatDark().toThemeData()
            : N42ChatTheme.wechatLight().toThemeData(),
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: ProfilePage(showAppBar: showAppBar),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders the signed-out profile and its service groups', (
    tester,
  ) async {
    await open(tester);

    expect(find.byType(ProfilePage), findsOneWidget);
    expect(find.text('Me'), findsOneWidget);
    expect(find.text('Services'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Moments'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('updates signed-out state when the host reports a logout', (
    tester,
  ) async {
    await open(tester, showAppBar: false);
    N42Chat.notifyUserChanged();
    await tester.pumpAndSettle();

    expect(find.byType(ProfilePage), findsOneWidget);
    expect(find.byType(AppBar), findsNothing);
    expect(tester.takeException(), isNull);
  });
  for (final dark in [false, true]) {
    testWidgets(
      'profile menu labels remain opaque in ${dark ? "dark" : "light"} mode',
      (tester) async {
        await open(tester, dark: dark);
        for (final title in ['Services', 'Favorites', 'Moments']) {
          final text = tester.widget<Text>(find.text(title));
          expect(text.style?.color?.a, 1, reason: '$title must be visible');
        }
        expect(tester.takeException(), isNull);
      },
    );
  }
}
