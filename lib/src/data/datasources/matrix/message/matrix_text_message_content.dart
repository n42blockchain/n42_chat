Map<String, dynamic> buildTextMessageContent(
  String text, {
  int? selfDestructAfter,
  List<String>? mentionedUserIds,
  bool mentionsRoom = false,
  String? replySenderId,
  String? currentUserId,
}) {
  final content = <String, dynamic>{'msgtype': 'm.text', 'body': text};

  final mentionIds = <String>{...?mentionedUserIds};

  if (replySenderId != null &&
      replySenderId.isNotEmpty &&
      replySenderId != currentUserId) {
    mentionIds.add(replySenderId);
  }

  if (mentionsRoom || mentionIds.isNotEmpty) {
    content['m.mentions'] = <String, dynamic>{
      if (mentionsRoom) 'room': true,
      if (mentionIds.isNotEmpty) 'user_ids': mentionIds.toList(),
    };
  }

  if (selfDestructAfter != null && selfDestructAfter > 0) {
    content['n42.self_destruct'] = {'after': selfDestructAfter};
  }

  return content;
}

bool hasExtendedTextMetadata(Map<String, dynamic> content) =>
    content.containsKey('m.mentions') ||
    content.containsKey('n42.self_destruct');
