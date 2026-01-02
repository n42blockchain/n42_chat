import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';

/// Matrix客户端管理器
///
/// 单例模式管理Matrix Client实例，负责：
/// - 客户端初始化和配置
/// - 连接管理（连接、断开、重连）
/// - 同步状态管理
/// - 事件分发
class MatrixClientManager {
  MatrixClientManager._();

  static final MatrixClientManager _instance = MatrixClientManager._();
  static MatrixClientManager get instance => _instance;

  Client? _client;
  bool _isInitialized = false;
  bool _isInitializing = false;

  /// 获取Matrix客户端实例
  Client? get client => _client;

  /// 是否已初始化
  bool get isInitialized => _isInitialized;

  /// 是否已登录
  bool get isLoggedIn => _client?.isLogged() ?? false;

  /// 当前用户ID
  String? get userId => _client?.userID;

  /// 当前用户显示名
  String? get displayName => _client?.userID?.localpart;

  /// 同步状态流
  Stream<SyncStatusUpdate>? get onSyncStatus => _client?.onSyncStatus.stream;

  /// 登录状态变化流
  Stream<LoginState>? get onLoginStateChanged =>
      _client?.onLoginStateChanged.stream;

  /// 房间更新流
  Stream<String>? get onRoomUpdate => _client?.onSync.stream.map(
        (sync) => sync.rooms?.join?.keys.first ?? '',
      );

  // ============================================
  // 初始化
  // ============================================

  /// 初始化Matrix客户端
  ///
  /// [clientName] 客户端名称，用于设备识别
  /// [databasePath] 数据库存储路径，为空则使用默认路径
  Future<void> initialize({
    String clientName = 'N42Chat',
    String? databasePath,
  }) async {
    if (_isInitialized) {
      debugPrint('MatrixClientManager: Already initialized');
      return;
    }

    // 防止并发初始化
    if (_isInitializing) {
      debugPrint('MatrixClientManager: Already initializing, waiting...');
      // 等待初始化完成
      while (_isInitializing) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      return;
    }

    _isInitializing = true;

    try {
      // 获取数据库路径
      final dbPath = databasePath ?? await _getDefaultDatabasePath();

      // 确保数据库目录存在
      if (dbPath.isNotEmpty && !kIsWeb) {
        final dir = Directory(dbPath);
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }
      }

      // 创建客户端
      _client = Client(
        clientName,
        databaseBuilder: (_) => HiveCollectionsDatabase(
          clientName,
          dbPath,
        ),
        supportedLoginTypes: {
          AuthenticationTypes.password,
          AuthenticationTypes.sso,
        },
        logLevel: kDebugMode ? Level.verbose : Level.warning,
      );

      // 初始化客户端
      await _client!.init(
        waitForFirstSync: false,
        waitUntilLoadCompletedLoaded: false,
      );

      _isInitialized = true;
      debugPrint('MatrixClientManager: Initialized successfully');
      debugPrint('MatrixClientManager: Logged in: $isLoggedIn');
    } catch (e, stack) {
      debugPrint('MatrixClientManager: Initialize failed: $e');
      debugPrint('Stack: $stack');
      // 清理失败的初始化
      _client = null;
      _isInitialized = false;
      rethrow;
    } finally {
      _isInitializing = false;
    }
  }

  /// 获取默认数据库路径
  Future<String> _getDefaultDatabasePath() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      return dir.path;
    } catch (e) {
      // Web平台使用空路径
      return '';
    }
  }

  // ============================================
  // 认证
  // ============================================

  /// 使用用户名密码登录
  ///
  /// [homeserver] Matrix服务器地址
  /// [username] 用户名（不含@和服务器部分）
  /// [password] 密码
  /// [deviceName] 设备名称
  Future<LoginResponse> login({
    required String homeserver,
    required String username,
    required String password,
    String? deviceName,
  }) async {
    _ensureInitialized();

    try {
      // 设置homeserver
      final homeserverUri = Uri.parse(homeserver);
      await _client!.checkHomeserver(homeserverUri);

      // 登录
      final response = await _client!.login(
        LoginType.mLoginPassword,
        identifier: AuthenticationUserIdentifier(user: username),
        password: password,
        initialDeviceDisplayName: deviceName ?? 'N42Chat',
      );

      debugPrint('MatrixClientManager: Login successful - ${response.userId}');
      return response;
    } catch (e) {
      debugPrint('MatrixClientManager: Login failed: $e');
      rethrow;
    }
  }

  /// 使用Token登录（恢复会话）
  ///
  /// [homeserver] Matrix服务器地址
  /// [accessToken] 访问令牌
  /// [userId] 用户ID
  /// [deviceId] 设备ID
  Future<void> loginWithToken({
    required String homeserver,
    required String accessToken,
    required String userId,
    required String deviceId,
  }) async {
    _ensureInitialized();

    try {
      final homeserverUri = Uri.parse(homeserver);
      await _client!.checkHomeserver(homeserverUri);

      // 使用token恢复登录
      await _client!.init(
        newToken: accessToken,
        newUserID: userId,
        newDeviceID: deviceId,
        newDeviceName: 'N42Chat',
        newHomeserver: homeserverUri,
      );

      debugPrint('MatrixClientManager: Token login successful - $userId');
    } catch (e) {
      debugPrint('MatrixClientManager: Token login failed: $e');
      rethrow;
    }
  }

  /// 登出
  Future<void> logout() async {
    if (_client == null) return;

    try {
      await _client!.logout();
      debugPrint('MatrixClientManager: Logout successful');
    } catch (e) {
      debugPrint('MatrixClientManager: Logout failed: $e');
      // 即使登出失败也清理本地状态
    }
  }

  // ============================================
  // 同步
  // ============================================

  /// 开始同步
  ///
  /// [timeout] 同步超时时间
  /// [fullState] 是否获取完整状态
  Future<void> startSync({
    Duration timeout = const Duration(seconds: 30),
    bool fullState = false,
  }) async {
    _ensureInitialized();
    _ensureLoggedIn();

    try {
      // 开始后台同步
      _client!.backgroundSync = true;

      debugPrint('MatrixClientManager: Sync started');
    } catch (e) {
      debugPrint('MatrixClientManager: Start sync failed: $e');
      rethrow;
    }
  }

  /// 停止同步
  void stopSync() {
    if (_client != null) {
      _client!.backgroundSync = false;
      debugPrint('MatrixClientManager: Sync stopped');
    }
  }

  // ============================================
  // 房间操作
  // ============================================

  /// 获取所有房间
  List<Room> get rooms => _client?.rooms ?? [];

  /// 获取房间
  Room? getRoom(String roomId) => _client?.getRoomById(roomId);

  /// 获取私聊房间（通过用户ID）
  Room? getDirectChat(String userId) {
    final roomId = _client?.getDirectChatFromUserId(userId);
    if (roomId == null) return null;
    return _client?.getRoomById(roomId);
  }

  /// 创建私聊房间
  Future<String> createDirectChat(String userId) async {
    _ensureInitialized();
    _ensureLoggedIn();

    final roomId = await _client!.startDirectChat(userId);
    return roomId;
  }

  /// 创建群聊房间
  Future<String> createGroup({
    required String name,
    List<String> inviteUserIds = const [],
    String? topic,
    bool encrypted = true,
  }) async {
    _ensureInitialized();
    _ensureLoggedIn();

    final roomId = await _client!.createRoom(
      name: name,
      invite: inviteUserIds,
      topic: topic,
      preset: CreateRoomPreset.privateChat,
      initialState: encrypted
          ? [
              StateEvent(
                type: EventTypes.Encryption,
                stateKey: '',
                content: {'algorithm': 'm.megolm.v1.aes-sha2'},
              ),
            ]
          : null,
    );
    return roomId;
  }

  // ============================================
  // 用户操作
  // ============================================

  /// 搜索用户
  Future<SearchUserDirectoryResponse> searchUsers(
    String term, {
    int limit = 10,
  }) async {
    _ensureInitialized();
    _ensureLoggedIn();

    return await _client!.searchUserDirectory(term, limit: limit);
  }

  /// 获取用户资料
  Future<Profile> getUserProfile(String userId) async {
    _ensureInitialized();

    return await _client!.getProfileFromUserId(userId);
  }

  /// 更新显示名称
  Future<void> setDisplayName(String displayName) async {
    _ensureInitialized();
    _ensureLoggedIn();

    await _client!.setDisplayName(_client!.userID!, displayName);
  }

  /// 更新头像
  Future<void> setAvatar(MatrixFile file) async {
    _ensureInitialized();
    _ensureLoggedIn();

    await _client!.setAvatar(file);
  }

  // ============================================
  // 资源管理
  // ============================================

  /// 释放资源
  Future<void> dispose() async {
    stopSync();

    if (_client != null) {
      await _client!.dispose();
      _client = null;
    }

    _isInitialized = false;
    debugPrint('MatrixClientManager: Disposed');
  }

  // ============================================
  // 辅助方法
  // ============================================

  void _ensureInitialized() {
    if (!_isInitialized || _client == null) {
      throw StateError(
        'MatrixClientManager has not been initialized. '
        'Call initialize() first.',
      );
    }
  }

  void _ensureLoggedIn() {
    if (!isLoggedIn) {
      throw StateError('Not logged in. Call login() first.');
    }
  }
}

