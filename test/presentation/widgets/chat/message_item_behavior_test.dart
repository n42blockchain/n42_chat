import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/core/utils/event_message_data.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/presentation/pages/chat/message_item.dart';
import 'package:n42_chat/src/presentation/widgets/chat/code_block_message_widget.dart';
import 'package:n42_chat/src/presentation/widgets/chat/chat_widgets.dart';

MessageEntity _message({
  String id = 'event-1',
  String senderName = 'Rae',
  String content = 'A message',
  MessageType type = MessageType.text,
  MessageStatus status = MessageStatus.sent,
  bool isFromMe = false,
  bool isBotMessage = false,
  String? replyToId,
  String? replyToContent,
  String? replyToSender,
  List<MessageReaction> reactions = const [],
  MessageMetadata? metadata,
  bool isEdited = false,
  int? selfDestructAfter,
  DateTime? destroyedAt,
  DateTime? scheduledAt,
}) => MessageEntity(
  id: id,
  roomId: '!room:example.org',
  senderId: '@rae:example.org',
  senderName: senderName,
  content: content,
  type: type,
  timestamp: DateTime(2026, 10, 2, 12),
  status: status,
  isFromMe: isFromMe,
  isBotMessage: isBotMessage,
  replyToId: replyToId,
  replyToContent: replyToContent,
  replyToSender: replyToSender,
  isEdited: isEdited,
  reactions: reactions,
  metadata: metadata,
  selfDestructAfter: selfDestructAfter,
  destroyedAt: destroyedAt,
  scheduledAt: scheduledAt,
);

Widget _app(Widget child) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: S.localizationsDelegates,
  supportedLocales: S.supportedLocales,
  home: Scaffold(body: Center(child: child)),
);

void main() {
  testWidgets('system and notice messages render without a chat bubble', (
    tester,
  ) async {
    final parsed = CodeBlockMessageWidget.parse(
      '```js\nconst answer = 42;\n```',
    );
    expect(parsed.language, 'javascript');
    expect(parsed.code, 'const answer = 42;');

    await tester.pumpWidget(
      _app(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MessageItem(
              message: _message(
                type: MessageType.system,
                content: 'Rae joined',
              ),
            ),
            MessageItem(
              message: _message(
                type: MessageType.notice,
                content: 'Room renamed',
              ),
            ),
          ],
        ),
      ),
    );

    expect(find.text('Rae joined'), findsOneWidget);
    expect(find.text('Room renamed'), findsOneWidget);
    expect(find.byType(MessageBubble), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('redacted messages never render the original message body', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.redacted,
            content: 'private text that was withdrawn',
          ),
        ),
      ),
    );

    expect(find.text('private text that was withdrawn'), findsNothing);
    expect(find.byType(MessageBubble), findsNothing);
    expect(find.byType(RecalledMessageWidget), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('group text displays sender and bot marker', (tester) async {
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            senderName: 'Release helper',
            content: 'Build finished',
            isBotMessage: true,
          ),
          isGroupChat: true,
          showSenderName: true,
        ),
      ),
    );

    expect(find.text('Release helper'), findsOneWidget);
    expect(find.text('BOT'), findsOneWidget);
    expect(find.text('Build finished'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reply quote invokes navigation with its event id', (
    tester,
  ) async {
    String? openedEventId;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            content: 'Current reply',
            replyToId: 'original-event',
            replyToContent: 'Earlier statement',
            replyToSender: 'Kai',
          ),
          onReplyQuoteTap: (id) => openedEventId = id,
        ),
      ),
    );

    expect(find.text('Kai'), findsOneWidget);
    expect(find.text('Earlier statement'), findsOneWidget);
    await tester.tap(find.text('Earlier statement'));

    expect(openedEventId, 'original-event');
    expect(find.text('Current reply'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reaction count and selected reaction reach the callback', (
    tester,
  ) async {
    String? selectedEmoji;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            content: 'Thanks!',
            reactions: const [
              MessageReaction(
                key: '🎉',
                userIds: ['@me:example.org', '@rae:example.org'],
              ),
            ],
          ),
          currentUserId: '@me:example.org',
          onReactionTap: (emoji) => selectedEmoji = emoji,
        ),
      ),
    );

    expect(find.text('2'), findsOneWidget);
    await tester.tap(find.text('🎉'));

    expect(selectedEmoji, '🎉');
    expect(tester.takeException(), isNull);
  });

  testWidgets('missed incoming voice call offers a callback action', (
    tester,
  ) async {
    MessageEntity? calledBack;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.voiceCall,
            metadata: const MessageMetadata(isMissedCall: true),
          ),
          onCallBack: (message) => calledBack = message,
        ),
      ),
    );

    final callbackLabel = S
        .of(tester.element(find.byType(Scaffold)))!
        .chatCallBack;
    expect(find.text(callbackLabel), findsOneWidget);
    await tester.tap(find.text(callbackLabel));

    expect(calledBack?.type, MessageType.voiceCall);
    expect(tester.takeException(), isNull);
  });

  testWidgets('contact card parses legacy identity fields and routes tap', (
    tester,
  ) async {
    String? openedContactId;
    String? openedContactName;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.contactCard,
            content:
                '[Contact Card]\nName: Alex Example\nID: @alex:example.org',
          ),
          onContactCardTap: (id, name, _) {
            openedContactId = id;
            openedContactName = name;
          },
        ),
      ),
    );

    expect(find.text('Alex Example'), findsOneWidget);
    await tester.tap(find.text('Alex Example'));

    expect(openedContactId, '@alex:example.org');
    expect(openedContactName, 'Alex Example');
    expect(tester.takeException(), isNull);
  });

  testWidgets('code block normalizes a language alias and renders source', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.codeBlock,
            content: '```js\nconst answer = 42;\n```',
          ),
        ),
      ),
    );

    expect(find.text('JAVASCRIPT'), findsOneWidget);
    expect(find.text('Copy'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('file message displays its metadata filename and size', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.file,
            content: 'fallback.txt',
            metadata: const MessageMetadata(
              fileName: 'release-notes.txt',
              size: 1024,
            ),
          ),
        ),
      ),
    );

    expect(find.text('release-notes.txt'), findsOneWidget);
    expect(find.text('1.0 KB'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('location with a geo URI uses the localized fallback label', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.location,
            content: 'geo:43.6532,-79.3832',
            metadata: const MessageMetadata(
              latitude: 43.6532,
              longitude: -79.3832,
            ),
          ),
        ),
      ),
    );

    final locationLabel = S
        .of(tester.element(find.byType(Scaffold)))!
        .chatMyLocation;
    expect(find.text(locationLabel), findsOneWidget);
    expect(find.text('43.6532, -79.3832'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed transfer renders its failure state and amount', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.transfer,
            content: 'Rent',
            metadata: const MessageMetadata(
              amount: '2.5',
              token: 'ETH',
              transferStatus: 'failed',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Ξ2.5'), findsOneWidget);
    expect(find.text('Transfer failed'), findsOneWidget);
    expect(find.text('Rent'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('red packet action returns the message and preserves its note', (
    tester,
  ) async {
    MessageEntity? openedMessage;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            id: 'packet-event',
            type: MessageType.redPacket,
            content: 'Good luck!',
            metadata: const MessageMetadata(transferStatus: 'pending'),
          ),
          onRedPacketTap: (message) => openedMessage = message,
        ),
      ),
    );

    expect(find.text('Good luck!'), findsOneWidget);
    await tester.tap(find.text('Good luck!'));

    expect(openedMessage?.id, 'packet-event');
    expect(openedMessage?.type, MessageType.redPacket);
    expect(tester.takeException(), isNull);
  });

  testWidgets('payment request status follows paid metadata and forwards tap', (
    tester,
  ) async {
    var tapped = false;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.paymentRequest,
            content: 'Dinner',
            metadata: const MessageMetadata(
              amount: '18',
              token: 'USDT',
              transferStatus: 'paid',
            ),
          ),
          onTap: () => tapped = true,
        ),
      ),
    );

    expect(find.text('\$18'), findsOneWidget);
    expect(find.text('Dinner'), findsOneWidget);
    expect(find.text('Received'), findsOneWidget);
    await tester.tap(find.text('Dinner'));

    expect(tapped, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('poll vote callback receives the option and selection limit', (
    tester,
  ) async {
    String? pollId;
    String? optionId;
    List<String>? previousVotes;
    int? maxSelections;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            id: 'poll-event',
            type: MessageType.poll,
            content: 'Preferred release day?',
            metadata: const MessageMetadata(
              pollQuestion: 'Preferred release day?',
              pollOptions: ['Friday', 'Monday'],
              pollOptionIds: ['fri', 'mon'],
              myVotes: ['mon'],
              maxSelections: 1,
            ),
          ),
          onPollVote: (id, option, votes, limit) {
            pollId = id;
            optionId = option;
            previousVotes = votes;
            maxSelections = limit;
          },
        ),
      ),
    );

    expect(find.text('Preferred release day?'), findsOneWidget);
    expect(find.text('Friday'), findsOneWidget);
    await tester.tap(find.text('Friday'));

    expect(pollId, 'poll-event');
    expect(optionId, 'fri');
    expect(previousVotes, ['mon']);
    expect(maxSelections, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ended poll does not offer voting or end-poll actions', (
    tester,
  ) async {
    var voteCalled = false;
    var endCalled = false;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.poll,
            content: 'Release day?',
            isFromMe: true,
            metadata: const MessageMetadata(
              pollQuestion: 'Release day?',
              pollOptions: ['Friday'],
              pollOptionIds: ['fri'],
              pollEnded: true,
            ),
          ),
          onPollVote: (_, _, _, _) => voteCalled = true,
          onEndPoll: (_) => endCalled = true,
        ),
      ),
    );

    expect(find.text('Ended'), findsOneWidget);
    expect(find.text('End Poll'), findsNothing);
    await tester.tap(find.text('Friday'));

    expect(voteCalled, isFalse);
    expect(endCalled, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed outgoing message exposes a retry action', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            content: 'Send this again',
            isFromMe: true,
            status: MessageStatus.failed,
          ),
          onResend: () => retried = true,
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.priority_high));

    expect(retried, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sticker without an uploaded media URL shows its text fallback', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(type: MessageType.sticker, content: 'wave sticker'),
        ),
      ),
    );

    expect(find.text('wave sticker'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('unopened view-once video reveals only an open prompt', (
    tester,
  ) async {
    var opened = false;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.video,
            content: 'private video body',
            selfDestructAfter: 30,
          ),
          onTap: () => opened = true,
        ),
      ),
    );

    expect(find.text('View Once Video'), findsOneWidget);
    expect(find.text('Tap to view'), findsOneWidget);
    expect(find.text('private video body'), findsNothing);
    await tester.tap(find.text('View Once Video'));

    expect(opened, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('view-once video distinguishes expired and already viewed', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MessageItem(
              message: _message(
                id: 'expired-video',
                type: MessageType.video,
                isFromMe: false,
                selfDestructAfter: 30,
                destroyedAt: DateTime(2020),
              ),
            ),
            MessageItem(
              message: _message(
                id: 'viewed-video',
                type: MessageType.video,
                isFromMe: false,
                selfDestructAfter: 30,
                destroyedAt: DateTime.now().add(const Duration(minutes: 1)),
              ),
            ),
          ],
        ),
      ),
    );

    expect(find.text('Message destroyed'), findsOneWidget);
    expect(find.text('Viewed'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('video note has its own semantics and opens on tap', (
    tester,
  ) async {
    var opened = false;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.video,
            metadata: const MessageMetadata(fileName: 'n42note_123.mp4'),
          ),
          onTap: () => opened = true,
        ),
      ),
    );

    final videoNote = find.bySemanticsLabel('Video note');
    expect(videoNote, findsOneWidget);
    await tester.tap(videoNote);

    expect(opened, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tip card distinguishes off-chain and confirmed transfers', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MessageItem(
              message: _message(
                type: MessageType.tip,
                content: 'Coffee',
                metadata: const MessageMetadata(amount: '2', token: 'USDC'),
              ),
            ),
            MessageItem(
              message: _message(
                id: 'confirmed-tip',
                type: MessageType.tip,
                content: 'Lunch',
                metadata: const MessageMetadata(
                  amount: '5',
                  token: 'USDC',
                  txHash: '0xabc',
                ),
              ),
            ),
          ],
        ),
      ),
    );

    expect(find.text('Tip · 2 USDC'), findsOneWidget);
    expect(find.text('Sent'), findsOneWidget);
    expect(find.text('On-chain ✓'), findsOneWidget);
    expect(find.text('Coffee'), findsOneWidget);
    expect(find.text('Lunch'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('music card displays metadata and opens a linked song', (
    tester,
  ) async {
    var opened = false;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.music,
            metadata: const MessageMetadata(
              musicTitle: 'North Star',
              musicArtist: 'The Example Band',
              musicUrl: 'https://music.example/song/1',
            ),
          ),
          onTap: () => opened = true,
        ),
      ),
    );

    expect(find.text('North Star'), findsOneWidget);
    expect(find.text('The Example Band'), findsOneWidget);
    await tester.tap(find.text('North Star'));

    expect(opened, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('event message presents its date, location and description', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.event,
            metadata: MessageMetadata(
              event: EventMessageData(
                title: 'Release meetup',
                startsAt: DateTime(2026, 10, 2, 12),
                endsAt: DateTime(2026, 10, 2, 13),
                location: 'Toronto office',
                description: 'Bring a demo',
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Release meetup'), findsOneWidget);
    expect(find.text('Toronto office'), findsOneWidget);
    expect(find.text('Bring a demo'), findsOneWidget);
    expect(find.text('Add to calendar'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('event without structured metadata safely shows the body', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.event,
            content: 'Event details from an older client',
          ),
        ),
      ),
    );

    expect(find.text('Event details from an older client'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('voted quiz reveals the answer and locks further voting', (
    tester,
  ) async {
    var voteCalled = false;
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.poll,
            content: 'Which option is correct?',
            metadata: const MessageMetadata(
              pollQuestion: 'Which option is correct?',
              pollOptions: ['Wrong', 'Correct'],
              pollOptionIds: ['wrong', 'correct'],
              myVotes: ['wrong'],
              quizCorrectIndex: 1,
              quizExplanation: 'The second choice is correct.',
            ),
          ),
          onPollVote: (_, _, _, _) => voteCalled = true,
        ),
      ),
    );

    expect(find.text('The second choice is correct.'), findsOneWidget);
    await tester.tap(find.text('Correct'));

    expect(voteCalled, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('pending self-destruct and scheduled messages show their cues', (
    tester,
  ) async {
    final futureSend = DateTime.now().add(const Duration(hours: 1));
    await tester.pumpWidget(
      _app(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MessageItem(
              message: _message(content: 'Temporary', selfDestructAfter: 60),
            ),
            MessageItem(
              message: _message(
                id: 'scheduled-message',
                content: 'Send later',
                isFromMe: true,
                scheduledAt: futureSend,
              ),
            ),
          ],
        ),
      ),
    );

    expect(find.byIcon(Icons.timer_outlined), findsOneWidget);
    expect(find.byIcon(Icons.schedule), findsOneWidget);
    expect(find.textContaining('Scheduled'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('payment request expires after its deadline', (tester) async {
    await tester.pumpWidget(
      _app(
        MessageItem(
          message: _message(
            type: MessageType.paymentRequest,
            content: 'Old request',
            metadata: MessageMetadata(
              amount: '3',
              token: 'USDT',
              paymentRequestExpiresAt: DateTime(2020),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Expired'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
