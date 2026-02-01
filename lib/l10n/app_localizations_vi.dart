// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class SVi extends S {
  SVi([String locale = 'vi']) : super(locale);

  @override
  String get chatModuleInitFailed => 'Khoi tao module chat that bai';

  @override
  String get checkNetworkRetry => 'Vui long kiem tra ket noi mang va thu lai';

  @override
  String get retry => 'Thu lai';

  @override
  String get unknownUser => 'Nguoi dung khong xac dinh';

  @override
  String get walletNotConnected => 'Vi chua ket noi';

  @override
  String get cannotGetWalletAddress => 'Khong the lay dia chi vi';

  @override
  String paymentRequestMemo(String requestId) {
    return 'Yeu cau thanh toan: $requestId';
  }

  @override
  String get callServiceNotInitialized => 'Dich vu goi chua khoi tao';

  @override
  String get alreadyInCall => 'Dang trong cuoc goi';

  @override
  String get meetingServiceNotInitialized => 'Dich vu hop chua khoi tao';

  @override
  String get livekitNotConfigured => 'LiveKit chua duoc cau hinh';

  @override
  String get unknownConversation => 'Cuoc tro chuyen khong xac dinh';

  @override
  String startCallFailed(String error) {
    return 'Bat dau cuoc goi that bai: $error';
  }

  @override
  String answerCallFailed(String error) {
    return 'Tra loi that bai: $error';
  }

  @override
  String get connectionFailed => 'Ket noi that bai';

  @override
  String get callRejected => 'Cuoc goi bi tu choi';

  @override
  String get noAnswer => 'Khong tra loi';

  @override
  String get invalidLoginResponse => 'Phan hoi dang nhap khong hop le';

  @override
  String loginFailed(String error) {
    return 'Dang nhap that bai: $error';
  }

  @override
  String get sessionRestoreFailed => 'Khoi phuc phien that bai';

  @override
  String get additionalVerificationRequired => 'Can xac minh bo sung';

  @override
  String registrationFailed(String error) {
    return 'Dang ky that bai: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'Khong the ket noi may chu: $error';
  }

  @override
  String get wrongUsernamePassword => 'Ten dang nhap hoac mat khau khong dung';

  @override
  String get usernameTaken => 'Ten dang nhap da duoc su dung';

  @override
  String get invalidUsernameFormat => 'Dinh dang ten dang nhap khong hop le';

  @override
  String get rateLimitExceeded => 'Qua nhieu yeu cau, vui long thu lai sau';

  @override
  String get loginExpired => 'Dang nhap het han';

  @override
  String joinMeetingFailed(String error) {
    return 'Tham gia cuoc hop that bai: $error';
  }

  @override
  String screenShareFailed(String error) {
    return 'Chia se man hinh that bai: $error';
  }

  @override
  String get answer => 'Tra loi';

  @override
  String get decline => 'Tu choi';

  @override
  String get missedCall => 'Cuoc goi nho';

  @override
  String get callBack => 'Goi lai';

  @override
  String get incomingCall => 'Cuoc goi den';

  @override
  String get missedVideoCall => 'Cuoc goi video nho';

  @override
  String get missedVoiceCall => 'Cuoc goi thoai nho';

  @override
  String get passkeyNotInitialized => 'Passkey chua khoi tao';

  @override
  String get googleSignInNotConfigured => 'Dang nhap Google chua cau hinh';

  @override
  String get encryptedMessage => '[Tin nhan ma hoa]';

  @override
  String get sticker => '[Nhan dan]';

  @override
  String get groupCreated => 'Nhom da duoc tao';

  @override
  String get groupNameChanged => 'Ten nhom da thay doi';

  @override
  String get groupAvatarChanged => 'Anh dai dien nhom da thay doi';

  @override
  String get groupAnnouncementChanged => 'Thong bao nhom da thay doi';

  @override
  String get image => '[Hinh anh]';

  @override
  String get video => '[Video]';

  @override
  String get voice => '[Tin nhan thoai]';

  @override
  String get file => '[Tep]';

  @override
  String get location => '[Vi tri]';

  @override
  String get unknownMessage => '[Tin nhan khong xac dinh]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName da tham gia nhom';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName da roi nhom';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName da duoc moi';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName da bi xoa';
  }

  @override
  String get avatarDataEmpty => 'Du lieu anh dai dien trong';

  @override
  String get avatarTooLarge => 'Tep anh dai dien qua lon, toi da 10MB';

  @override
  String get uploadAvatarFailed => 'Tai len anh dai dien that bai';

  @override
  String get delete => 'Xoa';

  @override
  String get notLoggedIn => 'Chua dang nhap';

  @override
  String roomNotExist(String roomId) {
    return 'Khong tim thay phong: $roomId';
  }

  @override
  String get uploadImageFailed => 'Tai len hinh anh that bai';

  @override
  String get matrixClientNotInitialized => 'Matrix client chua khoi tao';

  @override
  String get uploadVoiceFailed =>
      'Tai len tin nhan thoai that bai: Khong the lay MXC URI';

  @override
  String get uploadVideoFailed =>
      'Tai len video that bai: Khong the lay MXC URI';

  @override
  String get uploadFileFailed => 'Tai len tep that bai: Khong the lay MXC URI';

  @override
  String locationWithCoords(String lat, String lon) {
    return 'Vi tri: $lat, $lon';
  }

  @override
  String get myLocation => 'Vi tri cua toi';

  @override
  String get pollEnded => 'Binh chon da ket thuc';

  @override
  String get groupChat => 'Chat nhom';

  @override
  String get search => 'Tim kiem';

  @override
  String get cancel => 'Huy';

  @override
  String get userCancelled => 'Nguoi dung da huy';

  @override
  String get noData => 'Khong co du lieu';

  @override
  String get noSearchResults => 'Khong co ket qua tim kiem';

  @override
  String get tryDifferentKeyword => 'Thu tu khoa khac';

  @override
  String get loadFailed => 'Tai that bai';

  @override
  String get checkNetwork => 'Vui long kiem tra ket noi mang';

  @override
  String get networkConnectionFailed => 'Ket noi mang that bai';

  @override
  String get checkNetworkSettings => 'Vui long kiem tra cai dat mang';

  @override
  String get messages => 'Tin nhan';

  @override
  String get contacts => 'Danh ba';

  @override
  String get discover => 'Kham pha';

  @override
  String get me => 'Toi';

  @override
  String get voiceLoading => 'Dang tai tin nhan thoai, vui long thu lai sau';

  @override
  String get voiceToTextFailed => 'Chuyen giong noi thanh van ban that bai';

  @override
  String get converting => 'Dang chuyen doi...';

  @override
  String get convertToText => 'Chuyen thanh van ban';

  @override
  String get convertToTextTitle => 'Chuyen thanh van ban';

  @override
  String get selectEmoji => 'Chon bieu tuong cam xuc';

  @override
  String get frequentlyUsed => 'Thuong dung';

  @override
  String get copy => 'Sao chep';

  @override
  String get forward => 'Chuyen tiep';

  @override
  String get unfavorite => 'Bo yeu thich';

  @override
  String get favorite => 'Yeu thich';

  @override
  String get resend => 'Gui lai';

  @override
  String get recall => 'Thu hoi';

  @override
  String get multiSelect => 'Chon nhieu';

  @override
  String get quote => 'Trich dan';

  @override
  String get remind => 'Nhac nho';

  @override
  String get searchThis => 'Tim kiem';

  @override
  String get recallMessageConfirm => 'Thu hoi tin nhan nay?';

  @override
  String get youRecalledMessage => 'Ban da thu hoi mot tin nhan';

  @override
  String get otherRecalledMessage => 'Tin nhan da duoc thu hoi';

  @override
  String get reEdit => 'Chinh sua lai';

  @override
  String get copied => 'Da sao chep';

  @override
  String get sendMessageHint => 'Gui tin nhan';

  @override
  String get microphonePermissionRequired =>
      'Vui long cap quyen truy cap micro';

  @override
  String startRecordingFailed(String error) {
    return 'Bat dau ghi am that bai: $error';
  }

  @override
  String get recordingTooShort => 'Ban ghi qua ngan';

  @override
  String stopRecordingFailed(String error) {
    return 'Dung ghi am that bai: $error';
  }

  @override
  String get releaseToCancel => 'Tha de huy';

  @override
  String get releaseToSend => 'Tha de gui, vuot len de huy';

  @override
  String get holdToTalk => 'Giu de noi';

  @override
  String get send => 'Gui';

  @override
  String conversationWithId(String roomId) {
    return 'Cuoc tro chuyen: $roomId';
  }

  @override
  String contactWithId(String userId) {
    return 'Lien he: $userId';
  }

  @override
  String get addFriend => 'Them ban';

  @override
  String get chatServiceNotConnected => 'Dich vu chat chua ket noi';

  @override
  String userNotFoundHint(String query) {
    return 'Khong tim thay nguoi dung \"$query\"\n\nGoi y:\n• Thu nhap day du ID nguoi dung, vi du @username:server.com\n• Kiem tra chinh ta ten nguoi dung';
  }

  @override
  String createChatFailed(String error) {
    return 'Tao cuoc tro chuyen that bai: $error';
  }

  @override
  String searchFailed(String error) {
    return 'Tim kiem that bai: $error';
  }

  @override
  String get enterUserIdOrUsername =>
      'Nhap ID nguoi dung hoac ten dang nhap de tim kiem';

  @override
  String get searching => 'Dang tim kiem...';

  @override
  String get searchUserToChat => 'Tim nguoi dung de bat dau tro chuyen';

  @override
  String get matrixIdExample =>
      'Ban co the nhap day du Matrix ID\nvi du @user:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return 'Khong tim thay nguoi dung \"$username\"';
  }

  @override
  String get chat => 'Tro chuyen';

  @override
  String get settings => 'Cai dat';

  @override
  String get editProfile => 'Chinh sua ho so';

  @override
  String get login => 'Dang nhap';

  @override
  String get createGroup => 'Tao nhom';

  @override
  String developing(String title) {
    return '$title\n(Sap ra mat)';
  }

  @override
  String get error => 'Loi';

  @override
  String get pageNotFound => 'Khong tim thay trang';

  @override
  String get backToHome => 'Quay lai trang chu';

  @override
  String get allRead => 'Da doc tat ca';

  @override
  String readCount(int count) {
    return '$count da doc';
  }

  @override
  String get transfer => 'Chuyen tien';

  @override
  String get pendingReceipt => 'Cho xu ly';

  @override
  String get tapToReceive => 'Nhan de nhan';

  @override
  String get received => 'Da nhan';

  @override
  String get paymentReceived => 'Da nhan thanh toan';

  @override
  String get refunded => 'Da hoan tien';

  @override
  String get expired => 'Het han';

  @override
  String get redPacketGreeting => 'Chuc mung tot lanh';

  @override
  String get n42RedPacket => 'Li xi N42';

  @override
  String get goodLuck => 'Chuc may man';

  @override
  String get claimed => 'Da nhan';

  @override
  String get allClaimed => 'Da nhan het';

  @override
  String get emoji => 'Bieu tuong cam xuc';

  @override
  String get love => 'Yeu thuong';

  @override
  String get animals => 'Dong vat';

  @override
  String get food => 'Thuc an';

  @override
  String get travel => 'Du lich';

  @override
  String get activities => 'Hoat dong';

  @override
  String get objects => 'Do vat';

  @override
  String get symbols => 'Bieu tuong';

  @override
  String get reply => 'Tra loi';

  @override
  String get copiedToClipboard => 'Da sao chep vao clipboard';

  @override
  String get edit => 'Chinh sua';

  @override
  String get more => 'Them';

  @override
  String get selectForwardTarget => 'Chon nguoi nhan';

  @override
  String sendCount(int count) {
    return 'Gui ($count)';
  }

  @override
  String get draft => '[Ban nhap] ';

  @override
  String n42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get n42IdTitle => 'N42 ID';

  @override
  String get n42Bean => 'N42 Bean';

  @override
  String get friendInfo => 'Thong tin ban be';

  @override
  String get friendInfoDesc =>
      'Them ghi chu, dien thoai, the, ghi nhan, anh cua ban be va cai dat quyen.';

  @override
  String get moments => 'Khoang khac';

  @override
  String get sendMessage => 'Tin nhan';

  @override
  String get audioVideoCall => 'Goi Am thanh/Video';

  @override
  String get videoChannel => 'Kenh Video';

  @override
  String get remark => 'Ghi chu';

  @override
  String get remarkName => 'Ten ghi chu';

  @override
  String get phone => 'Dien thoai';

  @override
  String get tags => 'The';

  @override
  String get notes => 'Ghi chu';

  @override
  String get photos => 'Anh';

  @override
  String get permissions => 'Quyen';

  @override
  String get chatMomentsEtc => 'Chat, Khoang khac, The thao, v.v.';

  @override
  String get moreInfo => 'Thong tin them';

  @override
  String get commonGroups => 'Nhom chung';

  @override
  String get zeroGroups => '0';

  @override
  String get source => 'Nguon';

  @override
  String get notificationSettings => 'Thong bao';

  @override
  String get receiveNotifications => 'Nhan thong bao tin nhan moi';

  @override
  String get showPreview => 'Hien thi xem truoc tin nhan';

  @override
  String get showContentInNotification =>
      'Hien thi noi dung tin nhan trong thong bao';

  @override
  String get notificationSound => 'Am thanh thong bao';

  @override
  String get playSoundOnMessage => 'Phat am thanh khi nhan tin nhan';

  @override
  String get vibrate => 'Rung';

  @override
  String get vibrateOnMessage => 'Rung khi nhan tin nhan';

  @override
  String get doNotDisturb => 'Khong lam phien';

  @override
  String get dndDescription => 'Tat thong bao trong khung gio chi dinh';

  @override
  String get startTime => 'Thoi gian bat dau';

  @override
  String get endTime => 'Thoi gian ket thuc';

  @override
  String get privacy => 'Quyen rieng tu';

  @override
  String get appearance => 'Giao dien';

  @override
  String get about => 'Gioi thieu';

  @override
  String get logout => 'Dang xuat';

  @override
  String get logoutConfirm => 'Ban co chac muon dang xuat?';

  @override
  String get exit => 'Dang xuat';

  @override
  String get save => 'Luu';

  @override
  String get nickname => 'Biet danh';

  @override
  String get enterNickname => 'Nhap biet danh';

  @override
  String get signature => 'Chu ky';

  @override
  String get addSignature => 'Them chu ky';

  @override
  String get takePhoto => 'Chup anh';

  @override
  String get chooseFromGallery => 'Chon tu thu vien';

  @override
  String saveFailed(String error) {
    return 'Luu that bai: $error';
  }

  @override
  String get secureDecentralizedChat => 'Nhan tin bao mat, phi tap trung';

  @override
  String get endToEndEncryption => 'Ma hoa dau cuoi';

  @override
  String get messagesOnlyYouCanSee =>
      'Chi ban va nguoi nhan moi xem duoc tin nhan';

  @override
  String get decentralized => 'Phi tap trung';

  @override
  String get basedOnMatrix => 'Xay dung tren giao thuc mo Matrix';

  @override
  String get walletIntegration => 'Tich hop Vi';

  @override
  String get easyCryptoTransfer => 'Chuyen tien dien tu de dang';

  @override
  String get register => 'Dang ky';

  @override
  String get agreeTerms => 'Bang viec dang nhap, ban dong y voi';

  @override
  String get termsOfService => 'Dieu khoan Dich vu';

  @override
  String get and => 'va';

  @override
  String get privacyPolicy => 'Chinh sach Bao mat';

  @override
  String get serverAddress => 'Dia chi May chu';

  @override
  String get enterServerAddress => 'Nhap dia chi may chu';

  @override
  String get validServerAddress => 'Vui long nhap dia chi may chu hop le';

  @override
  String connectedTo(String serverName) {
    return 'Da ket noi toi $serverName';
  }

  @override
  String get username => 'Ten dang nhap';

  @override
  String get enterUsername => 'Nhap ten dang nhap';

  @override
  String get password => 'Mat khau';

  @override
  String get enterPassword => 'Nhap mat khau';

  @override
  String get registerAccount => 'Dang ky';

  @override
  String get forgotPassword => 'Quen mat khau';

  @override
  String get otherLoginMethods => 'Phuong thuc dang nhap khac';

  @override
  String get emailVerification => 'Ma xac minh email';

  @override
  String get enterServerFirst => 'Vui long nhap dia chi may chu truoc';

  @override
  String get passkeyNeedsServer => 'Dang nhap Passkey can ho tro may chu';

  @override
  String googleLoginSuccess(String email) {
    return 'Dang nhap Google thanh cong: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Dang nhap Google that bai: $error';
  }

  @override
  String get appleLoginSuccess => 'Dang nhap Apple thanh cong';

  @override
  String appleLoginFailed(String error) {
    return 'Dang nhap Apple that bai: $error';
  }

  @override
  String get createAccount => 'Tao tai khoan';

  @override
  String get joinN42Chat => 'Tham gia N42 Chat de bat dau tro chuyen';

  @override
  String get usernameHint => '3-20 ky tu, chu/so/_';

  @override
  String get usernameMinLength => 'Ten dang nhap phai co it nhat 3 ky tu';

  @override
  String get usernameMaxLength => 'Ten dang nhap toi da 20 ky tu';

  @override
  String get usernameFormat =>
      'Ten dang nhap chi co the chua chu, so va dau gach duoi';

  @override
  String get passwordHint => 'Toi thieu 8 ky tu';

  @override
  String get passwordMinLength => 'Mat khau phai co it nhat 8 ky tu';

  @override
  String get confirmPassword => 'Xac nhan mat khau';

  @override
  String get reEnterPassword => 'Nhap lai mat khau';

  @override
  String get passwordsNotMatch => 'Mat khau khong khop';

  @override
  String get inviteCode => 'Ma moi (tich hop san)';

  @override
  String get filled => 'Da dien';

  @override
  String get enterInviteCode => 'Nhap ma moi';

  @override
  String get inviteCodeHint =>
      'Ma moi da tich hop san, thuong khong can thay doi';

  @override
  String get agreeTermsFirst =>
      'Vui long doc va dong y voi dieu khoan va chinh sach bao mat truoc';

  @override
  String get iAgree => 'Toi da doc va dong y voi';

  @override
  String get alreadyHaveAccount => 'Da co tai khoan?';

  @override
  String get loginNow => 'Dang nhap ngay';

  @override
  String get whoCanSee => 'Ai co the xem';

  @override
  String get avatar => 'Anh dai dien';

  @override
  String get status => 'Trang thai';

  @override
  String get lastSeen => 'Lan cuoi truc tuyen';

  @override
  String get messageSettings => 'Tin nhan';

  @override
  String get allowStrangerMessage => 'Cho phep tin nhan tu nguoi la';

  @override
  String get receiveNonContact => 'Nhan tin nhan tu nguoi khong trong danh ba';

  @override
  String get readReceipts => 'Xac nhan da doc';

  @override
  String get letOthersKnowRead =>
      'Cho nguoi khac biet ban da doc tin nhan cua ho';

  @override
  String get typingStatus => 'Trang thai dang nhap';

  @override
  String get letOthersKnowTyping => 'Cho nguoi khac biet ban dang nhap';

  @override
  String get everyone => 'Tat ca moi nguoi';

  @override
  String get contactsOnly => 'Chi danh ba';

  @override
  String get nobody => 'Khong ai';

  @override
  String whoCanSeeItem(String title) {
    return 'Ai co the xem $title';
  }

  @override
  String version(String version) {
    return 'Phien ban $version';
  }

  @override
  String get checkUpdate => 'Kiem tra cap nhat';

  @override
  String get openSourceLicenses => 'Giay phep ma nguon mo';

  @override
  String get feedback => 'Phan hoi';

  @override
  String get builtOnMatrix => 'Xay dung tren giao thuc Matrix';

  @override
  String get loading => 'Dang tai...';

  @override
  String get noConversations => 'Khong co cuoc tro chuyen';

  @override
  String get tapToChat => 'Nhan vao goc tren ben phai de bat dau tro chuyen';

  @override
  String get startGroup => 'Bat dau Chat nhom';

  @override
  String get scan => 'Quet';

  @override
  String get payment => 'Thanh toan';

  @override
  String featureComingSoon(String feature) {
    return '$feature sap ra mat';
  }

  @override
  String get markAsRead => 'Danh dau da doc';

  @override
  String get unmute => 'Bo tat tieng';

  @override
  String get mute => 'Tat tieng';

  @override
  String get unpin => 'Bo ghim';

  @override
  String get pin => 'Ghim';

  @override
  String get deleteConversation => 'Xoa cuoc tro chuyen';

  @override
  String deleteConversationConfirm(String name) {
    return 'Xoa cuoc tro chuyen voi \"$name\"?';
  }

  @override
  String get noContacts => 'Khong co lien he';

  @override
  String get addFriendsToChat => 'Them ban de bat dau tro chuyen';

  @override
  String get contactNotFound => 'Khong tim thay lien he';

  @override
  String get tryOtherKeywords => 'Thu tu khoa khac hoac tim kiem toan cau';

  @override
  String get searchResults => 'Ket qua tim kiem';

  @override
  String get newFriends => 'Ban moi';

  @override
  String get chatOnlyFriends => 'Ban chi chat';

  @override
  String get officialAccounts => 'Tai khoan chinh thuc';

  @override
  String get serviceAccounts => 'Tai khoan dich vu';

  @override
  String get enterpriseContacts => 'Lien he doanh nghiep';

  @override
  String contactsCount(int count) {
    return '$count lien he';
  }

  @override
  String get recommendToFriend => 'Chia se lien he';

  @override
  String get setRemark => 'Dat ghi chu';

  @override
  String get addToHome => 'Them vao man hinh chinh';

  @override
  String get sendingCard => 'Dang gui the lien he...';

  @override
  String get contactCard => '[The Lien he]';

  @override
  String get fileLabel => 'Tep';

  @override
  String get locationLabel => 'Vi tri';

  @override
  String cardSent(String contact, String friend) {
    return 'Da gui the cua $contact cho $friend';
  }

  @override
  String recommendFailed(String error) {
    return 'Gioi thieu that bai: $error';
  }

  @override
  String get enterRemark => 'Nhap ghi chu';

  @override
  String remarkSet(String remark) {
    return 'Ghi chu da dat: $remark';
  }

  @override
  String get openingChat => 'Dang mo tro chuyen...';

  @override
  String openChatFailed(String error) {
    return 'Mo tro chuyen that bai: $error';
  }

  @override
  String get addContact => 'Them lien he';

  @override
  String get enterUserId => 'Nhap ID nguoi dung';

  @override
  String get noFriendRequests => 'Khong co yeu cau ket ban';

  @override
  String get accept => 'Chap nhan';

  @override
  String get reject => 'Tu choi';

  @override
  String acceptedRequest(String name) {
    return 'Da chap nhan yeu cau ket ban cua $name';
  }

  @override
  String rejectedRequest(String name) {
    return 'Da tu choi yeu cau ket ban cua $name';
  }

  @override
  String get noGroups => 'Khong co nhom';

  @override
  String get creatingGroup => 'Sap co tinh nang tao nhom...';

  @override
  String get selectFriendToRecommend => 'Chon ban de gioi thieu';

  @override
  String get searchContacts => 'Tim kiem lien he';

  @override
  String get noContactsFound => 'Khong tim thay lien he';

  @override
  String get yesterday => 'Hom qua';

  @override
  String get monday => 'T2';

  @override
  String get tuesday => 'T3';

  @override
  String get wednesday => 'T4';

  @override
  String get thursday => 'T5';

  @override
  String get friday => 'T6';

  @override
  String get saturday => 'T7';

  @override
  String get sunday => 'CN';

  @override
  String get justNow => 'Vua xong';

  @override
  String minutesAgo(int count) {
    return '$count phut truoc';
  }

  @override
  String hoursAgo(int count) {
    return '$count gio truoc';
  }

  @override
  String daysAgo(int count) {
    return '$count ngay truoc';
  }

  @override
  String get online => 'Truc tuyen';

  @override
  String get offline => 'Ngoai tuyen';

  @override
  String minutesAgoOnline(int count) {
    return 'Truc tuyen $count phut truoc';
  }

  @override
  String hoursAgoOnline(int count) {
    return 'Truc tuyen $count gio truoc';
  }

  @override
  String daysAgoOnline(int count) {
    return 'Truc tuyen $count ngay truoc';
  }

  @override
  String get searchContactsGroupsMessages => 'Tim lien he, nhom, tin nhan';

  @override
  String get searchError => 'Loi tim kiem';

  @override
  String get searchHint => 'Tim lien he, nhom va tin nhan';

  @override
  String get enterKeyword => 'Nhap tu khoa de tim kiem';

  @override
  String get searchHistory => 'Lich su tim kiem';

  @override
  String get clear => 'Xoa';

  @override
  String noResultsFor(String query) {
    return 'Khong co ket qua cho \"$query\"';
  }

  @override
  String get all => 'Tat ca';

  @override
  String get groups => 'Nhom';

  @override
  String get noResults => 'Khong co ket qua';

  @override
  String get groupInfo => 'Thong tin nhom';

  @override
  String groupMembers(int count) {
    return 'Thanh vien ($count)';
  }

  @override
  String get groupMembersTitle => 'Thành viên nhóm';

  @override
  String get viewAll => 'Xem tat ca';

  @override
  String get owner => 'Chu so huu';

  @override
  String get admin => 'Quan tri vien';

  @override
  String get invite => 'Moi';

  @override
  String get groupAnnouncement => 'Thong bao nhom';

  @override
  String get notSet => 'Chua dat';

  @override
  String get groupDescription => 'Mo ta nhom';

  @override
  String get publicGroup => 'Nhom cong khai';

  @override
  String get allowSearchJoin => 'Cho phep nguoi khac tim kiem va tham gia';

  @override
  String get clearChatHistory => 'Xoa lich su tro chuyen';

  @override
  String get dissolveGroup => 'Giai tan nhom';

  @override
  String get leaveGroup => 'Roi nhom';

  @override
  String get changeGroupName => 'Doi ten nhom';

  @override
  String get enterGroupName => 'Nhap ten nhom';

  @override
  String get confirm => 'Xac nhan';

  @override
  String get changeGroupDescription => 'Doi mo ta nhom';

  @override
  String get enterGroupDescription => 'Nhap mo ta nhom';

  @override
  String get editAnnouncement => 'Chinh sua thong bao';

  @override
  String get enterAnnouncement => 'Nhap thong bao';

  @override
  String get publish => 'Dang';

  @override
  String get clearHistoryConfirm =>
      'Xoa tat ca lich su tro chuyen? Hanh dong nay khong the hoan tac.';

  @override
  String get clearAction => 'Xoa';

  @override
  String get chatHistoryCleared => 'Da xoa lich su tro chuyen';

  @override
  String leaveGroupConfirm(String name) {
    return 'Roi nhom \"$name\"?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return 'Giai tan nhom \"$name\"? Hanh dong nay khong the hoan tac.';
  }

  @override
  String get dissolve => 'Giai tan';

  @override
  String get groupQrCode => 'Ma QR nhom';

  @override
  String get searchChatHistory => 'Tim kich su tro chuyen';

  @override
  String get groupIdCopied => 'Da sao chep ID nhom';

  @override
  String tapCopyGroupId(int count) {
    return '$count thanh vien · Nhan de sao chep ID nhom';
  }

  @override
  String get receiverAddress => 'Dia chi nguoi nhan';

  @override
  String get enterOrPasteAddress => 'Nhap hoac dan dia chi vi';

  @override
  String get selectToken => 'Chon Token';

  @override
  String get transferAmount => 'So tien chuyen';

  @override
  String get available => 'Kha dung';

  @override
  String get allAmount => 'Tat ca';

  @override
  String get memoOptional => 'Ghi chu (tuy chon)';

  @override
  String get addMemo => 'Them ghi chu';

  @override
  String get confirmTransfer => 'Xac nhan chuyen tien';

  @override
  String get invalidAddress => 'Vui long nhap dia chi nguoi nhan hop le';

  @override
  String get invalidAmount => 'Vui long nhap so tien hop le';

  @override
  String get selectTokenPlease => 'Vui long chon token';

  @override
  String get addressVerified => 'Dia chi da xac minh';

  @override
  String availableBalance(String balance, String symbol) {
    return 'Kha dung: $balance $symbol';
  }

  @override
  String get scanningInDevelopment => 'Tinh nang quet dang phat trien...';

  @override
  String get enterAmount => 'Nhap so tien';

  @override
  String get redPacketCountMin => 'Can it nhat 1 li xi';

  @override
  String get viewRedPacketDetails => 'Xem chi tiet li xi';

  @override
  String get enterTransferAmount => 'Nhap so tien chuyen';

  @override
  String get transferTo => 'Chuyen den';

  @override
  String get selectCurrency => 'Chon loai tien';

  @override
  String get receiveTransfer => 'Da nhan chuyen tien';

  @override
  String fromSender(String name, Object senderName) {
    return 'Tu $senderName';
  }

  @override
  String get confirmReceive => 'Xac nhan nhan';

  @override
  String get groupProfile => 'Thong tin nhom';

  @override
  String get viewProfile => 'Xem ho so';

  @override
  String get removeMember => 'Xoa khoi nhom';

  @override
  String removeMemberConfirm(String name) {
    return 'Xoa \"$name\" khoi nhom?';
  }

  @override
  String get remove => 'Xoa';

  @override
  String get clearStatus => 'Xoa trang thai';

  @override
  String get clearStatusConfirm => 'Xoa trang thai hien tai?';

  @override
  String get statusCleared => 'Da xoa trang thai';

  @override
  String statusSet(String result) {
    return 'Trang thai da dat: $result';
  }

  @override
  String get userNotExist => 'Nguoi dung khong ton tai';

  @override
  String get userIdCopied => 'Da sao chep ID nguoi dung';

  @override
  String get voiceCallInDevelopment => 'Goi thoai dang phat trien...';

  @override
  String get report => 'Bao cao';

  @override
  String get reportInDevelopment => 'Tinh nang bao cao dang phat trien...';

  @override
  String get shareCard => 'Chia se the';

  @override
  String get shareInDevelopment => 'Tinh nang chia se dang phat trien...';

  @override
  String get qrCode => 'Ma QR';

  @override
  String get qrCodeInDevelopment => 'Tinh nang ma QR dang phat trien...';

  @override
  String get avatarUpdated => 'Da cap nhat anh dai dien';

  @override
  String selectImageFailed(String error) {
    return 'Chon hinh anh that bai: $error';
  }

  @override
  String get changeName => 'Doi ten';

  @override
  String get male => 'Nam';

  @override
  String get female => 'Nu';

  @override
  String genderSet(String gender) {
    return 'Gioi tinh da dat: $gender';
  }

  @override
  String regionSet(String region) {
    return 'Khu vuc da dat: $region';
  }

  @override
  String get setPatText => 'Dat van ban vo vai';

  @override
  String get changeSignature => 'Doi chu ky';

  @override
  String ringtoneSet(String result) {
    return 'Nhac chuong da dat: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature dang phat trien...';
  }

  @override
  String saveAddressFailed(String error) {
    return 'Luu dia chi that bai: $error';
  }

  @override
  String get myAddress => 'Dia chi cua toi';

  @override
  String get addNew => 'Them';

  @override
  String get addAddress => 'Them dia chi';

  @override
  String get addressAdded => 'Da them dia chi';

  @override
  String get addressUpdated => 'Da cap nhat dia chi';

  @override
  String get deleteAddress => 'Xoa dia chi';

  @override
  String get deleteAddressConfirm => 'Xoa dia chi nay?';

  @override
  String get addressDeleted => 'Da xoa dia chi';

  @override
  String get setDefaultAddress => 'Dat lam mac dinh';

  @override
  String get fillCompleteInfo => 'Vui long dien day du thong tin';

  @override
  String saveInvoiceFailed(String error) {
    return 'Luu hoa don that bai: $error';
  }

  @override
  String get myInvoices => 'Hoa don cua toi';

  @override
  String get addInvoice => 'Them hoa don';

  @override
  String get invoiceAdded => 'Da them hoa don';

  @override
  String get invoiceUpdated => 'Da cap nhat hoa don';

  @override
  String get deleteInvoice => 'Xoa hoa don';

  @override
  String get deleteInvoiceConfirm => 'Xoa hoa don nay?';

  @override
  String get invoiceDeleted => 'Da xoa hoa don';

  @override
  String get invoiceType => 'Loai hoa don: ';

  @override
  String get personal => 'Ca nhan';

  @override
  String get enterprise => 'Doanh nghiep';

  @override
  String get setDefaultInvoice => 'Dat lam mac dinh';

  @override
  String get enterTaxId => 'Nhap ma so thue';

  @override
  String get vibrateMode => 'Che do rung';

  @override
  String get silentMode => 'Che do im lang';

  @override
  String playing(String ringtoneName) {
    return 'Dang phat: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return 'Phat that bai: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'Vui long nhap ten nhom';

  @override
  String get selectAtLeastOne => 'Vui long chon it nhat mot thanh vien';

  @override
  String get fillStatus => 'Viet trang thai';

  @override
  String get fileNotExist => 'Tep khong ton tai';

  @override
  String sendFailed(String error) {
    return 'Gui that bai: $error';
  }

  @override
  String get cannotOpenBrowser => 'Khong the mo trinh duyet';

  @override
  String selectFileFailed(String error) {
    return 'Chon tep that bai: $error';
  }

  @override
  String get enterMusicLink => 'Nhap lien ket nhac';

  @override
  String get enterValidLink => 'Vui long nhap lien ket hop le';

  @override
  String get enterPollQuestion => 'Nhap cau hoi binh chon';

  @override
  String get minTwoOptions => 'Can it nhat 2 lua chon';

  @override
  String get crossDeviceEnabled => 'Da bat ky da thiet bi';

  @override
  String get crossDeviceSet => 'Cai dat ky da thiet bi thanh cong';

  @override
  String setupFailed(String error) {
    return 'Cai dat that bai: $error';
  }

  @override
  String get receiveAmount => 'So tien nhan';

  @override
  String get enterValidAmount => 'Vui long nhap so tien hop le';

  @override
  String get addressCopied => 'Da sao chep dia chi';

  @override
  String openItem(String content) {
    return 'Mo: $content';
  }

  @override
  String get newNoteComingSoon => 'Tinh nang ghi chu moi sap ra mat';

  @override
  String get addLinkComingSoon => 'Tinh nang them lien ket sap ra mat';

  @override
  String get deleted => 'Da xoa';

  @override
  String get shareComingSoon => 'Tinh nang chia se sap ra mat';

  @override
  String get saveComingSoon => 'Tinh nang luu sap ra mat';

  @override
  String get moreStylesComingSoon => 'Them kieu sap ra mat';

  @override
  String get wallet => 'Vi';

  @override
  String get walletArea => 'Khu vuc vi';

  @override
  String get recording => 'Dang ghi am';

  @override
  String get invalidVideoUrl => 'URL video khong hop le';

  @override
  String get downloadFile => 'Tai tep xuong';

  @override
  String get clearChatHistoryTitle => 'Xoa lich su tro chuyen';

  @override
  String get cannotUndo => 'Hanh dong nay khong the hoan tac';

  @override
  String get videoCall => 'Goi Video';

  @override
  String get voiceCall => 'Goi Thoai';

  @override
  String get leaveMeeting => 'Roi cuoc hop';

  @override
  String get chatDetails => 'Chi tiet tro chuyen';

  @override
  String get viewAllGroupMembers => 'Xem tat ca thanh vien';

  @override
  String get groupName => 'Ten nhom';

  @override
  String get groupNameUpdated => 'Da cap nhat ten nhom';

  @override
  String get updateFailed => 'Cap nhat that bai';

  @override
  String get noPermissionToModify => 'Ban khong co quyen sua doi';

  @override
  String get groupManagement => 'Quan ly nhom';

  @override
  String get myNicknameInGroup => 'Biet danh trong nhom';

  @override
  String get pinChat => 'Ghim tro chuyen';

  @override
  String get strongReminder => 'Nhac nho manh';

  @override
  String get setChatBackground => 'Dat hinh nen tro chuyen';

  @override
  String get unknownFile => 'Tep khong xac dinh';

  @override
  String get download => 'Tai xuong';

  @override
  String get invalidLocation => 'Vi tri khong hop le';

  @override
  String get address => 'Dia chi';

  @override
  String get latitude => 'Vi do';

  @override
  String get longitude => 'Kinh do';

  @override
  String get close => 'Dong';

  @override
  String get tapToCancel => 'Nhan de huy';

  @override
  String captureFailed(Object error) {
    return 'Chup that bai: $error';
  }

  @override
  String get processingVideo => 'Dang xu ly video...';

  @override
  String get videoFileNotExist => 'Tep video khong ton tai';

  @override
  String get videoDataEmpty => 'Du lieu video trong';

  @override
  String get videoTooLarge => 'Kich thuoc video khong the vuot qua 100MB';

  @override
  String get sendingVideo => 'Dang gui video...';

  @override
  String sendVideoFailed(Object error) {
    return 'Gui video that bai: $error';
  }

  @override
  String get imageFileNotExist => 'Tep hinh anh khong ton tai';

  @override
  String get imageDataEmpty => 'Du lieu hinh anh trong';

  @override
  String get sendingImage => 'Dang gui hinh anh...';

  @override
  String sendImageFailed(Object error) {
    return 'Gui hinh anh that bai: $error';
  }

  @override
  String get sendLocation => 'Gui vi tri';

  @override
  String get selectLocationAndSend => 'Chon vi tri va gui';

  @override
  String get shareRealTimeLocation => 'Chia se vi tri thoi gian thuc';

  @override
  String get shareLocationForOneHour =>
      'Chia se vi tri thoi gian thuc voi ban trong 1 gio';

  @override
  String get locationSent => 'Da gui vi tri';

  @override
  String get selectMessages => 'Chon tin nhan';

  @override
  String selectedCount(int count) {
    return 'Da chon $count';
  }

  @override
  String get selectAll => 'Chon tat ca';

  @override
  String groupChatCount(int count) {
    return 'Chat nhom ($count)';
  }

  @override
  String get privateChat => 'Chat rieng';

  @override
  String get noMessages => 'Khong co tin nhan';

  @override
  String get sendFirstMessage => 'Gui tin nhan dau tien de bat dau tro chuyen';

  @override
  String get encryptionNotice =>
      'Cuoc tro chuyen nay duoc ma hoa dau cuoi. Chi ban va nguoi nhan moi doc duoc tin nhan.';

  @override
  String replyTo(String name) {
    return 'Tra loi $name';
  }

  @override
  String get multiForward => 'Chuyen tiep';

  @override
  String get collect => 'Luu tap';

  @override
  String get noMembers => 'Khong co thanh vien';

  @override
  String get memberNotFound => 'Khong tim thay thanh vien';

  @override
  String get voiceFileNotExist => 'Tep giong noi khong ton tai';

  @override
  String get voiceFileEmpty => 'Tep giong noi trong';

  @override
  String get sendingVoice => 'Dang gui tin nhan thoai...';

  @override
  String sendVoiceFailed(Object error) {
    return 'Gui tin nhan thoai that bai: $error';
  }

  @override
  String get messageCopied => 'Da sao chep tin nhan';

  @override
  String get messageForwarded => 'Da chuyen tiep tin nhan';

  @override
  String forwardFailed(Object error) {
    return 'Chuyen tiep that bai: $error';
  }

  @override
  String get unfavorited => 'Da bo yeu thich';

  @override
  String get favorited => 'Da yeu thich';

  @override
  String get reactionAdded => 'Da them phan ung';

  @override
  String get failedMessageDeleted => 'Da xoa tin nhan that bai';

  @override
  String get deleteMessages => 'Xoa tin nhan';

  @override
  String deleteMessagesConfirm(Object count) {
    return 'Ban co chac muon xoa $count tin nhan?';
  }

  @override
  String noteOtherMessages(Object count) {
    return 'Luu y: $count tin nhan tu nguoi khac, chi co the xoa cuc bo.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '$count tin nhan tu ban se bi thu hoi.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return 'Da thu hoi $count tin nhan, da xoa $localCount cuc bo';
  }

  @override
  String recalledMessages(Object count) {
    return 'Da thu hoi $count tin nhan';
  }

  @override
  String deletedLocally(Object count) {
    return 'Da xoa $count tin nhan (cuc bo)';
  }

  @override
  String forwardedCount(Object count) {
    return 'Da chuyen tiep $count tin nhan';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return 'Chuyen tiep hoan tat: $success thanh cong, $failed that bai';
  }

  @override
  String get remindOnlyInGroup =>
      'Tinh nang nhac nho chi kha dung trong chat nhom';

  @override
  String get onlyTextSearchable => 'Chi co the tim kiem tin nhan van ban';

  @override
  String searchFor(Object text) {
    return 'Tim \"$text\"';
  }

  @override
  String get baiduSearch => 'Tim Baidu';

  @override
  String get googleSearch => 'Tim Google';

  @override
  String get bingSearch => 'Tim Bing';

  @override
  String get calling => 'Dang goi...';

  @override
  String get connecting => 'Dang ket noi...';

  @override
  String get ringing => 'Dang reo...';

  @override
  String get inCall => 'Dang trong cuoc goi';

  @override
  String featureInDevelopment(String feature) {
    return 'Tinh nang dang phat trien...';
  }

  @override
  String collectMessages(Object count) {
    return 'Da luu $count tin nhan';
  }

  @override
  String get voted => 'Da binh chon';

  @override
  String get voteChanged => 'Da thay doi binh chon';

  @override
  String get voteRemoved => 'Da xoa binh chon';

  @override
  String get endPoll => 'Ket thuc binh chon';

  @override
  String get endPollConfirm =>
      'Ban co chac muon ket thuc binh chon nay? Khong the binh chon sau khi ket thuc.';

  @override
  String memberCount(int count) {
    return '$count thanh vien';
  }

  @override
  String get videoChannels => 'Kenh';

  @override
  String get live => 'Truc tiep';

  @override
  String get listen => 'Nghe';

  @override
  String get watch => 'Xem';

  @override
  String get searchDiscover => 'Tim kiem';

  @override
  String get nearbyPeople => 'Gan day';

  @override
  String get games => 'Tro choi';

  @override
  String get miniPrograms => 'Ung dung mini';

  @override
  String done(int count) {
    return 'Xong($count)';
  }

  @override
  String get services => 'Dich vu';

  @override
  String get favorites => 'Yeu thich';

  @override
  String get ordersAndCards => 'Don hang & The';

  @override
  String get stickers => 'Nhan dan';

  @override
  String statusSetTo(String status) {
    return 'Trang thai da dat: $status';
  }

  @override
  String get avatarUploadFailed => 'Tai len anh dai dien that bai';

  @override
  String get personalProfile => 'Ho so ca nhan';

  @override
  String get name => 'Ten';

  @override
  String get gender => 'Gioi tinh';

  @override
  String get region => 'Khu vuc';

  @override
  String get myQrCode => 'Ma QR cua toi';

  @override
  String get poke => 'Vo vai';

  @override
  String get ringtone => 'Nhac chuong';

  @override
  String get defaultRingtone => 'Nhac chuong mac dinh';

  @override
  String get myAddresses => 'Dia chi cua toi';

  @override
  String genderSetTo(String gender) {
    return 'Gioi tinh da dat: $gender';
  }

  @override
  String get selectRegion => 'Chon khu vuc';

  @override
  String get selectCity => 'Chon thanh pho';

  @override
  String regionSetTo(String region) {
    return 'Khu vuc da dat: $region';
  }

  @override
  String get setPoke => 'Dat vo vai';

  @override
  String get friendPokedMe => 'Ban be vo vai toi';

  @override
  String get enterPokeSuffix => 'Nhap hau to vo vai, vi du: vao vai';

  @override
  String get example => 'Vi du';

  @override
  String get onTheShoulder => ' vao vai';

  @override
  String get pokeCleared => 'Da xoa vo vai';

  @override
  String pokeSetTo(String suffix) {
    return 'Vo vai da dat: vo vai toi$suffix';
  }

  @override
  String get editSignature => 'Chinh sua chu ky';

  @override
  String get introduceYourself => 'Mot cau gioi thieu ban than';

  @override
  String get signatureCleared => 'Da xoa chu ky';

  @override
  String get signatureUpdated => 'Da cap nhat chu ky';

  @override
  String get scanToAddFriend => 'Quet ma QR tren de ket ban voi toi';

  @override
  String ringtoneSetTo(String ringtone) {
    return 'Nhac chuong da dat: $ringtone';
  }

  @override
  String confirmDissolveGroup(String name) {
    return 'Ban co chac chac muon giai tan \"$name\" khong? Hanh dong nay khong the hoan tac.';
  }

  @override
  String get enterValidServerAddress => 'Vui long nhap dia chi may chu hop le';

  @override
  String get emailOtp => 'OTP Email';

  @override
  String get enterServerAddressFirst => 'Vui long nhap dia chi may chu truoc';

  @override
  String get passkeyRequiresServer => 'Dang nhap Passkey can ho tro may chu';

  @override
  String get loginAgreement => 'Bang viec dang nhap, ban dong y voi ';

  @override
  String get pleaseAgreeToTerms =>
      'Vui long doc va dong y voi Dieu khoan Dich vu va Chinh sach Bao mat';

  @override
  String get registerFailed => 'Dang ky that bai';

  @override
  String get reenterPassword => 'Nhap lai mat khau';

  @override
  String get passwordsDoNotMatch => 'Mat khau khong khop';

  @override
  String get inviteCodeBuiltIn => 'Ma moi (tich hop san)';

  @override
  String get inviteCodeBuiltInNote =>
      'Ma moi da tich hop san, thuong khong can thay doi';

  @override
  String get iHaveReadAndAgree => 'Toi da doc va dong y voi ';

  @override
  String get startGroupChat => 'Bat dau Chat nhom';

  @override
  String get addFriends => 'Them ban';

  @override
  String get paymentAndCollection => 'Thanh toan';

  @override
  String messagesWithCount(int count) {
    return 'Tin nhan($count)';
  }

  @override
  String contactCount(int count) {
    return '$count lien he';
  }

  @override
  String get addToHomeScreen => 'Them vao man hinh chinh';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return 'Da gioi thieu the cua $contact cho $recipient';
  }

  @override
  String get enterRemarkName => 'Nhap ten ghi chu';

  @override
  String remarkSetTo(String remark) {
    return 'Ghi chu da dat: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return 'Da chap nhan yeu cau ket ban cua $name';
  }

  @override
  String rejectedFriendRequest(String name) {
    return 'Da tu choi yeu cau ket ban cua $name';
  }

  @override
  String get groupInvites => 'Loi moi nhom';

  @override
  String myGroups(int count) {
    return 'Nhom cua toi ($count)';
  }

  @override
  String get invitedToJoinGroup => 'Duoc moi tham gia nhom';

  @override
  String confirmLeaveGroup(String name) {
    return 'Ban co chac chac muon roi khoi \"$name\" khong?';
  }

  @override
  String get leave => 'Roi';

  @override
  String get saveMedia => 'Lưu';

  @override
  String get recallThisMessage => 'Thu hoi tin nhan nay?';

  @override
  String get messageRecalled => 'Tin nhan da thu hoi';

  @override
  String get savedToGallery => 'Da luu vao thu vien';

  @override
  String get failedToSave => 'Luu that bai';

  @override
  String get saving => 'Dang luu...';

  @override
  String get share => 'Chia se';

  @override
  String get saveToGallery => 'Luu vao Thu vien';

  @override
  String downloadFailed(String code) {
    return 'Tai xuong that bai: $code';
  }

  @override
  String get noMediaUrl => 'Khong co URL media';

  @override
  String shareFailed(String error) {
    return 'Chia se that bai: $error';
  }

  @override
  String get failedToLoadImage => 'Tai hinh anh that bai';

  @override
  String get failedToLoadMoreMessages => 'Tai them tin nhan that bai';

  @override
  String get failedToSend => 'Gui that bai';

  @override
  String get failedToSendImage => 'Gui hinh anh that bai';

  @override
  String get failedToSendVoice => 'Gui tin nhan thoai that bai';

  @override
  String get failedToSendFile => 'Gui tep that bai';

  @override
  String get failedToSendVideo => 'Gui video that bai';

  @override
  String get failedToSendLocation => 'Gui vi tri that bai';

  @override
  String get failedToResend => 'Gui lai that bai';

  @override
  String get failedToRecall => 'Thu hoi that bai';

  @override
  String get failedToReply => 'Tra loi that bai';

  @override
  String get failedToAddReaction => 'Them phan ung that bai';

  @override
  String get failedToSendPoll => 'Gui binh chon that bai';

  @override
  String get failedToVote => 'Binh chon that bai';

  @override
  String get failedToLoadMessages => 'Tai tin nhan that bai';

  @override
  String get callFeatureComingSoon => 'Tinh nang goi thoai va video sap ra mat';

  @override
  String get cannotForwardRedPacketOrTransfer =>
      'Khong the chuyen tiep li xi va chuyen tien';

  @override
  String get videoRecordingFailed => 'Quay video that bai. Vui long thu lai.';

  @override
  String get redPacket => 'Li xi';

  @override
  String get music => 'Nhac';

  @override
  String get coupon => 'Phieu giam gia';

  @override
  String get gift => 'Qua tang';

  @override
  String get poll => 'Binh chon';

  @override
  String get text => 'Van ban';

  @override
  String get link => 'Lien ket';

  @override
  String get note => 'Ghi chu';

  @override
  String get myNotes => 'Ghi chu cua toi';

  @override
  String get today => 'Hom nay';

  @override
  String daysAgoText(int count) {
    return '$count ngay truoc';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day/$month';
  }

  @override
  String get noFavorites => 'Chua co yeu thich';

  @override
  String get longPressToFavorite => 'Nhan giu tin nhan de yeu thich';

  @override
  String get newNote => 'Ghi chu moi';

  @override
  String get favoriteLink => 'Lien ket yeu thich';

  @override
  String get editTags => 'Chinh sua the';

  @override
  String get deleteFavorite => 'Xoa yeu thich';

  @override
  String get deleteFavoriteConfirm => 'Ban co chac muon xoa yeu thich nay?';

  @override
  String get noSearchResultsFound => 'Khong tim thay ket qua';

  @override
  String get sendRedPacket => 'Gui li xi';

  @override
  String get amount => 'So tien';

  @override
  String get redPacketCover => 'Bia li xi';

  @override
  String get redPacketType => 'Loai li xi';

  @override
  String get normalRedPacket => 'Thuong';

  @override
  String get luckyRedPacket => 'May man';

  @override
  String get redPacketCount => 'So li xi';

  @override
  String get pieces => 'cai';

  @override
  String get putMoneyInRedPacket => 'Bo tien vao li xi';

  @override
  String get redPacketRefundNotice => 'Li xi chua nhan se duoc hoan sau 24 gio';

  @override
  String get openRedPacket => 'Mo';

  @override
  String get redPacketAllClaimed => 'Li xi da nhan het';

  @override
  String get redPacketExpired => 'Li xi het han';

  @override
  String get addTransferNote => 'Them ghi chu chuyen tien';

  @override
  String get yuan => 'VND';

  @override
  String get savedToChangeCanTransfer =>
      'Da luu vao so du, co the chuyen truc tiep';

  @override
  String get replyWithEmoji => 'Tra loi bang bieu tuong nay';

  @override
  String get claimedYourRedPacket => 'da nhan li xi cua ban';

  @override
  String get claimedRedPacket => 'da nhan';

  @override
  String get otherTyping => 'dang nhap...';

  @override
  String get processing => 'Dang xu ly...';

  @override
  String get transferCancelled => 'Da huy chuyen tien';

  @override
  String get transferFailed => 'Chuyen tien that bai';

  @override
  String get creatingPaymentRequest => 'Dang tao yeu cau thanh toan...';

  @override
  String get processingPayment => 'Dang xu ly thanh toan...';

  @override
  String get paymentFailed => 'Thanh toan that bai';

  @override
  String get clickRetry => 'Nhan de thu lai';

  @override
  String get settingsTitle => 'Cai dat';

  @override
  String get editRemark => 'Chinh sua ghi chu';

  @override
  String get setPermissions => 'Dat quyen';

  @override
  String get recommendToFriends => 'Gioi thieu cho ban be';

  @override
  String get setStarFriend => 'Dat lam ban than';

  @override
  String get addToBlacklist => 'Them vao danh sach chan';

  @override
  String get complain => 'Bao cao';

  @override
  String get deleteContact => 'Xoa lien he';

  @override
  String deleteContactConfirm(String name) {
    return 'Ban co chac muon xoa $name?';
  }

  @override
  String get transferTitle => 'Chuyen tien';

  @override
  String get receiverAddressLabel => 'Dia chi nguoi nhan';

  @override
  String get selectTokenLabel => 'Chon Token';

  @override
  String get transferAmountLabel => 'So tien chuyen';

  @override
  String get memoLabel => 'Ghi chu (tuy chon)';

  @override
  String get enterOrPasteAddressHint => 'Nhap hoac dan dia chi vi';

  @override
  String get scanInDevelopment => 'Tinh nang quet dang phat trien...';

  @override
  String get availableLabel => 'Kha dung';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return 'Kha dung: $balance $symbol';
  }

  @override
  String get addMemoHint => 'Them ghi chu';

  @override
  String get receiveTitle => 'Nhan';

  @override
  String get walletNotConnectedTitle => 'Vi chua ket noi';

  @override
  String get connectWalletFirst => 'Vui long ket noi vi truoc';

  @override
  String get sendPaymentRequest => 'Gui yeu cau thanh toan';

  @override
  String get qrCodeGenerateFailed => 'Tao ma QR that bai';

  @override
  String get scanQrToPayMe => 'Quet ma QR de thanh toan cho toi';

  @override
  String get myWalletAddress => 'Dia chi vi cua toi';

  @override
  String get createPaymentRequest => 'Tao yeu cau thanh toan';

  @override
  String get selectTokenHint => 'Chon Token';

  @override
  String get amountLabel => 'So tien';

  @override
  String get cancelButton => 'Huy';

  @override
  String get sendRequestButton => 'Gui yeu cau';

  @override
  String get allReadReceipt => 'Tat ca da doc';

  @override
  String readCountReceipt(int count) {
    return '$count da doc';
  }

  @override
  String n42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get redPacketDefaultGreeting => 'Chuc mung tot lanh';

  @override
  String senderRedPacket(String name) {
    return 'Li xi cua $name';
  }

  @override
  String get allButton => 'Tất cả';

  @override
  String get enterValidAddress => 'Vui long nhap dia chi hop le';

  @override
  String get pleaseSelectToken => 'Vui long chon token';

  @override
  String get receivedTransfer => 'Da nhan chuyen tien';

  @override
  String get selectForwardRecipient => 'Chon nguoi nhan chuyen tiep';

  @override
  String get emojiFaces => 'Khuon mat';

  @override
  String get emojiHearts => 'Trai tim';

  @override
  String get emojiAnimals => 'Dong vat';

  @override
  String get emojiFood => 'Thuc an';

  @override
  String get emojiTransport => 'Giao thong';

  @override
  String get emojiActivities => 'Hoat dong';

  @override
  String get emojiObjects => 'Do vat';

  @override
  String get emojiSymbols => 'Bieu tuong';

  @override
  String get transferProcessing => 'Dang xu ly chuyen tien...';

  @override
  String senderSentRedPacket(String name) {
    return '$name da gui li xi';
  }

  @override
  String get savedToBalance => 'Da luu vao so du, co the chuyen truc tiep';

  @override
  String get redPacketExpiredOrEmpty => 'Li xi het han/da nhan het';

  @override
  String get scanFeatureComingSoon => 'Tinh nang quet sap ra mat...';

  @override
  String get setAsStarred => 'Dat lam yeu thich';

  @override
  String get addToBlocklist => 'Them vao danh sach chan';

  @override
  String get claimedYour => ' da nhan ';

  @override
  String get claimedText => ' da nhan ';

  @override
  String userTyping(String name) {
    return '$name dang nhap...';
  }

  @override
  String get typing => 'Dang nhap...';

  @override
  String get waitingToReceive => 'Cho nhan';

  @override
  String get tapToClaim => 'Nhan de nhan';

  @override
  String get hasBeenReceived => 'Da nhan';

  @override
  String get getLucky => 'Chuc may man';

  @override
  String get cameraStartFailed => 'Camera khoi dong that bai';

  @override
  String get unknownError => 'Loi khong xac dinh';

  @override
  String get placeQrCodeInFrame => 'Dat ma QR trong khung de quet';

  @override
  String get closeManualInput => 'Dong nhap thu cong';

  @override
  String get manualInputUserId => 'Nhap ID nguoi dung thu cong';

  @override
  String get add => 'Them';

  @override
  String get ringtoneClear => 'Xoa';

  @override
  String get ringtonePhone => 'Dien thoai';

  @override
  String get ringtoneClassic => 'Co dien';

  @override
  String get ringtoneSoft => 'Nhe nhang';

  @override
  String get ringtoneVibrate => 'Rung';

  @override
  String get ringtoneSilent => 'Im lang';

  @override
  String get stop => 'Dung';

  @override
  String get selectRingtone => 'Chon nhac chuong';

  @override
  String get loadingRingtones => 'Dang tai nhac chuong...';

  @override
  String get noRingtonesFound => 'Khong tim thay nhac chuong';

  @override
  String get moodAndThoughts => 'Tam trang & Suy nghi';

  @override
  String get statusHappy => 'Vui ve';

  @override
  String get statusCracked => 'Vo tan';

  @override
  String get statusLucky => 'May man';

  @override
  String get statusSunny => 'Nang ve';

  @override
  String get statusTired => 'Met moi';

  @override
  String get statusDaydream => 'Mo mong';

  @override
  String get statusRushing => 'Ban ron';

  @override
  String get statusOverthinking => 'Suy nghi qua nhieu';

  @override
  String get statusEnergized => 'Day nang luong';

  @override
  String get workAndStudy => 'Cong viec & Hoc tap';

  @override
  String get statusWorking => 'Dang lam viec';

  @override
  String get statusStudying => 'Dang hoc';

  @override
  String get statusBusy => 'Ban';

  @override
  String get statusSlacking => 'Nghi ngoi';

  @override
  String get statusTraveling => 'Di du lich';

  @override
  String get statusGoingHome => 'Ve nha';

  @override
  String get statusDnd => 'Khong lam phien';

  @override
  String get statusHanging => 'Di choi';

  @override
  String get statusCheckIn => 'Diem danh';

  @override
  String get statusExercising => 'Tap the duc';

  @override
  String get statusCoffee => 'Uong ca phe';

  @override
  String get statusBubbleTea => 'Uong tra sua';

  @override
  String get statusEating => 'An uong';

  @override
  String get statusParenting => 'Cham con';

  @override
  String get statusSavingWorld => 'Cuu the gioi';

  @override
  String get statusSelfie => 'Chup selfie';

  @override
  String get rest => 'Nghi ngoi';

  @override
  String get statusRetreat => 'An cu';

  @override
  String get statusHome => 'O nha';

  @override
  String get statusSleeping => 'Dang ngu';

  @override
  String get statusCatLover => 'Nguoi yeu meo';

  @override
  String get statusDogWalking => 'Dat cho di dao';

  @override
  String get statusGaming => 'Choi game';

  @override
  String get statusListening => 'Dang nghe';

  @override
  String get setStatus => 'Dat trang thai';

  @override
  String get visibleToFriends24h => 'Hien thi voi ban be trong 24 gio';

  @override
  String get writeStatus => 'Viet trang thai';

  @override
  String get enterYourStatus => 'Nhap trang thai...';

  @override
  String get ok => 'OK';

  @override
  String get cameraPermissionRequired => 'Can quyen camera de quet ma QR';

  @override
  String get cameraPermissionDenied =>
      'Quyen camera bi tu choi vinh vien. Vui long bat trong cai dat he thong.';

  @override
  String get cannotGetCameraPermission => 'Khong the lay quyen camera';

  @override
  String permissionCheckError(String error) {
    return 'Loi kiem tra quyen: $error';
  }

  @override
  String get invalidQrCode => 'Ma QR khong hop le';

  @override
  String qrCodeProcessFailed(String error) {
    return 'Xu ly ma QR that bai: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return 'Khong the ket ban: $error';
  }

  @override
  String get scanQrCode => 'Quet ma QR';

  @override
  String get checkingCameraPermission => 'Dang kiem tra quyen camera...';

  @override
  String get needCameraPermission => 'Can quyen camera';

  @override
  String get retryPermission => 'Thu lai';

  @override
  String get openSettings => 'Mo cai dat';

  @override
  String get inviteMembers => 'Moi thanh vien';

  @override
  String inviteCount(int count) {
    return 'Moi($count)';
  }

  @override
  String get noShippingAddress => 'Khong co dia chi giao hang';

  @override
  String get defaultLabel => 'Mac dinh';

  @override
  String get editAddress => 'Chinh sua dia chi';

  @override
  String get recipient => 'Nguoi nhan';

  @override
  String get enterRecipientName => 'Nhap ten nguoi nhan';

  @override
  String get phoneNumber => 'So dien thoai';

  @override
  String get enterPhoneNumber => 'Nhap so dien thoai';

  @override
  String get regionHint => 'Tinh/Thanh pho/Quan';

  @override
  String get detailedAddress => 'Dia chi chi tiet';

  @override
  String get detailedAddressHint => 'Duong, so nha, v.v.';

  @override
  String get setAsDefaultAddress => 'Dat lam dia chi mac dinh';

  @override
  String get pleaseCompleteInfo => 'Vui long dien day du thong tin';

  @override
  String get noInvoice => 'Khong co hoa don';

  @override
  String get company => 'Cong ty';

  @override
  String get taxNumber => 'Ma so thue';

  @override
  String get editInvoice => 'Chinh sua hoa don';

  @override
  String get companyName => 'Ten cong ty';

  @override
  String get enterCompanyName => 'Nhap ten cong ty';

  @override
  String get personalName => 'Ten ca nhan';

  @override
  String get enterName => 'Nhap ten';

  @override
  String get taxIdNumber => 'Ma so thue';

  @override
  String get enterTaxIdNumber => 'Nhap ma so thue';

  @override
  String get bankNameOptional => 'Ten ngan hang (Tuy chon)';

  @override
  String get enterBankName => 'Nhap ten ngan hang';

  @override
  String get bankAccountOptional => 'Tai khoan ngan hang (Tuy chon)';

  @override
  String get enterBankAccount => 'Nhap tai khoan ngan hang';

  @override
  String get companyAddressOptional => 'Dia chi cong ty (Tuy chon)';

  @override
  String get enterCompanyAddress => 'Nhap dia chi cong ty';

  @override
  String get companyPhoneOptional => 'Dien thoai cong ty (Tuy chon)';

  @override
  String get enterCompanyPhone => 'Nhap dien thoai cong ty';

  @override
  String get setAsDefaultInvoice => 'Dat lam hoa don mac dinh';

  @override
  String get confirmDeleteAddress => 'Ban co chac muon xoa dia chi nay?';

  @override
  String get confirmDeleteInvoice => 'Ban co chac muon xoa hoa don nay?';

  @override
  String get groupOwner => 'Chu so huu';

  @override
  String get groupAdmin => 'Quan tri vien';

  @override
  String get searchMembers => 'Tim thanh vien';

  @override
  String totalMembers(int count) {
    return '$count thanh vien';
  }

  @override
  String get removeFromGroup => 'Xoa khoi nhom';

  @override
  String confirmRemoveMember(String name) {
    return 'Ban co chac muon xoa \"$name\" khoi nhom?';
  }

  @override
  String get setAsAdmin => 'Dat lam quan tri vien';

  @override
  String get removeAdmin => 'Xoa quyen quan tri';

  @override
  String get deleteContactSuccess => 'Da xoa lien he';

  @override
  String get unknownSong => 'Bai hat khong xac dinh';

  @override
  String get unknownArtist => 'Nghe si khong xac dinh';

  @override
  String get unknownContact => 'Lien he khong xac dinh';

  @override
  String get personalCard => 'The lien he';

  @override
  String get singleChoice => 'Chon mot';

  @override
  String get multiChoice => 'Chon nhieu';

  @override
  String get ended => 'Ket thuc';

  @override
  String get endPollButton => 'Ket thuc binh chon';

  @override
  String get createPoll => 'Tao binh chon';

  @override
  String get pollQuestion => 'Cau hoi binh chon';

  @override
  String get pollOptions => 'Cac lua chon';

  @override
  String optionPlaceholder(int index) {
    return 'Lua chon $index';
  }

  @override
  String get addOption => 'Them lua chon';

  @override
  String get pollSettings => 'Cai dat binh chon';

  @override
  String get anonymousPoll => 'Binh chon an danh';

  @override
  String get pollHint =>
      'Binh chon se hien trong chat. Thanh vien nhom co the binh chon.';

  @override
  String get searchSongOrArtist => 'Tim bai hat hoac nghe si';

  @override
  String get noSongsFound => 'Khong tim thay bai hat';

  @override
  String get supportedMusicPlatforms =>
      'Ho tro lien ket nhac tu NetEase, QQ Music, v.v.';

  @override
  String get songNameOptional => 'Ten bai hat (Tuy chon)';

  @override
  String get enterSongName => 'Nhap ten bai hat';

  @override
  String get artistNameOptional => 'Ten nghe si (Tuy chon)';

  @override
  String get enterArtistName => 'Nhap ten nghe si';

  @override
  String get shareSong => 'Chia se bai hat';

  @override
  String get realTimeLocationSharing =>
      'Chia se vi tri thoi gian thuc dang phat trien...';

  @override
  String get voiceCallFeatureInDev => 'Tinh nang goi thoai dang phat trien...';

  @override
  String get reportFeatureInDev => 'Tinh nang bao cao dang phat trien...';

  @override
  String get shareFeatureInDev => 'Tinh nang chia se dang phat trien...';

  @override
  String get qrCodeFeatureInDev => 'Tinh nang ma QR dang phat trien...';

  @override
  String get scanQrToAddMe => 'Quet ma QR tren de ket ban voi toi';

  @override
  String get saveToAlbum => 'Luu vao Album';

  @override
  String get changeStyle => 'Doi kieu';

  @override
  String get copyId => 'Sao chep ID';

  @override
  String get idCopied => 'Da sao chep ID';

  @override
  String get shareFeatureComingSoon => 'Tinh nang chia se sap ra mat';

  @override
  String get saveFeatureComingSoon => 'Tinh nang luu sap ra mat';

  @override
  String get moreStylesFeatureComingSoon => 'Them kieu sap ra mat';

  @override
  String get confirmEndPoll => 'Ban co chac muon ket thuc binh chon nay?';

  @override
  String get cannotVoteAfterEnd => 'Khong the binh chon sau khi ket thuc.';

  @override
  String get bio => 'Tieu su';

  @override
  String get homeServer => 'May chu';

  @override
  String get shareContactCard => 'Chia se the lien he';

  @override
  String get removeFromBlacklist => 'Xoa khoi danh sach chan';

  @override
  String get confirmAddBlacklist =>
      'Ban co chac muon them nguoi nay vao danh sach chan? Ban se khong nhan tin nhan tu ho.';

  @override
  String get confirmRemoveBlacklist =>
      'Ban co chac muon xoa nguoi nay khoi danh sach chan?';

  @override
  String get remarkSaved => 'Da luu ghi chu';

  @override
  String get remarkCleared => 'Da xoa ghi chu';

  @override
  String get receive => 'Nhan';

  @override
  String get pleaseConnectWallet => 'Vui long ket noi vi truoc';

  @override
  String get sendRequest => 'Gui yeu cau';

  @override
  String get pleaseEnterValidAmount => 'Vui long nhap so tien hop le';

  @override
  String get searchPlaceholder => 'Tim lien he, nhom, tin nhan';

  @override
  String get enterKeywordToSearch => 'Nhap tu khoa de bat dau tim kiem';

  @override
  String get clearHistory => 'Xoa';

  @override
  String noResultsForQuery(String query) {
    return 'Khong tim thay ket qua cho \"$query\"';
  }

  @override
  String get allResults => 'Tat ca';

  @override
  String get searchInChat => 'Tim trong tro chuyen';

  @override
  String get contactLabel => 'Lien he';

  @override
  String get groupLabel => 'Nhom';

  @override
  String get conversationLabel => 'Cuộc trò chuyện';

  @override
  String get messageLabel => 'Tin nhan';

  @override
  String get securityTitle => 'Bao mat';

  @override
  String get keyBackup => 'Sao luu khoa';

  @override
  String get backupEncryptionKeys => 'Sao luu khoa ma hoa';

  @override
  String keysBackedUp(int count) {
    return '$count khoa da sao luu';
  }

  @override
  String get backupNotSet => 'Chua dat sao luu';

  @override
  String get restoreKeys => 'Khoi phuc khoa';

  @override
  String get restoreKeysFromBackup => 'Khoi phuc khoa ma hoa tu ban sao luu';

  @override
  String get exportKeys => 'Xuat khoa';

  @override
  String get exportKeysToFile => 'Xuat khoa ra tep';

  @override
  String get loggedInDevices => 'Thiet bi da dang nhap';

  @override
  String get noOtherDevices => 'Khong co thiet bi khac';

  @override
  String get verified => 'Da xac minh';

  @override
  String get unverified => 'Chua xac minh';

  @override
  String get advanced => 'Nang cao';

  @override
  String get crossSigning => 'Ky cheo';

  @override
  String get enabled => 'Da bat';

  @override
  String get notEnabled => 'Chua bat';

  @override
  String get resetEncryption => 'Dat lai ma hoa';

  @override
  String get deleteAllEncryptionKeys => 'Xoa tat ca khoa ma hoa';

  @override
  String get encryptionNotSupported => 'Khong ho tro ma hoa';

  @override
  String get notInitialized => 'Chua khoi tao';

  @override
  String get backupKeyTitle => 'Sao luu khoa';

  @override
  String get backupKeyMessage =>
      'Tao ban sao luu khoa moi? Dieu nay se giup ban khoi phuc tin nhan ma hoa tren thiet bi moi.';

  @override
  String get backup => 'Sao luu';

  @override
  String get restoreKeyTitle => 'Khoi phuc khoa';

  @override
  String get restoreKeyMessage =>
      'Nhap mat khau khoi phuc hoac khoa khoi phuc de khoi phuc tin nhan ma hoa.';

  @override
  String get restore => 'Khoi phuc';

  @override
  String get exportKeyTitle => 'Xuat khoa';

  @override
  String get exportKeyMessage =>
      'Tep khoa xuat chua tat ca khoa ma hoa cua ban. Vui long giu an toan.';

  @override
  String get export => 'Xuat';

  @override
  String deviceIdLabel(String deviceId) {
    return 'ID thiet bi: $deviceId';
  }

  @override
  String get deviceStatusVerified => 'Trang thai: Da xac minh';

  @override
  String get deviceStatusUnverified => 'Trang thai: Chua xac minh';

  @override
  String lastActiveLabel(String lastSeen) {
    return 'Hoat dong cuoi: $lastSeen';
  }

  @override
  String get verifyThisDevice => 'Xac minh thiet bi nay';

  @override
  String get crossSigningAlreadyEnabled => 'Ky cheo da duoc bat';

  @override
  String get crossSigningSetupSuccess => 'Cai dat ky cheo thanh cong';

  @override
  String get resetEncryptionTitle => 'Dat lai ma hoa';

  @override
  String get resetEncryptionWarning =>
      'Canh bao: Hanh dong nay se xoa tat ca khoa ma hoa cua ban. Ban se khong the giai ma tin nhan ma hoa truoc do. Hanh dong nay khong the hoan tac.';

  @override
  String get reset => 'Dat lai';

  @override
  String get leaveMeetingConfirm => 'Ban co chac muon roi cuoc hop?';

  @override
  String pokedSomeone(String name, String suffix) {
    return 'da vo vai $name$suffix';
  }

  @override
  String get noContactsToAdd => 'Khong co lien he de them';

  @override
  String get addMembers => 'Them thanh vien';

  @override
  String invitedMembers(int count) {
    return 'Da moi $count thanh vien';
  }

  @override
  String inviteFailed(String error) {
    return 'Moi that bai: $error';
  }

  @override
  String get memberRemoved => 'Da xoa thanh vien';

  @override
  String removeFailed(String error) {
    return 'Xoa that bai: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      'Sau khi chia se, nguoi kia co the thay vi tri thoi gian thuc cua ban trong 1 gio.';

  @override
  String get startSharing => 'Bat dau chia se';

  @override
  String get locationServiceNotEnabled => 'Dich vu vi tri chua duoc bat';

  @override
  String get enableLocationService =>
      'Vui long bat dich vu vi tri de su dung tinh nang nay';

  @override
  String get goToSettings => 'Di den Cai dat';

  @override
  String get locationPermissionRequired => 'Can quyen vi tri cho tinh nang nay';

  @override
  String get locationPermissionDeniedPermanent =>
      'Quyen vi tri bi tu choi vinh vien. Vui long bat trong cai dat.';

  @override
  String get locationPermissionDenied => 'Quyen vi tri bi tu choi';

  @override
  String get gettingLocation => 'Dang lay vi tri...';

  @override
  String getLocationFailed(String error) {
    return 'Lay vi tri that bai: $error';
  }

  @override
  String get currentLocation => 'Vi tri hien tai';

  @override
  String nearbyPlace(int index) {
    return 'Dia diem gan $index';
  }

  @override
  String approximateDistance(String distance) {
    return 'Khoang $distance';
  }

  @override
  String get mapPreview => 'Xem truoc ban do';

  @override
  String get searchLocation => 'Tim vi tri';

  @override
  String redPacketSent(String amount, String token) {
    return 'Da gui li xi $amount $token';
  }

  @override
  String get transferDefault => 'Chuyen tien';

  @override
  String transferSent(String amount, String token) {
    return 'Da gui chuyen tien $amount $token';
  }

  @override
  String pickFileFailed(String error) {
    return 'Chon tep that bai: $error';
  }

  @override
  String get fileSizeLimit => 'Kich thuoc tep khong the vuot qua 50MB';

  @override
  String fileSending(String filename) {
    return 'Dang gui tep: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'Gui tep that bai: $error';
  }

  @override
  String contactCardSent(String name) {
    return 'Da gui the lien he cua $name';
  }

  @override
  String get favoritesFeature => 'Yeu thich';

  @override
  String get couponsFeature => 'Phieu giam gia';

  @override
  String get giftFeature => 'Qua tang';

  @override
  String sharedMusic(String name) {
    return 'Da chia se $name';
  }

  @override
  String get endPollTitle => 'Ket thuc binh chon';

  @override
  String get endPollConfirmMessage =>
      'Ban co chac muon ket thuc binh chon nay? Binh chon se dong sau khi ket thuc.';

  @override
  String get pollEndedMessage => 'Binh chon da ket thuc';

  @override
  String get connectingCall => 'Đang kết nối...';

  @override
  String get muteCall => 'Tat tieng';

  @override
  String get speakerOff => 'Tat loa';

  @override
  String get speakerOn => 'Loa';

  @override
  String get cameraOn => 'Bat camera';

  @override
  String get cameraOff => 'Tat camera';

  @override
  String get hangUp => 'Cup may';

  @override
  String get selectForwardTargetTitle => 'Chon muc tieu chuyen tiep';

  @override
  String get noForwardableChat => 'Khong co tro chuyen de chuyen tiep';

  @override
  String get noMatchingChat => 'Khong tim thay tro chuyen phu hop';

  @override
  String get imagePreview => '[Hinh anh]';

  @override
  String get voicePreview => '[Tin nhan thoai]';

  @override
  String get videoPreview => '[Video]';

  @override
  String filePreviewWithName(String filename) {
    return '[Tep] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[Vi tri] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[Nhac] $title';
  }

  @override
  String get messagePreview => '[Tin nhan]';

  @override
  String get locationTitle => 'Vi tri';

  @override
  String get sendButton => 'Gui';

  @override
  String get retryButton => 'Thu lai';

  @override
  String get selectContact => 'Chon lien he';

  @override
  String get searchContactHint => 'Tim lien he';

  @override
  String get shareMusic => 'Chia se nhac';

  @override
  String get recentPlayed => 'Gan day';

  @override
  String get myFavorites => 'Yeu thich';

  @override
  String get networkLink => 'Lien ket';

  @override
  String get localFile => 'Tep';

  @override
  String get musicLinkRequired => 'Lien ket nhac *';

  @override
  String get pasteMusicLink => 'Dan lien ket nhac';

  @override
  String get enterSongNamePlaceholder => 'Nhap ten bai hat';

  @override
  String get enterArtistNamePlaceholder => 'Nhap ten nghe si';

  @override
  String get shareMusicButton => 'Chia se nhac';

  @override
  String get selectLocalAudio => 'Chon tep am thanh';

  @override
  String get supportedAudioFormats => 'Ho tro MP3, M4A, WAV, FLAC, v.v.';

  @override
  String get selectFileButton => 'Chon tep';

  @override
  String get pleaseEnterMusicLink => 'Vui long nhap lien ket nhac';

  @override
  String get pleaseEnterValidLink => 'Vui long nhap URL hop le';

  @override
  String get sharedSong => 'Bai hat da chia se';

  @override
  String get selectMember => 'Chon thanh vien';

  @override
  String get searchMemberHint => 'Tim thanh vien';

  @override
  String get noMatchingMembers => 'Khong tim thay thanh vien phu hop';

  @override
  String get unknownMember => 'Khong xac dinh';

  @override
  String selectedMessagesCount(int count) {
    return 'Da chon $count tin nhan';
  }

  @override
  String get searchContactsOrGroups => 'Tim lien he hoac nhom';

  @override
  String get noMatchingConversations => 'Khong tim thay tro chuyen phu hop';

  @override
  String get videoTitle => 'Video';

  @override
  String get loadingText => 'Dang tai...';

  @override
  String get videoPlaybackFailed => 'Phat video that bai';

  @override
  String get videoLoadFailed => 'Tai video that bai';

  @override
  String get playerInitFailed => 'Khoi tao trinh phat that bai';

  @override
  String get createPollTitle => 'Tao binh chon';

  @override
  String get submitPoll => 'Gui';

  @override
  String get pollQuestionLabel => 'Cau hoi binh chon';

  @override
  String get enterPollQuestionHint => 'Vui long nhap cau hoi binh chon';

  @override
  String get pollOptionsLabel => 'Cac lua chon';

  @override
  String optionHintWithIndex(int index) {
    return 'Lua chon $index';
  }

  @override
  String get addOptionButton => 'Them lua chon';

  @override
  String get pollSettingsLabel => 'Cai dat binh chon';

  @override
  String get selectionType => 'Loai chon';

  @override
  String get singleChoiceLabel => 'Chon mot';

  @override
  String get multiChoiceLabel => 'Chon nhieu';

  @override
  String get anonymousPollSwitch => 'Binh chon an danh';

  @override
  String get pleaseEnterQuestion => 'Vui long nhap cau hoi binh chon';

  @override
  String get atLeastTwoOptions => 'Can it nhat 2 lua chon';

  @override
  String confirmWithCount(int count) {
    return 'Xac nhan ($count)';
  }

  @override
  String get emailVerificationTitle => 'Xac minh Email';

  @override
  String get enterValidEmailAddress => 'Vui long nhap dia chi email hop le';

  @override
  String verificationCodeSentTo(String email) {
    return 'Ma xac minh da gui den $email';
  }

  @override
  String sendCodeFailed(String error) {
    return 'Gui ma that bai: $error';
  }

  @override
  String get verificationSuccess => 'Xac minh thanh cong';

  @override
  String get verificationFailed => 'Xac minh that bai';

  @override
  String verificationCodeError(String error) {
    return 'Loi ma xac minh: $error';
  }

  @override
  String get enterVerificationCode => 'Nhap ma xac minh';

  @override
  String get enterYourEmail => 'Nhap email';

  @override
  String weSentCodeTo(String email) {
    return 'Chung toi da gui ma 6 so den\n$email';
  }

  @override
  String get enterEmailForCode =>
      'Nhap dia chi email, chung toi se gui ma xac minh';

  @override
  String get sendVerificationCode => 'Gui ma xac minh';

  @override
  String get resendVerificationCode => 'Gui lai ma xac minh';

  @override
  String canResendAfter(int seconds) {
    return 'Co the gui lai sau $seconds giay';
  }

  @override
  String get changeEmail => 'Doi email';

  @override
  String get addToContacts => 'Them vao danh ba';

  @override
  String get addingToContacts => 'Dang them...';

  @override
  String get addedToContacts => 'Da them vao danh ba';

  @override
  String addFailedWithError(String error) {
    return 'Them that bai: $error';
  }

  @override
  String get addPhone => 'Them dien thoai';

  @override
  String get addTag => 'Them the';

  @override
  String get addText => 'Them van ban';

  @override
  String get addPhoto => 'Them anh';

  @override
  String groupCountLabel(int count) {
    return '$count nhom';
  }

  @override
  String get addedViaSearch => 'Da them qua tim kiem';

  @override
  String get addTime => 'Thoi gian them';

  @override
  String get doneButton => 'Xong';

  @override
  String get waitingForParticipants => 'Dang cho nguoi tham gia...';

  @override
  String participantMe(String name) {
    return '$name (Toi)';
  }

  @override
  String get sharingLabel => 'Dang chia se';

  @override
  String screenSharingBy(String name) {
    return '$name dang chia se man hinh';
  }

  @override
  String participantCount(int count) {
    return '$count nguoi tham gia';
  }

  @override
  String get muteLabel => 'Tat tieng';

  @override
  String get unmuteLabel => 'Bat tieng';

  @override
  String get turnOffVideo => 'Tat video';

  @override
  String get turnOnVideo => 'Bat video';

  @override
  String get shareScreen => 'Chia se man hinh';

  @override
  String get stopSharing => 'Dung chia se';

  @override
  String get switchCameraLabel => 'Chuyen';

  @override
  String get leaveLabel => 'Roi';

  @override
  String get participantsLabel => 'Nguoi tham gia';

  @override
  String get joiningMeeting => 'Dang tham gia cuoc hop...';

  @override
  String pollVotesFormat(int count, String percentage) {
    return '$count phiếu ($percentage%)';
  }

  @override
  String pollParticipantsFormat(int count) {
    return '$count người tham gia';
  }

  @override
  String get tapToRetry => 'Nhấn để thử lại';

  @override
  String get noConversationsToForward =>
      'Không có cuộc trò chuyện nào để chuyển tiếp';

  @override
  String get defaultRedPacketGreeting => 'Chúc phát tài phát lộc';

  @override
  String get emojiCategoryFace => 'Biểu cảm';

  @override
  String get emojiCategoryHeart => 'Trái tim';

  @override
  String get emojiCategoryAnimal => 'Động vật';

  @override
  String get emojiCategoryFood => 'Đồ ăn';

  @override
  String get emojiCategoryTransport => 'Phương tiện';

  @override
  String get emojiCategoryActivity => 'Hoạt động';

  @override
  String get emojiCategoryObject => 'Đồ vật';

  @override
  String get emojiCategorySymbol => 'Ký hiệu';

  @override
  String get allowOthersToSearchAndJoin =>
      'Cho phép những người khác tìm kiếm và tham gia';

  @override
  String get allowStrangerMessages => 'Cho phép tin nhắn từ người lạ';

  @override
  String get alwaysUseDarkTheme => 'Luôn dùng giao diện tối';

  @override
  String get alwaysUseLightTheme => 'Luôn dùng giao diện sáng';

  @override
  String get autoSwitchBySystem => 'Tự động chuyển theo cài đặt hệ thống';

  @override
  String get bubbleStyle => 'Kiểu bong bóng';

  @override
  String get bubbleStyleClassic => 'Kiểu cổ điển';

  @override
  String get bubbleStyleClassicDesc => 'Kiểu bong bóng truyền thống';

  @override
  String get bubbleStyleModern => 'Kiểu hiện đại';

  @override
  String get bubbleStyleModernDesc => 'Kiểu bong bóng hiện đại sạch sẽ';

  @override
  String get bubbleStyleWechat => 'Kiểu WeChat';

  @override
  String get bubbleStyleWechatDesc => 'Kiểu bong bóng WeChat cổ điển';

  @override
  String get callEnded => 'Cuộc gọi kết thúc';

  @override
  String get callFailed => 'Cuộc gọi thất bại';

  @override
  String get checkForUpdates => 'Kiểm tra cập nhật';

  @override
  String get confirmClearChatHistory =>
      'Bạn có chắc chắn muốn xóa lịch sử trò chuyện không?';

  @override
  String get createGroupToChat => 'Tạo một nhóm để bắt đầu trò chuyện';

  @override
  String get darkMode => 'Chế độ tối';

  @override
  String get darkModeOption => 'Chế độ tối';

  @override
  String get doNotDisturbDescription =>
      'Không nhận thông báo trong khoảng thời gian chỉ định';

  @override
  String get doNotDisturbMode => 'Không làm phiền';

  @override
  String get editGroupAnnouncement => 'Chỉnh sửa thông báo nhóm';

  @override
  String get editGroupDescription => 'Chỉnh sửa mô tả nhóm';

  @override
  String get enterGroupAnnouncement => 'Nhập thông báo nhóm';

  @override
  String errorWithMessage(String message) {
    return 'Lỗi: $message';
  }

  @override
  String get feedbackAndSuggestions => 'Phản hồi và đề xuất';

  @override
  String get followSystem => 'Theo hệ thống';

  @override
  String get fontSize => 'Cỡ chữ';

  @override
  String get fontSizeExtraLarge => 'Rất lớn';

  @override
  String get fontSizeLarge => 'Lớn';

  @override
  String get fontSizeSmall => 'Nhỏ';

  @override
  String get fontSizeStandard => 'Tiêu chuẩn';

  @override
  String get incomingVideoCall => 'Cuộc gọi video đến';

  @override
  String get incomingVoiceCall => 'Cuộc gọi thoại đến';

  @override
  String get letOthersKnowYouRead =>
      'Cho người khác biết bạn đã đọc tin nhắn của họ';

  @override
  String get letOthersKnowYouTyping => 'Cho người khác biết bạn đang nhập';

  @override
  String get lightMode => 'Chế độ sáng';

  @override
  String memberCountClickToCopy(int count) {
    return '$count thành viên, nhấp để sao chép ID nhóm';
  }

  @override
  String get messageNotifications => 'Thông báo tin nhắn';

  @override
  String get messagesLabel => 'Tin nhắn';

  @override
  String get musicLinkLabel => 'Liên kết nhạc';

  @override
  String get noMediaUrlAvailable => 'URL phương tiện không khả dụng';

  @override
  String get noPermissionToEditGroupName =>
      'Bạn không có quyền chỉnh sửa tên nhóm';

  @override
  String get receiveMessagesFromNonContacts =>
      'Nhận tin nhắn từ người không có trong danh bạ';

  @override
  String get receiveNewMessageNotifications => 'Nhận thông báo tin nhắn mới';

  @override
  String get reconnectingCall => 'Đang kết nối lại...';

  @override
  String get redPacketTransferCannotForward =>
      'Lì xì và chuyển khoản không thể chuyển tiếp';

  @override
  String get showMessageContentInNotification =>
      'Hiển thị nội dung tin nhắn trong thông báo';

  @override
  String get showMessagePreview => 'Hiển thị xem trước tin nhắn';

  @override
  String get typingIndicator => 'Chỉ báo đang nhập';

  @override
  String versionInfo(String version) {
    return 'Phiên bản $version';
  }

  @override
  String get vibration => 'Rung';

  @override
  String get videoCallInProgress => 'Cuộc gọi video';

  @override
  String get voiceCallInProgress => 'Cuộc gọi thoại';

  @override
  String whoCanSeeTitle(String title) {
    return 'Ai có thể xem $title';
  }

  @override
  String get emailAddress => 'Địa chỉ email';

  @override
  String get enterEmailAddress => 'Nhập địa chỉ email';

  @override
  String get emailRecoveryHint => 'Dùng để khôi phục mật khẩu';

  @override
  String get invalidEmailFormat => 'Vui lòng nhập địa chỉ email hợp lệ';

  @override
  String get optional => 'Tùy chọn';

  @override
  String get resetPassword => 'Đặt lại mật khẩu';

  @override
  String get resetPasswordTitle => 'Đặt lại mật khẩu của bạn';

  @override
  String get enterRegisteredEmail => 'Nhập địa chỉ email bạn đã đăng ký';

  @override
  String get sendResetCode => 'Gửi mã đặt lại';

  @override
  String resetCodeSent(String email) {
    return 'Mã đặt lại đã gửi đến $email';
  }

  @override
  String get enterResetCode => 'Nhập mã đặt lại';

  @override
  String get setNewPassword => 'Đặt mật khẩu mới';

  @override
  String get confirmNewPassword => 'Xác nhận mật khẩu mới';

  @override
  String get newPassword => 'Mật khẩu mới';

  @override
  String get passwordResetSuccess =>
      'Mật khẩu đã được đặt lại thành công. Vui lòng đăng nhập bằng mật khẩu mới.';

  @override
  String get resetPasswordFailed => 'Đặt lại mật khẩu thất bại';

  @override
  String get changePassword => 'Đổi mật khẩu';

  @override
  String get currentPassword => 'Mật khẩu hiện tại';

  @override
  String get enterCurrentPassword => 'Nhập mật khẩu hiện tại';

  @override
  String get enterNewPassword => 'Nhập mật khẩu mới';

  @override
  String get passwordChanged =>
      'Mật khẩu đã được thay đổi thành công. Vui lòng đăng nhập bằng mật khẩu mới.';

  @override
  String get changePasswordFailed => 'Đổi mật khẩu thất bại';

  @override
  String get incorrectCurrentPassword => 'Mật khẩu hiện tại không đúng';

  @override
  String get newPasswordMustBeDifferent =>
      'Mật khẩu mới phải khác mật khẩu hiện tại';

  @override
  String get changePasswordInfo =>
      'Sau khi đổi mật khẩu, bạn sẽ bị đăng xuất và cần đăng nhập lại bằng mật khẩu mới.';

  @override
  String get passwordRequirements => 'Yêu cầu mật khẩu:';

  @override
  String get securityNote =>
      'Vì lý do bảo mật, bạn sẽ cần đăng nhập lại trên tất cả thiết bị sau khi đổi mật khẩu.';

  @override
  String get security => 'Bảo mật';

  @override
  String get currentBoundEmail => 'Email hiện đang liên kết';

  @override
  String get newEmailAddress => 'Địa chỉ email mới';

  @override
  String get enterNewEmail => 'Nhập địa chỉ email mới';

  @override
  String get verificationCode => 'Mã xác nhận';

  @override
  String get verificationCodeSent => 'Mã xác nhận đã được gửi';

  @override
  String get codeSentTo => 'Mã xác nhận đã gửi đến';

  @override
  String get didNotReceiveCode => 'Không nhận được mã?';

  @override
  String get emailChangedSuccess => 'Email đã được thay đổi thành công';

  @override
  String get changeEmailFailed => 'Thay đổi email thất bại';

  @override
  String get emailSecurityNote =>
      'Email của bạn được dùng để khôi phục mật khẩu. Hãy giữ an toàn.';

  @override
  String get googleLogin => 'Đăng nhập bằng Google';

  @override
  String get appleLogin => 'Đăng nhập bằng Apple';

  @override
  String get facebookLogin => '使用 Facebook 登录';

  @override
  String get twitterLogin => '使用 Twitter 登录';

  @override
  String get wechatLogin => '使用微信登录';

  @override
  String get wechat => '微信';

  @override
  String get facebook => 'Facebook';

  @override
  String get twitter => 'Twitter';

  @override
  String get wechatNotInstalled => '请先安装微信';

  @override
  String get wechatLoginFailed => '微信登录失败';

  @override
  String get facebookLoginFailed => 'Facebook 登录失败';

  @override
  String get twitterLoginFailed => 'Twitter 登录失败';

  @override
  String get twitterNotConfigured => 'Twitter 登录未配置';

  @override
  String get socialLoginCancelled => 'Đăng nhập đã bị hủy';

  @override
  String get socialLoginFailed => 'Đăng nhập mạng xã hội thất bại';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get languageChanged => 'Ngôn ngữ đã thay đổi';

  @override
  String get biometricLogin => '生物识别登录';

  @override
  String loginWithBiometric(Object type) {
    return '使用$type登录';
  }

  @override
  String get biometricLoginEnabled => '生物识别登录已启用';

  @override
  String get biometricLoginDisabled => '生物识别登录已禁用';

  @override
  String get enableBiometricLogin => '启用生物识别登录';

  @override
  String get disableBiometricLogin => '禁用生物识别登录';

  @override
  String get biometricNotAvailable => '此设备不支持生物识别';

  @override
  String get biometricNotEnrolled => '未录入生物识别数据，请在设备设置中设置';

  @override
  String get biometricAuthFailed => '生物识别验证失败';

  @override
  String get biometricAuthCancelled => '验证已取消';

  @override
  String get biometricLockedOut => '尝试次数过多，请稍后再试';

  @override
  String get useBiometricToLogin => '使用生物识别快速登录';

  @override
  String get authenticateToLogin => '验证身份以登录';

  @override
  String get authenticateToEnable => '验证身份以启用生物识别登录';

  @override
  String get faceId => '面容 ID';

  @override
  String get touchId => '触控 ID';

  @override
  String get fingerprint => '指纹';

  @override
  String get biometric => '生物识别';

  @override
  String get biometricEnabled => '已启用 - 使用生物识别登录';

  @override
  String get biometricDisabled => '已禁用 - 点击启用';

  @override
  String get biometricNeedRelogin => '请退出后重新登录以启用生物识别';

  @override
  String get or => '或';
}
