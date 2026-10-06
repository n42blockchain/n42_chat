import '../../core/services/ai_service.dart';
import '../../domain/entities/message_entity.dart';

class AiReplySuggestionContext {
  const AiReplySuggestionContext({
    required this.anchorMessageId,
    required this.sourceMessageIds,
    required this.messages,
  });

  final String anchorMessageId;
  final List<String> sourceMessageIds;
  final List<AiMessage> messages;
}

abstract final class AiReplySuggestionHelper {
  static AiReplySuggestionContext? buildContext(
    List<MessageEntity> messages, {
    int limit = 6,
    Set<String>? authorizedMessageIds,
  }) {
    final recentMessages = messages
        .where(_isEligibleTextMessage)
        .where(
          (message) =>
              authorizedMessageIds == null ||
              authorizedMessageIds.contains(message.id),
        )
        .take(limit)
        .toList()
        .reversed
        .toList();

    if (recentMessages.isEmpty) {
      return null;
    }

    final latestMessage = recentMessages.last;
    if (latestMessage.isFromMe) {
      return null;
    }

    return AiReplySuggestionContext(
      anchorMessageId: latestMessage.id,
      sourceMessageIds: recentMessages.map((message) => message.id).toList(),
      messages: recentMessages.map(_toAiMessage).toList(),
    );
  }

  static Future<List<String>> loadSuggestions({
    required AiService aiService,
    required AiReplySuggestionContext context,
    int count = 3,
    String? language,
  }) {
    return aiService.suggestReplies(
      context.messages,
      count: count,
      language: language,
    );
  }

  static bool _isEligibleTextMessage(MessageEntity message) {
    return message.type == MessageType.text &&
        message.content.trim().isNotEmpty &&
        // Self-destruct content must never leave the device for an external AI
        // endpoint. Smart replies refresh automatically on state changes, so
        // without this the plaintext is shipped with no user action at all.
        !message.isSelfDestructing;
  }

  static AiMessage _toAiMessage(MessageEntity message) {
    // Smart replies are generated as the "assistant" turn, so the current
    // user's past messages should be mapped to assistant and the remote side
    // should be mapped to user.
    final role = message.isFromMe ? AiRole.assistant : AiRole.user;
    final prefix = message.isFromMe
        ? 'Me'
        : (message.senderName.trim().isEmpty ? 'Other' : message.senderName);
    return AiMessage(role: role, content: '$prefix: ${message.content}');
  }
}
