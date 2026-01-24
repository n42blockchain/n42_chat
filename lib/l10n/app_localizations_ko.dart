// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class SKo extends S {
  SKo([String locale = 'ko']) : super(locale);

  @override
  String get chatModuleInitFailed => '채팅 모듈 초기화 실패';

  @override
  String get checkNetworkRetry => '네트워크 연결을 확인하고 다시 시도해주세요';

  @override
  String get retry => '다시 시도';

  @override
  String get unknownUser => '알 수 없는 사용자';

  @override
  String get walletNotConnected => '지갑이 연결되지 않음';

  @override
  String get cannotGetWalletAddress => '지갑 주소를 가져올 수 없습니다';

  @override
  String paymentRequestMemo(String requestId) {
    return '결제 요청: $requestId';
  }

  @override
  String get callServiceNotInitialized => '통화 서비스가 초기화되지 않았습니다';

  @override
  String get alreadyInCall => '이미 통화 중입니다';

  @override
  String get meetingServiceNotInitialized => '회의 서비스가 초기화되지 않았습니다';

  @override
  String get livekitNotConfigured => 'LiveKit이 구성되지 않았습니다';

  @override
  String get unknownConversation => '알 수 없는 대화';

  @override
  String startCallFailed(String error) {
    return '통화 시작 실패: $error';
  }

  @override
  String answerCallFailed(String error) {
    return '응답 실패: $error';
  }

  @override
  String get connectionFailed => '연결 실패';

  @override
  String get callRejected => '통화 거절됨';

  @override
  String get noAnswer => '응답 없음';

  @override
  String get invalidLoginResponse => '잘못된 로그인 응답';

  @override
  String loginFailed(String error) {
    return '로그인 실패: $error';
  }

  @override
  String get sessionRestoreFailed => '세션 복원 실패';

  @override
  String get additionalVerificationRequired => '추가 인증이 필요합니다';

  @override
  String registrationFailed(String error) {
    return '회원가입 실패: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return '서버에 연결할 수 없습니다: $error';
  }

  @override
  String get wrongUsernamePassword => '아이디 또는 비밀번호가 올바르지 않습니다';

  @override
  String get usernameTaken => '이미 사용 중인 아이디입니다';

  @override
  String get invalidUsernameFormat => '잘못된 아이디 형식입니다';

  @override
  String get rateLimitExceeded => '요청이 너무 많습니다. 잠시 후 다시 시도해주세요';

  @override
  String get loginExpired => '로그인이 만료되었습니다';

  @override
  String joinMeetingFailed(String error) {
    return '회의 참여 실패: $error';
  }

  @override
  String screenShareFailed(String error) {
    return '화면 공유 실패: $error';
  }

  @override
  String get answer => '응답';

  @override
  String get decline => '거절';

  @override
  String get missedCall => '부재중 전화';

  @override
  String get callBack => '다시 전화';

  @override
  String get incomingCall => '수신 전화';

  @override
  String get missedVideoCall => '부재중 영상통화';

  @override
  String get missedVoiceCall => '부재중 음성통화';

  @override
  String get passkeyNotInitialized => '패스키가 초기화되지 않았습니다';

  @override
  String get googleSignInNotConfigured => 'Google 로그인이 구성되지 않았습니다';

  @override
  String get encryptedMessage => '[암호화된 메시지]';

  @override
  String get sticker => '[스티커]';

  @override
  String get groupCreated => '그룹이 생성되었습니다';

  @override
  String get groupNameChanged => '그룹 이름이 변경되었습니다';

  @override
  String get groupAvatarChanged => '그룹 프로필 사진이 변경되었습니다';

  @override
  String get groupAnnouncementChanged => '그룹 공지가 변경되었습니다';

  @override
  String get image => '[이미지]';

  @override
  String get video => '[동영상]';

  @override
  String get voice => '[음성]';

  @override
  String get file => '[파일]';

  @override
  String get location => '[위치]';

  @override
  String get unknownMessage => '[알 수 없는 메시지]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName님이 그룹에 참여했습니다';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName님이 그룹을 나갔습니다';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName님이 초대되었습니다';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName님이 삭제되었습니다';
  }

  @override
  String get avatarDataEmpty => '프로필 사진 데이터가 비어 있습니다';

  @override
  String get avatarTooLarge => '프로필 사진이 너무 큽니다. 최대 10MB';

  @override
  String get uploadAvatarFailed => '프로필 사진 업로드 실패';

  @override
  String get delete => '삭제';

  @override
  String get notLoggedIn => '로그인되지 않음';

  @override
  String roomNotExist(String roomId) {
    return '방을 찾을 수 없습니다: $roomId';
  }

  @override
  String get uploadImageFailed => '이미지 업로드 실패';

  @override
  String get matrixClientNotInitialized => 'Matrix 클라이언트가 초기화되지 않았습니다';

  @override
  String get uploadVoiceFailed => '음성 업로드 실패: MXC URI를 가져올 수 없습니다';

  @override
  String get uploadVideoFailed => '동영상 업로드 실패: MXC URI를 가져올 수 없습니다';

  @override
  String get uploadFileFailed => '파일 업로드 실패: MXC URI를 가져올 수 없습니다';

  @override
  String locationWithCoords(String lat, String lon) {
    return '위치: $lat, $lon';
  }

  @override
  String get myLocation => '내 위치';

  @override
  String get pollEnded => '투표가 종료되었습니다';

  @override
  String get groupChat => '그룹 채팅';

  @override
  String get search => '검색';

  @override
  String get cancel => '취소';

  @override
  String get userCancelled => '사용자가 취소했습니다';

  @override
  String get noData => '데이터 없음';

  @override
  String get noSearchResults => '검색 결과 없음';

  @override
  String get tryDifferentKeyword => '다른 키워드로 시도해보세요';

  @override
  String get loadFailed => '로드 실패';

  @override
  String get checkNetwork => '네트워크 연결을 확인해주세요';

  @override
  String get networkConnectionFailed => '네트워크 연결 실패';

  @override
  String get checkNetworkSettings => '네트워크 설정을 확인해주세요';

  @override
  String get messages => '메시지';

  @override
  String get contacts => '연락처';

  @override
  String get discover => '발견';

  @override
  String get me => '나';

  @override
  String get voiceLoading => '음성 로딩 중, 잠시 후 다시 시도해주세요';

  @override
  String get voiceToTextFailed => '음성을 텍스트로 변환 실패';

  @override
  String get converting => '변환 중...';

  @override
  String get convertToText => '텍스트로 변환';

  @override
  String get convertToTextTitle => '텍스트로 변환';

  @override
  String get selectEmoji => '이모티콘 선택';

  @override
  String get frequentlyUsed => '자주 사용';

  @override
  String get copy => '복사';

  @override
  String get forward => '전달';

  @override
  String get unfavorite => '즐겨찾기 해제';

  @override
  String get favorite => '즐겨찾기';

  @override
  String get resend => '다시 보내기';

  @override
  String get recall => '메시지 취소';

  @override
  String get multiSelect => '다중 선택';

  @override
  String get quote => '인용';

  @override
  String get remind => '멘션';

  @override
  String get searchThis => '검색';

  @override
  String get recallMessageConfirm => '이 메시지를 취소하시겠습니까?';

  @override
  String get youRecalledMessage => '메시지를 취소했습니다';

  @override
  String get otherRecalledMessage => '메시지가 취소되었습니다';

  @override
  String get reEdit => '다시 편집';

  @override
  String get copied => '복사됨';

  @override
  String get sendMessageHint => '메시지 보내기';

  @override
  String get microphonePermissionRequired => '마이크 권한을 허용해주세요';

  @override
  String startRecordingFailed(String error) {
    return '녹음 시작 실패: $error';
  }

  @override
  String get recordingTooShort => '녹음이 너무 짧습니다';

  @override
  String stopRecordingFailed(String error) {
    return '녹음 중지 실패: $error';
  }

  @override
  String get releaseToCancel => '손가락을 떼면 취소';

  @override
  String get releaseToSend => '손가락을 떼면 전송, 위로 스와이프하면 취소';

  @override
  String get holdToTalk => '길게 눌러서 말하기';

  @override
  String get send => '전송';

  @override
  String conversationWithId(String roomId) {
    return '대화: $roomId';
  }

  @override
  String contactWithId(String userId) {
    return '연락처: $userId';
  }

  @override
  String get addFriend => '친구 추가';

  @override
  String get chatServiceNotConnected => '채팅 서비스에 연결되지 않음';

  @override
  String userNotFoundHint(String query) {
    return '사용자 \"$query\"를 찾을 수 없습니다\n\n팁:\n• 전체 사용자 ID를 입력해보세요 (예: @username:server.com)\n• 사용자 이름 철자를 확인해주세요';
  }

  @override
  String createChatFailed(String error) {
    return '채팅 생성 실패: $error';
  }

  @override
  String searchFailed(String error) {
    return '검색 실패: $error';
  }

  @override
  String get enterUserIdOrUsername => '검색할 사용자 ID 또는 이름을 입력하세요';

  @override
  String get searching => '검색 중...';

  @override
  String get searchUserToChat => '채팅할 사용자를 검색하세요';

  @override
  String get matrixIdExample =>
      '전체 Matrix ID를 입력할 수 있습니다\n예: @user:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return '사용자 \"$username\"를 찾을 수 없습니다';
  }

  @override
  String get chat => '채팅';

  @override
  String get settings => '설정';

  @override
  String get editProfile => '프로필 편집';

  @override
  String get login => '로그인';

  @override
  String get createGroup => '그룹 만들기';

  @override
  String developing(String title) {
    return '$title\n(곧 출시 예정)';
  }

  @override
  String get error => '오류';

  @override
  String get pageNotFound => '페이지를 찾을 수 없습니다';

  @override
  String get backToHome => '홈으로 돌아가기';

  @override
  String get allRead => '모두 읽음';

  @override
  String readCount(int count) {
    return '$count명 읽음';
  }

  @override
  String get transfer => '송금';

  @override
  String get pendingReceipt => '대기 중';

  @override
  String get tapToReceive => '탭하여 받기';

  @override
  String get received => '받음';

  @override
  String get paymentReceived => '결제가 완료되었습니다';

  @override
  String get refunded => '환불됨';

  @override
  String get expired => '만료됨';

  @override
  String get redPacketGreeting => '행운을 빕니다';

  @override
  String get n42RedPacket => 'N42 레드패킷';

  @override
  String get goodLuck => '행운을 잡으세요';

  @override
  String get claimed => '수령 완료';

  @override
  String get allClaimed => '모두 수령됨';

  @override
  String get emoji => '이모티콘';

  @override
  String get love => '사랑';

  @override
  String get animals => '동물';

  @override
  String get food => '음식';

  @override
  String get travel => '여행';

  @override
  String get activities => '활동';

  @override
  String get objects => '사물';

  @override
  String get symbols => '기호';

  @override
  String get reply => '답장';

  @override
  String get copiedToClipboard => '클립보드에 복사됨';

  @override
  String get edit => '편집';

  @override
  String get more => '더보기';

  @override
  String get selectForwardTarget => '받는 사람 선택';

  @override
  String sendCount(int count) {
    return '전송 ($count)';
  }

  @override
  String get draft => '[임시 저장] ';

  @override
  String n42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get n42IdTitle => 'N42 ID';

  @override
  String get n42Bean => 'N42 빈';

  @override
  String get friendInfo => '친구 정보';

  @override
  String get friendInfoDesc => '친구의 별명, 전화번호, 태그, 메모, 사진을 추가하고 권한을 설정하세요.';

  @override
  String get moments => '모먼트';

  @override
  String get sendMessage => '메시지';

  @override
  String get audioVideoCall => '음성/영상 통화';

  @override
  String get videoChannel => '영상 채널';

  @override
  String get remark => '별명';

  @override
  String get remarkName => '별명';

  @override
  String get phone => '전화번호';

  @override
  String get tags => '태그';

  @override
  String get notes => '메모';

  @override
  String get photos => '사진';

  @override
  String get permissions => '권한';

  @override
  String get chatMomentsEtc => '채팅, 모먼트, 운동 등';

  @override
  String get moreInfo => '추가 정보';

  @override
  String get commonGroups => '공통 그룹';

  @override
  String get zeroGroups => '0';

  @override
  String get source => '출처';

  @override
  String get notificationSettings => '알림';

  @override
  String get receiveNotifications => '새 메시지 알림 받기';

  @override
  String get showPreview => '메시지 미리보기 표시';

  @override
  String get showContentInNotification => '알림에 메시지 내용 표시';

  @override
  String get notificationSound => '알림 소리';

  @override
  String get playSoundOnMessage => '메시지 수신 시 소리 재생';

  @override
  String get vibrate => '진동';

  @override
  String get vibrateOnMessage => '메시지 수신 시 진동';

  @override
  String get doNotDisturb => '방해 금지';

  @override
  String get dndDescription => '지정된 시간 동안 알림 음소거';

  @override
  String get startTime => '시작 시간';

  @override
  String get endTime => '종료 시간';

  @override
  String get privacy => '개인정보';

  @override
  String get appearance => '외관';

  @override
  String get about => '정보';

  @override
  String get logout => '로그아웃';

  @override
  String get logoutConfirm => '정말 로그아웃하시겠습니까?';

  @override
  String get exit => '로그아웃';

  @override
  String get save => '저장';

  @override
  String get nickname => '닉네임';

  @override
  String get enterNickname => '닉네임 입력';

  @override
  String get signature => '상태 메시지';

  @override
  String get addSignature => '상태 메시지 추가';

  @override
  String get takePhoto => '사진 촬영';

  @override
  String get chooseFromGallery => '갤러리에서 선택';

  @override
  String saveFailed(String error) {
    return '저장 실패: $error';
  }

  @override
  String get secureDecentralizedChat => '안전한 분산형 메시징';

  @override
  String get endToEndEncryption => '종단간 암호화';

  @override
  String get messagesOnlyYouCanSee => '나와 상대방만 볼 수 있는 메시지';

  @override
  String get decentralized => '분산형';

  @override
  String get basedOnMatrix => 'Matrix 오픈 프로토콜 기반';

  @override
  String get walletIntegration => '지갑 연동';

  @override
  String get easyCryptoTransfer => '간편한 암호화폐 송금';

  @override
  String get register => '회원가입';

  @override
  String get agreeTerms => '로그인하면 다음에 동의하는 것으로 간주됩니다';

  @override
  String get termsOfService => '서비스 약관';

  @override
  String get and => '및';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get serverAddress => '서버 주소';

  @override
  String get enterServerAddress => '서버 주소 입력';

  @override
  String get validServerAddress => '올바른 서버 주소를 입력해주세요';

  @override
  String connectedTo(String serverName) {
    return '$serverName에 연결됨';
  }

  @override
  String get username => '아이디';

  @override
  String get enterUsername => '아이디 입력';

  @override
  String get password => '비밀번호';

  @override
  String get enterPassword => '비밀번호 입력';

  @override
  String get registerAccount => '회원가입';

  @override
  String get forgotPassword => '비밀번호 찾기';

  @override
  String get otherLoginMethods => '다른 로그인 방법';

  @override
  String get emailVerification => '이메일 인증 코드';

  @override
  String get enterServerFirst => '먼저 서버 주소를 입력해주세요';

  @override
  String get passkeyNeedsServer => '패스키 로그인은 서버 지원이 필요합니다';

  @override
  String googleLoginSuccess(String email) {
    return 'Google 로그인 성공: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Google 로그인 실패: $error';
  }

  @override
  String get appleLoginSuccess => 'Apple 로그인 성공';

  @override
  String appleLoginFailed(String error) {
    return 'Apple 로그인 실패: $error';
  }

  @override
  String get createAccount => '계정 만들기';

  @override
  String get joinN42Chat => 'N42 Chat에 가입하여 채팅을 시작하세요';

  @override
  String get usernameHint => '3-20자, 영문/숫자/_';

  @override
  String get usernameMinLength => '아이디는 최소 3자 이상이어야 합니다';

  @override
  String get usernameMaxLength => '아이디는 최대 20자까지 가능합니다';

  @override
  String get usernameFormat => '아이디는 영문, 숫자, 밑줄만 사용할 수 있습니다';

  @override
  String get passwordHint => '최소 8자';

  @override
  String get passwordMinLength => '비밀번호는 최소 8자 이상이어야 합니다';

  @override
  String get confirmPassword => '비밀번호 확인';

  @override
  String get reEnterPassword => '비밀번호 재입력';

  @override
  String get passwordsNotMatch => '비밀번호가 일치하지 않습니다';

  @override
  String get inviteCode => '초대 코드 (내장)';

  @override
  String get filled => '입력됨';

  @override
  String get enterInviteCode => '초대 코드 입력';

  @override
  String get inviteCodeHint => '초대 코드는 내장되어 있어 일반적으로 수정할 필요가 없습니다';

  @override
  String get agreeTermsFirst => '먼저 약관과 개인정보 처리방침을 읽고 동의해주세요';

  @override
  String get iAgree => '읽고 동의합니다';

  @override
  String get alreadyHaveAccount => '이미 계정이 있으신가요?';

  @override
  String get loginNow => '지금 로그인';

  @override
  String get whoCanSee => '볼 수 있는 사람';

  @override
  String get avatar => '프로필 사진';

  @override
  String get status => '상태';

  @override
  String get lastSeen => '마지막 접속';

  @override
  String get messageSettings => '메시지';

  @override
  String get allowStrangerMessage => '모르는 사람의 메시지 허용';

  @override
  String get receiveNonContact => '연락처에 없는 사람의 메시지 받기';

  @override
  String get readReceipts => '읽음 확인';

  @override
  String get letOthersKnowRead => '상대방에게 메시지를 읽었다고 알림';

  @override
  String get typingStatus => '입력 중 표시';

  @override
  String get letOthersKnowTyping => '상대방에게 입력 중이라고 알림';

  @override
  String get everyone => '모든 사람';

  @override
  String get contactsOnly => '연락처만';

  @override
  String get nobody => '아무도';

  @override
  String whoCanSeeItem(String title) {
    return '$title을(를) 볼 수 있는 사람';
  }

  @override
  String version(String version) {
    return '버전 $version';
  }

  @override
  String get checkUpdate => '업데이트 확인';

  @override
  String get openSourceLicenses => '오픈소스 라이선스';

  @override
  String get feedback => '피드백';

  @override
  String get builtOnMatrix => 'Matrix 프로토콜 기반';

  @override
  String get loading => '로딩 중...';

  @override
  String get noConversations => '대화 없음';

  @override
  String get tapToChat => '오른쪽 상단을 탭하여 채팅 시작';

  @override
  String get startGroup => '그룹 채팅 시작';

  @override
  String get scan => '스캔';

  @override
  String get payment => '결제';

  @override
  String featureComingSoon(String feature) {
    return '$feature 곧 출시 예정';
  }

  @override
  String get markAsRead => '읽음으로 표시';

  @override
  String get unmute => '알림 켜기';

  @override
  String get mute => '알림 끄기';

  @override
  String get unpin => '고정 해제';

  @override
  String get pin => '고정';

  @override
  String get deleteConversation => '대화 삭제';

  @override
  String deleteConversationConfirm(String name) {
    return '\"$name\"님과의 대화를 삭제하시겠습니까?';
  }

  @override
  String get noContacts => '연락처 없음';

  @override
  String get addFriendsToChat => '친구를 추가하여 채팅을 시작하세요';

  @override
  String get contactNotFound => '연락처를 찾을 수 없습니다';

  @override
  String get tryOtherKeywords => '다른 키워드로 시도하거나 전체 검색을 이용하세요';

  @override
  String get searchResults => '검색 결과';

  @override
  String get newFriends => '새 친구';

  @override
  String get chatOnlyFriends => '채팅 전용 친구';

  @override
  String get officialAccounts => '공식 계정';

  @override
  String get serviceAccounts => '서비스 계정';

  @override
  String get enterpriseContacts => '기업 연락처';

  @override
  String contactsCount(int count) {
    return '연락처 $count명';
  }

  @override
  String get recommendToFriend => '연락처 공유';

  @override
  String get setRemark => '별명 설정';

  @override
  String get addToHome => '홈 화면에 추가';

  @override
  String get sendingCard => '연락처 카드 전송 중...';

  @override
  String get contactCard => '[연락처 카드]';

  @override
  String get fileLabel => '파일';

  @override
  String get locationLabel => '위치';

  @override
  String cardSent(String contact, String friend) {
    return '$contact님의 카드를 $friend님에게 전송했습니다';
  }

  @override
  String recommendFailed(String error) {
    return '추천 실패: $error';
  }

  @override
  String get enterRemark => '별명 입력';

  @override
  String remarkSet(String remark) {
    return '별명이 설정되었습니다: $remark';
  }

  @override
  String get openingChat => '채팅 열는 중...';

  @override
  String openChatFailed(String error) {
    return '채팅 열기 실패: $error';
  }

  @override
  String get addContact => '연락처 추가';

  @override
  String get enterUserId => '사용자 ID 입력';

  @override
  String get noFriendRequests => '친구 요청 없음';

  @override
  String get accept => '수락';

  @override
  String get reject => '거절';

  @override
  String acceptedRequest(String name) {
    return '$name님의 친구 요청을 수락했습니다';
  }

  @override
  String rejectedRequest(String name) {
    return '$name님의 친구 요청을 거절했습니다';
  }

  @override
  String get noGroups => '그룹 없음';

  @override
  String get creatingGroup => '그룹 만들기 곧 출시 예정...';

  @override
  String get selectFriendToRecommend => '추천할 친구 선택';

  @override
  String get searchContacts => '연락처 검색';

  @override
  String get noContactsFound => '연락처를 찾을 수 없습니다';

  @override
  String get yesterday => '어제';

  @override
  String get monday => '월';

  @override
  String get tuesday => '화';

  @override
  String get wednesday => '수';

  @override
  String get thursday => '목';

  @override
  String get friday => '금';

  @override
  String get saturday => '토';

  @override
  String get sunday => '일';

  @override
  String get justNow => '방금';

  @override
  String minutesAgo(int count) {
    return '$count분 전';
  }

  @override
  String hoursAgo(int count) {
    return '$count시간 전';
  }

  @override
  String daysAgo(int count) {
    return '$count일 전';
  }

  @override
  String get online => '온라인';

  @override
  String get offline => '오프라인';

  @override
  String minutesAgoOnline(int count) {
    return '$count분 전 온라인';
  }

  @override
  String hoursAgoOnline(int count) {
    return '$count시간 전 온라인';
  }

  @override
  String daysAgoOnline(int count) {
    return '$count일 전 온라인';
  }

  @override
  String get searchContactsGroupsMessages => '연락처, 그룹, 메시지 검색';

  @override
  String get searchError => '검색 오류';

  @override
  String get searchHint => '연락처, 그룹, 메시지 검색';

  @override
  String get enterKeyword => '키워드를 입력하여 검색';

  @override
  String get searchHistory => '검색 기록';

  @override
  String get clear => '지우기';

  @override
  String noResultsFor(String query) {
    return '\"$query\"에 대한 결과 없음';
  }

  @override
  String get all => '전체';

  @override
  String get groups => '그룹';

  @override
  String get noResults => '결과 없음';

  @override
  String get groupInfo => '그룹 정보';

  @override
  String groupMembers(int count) {
    return '멤버 ($count명)';
  }

  @override
  String get groupMembersTitle => '그룹 멤버';

  @override
  String get viewAll => '모두 보기';

  @override
  String get owner => '소유자';

  @override
  String get admin => '관리자';

  @override
  String get invite => '초대';

  @override
  String get groupAnnouncement => '그룹 공지';

  @override
  String get notSet => '설정되지 않음';

  @override
  String get groupDescription => '그룹 설명';

  @override
  String get publicGroup => '공개 그룹';

  @override
  String get allowSearchJoin => '다른 사람이 검색하고 참여할 수 있도록 허용';

  @override
  String get clearChatHistory => '채팅 기록 지우기';

  @override
  String get dissolveGroup => '그룹 해체';

  @override
  String get leaveGroup => '그룹 나가기';

  @override
  String get changeGroupName => '그룹 이름 변경';

  @override
  String get enterGroupName => '그룹 이름 입력';

  @override
  String get confirm => '확인';

  @override
  String get changeGroupDescription => '그룹 설명 변경';

  @override
  String get enterGroupDescription => '그룹 설명 입력';

  @override
  String get editAnnouncement => '공지 편집';

  @override
  String get enterAnnouncement => '공지 입력';

  @override
  String get publish => '게시';

  @override
  String get clearHistoryConfirm => '모든 채팅 기록을 지우시겠습니까? 이 작업은 취소할 수 없습니다.';

  @override
  String get clearAction => '지우기';

  @override
  String get chatHistoryCleared => '채팅 기록이 삭제되었습니다';

  @override
  String leaveGroupConfirm(String name) {
    return '\"$name\"을(를) 나가시겠습니까?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return '\"$name\"을(를) 해체하시겠습니까? 이 작업은 취소할 수 없습니다.';
  }

  @override
  String get dissolve => '해체';

  @override
  String get groupQrCode => '그룹 QR 코드';

  @override
  String get searchChatHistory => '채팅 기록 검색';

  @override
  String get groupIdCopied => '그룹 ID 복사됨';

  @override
  String tapCopyGroupId(int count) {
    return '멤버 $count명 · 탭하여 그룹 ID 복사';
  }

  @override
  String get receiverAddress => '받는 주소';

  @override
  String get enterOrPasteAddress => '지갑 주소 입력 또는 붙여넣기';

  @override
  String get selectToken => '토큰 선택';

  @override
  String get transferAmount => '송금 금액';

  @override
  String get available => '사용 가능';

  @override
  String get allAmount => '전액';

  @override
  String get memoOptional => '메모 (선택)';

  @override
  String get addMemo => '메모 추가';

  @override
  String get confirmTransfer => '송금 확인';

  @override
  String get invalidAddress => '올바른 받는 주소를 입력해주세요';

  @override
  String get invalidAmount => '올바른 금액을 입력해주세요';

  @override
  String get selectTokenPlease => '토큰을 선택해주세요';

  @override
  String get addressVerified => '주소 확인됨';

  @override
  String availableBalance(String balance, String symbol) {
    return '사용 가능: $balance $symbol';
  }

  @override
  String get scanningInDevelopment => '스캔 기능 개발 중...';

  @override
  String get enterAmount => '금액 입력';

  @override
  String get redPacketCountMin => '최소 1개의 레드패킷이 필요합니다';

  @override
  String get viewRedPacketDetails => '레드패킷 상세 보기';

  @override
  String get enterTransferAmount => '송금 금액 입력';

  @override
  String get transferTo => '받는 사람';

  @override
  String get selectCurrency => '통화 선택';

  @override
  String get receiveTransfer => '송금 받음';

  @override
  String fromSender(String name, Object senderName) {
    return '$senderName님으로부터';
  }

  @override
  String get confirmReceive => '수령 확인';

  @override
  String get groupProfile => '그룹 정보';

  @override
  String get viewProfile => '프로필 보기';

  @override
  String get removeMember => '그룹에서 삭제';

  @override
  String removeMemberConfirm(String name) {
    return '그룹에서 \"$name\"님을 삭제하시겠습니까?';
  }

  @override
  String get remove => '삭제';

  @override
  String get clearStatus => '상태 지우기';

  @override
  String get clearStatusConfirm => '현재 상태를 지우시겠습니까?';

  @override
  String get statusCleared => '상태가 지워졌습니다';

  @override
  String statusSet(String result) {
    return '상태 설정됨: $result';
  }

  @override
  String get userNotExist => '사용자가 존재하지 않습니다';

  @override
  String get userIdCopied => '사용자 ID 복사됨';

  @override
  String get voiceCallInDevelopment => '음성 통화 개발 중...';

  @override
  String get report => '신고';

  @override
  String get reportInDevelopment => '신고 기능 개발 중...';

  @override
  String get shareCard => '카드 공유';

  @override
  String get shareInDevelopment => '공유 기능 개발 중...';

  @override
  String get qrCode => 'QR 코드';

  @override
  String get qrCodeInDevelopment => 'QR 코드 기능 개발 중...';

  @override
  String get avatarUpdated => '프로필 사진이 업데이트되었습니다';

  @override
  String selectImageFailed(String error) {
    return '이미지 선택 실패: $error';
  }

  @override
  String get changeName => '이름 변경';

  @override
  String get male => '남성';

  @override
  String get female => '여성';

  @override
  String genderSet(String gender) {
    return '성별이 설정되었습니다: $gender';
  }

  @override
  String regionSet(String region) {
    return '지역이 설정되었습니다: $region';
  }

  @override
  String get setPatText => '찌르기 텍스트 설정';

  @override
  String get changeSignature => '상태 메시지 변경';

  @override
  String ringtoneSet(String result) {
    return '벨소리가 설정되었습니다: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature 개발 중...';
  }

  @override
  String saveAddressFailed(String error) {
    return '주소 저장 실패: $error';
  }

  @override
  String get myAddress => '내 주소';

  @override
  String get addNew => '추가';

  @override
  String get addAddress => '주소 추가';

  @override
  String get addressAdded => '주소가 추가되었습니다';

  @override
  String get addressUpdated => '주소가 업데이트되었습니다';

  @override
  String get deleteAddress => '주소 삭제';

  @override
  String get deleteAddressConfirm => '이 주소를 삭제하시겠습니까?';

  @override
  String get addressDeleted => '주소가 삭제되었습니다';

  @override
  String get setDefaultAddress => '기본 주소로 설정';

  @override
  String get fillCompleteInfo => '모든 항목을 입력해주세요';

  @override
  String saveInvoiceFailed(String error) {
    return '청구서 저장 실패: $error';
  }

  @override
  String get myInvoices => '내 청구서';

  @override
  String get addInvoice => '청구서 추가';

  @override
  String get invoiceAdded => '청구서가 추가되었습니다';

  @override
  String get invoiceUpdated => '청구서가 업데이트되었습니다';

  @override
  String get deleteInvoice => '청구서 삭제';

  @override
  String get deleteInvoiceConfirm => '이 청구서를 삭제하시겠습니까?';

  @override
  String get invoiceDeleted => '청구서가 삭제되었습니다';

  @override
  String get invoiceType => '청구서 유형: ';

  @override
  String get personal => '개인';

  @override
  String get enterprise => '기업';

  @override
  String get setDefaultInvoice => '기본 청구서로 설정';

  @override
  String get enterTaxId => '사업자 등록번호 입력';

  @override
  String get vibrateMode => '진동 모드';

  @override
  String get silentMode => '무음 모드';

  @override
  String playing(String ringtoneName) {
    return '재생 중: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return '재생 실패: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => '그룹 이름을 입력해주세요';

  @override
  String get selectAtLeastOne => '최소 한 명의 멤버를 선택해주세요';

  @override
  String get fillStatus => '상태 작성';

  @override
  String get fileNotExist => '파일이 존재하지 않습니다';

  @override
  String sendFailed(String error) {
    return '전송 실패: $error';
  }

  @override
  String get cannotOpenBrowser => '브라우저를 열 수 없습니다';

  @override
  String selectFileFailed(String error) {
    return '파일 선택 실패: $error';
  }

  @override
  String get enterMusicLink => '음악 링크 입력';

  @override
  String get enterValidLink => '올바른 링크를 입력해주세요';

  @override
  String get enterPollQuestion => '투표 질문 입력';

  @override
  String get minTwoOptions => '최소 2개의 옵션이 필요합니다';

  @override
  String get crossDeviceEnabled => '교차 기기 서명이 활성화되었습니다';

  @override
  String get crossDeviceSet => '교차 기기 서명이 성공적으로 설정되었습니다';

  @override
  String setupFailed(String error) {
    return '설정 실패: $error';
  }

  @override
  String get receiveAmount => '받을 금액';

  @override
  String get enterValidAmount => '올바른 금액을 입력해주세요';

  @override
  String get addressCopied => '주소 복사됨';

  @override
  String openItem(String content) {
    return '열기: $content';
  }

  @override
  String get newNoteComingSoon => '새 노트 기능 곧 출시 예정';

  @override
  String get addLinkComingSoon => '링크 추가 기능 곧 출시 예정';

  @override
  String get deleted => '삭제됨';

  @override
  String get shareComingSoon => '공유 기능 곧 출시 예정';

  @override
  String get saveComingSoon => '저장 기능 곧 출시 예정';

  @override
  String get moreStylesComingSoon => '더 많은 스타일 곧 출시 예정';

  @override
  String get wallet => '지갑';

  @override
  String get walletArea => '지갑 영역';

  @override
  String get recording => '녹음 중';

  @override
  String get invalidVideoUrl => '잘못된 동영상 URL';

  @override
  String get downloadFile => '파일 다운로드';

  @override
  String get clearChatHistoryTitle => '채팅 기록 지우기';

  @override
  String get cannotUndo => '이 작업은 취소할 수 없습니다';

  @override
  String get videoCall => '영상 통화';

  @override
  String get voiceCall => '음성 통화';

  @override
  String get leaveMeeting => '회의 나가기';

  @override
  String get chatDetails => '채팅 상세';

  @override
  String get viewAllGroupMembers => '모든 멤버 보기';

  @override
  String get groupName => '그룹 이름';

  @override
  String get groupNameUpdated => '그룹 이름이 업데이트되었습니다';

  @override
  String get updateFailed => '업데이트 실패';

  @override
  String get noPermissionToModify => '수정 권한이 없습니다';

  @override
  String get groupManagement => '그룹 관리';

  @override
  String get myNicknameInGroup => '그룹 내 내 별명';

  @override
  String get pinChat => '채팅 고정';

  @override
  String get strongReminder => '강력 알림';

  @override
  String get setChatBackground => '채팅 배경 설정';

  @override
  String get unknownFile => '알 수 없는 파일';

  @override
  String get download => '다운로드';

  @override
  String get invalidLocation => '잘못된 위치';

  @override
  String get address => '주소';

  @override
  String get latitude => '위도';

  @override
  String get longitude => '경도';

  @override
  String get close => '닫기';

  @override
  String get tapToCancel => '탭하여 취소';

  @override
  String captureFailed(Object error) {
    return '캡처 실패: $error';
  }

  @override
  String get processingVideo => '동영상 처리 중...';

  @override
  String get videoFileNotExist => '동영상 파일이 존재하지 않습니다';

  @override
  String get videoDataEmpty => '동영상 데이터가 비어 있습니다';

  @override
  String get videoTooLarge => '동영상 크기는 100MB를 초과할 수 없습니다';

  @override
  String get sendingVideo => '동영상 전송 중...';

  @override
  String sendVideoFailed(Object error) {
    return '동영상 전송 실패: $error';
  }

  @override
  String get imageFileNotExist => '이미지 파일이 존재하지 않습니다';

  @override
  String get imageDataEmpty => '이미지 데이터가 비어 있습니다';

  @override
  String get sendingImage => '이미지 전송 중...';

  @override
  String sendImageFailed(Object error) {
    return '이미지 전송 실패: $error';
  }

  @override
  String get sendLocation => '위치 보내기';

  @override
  String get selectLocationAndSend => '위치를 선택하고 보내기';

  @override
  String get shareRealTimeLocation => '실시간 위치 공유';

  @override
  String get shareLocationForOneHour => '친구와 1시간 동안 실시간 위치 공유';

  @override
  String get locationSent => '위치가 전송되었습니다';

  @override
  String get selectMessages => '메시지 선택';

  @override
  String selectedCount(int count) {
    return '$count개 선택됨';
  }

  @override
  String get selectAll => '전체 선택';

  @override
  String groupChatCount(int count) {
    return '그룹 채팅 ($count)';
  }

  @override
  String get privateChat => '개인 채팅';

  @override
  String get noMessages => '메시지 없음';

  @override
  String get sendFirstMessage => '첫 메시지를 보내 채팅을 시작하세요';

  @override
  String get encryptionNotice =>
      '이 채팅은 종단간 암호화되어 있습니다. 나와 상대방만 메시지를 읽을 수 있습니다.';

  @override
  String replyTo(String name) {
    return '$name님에게 답장';
  }

  @override
  String get multiForward => '전달';

  @override
  String get collect => '수집';

  @override
  String get noMembers => '멤버 없음';

  @override
  String get memberNotFound => '멤버를 찾을 수 없습니다';

  @override
  String get voiceFileNotExist => '음성 파일이 존재하지 않습니다';

  @override
  String get voiceFileEmpty => '음성 파일이 비어 있습니다';

  @override
  String get sendingVoice => '음성 전송 중...';

  @override
  String sendVoiceFailed(Object error) {
    return '음성 전송 실패: $error';
  }

  @override
  String get messageCopied => '메시지 복사됨';

  @override
  String get messageForwarded => '메시지 전달됨';

  @override
  String forwardFailed(Object error) {
    return '전달 실패: $error';
  }

  @override
  String get unfavorited => '즐겨찾기 해제됨';

  @override
  String get favorited => '즐겨찾기 추가됨';

  @override
  String get reactionAdded => '반응 추가됨';

  @override
  String get failedMessageDeleted => '실패한 메시지 삭제됨';

  @override
  String get deleteMessages => '메시지 삭제';

  @override
  String deleteMessagesConfirm(Object count) {
    return '정말 $count개의 메시지를 삭제하시겠습니까?';
  }

  @override
  String noteOtherMessages(Object count) {
    return '참고: $count개의 메시지는 다른 사람의 것으로, 로컬에서만 삭제됩니다.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '내 $count개의 메시지가 취소됩니다.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return '$count개 취소됨, $localCount개 로컬 삭제됨';
  }

  @override
  String recalledMessages(Object count) {
    return '$count개 메시지 취소됨';
  }

  @override
  String deletedLocally(Object count) {
    return '$count개 메시지 삭제됨 (로컬)';
  }

  @override
  String forwardedCount(Object count) {
    return '$count개 메시지 전달됨';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return '전달 완료: $success개 성공, $failed개 실패';
  }

  @override
  String get remindOnlyInGroup => '멘션 기능은 그룹 채팅에서만 사용할 수 있습니다';

  @override
  String get onlyTextSearchable => '텍스트 메시지만 검색할 수 있습니다';

  @override
  String searchFor(Object text) {
    return '\"$text\" 검색';
  }

  @override
  String get baiduSearch => '바이두 검색';

  @override
  String get googleSearch => 'Google 검색';

  @override
  String get bingSearch => 'Bing 검색';

  @override
  String get calling => '전화 중...';

  @override
  String get connecting => '연결 중...';

  @override
  String get ringing => '벨소리 울리는 중...';

  @override
  String get inCall => '통화 중';

  @override
  String featureInDevelopment(String feature) {
    return '기능 개발 중...';
  }

  @override
  String collectMessages(Object count) {
    return '$count개 메시지 수집됨';
  }

  @override
  String get voted => '투표함';

  @override
  String get voteChanged => '투표 변경됨';

  @override
  String get voteRemoved => '투표 취소됨';

  @override
  String get endPoll => '투표 종료';

  @override
  String get endPollConfirm => '정말 이 투표를 종료하시겠습니까? 종료 후에는 더 이상 투표할 수 없습니다.';

  @override
  String memberCount(int count) {
    return '멤버 $count명';
  }

  @override
  String get videoChannels => '채널';

  @override
  String get live => '라이브';

  @override
  String get listen => '듣기';

  @override
  String get watch => '보기';

  @override
  String get searchDiscover => '검색';

  @override
  String get nearbyPeople => '주변';

  @override
  String get games => '게임';

  @override
  String get miniPrograms => '미니 프로그램';

  @override
  String done(int count) {
    return '완료($count)';
  }

  @override
  String get services => '서비스';

  @override
  String get favorites => '즐겨찾기';

  @override
  String get ordersAndCards => '주문 및 카드';

  @override
  String get stickers => '스티커';

  @override
  String statusSetTo(String status) {
    return '상태 설정됨: $status';
  }

  @override
  String get avatarUploadFailed => '프로필 사진 업로드 실패';

  @override
  String get personalProfile => '개인 프로필';

  @override
  String get name => '이름';

  @override
  String get gender => '성별';

  @override
  String get region => '지역';

  @override
  String get myQrCode => '내 QR 코드';

  @override
  String get poke => '찌르기';

  @override
  String get ringtone => '벨소리';

  @override
  String get defaultRingtone => '기본 벨소리';

  @override
  String get myAddresses => '내 주소';

  @override
  String genderSetTo(String gender) {
    return '성별 설정됨: $gender';
  }

  @override
  String get selectRegion => '지역 선택';

  @override
  String get selectCity => '도시 선택';

  @override
  String regionSetTo(String region) {
    return '지역 설정됨: $region';
  }

  @override
  String get setPoke => '찌르기 설정';

  @override
  String get friendPokedMe => '친구가 나를 찔렀어요';

  @override
  String get enterPokeSuffix => '찌르기 접미사 입력, 예: 어깨를';

  @override
  String get example => '예시';

  @override
  String get onTheShoulder => ' 어깨를';

  @override
  String get pokeCleared => '찌르기가 지워졌습니다';

  @override
  String pokeSetTo(String suffix) {
    return '찌르기 설정됨: 나를 찔렀어요$suffix';
  }

  @override
  String get editSignature => '상태 메시지 편집';

  @override
  String get introduceYourself => '자신을 소개하는 한 마디';

  @override
  String get signatureCleared => '상태 메시지가 지워졌습니다';

  @override
  String get signatureUpdated => '상태 메시지가 업데이트되었습니다';

  @override
  String get scanToAddFriend => '위의 QR 코드를 스캔하여 친구로 추가하세요';

  @override
  String ringtoneSetTo(String ringtone) {
    return '벨소리 설정됨: $ringtone';
  }

  @override
  String confirmDissolveGroup(String name) {
    return '\"$name\"을(를) 해산하시겠습니까? 이 작업은 취소할 수 없습니다.';
  }

  @override
  String get enterValidServerAddress => '올바른 서버 주소를 입력해주세요';

  @override
  String get emailOtp => '이메일 OTP';

  @override
  String get enterServerAddressFirst => '먼저 서버 주소를 입력해주세요';

  @override
  String get passkeyRequiresServer => '패스키 로그인은 서버 지원이 필요합니다';

  @override
  String get loginAgreement => '로그인하면 다음에 동의하는 것으로 간주됩니다 ';

  @override
  String get pleaseAgreeToTerms => '서비스 약관과 개인정보 처리방침을 읽고 동의해주세요';

  @override
  String get registerFailed => '회원가입 실패';

  @override
  String get reenterPassword => '비밀번호 재입력';

  @override
  String get passwordsDoNotMatch => '비밀번호가 일치하지 않습니다';

  @override
  String get inviteCodeBuiltIn => '초대 코드 (내장)';

  @override
  String get inviteCodeBuiltInNote => '초대 코드는 내장되어 있어 일반적으로 수정할 필요가 없습니다';

  @override
  String get iHaveReadAndAgree => '읽고 동의합니다 ';

  @override
  String get startGroupChat => '그룹 채팅 시작';

  @override
  String get addFriends => '친구 추가';

  @override
  String get paymentAndCollection => '결제';

  @override
  String messagesWithCount(int count) {
    return '메시지($count)';
  }

  @override
  String contactCount(int count) {
    return '연락처 $count명';
  }

  @override
  String get addToHomeScreen => '홈 화면에 추가';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return '$contact님의 카드를 $recipient님에게 추천했습니다';
  }

  @override
  String get enterRemarkName => '별명 입력';

  @override
  String remarkSetTo(String remark) {
    return '별명 설정됨: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return '$name님의 친구 요청을 수락했습니다';
  }

  @override
  String rejectedFriendRequest(String name) {
    return '$name님의 친구 요청을 거절했습니다';
  }

  @override
  String get groupInvites => '그룹 초대';

  @override
  String myGroups(int count) {
    return '내 그룹 ($count)';
  }

  @override
  String get invitedToJoinGroup => '그룹 참여 초대됨';

  @override
  String confirmLeaveGroup(String name) {
    return '\"$name\"에서 나가시겠습니까?';
  }

  @override
  String get leave => '나가기';

  @override
  String get saveMedia => '저장';

  @override
  String get recallThisMessage => '이 메시지를 취소하시겠습니까?';

  @override
  String get messageRecalled => '메시지가 취소되었습니다';

  @override
  String get savedToGallery => '갤러리에 저장됨';

  @override
  String get failedToSave => '저장 실패';

  @override
  String get saving => '저장 중...';

  @override
  String get share => '공유';

  @override
  String get saveToGallery => '갤러리에 저장';

  @override
  String downloadFailed(String code) {
    return '다운로드 실패: $code';
  }

  @override
  String get noMediaUrl => '사용 가능한 미디어 URL이 없습니다';

  @override
  String shareFailed(String error) {
    return '공유 실패: $error';
  }

  @override
  String get failedToLoadImage => '이미지 로드 실패';

  @override
  String get failedToLoadMoreMessages => '더 많은 메시지 로드 실패';

  @override
  String get failedToSend => '전송 실패';

  @override
  String get failedToSendImage => '이미지 전송 실패';

  @override
  String get failedToSendVoice => '음성 전송 실패';

  @override
  String get failedToSendFile => '파일 전송 실패';

  @override
  String get failedToSendVideo => '동영상 전송 실패';

  @override
  String get failedToSendLocation => '위치 전송 실패';

  @override
  String get failedToResend => '재전송 실패';

  @override
  String get failedToRecall => '취소 실패';

  @override
  String get failedToReply => '답장 실패';

  @override
  String get failedToAddReaction => '반응 추가 실패';

  @override
  String get failedToSendPoll => '투표 전송 실패';

  @override
  String get failedToVote => '투표 실패';

  @override
  String get failedToLoadMessages => '메시지 로드 실패';

  @override
  String get callFeatureComingSoon => '음성 및 영상 통화 기능 곧 출시 예정';

  @override
  String get cannotForwardRedPacketOrTransfer => '레드패킷과 송금은 전달할 수 없습니다';

  @override
  String get videoRecordingFailed => '동영상 녹화 실패. 다시 시도해주세요.';

  @override
  String get redPacket => '레드패킷';

  @override
  String get music => '음악';

  @override
  String get coupon => '쿠폰';

  @override
  String get gift => '선물';

  @override
  String get poll => '투표';

  @override
  String get text => '텍스트';

  @override
  String get link => '링크';

  @override
  String get note => '노트';

  @override
  String get myNotes => '내 노트';

  @override
  String get today => '오늘';

  @override
  String daysAgoText(int count) {
    return '$count일 전';
  }

  @override
  String dateFormat(int month, int day) {
    return '$month/$day';
  }

  @override
  String get noFavorites => '즐겨찾기 없음';

  @override
  String get longPressToFavorite => '메시지를 길게 눌러 즐겨찾기에 추가';

  @override
  String get newNote => '새 노트';

  @override
  String get favoriteLink => '즐겨찾기 링크';

  @override
  String get editTags => '태그 편집';

  @override
  String get deleteFavorite => '즐겨찾기 삭제';

  @override
  String get deleteFavoriteConfirm => '정말 이 즐겨찾기를 삭제하시겠습니까?';

  @override
  String get noSearchResultsFound => '결과를 찾을 수 없습니다';

  @override
  String get sendRedPacket => '레드패킷 보내기';

  @override
  String get amount => '금액';

  @override
  String get redPacketCover => '레드패킷 커버';

  @override
  String get redPacketType => '레드패킷 유형';

  @override
  String get normalRedPacket => '일반';

  @override
  String get luckyRedPacket => '행운';

  @override
  String get redPacketCount => '레드패킷 개수';

  @override
  String get pieces => '개';

  @override
  String get putMoneyInRedPacket => '레드패킷에 돈 넣기';

  @override
  String get redPacketRefundNotice => '24시간 후 수령하지 않은 레드패킷은 환불됩니다';

  @override
  String get openRedPacket => '열기';

  @override
  String get redPacketAllClaimed => '레드패킷 모두 수령됨';

  @override
  String get redPacketExpired => '레드패킷 만료됨';

  @override
  String get addTransferNote => '송금 메모 추가';

  @override
  String get yuan => '원';

  @override
  String get savedToChangeCanTransfer => '잔액에 저장됨, 바로 송금 가능';

  @override
  String get replyWithEmoji => '이 이모티콘으로 답장';

  @override
  String get claimedYourRedPacket => '님이 당신의';

  @override
  String get claimedRedPacket => '님이 수령함';

  @override
  String get otherTyping => '입력 중...';

  @override
  String get processing => '처리 중...';

  @override
  String get transferCancelled => '송금 취소됨';

  @override
  String get transferFailed => '송금 실패';

  @override
  String get creatingPaymentRequest => '결제 요청 생성 중...';

  @override
  String get processingPayment => '결제 처리 중...';

  @override
  String get paymentFailed => '결제 실패';

  @override
  String get clickRetry => '탭하여 다시 시도';

  @override
  String get settingsTitle => '설정';

  @override
  String get editRemark => '별명 편집';

  @override
  String get setPermissions => '권한 설정';

  @override
  String get recommendToFriends => '친구에게 추천';

  @override
  String get setStarFriend => '즐겨찾는 친구로 설정';

  @override
  String get addToBlacklist => '차단 목록에 추가';

  @override
  String get complain => '신고';

  @override
  String get deleteContact => '연락처 삭제';

  @override
  String deleteContactConfirm(String name) {
    return '정말 $name님을 삭제하시겠습니까?';
  }

  @override
  String get transferTitle => '송금';

  @override
  String get receiverAddressLabel => '받는 주소';

  @override
  String get selectTokenLabel => '토큰 선택';

  @override
  String get transferAmountLabel => '송금 금액';

  @override
  String get memoLabel => '메모 (선택)';

  @override
  String get enterOrPasteAddressHint => '지갑 주소 입력 또는 붙여넣기';

  @override
  String get scanInDevelopment => '스캔 기능 개발 중...';

  @override
  String get availableLabel => '사용 가능';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return '사용 가능: $balance $symbol';
  }

  @override
  String get addMemoHint => '메모 추가';

  @override
  String get receiveTitle => '받기';

  @override
  String get walletNotConnectedTitle => '지갑이 연결되지 않음';

  @override
  String get connectWalletFirst => '먼저 지갑을 연결해주세요';

  @override
  String get sendPaymentRequest => '결제 요청 보내기';

  @override
  String get qrCodeGenerateFailed => 'QR 코드 생성 실패';

  @override
  String get scanQrToPayMe => 'QR 코드를 스캔하여 결제하세요';

  @override
  String get myWalletAddress => '내 지갑 주소';

  @override
  String get createPaymentRequest => '결제 요청 생성';

  @override
  String get selectTokenHint => '토큰 선택';

  @override
  String get amountLabel => '금액';

  @override
  String get cancelButton => '취소';

  @override
  String get sendRequestButton => '요청 보내기';

  @override
  String get allReadReceipt => '모두 읽음';

  @override
  String readCountReceipt(int count) {
    return '$count명 읽음';
  }

  @override
  String n42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get redPacketDefaultGreeting => '행운을 빕니다';

  @override
  String senderRedPacket(String name) {
    return '$name님의 레드패킷';
  }

  @override
  String get allButton => '전체';

  @override
  String get enterValidAddress => '올바른 주소를 입력해주세요';

  @override
  String get pleaseSelectToken => '토큰을 선택해주세요';

  @override
  String get receivedTransfer => '송금 받음';

  @override
  String get selectForwardRecipient => '전달할 사람 선택';

  @override
  String get emojiFaces => '얼굴';

  @override
  String get emojiHearts => '하트';

  @override
  String get emojiAnimals => '동물';

  @override
  String get emojiFood => '음식';

  @override
  String get emojiTransport => '교통';

  @override
  String get emojiActivities => '활동';

  @override
  String get emojiObjects => '사물';

  @override
  String get emojiSymbols => '기호';

  @override
  String get transferProcessing => '송금 처리 중...';

  @override
  String senderSentRedPacket(String name) {
    return '$name님이 레드패킷을 보냈습니다';
  }

  @override
  String get savedToBalance => '잔액에 저장됨, 바로 송금 가능';

  @override
  String get redPacketExpiredOrEmpty => '레드패킷 만료됨/모두 수령됨';

  @override
  String get scanFeatureComingSoon => '스캔 기능 곧 출시 예정...';

  @override
  String get setAsStarred => '즐겨찾기로 설정';

  @override
  String get addToBlocklist => '차단 목록에 추가';

  @override
  String get claimedYour => ' 님이 당신의 ';

  @override
  String get claimedText => ' 님이 수령함 ';

  @override
  String userTyping(String name) {
    return '$name님이 입력 중...';
  }

  @override
  String get typing => '입력 중...';

  @override
  String get waitingToReceive => '받기 대기 중';

  @override
  String get tapToClaim => '탭하여 수령';

  @override
  String get hasBeenReceived => '수령됨';

  @override
  String get getLucky => '행운을 잡으세요';

  @override
  String get cameraStartFailed => '카메라 시작 실패';

  @override
  String get unknownError => '알 수 없는 오류';

  @override
  String get placeQrCodeInFrame => '프레임 안에 QR 코드를 배치하세요';

  @override
  String get closeManualInput => '수동 입력 닫기';

  @override
  String get manualInputUserId => '사용자 ID 수동 입력';

  @override
  String get add => '추가';

  @override
  String get ringtoneClear => '지우기';

  @override
  String get ringtonePhone => '전화';

  @override
  String get ringtoneClassic => '클래식';

  @override
  String get ringtoneSoft => '부드러운';

  @override
  String get ringtoneVibrate => '진동';

  @override
  String get ringtoneSilent => '무음';

  @override
  String get stop => '중지';

  @override
  String get selectRingtone => '벨소리 선택';

  @override
  String get loadingRingtones => '벨소리 로딩 중...';

  @override
  String get noRingtonesFound => '벨소리를 찾을 수 없습니다';

  @override
  String get moodAndThoughts => '기분 및 생각';

  @override
  String get statusHappy => '행복해요';

  @override
  String get statusCracked => '무너졌어요';

  @override
  String get statusLucky => '운이 좋아요';

  @override
  String get statusSunny => '화창해요';

  @override
  String get statusTired => '피곤해요';

  @override
  String get statusDaydream => '몽상 중';

  @override
  String get statusRushing => '바쁜 중';

  @override
  String get statusOverthinking => '생각이 많아요';

  @override
  String get statusEnergized => '활력 넘쳐요';

  @override
  String get workAndStudy => '일 및 공부';

  @override
  String get statusWorking => '일하는 중';

  @override
  String get statusStudying => '공부하는 중';

  @override
  String get statusBusy => '바쁨';

  @override
  String get statusSlacking => '쉬는 중';

  @override
  String get statusTraveling => '여행 중';

  @override
  String get statusGoingHome => '집에 가는 중';

  @override
  String get statusDnd => '방해 금지';

  @override
  String get statusHanging => '놀고 있어요';

  @override
  String get statusCheckIn => '체크인';

  @override
  String get statusExercising => '운동 중';

  @override
  String get statusCoffee => '커피';

  @override
  String get statusBubbleTea => '버블티';

  @override
  String get statusEating => '식사 중';

  @override
  String get statusParenting => '육아 중';

  @override
  String get statusSavingWorld => '세상 구하는 중';

  @override
  String get statusSelfie => '셀카';

  @override
  String get rest => '휴식';

  @override
  String get statusRetreat => '피정 중';

  @override
  String get statusHome => '집';

  @override
  String get statusSleeping => '자는 중';

  @override
  String get statusCatLover => '고양이 좋아요';

  @override
  String get statusDogWalking => '산책 중';

  @override
  String get statusGaming => '게임 중';

  @override
  String get statusListening => '듣는 중';

  @override
  String get setStatus => '상태 설정';

  @override
  String get visibleToFriends24h => '친구에게 24시간 동안 표시됨';

  @override
  String get writeStatus => '상태 작성';

  @override
  String get enterYourStatus => '상태를 입력하세요...';

  @override
  String get ok => '확인';

  @override
  String get cameraPermissionRequired => 'QR 코드 스캔을 위해 카메라 권한이 필요합니다';

  @override
  String get cameraPermissionDenied =>
      '카메라 권한이 영구적으로 거부되었습니다. 시스템 설정에서 활성화해주세요.';

  @override
  String get cannotGetCameraPermission => '카메라 권한을 얻을 수 없습니다';

  @override
  String permissionCheckError(String error) {
    return '권한 확인 오류: $error';
  }

  @override
  String get invalidQrCode => '잘못된 QR 코드';

  @override
  String qrCodeProcessFailed(String error) {
    return 'QR 코드 처리 실패: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return '친구 추가 불가: $error';
  }

  @override
  String get scanQrCode => 'QR 코드 스캔';

  @override
  String get checkingCameraPermission => '카메라 권한 확인 중...';

  @override
  String get needCameraPermission => '카메라 권한 필요';

  @override
  String get retryPermission => '다시 시도';

  @override
  String get openSettings => '설정 열기';

  @override
  String get inviteMembers => '멤버 초대';

  @override
  String inviteCount(int count) {
    return '초대($count)';
  }

  @override
  String get noShippingAddress => '배송 주소 없음';

  @override
  String get defaultLabel => '기본';

  @override
  String get editAddress => '주소 편집';

  @override
  String get recipient => '수령인';

  @override
  String get enterRecipientName => '수령인 이름 입력';

  @override
  String get phoneNumber => '전화번호';

  @override
  String get enterPhoneNumber => '전화번호 입력';

  @override
  String get regionHint => '시/도/구';

  @override
  String get detailedAddress => '상세 주소';

  @override
  String get detailedAddressHint => '도로명, 건물 번호 등';

  @override
  String get setAsDefaultAddress => '기본 주소로 설정';

  @override
  String get pleaseCompleteInfo => '모든 항목을 입력해주세요';

  @override
  String get noInvoice => '청구서 없음';

  @override
  String get company => '회사';

  @override
  String get taxNumber => '사업자 등록번호';

  @override
  String get editInvoice => '청구서 편집';

  @override
  String get companyName => '회사명';

  @override
  String get enterCompanyName => '회사명 입력';

  @override
  String get personalName => '개인 이름';

  @override
  String get enterName => '이름 입력';

  @override
  String get taxIdNumber => '사업자 등록번호';

  @override
  String get enterTaxIdNumber => '사업자 등록번호 입력';

  @override
  String get bankNameOptional => '은행명 (선택)';

  @override
  String get enterBankName => '은행명 입력';

  @override
  String get bankAccountOptional => '계좌번호 (선택)';

  @override
  String get enterBankAccount => '계좌번호 입력';

  @override
  String get companyAddressOptional => '회사 주소 (선택)';

  @override
  String get enterCompanyAddress => '회사 주소 입력';

  @override
  String get companyPhoneOptional => '회사 전화번호 (선택)';

  @override
  String get enterCompanyPhone => '회사 전화번호 입력';

  @override
  String get setAsDefaultInvoice => '기본 청구서로 설정';

  @override
  String get confirmDeleteAddress => '정말 이 주소를 삭제하시겠습니까?';

  @override
  String get confirmDeleteInvoice => '정말 이 청구서를 삭제하시겠습니까?';

  @override
  String get groupOwner => '소유자';

  @override
  String get groupAdmin => '관리자';

  @override
  String get searchMembers => '멤버 검색';

  @override
  String totalMembers(int count) {
    return '멤버 $count명';
  }

  @override
  String get removeFromGroup => '그룹에서 삭제';

  @override
  String confirmRemoveMember(String name) {
    return '정말 \"$name\"님을 그룹에서 삭제하시겠습니까?';
  }

  @override
  String get setAsAdmin => '관리자로 설정';

  @override
  String get removeAdmin => '관리자 삭제';

  @override
  String get deleteContactSuccess => '연락처 삭제됨';

  @override
  String get unknownSong => '알 수 없는 곡';

  @override
  String get unknownArtist => '알 수 없는 아티스트';

  @override
  String get unknownContact => '알 수 없는 연락처';

  @override
  String get personalCard => '연락처 카드';

  @override
  String get singleChoice => '단일';

  @override
  String get multiChoice => '복수';

  @override
  String get ended => '종료됨';

  @override
  String get endPollButton => '투표 종료';

  @override
  String get createPoll => '투표 만들기';

  @override
  String get pollQuestion => '투표 질문';

  @override
  String get pollOptions => '투표 옵션';

  @override
  String optionPlaceholder(int index) {
    return '옵션 $index';
  }

  @override
  String get addOption => '옵션 추가';

  @override
  String get pollSettings => '투표 설정';

  @override
  String get anonymousPoll => '익명 투표';

  @override
  String get pollHint => '투표가 채팅에 표시됩니다. 그룹 멤버가 투표할 수 있습니다.';

  @override
  String get searchSongOrArtist => '곡 또는 아티스트 검색';

  @override
  String get noSongsFound => '곡을 찾을 수 없습니다';

  @override
  String get supportedMusicPlatforms => '네이버 음악, 멜론 등의 음악 링크를 지원합니다';

  @override
  String get songNameOptional => '곡 이름 (선택)';

  @override
  String get enterSongName => '곡 이름 입력';

  @override
  String get artistNameOptional => '아티스트 이름 (선택)';

  @override
  String get enterArtistName => '아티스트 이름 입력';

  @override
  String get shareSong => '곡 공유';

  @override
  String get realTimeLocationSharing => '실시간 위치 공유 개발 중...';

  @override
  String get voiceCallFeatureInDev => '음성 통화 기능 개발 중...';

  @override
  String get reportFeatureInDev => '신고 기능 개발 중...';

  @override
  String get shareFeatureInDev => '공유 기능 개발 중...';

  @override
  String get qrCodeFeatureInDev => 'QR 코드 기능 개발 중...';

  @override
  String get scanQrToAddMe => '위의 QR 코드를 스캔하여 친구로 추가하세요';

  @override
  String get saveToAlbum => '앨범에 저장';

  @override
  String get changeStyle => '스타일 변경';

  @override
  String get copyId => 'ID 복사';

  @override
  String get idCopied => 'ID 복사됨';

  @override
  String get shareFeatureComingSoon => '공유 기능 곧 출시 예정';

  @override
  String get saveFeatureComingSoon => '저장 기능 곧 출시 예정';

  @override
  String get moreStylesFeatureComingSoon => '더 많은 스타일 곧 출시 예정';

  @override
  String get confirmEndPoll => '정말 이 투표를 종료하시겠습니까?';

  @override
  String get cannotVoteAfterEnd => '종료 후에는 더 이상 투표할 수 없습니다.';

  @override
  String get bio => '소개';

  @override
  String get homeServer => '서버';

  @override
  String get shareContactCard => '연락처 카드 공유';

  @override
  String get removeFromBlacklist => '차단 목록에서 삭제';

  @override
  String get confirmAddBlacklist =>
      '정말 이 사용자를 차단 목록에 추가하시겠습니까? 이 사용자로부터 메시지를 받지 않게 됩니다.';

  @override
  String get confirmRemoveBlacklist => '정말 이 사용자를 차단 목록에서 삭제하시겠습니까?';

  @override
  String get remarkSaved => '별명 저장됨';

  @override
  String get remarkCleared => '별명 지워짐';

  @override
  String get receive => '받기';

  @override
  String get pleaseConnectWallet => '먼저 지갑을 연결해주세요';

  @override
  String get sendRequest => '요청 보내기';

  @override
  String get pleaseEnterValidAmount => '올바른 금액을 입력해주세요';

  @override
  String get searchPlaceholder => '연락처, 그룹, 메시지 검색';

  @override
  String get enterKeywordToSearch => '키워드를 입력하여 검색 시작';

  @override
  String get clearHistory => '지우기';

  @override
  String noResultsForQuery(String query) {
    return '\"$query\"에 대한 결과 없음';
  }

  @override
  String get allResults => '전체';

  @override
  String get searchInChat => '채팅에서 검색';

  @override
  String get contactLabel => '연락처';

  @override
  String get groupLabel => '그룹';

  @override
  String get conversationLabel => '会话';

  @override
  String get messageLabel => '메시지';

  @override
  String get securityTitle => '보안';

  @override
  String get keyBackup => '키 백업';

  @override
  String get backupEncryptionKeys => '암호화 키 백업';

  @override
  String keysBackedUp(int count) {
    return '키 $count개 백업됨';
  }

  @override
  String get backupNotSet => '백업이 설정되지 않음';

  @override
  String get restoreKeys => '키 복원';

  @override
  String get restoreKeysFromBackup => '백업에서 암호화 키 복원';

  @override
  String get exportKeys => '키 내보내기';

  @override
  String get exportKeysToFile => '파일로 키 내보내기';

  @override
  String get loggedInDevices => '로그인된 기기';

  @override
  String get noOtherDevices => '다른 기기 없음';

  @override
  String get verified => '인증됨';

  @override
  String get unverified => '미인증';

  @override
  String get advanced => '고급';

  @override
  String get crossSigning => '교차 서명';

  @override
  String get enabled => '활성화됨';

  @override
  String get notEnabled => '활성화되지 않음';

  @override
  String get resetEncryption => '암호화 재설정';

  @override
  String get deleteAllEncryptionKeys => '모든 암호화 키 삭제';

  @override
  String get encryptionNotSupported => '암호화가 지원되지 않습니다';

  @override
  String get notInitialized => '초기화되지 않음';

  @override
  String get backupKeyTitle => '키 백업';

  @override
  String get backupKeyMessage =>
      '새 키 백업을 생성하시겠습니까? 새 기기에서 암호화된 메시지를 복원하는 데 도움이 됩니다.';

  @override
  String get backup => '백업';

  @override
  String get restoreKeyTitle => '키 복원';

  @override
  String get restoreKeyMessage => '복구 비밀번호 또는 복구 키를 입력하여 암호화된 메시지를 복원하세요.';

  @override
  String get restore => '복원';

  @override
  String get exportKeyTitle => '키 내보내기';

  @override
  String get exportKeyMessage => '내보낸 키 파일에는 모든 암호화 키가 포함됩니다. 안전하게 보관해주세요.';

  @override
  String get export => '내보내기';

  @override
  String deviceIdLabel(String deviceId) {
    return '기기 ID: $deviceId';
  }

  @override
  String get deviceStatusVerified => '상태: 인증됨';

  @override
  String get deviceStatusUnverified => '상태: 미인증';

  @override
  String lastActiveLabel(String lastSeen) {
    return '마지막 활동: $lastSeen';
  }

  @override
  String get verifyThisDevice => '이 기기 인증';

  @override
  String get crossSigningAlreadyEnabled => '교차 서명이 이미 활성화되어 있습니다';

  @override
  String get crossSigningSetupSuccess => '교차 서명 설정 성공';

  @override
  String get resetEncryptionTitle => '암호화 재설정';

  @override
  String get resetEncryptionWarning =>
      '경고: 이 작업은 모든 암호화 키를 삭제합니다. 이전의 암호화된 메시지를 복호화할 수 없게 됩니다. 이 작업은 취소할 수 없습니다.';

  @override
  String get reset => '재설정';

  @override
  String get leaveMeetingConfirm => '정말 회의를 나가시겠습니까?';

  @override
  String pokedSomeone(String name, String suffix) {
    return '$name님을 찔렀어요$suffix';
  }

  @override
  String get noContactsToAdd => '추가할 연락처가 없습니다';

  @override
  String get addMembers => '멤버 추가';

  @override
  String invitedMembers(int count) {
    return '멤버 $count명 초대됨';
  }

  @override
  String inviteFailed(String error) {
    return '초대 실패: $error';
  }

  @override
  String get memberRemoved => '멤버 삭제됨';

  @override
  String removeFailed(String error) {
    return '삭제 실패: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      '공유 후 상대방이 1시간 동안 당신의 실시간 위치를 볼 수 있습니다.';

  @override
  String get startSharing => '공유 시작';

  @override
  String get locationServiceNotEnabled => '위치 서비스가 활성화되지 않았습니다';

  @override
  String get enableLocationService => '이 기능을 사용하려면 위치 서비스를 활성화해주세요';

  @override
  String get goToSettings => '설정으로 이동';

  @override
  String get locationPermissionRequired => '이 기능을 사용하려면 위치 권한이 필요합니다';

  @override
  String get locationPermissionDeniedPermanent =>
      '위치 권한이 영구적으로 거부되었습니다. 설정에서 활성화해주세요.';

  @override
  String get locationPermissionDenied => '위치 권한 거부됨';

  @override
  String get gettingLocation => '위치 가져오는 중...';

  @override
  String getLocationFailed(String error) {
    return '위치 가져오기 실패: $error';
  }

  @override
  String get currentLocation => '현재 위치';

  @override
  String nearbyPlace(int index) {
    return '주변 장소 $index';
  }

  @override
  String approximateDistance(String distance) {
    return '약 $distance';
  }

  @override
  String get mapPreview => '지도 미리보기';

  @override
  String get searchLocation => '위치 검색';

  @override
  String redPacketSent(String amount, String token) {
    return '$amount $token 레드패킷 전송됨';
  }

  @override
  String get transferDefault => '송금';

  @override
  String transferSent(String amount, String token) {
    return '$amount $token 송금 전송됨';
  }

  @override
  String pickFileFailed(String error) {
    return '파일 선택 실패: $error';
  }

  @override
  String get fileSizeLimit => '파일 크기는 50MB를 초과할 수 없습니다';

  @override
  String fileSending(String filename) {
    return '파일 전송 중: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return '파일 전송 실패: $error';
  }

  @override
  String contactCardSent(String name) {
    return '$name님의 연락처 카드 전송됨';
  }

  @override
  String get favoritesFeature => '즐겨찾기';

  @override
  String get couponsFeature => '쿠폰';

  @override
  String get giftFeature => '선물';

  @override
  String sharedMusic(String name) {
    return '$name 공유됨';
  }

  @override
  String get endPollTitle => '투표 종료';

  @override
  String get endPollConfirmMessage => '정말 이 투표를 종료하시겠습니까? 종료 후에는 투표가 마감됩니다.';

  @override
  String get pollEndedMessage => '투표가 종료되었습니다';

  @override
  String get connectingCall => '연결 중...';

  @override
  String get muteCall => '음소거';

  @override
  String get speakerOff => '스피커 끄기';

  @override
  String get speakerOn => '스피커';

  @override
  String get cameraOn => '카메라 켜기';

  @override
  String get cameraOff => '카메라 끄기';

  @override
  String get hangUp => '끊기';

  @override
  String get selectForwardTargetTitle => '전달 대상 선택';

  @override
  String get noForwardableChat => '전달 가능한 채팅이 없습니다';

  @override
  String get noMatchingChat => '일치하는 채팅을 찾을 수 없습니다';

  @override
  String get imagePreview => '[이미지]';

  @override
  String get voicePreview => '[음성]';

  @override
  String get videoPreview => '[동영상]';

  @override
  String filePreviewWithName(String filename) {
    return '[파일] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[위치] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[음악] $title';
  }

  @override
  String get messagePreview => '[메시지]';

  @override
  String get locationTitle => '위치';

  @override
  String get sendButton => '전송';

  @override
  String get retryButton => '다시 시도';

  @override
  String get selectContact => '연락처 선택';

  @override
  String get searchContactHint => '연락처 검색';

  @override
  String get shareMusic => '음악 공유';

  @override
  String get recentPlayed => '최근';

  @override
  String get myFavorites => '즐겨찾기';

  @override
  String get networkLink => '링크';

  @override
  String get localFile => '로컬';

  @override
  String get musicLinkRequired => '음악 링크 *';

  @override
  String get pasteMusicLink => '음악 링크 붙여넣기';

  @override
  String get enterSongNamePlaceholder => '곡 이름 입력';

  @override
  String get enterArtistNamePlaceholder => '아티스트 이름 입력';

  @override
  String get shareMusicButton => '음악 공유';

  @override
  String get selectLocalAudio => '로컬 오디오 파일 선택';

  @override
  String get supportedAudioFormats => 'MP3, M4A, WAV, FLAC 등 지원';

  @override
  String get selectFileButton => '파일 선택';

  @override
  String get pleaseEnterMusicLink => '음악 링크를 입력해주세요';

  @override
  String get pleaseEnterValidLink => '올바른 URL을 입력해주세요';

  @override
  String get sharedSong => '공유된 곡';

  @override
  String get selectMember => '멤버 선택';

  @override
  String get searchMemberHint => '멤버 검색';

  @override
  String get noMatchingMembers => '일치하는 멤버를 찾을 수 없습니다';

  @override
  String get unknownMember => '알 수 없음';

  @override
  String selectedMessagesCount(int count) {
    return '$count개 메시지 선택됨';
  }

  @override
  String get searchContactsOrGroups => '연락처 또는 그룹 검색';

  @override
  String get noMatchingConversations => '일치하는 대화를 찾을 수 없습니다';

  @override
  String get videoTitle => '동영상';

  @override
  String get loadingText => '로딩 중...';

  @override
  String get videoPlaybackFailed => '동영상 재생 실패';

  @override
  String get videoLoadFailed => '동영상 로드 실패';

  @override
  String get playerInitFailed => '플레이어 초기화 실패';

  @override
  String get createPollTitle => '투표 만들기';

  @override
  String get submitPoll => '제출';

  @override
  String get pollQuestionLabel => '투표 질문';

  @override
  String get enterPollQuestionHint => '투표 질문을 입력해주세요';

  @override
  String get pollOptionsLabel => '투표 옵션';

  @override
  String optionHintWithIndex(int index) {
    return '옵션 $index';
  }

  @override
  String get addOptionButton => '옵션 추가';

  @override
  String get pollSettingsLabel => '투표 설정';

  @override
  String get selectionType => '선택 유형';

  @override
  String get singleChoiceLabel => '단일';

  @override
  String get multiChoiceLabel => '복수';

  @override
  String get anonymousPollSwitch => '익명 투표';

  @override
  String get pleaseEnterQuestion => '투표 질문을 입력해주세요';

  @override
  String get atLeastTwoOptions => '최소 2개의 옵션이 필요합니다';

  @override
  String confirmWithCount(int count) {
    return '확인 ($count)';
  }

  @override
  String get emailVerificationTitle => '이메일 인증';

  @override
  String get enterValidEmailAddress => '올바른 이메일 주소를 입력해주세요';

  @override
  String verificationCodeSentTo(String email) {
    return '인증 코드가 $email로 전송되었습니다';
  }

  @override
  String sendCodeFailed(String error) {
    return '코드 전송 실패: $error';
  }

  @override
  String get verificationSuccess => '인증 성공';

  @override
  String get verificationFailed => '인증 실패';

  @override
  String verificationCodeError(String error) {
    return '인증 코드 오류: $error';
  }

  @override
  String get enterVerificationCode => '인증 코드 입력';

  @override
  String get enterYourEmail => '이메일 입력';

  @override
  String weSentCodeTo(String email) {
    return '6자리 코드를 보냈습니다\n$email';
  }

  @override
  String get enterEmailForCode => '이메일 주소를 입력하시면 인증 코드를 보내드립니다';

  @override
  String get sendVerificationCode => '인증 코드 보내기';

  @override
  String get resendVerificationCode => '인증 코드 다시 보내기';

  @override
  String canResendAfter(int seconds) {
    return '$seconds초 후 다시 보낼 수 있습니다';
  }

  @override
  String get changeEmail => '이메일 변경';

  @override
  String get addToContacts => '연락처에 추가';

  @override
  String get addingToContacts => '추가 중...';

  @override
  String get addedToContacts => '연락처에 추가됨';

  @override
  String addFailedWithError(String error) {
    return '추가 실패: $error';
  }

  @override
  String get addPhone => '전화번호 추가';

  @override
  String get addTag => '태그 추가';

  @override
  String get addText => '텍스트 추가';

  @override
  String get addPhoto => '사진 추가';

  @override
  String groupCountLabel(int count) {
    return '그룹 $count개';
  }

  @override
  String get addedViaSearch => '검색으로 추가됨';

  @override
  String get addTime => '추가 시간';

  @override
  String get doneButton => '완료';

  @override
  String get waitingForParticipants => '참가자 대기 중...';

  @override
  String participantMe(String name) {
    return '$name (나)';
  }

  @override
  String get sharingLabel => '공유 중';

  @override
  String screenSharingBy(String name) {
    return '$name님이 화면 공유 중';
  }

  @override
  String participantCount(int count) {
    return '참가자 $count명';
  }

  @override
  String get muteLabel => '음소거';

  @override
  String get unmuteLabel => '음소거 해제';

  @override
  String get turnOffVideo => '영상 끄기';

  @override
  String get turnOnVideo => '영상 켜기';

  @override
  String get shareScreen => '화면 공유';

  @override
  String get stopSharing => '공유 중지';

  @override
  String get switchCameraLabel => '전환';

  @override
  String get leaveLabel => '나가기';

  @override
  String get participantsLabel => '참가자';

  @override
  String get joiningMeeting => '회의 참여 중...';

  @override
  String pollVotesFormat(int count, String percentage) {
    return '$count표 ($percentage%)';
  }

  @override
  String pollParticipantsFormat(int count) {
    return '$count명 참여';
  }

  @override
  String get tapToRetry => '탭하여 다시 시도';

  @override
  String get noConversationsToForward => '전달할 대화가 없습니다';

  @override
  String get defaultRedPacketGreeting => '부자 되세요, 행운을 빕니다';

  @override
  String get emojiCategoryFace => '이모티콘';

  @override
  String get emojiCategoryHeart => '하트';

  @override
  String get emojiCategoryAnimal => '동물';

  @override
  String get emojiCategoryFood => '음식';

  @override
  String get emojiCategoryTransport => '교통';

  @override
  String get emojiCategoryActivity => '활동';

  @override
  String get emojiCategoryObject => '사물';

  @override
  String get emojiCategorySymbol => '기호';

  @override
  String get allowOthersToSearchAndJoin => '다른 사용자가 검색하고 참여하도록 허용';

  @override
  String get allowStrangerMessages => '모르는 사람의 메시지 허용';

  @override
  String get alwaysUseDarkTheme => '항상 어두운 테마 사용';

  @override
  String get alwaysUseLightTheme => '항상 밝은 테마 사용';

  @override
  String get autoSwitchBySystem => '시스템 설정에 따라 자동 전환';

  @override
  String get bubbleStyle => '말풍선 스타일';

  @override
  String get bubbleStyleClassic => '클래식 스타일';

  @override
  String get bubbleStyleClassicDesc => '전통적인 말풍선 스타일';

  @override
  String get bubbleStyleModern => '모던 스타일';

  @override
  String get bubbleStyleModernDesc => '깔끔한 모던 말풍선 스타일';

  @override
  String get bubbleStyleWechat => 'WeChat 스타일';

  @override
  String get bubbleStyleWechatDesc => '클래식 WeChat 말풍선 스타일';

  @override
  String get callEnded => '통화 종료';

  @override
  String get callFailed => '통화 실패';

  @override
  String get checkForUpdates => '업데이트 확인';

  @override
  String get confirmClearChatHistory => '채팅 기록을 정말 삭제하시겠습니까?';

  @override
  String get createGroupToChat => '그룹을 만들어 채팅을 시작하세요';

  @override
  String get darkMode => '다크 모드';

  @override
  String get darkModeOption => '다크 모드';

  @override
  String get doNotDisturbDescription => '지정된 시간 동안 알림을 받지 않습니다';

  @override
  String get doNotDisturbMode => '방해 금지';

  @override
  String get editGroupAnnouncement => '그룹 공지 수정';

  @override
  String get editGroupDescription => '그룹 설명 수정';

  @override
  String get enterGroupAnnouncement => '그룹 공지를 입력하세요';

  @override
  String errorWithMessage(String message) {
    return '오류: $message';
  }

  @override
  String get feedbackAndSuggestions => '피드백 및 제안';

  @override
  String get followSystem => '시스템 설정 따르기';

  @override
  String get fontSize => '글꼴 크기';

  @override
  String get fontSizeExtraLarge => '매우 크게';

  @override
  String get fontSizeLarge => '크게';

  @override
  String get fontSizeSmall => '작게';

  @override
  String get fontSizeStandard => '표준';

  @override
  String get incomingVideoCall => '영상 통화 수신';

  @override
  String get incomingVoiceCall => '음성 통화 수신';

  @override
  String get letOthersKnowYouRead => '읽음 확인 보내기';

  @override
  String get letOthersKnowYouTyping => '입력 중임을 상대방에게 알리기';

  @override
  String get lightMode => '라이트 모드';

  @override
  String memberCountClickToCopy(int count) {
    return '$count명, 클릭하여 그룹 ID 복사';
  }

  @override
  String get messageNotifications => '메시지 알림';

  @override
  String get messagesLabel => '메시지';

  @override
  String get musicLinkLabel => '음악 링크';

  @override
  String get noMediaUrlAvailable => '미디어 URL을 사용할 수 없습니다';

  @override
  String get noPermissionToEditGroupName => '그룹 이름을 수정할 권한이 없습니다';

  @override
  String get receiveMessagesFromNonContacts => '연락처에 없는 사람의 메시지 받기';

  @override
  String get receiveNewMessageNotifications => '새 메시지 알림 받기';

  @override
  String get reconnectingCall => '재연결 중...';

  @override
  String get redPacketTransferCannotForward => '홍바오와 송금은 전달할 수 없습니다';

  @override
  String get showMessageContentInNotification => '알림에 메시지 내용 표시';

  @override
  String get showMessagePreview => '메시지 미리보기 표시';

  @override
  String get typingIndicator => '입력 중 표시';

  @override
  String versionInfo(String version) {
    return '버전 $version';
  }

  @override
  String get vibration => '진동';

  @override
  String get videoCallInProgress => '영상 통화 중';

  @override
  String get voiceCallInProgress => '음성 통화 중';

  @override
  String whoCanSeeTitle(String title) {
    return '$title을(를) 볼 수 있는 사람';
  }
}
