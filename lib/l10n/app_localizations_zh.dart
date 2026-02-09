// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get commonRetry => '重试';

  @override
  String get commonUnknownUser => '未知用户';

  @override
  String get transferWalletNotConnected => '钱包未连接';

  @override
  String get chatCallServiceNotInitialized => '通话服务未初始化';

  @override
  String authLoginFailed(String error) {
    return '登录失败: $error';
  }

  @override
  String get chatCallBack => '回拨';

  @override
  String get chatMissedVideoCall => '未接视频通话';

  @override
  String get chatMissedVoiceCall => '未接语音通话';

  @override
  String get chatCallNotAnswered => '对方未接听';

  @override
  String get chatCallDurationLabel => '通话时长';

  @override
  String get chatVoiceCallCancelled => '语音通话已取消';

  @override
  String get chatVideoCallCancelled => '视频通话已取消';

  @override
  String get commonImage => '[图片]';

  @override
  String get chatVideo => '[视频]';

  @override
  String get chatVoice => '[语音]';

  @override
  String get commonFile => '[文件]';

  @override
  String get chatLocation => '[位置]';

  @override
  String get chatUnknownMessage => '[未知消息]';

  @override
  String get commonDelete => '删除';

  @override
  String get chatDeleteThisMessage => '删除这条消息？';

  @override
  String get chatMessageDeleted => '消息已删除';

  @override
  String get profileNotLoggedIn => '未登录';

  @override
  String get chatMyLocation => '我的位置';

  @override
  String get commonGroupChat => '群聊';

  @override
  String get commonSearch => '搜索';

  @override
  String get commonCancel => '取消';

  @override
  String get commonLoadFailed => '加载失败';

  @override
  String get commonMessages => '消息';

  @override
  String get commonContacts => '联系人';

  @override
  String get commonMe => '我';

  @override
  String get commonVoiceLoading => '语音加载中，请稍后再试';

  @override
  String get commonVoiceToTextFailed => '语音转文字失败';

  @override
  String get commonConvertToText => '转文字';

  @override
  String get chatCopy => '复制';

  @override
  String get commonForward => '转发';

  @override
  String get commonUnfavorite => '取消收藏';

  @override
  String get commonFavorite => '收藏';

  @override
  String get settingsResend => '重新发送';

  @override
  String get chatRecall => '撤回';

  @override
  String get commonQuote => '引用';

  @override
  String get commonRemind => '提醒';

  @override
  String get chatCopied => '已复制';

  @override
  String get storySendMessageHint => '发送消息';

  @override
  String get commonMicrophonePermissionRequired => '请允许使用麦克风权限';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return '开始录音失败: $error';
  }

  @override
  String get commonRecordingTooShort => '录音时间太短';

  @override
  String commonStopRecordingFailed(String error) {
    return '停止录音失败: $error';
  }

  @override
  String get chatReleaseToCancel => '松开取消';

  @override
  String get chatReleaseToSend => '松开发送，上滑取消';

  @override
  String get commonHoldToTalk => '按住 说话';

  @override
  String get commonSend => '发送';

  @override
  String get commonAddFriend => '添加好友';

  @override
  String get commonChatServiceNotConnected => '聊天服务未连接';

  @override
  String contactUserNotFoundHint(String query) {
    return '未找到用户 \"$query\"\n\n提示：\n• 尝试输入完整用户ID，如 @username:server.com\n• 确认用户名拼写正确';
  }

  @override
  String contactCreateChatFailed(String error) {
    return '创建会话失败: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return '搜索失败: $error';
  }

  @override
  String get contactEnterUserIdOrUsername => '输入用户 ID 或用户名搜索';

  @override
  String get contactSearching => '搜索中...';

  @override
  String get contactSearchUserToChat => '搜索用户开始聊天';

  @override
  String get contactMatrixIdExample =>
      '可以输入完整的 Matrix ID\n例如: @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return '未找到用户 \"$username\"';
  }

  @override
  String get commonChat => '聊天';

  @override
  String get commonSettings => '设置';

  @override
  String get profileEditProfile => '编辑资料';

  @override
  String get authLogin => '登录';

  @override
  String get commonCreateGroup => '创建群聊';

  @override
  String get chatError => '错误';

  @override
  String get commonTransfer => '转账';

  @override
  String get commonReceived => '已被接收';

  @override
  String get commonRefunded => '已退还';

  @override
  String get commonExpired => '已过期';

  @override
  String get chatRedPacketGreeting => '恭喜发财，大吉大利';

  @override
  String get commonN42RedPacket => 'N42红包';

  @override
  String get commonClaimed => '已领取';

  @override
  String get commonAllClaimed => '已被领完';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => '回复';

  @override
  String get commonEdit => '编辑';

  @override
  String get chatSelectForwardTarget => '选择转发对象';

  @override
  String commonSendCount(int count) {
    return '发送($count)';
  }

  @override
  String contactN42Id(String id) {
    return 'N42号：$id';
  }

  @override
  String get profileN42IdTitle => 'N42号';

  @override
  String get profileN42Bean => 'N42豆';

  @override
  String get contactFriendInfo => '朋友资料';

  @override
  String get contactFriendInfoDesc => '添加朋友的备注名、电话、标签、备忘、照片等，并设置朋友权限。';

  @override
  String get commonMoments => '朋友圈';

  @override
  String get commonSendMessage => '发消息';

  @override
  String get contactAudioVideoCall => '音视频通话';

  @override
  String get contactVideoChannel => '视频号';

  @override
  String get contactRemark => '备注';

  @override
  String get contactRemarkName => '备注名';

  @override
  String get contactPhone => '电话';

  @override
  String get contactTags => '标签';

  @override
  String get contactNotes => '备忘';

  @override
  String get contactPhotos => '照片';

  @override
  String get contactPermissions => '权限';

  @override
  String get contactChatMomentsEtc => '聊天、朋友圈、运动等';

  @override
  String get contactMoreInfo => '更多信息';

  @override
  String get contactCommonGroups => '我和他 (她) 的共同群聊';

  @override
  String get contactSource => '来源';

  @override
  String get settingsNotificationSettings => '消息通知';

  @override
  String get settingsPrivacy => '隐私';

  @override
  String get settingsAppearance => '外观';

  @override
  String get settingsAbout => '关于';

  @override
  String get commonLogout => '退出登录';

  @override
  String get commonLogoutConfirm => '确定要退出登录吗？';

  @override
  String get commonSave => '保存';

  @override
  String get profileNickname => '昵称';

  @override
  String get profileEnterNickname => '请输入昵称';

  @override
  String get profileSignature => '签名';

  @override
  String get profileAddSignature => '添加个性签名';

  @override
  String get commonTakePhoto => '拍照';

  @override
  String get profileChooseFromGallery => '从相册选择';

  @override
  String profileSaveFailed(String error) {
    return '保存失败: $error';
  }

  @override
  String get authSecureDecentralizedChat => '安全、去中心化的即时通讯';

  @override
  String get commonEndToEndEncryption => '端到端加密';

  @override
  String get authMessagesOnlyYouCanSee => '消息仅你和对方可见';

  @override
  String get authDecentralized => '去中心化';

  @override
  String get authBasedOnMatrix => '基于Matrix开放协议';

  @override
  String get authWalletIntegration => '钱包集成';

  @override
  String get authEasyCryptoTransfer => '轻松进行加密货币转账';

  @override
  String get authRegister => '注册';

  @override
  String get authAgreeTerms => '登录即表示同意';

  @override
  String get authTermsOfService => '《服务协议》';

  @override
  String get authAnd => '和';

  @override
  String get authPrivacyPolicy => '《隐私政策》';

  @override
  String get authServerAddress => '服务器地址';

  @override
  String get authEnterServerAddress => '请输入服务器地址';

  @override
  String authConnectedTo(String serverName) {
    return '已连接到 $serverName';
  }

  @override
  String get authUsername => '用户名';

  @override
  String get authEnterUsername => '请输入用户名';

  @override
  String get authPassword => '密码';

  @override
  String get authEnterPassword => '请输入密码';

  @override
  String get authRegisterAccount => '注册账号';

  @override
  String get authForgotPassword => '忘记密码';

  @override
  String get authOtherLoginMethods => '其他登录方式';

  @override
  String get authCreateAccount => '创建账号';

  @override
  String get authJoinN42Chat => '加入 N42 Chat 开始聊天';

  @override
  String get authUsernameHint => '3-20字符，字母/数字/_';

  @override
  String get authUsernameMinLength => '用户名至少3个字符';

  @override
  String get authUsernameMaxLength => '用户名最多20个字符';

  @override
  String get authUsernameFormat => '用户名只能包含字母、数字和下划线';

  @override
  String get authPasswordHint => '至少8位';

  @override
  String get commonPasswordMinLength => '密码至少8位';

  @override
  String get authConfirmPassword => '确认密码';

  @override
  String get authFilled => '已填写';

  @override
  String get authEnterInviteCode => '请输入邀请码';

  @override
  String get authAlreadyHaveAccount => '已有账号？';

  @override
  String get authLoginNow => '立即登录';

  @override
  String get profileAvatar => '头像';

  @override
  String get profileStatus => '状态';

  @override
  String get commonLoading => '加载中...';

  @override
  String get conversationNoConversations => '暂无会话';

  @override
  String get conversationTapToChat => '点击右上角开始聊天';

  @override
  String get conversationStartGroup => '发起群聊';

  @override
  String get commonScan => '扫一扫';

  @override
  String get commonPayment => '收付款';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature 功能即将推出';
  }

  @override
  String get conversationMarkAsRead => '标记已读';

  @override
  String get commonUnmute => '取消静音';

  @override
  String get commonMute => '消息免打扰';

  @override
  String get conversationUnpin => '取消置顶';

  @override
  String get conversationPin => '置顶';

  @override
  String get conversationDeleteConversation => '删除会话';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return '确定要删除与 $name 的会话吗？';
  }

  @override
  String get commonNoContacts => '暂无联系人';

  @override
  String get contactAddFriendsToChat => '添加好友开始聊天';

  @override
  String get contactNotFound => '未找到联系人';

  @override
  String get contactTryOtherKeywords => '尝试搜索其他关键词或全局搜索';

  @override
  String get contactSearchResults => '搜索结果';

  @override
  String get contactNewFriends => '新的朋友';

  @override
  String get contactChatOnlyFriends => '仅聊天的朋友';

  @override
  String get contactOfficialAccounts => '公众号';

  @override
  String get contactServiceAccounts => '服务号';

  @override
  String get contactEnterpriseContacts => '企业联系人';

  @override
  String get contactRecommendToFriend => '推荐给朋友';

  @override
  String get commonSetRemark => '设置备注';

  @override
  String get contactSendingCard => '正在发送名片...';

  @override
  String get commonFileLabel => '文件';

  @override
  String get commonLocationLabel => '位置';

  @override
  String contactRecommendFailed(String error) {
    return '推荐失败: $error';
  }

  @override
  String get profileEnterRemark => '请输入备注名';

  @override
  String get contactOpeningChat => '正在打开聊天...';

  @override
  String contactOpenChatFailed(String error) {
    return '打开聊天失败: $error';
  }

  @override
  String get contactAddContact => '添加联系人';

  @override
  String get contactEnterUserId => '输入用户ID';

  @override
  String get contactNoFriendRequests => '暂无好友请求';

  @override
  String get commonAccept => '接受';

  @override
  String get commonReject => '拒绝';

  @override
  String get commonNoGroups => '暂无群聊';

  @override
  String get contactSelectFriendToRecommend => '选择要推荐给的朋友';

  @override
  String get commonSearchContacts => '搜索联系人';

  @override
  String get contactNoContactsFound => '没有找到联系人';

  @override
  String get favoriteYesterday => '昨天';

  @override
  String get chatJustNow => '刚刚';

  @override
  String get profileOnline => '在线';

  @override
  String get profileOffline => '离线';

  @override
  String get searchContactsGroupsMessages => '搜索联系人、群聊和消息';

  @override
  String get searchError => '搜索出错';

  @override
  String get chatSearchHint => '搜索';

  @override
  String get searchHistory => '搜索历史';

  @override
  String get commonClear => '清除';

  @override
  String get commonAll => '全部';

  @override
  String get searchGroups => '群聊';

  @override
  String get searchNoResults => '无结果';

  @override
  String commonGroupMembers(int count) {
    return '群成员 ($count)';
  }

  @override
  String get groupMembersTitle => '群成员';

  @override
  String get groupViewAll => '查看全部';

  @override
  String get groupOwner => '群主';

  @override
  String get groupAdmin => '管理';

  @override
  String get groupInvite => '邀请';

  @override
  String get commonGroupAnnouncement => '群公告';

  @override
  String get commonNotSet => '未设置';

  @override
  String get groupDescription => '群简介';

  @override
  String get groupPublicGroup => '公开群聊';

  @override
  String get commonClearChatHistory => '清空聊天记录';

  @override
  String get commonDissolveGroup => '解散群聊';

  @override
  String get commonLeaveGroup => '退出群聊';

  @override
  String get groupChangeGroupName => '修改群名称';

  @override
  String get commonEnterGroupName => '请输入群名称';

  @override
  String get commonConfirm => '确认';

  @override
  String get groupEnterGroupDescription => '请输入群简介';

  @override
  String get groupPublish => '发布';

  @override
  String get chatClearHistoryConfirm => '确定要清空聊天记录吗？此操作不可恢复。';

  @override
  String get chatClearAction => '清空';

  @override
  String get commonChatHistoryCleared => '聊天记录已清空';

  @override
  String get commonDissolve => '解散';

  @override
  String get groupQrCode => '群二维码';

  @override
  String get commonSearchChatHistory => '查找聊天记录';

  @override
  String get groupIdCopied => '群ID已复制';

  @override
  String get transferEnterOrPasteAddress => '输入或粘贴钱包地址';

  @override
  String get transferSelectToken => '选择代币';

  @override
  String get commonTransferAmount => '转账金额';

  @override
  String get transferAvailable => '可用';

  @override
  String get transferMemoOptional => '备注（可选）';

  @override
  String get transferConfirmTransfer => '确认转账';

  @override
  String get transferAddressVerified => '地址已验证';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return '可用余额: $balance $symbol';
  }

  @override
  String get commonEnterAmount => '请输入金额';

  @override
  String get commonRedPacketCountMin => '红包个数至少为1';

  @override
  String get commonViewRedPacketDetails => '查看红包详情';

  @override
  String get commonEnterTransferAmount => '请输入转账金额';

  @override
  String get commonTransferTo => '转账给';

  @override
  String commonFromSender(String name, Object senderName) {
    return '来自 $name';
  }

  @override
  String get commonConfirmReceive => '确认收款';

  @override
  String get groupProfile => '群资料';

  @override
  String get groupRemoveMember => '移出群聊';

  @override
  String get commonRemove => '移出';

  @override
  String get profileClearStatus => '清除状态';

  @override
  String get profileClearStatusConfirm => '确定要清除当前状态吗？';

  @override
  String get profileStatusCleared => '状态已清除';

  @override
  String get profileUserNotExist => '用户不存在';

  @override
  String get profileUserIdCopied => '用户ID已复制';

  @override
  String get commonReport => '举报';

  @override
  String get profileQrCode => '二维码';

  @override
  String get profileAvatarUpdated => '头像更新成功';

  @override
  String commonSelectImageFailed(String error) {
    return '选择图片失败: $error';
  }

  @override
  String get profileChangeName => '修改名字';

  @override
  String get profileMale => '男';

  @override
  String get profileFemale => '女';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature功能开发中...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return '保存地址失败: $error';
  }

  @override
  String get profileAddNew => '新增';

  @override
  String get profileAddAddress => '添加地址';

  @override
  String get profileAddressAdded => '地址添加成功';

  @override
  String get profileAddressUpdated => '地址更新成功';

  @override
  String get profileDeleteAddress => '删除地址';

  @override
  String get profileAddressDeleted => '地址已删除';

  @override
  String profileSaveInvoiceFailed(String error) {
    return '保存发票抬头失败: $error';
  }

  @override
  String get profileMyInvoices => '我的发票抬头';

  @override
  String get profileAddInvoice => '添加发票抬头';

  @override
  String get profileInvoiceAdded => '发票抬头添加成功';

  @override
  String get profileInvoiceUpdated => '发票抬头更新成功';

  @override
  String get profileDeleteInvoice => '删除发票抬头';

  @override
  String get profileInvoiceDeleted => '发票抬头已删除';

  @override
  String get profilePersonal => '个人';

  @override
  String get groupSelectAtLeastOne => '请至少选择一位成员';

  @override
  String get chatFileNotExist => '文件不存在';

  @override
  String chatSendFailed(String error) {
    return '发送失败: $error';
  }

  @override
  String get chatCannotOpenBrowser => '无法打开浏览器';

  @override
  String chatSelectFileFailed(String error) {
    return '选择文件失败: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return '设置失败: $error';
  }

  @override
  String get transferEnterValidAmount => '请输入有效的转账金额';

  @override
  String get commonAddressCopied => '地址已复制';

  @override
  String favoriteOpenItem(String content) {
    return '打开: $content';
  }

  @override
  String get favoriteDeleted => '已删除';

  @override
  String get profileWallet => '钱包';

  @override
  String get chatRecording => '录像';

  @override
  String get chatInvalidVideoUrl => '无效的视频链接';

  @override
  String get chatDownloadFile => '下载文件';

  @override
  String get chatClearChatHistoryTitle => '清空聊天记录';

  @override
  String get chatVideoCall => '视频通话';

  @override
  String get commonVoiceCall => '语音通话';

  @override
  String get callLeaveMeeting => '离开会议';

  @override
  String get chatDetails => '聊天详情';

  @override
  String get chatViewAllGroupMembers => '查看全部群成员';

  @override
  String get chatGroupName => '群聊名称';

  @override
  String get chatGroupNameUpdated => '群名称已更新';

  @override
  String get chatUpdateFailed => '更新失败';

  @override
  String get chatNoPermissionToModify => '您没有修改权限';

  @override
  String get chatGroupManagement => '群管理';

  @override
  String get chatMyNicknameInGroup => '我在本群的昵称';

  @override
  String get chatPinChat => '置顶聊天';

  @override
  String get chatStrongReminder => '强提醒';

  @override
  String get chatSetChatBackground => '设置当前聊天背景';

  @override
  String get chatUnknownFile => '未知文件';

  @override
  String get chatDownload => '下载';

  @override
  String get chatInvalidLocation => '无效的位置';

  @override
  String get chatTapToCancel => '点击取消';

  @override
  String chatCaptureFailed(Object error) {
    return '拍摄失败: $error';
  }

  @override
  String get chatProcessingVideo => '正在处理视频...';

  @override
  String get chatVideoFileNotExist => '视频文件不存在';

  @override
  String get chatVideoDataEmpty => '视频数据为空';

  @override
  String get chatVideoTooLarge => '视频大小不能超过 100MB';

  @override
  String get chatSendingVideo => '视频发送中...';

  @override
  String chatSendVideoFailed(Object error) {
    return '发送视频失败: $error';
  }

  @override
  String get chatImageFileNotExist => '图片文件不存在';

  @override
  String get commonImageDataEmpty => '图片数据为空';

  @override
  String get chatSendingImage => '图片发送中...';

  @override
  String chatSendImageFailed(Object error) {
    return '发送图片失败: $error';
  }

  @override
  String get chatSendLocation => '发送位置';

  @override
  String get chatSelectLocationAndSend => '选择地点并发送给对方';

  @override
  String get chatShareRealTimeLocation => '共享实时位置';

  @override
  String get chatShareLocationForOneHour => '与好友共享1小时实时位置';

  @override
  String get chatLocationSent => '位置已发送';

  @override
  String get chatSelectMessages => '选择消息';

  @override
  String chatSelectedCount(int count) {
    return '已选择 $count';
  }

  @override
  String get chatSelectAll => '全选';

  @override
  String chatGroupChatCount(int count) {
    return '群聊($count)';
  }

  @override
  String get chatPrivateChat => '私聊';

  @override
  String get chatNoMessages => '暂无消息';

  @override
  String get chatSendFirstMessage => '发送第一条消息开始聊天';

  @override
  String get chatEncryptionNotice => '此聊天已启用端到端加密。只有您和对方可以阅读消息。';

  @override
  String get chatMultiForward => '转发';

  @override
  String get chatCollect => '收藏';

  @override
  String get chatNoMembers => '没有成员';

  @override
  String get chatMemberNotFound => '未找到成员';

  @override
  String get chatVoiceFileNotExist => '语音文件不存在';

  @override
  String get chatVoiceFileEmpty => '语音文件为空';

  @override
  String get chatSendingVoice => '语音发送中...';

  @override
  String chatSendVoiceFailed(Object error) {
    return '发送语音失败: $error';
  }

  @override
  String get chatMessageForwarded => '消息已转发';

  @override
  String chatForwardFailed(Object error) {
    return '转发失败: $error';
  }

  @override
  String get chatUnfavorited => '已取消收藏';

  @override
  String get chatFavorited => '已收藏';

  @override
  String get chatReactionAdded => '已添加表情回应';

  @override
  String get chatReactionRemoved => '已移除表情回应';

  @override
  String get chatFailedMessageDeleted => '已删除失败消息';

  @override
  String get chatDeleteMessages => '删除消息';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return '确定要删除 $count 条消息吗？';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return '注意：$count 条消息来自他人，仅对你删除。';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count 条你发送的消息将对所有人撤回。';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return '已撤回 $count 条消息，$localCount 条仅对你删除';
  }

  @override
  String chatRecalledMessages(Object count) {
    return '已撤回 $count 条消息';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count 条消息仅对你删除';
  }

  @override
  String chatForwardedCount(Object count) {
    return '已转发 $count 条消息';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return '转发完成：成功 $success 条，失败 $failed 条';
  }

  @override
  String get chatRemindOnlyInGroup => '提醒功能仅在群聊中可用';

  @override
  String get chatOnlyTextSearchable => '仅支持搜索文本消息';

  @override
  String chatSearchFor(Object text) {
    return '搜索 \"$text\"';
  }

  @override
  String get chatBaiduSearch => '百度搜索';

  @override
  String get chatGoogleSearch => 'Google 搜索';

  @override
  String get chatBingSearch => '必应搜索';

  @override
  String get chatCalling => '呼叫中...';

  @override
  String get chatRinging => '响铃中...';

  @override
  String get chatInCall => '通话中';

  @override
  String commonFeatureInDevelopment(String feature) {
    return '$feature功能开发中...';
  }

  @override
  String chatCollectMessages(Object count) {
    return '已收藏 $count 条消息';
  }

  @override
  String commonMemberCount(int count) {
    return '$count 人';
  }

  @override
  String groupDone(int count) {
    return '完成($count)';
  }

  @override
  String get profileServices => '服务';

  @override
  String get commonFavorites => '收藏';

  @override
  String get profileOrdersAndCards => '订单与卡包';

  @override
  String get profileStickers => '表情';

  @override
  String profileStatusSetTo(String status) {
    return '状态已设置为：$status';
  }

  @override
  String get profileAvatarUploadFailed => '头像上传失败';

  @override
  String get profilePersonalProfile => '个人信息';

  @override
  String get profileName => '名字';

  @override
  String get profileGender => '性别';

  @override
  String get profileRegion => '地区';

  @override
  String get commonMyQrCode => '我的二维码';

  @override
  String get profilePoke => '拍一拍';

  @override
  String get profileRingtone => '来电铃声';

  @override
  String get profileDefaultRingtone => '默认铃声';

  @override
  String get profileMyAddresses => '我的地址';

  @override
  String profileGenderSetTo(String gender) {
    return '性别已设置为：$gender';
  }

  @override
  String get profileSelectRegion => '选择地区';

  @override
  String get profileSelectCity => '选择城市';

  @override
  String profileRegionSetTo(String region) {
    return '地区已设置为：$region';
  }

  @override
  String get profileSetPoke => '设置拍一拍';

  @override
  String get profileFriendPokedMe => '朋友拍了拍我';

  @override
  String get profileExample => '示例';

  @override
  String get profileOnTheShoulder => '的肩膀';

  @override
  String get profilePokeCleared => '拍一拍已清除';

  @override
  String profilePokeSetTo(String suffix) {
    return '拍一拍已设置为：拍了拍我$suffix';
  }

  @override
  String get profileEditSignature => '编辑个性签名';

  @override
  String get profileIntroduceYourself => '一句话介绍自己';

  @override
  String get profileSignatureCleared => '个性签名已清除';

  @override
  String get profileSignatureUpdated => '个性签名已更新';

  @override
  String get profileScanToAddFriend => '扫一扫上面的二维码图案，加我为好友';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return '来电铃声已设置为：$ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return '确定要解散群聊「$name」吗？此操作无法撤销。';
  }

  @override
  String get authEnterValidServerAddress => '请输入有效的服务器地址';

  @override
  String get authEmailOtp => '邮箱验证码';

  @override
  String get authEnterServerAddressFirst => '请先输入服务器地址';

  @override
  String get authPasskeyRequiresServer => 'Passkey登录需要服务器支持';

  @override
  String get authLoginAgreement => '登录即表示同意';

  @override
  String get authPleaseAgreeToTerms => '请先阅读并同意服务协议和隐私政策';

  @override
  String get authRegisterFailed => '注册失败';

  @override
  String get commonReenterPassword => '请再次输入密码';

  @override
  String get commonPasswordsDoNotMatch => '两次输入的密码不一致';

  @override
  String get authInviteCodeBuiltIn => '邀请码（已内置）';

  @override
  String get authInviteCodeBuiltInNote => '邀请码已内置，通常无需修改';

  @override
  String get authIHaveReadAndAgree => '我已阅读并同意';

  @override
  String get mainStartGroupChat => '发起群聊';

  @override
  String get mainAddFriends => '添加朋友';

  @override
  String get mainPaymentAndCollection => '收付款';

  @override
  String contactCount(int count) {
    return '$count位联系人';
  }

  @override
  String get contactAddToHomeScreen => '添加到桌面';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return '已将$contact的名片推荐给$recipient';
  }

  @override
  String get contactEnterRemarkName => '请输入备注名';

  @override
  String contactRemarkSetTo(String remark) {
    return '备注已设置为：$remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return '已接受$name的好友请求';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return '已拒绝$name的好友请求';
  }

  @override
  String get commonGroupInvites => '群邀请';

  @override
  String commonMyGroups(int count) {
    return '我的群聊 ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => '邀请加入群聊';

  @override
  String commonConfirmLeaveGroup(String name) {
    return '确定要退出群聊「$name」吗？';
  }

  @override
  String get commonLeave => '离开';

  @override
  String get commonRecallThisMessage => '撤回该条消息？';

  @override
  String get commonSavedToGallery => '已保存到相册';

  @override
  String get commonFailedToSave => '保存失败';

  @override
  String get chatSaving => '保存中...';

  @override
  String get commonShare => '分享';

  @override
  String get chatSaveToGallery => '保存到相册';

  @override
  String chatDownloadFailed(String code) {
    return '下载失败: $code';
  }

  @override
  String commonShareFailed(String error) {
    return '分享失败: $error';
  }

  @override
  String get chatFailedToLoadImage => '图片加载失败';

  @override
  String get chatVideoRecordingFailed => '视频录制失败，请重试';

  @override
  String get profileRedPacket => '红包';

  @override
  String get commonMusic => '音乐';

  @override
  String get commonCoupon => '卡券';

  @override
  String get commonGift => '礼物';

  @override
  String get commonPoll => '投票';

  @override
  String get favoriteText => '文本';

  @override
  String get favoriteLinkLabel => '链接';

  @override
  String get favoriteNote => '笔记';

  @override
  String get favoriteMyNotes => '我的笔记';

  @override
  String get favoriteToday => '今天';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count天前';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$month月$day日';
  }

  @override
  String get favoriteNoFavorites => '暂无收藏';

  @override
  String get favoriteLongPressToFavorite => '长按消息进行收藏';

  @override
  String get favoriteNewNote => '新建笔记';

  @override
  String get favoriteLink => '收藏链接';

  @override
  String get favoriteEditTags => '编辑标签';

  @override
  String get favoriteDeleteFavorite => '删除收藏';

  @override
  String get favoriteDeleteFavoriteConfirm => '确定要删除这条收藏吗？';

  @override
  String get favoriteNoSearchResultsFound => '没有找到结果';

  @override
  String get commonSendRedPacket => '发红包';

  @override
  String get transferAmount => '金额';

  @override
  String get commonRedPacketCover => '红包封面';

  @override
  String get commonRedPacketType => '红包类型';

  @override
  String get commonNormalRedPacket => '普通红包';

  @override
  String get commonLuckyRedPacket => '拼手气';

  @override
  String get commonRedPacketCount => '红包个数';

  @override
  String get commonPieces => '个';

  @override
  String get commonPutMoneyInRedPacket => '塞钱进红包';

  @override
  String get commonRedPacketRefundNotice => '未领取的红包，将于24小时后发起退款';

  @override
  String get commonOpenRedPacket => '開';

  @override
  String get commonRedPacketAllClaimed => '红包已被领完';

  @override
  String get commonRedPacketExpired => '红包已过期';

  @override
  String get commonAddTransferNote => '添加转账说明';

  @override
  String get commonYuan => '元';

  @override
  String get commonReplyWithEmoji => '用此表情回复';

  @override
  String get contactEditRemark => '编辑备注';

  @override
  String get contactSetPermissions => '设置权限';

  @override
  String get profileAddToBlacklist => '加入黑名单';

  @override
  String get contactDeleteContact => '删除联系人';

  @override
  String contactDeleteContactConfirm(String name) {
    return '确定要删除 $name 吗？';
  }

  @override
  String get transferTitle => '转账';

  @override
  String get transferReceiverAddressLabel => '收款地址';

  @override
  String get transferSelectTokenLabel => '选择代币';

  @override
  String get transferAmountLabel => '转账金额';

  @override
  String get transferMemoLabel => '备注（可选）';

  @override
  String get transferAddMemoHint => '添加备注信息';

  @override
  String get transferSendPaymentRequest => '发送收款请求';

  @override
  String get transferQrCodeGenerateFailed => '二维码生成失败';

  @override
  String get transferScanQrToPayMe => '扫描二维码向我付款';

  @override
  String get transferMyWalletAddress => '我的钱包地址';

  @override
  String get transferCreatePaymentRequest => '创建收款请求';

  @override
  String profileN42IdLabel(String id) {
    return 'N42号：$id';
  }

  @override
  String get commonRedPacketDefaultGreeting => '恭喜发财，大吉大利';

  @override
  String commonSenderRedPacket(String name) {
    return '$name的红包';
  }

  @override
  String get transferEnterValidAddress => '请输入有效的收款地址';

  @override
  String get transferPleaseSelectToken => '请选择代币';

  @override
  String get commonReceivedTransfer => '收到转账';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name发出的红包';
  }

  @override
  String get commonSavedToBalance => '已存入零钱，可直接转账';

  @override
  String get commonRedPacketExpiredOrEmpty => '红包已过期/已领完';

  @override
  String get transferScanFeatureComingSoon => '扫描功能开发中...';

  @override
  String get contactSetAsStarred => '设为星标朋友';

  @override
  String get contactAddToBlocklist => '加入黑名单';

  @override
  String get commonClaimedYour => '领取了你的';

  @override
  String get commonClaimedText => '领取了';

  @override
  String commonUserTyping(String name) {
    return '$name正在输入...';
  }

  @override
  String get commonTyping => '对方正在输入...';

  @override
  String get commonWaitingToReceive => '待对方接收';

  @override
  String get commonTapToClaim => '点击领取';

  @override
  String get commonHasBeenReceived => '已被接收';

  @override
  String get commonGetLucky => '领个好彩头';

  @override
  String get qrcodeCameraStartFailed => '相机启动失败';

  @override
  String get qrcodeUnknownError => '未知错误';

  @override
  String get qrcodePlaceQrCodeInFrame => '将二维码放入框内扫描';

  @override
  String get qrcodeCloseManualInput => '关闭手动输入';

  @override
  String get qrcodeManualInputUserId => '手动输入用户ID';

  @override
  String get commonAdd => '加入';

  @override
  String get profileSetStatus => '设置状态';

  @override
  String get profileVisibleToFriends24h => '可被好友看到，24小时后自动清除';

  @override
  String get profileWriteStatus => '写状态';

  @override
  String get profileEnterYourStatus => '输入你的状态...';

  @override
  String get profileOk => '确定';

  @override
  String get qrcodeCameraPermissionRequired => '扫描二维码需要相机权限';

  @override
  String get qrcodeCameraPermissionDenied => '相机权限已被永久拒绝，请在系统设置中开启。';

  @override
  String qrcodePermissionCheckError(String error) {
    return '检查权限时出错: $error';
  }

  @override
  String get qrcodeInvalidQrCode => '无效的二维码';

  @override
  String qrcodeCannotAddFriend(String error) {
    return '无法添加好友: $error';
  }

  @override
  String get qrcodeScanQrCode => '扫描二维码';

  @override
  String get qrcodeCheckingCameraPermission => '正在检查相机权限...';

  @override
  String get qrcodeNeedCameraPermission => '需要相机权限';

  @override
  String get qrcodeRetryPermission => '重试';

  @override
  String get qrcodeOpenSettings => '打开设置';

  @override
  String get groupInviteMembers => '邀请成员';

  @override
  String groupInviteCount(int count) {
    return '邀请($count)';
  }

  @override
  String get profileNoShippingAddress => '暂无收货地址';

  @override
  String get profileDefaultLabel => '默认';

  @override
  String get profileNoInvoice => '暂无发票抬头';

  @override
  String get profileCompany => '企业';

  @override
  String get profileTaxNumber => '税号';

  @override
  String get profileConfirmDeleteAddress => '确定要删除这个地址吗？';

  @override
  String get profileConfirmDeleteInvoice => '确定要删除这个发票抬头吗？';

  @override
  String get commonGroupOwner => '群主';

  @override
  String get commonGroupAdmin => '管理员';

  @override
  String get groupSearchMembers => '搜索成员';

  @override
  String groupTotalMembers(int count) {
    return '$count位成员';
  }

  @override
  String get chatRemoveFromGroup => '移出群聊';

  @override
  String groupConfirmRemoveMember(String name) {
    return '确定要将\"$name\"移出群聊吗？';
  }

  @override
  String get chatUnknownSong => '未知歌曲';

  @override
  String get chatUnknownArtist => '未知艺术家';

  @override
  String get chatUnknownContact => '未知联系人';

  @override
  String get chatPersonalCard => '个人名片';

  @override
  String get chatSingleChoice => '单选';

  @override
  String get chatMultiChoice => '多选';

  @override
  String get chatEnded => '已结束';

  @override
  String get chatEndPollButton => '结束投票';

  @override
  String get chatPollHint => '投票发起后将显示在聊天中，群成员可以参与投票';

  @override
  String get chatSearchSongOrArtist => '搜索歌曲或歌手';

  @override
  String get chatNoSongsFound => '没有找到歌曲';

  @override
  String get chatSongNameOptional => '歌曲名称（可选）';

  @override
  String get chatEnterSongName => '输入歌曲名称';

  @override
  String get chatArtistNameOptional => '歌手名称（可选）';

  @override
  String get chatEnterArtistName => '输入歌手名称';

  @override
  String get chatRealTimeLocationSharing => '实时位置共享功能开发中...';

  @override
  String get profileVoiceCallFeatureInDev => '语音通话功能开发中...';

  @override
  String get profileReportFeatureInDev => '举报功能开发中...';

  @override
  String get profileShareFeatureInDev => '分享功能开发中...';

  @override
  String get profileQrCodeFeatureInDev => '二维码功能开发中...';

  @override
  String get qrcodeScanQrToAddMe => '扫一扫上面的二维码，加我为好友';

  @override
  String get qrcodeSaveToAlbum => '保存到相册';

  @override
  String get qrcodeChangeStyle => '换个样式';

  @override
  String get qrcodeCopyId => '复制 ID';

  @override
  String get qrcodeIdCopied => '已复制用户 ID';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => '更多样式即将推出';

  @override
  String get profileBio => '个性签名';

  @override
  String get profileHomeServer => '服务器';

  @override
  String get profileShareContactCard => '分享名片';

  @override
  String get profileRemoveFromBlacklist => '移出黑名单';

  @override
  String get profileConfirmAddBlacklist => '确定将该用户加入黑名单吗？你将不再收到对方的消息';

  @override
  String get profileConfirmRemoveBlacklist => '确定将该用户移出黑名单吗？';

  @override
  String get profileRemarkSaved => '备注已保存';

  @override
  String get profileRemarkCleared => '已清除备注';

  @override
  String get transferReceive => '收款';

  @override
  String get transferPleaseConnectWallet => '请先连接钱包';

  @override
  String get transferSendRequest => '发送请求';

  @override
  String get transferPleaseEnterValidAmount => '请输入有效的金额';

  @override
  String get searchPlaceholder => '搜索联系人、群聊、消息';

  @override
  String get searchEnterKeywordToSearch => '输入关键词开始搜索';

  @override
  String get searchClearHistory => '清除';

  @override
  String searchNoResultsForQuery(String query) {
    return '没有找到\"$query\"相关的结果';
  }

  @override
  String get searchAllResults => '全部';

  @override
  String get searchInChat => '在聊天中搜索';

  @override
  String get searchContactLabel => '联系人';

  @override
  String get searchGroupLabel => '群聊';

  @override
  String get searchConversationLabel => '会话';

  @override
  String get searchMessageLabel => '消息';

  @override
  String get settingsSecurityTitle => '安全';

  @override
  String get settingsKeyBackup => '密钥备份';

  @override
  String get settingsBackupEncryptionKeys => '备份加密密钥';

  @override
  String settingsKeysBackedUp(int count) {
    return '已备份 $count 个密钥';
  }

  @override
  String get settingsBackupNotSet => '未设置备份';

  @override
  String get settingsRestoreKeys => '恢复密钥';

  @override
  String get settingsRestoreKeysFromBackup => '从备份恢复加密密钥';

  @override
  String get settingsExportKeys => '导出密钥';

  @override
  String get settingsExportKeysToFile => '导出密钥到文件';

  @override
  String get settingsLoggedInDevices => '已登录设备';

  @override
  String get settingsNoOtherDevices => '暂无其他设备';

  @override
  String get settingsVerified => '已验证';

  @override
  String get settingsUnverified => '未验证';

  @override
  String get settingsAdvanced => '高级';

  @override
  String get settingsCrossSigning => '跨设备签名';

  @override
  String get settingsEnabled => '已启用';

  @override
  String get settingsNotEnabled => '未启用';

  @override
  String get settingsResetEncryption => '重置加密';

  @override
  String get settingsDeleteAllEncryptionKeys => '删除所有加密密钥';

  @override
  String get settingsEncryptionNotSupported => '不支持加密';

  @override
  String get settingsNotInitialized => '未初始化';

  @override
  String get settingsBackupKeyTitle => '备份密钥';

  @override
  String get settingsBackupKeyMessage => '是否创建新的密钥备份？这将帮助您在新设备上恢复加密消息。';

  @override
  String get settingsBackup => '备份';

  @override
  String get settingsRestoreKeyTitle => '恢复密钥';

  @override
  String get settingsRestoreKeyMessage => '输入您的恢复密码或恢复密钥来恢复加密消息。';

  @override
  String get settingsRestore => '恢复';

  @override
  String get settingsExportKeyTitle => '导出密钥';

  @override
  String get settingsExportKeyMessage => '导出的密钥文件包含您的所有加密密钥，请妥善保管。';

  @override
  String get settingsExport => '导出';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return '设备ID: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => '状态: 已验证';

  @override
  String get settingsDeviceStatusUnverified => '状态: 未验证';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return '最后活跃: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => '验证此设备';

  @override
  String get settingsCrossSigningAlreadyEnabled => '跨设备签名已启用';

  @override
  String get settingsCrossSigningSetupSuccess => '跨设备签名设置成功';

  @override
  String get settingsResetEncryptionTitle => '重置加密';

  @override
  String get settingsResetEncryptionWarning =>
      '警告：这将删除您所有的加密密钥。您将无法解密之前的加密消息。此操作不可撤销。';

  @override
  String get settingsReset => '重置';

  @override
  String get settingsBackupSuccess => '密钥备份成功';

  @override
  String get settingsBackupFailed => '备份失败';

  @override
  String get settingsRecoveryKey => '恢复密钥';

  @override
  String get settingsRecoveryKeySaveWarning =>
      '请将此恢复密钥保存在安全的地方。您需要它在新设备上恢复加密消息。';

  @override
  String get settingsRecoveryKeySaved => '我已保存';

  @override
  String get settingsRestoreSuccess => '密钥恢复成功';

  @override
  String get settingsRestoreFailed => '恢复失败';

  @override
  String get settingsPassword => '密码';

  @override
  String get settingsEnterRecoveryKey => '输入恢复密钥';

  @override
  String get settingsEnterPassword => '输入密码';

  @override
  String get settingsExportSuccess => '密钥已成功导出到服务端备份';

  @override
  String get settingsExportNeedBackupFirst => '请先创建密钥备份';

  @override
  String get settingsExportFailed => '导出失败';

  @override
  String get settingsResetSuccess => '加密重置成功';

  @override
  String get settingsResetFailed => '重置失败';

  @override
  String get callLeaveMeetingConfirm => '确定要离开会议吗？';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return '拍了拍「$name」$suffix';
  }

  @override
  String get chatNoContactsToAdd => '没有可添加的联系人';

  @override
  String get chatAddMembers => '添加成员';

  @override
  String chatInvitedMembers(int count) {
    return '已邀请 $count 位成员';
  }

  @override
  String chatInviteFailed(String error) {
    return '邀请失败: $error';
  }

  @override
  String get chatMemberRemoved => '已移除成员';

  @override
  String chatRemoveFailed(String error) {
    return '移除失败: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage => '开始共享后，对方将能看到你的实时位置，共享时长为1小时。';

  @override
  String get chatStartSharing => '开始共享';

  @override
  String get chatLocationServiceNotEnabled => '位置服务未开启';

  @override
  String get chatEnableLocationService => '请开启位置服务以使用位置功能';

  @override
  String get chatGoToSettings => '去设置';

  @override
  String get chatLocationPermissionRequired => '需要位置权限才能使用此功能';

  @override
  String get chatLocationPermissionDeniedPermanent => '位置权限已被永久拒绝，请在设置中开启';

  @override
  String get chatLocationPermissionDenied => '位置权限被拒绝';

  @override
  String get chatGettingLocation => '正在获取位置...';

  @override
  String chatGetLocationFailed(String error) {
    return '获取位置失败: $error';
  }

  @override
  String get chatMapPreview => '地图预览';

  @override
  String get chatSearchLocation => '搜索地点';

  @override
  String chatRedPacketSent(String amount, String token) {
    return '已发送 $amount $token 红包';
  }

  @override
  String get chatTransferDefault => '转账';

  @override
  String chatTransferSent(String amount, String token) {
    return '已发送 $amount $token 转账';
  }

  @override
  String chatPickFileFailed(String error) {
    return '选择文件失败: $error';
  }

  @override
  String get chatFileSizeLimit => '文件大小不能超过 50MB';

  @override
  String chatFileSending(String filename) {
    return '文件发送中: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return '发送文件失败: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return '已发送 $name 的名片';
  }

  @override
  String get chatFavoritesFeature => '收藏';

  @override
  String get chatCouponsFeature => '卡券';

  @override
  String get chatGiftFeature => '礼物';

  @override
  String chatSharedMusic(String name) {
    return '已分享 $name';
  }

  @override
  String get chatEndPollTitle => '结束投票';

  @override
  String get chatEndPollConfirmMessage => '确定要结束这个投票吗？结束后将无法继续投票。';

  @override
  String get chatPollEndedMessage => '投票已结束';

  @override
  String get chatConnectingCall => '正在连接...';

  @override
  String get chatMuteCall => '静音';

  @override
  String get chatSpeakerOff => '关闭免提';

  @override
  String get chatSpeakerOn => '免提';

  @override
  String get chatCameraOn => '开启摄像头';

  @override
  String get chatCameraOff => '关闭摄像头';

  @override
  String get chatHangUp => '挂断';

  @override
  String get chatSelectForwardTargetTitle => '选择转发对象';

  @override
  String get chatNoForwardableChat => '没有可转发的会话';

  @override
  String get chatNoMatchingChat => '没有找到相关会话';

  @override
  String get chatLocationTitle => '位置';

  @override
  String get chatSendButton => '发送';

  @override
  String get chatRetryButton => '重试';

  @override
  String get chatSearchContactHint => '搜索联系人';

  @override
  String get chatShareMusic => '分享音乐';

  @override
  String get chatRecentPlayed => '最近播放';

  @override
  String get chatMyFavorites => '我喜欢';

  @override
  String get chatNetworkLink => '网络链接';

  @override
  String get chatLocalFile => '本地文件';

  @override
  String get chatPasteMusicLink => '粘贴音乐链接';

  @override
  String get chatShareMusicButton => '分享音乐';

  @override
  String get chatSelectLocalAudio => '选择本地音频文件';

  @override
  String get chatSupportedAudioFormats => '支持 MP3、M4A、WAV、FLAC 等格式';

  @override
  String get chatSelectFileButton => '选择文件';

  @override
  String get chatPleaseEnterMusicLink => '请输入音乐链接';

  @override
  String get chatPleaseEnterValidLink => '请输入有效的网络链接';

  @override
  String get chatSharedSong => '分享歌曲';

  @override
  String get chatSelectMember => '选择成员';

  @override
  String get chatSearchMemberHint => '搜索成员';

  @override
  String get chatNoMatchingMembers => '未找到匹配的成员';

  @override
  String get commonUnknownMember => '未知';

  @override
  String chatSelectedMessagesCount(int count) {
    return '已选择 $count 条消息';
  }

  @override
  String get chatSearchContactsOrGroups => '搜索联系人或群聊';

  @override
  String get chatVideoTitle => '视频';

  @override
  String get chatLoadingText => '加载中...';

  @override
  String get chatVideoLoadFailed => '视频加载失败';

  @override
  String get chatPlayerInitFailed => '播放器初始化失败';

  @override
  String get chatCreatePollTitle => '创建投票';

  @override
  String get chatSubmitPoll => '发起';

  @override
  String get chatPollQuestionLabel => '投票问题';

  @override
  String get chatEnterPollQuestionHint => '请输入投票问题';

  @override
  String get chatPollOptionsLabel => '投票选项';

  @override
  String chatOptionHintWithIndex(int index) {
    return '选项 $index';
  }

  @override
  String get chatAddOptionButton => '添加选项';

  @override
  String get chatPollSettingsLabel => '投票设置';

  @override
  String get chatSelectionType => '选择类型';

  @override
  String get chatSingleChoiceLabel => '单选';

  @override
  String get chatMultiChoiceLabel => '多选';

  @override
  String get chatAnonymousPollSwitch => '匿名投票';

  @override
  String get chatPleaseEnterQuestion => '请输入投票问题';

  @override
  String get chatAtLeastTwoOptions => '至少需要2个选项';

  @override
  String chatConfirmWithCount(int count) {
    return '确定 ($count)';
  }

  @override
  String get authEmailVerificationTitle => '邮箱验证';

  @override
  String get authEnterValidEmailAddress => '请输入有效的邮箱地址';

  @override
  String authVerificationCodeSentTo(String email) {
    return '验证码已发送到 $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return '发送验证码失败: $error';
  }

  @override
  String get authVerificationSuccess => '验证成功';

  @override
  String get authVerificationFailed => '验证失败';

  @override
  String authVerificationCodeError(String error) {
    return '验证码错误: $error';
  }

  @override
  String get commonEnterVerificationCode => '输入验证码';

  @override
  String get authEnterYourEmail => '输入邮箱';

  @override
  String authWeSentCodeTo(String email) {
    return '我们已向 $email 发送了\n6位验证码';
  }

  @override
  String get authEnterEmailForCode => '输入您的邮箱地址，我们将发送验证码';

  @override
  String get commonSendVerificationCode => '发送验证码';

  @override
  String get authResendVerificationCode => '重新发送验证码';

  @override
  String authCanResendAfter(int seconds) {
    return '$seconds秒后可重新发送';
  }

  @override
  String get commonChangeEmail => '更换邮箱';

  @override
  String get contactAddToContacts => '添加到通讯录';

  @override
  String get contactAddingToContacts => '添加中...';

  @override
  String get contactAddedToContacts => '已添加到通讯录';

  @override
  String contactAddFailedWithError(String error) {
    return '添加失败: $error';
  }

  @override
  String get contactAddPhone => '添加电话';

  @override
  String get contactAddTag => '添加标签';

  @override
  String get contactAddText => '添加文字';

  @override
  String get contactAddPhoto => '添加照片';

  @override
  String contactGroupCountLabel(int count) {
    return '$count个';
  }

  @override
  String get contactAddedViaSearch => '通过搜索添加';

  @override
  String get contactAddTime => '添加时间';

  @override
  String get contactDoneButton => '完成';

  @override
  String get callWaitingForParticipants => '等待参与者加入...';

  @override
  String callParticipantMe(String name) {
    return '$name（我）';
  }

  @override
  String get callSharingLabel => '共享中';

  @override
  String callScreenSharingBy(String name) {
    return '$name 正在共享屏幕';
  }

  @override
  String callParticipantCount(int count) {
    return '$count 人';
  }

  @override
  String get callMuteLabel => '静音';

  @override
  String get callUnmuteLabel => '解除静音';

  @override
  String get callTurnOffVideo => '关闭视频';

  @override
  String get callTurnOnVideo => '开启视频';

  @override
  String get callShareScreen => '共享屏幕';

  @override
  String get callStopSharing => '停止共享';

  @override
  String get callSwitchCameraLabel => '切换';

  @override
  String get callLeaveLabel => '离开';

  @override
  String get callParticipantsLabel => '参与者';

  @override
  String get callJoiningMeeting => '正在加入会议...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count 票 ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count 人参与';
  }

  @override
  String get commonTapToRetry => '点击重试';

  @override
  String get chatDefaultRedPacketGreeting => '恭喜发财，大吉大利';

  @override
  String get groupAllowOthersToSearchAndJoin => '允许他人搜索并加入';

  @override
  String get groupConfirmClearChatHistory => '确定要清空聊天记录吗？';

  @override
  String get groupCreateGroupToChat => '创建群聊以开始聊天';

  @override
  String get groupEditGroupAnnouncement => '编辑群公告';

  @override
  String get groupEditGroupDescription => '编辑群描述';

  @override
  String get groupEnterGroupAnnouncement => '请输入群公告';

  @override
  String chatErrorWithMessage(String message) {
    return '错误: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count人，点击复制群ID';
  }

  @override
  String get chatMusicLinkLabel => '音乐链接';

  @override
  String get chatNoMediaUrlAvailable => '没有可用的媒体链接';

  @override
  String get groupNoPermissionToEditGroupName => '你没有权限修改群名称';

  @override
  String get chatRedPacketTransferCannotForward => '红包和转账消息无法转发';

  @override
  String get authEmailAddress => '邮箱地址';

  @override
  String get commonEnterEmailAddress => '请输入邮箱地址';

  @override
  String get authEmailRecoveryHint => '用于找回密码';

  @override
  String get commonInvalidEmailFormat => '请输入有效的邮箱地址';

  @override
  String get authOptional => '选填';

  @override
  String get authResetPassword => '重置密码';

  @override
  String get authEnterRegisteredEmail => '请输入注册时绑定的邮箱地址';

  @override
  String get authSendResetCode => '发送重置验证码';

  @override
  String authResetCodeSent(String email) {
    return '重置验证码已发送至 $email';
  }

  @override
  String get authEnterResetCode => '输入重置验证码';

  @override
  String get authSetNewPassword => '设置新密码';

  @override
  String get commonConfirmNewPassword => '确认新密码';

  @override
  String get commonNewPassword => '新密码';

  @override
  String get authPasswordResetSuccess => '密码重置成功，请使用新密码登录';

  @override
  String get authResetPasswordFailed => '重置密码失败';

  @override
  String get settingsChangePassword => '修改密码';

  @override
  String get settingsCurrentPassword => '当前密码';

  @override
  String get settingsEnterCurrentPassword => '请输入当前密码';

  @override
  String get settingsEnterNewPassword => '请输入新密码';

  @override
  String get settingsPasswordChanged => '密码修改成功，请使用新密码重新登录';

  @override
  String get settingsChangePasswordFailed => '修改密码失败';

  @override
  String get settingsNewPasswordMustBeDifferent => '新密码不能与当前密码相同';

  @override
  String get settingsChangePasswordInfo => '修改密码后，您将被登出，需要使用新密码重新登录。';

  @override
  String get settingsPasswordRequirements => '密码要求：';

  @override
  String get settingsSecurityNote => '为了安全，修改密码后需要在所有设备上重新登录。';

  @override
  String get settingsSecurity => '安全';

  @override
  String get settingsCurrentBoundEmail => '当前绑定邮箱';

  @override
  String get settingsNewEmailAddress => '新邮箱地址';

  @override
  String get settingsEnterNewEmail => '请输入新邮箱地址';

  @override
  String get settingsVerificationCode => '验证码';

  @override
  String get settingsVerificationCodeSent => '验证码已发送';

  @override
  String get settingsCodeSentTo => '验证码已发送至';

  @override
  String get settingsDidNotReceiveCode => '没有收到验证码？';

  @override
  String get settingsEmailChangedSuccess => '邮箱修改成功';

  @override
  String get settingsChangeEmailFailed => '修改邮箱失败';

  @override
  String get settingsEmailSecurityNote => '邮箱用于密码找回，请确保安全。';

  @override
  String get commonGoogleLogin => '使用 Google 登录';

  @override
  String get commonAppleLogin => '使用 Apple 登录';

  @override
  String get commonWechat => '微信';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsLanguageChanged => '语言已更改';

  @override
  String get settingsBiometricLogin => '生物识别登录';

  @override
  String authLoginWithBiometric(Object type) {
    return '使用$type登录';
  }

  @override
  String get settingsBiometricLoginEnabled => '生物识别登录已启用';

  @override
  String get settingsBiometricLoginDisabled => '生物识别登录已禁用';

  @override
  String get settingsEnableBiometricLogin => '启用生物识别登录';

  @override
  String get settingsBiometricEnabled => '已启用 - 使用生物识别登录';

  @override
  String get settingsBiometricDisabled => '已禁用 - 点击启用';

  @override
  String get settingsBiometricNeedRelogin => '请退出后重新登录以启用生物识别';

  @override
  String get authOr => '或';

  @override
  String get qrcodeCameraPermissionRestricted => '此设备上的相机访问受限';

  @override
  String get authPasskeyLabel => 'Passkey';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'Apple';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get transferAmountHintZero => '0.00';

  @override
  String get commonMatrixIdHint => '@username:server.com';

  @override
  String get authServerAddressHint => 'https://m.si46.world';

  @override
  String get authEmailExampleHint => 'example@email.com';

  @override
  String get authVerificationCodePlaceholder => '------';

  @override
  String get profileEnterPokeSuffixHint => '输入戳一戳后缀，例如：的肩膀';

  @override
  String get groupAlbum => '群相册';

  @override
  String get groupFiles => '群文件';

  @override
  String get groupImages => '图片';

  @override
  String get groupVideos => '视频';

  @override
  String get groupTotal => '全部';

  @override
  String get groupSize => '大小';

  @override
  String get groupNoMedia => '暂无媒体';

  @override
  String get groupNoMediaDescription => '此群还没有图片或视频';

  @override
  String get groupDocuments => '文档';

  @override
  String get groupNoFiles => '暂无文件';

  @override
  String get groupNoFilesDescription => '此群还没有文件';

  @override
  String groupDownloadStarted(String filename) {
    return '正在下载 $filename...';
  }

  @override
  String get contactNoCommonGroups => '暂无共同群组';

  @override
  String get contactNoCommonGroupsDescription => '你们没有共同加入的群组';

  @override
  String get chatVoiceMessage => '语音';

  @override
  String get chatMessage => '消息';

  @override
  String get conversationHideChat => '隐藏';

  @override
  String get settingsQuickReply => '快捷回复';

  @override
  String get commonTranslate => '翻译';

  @override
  String get contactCreateTag => '新建标签';

  @override
  String get contactEnterTagName => '输入标签名称';

  @override
  String get contactEditTag => '编辑标签';

  @override
  String get contactDeleteTag => '删除标签';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return '确定要删除标签 \"$tagName\" 吗？';
  }

  @override
  String get contactNoTags => '暂无标签';

  @override
  String get contactFriendPermissions => '朋友权限';

  @override
  String get contactSetChatOnly => '设为仅聊天';

  @override
  String get contactChatOnlyDesc => '只能聊天，其他内容将被隐藏';

  @override
  String get contactHideMyMoments => '不让他（她）看我的朋友圈';

  @override
  String get contactHideMyMomentsDesc => '该好友无法查看你的朋友圈动态';

  @override
  String get contactHideTheirMoments => '不看他（她）的朋友圈';

  @override
  String get contactHideTheirMomentsDesc => '不会看到该好友的朋友圈动态';

  @override
  String get contactHideMyStatus => '不让他（她）看我的状态';

  @override
  String get contactHideMyStatusDesc => '该好友无法查看你的状态更新';

  @override
  String get contactNoChatOnlyFriends => '暂无仅聊天的朋友';

  @override
  String get contactNoOfficialAccounts => '暂无公众号';

  @override
  String get contactFollowOfficialAccountsDesc => '关注公众号，获取最新资讯';

  @override
  String get contactNoServiceAccounts => '暂无服务号';

  @override
  String get contactSubscribeServiceAccountsDesc => '订阅服务号，享受便捷服务';

  @override
  String get contactNoEnterpriseContacts => '暂无企业联系人';

  @override
  String get contactEnterpriseContactsDesc => '企业通讯录联系人将显示在这里';

  @override
  String get profileCardPack => '卡包';

  @override
  String get profileOrders => '订单';

  @override
  String get profileNoOrders => '暂无订单';

  @override
  String get profileOrdersDesc => '你的订单将显示在这里';

  @override
  String get profileNoCards => '暂无卡券';

  @override
  String get profileCardsDesc => '你的卡券将显示在这里';

  @override
  String get favoriteEnterTagsHint => '输入标签，用逗号分隔';

  @override
  String get favoriteTagsUpdated => '标签已更新';

  @override
  String get favoriteForwardedContent => '内容已转发';

  @override
  String get favoriteEnterNoteContent => '输入笔记内容';

  @override
  String get favoriteNoteAdded => '笔记已添加';

  @override
  String get favoriteLinkTitle => '链接标题';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => '链接已添加';

  @override
  String get contactPhotoAdded => '照片已添加';

  @override
  String get contactEnterPhone => '输入手机号码';

  @override
  String commonConversationWithId(String roomId) {
    return '会话: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return '联系人: $userId';
  }

  @override
  String get commonDiscover => '发现';

  @override
  String commonDeveloping(String title) {
    return '$title\n(开发中)';
  }

  @override
  String get commonPageNotFound => '页面不存在';

  @override
  String get commonBackToHome => '返回首页';

  @override
  String get settingsMessageNotifications => '消息通知';

  @override
  String get settingsReceiveNewMessageNotifications => '接收新消息通知';

  @override
  String get settingsShowMessagePreview => '显示消息预览';

  @override
  String get settingsShowMessageContentInNotification => '在通知中显示消息内容';

  @override
  String get settingsNotificationSound => '通知声音';

  @override
  String get settingsPlaySoundOnMessage => '收到消息时播放声音';

  @override
  String get commonVibration => '振动';

  @override
  String get settingsVibrateOnMessage => '收到消息时震动';

  @override
  String get settingsDoNotDisturbMode => '勿扰模式';

  @override
  String get settingsDoNotDisturbDescription => '在指定时间内不接收通知';

  @override
  String get settingsStartTime => '开始时间';

  @override
  String get settingsEndTime => '结束时间';

  @override
  String get settingsDeleteQuickReply => '删除快捷回复';

  @override
  String get settingsEditQuickReply => '编辑快捷回复';

  @override
  String get settingsAddQuickReply => '添加快捷回复';

  @override
  String get settingsManageQuickReplies => '管理快捷回复';

  @override
  String get settingsNoQuickReplies => '暂无快捷回复';

  @override
  String get settingsDefaultQuickReplies => '将显示默认快捷回复';

  @override
  String get settingsWhoCanSee => '谁可以查看';

  @override
  String get settingsLastSeen => '最后上线时间';

  @override
  String get settingsHiddenChats => '隐藏的聊天';

  @override
  String get settingsMessagesLabel => '消息';

  @override
  String get settingsAllowStrangerMessages => '允许陌生人消息';

  @override
  String get settingsReceiveMessagesFromNonContacts => '接收非联系人的消息';

  @override
  String get settingsReadReceipts => '已读回执';

  @override
  String get settingsLetOthersKnowYouRead => '让对方知道你已读';

  @override
  String get settingsTypingIndicator => '输入状态指示';

  @override
  String get settingsLetOthersKnowYouTyping => '让对方知道你正在输入';

  @override
  String get settingsEveryone => '所有人';

  @override
  String get settingsContactsOnly => '仅联系人';

  @override
  String get settingsNobody => '无人';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return '谁可以看到 $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return '版本 $version';
  }

  @override
  String get settingsCheckForUpdates => '检查更新';

  @override
  String get settingsOpenSourceLicenses => '开源许可';

  @override
  String get settingsFeedbackAndSuggestions => '反馈与建议';

  @override
  String get settingsBuiltOnMatrix => '基于 Matrix 协议构建';

  @override
  String get settingsNoHiddenChats => '没有隐藏的聊天';

  @override
  String get settingsNoHiddenChatsDescription => '你隐藏的聊天会显示在这里';

  @override
  String get settingsUnhideChat => '取消隐藏';

  @override
  String get settingsDarkMode => '深色模式';

  @override
  String get settingsFontSize => '字体大小';

  @override
  String get settingsBubbleStyle => '气泡样式';

  @override
  String get settingsFollowSystem => '跟随系统';

  @override
  String get settingsAutoSwitchBySystem => '跟随系统自动切换';

  @override
  String get settingsLightMode => '浅色模式';

  @override
  String get settingsAlwaysUseLightTheme => '始终使用浅色主题';

  @override
  String get settingsDarkModeOption => '深色模式选项';

  @override
  String get settingsAlwaysUseDarkTheme => '始终使用深色主题';

  @override
  String get settingsFontSizeSmall => '小';

  @override
  String get settingsFontSizeStandard => '标准';

  @override
  String get settingsFontSizeLarge => '大';

  @override
  String get settingsFontSizeExtraLarge => '特大';

  @override
  String get settingsBubbleStyleWechat => '微信样式';

  @override
  String get settingsBubbleStyleWechatDesc => '经典微信气泡样式';

  @override
  String get settingsBubbleStyleModern => '现代样式';

  @override
  String get settingsBubbleStyleModernDesc => '简洁的现代气泡样式';

  @override
  String get settingsBubbleStyleClassic => '经典样式';

  @override
  String get settingsBubbleStyleClassicDesc => '传统的气泡样式';

  @override
  String get discoverVideoChannels => '视频号';

  @override
  String get discoverLive => '直播';

  @override
  String get discoverListen => '听一听';

  @override
  String get discoverWatch => '看一看';

  @override
  String get discoverSearchDiscover => '搜一搜';

  @override
  String get discoverNearbyPeople => '附近的人';

  @override
  String get discoverGames => '游戏';

  @override
  String get discoverMiniPrograms => '小程序';

  @override
  String get chatAlreadyInCall => '当前正在通话中';

  @override
  String get commonConnectionFailed => '连接失败';

  @override
  String get chatCallRejected => '对方已拒绝';

  @override
  String get chatNoAnswer => '对方无应答';

  @override
  String get commonClose => '关闭';

  @override
  String get chatSelectContact => '选择联系人';

  @override
  String get chatVoteRemoved => '已取消投票';

  @override
  String get chatVoteChanged => '投票已更改';

  @override
  String get chatVoted => '已投票';

  @override
  String chatReplyTo(String name) {
    return '回复 $name';
  }

  @override
  String get chatCurrentLocation => '当前位置';

  @override
  String chatNearbyPlace(int index) {
    return '附近地点 $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return '约 $distance';
  }

  @override
  String get chatAddress => '地址';

  @override
  String get chatLatitude => '纬度';

  @override
  String get chatLongitude => '经度';

  @override
  String get groupDescriptionUpdated => '群简介已更新';

  @override
  String get groupAvatarUpdated => '群头像已更新';

  @override
  String get callDecline => '拒绝';

  @override
  String get callAnswer => '接听';

  @override
  String get callIncomingVideoCall => '视频来电';

  @override
  String get callIncomingVoiceCall => '语音来电';

  @override
  String get callVideoCallInProgress => '视频通话中';

  @override
  String get callVoiceCallInProgress => '语音通话中';

  @override
  String get callReconnectingCall => '正在重连...';

  @override
  String get callEnded => '通话已结束';

  @override
  String get callFailed => '通话失败';

  @override
  String get callLivekitNotConfigured => 'LiveKit 未配置';

  @override
  String callJoinMeetingFailed(String error) {
    return '加入会议失败: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return '屏幕共享失败: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42豆';

  @override
  String get profileNoN42Bean => '暂无N42豆';

  @override
  String get profileN42BeanDetails => 'N42豆明细';

  @override
  String get profileN42BeanDescription => 'N42豆是用于兑换N42内虚拟物品和服务的道具，目前可用于兑换：';

  @override
  String get profileN42BeanFeature1 => '会员专属表情和主题';

  @override
  String get profileN42BeanFeature2 => '聊天气泡个性化';

  @override
  String get profileN42BeanFeature3 => '红包封面定制';

  @override
  String get profileN42BeanFeature4 => '专属昵称标识';

  @override
  String get profileN42BeanFeature5 => '群聊特权功能';

  @override
  String get profileN42BeanFeature6 => '云存储空间扩展';

  @override
  String get profileN42BeanFeature7 => '视频通话美颜滤镜';

  @override
  String get profileN42BeanFeature8 => '朋友圈背景更换';

  @override
  String get profileN42BeanFeature9 => 'VIP客服优先服务';

  @override
  String get profileGotIt => '我知道了';

  @override
  String get profileNoN42BeanRecords => '暂无N42豆明细记录';

  @override
  String get profileMoodAndThoughts => '心情想法';

  @override
  String get profileStatusHappy => '开心';

  @override
  String get profileStatusCracked => '裂开';

  @override
  String get profileStatusLucky => '发呆';

  @override
  String get profileStatusSunny => '天气晴';

  @override
  String get profileStatusTired => '累了';

  @override
  String get profileStatusDaydream => '发呆中';

  @override
  String get profileStatusRushing => '忙碌';

  @override
  String get profileStatusOverthinking => '想太多';

  @override
  String get profileStatusEnergized => '元气满满';

  @override
  String get profileWorkAndStudy => '工作学习';

  @override
  String get profileStatusWorking => '搬砖中';

  @override
  String get profileStatusStudying => '学习中';

  @override
  String get profileStatusBusy => '忙';

  @override
  String get profileStatusSlacking => '摸鱼中';

  @override
  String get profileStatusTraveling => '旅行中';

  @override
  String get profileStatusGoingHome => '回家中';

  @override
  String get profileStatusDnd => '请勿打扰';

  @override
  String get profileActivities => '活动';

  @override
  String get profileStatusHanging => '出去浪';

  @override
  String get profileStatusCheckIn => '打卡';

  @override
  String get profileStatusExercising => '运动中';

  @override
  String get profileStatusCoffee => '喝咖啡';

  @override
  String get profileStatusBubbleTea => '奶茶';

  @override
  String get profileStatusEating => '干饭中';

  @override
  String get profileStatusParenting => '带娃中';

  @override
  String get profileStatusSavingWorld => '拯救世界';

  @override
  String get profileStatusSelfie => '自拍';

  @override
  String get profileRest => '休息';

  @override
  String get profileStatusRetreat => '闭关';

  @override
  String get profileStatusHome => '宅家';

  @override
  String get profileStatusSleeping => '睡觉中';

  @override
  String get profileStatusCatLover => '吸猫中';

  @override
  String get profileStatusDogWalking => '遛狗中';

  @override
  String get profileStatusGaming => '游戏中';

  @override
  String get profileStatusListening => '听歌中';

  @override
  String get profileEditAddress => '编辑地址';

  @override
  String get profileRecipient => '收货人';

  @override
  String get profileEnterRecipientName => '请输入收货人姓名';

  @override
  String get profilePhoneNumber => '手机号码';

  @override
  String get profileEnterPhoneNumber => '请输入手机号码';

  @override
  String get profileRegionHint => '省/市/区';

  @override
  String get profileDetailedAddress => '详细地址';

  @override
  String get profileDetailedAddressHint => '街道、门牌号等';

  @override
  String get profileSetAsDefaultAddress => '设为默认地址';

  @override
  String get profilePleaseCompleteInfo => '请填写完整信息';

  @override
  String get profileEditInvoice => '编辑发票抬头';

  @override
  String get profileInvoiceType => '抬头类型';

  @override
  String get profileCompanyName => '企业名称';

  @override
  String get profilePersonalName => '个人姓名';

  @override
  String get profileEnterCompanyName => '请输入企业名称';

  @override
  String get profileEnterName => '请输入姓名';

  @override
  String get profileTaxIdNumber => '纳税人识别号';

  @override
  String get profileEnterTaxIdNumber => '请输入纳税人识别号';

  @override
  String get profileBankNameOptional => '开户银行（选填）';

  @override
  String get profileEnterBankName => '请输入开户银行';

  @override
  String get profileBankAccountOptional => '银行账号（选填）';

  @override
  String get profileEnterBankAccount => '请输入银行账号';

  @override
  String get profileCompanyAddressOptional => '企业地址（选填）';

  @override
  String get profileEnterCompanyAddress => '请输入企业地址';

  @override
  String get profileCompanyPhoneOptional => '企业电话（选填）';

  @override
  String get profileEnterCompanyPhone => '请输入企业电话';

  @override
  String get profileSetAsDefaultInvoice => '设为默认抬头';

  @override
  String get profileRingtoneVibrate => '震动';

  @override
  String get profileRingtoneSilent => '静音';

  @override
  String get profileVibrateMode => '振动模式';

  @override
  String get profileSilentMode => '静音模式';

  @override
  String profilePlayFailed(String ringtoneName) {
    return '播放失败: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return '正在播放: $ringtoneName';
  }

  @override
  String get profileStop => '停止';

  @override
  String get profileSelectRingtone => '选择铃声';

  @override
  String get profileLoadingRingtones => '加载铃声中...';

  @override
  String get profileNoRingtonesFound => '未找到铃声';

  @override
  String mainMessagesWithCount(int count) {
    return '消息($count)';
  }

  @override
  String get storyViewers => '浏览者';

  @override
  String get storyNoViewers => '暂无浏览';

  @override
  String get storyReplyToStory => '回复状态...';

  @override
  String get commonCopiedToClipboard => '已复制到剪贴板';

  @override
  String get commonMore => '更多';

  @override
  String get commonTranslating => '翻译中...';

  @override
  String commonTranslatedFrom(String language) {
    return '翻译自$language';
  }

  @override
  String get commonTranslation => '翻译';

  @override
  String get commonTranslationFailed => '翻译失败';

  @override
  String get commonAllRead => '全部已读';

  @override
  String commonReadCount(int count) {
    return '$count人已读';
  }

  @override
  String get commonYouRecalledMessage => '你撤回了一条消息';

  @override
  String get commonMessageRecalled => '对方撤回了一条消息';

  @override
  String get commonReEdit => '重新编辑';

  @override
  String get commonWalletArea => '钱包功能区域';

  @override
  String get callIncomingCall => '来电';

  @override
  String get callMissedCall => '未接来电';

  @override
  String get groupRemoveAdmin => '取消管理员';

  @override
  String get chatSelectCurrency => '选择币种';

  @override
  String get chatSelectEmoji => '选择表情';

  @override
  String get chatSelectRedPacketCover => '选择封面';

  @override
  String get groupSetAsAdmin => '设为管理员';

  @override
  String get chatVideoPlaybackFailed => '视频播放失败';

  @override
  String get groupViewProfile => '查看资料';

  @override
  String get favoriteAddLinkComingSoon => '添加链接功能即将推出';

  @override
  String get favoriteNewNoteComingSoon => '新建笔记功能即将推出';

  @override
  String get qrcodeSaveFeatureComingSoon => '保存功能即将推出';

  @override
  String get qrcodeShareFeatureComingSoon => '分享功能即将推出';

  @override
  String qrcodeProcessFailed(String error) {
    return '处理二维码失败: $error';
  }

  @override
  String get securityDeviceIdRequired => '需要设备 ID';

  @override
  String securityVerificationStartFailed(String error) {
    return '启动验证失败: $error';
  }

  @override
  String get securityVerificationFailed => '验证失败';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return '验证失败: $reason';
  }

  @override
  String get securityEmojiMismatchRejected => '验证被拒绝 - 表情不匹配';

  @override
  String get securityWaitingForDeviceAccept => '等待另一台设备接受...';

  @override
  String get securityVerifyDevice => '验证此设备';

  @override
  String get securityConfirmEmojiMatch => '确认以下表情符号在两台设备上以相同顺序显示';

  @override
  String get securityEmojiDontMatch => '不匹配';

  @override
  String get securityEmojiMatch => '匹配';

  @override
  String get securityWaitingForDeviceConfirm => '等待另一台设备确认...';

  @override
  String get securityVerificationSuccess => '验证成功！';

  @override
  String get securityDeviceVerifiedTrusted => '此设备已验证并可信任。';

  @override
  String get securityCompareEmoji => '比较两台设备上的表情符号';

  @override
  String get securityCompareNumbers => '比较两台设备上的数字';

  @override
  String get commonTryAgain => '重试';

  @override
  String get commonDone => '完成';

  @override
  String get chatExportTitle => '导出聊天记录';

  @override
  String get chatExportSuccess => '导出成功';

  @override
  String chatExportFailed(String error) {
    return '导出失败: $error';
  }

  @override
  String get chatExportFormat => '导出格式';

  @override
  String get chatExportHtmlDesc => '可在任何浏览器中打开的精美排版';

  @override
  String get chatExportJsonDesc => '机器可读的结构化数据格式';

  @override
  String get chatExportDateRange => '日期范围';

  @override
  String get chatExportAll => '全部消息';

  @override
  String get chatExportLastWeek => '最近7天';

  @override
  String get chatExportLastMonth => '最近一个月';

  @override
  String get chatExportLast3Months => '最近三个月';

  @override
  String get chatExportMessageCount => '待导出消息';

  @override
  String get chatExportButton => '导出并分享';

  @override
  String get chatMediaGallery => '媒体文件';

  @override
  String get chatExportHistory => '导出聊天记录';

  @override
  String get pdfLoadFailed => '加载 PDF 失败';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => '全部';

  @override
  String get mediaImages => '图片';

  @override
  String get mediaVideos => '视频';

  @override
  String get mediaFiles => '文件';

  @override
  String get mediaAudio => '音频';

  @override
  String mediaItemsCount(int count) {
    return '$count 项';
  }

  @override
  String get mediaNoMediaFound => '暂无媒体文件';

  @override
  String get spacesTitle => '社区';

  @override
  String get spacesCreate => '创建社区';

  @override
  String get spacesJoined => '已加入';

  @override
  String get spacesDiscover => '发现';

  @override
  String get spacesNoJoined => '还没有加入任何社区';

  @override
  String get spacesExplore => '探索社区';

  @override
  String get spacesNoPublic => '没有找到公共社区';

  @override
  String get spacesJoin => '加入';

  @override
  String get spacesSubSpaces => '子社区';

  @override
  String get spacesChannels => '频道';

  @override
  String spacesMembersCount(int count) {
    return '$count 位成员';
  }

  @override
  String get spacesPublic => '公开';

  @override
  String get spacesPrivate => '私密';

  @override
  String get spacesSuggested => '推荐';

  @override
  String spacesChannelsCount(int count) {
    return '$count 个频道';
  }

  @override
  String get callInCallChat => '通话中聊天';

  @override
  String callMessagesCount(int count) {
    return '$count 条消息';
  }

  @override
  String get callNoMessagesYet => '暂无消息\n发送一条消息开始聊天';

  @override
  String get callTypeMessage => '输入消息...';

  @override
  String get callYouSender => '我';

  @override
  String get callChatLabel => '聊天';

  @override
  String get chatEdited => '已编辑';

  @override
  String get chatEditHistory => '编辑历史';

  @override
  String get chatOriginalMessage => '原始消息';

  @override
  String chatEditedAt(String time) {
    return '编辑于 $time';
  }

  @override
  String get chatViewOnce => '阅后即焚';

  @override
  String get chatViewOncePhoto => '阅后即焚照片';

  @override
  String get chatViewOnceVideo => '阅后即焚视频';

  @override
  String get chatViewOnceViewed => '已查看';

  @override
  String get chatViewOnceExpired => '已过期';

  @override
  String get chatViewOnceTap => '点击查看';

  @override
  String get chatAutoFaceBlur => '自动模糊人脸';

  @override
  String get chatAutoFaceBlurDesc => '发送照片时自动模糊人脸';

  @override
  String get threadReplyInThread => '在线程中回复';

  @override
  String threadReplies(int count) {
    return '$count 条回复';
  }

  @override
  String get threadReply => '1 条回复';

  @override
  String threadLatestReply(String preview) {
    return '最新: $preview';
  }

  @override
  String get threadTitle => '消息线程';

  @override
  String get threadReplyPlaceholder => '在线程中回复...';

  @override
  String threadParticipants(int count) {
    return '$count 位参与者';
  }

  @override
  String get voiceRoomTitle => '语音聊天室';

  @override
  String get voiceRoomCreate => '创建语音房间';

  @override
  String get voiceRoomJoin => '加入';

  @override
  String get voiceRoomLeave => '离开';

  @override
  String get voiceRoomEnd => '结束房间';

  @override
  String get voiceRoomRaiseHand => '举手';

  @override
  String get voiceRoomLowerHand => '放下手';

  @override
  String get voiceRoomMute => '静音';

  @override
  String get voiceRoomUnmute => '取消静音';

  @override
  String get voiceRoomHost => '主持人';

  @override
  String get voiceRoomSpeakers => '发言者';

  @override
  String get voiceRoomListeners => '听众';

  @override
  String get voiceRoomLive => '直播中';

  @override
  String get voiceRoomEnded => '已结束';

  @override
  String get voiceRoomScheduled => '已预约';

  @override
  String get voiceRoomApprove => '批准发言';

  @override
  String get voiceRoomDemote => '移至听众';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name 举手了';
  }

  @override
  String get voiceRoomName => '房间名称';

  @override
  String get voiceRoomTopic => '话题（可选）';

  @override
  String get voiceRoomNoActive => '暂无活跃的语音房间';

  @override
  String get voiceRoomConnecting => '连接中...';

  @override
  String get usernameTitle => '用户名';

  @override
  String get usernameSet => '设置用户名';

  @override
  String get usernameChange => '修改用户名';

  @override
  String get usernamePlaceholder => '输入用户名';

  @override
  String get usernameAvailable => '用户名可用';

  @override
  String get usernameUnavailable => '用户名已被占用';

  @override
  String get usernameInvalid => '3-30个字符，小写字母、数字、下划线，必须以字母开头';

  @override
  String get usernameReserved => '此用户名为保留名称';

  @override
  String get usernameSaved => '用户名已保存';

  @override
  String get usernameSearchHint => '通过 @用户名 搜索';

  @override
  String get ensName => 'ENS 域名';

  @override
  String get ensLinked => '已关联 ENS';

  @override
  String get ensResolving => '正在解析 ENS...';

  @override
  String get ensNotFound => '未找到 ENS 域名';

  @override
  String get tokenGateTitle => '代币门控';

  @override
  String get tokenGateEnable => '启用代币门控';

  @override
  String get tokenGateDisable => '禁用代币门控';

  @override
  String get tokenGateAddRule => '添加规则';

  @override
  String get tokenGateRemoveRule => '删除规则';

  @override
  String get tokenGateContractAddress => '合约地址';

  @override
  String get tokenGateMinBalance => '最低余额';

  @override
  String get tokenGateTokenId => 'Token ID (ERC-1155)';

  @override
  String get tokenGateChainId => '链 ID';

  @override
  String get tokenGateVerifying => '正在验证代币持有...';

  @override
  String get tokenGateVerified => '验证通过';

  @override
  String get tokenGateDenied => '您未满足代币要求';

  @override
  String get tokenGateOperatorAnd => '需满足所有规则';

  @override
  String get tokenGateOperatorOr => '满足任一规则即可';

  @override
  String get tokenGateRuleErc20 => 'ERC-20 代币';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => '多代币 (ERC-1155)';

  @override
  String get tokenGateRuleNative => '原生代币';

  @override
  String get tokenGateSaved => '代币门控已保存';

  @override
  String get tokenGateEnableDescription => '要求成员持有指定代币才能加入';

  @override
  String get tokenGateOperator => '规则逻辑';

  @override
  String get tokenGateRules => '规则列表';

  @override
  String get tokenGateSymbol => '代币符号（可选）';

  @override
  String get tokenGateChain => '区块链';

  @override
  String get tokenGateTokenStandard => '代币标准';

  @override
  String get tokenGateDenialMessage => '拒绝消息';

  @override
  String get tokenGateDenialMessageHint => '验证失败时显示的消息';

  @override
  String get tokenGateVerifyTitle => '代币验证';

  @override
  String get tokenGateVerifyPassed => '验证通过';

  @override
  String get tokenGateVerifyFailed => '验证未通过';

  @override
  String get tokenGateRetryVerify => '重新验证';

  @override
  String get tokenGateRequired => '要求';

  @override
  String get tokenGateYourBalance => '你的余额';

  @override
  String get tokenGateRulesActive => '条规则生效';

  @override
  String get tokenGateDisabled => '未启用';

  @override
  String get ensNotBound => '未绑定';

  @override
  String get liveLocation => '实时位置';

  @override
  String get stopLiveLocation => '停止共享';

  @override
  String get startLiveLocation => '开始共享';

  @override
  String get selectDuration => '选择共享时长';

  @override
  String get groupChatFiles => '聊天文件';

  @override
  String get groupLinks => '链接';

  @override
  String get groupNoLinks => '暂无链接';

  @override
  String get chatBackground => '聊天背景';

  @override
  String get solidColors => '纯色';

  @override
  String get gradients => '渐变';

  @override
  String get defaultBackground => '默认';

  @override
  String get settingsFontSizeSlider => '字体大小';

  @override
  String get autoDownload => '自动下载';

  @override
  String get images => '图片';

  @override
  String get voice => '语音';

  @override
  String get video => '视频';

  @override
  String get files => '文件';

  @override
  String get mobileData => '移动数据';

  @override
  String get roaming => '漫游';

  @override
  String get storageManagement => '存储管理';

  @override
  String get totalUsage => '总用量';

  @override
  String get cache => '缓存';

  @override
  String get other => '其他';

  @override
  String get clearCache => '清理缓存';

  @override
  String get cacheCleared => '缓存已清除';

  @override
  String get clearCacheFailed => '清理缓存失败';

  @override
  String get confirmClearCache => '确认清理所有缓存数据？';

  @override
  String get mapView => '地图视图';

  @override
  String liveLocationSharingCount(int count) {
    return '$count 人正在共享位置';
  }

  @override
  String get minutes15 => '15 分钟';

  @override
  String get minutes30 => '30 分钟';

  @override
  String get hour1 => '1 小时';

  @override
  String get hours8 => '8 小时';

  @override
  String get personalCard => '个人名片';

  @override
  String get downloadFailed => '下载失败';

  @override
  String get locationExpired => '已过期';

  @override
  String secondsRemaining(int count) {
    return '$count秒';
  }

  @override
  String minutesRemaining(int count) {
    return '$count分钟';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '$hours小时$minutes分钟';
  }

  @override
  String get favoriteMessages => '收藏消息';

  @override
  String get linksCopied => '链接已复制';

  @override
  String get noLinksFound => '未找到链接';

  @override
  String get roomStorageRanking => '房间存储排行';

  @override
  String get downloadComplete => '下载完成';

  @override
  String get downloading => '下载中...';

  @override
  String get draftSaved => '草稿已保存';

  @override
  String get voiceRecording => '语音录制';

  @override
  String get searchLocation => '搜索地点';

  @override
  String get tapToSearch => '点击搜索';

  @override
  String get settingsThisDevice => '本设备';

  @override
  String get settingsJustNow => '刚刚';

  @override
  String get settingsDeviceId => '设备 ID';

  @override
  String get settingsStatus => '状态';

  @override
  String get settingsLastActive => '最后活跃';

  @override
  String get settingsIpAddress => 'IP 地址';

  @override
  String get settingsRenameDevice => '重命名设备';

  @override
  String get settingsDeviceNameHint => '输入设备名称';

  @override
  String get settingsDeviceRenamed => '设备已重命名';

  @override
  String get settingsRenameFailed => '重命名失败';

  @override
  String get settingsRemoteLogout => '远程登出';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return '确定要登出「$deviceName」吗？此操作无法撤销。';
  }

  @override
  String get settingsDeviceLoggedOut => '设备已登出';

  @override
  String get settingsLogoutFailed => '登出失败';

  @override
  String get settingsLogout => '登出';

  @override
  String get settingsVerifyIdentity => '验证身份';

  @override
  String get settingsEnterPasswordToConfirm => '请输入密码以确认此操作。';

  @override
  String get scheduledSendTitle => '定时发送';

  @override
  String get scheduledSendInOneHour => '1小时后';

  @override
  String get scheduledSendTonight => '今晚 (20:00)';

  @override
  String get scheduledSendTomorrowMorning => '明早 (9:00)';

  @override
  String get scheduledSendCustom => '自定义时间';

  @override
  String get scheduledMessageLabel => '定时发送';

  @override
  String get scheduledMessageCancel => '取消定时发送';

  @override
  String get chatLockTitle => '聊天锁';

  @override
  String get chatLockEnable => '锁定此聊天';

  @override
  String get chatLockDisable => '解锁此聊天';

  @override
  String get chatLockDescription => '锁定的聊天需要通过生物识别或 PIN 码验证才能打开';

  @override
  String get chatLockVerifyTitle => '聊天已锁定';

  @override
  String get chatLockVerifySubtitle => '验证后访问此聊天';

  @override
  String get chatLockVerifyFailed => '验证失败';

  @override
  String get chatLockEnabled => '聊天已锁定';

  @override
  String get chatLockDisabled => '聊天已解锁';

  @override
  String get chatLockPinTitle => '输入 PIN 码';

  @override
  String get chatLockPinSetTitle => '设置 PIN 码';

  @override
  String get chatLockPinConfirmTitle => '确认 PIN 码';

  @override
  String get chatLockPinMismatch => 'PIN 码不一致';

  @override
  String get chatLockUseBiometric => '使用生物识别';

  @override
  String get chatLockUsePin => '使用 PIN 码';

  @override
  String get mediaEditorUndo => '撤销';

  @override
  String get mediaEditorRedo => '重做';

  @override
  String get mediaEditorCrop => '裁剪';

  @override
  String get mediaEditorFilter => '滤镜';

  @override
  String get mediaEditorDraw => '涂鸦';

  @override
  String get mediaEditorText => '文字';

  @override
  String get aiAssistant => 'AI 助手';

  @override
  String get aiAssistantWelcome => '你好！我是 N42 AI 助手，有什么可以帮你的吗？';

  @override
  String get aiAssistantNotConfigured => 'AI 服务未配置';

  @override
  String get aiAssistantSettings => 'AI 设置';

  @override
  String get aiAssistantClearHistory => '清空对话历史';

  @override
  String get aiAssistantClearHistoryConfirm => '确定清空所有 AI 对话历史？';

  @override
  String get aiAssistantStopGenerating => '停止生成';

  @override
  String get aiAssistantModel => '模型';

  @override
  String get aiAssistantTemperature => '温度';

  @override
  String get aiAssistantMaxTokens => '最大令牌数';

  @override
  String get aiAssistantContextWindow => '上下文窗口';

  @override
  String get aiAssistantServiceStatus => '服务状态';

  @override
  String get aiAssistantAvailable => '可用';

  @override
  String get aiAssistantUnavailable => '不可用';

  @override
  String get aiSummarize => 'AI 总结';

  @override
  String aiSummarizeUnread(int count) {
    return 'AI 总结 $count 条未读消息';
  }

  @override
  String get aiSummarizeLoading => '正在总结...';

  @override
  String get aiSummarizeError => '总结失败';

  @override
  String get aiRewrite => 'AI 改写';

  @override
  String get aiRewriteFormal => '正式';

  @override
  String get aiRewriteCasual => '轻松';

  @override
  String get aiRewritePlayful => '俏皮';

  @override
  String get aiRewriteProfessional => '专业';

  @override
  String get aiRewriteAccept => '使用';

  @override
  String get aiRewriteCancel => '取消';

  @override
  String get aiRewriteLoading => '正在改写...';

  @override
  String get aiLinkSummary => 'AI 摘要';

  @override
  String get aiLinkSummaryAnalyzing => '正在分析...';

  @override
  String get chatFolderManagement => '管理文件夹';

  @override
  String get chatFolderSystem => '系统文件夹';

  @override
  String get chatFolderCustom => '自定义文件夹';

  @override
  String get chatFolderEmpty => '暂无自定义文件夹';

  @override
  String get chatFolderCreate => '创建文件夹';

  @override
  String get chatFolderEdit => '编辑文件夹';

  @override
  String get chatFolderNameHint => '文件夹名称';

  @override
  String get chatFolderAll => '全部';

  @override
  String get chatFolderUnread => '未读';

  @override
  String get chatFolderPersonal => '私聊';

  @override
  String get chatFolderGroups => '群组';

  @override
  String get chatFolderChannels => '频道';

  @override
  String get chatFolderMuted => '已静音';

  @override
  String get storyAddMusic => '添加音乐';

  @override
  String get storyChangeMusic => '更换音乐';

  @override
  String get storyBackgroundMusic => '背景音乐';

  @override
  String get storyMusicPreview => '预览 (最长15秒)';

  @override
  String get storyChooseFromDevice => '从设备选择';

  @override
  String get storyUseThisMusic => '使用此音乐';

  @override
  String get authPasskeyNotSupported => '此设备不支持 Passkey';

  @override
  String get authPasskeyRegister => '注册 Passkey';

  @override
  String get authPasskeyNoRegistered => '未注册 Passkey';

  @override
  String get authPasskeyRegisterHint => '注册 Passkey 以实现无密码登录';

  @override
  String get authPasskeyNameYours => '为 Passkey 命名';

  @override
  String get authPasskeyRegistered => 'Passkey 注册成功';

  @override
  String get authPasskeyDeleted => 'Passkey 已删除';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return '删除 Passkey \"$name\"？删除后将无法使用该 Passkey 登录。';
  }

  @override
  String get momentVisibilityPublic => '公开';

  @override
  String get momentVisibilityPrivate => '私密';

  @override
  String get momentVisibilityPartial => '部分可见';

  @override
  String get momentVisibilityExcluded => '不给谁看';

  @override
  String momentUserMoments(String userName) {
    return '$userName的朋友圈';
  }

  @override
  String get momentForwardTo => '转发给';

  @override
  String get momentForwardSuccess => '转发成功';

  @override
  String get momentSelectFriends => '选择好友';

  @override
  String get momentSelectTags => '按标签选择';

  @override
  String momentSelectedCount(int count) {
    return '已选择 ($count)';
  }

  @override
  String get momentNoMomentsYet => '暂无动态';

  @override
  String get momentForwardMoment => '转发动态';

  @override
  String get momentAddComment => '写评论...';

  @override
  String momentForwardContent(String content) {
    return '[朋友圈] $content';
  }

  @override
  String get momentDeleteMoment => '删除动态';

  @override
  String get momentDeleteConfirm => '确定要删除这条动态吗？';

  @override
  String get momentComment => '评论';

  @override
  String get momentWriteComment => '写评论...';

  @override
  String get momentLike => '赞';

  @override
  String get momentUnlike => '取消';

  @override
  String get momentForward => '转发';

  @override
  String get momentDelete => '删除';

  @override
  String get momentReply => '回复';

  @override
  String get momentMoment => '动态';

  @override
  String momentLikesCount(int count) {
    return '$count 个赞';
  }

  @override
  String momentCommentsCount(int count) {
    return '$count 条评论';
  }

  @override
  String get momentNoComments => '暂无评论';

  @override
  String get momentFailedToLoad => '图片加载失败';

  @override
  String momentReplyTo(String userName) {
    return '回复 $userName...';
  }

  @override
  String get momentNoConversations => '暂无会话';

  @override
  String get momentJustNow => '刚刚';

  @override
  String momentMinutesAgo(int count) {
    return '$count分钟前';
  }

  @override
  String momentHoursAgo(int count) {
    return '$count小时前';
  }

  @override
  String momentDaysAgo(int count) {
    return '$count天前';
  }

  @override
  String get chatGroupAnnouncementHint => '输入群公告';

  @override
  String get chatGroupAnnouncementEmpty => '暂无群公告';

  @override
  String get chatEditNickname => '编辑群昵称';

  @override
  String get chatNicknameHint => '输入你在群里的昵称';

  @override
  String get contactAddPhoneHint => '输入电话号码';

  @override
  String get contactNotesHint => '添加联系人备忘';

  @override
  String get reportTitle => '投诉';

  @override
  String get reportReasonSpam => '垃圾信息';

  @override
  String get reportReasonHarassment => '骚扰';

  @override
  String get reportReasonFraud => '欺诈';

  @override
  String get reportReasonOther => '其他';

  @override
  String get reportSubmitted => '投诉已提交';

  @override
  String get reportDescription => '补充说明（选填）';

  @override
  String get qrcodeSaved => '二维码已保存到相册';

  @override
  String get chatSendRedPacketInChat => '请在聊天中发送红包';

  @override
  String get commonSaveFailed => '保存失败';

  @override
  String get reportSelectReason => '请选择投诉原因';
}
