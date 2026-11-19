// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class STe extends S {
  STe([String locale = 'te']) : super(locale);

  @override
  String get commonRetry => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get commonUnknownUser => 'తెలియని వినియోగదారు';

  @override
  String get transferWalletNotConnected => 'వాలెట్ కనెక్ట్ కాలేదు';

  @override
  String get chatCallServiceNotInitialized => 'కాల్ సేవ ప్రారంభించబడలేదు';

  @override
  String authLoginFailed(Object error) {
    return 'లాగిన్ విఫలమైంది: $error';
  }

  @override
  String get chatCallBack => 'తిరిగి కాల్ చేయండి';

  @override
  String get chatMissedVideoCall => 'మిస్డ్ వీడియో కాల్';

  @override
  String get chatMissedVoiceCall => 'మిస్డ్ వాయిస్ కాల్';

  @override
  String get chatCallNotAnswered => 'సమాధానం చెప్పలేదు';

  @override
  String get chatCallDurationLabel => 'కాల్ వ్యవధి';

  @override
  String get chatVoiceCallCancelled => 'వాయిస్ కాల్ రద్దు చేయబడింది';

  @override
  String get chatVideoCallCancelled => 'వీడియో కాల్ రద్దు చేయబడింది';

  @override
  String get commonImage => '[చిత్రం]';

  @override
  String get chatVideo => '[వీడియో]';

  @override
  String get chatVoice => '[వాయిస్]';

  @override
  String get commonFile => '[ఫైల్]';

  @override
  String get chatLocation => '[స్థానం]';

  @override
  String get chatUnknownMessage => '[తెలియని సందేశం]';

  @override
  String get commonDelete => 'తొలగించు';

  @override
  String get chatDeleteThisMessage => 'ఈ సందేశాన్ని తొలగించాలా?';

  @override
  String get chatMessageDeleted => 'సందేశం తొలగించబడింది';

  @override
  String get profileNotLoggedIn => 'లాగిన్ కాలేదు';

  @override
  String get chatMyLocation => 'నా స్థానం';

  @override
  String get commonGroupChat => 'గ్రూప్ చాట్';

  @override
  String get commonSearch => 'శోధించండి';

  @override
  String get commonCancel => 'రద్దు చేయి';

  @override
  String get commonLoadFailed => 'లోడ్ చేయడంలో విఫలమైంది';

  @override
  String get commonMessages => 'సందేశాలు';

  @override
  String get commonContacts => 'పరిచయాలు';

  @override
  String get commonMe => 'నేను';

  @override
  String get commonVoiceLoading =>
      'వాయిస్ లోడ్ అవుతోంది, దయచేసి తర్వాత మళ్లీ ప్రయత్నించండి';

  @override
  String get commonVoiceToTextFailed => 'వాయిస్ టు టెక్స్ట్ విఫలమైంది';

  @override
  String get commonConvertToText => 'వచనానికి';

  @override
  String get chatCopy => 'కాపీ చేయండి';

  @override
  String get commonForward => 'ముందుకు';

  @override
  String get commonUnfavorite => 'అన్‌ఫేవ్';

  @override
  String get commonFavorite => 'ఇష్టమైనది';

  @override
  String get settingsResend => 'మళ్లీ పంపండి';

  @override
  String get chatRecall => 'గుర్తుచేసుకోండి';

  @override
  String get commonQuote => 'కోట్';

  @override
  String get commonRemind => 'గుర్తు చేయండి';

  @override
  String get chatCopied => 'కాపీ చేయబడింది';

  @override
  String get storySendMessageHint => 'సందేశం పంపండి';

  @override
  String get commonMicrophonePermissionRequired =>
      'దయచేసి మైక్రోఫోన్ అనుమతిని అనుమతించండి';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      'మైక్రోఫోన్ అనుమతి నిరాకరించబడింది. వాయిస్ సందేశాలను ఉపయోగించడానికి దయచేసి సిస్టమ్ సెట్టింగ్‌లలో దీన్ని ప్రారంభించండి.';

  @override
  String commonStartRecordingFailed(Object error) {
    return 'రికార్డింగ్ ప్రారంభించడంలో విఫలమైంది: $error';
  }

  @override
  String get commonRecordingTooShort => 'రికార్డింగ్ చాలా చిన్నది';

  @override
  String commonStopRecordingFailed(Object error) {
    return 'రికార్డింగ్‌ని ఆపడంలో విఫలమైంది: $error';
  }

  @override
  String get chatReleaseToCancel => 'రద్దు చేయడానికి విడుదల';

  @override
  String get chatReleaseToSend =>
      'పంపడానికి విడుదల చేయండి, రద్దు చేయడానికి పైకి స్వైప్ చేయండి';

  @override
  String get commonHoldToTalk => 'మాట్లాడటానికి పట్టుకోండి';

  @override
  String get commonSend => 'పంపండి';

  @override
  String get commonAddFriend => 'స్నేహితుడిని జోడించండి';

  @override
  String get commonChatServiceNotConnected => 'చాట్ సర్వీస్ కనెక్ట్ కాలేదు';

  @override
  String contactUserNotFoundHint(String query) {
    return 'వినియోగదారు \"$query\" కనుగొనబడలేదు\n\nచిట్కాలు:\n• పూర్తి వినియోగదారు IDని నమోదు చేయడానికి ప్రయత్నించండి, ఉదా. @username:server.com\n• వినియోగదారు పేరు స్పెల్లింగ్‌ను తనిఖీ చేయండి';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'చాట్‌ని సృష్టించడం విఫలమైంది: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'శోధన విఫలమైంది: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'శోధించడానికి వినియోగదారు ID లేదా వినియోగదారు పేరును నమోదు చేయండి';

  @override
  String get contactSearching => 'శోధిస్తోంది...';

  @override
  String get contactSearchUserToChat =>
      'చాటింగ్ ప్రారంభించడానికి వినియోగదారుని శోధించండి';

  @override
  String get contactMatrixIdExample =>
      'మీరు పూర్తి మ్యాట్రిక్స్ IDని నమోదు చేయవచ్చు\nఉదా @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'వినియోగదారు \"$username\" కనుగొనబడలేదు';
  }

  @override
  String get commonChat => 'చాట్ చేయండి';

  @override
  String get commonSettings => 'సెట్టింగ్‌లు';

  @override
  String get profileEditProfile => 'ప్రొఫైల్‌ని సవరించండి';

  @override
  String get authLogin => 'లాగిన్ చేయండి';

  @override
  String get commonCreateGroup => 'సమూహాన్ని సృష్టించండి';

  @override
  String get chatError => 'లోపం';

  @override
  String get commonTransfer => 'బదిలీ చేయండి';

  @override
  String get commonReceived => 'అందుకుంది';

  @override
  String get commonRefunded => 'వాపసు ఇచ్చారు';

  @override
  String get commonExpired => 'గడువు ముగిసింది';

  @override
  String get chatRedPacketGreeting => 'శుభాకాంక్షలు';

  @override
  String get commonN42RedPacket => 'N42 రెడ్ ప్యాకెట్';

  @override
  String get commonClaimed => 'దావా వేసింది';

  @override
  String get commonAllClaimed => 'అన్నీ క్లెయిమ్ చేశాయి';

  @override
  String get chatReadAloud => 'బిగ్గరగా చదవండి';

  @override
  String get chatReply => 'ప్రత్యుత్తరం ఇవ్వండి';

  @override
  String get commonEdit => 'సవరించు';

  @override
  String get chatSelectForwardTarget => 'ఫార్వర్డ్ టార్గెట్ ఎంచుకోండి';

  @override
  String commonSendCount(int count) {
    return 'పంపు($count)';
  }

  @override
  String contactN42Id(Object id) {
    return 'N42 ID: $id';
  }

  @override
  String get profileN42IdTitle => 'N42 ID';

  @override
  String get profileN42Bean => 'N42 బీన్';

  @override
  String get contactFriendInfo => 'స్నేహితుని సమాచారం';

  @override
  String get contactFriendInfoDesc =>
      'స్నేహితుడి రిమార్క్, ఫోన్, ట్యాగ్‌లు, గమనికలు, ఫోటోలు మరియు సెట్ అనుమతులను జోడించండి.';

  @override
  String get commonMoments => 'క్షణాలు';

  @override
  String get commonSendMessage => 'సందేశం';

  @override
  String get contactAudioVideoCall => 'ఆడియో/వీడియో కాల్';

  @override
  String get contactVideoChannel => 'వీడియో ఛానెల్';

  @override
  String get contactRemark => 'వ్యాఖ్య';

  @override
  String get contactRemarkName => 'రిమార్క్ పేరు';

  @override
  String get contactPhone => 'ఫోన్';

  @override
  String get contactTags => 'ట్యాగ్‌లు';

  @override
  String get contactNotes => 'గమనికలు';

  @override
  String get contactPhotos => 'ఫోటోలు';

  @override
  String get contactPermissions => 'అనుమతులు';

  @override
  String get contactChatMomentsEtc => 'చాట్, క్షణాలు, క్రీడలు మొదలైనవి.';

  @override
  String get contactMoreInfo => 'మరింత సమాచారం';

  @override
  String get contactCommonGroups => 'ఉమ్మడిగా ఉన్న సమూహాలు';

  @override
  String get contactSource => 'మూలం';

  @override
  String get settingsNotificationSettings => 'నోటిఫికేషన్‌లు';

  @override
  String get settingsPrivacy => 'గోప్యత';

  @override
  String get settingsAppearance => 'స్వరూపం';

  @override
  String get settingsAbout => 'గురించి';

  @override
  String get commonLogout => 'లాగ్ అవుట్ చేయండి';

  @override
  String get commonLogoutConfirm =>
      'మీరు ఖచ్చితంగా లాగ్ అవుట్ చేయాలనుకుంటున్నారా?';

  @override
  String get commonSave => 'సేవ్ చేయండి';

  @override
  String get profileNickname => 'మారుపేరు';

  @override
  String get profileEnterNickname => 'మారుపేరును నమోదు చేయండి';

  @override
  String get profileSignature => 'సంతకం';

  @override
  String get profileAddSignature => 'సంతకాన్ని జోడించండి';

  @override
  String get commonTakePhoto => 'ఫోటో తీయండి';

  @override
  String get profileChooseFromGallery => 'గ్యాలరీ నుండి ఎంచుకోండి';

  @override
  String profileSaveFailed(Object error) {
    return 'సేవ్ చేయడం విఫలమైంది: $error';
  }

  @override
  String get authSecureDecentralizedChat => 'సురక్షితమైన, వికేంద్రీకృత సందేశం';

  @override
  String get commonEndToEndEncryption => 'ఎండ్-టు-ఎండ్ ఎన్‌క్రిప్షన్';

  @override
  String get authMessagesOnlyYouCanSee =>
      'సందేశాలు మీకు మరియు స్వీకర్తకు మాత్రమే కనిపిస్తాయి';

  @override
  String get authDecentralized => 'వికేంద్రీకరించబడింది';

  @override
  String get authBasedOnMatrix =>
      'మ్యాట్రిక్స్ ఓపెన్ ప్రోటోకాల్‌పై నిర్మించబడింది';

  @override
  String get authWalletIntegration => 'వాలెట్ ఇంటిగ్రేషన్';

  @override
  String get authEasyCryptoTransfer => 'సులభమైన క్రిప్టోకరెన్సీ బదిలీలు';

  @override
  String get authRegister => 'సైన్ అప్ చేయండి';

  @override
  String get authAgreeTerms => 'లాగిన్ చేయడం ద్వారా, మీరు అంగీకరిస్తున్నారు';

  @override
  String get authTermsOfService => 'సేవా నిబంధనలు';

  @override
  String get authAnd => ' మరియు ';

  @override
  String get authPrivacyPolicy => 'గోప్యతా విధానం';

  @override
  String get authServerAddress => 'సర్వర్ చిరునామా';

  @override
  String get authEnterServerAddress => 'సర్వర్ చిరునామాను నమోదు చేయండి';

  @override
  String authConnectedTo(Object serverName) {
    return '$serverNameకి కనెక్ట్ చేయబడింది';
  }

  @override
  String get authUsername => 'వినియోగదారు పేరు';

  @override
  String get authEnterUsername => 'వినియోగదారు పేరును నమోదు చేయండి';

  @override
  String get authUsernameOrEmail => 'వినియోగదారు పేరు లేదా ఇమెయిల్';

  @override
  String get authEnterUsernameOrEmail =>
      'వినియోగదారు పేరు లేదా ఇమెయిల్‌ను నమోదు చేయండి';

  @override
  String get authPassword => 'పాస్వర్డ్';

  @override
  String get authEnterPassword => 'పాస్వర్డ్ను నమోదు చేయండి';

  @override
  String get authRegisterAccount => 'సైన్ అప్ చేయండి';

  @override
  String get authForgotPassword => 'పాస్‌వర్డ్ మర్చిపోయాను';

  @override
  String get authOtherLoginMethods => 'ఇతర లాగిన్ పద్ధతులు';

  @override
  String get authCreateAccount => 'ఖాతాను సృష్టించండి';

  @override
  String get authJoinN42Chat => 'చాటింగ్ ప్రారంభించడానికి N42 చాట్‌లో చేరండి';

  @override
  String get authUsernameHint => '3-20 అక్షరాలు, అక్షరాలు/సంఖ్యలు/_';

  @override
  String get authUsernameMinLength =>
      'వినియోగదారు పేరు తప్పనిసరిగా కనీసం 3 అక్షరాలు ఉండాలి';

  @override
  String get authUsernameMaxLength =>
      'వినియోగదారు పేరు తప్పనిసరిగా గరిష్టంగా 20 అక్షరాలు ఉండాలి';

  @override
  String get authUsernameFormat =>
      'వినియోగదారు పేరు అక్షరాలు, సంఖ్యలు మరియు అండర్‌స్కోర్‌లను మాత్రమే కలిగి ఉంటుంది';

  @override
  String get authPasswordHint => 'కనిష్టంగా 8 అక్షరాలు';

  @override
  String get commonPasswordMinLength =>
      'పాస్‌వర్డ్ తప్పనిసరిగా కనీసం 8 అక్షరాలు ఉండాలి';

  @override
  String get authConfirmPassword => 'పాస్‌వర్డ్‌ని నిర్ధారించండి';

  @override
  String get authFilled => 'నిండిపోయింది';

  @override
  String get authEnterInviteCode => 'ఆహ్వాన కోడ్‌ని నమోదు చేయండి';

  @override
  String get authAlreadyHaveAccount => 'ఇప్పటికే ఖాతా ఉందా?';

  @override
  String get authLoginNow => 'ఇప్పుడే లాగిన్ అవ్వండి';

  @override
  String get profileAvatar => 'అవతార్';

  @override
  String get profileStatus => 'స్థితి';

  @override
  String get commonLoading => 'లోడ్ అవుతోంది...';

  @override
  String get conversationNoConversations => 'సంభాషణలు లేవు';

  @override
  String get conversationTapToChat =>
      'చాటింగ్ ప్రారంభించడానికి కుడి ఎగువన నొక్కండి';

  @override
  String get conversationStartGroup => 'గ్రూప్ చాట్ ప్రారంభించండి';

  @override
  String get commonScan => 'స్కాన్ చేయండి';

  @override
  String get commonPayment => 'చెల్లింపు';

  @override
  String commonFeatureComingSoon(Object feature) {
    return '$feature త్వరలో వస్తుంది';
  }

  @override
  String get conversationMarkAsRead => 'చదివినట్లు గుర్తు పెట్టండి';

  @override
  String get commonUnmute => 'అన్‌మ్యూట్ చేయండి';

  @override
  String get commonMute => 'మ్యూట్ చేయండి';

  @override
  String get conversationUnpin => 'అన్‌పిన్ చేయండి';

  @override
  String get conversationPin => 'పిన్ చేయండి';

  @override
  String get conversationDeleteConversation => 'సంభాషణను తొలగించండి';

  @override
  String conversationDeleteConversationConfirm(Object name) {
    return '\"$name\"తో సంభాషణను తొలగించాలా?';
  }

  @override
  String get commonNoContacts => 'పరిచయాలు లేవు';

  @override
  String get contactAddFriendsToChat =>
      'చాటింగ్ ప్రారంభించడానికి స్నేహితులను జోడించండి';

  @override
  String get contactNotFound => 'పరిచయం కనుగొనబడలేదు';

  @override
  String get contactTryOtherKeywords =>
      'No search results found for గ్లోబల్ సెర్చ్, Try other keywords';

  @override
  String get contactSearchResults => 'శోధన ఫలితాలు';

  @override
  String get contactNewFriends => 'కొత్త స్నేహితులు';

  @override
  String get contactChatOnlyFriends => 'చాట్-మాత్రమే స్నేహితులు';

  @override
  String get contactOfficialAccounts => 'అధికారిక ఖాతాలు';

  @override
  String get contactServiceAccounts => 'సేవా ఖాతాలు';

  @override
  String get contactEnterpriseContacts => 'ఎంటర్ప్రైజ్ పరిచయాలు';

  @override
  String get contactRecommendToFriend => 'పరిచయాన్ని పంచుకోండి';

  @override
  String get commonSetRemark => 'వ్యాఖ్యను సెట్ చేయండి';

  @override
  String get contactSendingCard => 'కాంటాక్ట్ కార్డ్‌ని పంపుతోంది...';

  @override
  String get commonFileLabel => 'ఫైల్';

  @override
  String get commonLocationLabel => 'స్థానం';

  @override
  String contactRecommendFailed(Object error) {
    return 'సిఫార్సు విఫలమైంది: $error';
  }

  @override
  String get profileEnterRemark => 'వ్యాఖ్యను నమోదు చేయండి';

  @override
  String get contactOpeningChat => 'చాట్‌ని తెరుస్తోంది...';

  @override
  String contactOpenChatFailed(Object error) {
    return 'చాట్ తెరవడంలో విఫలమైంది: $error';
  }

  @override
  String get contactAddContact => 'పరిచయాన్ని జోడించండి';

  @override
  String get contactEnterUserId => 'వినియోగదారు IDని నమోదు చేయండి';

  @override
  String get contactNoFriendRequests => 'స్నేహితుని అభ్యర్థనలు లేవు';

  @override
  String get commonAccept => 'అంగీకరించు';

  @override
  String get commonReject => 'తిరస్కరించు';

  @override
  String get commonNoGroups => 'సమూహాలు లేవు';

  @override
  String get contactSelectFriendToRecommend =>
      'సిఫార్సు చేయడానికి స్నేహితుడిని ఎంచుకోండి';

  @override
  String get commonSearchContacts => 'పరిచయాలను శోధించండి';

  @override
  String get contactNoContactsFound => 'పరిచయాలు ఏవీ కనుగొనబడలేదు';

  @override
  String get favoriteYesterday => 'నిన్న';

  @override
  String get chatJustNow => 'ఇప్పుడే';

  @override
  String get profileOnline => 'ఆన్‌లైన్';

  @override
  String get profileOffline => 'ఆఫ్‌లైన్';

  @override
  String get searchContactsGroupsMessages =>
      'పరిచయాలు, సమూహాలు మరియు సందేశాలను శోధించండి';

  @override
  String get searchError => 'శోధన లోపం';

  @override
  String get chatSearchHint => 'శోధించండి';

  @override
  String get searchHistory => 'శోధన చరిత్ర';

  @override
  String get commonClear => 'క్లియర్';

  @override
  String get commonAll => 'అన్నీ';

  @override
  String get searchGroups => 'గుంపులు';

  @override
  String get searchNoResults => 'ఫలితాలు లేవు';

  @override
  String commonGroupMembers(Object count) {
    return 'సభ్యులు ($count)';
  }

  @override
  String get groupMembersTitle => 'గుంపు సభ్యులు';

  @override
  String get groupViewAll => 'అన్నీ చూడండి';

  @override
  String get groupOwner => 'యజమాని';

  @override
  String get groupAdmin => 'అడ్మిన్';

  @override
  String get groupInvite => 'ఆహ్వానించండి';

  @override
  String get commonGroupAnnouncement => 'సమూహం ప్రకటన';

  @override
  String get commonNotSet => 'సెట్ కాలేదు';

  @override
  String get groupDescription => 'సమూహ వివరణ';

  @override
  String get groupPublicGroup => 'పబ్లిక్ గ్రూప్';

  @override
  String get commonClearChatHistory => 'చాట్ చరిత్రను క్లియర్ చేయండి';

  @override
  String get commonDissolveGroup => 'సమూహాన్ని రద్దు చేయండి';

  @override
  String get commonLeaveGroup => 'సమూహాన్ని వదిలివేయండి';

  @override
  String get groupChangeGroupName => 'గ్రూప్ పేరు మార్చండి';

  @override
  String get commonEnterGroupName => 'సమూహం పేరును నమోదు చేయండి';

  @override
  String get commonConfirm => 'నిర్ధారించండి';

  @override
  String get groupEnterGroupDescription => 'సమూహ వివరణను నమోదు చేయండి';

  @override
  String get groupPublish => 'ప్రచురించండి';

  @override
  String get chatClearHistoryConfirm =>
      'మొత్తం చాట్ చరిత్రను క్లియర్ చేయాలా? ఇది రద్దు చేయబడదు.';

  @override
  String get chatClearAction => 'క్లియర్';

  @override
  String get commonChatHistoryCleared => 'చాట్ చరిత్ర క్లియర్ చేయబడింది';

  @override
  String get commonDissolve => 'కరిగించండి';

  @override
  String get groupQrCode => 'గ్రూప్ QR కోడ్';

  @override
  String get commonSearchChatHistory => 'చాట్ చరిత్రను శోధించండి';

  @override
  String get groupIdCopied => 'గ్రూప్ ID కాపీ చేయబడింది';

  @override
  String get transferEnterOrPasteAddress =>
      'వాలెట్ చిరునామాను నమోదు చేయండి లేదా అతికించండి';

  @override
  String get transferSelectToken => 'టోకెన్‌ని ఎంచుకోండి';

  @override
  String get commonTransferAmount => 'బదిలీ మొత్తం';

  @override
  String get transferAvailable => 'అందుబాటులో ఉంది';

  @override
  String get transferMemoOptional => 'మెమో (ఐచ్ఛికం)';

  @override
  String get transferConfirmTransfer => 'బదిలీని నిర్ధారించండి';

  @override
  String get transferAddressVerified => 'చిరునామా ధృవీకరించబడింది';

  @override
  String transferAvailableBalance(Object balance, Object symbol) {
    return 'అందుబాటులో ఉంది: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'మొత్తాన్ని నమోదు చేయండి';

  @override
  String get commonRedPacketCountMin => 'కనీసం 1 ఎరుపు ప్యాకెట్ అవసరం';

  @override
  String get commonViewRedPacketDetails => 'రెడ్ ప్యాకెట్ వివరాలను వీక్షించండి';

  @override
  String get commonEnterTransferAmount =>
      'దయచేసి బదిలీ మొత్తాన్ని నమోదు చేయండి';

  @override
  String get commonTransferTo => 'కు బదిలీ చేయండి';

  @override
  String commonFromSender(String name) {
    return '$name నుండి';
  }

  @override
  String get commonConfirmReceive => 'రసీదుని నిర్ధారించండి';

  @override
  String get groupProfile => 'గ్రూప్ సమాచారం';

  @override
  String get groupRemoveMember => 'సమూహం నుండి తీసివేయండి';

  @override
  String get commonRemove => 'తొలగించు';

  @override
  String get profileClearStatus => 'క్లియర్ స్థితి';

  @override
  String get profileClearStatusConfirm => 'ప్రస్తుత స్థితిని క్లియర్ చేయాలా?';

  @override
  String get profileStatusCleared => 'స్థితి క్లియర్ చేయబడింది';

  @override
  String get profileUserNotExist => 'వినియోగదారు ఉనికిలో లేరు';

  @override
  String get profileUserIdCopied => 'వినియోగదారు ID కాపీ చేయబడింది';

  @override
  String get commonReport => 'నివేదించండి';

  @override
  String get profileQrCode => 'QR కోడ్';

  @override
  String get profileAvatarUpdated => 'అవతార్ నవీకరించబడింది';

  @override
  String commonSelectImageFailed(Object error) {
    return 'చిత్రాన్ని ఎంచుకోవడంలో విఫలమైంది: $error';
  }

  @override
  String get profileChangeName => 'పేరు మార్చండి';

  @override
  String get profileMale => 'పురుషుడు';

  @override
  String get profileFemale => 'స్త్రీ';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature ఫీచర్ అభివృద్ధిలో ఉంది...';
  }

  @override
  String profileSaveAddressFailed(Object error) {
    return 'చిరునామాను సేవ్ చేయడంలో విఫలమైంది: $error';
  }

  @override
  String get profileAddNew => 'జోడించు';

  @override
  String get profileAddAddress => 'చిరునామాను జోడించండి';

  @override
  String get profileAddressAdded => 'చిరునామా జోడించబడింది';

  @override
  String get profileAddressUpdated => 'చిరునామా నవీకరించబడింది';

  @override
  String get profileDeleteAddress => 'చిరునామాను తొలగించండి';

  @override
  String get profileAddressDeleted => 'చిరునామా తొలగించబడింది';

  @override
  String profileSaveInvoiceFailed(Object error) {
    return 'ఇన్‌వాయిస్‌ని సేవ్ చేయడంలో విఫలమైంది: $error';
  }

  @override
  String get profileMyInvoices => 'నా ఇన్‌వాయిస్‌లు';

  @override
  String get profileAddInvoice => 'ఇన్వాయిస్ జోడించండి';

  @override
  String get profileInvoiceAdded => 'ఇన్‌వాయిస్ జోడించబడింది';

  @override
  String get profileInvoiceUpdated => 'ఇన్‌వాయిస్ నవీకరించబడింది';

  @override
  String get profileDeleteInvoice => 'ఇన్‌వాయిస్‌ని తొలగించండి';

  @override
  String get profileInvoiceDeleted => 'ఇన్‌వాయిస్ తొలగించబడింది';

  @override
  String get profilePersonal => 'వ్యక్తిగత';

  @override
  String get groupSelectAtLeastOne => 'దయచేసి కనీసం ఒక సభ్యుడిని ఎంచుకోండి';

  @override
  String get chatFileNotExist => 'ఫైల్ ఉనికిలో లేదు';

  @override
  String chatSendFailed(String error) {
    return 'పంపడం విఫలమైంది: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'బ్రౌజర్‌ని తెరవడం సాధ్యం కాదు';

  @override
  String chatSelectFileFailed(String error) {
    return 'ఫైల్‌ని ఎంచుకోవడంలో విఫలమైంది: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'సెటప్ విఫలమైంది: $error';
  }

  @override
  String get transferEnterValidAmount =>
      'దయచేసి చెల్లుబాటు అయ్యే మొత్తాన్ని నమోదు చేయండి';

  @override
  String get commonAddressCopied => 'చిరునామా కాపీ చేయబడింది';

  @override
  String favoriteOpenItem(Object content) {
    return 'తెరువు: $content';
  }

  @override
  String get favoriteDeleted => 'తొలగించబడింది';

  @override
  String get profileWallet => 'వాలెట్';

  @override
  String get chatRecording => 'రికార్డింగ్';

  @override
  String get chatInvalidVideoUrl => 'చెల్లని వీడియో URL';

  @override
  String get chatDownloadFile => 'ఫైల్‌ని డౌన్‌లోడ్ చేయండి';

  @override
  String get chatClearChatHistoryTitle => 'చాట్ చరిత్రను క్లియర్ చేయండి';

  @override
  String get chatVideoCall => 'వీడియో కాల్';

  @override
  String get commonVoiceCall => 'వాయిస్ కాల్';

  @override
  String get callLeaveMeeting => 'సమావేశాన్ని వదిలివేయండి';

  @override
  String get chatDetails => 'చాట్ వివరాలు';

  @override
  String get chatViewAllGroupMembers => 'సభ్యులందరినీ వీక్షించండి';

  @override
  String get chatGroupName => 'సమూహం పేరు';

  @override
  String get chatGroupNameUpdated => 'సమూహం పేరు నవీకరించబడింది';

  @override
  String get chatUpdateFailed => 'నవీకరణ విఫలమైంది';

  @override
  String get chatNoPermissionToModify => 'సవరించడానికి మీకు అనుమతి లేదు';

  @override
  String get chatGroupManagement => 'గ్రూప్ మేనేజ్‌మెంట్';

  @override
  String get chatMyNicknameInGroup => 'సమూహంలో నా ముద్దుపేరు';

  @override
  String get chatPinChat => 'పిన్ చాట్';

  @override
  String get chatStrongReminder => 'బలమైన రిమైండర్';

  @override
  String get chatSetChatBackground => 'చాట్ నేపథ్యాన్ని సెట్ చేయండి';

  @override
  String get chatUnknownFile => 'తెలియని ఫైల్';

  @override
  String get chatDownload => 'డౌన్‌లోడ్ చేయండి';

  @override
  String get chatInvalidLocation => 'చెల్లని స్థానం';

  @override
  String get chatTapToCancel => 'రద్దు చేయడానికి నొక్కండి';

  @override
  String chatCaptureFailed(Object error) {
    return 'క్యాప్చర్ విఫలమైంది: $error';
  }

  @override
  String get chatProcessingVideo => 'వీడియోను ప్రాసెస్ చేస్తోంది...';

  @override
  String get chatVideoFileNotExist => 'వీడియో ఫైల్ ఉనికిలో లేదు';

  @override
  String get chatVideoDataEmpty => 'వీడియో డేటా ఖాళీగా ఉంది';

  @override
  String get chatVideoTooLarge => 'వీడియో పరిమాణం 100MB మించకూడదు';

  @override
  String get chatSendingVideo => 'వీడియోను పంపుతోంది...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'వీడియోను పంపడంలో విఫలమైంది: $error';
  }

  @override
  String get chatImageFileNotExist => 'ఇమేజ్ ఫైల్ ఉనికిలో లేదు';

  @override
  String get commonImageDataEmpty => 'చిత్ర డేటా ఖాళీగా ఉంది';

  @override
  String get chatSendingImage => 'చిత్రాన్ని పంపుతోంది...';

  @override
  String chatSendImageFailed(Object error) {
    return 'చిత్రాన్ని పంపడంలో విఫలమైంది: $error';
  }

  @override
  String get chatSendLocation => 'స్థానాన్ని పంపండి';

  @override
  String get chatSelectLocationAndSend => 'లొకేషన్‌ని ఎంచుకుని పంపండి';

  @override
  String get chatShareRealTimeLocation =>
      'నిజ-సమయ స్థానాన్ని భాగస్వామ్యం చేయండి';

  @override
  String get chatShareLocationForOneHour =>
      'స్నేహితుడితో 1 గంట పాటు నిజ-సమయ స్థానాన్ని షేర్ చేయండి';

  @override
  String get chatLocationSent => 'స్థానం పంపబడింది';

  @override
  String get chatSelectMessages => 'సందేశాలను ఎంచుకోండి';

  @override
  String chatSelectedCount(int count) {
    return '$count ఎంచుకోబడింది';
  }

  @override
  String get chatSelectAll => 'అన్నీ ఎంచుకోండి';

  @override
  String chatGroupChatCount(int count) {
    return 'గ్రూప్ చాట్($count)';
  }

  @override
  String get chatPrivateChat => 'ప్రైవేట్ చాట్';

  @override
  String get chatNoMessages => 'సందేశాలు లేవు';

  @override
  String get chatSendFirstMessage =>
      'చాటింగ్ ప్రారంభించడానికి మొదటి సందేశాన్ని పంపండి';

  @override
  String get chatEncryptionNotice =>
      'ఈ చాట్ ఎండ్-టు-ఎండ్ ఎన్‌క్రిప్ట్ చేయబడింది. మీరు మరియు గ్రహీత మాత్రమే సందేశాలను చదవగలరు.';

  @override
  String get chatMultiForward => 'ముందుకు';

  @override
  String get chatCollect => 'సేకరించండి';

  @override
  String get chatNoMembers => 'సభ్యులు లేరు';

  @override
  String get chatMemberNotFound => 'సభ్యుడు దొరకలేదు';

  @override
  String get chatVoiceFileNotExist => 'వాయిస్ ఫైల్ ఉనికిలో లేదు';

  @override
  String get chatVoiceFileEmpty => 'వాయిస్ ఫైల్ ఖాళీగా ఉంది';

  @override
  String get chatSendingVoice => 'వాయిస్ పంపుతోంది...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'వాయిస్ పంపడంలో విఫలమైంది: $error';
  }

  @override
  String get chatMessageForwarded => 'సందేశం ఫార్వార్డ్ చేయబడింది';

  @override
  String chatForwardFailed(Object error) {
    return 'ఫార్వార్డ్ విఫలమైంది: $error';
  }

  @override
  String get chatUnfavorited => 'ఇష్టపడనిది';

  @override
  String get chatFavorited => 'ఇష్టమైనవి';

  @override
  String get chatReactionAdded => 'ప్రతిచర్య జోడించబడింది';

  @override
  String get chatReactionRemoved => 'ప్రతిచర్య తీసివేయబడింది';

  @override
  String get chatFailedMessageDeleted => 'విఫలమైన సందేశం తొలగించబడింది';

  @override
  String get chatDeleteMessages => 'సందేశాలను తొలగించండి';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'మీరు ఖచ్చితంగా $count సందేశాలను తొలగించాలనుకుంటున్నారా?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'గమనిక: $count సందేశాలు ఇతరుల నుండి వచ్చినవి మరియు మీ కోసం మాత్రమే తొలగించబడతాయి.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return 'మీ నుండి వచ్చిన $count సందేశాలు ప్రతి ఒక్కరికీ రీకాల్ చేయబడతాయి.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return '$count సందేశాలను రీకాల్ చేసారు, $localCount మీ కోసం మాత్రమే తొలగించబడింది';
  }

  @override
  String chatRecalledMessages(Object count) {
    return '$count సందేశాలను గుర్తుచేసుకున్నారు';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count సందేశాలు మీ కోసం మాత్రమే తొలగించబడ్డాయి';
  }

  @override
  String chatForwardedCount(Object count) {
    return '$count సందేశాలు ఫార్వార్డ్ చేయబడ్డాయి';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'ఫార్వార్డ్ పూర్తయింది: $success విజయవంతమైంది, $failed విఫలమైంది';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'రిమైండ్ ఫీచర్ గ్రూప్ చాట్‌లో మాత్రమే అందుబాటులో ఉంటుంది';

  @override
  String get chatOnlyTextSearchable => 'వచన సందేశాలను మాత్రమే శోధించవచ్చు';

  @override
  String chatSearchFor(Object text) {
    return '\"$text\"ని శోధించండి';
  }

  @override
  String get chatBaiduSearch => 'Baidu శోధన';

  @override
  String get chatGoogleSearch => 'Google శోధన';

  @override
  String get chatBingSearch => 'బింగ్ శోధన';

  @override
  String get chatCalling => 'కాల్ చేస్తోంది...';

  @override
  String get chatRinging => 'మోగుతోంది...';

  @override
  String get chatInCall => 'కాల్ లో';

  @override
  String commonFeatureInDevelopment(Object feature) {
    return '$feature ఫీచర్ అభివృద్ధిలో ఉంది...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'సేకరించిన $count సందేశాలు';
  }

  @override
  String commonMemberCount(int count) {
    return '$count సభ్యులు';
  }

  @override
  String groupDone(int count) {
    return 'పూర్తయింది($count)';
  }

  @override
  String get profileServices => 'సేవలు';

  @override
  String get commonFavorites => 'ఇష్టమైనవి';

  @override
  String get profileOrdersAndCards => 'ఆర్డర్‌లు & కార్డ్‌లు';

  @override
  String get profileStickers => 'స్టిక్కర్లు';

  @override
  String profileStatusSetTo(String status) {
    return 'స్థితి దీనికి సెట్ చేయబడింది: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'అవతార్ అప్‌లోడ్ విఫలమైంది';

  @override
  String get profilePersonalProfile => 'వ్యక్తిగత ప్రొఫైల్';

  @override
  String get profileName => 'పేరు';

  @override
  String get profileGender => 'లింగం';

  @override
  String get profileRegion => 'ప్రాంతం';

  @override
  String get commonMyQrCode => 'నా QR కోడ్';

  @override
  String get profilePoke => 'దూర్చు';

  @override
  String get profileRingtone => 'రింగ్‌టోన్';

  @override
  String get profileDefaultRingtone => 'డిఫాల్ట్ రింగ్‌టోన్';

  @override
  String get profileMyAddresses => 'నా చిరునామాలు';

  @override
  String profileGenderSetTo(String gender) {
    return 'లింగం దీనికి సెట్ చేయబడింది: $gender';
  }

  @override
  String get profileSelectRegion => 'ప్రాంతాన్ని ఎంచుకోండి';

  @override
  String get profileSelectCity => 'నగరాన్ని ఎంచుకోండి';

  @override
  String profileRegionSetTo(String region) {
    return 'ప్రాంతం దీనికి సెట్ చేయబడింది: $region';
  }

  @override
  String get profileSetPoke => 'పోక్ సెట్ చేయండి';

  @override
  String get profileFriendPokedMe => 'స్నేహితుడు నన్ను పొడుచుకున్నాడు';

  @override
  String get profileExample => 'ఉదాహరణ';

  @override
  String get profileOnTheShoulder => ' భుజం మీద';

  @override
  String get profilePokeCleared => 'పోక్ క్లియర్ చేయబడింది';

  @override
  String profilePokeSetTo(String suffix) {
    return 'పోక్ దీనికి సెట్ చేయబడింది: poked me$suffix';
  }

  @override
  String get profileEditSignature => 'సంతకాన్ని సవరించండి';

  @override
  String get profileIntroduceYourself =>
      'మిమ్మల్ని మీరు పరిచయం చేసుకోవడానికి ఒక వాక్యం';

  @override
  String get profileSignatureCleared => 'సంతకం క్లియర్ చేయబడింది';

  @override
  String get profileSignatureUpdated => 'సంతకం నవీకరించబడింది';

  @override
  String get profileScanToAddFriend =>
      'నన్ను స్నేహితునిగా చేర్చుకోవడానికి పైన ఉన్న QR కోడ్‌ని స్కాన్ చేయండి';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'రింగ్‌టోన్ దీనికి సెట్ చేయబడింది: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'మీరు ఖచ్చితంగా \"$name\"ని రద్దు చేయాలనుకుంటున్నారా? ఈ చర్య రద్దు చేయబడదు.';
  }

  @override
  String get authEnterValidServerAddress =>
      'దయచేసి చెల్లుబాటు అయ్యే సర్వర్ చిరునామాను నమోదు చేయండి';

  @override
  String get authEnterServerAddressFirst =>
      'దయచేసి ముందుగా సర్వర్ చిరునామాను నమోదు చేయండి';

  @override
  String get authPasskeyRequiresServer =>
      'పాస్‌కీ లాగిన్‌కి సర్వర్ మద్దతు అవసరం';

  @override
  String get authLoginAgreement =>
      'లాగిన్ చేయడం ద్వారా, మీరు అంగీకరిస్తున్నారు ';

  @override
  String get authPleaseAgreeToTerms =>
      'దయచేసి సేవా నిబంధనలు మరియు గోప్యతా విధానాన్ని చదివి, అంగీకరించండి';

  @override
  String get authRegisterFailed => 'నమోదు విఫలమైంది';

  @override
  String get authRegistrationDisabled =>
      'ఈ సర్వర్‌లో నమోదు నిలిపివేయబడింది. దాన్ని ప్రారంభించడానికి సర్వర్ నిర్వాహకుడిని సంప్రదించండి.';

  @override
  String get commonReenterPassword => 'పాస్వర్డ్ను మళ్లీ నమోదు చేయండి';

  @override
  String get commonPasswordsDoNotMatch => 'పాస్‌వర్డ్‌లు సరిపోలడం లేదు';

  @override
  String get authInviteCodeBuiltIn => 'ఆహ్వాన కోడ్ (అంతర్నిర్మిత)';

  @override
  String get authInviteCodeBuiltInNote =>
      'ఆహ్వాన కోడ్ అంతర్నిర్మితమైంది, సాధారణంగా సవరించాల్సిన అవసరం లేదు';

  @override
  String get authIHaveReadAndAgree => 'నేను చదివి అంగీకరించాను ';

  @override
  String get mainStartGroupChat => 'గ్రూప్ చాట్ ప్రారంభించండి';

  @override
  String get mainAddFriends => 'స్నేహితులను జోడించండి';

  @override
  String get mainPaymentAndCollection => 'చెల్లింపు';

  @override
  String contactCount(int count) {
    return '$count పరిచయాలు';
  }

  @override
  String get contactAddToHomeScreen => 'హోమ్ స్క్రీన్‌కి జోడించండి';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return '$contact యొక్క కార్డ్ $recipientకి సిఫార్సు చేయబడింది';
  }

  @override
  String get contactEnterRemarkName => 'రిమార్క్ పేరును నమోదు చేయండి';

  @override
  String contactRemarkSetTo(String remark) {
    return 'రిమార్క్ దీనికి సెట్ చేయబడింది: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return '$name స్నేహితుని అభ్యర్థన ఆమోదించబడింది';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return '$name స్నేహితుని అభ్యర్థన తిరస్కరించబడింది';
  }

  @override
  String get commonGroupInvites => 'సమూహం ఆహ్వానాలు';

  @override
  String commonMyGroups(int count) {
    return 'నా గుంపులు ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'సమూహంలో చేరడానికి ఆహ్వానించబడ్డారు';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'మీరు ఖచ్చితంగా \"$name\" నుండి నిష్క్రమించాలనుకుంటున్నారా?';
  }

  @override
  String get commonLeave => 'వదిలేయండి';

  @override
  String get commonRecallThisMessage => 'ఈ సందేశాన్ని గుర్తుకు తెచ్చుకోవాలా?';

  @override
  String get commonSavedToGallery => 'గ్యాలరీకి సేవ్ చేయబడింది';

  @override
  String get commonFailedToSave => 'సేవ్ చేయడంలో విఫలమైంది';

  @override
  String get chatSaving => 'సేవ్ చేస్తోంది...';

  @override
  String get commonShare => 'షేర్ చేయండి';

  @override
  String get chatSaveToGallery => 'గ్యాలరీకి సేవ్ చేయండి';

  @override
  String get chatFailedToLoadImage => 'చిత్రాన్ని లోడ్ చేయడంలో విఫలమైంది';

  @override
  String get chatVideoRecordingFailed => 'వీడియో రికార్డింగ్ విఫలమైంది';

  @override
  String get profileRedPacket => 'రెడ్ ప్యాకెట్';

  @override
  String get commonMusic => 'సంగీతం';

  @override
  String get commonCoupon => 'కూపన్';

  @override
  String get commonGift => 'బహుమతి';

  @override
  String get commonPoll => 'పోల్';

  @override
  String get favoriteText => 'వచనం';

  @override
  String get favoriteLinkLabel => 'లింక్';

  @override
  String get favoriteNote => 'గమనిక';

  @override
  String get favoriteMyNotes => 'నా గమనికలు';

  @override
  String get favoriteToday => 'ఈరోజు';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count రోజుల క్రితం';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$month/$day';
  }

  @override
  String get favoriteNoFavorites => 'ఇంకా ఇష్టమైనవి లేవు';

  @override
  String get favoriteLongPressToFavorite =>
      'ఇష్టమైన వాటికి సందేశాన్ని ఎక్కువసేపు నొక్కండి';

  @override
  String get favoriteNewNote => 'కొత్త నోట్';

  @override
  String get favoriteLink => 'ఇష్టమైన లింక్';

  @override
  String get favoriteEditTags => 'ట్యాగ్‌లను సవరించండి';

  @override
  String get favoriteDeleteFavorite => 'ఇష్టమైన వాటిని తొలగించండి';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'మీరు ఈ ఇష్టమైనవిని ఖచ్చితంగా తొలగించాలనుకుంటున్నారా?';

  @override
  String get favoriteNoSearchResultsFound => 'ఫలితాలు ఏవీ కనుగొనబడలేదు';

  @override
  String get commonSendRedPacket => 'రెడ్ ప్యాకెట్ పంపండి';

  @override
  String get transferAmount => 'మొత్తం';

  @override
  String get commonRedPacketCover => 'రెడ్ ప్యాకెట్ కవర్';

  @override
  String get commonRedPacketType => 'రెడ్ ప్యాకెట్ రకం';

  @override
  String get commonNormalRedPacket => 'సాధారణ';

  @override
  String get commonLuckyRedPacket => 'అదృష్టవంతుడు';

  @override
  String get commonRedPacketCount => 'రెడ్ ప్యాకెట్ కౌంట్';

  @override
  String get commonPieces => 'ముక్కలు';

  @override
  String get commonPutMoneyInRedPacket => 'ఎరుపు ప్యాకెట్‌లో డబ్బు ఉంచండి';

  @override
  String get commonRedPacketRefundNotice =>
      'క్లెయిమ్ చేయని రెడ్ ప్యాకెట్లు 24 గంటల తర్వాత వాపసు ఇవ్వబడతాయి';

  @override
  String get commonOpenRedPacket => 'తెరవండి';

  @override
  String get commonRedPacketAllClaimed =>
      'రెడ్ ప్యాకెట్ అన్నీ క్లెయిమ్ చేయబడ్డాయి';

  @override
  String get commonRedPacketExpired => 'ఎరుపు ప్యాకెట్ గడువు ముగిసింది';

  @override
  String get commonAddTransferNote => 'బదిలీ గమనికను జోడించండి';

  @override
  String get commonYuan => 'CNY';

  @override
  String get commonReplyWithEmoji => 'ఈ ఎమోజితో ప్రత్యుత్తరం ఇవ్వండి';

  @override
  String get contactEditRemark => 'రిమార్క్‌ని సవరించండి';

  @override
  String get contactSetPermissions => 'అనుమతులను సెట్ చేయండి';

  @override
  String get profileAddToBlacklist => 'బ్లాక్‌లిస్ట్‌కు జోడించండి';

  @override
  String get contactDeleteContact => 'పరిచయాన్ని తొలగించండి';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'మీరు ఖచ్చితంగా $nameని తొలగించాలనుకుంటున్నారా?';
  }

  @override
  String get transferTitle => 'బదిలీ చేయండి';

  @override
  String get transferReceiverAddressLabel => 'గ్రహీత చిరునామా';

  @override
  String get transferSelectTokenLabel => 'టోకెన్‌ని ఎంచుకోండి';

  @override
  String get transferAmountLabel => 'బదిలీ మొత్తం';

  @override
  String get transferMemoLabel => 'మెమో (ఐచ్ఛికం)';

  @override
  String get transferAddMemoHint => 'మెమోని జోడించండి';

  @override
  String get transferSendPaymentRequest => 'చెల్లింపు అభ్యర్థనను పంపండి';

  @override
  String get transferQrCodeGenerateFailed => 'QR కోడ్ ఉత్పత్తి విఫలమైంది';

  @override
  String get transferScanQrToPayMe =>
      'నాకు చెల్లించడానికి QR కోడ్‌ని స్కాన్ చేయండి';

  @override
  String get transferMyWalletAddress => 'నా వాలెట్ చిరునామా';

  @override
  String get transferCreatePaymentRequest => 'చెల్లింపు అభ్యర్థనను సృష్టించండి';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'శుభాకాంక్షలు';

  @override
  String commonSenderRedPacket(String name) {
    return '$name యొక్క రెడ్ ప్యాకెట్';
  }

  @override
  String get transferEnterValidAddress =>
      'దయచేసి చెల్లుబాటు అయ్యే చిరునామాను నమోదు చేయండి';

  @override
  String get transferPleaseSelectToken => 'దయచేసి టోకెన్‌ను ఎంచుకోండి';

  @override
  String get commonReceivedTransfer => 'బదిలీని స్వీకరించారు';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name ఎరుపు రంగు ప్యాకెట్‌ని పంపింది';
  }

  @override
  String get commonSavedToBalance =>
      'బ్యాలెన్స్‌కు సేవ్ చేయబడింది, నేరుగా బదిలీ చేయవచ్చు';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'ఎరుపు ప్యాకెట్ గడువు ముగిసింది/అన్నీ క్లెయిమ్ చేయబడ్డాయి';

  @override
  String get transferScanFeatureComingSoon => 'స్కాన్ ఫీచర్ త్వరలో...';

  @override
  String get contactSetAsStarred => 'నక్షత్రం గుర్తుగా సెట్ చేయండి';

  @override
  String get contactAddToBlocklist => 'బ్లాక్‌లిస్ట్‌కు జోడించండి';

  @override
  String get commonClaimedYour => ' క్లెయిమ్ చేసింది మీ ';

  @override
  String get commonClaimedText => ' పేర్కొన్నారు ';

  @override
  String commonUserTyping(String name) {
    return '$name టైప్ చేస్తోంది...';
  }

  @override
  String get commonTyping => 'టైప్ చేస్తోంది...';

  @override
  String get commonWaitingToReceive => 'అందుకోవడానికి వేచి ఉంది';

  @override
  String get commonTapToClaim => 'క్లెయిమ్ చేయడానికి నొక్కండి';

  @override
  String get commonHasBeenReceived => 'అందుకుంది';

  @override
  String get commonGetLucky => 'అదృష్టాన్ని పొందండి';

  @override
  String get qrcodeCameraStartFailed => 'కెమెరా ప్రారంభించడంలో విఫలమైంది';

  @override
  String get qrcodeUnknownError => 'తెలియని లోపం';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'స్కాన్ చేయడానికి ఫ్రేమ్‌లో QR కోడ్‌ని ఉంచండి';

  @override
  String get qrcodeCloseManualInput => 'మాన్యువల్ ఇన్‌పుట్‌ను మూసివేయండి';

  @override
  String get qrcodeManualInputUserId => 'మాన్యువల్ ఇన్‌పుట్ వినియోగదారు ID';

  @override
  String get commonAdd => 'జోడించు';

  @override
  String get profileSetStatus => 'స్థితిని సెట్ చేయండి';

  @override
  String get profileVisibleToFriends24h =>
      'స్నేహితులకు 24 గంటల పాటు కనిపిస్తుంది';

  @override
  String get profileWriteStatus => 'స్థితిని వ్రాయండి';

  @override
  String get profileEnterYourStatus => 'మీ స్థితిని నమోదు చేయండి...';

  @override
  String get profileOk => 'సరే';

  @override
  String get qrcodeCameraPermissionRequired =>
      'QR కోడ్‌ని స్కాన్ చేయడానికి కెమెరా అనుమతి అవసరం';

  @override
  String get qrcodeCameraPermissionDenied =>
      'కెమెరా అనుమతి శాశ్వతంగా తిరస్కరించబడింది. దయచేసి సిస్టమ్ సెట్టింగ్‌లలో దీన్ని ప్రారంభించండి.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'అనుమతిని తనిఖీ చేయడంలో లోపం: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'చెల్లని QR కోడ్';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'స్నేహితుడిని జోడించలేరు: $error';
  }

  @override
  String get qrcodeScanQrCode => 'QR కోడ్‌ని స్కాన్ చేయండి';

  @override
  String get qrcodeCheckingCameraPermission =>
      'కెమెరా అనుమతిని తనిఖీ చేస్తోంది...';

  @override
  String get qrcodeNeedCameraPermission => 'కెమెరా అనుమతి అవసరం';

  @override
  String get qrcodeRetryPermission => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get qrcodeOpenSettings => 'సెట్టింగ్‌లను తెరవండి';

  @override
  String get groupInviteMembers => 'సభ్యులను ఆహ్వానించండి';

  @override
  String groupInviteCount(int count) {
    return 'ఆహ్వానం($count)';
  }

  @override
  String get profileNoShippingAddress => 'షిప్పింగ్ చిరునామా లేదు';

  @override
  String get profileDefaultLabel => 'డిఫాల్ట్';

  @override
  String get profileNoInvoice => 'ఇన్వాయిస్ లేదు';

  @override
  String get profileCompany => 'కంపెనీ';

  @override
  String get profileTaxNumber => 'పన్ను సంఖ్య';

  @override
  String get profileConfirmDeleteAddress =>
      'మీరు ఖచ్చితంగా ఈ చిరునామాను తొలగించాలనుకుంటున్నారా?';

  @override
  String get profileConfirmDeleteInvoice =>
      'మీరు ఖచ్చితంగా ఈ ఇన్‌వాయిస్‌ని తొలగించాలనుకుంటున్నారా?';

  @override
  String get commonGroupOwner => 'యజమాని';

  @override
  String get commonGroupAdmin => 'అడ్మిన్';

  @override
  String get groupSearchMembers => 'శోధన సభ్యులు';

  @override
  String groupTotalMembers(int count) {
    return '$count సభ్యులు';
  }

  @override
  String get chatRemoveFromGroup => 'సమూహం నుండి తీసివేయండి';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'మీరు ఖచ్చితంగా సమూహం నుండి \"$name\"ని తీసివేయాలనుకుంటున్నారా?';
  }

  @override
  String get chatUnknownSong => 'తెలియని పాట';

  @override
  String get chatUnknownArtist => 'తెలియని కళాకారుడు';

  @override
  String get chatUnknownContact => 'తెలియని పరిచయం';

  @override
  String get chatPersonalCard => 'సంప్రదింపు కార్డ్';

  @override
  String get chatSingleChoice => 'సింగిల్';

  @override
  String get chatMultiChoice => 'బహుళ';

  @override
  String get chatEnded => 'ముగిసింది';

  @override
  String get chatEndPollButton => 'పోల్ ముగించు';

  @override
  String get chatPollHint =>
      'పోల్ చాట్‌లో ప్రదర్శించబడుతుంది. గ్రూప్ సభ్యులు ఓటు వేయవచ్చు.';

  @override
  String get chatSearchSongOrArtist => 'పాట లేదా కళాకారుడిని శోధించండి';

  @override
  String get chatNoSongsFound => 'పాటలు ఏవీ కనుగొనబడలేదు';

  @override
  String get chatSongNameOptional => 'పాట పేరు (ఐచ్ఛికం)';

  @override
  String get chatEnterSongName => 'పాట పేరు నమోదు చేయండి';

  @override
  String get chatArtistNameOptional => 'కళాకారుడి పేరు (ఐచ్ఛికం)';

  @override
  String get chatEnterArtistName => 'కళాకారుడి పేరును నమోదు చేయండి';

  @override
  String get chatRealTimeLocationSharing =>
      'అభివృద్ధిలో నిజ-సమయ స్థాన భాగస్వామ్యం...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'వాయిస్ కాల్ ఫీచర్ అభివృద్ధిలో ఉంది...';

  @override
  String get profileReportFeatureInDev => 'అభివృద్ధిలో ఫీచర్‌ని నివేదించండి...';

  @override
  String get profileShareFeatureInDev =>
      'అభివృద్ధిలో ఫీచర్‌ను భాగస్వామ్యం చేయండి...';

  @override
  String get profileQrCodeFeatureInDev => 'అభివృద్ధిలో QR కోడ్ ఫీచర్...';

  @override
  String get qrcodeScanQrToAddMe =>
      'నన్ను స్నేహితునిగా చేర్చుకోవడానికి పైన ఉన్న QR కోడ్‌ని స్కాన్ చేయండి';

  @override
  String get qrcodeSaveToAlbum => 'ఆల్బమ్‌కు సేవ్ చేయండి';

  @override
  String get qrcodeChangeStyle => 'శైలిని మార్చండి';

  @override
  String get qrcodeCopyId => 'IDని కాపీ చేయండి';

  @override
  String get qrcodeIdCopied => 'ID కాపీ చేయబడింది';

  @override
  String get qrcodeMoreStylesFeatureComingSoon =>
      'మరిన్ని స్టైల్స్ త్వరలో వస్తాయి';

  @override
  String get profileBio => 'బయో';

  @override
  String get profileHomeServer => 'సర్వర్';

  @override
  String get profileShareContactCard => 'కాంటాక్ట్ కార్డ్ షేర్ చేయండి';

  @override
  String get profileRemoveFromBlacklist => 'బ్లాక్‌లిస్ట్ నుండి తీసివేయండి';

  @override
  String get profileConfirmAddBlacklist =>
      'మీరు ఖచ్చితంగా ఈ వినియోగదారుని బ్లాక్‌లిస్ట్‌కి జోడించాలనుకుంటున్నారా? మీరు వారి నుండి సందేశాలను స్వీకరించరు.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'మీరు ఖచ్చితంగా ఈ వినియోగదారుని బ్లాక్‌లిస్ట్ నుండి తీసివేయాలనుకుంటున్నారా?';

  @override
  String get profileRemarkSaved => 'రిమార్క్ సేవ్ చేయబడింది';

  @override
  String get profileRemarkCleared => 'వ్యాఖ్య క్లియర్ చేయబడింది';

  @override
  String get transferReceive => 'స్వీకరించండి';

  @override
  String get transferPleaseConnectWallet =>
      'దయచేసి ముందుగా మీ వాలెట్‌ని కనెక్ట్ చేయండి';

  @override
  String get transferSendRequest => 'అభ్యర్థనను పంపండి';

  @override
  String get transferPleaseEnterValidAmount =>
      'దయచేసి చెల్లుబాటు అయ్యే మొత్తాన్ని నమోదు చేయండి';

  @override
  String get searchPlaceholder => 'పరిచయాలు, సమూహాలు, సందేశాలను శోధించండి';

  @override
  String get searchEnterKeywordToSearch =>
      'శోధనను ప్రారంభించడానికి కీవర్డ్‌ని నమోదు చేయండి';

  @override
  String get searchClearHistory => 'క్లియర్';

  @override
  String get searchClearHistoryConfirm =>
      'అన్ని ఇటీవలి శోధనలను క్లియర్ చేయాలా?';

  @override
  String searchNoResultsForQuery(String query) {
    return '\"$query\" కోసం ఫలితాలు కనుగొనబడలేదు';
  }

  @override
  String get searchAllResults => 'అన్నీ';

  @override
  String get searchInChat => 'చాట్‌లో శోధించండి';

  @override
  String get searchContactLabel => 'సంప్రదించండి';

  @override
  String get searchGroupLabel => 'సమూహం';

  @override
  String get searchConversationLabel => 'సంభాషణ';

  @override
  String get searchMessageLabel => 'సందేశం';

  @override
  String get settingsSecurityTitle => 'భద్రత';

  @override
  String get settingsDeleteAccountTitle => 'ఖాతాను తొలగించండి';

  @override
  String get settingsDeleteAccountSubtitle =>
      'ఈ Matrix ఖాతాను నిష్క్రియం చేసి, దాని స్థానిక చాట్ డేటాను శుభ్రం చేయండి';

  @override
  String get settingsDeleteAccountExplanation =>
      'ఇది Matrix ఖాతాను శాశ్వతంగా నిష్క్రియం చేయమని అభ్యర్థిస్తుంది. సర్వర్ నిర్ధారణ తర్వాత, సురక్షితమైనప్పుడు ఈ ఖాతా స్థానిక చాట్ సెషన్ మరియు ఎన్‌క్రిప్షన్ కీలను యాప్ తొలగిస్తుంది. ఇతర ఖాతాలు, మీ వాలెట్ అలాగే ఉంటాయి. సర్వర్ల సమాఖ్య మరియు డేటా నిల్వ విధానాలు డేటా తొలగింపును పరిమితం చేయవచ్చు.';

  @override
  String get settingsDeleteAccountPasswordOptional =>
      'అడిగితే Matrix పాస్‌వర్డ్';

  @override
  String get settingsDeleteAccountServerErase =>
      'సర్వర్ డేటా తొలగింపును అభ్యర్థించండి';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      'సదుపాయం ఉన్నచోట ఖాతా డేటాను తొలగించమని ఈ హోమ్‌సర్వర్‌ను అడగండి. ఇతర సర్వర్లలో ఉన్న లేదా నిల్వ విధానాల ప్రకారం అవసరమైన కాపీలు మిగిలి ఉండవచ్చు.';

  @override
  String get settingsDeleteAccountChooseStage => 'ఈ Matrix ఖాతాను ధృవీకరించండి';

  @override
  String get settingsDeleteAccountUsePassword =>
      'Matrix పాస్‌వర్డ్ ఉపయోగించండి';

  @override
  String get settingsDeleteAccountUseBrowser => 'బ్రౌజర్‌లో కొనసాగించండి';

  @override
  String get settingsDeleteAccountFallbackTitle =>
      'Matrix ధృవీకరణ నుంచి తిరిగి రండి';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      'బ్రౌజర్ నుంచి తిరిగి రావడం తొలగింపును నిర్ధారించదు. అసలు అభ్యర్థనను Matrix సర్వర్‌తో తనిఖీ చేయండి.';

  @override
  String get settingsDeleteAccountCheckServer => 'సర్వర్‌తో తనిఖీ చేయండి';

  @override
  String get settingsDeleteAccountRequestFailed =>
      'ఖాతా తొలగింపును Matrix సర్వర్ నిర్ధారించలేదు.';

  @override
  String get settingsDeleteAccountPendingTitle =>
      'స్థానిక ఖాతా శుభ్రపరచడం పెండింగ్‌లో ఉంది';

  @override
  String get settingsDeleteAccountPendingSubtitle =>
      'గతంలో నిష్క్రియం చేసిన Matrix ఖాతా శుభ్రపరచడాన్ని సమీక్షించండి';

  @override
  String get settingsDeleteAccountPendingReadError =>
      'పెండింగ్ శుభ్రపరిచే రికార్డులను చదవలేకపోయాము. మళ్లీ ప్రయత్నించడానికి నొక్కండి.';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'Matrix ఖాతా నిష్క్రియం అయింది, కానీ స్థానిక శుభ్రపరచడం ఇంకా పెండింగ్‌లో ఉంది. ఇతర ఖాతాలు అందుబాటులో ఉంటాయి.';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      'ఖాతా నిర్వహణ మీ బ్రౌజర్‌లో తెరవబడింది. ఈ యాప్‌లో తొలగింపు నిర్ధారించబడలేదు, కాబట్టి మీ చాట్ సెషన్ అందుబాటులో ఉంటుంది.';

  @override
  String get settingsKeyBackup => 'కీ బ్యాకప్';

  @override
  String get settingsBackupEncryptionKeys => 'బ్యాకప్ ఎన్‌క్రిప్షన్ కీలు';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count కీలు బ్యాకప్ చేయబడ్డాయి';
  }

  @override
  String get settingsBackupNotSet => 'బ్యాకప్ సెట్ చేయబడలేదు';

  @override
  String get settingsRestoreKeys => 'కీలను పునరుద్ధరించండి';

  @override
  String get settingsRestoreKeysFromBackup =>
      'బ్యాకప్ నుండి ఎన్క్రిప్షన్ కీలను పునరుద్ధరించండి';

  @override
  String get settingsExportKeys => 'కీలను ఎగుమతి చేయండి';

  @override
  String get settingsExportKeysToFile => 'ఫైల్‌కి కీలను ఎగుమతి చేయండి';

  @override
  String get settingsLoggedInDevices => 'పరికరాలకు లాగిన్ చేయబడింది';

  @override
  String get settingsNoOtherDevices => 'ఇతర పరికరాలు లేవు';

  @override
  String get settingsVerified => 'ధృవీకరించబడింది';

  @override
  String get settingsUnverified => 'ధృవీకరించబడలేదు';

  @override
  String get settingsAdvanced => 'అధునాతనమైనది';

  @override
  String get settingsCrossSigning => 'క్రాస్-సైనింగ్';

  @override
  String get settingsEnabled => 'ప్రారంభించబడింది';

  @override
  String get settingsNotEnabled => 'ప్రారంభించబడలేదు';

  @override
  String get settingsResetEncryption => 'ఎన్క్రిప్షన్ రీసెట్ చేయండి';

  @override
  String get settingsDeleteAllEncryptionKeys =>
      'అన్ని ఎన్క్రిప్షన్ కీలను తొలగించండి';

  @override
  String get settingsEncryptionNotSupported => 'గుప్తీకరణకు మద్దతు లేదు';

  @override
  String get settingsNotInitialized => 'ప్రారంభించబడలేదు';

  @override
  String get settingsBackupKeyTitle => 'బ్యాకప్ కీలు';

  @override
  String get settingsBackupKeyMessage =>
      'కొత్త కీ బ్యాకప్‌ని సృష్టించాలా? కొత్త పరికరంలో గుప్తీకరించిన సందేశాలను పునరుద్ధరించడానికి ఇది మీకు సహాయం చేస్తుంది.';

  @override
  String get settingsBackup => 'బ్యాకప్';

  @override
  String get settingsRestoreKeyTitle => 'కీలను పునరుద్ధరించండి';

  @override
  String get settingsRestoreKeyMessage =>
      'గుప్తీకరించిన సందేశాలను పునరుద్ధరించడానికి మీ పునరుద్ధరణ పాస్‌వర్డ్ లేదా పునరుద్ధరణ కీని నమోదు చేయండి.';

  @override
  String get settingsRestore => 'పునరుద్ధరించు';

  @override
  String get settingsExportKeyTitle => 'కీలను ఎగుమతి చేయండి';

  @override
  String get settingsExportKeyMessage =>
      'ఎగుమతి చేయబడిన కీ ఫైల్ మీ అన్ని ఎన్‌క్రిప్షన్ కీలను కలిగి ఉంటుంది. దయచేసి దానిని సురక్షితంగా ఉంచండి.';

  @override
  String get settingsExport => 'ఎగుమతి చేయండి';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'పరికరం ID: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'స్థితి: ధృవీకరించబడింది';

  @override
  String get settingsDeviceStatusUnverified => 'స్థితి: ధృవీకరించబడలేదు';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'చివరిగా సక్రియం: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'ఈ పరికరాన్ని ధృవీకరించండి';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'క్రాస్-సైనింగ్ ఇప్పటికే ప్రారంభించబడింది';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'క్రాస్-సైనింగ్ సెటప్ విజయవంతమైంది';

  @override
  String get settingsResetEncryptionTitle => 'ఎన్క్రిప్షన్ రీసెట్ చేయండి';

  @override
  String get settingsResetEncryptionWarning =>
      'హెచ్చరిక: ఇది మీ అన్ని ఎన్‌క్రిప్షన్ కీలను తొలగిస్తుంది. మీరు మునుపటి గుప్తీకరించిన సందేశాలను డీక్రిప్ట్ చేయలేరు. ఈ చర్య రద్దు చేయబడదు.';

  @override
  String get settingsReset => 'రీసెట్ చేయండి';

  @override
  String get settingsBackupSuccess => 'కీలు విజయవంతంగా బ్యాకప్ చేయబడ్డాయి';

  @override
  String get settingsBackupFailed => 'బ్యాకప్ విఫలమైంది';

  @override
  String get settingsRecoveryKey => 'రికవరీ కీ';

  @override
  String get settingsRecoveryKeySaveWarning =>
      'దయచేసి ఈ రికవరీ కీని సురక్షితమైన స్థలంలో సేవ్ చేయండి. కొత్త పరికరంలో మీ గుప్తీకరించిన సందేశాలను పునరుద్ధరించడానికి మీకు ఇది అవసరం.';

  @override
  String get settingsRecoveryKeySaved => 'నేను దానిని సేవ్ చేసాను';

  @override
  String get settingsRestoreSuccess => 'కీలు విజయవంతంగా పునరుద్ధరించబడ్డాయి';

  @override
  String get settingsRestoreEmpty => 'ఈ బ్యాకప్‌లో సందేశ కీలేవీ కనుగొనబడలేదు.';

  @override
  String settingsRestoreSessions(int count) {
    return '$count కీ సెషన్‌లు పునరుద్ధరించబడ్డాయి. కీలు లేని సందేశాలు గుప్తీకరించబడి ఉండవచ్చు.';
  }

  @override
  String get settingsRestoreFailed => 'పునరుద్ధరించడం విఫలమైంది';

  @override
  String get settingsPassword => 'పాస్వర్డ్';

  @override
  String get settingsEnterRecoveryKey => 'రికవరీ కీని నమోదు చేయండి';

  @override
  String get settingsEnterPassword => 'పాస్వర్డ్ను నమోదు చేయండి';

  @override
  String get settingsExportSuccess =>
      'కీలు సర్వర్ బ్యాకప్‌కి విజయవంతంగా ఎగుమతి చేయబడ్డాయి';

  @override
  String get settingsExportNeedBackupFirst =>
      'దయచేసి ముందుగా కీ బ్యాకప్‌ని సృష్టించండి';

  @override
  String get settingsExportFailed => 'ఎగుమతి విఫలమైంది';

  @override
  String get settingsResetSuccess => 'ఎన్‌క్రిప్షన్ రీసెట్ విజయవంతమైంది';

  @override
  String get settingsResetFailed => 'రీసెట్ విఫలమైంది';

  @override
  String get callLeaveMeetingConfirm =>
      'మీరు ఖచ్చితంగా సమావేశం నుండి నిష్క్రమించాలనుకుంటున్నారా?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return '$name$suffixని పొడిచారు';
  }

  @override
  String get chatNoContactsToAdd => 'జోడించడానికి పరిచయాలు ఏవీ అందుబాటులో లేవు';

  @override
  String get chatAddMembers => 'సభ్యులను జోడించండి';

  @override
  String chatInvitedMembers(int count) {
    return '$count సభ్యులు ఆహ్వానించబడ్డారు';
  }

  @override
  String chatInviteFailed(String error) {
    return 'ఆహ్వానం విఫలమైంది: $error';
  }

  @override
  String get chatMemberRemoved => 'సభ్యుడు తొలగించబడ్డారు';

  @override
  String chatRemoveFailed(String error) {
    return 'తీసివేయడం విఫలమైంది: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'భాగస్వామ్యం చేసిన తర్వాత, అవతలి పక్షం 1 గంట పాటు మీ నిజ-సమయ స్థానాన్ని చూడగలరు.';

  @override
  String get chatStartSharing => 'భాగస్వామ్యం చేయడం ప్రారంభించండి';

  @override
  String get chatLocationServiceNotEnabled => 'స్థాన సేవ ప్రారంభించబడలేదు';

  @override
  String get chatEnableLocationService =>
      'దయచేసి ఈ లక్షణాన్ని ఉపయోగించడానికి స్థాన సేవను ప్రారంభించండి';

  @override
  String get chatGoToSettings => 'సెట్టింగ్‌లకు వెళ్లండి';

  @override
  String get chatLocationPermissionRequired =>
      'ఈ ఫీచర్ కోసం స్థాన అనుమతి అవసరం';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'స్థాన అనుమతి శాశ్వతంగా తిరస్కరించబడింది. దయచేసి సెట్టింగ్‌లలో దీన్ని ప్రారంభించండి.';

  @override
  String get chatLocationPermissionDenied => 'స్థాన అనుమతి నిరాకరించబడింది';

  @override
  String get chatGettingLocation => 'స్థానాన్ని పొందుతోంది...';

  @override
  String chatGetLocationFailed(String error) {
    return 'స్థానాన్ని పొందడంలో విఫలమైంది: $error';
  }

  @override
  String get chatMapPreview => 'మ్యాప్ ప్రివ్యూ';

  @override
  String get chatSearchLocation => 'స్థానాన్ని శోధించండి';

  @override
  String chatRedPacketSent(String amount, String token) {
    return '$amount $token ఎరుపు ప్యాకెట్ పంపబడింది';
  }

  @override
  String get chatTransferDefault => 'బదిలీ చేయండి';

  @override
  String chatTransferSent(String amount, String token) {
    return '$amount $token బదిలీ పంపబడింది';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'ఫైల్‌ను ఎంచుకోవడంలో విఫలమైంది: $error';
  }

  @override
  String get chatFileSizeLimit => 'ఫైల్ పరిమాణం 50MB మించకూడదు';

  @override
  String chatFileSending(String filename) {
    return 'ఫైల్‌ని పంపుతోంది: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'ఫైల్‌ని పంపడంలో విఫలమైంది: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return '$name యొక్క సంప్రదింపు కార్డ్ పంపబడింది';
  }

  @override
  String get chatFavoritesFeature => 'ఇష్టమైనవి';

  @override
  String get chatCouponsFeature => 'కూపన్లు';

  @override
  String get chatGiftFeature => 'బహుమతి';

  @override
  String chatSharedMusic(String name) {
    return 'భాగస్వామ్యం చేయబడిన $name';
  }

  @override
  String get chatEndPollTitle => 'పోల్ ముగించు';

  @override
  String get chatEndPollConfirmMessage =>
      'మీరు ఖచ్చితంగా ఈ పోల్‌ను ముగించాలనుకుంటున్నారా? ముగిసిన తర్వాత ఓటింగ్ మూసివేయబడుతుంది.';

  @override
  String get chatPollEndedMessage => 'పోల్ ముగిసింది';

  @override
  String get chatConnectingCall => 'కనెక్ట్ అవుతోంది...';

  @override
  String get chatMuteCall => 'మ్యూట్ చేయండి';

  @override
  String get chatSpeakerOff => 'స్పీకర్ ఆఫ్';

  @override
  String get chatSpeakerOn => 'స్పీకర్';

  @override
  String get chatCameraOn => 'కెమెరా ఆన్';

  @override
  String get chatCameraOff => 'కెమెరా ఆఫ్';

  @override
  String get chatHangUp => 'హ్యాంగ్ అప్ చేయండి';

  @override
  String get chatSelectForwardTargetTitle => 'ఫార్వర్డ్ టార్గెట్ ఎంచుకోండి';

  @override
  String get chatNoForwardableChat =>
      'ఫార్వార్డింగ్ కోసం చాట్‌లు ఏవీ అందుబాటులో లేవు';

  @override
  String get chatNoMatchingChat => 'సరిపోలే చాట్‌లు ఏవీ కనుగొనబడలేదు';

  @override
  String get chatLocationTitle => 'స్థానం';

  @override
  String get chatSendButton => 'పంపండి';

  @override
  String get chatRetryButton => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get chatSearchContactHint => 'పరిచయాలను శోధించండి';

  @override
  String get chatShareMusic => 'సంగీతాన్ని భాగస్వామ్యం చేయండి';

  @override
  String get chatRecentPlayed => 'ఇటీవలి';

  @override
  String get chatMyFavorites => 'ఇష్టమైనవి';

  @override
  String get chatNetworkLink => 'లింక్';

  @override
  String get chatLocalFile => 'స్థానిక';

  @override
  String get chatPasteMusicLink => 'మ్యూజిక్ లింక్‌ని అతికించండి';

  @override
  String get chatShareMusicButton => 'సంగీతాన్ని భాగస్వామ్యం చేయండి';

  @override
  String get chatSelectLocalAudio => 'లోకల్ ఆడియో ఫైల్‌ని ఎంచుకోండి';

  @override
  String get chatSupportedAudioFormats =>
      'MP3, M4A, WAV, FLAC మొదలైన వాటికి మద్దతు ఇస్తుంది.';

  @override
  String get chatSelectFileButton => 'ఫైల్‌ని ఎంచుకోండి';

  @override
  String get chatPleaseEnterMusicLink => 'దయచేసి సంగీత లింక్‌ని నమోదు చేయండి';

  @override
  String get chatPleaseEnterValidLink =>
      'దయచేసి చెల్లుబాటు అయ్యే URLని నమోదు చేయండి';

  @override
  String get chatSharedSong => 'షేర్డ్ సాంగ్';

  @override
  String get chatSelectMember => 'సభ్యుడిని ఎంచుకోండి';

  @override
  String get chatSearchMemberHint => 'శోధన సభ్యులు';

  @override
  String get chatNoMatchingMembers => 'సరిపోలే సభ్యులు కనుగొనబడలేదు';

  @override
  String get commonUnknownMember => 'తెలియదు';

  @override
  String chatSelectedMessagesCount(int count) {
    return 'ఎంచుకున్న $count సందేశాలు';
  }

  @override
  String get chatSearchContactsOrGroups => 'పరిచయాలు లేదా సమూహాలను శోధించండి';

  @override
  String get chatVideoTitle => 'వీడియో';

  @override
  String get chatLoadingText => 'లోడ్ అవుతోంది...';

  @override
  String get chatVideoLoadFailed => 'వీడియో లోడ్ విఫలమైంది';

  @override
  String get chatPlayerInitFailed => 'ప్లేయర్ ప్రారంభించడం విఫలమైంది';

  @override
  String get chatCreatePollTitle => 'పోల్‌ని సృష్టించండి';

  @override
  String get chatSubmitPoll => 'సమర్పించండి';

  @override
  String get chatPollQuestionLabel => 'పోల్ ప్రశ్న';

  @override
  String get chatEnterPollQuestionHint => 'దయచేసి పోల్ ప్రశ్నను నమోదు చేయండి';

  @override
  String get chatPollOptionsLabel => 'పోల్ ఎంపికలు';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'ఎంపిక $index';
  }

  @override
  String get chatAddOptionButton => 'ఎంపికను జోడించండి';

  @override
  String get chatPollSettingsLabel => 'పోల్ సెట్టింగ్‌లు';

  @override
  String get chatSelectionType => 'ఎంపిక రకం';

  @override
  String get chatSingleChoiceLabel => 'సింగిల్';

  @override
  String get chatMultiChoiceLabel => 'బహుళ';

  @override
  String get chatAnonymousPollSwitch => 'అనామక పోల్';

  @override
  String get chatPleaseEnterQuestion => 'దయచేసి పోల్ ప్రశ్నను నమోదు చేయండి';

  @override
  String get chatAtLeastTwoOptions => 'కనీసం 2 ఎంపికలు అవసరం';

  @override
  String chatConfirmWithCount(int count) {
    return 'నిర్ధారించండి ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'ఇమెయిల్ ధృవీకరణ';

  @override
  String get authEnterValidEmailAddress =>
      'దయచేసి చెల్లుబాటు అయ్యే ఇమెయిల్ చిరునామాను నమోదు చేయండి';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'ధృవీకరణ కోడ్ $emailకి పంపబడింది';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'కోడ్‌ని పంపడంలో విఫలమైంది: $error';
  }

  @override
  String get authVerificationSuccess => 'ధృవీకరణ విజయవంతమైంది';

  @override
  String get authVerificationFailed => 'ధృవీకరణ విఫలమైంది';

  @override
  String authVerificationCodeError(String error) {
    return 'ధృవీకరణ కోడ్ లోపం: $error';
  }

  @override
  String get commonEnterVerificationCode => 'ధృవీకరణ కోడ్‌ను నమోదు చేయండి';

  @override
  String get authEnterYourEmail => 'ఇమెయిల్‌ని నమోదు చేయండి';

  @override
  String authWeSentCodeTo(String email) {
    return 'మేము 6 అంకెల కోడ్‌ని పంపాము\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'మీ ఇమెయిల్ చిరునామాను నమోదు చేయండి, మేము ధృవీకరణ కోడ్‌ని పంపుతాము';

  @override
  String get commonSendVerificationCode => 'ధృవీకరణ కోడ్‌ని పంపండి';

  @override
  String get authResendVerificationCode => 'ధృవీకరణ కోడ్‌ని మళ్లీ పంపండి';

  @override
  String authCanResendAfter(int seconds) {
    return '$seconds సెకన్ల తర్వాత మళ్లీ పంపవచ్చు';
  }

  @override
  String get commonChangeEmail => 'ఇమెయిల్ మార్చండి';

  @override
  String get contactAddToContacts => 'పరిచయాలకు జోడించండి';

  @override
  String get contactAddingToContacts => 'జోడిస్తోంది...';

  @override
  String get contactAddedToContacts => 'పరిచయాలకు జోడించబడింది';

  @override
  String contactAddFailedWithError(String error) {
    return 'జోడించడం విఫలమైంది: $error';
  }

  @override
  String get contactAddPhone => 'ఫోన్ జోడించండి';

  @override
  String get contactAddTag => 'ట్యాగ్‌లను జోడించండి';

  @override
  String get contactAddText => 'వచనాన్ని జోడించండి';

  @override
  String get contactAddPhoto => 'ఫోటోను జోడించండి';

  @override
  String contactGroupCountLabel(int count) {
    return '$count సమూహాలు';
  }

  @override
  String get contactAddedViaSearch => 'శోధన ద్వారా జోడించబడింది';

  @override
  String get contactAddTime => 'సమయాన్ని జోడించండి';

  @override
  String get contactDoneButton => 'పూర్తయింది';

  @override
  String get callWaitingForParticipants => 'పాల్గొనేవారి కోసం వేచి ఉంది...';

  @override
  String callParticipantMe(String name) {
    return '$name (నేను)';
  }

  @override
  String get callSharingLabel => 'భాగస్వామ్యం';

  @override
  String callScreenSharingBy(String name) {
    return '$name స్క్రీన్‌ను షేర్ చేస్తోంది';
  }

  @override
  String callParticipantCount(int count) {
    return '$count పాల్గొనేవారు';
  }

  @override
  String get callMuteLabel => 'మ్యూట్ చేయండి';

  @override
  String get callUnmuteLabel => 'అన్‌మ్యూట్ చేయండి';

  @override
  String get callTurnOffVideo => 'వీడియోను ఆఫ్ చేయండి';

  @override
  String get callTurnOnVideo => 'వీడియోను ఆన్ చేయండి';

  @override
  String get callShareScreen => 'స్క్రీన్ షేర్ చేయండి';

  @override
  String get callStopSharing => 'భాగస్వామ్యం చేయడం ఆపివేయండి';

  @override
  String get callSwitchCameraLabel => 'మారండి';

  @override
  String get callLeaveLabel => 'వదిలేయండి';

  @override
  String get callParticipantsLabel => 'పాల్గొనేవారు';

  @override
  String get callJoiningMeeting => 'సమావేశంలో చేరుతున్నారు...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count ఓట్లు ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count పాల్గొనేవారు';
  }

  @override
  String get chatNoMediaUrlAvailable => 'మీడియా URL అందుబాటులో లేదు';

  @override
  String chatDownloadFailed(String code) {
    return 'డౌన్‌లోడ్ విఫలమైంది: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return 'లోపం: $message';
  }

  @override
  String get chatMusicLinkLabel => 'సంగీతం లింక్';

  @override
  String get chatRedPacketTransferCannotForward =>
      'ఎరుపు ప్యాకెట్లు మరియు బదిలీలు ఫార్వార్డ్ చేయబడవు';

  @override
  String commonShareFailed(String error) {
    return 'భాగస్వామ్యం విఫలమైంది: $error';
  }

  @override
  String get commonTapToRetry => 'మళ్లీ ప్రయత్నించడానికి నొక్కండి';

  @override
  String get chatDefaultRedPacketGreeting => 'శ్రేయస్సు కోసం శుభాకాంక్షలు';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'శోధించడానికి మరియు చేరడానికి ఇతరులను అనుమతించండి';

  @override
  String get groupConfirmClearChatHistory =>
      'మీరు ఖచ్చితంగా చాట్ చరిత్రను క్లియర్ చేయాలనుకుంటున్నారా?';

  @override
  String get groupCreateGroupToChat =>
      'చాటింగ్ ప్రారంభించడానికి ఒక సమూహాన్ని సృష్టించండి';

  @override
  String get groupEditGroupAnnouncement => 'సమూహ ప్రకటనను సవరించండి';

  @override
  String get groupEditGroupDescription => 'సమూహ వివరణను సవరించండి';

  @override
  String get groupEnterGroupAnnouncement => 'సమూహ ప్రకటనను నమోదు చేయండి';

  @override
  String groupMemberCountClickToCopy(Object count) {
    return '$count సభ్యులు, గ్రూప్ IDని కాపీ చేయడానికి క్లిక్ చేయండి';
  }

  @override
  String get groupNoPermissionToEditGroupName =>
      'సమూహం పేరును సవరించడానికి మీకు అనుమతి లేదు';

  @override
  String get authEmailAddress => 'ఇమెయిల్ చిరునామా';

  @override
  String get commonEnterEmailAddress => 'ఇమెయిల్ చిరునామాను నమోదు చేయండి';

  @override
  String get authEmailRecoveryHint => 'పాస్‌వర్డ్ రికవరీ కోసం ఉపయోగించబడుతుంది';

  @override
  String get commonInvalidEmailFormat =>
      'దయచేసి చెల్లుబాటు అయ్యే ఇమెయిల్ చిరునామాను నమోదు చేయండి';

  @override
  String get authOptional => 'ఐచ్ఛికం';

  @override
  String get authResetPassword => 'పాస్‌వర్డ్‌ని రీసెట్ చేయండి';

  @override
  String get authEnterRegisteredEmail =>
      'మీరు నమోదు చేసుకున్న ఇమెయిల్ చిరునామాను నమోదు చేయండి';

  @override
  String get authSendResetCode => 'రీసెట్ కోడ్‌ని పంపండి';

  @override
  String authResetCodeSent(String email) {
    return 'రీసెట్ కోడ్ $emailకి పంపబడింది';
  }

  @override
  String get authEnterResetCode => 'రీసెట్ కోడ్‌ని నమోదు చేయండి';

  @override
  String get authSetNewPassword => 'కొత్త పాస్‌వర్డ్‌ని సెట్ చేయండి';

  @override
  String get commonConfirmNewPassword => 'కొత్త పాస్‌వర్డ్‌ని నిర్ధారించండి';

  @override
  String get commonNewPassword => 'కొత్త పాస్‌వర్డ్';

  @override
  String get authPasswordResetSuccess =>
      'పాస్‌వర్డ్ రీసెట్ విజయవంతమైంది. దయచేసి మీ కొత్త పాస్‌వర్డ్‌తో లాగిన్ చేయండి.';

  @override
  String get authResetPasswordFailed => 'పాస్‌వర్డ్ రీసెట్ చేయడం విఫలమైంది';

  @override
  String get settingsChangePassword => 'పాస్‌వర్డ్ మార్చండి';

  @override
  String get settingsCurrentPassword => 'ప్రస్తుత పాస్వర్డ్';

  @override
  String get settingsEnterCurrentPassword =>
      'ప్రస్తుత పాస్వర్డ్ను నమోదు చేయండి';

  @override
  String get settingsEnterNewPassword => 'కొత్త పాస్‌వర్డ్‌ను నమోదు చేయండి';

  @override
  String get settingsPasswordChanged =>
      'పాస్‌వర్డ్ విజయవంతంగా మార్చబడింది. దయచేసి మీ కొత్త పాస్‌వర్డ్‌తో లాగిన్ చేయండి.';

  @override
  String get settingsChangePasswordFailed => 'పాస్‌వర్డ్ మార్చడం విఫలమైంది';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'కొత్త పాస్‌వర్డ్ తప్పనిసరిగా ప్రస్తుత పాస్‌వర్డ్‌కి భిన్నంగా ఉండాలి';

  @override
  String get settingsChangePasswordInfo =>
      'పాస్‌వర్డ్ మార్చిన తర్వాత, మీరు లాగ్ అవుట్ చేయబడతారు మరియు కొత్త పాస్‌వర్డ్‌తో లాగిన్ అవ్వాలి.';

  @override
  String get settingsPasswordRequirements => 'పాస్‌వర్డ్ అవసరాలు:';

  @override
  String get settingsSecurityNote =>
      'భద్రత కోసం, మీరు పాస్‌వర్డ్‌ని మార్చిన తర్వాత అన్ని పరికరాలలో మళ్లీ లాగిన్ చేయాలి.';

  @override
  String get settingsSecurity => 'భద్రత';

  @override
  String get settingsCurrentBoundEmail => 'ప్రస్తుత బౌండ్ ఇమెయిల్';

  @override
  String get settingsNewEmailAddress => 'కొత్త ఇమెయిల్ చిరునామా';

  @override
  String get settingsEnterNewEmail => 'కొత్త ఇమెయిల్ చిరునామాను నమోదు చేయండి';

  @override
  String get settingsVerificationCode => 'ధృవీకరణ కోడ్';

  @override
  String get settingsVerificationCodeSent => 'ధృవీకరణ కోడ్ పంపబడింది';

  @override
  String get settingsCodeSentTo => 'ధృవీకరణ కోడ్ పంపబడింది';

  @override
  String get settingsDidNotReceiveCode => 'కోడ్ అందలేదా?';

  @override
  String get settingsEmailChangedSuccess => 'ఇమెయిల్ విజయవంతంగా మార్చబడింది';

  @override
  String get settingsChangeEmailFailed => 'ఇమెయిల్ మార్పు విఫలమైంది';

  @override
  String get settingsEmailSecurityNote =>
      'మీ ఇమెయిల్ పాస్‌వర్డ్ రికవరీ కోసం ఉపయోగించబడుతుంది. దయచేసి దానిని సురక్షితంగా ఉంచండి.';

  @override
  String get commonGoogleLogin => 'Googleతో సైన్ ఇన్ చేయండి';

  @override
  String get commonAppleLogin => 'Appleతో సైన్ ఇన్ చేయండి';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'భాష';

  @override
  String get settingsLanguageChanged => 'భాష మారింది';

  @override
  String get settingsTranslation => 'అనువాదం';

  @override
  String get settingsTranslateTextTo => 'వచనాన్ని అనువదించండి';

  @override
  String get settingsTranslateDescription =>
      'మీరు సందేశాలను అనువదించాలనుకుంటున్న భాషను ఎంచుకోండి.';

  @override
  String get settingsAutoTranslate =>
      'అందుకున్న సందేశాలను స్వయంచాలకంగా అనువదించండి';

  @override
  String get settingsAutoTranslateDescription =>
      'చాట్‌లో స్వీకరించిన సందేశాలను మీరు ఎంచుకున్న భాషకు స్వయంచాలకంగా అనువదించండి.';

  @override
  String get settingsBiometricLogin => 'బయోమెట్రిక్ లాగిన్';

  @override
  String authLoginWithBiometric(Object type) {
    return '$typeతో లాగిన్ చేయండి';
  }

  @override
  String get settingsBiometricLoginEnabled =>
      'బయోమెట్రిక్ లాగిన్ ప్రారంభించబడింది';

  @override
  String get settingsBiometricLoginDisabled =>
      'బయోమెట్రిక్ లాగిన్ నిలిపివేయబడింది';

  @override
  String get settingsEnableBiometricLogin =>
      'బయోమెట్రిక్ లాగిన్‌ని ప్రారంభించండి';

  @override
  String get settingsBiometricEnabled =>
      'ప్రారంభించబడింది - లాగిన్ చేయడానికి బయోమెట్రిక్ ఉపయోగించండి';

  @override
  String get settingsBiometricDisabled =>
      'నిలిపివేయబడింది - ప్రారంభించడానికి నొక్కండి';

  @override
  String get settingsBiometricNeedRelogin =>
      'బయోమెట్రిక్ లాగిన్‌ని ప్రారంభించడానికి దయచేసి లాగ్ అవుట్ చేసి, మళ్లీ లాగిన్ చేయండి';

  @override
  String get authOr => 'లేదా';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'ఈ పరికరంలో కెమెరా యాక్సెస్ పరిమితం చేయబడింది';

  @override
  String get authPasskeyLabel => 'పాస్కీ';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'ఆపిల్';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get authSsoNotConfigured =>
      'ఈ సర్వర్ SSO లాగిన్ ప్రొవైడర్‌లను కాన్ఫిగర్ చేయలేదు';

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
  String get profileEnterPokeSuffixHint =>
      'పోక్ ప్రత్యయాన్ని నమోదు చేయండి, ఉదా: భుజంపై';

  @override
  String get groupAlbum => 'సమూహ ఆల్బమ్';

  @override
  String get groupFiles => 'సమూహ ఫైల్‌లు';

  @override
  String get groupImages => 'చిత్రాలు';

  @override
  String get groupVideos => 'వీడియోలు';

  @override
  String get groupTotal => 'మొత్తం';

  @override
  String get groupSize => 'పరిమాణం';

  @override
  String get groupNoMedia => 'మీడియా లేదు';

  @override
  String get groupNoMediaDescription =>
      'ఈ సమూహంలో ఇంకా ఫోటోలు లేదా వీడియోలు లేవు';

  @override
  String get groupDocuments => 'డాక్స్';

  @override
  String get groupNoFiles => 'ఫైల్‌లు లేవు';

  @override
  String get groupNoFilesDescription => 'ఈ గుంపులో ఇంకా ఫైల్‌లు లేవు';

  @override
  String groupDownloadStarted(String filename) {
    return '$filename డౌన్‌లోడ్ చేస్తోంది...';
  }

  @override
  String get contactNoCommonGroups => 'సాధారణ సమూహాలు లేవు';

  @override
  String get contactNoCommonGroupsDescription =>
      'మీకు ఉమ్మడిగా సమూహాలు ఏవీ లేవు';

  @override
  String get chatVoiceMessage => 'వాయిస్';

  @override
  String get chatMessage => 'సందేశం';

  @override
  String get conversationHideChat => 'దాచు';

  @override
  String get settingsQuickReply => 'శీఘ్ర ప్రత్యుత్తరం';

  @override
  String get commonTranslate => 'అనువదించు';

  @override
  String get contactCreateTag => 'ట్యాగ్‌ని సృష్టించండి';

  @override
  String get contactEnterTagName => 'ట్యాగ్ పేరును నమోదు చేయండి';

  @override
  String get contactEditTag => 'ట్యాగ్‌ని సవరించండి';

  @override
  String get contactDeleteTag => 'ట్యాగ్‌ని తొలగించండి';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'మీరు \"$tagName\" ట్యాగ్‌ని ఖచ్చితంగా తొలగించాలనుకుంటున్నారా?';
  }

  @override
  String get contactNoTags => 'ఇంకా ట్యాగ్‌లు లేవు';

  @override
  String get contactFriendPermissions => 'స్నేహితుని అనుమతులు';

  @override
  String get contactSetChatOnly => 'చాట్-మాత్రమేగా సెట్ చేయండి';

  @override
  String get contactChatOnlyDesc =>
      'మీతో మాత్రమే చాట్ చేయగలరు, ఇతర కంటెంట్ దాచబడుతుంది';

  @override
  String get contactHideMyMoments => 'నా క్షణాలను దాచు';

  @override
  String get contactHideMyMomentsDesc => 'ఈ స్నేహితుడు నా క్షణాలను చూడలేరు';

  @override
  String get contactHideTheirMoments => 'వారి క్షణాలను దాచండి';

  @override
  String get contactHideTheirMomentsDesc => 'ఈ స్నేహితుడి మూమెంట్స్ చూడవద్దు';

  @override
  String get contactHideMyStatus => 'నా స్థితిని దాచు';

  @override
  String get contactHideMyStatusDesc =>
      'ఈ స్నేహితుడు నా స్థితి నవీకరణలను చూడలేరు';

  @override
  String get contactNoChatOnlyFriends => 'చాట్-మాత్రమే స్నేహితులు లేరు';

  @override
  String get contactNoOfficialAccounts => 'అధికారిక ఖాతాలు లేవు';

  @override
  String get contactFollowOfficialAccountsDesc =>
      'తాజా అప్‌డేట్‌లను పొందడానికి అధికారిక ఖాతాలను అనుసరించండి';

  @override
  String get contactNoServiceAccounts => 'సేవా ఖాతాలు లేవు';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      'అనుకూలమైన సేవల కోసం సేవా ఖాతాలకు సభ్యత్వాన్ని పొందండి';

  @override
  String get contactNoEnterpriseContacts => 'ఎంటర్‌ప్రైజ్ పరిచయాలు లేవు';

  @override
  String get contactEnterpriseContactsDesc =>
      'ఎంటర్‌ప్రైజ్ పరిచయాలు ఇక్కడ ప్రదర్శించబడతాయి';

  @override
  String get profileCardPack => 'కార్డ్ ప్యాక్';

  @override
  String get profileOrders => 'ఆర్డర్లు';

  @override
  String get profileNoOrders => 'ఆదేశాలు లేవు';

  @override
  String get profileOrdersDesc => 'మీ ఆర్డర్‌లు ఇక్కడ ప్రదర్శించబడతాయి';

  @override
  String get profileNoCards => 'కార్డులు లేవు';

  @override
  String get profileCardsDesc => 'మీ కార్డ్‌లు ఇక్కడ ప్రదర్శించబడతాయి';

  @override
  String get favoriteEnterTagsHint =>
      'కామాలతో వేరు చేయబడిన ట్యాగ్‌లను నమోదు చేయండి';

  @override
  String get favoriteTagsUpdated => 'ట్యాగ్‌లు నవీకరించబడ్డాయి';

  @override
  String get favoriteForwardedContent => 'కంటెంట్ ఫార్వార్డ్ చేయబడింది';

  @override
  String get favoriteEnterNoteContent => 'గమనిక కంటెంట్‌ని నమోదు చేయండి';

  @override
  String get favoriteNoteAdded => 'గమనిక జోడించబడింది';

  @override
  String get favoriteLinkTitle => 'లింక్ శీర్షిక';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'లింక్ జోడించబడింది';

  @override
  String get contactPhotoAdded => 'ఫోటో జోడించబడింది';

  @override
  String get contactEnterPhone => 'ఫోన్ నంబర్‌ను నమోదు చేయండి';

  @override
  String commonConversationWithId(Object roomId) {
    return 'సంభాషణ: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return 'సంప్రదించండి: $userId';
  }

  @override
  String get commonDiscover => 'కనుగొనండి';

  @override
  String commonDeveloping(Object title) {
    return '$title\n(త్వరలో వస్తుంది)';
  }

  @override
  String get commonPageNotFound => 'పేజీ కనుగొనబడలేదు';

  @override
  String get commonBackToHome => 'ఇంటికి తిరిగి వెళ్ళు';

  @override
  String get settingsMessageNotifications => 'సందేశ నోటిఫికేషన్‌లు';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'కొత్త సందేశ నోటిఫికేషన్‌లను స్వీకరించండి';

  @override
  String get settingsShowMessagePreview => 'సందేశ ప్రివ్యూను చూపు';

  @override
  String get settingsShowMessageContentInNotification =>
      'నోటిఫికేషన్‌లో సందేశ కంటెంట్‌ని చూపండి';

  @override
  String get settingsNotificationSound => 'నోటిఫికేషన్ సౌండ్';

  @override
  String get settingsPlaySoundOnMessage =>
      'సందేశాలను స్వీకరించేటప్పుడు ధ్వనిని ప్లే చేయండి';

  @override
  String get commonVibration => 'కంపనం';

  @override
  String get settingsVibrateOnMessage =>
      'సందేశాలను స్వీకరించేటప్పుడు వైబ్రేట్ చేయండి';

  @override
  String get settingsDoNotDisturbMode => 'డిస్టర్బ్ చేయవద్దు';

  @override
  String get settingsDoNotDisturbDescription =>
      'నిర్దిష్ట సమయంలో నోటిఫికేషన్‌లను స్వీకరించవద్దు';

  @override
  String get settingsStartTime => 'ప్రారంభ సమయం';

  @override
  String get settingsEndTime => 'ముగింపు సమయం';

  @override
  String get settingsDeleteQuickReply => 'త్వరిత ప్రత్యుత్తరాన్ని తొలగించండి';

  @override
  String get settingsEditQuickReply => 'త్వరిత ప్రత్యుత్తరాన్ని సవరించండి';

  @override
  String get settingsAddQuickReply => 'త్వరిత ప్రత్యుత్తరాన్ని జోడించండి';

  @override
  String get settingsManageQuickReplies =>
      'త్వరిత ప్రత్యుత్తరాలను నిర్వహించండి';

  @override
  String get settingsNoQuickReplies => 'త్వరిత సమాధానాలు లేవు';

  @override
  String get settingsDefaultQuickReplies =>
      'డిఫాల్ట్ త్వరిత ప్రత్యుత్తరాలు చూపబడతాయి';

  @override
  String get settingsWhoCanSee => 'ఎవరు చూడగలరు';

  @override
  String get settingsLastSeen => 'చివరిగా చూసింది';

  @override
  String get settingsHiddenChats => 'దాచిన చాట్‌లు';

  @override
  String get settingsMessagesLabel => 'సందేశాలు';

  @override
  String get settingsAllowStrangerMessages => 'అపరిచిత సందేశాలను అనుమతించండి';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'కాని పరిచయాల నుండి సందేశాలను స్వీకరించండి';

  @override
  String get settingsReadReceipts => 'రసీదులను చదవండి';

  @override
  String get settingsLetOthersKnowYouRead =>
      'మీరు చదివినట్లు ఇతరులకు తెలియజేయండి';

  @override
  String get settingsTypingIndicator => 'టైపింగ్ సూచిక';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'మీరు టైప్ చేస్తున్నారని ఇతరులకు తెలియజేయండి';

  @override
  String get settingsEveryone => 'అందరూ';

  @override
  String get settingsContactsOnly => 'పరిచయాలు మాత్రమే';

  @override
  String get settingsNobody => 'ఎవరూ';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return '$titleని ఎవరు చూడగలరు';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'వెర్షన్ $version';
  }

  @override
  String get settingsCheckForUpdates => 'నవీకరణల కోసం తనిఖీ చేయండి';

  @override
  String get settingsOpenSourceLicenses => 'ఓపెన్ సోర్స్ లైసెన్స్‌లు';

  @override
  String get settingsFeedbackAndSuggestions => 'అభిప్రాయం మరియు సూచనలు';

  @override
  String get settingsBuiltOnMatrix =>
      'మ్యాట్రిక్స్ ప్రోటోకాల్‌పై నిర్మించబడింది';

  @override
  String get settingsNoHiddenChats => 'దాచిన చాట్‌లు లేవు';

  @override
  String get settingsNoHiddenChatsDescription =>
      'మీరు దాచిన చాట్‌లు ఇక్కడ కనిపిస్తాయి';

  @override
  String get settingsUnhideChat => 'దాచిపెట్టు';

  @override
  String get settingsDarkMode => 'డార్క్ మోడ్';

  @override
  String get settingsFontSize => 'ఫాంట్ పరిమాణం';

  @override
  String get settingsBubbleStyle => 'బబుల్ శైలి';

  @override
  String get settingsFollowSystem => 'వ్యవస్థను అనుసరించండి';

  @override
  String get settingsAutoSwitchBySystem => 'సిస్టమ్ ద్వారా ఆటో స్విచ్';

  @override
  String get settingsLightMode => 'లైట్ మోడ్';

  @override
  String get settingsAlwaysUseLightTheme =>
      'ఎల్లప్పుడూ లైట్ థీమ్‌ని ఉపయోగించండి';

  @override
  String get settingsDarkModeOption => 'డార్క్ మోడ్ ఎంపిక';

  @override
  String get settingsAlwaysUseDarkTheme =>
      'ఎల్లప్పుడూ డార్క్ థీమ్‌ని ఉపయోగించండి';

  @override
  String get settingsFontSizeSmall => 'చిన్నది';

  @override
  String get settingsFontSizeStandard => 'ప్రామాణికం';

  @override
  String get settingsFontSizeLarge => 'పెద్దది';

  @override
  String get settingsFontSizeExtraLarge => 'అదనపు పెద్దది';

  @override
  String get settingsBubbleStyleWechat => 'WeChat శైలి';

  @override
  String get settingsBubbleStyleWechatDesc => 'క్లాసిక్ WeChat బబుల్ శైలి';

  @override
  String get settingsBubbleStyleModern => 'ఆధునిక శైలి';

  @override
  String get settingsBubbleStyleModernDesc =>
      'ఆధునిక బబుల్ శైలిని శుభ్రం చేయండి';

  @override
  String get settingsBubbleStyleClassic => 'క్లాసిక్ శైలి';

  @override
  String get settingsBubbleStyleClassicDesc => 'సాంప్రదాయ బబుల్ శైలి';

  @override
  String get discoverVideoChannels => 'ఛానెల్‌లు';

  @override
  String get discoverLive => 'ప్రత్యక్షం';

  @override
  String get discoverListen => 'వినండి';

  @override
  String get discoverWatch => 'చూడండి';

  @override
  String get discoverSearchDiscover => 'శోధించండి';

  @override
  String get discoverNearbyPeople => 'సమీపంలో';

  @override
  String get discoverGames => 'ఆటలు';

  @override
  String get discoverMiniPrograms => 'మినీ ప్రోగ్రామ్‌లు';

  @override
  String get chatAlreadyInCall => 'ఇప్పటికే కాల్‌లో ఉన్నారు';

  @override
  String get commonConnectionFailed => 'కనెక్షన్ విఫలమైంది';

  @override
  String get chatCallRejected => 'కాల్ తిరస్కరించబడింది';

  @override
  String get chatNoAnswer => 'సమాధానం లేదు';

  @override
  String get commonClose => 'మూసివేయి';

  @override
  String get chatSelectContact => 'పరిచయాన్ని ఎంచుకోండి';

  @override
  String get chatVoteRemoved => 'ఓటు తీసివేయబడింది';

  @override
  String get chatVoteChanged => 'ఓటు మారింది';

  @override
  String get chatVoted => 'ఓటు వేశారు';

  @override
  String chatReplyTo(String name) {
    return '$nameకి ప్రత్యుత్తరం ఇవ్వండి';
  }

  @override
  String get chatCurrentLocation => 'ప్రస్తుత స్థానం';

  @override
  String chatNearbyPlace(int index) {
    return 'సమీప స్థలం $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return '$distance గురించి';
  }

  @override
  String get chatAddress => 'చిరునామా';

  @override
  String get chatLatitude => 'అక్షాంశం';

  @override
  String get chatLongitude => 'రేఖాంశం';

  @override
  String get groupDescriptionUpdated => 'సమూహ వివరణ నవీకరించబడింది';

  @override
  String get groupAvatarUpdated => 'సమూహ అవతార్ నవీకరించబడింది';

  @override
  String get groupVisibilityUpdated => 'సమూహ దృశ్యమానత నవీకరించబడింది';

  @override
  String get groupChannelCreated => 'ఛానెల్ సృష్టించబడింది';

  @override
  String get groupChannelUpdated => 'ఛానెల్ నవీకరించబడింది';

  @override
  String get groupChannelDeleted => 'ఛానెల్ తొలగించబడింది';

  @override
  String get callDecline => 'తిరస్కరించు';

  @override
  String get callAnswer => 'సమాధానం';

  @override
  String get callIncomingVideoCall => 'ఇన్‌కమింగ్ వీడియో కాల్';

  @override
  String get callIncomingVoiceCall => 'ఇన్‌కమింగ్ వాయిస్ కాల్';

  @override
  String get callVideoCallInProgress => 'వీడియో కాల్ ప్రోగ్రెస్‌లో ఉంది';

  @override
  String get callVoiceCallInProgress => 'వాయిస్ కాల్ ప్రోగ్రెస్‌లో ఉంది';

  @override
  String get callReconnectingCall => 'మళ్లీ కనెక్ట్ అవుతోంది...';

  @override
  String get callEnded => 'కాల్ ముగిసింది';

  @override
  String get callFailed => 'కాల్ విఫలమైంది';

  @override
  String get callLivekitNotConfigured => 'LiveKit కాన్ఫిగర్ చేయబడలేదు';

  @override
  String callJoinMeetingFailed(Object error) {
    return 'సమావేశంలో చేరడం విఫలమైంది: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return 'స్క్రీన్ భాగస్వామ్యం విఫలమైంది: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 బీన్';

  @override
  String get profileNoN42Bean => 'N42 బీన్ లేదు';

  @override
  String get profileN42BeanDetails => 'N42 బీన్ వివరాలు';

  @override
  String get profileN42BeanDescription =>
      'N42 బీన్ అనేది N42లో వర్చువల్ అంశాలు మరియు సేవలను రీడీమ్ చేయడానికి ఉపయోగించే టోకెన్. ప్రస్తుతం అందుబాటులో ఉంది:';

  @override
  String get profileN42BeanFeature1 =>
      'ప్రత్యేకమైన సభ్యుల స్టిక్కర్లు మరియు థీమ్‌లు';

  @override
  String get profileN42BeanFeature2 => 'చాట్ బబుల్ అనుకూలీకరణ';

  @override
  String get profileN42BeanFeature3 => 'రెడ్ ప్యాకెట్ కవర్ అనుకూలీకరణ';

  @override
  String get profileN42BeanFeature4 => 'ప్రత్యేకమైన మారుపేరు బ్యాడ్జ్';

  @override
  String get profileN42BeanFeature5 => 'సమూహ చాట్ అధికారాలు';

  @override
  String get profileN42BeanFeature6 => 'క్లౌడ్ నిల్వ విస్తరణ';

  @override
  String get profileN42BeanFeature7 => 'వీడియో కాల్ బ్యూటీ ఫిల్టర్‌లు';

  @override
  String get profileN42BeanFeature8 => 'క్షణాల నేపథ్య అనుకూలీకరణ';

  @override
  String get profileN42BeanFeature9 => 'VIP కస్టమర్ సేవ ప్రాధాన్యత';

  @override
  String get profileGotIt => 'అర్థమైంది';

  @override
  String get profileNoN42BeanRecords => 'N42 బీన్ రికార్డులు లేవు';

  @override
  String get profileMoodAndThoughts => 'మూడ్ & ఆలోచనలు';

  @override
  String get profileStatusHappy => 'సంతోషం';

  @override
  String get profileStatusCracked => 'పగిలిపోయింది';

  @override
  String get profileStatusLucky => 'అదృష్టవంతుడు';

  @override
  String get profileStatusSunny => 'సన్నీ';

  @override
  String get profileStatusTired => 'అలసిపోయింది';

  @override
  String get profileStatusDaydream => 'పగటి కల';

  @override
  String get profileStatusRushing => 'పరుగెత్తుతోంది';

  @override
  String get profileStatusOverthinking => 'అతిగా ఆలోచించడం';

  @override
  String get profileStatusEnergized => 'శక్తివంతమైంది';

  @override
  String get profileWorkAndStudy => 'పని & అధ్యయనం';

  @override
  String get profileStatusWorking => 'పని చేస్తోంది';

  @override
  String get profileStatusStudying => 'చదువుతున్నారు';

  @override
  String get profileStatusBusy => 'బిజీ';

  @override
  String get profileStatusSlacking => 'స్లాకింగ్';

  @override
  String get profileStatusTraveling => 'ప్రయాణిస్తున్నాను';

  @override
  String get profileStatusGoingHome => 'ఇంటికి వెళుతున్నాను';

  @override
  String get profileStatusDnd => 'డిస్టర్బ్ చేయవద్దు';

  @override
  String get profileActivities => 'కార్యకలాపాలు';

  @override
  String get profileStatusHanging => 'హ్యాంగ్ అవుట్';

  @override
  String get profileStatusCheckIn => 'చెక్ ఇన్ చేయండి';

  @override
  String get profileStatusExercising => 'వ్యాయామం చేస్తున్నారు';

  @override
  String get profileStatusCoffee => 'కాఫీ';

  @override
  String get profileStatusBubbleTea => 'బబుల్ టీ';

  @override
  String get profileStatusEating => 'తినడం';

  @override
  String get profileStatusParenting => 'పేరెంటింగ్';

  @override
  String get profileStatusSavingWorld => 'ప్రపంచాన్ని కాపాడుతోంది';

  @override
  String get profileStatusSelfie => 'సెల్ఫీ';

  @override
  String get profileRest => 'విశ్రాంతి';

  @override
  String get profileStatusRetreat => 'తిరోగమనం';

  @override
  String get profileStatusHome => 'హోమ్';

  @override
  String get profileStatusSleeping => 'నిద్రపోతున్నాను';

  @override
  String get profileStatusCatLover => 'పిల్లి ప్రేమికుడు';

  @override
  String get profileStatusDogWalking => 'వాకింగ్ డాగ్';

  @override
  String get profileStatusGaming => 'గేమింగ్';

  @override
  String get profileStatusListening => 'వింటున్నాను';

  @override
  String get profileEditAddress => 'చిరునామాను సవరించండి';

  @override
  String get profileRecipient => 'గ్రహీత';

  @override
  String get profileEnterRecipientName => 'గ్రహీత పేరును నమోదు చేయండి';

  @override
  String get profilePhoneNumber => 'ఫోన్ నంబర్';

  @override
  String get profileEnterPhoneNumber => 'ఫోన్ నంబర్‌ను నమోదు చేయండి';

  @override
  String get profileRegionHint => 'ప్రావిన్స్/నగరం/జిల్లా';

  @override
  String get profileDetailedAddress => 'వివరణాత్మక చిరునామా';

  @override
  String get profileDetailedAddressHint => 'వీధి, భవనం సంఖ్య మొదలైనవి.';

  @override
  String get profileSetAsDefaultAddress => 'డిఫాల్ట్ చిరునామాగా సెట్ చేయండి';

  @override
  String get profilePleaseCompleteInfo =>
      'దయచేసి అన్ని ఫీల్డ్‌లను పూర్తి చేయండి';

  @override
  String get profileEditInvoice => 'ఇన్‌వాయిస్‌ని సవరించండి';

  @override
  String get profileInvoiceType => 'ఇన్వాయిస్ రకం';

  @override
  String get profileCompanyName => 'కంపెనీ పేరు';

  @override
  String get profilePersonalName => 'వ్యక్తిగత పేరు';

  @override
  String get profileEnterCompanyName => 'కంపెనీ పేరును నమోదు చేయండి';

  @override
  String get profileEnterName => 'పేరు నమోదు చేయండి';

  @override
  String get profileTaxIdNumber => 'పన్ను ID సంఖ్య';

  @override
  String get profileEnterTaxIdNumber => 'పన్ను ID నంబర్‌ను నమోదు చేయండి';

  @override
  String get profileBankNameOptional => 'బ్యాంక్ పేరు (ఐచ్ఛికం)';

  @override
  String get profileEnterBankName => 'బ్యాంక్ పేరును నమోదు చేయండి';

  @override
  String get profileBankAccountOptional => 'బ్యాంక్ ఖాతా (ఐచ్ఛికం)';

  @override
  String get profileEnterBankAccount => 'బ్యాంక్ ఖాతాను నమోదు చేయండి';

  @override
  String get profileCompanyAddressOptional => 'కంపెనీ చిరునామా (ఐచ్ఛికం)';

  @override
  String get profileEnterCompanyAddress => 'కంపెనీ చిరునామాను నమోదు చేయండి';

  @override
  String get profileCompanyPhoneOptional => 'కంపెనీ ఫోన్ (ఐచ్ఛికం)';

  @override
  String get profileEnterCompanyPhone => 'కంపెనీ ఫోన్‌ని నమోదు చేయండి';

  @override
  String get profileSetAsDefaultInvoice => 'డిఫాల్ట్ ఇన్‌వాయిస్‌గా సెట్ చేయండి';

  @override
  String get profileRingtoneVibrate => 'కంపించు';

  @override
  String get profileRingtoneSilent => 'నిశ్శబ్దం';

  @override
  String get profileVibrateMode => 'వైబ్రేట్ మోడ్';

  @override
  String get profileSilentMode => 'సైలెంట్ మోడ్';

  @override
  String profilePlayFailed(Object ringtoneName) {
    return 'ప్లే చేయడంలో విఫలమైంది: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
    return 'ప్లే చేస్తోంది: $ringtoneName';
  }

  @override
  String get profileStop => 'ఆపు';

  @override
  String get profileSelectRingtone => 'రింగ్‌టోన్‌ని ఎంచుకోండి';

  @override
  String get profileLoadingRingtones => 'రింగ్‌టోన్‌లను లోడ్ చేస్తోంది...';

  @override
  String get profileNoRingtonesFound => 'రింగ్‌టోన్‌లు ఏవీ కనుగొనబడలేదు';

  @override
  String mainMessagesWithCount(int count) {
    return 'సందేశాలు($count)';
  }

  @override
  String get storyViewers => 'వీక్షకులు';

  @override
  String get storyNoViewers => 'ఇంకా వీక్షకులు లేరు';

  @override
  String get storyReplyToStory => 'కథకు ప్రత్యుత్తరం ఇవ్వండి...';

  @override
  String get commonCopiedToClipboard => 'క్లిప్‌బోర్డ్‌కి కాపీ చేయబడింది';

  @override
  String get commonMore => 'మరిన్ని';

  @override
  String get commonTranslating => 'అనువదిస్తోంది...';

  @override
  String commonTranslatedFrom(String language) {
    return '$language నుండి అనువదించబడింది';
  }

  @override
  String get commonTranslation => 'అనువాదం';

  @override
  String get commonTranslationFailed => 'అనువాదం విఫలమైంది';

  @override
  String get commonAllRead => 'అన్నీ చదివారు';

  @override
  String commonReadCount(Object count) {
    return '$count చదివారు';
  }

  @override
  String get commonYouRecalledMessage =>
      'మీరు ఒక సందేశాన్ని గుర్తు చేసుకున్నారు';

  @override
  String get commonMessageRecalled => 'సందేశం గుర్తుకు వచ్చింది';

  @override
  String get commonReEdit => 'మళ్లీ సవరించండి';

  @override
  String get commonWalletArea => 'వాలెట్ ప్రాంతం';

  @override
  String get callIncomingCall => 'ఇన్‌కమింగ్ కాల్';

  @override
  String get callMissedCall => 'మిస్డ్ కాల్';

  @override
  String get groupRemoveAdmin => 'అడ్మిన్‌ని తీసివేయండి';

  @override
  String get chatSelectCurrency => 'కరెన్సీని ఎంచుకోండి';

  @override
  String get chatSelectEmoji => 'ఎమోజిని ఎంచుకోండి';

  @override
  String get chatSelectRedPacketCover => 'కవర్ ఎంచుకోండి';

  @override
  String get groupSetAsAdmin => 'అడ్మిన్‌గా సెట్ చేయండి';

  @override
  String get chatVideoPlaybackFailed => 'వీడియో ప్లేబ్యాక్ విఫలమైంది';

  @override
  String get groupViewProfile => 'ప్రొఫైల్‌ని వీక్షించండి';

  @override
  String get favoriteAddLinkComingSoon =>
      'లింక్ ఫీచర్‌ని జోడించు త్వరలో వస్తుంది';

  @override
  String get favoriteNewNoteComingSoon => 'కొత్త నోట్ ఫీచర్ త్వరలో రానుంది';

  @override
  String get qrcodeSaveFeatureComingSoon => 'సేవ్ ఫీచర్ త్వరలో వస్తుంది';

  @override
  String get qrcodeShareFeatureComingSoon => 'షేర్ ఫీచర్ త్వరలో వస్తుంది';

  @override
  String qrcodeProcessFailed(String error) {
    return 'QR కోడ్‌ని ప్రాసెస్ చేయడంలో విఫలమైంది: $error';
  }

  @override
  String get securityDeviceIdRequired => 'పరికర ID అవసరం';

  @override
  String securityVerificationStartFailed(String error) {
    return 'ధృవీకరణను ప్రారంభించడంలో విఫలమైంది: $error';
  }

  @override
  String get securityVerificationFailed => 'ధృవీకరణ విఫలమైంది';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return 'ధృవీకరణ విఫలమైంది: $reason';
  }

  @override
  String get securityEmojiMismatchRejected =>
      'ధృవీకరణ తిరస్కరించబడింది - ఎమోజి సరిపోలలేదు';

  @override
  String get securityWaitingForDeviceAccept =>
      'ఇతర పరికరం ఆమోదించడానికి వేచి ఉంది...';

  @override
  String get securityVerifyDevice => 'ఈ పరికరాన్ని ధృవీకరించండి';

  @override
  String get securityConfirmEmojiMatch =>
      'దిగువన ఉన్న ఎమోజీలు రెండు పరికరాలలో ఒకే క్రమంలో ప్రదర్శించబడతాయని నిర్ధారించండి';

  @override
  String get securityEmojiDontMatch => 'అవి సరిపోలడం లేదు';

  @override
  String get securityEmojiMatch => 'అవి సరిపోతాయి';

  @override
  String get securityWaitingForDeviceConfirm =>
      'ఇతర పరికరం నిర్ధారించడానికి వేచి ఉంది...';

  @override
  String get securityVerificationSuccess => 'ధృవీకరణ విజయవంతమైంది!';

  @override
  String get securityDeviceVerifiedTrusted =>
      'ఈ పరికరం ఇప్పుడు ధృవీకరించబడింది మరియు విశ్వసనీయమైనది.';

  @override
  String get securityCompareEmoji => 'రెండు పరికరాలలో ఎమోజీని సరిపోల్చండి';

  @override
  String get securityCompareNumbers =>
      'రెండు పరికరాల్లోని సంఖ్యలను సరిపోల్చండి';

  @override
  String get commonTryAgain => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get commonDone => 'పూర్తయింది';

  @override
  String get chatExportTitle => 'చాట్‌ని ఎగుమతి చేయండి';

  @override
  String get chatExportSuccess => 'ఎగుమతి విజయవంతమైంది';

  @override
  String chatExportFailed(String error) {
    return 'ఎగుమతి విఫలమైంది: $error';
  }

  @override
  String get chatExportFormat => 'ఎగుమతి ఫార్మాట్';

  @override
  String get chatExportHtmlDesc =>
      'స్టైల్ లేఅవుట్‌తో ఏదైనా బ్రౌజర్‌లో చదవగలిగేది';

  @override
  String get chatExportJsonDesc => 'మెషిన్-రీడబుల్ స్ట్రక్చర్డ్ డేటా ఫార్మాట్';

  @override
  String get chatExportDateRange => 'తేదీ పరిధి';

  @override
  String get chatExportAll => 'అన్ని సందేశాలు';

  @override
  String get chatExportLastWeek => 'గత 7 రోజులు';

  @override
  String get chatExportLastMonth => 'గత నెల';

  @override
  String get chatExportLast3Months => 'గత 3 నెలలు';

  @override
  String get chatExportMessageCount => 'ఎగుమతి చేయడానికి సందేశాలు';

  @override
  String get chatExportButton => 'ఎగుమతి & భాగస్వామ్యం చేయండి';

  @override
  String get chatMediaGallery => 'మీడియా గ్యాలరీ';

  @override
  String get chatExportHistory => 'చాట్ చరిత్రను ఎగుమతి చేయండి';

  @override
  String get pdfLoadFailed => 'PDFని లోడ్ చేయడంలో విఫలమైంది';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => 'అన్నీ';

  @override
  String get mediaImages => 'చిత్రాలు';

  @override
  String get mediaVideos => 'వీడియోలు';

  @override
  String get mediaFiles => 'ఫైళ్లు';

  @override
  String get mediaAudio => 'ఆడియో';

  @override
  String mediaItemsCount(int count) {
    return '$count అంశాలు';
  }

  @override
  String get mediaNoMediaFound => 'మీడియా ఏదీ కనుగొనబడలేదు';

  @override
  String get spacesTitle => 'సంఘాలు';

  @override
  String get spacesCreate => 'సంఘాన్ని సృష్టించండి';

  @override
  String get spacesJoined => 'చేరారు';

  @override
  String get spacesDiscover => 'కనుగొనండి';

  @override
  String get spacesNoJoined => 'ఇంకా సంఘాలు ఏవీ చేరలేదు';

  @override
  String get spacesExplore => 'సంఘాలను అన్వేషించండి';

  @override
  String get spacesNoPublic => 'పబ్లిక్ కమ్యూనిటీలు ఏవీ కనుగొనబడలేదు';

  @override
  String get spacesJoin => 'చేరండి';

  @override
  String get spacesSubSpaces => 'ఉప సంఘాలు';

  @override
  String get spacesChannels => 'ఛానెల్‌లు';

  @override
  String spacesMembersCount(int count) {
    return '$count సభ్యులు';
  }

  @override
  String get spacesPublic => 'పబ్లిక్';

  @override
  String get spacesPrivate => 'ప్రైవేట్';

  @override
  String get spacesSuggested => 'సూచించారు';

  @override
  String spacesChannelsCount(int count) {
    return '$count ఛానెల్‌లు';
  }

  @override
  String get callInCallChat => 'ఇన్-కాల్ చాట్';

  @override
  String callMessagesCount(int count) {
    return '$count సందేశాలు';
  }

  @override
  String get callNoMessagesYet =>
      'ఇంకా సందేశాలు లేవు.\nప్రారంభించడానికి సందేశాన్ని పంపండి.';

  @override
  String get callTypeMessage => 'సందేశాన్ని టైప్ చేయండి...';

  @override
  String get callYouSender => 'మీరు';

  @override
  String get callChatLabel => 'చాట్ చేయండి';

  @override
  String get chatEdited => 'సవరించబడింది';

  @override
  String get chatEditHistory => 'చరిత్రను సవరించండి';

  @override
  String get chatOriginalMessage => 'అసలైనది';

  @override
  String chatEditedAt(String time) {
    return '$timeలో సవరించబడింది';
  }

  @override
  String get chatViewOnce => 'ఒకసారి చూడండి';

  @override
  String get chatViewOncePhoto => 'ఒక్కసారి ఫోటో చూడండి';

  @override
  String get chatViewOnceVideo => 'ఒక్కసారి వీడియో చూడండి';

  @override
  String get chatViewOnceViewed => 'వీక్షించారు';

  @override
  String get chatViewOnceExpired => 'గడువు ముగిసింది';

  @override
  String get chatViewOnceTap => 'వీక్షించడానికి నొక్కండి';

  @override
  String get chatAutoFaceBlur => 'ఆటో ముఖం బ్లర్';

  @override
  String get chatAutoFaceBlurDesc =>
      'ఫోటోలను పంపేటప్పుడు ఆటోమేటిక్‌గా ముఖాలను బ్లర్ చేయండి';

  @override
  String get threadReplyInThread => 'థ్రెడ్‌లో ప్రత్యుత్తరం ఇవ్వండి';

  @override
  String threadReplies(int count) {
    return '$count ప్రత్యుత్తరాలు';
  }

  @override
  String get threadReply => '1 ప్రత్యుత్తరం';

  @override
  String threadLatestReply(String preview) {
    return 'తాజాది: $preview';
  }

  @override
  String get threadTitle => 'థ్రెడ్';

  @override
  String get threadReplyPlaceholder => 'థ్రెడ్‌లో ప్రత్యుత్తరం ఇవ్వండి...';

  @override
  String threadParticipants(int count) {
    return '$count పాల్గొనేవారు';
  }

  @override
  String get voiceRoomTitle => 'వాయిస్ రూమ్';

  @override
  String get voiceRoomCreate => 'వాయిస్ గదిని సృష్టించండి';

  @override
  String get voiceRoomJoin => 'చేరండి';

  @override
  String get voiceRoomLeave => 'వదిలేయండి';

  @override
  String get voiceRoomEnd => 'ముగింపు గది';

  @override
  String get voiceRoomRaiseHand => 'చేయి పైకెత్తండి';

  @override
  String get voiceRoomLowerHand => 'దిగువ చేయి';

  @override
  String get voiceRoomMute => 'మ్యూట్ చేయండి';

  @override
  String get voiceRoomUnmute => 'అన్‌మ్యూట్ చేయండి';

  @override
  String get voiceRoomHost => 'హోస్ట్';

  @override
  String get voiceRoomSpeakers => 'వక్తలు';

  @override
  String get voiceRoomListeners => 'శ్రోతలు';

  @override
  String get voiceRoomLive => 'ప్రత్యక్ష ప్రసారం';

  @override
  String get voiceRoomEnded => 'ముగిసింది';

  @override
  String get voiceRoomScheduled => 'షెడ్యూల్ చేయబడింది';

  @override
  String get voiceRoomApprove => 'ఆమోదించండి';

  @override
  String get voiceRoomDemote => 'శ్రోతకి తరలించండి';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name చేతులెత్తేసింది';
  }

  @override
  String get voiceRoomName => 'గది పేరు';

  @override
  String get voiceRoomTopic => 'అంశం (ఐచ్ఛికం)';

  @override
  String get voiceRoomNoActive => 'యాక్టివ్ వాయిస్ రూమ్‌లు లేవు';

  @override
  String get voiceRoomConnecting => 'కనెక్ట్ అవుతోంది...';

  @override
  String get usernameTitle => 'వినియోగదారు పేరు';

  @override
  String get usernameSet => 'వినియోగదారు పేరును సెట్ చేయండి';

  @override
  String get usernameChange => 'వినియోగదారు పేరు మార్చండి';

  @override
  String get usernamePlaceholder => 'వినియోగదారు పేరును నమోదు చేయండి';

  @override
  String get usernameAvailable => 'వినియోగదారు పేరు అందుబాటులో ఉంది';

  @override
  String get usernameUnavailable => 'వినియోగదారు పేరు ఇప్పటికే తీసుకోబడింది';

  @override
  String get usernameInvalid =>
      '3-30 అక్షరాలు, చిన్న అక్షరాలు, సంఖ్యలు, అండర్ స్కోర్. అక్షరంతో ప్రారంభించాలి.';

  @override
  String get usernameReserved => 'ఈ వినియోగదారు పేరు రిజర్వ్ చేయబడింది';

  @override
  String get usernameSaved => 'వినియోగదారు పేరు సేవ్ చేయబడింది';

  @override
  String get usernameSearchHint => '@username ద్వారా శోధించండి';

  @override
  String get ensName => 'ENS పేరు';

  @override
  String get ensLinked => 'ENSకి లింక్ చేయబడింది';

  @override
  String get ensResolving => 'ENS ని పరిష్కరిస్తోంది...';

  @override
  String get ensNotFound => 'ENS పేరు కనుగొనబడలేదు';

  @override
  String get tokenGateTitle => 'టోకెన్ గేట్';

  @override
  String get tokenGateEnable => 'టోకెన్ గేట్‌ని ప్రారంభించండి';

  @override
  String get tokenGateDisable => 'టోకెన్ గేట్‌ను నిలిపివేయండి';

  @override
  String get tokenGateAddRule => 'నియమాన్ని జోడించండి';

  @override
  String get tokenGateRemoveRule => 'నియమాన్ని తీసివేయండి';

  @override
  String get tokenGateContractAddress => 'కాంట్రాక్ట్ చిరునామా';

  @override
  String get tokenGateMinBalance => 'కనీస బ్యాలెన్స్';

  @override
  String get tokenGateTokenId => 'టోకెన్ ID (ERC-1155)';

  @override
  String get tokenGateChainId => 'చైన్ ID';

  @override
  String get tokenGateVerifying => 'టోకెన్ హోల్డింగ్‌లను ధృవీకరిస్తోంది...';

  @override
  String get tokenGateVerified => 'ధృవీకరణ ఆమోదించబడింది';

  @override
  String get tokenGateDenied => 'మీరు టోకెన్ అవసరాలను తీర్చలేదు';

  @override
  String get tokenGateOperatorAnd => 'అన్ని నియమాలకు అనుగుణంగా ఉండాలి';

  @override
  String get tokenGateOperatorOr => 'ఏదైనా నియమానికి అనుగుణంగా ఉండాలి';

  @override
  String get tokenGateRuleErc20 => 'ERC-20 టోకెన్';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => 'బహుళ-టోకెన్ (ERC-1155)';

  @override
  String get tokenGateRuleNative => 'స్థానిక టోకెన్';

  @override
  String get tokenGateSaved => 'టోకెన్ గేట్ సేవ్ చేయబడింది';

  @override
  String get tokenGateEnableDescription =>
      'చేరడానికి సభ్యులు టోకెన్‌లను కలిగి ఉండవలసి ఉంటుంది';

  @override
  String get tokenGateOperator => 'రూల్ లాజిక్';

  @override
  String get tokenGateRules => 'నియమాలు';

  @override
  String get tokenGateSymbol => 'చిహ్నం (ఐచ్ఛికం)';

  @override
  String get tokenGateChain => 'చైన్';

  @override
  String get tokenGateTokenStandard => 'టోకెన్ స్టాండర్డ్';

  @override
  String get tokenGateDenialMessage => 'తిరస్కరణ సందేశం';

  @override
  String get tokenGateDenialMessageHint =>
      'ధృవీకరణ విఫలమైనప్పుడు సందేశం చూపబడుతుంది';

  @override
  String get tokenGateVerifyTitle => 'టోకెన్ ధృవీకరణ';

  @override
  String get tokenGateVerifyPassed => 'ధృవీకరణ ఆమోదించబడింది';

  @override
  String get tokenGateVerifyFailed => 'ధృవీకరణ విఫలమైంది';

  @override
  String get tokenGateRetryVerify => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get tokenGateRequired => 'అవసరం';

  @override
  String get tokenGateYourBalance => 'మీ బ్యాలెన్స్';

  @override
  String get tokenGateRulesActive => 'నియమాలు చురుకుగా ఉంటాయి';

  @override
  String get tokenGateDisabled => 'వికలాంగుడు';

  @override
  String get ensNotBound => 'కట్టుబడి లేదు';

  @override
  String get liveLocation => 'ప్రత్యక్ష స్థానం';

  @override
  String get stopLiveLocation => 'భాగస్వామ్యం చేయడం ఆపు';

  @override
  String get startLiveLocation => 'భాగస్వామ్యం చేయడం ప్రారంభించండి';

  @override
  String get selectDuration => 'వ్యవధిని ఎంచుకోండి';

  @override
  String get groupChatFiles => 'చాట్ ఫైల్స్';

  @override
  String get groupLinks => 'లింకులు';

  @override
  String get groupNoLinks => 'ఇంకా లింక్‌లు లేవు';

  @override
  String get chatBackground => 'చాట్ నేపథ్యం';

  @override
  String get solidColors => 'ఘన రంగులు';

  @override
  String get gradients => 'ప్రవణతలు';

  @override
  String get defaultBackground => 'డిఫాల్ట్';

  @override
  String get settingsFontSizeSlider => 'ఫాంట్ పరిమాణం';

  @override
  String get autoDownload => 'ఆటో-డౌన్‌లోడ్';

  @override
  String get images => 'చిత్రాలు';

  @override
  String get voice => 'వాయిస్';

  @override
  String get video => 'వీడియో';

  @override
  String get files => 'ఫైళ్లు';

  @override
  String get mobileData => 'మొబైల్ డేటా';

  @override
  String get roaming => 'రోమింగ్';

  @override
  String get storageManagement => 'నిల్వ';

  @override
  String get totalUsage => 'మొత్తం వినియోగం';

  @override
  String get cache => 'కాష్';

  @override
  String get other => 'ఇతర';

  @override
  String get clearCache => 'కాష్‌ని క్లియర్ చేయండి';

  @override
  String get cacheCleared => 'కాష్ క్లియర్ చేయబడింది';

  @override
  String get clearCacheFailed => 'కాష్‌ని క్లియర్ చేయడంలో విఫలమైంది';

  @override
  String get confirmClearCache => 'మొత్తం కాష్ డేటాను క్లియర్ చేయాలా?';

  @override
  String get mapView => 'మ్యాప్ వీక్షణ';

  @override
  String liveLocationSharingCount(int count) {
    return '$count వ్యక్తులు స్థానాన్ని భాగస్వామ్యం చేస్తున్నారు';
  }

  @override
  String get minutes15 => '15 నిమిషాలు';

  @override
  String get minutes30 => '30 నిమిషాలు';

  @override
  String get hour1 => '1 గంట';

  @override
  String get hours8 => '8 గంటలు';

  @override
  String get personalCard => 'వ్యక్తిగత కార్డ్';

  @override
  String get downloadFailed => 'డౌన్‌లోడ్ విఫలమైంది';

  @override
  String get locationExpired => 'గడువు ముగిసింది';

  @override
  String secondsRemaining(int count) {
    return '$countలు';
  }

  @override
  String minutesRemaining(int count) {
    return '$count నిమిషాలు';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '$hours గంటలు $minutes నిమిషాలు';
  }

  @override
  String get favoriteMessages => 'ఇష్టమైనవి';

  @override
  String get linksCopied => 'లింక్ కాపీ చేయబడింది';

  @override
  String get noLinksFound => 'లింక్‌లు ఏవీ కనుగొనబడలేదు';

  @override
  String get roomStorageRanking => 'గది నిల్వ ర్యాంకింగ్';

  @override
  String get downloadComplete => 'డౌన్‌లోడ్ పూర్తయింది';

  @override
  String get downloading => 'డౌన్‌లోడ్ చేస్తోంది...';

  @override
  String get draftSaved => 'డ్రాఫ్ట్ సేవ్ చేయబడింది';

  @override
  String get voiceRecording => 'వాయిస్ రికార్డింగ్';

  @override
  String get searchLocation => 'స్థానాన్ని శోధించండి';

  @override
  String get tapToSearch => 'శోధించడానికి నొక్కండి';

  @override
  String get settingsThisDevice => 'ఈ పరికరం';

  @override
  String get settingsJustNow => 'ఇప్పుడే';

  @override
  String get settingsDeviceId => 'పరికరం ID';

  @override
  String get settingsStatus => 'స్థితి';

  @override
  String get settingsLastActive => 'చివరిగా సక్రియం';

  @override
  String get settingsIpAddress => 'IP చిరునామా';

  @override
  String get settingsRenameDevice => 'పరికరం పేరు మార్చండి';

  @override
  String get settingsDeviceNameHint => 'పరికరం పేరును నమోదు చేయండి';

  @override
  String get settingsDeviceRenamed => 'పరికరం పేరు మార్చబడింది';

  @override
  String get settingsRenameFailed => 'పేరు మార్చడం విఫలమైంది';

  @override
  String get settingsRemoteLogout => 'రిమోట్ లాగ్అవుట్';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return 'మీరు ఖచ్చితంగా \"$deviceName\" నుండి లాగ్ అవుట్ చేయాలనుకుంటున్నారా? ఈ చర్య రద్దు చేయబడదు.';
  }

  @override
  String get settingsDeviceLoggedOut => 'పరికరం లాగ్ అవుట్ చేయబడింది';

  @override
  String get settingsLogoutFailed => 'లాగ్ అవుట్ విఫలమైంది';

  @override
  String get settingsLogout => 'లాగ్అవుట్';

  @override
  String get settingsVerifyIdentity => 'గుర్తింపును ధృవీకరించండి';

  @override
  String get settingsEnterPasswordToConfirm =>
      'ఈ చర్యను నిర్ధారించడానికి మీ పాస్‌వర్డ్‌ను నమోదు చేయండి.';

  @override
  String get scheduledSendTitle => 'సందేశాన్ని షెడ్యూల్ చేయండి';

  @override
  String get scheduledSendInOneHour => '1 గంటలో';

  @override
  String get scheduledSendTonight => 'ఈ రాత్రి (8:00 PM)';

  @override
  String get scheduledSendTomorrowMorning => 'రేపు ఉదయం (9:00 AM)';

  @override
  String get scheduledSendCustom => 'తేదీ & సమయాన్ని ఎంచుకోండి';

  @override
  String get scheduledMessageLabel => 'షెడ్యూల్ చేయబడింది';

  @override
  String get scheduledMessageCancel => 'షెడ్యూల్ చేసిన సందేశాన్ని రద్దు చేయండి';

  @override
  String get chatLockTitle => 'చాట్ లాక్';

  @override
  String get chatLockEnable => 'ఈ చాట్‌ని లాక్ చేయండి';

  @override
  String get chatLockDisable => 'ఈ చాట్‌ని అన్‌లాక్ చేయండి';

  @override
  String get chatLockDescription =>
      'లాక్ చేయబడిన చాట్‌లను తెరవడానికి బయోమెట్రిక్ లేదా పిన్ ధృవీకరణ అవసరం';

  @override
  String get chatLockVerifyTitle => 'చాట్ లాక్ చేయబడింది';

  @override
  String get chatLockVerifySubtitle =>
      'ఈ చాట్‌ని యాక్సెస్ చేయడానికి వెరిఫై చేయండి';

  @override
  String get chatLockVerifyFailed => 'ధృవీకరణ విఫలమైంది';

  @override
  String get chatLockEnabled => 'చాట్ లాక్ చేయబడింది';

  @override
  String get chatLockDisabled => 'చాట్ అన్‌లాక్ చేయబడింది';

  @override
  String get chatLockPinTitle => 'PINని నమోదు చేయండి';

  @override
  String get chatLockPinSetTitle => 'PINని సెట్ చేయండి';

  @override
  String get chatLockPinConfirmTitle => 'PINని నిర్ధారించండి';

  @override
  String get chatLockPinMismatch => 'పిన్ సరిపోలలేదు';

  @override
  String get chatLockUseBiometric => 'బయోమెట్రిక్ ఉపయోగించండి';

  @override
  String get chatLockUsePin => 'పిన్ ఉపయోగించండి';

  @override
  String get mediaEditorUndo => 'అన్డు';

  @override
  String get mediaEditorRedo => 'పునరావృతం చేయండి';

  @override
  String get mediaEditorCrop => 'పంట';

  @override
  String get mediaEditorFilter => 'ఫిల్టర్ చేయండి';

  @override
  String get mediaEditorDraw => 'గీయండి';

  @override
  String get mediaEditorText => 'వచనం';

  @override
  String get aiAssistant => 'AI అసిస్టెంట్';

  @override
  String get aiAssistantWelcome =>
      'హలో! నేను N42 AI అసిస్టెంట్‌ని. నేను మీకు ఎలా సహాయం చేయగలను?';

  @override
  String get aiAssistantNotConfigured => 'AI సేవ కాన్ఫిగర్ చేయబడలేదు';

  @override
  String get aiAssistantSettings => 'AI సెట్టింగ్‌లు';

  @override
  String get aiAssistantClearHistory => 'చాట్ చరిత్రను క్లియర్ చేయండి';

  @override
  String get aiAssistantClearHistoryConfirm =>
      'మీరు ఖచ్చితంగా మొత్తం AI చాట్ చరిత్రను క్లియర్ చేయాలనుకుంటున్నారా?';

  @override
  String get aiAssistantStopGenerating => 'ఉత్పత్తి చేయడం ఆపివేయండి';

  @override
  String get aiAssistantModel => 'మోడల్';

  @override
  String get aiAssistantTemperature => 'ఉష్ణోగ్రత';

  @override
  String get aiAssistantMaxTokens => 'గరిష్ట టోకెన్లు';

  @override
  String get aiAssistantContextWindow => 'సందర్భ విండో';

  @override
  String get aiAssistantServiceStatus => 'సేవా స్థితి';

  @override
  String get aiAssistantAvailable => 'అందుబాటులో ఉంది';

  @override
  String get aiAssistantUnavailable => 'అందుబాటులో లేదు';

  @override
  String get aiSummarize => 'AI సారాంశం';

  @override
  String aiSummarizeUnread(int count) {
    return '$count చదవని సందేశాలను సంగ్రహించండి';
  }

  @override
  String get aiSummarizeLoading => 'సంగ్రహించడం...';

  @override
  String get aiSummarizeError => 'సంగ్రహించడంలో విఫలమైంది';

  @override
  String get aiRewrite => 'AI తిరిగి వ్రాయండి';

  @override
  String get aiRewriteFormal => 'అధికారిక';

  @override
  String get aiRewriteCasual => 'సాధారణం';

  @override
  String get aiRewritePlayful => 'ఉల్లాసభరితమైన';

  @override
  String get aiRewriteProfessional => 'వృత్తిపరమైన';

  @override
  String get aiRewriteAccept => 'ఉపయోగించండి';

  @override
  String get aiRewriteCancel => 'రద్దు చేయి';

  @override
  String get aiRewriteLoading => 'తిరిగి రాస్తోంది...';

  @override
  String get aiLinkSummary => 'AI సారాంశం';

  @override
  String get aiLinkSummaryAnalyzing => 'విశ్లేషిస్తోంది...';

  @override
  String get chatFolderManagement => 'ఫోల్డర్‌లను నిర్వహించండి';

  @override
  String get chatFolderSystem => 'సిస్టమ్ ఫోల్డర్లు';

  @override
  String get chatFolderCustom => 'కస్టమ్ ఫోల్డర్లు';

  @override
  String get chatFolderEmpty => 'ఇంకా అనుకూల ఫోల్డర్‌లు లేవు';

  @override
  String get chatFolderCreate => 'ఫోల్డర్‌ని సృష్టించండి';

  @override
  String get chatFolderEdit => 'ఫోల్డర్‌ని సవరించండి';

  @override
  String get chatFolderNameHint => 'ఫోల్డర్ పేరు';

  @override
  String get chatFolderAll => 'అన్నీ';

  @override
  String get chatFolderUnread => 'చదవలేదు';

  @override
  String get chatFolderPersonal => 'వ్యక్తిగత';

  @override
  String get chatFolderGroups => 'గుంపులు';

  @override
  String get chatFolderChannels => 'ఛానెల్‌లు';

  @override
  String get chatFolderMuted => 'మ్యూట్ చేయబడింది';

  @override
  String get storyAddMusic => 'సంగీతాన్ని జోడించండి';

  @override
  String get storyChangeMusic => 'సంగీతాన్ని మార్చండి';

  @override
  String get storyBackgroundMusic => 'నేపథ్య సంగీతం';

  @override
  String get storyMusicPreview => 'ప్రివ్యూ (గరిష్టంగా 15సె)';

  @override
  String get storyChooseFromDevice => 'పరికరం నుండి ఎంచుకోండి';

  @override
  String get storyUseThisMusic => 'ఈ సంగీతాన్ని ఉపయోగించండి';

  @override
  String get authPasskeyNotSupported => 'ఈ పరికరంలో పాస్‌కీకి మద్దతు లేదు';

  @override
  String get authPasskeyRegister => 'పాస్‌కీని నమోదు చేయండి';

  @override
  String get authPasskeyNoRegistered => 'పాస్‌కీలు నమోదు కాలేదు';

  @override
  String get authPasskeyRegisterHint =>
      'ఈ ఖాతా కోసం పాస్‌కీని నమోదు చేయండి. స్వతంత్ర పాస్‌కీ సైన్-ఇన్ తర్వాత ప్రారంభించబడుతుంది.';

  @override
  String get authPasskeyNameYours => 'మీ పాస్‌కీకి పేరు పెట్టండి';

  @override
  String get authPasskeyRegistered => 'పాస్‌కీ ఈ ఖాతాలో సేవ్ చేయబడింది';

  @override
  String get authPasskeyDeleted => 'ఈ ఖాతా నుండి పాస్‌కీ తీసివేయబడింది';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return '\"$name\" పాస్‌కీని తొలగించాలా? పాస్‌కీ సైన్-ఇన్‌ని ఉపయోగించే ముందు మీరు దాన్ని మళ్లీ నమోదు చేసుకోవాలి.';
  }

  @override
  String get momentVisibilityPublic => 'పబ్లిక్';

  @override
  String get momentVisibilityPrivate => 'ప్రైవేట్';

  @override
  String get momentVisibilityPartial => 'ఎంచుకున్న స్నేహితులు';

  @override
  String get momentVisibilityExcluded => 'కొంతమంది స్నేహితులను మినహాయించండి';

  @override
  String momentUserMoments(String userName) {
    return '$userName యొక్క క్షణాలు';
  }

  @override
  String get momentForwardTo => 'ముందుకు';

  @override
  String get momentForwardSuccess => 'విజయవంతంగా ఫార్వార్డ్ చేయబడింది';

  @override
  String get momentSelectFriends => 'స్నేహితులను ఎంచుకోండి';

  @override
  String get momentSelectTags => 'ట్యాగ్‌ల ద్వారా ఎంచుకోండి';

  @override
  String momentSelectedCount(int count) {
    return 'ఎంచుకోబడింది ($count)';
  }

  @override
  String get momentNoMomentsYet => 'ఇంకా క్షణాలు లేవు';

  @override
  String get momentForwardMoment => 'ఫార్వర్డ్ మూమెంట్';

  @override
  String get momentAddComment => 'వ్యాఖ్యను జోడించండి...';

  @override
  String momentForwardContent(String content) {
    return '[క్షణం] $content';
  }

  @override
  String get momentDeleteMoment => 'క్షణం తొలగించు';

  @override
  String get momentDeleteConfirm =>
      'మీరు ఖచ్చితంగా ఈ క్షణాన్ని తొలగించాలనుకుంటున్నారా?';

  @override
  String get momentComment => 'వ్యాఖ్యానించండి';

  @override
  String get momentWriteComment => 'వ్యాఖ్య వ్రాయండి...';

  @override
  String get momentLike => 'ఇష్టం';

  @override
  String get momentUnlike => 'కాకుండా';

  @override
  String get momentForward => 'ముందుకు';

  @override
  String get momentDelete => 'తొలగించు';

  @override
  String get momentReply => 'ప్రత్యుత్తరం ఇవ్వండి';

  @override
  String get momentMoment => 'క్షణం';

  @override
  String momentLikesCount(int count) {
    return '$count ఇష్టపడ్డారు';
  }

  @override
  String momentCommentsCount(int count) {
    return '$count వ్యాఖ్యలు';
  }

  @override
  String get momentNoComments => 'ఇంకా వ్యాఖ్యలు లేవు';

  @override
  String get momentFailedToLoad => 'చిత్రాన్ని లోడ్ చేయడంలో విఫలమైంది';

  @override
  String momentReplyTo(String userName) {
    return '$userNameకి ప్రత్యుత్తరం ఇవ్వండి...';
  }

  @override
  String get momentNoConversations => 'సంభాషణలు లేవు';

  @override
  String get momentJustNow => 'ఇప్పుడే';

  @override
  String momentMinutesAgo(int count) {
    return '${count}m క్రితం';
  }

  @override
  String momentHoursAgo(int count) {
    return '${count}h క్రితం';
  }

  @override
  String momentDaysAgo(int count) {
    return '${count}d క్రితం';
  }

  @override
  String get chatGroupAnnouncementHint => 'సమూహ ప్రకటనను నమోదు చేయండి';

  @override
  String get chatGroupAnnouncementEmpty => 'ప్రకటన లేదు';

  @override
  String get chatEditNickname => 'మారుపేరును సవరించండి';

  @override
  String get chatNicknameHint => 'ఈ గుంపులో మీ మారుపేరును నమోదు చేయండి';

  @override
  String get contactAddPhoneHint => 'ఫోన్ నంబర్‌ను నమోదు చేయండి';

  @override
  String get contactNotesHint => 'ఈ పరిచయం గురించి గమనికలను జోడించండి';

  @override
  String get reportTitle => 'నివేదించండి';

  @override
  String get reportReasonSpam => 'స్పామ్';

  @override
  String get reportReasonHarassment => 'వేధింపులు';

  @override
  String get reportReasonFraud => 'మోసం';

  @override
  String get reportReasonOther => 'ఇతర';

  @override
  String get reportSubmitted => 'నివేదిక సమర్పించారు';

  @override
  String get reportDescription => 'అదనపు వివరణ (ఐచ్ఛికం)';

  @override
  String get qrcodeSaved => 'QR కోడ్ ఆల్బమ్‌లో సేవ్ చేయబడింది';

  @override
  String get chatSendRedPacketInChat =>
      'దయచేసి చాట్‌లో ఎరుపు ప్యాకెట్‌ని పంపండి';

  @override
  String get commonSaveFailed => 'సేవ్ చేయడం విఫలమైంది';

  @override
  String get reportSelectReason => 'దయచేసి ఒక కారణాన్ని ఎంచుకోండి';

  @override
  String get reportUnavailable => 'రిపోర్టు పంపడానికి సైన్ ఇన్ చేయండి.';

  @override
  String get reportAccountChanged =>
      'ఖాతా మారింది. పంపడానికి ఈ రిపోర్టును మళ్లీ తెరవండి.';

  @override
  String get reportUnsupported =>
      'ఈ హోమ్‌సర్వర్ వినియోగదారులపై రిపోర్టులకు మద్దతు ఇవ్వదు.';

  @override
  String get reportRoomUnsupported =>
      'ఈ హోమ్‌సర్వర్ గదులపై రిపోర్టులకు మద్దతు ఇవ్వదు.';

  @override
  String get reportRateLimited =>
      'చాలా ఎక్కువ రిపోర్టులు పంపబడ్డాయి. తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String get reportCouldNotSend =>
      'రిపోర్టు పంపలేకపోయాము. మళ్లీ ప్రయత్నించండి.';

  @override
  String get gameCenter => 'ఆటలు';

  @override
  String get gameHighScore => 'ఉత్తమమైనది';

  @override
  String get gameScore => 'స్కోర్';

  @override
  String get gameOver => 'గేమ్ ముగిసింది';

  @override
  String get gamePlayAgain => 'మళ్లీ ఆడండి';

  @override
  String get gameLeaderboard => 'లీడర్‌బోర్డ్';

  @override
  String get gamePause => 'పాజ్ చేయబడింది';

  @override
  String get gameResume => 'పునఃప్రారంభించడానికి నొక్కండి';

  @override
  String get gameConfirmExit => 'ఈ గేమ్ నుండి నిష్క్రమించాలా?';

  @override
  String get gameNoScores => 'ఇంకా స్కోర్లు లేవు';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => '2048కి చేరుకోవడానికి టైల్స్‌ను విలీనం చేయండి';

  @override
  String get gameBlockDrop => 'బ్లాక్ డ్రాప్';

  @override
  String get gameBlockDropDesc => 'పంక్తులను వదలండి మరియు క్లియర్ చేయండి';

  @override
  String get gameMinesweeper => 'మైన్స్వీపర్';

  @override
  String get gameMinesweeperDesc => 'అన్ని సురక్షిత సెల్‌లను కనుగొనండి';

  @override
  String get gameMatch3 => 'మ్యాచ్ 3';

  @override
  String get gameMatch3Desc => '3 లేదా అంతకంటే ఎక్కువ రత్నాలను సరిపోల్చండి';

  @override
  String get gameMinesweeperEasy => 'సులువు';

  @override
  String get gameMinesweeperMedium => 'మధ్యస్థం';

  @override
  String get gameMinesLeft => 'గనులు మిగిలాయి';

  @override
  String get gameTimeLeft => 'సమయం';

  @override
  String get gameLevel => 'స్థాయి';

  @override
  String get gameNext => 'తదుపరి';

  @override
  String get gameBestTime => 'ఉత్తమ సమయం';

  @override
  String get gameNewRecord => 'కొత్త రికార్డు!';

  @override
  String get gameLines => 'లైన్లు';

  @override
  String get storyMyStory => 'నా కథ';

  @override
  String get storageSmartCleanup => 'స్మార్ట్ క్లీనప్';

  @override
  String get storageOldMediaFiles => 'పాత మీడియా ఫైల్స్';

  @override
  String get storageLargeFiles => 'పెద్ద ఫైల్స్';

  @override
  String get storageAppCache => 'యాప్ కాష్';

  @override
  String get storageSettings => 'నిల్వ సెట్టింగ్‌లు';

  @override
  String get storageAutoCleanup => 'ఆటో క్లీనప్';

  @override
  String storageAutoCleanupDesc(int days) {
    return '$days రోజుల కంటే పాత ఫైల్‌లను ఆటోమేటిక్‌గా క్లీన్ చేయండి';
  }

  @override
  String get storageCleanupPeriod => 'శుభ్రపరిచే కాలం';

  @override
  String get storagePreserveThumbnails => 'సూక్ష్మచిత్రాలను సంరక్షించండి';

  @override
  String get storagePreserveThumbnailsDesc =>
      'శుభ్రపరిచే సమయంలో చిత్ర సూక్ష్మచిత్రాలను ఉంచండి';

  @override
  String get storageWarningHigh =>
      'నిల్వ వినియోగం ఎక్కువ. పాత ఫైళ్లను శుభ్రం చేయడాన్ని పరిగణించండి.';

  @override
  String get storageWarningCritical =>
      'నిల్వ చాలా తక్కువగా ఉంది. దయచేసి ఖాళీ స్థలం వరకు శుభ్రం చేయండి.';

  @override
  String storageFreed(String size, int count) {
    return 'ఫ్రీడ్ $size ($count ఫైల్‌లు)';
  }

  @override
  String storageDays(int days) {
    return '$days రోజులు';
  }

  @override
  String storageViewAllRooms(int count) {
    return 'అన్ని $count గదులను వీక్షించండి';
  }

  @override
  String get storageNoFiles => 'ఫైల్‌లు ఏవీ కనుగొనబడలేదు';

  @override
  String get storageFilePinned => 'పిన్ చేయబడింది';

  @override
  String storageDeleteSelected(int count) {
    return '$count ఎంచుకున్న ఫైల్‌లను తొలగించాలా? వాటిని సర్వర్ నుండి మళ్లీ డౌన్‌లోడ్ చేసుకోవచ్చు.';
  }

  @override
  String get backupRestore => 'బ్యాకప్ & పునరుద్ధరించు';

  @override
  String get backupCreate => 'బ్యాకప్ సృష్టించండి';

  @override
  String get backupCreateDesc =>
      'మీ సెట్టింగ్‌లు మరియు ఎన్‌క్రిప్షన్ కీలను బ్యాకప్ చేయండి. మళ్లీ లాగిన్ అయిన తర్వాత సర్వర్ నుండి సందేశాలు పునరుద్ధరించబడతాయి.';

  @override
  String get backupIncludeKeys => 'ఎన్క్రిప్షన్ కీలను చేర్చండి';

  @override
  String get backupIncludeKeysDesc => 'గుప్తీకరించిన సందేశాలను చదవడం అవసరం';

  @override
  String get backupPasswordProtect => 'పాస్‌వర్డ్ రక్షణ';

  @override
  String get backupEnterPassword => 'బ్యాకప్ పాస్‌వర్డ్‌ను నమోదు చేయండి';

  @override
  String get backupHistory => 'బ్యాకప్ చరిత్ర';

  @override
  String get backupNoBackups => 'ఇంకా బ్యాకప్‌లు లేవు';

  @override
  String get backupRestore2 => 'పునరుద్ధరించు';

  @override
  String get backupDelete => 'తొలగించు';

  @override
  String get backupDeleteConfirm =>
      'మీరు ఖచ్చితంగా ఈ బ్యాకప్‌ని తొలగించాలనుకుంటున్నారా? ఇది రద్దు చేయబడదు.';

  @override
  String get backupRestoreFromFile => 'ఫైల్ నుండి పునరుద్ధరించండి';

  @override
  String get backupRestoreFromFileDesc =>
      'మరొక పరికరం లేదా మునుపటి బ్యాకప్ నుండి .n42backup ఫైల్‌ని దిగుమతి చేయండి.';

  @override
  String get backupChooseFile => 'బ్యాకప్ ఫైల్‌ని ఎంచుకోండి';

  @override
  String get backupRestoring => 'పునరుద్ధరిస్తోంది...';

  @override
  String backupCreated(int rooms, int messages) {
    return 'బ్యాకప్ సృష్టించబడింది: $rooms గదులు, $messages సందేశాలు';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return '$rooms గదుల నుండి $settings సెట్టింగ్‌లు పునరుద్ధరించబడ్డాయి';
  }

  @override
  String backupFailed(String error) {
    return 'బ్యాకప్ విఫలమైంది: $error';
  }

  @override
  String get backupPasswordRequired => 'ఈ బ్యాకప్ పాస్‌వర్డ్-రక్షితమైనది';

  @override
  String get blocGroupNotFound => 'సమూహం కనుగొనబడలేదు';

  @override
  String blocGroupMembersInvited(int count) {
    return 'ఆహ్వానించబడిన $count సభ్యులు(లు)';
  }

  @override
  String get blocGroupMemberRemoved => 'సభ్యుడు తొలగించబడ్డారు';

  @override
  String get blocGroupAdminRemoved => 'అడ్మిన్ తీసివేయబడ్డారు';

  @override
  String get blocGroupLeft => 'సమూహం నుండి నిష్క్రమించారు';

  @override
  String get blocGroupDisbanded => 'సమూహం రద్దు చేయబడింది';

  @override
  String get blocGroupJoined => 'సమూహంలో చేరారు';

  @override
  String get blocGroupInviteDeclined => 'ఆహ్వానం తిరస్కరించబడింది';

  @override
  String get blocGroupTokenGateUpdated => 'టోకెన్ గేట్ నవీకరించబడింది';

  @override
  String get blocTransferProcessing => 'బదిలీని ప్రాసెస్ చేస్తోంది...';

  @override
  String get blocTransferCancelled => 'బదిలీ రద్దు చేయబడింది';

  @override
  String get blocTransferFailed => 'బదిలీ విఫలమైంది';

  @override
  String get blocPaymentProcessing => 'చెల్లింపును ప్రాసెస్ చేస్తోంది...';

  @override
  String get blocPaymentFailed => 'చెల్లింపు విఫలమైంది';

  @override
  String get groupMaxMembers => 'సభ్యుల పరిమితి';

  @override
  String get groupMaxMembersUnlimited => 'అపరిమిత';

  @override
  String get groupMaxMembersHint =>
      'పరిమితిని నమోదు చేయండి (అపరిమిత కోసం ఖాళీగా ఉంచండి)';

  @override
  String get groupMaxMembersUpdated => 'సభ్యుల పరిమితి నవీకరించబడింది';

  @override
  String get groupFull => 'సమూహం సామర్థ్యంలో ఉంది';

  @override
  String get groupChannels => 'టాపిక్ ఛానెల్‌లు';

  @override
  String get groupChannelsEmpty => 'ఇంకా ఛానెల్‌లు లేవు';

  @override
  String get groupChannelsCount => 'ఛానెల్‌లు';

  @override
  String get groupChannelCreate => 'కొత్త ఛానెల్';

  @override
  String get groupChannelName => 'ఛానెల్ పేరు';

  @override
  String get groupChannelTopic => 'ఛానెల్ అంశం (ఐచ్ఛికం)';

  @override
  String get groupChannelDelete => 'ఛానెల్‌ని తొలగించండి';

  @override
  String get groupChannelDeleteConfirm =>
      'ఈ ఛానెల్‌ని తొలగించాలా? అన్ని సందేశాలు పోతాయి.';

  @override
  String get groupBotSettings => 'బాట్ సెట్టింగ్‌లు';

  @override
  String get groupBotEnabled => 'బాట్‌ని ప్రారంభించండి';

  @override
  String get groupBotWelcomeMessage => 'స్వాగతం సందేశం టెంప్లేట్';

  @override
  String get groupBotWelcomeHint =>
      'కొత్త సభ్యుని పేరు కోసం ప్లేస్‌హోల్డర్‌గా \'పేరు\'ని ఉపయోగించండి';

  @override
  String get groupBotConfigUpdated => 'బాట్ సెట్టింగ్‌లు నవీకరించబడ్డాయి';

  @override
  String get groupContentFilter => 'కంటెంట్ ఫిల్టర్';

  @override
  String get groupContentFilterEnabled => 'కీవర్డ్ ఫిల్టర్‌ని ప్రారంభించండి';

  @override
  String get groupContentFilterReplace => '***తో భర్తీ చేయండి';

  @override
  String get groupContentFilterHide => 'సందేశాన్ని దాచు';

  @override
  String get groupContentFilterAddWord => 'కీవర్డ్ జోడించండి';

  @override
  String get groupContentFilterUpdated => 'కంటెంట్ ఫిల్టర్ నవీకరించబడింది';

  @override
  String get chatSlashCommands => 'ఆదేశాలు';

  @override
  String get chatCommandPoll => '/poll — పోల్‌ను సృష్టించండి';

  @override
  String get chatCommandAnnounce => '/ప్రకటించండి - ప్రకటన పంపండి';

  @override
  String get chatCommandWelcome => '/ స్వాగతం — స్వాగత సందేశాన్ని సెట్ చేయండి';

  @override
  String get chatReportMessage => 'నివేదించండి';

  @override
  String get chatReportReason => 'కారణం నివేదించండి';

  @override
  String get chatReportSpam => 'స్పామ్';

  @override
  String get chatReportHarassment => 'వేధింపులు';

  @override
  String get chatReportInappropriate => 'తగని కంటెంట్';

  @override
  String get chatReportOther => 'ఇతర';

  @override
  String get chatReportSuccess => 'నివేదిక సమర్పించారు';

  @override
  String get spacesName => 'సంఘం పేరు';

  @override
  String get spacesNameHint => 'ఉదా క్రిప్టో వ్యాపారులు';

  @override
  String get spacesNameRequired => 'పేరు అవసరం';

  @override
  String get spacesDescription => 'వివరణ';

  @override
  String get spacesDescriptionHint => 'ఈ సంఘం దేనికి సంబంధించినది?';

  @override
  String get spacesType => 'సంఘం రకం';

  @override
  String get spacesPublicDesc => 'ఎవరైనా కనుగొనవచ్చు మరియు చేరవచ్చు';

  @override
  String get spacesPrivateDesc => 'ఆహ్వానించబడిన సభ్యులు మాత్రమే చేరగలరు';

  @override
  String get spacesNotFound => 'సంఘం కనుగొనబడలేదు';

  @override
  String get spacesSearch => 'సంఘాలను శోధించండి...';

  @override
  String get spacesMembers => 'సభ్యులు';

  @override
  String get spacesNoChannels => 'ఇంకా ఛానెల్‌లు లేవు';

  @override
  String get spacesLeave => 'సంఘం నుండి నిష్క్రమించండి';

  @override
  String spacesLeaveConfirm(String name) {
    return 'మీరు ఖచ్చితంగా \"$name\" నుండి నిష్క్రమించాలనుకుంటున్నారా?';
  }

  @override
  String get spacesDelete => 'సంఘాన్ని తొలగించండి';

  @override
  String spacesDeleteConfirm(String name) {
    return 'ఇది \"$name\" మరియు దాని అన్ని ఛానెల్‌లను శాశ్వతంగా తొలగిస్తుంది. ఈ చర్య రద్దు చేయబడదు.';
  }

  @override
  String get spacesCreateChannel => 'ఛానెల్‌ని జోడించండి';

  @override
  String get spacesChannelName => 'ఛానెల్ పేరు';

  @override
  String get spacesChannelTopic => 'అంశం (ఐచ్ఛికం)';

  @override
  String get spacesDeleteChannel => 'ఛానెల్‌ని తొలగించండి';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return 'మీరు ఖచ్చితంగా \"#$name\"ని తొలగించాలనుకుంటున్నారా?';
  }

  @override
  String get spacesEditName => 'పేరును సవరించండి';

  @override
  String get spacesEditDescription => 'వివరణను సవరించండి';

  @override
  String spacesViewAllMembers(int count) {
    return '$count సభ్యులందరినీ వీక్షించండి';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return '$name కిక్ చేయండి';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return '$nameని నిషేధించండి';
  }

  @override
  String get spacesPromoteAdmin => 'అడ్మిన్‌గా ప్రమోట్ చేయండి';

  @override
  String get spacesDemoteAdmin => 'అడ్మిన్‌ని తీసివేయండి';

  @override
  String get spacesInviteMember => 'సభ్యుడిని ఆహ్వానించండి';

  @override
  String get spacesInviteMemberUserId =>
      'వినియోగదారు ID (ఉదా. @user:server.com)';

  @override
  String get spacesSave => 'సేవ్ చేయండి';

  @override
  String get settingsScreenshotProtection => 'స్క్రీన్షాట్ రక్షణ';

  @override
  String get settingsScreenshotProtectionDesc =>
      'స్క్రీన్‌షాట్‌లు మరియు స్క్రీన్ రికార్డింగ్‌ను నిరోధించండి';

  @override
  String get chatSelfDestructTimer => 'స్వీయ-నాశనము';

  @override
  String get chatTimerPickerTitle => 'స్వీయ-విధ్వంసక టైమర్';

  @override
  String get chatTimerOff => 'ఆఫ్';

  @override
  String get onChainNotificationsTitle => 'ఆన్-చైన్ ఈవెంట్‌లు';

  @override
  String get onChainMarkAllRead => 'అన్నీ చదివినట్లు గుర్తు పెట్టండి';

  @override
  String get onChainNoNotifications => 'ఇంకా ఆన్-చైన్ ఈవెంట్‌లు లేవు';

  @override
  String get onChainNoNotificationsDesc =>
      'సభ్యత్వం పొందిన ఛానెల్‌ల నుండి ఈవెంట్‌లు ఇక్కడ కనిపిస్తాయి';

  @override
  String get onChainViewDetails => 'వివరాలను వీక్షించండి';

  @override
  String get chatCommandHelp => '/help — అన్ని ఆదేశాలను చూపించు';

  @override
  String get chatCommandPrice => '/ ధర - టోకెన్ ధర పొందండి';

  @override
  String get chatCommandBalance => '/ బ్యాలెన్స్ - వాలెట్ బ్యాలెన్స్ చూపించు';

  @override
  String get chatCommandChains => '/ గొలుసులు — జాబితా 236+ మద్దతు గొలుసులు';

  @override
  String get chatMiniApps => 'యాప్‌లు';

  @override
  String get miniAppMarketTitle => 'మినీ యాప్‌లు';

  @override
  String get miniAppCategoryAll => 'అన్నీ';

  @override
  String get miniAppSearch => 'యాప్‌లను శోధించండి...';

  @override
  String get miniAppFeatured => 'ఫీచర్ చేయబడింది';

  @override
  String get miniAppAllApps => 'అన్ని యాప్‌లు';

  @override
  String get miniAppNoResults => 'యాప్‌లు ఏవీ కనుగొనబడలేదు';

  @override
  String get slideToPayLabel => '→→→ నిర్ధారించడానికి స్లయిడ్ చేయండి';

  @override
  String get slideToPayConfirming => 'ధృవీకరిస్తోంది...';

  @override
  String get redPacketBestLuck => 'బెస్ట్ లక్';

  @override
  String get redPacketBestLuckCongrats => 'బెస్ట్ లక్! మీరు ఎక్కువగా పొందారు!';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total దావా వేయబడింది';
  }

  @override
  String get redPacketStatsTotal => 'మొత్తం';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 ఎరుపు రంగు ప్యాకెట్‌ని పట్టుకున్నారు • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id • 0x వాలెట్ చిరునామా • name.eth';

  @override
  String get web3SearchPlaceholder => 'ID, వాలెట్ లేదా ENS ద్వారా శోధించండి...';

  @override
  String get web3WalletAddress => 'వాలెట్ చిరునామా';

  @override
  String get web3AddressCopied => 'చిరునామా కాపీ చేయబడింది';

  @override
  String get web3Copy => 'కాపీ చేయండి';

  @override
  String get web3SendMessage => 'సందేశం పంపండి';

  @override
  String get web3SendToWallet => 'సందేశం వాలెట్';

  @override
  String get web3WalletOnlyHint =>
      'ఈ చిరునామాకు ఇంకా N42 ఖాతా లేదు. వారు చేరినప్పుడు సందేశం పంపబడుతుంది.';

  @override
  String get web3NftAvatar => 'NFT అవతార్';

  @override
  String get web3ResolveFailed => 'గుర్తింపును పరిష్కరించడంలో విఫలమైంది';

  @override
  String web3EnsNotFound(String name) {
    return 'ENS పేరు \"$name\" కనుగొనబడలేదు';
  }

  @override
  String get web3NoN42AccountTitle => 'N42 ఖాతా లేదు';

  @override
  String get web3NoN42AccountDesc =>
      'ఈ వాలెట్ చిరునామాకు ఇంకా N42 ఖాతా లేదు. మీరు ప్రారంభించడానికి మీ N42 ఆహ్వాన లింక్‌ని వారితో పంచుకోవచ్చు.';

  @override
  String get web3ShareInvite => 'ఆహ్వానాన్ని షేర్ చేయండి';

  @override
  String get nftPickerTitle => 'NFT అవతార్‌ని ఎంచుకోండి';

  @override
  String get nftPickerTabPopular => 'జనాదరణ పొందినది';

  @override
  String get nftPickerTabCustom => 'కస్టమ్';

  @override
  String get nftPickerChain => 'చైన్';

  @override
  String get nftPickerContract => 'కాంట్రాక్ట్ చిరునామా';

  @override
  String get nftPickerTokenId => 'టోకెన్ ID';

  @override
  String get nftPickerVerifyOwnership => 'యాజమాన్యం & ప్రివ్యూను ధృవీకరించండి';

  @override
  String get nftPickerUseAsAvatar => 'అవతార్‌గా ఉపయోగించండి';

  @override
  String get nftPickerPreview => 'ప్రివ్యూ';

  @override
  String get nftPickerNotOwned => 'మీరు ఈ NFTని కలిగి లేరు';

  @override
  String get nftPickerInvalidTokenId => 'చెల్లని టోకెన్ ID';

  @override
  String get nftPickerEnterBoth =>
      'ఒప్పంద చిరునామా మరియు టోకెన్ IDని నమోదు చేయండి';

  @override
  String get nftPickerInfoTitle => 'NFT అవతార్ — ధృవీకరించబడిన ఆన్-చైన్';

  @override
  String get nftPickerInfoDesc =>
      'మీకు స్వంతమైన NFTని మీ అవతార్‌గా బంధించండి. చైన్‌లో ఎవరైనా యాజమాన్యాన్ని ధృవీకరించవచ్చు. N42 అంతటా బంగారు ఉంగరంతో ప్రదర్శించబడింది.';

  @override
  String get nftPickerPopularCollections => 'జనాదరణ పొందిన సేకరణలు';

  @override
  String get nftPickerWalletHint =>
      '236+ చైన్‌లలో మీ NFTలను స్వయంచాలకంగా కనుగొనడానికి మీ N42 వాలెట్‌ని కనెక్ట్ చేయండి.';

  @override
  String get profileBindNftAvatar => 'NFT అవతార్‌ను బంధించండి';

  @override
  String get profileChangeAvatar => 'అవతార్ మార్చండి';

  @override
  String get groupTopics => 'అంశాలు';

  @override
  String get groupTopicsEmpty => 'ఇంకా టాపిక్‌లు లేవు';

  @override
  String get syncInProgress => 'సందేశ చరిత్రను సమకాలీకరిస్తోంది...';

  @override
  String get recoveryKeyReminderTitle => 'మీ సందేశాలను రక్షించండి';

  @override
  String get recoveryKeyReminderDesc =>
      'పరికరాల్లో గుప్తీకరించిన సందేశాలను సురక్షితంగా సమకాలీకరించడానికి రికవరీ కీని సృష్టించండి';

  @override
  String get recoveryKeySetupNow => 'ఇప్పుడే సెటప్ చేయండి';

  @override
  String get recoveryKeyRemindLater => 'నాకు తర్వాత గుర్తు చేయండి';

  @override
  String get channelReadOnly =>
      'ఈ ఛానెల్‌లో నిర్వాహకులు మాత్రమే పోస్ట్ చేయగలరు';

  @override
  String get channelSubscribers => 'చందాదారులు';

  @override
  String get channelVerified => 'ధృవీకరించబడిన ఛానెల్';

  @override
  String get redPacketHistory => 'రెడ్ ప్యాకెట్ చరిత్ర';

  @override
  String get redPacketSent => 'పంపబడింది';

  @override
  String get redPacketReceived => 'అందుకుంది';

  @override
  String get redPacketExpired => 'గడువు ముగిసింది';

  @override
  String get redPacketClaimed => 'దావా వేసింది';

  @override
  String get redPacketInsufficientBalance => 'సరిపోని బ్యాలెన్స్';

  @override
  String selfDestructCountdown(String time) {
    return '$timeలో స్వీయ-విధ్వంసం';
  }

  @override
  String get messageDestroyed => 'సందేశం నాశనం చేయబడింది';

  @override
  String miniAppPermissionDenied(String permission) {
    return 'అనుమతి నిరాకరించబడింది: $permission';
  }

  @override
  String get aiSuggestionGasFee => 'గ్యాస్ ఫీజు అంటే ఏమిటి?';

  @override
  String get aiSuggestionDefi => 'DeFi బిగినర్స్ గైడ్';

  @override
  String get aiSuggestionSecurity => 'కాంట్రాక్ట్ భద్రతను ఎలా తనిఖీ చేయాలి';

  @override
  String get aiSuggestionBridge => 'క్రాస్ చైన్ బ్రిడ్జింగ్';

  @override
  String get channelDiscoverTitle => 'ఛానెల్‌లను కనుగొనండి';

  @override
  String get channelDiscoverSearch => 'ఛానెల్‌లను శోధించండి...';

  @override
  String get channelJoin => 'చేరండి';

  @override
  String get channelJoined => 'చేరారు';

  @override
  String get channelCategory => 'వర్గం';

  @override
  String slowModeCooldown(int seconds) {
    return 'స్లో మోడ్: $secondsలు వేచి ఉండండి';
  }

  @override
  String get addressCopyAction => 'చిరునామాను కాపీ చేయండి';

  @override
  String get addressSendMessage => 'సందేశం పంపండి';

  @override
  String get addressViewProfile => 'ప్రొఫైల్‌ని వీక్షించండి';

  @override
  String get sendToAddress => 'వాలెట్ చిరునామాకు పంపండి';

  @override
  String get blocAuthSendVerificationCodeFailed =>
      'ధృవీకరణ కోడ్‌ని పంపడంలో విఫలమైంది';

  @override
  String get blocAuthServerNoEmailPasswordReset =>
      'ఈ సర్వర్ ఇమెయిల్ పాస్‌వర్డ్ రీసెట్‌కు మద్దతు ఇవ్వదు';

  @override
  String get blocAuthResetPasswordFailed =>
      'పాస్‌వర్డ్ రీసెట్ చేయడంలో విఫలమైంది';

  @override
  String get blocAuthChangePasswordFailed =>
      'పాస్‌వర్డ్‌ని మార్చడంలో విఫలమైంది';

  @override
  String get blocAuthOldPasswordWrong => 'ప్రస్తుత పాస్‌వర్డ్ తప్పు';

  @override
  String get blocAuthLoginCancelled => 'లాగిన్ రద్దు చేయబడింది';

  @override
  String get blocAuthGoogleLoginFailed => 'Google లాగిన్ విఫలమైంది';

  @override
  String get blocAuthAppleLoginFailed => 'Apple లాగిన్ విఫలమైంది';

  @override
  String get blocAuthSsoLoginFailed => 'SSO లాగిన్ విఫలమైంది';

  @override
  String get blocAuthFacebookLoginFailed => 'Facebook లాగిన్ విఫలమైంది';

  @override
  String get blocAuthTwitterLoginFailed => 'ట్విట్టర్ లాగిన్ విఫలమైంది';

  @override
  String get blocAuthWeChatLoginFailed => 'WeChat లాగిన్ విఫలమైంది';

  @override
  String get blocAuthWeChatNotConfigured => 'WeChat లాగిన్ కాన్ఫిగర్ చేయబడలేదు';

  @override
  String get blocAuthWeChatNotInstalled =>
      'దయచేసి ముందుగా WeChatని ఇన్‌స్టాల్ చేయండి';

  @override
  String get blocAuthPasswordWrong => 'పాస్‌వర్డ్ తప్పు';

  @override
  String get blocAuthEmailAlreadyBound =>
      'ఈ ఇమెయిల్ ఇప్పటికే మరొక ఖాతాకు కట్టుబడి ఉంది';

  @override
  String get blocAuthChangeEmailFailed => 'ఇమెయిల్‌ని మార్చడంలో విఫలమైంది';

  @override
  String get blocAuthVerificationCodeInvalid =>
      'ధృవీకరణ కోడ్ తప్పు లేదా గడువు ముగిసింది';

  @override
  String get blocAuthSessionExpired =>
      'సెషన్ గడువు ముగిసింది, దయచేసి మళ్లీ లాగిన్ చేయండి';

  @override
  String get blocAuthSessionIncomplete =>
      'సెషన్ డేటా అసంపూర్తిగా ఉంది, దయచేసి మళ్లీ లాగిన్ చేయండి';

  @override
  String get chatReadingMode => 'పఠన మోడ్';

  @override
  String get groupPoints => 'పాయింట్లు';

  @override
  String get settingsPrivacySecurity => 'గోప్యత మరియు భద్రత';

  @override
  String get settingsSystemAccounts => 'సిస్టమ్ మరియు ఖాతాలు';

  @override
  String get settingsNotificationPrivacy => 'నోటిఫికేషన్ గోప్యత';

  @override
  String get settingsSenderOnly => 'పంపినవారిని మాత్రమే చూపించు';

  @override
  String get settingsHiddenNotification => 'పంపినవారిని మరియు సందేశాన్ని దాచు';

  @override
  String get settingsSmartFilter => 'స్మార్ట్ ఫిల్టర్';

  @override
  String get settingsEmailVerificationSent => 'ధృవీకరణ ఇమెయిల్ పంపబడింది';

  @override
  String get settingsEmailLinkInstructions =>
      'మీ ఇమెయిల్‌లోని ధృవీకరణ లింక్‌ను తెరిచి, ఇక్కడికి తిరిగి వచ్చి నిర్ధారించండి.';

  @override
  String get settingsSendVerificationEmail => 'ధృవీకరణ ఇమెయిల్ పంపండి';

  @override
  String get chatLogoutKeyWarning =>
      'లాగ్ అవుట్ చేసే ముందు మీ ఎన్‌క్రిప్షన్ కీలను బ్యాకప్ చేయండి, లేకపోతే ఎన్‌క్రిప్ట్ చేసిన సందేశాలను చదవలేకపోవచ్చు.';

  @override
  String get settingsBiometricUnavailable =>
      'బయోమెట్రిక్ ప్రామాణీకరణ అందుబాటులో లేదు. పరికర సెట్టింగ్‌లలో నమోదు మరియు అనుమతులను తనిఖీ చేయండి.';

  @override
  String get chatEncryptionNotReady =>
      'సురక్షిత కనెక్షన్ సిద్ధంగా లేదు. సందేశం పంపబడలేదు. రెండు ఖాతాల్లో కనెక్షన్, పరికర ధృవీకరణను తనిఖీ చేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get contactRequestPending => 'ఆమోదం కోసం వేచి ఉంది';

  @override
  String get chatFriendRequestPending =>
      'స్నేహం నిర్ధారించబడలేదు. పంపే ముందు కాంటాక్ట్‌లు > కొత్త స్నేహితులు చూడండి.';

  @override
  String contactPhotoCount(int count) {
    return '$count ఫోటోలు';
  }

  @override
  String get videoPublish => 'వీడియోను ప్రచురించండి';

  @override
  String get videoGoLive => 'లైవ్ ప్రారంభించండి';

  @override
  String get videoSelect => 'వీడియోను ఎంచుకోండి';

  @override
  String get videoLiveUnavailable => 'ప్రత్యక్ష ప్రసారం అందుబాటులో లేదు';

  @override
  String get qrcodeAlbum => 'ఆల్బమ్';

  @override
  String get settingsSwitchAccount => 'ఖాతాను మార్చండి';

  @override
  String get chatFilterUnread => 'చదవనివి';

  @override
  String get chatFilterEmpty => 'ఈ ఫిల్టర్‌లో సంభాషణలు లేవు';

  @override
  String get accountAdd => 'ఖాతాను జోడించండి';

  @override
  String get accountCurrent => 'ప్రస్తుత ఖాతా';

  @override
  String get accountSwitching => 'ఖాతా మారుతోంది…';

  @override
  String get accountSwitchFailed =>
      'ఖాతాను మార్చలేకపోయాము. మళ్లీ ప్రయత్నించండి లేదా మళ్లీ సైన్ ఇన్ చేయడానికి ఖాతాను జోడించండి.';

  @override
  String get accountSessionsHint =>
      'ప్రతి ఖాతా సందేశాలు, సురక్షిత సెషన్ వేరుగా ఉండేలా ఇక్కడ ఖాతాలను మార్చండి.';

  @override
  String get accountNoSaved => 'ఇంకా సేవ్ చేసిన ఖాతాలు లేవు';

  @override
  String get contactRequestSent => 'అభ్యర్థన పంపబడింది';

  @override
  String get contactRequestsIncoming => 'అందిన అభ్యర్థనలు';

  @override
  String get contactRequestsOutgoing => 'పంపిన అభ్యర్థనలు';

  @override
  String get contactRequestHint =>
      'అభ్యర్థన ఆమోదించిన తర్వాత మీరు చాట్, కాల్ చేయవచ్చు.';

  @override
  String get callReturnToCall => 'కాల్‌కు తిరిగి వెళ్లండి';

  @override
  String get chatMessageSending => 'పంపుతోంది';

  @override
  String get chatMessageSent => 'పంపబడింది';

  @override
  String get chatMessageDelivered => 'చేరింది';

  @override
  String get chatMessageRead => 'చదివారు';

  @override
  String get chatMessageFailed => 'పంపబడలేదు. మళ్లీ ప్రయత్నించడానికి నొక్కండి.';

  @override
  String get chatMessageUnavailable =>
      'ఈ పరికరంలో సందేశం అందుబాటులో లేదు. రికవరీ ఎంపికలను తనిఖీ చేయడానికి నొక్కండి.';

  @override
  String get contactStarredFriends => 'స్టార్ చేసిన స్నేహితులు';

  @override
  String get chatRecipientKeysMissing =>
      'ఈ స్నేహితునికి అందుబాటులో ఉన్న ఎన్‌క్రిప్ట్ చేసిన సెషన్ లేదు. సైన్ ఇన్ చేసి యాప్ తెరవమని అడిగి మళ్లీ ప్రయత్నించండి. ఖాతాలను మార్చేటప్పుడు లాగ్ అవుట్ బదులుగా ఖాతా మార్చు ఉపయోగించండి.';

  @override
  String get chatSwitchForMessaging =>
      'ఖాతాలను మారుస్తున్నారా? సందేశాలు, సురక్షిత సెషన్లను ఉంచడానికి ఖాతా మార్చు ఉపయోగించండి. లాగ్ అవుట్ ఈ పరికర యాక్సెస్‌ను రద్దు చేస్తుంది; వచ్చే ఎన్‌క్రిప్ట్ చేసిన సందేశాలు అందుబాటులో లేకపోవచ్చు.';

  @override
  String get aiServiceUnavailable =>
      'AI సారాంశాలు ప్రస్తుతం అందుబాటులో లేవు. సేవ యాక్సెస్ పునరుద్ధరించిన తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String aiSummarizeMessages(int count) {
    return 'ఇటీవలి $count సందేశాలను సంగ్రహించండి';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return '$joined చేరారు · $invited ఆహ్వానించబడ్డారు';
  }

  @override
  String contactPendingCount(int count) {
    return '$count పెండింగ్ అభ్యర్థనలు';
  }

  @override
  String get chatDraftLabel => 'డ్రాఫ్ట్';

  @override
  String get contactIndexLabel => 'కాంటాక్ట్‌ల సూచిక';

  @override
  String get transferAssetUnavailable => 'చెల్లింపు ఆస్తి అందుబాటులో లేదు';

  @override
  String get transferPaymentRequestUnavailable =>
      'చెల్లింపు అభ్యర్థన అందుబాటులో లేదు';

  @override
  String get chatCatchUp => 'మిస్ అయిన సంభాషణను చూడండి';

  @override
  String get chatCatchUpMentions => 'ప్రస్తావనలు';

  @override
  String get chatCatchUpReplies => 'నాకు వచ్చిన ప్రత్యుత్తరాలు';

  @override
  String get chatCatchUpPinned => 'పిన్ చేసిన సందేశాలు';

  @override
  String get chatCatchUpScope =>
      'చదివినవాటితో సహా లోడ్ చేసిన సందేశాల్లో ప్రస్తావనలు, ప్రత్యుత్తరాలు వెతకబడతాయి. మునుపటి ప్రత్యుత్తరాలను కనుగొనడానికి పాత సందేశాలను లోడ్ చేయండి.';

  @override
  String get chatCatchUpLoadMore => 'పాత సందేశాలను లోడ్ చేయండి';

  @override
  String get chatActionPreview => 'క్యాలెండర్ సూచనను సమీక్షించండి';

  @override
  String get chatActionPrivacy =>
      'నిర్ధారణ తర్వాత దిగువ శీర్షిక, సమయం మాత్రమే మీ క్యాలెండర్ యాప్‌తో పంచుకోబడతాయి. టైమ్ జోన్ తనిఖీ చేయండి. మీ క్యాలెండర్ ఖాతా ఈ ఈవెంట్‌ను సింక్ చేయవచ్చు.';

  @override
  String get chatActionTitle => 'చాట్ ఈవెంట్';

  @override
  String get chatActionSuggestion => 'క్యాలెండర్ సూచన';

  @override
  String get chatUnreadAttention => 'చదవని ప్రస్తావనలు, ప్రత్యుత్తరాలు';

  @override
  String get chatScanAgain => 'మళ్లీ స్కాన్ చేయండి';

  @override
  String get chatUnreadScope =>
      'మీ రీడ్ మార్కర్ వరకు సర్వర్ చరిత్రను స్కాన్ చేస్తుంది. చదవడానికి సంభాషణను తెరవండి; ఫలితాలను మళ్లీ రూపొందించడానికి రిఫ్రెష్ చేయండి.';

  @override
  String get chatScanIncomplete =>
      'అసంపూర్ణం: చరిత్ర, డీక్రిప్షన్ లేదా రీడ్ మార్కర్ అందుబాటులో లేదు. సింక్ తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String get chatHistoryShare => 'ఎంచుకున్న చరిత్రను పంచుకోండి';

  @override
  String get chatHistoryExplanation =>
      'నిర్వాహకులకు మాత్రమే. సాదా వచనం మరియు గ్రూపులో చేరిన సభ్యునితో ఇప్పటికే ఉన్న ఎన్‌క్రిప్ట్ చేసిన ప్రత్యక్ష చాట్‌ను ఎంచుకోండి. పంచుకోవడం వల్ల గ్రూపులో కనిపించే ఆడిట్ సందేశాలు ఏర్పడతాయి.';

  @override
  String get chatHistoryEnable => 'పంచుకోవడాన్ని ప్రారంభించండి';

  @override
  String get chatHistoryDisable => 'పంచుకోవడాన్ని నిలిపివేయండి';

  @override
  String get chatHistoryPolicy => 'గ్రూపు చరిత్ర పంచుకునే విధానం';

  @override
  String get chatHistoryPolicyDetail =>
      'నిర్వాహకులు మాత్రమే పంచుకోగలరు. ప్రారంభించడం వల్ల గ్రూపు చరిత్ర కనిపించడం కూడా చేరిన తర్వాతి ఈవెంట్లకు పరిమితం అవుతుంది. దిగువ వచన సందేశ పరిమితులను సెట్ చేసి నిర్ధారించండి.';

  @override
  String get chatHistoryPolicySaved => 'విధానం సేవ్ అయింది';

  @override
  String get chatHistoryRecipient => 'గ్రహీతతో ఎన్‌క్రిప్ట్ చేసిన సంభాషణ';

  @override
  String get chatHistoryReview => 'ఎంచుకున్న సందేశాలను సమీక్షించండి';

  @override
  String get chatHistoryMessages => 'సందేశాలు';

  @override
  String get chatHistoryConfirmDetail =>
      'పంచుకునే ముందు ఈ గ్రహీతను, ప్రతి సందేశాన్ని, దాని సమయాన్ని నిర్ధారించండి. విఫలమైన లేదా తెలియని ఫలితం వచ్చినా కంటెంట్ ఇప్పటికే పంపబడి ఉండవచ్చు: కొనసాగించే ముందు పంపిన ఫలితాన్ని తనిఖీ చేయండి.';

  @override
  String get chatHistoryCompleted =>
      'ఎంచుకున్న చరిత్ర పంపబడింది, గ్రూపు ఆడిట్ నిర్ధారించబడింది';

  @override
  String get chatHistoryPending =>
      'పెండింగ్: ఫలితాన్ని తనిఖీ చేసి, కొనసాగించడానికి మళ్లీ నిర్ధారించండి. ఫలితం తెలియని పంపకాలు ఎప్పుడూ మళ్లీ పంపబడవు.';

  @override
  String get chatHistoryReconcile => 'పంపిన ఫలితాన్ని తనిఖీ చేయండి';

  @override
  String get chatHistoryFailed =>
      'పూర్తి చేయలేకపోయాము. నిర్వాహక అనుమతి, గ్రూపు విధానం, ఎన్‌క్రిప్షన్, గ్రహీత సభ్యత్వం, సందేశ ఎంపికను తనిఖీ చేయండి. పంపడం ప్రారంభమైతే దాని ఫలితాన్ని తనిఖీ చేయండి.';

  @override
  String get chatDeviceActions => 'పరికరంలో జరిగే చర్యలు';

  @override
  String get chatDeviceActionsReview =>
      'నిర్ధారణ తర్వాత ఈ సందేశం మాత్రమే పరికరంలో ప్రాసెస్ చేసే సిస్టమ్ చర్యల సూచనలకు అందించబడుతుంది. క్యాలెండర్, రిమైండర్లు లేదా మ్యాప్స్ తెరవడానికి ఒక చర్యను ఎంచుకోండి.';

  @override
  String get chatHistoryMaxMessages => 'సందేశాల పరిమితి (1–50)';

  @override
  String get chatHistoryMaxHours => 'చరిత్ర పరిధి గంటల్లో (1–720)';

  @override
  String get chatNotifyAll => 'అన్ని సందేశాలు';

  @override
  String get chatNotifyAllDescription =>
      'ఈ చాట్‌లోని ప్రతి కొత్త సందేశానికి తెలియజేయండి';

  @override
  String get chatNotifyMentions => 'ప్రస్తావనలు మాత్రమే';

  @override
  String get chatNotifyMentionsDescription =>
      'మిమ్మల్ని ప్రస్తావించినప్పుడు లేదా @room ఉపయోగించినప్పుడు మాత్రమే తెలియజేయండి';

  @override
  String get chatNotifyMutedDescription =>
      'అన్ని పరికరాల్లో ఈ చాట్ నోటిఫికేషన్‌లను ఆపివేయండి';

  @override
  String get scheduledMessagesTitle => 'షెడ్యూల్ చేసిన సందేశాలు';

  @override
  String get scheduledMessagesEmpty => 'ఇంకా షెడ్యూల్ చేసిన సందేశాలు లేవు';

  @override
  String get scheduledMessagesHint =>
      'సందేశాన్ని షెడ్యూల్ చేయడానికి పంపు, ఫోటోలు, ఫైల్‌లు, GIF లేదా స్టిక్కర్‌ను ఎక్కువసేపు నొక్కండి.';

  @override
  String get scheduledMessageCancelled =>
      'షెడ్యూల్ చేసిన సందేశం రద్దు చేయబడింది';

  @override
  String scheduledMessageCreatedAt(String time) {
    return 'సృష్టించిన సమయం: $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => 'డెలివరీ నిర్ధారించబడలేదు';

  @override
  String get scheduledRecoveryCopy => 'పునరుద్ధరణ కాపీని సేవ్ చేయండి';

  @override
  String get scheduledRecoveryCopyHint =>
      'సందేశాలను మార్చకుండా లేదా పంపకుండా ఈ పరికరంలో సేవ్ చేయబడింది. ప్రివ్యూలో గరిష్ఠంగా 8,000 అక్షరాలు కనిపిస్తాయి.';

  @override
  String get scheduledRecoveryCopies => 'పునరుద్ధరణ కాపీలు';

  @override
  String get scheduledRecoveryReset => 'దెబ్బతిన్న క్యూను రీసెట్ చేయండి';

  @override
  String get scheduledRecoveryResetHint =>
      'ఈ పరికరంలో యథాతథ కాపీ సేవ్ చేయబడింది. ఈ ఖాతాలోని షెడ్యూల్ చేసిన అన్ని సందేశాలను రీసెట్ చేయాలా? కొన్ని ఇప్పటికే పంపబడి ఉండవచ్చు. కాపీలు, అటాచ్‌మెంట్‌లు అలాగే ఉంటాయి. ఏదీ మళ్లీ పంపబడదు.';

  @override
  String get scheduledRecoveryExportHint =>
      'ఈ ఫైల్‌లో ఎన్‌క్రిప్ట్ చేయని చిత్తుప్రతి వచనం మరియు ఖాతా వివరాలు ఉన్నాయి. జోడింపులు చేర్చబడలేదు. నమ్మదగిన గమ్యస్థానాన్ని ఎంచుకోండి.';

  @override
  String get scheduledRecoveryImport => 'పునరుద్ధరణ కాపీని దిగుమతి చేయండి';

  @override
  String get scheduledRecoveryImportHint =>
      'ఈ ప్రివ్యూను పునరుద్ధరణ కాపీగా మాత్రమే సేవ్ చేయండి. సందేశాలు షెడ్యూల్ చేయబడవు లేదా పంపబడవు. జోడింపులు చేర్చబడలేదు. ఫైల్ రచయిత ధృవీకరించబడలేదు.';

  @override
  String get scheduledRecoveryComposerHint =>
      'సమీక్ష కోసం ప్రస్తుత చిత్తుప్రతికి వచనాన్ని జోడించండి. ఏదీ పంపబడదు. జోడింపులు, ప్రస్తావనలు, టైమర్‌లు పునరుద్ధరించబడవు. ఈ సందేశం ఇప్పటికే చేరిందో లేదో తనిఖీ చేయండి.';

  @override
  String get backupRecoverLegacyArchive =>
      'పాత స్థానిక చరిత్రను పునరుద్ధరించండి';

  @override
  String get backupLegacyArchiveWarning =>
      'ఈ చరిత్ర యజమాని ధృవీకరించబడలేదు. మీ గదులను మాత్రమే దిగువ ఖాతాకు కాపీ చేయండి. అసలు చరిత్ర అలాగే ఉంచబడుతుంది.';

  @override
  String get backupOlderFiles => 'పాత బ్యాకప్ ఫైళ్లు';

  @override
  String get backupOlderFilesWarning =>
      'ఈ ఫైళ్లు మరొక ఖాతాకు చెందినవి కావచ్చు. పునరుద్ధరించే ముందు విషయాన్ని, యజమానిని తనిఖీ చేయడానికి ఫైల్‌ను ఎంచుకోండి.';

  @override
  String get stickerImportTitle => 'స్టికర్ ప్యాక్‌ను దిగుమతి చేయండి';

  @override
  String get stickerImportLinkHint => 'Matrix స్టికర్ ప్యాక్ లింక్';

  @override
  String get stickerImportPreview => 'ముందస్తు వీక్షణ';

  @override
  String get stickerImportUnavailable =>
      'ఈ ప్యాక్ అందుబాటులో లేదు లేదా మీకు ప్రాప్యత లేదు.';

  @override
  String get stickerImportCopyNotice =>
      'ఈ ప్యాక్‌కు వ్యక్తిగత కాపీని జోడించండి. దీని చిత్రాలు మరియు మెటాడేటా ఎండ్-టు-ఎండ్ ఎన్‌క్రిప్ట్ చేయబడవు.';

  @override
  String get stickerImportFailed =>
      'ఈ ప్యాక్‌ను జోడించలేకపోయాము. మళ్లీ ప్రయత్నించండి.';

  @override
  String get stickerImportAccountChanged =>
      'ఖాతా మారింది లేదా సెషన్ గడువు ముగిసింది. స్టికర్ దిగుమతిని మళ్లీ తెరవండి.';

  @override
  String get stickerPackSourceRoom => 'మూల చాట్';

  @override
  String get stickerPackImages => 'చిత్రాలు';

  @override
  String get stickerPublishNotice =>
      'ఈ స్టిక్కర్ ప్యాక్‌ను ఎంచుకున్న గ్రూపులో ప్రచురించండి. చిత్రాలు, మెటాడేటా ఎండ్-టు-ఎండ్ ఎన్‌క్రిప్ట్ చేయబడవు. గ్రూపు స్థితిని చదవగలవారు వీటిని చూడవచ్చు.';

  @override
  String get stickerPublishFailed =>
      'ప్రచురణ నిర్ధారించబడలేదు. మళ్లీ ప్రయత్నించే ముందు గ్రూపును తనిఖీ చేయండి.';

  @override
  String get stickerPublishReceiptMissing =>
      'ప్రచురించబడింది, కానీ లింక్ సేవ్ కాలేదు. ఈ పేజీ నుండి వెళ్లే ముందు దాన్ని షేర్ చేయండి లేదా కాపీ చేయండి.';

  @override
  String get stickerSubscribe => 'నవీకరణలకు సభ్యత్వం పొందండి';

  @override
  String get stickerSubscribeNotice =>
      'ఈ ప్యాక్ నిర్వాహకులు చేసే తదుపరి మార్పులను పొందండి. చిత్రాలు, మెటాడేటాకు ఎండ్-టు-ఎండ్ ఎన్‌క్రిప్షన్ లేదు. తర్వాత సభ్యత్వాన్ని రద్దు చేయవచ్చు; దీనివల్ల మూల చాట్‌లో చేరరు.';

  @override
  String get stickerSubscriptions => 'స్టికర్ సభ్యత్వాలు';

  @override
  String get stickerUnsubscribe => 'సభ్యత్వాన్ని రద్దు చేయండి';

  @override
  String get stickerSubscriptionsEmpty => 'స్టికర్ సభ్యత్వాలు లేవు';

  @override
  String get chatAttachmentEvent => 'ఈవెంట్';

  @override
  String get chatRecentMedia => 'ఇటీవలి ఫోటోలు మరియు వీడియోలు';

  @override
  String get chatRecentMediaLoadFailed => 'ఇటీవలి మీడియాను లోడ్ చేయలేకపోయాము';

  @override
  String get chatRecentMediaPermission =>
      'ఇటీవలి మీడియాను చూపడానికి ఫోటోలను యాక్సెస్ చేసే అనుమతి అవసరం';

  @override
  String get chatRecentMediaEmpty => 'ఇటీవలి ఫోటోలు లేదా వీడియోలు లేవు';

  @override
  String get chatRecentPhoto => 'ఇటీవలి ఫోటో';

  @override
  String get chatRecentVideo => 'ఇటీవలి వీడియో';

  @override
  String get chatAttachmentTip => 'టిప్';

  @override
  String get chatAttachmentWhiteboard => 'వైట్‌బోర్డ్';

  @override
  String get chatAttachmentVideoNote => 'వీడియో సందేశం';

  @override
  String get chatAttachmentCode => 'కోడ్';

  @override
  String get chatAttachmentShop => 'దుకాణం';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'ఎంపిక పరిమితి: $countString';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return 'ఈ రాత్రి ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return 'రేపు ఉదయం ($time)';
  }

  @override
  String get a11yScrollToBottom => 'కిందికి స్క్రోల్ చేయండి';

  @override
  String get ui3EnterMessageBeforeScheduling =>
      'షెడ్యూల్ చేసే ముందు సందేశాన్ని నమోదు చేయండి';

  @override
  String get ui3SendCode => 'కోడ్ పంపండి';

  @override
  String get ui3CodeLanguage => 'భాష';

  @override
  String get ui3PasteCodeHere => 'కోడ్‌ను ఇక్కడ అతికించండి';

  @override
  String ui3ReminderSetAt(String time) {
    return 'రిమైండర్ సెట్ చేయబడింది · $time';
  }

  @override
  String get ui3RedPacketCreateFailed =>
      'రెడ్ ప్యాకెట్‌ను సృష్టించడం విఫలమైంది';

  @override
  String get ui3SendTip => 'టిప్ పంపండి';

  @override
  String get ui3TokenLabel => 'టోకెన్';

  @override
  String get ui3NoteOptional => 'గమనిక (ఐచ్ఛికం)';

  @override
  String ui3TipFailed(String error) {
    return 'టిప్ విఫలమైంది: $error';
  }

  @override
  String get ui3GiftNftTitle => 'NFT బహుమతిగా ఇవ్వండి';

  @override
  String get ui3TokenId => 'టోకెన్ ID';

  @override
  String ui3NftGiftFailed(String error) {
    return 'NFT బహుమతి విఫలమైంది: $error';
  }

  @override
  String get ui3AiAgentSubtitle =>
      'ఒక పనిని వివరించండి, సరైన మినీ యాప్‌ను తెరవండి';

  @override
  String get ui3GiftNft => 'NFT బహుమతి';

  @override
  String get ui3GiftNftSubtitle => 'ఈ పరిచయానికి NFT పంపండి';

  @override
  String get ui3MiniAppUnavailable => 'మినీ యాప్ అందుబాటులో లేదు';

  @override
  String ui3MediaItemsNotSent(int count) {
    return 'ఎంచుకున్న $count మీడియా అంశాలను పంపడం సాధ్యం కాలేదు';
  }

  @override
  String get ui3PhotosSubtitle =>
      'చాట్‌కు అనువైన ఫార్మాట్‌లో ఫోటోలు, వీడియోలు పంపండి';

  @override
  String get ui3OriginalImages => 'అసలు చిత్రాలు';

  @override
  String get ui3OriginalImagesSubtitle =>
      'కంప్రెస్ చేయని ఫోటోలను ఫైల్‌లుగా పంపండి';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return '$filename $timeకి షెడ్యూల్ చేయబడింది';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return 'అసలు చిత్రాన్ని పంపుతోంది: $filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return 'అసలు చిత్రం షెడ్యూల్ చేయబడింది: $filename';
  }

  @override
  String get ui3PaymentAlreadySent => 'చెల్లింపు ఇప్పటికే పంపబడింది';

  @override
  String get ui3PaymentProcessing => 'చెల్లింపు ప్రాసెస్ అవుతోంది';

  @override
  String ui3ChainStatus(String status) {
    return 'చైన్ స్థితి: $status';
  }

  @override
  String get ui3NotChecked => 'తనిఖీ చేయలేదు';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return 'నిర్ధారించబడింది: $confirmations / $required బ్లాక్‌లు';
  }

  @override
  String get ui3CopyTxHash => 'లావాదేవీ హ్యాష్‌ను కాపీ చేయండి';

  @override
  String get ui3VerifyAgain => 'మళ్లీ ధృవీకరించండి';

  @override
  String get ui3VerifyOnChain => 'చైన్‌లో ధృవీకరించండి';

  @override
  String get ui3TransferMissingChainDetails =>
      'ఈ బదిలీలో ఖచ్చితమైన చైన్, ఆస్తి వివరాలు లేవు.';

  @override
  String get ui3ReceiptPending => 'చైన్‌లో పెండింగ్‌లో ఉంది';

  @override
  String get ui3ReceiptConfirmed => 'నిర్ధారించబడింది';

  @override
  String get ui3ReceiptFailed => 'చైన్‌లో విఫలమైంది';

  @override
  String get ui3ReceiptMismatch => 'లావాదేవీ వివరాలు సరిపోలడం లేదు';

  @override
  String get ui3ReceiptUnsupported => 'చైన్ ధృవీకరణకు మద్దతు లేదు';

  @override
  String get ui3ReceiptUnavailable => 'ధృవీకరణ అందుబాటులో లేదు';

  @override
  String get ui3OpenOrSave => 'తెరువు / సేవ్ చేయి';

  @override
  String get ui3UnableToOpenFile => 'ఈ ఫైల్‌ను తెరవడం సాధ్యం కాలేదు.';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'AI తిరిగి రాయడం విఫలమైంది: $error';
  }

  @override
  String get ui3AiShareMessagesTitle => 'AIతో సందేశాలను షేర్ చేయాలా?';

  @override
  String get ui3AiShareMessagesBody =>
      'ఈ ప్రత్యుత్తరం కోసం AI ఉపయోగించగల సందేశాలను ఎంచుకోండి. ఈ ఒక్కసారి అనుమతి రెండు నిమిషాల తర్వాత గడువు ముగుస్తుంది. క్విక్ రిప్లైని మూసివేస్తే పెండింగ్ ఫలితాలు రద్దవుతాయి. ఇది చెల్లింపులు లేదా ఎగుమతులను అనుమతించదు.';

  @override
  String get ui3OtherParticipant => 'అవతలి వ్యక్తి';

  @override
  String get ui3ShareSelected => 'ఎంచుకున్నవి షేర్ చేయండి';

  @override
  String get ui3BotCommandError => 'కమాండ్ లోపం';

  @override
  String get ui3BotUnknownCommand => 'తెలియని కమాండ్';

  @override
  String get ui3BotTypeHelp =>
      'అందుబాటులో ఉన్న కమాండ్‌లను చూడటానికి /help టైప్ చేయండి.';

  @override
  String get ui3FilesMediaLinks => 'ఫైల్‌లు, మీడియా & లింక్‌లు';

  @override
  String get ui3ChatStorage => 'చాట్ నిల్వ';

  @override
  String get ui3EncryptionKeysDevices => 'ఎన్‌క్రిప్షన్ కీలు & పరికరాలు';

  @override
  String get ui3EncryptionServiceUnavailable =>
      'ఎన్‌క్రిప్షన్ సేవ ఇంకా అందుబాటులో లేదు';

  @override
  String get ui3ExportLoadingHistory =>
      'ఎగుమతి కోసం మరింత చాట్ చరిత్రను లోడ్ చేస్తోంది...';

  @override
  String get ui3ExportTxtDesc =>
      'గమనికలు, బ్యాకప్ లేదా సమ్మతి సమీక్ష కోసం సాదా టెక్స్ట్ ట్రాన్స్‌క్రిప్ట్';

  @override
  String get ui3ExportCustomRange => 'అనుకూల పరిధి';

  @override
  String get ui3ExportStart => 'ప్రారంభం';

  @override
  String get ui3ExportEnd => 'ముగింపు';

  @override
  String get ui3ExportSelectDate => 'తేదీని ఎంచుకోండి';

  @override
  String get ui3FolderFilterUnreadOnly => 'చదవనివి మాత్రమే';

  @override
  String get ui3FolderFilterMutedOnly => 'మ్యూట్ చేసినవి మాత్రమే';

  @override
  String get ui3FolderFilterNoDms => 'ప్రత్యక్ష సందేశాలు మినహా';

  @override
  String get ui3FolderFilterNoGroups => 'గ్రూప్‌లు మినహా';

  @override
  String get ui3FolderFilterNoChannels => 'ఛానెల్‌లు మినహా';

  @override
  String get ui3FolderFilterAllChats => 'అన్ని చాట్‌లు';

  @override
  String get ui3Create => 'సృష్టించు';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return '\"$name\" ఫోల్డర్‌ను తొలగించాలా?';
  }

  @override
  String get a11yDecreaseTextSize => 'టెక్స్ట్ పరిమాణం తగ్గించండి';

  @override
  String get a11yIncreaseTextSize => 'టెక్స్ట్ పరిమాణం పెంచండి';

  @override
  String ui3MinutesRead(int minutes) {
    return '$minutes నిమిషాల పఠనం';
  }

  @override
  String get ui3TipOnChain => 'ఆన్-చైన్ ✓';

  @override
  String get ui3ViewSource => 'సోర్స్ చూడండి';

  @override
  String get a11yPreviousPage => 'మునుపటి పేజీ';

  @override
  String get a11yNextPage => 'తదుపరి పేజీ';

  @override
  String get ui3OpenExternalLinkTitle => 'బాహ్య లింక్‌ను తెరవాలా?';

  @override
  String get ui3Open => 'తెరువు';

  @override
  String get ui3UnableToOpenLink => 'ఈ లింక్‌ను తెరవడం సాధ్యం కాలేదు.';

  @override
  String get ui3ImageUnavailable => 'చిత్రం అందుబాటులో లేదు';

  @override
  String ui3LoadImageFrom(Object host) {
    return '$host నుండి చిత్రాన్ని లోడ్ చేయండి';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return '$host నుండి చిత్రాన్ని మళ్లీ లోడ్ చేయండి';
  }

  @override
  String get ui3TranslatedByN42 => 'N42 ద్వారా అనువదించబడింది';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return 'N42 ద్వారా $language నుండి అనువదించబడింది';
  }

  @override
  String get ui3ClearWhiteboardTitle => 'వైట్‌బోర్డ్‌ను క్లియర్ చేయాలా?';

  @override
  String get ui3ClearWhiteboardMessage =>
      'అందరికీ అన్ని గీతలు తీసివేయబడతాయి. దీన్ని రద్దు చేయలేరు.';

  @override
  String get ui3WhiteboardLive => 'వైట్‌బోర్డ్ · లైవ్';

  @override
  String get a11yPenColor => 'పెన్ రంగు';

  @override
  String get ui3AiDescribeOcr => 'AI వివరణ / OCR';

  @override
  String get ui3DocumentPreviewFailed =>
      'ఈ పత్రాన్ని సురక్షితంగా ప్రివ్యూ చేయడం సాధ్యం కాలేదు. కనెక్షన్, ఫైల్ పరిమాణాన్ని తనిఖీ చేయండి (గరిష్ఠం 2MB).';

  @override
  String get ui3AiConsentMessage =>
      'ఈ సారాంశం కోసం AI ఉపయోగించగల సందేశాలను ఎంచుకోండి. ఈ ఒక్కసారి అనుమతి రెండు నిమిషాల తర్వాత గడువు ముగుస్తుంది. ఇది చెల్లింపులు లేదా ఎగుమతులను అనుమతించదు.';

  @override
  String get ui3AiSuggestedReplies => 'సూచించిన ప్రత్యుత్తరాలు';

  @override
  String get ui3AiGeneratingSuggestions => 'సూచనలను రూపొందిస్తోంది...';

  @override
  String get ui3StickersEmpty => 'ఇంకా స్టిక్కర్‌లు లేవు';

  @override
  String get ui3StickersGet => 'స్టిక్కర్‌లను పొందండి';

  @override
  String get a11yFormatBold => 'బోల్డ్';

  @override
  String get a11yFormatItalic => 'ఇటాలిక్';

  @override
  String get a11yFormatStrikethrough => 'స్ట్రైక్‌త్రూ';

  @override
  String get a11yFormatInlineCode => 'ఇన్‌లైన్ కోడ్';

  @override
  String get a11yFormatCodeBlock => 'కోడ్ బ్లాక్';

  @override
  String get a11yFormatChecklistItem => 'చెక్‌లిస్ట్ అంశం';

  @override
  String get a11yFormatBulletList => 'బుల్లెట్ జాబితా';

  @override
  String get a11yFormatNumberedList => 'సంఖ్యల జాబితా';

  @override
  String get a11yFormatLink => 'లింక్';

  @override
  String get a11yFormatTable => 'పట్టిక';

  @override
  String get a11yFormatMeetingTemplate => 'మీటింగ్ టెంప్లేట్';

  @override
  String get a11yEmojiSmileys => 'స్మైలీలు & వ్యక్తులు';

  @override
  String get a11yEmojiHearts => 'హృదయాలు';

  @override
  String get a11yEmojiAnimals => 'జంతువులు & ప్రకృతి';

  @override
  String get a11yEmojiFood => 'ఆహారం & పానీయాలు';

  @override
  String get a11yEmojiTravel => 'ప్రయాణం & ప్రదేశాలు';

  @override
  String get a11yEmojiActivities => 'కార్యకలాపాలు';

  @override
  String get a11yEmojiObjects => 'వస్తువులు';

  @override
  String get a11yEmojiSymbols => 'చిహ్నాలు';

  @override
  String get ui3FrequentlyUsed => 'తరచుగా ఉపయోగించినవి';

  @override
  String get ui3NoEditHistory => 'సవరణ చరిత్ర లేదు';

  @override
  String get ui3EventNew => 'కొత్త ఈవెంట్';

  @override
  String get ui3EventTitleLabel => 'శీర్షిక';

  @override
  String get ui3EventLocationOptional => 'స్థానం (ఐచ్ఛికం)';

  @override
  String get ui3EventDescriptionOptional => 'వివరణ (ఐచ్ఛికం)';

  @override
  String get ui3EventSend => 'ఈవెంట్ పంపండి';

  @override
  String get ui3EventTitleRequired => 'శీర్షిక అవసరం';

  @override
  String get ui3EventEndAfterStart => 'ముగింపు సమయం ప్రారంభం తర్వాత ఉండాలి';

  @override
  String get ui3MiniAppAgentIntro =>
      'మీరు ఏం చేయాలనుకుంటున్నారో వివరించండి — సరైన మినీ యాప్‌ను తెరుస్తాను.';

  @override
  String get ui3MiniAppAgentExample => 'ఉదా. ETHని USDCకి స్వాప్ చేయండి';

  @override
  String get ui3MiniAppAgentNoMatch =>
      'సరిపోలే మినీ యాప్ కనుగొనబడలేదు. వేరే విధంగా చెప్పి చూడండి.';

  @override
  String ui3MiniAppOpen(Object appName) {
    return '$appName తెరవండి';
  }

  @override
  String get ui3MusicLinkPlatforms =>
      'NetEase Cloud Music, QQ Music, Kugou, Kuwo మరియు మరిన్నింటి పాటల లింక్‌లకు మద్దతు ఉంది';

  @override
  String get ui3PollMarkCorrectAnswer =>
      'ఖాళీ కాని సరైన సమాధానాన్ని గుర్తించండి';

  @override
  String get ui3PollQuizMode => 'క్విజ్ మోడ్';

  @override
  String get ui3PollAnswerExplanationHint => 'సమాధాన వివరణ (ఐచ్ఛికం)';

  @override
  String get a11yCorrectAnswer => 'సరైన సమాధానం';

  @override
  String get ui3AiSuggestions => 'AI సూచనలు';

  @override
  String get a11yPaste => 'అతికించండి';

  @override
  String get a11yRefresh => 'రిఫ్రెష్ చేయండి';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      'ఈ కీని సురక్షితంగా భద్రపరచండి. అన్ని పరికరాలకు యాక్సెస్ కోల్పోతే, మీ ఎన్‌క్రిప్ట్ చేసిన సందేశాలను తిరిగి పొందడానికి ఇదే ఏకైక మార్గం.';

  @override
  String ui3SavedToPath(Object path) {
    return 'సేవ్ చేయబడింది: $path';
  }

  @override
  String get ui3UnknownAccount => 'తెలియని ఖాతా';

  @override
  String get ui3UnknownHomeserver => 'తెలియని హోమ్‌సర్వర్';

  @override
  String get ui3ImportRecoveryKey => 'రికవరీ కీని దిగుమతి చేయండి';

  @override
  String get ui3ImportRecoveryKeyDesc =>
      'ఎన్‌క్రిప్ట్ చేసిన సందేశ చరిత్రకు రూమ్ కీలను పునరుద్ధరించడానికి మీ రికవరీ కీని నమోదు చేయండి లేదా అతికించండి.';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return 'ఖాతా: $account\\nహోమ్‌సర్వర్: $homeserver';
  }

  @override
  String get ui3Import => 'దిగుమతి చేయండి';

  @override
  String get ui3InvalidRecoveryKeyFormat => 'రికవరీ కీ ఫార్మాట్ చెల్లదు';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return '$total కీలలో $restored పునరుద్ధరించబడ్డాయి. $failed కీలు విఫలమయ్యాయి. ఖాతా, నెట్‌వర్క్, బ్యాకప్‌ను తనిఖీ చేసి మళ్లీ ప్రయత్నించండి. కొంత చరిత్ర చదవలేనిదిగా ఉండిపోవచ్చు.';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return '$total కీలలో $restored విజయవంతంగా పునరుద్ధరించబడ్డాయి';
  }

  @override
  String ui3ImportFailed(Object error) {
    return 'దిగుమతి విఫలమైంది: $error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return 'పాస్‌కీ నమోదు విఫలమైంది: $error';
  }

  @override
  String get ui3PasskeyDefaultName => 'నా పాస్‌కీ';

  @override
  String get ui3PasskeyNameHint => 'ఉదా. iPhone, MacBook';

  @override
  String get ui3PasskeyDeleteFailed => 'పాస్‌కీని తొలగించడం విఫలమైంది';

  @override
  String get ui3TwoFactorAuth => 'రెండు-దశల ప్రమాణీకరణ';

  @override
  String get ui3TwoFactorOnSubtitle => 'ఆన్ — ప్రమాణీకరణ యాప్ కోడ్ అవసరం';

  @override
  String get ui3TwoFactorOffSubtitle =>
      'ఆఫ్ — ప్రమాణీకరణ యాప్‌తో (TOTP) రక్షించండి';

  @override
  String get ui3ShowRecoveryKey => 'రికవరీ కీని చూపించు';

  @override
  String get ui3ShowRecoveryKeyDesc =>
      'బ్యాకప్ కోసం మీ రికవరీ కీని ప్రదర్శించండి';

  @override
  String get ui3ImportRecoveryKeyHint =>
      'రికవరీ కీతో సందేశాలను పునరుద్ధరించండి';

  @override
  String get ui3RecoveryKeyCreateFailed => 'రికవరీ కీని సృష్టించడం విఫలమైంది';

  @override
  String get ui3TotpIncorrectCode => 'తప్పు కోడ్, మళ్లీ ప్రయత్నించండి';

  @override
  String get ui3TwoFactorEnabled => 'రెండు-దశల ప్రమాణీకరణ ప్రారంభించబడింది';

  @override
  String get ui3TwoFactorDisabled => 'రెండు-దశల ప్రమాణీకరణ నిలిపివేయబడింది';

  @override
  String get ui3TwoFactorTurnOffTitle => 'రెండు-దశల ప్రమాణీకరణను ఆఫ్ చేయాలా?';

  @override
  String get ui3TwoFactorTurnOffMessage =>
      'మీ ప్రమాణీకరణ యాప్ ఇకపై అవసరం ఉండదు. తర్వాత కొత్త కీతో మళ్లీ సెటప్ చేయవచ్చు.';

  @override
  String get ui3TurnOff => 'ఆఫ్ చేయండి';

  @override
  String get ui3TwoFactorTotpTitle => 'రెండు-దశలు (TOTP)';

  @override
  String get ui3TwoFactorIsOn => 'రెండు-దశల ప్రమాణీకరణ ఆన్‌లో ఉంది';

  @override
  String get ui3TwoFactorCodeRequired => 'మీ ప్రమాణీకరణ యాప్ నుండి కోడ్ అవసరం.';

  @override
  String get ui3TotpStepScan =>
      '1. ఈ QRని ప్రమాణీకరణ యాప్‌తో (Google Authenticator, Authy, 1Password…) స్కాన్ చేయండి, లేదా కీని మాన్యువల్‌గా నమోదు చేయండి.';

  @override
  String get ui3TotpKeyCopied => 'కీ కాపీ చేయబడింది';

  @override
  String get ui3TotpStepConfirm =>
      '2. నిర్ధారించడానికి 6 అంకెల కోడ్‌ను నమోదు చేయండి.';

  @override
  String get ui3Enable => 'ప్రారంభించండి';

  @override
  String get ui3BackupSettingsDesc =>
      'మీ స్థానిక చాట్ సెట్టింగ్‌లను బ్యాకప్ చేయండి. మళ్లీ లాగిన్ అయిన తర్వాత సందేశాలు సర్వర్ నుండి పునరుద్ధరించబడతాయి.';

  @override
  String get ui3BackupKeysSeparate =>
      'ఎన్‌క్రిప్షన్ కీలు విడిగా నిర్వహించబడతాయి';

  @override
  String get ui3BackupKeysSeparateHint =>
      'ఎన్‌క్రిప్ట్ చేసిన సందేశాల యాక్సెస్‌ను బ్యాకప్ చేయడానికి భద్రత > రికవరీ కీని ఉపయోగించండి.';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return '$rooms రూమ్‌లు  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      'మరొక పరికరం లేదా మునుపటి బ్యాకప్ నుండి .n42backup ఫైల్‌ను దిగుమతి చేయండి. ఎన్‌క్రిప్షన్ కీలు మీ రికవరీ కీతో విడిగా పునరుద్ధరించబడతాయి.';

  @override
  String get ui3UsernameSessionRequired => 'యూజర్‌నేమ్‌కు సక్రియ సెషన్ అవసరం';

  @override
  String get ui3SecuritySessionRequired =>
      'భద్రతా సెట్టింగ్‌లకు సక్రియ సెషన్ అవసరం';

  @override
  String get ui3ConnectedAccountsSessionRequired =>
      'కనెక్ట్ చేసిన ఖాతాలకు సక్రియ సెషన్ అవసరం';

  @override
  String get ui3SystemAccounts => 'సిస్టమ్ & ఖాతాలు';

  @override
  String get ui3AccountIdentity => 'ఖాతా & గుర్తింపు';

  @override
  String get ui3Accounts => 'ఖాతాలు';

  @override
  String get ui3DevicesSessions => 'పరికరాలు & సెషన్‌లు';

  @override
  String get ui3Integrations => 'ఇంటిగ్రేషన్‌లు';

  @override
  String get ui3ConnectedAccounts => 'కనెక్ట్ చేసిన ఖాతాలు';

  @override
  String get ui3ConnectedAccountsDesc =>
      'Telegram, WhatsApp, Discord మరియు API బ్రిడ్జ్ ఇంటిగ్రేషన్‌లు';

  @override
  String get ui3SystemOverview => 'సిస్టమ్ అవలోకనం';

  @override
  String ui3AccountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ఖాతాలు',
      one: '1 ఖాతా',
    );
    return '$_temp0';
  }

  @override
  String ui3DeviceCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count పరికరాలు',
      one: '1 పరికరం',
    );
    return '$_temp0';
  }

  @override
  String get ui3PrivacySecurityOverview =>
      'ఎండ్-టు-ఎండ్ ఎన్‌క్రిప్షన్, స్క్రీన్‌షాట్ రక్షణ మరియు ప్రాక్సీ నియంత్రణలు';

  @override
  String get ui3ConversationPrivacy => 'సంభాషణ గోప్యత';

  @override
  String get ui3NetworkPrivacy => 'నెట్‌వర్క్ గోప్యత';

  @override
  String get ui3IdentityPrivacy => 'గుర్తింపు గోప్యత';

  @override
  String get ui3EncryptionKeyBackup => 'ఎన్‌క్రిప్షన్ & కీ బ్యాకప్';

  @override
  String get ui3DevicesVerification => 'పరికరాలు & ధృవీకరణ';

  @override
  String get ui3ChipE2eeDefault => 'డిఫాల్ట్ E2EE';

  @override
  String get ui3ChipManualE2ee => 'మాన్యువల్ E2EE';

  @override
  String get ui3ChipSelfDestruct => 'స్వీయ వినాశనం';

  @override
  String get ui3ChipScreenshotGuard => 'స్క్రీన్‌షాట్ రక్షణ';

  @override
  String get ui3ChipIpProxy => 'IP / ప్రాక్సీ';

  @override
  String get ui3ChipLinkPreviewsOff => 'లింక్ ప్రివ్యూలు ఆఫ్';

  @override
  String get ui3ChipPublicHandle => 'పబ్లిక్ యూజర్‌నేమ్';

  @override
  String get a11yShowPassword => 'పాస్‌వర్డ్ చూపించు';

  @override
  String get a11yHidePassword => 'పాస్‌వర్డ్ దాచు';

  @override
  String get a11yCheckServer => 'సర్వర్‌ను తనిఖీ చేయి';

  @override
  String get ui3AuthAnonymousRegistration => 'అనామక నమోదు';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      'ఫోన్ లేదా ఈమెయిల్ లింక్ చేయకుండానే ఖాతాను సృష్టించండి. యూజర్‌నేమ్ ఆటోమేటిక్‌గా రూపొందించబడుతుంది.';

  @override
  String get ui3AuthAnonymousModeOn => 'అనామక మోడ్ ఆన్‌లో ఉంది';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      'యాప్ మీ కోసం యాదృచ్ఛిక Matrix యూజర్‌నేమ్‌ను సృష్టిస్తుంది. తర్వాత రూపొందించిన ఖాతా మరియు పాస్‌వర్డ్‌తో సైన్ ఇన్ చేయవచ్చు.';

  @override
  String get ui3AuthChooseLoginMethod => 'లాగిన్ పద్ధతిని ఎంచుకోండి';

  @override
  String get ui3AuthSsoOpenFailed => 'SSO లాగిన్ పేజీని తెరవడం విఫలమైంది';

  @override
  String get ui3AuthWalletUnavailable => 'వాలెట్ అందుబాటులో లేదు';

  @override
  String get ui3ProfileSubscriptions => 'సబ్‌స్క్రిప్షన్‌లు';

  @override
  String get ui3ProfileBuySellCrypto => 'క్రిప్టో కొనండి / అమ్మండి';

  @override
  String get ui3ProfileOnDeviceAi => 'పరికరంలోనే AI';

  @override
  String get ui3ProfileSetAUsername => 'యూజర్‌నేమ్ సెట్ చేయండి';

  @override
  String get ui3ProfileAvatarStudio => 'అవతార్ స్టూడియో';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'NFT అవతార్ / అలంకరణలు';

  @override
  String get ui3ProfileCustomize => 'అనుకూలీకరించు';

  @override
  String get ui3ProfileQrSubtitle =>
      'ఈ ప్రొఫైల్‌ను తెరవడానికి లేదా చాట్ ప్రారంభించడానికి స్కాన్ చేయండి';

  @override
  String get ui3PrivacyHardening => 'గోప్యత బలోపేతం';

  @override
  String get ui3HidePhoneNumber => 'ఫోన్ నంబర్ దాచు';

  @override
  String get ui3HidePhoneNumberDesc =>
      'ఈ పరికరంలోని ప్రొఫైల్ పేజీలలో లింక్ చేసిన ఫోన్ నంబర్‌ను దాచండి';

  @override
  String get ui3EncryptNewChatsByDefault =>
      'కొత్త చాట్‌లను డిఫాల్ట్‌గా ఎన్‌క్రిప్ట్ చేయి';

  @override
  String get ui3EncryptNewChatsByDefaultDesc =>
      'కొత్త డైరెక్ట్ చాట్‌లు మరియు ప్రైవేట్ రూమ్‌లను E2EE ఆన్‌తో ప్రారంభించండి';

  @override
  String get ui3PrivateChatMode => 'ప్రైవేట్ చాట్ మోడ్';

  @override
  String get ui3PrivateChatModeDesc =>
      'ప్రైవేట్ లేదా ఎన్‌క్రిప్ట్ చేసిన చాట్‌లను చూస్తున్నప్పుడు తాత్కాలికంగా స్క్రీన్‌షాట్‌లను నిరోధించండి';

  @override
  String get ui3DefaultSelfDestructTimer => 'డిఫాల్ట్ స్వీయ వినాశన టైమర్';

  @override
  String get ui3DefaultSelfDestructTimerDesc =>
      'కొత్తగా పంపే సందేశాలకు డిఫాల్ట్ స్వీయ వినాశన టైమర్‌ను వర్తింపజేయండి';

  @override
  String get ui3LinkPreviews => 'లింక్ ప్రివ్యూలు';

  @override
  String get ui3LinkPreviewsDesc =>
      'సందేశాలలో URLలు ఉన్నప్పుడు శీర్షికలు, వివరణలు, థంబ్‌నెయిల్‌లను పొందండి';

  @override
  String get ui3IpAddressProtection => 'IP చిరునామా రక్షణ';

  @override
  String get ui3IpAddressProtectionDesc =>
      'అందుబాటులో ఉన్నప్పుడు Matrix మరియు లింక్ ప్రివ్యూ అభ్యర్థనలను మీరు కాన్ఫిగర్ చేసిన HTTP గోప్యతా ప్రాక్సీ ద్వారా పంపండి';

  @override
  String get ui3UseTorProxy => 'Tor / Privoxy HTTP ప్రాక్సీని ఉపయోగించు';

  @override
  String get ui3UseTorProxyDesc =>
      '127.0.0.1:8118లో Privoxy వంటి లోకల్ HTTP ప్రాక్సీ ఎండ్‌పాయింట్‌ను ఉపయోగించండి. నేటివ్ SOCKS5 Tor రూటింగ్‌కు ఇక్కడ మద్దతు లేదు.';

  @override
  String get ui3CustomProxy => 'అనుకూల ప్రాక్సీ';

  @override
  String get ui3CustomProxyDesc =>
      'Matrix ట్రాఫిక్ మరియు లింక్ ప్రివ్యూల కోసం అనుకూల HTTP లేదా HTTPS ప్రాక్సీని ఉపయోగించండి';

  @override
  String get ui3ProxyEndpoint => 'ప్రాక్సీ చిరునామా';

  @override
  String get ui3ProxyEndpointDesc =>
      'HTTP/HTTPS ప్రాక్సీ చిరునామా (SOCKSకు మద్దతు లేదు)';

  @override
  String get ui3InvalidEndpoint => 'చెల్లని చిరునామా';

  @override
  String get ui3CustomProxyStaysOff =>
      'చెల్లుబాటు అయ్యే చిరునామాను సెట్ చేసే వరకు అనుకూల ప్రాక్సీ ఆఫ్‌లోనే ఉంటుంది';

  @override
  String get ui3NotificationFilterNote =>
      'ప్రాధాన్యత నియమాలు ఎల్లప్పుడూ తెలియజేస్తాయి (మ్యూట్, ప్రస్తావనలు మాత్రమే, అంతరాయం కలిగించవద్దు వాటిని దాటవేసి). మ్యూట్ చేసిన కీవర్డ్‌లు నోటిఫికేషన్‌లను ఆపుతాయి.';

  @override
  String get ui3PriorityKeywords => 'ప్రాధాన్యత కీవర్డ్‌లు';

  @override
  String get ui3PriorityKeywordHint => 'ఉదా. అత్యవసరం';

  @override
  String get ui3MutedKeywords => 'మ్యూట్ చేసిన కీవర్డ్‌లు';

  @override
  String get ui3MutedKeywordHint => 'ఉదా. స్పామ్';

  @override
  String get ui3PrioritySenders => 'ప్రాధాన్యత పంపినవారు';

  @override
  String get ui3CaseSensitive => 'అక్షరాల కేస్‌ను పరిగణించు';

  @override
  String get ui3None => 'ఏవీ లేవు';

  @override
  String get ui3SmartReplyTranslation => 'స్మార్ట్ రిప్లై అనువాదం';

  @override
  String get ui3SmartReplyTranslationDesc =>
      'పంపే ముందు మీ సందేశాలను స్వీకర్త భాషలోకి ఆటోమేటిక్‌గా అనువదించండి.';

  @override
  String get ui3FromPhotos => 'ఫోటోల నుండి';

  @override
  String get ui3ChangePhoto => 'ఫోటో మార్చు';

  @override
  String get ui3RoamingUsesMobileData =>
      'రోమింగ్‌లో మొబైల్ డేటా నియమాలు వర్తిస్తాయి';

  @override
  String get ui3RoamingUsesMobileDataDesc =>
      'ప్రత్యేక రోమింగ్ గుర్తింపు ఇంకా అందుబాటులో లేదు, కాబట్టి రోమింగ్ ప్రస్తుతం మొబైల్ డేటా ఆటో-డౌన్‌లోడ్ సెట్టింగ్‌లను అనుసరిస్తుంది.';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return '\"$content\"ను తొలగించాలా?';
  }

  @override
  String get ui3ResetToDefaults => 'డిఫాల్ట్‌లకు రీసెట్ చేయి';

  @override
  String get ui3ResetQuickRepliesMessage =>
      'ఇది అన్ని అనుకూల త్వరిత ప్రత్యుత్తరాలను తీసివేసి డిఫాల్ట్‌లను పునరుద్ధరిస్తుంది. కొనసాగించాలా?';

  @override
  String get ui3LocalLlmUnavailable => 'ఈ పరికరంలో మద్దతు లేదు';

  @override
  String get ui3LocalLlmNotDownloaded => 'మోడల్ డౌన్‌లోడ్ కాలేదు';

  @override
  String get ui3LocalLlmReady => 'సిద్ధం (పరికరంలో)';

  @override
  String get ui3LocalLlmDescription =>
      'ఆన్ చేసి సిద్ధంగా ఉన్నప్పుడు AI ఫీచర్‌లు (సారాంశం, తిరిగి రాయడం, అనువాదం, ప్రత్యుత్తరాలు) పూర్తిగా పరికరంలోనే నడుస్తాయి — డేటా మీ ఫోన్‌ను ఎప్పటికీ దాటదు. లేకపోతే అవి క్లౌడ్ ప్రొవైడర్‌ను ఉపయోగిస్తాయి.';

  @override
  String get ui3UseOnDeviceAi => 'పరికరంలోనే AIని ఉపయోగించు';

  @override
  String get ui3UseOnDeviceAiDesc =>
      'సిద్ధంగా ఉన్నప్పుడు లోకల్ ఇన్ఫరెన్స్‌కు ప్రాధాన్యం';

  @override
  String get ui3DownloadModel => 'మోడల్‌ను డౌన్‌లోడ్ చేయి';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      'పరికరంలో ఇన్ఫరెన్స్‌కు నేటివ్ రన్‌టైమ్ (Android MediaPipe / iOS Core ML) అవసరం. ప్లాట్‌ఫామ్ హ్యాండ్లర్ అందుబాటులోకి రాగానే ఇది ఆటోమేటిక్‌గా సక్రియం అవుతుంది.';

  @override
  String get ui3PhotoAvatar => 'ఫోటో అవతార్';

  @override
  String get ui3AvatarStyles => 'అవతార్ శైలులు';

  @override
  String get ui3AvatarStylesDesc =>
      'ప్రొఫైల్ మరియు అవతార్ ఎంట్రీ పాయింట్‌ల కోసం ఒకే అలంకరణ సెలెక్టర్‌ను ఉపయోగించండి.';

  @override
  String get ui3ReplaceNftAvatar => 'NFT అవతార్‌ను మార్చు';

  @override
  String get ui3NftAvatarDesc =>
      'ఆన్-చెయిన్ సేకరణ వస్తువును మీ అవతార్‌గా ఉపయోగించండి.';

  @override
  String get ui3UsePhotoAvatar => 'ఫోటో అవతార్‌ను ఉపయోగించు';

  @override
  String get ui3UsePhotoAvatarDesc =>
      'అప్‌లోడ్ చేసిన అవతార్‌ను ఉంచి NFT లింక్‌ను తీసివేయండి.';

  @override
  String ui3AvatarStyleSet(Object name) {
    return 'అవతార్ శైలి సెట్ చేయబడింది: $name';
  }

  @override
  String get ui3NftAvatarUpdated => 'NFT అవతార్ అప్‌డేట్ అయింది';

  @override
  String get ui3SwitchedToPhotoAvatar => 'ఫోటో అవతార్‌కు తిరిగి మారింది';

  @override
  String get ui3SignInToViewRedPacketHistory =>
      'రెడ్ ప్యాకెట్ చరిత్రను చూడటానికి సైన్ ఇన్ చేయండి';

  @override
  String get ui3RedPacketActive => 'సక్రియం';

  @override
  String get ui3RedPacketCompleted => 'పూర్తయింది';

  @override
  String get ui3CardsAndPasses => 'కార్డ్‌లు మరియు పాస్‌లు';

  @override
  String get ui3CardsAndPassesDesc =>
      'వాలెట్ కార్డ్‌లు, కూపన్‌లు మరియు పాస్‌లు ప్రధాన యాప్‌లో నిర్వహించబడతాయి.';

  @override
  String get ui3CardPackRequiresMainApp => 'కార్డ్ ప్యాక్‌కు ప్రధాన యాప్ అవసరం';

  @override
  String get ui3OpenCardPack => 'కార్డ్ ప్యాక్‌ను తెరువు';

  @override
  String get ui3UnableToOpenChat => 'ఈ పరిచయంతో చాట్‌ను తెరవడం సాధ్యం కాలేదు';

  @override
  String get ui3WalletManagedInMainApp =>
      'వాలెట్ ప్రధాన యాప్‌లో నిర్వహించబడుతుంది';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · ప్లాన్‌లు';
  }

  @override
  String get ui3NewPlan => 'కొత్త ప్లాన్';

  @override
  String get ui3MySubscriptions => 'నా సబ్‌స్క్రిప్షన్‌లు';

  @override
  String get ui3AvailablePlans => 'అందుబాటులో ఉన్న ప్లాన్‌లు';

  @override
  String get ui3NoPlansYet =>
      'ఇంకా ప్లాన్‌లు లేవు · సృష్టించడానికి \"కొత్త ప్లాన్\" నొక్కండి';

  @override
  String ui3DaysLeft(Object days) {
    return '$days రోజులు మిగిలి ఉన్నాయి';
  }

  @override
  String get ui3SubscriptionCancelled => 'రద్దు చేయబడింది';

  @override
  String get ui3AutoRenewOn => 'ఆటో-రెన్యూ: ఆన్';

  @override
  String get ui3AutoRenewOff => 'ఆటో-రెన్యూ: ఆఫ్';

  @override
  String get ui3CancelSubscriptionTitle => 'సబ్‌స్క్రిప్షన్ రద్దు చేయాలా?';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return '$nameకు మీ సబ్‌స్క్రిప్షన్ గడువు ముగిసే వరకు సక్రియంగా ఉంటుంది, పునరుద్ధరించబడదు.';
  }

  @override
  String get ui3Subscribe => 'సబ్‌స్క్రైబ్ చేయండి';

  @override
  String ui3SubscribedTo(Object name) {
    return '$nameకు సబ్‌స్క్రైబ్ అయ్యారు';
  }

  @override
  String get ui3PlanPriceLabel => 'ధర (ఉదా. 9.9 USDT)';

  @override
  String get ui3PlanDescriptionLabel => 'వివరణ (ఐచ్ఛికం)';

  @override
  String get ui3PlanBenefitsLabel => 'ప్రయోజనాలు (కామాలతో వేరు చేయండి)';

  @override
  String get ui3PlanPeriod => 'వ్యవధి:';

  @override
  String get ui3Monthly => 'నెలవారీ';

  @override
  String get ui3Yearly => 'వార్షిక';

  @override
  String get ui3SaveRemarkFailed => 'గమనికను సేవ్ చేయడం విఫలమైంది';

  @override
  String get ui3CopyLink => 'లింక్ కాపీ చేయండి';

  @override
  String get ui3Connect => 'కనెక్ట్ అవ్వండి';

  @override
  String get ui3CommonTokens => 'ఉమ్మడి టోకెన్‌లు';

  @override
  String get ui3SharedNfts => 'ఉమ్మడి NFTలు';

  @override
  String get ui3TransactionHistory => 'లావాదేవీ చరిత్ర';

  @override
  String get ui3CommonDaos => 'ఉమ్మడి DAOలు';

  @override
  String get ui3SameChains => 'ఒకే చైన్‌లు';

  @override
  String get ui3ChatInitFailed => 'చాట్ ప్రారంభం విఫలమైంది';

  @override
  String get ui3CheckNetworkRetry =>
      'దయచేసి మీ నెట్‌వర్క్‌ను తనిఖీ చేసి మళ్లీ ప్రయత్నించండి';

  @override
  String get ui3FromContacts => 'పరిచయాల నుండి';

  @override
  String get ui3FindFriendsFromContacts =>
      'మీ ఫోన్ పరిచయాల నుండి స్నేహితులను కనుగొనండి';

  @override
  String get ui3EnsOrDomain => 'ENS / డొమైన్';

  @override
  String get ui3LoadingContacts => 'పరిచయాలు లోడ్ అవుతున్నాయి...';

  @override
  String get ui3ContactsPermissionRequired => 'పరిచయాల అనుమతి అవసరం';

  @override
  String get ui3ContactsPermissionMessage =>
      'మీ పరిచయాల నుండి స్నేహితులను కనుగొనడానికి, దయచేసి పరిచయాలకు యాక్సెస్ అనుమతించండి.';

  @override
  String get ui3AllowAccess => 'యాక్సెస్ అనుమతించండి';

  @override
  String get ui3NoContactMatches => 'సరిపోలికలు ఏవీ కనుగొనబడలేదు';

  @override
  String get ui3NoContactMatchesMessage =>
      'మీ పరిచయాల్లో ఎవరూ ఇంకా ఈ యాప్‌ను ఉపయోగించడం లేదు. వారిని ఆహ్వానించండి!';

  @override
  String ui3ScannedContacts(Object count) {
    return '$count పరిచయాలు స్కాన్ చేయబడ్డాయి';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return 'మీ పరిచయాల్లో $count సరిపోలికలు కనుగొనబడ్డాయి';
  }

  @override
  String ui3InContactsAs(Object name) {
    return 'పరిచయాల్లో: $name';
  }

  @override
  String get ui3DeletePhotoConfirm => 'ఈ ఫోటోను తొలగించాలా?';

  @override
  String get ui3InviteLink => 'ఆహ్వాన లింక్';

  @override
  String get ui3ShareJoinLink => 'ఈ రూమ్‌లో చేరడానికి లింక్‌ను షేర్ చేయండి';

  @override
  String get ui3ShareRoomReference =>
      'ఆహ్వానించిన సభ్యులతో రూమ్ రిఫరెన్స్‌ను షేర్ చేయండి';

  @override
  String get ui3ScanToJoinGroup => 'ఈ గ్రూప్‌లో నేరుగా చేరడానికి స్కాన్ చేయండి';

  @override
  String get ui3ScanToShareRoomReference =>
      'ఆహ్వానించిన సభ్యులతో ఈ రూమ్ రిఫరెన్స్‌ను షేర్ చేయడానికి స్కాన్ చేయండి';

  @override
  String get ui3InviteLinkLoadFailed => 'ఆహ్వాన లింక్‌ను లోడ్ చేయడం విఫలమైంది';

  @override
  String get ui3InviteLinkCopied => 'ఆహ్వాన లింక్ కాపీ చేయబడింది';

  @override
  String get ui3ChannelCategoryOptional => 'వర్గం (ఐచ్ఛికం)';

  @override
  String get ui3ChannelCategoryHint => 'ప్రకటనలు / ఉత్పత్తి / మద్దతు';

  @override
  String get ui3DescriptionOptional => 'వివరణ (ఐచ్ఛికం)';

  @override
  String get ui3WebhookEnable => 'webhook ఆటోమేషన్‌ను ప్రారంభించండి';

  @override
  String get ui3WebhookEnableDesc =>
      'సభ్యుల చేరిక మరియు స్వాగత ఈవెంట్‌లను మీ ఇంటిగ్రేషన్ ఎండ్‌పాయింట్‌కు పంపండి.';

  @override
  String get ui3WebhookUrl => 'webhook URL';

  @override
  String get ui3WebhookSecretOptional => 'సంతకం సీక్రెట్ (ఐచ్ఛికం)';

  @override
  String get ui3WebhookSecretHint => 'X-N42-Signature కోసం ఉపయోగించబడుతుంది';

  @override
  String get ui3WebhookNotifyMemberJoined => 'సభ్యుడు చేరినప్పుడు తెలియజేయండి';

  @override
  String get ui3WebhookNotifyWelcomeSent =>
      'స్వాగత సందేశం పంపినప్పుడు తెలియజేయండి';

  @override
  String get ui3WebhookTestSend => 'టెస్ట్ webhook పంపండి';

  @override
  String get ui3WebhookTestSending => 'టెస్ట్ webhook పంపుతోంది...';

  @override
  String get ui3WebhookTestSent => 'టెస్ట్ webhook విజయవంతంగా పంపబడింది';

  @override
  String get ui3WebhookTestFailed => 'టెస్ట్ webhook పంపడం విఫలమైంది';

  @override
  String get ui3WebhookUrlInvalid =>
      'webhook URL తప్పనిసరిగా పబ్లిక్ HTTPS చిరునామా అయి ఉండాలి';

  @override
  String get ui3WebhookSelectEvent => 'కనీసం ఒక webhook ఈవెంట్‌ను ఎంచుకోండి';

  @override
  String get ui3SensitiveDataDetection => 'సున్నితమైన డేటా గుర్తింపు';

  @override
  String get ui3Email => 'ఇమెయిల్';

  @override
  String get ui3CreditCard => 'క్రెడిట్ కార్డ్';

  @override
  String get ui3DetectEmailDesc =>
      'టెక్స్ట్ సందేశాల్లో ఇమెయిల్ చిరునామాలను గుర్తించండి';

  @override
  String get ui3DetectPhoneDesc =>
      'ఫోన్ నంబర్‌లు మరియు అంతర్జాతీయ నంబర్‌లను గుర్తించండి';

  @override
  String get ui3DetectCardDesc =>
      'బ్యాంక్ మరియు కార్డ్ నంబర్‌లుగా అనిపించేవాటిని గుర్తించండి';

  @override
  String get ui3DetectWalletDesc =>
      'Ethereum తరహా వాలెట్ చిరునామాలను గుర్తించండి';

  @override
  String get ui3GeneralTopic => 'సాధారణం';

  @override
  String get a11yPreviousResult => 'మునుపటి ఫలితం';

  @override
  String get a11yNextResult => 'తదుపరి ఫలితం';

  @override
  String get ui3TryDifferentKeywords => 'వేరే కీవర్డ్‌లను ప్రయత్నించండి';

  @override
  String ui3FiltersActive(Object count) {
    return 'సక్రియ ఫిల్టర్‌లు: $count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return 'సక్రియ సందేశ ఫిల్టర్‌లు: $count';
  }

  @override
  String get ui3LoadMore => 'మరిన్ని లోడ్ చేయండి';

  @override
  String get ui3MessageFilters => 'సందేశ ఫిల్టర్‌లు';

  @override
  String get ui3SenderUserId => 'పంపినవారి యూజర్ ID';

  @override
  String get ui3FilterType => 'రకం';

  @override
  String get ui3FilterAny => 'ఏదైనా';

  @override
  String get ui3FilterImage => 'చిత్రం';

  @override
  String get ui3FilterTime => 'సమయం';

  @override
  String get ui3AnyTime => 'ఎప్పుడైనా';

  @override
  String get ui3OnlyMyMessages => 'నా సందేశాలు మాత్రమే';

  @override
  String get ui3MediaOnly => 'మీడియా మాత్రమే';

  @override
  String get ui3Apply => 'వర్తింపజేయండి';

  @override
  String get ui3QrStyleClassic => 'క్లాసిక్';

  @override
  String get ui3QrStyleOcean => 'సముద్రం';

  @override
  String get ui3QrStyleBerry => 'బెర్రీ';

  @override
  String get ui3NfcUnavailable =>
      'NFC అందుబాటులో లేదు లేదా ట్యాగ్‌కు మద్దతు లేదు. NFCని ఆన్ చేయండి, వేరే ట్యాగ్ ప్రయత్నించండి లేదా QR ఉపయోగించండి.';

  @override
  String get ui3CancelNfc => 'NFC రద్దు చేయండి';

  @override
  String get ui3ReadNfcTag => 'NFC ట్యాగ్ చదవండి';

  @override
  String get ui3HoldNearNfcTag => 'మీ ఫోన్‌ను సర్వీస్ ట్యాగ్ దగ్గర పట్టుకోండి.';

  @override
  String get a11yFlashlightOn => 'ఫ్లాష్‌లైట్ ఆన్ చేయండి';

  @override
  String get a11yFlashlightOff => 'ఫ్లాష్‌లైట్ ఆఫ్ చేయండి';

  @override
  String get ui3SocialGraph => 'సోషల్ గ్రాఫ్';

  @override
  String get ui3RecommendedConnections => 'సిఫార్సు చేసిన కనెక్షన్‌లు';

  @override
  String get ui3Portfolio => 'పోర్ట్‌ఫోలియో';

  @override
  String get ui3Chains => 'చైన్‌లు';

  @override
  String get ui3Tokens => 'టోకెన్‌లు';

  @override
  String get ui3NoConnectionsFound => 'కనెక్షన్‌లు ఏవీ కనుగొనబడలేదు';

  @override
  String get ui3ConnectionsHint =>
      'మీ ఆన్-చైన్ కార్యకలాపం పెరిగే కొద్దీ కనెక్షన్‌లు కనిపిస్తాయి';

  @override
  String get ui3SocialGraphLoadFailed => 'సోషల్ గ్రాఫ్ లోడ్ చేయడం విఫలమైంది';

  @override
  String get ui3Similarity => 'సారూప్యత';

  @override
  String get ui3Breakdown => 'వివరాలు';

  @override
  String get ui3TokenHoldings => 'టోకెన్ హోల్డింగ్‌లు';

  @override
  String get ui3NftCollections => 'NFT సేకరణలు';

  @override
  String get ui3ChainUsage => 'చెయిన్ వినియోగం';

  @override
  String get ui3Transactions => 'లావాదేవీలు';

  @override
  String get ui3DaoMembership => 'DAO సభ్యత్వం';

  @override
  String get ui3NotWeighted => 'వెయిట్ లేదు';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent% (వెయిట్: $weight)';
  }

  @override
  String get ui3CommonOnChainActivity => 'ఉమ్మడి ఆన్-చెయిన్ కార్యకలాపం';

  @override
  String get ui3SharedTokens => 'ఉమ్మడి టోకెన్‌లు';

  @override
  String get ui3SharedNftCollections => 'ఉమ్మడి NFT సేకరణలు';

  @override
  String get ui3SharedChains => 'ఉమ్మడి చెయిన్‌లు';

  @override
  String get ui3NoSharedTokens => 'ఉమ్మడి టోకెన్‌లు ఏవీ కనుగొనబడలేదు';

  @override
  String get ui3NoSharedNftCollections => 'ఉమ్మడి NFT సేకరణలు ఏవీ కనుగొనబడలేదు';

  @override
  String get ui3NoSharedChains => 'ఉమ్మడి చెయిన్‌లు ఏవీ కనుగొనబడలేదు';

  @override
  String get ui3SimilarityFailed => 'సారూప్యతను లెక్కించడం విఫలమైంది';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items +మరో $count';
  }

  @override
  String get a11yGovernance => 'పాలన';

  @override
  String get ui3CommunityLink => 'కమ్యూనిటీ లింక్';

  @override
  String get ui3CommunityQrCode => 'కమ్యూనిటీ QR కోడ్';

  @override
  String get ui3CommunityQrSubtitle =>
      'ఈ కమ్యూనిటీలో చేరి దాని ఛానెల్‌లను చూడటానికి స్కాన్ చేయండి';

  @override
  String get ui3CommunityLinkLoadFailed =>
      'కమ్యూనిటీ లింక్‌ను లోడ్ చేయడం విఫలమైంది';

  @override
  String get ui3CommunityLinkCopied => 'కమ్యూనిటీ లింక్ కాపీ చేయబడింది';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name ఈ కమ్యూనిటీ నుండి తీసివేయబడతారు.';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name తీసివేయబడతారు, మళ్లీ చేరలేరు.';
  }

  @override
  String get ui3SignInToDiscoverChannels =>
      'పబ్లిక్ ఛానెల్‌లను కనుగొనడానికి సైన్ ఇన్ చేయండి';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return '$nameలో చేరడం సాధ్యం కాలేదు: $error';
  }

  @override
  String get ui3CategoryTech => 'టెక్';

  @override
  String get ui3CategorySocial => 'సోషల్';

  @override
  String get ui3NoPublicChannels => 'పబ్లిక్ ఛానెల్‌లు ఏవీ కనుగొనబడలేదు';

  @override
  String get ui3StoriesAndFun => 'స్టోరీలు & వినోదం';

  @override
  String get ui3SearchMusicHint => 'పాటలు, కళాకారులు లేదా స్నేహితులను వెతకండి';

  @override
  String get ui3ForYou => 'మీ కోసం';

  @override
  String get ui3Liked => 'నచ్చినవి';

  @override
  String get ui3NoLikedMusic => 'ఇంకా నచ్చిన సంగీతం లేదు';

  @override
  String get ui3NoMusicStories => 'ఇంకా సంగీత స్టోరీలు లేవు';

  @override
  String get ui3LikedMusicHint =>
      'పాట పక్కన ఉన్న హార్ట్‌ను నొక్కితే అది ఇక్కడ ఉంటుంది.';

  @override
  String get ui3MusicStoriesHint =>
      'స్టోరీలలో షేర్ చేసిన సంగీతం ఇక్కడ కనిపిస్తుంది.';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · $name షేర్ చేశారు';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return '$title ప్లే చేయడం సాధ్యం కాలేదు: $error';
  }

  @override
  String get a11yPreviousTrack => 'మునుపటి ట్రాక్';

  @override
  String get a11yNextTrack => 'తదుపరి ట్రాక్';

  @override
  String get a11yPlay => 'ప్లే చేయి';

  @override
  String get a11yPause => 'పాజ్ చేయి';

  @override
  String get ui3Refresh => 'రిఫ్రెష్ చేయి';

  @override
  String get ui3NearbyIntroTitle => 'సమీపంలోని పబ్లిక్ పోస్ట్‌లను కనుగొనండి';

  @override
  String get ui3NearbyIntroBody =>
      'పబ్లిక్ మూమెంట్స్‌ను క్రమబద్ధీకరించడానికి మీ స్థానం ఈ పరికరంలో ఒకసారి మాత్రమే ఉపయోగించబడుతుంది. ఇది అప్‌లోడ్ చేయబడదు, ప్రసారం చేయబడదు, ఇతరులకు చూపబడదు.';

  @override
  String get ui3UseMyLocation => 'నా స్థానాన్ని ఉపయోగించు';

  @override
  String get ui3NearbyUnavailable => 'సమీపం ఫీచర్ అందుబాటులో లేదు';

  @override
  String get ui3NoNearbyPosts => 'సమీపంలో ఇంకా పోస్ట్‌లు లేవు';

  @override
  String get ui3NoNearbyPostsHint =>
      'స్థానం ఉన్న పబ్లిక్ మూమెంట్స్ ఇక్కడ కనిపిస్తాయి.';

  @override
  String get ui3NearbyDistanceNote =>
      'సుమారు దూరం · పబ్లిక్ స్థాన పోస్ట్‌లు మాత్రమే';

  @override
  String get ui3PublicLocationPost => 'పబ్లిక్ స్థాన పోస్ట్';

  @override
  String get ui3LocationServicesOff => 'లొకేషన్ సేవలు ఆఫ్‌లో ఉన్నాయి';

  @override
  String get ui3LocationPermissionDenied => 'స్థాన అనుమతి తిరస్కరించబడింది';

  @override
  String get ui3EnableLocationInSettings =>
      'సిస్టమ్ సెట్టింగ్‌లలో స్థాన అనుమతిని ప్రారంభించండి';

  @override
  String get ui3CreateStory => 'స్టోరీని సృష్టించు';

  @override
  String get ui3CreateStoryDesc => 'టెక్స్ట్ లేదా ఫోటో స్టేటస్ పోస్ట్ చేయండి.';

  @override
  String get ui3StoryCamera => 'స్టోరీ కెమెరా';

  @override
  String get ui3StoryCameraDesc =>
      'నేరుగా ఫిల్టర్‌లు, ఫోటో ఎడిటింగ్‌కు వెళ్లండి.';

  @override
  String get ui3MomentsDesc => 'పూర్తి ఫీడ్ మరియు వ్యాఖ్యలను తెరవండి.';

  @override
  String get ui3MomentCamera => 'మూమెంట్ కెమెరా';

  @override
  String get ui3MomentCameraDesc =>
      'పోస్ట్ సృష్టించి వెంటనే మీడియాను ఎంచుకోండి.';

  @override
  String get ui3GamesDesc =>
      'అంతర్నిర్మిత క్యాజువల్ గేమ్ సెంటర్‌ను ప్రారంభించండి.';

  @override
  String get ui3AvatarStudio => 'అవతార్ స్టూడియో';

  @override
  String get ui3AvatarStudioDesc =>
      'అలంకరణలు, NFT అవతార్ మరియు గుర్తింపు శైలి.';

  @override
  String get ui3SocialGraphDesc =>
      'ఆన్-చెయిన్ ఫాలోలు, అభిమానులు మరియు కనెక్షన్‌లు.';

  @override
  String get ui3SocialHubHeroTitle =>
      'స్టోరీలు, మూమెంట్స్, గేమ్‌లు మరియు అవతార్‌లు';

  @override
  String get ui3SocialHubHeroBody =>
      'చాట్, ప్రొఫైల్, డిస్కవర్‌లలో చెల్లాచెదురుగా కాకుండా అన్ని సోషల్ ఫీచర్లు ఒకే చోట.';

  @override
  String get ui3SocialGraphNotConfigured =>
      'ఈ బిల్డ్‌లో సోషల్ గ్రాఫ్ కాన్ఫిగర్ చేయబడలేదు';

  @override
  String get ui3ConnectWalletForSocialGraph =>
      'మీ సోషల్ గ్రాఫ్‌ను చూడటానికి వాలెట్‌ను కనెక్ట్ చేయండి';

  @override
  String get ui3AvatarStudioSignIn => 'అవతార్ స్టూడియోకు సైన్ ఇన్ అవసరం';

  @override
  String get a11yRemoveImage => 'చిత్రాన్ని తీసివేయి';

  @override
  String get a11yBack => 'వెనుకకు';

  @override
  String get ui3MiniAppConfirmTransactionTitle => 'లావాదేవీని నిర్ధారించండి';

  @override
  String get ui3MiniAppConfirmTransactionBody =>
      'ఒక మినీ యాప్ మీ తరపున లావాదేవీని పంపాలని అభ్యర్థిస్తోంది.';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return '$nameను తెరవాలా?';
  }

  @override
  String get ui3MiniAppOpenButton => 'తెరువు';

  @override
  String get ui3StoryReplySendFailed => 'స్టోరీకి ప్రత్యుత్తరం పంపడం విఫలమైంది';

  @override
  String get ui3RedPacketDemoNotice =>
      'డెమో రెడ్ ప్యాకెట్ — చాట్‌లోని రికార్డ్ మాత్రమే, నిజమైన ఆన్-చెయిన్ ఆస్తి బదిలీ కాదు.';

  @override
  String get ui3RedPacketCoverClassic => 'క్లాసిక్ ఎరుపు';

  @override
  String get ui3RedPacketCoverGolden => 'బంగారు';

  @override
  String get ui3RedPacketCoverPurple => 'ఊదా';

  @override
  String get ui3RedPacketCoverOceanBlue => 'సముద్ర నీలం';

  @override
  String get ui3RedPacketCoverNatureGreen => 'ప్రకృతి ఆకుపచ్చ';

  @override
  String get ui3RedPacketCoverRosePink => 'గులాబీ రంగు';

  @override
  String get ui3RedPacketHistoryEmpty => 'ఇంకా రెడ్ ప్యాకెట్‌లు లేవు';

  @override
  String get ui3TransferMerchantQrWithAmount => 'వ్యాపారి QR (మొత్తంతో)';

  @override
  String get ui3TransferMerchantQrTitle => 'వ్యాపారి QR';

  @override
  String get ui3TransferOpenAmountHint => 'ఏ మొత్తానికైనా ఖాళీగా ఉంచండి';

  @override
  String get ui3FiatRampTitle => 'క్రిప్టో కొనండి / అమ్మండి';

  @override
  String get ui3FiatRampBuy => 'కొనండి';

  @override
  String get ui3FiatRampSell => 'అమ్మండి';

  @override
  String get ui3FiatRampNotConfigured =>
      'ఫియట్ ఆన్/ఆఫ్-ర్యాంప్ కాన్ఫిగర్ చేయబడలేదు';

  @override
  String get a11yPointsAddRule => 'రివార్డ్ నియమాన్ని జోడించు';

  @override
  String get a11yGovernanceRemoveChoice => 'ఎంపికను తీసివేయి';

  @override
  String get a11yGovernanceCreateProposal => 'ప్రతిపాదనను సృష్టించు';

  @override
  String get ui3MiniAppUpdateN42 => 'N42ను అప్‌డేట్ చేయండి';

  @override
  String get ui3MiniAppOfficial => 'అధికారిక';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count వినియోగదారులు';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return 'నేపథ్య రంగు $index';
  }

  @override
  String get a11yStoryAdd => 'స్టోరీని జోడించండి';

  @override
  String get ui3StoryPostFailed => 'స్టోరీని పోస్ట్ చేయడం విఫలమైంది';

  @override
  String get ui3StoryTapToSelectImage => 'చిత్రాన్ని ఎంచుకోవడానికి నొక్కండి';

  @override
  String get ui3StoryChangeImage => 'మార్చు';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return 'ఎంచుకున్న సంగీతాన్ని చదవలేకపోయాము: $error';
  }

  @override
  String get ui3StoryDeleteConfirm => 'ఈ స్టోరీని తొలగించాలా?';

  @override
  String get ui3StoryDeleteFailed => 'స్టోరీని తొలగించడం విఫలమైంది';

  @override
  String get ui3MomentCreateTitle => 'మూమెంట్ సృష్టించండి';

  @override
  String get ui3MomentContentHint => 'మీరు ఏమి ఆలోచిస్తున్నారు?';

  @override
  String get ui3MomentAddPhotos => 'ఫోటోలను జోడించండి';

  @override
  String get ui3MomentAddLocation => 'స్థానాన్ని జోడించండి';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return 'ఎంచుకున్న మీడియా ($count)';
  }

  @override
  String get ui3MomentClearAll => 'అన్నీ క్లియర్ చేయండి';

  @override
  String get ui3MomentClearMediaConfirm =>
      'ఎంచుకున్న అన్ని ఫోటోలు/వీడియోలను తీసివేయాలా?';

  @override
  String get ui3MomentVisibilityPublicDesc => 'స్నేహితులందరూ చూడగలరు';

  @override
  String get ui3MomentVisibilityPrivateDesc => 'మీరు మాత్రమే చూడగలరు';

  @override
  String get ui3MomentVisibilityPartialDesc => 'ఎవరు చూడగలరో ఎంచుకోండి';

  @override
  String get ui3MomentVisibilityExcludedDesc =>
      'నిర్దిష్ట స్నేహితుల నుండి దాచండి';

  @override
  String get ui3MomentVideos => 'వీడియోలు';

  @override
  String get ui3MomentNoVideos => 'ఇంకా వీడియోలు లేవు';

  @override
  String get a11yCallMinimize => 'చిన్నదిగా చేయండి';

  @override
  String get a11yCallGridView => 'గ్రిడ్ వీక్షణ';

  @override
  String get a11yCallFocusView => 'ఫోకస్ వీక్షణ';

  @override
  String get ui3CallTools => 'కాల్ సాధనాలు';

  @override
  String get ui3CallMeetingTools => 'మీటింగ్ సాధనాలు';

  @override
  String get ui3CallToolsSubtitle =>
      'కాల్ నుండి నిష్క్రమించకుండానే ఆడియో, వీడియో నాణ్యతను సర్దుబాటు చేయండి.';

  @override
  String get ui3CallAudioEnhancement => 'ఆడియో మెరుగుదల';

  @override
  String get ui3CallNoiseSuppression => 'నాయిస్ అణచివేత';

  @override
  String get ui3CallNoiseSuppressionDesc =>
      'కీబోర్డ్ మరియు నేపథ్య శబ్దాన్ని తగ్గిస్తుంది.';

  @override
  String get ui3CallEchoCancellation => 'ప్రతిధ్వని రద్దు';

  @override
  String get ui3CallEchoCancellationDesc =>
      'స్పీకర్ శబ్దం తిరిగి మైక్‌లోకి రాకుండా నిరోధిస్తుంది.';

  @override
  String get ui3CallAutoGainControl => 'ఆటోమేటిక్ గెయిన్ నియంత్రణ';

  @override
  String get ui3CallAutoGainControlDesc =>
      'మైక్రోఫోన్ వాల్యూమ్‌ను మరింత స్థిరంగా ఉంచుతుంది.';

  @override
  String get ui3CallVoiceIsolation => 'మెరుగైన వాయిస్ ఐసోలేషన్';

  @override
  String get ui3CallVoiceIsolationDesc =>
      'మరింత బలమైన నాయిస్ తగ్గింపు ప్రొఫైల్‌ను ఉపయోగించండి.';

  @override
  String get ui3CallVideoSection => 'వీడియో';

  @override
  String get ui3CallBackgroundBlur => 'నేపథ్యం బ్లర్ (బీటా)';

  @override
  String get ui3CallBlurDescReady =>
      'ప్రాధాన్యత అమలులో ఉంది. వాస్తవ బ్లర్ వీడియో ప్రాసెసర్ విడుదలపై ఆధారపడి ఉంటుంది.';

  @override
  String get ui3CallBlurDescSaved =>
      'బ్లర్ ప్రాధాన్యత సేవ్ చేయబడింది, కెమెరా ప్రాసెసింగ్ అందుబాటులోకి వచ్చినప్పుడు వర్తిస్తుంది.';

  @override
  String get ui3CallBlurDescCameraOff =>
      'నేపథ్య ప్రాసెసింగ్ అందుబాటులోకి వచ్చిన తర్వాత కెమెరాను ఆన్ చేయండి.';

  @override
  String get ui3CallRecordingSection => 'రికార్డింగ్';

  @override
  String get ui3CallRecordingDesc =>
      'రికార్డింగ్‌లను సేవ్ చేయడానికి సర్వర్ వైపు egress అవసరం.';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return 'కాల్ సెట్టింగ్‌లను నవీకరించడం విఫలమైంది: $error';
  }

  @override
  String get ui3CallRecordingStarted => 'రికార్డింగ్ ప్రారంభమైంది';

  @override
  String get ui3VoiceRoomNotFound => 'రూమ్ కనుగొనబడలేదు';

  @override
  String get ui3VoiceRoomEndConfirm =>
      'ఈ వాయిస్ రూమ్‌ను ముగించాలనుకుంటున్నారా?';

  @override
  String get a11yGameMoveUp => 'పైకి జరపండి';

  @override
  String get a11yGameMoveDown => 'కిందికి జరపండి';

  @override
  String get a11yGameMoveLeft => 'ఎడమకు జరపండి';

  @override
  String get a11yGameMoveRight => 'కుడికి జరపండి';

  @override
  String get a11yGameRotate => 'తిప్పండి';

  @override
  String get a11yGameDrop => 'కిందకు వదలండి';

  @override
  String ui3StickerAddedCount(Object count) {
    return '$count స్టిక్కర్‌లు జోడించబడ్డాయి';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return 'జోడించడం విఫలమైంది: $error';
  }

  @override
  String get ui3StickerRemoveTitle => 'స్టిక్కర్‌ను తీసివేయండి';

  @override
  String get ui3StickerRemoveConfirm =>
      'ఈ స్టిక్కర్‌ను ప్యాక్ నుండి తీసివేయాలా?';

  @override
  String get ui3StickerRemoveFailed => 'తీసివేయడం విఫలమైంది';

  @override
  String get ui3StickerRenamePack => 'ప్యాక్ పేరు మార్చండి';

  @override
  String get ui3StickerPackName => 'ప్యాక్ పేరు';

  @override
  String get ui3StickerRenameFailed => 'పేరు మార్చడం విఫలమైంది';

  @override
  String get ui3StickerDeletePack => 'ప్యాక్‌ను తొలగించండి';

  @override
  String get ui3StickerThisPack => 'ఈ ప్యాక్';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return '\"$name\" మరియు దానిలోని అన్ని స్టిక్కర్‌లను తొలగించాలా? దీన్ని రద్దు చేయలేరు.';
  }

  @override
  String get ui3StickerDeleteFailed => 'తొలగించడం విఫలమైంది';

  @override
  String get ui3StickerPack => 'స్టిక్కర్ ప్యాక్';

  @override
  String get ui3StickerAdding => 'జోడిస్తోంది…';

  @override
  String get ui3StickerAddStickers => 'స్టిక్కర్‌లను జోడించండి';

  @override
  String get ui3StickerPackNotFound => 'ప్యాక్ కనుగొనబడలేదు';

  @override
  String get ui3StickerEmptyHint =>
      'చిత్రాలను అప్‌లోడ్ చేయడానికి \"స్టిక్కర్‌లను జోడించండి\" నొక్కండి';

  @override
  String get ui3StickerNewPack => 'కొత్త స్టిక్కర్ ప్యాక్';

  @override
  String get ui3StickerCreate => 'సృష్టించండి';

  @override
  String get ui3StickerCreateFailed => 'ప్యాక్‌ను సృష్టించడం విఫలమైంది';

  @override
  String ui3StickerInstalled(Object name) {
    return '\"$name\" ఇన్‌స్టాల్ చేయబడింది';
  }

  @override
  String get ui3StickerRemovePackTitle => 'స్టిక్కర్ ప్యాక్‌ను తీసివేయండి';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return 'మీ స్టిక్కర్‌ల నుండి \"$name\"ను తీసివేయాలా?';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return '\"$name\" తీసివేయబడింది';
  }

  @override
  String get ui3StickerAiSticker => 'AI స్టిక్కర్';

  @override
  String get ui3StickerStoreTab => 'స్టోర్';

  @override
  String get ui3StickerMyStickersTab => 'నా స్టిక్కర్‌లు';

  @override
  String get ui3StickerNoneFound => 'స్టిక్కర్‌లు కనుగొనబడలేదు';

  @override
  String ui3StickerByAuthor(Object author) {
    return '$author రూపొందించింది';
  }

  @override
  String get ui3StickerManage => 'నిర్వహించండి';

  @override
  String ui3StickerCount(Object count) {
    return '$count స్టిక్కర్‌లు';
  }

  @override
  String get ui3StickerNoneInstalled => 'స్టిక్కర్‌లు ఏవీ ఇన్‌స్టాల్ కాలేదు';

  @override
  String get ui3StickerGetFromStore => 'స్టోర్ నుండి స్టిక్కర్‌లను పొందండి';

  @override
  String get ui3StickerBrowseStore => 'స్టోర్‌ను బ్రౌజ్ చేయండి';

  @override
  String get ui3StickerAddedToAi => '\"AI స్టిక్కర్‌లు\"కు జోడించబడింది';

  @override
  String get ui3StickerAddOneFailed => 'స్టిక్కర్‌ను జోడించడం విఫలమైంది';

  @override
  String get ui3StickerPromptLabel => 'మీ స్టిక్కర్‌ను వివరించండి';

  @override
  String get ui3StickerPromptHint =>
      'ఉదా. సన్‌గ్లాసెస్ పెట్టుకున్న సంతోషంగా ఉన్న నారింజ పిల్లి';

  @override
  String get ui3StickerGenerating => 'రూపొందిస్తోంది…';

  @override
  String get ui3StickerGenerate => 'రూపొందించండి';

  @override
  String get ui3StickerAddToStickers => 'స్టిక్కర్‌లకు జోడించండి';

  @override
  String get ui3StickerGeneratingPreview => 'మీ స్టిక్కర్‌ను రూపొందిస్తోంది…';

  @override
  String get ui3StickerGenerateEmpty =>
      'స్టిక్కర్‌ను వివరించి \"రూపొందించండి\" నొక్కండి';
}
