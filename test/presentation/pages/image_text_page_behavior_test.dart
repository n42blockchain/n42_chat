import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:n42_chat/src/core/di/injection.dart';
import 'package:n42_chat/src/core/services/chat_media_bytes_resolver.dart';
import 'package:n42_chat/src/core/services/image_text_recognition_service.dart';
import 'package:n42_chat/src/core/services/image_text_session_service.dart';
import 'package:n42_chat/src/core/services/image_translation_coordinator.dart';
import 'package:n42_chat/src/core/services/on_device_translation_service.dart';
import 'package:n42_chat/src/core/services/translation_service.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/entities/ocr_document.dart';
import 'package:n42_chat/src/presentation/pages/chat/viewers/image_text_page.dart';

const _imageBytes = <int>[
  71,
  73,
  70,
  56,
  57,
  97,
  1,
  0,
  1,
  0,
  128,
  0,
  0,
  0,
  0,
  0,
  255,
  255,
  255,
  33,
  249,
  4,
  1,
  0,
  0,
  0,
  0,
  44,
  0,
  0,
  0,
  0,
  1,
  0,
  1,
  0,
  0,
  2,
  2,
  68,
  1,
  0,
  59,
];

final _message = MessageEntity(
  id: 'ocr-image',
  roomId: '!ocr:test',
  senderId: '@alice:test',
  senderName: 'Alice',
  content: 'image.gif',
  type: MessageType.image,
  timestamp: DateTime(2026),
);

OcrDocument _document({bool empty = false}) => OcrDocument(
  fullText: empty ? '' : 'hello world',
  pixelSize: const Size(1, 1),
  blocks: empty
      ? const []
      : const [
          OcrBlock(
            id: 'hello',
            text: 'hello',
            normalizedRect: Rect.fromLTWH(0.1, 0.1, 0.5, 0.3),
            lines: [
              OcrLine(
                id: 'line-hello',
                blockId: 'hello',
                text: 'hello',
                normalizedRect: Rect.fromLTWH(0.1, 0.1, 0.5, 0.3),
                readingOrder: 0,
              ),
            ],
            readingOrder: 0,
          ),
          OcrBlock(
            id: 'world',
            text: 'world',
            normalizedRect: Rect.fromLTWH(0.1, 0.5, 0.5, 0.3),
            lines: [
              OcrLine(
                id: 'line-world',
                blockId: 'world',
                text: 'world',
                normalizedRect: Rect.fromLTWH(0.1, 0.5, 0.5, 0.3),
                readingOrder: 1,
              ),
            ],
            readingOrder: 1,
          ),
        ],
);

class _Resolver extends ChatMediaBytesResolver {
  int calls = 0;
  bool failFirst = false;

  @override
  Future<ChatMediaData> resolveMessage(
    MessageEntity message, {
    bool allowSelfDestructing = false,
  }) async {
    calls++;
    if (failFirst && calls == 1) {
      throw const ChatMediaResolveException('offline');
    }
    return ChatMediaData(
      bytes: Uint8List.fromList(_imageBytes),
      mimeType: 'image/gif',
    );
  }
}

class _Recognizer implements ImageTextRecognitionService {
  _Recognizer({this.empty = false});

  final bool empty;
  int calls = 0;

  @override
  bool get isSupported => true;

  @override
  Future<OcrDocument> recognize(
    ChatMediaData media, {
    Set<OcrScript> scripts = const {OcrScript.latin, OcrScript.chinese},
  }) async {
    calls++;
    return _document(empty: empty);
  }

  @override
  void dispose() {}
}

class _OnDeviceTranslation extends OnDeviceTranslationService {
  final targets = <String>[];

  @override
  Future<String> translate({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    targets.add(targetLanguage);
    return 'translated $text';
  }
}

class _RemoteTranslation implements ITranslationService {
  @override
  Future<String?> detectLanguage(String text) async => 'en';

  @override
  List<TranslationLanguage> getSupportedLanguages() => const [];

  @override
  Future<TranslationResult> translate({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  }) async => TranslationResult(
    translatedText: 'remote $text',
    targetLanguage: targetLanguage,
  );
}

void main() {
  late _Resolver resolver;
  late _Recognizer recognizer;
  late _OnDeviceTranslation onDevice;

  Future<void> pumpPage(
    WidgetTester tester, {
    ImageTextMode mode = ImageTextMode.extract,
    String language = 'en',
    ValueChanged<String>? onForward,
    ValueChanged<String>? onFavorite,
    ValueChanged<String>? onSearch,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ImageTextPage(
          message: _message,
          initialMode: mode,
          initialTargetLanguage: language,
          onForwardText: onForward,
          onFavoriteText: onFavorite,
          onSearchText: onSearch,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  setUp(() async {
    await GetIt.I.reset();
    resolver = _Resolver();
    recognizer = _Recognizer();
    onDevice = _OnDeviceTranslation();
    getIt.registerSingleton<ImageTextSessionService>(
      ImageTextSessionService(mediaResolver: resolver, recognizer: recognizer),
    );
    getIt.registerSingleton<ImageTranslationCoordinator>(
      ImageTranslationCoordinator(
        onDevice: onDevice,
        remote: _RemoteTranslation(),
      ),
    );
  });

  tearDown(() async => GetIt.I.reset());

  testWidgets('recognition failure is visible and retry loads the image', (
    tester,
  ) async {
    resolver.failFirst = true;
    await pumpPage(tester);

    expect(
      find.text('Could not read this image. Retry or choose a clearer image.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.text('hello'), findsOneWidget);
    expect(resolver.calls, 2);
    expect(recognizer.calls, 1);
  });

  testWidgets('empty recognition displays the no-text state', (tester) async {
    recognizer = _Recognizer(empty: true);
    getIt.unregister<ImageTextSessionService>();
    getIt.registerSingleton<ImageTextSessionService>(
      ImageTextSessionService(mediaResolver: resolver, recognizer: recognizer),
    );
    await pumpPage(tester);

    expect(find.text('No text found'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(find.byTooltip('Copy'), findsNothing);
  });

  testWidgets('selected OCR text is sent to the requested message actions', (
    tester,
  ) async {
    final forwarded = <String>[];
    final favorited = <String>[];
    final searched = <String>[];
    await pumpPage(
      tester,
      onForward: forwarded.add,
      onFavorite: favorited.add,
      onSearch: searched.add,
    );
    await tester.tap(find.text('Clear'));
    await tester.pump();
    await tester.tap(find.text('hello'));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Forward'));
    await tester.pumpAndSettle();
    expect(forwarded, ['hello']);

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Favorite'));
    await tester.pumpAndSettle();
    expect(favorited, ['hello']);

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    expect(searched, ['hello']);
  });

  testWidgets(
    'translation mode uses the chosen language and can return to source',
    (tester) async {
      await pumpPage(tester, mode: ImageTextMode.translate, language: 'es');

      expect(find.text('translated hello'), findsNWidgets(2));
      expect(find.text('translated world'), findsNWidgets(2));
      expect(onDevice.targets, ['es', 'es']);

      await tester.tap(find.text('Original'));
      await tester.pumpAndSettle();
      expect(find.text('hello'), findsOneWidget);
      expect(find.text('translated hello'), findsNothing);
    },
  );
}
