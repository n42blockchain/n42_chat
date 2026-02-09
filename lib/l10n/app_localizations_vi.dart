// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class SVi extends S {
  SVi([String locale = 'vi']) : super(locale);

  @override
  String get commonRetry => 'Thu lai';

  @override
  String get commonUnknownUser => 'Nguoi dung khong xac dinh';

  @override
  String get transferWalletNotConnected => 'Vi chua ket noi';

  @override
  String get chatCallServiceNotInitialized => 'Dich vu goi chua khoi tao';

  @override
  String authLoginFailed(String error) {
    return 'Dang nhap that bai: $error';
  }

  @override
  String get chatCallBack => 'Goi lai';

  @override
  String get chatMissedVideoCall => 'Cuoc goi video nho';

  @override
  String get chatMissedVoiceCall => 'Cuoc goi thoai nho';

  @override
  String get chatCallNotAnswered => 'Không trả lời';

  @override
  String get chatCallDurationLabel => 'Thời lượng cuộc gọi';

  @override
  String get chatVoiceCallCancelled => 'Cuộc gọi thoại đã bị huỷ';

  @override
  String get chatVideoCallCancelled => 'Cuộc gọi video đã bị huỷ';

  @override
  String get commonImage => '[Hinh anh]';

  @override
  String get chatVideo => '[Video]';

  @override
  String get chatVoice => '[Tin nhan thoai]';

  @override
  String get commonFile => '[Tep]';

  @override
  String get chatLocation => '[Vi tri]';

  @override
  String get chatUnknownMessage => '[Tin nhan khong xac dinh]';

  @override
  String get commonDelete => 'Xoa';

  @override
  String get chatDeleteThisMessage => 'Xóa tin nhắn này?';

  @override
  String get chatMessageDeleted => 'Tin nhắn đã xóa';

  @override
  String get profileNotLoggedIn => 'Chua dang nhap';

  @override
  String get chatMyLocation => 'Vi tri cua toi';

  @override
  String get commonGroupChat => 'Chat nhom';

  @override
  String get commonSearch => 'Tim kiem';

  @override
  String get commonCancel => 'Huy';

  @override
  String get commonLoadFailed => 'Tai that bai';

  @override
  String get commonMessages => 'Tin nhan';

  @override
  String get commonContacts => 'Danh ba';

  @override
  String get commonMe => 'Toi';

  @override
  String get commonVoiceLoading =>
      'Dang tai tin nhan thoai, vui long thu lai sau';

  @override
  String get commonVoiceToTextFailed =>
      'Chuyen giong noi thanh van ban that bai';

  @override
  String get commonConvertToText => 'Chuyen thanh van ban';

  @override
  String get chatCopy => 'Sao chep';

  @override
  String get commonForward => 'Chuyen tiep';

  @override
  String get commonUnfavorite => 'Bo yeu thich';

  @override
  String get commonFavorite => 'Yeu thich';

  @override
  String get settingsResend => 'Gui lai';

  @override
  String get chatRecall => 'Thu hoi';

  @override
  String get commonQuote => 'Trich dan';

  @override
  String get commonRemind => 'Nhac nho';

  @override
  String get chatCopied => 'Da sao chep';

  @override
  String get storySendMessageHint => 'Gui tin nhan';

  @override
  String get commonMicrophonePermissionRequired =>
      'Vui long cap quyen truy cap micro';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return 'Bat dau ghi am that bai: $error';
  }

  @override
  String get commonRecordingTooShort => 'Ban ghi qua ngan';

  @override
  String commonStopRecordingFailed(String error) {
    return 'Dung ghi am that bai: $error';
  }

  @override
  String get chatReleaseToCancel => 'Tha de huy';

  @override
  String get chatReleaseToSend => 'Tha de gui, vuot len de huy';

  @override
  String get commonHoldToTalk => 'Giu de noi';

  @override
  String get commonSend => 'Gui';

  @override
  String get commonAddFriend => 'Them ban';

  @override
  String get commonChatServiceNotConnected => 'Dich vu chat chua ket noi';

  @override
  String contactUserNotFoundHint(String query) {
    return 'Khong tim thay nguoi dung \"$query\"\n\nGoi y:\n• Thu nhap day du ID nguoi dung, vi du @username:server.com\n• Kiem tra chinh ta ten nguoi dung';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Tao cuoc tro chuyen that bai: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Tim kiem that bai: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Nhap ID nguoi dung hoac ten dang nhap de tim kiem';

  @override
  String get contactSearching => 'Dang tim kiem...';

  @override
  String get contactSearchUserToChat => 'Tim nguoi dung de bat dau tro chuyen';

  @override
  String get contactMatrixIdExample =>
      'Ban co the nhap day du Matrix ID\nvi du @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'Khong tim thay nguoi dung \"$username\"';
  }

  @override
  String get commonChat => 'Tro chuyen';

  @override
  String get commonSettings => 'Cai dat';

  @override
  String get profileEditProfile => 'Chinh sua ho so';

  @override
  String get authLogin => 'Dang nhap';

  @override
  String get commonCreateGroup => 'Tao nhom';

  @override
  String get chatError => 'Loi';

  @override
  String get commonTransfer => 'Chuyen tien';

  @override
  String get commonReceived => 'Da nhan';

  @override
  String get commonRefunded => 'Da hoan tien';

  @override
  String get commonExpired => 'Het han';

  @override
  String get chatRedPacketGreeting => 'Chuc mung tot lanh';

  @override
  String get commonN42RedPacket => 'Li xi N42';

  @override
  String get commonClaimed => 'Da nhan';

  @override
  String get commonAllClaimed => 'Da nhan het';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => 'Tra loi';

  @override
  String get commonEdit => 'Chinh sua';

  @override
  String get chatSelectForwardTarget => 'Chon nguoi nhan';

  @override
  String commonSendCount(int count) {
    return 'Gui ($count)';
  }

  @override
  String contactN42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get profileN42IdTitle => 'N42 ID';

  @override
  String get profileN42Bean => 'N42 Bean';

  @override
  String get contactFriendInfo => 'Thong tin ban be';

  @override
  String get contactFriendInfoDesc =>
      'Them ghi chu, dien thoai, the, ghi nhan, anh cua ban be va cai dat quyen.';

  @override
  String get commonMoments => 'Khoang khac';

  @override
  String get commonSendMessage => 'Tin nhan';

  @override
  String get contactAudioVideoCall => 'Goi Am thanh/Video';

  @override
  String get contactVideoChannel => 'Kenh Video';

  @override
  String get contactRemark => 'Ghi chu';

  @override
  String get contactRemarkName => 'Ten ghi chu';

  @override
  String get contactPhone => 'Dien thoai';

  @override
  String get contactTags => 'The';

  @override
  String get contactNotes => 'Ghi chu';

  @override
  String get contactPhotos => 'Anh';

  @override
  String get contactPermissions => 'Quyen';

  @override
  String get contactChatMomentsEtc => 'Chat, Khoang khac, The thao, v.v.';

  @override
  String get contactMoreInfo => 'Thong tin them';

  @override
  String get contactCommonGroups => 'Nhom chung';

  @override
  String get contactSource => 'Nguon';

  @override
  String get settingsNotificationSettings => 'Thong bao';

  @override
  String get settingsPrivacy => 'Quyen rieng tu';

  @override
  String get settingsAppearance => 'Giao dien';

  @override
  String get settingsAbout => 'Gioi thieu';

  @override
  String get commonLogout => 'Dang xuat';

  @override
  String get commonLogoutConfirm => 'Ban co chac muon dang xuat?';

  @override
  String get commonSave => 'Luu';

  @override
  String get profileNickname => 'Biet danh';

  @override
  String get profileEnterNickname => 'Nhap biet danh';

  @override
  String get profileSignature => 'Chu ky';

  @override
  String get profileAddSignature => 'Them chu ky';

  @override
  String get commonTakePhoto => 'Chup anh';

  @override
  String get profileChooseFromGallery => 'Chon tu thu vien';

  @override
  String profileSaveFailed(String error) {
    return 'Luu that bai: $error';
  }

  @override
  String get authSecureDecentralizedChat => 'Nhan tin bao mat, phi tap trung';

  @override
  String get commonEndToEndEncryption => 'Ma hoa dau cuoi';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Chi ban va nguoi nhan moi xem duoc tin nhan';

  @override
  String get authDecentralized => 'Phi tap trung';

  @override
  String get authBasedOnMatrix => 'Xay dung tren giao thuc mo Matrix';

  @override
  String get authWalletIntegration => 'Tich hop Vi';

  @override
  String get authEasyCryptoTransfer => 'Chuyen tien dien tu de dang';

  @override
  String get authRegister => 'Dang ky';

  @override
  String get authAgreeTerms => 'Bang viec dang nhap, ban dong y voi';

  @override
  String get authTermsOfService => 'Dieu khoan Dich vu';

  @override
  String get authAnd => 'va';

  @override
  String get authPrivacyPolicy => 'Chinh sach Bao mat';

  @override
  String get authServerAddress => 'Dia chi May chu';

  @override
  String get authEnterServerAddress => 'Nhap dia chi may chu';

  @override
  String authConnectedTo(String serverName) {
    return 'Da ket noi toi $serverName';
  }

  @override
  String get authUsername => 'Ten dang nhap';

  @override
  String get authEnterUsername => 'Nhap ten dang nhap';

  @override
  String get authPassword => 'Mat khau';

  @override
  String get authEnterPassword => 'Nhap mat khau';

  @override
  String get authRegisterAccount => 'Dang ky';

  @override
  String get authForgotPassword => 'Quen mat khau';

  @override
  String get authOtherLoginMethods => 'Phuong thuc dang nhap khac';

  @override
  String get authCreateAccount => 'Tao tai khoan';

  @override
  String get authJoinN42Chat => 'Tham gia N42 Chat de bat dau tro chuyen';

  @override
  String get authUsernameHint => '3-20 ky tu, chu/so/_';

  @override
  String get authUsernameMinLength => 'Ten dang nhap phai co it nhat 3 ky tu';

  @override
  String get authUsernameMaxLength => 'Ten dang nhap toi da 20 ky tu';

  @override
  String get authUsernameFormat =>
      'Ten dang nhap chi co the chua chu, so va dau gach duoi';

  @override
  String get authPasswordHint => 'Toi thieu 8 ky tu';

  @override
  String get commonPasswordMinLength => 'Mat khau phai co it nhat 8 ky tu';

  @override
  String get authConfirmPassword => 'Xac nhan mat khau';

  @override
  String get authFilled => 'Da dien';

  @override
  String get authEnterInviteCode => 'Nhap ma moi';

  @override
  String get authAlreadyHaveAccount => 'Da co tai khoan?';

  @override
  String get authLoginNow => 'Dang nhap ngay';

  @override
  String get profileAvatar => 'Anh dai dien';

  @override
  String get profileStatus => 'Trang thai';

  @override
  String get commonLoading => 'Dang tai...';

  @override
  String get conversationNoConversations => 'Khong co cuoc tro chuyen';

  @override
  String get conversationTapToChat =>
      'Nhan vao goc tren ben phai de bat dau tro chuyen';

  @override
  String get conversationStartGroup => 'Bat dau Chat nhom';

  @override
  String get commonScan => 'Quet';

  @override
  String get commonPayment => 'Thanh toan';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature sap ra mat';
  }

  @override
  String get conversationMarkAsRead => 'Danh dau da doc';

  @override
  String get commonUnmute => 'Bo tat tieng';

  @override
  String get commonMute => 'Tat tieng';

  @override
  String get conversationUnpin => 'Bo ghim';

  @override
  String get conversationPin => 'Ghim';

  @override
  String get conversationDeleteConversation => 'Xoa cuoc tro chuyen';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return 'Xoa cuoc tro chuyen voi \"$name\"?';
  }

  @override
  String get commonNoContacts => 'Khong co lien he';

  @override
  String get contactAddFriendsToChat => 'Them ban de bat dau tro chuyen';

  @override
  String get contactNotFound => 'Khong tim thay lien he';

  @override
  String get contactTryOtherKeywords =>
      'Thu tu khoa khac hoac tim kiem toan cau';

  @override
  String get contactSearchResults => 'Ket qua tim kiem';

  @override
  String get contactNewFriends => 'Ban moi';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => 'Tai khoan chinh thuc';

  @override
  String get contactServiceAccounts => 'Tai khoan dich vu';

  @override
  String get contactEnterpriseContacts => 'Lien he doanh nghiep';

  @override
  String get contactRecommendToFriend => 'Chia se lien he';

  @override
  String get commonSetRemark => 'Dat ghi chu';

  @override
  String get contactSendingCard => 'Dang gui the lien he...';

  @override
  String get commonFileLabel => 'Tep';

  @override
  String get commonLocationLabel => 'Vi tri';

  @override
  String contactRecommendFailed(String error) {
    return 'Gioi thieu that bai: $error';
  }

  @override
  String get profileEnterRemark => 'Nhap ghi chu';

  @override
  String get contactOpeningChat => 'Dang mo tro chuyen...';

  @override
  String contactOpenChatFailed(String error) {
    return 'Mo tro chuyen that bai: $error';
  }

  @override
  String get contactAddContact => 'Them lien he';

  @override
  String get contactEnterUserId => 'Nhap ID nguoi dung';

  @override
  String get contactNoFriendRequests => 'Khong co yeu cau ket ban';

  @override
  String get commonAccept => 'Chap nhan';

  @override
  String get commonReject => 'Tu choi';

  @override
  String get commonNoGroups => 'Khong co nhom';

  @override
  String get contactSelectFriendToRecommend => 'Chon ban de gioi thieu';

  @override
  String get commonSearchContacts => 'Tim kiem lien he';

  @override
  String get contactNoContactsFound => 'Khong tim thay lien he';

  @override
  String get favoriteYesterday => 'Hom qua';

  @override
  String get chatJustNow => 'Vua xong';

  @override
  String get profileOnline => 'Truc tuyen';

  @override
  String get profileOffline => 'Ngoai tuyen';

  @override
  String get searchContactsGroupsMessages => 'Tim lien he, nhom, tin nhan';

  @override
  String get searchError => 'Loi tim kiem';

  @override
  String get chatSearchHint => 'Tim lien he, nhom va tin nhan';

  @override
  String get searchHistory => 'Lich su tim kiem';

  @override
  String get commonClear => 'Xoa';

  @override
  String get commonAll => 'Tat ca';

  @override
  String get searchGroups => 'Nhom';

  @override
  String get searchNoResults => 'Khong co ket qua';

  @override
  String commonGroupMembers(int count) {
    return 'Thanh vien ($count)';
  }

  @override
  String get groupMembersTitle => 'Thành viên nhóm';

  @override
  String get groupViewAll => 'Xem tat ca';

  @override
  String get groupOwner => 'Chu so huu';

  @override
  String get groupAdmin => 'Quan tri vien';

  @override
  String get groupInvite => 'Moi';

  @override
  String get commonGroupAnnouncement => 'Thong bao nhom';

  @override
  String get commonNotSet => 'Chua dat';

  @override
  String get groupDescription => 'Mo ta nhom';

  @override
  String get groupPublicGroup => 'Nhom cong khai';

  @override
  String get commonClearChatHistory => 'Xoa lich su tro chuyen';

  @override
  String get commonDissolveGroup => 'Giai tan nhom';

  @override
  String get commonLeaveGroup => 'Roi nhom';

  @override
  String get groupChangeGroupName => 'Doi ten nhom';

  @override
  String get commonEnterGroupName => 'Nhap ten nhom';

  @override
  String get commonConfirm => 'Xac nhan';

  @override
  String get groupEnterGroupDescription => 'Nhap mo ta nhom';

  @override
  String get groupPublish => 'Dang';

  @override
  String get chatClearHistoryConfirm =>
      'Xoa tat ca lich su tro chuyen? Hanh dong nay khong the hoan tac.';

  @override
  String get chatClearAction => 'Xoa';

  @override
  String get commonChatHistoryCleared => 'Da xoa lich su tro chuyen';

  @override
  String get commonDissolve => 'Giai tan';

  @override
  String get groupQrCode => 'Ma QR nhom';

  @override
  String get commonSearchChatHistory => 'Tim kich su tro chuyen';

  @override
  String get groupIdCopied => 'Da sao chep ID nhom';

  @override
  String get transferEnterOrPasteAddress => 'Nhap hoac dan dia chi vi';

  @override
  String get transferSelectToken => 'Chon Token';

  @override
  String get commonTransferAmount => 'So tien chuyen';

  @override
  String get transferAvailable => 'Kha dung';

  @override
  String get transferMemoOptional => 'Ghi chu (tuy chon)';

  @override
  String get transferConfirmTransfer => 'Xac nhan chuyen tien';

  @override
  String get transferAddressVerified => 'Dia chi da xac minh';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return 'Kha dung: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Nhap so tien';

  @override
  String get commonRedPacketCountMin => 'Can it nhat 1 li xi';

  @override
  String get commonViewRedPacketDetails => 'Xem chi tiet li xi';

  @override
  String get commonEnterTransferAmount => 'Nhap so tien chuyen';

  @override
  String get commonTransferTo => 'Chuyen den';

  @override
  String commonFromSender(String name, Object senderName) {
    return 'Tu $senderName';
  }

  @override
  String get commonConfirmReceive => 'Xac nhan nhan';

  @override
  String get groupProfile => 'Thong tin nhom';

  @override
  String get groupRemoveMember => 'Xoa khoi nhom';

  @override
  String get commonRemove => 'Xoa';

  @override
  String get profileClearStatus => 'Xoa trang thai';

  @override
  String get profileClearStatusConfirm => 'Xoa trang thai hien tai?';

  @override
  String get profileStatusCleared => 'Da xoa trang thai';

  @override
  String get profileUserNotExist => 'Nguoi dung khong ton tai';

  @override
  String get profileUserIdCopied => 'Da sao chep ID nguoi dung';

  @override
  String get commonReport => 'Bao cao';

  @override
  String get profileQrCode => 'Ma QR';

  @override
  String get profileAvatarUpdated => 'Da cap nhat anh dai dien';

  @override
  String commonSelectImageFailed(String error) {
    return 'Chon hinh anh that bai: $error';
  }

  @override
  String get profileChangeName => 'Doi ten';

  @override
  String get profileMale => 'Nam';

  @override
  String get profileFemale => 'Nu';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature dang phat trien...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return 'Luu dia chi that bai: $error';
  }

  @override
  String get profileAddNew => 'Them';

  @override
  String get profileAddAddress => 'Them dia chi';

  @override
  String get profileAddressAdded => 'Da them dia chi';

  @override
  String get profileAddressUpdated => 'Da cap nhat dia chi';

  @override
  String get profileDeleteAddress => 'Xoa dia chi';

  @override
  String get profileAddressDeleted => 'Da xoa dia chi';

  @override
  String profileSaveInvoiceFailed(String error) {
    return 'Luu hoa don that bai: $error';
  }

  @override
  String get profileMyInvoices => 'Hoa don cua toi';

  @override
  String get profileAddInvoice => 'Them hoa don';

  @override
  String get profileInvoiceAdded => 'Da them hoa don';

  @override
  String get profileInvoiceUpdated => 'Da cap nhat hoa don';

  @override
  String get profileDeleteInvoice => 'Xoa hoa don';

  @override
  String get profileInvoiceDeleted => 'Da xoa hoa don';

  @override
  String get profilePersonal => 'Ca nhan';

  @override
  String get groupSelectAtLeastOne => 'Vui long chon it nhat mot thanh vien';

  @override
  String get chatFileNotExist => 'Tep khong ton tai';

  @override
  String chatSendFailed(String error) {
    return 'Gui that bai: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Khong the mo trinh duyet';

  @override
  String chatSelectFileFailed(String error) {
    return 'Chon tep that bai: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Cai dat that bai: $error';
  }

  @override
  String get transferEnterValidAmount => 'Vui long nhap so tien hop le';

  @override
  String get commonAddressCopied => 'Da sao chep dia chi';

  @override
  String favoriteOpenItem(String content) {
    return 'Mo: $content';
  }

  @override
  String get favoriteDeleted => 'Da xoa';

  @override
  String get profileWallet => 'Vi';

  @override
  String get chatRecording => 'Dang ghi am';

  @override
  String get chatInvalidVideoUrl => 'URL video khong hop le';

  @override
  String get chatDownloadFile => 'Tai tep xuong';

  @override
  String get chatClearChatHistoryTitle => 'Xoa lich su tro chuyen';

  @override
  String get chatVideoCall => 'Goi Video';

  @override
  String get commonVoiceCall => 'Goi Thoai';

  @override
  String get callLeaveMeeting => 'Roi cuoc hop';

  @override
  String get chatDetails => 'Chi tiet tro chuyen';

  @override
  String get chatViewAllGroupMembers => 'Xem tat ca thanh vien';

  @override
  String get chatGroupName => 'Ten nhom';

  @override
  String get chatGroupNameUpdated => 'Da cap nhat ten nhom';

  @override
  String get chatUpdateFailed => 'Cap nhat that bai';

  @override
  String get chatNoPermissionToModify => 'Ban khong co quyen sua doi';

  @override
  String get chatGroupManagement => 'Quan ly nhom';

  @override
  String get chatMyNicknameInGroup => 'Biet danh trong nhom';

  @override
  String get chatPinChat => 'Ghim tro chuyen';

  @override
  String get chatStrongReminder => 'Nhac nho manh';

  @override
  String get chatSetChatBackground => 'Dat hinh nen tro chuyen';

  @override
  String get chatUnknownFile => 'Tep khong xac dinh';

  @override
  String get chatDownload => 'Tai xuong';

  @override
  String get chatInvalidLocation => 'Vi tri khong hop le';

  @override
  String get chatTapToCancel => 'Nhan de huy';

  @override
  String chatCaptureFailed(Object error) {
    return 'Chup that bai: $error';
  }

  @override
  String get chatProcessingVideo => 'Dang xu ly video...';

  @override
  String get chatVideoFileNotExist => 'Tep video khong ton tai';

  @override
  String get chatVideoDataEmpty => 'Du lieu video trong';

  @override
  String get chatVideoTooLarge => 'Kich thuoc video khong the vuot qua 100MB';

  @override
  String get chatSendingVideo => 'Dang gui video...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Gui video that bai: $error';
  }

  @override
  String get chatImageFileNotExist => 'Tep hinh anh khong ton tai';

  @override
  String get commonImageDataEmpty => 'Du lieu hinh anh trong';

  @override
  String get chatSendingImage => 'Dang gui hinh anh...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Gui hinh anh that bai: $error';
  }

  @override
  String get chatSendLocation => 'Gui vi tri';

  @override
  String get chatSelectLocationAndSend => 'Chon vi tri va gui';

  @override
  String get chatShareRealTimeLocation => 'Chia se vi tri thoi gian thuc';

  @override
  String get chatShareLocationForOneHour =>
      'Chia se vi tri thoi gian thuc voi ban trong 1 gio';

  @override
  String get chatLocationSent => 'Da gui vi tri';

  @override
  String get chatSelectMessages => 'Chon tin nhan';

  @override
  String chatSelectedCount(int count) {
    return 'Da chon $count';
  }

  @override
  String get chatSelectAll => 'Chon tat ca';

  @override
  String chatGroupChatCount(int count) {
    return 'Chat nhom ($count)';
  }

  @override
  String get chatPrivateChat => 'Chat rieng';

  @override
  String get chatNoMessages => 'Khong co tin nhan';

  @override
  String get chatSendFirstMessage =>
      'Gui tin nhan dau tien de bat dau tro chuyen';

  @override
  String get chatEncryptionNotice =>
      'Cuoc tro chuyen nay duoc ma hoa dau cuoi. Chi ban va nguoi nhan moi doc duoc tin nhan.';

  @override
  String get chatMultiForward => 'Chuyen tiep';

  @override
  String get chatCollect => 'Luu tap';

  @override
  String get chatNoMembers => 'Khong co thanh vien';

  @override
  String get chatMemberNotFound => 'Khong tim thay thanh vien';

  @override
  String get chatVoiceFileNotExist => 'Tep giong noi khong ton tai';

  @override
  String get chatVoiceFileEmpty => 'Tep giong noi trong';

  @override
  String get chatSendingVoice => 'Dang gui tin nhan thoai...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Gui tin nhan thoai that bai: $error';
  }

  @override
  String get chatMessageForwarded => 'Da chuyen tiep tin nhan';

  @override
  String chatForwardFailed(Object error) {
    return 'Chuyen tiep that bai: $error';
  }

  @override
  String get chatUnfavorited => 'Da bo yeu thich';

  @override
  String get chatFavorited => 'Da yeu thich';

  @override
  String get chatReactionAdded => 'Da them phan ung';

  @override
  String get chatReactionRemoved => 'Da xoa phan ung';

  @override
  String get chatFailedMessageDeleted => 'Da xoa tin nhan that bai';

  @override
  String get chatDeleteMessages => 'Xoa tin nhan';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Ban co chac muon xoa $count tin nhan?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Luu y: $count tin nhan tu nguoi khac va chi bi xoa cho ban.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count tin nhan tu ban se bi thu hoi cho tat ca.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return 'Da thu hoi $count tin nhan, $localCount chi bi xoa cho ban';
  }

  @override
  String chatRecalledMessages(Object count) {
    return 'Da thu hoi $count tin nhan';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count tin nhan chi bi xoa cho ban';
  }

  @override
  String chatForwardedCount(Object count) {
    return 'Da chuyen tiep $count tin nhan';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Chuyen tiep hoan tat: $success thanh cong, $failed that bai';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'Tinh nang nhac nho chi kha dung trong chat nhom';

  @override
  String get chatOnlyTextSearchable => 'Chi co the tim kiem tin nhan van ban';

  @override
  String chatSearchFor(Object text) {
    return 'Tim \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Tim Baidu';

  @override
  String get chatGoogleSearch => 'Tim Google';

  @override
  String get chatBingSearch => 'Tim Bing';

  @override
  String get chatCalling => 'Dang goi...';

  @override
  String get chatRinging => 'Dang reo...';

  @override
  String get chatInCall => 'Dang trong cuoc goi';

  @override
  String commonFeatureInDevelopment(String feature) {
    return 'Tinh nang dang phat trien...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'Da luu $count tin nhan';
  }

  @override
  String commonMemberCount(int count) {
    return '$count thanh vien';
  }

  @override
  String groupDone(int count) {
    return 'Xong($count)';
  }

  @override
  String get profileServices => 'Dich vu';

  @override
  String get commonFavorites => 'Yeu thich';

  @override
  String get profileOrdersAndCards => 'Don hang & The';

  @override
  String get profileStickers => 'Nhan dan';

  @override
  String profileStatusSetTo(String status) {
    return 'Trang thai da dat: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'Tai len anh dai dien that bai';

  @override
  String get profilePersonalProfile => 'Ho so ca nhan';

  @override
  String get profileName => 'Ten';

  @override
  String get profileGender => 'Gioi tinh';

  @override
  String get profileRegion => 'Khu vuc';

  @override
  String get commonMyQrCode => 'Ma QR cua toi';

  @override
  String get profilePoke => 'Vo vai';

  @override
  String get profileRingtone => 'Nhac chuong';

  @override
  String get profileDefaultRingtone => 'Nhac chuong mac dinh';

  @override
  String get profileMyAddresses => 'Dia chi cua toi';

  @override
  String profileGenderSetTo(String gender) {
    return 'Gioi tinh da dat: $gender';
  }

  @override
  String get profileSelectRegion => 'Chon khu vuc';

  @override
  String get profileSelectCity => 'Chon thanh pho';

  @override
  String profileRegionSetTo(String region) {
    return 'Khu vuc da dat: $region';
  }

  @override
  String get profileSetPoke => 'Dat vo vai';

  @override
  String get profileFriendPokedMe => 'Ban be vo vai toi';

  @override
  String get profileExample => 'Vi du';

  @override
  String get profileOnTheShoulder => ' vao vai';

  @override
  String get profilePokeCleared => 'Da xoa vo vai';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Vo vai da dat: vo vai toi$suffix';
  }

  @override
  String get profileEditSignature => 'Chinh sua chu ky';

  @override
  String get profileIntroduceYourself => 'Mot cau gioi thieu ban than';

  @override
  String get profileSignatureCleared => 'Da xoa chu ky';

  @override
  String get profileSignatureUpdated => 'Da cap nhat chu ky';

  @override
  String get profileScanToAddFriend => 'Quet ma QR tren de ket ban voi toi';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Nhac chuong da dat: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'Ban co chac chac muon giai tan \"$name\" khong? Hanh dong nay khong the hoan tac.';
  }

  @override
  String get authEnterValidServerAddress =>
      'Vui long nhap dia chi may chu hop le';

  @override
  String get authEmailOtp => 'OTP Email';

  @override
  String get authEnterServerAddressFirst =>
      'Vui long nhap dia chi may chu truoc';

  @override
  String get authPasskeyRequiresServer =>
      'Dang nhap Passkey can ho tro may chu';

  @override
  String get authLoginAgreement => 'Bang viec dang nhap, ban dong y voi ';

  @override
  String get authPleaseAgreeToTerms =>
      'Vui long doc va dong y voi Dieu khoan Dich vu va Chinh sach Bao mat';

  @override
  String get authRegisterFailed => 'Dang ky that bai';

  @override
  String get commonReenterPassword => 'Nhap lai mat khau';

  @override
  String get commonPasswordsDoNotMatch => 'Mat khau khong khop';

  @override
  String get authInviteCodeBuiltIn => 'Ma moi (tich hop san)';

  @override
  String get authInviteCodeBuiltInNote =>
      'Ma moi da tich hop san, thuong khong can thay doi';

  @override
  String get authIHaveReadAndAgree => 'Toi da doc va dong y voi ';

  @override
  String get mainStartGroupChat => 'Bat dau Chat nhom';

  @override
  String get mainAddFriends => 'Them ban';

  @override
  String get mainPaymentAndCollection => 'Thanh toan';

  @override
  String contactCount(int count) {
    return '$count lien he';
  }

  @override
  String get contactAddToHomeScreen => 'Them vao man hinh chinh';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'Da gioi thieu the cua $contact cho $recipient';
  }

  @override
  String get contactEnterRemarkName => 'Nhap ten ghi chu';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Ghi chu da dat: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Da chap nhan yeu cau ket ban cua $name';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Da tu choi yeu cau ket ban cua $name';
  }

  @override
  String get commonGroupInvites => 'Loi moi nhom';

  @override
  String commonMyGroups(int count) {
    return 'Nhom cua toi ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Duoc moi tham gia nhom';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'Ban co chac chac muon roi khoi \"$name\" khong?';
  }

  @override
  String get commonLeave => 'Roi';

  @override
  String get commonRecallThisMessage => 'Thu hoi tin nhan nay?';

  @override
  String get commonSavedToGallery => 'Da luu vao thu vien';

  @override
  String get commonFailedToSave => 'Luu that bai';

  @override
  String get chatSaving => 'Dang luu...';

  @override
  String get commonShare => 'Chia se';

  @override
  String get chatSaveToGallery => 'Luu vao Thu vien';

  @override
  String chatDownloadFailed(String code) {
    return 'Tai xuong that bai: $code';
  }

  @override
  String commonShareFailed(String error) {
    return 'Chia se that bai: $error';
  }

  @override
  String get chatFailedToLoadImage => 'Tai hinh anh that bai';

  @override
  String get chatVideoRecordingFailed =>
      'Quay video that bai. Vui long thu lai.';

  @override
  String get profileRedPacket => 'Li xi';

  @override
  String get commonMusic => 'Nhac';

  @override
  String get commonCoupon => 'Phieu giam gia';

  @override
  String get commonGift => 'Qua tang';

  @override
  String get commonPoll => 'Binh chon';

  @override
  String get favoriteText => 'Van ban';

  @override
  String get favoriteLinkLabel => 'Lien ket';

  @override
  String get favoriteNote => 'Ghi chu';

  @override
  String get favoriteMyNotes => 'Ghi chu cua toi';

  @override
  String get favoriteToday => 'Hom nay';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count ngay truoc';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get favoriteNoFavorites => 'Chua co yeu thich';

  @override
  String get favoriteLongPressToFavorite => 'Nhan giu tin nhan de yeu thich';

  @override
  String get favoriteNewNote => 'Ghi chu moi';

  @override
  String get favoriteLink => 'Lien ket yeu thich';

  @override
  String get favoriteEditTags => 'Chinh sua the';

  @override
  String get favoriteDeleteFavorite => 'Xoa yeu thich';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Ban co chac muon xoa yeu thich nay?';

  @override
  String get favoriteNoSearchResultsFound => 'Khong tim thay ket qua';

  @override
  String get commonSendRedPacket => 'Gui li xi';

  @override
  String get transferAmount => 'So tien';

  @override
  String get commonRedPacketCover => 'Bia li xi';

  @override
  String get commonRedPacketType => 'Loai li xi';

  @override
  String get commonNormalRedPacket => 'Thuong';

  @override
  String get commonLuckyRedPacket => 'May man';

  @override
  String get commonRedPacketCount => 'So li xi';

  @override
  String get commonPieces => 'cai';

  @override
  String get commonPutMoneyInRedPacket => 'Bo tien vao li xi';

  @override
  String get commonRedPacketRefundNotice =>
      'Li xi chua nhan se duoc hoan sau 24 gio';

  @override
  String get commonOpenRedPacket => 'Mo';

  @override
  String get commonRedPacketAllClaimed => 'Li xi da nhan het';

  @override
  String get commonRedPacketExpired => 'Li xi het han';

  @override
  String get commonAddTransferNote => 'Them ghi chu chuyen tien';

  @override
  String get commonYuan => 'VND';

  @override
  String get commonReplyWithEmoji => 'Tra loi bang bieu tuong nay';

  @override
  String get contactEditRemark => 'Chinh sua ghi chu';

  @override
  String get contactSetPermissions => 'Dat quyen';

  @override
  String get profileAddToBlacklist => 'Them vao danh sach chan';

  @override
  String get contactDeleteContact => 'Xoa lien he';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Ban co chac muon xoa $name?';
  }

  @override
  String get transferTitle => 'Chuyen tien';

  @override
  String get transferReceiverAddressLabel => 'Dia chi nguoi nhan';

  @override
  String get transferSelectTokenLabel => 'Chon Token';

  @override
  String get transferAmountLabel => 'So tien chuyen';

  @override
  String get transferMemoLabel => 'Ghi chu (tuy chon)';

  @override
  String get transferAddMemoHint => 'Them ghi chu';

  @override
  String get transferSendPaymentRequest => 'Gui yeu cau thanh toan';

  @override
  String get transferQrCodeGenerateFailed => 'Tao ma QR that bai';

  @override
  String get transferScanQrToPayMe => 'Quet ma QR de thanh toan cho toi';

  @override
  String get transferMyWalletAddress => 'Dia chi vi cua toi';

  @override
  String get transferCreatePaymentRequest => 'Tao yeu cau thanh toan';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'Chuc mung tot lanh';

  @override
  String commonSenderRedPacket(String name) {
    return 'Li xi cua $name';
  }

  @override
  String get transferEnterValidAddress => 'Vui long nhap dia chi hop le';

  @override
  String get transferPleaseSelectToken => 'Vui long chon token';

  @override
  String get commonReceivedTransfer => 'Da nhan chuyen tien';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name da gui li xi';
  }

  @override
  String get commonSavedToBalance =>
      'Da luu vao so du, co the chuyen truc tiep';

  @override
  String get commonRedPacketExpiredOrEmpty => 'Li xi het han/da nhan het';

  @override
  String get transferScanFeatureComingSoon => 'Tinh nang quet sap ra mat...';

  @override
  String get contactSetAsStarred => 'Dat lam yeu thich';

  @override
  String get contactAddToBlocklist => 'Them vao danh sach chan';

  @override
  String get commonClaimedYour => ' da nhan ';

  @override
  String get commonClaimedText => ' da nhan ';

  @override
  String commonUserTyping(String name) {
    return '$name dang nhap...';
  }

  @override
  String get commonTyping => 'Dang nhap...';

  @override
  String get commonWaitingToReceive => 'Cho nhan';

  @override
  String get commonTapToClaim => 'Nhan de nhan';

  @override
  String get commonHasBeenReceived => 'Da nhan';

  @override
  String get commonGetLucky => 'Chuc may man';

  @override
  String get qrcodeCameraStartFailed => 'Camera khoi dong that bai';

  @override
  String get qrcodeUnknownError => 'Loi khong xac dinh';

  @override
  String get qrcodePlaceQrCodeInFrame => 'Dat ma QR trong khung de quet';

  @override
  String get qrcodeCloseManualInput => 'Dong nhap thu cong';

  @override
  String get qrcodeManualInputUserId => 'Nhap ID nguoi dung thu cong';

  @override
  String get commonAdd => 'Them';

  @override
  String get profileSetStatus => 'Dat trang thai';

  @override
  String get profileVisibleToFriends24h => 'Hien thi voi ban be trong 24 gio';

  @override
  String get profileWriteStatus => 'Viet trang thai';

  @override
  String get profileEnterYourStatus => 'Nhap trang thai...';

  @override
  String get profileOk => 'OK';

  @override
  String get qrcodeCameraPermissionRequired => 'Can quyen camera de quet ma QR';

  @override
  String get qrcodeCameraPermissionDenied =>
      'Quyen camera bi tu choi vinh vien. Vui long bat trong cai dat he thong.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Loi kiem tra quyen: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'Ma QR khong hop le';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Khong the ket ban: $error';
  }

  @override
  String get qrcodeScanQrCode => 'Quet ma QR';

  @override
  String get qrcodeCheckingCameraPermission => 'Dang kiem tra quyen camera...';

  @override
  String get qrcodeNeedCameraPermission => 'Can quyen camera';

  @override
  String get qrcodeRetryPermission => 'Thu lai';

  @override
  String get qrcodeOpenSettings => 'Mo cai dat';

  @override
  String get groupInviteMembers => 'Moi thanh vien';

  @override
  String groupInviteCount(int count) {
    return 'Moi($count)';
  }

  @override
  String get profileNoShippingAddress => 'Khong co dia chi giao hang';

  @override
  String get profileDefaultLabel => 'Mac dinh';

  @override
  String get profileNoInvoice => 'Khong co hoa don';

  @override
  String get profileCompany => 'Cong ty';

  @override
  String get profileTaxNumber => 'Ma so thue';

  @override
  String get profileConfirmDeleteAddress => 'Ban co chac muon xoa dia chi nay?';

  @override
  String get profileConfirmDeleteInvoice => 'Ban co chac muon xoa hoa don nay?';

  @override
  String get commonGroupOwner => 'Chu so huu';

  @override
  String get commonGroupAdmin => 'Quan tri vien';

  @override
  String get groupSearchMembers => 'Tim thanh vien';

  @override
  String groupTotalMembers(int count) {
    return '$count thanh vien';
  }

  @override
  String get chatRemoveFromGroup => 'Xoa khoi nhom';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Ban co chac muon xoa \"$name\" khoi nhom?';
  }

  @override
  String get chatUnknownSong => 'Bai hat khong xac dinh';

  @override
  String get chatUnknownArtist => 'Nghe si khong xac dinh';

  @override
  String get chatUnknownContact => 'Lien he khong xac dinh';

  @override
  String get chatPersonalCard => 'The lien he';

  @override
  String get chatSingleChoice => 'Chon mot';

  @override
  String get chatMultiChoice => 'Chon nhieu';

  @override
  String get chatEnded => 'Ket thuc';

  @override
  String get chatEndPollButton => 'Ket thuc binh chon';

  @override
  String get chatPollHint =>
      'Binh chon se hien trong chat. Thanh vien nhom co the binh chon.';

  @override
  String get chatSearchSongOrArtist => 'Tim bai hat hoac nghe si';

  @override
  String get chatNoSongsFound => 'Khong tim thay bai hat';

  @override
  String get chatSongNameOptional => 'Ten bai hat (Tuy chon)';

  @override
  String get chatEnterSongName => 'Nhap ten bai hat';

  @override
  String get chatArtistNameOptional => 'Ten nghe si (Tuy chon)';

  @override
  String get chatEnterArtistName => 'Nhap ten nghe si';

  @override
  String get chatRealTimeLocationSharing =>
      'Chia se vi tri thoi gian thuc dang phat trien...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Tinh nang goi thoai dang phat trien...';

  @override
  String get profileReportFeatureInDev =>
      'Tinh nang bao cao dang phat trien...';

  @override
  String get profileShareFeatureInDev => 'Tinh nang chia se dang phat trien...';

  @override
  String get profileQrCodeFeatureInDev => 'Tinh nang ma QR dang phat trien...';

  @override
  String get qrcodeScanQrToAddMe => 'Quet ma QR tren de ket ban voi toi';

  @override
  String get qrcodeSaveToAlbum => 'Luu vao Album';

  @override
  String get qrcodeChangeStyle => 'Doi kieu';

  @override
  String get qrcodeCopyId => 'Sao chep ID';

  @override
  String get qrcodeIdCopied => 'Da sao chep ID';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => 'Them kieu sap ra mat';

  @override
  String get profileBio => 'Tieu su';

  @override
  String get profileHomeServer => 'May chu';

  @override
  String get profileShareContactCard => 'Chia se the lien he';

  @override
  String get profileRemoveFromBlacklist => 'Xoa khoi danh sach chan';

  @override
  String get profileConfirmAddBlacklist =>
      'Ban co chac muon them nguoi nay vao danh sach chan? Ban se khong nhan tin nhan tu ho.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Ban co chac muon xoa nguoi nay khoi danh sach chan?';

  @override
  String get profileRemarkSaved => 'Da luu ghi chu';

  @override
  String get profileRemarkCleared => 'Da xoa ghi chu';

  @override
  String get transferReceive => 'Nhan';

  @override
  String get transferPleaseConnectWallet => 'Vui long ket noi vi truoc';

  @override
  String get transferSendRequest => 'Gui yeu cau';

  @override
  String get transferPleaseEnterValidAmount => 'Vui long nhap so tien hop le';

  @override
  String get searchPlaceholder => 'Tim lien he, nhom, tin nhan';

  @override
  String get searchEnterKeywordToSearch => 'Nhap tu khoa de bat dau tim kiem';

  @override
  String get searchClearHistory => 'Xoa';

  @override
  String searchNoResultsForQuery(String query) {
    return 'Khong tim thay ket qua cho \"$query\"';
  }

  @override
  String get searchAllResults => 'Tat ca';

  @override
  String get searchInChat => 'Tim trong tro chuyen';

  @override
  String get searchContactLabel => 'Lien he';

  @override
  String get searchGroupLabel => 'Nhom';

  @override
  String get searchConversationLabel => 'Cuộc trò chuyện';

  @override
  String get searchMessageLabel => 'Tin nhan';

  @override
  String get settingsSecurityTitle => 'Bao mat';

  @override
  String get settingsKeyBackup => 'Sao luu khoa';

  @override
  String get settingsBackupEncryptionKeys => 'Sao luu khoa ma hoa';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count khoa da sao luu';
  }

  @override
  String get settingsBackupNotSet => 'Chua dat sao luu';

  @override
  String get settingsRestoreKeys => 'Khoi phuc khoa';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Khoi phuc khoa ma hoa tu ban sao luu';

  @override
  String get settingsExportKeys => 'Xuat khoa';

  @override
  String get settingsExportKeysToFile => 'Xuat khoa ra tep';

  @override
  String get settingsLoggedInDevices => 'Thiet bi da dang nhap';

  @override
  String get settingsNoOtherDevices => 'Khong co thiet bi khac';

  @override
  String get settingsVerified => 'Da xac minh';

  @override
  String get settingsUnverified => 'Chua xac minh';

  @override
  String get settingsAdvanced => 'Nang cao';

  @override
  String get settingsCrossSigning => 'Ky cheo';

  @override
  String get settingsEnabled => 'Da bat';

  @override
  String get settingsNotEnabled => 'Chua bat';

  @override
  String get settingsResetEncryption => 'Dat lai ma hoa';

  @override
  String get settingsDeleteAllEncryptionKeys => 'Xoa tat ca khoa ma hoa';

  @override
  String get settingsEncryptionNotSupported => 'Khong ho tro ma hoa';

  @override
  String get settingsNotInitialized => 'Chua khoi tao';

  @override
  String get settingsBackupKeyTitle => 'Sao luu khoa';

  @override
  String get settingsBackupKeyMessage =>
      'Tao ban sao luu khoa moi? Dieu nay se giup ban khoi phuc tin nhan ma hoa tren thiet bi moi.';

  @override
  String get settingsBackup => 'Sao luu';

  @override
  String get settingsRestoreKeyTitle => 'Khoi phuc khoa';

  @override
  String get settingsRestoreKeyMessage =>
      'Nhap mat khau khoi phuc hoac khoa khoi phuc de khoi phuc tin nhan ma hoa.';

  @override
  String get settingsRestore => 'Khoi phuc';

  @override
  String get settingsExportKeyTitle => 'Xuat khoa';

  @override
  String get settingsExportKeyMessage =>
      'Tep khoa xuat chua tat ca khoa ma hoa cua ban. Vui long giu an toan.';

  @override
  String get settingsExport => 'Xuat';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'ID thiet bi: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Trang thai: Da xac minh';

  @override
  String get settingsDeviceStatusUnverified => 'Trang thai: Chua xac minh';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Hoat dong cuoi: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Xac minh thiet bi nay';

  @override
  String get settingsCrossSigningAlreadyEnabled => 'Ky cheo da duoc bat';

  @override
  String get settingsCrossSigningSetupSuccess => 'Cai dat ky cheo thanh cong';

  @override
  String get settingsResetEncryptionTitle => 'Dat lai ma hoa';

  @override
  String get settingsResetEncryptionWarning =>
      'Canh bao: Hanh dong nay se xoa tat ca khoa ma hoa cua ban. Ban se khong the giai ma tin nhan ma hoa truoc do. Hanh dong nay khong the hoan tac.';

  @override
  String get settingsReset => 'Dat lai';

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
  String get callLeaveMeetingConfirm => 'Ban co chac muon roi cuoc hop?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'da vo vai $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'Khong co lien he de them';

  @override
  String get chatAddMembers => 'Them thanh vien';

  @override
  String chatInvitedMembers(int count) {
    return 'Da moi $count thanh vien';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Moi that bai: $error';
  }

  @override
  String get chatMemberRemoved => 'Da xoa thanh vien';

  @override
  String chatRemoveFailed(String error) {
    return 'Xoa that bai: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'Sau khi chia se, nguoi kia co the thay vi tri thoi gian thuc cua ban trong 1 gio.';

  @override
  String get chatStartSharing => 'Bat dau chia se';

  @override
  String get chatLocationServiceNotEnabled => 'Dich vu vi tri chua duoc bat';

  @override
  String get chatEnableLocationService =>
      'Vui long bat dich vu vi tri de su dung tinh nang nay';

  @override
  String get chatGoToSettings => 'Di den Cai dat';

  @override
  String get chatLocationPermissionRequired =>
      'Can quyen vi tri cho tinh nang nay';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'Quyen vi tri bi tu choi vinh vien. Vui long bat trong cai dat.';

  @override
  String get chatLocationPermissionDenied => 'Quyen vi tri bi tu choi';

  @override
  String get chatGettingLocation => 'Dang lay vi tri...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Lay vi tri that bai: $error';
  }

  @override
  String get chatMapPreview => 'Xem truoc ban do';

  @override
  String get chatSearchLocation => 'Tim vi tri';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'Da gui li xi $amount $token';
  }

  @override
  String get chatTransferDefault => 'Chuyen tien';

  @override
  String chatTransferSent(String amount, String token) {
    return 'Da gui chuyen tien $amount $token';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Chon tep that bai: $error';
  }

  @override
  String get chatFileSizeLimit => 'Kich thuoc tep khong the vuot qua 50MB';

  @override
  String chatFileSending(String filename) {
    return 'Dang gui tep: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Gui tep that bai: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'Da gui the lien he cua $name';
  }

  @override
  String get chatFavoritesFeature => 'Yeu thich';

  @override
  String get chatCouponsFeature => 'Phieu giam gia';

  @override
  String get chatGiftFeature => 'Qua tang';

  @override
  String chatSharedMusic(String name) {
    return 'Da chia se $name';
  }

  @override
  String get chatEndPollTitle => 'Ket thuc binh chon';

  @override
  String get chatEndPollConfirmMessage =>
      'Ban co chac muon ket thuc binh chon nay? Binh chon se dong sau khi ket thuc.';

  @override
  String get chatPollEndedMessage => 'Binh chon da ket thuc';

  @override
  String get chatConnectingCall => 'Đang kết nối...';

  @override
  String get chatMuteCall => 'Tat tieng';

  @override
  String get chatSpeakerOff => 'Tat loa';

  @override
  String get chatSpeakerOn => 'Loa';

  @override
  String get chatCameraOn => 'Bat camera';

  @override
  String get chatCameraOff => 'Tat camera';

  @override
  String get chatHangUp => 'Cup may';

  @override
  String get chatSelectForwardTargetTitle => 'Chon muc tieu chuyen tiep';

  @override
  String get chatNoForwardableChat => 'Khong co tro chuyen de chuyen tiep';

  @override
  String get chatNoMatchingChat => 'Khong tim thay tro chuyen phu hop';

  @override
  String get chatLocationTitle => 'Vi tri';

  @override
  String get chatSendButton => 'Gui';

  @override
  String get chatRetryButton => 'Thu lai';

  @override
  String get chatSearchContactHint => 'Tim lien he';

  @override
  String get chatShareMusic => 'Chia se nhac';

  @override
  String get chatRecentPlayed => 'Gan day';

  @override
  String get chatMyFavorites => 'Yeu thich';

  @override
  String get chatNetworkLink => 'Lien ket';

  @override
  String get chatLocalFile => 'Tep';

  @override
  String get chatPasteMusicLink => 'Dan lien ket nhac';

  @override
  String get chatShareMusicButton => 'Chia se nhac';

  @override
  String get chatSelectLocalAudio => 'Chon tep am thanh';

  @override
  String get chatSupportedAudioFormats => 'Ho tro MP3, M4A, WAV, FLAC, v.v.';

  @override
  String get chatSelectFileButton => 'Chon tep';

  @override
  String get chatPleaseEnterMusicLink => 'Vui long nhap lien ket nhac';

  @override
  String get chatPleaseEnterValidLink => 'Vui long nhap URL hop le';

  @override
  String get chatSharedSong => 'Bai hat da chia se';

  @override
  String get chatSelectMember => 'Chon thanh vien';

  @override
  String get chatSearchMemberHint => 'Tim thanh vien';

  @override
  String get chatNoMatchingMembers => 'Khong tim thay thanh vien phu hop';

  @override
  String get commonUnknownMember => 'Khong xac dinh';

  @override
  String chatSelectedMessagesCount(int count) {
    return 'Da chon $count tin nhan';
  }

  @override
  String get chatSearchContactsOrGroups => 'Tim lien he hoac nhom';

  @override
  String get chatVideoTitle => 'Video';

  @override
  String get chatLoadingText => 'Dang tai...';

  @override
  String get chatVideoLoadFailed => 'Tai video that bai';

  @override
  String get chatPlayerInitFailed => 'Khoi tao trinh phat that bai';

  @override
  String get chatCreatePollTitle => 'Tao binh chon';

  @override
  String get chatSubmitPoll => 'Gui';

  @override
  String get chatPollQuestionLabel => 'Cau hoi binh chon';

  @override
  String get chatEnterPollQuestionHint => 'Vui long nhap cau hoi binh chon';

  @override
  String get chatPollOptionsLabel => 'Cac lua chon';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Lua chon $index';
  }

  @override
  String get chatAddOptionButton => 'Them lua chon';

  @override
  String get chatPollSettingsLabel => 'Cai dat binh chon';

  @override
  String get chatSelectionType => 'Loai chon';

  @override
  String get chatSingleChoiceLabel => 'Chon mot';

  @override
  String get chatMultiChoiceLabel => 'Chon nhieu';

  @override
  String get chatAnonymousPollSwitch => 'Binh chon an danh';

  @override
  String get chatPleaseEnterQuestion => 'Vui long nhap cau hoi binh chon';

  @override
  String get chatAtLeastTwoOptions => 'Can it nhat 2 lua chon';

  @override
  String chatConfirmWithCount(int count) {
    return 'Xac nhan ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'Xac minh Email';

  @override
  String get authEnterValidEmailAddress => 'Vui long nhap dia chi email hop le';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Ma xac minh da gui den $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Gui ma that bai: $error';
  }

  @override
  String get authVerificationSuccess => 'Xac minh thanh cong';

  @override
  String get authVerificationFailed => 'Xac minh that bai';

  @override
  String authVerificationCodeError(String error) {
    return 'Loi ma xac minh: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Nhap ma xac minh';

  @override
  String get authEnterYourEmail => 'Nhap email';

  @override
  String authWeSentCodeTo(String email) {
    return 'Chung toi da gui ma 6 so den\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'Nhap dia chi email, chung toi se gui ma xac minh';

  @override
  String get commonSendVerificationCode => 'Gui ma xac minh';

  @override
  String get authResendVerificationCode => 'Gui lai ma xac minh';

  @override
  String authCanResendAfter(int seconds) {
    return 'Co the gui lai sau $seconds giay';
  }

  @override
  String get commonChangeEmail => 'Doi email';

  @override
  String get contactAddToContacts => 'Them vao danh ba';

  @override
  String get contactAddingToContacts => 'Dang them...';

  @override
  String get contactAddedToContacts => 'Da them vao danh ba';

  @override
  String contactAddFailedWithError(String error) {
    return 'Them that bai: $error';
  }

  @override
  String get contactAddPhone => 'Them dien thoai';

  @override
  String get contactAddTag => 'Them the';

  @override
  String get contactAddText => 'Them van ban';

  @override
  String get contactAddPhoto => 'Them anh';

  @override
  String contactGroupCountLabel(int count) {
    return '$count nhom';
  }

  @override
  String get contactAddedViaSearch => 'Da them qua tim kiem';

  @override
  String get contactAddTime => 'Thoi gian them';

  @override
  String get contactDoneButton => 'Xong';

  @override
  String get callWaitingForParticipants => 'Dang cho nguoi tham gia...';

  @override
  String callParticipantMe(String name) {
    return '$name (Toi)';
  }

  @override
  String get callSharingLabel => 'Dang chia se';

  @override
  String callScreenSharingBy(String name) {
    return '$name dang chia se man hinh';
  }

  @override
  String callParticipantCount(int count) {
    return '$count nguoi tham gia';
  }

  @override
  String get callMuteLabel => 'Tat tieng';

  @override
  String get callUnmuteLabel => 'Bat tieng';

  @override
  String get callTurnOffVideo => 'Tat video';

  @override
  String get callTurnOnVideo => 'Bat video';

  @override
  String get callShareScreen => 'Chia se man hinh';

  @override
  String get callStopSharing => 'Dung chia se';

  @override
  String get callSwitchCameraLabel => 'Chuyen';

  @override
  String get callLeaveLabel => 'Roi';

  @override
  String get callParticipantsLabel => 'Nguoi tham gia';

  @override
  String get callJoiningMeeting => 'Dang tham gia cuoc hop...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count phiếu ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count người tham gia';
  }

  @override
  String get commonTapToRetry => 'Nhấn để thử lại';

  @override
  String get chatDefaultRedPacketGreeting => 'Chúc phát tài phát lộc';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Cho phép những người khác tìm kiếm và tham gia';

  @override
  String get groupConfirmClearChatHistory =>
      'Bạn có chắc chắn muốn xóa lịch sử trò chuyện không?';

  @override
  String get groupCreateGroupToChat => 'Tạo một nhóm để bắt đầu trò chuyện';

  @override
  String get groupEditGroupAnnouncement => 'Chỉnh sửa thông báo nhóm';

  @override
  String get groupEditGroupDescription => 'Chỉnh sửa mô tả nhóm';

  @override
  String get groupEnterGroupAnnouncement => 'Nhập thông báo nhóm';

  @override
  String chatErrorWithMessage(String message) {
    return 'Lỗi: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count thành viên, nhấp để sao chép ID nhóm';
  }

  @override
  String get chatMusicLinkLabel => 'Liên kết nhạc';

  @override
  String get chatNoMediaUrlAvailable => 'URL phương tiện không khả dụng';

  @override
  String get groupNoPermissionToEditGroupName =>
      'Bạn không có quyền chỉnh sửa tên nhóm';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Lì xì và chuyển khoản không thể chuyển tiếp';

  @override
  String get authEmailAddress => 'Địa chỉ email';

  @override
  String get commonEnterEmailAddress => 'Nhập địa chỉ email';

  @override
  String get authEmailRecoveryHint => 'Dùng để khôi phục mật khẩu';

  @override
  String get commonInvalidEmailFormat => 'Vui lòng nhập địa chỉ email hợp lệ';

  @override
  String get authOptional => 'Tùy chọn';

  @override
  String get authResetPassword => 'Đặt lại mật khẩu';

  @override
  String get authEnterRegisteredEmail => 'Nhập địa chỉ email bạn đã đăng ký';

  @override
  String get authSendResetCode => 'Gửi mã đặt lại';

  @override
  String authResetCodeSent(String email) {
    return 'Mã đặt lại đã gửi đến $email';
  }

  @override
  String get authEnterResetCode => 'Nhập mã đặt lại';

  @override
  String get authSetNewPassword => 'Đặt mật khẩu mới';

  @override
  String get commonConfirmNewPassword => 'Xác nhận mật khẩu mới';

  @override
  String get commonNewPassword => 'Mật khẩu mới';

  @override
  String get authPasswordResetSuccess =>
      'Mật khẩu đã được đặt lại thành công. Vui lòng đăng nhập bằng mật khẩu mới.';

  @override
  String get authResetPasswordFailed => 'Đặt lại mật khẩu thất bại';

  @override
  String get settingsChangePassword => 'Đổi mật khẩu';

  @override
  String get settingsCurrentPassword => 'Mật khẩu hiện tại';

  @override
  String get settingsEnterCurrentPassword => 'Nhập mật khẩu hiện tại';

  @override
  String get settingsEnterNewPassword => 'Nhập mật khẩu mới';

  @override
  String get settingsPasswordChanged =>
      'Mật khẩu đã được thay đổi thành công. Vui lòng đăng nhập bằng mật khẩu mới.';

  @override
  String get settingsChangePasswordFailed => 'Đổi mật khẩu thất bại';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'Mật khẩu mới phải khác mật khẩu hiện tại';

  @override
  String get settingsChangePasswordInfo =>
      'Sau khi đổi mật khẩu, bạn sẽ bị đăng xuất và cần đăng nhập lại bằng mật khẩu mới.';

  @override
  String get settingsPasswordRequirements => 'Yêu cầu mật khẩu:';

  @override
  String get settingsSecurityNote =>
      'Vì lý do bảo mật, bạn sẽ cần đăng nhập lại trên tất cả thiết bị sau khi đổi mật khẩu.';

  @override
  String get settingsSecurity => 'Bảo mật';

  @override
  String get settingsCurrentBoundEmail => 'Email hiện đang liên kết';

  @override
  String get settingsNewEmailAddress => 'Địa chỉ email mới';

  @override
  String get settingsEnterNewEmail => 'Nhập địa chỉ email mới';

  @override
  String get settingsVerificationCode => 'Mã xác nhận';

  @override
  String get settingsVerificationCodeSent => 'Mã xác nhận đã được gửi';

  @override
  String get settingsCodeSentTo => 'Mã xác nhận đã gửi đến';

  @override
  String get settingsDidNotReceiveCode => 'Không nhận được mã?';

  @override
  String get settingsEmailChangedSuccess => 'Email đã được thay đổi thành công';

  @override
  String get settingsChangeEmailFailed => 'Thay đổi email thất bại';

  @override
  String get settingsEmailSecurityNote =>
      'Email của bạn được dùng để khôi phục mật khẩu. Hãy giữ an toàn.';

  @override
  String get commonGoogleLogin => 'Đăng nhập bằng Google';

  @override
  String get commonAppleLogin => 'Đăng nhập bằng Apple';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Ngôn ngữ';

  @override
  String get settingsLanguageChanged => 'Ngôn ngữ đã thay đổi';

  @override
  String get settingsBiometricLogin => 'Đăng nhập sinh trắc học';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Đăng nhập bằng $type';
  }

  @override
  String get settingsBiometricLoginEnabled => 'Đăng nhập sinh trắc học đã bật';

  @override
  String get settingsBiometricLoginDisabled => 'Đăng nhập sinh trắc học đã tắt';

  @override
  String get settingsEnableBiometricLogin => 'Bật đăng nhập sinh trắc học';

  @override
  String get settingsBiometricEnabled =>
      'Đã bật - Dùng sinh trắc học để đăng nhập';

  @override
  String get settingsBiometricDisabled => 'Đã tắt - Nhấn để bật';

  @override
  String get settingsBiometricNeedRelogin =>
      'Vui lòng đăng xuất và đăng nhập lại để bật đăng nhập sinh trắc học';

  @override
  String get authOr => 'HOẶC';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'Quyền truy cập camera bị hạn chế trên thiết bị này';

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
  String get profileEnterPokeSuffixHint => 'Nhập hậu tố chọc, ví dụ: vào vai';

  @override
  String get groupAlbum => 'Album nhóm';

  @override
  String get groupFiles => 'Tệp nhóm';

  @override
  String get groupImages => 'Hình ảnh';

  @override
  String get groupVideos => 'Video';

  @override
  String get groupTotal => 'Tổng cộng';

  @override
  String get groupSize => 'Kích thước';

  @override
  String get groupNoMedia => 'Không có phương tiện';

  @override
  String get groupNoMediaDescription =>
      'Chưa có ảnh hoặc video nào trong nhóm này';

  @override
  String get groupDocuments => 'Tài liệu';

  @override
  String get groupNoFiles => 'Không có tệp';

  @override
  String get groupNoFilesDescription => 'Chưa có tệp nào trong nhóm này';

  @override
  String groupDownloadStarted(String filename) {
    return 'Đang tải $filename...';
  }

  @override
  String get contactNoCommonGroups => 'Không có nhóm chung';

  @override
  String get contactNoCommonGroupsDescription =>
      'Các bạn không có nhóm chung nào';

  @override
  String get chatVoiceMessage => 'Giọng nói';

  @override
  String get chatMessage => 'Tin nhắn';

  @override
  String get conversationHideChat => 'Ẩn';

  @override
  String get settingsQuickReply => 'Trả lời nhanh';

  @override
  String get commonTranslate => 'Dịch';

  @override
  String get contactCreateTag => 'Create Tag';

  @override
  String get contactEnterTagName => 'Enter tag name';

  @override
  String get contactEditTag => 'Edit Tag';

  @override
  String get contactDeleteTag => 'Delete Tag';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'Are you sure you want to delete the tag \"$tagName\"?';
  }

  @override
  String get contactNoTags => 'No tags yet';

  @override
  String get contactFriendPermissions => 'Friend Permissions';

  @override
  String get contactSetChatOnly => 'Set as Chat-only';

  @override
  String get contactChatOnlyDesc =>
      'Can only chat with you, other content will be hidden';

  @override
  String get contactHideMyMoments => 'Hide My Moments';

  @override
  String get contactHideMyMomentsDesc => 'This friend cannot see my Moments';

  @override
  String get contactHideTheirMoments => 'Hide Their Moments';

  @override
  String get contactHideTheirMomentsDesc => 'Don\'t see this friend\'s Moments';

  @override
  String get contactHideMyStatus => 'Hide My Status';

  @override
  String get contactHideMyStatusDesc =>
      'This friend cannot see my status updates';

  @override
  String get contactNoChatOnlyFriends => 'No chat-only friends';

  @override
  String get contactNoOfficialAccounts => 'No official accounts';

  @override
  String get contactFollowOfficialAccountsDesc =>
      'Follow official accounts to get the latest updates';

  @override
  String get contactNoServiceAccounts => 'No service accounts';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      'Subscribe to service accounts for convenient services';

  @override
  String get contactNoEnterpriseContacts => 'No enterprise contacts';

  @override
  String get contactEnterpriseContactsDesc =>
      'Enterprise contacts will be displayed here';

  @override
  String get profileCardPack => 'Card Pack';

  @override
  String get profileOrders => 'Orders';

  @override
  String get profileNoOrders => 'No orders';

  @override
  String get profileOrdersDesc => 'Your orders will be displayed here';

  @override
  String get profileNoCards => 'No cards';

  @override
  String get profileCardsDesc => 'Your cards will be displayed here';

  @override
  String get favoriteEnterTagsHint => 'Enter tags separated by commas';

  @override
  String get favoriteTagsUpdated => 'Tags updated';

  @override
  String get favoriteForwardedContent => 'Content forwarded';

  @override
  String get favoriteEnterNoteContent => 'Enter note content';

  @override
  String get favoriteNoteAdded => 'Note added';

  @override
  String get favoriteLinkTitle => 'Link title';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'Link added';

  @override
  String get contactPhotoAdded => 'Photo added';

  @override
  String get contactEnterPhone => 'Enter phone number';

  @override
  String commonConversationWithId(String roomId) {
    return 'Cuoc tro chuyen: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return 'Lien he: $userId';
  }

  @override
  String get commonDiscover => 'Kham pha';

  @override
  String commonDeveloping(String title) {
    return '$title\n(Sap ra mat)';
  }

  @override
  String get commonPageNotFound => 'Khong tim thay trang';

  @override
  String get commonBackToHome => 'Quay lai trang chu';

  @override
  String get settingsMessageNotifications => 'Thông báo tin nhắn';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Nhận thông báo tin nhắn mới';

  @override
  String get settingsShowMessagePreview => 'Hiển thị xem trước tin nhắn';

  @override
  String get settingsShowMessageContentInNotification =>
      'Hiển thị nội dung tin nhắn trong thông báo';

  @override
  String get settingsNotificationSound => 'Am thanh thong bao';

  @override
  String get settingsPlaySoundOnMessage => 'Phat am thanh khi nhan tin nhan';

  @override
  String get commonVibration => 'Rung';

  @override
  String get settingsVibrateOnMessage => 'Rung khi nhan tin nhan';

  @override
  String get settingsDoNotDisturbMode => 'Không làm phiền';

  @override
  String get settingsDoNotDisturbDescription =>
      'Không nhận thông báo trong khoảng thời gian chỉ định';

  @override
  String get settingsStartTime => 'Thoi gian bat dau';

  @override
  String get settingsEndTime => 'Thoi gian ket thuc';

  @override
  String get settingsDeleteQuickReply => 'Xóa trả lời nhanh';

  @override
  String get settingsEditQuickReply => 'Sửa trả lời nhanh';

  @override
  String get settingsAddQuickReply => 'Thêm trả lời nhanh';

  @override
  String get settingsManageQuickReplies => 'Quản lý trả lời nhanh';

  @override
  String get settingsNoQuickReplies => 'Không có trả lời nhanh';

  @override
  String get settingsDefaultQuickReplies =>
      'Trả lời nhanh mặc định sẽ được hiển thị';

  @override
  String get settingsWhoCanSee => 'Ai co the xem';

  @override
  String get settingsLastSeen => 'Lan cuoi truc tuyen';

  @override
  String get settingsHiddenChats => 'Cuộc trò chuyện ẩn';

  @override
  String get settingsMessagesLabel => 'Tin nhắn';

  @override
  String get settingsAllowStrangerMessages => 'Cho phép tin nhắn từ người lạ';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Nhận tin nhắn từ người không có trong danh bạ';

  @override
  String get settingsReadReceipts => 'Xac nhan da doc';

  @override
  String get settingsLetOthersKnowYouRead =>
      'Cho người khác biết bạn đã đọc tin nhắn của họ';

  @override
  String get settingsTypingIndicator => 'Chỉ báo đang nhập';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'Cho người khác biết bạn đang nhập';

  @override
  String get settingsEveryone => 'Tat ca moi nguoi';

  @override
  String get settingsContactsOnly => 'Chi danh ba';

  @override
  String get settingsNobody => 'Khong ai';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Ai có thể xem $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Phiên bản $version';
  }

  @override
  String get settingsCheckForUpdates => 'Kiểm tra cập nhật';

  @override
  String get settingsOpenSourceLicenses => 'Giay phep ma nguon mo';

  @override
  String get settingsFeedbackAndSuggestions => 'Phản hồi và đề xuất';

  @override
  String get settingsBuiltOnMatrix => 'Xay dung tren giao thuc Matrix';

  @override
  String get settingsNoHiddenChats => 'Không có cuộc trò chuyện ẩn';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Các cuộc trò chuyện bạn ẩn sẽ xuất hiện ở đây';

  @override
  String get settingsUnhideChat => 'Bỏ ẩn';

  @override
  String get settingsDarkMode => 'Chế độ tối';

  @override
  String get settingsFontSize => 'Cỡ chữ';

  @override
  String get settingsBubbleStyle => 'Kiểu bong bóng';

  @override
  String get settingsFollowSystem => 'Theo hệ thống';

  @override
  String get settingsAutoSwitchBySystem =>
      'Tự động chuyển theo cài đặt hệ thống';

  @override
  String get settingsLightMode => 'Chế độ sáng';

  @override
  String get settingsAlwaysUseLightTheme => 'Luôn dùng giao diện sáng';

  @override
  String get settingsDarkModeOption => 'Chế độ tối';

  @override
  String get settingsAlwaysUseDarkTheme => 'Luôn dùng giao diện tối';

  @override
  String get settingsFontSizeSmall => 'Nhỏ';

  @override
  String get settingsFontSizeStandard => 'Tiêu chuẩn';

  @override
  String get settingsFontSizeLarge => 'Lớn';

  @override
  String get settingsFontSizeExtraLarge => 'Rất lớn';

  @override
  String get settingsBubbleStyleWechat => 'Kiểu WeChat';

  @override
  String get settingsBubbleStyleWechatDesc => 'Kiểu bong bóng WeChat cổ điển';

  @override
  String get settingsBubbleStyleModern => 'Kiểu hiện đại';

  @override
  String get settingsBubbleStyleModernDesc => 'Kiểu bong bóng hiện đại sạch sẽ';

  @override
  String get settingsBubbleStyleClassic => 'Kiểu cổ điển';

  @override
  String get settingsBubbleStyleClassicDesc => 'Kiểu bong bóng truyền thống';

  @override
  String get discoverVideoChannels => 'Kenh';

  @override
  String get discoverLive => 'Truc tiep';

  @override
  String get discoverListen => 'Nghe';

  @override
  String get discoverWatch => 'Xem';

  @override
  String get discoverSearchDiscover => 'Tim kiem';

  @override
  String get discoverNearbyPeople => 'Gan day';

  @override
  String get discoverGames => 'Tro choi';

  @override
  String get discoverMiniPrograms => 'Ung dung mini';

  @override
  String get chatAlreadyInCall => 'Dang trong cuoc goi';

  @override
  String get commonConnectionFailed => 'Ket noi that bai';

  @override
  String get chatCallRejected => 'Cuoc goi bi tu choi';

  @override
  String get chatNoAnswer => 'Khong tra loi';

  @override
  String get commonClose => 'Dong';

  @override
  String get chatSelectContact => 'Chon lien he';

  @override
  String get chatVoteRemoved => 'Da xoa binh chon';

  @override
  String get chatVoteChanged => 'Da thay doi binh chon';

  @override
  String get chatVoted => 'Da binh chon';

  @override
  String chatReplyTo(String name) {
    return 'Tra loi $name';
  }

  @override
  String get chatCurrentLocation => 'Vi tri hien tai';

  @override
  String chatNearbyPlace(int index) {
    return 'Dia diem gan $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Khoang $distance';
  }

  @override
  String get chatAddress => 'Dia chi';

  @override
  String get chatLatitude => 'Vi do';

  @override
  String get chatLongitude => 'Kinh do';

  @override
  String get groupDescriptionUpdated => 'Đã cập nhật mô tả nhóm';

  @override
  String get groupAvatarUpdated => 'Đã cập nhật ảnh đại diện nhóm';

  @override
  String get callDecline => 'Tu choi';

  @override
  String get callAnswer => 'Tra loi';

  @override
  String get callIncomingVideoCall => 'Cuộc gọi video đến';

  @override
  String get callIncomingVoiceCall => 'Cuộc gọi thoại đến';

  @override
  String get callVideoCallInProgress => 'Cuộc gọi video';

  @override
  String get callVoiceCallInProgress => 'Cuộc gọi thoại';

  @override
  String get callReconnectingCall => 'Đang kết nối lại...';

  @override
  String get callEnded => 'Cuộc gọi kết thúc';

  @override
  String get callFailed => 'Cuộc gọi thất bại';

  @override
  String get callLivekitNotConfigured => 'LiveKit chua duoc cau hinh';

  @override
  String callJoinMeetingFailed(String error) {
    return 'Tham gia cuoc hop that bai: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return 'Chia se man hinh that bai: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bean';

  @override
  String get profileNoN42Bean => 'Không có N42 Bean';

  @override
  String get profileN42BeanDetails => 'Chi tiết N42 Bean';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean là token dùng để đổi vật phẩm ảo và dịch vụ trong N42. Hiện có thể dùng cho:';

  @override
  String get profileN42BeanFeature1 =>
      'Nhãn dán và chủ đề độc quyền cho thành viên';

  @override
  String get profileN42BeanFeature2 => 'Tùy chỉnh bong bóng chat';

  @override
  String get profileN42BeanFeature3 => 'Tùy chỉnh bìa phong bao đỏ';

  @override
  String get profileN42BeanFeature4 => 'Huy hiệu biệt danh độc quyền';

  @override
  String get profileN42BeanFeature5 => 'Đặc quyền trò chuyện nhóm';

  @override
  String get profileN42BeanFeature6 => 'Mở rộng lưu trữ đám mây';

  @override
  String get profileN42BeanFeature7 => 'Bộ lọc làm đẹp cuộc gọi video';

  @override
  String get profileN42BeanFeature8 => 'Tùy chỉnh nền Khoảnh khắc';

  @override
  String get profileN42BeanFeature9 => 'Ưu tiên dịch vụ khách hàng VIP';

  @override
  String get profileGotIt => 'Đã hiểu';

  @override
  String get profileNoN42BeanRecords => 'Không có bản ghi N42 Bean';

  @override
  String get profileMoodAndThoughts => 'Tam trang & Suy nghi';

  @override
  String get profileStatusHappy => 'Vui ve';

  @override
  String get profileStatusCracked => 'Vo tan';

  @override
  String get profileStatusLucky => 'May man';

  @override
  String get profileStatusSunny => 'Nang ve';

  @override
  String get profileStatusTired => 'Met moi';

  @override
  String get profileStatusDaydream => 'Mo mong';

  @override
  String get profileStatusRushing => 'Ban ron';

  @override
  String get profileStatusOverthinking => 'Suy nghi qua nhieu';

  @override
  String get profileStatusEnergized => 'Day nang luong';

  @override
  String get profileWorkAndStudy => 'Cong viec & Hoc tap';

  @override
  String get profileStatusWorking => 'Dang lam viec';

  @override
  String get profileStatusStudying => 'Dang hoc';

  @override
  String get profileStatusBusy => 'Ban';

  @override
  String get profileStatusSlacking => 'Nghi ngoi';

  @override
  String get profileStatusTraveling => 'Di du lich';

  @override
  String get profileStatusGoingHome => 'Ve nha';

  @override
  String get profileStatusDnd => 'Khong lam phien';

  @override
  String get profileActivities => 'Hoat dong';

  @override
  String get profileStatusHanging => 'Di choi';

  @override
  String get profileStatusCheckIn => 'Diem danh';

  @override
  String get profileStatusExercising => 'Tap the duc';

  @override
  String get profileStatusCoffee => 'Uong ca phe';

  @override
  String get profileStatusBubbleTea => 'Uong tra sua';

  @override
  String get profileStatusEating => 'An uong';

  @override
  String get profileStatusParenting => 'Cham con';

  @override
  String get profileStatusSavingWorld => 'Cuu the gioi';

  @override
  String get profileStatusSelfie => 'Chup selfie';

  @override
  String get profileRest => 'Nghi ngoi';

  @override
  String get profileStatusRetreat => 'An cu';

  @override
  String get profileStatusHome => 'O nha';

  @override
  String get profileStatusSleeping => 'Dang ngu';

  @override
  String get profileStatusCatLover => 'Nguoi yeu meo';

  @override
  String get profileStatusDogWalking => 'Dat cho di dao';

  @override
  String get profileStatusGaming => 'Choi game';

  @override
  String get profileStatusListening => 'Dang nghe';

  @override
  String get profileEditAddress => 'Chinh sua dia chi';

  @override
  String get profileRecipient => 'Nguoi nhan';

  @override
  String get profileEnterRecipientName => 'Nhap ten nguoi nhan';

  @override
  String get profilePhoneNumber => 'So dien thoai';

  @override
  String get profileEnterPhoneNumber => 'Nhap so dien thoai';

  @override
  String get profileRegionHint => 'Tinh/Thanh pho/Quan';

  @override
  String get profileDetailedAddress => 'Dia chi chi tiet';

  @override
  String get profileDetailedAddressHint => 'Duong, so nha, v.v.';

  @override
  String get profileSetAsDefaultAddress => 'Dat lam dia chi mac dinh';

  @override
  String get profilePleaseCompleteInfo => 'Vui long dien day du thong tin';

  @override
  String get profileEditInvoice => 'Chinh sua hoa don';

  @override
  String get profileInvoiceType => 'Loai hoa don: ';

  @override
  String get profileCompanyName => 'Ten cong ty';

  @override
  String get profilePersonalName => 'Ten ca nhan';

  @override
  String get profileEnterCompanyName => 'Nhap ten cong ty';

  @override
  String get profileEnterName => 'Nhap ten';

  @override
  String get profileTaxIdNumber => 'Ma so thue';

  @override
  String get profileEnterTaxIdNumber => 'Nhap ma so thue';

  @override
  String get profileBankNameOptional => 'Ten ngan hang (Tuy chon)';

  @override
  String get profileEnterBankName => 'Nhap ten ngan hang';

  @override
  String get profileBankAccountOptional => 'Tai khoan ngan hang (Tuy chon)';

  @override
  String get profileEnterBankAccount => 'Nhap tai khoan ngan hang';

  @override
  String get profileCompanyAddressOptional => 'Dia chi cong ty (Tuy chon)';

  @override
  String get profileEnterCompanyAddress => 'Nhap dia chi cong ty';

  @override
  String get profileCompanyPhoneOptional => 'Dien thoai cong ty (Tuy chon)';

  @override
  String get profileEnterCompanyPhone => 'Nhap dien thoai cong ty';

  @override
  String get profileSetAsDefaultInvoice => 'Dat lam hoa don mac dinh';

  @override
  String get profileRingtoneVibrate => 'Rung';

  @override
  String get profileRingtoneSilent => 'Im lang';

  @override
  String get profileVibrateMode => 'Che do rung';

  @override
  String get profileSilentMode => 'Che do im lang';

  @override
  String profilePlayFailed(String ringtoneName) {
    return 'Phat that bai: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return 'Dang phat: $ringtoneName';
  }

  @override
  String get profileStop => 'Dung';

  @override
  String get profileSelectRingtone => 'Chon nhac chuong';

  @override
  String get profileLoadingRingtones => 'Dang tai nhac chuong...';

  @override
  String get profileNoRingtonesFound => 'Khong tim thay nhac chuong';

  @override
  String mainMessagesWithCount(int count) {
    return 'Tin nhan($count)';
  }

  @override
  String get storyViewers => 'Người xem';

  @override
  String get storyNoViewers => 'Chưa có người xem';

  @override
  String get storyReplyToStory => 'Trả lời trạng thái...';

  @override
  String get commonCopiedToClipboard => 'Da sao chep vao clipboard';

  @override
  String get commonMore => 'Them';

  @override
  String get commonTranslating => 'Đang dịch...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Dịch từ $language';
  }

  @override
  String get commonTranslation => 'Bản dịch';

  @override
  String get commonTranslationFailed => 'Dịch thất bại';

  @override
  String get commonAllRead => 'Da doc tat ca';

  @override
  String commonReadCount(int count) {
    return '$count da doc';
  }

  @override
  String get commonYouRecalledMessage => 'Ban da thu hoi mot tin nhan';

  @override
  String get commonMessageRecalled => 'Tin nhan da thu hoi';

  @override
  String get commonReEdit => 'Chinh sua lai';

  @override
  String get commonWalletArea => 'Khu vuc vi';

  @override
  String get callIncomingCall => 'Cuoc goi den';

  @override
  String get callMissedCall => 'Cuoc goi nho';

  @override
  String get groupRemoveAdmin => 'Xoa quyen quan tri';

  @override
  String get chatSelectCurrency => 'Chon loai tien';

  @override
  String get chatSelectEmoji => 'Chon bieu tuong cam xuc';

  @override
  String get chatSelectRedPacketCover => 'Chon bia';

  @override
  String get groupSetAsAdmin => 'Dat lam quan tri vien';

  @override
  String get chatVideoPlaybackFailed => 'Phat video that bai';

  @override
  String get groupViewProfile => 'Xem ho so';

  @override
  String get favoriteAddLinkComingSoon => 'Tinh nang them lien ket sap ra mat';

  @override
  String get favoriteNewNoteComingSoon => 'Tinh nang ghi chu moi sap ra mat';

  @override
  String get qrcodeSaveFeatureComingSoon => 'Tinh nang luu sap ra mat';

  @override
  String get qrcodeShareFeatureComingSoon => 'Tinh nang chia se sap ra mat';

  @override
  String qrcodeProcessFailed(String error) {
    return 'Xu ly ma QR that bai: $error';
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
  String get liveLocation => 'Live Location';

  @override
  String get stopLiveLocation => 'Stop Sharing';

  @override
  String get startLiveLocation => 'Start Sharing';

  @override
  String get selectDuration => 'Select Duration';

  @override
  String get groupChatFiles => 'Chat Files';

  @override
  String get groupLinks => 'Links';

  @override
  String get groupNoLinks => 'No links yet';

  @override
  String get chatBackground => 'Chat Background';

  @override
  String get solidColors => 'Solid Colors';

  @override
  String get gradients => 'Gradients';

  @override
  String get defaultBackground => 'Default';

  @override
  String get settingsFontSizeSlider => 'Font Size';

  @override
  String get autoDownload => 'Auto-Download';

  @override
  String get images => 'Images';

  @override
  String get voice => 'Voice';

  @override
  String get video => 'Video';

  @override
  String get files => 'Files';

  @override
  String get mobileData => 'Mobile Data';

  @override
  String get roaming => 'Roaming';

  @override
  String get storageManagement => 'Storage';

  @override
  String get totalUsage => 'Total Usage';

  @override
  String get cache => 'Cache';

  @override
  String get other => 'Other';

  @override
  String get clearCache => 'Clear Cache';

  @override
  String get cacheCleared => 'Cache cleared';

  @override
  String get clearCacheFailed => 'Failed to clear cache';

  @override
  String get confirmClearCache => 'Clear all cache data?';

  @override
  String get mapView => 'Map View';

  @override
  String liveLocationSharingCount(int count) {
    return '$count people sharing location';
  }

  @override
  String get minutes15 => '15 minutes';

  @override
  String get minutes30 => '30 minutes';

  @override
  String get hour1 => '1 hour';

  @override
  String get hours8 => '8 hours';

  @override
  String get personalCard => 'Personal Card';

  @override
  String get downloadFailed => 'Download failed';

  @override
  String get locationExpired => 'Expired';

  @override
  String secondsRemaining(int count) {
    return '${count}s';
  }

  @override
  String minutesRemaining(int count) {
    return '${count}min';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '${hours}h ${minutes}min';
  }

  @override
  String get favoriteMessages => 'Favorites';

  @override
  String get linksCopied => 'Link copied';

  @override
  String get noLinksFound => 'No links found';

  @override
  String get roomStorageRanking => 'Room Storage Ranking';

  @override
  String get downloadComplete => 'Download complete';

  @override
  String get downloading => 'Downloading...';

  @override
  String get draftSaved => 'Draft saved';

  @override
  String get voiceRecording => 'Voice Recording';

  @override
  String get searchLocation => 'Search Location';

  @override
  String get tapToSearch => 'Tap to search';

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
