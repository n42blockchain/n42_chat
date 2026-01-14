// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get chatModuleInitFailed => '聊天模块初始化失败';

  @override
  String get checkNetworkRetry => '请检查网络连接后重试';

  @override
  String get retry => '重试';

  @override
  String get unknownUser => '未知用户';

  @override
  String get walletNotConnected => '钱包未连接';

  @override
  String get cannotGetWalletAddress => '无法获取钱包地址';

  @override
  String paymentRequestMemo(String requestId) {
    return '支付请求: $requestId';
  }

  @override
  String get callServiceNotInitialized => '通话服务未初始化';

  @override
  String get alreadyInCall => '当前正在通话中';

  @override
  String get meetingServiceNotInitialized => '会议服务未初始化';

  @override
  String get livekitNotConfigured => 'LiveKit 未配置';

  @override
  String get unknownConversation => '未知会话';

  @override
  String startCallFailed(String error) {
    return '发起通话失败: $error';
  }

  @override
  String answerCallFailed(String error) {
    return '接听失败: $error';
  }

  @override
  String get connectionFailed => '连接失败';

  @override
  String get callRejected => '对方已拒绝';

  @override
  String get noAnswer => '对方无应答';

  @override
  String get invalidLoginResponse => '登录响应无效';

  @override
  String loginFailed(String error) {
    return '登录失败: $error';
  }

  @override
  String get sessionRestoreFailed => '会话恢复失败';

  @override
  String get additionalVerificationRequired => '需要完成额外验证';

  @override
  String registrationFailed(String error) {
    return '注册失败: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return '无法连接到服务器: $error';
  }

  @override
  String get wrongUsernamePassword => '用户名或密码错误';

  @override
  String get usernameTaken => '用户名已被使用';

  @override
  String get invalidUsernameFormat => '用户名格式无效';

  @override
  String get rateLimitExceeded => '请求过于频繁，请稍后再试';

  @override
  String get loginExpired => '登录已过期';

  @override
  String joinMeetingFailed(String error) {
    return '加入会议失败: $error';
  }

  @override
  String screenShareFailed(String error) {
    return '屏幕共享失败: $error';
  }

  @override
  String get answer => '接听';

  @override
  String get decline => '拒绝';

  @override
  String get missedCall => '未接来电';

  @override
  String get callBack => '回拨';

  @override
  String get incomingCall => '来电';

  @override
  String get missedVideoCall => '未接视频通话';

  @override
  String get missedVoiceCall => '未接语音通话';

  @override
  String get passkeyNotInitialized => 'Passkey 未初始化';

  @override
  String get googleSignInNotConfigured => 'Google Sign In 未配置';

  @override
  String get encryptedMessage => '[加密消息]';

  @override
  String get sticker => '[表情]';

  @override
  String get groupCreated => '创建了群聊';

  @override
  String get groupNameChanged => '修改了群名称';

  @override
  String get groupAvatarChanged => '修改了群头像';

  @override
  String get groupAnnouncementChanged => '修改了群公告';

  @override
  String get image => '[图片]';

  @override
  String get video => '[视频]';

  @override
  String get voice => '[语音]';

  @override
  String get file => '[文件]';

  @override
  String get location => '[位置]';

  @override
  String get unknownMessage => '[未知消息]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName 加入了群聊';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName 离开了群聊';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName 被邀请加入';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName 被移出群聊';
  }

  @override
  String get avatarDataEmpty => '头像数据为空';

  @override
  String get avatarTooLarge => '头像文件过大，最大支持 10MB';

  @override
  String get uploadAvatarFailed => '上传头像失败';

  @override
  String get delete => '删除';

  @override
  String get notLoggedIn => '未登录';

  @override
  String roomNotExist(String roomId) {
    return '房间不存在: $roomId';
  }

  @override
  String get uploadImageFailed => '上传图片失败';

  @override
  String get matrixClientNotInitialized => 'Matrix 客户端未初始化';

  @override
  String get uploadVoiceFailed => '上传语音失败：无法获取 MXC URI';

  @override
  String get uploadVideoFailed => '上传视频失败：无法获取 MXC URI';

  @override
  String get uploadFileFailed => '上传文件失败：无法获取 MXC URI';

  @override
  String locationWithCoords(String lat, String lon) {
    return '位置: $lat, $lon';
  }

  @override
  String get myLocation => '我的位置';

  @override
  String get pollEnded => '投票已结束';

  @override
  String get groupChat => '群聊';

  @override
  String get search => '搜索';

  @override
  String get cancel => '取消';

  @override
  String get userCancelled => '用户取消';

  @override
  String get noData => '暂无数据';

  @override
  String get noSearchResults => '无搜索结果';

  @override
  String get tryDifferentKeyword => '换个关键词试试';

  @override
  String get loadFailed => '加载失败';

  @override
  String get checkNetwork => '请检查网络连接';

  @override
  String get networkConnectionFailed => '网络连接失败';

  @override
  String get checkNetworkSettings => '请检查网络设置';

  @override
  String get messages => '消息';

  @override
  String get contacts => '联系人';

  @override
  String get discover => '发现';

  @override
  String get me => '我';

  @override
  String get voiceLoading => '语音加载中，请稍后再试';

  @override
  String get voiceToTextFailed => '语音转文字失败';

  @override
  String get converting => '转换中...';

  @override
  String get convertToText => '转文字';

  @override
  String get convertToTextTitle => '转为文字';

  @override
  String get selectEmoji => '选择表情';

  @override
  String get frequentlyUsed => '常用';

  @override
  String get copy => '复制';

  @override
  String get forward => '转发';

  @override
  String get unfavorite => '取消收藏';

  @override
  String get favorite => '收藏';

  @override
  String get resend => '重发';

  @override
  String get recall => '撤回';

  @override
  String get multiSelect => '多选';

  @override
  String get quote => '引用';

  @override
  String get remind => '提醒';

  @override
  String get searchThis => '搜一搜';

  @override
  String get recallMessageConfirm => '撤回该条消息？';

  @override
  String get youRecalledMessage => '你撤回了一条消息';

  @override
  String get otherRecalledMessage => '对方撤回了一条消息';

  @override
  String get reEdit => '重新编辑';

  @override
  String get copied => '已复制';

  @override
  String get sendMessageHint => '发送消息';

  @override
  String get microphonePermissionRequired => '请允许使用麦克风权限';

  @override
  String startRecordingFailed(String error) {
    return '开始录音失败: $error';
  }

  @override
  String get recordingTooShort => '录音时间太短';

  @override
  String stopRecordingFailed(String error) {
    return '停止录音失败: $error';
  }

  @override
  String get releaseToCancel => '松开取消';

  @override
  String get releaseToSend => '松开发送，上滑取消';

  @override
  String get holdToTalk => '按住 说话';

  @override
  String get send => '发送';

  @override
  String conversationLabel(String roomId) {
    return '会话';
  }

  @override
  String contactLabel(String userId) {
    return '联系人';
  }

  @override
  String get addFriend => '添加好友';

  @override
  String get chatServiceNotConnected => '聊天服务未连接';

  @override
  String userNotFoundHint(String query) {
    return '未找到用户 \"$query\"\n\n提示：\n• 尝试输入完整用户ID，如 @username:server.com\n• 确认用户名拼写正确';
  }

  @override
  String createChatFailed(String error) {
    return '创建会话失败: $error';
  }

  @override
  String searchFailed(String error) {
    return '搜索失败: $error';
  }

  @override
  String get enterUserIdOrUsername => '输入用户 ID 或用户名搜索';

  @override
  String get searching => '搜索中...';

  @override
  String get searchUserToChat => '搜索用户开始聊天';

  @override
  String get matrixIdExample =>
      '可以输入完整的 Matrix ID\n例如: @user:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return '未找到用户 \"$username\"';
  }

  @override
  String get chat => '聊天';

  @override
  String get settings => '设置';

  @override
  String get editProfile => '编辑资料';

  @override
  String get login => '登录';

  @override
  String get createGroup => '创建群聊';

  @override
  String developing(String title) {
    return '$title\n(开发中)';
  }

  @override
  String get error => '错误';

  @override
  String get pageNotFound => '页面不存在';

  @override
  String get backToHome => '返回首页';

  @override
  String get allRead => '全部已读';

  @override
  String readCount(int count) {
    return '$count人已读';
  }

  @override
  String get transfer => '转账';

  @override
  String get pendingReceipt => '待对方接收';

  @override
  String get tapToReceive => '点击领取';

  @override
  String get received => '已被接收';

  @override
  String get paymentReceived => '已收款';

  @override
  String get refunded => '已退还';

  @override
  String get expired => '已过期';

  @override
  String get redPacketGreeting => '恭喜发财，大吉大利';

  @override
  String get n42RedPacket => 'N42红包';

  @override
  String get goodLuck => '领个好彩头';

  @override
  String get claimed => '已领取';

  @override
  String get allClaimed => '已被领完';

  @override
  String get emoji => '表情';

  @override
  String get love => '爱心';

  @override
  String get animals => '动物';

  @override
  String get food => '食物';

  @override
  String get travel => '交通';

  @override
  String get activities => '活动';

  @override
  String get objects => '物品';

  @override
  String get symbols => '符号';

  @override
  String get reply => '回复';

  @override
  String get copiedToClipboard => '已复制到剪贴板';

  @override
  String get edit => '编辑';

  @override
  String get more => '更多';

  @override
  String get selectForwardTarget => '选择转发对象';

  @override
  String sendCount(int count) {
    return '发送($count)';
  }

  @override
  String get draft => '[草稿] ';

  @override
  String n42Id(String id) {
    return 'N42号：$id';
  }

  @override
  String get friendInfo => '朋友资料';

  @override
  String get friendInfoDesc => '添加朋友的备注名、电话、标签、备忘、照片等，并设置朋友权限。';

  @override
  String get moments => '朋友圈';

  @override
  String get sendMessage => '发消息';

  @override
  String get audioVideoCall => '音视频通话';

  @override
  String get videoChannel => '视频号';

  @override
  String get remark => '备注';

  @override
  String get remarkName => '备注名';

  @override
  String get phone => '电话';

  @override
  String get tags => '标签';

  @override
  String get notes => '备忘';

  @override
  String get photos => '照片';

  @override
  String get permissions => '权限';

  @override
  String get chatMomentsEtc => '聊天、朋友圈、运动等';

  @override
  String get moreInfo => '更多信息';

  @override
  String get commonGroups => '我和他 (她) 的共同群聊';

  @override
  String get zeroGroups => '0个';

  @override
  String get source => '来源';

  @override
  String get notificationSettings => '消息通知';

  @override
  String get receiveNotifications => '接收新消息通知';

  @override
  String get showPreview => '显示消息预览';

  @override
  String get showContentInNotification => '在通知中显示消息内容';

  @override
  String get notificationSound => '通知声音';

  @override
  String get playSoundOnMessage => '收到消息时播放声音';

  @override
  String get vibrate => '震动';

  @override
  String get vibrateOnMessage => '收到消息时震动';

  @override
  String get doNotDisturb => '免打扰模式';

  @override
  String get dndDescription => '在指定时间段内不接收通知';

  @override
  String get startTime => '开始时间';

  @override
  String get endTime => '结束时间';

  @override
  String get privacy => '隐私';

  @override
  String get appearance => '外观';

  @override
  String get about => '关于';

  @override
  String get logout => '退出登录';

  @override
  String get logoutConfirm => '确定要退出登录吗？';

  @override
  String get exit => '退出';

  @override
  String get save => '保存';

  @override
  String get nickname => '昵称';

  @override
  String get enterNickname => '请输入昵称';

  @override
  String get signature => '签名';

  @override
  String get addSignature => '添加个性签名';

  @override
  String get takePhoto => '拍照';

  @override
  String get chooseFromGallery => '从相册选择';

  @override
  String saveFailed(String error) {
    return '保存失败: $error';
  }

  @override
  String get secureDecentralizedChat => '安全、去中心化的即时通讯';

  @override
  String get endToEndEncryption => '端对端加密';

  @override
  String get messagesOnlyYouCanSee => '消息仅你和对方可见';

  @override
  String get decentralized => '去中心化';

  @override
  String get basedOnMatrix => '基于Matrix开放协议';

  @override
  String get walletIntegration => '钱包集成';

  @override
  String get easyCryptoTransfer => '轻松进行加密货币转账';

  @override
  String get register => '注册';

  @override
  String get agreeTerms => '登录即表示同意';

  @override
  String get termsOfService => '《服务协议》';

  @override
  String get and => '和';

  @override
  String get privacyPolicy => '《隐私政策》';

  @override
  String get serverAddress => '服务器地址';

  @override
  String get enterServerAddress => '请输入服务器地址';

  @override
  String get validServerAddress => '请输入有效的服务器地址';

  @override
  String connectedTo(String serverName) {
    return '已连接到 $serverName';
  }

  @override
  String get username => '用户名';

  @override
  String get enterUsername => '请输入用户名';

  @override
  String get password => '密码';

  @override
  String get enterPassword => '请输入密码';

  @override
  String get registerAccount => '注册账号';

  @override
  String get forgotPassword => '忘记密码';

  @override
  String get otherLoginMethods => '其他登录方式';

  @override
  String get emailVerification => '邮箱验证码';

  @override
  String get enterServerFirst => '请先输入服务器地址';

  @override
  String get passkeyNeedsServer => 'Passkey 登录需要服务端支持';

  @override
  String googleLoginSuccess(String email) {
    return 'Google 登录成功: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Google 登录失败: $error';
  }

  @override
  String get appleLoginSuccess => 'Apple 登录成功';

  @override
  String appleLoginFailed(String error) {
    return 'Apple 登录失败: $error';
  }

  @override
  String get createAccount => '创建账号';

  @override
  String get joinN42Chat => '加入 N42 Chat 开始聊天';

  @override
  String get usernameHint => '3-20字符，字母/数字/_';

  @override
  String get usernameMinLength => '用户名至少3个字符';

  @override
  String get usernameMaxLength => '用户名最多20个字符';

  @override
  String get usernameFormat => '用户名只能包含字母、数字和下划线';

  @override
  String get passwordHint => '至少8位';

  @override
  String get passwordMinLength => '密码至少8位';

  @override
  String get confirmPassword => '确认密码';

  @override
  String get reEnterPassword => '请再次输入密码';

  @override
  String get passwordsNotMatch => '两次输入的密码不一致';

  @override
  String get inviteCode => '邀请码（已内置）';

  @override
  String get filled => '已填写';

  @override
  String get enterInviteCode => '请输入邀请码';

  @override
  String get inviteCodeHint => '邀请码已内置，通常无需修改';

  @override
  String get agreeTermsFirst => '请先阅读并同意服务协议和隐私政策';

  @override
  String get iAgree => '我已阅读并同意';

  @override
  String get alreadyHaveAccount => '已有账号？';

  @override
  String get loginNow => '立即登录';

  @override
  String get whoCanSee => '谁可以查看';

  @override
  String get avatar => '头像';

  @override
  String get status => '状态';

  @override
  String get lastSeen => '最后上线时间';

  @override
  String get messageSettings => '消息';

  @override
  String get allowStrangerMessage => '允许陌生人私聊';

  @override
  String get receiveNonContact => '接收非联系人的消息';

  @override
  String get readReceipts => '已读回执';

  @override
  String get letOthersKnowRead => '让对方知道你已阅读消息';

  @override
  String get typingStatus => '输入状态';

  @override
  String get letOthersKnowTyping => '让对方知道你正在输入';

  @override
  String get everyone => '所有人';

  @override
  String get contactsOnly => '仅联系人';

  @override
  String get nobody => '无人';

  @override
  String whoCanSeeItem(String title) {
    return '谁可以查看$title';
  }

  @override
  String version(String version) {
    return '版本 $version';
  }

  @override
  String get checkUpdate => '检查更新';

  @override
  String get openSourceLicenses => '开源许可';

  @override
  String get feedback => '反馈与建议';

  @override
  String get builtOnMatrix => '基于 Matrix 协议构建';

  @override
  String get loading => '加载中...';

  @override
  String get noConversations => '暂无会话';

  @override
  String get tapToChat => '点击右上角开始聊天';

  @override
  String get startGroup => '发起群聊';

  @override
  String get scan => '扫一扫';

  @override
  String get payment => '收付款';

  @override
  String featureComingSoon(String feature) {
    return '$feature 功能即将推出';
  }

  @override
  String get markAsRead => '标记已读';

  @override
  String get unmute => '取消免打扰';

  @override
  String get mute => '消息免打扰';

  @override
  String get unpin => '取消置顶';

  @override
  String get pin => '置顶';

  @override
  String get deleteConversation => '删除会话';

  @override
  String deleteConversationConfirm(String name) {
    return '确定要删除与 $name 的会话吗？';
  }

  @override
  String get noContacts => '暂无联系人';

  @override
  String get addFriendsToChat => '添加好友开始聊天';

  @override
  String get contactNotFound => '未找到联系人';

  @override
  String get tryOtherKeywords => '尝试搜索其他关键词或全局搜索';

  @override
  String get searchResults => '搜索结果';

  @override
  String get newFriends => '新的朋友';

  @override
  String get chatOnlyFriends => '仅聊天的朋友';

  @override
  String get officialAccounts => '公众号';

  @override
  String get serviceAccounts => '服务号';

  @override
  String get enterpriseContacts => '企业联系人';

  @override
  String contactsCount(int count) {
    return '$count位联系人';
  }

  @override
  String get recommendToFriend => '推荐给朋友';

  @override
  String get setRemark => '设置备注';

  @override
  String get addToHome => '添加到桌面';

  @override
  String get sendingCard => '正在发送名片...';

  @override
  String get contactCard => '[名片]';

  @override
  String cardSent(String contact, String friend) {
    return '已将 $contact 的名片推荐给 $friend';
  }

  @override
  String recommendFailed(String error) {
    return '推荐失败: $error';
  }

  @override
  String get enterRemark => '请输入备注名';

  @override
  String remarkSet(String remark) {
    return '已设置备注为: $remark';
  }

  @override
  String get openingChat => '正在打开聊天...';

  @override
  String openChatFailed(String error) {
    return '打开聊天失败: $error';
  }

  @override
  String get addContact => '添加联系人';

  @override
  String get enterUserId => '输入用户ID';

  @override
  String get noFriendRequests => '暂无好友请求';

  @override
  String get accept => '接受';

  @override
  String get reject => '拒绝';

  @override
  String acceptedRequest(String name) {
    return '已接受 $name 的好友请求';
  }

  @override
  String rejectedRequest(String name) {
    return '已拒绝 $name 的好友请求';
  }

  @override
  String get noGroups => '暂无群聊';

  @override
  String get creatingGroup => '创建群聊功能开发中...';

  @override
  String get selectFriendToRecommend => '选择要推荐给的朋友';

  @override
  String get searchContacts => '搜索联系人';

  @override
  String get noContactsFound => '没有找到联系人';

  @override
  String get yesterday => '昨天';

  @override
  String get monday => '周一';

  @override
  String get tuesday => '周二';

  @override
  String get wednesday => '周三';

  @override
  String get thursday => '周四';

  @override
  String get friday => '周五';

  @override
  String get saturday => '周六';

  @override
  String get sunday => '周日';

  @override
  String get justNow => '刚刚';

  @override
  String minutesAgo(int count) {
    return '$count分钟前';
  }

  @override
  String hoursAgo(int count) {
    return '$count小时前';
  }

  @override
  String daysAgo(int count) {
    return '$count天前';
  }

  @override
  String get online => '在线';

  @override
  String get offline => '离线';

  @override
  String minutesAgoOnline(int count) {
    return '$count分钟前在线';
  }

  @override
  String hoursAgoOnline(int count) {
    return '$count小时前在线';
  }

  @override
  String daysAgoOnline(int count) {
    return '$count天前在线';
  }

  @override
  String get searchContactsGroupsMessages => '搜索联系人、群聊和消息';

  @override
  String get searchError => '搜索出错';

  @override
  String get searchHint => '搜索联系人、群聊和消息';

  @override
  String get enterKeyword => '输入关键词开始搜索';

  @override
  String get searchHistory => '搜索历史';

  @override
  String get clear => '清除';

  @override
  String noResultsFor(String query) {
    return '没有找到 $query 相关的结果';
  }

  @override
  String get all => '全部';

  @override
  String get groups => '群聊';

  @override
  String get noResults => '无结果';

  @override
  String get groupInfo => '群聊资料';

  @override
  String groupMembers(int count) {
    return '群成员 ($count)';
  }

  @override
  String get viewAll => '查看全部';

  @override
  String get owner => '群主';

  @override
  String get admin => '管理';

  @override
  String get invite => '邀请';

  @override
  String get groupAnnouncement => '群公告';

  @override
  String get notSet => '未设置';

  @override
  String get groupDescription => '群简介';

  @override
  String get publicGroup => '公开群聊';

  @override
  String get allowSearchJoin => '允许其他人搜索并加入';

  @override
  String get clearChatHistory => '清空聊天记录';

  @override
  String get dissolveGroup => '解散群聊';

  @override
  String get leaveGroup => '退出群聊';

  @override
  String get changeGroupName => '修改群名称';

  @override
  String get enterGroupName => '请输入群名称';

  @override
  String get confirm => '确定';

  @override
  String get changeGroupDescription => '修改群简介';

  @override
  String get enterGroupDescription => '请输入群简介';

  @override
  String get editAnnouncement => '编辑群公告';

  @override
  String get enterAnnouncement => '请输入群公告';

  @override
  String get publish => '发布';

  @override
  String get clearHistoryConfirm => '确定要清空聊天记录吗？此操作不可恢复。';

  @override
  String get clearAction => '清空';

  @override
  String get chatHistoryCleared => '聊天记录已清空';

  @override
  String leaveGroupConfirm(String name) {
    return '确定要退出 $name 吗？';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return '确定要解散 $name 吗？此操作不可恢复。';
  }

  @override
  String get dissolve => '解散';

  @override
  String get groupQrCode => '群二维码';

  @override
  String get searchChatHistory => '查找聊天记录';

  @override
  String get groupIdCopied => '群ID已复制';

  @override
  String tapCopyGroupId(int count) {
    return '$count人 · 点击复制群ID';
  }

  @override
  String featureInDevelopment(Object feature) {
    return '$feature功能开发中...';
  }

  @override
  String get receiverAddress => '收款地址';

  @override
  String get enterOrPasteAddress => '输入或粘贴钱包地址';

  @override
  String get selectToken => '选择代币';

  @override
  String get transferAmount => '转账金额';

  @override
  String get available => '可用';

  @override
  String get allAmount => '全部';

  @override
  String get memoOptional => '备注（可选）';

  @override
  String get addMemo => '添加备注信息';

  @override
  String get confirmTransfer => '确认转账';

  @override
  String get invalidAddress => '请输入有效的收款地址';

  @override
  String get invalidAmount => '请输入有效的转账金额';

  @override
  String get selectTokenPlease => '请选择代币';

  @override
  String get addressVerified => '地址已验证';

  @override
  String availableBalance(String balance, String symbol) {
    return '可用余额: $balance $symbol';
  }

  @override
  String get scanningInDevelopment => '扫描功能开发中...';

  @override
  String get enterAmount => '请输入金额';

  @override
  String get redPacketCountMin => '红包个数至少为1';

  @override
  String get viewRedPacketDetails => '查看红包详情';

  @override
  String get enterTransferAmount => '请输入转账金额';

  @override
  String get transferTo => '转账给';

  @override
  String get selectCurrency => '选择币种';

  @override
  String get receiveTransfer => '收到转账';

  @override
  String fromSender(String name) {
    return '来自 $name';
  }

  @override
  String get confirmReceive => '确认收款';

  @override
  String get groupProfile => '群资料';

  @override
  String get viewProfile => '查看资料';

  @override
  String get removeMember => '移出群聊';

  @override
  String removeMemberConfirm(String name) {
    return '确定要将 $name 移出群聊吗？';
  }

  @override
  String get remove => '移出';

  @override
  String get clearStatus => '清除状态';

  @override
  String get clearStatusConfirm => '确定要清除当前状态吗？';

  @override
  String get statusCleared => '状态已清除';

  @override
  String statusSet(String result) {
    return '状态已设置为：$result';
  }

  @override
  String get userNotExist => '用户不存在';

  @override
  String get userIdCopied => '用户ID已复制';

  @override
  String get voiceCallInDevelopment => '语音通话功能开发中...';

  @override
  String get report => '举报';

  @override
  String get reportInDevelopment => '举报功能开发中...';

  @override
  String get shareCard => '分享名片';

  @override
  String get shareInDevelopment => '分享功能开发中...';

  @override
  String get qrCode => '二维码';

  @override
  String get qrCodeInDevelopment => '二维码功能开发中...';

  @override
  String get avatarUpdated => '头像更新成功';

  @override
  String selectImageFailed(String error) {
    return '选择图片失败: $error';
  }

  @override
  String get changeName => '修改名字';

  @override
  String get male => '男';

  @override
  String get female => '女';

  @override
  String genderSet(String gender) {
    return '性别已设置为: $gender';
  }

  @override
  String regionSet(String region) {
    return '地区已设置为: $region';
  }

  @override
  String get setPatText => '设置拍一拍';

  @override
  String get changeSignature => '修改签名';

  @override
  String ringtoneSet(String result) {
    return '来电铃声已设置为: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature功能开发中...';
  }

  @override
  String saveAddressFailed(String error) {
    return '保存地址失败: $error';
  }

  @override
  String get myAddress => '我的地址';

  @override
  String get addNew => '新增';

  @override
  String get addAddress => '添加地址';

  @override
  String get addressAdded => '地址添加成功';

  @override
  String get addressUpdated => '地址更新成功';

  @override
  String get deleteAddress => '删除地址';

  @override
  String get deleteAddressConfirm => '确定要删除这个地址吗？';

  @override
  String get addressDeleted => '地址已删除';

  @override
  String get setDefaultAddress => '设为默认地址';

  @override
  String get fillCompleteInfo => '请填写完整信息';

  @override
  String saveInvoiceFailed(String error) {
    return '保存发票抬头失败: $error';
  }

  @override
  String get myInvoices => '我的发票抬头';

  @override
  String get addInvoice => '添加发票抬头';

  @override
  String get invoiceAdded => '发票抬头添加成功';

  @override
  String get invoiceUpdated => '发票抬头更新成功';

  @override
  String get deleteInvoice => '删除发票抬头';

  @override
  String get deleteInvoiceConfirm => '确定要删除这个发票抬头吗？';

  @override
  String get invoiceDeleted => '发票抬头已删除';

  @override
  String get invoiceType => '抬头类型';

  @override
  String get personal => '个人';

  @override
  String get enterprise => '企业';

  @override
  String get setDefaultInvoice => '设为默认抬头';

  @override
  String get enterTaxId => '请输入纳税人识别号';

  @override
  String get vibrateMode => '振动模式';

  @override
  String get silentMode => '静音模式';

  @override
  String playing(String ringtoneName) {
    return '正在播放: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return '播放失败: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => '请输入群名称';

  @override
  String get selectAtLeastOne => '请至少选择一位成员';

  @override
  String get fillStatus => '填写状态';

  @override
  String get fileNotExist => '文件不存在';

  @override
  String sendFailed(String error) {
    return '发送失败: $error';
  }

  @override
  String get cannotOpenBrowser => '无法打开浏览器';

  @override
  String selectFileFailed(String error) {
    return '选择文件失败: $error';
  }

  @override
  String get enterMusicLink => '请输入音乐链接';

  @override
  String get enterValidLink => '请输入有效的网络链接';

  @override
  String get enterPollQuestion => '请输入投票问题';

  @override
  String get minTwoOptions => '至少需要2个选项';

  @override
  String get crossDeviceEnabled => '跨设备签名已启用';

  @override
  String get crossDeviceSet => '跨设备签名设置成功';

  @override
  String setupFailed(String error) {
    return '设置失败: $error';
  }

  @override
  String get receiveAmount => '收款金额';

  @override
  String get enterValidAmount => '请输入有效的转账金额';

  @override
  String get addressCopied => '地址已复制';

  @override
  String openItem(String content) {
    return '打开: $content';
  }

  @override
  String get newNoteComingSoon => '新建笔记功能即将推出';

  @override
  String get addLinkComingSoon => '添加链接功能即将推出';

  @override
  String get deleted => '已删除';

  @override
  String get shareComingSoon => '分享功能即将推出';

  @override
  String get saveComingSoon => '保存功能即将推出';

  @override
  String get moreStylesComingSoon => '更多样式即将推出';

  @override
  String get wallet => '钱包';

  @override
  String get walletArea => '钱包功能区域';

  @override
  String get recording => '录像';

  @override
  String get invalidVideoUrl => '视频地址无效';

  @override
  String get downloadFile => '下载文件';

  @override
  String get clearChatHistoryTitle => '清空聊天记录';

  @override
  String get cannotUndo => '此操作不可恢复';

  @override
  String get videoCall => '视频通话';

  @override
  String get voiceCall => '语音通话';

  @override
  String get leaveMeeting => '离开会议';

  @override
  String get chatDetails => '聊天详情';

  @override
  String get viewAllGroupMembers => '查看全部群成员';

  @override
  String get groupName => '群聊名称';

  @override
  String get groupNameUpdated => '群名称已更新';

  @override
  String get updateFailed => '更新失败';

  @override
  String get noPermissionToModify => '您没有修改权限';

  @override
  String get groupManagement => '群管理';

  @override
  String get myNicknameInGroup => '我在本群的昵称';

  @override
  String get pinChat => '置顶聊天';

  @override
  String get strongReminder => '强提醒';

  @override
  String get setChatBackground => '设置当前聊天背景';

  @override
  String get unknownFile => '未知文件';

  @override
  String get download => '下载';

  @override
  String get invalidLocation => '位置信息无效';

  @override
  String get address => '地址';

  @override
  String get latitude => '纬度';

  @override
  String get longitude => '经度';

  @override
  String get close => '关闭';

  @override
  String get tapToCancel => '点击取消';

  @override
  String captureFailed(Object error) {
    return '拍摄失败: $error';
  }

  @override
  String get processingVideo => '正在处理视频...';

  @override
  String get videoFileNotExist => '视频文件不存在';

  @override
  String get videoDataEmpty => '视频数据为空';

  @override
  String get videoTooLarge => '视频大小不能超过 100MB';

  @override
  String get sendingVideo => '视频发送中...';

  @override
  String sendVideoFailed(Object error) {
    return '发送视频失败: $error';
  }

  @override
  String get imageFileNotExist => '图片文件不存在';

  @override
  String get imageDataEmpty => '图片数据为空';

  @override
  String get sendingImage => '图片发送中...';

  @override
  String sendImageFailed(Object error) {
    return '发送图片失败: $error';
  }

  @override
  String get sendLocation => '发送位置';

  @override
  String get selectLocationAndSend => '选择地点并发送给对方';

  @override
  String get shareRealTimeLocation => '共享实时位置';

  @override
  String get shareLocationForOneHour => '与好友共享1小时实时位置';

  @override
  String get locationSent => '位置发送成功';

  @override
  String get selectMessages => '多选';

  @override
  String selectedCount(Object count) {
    return '已选择 $count 条';
  }

  @override
  String get selectAll => '全选';

  @override
  String groupChatCount(Object count) {
    return '群聊($count)';
  }

  @override
  String get privateChat => '私聊';

  @override
  String get noMessages => '暂无消息';

  @override
  String get sendFirstMessage => '发送第一条消息开始聊天';

  @override
  String get encryptionNotice => '本聊天已开启端对端加密保护，只有您和对方可以读取消息内容';

  @override
  String replyTo(Object name) {
    return '回复 $name';
  }

  @override
  String get multiForward => '转发';

  @override
  String get collect => '收藏';

  @override
  String get noMembers => '暂无成员';

  @override
  String get memberNotFound => '未找到成员';

  @override
  String get voiceFileNotExist => '语音文件不存在';

  @override
  String get voiceFileEmpty => '语音文件为空';

  @override
  String get sendingVoice => '语音发送中...';

  @override
  String sendVoiceFailed(Object error) {
    return '发送语音失败: $error';
  }

  @override
  String get messageCopied => '消息已复制';

  @override
  String get messageForwarded => '消息已转发';

  @override
  String forwardFailed(Object error) {
    return '转发失败: $error';
  }

  @override
  String get unfavorited => '已取消收藏';

  @override
  String get favorited => '已收藏';

  @override
  String get reactionAdded => '已添加表情回应';

  @override
  String get failedMessageDeleted => '已删除失败消息';

  @override
  String get deleteMessages => '删除消息';

  @override
  String deleteMessagesConfirm(Object count) {
    return '确定要删除 $count 条消息吗？';
  }

  @override
  String noteOtherMessages(Object count) {
    return '注意：$count 条消息是他人发送的，只能在本地删除。';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '$count 条自己发送的消息将被撤回。';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return '已撤回 $count 条消息，本地删除 $localCount 条';
  }

  @override
  String recalledMessages(Object count) {
    return '已撤回 $count 条消息';
  }

  @override
  String deletedLocally(Object count) {
    return '已删除 $count 条消息（仅本地）';
  }

  @override
  String forwardedCount(Object count) {
    return '已转发 $count 条消息';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return '转发完成：成功 $success 条，失败 $failed 条';
  }

  @override
  String get remindOnlyInGroup => '提醒功能仅在群聊中可用';

  @override
  String get onlyTextSearchable => '仅支持搜索文本消息';

  @override
  String searchFor(Object text) {
    return '搜索 \"$text\"';
  }

  @override
  String get baiduSearch => '百度搜索';

  @override
  String get googleSearch => 'Google 搜索';

  @override
  String get bingSearch => '必应搜索';

  @override
  String get calling => '呼叫中...';

  @override
  String get connecting => '正在连接...';

  @override
  String get ringing => '响铃中...';

  @override
  String get inCall => '通话中';

  @override
  String collectMessages(Object count) {
    return '已收藏 $count 条消息';
  }

  @override
  String get voted => '已投票';

  @override
  String get voteChanged => '已更改投票';

  @override
  String get voteRemoved => '已取消投票';

  @override
  String get endPoll => '结束投票';

  @override
  String get endPollConfirm => '确定要结束这个投票吗？结束后将无法继续投票。';

  @override
  String memberCount(Object count) {
    return '$count人';
  }

  @override
  String get videoChannels => '视频号';

  @override
  String get live => '直播';

  @override
  String get listen => '听一听';

  @override
  String get watch => '看一看';

  @override
  String get searchDiscover => '搜一搜';

  @override
  String get nearbyPeople => '附近的人';

  @override
  String get games => '游戏';

  @override
  String get miniPrograms => '小程序';

  @override
  String done(int count) {
    return '完成($count)';
  }

  @override
  String get services => '服务';

  @override
  String get favorites => '收藏';

  @override
  String get ordersAndCards => '订单卡券';

  @override
  String get stickers => '表情';

  @override
  String statusSetTo(String status) {
    return '状态已设置为：$status';
  }

  @override
  String get avatarUploadFailed => '头像上传失败';

  @override
  String get personalProfile => '个人信息';

  @override
  String get name => '名字';

  @override
  String get gender => '性别';

  @override
  String get region => '地区';

  @override
  String get myQrCode => '我的二维码';

  @override
  String get poke => '拍一拍';

  @override
  String get ringtone => '来电铃声';

  @override
  String get defaultRingtone => '默认铃声';

  @override
  String get myAddresses => '我的地址';

  @override
  String genderSetTo(String gender) {
    return '性别已设置为：$gender';
  }

  @override
  String get selectRegion => '选择地区';

  @override
  String get selectCity => '选择城市';

  @override
  String regionSetTo(String region) {
    return '地区已设置为：$region';
  }

  @override
  String get setPoke => '设置拍一拍';

  @override
  String get friendPokedMe => '朋友拍了拍我';

  @override
  String get enterPokeSuffix => '输入拍一拍后缀，如：的肩膀';

  @override
  String get example => '示例';

  @override
  String get onTheShoulder => '的肩膀';

  @override
  String get pokeCleared => '拍一拍已清除';

  @override
  String pokeSetTo(String suffix) {
    return '拍一拍已设置为：拍了拍我$suffix';
  }

  @override
  String get editSignature => '编辑个性签名';

  @override
  String get introduceYourself => '一句话介绍自己';

  @override
  String get signatureCleared => '个性签名已清除';

  @override
  String get signatureUpdated => '个性签名已更新';

  @override
  String get scanToAddFriend => '扫一扫上面的二维码图案，加我为好友';

  @override
  String ringtoneSetTo(String ringtone) {
    return '来电铃声已设置为：$ringtone';
  }

  @override
  String get confirmDissolveGroup => '确定要解散群聊';

  @override
  String get enterValidServerAddress => '请输入有效的服务器地址';

  @override
  String get emailOtp => '邮箱验证码';

  @override
  String get enterServerAddressFirst => '请先输入服务器地址';

  @override
  String get passkeyRequiresServer => 'Passkey登录需要服务器支持';

  @override
  String get loginAgreement => '登录即表示同意';

  @override
  String get pleaseAgreeToTerms => '请先阅读并同意服务协议和隐私政策';

  @override
  String get registerFailed => '注册失败';

  @override
  String get reenterPassword => '请再次输入密码';

  @override
  String get passwordsDoNotMatch => '两次输入的密码不一致';

  @override
  String get inviteCodeBuiltIn => '邀请码（已内置）';

  @override
  String get inviteCodeBuiltInNote => '邀请码已内置，通常无需修改';

  @override
  String get iHaveReadAndAgree => '我已阅读并同意';

  @override
  String get startGroupChat => '发起群聊';

  @override
  String get addFriends => '添加朋友';

  @override
  String get paymentAndCollection => '收付款';

  @override
  String messagesWithCount(int count) {
    return '消息($count)';
  }

  @override
  String contactCount(int count) {
    return '$count位联系人';
  }

  @override
  String get addToHomeScreen => '添加到桌面';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return '已将$contact的名片推荐给$recipient';
  }

  @override
  String get enterRemarkName => '请输入备注名';

  @override
  String remarkSetTo(String remark) {
    return '备注已设置为：$remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return '已接受$name的好友请求';
  }

  @override
  String rejectedFriendRequest(String name) {
    return '已拒绝$name的好友请求';
  }

  @override
  String get groupInvites => '群邀请';

  @override
  String get myGroups => '我的群聊';

  @override
  String get invitedToJoinGroup => '邀请加入群聊';

  @override
  String get confirmLeaveGroup => '确定要退出';

  @override
  String get leave => '退出';

  @override
  String get saveMedia => '保存';

  @override
  String get recallThisMessage => '撤回该条消息？';

  @override
  String get messageRecalled => '对方撤回了一条消息';

  @override
  String get savedToGallery => '已保存到相册';

  @override
  String get failedToSave => '保存失败';

  @override
  String get saving => '保存中...';

  @override
  String get share => '分享';

  @override
  String get saveToGallery => '保存到相册';

  @override
  String get downloadFailed => '下载失败';

  @override
  String get noMediaUrl => '没有可用的媒体链接';

  @override
  String get shareFailed => '分享失败';

  @override
  String get failedToLoadImage => '图片加载失败';

  @override
  String get failedToLoadMoreMessages => '加载更多消息失败';

  @override
  String get failedToSend => '发送失败';

  @override
  String get failedToSendImage => '发送图片失败';

  @override
  String get failedToSendVoice => '发送语音失败';

  @override
  String get failedToSendFile => '发送文件失败';

  @override
  String get failedToSendVideo => '发送视频失败';

  @override
  String get failedToSendLocation => '发送位置失败';

  @override
  String get failedToResend => '重发失败';

  @override
  String get failedToRecall => '撤回失败';

  @override
  String get failedToReply => '回复失败';

  @override
  String get failedToAddReaction => '添加回应失败';

  @override
  String get failedToSendPoll => '发送投票失败';

  @override
  String get failedToVote => '投票失败';

  @override
  String get failedToLoadMessages => '加载消息失败';

  @override
  String get callFeatureComingSoon => '语音和视频通话功能即将上线';

  @override
  String get cannotForwardRedPacketOrTransfer => '红包和转账不能转发';

  @override
  String get videoRecordingFailed => '视频录制失败，请重试';

  @override
  String get redPacket => '红包';

  @override
  String get music => '音乐';

  @override
  String get coupon => '卡券';

  @override
  String get gift => '礼物';

  @override
  String get poll => '投票';

  @override
  String get text => '文本';

  @override
  String get link => '链接';

  @override
  String get note => '笔记';

  @override
  String get myNotes => '我的笔记';

  @override
  String get today => '今天';

  @override
  String daysAgoText(int count) {
    return '$count天前';
  }

  @override
  String dateFormat(int month, int day) {
    return '$month月$day日';
  }

  @override
  String get noFavorites => '暂无收藏';

  @override
  String get longPressToFavorite => '长按消息进行收藏';

  @override
  String get newNote => '新建笔记';

  @override
  String get favoriteLink => '收藏链接';

  @override
  String get editTags => '编辑标签';

  @override
  String get deleteFavorite => '删除收藏';

  @override
  String get deleteFavoriteConfirm => '确定要删除这条收藏吗？';

  @override
  String get noSearchResultsFound => '没有找到结果';

  @override
  String get sendRedPacket => '发红包';

  @override
  String get amount => '金额';

  @override
  String get redPacketCover => '红包封面';

  @override
  String get redPacketType => '红包类型';

  @override
  String get normalRedPacket => '普通红包';

  @override
  String get luckyRedPacket => '拼手气';

  @override
  String get redPacketCount => '红包个数';

  @override
  String get pieces => '个';

  @override
  String get putMoneyInRedPacket => '塞钱进红包';

  @override
  String get redPacketRefundNotice => '未领取的红包，将于24小时后发起退款';

  @override
  String get openRedPacket => '開';

  @override
  String get redPacketAllClaimed => '红包已被领完';

  @override
  String get redPacketExpired => '红包已过期';

  @override
  String get addTransferNote => '添加转账说明';

  @override
  String get yuan => '元';

  @override
  String get savedToChangeCanTransfer => '已存入零钱，可直接转账';

  @override
  String get replyWithEmoji => '用此表情回复';

  @override
  String get claimedYourRedPacket => '领取了你的';

  @override
  String get claimedRedPacket => '领取了';

  @override
  String get otherTyping => '对方正在输入...';

  @override
  String get processing => '处理中...';

  @override
  String get transferCancelled => '转账已取消';

  @override
  String get transferFailed => '转账失败';

  @override
  String get creatingPaymentRequest => '正在创建收款请求...';

  @override
  String get processingPayment => '正在处理支付...';

  @override
  String get paymentFailed => '支付失败';

  @override
  String get clickRetry => '点击重试';

  @override
  String get settingsTitle => '设置';

  @override
  String get editRemark => '编辑备注';

  @override
  String get setPermissions => '设置权限';

  @override
  String get recommendToFriends => '把他 (她) 推荐给朋友';

  @override
  String get setStarFriend => '设为星标朋友';

  @override
  String get addToBlacklist => '加入黑名单';

  @override
  String get complain => '投诉';

  @override
  String get deleteContact => '删除联系人';

  @override
  String deleteContactConfirm(String name) {
    return '确定要删除 $name 吗？';
  }

  @override
  String get transferTitle => '转账';

  @override
  String get receiverAddressLabel => '收款地址';

  @override
  String get selectTokenLabel => '选择代币';

  @override
  String get transferAmountLabel => '转账金额';

  @override
  String get memoLabel => '备注（可选）';

  @override
  String get enterOrPasteAddressHint => '输入或粘贴钱包地址';

  @override
  String get scanInDevelopment => '扫描功能开发中...';

  @override
  String get availableLabel => '可用';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return '可用余额: $balance $symbol';
  }

  @override
  String get addMemoHint => '添加备注信息';

  @override
  String get receiveTitle => '收款';

  @override
  String get walletNotConnectedTitle => '钱包未连接';

  @override
  String get connectWalletFirst => '请先连接钱包';

  @override
  String get sendPaymentRequest => '发送收款请求';

  @override
  String get qrCodeGenerateFailed => '二维码生成失败';

  @override
  String get scanQrToPayMe => '扫描二维码向我付款';

  @override
  String get myWalletAddress => '我的钱包地址';

  @override
  String get createPaymentRequest => '创建收款请求';

  @override
  String get selectTokenHint => '选择代币';

  @override
  String get amountLabel => '金额';

  @override
  String get cancelButton => '取消';

  @override
  String get sendRequestButton => '发送请求';

  @override
  String get allReadReceipt => '全部已读';

  @override
  String readCountReceipt(int count) {
    return '$count人已读';
  }

  @override
  String n42IdLabel(String id) {
    return 'N42号：$id';
  }

  @override
  String get redPacketDefaultGreeting => '恭喜发财，大吉大利';

  @override
  String senderRedPacket(String name) {
    return '$name的红包';
  }

  @override
  String get allButton => '全部';

  @override
  String get enterValidAddress => '请输入有效的收款地址';

  @override
  String get pleaseSelectToken => '请选择代币';

  @override
  String get receivedTransfer => '收到转账';

  @override
  String get selectForwardRecipient => '选择转发对象';

  @override
  String get emojiFaces => '表情';

  @override
  String get emojiHearts => '爱心';

  @override
  String get emojiAnimals => '动物';

  @override
  String get emojiFood => '食物';

  @override
  String get emojiTransport => '交通';

  @override
  String get emojiActivities => '活动';

  @override
  String get emojiObjects => '物品';

  @override
  String get emojiSymbols => '符号';

  @override
  String get transferProcessing => '正在处理转账...';

  @override
  String senderSentRedPacket(String name) {
    return '$name发出的红包';
  }

  @override
  String get savedToBalance => '已存入零钱，可直接转账';

  @override
  String get redPacketExpiredOrEmpty => '红包已过期/已领完';

  @override
  String get scanFeatureComingSoon => '扫描功能开发中...';

  @override
  String get setAsStarred => '设为星标朋友';

  @override
  String get addToBlocklist => '加入黑名单';

  @override
  String get claimedYour => '领取了你的';

  @override
  String get claimedText => '领取了';

  @override
  String userTyping(String name) {
    return '$name正在输入...';
  }

  @override
  String get typing => '对方正在输入...';

  @override
  String get waitingToReceive => '待对方接收';

  @override
  String get tapToClaim => '点击领取';

  @override
  String get hasBeenReceived => '已被接收';

  @override
  String get getLucky => '领个好彩头';

  @override
  String get cameraStartFailed => '相机启动失败';

  @override
  String get unknownError => '未知错误';

  @override
  String get placeQrCodeInFrame => '将二维码放入框内扫描';

  @override
  String get closeManualInput => '关闭手动输入';

  @override
  String get manualInputUserId => '手动输入用户ID';

  @override
  String get add => '加入';

  @override
  String get ringtoneClear => '清脆';

  @override
  String get ringtonePhone => '电话';

  @override
  String get ringtoneClassic => '经典';

  @override
  String get ringtoneSoft => '柔和';

  @override
  String get ringtoneVibrate => '震动';

  @override
  String get ringtoneSilent => '静音';

  @override
  String get stop => '停止';

  @override
  String get selectRingtone => '选择铃声';

  @override
  String get loadingRingtones => '加载铃声中...';

  @override
  String get noRingtonesFound => '未找到铃声';

  @override
  String get moodAndThoughts => '心情想法';

  @override
  String get statusHappy => '开心';

  @override
  String get statusCracked => '裂开';

  @override
  String get statusLucky => '发呆';

  @override
  String get statusSunny => '天气晴';

  @override
  String get statusTired => '累了';

  @override
  String get statusDaydream => '发呆中';

  @override
  String get statusRushing => '忙碌';

  @override
  String get statusOverthinking => '想太多';

  @override
  String get statusEnergized => '元气满满';

  @override
  String get workAndStudy => '工作学习';

  @override
  String get statusWorking => '搬砖中';

  @override
  String get statusStudying => '学习中';

  @override
  String get statusBusy => '忙';

  @override
  String get statusSlacking => '摸鱼中';

  @override
  String get statusTraveling => '旅行中';

  @override
  String get statusGoingHome => '回家中';

  @override
  String get statusDnd => '请勿打扰';

  @override
  String get statusHanging => '出去浪';

  @override
  String get statusCheckIn => '打卡';

  @override
  String get statusExercising => '运动中';

  @override
  String get statusCoffee => '喝咖啡';

  @override
  String get statusBubbleTea => '奶茶';

  @override
  String get statusEating => '干饭中';

  @override
  String get statusParenting => '带娃中';

  @override
  String get statusSavingWorld => '拯救世界';

  @override
  String get statusSelfie => '自拍';

  @override
  String get rest => '休息';

  @override
  String get statusRetreat => '闭关';

  @override
  String get statusHome => '宅家';

  @override
  String get statusSleeping => '睡觉中';

  @override
  String get statusCatLover => '吸猫中';

  @override
  String get statusDogWalking => '遛狗中';

  @override
  String get statusGaming => '游戏中';

  @override
  String get statusListening => '听歌中';

  @override
  String get setStatus => '设置状态';

  @override
  String get visibleToFriends24h => '可被好友看到，24小时后自动清除';

  @override
  String get writeStatus => '写状态';

  @override
  String get enterYourStatus => '输入你的状态...';

  @override
  String get ok => '确定';

  @override
  String get cameraPermissionRequired => '扫描二维码需要相机权限';

  @override
  String get cameraPermissionDenied => '相机权限已被永久拒绝，请在系统设置中开启。';

  @override
  String get cannotGetCameraPermission => '无法获取相机权限';

  @override
  String permissionCheckError(String error) {
    return '检查权限时出错: $error';
  }

  @override
  String get invalidQrCode => '无效的二维码';

  @override
  String qrCodeProcessFailed(String error) {
    return '处理二维码失败: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return '无法添加好友: $error';
  }

  @override
  String get scanQrCode => '扫描二维码';

  @override
  String get checkingCameraPermission => '正在检查相机权限...';

  @override
  String get needCameraPermission => '需要相机权限';

  @override
  String get retryPermission => '重试';

  @override
  String get openSettings => '打开设置';

  @override
  String get inviteMembers => '邀请成员';

  @override
  String inviteCount(int count) {
    return '邀请($count)';
  }

  @override
  String get noShippingAddress => '暂无收货地址';

  @override
  String get defaultLabel => '默认';

  @override
  String get editAddress => '编辑地址';

  @override
  String get recipient => '收货人';

  @override
  String get enterRecipientName => '请输入收货人姓名';

  @override
  String get phoneNumber => '手机号码';

  @override
  String get enterPhoneNumber => '请输入手机号码';

  @override
  String get regionHint => '省/市/区';

  @override
  String get detailedAddress => '详细地址';

  @override
  String get detailedAddressHint => '街道、门牌号等';

  @override
  String get setAsDefaultAddress => '设为默认地址';

  @override
  String get pleaseCompleteInfo => '请填写完整信息';

  @override
  String get noInvoice => '暂无发票抬头';

  @override
  String get company => '企业';

  @override
  String get taxNumber => '税号';

  @override
  String get editInvoice => '编辑发票抬头';

  @override
  String get companyName => '企业名称';

  @override
  String get enterCompanyName => '请输入企业名称';

  @override
  String get personalName => '个人姓名';

  @override
  String get enterName => '请输入姓名';

  @override
  String get taxIdNumber => '纳税人识别号';

  @override
  String get enterTaxIdNumber => '请输入纳税人识别号';

  @override
  String get bankNameOptional => '开户银行（选填）';

  @override
  String get enterBankName => '请输入开户银行';

  @override
  String get bankAccountOptional => '银行账号（选填）';

  @override
  String get enterBankAccount => '请输入银行账号';

  @override
  String get companyAddressOptional => '企业地址（选填）';

  @override
  String get enterCompanyAddress => '请输入企业地址';

  @override
  String get companyPhoneOptional => '企业电话（选填）';

  @override
  String get enterCompanyPhone => '请输入企业电话';

  @override
  String get setAsDefaultInvoice => '设为默认抬头';

  @override
  String get confirmDeleteAddress => '确定要删除这个地址吗？';

  @override
  String get confirmDeleteInvoice => '确定要删除这个发票抬头吗？';

  @override
  String get groupOwner => '群主';

  @override
  String get groupAdmin => '管理员';

  @override
  String get searchMembers => '搜索成员';

  @override
  String totalMembers(int count) {
    return '$count位成员';
  }

  @override
  String get removeFromGroup => '移出群聊';

  @override
  String confirmRemoveMember(String name) {
    return '确定要将\"$name\"移出群聊吗？';
  }

  @override
  String get setAsAdmin => '设为管理员';

  @override
  String get removeAdmin => '取消管理员';

  @override
  String get deleteContactSuccess => '联系人已删除';

  @override
  String get unknownSong => '未知歌曲';

  @override
  String get unknownArtist => '未知艺术家';

  @override
  String get unknownContact => '未知联系人';

  @override
  String get personalCard => '个人名片';

  @override
  String get singleChoice => '单选';

  @override
  String get multiChoice => '多选';

  @override
  String get ended => '已结束';

  @override
  String get endPollButton => '结束投票';

  @override
  String get createPoll => '创建投票';

  @override
  String get pollQuestion => '投票问题';

  @override
  String get pollOptions => '投票选项';

  @override
  String optionPlaceholder(int index) {
    return '选项 $index';
  }

  @override
  String get addOption => '添加选项';

  @override
  String get pollSettings => '投票设置';

  @override
  String get anonymousPoll => '匿名投票';

  @override
  String get pollHint => '投票发起后将显示在聊天中，群成员可以参与投票';

  @override
  String get searchSongOrArtist => '搜索歌曲或歌手';

  @override
  String get noSongsFound => '没有找到歌曲';

  @override
  String get supportedMusicPlatforms => '支持网易云、QQ音乐、酷狗、酷我等平台的歌曲链接';

  @override
  String get songNameOptional => '歌曲名称（可选）';

  @override
  String get enterSongName => '输入歌曲名称';

  @override
  String get artistNameOptional => '歌手名称（可选）';

  @override
  String get enterArtistName => '输入歌手名称';

  @override
  String get shareSong => '分享歌曲';

  @override
  String get realTimeLocationSharing => '实时位置共享功能开发中...';

  @override
  String get voiceCallFeatureInDev => '语音通话功能开发中...';

  @override
  String get reportFeatureInDev => '举报功能开发中...';

  @override
  String get shareFeatureInDev => '分享功能开发中...';

  @override
  String get qrCodeFeatureInDev => '二维码功能开发中...';

  @override
  String get scanQrToAddMe => '扫一扫上面的二维码，加我为好友';

  @override
  String get saveToAlbum => '保存到相册';

  @override
  String get changeStyle => '换个样式';

  @override
  String get copyId => '复制 ID';

  @override
  String get idCopied => '已复制用户 ID';

  @override
  String get shareFeatureComingSoon => '分享功能即将推出';

  @override
  String get saveFeatureComingSoon => '保存功能即将推出';

  @override
  String get moreStylesFeatureComingSoon => '更多样式即将推出';

  @override
  String get confirmEndPoll => '确定要结束这个投票吗？';

  @override
  String get cannotVoteAfterEnd => '结束后将无法继续投票。';

  @override
  String get bio => '个性签名';

  @override
  String get homeServer => '服务器';

  @override
  String get shareContactCard => '分享名片';

  @override
  String get removeFromBlacklist => '移出黑名单';

  @override
  String get confirmAddBlacklist => '确定将该用户加入黑名单吗？你将不再收到对方的消息';

  @override
  String get confirmRemoveBlacklist => '确定将该用户移出黑名单吗？';

  @override
  String get remarkSaved => '备注已保存';

  @override
  String get remarkCleared => '已清除备注';

  @override
  String get receive => '收款';

  @override
  String get pleaseConnectWallet => '请先连接钱包';

  @override
  String get sendRequest => '发送请求';

  @override
  String get pleaseEnterValidAmount => '请输入有效的金额';

  @override
  String get searchPlaceholder => '搜索联系人、群聊、消息';

  @override
  String get enterKeywordToSearch => '输入关键词开始搜索';

  @override
  String get clearHistory => '清除';

  @override
  String noResultsForQuery(String query) {
    return '没有找到\"$query\"相关的结果';
  }

  @override
  String get allResults => '全部';

  @override
  String get searchInChat => '在聊天中搜索';

  @override
  String get groupLabel => '群聊';

  @override
  String get messageLabel => '消息';
}
