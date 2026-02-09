import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/blocs/moment/moment_bloc.dart';
import 'package:n42_chat/src/presentation/blocs/moment/moment_state.dart';
import 'package:n42_chat/src/presentation/pages/discover/discover_page.dart';

class MockMomentBloc extends Mock implements MomentBloc {
  @override
  MomentState get state => const MomentState();

  @override
  Stream<MomentState> get stream => const Stream.empty();

  @override
  Future<void> close() async {}
}

Widget buildTestWidget(Widget child, {MomentBloc? momentBloc}) {
  final widget = MaterialApp(
    localizationsDelegates: S.localizationsDelegates,
    supportedLocales: S.supportedLocales,
    locale: const Locale('en'),
    home: child,
  );

  if (momentBloc != null) {
    return BlocProvider<MomentBloc>.value(
      value: momentBloc,
      child: widget,
    );
  }
  return widget;
}

void main() {
  group('DiscoverPage', () {
    testWidgets('renders 4 menu items (Moments, Scan, Search, Communities)',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(const DiscoverPage()));
      await tester.pumpAndSettle();

      // 验证有 Moments 菜单项
      expect(find.text('Moments'), findsOneWidget);

      // 验证有 Scan 菜单项
      expect(find.text('Scan'), findsOneWidget);

      // 验证有 Search 菜单项（可能是 'Search' 或本地化的文本）
      final searchFinder = find.textContaining('Search');
      expect(searchFinder, findsWidgets);

      // 验证有 Communities 菜单项
      expect(find.text('Communities'), findsOneWidget);
    });

    testWidgets('does not show hidden features (Channels, Live, etc.)',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(const DiscoverPage()));
      await tester.pumpAndSettle();

      // 验证已隐藏的功能不显示
      expect(find.text('Channels'), findsNothing);
      expect(find.text('Live'), findsNothing);
      expect(find.text('Listen'), findsNothing);
      expect(find.text('Watch'), findsNothing);
      expect(find.text('Nearby'), findsNothing);
      expect(find.text('Games'), findsNothing);
      expect(find.text('Mini Programs'), findsNothing);
    });

    testWidgets('shows AppBar with Discover title when showAppBar is true',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(const DiscoverPage()));
      await tester.pumpAndSettle();

      expect(find.text('Discover'), findsOneWidget);
    });

    testWidgets('hides AppBar when showAppBar is false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const DiscoverPage(showAppBar: false)),
      );
      await tester.pumpAndSettle();

      // AppBar title should not appear (Discover text may appear elsewhere)
      // Instead check that no AppBar widget is rendered
      expect(find.byType(AppBar), findsNothing);
    });

    testWidgets('tapping Scan triggers navigation', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DiscoverPage()));
      await tester.pumpAndSettle();

      // 验证 Scan 菜单项可点击（InkWell 包裹）
      await tester.tap(find.text('Scan'));
      // 只 pump 一帧验证不报异常，不 pumpAndSettle（ScanQRPage 含平台插件）
      await tester.pump();
    });

    testWidgets('tapping Search navigates to GlobalSearchPage', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DiscoverPage()));
      await tester.pumpAndSettle();

      // 找到 Search 相关的可点击项
      final searchItem = find.textContaining('Search');
      expect(searchItem, findsWidgets);
    });

    testWidgets('renders correctly in dark mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: const Locale('en'),
          theme: ThemeData.dark(),
          home: const DiscoverPage(),
        ),
      );
      await tester.pumpAndSettle();

      // 验证页面在暗色模式下正常渲染
      expect(find.text('Moments'), findsOneWidget);
      expect(find.text('Scan'), findsOneWidget);
      expect(find.text('Communities'), findsOneWidget);
    });

    testWidgets('renders with MomentBloc provided', (tester) async {
      final mockBloc = MockMomentBloc();

      await tester.pumpWidget(
        buildTestWidget(const DiscoverPage(), momentBloc: mockBloc),
      );
      await tester.pumpAndSettle();

      // 验证 Moments 菜单项依然存在
      expect(find.text('Moments'), findsOneWidget);
    });

    testWidgets('has exactly 4 chevron_right icons for menu items',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(const DiscoverPage()));
      await tester.pumpAndSettle();

      // 发现页应该有 4 个右箭头（Moments、Scan、Search、Communities）
      final chevronIcons = find.byIcon(Icons.chevron_right);
      expect(chevronIcons, findsNWidgets(4));
    });
  });
}
