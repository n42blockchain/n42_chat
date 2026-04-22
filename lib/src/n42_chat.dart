import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import 'core/extensions/context_extension.dart';
import 'core/notifications/firebase_push_service.dart';
import 'core/notifications/push_notification_service.dart';
import 'data/datasources/local/preferences_datasource.dart';
import 'data/datasources/local/secure_storage_datasource.dart';
import 'data/datasources/matrix/matrix_client_manager.dart';
import 'data/datasources/matrix/matrix_moment_datasource.dart';
import 'services/auth/auth_methods_service.dart';
import 'services/voip/call_manager.dart';
import 'n42_chat_config.dart';
import 'core/di/injection.dart';
import 'core/utils/date_utils.dart';
import 'domain/entities/conversation_entity.dart';
import 'domain/entities/user_entity.dart';
import 'domain/entities/user_profile_entity.dart';
import 'core/router/app_router.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/conversation_repository.dart';
import 'domain/repositories/group_repository.dart';
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
import 'presentation/pages/profile/user_profile_page.dart';
import 'presentation/pages/settings/change_email_page.dart' as chat_settings;
import 'core/utils/debug_log.dart';

part 'presentation/widgets/n42_chat_widgets.dart';
part 'core/services/n42_theme_manager.dart';
part 'core/services/n42_push_manager.dart';
part 'core/services/n42_call_facade.dart';

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
///   defaultHomeserver: 'https://m.si46.world',
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
  static Completer<void>? _initCompleter;
  static String? _pendingNotificationRoomId;
  static String? _pendingNotificationEventId;
  static String? _lastHandledNotificationKey;
  static DateTime? _lastHandledNotificationAt;

  /// 全局 AuthBloc 实例（单例）
  static AuthBloc? _authBloc;

  /// 导航键（用于通话页面导航）
  static GlobalKey<NavigatorState>? _navigatorKey;

  /// 通知点击回调
  static void Function(String? roomId, String? eventId)? _onNotificationTap;

  /// 宿主打开钱包 / 卡包的回调（chat 内 ServicesPage 触发）。
  /// 宿主未注册时 ServicesPage 会降级为信息提示。
  static VoidCallback? _onOpenWallet;
  static VoidCallback? _onOpenCardPack;

  /// Moment 邀请节流时间戳（10 秒内不重复处理）
  static DateTime? _lastMomentInviteCheck;

  /// 用户变化流控制器
  static StreamController<UserEntity?> _userStreamController =
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
    debugLog('N42Chat: User changed notification - ${user?.displayName}');
  }

  /// 获取当前配置
  static N42ChatConfig? get config => _config;

  /// 是否已初始化
  static bool get isInitialized => _initialized;

  // ---------------------------------------------------------------------------
  // Theme / Font / Locale — delegated to _N42ThemeManager
  // ---------------------------------------------------------------------------

  /// 获取当前主题模式
  static ThemeMode get themeMode => _N42ThemeManager.themeMode;

  /// 获取当前字体大小偏好
  static FontSize get fontSize => _N42ThemeManager.fontSize;

  /// 获取当前语言设置
  static Locale get locale => _N42ThemeManager.locale;

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
  static void setThemeMode(ThemeMode mode) => _N42ThemeManager.setThemeMode(mode);

  /// 添加主题变化监听器
  static void addThemeListener(void Function(ThemeMode) listener) =>
      _N42ThemeManager.addThemeListener(listener);

  /// 移除主题变化监听器
  static void removeThemeListener(void Function(ThemeMode) listener) =>
      _N42ThemeManager.removeThemeListener(listener);

  /// 设置字体大小
  static void setFontSize(FontSize fontSize) =>
      _N42ThemeManager.setFontSize(fontSize);

  /// 添加字体大小变化监听器
  static void addFontSizeListener(void Function(FontSize) listener) =>
      _N42ThemeManager.addFontSizeListener(listener);

  /// 移除字体大小变化监听器
  static void removeFontSizeListener(void Function(FontSize) listener) =>
      _N42ThemeManager.removeFontSizeListener(listener);

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
  static void setLocale(Locale locale) => _N42ThemeManager.setLocale(locale);

  /// 添加语言变化监听器
  static void addLocaleListener(void Function(Locale) listener) =>
      _N42ThemeManager.addLocaleListener(listener);

  /// 移除语言变化监听器
  static void removeLocaleListener(void Function(Locale) listener) =>
      _N42ThemeManager.removeLocaleListener(listener);

  /// 判断当前是否为深色模式
  ///
  /// 需要传入 BuildContext 来判断系统主题
  static bool isDarkMode(BuildContext context) =>
      _N42ThemeManager.isDarkMode(context);

  // ---------------------------------------------------------------------------
  // Call Manager — delegated to _N42CallFacade
  // ---------------------------------------------------------------------------

  /// 获取通话管理器
  static CallManager? get callManager => _N42CallFacade.callManager;

  /// LiveKit JWT URL
  static String? get liveKitJwtUrl => _N42CallFacade.liveKitJwtUrl;

  /// 初始化通话管理器
  ///
  /// 登录成功后调用此方法初始化 VoIP 服务
  static Future<void> initializeCallManager() =>
      _N42CallFacade.initializeCallManager();

  /// 释放通话管理器
  static Future<void> disposeCallManager() =>
      _N42CallFacade.disposeCallManager();

  // ---------------------------------------------------------------------------
  // Push Notifications — delegated to _N42PushManager
  // ---------------------------------------------------------------------------

  /// 获取推送服务
  static FirebasePushService? get pushService => _N42PushManager.pushService;

  /// 注册推送通知
  ///
  /// 登录成功后调用此方法注册推送。
  /// 如果推送服务正在初始化中（竞态），会等待初始化完成后再注册。
  static Future<void> registerPushNotifications() =>
      _N42PushManager.registerPushNotifications();

  /// 取消注册推送通知
  ///
  /// 登出时调用
  static Future<void> unregisterPushNotifications() =>
      _N42PushManager.unregisterPushNotifications();

  /// 清除所有通知
  static Future<void> clearAllNotifications() =>
      _N42PushManager.clearAllNotifications();

  /// 清除指定房间的通知
  static Future<void> clearNotificationsForRoom(String roomId) =>
      _N42PushManager.clearNotificationsForRoom(roomId);

  /// 获取推送诊断信息
  ///
  /// 返回推送服务的详细状态，用于调试推送问题。
  /// 搜索日志中 `[PUSH_REG_OK]` 和 `[PUSH_VERIFY_OK]` 确认注册成功。
  static Map<String, dynamic> getPushDiagnostics() =>
      _N42PushManager.getPushDiagnostics();

  /// 强制重新注册推送
  ///
  /// 当推送不工作时调用此方法尝试修复。
  /// 会清除之前的注册状态并重新执行整个注册流程。
  static Future<void> forceReRegisterPush() =>
      _N42PushManager.forceReRegisterPush();

  // ---------------------------------------------------------------------------
  // Navigator & Notification Tap
  // ---------------------------------------------------------------------------

  /// 设置导航键（用于通话页面导航）
  static void setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
    // 同步更新 CallManager 的导航键
    _N42CallFacade._callManager?.setNavigatorKey(key);
    _flushPendingNotificationTap();
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
    _flushPendingNotificationTap();
  }

  /// 注册宿主侧"打开钱包"回调。
  /// 由 chat 内的 ServicesPage 在用户点击 Wallet 时调用；
  /// 宿主应在此切换到钱包 Tab 或 push 钱包页面。
  static void setOpenWalletHandler(VoidCallback? handler) {
    _onOpenWallet = handler;
  }

  /// 注册宿主侧"打开卡包"回调。
  static void setOpenCardPackHandler(VoidCallback? handler) {
    _onOpenCardPack = handler;
  }

  /// 内部使用：ServicesPage 触发 Wallet，若未注册返回 false。
  static bool invokeOpenWallet() {
    final cb = _onOpenWallet;
    if (cb == null) return false;
    cb();
    return true;
  }

  /// 内部使用：ServicesPage 触发 CardPack，若未注册返回 false。
  static bool invokeOpenCardPack() {
    final cb = _onOpenCardPack;
    if (cb == null) return false;
    cb();
    return true;
  }

  /// 供宿主应用在更早的推送生命周期中转发聊天通知点击。
  ///
  /// 当 Chat 尚未完成初始化或 navigator 尚不可用时，先缓存此次点击，
  /// 待初始化完成后再自动打开对应会话。
  static void handleNotificationTap({String? roomId, String? eventId}) {
    _onNotificationTap?.call(roomId, eventId);
    _routeNotificationTap(roomId: roomId, eventId: eventId);
  }

  static void _routeNotificationTap({String? roomId, String? eventId}) {
    if (roomId == null) return;

    final ctx = _navigatorKey?.currentContext;
    if (!_initialized || ctx == null) {
      _pendingNotificationRoomId = roomId;
      _pendingNotificationEventId = eventId;
      debugLog(
        'N42Chat: Queued notification tap until initialization is ready '
        '(roomId=$roomId, eventId=$eventId)',
      );
      return;
    }

    final key = '$roomId|${eventId ?? ''}';
    final now = DateTime.now();
    if (_lastHandledNotificationKey == key &&
        _lastHandledNotificationAt != null &&
        now.difference(_lastHandledNotificationAt!) <
            const Duration(seconds: 2)) {
      debugLog('N42Chat: Skipping duplicate notification tap for $key');
      return;
    }
    _lastHandledNotificationKey = key;
    _lastHandledNotificationAt = now;

    unawaited(
      openConversation(roomId, targetMessageId: eventId).catchError((Object e) {
        debugLog('N42Chat: Failed to open notification room $roomId: $e');
      }),
    );
  }

  static void _flushPendingNotificationTap() {
    final roomId = _pendingNotificationRoomId;
    if (roomId == null) return;
    final ctx = _navigatorKey?.currentContext;
    if (!_initialized || ctx == null) return;

    final eventId = _pendingNotificationEventId;
    _pendingNotificationRoomId = null;
    _pendingNotificationEventId = null;
    _routeNotificationTap(roomId: roomId, eventId: eventId);
  }

  // ---------------------------------------------------------------------------
  // Preferences helpers
  // ---------------------------------------------------------------------------

  static PreferencesDataSource _preferencesDataSource() {
    if (getIt.isRegistered<PreferencesDataSource>()) {
      return getIt<PreferencesDataSource>();
    }
    return PreferencesDataSource();
  }

  static Future<AppearanceSettings> getSavedAppearanceSettings() async {
    return _preferencesDataSource().getAppearanceSettingsModel();
  }

  static Future<NotificationSettings> getSavedNotificationSettings() async {
    return _preferencesDataSource().getNotificationSettingsModel();
  }

  static Future<void> applyAppearanceSettings(
    AppearanceSettings settings,
  ) async {
    await _preferencesDataSource().saveAppearanceSettingsModel(settings);
    setThemeMode(settings.themeMode);
    setFontSize(settings.fontSize);
  }

  static Future<void> applyNotificationSettings(
    NotificationSettings settings,
  ) async {
    await _preferencesDataSource().saveNotificationSettingsModel(settings);
    _N42PushManager._pushService?.setNotificationConfig(
      _notificationConfigFromSettings(settings),
    );
  }

  static NotificationConfig _notificationConfigFromSettings(
    NotificationSettings settings,
  ) {
    return NotificationConfig(
      enabled: settings.enabled,
      showPreview: settings.showPreview,
      playSound: settings.playSound,
      vibrate: settings.vibrate,
      doNotDisturb: settings.doNotDisturb,
      dndStartTime: _parseStoredTimeOfDay(settings.doNotDisturbStart),
      dndEndTime: _parseStoredTimeOfDay(settings.doNotDisturbEnd),
      privacyMode: settings.privacyMode,
    );
  }

  static TimeOfDay? _parseStoredTimeOfDay(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parts = value.split(':');
    if (parts.length != 2) {
      return null;
    }
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) {
      return null;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  // ---------------------------------------------------------------------------
  // Initialization
  // ---------------------------------------------------------------------------

  /// 初始化聊天模块
  ///
  /// 必须在使用其他API之前调用此方法
  ///
  /// [config] 模块配置
  ///
  /// ```dart
  /// await N42Chat.initialize(N42ChatConfig(
  ///   defaultHomeserver: 'https://m.si46.world',
  ///   enableEncryption: true,
  /// ));
  /// ```
  static Future<void> initialize(N42ChatConfig config) async {
    if (_initialized) {
      debugLog('N42Chat: Already initialized');
      return;
    }
    // 防止并发调用：第二次调用等待第一次完成
    if (_initCompleter != null) {
      debugLog('N42Chat: Initialization in progress, waiting...');
      return _initCompleter!.future;
    }
    _initCompleter = Completer<void>();

    try {
      _config = config;
      N42ChatRouter.configure(enableDebugLogs: config.enableDebugLogs);
      await _initializeAuthMethods(config);

      // 重建用户变化流（dispose 后 controller 已关闭，需要新实例）
      if (_userStreamController.isClosed) {
        _userStreamController = StreamController<UserEntity?>.broadcast();
      }

      // 如果之前初始化中途失败，GetIt 可能已有部分注册，需要先重置
      if (getIt.isRegistered<N42ChatConfig>()) {
        debugLog('N42Chat: Resetting previous partial initialization');
        N42ChatRouter.reset(preserveDebugLogging: true);
        await resetDependencies();
      }

      // 初始化依赖注入
      await configureDependencies(config);

      // 创建全局 AuthBloc 并尝试恢复会话（防御性关闭旧实例）
      await _authBloc?.close();
      _authBloc = getIt<AuthBloc>();
      _authBloc!.add(const AuthRestoreSessionRequested());

      // 初始化推送通知服务（如果启用）
      // 不阻塞主初始化流程：FCM token 获取在无 GMS 设备上可能耗时 60-90 秒
      if (config.enablePushNotifications) {
        unawaited(
          _N42PushManager.initializePushService(config).catchError((Object e) {
            debugLog(
              'N42Chat: Push service initialization failed in background: $e',
            );
          }),
        );
      }

      // 如果 Matrix 客户端已登录，立即初始化通话管理器
      try {
        final clientManager = getIt<MatrixClientManager>();
        if (clientManager.client?.isLogged() == true) {
          debugLog(
            'N42Chat: Matrix client is logged in, initializing call manager',
          );
          await initializeCallManager();
        }
      } catch (e) {
        debugLog('N42Chat: Failed to check login status for call manager: $e');
      }

      // 设置 Moment 房间邀请自动加入监听
      _setupMomentInviteListener();

      _initialized = true;
      _flushPendingNotificationTap();
      debugLog('N42Chat: Initialized successfully');
      _initCompleter!.complete();
    } catch (e) {
      debugLog('N42Chat: Initialization failed, cleaning up: $e');
      // 清理已分配资源，使外部调用方可以重新初始化
      try {
        await _authBloc?.close();
        _authBloc = null;
      } catch (_) {}
      try {
        await _cleanupRuntimeResources();
      } catch (_) {}
      try {
        if (getIt.isRegistered<N42ChatConfig>()) {
          N42ChatRouter.reset();
          await resetDependencies();
        }
      } catch (_) {}
      _initialized = false;
      _config = null;
      _N42CallFacade._liveKitJwtUrl = null;
      _initCompleter!.completeError(e);
      rethrow;
    } finally {
      _initCompleter = null;
    }
  }

  static Future<void> _initializeAuthMethods(N42ChatConfig config) async {
    final rpId = Uri.tryParse(config.defaultHomeserver)?.host;
    try {
      await AuthMethodsService().initialize(
        googleClientId: config.googleClientId,
        googleServerClientId: config.googleServerClientId,
        passkeyRpId: (rpId != null && rpId.isNotEmpty) ? rpId : null,
        twitterApiKey: config.twitterApiKey,
        twitterApiSecret: config.twitterApiSecret,
        twitterRedirectUri: config.twitterRedirectUri,
        weChatAppId: config.weChatAppId,
        weChatUniversalLink: config.weChatUniversalLink,
      );
    } catch (e) {
      debugLog('N42Chat: Auth methods initialization failed: $e');
    }
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
        debugLog('N42Chat: Client null, skipping moment invite listener setup');
        return;
      }

      // 取消之前的监听
      _momentSyncSubscription?.cancel();

      _momentSyncSubscription = client.onSync.stream.listen((_) async {
        final now = DateTime.now();
        if (_lastMomentInviteCheck != null &&
            now.difference(_lastMomentInviteCheck!) <
                const Duration(seconds: 10)) {
          return;
        }
        _lastMomentInviteCheck = now;
        try {
          final momentDataSource = getIt<MatrixMomentDataSource>();
          await momentDataSource.processMomentInvites();
        } catch (e) {
          debugLog('N42Chat: Moment invite processing error: $e');
        }
      });

      debugLog('N42Chat: Moment invite listener set up');
    } catch (e) {
      debugLog('N42Chat: Failed to setup moment invite listener: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Auth
  // ---------------------------------------------------------------------------

  /// 获取全局 AuthBloc
  static AuthBloc get authBloc {
    _ensureInitialized();
    return _authBloc!;
  }

  /// 当前认证状态
  static AuthStatus get authStatus => authBloc.state.status;

  /// 认证状态变化流
  static Stream<AuthStatus> get authStatusStream =>
      authBloc.stream.map((state) => state.status).distinct();

  /// 打开 Chat 账户修改邮箱页面（完整 UI 流程）
  ///
  /// 适合在主应用完成 N42 账户邮箱修改后，引导用户同步 Chat 账户邮箱。
  /// 返回 `true` 表示用户完成了 Chat 邮箱修改。
  static Future<bool?> openChangeEmailPage(BuildContext context) {
    _ensureInitialized();
    return Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: _authBloc!,
          child: const chat_settings.ChangeEmailPage(),
        ),
      ),
    );
  }

  /// 请求修改 Chat 账户邮箱验证码（第一步）
  ///
  /// 在主应用 N42 邮箱修改成功后调用，向新邮箱发送 Chat 验证码。
  /// [password] 当前账户密码（Matrix 验证用）
  /// [newEmail] 新邮箱地址
  ///
  /// 成功时 Future 完成，失败时抛出异常（含错误描述）。
  /// 超时时间 30 秒。
  static Future<void> requestChatEmailChange(String password, String newEmail) {
    _ensureInitialized();
    final completer = Completer<void>();
    late StreamSubscription<AuthState> sub;
    sub = _authBloc!.stream.listen((state) {
      if (completer.isCompleted) {
        sub.cancel();
        return;
      }
      if (state.changeEmailStatus == ChangeEmailStatus.codeSent) {
        sub.cancel();
        completer.complete();
      } else if (state.changeEmailStatus == ChangeEmailStatus.failed) {
        sub.cancel();
        completer.completeError(
          state.errorMessage ?? 'Failed to send verification code',
        );
      }
    });
    _authBloc!.add(
      AuthRequestChangeEmailRequested(password: password, newEmail: newEmail),
    );
    return completer.future.timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        sub.cancel();
        throw TimeoutException('Chat email code request timed out');
      },
    );
  }

  /// 确认修改 Chat 账户邮箱（第二步）
  ///
  /// [newEmail] 新邮箱地址（与请求时一致）
  /// [code]     用户收到的 6 位验证码
  ///
  /// 成功时 Future 完成，失败时抛出异常（含错误描述）。
  /// 超时时间 30 秒。
  static Future<void> confirmChatEmailChange(String newEmail, String code) {
    _ensureInitialized();
    final completer = Completer<void>();
    late StreamSubscription<AuthState> sub;
    sub = _authBloc!.stream.listen((state) {
      if (completer.isCompleted) {
        sub.cancel();
        return;
      }
      if (state.changeEmailStatus == ChangeEmailStatus.success) {
        sub.cancel();
        completer.complete();
      } else if (state.changeEmailStatus == ChangeEmailStatus.failed) {
        sub.cancel();
        completer.completeError(
          state.errorMessage ?? 'Failed to update chat email',
        );
      }
    });
    _authBloc!.add(
      AuthConfirmChangeEmailRequested(newEmail: newEmail, code: code),
    );
    return completer.future.timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        sub.cancel();
        throw TimeoutException('Chat email confirmation timed out');
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Widget factories
  // ---------------------------------------------------------------------------

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
      return const _N42ChatBootstrapWidget();
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
      return _N42ProfileBootstrapWidget(showAppBar: showAppBar);
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
    return N42ChatRouter.routes;
  }

  // ---------------------------------------------------------------------------
  // Login / Logout
  // ---------------------------------------------------------------------------

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
    await _runAuthEvent(
      event: AuthLoginRequested(
        homeserver: homeserver,
        username: username,
        password: password,
        rememberMe: true,
      ),
      isSuccess: (state) => state.status == AuthStatus.authenticated,
      defaultErrorMessage: 'Failed to login',
      timeoutMessage: 'N42Chat.login() timed out',
    );
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
    await _runAuthEvent(
      event: AuthTokenLoginRequested(
        homeserver: homeserver,
        accessToken: accessToken,
        userId: userId,
        deviceId: deviceId,
      ),
      isSuccess: (state) => state.status == AuthStatus.authenticated,
      defaultErrorMessage: 'Failed to login with token',
      timeoutMessage: 'N42Chat.loginWithToken() timed out',
    );
  }

  /// 使用 Matrix SSO/OIDC 回调返回的 login token 登录
  static Future<void> loginWithLoginToken({
    required String homeserver,
    required String loginToken,
  }) async {
    _ensureInitialized();
    await _runAuthEvent(
      event: AuthLoginTokenLoginRequested(
        homeserver: homeserver,
        loginToken: loginToken,
      ),
      isSuccess: (state) => state.status == AuthStatus.authenticated,
      defaultErrorMessage: 'Failed to login with login token',
      timeoutMessage: 'N42Chat.loginWithLoginToken() timed out',
    );
  }

  /// 登出当前用户
  ///
  /// 清除本地会话数据和缓存
  static Future<void> logout() async {
    _ensureInitialized();
    final bloc = _authBloc;
    if (bloc == null) {
      throw StateError('N42Chat AuthBloc is not available.');
    }
    if (bloc.state.status == AuthStatus.unauthenticated && !isLoggedIn) {
      return;
    }

    final completer = Completer<void>();
    late final StreamSubscription<AuthState> sub;
    sub = bloc.stream.listen((state) {
      if (completer.isCompleted) {
        sub.cancel();
        return;
      }
      if (state.status == AuthStatus.unauthenticated ||
          state.status == AuthStatus.initial) {
        sub.cancel();
        completer.complete();
      } else if (state.status == AuthStatus.error) {
        sub.cancel();
        completer.completeError(
          N42ChatException(state.errorMessage ?? 'Failed to logout'),
        );
      }
    });

    bloc.add(const AuthLogoutRequested());
    await completer.future.timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        sub.cancel();
        throw TimeoutException('N42Chat.logout() timed out');
      },
    );
  }

  /// 清理本地持久化的 chat 数据。
  ///
  /// 用于账号注销后的强制清理，可在未初始化时调用。
  static Future<void> purgeLocalData() async {
    try {
      final secureStorage = getIt.isRegistered<SecureStorageDataSource>()
          ? getIt<SecureStorageDataSource>()
          : SecureStorageDataSource();
      await secureStorage.clearAll();
    } catch (e) {
      debugLog('N42Chat: Failed to clear secure storage: $e');
    }

    try {
      final docsDir = await getApplicationDocumentsDirectory();
      final supportDir = await getApplicationSupportDirectory();

      await _deleteDirectoryIfExists(Directory('${docsDir.path}/n42_chat_db'));
      await _deleteDirectoryIfExists(
        Directory('${supportDir.path}/n42_chat_db'),
      );
      await _deleteDirectoryIfExists(
        Directory('${docsDir.path}/n42_chat_storage'),
      );
      await _deleteDirectoryIfExists(
        Directory('${docsDir.path}/n42_chat_archives'),
      );
      await _deleteDirectoryIfExists(Directory('${docsDir.path}/matrix_cache'));
    } catch (e) {
      debugLog('N42Chat: Failed to clear local chat directories: $e');
    }
  }

  static Future<void> _runAuthEvent({
    required AuthEvent event,
    required bool Function(AuthState state) isSuccess,
    required String defaultErrorMessage,
    required String timeoutMessage,
  }) async {
    final bloc = _authBloc;
    if (bloc == null) {
      throw StateError('N42Chat AuthBloc is not available.');
    }

    final completer = Completer<void>();
    late final StreamSubscription<AuthState> sub;
    sub = bloc.stream.listen((state) {
      if (completer.isCompleted) {
        sub.cancel();
        return;
      }
      if (isSuccess(state)) {
        sub.cancel();
        completer.complete();
      } else if (state.status == AuthStatus.error) {
        sub.cancel();
        completer.completeError(
          N42ChatException(state.errorMessage ?? defaultErrorMessage),
        );
      }
    });

    bloc.add(event);
    await completer.future.timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        sub.cancel();
        throw TimeoutException(timeoutMessage);
      },
    );
  }

  // ---------------------------------------------------------------------------
  // User / Conversation queries
  // ---------------------------------------------------------------------------

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
    try {
      final repo = getIt<IConversationRepository>();
      return repo.watchTotalUnreadCount();
    } catch (e) {
      debugLog('N42Chat: Failed to get unread count stream: $e');
      return const Stream<int>.empty();
    }
  }

  /// 打开指定会话
  ///
  /// [roomId] Matrix房间ID
  /// [context] 可选的BuildContext，用于导航
  static Future<void> openConversation(
    String roomId, {
    BuildContext? context,
    String? targetMessageId,
  }) async {
    _ensureInitialized();
    debugLog(
      'N42Chat: Open conversation - $roomId'
      '${targetMessageId != null ? ' (target=$targetMessageId)' : ''}',
    );

    final ctx = context ?? _navigatorKey?.currentContext;
    if (ctx == null) {
      debugLog('N42Chat: No context available for navigation');
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
          debugLog('N42Chat: Failed to join room $roomId: $e');
        }
      }

      if (conversation == null) {
        debugLog('N42Chat: Conversation not found: $roomId');
        return;
      }

      if (!ctx.mounted) return;

      // Check if chat is locked
      final lockService = ChatLockService();
      final isLocked = await lockService.isChatLocked(roomId);

      if (isLocked && ctx.mounted) {
        final verified = await Navigator.of(ctx).push<bool>(
          MaterialPageRoute<bool>(
            builder: (_) =>
                ChatLockPage(roomId: roomId, chatName: conversation!.name),
          ),
        );
        if (verified != true) return;
      }

      if (!ctx.mounted) return;

      unawaited(
        Navigator.of(ctx)
            .push(
              MaterialPageRoute<void>(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => getIt<ChatBloc>()),
                    BlocProvider(create: (_) => getIt<ContactBloc>()),
                  ],
                  child: ChatPage(
                    conversation: conversation!,
                    initialTargetMessageId: targetMessageId,
                    onBack: () => Navigator.of(ctx).pop(),
                  ),
                ),
              ),
            )
            .catchError((Object e) {
              debugLog('N42Chat: Navigation error for room $roomId: $e');
            }),
      );
    } catch (e) {
      debugLog('N42Chat: Failed to open conversation $roomId: $e');
    }
  }

  /// 创建私聊会话
  ///
  /// [userId] 对方的Matrix用户ID
  /// 返回创建的房间ID
  static Future<String> createDirectMessage(String userId) async {
    _ensureInitialized();
    final repo = getIt<IConversationRepository>();
    final conversation = await repo.createDirectChat(userId);
    return conversation.id;
  }

  /// 打开用户资料页
  ///
  /// [userId] Matrix 用户 ID
  /// [context] 可选的 BuildContext，用于导航
  static Future<void> openUserProfile(
    String userId, {
    BuildContext? context,
  }) async {
    _ensureInitialized();
    debugLog('N42Chat: Open user profile - $userId');

    final ctx = context ?? _navigatorKey?.currentContext;
    if (ctx == null) {
      debugLog('N42Chat: No context available for user profile navigation');
      return;
    }

    if (!ctx.mounted) return;

    await Navigator.of(ctx).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
          create: (_) => getIt<ContactBloc>(),
          child: UserProfilePage(
            userId: userId,
            onChatStarted: (roomId, profileContext) async {
              if (Navigator.of(profileContext).canPop()) {
                Navigator.of(profileContext).pop();
              }
              if (!ctx.mounted) return;
              await openConversation(roomId, context: ctx);
            },
          ),
        ),
      ),
    );
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
    final repo = getIt<IGroupRepository>();
    return await repo.createGroup(name: name, inviteUserIds: inviteUserIds);
  }

  // ---------------------------------------------------------------------------
  // Dispose
  // ---------------------------------------------------------------------------

  /// 释放资源
  ///
  /// 在应用退出前调用，完整清理所有持有的资源
  static Future<void> dispose() async {
    if (!_initialized &&
        _authBloc == null &&
        _N42PushManager._pushService == null &&
        _N42CallFacade._callManager == null &&
        !getIt.isRegistered<N42ChatConfig>()) {
      return;
    }

    // 1. 关闭 AuthBloc（取消 loginStateStream 订阅）
    await _authBloc?.close();
    _authBloc = null;

    // 2. 释放运行时资源
    await _cleanupRuntimeResources();

    // 3. 关闭用户变化流
    await _userStreamController.close();

    // 4. 重置依赖注入容器和路由缓存
    N42ChatRouter.reset();
    if (getIt.isRegistered<N42ChatConfig>()) {
      await resetDependencies();
    }

    _initialized = false;
    _config = null;
    _N42CallFacade._liveKitJwtUrl = null;
    debugLog('N42Chat: Disposed');
  }

  static Future<void> _cleanupRuntimeResources() async {
    try {
      await _momentSyncSubscription?.cancel();
    } catch (_) {}
    _momentSyncSubscription = null;

    await _N42CallFacade.dispose();
    await _N42PushManager.dispose();

    _lastMomentInviteCheck = null;
    _pendingNotificationRoomId = null;
    _pendingNotificationEventId = null;
    _lastHandledNotificationKey = null;
    _lastHandledNotificationAt = null;
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

  static Future<void> _deleteDirectoryIfExists(Directory directory) async {
    if (!await directory.exists()) {
      return;
    }
    await directory.delete(recursive: true);
  }
}

/// N42 Chat 异常
class N42ChatException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const N42ChatException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'N42ChatException: $message (code: $code)';
}
