import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'n42_chat_config.dart';
import 'core/di/injection.dart';
import 'domain/entities/user_entity.dart';
import 'domain/repositories/auth_repository.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/auth/auth_event.dart';
import 'presentation/blocs/auth/auth_state.dart';
import 'presentation/blocs/conversation/conversation_bloc.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/auth/register_page.dart';
import 'presentation/pages/auth/welcome_page.dart';
import 'presentation/pages/conversation/conversation_list_page.dart';

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
  static final List<void Function(ThemeMode)> _themeListeners = [];
  
  /// 全局 AuthBloc 实例（单例）
  static AuthBloc? _authBloc;

  /// 获取当前配置
  static N42ChatConfig? get config => _config;

  /// 是否已初始化
  static bool get isInitialized => _initialized;

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

    // 初始化依赖注入
    await configureDependencies(config);

    // 创建全局 AuthBloc 并尝试恢复会话
    _authBloc = getIt<AuthBloc>();
    _authBloc!.add(const AuthRestoreSessionRequested());

    // 初始化推送通知（如果启用）
    if (config.enablePushNotifications) {
      debugPrint('N42Chat: Push notifications enabled');
      // TODO: 注册推送通知
    }

    _initialized = true;
    debugPrint('N42Chat: Initialized successfully');
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
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: N42Chat.authBloc,
          child: const LoginPage(),
        ),
      ),
    );
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: N42Chat.authBloc,
          child: const RegisterPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: N42Chat.authBloc),
        BlocProvider<ConversationBloc>(
          create: (_) => getIt<ConversationBloc>(),
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // 检查中或初始状态 - 显示加载
          if (state.status == AuthStatus.initial || 
              state.status == AuthStatus.checking) {
            return const _LoadingPage();
          }

          // 已登录 - 显示会话列表
          if (state.isAuthenticated) {
            return ConversationListPage(
              onConversationTap: (conversation) {
                // TODO: 导航到聊天页面
                debugPrint('N42Chat: Open conversation ${conversation.id}');
              },
              onSearchTap: () {
                // TODO: 导航到搜索页面
                debugPrint('N42Chat: Open search');
              },
            );
          }

          // 未登录 - 显示欢迎页面
          return WelcomePage(
            onLogin: () => _navigateToLogin(context),
            onRegister: () => _navigateToRegister(context),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
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

    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                  color: Colors.orange.withOpacity(0.15),
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
                '聊天模块初始化失败',
                style: TextStyle(
                  fontSize: 16,
                  color: subtitleColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '请检查网络连接后重试',
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
                          '重试',
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

