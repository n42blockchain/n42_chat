// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class SKo extends S {
  SKo([String locale = 'ko']) : super(locale);

  @override
  String get commonRetry => '다시 시도';

  @override
  String get commonUnknownUser => '알 수 없는 사용자';

  @override
  String get transferWalletNotConnected => '지갑이 연결되지 않음';

  @override
  String get chatCallServiceNotInitialized => '통화 서비스가 초기화되지 않았습니다';

  @override
  String authLoginFailed(String error) {
    return '로그인 실패: $error';
  }

  @override
  String get chatCallBack => '다시 전화';

  @override
  String get chatMissedVideoCall => '부재중 영상통화';

  @override
  String get chatMissedVoiceCall => '부재중 음성통화';

  @override
  String get chatCallNotAnswered => '응답 없음';

  @override
  String get chatCallDurationLabel => '통화 시간';

  @override
  String get chatVoiceCallCancelled => '음성 통화 취소됨';

  @override
  String get chatVideoCallCancelled => '영상 통화 취소됨';

  @override
  String get commonImage => '[이미지]';

  @override
  String get chatVideo => '[동영상]';

  @override
  String get chatVoice => '[음성]';

  @override
  String get commonFile => '[파일]';

  @override
  String get chatLocation => '[위치]';

  @override
  String get chatUnknownMessage => '[알 수 없는 메시지]';

  @override
  String get commonDelete => '삭제';

  @override
  String get chatDeleteThisMessage => '이 메시지를 삭제하시겠습니까?';

  @override
  String get chatMessageDeleted => '메시지가 삭제되었습니다';

  @override
  String get profileNotLoggedIn => '로그인되지 않음';

  @override
  String get chatMyLocation => '내 위치';

  @override
  String get commonGroupChat => '그룹 채팅';

  @override
  String get commonSearch => '검색';

  @override
  String get commonCancel => '취소';

  @override
  String get commonLoadFailed => '로드 실패';

  @override
  String get commonMessages => '메시지';

  @override
  String get commonContacts => '연락처';

  @override
  String get commonMe => '나';

  @override
  String get commonVoiceLoading => '음성 로딩 중, 잠시 후 다시 시도해주세요';

  @override
  String get commonVoiceToTextFailed => '음성을 텍스트로 변환 실패';

  @override
  String get commonConvertToText => '텍스트로 변환';

  @override
  String get chatCopy => '복사';

  @override
  String get commonForward => '전달';

  @override
  String get commonUnfavorite => '즐겨찾기 해제';

  @override
  String get commonFavorite => '즐겨찾기';

  @override
  String get settingsResend => '다시 보내기';

  @override
  String get chatRecall => '메시지 취소';

  @override
  String get commonQuote => '인용';

  @override
  String get commonRemind => '멘션';

  @override
  String get chatCopied => '복사됨';

  @override
  String get storySendMessageHint => '메시지 보내기';

  @override
  String get commonMicrophonePermissionRequired => '마이크 권한을 허용해주세요';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return '녹음 시작 실패: $error';
  }

  @override
  String get commonRecordingTooShort => '녹음이 너무 짧습니다';

  @override
  String commonStopRecordingFailed(String error) {
    return '녹음 중지 실패: $error';
  }

  @override
  String get chatReleaseToCancel => '손가락을 떼면 취소';

  @override
  String get chatReleaseToSend => '손가락을 떼면 전송, 위로 스와이프하면 취소';

  @override
  String get commonHoldToTalk => '길게 눌러서 말하기';

  @override
  String get commonSend => '전송';

  @override
  String get commonAddFriend => '친구 추가';

  @override
  String get commonChatServiceNotConnected => '채팅 서비스에 연결되지 않음';

  @override
  String contactUserNotFoundHint(String query) {
    return '사용자 \"$query\"를 찾을 수 없습니다\n\n팁:\n• 전체 사용자 ID를 입력해보세요 (예: @username:server.com)\n• 사용자 이름 철자를 확인해주세요';
  }

  @override
  String contactCreateChatFailed(String error) {
    return '채팅 생성 실패: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return '검색 실패: $error';
  }

  @override
  String get contactEnterUserIdOrUsername => '검색할 사용자 ID 또는 이름을 입력하세요';

  @override
  String get contactSearching => '검색 중...';

  @override
  String get contactSearchUserToChat => '채팅할 사용자를 검색하세요';

  @override
  String get contactMatrixIdExample =>
      '전체 Matrix ID를 입력할 수 있습니다\n예: @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return '사용자 \"$username\"를 찾을 수 없습니다';
  }

  @override
  String get commonChat => '채팅';

  @override
  String get commonSettings => '설정';

  @override
  String get profileEditProfile => '프로필 편집';

  @override
  String get authLogin => '로그인';

  @override
  String get commonCreateGroup => '그룹 만들기';

  @override
  String get chatError => '오류';

  @override
  String get commonTransfer => '송금';

  @override
  String get commonReceived => '받음';

  @override
  String get commonRefunded => '환불됨';

  @override
  String get commonExpired => '만료됨';

  @override
  String get chatRedPacketGreeting => '행운을 빕니다';

  @override
  String get commonN42RedPacket => 'N42 레드패킷';

  @override
  String get commonClaimed => '수령 완료';

  @override
  String get commonAllClaimed => '모두 수령됨';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => '답장';

  @override
  String get commonEdit => '편집';

  @override
  String get chatSelectForwardTarget => '받는 사람 선택';

  @override
  String commonSendCount(int count) {
    return '전송 ($count)';
  }

  @override
  String contactN42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get profileN42IdTitle => 'N42 ID';

  @override
  String get profileN42Bean => 'N42 빈';

  @override
  String get contactFriendInfo => '친구 정보';

  @override
  String get contactFriendInfoDesc =>
      '친구의 별명, 전화번호, 태그, 메모, 사진을 추가하고 권한을 설정하세요.';

  @override
  String get commonMoments => '모먼트';

  @override
  String get commonSendMessage => '메시지';

  @override
  String get contactAudioVideoCall => '음성/영상 통화';

  @override
  String get contactVideoChannel => '영상 채널';

  @override
  String get contactRemark => '별명';

  @override
  String get contactRemarkName => '별명';

  @override
  String get contactPhone => '전화번호';

  @override
  String get contactTags => '태그';

  @override
  String get contactNotes => '메모';

  @override
  String get contactPhotos => '사진';

  @override
  String get contactPermissions => '권한';

  @override
  String get contactChatMomentsEtc => '채팅, 모먼트, 운동 등';

  @override
  String get contactMoreInfo => '추가 정보';

  @override
  String get contactCommonGroups => '공통 그룹';

  @override
  String get contactSource => '출처';

  @override
  String get settingsNotificationSettings => '알림';

  @override
  String get settingsPrivacy => '개인정보';

  @override
  String get settingsAppearance => '외관';

  @override
  String get settingsAbout => '정보';

  @override
  String get commonLogout => '로그아웃';

  @override
  String get commonLogoutConfirm => '정말 로그아웃하시겠습니까?';

  @override
  String get commonSave => '저장';

  @override
  String get profileNickname => '닉네임';

  @override
  String get profileEnterNickname => '닉네임 입력';

  @override
  String get profileSignature => '상태 메시지';

  @override
  String get profileAddSignature => '상태 메시지 추가';

  @override
  String get commonTakePhoto => '사진 촬영';

  @override
  String get profileChooseFromGallery => '갤러리에서 선택';

  @override
  String profileSaveFailed(String error) {
    return '저장 실패: $error';
  }

  @override
  String get authSecureDecentralizedChat => '안전한 분산형 메시징';

  @override
  String get commonEndToEndEncryption => '종단간 암호화';

  @override
  String get authMessagesOnlyYouCanSee => '나와 상대방만 볼 수 있는 메시지';

  @override
  String get authDecentralized => '분산형';

  @override
  String get authBasedOnMatrix => 'Matrix 오픈 프로토콜 기반';

  @override
  String get authWalletIntegration => '지갑 연동';

  @override
  String get authEasyCryptoTransfer => '간편한 암호화폐 송금';

  @override
  String get authRegister => '회원가입';

  @override
  String get authAgreeTerms => '로그인하면 다음에 동의하는 것으로 간주됩니다';

  @override
  String get authTermsOfService => '서비스 약관';

  @override
  String get authAnd => '및';

  @override
  String get authPrivacyPolicy => '개인정보 처리방침';

  @override
  String get authServerAddress => '서버 주소';

  @override
  String get authEnterServerAddress => '서버 주소 입력';

  @override
  String authConnectedTo(String serverName) {
    return '$serverName에 연결됨';
  }

  @override
  String get authUsername => '아이디';

  @override
  String get authEnterUsername => '아이디 입력';

  @override
  String get authPassword => '비밀번호';

  @override
  String get authEnterPassword => '비밀번호 입력';

  @override
  String get authRegisterAccount => '회원가입';

  @override
  String get authForgotPassword => '비밀번호 찾기';

  @override
  String get authOtherLoginMethods => '다른 로그인 방법';

  @override
  String get authCreateAccount => '계정 만들기';

  @override
  String get authJoinN42Chat => 'N42 Chat에 가입하여 채팅을 시작하세요';

  @override
  String get authUsernameHint => '3-20자, 영문/숫자/_';

  @override
  String get authUsernameMinLength => '아이디는 최소 3자 이상이어야 합니다';

  @override
  String get authUsernameMaxLength => '아이디는 최대 20자까지 가능합니다';

  @override
  String get authUsernameFormat => '아이디는 영문, 숫자, 밑줄만 사용할 수 있습니다';

  @override
  String get authPasswordHint => '최소 8자';

  @override
  String get commonPasswordMinLength => '비밀번호는 최소 8자 이상이어야 합니다';

  @override
  String get authConfirmPassword => '비밀번호 확인';

  @override
  String get authFilled => '입력됨';

  @override
  String get authEnterInviteCode => '초대 코드 입력';

  @override
  String get authAlreadyHaveAccount => '이미 계정이 있으신가요?';

  @override
  String get authLoginNow => '지금 로그인';

  @override
  String get profileAvatar => '프로필 사진';

  @override
  String get profileStatus => '상태';

  @override
  String get commonLoading => '로딩 중...';

  @override
  String get conversationNoConversations => '대화 없음';

  @override
  String get conversationTapToChat => '오른쪽 상단을 탭하여 채팅 시작';

  @override
  String get conversationStartGroup => '그룹 채팅 시작';

  @override
  String get commonScan => '스캔';

  @override
  String get commonPayment => '결제';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature 곧 출시 예정';
  }

  @override
  String get conversationMarkAsRead => '읽음으로 표시';

  @override
  String get commonUnmute => '알림 켜기';

  @override
  String get commonMute => '알림 끄기';

  @override
  String get conversationUnpin => '고정 해제';

  @override
  String get conversationPin => '고정';

  @override
  String get conversationDeleteConversation => '대화 삭제';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return '\"$name\"님과의 대화를 삭제하시겠습니까?';
  }

  @override
  String get commonNoContacts => '연락처 없음';

  @override
  String get contactAddFriendsToChat => '친구를 추가하여 채팅을 시작하세요';

  @override
  String get contactNotFound => '연락처를 찾을 수 없습니다';

  @override
  String get contactTryOtherKeywords => '다른 키워드로 시도하거나 전체 검색을 이용하세요';

  @override
  String get contactSearchResults => '검색 결과';

  @override
  String get contactNewFriends => '새 친구';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => '공식 계정';

  @override
  String get contactServiceAccounts => '서비스 계정';

  @override
  String get contactEnterpriseContacts => '기업 연락처';

  @override
  String get contactRecommendToFriend => '연락처 공유';

  @override
  String get commonSetRemark => '별명 설정';

  @override
  String get contactSendingCard => '연락처 카드 전송 중...';

  @override
  String get commonFileLabel => '파일';

  @override
  String get commonLocationLabel => '위치';

  @override
  String contactRecommendFailed(String error) {
    return '추천 실패: $error';
  }

  @override
  String get profileEnterRemark => '별명 입력';

  @override
  String get contactOpeningChat => '채팅 열는 중...';

  @override
  String contactOpenChatFailed(String error) {
    return '채팅 열기 실패: $error';
  }

  @override
  String get contactAddContact => '연락처 추가';

  @override
  String get contactEnterUserId => '사용자 ID 입력';

  @override
  String get contactNoFriendRequests => '친구 요청 없음';

  @override
  String get commonAccept => '수락';

  @override
  String get commonReject => '거절';

  @override
  String get commonNoGroups => '그룹 없음';

  @override
  String get contactSelectFriendToRecommend => '추천할 친구 선택';

  @override
  String get commonSearchContacts => '연락처 검색';

  @override
  String get contactNoContactsFound => '연락처를 찾을 수 없습니다';

  @override
  String get favoriteYesterday => '어제';

  @override
  String get chatJustNow => '방금';

  @override
  String get profileOnline => '온라인';

  @override
  String get profileOffline => '오프라인';

  @override
  String get searchContactsGroupsMessages => '연락처, 그룹, 메시지 검색';

  @override
  String get searchError => '검색 오류';

  @override
  String get chatSearchHint => '연락처, 그룹, 메시지 검색';

  @override
  String get searchHistory => '검색 기록';

  @override
  String get commonClear => '지우기';

  @override
  String get commonAll => '전체';

  @override
  String get searchGroups => '그룹';

  @override
  String get searchNoResults => '결과 없음';

  @override
  String commonGroupMembers(int count) {
    return '멤버 ($count명)';
  }

  @override
  String get groupMembersTitle => '그룹 멤버';

  @override
  String get groupViewAll => '모두 보기';

  @override
  String get groupOwner => '소유자';

  @override
  String get groupAdmin => '관리자';

  @override
  String get groupInvite => '초대';

  @override
  String get commonGroupAnnouncement => '그룹 공지';

  @override
  String get commonNotSet => '설정되지 않음';

  @override
  String get groupDescription => '그룹 설명';

  @override
  String get groupPublicGroup => '공개 그룹';

  @override
  String get commonClearChatHistory => '채팅 기록 지우기';

  @override
  String get commonDissolveGroup => '그룹 해체';

  @override
  String get commonLeaveGroup => '그룹 나가기';

  @override
  String get groupChangeGroupName => '그룹 이름 변경';

  @override
  String get commonEnterGroupName => '그룹 이름 입력';

  @override
  String get commonConfirm => '확인';

  @override
  String get groupEnterGroupDescription => '그룹 설명 입력';

  @override
  String get groupPublish => '게시';

  @override
  String get chatClearHistoryConfirm => '모든 채팅 기록을 지우시겠습니까? 이 작업은 취소할 수 없습니다.';

  @override
  String get chatClearAction => '지우기';

  @override
  String get commonChatHistoryCleared => '채팅 기록이 삭제되었습니다';

  @override
  String get commonDissolve => '해체';

  @override
  String get groupQrCode => '그룹 QR 코드';

  @override
  String get commonSearchChatHistory => '채팅 기록 검색';

  @override
  String get groupIdCopied => '그룹 ID 복사됨';

  @override
  String get transferEnterOrPasteAddress => '지갑 주소 입력 또는 붙여넣기';

  @override
  String get transferSelectToken => '토큰 선택';

  @override
  String get commonTransferAmount => '송금 금액';

  @override
  String get transferAvailable => '사용 가능';

  @override
  String get transferMemoOptional => '메모 (선택)';

  @override
  String get transferConfirmTransfer => '송금 확인';

  @override
  String get transferAddressVerified => '주소 확인됨';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return '사용 가능: $balance $symbol';
  }

  @override
  String get commonEnterAmount => '금액 입력';

  @override
  String get commonRedPacketCountMin => '최소 1개의 레드패킷이 필요합니다';

  @override
  String get commonViewRedPacketDetails => '레드패킷 상세 보기';

  @override
  String get commonEnterTransferAmount => '송금 금액 입력';

  @override
  String get commonTransferTo => '받는 사람';

  @override
  String commonFromSender(String name, Object senderName) {
    return '$senderName님으로부터';
  }

  @override
  String get commonConfirmReceive => '수령 확인';

  @override
  String get groupProfile => '그룹 정보';

  @override
  String get groupRemoveMember => '그룹에서 삭제';

  @override
  String get commonRemove => '삭제';

  @override
  String get profileClearStatus => '상태 지우기';

  @override
  String get profileClearStatusConfirm => '현재 상태를 지우시겠습니까?';

  @override
  String get profileStatusCleared => '상태가 지워졌습니다';

  @override
  String get profileUserNotExist => '사용자가 존재하지 않습니다';

  @override
  String get profileUserIdCopied => '사용자 ID 복사됨';

  @override
  String get commonReport => '신고';

  @override
  String get profileQrCode => 'QR 코드';

  @override
  String get profileAvatarUpdated => '프로필 사진이 업데이트되었습니다';

  @override
  String commonSelectImageFailed(String error) {
    return '이미지 선택 실패: $error';
  }

  @override
  String get profileChangeName => '이름 변경';

  @override
  String get profileMale => '남성';

  @override
  String get profileFemale => '여성';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature 개발 중...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return '주소 저장 실패: $error';
  }

  @override
  String get profileAddNew => '추가';

  @override
  String get profileAddAddress => '주소 추가';

  @override
  String get profileAddressAdded => '주소가 추가되었습니다';

  @override
  String get profileAddressUpdated => '주소가 업데이트되었습니다';

  @override
  String get profileDeleteAddress => '주소 삭제';

  @override
  String get profileAddressDeleted => '주소가 삭제되었습니다';

  @override
  String profileSaveInvoiceFailed(String error) {
    return '청구서 저장 실패: $error';
  }

  @override
  String get profileMyInvoices => '내 청구서';

  @override
  String get profileAddInvoice => '청구서 추가';

  @override
  String get profileInvoiceAdded => '청구서가 추가되었습니다';

  @override
  String get profileInvoiceUpdated => '청구서가 업데이트되었습니다';

  @override
  String get profileDeleteInvoice => '청구서 삭제';

  @override
  String get profileInvoiceDeleted => '청구서가 삭제되었습니다';

  @override
  String get profilePersonal => '개인';

  @override
  String get groupSelectAtLeastOne => '최소 한 명의 멤버를 선택해주세요';

  @override
  String get chatFileNotExist => '파일이 존재하지 않습니다';

  @override
  String chatSendFailed(String error) {
    return '전송 실패: $error';
  }

  @override
  String get chatCannotOpenBrowser => '브라우저를 열 수 없습니다';

  @override
  String chatSelectFileFailed(String error) {
    return '파일 선택 실패: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return '설정 실패: $error';
  }

  @override
  String get transferEnterValidAmount => '올바른 금액을 입력해주세요';

  @override
  String get commonAddressCopied => '주소 복사됨';

  @override
  String favoriteOpenItem(String content) {
    return '열기: $content';
  }

  @override
  String get favoriteDeleted => '삭제됨';

  @override
  String get profileWallet => '지갑';

  @override
  String get chatRecording => '녹음 중';

  @override
  String get chatInvalidVideoUrl => '잘못된 동영상 URL';

  @override
  String get chatDownloadFile => '파일 다운로드';

  @override
  String get chatClearChatHistoryTitle => '채팅 기록 지우기';

  @override
  String get chatVideoCall => '영상 통화';

  @override
  String get commonVoiceCall => '음성 통화';

  @override
  String get callLeaveMeeting => '회의 나가기';

  @override
  String get chatDetails => '채팅 상세';

  @override
  String get chatViewAllGroupMembers => '모든 멤버 보기';

  @override
  String get chatGroupName => '그룹 이름';

  @override
  String get chatGroupNameUpdated => '그룹 이름이 업데이트되었습니다';

  @override
  String get chatUpdateFailed => '업데이트 실패';

  @override
  String get chatNoPermissionToModify => '수정 권한이 없습니다';

  @override
  String get chatGroupManagement => '그룹 관리';

  @override
  String get chatMyNicknameInGroup => '그룹 내 내 별명';

  @override
  String get chatPinChat => '채팅 고정';

  @override
  String get chatStrongReminder => '강력 알림';

  @override
  String get chatSetChatBackground => '채팅 배경 설정';

  @override
  String get chatUnknownFile => '알 수 없는 파일';

  @override
  String get chatDownload => '다운로드';

  @override
  String get chatInvalidLocation => '잘못된 위치';

  @override
  String get chatTapToCancel => '탭하여 취소';

  @override
  String chatCaptureFailed(Object error) {
    return '캡처 실패: $error';
  }

  @override
  String get chatProcessingVideo => '동영상 처리 중...';

  @override
  String get chatVideoFileNotExist => '동영상 파일이 존재하지 않습니다';

  @override
  String get chatVideoDataEmpty => '동영상 데이터가 비어 있습니다';

  @override
  String get chatVideoTooLarge => '동영상 크기는 100MB를 초과할 수 없습니다';

  @override
  String get chatSendingVideo => '동영상 전송 중...';

  @override
  String chatSendVideoFailed(Object error) {
    return '동영상 전송 실패: $error';
  }

  @override
  String get chatImageFileNotExist => '이미지 파일이 존재하지 않습니다';

  @override
  String get commonImageDataEmpty => '이미지 데이터가 비어 있습니다';

  @override
  String get chatSendingImage => '이미지 전송 중...';

  @override
  String chatSendImageFailed(Object error) {
    return '이미지 전송 실패: $error';
  }

  @override
  String get chatSendLocation => '위치 보내기';

  @override
  String get chatSelectLocationAndSend => '위치를 선택하고 보내기';

  @override
  String get chatShareRealTimeLocation => '실시간 위치 공유';

  @override
  String get chatShareLocationForOneHour => '친구와 1시간 동안 실시간 위치 공유';

  @override
  String get chatLocationSent => '위치가 전송되었습니다';

  @override
  String get chatSelectMessages => '메시지 선택';

  @override
  String chatSelectedCount(int count) {
    return '$count개 선택됨';
  }

  @override
  String get chatSelectAll => '전체 선택';

  @override
  String chatGroupChatCount(int count) {
    return '그룹 채팅 ($count)';
  }

  @override
  String get chatPrivateChat => '개인 채팅';

  @override
  String get chatNoMessages => '메시지 없음';

  @override
  String get chatSendFirstMessage => '첫 메시지를 보내 채팅을 시작하세요';

  @override
  String get chatEncryptionNotice =>
      '이 채팅은 종단간 암호화되어 있습니다. 나와 상대방만 메시지를 읽을 수 있습니다.';

  @override
  String get chatMultiForward => '전달';

  @override
  String get chatCollect => '수집';

  @override
  String get chatNoMembers => '멤버 없음';

  @override
  String get chatMemberNotFound => '멤버를 찾을 수 없습니다';

  @override
  String get chatVoiceFileNotExist => '음성 파일이 존재하지 않습니다';

  @override
  String get chatVoiceFileEmpty => '음성 파일이 비어 있습니다';

  @override
  String get chatSendingVoice => '음성 전송 중...';

  @override
  String chatSendVoiceFailed(Object error) {
    return '음성 전송 실패: $error';
  }

  @override
  String get chatMessageForwarded => '메시지 전달됨';

  @override
  String chatForwardFailed(Object error) {
    return '전달 실패: $error';
  }

  @override
  String get chatUnfavorited => '즐겨찾기 해제됨';

  @override
  String get chatFavorited => '즐겨찾기 추가됨';

  @override
  String get chatReactionAdded => '반응 추가됨';

  @override
  String get chatReactionRemoved => '반응 제거됨';

  @override
  String get chatFailedMessageDeleted => '실패한 메시지 삭제됨';

  @override
  String get chatDeleteMessages => '메시지 삭제';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return '정말 $count개의 메시지를 삭제하시겠습니까?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return '참고: $count개의 메시지는 다른 사람의 것으로, 나에게만 삭제됩니다.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '내 $count개의 메시지가 모든 사람에게 취소됩니다.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return '$count개 취소됨, $localCount개 나에게만 삭제됨';
  }

  @override
  String chatRecalledMessages(Object count) {
    return '$count개 메시지 취소됨';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count개 메시지가 나에게만 삭제됨';
  }

  @override
  String chatForwardedCount(Object count) {
    return '$count개 메시지 전달됨';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return '전달 완료: $success개 성공, $failed개 실패';
  }

  @override
  String get chatRemindOnlyInGroup => '멘션 기능은 그룹 채팅에서만 사용할 수 있습니다';

  @override
  String get chatOnlyTextSearchable => '텍스트 메시지만 검색할 수 있습니다';

  @override
  String chatSearchFor(Object text) {
    return '\"$text\" 검색';
  }

  @override
  String get chatBaiduSearch => '바이두 검색';

  @override
  String get chatGoogleSearch => 'Google 검색';

  @override
  String get chatBingSearch => 'Bing 검색';

  @override
  String get chatCalling => '전화 중...';

  @override
  String get chatRinging => '벨소리 울리는 중...';

  @override
  String get chatInCall => '통화 중';

  @override
  String commonFeatureInDevelopment(String feature) {
    return '기능 개발 중...';
  }

  @override
  String chatCollectMessages(Object count) {
    return '$count개 메시지 수집됨';
  }

  @override
  String commonMemberCount(int count) {
    return '멤버 $count명';
  }

  @override
  String groupDone(int count) {
    return '완료($count)';
  }

  @override
  String get profileServices => '서비스';

  @override
  String get commonFavorites => '즐겨찾기';

  @override
  String get profileOrdersAndCards => '주문 및 카드';

  @override
  String get profileStickers => '스티커';

  @override
  String profileStatusSetTo(String status) {
    return '상태 설정됨: $status';
  }

  @override
  String get profileAvatarUploadFailed => '프로필 사진 업로드 실패';

  @override
  String get profilePersonalProfile => '개인 프로필';

  @override
  String get profileName => '이름';

  @override
  String get profileGender => '성별';

  @override
  String get profileRegion => '지역';

  @override
  String get commonMyQrCode => '내 QR 코드';

  @override
  String get profilePoke => '찌르기';

  @override
  String get profileRingtone => '벨소리';

  @override
  String get profileDefaultRingtone => '기본 벨소리';

  @override
  String get profileMyAddresses => '내 주소';

  @override
  String profileGenderSetTo(String gender) {
    return '성별 설정됨: $gender';
  }

  @override
  String get profileSelectRegion => '지역 선택';

  @override
  String get profileSelectCity => '도시 선택';

  @override
  String profileRegionSetTo(String region) {
    return '지역 설정됨: $region';
  }

  @override
  String get profileSetPoke => '찌르기 설정';

  @override
  String get profileFriendPokedMe => '친구가 나를 찔렀어요';

  @override
  String get profileExample => '예시';

  @override
  String get profileOnTheShoulder => ' 어깨를';

  @override
  String get profilePokeCleared => '찌르기가 지워졌습니다';

  @override
  String profilePokeSetTo(String suffix) {
    return '찌르기 설정됨: 나를 찔렀어요$suffix';
  }

  @override
  String get profileEditSignature => '상태 메시지 편집';

  @override
  String get profileIntroduceYourself => '자신을 소개하는 한 마디';

  @override
  String get profileSignatureCleared => '상태 메시지가 지워졌습니다';

  @override
  String get profileSignatureUpdated => '상태 메시지가 업데이트되었습니다';

  @override
  String get profileScanToAddFriend => '위의 QR 코드를 스캔하여 친구로 추가하세요';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return '벨소리 설정됨: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return '\"$name\"을(를) 해산하시겠습니까? 이 작업은 취소할 수 없습니다.';
  }

  @override
  String get authEnterValidServerAddress => '올바른 서버 주소를 입력해주세요';

  @override
  String get authEmailOtp => '이메일 OTP';

  @override
  String get authEnterServerAddressFirst => '먼저 서버 주소를 입력해주세요';

  @override
  String get authPasskeyRequiresServer => '패스키 로그인은 서버 지원이 필요합니다';

  @override
  String get authLoginAgreement => '로그인하면 다음에 동의하는 것으로 간주됩니다 ';

  @override
  String get authPleaseAgreeToTerms => '서비스 약관과 개인정보 처리방침을 읽고 동의해주세요';

  @override
  String get authRegisterFailed => '회원가입 실패';

  @override
  String get commonReenterPassword => '비밀번호 재입력';

  @override
  String get commonPasswordsDoNotMatch => '비밀번호가 일치하지 않습니다';

  @override
  String get authInviteCodeBuiltIn => '초대 코드 (내장)';

  @override
  String get authInviteCodeBuiltInNote => '초대 코드는 내장되어 있어 일반적으로 수정할 필요가 없습니다';

  @override
  String get authIHaveReadAndAgree => '읽고 동의합니다 ';

  @override
  String get mainStartGroupChat => '그룹 채팅 시작';

  @override
  String get mainAddFriends => '친구 추가';

  @override
  String get mainPaymentAndCollection => '결제';

  @override
  String contactCount(int count) {
    return '연락처 $count명';
  }

  @override
  String get contactAddToHomeScreen => '홈 화면에 추가';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return '$contact님의 카드를 $recipient님에게 추천했습니다';
  }

  @override
  String get contactEnterRemarkName => '별명 입력';

  @override
  String contactRemarkSetTo(String remark) {
    return '별명 설정됨: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return '$name님의 친구 요청을 수락했습니다';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return '$name님의 친구 요청을 거절했습니다';
  }

  @override
  String get commonGroupInvites => '그룹 초대';

  @override
  String commonMyGroups(int count) {
    return '내 그룹 ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => '그룹 참여 초대됨';

  @override
  String commonConfirmLeaveGroup(String name) {
    return '\"$name\"에서 나가시겠습니까?';
  }

  @override
  String get commonLeave => '나가기';

  @override
  String get commonRecallThisMessage => '이 메시지를 취소하시겠습니까?';

  @override
  String get commonSavedToGallery => '갤러리에 저장됨';

  @override
  String get commonFailedToSave => '저장 실패';

  @override
  String get chatSaving => '저장 중...';

  @override
  String get commonShare => '공유';

  @override
  String get chatSaveToGallery => '갤러리에 저장';

  @override
  String chatDownloadFailed(String code) {
    return '다운로드 실패: $code';
  }

  @override
  String commonShareFailed(String error) {
    return '공유 실패: $error';
  }

  @override
  String get chatFailedToLoadImage => '이미지 로드 실패';

  @override
  String get chatVideoRecordingFailed => '동영상 녹화 실패. 다시 시도해주세요.';

  @override
  String get profileRedPacket => '레드패킷';

  @override
  String get commonMusic => '음악';

  @override
  String get commonCoupon => '쿠폰';

  @override
  String get commonGift => '선물';

  @override
  String get commonPoll => '투표';

  @override
  String get favoriteText => '텍스트';

  @override
  String get favoriteLinkLabel => '링크';

  @override
  String get favoriteNote => '노트';

  @override
  String get favoriteMyNotes => '내 노트';

  @override
  String get favoriteToday => '오늘';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count일 전';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$month/$day';
  }

  @override
  String get favoriteNoFavorites => '즐겨찾기 없음';

  @override
  String get favoriteLongPressToFavorite => '메시지를 길게 눌러 즐겨찾기에 추가';

  @override
  String get favoriteNewNote => '새 노트';

  @override
  String get favoriteLink => '즐겨찾기 링크';

  @override
  String get favoriteEditTags => '태그 편집';

  @override
  String get favoriteDeleteFavorite => '즐겨찾기 삭제';

  @override
  String get favoriteDeleteFavoriteConfirm => '정말 이 즐겨찾기를 삭제하시겠습니까?';

  @override
  String get favoriteNoSearchResultsFound => '결과를 찾을 수 없습니다';

  @override
  String get commonSendRedPacket => '레드패킷 보내기';

  @override
  String get transferAmount => '금액';

  @override
  String get commonRedPacketCover => '레드패킷 커버';

  @override
  String get commonRedPacketType => '레드패킷 유형';

  @override
  String get commonNormalRedPacket => '일반';

  @override
  String get commonLuckyRedPacket => '행운';

  @override
  String get commonRedPacketCount => '레드패킷 개수';

  @override
  String get commonPieces => '개';

  @override
  String get commonPutMoneyInRedPacket => '레드패킷에 돈 넣기';

  @override
  String get commonRedPacketRefundNotice => '24시간 후 수령하지 않은 레드패킷은 환불됩니다';

  @override
  String get commonOpenRedPacket => '열기';

  @override
  String get commonRedPacketAllClaimed => '레드패킷 모두 수령됨';

  @override
  String get commonRedPacketExpired => '레드패킷 만료됨';

  @override
  String get commonAddTransferNote => '송금 메모 추가';

  @override
  String get commonYuan => '원';

  @override
  String get commonReplyWithEmoji => '이 이모티콘으로 답장';

  @override
  String get contactEditRemark => '별명 편집';

  @override
  String get contactSetPermissions => '권한 설정';

  @override
  String get profileAddToBlacklist => '차단 목록에 추가';

  @override
  String get contactDeleteContact => '연락처 삭제';

  @override
  String contactDeleteContactConfirm(String name) {
    return '정말 $name님을 삭제하시겠습니까?';
  }

  @override
  String get transferTitle => '송금';

  @override
  String get transferReceiverAddressLabel => '받는 주소';

  @override
  String get transferSelectTokenLabel => '토큰 선택';

  @override
  String get transferAmountLabel => '송금 금액';

  @override
  String get transferMemoLabel => '메모 (선택)';

  @override
  String get transferAddMemoHint => '메모 추가';

  @override
  String get transferSendPaymentRequest => '결제 요청 보내기';

  @override
  String get transferQrCodeGenerateFailed => 'QR 코드 생성 실패';

  @override
  String get transferScanQrToPayMe => 'QR 코드를 스캔하여 결제하세요';

  @override
  String get transferMyWalletAddress => '내 지갑 주소';

  @override
  String get transferCreatePaymentRequest => '결제 요청 생성';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => '행운을 빕니다';

  @override
  String commonSenderRedPacket(String name) {
    return '$name님의 레드패킷';
  }

  @override
  String get transferEnterValidAddress => '올바른 주소를 입력해주세요';

  @override
  String get transferPleaseSelectToken => '토큰을 선택해주세요';

  @override
  String get commonReceivedTransfer => '송금 받음';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name님이 레드패킷을 보냈습니다';
  }

  @override
  String get commonSavedToBalance => '잔액에 저장됨, 바로 송금 가능';

  @override
  String get commonRedPacketExpiredOrEmpty => '레드패킷 만료됨/모두 수령됨';

  @override
  String get transferScanFeatureComingSoon => '스캔 기능 곧 출시 예정...';

  @override
  String get contactSetAsStarred => '즐겨찾기로 설정';

  @override
  String get contactAddToBlocklist => '차단 목록에 추가';

  @override
  String get commonClaimedYour => ' 님이 당신의 ';

  @override
  String get commonClaimedText => ' 님이 수령함 ';

  @override
  String commonUserTyping(String name) {
    return '$name님이 입력 중...';
  }

  @override
  String get commonTyping => '입력 중...';

  @override
  String get commonWaitingToReceive => '받기 대기 중';

  @override
  String get commonTapToClaim => '탭하여 수령';

  @override
  String get commonHasBeenReceived => '수령됨';

  @override
  String get commonGetLucky => '행운을 잡으세요';

  @override
  String get qrcodeCameraStartFailed => '카메라 시작 실패';

  @override
  String get qrcodeUnknownError => '알 수 없는 오류';

  @override
  String get qrcodePlaceQrCodeInFrame => '프레임 안에 QR 코드를 배치하세요';

  @override
  String get qrcodeCloseManualInput => '수동 입력 닫기';

  @override
  String get qrcodeManualInputUserId => '사용자 ID 수동 입력';

  @override
  String get commonAdd => '추가';

  @override
  String get profileSetStatus => '상태 설정';

  @override
  String get profileVisibleToFriends24h => '친구에게 24시간 동안 표시됨';

  @override
  String get profileWriteStatus => '상태 작성';

  @override
  String get profileEnterYourStatus => '상태를 입력하세요...';

  @override
  String get profileOk => '확인';

  @override
  String get qrcodeCameraPermissionRequired => 'QR 코드 스캔을 위해 카메라 권한이 필요합니다';

  @override
  String get qrcodeCameraPermissionDenied =>
      '카메라 권한이 영구적으로 거부되었습니다. 시스템 설정에서 활성화해주세요.';

  @override
  String qrcodePermissionCheckError(String error) {
    return '권한 확인 오류: $error';
  }

  @override
  String get qrcodeInvalidQrCode => '잘못된 QR 코드';

  @override
  String qrcodeCannotAddFriend(String error) {
    return '친구 추가 불가: $error';
  }

  @override
  String get qrcodeScanQrCode => 'QR 코드 스캔';

  @override
  String get qrcodeCheckingCameraPermission => '카메라 권한 확인 중...';

  @override
  String get qrcodeNeedCameraPermission => '카메라 권한 필요';

  @override
  String get qrcodeRetryPermission => '다시 시도';

  @override
  String get qrcodeOpenSettings => '설정 열기';

  @override
  String get groupInviteMembers => '멤버 초대';

  @override
  String groupInviteCount(int count) {
    return '초대($count)';
  }

  @override
  String get profileNoShippingAddress => '배송 주소 없음';

  @override
  String get profileDefaultLabel => '기본';

  @override
  String get profileNoInvoice => '청구서 없음';

  @override
  String get profileCompany => '회사';

  @override
  String get profileTaxNumber => '사업자 등록번호';

  @override
  String get profileConfirmDeleteAddress => '정말 이 주소를 삭제하시겠습니까?';

  @override
  String get profileConfirmDeleteInvoice => '정말 이 청구서를 삭제하시겠습니까?';

  @override
  String get commonGroupOwner => '소유자';

  @override
  String get commonGroupAdmin => '관리자';

  @override
  String get groupSearchMembers => '멤버 검색';

  @override
  String groupTotalMembers(int count) {
    return '멤버 $count명';
  }

  @override
  String get chatRemoveFromGroup => '그룹에서 삭제';

  @override
  String groupConfirmRemoveMember(String name) {
    return '정말 \"$name\"님을 그룹에서 삭제하시겠습니까?';
  }

  @override
  String get chatUnknownSong => '알 수 없는 곡';

  @override
  String get chatUnknownArtist => '알 수 없는 아티스트';

  @override
  String get chatUnknownContact => '알 수 없는 연락처';

  @override
  String get chatPersonalCard => '연락처 카드';

  @override
  String get chatSingleChoice => '단일';

  @override
  String get chatMultiChoice => '복수';

  @override
  String get chatEnded => '종료됨';

  @override
  String get chatEndPollButton => '투표 종료';

  @override
  String get chatPollHint => '투표가 채팅에 표시됩니다. 그룹 멤버가 투표할 수 있습니다.';

  @override
  String get chatSearchSongOrArtist => '곡 또는 아티스트 검색';

  @override
  String get chatNoSongsFound => '곡을 찾을 수 없습니다';

  @override
  String get chatSongNameOptional => '곡 이름 (선택)';

  @override
  String get chatEnterSongName => '곡 이름 입력';

  @override
  String get chatArtistNameOptional => '아티스트 이름 (선택)';

  @override
  String get chatEnterArtistName => '아티스트 이름 입력';

  @override
  String get chatRealTimeLocationSharing => '실시간 위치 공유 개발 중...';

  @override
  String get profileVoiceCallFeatureInDev => '음성 통화 기능 개발 중...';

  @override
  String get profileReportFeatureInDev => '신고 기능 개발 중...';

  @override
  String get profileShareFeatureInDev => '공유 기능 개발 중...';

  @override
  String get profileQrCodeFeatureInDev => 'QR 코드 기능 개발 중...';

  @override
  String get qrcodeScanQrToAddMe => '위의 QR 코드를 스캔하여 친구로 추가하세요';

  @override
  String get qrcodeSaveToAlbum => '앨범에 저장';

  @override
  String get qrcodeChangeStyle => '스타일 변경';

  @override
  String get qrcodeCopyId => 'ID 복사';

  @override
  String get qrcodeIdCopied => 'ID 복사됨';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => '더 많은 스타일 곧 출시 예정';

  @override
  String get profileBio => '소개';

  @override
  String get profileHomeServer => '서버';

  @override
  String get profileShareContactCard => '연락처 카드 공유';

  @override
  String get profileRemoveFromBlacklist => '차단 목록에서 삭제';

  @override
  String get profileConfirmAddBlacklist =>
      '정말 이 사용자를 차단 목록에 추가하시겠습니까? 이 사용자로부터 메시지를 받지 않게 됩니다.';

  @override
  String get profileConfirmRemoveBlacklist => '정말 이 사용자를 차단 목록에서 삭제하시겠습니까?';

  @override
  String get profileRemarkSaved => '별명 저장됨';

  @override
  String get profileRemarkCleared => '별명 지워짐';

  @override
  String get transferReceive => '받기';

  @override
  String get transferPleaseConnectWallet => '먼저 지갑을 연결해주세요';

  @override
  String get transferSendRequest => '요청 보내기';

  @override
  String get transferPleaseEnterValidAmount => '올바른 금액을 입력해주세요';

  @override
  String get searchPlaceholder => '연락처, 그룹, 메시지 검색';

  @override
  String get searchEnterKeywordToSearch => '키워드를 입력하여 검색 시작';

  @override
  String get searchClearHistory => '지우기';

  @override
  String searchNoResultsForQuery(String query) {
    return '\"$query\"에 대한 결과 없음';
  }

  @override
  String get searchAllResults => '전체';

  @override
  String get searchInChat => '채팅에서 검색';

  @override
  String get searchContactLabel => '연락처';

  @override
  String get searchGroupLabel => '그룹';

  @override
  String get searchConversationLabel => '대화';

  @override
  String get searchMessageLabel => '메시지';

  @override
  String get settingsSecurityTitle => '보안';

  @override
  String get settingsKeyBackup => '키 백업';

  @override
  String get settingsBackupEncryptionKeys => '암호화 키 백업';

  @override
  String settingsKeysBackedUp(int count) {
    return '키 $count개 백업됨';
  }

  @override
  String get settingsBackupNotSet => '백업이 설정되지 않음';

  @override
  String get settingsRestoreKeys => '키 복원';

  @override
  String get settingsRestoreKeysFromBackup => '백업에서 암호화 키 복원';

  @override
  String get settingsExportKeys => '키 내보내기';

  @override
  String get settingsExportKeysToFile => '파일로 키 내보내기';

  @override
  String get settingsLoggedInDevices => '로그인된 기기';

  @override
  String get settingsNoOtherDevices => '다른 기기 없음';

  @override
  String get settingsVerified => '인증됨';

  @override
  String get settingsUnverified => '미인증';

  @override
  String get settingsAdvanced => '고급';

  @override
  String get settingsCrossSigning => '교차 서명';

  @override
  String get settingsEnabled => '활성화됨';

  @override
  String get settingsNotEnabled => '활성화되지 않음';

  @override
  String get settingsResetEncryption => '암호화 재설정';

  @override
  String get settingsDeleteAllEncryptionKeys => '모든 암호화 키 삭제';

  @override
  String get settingsEncryptionNotSupported => '암호화가 지원되지 않습니다';

  @override
  String get settingsNotInitialized => '초기화되지 않음';

  @override
  String get settingsBackupKeyTitle => '키 백업';

  @override
  String get settingsBackupKeyMessage =>
      '새 키 백업을 생성하시겠습니까? 새 기기에서 암호화된 메시지를 복원하는 데 도움이 됩니다.';

  @override
  String get settingsBackup => '백업';

  @override
  String get settingsRestoreKeyTitle => '키 복원';

  @override
  String get settingsRestoreKeyMessage =>
      '복구 비밀번호 또는 복구 키를 입력하여 암호화된 메시지를 복원하세요.';

  @override
  String get settingsRestore => '복원';

  @override
  String get settingsExportKeyTitle => '키 내보내기';

  @override
  String get settingsExportKeyMessage =>
      '내보낸 키 파일에는 모든 암호화 키가 포함됩니다. 안전하게 보관해주세요.';

  @override
  String get settingsExport => '내보내기';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return '기기 ID: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => '상태: 인증됨';

  @override
  String get settingsDeviceStatusUnverified => '상태: 미인증';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return '마지막 활동: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => '이 기기 인증';

  @override
  String get settingsCrossSigningAlreadyEnabled => '교차 서명이 이미 활성화되어 있습니다';

  @override
  String get settingsCrossSigningSetupSuccess => '교차 서명 설정 성공';

  @override
  String get settingsResetEncryptionTitle => '암호화 재설정';

  @override
  String get settingsResetEncryptionWarning =>
      '경고: 이 작업은 모든 암호화 키를 삭제합니다. 이전의 암호화된 메시지를 복호화할 수 없게 됩니다. 이 작업은 취소할 수 없습니다.';

  @override
  String get settingsReset => '재설정';

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
  String get callLeaveMeetingConfirm => '정말 회의를 나가시겠습니까?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return '$name님을 찔렀어요$suffix';
  }

  @override
  String get chatNoContactsToAdd => '추가할 연락처가 없습니다';

  @override
  String get chatAddMembers => '멤버 추가';

  @override
  String chatInvitedMembers(int count) {
    return '멤버 $count명 초대됨';
  }

  @override
  String chatInviteFailed(String error) {
    return '초대 실패: $error';
  }

  @override
  String get chatMemberRemoved => '멤버 삭제됨';

  @override
  String chatRemoveFailed(String error) {
    return '삭제 실패: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      '공유 후 상대방이 1시간 동안 당신의 실시간 위치를 볼 수 있습니다.';

  @override
  String get chatStartSharing => '공유 시작';

  @override
  String get chatLocationServiceNotEnabled => '위치 서비스가 활성화되지 않았습니다';

  @override
  String get chatEnableLocationService => '이 기능을 사용하려면 위치 서비스를 활성화해주세요';

  @override
  String get chatGoToSettings => '설정으로 이동';

  @override
  String get chatLocationPermissionRequired => '이 기능을 사용하려면 위치 권한이 필요합니다';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      '위치 권한이 영구적으로 거부되었습니다. 설정에서 활성화해주세요.';

  @override
  String get chatLocationPermissionDenied => '위치 권한 거부됨';

  @override
  String get chatGettingLocation => '위치 가져오는 중...';

  @override
  String chatGetLocationFailed(String error) {
    return '위치 가져오기 실패: $error';
  }

  @override
  String get chatMapPreview => '지도 미리보기';

  @override
  String get chatSearchLocation => '위치 검색';

  @override
  String chatRedPacketSent(String amount, String token) {
    return '$amount $token 레드패킷 전송됨';
  }

  @override
  String get chatTransferDefault => '송금';

  @override
  String chatTransferSent(String amount, String token) {
    return '$amount $token 송금 전송됨';
  }

  @override
  String chatPickFileFailed(String error) {
    return '파일 선택 실패: $error';
  }

  @override
  String get chatFileSizeLimit => '파일 크기는 50MB를 초과할 수 없습니다';

  @override
  String chatFileSending(String filename) {
    return '파일 전송 중: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return '파일 전송 실패: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return '$name님의 연락처 카드 전송됨';
  }

  @override
  String get chatFavoritesFeature => '즐겨찾기';

  @override
  String get chatCouponsFeature => '쿠폰';

  @override
  String get chatGiftFeature => '선물';

  @override
  String chatSharedMusic(String name) {
    return '$name 공유됨';
  }

  @override
  String get chatEndPollTitle => '투표 종료';

  @override
  String get chatEndPollConfirmMessage =>
      '정말 이 투표를 종료하시겠습니까? 종료 후에는 투표가 마감됩니다.';

  @override
  String get chatPollEndedMessage => '투표가 종료되었습니다';

  @override
  String get chatConnectingCall => '연결 중...';

  @override
  String get chatMuteCall => '음소거';

  @override
  String get chatSpeakerOff => '스피커 끄기';

  @override
  String get chatSpeakerOn => '스피커';

  @override
  String get chatCameraOn => '카메라 켜기';

  @override
  String get chatCameraOff => '카메라 끄기';

  @override
  String get chatHangUp => '끊기';

  @override
  String get chatSelectForwardTargetTitle => '전달 대상 선택';

  @override
  String get chatNoForwardableChat => '전달 가능한 채팅이 없습니다';

  @override
  String get chatNoMatchingChat => '일치하는 채팅을 찾을 수 없습니다';

  @override
  String get chatLocationTitle => '위치';

  @override
  String get chatSendButton => '전송';

  @override
  String get chatRetryButton => '다시 시도';

  @override
  String get chatSearchContactHint => '연락처 검색';

  @override
  String get chatShareMusic => '음악 공유';

  @override
  String get chatRecentPlayed => '최근';

  @override
  String get chatMyFavorites => '즐겨찾기';

  @override
  String get chatNetworkLink => '링크';

  @override
  String get chatLocalFile => '로컬';

  @override
  String get chatPasteMusicLink => '음악 링크 붙여넣기';

  @override
  String get chatShareMusicButton => '음악 공유';

  @override
  String get chatSelectLocalAudio => '로컬 오디오 파일 선택';

  @override
  String get chatSupportedAudioFormats => 'MP3, M4A, WAV, FLAC 등 지원';

  @override
  String get chatSelectFileButton => '파일 선택';

  @override
  String get chatPleaseEnterMusicLink => '음악 링크를 입력해주세요';

  @override
  String get chatPleaseEnterValidLink => '올바른 URL을 입력해주세요';

  @override
  String get chatSharedSong => '공유된 곡';

  @override
  String get chatSelectMember => '멤버 선택';

  @override
  String get chatSearchMemberHint => '멤버 검색';

  @override
  String get chatNoMatchingMembers => '일치하는 멤버를 찾을 수 없습니다';

  @override
  String get commonUnknownMember => '알 수 없음';

  @override
  String chatSelectedMessagesCount(int count) {
    return '$count개 메시지 선택됨';
  }

  @override
  String get chatSearchContactsOrGroups => '연락처 또는 그룹 검색';

  @override
  String get chatVideoTitle => '동영상';

  @override
  String get chatLoadingText => '로딩 중...';

  @override
  String get chatVideoLoadFailed => '동영상 로드 실패';

  @override
  String get chatPlayerInitFailed => '플레이어 초기화 실패';

  @override
  String get chatCreatePollTitle => '투표 만들기';

  @override
  String get chatSubmitPoll => '제출';

  @override
  String get chatPollQuestionLabel => '투표 질문';

  @override
  String get chatEnterPollQuestionHint => '투표 질문을 입력해주세요';

  @override
  String get chatPollOptionsLabel => '투표 옵션';

  @override
  String chatOptionHintWithIndex(int index) {
    return '옵션 $index';
  }

  @override
  String get chatAddOptionButton => '옵션 추가';

  @override
  String get chatPollSettingsLabel => '투표 설정';

  @override
  String get chatSelectionType => '선택 유형';

  @override
  String get chatSingleChoiceLabel => '단일';

  @override
  String get chatMultiChoiceLabel => '복수';

  @override
  String get chatAnonymousPollSwitch => '익명 투표';

  @override
  String get chatPleaseEnterQuestion => '투표 질문을 입력해주세요';

  @override
  String get chatAtLeastTwoOptions => '최소 2개의 옵션이 필요합니다';

  @override
  String chatConfirmWithCount(int count) {
    return '확인 ($count)';
  }

  @override
  String get authEmailVerificationTitle => '이메일 인증';

  @override
  String get authEnterValidEmailAddress => '올바른 이메일 주소를 입력해주세요';

  @override
  String authVerificationCodeSentTo(String email) {
    return '인증 코드가 $email로 전송되었습니다';
  }

  @override
  String authSendCodeFailed(String error) {
    return '코드 전송 실패: $error';
  }

  @override
  String get authVerificationSuccess => '인증 성공';

  @override
  String get authVerificationFailed => '인증 실패';

  @override
  String authVerificationCodeError(String error) {
    return '인증 코드 오류: $error';
  }

  @override
  String get commonEnterVerificationCode => '인증 코드 입력';

  @override
  String get authEnterYourEmail => '이메일 입력';

  @override
  String authWeSentCodeTo(String email) {
    return '6자리 코드를 보냈습니다\n$email';
  }

  @override
  String get authEnterEmailForCode => '이메일 주소를 입력하시면 인증 코드를 보내드립니다';

  @override
  String get commonSendVerificationCode => '인증 코드 보내기';

  @override
  String get authResendVerificationCode => '인증 코드 다시 보내기';

  @override
  String authCanResendAfter(int seconds) {
    return '$seconds초 후 다시 보낼 수 있습니다';
  }

  @override
  String get commonChangeEmail => '이메일 변경';

  @override
  String get contactAddToContacts => '연락처에 추가';

  @override
  String get contactAddingToContacts => '추가 중...';

  @override
  String get contactAddedToContacts => '연락처에 추가됨';

  @override
  String contactAddFailedWithError(String error) {
    return '추가 실패: $error';
  }

  @override
  String get contactAddPhone => '전화번호 추가';

  @override
  String get contactAddTag => '태그 추가';

  @override
  String get contactAddText => '텍스트 추가';

  @override
  String get contactAddPhoto => '사진 추가';

  @override
  String contactGroupCountLabel(int count) {
    return '그룹 $count개';
  }

  @override
  String get contactAddedViaSearch => '검색으로 추가됨';

  @override
  String get contactAddTime => '추가 시간';

  @override
  String get contactDoneButton => '완료';

  @override
  String get callWaitingForParticipants => '참가자 대기 중...';

  @override
  String callParticipantMe(String name) {
    return '$name (나)';
  }

  @override
  String get callSharingLabel => '공유 중';

  @override
  String callScreenSharingBy(String name) {
    return '$name님이 화면 공유 중';
  }

  @override
  String callParticipantCount(int count) {
    return '참가자 $count명';
  }

  @override
  String get callMuteLabel => '음소거';

  @override
  String get callUnmuteLabel => '음소거 해제';

  @override
  String get callTurnOffVideo => '영상 끄기';

  @override
  String get callTurnOnVideo => '영상 켜기';

  @override
  String get callShareScreen => '화면 공유';

  @override
  String get callStopSharing => '공유 중지';

  @override
  String get callSwitchCameraLabel => '전환';

  @override
  String get callLeaveLabel => '나가기';

  @override
  String get callParticipantsLabel => '참가자';

  @override
  String get callJoiningMeeting => '회의 참여 중...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count표 ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count명 참여';
  }

  @override
  String get commonTapToRetry => '탭하여 다시 시도';

  @override
  String get chatDefaultRedPacketGreeting => '부자 되세요, 행운을 빕니다';

  @override
  String get groupAllowOthersToSearchAndJoin => '다른 사용자가 검색하고 참여하도록 허용';

  @override
  String get groupConfirmClearChatHistory => '채팅 기록을 정말 삭제하시겠습니까?';

  @override
  String get groupCreateGroupToChat => '그룹을 만들어 채팅을 시작하세요';

  @override
  String get groupEditGroupAnnouncement => '그룹 공지 수정';

  @override
  String get groupEditGroupDescription => '그룹 설명 수정';

  @override
  String get groupEnterGroupAnnouncement => '그룹 공지를 입력하세요';

  @override
  String chatErrorWithMessage(String message) {
    return '오류: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count명, 클릭하여 그룹 ID 복사';
  }

  @override
  String get chatMusicLinkLabel => '음악 링크';

  @override
  String get chatNoMediaUrlAvailable => '미디어 URL을 사용할 수 없습니다';

  @override
  String get groupNoPermissionToEditGroupName => '그룹 이름을 수정할 권한이 없습니다';

  @override
  String get chatRedPacketTransferCannotForward => '홍바오와 송금은 전달할 수 없습니다';

  @override
  String get authEmailAddress => '이메일 주소';

  @override
  String get commonEnterEmailAddress => '이메일 주소 입력';

  @override
  String get authEmailRecoveryHint => '비밀번호 복구에 사용됩니다';

  @override
  String get commonInvalidEmailFormat => '유효한 이메일 주소를 입력하세요';

  @override
  String get authOptional => '선택 사항';

  @override
  String get authResetPassword => '비밀번호 재설정';

  @override
  String get authEnterRegisteredEmail => '등록한 이메일 주소를 입력하세요';

  @override
  String get authSendResetCode => '재설정 코드 전송';

  @override
  String authResetCodeSent(String email) {
    return '재설정 코드가 $email로 전송되었습니다';
  }

  @override
  String get authEnterResetCode => '재설정 코드 입력';

  @override
  String get authSetNewPassword => '새 비밀번호 설정';

  @override
  String get commonConfirmNewPassword => '새 비밀번호 확인';

  @override
  String get commonNewPassword => '새 비밀번호';

  @override
  String get authPasswordResetSuccess =>
      '비밀번호가 성공적으로 재설정되었습니다. 새 비밀번호로 로그인하세요.';

  @override
  String get authResetPasswordFailed => '비밀번호 재설정 실패';

  @override
  String get settingsChangePassword => '비밀번호 변경';

  @override
  String get settingsCurrentPassword => '현재 비밀번호';

  @override
  String get settingsEnterCurrentPassword => '현재 비밀번호 입력';

  @override
  String get settingsEnterNewPassword => '새 비밀번호 입력';

  @override
  String get settingsPasswordChanged => '비밀번호가 성공적으로 변경되었습니다. 새 비밀번호로 로그인하세요.';

  @override
  String get settingsChangePasswordFailed => '비밀번호 변경 실패';

  @override
  String get settingsNewPasswordMustBeDifferent => '새 비밀번호는 현재 비밀번호와 달라야 합니다';

  @override
  String get settingsChangePasswordInfo =>
      '비밀번호를 변경하면 로그아웃되며 새 비밀번호로 로그인해야 합니다.';

  @override
  String get settingsPasswordRequirements => '비밀번호 요구 사항:';

  @override
  String get settingsSecurityNote => '보안을 위해 비밀번호 변경 후 모든 기기에서 다시 로그인해야 합니다.';

  @override
  String get settingsSecurity => '보안';

  @override
  String get settingsCurrentBoundEmail => '현재 연결된 이메일';

  @override
  String get settingsNewEmailAddress => '새 이메일 주소';

  @override
  String get settingsEnterNewEmail => '새 이메일 주소 입력';

  @override
  String get settingsVerificationCode => '인증 코드';

  @override
  String get settingsVerificationCodeSent => '인증 코드가 전송되었습니다';

  @override
  String get settingsCodeSentTo => '인증 코드 전송됨';

  @override
  String get settingsDidNotReceiveCode => '코드를 받지 못하셨나요?';

  @override
  String get settingsEmailChangedSuccess => '이메일이 성공적으로 변경되었습니다';

  @override
  String get settingsChangeEmailFailed => '이메일 변경 실패';

  @override
  String get settingsEmailSecurityNote => '이메일은 비밀번호 복구에 사용됩니다. 안전하게 보관하세요.';

  @override
  String get commonGoogleLogin => 'Google로 로그인';

  @override
  String get commonAppleLogin => 'Apple로 로그인';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => '언어';

  @override
  String get settingsLanguageChanged => '언어가 변경되었습니다';

  @override
  String get settingsBiometricLogin => '생체 인식 로그인';

  @override
  String authLoginWithBiometric(Object type) {
    return '$type으로 로그인';
  }

  @override
  String get settingsBiometricLoginEnabled => '생체 인식 로그인이 활성화되었습니다';

  @override
  String get settingsBiometricLoginDisabled => '생체 인식 로그인이 비활성화되었습니다';

  @override
  String get settingsEnableBiometricLogin => '생체 인식 로그인 활성화';

  @override
  String get settingsBiometricEnabled => '활성화됨 - 생체 인식으로 로그인';

  @override
  String get settingsBiometricDisabled => '비활성화됨 - 탭하여 활성화';

  @override
  String get settingsBiometricNeedRelogin =>
      '생체 인식 로그인을 활성화하려면 로그아웃 후 다시 로그인하세요';

  @override
  String get authOr => '또는';

  @override
  String get qrcodeCameraPermissionRestricted => '이 기기에서 카메라 접근이 제한되어 있습니다';

  @override
  String get authPasskeyLabel => '패스키';

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
  String get profileEnterPokeSuffixHint => '쿡 찌르기 접미사를 입력하세요, 예: 어깨를';

  @override
  String get groupAlbum => '그룹 앨범';

  @override
  String get groupFiles => '그룹 파일';

  @override
  String get groupImages => '이미지';

  @override
  String get groupVideos => '동영상';

  @override
  String get groupTotal => '전체';

  @override
  String get groupSize => '크기';

  @override
  String get groupNoMedia => '미디어 없음';

  @override
  String get groupNoMediaDescription => '이 그룹에 아직 사진이나 동영상이 없습니다';

  @override
  String get groupDocuments => '문서';

  @override
  String get groupNoFiles => '파일 없음';

  @override
  String get groupNoFilesDescription => '이 그룹에 아직 파일이 없습니다';

  @override
  String groupDownloadStarted(String filename) {
    return '$filename 다운로드 중...';
  }

  @override
  String get contactNoCommonGroups => '공통 그룹 없음';

  @override
  String get contactNoCommonGroupsDescription => '공통으로 가입한 그룹이 없습니다';

  @override
  String get chatVoiceMessage => '음성';

  @override
  String get chatMessage => '메시지';

  @override
  String get conversationHideChat => '숨기기';

  @override
  String get settingsQuickReply => '빠른 답장';

  @override
  String get commonTranslate => '번역';

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
    return '대화: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return '연락처: $userId';
  }

  @override
  String get commonDiscover => '발견';

  @override
  String commonDeveloping(String title) {
    return '$title\n(곧 출시 예정)';
  }

  @override
  String get commonPageNotFound => '페이지를 찾을 수 없습니다';

  @override
  String get commonBackToHome => '홈으로 돌아가기';

  @override
  String get settingsMessageNotifications => '메시지 알림';

  @override
  String get settingsReceiveNewMessageNotifications => '새 메시지 알림 받기';

  @override
  String get settingsShowMessagePreview => '메시지 미리보기 표시';

  @override
  String get settingsShowMessageContentInNotification => '알림에 메시지 내용 표시';

  @override
  String get settingsNotificationSound => '알림 소리';

  @override
  String get settingsPlaySoundOnMessage => '메시지 수신 시 소리 재생';

  @override
  String get commonVibration => '진동';

  @override
  String get settingsVibrateOnMessage => '메시지 수신 시 진동';

  @override
  String get settingsDoNotDisturbMode => '방해 금지';

  @override
  String get settingsDoNotDisturbDescription => '지정된 시간 동안 알림을 받지 않습니다';

  @override
  String get settingsStartTime => '시작 시간';

  @override
  String get settingsEndTime => '종료 시간';

  @override
  String get settingsDeleteQuickReply => '빠른 답장 삭제';

  @override
  String get settingsEditQuickReply => '빠른 답장 편집';

  @override
  String get settingsAddQuickReply => '빠른 답장 추가';

  @override
  String get settingsManageQuickReplies => '빠른 답장 관리';

  @override
  String get settingsNoQuickReplies => '빠른 답장 없음';

  @override
  String get settingsDefaultQuickReplies => '기본 빠른 답장이 표시됩니다';

  @override
  String get settingsWhoCanSee => '볼 수 있는 사람';

  @override
  String get settingsLastSeen => '마지막 접속';

  @override
  String get settingsHiddenChats => '숨겨진 채팅';

  @override
  String get settingsMessagesLabel => '메시지';

  @override
  String get settingsAllowStrangerMessages => '모르는 사람의 메시지 허용';

  @override
  String get settingsReceiveMessagesFromNonContacts => '연락처에 없는 사람의 메시지 받기';

  @override
  String get settingsReadReceipts => '읽음 확인';

  @override
  String get settingsLetOthersKnowYouRead => '읽음 확인 보내기';

  @override
  String get settingsTypingIndicator => '입력 중 표시';

  @override
  String get settingsLetOthersKnowYouTyping => '입력 중임을 상대방에게 알리기';

  @override
  String get settingsEveryone => '모든 사람';

  @override
  String get settingsContactsOnly => '연락처만';

  @override
  String get settingsNobody => '아무도';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return '$title을(를) 볼 수 있는 사람';
  }

  @override
  String settingsVersionInfo(String version) {
    return '버전 $version';
  }

  @override
  String get settingsCheckForUpdates => '업데이트 확인';

  @override
  String get settingsOpenSourceLicenses => '오픈소스 라이선스';

  @override
  String get settingsFeedbackAndSuggestions => '피드백 및 제안';

  @override
  String get settingsBuiltOnMatrix => 'Matrix 프로토콜 기반';

  @override
  String get settingsNoHiddenChats => '숨겨진 채팅 없음';

  @override
  String get settingsNoHiddenChatsDescription => '숨긴 채팅이 여기에 표시됩니다';

  @override
  String get settingsUnhideChat => '숨기기 해제';

  @override
  String get settingsDarkMode => '다크 모드';

  @override
  String get settingsFontSize => '글꼴 크기';

  @override
  String get settingsBubbleStyle => '말풍선 스타일';

  @override
  String get settingsFollowSystem => '시스템 설정 따르기';

  @override
  String get settingsAutoSwitchBySystem => '시스템 설정에 따라 자동 전환';

  @override
  String get settingsLightMode => '라이트 모드';

  @override
  String get settingsAlwaysUseLightTheme => '항상 밝은 테마 사용';

  @override
  String get settingsDarkModeOption => '다크 모드';

  @override
  String get settingsAlwaysUseDarkTheme => '항상 어두운 테마 사용';

  @override
  String get settingsFontSizeSmall => '작게';

  @override
  String get settingsFontSizeStandard => '표준';

  @override
  String get settingsFontSizeLarge => '크게';

  @override
  String get settingsFontSizeExtraLarge => '매우 크게';

  @override
  String get settingsBubbleStyleWechat => 'WeChat 스타일';

  @override
  String get settingsBubbleStyleWechatDesc => '클래식 WeChat 말풍선 스타일';

  @override
  String get settingsBubbleStyleModern => '모던 스타일';

  @override
  String get settingsBubbleStyleModernDesc => '깔끔한 모던 말풍선 스타일';

  @override
  String get settingsBubbleStyleClassic => '클래식 스타일';

  @override
  String get settingsBubbleStyleClassicDesc => '전통적인 말풍선 스타일';

  @override
  String get discoverVideoChannels => '채널';

  @override
  String get discoverLive => '라이브';

  @override
  String get discoverListen => '듣기';

  @override
  String get discoverWatch => '보기';

  @override
  String get discoverSearchDiscover => '검색';

  @override
  String get discoverNearbyPeople => '주변';

  @override
  String get discoverGames => '게임';

  @override
  String get discoverMiniPrograms => '미니 프로그램';

  @override
  String get chatAlreadyInCall => '이미 통화 중입니다';

  @override
  String get commonConnectionFailed => '연결 실패';

  @override
  String get chatCallRejected => '통화 거절됨';

  @override
  String get chatNoAnswer => '응답 없음';

  @override
  String get commonClose => '닫기';

  @override
  String get chatSelectContact => '연락처 선택';

  @override
  String get chatVoteRemoved => '투표 취소됨';

  @override
  String get chatVoteChanged => '투표 변경됨';

  @override
  String get chatVoted => '투표함';

  @override
  String chatReplyTo(String name) {
    return '$name님에게 답장';
  }

  @override
  String get chatCurrentLocation => '현재 위치';

  @override
  String chatNearbyPlace(int index) {
    return '주변 장소 $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return '약 $distance';
  }

  @override
  String get chatAddress => '주소';

  @override
  String get chatLatitude => '위도';

  @override
  String get chatLongitude => '경도';

  @override
  String get groupDescriptionUpdated => '그룹 설명이 업데이트되었습니다';

  @override
  String get groupAvatarUpdated => '그룹 아바타가 업데이트되었습니다';

  @override
  String get callDecline => '거절';

  @override
  String get callAnswer => '응답';

  @override
  String get callIncomingVideoCall => '영상 통화 수신';

  @override
  String get callIncomingVoiceCall => '음성 통화 수신';

  @override
  String get callVideoCallInProgress => '영상 통화 중';

  @override
  String get callVoiceCallInProgress => '음성 통화 중';

  @override
  String get callReconnectingCall => '재연결 중...';

  @override
  String get callEnded => '통화 종료';

  @override
  String get callFailed => '통화 실패';

  @override
  String get callLivekitNotConfigured => 'LiveKit이 구성되지 않았습니다';

  @override
  String callJoinMeetingFailed(String error) {
    return '회의 참여 실패: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return '화면 공유 실패: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 빈';

  @override
  String get profileNoN42Bean => 'N42 빈 없음';

  @override
  String get profileN42BeanDetails => 'N42 빈 상세';

  @override
  String get profileN42BeanDescription =>
      'N42 빈은 N42 내 가상 아이템과 서비스를 교환하기 위한 토큰입니다. 현재 이용 가능:';

  @override
  String get profileN42BeanFeature1 => '회원 전용 스티커 및 테마';

  @override
  String get profileN42BeanFeature2 => '채팅 말풍선 커스터마이징';

  @override
  String get profileN42BeanFeature3 => '세뱃돈 봉투 커버 커스터마이징';

  @override
  String get profileN42BeanFeature4 => '전용 닉네임 뱃지';

  @override
  String get profileN42BeanFeature5 => '그룹 채팅 특권';

  @override
  String get profileN42BeanFeature6 => '클라우드 저장소 확장';

  @override
  String get profileN42BeanFeature7 => '영상통화 뷰티 필터';

  @override
  String get profileN42BeanFeature8 => '모먼트 배경 커스터마이징';

  @override
  String get profileN42BeanFeature9 => 'VIP 고객 서비스 우선권';

  @override
  String get profileGotIt => '알겠습니다';

  @override
  String get profileNoN42BeanRecords => 'N42 빈 기록 없음';

  @override
  String get profileMoodAndThoughts => '기분 및 생각';

  @override
  String get profileStatusHappy => '행복해요';

  @override
  String get profileStatusCracked => '무너졌어요';

  @override
  String get profileStatusLucky => '운이 좋아요';

  @override
  String get profileStatusSunny => '화창해요';

  @override
  String get profileStatusTired => '피곤해요';

  @override
  String get profileStatusDaydream => '몽상 중';

  @override
  String get profileStatusRushing => '바쁜 중';

  @override
  String get profileStatusOverthinking => '생각이 많아요';

  @override
  String get profileStatusEnergized => '활력 넘쳐요';

  @override
  String get profileWorkAndStudy => '일 및 공부';

  @override
  String get profileStatusWorking => '일하는 중';

  @override
  String get profileStatusStudying => '공부하는 중';

  @override
  String get profileStatusBusy => '바쁨';

  @override
  String get profileStatusSlacking => '쉬는 중';

  @override
  String get profileStatusTraveling => '여행 중';

  @override
  String get profileStatusGoingHome => '집에 가는 중';

  @override
  String get profileStatusDnd => '방해 금지';

  @override
  String get profileActivities => '활동';

  @override
  String get profileStatusHanging => '놀고 있어요';

  @override
  String get profileStatusCheckIn => '체크인';

  @override
  String get profileStatusExercising => '운동 중';

  @override
  String get profileStatusCoffee => '커피';

  @override
  String get profileStatusBubbleTea => '버블티';

  @override
  String get profileStatusEating => '식사 중';

  @override
  String get profileStatusParenting => '육아 중';

  @override
  String get profileStatusSavingWorld => '세상 구하는 중';

  @override
  String get profileStatusSelfie => '셀카';

  @override
  String get profileRest => '휴식';

  @override
  String get profileStatusRetreat => '피정 중';

  @override
  String get profileStatusHome => '집';

  @override
  String get profileStatusSleeping => '자는 중';

  @override
  String get profileStatusCatLover => '고양이 좋아요';

  @override
  String get profileStatusDogWalking => '산책 중';

  @override
  String get profileStatusGaming => '게임 중';

  @override
  String get profileStatusListening => '듣는 중';

  @override
  String get profileEditAddress => '주소 편집';

  @override
  String get profileRecipient => '수령인';

  @override
  String get profileEnterRecipientName => '수령인 이름 입력';

  @override
  String get profilePhoneNumber => '전화번호';

  @override
  String get profileEnterPhoneNumber => '전화번호 입력';

  @override
  String get profileRegionHint => '시/도/구';

  @override
  String get profileDetailedAddress => '상세 주소';

  @override
  String get profileDetailedAddressHint => '도로명, 건물 번호 등';

  @override
  String get profileSetAsDefaultAddress => '기본 주소로 설정';

  @override
  String get profilePleaseCompleteInfo => '모든 항목을 입력해주세요';

  @override
  String get profileEditInvoice => '청구서 편집';

  @override
  String get profileInvoiceType => '청구서 유형: ';

  @override
  String get profileCompanyName => '회사명';

  @override
  String get profilePersonalName => '개인 이름';

  @override
  String get profileEnterCompanyName => '회사명 입력';

  @override
  String get profileEnterName => '이름 입력';

  @override
  String get profileTaxIdNumber => '사업자 등록번호';

  @override
  String get profileEnterTaxIdNumber => '사업자 등록번호 입력';

  @override
  String get profileBankNameOptional => '은행명 (선택)';

  @override
  String get profileEnterBankName => '은행명 입력';

  @override
  String get profileBankAccountOptional => '계좌번호 (선택)';

  @override
  String get profileEnterBankAccount => '계좌번호 입력';

  @override
  String get profileCompanyAddressOptional => '회사 주소 (선택)';

  @override
  String get profileEnterCompanyAddress => '회사 주소 입력';

  @override
  String get profileCompanyPhoneOptional => '회사 전화번호 (선택)';

  @override
  String get profileEnterCompanyPhone => '회사 전화번호 입력';

  @override
  String get profileSetAsDefaultInvoice => '기본 청구서로 설정';

  @override
  String get profileRingtoneVibrate => '진동';

  @override
  String get profileRingtoneSilent => '무음';

  @override
  String get profileVibrateMode => '진동 모드';

  @override
  String get profileSilentMode => '무음 모드';

  @override
  String profilePlayFailed(String ringtoneName) {
    return '재생 실패: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return '재생 중: $ringtoneName';
  }

  @override
  String get profileStop => '중지';

  @override
  String get profileSelectRingtone => '벨소리 선택';

  @override
  String get profileLoadingRingtones => '벨소리 로딩 중...';

  @override
  String get profileNoRingtonesFound => '벨소리를 찾을 수 없습니다';

  @override
  String mainMessagesWithCount(int count) {
    return '메시지($count)';
  }

  @override
  String get storyViewers => '조회자';

  @override
  String get storyNoViewers => '아직 조회자 없음';

  @override
  String get storyReplyToStory => '스토리에 답장...';

  @override
  String get commonCopiedToClipboard => '클립보드에 복사됨';

  @override
  String get commonMore => '더보기';

  @override
  String get commonTranslating => '번역 중...';

  @override
  String commonTranslatedFrom(String language) {
    return '$language에서 번역됨';
  }

  @override
  String get commonTranslation => '번역';

  @override
  String get commonTranslationFailed => '번역 실패';

  @override
  String get commonAllRead => '모두 읽음';

  @override
  String commonReadCount(int count) {
    return '$count명 읽음';
  }

  @override
  String get commonYouRecalledMessage => '메시지를 취소했습니다';

  @override
  String get commonMessageRecalled => '메시지가 취소되었습니다';

  @override
  String get commonReEdit => '다시 편집';

  @override
  String get commonWalletArea => '지갑 영역';

  @override
  String get callIncomingCall => '수신 전화';

  @override
  String get callMissedCall => '부재중 전화';

  @override
  String get groupRemoveAdmin => '관리자 삭제';

  @override
  String get chatSelectCurrency => '통화 선택';

  @override
  String get chatSelectEmoji => '이모티콘 선택';

  @override
  String get chatSelectRedPacketCover => '커버 선택';

  @override
  String get groupSetAsAdmin => '관리자로 설정';

  @override
  String get chatVideoPlaybackFailed => '동영상 재생 실패';

  @override
  String get groupViewProfile => '프로필 보기';

  @override
  String get favoriteAddLinkComingSoon => '링크 추가 기능 곧 출시 예정';

  @override
  String get favoriteNewNoteComingSoon => '새 노트 기능 곧 출시 예정';

  @override
  String get qrcodeSaveFeatureComingSoon => '저장 기능 곧 출시 예정';

  @override
  String get qrcodeShareFeatureComingSoon => '공유 기능 곧 출시 예정';

  @override
  String qrcodeProcessFailed(String error) {
    return 'QR 코드 처리 실패: $error';
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

  @override
  String get gameCenter => '게임';

  @override
  String get gameHighScore => '최고';

  @override
  String get gameScore => '점수';

  @override
  String get gameOver => '게임 오버';

  @override
  String get gamePlayAgain => '다시 하기';

  @override
  String get gameLeaderboard => '순위표';

  @override
  String get gamePause => '일시정지';

  @override
  String get gameResume => '탭하여 재개';

  @override
  String get gameConfirmExit => '게임을 종료하시겠습니까?';

  @override
  String get gameNoScores => '기록 없음';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => '타일을 합쳐 2048을 만드세요';

  @override
  String get gameBlockDrop => '블록 드롭';

  @override
  String get gameBlockDropDesc => '블록을 떨어뜨려 줄을 지우세요';

  @override
  String get gameMinesweeper => '지뢰찾기';

  @override
  String get gameMinesweeperDesc => '안전한 칸을 모두 찾으세요';

  @override
  String get gameMatch3 => '매치 3';

  @override
  String get gameMatch3Desc => '보석 3개 이상을 연결하세요';

  @override
  String get gameMinesweeperEasy => '쉬움';

  @override
  String get gameMinesweeperMedium => '보통';

  @override
  String get gameMinesLeft => '남은 지뢰';

  @override
  String get gameTimeLeft => '시간';

  @override
  String get gameLevel => '레벨';

  @override
  String get gameNext => '다음';

  @override
  String get gameBestTime => '최고 기록';

  @override
  String get gameNewRecord => '신기록!';

  @override
  String get gameLines => '라인';
}
