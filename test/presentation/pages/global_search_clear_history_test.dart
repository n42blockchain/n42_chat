import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/repositories/search_repository.dart';
import 'package:n42_chat/src/presentation/blocs/search/search_bloc.dart';
import 'package:n42_chat/src/presentation/pages/search/global_search_page.dart';

class _SearchRepository extends Mock implements ISearchRepository {}

void main() {
  late _SearchRepository repository;
  late SearchBloc bloc;

  setUp(() {
    repository = _SearchRepository();
    when(() => repository.getRecentSearches())
        .thenAnswer((_) async => ['alpha']);
    when(() => repository.clearSearchHistory()).thenAnswer((_) async {});
    bloc = SearchBloc(repository);
  });

  tearDown(() => bloc.close());

  Future<void> pumpPage(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<SearchBloc>.value(
          value: bloc,
          child: const GlobalSearchPage(),
        ),
      ),
    );
    // The mocked history future resolves outside the fake clock.
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pumpAndSettle();
  }

  Finder inDialog(Finder finder) =>
      find.descendant(of: find.byType(AlertDialog), matching: finder);

  testWidgets('clearing search history asks first and keeps it on cancel', (
    tester,
  ) async {
    await pumpPage(tester);
    expect(find.text('alpha'), findsOneWidget);

    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();
    expect(find.text('Clear all recent searches?'), findsOneWidget);
    await tester.tap(inDialog(find.text('Cancel')));
    await tester.pumpAndSettle();

    verifyNever(() => repository.clearSearchHistory());
    expect(find.text('alpha'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('confirming clears search history', (tester) async {
    await pumpPage(tester);

    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();
    await tester.tap(inDialog(find.text('Clear')));
    await tester.pumpAndSettle();

    verify(() => repository.clearSearchHistory()).called(1);
    expect(tester.takeException(), isNull);
  });
}
