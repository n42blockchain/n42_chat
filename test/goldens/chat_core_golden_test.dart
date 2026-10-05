import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/core/theme/n42_chat_theme.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/presentation/pages/conversation/conversation_tile.dart';
import 'package:n42_chat/src/presentation/widgets/chat/message_bubble.dart';
import 'package:n42_chat/src/presentation/widgets/chat/message_status_indicator.dart';

const _goldenSize = Size(390, 760);

void main() {
  testWidgets('chat core matches the light theme baseline', (tester) async {
    await _pumpGolden(tester, N42ChatTheme.wechatLight());

    await expectLater(
      find.byKey(const ValueKey('chat-core-golden')),
      matchesGoldenFile('baselines/chat_core_light.png'),
    );
  });

  testWidgets('chat core matches the dark theme baseline', (tester) async {
    await _pumpGolden(tester, N42ChatTheme.wechatDark());

    await expectLater(
      find.byKey(const ValueKey('chat-core-golden')),
      matchesGoldenFile('baselines/chat_core_dark.png'),
    );
  });
}

Future<void> _pumpGolden(WidgetTester tester, N42ChatTheme chatTheme) async {
  tester.view.physicalSize = _goldenSize;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      theme: chatTheme.toThemeData(),
      home: _ChatCoreGolden(chatTheme: chatTheme),
    ),
  );
  await tester.pumpAndSettle();
}

class _ChatCoreGolden extends StatelessWidget {
  const _ChatCoreGolden({required this.chatTheme});

  final N42ChatTheme chatTheme;

  @override
  Widget build(BuildContext context) {
    final sectionStyle = Theme.of(context).textTheme.labelLarge;

    return RepaintBoundary(
      key: const ValueKey('chat-core-golden'),
      child: ColoredBox(
        color: chatTheme.backgroundColor,
        child: SizedBox.expand(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Message bubbles', style: sectionStyle),
                ),
                const SizedBox(height: 4),
                MessageBubble(
                  isSelf: false,
                  avatarName: 'Alice',
                  showTimestamp: true,
                  timestamp: DateTime(2026, 8, 31, 9, 41),
                  child: Text(
                    'Spacing tokens keep this layout steady.',
                    style: TextStyle(
                      color: chatTheme.messageTextReceivedColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                MessageBubble(
                  isSelf: true,
                  avatarName: 'Me',
                  child: Text(
                    'Light and dark themes now share one visual baseline.',
                    style: TextStyle(
                      color: chatTheme.messageTextSentColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                MessageBubble(
                  isSelf: true,
                  avatarName: 'Me',
                  status: MessageStatus.failed,
                  child: Text(
                    'Retry this message',
                    style: TextStyle(
                      color: chatTheme.messageTextSentColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Conversation list', style: sectionStyle),
                ),
                const SizedBox(height: 4),
                const ConversationTile(
                  conversation: ConversationEntity(
                    id: 'alice',
                    name: 'Alice',
                    lastMessage: 'Tokenized spacing is ready.',
                    unreadCount: 7,
                    isEncrypted: true,
                  ),
                ),
                const ConversationTile(
                  conversation: ConversationEntity(
                    id: 'design-review',
                    name: 'Design review',
                    lastMessage: 'Dark theme checked',
                    lastMessageSenderName: 'Mina',
                    unreadCount: 3,
                    type: ConversationType.group,
                    isPinned: true,
                    isMuted: true,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Large text (1.3x)', style: sectionStyle),
                ),
                const SizedBox(height: 4),
                MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: const TextScaler.linear(1.3)),
                  child: MessageBubble(
                    isSelf: false,
                    avatarName: 'A',
                    child: Text(
                      'A one-pixel type change should be visible here.',
                      style: TextStyle(
                        color: chatTheme.messageTextReceivedColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
