import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:url_launcher/url_launcher.dart';

import 'core/extensions/context_extension.dart';
import 'core/notifications/firebase_push_service.dart';
import 'data/datasources/matrix/matrix_client_manager.dart';
import 'data/datasources/matrix/matrix_moment_datasource.dart';
import 'services/voip/call_manager.dart';
import 'n42_chat_config.dart';
import 'core/di/injection.dart';
import 'core/utils/date_utils.dart';
import 'domain/entities/conversation_entity.dart';
import 'domain/entities/user_entity.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/conversation_repository.dart';
import 'core/services/chat_lock_service.dart';
import 'presentation/blocs/chat/chat_bloc.dart';
import 'presentation/blocs/contact/contact_bloc.dart';
import 'presentation/pages/chat/chat_lock_page.dart';
import 'presentation/pages/chat/chat_page.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/auth/auth_event.dart';
import 'presentation/blocs/auth/auth_state.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/auth/register_page.dart';
import 'presentation/pages/auth/welcome_page.dart';
import 'presentation/pages/main/chat_main_page.dart';
import 'presentation/pages/profile/profile_page.dart';

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
  static ThemeMode _themeMode = ThemeMode.system;
  static Locale _locale = const Locale('en');
  static final List<void Function(ThemeMode)> _themeListeners = [];
  static final List<void Function(Locale)> _localeListeners = [];

  /// 全局 AuthBloc 实例（单例）
  static AuthBloc? _authBloc;

  /// 推送通知服务
  static FirebasePushService? _pushService;
  static Completer<void>? _pushInitCompleter;

  /// 通话管理器
  static CallManager? _callManager;

  /// 导航键（用于通话页面导航）
  static GlobalKey<NavigatorState>? _navigatorKey;

  /// 通知点击回调
  static void Function(String? roomId, String? eventId)? _onNotificationTap;

  /// 用户变化流控制器
  static final StreamController<UserEntity?> _userStreamController =
      StreamController<UserEntity?>.broadcast();

  /// 用户变化流
  ///
  /// 当用户登录、登出、更新头像/昵称时会发送通知
  ///
  /// ```dart
  /// N42Chat.userStream.listen((user) {
  ///   // 更新 UI 显示最新的用户信息
  ///   setState(() => _chatUser = user);
  /// });
  /// ```
  static Stream<UserEntity?> get userStream => _userStreamController.stream;

  /// 通知用户信息变化
  static void notifyUserChanged() {
    final user = currentUser;
    _userStreamController.add(user);
    debugPrint('N42Chat: User changed notification - ${user?.displayName}');
  }

  /// 获取当前配置
  static N42ChatConfig? get config => _config;

  /// 是否已初始化
  static bool get isInitialized => _initialized;

  /// 获取通话管理器
  static CallManager? get callManager => _callManager;

  /// 设置导航键（用于通话页面导航）
  static void setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
    // 同步更新 CallManager 的导航键
    _callManager?.setNavigatorKey(key);
  }

  /// 获取当前主题模式
  static ThemeMode get themeMode => _themeMode;

  /// 设置主题模式
  /// 
  /// 用于与主应用同步主题设置
  /// 
  /// [mode] Flutter 的 ThemeMode (system/light/dark)
  /// 
  /// ```dart
  /// // 在主应用中同步主题
  /// ref.listen(themeModeProvider, (previous, next) {
  ///   N42Chat.setThemeMode(next);
  /// });
  /// ```
  static void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      // 通知所有监听器
      for (final listener in _themeListeners) {
        listener(mode);
      }
      debugPrint('N42Chat: Theme mode changed to $mode');
    }
  }

  /// 添加主题变化监听器
  static void addThemeListener(void Function(ThemeMode) listener) {
    _themeListeners.add(listener);
  }

  /// 移除主题变化监听器
  static void removeThemeListener(void Function(ThemeMode) listener) {
    _themeListeners.remove(listener);
  }

  /// 获取当前语言设置
  static Locale get locale => _locale;

  /// 设置语言
  ///
  /// 用于与主应用同步语言设置
  ///
  /// [locale] Flutter 的 Locale
  ///
  /// ```dart
  /// // 在主应用中同步语言
  /// ref.listen(localeProvider, (previous, next) {
  ///   N42Chat.setLocale(next);
  /// });
  /// ```
  static void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      // 更新日期工具类的本地化
      N42DateUtils.setLocale(DateLocaleStrings.fromLocaleCode(locale.languageCode));
      // 通知所有监听器
      for (final listener in _localeListeners) {
        listener(locale);
      }
      debugPrint('N42Chat: Locale changed to $locale');
    }
  }

  /// 添加语言变化监听器
  static void addLocaleListener(void Function(Locale) listener) {
    _localeListeners.add(listener);
  }

  /// 移除语言变化监听器
  static void removeLocaleListener(void Function(Locale) listener) {
    _localeListeners.remove(listener);
  }

  /// 判断当前是否为深色模式
  /// 
  /// 需要传入 BuildContext 来判断系统主题
  static bool isDarkMode(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.dark:
        return true;
      case ThemeMode.light:
        return false;
      case ThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }

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

    // 如果之前初始化中途失败，GetIt 可能已有部分注册，需要先重置
    if (getIt.isRegistered<N42ChatConfig>()) {
      debugPrint('N42Chat: Resetting previous partial initialization');
      await resetDependencies();
    }

    // 初始化依赖注入
    await configureDependencies(config);

    // 创建全局 AuthBloc 并尝试恢复会话
    _authBloc = getIt<AuthBloc>();
    _authBloc!.add(const AuthRestoreSessionRequested());

    // 初始化推送通知服务（如果启用）
    if (config.enablePushNotifications) {
      await _initializePushService(config);
    }

    // 如果 Matrix 客户端已登录，立即初始化通话管理器
    try {
      final clientManager = getIt<MatrixClientManager>();
      if (clientManager.client?.isLogged() == true) {
        debugPrint('N42Chat: Matrix client is logged in, initializing call manager');
        await initializeCallManager();
      }
    } catch (e) {
      debugPrint('N42Chat: Failed to check login status for call manager: $e');
    }

    // 设置 Moment 房间邀请自动加入监听
    _setupMomentInviteListener();

    _initialized = true;
    debugPrint('N42Chat: Initialized successfully');
  }

  /// Moment 房间邀请 sync 监听的订阅
  static StreamSubscription<matrix.SyncUpdate>? _momentSyncSubscription;

  /// 设置 Moment 房间邀请的 sync 监听
  ///
  /// 在每次同步时检查是否有 Moment 房间邀请，自动接受
  static void _setupMomentInviteListener() {
    try {
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;
      if (client == null) {
        debugPrint('N42Chat: Client null, skipping moment invite listener setup');
        return;
      }

      // 取消之前的监听
      _momentSyncSubscription?.cancel();

      _momentSyncSubscription = client.onSync.stream.listen((_) async {
        try {
          final momentDataSource = getIt<MatrixMomentDataSource>();
          await momentDataSource.processMomentInvites();
        } catch (e) {
          // 静默处理，避免影响正常同步
          debugPrint('N42Chat: Moment invite processing error: $e');
        }
      });

      debugPrint('N42Chat: Moment invite listener set up');
    } catch (e) {
      debugPrint('N42Chat: Failed to setup moment invite listener: $e');
    }
  }

  /// 初始化推送服务
  ///
  /// 使用 Completer 防止并发初始化（auth 恢复可能与初始化并行执行）
  static Future<void> _initializePushService(N42ChatConfig config) async {
    // 防止并发初始化：如果正在初始化中，等待完成
    if (_pushInitCompleter != null && !_pushInitCompleter!.isCompleted) {
      debugPrint('N42Chat: Push service initialization already in progress, waiting...');
      await _pushInitCompleter!.future;
      // 如果等待后已初始化成功，直接返回
      if (_pushService != null) return;
      // 否则继续尝试初始化
    }

    // 已初始化则跳过
    if (_pushService != null) return;

    _pushInitCompleter = Completer<void>();

    try {
      // 获取 Matrix 客户端管理器
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;

      if (client == null) {
        debugPrint('N42Chat: Matrix client not initialized, push service will be initialized on login');
        return;
      }

      debugPrint('N42Chat: Creating push service with gateway: ${config.pushGatewayUrl}, appId: ${config.pushAppId}');

      // 创建推送服务
      _pushService = FirebasePushService(
        client,
        pushGatewayUrl: config.pushGatewayUrl,
        appId: config.pushAppId,
        onNotificationTap: (roomId, eventId) {
          debugPrint('N42Chat: Notification tapped - roomId: $roomId, eventId: $eventId');
          _onNotificationTap?.call(roomId, eventId);
          // 如果有 roomId，导航到对应聊天
          if (roomId != null) {
            openConversation(roomId);
          }
        },
      );

      // 初始化（包括获取 FCM Token）
      await _pushService!.initialize();

      // 如果已登录，立即注册推送
      if (client.isLogged()) {
        await _pushService!.registerForPush();
      }

      debugPrint('N42Chat: Push service initialized successfully');
    } catch (e) {
      debugPrint('N42Chat: Failed to initialize push service: $e');
      // 初始化失败，清除 pushService 以允许后续重试
      _pushService = null;
    } finally {
      if (_pushInitCompleter != null && !_pushInitCompleter!.isCompleted) {
        _pushInitCompleter!.complete();
      }
    }
  }

  /// 设置通知点击回调
  ///
  /// 当用户点击推送通知时触发
  ///
  /// ```dart
  /// N42Chat.setNotificationTapHandler((roomId, eventId) {
  ///   // 导航到聊天页面
  ///   Navigator.push(context, ...);
  /// });
  /// ```
  static void setNotificationTapHandler(
    void Function(String? roomId, String? eventId) handler,
  ) {
    _onNotificationTap = handler;
  }

  /// 获取推送服务
  static FirebasePushService? get pushService => _pushService;

  /// 注册推送通知
  ///
  /// 登录成功后调用此方法注册推送。
  /// 如果推送服务正在初始化中（竞态），会等待初始化完成后再注册。
  static Future<void> registerPushNotifications() async {
    debugPrint('N42Chat: registerPushNotifications called');

    // 等待正在进行的初始化完成
    if (_pushInitCompleter != null && !_pushInitCompleter!.isCompleted) {
      debugPrint('N42Chat: Waiting for push service initialization to complete...');
      await _pushInitCompleter!.future;
    }

    // 如果推送服务未初始化，尝试初始化（可能之前因 client 为 null 跳过）
    if (_pushService == null && _config != null && _config!.enablePushNotifications) {
      debugPrint('N42Chat: Push service is null, attempting initialization...');
      await _initializePushService(_config!);
    }

    if (_pushService != null) {
      debugPrint('N42Chat: Calling registerForPush...');
      await _pushService!.registerForPush();
      debugPrint('N42Chat: registerForPush completed');
    } else {
      debugPrint('N42Chat: Cannot register push - push service is null '
          '(config: ${_config != null}, enablePush: ${_config?.enablePushNotifications})');
    }
  }

  /// 取消注册推送通知
  ///
  /// 登出时调用
  static Future<void> unregisterPushNotifications() async {
    if (_pushService != null) {
      await _pushService!.unregisterPush();
    }
  }

  /// 初始化通话管理器
  ///
  /// 登录成功后调用此方法初始化 VoIP 服务
  static Future<void> initializeCallManager() async {
    try {
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;

      if (client == null) {
        debugPrint('N42Chat: Matrix client not initialized, call manager will be initialized later');
        return;
      }

      _callManager = CallManager();
      await _callManager!.initialize(
        client: client,
        navigatorKey: _navigatorKey,
      );

      // 配置 TURN 服务器（从 Matrix 服务器获取）
      try {
        final turnServers = await client.getTurnServer();
        debugPrint('N42Chat: TURN servers response: ${turnServers.uris}');
        if (turnServers.uris.isNotEmpty) {
          _callManager!.configureTurn(
            uris: turnServers.uris,
            username: turnServers.username,
            password: turnServers.password,
            ttl: turnServers.ttl,
          );
          debugPrint('N42Chat: TURN servers configured');
        } else {
          debugPrint('N42Chat: No TURN servers available');
        }
      } catch (e) {
        debugPrint('N42Chat: Failed to get TURN servers: $e');
      }

      // 从 well-known 获取 LiveKit 配置
      await _discoverLiveKitConfig(client);

      debugPrint('N42Chat: Call manager initialized');
    } catch (e) {
      debugPrint('N42Chat: Failed to initialize call manager: $e');
    }
  }

  /// 从 well-known 发现 LiveKit 配置
  static Future<void> _discoverLiveKitConfig(matrix.Client client) async {
    try {
      final homeserver = client.homeserver;
      if (homeserver == null) return;

      // 获取 well-known 配置
      final wellKnownUrl = Uri.parse('${homeserver.origin}/.well-known/matrix/client');
      debugPrint('N42Chat: Fetching well-known from $wellKnownUrl');

      final response = await client.httpClient.get(wellKnownUrl);
      if (response.statusCode != 200) {
        debugPrint('N42Chat: Well-known request failed: ${response.statusCode}');
        return;
      }

      final wellKnown = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('N42Chat: Well-known response: $wellKnown');

      // 检查 rtc_foci (Matrix VoIP focus 配置)
      // 格式参考: https://spec.matrix.org/latest/client-server-api/#mhomesserver
      final rtcFoci = wellKnown['org.matrix.msc4143.rtc_foci'] as List<dynamic>?;
      if (rtcFoci != null && rtcFoci.isNotEmpty) {
        for (final focus in rtcFoci) {
          if (focus is Map<String, dynamic>) {
            final type = focus['type'] as String?;
            if (type == 'livekit') {
              // livekit_service_url 是 JWT 服务 URL，用于获取访问令牌
              final jwtServiceUrl = focus['livekit_service_url'] as String?;
              final liveKitAlias = focus['livekit_alias'] as String?;
              debugPrint('N42Chat: Found LiveKit JWT service: $jwtServiceUrl, alias=$liveKitAlias');

              if (jwtServiceUrl != null) {
                // 保存 JWT URL
                _liveKitJwtUrl = jwtServiceUrl;

                // 从 JWT URL 推导 WebSocket URL
                // https://m.si46.world/livekit/jwt -> wss://m.si46.world/livekit/sfu
                final uri = Uri.parse(jwtServiceUrl);
                final wsUrl = 'wss://${uri.host}/livekit/sfu';

                if (_callManager != null) {
                  _callManager!.configureLiveKit(url: wsUrl);
                  debugPrint('N42Chat: LiveKit WebSocket configured: $wsUrl');
                }
                break;
              }
            }
          }
        }
      }

      // 备选：检查自定义 LiveKit 配置字段
      final liveKitConfig = wellKnown['n42.livekit'] as Map<String, dynamic>?;
      if (liveKitConfig != null && _callManager != null) {
        final wsUrl = liveKitConfig['ws_url'] as String?;
        final jwtUrl = liveKitConfig['jwt_url'] as String?;
        if (wsUrl != null) {
          _callManager!.configureLiveKit(url: wsUrl);
          debugPrint('N42Chat: LiveKit configured from n42.livekit: $wsUrl');
        }
        // 保存 JWT URL 供后续使用
        if (jwtUrl != null) {
          _liveKitJwtUrl = jwtUrl;
          debugPrint('N42Chat: LiveKit JWT URL: $jwtUrl');
        }
      }
    } catch (e) {
      debugPrint('N42Chat: Failed to discover LiveKit config: $e');
    }
  }

  /// LiveKit JWT URL (用于获取访问令牌)
  static String? _liveKitJwtUrl;
  static String? get liveKitJwtUrl => _liveKitJwtUrl;

  /// 释放通话管理器
  static Future<void> disposeCallManager() async {
    await _callManager?.dispose();
    _callManager = null;
  }

  /// 清除所有通知
  static Future<void> clearAllNotifications() async {
    if (_pushService != null) {
      await _pushService!.clearAllNotifications();
    }
  }

  /// 清除指定房间的通知
  static Future<void> clearNotificationsForRoom(String roomId) async {
    if (_pushService != null) {
      await _pushService!.clearNotificationsForRoom(roomId);
    }
  }
  
  /// 获取全局 AuthBloc
  static AuthBloc get authBloc {
    _ensureInitialized();
    return _authBloc!;
  }

  /// 获取聊天主Widget
  ///
  /// 返回会话列表页面，可直接嵌入TabView或Navigator
  /// 
  /// 根据登录状态自动显示：
  /// - 已登录：显示会话列表页面
  /// - 未登录：显示欢迎页面，可登录/注册
  /// - 未初始化：显示初始化错误页面，提供重试选项
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
    // 如果未初始化，显示错误页面而不是抛出异常
    if (!_initialized) {
      return const _NotInitializedPage();
    }
    return const _N42ChatEntryWidget();
  }

  /// 获取个人资料页面 Widget
  ///
  /// 返回可嵌入主应用的个人资料页面
  /// 如果用户未登录，会自动显示登录页面
  ///
  /// [showAppBar] 是否显示 AppBar，嵌入主框架时可设为 false
  ///
  /// ```dart
  /// // 导航到个人资料页
  /// Navigator.push(
  ///   context,
  ///   MaterialPageRoute(builder: (_) => N42Chat.profileWidget()),
  /// );
  /// ```
  static Widget profileWidget({bool showAppBar = true}) {
    // 如果未初始化，显示错误页面
    if (!_initialized) {
      return const _NotInitializedPage();
    }
    return _N42ProfileEntryWidget(showAppBar: showAppBar);
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
    try {
      final authRepo = getIt<IAuthRepository>();
      return authRepo.isLoggedIn;
    } catch (e) {
      return false;
    }
  }

  /// 当前登录用户
  static UserEntity? get currentUser {
    if (!_initialized) return null;
    try {
      final authRepo = getIt<IAuthRepository>();
      return authRepo.currentUser;
    } catch (e) {
      return null;
    }
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
  static Future<void> openConversation(String roomId, {BuildContext? context}) async {
    _ensureInitialized();
    debugPrint('N42Chat: Open conversation - $roomId');

    final ctx = context ?? _navigatorKey?.currentContext;
    if (ctx == null) {
      debugPrint('N42Chat: No context available for navigation');
      return;
    }

    try {
      final repo = getIt<IConversationRepository>();
      ConversationEntity? conversation = await repo.getConversationById(roomId);

      // If not found locally, try joining the room first
      if (conversation == null) {
        try {
          await repo.joinConversation(roomId);
          conversation = await repo.getConversationById(roomId);
        } catch (e) {
          debugPrint('N42Chat: Failed to join room $roomId: $e');
        }
      }

      if (conversation == null) {
        debugPrint('N42Chat: Conversation not found: $roomId');
        return;
      }

      if (!ctx.mounted) return;

      // Check if chat is locked
      final lockService = ChatLockService();
      final isLocked = await lockService.isChatLocked(roomId);

      if (isLocked && ctx.mounted) {
        final verified = await Navigator.of(ctx).push<bool>(
          MaterialPageRoute<bool>(
            builder: (_) => ChatLockPage(
              roomId: roomId,
              chatName: conversation!.name,
            ),
          ),
        );
        if (verified != true) return;
      }

      if (!ctx.mounted) return;

      unawaited(Navigator.of(ctx).push(
        MaterialPageRoute<void>(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<ChatBloc>()),
              BlocProvider(create: (_) => getIt<ContactBloc>()),
            ],
            child: ChatPage(
              conversation: conversation!,
              onBack: () => Navigator.of(ctx).pop(),
            ),
          ),
        ),
      ));
    } catch (e) {
      debugPrint('N42Chat: Failed to open conversation $roomId: $e');
    }
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

/// N42 Chat 入口Widget
/// 
/// 根据登录状态自动切换页面：
/// - 检查中：显示加载页
/// - 已登录：显示会话列表
/// - 未登录：显示欢迎页面
class _N42ChatEntryWidget extends StatefulWidget {
  const _N42ChatEntryWidget();

  @override
  State<_N42ChatEntryWidget> createState() => _N42ChatEntryWidgetState();
}

class _N42ChatEntryWidgetState extends State<_N42ChatEntryWidget> {
  @override
  void initState() {
    super.initState();
    // 检查当前登录状态
    N42Chat.authBloc.add(const AuthCheckRequested());
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: N42Chat.authBloc,
          child: const LoginPage(),
        ),
      ),
    );
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: N42Chat.authBloc,
          child: const RegisterPage(),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: N42Chat.authBloc,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // 检查中或初始状态 - 显示加载
          if (state.status == AuthStatus.initial || 
              state.status == AuthStatus.checking) {
            return const _LoadingPage();
          }

          // 已登录 - 显示主框架（微信风格底部Tab）
          if (state.isAuthenticated) {
            return ChatMainPage(
              onBackToMain: () {
                // 返回主应用 - 由外部处理
                Navigator.of(context).maybePop();
              },
            );
          }

          // 未登录 - 显示欢迎页面
          return WelcomePage(
            onLogin: () => _navigateToLogin(context),
            onRegister: () => _navigateToRegister(context),
            onTermsOfService: () => _launchUrl(N42Chat._config?.termsOfServiceUrl ?? 'https://n42.world/terms'),
            onPrivacyPolicy: () => _launchUrl(N42Chat._config?.privacyPolicyUrl ?? 'https://n42.world/privacy'),
          );
        },
      ),
    );
  }
}

/// 加载页面
class _LoadingPage extends StatelessWidget {
  const _LoadingPage();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEDEDED),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF07C160),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.chat_bubble_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'N42 Chat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : const Color(0xFF181818),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF07C160)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 未初始化错误页面
class _NotInitializedPage extends StatefulWidget {
  const _NotInitializedPage();

  @override
  State<_NotInitializedPage> createState() => _NotInitializedPageState();
}

class _NotInitializedPageState extends State<_NotInitializedPage> {
  bool _isRetrying = false;

  Future<void> _retry() async {
    if (_isRetrying) return;
    
    setState(() {
      _isRetrying = true;
    });

    try {
      // 尝试重新初始化
      await N42Chat.initialize(N42Chat.config ?? const N42ChatConfig());
      // 如果成功，触发重建
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('N42Chat retry initialization failed: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isRetrying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 如果已初始化，返回正常的入口Widget
    if (N42Chat.isInitialized) {
      return const _N42ChatEntryWidget();
    }

    final isDark = context.isDarkMode;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEDEDED);
    final textColor = isDark ? Colors.white : const Color(0xFF181818);
    final subtitleColor = isDark ? Colors.white70 : const Color(0xFF888888);
    
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Colors.orange,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'N42 Chat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Chat initialization failed',
                style: TextStyle(
                  fontSize: 16,
                  color: subtitleColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Please check your network and try again',
                style: TextStyle(
                  fontSize: 14,
                  color: subtitleColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 160,
                height: 44,
                child: ElevatedButton(
                  onPressed: _isRetrying ? null : _retry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF07C160),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: _isRetrying
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Retry',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// N42 个人资料入口 Widget
///
/// 根据登录状态自动切换页面：
/// - 已登录：显示个人资料页
/// - 未登录：显示欢迎页面（引导登录）
class _N42ProfileEntryWidget extends StatefulWidget {
  final bool showAppBar;

  const _N42ProfileEntryWidget({this.showAppBar = true});

  @override
  State<_N42ProfileEntryWidget> createState() => _N42ProfileEntryWidgetState();
}

class _N42ProfileEntryWidgetState extends State<_N42ProfileEntryWidget> {
  @override
  void initState() {
    super.initState();
    // 检查当前登录状态
    N42Chat.authBloc.add(const AuthCheckRequested());
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: N42Chat.authBloc,
          child: const LoginPage(),
        ),
      ),
    );
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: N42Chat.authBloc,
          child: const RegisterPage(),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: N42Chat.authBloc,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // 检查中或初始状态 - 显示加载
          if (state.status == AuthStatus.initial ||
              state.status == AuthStatus.checking) {
            return const _LoadingPage();
          }

          // 已登录 - 显示个人资料页
          if (state.isAuthenticated) {
            return ProfilePage(showAppBar: widget.showAppBar);
          }

          // 未登录 - 显示欢迎页面
          return WelcomePage(
            onLogin: () => _navigateToLogin(context),
            onRegister: () => _navigateToRegister(context),
            onTermsOfService: () => _launchUrl(
                N42Chat._config?.termsOfServiceUrl ?? 'https://n42.world/terms'),
            onPrivacyPolicy: () => _launchUrl(
                N42Chat._config?.privacyPolicyUrl ?? 'https://n42.world/privacy'),
          );
        },
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

