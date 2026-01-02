import 'dart:async';
import 'dart:convert';
import 'dart:io' if (dart.library.html) 'dart:html';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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
  /// [forceReinit] 强制重新初始化
  Future<void> initialize({
    String clientName = 'N42Chat',
    String? databasePath,
    bool forceReinit = false,
  }) async {
    if (_isInitialized && !forceReinit) {
      debugPrint('MatrixClientManager: Already initialized');
      return;
    }

    // 如果强制重新初始化，先清理旧的客户端
    if (forceReinit && _client != null) {
      debugPrint('MatrixClientManager: Force reinitializing, disposing old client...');
      try {
        await _client!.dispose();
      } catch (_) {}
      _client = null;
      _isInitialized = false;
    }

    // 防止并发初始化
    if (_isInitializing) {
      debugPrint('MatrixClientManager: Already initializing, waiting...');
      // 等待初始化完成
      int waitCount = 0;
      while (_isInitializing && waitCount < 100) {
        await Future.delayed(const Duration(milliseconds: 100));
        waitCount++;
      }
      if (_isInitialized) return;
      // 如果等待超时且仍未初始化，继续尝试初始化
    }

    _isInitializing = true;

    try {
      // 获取数据库路径
      String dbPath;
      if (databasePath != null) {
        dbPath = databasePath;
      } else {
        dbPath = await _getDefaultDatabasePath();
      }

      debugPrint('MatrixClientManager: Using database path: $dbPath');

      // 确保数据库目录存在（仅在非 Web 平台）
      if (!kIsWeb && dbPath.isNotEmpty) {
        try {
          final dir = Directory(dbPath);
          if (!dir.existsSync()) {
            dir.createSync(recursive: true);
            debugPrint('MatrixClientManager: Created database directory');
          }
          
          // 初始化 Hive（必须在使用 HiveCollectionsDatabase 之前）
          debugPrint('MatrixClientManager: Initializing Hive at: $dbPath');
          Hive.init(dbPath);
          debugPrint('MatrixClientManager: Hive initialized');
        } catch (e) {
          debugPrint('MatrixClientManager: Could not initialize Hive: $e');
          // 继续尝试，让 Matrix SDK 自己处理
        }
      }

      // 创建 Hive 数据库实例并先打开它
      debugPrint('MatrixClientManager: Creating HiveCollectionsDatabase...');
      final database = HiveCollectionsDatabase(
        clientName,
        dbPath,
      );
      
      // 先打开数据库，确保所有 boxes 都已初始化
      debugPrint('MatrixClientManager: Opening database...');
      await database.open();
      debugPrint('MatrixClientManager: Database opened successfully');
      
      // 创建客户端
      _client = Client(
        clientName,
        databaseBuilder: (_) => database,
        supportedLoginTypes: {
          AuthenticationTypes.password,
          AuthenticationTypes.sso,
        },
        logLevel: kDebugMode ? Level.verbose : Level.warning,
      );

      // 初始化客户端 - 等待数据库完全加载
      debugPrint('MatrixClientManager: Starting client init...');
      await _client!.init(
        waitForFirstSync: false,
        waitUntilLoadCompletedLoaded: true, // 等待数据库完全加载
      );
      
      // 额外等待确保初始化完成
      await Future.delayed(const Duration(milliseconds: 200));

      _isInitialized = true;
      debugPrint('MatrixClientManager: Initialized successfully');
      debugPrint('MatrixClientManager: Logged in: $isLoggedIn');
    } catch (e, stack) {
      debugPrint('MatrixClientManager: Initialize failed: $e');
      debugPrint('Stack: $stack');
      // 清理失败的初始化
      if (_client != null) {
        try {
          await _client!.dispose();
        } catch (_) {}
        _client = null;
      }
      _isInitialized = false;
      rethrow;
    } finally {
      _isInitializing = false;
    }
  }

  /// 获取默认数据库路径
  Future<String> _getDefaultDatabasePath() async {
    if (kIsWeb) {
      // Web 平台使用空路径，Hive 会使用 IndexedDB
      return '';
    }
    
    try {
      final dir = await getApplicationDocumentsDirectory();
      // 使用子目录来存储数据库
      final dbDir = p.join(dir.path, 'n42_chat_db');
      return dbDir;
    } catch (e) {
      debugPrint('MatrixClientManager: Failed to get documents directory: $e');
      // 尝试使用应用支持目录
      try {
        final supportDir = await getApplicationSupportDirectory();
        final dbDir = p.join(supportDir.path, 'n42_chat_db');
        return dbDir;
      } catch (e2) {
        debugPrint('MatrixClientManager: Failed to get support directory: $e2');
        return '';
      }
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
  /// 
  /// Matrix 头像上传流程:
  /// 1. 先上传文件到 Matrix 服务器获取 mxc:// URI
  /// 2. 然后调用 setAvatar 设置用户头像
  Future<void> setAvatar(Uint8List avatarBytes, String filename) async {
    debugPrint('=== MatrixClientManager.setAvatar start ===');
    debugPrint('filename: $filename');
    debugPrint('avatarBytes.length: ${avatarBytes.length}');
    
    _ensureInitialized();
    _ensureLoggedIn();

    // 检查文件是否为空
    if (avatarBytes.isEmpty) {
      debugPrint('ERROR: Avatar bytes is empty');
      throw Exception('头像数据为空');
    }
    
    // 检查文件大小（限制 10MB）
    const maxSize = 10 * 1024 * 1024; // 10MB
    if (avatarBytes.length > maxSize) {
      debugPrint('ERROR: Avatar too large: ${avatarBytes.length} bytes');
      throw Exception('头像文件过大，最大支持 10MB');
    }

    // 处理文件名 - 确保有扩展名
    String actualFilename = filename;
    if (!actualFilename.contains('.')) {
      actualFilename = '$actualFilename.jpg';
    }
    
    // 根据文件名确定 MIME 类型
    String mimeType = 'image/jpeg';
    final lowerFilename = actualFilename.toLowerCase();
    if (lowerFilename.endsWith('.png')) {
      mimeType = 'image/png';
    } else if (lowerFilename.endsWith('.gif')) {
      mimeType = 'image/gif';
    } else if (lowerFilename.endsWith('.webp')) {
      mimeType = 'image/webp';
    } else if (lowerFilename.endsWith('.heic') || lowerFilename.endsWith('.heif')) {
      // HEIC/HEIF 需要转换为 JPEG，因为 Matrix 服务器可能不支持
      mimeType = 'image/jpeg';
      actualFilename = actualFilename.replaceAll(RegExp(r'\.(heic|heif)$', caseSensitive: false), '.jpg');
    }
    
    debugPrint('Final filename: $actualFilename');
    debugPrint('Final mimeType: $mimeType');
    debugPrint('User ID: ${_client!.userID}');
    
    try {
      // 直接使用 SDK 的 uploadContent 方法（最可靠）
      debugPrint('Uploading avatar with SDK uploadContent...');
      Uri? mxcUri;
      
      try {
        mxcUri = await _client!.uploadContent(
          avatarBytes,
          filename: actualFilename,
          contentType: mimeType,
        );
        debugPrint('SDK upload successful: $mxcUri');
      } catch (sdkError) {
        debugPrint('SDK uploadContent failed: $sdkError');
        // 尝试手动上传
        debugPrint('Trying manual upload...');
        mxcUri = await _uploadContentAuthenticated(
          avatarBytes,
          filename: actualFilename,
          contentType: mimeType,
        );
      }
      
      if (mxcUri == null) {
        throw Exception('上传头像失败');
      }
      
      debugPrint('Avatar uploaded: $mxcUri');
      
      // 设置头像 URL
      debugPrint('Setting avatar URL...');
      await _client!.setAvatarUrl(_client!.userID!, mxcUri);
      debugPrint('Avatar URL set successfully');
      
      // 验证头像是否设置成功
      final profile = await _client!.getProfileFromUserId(_client!.userID!);
      debugPrint('New avatar URL: ${profile.avatarUrl}');
      
      debugPrint('=== setAvatar completed successfully ===');
    } catch (e, stackTrace) {
      debugPrint('=== setAvatar ERROR: $e ===');
      debugPrint('Stack: $stackTrace');
      rethrow;
    }
  }
  
  /// 检查服务器是否支持认证媒体上传
  Future<bool> _supportsAuthenticatedMedia() async {
    try {
      final versionsResponse = await _client!.getVersions();
      // 检查 Matrix 版本是否 >= v1.11 (支持认证媒体)
      final supportsV111 = versionsResponse.versions.any(
        (v) => _isVersionGreaterThanOrEqualTo(v, 'v1.11'),
      );
      // 或者检查 unstable feature
      final hasUnstableFeature = 
          versionsResponse.unstableFeatures?['org.matrix.msc3916.stable'] == true;
      
      debugPrint('MatrixClientManager: supportsV111=$supportsV111, hasUnstableFeature=$hasUnstableFeature');
      return supportsV111 || hasUnstableFeature;
    } catch (e) {
      debugPrint('MatrixClientManager: Error checking authenticated media support: $e');
      return false;
    }
  }
  
  bool _isVersionGreaterThanOrEqualTo(String version, String target) {
    try {
      final vParts = version.replaceAll('v', '').split('.');
      final tParts = target.replaceAll('v', '').split('.');
      
      final vMajor = int.tryParse(vParts[0]) ?? 0;
      final vMinor = vParts.length > 1 ? (int.tryParse(vParts[1]) ?? 0) : 0;
      final tMajor = int.tryParse(tParts[0]) ?? 0;
      final tMinor = tParts.length > 1 ? (int.tryParse(tParts[1]) ?? 0) : 0;
      
      if (vMajor > tMajor) return true;
      if (vMajor < tMajor) return false;
      return vMinor >= tMinor;
    } catch (e) {
      return false;
    }
  }

  /// 使用认证端点上传文件
  Future<Uri?> _uploadContentAuthenticated(
    Uint8List content, {
    String? filename,
    String? contentType,
  }) async {
    if (_client == null) {
      throw Exception('Matrix client not initialized');
    }
    if (_client!.accessToken == null) {
      throw Exception('No access token available');
    }
    if (_client!.homeserver == null) {
      throw Exception('No homeserver configured');
    }

    final supportsAuth = await _supportsAuthenticatedMedia();
    debugPrint('MatrixClientManager: supportsAuthenticatedMedia=$supportsAuth');
    
    // 根据服务器能力选择端点
    final path = supportsAuth 
        ? '_matrix/client/v1/media/upload'  // 认证媒体端点 (MSC3916)
        : '_matrix/media/v3/upload';         // 传统端点
    
    final uri = Uri.parse('${_client!.homeserver}/$path').replace(
      queryParameters: filename != null ? {'filename': filename} : null,
    );
    
    debugPrint('MatrixClientManager: Uploading to: $uri');
    debugPrint('MatrixClientManager: Content size: ${content.length} bytes');
    debugPrint('MatrixClientManager: Content type: $contentType');
    
    final request = http.Request('POST', uri);
    request.headers['Authorization'] = 'Bearer ${_client!.accessToken}';
    if (contentType != null) {
      request.headers['Content-Type'] = contentType;
    }
    request.bodyBytes = content;
    
    try {
      final streamedResponse = await http.Client().send(request);
      final response = await http.Response.fromStream(streamedResponse);
      
      debugPrint('MatrixClientManager: Upload response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final contentUri = json['content_uri'] as String?;
        if (contentUri != null) {
          debugPrint('MatrixClientManager: Upload successful: $contentUri');
          return Uri.parse(contentUri);
        }
      }
      
      // 上传失败，打印错误信息
      debugPrint('MatrixClientManager: Upload failed: ${response.body}');
      
      // 如果使用认证端点失败，尝试传统端点
      if (supportsAuth && response.statusCode == 403) {
        debugPrint('MatrixClientManager: Auth endpoint failed, trying legacy endpoint...');
        return _uploadContentLegacy(content, filename: filename, contentType: contentType);
      }
      
      // 解析错误信息
      try {
        final errorJson = jsonDecode(response.body);
        final errcode = errorJson['errcode'] as String?;
        final error = errorJson['error'] as String?;
        throw Exception('Upload failed: $errcode - $error');
      } catch (_) {
        throw Exception('Upload failed with status ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('MatrixClientManager: Upload error: $e');
      rethrow;
    }
  }
  
  /// 使用传统端点上传文件（作为 fallback）
  Future<Uri?> _uploadContentLegacy(
    Uint8List content, {
    String? filename,
    String? contentType,
  }) async {
    if (_client == null) return null;
    
    final uri = Uri.parse('${_client!.homeserver}/_matrix/media/v3/upload').replace(
      queryParameters: filename != null ? {'filename': filename} : null,
    );
    
    debugPrint('MatrixClientManager: Uploading (legacy) to: $uri');
    
    final request = http.Request('POST', uri);
    request.headers['Authorization'] = 'Bearer ${_client!.accessToken}';
    if (contentType != null) {
      request.headers['Content-Type'] = contentType;
    }
    request.bodyBytes = content;
    
    final streamedResponse = await http.Client().send(request);
    final response = await http.Response.fromStream(streamedResponse);
    
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final contentUri = json['content_uri'] as String?;
      if (contentUri != null) {
        return Uri.parse(contentUri);
      }
    }
    
    debugPrint('MatrixClientManager: Legacy upload failed: ${response.body}');
    return null;
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

