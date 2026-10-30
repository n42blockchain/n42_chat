import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/conversation_entity.dart';
import 'package:n42_chat/src/domain/entities/message_entity.dart';
import 'package:n42_chat/src/domain/services/chat_catch_up.dart';
import 'package:n42_chat/src/presentation/pages/conversation/conversation_filter.dart';

MessageEntity message(
  String id, {
  String sender = '@peer:hs',
  String room = '!r:hs',
  String? reply,
  List<String> mentions = const [],
  bool all = false,
  MessageType type = MessageType.text,
  int? ttl,
}) => MessageEntity(
  id: id,
  roomId: room,
  senderId: sender,
  senderName: sender,
  content: id,
  type: type,
  timestamp: DateTime.utc(2026),
  replyToId: reply,
  mentionedUserIds: mentions,
  mentionsRoom: all,
  selfDestructAfter: ttl,
);

void main() {
  List<MessageEntity> select(
    List<MessageEntity> messages,
    CatchUpFilter filter, {
    String? user = '@me:hs',
  }) => catchUpMessages(
    roomId: '!r:hs',
    userId: user,
    messages: messages,
    pinned: messages,
    filter: filter,
  );
  test(
    'mentions use structured IDs and room mentions, not body or sender names',
    () {
      final items = [
        message('yes', mentions: ['@me:hs']),
        message('all', all: true),
        message('@me:hs'),
        message('other', mentions: ['@someone:hs']),
        message('self', sender: '@me:hs', all: true),
      ];
      expect(select(items, CatchUpFilter.mentions).map((m) => m.id), [
        'yes',
        'all',
      ]);
      expect(select(items, CatchUpFilter.mentions, user: null), isEmpty);
    },
  );
  test(
    'replies resolve an exact own event in this room and exclude own replies',
    () {
      final items = [
        message('own', sender: '@me:hs'),
        message('yes', reply: 'own'),
        message('unknown', reply: 'missing'),
        message('self', reply: 'own', sender: '@me:hs'),
        message('foreign', room: '!other:hs', sender: '@me:hs'),
        message('wrong', reply: 'foreign'),
      ];
      expect(select(items, CatchUpFilter.replies).map((m) => m.id), ['yes']);
    },
  );
  test(
    'all filters exclude foreign, redacted and ephemeral events and duplicates',
    () {
      final own = message('own', sender: '@me:hs');
      final items = [
        own,
        message('ok', all: true, reply: 'own'),
        message('ok', all: true, reply: 'own'),
        message(
          'redacted',
          type: MessageType.redacted,
          all: true,
          reply: 'own',
        ),
        message('ttl', ttl: 10, all: true, reply: 'own'),
        message('foreign', room: '!other:hs', all: true, reply: 'own'),
      ];
      for (final filter in CatchUpFilter.values) {
        expect(
          select(items, filter).map((m) => m.id),
          filter == CatchUpFilter.pinned ? ['own', 'ok'] : ['ok'],
        );
      }
    },
  );
  test('mention room filter keeps muted highlights and rejects direct, hidden and invites', () {
    const group = ConversationEntity(
      id: '!r:hs',
      name: 'Group',
      type: ConversationType.group,
      highlightCount: 1,
      isMuted: true,
    );
    expect(ConversationFilter.mentions.matches(group), isTrue);
    expect(
      ConversationFilter.mentions.matches(group.copyWith(highlightCount: 0)),
      isFalse,
    );
    expect(
      ConversationFilter.mentions.matches(
        group.copyWith(type: ConversationType.direct),
      ),
      isFalse,
    );
    expect(
      ConversationFilter.mentions.matches(group.copyWith(isHidden: true)),
      isFalse,
    );
    expect(
      ConversationFilter.mentions.matches(group.copyWith(isInvite: true)),
      isFalse,
    );
  });
}
