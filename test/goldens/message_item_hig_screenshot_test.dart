// Visual review fixture for the chat page message types (HIG audit).
//
// Not a golden assertion: each case renders a representative set of
// MessageItem types in light/dark at 100% and 130% text scale, checks that
// layout raised no exception, and writes a PNG to build/hig-shots/ for
// before/after comparison. Uses a local system font when one is available so
// text is readable instead of test boxes.
//
// Run: flutter test test/goldens/message_item_hig_screenshot_test.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/theme/n42_chat_theme.dart';
import 'package:n42_chat/src/core/utils/event_message_data.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/presentation/pages/chat/message_item.dart';

const _font = 'ChatHigFont';
const _outDir = 'build/hig-shots';

Future<void> _loadFont() async {
  for (final path in [
    r'C:\Windows\Fonts\msyh.ttc',
    r'C:\Windows\Fonts\segoeui.ttf',
    '/System/Library/Fonts/Supplemental/Arial Unicode.ttf',
    '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
  ]) {
    final file = File(path);
    if (!file.existsSync()) continue;
    final bytes = file.readAsBytesSync();
    for (final family in [_font, 'Roboto']) {
      await (FontLoader(
        family,
      )..addFont(Future.value(ByteData.sublistView(bytes)))).load();
    }
    break;
  }
  // Material icons ship with the SDK, not with this package's assets.
  final root = Platform.environment['FLUTTER_ROOT'];
  final icons = File(
    '${root ?? ''}/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
  );
  if (root != null && icons.existsSync()) {
    await (FontLoader(
          'MaterialIcons',
        )..addFont(Future.value(ByteData.sublistView(icons.readAsBytesSync()))))
        .load();
  }
}

final _now = DateTime(2026, 11, 15, 9, 41);

MessageEntity _msg(
  String id,
  MessageType type, {
  String content = '',
  bool self = false,
  MessageMetadata? metadata,
  String? replyToId,
  String? replyToContent,
  String? replyToSender,
  bool edited = false,
}) => MessageEntity(
  id: id,
  roomId: '!room:hs.test',
  senderId: self ? '@me:hs.test' : '@alice:hs.test',
  senderName: self ? 'Me' : 'Alice',
  content: content,
  type: type,
  timestamp: _now,
  isFromMe: self,
  metadata: metadata,
  replyToId: replyToId,
  replyToContent: replyToContent,
  replyToSender: replyToSender,
  isEdited: edited,
);

List<MessageEntity> _messages() => [
  _msg(
    r'$text',
    MessageType.text,
    content:
        'Send it to 0x1234567890abcdef1234567890abcdef12345678 please, '
        'thanks!',
  ),
  _msg(
    r'$reply',
    MessageType.text,
    self: true,
    content: 'Sent, check the explorer.',
    replyToId: r'$text',
    replyToContent: 'Send it to 0x1234… please',
    replyToSender: 'Alice',
    edited: true,
  ),
  _msg(
    r'$poll',
    MessageType.poll,
    content: 'Lunch?',
    metadata: const MessageMetadata(
      pollQuestion: 'Lunch?',
      pollOptions: ['Noodles', 'Salad'],
      pollOptionIds: ['a', 'b'],
      voteCounts: {'a': 2, 'b': 1},
      totalVoters: 3,
      maxSelections: 1,
    ),
  ),
  _msg(
    r'$event',
    MessageType.event,
    content: 'Team meeting',
    metadata: MessageMetadata(
      event: EventMessageData(
        title: 'Team meeting',
        startsAt: DateTime.utc(2026, 11, 20, 10),
        location: 'Office',
      ),
    ),
  ),
  _msg(
    r'$call',
    MessageType.voiceCall,
    metadata: const MessageMetadata(isMissedCall: true),
  ),
];

void main() {
  setUpAll(_loadFont);

  for (final dark in [false, true]) {
    for (final scale in [1.0, 1.3]) {
      final name =
          'chat-messages-${dark ? 'dark' : 'light'}${scale == 1.0 ? '' : '-130'}';
      testWidgets(name, (tester) async {
        tester.view.physicalSize = const Size(780, 1688);
        tester.view.devicePixelRatio = 2;
        addTearDown(tester.view.reset);
        final chatTheme = dark
            ? N42ChatTheme.wechatDark()
            : N42ChatTheme.wechatLight();
        final base = chatTheme.toThemeData();
        final key = GlobalKey();
        await tester.pumpWidget(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: const Locale('en'),
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,
            theme: base.copyWith(
              textTheme: base.textTheme.apply(fontFamily: _font),
            ),
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(scale)),
              child: DefaultTextStyle.merge(
                style: const TextStyle(fontFamily: _font),
                child: child!,
              ),
            ),
            home: RepaintBoundary(
              key: key,
              child: Scaffold(
                backgroundColor: chatTheme.backgroundColor,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (final m in _messages())
                        MessageItem(
                          message: m,
                          currentUserId: '@me:hs.test',
                          onTap: () {},
                          onReplyQuoteTap: (_) {},
                          onPollVote: (_, _, _, _) {},
                          onEndPoll: (_) {},
                          onCallBack: (_) {},
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        final boundary =
            key.currentContext!.findRenderObject() as RenderRepaintBoundary;
        await tester.runAsync(() async {
          final image = await boundary.toImage(pixelRatio: 2);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          Directory(_outDir).createSync(recursive: true);
          File('$_outDir/$name.png')
              .writeAsBytesSync(bytes!.buffer.asUint8List());
          image.dispose();
        });
      });
    }
  }
}
