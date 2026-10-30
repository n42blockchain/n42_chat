import '../../../domain/entities/conversation_entity.dart';

enum ConversationFilter {
  all,
  unread,
  groups,
  mentions;

  bool matches(ConversationEntity conversation) => switch (this) {
    all => true,
    unread => conversation.unreadCount > 0,
    groups => conversation.isGroup,
    mentions =>
      conversation.isGroup &&
          !conversation.isInvite &&
          !conversation.isHidden &&
          conversation.highlightCount > 0,
  };
}
