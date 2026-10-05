import 'package:flutter_test/flutter_test.dart';
import 'package:n42_chat/src/domain/entities/moment_entity.dart';

void main() {
  test('post and comment preserve optional canonical identity through copy', () {
    final timestamp = DateTime.utc(2026);
    final legacy = MomentEntity(
      id: 'moment-content-id',
      userId: '@author:hs.test',
      userName: 'Author',
      timestamp: timestamp,
    );
    expect(legacy.sourceRoomId, isNull);
    expect(legacy.sourceEventId, isNull);
    final post = legacy.copyWith(
      sourceRoomId: '!room-a:hs.test',
      sourceEventId: r'$post-event',
    );
    expect(post.sourceRoomId, '!room-a:hs.test');
    expect(post.sourceEventId, r'$post-event');
    expect(post.copyWith(content: 'Updated'), isNot(legacy));
    expect(post.copyWith(), post);

    final oldComment = MomentComment(
      id: 'comment-content-id',
      userId: '@commenter:hs.test',
      userName: 'Commenter',
      content: 'Text',
      timestamp: timestamp,
    );
    expect(oldComment.sourceRoomId, isNull);
    expect(oldComment.sourceEventId, isNull);
    final comment = oldComment.copyWith(
      sourceRoomId: '!room-a:hs.test',
      sourceEventId: r'$comment-event',
    );
    expect(comment.sourceRoomId, post.sourceRoomId);
    expect(comment.sourceEventId, r'$comment-event');
    expect(comment.copyWith(), comment);
    expect(comment, isNot(oldComment));
  });
}
