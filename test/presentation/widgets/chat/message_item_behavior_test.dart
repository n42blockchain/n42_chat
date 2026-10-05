import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/presentation/pages/chat/message_item.dart';

const _pollId = r'$poll-event';

MessageEntity _pollMessage({
  List<String> options = const ['Option A', 'Option B'],
  List<String> optionIds = const ['a', 'b'],
  List<String> myVotes = const [],
  Map<String, int> voteCounts = const {},
  int totalVoters = 0,
  int maxSelections = 1,
  bool ended = false,
  int? correctIndex,
  String? explanation,
  bool isFromMe = false,
}) {
  return MessageEntity(
    id: _pollId,
    roomId: '!poll:hs.test',
    senderId: '@alice:hs.test',
    senderName: 'Alice',
    content: 'Choose a color',
    type: MessageType.poll,
    timestamp: DateTime(2026),
    isFromMe: isFromMe,
    metadata: MessageMetadata(
      pollQuestion: 'Choose a color',
      pollOptions: options,
      pollOptionIds: optionIds,
      myVotes: myVotes,
      voteCounts: voteCounts,
      totalVoters: totalVoters,
      maxSelections: maxSelections,
      pollEnded: ended,
      quizCorrectIndex: correctIndex,
      quizExplanation: explanation,
    ),
  );
}

Future<void> _showMessage(
  WidgetTester tester,
  MessageEntity message, {
  void Function(String, String, List<String>, int)? onPollVote,
  void Function(String)? onEndPoll,
  void Function(String, String, String?)? onContactCardTap,
  void Function(MessageEntity)? onCallBack,
  void Function(MessageEntity)? onRedPacketTap,
  void Function(MessageEntity)? onThreadTap,
  void Function(String)? onReactionTap,
  String? currentUserId,
  VoidCallback? onTap,
  void Function(String)? onReplyQuoteTap,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      home: Scaffold(
        body: SingleChildScrollView(
          child: MessageItem(
            message: message,
            onPollVote: onPollVote,
            onEndPoll: onEndPoll,
            onContactCardTap: onContactCardTap,
            onCallBack: onCallBack,
            onRedPacketTap: onRedPacketTap,
            onThreadTap: onThreadTap,
            onReactionTap: onReactionTap,
            currentUserId: currentUserId,
            onTap: onTap,
            onReplyQuoteTap: onReplyQuoteTap,
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('sticker without uploaded media keeps its text fallback', (
    tester,
  ) async {
    await _showMessage(
      tester,
      MessageEntity(
        id: r'$sticker-fallback',
        roomId: '!room:hs.test',
        senderId: '@alice:hs.test',
        senderName: 'Alice',
        content: 'Party time',
        type: MessageType.sticker,
        timestamp: DateTime(2026),
      ),
    );

    expect(find.text('Party time'), findsOneWidget);
  });

  testWidgets('music card only opens when it has a playable URL', (
    tester,
  ) async {
    var taps = 0;
    await _showMessage(
      tester,
      MessageEntity(
        id: r'$music-no-url',
        roomId: '!room:hs.test',
        senderId: '@alice:hs.test',
        senderName: 'Alice',
        content: '',
        type: MessageType.music,
        timestamp: DateTime(2026),
        metadata: const MessageMetadata(
          musicTitle: 'Quiet Morning',
          musicArtist: 'Sample Artist',
        ),
      ),
      onTap: () => taps++,
    );
    expect(find.text('Quiet Morning'), findsOneWidget);
    expect(find.text('Sample Artist'), findsOneWidget);
    await tester.tap(find.text('Quiet Morning'));
    expect(taps, 0);

    await _showMessage(
      tester,
      MessageEntity(
        id: r'$music-playable',
        roomId: '!room:hs.test',
        senderId: '@alice:hs.test',
        senderName: 'Alice',
        content: '',
        type: MessageType.music,
        timestamp: DateTime(2026),
        metadata: const MessageMetadata(
          musicTitle: 'Open Road',
          musicArtist: 'Another Artist',
          musicUrl: 'https://media.test/song.mp3',
        ),
      ),
      onTap: () => taps++,
    );
    await tester.tap(find.text('Open Road'));
    expect(taps, 1);
  });

  testWidgets('video-note filename renders as a tappable circle', (
    tester,
  ) async {
    var taps = 0;
    await _showMessage(
      tester,
      MessageEntity(
        id: r'$video-note',
        roomId: '!room:hs.test',
        senderId: '@alice:hs.test',
        senderName: 'Alice',
        content: '',
        type: MessageType.video,
        timestamp: DateTime(2026),
        metadata: MessageMetadata(fileName: 'n42note_123.mp4'),
      ),
      onTap: () => taps++,
    );

    final videoNote = find.bySemanticsLabel('Video note');
    expect(videoNote, findsOneWidget);
    expect(
      find.descendant(of: videoNote, matching: find.byType(ClipOval)),
      findsOneWidget,
    );
    await tester.tap(videoNote);
    expect(taps, 1);
  });

  testWidgets('completed voice call formats its duration', (tester) async {
    await _showMessage(
      tester,
      MessageEntity(
        id: r'$voice-call-completed',
        roomId: '!room:hs.test',
        senderId: '@alice:hs.test',
        senderName: 'Alice',
        content: '',
        type: MessageType.voiceCall,
        timestamp: DateTime(2026),
        metadata: const MessageMetadata(callDuration: 75),
      ),
    );

    expect(find.textContaining('01:15'), findsOneWidget);
  });

  testWidgets('reaction chips report the selected emoji', (tester) async {
    String? selectedEmoji;
    final message = MessageEntity(
      id: r'$reaction',
      roomId: '!room:hs.test',
      senderId: '@alice:hs.test',
      senderName: 'Alice',
      content: 'Good news',
      type: MessageType.text,
      timestamp: DateTime(2026),
      reactions: const [
        MessageReaction(
          key: '🎉',
          userIds: ['@alice:hs.test', '@bob:hs.test'],
          aggregateCount: 2,
        ),
      ],
    );
    await _showMessage(
      tester,
      message,
      currentUserId: '@alice:hs.test',
      onReactionTap: (emoji) => selectedEmoji = emoji,
    );

    expect(find.text('2'), findsOneWidget);
    await tester.tap(find.text('🎉'));
    expect(selectedEmoji, '🎉');
  });

  testWidgets('thread root shows its reply preview and opens the thread', (
    tester,
  ) async {
    MessageEntity? openedThread;
    final message = MessageEntity(
      id: r'$thread-root',
      roomId: '!room:hs.test',
      senderId: '@alice:hs.test',
      senderName: 'Alice',
      content: 'Let us decide here',
      type: MessageType.text,
      timestamp: DateTime(2026),
      threadReplyCount: 2,
      threadLatestReply: 'I agree',
      threadUnreadCount: 1,
    );
    await _showMessage(
      tester,
      message,
      onThreadTap: (value) => openedThread = value,
    );

    expect(find.text('2 replies'), findsOneWidget);
    expect(find.text('I agree'), findsOneWidget);
    await tester.tap(find.text('2 replies'));
    expect(openedThread, message);
  });

  testWidgets('scheduled message shows its future send time', (tester) async {
    final scheduledAt = DateTime.now().add(const Duration(hours: 2));
    await _showMessage(
      tester,
      MessageEntity(
        id: r'$scheduled',
        roomId: '!room:hs.test',
        senderId: '@alice:hs.test',
        senderName: 'Alice',
        content: 'Send this later',
        type: MessageType.text,
        timestamp: DateTime(2026),
        scheduledAt: scheduledAt,
      ),
    );

    expect(find.byIcon(Icons.schedule), findsOneWidget);
    expect(find.textContaining('Scheduled'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'system notices render their text and redacted bodies stay hidden',
    (tester) async {
      for (final type in [MessageType.system, MessageType.notice]) {
        await _showMessage(
          tester,
          MessageEntity(
            id: 'system-${type.name}',
            roomId: '!room:hs.test',
            senderId: '@server:hs.test',
            senderName: 'Server',
            content: 'Room topic changed',
            type: type,
            timestamp: DateTime(2026),
          ),
        );
        expect(find.text('Room topic changed'), findsOneWidget);
      }

      await _showMessage(
        tester,
        MessageEntity(
          id: r'$redacted',
          roomId: '!room:hs.test',
          senderId: '@alice:hs.test',
          senderName: 'Alice',
          content: 'private text that was removed',
          type: MessageType.redacted,
          timestamp: DateTime(2026),
        ),
      );
      expect(find.text('private text that was removed'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('single-choice option reports the poll and current vote state', (
    tester,
  ) async {
    String? pollId;
    String? optionId;
    List<String>? currentVotes;
    int? maxSelections;
    await _showMessage(
      tester,
      _pollMessage(totalVoters: 3, voteCounts: const {'a': 2, 'b': 1}),
      onPollVote: (id, option, votes, max) {
        pollId = id;
        optionId = option;
        currentVotes = votes;
        maxSelections = max;
      },
    );

    expect(find.text('Choose a color'), findsOneWidget);
    expect(find.text('2 votes (67%)'), findsOneWidget);
    await tester.tap(find.text('Option B'));

    expect(pollId, _pollId);
    expect(optionId, 'b');
    expect(currentVotes, isEmpty);
    expect(maxSelections, 1);
  });

  testWidgets('full multi-choice poll permits deselection only', (
    tester,
  ) async {
    final changedOptions = <String>[];
    await _showMessage(
      tester,
      _pollMessage(
        options: const ['Option A', 'Option B', 'Option C'],
        optionIds: const ['a', 'b', 'c'],
        myVotes: const ['a', 'b'],
        maxSelections: 2,
      ),
      onPollVote: (_, option, _, _) => changedOptions.add(option),
    );

    await tester.tap(find.text('Option C'));
    expect(changedOptions, isEmpty);
    await tester.tap(find.text('Option A'));
    expect(changedOptions, ['a']);
  });

  testWidgets('ended poll displays its state and ignores option taps', (
    tester,
  ) async {
    final changedOptions = <String>[];
    await _showMessage(
      tester,
      _pollMessage(ended: true),
      onPollVote: (_, option, _, _) => changedOptions.add(option),
    );

    expect(find.text('Ended'), findsOneWidget);
    await tester.tap(find.text('Option A'));
    expect(changedOptions, isEmpty);
  });

  testWidgets('quiz reveal marks the correct answer and shows explanation', (
    tester,
  ) async {
    await _showMessage(
      tester,
      _pollMessage(
        options: const ['Correct answer', 'Selected wrong answer'],
        optionIds: const ['correct', 'wrong'],
        myVotes: const ['wrong'],
        correctIndex: 0,
        explanation: 'Color theory explains the answer.',
      ),
    );

    expect(find.text('Color theory explains the answer.'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(find.byIcon(Icons.cancel), findsOneWidget);
  });

  testWidgets('poll owner can end an active poll', (tester) async {
    String? endedPollId;
    await _showMessage(
      tester,
      _pollMessage(isFromMe: true),
      onEndPoll: (id) => endedPollId = id,
    );

    expect(tester.takeException(), isNull);
    await tester.tap(find.text('End Poll'));
    expect(endedPollId, _pollId);
  });

  testWidgets('poll footer fits a narrow screen beside the owner action', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(260, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await _showMessage(
      tester,
      _pollMessage(totalVoters: 123456789, isFromMe: true),
    );

    expect(find.text('End Poll'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('contact card parses legacy fields and opens the contact', (
    tester,
  ) async {
    String? openedId;
    String? openedName;
    String? openedAvatar;
    final contact = MessageEntity(
      id: r'$contact-card',
      roomId: '!room:hs.test',
      senderId: '@alice:hs.test',
      senderName: 'Alice',
      content:
          '[Contact Card]\nName: Alice Example\nID: @alice:hs.test\nAvatar:',
      type: MessageType.contactCard,
      timestamp: DateTime(2026),
    );
    await _showMessage(
      tester,
      contact,
      onContactCardTap: (id, name, avatar) {
        openedId = id;
        openedName = name;
        openedAvatar = avatar;
      },
    );

    expect(find.text('Alice Example'), findsOneWidget);
    await tester.tap(find.text('Alice Example'));
    expect(openedId, '@alice:hs.test');
    expect(openedName, 'Alice Example');
    expect(openedAvatar, isNull);
  });

  testWidgets('text-formatted contact card also opens the parsed contact', (
    tester,
  ) async {
    String? openedId;
    final contact = MessageEntity(
      id: r'$contact-text',
      roomId: '!room:hs.test',
      senderId: '@alice:hs.test',
      senderName: 'Alice',
      content: '[Personal Contact]\n联系人：林\nID：@lin:hs.test',
      type: MessageType.text,
      timestamp: DateTime(2026),
    );
    await _showMessage(
      tester,
      contact,
      onContactCardTap: (id, _, _) => openedId = id,
    );

    expect(find.text('林'), findsNWidgets(2));
    await tester.tap(find.text('林').last);
    expect(openedId, '@lin:hs.test');
  });

  testWidgets('missed video call callback receives its message', (
    tester,
  ) async {
    MessageEntity? calledBack;
    final message = MessageEntity(
      id: r'$missed-call',
      roomId: '!room:hs.test',
      senderId: '@alice:hs.test',
      senderName: 'Alice',
      content: '',
      type: MessageType.videoCall,
      timestamp: DateTime(2026),
      metadata: const MessageMetadata(isMissedCall: true),
    );
    await _showMessage(
      tester,
      message,
      onCallBack: (value) => calledBack = value,
    );

    expect(find.text('Missed video call'), findsOneWidget);
    await tester.tap(find.text('Call back'));
    expect(calledBack, message);
  });

  testWidgets('reply quote routes to the original message', (tester) async {
    String? openedMessageId;
    final message = MessageEntity(
      id: r'$reply',
      roomId: '!room:hs.test',
      senderId: '@alice:hs.test',
      senderName: 'Alice',
      content: 'My answer',
      type: MessageType.text,
      timestamp: DateTime(2026),
      replyToId: r'$original',
      replyToContent: 'Original question',
      replyToSender: 'Bob',
    );
    await _showMessage(
      tester,
      message,
      onReplyQuoteTap: (id) => openedMessageId = id,
    );

    expect(find.text('Bob'), findsOneWidget);
    expect(find.text('Original question'), findsOneWidget);
    await tester.tap(find.text('Original question'));
    expect(openedMessageId, r'$original');
  });

  testWidgets('file message formats byte sizes across display units', (
    tester,
  ) async {
    for (final (bytes, label) in <(int, String)>[
      (512, '512 B'),
      (1536, '1.5 KB'),
      (1572864, '1.5 MB'),
      (1073741824, '1.0 GB'),
    ]) {
      await _showMessage(
        tester,
        MessageEntity(
          id: 'file-$bytes',
          roomId: '!room:hs.test',
          senderId: '@alice:hs.test',
          senderName: 'Alice',
          content: 'report.bin',
          type: MessageType.file,
          timestamp: DateTime(2026),
          metadata: MessageMetadata(size: bytes, fileName: 'report.bin'),
        ),
      );
      expect(find.text('report.bin'), findsOneWidget);
      expect(find.text(label), findsOneWidget);
    }
  });

  testWidgets('payment request renders lifecycle states and opens on tap', (
    tester,
  ) async {
    final openedMessages = <MessageEntity>[];
    final pending = MessageEntity(
      id: r'$request-pending',
      roomId: '!room:hs.test',
      senderId: '@alice:hs.test',
      senderName: 'Alice',
      content: 'Lunch',
      type: MessageType.paymentRequest,
      timestamp: DateTime(2026),
      metadata: const MessageMetadata(amount: '1.25', token: 'ETH'),
    );
    await _showMessage(
      tester,
      pending,
      onTap: () => openedMessages.add(pending),
    );
    expect(find.text('Ξ1.25'), findsOneWidget);
    expect(find.text('Payment'), findsOneWidget);
    expect(find.text('Lunch'), findsOneWidget);
    await tester.tap(find.text('Ξ1.25'));
    expect(openedMessages, [pending]);

    for (final (status, expected) in <(String, String)>[
      ('completed', 'Received'),
      ('paid', 'Received'),
      ('received', 'Received'),
    ]) {
      await _showMessage(
        tester,
        MessageEntity(
          id: 'request-$status',
          roomId: '!room:hs.test',
          senderId: '@alice:hs.test',
          senderName: 'Alice',
          content: 'Invoice',
          type: MessageType.paymentRequest,
          timestamp: DateTime(2026),
          metadata: MessageMetadata(
            amount: '4.00',
            token: 'USDT',
            transferStatus: status,
          ),
        ),
      );
      expect(find.text('\$4.00'), findsOneWidget);
      expect(find.text(expected), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    }

    await _showMessage(
      tester,
      MessageEntity(
        id: r'$request-expired',
        roomId: '!room:hs.test',
        senderId: '@alice:hs.test',
        senderName: 'Alice',
        content: 'Old request',
        type: MessageType.paymentRequest,
        timestamp: DateTime(2026),
        metadata: MessageMetadata(
          amount: '0.5',
          token: 'BTC',
          paymentRequestExpiresAt: DateTime.now().subtract(
            const Duration(minutes: 1),
          ),
        ),
      ),
    );
    expect(find.text('₿0.5'), findsOneWidget);
    expect(find.text('Expired'), findsOneWidget);
  });

  testWidgets('transfer messages render each server lifecycle state', (
    tester,
  ) async {
    for (final (status, expected) in <(String, String)>[
      ('pending', 'Tap to claim'),
      ('completed', 'Received Transfer'),
      ('received', 'Received Transfer'),
      ('failed', 'Transfer failed'),
      ('cancelled', 'Transfer cancelled'),
      ('refunded', 'Transfer cancelled'),
      ('expired', 'Expired'),
      ('unknown', 'Tap to claim'),
    ]) {
      await _showMessage(
        tester,
        MessageEntity(
          id: 'transfer-$status',
          roomId: '!room:hs.test',
          senderId: '@alice:hs.test',
          senderName: 'Alice',
          content: 'Coffee',
          type: MessageType.transfer,
          timestamp: DateTime(2026),
          metadata: MessageMetadata(
            amount: '0.002',
            token: 'BTC',
            transferStatus: status,
          ),
        ),
      );

      expect(find.text('₿0.002'), findsOneWidget);
      expect(find.text(expected), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('red packet renders claimed states and invokes its callback', (
    tester,
  ) async {
    MessageEntity? opened;
    for (final (status, expected) in <(String, String)>[
      ('opened', 'Claimed'),
      ('expired', 'Expired'),
      ('empty', 'All claimed'),
    ]) {
      final message = MessageEntity(
        id: 'red-packet-$status',
        roomId: '!room:hs.test',
        senderId: '@alice:hs.test',
        senderName: 'Alice',
        content: '',
        type: MessageType.redPacket,
        timestamp: DateTime(2026),
        metadata: MessageMetadata(transferStatus: status),
      );
      await _showMessage(
        tester,
        message,
        onRedPacketTap: (value) => opened = value,
      );

      expect(find.text('Best wishes for prosperity'), findsOneWidget);
      expect(find.text(expected), findsOneWidget);
      await tester.tap(find.text('Best wishes for prosperity'));
      expect(opened, message);
    }
    expect(tester.takeException(), isNull);
  });
}
