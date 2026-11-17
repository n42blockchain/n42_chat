// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class SSw extends S {
  SSw([String locale = 'sw']) : super(locale);

  @override
  String get commonRetry => 'Jaribu tena';

  @override
  String get commonUnknownUser => 'Mtumiaji asiyejulikana';

  @override
  String get transferWalletNotConnected => 'Wallet Haijaunganishwa';

  @override
  String get chatCallServiceNotInitialized =>
      'Huduma ya kupiga simu haijaanzishwa';

  @override
  String authLoginFailed(Object error) {
    return 'Kuingia kumeshindwa: $error';
  }

  @override
  String get chatCallBack => 'Piga simu tena';

  @override
  String get chatMissedVideoCall => 'Hukujibu simu ya video';

  @override
  String get chatMissedVoiceCall => 'Simu ambayo haikupokelewa';

  @override
  String get chatCallNotAnswered => 'Haijajibiwa';

  @override
  String get chatCallDurationLabel => 'Muda wa simu';

  @override
  String get chatVoiceCallCancelled => 'Simu ya sauti imeghairiwa';

  @override
  String get chatVideoCallCancelled => 'Hangout ya Video imeghairiwa';

  @override
  String get commonImage => '[Picha]';

  @override
  String get chatVideo => '[Video]';

  @override
  String get chatVoice => '[Sauti]';

  @override
  String get commonFile => '[Faili]';

  @override
  String get chatLocation => '[Mahali]';

  @override
  String get chatUnknownMessage => '[Ujumbe usiojulikana]';

  @override
  String get commonDelete => 'Futa';

  @override
  String get chatDeleteThisMessage => 'Ungependa kufuta ujumbe huu?';

  @override
  String get chatMessageDeleted => 'Ujumbe umefutwa';

  @override
  String get profileNotLoggedIn => 'Hujaingia';

  @override
  String get chatMyLocation => 'Eneo langu';

  @override
  String get commonGroupChat => 'Gumzo la Kikundi';

  @override
  String get commonSearch => 'Tafuta';

  @override
  String get commonCancel => 'Ghairi';

  @override
  String get commonLoadFailed => 'Imeshindwa kupakia';

  @override
  String get commonMessages => 'Ujumbe';

  @override
  String get commonContacts => 'Anwani';

  @override
  String get commonMe => 'Mimi';

  @override
  String get commonVoiceLoading =>
      'Inapakia sauti, tafadhali jaribu tena baadaye';

  @override
  String get commonVoiceToTextFailed => 'Sauti kwa maandishi imeshindwa';

  @override
  String get commonConvertToText => 'Kwa maandishi';

  @override
  String get chatCopy => 'Nakili';

  @override
  String get commonForward => 'Mbele';

  @override
  String get commonUnfavorite => 'Ondoa kwenye vipendwa';

  @override
  String get commonFavorite => 'Kipendwa';

  @override
  String get settingsResend => 'Tuma tena';

  @override
  String get chatRecall => 'Kumbuka';

  @override
  String get commonQuote => 'Nukuu';

  @override
  String get commonRemind => 'Kumbusha';

  @override
  String get chatCopied => 'Imenakiliwa';

  @override
  String get storySendMessageHint => 'Tuma ujumbe';

  @override
  String get commonMicrophonePermissionRequired =>
      'Tafadhali ruhusu maikrofoni ruhusa';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      'Ruhusa ya maikrofoni imekataliwa. Tafadhali iwashe katika mipangilio ya mfumo ili kutumia ujumbe wa sauti.';

  @override
  String commonStartRecordingFailed(Object error) {
    return 'Imeshindwa kuanza kurekodi: $error';
  }

  @override
  String get commonRecordingTooShort => 'Kurekodi ni fupi mno';

  @override
  String commonStopRecordingFailed(Object error) {
    return 'Imeshindwa kuacha kurekodi: $error';
  }

  @override
  String get chatReleaseToCancel => 'Toa ili kughairi';

  @override
  String get chatReleaseToSend =>
      'Achilia ili kutuma, telezesha kidole juu ili kughairi';

  @override
  String get commonHoldToTalk => 'Shikilia kuzungumza';

  @override
  String get commonSend => 'Tuma';

  @override
  String get commonAddFriend => 'Ongeza Rafiki';

  @override
  String get commonChatServiceNotConnected => 'Huduma ya gumzo haijaunganishwa';

  @override
  String contactUserNotFoundHint(String query) {
    return 'Mtumiaji \"$query\" hajapatikana\n\nVidokezo:\n• Jaribu kuweka kitambulisho kamili cha mtumiaji, k.m. @username:server.com\n• Angalia tahajia ya jina la mtumiaji';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Imeshindwa kuunda gumzo: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Utafutaji haukufaulu: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Weka kitambulisho cha mtumiaji au jina la mtumiaji ili kutafuta';

  @override
  String get contactSearching => 'Inatafuta...';

  @override
  String get contactSearchUserToChat =>
      'Tafuta mtumiaji ili kuanza kupiga gumzo';

  @override
  String get contactMatrixIdExample =>
      'Unaweza kuingiza Kitambulisho kamili cha Matrix\nk.m. @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'Mtumiaji \"$username\" hajapatikana';
  }

  @override
  String get commonChat => 'Soga';

  @override
  String get commonSettings => 'Mipangilio';

  @override
  String get profileEditProfile => 'Badilisha Wasifu';

  @override
  String get authLogin => 'Ingia';

  @override
  String get commonCreateGroup => 'Unda Kikundi';

  @override
  String get chatError => 'Hitilafu';

  @override
  String get commonTransfer => 'Uhamisho';

  @override
  String get commonReceived => 'Imepokelewa';

  @override
  String get commonRefunded => 'Imerejeshwa';

  @override
  String get commonExpired => 'Muda wake umeisha';

  @override
  String get chatRedPacketGreeting => 'Kila la heri';

  @override
  String get commonN42RedPacket => 'Pakiti Nyekundu ya N42';

  @override
  String get commonClaimed => 'Imedaiwa';

  @override
  String get commonAllClaimed => 'Wote walidai';

  @override
  String get chatReadAloud => 'Soma Kwa Sauti';

  @override
  String get chatReply => 'Jibu';

  @override
  String get commonEdit => 'Hariri';

  @override
  String get chatSelectForwardTarget => 'Chagua Lengo la Mbele';

  @override
  String commonSendCount(int count) {
    return 'Tuma($count)';
  }

  @override
  String contactN42Id(Object id) {
    return 'N42 ID: $id';
  }

  @override
  String get profileN42IdTitle => 'Kitambulisho cha N42';

  @override
  String get profileN42Bean => 'N42 Maharage';

  @override
  String get contactFriendInfo => 'Habari Rafiki';

  @override
  String get contactFriendInfoDesc =>
      'Ongeza maoni ya rafiki, simu, lebo, madokezo, picha na uweke ruhusa.';

  @override
  String get commonMoments => 'Muda mfupi';

  @override
  String get commonSendMessage => 'Ujumbe';

  @override
  String get contactAudioVideoCall => 'Simu ya Sauti/Video';

  @override
  String get contactVideoChannel => 'Kituo cha Video';

  @override
  String get contactRemark => 'Toa maoni';

  @override
  String get contactRemarkName => 'Rejea Jina';

  @override
  String get contactPhone => 'Simu';

  @override
  String get contactTags => 'Lebo';

  @override
  String get contactNotes => 'Vidokezo';

  @override
  String get contactPhotos => 'Picha';

  @override
  String get contactPermissions => 'Ruhusa';

  @override
  String get contactChatMomentsEtc => 'Gumzo, Matukio, Michezo, n.k.';

  @override
  String get contactMoreInfo => 'Maelezo Zaidi';

  @override
  String get contactCommonGroups => 'Vikundi kwa pamoja';

  @override
  String get contactSource => 'Chanzo';

  @override
  String get settingsNotificationSettings => 'Arifa';

  @override
  String get settingsPrivacy => 'Faragha';

  @override
  String get settingsAppearance => 'Muonekano';

  @override
  String get settingsAbout => 'Kuhusu';

  @override
  String get commonLogout => 'Toka nje';

  @override
  String get commonLogoutConfirm => 'Je, una uhakika unataka kutoka?';

  @override
  String get commonSave => 'Hifadhi';

  @override
  String get profileNickname => 'Jina la utani';

  @override
  String get profileEnterNickname => 'Weka jina la utani';

  @override
  String get profileSignature => 'Sahihi';

  @override
  String get profileAddSignature => 'Ongeza saini';

  @override
  String get commonTakePhoto => 'Piga Picha';

  @override
  String get profileChooseFromGallery => 'Chagua kutoka kwenye Matunzio';

  @override
  String profileSaveFailed(Object error) {
    return 'Imeshindwa kuhifadhi: $error';
  }

  @override
  String get authSecureDecentralizedChat => 'Ujumbe salama, uliogatuliwa';

  @override
  String get commonEndToEndEncryption => 'Usimbaji wa Mwisho-hadi-Mwisho';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Ujumbe unaoonekana kwako na mpokeaji pekee';

  @override
  String get authDecentralized => 'Iliyogatuliwa';

  @override
  String get authBasedOnMatrix => 'Imejengwa juu ya itifaki wazi ya Matrix';

  @override
  String get authWalletIntegration => 'Ujumuishaji wa Wallet';

  @override
  String get authEasyCryptoTransfer => 'Uhamisho rahisi wa cryptocurrency';

  @override
  String get authRegister => 'Jisajili';

  @override
  String get authAgreeTerms => 'Kwa kuingia, unakubali';

  @override
  String get authTermsOfService => 'Masharti ya Huduma';

  @override
  String get authAnd => ' na ';

  @override
  String get authPrivacyPolicy => 'Sera ya Faragha';

  @override
  String get authServerAddress => 'Anwani ya Seva';

  @override
  String get authEnterServerAddress => 'Ingiza anwani ya seva';

  @override
  String authConnectedTo(Object serverName) {
    return 'Imeunganishwa kwa $serverName';
  }

  @override
  String get authUsername => 'Jina la mtumiaji';

  @override
  String get authEnterUsername => 'Ingiza jina la mtumiaji';

  @override
  String get authUsernameOrEmail => 'Jina la mtumiaji au Barua pepe';

  @override
  String get authEnterUsernameOrEmail => 'Weka jina la mtumiaji au barua pepe';

  @override
  String get authPassword => 'Nenosiri';

  @override
  String get authEnterPassword => 'Weka nenosiri';

  @override
  String get authRegisterAccount => 'Jisajili';

  @override
  String get authForgotPassword => 'Umesahau Nenosiri';

  @override
  String get authOtherLoginMethods => 'Njia zingine za kuingia';

  @override
  String get authCreateAccount => 'Fungua Akaunti';

  @override
  String get authJoinN42Chat => 'Jiunge na N42 Chat ili kuanza kupiga gumzo';

  @override
  String get authUsernameHint => 'herufi 3-20, herufi/nambari/_';

  @override
  String get authUsernameMinLength =>
      'Jina la mtumiaji lazima liwe na angalau vibambo 3';

  @override
  String get authUsernameMaxLength =>
      'Jina la mtumiaji lazima liwe na vibambo 20';

  @override
  String get authUsernameFormat =>
      'Jina la mtumiaji linaweza tu kuwa na herufi, nambari, na mistari chini';

  @override
  String get authPasswordHint => 'Chini ya herufi 8';

  @override
  String get commonPasswordMinLength =>
      'Nenosiri lazima liwe na angalau vibambo 8';

  @override
  String get authConfirmPassword => 'Thibitisha Nenosiri';

  @override
  String get authFilled => 'Imejazwa';

  @override
  String get authEnterInviteCode => 'Weka msimbo wa mwaliko';

  @override
  String get authAlreadyHaveAccount => 'Je, tayari una akaunti?';

  @override
  String get authLoginNow => 'Ingia sasa';

  @override
  String get profileAvatar => 'Picha ya wasifu';

  @override
  String get profileStatus => 'Hali';

  @override
  String get commonLoading => 'Inapakia...';

  @override
  String get conversationNoConversations => 'Hakuna mazungumzo';

  @override
  String get conversationTapToChat =>
      'Gusa sehemu ya juu kulia ili kuanza kupiga gumzo';

  @override
  String get conversationStartGroup => 'Anzisha Gumzo la Kikundi';

  @override
  String get commonScan => 'Changanua';

  @override
  String get commonPayment => 'Malipo';

  @override
  String commonFeatureComingSoon(Object feature) {
    return '$feature inakuja hivi karibuni';
  }

  @override
  String get conversationMarkAsRead => 'Weka alama kama imesomwa';

  @override
  String get commonUnmute => 'Rejesha sauti';

  @override
  String get commonMute => 'Nyamazisha';

  @override
  String get conversationUnpin => 'Bandua';

  @override
  String get conversationPin => 'Bandika';

  @override
  String get conversationDeleteConversation => 'Futa Mazungumzo';

  @override
  String conversationDeleteConversationConfirm(Object name) {
    return 'Je, ungependa kufuta mazungumzo na \"$name\"?';
  }

  @override
  String get commonNoContacts => 'Hakuna anwani';

  @override
  String get contactAddFriendsToChat =>
      'Ongeza marafiki ili kuanza kupiga gumzo';

  @override
  String get contactNotFound => 'Anwani haijapatikana';

  @override
  String get contactTryOtherKeywords =>
      'Jaribu maneno mengine muhimu au utafutaji wa kimataifa';

  @override
  String get contactSearchResults => 'Matokeo ya utafutaji';

  @override
  String get contactNewFriends => 'Marafiki Wapya';

  @override
  String get contactChatOnlyFriends => 'Marafiki wa gumzo pekee';

  @override
  String get contactOfficialAccounts => 'Hesabu Rasmi';

  @override
  String get contactServiceAccounts => 'Hesabu za Huduma';

  @override
  String get contactEnterpriseContacts => 'Anwani za Biashara';

  @override
  String get contactRecommendToFriend => 'Shiriki anwani';

  @override
  String get commonSetRemark => 'Weka maoni';

  @override
  String get contactSendingCard => 'Inatuma kadi ya mawasiliano...';

  @override
  String get commonFileLabel => 'Faili';

  @override
  String get commonLocationLabel => 'Mahali';

  @override
  String contactRecommendFailed(Object error) {
    return 'Imeshindwa kupendekeza: $error';
  }

  @override
  String get profileEnterRemark => 'Ingiza maoni';

  @override
  String get contactOpeningChat => 'Inafungua gumzo...';

  @override
  String contactOpenChatFailed(Object error) {
    return 'Imeshindwa kufungua gumzo: $error';
  }

  @override
  String get contactAddContact => 'Ongeza Anwani';

  @override
  String get contactEnterUserId => 'Weka kitambulisho cha mtumiaji';

  @override
  String get contactNoFriendRequests => 'Hakuna maombi ya urafiki';

  @override
  String get commonAccept => 'Kubali';

  @override
  String get commonReject => 'Kataa';

  @override
  String get commonNoGroups => 'Hakuna vikundi';

  @override
  String get contactSelectFriendToRecommend => 'Chagua rafiki wa kumpendekeza';

  @override
  String get commonSearchContacts => 'Tafuta anwani';

  @override
  String get contactNoContactsFound => 'Hakuna anwani zilizopatikana';

  @override
  String get favoriteYesterday => 'Jana';

  @override
  String get chatJustNow => 'Sasa hivi';

  @override
  String get profileOnline => 'Mtandaoni';

  @override
  String get profileOffline => 'Nje ya mtandao';

  @override
  String get searchContactsGroupsMessages => 'Tafuta anwani, vikundi na ujumbe';

  @override
  String get searchError => 'Hitilafu ya Utafutaji';

  @override
  String get chatSearchHint => 'Tafuta';

  @override
  String get searchHistory => 'Historia ya Utafutaji';

  @override
  String get commonClear => 'Wazi';

  @override
  String get commonAll => 'Wote';

  @override
  String get searchGroups => 'Vikundi';

  @override
  String get searchNoResults => 'Hakuna Matokeo';

  @override
  String commonGroupMembers(Object count) {
    return 'Wanachama ($count)';
  }

  @override
  String get groupMembersTitle => 'Wajumbe wa Kikundi';

  @override
  String get groupViewAll => 'Tazama zote';

  @override
  String get groupOwner => 'Mmiliki';

  @override
  String get groupAdmin => 'Msimamizi';

  @override
  String get groupInvite => 'Alika';

  @override
  String get commonGroupAnnouncement => 'Tangazo la Kikundi';

  @override
  String get commonNotSet => 'Haijawekwa';

  @override
  String get groupDescription => 'Maelezo ya Kikundi';

  @override
  String get groupPublicGroup => 'Kikundi cha Umma';

  @override
  String get commonClearChatHistory => 'Futa Historia ya Gumzo';

  @override
  String get commonDissolveGroup => 'Futa Kikundi';

  @override
  String get commonLeaveGroup => 'Ondoka kwenye Kikundi';

  @override
  String get groupChangeGroupName => 'Badilisha Jina la Kikundi';

  @override
  String get commonEnterGroupName => 'Ingiza jina la kikundi';

  @override
  String get commonConfirm => 'Thibitisha';

  @override
  String get groupEnterGroupDescription => 'Weka maelezo ya kikundi';

  @override
  String get groupPublish => 'Chapisha';

  @override
  String get chatClearHistoryConfirm =>
      'Ungependa kufuta historia yote ya gumzo? Hili haliwezi kutenduliwa.';

  @override
  String get chatClearAction => 'Wazi';

  @override
  String get commonChatHistoryCleared => 'Historia ya gumzo imefutwa';

  @override
  String get commonDissolve => 'kuyeyusha';

  @override
  String get groupQrCode => 'Msimbo wa QR wa Kikundi';

  @override
  String get commonSearchChatHistory => 'Tafuta Historia ya Gumzo';

  @override
  String get groupIdCopied => 'Kitambulisho cha kikundi kimenakiliwa';

  @override
  String get transferEnterOrPasteAddress =>
      'Ingiza au ubandike anwani ya mkoba';

  @override
  String get transferSelectToken => 'Chagua Tokeni';

  @override
  String get commonTransferAmount => 'Kiasi cha Uhamisho';

  @override
  String get transferAvailable => 'Inapatikana';

  @override
  String get transferMemoOptional => 'Memo (ya hiari)';

  @override
  String get transferConfirmTransfer => 'Thibitisha Uhamisho';

  @override
  String get transferAddressVerified => 'Anwani imethibitishwa';

  @override
  String transferAvailableBalance(Object balance, Object symbol) {
    return 'Inapatikana: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Weka kiasi';

  @override
  String get commonRedPacketCountMin => 'Angalau pakiti 1 nyekundu inahitajika';

  @override
  String get commonViewRedPacketDetails => 'Tazama Maelezo ya Pakiti Nyekundu';

  @override
  String get commonEnterTransferAmount => 'Tafadhali weka kiasi cha uhamisho';

  @override
  String get commonTransferTo => 'Hamisha hadi';

  @override
  String commonFromSender(String name) {
    return 'Kutoka $name';
  }

  @override
  String get commonConfirmReceive => 'Thibitisha Risiti';

  @override
  String get groupProfile => 'Maelezo ya Kikundi';

  @override
  String get groupRemoveMember => 'Ondoa kwenye Kikundi';

  @override
  String get commonRemove => 'Ondoa';

  @override
  String get profileClearStatus => 'Wazi Hali';

  @override
  String get profileClearStatusConfirm => 'Je, ungependa kufuta hali ya sasa?';

  @override
  String get profileStatusCleared => 'Hali imefutwa';

  @override
  String get profileUserNotExist => 'Mtumiaji hayupo';

  @override
  String get profileUserIdCopied => 'Kitambulisho cha Mtumiaji kimenakiliwa';

  @override
  String get commonReport => 'Ripoti';

  @override
  String get profileQrCode => 'Msimbo wa QR';

  @override
  String get profileAvatarUpdated => 'Avatar imesasishwa';

  @override
  String commonSelectImageFailed(Object error) {
    return 'Imeshindwa kuchagua picha: $error';
  }

  @override
  String get profileChangeName => 'Badilisha Jina';

  @override
  String get profileMale => 'Mwanaume';

  @override
  String get profileFemale => 'Mwanamke';

  @override
  String chatFeatureInDev(String feature) {
    return 'Kipengele cha $feature katika maendeleo...';
  }

  @override
  String profileSaveAddressFailed(Object error) {
    return 'Imeshindwa kuhifadhi anwani: $error';
  }

  @override
  String get profileAddNew => 'Ongeza';

  @override
  String get profileAddAddress => 'Ongeza Anwani';

  @override
  String get profileAddressAdded => 'Anwani imeongezwa';

  @override
  String get profileAddressUpdated => 'Anwani imesasishwa';

  @override
  String get profileDeleteAddress => 'Futa Anwani';

  @override
  String get profileAddressDeleted => 'Anwani imefutwa';

  @override
  String profileSaveInvoiceFailed(Object error) {
    return 'Imeshindwa kuhifadhi ankara: $error';
  }

  @override
  String get profileMyInvoices => 'Ankara Zangu';

  @override
  String get profileAddInvoice => 'Ongeza ankara';

  @override
  String get profileInvoiceAdded => 'Ankara imeongezwa';

  @override
  String get profileInvoiceUpdated => 'Ankara imesasishwa';

  @override
  String get profileDeleteInvoice => 'Futa ankara';

  @override
  String get profileInvoiceDeleted => 'Ankara imefutwa';

  @override
  String get profilePersonal => 'Binafsi';

  @override
  String get groupSelectAtLeastOne =>
      'Tafadhali chagua angalau mwanachama mmoja';

  @override
  String get chatFileNotExist => 'Faili haipo';

  @override
  String chatSendFailed(String error) {
    return 'Imeshindwa kutuma: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Haiwezi kufungua kivinjari';

  @override
  String chatSelectFileFailed(String error) {
    return 'Imeshindwa kuchagua faili: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Imeshindwa kuweka mipangilio: $error';
  }

  @override
  String get transferEnterValidAmount => 'Tafadhali weka kiasi halali';

  @override
  String get commonAddressCopied => 'Anwani imenakiliwa';

  @override
  String favoriteOpenItem(Object content) {
    return 'Fungua: $content';
  }

  @override
  String get favoriteDeleted => 'Imefutwa';

  @override
  String get profileWallet => 'Mkoba';

  @override
  String get chatRecording => 'Kurekodi';

  @override
  String get chatInvalidVideoUrl => 'URL ya video si sahihi';

  @override
  String get chatDownloadFile => 'Pakua faili';

  @override
  String get chatClearChatHistoryTitle => 'Futa Historia ya Gumzo';

  @override
  String get chatVideoCall => 'Simu ya Video';

  @override
  String get commonVoiceCall => 'Wito wa Sauti';

  @override
  String get callLeaveMeeting => 'Ondoka kwenye Mkutano';

  @override
  String get chatDetails => 'Maelezo ya Gumzo';

  @override
  String get chatViewAllGroupMembers => 'Tazama wanachama wote';

  @override
  String get chatGroupName => 'Jina la Kikundi';

  @override
  String get chatGroupNameUpdated => 'Jina la kikundi limesasishwa';

  @override
  String get chatUpdateFailed => 'Usasishaji haukufaulu';

  @override
  String get chatNoPermissionToModify => 'Huna ruhusa ya kurekebisha';

  @override
  String get chatGroupManagement => 'Usimamizi wa Kikundi';

  @override
  String get chatMyNicknameInGroup => 'Jina Langu La Utani Katika Kundi';

  @override
  String get chatPinChat => 'Bandika Gumzo';

  @override
  String get chatStrongReminder => 'Kikumbusho chenye Nguvu';

  @override
  String get chatSetChatBackground => 'Weka Mandharinyuma ya Gumzo';

  @override
  String get chatUnknownFile => 'Faili isiyojulikana';

  @override
  String get chatDownload => 'Pakua';

  @override
  String get chatInvalidLocation => 'Mahali si sahihi';

  @override
  String get chatTapToCancel => 'Gusa ili kughairi';

  @override
  String chatCaptureFailed(Object error) {
    return 'Imeshindwa kupiga picha: $error';
  }

  @override
  String get chatProcessingVideo => 'Inachakata video...';

  @override
  String get chatVideoFileNotExist => 'Faili ya video haipo';

  @override
  String get chatVideoDataEmpty => 'Data ya video ni tupu';

  @override
  String get chatVideoTooLarge => 'Ukubwa wa video hauwezi kuzidi MB 100';

  @override
  String get chatSendingVideo => 'Inatuma video...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Imeshindwa kutuma video: $error';
  }

  @override
  String get chatImageFileNotExist => 'Faili ya picha haipo';

  @override
  String get commonImageDataEmpty => 'Data ya picha ni tupu';

  @override
  String get chatSendingImage => 'Inatuma picha...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Imeshindwa kutuma picha: $error';
  }

  @override
  String get chatSendLocation => 'Tuma Mahali';

  @override
  String get chatSelectLocationAndSend => 'Chagua eneo na utume';

  @override
  String get chatShareRealTimeLocation => 'Shiriki Mahali pa Wakati Halisi';

  @override
  String get chatShareLocationForOneHour =>
      'Shiriki eneo la wakati halisi na rafiki kwa saa 1';

  @override
  String get chatLocationSent => 'Mahali pa kutumwa';

  @override
  String get chatSelectMessages => 'Chagua ujumbe';

  @override
  String chatSelectedCount(int count) {
    return 'Imechaguliwa $count';
  }

  @override
  String get chatSelectAll => 'Chagua Zote';

  @override
  String chatGroupChatCount(int count) {
    return 'Gumzo la Kikundi($count)';
  }

  @override
  String get chatPrivateChat => 'Gumzo la Kibinafsi';

  @override
  String get chatNoMessages => 'Hakuna ujumbe';

  @override
  String get chatSendFirstMessage =>
      'Tuma ujumbe wa kwanza ili kuanza kupiga gumzo';

  @override
  String get chatEncryptionNotice =>
      'Gumzo hili limesimbwa kwa njia fiche kutoka mwanzo hadi mwisho. Ni wewe tu na mpokeaji mnaweza kusoma ujumbe.';

  @override
  String get chatMultiForward => 'Mbele';

  @override
  String get chatCollect => 'Kusanya';

  @override
  String get chatNoMembers => 'Hakuna wanachama';

  @override
  String get chatMemberNotFound => 'Mwanachama hajapatikana';

  @override
  String get chatVoiceFileNotExist => 'Faili ya sauti haipo';

  @override
  String get chatVoiceFileEmpty => 'Faili ya sauti haina chochote';

  @override
  String get chatSendingVoice => 'Inatuma sauti...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Imeshindwa kutuma sauti: $error';
  }

  @override
  String get chatMessageForwarded => 'Ujumbe umetumwa';

  @override
  String chatForwardFailed(Object error) {
    return 'Usambazaji mbele haukufaulu: $error';
  }

  @override
  String get chatUnfavorited => 'Isiyopendelewa';

  @override
  String get chatFavorited => 'Imependekezwa';

  @override
  String get chatReactionAdded => 'Maoni yameongezwa';

  @override
  String get chatReactionRemoved => 'Maoni yameondolewa';

  @override
  String get chatFailedMessageDeleted => 'Ujumbe ambao haukufaulu umefutwa';

  @override
  String get chatDeleteMessages => 'Futa ujumbe';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Je, una uhakika unataka kufuta ujumbe wa $count?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Kumbuka: Ujumbe wa $count unatoka kwa wengine na utafutwa kwa ajili yako pekee.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return 'Ujumbe wa $count kutoka kwako utakumbukwa kwa kila mtu.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return 'Umekumbuka ujumbe wa $count, $localCount ilifutwa kwa ajili yako tu';
  }

  @override
  String chatRecalledMessages(Object count) {
    return 'Ujumbe wa $count ulikumbuka';
  }

  @override
  String chatDeletedLocally(Object count) {
    return 'Ujumbe wa $count umefutwa kwa ajili yako tu';
  }

  @override
  String chatForwardedCount(Object count) {
    return 'Imesambazwa ujumbe wa $count';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Usambazaji umekamilika: $success imefaulu, $failed haikufaulu';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'Kipengele cha kukumbusha kinapatikana kwenye gumzo la kikundi pekee';

  @override
  String get chatOnlyTextSearchable => 'Ni SMS pekee zinazoweza kutafutwa';

  @override
  String chatSearchFor(Object text) {
    return 'Tafuta \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Utafutaji wa Baidu';

  @override
  String get chatGoogleSearch => 'Utafutaji wa Google';

  @override
  String get chatBingSearch => 'Utafutaji wa Bing';

  @override
  String get chatCalling => 'Inapiga...';

  @override
  String get chatRinging => 'Inapigia...';

  @override
  String get chatInCall => 'Katika simu';

  @override
  String commonFeatureInDevelopment(Object feature) {
    return 'Kipengele cha $feature katika maendeleo...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'Imekusanya ujumbe wa $count';
  }

  @override
  String commonMemberCount(int count) {
    return 'Wanachama wa $count';
  }

  @override
  String groupDone(int count) {
    return 'Imekamilika($count)';
  }

  @override
  String get profileServices => 'Huduma';

  @override
  String get commonFavorites => 'Vipendwa';

  @override
  String get profileOrdersAndCards => 'Maagizo na Kadi';

  @override
  String get profileStickers => 'Vibandiko';

  @override
  String profileStatusSetTo(String status) {
    return 'Hali imewekwa kuwa: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'Imeshindwa kupakia avatar';

  @override
  String get profilePersonalProfile => 'Wasifu wa Kibinafsi';

  @override
  String get profileName => 'Jina';

  @override
  String get profileGender => 'Jinsia';

  @override
  String get profileRegion => 'Mkoa';

  @override
  String get commonMyQrCode => 'Msimbo wangu wa QR';

  @override
  String get profilePoke => 'Gusa';

  @override
  String get profileRingtone => 'Mlio wa simu';

  @override
  String get profileDefaultRingtone => 'Mlio Chaguomsingi';

  @override
  String get profileMyAddresses => 'Anwani Zangu';

  @override
  String profileGenderSetTo(String gender) {
    return 'Jinsia imewekwa kuwa: $gender';
  }

  @override
  String get profileSelectRegion => 'Chagua Mkoa';

  @override
  String get profileSelectCity => 'Chagua Jiji';

  @override
  String profileRegionSetTo(String region) {
    return 'Mkoa umewekwa kuwa: $region';
  }

  @override
  String get profileSetPoke => 'Weka Poke';

  @override
  String get profileFriendPokedMe => 'Rafiki alinichokoza';

  @override
  String get profileExample => 'Mfano';

  @override
  String get profileOnTheShoulder => ' kwenye bega';

  @override
  String get profilePokeCleared => 'Poke imefutwa';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Poke imewekwa kwa: poked me$suffix';
  }

  @override
  String get profileEditSignature => 'Badilisha Sahihi';

  @override
  String get profileIntroduceYourself => 'Sentensi ya kujitambulisha';

  @override
  String get profileSignatureCleared => 'Sahihi imefutwa';

  @override
  String get profileSignatureUpdated => 'Sahihi imesasishwa';

  @override
  String get profileScanToAddFriend =>
      'Changanua msimbo wa QR hapo juu ili kuniongeza kama rafiki';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Mlio wa simu umewekwa kuwa: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'Je, una uhakika unataka kufuta \"$name\"? Kitendo hiki hakiwezi kutenduliwa.';
  }

  @override
  String get authEnterValidServerAddress =>
      'Tafadhali weka anwani sahihi ya seva';

  @override
  String get authEnterServerAddressFirst =>
      'Tafadhali weka anwani ya seva kwanza';

  @override
  String get authPasskeyRequiresServer =>
      'Kuingia kwa nenosiri kunahitaji usaidizi wa seva';

  @override
  String get authLoginAgreement => 'Kwa kuingia, unakubali ';

  @override
  String get authPleaseAgreeToTerms =>
      'Tafadhali soma na ukubali Sheria na Masharti na Sera ya Faragha';

  @override
  String get authRegisterFailed => 'Usajili umeshindwa';

  @override
  String get authRegistrationDisabled =>
      'Usajili umezimwa kwenye seva hii. Wasiliana na msimamizi wa seva ili kuuwezesha.';

  @override
  String get commonReenterPassword => 'Ingiza tena nenosiri';

  @override
  String get commonPasswordsDoNotMatch => 'Manenosiri hayalingani';

  @override
  String get authInviteCodeBuiltIn => 'Nambari ya Mwaliko (Imejengwa ndani)';

  @override
  String get authInviteCodeBuiltInNote =>
      'Msimbo wa mwaliko umejengewa ndani, kwa kawaida hakuna haja ya kurekebisha';

  @override
  String get authIHaveReadAndAgree => 'Nimesoma na kukubali ';

  @override
  String get mainStartGroupChat => 'Anzisha Gumzo la Kikundi';

  @override
  String get mainAddFriends => 'Ongeza Marafiki';

  @override
  String get mainPaymentAndCollection => 'Malipo';

  @override
  String contactCount(int count) {
    return 'Anwani za $count';
  }

  @override
  String get contactAddToHomeScreen => 'Ongeza kwenye skrini ya kwanza';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'Kadi ya $contact iliyopendekezwa kwa $recipient';
  }

  @override
  String get contactEnterRemarkName => 'Weka jina la maoni';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Maoni yamewekwa kuwa: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Ombi la urafiki la $name limekubaliwa';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Ombi la urafiki la $name limekataliwa';
  }

  @override
  String get commonGroupInvites => 'Mialiko ya Kikundi';

  @override
  String commonMyGroups(int count) {
    return 'Vikundi Vyangu ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Umealikwa kujiunga na kikundi';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'Je, una uhakika unataka kuondoka \"$name\"?';
  }

  @override
  String get commonLeave => 'Ondoka';

  @override
  String get commonRecallThisMessage => 'Je, unakumbuka ujumbe huu?';

  @override
  String get commonSavedToGallery => 'Imehifadhiwa kwenye ghala';

  @override
  String get commonFailedToSave => 'Imeshindwa kuhifadhi';

  @override
  String get chatSaving => 'Inahifadhi...';

  @override
  String get commonShare => 'Shiriki';

  @override
  String get chatSaveToGallery => 'Hifadhi kwenye Matunzio';

  @override
  String get chatFailedToLoadImage => 'Imeshindwa kupakia picha';

  @override
  String get chatVideoRecordingFailed => 'Imeshindwa kurekodi video';

  @override
  String get profileRedPacket => 'Kifurushi Nyekundu';

  @override
  String get commonMusic => 'Muziki';

  @override
  String get commonCoupon => 'Kuponi';

  @override
  String get commonGift => 'Zawadi';

  @override
  String get commonPoll => 'Kura ya maoni';

  @override
  String get favoriteText => 'Maandishi';

  @override
  String get favoriteLinkLabel => 'Kiungo';

  @override
  String get favoriteNote => 'Kumbuka';

  @override
  String get favoriteMyNotes => 'Vidokezo Vyangu';

  @override
  String get favoriteToday => 'Leo';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count siku zilizopita';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$month/$day';
  }

  @override
  String get favoriteNoFavorites => 'Bado hakuna vipendwa';

  @override
  String get favoriteLongPressToFavorite =>
      'Bonyeza kwa muda mrefu ujumbe ili uupende';

  @override
  String get favoriteNewNote => 'Ujumbe Mpya';

  @override
  String get favoriteLink => 'Kiungo Unachopenda';

  @override
  String get favoriteEditTags => 'Hariri Lebo';

  @override
  String get favoriteDeleteFavorite => 'Futa Vipendwa';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Je, una uhakika unataka kufuta kipendwa hiki?';

  @override
  String get favoriteNoSearchResultsFound => 'Hakuna matokeo yaliyopatikana';

  @override
  String get commonSendRedPacket => 'Tuma Kifurushi Nyekundu';

  @override
  String get transferAmount => 'Kiasi';

  @override
  String get commonRedPacketCover => 'Jalada la Pakiti Nyekundu';

  @override
  String get commonRedPacketType => 'Aina ya Pakiti Nyekundu';

  @override
  String get commonNormalRedPacket => 'Kawaida';

  @override
  String get commonLuckyRedPacket => 'Bahati';

  @override
  String get commonRedPacketCount => 'Hesabu ya Pakiti Nyekundu';

  @override
  String get commonPieces => 'vipande';

  @override
  String get commonPutMoneyInRedPacket => 'Weka pesa kwenye pakiti nyekundu';

  @override
  String get commonRedPacketRefundNotice =>
      'Pakiti nyekundu ambazo hazijadaiwa zitarejeshwa baada ya saa 24';

  @override
  String get commonOpenRedPacket => 'Fungua';

  @override
  String get commonRedPacketAllClaimed => 'Pakiti nyekundu zote zinadaiwa';

  @override
  String get commonRedPacketExpired => 'Pakiti nyekundu imeisha muda wake';

  @override
  String get commonAddTransferNote => 'Ongeza kidokezo cha uhamishaji';

  @override
  String get commonYuan => 'CNY';

  @override
  String get commonReplyWithEmoji => 'Jibu ukitumia emoji hii';

  @override
  String get contactEditRemark => 'Hariri Maoni';

  @override
  String get contactSetPermissions => 'Weka Ruhusa';

  @override
  String get profileAddToBlacklist => 'Ongeza kwenye Orodha Nyeusi';

  @override
  String get contactDeleteContact => 'Futa Anwani';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Je, una uhakika unataka kufuta $name?';
  }

  @override
  String get transferTitle => 'Uhamisho';

  @override
  String get transferReceiverAddressLabel => 'Anwani ya Mpokeaji';

  @override
  String get transferSelectTokenLabel => 'Chagua Tokeni';

  @override
  String get transferAmountLabel => 'Kiasi cha Uhamisho';

  @override
  String get transferMemoLabel => 'Memo (ya hiari)';

  @override
  String get transferAddMemoHint => 'Ongeza memo';

  @override
  String get transferSendPaymentRequest => 'Tuma Ombi la Malipo';

  @override
  String get transferQrCodeGenerateFailed => 'Imeshindwa kuunda msimbo wa QR';

  @override
  String get transferScanQrToPayMe => 'Changanua msimbo wa QR ili kunilipa';

  @override
  String get transferMyWalletAddress => 'Anwani yangu ya Wallet';

  @override
  String get transferCreatePaymentRequest => 'Unda Ombi la Malipo';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'Kila la heri';

  @override
  String commonSenderRedPacket(String name) {
    return 'Pakiti Nyekundu ya $name';
  }

  @override
  String get transferEnterValidAddress => 'Tafadhali weka anwani halali';

  @override
  String get transferPleaseSelectToken => 'Tafadhali chagua tokeni';

  @override
  String get commonReceivedTransfer => 'Uhamisho Umepokea';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name ilituma pakiti nyekundu';
  }

  @override
  String get commonSavedToBalance =>
      'Imehifadhiwa kwa usawa, inaweza kuhamisha moja kwa moja';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'Pakiti nyekundu imeisha muda wake/zote zinadaiwa';

  @override
  String get transferScanFeatureComingSoon =>
      'Kipengele cha Scan kinakuja hivi karibuni...';

  @override
  String get contactSetAsStarred => 'Weka kama Yenye Nyota';

  @override
  String get contactAddToBlocklist => 'Ongeza kwenye Orodha ya Kuzuia';

  @override
  String get commonClaimedYour => ' alidai yako ';

  @override
  String get commonClaimedText => ' alidai ';

  @override
  String commonUserTyping(String name) {
    return '$name anaandika...';
  }

  @override
  String get commonTyping => 'Inaandika...';

  @override
  String get commonWaitingToReceive => 'Inasubiri kupokea';

  @override
  String get commonTapToClaim => 'Gusa ili kudai';

  @override
  String get commonHasBeenReceived => 'Imepokelewa';

  @override
  String get commonGetLucky => 'Pata bahati';

  @override
  String get qrcodeCameraStartFailed => 'Kamera imeshindwa kuanza';

  @override
  String get qrcodeUnknownError => 'Hitilafu isiyojulikana';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'Weka msimbo wa QR ndani ya fremu ili uchanganue';

  @override
  String get qrcodeCloseManualInput => 'Funga Uingizaji wa Mwongozo';

  @override
  String get qrcodeManualInputUserId =>
      'Kitambulisho cha Mtumiaji cha Kuingiza kwa Mwongozo';

  @override
  String get commonAdd => 'Ongeza';

  @override
  String get profileSetStatus => 'Weka Hali';

  @override
  String get profileVisibleToFriends24h => 'Inaonekana kwa marafiki kwa saa 24';

  @override
  String get profileWriteStatus => 'Andika Hali';

  @override
  String get profileEnterYourStatus => 'Weka hali yako...';

  @override
  String get profileOk => 'Sawa';

  @override
  String get qrcodeCameraPermissionRequired =>
      'Ruhusa ya kamera inahitajika ili kuchanganua msimbo wa QR';

  @override
  String get qrcodeCameraPermissionDenied =>
      'Ruhusa ya kamera ilikataliwa kabisa. Tafadhali iwashe katika mipangilio ya mfumo.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Hitilafu katika kuangalia ruhusa: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'Msimbo wa QR si sahihi';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Haiwezi kuongeza rafiki: $error';
  }

  @override
  String get qrcodeScanQrCode => 'Changanua Msimbo wa QR';

  @override
  String get qrcodeCheckingCameraPermission => 'Inakagua ruhusa ya kamera...';

  @override
  String get qrcodeNeedCameraPermission => 'Ruhusa ya Kamera Inahitajika';

  @override
  String get qrcodeRetryPermission => 'Jaribu tena';

  @override
  String get qrcodeOpenSettings => 'Fungua Mipangilio';

  @override
  String get groupInviteMembers => 'Alika Wanachama';

  @override
  String groupInviteCount(int count) {
    return 'Alika($count)';
  }

  @override
  String get profileNoShippingAddress => 'Hakuna anwani ya usafirishaji';

  @override
  String get profileDefaultLabel => 'Chaguomsingi';

  @override
  String get profileNoInvoice => 'Hakuna ankara';

  @override
  String get profileCompany => 'Kampuni';

  @override
  String get profileTaxNumber => 'Nambari ya Ushuru';

  @override
  String get profileConfirmDeleteAddress =>
      'Je, una uhakika unataka kufuta anwani hii?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Je, una uhakika unataka kufuta ankara hii?';

  @override
  String get commonGroupOwner => 'Mmiliki';

  @override
  String get commonGroupAdmin => 'Msimamizi';

  @override
  String get groupSearchMembers => 'Tafuta wanachama';

  @override
  String groupTotalMembers(int count) {
    return 'Wanachama wa $count';
  }

  @override
  String get chatRemoveFromGroup => 'Ondoa kwenye Kikundi';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Je, una uhakika unataka kuondoa \"$name\" kutoka kwa kikundi?';
  }

  @override
  String get chatUnknownSong => 'Wimbo Usiojulikana';

  @override
  String get chatUnknownArtist => 'Msanii Asiyejulikana';

  @override
  String get chatUnknownContact => 'Anwani Isiyojulikana';

  @override
  String get chatPersonalCard => 'Kadi ya Mawasiliano';

  @override
  String get chatSingleChoice => 'Mtu mmoja';

  @override
  String get chatMultiChoice => 'Nyingi';

  @override
  String get chatEnded => 'Imeisha';

  @override
  String get chatEndPollButton => 'Maliza Kura';

  @override
  String get chatPollHint =>
      'Kura itaonyeshwa kwenye gumzo. Wanakikundi wanaweza kupiga kura.';

  @override
  String get chatSearchSongOrArtist => 'Tafuta wimbo au msanii';

  @override
  String get chatNoSongsFound => 'Hakuna nyimbo zilizopatikana';

  @override
  String get chatSongNameOptional => 'Jina la Wimbo (Si lazima)';

  @override
  String get chatEnterSongName => 'Ingiza jina la wimbo';

  @override
  String get chatArtistNameOptional => 'Jina la Msanii (Si lazima)';

  @override
  String get chatEnterArtistName => 'Weka jina la msanii';

  @override
  String get chatRealTimeLocationSharing =>
      'Kushiriki mahali kwa wakati halisi katika ukuzaji...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Kipengele cha simu ya sauti katika usanidi...';

  @override
  String get profileReportFeatureInDev =>
      'Ripoti kipengele katika maendeleo...';

  @override
  String get profileShareFeatureInDev => 'Shiriki kipengele katika ukuzaji...';

  @override
  String get profileQrCodeFeatureInDev =>
      'Kipengele cha msimbo wa QR katika ukuzaji...';

  @override
  String get qrcodeScanQrToAddMe =>
      'Changanua msimbo wa QR hapo juu ili kuniongeza kama rafiki';

  @override
  String get qrcodeSaveToAlbum => 'Hifadhi kwenye Albamu';

  @override
  String get qrcodeChangeStyle => 'Badilisha Mtindo';

  @override
  String get qrcodeCopyId => 'Nakili ID';

  @override
  String get qrcodeIdCopied => 'Kitambulisho kimenakiliwa';

  @override
  String get qrcodeMoreStylesFeatureComingSoon =>
      'Mitindo zaidi inakuja hivi karibuni';

  @override
  String get profileBio => 'Wasifu';

  @override
  String get profileHomeServer => 'Seva';

  @override
  String get profileShareContactCard => 'Shiriki Kadi ya Mawasiliano';

  @override
  String get profileRemoveFromBlacklist => 'Ondoa kutoka kwa Orodha Nyeusi';

  @override
  String get profileConfirmAddBlacklist =>
      'Je, una uhakika unataka kuongeza mtumiaji huyu kwenye orodha isiyoruhusiwa? Hutapokea ujumbe kutoka kwao.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Je, una uhakika unataka kumwondoa mtumiaji huyu kwenye orodha iliyoidhinishwa?';

  @override
  String get profileRemarkSaved => 'Maoni yamehifadhiwa';

  @override
  String get profileRemarkCleared => 'Maoni yamefutwa';

  @override
  String get transferReceive => 'Pokea';

  @override
  String get transferPleaseConnectWallet =>
      'Tafadhali unganisha pochi yako kwanza';

  @override
  String get transferSendRequest => 'Tuma Ombi';

  @override
  String get transferPleaseEnterValidAmount => 'Tafadhali weka kiasi halali';

  @override
  String get searchPlaceholder => 'Tafuta anwani, vikundi, ujumbe';

  @override
  String get searchEnterKeywordToSearch =>
      'Weka nenomsingi ili kuanza kutafuta';

  @override
  String get searchClearHistory => 'Wazi';

  @override
  String get searchClearHistoryConfirm =>
      'Futa utafutaji wote wa hivi karibuni?';

  @override
  String searchNoResultsForQuery(String query) {
    return 'Hakuna matokeo yaliyopatikana ya \"$query\"';
  }

  @override
  String get searchAllResults => 'Wote';

  @override
  String get searchInChat => 'Tafuta kwenye gumzo';

  @override
  String get searchContactLabel => 'Wasiliana';

  @override
  String get searchGroupLabel => 'Kikundi';

  @override
  String get searchConversationLabel => 'Mazungumzo';

  @override
  String get searchMessageLabel => 'Ujumbe';

  @override
  String get settingsSecurityTitle => 'Usalama';

  @override
  String get settingsDeleteAccountTitle => 'Futa akaunti';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Zima akaunti hii ya Matrix na usafishe data yake ya gumzo iliyo kwenye kifaa';

  @override
  String get settingsDeleteAccountExplanation =>
      'Hatua hii inaomba akaunti ya Matrix izimwe kabisa. Baada ya uthibitisho wa seva, programu itaondoa kipindi cha gumzo na funguo za usimbaji fiche za akaunti hii kwenye kifaa wakati ni salama kufanya hivyo. Akaunti nyingine na pochi yako vitahifadhiwa. Muungano wa seva na sera za uhifadhi zinaweza kuzuia ufutaji wa data.';

  @override
  String get settingsDeleteAccountPasswordOptional =>
      'Nenosiri la Matrix, likihitajika';

  @override
  String get settingsDeleteAccountServerErase =>
      'Omba kufutwa kwa data kwenye seva';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      'Omba seva hii ya nyumbani ifute data ya akaunti inapowezekana. Nakala zilizo kwenye seva nyingine au zinazohitajika na sera za uhifadhi zinaweza kubaki.';

  @override
  String get settingsDeleteAccountChooseStage =>
      'Thibitisha akaunti hii ya Matrix';

  @override
  String get settingsDeleteAccountUsePassword => 'Tumia nenosiri la Matrix';

  @override
  String get settingsDeleteAccountUseBrowser => 'Endelea kwenye kivinjari';

  @override
  String get settingsDeleteAccountFallbackTitle =>
      'Rudi kutoka uthibitishaji wa Matrix';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      'Kurudi kutoka kivinjari hakuthibitishi ufutaji. Angalia ombi la awali kwenye seva ya Matrix.';

  @override
  String get settingsDeleteAccountCheckServer => 'Angalia kwenye seva';

  @override
  String get settingsDeleteAccountRequestFailed =>
      'Seva ya Matrix haijathibitisha kufutwa kwa akaunti.';

  @override
  String get settingsDeleteAccountPendingTitle =>
      'Usafishaji wa akaunti kwenye kifaa unasubiri';

  @override
  String get settingsDeleteAccountPendingSubtitle =>
      'Kagua usafishaji wa akaunti ya Matrix iliyozimwa hapo awali';

  @override
  String get settingsDeleteAccountPendingReadError =>
      'Imeshindwa kusoma rekodi za usafishaji unaosubiri. Gusa ili kujaribu tena.';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'Akaunti ya Matrix imezimwa, lakini usafishaji kwenye kifaa bado unasubiri. Akaunti nyingine zinaendelea kupatikana.';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      'Usimamizi wa akaunti umefunguliwa kwenye kivinjari chako. Ufutaji haujathibitishwa katika programu hii, hivyo kipindi chako cha gumzo kinaendelea kupatikana.';

  @override
  String get settingsKeyBackup => 'Hifadhi Nakala muhimu';

  @override
  String get settingsBackupEncryptionKeys => 'Vifunguo vya Usimbaji Nakala';

  @override
  String settingsKeysBackedUp(int count) {
    return 'Vifunguo vya $count vimechelezwa';
  }

  @override
  String get settingsBackupNotSet => 'Hifadhi rudufu haijawekwa';

  @override
  String get settingsRestoreKeys => 'Rejesha Funguo';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Rejesha funguo za usimbuaji kutoka kwa nakala rudufu';

  @override
  String get settingsExportKeys => 'Funguo za kuuza nje';

  @override
  String get settingsExportKeysToFile => 'Hamisha vitufe kwenye faili';

  @override
  String get settingsLoggedInDevices => 'Vifaa Ulivyoingia';

  @override
  String get settingsNoOtherDevices => 'Hakuna vifaa vingine';

  @override
  String get settingsVerified => 'Imethibitishwa';

  @override
  String get settingsUnverified => 'Haijathibitishwa';

  @override
  String get settingsAdvanced => 'Mipangilio ya kina';

  @override
  String get settingsCrossSigning => 'Kusaini Mtambuka';

  @override
  String get settingsEnabled => 'Imewashwa';

  @override
  String get settingsNotEnabled => 'Haijawezeshwa';

  @override
  String get settingsResetEncryption => 'Weka Usimbaji upya';

  @override
  String get settingsDeleteAllEncryptionKeys =>
      'Futa funguo zote za usimbaji fiche';

  @override
  String get settingsEncryptionNotSupported => 'Usimbaji fiche hautumiki';

  @override
  String get settingsNotInitialized => 'Haijaanzishwa';

  @override
  String get settingsBackupKeyTitle => 'Vifunguo vya Hifadhi Nakala';

  @override
  String get settingsBackupKeyMessage =>
      'Ungependa kuunda nakala mpya ya ufunguo? Hii itakusaidia kurejesha ujumbe uliosimbwa kwa njia fiche kwenye kifaa kipya.';

  @override
  String get settingsBackup => 'Hifadhi nakala';

  @override
  String get settingsRestoreKeyTitle => 'Rejesha Funguo';

  @override
  String get settingsRestoreKeyMessage =>
      'Weka nenosiri lako la kurejesha akaunti au ufunguo wa kurejesha akaunti ili kurejesha ujumbe uliosimbwa.';

  @override
  String get settingsRestore => 'Rejesha';

  @override
  String get settingsExportKeyTitle => 'Funguo za kuuza nje';

  @override
  String get settingsExportKeyMessage =>
      'Faili ya ufunguo iliyohamishwa ina funguo zako zote za usimbaji fiche. Tafadhali weka salama.';

  @override
  String get settingsExport => 'Hamisha';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'Kitambulisho cha Kifaa: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Hali: Imethibitishwa';

  @override
  String get settingsDeviceStatusUnverified => 'Hali: Haijathibitishwa';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Mara ya mwisho kutumika: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Thibitisha kifaa hiki';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'Kutia sahihi kwa njia tofauti tayari kumewezeshwa';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Usanidi wa kuambatisha cheti umefaulu';

  @override
  String get settingsResetEncryptionTitle => 'Weka Usimbaji upya';

  @override
  String get settingsResetEncryptionWarning =>
      'Onyo: Hii itafuta funguo zako zote za usimbaji fiche. Hutaweza kusimbua ujumbe uliosimbwa kwa njia fiche hapo awali. Kitendo hiki hakiwezi kutenduliwa.';

  @override
  String get settingsReset => 'Weka upya';

  @override
  String get settingsBackupSuccess => 'Vifunguo vimechelezwa';

  @override
  String get settingsBackupFailed => 'Imeshindwa kuhifadhi nakala';

  @override
  String get settingsRecoveryKey => 'Ufunguo wa Kuokoa';

  @override
  String get settingsRecoveryKeySaveWarning =>
      'Tafadhali hifadhi ufunguo huu wa kurejesha akaunti mahali salama. Utaihitaji ili kurejesha ujumbe wako uliosimbwa kwa njia fiche kwenye kifaa kipya.';

  @override
  String get settingsRecoveryKeySaved => 'Nimeihifadhi';

  @override
  String get settingsRestoreSuccess => 'Vifunguo vimerejeshwa';

  @override
  String get settingsRestoreEmpty =>
      'Hakuna funguo za ujumbe zilizopatikana katika nakala hii.';

  @override
  String settingsRestoreSessions(int count) {
    return 'Vipindi $count vya funguo vimerejeshwa. Ujumbe usio na funguo unaweza kubaki umesimbwa.';
  }

  @override
  String get settingsRestoreFailed => 'Kurejesha kumeshindwa';

  @override
  String get settingsPassword => 'Nenosiri';

  @override
  String get settingsEnterRecoveryKey => 'Ingiza ufunguo wa kurejesha';

  @override
  String get settingsEnterPassword => 'Weka nenosiri';

  @override
  String get settingsExportSuccess =>
      'Vifunguo vimehamishwa kwa hifadhi rudufu ya seva';

  @override
  String get settingsExportNeedBackupFirst =>
      'Tafadhali unda nakala rudufu ya ufunguo kwanza';

  @override
  String get settingsExportFailed => 'Imeshindwa kuhamisha';

  @override
  String get settingsResetSuccess => 'Usimbaji upya umefaulu';

  @override
  String get settingsResetFailed => 'Imeshindwa kuweka upya';

  @override
  String get callLeaveMeetingConfirm =>
      'Je, una uhakika unataka kuondoka kwenye mkutano?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'ilipigwa $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'Hakuna anwani zinazopatikana za kuongeza';

  @override
  String get chatAddMembers => 'Ongeza Wanachama';

  @override
  String chatInvitedMembers(int count) {
    return 'Wamealikwa washiriki wa $count';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Imeshindwa kualika: $error';
  }

  @override
  String get chatMemberRemoved => 'Mwanachama ameondolewa';

  @override
  String chatRemoveFailed(String error) {
    return 'Imeshindwa kuondoa: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'Baada ya kushiriki, mhusika mwingine anaweza kuona eneo lako la wakati halisi kwa saa 1.';

  @override
  String get chatStartSharing => 'Anza Kushiriki';

  @override
  String get chatLocationServiceNotEnabled => 'Huduma ya eneo haijawashwa';

  @override
  String get chatEnableLocationService =>
      'Tafadhali wezesha huduma ya eneo ili kutumia kipengele hiki';

  @override
  String get chatGoToSettings => 'Nenda kwa Mipangilio';

  @override
  String get chatLocationPermissionRequired =>
      'Ruhusa ya eneo inahitajika kwa kipengele hiki';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'Ruhusa ya eneo imekataliwa kabisa. Tafadhali iwashe katika mipangilio.';

  @override
  String get chatLocationPermissionDenied => 'Ruhusa ya eneo imekataliwa';

  @override
  String get chatGettingLocation => 'Inapata eneo...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Imeshindwa kupata eneo: $error';
  }

  @override
  String get chatMapPreview => 'Hakiki ya Ramani';

  @override
  String get chatSearchLocation => 'Tafuta eneo';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'Imetumwa pakiti nyekundu ya $amount $token';
  }

  @override
  String get chatTransferDefault => 'Uhamisho';

  @override
  String chatTransferSent(String amount, String token) {
    return 'Imetuma uhamisho wa $amount $token';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Imeshindwa kuchagua faili: $error';
  }

  @override
  String get chatFileSizeLimit => 'Ukubwa wa faili hauwezi kuzidi MB 50';

  @override
  String chatFileSending(String filename) {
    return 'Inatuma faili: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Imeshindwa kutuma faili: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'Imetuma kadi ya mawasiliano ya $name';
  }

  @override
  String get chatFavoritesFeature => 'Vipendwa';

  @override
  String get chatCouponsFeature => 'Kuponi';

  @override
  String get chatGiftFeature => 'Zawadi';

  @override
  String chatSharedMusic(String name) {
    return 'Iliyoshirikiwa $name';
  }

  @override
  String get chatEndPollTitle => 'Maliza Kura';

  @override
  String get chatEndPollConfirmMessage =>
      'Je, una uhakika ungependa kusitisha kura hii? Upigaji kura utafungwa baada ya kumalizika.';

  @override
  String get chatPollEndedMessage => 'Kura ya maoni imekamilika';

  @override
  String get chatConnectingCall => 'Inaunganisha...';

  @override
  String get chatMuteCall => 'Nyamazisha';

  @override
  String get chatSpeakerOff => 'Spika Imezimwa';

  @override
  String get chatSpeakerOn => 'Spika';

  @override
  String get chatCameraOn => 'Kamera Imewashwa';

  @override
  String get chatCameraOff => 'Kamera Imezimwa';

  @override
  String get chatHangUp => 'Kata Simu';

  @override
  String get chatSelectForwardTargetTitle => 'Chagua Lengo la Mbele';

  @override
  String get chatNoForwardableChat =>
      'Hakuna gumzo zinazopatikana za kusambaza';

  @override
  String get chatNoMatchingChat => 'Hakuna soga zinazolingana zilizopatikana';

  @override
  String get chatLocationTitle => 'Mahali';

  @override
  String get chatSendButton => 'Tuma';

  @override
  String get chatRetryButton => 'Jaribu tena';

  @override
  String get chatSearchContactHint => 'Tafuta anwani';

  @override
  String get chatShareMusic => 'Shiriki Muziki';

  @override
  String get chatRecentPlayed => 'Hivi karibuni';

  @override
  String get chatMyFavorites => 'Vipendwa';

  @override
  String get chatNetworkLink => 'Kiungo';

  @override
  String get chatLocalFile => 'Ndani';

  @override
  String get chatPasteMusicLink => 'Bandika kiungo cha muziki';

  @override
  String get chatShareMusicButton => 'Shiriki Muziki';

  @override
  String get chatSelectLocalAudio => 'Chagua Faili ya Sauti ya Karibu Nawe';

  @override
  String get chatSupportedAudioFormats => 'Inasaidia MP3, M4A, WAV, FLAC, nk.';

  @override
  String get chatSelectFileButton => 'Chagua Faili';

  @override
  String get chatPleaseEnterMusicLink => 'Tafadhali weka kiungo cha muziki';

  @override
  String get chatPleaseEnterValidLink => 'Tafadhali weka URL halali';

  @override
  String get chatSharedSong => 'Wimbo Ulioshirikiwa';

  @override
  String get chatSelectMember => 'Chagua Mwanachama';

  @override
  String get chatSearchMemberHint => 'Tafuta wanachama';

  @override
  String get chatNoMatchingMembers =>
      'Hakuna wanachama wanaolingana waliopatikana';

  @override
  String get commonUnknownMember => 'Haijulikani';

  @override
  String chatSelectedMessagesCount(int count) {
    return 'Ujumbe wa $count uliochaguliwa';
  }

  @override
  String get chatSearchContactsOrGroups => 'Tafuta anwani au vikundi';

  @override
  String get chatVideoTitle => 'Video';

  @override
  String get chatLoadingText => 'Inapakia...';

  @override
  String get chatVideoLoadFailed => 'Imeshindwa kupakia video';

  @override
  String get chatPlayerInitFailed => 'Uanzishaji wa mchezaji haukufaulu';

  @override
  String get chatCreatePollTitle => 'Unda Kura';

  @override
  String get chatSubmitPoll => 'Wasilisha';

  @override
  String get chatPollQuestionLabel => 'Swali la Kura';

  @override
  String get chatEnterPollQuestionHint =>
      'Tafadhali ingiza swali la kura ya maoni';

  @override
  String get chatPollOptionsLabel => 'Chaguo za Kura';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Chaguo $index';
  }

  @override
  String get chatAddOptionButton => 'Ongeza Chaguo';

  @override
  String get chatPollSettingsLabel => 'Mipangilio ya Kura';

  @override
  String get chatSelectionType => 'Aina ya Uteuzi';

  @override
  String get chatSingleChoiceLabel => 'Mtu mmoja';

  @override
  String get chatMultiChoiceLabel => 'Nyingi';

  @override
  String get chatAnonymousPollSwitch => 'Kura Isiyojulikana';

  @override
  String get chatPleaseEnterQuestion =>
      'Tafadhali ingiza swali la kura ya maoni';

  @override
  String get chatAtLeastTwoOptions => 'Angalau chaguzi 2 zinahitajika';

  @override
  String chatConfirmWithCount(int count) {
    return 'Thibitisha ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'Uthibitishaji wa Barua Pepe';

  @override
  String get authEnterValidEmailAddress => 'Tafadhali weka barua pepe halali';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Nambari ya kuthibitisha imetumwa kwa $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Imeshindwa kutuma msimbo: $error';
  }

  @override
  String get authVerificationSuccess => 'Uthibitishaji umefaulu';

  @override
  String get authVerificationFailed => 'Uthibitishaji haukufaulu';

  @override
  String authVerificationCodeError(String error) {
    return 'Hitilafu ya msimbo wa uthibitishaji: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Weka nambari ya kuthibitisha';

  @override
  String get authEnterYourEmail => 'Weka barua pepe';

  @override
  String authWeSentCodeTo(String email) {
    return 'Tulituma msimbo wa tarakimu 6 kwa\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'Weka barua pepe yako, tutakutumia nambari ya kuthibitisha';

  @override
  String get commonSendVerificationCode => 'Tuma nambari ya kuthibitisha';

  @override
  String get authResendVerificationCode => 'Tuma tena nambari ya kuthibitisha';

  @override
  String authCanResendAfter(int seconds) {
    return 'Inaweza kutuma tena baada ya sekunde $seconds';
  }

  @override
  String get commonChangeEmail => 'Badilisha Barua pepe';

  @override
  String get contactAddToContacts => 'Ongeza kwa Anwani';

  @override
  String get contactAddingToContacts => 'Inaongeza...';

  @override
  String get contactAddedToContacts => 'Imeongezwa kwa anwani';

  @override
  String contactAddFailedWithError(String error) {
    return 'Imeshindwa kuongeza: $error';
  }

  @override
  String get contactAddPhone => 'Ongeza simu';

  @override
  String get contactAddTag => 'Ongeza vitambulisho';

  @override
  String get contactAddText => 'Ongeza maandishi';

  @override
  String get contactAddPhoto => 'Ongeza picha';

  @override
  String contactGroupCountLabel(int count) {
    return 'Vikundi vya $count';
  }

  @override
  String get contactAddedViaSearch => 'Imeongezwa kupitia utafutaji';

  @override
  String get contactAddTime => 'Ongeza muda';

  @override
  String get contactDoneButton => 'Imekamilika';

  @override
  String get callWaitingForParticipants => 'Inasubiri washiriki kujiunga...';

  @override
  String callParticipantMe(String name) {
    return '$name (Mimi)';
  }

  @override
  String get callSharingLabel => 'Kushiriki';

  @override
  String callScreenSharingBy(String name) {
    return '$name inashiriki skrini';
  }

  @override
  String callParticipantCount(int count) {
    return 'washiriki wa $count';
  }

  @override
  String get callMuteLabel => 'Nyamazisha';

  @override
  String get callUnmuteLabel => 'Rejesha sauti';

  @override
  String get callTurnOffVideo => 'Zima video';

  @override
  String get callTurnOnVideo => 'Washa video';

  @override
  String get callShareScreen => 'Shiriki skrini';

  @override
  String get callStopSharing => 'Acha kushiriki';

  @override
  String get callSwitchCameraLabel => 'Badili';

  @override
  String get callLeaveLabel => 'Ondoka';

  @override
  String get callParticipantsLabel => 'Washiriki';

  @override
  String get callJoiningMeeting => 'Unajiunga na mkutano...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return 'Kura za $count ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return 'washiriki wa $count';
  }

  @override
  String get chatNoMediaUrlAvailable => 'Hakuna URL ya midia inayopatikana';

  @override
  String chatDownloadFailed(String code) {
    return 'Imeshindwa kupakua: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return 'Hitilafu: $message';
  }

  @override
  String get chatMusicLinkLabel => 'Kiungo cha muziki';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Vifurushi vyekundu na uhamishaji hauwezi kusambazwa';

  @override
  String commonShareFailed(String error) {
    return 'Imeshindwa kushiriki: $error';
  }

  @override
  String get commonTapToRetry => 'Gusa ili kujaribu tena';

  @override
  String get chatDefaultRedPacketGreeting => 'Matakwa bora kwa ustawi';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Ruhusu wengine kutafuta na kujiunga';

  @override
  String get groupConfirmClearChatHistory =>
      'Je, una uhakika unataka kufuta historia ya gumzo?';

  @override
  String get groupCreateGroupToChat => 'Unda kikundi ili kuanza kupiga gumzo';

  @override
  String get groupEditGroupAnnouncement => 'Badilisha tangazo la kikundi';

  @override
  String get groupEditGroupDescription => 'Badilisha maelezo ya kikundi';

  @override
  String get groupEnterGroupAnnouncement => 'Weka tangazo la kikundi';

  @override
  String groupMemberCountClickToCopy(Object count) {
    return 'Wanachama wa $count, bofya ili kunakili kitambulisho cha kikundi';
  }

  @override
  String get groupNoPermissionToEditGroupName =>
      'Huna ruhusa ya kuhariri jina la kikundi';

  @override
  String get authEmailAddress => 'Anwani ya Barua Pepe';

  @override
  String get commonEnterEmailAddress => 'Weka barua pepe';

  @override
  String get authEmailRecoveryHint => 'Inatumika kurejesha nenosiri';

  @override
  String get commonInvalidEmailFormat => 'Tafadhali weka barua pepe halali';

  @override
  String get authOptional => 'Hiari';

  @override
  String get authResetPassword => 'Weka upya Nenosiri';

  @override
  String get authEnterRegisteredEmail =>
      'Weka barua pepe uliyojiandikisha nayo';

  @override
  String get authSendResetCode => 'Tuma Msimbo wa Kuweka Upya';

  @override
  String authResetCodeSent(String email) {
    return 'Weka upya msimbo umetumwa kwa $email';
  }

  @override
  String get authEnterResetCode => 'Weka msimbo wa kuweka upya';

  @override
  String get authSetNewPassword => 'Weka Nenosiri Jipya';

  @override
  String get commonConfirmNewPassword => 'Thibitisha Nenosiri Jipya';

  @override
  String get commonNewPassword => 'Nenosiri Mpya';

  @override
  String get authPasswordResetSuccess =>
      'Uwekaji upya nenosiri umefaulu. Tafadhali ingia kwa nenosiri lako jipya.';

  @override
  String get authResetPasswordFailed => 'Imeshindwa kuweka upya nenosiri';

  @override
  String get settingsChangePassword => 'Badilisha Nenosiri';

  @override
  String get settingsCurrentPassword => 'Nenosiri la Sasa';

  @override
  String get settingsEnterCurrentPassword => 'Weka nenosiri la sasa';

  @override
  String get settingsEnterNewPassword => 'Weka nenosiri jipya';

  @override
  String get settingsPasswordChanged =>
      'Nenosiri limebadilishwa. Tafadhali ingia kwa nenosiri lako jipya.';

  @override
  String get settingsChangePasswordFailed => 'Imeshindwa kubadilisha nenosiri';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'Nenosiri mpya lazima liwe tofauti na nenosiri la sasa';

  @override
  String get settingsChangePasswordInfo =>
      'Baada ya kubadilisha nenosiri, utatoka nje na unahitaji kuingia na nenosiri jipya.';

  @override
  String get settingsPasswordRequirements => 'Mahitaji ya nenosiri:';

  @override
  String get settingsSecurityNote =>
      'Kwa usalama, utahitaji kuingia tena kwenye vifaa vyote baada ya kubadilisha nenosiri.';

  @override
  String get settingsSecurity => 'Usalama';

  @override
  String get settingsCurrentBoundEmail => 'Barua pepe iliyofungwa kwa sasa';

  @override
  String get settingsNewEmailAddress => 'Anwani Mpya ya Barua Pepe';

  @override
  String get settingsEnterNewEmail => 'Weka barua pepe mpya';

  @override
  String get settingsVerificationCode => 'Nambari ya Uthibitishaji';

  @override
  String get settingsVerificationCodeSent => 'Nambari ya kuthibitisha imetumwa';

  @override
  String get settingsCodeSentTo => 'Nambari ya kuthibitisha imetumwa kwa';

  @override
  String get settingsDidNotReceiveCode => 'Hukupokea nambari ya kuthibitisha?';

  @override
  String get settingsEmailChangedSuccess => 'Barua pepe imebadilishwa';

  @override
  String get settingsChangeEmailFailed => 'Imeshindwa kubadilisha barua pepe';

  @override
  String get settingsEmailSecurityNote =>
      'Barua pepe yako inatumika kurejesha nenosiri. Tafadhali ihifadhi salama.';

  @override
  String get commonGoogleLogin => 'Ingia kwa kutumia Google';

  @override
  String get commonAppleLogin => 'Ingia kwa kutumia Apple';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Lugha';

  @override
  String get settingsLanguageChanged => 'Lugha imebadilika';

  @override
  String get settingsTranslation => 'Tafsiri';

  @override
  String get settingsTranslateTextTo => 'Tafsiri maandishi kwa';

  @override
  String get settingsTranslateDescription =>
      'Chagua lugha unayotaka ujumbe utafsiriwe.';

  @override
  String get settingsAutoTranslate => 'Tafsiri kiotomatiki ujumbe uliopokelewa';

  @override
  String get settingsAutoTranslateDescription =>
      'Tafsiri kiotomatiki ujumbe uliopokewa kwenye gumzo hadi lugha uliyochagua.';

  @override
  String get settingsBiometricLogin => 'Kuingia kwa Biometriska';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Ingia ukitumia $type';
  }

  @override
  String get settingsBiometricLoginEnabled =>
      'Kuingia kwa kibayometriki kumewashwa';

  @override
  String get settingsBiometricLoginDisabled =>
      'Kuingia kwa kibayometriki kumezimwa';

  @override
  String get settingsEnableBiometricLogin => 'Washa kuingia kwa kibayometriki';

  @override
  String get settingsBiometricEnabled =>
      'Imewashwa - Tumia kibayometriki kuingia';

  @override
  String get settingsBiometricDisabled => 'Imezimwa - Gusa ili kuwezesha';

  @override
  String get settingsBiometricNeedRelogin =>
      'Tafadhali ondoka na uingie tena ili kuwezesha kuingia kwa kibayometriki';

  @override
  String get authOr => 'AU';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'Ufikiaji wa kamera umezuiwa kwenye kifaa hiki';

  @override
  String get authPasskeyLabel => 'Nenosiri';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'Apple';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get authSsoNotConfigured =>
      'Seva hii haijasanidi watoa huduma wa kuingia SSO';

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
      'Ingiza kiambishi cha poke, kwa mfano: kwenye bega';

  @override
  String get groupAlbum => 'Albamu ya Kikundi';

  @override
  String get groupFiles => 'Faili za Kikundi';

  @override
  String get groupImages => 'Picha';

  @override
  String get groupVideos => 'Video';

  @override
  String get groupTotal => 'Jumla';

  @override
  String get groupSize => 'Ukubwa';

  @override
  String get groupNoMedia => 'Hakuna Vyombo vya Habari';

  @override
  String get groupNoMediaDescription =>
      'Bado hakuna picha au video katika kikundi hiki';

  @override
  String get groupDocuments => 'Hati';

  @override
  String get groupNoFiles => 'Hakuna Faili';

  @override
  String get groupNoFilesDescription => 'Bado hakuna faili katika kikundi hiki';

  @override
  String groupDownloadStarted(String filename) {
    return 'Inapakua $filename...';
  }

  @override
  String get contactNoCommonGroups => 'Hakuna vikundi vya kawaida';

  @override
  String get contactNoCommonGroupsDescription =>
      'Huna vikundi vyovyote vya pamoja';

  @override
  String get chatVoiceMessage => 'Sauti';

  @override
  String get chatMessage => 'Ujumbe';

  @override
  String get conversationHideChat => 'Ficha';

  @override
  String get settingsQuickReply => 'Jibu la Haraka';

  @override
  String get commonTranslate => 'Tafsiri';

  @override
  String get contactCreateTag => 'Unda Lebo';

  @override
  String get contactEnterTagName => 'Ingiza jina la lebo';

  @override
  String get contactEditTag => 'Hariri Lebo';

  @override
  String get contactDeleteTag => 'Futa Lebo';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'Je, una uhakika unataka kufuta lebo \"$tagName\"?';
  }

  @override
  String get contactNoTags => 'Bado hakuna lebo';

  @override
  String get contactFriendPermissions => 'Ruhusa za Marafiki';

  @override
  String get contactSetChatOnly => 'Weka kama Chat-pekee';

  @override
  String get contactChatOnlyDesc =>
      'Anaweza tu kuzungumza nawe, maudhui mengine yatafichwa';

  @override
  String get contactHideMyMoments => 'Ficha Dakika Zangu';

  @override
  String get contactHideMyMomentsDesc =>
      'Rafiki huyu hawezi kuona Nyakati zangu';

  @override
  String get contactHideTheirMoments => 'Ficha Nyakati zao';

  @override
  String get contactHideTheirMomentsDesc => 'Usione Nyakati za rafiki huyu';

  @override
  String get contactHideMyStatus => 'Ficha Hali Yangu';

  @override
  String get contactHideMyStatusDesc =>
      'Rafiki huyu hawezi kuona masasisho yangu ya hali';

  @override
  String get contactNoChatOnlyFriends => 'Hakuna marafiki wa gumzo pekee';

  @override
  String get contactNoOfficialAccounts => 'Hakuna akaunti rasmi';

  @override
  String get contactFollowOfficialAccountsDesc =>
      'Fuata akaunti rasmi ili kupata masasisho ya hivi punde';

  @override
  String get contactNoServiceAccounts => 'Hakuna akaunti za huduma';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      'Jiunge na akaunti za huduma kwa huduma zinazofaa';

  @override
  String get contactNoEnterpriseContacts => 'Hakuna mawasiliano ya biashara';

  @override
  String get contactEnterpriseContactsDesc =>
      'Anwani za biashara zitaonyeshwa hapa';

  @override
  String get profileCardPack => 'Kifurushi cha Kadi';

  @override
  String get profileOrders => 'Maagizo';

  @override
  String get profileNoOrders => 'Hakuna maagizo';

  @override
  String get profileOrdersDesc => 'Maagizo yako yataonyeshwa hapa';

  @override
  String get profileNoCards => 'Hakuna kadi';

  @override
  String get profileCardsDesc => 'Kadi zako zitaonyeshwa hapa';

  @override
  String get favoriteEnterTagsHint => 'Ingiza lebo zilizotenganishwa na koma';

  @override
  String get favoriteTagsUpdated => 'Lebo zimesasishwa';

  @override
  String get favoriteForwardedContent => 'Maudhui yamesambazwa';

  @override
  String get favoriteEnterNoteContent => 'Ingiza maudhui ya dokezo';

  @override
  String get favoriteNoteAdded => 'Dokezo limeongezwa';

  @override
  String get favoriteLinkTitle => 'Kichwa cha kiungo';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'Kiungo kimeongezwa';

  @override
  String get contactPhotoAdded => 'Picha imeongezwa';

  @override
  String get contactEnterPhone => 'Weka nambari ya simu';

  @override
  String commonConversationWithId(Object roomId) {
    return 'Mazungumzo: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return 'Mawasiliano: $userId';
  }

  @override
  String get commonDiscover => 'Gundua';

  @override
  String commonDeveloping(Object title) {
    return '$title\n(Inakuja hivi karibuni)';
  }

  @override
  String get commonPageNotFound => 'Ukurasa haujapatikana';

  @override
  String get commonBackToHome => 'Rudi Nyumbani';

  @override
  String get settingsMessageNotifications => 'Arifa za ujumbe';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Pokea arifa za ujumbe mpya';

  @override
  String get settingsShowMessagePreview => 'Onyesha onyesho la kukagua ujumbe';

  @override
  String get settingsShowMessageContentInNotification =>
      'Onyesha maudhui ya ujumbe katika arifa';

  @override
  String get settingsNotificationSound => 'Sauti ya Arifa';

  @override
  String get settingsPlaySoundOnMessage => 'Cheza sauti unapopokea ujumbe';

  @override
  String get commonVibration => 'Mtetemo';

  @override
  String get settingsVibrateOnMessage => 'Tetema unapopokea ujumbe';

  @override
  String get settingsDoNotDisturbMode => 'Usisumbue';

  @override
  String get settingsDoNotDisturbDescription =>
      'Usipokee arifa wakati uliowekwa';

  @override
  String get settingsStartTime => 'Wakati wa Kuanza';

  @override
  String get settingsEndTime => 'Wakati wa Mwisho';

  @override
  String get settingsDeleteQuickReply => 'Futa Jibu la Haraka';

  @override
  String get settingsEditQuickReply => 'Hariri Jibu la Haraka';

  @override
  String get settingsAddQuickReply => 'Ongeza Jibu la Haraka';

  @override
  String get settingsManageQuickReplies => 'Dhibiti Majibu ya Haraka';

  @override
  String get settingsNoQuickReplies => 'Hakuna majibu ya haraka';

  @override
  String get settingsDefaultQuickReplies =>
      'Majibu chaguomsingi ya haraka yataonyeshwa';

  @override
  String get settingsWhoCanSee => 'Nani anaweza kuona';

  @override
  String get settingsLastSeen => 'Mara ya Mwisho Kuonekana';

  @override
  String get settingsHiddenChats => 'Gumzo Siri';

  @override
  String get settingsMessagesLabel => 'Ujumbe';

  @override
  String get settingsAllowStrangerMessages => 'Ruhusu ujumbe usiowajua';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Pokea ujumbe kutoka kwa wasio waasiliani';

  @override
  String get settingsReadReceipts => 'Risiti za Kusoma';

  @override
  String get settingsLetOthersKnowYouRead => 'Wajulishe wengine kuwa unasoma';

  @override
  String get settingsTypingIndicator => 'Kiashiria cha kuandika';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'Wajulishe wengine kuwa unaandika';

  @override
  String get settingsEveryone => 'Kila mtu';

  @override
  String get settingsContactsOnly => 'Anwani Pekee';

  @override
  String get settingsNobody => 'Hakuna mtu';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Nani anaweza kuona $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Toleo la $version';
  }

  @override
  String get settingsCheckForUpdates => 'Angalia masasisho';

  @override
  String get settingsOpenSourceLicenses => 'Leseni za Chanzo Huria';

  @override
  String get settingsFeedbackAndSuggestions => 'Maoni na mapendekezo';

  @override
  String get settingsBuiltOnMatrix => 'Imejengwa kwa Itifaki ya Matrix';

  @override
  String get settingsNoHiddenChats => 'Hakuna gumzo zilizofichwa';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Gumzo unazoficha zitaonekana hapa';

  @override
  String get settingsUnhideChat => 'Onyesha';

  @override
  String get settingsDarkMode => 'Hali ya giza';

  @override
  String get settingsFontSize => 'Ukubwa wa herufi';

  @override
  String get settingsBubbleStyle => 'Mtindo wa Bubble';

  @override
  String get settingsFollowSystem => 'Fuata mfumo';

  @override
  String get settingsAutoSwitchBySystem => 'Badilisha kiotomatiki kwa mfumo';

  @override
  String get settingsLightMode => 'Hali ya mwanga';

  @override
  String get settingsAlwaysUseLightTheme => 'Tumia mandhari mepesi kila wakati';

  @override
  String get settingsDarkModeOption => 'Chaguo la hali ya giza';

  @override
  String get settingsAlwaysUseDarkTheme => 'Tumia mandhari meusi kila wakati';

  @override
  String get settingsFontSizeSmall => 'Ndogo';

  @override
  String get settingsFontSizeStandard => 'Kawaida';

  @override
  String get settingsFontSizeLarge => 'Kubwa';

  @override
  String get settingsFontSizeExtraLarge => 'Kubwa zaidi';

  @override
  String get settingsBubbleStyleWechat => 'Mtindo wa WeChat';

  @override
  String get settingsBubbleStyleWechatDesc =>
      'Mtindo wa Bubble wa WeChat wa kawaida';

  @override
  String get settingsBubbleStyleModern => 'Mtindo wa kisasa';

  @override
  String get settingsBubbleStyleModernDesc => 'Safi mtindo wa kisasa wa Bubble';

  @override
  String get settingsBubbleStyleClassic => 'Mtindo wa classic';

  @override
  String get settingsBubbleStyleClassicDesc => 'Mtindo wa Bubble wa jadi';

  @override
  String get discoverVideoChannels => 'Vituo';

  @override
  String get discoverLive => 'Ishi';

  @override
  String get discoverListen => 'Sikiliza';

  @override
  String get discoverWatch => 'Tazama';

  @override
  String get discoverSearchDiscover => 'Tafuta';

  @override
  String get discoverNearbyPeople => 'Karibu';

  @override
  String get discoverGames => 'Michezo';

  @override
  String get discoverMiniPrograms => 'Programu Ndogo';

  @override
  String get chatAlreadyInCall => 'Tayari katika simu';

  @override
  String get commonConnectionFailed => 'Muunganisho haukufaulu';

  @override
  String get chatCallRejected => 'Simu ilikataliwa';

  @override
  String get chatNoAnswer => 'Hakuna jibu';

  @override
  String get commonClose => 'Funga';

  @override
  String get chatSelectContact => 'Chagua Anwani';

  @override
  String get chatVoteRemoved => 'Kura imeondolewa';

  @override
  String get chatVoteChanged => 'Kura imebadilishwa';

  @override
  String get chatVoted => 'Imepiga kura';

  @override
  String chatReplyTo(String name) {
    return 'Jibu kwa $name';
  }

  @override
  String get chatCurrentLocation => 'Eneo la Sasa';

  @override
  String chatNearbyPlace(int index) {
    return 'Mahali pa Karibu $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Kuhusu $distance';
  }

  @override
  String get chatAddress => 'Anwani';

  @override
  String get chatLatitude => 'Latitudo';

  @override
  String get chatLongitude => 'Longitudo';

  @override
  String get groupDescriptionUpdated => 'Maelezo ya kikundi yamesasishwa';

  @override
  String get groupAvatarUpdated => 'Ishara ya kikundi imesasishwa';

  @override
  String get groupVisibilityUpdated => 'Mwonekano wa kikundi umesasishwa';

  @override
  String get groupChannelCreated => 'Kituo kimeundwa';

  @override
  String get groupChannelUpdated => 'Kituo kimesasishwa';

  @override
  String get groupChannelDeleted => 'Kituo kimefutwa';

  @override
  String get callDecline => 'Kataa';

  @override
  String get callAnswer => 'Jibu';

  @override
  String get callIncomingVideoCall => 'Simu ya video inayoingia';

  @override
  String get callIncomingVoiceCall => 'Simu ya sauti inayoingia';

  @override
  String get callVideoCallInProgress => 'Hangout ya Video inaendelea';

  @override
  String get callVoiceCallInProgress => 'Hangout ya sauti inaendelea';

  @override
  String get callReconnectingCall => 'Inaunganisha upya...';

  @override
  String get callEnded => 'Simu imekatika';

  @override
  String get callFailed => 'Simu haikufaulu';

  @override
  String get callLivekitNotConfigured => 'LiveKit haijasanidiwa';

  @override
  String callJoinMeetingFailed(Object error) {
    return 'Imeshindwa kujiunga na mkutano: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return 'Imeshindwa kushiriki skrini: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Maharage';

  @override
  String get profileNoN42Bean => 'Hakuna N42 Bean';

  @override
  String get profileN42BeanDetails => 'Maelezo ya Maharage ya N42';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean ni tokeni inayotumika kukomboa bidhaa na huduma pepe katika N42. Inapatikana kwa sasa kwa:';

  @override
  String get profileN42BeanFeature1 =>
      'Vibandiko na mandhari za wanachama wa kipekee';

  @override
  String get profileN42BeanFeature2 => 'Ubinafsishaji wa kiputo cha gumzo';

  @override
  String get profileN42BeanFeature3 =>
      'Ubinafsishaji wa kifuniko cha pakiti nyekundu';

  @override
  String get profileN42BeanFeature4 => 'Beji ya jina la utani la kipekee';

  @override
  String get profileN42BeanFeature5 => 'Mapendeleo ya gumzo la kikundi';

  @override
  String get profileN42BeanFeature6 => 'Upanuzi wa hifadhi ya wingu';

  @override
  String get profileN42BeanFeature7 =>
      'Vichujio vya urembo vya Hangout ya Video';

  @override
  String get profileN42BeanFeature8 =>
      'Urekebishaji wa mandharinyuma ya matukio';

  @override
  String get profileN42BeanFeature9 => 'VIP kipaumbele huduma kwa wateja';

  @override
  String get profileGotIt => 'Nimeipata';

  @override
  String get profileNoN42BeanRecords => 'Hakuna rekodi za N42 Bean';

  @override
  String get profileMoodAndThoughts => 'Mood & Mawazo';

  @override
  String get profileStatusHappy => 'Furaha';

  @override
  String get profileStatusCracked => 'Imevunjwa';

  @override
  String get profileStatusLucky => 'Bahati';

  @override
  String get profileStatusSunny => 'Jua';

  @override
  String get profileStatusTired => 'Uchovu';

  @override
  String get profileStatusDaydream => 'Ndoto ya mchana';

  @override
  String get profileStatusRushing => 'Kukimbilia';

  @override
  String get profileStatusOverthinking => 'Kufikiri kupita kiasi';

  @override
  String get profileStatusEnergized => 'Imetiwa nguvu';

  @override
  String get profileWorkAndStudy => 'Kazi & Jifunze';

  @override
  String get profileStatusWorking => 'Kufanya kazi';

  @override
  String get profileStatusStudying => 'Kusoma';

  @override
  String get profileStatusBusy => 'Shughuli';

  @override
  String get profileStatusSlacking => 'Kulegea';

  @override
  String get profileStatusTraveling => 'Kusafiri';

  @override
  String get profileStatusGoingHome => 'Kwenda Nyumbani';

  @override
  String get profileStatusDnd => 'Usinisumbue';

  @override
  String get profileActivities => 'Shughuli';

  @override
  String get profileStatusHanging => 'Kubarizi';

  @override
  String get profileStatusCheckIn => 'Ingia';

  @override
  String get profileStatusExercising => 'Kufanya mazoezi';

  @override
  String get profileStatusCoffee => 'Kahawa';

  @override
  String get profileStatusBubbleTea => 'Chai ya Bubble';

  @override
  String get profileStatusEating => 'Kula';

  @override
  String get profileStatusParenting => 'Uzazi';

  @override
  String get profileStatusSavingWorld => 'Kuokoa Ulimwengu';

  @override
  String get profileStatusSelfie => 'Selfie';

  @override
  String get profileRest => 'Pumzika';

  @override
  String get profileStatusRetreat => 'Rudi nyuma';

  @override
  String get profileStatusHome => 'Nyumbani';

  @override
  String get profileStatusSleeping => 'Kulala';

  @override
  String get profileStatusCatLover => 'Mpenzi wa Paka';

  @override
  String get profileStatusDogWalking => 'Kutembea Mbwa';

  @override
  String get profileStatusGaming => 'Michezo ya kubahatisha';

  @override
  String get profileStatusListening => 'Kusikiliza';

  @override
  String get profileEditAddress => 'Hariri Anwani';

  @override
  String get profileRecipient => 'Mpokeaji';

  @override
  String get profileEnterRecipientName => 'Weka jina la mpokeaji';

  @override
  String get profilePhoneNumber => 'Nambari ya Simu';

  @override
  String get profileEnterPhoneNumber => 'Weka nambari ya simu';

  @override
  String get profileRegionHint => 'Mkoa/Jiji/Wilaya';

  @override
  String get profileDetailedAddress => 'Anwani ya Kina';

  @override
  String get profileDetailedAddressHint => 'Mtaa, nambari ya jengo, nk.';

  @override
  String get profileSetAsDefaultAddress => 'Weka kama anwani chaguo-msingi';

  @override
  String get profilePleaseCompleteInfo => 'Tafadhali kamilisha sehemu zote';

  @override
  String get profileEditInvoice => 'Badilisha ankara';

  @override
  String get profileInvoiceType => 'Aina ya ankara';

  @override
  String get profileCompanyName => 'Jina la Kampuni';

  @override
  String get profilePersonalName => 'Jina la kibinafsi';

  @override
  String get profileEnterCompanyName => 'Ingiza jina la kampuni';

  @override
  String get profileEnterName => 'Ingiza jina';

  @override
  String get profileTaxIdNumber => 'Nambari ya Kitambulisho cha Ushuru';

  @override
  String get profileEnterTaxIdNumber =>
      'Weka nambari ya kitambulisho cha ushuru';

  @override
  String get profileBankNameOptional => 'Jina la Benki (Si lazima)';

  @override
  String get profileEnterBankName => 'Weka jina la benki';

  @override
  String get profileBankAccountOptional => 'Akaunti ya Benki (Si lazima)';

  @override
  String get profileEnterBankAccount => 'Ingiza akaunti ya benki';

  @override
  String get profileCompanyAddressOptional => 'Anwani ya Kampuni (Si lazima)';

  @override
  String get profileEnterCompanyAddress => 'Weka anwani ya kampuni';

  @override
  String get profileCompanyPhoneOptional => 'Simu ya Kampuni (Si lazima)';

  @override
  String get profileEnterCompanyPhone => 'Ingiza simu ya kampuni';

  @override
  String get profileSetAsDefaultInvoice => 'Weka kama ankara chaguomsingi';

  @override
  String get profileRingtoneVibrate => 'Tetema';

  @override
  String get profileRingtoneSilent => 'Kimya';

  @override
  String get profileVibrateMode => 'Hali ya mtetemo';

  @override
  String get profileSilentMode => 'Hali ya kimya';

  @override
  String profilePlayFailed(Object ringtoneName) {
    return 'Imeshindwa kucheza: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
    return 'Inacheza: $ringtoneName';
  }

  @override
  String get profileStop => 'Acha';

  @override
  String get profileSelectRingtone => 'Chagua Mlio wa Simu';

  @override
  String get profileLoadingRingtones => 'Inapakia milio ya simu...';

  @override
  String get profileNoRingtonesFound => 'Hakuna sauti za simu zilizopatikana';

  @override
  String mainMessagesWithCount(int count) {
    return 'Ujumbe($count)';
  }

  @override
  String get storyViewers => 'Watazamaji';

  @override
  String get storyNoViewers => 'Bado hakuna watazamaji';

  @override
  String get storyReplyToStory => 'Jibu hadithi...';

  @override
  String get commonCopiedToClipboard => 'Imenakiliwa kwenye ubao wa kunakili';

  @override
  String get commonMore => 'Zaidi';

  @override
  String get commonTranslating => 'Inatafsiri...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Imetafsiriwa kutoka $language';
  }

  @override
  String get commonTranslation => 'Tafsiri';

  @override
  String get commonTranslationFailed => 'Tafsiri imeshindwa';

  @override
  String get commonAllRead => 'Wote wamesoma';

  @override
  String commonReadCount(Object count) {
    return 'Imesomwa kwa $count';
  }

  @override
  String get commonYouRecalledMessage => 'Umekumbuka ujumbe';

  @override
  String get commonMessageRecalled => 'Ujumbe umekumbukwa';

  @override
  String get commonReEdit => 'Badilisha upya';

  @override
  String get commonWalletArea => 'Eneo la Wallet';

  @override
  String get callIncomingCall => 'Simu inayoingia';

  @override
  String get callMissedCall => 'Simu ambayo haikujibiwa';

  @override
  String get groupRemoveAdmin => 'Ondoa Admin';

  @override
  String get chatSelectCurrency => 'Chagua sarafu';

  @override
  String get chatSelectEmoji => 'Chagua Emoji';

  @override
  String get chatSelectRedPacketCover => 'Chagua Jalada';

  @override
  String get groupSetAsAdmin => 'Weka kama Msimamizi';

  @override
  String get chatVideoPlaybackFailed => 'Uchezaji wa video umeshindwa';

  @override
  String get groupViewProfile => 'Tazama Wasifu';

  @override
  String get favoriteAddLinkComingSoon =>
      'Ongeza kipengele cha kiungo kinakuja hivi karibuni';

  @override
  String get favoriteNewNoteComingSoon =>
      'Kipengele kipya cha dokezo kinakuja hivi karibuni';

  @override
  String get qrcodeSaveFeatureComingSoon =>
      'Hifadhi kipengele kinakuja hivi karibuni';

  @override
  String get qrcodeShareFeatureComingSoon =>
      'Shiriki kipengele kinakuja hivi karibuni';

  @override
  String qrcodeProcessFailed(String error) {
    return 'Imeshindwa kuchakata msimbo wa QR: $error';
  }

  @override
  String get securityDeviceIdRequired => 'Kitambulisho cha Kifaa kinahitajika';

  @override
  String securityVerificationStartFailed(String error) {
    return 'Imeshindwa kuanza uthibitishaji: $error';
  }

  @override
  String get securityVerificationFailed => 'Uthibitishaji haukufaulu';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return 'Uthibitishaji haukufaulu: $reason';
  }

  @override
  String get securityEmojiMismatchRejected =>
      'Uthibitishaji umekataliwa - emoji haikulingana';

  @override
  String get securityWaitingForDeviceAccept =>
      'Inasubiri kifaa kingine kikubali...';

  @override
  String get securityVerifyDevice => 'Thibitisha kifaa hiki';

  @override
  String get securityConfirmEmojiMatch =>
      'Thibitisha kuwa emoji hapa chini inaonyeshwa kwenye vifaa vyote viwili, kwa mpangilio sawa';

  @override
  String get securityEmojiDontMatch => 'Hazilingani';

  @override
  String get securityEmojiMatch => 'Wanalingana';

  @override
  String get securityWaitingForDeviceConfirm =>
      'Inasubiri kifaa kingine kuthibitisha...';

  @override
  String get securityVerificationSuccess => 'Uthibitishaji umefaulu!';

  @override
  String get securityDeviceVerifiedTrusted =>
      'Kifaa hiki sasa kimethibitishwa na kuaminiwa.';

  @override
  String get securityCompareEmoji =>
      'Linganisha emoji kwenye vifaa vyote viwili';

  @override
  String get securityCompareNumbers =>
      'Linganisha nambari kwenye vifaa vyote viwili';

  @override
  String get commonTryAgain => 'Jaribu Tena';

  @override
  String get commonDone => 'Imekamilika';

  @override
  String get chatExportTitle => 'Hamisha Gumzo';

  @override
  String get chatExportSuccess => 'Uhamishaji umefaulu';

  @override
  String chatExportFailed(String error) {
    return 'Uhamishaji haukufaulu: $error';
  }

  @override
  String get chatExportFormat => 'Hamisha Umbizo';

  @override
  String get chatExportHtmlDesc =>
      'Inaweza kusomeka katika kivinjari chochote kilicho na mpangilio maalum';

  @override
  String get chatExportJsonDesc =>
      'Umbizo la data iliyopangwa inayoweza kusomeka kwa mashine';

  @override
  String get chatExportDateRange => 'Masafa ya Tarehe';

  @override
  String get chatExportAll => 'Ujumbe Zote';

  @override
  String get chatExportLastWeek => 'Siku 7 zilizopita';

  @override
  String get chatExportLastMonth => 'Mwezi uliopita';

  @override
  String get chatExportLast3Months => 'Miezi 3 iliyopita';

  @override
  String get chatExportMessageCount => 'Ujumbe wa kusafirisha';

  @override
  String get chatExportButton => 'Hamisha na Shiriki';

  @override
  String get chatMediaGallery => 'Matunzio ya Vyombo vya Habari';

  @override
  String get chatExportHistory => 'Hamisha Historia ya Gumzo';

  @override
  String get pdfLoadFailed => 'Imeshindwa kupakia PDF';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => 'Wote';

  @override
  String get mediaImages => 'Picha';

  @override
  String get mediaVideos => 'Video';

  @override
  String get mediaFiles => 'Faili';

  @override
  String get mediaAudio => 'Sauti';

  @override
  String mediaItemsCount(int count) {
    return 'Vipengee vya $count';
  }

  @override
  String get mediaNoMediaFound => 'Hakuna media iliyopatikana';

  @override
  String get spacesTitle => 'Jumuiya';

  @override
  String get spacesCreate => 'Unda Jumuiya';

  @override
  String get spacesJoined => 'Imejiunga';

  @override
  String get spacesDiscover => 'Gundua';

  @override
  String get spacesNoJoined => 'Bado hakuna jumuiya zilizojiunga';

  @override
  String get spacesExplore => 'Gundua Jumuiya';

  @override
  String get spacesNoPublic => 'Hakuna jumuiya za umma zilizopatikana';

  @override
  String get spacesJoin => 'Jiunge';

  @override
  String get spacesSubSpaces => 'Jumuiya Ndogo';

  @override
  String get spacesChannels => 'Vituo';

  @override
  String spacesMembersCount(int count) {
    return 'Wanachama wa $count';
  }

  @override
  String get spacesPublic => 'Hadharani';

  @override
  String get spacesPrivate => 'Binafsi';

  @override
  String get spacesSuggested => 'Imependekezwa';

  @override
  String spacesChannelsCount(int count) {
    return 'Njia za $count';
  }

  @override
  String get callInCallChat => 'Gumzo la Ndani ya Simu';

  @override
  String callMessagesCount(int count) {
    return 'Ujumbe wa $count';
  }

  @override
  String get callNoMessagesYet =>
      'Bado hakuna ujumbe.\nTuma ujumbe ili kuanza.';

  @override
  String get callTypeMessage => 'Andika ujumbe...';

  @override
  String get callYouSender => 'Wewe';

  @override
  String get callChatLabel => 'Soga';

  @override
  String get chatEdited => 'Imehaririwa';

  @override
  String get chatEditHistory => 'Hariri Historia';

  @override
  String get chatOriginalMessage => 'Asili';

  @override
  String chatEditedAt(String time) {
    return 'Ilibadilishwa katika $time';
  }

  @override
  String get chatViewOnce => 'Tazama Mara Moja';

  @override
  String get chatViewOncePhoto => 'Tazama Picha Mara Moja';

  @override
  String get chatViewOnceVideo => 'Tazama Video Mara Moja';

  @override
  String get chatViewOnceViewed => 'Imetazamwa';

  @override
  String get chatViewOnceExpired => 'Muda wake umeisha';

  @override
  String get chatViewOnceTap => 'Gusa ili kutazama';

  @override
  String get chatAutoFaceBlur => 'Ukungu wa uso wa kiotomatiki';

  @override
  String get chatAutoFaceBlurDesc =>
      'Weka ukungu kwenye nyuso kiotomatiki unapotuma picha';

  @override
  String get threadReplyInThread => 'Jibu kwenye thread';

  @override
  String threadReplies(int count) {
    return '$count majibu';
  }

  @override
  String get threadReply => 'Jibu 1';

  @override
  String threadLatestReply(String preview) {
    return 'Hivi karibuni: $preview';
  }

  @override
  String get threadTitle => 'Uzi';

  @override
  String get threadReplyPlaceholder => 'Jibu kwenye thread...';

  @override
  String threadParticipants(int count) {
    return 'washiriki wa $count';
  }

  @override
  String get voiceRoomTitle => 'Chumba cha Sauti';

  @override
  String get voiceRoomCreate => 'Unda Chumba cha Sauti';

  @override
  String get voiceRoomJoin => 'Jiunge';

  @override
  String get voiceRoomLeave => 'Ondoka';

  @override
  String get voiceRoomEnd => 'Chumba cha Mwisho';

  @override
  String get voiceRoomRaiseHand => 'Inua Mkono';

  @override
  String get voiceRoomLowerHand => 'Mkono wa Chini';

  @override
  String get voiceRoomMute => 'Nyamazisha';

  @override
  String get voiceRoomUnmute => 'Rejesha sauti';

  @override
  String get voiceRoomHost => 'Mwenyeji';

  @override
  String get voiceRoomSpeakers => 'Wazungumzaji';

  @override
  String get voiceRoomListeners => 'Wasikilizaji';

  @override
  String get voiceRoomLive => 'MOJA KWA MOJA';

  @override
  String get voiceRoomEnded => 'Imeisha';

  @override
  String get voiceRoomScheduled => 'Imepangwa';

  @override
  String get voiceRoomApprove => 'Idhinisha';

  @override
  String get voiceRoomDemote => 'Nenda kwa Msikilizaji';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name waliinua mikono yao';
  }

  @override
  String get voiceRoomName => 'Jina la chumba';

  @override
  String get voiceRoomTopic => 'Mada (ya hiari)';

  @override
  String get voiceRoomNoActive => 'Hakuna vyumba vya sauti vinavyotumika';

  @override
  String get voiceRoomConnecting => 'Inaunganisha...';

  @override
  String get usernameTitle => 'Jina la mtumiaji';

  @override
  String get usernameSet => 'Weka Jina la mtumiaji';

  @override
  String get usernameChange => 'Badilisha Jina la mtumiaji';

  @override
  String get usernamePlaceholder => 'Ingiza jina la mtumiaji';

  @override
  String get usernameAvailable => 'Jina la mtumiaji linapatikana';

  @override
  String get usernameUnavailable => 'Jina la mtumiaji tayari limechukuliwa';

  @override
  String get usernameInvalid =>
      'Herufi 3-30, herufi ndogo, nambari, chini. Lazima kuanza na barua.';

  @override
  String get usernameReserved => 'Jina hili la mtumiaji limehifadhiwa';

  @override
  String get usernameSaved => 'Jina la mtumiaji limehifadhiwa';

  @override
  String get usernameSearchHint => 'Tafuta kwa @username';

  @override
  String get ensName => 'Jina la ENS';

  @override
  String get ensLinked => 'Imeunganishwa na ENS';

  @override
  String get ensResolving => 'Inatatua ENS...';

  @override
  String get ensNotFound => 'Jina la ENS halijapatikana';

  @override
  String get tokenGateTitle => 'Lango la Ishara';

  @override
  String get tokenGateEnable => 'Washa Lango la Tokeni';

  @override
  String get tokenGateDisable => 'Zima Lango la Tokeni';

  @override
  String get tokenGateAddRule => 'Ongeza Kanuni';

  @override
  String get tokenGateRemoveRule => 'Ondoa Kanuni';

  @override
  String get tokenGateContractAddress => 'Anwani ya Mkataba';

  @override
  String get tokenGateMinBalance => 'Usawa wa Chini';

  @override
  String get tokenGateTokenId => 'Kitambulisho cha Tokeni (ERC-1155)';

  @override
  String get tokenGateChainId => 'Kitambulisho cha mnyororo';

  @override
  String get tokenGateVerifying => 'Inathibitisha umiliki wa tokeni...';

  @override
  String get tokenGateVerified => 'Uthibitishaji umepitishwa';

  @override
  String get tokenGateDenied => 'Hufikii mahitaji ya ishara';

  @override
  String get tokenGateOperatorAnd => 'Lazima utimize sheria ZOTE';

  @override
  String get tokenGateOperatorOr => 'Lazima utimize sheria YOYOTE';

  @override
  String get tokenGateRuleErc20 => 'Ishara ya ERC-20';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => 'Tokeni nyingi (ERC-1155)';

  @override
  String get tokenGateRuleNative => 'Ishara ya asili';

  @override
  String get tokenGateSaved => 'Lango la ishara limehifadhiwa';

  @override
  String get tokenGateEnableDescription =>
      'Inahitaji wanachama kushikilia tokeni ili kujiunga';

  @override
  String get tokenGateOperator => 'Utawala Mantiki';

  @override
  String get tokenGateRules => 'Kanuni';

  @override
  String get tokenGateSymbol => 'Alama (si lazima)';

  @override
  String get tokenGateChain => 'Mnyororo';

  @override
  String get tokenGateTokenStandard => 'Kiwango cha Tokeni';

  @override
  String get tokenGateDenialMessage => 'Ujumbe wa Kukataa';

  @override
  String get tokenGateDenialMessageHint =>
      'Ujumbe unaonyeshwa wakati uthibitishaji unashindwa';

  @override
  String get tokenGateVerifyTitle => 'Uthibitishaji wa Ishara';

  @override
  String get tokenGateVerifyPassed => 'Uthibitishaji Umepitishwa';

  @override
  String get tokenGateVerifyFailed => 'Uthibitishaji Umeshindwa';

  @override
  String get tokenGateRetryVerify => 'Jaribu tena';

  @override
  String get tokenGateRequired => 'Inahitajika';

  @override
  String get tokenGateYourBalance => 'Mizani yako';

  @override
  String get tokenGateRulesActive => 'sheria kazi';

  @override
  String get tokenGateDisabled => 'Imezimwa';

  @override
  String get ensNotBound => 'Haijafungwa';

  @override
  String get liveLocation => 'Mahali pa Moja kwa Moja';

  @override
  String get stopLiveLocation => 'Acha Kushiriki';

  @override
  String get startLiveLocation => 'Anza Kushiriki';

  @override
  String get selectDuration => 'Chagua Muda';

  @override
  String get groupChatFiles => 'Faili za Gumzo';

  @override
  String get groupLinks => 'Viungo';

  @override
  String get groupNoLinks => 'Bado hakuna viungo';

  @override
  String get chatBackground => 'Mandharinyuma ya Gumzo';

  @override
  String get solidColors => 'Rangi Imara';

  @override
  String get gradients => 'Mipito ya rangi';

  @override
  String get defaultBackground => 'Chaguomsingi';

  @override
  String get settingsFontSizeSlider => 'Ukubwa wa herufi';

  @override
  String get autoDownload => 'Pakua Kiotomatiki';

  @override
  String get images => 'Picha';

  @override
  String get voice => 'Sauti';

  @override
  String get video => 'Video';

  @override
  String get files => 'Faili';

  @override
  String get mobileData => 'Data ya Simu';

  @override
  String get roaming => 'Kuzurura';

  @override
  String get storageManagement => 'Hifadhi';

  @override
  String get totalUsage => 'Jumla ya Matumizi';

  @override
  String get cache => 'Akiba';

  @override
  String get other => 'Nyingine';

  @override
  String get clearCache => 'Futa Cache';

  @override
  String get cacheCleared => 'Akiba imefutwa';

  @override
  String get clearCacheFailed => 'Imeshindwa kufuta akiba';

  @override
  String get confirmClearCache => 'Je, ungependa kufuta data yote ya akiba?';

  @override
  String get mapView => 'Mwonekano wa Ramani';

  @override
  String liveLocationSharingCount(int count) {
    return 'Watu wa $count wanashiriki eneo';
  }

  @override
  String get minutes15 => 'Dakika 15';

  @override
  String get minutes30 => 'Dakika 30';

  @override
  String get hour1 => 'Saa 1';

  @override
  String get hours8 => 'Saa 8';

  @override
  String get personalCard => 'Kadi ya kibinafsi';

  @override
  String get downloadFailed => 'Imeshindwa kupakua';

  @override
  String get locationExpired => 'Muda wake umeisha';

  @override
  String secondsRemaining(int count) {
    return 'Sekunde $count';
  }

  @override
  String minutesRemaining(int count) {
    return 'Dakika za $count';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '$hours masaa $minutes dakika';
  }

  @override
  String get favoriteMessages => 'Vipendwa';

  @override
  String get linksCopied => 'Kiungo kimenakiliwa';

  @override
  String get noLinksFound => 'Hakuna viungo vilivyopatikana';

  @override
  String get roomStorageRanking => 'Nafasi ya Hifadhi ya Chumba';

  @override
  String get downloadComplete => 'Upakuaji umekamilika';

  @override
  String get downloading => 'Inapakua...';

  @override
  String get draftSaved => 'Rasimu imehifadhiwa';

  @override
  String get voiceRecording => 'Kurekodi Sauti';

  @override
  String get searchLocation => 'Tafuta Mahali';

  @override
  String get tapToSearch => 'Gusa ili utafute';

  @override
  String get settingsThisDevice => 'Kifaa hiki';

  @override
  String get settingsJustNow => 'Sasa hivi';

  @override
  String get settingsDeviceId => 'Kitambulisho cha Kifaa';

  @override
  String get settingsStatus => 'Hali';

  @override
  String get settingsLastActive => 'Mara ya mwisho kutumika';

  @override
  String get settingsIpAddress => 'Anwani ya IP';

  @override
  String get settingsRenameDevice => 'Badilisha jina la kifaa';

  @override
  String get settingsDeviceNameHint => 'Weka jina la kifaa';

  @override
  String get settingsDeviceRenamed => 'Kifaa kimepewa jina jipya';

  @override
  String get settingsRenameFailed => 'Imeshindwa kubadilisha jina';

  @override
  String get settingsRemoteLogout => 'Kuondoka kwa mbali';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return 'Je, una uhakika unataka kuondoka kwenye \"$deviceName\"? Kitendo hiki hakiwezi kutenduliwa.';
  }

  @override
  String get settingsDeviceLoggedOut => 'Kifaa kimetoka';

  @override
  String get settingsLogoutFailed => 'Imeshindwa kuondoka';

  @override
  String get settingsLogout => 'Ondoka';

  @override
  String get settingsVerifyIdentity => 'Thibitisha utambulisho';

  @override
  String get settingsEnterPasswordToConfirm =>
      'Weka nenosiri lako ili kuthibitisha kitendo hiki.';

  @override
  String get scheduledSendTitle => 'Panga ujumbe';

  @override
  String get scheduledSendInOneHour => 'Katika saa 1';

  @override
  String get scheduledSendTonight => 'Leo usiku (8:00 PM)';

  @override
  String get scheduledSendTomorrowMorning => 'Kesho asubuhi (9:00 AM)';

  @override
  String get scheduledSendCustom => 'Chagua tarehe na saa';

  @override
  String get scheduledMessageLabel => 'Imepangwa';

  @override
  String get scheduledMessageCancel => 'Ghairi ujumbe ulioratibiwa';

  @override
  String get chatLockTitle => 'Kufunga gumzo';

  @override
  String get chatLockEnable => 'Funga gumzo hili';

  @override
  String get chatLockDisable => 'Fungua gumzo hili';

  @override
  String get chatLockDescription =>
      'Gumzo zilizofungwa zinahitaji uthibitishaji wa kibayometriki au PIN ili kufunguliwa';

  @override
  String get chatLockVerifyTitle => 'Soga imefungwa';

  @override
  String get chatLockVerifySubtitle => 'Thibitisha ili kufikia gumzo hili';

  @override
  String get chatLockVerifyFailed => 'Uthibitishaji haukufaulu';

  @override
  String get chatLockEnabled => 'Soga imefungwa';

  @override
  String get chatLockDisabled => 'Gumzo limefunguliwa';

  @override
  String get chatLockPinTitle => 'Weka PIN';

  @override
  String get chatLockPinSetTitle => 'Weka PIN';

  @override
  String get chatLockPinConfirmTitle => 'Thibitisha PIN';

  @override
  String get chatLockPinMismatch => 'PIN hailingani';

  @override
  String get chatLockUseBiometric => 'Tumia biometriska';

  @override
  String get chatLockUsePin => 'Tumia PIN';

  @override
  String get mediaEditorUndo => 'Tendua';

  @override
  String get mediaEditorRedo => 'Rudia';

  @override
  String get mediaEditorCrop => 'Mazao';

  @override
  String get mediaEditorFilter => 'Chuja';

  @override
  String get mediaEditorDraw => 'Chora';

  @override
  String get mediaEditorText => 'Maandishi';

  @override
  String get aiAssistant => 'Msaidizi wa AI';

  @override
  String get aiAssistantWelcome =>
      'Habari! Mimi ni Msaidizi wa AI wa N42. Nikusaidieje?';

  @override
  String get aiAssistantNotConfigured => 'Huduma ya AI haijasanidiwa';

  @override
  String get aiAssistantSettings => 'Mipangilio ya AI';

  @override
  String get aiAssistantClearHistory => 'Futa historia ya gumzo';

  @override
  String get aiAssistantClearHistoryConfirm =>
      'Je, una uhakika unataka kufuta historia yote ya gumzo ya AI?';

  @override
  String get aiAssistantStopGenerating => 'Acha kuzalisha';

  @override
  String get aiAssistantModel => 'Mfano';

  @override
  String get aiAssistantTemperature => 'Halijoto';

  @override
  String get aiAssistantMaxTokens => 'Tokeni za kiwango cha juu';

  @override
  String get aiAssistantContextWindow => 'Dirisha la muktadha';

  @override
  String get aiAssistantServiceStatus => 'Hali ya huduma';

  @override
  String get aiAssistantAvailable => 'Inapatikana';

  @override
  String get aiAssistantUnavailable => 'Haipatikani';

  @override
  String get aiSummarize => 'Muhtasari wa AI';

  @override
  String aiSummarizeUnread(int count) {
    return 'Fanya muhtasari wa ujumbe wa $count ambao haujasomwa';
  }

  @override
  String get aiSummarizeLoading => 'Inafupisha...';

  @override
  String get aiSummarizeError => 'Imeshindwa kufanya muhtasari';

  @override
  String get aiRewrite => 'AI Andika Upya';

  @override
  String get aiRewriteFormal => 'Rasmi';

  @override
  String get aiRewriteCasual => 'Kawaida';

  @override
  String get aiRewritePlayful => 'Ya kucheza';

  @override
  String get aiRewriteProfessional => 'Mtaalamu';

  @override
  String get aiRewriteAccept => 'Tumia';

  @override
  String get aiRewriteCancel => 'Ghairi';

  @override
  String get aiRewriteLoading => 'Inaandika upya...';

  @override
  String get aiLinkSummary => 'Muhtasari wa AI';

  @override
  String get aiLinkSummaryAnalyzing => 'Inachanganua...';

  @override
  String get chatFolderManagement => 'Dhibiti Folda';

  @override
  String get chatFolderSystem => 'Folda za Mfumo';

  @override
  String get chatFolderCustom => 'Folda Maalum';

  @override
  String get chatFolderEmpty => 'Bado hakuna folda maalum';

  @override
  String get chatFolderCreate => 'Unda Folda';

  @override
  String get chatFolderEdit => 'Badilisha Folda';

  @override
  String get chatFolderNameHint => 'Jina la folda';

  @override
  String get chatFolderAll => 'Wote';

  @override
  String get chatFolderUnread => 'Haijasomwa';

  @override
  String get chatFolderPersonal => 'Binafsi';

  @override
  String get chatFolderGroups => 'Vikundi';

  @override
  String get chatFolderChannels => 'Vituo';

  @override
  String get chatFolderMuted => 'Imenyamazishwa';

  @override
  String get storyAddMusic => 'Ongeza Muziki';

  @override
  String get storyChangeMusic => 'Badilisha Muziki';

  @override
  String get storyBackgroundMusic => 'Muziki wa Usuli';

  @override
  String get storyMusicPreview => 'Hakiki (isizidi sekunde 15)';

  @override
  String get storyChooseFromDevice => 'Chagua kutoka kwa Kifaa';

  @override
  String get storyUseThisMusic => 'Tumia Muziki Huu';

  @override
  String get authPasskeyNotSupported => 'Nenosiri halitumiki kwenye kifaa hiki';

  @override
  String get authPasskeyRegister => 'Usajili wa nenosiri';

  @override
  String get authPasskeyNoRegistered => 'Hakuna funguo za siri zilizosajiliwa';

  @override
  String get authPasskeyRegisterHint =>
      'Sajili nenosiri la akaunti hii. Kuingia kwa nenosiri la pekee kutawezeshwa baadaye.';

  @override
  String get authPasskeyNameYours => 'Taja Nenosiri lako';

  @override
  String get authPasskeyRegistered =>
      'Nenosiri limehifadhiwa kwenye akaunti hii';

  @override
  String get authPasskeyDeleted => 'Nenosiri limeondolewa kwenye akaunti hii';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return 'Ungependa kufuta nenosiri \"$name\"? Utahitaji kukisajili tena kabla ya kutumia nenosiri la kuingia baadaye.';
  }

  @override
  String get momentVisibilityPublic => 'Hadharani';

  @override
  String get momentVisibilityPrivate => 'Binafsi';

  @override
  String get momentVisibilityPartial => 'Marafiki Waliochaguliwa';

  @override
  String get momentVisibilityExcluded => 'Usijumuishe Baadhi ya Marafiki';

  @override
  String momentUserMoments(String userName) {
    return 'Nyakati za $userName';
  }

  @override
  String get momentForwardTo => 'Mbele kwa';

  @override
  String get momentForwardSuccess => 'Imesambazwa kwa mafanikio';

  @override
  String get momentSelectFriends => 'Chagua Marafiki';

  @override
  String get momentSelectTags => 'Chagua kwa Lebo';

  @override
  String momentSelectedCount(int count) {
    return 'Imechaguliwa ($count)';
  }

  @override
  String get momentNoMomentsYet => 'Bado hakuna muda mfupi';

  @override
  String get momentForwardMoment => 'Muda Mbele';

  @override
  String get momentAddComment => 'Ongeza maoni...';

  @override
  String momentForwardContent(String content) {
    return '[Moment] $content';
  }

  @override
  String get momentDeleteMoment => 'Futa Muda';

  @override
  String get momentDeleteConfirm =>
      'Je, una uhakika unataka kufuta wakati huu?';

  @override
  String get momentComment => 'Maoni';

  @override
  String get momentWriteComment => 'Andika maoni...';

  @override
  String get momentLike => 'Kama';

  @override
  String get momentUnlike => 'Tofauti';

  @override
  String get momentForward => 'Mbele';

  @override
  String get momentDelete => 'Futa';

  @override
  String get momentReply => 'jibu';

  @override
  String get momentMoment => 'Muda mfupi';

  @override
  String momentLikesCount(int count) {
    return '$count imependwa';
  }

  @override
  String momentCommentsCount(int count) {
    return 'Maoni ya $count';
  }

  @override
  String get momentNoComments => 'Hakuna maoni bado';

  @override
  String get momentFailedToLoad => 'Imeshindwa kupakia picha';

  @override
  String momentReplyTo(String userName) {
    return 'Jibu kwa $userName...';
  }

  @override
  String get momentNoConversations => 'Hakuna mazungumzo';

  @override
  String get momentJustNow => 'sasa hivi';

  @override
  String momentMinutesAgo(int count) {
    return '${count}m iliyopita';
  }

  @override
  String momentHoursAgo(int count) {
    return '${count}h iliyopita';
  }

  @override
  String momentDaysAgo(int count) {
    return '${count}d iliyopita';
  }

  @override
  String get chatGroupAnnouncementHint => 'Weka tangazo la kikundi';

  @override
  String get chatGroupAnnouncementEmpty => 'Hakuna tangazo';

  @override
  String get chatEditNickname => 'Hariri Jina la Utani';

  @override
  String get chatNicknameHint => 'Weka jina lako la utani kwenye kikundi hiki';

  @override
  String get contactAddPhoneHint => 'Weka nambari ya simu';

  @override
  String get contactNotesHint => 'Ongeza maelezo kuhusu mtu huyu';

  @override
  String get reportTitle => 'Ripoti';

  @override
  String get reportReasonSpam => 'Barua taka';

  @override
  String get reportReasonHarassment => 'Unyanyasaji';

  @override
  String get reportReasonFraud => 'Ulaghai';

  @override
  String get reportReasonOther => 'Nyingine';

  @override
  String get reportSubmitted => 'Ripoti imewasilishwa';

  @override
  String get reportDescription => 'Maelezo ya ziada (si lazima)';

  @override
  String get qrcodeSaved => 'Msimbo wa QR umehifadhiwa kwenye albamu';

  @override
  String get chatSendRedPacketInChat =>
      'Tafadhali tuma pakiti nyekundu kwenye gumzo';

  @override
  String get commonSaveFailed => 'Imeshindwa kuhifadhi';

  @override
  String get reportSelectReason => 'Tafadhali chagua sababu';

  @override
  String get reportUnavailable => 'Ingia ili kutuma ripoti.';

  @override
  String get reportAccountChanged =>
      'Akaunti imebadilika. Fungua ripoti hii tena ili kuituma.';

  @override
  String get reportUnsupported =>
      'Seva hii ya nyumbani haitumii ripoti kuhusu watumiaji.';

  @override
  String get reportRoomUnsupported =>
      'Seva hii ya nyumbani haitumii ripoti kuhusu vyumba.';

  @override
  String get reportRateLimited => 'Ripoti ni nyingi mno. Jaribu tena baadaye.';

  @override
  String get reportCouldNotSend => 'Imeshindwa kutuma ripoti. Jaribu tena.';

  @override
  String get gameCenter => 'Michezo';

  @override
  String get gameHighScore => 'Bora zaidi';

  @override
  String get gameScore => 'Alama';

  @override
  String get gameOver => 'Mchezo Umekwisha';

  @override
  String get gamePlayAgain => 'Cheza Tena';

  @override
  String get gameLeaderboard => 'Ubao wa wanaoongoza';

  @override
  String get gamePause => 'Imesitishwa';

  @override
  String get gameResume => 'Gusa ili uendelee';

  @override
  String get gameConfirmExit => 'Ungependa kuacha mchezo huu?';

  @override
  String get gameNoScores => 'Bado hakuna alama';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'Unganisha vigae kufikia 2048';

  @override
  String get gameBlockDrop => 'Kuacha kuzuia';

  @override
  String get gameBlockDropDesc => 'Tone na wazi mistari';

  @override
  String get gameMinesweeper => 'Mfagia madini';

  @override
  String get gameMinesweeperDesc => 'Pata seli zote salama';

  @override
  String get gameMatch3 => 'Mechi 3';

  @override
  String get gameMatch3Desc => 'Linganisha vito 3 au zaidi';

  @override
  String get gameMinesweeperEasy => 'Rahisi';

  @override
  String get gameMinesweeperMedium => 'Kati';

  @override
  String get gameMinesLeft => 'Migodi Imesalia';

  @override
  String get gameTimeLeft => 'Muda';

  @override
  String get gameLevel => 'Kiwango';

  @override
  String get gameNext => 'Inayofuata';

  @override
  String get gameBestTime => 'Wakati Bora';

  @override
  String get gameNewRecord => 'Rekodi Mpya!';

  @override
  String get gameLines => 'Mistari';

  @override
  String get storyMyStory => 'Hadithi Yangu';

  @override
  String get storageSmartCleanup => 'Usafishaji mahiri';

  @override
  String get storageOldMediaFiles => 'Faili za Midia ya Zamani';

  @override
  String get storageLargeFiles => 'Faili Kubwa';

  @override
  String get storageAppCache => 'Akiba ya Programu';

  @override
  String get storageSettings => 'Mipangilio ya Hifadhi';

  @override
  String get storageAutoCleanup => 'Kusafisha Kiotomatiki';

  @override
  String storageAutoCleanupDesc(int days) {
    return 'Safisha faili za zamani zaidi ya siku $days kiotomatiki';
  }

  @override
  String get storageCleanupPeriod => 'Kipindi cha Kusafisha';

  @override
  String get storagePreserveThumbnails => 'Hifadhi Vijipicha';

  @override
  String get storagePreserveThumbnailsDesc =>
      'Weka vijipicha vya picha wakati wa kusafisha';

  @override
  String get storageWarningHigh =>
      'Matumizi ya hifadhi ni ya juu. Fikiria kusafisha faili za zamani.';

  @override
  String get storageWarningCritical =>
      'Hifadhi iko chini sana. Tafadhali safisha ili upate nafasi.';

  @override
  String storageFreed(String size, int count) {
    return 'Imeachiliwa huru $size (faili $count)';
  }

  @override
  String storageDays(int days) {
    return 'Siku za $days';
  }

  @override
  String storageViewAllRooms(int count) {
    return 'Tazama vyumba vyote vya $count';
  }

  @override
  String get storageNoFiles => 'Hakuna faili zilizopatikana';

  @override
  String get storageFilePinned => 'Imebandikwa';

  @override
  String storageDeleteSelected(int count) {
    return 'Ungependa kufuta faili za $count zilizochaguliwa? Wanaweza kupakuliwa tena kutoka kwa seva.';
  }

  @override
  String get backupRestore => 'Hifadhi nakala na Rejesha';

  @override
  String get backupCreate => 'Unda Hifadhi Nakala';

  @override
  String get backupCreateDesc =>
      'Hifadhi nakala za mipangilio yako na vitufe vya usimbaji fiche. Ujumbe utarejeshwa kutoka kwa seva baada ya kuingia tena.';

  @override
  String get backupIncludeKeys => 'Jumuisha funguo za usimbaji fiche';

  @override
  String get backupIncludeKeysDesc =>
      'Inahitajika kwa kusoma ujumbe uliosimbwa kwa njia fiche';

  @override
  String get backupPasswordProtect => 'Ulinzi wa nenosiri';

  @override
  String get backupEnterPassword => 'Weka nenosiri mbadala';

  @override
  String get backupHistory => 'Hifadhi nakala ya Historia';

  @override
  String get backupNoBackups => 'Bado hakuna chelezo';

  @override
  String get backupRestore2 => 'Rejesha';

  @override
  String get backupDelete => 'Futa';

  @override
  String get backupDeleteConfirm =>
      'Je, una uhakika unataka kufuta nakala rudufu hii? Hili haliwezi kutenduliwa.';

  @override
  String get backupRestoreFromFile => 'Rejesha kutoka kwa Faili';

  @override
  String get backupRestoreFromFileDesc =>
      'Ingiza faili ya chelezo ya .n42 kutoka kwa kifaa kingine au nakala rudufu ya awali.';

  @override
  String get backupChooseFile => 'Chagua Faili ya Hifadhi Nakala';

  @override
  String get backupRestoring => 'Inarejesha...';

  @override
  String backupCreated(int rooms, int messages) {
    return 'Hifadhi rudufu imeundwa: Vyumba vya $rooms, ujumbe wa $messages';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return 'Mipangilio ya $settings iliyorejeshwa kutoka vyumba vya $rooms';
  }

  @override
  String backupFailed(String error) {
    return 'Imeshindwa kuhifadhi nakala: $error';
  }

  @override
  String get backupPasswordRequired =>
      'Hifadhi rudufu hii inalindwa na nenosiri';

  @override
  String get blocGroupNotFound => 'Kikundi hakijapatikana';

  @override
  String blocGroupMembersInvited(int count) {
    return 'Wanachama wa $count walioalikwa';
  }

  @override
  String get blocGroupMemberRemoved => 'Mwanachama ameondolewa';

  @override
  String get blocGroupAdminRemoved => 'Msimamizi ameondolewa';

  @override
  String get blocGroupLeft => 'Aliondoka kwenye kikundi';

  @override
  String get blocGroupDisbanded => 'Kikundi kimevunjwa';

  @override
  String get blocGroupJoined => 'Alijiunga na kikundi';

  @override
  String get blocGroupInviteDeclined => 'Mwaliko umekataliwa';

  @override
  String get blocGroupTokenGateUpdated => 'Lango la ishara limesasishwa';

  @override
  String get blocTransferProcessing => 'Inachakata uhamishaji...';

  @override
  String get blocTransferCancelled => 'Uhamisho umeghairiwa';

  @override
  String get blocTransferFailed => 'Imeshindwa kuhamisha';

  @override
  String get blocPaymentProcessing => 'Inachakata malipo...';

  @override
  String get blocPaymentFailed => 'Malipo yameshindwa';

  @override
  String get groupMaxMembers => 'Kikomo cha Wanachama';

  @override
  String get groupMaxMembersUnlimited => 'Bila kikomo';

  @override
  String get groupMaxMembersHint => 'Weka kikomo (wacha tupu kwa ukomo)';

  @override
  String get groupMaxMembersUpdated => 'Kikomo cha wanachama kimesasishwa';

  @override
  String get groupFull => 'Kikundi kiko kwenye uwezo';

  @override
  String get groupChannels => 'Mada ya Njia';

  @override
  String get groupChannelsEmpty => 'Bado hakuna chaneli';

  @override
  String get groupChannelsCount => 'njia';

  @override
  String get groupChannelCreate => 'Kituo Kipya';

  @override
  String get groupChannelName => 'Jina la Kituo';

  @override
  String get groupChannelTopic => 'Mada ya Kituo (si lazima)';

  @override
  String get groupChannelDelete => 'Futa Kituo';

  @override
  String get groupChannelDeleteConfirm =>
      'Ungependa kufuta kituo hiki? Barua pepe zote zitapotea.';

  @override
  String get groupBotSettings => 'Mipangilio ya Kijibu';

  @override
  String get groupBotEnabled => 'Washa Kijibu';

  @override
  String get groupBotWelcomeMessage => 'Kiolezo cha Ujumbe wa Karibu';

  @override
  String get groupBotWelcomeHint =>
      'Tumia \'jina\' kama kishika nafasi kwa jina jipya la mwanachama';

  @override
  String get groupBotConfigUpdated => 'Mipangilio ya kijibu imesasishwa';

  @override
  String get groupContentFilter => 'Kichujio cha Maudhui';

  @override
  String get groupContentFilterEnabled => 'Washa Kichujio cha Maneno Muhimu';

  @override
  String get groupContentFilterReplace => 'Badilisha na ***';

  @override
  String get groupContentFilterHide => 'Ficha Ujumbe';

  @override
  String get groupContentFilterAddWord => 'Ongeza Nenomsingi';

  @override
  String get groupContentFilterUpdated => 'Kichujio cha maudhui kimesasishwa';

  @override
  String get chatSlashCommands => 'Amri';

  @override
  String get chatCommandPoll => '/ kura - Tengeneza kura';

  @override
  String get chatCommandAnnounce => '/tangaza - Tuma tangazo';

  @override
  String get chatCommandWelcome => '/karibu - Weka ujumbe wa kukaribisha';

  @override
  String get chatReportMessage => 'Ripoti';

  @override
  String get chatReportReason => 'Ripoti Sababu';

  @override
  String get chatReportSpam => 'Barua taka';

  @override
  String get chatReportHarassment => 'Unyanyasaji';

  @override
  String get chatReportInappropriate => 'Maudhui Yasiyofaa';

  @override
  String get chatReportOther => 'Nyingine';

  @override
  String get chatReportSuccess => 'Ripoti imewasilishwa';

  @override
  String get spacesName => 'Jina la Jumuiya';

  @override
  String get spacesNameHint => 'k.m. Wafanyabiashara wa Crypto';

  @override
  String get spacesNameRequired => 'Jina linahitajika';

  @override
  String get spacesDescription => 'Maelezo';

  @override
  String get spacesDescriptionHint => 'Jumuiya hii inahusu nini?';

  @override
  String get spacesType => 'Aina ya Jumuiya';

  @override
  String get spacesPublicDesc => 'Mtu yeyote anaweza kugundua na kujiunga';

  @override
  String get spacesPrivateDesc =>
      'Wanachama walioalikwa pekee ndio wanaoweza kujiunga';

  @override
  String get spacesNotFound => 'Jumuiya haijapatikana';

  @override
  String get spacesSearch => 'Tafuta jumuiya...';

  @override
  String get spacesMembers => 'Wanachama';

  @override
  String get spacesNoChannels => 'Bado hakuna chaneli';

  @override
  String get spacesLeave => 'Ondoka kwenye Jumuiya';

  @override
  String spacesLeaveConfirm(String name) {
    return 'Je, una uhakika unataka kuondoka \"$name\"?';
  }

  @override
  String get spacesDelete => 'Futa Jumuiya';

  @override
  String spacesDeleteConfirm(String name) {
    return 'Hii itafuta kabisa \"$name\" na vituo vyake vyote. Kitendo hiki hakiwezi kutenduliwa.';
  }

  @override
  String get spacesCreateChannel => 'Ongeza Kituo';

  @override
  String get spacesChannelName => 'Jina la Kituo';

  @override
  String get spacesChannelTopic => 'Mada (ya hiari)';

  @override
  String get spacesDeleteChannel => 'Futa Kituo';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return 'Je, una uhakika unataka kufuta \"#$name\"?';
  }

  @override
  String get spacesEditName => 'Hariri Jina';

  @override
  String get spacesEditDescription => 'Hariri Maelezo';

  @override
  String spacesViewAllMembers(int count) {
    return 'Tazama wanachama wote wa $count';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return 'Piga $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return 'Piga marufuku $name';
  }

  @override
  String get spacesPromoteAdmin => 'Pandisha cheo hadi Msimamizi';

  @override
  String get spacesDemoteAdmin => 'Ondoa Admin';

  @override
  String get spacesInviteMember => 'Alika Mwanachama';

  @override
  String get spacesInviteMemberUserId =>
      'Kitambulisho cha Mtumiaji (k.m. @user:server.com)';

  @override
  String get spacesSave => 'Hifadhi';

  @override
  String get settingsScreenshotProtection => 'Ulinzi wa Picha ya skrini';

  @override
  String get settingsScreenshotProtectionDesc =>
      'Zuia picha za skrini na kurekodi skrini';

  @override
  String get chatSelfDestructTimer => 'Kujiharibu';

  @override
  String get chatTimerPickerTitle => 'Kipima Muda cha kujiharibu';

  @override
  String get chatTimerOff => 'Imezimwa';

  @override
  String get onChainNotificationsTitle => 'Matukio kwenye mnyororo';

  @override
  String get onChainMarkAllRead => 'Weka alama kuwa zote zimesomwa';

  @override
  String get onChainNoNotifications => 'Bado hakuna matukio ya mtandaoni';

  @override
  String get onChainNoNotificationsDesc =>
      'Matukio kutoka kwa vituo unavyofuatilia yataonekana hapa';

  @override
  String get onChainViewDetails => 'Tazama maelezo';

  @override
  String get chatCommandHelp => '/msaada — Onyesha amri zote';

  @override
  String get chatCommandPrice => '/bei - Pata bei ya ishara';

  @override
  String get chatCommandBalance => '/balance — Onyesha salio la pochi';

  @override
  String get chatCommandChains =>
      '/minyororo - Orodhesha minyororo 236+ inayotumika';

  @override
  String get chatMiniApps => 'Programu';

  @override
  String get miniAppMarketTitle => 'Programu Ndogo';

  @override
  String get miniAppCategoryAll => 'Wote';

  @override
  String get miniAppSearch => 'Tafuta programu...';

  @override
  String get miniAppFeatured => 'Iliyoangaziwa';

  @override
  String get miniAppAllApps => 'Programu Zote';

  @override
  String get miniAppNoResults => 'Hakuna programu zilizopatikana';

  @override
  String get slideToPayLabel => '→→→ Telezesha kidole ili kuthibitisha';

  @override
  String get slideToPayConfirming => 'Inathibitisha...';

  @override
  String get redPacketBestLuck => 'Bahati nzuri';

  @override
  String get redPacketBestLuckCongrats => 'Bahati nzuri! Umepata zaidi!';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total inadaiwa';
  }

  @override
  String get redPacketStatsTotal => 'jumla';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 alinyakua pakiti nyekundu • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id • 0x anwani ya pochi • name.eth';

  @override
  String get web3SearchPlaceholder =>
      'Tafuta kwa kitambulisho, pochi, au ENS...';

  @override
  String get web3WalletAddress => 'Anwani ya Wallet';

  @override
  String get web3AddressCopied => 'Anwani imenakiliwa';

  @override
  String get web3Copy => 'Nakili';

  @override
  String get web3SendMessage => 'Tuma Ujumbe';

  @override
  String get web3SendToWallet => 'Mkoba wa Ujumbe';

  @override
  String get web3WalletOnlyHint =>
      'Anwani hii bado haina akaunti ya N42. Ujumbe utawasilishwa watakapojiunga.';

  @override
  String get web3NftAvatar => 'Avatar ya NFT';

  @override
  String get web3ResolveFailed => 'Imeshindwa kutatua utambulisho';

  @override
  String web3EnsNotFound(String name) {
    return 'Jina la ENS \"$name\" halijapatikana';
  }

  @override
  String get web3NoN42AccountTitle => 'Hakuna Akaunti ya N42';

  @override
  String get web3NoN42AccountDesc =>
      'Anwani hii ya pochi bado haina akaunti ya N42. Unaweza kushiriki nao kiungo chako cha mwaliko wa N42 ili kuanza.';

  @override
  String get web3ShareInvite => 'Shiriki Mwaliko';

  @override
  String get nftPickerTitle => 'Chagua Avatar ya NFT';

  @override
  String get nftPickerTabPopular => 'Maarufu';

  @override
  String get nftPickerTabCustom => 'Desturi';

  @override
  String get nftPickerChain => 'Mnyororo';

  @override
  String get nftPickerContract => 'Anwani ya Mkataba';

  @override
  String get nftPickerTokenId => 'Kitambulisho cha ishara';

  @override
  String get nftPickerVerifyOwnership => 'Thibitisha Umiliki na Hakiki';

  @override
  String get nftPickerUseAsAvatar => 'Tumia kama Avatar';

  @override
  String get nftPickerPreview => 'Hakiki';

  @override
  String get nftPickerNotOwned => 'Humiliki NFT hii';

  @override
  String get nftPickerInvalidTokenId => 'Kitambulisho cha tokeni si sahihi';

  @override
  String get nftPickerEnterBoth =>
      'Weka anwani ya mkataba na kitambulisho cha tokeni';

  @override
  String get nftPickerInfoTitle =>
      'Avatar ya NFT - Imethibitishwa Kwenye Mnyororo';

  @override
  String get nftPickerInfoDesc =>
      'Unganisha NFT unayomiliki kama avatar yako. Mtu yeyote anaweza kuthibitisha umiliki kwenye mnyororo. Imeonyeshwa kwa pete ya dhahabu kote N42.';

  @override
  String get nftPickerPopularCollections => 'Mikusanyiko Maarufu';

  @override
  String get nftPickerWalletHint =>
      'Unganisha pochi yako ya N42 ili kugundua NFT zako kiotomatiki kwenye minyororo 236+.';

  @override
  String get profileBindNftAvatar => 'Funga Avatar ya NFT';

  @override
  String get profileChangeAvatar => 'Badilisha Avatar';

  @override
  String get groupTopics => 'Mada';

  @override
  String get groupTopicsEmpty => 'Bado hakuna mada';

  @override
  String get syncInProgress => 'Inasawazisha historia ya ujumbe...';

  @override
  String get recoveryKeyReminderTitle => 'Linda ujumbe wako';

  @override
  String get recoveryKeyReminderDesc =>
      'Unda ufunguo wa kurejesha akaunti ili kusawazisha ujumbe uliosimbwa kwa njia salama kwenye vifaa vyote';

  @override
  String get recoveryKeySetupNow => 'Sanidi sasa';

  @override
  String get recoveryKeyRemindLater => 'Nikumbushe baadaye';

  @override
  String get channelReadOnly =>
      'Wasimamizi pekee ndio wanaweza kuchapisha katika kituo hiki';

  @override
  String get channelSubscribers => 'waliojisajili';

  @override
  String get channelVerified => 'Kituo kilichothibitishwa';

  @override
  String get redPacketHistory => 'Historia ya Pakiti Nyekundu';

  @override
  String get redPacketSent => 'Imetumwa';

  @override
  String get redPacketReceived => 'Imepokelewa';

  @override
  String get redPacketExpired => 'Muda wake umeisha';

  @override
  String get redPacketClaimed => 'Imedaiwa';

  @override
  String get redPacketInsufficientBalance => 'Usawa usiotosha';

  @override
  String selfDestructCountdown(String time) {
    return 'Kujiharibu katika $time';
  }

  @override
  String get messageDestroyed => 'Ujumbe umeharibiwa';

  @override
  String miniAppPermissionDenied(String permission) {
    return 'Ruhusa imekataliwa: $permission';
  }

  @override
  String get aiSuggestionGasFee => 'Ada ya gesi ni nini?';

  @override
  String get aiSuggestionDefi => 'Mwongozo wa Mwanzo wa DeFi';

  @override
  String get aiSuggestionSecurity => 'Jinsi ya kuangalia usalama wa mkataba';

  @override
  String get aiSuggestionBridge => 'Madaraja ya mnyororo';

  @override
  String get channelDiscoverTitle => 'Gundua Vituo';

  @override
  String get channelDiscoverSearch => 'Tafuta vituo...';

  @override
  String get channelJoin => 'Jiunge';

  @override
  String get channelJoined => 'Imejiunga';

  @override
  String get channelCategory => 'Kategoria';

  @override
  String slowModeCooldown(int seconds) {
    return 'Hali ya polepole: subiri ${seconds}s';
  }

  @override
  String get addressCopyAction => 'Nakili Anwani';

  @override
  String get addressSendMessage => 'Tuma Ujumbe';

  @override
  String get addressViewProfile => 'Tazama Wasifu';

  @override
  String get sendToAddress => 'Tuma kwa anwani ya mkoba';

  @override
  String get blocAuthSendVerificationCodeFailed =>
      'Imeshindwa kutuma nambari ya kuthibitisha';

  @override
  String get blocAuthServerNoEmailPasswordReset =>
      'Seva hii haiauni kuweka upya nenosiri la barua pepe';

  @override
  String get blocAuthResetPasswordFailed => 'Imeshindwa kuweka upya nenosiri';

  @override
  String get blocAuthChangePasswordFailed => 'Imeshindwa kubadilisha nenosiri';

  @override
  String get blocAuthOldPasswordWrong => 'Nenosiri la sasa si sahihi';

  @override
  String get blocAuthLoginCancelled => 'Kuingia kumeghairiwa';

  @override
  String get blocAuthGoogleLoginFailed => 'Kuingia kwenye Google kumeshindwa';

  @override
  String get blocAuthAppleLoginFailed => 'Kuingia kwa Apple kumeshindwa';

  @override
  String get blocAuthSsoLoginFailed => 'Kuingia kwa SSO kumeshindwa';

  @override
  String get blocAuthFacebookLoginFailed =>
      'Kuingia kwenye Facebook kumeshindwa';

  @override
  String get blocAuthTwitterLoginFailed => 'Kuingia kwenye Twitter kumeshindwa';

  @override
  String get blocAuthWeChatLoginFailed => 'Kuingia kwenye WeChat kumeshindwa';

  @override
  String get blocAuthWeChatNotConfigured => 'Kuingia kwa WeChat hakujasanidiwa';

  @override
  String get blocAuthWeChatNotInstalled => 'Tafadhali sakinisha WeChat kwanza';

  @override
  String get blocAuthPasswordWrong => 'Nenosiri si sahihi';

  @override
  String get blocAuthEmailAlreadyBound =>
      'Barua pepe hii tayari imefungwa kwa akaunti nyingine';

  @override
  String get blocAuthChangeEmailFailed => 'Imeshindwa kubadilisha barua pepe';

  @override
  String get blocAuthVerificationCodeInvalid =>
      'Nambari ya uthibitishaji si sahihi au muda wake umeisha';

  @override
  String get blocAuthSessionExpired =>
      'Kipindi kimekwisha, tafadhali ingia tena';

  @override
  String get blocAuthSessionIncomplete =>
      'Data ya kipindi haijakamilika, tafadhali ingia tena';

  @override
  String get chatReadingMode => 'Hali ya kusoma';

  @override
  String get groupPoints => 'Pointi';

  @override
  String get settingsPrivacySecurity => 'Faragha na Usalama';

  @override
  String get settingsSystemAccounts => 'Mfumo na Akaunti';

  @override
  String get settingsNotificationPrivacy => 'Faragha ya Arifa';

  @override
  String get settingsSenderOnly => 'Onyesha mtumaji pekee';

  @override
  String get settingsHiddenNotification => 'Ficha mtumaji na ujumbe';

  @override
  String get settingsSmartFilter => 'Kichujio Mahiri';

  @override
  String get settingsEmailVerificationSent =>
      'Barua pepe ya uthibitishaji imetumwa';

  @override
  String get settingsEmailLinkInstructions =>
      'Fungua kiungo cha uthibitishaji katika barua pepe yako, kisha urudi hapa na uthibitishe.';

  @override
  String get settingsSendVerificationEmail =>
      'Tuma barua pepe ya uthibitishaji';

  @override
  String get chatLogoutKeyWarning =>
      'Hifadhi nakala ya funguo zako za usimbaji fiche kabla ya kutoka, la sivyo unaweza kupoteza ufikiaji wa ujumbe uliosimbwa.';

  @override
  String get settingsBiometricUnavailable =>
      'Uthibitishaji wa kibayometriki haupatikani. Angalia usajili na ruhusa katika mipangilio ya kifaa.';

  @override
  String get chatEncryptionNotReady =>
      'Muunganisho salama hauko tayari. Ujumbe haujatumwa. Angalia muunganisho na uthibitishaji wa vifaa kwenye akaunti zote mbili, kisha jaribu tena.';

  @override
  String get contactRequestPending => 'Inasubiri kukubaliwa';

  @override
  String get chatFriendRequestPending =>
      'Urafiki haujathibitishwa. Angalia Anwani > Marafiki Wapya kabla ya kutuma.';

  @override
  String contactPhotoCount(int count) {
    return 'Picha $count';
  }

  @override
  String get videoPublish => 'Chapisha video';

  @override
  String get videoGoLive => 'Anza matangazo ya moja kwa moja';

  @override
  String get videoSelect => 'Chagua video';

  @override
  String get videoLiveUnavailable => 'Matangazo ya moja kwa moja hayapatikani';

  @override
  String get qrcodeAlbum => 'Albamu';

  @override
  String get settingsSwitchAccount => 'Badili akaunti';

  @override
  String get chatFilterUnread => 'Haijasomwa';

  @override
  String get chatFilterEmpty => 'Hakuna mazungumzo katika kichujio hiki';

  @override
  String get accountAdd => 'Ongeza akaunti';

  @override
  String get accountCurrent => 'Akaunti ya sasa';

  @override
  String get accountSwitching => 'Inabadilisha akaunti…';

  @override
  String get accountSwitchFailed =>
      'Imeshindwa kubadilisha akaunti. Jaribu tena, au ongeza akaunti ili uingie tena.';

  @override
  String get accountSessionsHint =>
      'Badilisha akaunti hapa ili ujumbe na kipindi salama cha kila akaunti vibaki tofauti.';

  @override
  String get accountNoSaved => 'Hakuna akaunti zilizohifadhiwa bado';

  @override
  String get contactRequestSent => 'Ombi limetumwa';

  @override
  String get contactRequestsIncoming => 'Maombi yaliyopokelewa';

  @override
  String get contactRequestsOutgoing => 'Maombi yaliyotumwa';

  @override
  String get contactRequestHint =>
      'Unaweza kuzungumza na kupiga simu baada ya ombi kukubaliwa.';

  @override
  String get callReturnToCall => 'Rudi kwenye simu';

  @override
  String get chatMessageSending => 'Inatuma';

  @override
  String get chatMessageSent => 'Imetumwa';

  @override
  String get chatMessageDelivered => 'Imewasilishwa';

  @override
  String get chatMessageRead => 'Imesomwa';

  @override
  String get chatMessageFailed => 'Haijatumwa. Gusa ili kujaribu tena.';

  @override
  String get chatMessageUnavailable =>
      'Ujumbe haupatikani kwenye kifaa hiki. Gusa ili kuangalia chaguo za kurejesha.';

  @override
  String get contactStarredFriends => 'Marafiki wenye nyota';

  @override
  String get chatRecipientKeysMissing =>
      'Rafiki huyu hana kipindi kinachopatikana kilichosimbwa fiche. Mwombe aingie na kufungua programu, kisha jaribu tena. Tumia Badilisha Akaunti badala ya kutoka unapobadilisha akaunti.';

  @override
  String get chatSwitchForMessaging =>
      'Unabadilisha akaunti? Tumia Badilisha Akaunti ili kuhifadhi ujumbe na vipindi salama. Kutoka hubatilisha ufikiaji wa kifaa hiki na kunaweza kufanya ujumbe unaoingia uliosimbwa fiche usipatikane.';

  @override
  String get aiServiceUnavailable =>
      'Muhtasari wa AI haupatikani kwa sasa. Jaribu tena baada ya ufikiaji wa huduma kurejeshwa.';

  @override
  String aiSummarizeMessages(int count) {
    return 'Fupisha ujumbe $count wa karibuni';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return '$joined wamejiunga · $invited wamealikwa';
  }

  @override
  String contactPendingCount(int count) {
    return 'Maombi $count yanasubiri';
  }

  @override
  String get chatDraftLabel => 'Rasimu';

  @override
  String get contactIndexLabel => 'Faharasa ya anwani';

  @override
  String get transferAssetUnavailable => 'Mali ya malipo haipatikani';

  @override
  String get transferPaymentRequestUnavailable => 'Ombi la malipo halipatikani';

  @override
  String get chatCatchUp => 'Fuatilia yaliyopita';

  @override
  String get chatCatchUpMentions => 'Mitajo';

  @override
  String get chatCatchUpReplies => 'Majibu kwangu';

  @override
  String get chatCatchUpPinned => 'Ujumbe uliobandikwa';

  @override
  String get chatCatchUpScope =>
      'Mitajo na majibu hutafutwa katika ujumbe uliopakiwa, pamoja na uliosomwa. Pakia ujumbe wa zamani zaidi ili kupata majibu ya awali.';

  @override
  String get chatCatchUpLoadMore => 'Pakia ujumbe wa zamani';

  @override
  String get chatActionPreview => 'Kagua pendekezo la kalenda';

  @override
  String get chatActionPrivacy =>
      'Baada ya uthibitisho, kichwa na muda vilivyo hapa chini pekee vitashirikiwa na programu yako ya kalenda. Angalia ukanda wa saa. Akaunti yako ya kalenda inaweza kusawazisha tukio hili.';

  @override
  String get chatActionTitle => 'Tukio la gumzo';

  @override
  String get chatActionSuggestion => 'Pendekezo la kalenda';

  @override
  String get chatUnreadAttention => 'Mitajo na majibu ambayo hayajasomwa';

  @override
  String get chatScanAgain => 'Changanua tena';

  @override
  String get chatUnreadScope =>
      'Huchanganua historia ya seva hadi alama yako ya kusoma. Fungua mazungumzo ili uyasome; onyesha upya ili kutengeneza matokeo tena.';

  @override
  String get chatScanIncomplete =>
      'Haijakamilika: historia, kufungua usimbaji fiche au alama ya kusoma haipatikani. Jaribu tena baada ya usawazishaji.';

  @override
  String get chatHistoryShare => 'Shiriki historia iliyochaguliwa';

  @override
  String get chatHistoryExplanation =>
      'Kwa wasimamizi pekee. Chagua maandishi ya kawaida na gumzo la moja kwa moja lililosimbwa fiche ambalo tayari lipo na mshiriki aliyejiunga na kikundi. Kushiriki huunda ujumbe wa ukaguzi unaoonekana kwenye kikundi.';

  @override
  String get chatHistoryEnable => 'Washa kushiriki';

  @override
  String get chatHistoryDisable => 'Zima kushiriki';

  @override
  String get chatHistoryPolicy => 'Sera ya kushiriki historia ya kikundi';

  @override
  String get chatHistoryPolicyDetail =>
      'Wasimamizi pekee ndio wanaweza kushiriki. Kuwasha pia huzuia kuonekana kwa historia ya kikundi kwa matukio baada ya kujiunga pekee. Weka mipaka ya ujumbe wa maandishi hapa chini na uthibitishe.';

  @override
  String get chatHistoryPolicySaved => 'Sera imehifadhiwa';

  @override
  String get chatHistoryRecipient =>
      'Mazungumzo yaliyosimbwa fiche na mpokeaji';

  @override
  String get chatHistoryReview => 'Kagua ujumbe uliochaguliwa';

  @override
  String get chatHistoryMessages => 'ujumbe';

  @override
  String get chatHistoryConfirmDetail =>
      'Thibitisha mpokeaji huyu, kila ujumbe na muda wake kabla ya kushiriki. Matokeo yaliyoshindwa au yasiyojulikana yanaweza kuwa tayari yametuma maudhui: hakiki matokeo kabla ya kuendelea.';

  @override
  String get chatHistoryCompleted =>
      'Historia iliyochaguliwa imetumwa na ukaguzi wa kikundi umethibitishwa';

  @override
  String get chatHistoryPending =>
      'Inasubiri: hakiki matokeo, kisha thibitisha tena ili kuendelea. Utumaji wenye matokeo yasiyojulikana haurudiwi kamwe.';

  @override
  String get chatHistoryReconcile => 'Hakiki matokeo ya utumaji';

  @override
  String get chatHistoryFailed =>
      'Imeshindwa kukamilisha. Angalia ruhusa za msimamizi, sera ya kikundi, usimbaji fiche, uanachama wa mpokeaji na chaguo la ujumbe. Ikiwa utumaji umeanza, hakiki matokeo yake.';

  @override
  String get chatDeviceActions => 'Vitendo kwenye kifaa';

  @override
  String get chatDeviceActionsReview =>
      'Baada ya uthibitisho, ujumbe huu pekee hutolewa kwa mapendekezo ya vitendo ya mfumo yanayochakatwa kwenye kifaa. Chagua kitendo cha kufungua Kalenda, Vikumbusho au Ramani.';

  @override
  String get chatHistoryMaxMessages => 'Kikomo cha ujumbe (1–50)';

  @override
  String get chatHistoryMaxHours => 'Kipindi cha historia kwa saa (1–720)';

  @override
  String get chatNotifyAll => 'Ujumbe wote';

  @override
  String get chatNotifyAllDescription =>
      'Arifu kuhusu kila ujumbe mpya katika gumzo hili';

  @override
  String get chatNotifyMentions => 'Kutajwa tu';

  @override
  String get chatNotifyMentionsDescription =>
      'Arifu tu unapotajwa au @room inapotumiwa';

  @override
  String get chatNotifyMutedDescription =>
      'Zima arifa za gumzo hili kwenye vifaa vyote';

  @override
  String get scheduledMessagesTitle => 'Ujumbe ulioratibiwa';

  @override
  String get scheduledMessagesEmpty => 'Bado hakuna ujumbe ulioratibiwa';

  @override
  String get scheduledMessagesHint =>
      'Bonyeza kwa muda Tuma, Picha, Faili, GIF au kibandiko ili kuratibu ujumbe.';

  @override
  String get scheduledMessageCancelled => 'Ujumbe ulioratibiwa umeghairiwa';

  @override
  String scheduledMessageCreatedAt(String time) {
    return 'Uliundwa $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => 'Uwasilishaji haujathibitishwa';

  @override
  String get scheduledRecoveryCopy => 'Hifadhi nakala ya urejeshaji';

  @override
  String get scheduledRecoveryCopyHint =>
      'Imehifadhiwa kwenye kifaa hiki bila kubadilisha au kutuma ujumbe. Onyesho la kukagua lina hadi herufi 8,000.';

  @override
  String get scheduledRecoveryCopies => 'Nakala za urejeshaji';

  @override
  String get scheduledRecoveryReset => 'Weka upya foleni iliyoharibika';

  @override
  String get scheduledRecoveryResetHint =>
      'Nakala kamili imehifadhiwa kwenye kifaa hiki. Ungependa kuweka upya ujumbe wote ulioratibiwa wa akaunti hii? Baadhi huenda tayari umetumwa. Nakala na viambatisho vitahifadhiwa. Hakuna ujumbe utakaotumwa tena.';

  @override
  String get scheduledRecoveryExportHint =>
      'Faili hili lina maandishi ya rasimu na maelezo ya akaunti ambayo hayajasimbwa kwa njia fiche. Viambatisho havijajumuishwa. Chagua mahali unapoamini.';

  @override
  String get scheduledRecoveryImport => 'Ingiza nakala ya urejeshaji';

  @override
  String get scheduledRecoveryImportHint =>
      'Hifadhi onyesho hili kama nakala ya urejeshaji pekee. Hakuna ujumbe utakaoratibiwa au kutumwa. Viambatisho havijajumuishwa. Mwandishi wa faili hajathibitishwa.';

  @override
  String get scheduledRecoveryComposerHint =>
      'Ongeza maandishi kwenye rasimu ya sasa ili uyakague. Hakuna kitakachotumwa. Viambatisho, mitajo na vipima muda havitarejeshwa. Angalia kama ujumbe huu tayari umewasilishwa.';

  @override
  String get backupRecoverLegacyArchive =>
      'Rejesha historia ya zamani ya kifaa';

  @override
  String get backupLegacyArchiveWarning =>
      'Mmiliki wa historia hii hajathibitishwa. Nakili vyumba vyako tu kwenye akaunti iliyo hapa chini. Historia asili itahifadhiwa.';

  @override
  String get backupOlderFiles => 'Faili za zamani za nakala rudufu';

  @override
  String get backupOlderFilesWarning =>
      'Faili hizi huenda ni za akaunti nyingine. Chagua faili ili ukague maudhui na mmiliki kabla ya kurejesha.';

  @override
  String get stickerImportTitle => 'Leta kifurushi cha vibandiko';

  @override
  String get stickerImportLinkHint =>
      'Kiungo cha kifurushi cha vibandiko cha Matrix';

  @override
  String get stickerImportPreview => 'Hakiki';

  @override
  String get stickerImportUnavailable =>
      'Kifurushi hiki hakipatikani au huna ruhusa ya kukifikia.';

  @override
  String get stickerImportCopyNotice =>
      'Ongeza nakala ya faragha ya kifurushi hiki. Picha na metadata zake hazijasimbwa kwa njia fiche kutoka mwanzo hadi mwisho.';

  @override
  String get stickerImportFailed =>
      'Haikuwezekana kuongeza kifurushi hiki. Jaribu tena.';

  @override
  String get stickerImportAccountChanged =>
      'Akaunti imebadilika au kipindi kimeisha. Fungua tena uletaji wa vibandiko.';

  @override
  String get stickerPackSourceRoom => 'Gumzo la chanzo';

  @override
  String get stickerPackImages => 'Picha';

  @override
  String get stickerPublishNotice =>
      'Chapisha kifurushi hiki katika kikundi kilichochaguliwa. Picha na metadata zake hazijasimbwa kutoka mwanzo hadi mwisho. Watu wanaoweza kusoma hali ya kikundi wanaweza kuzifikia.';

  @override
  String get stickerPublishFailed =>
      'Uchapishaji haujathibitishwa. Angalia kikundi kabla ya kujaribu tena.';

  @override
  String get stickerPublishReceiptMissing =>
      'Imechapishwa, lakini kiungo hakijahifadhiwa. Kishiriki au ukinakili kabla ya kuondoka kwenye ukurasa huu.';

  @override
  String get stickerSubscribe => 'Jiandikishe kwa masasisho';

  @override
  String get stickerSubscribeNotice =>
      'Pokea mabadiliko yajayo kutoka kwa wasimamizi wa kifurushi hiki. Picha na metadata hazijasimbwa kutoka mwisho hadi mwisho. Unaweza kujiondoa baadaye; hatua hii haikuungi kwenye gumzo la chanzo.';

  @override
  String get stickerSubscriptions => 'Usajili wa vibandiko';

  @override
  String get stickerUnsubscribe => 'Jiondoe';

  @override
  String get stickerSubscriptionsEmpty => 'Hakuna usajili wa vibandiko';

  @override
  String get chatAttachmentEvent => 'Tukio';

  @override
  String get chatRecentMedia => 'Picha na video za hivi karibuni';

  @override
  String get chatRecentMediaLoadFailed =>
      'Imeshindikana kupakia midia ya hivi karibuni';

  @override
  String get chatRecentMediaPermission =>
      'Ruhusa ya kufikia picha inahitajika ili kuonyesha midia ya hivi karibuni';

  @override
  String get chatRecentMediaEmpty => 'Hakuna picha au video za hivi karibuni';

  @override
  String get chatRecentPhoto => 'Picha ya hivi karibuni';

  @override
  String get chatRecentVideo => 'Video ya hivi karibuni';

  @override
  String get chatAttachmentTip => 'Bakshishi';

  @override
  String get chatAttachmentWhiteboard => 'Ubao mweupe';

  @override
  String get chatAttachmentVideoNote => 'Ujumbe wa video';

  @override
  String get chatAttachmentCode => 'Msimbo';

  @override
  String get chatAttachmentShop => 'Duka';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Kikomo cha uteuzi: $countString';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return 'Leo usiku ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return 'Kesho asubuhi ($time)';
  }

  @override
  String get a11yScrollToBottom => 'Sogeza hadi chini';

  @override
  String get ui3EnterMessageBeforeScheduling =>
      'Andika ujumbe kabla ya kuratibu';

  @override
  String get ui3SendCode => 'Tuma msimbo';

  @override
  String get ui3CodeLanguage => 'Lugha';

  @override
  String get ui3PasteCodeHere => 'Bandika msimbo hapa';

  @override
  String ui3ReminderSetAt(String time) {
    return 'Kikumbusho kimewekwa · $time';
  }

  @override
  String get ui3RedPacketCreateFailed => 'Imeshindwa kuunda bahasha nyekundu';

  @override
  String get ui3SendTip => 'Tuma bakshishi';

  @override
  String get ui3TokenLabel => 'Tokeni';

  @override
  String get ui3NoteOptional => 'Dokezo (si lazima)';

  @override
  String ui3TipFailed(String error) {
    return 'Bakshishi imeshindwa: $error';
  }

  @override
  String get ui3GiftNftTitle => 'Toa NFT kama zawadi';

  @override
  String get ui3TokenId => 'Kitambulisho cha tokeni';

  @override
  String ui3NftGiftFailed(String error) {
    return 'Zawadi ya NFT imeshindwa: $error';
  }

  @override
  String get ui3AiAgentSubtitle => 'Eleza kazi, fungua programu ndogo inayofaa';

  @override
  String get ui3GiftNft => 'Zawadi ya NFT';

  @override
  String get ui3GiftNftSubtitle => 'Tuma NFT kwa mwasiliani huyu';

  @override
  String get ui3MiniAppUnavailable => 'Programu ndogo haipatikani';

  @override
  String ui3MediaItemsNotSent(int count) {
    return 'Midia $count uliyochagua haikuweza kutumwa';
  }

  @override
  String get ui3PhotosSubtitle =>
      'Tuma picha na video katika muundo unaofaa gumzo';

  @override
  String get ui3OriginalImages => 'Picha asili';

  @override
  String get ui3OriginalImagesSubtitle => 'Tuma picha zisizobanwa kama faili';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return '$filename imeratibiwa $time';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return 'Inatuma picha asili: $filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return 'Picha asili imeratibiwa: $filename';
  }

  @override
  String get ui3PaymentAlreadySent => 'Malipo tayari yametumwa';

  @override
  String get ui3PaymentProcessing => 'Malipo yanashughulikiwa';

  @override
  String ui3ChainStatus(String status) {
    return 'Hali kwenye mnyororo: $status';
  }

  @override
  String get ui3NotChecked => 'Haijakaguliwa';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return 'Imethibitishwa: vitalu $confirmations / $required';
  }

  @override
  String get ui3CopyTxHash => 'Nakili hash ya muamala';

  @override
  String get ui3VerifyAgain => 'Thibitisha tena';

  @override
  String get ui3VerifyOnChain => 'Thibitisha kwenye mnyororo';

  @override
  String get ui3TransferMissingChainDetails =>
      'Uhamisho huu haujumuishi maelezo kamili ya mnyororo na rasilimali.';

  @override
  String get ui3ReceiptPending => 'Inasubiri kwenye mnyororo';

  @override
  String get ui3ReceiptConfirmed => 'Imethibitishwa';

  @override
  String get ui3ReceiptFailed => 'Imeshindwa kwenye mnyororo';

  @override
  String get ui3ReceiptMismatch => 'Maelezo ya muamala hayalingani';

  @override
  String get ui3ReceiptUnsupported => 'Uthibitishaji wa mnyororo hautumiki';

  @override
  String get ui3ReceiptUnavailable => 'Uthibitishaji haupatikani';

  @override
  String get ui3OpenOrSave => 'Fungua / Hifadhi';

  @override
  String get ui3UnableToOpenFile => 'Imeshindwa kufungua faili hii.';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'Kuandika upya kwa AI kumeshindwa: $error';
  }

  @override
  String get ui3AiShareMessagesTitle => 'Shiriki ujumbe na AI?';

  @override
  String get ui3AiShareMessagesBody =>
      'Chagua ujumbe ambao AI inaweza kutumia kwa jibu hili. Idhini hii ya ombi moja itaisha baada ya dakika mbili. Kufunga Jibu la Haraka kunaghairi matokeo yanayosubiri. Haiidhinishi malipo wala uhamishaji.';

  @override
  String get ui3OtherParticipant => 'Mwingine';

  @override
  String get ui3ShareSelected => 'Shiriki zilizochaguliwa';

  @override
  String get ui3BotCommandError => 'Hitilafu ya amri';

  @override
  String get ui3BotUnknownCommand => 'Amri isiyojulikana';

  @override
  String get ui3BotTypeHelp => 'Andika /help kuona amri zinazopatikana.';

  @override
  String get ui3FilesMediaLinks => 'Faili, Midia na Viungo';

  @override
  String get ui3ChatStorage => 'Hifadhi ya gumzo';

  @override
  String get ui3EncryptionKeysDevices => 'Funguo za usimbaji fiche na vifaa';

  @override
  String get ui3EncryptionServiceUnavailable =>
      'Huduma ya usimbaji fiche bado haipatikani';

  @override
  String get ui3ExportLoadingHistory =>
      'Inapakia historia zaidi ya gumzo kwa ajili ya kuhamisha...';

  @override
  String get ui3ExportTxtDesc =>
      'Nakala ya maandishi matupu kwa madokezo, nakala rudufu au ukaguzi wa utiifu';

  @override
  String get ui3ExportCustomRange => 'Kipindi maalum';

  @override
  String get ui3ExportStart => 'Mwanzo';

  @override
  String get ui3ExportEnd => 'Mwisho';

  @override
  String get ui3ExportSelectDate => 'Chagua tarehe';

  @override
  String get ui3FolderFilterUnreadOnly => 'Ambazo hazijasomwa pekee';

  @override
  String get ui3FolderFilterMutedOnly => 'Zilizonyamazishwa pekee';

  @override
  String get ui3FolderFilterNoDms => 'Bila ujumbe wa moja kwa moja';

  @override
  String get ui3FolderFilterNoGroups => 'Bila vikundi';

  @override
  String get ui3FolderFilterNoChannels => 'Bila chaneli';

  @override
  String get ui3FolderFilterAllChats => 'Gumzo zote';

  @override
  String get ui3Create => 'Unda';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return 'Futa folda \"$name\"?';
  }

  @override
  String get a11yDecreaseTextSize => 'Punguza ukubwa wa maandishi';

  @override
  String get a11yIncreaseTextSize => 'Ongeza ukubwa wa maandishi';

  @override
  String ui3MinutesRead(int minutes) {
    return 'Dakika $minutes za kusoma';
  }

  @override
  String get ui3TipOnChain => 'Kwenye mnyororo ✓';

  @override
  String get ui3ViewSource => 'Tazama chanzo';

  @override
  String get a11yPreviousPage => 'Ukurasa uliotangulia';

  @override
  String get a11yNextPage => 'Ukurasa unaofuata';

  @override
  String get ui3OpenExternalLinkTitle => 'Fungua kiungo cha nje?';

  @override
  String get ui3Open => 'Fungua';

  @override
  String get ui3UnableToOpenLink => 'Imeshindwa kufungua kiungo hiki.';

  @override
  String get ui3ImageUnavailable => 'Picha haipatikani';

  @override
  String ui3LoadImageFrom(Object host) {
    return 'Pakia picha kutoka $host';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return 'Jaribu tena picha kutoka $host';
  }

  @override
  String get ui3TranslatedByN42 => 'Imetafsiriwa na N42';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return 'Imetafsiriwa kutoka $language na N42';
  }

  @override
  String get ui3ClearWhiteboardTitle => 'Futa ubao mweupe?';

  @override
  String get ui3ClearWhiteboardMessage =>
      'Mistari yote itaondolewa kwa kila mtu. Hatua hii haiwezi kutenduliwa.';

  @override
  String get ui3WhiteboardLive => 'Ubao mweupe · Moja kwa moja';

  @override
  String get a11yPenColor => 'Rangi ya kalamu';

  @override
  String get ui3AiDescribeOcr => 'Maelezo ya AI / OCR';

  @override
  String get ui3DocumentPreviewFailed =>
      'Imeshindwa kuhakiki hati hii kwa usalama. Angalia muunganisho na ukubwa wa faili (kiwango cha juu 2MB).';

  @override
  String get ui3AiConsentMessage =>
      'Chagua ujumbe ambao AI inaweza kutumia kwa muhtasari huu. Idhini hii ya ombi moja itaisha baada ya dakika mbili. Haiidhinishi malipo wala uhamishaji.';

  @override
  String get ui3AiSuggestedReplies => 'Majibu yanayopendekezwa';

  @override
  String get ui3AiGeneratingSuggestions => 'Inatengeneza mapendekezo...';

  @override
  String get ui3StickersEmpty => 'Bado hakuna vibandiko';

  @override
  String get ui3StickersGet => 'Pata vibandiko';

  @override
  String get a11yFormatBold => 'Herufi nzito';

  @override
  String get a11yFormatItalic => 'Italiki';

  @override
  String get a11yFormatStrikethrough => 'Mstari katikati';

  @override
  String get a11yFormatInlineCode => 'Msimbo wa ndani ya mstari';

  @override
  String get a11yFormatCodeBlock => 'Kizuizi cha msimbo';

  @override
  String get a11yFormatChecklistItem => 'Kipengee cha orodha hakiki';

  @override
  String get a11yFormatBulletList => 'Orodha ya vitone';

  @override
  String get a11yFormatNumberedList => 'Orodha ya namba';

  @override
  String get a11yFormatLink => 'Kiungo';

  @override
  String get a11yFormatTable => 'Jedwali';

  @override
  String get a11yFormatMeetingTemplate => 'Kiolezo cha mkutano';

  @override
  String get a11yEmojiSmileys => 'Vikaragosi na watu';

  @override
  String get a11yEmojiHearts => 'Mioyo';

  @override
  String get a11yEmojiAnimals => 'Wanyama na mazingira';

  @override
  String get a11yEmojiFood => 'Chakula na vinywaji';

  @override
  String get a11yEmojiTravel => 'Safari na maeneo';

  @override
  String get a11yEmojiActivities => 'Shughuli';

  @override
  String get a11yEmojiObjects => 'Vitu';

  @override
  String get a11yEmojiSymbols => 'Alama';

  @override
  String get ui3FrequentlyUsed => 'Zinazotumika mara kwa mara';

  @override
  String get ui3NoEditHistory => 'Hakuna historia ya uhariri';

  @override
  String get ui3EventNew => 'Tukio jipya';

  @override
  String get ui3EventTitleLabel => 'Kichwa';

  @override
  String get ui3EventLocationOptional => 'Mahali (si lazima)';

  @override
  String get ui3EventDescriptionOptional => 'Maelezo (si lazima)';

  @override
  String get ui3EventSend => 'Tuma tukio';

  @override
  String get ui3EventTitleRequired => 'Kichwa kinahitajika';

  @override
  String get ui3EventEndAfterStart =>
      'Muda wa kumalizika lazima uwe baada ya kuanza';

  @override
  String get ui3MiniAppAgentIntro =>
      'Eleza unachotaka kufanya — nitafungua programu ndogo inayofaa.';

  @override
  String get ui3MiniAppAgentExample => 'mf. badilisha ETH kuwa USDC';

  @override
  String get ui3MiniAppAgentNoMatch =>
      'Hakuna programu ndogo inayolingana. Jaribu kusema kwa njia nyingine.';

  @override
  String ui3MiniAppOpen(Object appName) {
    return 'Fungua $appName';
  }

  @override
  String get ui3MusicLinkPlatforms =>
      'Inaauni viungo vya nyimbo kutoka NetEase Cloud Music, QQ Music, Kugou, Kuwo na zaidi';

  @override
  String get ui3PollMarkCorrectAnswer =>
      'Weka alama kwenye jibu sahihi lisilo tupu';

  @override
  String get ui3PollQuizMode => 'Hali ya chemsha bongo';

  @override
  String get ui3PollAnswerExplanationHint => 'Maelezo ya jibu (si lazima)';

  @override
  String get a11yCorrectAnswer => 'Jibu sahihi';

  @override
  String get ui3AiSuggestions => 'Mapendekezo ya AI';

  @override
  String get a11yPaste => 'Bandika';

  @override
  String get a11yRefresh => 'Onyesha upya';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      'Hifadhi ufunguo huu mahali salama. Ndiyo njia pekee ya kurejesha ujumbe wako uliosimbwa ukipoteza ufikiaji wa vifaa vyote.';

  @override
  String ui3SavedToPath(Object path) {
    return 'Imehifadhiwa: $path';
  }

  @override
  String get ui3UnknownAccount => 'Akaunti isiyojulikana';

  @override
  String get ui3UnknownHomeserver => 'Seva ya nyumbani isiyojulikana';

  @override
  String get ui3ImportRecoveryKey => 'Leta ufunguo wa urejeshaji';

  @override
  String get ui3ImportRecoveryKeyDesc =>
      'Weka au bandika ufunguo wako wa urejeshaji ili kurejesha funguo za vyumba za historia ya ujumbe uliosimbwa.';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return 'Akaunti: $account\\nSeva ya nyumbani: $homeserver';
  }

  @override
  String get ui3Import => 'Leta';

  @override
  String get ui3InvalidRecoveryKeyFormat =>
      'Muundo wa ufunguo wa urejeshaji si sahihi';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return 'Funguo $restored kati ya $total zimerejeshwa. Funguo $failed zimeshindwa. Kagua akaunti, mtandao na nakala rudufu, kisha ujaribu tena. Sehemu ya historia huenda isisomeke.';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return 'Funguo $restored kati ya $total zimerejeshwa kwa mafanikio';
  }

  @override
  String ui3ImportFailed(Object error) {
    return 'Imeshindwa kuleta: $error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return 'Usajili wa passkey umeshindwa: $error';
  }

  @override
  String get ui3PasskeyDefaultName => 'Passkey yangu';

  @override
  String get ui3PasskeyNameHint => 'mf. iPhone, MacBook';

  @override
  String get ui3PasskeyDeleteFailed => 'Imeshindwa kufuta passkey';

  @override
  String get ui3TwoFactorAuth => 'Uthibitishaji wa hatua mbili';

  @override
  String get ui3TwoFactorOnSubtitle =>
      'Imewashwa — msimbo wa programu ya uthibitishaji unahitajika';

  @override
  String get ui3TwoFactorOffSubtitle =>
      'Imezimwa — linda kwa programu ya uthibitishaji (TOTP)';

  @override
  String get ui3ShowRecoveryKey => 'Onyesha ufunguo wa urejeshaji';

  @override
  String get ui3ShowRecoveryKeyDesc =>
      'Onyesha ufunguo wako wa urejeshaji kwa ajili ya nakala rudufu';

  @override
  String get ui3ImportRecoveryKeyHint =>
      'Rejesha ujumbe kwa kutumia ufunguo wa urejeshaji';

  @override
  String get ui3RecoveryKeyCreateFailed =>
      'Imeshindwa kuunda ufunguo wa urejeshaji';

  @override
  String get ui3TotpIncorrectCode => 'Msimbo si sahihi, jaribu tena';

  @override
  String get ui3TwoFactorEnabled => 'Uthibitishaji wa hatua mbili umewashwa';

  @override
  String get ui3TwoFactorDisabled => 'Uthibitishaji wa hatua mbili umezimwa';

  @override
  String get ui3TwoFactorTurnOffTitle => 'Zima uthibitishaji wa hatua mbili?';

  @override
  String get ui3TwoFactorTurnOffMessage =>
      'Programu yako ya uthibitishaji haitahitajika tena. Unaweza kuiweka upya baadaye kwa ufunguo mpya.';

  @override
  String get ui3TurnOff => 'Zima';

  @override
  String get ui3TwoFactorTotpTitle => 'Hatua mbili (TOTP)';

  @override
  String get ui3TwoFactorIsOn => 'Uthibitishaji wa hatua mbili umewashwa';

  @override
  String get ui3TwoFactorCodeRequired =>
      'Msimbo kutoka kwa programu yako ya uthibitishaji unahitajika.';

  @override
  String get ui3TotpStepScan =>
      '1. Changanua QR hii kwa programu ya uthibitishaji (Google Authenticator, Authy, 1Password…), au weka ufunguo mwenyewe.';

  @override
  String get ui3TotpKeyCopied => 'Ufunguo umenakiliwa';

  @override
  String get ui3TotpStepConfirm =>
      '2. Weka msimbo wa tarakimu 6 ili kuthibitisha.';

  @override
  String get ui3Enable => 'Washa';

  @override
  String get ui3BackupSettingsDesc =>
      'Hifadhi nakala ya mipangilio yako ya gumzo ya ndani. Ujumbe utarejeshwa kutoka kwa seva baada ya kuingia tena.';

  @override
  String get ui3BackupKeysSeparate =>
      'Funguo za usimbaji fiche zinadhibitiwa kando';

  @override
  String get ui3BackupKeysSeparateHint =>
      'Tumia Usalama > Ufunguo wa Urejeshaji kuhifadhi nakala ya ufikiaji wa ujumbe uliosimbwa.';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return 'Vyumba $rooms  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      'Leta faili ya .n42backup kutoka kifaa kingine au nakala rudufu ya awali. Funguo za usimbaji fiche hurejeshwa kando kwa ufunguo wako wa urejeshaji.';

  @override
  String get ui3UsernameSessionRequired =>
      'Jina la mtumiaji linahitaji kipindi amilifu';

  @override
  String get ui3SecuritySessionRequired =>
      'Mipangilio ya usalama inahitaji kipindi amilifu';

  @override
  String get ui3ConnectedAccountsSessionRequired =>
      'Akaunti zilizounganishwa zinahitaji kipindi amilifu';

  @override
  String get ui3SystemAccounts => 'Mfumo na akaunti';

  @override
  String get ui3AccountIdentity => 'Akaunti na utambulisho';

  @override
  String get ui3Accounts => 'Akaunti';

  @override
  String get ui3DevicesSessions => 'Vifaa na vipindi';

  @override
  String get ui3Integrations => 'Miunganisho';

  @override
  String get ui3ConnectedAccounts => 'Akaunti zilizounganishwa';

  @override
  String get ui3ConnectedAccountsDesc =>
      'Miunganisho ya Telegram, WhatsApp, Discord na madaraja ya API';

  @override
  String get ui3SystemOverview => 'Muhtasari wa mfumo';

  @override
  String ui3AccountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Akaunti $count',
      one: 'Akaunti 1',
    );
    return '$_temp0';
  }

  @override
  String ui3DeviceCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vifaa $count',
      one: 'Kifaa 1',
    );
    return '$_temp0';
  }

  @override
  String get ui3PrivacySecurityOverview =>
      'Usimbaji fiche wa mwisho hadi mwisho, ulinzi wa picha za skrini na udhibiti wa proksi';

  @override
  String get ui3ConversationPrivacy => 'Faragha ya mazungumzo';

  @override
  String get ui3NetworkPrivacy => 'Faragha ya mtandao';

  @override
  String get ui3IdentityPrivacy => 'Faragha ya utambulisho';

  @override
  String get ui3EncryptionKeyBackup => 'Usimbaji fiche na nakala ya funguo';

  @override
  String get ui3DevicesVerification => 'Vifaa na uthibitishaji';

  @override
  String get ui3ChipE2eeDefault => 'E2EE kwa chaguomsingi';

  @override
  String get ui3ChipManualE2ee => 'E2EE ya mikono';

  @override
  String get ui3ChipSelfDestruct => 'Kujifuta';

  @override
  String get ui3ChipScreenshotGuard => 'Kinga ya picha za skrini';

  @override
  String get ui3ChipIpProxy => 'IP / seva mbadala';

  @override
  String get ui3ChipLinkPreviewsOff => 'Onyesho la viungo limezimwa';

  @override
  String get ui3ChipPublicHandle => 'Jina la mtumiaji la umma';

  @override
  String get a11yShowPassword => 'Onyesha nenosiri';

  @override
  String get a11yHidePassword => 'Ficha nenosiri';

  @override
  String get a11yCheckServer => 'Kagua seva';

  @override
  String get ui3AuthAnonymousRegistration => 'Usajili bila kujitambulisha';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      'Fungua akaunti bila kuunganisha simu au barua pepe. Jina la mtumiaji litatengenezwa kiotomatiki.';

  @override
  String get ui3AuthAnonymousModeOn => 'Hali ya kutojulikana imewashwa';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      'Programu itakutengenezea jina la mtumiaji la Matrix la nasibu. Bado unaweza kuingia baadaye kwa akaunti na nenosiri vilivyotengenezwa.';

  @override
  String get ui3AuthChooseLoginMethod => 'Chagua njia ya kuingia';

  @override
  String get ui3AuthSsoOpenFailed =>
      'Imeshindwa kufungua ukurasa wa kuingia wa SSO';

  @override
  String get ui3AuthWalletUnavailable => 'Pochi haipatikani';

  @override
  String get ui3ProfileSubscriptions => 'Usajili';

  @override
  String get ui3ProfileBuySellCrypto => 'Nunua / Uza kripto';

  @override
  String get ui3ProfileOnDeviceAi => 'AI kwenye kifaa';

  @override
  String get ui3ProfileSetAUsername => 'Weka jina la mtumiaji';

  @override
  String get ui3ProfileAvatarStudio => 'Studio ya Avatar';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'Avatar ya NFT / Mapambo';

  @override
  String get ui3ProfileCustomize => 'Badilisha upendavyo';

  @override
  String get ui3ProfileQrSubtitle =>
      'Changanua ili kufungua wasifu huu au kuanzisha gumzo';

  @override
  String get ui3PrivacyHardening => 'Kuimarisha Faragha';

  @override
  String get ui3HidePhoneNumber => 'Ficha Nambari ya Simu';

  @override
  String get ui3HidePhoneNumberDesc =>
      'Ficha nambari ya simu iliyounganishwa kwenye kurasa za wasifu kwenye kifaa hiki';

  @override
  String get ui3EncryptNewChatsByDefault => 'Simba Gumzo Mpya kwa Chaguomsingi';

  @override
  String get ui3EncryptNewChatsByDefaultDesc =>
      'Anzisha gumzo za moja kwa moja na vyumba vya faragha vipya E2EE ikiwa imewashwa';

  @override
  String get ui3PrivateChatMode => 'Hali ya Gumzo la Faragha';

  @override
  String get ui3PrivateChatModeDesc =>
      'Zuia picha za skrini kwa muda unapotazama gumzo za faragha au zilizosimbwa';

  @override
  String get ui3DefaultSelfDestructTimer =>
      'Kipima Muda cha Kujifuta Chaguomsingi';

  @override
  String get ui3DefaultSelfDestructTimerDesc =>
      'Tumia kipima muda cha kujifuta chaguomsingi kwa ujumbe mpya unaotumwa';

  @override
  String get ui3LinkPreviews => 'Onyesho la Viungo';

  @override
  String get ui3LinkPreviewsDesc =>
      'Leta vichwa, maelezo na picha ndogo ujumbe unapokuwa na URL';

  @override
  String get ui3IpAddressProtection => 'Ulinzi wa Anwani ya IP';

  @override
  String get ui3IpAddressProtectionDesc =>
      'Pitisha maombi ya Matrix na ya onyesho la viungo kupitia seva mbadala ya faragha ya HTTP uliyosanidi inapopatikana';

  @override
  String get ui3UseTorProxy => 'Tumia Seva Mbadala ya HTTP ya Tor / Privoxy';

  @override
  String get ui3UseTorProxyDesc =>
      'Tumia sehemu ya seva mbadala ya HTTP ya ndani kama Privoxy kwenye 127.0.0.1:8118. Uelekezaji asilia wa Tor kupitia SOCKS5 hautumiki hapa.';

  @override
  String get ui3CustomProxy => 'Seva Mbadala Maalum';

  @override
  String get ui3CustomProxyDesc =>
      'Tumia seva mbadala maalum ya HTTP au HTTPS kwa trafiki ya Matrix na onyesho la viungo';

  @override
  String get ui3ProxyEndpoint => 'Anwani ya Seva Mbadala';

  @override
  String get ui3ProxyEndpointDesc =>
      'Anwani ya seva mbadala ya HTTP/HTTPS (SOCKS haitumiki)';

  @override
  String get ui3InvalidEndpoint => 'Anwani si sahihi';

  @override
  String get ui3CustomProxyStaysOff =>
      'Seva mbadala maalum itabaki imezimwa hadi uweke anwani sahihi';

  @override
  String get ui3NotificationFilterNote =>
      'Kanuni za kipaumbele huarifu kila wakati (hupita kunyamazisha, kutajwa tu na Usisumbue). Maneno muhimu yaliyonyamazishwa huzuia arifa.';

  @override
  String get ui3PriorityKeywords => 'Maneno muhimu ya kipaumbele';

  @override
  String get ui3PriorityKeywordHint => 'k.m. dharura';

  @override
  String get ui3MutedKeywords => 'Maneno muhimu yaliyonyamazishwa';

  @override
  String get ui3MutedKeywordHint => 'k.m. barua taka';

  @override
  String get ui3PrioritySenders => 'Watumaji wa kipaumbele';

  @override
  String get ui3CaseSensitive => 'Zingatia herufi kubwa/ndogo';

  @override
  String get ui3None => 'Hakuna';

  @override
  String get ui3SmartReplyTranslation => 'Tafsiri ya majibu mahiri';

  @override
  String get ui3SmartReplyTranslationDesc =>
      'Tafsiri ujumbe wako kiotomatiki kwa lugha ya mpokeaji kabla ya kutuma.';

  @override
  String get ui3FromPhotos => 'Kutoka kwa Picha';

  @override
  String get ui3ChangePhoto => 'Badilisha picha';

  @override
  String get ui3RoamingUsesMobileData =>
      'Uzururaji unafuata kanuni za Data ya Simu';

  @override
  String get ui3RoamingUsesMobileDataDesc =>
      'Utambuzi maalum wa uzururaji bado haupatikani, kwa hivyo uzururaji kwa sasa unafuata mipangilio ya kupakua kiotomatiki ya Data ya Simu.';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return 'Ungependa kufuta \"$content\"?';
  }

  @override
  String get ui3ResetToDefaults => 'Rejesha Chaguomsingi';

  @override
  String get ui3ResetQuickRepliesMessage =>
      'Hii itaondoa majibu yote ya haraka maalum na kurejesha chaguomsingi. Ungependa kuendelea?';

  @override
  String get ui3LocalLlmUnavailable => 'Haitumiki kwenye kifaa hiki';

  @override
  String get ui3LocalLlmNotDownloaded => 'Muundo haujapakuliwa';

  @override
  String get ui3LocalLlmReady => 'Tayari (kwenye kifaa)';

  @override
  String get ui3LocalLlmDescription =>
      'Ikiwashwa na kuwa tayari, vipengele vya AI (kufupisha, kuandika upya, kutafsiri, majibu) huendeshwa kikamilifu kwenye kifaa — data haitoki kamwe kwenye simu yako. Vinginevyo vinatumia mtoa huduma wa wingu.';

  @override
  String get ui3UseOnDeviceAi => 'Tumia AI kwenye kifaa';

  @override
  String get ui3UseOnDeviceAiDesc =>
      'Pendelea uchakataji wa ndani ukiwa tayari';

  @override
  String get ui3DownloadModel => 'Pakua muundo';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      'Uchakataji kwenye kifaa unahitaji mazingira asilia ya utekelezaji (Android MediaPipe / iOS Core ML). Utawashwa kiotomatiki mara kishughulikiaji cha jukwaa kitakapopatikana.';

  @override
  String get ui3PhotoAvatar => 'Avatar ya Picha';

  @override
  String get ui3AvatarStyles => 'Mitindo ya Avatar';

  @override
  String get ui3AvatarStylesDesc =>
      'Tumia kichaguzi kimoja cha mapambo kwa wasifu na sehemu za kuingia za avatar.';

  @override
  String get ui3ReplaceNftAvatar => 'Badilisha Avatar ya NFT';

  @override
  String get ui3NftAvatarDesc =>
      'Tumia mkusanyiko ulio kwenye mnyororo kama avatar yako.';

  @override
  String get ui3UsePhotoAvatar => 'Tumia Avatar ya Picha';

  @override
  String get ui3UsePhotoAvatarDesc =>
      'Hifadhi avatar uliyopakia na uondoe muunganisho wa NFT.';

  @override
  String ui3AvatarStyleSet(Object name) {
    return 'Mtindo wa avatar umewekwa kuwa: $name';
  }

  @override
  String get ui3NftAvatarUpdated => 'Avatar ya NFT imesasishwa';

  @override
  String get ui3SwitchedToPhotoAvatar => 'Umerudi kwenye avatar ya picha';

  @override
  String get ui3SignInToViewRedPacketHistory =>
      'Ingia ili kuona historia ya bahasha nyekundu';

  @override
  String get ui3RedPacketActive => 'Zinazoendelea';

  @override
  String get ui3RedPacketCompleted => 'Zimekamilika';

  @override
  String get ui3CardsAndPasses => 'Kadi na pasi';

  @override
  String get ui3CardsAndPassesDesc =>
      'Kadi za pochi, kuponi na pasi zinasimamiwa na programu kuu.';

  @override
  String get ui3CardPackRequiresMainApp =>
      'Kifurushi cha Kadi kinahitaji programu kuu';

  @override
  String get ui3OpenCardPack => 'Fungua Kifurushi cha Kadi';

  @override
  String get ui3UnableToOpenChat =>
      'Imeshindwa kufungua gumzo na mwasiliani huyu';

  @override
  String get ui3WalletManagedInMainApp =>
      'Pochi inasimamiwa kwenye programu kuu';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · Mipango';
  }

  @override
  String get ui3NewPlan => 'Mpango mpya';

  @override
  String get ui3MySubscriptions => 'Usajili wangu';

  @override
  String get ui3AvailablePlans => 'Mipango inayopatikana';

  @override
  String get ui3NoPlansYet =>
      'Bado hakuna mipango · gusa \"Mpango mpya\" ili kuunda';

  @override
  String ui3DaysLeft(Object days) {
    return 'Zimebaki siku $days';
  }

  @override
  String get ui3SubscriptionCancelled => 'Umeghairiwa';

  @override
  String get ui3AutoRenewOn => 'Kusasisha kiotomatiki: kumewashwa';

  @override
  String get ui3AutoRenewOff => 'Kusasisha kiotomatiki: kumezimwa';

  @override
  String get ui3CancelSubscriptionTitle => 'Ungependa kughairi usajili?';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return 'Usajili wako wa $name utaendelea kuwa hai hadi utakapoisha na hautasasishwa.';
  }

  @override
  String get ui3Subscribe => 'Jisajili';

  @override
  String ui3SubscribedTo(Object name) {
    return 'Umejisajili kwa $name';
  }

  @override
  String get ui3PlanPriceLabel => 'Bei (mf. 9.9 USDT)';

  @override
  String get ui3PlanDescriptionLabel => 'Maelezo (si lazima)';

  @override
  String get ui3PlanBenefitsLabel => 'Manufaa (tenganisha kwa koma)';

  @override
  String get ui3PlanPeriod => 'Kipindi:';

  @override
  String get ui3Monthly => 'Kila mwezi';

  @override
  String get ui3Yearly => 'Kila mwaka';

  @override
  String get ui3SaveRemarkFailed => 'Imeshindwa kuhifadhi dokezo';

  @override
  String get ui3CopyLink => 'Nakili Kiungo';

  @override
  String get ui3Connect => 'Unganisha';

  @override
  String get ui3CommonTokens => 'Tokeni za pamoja';

  @override
  String get ui3SharedNfts => 'NFT za pamoja';

  @override
  String get ui3TransactionHistory => 'Historia ya miamala';

  @override
  String get ui3CommonDaos => 'DAO za pamoja';

  @override
  String get ui3SameChains => 'Minyororo sawa';

  @override
  String get ui3ChatInitFailed => 'Imeshindwa kuanzisha gumzo';

  @override
  String get ui3CheckNetworkRetry =>
      'Tafadhali angalia mtandao wako kisha ujaribu tena';

  @override
  String get ui3FromContacts => 'Kutoka kwa Anwani';

  @override
  String get ui3FindFriendsFromContacts =>
      'Tafuta marafiki kutoka kwa anwani za simu yako';

  @override
  String get ui3EnsOrDomain => 'ENS / Kikoa';

  @override
  String get ui3LoadingContacts => 'Inapakia anwani...';

  @override
  String get ui3ContactsPermissionRequired => 'Ruhusa ya Anwani Inahitajika';

  @override
  String get ui3ContactsPermissionMessage =>
      'Ili kupata marafiki kutoka kwa anwani zako, tafadhali ruhusu ufikiaji wa anwani zako.';

  @override
  String get ui3AllowAccess => 'Ruhusu Ufikiaji';

  @override
  String get ui3NoContactMatches => 'Hakuna Vinavyolingana';

  @override
  String get ui3NoContactMatchesMessage =>
      'Hakuna kati ya anwani zako anayetumia programu hii bado. Waalike wajiunge!';

  @override
  String ui3ScannedContacts(Object count) {
    return 'Anwani $count zimechanganuliwa';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return 'Vinavyolingana $count vimepatikana kwenye anwani zako';
  }

  @override
  String ui3InContactsAs(Object name) {
    return 'Kwenye Anwani: $name';
  }

  @override
  String get ui3DeletePhotoConfirm => 'Ungependa kufuta picha hii?';

  @override
  String get ui3InviteLink => 'Kiungo cha Mwaliko';

  @override
  String get ui3ShareJoinLink => 'Shiriki kiungo cha kujiunga na chumba hiki';

  @override
  String get ui3ShareRoomReference =>
      'Shiriki marejeleo ya chumba na wanachama walioalikwa';

  @override
  String get ui3ScanToJoinGroup =>
      'Changanua ili ujiunge na kikundi hiki moja kwa moja';

  @override
  String get ui3ScanToShareRoomReference =>
      'Changanua ili kushiriki marejeleo ya chumba hiki na wanachama walioalikwa';

  @override
  String get ui3InviteLinkLoadFailed => 'Imeshindwa kupakia kiungo cha mwaliko';

  @override
  String get ui3InviteLinkCopied => 'Kiungo cha mwaliko kimenakiliwa';

  @override
  String get ui3ChannelCategoryOptional => 'Aina (si lazima)';

  @override
  String get ui3ChannelCategoryHint => 'Matangazo / Bidhaa / Usaidizi';

  @override
  String get ui3DescriptionOptional => 'Maelezo (si lazima)';

  @override
  String get ui3WebhookEnable => 'Washa uendeshaji otomatiki wa webhook';

  @override
  String get ui3WebhookEnableDesc =>
      'Tuma matukio ya mwanachama kujiunga na makaribisho kwa endpoint ya muunganisho wako.';

  @override
  String get ui3WebhookUrl => 'URL ya webhook';

  @override
  String get ui3WebhookSecretOptional => 'Siri ya Kusaini (si lazima)';

  @override
  String get ui3WebhookSecretHint => 'Hutumika kwa X-N42-Signature';

  @override
  String get ui3WebhookNotifyMemberJoined => 'Arifu mwanachama anapojiunga';

  @override
  String get ui3WebhookNotifyWelcomeSent => 'Arifu ukaribisho unapotumwa';

  @override
  String get ui3WebhookTestSend => 'Tuma webhook ya majaribio';

  @override
  String get ui3WebhookTestSending => 'Inatuma webhook ya majaribio...';

  @override
  String get ui3WebhookTestSent => 'Webhook ya majaribio imetumwa';

  @override
  String get ui3WebhookTestFailed => 'Imeshindwa kutuma webhook ya majaribio';

  @override
  String get ui3WebhookUrlInvalid =>
      'URL ya webhook lazima iwe anwani ya umma ya HTTPS';

  @override
  String get ui3WebhookSelectEvent => 'Chagua angalau tukio moja la webhook';

  @override
  String get ui3SensitiveDataDetection => 'Ugunduzi wa Data Nyeti';

  @override
  String get ui3Email => 'Barua pepe';

  @override
  String get ui3CreditCard => 'Kadi ya Mkopo';

  @override
  String get ui3DetectEmailDesc =>
      'Gundua anwani za barua pepe katika ujumbe wa maandishi';

  @override
  String get ui3DetectPhoneDesc =>
      'Gundua nambari za simu na nambari za kimataifa';

  @override
  String get ui3DetectCardDesc =>
      'Gundua nambari zinazowezekana za benki na kadi';

  @override
  String get ui3DetectWalletDesc =>
      'Gundua anwani za pochi za mtindo wa Ethereum';

  @override
  String get ui3GeneralTopic => 'Jumla';

  @override
  String get a11yPreviousResult => 'Tokeo lililotangulia';

  @override
  String get a11yNextResult => 'Tokeo linalofuata';

  @override
  String get ui3TryDifferentKeywords => 'Jaribu maneno muhimu tofauti';

  @override
  String ui3FiltersActive(Object count) {
    return 'Vichujio vinavyotumika: $count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return 'Vichujio vya ujumbe vinavyotumika: $count';
  }

  @override
  String get ui3LoadMore => 'Pakia zaidi';

  @override
  String get ui3MessageFilters => 'Vichujio vya Ujumbe';

  @override
  String get ui3SenderUserId => 'Kitambulisho cha Mtumaji';

  @override
  String get ui3FilterType => 'Aina';

  @override
  String get ui3FilterAny => 'Yoyote';

  @override
  String get ui3FilterImage => 'Picha';

  @override
  String get ui3FilterTime => 'Muda';

  @override
  String get ui3AnyTime => 'Wakati wowote';

  @override
  String get ui3OnlyMyMessages => 'Ujumbe wangu pekee';

  @override
  String get ui3MediaOnly => 'Media pekee';

  @override
  String get ui3Apply => 'Tekeleza';

  @override
  String get ui3QrStyleClassic => 'Asili';

  @override
  String get ui3QrStyleOcean => 'Bahari';

  @override
  String get ui3QrStyleBerry => 'Beri';

  @override
  String get ui3NfcUnavailable =>
      'NFC haipatikani au lebo haitumiki. Washa NFC, jaribu lebo nyingine, au tumia QR.';

  @override
  String get ui3CancelNfc => 'Ghairi NFC';

  @override
  String get ui3ReadNfcTag => 'Soma lebo ya NFC';

  @override
  String get ui3HoldNearNfcTag =>
      'Shikilia simu yako karibu na lebo ya huduma.';

  @override
  String get a11yFlashlightOn => 'Washa tochi';

  @override
  String get a11yFlashlightOff => 'Zima tochi';

  @override
  String get ui3SocialGraph => 'Mtandao wa Kijamii';

  @override
  String get ui3RecommendedConnections => 'Miunganisho Inayopendekezwa';

  @override
  String get ui3Portfolio => 'Jalada la Mali';

  @override
  String get ui3Chains => 'Minyororo';

  @override
  String get ui3Tokens => 'Tokeni';

  @override
  String get ui3NoConnectionsFound => 'Hakuna miunganisho iliyopatikana';

  @override
  String get ui3ConnectionsHint =>
      'Miunganisho itaonekana unapoongeza shughuli kwenye mnyororo';

  @override
  String get ui3SocialGraphLoadFailed =>
      'Imeshindwa kupakia mtandao wa kijamii';

  @override
  String get ui3Similarity => 'Ufanano';

  @override
  String get ui3Breakdown => 'Mchanganuo';

  @override
  String get ui3TokenHoldings => 'Tokeni unayomiliki';

  @override
  String get ui3NftCollections => 'Mikusanyiko ya NFT';

  @override
  String get ui3ChainUsage => 'Matumizi ya mnyororo';

  @override
  String get ui3Transactions => 'Miamala';

  @override
  String get ui3DaoMembership => 'Uanachama wa DAO';

  @override
  String get ui3NotWeighted => 'Haina uzito';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent% (uzito: $weight)';
  }

  @override
  String get ui3CommonOnChainActivity => 'Shughuli za pamoja kwenye mnyororo';

  @override
  String get ui3SharedTokens => 'Tokeni za pamoja';

  @override
  String get ui3SharedNftCollections => 'Mikusanyiko ya NFT ya pamoja';

  @override
  String get ui3SharedChains => 'Minyororo ya pamoja';

  @override
  String get ui3NoSharedTokens => 'Hakuna tokeni za pamoja zilizopatikana';

  @override
  String get ui3NoSharedNftCollections =>
      'Hakuna mikusanyiko ya NFT ya pamoja iliyopatikana';

  @override
  String get ui3NoSharedChains => 'Hakuna minyororo ya pamoja iliyopatikana';

  @override
  String get ui3SimilarityFailed => 'Imeshindwa kukokotoa ufanano';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items +$count zaidi';
  }

  @override
  String get a11yGovernance => 'Utawala';

  @override
  String get ui3CommunityLink => 'Kiungo cha jumuiya';

  @override
  String get ui3CommunityQrCode => 'Msimbo wa QR wa jumuiya';

  @override
  String get ui3CommunityQrSubtitle =>
      'Changanua ili ujiunge na jumuiya hii na uvinjari chaneli zake';

  @override
  String get ui3CommunityLinkLoadFailed =>
      'Imeshindwa kupakia kiungo cha jumuiya';

  @override
  String get ui3CommunityLinkCopied => 'Kiungo cha jumuiya kimenakiliwa';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name ataondolewa kwenye jumuiya hii.';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name ataondolewa na hataweza kujiunga tena.';
  }

  @override
  String get ui3SignInToDiscoverChannels => 'Ingia ili ugundue chaneli za umma';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return 'Imeshindwa kujiunga na $name: $error';
  }

  @override
  String get ui3CategoryTech => 'Teknolojia';

  @override
  String get ui3CategorySocial => 'Kijamii';

  @override
  String get ui3NoPublicChannels => 'Hakuna chaneli za umma zilizopatikana';

  @override
  String get ui3StoriesAndFun => 'Hadithi na Burudani';

  @override
  String get ui3SearchMusicHint => 'Tafuta nyimbo, wasanii au marafiki';

  @override
  String get ui3ForYou => 'Kwa ajili yako';

  @override
  String get ui3Liked => 'Zilizopendwa';

  @override
  String get ui3NoLikedMusic => 'Bado hakuna muziki uliopendwa';

  @override
  String get ui3NoMusicStories => 'Bado hakuna Hadithi za muziki';

  @override
  String get ui3LikedMusicHint => 'Gusa moyo kando ya wimbo ili kuuweka hapa.';

  @override
  String get ui3MusicStoriesHint =>
      'Muziki ulioshirikiwa kwenye Hadithi utaonekana hapa.';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · imeshirikiwa na $name';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return 'Imeshindwa kucheza $title: $error';
  }

  @override
  String get a11yPreviousTrack => 'Wimbo uliotangulia';

  @override
  String get a11yNextTrack => 'Wimbo unaofuata';

  @override
  String get a11yPlay => 'Cheza';

  @override
  String get a11yPause => 'Sitisha';

  @override
  String get ui3Refresh => 'Onyesha upya';

  @override
  String get ui3NearbyIntroTitle => 'Gundua machapisho ya umma yaliyo karibu';

  @override
  String get ui3NearbyIntroBody =>
      'Mahali ulipo hutumika mara moja kwenye kifaa hiki kupanga Matukio ya umma. Hapapakiwi, hapatangazwi wala kuonyeshwa kwa watu wengine.';

  @override
  String get ui3UseMyLocation => 'Tumia mahali nilipo';

  @override
  String get ui3NearbyUnavailable => 'Kipengele cha Karibu hakipatikani';

  @override
  String get ui3NoNearbyPosts => 'Bado hakuna machapisho karibu';

  @override
  String get ui3NoNearbyPostsHint =>
      'Matukio ya umma yenye mahali yataonekana hapa.';

  @override
  String get ui3NearbyDistanceNote =>
      'Umbali wa kukadiria · machapisho ya umma yenye mahali pekee';

  @override
  String get ui3PublicLocationPost => 'Chapisho la umma lenye mahali';

  @override
  String get ui3LocationServicesOff => 'Huduma za Mahali zimezimwa';

  @override
  String get ui3LocationPermissionDenied => 'Ruhusa ya mahali imekataliwa';

  @override
  String get ui3EnableLocationInSettings =>
      'Washa ruhusa ya mahali kwenye mipangilio ya mfumo';

  @override
  String get ui3CreateStory => 'Unda Hadithi';

  @override
  String get ui3CreateStoryDesc => 'Chapisha hali ya maandishi au picha.';

  @override
  String get ui3StoryCamera => 'Kamera ya Hadithi';

  @override
  String get ui3StoryCameraDesc =>
      'Nenda moja kwa moja kwenye vichujio na kuhariri picha.';

  @override
  String get ui3MomentsDesc => 'Fungua mlisho kamili na maoni.';

  @override
  String get ui3MomentCamera => 'Kamera ya Matukio';

  @override
  String get ui3MomentCameraDesc => 'Unda chapisho na uchague midia mara moja.';

  @override
  String get ui3GamesDesc =>
      'Fungua kituo cha michezo ya kawaida kilichojengewa ndani.';

  @override
  String get ui3AvatarStudio => 'Studio ya Avatar';

  @override
  String get ui3AvatarStudioDesc =>
      'Mapambo, avatar ya NFT na mtindo wa utambulisho.';

  @override
  String get ui3SocialGraphDesc =>
      'Wanaofuatwa, mashabiki na miunganisho kwenye mnyororo.';

  @override
  String get ui3SocialHubHeroTitle => 'Hadithi, matukio, michezo na avatar';

  @override
  String get ui3SocialHubHeroBody =>
      'Vipengele vyote vya kijamii mahali pamoja badala ya kutawanyika kwenye gumzo, wasifu na ugunduzi.';

  @override
  String get ui3SocialGraphNotConfigured =>
      'Grafu ya kijamii haijasanidiwa kwenye toleo hili';

  @override
  String get ui3ConnectWalletForSocialGraph =>
      'Unganisha pochi ili kuona grafu yako ya kijamii';

  @override
  String get ui3AvatarStudioSignIn =>
      'Studio ya Avatar inahitaji mtumiaji aliyeingia';

  @override
  String get a11yRemoveImage => 'Ondoa picha';

  @override
  String get a11yBack => 'Rudi';

  @override
  String get ui3MiniAppConfirmTransactionTitle => 'Thibitisha muamala';

  @override
  String get ui3MiniAppConfirmTransactionBody =>
      'Programu Ndogo inaomba kutuma muamala kwa niaba yako.';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return 'Fungua $name?';
  }

  @override
  String get ui3MiniAppOpenButton => 'Fungua';

  @override
  String get ui3StoryReplySendFailed => 'Imeshindwa kutuma jibu la Hadithi';

  @override
  String get ui3RedPacketDemoNotice =>
      'Bahasha nyekundu ya majaribio — ni rekodi ndani ya gumzo tu, hakuna mali halisi kwenye mnyororo inayohamishwa.';

  @override
  String get ui3RedPacketCoverClassic => 'Nyekundu ya kawaida';

  @override
  String get ui3RedPacketCoverGolden => 'Dhahabu';

  @override
  String get ui3RedPacketCoverPurple => 'Zambarau';

  @override
  String get ui3RedPacketCoverOceanBlue => 'Buluu ya bahari';

  @override
  String get ui3RedPacketCoverNatureGreen => 'Kijani ya asili';

  @override
  String get ui3RedPacketCoverRosePink => 'Waridi';

  @override
  String get ui3RedPacketHistoryEmpty => 'Bado hakuna bahasha nyekundu';

  @override
  String get ui3TransferMerchantQrWithAmount =>
      'QR ya mfanyabiashara (pamoja na kiasi)';

  @override
  String get ui3TransferMerchantQrTitle => 'QR ya mfanyabiashara';

  @override
  String get ui3TransferOpenAmountHint => 'Acha wazi kwa kiasi chochote';

  @override
  String get ui3FiatRampTitle => 'Nunua / uza kripto';

  @override
  String get ui3FiatRampBuy => 'Nunua';

  @override
  String get ui3FiatRampSell => 'Uza';

  @override
  String get ui3FiatRampNotConfigured =>
      'Huduma ya kuingiza/kutoa fiat haijasanidiwa';

  @override
  String get a11yPointsAddRule => 'Ongeza kanuni ya zawadi';

  @override
  String get a11yGovernanceRemoveChoice => 'Ondoa chaguo';

  @override
  String get a11yGovernanceCreateProposal => 'Unda pendekezo';

  @override
  String get ui3MiniAppUpdateN42 => 'Sasisha N42';

  @override
  String get ui3MiniAppOfficial => 'Rasmi';

  @override
  String ui3MiniAppUserCount(Object count) {
    return 'Watumiaji $count';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return 'Rangi ya mandharinyuma $index';
  }

  @override
  String get a11yStoryAdd => 'Ongeza hadithi';

  @override
  String get ui3StoryPostFailed => 'Imeshindwa kuchapisha hadithi';

  @override
  String get ui3StoryTapToSelectImage => 'Gusa ili kuchagua picha';

  @override
  String get ui3StoryChangeImage => 'Badilisha';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return 'Imeshindwa kusoma muziki uliochaguliwa: $error';
  }

  @override
  String get ui3StoryDeleteConfirm => 'Futa hadithi hii?';

  @override
  String get ui3StoryDeleteFailed => 'Imeshindwa kufuta hadithi';

  @override
  String get ui3MomentCreateTitle => 'Unda tukio';

  @override
  String get ui3MomentContentHint => 'Unawaza nini?';

  @override
  String get ui3MomentAddPhotos => 'Ongeza picha';

  @override
  String get ui3MomentAddLocation => 'Ongeza mahali';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return 'Midia zilizochaguliwa ($count)';
  }

  @override
  String get ui3MomentClearAll => 'Futa zote';

  @override
  String get ui3MomentClearMediaConfirm =>
      'Ondoa picha/video zote zilizochaguliwa?';

  @override
  String get ui3MomentVisibilityPublicDesc => 'Marafiki wote wanaweza kuona';

  @override
  String get ui3MomentVisibilityPrivateDesc => 'Wewe pekee unaweza kuona';

  @override
  String get ui3MomentVisibilityPartialDesc => 'Chagua anayeweza kuona';

  @override
  String get ui3MomentVisibilityExcludedDesc => 'Ficha kwa marafiki fulani';

  @override
  String get ui3MomentVideos => 'Video';

  @override
  String get ui3MomentNoVideos => 'Bado hakuna video';

  @override
  String get a11yCallMinimize => 'Punguza';

  @override
  String get a11yCallGridView => 'Mwonekano wa gridi';

  @override
  String get a11yCallFocusView => 'Mwonekano wa kulenga';

  @override
  String get ui3CallTools => 'Zana za simu';

  @override
  String get ui3CallMeetingTools => 'Zana za mkutano';

  @override
  String get ui3CallToolsSubtitle =>
      'Rekebisha ubora wa sauti na video bila kuondoka kwenye simu.';

  @override
  String get ui3CallAudioEnhancement => 'Uboreshaji wa sauti';

  @override
  String get ui3CallNoiseSuppression => 'Kuzuia kelele';

  @override
  String get ui3CallNoiseSuppressionDesc =>
      'Punguza kelele za kibodi na za mandharinyuma.';

  @override
  String get ui3CallEchoCancellation => 'Kuondoa mwangwi';

  @override
  String get ui3CallEchoCancellationDesc =>
      'Zuia sauti ya spika kurudi kwenye maikrofoni.';

  @override
  String get ui3CallAutoGainControl => 'Udhibiti wa kiotomatiki wa sauti';

  @override
  String get ui3CallAutoGainControlDesc =>
      'Weka sauti ya maikrofoni iwe thabiti zaidi.';

  @override
  String get ui3CallVoiceIsolation => 'Utengaji wa sauti ulioboreshwa';

  @override
  String get ui3CallVoiceIsolationDesc =>
      'Tumia wasifu thabiti zaidi wa kupunguza kelele.';

  @override
  String get ui3CallVideoSection => 'Mipangilio ya video';

  @override
  String get ui3CallBackgroundBlur => 'Kufifisha mandharinyuma (beta)';

  @override
  String get ui3CallBlurDescReady =>
      'Mapendeleo yamewashwa. Ufifishaji halisi bado unategemea kuzinduliwa kwa kichakataji video.';

  @override
  String get ui3CallBlurDescSaved =>
      'Mapendeleo ya kufifisha yamehifadhiwa na yatatumika uchakataji wa kamera ukipatikana.';

  @override
  String get ui3CallBlurDescCameraOff =>
      'Washa kamera yako uchakataji wa mandharinyuma ukipatikana.';

  @override
  String get ui3CallRecordingSection => 'Kurekodi';

  @override
  String get ui3CallRecordingDesc =>
      'Inahitaji huduma ya egress upande wa seva kabla ya kuhifadhi rekodi.';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return 'Imeshindwa kusasisha mipangilio ya simu: $error';
  }

  @override
  String get ui3CallRecordingStarted => 'Kurekodi kumeanza';

  @override
  String get ui3VoiceRoomNotFound => 'Chumba hakijapatikana';

  @override
  String get ui3VoiceRoomEndConfirm =>
      'Una uhakika unataka kumaliza chumba hiki cha sauti?';

  @override
  String get a11yGameMoveUp => 'Sogeza juu';

  @override
  String get a11yGameMoveDown => 'Sogeza chini';

  @override
  String get a11yGameMoveLeft => 'Sogeza kushoto';

  @override
  String get a11yGameMoveRight => 'Sogeza kulia';

  @override
  String get a11yGameRotate => 'Zungusha';

  @override
  String get a11yGameDrop => 'Dondosha';

  @override
  String ui3StickerAddedCount(Object count) {
    return 'Vibandiko $count vimeongezwa';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return 'Imeshindwa kuongeza: $error';
  }

  @override
  String get ui3StickerRemoveTitle => 'Ondoa kibandiko';

  @override
  String get ui3StickerRemoveConfirm =>
      'Ondoa kibandiko hiki kwenye kifurushi?';

  @override
  String get ui3StickerRemoveFailed => 'Imeshindwa kuondoa';

  @override
  String get ui3StickerRenamePack => 'Badilisha jina la kifurushi';

  @override
  String get ui3StickerPackName => 'Jina la kifurushi';

  @override
  String get ui3StickerRenameFailed => 'Imeshindwa kubadilisha jina';

  @override
  String get ui3StickerDeletePack => 'Futa kifurushi';

  @override
  String get ui3StickerThisPack => 'kifurushi hiki';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return 'Futa \"$name\" na vibandiko vyake vyote? Hatua hii haiwezi kutenduliwa.';
  }

  @override
  String get ui3StickerDeleteFailed => 'Imeshindwa kufuta';

  @override
  String get ui3StickerPack => 'Kifurushi cha vibandiko';

  @override
  String get ui3StickerAdding => 'Inaongeza…';

  @override
  String get ui3StickerAddStickers => 'Ongeza vibandiko';

  @override
  String get ui3StickerPackNotFound => 'Kifurushi hakijapatikana';

  @override
  String get ui3StickerEmptyHint =>
      'Gusa \"Ongeza vibandiko\" ili kupakia picha';

  @override
  String get ui3StickerNewPack => 'Kifurushi kipya cha vibandiko';

  @override
  String get ui3StickerCreate => 'Unda';

  @override
  String get ui3StickerCreateFailed => 'Imeshindwa kuunda kifurushi';

  @override
  String ui3StickerInstalled(Object name) {
    return '\"$name\" imesakinishwa';
  }

  @override
  String get ui3StickerRemovePackTitle => 'Ondoa kifurushi cha vibandiko';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return 'Ondoa \"$name\" kwenye vibandiko vyako?';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return '\"$name\" imeondolewa';
  }

  @override
  String get ui3StickerAiSticker => 'Kibandiko cha AI';

  @override
  String get ui3StickerStoreTab => 'Duka';

  @override
  String get ui3StickerMyStickersTab => 'Vibandiko vyangu';

  @override
  String get ui3StickerNoneFound => 'Hakuna vibandiko vilivyopatikana';

  @override
  String ui3StickerByAuthor(Object author) {
    return 'na $author';
  }

  @override
  String get ui3StickerManage => 'Dhibiti';

  @override
  String ui3StickerCount(Object count) {
    return 'Vibandiko $count';
  }

  @override
  String get ui3StickerNoneInstalled => 'Hakuna vibandiko vilivyosakinishwa';

  @override
  String get ui3StickerGetFromStore => 'Pata vibandiko kutoka dukani';

  @override
  String get ui3StickerBrowseStore => 'Vinjari duka';

  @override
  String get ui3StickerAddedToAi => 'Imeongezwa kwenye \"Vibandiko vya AI\"';

  @override
  String get ui3StickerAddOneFailed => 'Imeshindwa kuongeza kibandiko';

  @override
  String get ui3StickerPromptLabel => 'Eleza kibandiko chako';

  @override
  String get ui3StickerPromptHint =>
      'mf. paka mchungwa mwenye furaha aliyevaa miwani ya jua';

  @override
  String get ui3StickerGenerating => 'Inatengeneza…';

  @override
  String get ui3StickerGenerate => 'Tengeneza';

  @override
  String get ui3StickerAddToStickers => 'Ongeza kwenye vibandiko';

  @override
  String get ui3StickerGeneratingPreview => 'Inatengeneza kibandiko chako…';

  @override
  String get ui3StickerGenerateEmpty =>
      'Eleza kibandiko kisha gusa \"Tengeneza\"';
}
