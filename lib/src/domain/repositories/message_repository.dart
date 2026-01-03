import 'dart:typed_data';

import '../entities/message_entity.dart';

/// 消息仓库接口
///
/// 定义消息相关的业务操作
abstract class IMessageRepository {
  /// 获取房间消息列表
  Future<List<MessageEntity>> getMessages(
    String roomId, {
    int limit = 50,
    String? beforeEventId,
  });

  /// 监听房间消息更新
  Stream<List<MessageEntity>> watchMessages(String roomId);

  /// 监听单条消息更新
  Stream<MessageEntity?> watchMessage(String roomId, String messageId);

  /// 加载更多历史消息
  Future<List<MessageEntity>> loadMoreMessages(
    String roomId, {
    int limit = 50,
  });

  /// 发送文本消息
  Future<MessageEntity?> sendTextMessage(String roomId, String text);

  /// 发送图片消息
  Future<MessageEntity?> sendImageMessage(
    String roomId, {
    required Uint8List imageBytes,
    required String filename,
    String? mimeType,
  });

  /// 发送语音消息
  Future<MessageEntity?> sendVoiceMessage(
    String roomId, {
    required Uint8List audioBytes,
    required String filename,
    required int duration,
    String? mimeType,
  });

  /// 发送视频消息
  Future<MessageEntity?> sendVideoMessage(
    String roomId, {
    required Uint8List videoBytes,
    required String filename,
    String? mimeType,
    Uint8List? thumbnailBytes,
  });

  /// 发送文件消息
  Future<MessageEntity?> sendFileMessage(
    String roomId, {
    required Uint8List fileBytes,
    required String filename,
    String? mimeType,
  });

  /// 发送位置消息
  Future<MessageEntity?> sendLocationMessage(
    String roomId, {
    required double latitude,
    required double longitude,
    String? description,
  });

  /// 重发失败的消息
  Future<bool> resendMessage(String roomId, String messageId);

  /// 撤回消息
  Future<bool> redactMessage(String roomId, String messageId, {String? reason});
  
  /// 删除发送失败的消息（从本地和服务器）
  Future<bool> deleteFailedMessage(String roomId, String messageId);

  /// 回复消息
  Future<MessageEntity?> replyToMessage(
    String roomId,
    String replyToMessageId,
    String text,
  );

  /// 编辑消息
  Future<MessageEntity?> editMessage(
    String roomId,
    String messageId,
    String newText,
  );

  /// 添加表情回应
  Future<bool> addReaction(String roomId, String messageId, String emoji);

  /// 移除表情回应
  Future<bool> removeReaction(String roomId, String messageId, String emoji);

  /// 标记消息已读
  Future<void> markAsRead(String roomId, String messageId);

  /// 发送正在输入状态
  Future<void> sendTypingNotification(String roomId, bool isTyping);
  
  /// 发送系统通知/拍一拍消息
  Future<MessageEntity?> sendNoticeMessage({
    required String roomId,
    required String notice,
  });
  
  /// 获取房间成员的拍一拍后缀
  Future<String?> getMemberPokeText({
    required String roomId,
    required String userId,
  });

  /// 获取媒体下载URL
  String? getMediaUrl(String? mxcUrl, {int? width, int? height});

  /// 下载媒体文件
  Future<Uint8List?> downloadMedia(String mxcUrl);
  
  /// 获取当前用户ID
  Future<String?> getCurrentUserId();
}

