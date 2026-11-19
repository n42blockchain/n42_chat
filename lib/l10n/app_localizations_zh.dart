// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get commonRetry => '重試';

  @override
  String get commonUnknownUser => '未知用戶';

  @override
  String get transferWalletNotConnected => '錢包未連接';

  @override
  String get chatCallServiceNotInitialized => '通話服務未初始化';

  @override
  String authLoginFailed(Object error) {
    return '登錄失敗: $error';
  }

  @override
  String get chatCallBack => '回撥';

  @override
  String get chatMissedVideoCall => '未接視頻通話';

  @override
  String get chatMissedVoiceCall => '未接語音通話';

  @override
  String get chatCallNotAnswered => '對方未接聽';

  @override
  String get chatCallDurationLabel => '通話時長';

  @override
  String get chatVoiceCallCancelled => '語音通話已取消';

  @override
  String get chatVideoCallCancelled => '視頻通話已取消';

  @override
  String get commonImage => '[圖片]';

  @override
  String get chatVideo => '[視頻]';

  @override
  String get chatVoice => '[語音]';

  @override
  String get commonFile => '[文件]';

  @override
  String get chatLocation => '[位置]';

  @override
  String get chatUnknownMessage => '[未知消息]';

  @override
  String get commonDelete => '刪除';

  @override
  String get chatDeleteThisMessage => '刪除這條消息？';

  @override
  String get chatMessageDeleted => '消息已刪除';

  @override
  String get profileNotLoggedIn => '未登錄';

  @override
  String get chatMyLocation => '我的位置';

  @override
  String get commonGroupChat => '羣聊';

  @override
  String get commonSearch => '搜索';

  @override
  String get commonCancel => '取消';

  @override
  String get commonLoadFailed => '加載失敗';

  @override
  String get commonMessages => '消息';

  @override
  String get commonContacts => '聯繫人';

  @override
  String get commonMe => '我';

  @override
  String get commonVoiceLoading => '語音加載中，請稍後再試';

  @override
  String get commonVoiceToTextFailed => '語音轉文字失敗';

  @override
  String get commonConvertToText => '轉文字';

  @override
  String get chatCopy => '複製';

  @override
  String get commonForward => '轉發';

  @override
  String get commonUnfavorite => '取消收藏';

  @override
  String get commonFavorite => '收藏';

  @override
  String get settingsResend => '重新發送';

  @override
  String get chatRecall => '撤回';

  @override
  String get commonQuote => '引用';

  @override
  String get commonRemind => '提醒';

  @override
  String get chatCopied => '已複製';

  @override
  String get storySendMessageHint => '發送消息';

  @override
  String get commonMicrophonePermissionRequired => '請允許使用麥克風權限';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麥克風權限已被拒絕，請在系統設置中開啓以使用語音消息功能。';

  @override
  String commonStartRecordingFailed(Object error) {
    return '開始錄音失敗: $error';
  }

  @override
  String get commonRecordingTooShort => '錄音時間太短';

  @override
  String commonStopRecordingFailed(Object error) {
    return '停止錄音失敗: $error';
  }

  @override
  String get chatReleaseToCancel => '鬆開取消';

  @override
  String get chatReleaseToSend => '鬆開發送，上滑取消';

  @override
  String get commonHoldToTalk => '按住 說話';

  @override
  String get commonSend => '發送';

  @override
  String get commonAddFriend => '添加好友';

  @override
  String get commonChatServiceNotConnected => '聊天服務未連接';

  @override
  String contactUserNotFoundHint(String query) {
    return '未找到用戶 \"$query\"\n\n提示：\n• 嘗試輸入完整用戶ID，如 @username:server.com\n• 確認用戶名拼寫正確';
  }

  @override
  String contactCreateChatFailed(String error) {
    return '創建會話失敗: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return '搜索失敗: $error';
  }

  @override
  String get contactEnterUserIdOrUsername => '輸入用戶 ID 或用戶名搜索';

  @override
  String get contactSearching => '搜索中...';

  @override
  String get contactSearchUserToChat => '搜索用戶開始聊天';

  @override
  String get contactMatrixIdExample =>
      '可以輸入完整的 Matrix ID\n例如: @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return '未找到用戶 \"$username\"';
  }

  @override
  String get commonChat => '聊天';

  @override
  String get commonSettings => '設置';

  @override
  String get profileEditProfile => '編輯資料';

  @override
  String get authLogin => '登錄';

  @override
  String get commonCreateGroup => '創建羣聊';

  @override
  String get chatError => '錯誤';

  @override
  String get commonTransfer => '轉賬';

  @override
  String get commonReceived => '已被接收';

  @override
  String get commonRefunded => '已退還';

  @override
  String get commonExpired => '已過期';

  @override
  String get chatRedPacketGreeting => '恭喜發財，大吉大利';

  @override
  String get commonN42RedPacket => 'N42紅包';

  @override
  String get commonClaimed => '已領取';

  @override
  String get commonAllClaimed => '已被領完';

  @override
  String get chatReadAloud => '朗讀';

  @override
  String get chatReply => '回覆';

  @override
  String get commonEdit => '編輯';

  @override
  String get chatSelectForwardTarget => '選擇轉發對象';

  @override
  String commonSendCount(int count) {
    return '發送($count)';
  }

  @override
  String contactN42Id(Object id) {
    return 'N42號：$id';
  }

  @override
  String get profileN42IdTitle => 'N42號';

  @override
  String get profileN42Bean => 'N42豆';

  @override
  String get contactFriendInfo => '朋友資料';

  @override
  String get contactFriendInfoDesc => '添加朋友的備註名、電話、標籤、備忘、照片等，並設置朋友權限。';

  @override
  String get commonMoments => '朋友圈';

  @override
  String get commonSendMessage => '發消息';

  @override
  String get contactAudioVideoCall => '音視頻通話';

  @override
  String get contactVideoChannel => '視頻號';

  @override
  String get contactRemark => '備註';

  @override
  String get contactRemarkName => '備註名';

  @override
  String get contactPhone => '電話';

  @override
  String get contactTags => '標籤';

  @override
  String get contactNotes => '備忘';

  @override
  String get contactPhotos => '照片';

  @override
  String get contactPermissions => '權限';

  @override
  String get contactChatMomentsEtc => '聊天、朋友圈、運動等';

  @override
  String get contactMoreInfo => '更多信息';

  @override
  String get contactCommonGroups => '我和他 (她) 的共同羣聊';

  @override
  String get contactSource => '來源';

  @override
  String get settingsNotificationSettings => '消息通知';

  @override
  String get settingsPrivacy => '隱私';

  @override
  String get settingsAppearance => '外觀';

  @override
  String get settingsAbout => '關於';

  @override
  String get commonLogout => '退出登錄';

  @override
  String get commonLogoutConfirm => '確定要退出登錄嗎？';

  @override
  String get commonSave => '保存';

  @override
  String get profileNickname => '暱稱';

  @override
  String get profileEnterNickname => '請輸入暱稱';

  @override
  String get profileSignature => '簽名';

  @override
  String get profileAddSignature => '添加個性簽名';

  @override
  String get commonTakePhoto => '拍照';

  @override
  String get profileChooseFromGallery => '從相冊選擇';

  @override
  String profileSaveFailed(Object error) {
    return '保存失敗: $error';
  }

  @override
  String get authSecureDecentralizedChat => '安全、去中心化的即時通訊';

  @override
  String get commonEndToEndEncryption => '端到端加密';

  @override
  String get authMessagesOnlyYouCanSee => '消息僅你和對方可見';

  @override
  String get authDecentralized => '去中心化';

  @override
  String get authBasedOnMatrix => '基於Matrix開放協議';

  @override
  String get authWalletIntegration => '錢包集成';

  @override
  String get authEasyCryptoTransfer => '輕鬆進行加密貨幣轉賬';

  @override
  String get authRegister => '註冊';

  @override
  String get authAgreeTerms => '登錄即表示同意';

  @override
  String get authTermsOfService => '《服務協議》';

  @override
  String get authAnd => '和';

  @override
  String get authPrivacyPolicy => '《隱私政策》';

  @override
  String get authServerAddress => '服務器地址';

  @override
  String get authEnterServerAddress => '請輸入服務器地址';

  @override
  String authConnectedTo(Object serverName) {
    return '已連接到 $serverName';
  }

  @override
  String get authUsername => '用戶名';

  @override
  String get authEnterUsername => '請輸入用戶名';

  @override
  String get authUsernameOrEmail => '用戶名或郵箱';

  @override
  String get authEnterUsernameOrEmail => '請輸入用戶名或郵箱';

  @override
  String get authPassword => '密碼';

  @override
  String get authEnterPassword => '請輸入密碼';

  @override
  String get authRegisterAccount => '註冊賬號';

  @override
  String get authForgotPassword => '忘記密碼';

  @override
  String get authOtherLoginMethods => '其他登錄方式';

  @override
  String get authCreateAccount => '創建賬號';

  @override
  String get authJoinN42Chat => '加入 N42 Chat 開始聊天';

  @override
  String get authUsernameHint => '3-20字符，字母/數字/_';

  @override
  String get authUsernameMinLength => '用戶名至少3個字符';

  @override
  String get authUsernameMaxLength => '用戶名最多20個字符';

  @override
  String get authUsernameFormat => '用戶名只能包含字母、數字和下劃線';

  @override
  String get authPasswordHint => '至少8位';

  @override
  String get commonPasswordMinLength => '密碼至少8位';

  @override
  String get authConfirmPassword => '確認密碼';

  @override
  String get authFilled => '已填寫';

  @override
  String get authEnterInviteCode => '請輸入邀請碼';

  @override
  String get authAlreadyHaveAccount => '已有賬號？';

  @override
  String get authLoginNow => '立即登錄';

  @override
  String get profileAvatar => '頭像';

  @override
  String get profileStatus => '狀態';

  @override
  String get commonLoading => '加載中...';

  @override
  String get conversationNoConversations => '暫無會話';

  @override
  String get conversationTapToChat => '點擊右上角開始聊天';

  @override
  String get conversationStartGroup => '發起羣聊';

  @override
  String get commonScan => '掃一掃';

  @override
  String get commonPayment => '收付款';

  @override
  String commonFeatureComingSoon(Object feature) {
    return '$feature 功能即將推出';
  }

  @override
  String get conversationMarkAsRead => '標記已讀';

  @override
  String get commonUnmute => '取消靜音';

  @override
  String get commonMute => '消息免打擾';

  @override
  String get conversationUnpin => '取消置頂';

  @override
  String get conversationPin => '置頂';

  @override
  String get conversationDeleteConversation => '刪除會話';

  @override
  String conversationDeleteConversationConfirm(Object name) {
    return '確定要刪除與 $name 的會話嗎？';
  }

  @override
  String get commonNoContacts => '暫無聯繫人';

  @override
  String get contactAddFriendsToChat => '添加好友開始聊天';

  @override
  String get contactNotFound => '未找到聯繫人';

  @override
  String get contactTryOtherKeywords => '嘗試搜索其他關鍵詞或全局搜索';

  @override
  String get contactSearchResults => '搜索結果';

  @override
  String get contactNewFriends => '新的朋友';

  @override
  String get contactChatOnlyFriends => '僅聊天的朋友';

  @override
  String get contactOfficialAccounts => '公衆號';

  @override
  String get contactServiceAccounts => '服務號';

  @override
  String get contactEnterpriseContacts => '企業聯繫人';

  @override
  String get contactRecommendToFriend => '推薦給朋友';

  @override
  String get commonSetRemark => '設置備註';

  @override
  String get contactSendingCard => '正在發送名片...';

  @override
  String get commonFileLabel => '文件';

  @override
  String get commonLocationLabel => '位置';

  @override
  String contactRecommendFailed(Object error) {
    return '推薦失敗: $error';
  }

  @override
  String get profileEnterRemark => '請輸入備註名';

  @override
  String get contactOpeningChat => '正在打開聊天...';

  @override
  String contactOpenChatFailed(Object error) {
    return '打開聊天失敗: $error';
  }

  @override
  String get contactAddContact => '添加聯繫人';

  @override
  String get contactEnterUserId => '輸入用戶ID';

  @override
  String get contactNoFriendRequests => '暫無好友請求';

  @override
  String get commonAccept => '接受';

  @override
  String get commonReject => '拒絕';

  @override
  String get commonNoGroups => '暫無羣聊';

  @override
  String get contactSelectFriendToRecommend => '選擇要推薦給的朋友';

  @override
  String get commonSearchContacts => '搜索聯繫人';

  @override
  String get contactNoContactsFound => '沒有找到聯繫人';

  @override
  String get favoriteYesterday => '昨天';

  @override
  String get chatJustNow => '剛剛';

  @override
  String get profileOnline => '在線';

  @override
  String get profileOffline => '離線';

  @override
  String get searchContactsGroupsMessages => '搜索聯繫人、羣聊和消息';

  @override
  String get searchError => '搜索出錯';

  @override
  String get chatSearchHint => '搜索';

  @override
  String get searchHistory => '搜索歷史';

  @override
  String get commonClear => '清除';

  @override
  String get commonAll => '全部';

  @override
  String get searchGroups => '羣聊';

  @override
  String get searchNoResults => '無結果';

  @override
  String commonGroupMembers(Object count) {
    return '羣成員 ($count)';
  }

  @override
  String get groupMembersTitle => '羣成員';

  @override
  String get groupViewAll => '查看全部';

  @override
  String get groupOwner => '羣主';

  @override
  String get groupAdmin => '管理';

  @override
  String get groupInvite => '邀請';

  @override
  String get commonGroupAnnouncement => '羣公告';

  @override
  String get commonNotSet => '未設置';

  @override
  String get groupDescription => '羣簡介';

  @override
  String get groupPublicGroup => '公開羣聊';

  @override
  String get commonClearChatHistory => '清空聊天記錄';

  @override
  String get commonDissolveGroup => '解散羣聊';

  @override
  String get commonLeaveGroup => '退出羣聊';

  @override
  String get groupChangeGroupName => '修改羣名稱';

  @override
  String get commonEnterGroupName => '請輸入羣名稱';

  @override
  String get commonConfirm => '確認';

  @override
  String get groupEnterGroupDescription => '請輸入羣簡介';

  @override
  String get groupPublish => '发布';

  @override
  String get chatClearHistoryConfirm => '確定要清空聊天記錄嗎？此操作不可恢復。';

  @override
  String get chatClearAction => '清空';

  @override
  String get commonChatHistoryCleared => '聊天記錄已清空';

  @override
  String get commonDissolve => '解散';

  @override
  String get groupQrCode => '羣二維碼';

  @override
  String get commonSearchChatHistory => '查找聊天記錄';

  @override
  String get groupIdCopied => '羣ID已複製';

  @override
  String get transferEnterOrPasteAddress => '輸入或粘貼錢包地址';

  @override
  String get transferSelectToken => '選擇代幣';

  @override
  String get commonTransferAmount => '轉賬金額';

  @override
  String get transferAvailable => '可用';

  @override
  String get transferMemoOptional => '備註（可選）';

  @override
  String get transferConfirmTransfer => '確認轉賬';

  @override
  String get transferAddressVerified => '地址已驗證';

  @override
  String transferAvailableBalance(Object balance, Object symbol) {
    return '可用餘額: $balance $symbol';
  }

  @override
  String get commonEnterAmount => '請輸入金額';

  @override
  String get commonRedPacketCountMin => '紅包個數至少爲1';

  @override
  String get commonViewRedPacketDetails => '查看紅包詳情';

  @override
  String get commonEnterTransferAmount => '請輸入轉賬金額';

  @override
  String get commonTransferTo => '轉賬給';

  @override
  String commonFromSender(String name) {
    return '來自 $name';
  }

  @override
  String get commonConfirmReceive => '確認收款';

  @override
  String get groupProfile => '羣資料';

  @override
  String get groupRemoveMember => '移出羣聊';

  @override
  String get commonRemove => '移出';

  @override
  String get profileClearStatus => '清除狀態';

  @override
  String get profileClearStatusConfirm => '確定要清除當前狀態嗎？';

  @override
  String get profileStatusCleared => '狀態已清除';

  @override
  String get profileUserNotExist => '用戶不存在';

  @override
  String get profileUserIdCopied => '用戶ID已複製';

  @override
  String get commonReport => '舉報';

  @override
  String get profileQrCode => '二維碼';

  @override
  String get profileAvatarUpdated => '頭像更新成功';

  @override
  String commonSelectImageFailed(Object error) {
    return '選擇圖片失敗: $error';
  }

  @override
  String get profileChangeName => '修改名字';

  @override
  String get profileMale => '男';

  @override
  String get profileFemale => '女';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature功能開發中...';
  }

  @override
  String profileSaveAddressFailed(Object error) {
    return '保存地址失敗: $error';
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
  String get profileDeleteAddress => '刪除地址';

  @override
  String get profileAddressDeleted => '地址已刪除';

  @override
  String profileSaveInvoiceFailed(Object error) {
    return '保存發票抬頭失敗: $error';
  }

  @override
  String get profileMyInvoices => '我的發票抬頭';

  @override
  String get profileAddInvoice => '添加發票抬頭';

  @override
  String get profileInvoiceAdded => '發票抬頭添加成功';

  @override
  String get profileInvoiceUpdated => '發票抬頭更新成功';

  @override
  String get profileDeleteInvoice => '刪除發票抬頭';

  @override
  String get profileInvoiceDeleted => '發票抬頭已刪除';

  @override
  String get profilePersonal => '個人';

  @override
  String get groupSelectAtLeastOne => '請至少選擇一位成員';

  @override
  String get chatFileNotExist => '文件不存在';

  @override
  String chatSendFailed(String error) {
    return '發送失敗: $error';
  }

  @override
  String get chatCannotOpenBrowser => '無法打開瀏覽器';

  @override
  String chatSelectFileFailed(String error) {
    return '選擇文件失敗: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return '設置失敗: $error';
  }

  @override
  String get transferEnterValidAmount => '請輸入有效的轉賬金額';

  @override
  String get commonAddressCopied => '地址已複製';

  @override
  String favoriteOpenItem(Object content) {
    return '打開: $content';
  }

  @override
  String get favoriteDeleted => '已刪除';

  @override
  String get profileWallet => '錢包';

  @override
  String get chatRecording => '錄像';

  @override
  String get chatInvalidVideoUrl => '無效的視頻鏈接';

  @override
  String get chatDownloadFile => '下載文件';

  @override
  String get chatClearChatHistoryTitle => '清空聊天記錄';

  @override
  String get chatVideoCall => '視頻通話';

  @override
  String get commonVoiceCall => '語音通話';

  @override
  String get callLeaveMeeting => '離開會議';

  @override
  String get chatDetails => '聊天詳情';

  @override
  String get chatViewAllGroupMembers => '查看全部羣成員';

  @override
  String get chatGroupName => '羣聊名稱';

  @override
  String get chatGroupNameUpdated => '羣名稱已更新';

  @override
  String get chatUpdateFailed => '更新失敗';

  @override
  String get chatNoPermissionToModify => '您沒有修改權限';

  @override
  String get chatGroupManagement => '羣管理';

  @override
  String get chatMyNicknameInGroup => '我在本羣的暱稱';

  @override
  String get chatPinChat => '置頂聊天';

  @override
  String get chatStrongReminder => '強提醒';

  @override
  String get chatSetChatBackground => '設置當前聊天背景';

  @override
  String get chatUnknownFile => '未知文件';

  @override
  String get chatDownload => '下載';

  @override
  String get chatInvalidLocation => '無效的位置';

  @override
  String get chatTapToCancel => '點擊取消';

  @override
  String chatCaptureFailed(Object error) {
    return '拍攝失敗: $error';
  }

  @override
  String get chatProcessingVideo => '正在處理視頻...';

  @override
  String get chatVideoFileNotExist => '視頻文件不存在';

  @override
  String get chatVideoDataEmpty => '視頻數據爲空';

  @override
  String get chatVideoTooLarge => '視頻大小不能超過 100MB';

  @override
  String get chatSendingVideo => '視頻發送中...';

  @override
  String chatSendVideoFailed(Object error) {
    return '發送視頻失敗: $error';
  }

  @override
  String get chatImageFileNotExist => '圖片文件不存在';

  @override
  String get commonImageDataEmpty => '圖片數據爲空';

  @override
  String get chatSendingImage => '圖片發送中...';

  @override
  String chatSendImageFailed(Object error) {
    return '發送圖片失敗: $error';
  }

  @override
  String get chatSendLocation => '發送位置';

  @override
  String get chatSelectLocationAndSend => '選擇地點併發送給對方';

  @override
  String get chatShareRealTimeLocation => '共享實時位置';

  @override
  String get chatShareLocationForOneHour => '與好友共享1小時實時位置';

  @override
  String get chatLocationSent => '位置已發送';

  @override
  String get chatSelectMessages => '選擇消息';

  @override
  String chatSelectedCount(int count) {
    return '已選擇 $count';
  }

  @override
  String get chatSelectAll => '全選';

  @override
  String chatGroupChatCount(int count) {
    return '羣聊($count)';
  }

  @override
  String get chatPrivateChat => '私聊';

  @override
  String get chatNoMessages => '暂无消息';

  @override
  String get chatSendFirstMessage => '發送第一條消息開始聊天';

  @override
  String get chatEncryptionNotice => '此聊天已啓用端到端加密。只有您和對方可以閱讀消息。';

  @override
  String get chatMultiForward => '轉發';

  @override
  String get chatCollect => '收藏';

  @override
  String get chatNoMembers => '沒有成員';

  @override
  String get chatMemberNotFound => '未找到成員';

  @override
  String get chatVoiceFileNotExist => '語音文件不存在';

  @override
  String get chatVoiceFileEmpty => '語音文件爲空';

  @override
  String get chatSendingVoice => '語音發送中...';

  @override
  String chatSendVoiceFailed(Object error) {
    return '發送語音失敗: $error';
  }

  @override
  String get chatMessageForwarded => '消息已轉發';

  @override
  String chatForwardFailed(Object error) {
    return '轉發失敗: $error';
  }

  @override
  String get chatUnfavorited => '已取消收藏';

  @override
  String get chatFavorited => '已收藏';

  @override
  String get chatReactionAdded => '已添加表情回應';

  @override
  String get chatReactionRemoved => '已移除表情回應';

  @override
  String get chatFailedMessageDeleted => '已刪除失敗消息';

  @override
  String get chatDeleteMessages => '刪除消息';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return '確定要刪除 $count 條消息嗎？';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return '注意：$count 條消息來自他人，僅對你刪除。';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count 條你發送的消息將對所有人撤回。';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return '已撤回 $count 條消息，$localCount 條僅對你刪除';
  }

  @override
  String chatRecalledMessages(Object count) {
    return '已撤回 $count 條消息';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count 條消息僅對你刪除';
  }

  @override
  String chatForwardedCount(Object count) {
    return '已轉發 $count 條消息';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return '轉發完成：成功 $success 條，失敗 $failed 條';
  }

  @override
  String get chatRemindOnlyInGroup => '提醒功能僅在羣聊中可用';

  @override
  String get chatOnlyTextSearchable => '僅支持搜索文本消息';

  @override
  String chatSearchFor(Object text) {
    return '搜索 \"$text\"';
  }

  @override
  String get chatBaiduSearch => '百度搜索';

  @override
  String get chatGoogleSearch => 'Google 搜索';

  @override
  String get chatBingSearch => '必應搜索';

  @override
  String get chatCalling => '呼叫中...';

  @override
  String get chatRinging => '響鈴中...';

  @override
  String get chatInCall => '通話中';

  @override
  String commonFeatureInDevelopment(Object feature) {
    return '$feature功能開發中...';
  }

  @override
  String chatCollectMessages(Object count) {
    return '已收藏 $count 條消息';
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
  String get profileServices => '服務';

  @override
  String get commonFavorites => '收藏';

  @override
  String get profileOrdersAndCards => '訂單與卡包';

  @override
  String get profileStickers => '表情';

  @override
  String profileStatusSetTo(String status) {
    return '狀態已設置爲：$status';
  }

  @override
  String get profileAvatarUploadFailed => '頭像上傳失敗';

  @override
  String get profilePersonalProfile => '個人信息';

  @override
  String get profileName => '名字';

  @override
  String get profileGender => '性別';

  @override
  String get profileRegion => '地區';

  @override
  String get commonMyQrCode => '我的二維碼';

  @override
  String get profilePoke => '拍一拍';

  @override
  String get profileRingtone => '來電鈴聲';

  @override
  String get profileDefaultRingtone => '默認鈴聲';

  @override
  String get profileMyAddresses => '我的地址';

  @override
  String profileGenderSetTo(String gender) {
    return '性別已設置爲：$gender';
  }

  @override
  String get profileSelectRegion => '選擇地區';

  @override
  String get profileSelectCity => '選擇城市';

  @override
  String profileRegionSetTo(String region) {
    return '地區已設置爲：$region';
  }

  @override
  String get profileSetPoke => '設置拍一拍';

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
    return '拍一拍已設置爲：拍了拍我$suffix';
  }

  @override
  String get profileEditSignature => '編輯個性簽名';

  @override
  String get profileIntroduceYourself => '一句話介紹自己';

  @override
  String get profileSignatureCleared => '個性簽名已清除';

  @override
  String get profileSignatureUpdated => '個性簽名已更新';

  @override
  String get profileScanToAddFriend => '掃一掃上面的二維碼圖案，加我爲好友';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return '來電鈴聲已設置爲：$ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return '確定要解散羣聊「$name」嗎？此操作無法撤銷。';
  }

  @override
  String get authEnterValidServerAddress => '請輸入有效的服務器地址';

  @override
  String get authEnterServerAddressFirst => '請先輸入服務器地址';

  @override
  String get authPasskeyRequiresServer => 'Passkey登錄需要服務器支持';

  @override
  String get authLoginAgreement => '登錄即表示同意';

  @override
  String get authPleaseAgreeToTerms => '請先閱讀並同意服務協議和隱私政策';

  @override
  String get authRegisterFailed => '註冊失敗';

  @override
  String get authRegistrationDisabled => '此服务器已关闭注册，请联系服务器管理员开放注册。';

  @override
  String get commonReenterPassword => '請再次輸入密碼';

  @override
  String get commonPasswordsDoNotMatch => '兩次輸入的密碼不一致';

  @override
  String get authInviteCodeBuiltIn => '邀請碼（已內置）';

  @override
  String get authInviteCodeBuiltInNote => '邀請碼已內置，通常無需修改';

  @override
  String get authIHaveReadAndAgree => '我已閱讀並同意';

  @override
  String get mainStartGroupChat => '發起羣聊';

  @override
  String get mainAddFriends => '添加朋友';

  @override
  String get mainPaymentAndCollection => '收付款';

  @override
  String contactCount(int count) {
    return '$count位聯繫人';
  }

  @override
  String get contactAddToHomeScreen => '添加到桌面';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return '已將$contact的名片推薦給$recipient';
  }

  @override
  String get contactEnterRemarkName => '請輸入備註名';

  @override
  String contactRemarkSetTo(String remark) {
    return '備註已設置爲：$remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return '已接受$name的好友請求';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return '已拒絕$name的好友請求';
  }

  @override
  String get commonGroupInvites => '羣邀請';

  @override
  String commonMyGroups(int count) {
    return '我的羣聊 ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => '邀請加入羣聊';

  @override
  String commonConfirmLeaveGroup(String name) {
    return '確定要退出羣聊「$name」嗎？';
  }

  @override
  String get commonLeave => '離開';

  @override
  String get commonRecallThisMessage => '撤回該條消息？';

  @override
  String get commonSavedToGallery => '已保存到相冊';

  @override
  String get commonFailedToSave => '保存失敗';

  @override
  String get chatSaving => '保存中...';

  @override
  String get commonShare => '分享';

  @override
  String get chatSaveToGallery => '保存到相冊';

  @override
  String get chatFailedToLoadImage => '圖片加載失敗';

  @override
  String get chatVideoRecordingFailed => '視頻錄製失敗，請重試';

  @override
  String get profileRedPacket => '紅包';

  @override
  String get commonMusic => '音樂';

  @override
  String get commonCoupon => '卡券';

  @override
  String get commonGift => '禮物';

  @override
  String get commonPoll => '投票';

  @override
  String get favoriteText => '文本';

  @override
  String get favoriteLinkLabel => '鏈接';

  @override
  String get favoriteNote => '筆記';

  @override
  String get favoriteMyNotes => '我的筆記';

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
  String get favoriteNoFavorites => '暫無收藏';

  @override
  String get favoriteLongPressToFavorite => '長按消息進行收藏';

  @override
  String get favoriteNewNote => '新建筆記';

  @override
  String get favoriteLink => '收藏鏈接';

  @override
  String get favoriteEditTags => '編輯標籤';

  @override
  String get favoriteDeleteFavorite => '刪除收藏';

  @override
  String get favoriteDeleteFavoriteConfirm => '確定要刪除這條收藏嗎？';

  @override
  String get favoriteNoSearchResultsFound => '沒有找到結果';

  @override
  String get commonSendRedPacket => '發紅包';

  @override
  String get transferAmount => '金額';

  @override
  String get commonRedPacketCover => '紅包封面';

  @override
  String get commonRedPacketType => '紅包類型';

  @override
  String get commonNormalRedPacket => '普通紅包';

  @override
  String get commonLuckyRedPacket => '拼手氣';

  @override
  String get commonRedPacketCount => '紅包個數';

  @override
  String get commonPieces => '個';

  @override
  String get commonPutMoneyInRedPacket => '塞錢進紅包';

  @override
  String get commonRedPacketRefundNotice => '未領取的紅包，將於24小時後發起退款';

  @override
  String get commonOpenRedPacket => '開';

  @override
  String get commonRedPacketAllClaimed => '紅包已被領完';

  @override
  String get commonRedPacketExpired => '紅包已過期';

  @override
  String get commonAddTransferNote => '添加轉賬說明';

  @override
  String get commonYuan => '元';

  @override
  String get commonReplyWithEmoji => '用此表情回覆';

  @override
  String get contactEditRemark => '編輯備註';

  @override
  String get contactSetPermissions => '設置權限';

  @override
  String get profileAddToBlacklist => '加入黑名單';

  @override
  String get contactDeleteContact => '刪除聯繫人';

  @override
  String contactDeleteContactConfirm(String name) {
    return '確定要刪除 $name 嗎？';
  }

  @override
  String get transferTitle => '轉賬';

  @override
  String get transferReceiverAddressLabel => '收款地址';

  @override
  String get transferSelectTokenLabel => '選擇代幣';

  @override
  String get transferAmountLabel => '轉賬金額';

  @override
  String get transferMemoLabel => '備註（可選）';

  @override
  String get transferAddMemoHint => '添加備註信息';

  @override
  String get transferSendPaymentRequest => '發送收款請求';

  @override
  String get transferQrCodeGenerateFailed => '二維碼生成失敗';

  @override
  String get transferScanQrToPayMe => '掃描二維碼向我付款';

  @override
  String get transferMyWalletAddress => '我的錢包地址';

  @override
  String get transferCreatePaymentRequest => '創建收款請求';

  @override
  String profileN42IdLabel(String id) {
    return 'N42號：$id';
  }

  @override
  String get commonRedPacketDefaultGreeting => '恭喜發財，大吉大利';

  @override
  String commonSenderRedPacket(String name) {
    return '$name的紅包';
  }

  @override
  String get transferEnterValidAddress => '請輸入有效的收款地址';

  @override
  String get transferPleaseSelectToken => '請選擇代幣';

  @override
  String get commonReceivedTransfer => '收到轉賬';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name發出的紅包';
  }

  @override
  String get commonSavedToBalance => '已存入零錢，可直接轉賬';

  @override
  String get commonRedPacketExpiredOrEmpty => '紅包已過期/已領完';

  @override
  String get transferScanFeatureComingSoon => '掃描功能開發中...';

  @override
  String get contactSetAsStarred => '設爲星標朋友';

  @override
  String get contactAddToBlocklist => '加入黑名單';

  @override
  String get commonClaimedYour => '領取了你的';

  @override
  String get commonClaimedText => '領取了';

  @override
  String commonUserTyping(String name) {
    return '$name正在輸入...';
  }

  @override
  String get commonTyping => '對方正在輸入...';

  @override
  String get commonWaitingToReceive => '待對方接收';

  @override
  String get commonTapToClaim => '點擊領取';

  @override
  String get commonHasBeenReceived => '已被接收';

  @override
  String get commonGetLucky => '領個好彩頭';

  @override
  String get qrcodeCameraStartFailed => '相機啓動失敗';

  @override
  String get qrcodeUnknownError => '未知錯誤';

  @override
  String get qrcodePlaceQrCodeInFrame => '將二維碼放入框內掃描';

  @override
  String get qrcodeCloseManualInput => '關閉手動輸入';

  @override
  String get qrcodeManualInputUserId => '手動輸入用戶ID';

  @override
  String get commonAdd => '加入';

  @override
  String get profileSetStatus => '設置狀態';

  @override
  String get profileVisibleToFriends24h => '可被好友看到，24小時後自動清除';

  @override
  String get profileWriteStatus => '寫狀態';

  @override
  String get profileEnterYourStatus => '輸入你的狀態...';

  @override
  String get profileOk => '確定';

  @override
  String get qrcodeCameraPermissionRequired => '掃描二維碼需要相機權限';

  @override
  String get qrcodeCameraPermissionDenied => '相機權限已被永久拒絕，請在系統設置中開啓。';

  @override
  String qrcodePermissionCheckError(String error) {
    return '檢查權限時出錯: $error';
  }

  @override
  String get qrcodeInvalidQrCode => '無效的二維碼';

  @override
  String qrcodeCannotAddFriend(String error) {
    return '無法添加好友: $error';
  }

  @override
  String get qrcodeScanQrCode => '掃描二維碼';

  @override
  String get qrcodeCheckingCameraPermission => '正在檢查相機權限...';

  @override
  String get qrcodeNeedCameraPermission => '需要相機權限';

  @override
  String get qrcodeRetryPermission => '重試';

  @override
  String get qrcodeOpenSettings => '打開設置';

  @override
  String get groupInviteMembers => '邀請成員';

  @override
  String groupInviteCount(int count) {
    return '邀請($count)';
  }

  @override
  String get profileNoShippingAddress => '暫無收貨地址';

  @override
  String get profileDefaultLabel => '默認';

  @override
  String get profileNoInvoice => '暫無發票抬頭';

  @override
  String get profileCompany => '企業';

  @override
  String get profileTaxNumber => '稅號';

  @override
  String get profileConfirmDeleteAddress => '確定要刪除這個地址嗎？';

  @override
  String get profileConfirmDeleteInvoice => '確定要刪除這個發票抬頭嗎？';

  @override
  String get commonGroupOwner => '羣主';

  @override
  String get commonGroupAdmin => '管理員';

  @override
  String get groupSearchMembers => '搜索成員';

  @override
  String groupTotalMembers(int count) {
    return '$count位成員';
  }

  @override
  String get chatRemoveFromGroup => '移出羣聊';

  @override
  String groupConfirmRemoveMember(String name) {
    return '確定要將\"$name\"移出羣聊嗎？';
  }

  @override
  String get chatUnknownSong => '未知歌曲';

  @override
  String get chatUnknownArtist => '未知藝術家';

  @override
  String get chatUnknownContact => '未知聯繫人';

  @override
  String get chatPersonalCard => '個人名片';

  @override
  String get chatSingleChoice => '單選';

  @override
  String get chatMultiChoice => '多選';

  @override
  String get chatEnded => '已結束';

  @override
  String get chatEndPollButton => '結束投票';

  @override
  String get chatPollHint => '投票發起後將顯示在聊天中，羣成員可以參與投票';

  @override
  String get chatSearchSongOrArtist => '搜索歌曲或歌手';

  @override
  String get chatNoSongsFound => '沒有找到歌曲';

  @override
  String get chatSongNameOptional => '歌曲名稱（可選）';

  @override
  String get chatEnterSongName => '輸入歌曲名稱';

  @override
  String get chatArtistNameOptional => '歌手名稱（可選）';

  @override
  String get chatEnterArtistName => '輸入歌手名稱';

  @override
  String get chatRealTimeLocationSharing => '實時位置共享功能開發中...';

  @override
  String get profileVoiceCallFeatureInDev => '語音通話功能開發中...';

  @override
  String get profileReportFeatureInDev => '舉報功能開發中...';

  @override
  String get profileShareFeatureInDev => '分享功能開發中...';

  @override
  String get profileQrCodeFeatureInDev => '二維碼功能開發中...';

  @override
  String get qrcodeScanQrToAddMe => '掃一掃上面的二維碼，加我爲好友';

  @override
  String get qrcodeSaveToAlbum => '保存到相冊';

  @override
  String get qrcodeChangeStyle => '換個樣式';

  @override
  String get qrcodeCopyId => '複製 ID';

  @override
  String get qrcodeIdCopied => '已複製用戶 ID';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => '更多樣式即將推出';

  @override
  String get profileBio => '個性簽名';

  @override
  String get profileHomeServer => '服務器';

  @override
  String get profileShareContactCard => '分享名片';

  @override
  String get profileRemoveFromBlacklist => '移出黑名單';

  @override
  String get profileConfirmAddBlacklist => '確定將該用戶加入黑名單嗎？你將不再收到對方的消息';

  @override
  String get profileConfirmRemoveBlacklist => '確定將該用戶移出黑名單嗎？';

  @override
  String get profileRemarkSaved => '備註已保存';

  @override
  String get profileRemarkCleared => '已清除備註';

  @override
  String get transferReceive => '收款';

  @override
  String get transferPleaseConnectWallet => '請先連接錢包';

  @override
  String get transferSendRequest => '發送請求';

  @override
  String get transferPleaseEnterValidAmount => '請輸入有效的金額';

  @override
  String get searchPlaceholder => '搜索聯繫人、羣聊、消息';

  @override
  String get searchEnterKeywordToSearch => '輸入關鍵詞開始搜索';

  @override
  String get searchClearHistory => '清除';

  @override
  String get searchClearHistoryConfirm => '清除所有最近的搜索记录？';

  @override
  String searchNoResultsForQuery(String query) {
    return '沒有找到\"$query\"相關的結果';
  }

  @override
  String get searchAllResults => '全部';

  @override
  String get searchInChat => '在聊天中搜索';

  @override
  String get searchContactLabel => '聯繫人';

  @override
  String get searchGroupLabel => '羣聊';

  @override
  String get searchConversationLabel => '會話';

  @override
  String get searchMessageLabel => '消息';

  @override
  String get settingsSecurityTitle => '安全';

  @override
  String get settingsDeleteAccountTitle => '删除账户';

  @override
  String get settingsDeleteAccountSubtitle => '停用此 Matrix 账户并清理其本地聊天数据';

  @override
  String get settingsDeleteAccountExplanation =>
      '此操作会请求永久停用 Matrix 账户。服务器确认后，本应用会在安全的情况下移除此账户的本地聊天会话和加密密钥。其他账户及钱包将保留。联邦网络和服务器保留规则可能限制数据擦除。';

  @override
  String get settingsDeleteAccountPasswordOptional => 'Matrix 密码（如有要求）';

  @override
  String get settingsDeleteAccountServerErase => '请求擦除服务器数据';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      '请求此主服务器在支持的情况下擦除账户数据。其他服务器持有的副本或按保留规则保存的数据可能仍然存在。';

  @override
  String get settingsDeleteAccountChooseStage => '验证此 Matrix 账户';

  @override
  String get settingsDeleteAccountUsePassword => '使用 Matrix 密码';

  @override
  String get settingsDeleteAccountUseBrowser => '在浏览器中继续';

  @override
  String get settingsDeleteAccountFallbackTitle => '从 Matrix 验证返回';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      '从浏览器返回不代表删除已确认。请向 Matrix 服务器核对此次原始请求。';

  @override
  String get settingsDeleteAccountCheckServer => '向服务器核对';

  @override
  String get settingsDeleteAccountRequestFailed => 'Matrix 服务器未确认账户删除。';

  @override
  String get settingsDeleteAccountPendingTitle => '本地账户数据待清理';

  @override
  String get settingsDeleteAccountPendingSubtitle => '查看先前已停用 Matrix 账户的清理情况';

  @override
  String get settingsDeleteAccountPendingReadError => '无法读取待清理记录。点击重试。';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'Matrix 账户已停用，但本地数据仍待清理。其他账户仍可使用。';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      '已在浏览器中打开账户管理。本应用尚未确认删除，因此聊天会话仍可使用。';

  @override
  String get settingsKeyBackup => '密鑰備份';

  @override
  String get settingsBackupEncryptionKeys => '備份加密密鑰';

  @override
  String settingsKeysBackedUp(int count) {
    return '已備份 $count 個密鑰';
  }

  @override
  String get settingsBackupNotSet => '未設置備份';

  @override
  String get settingsRestoreKeys => '恢復密鑰';

  @override
  String get settingsRestoreKeysFromBackup => '從備份恢復加密密鑰';

  @override
  String get settingsExportKeys => '導出密鑰';

  @override
  String get settingsExportKeysToFile => '導出密鑰到文件';

  @override
  String get settingsLoggedInDevices => '已登錄設備';

  @override
  String get settingsNoOtherDevices => '暫無其他設備';

  @override
  String get settingsVerified => '已驗證';

  @override
  String get settingsUnverified => '未驗證';

  @override
  String get settingsAdvanced => '高級';

  @override
  String get settingsCrossSigning => '跨設備簽名';

  @override
  String get settingsEnabled => '已啓用';

  @override
  String get settingsNotEnabled => '未啓用';

  @override
  String get settingsResetEncryption => '重置加密';

  @override
  String get settingsDeleteAllEncryptionKeys => '刪除所有加密密鑰';

  @override
  String get settingsEncryptionNotSupported => '不支持加密';

  @override
  String get settingsNotInitialized => '未初始化';

  @override
  String get settingsBackupKeyTitle => '備份密鑰';

  @override
  String get settingsBackupKeyMessage => '是否創建新的密鑰備份？這將幫助您在新設備上恢復加密消息。';

  @override
  String get settingsBackup => '備份';

  @override
  String get settingsRestoreKeyTitle => '恢復密鑰';

  @override
  String get settingsRestoreKeyMessage => '輸入您的恢復密碼或恢復密鑰來恢復加密消息。';

  @override
  String get settingsRestore => '恢復';

  @override
  String get settingsExportKeyTitle => '導出密鑰';

  @override
  String get settingsExportKeyMessage => '導出的密鑰文件包含您的所有加密密鑰，請妥善保管。';

  @override
  String get settingsExport => '導出';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return '設備ID: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => '狀態: 已驗證';

  @override
  String get settingsDeviceStatusUnverified => '狀態: 未驗證';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return '最後活躍: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => '驗證此設備';

  @override
  String get settingsCrossSigningAlreadyEnabled => '跨設備簽名已啓用';

  @override
  String get settingsCrossSigningSetupSuccess => '跨設備簽名設置成功';

  @override
  String get settingsResetEncryptionTitle => '重置加密';

  @override
  String get settingsResetEncryptionWarning =>
      '警告：這將刪除您所有的加密密鑰。您將無法解密之前的加密消息。此操作不可撤銷。';

  @override
  String get settingsReset => '重置';

  @override
  String get settingsBackupSuccess => '密鑰備份成功';

  @override
  String get settingsBackupFailed => '備份失敗';

  @override
  String get settingsRecoveryKey => '恢復密鑰';

  @override
  String get settingsRecoveryKeySaveWarning =>
      '請將此恢復密鑰保存在安全的地方。您需要它在新設備上恢復加密消息。';

  @override
  String get settingsRecoveryKeySaved => '我已保存';

  @override
  String get settingsRestoreSuccess => '密鑰恢復成功';

  @override
  String get settingsRestoreEmpty => '此备份中没有可恢复的消息密钥。';

  @override
  String settingsRestoreSessions(int count) {
    return '已恢复 $count 组消息密钥；缺少密钥的消息仍可能无法解密。';
  }

  @override
  String get settingsRestoreFailed => '恢復失敗';

  @override
  String get settingsPassword => '密碼';

  @override
  String get settingsEnterRecoveryKey => '輸入恢復密鑰';

  @override
  String get settingsEnterPassword => '輸入密碼';

  @override
  String get settingsExportSuccess => '密鑰已成功導出到服務端備份';

  @override
  String get settingsExportNeedBackupFirst => '請先創建密鑰備份';

  @override
  String get settingsExportFailed => '導出失敗';

  @override
  String get settingsResetSuccess => '加密重置成功';

  @override
  String get settingsResetFailed => '重置失敗';

  @override
  String get callLeaveMeetingConfirm => '確定要離開會議嗎？';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return '拍了拍「$name」$suffix';
  }

  @override
  String get chatNoContactsToAdd => '沒有可添加的聯繫人';

  @override
  String get chatAddMembers => '添加成員';

  @override
  String chatInvitedMembers(int count) {
    return '已邀請 $count 位成員';
  }

  @override
  String chatInviteFailed(String error) {
    return '邀請失敗: $error';
  }

  @override
  String get chatMemberRemoved => '已移除成員';

  @override
  String chatRemoveFailed(String error) {
    return '移除失敗: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage => '開始共享後，對方將能看到你的實時位置，共享時長爲1小時。';

  @override
  String get chatStartSharing => '開始共享';

  @override
  String get chatLocationServiceNotEnabled => '位置服務未開啓';

  @override
  String get chatEnableLocationService => '請開啓位置服務以使用位置功能';

  @override
  String get chatGoToSettings => '去設置';

  @override
  String get chatLocationPermissionRequired => '需要位置權限才能使用此功能';

  @override
  String get chatLocationPermissionDeniedPermanent => '位置權限已被永久拒絕，請在設置中開啓';

  @override
  String get chatLocationPermissionDenied => '位置權限被拒絕';

  @override
  String get chatGettingLocation => '正在獲取位置...';

  @override
  String chatGetLocationFailed(String error) {
    return '獲取位置失敗: $error';
  }

  @override
  String get chatMapPreview => '地圖預覽';

  @override
  String get chatSearchLocation => '搜索地點';

  @override
  String chatRedPacketSent(String amount, String token) {
    return '已發送 $amount $token 紅包';
  }

  @override
  String get chatTransferDefault => '轉賬';

  @override
  String chatTransferSent(String amount, String token) {
    return '已發送 $amount $token 轉賬';
  }

  @override
  String chatPickFileFailed(String error) {
    return '選擇文件失敗: $error';
  }

  @override
  String get chatFileSizeLimit => '文件大小不能超過 50MB';

  @override
  String chatFileSending(String filename) {
    return '文件發送中: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return '發送文件失敗: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return '已發送 $name 的名片';
  }

  @override
  String get chatFavoritesFeature => '收藏';

  @override
  String get chatCouponsFeature => '卡券';

  @override
  String get chatGiftFeature => '禮物';

  @override
  String chatSharedMusic(String name) {
    return '已分享 $name';
  }

  @override
  String get chatEndPollTitle => '結束投票';

  @override
  String get chatEndPollConfirmMessage => '確定要結束這個投票嗎？結束後將無法繼續投票。';

  @override
  String get chatPollEndedMessage => '投票已結束';

  @override
  String get chatConnectingCall => '正在連接...';

  @override
  String get chatMuteCall => '靜音';

  @override
  String get chatSpeakerOff => '關閉免提';

  @override
  String get chatSpeakerOn => '免提';

  @override
  String get chatCameraOn => '開啓攝像頭';

  @override
  String get chatCameraOff => '關閉攝像頭';

  @override
  String get chatHangUp => '掛斷';

  @override
  String get chatSelectForwardTargetTitle => '選擇轉發對象';

  @override
  String get chatNoForwardableChat => '沒有可轉發的會話';

  @override
  String get chatNoMatchingChat => '沒有找到相關會話';

  @override
  String get chatLocationTitle => '位置';

  @override
  String get chatSendButton => '發送';

  @override
  String get chatRetryButton => '重試';

  @override
  String get chatSearchContactHint => '搜索聯繫人';

  @override
  String get chatShareMusic => '分享音樂';

  @override
  String get chatRecentPlayed => '最近播放';

  @override
  String get chatMyFavorites => '我喜歡';

  @override
  String get chatNetworkLink => '網絡鏈接';

  @override
  String get chatLocalFile => '本地文件';

  @override
  String get chatPasteMusicLink => '粘貼音樂鏈接';

  @override
  String get chatShareMusicButton => '分享音樂';

  @override
  String get chatSelectLocalAudio => '選擇本地音頻文件';

  @override
  String get chatSupportedAudioFormats => '支持 MP3、M4A、WAV、FLAC 等格式';

  @override
  String get chatSelectFileButton => '選擇文件';

  @override
  String get chatPleaseEnterMusicLink => '請輸入音樂鏈接';

  @override
  String get chatPleaseEnterValidLink => '請輸入有效的網絡鏈接';

  @override
  String get chatSharedSong => '分享歌曲';

  @override
  String get chatSelectMember => '選擇成員';

  @override
  String get chatSearchMemberHint => '搜索成員';

  @override
  String get chatNoMatchingMembers => '未找到匹配的成員';

  @override
  String get commonUnknownMember => '未知';

  @override
  String chatSelectedMessagesCount(int count) {
    return '已選擇 $count 條消息';
  }

  @override
  String get chatSearchContactsOrGroups => '搜索聯繫人或羣聊';

  @override
  String get chatVideoTitle => '視頻';

  @override
  String get chatLoadingText => '加載中...';

  @override
  String get chatVideoLoadFailed => '視頻加載失敗';

  @override
  String get chatPlayerInitFailed => '播放器初始化失敗';

  @override
  String get chatCreatePollTitle => '創建投票';

  @override
  String get chatSubmitPoll => '發起';

  @override
  String get chatPollQuestionLabel => '投票問題';

  @override
  String get chatEnterPollQuestionHint => '請輸入投票問題';

  @override
  String get chatPollOptionsLabel => '投票選項';

  @override
  String chatOptionHintWithIndex(int index) {
    return '選項 $index';
  }

  @override
  String get chatAddOptionButton => '添加選項';

  @override
  String get chatPollSettingsLabel => '投票設置';

  @override
  String get chatSelectionType => '選擇類型';

  @override
  String get chatSingleChoiceLabel => '單選';

  @override
  String get chatMultiChoiceLabel => '多選';

  @override
  String get chatAnonymousPollSwitch => '匿名投票';

  @override
  String get chatPleaseEnterQuestion => '請輸入投票問題';

  @override
  String get chatAtLeastTwoOptions => '至少需要2個選項';

  @override
  String chatConfirmWithCount(int count) {
    return '確定 ($count)';
  }

  @override
  String get authEmailVerificationTitle => '郵箱驗證';

  @override
  String get authEnterValidEmailAddress => '請輸入有效的郵箱地址';

  @override
  String authVerificationCodeSentTo(String email) {
    return '驗證碼已發送到 $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return '發送驗證碼失敗: $error';
  }

  @override
  String get authVerificationSuccess => '驗證成功';

  @override
  String get authVerificationFailed => '驗證失敗';

  @override
  String authVerificationCodeError(String error) {
    return '驗證碼錯誤: $error';
  }

  @override
  String get commonEnterVerificationCode => '輸入驗證碼';

  @override
  String get authEnterYourEmail => '輸入郵箱';

  @override
  String authWeSentCodeTo(String email) {
    return '我們已向 $email 發送了\n6位驗證碼';
  }

  @override
  String get authEnterEmailForCode => '輸入您的郵箱地址，我們將發送驗證碼';

  @override
  String get commonSendVerificationCode => '發送驗證碼';

  @override
  String get authResendVerificationCode => '重新發送驗證碼';

  @override
  String authCanResendAfter(int seconds) {
    return '$seconds秒後可重新發送';
  }

  @override
  String get commonChangeEmail => '更換郵箱';

  @override
  String get contactAddToContacts => '添加到通訊錄';

  @override
  String get contactAddingToContacts => '添加中...';

  @override
  String get contactAddedToContacts => '已添加到通訊錄';

  @override
  String contactAddFailedWithError(String error) {
    return '添加失敗: $error';
  }

  @override
  String get contactAddPhone => '添加電話';

  @override
  String get contactAddTag => '添加標籤';

  @override
  String get contactAddText => '添加文字';

  @override
  String get contactAddPhoto => '添加照片';

  @override
  String contactGroupCountLabel(int count) {
    return '$count個';
  }

  @override
  String get contactAddedViaSearch => '通過搜索添加';

  @override
  String get contactAddTime => '添加時間';

  @override
  String get contactDoneButton => '完成';

  @override
  String get callWaitingForParticipants => '等待參與者加入...';

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
  String get callMuteLabel => '靜音';

  @override
  String get callUnmuteLabel => '解除靜音';

  @override
  String get callTurnOffVideo => '關閉視頻';

  @override
  String get callTurnOnVideo => '開啓視頻';

  @override
  String get callShareScreen => '共享屏幕';

  @override
  String get callStopSharing => '停止共享';

  @override
  String get callSwitchCameraLabel => '切換';

  @override
  String get callLeaveLabel => '離開';

  @override
  String get callParticipantsLabel => '參與者';

  @override
  String get callJoiningMeeting => '正在加入會議...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count 票 ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count 人蔘與';
  }

  @override
  String get chatNoMediaUrlAvailable => '沒有可用的媒體鏈接';

  @override
  String chatDownloadFailed(String code) {
    return '下載失敗: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return '錯誤: $message';
  }

  @override
  String get chatMusicLinkLabel => '音樂鏈接';

  @override
  String get chatRedPacketTransferCannotForward => '紅包和轉賬消息無法轉發';

  @override
  String commonShareFailed(String error) {
    return '分享失敗: $error';
  }

  @override
  String get commonTapToRetry => '點擊重試';

  @override
  String get chatDefaultRedPacketGreeting => '恭喜發財，大吉大利';

  @override
  String get groupAllowOthersToSearchAndJoin => '允許他人搜索並加入';

  @override
  String get groupConfirmClearChatHistory => '確定要清空聊天記錄嗎？';

  @override
  String get groupCreateGroupToChat => '創建羣聊以開始聊天';

  @override
  String get groupEditGroupAnnouncement => '編輯羣公告';

  @override
  String get groupEditGroupDescription => '編輯羣描述';

  @override
  String get groupEnterGroupAnnouncement => '請輸入羣公告';

  @override
  String groupMemberCountClickToCopy(Object count) {
    return '$count人，點擊複製羣ID';
  }

  @override
  String get groupNoPermissionToEditGroupName => '你沒有權限修改羣名稱';

  @override
  String get authEmailAddress => '郵箱地址';

  @override
  String get commonEnterEmailAddress => '請輸入郵箱地址';

  @override
  String get authEmailRecoveryHint => '用於找回密碼';

  @override
  String get commonInvalidEmailFormat => '請輸入有效的郵箱地址';

  @override
  String get authOptional => '選填';

  @override
  String get authResetPassword => '重置密碼';

  @override
  String get authEnterRegisteredEmail => '請輸入註冊時綁定的郵箱地址';

  @override
  String get authSendResetCode => '發送重置驗證碼';

  @override
  String authResetCodeSent(String email) {
    return '重置驗證碼已發送至 $email';
  }

  @override
  String get authEnterResetCode => '輸入重置驗證碼';

  @override
  String get authSetNewPassword => '設置新密碼';

  @override
  String get commonConfirmNewPassword => '確認新密碼';

  @override
  String get commonNewPassword => '新密碼';

  @override
  String get authPasswordResetSuccess => '密碼重置成功，請使用新密碼登錄';

  @override
  String get authResetPasswordFailed => '重置密碼失敗';

  @override
  String get settingsChangePassword => '修改密碼';

  @override
  String get settingsCurrentPassword => '當前密碼';

  @override
  String get settingsEnterCurrentPassword => '請輸入當前密碼';

  @override
  String get settingsEnterNewPassword => '請輸入新密碼';

  @override
  String get settingsPasswordChanged => '密碼修改成功，請使用新密碼重新登錄';

  @override
  String get settingsChangePasswordFailed => '修改密碼失敗';

  @override
  String get settingsNewPasswordMustBeDifferent => '新密碼不能與當前密碼相同';

  @override
  String get settingsChangePasswordInfo => '修改密碼後，您將被登出，需要使用新密碼重新登錄。';

  @override
  String get settingsPasswordRequirements => '密碼要求：';

  @override
  String get settingsSecurityNote => '爲了安全，修改密碼後需要在所有設備上重新登錄。';

  @override
  String get settingsSecurity => '安全';

  @override
  String get settingsCurrentBoundEmail => '當前綁定郵箱';

  @override
  String get settingsNewEmailAddress => '新郵箱地址';

  @override
  String get settingsEnterNewEmail => '請輸入新郵箱地址';

  @override
  String get settingsVerificationCode => '驗證碼';

  @override
  String get settingsVerificationCodeSent => '驗證碼已發送';

  @override
  String get settingsCodeSentTo => '驗證碼已發送至';

  @override
  String get settingsDidNotReceiveCode => '沒有收到驗證碼？';

  @override
  String get settingsEmailChangedSuccess => '郵箱修改成功';

  @override
  String get settingsChangeEmailFailed => '修改郵箱失敗';

  @override
  String get settingsEmailSecurityNote => '郵箱用於密碼找回，請確保安全。';

  @override
  String get commonGoogleLogin => '使用 Google 登錄';

  @override
  String get commonAppleLogin => '使用 Apple 登錄';

  @override
  String get commonWechat => '微信';

  @override
  String get settingsLanguage => '語言';

  @override
  String get settingsLanguageChanged => '語言已更改';

  @override
  String get settingsTranslation => '翻譯';

  @override
  String get settingsTranslateTextTo => '將文字翻譯爲';

  @override
  String get settingsTranslateDescription => '選擇你希望將消息翻譯成的語言。';

  @override
  String get settingsAutoTranslate => '自動翻譯聊天中收到的消息';

  @override
  String get settingsAutoTranslateDescription => '自動將聊天中收到的消息翻譯爲你選擇的語言。';

  @override
  String get settingsBiometricLogin => '生物識別登錄';

  @override
  String authLoginWithBiometric(Object type) {
    return '使用$type登錄';
  }

  @override
  String get settingsBiometricLoginEnabled => '生物識別登錄已啓用';

  @override
  String get settingsBiometricLoginDisabled => '生物識別登錄已禁用';

  @override
  String get settingsEnableBiometricLogin => '啓用生物識別登錄';

  @override
  String get settingsBiometricEnabled => '已啓用 - 使用生物識別登錄';

  @override
  String get settingsBiometricDisabled => '已禁用 - 點擊啓用';

  @override
  String get settingsBiometricNeedRelogin => '請退出後重新登錄以啓用生物識別';

  @override
  String get authOr => '或';

  @override
  String get qrcodeCameraPermissionRestricted => '此設備上的相機訪問受限';

  @override
  String get authPasskeyLabel => '通行密钥';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'Apple';

  @override
  String get authSsoLabel => '单点登录';

  @override
  String get authSsoNotConfigured => '该服务器未配置SSO登录提供商';

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
  String get profileEnterPokeSuffixHint => '輸入戳一戳後綴，例如：的肩膀';

  @override
  String get groupAlbum => '羣相冊';

  @override
  String get groupFiles => '羣文件';

  @override
  String get groupImages => '圖片';

  @override
  String get groupVideos => '視頻';

  @override
  String get groupTotal => '全部';

  @override
  String get groupSize => '大小';

  @override
  String get groupNoMedia => '暫無媒體';

  @override
  String get groupNoMediaDescription => '此羣還沒有圖片或視頻';

  @override
  String get groupDocuments => '文檔';

  @override
  String get groupNoFiles => '暫無文件';

  @override
  String get groupNoFilesDescription => '此羣還沒有文件';

  @override
  String groupDownloadStarted(String filename) {
    return '正在下載 $filename...';
  }

  @override
  String get contactNoCommonGroups => '暫無共同羣組';

  @override
  String get contactNoCommonGroupsDescription => '你們沒有共同加入的羣組';

  @override
  String get chatVoiceMessage => '語音';

  @override
  String get chatMessage => '消息';

  @override
  String get conversationHideChat => '隱藏';

  @override
  String get settingsQuickReply => '快捷回覆';

  @override
  String get commonTranslate => '翻譯';

  @override
  String get contactCreateTag => '新建標籤';

  @override
  String get contactEnterTagName => '輸入標籤名稱';

  @override
  String get contactEditTag => '編輯標籤';

  @override
  String get contactDeleteTag => '刪除標籤';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return '確定要刪除標籤 \"$tagName\" 嗎？';
  }

  @override
  String get contactNoTags => '暫無標籤';

  @override
  String get contactFriendPermissions => '朋友權限';

  @override
  String get contactSetChatOnly => '設爲僅聊天';

  @override
  String get contactChatOnlyDesc => '只能聊天，其他內容將被隱藏';

  @override
  String get contactHideMyMoments => '不讓他（她）看我的朋友圈';

  @override
  String get contactHideMyMomentsDesc => '該好友無法查看你的朋友圈動態';

  @override
  String get contactHideTheirMoments => '不看他（她）的朋友圈';

  @override
  String get contactHideTheirMomentsDesc => '不會看到該好友的朋友圈動態';

  @override
  String get contactHideMyStatus => '不讓他（她）看我的狀態';

  @override
  String get contactHideMyStatusDesc => '該好友無法查看你的狀態更新';

  @override
  String get contactNoChatOnlyFriends => '暫無僅聊天的朋友';

  @override
  String get contactNoOfficialAccounts => '暫無公衆號';

  @override
  String get contactFollowOfficialAccountsDesc => '關注公衆號，獲取最新資訊';

  @override
  String get contactNoServiceAccounts => '暫無服務號';

  @override
  String get contactSubscribeServiceAccountsDesc => '訂閱服務號，享受便捷服務';

  @override
  String get contactNoEnterpriseContacts => '暫無企業聯繫人';

  @override
  String get contactEnterpriseContactsDesc => '企業通訊錄聯繫人將顯示在這裏';

  @override
  String get profileCardPack => '卡包';

  @override
  String get profileOrders => '訂單';

  @override
  String get profileNoOrders => '暫無訂單';

  @override
  String get profileOrdersDesc => '你的訂單將顯示在這裏';

  @override
  String get profileNoCards => '暫無卡券';

  @override
  String get profileCardsDesc => '你的卡券將顯示在這裏';

  @override
  String get favoriteEnterTagsHint => '輸入標籤，用逗號分隔';

  @override
  String get favoriteTagsUpdated => '標籤已更新';

  @override
  String get favoriteForwardedContent => '內容已轉發';

  @override
  String get favoriteEnterNoteContent => '輸入筆記內容';

  @override
  String get favoriteNoteAdded => '筆記已添加';

  @override
  String get favoriteLinkTitle => '鏈接標題';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => '鏈接已添加';

  @override
  String get contactPhotoAdded => '照片已添加';

  @override
  String get contactEnterPhone => '輸入手機號碼';

  @override
  String commonConversationWithId(Object roomId) {
    return '會話: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return '聯繫人: $userId';
  }

  @override
  String get commonDiscover => '發現';

  @override
  String commonDeveloping(Object title) {
    return '$title\n(開發中)';
  }

  @override
  String get commonPageNotFound => '頁面不存在';

  @override
  String get commonBackToHome => '返回首頁';

  @override
  String get settingsMessageNotifications => '消息通知';

  @override
  String get settingsReceiveNewMessageNotifications => '接收新消息通知';

  @override
  String get settingsShowMessagePreview => '顯示消息預覽';

  @override
  String get settingsShowMessageContentInNotification => '在通知中顯示消息內容';

  @override
  String get settingsNotificationSound => '通知聲音';

  @override
  String get settingsPlaySoundOnMessage => '收到消息時播放聲音';

  @override
  String get commonVibration => '振動';

  @override
  String get settingsVibrateOnMessage => '收到消息時震動';

  @override
  String get settingsDoNotDisturbMode => '勿擾模式';

  @override
  String get settingsDoNotDisturbDescription => '在指定時間內不接收通知';

  @override
  String get settingsStartTime => '開始時間';

  @override
  String get settingsEndTime => '結束時間';

  @override
  String get settingsDeleteQuickReply => '刪除快捷回覆';

  @override
  String get settingsEditQuickReply => '編輯快捷回覆';

  @override
  String get settingsAddQuickReply => '添加快捷回覆';

  @override
  String get settingsManageQuickReplies => '管理快捷回覆';

  @override
  String get settingsNoQuickReplies => '暫無快捷回覆';

  @override
  String get settingsDefaultQuickReplies => '將顯示默認快捷回覆';

  @override
  String get settingsWhoCanSee => '誰可以查看';

  @override
  String get settingsLastSeen => '最後上線時間';

  @override
  String get settingsHiddenChats => '隱藏的聊天';

  @override
  String get settingsMessagesLabel => '消息';

  @override
  String get settingsAllowStrangerMessages => '允許陌生人消息';

  @override
  String get settingsReceiveMessagesFromNonContacts => '接收非聯繫人的消息';

  @override
  String get settingsReadReceipts => '已讀回執';

  @override
  String get settingsLetOthersKnowYouRead => '讓對方知道你已讀';

  @override
  String get settingsTypingIndicator => '輸入狀態指示';

  @override
  String get settingsLetOthersKnowYouTyping => '讓對方知道你正在輸入';

  @override
  String get settingsEveryone => '所有人';

  @override
  String get settingsContactsOnly => '僅聯繫人';

  @override
  String get settingsNobody => '無人';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return '誰可以看到 $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return '版本 $version';
  }

  @override
  String get settingsCheckForUpdates => '檢查更新';

  @override
  String get settingsOpenSourceLicenses => '開源許可';

  @override
  String get settingsFeedbackAndSuggestions => '反饋與建議';

  @override
  String get settingsBuiltOnMatrix => '基於 Matrix 協議構建';

  @override
  String get settingsNoHiddenChats => '沒有隱藏的聊天';

  @override
  String get settingsNoHiddenChatsDescription => '你隱藏的聊天會顯示在這裏';

  @override
  String get settingsUnhideChat => '取消隱藏';

  @override
  String get settingsDarkMode => '深色模式';

  @override
  String get settingsFontSize => '字體大小';

  @override
  String get settingsBubbleStyle => '氣泡樣式';

  @override
  String get settingsFollowSystem => '跟隨系統';

  @override
  String get settingsAutoSwitchBySystem => '跟隨系統自動切換';

  @override
  String get settingsLightMode => '淺色模式';

  @override
  String get settingsAlwaysUseLightTheme => '始終使用淺色主題';

  @override
  String get settingsDarkModeOption => '深色模式選項';

  @override
  String get settingsAlwaysUseDarkTheme => '始終使用深色主題';

  @override
  String get settingsFontSizeSmall => '小';

  @override
  String get settingsFontSizeStandard => '標準';

  @override
  String get settingsFontSizeLarge => '大';

  @override
  String get settingsFontSizeExtraLarge => '特大';

  @override
  String get settingsBubbleStyleWechat => '微信樣式';

  @override
  String get settingsBubbleStyleWechatDesc => '經典微信氣泡樣式';

  @override
  String get settingsBubbleStyleModern => '現代樣式';

  @override
  String get settingsBubbleStyleModernDesc => '簡潔的現代氣泡樣式';

  @override
  String get settingsBubbleStyleClassic => '經典樣式';

  @override
  String get settingsBubbleStyleClassicDesc => '傳統的氣泡樣式';

  @override
  String get discoverVideoChannels => '視頻號';

  @override
  String get discoverLive => '直播';

  @override
  String get discoverListen => '聽一聽';

  @override
  String get discoverWatch => '看一看';

  @override
  String get discoverSearchDiscover => '搜一搜';

  @override
  String get discoverNearbyPeople => '附近的人';

  @override
  String get discoverGames => '遊戲';

  @override
  String get discoverMiniPrograms => '小程序';

  @override
  String get chatAlreadyInCall => '當前正在通話中';

  @override
  String get commonConnectionFailed => '連接失敗';

  @override
  String get chatCallRejected => '對方已拒絕';

  @override
  String get chatNoAnswer => '對方無應答';

  @override
  String get commonClose => '關閉';

  @override
  String get chatSelectContact => '選擇聯繫人';

  @override
  String get chatVoteRemoved => '已取消投票';

  @override
  String get chatVoteChanged => '投票已更改';

  @override
  String get chatVoted => '已投票';

  @override
  String chatReplyTo(String name) {
    return '回覆 $name';
  }

  @override
  String get chatCurrentLocation => '當前位置';

  @override
  String chatNearbyPlace(int index) {
    return '附近地點 $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return '約 $distance';
  }

  @override
  String get chatAddress => '地址';

  @override
  String get chatLatitude => '緯度';

  @override
  String get chatLongitude => '經度';

  @override
  String get groupDescriptionUpdated => '羣簡介已更新';

  @override
  String get groupAvatarUpdated => '羣頭像已更新';

  @override
  String get groupVisibilityUpdated => '羣可見性已更新';

  @override
  String get groupChannelCreated => '頻道已創建';

  @override
  String get groupChannelUpdated => '頻道已更新';

  @override
  String get groupChannelDeleted => '頻道已刪除';

  @override
  String get callDecline => '拒絕';

  @override
  String get callAnswer => '接聽';

  @override
  String get callIncomingVideoCall => '視頻來電';

  @override
  String get callIncomingVoiceCall => '語音來電';

  @override
  String get callVideoCallInProgress => '視頻通話中';

  @override
  String get callVoiceCallInProgress => '語音通話中';

  @override
  String get callReconnectingCall => '正在重連...';

  @override
  String get callEnded => '通話已結束';

  @override
  String get callFailed => '通話失敗';

  @override
  String get callLivekitNotConfigured => 'LiveKit 未配置';

  @override
  String callJoinMeetingFailed(Object error) {
    return '加入會議失敗: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return '屏幕共享失敗: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42豆';

  @override
  String get profileNoN42Bean => '暫無N42豆';

  @override
  String get profileN42BeanDetails => 'N42豆明細';

  @override
  String get profileN42BeanDescription => 'N42豆是用於兌換N42內虛擬物品和服務的道具，目前可用於兌換：';

  @override
  String get profileN42BeanFeature1 => '會員專屬表情和主題';

  @override
  String get profileN42BeanFeature2 => '聊天氣泡個性化';

  @override
  String get profileN42BeanFeature3 => '紅包封面定製';

  @override
  String get profileN42BeanFeature4 => '專屬暱稱標識';

  @override
  String get profileN42BeanFeature5 => '羣聊特權功能';

  @override
  String get profileN42BeanFeature6 => '雲存儲空間擴展';

  @override
  String get profileN42BeanFeature7 => '視頻通話美顏濾鏡';

  @override
  String get profileN42BeanFeature8 => '朋友圈背景更換';

  @override
  String get profileN42BeanFeature9 => 'VIP客服優先服務';

  @override
  String get profileGotIt => '我知道了';

  @override
  String get profileNoN42BeanRecords => '暫無N42豆明細記錄';

  @override
  String get profileMoodAndThoughts => '心情想法';

  @override
  String get profileStatusHappy => '開心';

  @override
  String get profileStatusCracked => '裂開';

  @override
  String get profileStatusLucky => '發呆';

  @override
  String get profileStatusSunny => '天氣晴';

  @override
  String get profileStatusTired => '累了';

  @override
  String get profileStatusDaydream => '發呆中';

  @override
  String get profileStatusRushing => '忙碌';

  @override
  String get profileStatusOverthinking => '想太多';

  @override
  String get profileStatusEnergized => '元氣滿滿';

  @override
  String get profileWorkAndStudy => '工作學習';

  @override
  String get profileStatusWorking => '搬磚中';

  @override
  String get profileStatusStudying => '學習中';

  @override
  String get profileStatusBusy => '忙';

  @override
  String get profileStatusSlacking => '摸魚中';

  @override
  String get profileStatusTraveling => '旅行中';

  @override
  String get profileStatusGoingHome => '回家中';

  @override
  String get profileStatusDnd => '請勿打擾';

  @override
  String get profileActivities => '活動';

  @override
  String get profileStatusHanging => '出去浪';

  @override
  String get profileStatusCheckIn => '打卡';

  @override
  String get profileStatusExercising => '運動中';

  @override
  String get profileStatusCoffee => '喝咖啡';

  @override
  String get profileStatusBubbleTea => '奶茶';

  @override
  String get profileStatusEating => '乾飯中';

  @override
  String get profileStatusParenting => '帶娃中';

  @override
  String get profileStatusSavingWorld => '拯救世界';

  @override
  String get profileStatusSelfie => '自拍';

  @override
  String get profileRest => '休息';

  @override
  String get profileStatusRetreat => '閉關';

  @override
  String get profileStatusHome => '宅家';

  @override
  String get profileStatusSleeping => '睡覺中';

  @override
  String get profileStatusCatLover => '吸貓中';

  @override
  String get profileStatusDogWalking => '遛狗中';

  @override
  String get profileStatusGaming => '遊戲中';

  @override
  String get profileStatusListening => '聽歌中';

  @override
  String get profileEditAddress => '編輯地址';

  @override
  String get profileRecipient => '收貨人';

  @override
  String get profileEnterRecipientName => '請輸入收貨人姓名';

  @override
  String get profilePhoneNumber => '手機號碼';

  @override
  String get profileEnterPhoneNumber => '請輸入手機號碼';

  @override
  String get profileRegionHint => '省/市/區';

  @override
  String get profileDetailedAddress => '詳細地址';

  @override
  String get profileDetailedAddressHint => '街道、門牌號等';

  @override
  String get profileSetAsDefaultAddress => '設爲默認地址';

  @override
  String get profilePleaseCompleteInfo => '請填寫完整信息';

  @override
  String get profileEditInvoice => '編輯發票抬頭';

  @override
  String get profileInvoiceType => '抬頭類型';

  @override
  String get profileCompanyName => '企業名稱';

  @override
  String get profilePersonalName => '個人姓名';

  @override
  String get profileEnterCompanyName => '請輸入企業名稱';

  @override
  String get profileEnterName => '請輸入姓名';

  @override
  String get profileTaxIdNumber => '納稅人識別號';

  @override
  String get profileEnterTaxIdNumber => '請輸入納稅人識別號';

  @override
  String get profileBankNameOptional => '開戶銀行（選填）';

  @override
  String get profileEnterBankName => '請輸入開戶銀行';

  @override
  String get profileBankAccountOptional => '銀行賬號（選填）';

  @override
  String get profileEnterBankAccount => '請輸入銀行賬號';

  @override
  String get profileCompanyAddressOptional => '企業地址（選填）';

  @override
  String get profileEnterCompanyAddress => '請輸入企業地址';

  @override
  String get profileCompanyPhoneOptional => '企業電話（選填）';

  @override
  String get profileEnterCompanyPhone => '請輸入企業電話';

  @override
  String get profileSetAsDefaultInvoice => '設爲默認抬頭';

  @override
  String get profileRingtoneVibrate => '震動';

  @override
  String get profileRingtoneSilent => '靜音';

  @override
  String get profileVibrateMode => '振動模式';

  @override
  String get profileSilentMode => '靜音模式';

  @override
  String profilePlayFailed(Object ringtoneName) {
    return '播放失敗: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
    return '正在播放: $ringtoneName';
  }

  @override
  String get profileStop => '停止';

  @override
  String get profileSelectRingtone => '選擇鈴聲';

  @override
  String get profileLoadingRingtones => '加載鈴聲中...';

  @override
  String get profileNoRingtonesFound => '未找到鈴聲';

  @override
  String mainMessagesWithCount(int count) {
    return '消息($count)';
  }

  @override
  String get storyViewers => '瀏覽者';

  @override
  String get storyNoViewers => '暫無瀏覽';

  @override
  String get storyReplyToStory => '回覆狀態...';

  @override
  String get commonCopiedToClipboard => '已複製到剪貼板';

  @override
  String get commonMore => '更多';

  @override
  String get commonTranslating => '翻譯中...';

  @override
  String commonTranslatedFrom(String language) {
    return '翻譯自$language';
  }

  @override
  String get commonTranslation => '翻譯';

  @override
  String get commonTranslationFailed => '翻譯失敗';

  @override
  String get commonAllRead => '全部已讀';

  @override
  String commonReadCount(Object count) {
    return '$count人已讀';
  }

  @override
  String get commonYouRecalledMessage => '你撤回了一條消息';

  @override
  String get commonMessageRecalled => '對方撤回了一條消息';

  @override
  String get commonReEdit => '重新編輯';

  @override
  String get commonWalletArea => '錢包功能區域';

  @override
  String get callIncomingCall => '來電';

  @override
  String get callMissedCall => '未接來電';

  @override
  String get groupRemoveAdmin => '取消管理員';

  @override
  String get chatSelectCurrency => '選擇幣種';

  @override
  String get chatSelectEmoji => '選擇表情';

  @override
  String get chatSelectRedPacketCover => '選擇封面';

  @override
  String get groupSetAsAdmin => '設爲管理員';

  @override
  String get chatVideoPlaybackFailed => '視頻播放失敗';

  @override
  String get groupViewProfile => '查看資料';

  @override
  String get favoriteAddLinkComingSoon => '添加鏈接功能即將推出';

  @override
  String get favoriteNewNoteComingSoon => '新建筆記功能即將推出';

  @override
  String get qrcodeSaveFeatureComingSoon => '保存功能即將推出';

  @override
  String get qrcodeShareFeatureComingSoon => '分享功能即將推出';

  @override
  String qrcodeProcessFailed(String error) {
    return '處理二維碼失敗: $error';
  }

  @override
  String get securityDeviceIdRequired => '需要設備 ID';

  @override
  String securityVerificationStartFailed(String error) {
    return '啓動驗證失敗: $error';
  }

  @override
  String get securityVerificationFailed => '驗證失敗';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return '驗證失敗: $reason';
  }

  @override
  String get securityEmojiMismatchRejected => '驗證被拒絕 - 表情不匹配';

  @override
  String get securityWaitingForDeviceAccept => '等待另一臺設備接受...';

  @override
  String get securityVerifyDevice => '驗證此設備';

  @override
  String get securityConfirmEmojiMatch => '確認以下表情符號在兩臺設備上以相同順序顯示';

  @override
  String get securityEmojiDontMatch => '不匹配';

  @override
  String get securityEmojiMatch => '匹配';

  @override
  String get securityWaitingForDeviceConfirm => '等待另一臺設備確認...';

  @override
  String get securityVerificationSuccess => '驗證成功！';

  @override
  String get securityDeviceVerifiedTrusted => '此設備已驗證並可信任。';

  @override
  String get securityCompareEmoji => '比較兩臺設備上的表情符號';

  @override
  String get securityCompareNumbers => '比較兩臺設備上的數字';

  @override
  String get commonTryAgain => '重試';

  @override
  String get commonDone => '完成';

  @override
  String get chatExportTitle => '導出聊天記錄';

  @override
  String get chatExportSuccess => '導出成功';

  @override
  String chatExportFailed(String error) {
    return '導出失敗: $error';
  }

  @override
  String get chatExportFormat => '導出格式';

  @override
  String get chatExportHtmlDesc => '可在任何瀏覽器中打開的精美排版';

  @override
  String get chatExportJsonDesc => '機器可讀的結構化數據格式';

  @override
  String get chatExportDateRange => '日期範圍';

  @override
  String get chatExportAll => '全部消息';

  @override
  String get chatExportLastWeek => '最近7天';

  @override
  String get chatExportLastMonth => '最近一個月';

  @override
  String get chatExportLast3Months => '最近三個月';

  @override
  String get chatExportMessageCount => '待導出消息';

  @override
  String get chatExportButton => '導出並分享';

  @override
  String get chatMediaGallery => '媒體文件';

  @override
  String get chatExportHistory => '導出聊天記錄';

  @override
  String get pdfLoadFailed => '加載 PDF 失敗';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => '全部';

  @override
  String get mediaImages => '圖片';

  @override
  String get mediaVideos => '視頻';

  @override
  String get mediaFiles => '文件';

  @override
  String get mediaAudio => '音頻';

  @override
  String mediaItemsCount(int count) {
    return '$count 項';
  }

  @override
  String get mediaNoMediaFound => '暫無媒體文件';

  @override
  String get spacesTitle => '社區';

  @override
  String get spacesCreate => '創建社區';

  @override
  String get spacesJoined => '已加入';

  @override
  String get spacesDiscover => '發現';

  @override
  String get spacesNoJoined => '還沒有加入任何社區';

  @override
  String get spacesExplore => '探索社區';

  @override
  String get spacesNoPublic => '沒有找到公共社區';

  @override
  String get spacesJoin => '加入';

  @override
  String get spacesSubSpaces => '子社區';

  @override
  String get spacesChannels => '頻道';

  @override
  String spacesMembersCount(int count) {
    return '$count 位成員';
  }

  @override
  String get spacesPublic => '公開';

  @override
  String get spacesPrivate => '私密';

  @override
  String get spacesSuggested => '推薦';

  @override
  String spacesChannelsCount(int count) {
    return '$count 個頻道';
  }

  @override
  String get callInCallChat => '通話中聊天';

  @override
  String callMessagesCount(int count) {
    return '$count 條消息';
  }

  @override
  String get callNoMessagesYet => '暫無消息\n發送一條消息開始聊天';

  @override
  String get callTypeMessage => '輸入消息...';

  @override
  String get callYouSender => '我';

  @override
  String get callChatLabel => '聊天';

  @override
  String get chatEdited => '已編輯';

  @override
  String get chatEditHistory => '編輯歷史';

  @override
  String get chatOriginalMessage => '原始消息';

  @override
  String chatEditedAt(String time) {
    return '編輯於 $time';
  }

  @override
  String get chatViewOnce => '閱後即焚';

  @override
  String get chatViewOncePhoto => '閱後即焚照片';

  @override
  String get chatViewOnceVideo => '閱後即焚視頻';

  @override
  String get chatViewOnceViewed => '已查看';

  @override
  String get chatViewOnceExpired => '已過期';

  @override
  String get chatViewOnceTap => '點擊查看';

  @override
  String get chatAutoFaceBlur => '发送照片模糊人脸';

  @override
  String get chatAutoFaceBlurDesc => '發送照片時自動模糊人臉';

  @override
  String get threadReplyInThread => '在線程中回覆';

  @override
  String threadReplies(int count) {
    return '$count 條回覆';
  }

  @override
  String get threadReply => '1 條回覆';

  @override
  String threadLatestReply(String preview) {
    return '最新: $preview';
  }

  @override
  String get threadTitle => '消息線程';

  @override
  String get threadReplyPlaceholder => '在線程中回覆...';

  @override
  String threadParticipants(int count) {
    return '$count 位參與者';
  }

  @override
  String get voiceRoomTitle => '語音聊天室';

  @override
  String get voiceRoomCreate => '創建語音房間';

  @override
  String get voiceRoomJoin => '加入';

  @override
  String get voiceRoomLeave => '離開';

  @override
  String get voiceRoomEnd => '結束房間';

  @override
  String get voiceRoomRaiseHand => '舉手';

  @override
  String get voiceRoomLowerHand => '放下手';

  @override
  String get voiceRoomMute => '靜音';

  @override
  String get voiceRoomUnmute => '取消靜音';

  @override
  String get voiceRoomHost => '主持人';

  @override
  String get voiceRoomSpeakers => '發言者';

  @override
  String get voiceRoomListeners => '聽衆';

  @override
  String get voiceRoomLive => '直播中';

  @override
  String get voiceRoomEnded => '已結束';

  @override
  String get voiceRoomScheduled => '已預約';

  @override
  String get voiceRoomApprove => '批准發言';

  @override
  String get voiceRoomDemote => '移至聽衆';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name 舉手了';
  }

  @override
  String get voiceRoomName => '房間名稱';

  @override
  String get voiceRoomTopic => '話題（可選）';

  @override
  String get voiceRoomNoActive => '暫無活躍的語音房間';

  @override
  String get voiceRoomConnecting => '連接中...';

  @override
  String get usernameTitle => '用戶名';

  @override
  String get usernameSet => '設置用戶名';

  @override
  String get usernameChange => '修改用戶名';

  @override
  String get usernamePlaceholder => '輸入用戶名';

  @override
  String get usernameAvailable => '用戶名可用';

  @override
  String get usernameUnavailable => '用戶名已被佔用';

  @override
  String get usernameInvalid => '3-30個字符，小寫字母、數字、下劃線，必須以字母開頭';

  @override
  String get usernameReserved => '此用戶名爲保留名稱';

  @override
  String get usernameSaved => '用戶名已保存';

  @override
  String get usernameSearchHint => '通過 @用戶名 搜索';

  @override
  String get ensName => 'ENS 域名';

  @override
  String get ensLinked => '已關聯 ENS';

  @override
  String get ensResolving => '正在解析 ENS...';

  @override
  String get ensNotFound => '未找到 ENS 域名';

  @override
  String get tokenGateTitle => '代幣門控';

  @override
  String get tokenGateEnable => '啓用代幣門控';

  @override
  String get tokenGateDisable => '禁用代幣門控';

  @override
  String get tokenGateAddRule => '添加規則';

  @override
  String get tokenGateRemoveRule => '刪除規則';

  @override
  String get tokenGateContractAddress => '合約地址';

  @override
  String get tokenGateMinBalance => '最低餘額';

  @override
  String get tokenGateTokenId => '代币 ID（ERC-1155）';

  @override
  String get tokenGateChainId => '鏈 ID';

  @override
  String get tokenGateVerifying => '正在驗證代幣持有...';

  @override
  String get tokenGateVerified => '驗證通過';

  @override
  String get tokenGateDenied => '您未滿足代幣要求';

  @override
  String get tokenGateOperatorAnd => '需滿足所有規則';

  @override
  String get tokenGateOperatorOr => '滿足任一規則即可';

  @override
  String get tokenGateRuleErc20 => 'ERC-20 代幣';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => '多代幣 (ERC-1155)';

  @override
  String get tokenGateRuleNative => '原生代幣';

  @override
  String get tokenGateSaved => '代幣門控已保存';

  @override
  String get tokenGateEnableDescription => '要求成員持有指定代幣才能加入';

  @override
  String get tokenGateOperator => '規則邏輯';

  @override
  String get tokenGateRules => '規則列表';

  @override
  String get tokenGateSymbol => '代幣符號（可選）';

  @override
  String get tokenGateChain => '區塊鏈';

  @override
  String get tokenGateTokenStandard => '代幣標準';

  @override
  String get tokenGateDenialMessage => '拒絕消息';

  @override
  String get tokenGateDenialMessageHint => '驗證失敗時顯示的消息';

  @override
  String get tokenGateVerifyTitle => '代幣驗證';

  @override
  String get tokenGateVerifyPassed => '驗證通過';

  @override
  String get tokenGateVerifyFailed => '驗證未通過';

  @override
  String get tokenGateRetryVerify => '重新驗證';

  @override
  String get tokenGateRequired => '要求';

  @override
  String get tokenGateYourBalance => '你的餘額';

  @override
  String get tokenGateRulesActive => '條規則生效';

  @override
  String get tokenGateDisabled => '未啓用';

  @override
  String get ensNotBound => '未綁定';

  @override
  String get liveLocation => '實時位置';

  @override
  String get stopLiveLocation => '停止共享';

  @override
  String get startLiveLocation => '開始共享';

  @override
  String get selectDuration => '選擇共享時長';

  @override
  String get groupChatFiles => '聊天文件';

  @override
  String get groupLinks => '鏈接';

  @override
  String get groupNoLinks => '暫無鏈接';

  @override
  String get chatBackground => '聊天背景';

  @override
  String get solidColors => '純色';

  @override
  String get gradients => '漸變';

  @override
  String get defaultBackground => '默認';

  @override
  String get settingsFontSizeSlider => '字體大小';

  @override
  String get autoDownload => '自動下載';

  @override
  String get images => '圖片';

  @override
  String get voice => '語音';

  @override
  String get video => '視頻';

  @override
  String get files => '文件';

  @override
  String get mobileData => '移動數據';

  @override
  String get roaming => '漫遊';

  @override
  String get storageManagement => '存儲管理';

  @override
  String get totalUsage => '總用量';

  @override
  String get cache => '緩存';

  @override
  String get other => '其他';

  @override
  String get clearCache => '清理緩存';

  @override
  String get cacheCleared => '緩存已清除';

  @override
  String get clearCacheFailed => '清理緩存失敗';

  @override
  String get confirmClearCache => '確認清理所有緩存數據？';

  @override
  String get mapView => '地圖視圖';

  @override
  String liveLocationSharingCount(int count) {
    return '$count 人正在共享位置';
  }

  @override
  String get minutes15 => '15 分鐘';

  @override
  String get minutes30 => '30 分鐘';

  @override
  String get hour1 => '1 小時';

  @override
  String get hours8 => '8 小時';

  @override
  String get personalCard => '個人名片';

  @override
  String get downloadFailed => '下載失敗';

  @override
  String get locationExpired => '已過期';

  @override
  String secondsRemaining(int count) {
    return '$count秒';
  }

  @override
  String minutesRemaining(int count) {
    return '$count分鐘';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '$hours小時$minutes分鐘';
  }

  @override
  String get favoriteMessages => '收藏消息';

  @override
  String get linksCopied => '鏈接已複製';

  @override
  String get noLinksFound => '未找到鏈接';

  @override
  String get roomStorageRanking => '房間存儲排行';

  @override
  String get downloadComplete => '下載完成';

  @override
  String get downloading => '下載中...';

  @override
  String get draftSaved => '草稿已保存';

  @override
  String get voiceRecording => '語音錄製';

  @override
  String get searchLocation => '搜索地點';

  @override
  String get tapToSearch => '點擊搜索';

  @override
  String get settingsThisDevice => '本設備';

  @override
  String get settingsJustNow => '剛剛';

  @override
  String get settingsDeviceId => '設備 ID';

  @override
  String get settingsStatus => '狀態';

  @override
  String get settingsLastActive => '最後活躍';

  @override
  String get settingsIpAddress => 'IP 地址';

  @override
  String get settingsRenameDevice => '重命名設備';

  @override
  String get settingsDeviceNameHint => '輸入設備名稱';

  @override
  String get settingsDeviceRenamed => '設備已重命名';

  @override
  String get settingsRenameFailed => '重命名失敗';

  @override
  String get settingsRemoteLogout => '遠程登出';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return '確定要登出「$deviceName」嗎？此操作無法撤銷。';
  }

  @override
  String get settingsDeviceLoggedOut => '設備已登出';

  @override
  String get settingsLogoutFailed => '登出失敗';

  @override
  String get settingsLogout => '登出';

  @override
  String get settingsVerifyIdentity => '驗證身份';

  @override
  String get settingsEnterPasswordToConfirm => '請輸入密碼以確認此操作。';

  @override
  String get scheduledSendTitle => '定時發送';

  @override
  String get scheduledSendInOneHour => '1小時後';

  @override
  String get scheduledSendTonight => '今晚 (20:00)';

  @override
  String get scheduledSendTomorrowMorning => '明早 (9:00)';

  @override
  String get scheduledSendCustom => '自定義時間';

  @override
  String get scheduledMessageLabel => '定時發送';

  @override
  String get scheduledMessageCancel => '取消定時發送';

  @override
  String get chatLockTitle => '聊天鎖';

  @override
  String get chatLockEnable => '鎖定此聊天';

  @override
  String get chatLockDisable => '解鎖此聊天';

  @override
  String get chatLockDescription => '鎖定的聊天需要通過生物識別或 PIN 碼驗證才能打開';

  @override
  String get chatLockVerifyTitle => '聊天已鎖定';

  @override
  String get chatLockVerifySubtitle => '驗證後訪問此聊天';

  @override
  String get chatLockVerifyFailed => '驗證失敗';

  @override
  String get chatLockEnabled => '聊天已鎖定';

  @override
  String get chatLockDisabled => '聊天已解鎖';

  @override
  String get chatLockPinTitle => '輸入 PIN 碼';

  @override
  String get chatLockPinSetTitle => '設置 PIN 碼';

  @override
  String get chatLockPinConfirmTitle => '確認 PIN 碼';

  @override
  String get chatLockPinMismatch => 'PIN 碼不一致';

  @override
  String get chatLockUseBiometric => '使用生物識別';

  @override
  String get chatLockUsePin => '使用 PIN 碼';

  @override
  String get mediaEditorUndo => '撤銷';

  @override
  String get mediaEditorRedo => '重做';

  @override
  String get mediaEditorCrop => '裁剪';

  @override
  String get mediaEditorFilter => '濾鏡';

  @override
  String get mediaEditorDraw => '塗鴉';

  @override
  String get mediaEditorText => '文字';

  @override
  String get aiAssistant => 'AI 助手';

  @override
  String get aiAssistantWelcome => '你好！我是 N42 AI 助手，有什麼可以幫你的嗎？';

  @override
  String get aiAssistantNotConfigured => 'AI 服務未配置';

  @override
  String get aiAssistantSettings => 'AI 設置';

  @override
  String get aiAssistantClearHistory => '清空對話歷史';

  @override
  String get aiAssistantClearHistoryConfirm => '確定清空所有 AI 對話歷史？';

  @override
  String get aiAssistantStopGenerating => '停止生成';

  @override
  String get aiAssistantModel => '模型';

  @override
  String get aiAssistantTemperature => '溫度';

  @override
  String get aiAssistantMaxTokens => '最大令牌數';

  @override
  String get aiAssistantContextWindow => '上下文窗口';

  @override
  String get aiAssistantServiceStatus => '服務狀態';

  @override
  String get aiAssistantAvailable => '可用';

  @override
  String get aiAssistantUnavailable => '不可用';

  @override
  String get aiSummarize => 'AI 總結';

  @override
  String aiSummarizeUnread(int count) {
    return 'AI 總結 $count 條未讀消息';
  }

  @override
  String get aiSummarizeLoading => '正在總結...';

  @override
  String get aiSummarizeError => '總結失敗';

  @override
  String get aiRewrite => 'AI 改寫';

  @override
  String get aiRewriteFormal => '正式';

  @override
  String get aiRewriteCasual => '輕鬆';

  @override
  String get aiRewritePlayful => '俏皮';

  @override
  String get aiRewriteProfessional => '專業';

  @override
  String get aiRewriteAccept => '使用';

  @override
  String get aiRewriteCancel => '取消';

  @override
  String get aiRewriteLoading => '正在改寫...';

  @override
  String get aiLinkSummary => 'AI 摘要';

  @override
  String get aiLinkSummaryAnalyzing => '正在分析...';

  @override
  String get chatFolderManagement => '管理文件夾';

  @override
  String get chatFolderSystem => '系統文件夾';

  @override
  String get chatFolderCustom => '自定義文件夾';

  @override
  String get chatFolderEmpty => '暫無自定義文件夾';

  @override
  String get chatFolderCreate => '創建文件夾';

  @override
  String get chatFolderEdit => '編輯文件夾';

  @override
  String get chatFolderNameHint => '文件夾名稱';

  @override
  String get chatFolderAll => '全部';

  @override
  String get chatFolderUnread => '未讀';

  @override
  String get chatFolderPersonal => '私聊';

  @override
  String get chatFolderGroups => '羣組';

  @override
  String get chatFolderChannels => '頻道';

  @override
  String get chatFolderMuted => '已靜音';

  @override
  String get storyAddMusic => '添加音樂';

  @override
  String get storyChangeMusic => '更換音樂';

  @override
  String get storyBackgroundMusic => '背景音樂';

  @override
  String get storyMusicPreview => '預覽 (最長15秒)';

  @override
  String get storyChooseFromDevice => '從設備選擇';

  @override
  String get storyUseThisMusic => '使用此音樂';

  @override
  String get authPasskeyNotSupported => '此設備不支持 Passkey';

  @override
  String get authPasskeyRegister => '註冊 Passkey';

  @override
  String get authPasskeyNoRegistered => '未註冊 Passkey';

  @override
  String get authPasskeyRegisterHint => '爲當前賬號註冊 Passkey，獨立 Passkey 登錄入口後續開放。';

  @override
  String get authPasskeyNameYours => '爲 Passkey 命名';

  @override
  String get authPasskeyRegistered => 'Passkey 已保存到當前賬號';

  @override
  String get authPasskeyDeleted => 'Passkey 已從當前賬號移除';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return '刪除 Passkey \"$name\"？如需後續使用 Passkey 登錄，需要重新註冊。';
  }

  @override
  String get momentVisibilityPublic => '公開';

  @override
  String get momentVisibilityPrivate => '私密';

  @override
  String get momentVisibilityPartial => '部分可見';

  @override
  String get momentVisibilityExcluded => '不給誰看';

  @override
  String momentUserMoments(String userName) {
    return '$userName的朋友圈';
  }

  @override
  String get momentForwardTo => '轉發給';

  @override
  String get momentForwardSuccess => '轉發成功';

  @override
  String get momentSelectFriends => '選擇好友';

  @override
  String get momentSelectTags => '按標籤選擇';

  @override
  String momentSelectedCount(int count) {
    return '已選擇 ($count)';
  }

  @override
  String get momentNoMomentsYet => '暫無動態';

  @override
  String get momentForwardMoment => '轉發動態';

  @override
  String get momentAddComment => '寫評論...';

  @override
  String momentForwardContent(String content) {
    return '[朋友圈] $content';
  }

  @override
  String get momentDeleteMoment => '刪除動態';

  @override
  String get momentDeleteConfirm => '確定要刪除這條動態嗎？';

  @override
  String get momentComment => '評論';

  @override
  String get momentWriteComment => '寫評論...';

  @override
  String get momentLike => '贊';

  @override
  String get momentUnlike => '取消';

  @override
  String get momentForward => '轉發';

  @override
  String get momentDelete => '刪除';

  @override
  String get momentReply => '回覆';

  @override
  String get momentMoment => '動態';

  @override
  String momentLikesCount(int count) {
    return '$count 個贊';
  }

  @override
  String momentCommentsCount(int count) {
    return '$count 條評論';
  }

  @override
  String get momentNoComments => '暫無評論';

  @override
  String get momentFailedToLoad => '圖片加載失敗';

  @override
  String momentReplyTo(String userName) {
    return '回覆 $userName...';
  }

  @override
  String get momentNoConversations => '暫無會話';

  @override
  String get momentJustNow => '剛剛';

  @override
  String momentMinutesAgo(int count) {
    return '$count分鐘前';
  }

  @override
  String momentHoursAgo(int count) {
    return '$count小時前';
  }

  @override
  String momentDaysAgo(int count) {
    return '$count天前';
  }

  @override
  String get chatGroupAnnouncementHint => '輸入羣公告';

  @override
  String get chatGroupAnnouncementEmpty => '暫無羣公告';

  @override
  String get chatEditNickname => '編輯羣暱稱';

  @override
  String get chatNicknameHint => '輸入你在羣裏的暱稱';

  @override
  String get contactAddPhoneHint => '輸入電話號碼';

  @override
  String get contactNotesHint => '添加聯繫人備忘';

  @override
  String get reportTitle => '投訴';

  @override
  String get reportReasonSpam => '垃圾信息';

  @override
  String get reportReasonHarassment => '騷擾';

  @override
  String get reportReasonFraud => '欺詐';

  @override
  String get reportReasonOther => '其他';

  @override
  String get reportSubmitted => '投訴已提交';

  @override
  String get reportDescription => '補充說明（選填）';

  @override
  String get qrcodeSaved => '二維碼已保存到相冊';

  @override
  String get chatSendRedPacketInChat => '請在聊天中發送紅包';

  @override
  String get commonSaveFailed => '保存失敗';

  @override
  String get reportSelectReason => '請選擇投訴原因';

  @override
  String get reportUnavailable => '登录后即可举报。';

  @override
  String get reportAccountChanged => '账户已切换。请重新打开此举报页面后发送。';

  @override
  String get reportUnsupported => '此主服务器不支持举报用户。';

  @override
  String get reportRoomUnsupported => '此主服务器不支持举报房间。';

  @override
  String get reportRateLimited => '举报过于频繁，请稍后重试。';

  @override
  String get reportCouldNotSend => '无法发送举报，请重试。';

  @override
  String get gameCenter => '遊戲中心';

  @override
  String get gameHighScore => '最高分';

  @override
  String get gameScore => '分數';

  @override
  String get gameOver => '遊戲結束';

  @override
  String get gamePlayAgain => '再來一局';

  @override
  String get gameLeaderboard => '排行榜';

  @override
  String get gamePause => '暫停';

  @override
  String get gameResume => '點擊繼續';

  @override
  String get gameConfirmExit => '確定退出遊戲？';

  @override
  String get gameNoScores => '暫無記錄';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => '合併數字到 2048';

  @override
  String get gameBlockDrop => '方塊消除';

  @override
  String get gameBlockDropDesc => '消除方塊行';

  @override
  String get gameMinesweeper => '掃雷';

  @override
  String get gameMinesweeperDesc => '找出所有安全格';

  @override
  String get gameMatch3 => '消消樂';

  @override
  String get gameMatch3Desc => '連接3個以上寶石';

  @override
  String get gameMinesweeperEasy => '初級';

  @override
  String get gameMinesweeperMedium => '中級';

  @override
  String get gameMinesLeft => '剩餘雷數';

  @override
  String get gameTimeLeft => '時間';

  @override
  String get gameLevel => '等級';

  @override
  String get gameNext => '下一個';

  @override
  String get gameBestTime => '最佳用時';

  @override
  String get gameNewRecord => '新紀錄！';

  @override
  String get gameLines => '行數';

  @override
  String get storyMyStory => '我的動態';

  @override
  String get storageSmartCleanup => '智能清理';

  @override
  String get storageOldMediaFiles => '舊媒體文件';

  @override
  String get storageLargeFiles => '大文件';

  @override
  String get storageAppCache => '應用緩存';

  @override
  String get storageSettings => '存儲設置';

  @override
  String get storageAutoCleanup => '自動清理';

  @override
  String storageAutoCleanupDesc(int days) {
    return '自動清理 $days 天以上未訪問的文件';
  }

  @override
  String get storageCleanupPeriod => '清理週期';

  @override
  String get storagePreserveThumbnails => '保留縮略圖';

  @override
  String get storagePreserveThumbnailsDesc => '清理時保留圖片縮略圖';

  @override
  String get storageWarningHigh => '存儲空間較高，建議清理舊文件。';

  @override
  String get storageWarningCritical => '存儲空間嚴重不足，請立即清理。';

  @override
  String storageFreed(String size, int count) {
    return '已釋放 $size（$count 個文件）';
  }

  @override
  String storageDays(int days) {
    return '$days 天';
  }

  @override
  String storageViewAllRooms(int count) {
    return '查看全部 $count 個房間';
  }

  @override
  String get storageNoFiles => '暫無文件';

  @override
  String get storageFilePinned => '已保留';

  @override
  String storageDeleteSelected(int count) {
    return '刪除 $count 個選中文件？文件可從服務器重新下載。';
  }

  @override
  String get backupRestore => '備份與恢復';

  @override
  String get backupCreate => '創建備份';

  @override
  String get backupCreateDesc => '備份設置和加密密鑰。消息將在重新登錄後從服務器恢復。';

  @override
  String get backupIncludeKeys => '包含加密密鑰';

  @override
  String get backupIncludeKeysDesc => '讀取加密消息所必需';

  @override
  String get backupPasswordProtect => '密碼保護';

  @override
  String get backupEnterPassword => '輸入備份密碼';

  @override
  String get backupHistory => '備份歷史';

  @override
  String get backupNoBackups => '暫無備份';

  @override
  String get backupRestore2 => '恢復';

  @override
  String get backupDelete => '刪除';

  @override
  String get backupDeleteConfirm => '確定刪除此備份？此操作不可撤銷。';

  @override
  String get backupRestoreFromFile => '從文件恢復';

  @override
  String get backupRestoreFromFileDesc => '導入來自其他設備或之前備份的 .n42backup 文件。';

  @override
  String get backupChooseFile => '選擇備份文件';

  @override
  String get backupRestoring => '恢復中...';

  @override
  String backupCreated(int rooms, int messages) {
    return '備份已創建：$rooms 個房間，$messages 條消息';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return '已恢復 $settings 項設置（來自 $rooms 個房間）';
  }

  @override
  String backupFailed(String error) {
    return '備份失敗：$error';
  }

  @override
  String get backupPasswordRequired => '此備份需要密碼';

  @override
  String get blocGroupNotFound => '羣組未找到';

  @override
  String blocGroupMembersInvited(int count) {
    return '已邀請$count位成員';
  }

  @override
  String get blocGroupMemberRemoved => '成員已移除';

  @override
  String get blocGroupAdminRemoved => '已取消管理員';

  @override
  String get blocGroupLeft => '已退出羣聊';

  @override
  String get blocGroupDisbanded => '羣聊已解散';

  @override
  String get blocGroupJoined => '已加入羣聊';

  @override
  String get blocGroupInviteDeclined => '已拒絕邀請';

  @override
  String get blocGroupTokenGateUpdated => 'Token 門檻已更新';

  @override
  String get blocTransferProcessing => '轉賬處理中...';

  @override
  String get blocTransferCancelled => '轉賬已取消';

  @override
  String get blocTransferFailed => '轉賬失敗';

  @override
  String get blocPaymentProcessing => '支付處理中...';

  @override
  String get blocPaymentFailed => '支付失敗';

  @override
  String get groupMaxMembers => '羣人數上限';

  @override
  String get groupMaxMembersUnlimited => '不限';

  @override
  String get groupMaxMembersHint => '輸入上限（留空表示不限）';

  @override
  String get groupMaxMembersUpdated => '羣人數上限已更新';

  @override
  String get groupFull => '羣已滿員';

  @override
  String get groupChannels => '話題頻道';

  @override
  String get groupChannelsEmpty => '暫無話題頻道';

  @override
  String get groupChannelsCount => '個頻道';

  @override
  String get groupChannelCreate => '新建頻道';

  @override
  String get groupChannelName => '頻道名稱';

  @override
  String get groupChannelTopic => '頻道話題（可選）';

  @override
  String get groupChannelDelete => '刪除頻道';

  @override
  String get groupChannelDeleteConfirm => '確認刪除此頻道？消息不可恢復。';

  @override
  String get groupBotSettings => 'Bot 設置';

  @override
  String get groupBotEnabled => '啓用 Bot';

  @override
  String get groupBotWelcomeMessage => '歡迎語模板';

  @override
  String get groupBotWelcomeHint => '用 \'name\' 作爲新成員名字佔位符';

  @override
  String get groupBotConfigUpdated => 'Bot 設置已更新';

  @override
  String get groupContentFilter => '關鍵詞過濾';

  @override
  String get groupContentFilterEnabled => '啓用關鍵詞過濾';

  @override
  String get groupContentFilterReplace => '替換爲 ***';

  @override
  String get groupContentFilterHide => '隱藏消息';

  @override
  String get groupContentFilterAddWord => '添加關鍵詞';

  @override
  String get groupContentFilterUpdated => '內容過濾設置已更新';

  @override
  String get chatSlashCommands => '指令';

  @override
  String get chatCommandPoll => '/poll — 創建投票';

  @override
  String get chatCommandAnnounce => '/announce — 發佈公告';

  @override
  String get chatCommandWelcome => '/welcome — 設置歡迎語';

  @override
  String get chatReportMessage => '舉報';

  @override
  String get chatReportReason => '舉報原因';

  @override
  String get chatReportSpam => '垃圾信息';

  @override
  String get chatReportHarassment => '騷擾';

  @override
  String get chatReportInappropriate => '違規內容';

  @override
  String get chatReportOther => '其他';

  @override
  String get chatReportSuccess => '舉報已提交';

  @override
  String get spacesName => '社區名稱';

  @override
  String get spacesNameHint => '例如：加密交易者';

  @override
  String get spacesNameRequired => '請輸入社區名稱';

  @override
  String get spacesDescription => '簡介';

  @override
  String get spacesDescriptionHint => '介紹一下這個社區';

  @override
  String get spacesType => '社區類型';

  @override
  String get spacesPublicDesc => '任何人均可發現並加入';

  @override
  String get spacesPrivateDesc => '僅受邀成員可加入';

  @override
  String get spacesNotFound => '社區不存在';

  @override
  String get spacesSearch => '搜索社區...';

  @override
  String get spacesMembers => '成員';

  @override
  String get spacesNoChannels => '暫無頻道';

  @override
  String get spacesLeave => '退出社區';

  @override
  String spacesLeaveConfirm(String name) {
    return '確定要退出「$name」嗎？';
  }

  @override
  String get spacesDelete => '解散社區';

  @override
  String spacesDeleteConfirm(String name) {
    return '此操作將永久刪除「$name」及其所有頻道，且不可撤銷。';
  }

  @override
  String get spacesCreateChannel => '創建頻道';

  @override
  String get spacesChannelName => '頻道名稱';

  @override
  String get spacesChannelTopic => '話題（可選）';

  @override
  String get spacesDeleteChannel => '刪除頻道';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return '確定要刪除頻道「#$name」嗎？';
  }

  @override
  String get spacesEditName => '修改名稱';

  @override
  String get spacesEditDescription => '修改簡介';

  @override
  String spacesViewAllMembers(int count) {
    return '查看全部 $count 位成員';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return '踢出 $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return '封禁 $name';
  }

  @override
  String get spacesPromoteAdmin => '設爲管理員';

  @override
  String get spacesDemoteAdmin => '撤銷管理員';

  @override
  String get spacesInviteMember => '邀請成員';

  @override
  String get spacesInviteMemberUserId => '用戶 ID（如 @user:server.com）';

  @override
  String get spacesSave => '保存';

  @override
  String get settingsScreenshotProtection => '截圖防護';

  @override
  String get settingsScreenshotProtectionDesc => '防止截圖和屏幕錄製';

  @override
  String get chatSelfDestructTimer => '閱後即焚';

  @override
  String get chatTimerPickerTitle => '設置閱後即焚時間';

  @override
  String get chatTimerOff => '關閉';

  @override
  String get onChainNotificationsTitle => '鏈上事件';

  @override
  String get onChainMarkAllRead => '全部已讀';

  @override
  String get onChainNoNotifications => '暫無鏈上事件';

  @override
  String get onChainNoNotificationsDesc => '來自訂閱頻道的事件通知將在此顯示';

  @override
  String get onChainViewDetails => '查看詳情';

  @override
  String get chatCommandHelp => '/help — 查看所有命令';

  @override
  String get chatCommandPrice => '/price — 查詢代幣價格';

  @override
  String get chatCommandBalance => '/balance — 查看錢包餘額';

  @override
  String get chatCommandChains => '/chains — 查看 236+ 條支持鏈';

  @override
  String get chatMiniApps => '應用';

  @override
  String get miniAppMarketTitle => '小程序';

  @override
  String get miniAppCategoryAll => '全部';

  @override
  String get miniAppSearch => '搜索應用...';

  @override
  String get miniAppFeatured => '精選';

  @override
  String get miniAppAllApps => '全部應用';

  @override
  String get miniAppNoResults => '未找到應用';

  @override
  String get slideToPayLabel => '→→→  滑動確認';

  @override
  String get slideToPayConfirming => '確認中...';

  @override
  String get redPacketBestLuck => '最佳手氣';

  @override
  String get redPacketBestLuckCongrats => '最佳手氣！你搶到了最多！';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total 個已領取';
  }

  @override
  String get redPacketStatsTotal => '共計';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 搶到了紅包 • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id  •  0x 錢包地址  •  name.eth';

  @override
  String get web3SearchPlaceholder => '搜索 ID、錢包地址或 ENS...';

  @override
  String get web3WalletAddress => '錢包地址';

  @override
  String get web3AddressCopied => '地址已複製';

  @override
  String get web3Copy => '複製';

  @override
  String get web3SendMessage => '發消息';

  @override
  String get web3SendToWallet => '發送到錢包';

  @override
  String get web3WalletOnlyHint => '該地址尚無 N42 賬號。對方加入後消息將自動送達。';

  @override
  String get web3NftAvatar => 'NFT 頭像';

  @override
  String get web3ResolveFailed => '身份解析失敗';

  @override
  String web3EnsNotFound(String name) {
    return 'ENS 名稱“$name”未找到';
  }

  @override
  String get web3NoN42AccountTitle => '無 N42 賬號';

  @override
  String get web3NoN42AccountDesc => '該錢包地址尚無 N42 賬號。您可以分享 N42 邀請鏈接邀請對方加入。';

  @override
  String get web3ShareInvite => '分享邀請';

  @override
  String get nftPickerTitle => '選擇 NFT 頭像';

  @override
  String get nftPickerTabPopular => '熱門';

  @override
  String get nftPickerTabCustom => '自定義';

  @override
  String get nftPickerChain => '鏈';

  @override
  String get nftPickerContract => '合約地址';

  @override
  String get nftPickerTokenId => '代币 ID';

  @override
  String get nftPickerVerifyOwnership => '驗證所有權並預覽';

  @override
  String get nftPickerUseAsAvatar => '用作頭像';

  @override
  String get nftPickerPreview => '預覽';

  @override
  String get nftPickerNotOwned => '您不擁有這個 NFT';

  @override
  String get nftPickerInvalidTokenId => '無效的 Token ID';

  @override
  String get nftPickerEnterBoth => '請輸入合約地址和 Token ID';

  @override
  String get nftPickerInfoTitle => 'NFT 頭像 — 鏈上身份驗證';

  @override
  String get nftPickerInfoDesc =>
      '綁定您持有的 NFT 作爲頭像。任何人均可在鏈上驗證歸屬權。在 N42 全應用中以金色邊框標識。';

  @override
  String get nftPickerPopularCollections => '熱門 NFT 項目';

  @override
  String get nftPickerWalletHint => '連接 N42 錢包，自動發現您在 236+ 條鏈上持有的 NFT。';

  @override
  String get profileBindNftAvatar => '綁定 NFT 頭像';

  @override
  String get profileChangeAvatar => '更換頭像';

  @override
  String get groupTopics => '羣話題';

  @override
  String get groupTopicsEmpty => '暫無話題';

  @override
  String get syncInProgress => '正在同步歷史消息...';

  @override
  String get recoveryKeyReminderTitle => '保護您的消息';

  @override
  String get recoveryKeyReminderDesc => '創建恢復密鑰以在多設備上安全同步加密消息';

  @override
  String get recoveryKeySetupNow => '立即設置';

  @override
  String get recoveryKeyRemindLater => '稍後提醒';

  @override
  String get channelReadOnly => '僅管理員可在此頻道發言';

  @override
  String get channelSubscribers => '訂閱者';

  @override
  String get channelVerified => '已認證頻道';

  @override
  String get redPacketHistory => '紅包記錄';

  @override
  String get redPacketSent => '已發出';

  @override
  String get redPacketReceived => '已收到';

  @override
  String get redPacketExpired => '已過期';

  @override
  String get redPacketClaimed => '已領取';

  @override
  String get redPacketInsufficientBalance => '餘額不足';

  @override
  String selfDestructCountdown(String time) {
    return '$time 後銷燬';
  }

  @override
  String get messageDestroyed => '消息已銷燬';

  @override
  String miniAppPermissionDenied(String permission) {
    return '權限不足：$permission';
  }

  @override
  String get aiSuggestionGasFee => '什麼是 Gas 費？';

  @override
  String get aiSuggestionDefi => 'DeFi 入門';

  @override
  String get aiSuggestionSecurity => '如何檢查合約安全';

  @override
  String get aiSuggestionBridge => '跨鏈橋接';

  @override
  String get channelDiscoverTitle => '發現頻道';

  @override
  String get channelDiscoverSearch => '搜索頻道...';

  @override
  String get channelJoin => '加入';

  @override
  String get channelJoined => '已加入';

  @override
  String get channelCategory => '分類';

  @override
  String slowModeCooldown(int seconds) {
    return '慢速模式：請等待 $seconds 秒';
  }

  @override
  String get addressCopyAction => '複製地址';

  @override
  String get addressSendMessage => '發消息';

  @override
  String get addressViewProfile => '查看資料';

  @override
  String get sendToAddress => '通過錢包地址發消息';

  @override
  String get blocAuthSendVerificationCodeFailed => '發送驗證碼失敗';

  @override
  String get blocAuthServerNoEmailPasswordReset => '該服務器不支持通過郵箱重置密碼';

  @override
  String get blocAuthResetPasswordFailed => '重置密碼失敗';

  @override
  String get blocAuthChangePasswordFailed => '修改密碼失敗';

  @override
  String get blocAuthOldPasswordWrong => '原密碼錯誤';

  @override
  String get blocAuthLoginCancelled => '登錄已取消';

  @override
  String get blocAuthGoogleLoginFailed => 'Google 登錄失敗';

  @override
  String get blocAuthAppleLoginFailed => 'Apple 登錄失敗';

  @override
  String get blocAuthSsoLoginFailed => 'SSO 登錄失敗';

  @override
  String get blocAuthFacebookLoginFailed => 'Facebook 登錄失敗';

  @override
  String get blocAuthTwitterLoginFailed => 'Twitter 登錄失敗';

  @override
  String get blocAuthWeChatLoginFailed => '微信登錄失敗';

  @override
  String get blocAuthWeChatNotConfigured => '微信登錄未配置';

  @override
  String get blocAuthWeChatNotInstalled => '請先安裝微信';

  @override
  String get blocAuthPasswordWrong => '密碼錯誤';

  @override
  String get blocAuthEmailAlreadyBound => '該郵箱已被其他賬號綁定';

  @override
  String get blocAuthChangeEmailFailed => '修改郵箱失敗';

  @override
  String get blocAuthVerificationCodeInvalid => '驗證碼錯誤或已過期';

  @override
  String get blocAuthSessionExpired => '會話已失效，請重新登錄';

  @override
  String get blocAuthSessionIncomplete => '會話數據不完整，請重新登錄';

  @override
  String get chatReadingMode => '阅读模式';

  @override
  String get groupPoints => '积分';

  @override
  String get settingsPrivacySecurity => '隐私与安全';

  @override
  String get settingsSystemAccounts => '系统与账号';

  @override
  String get settingsNotificationPrivacy => '通知隐私';

  @override
  String get settingsSenderOnly => '仅显示发送者';

  @override
  String get settingsHiddenNotification => '隐藏发送者和消息';

  @override
  String get settingsSmartFilter => '智能过滤';

  @override
  String get settingsEmailVerificationSent => '验证邮件已发送';

  @override
  String get settingsEmailLinkInstructions => '请打开邮件中的验证链接，然后返回此处确认。';

  @override
  String get settingsSendVerificationEmail => '发送验证邮件';

  @override
  String get chatLogoutKeyWarning => '登出前請備份加密金鑰，否則可能無法再讀取加密訊息。';

  @override
  String get settingsBiometricUnavailable => '生物识别暂不可用，请检查系统设置中的人脸或指纹录入及应用权限。';

  @override
  String get chatEncryptionNotReady => '安全连接尚未就绪，消息未发送。请双方检查网络和设备验证后重试。';

  @override
  String get contactRequestPending => '等待对方接受';

  @override
  String get chatFriendRequestPending => '好友关系尚未确认，请到“联系人 → 新的朋友”查看并处理申请后再发送。';

  @override
  String contactPhotoCount(int count) {
    return '$count张照片';
  }

  @override
  String get videoPublish => '发布视频';

  @override
  String get videoGoLive => '发起直播';

  @override
  String get videoSelect => '选择视频';

  @override
  String get videoLiveUnavailable => '当前无法发起直播';

  @override
  String get qrcodeAlbum => '相册';

  @override
  String get settingsSwitchAccount => '切换账号';

  @override
  String get chatFilterUnread => '未读';

  @override
  String get chatFilterEmpty => '此分类暂无会话';

  @override
  String get accountAdd => '添加账号';

  @override
  String get accountCurrent => '当前账号';

  @override
  String get accountSwitching => '正在切换账号…';

  @override
  String get accountSwitchFailed => '切换失败，请重试，或添加该账号重新登录。';

  @override
  String get accountSessionsHint => '在此切换账号，各账号的消息和安全会话独立保留。';

  @override
  String get accountNoSaved => '尚无已保存的账号';

  @override
  String get contactRequestSent => '申请已发送';

  @override
  String get contactRequestsIncoming => '收到的申请';

  @override
  String get contactRequestsOutgoing => '发出的申请';

  @override
  String get contactRequestHint => '申请通过后即可聊天和通话。';

  @override
  String get callReturnToCall => '返回通话';

  @override
  String get chatMessageSending => '发送中';

  @override
  String get chatMessageSent => '已发送';

  @override
  String get chatMessageDelivered => '已送达';

  @override
  String get chatMessageRead => '已读';

  @override
  String get chatMessageFailed => '未发送，点击重试。';

  @override
  String get chatMessageUnavailable => '此设备暂时无法读取这条消息，点击查看恢复选项。';

  @override
  String get contactStarredFriends => '星标朋友';

  @override
  String get chatRecipientKeysMissing =>
      '对方暂无可用的加密会话。请对方登录并打开应用后重试。日常换号请使用“切换账号”，不要退出登录。';

  @override
  String get chatSwitchForMessaging =>
      '需要换号？请选择“切换账号”以保留消息和安全会话。退出登录会撤销此设备，可能导致收到的加密消息无法读取。';

  @override
  String get aiServiceUnavailable => 'AI 总结服务暂不可用，请待服务恢复访问后重试。';

  @override
  String aiSummarizeMessages(int count) {
    return '总结最近 $count 条消息';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return '$joined 人已加入 · $invited 人待接受';
  }

  @override
  String contactPendingCount(int count) {
    return '$count 条待处理申请';
  }

  @override
  String get chatDraftLabel => '草稿';

  @override
  String get contactIndexLabel => '联系人索引';

  @override
  String get transferAssetUnavailable => '支付资产不可用';

  @override
  String get transferPaymentRequestUnavailable => '收款请求不可用';

  @override
  String get chatCatchUp => '群聊追赶';

  @override
  String get chatCatchUpMentions => '提及我的';

  @override
  String get chatCatchUpReplies => '回复我的';

  @override
  String get chatCatchUpPinned => '置顶消息';

  @override
  String get chatCatchUpScope => '提及和回复仅筛选已加载消息，包含已读消息。加载更早消息可查找更早的回复。';

  @override
  String get chatCatchUpLoadMore => '加载更早消息';

  @override
  String get chatActionPreview => '确认日历建议';

  @override
  String get chatActionPrivacy => '确认后，仅将下方标题和时间交给日历应用。请核对时区。日历账户可能同步此日程。';

  @override
  String get chatActionTitle => '聊天日程';

  @override
  String get chatActionSuggestion => '日历建议';

  @override
  String get chatUnreadAttention => '未读提及与回复';

  @override
  String get chatScanAgain => '重新扫描';

  @override
  String get chatUnreadScope => '按服务器顺序扫描至已读标记。打开会话即可阅读，刷新可重新扫描。';

  @override
  String get chatScanIncomplete => '尚未完整：历史、解密或已读标记不可用，请同步后重试。';

  @override
  String get chatHistoryShare => '补发选定历史';

  @override
  String get chatHistoryExplanation =>
      '仅管理员可用。选择普通文本和已入群成员的现有加密私聊。补发会在群内留下可见审计消息。';

  @override
  String get chatHistoryEnable => '启用补发';

  @override
  String get chatHistoryDisable => '停用补发';

  @override
  String get chatHistoryPolicy => '群历史补发策略';

  @override
  String get chatHistoryPolicyDetail =>
      '仅管理员可补发。启用时也将群历史可见性限制为入群之后。请设置下方文本消息限制并确认。';

  @override
  String get chatHistoryPolicySaved => '策略已保存';

  @override
  String get chatHistoryRecipient => '接收人的加密私聊';

  @override
  String get chatHistoryReview => '预览选定消息';

  @override
  String get chatHistoryMessages => '条消息';

  @override
  String get chatHistoryConfirmDetail =>
      '请确认接收人、每条正文和时间再补发。失败或结果未知时内容可能已发出，请先核对结果。';

  @override
  String get chatHistoryCompleted => '选定历史已发送，群内审计已确认';

  @override
  String get chatHistoryPending => '待核对：请先核对，再确认继续。发送结果未知的内容不会重发。';

  @override
  String get chatHistoryReconcile => '核对发送结果';

  @override
  String get chatHistoryFailed =>
      '未能完成。请检查管理员权限、群策略、加密、接收人成员身份和选定内容。若已开始发送，请核对结果。';

  @override
  String get chatDeviceActions => '设备端操作';

  @override
  String get chatDeviceActionsReview =>
      '确认后，仅将此消息交给系统的设备端操作建议。选择建议可打开日历、提醒事项或地图。';

  @override
  String get chatHistoryMaxMessages => '消息上限（1–50）';

  @override
  String get chatHistoryMaxHours => '回溯小时数（1–720）';

  @override
  String get chatNotifyAll => '所有消息';

  @override
  String get chatNotifyAllDescription => '此聊天中每条新消息都通知';

  @override
  String get chatNotifyMentions => '仅提及我';

  @override
  String get chatNotifyMentionsDescription => '仅在有人提及你或使用 @room 时通知';

  @override
  String get chatNotifyMutedDescription => '在所有设备上关闭此聊天的通知';

  @override
  String get scheduledMessagesTitle => '定时消息';

  @override
  String get scheduledMessagesEmpty => '暂无定时消息';

  @override
  String get scheduledMessagesHint => '长按发送、照片、文件、GIF 或贴纸，即可设置定时发送。';

  @override
  String get scheduledMessageCancelled => '已取消定时消息';

  @override
  String scheduledMessageCreatedAt(String time) {
    return '创建于 $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => '发送结果未确认';

  @override
  String get scheduledRecoveryCopy => '保存恢复副本';

  @override
  String get scheduledRecoveryCopyHint =>
      '副本保存在此设备，不会更改或发送消息。预览最多显示 8,000 个字符。';

  @override
  String get scheduledRecoveryCopies => '恢复副本';

  @override
  String get scheduledRecoveryReset => '重置损坏队列';

  @override
  String get scheduledRecoveryResetHint =>
      '完整副本已保存在此设备。要重置此账号的所有定时消息吗？部分消息可能已发送。副本和附件将保留，不会重新发送任何消息。';

  @override
  String get scheduledRecoveryExportHint =>
      '此文件包含未加密的草稿文本和账号信息，不包含附件。请选择可信的保存或分享位置。';

  @override
  String get scheduledRecoveryImport => '导入恢复副本';

  @override
  String get scheduledRecoveryImportHint =>
      '仅将预览内容保存为恢复副本，不会安排或发送消息。文件不含附件，文件作者未经验证。';

  @override
  String get scheduledRecoveryComposerHint =>
      '将文本追加到当前草稿以供检查，不会发送消息。附件、提及和定时设置不会恢复。请确认此消息是否已送达。';

  @override
  String get backupRecoverLegacyArchive => '恢复旧的本地历史';

  @override
  String get backupLegacyArchiveWarning =>
      '这些历史记录的账号归属未经验证。请仅将属于你的房间复制到下方账号，原始记录会保留。';

  @override
  String get backupOlderFiles => '旧备份文件';

  @override
  String get backupOlderFilesWarning => '这些文件可能属于其他账号。请选择文件，核对内容和账号归属后再恢复。';

  @override
  String get stickerImportTitle => '导入贴纸包';

  @override
  String get stickerImportLinkHint => 'Matrix 贴纸包链接';

  @override
  String get stickerImportPreview => '预览';

  @override
  String get stickerImportUnavailable => '此贴纸包不可用，或你没有访问权限。';

  @override
  String get stickerImportCopyNotice => '添加此贴纸包的私人副本。图片和元数据不受端到端加密保护。';

  @override
  String get stickerImportFailed => '无法添加此贴纸包，请重试。';

  @override
  String get stickerImportAccountChanged => '账号已变更或登录已失效，请重新打开贴纸导入。';

  @override
  String get stickerPackSourceRoom => '来源会话';

  @override
  String get stickerPackImages => '图片';

  @override
  String get stickerPublishNotice =>
      '将此贴纸包发布到所选群聊。图片和元数据不受端到端加密保护。可读取群状态的人可能访问这些内容。';

  @override
  String get stickerPublishFailed => '未能确认发布结果。请先检查群聊，再决定是否重试。';

  @override
  String get stickerPublishReceiptMissing => '已发布，但链接未能保存。离开此页面前，请先分享或复制链接。';

  @override
  String get stickerSubscribe => '订阅更新';

  @override
  String get stickerSubscribeNotice =>
      '持续接收贴纸包管理员后续的修改。图片和元数据不受端到端加密保护。你可以稍后取消订阅；此操作不会加入来源群聊。';

  @override
  String get stickerSubscriptions => '贴纸订阅';

  @override
  String get stickerUnsubscribe => '取消订阅';

  @override
  String get stickerSubscriptionsEmpty => '暂无贴纸订阅';

  @override
  String get chatAttachmentEvent => '活动';

  @override
  String get chatRecentMedia => '最近的照片和视频';

  @override
  String get chatRecentMediaLoadFailed => '无法加载最近的照片和视频';

  @override
  String get chatRecentMediaPermission => '需要照片访问权限才能显示最近的照片和视频';

  @override
  String get chatRecentMediaEmpty => '暂无最近的照片或视频';

  @override
  String get chatRecentPhoto => '最近的照片';

  @override
  String get chatRecentVideo => '最近的视频';

  @override
  String get chatAttachmentTip => '打赏';

  @override
  String get chatAttachmentWhiteboard => '白板';

  @override
  String get chatAttachmentVideoNote => '视频留言';

  @override
  String get chatAttachmentCode => '代码';

  @override
  String get chatAttachmentShop => '商店';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '最多选择 $countString 项';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return '今晚 ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return '明早 ($time)';
  }

  @override
  String get a11yScrollToBottom => '滚动到底部';

  @override
  String get ui3EnterMessageBeforeScheduling => '请先输入消息再定时发送';

  @override
  String get ui3SendCode => '发送代码';

  @override
  String get ui3CodeLanguage => '语言';

  @override
  String get ui3PasteCodeHere => '在此粘贴代码';

  @override
  String ui3ReminderSetAt(String time) {
    return '已设置提醒 · $time';
  }

  @override
  String get ui3RedPacketCreateFailed => '红包创建失败';

  @override
  String get ui3SendTip => '打赏';

  @override
  String get ui3TokenLabel => '代币';

  @override
  String get ui3NoteOptional => '备注（可选）';

  @override
  String ui3TipFailed(String error) {
    return '打赏失败：$error';
  }

  @override
  String get ui3GiftNftTitle => '赠送 NFT';

  @override
  String get ui3TokenId => '代币 ID';

  @override
  String ui3NftGiftFailed(String error) {
    return 'NFT 赠送失败：$error';
  }

  @override
  String get ui3AiAgentSubtitle => '描述任务，打开合适的小程序';

  @override
  String get ui3GiftNft => '赠送 NFT';

  @override
  String get ui3GiftNftSubtitle => '向此联系人发送 NFT';

  @override
  String get ui3MiniAppUnavailable => '小程序不可用';

  @override
  String ui3MediaItemsNotSent(int count) {
    return '$count 个所选媒体未能发送';
  }

  @override
  String get ui3PhotosSubtitle => '以适合聊天的格式发送照片和视频';

  @override
  String get ui3OriginalImages => '原图';

  @override
  String get ui3OriginalImagesSubtitle => '以文件形式发送未压缩的照片';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return '已定时发送 $filename：$time';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return '正在发送原图：$filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return '已定时发送原图：$filename';
  }

  @override
  String get ui3PaymentAlreadySent => '已付款';

  @override
  String get ui3PaymentProcessing => '付款处理中';

  @override
  String ui3ChainStatus(String status) {
    return '链上状态：$status';
  }

  @override
  String get ui3NotChecked => '未检查';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return '已确认：$confirmations / $required 个区块';
  }

  @override
  String get ui3CopyTxHash => '复制交易哈希';

  @override
  String get ui3VerifyAgain => '重新验证';

  @override
  String get ui3VerifyOnChain => '链上验证';

  @override
  String get ui3TransferMissingChainDetails => '此转账未包含确切的链和资产信息。';

  @override
  String get ui3ReceiptPending => '链上待确认';

  @override
  String get ui3ReceiptConfirmed => '已确认';

  @override
  String get ui3ReceiptFailed => '链上失败';

  @override
  String get ui3ReceiptMismatch => '交易详情不匹配';

  @override
  String get ui3ReceiptUnsupported => '不支持链上验证';

  @override
  String get ui3ReceiptUnavailable => '验证不可用';

  @override
  String get ui3OpenOrSave => '打开 / 保存';

  @override
  String get ui3UnableToOpenFile => '无法打开此文件。';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'AI 改写失败：$error';
  }

  @override
  String get ui3AiShareMessagesTitle => '与 AI 共享消息？';

  @override
  String get ui3AiShareMessagesBody =>
      '选择 AI 可用于本次回复的消息。此次单次授权将在两分钟后失效。关闭快捷回复会取消待处理的结果。该授权不允许付款或导出。';

  @override
  String get ui3OtherParticipant => '对方';

  @override
  String get ui3ShareSelected => '共享所选';

  @override
  String get ui3BotCommandError => '命令错误';

  @override
  String get ui3BotUnknownCommand => '未知命令';

  @override
  String get ui3BotTypeHelp => '输入 /help 查看可用命令。';

  @override
  String get ui3FilesMediaLinks => '文件、媒体和链接';

  @override
  String get ui3ChatStorage => '聊天存储';

  @override
  String get ui3EncryptionKeysDevices => '加密密钥和设备';

  @override
  String get ui3EncryptionServiceUnavailable => '加密服务暂不可用';

  @override
  String get ui3ExportLoadingHistory => '正在加载更多聊天记录用于导出…';

  @override
  String get ui3ExportTxtDesc => '纯文本记录，可用于笔记、备份或合规审查';

  @override
  String get ui3ExportCustomRange => '自定义范围';

  @override
  String get ui3ExportStart => '开始';

  @override
  String get ui3ExportEnd => '结束';

  @override
  String get ui3ExportSelectDate => '选择日期';

  @override
  String get ui3FolderFilterUnreadOnly => '仅未读';

  @override
  String get ui3FolderFilterMutedOnly => '仅免打扰';

  @override
  String get ui3FolderFilterNoDms => '不含私聊';

  @override
  String get ui3FolderFilterNoGroups => '不含群聊';

  @override
  String get ui3FolderFilterNoChannels => '不含频道';

  @override
  String get ui3FolderFilterAllChats => '全部聊天';

  @override
  String get ui3Create => '创建';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return '删除文件夹“$name”？';
  }

  @override
  String get a11yDecreaseTextSize => '减小字号';

  @override
  String get a11yIncreaseTextSize => '增大字号';

  @override
  String ui3MinutesRead(int minutes) {
    return '阅读约 $minutes 分钟';
  }

  @override
  String get ui3TipOnChain => '已上链 ✓';

  @override
  String get ui3ViewSource => '查看源码';

  @override
  String get a11yPreviousPage => '上一页';

  @override
  String get a11yNextPage => '下一页';

  @override
  String get ui3OpenExternalLinkTitle => '打开外部链接？';

  @override
  String get ui3Open => '打开';

  @override
  String get ui3UnableToOpenLink => '无法打开此链接。';

  @override
  String get ui3ImageUnavailable => '图片不可用';

  @override
  String ui3LoadImageFrom(Object host) {
    return '从 $host 加载图片';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return '重新从 $host 加载图片';
  }

  @override
  String get ui3TranslatedByN42 => '由 N42 翻译';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return '由 N42 从$language翻译';
  }

  @override
  String get ui3ClearWhiteboardTitle => '清空白板？';

  @override
  String get ui3ClearWhiteboardMessage => '所有人的笔迹都将被清除，且无法撤销。';

  @override
  String get ui3WhiteboardLive => '白板 · 实时';

  @override
  String get a11yPenColor => '画笔颜色';

  @override
  String get ui3AiDescribeOcr => 'AI 识图 / 文字识别';

  @override
  String get ui3DocumentPreviewFailed => '无法安全预览此文档。请检查网络连接和文件大小（最大 2MB）。';

  @override
  String get ui3AiConsentMessage => '选择 AI 可用于本次摘要的消息。此单次授权两分钟后失效，不允许付款或导出。';

  @override
  String get ui3AiSuggestedReplies => '建议回复';

  @override
  String get ui3AiGeneratingSuggestions => '正在生成建议…';

  @override
  String get ui3StickersEmpty => '还没有贴纸';

  @override
  String get ui3StickersGet => '获取贴纸';

  @override
  String get a11yFormatBold => '粗体';

  @override
  String get a11yFormatItalic => '斜体';

  @override
  String get a11yFormatStrikethrough => '删除线';

  @override
  String get a11yFormatInlineCode => '行内代码';

  @override
  String get a11yFormatCodeBlock => '代码块';

  @override
  String get a11yFormatChecklistItem => '待办事项';

  @override
  String get a11yFormatBulletList => '项目符号列表';

  @override
  String get a11yFormatNumberedList => '编号列表';

  @override
  String get a11yFormatLink => '链接';

  @override
  String get a11yFormatTable => '表格';

  @override
  String get a11yFormatMeetingTemplate => '会议模板';

  @override
  String get a11yEmojiSmileys => '表情与人物';

  @override
  String get a11yEmojiHearts => '爱心';

  @override
  String get a11yEmojiAnimals => '动物与自然';

  @override
  String get a11yEmojiFood => '食物与饮料';

  @override
  String get a11yEmojiTravel => '旅行与地点';

  @override
  String get a11yEmojiActivities => '活动';

  @override
  String get a11yEmojiObjects => '物品';

  @override
  String get a11yEmojiSymbols => '符号';

  @override
  String get ui3FrequentlyUsed => '常用';

  @override
  String get ui3NoEditHistory => '暂无编辑记录';

  @override
  String get ui3EventNew => '新建日程';

  @override
  String get ui3EventTitleLabel => '标题';

  @override
  String get ui3EventLocationOptional => '地点（可选）';

  @override
  String get ui3EventDescriptionOptional => '描述（可选）';

  @override
  String get ui3EventSend => '发送日程';

  @override
  String get ui3EventTitleRequired => '请输入标题';

  @override
  String get ui3EventEndAfterStart => '结束时间必须晚于开始时间';

  @override
  String get ui3MiniAppAgentIntro => '描述你想做的事，我会为你打开合适的小程序。';

  @override
  String get ui3MiniAppAgentExample => '例如：把 ETH 兑换成 USDC';

  @override
  String get ui3MiniAppAgentNoMatch => '未找到匹配的小程序，请换个说法试试。';

  @override
  String ui3MiniAppOpen(Object appName) {
    return '打开$appName';
  }

  @override
  String get ui3MusicLinkPlatforms => '支持网易云、QQ音乐、酷狗、酷我等平台的歌曲链接';

  @override
  String get ui3PollMarkCorrectAnswer => '请为非空选项标记正确答案';

  @override
  String get ui3PollQuizMode => '测验模式';

  @override
  String get ui3PollAnswerExplanationHint => '答案解析（可选）';

  @override
  String get a11yCorrectAnswer => '正确答案';

  @override
  String get ui3AiSuggestions => 'AI 建议';

  @override
  String get a11yPaste => '粘贴';

  @override
  String get a11yRefresh => '刷新';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      '请妥善保管此密钥。如果您无法访问所有设备，这是恢复加密消息的唯一方式。';

  @override
  String ui3SavedToPath(Object path) {
    return '已保存：$path';
  }

  @override
  String get ui3UnknownAccount => '未知账号';

  @override
  String get ui3UnknownHomeserver => '未知服务器';

  @override
  String get ui3ImportRecoveryKey => '导入恢复密钥';

  @override
  String get ui3ImportRecoveryKeyDesc => '输入或粘贴恢复密钥，以恢复加密消息历史的房间密钥。';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return '账号：$account\\n服务器：$homeserver';
  }

  @override
  String get ui3Import => '导入';

  @override
  String get ui3InvalidRecoveryKeyFormat => '恢复密钥格式无效';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return '已恢复 $restored/$total 个密钥，$failed 个失败。请检查账号、网络和备份后重试。部分历史消息可能仍无法读取。';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return '已成功恢复 $restored/$total 个密钥';
  }

  @override
  String ui3ImportFailed(Object error) {
    return '导入失败：$error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return '通行密钥注册失败：$error';
  }

  @override
  String get ui3PasskeyDefaultName => '我的通行密钥';

  @override
  String get ui3PasskeyNameHint => '例如：iPhone、MacBook';

  @override
  String get ui3PasskeyDeleteFailed => '删除通行密钥失败';

  @override
  String get ui3TwoFactorAuth => '两步验证';

  @override
  String get ui3TwoFactorOnSubtitle => '已开启 — 需要验证器 App 的验证码';

  @override
  String get ui3TwoFactorOffSubtitle => '已关闭 — 使用验证器 App（TOTP）保护';

  @override
  String get ui3ShowRecoveryKey => '显示恢复密钥';

  @override
  String get ui3ShowRecoveryKeyDesc => '显示恢复密钥以便备份';

  @override
  String get ui3ImportRecoveryKeyHint => '使用恢复密钥恢复消息';

  @override
  String get ui3RecoveryKeyCreateFailed => '创建恢复密钥失败';

  @override
  String get ui3TotpIncorrectCode => '验证码错误，请重试';

  @override
  String get ui3TwoFactorEnabled => '两步验证已开启';

  @override
  String get ui3TwoFactorDisabled => '两步验证已关闭';

  @override
  String get ui3TwoFactorTurnOffTitle => '关闭两步验证？';

  @override
  String get ui3TwoFactorTurnOffMessage => '将不再需要验证器 App。之后可以使用新密钥重新设置。';

  @override
  String get ui3TurnOff => '关闭';

  @override
  String get ui3TwoFactorTotpTitle => '两步验证（TOTP）';

  @override
  String get ui3TwoFactorIsOn => '两步验证已开启';

  @override
  String get ui3TwoFactorCodeRequired => '需要验证器 App 生成的验证码。';

  @override
  String get ui3TotpStepScan =>
      '1. 使用验证器 App（Google Authenticator、Authy、1Password 等）扫描此二维码，或手动输入密钥。';

  @override
  String get ui3TotpKeyCopied => '密钥已复制';

  @override
  String get ui3TotpStepConfirm => '2. 输入 6 位验证码以确认。';

  @override
  String get ui3Enable => '开启';

  @override
  String get ui3BackupSettingsDesc => '备份本地聊天设置。重新登录后将从服务器恢复消息。';

  @override
  String get ui3BackupKeysSeparate => '加密密钥单独管理';

  @override
  String get ui3BackupKeysSeparateHint => '请在“安全 > 恢复密钥”中备份加密消息的访问权限。';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return '$rooms 个房间  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      '从其他设备或以前的备份导入 .n42backup 文件。加密密钥需使用恢复密钥单独恢复。';

  @override
  String get ui3UsernameSessionRequired => '设置用户名需要有效的登录会话';

  @override
  String get ui3SecuritySessionRequired => '安全设置需要有效的登录会话';

  @override
  String get ui3ConnectedAccountsSessionRequired => '关联账号需要有效的登录会话';

  @override
  String get ui3SystemAccounts => '系统与账号';

  @override
  String get ui3AccountIdentity => '账号与身份';

  @override
  String get ui3Accounts => '账号';

  @override
  String get ui3DevicesSessions => '设备与会话';

  @override
  String get ui3Integrations => '集成';

  @override
  String get ui3ConnectedAccounts => '关联账号';

  @override
  String get ui3ConnectedAccountsDesc => 'Telegram、WhatsApp、Discord 及 API 桥接集成';

  @override
  String get ui3SystemOverview => '系统概览';

  @override
  String ui3AccountCount(num count) {
    return '$count 个账号';
  }

  @override
  String ui3DeviceCount(num count) {
    return '$count 台设备';
  }

  @override
  String get ui3PrivacySecurityOverview => '端到端加密、截屏保护和代理控制';

  @override
  String get ui3ConversationPrivacy => '会话隐私';

  @override
  String get ui3NetworkPrivacy => '网络隐私';

  @override
  String get ui3IdentityPrivacy => '身份隐私';

  @override
  String get ui3EncryptionKeyBackup => '加密与密钥备份';

  @override
  String get ui3DevicesVerification => '设备与验证';

  @override
  String get ui3ChipE2eeDefault => '默认端到端加密';

  @override
  String get ui3ChipManualE2ee => '手动端到端加密';

  @override
  String get ui3ChipSelfDestruct => '阅后即焚';

  @override
  String get ui3ChipScreenshotGuard => '截屏保护';

  @override
  String get ui3ChipIpProxy => 'IP / 代理';

  @override
  String get ui3ChipLinkPreviewsOff => '链接预览已关闭';

  @override
  String get ui3ChipPublicHandle => '公开用户名';

  @override
  String get a11yShowPassword => '显示密码';

  @override
  String get a11yHidePassword => '隐藏密码';

  @override
  String get a11yCheckServer => '检查服务器';

  @override
  String get ui3AuthAnonymousRegistration => '匿名注册';

  @override
  String get ui3AuthAnonymousRegistrationDesc => '无需绑定手机号或邮箱即可创建账号，系统将自动生成用户名。';

  @override
  String get ui3AuthAnonymousModeOn => '已开启匿名模式';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      '应用将为你创建一个随机的 Matrix 用户名。之后你仍可使用生成的账号和密码登录。';

  @override
  String get ui3AuthChooseLoginMethod => '选择登录方式';

  @override
  String get ui3AuthSsoOpenFailed => '无法打开 SSO 登录页面';

  @override
  String get ui3AuthWalletUnavailable => '钱包不可用';

  @override
  String get ui3ProfileSubscriptions => '订阅';

  @override
  String get ui3ProfileBuySellCrypto => '买卖加密货币';

  @override
  String get ui3ProfileOnDeviceAi => '端侧 AI';

  @override
  String get ui3ProfileSetAUsername => '设置用户名';

  @override
  String get ui3ProfileAvatarStudio => '头像工作室';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'NFT 头像 / 装饰';

  @override
  String get ui3ProfileCustomize => '自定义';

  @override
  String get ui3ProfileQrSubtitle => '扫码查看此资料或发起聊天';

  @override
  String get ui3PrivacyHardening => '隐私加固';

  @override
  String get ui3HidePhoneNumber => '隐藏手机号';

  @override
  String get ui3HidePhoneNumberDesc => '在本设备的个人资料相关页面中遮盖已绑定的手机号';

  @override
  String get ui3EncryptNewChatsByDefault => '默认加密新聊天';

  @override
  String get ui3EncryptNewChatsByDefaultDesc => '新建单聊和私密群聊时默认开启端到端加密';

  @override
  String get ui3PrivateChatMode => '私密聊天模式';

  @override
  String get ui3PrivateChatModeDesc => '查看私密或加密聊天时临时启用防截屏';

  @override
  String get ui3DefaultSelfDestructTimer => '默认阅后即焚时长';

  @override
  String get ui3DefaultSelfDestructTimerDesc => '为新发送的消息应用默认阅后即焚时长';

  @override
  String get ui3LinkPreviews => '链接预览';

  @override
  String get ui3LinkPreviewsDesc => '消息包含网址时获取标题、描述和缩略图';

  @override
  String get ui3IpAddressProtection => 'IP 地址保护';

  @override
  String get ui3IpAddressProtectionDesc =>
      '在可用时通过你配置的 HTTP 隐私代理转发 Matrix 和链接预览请求';

  @override
  String get ui3UseTorProxy => '使用 Tor / Privoxy HTTP 代理';

  @override
  String get ui3UseTorProxyDesc =>
      '使用本地 HTTP 代理端点，例如 127.0.0.1:8118 上的 Privoxy。此处不支持原生 SOCKS5 Tor 路由。';

  @override
  String get ui3CustomProxy => '自定义代理';

  @override
  String get ui3CustomProxyDesc => '为 Matrix 流量和链接预览使用自定义 HTTP 或 HTTPS 代理';

  @override
  String get ui3ProxyEndpoint => '代理地址';

  @override
  String get ui3ProxyEndpointDesc => 'HTTP/HTTPS 代理地址（不支持 SOCKS）';

  @override
  String get ui3InvalidEndpoint => '地址无效';

  @override
  String get ui3CustomProxyStaysOff => '设置有效地址前，自定义代理保持关闭';

  @override
  String get ui3NotificationFilterNote => '优先规则始终通知（忽略静音、仅提及和免打扰）。屏蔽关键词会抑制通知。';

  @override
  String get ui3PriorityKeywords => '优先关键词';

  @override
  String get ui3PriorityKeywordHint => '例如：紧急';

  @override
  String get ui3MutedKeywords => '屏蔽关键词';

  @override
  String get ui3MutedKeywordHint => '例如：广告';

  @override
  String get ui3PrioritySenders => '优先发送者';

  @override
  String get ui3CaseSensitive => '区分大小写';

  @override
  String get ui3None => '无';

  @override
  String get ui3SmartReplyTranslation => '智能回复翻译';

  @override
  String get ui3SmartReplyTranslationDesc => '发送前自动将你的消息翻译为对方的语言。';

  @override
  String get ui3FromPhotos => '来自相册';

  @override
  String get ui3ChangePhoto => '更换照片';

  @override
  String get ui3RoamingUsesMobileData => '漫游沿用移动数据规则';

  @override
  String get ui3RoamingUsesMobileDataDesc => '暂不支持单独检测漫游，因此漫游时沿用移动数据的自动下载设置。';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return '删除“$content”？';
  }

  @override
  String get ui3ResetToDefaults => '恢复默认';

  @override
  String get ui3ResetQuickRepliesMessage => '这将删除所有自定义快捷回复并恢复默认，是否继续？';

  @override
  String get ui3LocalLlmUnavailable => '此设备不支持';

  @override
  String get ui3LocalLlmNotDownloaded => '模型未下载';

  @override
  String get ui3LocalLlmReady => '已就绪（端侧）';

  @override
  String get ui3LocalLlmDescription =>
      '启用并就绪后，AI 功能（摘要、改写、翻译、回复）完全在设备上运行，数据不会离开你的手机；否则使用云端服务。';

  @override
  String get ui3UseOnDeviceAi => '使用端侧 AI';

  @override
  String get ui3UseOnDeviceAiDesc => '就绪时优先本地推理';

  @override
  String get ui3DownloadModel => '下载模型';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      '端侧推理需要原生运行时（Android MediaPipe / iOS Core ML），平台处理程序可用后将自动启用。';

  @override
  String get ui3PhotoAvatar => '照片头像';

  @override
  String get ui3AvatarStyles => '头像样式';

  @override
  String get ui3AvatarStylesDesc => '个人资料与头像入口共用同一套装饰样式。';

  @override
  String get ui3ReplaceNftAvatar => '更换 NFT 头像';

  @override
  String get ui3NftAvatarDesc => '使用链上藏品作为头像。';

  @override
  String get ui3UsePhotoAvatar => '使用照片头像';

  @override
  String get ui3UsePhotoAvatarDesc => '保留已上传的头像并解除 NFT 绑定。';

  @override
  String ui3AvatarStyleSet(Object name) {
    return '头像样式已设为：$name';
  }

  @override
  String get ui3NftAvatarUpdated => 'NFT 头像已更新';

  @override
  String get ui3SwitchedToPhotoAvatar => '已切换回照片头像';

  @override
  String get ui3SignInToViewRedPacketHistory => '登录后查看红包记录';

  @override
  String get ui3RedPacketActive => '进行中';

  @override
  String get ui3RedPacketCompleted => '已领完';

  @override
  String get ui3CardsAndPasses => '卡券与通行证';

  @override
  String get ui3CardsAndPassesDesc => '钱包卡片、优惠券和通行证由主应用管理。';

  @override
  String get ui3CardPackRequiresMainApp => '卡包需要在主应用中使用';

  @override
  String get ui3OpenCardPack => '打开卡包';

  @override
  String get ui3UnableToOpenChat => '无法与该联系人开启聊天';

  @override
  String get ui3WalletManagedInMainApp => '钱包由主应用管理';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · 订阅计划';
  }

  @override
  String get ui3NewPlan => '新建计划';

  @override
  String get ui3MySubscriptions => '我的订阅';

  @override
  String get ui3AvailablePlans => '可用计划';

  @override
  String get ui3NoPlansYet => '暂无计划 · 点按“新建计划”创建';

  @override
  String ui3DaysLeft(Object days) {
    return '剩余 $days 天';
  }

  @override
  String get ui3SubscriptionCancelled => '已取消';

  @override
  String get ui3AutoRenewOn => '自动续订：开';

  @override
  String get ui3AutoRenewOff => '自动续订：关';

  @override
  String get ui3CancelSubscriptionTitle => '取消订阅？';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return '你对 $name 的订阅将保持有效至到期，之后不再续订。';
  }

  @override
  String get ui3Subscribe => '订阅';

  @override
  String ui3SubscribedTo(Object name) {
    return '已订阅 $name';
  }

  @override
  String get ui3PlanPriceLabel => '价格（例如 9.9 USDT）';

  @override
  String get ui3PlanDescriptionLabel => '描述（可选）';

  @override
  String get ui3PlanBenefitsLabel => '权益（用逗号分隔）';

  @override
  String get ui3PlanPeriod => '周期：';

  @override
  String get ui3Monthly => '按月';

  @override
  String get ui3Yearly => '按年';

  @override
  String get ui3SaveRemarkFailed => '备注保存失败';

  @override
  String get ui3CopyLink => '复制链接';

  @override
  String get ui3Connect => '连接';

  @override
  String get ui3CommonTokens => '共同代币';

  @override
  String get ui3SharedNfts => '共同 NFT';

  @override
  String get ui3TransactionHistory => '交易记录';

  @override
  String get ui3CommonDaos => '共同 DAO';

  @override
  String get ui3SameChains => '相同链';

  @override
  String get ui3ChatInitFailed => '聊天初始化失败';

  @override
  String get ui3CheckNetworkRetry => '请检查网络后重试';

  @override
  String get ui3FromContacts => '从通讯录添加';

  @override
  String get ui3FindFriendsFromContacts => '从手机通讯录查找好友';

  @override
  String get ui3EnsOrDomain => 'ENS / 域名';

  @override
  String get ui3LoadingContacts => '正在加载通讯录...';

  @override
  String get ui3ContactsPermissionRequired => '需要通讯录权限';

  @override
  String get ui3ContactsPermissionMessage => '如需从通讯录查找好友，请允许访问通讯录。';

  @override
  String get ui3AllowAccess => '允许访问';

  @override
  String get ui3NoContactMatches => '未找到匹配';

  @override
  String get ui3NoContactMatchesMessage => '你的通讯录联系人还没有使用此应用，邀请他们加入吧！';

  @override
  String ui3ScannedContacts(Object count) {
    return '已扫描 $count 位联系人';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return '在通讯录中找到 $count 个匹配';
  }

  @override
  String ui3InContactsAs(Object name) {
    return '通讯录中：$name';
  }

  @override
  String get ui3DeletePhotoConfirm => '删除这张照片？';

  @override
  String get ui3InviteLink => '邀请链接';

  @override
  String get ui3ShareJoinLink => '分享此群的加入链接';

  @override
  String get ui3ShareRoomReference => '向受邀成员分享群聊引用';

  @override
  String get ui3ScanToJoinGroup => '扫码直接加入此群';

  @override
  String get ui3ScanToShareRoomReference => '扫码向受邀成员分享群聊引用';

  @override
  String get ui3InviteLinkLoadFailed => '邀请链接加载失败';

  @override
  String get ui3InviteLinkCopied => '邀请链接已复制';

  @override
  String get ui3ChannelCategoryOptional => '分类（可选）';

  @override
  String get ui3ChannelCategoryHint => '公告 / 产品 / 支持';

  @override
  String get ui3DescriptionOptional => '描述（可选）';

  @override
  String get ui3WebhookEnable => '启用 Webhook 自动化';

  @override
  String get ui3WebhookEnableDesc => '将成员加入和欢迎事件推送到你的集成端点。';

  @override
  String get ui3WebhookUrl => 'Webhook 地址';

  @override
  String get ui3WebhookSecretOptional => '签名密钥（可选）';

  @override
  String get ui3WebhookSecretHint => '用于 X-N42-Signature';

  @override
  String get ui3WebhookNotifyMemberJoined => '成员加入时通知';

  @override
  String get ui3WebhookNotifyWelcomeSent => '发送欢迎语时通知';

  @override
  String get ui3WebhookTestSend => '发送测试 Webhook';

  @override
  String get ui3WebhookTestSending => '正在发送测试 Webhook...';

  @override
  String get ui3WebhookTestSent => '测试 Webhook 发送成功';

  @override
  String get ui3WebhookTestFailed => '测试 Webhook 发送失败';

  @override
  String get ui3WebhookUrlInvalid => 'Webhook 地址必须是公开的 HTTPS 地址';

  @override
  String get ui3WebhookSelectEvent => '请至少选择一个 Webhook 事件';

  @override
  String get ui3SensitiveDataDetection => '敏感信息检测';

  @override
  String get ui3Email => '邮箱';

  @override
  String get ui3CreditCard => '银行卡';

  @override
  String get ui3DetectEmailDesc => '检测文本消息中的邮箱地址';

  @override
  String get ui3DetectPhoneDesc => '检测手机号和国际号码';

  @override
  String get ui3DetectCardDesc => '检测疑似银行卡号';

  @override
  String get ui3DetectWalletDesc => '检测以太坊格式的钱包地址';

  @override
  String get ui3GeneralTopic => '综合';

  @override
  String get a11yPreviousResult => '上一个结果';

  @override
  String get a11yNextResult => '下一个结果';

  @override
  String get ui3TryDifferentKeywords => '试试其他关键词';

  @override
  String ui3FiltersActive(Object count) {
    return '已启用筛选：$count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return '已启用消息筛选：$count';
  }

  @override
  String get ui3LoadMore => '加载更多';

  @override
  String get ui3MessageFilters => '消息筛选';

  @override
  String get ui3SenderUserId => '发送者用户 ID';

  @override
  String get ui3FilterType => '类型';

  @override
  String get ui3FilterAny => '全部';

  @override
  String get ui3FilterImage => '图片';

  @override
  String get ui3FilterTime => '时间';

  @override
  String get ui3AnyTime => '不限时间';

  @override
  String get ui3OnlyMyMessages => '仅我的消息';

  @override
  String get ui3MediaOnly => '仅媒体';

  @override
  String get ui3Apply => '应用';

  @override
  String get ui3QrStyleClassic => '经典';

  @override
  String get ui3QrStyleOcean => '海洋';

  @override
  String get ui3QrStyleBerry => '莓果';

  @override
  String get a11yFlashlightOn => '打开手电筒';

  @override
  String get a11yFlashlightOff => '关闭手电筒';

  @override
  String get ui3SocialGraph => '社交图谱';

  @override
  String get ui3RecommendedConnections => '推荐连接';

  @override
  String get ui3Portfolio => '资产组合';

  @override
  String get ui3Chains => '链';

  @override
  String get ui3Tokens => '代币';

  @override
  String get ui3NoConnectionsFound => '暂无连接';

  @override
  String get ui3ConnectionsHint => '随着你的链上活动增加，连接会逐渐出现';

  @override
  String get ui3SocialGraphLoadFailed => '社交图谱加载失败';

  @override
  String get ui3Similarity => '相似度';

  @override
  String get ui3Breakdown => '明细';

  @override
  String get ui3TokenHoldings => '代币持仓';

  @override
  String get ui3NftCollections => 'NFT 合集';

  @override
  String get ui3ChainUsage => '链使用';

  @override
  String get ui3Transactions => '交易';

  @override
  String get ui3DaoMembership => 'DAO 成员资格';

  @override
  String get ui3NotWeighted => '不计权重';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent%（权重：$weight）';
  }

  @override
  String get ui3CommonOnChainActivity => '共同链上活动';

  @override
  String get ui3SharedTokens => '共同代币';

  @override
  String get ui3SharedNftCollections => '共同 NFT 合集';

  @override
  String get ui3SharedChains => '共同链';

  @override
  String get ui3NoSharedTokens => '未发现共同代币';

  @override
  String get ui3NoSharedNftCollections => '未发现共同 NFT 合集';

  @override
  String get ui3NoSharedChains => '未发现共同链';

  @override
  String get ui3SimilarityFailed => '相似度计算失败';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items 等另外 $count 项';
  }

  @override
  String get a11yGovernance => '治理';

  @override
  String get ui3CommunityLink => '社区链接';

  @override
  String get ui3CommunityQrCode => '社区二维码';

  @override
  String get ui3CommunityQrSubtitle => '扫码加入此社区并浏览其频道';

  @override
  String get ui3CommunityLinkLoadFailed => '社区链接加载失败';

  @override
  String get ui3CommunityLinkCopied => '社区链接已复制';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name 将被移出此社区。';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name 将被移出且无法重新加入。';
  }

  @override
  String get ui3SignInToDiscoverChannels => '登录后即可发现公开频道';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return '无法加入 $name：$error';
  }

  @override
  String get ui3CategoryTech => '科技';

  @override
  String get ui3CategorySocial => '社交';

  @override
  String get ui3NoPublicChannels => '未找到公开频道';

  @override
  String get ui3StoriesAndFun => '故事与趣味';

  @override
  String get ui3SearchMusicHint => '搜索歌曲、艺人或好友';

  @override
  String get ui3ForYou => '为你推荐';

  @override
  String get ui3Liked => '已喜欢';

  @override
  String get ui3NoLikedMusic => '还没有喜欢的音乐';

  @override
  String get ui3NoMusicStories => '还没有音乐动态';

  @override
  String get ui3LikedMusicHint => '点击歌曲旁的爱心即可收藏到这里。';

  @override
  String get ui3MusicStoriesHint => '动态中分享的音乐会显示在这里。';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · 由 $name 分享';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return '无法播放 $title：$error';
  }

  @override
  String get a11yPreviousTrack => '上一首';

  @override
  String get a11yNextTrack => '下一首';

  @override
  String get a11yPlay => '播放';

  @override
  String get a11yPause => '暂停';

  @override
  String get ui3Refresh => '刷新';

  @override
  String get ui3NearbyIntroTitle => '发现附近的公开动态';

  @override
  String get ui3NearbyIntroBody => '你的位置仅在本设备上使用一次，用于对公开朋友圈排序，不会上传、广播或展示给他人。';

  @override
  String get ui3UseMyLocation => '使用我的位置';

  @override
  String get ui3NearbyUnavailable => '附近功能不可用';

  @override
  String get ui3NoNearbyPosts => '附近暂无动态';

  @override
  String get ui3NoNearbyPostsHint => '带位置的公开朋友圈会显示在这里。';

  @override
  String get ui3NearbyDistanceNote => '大致距离 · 仅显示公开的位置动态';

  @override
  String get ui3PublicLocationPost => '公开位置动态';

  @override
  String get ui3LocationServicesOff => '定位服务已关闭';

  @override
  String get ui3LocationPermissionDenied => '定位权限被拒绝';

  @override
  String get ui3EnableLocationInSettings => '请在系统设置中开启定位权限';

  @override
  String get ui3CreateStory => '发布动态';

  @override
  String get ui3CreateStoryDesc => '发布文字或照片状态。';

  @override
  String get ui3StoryCamera => '动态相机';

  @override
  String get ui3StoryCameraDesc => '直接进入滤镜和照片编辑。';

  @override
  String get ui3MomentsDesc => '打开完整动态和评论。';

  @override
  String get ui3MomentCamera => '朋友圈相机';

  @override
  String get ui3MomentCameraDesc => '发布帖子并立即选择媒体。';

  @override
  String get ui3GamesDesc => '打开内置休闲游戏中心。';

  @override
  String get ui3AvatarStudio => '头像工作室';

  @override
  String get ui3AvatarStudioDesc => '装饰、NFT 头像与身份标识。';

  @override
  String get ui3SocialGraphDesc => '链上关注、粉丝与连接。';

  @override
  String get ui3SocialHubHeroTitle => '动态、朋友圈、游戏和头像';

  @override
  String get ui3SocialHubHeroBody => '统一使用现有社交功能，而不是把入口分散在聊天、个人资料和发现中。';

  @override
  String get ui3SocialGraphNotConfigured => '此版本未配置社交图谱';

  @override
  String get ui3ConnectWalletForSocialGraph => '连接钱包以查看你的社交图谱';

  @override
  String get ui3AvatarStudioSignIn => '头像工作室需要登录';

  @override
  String get a11yRemoveImage => '移除图片';

  @override
  String get a11yBack => '返回';

  @override
  String get ui3MiniAppConfirmTransactionTitle => '确认交易';

  @override
  String get ui3MiniAppConfirmTransactionBody => '小程序正在请求代表你发送一笔交易。';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return '打开 $name？';
  }

  @override
  String get ui3MiniAppOpenButton => '打开';

  @override
  String get ui3StoryReplySendFailed => '故事回复发送失败';

  @override
  String get ui3RedPacketDemoNotice => '演示红包——仅为聊天内记录，不会转移真实的链上资产。';

  @override
  String get ui3RedPacketCoverClassic => '经典红';

  @override
  String get ui3RedPacketCoverGolden => '金色';

  @override
  String get ui3RedPacketCoverPurple => '紫色';

  @override
  String get ui3RedPacketCoverOceanBlue => '海洋蓝';

  @override
  String get ui3RedPacketCoverNatureGreen => '自然绿';

  @override
  String get ui3RedPacketCoverRosePink => '玫瑰粉';

  @override
  String get ui3RedPacketHistoryEmpty => '暂无红包';

  @override
  String get ui3TransferMerchantQrWithAmount => '商户收款码（含金额）';

  @override
  String get ui3TransferMerchantQrTitle => '商户收款码';

  @override
  String get ui3TransferOpenAmountHint => '留空则不限金额';

  @override
  String get ui3FiatRampTitle => '买入 / 卖出加密货币';

  @override
  String get ui3FiatRampBuy => '买入';

  @override
  String get ui3FiatRampSell => '卖出';

  @override
  String get ui3FiatRampNotConfigured => '未配置法币出入金通道';

  @override
  String get a11yPointsAddRule => '添加奖励规则';

  @override
  String get a11yGovernanceRemoveChoice => '移除选项';

  @override
  String get a11yGovernanceCreateProposal => '创建提案';

  @override
  String get ui3MiniAppUpdateN42 => '更新 N42';

  @override
  String get ui3MiniAppOfficial => '官方';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count 位用户';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return '背景颜色 $index';
  }

  @override
  String get a11yStoryAdd => '添加动态';

  @override
  String get ui3StoryPostFailed => '发布动态失败';

  @override
  String get ui3StoryTapToSelectImage => '点击选择图片';

  @override
  String get ui3StoryChangeImage => '更换';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return '无法读取所选音乐：$error';
  }

  @override
  String get ui3StoryDeleteConfirm => '删除这条动态？';

  @override
  String get ui3StoryDeleteFailed => '删除动态失败';

  @override
  String get ui3MomentCreateTitle => '发布动态';

  @override
  String get ui3MomentContentHint => '这一刻的想法…';

  @override
  String get ui3MomentAddPhotos => '添加照片';

  @override
  String get ui3MomentAddLocation => '添加位置';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return '已选媒体（$count）';
  }

  @override
  String get ui3MomentClearAll => '全部清除';

  @override
  String get ui3MomentClearMediaConfirm => '移除所有已选的照片/视频？';

  @override
  String get ui3MomentVisibilityPublicDesc => '所有朋友可见';

  @override
  String get ui3MomentVisibilityPrivateDesc => '仅自己可见';

  @override
  String get ui3MomentVisibilityPartialDesc => '选择谁可以看';

  @override
  String get ui3MomentVisibilityExcludedDesc => '不给指定朋友看';

  @override
  String get ui3MomentVideos => '视频';

  @override
  String get ui3MomentNoVideos => '暂无视频';

  @override
  String get a11yCallMinimize => '最小化';

  @override
  String get a11yCallGridView => '宫格视图';

  @override
  String get a11yCallFocusView => '聚焦视图';

  @override
  String get ui3CallTools => '通话工具';

  @override
  String get ui3CallMeetingTools => '会议工具';

  @override
  String get ui3CallToolsSubtitle => '无需离开通话即可调整音视频质量。';

  @override
  String get ui3CallAudioEnhancement => '音频增强';

  @override
  String get ui3CallNoiseSuppression => '降噪';

  @override
  String get ui3CallNoiseSuppressionDesc => '减少键盘声和背景噪音。';

  @override
  String get ui3CallEchoCancellation => '回声消除';

  @override
  String get ui3CallEchoCancellationDesc => '防止扬声器声音回传到麦克风。';

  @override
  String get ui3CallAutoGainControl => '自动增益';

  @override
  String get ui3CallAutoGainControlDesc => '让麦克风音量更稳定。';

  @override
  String get ui3CallVoiceIsolation => '增强人声隔离';

  @override
  String get ui3CallVoiceIsolationDesc => '使用更强的降噪配置。';

  @override
  String get ui3CallVideoSection => '视频';

  @override
  String get ui3CallBackgroundBlur => '背景虚化（测试版）';

  @override
  String get ui3CallBlurDescReady => '偏好已生效，实际虚化效果仍取决于视频处理器的上线。';

  @override
  String get ui3CallBlurDescSaved => '虚化偏好已保存，摄像头处理可用时将生效。';

  @override
  String get ui3CallBlurDescCameraOff => '背景处理可用后请打开摄像头。';

  @override
  String get ui3CallRecordingSection => '录制';

  @override
  String get ui3CallRecordingDesc => '需要服务端录制服务后才能保存录音。';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return '更新通话设置失败：$error';
  }

  @override
  String get ui3CallRecordingStarted => '已开始录制';

  @override
  String get ui3VoiceRoomNotFound => '房间不存在';

  @override
  String get ui3VoiceRoomEndConfirm => '确定要结束这个语音房间吗？';

  @override
  String get a11yGameMoveUp => '向上移动';

  @override
  String get a11yGameMoveDown => '向下移动';

  @override
  String get a11yGameMoveLeft => '向左移动';

  @override
  String get a11yGameMoveRight => '向右移动';

  @override
  String get a11yGameRotate => '旋转';

  @override
  String get a11yGameDrop => '落下';

  @override
  String ui3StickerAddedCount(Object count) {
    return '已添加 $count 个贴纸';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return '添加失败：$error';
  }

  @override
  String get ui3StickerRemoveTitle => '移除贴纸';

  @override
  String get ui3StickerRemoveConfirm => '要从贴纸包中移除此贴纸吗？';

  @override
  String get ui3StickerRemoveFailed => '移除失败';

  @override
  String get ui3StickerRenamePack => '重命名贴纸包';

  @override
  String get ui3StickerPackName => '贴纸包名称';

  @override
  String get ui3StickerRenameFailed => '重命名失败';

  @override
  String get ui3StickerDeletePack => '删除贴纸包';

  @override
  String get ui3StickerThisPack => '此贴纸包';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return '要删除“$name”及其所有贴纸吗？此操作无法撤销。';
  }

  @override
  String get ui3StickerDeleteFailed => '删除失败';

  @override
  String get ui3StickerPack => '贴纸包';

  @override
  String get ui3StickerAdding => '正在添加…';

  @override
  String get ui3StickerAddStickers => '添加贴纸';

  @override
  String get ui3StickerPackNotFound => '未找到贴纸包';

  @override
  String get ui3StickerEmptyHint => '点按“添加贴纸”上传图片';

  @override
  String get ui3StickerNewPack => '新建贴纸包';

  @override
  String get ui3StickerCreate => '创建';

  @override
  String get ui3StickerCreateFailed => '创建贴纸包失败';

  @override
  String ui3StickerInstalled(Object name) {
    return '已添加“$name”';
  }

  @override
  String get ui3StickerRemovePackTitle => '移除贴纸包';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return '要从你的贴纸中移除“$name”吗？';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return '已移除“$name”';
  }

  @override
  String get ui3StickerAiSticker => 'AI 贴纸';

  @override
  String get ui3StickerStoreTab => '商店';

  @override
  String get ui3StickerMyStickersTab => '我的贴纸';

  @override
  String get ui3StickerNoneFound => '未找到贴纸';

  @override
  String ui3StickerByAuthor(Object author) {
    return '作者：$author';
  }

  @override
  String get ui3StickerManage => '管理';

  @override
  String ui3StickerCount(Object count) {
    return '$count 个贴纸';
  }

  @override
  String get ui3StickerNoneInstalled => '尚未添加贴纸';

  @override
  String get ui3StickerGetFromStore => '去商店获取贴纸';

  @override
  String get ui3StickerBrowseStore => '浏览商店';

  @override
  String get ui3StickerAddedToAi => '已添加到“AI 贴纸”';

  @override
  String get ui3StickerAddOneFailed => '添加贴纸失败';

  @override
  String get ui3StickerPromptLabel => '描述你的贴纸';

  @override
  String get ui3StickerPromptHint => '例如：一只戴墨镜的开心橘猫';

  @override
  String get ui3StickerGenerating => '正在生成…';

  @override
  String get ui3StickerGenerate => '生成';

  @override
  String get ui3StickerAddToStickers => '添加到贴纸';

  @override
  String get ui3StickerGeneratingPreview => '正在生成你的贴纸…';

  @override
  String get ui3StickerGenerateEmpty => '描述一个贴纸，然后点按“生成”';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class SZhTw extends SZh {
  SZhTw() : super('zh_TW');

  @override
  String get commonRetry => '重試';

  @override
  String get commonUnknownUser => '未知用戶';

  @override
  String get transferWalletNotConnected => '錢包未連接';

  @override
  String get chatCallServiceNotInitialized => '通話服務未初始化';

  @override
  String authLoginFailed(Object error) {
    return '登錄失敗: $error';
  }

  @override
  String get chatCallBack => '回撥';

  @override
  String get chatMissedVideoCall => '未接視頻通話';

  @override
  String get chatMissedVoiceCall => '未接語音通話';

  @override
  String get chatCallNotAnswered => '對方未接聽';

  @override
  String get chatCallDurationLabel => '通話時長';

  @override
  String get chatVoiceCallCancelled => '語音通話已取消';

  @override
  String get chatVideoCallCancelled => '視頻通話已取消';

  @override
  String get commonImage => '[圖片]';

  @override
  String get chatVideo => '[視頻]';

  @override
  String get chatVoice => '[語音]';

  @override
  String get commonFile => '[文件]';

  @override
  String get chatLocation => '[位置]';

  @override
  String get chatUnknownMessage => '[未知消息]';

  @override
  String get commonDelete => '刪除';

  @override
  String get chatDeleteThisMessage => '刪除這條消息？';

  @override
  String get chatMessageDeleted => '消息已刪除';

  @override
  String get profileNotLoggedIn => '未登錄';

  @override
  String get chatMyLocation => '我的位置';

  @override
  String get commonGroupChat => '羣聊';

  @override
  String get commonSearch => '搜索';

  @override
  String get commonCancel => '取消';

  @override
  String get commonLoadFailed => '加載失敗';

  @override
  String get commonMessages => '消息';

  @override
  String get commonContacts => '聯繫人';

  @override
  String get commonMe => '我';

  @override
  String get commonVoiceLoading => '語音加載中，請稍後再試';

  @override
  String get commonVoiceToTextFailed => '語音轉文字失敗';

  @override
  String get commonConvertToText => '轉文字';

  @override
  String get chatCopy => '複製';

  @override
  String get commonForward => '轉發';

  @override
  String get commonUnfavorite => '取消收藏';

  @override
  String get commonFavorite => '收藏';

  @override
  String get settingsResend => '重新發送';

  @override
  String get chatRecall => '撤回';

  @override
  String get commonQuote => '引用';

  @override
  String get commonRemind => '提醒';

  @override
  String get chatCopied => '已複製';

  @override
  String get storySendMessageHint => '發送消息';

  @override
  String get commonMicrophonePermissionRequired => '請允許使用麥克風權限';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麥克風權限已被拒絕，請在系統設置中開啓以使用語音消息功能。';

  @override
  String commonStartRecordingFailed(Object error) {
    return '開始錄音失敗: $error';
  }

  @override
  String get commonRecordingTooShort => '錄音時間太短';

  @override
  String commonStopRecordingFailed(Object error) {
    return '停止錄音失敗: $error';
  }

  @override
  String get chatReleaseToCancel => '鬆開取消';

  @override
  String get chatReleaseToSend => '鬆開發送，上滑取消';

  @override
  String get commonHoldToTalk => '按住 說話';

  @override
  String get commonSend => '發送';

  @override
  String get commonAddFriend => '添加好友';

  @override
  String get commonChatServiceNotConnected => '聊天服務未連接';

  @override
  String contactUserNotFoundHint(String query) {
    return '未找到用戶 \"$query\"\n\n提示：\n• 嘗試輸入完整用戶ID，如 @username:server.com\n• 確認用戶名拼寫正確';
  }

  @override
  String contactCreateChatFailed(String error) {
    return '創建會話失敗: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return '搜索失敗: $error';
  }

  @override
  String get contactEnterUserIdOrUsername => '輸入用戶 ID 或用戶名搜索';

  @override
  String get contactSearching => '搜索中...';

  @override
  String get contactSearchUserToChat => '搜索用戶開始聊天';

  @override
  String get contactMatrixIdExample =>
      '可以輸入完整的 Matrix ID\n例如: @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return '未找到用戶 \"$username\"';
  }

  @override
  String get commonChat => '聊天';

  @override
  String get commonSettings => '設置';

  @override
  String get profileEditProfile => '編輯資料';

  @override
  String get authLogin => '登錄';

  @override
  String get commonCreateGroup => '創建羣聊';

  @override
  String get chatError => '錯誤';

  @override
  String get commonTransfer => '轉賬';

  @override
  String get commonReceived => '已被接收';

  @override
  String get commonRefunded => '已退還';

  @override
  String get commonExpired => '已過期';

  @override
  String get chatRedPacketGreeting => '恭喜發財，大吉大利';

  @override
  String get commonN42RedPacket => 'N42紅包';

  @override
  String get commonClaimed => '已領取';

  @override
  String get commonAllClaimed => '已被領完';

  @override
  String get chatReadAloud => '朗讀';

  @override
  String get chatReply => '回覆';

  @override
  String get commonEdit => '編輯';

  @override
  String get chatSelectForwardTarget => '選擇轉發對象';

  @override
  String commonSendCount(int count) {
    return '發送($count)';
  }

  @override
  String contactN42Id(Object id) {
    return 'N42號：$id';
  }

  @override
  String get profileN42IdTitle => 'N42號';

  @override
  String get profileN42Bean => 'N42豆';

  @override
  String get contactFriendInfo => '朋友資料';

  @override
  String get contactFriendInfoDesc => '添加朋友的備註名、電話、標籤、備忘、照片等，並設置朋友權限。';

  @override
  String get commonMoments => '朋友圈';

  @override
  String get commonSendMessage => '發消息';

  @override
  String get contactAudioVideoCall => '音視頻通話';

  @override
  String get contactVideoChannel => '視頻號';

  @override
  String get contactRemark => '備註';

  @override
  String get contactRemarkName => '備註名';

  @override
  String get contactPhone => '電話';

  @override
  String get contactTags => '標籤';

  @override
  String get contactNotes => '備忘';

  @override
  String get contactPhotos => '照片';

  @override
  String get contactPermissions => '權限';

  @override
  String get contactChatMomentsEtc => '聊天、朋友圈、運動等';

  @override
  String get contactMoreInfo => '更多信息';

  @override
  String get contactCommonGroups => '我和他 (她) 的共同羣聊';

  @override
  String get contactSource => '來源';

  @override
  String get settingsNotificationSettings => '消息通知';

  @override
  String get settingsPrivacy => '隱私';

  @override
  String get settingsAppearance => '外觀';

  @override
  String get settingsAbout => '關於';

  @override
  String get commonLogout => '退出登錄';

  @override
  String get commonLogoutConfirm => '確定要退出登錄嗎？';

  @override
  String get commonSave => '保存';

  @override
  String get profileNickname => '暱稱';

  @override
  String get profileEnterNickname => '請輸入暱稱';

  @override
  String get profileSignature => '簽名';

  @override
  String get profileAddSignature => '添加個性簽名';

  @override
  String get commonTakePhoto => '拍照';

  @override
  String get profileChooseFromGallery => '從相冊選擇';

  @override
  String profileSaveFailed(Object error) {
    return '保存失敗: $error';
  }

  @override
  String get authSecureDecentralizedChat => '安全、去中心化的即時通訊';

  @override
  String get commonEndToEndEncryption => '端到端加密';

  @override
  String get authMessagesOnlyYouCanSee => '消息僅你和對方可見';

  @override
  String get authDecentralized => '去中心化';

  @override
  String get authBasedOnMatrix => '基於Matrix開放協議';

  @override
  String get authWalletIntegration => '錢包集成';

  @override
  String get authEasyCryptoTransfer => '輕鬆進行加密貨幣轉賬';

  @override
  String get authRegister => '註冊';

  @override
  String get authAgreeTerms => '登錄即表示同意';

  @override
  String get authTermsOfService => '《服務協議》';

  @override
  String get authAnd => '和';

  @override
  String get authPrivacyPolicy => '《隱私政策》';

  @override
  String get authServerAddress => '服務器地址';

  @override
  String get authEnterServerAddress => '請輸入服務器地址';

  @override
  String authConnectedTo(Object serverName) {
    return '已連接到 $serverName';
  }

  @override
  String get authUsername => '用戶名';

  @override
  String get authEnterUsername => '請輸入用戶名';

  @override
  String get authUsernameOrEmail => '用戶名或郵箱';

  @override
  String get authEnterUsernameOrEmail => '請輸入用戶名或郵箱';

  @override
  String get authPassword => '密碼';

  @override
  String get authEnterPassword => '請輸入密碼';

  @override
  String get authRegisterAccount => '註冊賬號';

  @override
  String get authForgotPassword => '忘記密碼';

  @override
  String get authOtherLoginMethods => '其他登錄方式';

  @override
  String get authCreateAccount => '創建賬號';

  @override
  String get authJoinN42Chat => '加入 N42 Chat 開始聊天';

  @override
  String get authUsernameHint => '3-20字符，字母/數字/_';

  @override
  String get authUsernameMinLength => '用戶名至少3個字符';

  @override
  String get authUsernameMaxLength => '用戶名最多20個字符';

  @override
  String get authUsernameFormat => '用戶名只能包含字母、數字和下劃線';

  @override
  String get authPasswordHint => '至少8位';

  @override
  String get commonPasswordMinLength => '密碼至少8位';

  @override
  String get authConfirmPassword => '確認密碼';

  @override
  String get authFilled => '已填寫';

  @override
  String get authEnterInviteCode => '請輸入邀請碼';

  @override
  String get authAlreadyHaveAccount => '已有賬號？';

  @override
  String get authLoginNow => '立即登錄';

  @override
  String get profileAvatar => '頭像';

  @override
  String get profileStatus => '狀態';

  @override
  String get commonLoading => '加載中...';

  @override
  String get conversationNoConversations => '暫無會話';

  @override
  String get conversationTapToChat => '點擊右上角開始聊天';

  @override
  String get conversationStartGroup => '發起羣聊';

  @override
  String get commonScan => '掃一掃';

  @override
  String get commonPayment => '收付款';

  @override
  String commonFeatureComingSoon(Object feature) {
    return '$feature 功能即將推出';
  }

  @override
  String get conversationMarkAsRead => '標記已讀';

  @override
  String get commonUnmute => '取消靜音';

  @override
  String get commonMute => '消息免打擾';

  @override
  String get conversationUnpin => '取消置頂';

  @override
  String get conversationPin => '置頂';

  @override
  String get conversationDeleteConversation => '刪除會話';

  @override
  String conversationDeleteConversationConfirm(Object name) {
    return '確定要刪除與 $name 的會話嗎？';
  }

  @override
  String get commonNoContacts => '暫無聯繫人';

  @override
  String get contactAddFriendsToChat => '添加好友開始聊天';

  @override
  String get contactNotFound => '未找到聯繫人';

  @override
  String get contactTryOtherKeywords => '嘗試搜索其他關鍵詞或全局搜索';

  @override
  String get contactSearchResults => '搜索結果';

  @override
  String get contactNewFriends => '新的朋友';

  @override
  String get contactChatOnlyFriends => '僅聊天的朋友';

  @override
  String get contactOfficialAccounts => '公衆號';

  @override
  String get contactServiceAccounts => '服務號';

  @override
  String get contactEnterpriseContacts => '企業聯繫人';

  @override
  String get contactRecommendToFriend => '推薦給朋友';

  @override
  String get commonSetRemark => '設置備註';

  @override
  String get contactSendingCard => '正在發送名片...';

  @override
  String get commonFileLabel => '文件';

  @override
  String get commonLocationLabel => '位置';

  @override
  String contactRecommendFailed(Object error) {
    return '推薦失敗: $error';
  }

  @override
  String get profileEnterRemark => '請輸入備註名';

  @override
  String get contactOpeningChat => '正在打開聊天...';

  @override
  String contactOpenChatFailed(Object error) {
    return '打開聊天失敗: $error';
  }

  @override
  String get contactAddContact => '添加聯繫人';

  @override
  String get contactEnterUserId => '輸入用戶ID';

  @override
  String get contactNoFriendRequests => '暫無好友請求';

  @override
  String get commonAccept => '接受';

  @override
  String get commonReject => '拒絕';

  @override
  String get commonNoGroups => '暫無羣聊';

  @override
  String get contactSelectFriendToRecommend => '選擇要推薦給的朋友';

  @override
  String get commonSearchContacts => '搜索聯繫人';

  @override
  String get contactNoContactsFound => '沒有找到聯繫人';

  @override
  String get favoriteYesterday => '昨天';

  @override
  String get chatJustNow => '剛剛';

  @override
  String get profileOnline => '在線';

  @override
  String get profileOffline => '離線';

  @override
  String get searchContactsGroupsMessages => '搜索聯繫人、羣聊和消息';

  @override
  String get searchError => '搜索出錯';

  @override
  String get chatSearchHint => '搜索';

  @override
  String get searchHistory => '搜索歷史';

  @override
  String get commonClear => '清除';

  @override
  String get commonAll => '全部';

  @override
  String get searchGroups => '羣聊';

  @override
  String get searchNoResults => '無結果';

  @override
  String commonGroupMembers(Object count) {
    return '羣成員 ($count)';
  }

  @override
  String get groupMembersTitle => '羣成員';

  @override
  String get groupViewAll => '查看全部';

  @override
  String get groupOwner => '羣主';

  @override
  String get groupAdmin => '管理';

  @override
  String get groupInvite => '邀請';

  @override
  String get commonGroupAnnouncement => '羣公告';

  @override
  String get commonNotSet => '未設置';

  @override
  String get groupDescription => '羣簡介';

  @override
  String get groupPublicGroup => '公開羣聊';

  @override
  String get commonClearChatHistory => '清空聊天記錄';

  @override
  String get commonDissolveGroup => '解散羣聊';

  @override
  String get commonLeaveGroup => '退出羣聊';

  @override
  String get groupChangeGroupName => '修改羣名稱';

  @override
  String get commonEnterGroupName => '請輸入羣名稱';

  @override
  String get commonConfirm => '確認';

  @override
  String get groupEnterGroupDescription => '請輸入羣簡介';

  @override
  String get groupPublish => '發佈';

  @override
  String get chatClearHistoryConfirm => '確定要清空聊天記錄嗎？此操作不可恢復。';

  @override
  String get chatClearAction => '清空';

  @override
  String get commonChatHistoryCleared => '聊天記錄已清空';

  @override
  String get commonDissolve => '解散';

  @override
  String get groupQrCode => '羣二維碼';

  @override
  String get commonSearchChatHistory => '查找聊天記錄';

  @override
  String get groupIdCopied => '羣ID已複製';

  @override
  String get transferEnterOrPasteAddress => '輸入或粘貼錢包地址';

  @override
  String get transferSelectToken => '選擇代幣';

  @override
  String get commonTransferAmount => '轉賬金額';

  @override
  String get transferAvailable => '可用';

  @override
  String get transferMemoOptional => '備註（可選）';

  @override
  String get transferConfirmTransfer => '確認轉賬';

  @override
  String get transferAddressVerified => '地址已驗證';

  @override
  String transferAvailableBalance(Object balance, Object symbol) {
    return '可用餘額: $balance $symbol';
  }

  @override
  String get commonEnterAmount => '請輸入金額';

  @override
  String get commonRedPacketCountMin => '紅包個數至少爲1';

  @override
  String get commonViewRedPacketDetails => '查看紅包詳情';

  @override
  String get commonEnterTransferAmount => '請輸入轉賬金額';

  @override
  String get commonTransferTo => '轉賬給';

  @override
  String commonFromSender(String name) {
    return '來自 $name';
  }

  @override
  String get commonConfirmReceive => '確認收款';

  @override
  String get groupProfile => '羣資料';

  @override
  String get groupRemoveMember => '移出羣聊';

  @override
  String get commonRemove => '移出';

  @override
  String get profileClearStatus => '清除狀態';

  @override
  String get profileClearStatusConfirm => '確定要清除當前狀態嗎？';

  @override
  String get profileStatusCleared => '狀態已清除';

  @override
  String get profileUserNotExist => '用戶不存在';

  @override
  String get profileUserIdCopied => '用戶ID已複製';

  @override
  String get commonReport => '舉報';

  @override
  String get profileQrCode => '二維碼';

  @override
  String get profileAvatarUpdated => '頭像更新成功';

  @override
  String commonSelectImageFailed(Object error) {
    return '選擇圖片失敗: $error';
  }

  @override
  String get profileChangeName => '修改名字';

  @override
  String get profileMale => '男';

  @override
  String get profileFemale => '女';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature功能開發中...';
  }

  @override
  String profileSaveAddressFailed(Object error) {
    return '保存地址失敗: $error';
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
  String get profileDeleteAddress => '刪除地址';

  @override
  String get profileAddressDeleted => '地址已刪除';

  @override
  String profileSaveInvoiceFailed(Object error) {
    return '保存發票抬頭失敗: $error';
  }

  @override
  String get profileMyInvoices => '我的發票抬頭';

  @override
  String get profileAddInvoice => '添加發票抬頭';

  @override
  String get profileInvoiceAdded => '發票抬頭添加成功';

  @override
  String get profileInvoiceUpdated => '發票抬頭更新成功';

  @override
  String get profileDeleteInvoice => '刪除發票抬頭';

  @override
  String get profileInvoiceDeleted => '發票抬頭已刪除';

  @override
  String get profilePersonal => '個人';

  @override
  String get groupSelectAtLeastOne => '請至少選擇一位成員';

  @override
  String get chatFileNotExist => '文件不存在';

  @override
  String chatSendFailed(String error) {
    return '發送失敗: $error';
  }

  @override
  String get chatCannotOpenBrowser => '無法打開瀏覽器';

  @override
  String chatSelectFileFailed(String error) {
    return '選擇文件失敗: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return '設置失敗: $error';
  }

  @override
  String get transferEnterValidAmount => '請輸入有效的轉賬金額';

  @override
  String get commonAddressCopied => '地址已複製';

  @override
  String favoriteOpenItem(Object content) {
    return '打開: $content';
  }

  @override
  String get favoriteDeleted => '已刪除';

  @override
  String get profileWallet => '錢包';

  @override
  String get chatRecording => '錄像';

  @override
  String get chatInvalidVideoUrl => '無效的視頻鏈接';

  @override
  String get chatDownloadFile => '下載文件';

  @override
  String get chatClearChatHistoryTitle => '清空聊天記錄';

  @override
  String get chatVideoCall => '視頻通話';

  @override
  String get commonVoiceCall => '語音通話';

  @override
  String get callLeaveMeeting => '離開會議';

  @override
  String get chatDetails => '聊天詳情';

  @override
  String get chatViewAllGroupMembers => '查看全部羣成員';

  @override
  String get chatGroupName => '羣聊名稱';

  @override
  String get chatGroupNameUpdated => '羣名稱已更新';

  @override
  String get chatUpdateFailed => '更新失敗';

  @override
  String get chatNoPermissionToModify => '您沒有修改權限';

  @override
  String get chatGroupManagement => '羣管理';

  @override
  String get chatMyNicknameInGroup => '我在本羣的暱稱';

  @override
  String get chatPinChat => '置頂聊天';

  @override
  String get chatStrongReminder => '強提醒';

  @override
  String get chatSetChatBackground => '設置當前聊天背景';

  @override
  String get chatUnknownFile => '未知文件';

  @override
  String get chatDownload => '下載';

  @override
  String get chatInvalidLocation => '無效的位置';

  @override
  String get chatTapToCancel => '點擊取消';

  @override
  String chatCaptureFailed(Object error) {
    return '拍攝失敗: $error';
  }

  @override
  String get chatProcessingVideo => '正在處理視頻...';

  @override
  String get chatVideoFileNotExist => '視頻文件不存在';

  @override
  String get chatVideoDataEmpty => '視頻數據爲空';

  @override
  String get chatVideoTooLarge => '視頻大小不能超過 100MB';

  @override
  String get chatSendingVideo => '視頻發送中...';

  @override
  String chatSendVideoFailed(Object error) {
    return '發送視頻失敗: $error';
  }

  @override
  String get chatImageFileNotExist => '圖片文件不存在';

  @override
  String get commonImageDataEmpty => '圖片數據爲空';

  @override
  String get chatSendingImage => '圖片發送中...';

  @override
  String chatSendImageFailed(Object error) {
    return '發送圖片失敗: $error';
  }

  @override
  String get chatSendLocation => '發送位置';

  @override
  String get chatSelectLocationAndSend => '選擇地點併發送給對方';

  @override
  String get chatShareRealTimeLocation => '共享實時位置';

  @override
  String get chatShareLocationForOneHour => '與好友共享1小時實時位置';

  @override
  String get chatLocationSent => '位置已發送';

  @override
  String get chatSelectMessages => '選擇消息';

  @override
  String chatSelectedCount(int count) {
    return '已選擇 $count';
  }

  @override
  String get chatSelectAll => '全選';

  @override
  String chatGroupChatCount(int count) {
    return '羣聊($count)';
  }

  @override
  String get chatPrivateChat => '私聊';

  @override
  String get chatNoMessages => '暫無消息';

  @override
  String get chatSendFirstMessage => '發送第一條消息開始聊天';

  @override
  String get chatEncryptionNotice => '此聊天已啓用端到端加密。只有您和對方可以閱讀消息。';

  @override
  String get chatMultiForward => '轉發';

  @override
  String get chatCollect => '收藏';

  @override
  String get chatNoMembers => '沒有成員';

  @override
  String get chatMemberNotFound => '未找到成員';

  @override
  String get chatVoiceFileNotExist => '語音文件不存在';

  @override
  String get chatVoiceFileEmpty => '語音文件爲空';

  @override
  String get chatSendingVoice => '語音發送中...';

  @override
  String chatSendVoiceFailed(Object error) {
    return '發送語音失敗: $error';
  }

  @override
  String get chatMessageForwarded => '消息已轉發';

  @override
  String chatForwardFailed(Object error) {
    return '轉發失敗: $error';
  }

  @override
  String get chatUnfavorited => '已取消收藏';

  @override
  String get chatFavorited => '已收藏';

  @override
  String get chatReactionAdded => '已添加表情回應';

  @override
  String get chatReactionRemoved => '已移除表情回應';

  @override
  String get chatFailedMessageDeleted => '已刪除失敗消息';

  @override
  String get chatDeleteMessages => '刪除消息';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return '確定要刪除 $count 條消息嗎？';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return '注意：$count 條消息來自他人，僅對你刪除。';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count 條你發送的消息將對所有人撤回。';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return '已撤回 $count 條消息，$localCount 條僅對你刪除';
  }

  @override
  String chatRecalledMessages(Object count) {
    return '已撤回 $count 條消息';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count 條消息僅對你刪除';
  }

  @override
  String chatForwardedCount(Object count) {
    return '已轉發 $count 條消息';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return '轉發完成：成功 $success 條，失敗 $failed 條';
  }

  @override
  String get chatRemindOnlyInGroup => '提醒功能僅在羣聊中可用';

  @override
  String get chatOnlyTextSearchable => '僅支持搜索文本消息';

  @override
  String chatSearchFor(Object text) {
    return '搜索 \"$text\"';
  }

  @override
  String get chatBaiduSearch => '百度搜索';

  @override
  String get chatGoogleSearch => 'Google 搜索';

  @override
  String get chatBingSearch => '必應搜索';

  @override
  String get chatCalling => '呼叫中...';

  @override
  String get chatRinging => '響鈴中...';

  @override
  String get chatInCall => '通話中';

  @override
  String commonFeatureInDevelopment(Object feature) {
    return '$feature功能開發中...';
  }

  @override
  String chatCollectMessages(Object count) {
    return '已收藏 $count 條消息';
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
  String get profileServices => '服務';

  @override
  String get commonFavorites => '收藏';

  @override
  String get profileOrdersAndCards => '訂單與卡包';

  @override
  String get profileStickers => '表情';

  @override
  String profileStatusSetTo(String status) {
    return '狀態已設置爲：$status';
  }

  @override
  String get profileAvatarUploadFailed => '頭像上傳失敗';

  @override
  String get profilePersonalProfile => '個人信息';

  @override
  String get profileName => '名字';

  @override
  String get profileGender => '性別';

  @override
  String get profileRegion => '地區';

  @override
  String get commonMyQrCode => '我的二維碼';

  @override
  String get profilePoke => '拍一拍';

  @override
  String get profileRingtone => '來電鈴聲';

  @override
  String get profileDefaultRingtone => '默認鈴聲';

  @override
  String get profileMyAddresses => '我的地址';

  @override
  String profileGenderSetTo(String gender) {
    return '性別已設置爲：$gender';
  }

  @override
  String get profileSelectRegion => '選擇地區';

  @override
  String get profileSelectCity => '選擇城市';

  @override
  String profileRegionSetTo(String region) {
    return '地區已設置爲：$region';
  }

  @override
  String get profileSetPoke => '設置拍一拍';

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
    return '拍一拍已設置爲：拍了拍我$suffix';
  }

  @override
  String get profileEditSignature => '編輯個性簽名';

  @override
  String get profileIntroduceYourself => '一句話介紹自己';

  @override
  String get profileSignatureCleared => '個性簽名已清除';

  @override
  String get profileSignatureUpdated => '個性簽名已更新';

  @override
  String get profileScanToAddFriend => '掃一掃上面的二維碼圖案，加我爲好友';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return '來電鈴聲已設置爲：$ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return '確定要解散羣聊「$name」嗎？此操作無法撤銷。';
  }

  @override
  String get authEnterValidServerAddress => '請輸入有效的服務器地址';

  @override
  String get authEnterServerAddressFirst => '請先輸入服務器地址';

  @override
  String get authPasskeyRequiresServer => 'Passkey登錄需要服務器支持';

  @override
  String get authLoginAgreement => '登錄即表示同意';

  @override
  String get authPleaseAgreeToTerms => '請先閱讀並同意服務協議和隱私政策';

  @override
  String get authRegisterFailed => '註冊失敗';

  @override
  String get authRegistrationDisabled => '此伺服器已關閉註冊，請聯絡伺服器管理員開放註冊。';

  @override
  String get commonReenterPassword => '請再次輸入密碼';

  @override
  String get commonPasswordsDoNotMatch => '兩次輸入的密碼不一致';

  @override
  String get authInviteCodeBuiltIn => '邀請碼（已內置）';

  @override
  String get authInviteCodeBuiltInNote => '邀請碼已內置，通常無需修改';

  @override
  String get authIHaveReadAndAgree => '我已閱讀並同意';

  @override
  String get mainStartGroupChat => '發起羣聊';

  @override
  String get mainAddFriends => '添加朋友';

  @override
  String get mainPaymentAndCollection => '收付款';

  @override
  String contactCount(int count) {
    return '$count位聯繫人';
  }

  @override
  String get contactAddToHomeScreen => '添加到桌面';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return '已將$contact的名片推薦給$recipient';
  }

  @override
  String get contactEnterRemarkName => '請輸入備註名';

  @override
  String contactRemarkSetTo(String remark) {
    return '備註已設置爲：$remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return '已接受$name的好友請求';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return '已拒絕$name的好友請求';
  }

  @override
  String get commonGroupInvites => '羣邀請';

  @override
  String commonMyGroups(int count) {
    return '我的羣聊 ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => '邀請加入羣聊';

  @override
  String commonConfirmLeaveGroup(String name) {
    return '確定要退出羣聊「$name」嗎？';
  }

  @override
  String get commonLeave => '離開';

  @override
  String get commonRecallThisMessage => '撤回該條消息？';

  @override
  String get commonSavedToGallery => '已保存到相冊';

  @override
  String get commonFailedToSave => '保存失敗';

  @override
  String get chatSaving => '保存中...';

  @override
  String get commonShare => '分享';

  @override
  String get chatSaveToGallery => '保存到相冊';

  @override
  String get chatFailedToLoadImage => '圖片加載失敗';

  @override
  String get chatVideoRecordingFailed => '視頻錄製失敗，請重試';

  @override
  String get profileRedPacket => '紅包';

  @override
  String get commonMusic => '音樂';

  @override
  String get commonCoupon => '卡券';

  @override
  String get commonGift => '禮物';

  @override
  String get commonPoll => '投票';

  @override
  String get favoriteText => '文本';

  @override
  String get favoriteLinkLabel => '鏈接';

  @override
  String get favoriteNote => '筆記';

  @override
  String get favoriteMyNotes => '我的筆記';

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
  String get favoriteNoFavorites => '暫無收藏';

  @override
  String get favoriteLongPressToFavorite => '長按消息進行收藏';

  @override
  String get favoriteNewNote => '新建筆記';

  @override
  String get favoriteLink => '收藏鏈接';

  @override
  String get favoriteEditTags => '編輯標籤';

  @override
  String get favoriteDeleteFavorite => '刪除收藏';

  @override
  String get favoriteDeleteFavoriteConfirm => '確定要刪除這條收藏嗎？';

  @override
  String get favoriteNoSearchResultsFound => '沒有找到結果';

  @override
  String get commonSendRedPacket => '發紅包';

  @override
  String get transferAmount => '金額';

  @override
  String get commonRedPacketCover => '紅包封面';

  @override
  String get commonRedPacketType => '紅包類型';

  @override
  String get commonNormalRedPacket => '普通紅包';

  @override
  String get commonLuckyRedPacket => '拼手氣';

  @override
  String get commonRedPacketCount => '紅包個數';

  @override
  String get commonPieces => '個';

  @override
  String get commonPutMoneyInRedPacket => '塞錢進紅包';

  @override
  String get commonRedPacketRefundNotice => '未領取的紅包，將於24小時後發起退款';

  @override
  String get commonOpenRedPacket => '開';

  @override
  String get commonRedPacketAllClaimed => '紅包已被領完';

  @override
  String get commonRedPacketExpired => '紅包已過期';

  @override
  String get commonAddTransferNote => '添加轉賬說明';

  @override
  String get commonYuan => '元';

  @override
  String get commonReplyWithEmoji => '用此表情回覆';

  @override
  String get contactEditRemark => '編輯備註';

  @override
  String get contactSetPermissions => '設置權限';

  @override
  String get profileAddToBlacklist => '加入黑名單';

  @override
  String get contactDeleteContact => '刪除聯繫人';

  @override
  String contactDeleteContactConfirm(String name) {
    return '確定要刪除 $name 嗎？';
  }

  @override
  String get transferTitle => '轉賬';

  @override
  String get transferReceiverAddressLabel => '收款地址';

  @override
  String get transferSelectTokenLabel => '選擇代幣';

  @override
  String get transferAmountLabel => '轉賬金額';

  @override
  String get transferMemoLabel => '備註（可選）';

  @override
  String get transferAddMemoHint => '添加備註信息';

  @override
  String get transferSendPaymentRequest => '發送收款請求';

  @override
  String get transferQrCodeGenerateFailed => '二維碼生成失敗';

  @override
  String get transferScanQrToPayMe => '掃描二維碼向我付款';

  @override
  String get transferMyWalletAddress => '我的錢包地址';

  @override
  String get transferCreatePaymentRequest => '創建收款請求';

  @override
  String profileN42IdLabel(String id) {
    return 'N42號：$id';
  }

  @override
  String get commonRedPacketDefaultGreeting => '恭喜發財，大吉大利';

  @override
  String commonSenderRedPacket(String name) {
    return '$name的紅包';
  }

  @override
  String get transferEnterValidAddress => '請輸入有效的收款地址';

  @override
  String get transferPleaseSelectToken => '請選擇代幣';

  @override
  String get commonReceivedTransfer => '收到轉賬';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name發出的紅包';
  }

  @override
  String get commonSavedToBalance => '已存入零錢，可直接轉賬';

  @override
  String get commonRedPacketExpiredOrEmpty => '紅包已過期/已領完';

  @override
  String get transferScanFeatureComingSoon => '掃描功能開發中...';

  @override
  String get contactSetAsStarred => '設爲星標朋友';

  @override
  String get contactAddToBlocklist => '加入黑名單';

  @override
  String get commonClaimedYour => '領取了你的';

  @override
  String get commonClaimedText => '領取了';

  @override
  String commonUserTyping(String name) {
    return '$name正在輸入...';
  }

  @override
  String get commonTyping => '對方正在輸入...';

  @override
  String get commonWaitingToReceive => '待對方接收';

  @override
  String get commonTapToClaim => '點擊領取';

  @override
  String get commonHasBeenReceived => '已被接收';

  @override
  String get commonGetLucky => '領個好彩頭';

  @override
  String get qrcodeCameraStartFailed => '相機啓動失敗';

  @override
  String get qrcodeUnknownError => '未知錯誤';

  @override
  String get qrcodePlaceQrCodeInFrame => '將二維碼放入框內掃描';

  @override
  String get qrcodeCloseManualInput => '關閉手動輸入';

  @override
  String get qrcodeManualInputUserId => '手動輸入用戶ID';

  @override
  String get commonAdd => '加入';

  @override
  String get profileSetStatus => '設置狀態';

  @override
  String get profileVisibleToFriends24h => '可被好友看到，24小時後自動清除';

  @override
  String get profileWriteStatus => '寫狀態';

  @override
  String get profileEnterYourStatus => '輸入你的狀態...';

  @override
  String get profileOk => '確定';

  @override
  String get qrcodeCameraPermissionRequired => '掃描二維碼需要相機權限';

  @override
  String get qrcodeCameraPermissionDenied => '相機權限已被永久拒絕，請在系統設置中開啓。';

  @override
  String qrcodePermissionCheckError(String error) {
    return '檢查權限時出錯: $error';
  }

  @override
  String get qrcodeInvalidQrCode => '無效的二維碼';

  @override
  String qrcodeCannotAddFriend(String error) {
    return '無法添加好友: $error';
  }

  @override
  String get qrcodeScanQrCode => '掃描二維碼';

  @override
  String get qrcodeCheckingCameraPermission => '正在檢查相機權限...';

  @override
  String get qrcodeNeedCameraPermission => '需要相機權限';

  @override
  String get qrcodeRetryPermission => '重試';

  @override
  String get qrcodeOpenSettings => '打開設置';

  @override
  String get groupInviteMembers => '邀請成員';

  @override
  String groupInviteCount(int count) {
    return '邀請($count)';
  }

  @override
  String get profileNoShippingAddress => '暫無收貨地址';

  @override
  String get profileDefaultLabel => '默認';

  @override
  String get profileNoInvoice => '暫無發票抬頭';

  @override
  String get profileCompany => '企業';

  @override
  String get profileTaxNumber => '稅號';

  @override
  String get profileConfirmDeleteAddress => '確定要刪除這個地址嗎？';

  @override
  String get profileConfirmDeleteInvoice => '確定要刪除這個發票抬頭嗎？';

  @override
  String get commonGroupOwner => '羣主';

  @override
  String get commonGroupAdmin => '管理員';

  @override
  String get groupSearchMembers => '搜索成員';

  @override
  String groupTotalMembers(int count) {
    return '$count位成員';
  }

  @override
  String get chatRemoveFromGroup => '移出羣聊';

  @override
  String groupConfirmRemoveMember(String name) {
    return '確定要將\"$name\"移出羣聊嗎？';
  }

  @override
  String get chatUnknownSong => '未知歌曲';

  @override
  String get chatUnknownArtist => '未知藝術家';

  @override
  String get chatUnknownContact => '未知聯繫人';

  @override
  String get chatPersonalCard => '個人名片';

  @override
  String get chatSingleChoice => '單選';

  @override
  String get chatMultiChoice => '多選';

  @override
  String get chatEnded => '已結束';

  @override
  String get chatEndPollButton => '結束投票';

  @override
  String get chatPollHint => '投票發起後將顯示在聊天中，羣成員可以參與投票';

  @override
  String get chatSearchSongOrArtist => '搜索歌曲或歌手';

  @override
  String get chatNoSongsFound => '沒有找到歌曲';

  @override
  String get chatSongNameOptional => '歌曲名稱（可選）';

  @override
  String get chatEnterSongName => '輸入歌曲名稱';

  @override
  String get chatArtistNameOptional => '歌手名稱（可選）';

  @override
  String get chatEnterArtistName => '輸入歌手名稱';

  @override
  String get chatRealTimeLocationSharing => '實時位置共享功能開發中...';

  @override
  String get profileVoiceCallFeatureInDev => '語音通話功能開發中...';

  @override
  String get profileReportFeatureInDev => '舉報功能開發中...';

  @override
  String get profileShareFeatureInDev => '分享功能開發中...';

  @override
  String get profileQrCodeFeatureInDev => '二維碼功能開發中...';

  @override
  String get qrcodeScanQrToAddMe => '掃一掃上面的二維碼，加我爲好友';

  @override
  String get qrcodeSaveToAlbum => '保存到相冊';

  @override
  String get qrcodeChangeStyle => '換個樣式';

  @override
  String get qrcodeCopyId => '複製 ID';

  @override
  String get qrcodeIdCopied => '已複製用戶 ID';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => '更多樣式即將推出';

  @override
  String get profileBio => '個性簽名';

  @override
  String get profileHomeServer => '服務器';

  @override
  String get profileShareContactCard => '分享名片';

  @override
  String get profileRemoveFromBlacklist => '移出黑名單';

  @override
  String get profileConfirmAddBlacklist => '確定將該用戶加入黑名單嗎？你將不再收到對方的消息';

  @override
  String get profileConfirmRemoveBlacklist => '確定將該用戶移出黑名單嗎？';

  @override
  String get profileRemarkSaved => '備註已保存';

  @override
  String get profileRemarkCleared => '已清除備註';

  @override
  String get transferReceive => '收款';

  @override
  String get transferPleaseConnectWallet => '請先連接錢包';

  @override
  String get transferSendRequest => '發送請求';

  @override
  String get transferPleaseEnterValidAmount => '請輸入有效的金額';

  @override
  String get searchPlaceholder => '搜索聯繫人、羣聊、消息';

  @override
  String get searchEnterKeywordToSearch => '輸入關鍵詞開始搜索';

  @override
  String get searchClearHistory => '清除';

  @override
  String get searchClearHistoryConfirm => '清除所有最近的搜尋紀錄？';

  @override
  String searchNoResultsForQuery(String query) {
    return '沒有找到\"$query\"相關的結果';
  }

  @override
  String get searchAllResults => '全部';

  @override
  String get searchInChat => '在聊天中搜索';

  @override
  String get searchContactLabel => '聯繫人';

  @override
  String get searchGroupLabel => '羣聊';

  @override
  String get searchConversationLabel => '會話';

  @override
  String get searchMessageLabel => '消息';

  @override
  String get settingsSecurityTitle => '安全';

  @override
  String get settingsDeleteAccountTitle => '刪除帳戶';

  @override
  String get settingsDeleteAccountSubtitle => '停用此 Matrix 帳戶並清理其本機聊天資料';

  @override
  String get settingsDeleteAccountExplanation =>
      '此操作會要求永久停用 Matrix 帳戶。伺服器確認後，本應用程式會在安全的情況下移除此帳戶的本機聊天工作階段與加密金鑰。其他帳戶及錢包將保留。聯邦網路與伺服器保留規則可能限制資料清除。';

  @override
  String get settingsDeleteAccountPasswordOptional => 'Matrix 密碼（如有要求）';

  @override
  String get settingsDeleteAccountServerErase => '要求清除伺服器資料';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      '要求此主伺服器在支援的情況下清除帳戶資料。其他伺服器持有的副本或依保留規則儲存的資料可能仍然存在。';

  @override
  String get settingsDeleteAccountChooseStage => '驗證此 Matrix 帳戶';

  @override
  String get settingsDeleteAccountUsePassword => '使用 Matrix 密碼';

  @override
  String get settingsDeleteAccountUseBrowser => '在瀏覽器中繼續';

  @override
  String get settingsDeleteAccountFallbackTitle => '從 Matrix 驗證返回';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      '從瀏覽器返回不代表刪除已確認。請向 Matrix 伺服器核對此次原始要求。';

  @override
  String get settingsDeleteAccountCheckServer => '向伺服器核對';

  @override
  String get settingsDeleteAccountRequestFailed => 'Matrix 伺服器未確認帳戶刪除。';

  @override
  String get settingsDeleteAccountPendingTitle => '本機帳戶資料待清理';

  @override
  String get settingsDeleteAccountPendingSubtitle => '查看先前已停用 Matrix 帳戶的清理情況';

  @override
  String get settingsDeleteAccountPendingReadError => '無法讀取待清理紀錄。點一下重試。';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'Matrix 帳戶已停用，但本機資料仍待清理。其他帳戶仍可使用。';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      '已在瀏覽器中開啟帳戶管理。本應用程式尚未確認刪除，因此聊天工作階段仍可使用。';

  @override
  String get settingsKeyBackup => '密鑰備份';

  @override
  String get settingsBackupEncryptionKeys => '備份加密密鑰';

  @override
  String settingsKeysBackedUp(int count) {
    return '已備份 $count 個密鑰';
  }

  @override
  String get settingsBackupNotSet => '未設置備份';

  @override
  String get settingsRestoreKeys => '恢復密鑰';

  @override
  String get settingsRestoreKeysFromBackup => '從備份恢復加密密鑰';

  @override
  String get settingsExportKeys => '導出密鑰';

  @override
  String get settingsExportKeysToFile => '導出密鑰到文件';

  @override
  String get settingsLoggedInDevices => '已登錄設備';

  @override
  String get settingsNoOtherDevices => '暫無其他設備';

  @override
  String get settingsVerified => '已驗證';

  @override
  String get settingsUnverified => '未驗證';

  @override
  String get settingsAdvanced => '高級';

  @override
  String get settingsCrossSigning => '跨設備簽名';

  @override
  String get settingsEnabled => '已啓用';

  @override
  String get settingsNotEnabled => '未啓用';

  @override
  String get settingsResetEncryption => '重置加密';

  @override
  String get settingsDeleteAllEncryptionKeys => '刪除所有加密密鑰';

  @override
  String get settingsEncryptionNotSupported => '不支持加密';

  @override
  String get settingsNotInitialized => '未初始化';

  @override
  String get settingsBackupKeyTitle => '備份密鑰';

  @override
  String get settingsBackupKeyMessage => '是否創建新的密鑰備份？這將幫助您在新設備上恢復加密消息。';

  @override
  String get settingsBackup => '備份';

  @override
  String get settingsRestoreKeyTitle => '恢復密鑰';

  @override
  String get settingsRestoreKeyMessage => '輸入您的恢復密碼或恢復密鑰來恢復加密消息。';

  @override
  String get settingsRestore => '恢復';

  @override
  String get settingsExportKeyTitle => '導出密鑰';

  @override
  String get settingsExportKeyMessage => '導出的密鑰文件包含您的所有加密密鑰，請妥善保管。';

  @override
  String get settingsExport => '導出';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return '設備ID: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => '狀態: 已驗證';

  @override
  String get settingsDeviceStatusUnverified => '狀態: 未驗證';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return '最後活躍: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => '驗證此設備';

  @override
  String get settingsCrossSigningAlreadyEnabled => '跨設備簽名已啓用';

  @override
  String get settingsCrossSigningSetupSuccess => '跨設備簽名設置成功';

  @override
  String get settingsResetEncryptionTitle => '重置加密';

  @override
  String get settingsResetEncryptionWarning =>
      '警告：這將刪除您所有的加密密鑰。您將無法解密之前的加密消息。此操作不可撤銷。';

  @override
  String get settingsReset => '重置';

  @override
  String get settingsBackupSuccess => '密鑰備份成功';

  @override
  String get settingsBackupFailed => '備份失敗';

  @override
  String get settingsRecoveryKey => '恢復密鑰';

  @override
  String get settingsRecoveryKeySaveWarning =>
      '請將此恢復密鑰保存在安全的地方。您需要它在新設備上恢復加密消息。';

  @override
  String get settingsRecoveryKeySaved => '我已保存';

  @override
  String get settingsRestoreSuccess => '密鑰恢復成功';

  @override
  String get settingsRestoreEmpty => '此備份中沒有可恢復的訊息金鑰。';

  @override
  String settingsRestoreSessions(int count) {
    return '已恢復 $count 組訊息金鑰；缺少金鑰的訊息仍可能無法解密。';
  }

  @override
  String get settingsRestoreFailed => '恢復失敗';

  @override
  String get settingsPassword => '密碼';

  @override
  String get settingsEnterRecoveryKey => '輸入恢復密鑰';

  @override
  String get settingsEnterPassword => '輸入密碼';

  @override
  String get settingsExportSuccess => '密鑰已成功導出到服務端備份';

  @override
  String get settingsExportNeedBackupFirst => '請先創建密鑰備份';

  @override
  String get settingsExportFailed => '導出失敗';

  @override
  String get settingsResetSuccess => '加密重置成功';

  @override
  String get settingsResetFailed => '重置失敗';

  @override
  String get callLeaveMeetingConfirm => '確定要離開會議嗎？';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return '拍了拍「$name」$suffix';
  }

  @override
  String get chatNoContactsToAdd => '沒有可添加的聯繫人';

  @override
  String get chatAddMembers => '添加成員';

  @override
  String chatInvitedMembers(int count) {
    return '已邀請 $count 位成員';
  }

  @override
  String chatInviteFailed(String error) {
    return '邀請失敗: $error';
  }

  @override
  String get chatMemberRemoved => '已移除成員';

  @override
  String chatRemoveFailed(String error) {
    return '移除失敗: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage => '開始共享後，對方將能看到你的實時位置，共享時長爲1小時。';

  @override
  String get chatStartSharing => '開始共享';

  @override
  String get chatLocationServiceNotEnabled => '位置服務未開啓';

  @override
  String get chatEnableLocationService => '請開啓位置服務以使用位置功能';

  @override
  String get chatGoToSettings => '去設置';

  @override
  String get chatLocationPermissionRequired => '需要位置權限才能使用此功能';

  @override
  String get chatLocationPermissionDeniedPermanent => '位置權限已被永久拒絕，請在設置中開啓';

  @override
  String get chatLocationPermissionDenied => '位置權限被拒絕';

  @override
  String get chatGettingLocation => '正在獲取位置...';

  @override
  String chatGetLocationFailed(String error) {
    return '獲取位置失敗: $error';
  }

  @override
  String get chatMapPreview => '地圖預覽';

  @override
  String get chatSearchLocation => '搜索地點';

  @override
  String chatRedPacketSent(String amount, String token) {
    return '已發送 $amount $token 紅包';
  }

  @override
  String get chatTransferDefault => '轉賬';

  @override
  String chatTransferSent(String amount, String token) {
    return '已發送 $amount $token 轉賬';
  }

  @override
  String chatPickFileFailed(String error) {
    return '選擇文件失敗: $error';
  }

  @override
  String get chatFileSizeLimit => '文件大小不能超過 50MB';

  @override
  String chatFileSending(String filename) {
    return '文件發送中: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return '發送文件失敗: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return '已發送 $name 的名片';
  }

  @override
  String get chatFavoritesFeature => '收藏';

  @override
  String get chatCouponsFeature => '卡券';

  @override
  String get chatGiftFeature => '禮物';

  @override
  String chatSharedMusic(String name) {
    return '已分享 $name';
  }

  @override
  String get chatEndPollTitle => '結束投票';

  @override
  String get chatEndPollConfirmMessage => '確定要結束這個投票嗎？結束後將無法繼續投票。';

  @override
  String get chatPollEndedMessage => '投票已結束';

  @override
  String get chatConnectingCall => '正在連接...';

  @override
  String get chatMuteCall => '靜音';

  @override
  String get chatSpeakerOff => '關閉免提';

  @override
  String get chatSpeakerOn => '免提';

  @override
  String get chatCameraOn => '開啓攝像頭';

  @override
  String get chatCameraOff => '關閉攝像頭';

  @override
  String get chatHangUp => '掛斷';

  @override
  String get chatSelectForwardTargetTitle => '選擇轉發對象';

  @override
  String get chatNoForwardableChat => '沒有可轉發的會話';

  @override
  String get chatNoMatchingChat => '沒有找到相關會話';

  @override
  String get chatLocationTitle => '位置';

  @override
  String get chatSendButton => '發送';

  @override
  String get chatRetryButton => '重試';

  @override
  String get chatSearchContactHint => '搜索聯繫人';

  @override
  String get chatShareMusic => '分享音樂';

  @override
  String get chatRecentPlayed => '最近播放';

  @override
  String get chatMyFavorites => '我喜歡';

  @override
  String get chatNetworkLink => '網絡鏈接';

  @override
  String get chatLocalFile => '本地文件';

  @override
  String get chatPasteMusicLink => '粘貼音樂鏈接';

  @override
  String get chatShareMusicButton => '分享音樂';

  @override
  String get chatSelectLocalAudio => '選擇本地音頻文件';

  @override
  String get chatSupportedAudioFormats => '支持 MP3、M4A、WAV、FLAC 等格式';

  @override
  String get chatSelectFileButton => '選擇文件';

  @override
  String get chatPleaseEnterMusicLink => '請輸入音樂鏈接';

  @override
  String get chatPleaseEnterValidLink => '請輸入有效的網絡鏈接';

  @override
  String get chatSharedSong => '分享歌曲';

  @override
  String get chatSelectMember => '選擇成員';

  @override
  String get chatSearchMemberHint => '搜索成員';

  @override
  String get chatNoMatchingMembers => '未找到匹配的成員';

  @override
  String get commonUnknownMember => '未知';

  @override
  String chatSelectedMessagesCount(int count) {
    return '已選擇 $count 條消息';
  }

  @override
  String get chatSearchContactsOrGroups => '搜索聯繫人或羣聊';

  @override
  String get chatVideoTitle => '視頻';

  @override
  String get chatLoadingText => '加載中...';

  @override
  String get chatVideoLoadFailed => '視頻加載失敗';

  @override
  String get chatPlayerInitFailed => '播放器初始化失敗';

  @override
  String get chatCreatePollTitle => '創建投票';

  @override
  String get chatSubmitPoll => '發起';

  @override
  String get chatPollQuestionLabel => '投票問題';

  @override
  String get chatEnterPollQuestionHint => '請輸入投票問題';

  @override
  String get chatPollOptionsLabel => '投票選項';

  @override
  String chatOptionHintWithIndex(int index) {
    return '選項 $index';
  }

  @override
  String get chatAddOptionButton => '添加選項';

  @override
  String get chatPollSettingsLabel => '投票設置';

  @override
  String get chatSelectionType => '選擇類型';

  @override
  String get chatSingleChoiceLabel => '單選';

  @override
  String get chatMultiChoiceLabel => '多選';

  @override
  String get chatAnonymousPollSwitch => '匿名投票';

  @override
  String get chatPleaseEnterQuestion => '請輸入投票問題';

  @override
  String get chatAtLeastTwoOptions => '至少需要2個選項';

  @override
  String chatConfirmWithCount(int count) {
    return '確定 ($count)';
  }

  @override
  String get authEmailVerificationTitle => '郵箱驗證';

  @override
  String get authEnterValidEmailAddress => '請輸入有效的郵箱地址';

  @override
  String authVerificationCodeSentTo(String email) {
    return '驗證碼已發送到 $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return '發送驗證碼失敗: $error';
  }

  @override
  String get authVerificationSuccess => '驗證成功';

  @override
  String get authVerificationFailed => '驗證失敗';

  @override
  String authVerificationCodeError(String error) {
    return '驗證碼錯誤: $error';
  }

  @override
  String get commonEnterVerificationCode => '輸入驗證碼';

  @override
  String get authEnterYourEmail => '輸入郵箱';

  @override
  String authWeSentCodeTo(String email) {
    return '我們已向 $email 發送了\n6位驗證碼';
  }

  @override
  String get authEnterEmailForCode => '輸入您的郵箱地址，我們將發送驗證碼';

  @override
  String get commonSendVerificationCode => '發送驗證碼';

  @override
  String get authResendVerificationCode => '重新發送驗證碼';

  @override
  String authCanResendAfter(int seconds) {
    return '$seconds秒後可重新發送';
  }

  @override
  String get commonChangeEmail => '更換郵箱';

  @override
  String get contactAddToContacts => '添加到通訊錄';

  @override
  String get contactAddingToContacts => '添加中...';

  @override
  String get contactAddedToContacts => '已添加到通訊錄';

  @override
  String contactAddFailedWithError(String error) {
    return '添加失敗: $error';
  }

  @override
  String get contactAddPhone => '添加電話';

  @override
  String get contactAddTag => '添加標籤';

  @override
  String get contactAddText => '添加文字';

  @override
  String get contactAddPhoto => '添加照片';

  @override
  String contactGroupCountLabel(int count) {
    return '$count個';
  }

  @override
  String get contactAddedViaSearch => '通過搜索添加';

  @override
  String get contactAddTime => '添加時間';

  @override
  String get contactDoneButton => '完成';

  @override
  String get callWaitingForParticipants => '等待參與者加入...';

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
  String get callMuteLabel => '靜音';

  @override
  String get callUnmuteLabel => '解除靜音';

  @override
  String get callTurnOffVideo => '關閉視頻';

  @override
  String get callTurnOnVideo => '開啓視頻';

  @override
  String get callShareScreen => '共享屏幕';

  @override
  String get callStopSharing => '停止共享';

  @override
  String get callSwitchCameraLabel => '切換';

  @override
  String get callLeaveLabel => '離開';

  @override
  String get callParticipantsLabel => '參與者';

  @override
  String get callJoiningMeeting => '正在加入會議...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count 票 ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count 人蔘與';
  }

  @override
  String get chatNoMediaUrlAvailable => '沒有可用的媒體鏈接';

  @override
  String chatDownloadFailed(String code) {
    return '下載失敗: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return '錯誤: $message';
  }

  @override
  String get chatMusicLinkLabel => '音樂鏈接';

  @override
  String get chatRedPacketTransferCannotForward => '紅包和轉賬消息無法轉發';

  @override
  String commonShareFailed(String error) {
    return '分享失敗: $error';
  }

  @override
  String get commonTapToRetry => '點擊重試';

  @override
  String get chatDefaultRedPacketGreeting => '恭喜發財，大吉大利';

  @override
  String get groupAllowOthersToSearchAndJoin => '允許他人搜索並加入';

  @override
  String get groupConfirmClearChatHistory => '確定要清空聊天記錄嗎？';

  @override
  String get groupCreateGroupToChat => '創建羣聊以開始聊天';

  @override
  String get groupEditGroupAnnouncement => '編輯羣公告';

  @override
  String get groupEditGroupDescription => '編輯羣描述';

  @override
  String get groupEnterGroupAnnouncement => '請輸入羣公告';

  @override
  String groupMemberCountClickToCopy(Object count) {
    return '$count人，點擊複製羣ID';
  }

  @override
  String get groupNoPermissionToEditGroupName => '你沒有權限修改羣名稱';

  @override
  String get authEmailAddress => '郵箱地址';

  @override
  String get commonEnterEmailAddress => '請輸入郵箱地址';

  @override
  String get authEmailRecoveryHint => '用於找回密碼';

  @override
  String get commonInvalidEmailFormat => '請輸入有效的郵箱地址';

  @override
  String get authOptional => '選填';

  @override
  String get authResetPassword => '重置密碼';

  @override
  String get authEnterRegisteredEmail => '請輸入註冊時綁定的郵箱地址';

  @override
  String get authSendResetCode => '發送重置驗證碼';

  @override
  String authResetCodeSent(String email) {
    return '重置驗證碼已發送至 $email';
  }

  @override
  String get authEnterResetCode => '輸入重置驗證碼';

  @override
  String get authSetNewPassword => '設置新密碼';

  @override
  String get commonConfirmNewPassword => '確認新密碼';

  @override
  String get commonNewPassword => '新密碼';

  @override
  String get authPasswordResetSuccess => '密碼重置成功，請使用新密碼登錄';

  @override
  String get authResetPasswordFailed => '重置密碼失敗';

  @override
  String get settingsChangePassword => '修改密碼';

  @override
  String get settingsCurrentPassword => '當前密碼';

  @override
  String get settingsEnterCurrentPassword => '請輸入當前密碼';

  @override
  String get settingsEnterNewPassword => '請輸入新密碼';

  @override
  String get settingsPasswordChanged => '密碼修改成功，請使用新密碼重新登錄';

  @override
  String get settingsChangePasswordFailed => '修改密碼失敗';

  @override
  String get settingsNewPasswordMustBeDifferent => '新密碼不能與當前密碼相同';

  @override
  String get settingsChangePasswordInfo => '修改密碼後，您將被登出，需要使用新密碼重新登錄。';

  @override
  String get settingsPasswordRequirements => '密碼要求：';

  @override
  String get settingsSecurityNote => '爲了安全，修改密碼後需要在所有設備上重新登錄。';

  @override
  String get settingsSecurity => '安全';

  @override
  String get settingsCurrentBoundEmail => '當前綁定郵箱';

  @override
  String get settingsNewEmailAddress => '新郵箱地址';

  @override
  String get settingsEnterNewEmail => '請輸入新郵箱地址';

  @override
  String get settingsVerificationCode => '驗證碼';

  @override
  String get settingsVerificationCodeSent => '驗證碼已發送';

  @override
  String get settingsCodeSentTo => '驗證碼已發送至';

  @override
  String get settingsDidNotReceiveCode => '沒有收到驗證碼？';

  @override
  String get settingsEmailChangedSuccess => '郵箱修改成功';

  @override
  String get settingsChangeEmailFailed => '修改郵箱失敗';

  @override
  String get settingsEmailSecurityNote => '郵箱用於密碼找回，請確保安全。';

  @override
  String get commonGoogleLogin => '使用 Google 登錄';

  @override
  String get commonAppleLogin => '使用 Apple 登錄';

  @override
  String get commonWechat => '微信';

  @override
  String get settingsLanguage => '語言';

  @override
  String get settingsLanguageChanged => '語言已更改';

  @override
  String get settingsTranslation => '翻譯';

  @override
  String get settingsTranslateTextTo => '將文字翻譯爲';

  @override
  String get settingsTranslateDescription => '選擇你希望將消息翻譯成的語言。';

  @override
  String get settingsAutoTranslate => '自動翻譯聊天中收到的消息';

  @override
  String get settingsAutoTranslateDescription => '自動將聊天中收到的消息翻譯爲你選擇的語言。';

  @override
  String get settingsBiometricLogin => '生物識別登錄';

  @override
  String authLoginWithBiometric(Object type) {
    return '使用$type登錄';
  }

  @override
  String get settingsBiometricLoginEnabled => '生物識別登錄已啓用';

  @override
  String get settingsBiometricLoginDisabled => '生物識別登錄已禁用';

  @override
  String get settingsEnableBiometricLogin => '啓用生物識別登錄';

  @override
  String get settingsBiometricEnabled => '已啓用 - 使用生物識別登錄';

  @override
  String get settingsBiometricDisabled => '已禁用 - 點擊啓用';

  @override
  String get settingsBiometricNeedRelogin => '請退出後重新登錄以啓用生物識別';

  @override
  String get authOr => '或';

  @override
  String get qrcodeCameraPermissionRestricted => '此設備上的相機訪問受限';

  @override
  String get authPasskeyLabel => '通行金鑰';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'Apple';

  @override
  String get authSsoLabel => '單一登入';

  @override
  String get authSsoNotConfigured => '該服務器未配置SSO登錄提供商';

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
  String get profileEnterPokeSuffixHint => '輸入戳一戳後綴，例如：的肩膀';

  @override
  String get groupAlbum => '羣相冊';

  @override
  String get groupFiles => '羣文件';

  @override
  String get groupImages => '圖片';

  @override
  String get groupVideos => '視頻';

  @override
  String get groupTotal => '全部';

  @override
  String get groupSize => '大小';

  @override
  String get groupNoMedia => '暫無媒體';

  @override
  String get groupNoMediaDescription => '此羣還沒有圖片或視頻';

  @override
  String get groupDocuments => '文檔';

  @override
  String get groupNoFiles => '暫無文件';

  @override
  String get groupNoFilesDescription => '此羣還沒有文件';

  @override
  String groupDownloadStarted(String filename) {
    return '正在下載 $filename...';
  }

  @override
  String get contactNoCommonGroups => '暫無共同羣組';

  @override
  String get contactNoCommonGroupsDescription => '你們沒有共同加入的羣組';

  @override
  String get chatVoiceMessage => '語音';

  @override
  String get chatMessage => '消息';

  @override
  String get conversationHideChat => '隱藏';

  @override
  String get settingsQuickReply => '快捷回覆';

  @override
  String get commonTranslate => '翻譯';

  @override
  String get contactCreateTag => '新建標籤';

  @override
  String get contactEnterTagName => '輸入標籤名稱';

  @override
  String get contactEditTag => '編輯標籤';

  @override
  String get contactDeleteTag => '刪除標籤';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return '確定要刪除標籤 \"$tagName\" 嗎？';
  }

  @override
  String get contactNoTags => '暫無標籤';

  @override
  String get contactFriendPermissions => '朋友權限';

  @override
  String get contactSetChatOnly => '設爲僅聊天';

  @override
  String get contactChatOnlyDesc => '只能聊天，其他內容將被隱藏';

  @override
  String get contactHideMyMoments => '不讓他（她）看我的朋友圈';

  @override
  String get contactHideMyMomentsDesc => '該好友無法查看你的朋友圈動態';

  @override
  String get contactHideTheirMoments => '不看他（她）的朋友圈';

  @override
  String get contactHideTheirMomentsDesc => '不會看到該好友的朋友圈動態';

  @override
  String get contactHideMyStatus => '不讓他（她）看我的狀態';

  @override
  String get contactHideMyStatusDesc => '該好友無法查看你的狀態更新';

  @override
  String get contactNoChatOnlyFriends => '暫無僅聊天的朋友';

  @override
  String get contactNoOfficialAccounts => '暫無公衆號';

  @override
  String get contactFollowOfficialAccountsDesc => '關注公衆號，獲取最新資訊';

  @override
  String get contactNoServiceAccounts => '暫無服務號';

  @override
  String get contactSubscribeServiceAccountsDesc => '訂閱服務號，享受便捷服務';

  @override
  String get contactNoEnterpriseContacts => '暫無企業聯繫人';

  @override
  String get contactEnterpriseContactsDesc => '企業通訊錄聯繫人將顯示在這裏';

  @override
  String get profileCardPack => '卡包';

  @override
  String get profileOrders => '訂單';

  @override
  String get profileNoOrders => '暫無訂單';

  @override
  String get profileOrdersDesc => '你的訂單將顯示在這裏';

  @override
  String get profileNoCards => '暫無卡券';

  @override
  String get profileCardsDesc => '你的卡券將顯示在這裏';

  @override
  String get favoriteEnterTagsHint => '輸入標籤，用逗號分隔';

  @override
  String get favoriteTagsUpdated => '標籤已更新';

  @override
  String get favoriteForwardedContent => '內容已轉發';

  @override
  String get favoriteEnterNoteContent => '輸入筆記內容';

  @override
  String get favoriteNoteAdded => '筆記已添加';

  @override
  String get favoriteLinkTitle => '鏈接標題';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => '鏈接已添加';

  @override
  String get contactPhotoAdded => '照片已添加';

  @override
  String get contactEnterPhone => '輸入手機號碼';

  @override
  String commonConversationWithId(Object roomId) {
    return '會話: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return '聯繫人: $userId';
  }

  @override
  String get commonDiscover => '發現';

  @override
  String commonDeveloping(Object title) {
    return '$title\n(開發中)';
  }

  @override
  String get commonPageNotFound => '頁面不存在';

  @override
  String get commonBackToHome => '返回首頁';

  @override
  String get settingsMessageNotifications => '消息通知';

  @override
  String get settingsReceiveNewMessageNotifications => '接收新消息通知';

  @override
  String get settingsShowMessagePreview => '顯示消息預覽';

  @override
  String get settingsShowMessageContentInNotification => '在通知中顯示消息內容';

  @override
  String get settingsNotificationSound => '通知聲音';

  @override
  String get settingsPlaySoundOnMessage => '收到消息時播放聲音';

  @override
  String get commonVibration => '振動';

  @override
  String get settingsVibrateOnMessage => '收到消息時震動';

  @override
  String get settingsDoNotDisturbMode => '勿擾模式';

  @override
  String get settingsDoNotDisturbDescription => '在指定時間內不接收通知';

  @override
  String get settingsStartTime => '開始時間';

  @override
  String get settingsEndTime => '結束時間';

  @override
  String get settingsDeleteQuickReply => '刪除快捷回覆';

  @override
  String get settingsEditQuickReply => '編輯快捷回覆';

  @override
  String get settingsAddQuickReply => '添加快捷回覆';

  @override
  String get settingsManageQuickReplies => '管理快捷回覆';

  @override
  String get settingsNoQuickReplies => '暫無快捷回覆';

  @override
  String get settingsDefaultQuickReplies => '將顯示默認快捷回覆';

  @override
  String get settingsWhoCanSee => '誰可以查看';

  @override
  String get settingsLastSeen => '最後上線時間';

  @override
  String get settingsHiddenChats => '隱藏的聊天';

  @override
  String get settingsMessagesLabel => '消息';

  @override
  String get settingsAllowStrangerMessages => '允許陌生人消息';

  @override
  String get settingsReceiveMessagesFromNonContacts => '接收非聯繫人的消息';

  @override
  String get settingsReadReceipts => '已讀回執';

  @override
  String get settingsLetOthersKnowYouRead => '讓對方知道你已讀';

  @override
  String get settingsTypingIndicator => '輸入狀態指示';

  @override
  String get settingsLetOthersKnowYouTyping => '讓對方知道你正在輸入';

  @override
  String get settingsEveryone => '所有人';

  @override
  String get settingsContactsOnly => '僅聯繫人';

  @override
  String get settingsNobody => '無人';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return '誰可以看到 $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return '版本 $version';
  }

  @override
  String get settingsCheckForUpdates => '檢查更新';

  @override
  String get settingsOpenSourceLicenses => '開源許可';

  @override
  String get settingsFeedbackAndSuggestions => '反饋與建議';

  @override
  String get settingsBuiltOnMatrix => '基於 Matrix 協議構建';

  @override
  String get settingsNoHiddenChats => '沒有隱藏的聊天';

  @override
  String get settingsNoHiddenChatsDescription => '你隱藏的聊天會顯示在這裏';

  @override
  String get settingsUnhideChat => '取消隱藏';

  @override
  String get settingsDarkMode => '深色模式';

  @override
  String get settingsFontSize => '字體大小';

  @override
  String get settingsBubbleStyle => '氣泡樣式';

  @override
  String get settingsFollowSystem => '跟隨系統';

  @override
  String get settingsAutoSwitchBySystem => '跟隨系統自動切換';

  @override
  String get settingsLightMode => '淺色模式';

  @override
  String get settingsAlwaysUseLightTheme => '始終使用淺色主題';

  @override
  String get settingsDarkModeOption => '深色模式選項';

  @override
  String get settingsAlwaysUseDarkTheme => '始終使用深色主題';

  @override
  String get settingsFontSizeSmall => '小';

  @override
  String get settingsFontSizeStandard => '標準';

  @override
  String get settingsFontSizeLarge => '大';

  @override
  String get settingsFontSizeExtraLarge => '特大';

  @override
  String get settingsBubbleStyleWechat => '微信樣式';

  @override
  String get settingsBubbleStyleWechatDesc => '經典微信氣泡樣式';

  @override
  String get settingsBubbleStyleModern => '現代樣式';

  @override
  String get settingsBubbleStyleModernDesc => '簡潔的現代氣泡樣式';

  @override
  String get settingsBubbleStyleClassic => '經典樣式';

  @override
  String get settingsBubbleStyleClassicDesc => '傳統的氣泡樣式';

  @override
  String get discoverVideoChannels => '視頻號';

  @override
  String get discoverLive => '直播';

  @override
  String get discoverListen => '聽一聽';

  @override
  String get discoverWatch => '看一看';

  @override
  String get discoverSearchDiscover => '搜一搜';

  @override
  String get discoverNearbyPeople => '附近的人';

  @override
  String get discoverGames => '遊戲';

  @override
  String get discoverMiniPrograms => '小程序';

  @override
  String get chatAlreadyInCall => '當前正在通話中';

  @override
  String get commonConnectionFailed => '連接失敗';

  @override
  String get chatCallRejected => '對方已拒絕';

  @override
  String get chatNoAnswer => '對方無應答';

  @override
  String get commonClose => '關閉';

  @override
  String get chatSelectContact => '選擇聯繫人';

  @override
  String get chatVoteRemoved => '已取消投票';

  @override
  String get chatVoteChanged => '投票已更改';

  @override
  String get chatVoted => '已投票';

  @override
  String chatReplyTo(String name) {
    return '回覆 $name';
  }

  @override
  String get chatCurrentLocation => '當前位置';

  @override
  String chatNearbyPlace(int index) {
    return '附近地點 $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return '約 $distance';
  }

  @override
  String get chatAddress => '地址';

  @override
  String get chatLatitude => '緯度';

  @override
  String get chatLongitude => '經度';

  @override
  String get groupDescriptionUpdated => '羣簡介已更新';

  @override
  String get groupAvatarUpdated => '羣頭像已更新';

  @override
  String get groupVisibilityUpdated => '羣可見性已更新';

  @override
  String get groupChannelCreated => '頻道已創建';

  @override
  String get groupChannelUpdated => '頻道已更新';

  @override
  String get groupChannelDeleted => '頻道已刪除';

  @override
  String get callDecline => '拒絕';

  @override
  String get callAnswer => '接聽';

  @override
  String get callIncomingVideoCall => '視頻來電';

  @override
  String get callIncomingVoiceCall => '語音來電';

  @override
  String get callVideoCallInProgress => '視頻通話中';

  @override
  String get callVoiceCallInProgress => '語音通話中';

  @override
  String get callReconnectingCall => '正在重連...';

  @override
  String get callEnded => '通話已結束';

  @override
  String get callFailed => '通話失敗';

  @override
  String get callLivekitNotConfigured => 'LiveKit 未配置';

  @override
  String callJoinMeetingFailed(Object error) {
    return '加入會議失敗: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return '屏幕共享失敗: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42豆';

  @override
  String get profileNoN42Bean => '暫無N42豆';

  @override
  String get profileN42BeanDetails => 'N42豆明細';

  @override
  String get profileN42BeanDescription => 'N42豆是用於兌換N42內虛擬物品和服務的道具，目前可用於兌換：';

  @override
  String get profileN42BeanFeature1 => '會員專屬表情和主題';

  @override
  String get profileN42BeanFeature2 => '聊天氣泡個性化';

  @override
  String get profileN42BeanFeature3 => '紅包封面定製';

  @override
  String get profileN42BeanFeature4 => '專屬暱稱標識';

  @override
  String get profileN42BeanFeature5 => '羣聊特權功能';

  @override
  String get profileN42BeanFeature6 => '雲存儲空間擴展';

  @override
  String get profileN42BeanFeature7 => '視頻通話美顏濾鏡';

  @override
  String get profileN42BeanFeature8 => '朋友圈背景更換';

  @override
  String get profileN42BeanFeature9 => 'VIP客服優先服務';

  @override
  String get profileGotIt => '我知道了';

  @override
  String get profileNoN42BeanRecords => '暫無N42豆明細記錄';

  @override
  String get profileMoodAndThoughts => '心情想法';

  @override
  String get profileStatusHappy => '開心';

  @override
  String get profileStatusCracked => '裂開';

  @override
  String get profileStatusLucky => '發呆';

  @override
  String get profileStatusSunny => '天氣晴';

  @override
  String get profileStatusTired => '累了';

  @override
  String get profileStatusDaydream => '發呆中';

  @override
  String get profileStatusRushing => '忙碌';

  @override
  String get profileStatusOverthinking => '想太多';

  @override
  String get profileStatusEnergized => '元氣滿滿';

  @override
  String get profileWorkAndStudy => '工作學習';

  @override
  String get profileStatusWorking => '搬磚中';

  @override
  String get profileStatusStudying => '學習中';

  @override
  String get profileStatusBusy => '忙';

  @override
  String get profileStatusSlacking => '摸魚中';

  @override
  String get profileStatusTraveling => '旅行中';

  @override
  String get profileStatusGoingHome => '回家中';

  @override
  String get profileStatusDnd => '請勿打擾';

  @override
  String get profileActivities => '活動';

  @override
  String get profileStatusHanging => '出去浪';

  @override
  String get profileStatusCheckIn => '打卡';

  @override
  String get profileStatusExercising => '運動中';

  @override
  String get profileStatusCoffee => '喝咖啡';

  @override
  String get profileStatusBubbleTea => '奶茶';

  @override
  String get profileStatusEating => '乾飯中';

  @override
  String get profileStatusParenting => '帶娃中';

  @override
  String get profileStatusSavingWorld => '拯救世界';

  @override
  String get profileStatusSelfie => '自拍';

  @override
  String get profileRest => '休息';

  @override
  String get profileStatusRetreat => '閉關';

  @override
  String get profileStatusHome => '宅家';

  @override
  String get profileStatusSleeping => '睡覺中';

  @override
  String get profileStatusCatLover => '吸貓中';

  @override
  String get profileStatusDogWalking => '遛狗中';

  @override
  String get profileStatusGaming => '遊戲中';

  @override
  String get profileStatusListening => '聽歌中';

  @override
  String get profileEditAddress => '編輯地址';

  @override
  String get profileRecipient => '收貨人';

  @override
  String get profileEnterRecipientName => '請輸入收貨人姓名';

  @override
  String get profilePhoneNumber => '手機號碼';

  @override
  String get profileEnterPhoneNumber => '請輸入手機號碼';

  @override
  String get profileRegionHint => '省/市/區';

  @override
  String get profileDetailedAddress => '詳細地址';

  @override
  String get profileDetailedAddressHint => '街道、門牌號等';

  @override
  String get profileSetAsDefaultAddress => '設爲默認地址';

  @override
  String get profilePleaseCompleteInfo => '請填寫完整信息';

  @override
  String get profileEditInvoice => '編輯發票抬頭';

  @override
  String get profileInvoiceType => '抬頭類型';

  @override
  String get profileCompanyName => '企業名稱';

  @override
  String get profilePersonalName => '個人姓名';

  @override
  String get profileEnterCompanyName => '請輸入企業名稱';

  @override
  String get profileEnterName => '請輸入姓名';

  @override
  String get profileTaxIdNumber => '納稅人識別號';

  @override
  String get profileEnterTaxIdNumber => '請輸入納稅人識別號';

  @override
  String get profileBankNameOptional => '開戶銀行（選填）';

  @override
  String get profileEnterBankName => '請輸入開戶銀行';

  @override
  String get profileBankAccountOptional => '銀行賬號（選填）';

  @override
  String get profileEnterBankAccount => '請輸入銀行賬號';

  @override
  String get profileCompanyAddressOptional => '企業地址（選填）';

  @override
  String get profileEnterCompanyAddress => '請輸入企業地址';

  @override
  String get profileCompanyPhoneOptional => '企業電話（選填）';

  @override
  String get profileEnterCompanyPhone => '請輸入企業電話';

  @override
  String get profileSetAsDefaultInvoice => '設爲默認抬頭';

  @override
  String get profileRingtoneVibrate => '震動';

  @override
  String get profileRingtoneSilent => '靜音';

  @override
  String get profileVibrateMode => '振動模式';

  @override
  String get profileSilentMode => '靜音模式';

  @override
  String profilePlayFailed(Object ringtoneName) {
    return '播放失敗: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
    return '正在播放: $ringtoneName';
  }

  @override
  String get profileStop => '停止';

  @override
  String get profileSelectRingtone => '選擇鈴聲';

  @override
  String get profileLoadingRingtones => '加載鈴聲中...';

  @override
  String get profileNoRingtonesFound => '未找到鈴聲';

  @override
  String mainMessagesWithCount(int count) {
    return '消息($count)';
  }

  @override
  String get storyViewers => '瀏覽者';

  @override
  String get storyNoViewers => '暫無瀏覽';

  @override
  String get storyReplyToStory => '回覆狀態...';

  @override
  String get commonCopiedToClipboard => '已複製到剪貼板';

  @override
  String get commonMore => '更多';

  @override
  String get commonTranslating => '翻譯中...';

  @override
  String commonTranslatedFrom(String language) {
    return '翻譯自$language';
  }

  @override
  String get commonTranslation => '翻譯';

  @override
  String get commonTranslationFailed => '翻譯失敗';

  @override
  String get commonAllRead => '全部已讀';

  @override
  String commonReadCount(Object count) {
    return '$count人已讀';
  }

  @override
  String get commonYouRecalledMessage => '你撤回了一條消息';

  @override
  String get commonMessageRecalled => '對方撤回了一條消息';

  @override
  String get commonReEdit => '重新編輯';

  @override
  String get commonWalletArea => '錢包功能區域';

  @override
  String get callIncomingCall => '來電';

  @override
  String get callMissedCall => '未接來電';

  @override
  String get groupRemoveAdmin => '取消管理員';

  @override
  String get chatSelectCurrency => '選擇幣種';

  @override
  String get chatSelectEmoji => '選擇表情';

  @override
  String get chatSelectRedPacketCover => '選擇封面';

  @override
  String get groupSetAsAdmin => '設爲管理員';

  @override
  String get chatVideoPlaybackFailed => '視頻播放失敗';

  @override
  String get groupViewProfile => '查看資料';

  @override
  String get favoriteAddLinkComingSoon => '添加鏈接功能即將推出';

  @override
  String get favoriteNewNoteComingSoon => '新建筆記功能即將推出';

  @override
  String get qrcodeSaveFeatureComingSoon => '保存功能即將推出';

  @override
  String get qrcodeShareFeatureComingSoon => '分享功能即將推出';

  @override
  String qrcodeProcessFailed(String error) {
    return '處理二維碼失敗: $error';
  }

  @override
  String get securityDeviceIdRequired => '需要設備 ID';

  @override
  String securityVerificationStartFailed(String error) {
    return '啓動驗證失敗: $error';
  }

  @override
  String get securityVerificationFailed => '驗證失敗';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return '驗證失敗: $reason';
  }

  @override
  String get securityEmojiMismatchRejected => '驗證被拒絕 - 表情不匹配';

  @override
  String get securityWaitingForDeviceAccept => '等待另一臺設備接受...';

  @override
  String get securityVerifyDevice => '驗證此設備';

  @override
  String get securityConfirmEmojiMatch => '確認以下表情符號在兩臺設備上以相同順序顯示';

  @override
  String get securityEmojiDontMatch => '不匹配';

  @override
  String get securityEmojiMatch => '匹配';

  @override
  String get securityWaitingForDeviceConfirm => '等待另一臺設備確認...';

  @override
  String get securityVerificationSuccess => '驗證成功！';

  @override
  String get securityDeviceVerifiedTrusted => '此設備已驗證並可信任。';

  @override
  String get securityCompareEmoji => '比較兩臺設備上的表情符號';

  @override
  String get securityCompareNumbers => '比較兩臺設備上的數字';

  @override
  String get commonTryAgain => '重試';

  @override
  String get commonDone => '完成';

  @override
  String get chatExportTitle => '導出聊天記錄';

  @override
  String get chatExportSuccess => '導出成功';

  @override
  String chatExportFailed(String error) {
    return '導出失敗: $error';
  }

  @override
  String get chatExportFormat => '導出格式';

  @override
  String get chatExportHtmlDesc => '可在任何瀏覽器中打開的精美排版';

  @override
  String get chatExportJsonDesc => '機器可讀的結構化數據格式';

  @override
  String get chatExportDateRange => '日期範圍';

  @override
  String get chatExportAll => '全部消息';

  @override
  String get chatExportLastWeek => '最近7天';

  @override
  String get chatExportLastMonth => '最近一個月';

  @override
  String get chatExportLast3Months => '最近三個月';

  @override
  String get chatExportMessageCount => '待導出消息';

  @override
  String get chatExportButton => '導出並分享';

  @override
  String get chatMediaGallery => '媒體文件';

  @override
  String get chatExportHistory => '導出聊天記錄';

  @override
  String get pdfLoadFailed => '加載 PDF 失敗';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => '全部';

  @override
  String get mediaImages => '圖片';

  @override
  String get mediaVideos => '視頻';

  @override
  String get mediaFiles => '文件';

  @override
  String get mediaAudio => '音頻';

  @override
  String mediaItemsCount(int count) {
    return '$count 項';
  }

  @override
  String get mediaNoMediaFound => '暫無媒體文件';

  @override
  String get spacesTitle => '社區';

  @override
  String get spacesCreate => '創建社區';

  @override
  String get spacesJoined => '已加入';

  @override
  String get spacesDiscover => '發現';

  @override
  String get spacesNoJoined => '還沒有加入任何社區';

  @override
  String get spacesExplore => '探索社區';

  @override
  String get spacesNoPublic => '沒有找到公共社區';

  @override
  String get spacesJoin => '加入';

  @override
  String get spacesSubSpaces => '子社區';

  @override
  String get spacesChannels => '頻道';

  @override
  String spacesMembersCount(int count) {
    return '$count 位成員';
  }

  @override
  String get spacesPublic => '公開';

  @override
  String get spacesPrivate => '私密';

  @override
  String get spacesSuggested => '推薦';

  @override
  String spacesChannelsCount(int count) {
    return '$count 個頻道';
  }

  @override
  String get callInCallChat => '通話中聊天';

  @override
  String callMessagesCount(int count) {
    return '$count 條消息';
  }

  @override
  String get callNoMessagesYet => '暫無消息\n發送一條消息開始聊天';

  @override
  String get callTypeMessage => '輸入消息...';

  @override
  String get callYouSender => '我';

  @override
  String get callChatLabel => '聊天';

  @override
  String get chatEdited => '已編輯';

  @override
  String get chatEditHistory => '編輯歷史';

  @override
  String get chatOriginalMessage => '原始消息';

  @override
  String chatEditedAt(String time) {
    return '編輯於 $time';
  }

  @override
  String get chatViewOnce => '閱後即焚';

  @override
  String get chatViewOncePhoto => '閱後即焚照片';

  @override
  String get chatViewOnceVideo => '閱後即焚視頻';

  @override
  String get chatViewOnceViewed => '已查看';

  @override
  String get chatViewOnceExpired => '已過期';

  @override
  String get chatViewOnceTap => '點擊查看';

  @override
  String get chatAutoFaceBlur => '傳送照片模糊人臉';

  @override
  String get chatAutoFaceBlurDesc => '發送照片時自動模糊人臉';

  @override
  String get threadReplyInThread => '在線程中回覆';

  @override
  String threadReplies(int count) {
    return '$count 條回覆';
  }

  @override
  String get threadReply => '1 條回覆';

  @override
  String threadLatestReply(String preview) {
    return '最新: $preview';
  }

  @override
  String get threadTitle => '消息線程';

  @override
  String get threadReplyPlaceholder => '在線程中回覆...';

  @override
  String threadParticipants(int count) {
    return '$count 位參與者';
  }

  @override
  String get voiceRoomTitle => '語音聊天室';

  @override
  String get voiceRoomCreate => '創建語音房間';

  @override
  String get voiceRoomJoin => '加入';

  @override
  String get voiceRoomLeave => '離開';

  @override
  String get voiceRoomEnd => '結束房間';

  @override
  String get voiceRoomRaiseHand => '舉手';

  @override
  String get voiceRoomLowerHand => '放下手';

  @override
  String get voiceRoomMute => '靜音';

  @override
  String get voiceRoomUnmute => '取消靜音';

  @override
  String get voiceRoomHost => '主持人';

  @override
  String get voiceRoomSpeakers => '發言者';

  @override
  String get voiceRoomListeners => '聽衆';

  @override
  String get voiceRoomLive => '直播中';

  @override
  String get voiceRoomEnded => '已結束';

  @override
  String get voiceRoomScheduled => '已預約';

  @override
  String get voiceRoomApprove => '批准發言';

  @override
  String get voiceRoomDemote => '移至聽衆';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name 舉手了';
  }

  @override
  String get voiceRoomName => '房間名稱';

  @override
  String get voiceRoomTopic => '話題（可選）';

  @override
  String get voiceRoomNoActive => '暫無活躍的語音房間';

  @override
  String get voiceRoomConnecting => '連接中...';

  @override
  String get usernameTitle => '用戶名';

  @override
  String get usernameSet => '設置用戶名';

  @override
  String get usernameChange => '修改用戶名';

  @override
  String get usernamePlaceholder => '輸入用戶名';

  @override
  String get usernameAvailable => '用戶名可用';

  @override
  String get usernameUnavailable => '用戶名已被佔用';

  @override
  String get usernameInvalid => '3-30個字符，小寫字母、數字、下劃線，必須以字母開頭';

  @override
  String get usernameReserved => '此用戶名爲保留名稱';

  @override
  String get usernameSaved => '用戶名已保存';

  @override
  String get usernameSearchHint => '通過 @用戶名 搜索';

  @override
  String get ensName => 'ENS 域名';

  @override
  String get ensLinked => '已關聯 ENS';

  @override
  String get ensResolving => '正在解析 ENS...';

  @override
  String get ensNotFound => '未找到 ENS 域名';

  @override
  String get tokenGateTitle => '代幣門控';

  @override
  String get tokenGateEnable => '啓用代幣門控';

  @override
  String get tokenGateDisable => '禁用代幣門控';

  @override
  String get tokenGateAddRule => '添加規則';

  @override
  String get tokenGateRemoveRule => '刪除規則';

  @override
  String get tokenGateContractAddress => '合約地址';

  @override
  String get tokenGateMinBalance => '最低餘額';

  @override
  String get tokenGateTokenId => '代幣 ID（ERC-1155）';

  @override
  String get tokenGateChainId => '鏈 ID';

  @override
  String get tokenGateVerifying => '正在驗證代幣持有...';

  @override
  String get tokenGateVerified => '驗證通過';

  @override
  String get tokenGateDenied => '您未滿足代幣要求';

  @override
  String get tokenGateOperatorAnd => '需滿足所有規則';

  @override
  String get tokenGateOperatorOr => '滿足任一規則即可';

  @override
  String get tokenGateRuleErc20 => 'ERC-20 代幣';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => '多代幣 (ERC-1155)';

  @override
  String get tokenGateRuleNative => '原生代幣';

  @override
  String get tokenGateSaved => '代幣門控已保存';

  @override
  String get tokenGateEnableDescription => '要求成員持有指定代幣才能加入';

  @override
  String get tokenGateOperator => '規則邏輯';

  @override
  String get tokenGateRules => '規則列表';

  @override
  String get tokenGateSymbol => '代幣符號（可選）';

  @override
  String get tokenGateChain => '區塊鏈';

  @override
  String get tokenGateTokenStandard => '代幣標準';

  @override
  String get tokenGateDenialMessage => '拒絕消息';

  @override
  String get tokenGateDenialMessageHint => '驗證失敗時顯示的消息';

  @override
  String get tokenGateVerifyTitle => '代幣驗證';

  @override
  String get tokenGateVerifyPassed => '驗證通過';

  @override
  String get tokenGateVerifyFailed => '驗證未通過';

  @override
  String get tokenGateRetryVerify => '重新驗證';

  @override
  String get tokenGateRequired => '要求';

  @override
  String get tokenGateYourBalance => '你的餘額';

  @override
  String get tokenGateRulesActive => '條規則生效';

  @override
  String get tokenGateDisabled => '未啓用';

  @override
  String get ensNotBound => '未綁定';

  @override
  String get liveLocation => '實時位置';

  @override
  String get stopLiveLocation => '停止共享';

  @override
  String get startLiveLocation => '開始共享';

  @override
  String get selectDuration => '選擇共享時長';

  @override
  String get groupChatFiles => '聊天文件';

  @override
  String get groupLinks => '鏈接';

  @override
  String get groupNoLinks => '暫無鏈接';

  @override
  String get chatBackground => '聊天背景';

  @override
  String get solidColors => '純色';

  @override
  String get gradients => '漸變';

  @override
  String get defaultBackground => '默認';

  @override
  String get settingsFontSizeSlider => '字體大小';

  @override
  String get autoDownload => '自動下載';

  @override
  String get images => '圖片';

  @override
  String get voice => '語音';

  @override
  String get video => '視頻';

  @override
  String get files => '文件';

  @override
  String get mobileData => '移動數據';

  @override
  String get roaming => '漫遊';

  @override
  String get storageManagement => '存儲管理';

  @override
  String get totalUsage => '總用量';

  @override
  String get cache => '緩存';

  @override
  String get other => '其他';

  @override
  String get clearCache => '清理緩存';

  @override
  String get cacheCleared => '緩存已清除';

  @override
  String get clearCacheFailed => '清理緩存失敗';

  @override
  String get confirmClearCache => '確認清理所有緩存數據？';

  @override
  String get mapView => '地圖視圖';

  @override
  String liveLocationSharingCount(int count) {
    return '$count 人正在共享位置';
  }

  @override
  String get minutes15 => '15 分鐘';

  @override
  String get minutes30 => '30 分鐘';

  @override
  String get hour1 => '1 小時';

  @override
  String get hours8 => '8 小時';

  @override
  String get personalCard => '個人名片';

  @override
  String get downloadFailed => '下載失敗';

  @override
  String get locationExpired => '已過期';

  @override
  String secondsRemaining(int count) {
    return '$count秒';
  }

  @override
  String minutesRemaining(int count) {
    return '$count分鐘';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '$hours小時$minutes分鐘';
  }

  @override
  String get favoriteMessages => '收藏消息';

  @override
  String get linksCopied => '鏈接已複製';

  @override
  String get noLinksFound => '未找到鏈接';

  @override
  String get roomStorageRanking => '房間存儲排行';

  @override
  String get downloadComplete => '下載完成';

  @override
  String get downloading => '下載中...';

  @override
  String get draftSaved => '草稿已保存';

  @override
  String get voiceRecording => '語音錄製';

  @override
  String get searchLocation => '搜索地點';

  @override
  String get tapToSearch => '點擊搜索';

  @override
  String get settingsThisDevice => '本設備';

  @override
  String get settingsJustNow => '剛剛';

  @override
  String get settingsDeviceId => '設備 ID';

  @override
  String get settingsStatus => '狀態';

  @override
  String get settingsLastActive => '最後活躍';

  @override
  String get settingsIpAddress => 'IP 地址';

  @override
  String get settingsRenameDevice => '重命名設備';

  @override
  String get settingsDeviceNameHint => '輸入設備名稱';

  @override
  String get settingsDeviceRenamed => '設備已重命名';

  @override
  String get settingsRenameFailed => '重命名失敗';

  @override
  String get settingsRemoteLogout => '遠程登出';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return '確定要登出「$deviceName」嗎？此操作無法撤銷。';
  }

  @override
  String get settingsDeviceLoggedOut => '設備已登出';

  @override
  String get settingsLogoutFailed => '登出失敗';

  @override
  String get settingsLogout => '登出';

  @override
  String get settingsVerifyIdentity => '驗證身份';

  @override
  String get settingsEnterPasswordToConfirm => '請輸入密碼以確認此操作。';

  @override
  String get scheduledSendTitle => '定時發送';

  @override
  String get scheduledSendInOneHour => '1小時後';

  @override
  String get scheduledSendTonight => '今晚 (20:00)';

  @override
  String get scheduledSendTomorrowMorning => '明早 (9:00)';

  @override
  String get scheduledSendCustom => '自定義時間';

  @override
  String get scheduledMessageLabel => '定時發送';

  @override
  String get scheduledMessageCancel => '取消定時發送';

  @override
  String get chatLockTitle => '聊天鎖';

  @override
  String get chatLockEnable => '鎖定此聊天';

  @override
  String get chatLockDisable => '解鎖此聊天';

  @override
  String get chatLockDescription => '鎖定的聊天需要通過生物識別或 PIN 碼驗證才能打開';

  @override
  String get chatLockVerifyTitle => '聊天已鎖定';

  @override
  String get chatLockVerifySubtitle => '驗證後訪問此聊天';

  @override
  String get chatLockVerifyFailed => '驗證失敗';

  @override
  String get chatLockEnabled => '聊天已鎖定';

  @override
  String get chatLockDisabled => '聊天已解鎖';

  @override
  String get chatLockPinTitle => '輸入 PIN 碼';

  @override
  String get chatLockPinSetTitle => '設置 PIN 碼';

  @override
  String get chatLockPinConfirmTitle => '確認 PIN 碼';

  @override
  String get chatLockPinMismatch => 'PIN 碼不一致';

  @override
  String get chatLockUseBiometric => '使用生物識別';

  @override
  String get chatLockUsePin => '使用 PIN 碼';

  @override
  String get mediaEditorUndo => '撤銷';

  @override
  String get mediaEditorRedo => '重做';

  @override
  String get mediaEditorCrop => '裁剪';

  @override
  String get mediaEditorFilter => '濾鏡';

  @override
  String get mediaEditorDraw => '塗鴉';

  @override
  String get mediaEditorText => '文字';

  @override
  String get aiAssistant => 'AI 助手';

  @override
  String get aiAssistantWelcome => '你好！我是 N42 AI 助手，有什麼可以幫你的嗎？';

  @override
  String get aiAssistantNotConfigured => 'AI 服務未配置';

  @override
  String get aiAssistantSettings => 'AI 設置';

  @override
  String get aiAssistantClearHistory => '清空對話歷史';

  @override
  String get aiAssistantClearHistoryConfirm => '確定清空所有 AI 對話歷史？';

  @override
  String get aiAssistantStopGenerating => '停止生成';

  @override
  String get aiAssistantModel => '模型';

  @override
  String get aiAssistantTemperature => '溫度';

  @override
  String get aiAssistantMaxTokens => '最大令牌數';

  @override
  String get aiAssistantContextWindow => '上下文窗口';

  @override
  String get aiAssistantServiceStatus => '服務狀態';

  @override
  String get aiAssistantAvailable => '可用';

  @override
  String get aiAssistantUnavailable => '不可用';

  @override
  String get aiSummarize => 'AI 總結';

  @override
  String aiSummarizeUnread(int count) {
    return 'AI 總結 $count 條未讀消息';
  }

  @override
  String get aiSummarizeLoading => '正在總結...';

  @override
  String get aiSummarizeError => '總結失敗';

  @override
  String get aiRewrite => 'AI 改寫';

  @override
  String get aiRewriteFormal => '正式';

  @override
  String get aiRewriteCasual => '輕鬆';

  @override
  String get aiRewritePlayful => '俏皮';

  @override
  String get aiRewriteProfessional => '專業';

  @override
  String get aiRewriteAccept => '使用';

  @override
  String get aiRewriteCancel => '取消';

  @override
  String get aiRewriteLoading => '正在改寫...';

  @override
  String get aiLinkSummary => 'AI 摘要';

  @override
  String get aiLinkSummaryAnalyzing => '正在分析...';

  @override
  String get chatFolderManagement => '管理文件夾';

  @override
  String get chatFolderSystem => '系統文件夾';

  @override
  String get chatFolderCustom => '自定義文件夾';

  @override
  String get chatFolderEmpty => '暫無自定義文件夾';

  @override
  String get chatFolderCreate => '創建文件夾';

  @override
  String get chatFolderEdit => '編輯文件夾';

  @override
  String get chatFolderNameHint => '文件夾名稱';

  @override
  String get chatFolderAll => '全部';

  @override
  String get chatFolderUnread => '未讀';

  @override
  String get chatFolderPersonal => '私聊';

  @override
  String get chatFolderGroups => '羣組';

  @override
  String get chatFolderChannels => '頻道';

  @override
  String get chatFolderMuted => '已靜音';

  @override
  String get storyAddMusic => '添加音樂';

  @override
  String get storyChangeMusic => '更換音樂';

  @override
  String get storyBackgroundMusic => '背景音樂';

  @override
  String get storyMusicPreview => '預覽 (最長15秒)';

  @override
  String get storyChooseFromDevice => '從設備選擇';

  @override
  String get storyUseThisMusic => '使用此音樂';

  @override
  String get authPasskeyNotSupported => '此設備不支持 Passkey';

  @override
  String get authPasskeyRegister => '註冊 Passkey';

  @override
  String get authPasskeyNoRegistered => '未註冊 Passkey';

  @override
  String get authPasskeyRegisterHint => '爲當前賬號註冊 Passkey，獨立 Passkey 登錄入口後續開放。';

  @override
  String get authPasskeyNameYours => '爲 Passkey 命名';

  @override
  String get authPasskeyRegistered => 'Passkey 已保存到當前賬號';

  @override
  String get authPasskeyDeleted => 'Passkey 已從當前賬號移除';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return '刪除 Passkey \"$name\"？如需後續使用 Passkey 登錄，需要重新註冊。';
  }

  @override
  String get momentVisibilityPublic => '公開';

  @override
  String get momentVisibilityPrivate => '私密';

  @override
  String get momentVisibilityPartial => '部分可見';

  @override
  String get momentVisibilityExcluded => '不給誰看';

  @override
  String momentUserMoments(String userName) {
    return '$userName的朋友圈';
  }

  @override
  String get momentForwardTo => '轉發給';

  @override
  String get momentForwardSuccess => '轉發成功';

  @override
  String get momentSelectFriends => '選擇好友';

  @override
  String get momentSelectTags => '按標籤選擇';

  @override
  String momentSelectedCount(int count) {
    return '已選擇 ($count)';
  }

  @override
  String get momentNoMomentsYet => '暫無動態';

  @override
  String get momentForwardMoment => '轉發動態';

  @override
  String get momentAddComment => '寫評論...';

  @override
  String momentForwardContent(String content) {
    return '[朋友圈] $content';
  }

  @override
  String get momentDeleteMoment => '刪除動態';

  @override
  String get momentDeleteConfirm => '確定要刪除這條動態嗎？';

  @override
  String get momentComment => '評論';

  @override
  String get momentWriteComment => '寫評論...';

  @override
  String get momentLike => '贊';

  @override
  String get momentUnlike => '取消';

  @override
  String get momentForward => '轉發';

  @override
  String get momentDelete => '刪除';

  @override
  String get momentReply => '回覆';

  @override
  String get momentMoment => '動態';

  @override
  String momentLikesCount(int count) {
    return '$count 個贊';
  }

  @override
  String momentCommentsCount(int count) {
    return '$count 條評論';
  }

  @override
  String get momentNoComments => '暫無評論';

  @override
  String get momentFailedToLoad => '圖片加載失敗';

  @override
  String momentReplyTo(String userName) {
    return '回覆 $userName...';
  }

  @override
  String get momentNoConversations => '暫無會話';

  @override
  String get momentJustNow => '剛剛';

  @override
  String momentMinutesAgo(int count) {
    return '$count分鐘前';
  }

  @override
  String momentHoursAgo(int count) {
    return '$count小時前';
  }

  @override
  String momentDaysAgo(int count) {
    return '$count天前';
  }

  @override
  String get chatGroupAnnouncementHint => '輸入羣公告';

  @override
  String get chatGroupAnnouncementEmpty => '暫無羣公告';

  @override
  String get chatEditNickname => '編輯羣暱稱';

  @override
  String get chatNicknameHint => '輸入你在羣裏的暱稱';

  @override
  String get contactAddPhoneHint => '輸入電話號碼';

  @override
  String get contactNotesHint => '添加聯繫人備忘';

  @override
  String get reportTitle => '投訴';

  @override
  String get reportReasonSpam => '垃圾信息';

  @override
  String get reportReasonHarassment => '騷擾';

  @override
  String get reportReasonFraud => '欺詐';

  @override
  String get reportReasonOther => '其他';

  @override
  String get reportSubmitted => '投訴已提交';

  @override
  String get reportDescription => '補充說明（選填）';

  @override
  String get qrcodeSaved => '二維碼已保存到相冊';

  @override
  String get chatSendRedPacketInChat => '請在聊天中發送紅包';

  @override
  String get commonSaveFailed => '保存失敗';

  @override
  String get reportSelectReason => '請選擇投訴原因';

  @override
  String get reportUnavailable => '登入後即可檢舉。';

  @override
  String get reportAccountChanged => '帳戶已切換。請重新開啟此檢舉頁面後傳送。';

  @override
  String get reportUnsupported => '此主伺服器不支援檢舉使用者。';

  @override
  String get reportRoomUnsupported => '此主伺服器不支援檢舉聊天室。';

  @override
  String get reportRateLimited => '檢舉過於頻繁，請稍後重試。';

  @override
  String get reportCouldNotSend => '無法傳送檢舉，請重試。';

  @override
  String get gameCenter => '遊戲中心';

  @override
  String get gameHighScore => '最高分';

  @override
  String get gameScore => '分數';

  @override
  String get gameOver => '遊戲結束';

  @override
  String get gamePlayAgain => '再來一局';

  @override
  String get gameLeaderboard => '排行榜';

  @override
  String get gamePause => '暫停';

  @override
  String get gameResume => '點擊繼續';

  @override
  String get gameConfirmExit => '確定退出遊戲？';

  @override
  String get gameNoScores => '暫無記錄';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => '合併數字到 2048';

  @override
  String get gameBlockDrop => '方塊消除';

  @override
  String get gameBlockDropDesc => '消除方塊行';

  @override
  String get gameMinesweeper => '掃雷';

  @override
  String get gameMinesweeperDesc => '找出所有安全格';

  @override
  String get gameMatch3 => '消消樂';

  @override
  String get gameMatch3Desc => '連接3個以上寶石';

  @override
  String get gameMinesweeperEasy => '初級';

  @override
  String get gameMinesweeperMedium => '中級';

  @override
  String get gameMinesLeft => '剩餘雷數';

  @override
  String get gameTimeLeft => '時間';

  @override
  String get gameLevel => '等級';

  @override
  String get gameNext => '下一個';

  @override
  String get gameBestTime => '最佳用時';

  @override
  String get gameNewRecord => '新紀錄！';

  @override
  String get gameLines => '行數';

  @override
  String get storyMyStory => '我的動態';

  @override
  String get storageSmartCleanup => '智能清理';

  @override
  String get storageOldMediaFiles => '舊媒體文件';

  @override
  String get storageLargeFiles => '大文件';

  @override
  String get storageAppCache => '應用緩存';

  @override
  String get storageSettings => '存儲設置';

  @override
  String get storageAutoCleanup => '自動清理';

  @override
  String storageAutoCleanupDesc(int days) {
    return '自動清理 $days 天以上未訪問的文件';
  }

  @override
  String get storageCleanupPeriod => '清理週期';

  @override
  String get storagePreserveThumbnails => '保留縮略圖';

  @override
  String get storagePreserveThumbnailsDesc => '清理時保留圖片縮略圖';

  @override
  String get storageWarningHigh => '存儲空間較高，建議清理舊文件。';

  @override
  String get storageWarningCritical => '存儲空間嚴重不足，請立即清理。';

  @override
  String storageFreed(String size, int count) {
    return '已釋放 $size（$count 個文件）';
  }

  @override
  String storageDays(int days) {
    return '$days 天';
  }

  @override
  String storageViewAllRooms(int count) {
    return '查看全部 $count 個房間';
  }

  @override
  String get storageNoFiles => '暫無文件';

  @override
  String get storageFilePinned => '已保留';

  @override
  String storageDeleteSelected(int count) {
    return '刪除 $count 個選中文件？文件可從服務器重新下載。';
  }

  @override
  String get backupRestore => '備份與恢復';

  @override
  String get backupCreate => '創建備份';

  @override
  String get backupCreateDesc => '備份設置和加密密鑰。消息將在重新登錄後從服務器恢復。';

  @override
  String get backupIncludeKeys => '包含加密密鑰';

  @override
  String get backupIncludeKeysDesc => '讀取加密消息所必需';

  @override
  String get backupPasswordProtect => '密碼保護';

  @override
  String get backupEnterPassword => '輸入備份密碼';

  @override
  String get backupHistory => '備份歷史';

  @override
  String get backupNoBackups => '暫無備份';

  @override
  String get backupRestore2 => '恢復';

  @override
  String get backupDelete => '刪除';

  @override
  String get backupDeleteConfirm => '確定刪除此備份？此操作不可撤銷。';

  @override
  String get backupRestoreFromFile => '從文件恢復';

  @override
  String get backupRestoreFromFileDesc => '導入來自其他設備或之前備份的 .n42backup 文件。';

  @override
  String get backupChooseFile => '選擇備份文件';

  @override
  String get backupRestoring => '恢復中...';

  @override
  String backupCreated(int rooms, int messages) {
    return '備份已創建：$rooms 個房間，$messages 條消息';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return '已恢復 $settings 項設置（來自 $rooms 個房間）';
  }

  @override
  String backupFailed(String error) {
    return '備份失敗：$error';
  }

  @override
  String get backupPasswordRequired => '此備份需要密碼';

  @override
  String get blocGroupNotFound => '羣組未找到';

  @override
  String blocGroupMembersInvited(int count) {
    return '已邀請$count位成員';
  }

  @override
  String get blocGroupMemberRemoved => '成員已移除';

  @override
  String get blocGroupAdminRemoved => '已取消管理員';

  @override
  String get blocGroupLeft => '已退出羣聊';

  @override
  String get blocGroupDisbanded => '羣聊已解散';

  @override
  String get blocGroupJoined => '已加入羣聊';

  @override
  String get blocGroupInviteDeclined => '已拒絕邀請';

  @override
  String get blocGroupTokenGateUpdated => 'Token 門檻已更新';

  @override
  String get blocTransferProcessing => '轉賬處理中...';

  @override
  String get blocTransferCancelled => '轉賬已取消';

  @override
  String get blocTransferFailed => '轉賬失敗';

  @override
  String get blocPaymentProcessing => '支付處理中...';

  @override
  String get blocPaymentFailed => '支付失敗';

  @override
  String get groupMaxMembers => '羣人數上限';

  @override
  String get groupMaxMembersUnlimited => '不限';

  @override
  String get groupMaxMembersHint => '輸入上限（留空表示不限）';

  @override
  String get groupMaxMembersUpdated => '羣人數上限已更新';

  @override
  String get groupFull => '羣已滿員';

  @override
  String get groupChannels => '話題頻道';

  @override
  String get groupChannelsEmpty => '暫無話題頻道';

  @override
  String get groupChannelsCount => '個頻道';

  @override
  String get groupChannelCreate => '新建頻道';

  @override
  String get groupChannelName => '頻道名稱';

  @override
  String get groupChannelTopic => '頻道話題（可選）';

  @override
  String get groupChannelDelete => '刪除頻道';

  @override
  String get groupChannelDeleteConfirm => '確認刪除此頻道？消息不可恢復。';

  @override
  String get groupBotSettings => 'Bot 設置';

  @override
  String get groupBotEnabled => '啓用 Bot';

  @override
  String get groupBotWelcomeMessage => '歡迎語模板';

  @override
  String get groupBotWelcomeHint => '用 \'name\' 作爲新成員名字佔位符';

  @override
  String get groupBotConfigUpdated => 'Bot 設置已更新';

  @override
  String get groupContentFilter => '關鍵詞過濾';

  @override
  String get groupContentFilterEnabled => '啓用關鍵詞過濾';

  @override
  String get groupContentFilterReplace => '替換爲 ***';

  @override
  String get groupContentFilterHide => '隱藏消息';

  @override
  String get groupContentFilterAddWord => '添加關鍵詞';

  @override
  String get groupContentFilterUpdated => '內容過濾設置已更新';

  @override
  String get chatSlashCommands => '指令';

  @override
  String get chatCommandPoll => '/poll — 創建投票';

  @override
  String get chatCommandAnnounce => '/announce — 發佈公告';

  @override
  String get chatCommandWelcome => '/welcome — 設置歡迎語';

  @override
  String get chatReportMessage => '舉報';

  @override
  String get chatReportReason => '舉報原因';

  @override
  String get chatReportSpam => '垃圾信息';

  @override
  String get chatReportHarassment => '騷擾';

  @override
  String get chatReportInappropriate => '違規內容';

  @override
  String get chatReportOther => '其他';

  @override
  String get chatReportSuccess => '舉報已提交';

  @override
  String get spacesName => '社區名稱';

  @override
  String get spacesNameHint => '例如：加密交易者';

  @override
  String get spacesNameRequired => '請輸入社區名稱';

  @override
  String get spacesDescription => '簡介';

  @override
  String get spacesDescriptionHint => '介紹一下這個社區';

  @override
  String get spacesType => '社區類型';

  @override
  String get spacesPublicDesc => '任何人均可發現並加入';

  @override
  String get spacesPrivateDesc => '僅受邀成員可加入';

  @override
  String get spacesNotFound => '社區不存在';

  @override
  String get spacesSearch => '搜索社區...';

  @override
  String get spacesMembers => '成員';

  @override
  String get spacesNoChannels => '暫無頻道';

  @override
  String get spacesLeave => '退出社區';

  @override
  String spacesLeaveConfirm(String name) {
    return '確定要退出「$name」嗎？';
  }

  @override
  String get spacesDelete => '解散社區';

  @override
  String spacesDeleteConfirm(String name) {
    return '此操作將永久刪除「$name」及其所有頻道，且不可撤銷。';
  }

  @override
  String get spacesCreateChannel => '創建頻道';

  @override
  String get spacesChannelName => '頻道名稱';

  @override
  String get spacesChannelTopic => '話題（可選）';

  @override
  String get spacesDeleteChannel => '刪除頻道';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return '確定要刪除頻道「#$name」嗎？';
  }

  @override
  String get spacesEditName => '修改名稱';

  @override
  String get spacesEditDescription => '修改簡介';

  @override
  String spacesViewAllMembers(int count) {
    return '查看全部 $count 位成員';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return '踢出 $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return '封禁 $name';
  }

  @override
  String get spacesPromoteAdmin => '設爲管理員';

  @override
  String get spacesDemoteAdmin => '撤銷管理員';

  @override
  String get spacesInviteMember => '邀請成員';

  @override
  String get spacesInviteMemberUserId => '用戶 ID（如 @user:server.com）';

  @override
  String get spacesSave => '保存';

  @override
  String get settingsScreenshotProtection => '截圖防護';

  @override
  String get settingsScreenshotProtectionDesc => '防止截圖和屏幕錄製';

  @override
  String get chatSelfDestructTimer => '閱後即焚';

  @override
  String get chatTimerPickerTitle => '設置閱後即焚時間';

  @override
  String get chatTimerOff => '關閉';

  @override
  String get onChainNotificationsTitle => '鏈上事件';

  @override
  String get onChainMarkAllRead => '全部已讀';

  @override
  String get onChainNoNotifications => '暫無鏈上事件';

  @override
  String get onChainNoNotificationsDesc => '來自訂閱頻道的事件通知將在此顯示';

  @override
  String get onChainViewDetails => '查看詳情';

  @override
  String get chatCommandHelp => '/help — 查看所有命令';

  @override
  String get chatCommandPrice => '/price — 查詢代幣價格';

  @override
  String get chatCommandBalance => '/balance — 查看錢包餘額';

  @override
  String get chatCommandChains => '/chains — 查看 236+ 條支持鏈';

  @override
  String get chatMiniApps => '應用';

  @override
  String get miniAppMarketTitle => '小程序';

  @override
  String get miniAppCategoryAll => '全部';

  @override
  String get miniAppSearch => '搜索應用...';

  @override
  String get miniAppFeatured => '精選';

  @override
  String get miniAppAllApps => '全部應用';

  @override
  String get miniAppNoResults => '未找到應用';

  @override
  String get slideToPayLabel => '→→→  滑動確認';

  @override
  String get slideToPayConfirming => '確認中...';

  @override
  String get redPacketBestLuck => '最佳手氣';

  @override
  String get redPacketBestLuckCongrats => '最佳手氣！你搶到了最多！';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total 個已領取';
  }

  @override
  String get redPacketStatsTotal => '共計';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 搶到了紅包 • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id  •  0x 錢包地址  •  name.eth';

  @override
  String get web3SearchPlaceholder => '搜索 ID、錢包地址或 ENS...';

  @override
  String get web3WalletAddress => '錢包地址';

  @override
  String get web3AddressCopied => '地址已複製';

  @override
  String get web3Copy => '複製';

  @override
  String get web3SendMessage => '發消息';

  @override
  String get web3SendToWallet => '發送到錢包';

  @override
  String get web3WalletOnlyHint => '該地址尚無 N42 賬號。對方加入後消息將自動送達。';

  @override
  String get web3NftAvatar => 'NFT 頭像';

  @override
  String get web3ResolveFailed => '身份解析失敗';

  @override
  String web3EnsNotFound(String name) {
    return 'ENS 名稱“$name”未找到';
  }

  @override
  String get web3NoN42AccountTitle => '無 N42 賬號';

  @override
  String get web3NoN42AccountDesc => '該錢包地址尚無 N42 賬號。您可以分享 N42 邀請鏈接邀請對方加入。';

  @override
  String get web3ShareInvite => '分享邀請';

  @override
  String get nftPickerTitle => '選擇 NFT 頭像';

  @override
  String get nftPickerTabPopular => '熱門';

  @override
  String get nftPickerTabCustom => '自定義';

  @override
  String get nftPickerChain => '鏈';

  @override
  String get nftPickerContract => '合約地址';

  @override
  String get nftPickerTokenId => '代幣 ID';

  @override
  String get nftPickerVerifyOwnership => '驗證所有權並預覽';

  @override
  String get nftPickerUseAsAvatar => '用作頭像';

  @override
  String get nftPickerPreview => '預覽';

  @override
  String get nftPickerNotOwned => '您不擁有這個 NFT';

  @override
  String get nftPickerInvalidTokenId => '無效的 Token ID';

  @override
  String get nftPickerEnterBoth => '請輸入合約地址和 Token ID';

  @override
  String get nftPickerInfoTitle => 'NFT 頭像 — 鏈上身份驗證';

  @override
  String get nftPickerInfoDesc =>
      '綁定您持有的 NFT 作爲頭像。任何人均可在鏈上驗證歸屬權。在 N42 全應用中以金色邊框標識。';

  @override
  String get nftPickerPopularCollections => '熱門 NFT 項目';

  @override
  String get nftPickerWalletHint => '連接 N42 錢包，自動發現您在 236+ 條鏈上持有的 NFT。';

  @override
  String get profileBindNftAvatar => '綁定 NFT 頭像';

  @override
  String get profileChangeAvatar => '更換頭像';

  @override
  String get groupTopics => '羣話題';

  @override
  String get groupTopicsEmpty => '暫無話題';

  @override
  String get syncInProgress => '正在同步歷史消息...';

  @override
  String get recoveryKeyReminderTitle => '保護您的消息';

  @override
  String get recoveryKeyReminderDesc => '創建恢復密鑰以在多設備上安全同步加密消息';

  @override
  String get recoveryKeySetupNow => '立即設置';

  @override
  String get recoveryKeyRemindLater => '稍後提醒';

  @override
  String get channelReadOnly => '僅管理員可在此頻道發言';

  @override
  String get channelSubscribers => '訂閱者';

  @override
  String get channelVerified => '已認證頻道';

  @override
  String get redPacketHistory => '紅包記錄';

  @override
  String get redPacketSent => '已發出';

  @override
  String get redPacketReceived => '已收到';

  @override
  String get redPacketExpired => '已過期';

  @override
  String get redPacketClaimed => '已領取';

  @override
  String get redPacketInsufficientBalance => '餘額不足';

  @override
  String selfDestructCountdown(String time) {
    return '$time 後銷燬';
  }

  @override
  String get messageDestroyed => '消息已銷燬';

  @override
  String miniAppPermissionDenied(String permission) {
    return '權限不足：$permission';
  }

  @override
  String get aiSuggestionGasFee => '什麼是 Gas 費？';

  @override
  String get aiSuggestionDefi => 'DeFi 入門';

  @override
  String get aiSuggestionSecurity => '如何檢查合約安全';

  @override
  String get aiSuggestionBridge => '跨鏈橋接';

  @override
  String get channelDiscoverTitle => '發現頻道';

  @override
  String get channelDiscoverSearch => '搜索頻道...';

  @override
  String get channelJoin => '加入';

  @override
  String get channelJoined => '已加入';

  @override
  String get channelCategory => '分類';

  @override
  String slowModeCooldown(int seconds) {
    return '慢速模式：請等待 $seconds 秒';
  }

  @override
  String get addressCopyAction => '複製地址';

  @override
  String get addressSendMessage => '發消息';

  @override
  String get addressViewProfile => '查看資料';

  @override
  String get sendToAddress => '通過錢包地址發消息';

  @override
  String get blocAuthSendVerificationCodeFailed => '發送驗證碼失敗';

  @override
  String get blocAuthServerNoEmailPasswordReset => '該服務器不支持通過郵箱重置密碼';

  @override
  String get blocAuthResetPasswordFailed => '重置密碼失敗';

  @override
  String get blocAuthChangePasswordFailed => '修改密碼失敗';

  @override
  String get blocAuthOldPasswordWrong => '原密碼錯誤';

  @override
  String get blocAuthLoginCancelled => '登錄已取消';

  @override
  String get blocAuthGoogleLoginFailed => 'Google 登錄失敗';

  @override
  String get blocAuthAppleLoginFailed => 'Apple 登錄失敗';

  @override
  String get blocAuthSsoLoginFailed => 'SSO 登錄失敗';

  @override
  String get blocAuthFacebookLoginFailed => 'Facebook 登錄失敗';

  @override
  String get blocAuthTwitterLoginFailed => 'Twitter 登錄失敗';

  @override
  String get blocAuthWeChatLoginFailed => '微信登錄失敗';

  @override
  String get blocAuthWeChatNotConfigured => '微信登錄未配置';

  @override
  String get blocAuthWeChatNotInstalled => '請先安裝微信';

  @override
  String get blocAuthPasswordWrong => '密碼錯誤';

  @override
  String get blocAuthEmailAlreadyBound => '該郵箱已被其他賬號綁定';

  @override
  String get blocAuthChangeEmailFailed => '修改郵箱失敗';

  @override
  String get blocAuthVerificationCodeInvalid => '驗證碼錯誤或已過期';

  @override
  String get blocAuthSessionExpired => '會話已失效，請重新登錄';

  @override
  String get blocAuthSessionIncomplete => '會話數據不完整，請重新登錄';

  @override
  String get chatReadingMode => '閱讀模式';

  @override
  String get groupPoints => '積分';

  @override
  String get settingsPrivacySecurity => '隱私與安全';

  @override
  String get settingsSystemAccounts => '系統與帳號';

  @override
  String get settingsNotificationPrivacy => '通知隱私';

  @override
  String get settingsSenderOnly => '僅顯示傳送者';

  @override
  String get settingsHiddenNotification => '隱藏傳送者和訊息';

  @override
  String get settingsSmartFilter => '智慧篩選';

  @override
  String get settingsEmailVerificationSent => '驗證郵件已傳送';

  @override
  String get settingsEmailLinkInstructions => '請開啟郵件中的驗證連結，然後返回此處確認。';

  @override
  String get settingsSendVerificationEmail => '傳送驗證郵件';

  @override
  String get chatLogoutKeyWarning => '登出前請備份加密金鑰，否則可能無法再讀取加密訊息。';

  @override
  String get settingsBiometricUnavailable =>
      '生物識別暫不可用，請檢查系統設定中的臉部或指紋登錄及應用程式權限。';

  @override
  String get chatEncryptionNotReady => '安全連線尚未就緒，訊息未傳送。請雙方檢查網路和裝置驗證後重試。';

  @override
  String get contactRequestPending => '等待對方接受';

  @override
  String get chatFriendRequestPending => '好友關係尚未確認，請到「聯絡人 → 新的朋友」查看並處理申請後再傳送。';

  @override
  String contactPhotoCount(int count) {
    return '$count張照片';
  }

  @override
  String get videoPublish => '發布影片';

  @override
  String get videoGoLive => '發起直播';

  @override
  String get videoSelect => '選擇影片';

  @override
  String get videoLiveUnavailable => '目前無法發起直播';

  @override
  String get qrcodeAlbum => '相簿';

  @override
  String get settingsSwitchAccount => '切換帳號';

  @override
  String get chatFilterUnread => '未讀';

  @override
  String get chatFilterEmpty => '此分類暫無對話';

  @override
  String get accountAdd => '加入帳號';

  @override
  String get accountCurrent => '目前帳號';

  @override
  String get accountSwitching => '正在切換帳號…';

  @override
  String get accountSwitchFailed => '切換失敗，請重試，或加入該帳號重新登入。';

  @override
  String get accountSessionsHint => '在此切換帳號，各帳號的訊息與安全工作階段獨立保留。';

  @override
  String get accountNoSaved => '尚無已儲存的帳號';

  @override
  String get contactRequestSent => '申請已傳送';

  @override
  String get contactRequestsIncoming => '收到的申請';

  @override
  String get contactRequestsOutgoing => '發出的申請';

  @override
  String get contactRequestHint => '申請通過後即可聊天與通話。';

  @override
  String get callReturnToCall => '返回通話';

  @override
  String get chatMessageSending => '傳送中';

  @override
  String get chatMessageSent => '已傳送';

  @override
  String get chatMessageDelivered => '已送達';

  @override
  String get chatMessageRead => '已讀';

  @override
  String get chatMessageFailed => '未傳送，點一下重試。';

  @override
  String get chatMessageUnavailable => '此裝置暫時無法讀取這則訊息，點一下查看復原選項。';

  @override
  String get contactStarredFriends => '星標朋友';

  @override
  String get chatRecipientKeysMissing =>
      '對方暫無可用的加密會話。請對方登入並開啟應用程式後重試。日常換號請使用「切換帳號」，不要登出。';

  @override
  String get chatSwitchForMessaging =>
      '需要換號？請選擇「切換帳號」以保留訊息和安全會話。登出會撤銷此裝置，可能導致收到的加密訊息無法讀取。';

  @override
  String get aiServiceUnavailable => 'AI 總結服務暫不可用，請待服務恢復存取後重試。';

  @override
  String aiSummarizeMessages(int count) {
    return '總結最近 $count 則訊息';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return '$joined 人已加入 · $invited 人待接受';
  }

  @override
  String contactPendingCount(int count) {
    return '$count 則待處理申請';
  }

  @override
  String get chatDraftLabel => '草稿';

  @override
  String get contactIndexLabel => '聯絡人索引';

  @override
  String get transferAssetUnavailable => '支付資產無法使用';

  @override
  String get transferPaymentRequestUnavailable => '收款請求無法使用';

  @override
  String get chatCatchUp => '群聊追趕';

  @override
  String get chatCatchUpMentions => '提及我的';

  @override
  String get chatCatchUpReplies => '回覆我的';

  @override
  String get chatCatchUpPinned => '置頂訊息';

  @override
  String get chatCatchUpScope => '提及和回覆僅篩選已載入訊息，包含已讀訊息。載入更早訊息可尋找更早的回覆。';

  @override
  String get chatCatchUpLoadMore => '載入更早訊息';

  @override
  String get chatActionPreview => '確認日曆建議';

  @override
  String get chatActionPrivacy => '確認後，僅將下方標題和時間交給日曆應用程式。請核對時區。日曆帳戶可能同步此行程。';

  @override
  String get chatActionTitle => '聊天行程';

  @override
  String get chatActionSuggestion => '日曆建議';

  @override
  String get chatUnreadAttention => '未讀提及與回覆';

  @override
  String get chatScanAgain => '重新掃描';

  @override
  String get chatUnreadScope => '依伺服器順序掃描至已讀標記。開啟會話即可閱讀，重新整理可再次掃描。';

  @override
  String get chatScanIncomplete => '尚未完整：歷史、解密或已讀標記無法使用，請同步後重試。';

  @override
  String get chatHistoryShare => '補發選定歷史';

  @override
  String get chatHistoryExplanation =>
      '僅管理員可用。選擇一般文字與已入群成員的現有加密私聊。補發會在群內留下可見稽核訊息。';

  @override
  String get chatHistoryEnable => '啟用補發';

  @override
  String get chatHistoryDisable => '停用補發';

  @override
  String get chatHistoryPolicy => '群歷史補發原則';

  @override
  String get chatHistoryPolicyDetail =>
      '僅管理員可補發。啟用時也將群歷史可見性限制為入群之後。請設定下方文字訊息限制並確認。';

  @override
  String get chatHistoryPolicySaved => '原則已儲存';

  @override
  String get chatHistoryRecipient => '接收人的加密私聊';

  @override
  String get chatHistoryReview => '預覽選定訊息';

  @override
  String get chatHistoryMessages => '則訊息';

  @override
  String get chatHistoryConfirmDetail =>
      '請確認接收人、每則文字與時間後再補發。失敗或結果未知時內容可能已送出，請先核對結果。';

  @override
  String get chatHistoryCompleted => '選定歷史已送出，群內稽核已確認';

  @override
  String get chatHistoryPending => '待核對：請先核對，再確認繼續。傳送結果未知的內容不會重發。';

  @override
  String get chatHistoryReconcile => '核對傳送結果';

  @override
  String get chatHistoryFailed =>
      '無法完成。請檢查管理員權限、群原則、加密、接收人成員身分及選定內容。若已開始傳送，請核對結果。';

  @override
  String get chatDeviceActions => '裝置端操作';

  @override
  String get chatDeviceActionsReview =>
      '確認後，僅將此訊息交給系統的裝置端操作建議。選擇建議可開啟日曆、提醒事項或地圖。';

  @override
  String get chatHistoryMaxMessages => '訊息上限（1–50）';

  @override
  String get chatHistoryMaxHours => '回溯小時數（1–720）';

  @override
  String get chatNotifyAll => '所有訊息';

  @override
  String get chatNotifyAllDescription => '此聊天中的每則新訊息都通知';

  @override
  String get chatNotifyMentions => '僅提及我';

  @override
  String get chatNotifyMentionsDescription => '僅在有人提及你或使用 @room 時通知';

  @override
  String get chatNotifyMutedDescription => '在所有裝置上關閉此聊天的通知';

  @override
  String get scheduledMessagesTitle => '排程訊息';

  @override
  String get scheduledMessagesEmpty => '尚無排程訊息';

  @override
  String get scheduledMessagesHint => '長按傳送、照片、檔案、GIF 或貼圖，即可設定排程傳送。';

  @override
  String get scheduledMessageCancelled => '已取消排程訊息';

  @override
  String scheduledMessageCreatedAt(String time) {
    return '建立於 $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => '傳送結果尚未確認';

  @override
  String get scheduledRecoveryCopy => '儲存復原副本';

  @override
  String get scheduledRecoveryCopyHint =>
      '副本儲存在此裝置，不會變更或傳送訊息。預覽最多顯示 8,000 個字元。';

  @override
  String get scheduledRecoveryCopies => '復原副本';

  @override
  String get scheduledRecoveryReset => '重設損壞佇列';

  @override
  String get scheduledRecoveryResetHint =>
      '完整副本已儲存在此裝置。要重設此帳號的所有排程訊息嗎？部分訊息可能已傳送。副本和附件將保留，不會重新傳送任何訊息。';

  @override
  String get scheduledRecoveryExportHint =>
      '此檔案包含未加密的草稿文字和帳號資訊，不包含附件。請選擇可信任的儲存或分享位置。';

  @override
  String get scheduledRecoveryImport => '匯入復原副本';

  @override
  String get scheduledRecoveryImportHint =>
      '僅將預覽內容儲存為復原副本，不會排程或傳送訊息。檔案不含附件，檔案作者未經驗證。';

  @override
  String get scheduledRecoveryComposerHint =>
      '將文字附加到目前草稿以供檢查，不會傳送訊息。附件、提及和定時設定不會還原。請確認此訊息是否已送達。';

  @override
  String get backupRecoverLegacyArchive => '復原舊的本機歷史';

  @override
  String get backupLegacyArchiveWarning =>
      '這些歷史記錄的帳號歸屬未經驗證。請僅將屬於你的聊天室複製到下方帳號，原始記錄會保留。';

  @override
  String get backupOlderFiles => '舊備份檔案';

  @override
  String get backupOlderFilesWarning => '這些檔案可能屬於其他帳號。請選擇檔案，核對內容和帳號歸屬後再復原。';

  @override
  String get stickerImportTitle => '匯入貼圖包';

  @override
  String get stickerImportLinkHint => 'Matrix 貼圖包連結';

  @override
  String get stickerImportPreview => '預覽';

  @override
  String get stickerImportUnavailable => '此貼圖包無法使用，或你沒有存取權限。';

  @override
  String get stickerImportCopyNotice => '新增此貼圖包的私人副本。圖片和中繼資料不受端對端加密保護。';

  @override
  String get stickerImportFailed => '無法新增此貼圖包，請重試。';

  @override
  String get stickerImportAccountChanged => '帳號已變更或登入已失效，請重新開啟貼圖匯入。';

  @override
  String get stickerPackSourceRoom => '來源對話';

  @override
  String get stickerPackImages => '圖片';

  @override
  String get stickerPublishNotice =>
      '將此貼圖包發佈到所選群組。圖片和中繼資料不受端對端加密保護。可讀取群組狀態的人可能存取這些內容。';

  @override
  String get stickerPublishFailed => '無法確認發佈結果。請先檢查群組，再決定是否重試。';

  @override
  String get stickerPublishReceiptMissing => '已發佈，但連結未能儲存。離開此頁面前，請先分享或複製連結。';

  @override
  String get stickerSubscribe => '訂閱更新';

  @override
  String get stickerSubscribeNotice =>
      '持續接收貼圖包管理員後續的修改。圖片和中繼資料不受端對端加密保護。你可以稍後取消訂閱；此操作不會加入來源群組。';

  @override
  String get stickerSubscriptions => '貼圖訂閱';

  @override
  String get stickerUnsubscribe => '取消訂閱';

  @override
  String get stickerSubscriptionsEmpty => '尚無貼圖訂閱';

  @override
  String get chatAttachmentEvent => '活動';

  @override
  String get chatRecentMedia => '最近的照片和影片';

  @override
  String get chatRecentMediaLoadFailed => '無法載入最近的照片和影片';

  @override
  String get chatRecentMediaPermission => '需要照片存取權限才能顯示最近的照片和影片';

  @override
  String get chatRecentMediaEmpty => '沒有最近的照片或影片';

  @override
  String get chatRecentPhoto => '最近的照片';

  @override
  String get chatRecentVideo => '最近的影片';

  @override
  String get chatAttachmentTip => '打賞';

  @override
  String get chatAttachmentWhiteboard => '白板';

  @override
  String get chatAttachmentVideoNote => '影片留言';

  @override
  String get chatAttachmentCode => '程式碼';

  @override
  String get chatAttachmentShop => '商店';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '最多選擇 $countString 項';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return '今晚 ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return '明早 ($time)';
  }

  @override
  String get a11yScrollToBottom => '捲動到底部';

  @override
  String get ui3EnterMessageBeforeScheduling => '請先輸入訊息再排程傳送';

  @override
  String get ui3SendCode => '傳送程式碼';

  @override
  String get ui3CodeLanguage => '語言';

  @override
  String get ui3PasteCodeHere => '在此貼上程式碼';

  @override
  String ui3ReminderSetAt(String time) {
    return '已設定提醒 · $time';
  }

  @override
  String get ui3RedPacketCreateFailed => '紅包建立失敗';

  @override
  String get ui3SendTip => '打賞';

  @override
  String get ui3TokenLabel => '代幣';

  @override
  String get ui3NoteOptional => '備註（選填）';

  @override
  String ui3TipFailed(String error) {
    return '打賞失敗：$error';
  }

  @override
  String get ui3GiftNftTitle => '贈送 NFT';

  @override
  String get ui3TokenId => '代幣 ID';

  @override
  String ui3NftGiftFailed(String error) {
    return 'NFT 贈送失敗：$error';
  }

  @override
  String get ui3AiAgentSubtitle => '描述任務，開啟合適的小程式';

  @override
  String get ui3GiftNft => '贈送 NFT';

  @override
  String get ui3GiftNftSubtitle => '向此聯絡人傳送 NFT';

  @override
  String get ui3MiniAppUnavailable => '小程式無法使用';

  @override
  String ui3MediaItemsNotSent(int count) {
    return '$count 個所選媒體無法傳送';
  }

  @override
  String get ui3PhotosSubtitle => '以適合聊天的格式傳送相片和影片';

  @override
  String get ui3OriginalImages => '原圖';

  @override
  String get ui3OriginalImagesSubtitle => '以檔案形式傳送未壓縮的相片';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return '已排程傳送 $filename：$time';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return '正在傳送原圖：$filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return '已排程傳送原圖：$filename';
  }

  @override
  String get ui3PaymentAlreadySent => '已付款';

  @override
  String get ui3PaymentProcessing => '付款處理中';

  @override
  String ui3ChainStatus(String status) {
    return '鏈上狀態：$status';
  }

  @override
  String get ui3NotChecked => '未檢查';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return '已確認：$confirmations / $required 個區塊';
  }

  @override
  String get ui3CopyTxHash => '複製交易雜湊';

  @override
  String get ui3VerifyAgain => '重新驗證';

  @override
  String get ui3VerifyOnChain => '鏈上驗證';

  @override
  String get ui3TransferMissingChainDetails => '此轉帳未包含確切的鏈與資產資訊。';

  @override
  String get ui3ReceiptPending => '鏈上待確認';

  @override
  String get ui3ReceiptConfirmed => '已確認';

  @override
  String get ui3ReceiptFailed => '鏈上失敗';

  @override
  String get ui3ReceiptMismatch => '交易詳情不符';

  @override
  String get ui3ReceiptUnsupported => '不支援鏈上驗證';

  @override
  String get ui3ReceiptUnavailable => '無法驗證';

  @override
  String get ui3OpenOrSave => '開啟 / 儲存';

  @override
  String get ui3UnableToOpenFile => '無法開啟此檔案。';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'AI 改寫失敗：$error';
  }

  @override
  String get ui3AiShareMessagesTitle => '與 AI 分享訊息？';

  @override
  String get ui3AiShareMessagesBody =>
      '選擇 AI 可用於本次回覆的訊息。此次單次授權將在兩分鐘後失效。關閉快速回覆會取消待處理的結果。此授權不允許付款或匯出。';

  @override
  String get ui3OtherParticipant => '對方';

  @override
  String get ui3ShareSelected => '分享所選';

  @override
  String get ui3BotCommandError => '指令錯誤';

  @override
  String get ui3BotUnknownCommand => '未知指令';

  @override
  String get ui3BotTypeHelp => '輸入 /help 查看可用指令。';

  @override
  String get ui3FilesMediaLinks => '檔案、媒體和連結';

  @override
  String get ui3ChatStorage => '聊天儲存空間';

  @override
  String get ui3EncryptionKeysDevices => '加密金鑰和裝置';

  @override
  String get ui3EncryptionServiceUnavailable => '加密服務暫不可用';

  @override
  String get ui3ExportLoadingHistory => '正在載入更多聊天記錄以供匯出…';

  @override
  String get ui3ExportTxtDesc => '純文字記錄，可用於筆記、備份或合規審查';

  @override
  String get ui3ExportCustomRange => '自訂範圍';

  @override
  String get ui3ExportStart => '開始';

  @override
  String get ui3ExportEnd => '結束';

  @override
  String get ui3ExportSelectDate => '選擇日期';

  @override
  String get ui3FolderFilterUnreadOnly => '僅未讀';

  @override
  String get ui3FolderFilterMutedOnly => '僅勿擾';

  @override
  String get ui3FolderFilterNoDms => '不含私訊';

  @override
  String get ui3FolderFilterNoGroups => '不含群組';

  @override
  String get ui3FolderFilterNoChannels => '不含頻道';

  @override
  String get ui3FolderFilterAllChats => '全部聊天';

  @override
  String get ui3Create => '建立';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return '刪除資料夾「$name」？';
  }

  @override
  String get a11yDecreaseTextSize => '縮小字級';

  @override
  String get a11yIncreaseTextSize => '放大字級';

  @override
  String ui3MinutesRead(int minutes) {
    return '閱讀約 $minutes 分鐘';
  }

  @override
  String get ui3TipOnChain => '已上鏈 ✓';

  @override
  String get ui3ViewSource => '檢視原始碼';

  @override
  String get a11yPreviousPage => '上一頁';

  @override
  String get a11yNextPage => '下一頁';

  @override
  String get ui3OpenExternalLinkTitle => '開啟外部連結？';

  @override
  String get ui3Open => '開啟';

  @override
  String get ui3UnableToOpenLink => '無法開啟此連結。';

  @override
  String get ui3ImageUnavailable => '圖片無法使用';

  @override
  String ui3LoadImageFrom(Object host) {
    return '從 $host 載入圖片';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return '重新從 $host 載入圖片';
  }

  @override
  String get ui3TranslatedByN42 => '由 N42 翻譯';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return '由 N42 從$language翻譯';
  }

  @override
  String get ui3ClearWhiteboardTitle => '清空白板？';

  @override
  String get ui3ClearWhiteboardMessage => '所有人的筆跡都將被清除，且無法復原。';

  @override
  String get ui3WhiteboardLive => '白板 · 即時';

  @override
  String get a11yPenColor => '畫筆顏色';

  @override
  String get ui3AiDescribeOcr => 'AI 識圖 / 文字辨識';

  @override
  String get ui3DocumentPreviewFailed => '無法安全預覽此文件。請檢查網路連線與檔案大小（最大 2MB）。';

  @override
  String get ui3AiConsentMessage => '選擇 AI 可用於本次摘要的訊息。此單次授權兩分鐘後失效，不允許付款或匯出。';

  @override
  String get ui3AiSuggestedReplies => '建議回覆';

  @override
  String get ui3AiGeneratingSuggestions => '正在產生建議…';

  @override
  String get ui3StickersEmpty => '還沒有貼圖';

  @override
  String get ui3StickersGet => '取得貼圖';

  @override
  String get a11yFormatBold => '粗體';

  @override
  String get a11yFormatItalic => '斜體';

  @override
  String get a11yFormatStrikethrough => '刪除線';

  @override
  String get a11yFormatInlineCode => '行內程式碼';

  @override
  String get a11yFormatCodeBlock => '程式碼區塊';

  @override
  String get a11yFormatChecklistItem => '待辦事項';

  @override
  String get a11yFormatBulletList => '項目符號清單';

  @override
  String get a11yFormatNumberedList => '編號清單';

  @override
  String get a11yFormatLink => '連結';

  @override
  String get a11yFormatTable => '表格';

  @override
  String get a11yFormatMeetingTemplate => '會議範本';

  @override
  String get a11yEmojiSmileys => '表情與人物';

  @override
  String get a11yEmojiHearts => '愛心';

  @override
  String get a11yEmojiAnimals => '動物與自然';

  @override
  String get a11yEmojiFood => '食物與飲料';

  @override
  String get a11yEmojiTravel => '旅行與地點';

  @override
  String get a11yEmojiActivities => '活動';

  @override
  String get a11yEmojiObjects => '物品';

  @override
  String get a11yEmojiSymbols => '符號';

  @override
  String get ui3FrequentlyUsed => '常用';

  @override
  String get ui3NoEditHistory => '暫無編輯記錄';

  @override
  String get ui3EventNew => '新增行程';

  @override
  String get ui3EventTitleLabel => '標題';

  @override
  String get ui3EventLocationOptional => '地點（選填）';

  @override
  String get ui3EventDescriptionOptional => '描述（選填）';

  @override
  String get ui3EventSend => '傳送行程';

  @override
  String get ui3EventTitleRequired => '請輸入標題';

  @override
  String get ui3EventEndAfterStart => '結束時間必須晚於開始時間';

  @override
  String get ui3MiniAppAgentIntro => '描述你想做的事，我會為你開啟合適的小程式。';

  @override
  String get ui3MiniAppAgentExample => '例如：把 ETH 兌換成 USDC';

  @override
  String get ui3MiniAppAgentNoMatch => '找不到相符的小程式，請換個說法試試。';

  @override
  String ui3MiniAppOpen(Object appName) {
    return '開啟$appName';
  }

  @override
  String get ui3MusicLinkPlatforms => '支援網易雲、QQ音樂、酷狗、酷我等平台的歌曲連結';

  @override
  String get ui3PollMarkCorrectAnswer => '請為非空選項標記正確答案';

  @override
  String get ui3PollQuizMode => '測驗模式';

  @override
  String get ui3PollAnswerExplanationHint => '答案解析（選填）';

  @override
  String get a11yCorrectAnswer => '正確答案';

  @override
  String get ui3AiSuggestions => 'AI 建議';

  @override
  String get a11yPaste => '貼上';

  @override
  String get a11yRefresh => '重新整理';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      '請妥善保管此金鑰。如果您無法存取所有裝置，這是復原加密訊息的唯一方式。';

  @override
  String ui3SavedToPath(Object path) {
    return '已儲存：$path';
  }

  @override
  String get ui3UnknownAccount => '未知帳號';

  @override
  String get ui3UnknownHomeserver => '未知伺服器';

  @override
  String get ui3ImportRecoveryKey => '匯入復原金鑰';

  @override
  String get ui3ImportRecoveryKeyDesc => '輸入或貼上復原金鑰，以復原加密訊息記錄的聊天室金鑰。';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return '帳號：$account\\n伺服器：$homeserver';
  }

  @override
  String get ui3Import => '匯入';

  @override
  String get ui3InvalidRecoveryKeyFormat => '復原金鑰格式無效';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return '已復原 $restored/$total 個金鑰，$failed 個失敗。請檢查帳號、網路和備份後重試。部分歷史訊息可能仍無法讀取。';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return '已成功復原 $restored/$total 個金鑰';
  }

  @override
  String ui3ImportFailed(Object error) {
    return '匯入失敗：$error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return '通行金鑰註冊失敗：$error';
  }

  @override
  String get ui3PasskeyDefaultName => '我的通行金鑰';

  @override
  String get ui3PasskeyNameHint => '例如：iPhone、MacBook';

  @override
  String get ui3PasskeyDeleteFailed => '刪除通行金鑰失敗';

  @override
  String get ui3TwoFactorAuth => '兩步驟驗證';

  @override
  String get ui3TwoFactorOnSubtitle => '已開啟 — 需要驗證器 App 的驗證碼';

  @override
  String get ui3TwoFactorOffSubtitle => '已關閉 — 使用驗證器 App（TOTP）保護';

  @override
  String get ui3ShowRecoveryKey => '顯示復原金鑰';

  @override
  String get ui3ShowRecoveryKeyDesc => '顯示復原金鑰以便備份';

  @override
  String get ui3ImportRecoveryKeyHint => '使用復原金鑰復原訊息';

  @override
  String get ui3RecoveryKeyCreateFailed => '建立復原金鑰失敗';

  @override
  String get ui3TotpIncorrectCode => '驗證碼錯誤，請重試';

  @override
  String get ui3TwoFactorEnabled => '兩步驟驗證已開啟';

  @override
  String get ui3TwoFactorDisabled => '兩步驟驗證已關閉';

  @override
  String get ui3TwoFactorTurnOffTitle => '關閉兩步驟驗證？';

  @override
  String get ui3TwoFactorTurnOffMessage => '將不再需要驗證器 App。之後可以使用新金鑰重新設定。';

  @override
  String get ui3TurnOff => '關閉';

  @override
  String get ui3TwoFactorTotpTitle => '兩步驟驗證（TOTP）';

  @override
  String get ui3TwoFactorIsOn => '兩步驟驗證已開啟';

  @override
  String get ui3TwoFactorCodeRequired => '需要驗證器 App 產生的驗證碼。';

  @override
  String get ui3TotpStepScan =>
      '1. 使用驗證器 App（Google Authenticator、Authy、1Password 等）掃描此 QR 碼，或手動輸入金鑰。';

  @override
  String get ui3TotpKeyCopied => '金鑰已複製';

  @override
  String get ui3TotpStepConfirm => '2. 輸入 6 位數驗證碼以確認。';

  @override
  String get ui3Enable => '開啟';

  @override
  String get ui3BackupSettingsDesc => '備份本機聊天設定。重新登入後將從伺服器復原訊息。';

  @override
  String get ui3BackupKeysSeparate => '加密金鑰另行管理';

  @override
  String get ui3BackupKeysSeparateHint => '請在「安全性 > 復原金鑰」中備份加密訊息的存取權限。';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return '$rooms 個聊天室  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      '從其他裝置或先前的備份匯入 .n42backup 檔案。加密金鑰需使用復原金鑰另行復原。';

  @override
  String get ui3UsernameSessionRequired => '設定使用者名稱需要有效的登入工作階段';

  @override
  String get ui3SecuritySessionRequired => '安全性設定需要有效的登入工作階段';

  @override
  String get ui3ConnectedAccountsSessionRequired => '關聯帳號需要有效的登入工作階段';

  @override
  String get ui3SystemAccounts => '系統與帳號';

  @override
  String get ui3AccountIdentity => '帳號與身分';

  @override
  String get ui3Accounts => '帳號';

  @override
  String get ui3DevicesSessions => '裝置與工作階段';

  @override
  String get ui3Integrations => '整合';

  @override
  String get ui3ConnectedAccounts => '關聯帳號';

  @override
  String get ui3ConnectedAccountsDesc => 'Telegram、WhatsApp、Discord 及 API 橋接整合';

  @override
  String get ui3SystemOverview => '系統概覽';

  @override
  String ui3AccountCount(num count) {
    return '$count 個帳號';
  }

  @override
  String ui3DeviceCount(num count) {
    return '$count 台裝置';
  }

  @override
  String get ui3PrivacySecurityOverview => '端對端加密、螢幕截圖保護和代理控制';

  @override
  String get ui3ConversationPrivacy => '對話隱私';

  @override
  String get ui3NetworkPrivacy => '網路隱私';

  @override
  String get ui3IdentityPrivacy => '身分隱私';

  @override
  String get ui3EncryptionKeyBackup => '加密與金鑰備份';

  @override
  String get ui3DevicesVerification => '裝置與驗證';

  @override
  String get ui3ChipE2eeDefault => '預設端對端加密';

  @override
  String get ui3ChipManualE2ee => '手動端對端加密';

  @override
  String get ui3ChipSelfDestruct => '閱後即焚';

  @override
  String get ui3ChipScreenshotGuard => '螢幕截圖保護';

  @override
  String get ui3ChipIpProxy => 'IP / 代理';

  @override
  String get ui3ChipLinkPreviewsOff => '連結預覽已關閉';

  @override
  String get ui3ChipPublicHandle => '公開使用者名稱';

  @override
  String get a11yShowPassword => '顯示密碼';

  @override
  String get a11yHidePassword => '隱藏密碼';

  @override
  String get a11yCheckServer => '檢查伺服器';

  @override
  String get ui3AuthAnonymousRegistration => '匿名註冊';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      '無需綁定手機號碼或電子郵件即可建立帳號，系統將自動產生使用者名稱。';

  @override
  String get ui3AuthAnonymousModeOn => '已開啟匿名模式';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      '應用程式將為你建立一個隨機的 Matrix 使用者名稱。之後你仍可使用產生的帳號和密碼登入。';

  @override
  String get ui3AuthChooseLoginMethod => '選擇登入方式';

  @override
  String get ui3AuthSsoOpenFailed => '無法開啟 SSO 登入頁面';

  @override
  String get ui3AuthWalletUnavailable => '錢包無法使用';

  @override
  String get ui3ProfileSubscriptions => '訂閱';

  @override
  String get ui3ProfileBuySellCrypto => '買賣加密貨幣';

  @override
  String get ui3ProfileOnDeviceAi => '裝置端 AI';

  @override
  String get ui3ProfileSetAUsername => '設定使用者名稱';

  @override
  String get ui3ProfileAvatarStudio => '頭像工作室';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'NFT 頭像 / 裝飾';

  @override
  String get ui3ProfileCustomize => '自訂';

  @override
  String get ui3ProfileQrSubtitle => '掃描以查看此個人資料或開始聊天';

  @override
  String get ui3PrivacyHardening => '隱私強化';

  @override
  String get ui3HidePhoneNumber => '隱藏手機號碼';

  @override
  String get ui3HidePhoneNumberDesc => '在本裝置的個人資料相關頁面中遮蓋已綁定的手機號碼';

  @override
  String get ui3EncryptNewChatsByDefault => '預設加密新聊天';

  @override
  String get ui3EncryptNewChatsByDefaultDesc => '新建單聊和私密群組時預設啟用端對端加密';

  @override
  String get ui3PrivateChatMode => '私密聊天模式';

  @override
  String get ui3PrivateChatModeDesc => '檢視私密或加密聊天時暫時啟用防截圖';

  @override
  String get ui3DefaultSelfDestructTimer => '預設閱後即焚時長';

  @override
  String get ui3DefaultSelfDestructTimerDesc => '為新傳送的訊息套用預設閱後即焚時長';

  @override
  String get ui3LinkPreviews => '連結預覽';

  @override
  String get ui3LinkPreviewsDesc => '訊息包含網址時擷取標題、描述和縮圖';

  @override
  String get ui3IpAddressProtection => 'IP 位址保護';

  @override
  String get ui3IpAddressProtectionDesc =>
      '可用時透過你設定的 HTTP 隱私代理轉送 Matrix 和連結預覽請求';

  @override
  String get ui3UseTorProxy => '使用 Tor / Privoxy HTTP 代理';

  @override
  String get ui3UseTorProxyDesc =>
      '使用本機 HTTP 代理端點，例如 127.0.0.1:8118 上的 Privoxy。此處不支援原生 SOCKS5 Tor 路由。';

  @override
  String get ui3CustomProxy => '自訂代理';

  @override
  String get ui3CustomProxyDesc => '為 Matrix 流量和連結預覽使用自訂 HTTP 或 HTTPS 代理';

  @override
  String get ui3ProxyEndpoint => '代理位址';

  @override
  String get ui3ProxyEndpointDesc => 'HTTP/HTTPS 代理位址（不支援 SOCKS）';

  @override
  String get ui3InvalidEndpoint => '位址無效';

  @override
  String get ui3CustomProxyStaysOff => '設定有效位址前，自訂代理保持關閉';

  @override
  String get ui3NotificationFilterNote => '優先規則一律通知（略過靜音、僅提及和勿擾）。封鎖關鍵字會抑制通知。';

  @override
  String get ui3PriorityKeywords => '優先關鍵字';

  @override
  String get ui3PriorityKeywordHint => '例如：緊急';

  @override
  String get ui3MutedKeywords => '封鎖關鍵字';

  @override
  String get ui3MutedKeywordHint => '例如：廣告';

  @override
  String get ui3PrioritySenders => '優先傳送者';

  @override
  String get ui3CaseSensitive => '區分大小寫';

  @override
  String get ui3None => '無';

  @override
  String get ui3SmartReplyTranslation => '智慧回覆翻譯';

  @override
  String get ui3SmartReplyTranslationDesc => '傳送前自動將你的訊息翻譯為對方的語言。';

  @override
  String get ui3FromPhotos => '來自相簿';

  @override
  String get ui3ChangePhoto => '更換照片';

  @override
  String get ui3RoamingUsesMobileData => '漫遊沿用行動數據規則';

  @override
  String get ui3RoamingUsesMobileDataDesc => '暫不支援單獨偵測漫遊，因此漫遊時沿用行動數據的自動下載設定。';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return '刪除「$content」？';
  }

  @override
  String get ui3ResetToDefaults => '恢復預設';

  @override
  String get ui3ResetQuickRepliesMessage => '這將刪除所有自訂快速回覆並恢復預設，是否繼續？';

  @override
  String get ui3LocalLlmUnavailable => '此裝置不支援';

  @override
  String get ui3LocalLlmNotDownloaded => '模型未下載';

  @override
  String get ui3LocalLlmReady => '已就緒（裝置端）';

  @override
  String get ui3LocalLlmDescription =>
      '啟用並就緒後，AI 功能（摘要、改寫、翻譯、回覆）完全在裝置上執行，資料不會離開你的手機；否則使用雲端服務。';

  @override
  String get ui3UseOnDeviceAi => '使用裝置端 AI';

  @override
  String get ui3UseOnDeviceAiDesc => '就緒時優先本機推論';

  @override
  String get ui3DownloadModel => '下載模型';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      '裝置端推論需要原生執行環境（Android MediaPipe / iOS Core ML），平台處理程式可用後將自動啟用。';

  @override
  String get ui3PhotoAvatar => '照片頭像';

  @override
  String get ui3AvatarStyles => '頭像樣式';

  @override
  String get ui3AvatarStylesDesc => '個人資料與頭像入口共用同一套裝飾樣式。';

  @override
  String get ui3ReplaceNftAvatar => '更換 NFT 頭像';

  @override
  String get ui3NftAvatarDesc => '使用鏈上藏品作為頭像。';

  @override
  String get ui3UsePhotoAvatar => '使用照片頭像';

  @override
  String get ui3UsePhotoAvatarDesc => '保留已上傳的頭像並解除 NFT 綁定。';

  @override
  String ui3AvatarStyleSet(Object name) {
    return '頭像樣式已設為：$name';
  }

  @override
  String get ui3NftAvatarUpdated => 'NFT 頭像已更新';

  @override
  String get ui3SwitchedToPhotoAvatar => '已切換回照片頭像';

  @override
  String get ui3SignInToViewRedPacketHistory => '登入後查看紅包記錄';

  @override
  String get ui3RedPacketActive => '進行中';

  @override
  String get ui3RedPacketCompleted => '已領完';

  @override
  String get ui3CardsAndPasses => '卡券與通行證';

  @override
  String get ui3CardsAndPassesDesc => '錢包卡片、優惠券和通行證由主應用管理。';

  @override
  String get ui3CardPackRequiresMainApp => '卡包需要在主應用中使用';

  @override
  String get ui3OpenCardPack => '打開卡包';

  @override
  String get ui3UnableToOpenChat => '無法與該聯絡人開啟聊天';

  @override
  String get ui3WalletManagedInMainApp => '錢包由主應用管理';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · 訂閱方案';
  }

  @override
  String get ui3NewPlan => '新增方案';

  @override
  String get ui3MySubscriptions => '我的訂閱';

  @override
  String get ui3AvailablePlans => '可用方案';

  @override
  String get ui3NoPlansYet => '尚無方案 · 點按「新增方案」建立';

  @override
  String ui3DaysLeft(Object days) {
    return '剩餘 $days 天';
  }

  @override
  String get ui3SubscriptionCancelled => '已取消';

  @override
  String get ui3AutoRenewOn => '自動續訂：開';

  @override
  String get ui3AutoRenewOff => '自動續訂：關';

  @override
  String get ui3CancelSubscriptionTitle => '取消訂閱？';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return '你對 $name 的訂閱將維持有效至到期，之後不再續訂。';
  }

  @override
  String get ui3Subscribe => '訂閱';

  @override
  String ui3SubscribedTo(Object name) {
    return '已訂閱 $name';
  }

  @override
  String get ui3PlanPriceLabel => '價格（例如 9.9 USDT）';

  @override
  String get ui3PlanDescriptionLabel => '描述（選填）';

  @override
  String get ui3PlanBenefitsLabel => '權益（以逗號分隔）';

  @override
  String get ui3PlanPeriod => '週期：';

  @override
  String get ui3Monthly => '按月';

  @override
  String get ui3Yearly => '按年';

  @override
  String get ui3SaveRemarkFailed => '備註儲存失敗';

  @override
  String get ui3CopyLink => '複製連結';

  @override
  String get ui3Connect => '連接';

  @override
  String get ui3CommonTokens => '共同代幣';

  @override
  String get ui3SharedNfts => '共同 NFT';

  @override
  String get ui3TransactionHistory => '交易紀錄';

  @override
  String get ui3CommonDaos => '共同 DAO';

  @override
  String get ui3SameChains => '相同鏈';

  @override
  String get ui3ChatInitFailed => '聊天初始化失敗';

  @override
  String get ui3CheckNetworkRetry => '請檢查網路後重試';

  @override
  String get ui3FromContacts => '從通訊錄新增';

  @override
  String get ui3FindFriendsFromContacts => '從手機通訊錄尋找好友';

  @override
  String get ui3EnsOrDomain => 'ENS / 網域';

  @override
  String get ui3LoadingContacts => '正在載入通訊錄...';

  @override
  String get ui3ContactsPermissionRequired => '需要通訊錄權限';

  @override
  String get ui3ContactsPermissionMessage => '如需從通訊錄尋找好友，請允許存取通訊錄。';

  @override
  String get ui3AllowAccess => '允許存取';

  @override
  String get ui3NoContactMatches => '找不到相符項目';

  @override
  String get ui3NoContactMatchesMessage => '你的通訊錄聯絡人尚未使用此應用程式，邀請他們加入吧！';

  @override
  String ui3ScannedContacts(Object count) {
    return '已掃描 $count 位聯絡人';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return '在通訊錄中找到 $count 個相符項目';
  }

  @override
  String ui3InContactsAs(Object name) {
    return '通訊錄中：$name';
  }

  @override
  String get ui3DeletePhotoConfirm => '刪除這張照片？';

  @override
  String get ui3InviteLink => '邀請連結';

  @override
  String get ui3ShareJoinLink => '分享此群組的加入連結';

  @override
  String get ui3ShareRoomReference => '向受邀成員分享群組參照';

  @override
  String get ui3ScanToJoinGroup => '掃碼直接加入此群組';

  @override
  String get ui3ScanToShareRoomReference => '掃碼向受邀成員分享群組參照';

  @override
  String get ui3InviteLinkLoadFailed => '邀請連結載入失敗';

  @override
  String get ui3InviteLinkCopied => '邀請連結已複製';

  @override
  String get ui3ChannelCategoryOptional => '分類（選填）';

  @override
  String get ui3ChannelCategoryHint => '公告 / 產品 / 支援';

  @override
  String get ui3DescriptionOptional => '描述（選填）';

  @override
  String get ui3WebhookEnable => '啟用 Webhook 自動化';

  @override
  String get ui3WebhookEnableDesc => '將成員加入和歡迎事件推送到你的整合端點。';

  @override
  String get ui3WebhookUrl => 'Webhook 網址';

  @override
  String get ui3WebhookSecretOptional => '簽章密鑰（選填）';

  @override
  String get ui3WebhookSecretHint => '用於 X-N42-Signature';

  @override
  String get ui3WebhookNotifyMemberJoined => '成員加入時通知';

  @override
  String get ui3WebhookNotifyWelcomeSent => '傳送歡迎語時通知';

  @override
  String get ui3WebhookTestSend => '傳送測試 Webhook';

  @override
  String get ui3WebhookTestSending => '正在傳送測試 Webhook...';

  @override
  String get ui3WebhookTestSent => '測試 Webhook 傳送成功';

  @override
  String get ui3WebhookTestFailed => '測試 Webhook 傳送失敗';

  @override
  String get ui3WebhookUrlInvalid => 'Webhook 網址必須是公開的 HTTPS 位址';

  @override
  String get ui3WebhookSelectEvent => '請至少選擇一個 Webhook 事件';

  @override
  String get ui3SensitiveDataDetection => '敏感資訊偵測';

  @override
  String get ui3Email => '電子郵件';

  @override
  String get ui3CreditCard => '信用卡';

  @override
  String get ui3DetectEmailDesc => '偵測文字訊息中的電子郵件地址';

  @override
  String get ui3DetectPhoneDesc => '偵測手機號碼與國際號碼';

  @override
  String get ui3DetectCardDesc => '偵測疑似銀行卡號';

  @override
  String get ui3DetectWalletDesc => '偵測以太坊格式的錢包地址';

  @override
  String get ui3GeneralTopic => '綜合';

  @override
  String get a11yPreviousResult => '上一個結果';

  @override
  String get a11yNextResult => '下一個結果';

  @override
  String get ui3TryDifferentKeywords => '試試其他關鍵字';

  @override
  String ui3FiltersActive(Object count) {
    return '已啟用篩選：$count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return '已啟用訊息篩選：$count';
  }

  @override
  String get ui3LoadMore => '載入更多';

  @override
  String get ui3MessageFilters => '訊息篩選';

  @override
  String get ui3SenderUserId => '傳送者使用者 ID';

  @override
  String get ui3FilterType => '類型';

  @override
  String get ui3FilterAny => '全部';

  @override
  String get ui3FilterImage => '圖片';

  @override
  String get ui3FilterTime => '時間';

  @override
  String get ui3AnyTime => '不限時間';

  @override
  String get ui3OnlyMyMessages => '僅我的訊息';

  @override
  String get ui3MediaOnly => '僅媒體';

  @override
  String get ui3Apply => '套用';

  @override
  String get ui3QrStyleClassic => '經典';

  @override
  String get ui3QrStyleOcean => '海洋';

  @override
  String get ui3QrStyleBerry => '莓果';

  @override
  String get a11yFlashlightOn => '開啟手電筒';

  @override
  String get a11yFlashlightOff => '關閉手電筒';

  @override
  String get ui3SocialGraph => '社交圖譜';

  @override
  String get ui3RecommendedConnections => '推薦連結';

  @override
  String get ui3Portfolio => '資產組合';

  @override
  String get ui3Chains => '鏈';

  @override
  String get ui3Tokens => '代幣';

  @override
  String get ui3NoConnectionsFound => '暫無連結';

  @override
  String get ui3ConnectionsHint => '隨著你的鏈上活動增加，連結會逐漸出現';

  @override
  String get ui3SocialGraphLoadFailed => '社交圖譜載入失敗';

  @override
  String get ui3Similarity => '相似度';

  @override
  String get ui3Breakdown => '明細';

  @override
  String get ui3TokenHoldings => '代幣持倉';

  @override
  String get ui3NftCollections => 'NFT 系列';

  @override
  String get ui3ChainUsage => '鏈使用';

  @override
  String get ui3Transactions => '交易';

  @override
  String get ui3DaoMembership => 'DAO 成員資格';

  @override
  String get ui3NotWeighted => '不計權重';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent%（權重：$weight）';
  }

  @override
  String get ui3CommonOnChainActivity => '共同鏈上活動';

  @override
  String get ui3SharedTokens => '共同代幣';

  @override
  String get ui3SharedNftCollections => '共同 NFT 系列';

  @override
  String get ui3SharedChains => '共同鏈';

  @override
  String get ui3NoSharedTokens => '未發現共同代幣';

  @override
  String get ui3NoSharedNftCollections => '未發現共同 NFT 系列';

  @override
  String get ui3NoSharedChains => '未發現共同鏈';

  @override
  String get ui3SimilarityFailed => '相似度計算失敗';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items 等另外 $count 項';
  }

  @override
  String get a11yGovernance => '治理';

  @override
  String get ui3CommunityLink => '社群連結';

  @override
  String get ui3CommunityQrCode => '社群 QR 碼';

  @override
  String get ui3CommunityQrSubtitle => '掃碼加入此社群並瀏覽其頻道';

  @override
  String get ui3CommunityLinkLoadFailed => '社群連結載入失敗';

  @override
  String get ui3CommunityLinkCopied => '社群連結已複製';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name 將被移出此社群。';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name 將被移出且無法重新加入。';
  }

  @override
  String get ui3SignInToDiscoverChannels => '登入後即可探索公開頻道';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return '無法加入 $name：$error';
  }

  @override
  String get ui3CategoryTech => '科技';

  @override
  String get ui3CategorySocial => '社交';

  @override
  String get ui3NoPublicChannels => '找不到公開頻道';

  @override
  String get ui3StoriesAndFun => '故事與趣味';

  @override
  String get ui3SearchMusicHint => '搜尋歌曲、藝人或好友';

  @override
  String get ui3ForYou => '為你推薦';

  @override
  String get ui3Liked => '已喜歡';

  @override
  String get ui3NoLikedMusic => '還沒有喜歡的音樂';

  @override
  String get ui3NoMusicStories => '還沒有音樂動態';

  @override
  String get ui3LikedMusicHint => '點擊歌曲旁的愛心即可收藏到這裡。';

  @override
  String get ui3MusicStoriesHint => '動態中分享的音樂會顯示在這裡。';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · 由 $name 分享';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return '無法播放 $title：$error';
  }

  @override
  String get a11yPreviousTrack => '上一首';

  @override
  String get a11yNextTrack => '下一首';

  @override
  String get a11yPlay => '播放';

  @override
  String get a11yPause => '暫停';

  @override
  String get ui3Refresh => '重新整理';

  @override
  String get ui3NearbyIntroTitle => '探索附近的公開動態';

  @override
  String get ui3NearbyIntroBody => '你的位置僅在本裝置上使用一次，用於排序公開動態，不會上傳、廣播或顯示給他人。';

  @override
  String get ui3UseMyLocation => '使用我的位置';

  @override
  String get ui3NearbyUnavailable => '附近功能無法使用';

  @override
  String get ui3NoNearbyPosts => '附近暫無動態';

  @override
  String get ui3NoNearbyPostsHint => '帶位置的公開動態會顯示在這裡。';

  @override
  String get ui3NearbyDistanceNote => '大致距離 · 僅顯示公開的位置動態';

  @override
  String get ui3PublicLocationPost => '公開位置動態';

  @override
  String get ui3LocationServicesOff => '定位服務已關閉';

  @override
  String get ui3LocationPermissionDenied => '定位權限遭拒';

  @override
  String get ui3EnableLocationInSettings => '請在系統設定中開啟定位權限';

  @override
  String get ui3CreateStory => '發佈限時動態';

  @override
  String get ui3CreateStoryDesc => '發佈文字或照片狀態。';

  @override
  String get ui3StoryCamera => '限時動態相機';

  @override
  String get ui3StoryCameraDesc => '直接進入濾鏡和照片編輯。';

  @override
  String get ui3MomentsDesc => '開啟完整動態和留言。';

  @override
  String get ui3MomentCamera => '動態相機';

  @override
  String get ui3MomentCameraDesc => '發佈貼文並立即選擇媒體。';

  @override
  String get ui3GamesDesc => '開啟內建休閒遊戲中心。';

  @override
  String get ui3AvatarStudio => '頭像工作室';

  @override
  String get ui3AvatarStudioDesc => '裝飾、NFT 頭像與身分標誌。';

  @override
  String get ui3SocialGraphDesc => '鏈上追蹤、粉絲與連結。';

  @override
  String get ui3SocialHubHeroTitle => '限時動態、動態、遊戲和頭像';

  @override
  String get ui3SocialHubHeroBody => '統一使用現有社交功能，而不是把入口分散在聊天、個人資料和探索中。';

  @override
  String get ui3SocialGraphNotConfigured => '此版本未設定社交圖譜';

  @override
  String get ui3ConnectWalletForSocialGraph => '連接錢包以查看你的社交圖譜';

  @override
  String get ui3AvatarStudioSignIn => '頭像工作室需要登入';

  @override
  String get a11yRemoveImage => '移除圖片';

  @override
  String get a11yBack => '返回';

  @override
  String get ui3MiniAppConfirmTransactionTitle => '確認交易';

  @override
  String get ui3MiniAppConfirmTransactionBody => '小程式正在請求代表你發送一筆交易。';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return '開啟 $name？';
  }

  @override
  String get ui3MiniAppOpenButton => '開啟';

  @override
  String get ui3StoryReplySendFailed => '限時動態回覆傳送失敗';

  @override
  String get ui3RedPacketDemoNotice => '示範紅包——僅為聊天內紀錄，不會轉移真實的鏈上資產。';

  @override
  String get ui3RedPacketCoverClassic => '經典紅';

  @override
  String get ui3RedPacketCoverGolden => '金色';

  @override
  String get ui3RedPacketCoverPurple => '紫色';

  @override
  String get ui3RedPacketCoverOceanBlue => '海洋藍';

  @override
  String get ui3RedPacketCoverNatureGreen => '自然綠';

  @override
  String get ui3RedPacketCoverRosePink => '玫瑰粉';

  @override
  String get ui3RedPacketHistoryEmpty => '尚無紅包';

  @override
  String get ui3TransferMerchantQrWithAmount => '商戶收款碼（含金額）';

  @override
  String get ui3TransferMerchantQrTitle => '商戶收款碼';

  @override
  String get ui3TransferOpenAmountHint => '留空則不限金額';

  @override
  String get ui3FiatRampTitle => '買入 / 賣出加密貨幣';

  @override
  String get ui3FiatRampBuy => '買入';

  @override
  String get ui3FiatRampSell => '賣出';

  @override
  String get ui3FiatRampNotConfigured => '未設定法幣出入金通道';

  @override
  String get a11yPointsAddRule => '新增獎勵規則';

  @override
  String get a11yGovernanceRemoveChoice => '移除選項';

  @override
  String get a11yGovernanceCreateProposal => '建立提案';

  @override
  String get ui3MiniAppUpdateN42 => '更新 N42';

  @override
  String get ui3MiniAppOfficial => '官方';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count 位使用者';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return '背景顏色 $index';
  }

  @override
  String get a11yStoryAdd => '新增限時動態';

  @override
  String get ui3StoryPostFailed => '發佈限時動態失敗';

  @override
  String get ui3StoryTapToSelectImage => '點擊選擇圖片';

  @override
  String get ui3StoryChangeImage => '更換';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return '無法讀取所選音樂：$error';
  }

  @override
  String get ui3StoryDeleteConfirm => '刪除這則限時動態？';

  @override
  String get ui3StoryDeleteFailed => '刪除限時動態失敗';

  @override
  String get ui3MomentCreateTitle => '發佈動態';

  @override
  String get ui3MomentContentHint => '這一刻的想法…';

  @override
  String get ui3MomentAddPhotos => '新增照片';

  @override
  String get ui3MomentAddLocation => '新增位置';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return '已選媒體（$count）';
  }

  @override
  String get ui3MomentClearAll => '全部清除';

  @override
  String get ui3MomentClearMediaConfirm => '移除所有已選的照片/影片？';

  @override
  String get ui3MomentVisibilityPublicDesc => '所有朋友可見';

  @override
  String get ui3MomentVisibilityPrivateDesc => '僅自己可見';

  @override
  String get ui3MomentVisibilityPartialDesc => '選擇誰可以看';

  @override
  String get ui3MomentVisibilityExcludedDesc => '不給指定朋友看';

  @override
  String get ui3MomentVideos => '影片';

  @override
  String get ui3MomentNoVideos => '暫無影片';

  @override
  String get a11yCallMinimize => '最小化';

  @override
  String get a11yCallGridView => '格狀檢視';

  @override
  String get a11yCallFocusView => '聚焦檢視';

  @override
  String get ui3CallTools => '通話工具';

  @override
  String get ui3CallMeetingTools => '會議工具';

  @override
  String get ui3CallToolsSubtitle => '無需離開通話即可調整音訊與視訊品質。';

  @override
  String get ui3CallAudioEnhancement => '音訊增強';

  @override
  String get ui3CallNoiseSuppression => '降噪';

  @override
  String get ui3CallNoiseSuppressionDesc => '減少鍵盤聲與背景雜音。';

  @override
  String get ui3CallEchoCancellation => '回音消除';

  @override
  String get ui3CallEchoCancellationDesc => '防止揚聲器聲音回傳到麥克風。';

  @override
  String get ui3CallAutoGainControl => '自動增益';

  @override
  String get ui3CallAutoGainControlDesc => '讓麥克風音量更穩定。';

  @override
  String get ui3CallVoiceIsolation => '增強人聲隔離';

  @override
  String get ui3CallVoiceIsolationDesc => '使用更強的降噪設定。';

  @override
  String get ui3CallVideoSection => '視訊';

  @override
  String get ui3CallBackgroundBlur => '背景模糊（測試版）';

  @override
  String get ui3CallBlurDescReady => '偏好已生效，實際模糊效果仍取決於視訊處理器的上線。';

  @override
  String get ui3CallBlurDescSaved => '模糊偏好已儲存，相機處理可用時將生效。';

  @override
  String get ui3CallBlurDescCameraOff => '背景處理可用後請開啟相機。';

  @override
  String get ui3CallRecordingSection => '錄製';

  @override
  String get ui3CallRecordingDesc => '需要伺服器端錄製服務後才能儲存錄音。';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return '更新通話設定失敗：$error';
  }

  @override
  String get ui3CallRecordingStarted => '已開始錄製';

  @override
  String get ui3VoiceRoomNotFound => '房間不存在';

  @override
  String get ui3VoiceRoomEndConfirm => '確定要結束這個語音房間嗎？';

  @override
  String get a11yGameMoveUp => '向上移動';

  @override
  String get a11yGameMoveDown => '向下移動';

  @override
  String get a11yGameMoveLeft => '向左移動';

  @override
  String get a11yGameMoveRight => '向右移動';

  @override
  String get a11yGameRotate => '旋轉';

  @override
  String get a11yGameDrop => '落下';

  @override
  String ui3StickerAddedCount(Object count) {
    return '已新增 $count 個貼圖';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return '新增失敗：$error';
  }

  @override
  String get ui3StickerRemoveTitle => '移除貼圖';

  @override
  String get ui3StickerRemoveConfirm => '要從貼圖包中移除此貼圖嗎？';

  @override
  String get ui3StickerRemoveFailed => '移除失敗';

  @override
  String get ui3StickerRenamePack => '重新命名貼圖包';

  @override
  String get ui3StickerPackName => '貼圖包名稱';

  @override
  String get ui3StickerRenameFailed => '重新命名失敗';

  @override
  String get ui3StickerDeletePack => '刪除貼圖包';

  @override
  String get ui3StickerThisPack => '此貼圖包';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return '要刪除「$name」及其所有貼圖嗎？此操作無法復原。';
  }

  @override
  String get ui3StickerDeleteFailed => '刪除失敗';

  @override
  String get ui3StickerPack => '貼圖包';

  @override
  String get ui3StickerAdding => '正在新增…';

  @override
  String get ui3StickerAddStickers => '新增貼圖';

  @override
  String get ui3StickerPackNotFound => '找不到貼圖包';

  @override
  String get ui3StickerEmptyHint => '點按「新增貼圖」上傳圖片';

  @override
  String get ui3StickerNewPack => '新增貼圖包';

  @override
  String get ui3StickerCreate => '建立';

  @override
  String get ui3StickerCreateFailed => '建立貼圖包失敗';

  @override
  String ui3StickerInstalled(Object name) {
    return '已新增「$name」';
  }

  @override
  String get ui3StickerRemovePackTitle => '移除貼圖包';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return '要從你的貼圖中移除「$name」嗎？';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return '已移除「$name」';
  }

  @override
  String get ui3StickerAiSticker => 'AI 貼圖';

  @override
  String get ui3StickerStoreTab => '商店';

  @override
  String get ui3StickerMyStickersTab => '我的貼圖';

  @override
  String get ui3StickerNoneFound => '找不到貼圖';

  @override
  String ui3StickerByAuthor(Object author) {
    return '作者：$author';
  }

  @override
  String get ui3StickerManage => '管理';

  @override
  String ui3StickerCount(Object count) {
    return '$count 個貼圖';
  }

  @override
  String get ui3StickerNoneInstalled => '尚未新增貼圖';

  @override
  String get ui3StickerGetFromStore => '前往商店取得貼圖';

  @override
  String get ui3StickerBrowseStore => '瀏覽商店';

  @override
  String get ui3StickerAddedToAi => '已新增至「AI 貼圖」';

  @override
  String get ui3StickerAddOneFailed => '新增貼圖失敗';

  @override
  String get ui3StickerPromptLabel => '描述你的貼圖';

  @override
  String get ui3StickerPromptHint => '例如：一隻戴墨鏡的開心橘貓';

  @override
  String get ui3StickerGenerating => '正在產生…';

  @override
  String get ui3StickerGenerate => '產生';

  @override
  String get ui3StickerAddToStickers => '新增至貼圖';

  @override
  String get ui3StickerGeneratingPreview => '正在產生你的貼圖…';

  @override
  String get ui3StickerGenerateEmpty => '描述一個貼圖，然後點按「產生」';
}
