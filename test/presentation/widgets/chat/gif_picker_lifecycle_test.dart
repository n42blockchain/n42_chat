import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/services/gif_service.dart';
import 'package:n42_chat/src/core/services/giphy_service.dart';
import 'package:n42_chat/src/presentation/widgets/chat/gif_picker.dart';

class _Source implements GifService {
  final requests = <(String, int, Completer<GiphySearchResult>)>[];
  @override
  bool get isAvailable => true;

  Future<GiphySearchResult> _request(String query, int offset) {
    final pending = Completer<GiphySearchResult>();
    requests.add((query, offset, pending));
    return pending.future;
  }

  @override
  Future<GiphySearchResult> getTrendingGifs({
    int offset = 0,
    String? cursor,
    int? limit,
    String rating = 'g',
  }) => _request('', offset);

  @override
  Future<GiphySearchResult> searchGifs({
    required String query,
    int offset = 0,
    String? cursor,
    int? limit,
    String rating = 'g',
    String lang = 'en',
  }) => _request(query, offset);
}

const _empty = GiphySearchResult(gifs: [], totalCount: 0, offset: 0);

void main() {
  late _Source source;
  setUp(() {
    source = _Source();
    GetIt.instance.registerSingleton<GifService>(source);
  });
  tearDown(() => GetIt.instance.reset());

  Future<void> mount(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Scaffold(body: GifPicker(onGifSelected: (_) {})),
      ),
    );
  }

  const gif = GiphyGif(
    id: 'sample',
    title: 'Sample',
    originalUrl: 'https://test/gif',
    previewUrl: 'https://test/preview',
    width: 20,
    height: 30,
    previewWidth: 20,
    previewHeight: 30,
  );

  for (final schedule in [false, true]) {
    testWidgets(
      'legacy GIF selection still returns its result: scheduled=$schedule',
      (tester) async {
        GifPickerResult? result;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  child: const Text('Open'),
                  onPressed: () async {
                    result = await showGifPicker(context);
                  },
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.text('Open'));
        await tester.pump();
        source.requests.last.$3.complete(_empty);
        await tester.pumpAndSettle();
        final picker = tester.widget<GifPicker>(find.byType(GifPicker));
        if (schedule) {
          final selection = picker.onGifLongPressed!(gif);
          await tester.pumpAndSettle();
          await tester.tap(find.text('In 1 hour'));
          await tester.pumpAndSettle();
          await selection;
        } else {
          picker.onGifSelected(gif);
          await tester.pumpAndSettle();
        }
        expect(result?.gif, same(gif));
        expect(result?.scheduledAt, schedule ? isNotNull : isNull);
        expect(find.byType(GifPicker), findsNothing);
      },
    );
  }

  for (final outcome in ['saved', 'failed', 'cancel', 'disposed']) {
    testWidgets(
      'scheduled GIF retains picker until acknowledgement: $outcome',
      (tester) async {
        final acknowledgement = Completer<bool>();
        final selections = <GifPickerResult>[];
        GifPickerResult? returned;
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,
            home: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  child: const Text('Open'),
                  onPressed: () async {
                    returned = await showGifPicker(
                      context,
                      onSchedule: (selection) {
                        selections.add(selection);
                        return acknowledgement.future;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.text('Open'));
        await tester.pump();
        source.requests.last.$3.complete(_empty);
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'cats');
        await tester.pump(const Duration(milliseconds: 600));
        source.requests.last.$3.complete(_empty);
        await tester.pumpAndSettle();
        final picker = tester.widget<GifPicker>(find.byType(GifPicker));
        final operation = picker.onGifLongPressed!(gif);
        await tester.pumpAndSettle();
        if (outcome == 'cancel') {
          Navigator.of(tester.element(find.text('In 1 hour'))).pop();
        } else {
          await tester.tap(find.text('In 1 hour'));
          await tester.pumpAndSettle();
          expect(selections, hasLength(1));
          expect(selections.single.scheduledPayload['gifUrl'], gif.originalUrl);
          expect(
            selections.single.scheduledAt!.isAfter(DateTime.now()),
            isTrue,
          );
          expect(find.byType(GifPicker), findsOneWidget);
          picker.onGifSelected(gif);
          await picker.onGifLongPressed!(gif);
          expect(selections, hasLength(1));
          if (outcome == 'disposed') await tester.pumpWidget(const SizedBox());
          acknowledgement.complete(outcome != 'failed');
        }
        await tester.pumpAndSettle();
        await operation;
        expect(returned, isNull);
        if (outcome == 'failed' || outcome == 'cancel') {
          expect(find.byType(GifPicker), findsOneWidget);
          expect(
            tester.widget<TextField>(find.byType(TextField)).controller!.text,
            'cats',
          );
        } else {
          expect(find.byType(GifPicker), findsNothing);
        }
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'stalled GIF request ends with retry instead of an endless spinner',
    (tester) async {
      await mount(tester);
      await tester.pump(const Duration(seconds: 21));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Retry'), findsOneWidget);
      source.requests.first.$3.complete(_empty);
      await tester.pump();
    },
  );

  testWidgets(
    'typing a query while trending is pending starts the latest search',
    (tester) async {
      await mount(tester);
      expect(source.requests.map((r) => r.$1), ['']);
      await tester.enterText(find.byType(TextField), 'cats');
      await tester.pump(const Duration(milliseconds: 550));
      expect(source.requests.map((r) => r.$1), ['', 'cats']);
      source.requests.last.$3.complete(_empty);
      await tester.pump();
      source.requests.first.$3.completeError(
        StateError('obsolete trending failure'),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('a second search is not discarded while the first is pending', (
    tester,
  ) async {
    await mount(tester);
    source.requests.first.$3.complete(_empty);
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'cats');
    await tester.pump(const Duration(milliseconds: 550));
    await tester.enterText(find.byType(TextField), 'dogs');
    await tester.pump(const Duration(milliseconds: 550));
    expect(source.requests.map((r) => r.$1), ['', 'cats', 'dogs']);
    source.requests.last.$3.complete(_empty);
    await tester.pump();
    source.requests[1].$3.complete(_empty);
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
  testWidgets('trailing whitespace preserves the pending search debounce', (
    tester,
  ) async {
    await mount(tester);
    source.requests.first.$3.complete(_empty);
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'cats');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.enterText(find.byType(TextField), 'cats ');
    await tester.pump(const Duration(milliseconds: 350));
    expect(source.requests.map((r) => r.$1), ['', 'cats']);
    source.requests.last.$3.complete(_empty);
    await tester.pump();
  });

  testWidgets('failed loading exposes a working retry', (tester) async {
    await mount(tester);
    source.requests.first.$3.complete(
      const GiphySearchResult(
        gifs: [],
        totalCount: 0,
        offset: 0,
        isError: true,
      ),
    );
    await tester.pump();
    expect(find.text('Retry'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    expect(source.requests.length, 2);
    source.requests.last.$3.complete(_empty);
    await tester.pump();
    expect(find.text('Retry'), findsNothing);
    expect(find.text('No Results'), findsOneWidget);
  });

  testWidgets(
    'completion after closing the picker does not update disposed state',
    (tester) async {
      await mount(tester);
      await tester.pumpWidget(const SizedBox());
      source.requests.single.$3.complete(_empty);
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
}
