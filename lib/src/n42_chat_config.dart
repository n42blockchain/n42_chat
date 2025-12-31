import 'package:flutter/material.dart';

import 'core/theme/n42_chat_theme.dart';
import 'integration/wallet_bridge.dart';

/// N42 Chat 模块配置
///
/// 通过此类配置聊天模块的各种行为和外观
///
/// ## 基本配置
///
/// ```dart
/// N42ChatConfig(
///   defaultHomeserver: 'https://matrix.org',
///   enableEncryption: true,
/// )
/// ```
///
/// ## 完整配置
///
/// ```dart
/// N42ChatConfig(
///   defaultHomeserver: 'https://your-matrix-server.com',
///   enableEncryption: true,
///   enablePushNotifications: true,
///   customTheme: N42ChatTheme.wechatLight(),
///   walletBridge: MyWalletBridge(),
///   onMessageTap: (roomId, eventId) {
///     // 处理消息点击
///   },
/// )
/// ```
@immutable
class N42ChatConfig {
  /// 默认Matrix服务器地址
  ///
  /// 用户登录时的默认服务器，可以在登录页面修改
  final String defaultHomeserver;

  /// 是否启用端对端加密
  ///
  /// 启用后，新创建的私聊会自动使用E2EE
  /// 默认为 `true`
  final bool enableEncryption;

  /// 是否启用推送通知
  ///
  /// 需要配置FCM/APNs才能生效
  /// 默认为 `true`
  final bool enablePushNotifications;

  /// 同步超时时间
  ///
  /// Matrix长轮询同步的超时时间
  /// 默认为30秒
  final Duration syncTimeout;

  /// 同步过滤器设置
  final SyncFilterConfig syncFilter;

  /// 自定义主题
  ///
  /// 如果不设置，将使用微信风格的默认主题
  final N42ChatTheme? customTheme;

  /// 钱包桥接器
  ///
  /// 提供此接口以启用聊天中的加密货币转账功能
  final IWalletBridge? walletBridge;

  /// 消息点击回调
  ///
  /// 当用户点击消息时触发
  final void Function(String roomId, String eventId)? onMessageTap;

  /// 头像点击回调
  ///
  /// 当用户点击头像时触发，可用于查看用户资料
  final void Function(String userId)? onAvatarTap;

  /// 外部链接处理
  ///
  /// 当消息中包含链接时的处理方式
  final Future<void> Function(String url)? onLinkTap;

  /// 转账请求回调
  ///
  /// 当用户发起转账请求时触发
  final Future<bool> Function(
    String toAddress,
    String amount,
    String token,
  )? onTransferRequest;

  /// 是否显示在线状态
  final bool showPresence;

  /// 是否显示已读回执
  final bool showReadReceipts;

  /// 是否启用消息撤回
  final bool enableMessageDelete;

  /// 消息撤回时限（秒）
  ///
  /// 超过此时间的消息不能撤回
  /// 默认为120秒（2分钟）
  final int messageDeleteTimeout;

  /// 图片最大尺寸（字节）
  ///
  /// 超过此大小的图片会被压缩
  /// 默认为10MB
  final int maxImageSize;

  /// 文件最大尺寸（字节）
  ///
  /// 默认为50MB
  final int maxFileSize;

  /// 语音消息最大时长（秒）
  ///
  /// 默认为60秒
  final int maxVoiceDuration;

  /// 是否启用调试日志
  final bool enableDebugLogs;

  /// 数据库名称
  ///
  /// 支持多账号时，每个账号使用不同的数据库
  final String? databaseName;

  const N42ChatConfig({
    this.defaultHomeserver = 'https://matrix.org',
    this.enableEncryption = true,
    this.enablePushNotifications = true,
    this.syncTimeout = const Duration(seconds: 30),
    this.syncFilter = const SyncFilterConfig(),
    this.customTheme,
    this.walletBridge,
    this.onMessageTap,
    this.onAvatarTap,
    this.onLinkTap,
    this.onTransferRequest,
    this.showPresence = true,
    this.showReadReceipts = true,
    this.enableMessageDelete = true,
    this.messageDeleteTimeout = 120,
    this.maxImageSize = 10 * 1024 * 1024, // 10MB
    this.maxFileSize = 50 * 1024 * 1024, // 50MB
    this.maxVoiceDuration = 60,
    this.enableDebugLogs = false,
    this.databaseName,
  });

  /// 复制并修改配置
  N42ChatConfig copyWith({
    String? defaultHomeserver,
    bool? enableEncryption,
    bool? enablePushNotifications,
    Duration? syncTimeout,
    SyncFilterConfig? syncFilter,
    N42ChatTheme? customTheme,
    IWalletBridge? walletBridge,
    void Function(String roomId, String eventId)? onMessageTap,
    void Function(String userId)? onAvatarTap,
    Future<void> Function(String url)? onLinkTap,
    Future<bool> Function(String, String, String)? onTransferRequest,
    bool? showPresence,
    bool? showReadReceipts,
    bool? enableMessageDelete,
    int? messageDeleteTimeout,
    int? maxImageSize,
    int? maxFileSize,
    int? maxVoiceDuration,
    bool? enableDebugLogs,
    String? databaseName,
  }) {
    return N42ChatConfig(
      defaultHomeserver: defaultHomeserver ?? this.defaultHomeserver,
      enableEncryption: enableEncryption ?? this.enableEncryption,
      enablePushNotifications:
          enablePushNotifications ?? this.enablePushNotifications,
      syncTimeout: syncTimeout ?? this.syncTimeout,
      syncFilter: syncFilter ?? this.syncFilter,
      customTheme: customTheme ?? this.customTheme,
      walletBridge: walletBridge ?? this.walletBridge,
      onMessageTap: onMessageTap ?? this.onMessageTap,
      onAvatarTap: onAvatarTap ?? this.onAvatarTap,
      onLinkTap: onLinkTap ?? this.onLinkTap,
      onTransferRequest: onTransferRequest ?? this.onTransferRequest,
      showPresence: showPresence ?? this.showPresence,
      showReadReceipts: showReadReceipts ?? this.showReadReceipts,
      enableMessageDelete: enableMessageDelete ?? this.enableMessageDelete,
      messageDeleteTimeout: messageDeleteTimeout ?? this.messageDeleteTimeout,
      maxImageSize: maxImageSize ?? this.maxImageSize,
      maxFileSize: maxFileSize ?? this.maxFileSize,
      maxVoiceDuration: maxVoiceDuration ?? this.maxVoiceDuration,
      enableDebugLogs: enableDebugLogs ?? this.enableDebugLogs,
      databaseName: databaseName ?? this.databaseName,
    );
  }
}

/// 同步过滤器配置
@immutable
class SyncFilterConfig {
  /// 每个房间加载的时间线消息数量
  final int timelineLimit;

  /// 是否包含离开的房间
  final bool includeLeaveRooms;

  /// 是否懒加载成员列表
  final bool lazyLoadMembers;

  const SyncFilterConfig({
    this.timelineLimit = 20,
    this.includeLeaveRooms = false,
    this.lazyLoadMembers = true,
  });
}

