import 'package:flutter/material.dart';

import 'core/theme/n42_chat_theme.dart';
import 'integration/wallet_bridge.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Push Protocol 配置
// ─────────────────────────────────────────────────────────────────────────────

/// Push Protocol 链上事件推送配置
///
/// Push Protocol 是去中心化通知协议（https://push.org），
/// 支持通过钱包地址接收来自各 DApp 频道的链上事件通知。
///
/// ## 示例
/// ```dart
/// N42ChatConfig(
///   pushProtocol: PushProtocolConfig(
///     enabled: true,
///     chainId: 1, // 以太坊主网
///   ),
/// )
/// ```
@immutable
class PushProtocolConfig {
  /// 是否启用链上事件推送
  ///
  /// 默认为 `true`，设置为 `false` 可完全禁用该功能
  final bool enabled;

  /// 链 ID
  ///
  /// - 1: 以太坊主网 (Ethereum Mainnet)
  /// - 137: Polygon Mainnet
  /// - 56: BNB Smart Chain
  /// - 其他 EVM 兼容链 ID
  /// 默认为 1（以太坊主网）
  final int chainId;

  /// 自定义 Push Protocol API 基础地址
  ///
  /// 生产环境: `https://backend.epns.io/apis`（默认）
  /// 测试环境: `https://staging.backend.epns.io/apis`
  final String? apiBaseUrl;

  /// 轮询间隔
  ///
  /// 后台定期拉取新通知的频率。
  /// 过短会增加功耗和 API 请求量，建议不低于 30 秒。
  /// 默认 60 秒。
  final Duration pollInterval;

  const PushProtocolConfig({
    this.enabled = true,
    this.chainId = 1,
    this.apiBaseUrl,
    this.pollInterval = const Duration(minutes: 1),
  });
}

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

  /// 推送网关 URL
  ///
  /// Matrix Sygnal 推送网关服务器地址
  /// 用于将推送消息转发到 FCM/APNs
  final String? pushGatewayUrl;

  /// 推送应用标识符
  ///
  /// 用于 Matrix 推送注册
  final String pushAppId;

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

  /// Terms of Service URL
  ///
  /// 服务条款页面链接
  final String termsOfServiceUrl;

  /// Privacy Policy URL
  ///
  /// 隐私政策页面链接
  final String privacyPolicyUrl;

  /// Giphy API Key
  ///
  /// 用于 GIF 搜索功能。从 https://developers.giphy.com/ 获取
  /// 如果不设置，GIF 功能将不可用
  final String? giphyApiKey;

  /// Google Translate API Key
  ///
  /// 用于消息翻译功能。从 Google Cloud Console 获取
  /// 如果不设置，将使用模拟翻译（仅用于开发测试）
  final String? googleTranslateApiKey;

  /// AI API Key
  ///
  /// 用于 AI 聊天助手、摘要、改写等功能
  /// 支持 OpenAI / Claude / DeepSeek 等兼容 API
  final String? aiApiKey;

  /// AI API Base URL
  ///
  /// AI 服务的 API 基础地址
  /// 默认为 OpenAI: https://api.openai.com
  /// 可切换为其他兼容服务: https://api.deepseek.com 等
  final String aiBaseUrl;

  /// AI 默认模型
  ///
  /// 默认使用的 AI 模型名称
  final String aiModel;

  /// 存储管理配置
  final StorageManagementConfig storageManagement;

  /// Push Protocol 链上事件推送配置
  ///
  /// 为 null 时禁用链上事件推送功能。
  /// 传入 [PushProtocolConfig] 实例以启用。
  final PushProtocolConfig? pushProtocol;

  const N42ChatConfig({
    this.defaultHomeserver = 'https://m.si46.world',
    this.enableEncryption = true,
    this.enablePushNotifications = true,
    this.pushGatewayUrl,
    this.pushAppId = 'com.n42.chat',
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
    this.termsOfServiceUrl = 'https://n42.world/terms',
    this.privacyPolicyUrl = 'https://n42.world/privacy',
    this.giphyApiKey,
    this.googleTranslateApiKey,
    this.aiApiKey,
    this.aiBaseUrl = 'https://api.openai.com',
    this.aiModel = 'gpt-4o-mini',
    this.storageManagement = const StorageManagementConfig(),
    this.pushProtocol,
  });

  /// 复制并修改配置
  N42ChatConfig copyWith({
    String? defaultHomeserver,
    bool? enableEncryption,
    bool? enablePushNotifications,
    String? pushGatewayUrl,
    String? pushAppId,
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
    String? termsOfServiceUrl,
    String? privacyPolicyUrl,
    String? giphyApiKey,
    String? googleTranslateApiKey,
    String? aiApiKey,
    String? aiBaseUrl,
    String? aiModel,
    StorageManagementConfig? storageManagement,
    PushProtocolConfig? pushProtocol,
  }) {
    return N42ChatConfig(
      defaultHomeserver: defaultHomeserver ?? this.defaultHomeserver,
      enableEncryption: enableEncryption ?? this.enableEncryption,
      enablePushNotifications:
          enablePushNotifications ?? this.enablePushNotifications,
      pushGatewayUrl: pushGatewayUrl ?? this.pushGatewayUrl,
      pushAppId: pushAppId ?? this.pushAppId,
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
      termsOfServiceUrl: termsOfServiceUrl ?? this.termsOfServiceUrl,
      privacyPolicyUrl: privacyPolicyUrl ?? this.privacyPolicyUrl,
      giphyApiKey: giphyApiKey ?? this.giphyApiKey,
      googleTranslateApiKey: googleTranslateApiKey ?? this.googleTranslateApiKey,
      aiApiKey: aiApiKey ?? this.aiApiKey,
      aiBaseUrl: aiBaseUrl ?? this.aiBaseUrl,
      aiModel: aiModel ?? this.aiModel,
      storageManagement: storageManagement ?? this.storageManagement,
      pushProtocol: pushProtocol ?? this.pushProtocol,
    );
  }
}

/// 存储管理配置
@immutable
class StorageManagementConfig {
  /// 自动清理天数（超过此天数未访问的媒体可被自动清理）
  final int autoCleanupDays;

  /// 存储预警阈值 (MB)
  final int warningThresholdMB;

  /// 存储严重阈值 (MB)
  final int criticalThresholdMB;

  /// 热数据天数
  final int hotDataDays;

  /// 暖数据天数
  final int warmDataDays;

  /// 是否启用自动清理
  final bool autoCleanupEnabled;

  /// 是否保留缩略图
  final bool preserveThumbnails;

  const StorageManagementConfig({
    this.autoCleanupDays = 90,
    this.warningThresholdMB = 500,
    this.criticalThresholdMB = 1000,
    this.hotDataDays = 30,
    this.warmDataDays = 180,
    this.autoCleanupEnabled = false,
    this.preserveThumbnails = true,
  });
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

