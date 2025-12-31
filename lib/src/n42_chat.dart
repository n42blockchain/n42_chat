import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'n42_chat_config.dart';
import 'core/di/injection.dart';
import 'domain/entities/user_entity.dart';

/// N42 Chat 模块主入口类
///
/// 提供聊天模块的所有公共API，支持：
/// - 独立运行模式
/// - 嵌入主应用模式
///
/// ## 使用示例
///
/// ```dart
/// // 初始化
/// await N42Chat.initialize(N42ChatConfig(
///   defaultHomeserver: 'https://matrix.org',
/// ));
///
/// // 获取聊天Widget嵌入TabView
/// TabBarView(
///   children: [
///     WalletPage(),
///     N42Chat.chatWidget(),
///     // ...
///   ],
/// )
/// ```
class N42Chat {
  N42Chat._();

  static bool _initialized = false;
  static N42ChatConfig? _config;

  /// 获取当前配置
  static N42ChatConfig? get config => _config;

  /// 是否已初始化
  static bool get isInitialized => _initialized;

  /// 初始化聊天模块
  ///
  /// 必须在使用其他API之前调用此方法
  ///
  /// [config] 模块配置
  ///
  /// ```dart
  /// await N42Chat.initialize(N42ChatConfig(
  ///   defaultHomeserver: 'https://matrix.org',
  ///   enableEncryption: true,
  /// ));
  /// ```
  static Future<void> initialize(N42ChatConfig config) async {
    if (_initialized) {
      debugPrint('N42Chat: Already initialized');
      return;
    }

    _config = config;

    // 初始化依赖注入
    await configureDependencies(config);

    // TODO: 初始化Matrix客户端
    // TODO: 恢复上次登录会话
    // TODO: 初始化推送通知

    _initialized = true;
    debugPrint('N42Chat: Initialized successfully');
  }

  /// 获取聊天主Widget
  ///
  /// 返回会话列表页面，可直接嵌入TabView或Navigator
  ///
  /// ```dart
  /// TabBarView(
  ///   children: [
  ///     WalletPage(),
  ///     N42Chat.chatWidget(), // 聊天Tab
  ///     ProfilePage(),
  ///   ],
  /// )
  /// ```
  static Widget chatWidget() {
    _ensureInitialized();
    // TODO: 返回包装了必要Provider的ConversationListPage
    return const _ChatPlaceholder();
  }

  /// 获取路由配置
  ///
  /// 返回聊天相关的所有路由，可合并到主应用路由中
  ///
  /// ```dart
  /// GoRouter(
  ///   routes: [
  ///     ...appRoutes,
  ///     ...N42Chat.routes(),
  ///   ],
  /// )
  /// ```
  static List<RouteBase> routes() {
    _ensureInitialized();
    // TODO: 返回聊天相关路由
    return [];
  }

  /// 使用用户名密码登录
  ///
  /// [homeserver] Matrix服务器地址
  /// [username] 用户名
  /// [password] 密码
  ///
  /// 抛出 [N42ChatException] 当登录失败时
  static Future<void> login({
    required String homeserver,
    required String username,
    required String password,
  }) async {
    _ensureInitialized();
    // TODO: 实现Matrix登录
    debugPrint('N42Chat: Login - $username@$homeserver');
  }

  /// 使用已有Token登录
  ///
  /// 用于恢复会话或从主应用传递认证信息
  ///
  /// [homeserver] Matrix服务器地址
  /// [accessToken] 访问令牌
  /// [userId] 用户ID (格式: @user:server.com)
  /// [deviceId] 设备ID
  static Future<void> loginWithToken({
    required String homeserver,
    required String accessToken,
    required String userId,
    required String deviceId,
  }) async {
    _ensureInitialized();
    // TODO: 实现Token登录
    debugPrint('N42Chat: Login with token - $userId');
  }

  /// 登出当前用户
  ///
  /// 清除本地会话数据和缓存
  static Future<void> logout() async {
    _ensureInitialized();
    // TODO: 实现登出
    debugPrint('N42Chat: Logout');
  }

  /// 是否已登录
  static bool get isLoggedIn {
    if (!_initialized) return false;
    // TODO: 检查Matrix客户端登录状态
    return false;
  }

  /// 当前登录用户
  static UserEntity? get currentUser {
    if (!_initialized || !isLoggedIn) return null;
    // TODO: 返回当前用户信息
    return null;
  }

  /// 未读消息数量流
  ///
  /// 订阅此流以更新Tab徽章
  ///
  /// ```dart
  /// N42Chat.unreadCountStream.listen((count) {
  ///   setState(() => _unreadCount = count);
  /// });
  /// ```
  static Stream<int> get unreadCountStream {
    _ensureInitialized();
    // TODO: 返回Matrix客户端的未读消息流
    return const Stream<int>.empty();
  }

  /// 打开指定会话
  ///
  /// [roomId] Matrix房间ID
  /// [context] 可选的BuildContext，用于导航
  static void openConversation(String roomId, {BuildContext? context}) {
    _ensureInitialized();
    // TODO: 导航到会话页面
    debugPrint('N42Chat: Open conversation - $roomId');
  }

  /// 创建私聊会话
  ///
  /// [userId] 对方的Matrix用户ID
  /// 返回创建的房间ID
  static Future<String> createDirectMessage(String userId) async {
    _ensureInitialized();
    // TODO: 创建或获取DM房间
    debugPrint('N42Chat: Create DM with - $userId');
    return '';
  }

  /// 创建群聊
  ///
  /// [name] 群名称
  /// [inviteUserIds] 邀请的用户ID列表
  /// 返回创建的房间ID
  static Future<String> createGroup({
    required String name,
    List<String> inviteUserIds = const [],
  }) async {
    _ensureInitialized();
    // TODO: 创建群聊房间
    debugPrint('N42Chat: Create group - $name');
    return '';
  }

  /// 释放资源
  ///
  /// 在应用退出前调用
  static Future<void> dispose() async {
    if (!_initialized) return;

    // TODO: 停止同步
    // TODO: 关闭数据库连接
    // TODO: 清理资源

    _initialized = false;
    _config = null;
    debugPrint('N42Chat: Disposed');
  }

  /// 确保已初始化
  static void _ensureInitialized() {
    if (!_initialized) {
      throw StateError(
        'N42Chat has not been initialized. '
        'Call N42Chat.initialize() first.',
      );
    }
  }
}

/// 聊天占位Widget (开发中)
class _ChatPlaceholder extends StatelessWidget {
  const _ChatPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息'),
        backgroundColor: const Color(0xFFF7F7F7),
        foregroundColor: const Color(0xFF181818),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFEDEDED),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Color(0xFF888888),
            ),
            SizedBox(height: 16),
            Text(
              'N42 Chat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF181818),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '聊天模块开发中...',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF888888),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// N42 Chat 异常
class N42ChatException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const N42ChatException(
    this.message, {
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'N42ChatException: $message (code: $code)';
}

