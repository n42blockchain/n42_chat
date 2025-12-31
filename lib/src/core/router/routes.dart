/// 路由路径常量
abstract class Routes {
  Routes._();

  // ============================================
  // 主Tab页面
  // ============================================

  /// 会话列表（消息Tab）
  static const String conversationList = '/chat';
  static const String conversationListName = 'conversationList';

  /// 通讯录Tab
  static const String contacts = '/contacts';
  static const String contactsName = 'contacts';

  /// 发现Tab
  static const String discover = '/discover';
  static const String discoverName = 'discover';

  /// 个人中心Tab
  static const String profile = '/profile';
  static const String profileName = 'profile';

  // ============================================
  // 聊天相关
  // ============================================

  /// 聊天详情页
  static const String chat = '/chat/conversation/:roomId';
  static const String chatName = 'chat';

  /// 生成聊天详情路径
  static String chatPath(String roomId) =>
      '/chat/conversation/${Uri.encodeComponent(roomId)}';

  // ============================================
  // 通讯录相关
  // ============================================

  /// 联系人详情
  static const String contactDetail = '/contacts/detail/:userId';
  static const String contactDetailName = 'contactDetail';

  /// 生成联系人详情路径
  static String contactDetailPath(String userId) =>
      '/contacts/detail/${Uri.encodeComponent(userId)}';

  /// 添加联系人
  static const String addContact = '/contacts/add';
  static const String addContactName = 'addContact';

  // ============================================
  // 个人中心相关
  // ============================================

  /// 设置
  static const String settings = '/profile/settings';
  static const String settingsName = 'settings';

  /// 编辑资料
  static const String editProfile = '/profile/edit';
  static const String editProfileName = 'editProfile';

  // ============================================
  // 认证相关
  // ============================================

  /// 登录
  static const String login = '/login';
  static const String loginName = 'login';

  /// 注册
  static const String register = '/register';
  static const String registerName = 'register';

  /// 欢迎页
  static const String welcome = '/welcome';
  static const String welcomeName = 'welcome';

  // ============================================
  // 群组相关
  // ============================================

  /// 创建群聊
  static const String createGroup = '/group/create';
  static const String createGroupName = 'createGroup';

  /// 群资料
  static const String groupInfo = '/group/:roomId/info';
  static const String groupInfoName = 'groupInfo';

  /// 生成群资料路径
  static String groupInfoPath(String roomId) =>
      '/group/${Uri.encodeComponent(roomId)}/info';

  /// 群成员
  static const String groupMembers = '/group/:roomId/members';
  static const String groupMembersName = 'groupMembers';

  /// 生成群成员路径
  static String groupMembersPath(String roomId) =>
      '/group/${Uri.encodeComponent(roomId)}/members';

  // ============================================
  // 搜索
  // ============================================

  /// 全局搜索
  static const String search = '/search';
  static const String searchName = 'search';

  /// 会话内搜索
  static const String chatSearch = '/chat/:roomId/search';
  static const String chatSearchName = 'chatSearch';

  /// 生成会话内搜索路径
  static String chatSearchPath(String roomId) =>
      '/chat/${Uri.encodeComponent(roomId)}/search';

  // ============================================
  // 媒体预览
  // ============================================

  /// 图片预览
  static const String imagePreview = '/preview/image';
  static const String imagePreviewName = 'imagePreview';

  /// 视频播放
  static const String videoPlayer = '/preview/video';
  static const String videoPlayerName = 'videoPlayer';

  // ============================================
  // 其他
  // ============================================

  /// 二维码扫描
  static const String qrScanner = '/qr/scan';
  static const String qrScannerName = 'qrScanner';

  /// 我的二维码
  static const String myQrCode = '/qr/my';
  static const String myQrCodeName = 'myQrCode';
}

