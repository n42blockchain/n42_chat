import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/repositories/message_action_repository.dart';
import 'package:n42_chat/src/presentation/pages/favorite/favorite_list_page.dart';

class _Repository extends Mock implements IMessageActionRepository {}

class _Message extends Fake implements MessageEntity {}

MessageEntity _favorite(
  String id,
  String content,
  MessageType type, {
  int daysAgo = 0,
}) => MessageEntity(
  id: id,
  roomId: '!room:example.org',
  senderId: '@alice:example.org',
  senderName: 'Alice',
  content: content,
  type: type,
  timestamp: DateTime.now().subtract(Duration(days: daysAgo)),
);

void main() {
  final getIt = GetIt.instance;
  late _Repository repository;

  setUpAll(() => registerFallbackValue(_Message()));
  setUp(() async {
    await getIt.reset();
    repository = _Repository();
    getIt.registerSingleton<IMessageActionRepository>(repository);
    when(() => repository.getSavedMessages()).thenAnswer((_) async => []);
  });
  tearDown(() async => getIt.reset());

  Future<void> open(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: const FavoriteListPage(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows empty state and retries after a load error', (
    tester,
  ) async {
    var fail = true;
    when(() => repository.getSavedMessages()).thenAnswer((_) async {
      if (fail) throw StateError('offline');
      return [];
    });
    await open(tester);

    expect(find.text('Failed to load'), findsOneWidget);
    fail = false;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('No favorites yet'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('filters favorites and removes an item from its action sheet', (
    tester,
  ) async {
    final note = _favorite('note', 'A saved note', MessageType.text);
    final image = _favorite('image', 'A saved image', MessageType.image);
    final link = _favorite(
      'link',
      'Docs\nhttps://example.org',
      MessageType.text,
      daysAgo: 2,
    );
    when(
      () => repository.getSavedMessages(),
    ).thenAnswer((_) async => [note, image, link]);
    when(() => repository.unsaveMessage('image')).thenAnswer((_) async {});
    await open(tester);

    expect(find.text('A saved note'), findsOneWidget);
    expect(find.text('A saved image'), findsOneWidget);
    expect(find.textContaining('days ago'), findsOneWidget);
    await tester.tap(find.text('[Image]'));
    await tester.pumpAndSettle();
    expect(find.text('A saved image'), findsOneWidget);
    expect(find.text('A saved note'), findsNothing);

    await tester.longPress(find.text('A saved image'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    verify(() => repository.unsaveMessage('image')).called(1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('searches favorites and adds a note', (tester) async {
    when(
      () => repository.getSavedMessages(),
    ).thenAnswer((_) async => [_favorite('a', 'Keep this', MessageType.text)]);
    when(() => repository.saveMessage(any())).thenAnswer((_) async {});
    await open(tester);

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'nothing');
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    expect(find.text('No favorites yet'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.text('New Note'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '  Remember this  ');
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    final captured =
        verify(() => repository.saveMessage(captureAny())).captured.single
            as MessageEntity;
    expect(captured.content, 'Remember this');
    expect(captured.senderName, 'My Notes');
    expect(find.text('Note added'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('validates and saves a normalized link', (tester) async {
    when(() => repository.saveMessage(any())).thenAnswer((_) async {});
    await open(tester);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Favorite Link'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'Example');
    await tester.enterText(fields.at(1), 'javascript:alert(1)');
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a valid URL'), findsOneWidget);

    await tester.enterText(fields.at(1), 'example.org/page');
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    final captured =
        verify(() => repository.saveMessage(captureAny())).captured.single
            as MessageEntity;
    expect(captured.content, 'Example\nhttps://example.org/page');
    expect(captured.metadata?.httpUrl, 'https://example.org/page');
    expect(tester.takeException(), isNull);
  });
}
