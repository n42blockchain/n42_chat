import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @commonRetry.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get commonRetry;

  /// No description provided for @commonUnknownUser.
  ///
  /// In zh, this message translates to:
  /// **'未知用户'**
  String get commonUnknownUser;

  /// No description provided for @transferWalletNotConnected.
  ///
  /// In zh, this message translates to:
  /// **'钱包未连接'**
  String get transferWalletNotConnected;

  /// No description provided for @chatCallServiceNotInitialized.
  ///
  /// In zh, this message translates to:
  /// **'通话服务未初始化'**
  String get chatCallServiceNotInitialized;

  /// No description provided for @authLoginFailed.
  ///
  /// In zh, this message translates to:
  /// **'登录失败: {error}'**
  String authLoginFailed(String error);

  /// No description provided for @chatCallBack.
  ///
  /// In zh, this message translates to:
  /// **'回拨'**
  String get chatCallBack;

  /// No description provided for @chatMissedVideoCall.
  ///
  /// In zh, this message translates to:
  /// **'未接视频通话'**
  String get chatMissedVideoCall;

  /// No description provided for @chatMissedVoiceCall.
  ///
  /// In zh, this message translates to:
  /// **'未接语音通话'**
  String get chatMissedVoiceCall;

  /// No description provided for @chatCallNotAnswered.
  ///
  /// In zh, this message translates to:
  /// **'对方未接听'**
  String get chatCallNotAnswered;

  /// No description provided for @chatCallDurationLabel.
  ///
  /// In zh, this message translates to:
  /// **'通话时长'**
  String get chatCallDurationLabel;

  /// No description provided for @chatVoiceCallCancelled.
  ///
  /// In zh, this message translates to:
  /// **'语音通话已取消'**
  String get chatVoiceCallCancelled;

  /// No description provided for @chatVideoCallCancelled.
  ///
  /// In zh, this message translates to:
  /// **'视频通话已取消'**
  String get chatVideoCallCancelled;

  /// No description provided for @commonImage.
  ///
  /// In zh, this message translates to:
  /// **'[图片]'**
  String get commonImage;

  /// No description provided for @chatVideo.
  ///
  /// In zh, this message translates to:
  /// **'[视频]'**
  String get chatVideo;

  /// No description provided for @chatVoice.
  ///
  /// In zh, this message translates to:
  /// **'[语音]'**
  String get chatVoice;

  /// No description provided for @commonFile.
  ///
  /// In zh, this message translates to:
  /// **'[文件]'**
  String get commonFile;

  /// No description provided for @chatLocation.
  ///
  /// In zh, this message translates to:
  /// **'[位置]'**
  String get chatLocation;

  /// No description provided for @chatUnknownMessage.
  ///
  /// In zh, this message translates to:
  /// **'[未知消息]'**
  String get chatUnknownMessage;

  /// No description provided for @commonDelete.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get commonDelete;

  /// No description provided for @chatDeleteThisMessage.
  ///
  /// In zh, this message translates to:
  /// **'删除这条消息？'**
  String get chatDeleteThisMessage;

  /// No description provided for @chatMessageDeleted.
  ///
  /// In zh, this message translates to:
  /// **'消息已删除'**
  String get chatMessageDeleted;

  /// No description provided for @profileNotLoggedIn.
  ///
  /// In zh, this message translates to:
  /// **'未登录'**
  String get profileNotLoggedIn;

  /// No description provided for @chatMyLocation.
  ///
  /// In zh, this message translates to:
  /// **'我的位置'**
  String get chatMyLocation;

  /// No description provided for @commonGroupChat.
  ///
  /// In zh, this message translates to:
  /// **'群聊'**
  String get commonGroupChat;

  /// No description provided for @commonSearch.
  ///
  /// In zh, this message translates to:
  /// **'搜索'**
  String get commonSearch;

  /// No description provided for @commonCancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get commonCancel;

  /// No description provided for @commonLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'加载失败'**
  String get commonLoadFailed;

  /// No description provided for @commonMessages.
  ///
  /// In zh, this message translates to:
  /// **'消息'**
  String get commonMessages;

  /// No description provided for @commonContacts.
  ///
  /// In zh, this message translates to:
  /// **'联系人'**
  String get commonContacts;

  /// No description provided for @commonMe.
  ///
  /// In zh, this message translates to:
  /// **'我'**
  String get commonMe;

  /// No description provided for @commonVoiceLoading.
  ///
  /// In zh, this message translates to:
  /// **'语音加载中，请稍后再试'**
  String get commonVoiceLoading;

  /// No description provided for @commonVoiceToTextFailed.
  ///
  /// In zh, this message translates to:
  /// **'语音转文字失败'**
  String get commonVoiceToTextFailed;

  /// No description provided for @commonConvertToText.
  ///
  /// In zh, this message translates to:
  /// **'转文字'**
  String get commonConvertToText;

  /// No description provided for @chatCopy.
  ///
  /// In zh, this message translates to:
  /// **'复制'**
  String get chatCopy;

  /// No description provided for @commonForward.
  ///
  /// In zh, this message translates to:
  /// **'转发'**
  String get commonForward;

  /// No description provided for @commonUnfavorite.
  ///
  /// In zh, this message translates to:
  /// **'取消收藏'**
  String get commonUnfavorite;

  /// No description provided for @commonFavorite.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get commonFavorite;

  /// No description provided for @settingsResend.
  ///
  /// In zh, this message translates to:
  /// **'重新发送'**
  String get settingsResend;

  /// No description provided for @chatRecall.
  ///
  /// In zh, this message translates to:
  /// **'撤回'**
  String get chatRecall;

  /// No description provided for @commonQuote.
  ///
  /// In zh, this message translates to:
  /// **'引用'**
  String get commonQuote;

  /// No description provided for @commonRemind.
  ///
  /// In zh, this message translates to:
  /// **'提醒'**
  String get commonRemind;

  /// No description provided for @chatCopied.
  ///
  /// In zh, this message translates to:
  /// **'已复制'**
  String get chatCopied;

  /// No description provided for @storySendMessageHint.
  ///
  /// In zh, this message translates to:
  /// **'发送消息'**
  String get storySendMessageHint;

  /// No description provided for @commonMicrophonePermissionRequired.
  ///
  /// In zh, this message translates to:
  /// **'请允许使用麦克风权限'**
  String get commonMicrophonePermissionRequired;

  /// No description provided for @chatMicrophonePermissionDeniedPermanent.
  ///
  /// In zh, this message translates to:
  /// **'麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。'**
  String get chatMicrophonePermissionDeniedPermanent;

  /// No description provided for @commonStartRecordingFailed.
  ///
  /// In zh, this message translates to:
  /// **'开始录音失败: {error}'**
  String commonStartRecordingFailed(String error);

  /// No description provided for @commonRecordingTooShort.
  ///
  /// In zh, this message translates to:
  /// **'录音时间太短'**
  String get commonRecordingTooShort;

  /// No description provided for @commonStopRecordingFailed.
  ///
  /// In zh, this message translates to:
  /// **'停止录音失败: {error}'**
  String commonStopRecordingFailed(String error);

  /// No description provided for @chatReleaseToCancel.
  ///
  /// In zh, this message translates to:
  /// **'松开取消'**
  String get chatReleaseToCancel;

  /// No description provided for @chatReleaseToSend.
  ///
  /// In zh, this message translates to:
  /// **'松开发送，上滑取消'**
  String get chatReleaseToSend;

  /// No description provided for @commonHoldToTalk.
  ///
  /// In zh, this message translates to:
  /// **'按住 说话'**
  String get commonHoldToTalk;

  /// No description provided for @commonSend.
  ///
  /// In zh, this message translates to:
  /// **'发送'**
  String get commonSend;

  /// No description provided for @commonAddFriend.
  ///
  /// In zh, this message translates to:
  /// **'添加好友'**
  String get commonAddFriend;

  /// No description provided for @commonChatServiceNotConnected.
  ///
  /// In zh, this message translates to:
  /// **'聊天服务未连接'**
  String get commonChatServiceNotConnected;

  /// No description provided for @contactUserNotFoundHint.
  ///
  /// In zh, this message translates to:
  /// **'未找到用户 \"{query}\"\n\n提示：\n• 尝试输入完整用户ID，如 @username:server.com\n• 确认用户名拼写正确'**
  String contactUserNotFoundHint(String query);

  /// No description provided for @contactCreateChatFailed.
  ///
  /// In zh, this message translates to:
  /// **'创建会话失败: {error}'**
  String contactCreateChatFailed(String error);

  /// No description provided for @contactSearchFailed.
  ///
  /// In zh, this message translates to:
  /// **'搜索失败: {error}'**
  String contactSearchFailed(String error);

  /// No description provided for @contactEnterUserIdOrUsername.
  ///
  /// In zh, this message translates to:
  /// **'输入用户 ID 或用户名搜索'**
  String get contactEnterUserIdOrUsername;

  /// No description provided for @contactSearching.
  ///
  /// In zh, this message translates to:
  /// **'搜索中...'**
  String get contactSearching;

  /// No description provided for @contactSearchUserToChat.
  ///
  /// In zh, this message translates to:
  /// **'搜索用户开始聊天'**
  String get contactSearchUserToChat;

  /// No description provided for @contactMatrixIdExample.
  ///
  /// In zh, this message translates to:
  /// **'可以输入完整的 Matrix ID\n例如: @user:matrix.n42.network'**
  String get contactMatrixIdExample;

  /// No description provided for @contactUserNotFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到用户 \"{username}\"'**
  String contactUserNotFound(String username);

  /// No description provided for @commonChat.
  ///
  /// In zh, this message translates to:
  /// **'聊天'**
  String get commonChat;

  /// No description provided for @commonSettings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get commonSettings;

  /// No description provided for @profileEditProfile.
  ///
  /// In zh, this message translates to:
  /// **'编辑资料'**
  String get profileEditProfile;

  /// No description provided for @authLogin.
  ///
  /// In zh, this message translates to:
  /// **'登录'**
  String get authLogin;

  /// No description provided for @commonCreateGroup.
  ///
  /// In zh, this message translates to:
  /// **'创建群聊'**
  String get commonCreateGroup;

  /// No description provided for @chatError.
  ///
  /// In zh, this message translates to:
  /// **'错误'**
  String get chatError;

  /// No description provided for @commonTransfer.
  ///
  /// In zh, this message translates to:
  /// **'转账'**
  String get commonTransfer;

  /// No description provided for @commonReceived.
  ///
  /// In zh, this message translates to:
  /// **'已被接收'**
  String get commonReceived;

  /// No description provided for @commonRefunded.
  ///
  /// In zh, this message translates to:
  /// **'已退还'**
  String get commonRefunded;

  /// No description provided for @commonExpired.
  ///
  /// In zh, this message translates to:
  /// **'已过期'**
  String get commonExpired;

  /// No description provided for @chatRedPacketGreeting.
  ///
  /// In zh, this message translates to:
  /// **'恭喜发财，大吉大利'**
  String get chatRedPacketGreeting;

  /// No description provided for @commonN42RedPacket.
  ///
  /// In zh, this message translates to:
  /// **'N42红包'**
  String get commonN42RedPacket;

  /// No description provided for @commonClaimed.
  ///
  /// In zh, this message translates to:
  /// **'已领取'**
  String get commonClaimed;

  /// No description provided for @commonAllClaimed.
  ///
  /// In zh, this message translates to:
  /// **'已被领完'**
  String get commonAllClaimed;

  /// No description provided for @chatReadAloud.
  ///
  /// In zh, this message translates to:
  /// **'朗读'**
  String get chatReadAloud;

  /// No description provided for @chatReply.
  ///
  /// In zh, this message translates to:
  /// **'回复'**
  String get chatReply;

  /// No description provided for @commonEdit.
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get commonEdit;

  /// No description provided for @chatSelectForwardTarget.
  ///
  /// In zh, this message translates to:
  /// **'选择转发对象'**
  String get chatSelectForwardTarget;

  /// No description provided for @commonSendCount.
  ///
  /// In zh, this message translates to:
  /// **'发送({count})'**
  String commonSendCount(int count);

  /// No description provided for @contactN42Id.
  ///
  /// In zh, this message translates to:
  /// **'N42号：{id}'**
  String contactN42Id(String id);

  /// No description provided for @profileN42IdTitle.
  ///
  /// In zh, this message translates to:
  /// **'N42号'**
  String get profileN42IdTitle;

  /// No description provided for @profileN42Bean.
  ///
  /// In zh, this message translates to:
  /// **'N42豆'**
  String get profileN42Bean;

  /// No description provided for @contactFriendInfo.
  ///
  /// In zh, this message translates to:
  /// **'朋友资料'**
  String get contactFriendInfo;

  /// No description provided for @contactFriendInfoDesc.
  ///
  /// In zh, this message translates to:
  /// **'添加朋友的备注名、电话、标签、备忘、照片等，并设置朋友权限。'**
  String get contactFriendInfoDesc;

  /// No description provided for @commonMoments.
  ///
  /// In zh, this message translates to:
  /// **'朋友圈'**
  String get commonMoments;

  /// No description provided for @commonSendMessage.
  ///
  /// In zh, this message translates to:
  /// **'发消息'**
  String get commonSendMessage;

  /// No description provided for @contactAudioVideoCall.
  ///
  /// In zh, this message translates to:
  /// **'音视频通话'**
  String get contactAudioVideoCall;

  /// No description provided for @contactVideoChannel.
  ///
  /// In zh, this message translates to:
  /// **'视频号'**
  String get contactVideoChannel;

  /// No description provided for @contactRemark.
  ///
  /// In zh, this message translates to:
  /// **'备注'**
  String get contactRemark;

  /// No description provided for @contactRemarkName.
  ///
  /// In zh, this message translates to:
  /// **'备注名'**
  String get contactRemarkName;

  /// No description provided for @contactPhone.
  ///
  /// In zh, this message translates to:
  /// **'电话'**
  String get contactPhone;

  /// No description provided for @contactTags.
  ///
  /// In zh, this message translates to:
  /// **'标签'**
  String get contactTags;

  /// No description provided for @contactNotes.
  ///
  /// In zh, this message translates to:
  /// **'备忘'**
  String get contactNotes;

  /// No description provided for @contactPhotos.
  ///
  /// In zh, this message translates to:
  /// **'照片'**
  String get contactPhotos;

  /// No description provided for @contactPermissions.
  ///
  /// In zh, this message translates to:
  /// **'权限'**
  String get contactPermissions;

  /// No description provided for @contactChatMomentsEtc.
  ///
  /// In zh, this message translates to:
  /// **'聊天、朋友圈、运动等'**
  String get contactChatMomentsEtc;

  /// No description provided for @contactMoreInfo.
  ///
  /// In zh, this message translates to:
  /// **'更多信息'**
  String get contactMoreInfo;

  /// No description provided for @contactCommonGroups.
  ///
  /// In zh, this message translates to:
  /// **'我和他 (她) 的共同群聊'**
  String get contactCommonGroups;

  /// No description provided for @contactSource.
  ///
  /// In zh, this message translates to:
  /// **'来源'**
  String get contactSource;

  /// No description provided for @settingsNotificationSettings.
  ///
  /// In zh, this message translates to:
  /// **'消息通知'**
  String get settingsNotificationSettings;

  /// No description provided for @settingsPrivacy.
  ///
  /// In zh, this message translates to:
  /// **'隐私'**
  String get settingsPrivacy;

  /// No description provided for @settingsAppearance.
  ///
  /// In zh, this message translates to:
  /// **'外观'**
  String get settingsAppearance;

  /// No description provided for @settingsAbout.
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get settingsAbout;

  /// No description provided for @commonLogout.
  ///
  /// In zh, this message translates to:
  /// **'退出登录'**
  String get commonLogout;

  /// No description provided for @commonLogoutConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要退出登录吗？'**
  String get commonLogoutConfirm;

  /// No description provided for @commonSave.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get commonSave;

  /// No description provided for @profileNickname.
  ///
  /// In zh, this message translates to:
  /// **'昵称'**
  String get profileNickname;

  /// No description provided for @profileEnterNickname.
  ///
  /// In zh, this message translates to:
  /// **'请输入昵称'**
  String get profileEnterNickname;

  /// No description provided for @profileSignature.
  ///
  /// In zh, this message translates to:
  /// **'签名'**
  String get profileSignature;

  /// No description provided for @profileAddSignature.
  ///
  /// In zh, this message translates to:
  /// **'添加个性签名'**
  String get profileAddSignature;

  /// No description provided for @commonTakePhoto.
  ///
  /// In zh, this message translates to:
  /// **'拍照'**
  String get commonTakePhoto;

  /// No description provided for @profileChooseFromGallery.
  ///
  /// In zh, this message translates to:
  /// **'从相册选择'**
  String get profileChooseFromGallery;

  /// No description provided for @profileSaveFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存失败: {error}'**
  String profileSaveFailed(String error);

  /// No description provided for @authSecureDecentralizedChat.
  ///
  /// In zh, this message translates to:
  /// **'安全、去中心化的即时通讯'**
  String get authSecureDecentralizedChat;

  /// No description provided for @commonEndToEndEncryption.
  ///
  /// In zh, this message translates to:
  /// **'端到端加密'**
  String get commonEndToEndEncryption;

  /// No description provided for @authMessagesOnlyYouCanSee.
  ///
  /// In zh, this message translates to:
  /// **'消息仅你和对方可见'**
  String get authMessagesOnlyYouCanSee;

  /// No description provided for @authDecentralized.
  ///
  /// In zh, this message translates to:
  /// **'去中心化'**
  String get authDecentralized;

  /// No description provided for @authBasedOnMatrix.
  ///
  /// In zh, this message translates to:
  /// **'基于Matrix开放协议'**
  String get authBasedOnMatrix;

  /// No description provided for @authWalletIntegration.
  ///
  /// In zh, this message translates to:
  /// **'钱包集成'**
  String get authWalletIntegration;

  /// No description provided for @authEasyCryptoTransfer.
  ///
  /// In zh, this message translates to:
  /// **'轻松进行加密货币转账'**
  String get authEasyCryptoTransfer;

  /// No description provided for @authRegister.
  ///
  /// In zh, this message translates to:
  /// **'注册'**
  String get authRegister;

  /// No description provided for @authAgreeTerms.
  ///
  /// In zh, this message translates to:
  /// **'登录即表示同意'**
  String get authAgreeTerms;

  /// No description provided for @authTermsOfService.
  ///
  /// In zh, this message translates to:
  /// **'《服务协议》'**
  String get authTermsOfService;

  /// No description provided for @authAnd.
  ///
  /// In zh, this message translates to:
  /// **'和'**
  String get authAnd;

  /// No description provided for @authPrivacyPolicy.
  ///
  /// In zh, this message translates to:
  /// **'《隐私政策》'**
  String get authPrivacyPolicy;

  /// No description provided for @authServerAddress.
  ///
  /// In zh, this message translates to:
  /// **'服务器地址'**
  String get authServerAddress;

  /// No description provided for @authEnterServerAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入服务器地址'**
  String get authEnterServerAddress;

  /// No description provided for @authConnectedTo.
  ///
  /// In zh, this message translates to:
  /// **'已连接到 {serverName}'**
  String authConnectedTo(String serverName);

  /// No description provided for @authUsername.
  ///
  /// In zh, this message translates to:
  /// **'用户名'**
  String get authUsername;

  /// No description provided for @authEnterUsername.
  ///
  /// In zh, this message translates to:
  /// **'请输入用户名'**
  String get authEnterUsername;

  /// No description provided for @authPassword.
  ///
  /// In zh, this message translates to:
  /// **'密码'**
  String get authPassword;

  /// No description provided for @authEnterPassword.
  ///
  /// In zh, this message translates to:
  /// **'请输入密码'**
  String get authEnterPassword;

  /// No description provided for @authRegisterAccount.
  ///
  /// In zh, this message translates to:
  /// **'注册账号'**
  String get authRegisterAccount;

  /// No description provided for @authForgotPassword.
  ///
  /// In zh, this message translates to:
  /// **'忘记密码'**
  String get authForgotPassword;

  /// No description provided for @authOtherLoginMethods.
  ///
  /// In zh, this message translates to:
  /// **'其他登录方式'**
  String get authOtherLoginMethods;

  /// No description provided for @authCreateAccount.
  ///
  /// In zh, this message translates to:
  /// **'创建账号'**
  String get authCreateAccount;

  /// No description provided for @authJoinN42Chat.
  ///
  /// In zh, this message translates to:
  /// **'加入 N42 Chat 开始聊天'**
  String get authJoinN42Chat;

  /// No description provided for @authUsernameHint.
  ///
  /// In zh, this message translates to:
  /// **'3-20字符，字母/数字/_'**
  String get authUsernameHint;

  /// No description provided for @authUsernameMinLength.
  ///
  /// In zh, this message translates to:
  /// **'用户名至少3个字符'**
  String get authUsernameMinLength;

  /// No description provided for @authUsernameMaxLength.
  ///
  /// In zh, this message translates to:
  /// **'用户名最多20个字符'**
  String get authUsernameMaxLength;

  /// No description provided for @authUsernameFormat.
  ///
  /// In zh, this message translates to:
  /// **'用户名只能包含字母、数字和下划线'**
  String get authUsernameFormat;

  /// No description provided for @authPasswordHint.
  ///
  /// In zh, this message translates to:
  /// **'至少8位'**
  String get authPasswordHint;

  /// No description provided for @commonPasswordMinLength.
  ///
  /// In zh, this message translates to:
  /// **'密码至少8位'**
  String get commonPasswordMinLength;

  /// No description provided for @authConfirmPassword.
  ///
  /// In zh, this message translates to:
  /// **'确认密码'**
  String get authConfirmPassword;

  /// No description provided for @authFilled.
  ///
  /// In zh, this message translates to:
  /// **'已填写'**
  String get authFilled;

  /// No description provided for @authEnterInviteCode.
  ///
  /// In zh, this message translates to:
  /// **'请输入邀请码'**
  String get authEnterInviteCode;

  /// No description provided for @authAlreadyHaveAccount.
  ///
  /// In zh, this message translates to:
  /// **'已有账号？'**
  String get authAlreadyHaveAccount;

  /// No description provided for @authLoginNow.
  ///
  /// In zh, this message translates to:
  /// **'立即登录'**
  String get authLoginNow;

  /// No description provided for @profileAvatar.
  ///
  /// In zh, this message translates to:
  /// **'头像'**
  String get profileAvatar;

  /// No description provided for @profileStatus.
  ///
  /// In zh, this message translates to:
  /// **'状态'**
  String get profileStatus;

  /// No description provided for @commonLoading.
  ///
  /// In zh, this message translates to:
  /// **'加载中...'**
  String get commonLoading;

  /// No description provided for @conversationNoConversations.
  ///
  /// In zh, this message translates to:
  /// **'暂无会话'**
  String get conversationNoConversations;

  /// No description provided for @conversationTapToChat.
  ///
  /// In zh, this message translates to:
  /// **'点击右上角开始聊天'**
  String get conversationTapToChat;

  /// No description provided for @conversationStartGroup.
  ///
  /// In zh, this message translates to:
  /// **'发起群聊'**
  String get conversationStartGroup;

  /// No description provided for @commonScan.
  ///
  /// In zh, this message translates to:
  /// **'扫一扫'**
  String get commonScan;

  /// No description provided for @commonPayment.
  ///
  /// In zh, this message translates to:
  /// **'收付款'**
  String get commonPayment;

  /// No description provided for @commonFeatureComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'{feature} 功能即将推出'**
  String commonFeatureComingSoon(String feature);

  /// No description provided for @conversationMarkAsRead.
  ///
  /// In zh, this message translates to:
  /// **'标记已读'**
  String get conversationMarkAsRead;

  /// No description provided for @commonUnmute.
  ///
  /// In zh, this message translates to:
  /// **'取消静音'**
  String get commonUnmute;

  /// No description provided for @commonMute.
  ///
  /// In zh, this message translates to:
  /// **'消息免打扰'**
  String get commonMute;

  /// No description provided for @conversationUnpin.
  ///
  /// In zh, this message translates to:
  /// **'取消置顶'**
  String get conversationUnpin;

  /// No description provided for @conversationPin.
  ///
  /// In zh, this message translates to:
  /// **'置顶'**
  String get conversationPin;

  /// No description provided for @conversationDeleteConversation.
  ///
  /// In zh, this message translates to:
  /// **'删除会话'**
  String get conversationDeleteConversation;

  /// No description provided for @conversationDeleteConversationConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除与 {name} 的会话吗？'**
  String conversationDeleteConversationConfirm(String name);

  /// No description provided for @commonNoContacts.
  ///
  /// In zh, this message translates to:
  /// **'暂无联系人'**
  String get commonNoContacts;

  /// No description provided for @contactAddFriendsToChat.
  ///
  /// In zh, this message translates to:
  /// **'添加好友开始聊天'**
  String get contactAddFriendsToChat;

  /// No description provided for @contactNotFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到联系人'**
  String get contactNotFound;

  /// No description provided for @contactTryOtherKeywords.
  ///
  /// In zh, this message translates to:
  /// **'尝试搜索其他关键词或全局搜索'**
  String get contactTryOtherKeywords;

  /// No description provided for @contactSearchResults.
  ///
  /// In zh, this message translates to:
  /// **'搜索结果'**
  String get contactSearchResults;

  /// No description provided for @contactNewFriends.
  ///
  /// In zh, this message translates to:
  /// **'新的朋友'**
  String get contactNewFriends;

  /// No description provided for @contactChatOnlyFriends.
  ///
  /// In zh, this message translates to:
  /// **'仅聊天的朋友'**
  String get contactChatOnlyFriends;

  /// No description provided for @contactOfficialAccounts.
  ///
  /// In zh, this message translates to:
  /// **'公众号'**
  String get contactOfficialAccounts;

  /// No description provided for @contactServiceAccounts.
  ///
  /// In zh, this message translates to:
  /// **'服务号'**
  String get contactServiceAccounts;

  /// No description provided for @contactEnterpriseContacts.
  ///
  /// In zh, this message translates to:
  /// **'企业联系人'**
  String get contactEnterpriseContacts;

  /// No description provided for @contactRecommendToFriend.
  ///
  /// In zh, this message translates to:
  /// **'推荐给朋友'**
  String get contactRecommendToFriend;

  /// No description provided for @commonSetRemark.
  ///
  /// In zh, this message translates to:
  /// **'设置备注'**
  String get commonSetRemark;

  /// No description provided for @contactSendingCard.
  ///
  /// In zh, this message translates to:
  /// **'正在发送名片...'**
  String get contactSendingCard;

  /// No description provided for @commonFileLabel.
  ///
  /// In zh, this message translates to:
  /// **'文件'**
  String get commonFileLabel;

  /// No description provided for @commonLocationLabel.
  ///
  /// In zh, this message translates to:
  /// **'位置'**
  String get commonLocationLabel;

  /// No description provided for @contactRecommendFailed.
  ///
  /// In zh, this message translates to:
  /// **'推荐失败: {error}'**
  String contactRecommendFailed(String error);

  /// No description provided for @profileEnterRemark.
  ///
  /// In zh, this message translates to:
  /// **'请输入备注名'**
  String get profileEnterRemark;

  /// No description provided for @contactOpeningChat.
  ///
  /// In zh, this message translates to:
  /// **'正在打开聊天...'**
  String get contactOpeningChat;

  /// No description provided for @contactOpenChatFailed.
  ///
  /// In zh, this message translates to:
  /// **'打开聊天失败: {error}'**
  String contactOpenChatFailed(String error);

  /// No description provided for @contactAddContact.
  ///
  /// In zh, this message translates to:
  /// **'添加联系人'**
  String get contactAddContact;

  /// No description provided for @contactEnterUserId.
  ///
  /// In zh, this message translates to:
  /// **'输入用户ID'**
  String get contactEnterUserId;

  /// No description provided for @contactNoFriendRequests.
  ///
  /// In zh, this message translates to:
  /// **'暂无好友请求'**
  String get contactNoFriendRequests;

  /// No description provided for @commonAccept.
  ///
  /// In zh, this message translates to:
  /// **'接受'**
  String get commonAccept;

  /// No description provided for @commonReject.
  ///
  /// In zh, this message translates to:
  /// **'拒绝'**
  String get commonReject;

  /// No description provided for @commonNoGroups.
  ///
  /// In zh, this message translates to:
  /// **'暂无群聊'**
  String get commonNoGroups;

  /// No description provided for @contactSelectFriendToRecommend.
  ///
  /// In zh, this message translates to:
  /// **'选择要推荐给的朋友'**
  String get contactSelectFriendToRecommend;

  /// No description provided for @commonSearchContacts.
  ///
  /// In zh, this message translates to:
  /// **'搜索联系人'**
  String get commonSearchContacts;

  /// No description provided for @contactNoContactsFound.
  ///
  /// In zh, this message translates to:
  /// **'没有找到联系人'**
  String get contactNoContactsFound;

  /// No description provided for @favoriteYesterday.
  ///
  /// In zh, this message translates to:
  /// **'昨天'**
  String get favoriteYesterday;

  /// No description provided for @chatJustNow.
  ///
  /// In zh, this message translates to:
  /// **'刚刚'**
  String get chatJustNow;

  /// No description provided for @profileOnline.
  ///
  /// In zh, this message translates to:
  /// **'在线'**
  String get profileOnline;

  /// No description provided for @profileOffline.
  ///
  /// In zh, this message translates to:
  /// **'离线'**
  String get profileOffline;

  /// No description provided for @searchContactsGroupsMessages.
  ///
  /// In zh, this message translates to:
  /// **'搜索联系人、群聊和消息'**
  String get searchContactsGroupsMessages;

  /// No description provided for @searchError.
  ///
  /// In zh, this message translates to:
  /// **'搜索出错'**
  String get searchError;

  /// No description provided for @chatSearchHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索'**
  String get chatSearchHint;

  /// No description provided for @searchHistory.
  ///
  /// In zh, this message translates to:
  /// **'搜索历史'**
  String get searchHistory;

  /// No description provided for @commonClear.
  ///
  /// In zh, this message translates to:
  /// **'清除'**
  String get commonClear;

  /// No description provided for @commonAll.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get commonAll;

  /// No description provided for @searchGroups.
  ///
  /// In zh, this message translates to:
  /// **'群聊'**
  String get searchGroups;

  /// No description provided for @searchNoResults.
  ///
  /// In zh, this message translates to:
  /// **'无结果'**
  String get searchNoResults;

  /// No description provided for @commonGroupMembers.
  ///
  /// In zh, this message translates to:
  /// **'群成员 ({count})'**
  String commonGroupMembers(int count);

  /// No description provided for @groupMembersTitle.
  ///
  /// In zh, this message translates to:
  /// **'群成员'**
  String get groupMembersTitle;

  /// No description provided for @groupViewAll.
  ///
  /// In zh, this message translates to:
  /// **'查看全部'**
  String get groupViewAll;

  /// No description provided for @groupOwner.
  ///
  /// In zh, this message translates to:
  /// **'群主'**
  String get groupOwner;

  /// No description provided for @groupAdmin.
  ///
  /// In zh, this message translates to:
  /// **'管理'**
  String get groupAdmin;

  /// No description provided for @groupInvite.
  ///
  /// In zh, this message translates to:
  /// **'邀请'**
  String get groupInvite;

  /// No description provided for @commonGroupAnnouncement.
  ///
  /// In zh, this message translates to:
  /// **'群公告'**
  String get commonGroupAnnouncement;

  /// No description provided for @commonNotSet.
  ///
  /// In zh, this message translates to:
  /// **'未设置'**
  String get commonNotSet;

  /// No description provided for @groupDescription.
  ///
  /// In zh, this message translates to:
  /// **'群简介'**
  String get groupDescription;

  /// No description provided for @groupPublicGroup.
  ///
  /// In zh, this message translates to:
  /// **'公开群聊'**
  String get groupPublicGroup;

  /// No description provided for @commonClearChatHistory.
  ///
  /// In zh, this message translates to:
  /// **'清空聊天记录'**
  String get commonClearChatHistory;

  /// No description provided for @commonDissolveGroup.
  ///
  /// In zh, this message translates to:
  /// **'解散群聊'**
  String get commonDissolveGroup;

  /// No description provided for @commonLeaveGroup.
  ///
  /// In zh, this message translates to:
  /// **'退出群聊'**
  String get commonLeaveGroup;

  /// No description provided for @groupChangeGroupName.
  ///
  /// In zh, this message translates to:
  /// **'修改群名称'**
  String get groupChangeGroupName;

  /// No description provided for @commonEnterGroupName.
  ///
  /// In zh, this message translates to:
  /// **'请输入群名称'**
  String get commonEnterGroupName;

  /// No description provided for @commonConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认'**
  String get commonConfirm;

  /// No description provided for @groupEnterGroupDescription.
  ///
  /// In zh, this message translates to:
  /// **'请输入群简介'**
  String get groupEnterGroupDescription;

  /// No description provided for @groupPublish.
  ///
  /// In zh, this message translates to:
  /// **'发布'**
  String get groupPublish;

  /// No description provided for @chatClearHistoryConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要清空聊天记录吗？此操作不可恢复。'**
  String get chatClearHistoryConfirm;

  /// No description provided for @chatClearAction.
  ///
  /// In zh, this message translates to:
  /// **'清空'**
  String get chatClearAction;

  /// No description provided for @commonChatHistoryCleared.
  ///
  /// In zh, this message translates to:
  /// **'聊天记录已清空'**
  String get commonChatHistoryCleared;

  /// No description provided for @commonDissolve.
  ///
  /// In zh, this message translates to:
  /// **'解散'**
  String get commonDissolve;

  /// No description provided for @groupQrCode.
  ///
  /// In zh, this message translates to:
  /// **'群二维码'**
  String get groupQrCode;

  /// No description provided for @commonSearchChatHistory.
  ///
  /// In zh, this message translates to:
  /// **'查找聊天记录'**
  String get commonSearchChatHistory;

  /// No description provided for @groupIdCopied.
  ///
  /// In zh, this message translates to:
  /// **'群ID已复制'**
  String get groupIdCopied;

  /// No description provided for @transferEnterOrPasteAddress.
  ///
  /// In zh, this message translates to:
  /// **'输入或粘贴钱包地址'**
  String get transferEnterOrPasteAddress;

  /// No description provided for @transferSelectToken.
  ///
  /// In zh, this message translates to:
  /// **'选择代币'**
  String get transferSelectToken;

  /// No description provided for @commonTransferAmount.
  ///
  /// In zh, this message translates to:
  /// **'转账金额'**
  String get commonTransferAmount;

  /// No description provided for @transferAvailable.
  ///
  /// In zh, this message translates to:
  /// **'可用'**
  String get transferAvailable;

  /// No description provided for @transferMemoOptional.
  ///
  /// In zh, this message translates to:
  /// **'备注（可选）'**
  String get transferMemoOptional;

  /// No description provided for @transferConfirmTransfer.
  ///
  /// In zh, this message translates to:
  /// **'确认转账'**
  String get transferConfirmTransfer;

  /// No description provided for @transferAddressVerified.
  ///
  /// In zh, this message translates to:
  /// **'地址已验证'**
  String get transferAddressVerified;

  /// No description provided for @transferAvailableBalance.
  ///
  /// In zh, this message translates to:
  /// **'可用余额: {balance} {symbol}'**
  String transferAvailableBalance(String balance, String symbol);

  /// No description provided for @commonEnterAmount.
  ///
  /// In zh, this message translates to:
  /// **'请输入金额'**
  String get commonEnterAmount;

  /// No description provided for @commonRedPacketCountMin.
  ///
  /// In zh, this message translates to:
  /// **'红包个数至少为1'**
  String get commonRedPacketCountMin;

  /// No description provided for @commonViewRedPacketDetails.
  ///
  /// In zh, this message translates to:
  /// **'查看红包详情'**
  String get commonViewRedPacketDetails;

  /// No description provided for @commonEnterTransferAmount.
  ///
  /// In zh, this message translates to:
  /// **'请输入转账金额'**
  String get commonEnterTransferAmount;

  /// No description provided for @commonTransferTo.
  ///
  /// In zh, this message translates to:
  /// **'转账给'**
  String get commonTransferTo;

  /// No description provided for @commonFromSender.
  ///
  /// In zh, this message translates to:
  /// **'来自 {name}'**
  String commonFromSender(String name, Object senderName);

  /// No description provided for @commonConfirmReceive.
  ///
  /// In zh, this message translates to:
  /// **'确认收款'**
  String get commonConfirmReceive;

  /// No description provided for @groupProfile.
  ///
  /// In zh, this message translates to:
  /// **'群资料'**
  String get groupProfile;

  /// No description provided for @groupRemoveMember.
  ///
  /// In zh, this message translates to:
  /// **'移出群聊'**
  String get groupRemoveMember;

  /// No description provided for @commonRemove.
  ///
  /// In zh, this message translates to:
  /// **'移出'**
  String get commonRemove;

  /// No description provided for @profileClearStatus.
  ///
  /// In zh, this message translates to:
  /// **'清除状态'**
  String get profileClearStatus;

  /// No description provided for @profileClearStatusConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要清除当前状态吗？'**
  String get profileClearStatusConfirm;

  /// No description provided for @profileStatusCleared.
  ///
  /// In zh, this message translates to:
  /// **'状态已清除'**
  String get profileStatusCleared;

  /// No description provided for @profileUserNotExist.
  ///
  /// In zh, this message translates to:
  /// **'用户不存在'**
  String get profileUserNotExist;

  /// No description provided for @profileUserIdCopied.
  ///
  /// In zh, this message translates to:
  /// **'用户ID已复制'**
  String get profileUserIdCopied;

  /// No description provided for @commonReport.
  ///
  /// In zh, this message translates to:
  /// **'举报'**
  String get commonReport;

  /// No description provided for @profileQrCode.
  ///
  /// In zh, this message translates to:
  /// **'二维码'**
  String get profileQrCode;

  /// No description provided for @profileAvatarUpdated.
  ///
  /// In zh, this message translates to:
  /// **'头像更新成功'**
  String get profileAvatarUpdated;

  /// No description provided for @commonSelectImageFailed.
  ///
  /// In zh, this message translates to:
  /// **'选择图片失败: {error}'**
  String commonSelectImageFailed(String error);

  /// No description provided for @profileChangeName.
  ///
  /// In zh, this message translates to:
  /// **'修改名字'**
  String get profileChangeName;

  /// No description provided for @profileMale.
  ///
  /// In zh, this message translates to:
  /// **'男'**
  String get profileMale;

  /// No description provided for @profileFemale.
  ///
  /// In zh, this message translates to:
  /// **'女'**
  String get profileFemale;

  /// No description provided for @chatFeatureInDev.
  ///
  /// In zh, this message translates to:
  /// **'{feature}功能开发中...'**
  String chatFeatureInDev(String feature);

  /// No description provided for @profileSaveAddressFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存地址失败: {error}'**
  String profileSaveAddressFailed(String error);

  /// No description provided for @profileAddNew.
  ///
  /// In zh, this message translates to:
  /// **'新增'**
  String get profileAddNew;

  /// No description provided for @profileAddAddress.
  ///
  /// In zh, this message translates to:
  /// **'添加地址'**
  String get profileAddAddress;

  /// No description provided for @profileAddressAdded.
  ///
  /// In zh, this message translates to:
  /// **'地址添加成功'**
  String get profileAddressAdded;

  /// No description provided for @profileAddressUpdated.
  ///
  /// In zh, this message translates to:
  /// **'地址更新成功'**
  String get profileAddressUpdated;

  /// No description provided for @profileDeleteAddress.
  ///
  /// In zh, this message translates to:
  /// **'删除地址'**
  String get profileDeleteAddress;

  /// No description provided for @profileAddressDeleted.
  ///
  /// In zh, this message translates to:
  /// **'地址已删除'**
  String get profileAddressDeleted;

  /// No description provided for @profileSaveInvoiceFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存发票抬头失败: {error}'**
  String profileSaveInvoiceFailed(String error);

  /// No description provided for @profileMyInvoices.
  ///
  /// In zh, this message translates to:
  /// **'我的发票抬头'**
  String get profileMyInvoices;

  /// No description provided for @profileAddInvoice.
  ///
  /// In zh, this message translates to:
  /// **'添加发票抬头'**
  String get profileAddInvoice;

  /// No description provided for @profileInvoiceAdded.
  ///
  /// In zh, this message translates to:
  /// **'发票抬头添加成功'**
  String get profileInvoiceAdded;

  /// No description provided for @profileInvoiceUpdated.
  ///
  /// In zh, this message translates to:
  /// **'发票抬头更新成功'**
  String get profileInvoiceUpdated;

  /// No description provided for @profileDeleteInvoice.
  ///
  /// In zh, this message translates to:
  /// **'删除发票抬头'**
  String get profileDeleteInvoice;

  /// No description provided for @profileInvoiceDeleted.
  ///
  /// In zh, this message translates to:
  /// **'发票抬头已删除'**
  String get profileInvoiceDeleted;

  /// No description provided for @profilePersonal.
  ///
  /// In zh, this message translates to:
  /// **'个人'**
  String get profilePersonal;

  /// No description provided for @groupSelectAtLeastOne.
  ///
  /// In zh, this message translates to:
  /// **'请至少选择一位成员'**
  String get groupSelectAtLeastOne;

  /// No description provided for @chatFileNotExist.
  ///
  /// In zh, this message translates to:
  /// **'文件不存在'**
  String get chatFileNotExist;

  /// No description provided for @chatSendFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送失败: {error}'**
  String chatSendFailed(String error);

  /// No description provided for @chatCannotOpenBrowser.
  ///
  /// In zh, this message translates to:
  /// **'无法打开浏览器'**
  String get chatCannotOpenBrowser;

  /// No description provided for @chatSelectFileFailed.
  ///
  /// In zh, this message translates to:
  /// **'选择文件失败: {error}'**
  String chatSelectFileFailed(String error);

  /// No description provided for @settingsSetupFailed.
  ///
  /// In zh, this message translates to:
  /// **'设置失败: {error}'**
  String settingsSetupFailed(String error);

  /// No description provided for @transferEnterValidAmount.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的转账金额'**
  String get transferEnterValidAmount;

  /// No description provided for @commonAddressCopied.
  ///
  /// In zh, this message translates to:
  /// **'地址已复制'**
  String get commonAddressCopied;

  /// No description provided for @favoriteOpenItem.
  ///
  /// In zh, this message translates to:
  /// **'打开: {content}'**
  String favoriteOpenItem(String content);

  /// No description provided for @favoriteDeleted.
  ///
  /// In zh, this message translates to:
  /// **'已删除'**
  String get favoriteDeleted;

  /// No description provided for @profileWallet.
  ///
  /// In zh, this message translates to:
  /// **'钱包'**
  String get profileWallet;

  /// No description provided for @chatRecording.
  ///
  /// In zh, this message translates to:
  /// **'录像'**
  String get chatRecording;

  /// No description provided for @chatInvalidVideoUrl.
  ///
  /// In zh, this message translates to:
  /// **'无效的视频链接'**
  String get chatInvalidVideoUrl;

  /// No description provided for @chatDownloadFile.
  ///
  /// In zh, this message translates to:
  /// **'下载文件'**
  String get chatDownloadFile;

  /// No description provided for @chatClearChatHistoryTitle.
  ///
  /// In zh, this message translates to:
  /// **'清空聊天记录'**
  String get chatClearChatHistoryTitle;

  /// No description provided for @chatVideoCall.
  ///
  /// In zh, this message translates to:
  /// **'视频通话'**
  String get chatVideoCall;

  /// No description provided for @commonVoiceCall.
  ///
  /// In zh, this message translates to:
  /// **'语音通话'**
  String get commonVoiceCall;

  /// No description provided for @callLeaveMeeting.
  ///
  /// In zh, this message translates to:
  /// **'离开会议'**
  String get callLeaveMeeting;

  /// No description provided for @chatDetails.
  ///
  /// In zh, this message translates to:
  /// **'聊天详情'**
  String get chatDetails;

  /// No description provided for @chatViewAllGroupMembers.
  ///
  /// In zh, this message translates to:
  /// **'查看全部群成员'**
  String get chatViewAllGroupMembers;

  /// No description provided for @chatGroupName.
  ///
  /// In zh, this message translates to:
  /// **'群聊名称'**
  String get chatGroupName;

  /// No description provided for @chatGroupNameUpdated.
  ///
  /// In zh, this message translates to:
  /// **'群名称已更新'**
  String get chatGroupNameUpdated;

  /// No description provided for @chatUpdateFailed.
  ///
  /// In zh, this message translates to:
  /// **'更新失败'**
  String get chatUpdateFailed;

  /// No description provided for @chatNoPermissionToModify.
  ///
  /// In zh, this message translates to:
  /// **'您没有修改权限'**
  String get chatNoPermissionToModify;

  /// No description provided for @chatGroupManagement.
  ///
  /// In zh, this message translates to:
  /// **'群管理'**
  String get chatGroupManagement;

  /// No description provided for @chatMyNicknameInGroup.
  ///
  /// In zh, this message translates to:
  /// **'我在本群的昵称'**
  String get chatMyNicknameInGroup;

  /// No description provided for @chatPinChat.
  ///
  /// In zh, this message translates to:
  /// **'置顶聊天'**
  String get chatPinChat;

  /// No description provided for @chatStrongReminder.
  ///
  /// In zh, this message translates to:
  /// **'强提醒'**
  String get chatStrongReminder;

  /// No description provided for @chatSetChatBackground.
  ///
  /// In zh, this message translates to:
  /// **'设置当前聊天背景'**
  String get chatSetChatBackground;

  /// No description provided for @chatUnknownFile.
  ///
  /// In zh, this message translates to:
  /// **'未知文件'**
  String get chatUnknownFile;

  /// No description provided for @chatDownload.
  ///
  /// In zh, this message translates to:
  /// **'下载'**
  String get chatDownload;

  /// No description provided for @chatInvalidLocation.
  ///
  /// In zh, this message translates to:
  /// **'无效的位置'**
  String get chatInvalidLocation;

  /// No description provided for @chatTapToCancel.
  ///
  /// In zh, this message translates to:
  /// **'点击取消'**
  String get chatTapToCancel;

  /// No description provided for @chatCaptureFailed.
  ///
  /// In zh, this message translates to:
  /// **'拍摄失败: {error}'**
  String chatCaptureFailed(Object error);

  /// No description provided for @chatProcessingVideo.
  ///
  /// In zh, this message translates to:
  /// **'正在处理视频...'**
  String get chatProcessingVideo;

  /// No description provided for @chatVideoFileNotExist.
  ///
  /// In zh, this message translates to:
  /// **'视频文件不存在'**
  String get chatVideoFileNotExist;

  /// No description provided for @chatVideoDataEmpty.
  ///
  /// In zh, this message translates to:
  /// **'视频数据为空'**
  String get chatVideoDataEmpty;

  /// No description provided for @chatVideoTooLarge.
  ///
  /// In zh, this message translates to:
  /// **'视频大小不能超过 100MB'**
  String get chatVideoTooLarge;

  /// No description provided for @chatSendingVideo.
  ///
  /// In zh, this message translates to:
  /// **'视频发送中...'**
  String get chatSendingVideo;

  /// No description provided for @chatSendVideoFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送视频失败: {error}'**
  String chatSendVideoFailed(Object error);

  /// No description provided for @chatImageFileNotExist.
  ///
  /// In zh, this message translates to:
  /// **'图片文件不存在'**
  String get chatImageFileNotExist;

  /// No description provided for @commonImageDataEmpty.
  ///
  /// In zh, this message translates to:
  /// **'图片数据为空'**
  String get commonImageDataEmpty;

  /// No description provided for @chatSendingImage.
  ///
  /// In zh, this message translates to:
  /// **'图片发送中...'**
  String get chatSendingImage;

  /// No description provided for @chatSendImageFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送图片失败: {error}'**
  String chatSendImageFailed(Object error);

  /// No description provided for @chatSendLocation.
  ///
  /// In zh, this message translates to:
  /// **'发送位置'**
  String get chatSendLocation;

  /// No description provided for @chatSelectLocationAndSend.
  ///
  /// In zh, this message translates to:
  /// **'选择地点并发送给对方'**
  String get chatSelectLocationAndSend;

  /// No description provided for @chatShareRealTimeLocation.
  ///
  /// In zh, this message translates to:
  /// **'共享实时位置'**
  String get chatShareRealTimeLocation;

  /// No description provided for @chatShareLocationForOneHour.
  ///
  /// In zh, this message translates to:
  /// **'与好友共享1小时实时位置'**
  String get chatShareLocationForOneHour;

  /// No description provided for @chatLocationSent.
  ///
  /// In zh, this message translates to:
  /// **'位置已发送'**
  String get chatLocationSent;

  /// No description provided for @chatSelectMessages.
  ///
  /// In zh, this message translates to:
  /// **'选择消息'**
  String get chatSelectMessages;

  /// No description provided for @chatSelectedCount.
  ///
  /// In zh, this message translates to:
  /// **'已选择 {count}'**
  String chatSelectedCount(int count);

  /// No description provided for @chatSelectAll.
  ///
  /// In zh, this message translates to:
  /// **'全选'**
  String get chatSelectAll;

  /// No description provided for @chatGroupChatCount.
  ///
  /// In zh, this message translates to:
  /// **'群聊({count})'**
  String chatGroupChatCount(int count);

  /// No description provided for @chatPrivateChat.
  ///
  /// In zh, this message translates to:
  /// **'私聊'**
  String get chatPrivateChat;

  /// No description provided for @chatNoMessages.
  ///
  /// In zh, this message translates to:
  /// **'暂无消息'**
  String get chatNoMessages;

  /// No description provided for @chatSendFirstMessage.
  ///
  /// In zh, this message translates to:
  /// **'发送第一条消息开始聊天'**
  String get chatSendFirstMessage;

  /// No description provided for @chatEncryptionNotice.
  ///
  /// In zh, this message translates to:
  /// **'此聊天已启用端到端加密。只有您和对方可以阅读消息。'**
  String get chatEncryptionNotice;

  /// No description provided for @chatMultiForward.
  ///
  /// In zh, this message translates to:
  /// **'转发'**
  String get chatMultiForward;

  /// No description provided for @chatCollect.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get chatCollect;

  /// No description provided for @chatNoMembers.
  ///
  /// In zh, this message translates to:
  /// **'没有成员'**
  String get chatNoMembers;

  /// No description provided for @chatMemberNotFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到成员'**
  String get chatMemberNotFound;

  /// No description provided for @chatVoiceFileNotExist.
  ///
  /// In zh, this message translates to:
  /// **'语音文件不存在'**
  String get chatVoiceFileNotExist;

  /// No description provided for @chatVoiceFileEmpty.
  ///
  /// In zh, this message translates to:
  /// **'语音文件为空'**
  String get chatVoiceFileEmpty;

  /// No description provided for @chatSendingVoice.
  ///
  /// In zh, this message translates to:
  /// **'语音发送中...'**
  String get chatSendingVoice;

  /// No description provided for @chatSendVoiceFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送语音失败: {error}'**
  String chatSendVoiceFailed(Object error);

  /// No description provided for @chatMessageForwarded.
  ///
  /// In zh, this message translates to:
  /// **'消息已转发'**
  String get chatMessageForwarded;

  /// No description provided for @chatForwardFailed.
  ///
  /// In zh, this message translates to:
  /// **'转发失败: {error}'**
  String chatForwardFailed(Object error);

  /// No description provided for @chatUnfavorited.
  ///
  /// In zh, this message translates to:
  /// **'已取消收藏'**
  String get chatUnfavorited;

  /// No description provided for @chatFavorited.
  ///
  /// In zh, this message translates to:
  /// **'已收藏'**
  String get chatFavorited;

  /// No description provided for @chatReactionAdded.
  ///
  /// In zh, this message translates to:
  /// **'已添加表情回应'**
  String get chatReactionAdded;

  /// No description provided for @chatReactionRemoved.
  ///
  /// In zh, this message translates to:
  /// **'已移除表情回应'**
  String get chatReactionRemoved;

  /// No description provided for @chatFailedMessageDeleted.
  ///
  /// In zh, this message translates to:
  /// **'已删除失败消息'**
  String get chatFailedMessageDeleted;

  /// No description provided for @chatDeleteMessages.
  ///
  /// In zh, this message translates to:
  /// **'删除消息'**
  String get chatDeleteMessages;

  /// No description provided for @chatDeleteMessagesConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除 {count} 条消息吗？'**
  String chatDeleteMessagesConfirm(Object count);

  /// No description provided for @chatNoteOtherMessages.
  ///
  /// In zh, this message translates to:
  /// **'注意：{count} 条消息来自他人，仅对你删除。'**
  String chatNoteOtherMessages(Object count);

  /// No description provided for @chatMyMessagesWillBeRecalled.
  ///
  /// In zh, this message translates to:
  /// **'{count} 条你发送的消息将对所有人撤回。'**
  String chatMyMessagesWillBeRecalled(Object count);

  /// No description provided for @chatRecalledCount.
  ///
  /// In zh, this message translates to:
  /// **'已撤回 {count} 条消息，{localCount} 条仅对你删除'**
  String chatRecalledCount(Object count, Object localCount);

  /// No description provided for @chatRecalledMessages.
  ///
  /// In zh, this message translates to:
  /// **'已撤回 {count} 条消息'**
  String chatRecalledMessages(Object count);

  /// No description provided for @chatDeletedLocally.
  ///
  /// In zh, this message translates to:
  /// **'{count} 条消息仅对你删除'**
  String chatDeletedLocally(Object count);

  /// No description provided for @chatForwardedCount.
  ///
  /// In zh, this message translates to:
  /// **'已转发 {count} 条消息'**
  String chatForwardedCount(Object count);

  /// No description provided for @chatForwardComplete.
  ///
  /// In zh, this message translates to:
  /// **'转发完成：成功 {success} 条，失败 {failed} 条'**
  String chatForwardComplete(Object failed, Object success);

  /// No description provided for @chatRemindOnlyInGroup.
  ///
  /// In zh, this message translates to:
  /// **'提醒功能仅在群聊中可用'**
  String get chatRemindOnlyInGroup;

  /// No description provided for @chatOnlyTextSearchable.
  ///
  /// In zh, this message translates to:
  /// **'仅支持搜索文本消息'**
  String get chatOnlyTextSearchable;

  /// No description provided for @chatSearchFor.
  ///
  /// In zh, this message translates to:
  /// **'搜索 \"{text}\"'**
  String chatSearchFor(Object text);

  /// No description provided for @chatBaiduSearch.
  ///
  /// In zh, this message translates to:
  /// **'百度搜索'**
  String get chatBaiduSearch;

  /// No description provided for @chatGoogleSearch.
  ///
  /// In zh, this message translates to:
  /// **'Google 搜索'**
  String get chatGoogleSearch;

  /// No description provided for @chatBingSearch.
  ///
  /// In zh, this message translates to:
  /// **'必应搜索'**
  String get chatBingSearch;

  /// No description provided for @chatCalling.
  ///
  /// In zh, this message translates to:
  /// **'呼叫中...'**
  String get chatCalling;

  /// No description provided for @chatRinging.
  ///
  /// In zh, this message translates to:
  /// **'响铃中...'**
  String get chatRinging;

  /// No description provided for @chatInCall.
  ///
  /// In zh, this message translates to:
  /// **'通话中'**
  String get chatInCall;

  /// No description provided for @commonFeatureInDevelopment.
  ///
  /// In zh, this message translates to:
  /// **'{feature}功能开发中...'**
  String commonFeatureInDevelopment(String feature);

  /// No description provided for @chatCollectMessages.
  ///
  /// In zh, this message translates to:
  /// **'已收藏 {count} 条消息'**
  String chatCollectMessages(Object count);

  /// No description provided for @commonMemberCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人'**
  String commonMemberCount(int count);

  /// No description provided for @groupDone.
  ///
  /// In zh, this message translates to:
  /// **'完成({count})'**
  String groupDone(int count);

  /// No description provided for @profileServices.
  ///
  /// In zh, this message translates to:
  /// **'服务'**
  String get profileServices;

  /// No description provided for @commonFavorites.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get commonFavorites;

  /// No description provided for @profileOrdersAndCards.
  ///
  /// In zh, this message translates to:
  /// **'订单与卡包'**
  String get profileOrdersAndCards;

  /// No description provided for @profileStickers.
  ///
  /// In zh, this message translates to:
  /// **'表情'**
  String get profileStickers;

  /// No description provided for @profileStatusSetTo.
  ///
  /// In zh, this message translates to:
  /// **'状态已设置为：{status}'**
  String profileStatusSetTo(String status);

  /// No description provided for @profileAvatarUploadFailed.
  ///
  /// In zh, this message translates to:
  /// **'头像上传失败'**
  String get profileAvatarUploadFailed;

  /// No description provided for @profilePersonalProfile.
  ///
  /// In zh, this message translates to:
  /// **'个人信息'**
  String get profilePersonalProfile;

  /// No description provided for @profileName.
  ///
  /// In zh, this message translates to:
  /// **'名字'**
  String get profileName;

  /// No description provided for @profileGender.
  ///
  /// In zh, this message translates to:
  /// **'性别'**
  String get profileGender;

  /// No description provided for @profileRegion.
  ///
  /// In zh, this message translates to:
  /// **'地区'**
  String get profileRegion;

  /// No description provided for @commonMyQrCode.
  ///
  /// In zh, this message translates to:
  /// **'我的二维码'**
  String get commonMyQrCode;

  /// No description provided for @profilePoke.
  ///
  /// In zh, this message translates to:
  /// **'拍一拍'**
  String get profilePoke;

  /// No description provided for @profileRingtone.
  ///
  /// In zh, this message translates to:
  /// **'来电铃声'**
  String get profileRingtone;

  /// No description provided for @profileDefaultRingtone.
  ///
  /// In zh, this message translates to:
  /// **'默认铃声'**
  String get profileDefaultRingtone;

  /// No description provided for @profileMyAddresses.
  ///
  /// In zh, this message translates to:
  /// **'我的地址'**
  String get profileMyAddresses;

  /// No description provided for @profileGenderSetTo.
  ///
  /// In zh, this message translates to:
  /// **'性别已设置为：{gender}'**
  String profileGenderSetTo(String gender);

  /// No description provided for @profileSelectRegion.
  ///
  /// In zh, this message translates to:
  /// **'选择地区'**
  String get profileSelectRegion;

  /// No description provided for @profileSelectCity.
  ///
  /// In zh, this message translates to:
  /// **'选择城市'**
  String get profileSelectCity;

  /// No description provided for @profileRegionSetTo.
  ///
  /// In zh, this message translates to:
  /// **'地区已设置为：{region}'**
  String profileRegionSetTo(String region);

  /// No description provided for @profileSetPoke.
  ///
  /// In zh, this message translates to:
  /// **'设置拍一拍'**
  String get profileSetPoke;

  /// No description provided for @profileFriendPokedMe.
  ///
  /// In zh, this message translates to:
  /// **'朋友拍了拍我'**
  String get profileFriendPokedMe;

  /// No description provided for @profileExample.
  ///
  /// In zh, this message translates to:
  /// **'示例'**
  String get profileExample;

  /// No description provided for @profileOnTheShoulder.
  ///
  /// In zh, this message translates to:
  /// **'的肩膀'**
  String get profileOnTheShoulder;

  /// No description provided for @profilePokeCleared.
  ///
  /// In zh, this message translates to:
  /// **'拍一拍已清除'**
  String get profilePokeCleared;

  /// No description provided for @profilePokeSetTo.
  ///
  /// In zh, this message translates to:
  /// **'拍一拍已设置为：拍了拍我{suffix}'**
  String profilePokeSetTo(String suffix);

  /// No description provided for @profileEditSignature.
  ///
  /// In zh, this message translates to:
  /// **'编辑个性签名'**
  String get profileEditSignature;

  /// No description provided for @profileIntroduceYourself.
  ///
  /// In zh, this message translates to:
  /// **'一句话介绍自己'**
  String get profileIntroduceYourself;

  /// No description provided for @profileSignatureCleared.
  ///
  /// In zh, this message translates to:
  /// **'个性签名已清除'**
  String get profileSignatureCleared;

  /// No description provided for @profileSignatureUpdated.
  ///
  /// In zh, this message translates to:
  /// **'个性签名已更新'**
  String get profileSignatureUpdated;

  /// No description provided for @profileScanToAddFriend.
  ///
  /// In zh, this message translates to:
  /// **'扫一扫上面的二维码图案，加我为好友'**
  String get profileScanToAddFriend;

  /// No description provided for @profileRingtoneSetTo.
  ///
  /// In zh, this message translates to:
  /// **'来电铃声已设置为：{ringtone}'**
  String profileRingtoneSetTo(String ringtone);

  /// No description provided for @commonConfirmDissolveGroup.
  ///
  /// In zh, this message translates to:
  /// **'确定要解散群聊「{name}」吗？此操作无法撤销。'**
  String commonConfirmDissolveGroup(String name);

  /// No description provided for @authEnterValidServerAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的服务器地址'**
  String get authEnterValidServerAddress;

  /// No description provided for @authEmailOtp.
  ///
  /// In zh, this message translates to:
  /// **'邮箱验证码'**
  String get authEmailOtp;

  /// No description provided for @authEnterServerAddressFirst.
  ///
  /// In zh, this message translates to:
  /// **'请先输入服务器地址'**
  String get authEnterServerAddressFirst;

  /// No description provided for @authPasskeyRequiresServer.
  ///
  /// In zh, this message translates to:
  /// **'Passkey登录需要服务器支持'**
  String get authPasskeyRequiresServer;

  /// No description provided for @authLoginAgreement.
  ///
  /// In zh, this message translates to:
  /// **'登录即表示同意'**
  String get authLoginAgreement;

  /// No description provided for @authPleaseAgreeToTerms.
  ///
  /// In zh, this message translates to:
  /// **'请先阅读并同意服务协议和隐私政策'**
  String get authPleaseAgreeToTerms;

  /// No description provided for @authRegisterFailed.
  ///
  /// In zh, this message translates to:
  /// **'注册失败'**
  String get authRegisterFailed;

  /// No description provided for @commonReenterPassword.
  ///
  /// In zh, this message translates to:
  /// **'请再次输入密码'**
  String get commonReenterPassword;

  /// No description provided for @commonPasswordsDoNotMatch.
  ///
  /// In zh, this message translates to:
  /// **'两次输入的密码不一致'**
  String get commonPasswordsDoNotMatch;

  /// No description provided for @authInviteCodeBuiltIn.
  ///
  /// In zh, this message translates to:
  /// **'邀请码（已内置）'**
  String get authInviteCodeBuiltIn;

  /// No description provided for @authInviteCodeBuiltInNote.
  ///
  /// In zh, this message translates to:
  /// **'邀请码已内置，通常无需修改'**
  String get authInviteCodeBuiltInNote;

  /// No description provided for @authIHaveReadAndAgree.
  ///
  /// In zh, this message translates to:
  /// **'我已阅读并同意'**
  String get authIHaveReadAndAgree;

  /// No description provided for @mainStartGroupChat.
  ///
  /// In zh, this message translates to:
  /// **'发起群聊'**
  String get mainStartGroupChat;

  /// No description provided for @mainAddFriends.
  ///
  /// In zh, this message translates to:
  /// **'添加朋友'**
  String get mainAddFriends;

  /// No description provided for @mainPaymentAndCollection.
  ///
  /// In zh, this message translates to:
  /// **'收付款'**
  String get mainPaymentAndCollection;

  /// No description provided for @contactCount.
  ///
  /// In zh, this message translates to:
  /// **'{count}位联系人'**
  String contactCount(int count);

  /// No description provided for @contactAddToHomeScreen.
  ///
  /// In zh, this message translates to:
  /// **'添加到桌面'**
  String get contactAddToHomeScreen;

  /// No description provided for @contactRecommendedCardTo.
  ///
  /// In zh, this message translates to:
  /// **'已将{contact}的名片推荐给{recipient}'**
  String contactRecommendedCardTo(String contact, String recipient);

  /// No description provided for @contactEnterRemarkName.
  ///
  /// In zh, this message translates to:
  /// **'请输入备注名'**
  String get contactEnterRemarkName;

  /// No description provided for @contactRemarkSetTo.
  ///
  /// In zh, this message translates to:
  /// **'备注已设置为：{remark}'**
  String contactRemarkSetTo(String remark);

  /// No description provided for @contactAcceptedFriendRequest.
  ///
  /// In zh, this message translates to:
  /// **'已接受{name}的好友请求'**
  String contactAcceptedFriendRequest(String name);

  /// No description provided for @contactRejectedFriendRequest.
  ///
  /// In zh, this message translates to:
  /// **'已拒绝{name}的好友请求'**
  String contactRejectedFriendRequest(String name);

  /// No description provided for @commonGroupInvites.
  ///
  /// In zh, this message translates to:
  /// **'群邀请'**
  String get commonGroupInvites;

  /// No description provided for @commonMyGroups.
  ///
  /// In zh, this message translates to:
  /// **'我的群聊 ({count})'**
  String commonMyGroups(int count);

  /// No description provided for @commonInvitedToJoinGroup.
  ///
  /// In zh, this message translates to:
  /// **'邀请加入群聊'**
  String get commonInvitedToJoinGroup;

  /// No description provided for @commonConfirmLeaveGroup.
  ///
  /// In zh, this message translates to:
  /// **'确定要退出群聊「{name}」吗？'**
  String commonConfirmLeaveGroup(String name);

  /// No description provided for @commonLeave.
  ///
  /// In zh, this message translates to:
  /// **'离开'**
  String get commonLeave;

  /// No description provided for @commonRecallThisMessage.
  ///
  /// In zh, this message translates to:
  /// **'撤回该条消息？'**
  String get commonRecallThisMessage;

  /// No description provided for @commonSavedToGallery.
  ///
  /// In zh, this message translates to:
  /// **'已保存到相册'**
  String get commonSavedToGallery;

  /// No description provided for @commonFailedToSave.
  ///
  /// In zh, this message translates to:
  /// **'保存失败'**
  String get commonFailedToSave;

  /// No description provided for @chatSaving.
  ///
  /// In zh, this message translates to:
  /// **'保存中...'**
  String get chatSaving;

  /// No description provided for @commonShare.
  ///
  /// In zh, this message translates to:
  /// **'分享'**
  String get commonShare;

  /// No description provided for @chatSaveToGallery.
  ///
  /// In zh, this message translates to:
  /// **'保存到相册'**
  String get chatSaveToGallery;

  /// No description provided for @chatDownloadFailed.
  ///
  /// In zh, this message translates to:
  /// **'下载失败: {code}'**
  String chatDownloadFailed(String code);

  /// No description provided for @commonShareFailed.
  ///
  /// In zh, this message translates to:
  /// **'分享失败: {error}'**
  String commonShareFailed(String error);

  /// No description provided for @chatFailedToLoadImage.
  ///
  /// In zh, this message translates to:
  /// **'图片加载失败'**
  String get chatFailedToLoadImage;

  /// No description provided for @chatVideoRecordingFailed.
  ///
  /// In zh, this message translates to:
  /// **'视频录制失败，请重试'**
  String get chatVideoRecordingFailed;

  /// No description provided for @profileRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'红包'**
  String get profileRedPacket;

  /// No description provided for @commonMusic.
  ///
  /// In zh, this message translates to:
  /// **'音乐'**
  String get commonMusic;

  /// No description provided for @commonCoupon.
  ///
  /// In zh, this message translates to:
  /// **'卡券'**
  String get commonCoupon;

  /// No description provided for @commonGift.
  ///
  /// In zh, this message translates to:
  /// **'礼物'**
  String get commonGift;

  /// No description provided for @commonPoll.
  ///
  /// In zh, this message translates to:
  /// **'投票'**
  String get commonPoll;

  /// No description provided for @favoriteText.
  ///
  /// In zh, this message translates to:
  /// **'文本'**
  String get favoriteText;

  /// No description provided for @favoriteLinkLabel.
  ///
  /// In zh, this message translates to:
  /// **'链接'**
  String get favoriteLinkLabel;

  /// No description provided for @favoriteNote.
  ///
  /// In zh, this message translates to:
  /// **'笔记'**
  String get favoriteNote;

  /// No description provided for @favoriteMyNotes.
  ///
  /// In zh, this message translates to:
  /// **'我的笔记'**
  String get favoriteMyNotes;

  /// No description provided for @favoriteToday.
  ///
  /// In zh, this message translates to:
  /// **'今天'**
  String get favoriteToday;

  /// No description provided for @favoriteDaysAgoText.
  ///
  /// In zh, this message translates to:
  /// **'{count}天前'**
  String favoriteDaysAgoText(int count);

  /// No description provided for @favoriteDateFormat.
  ///
  /// In zh, this message translates to:
  /// **'{month}月{day}日'**
  String favoriteDateFormat(int month, int day);

  /// No description provided for @favoriteNoFavorites.
  ///
  /// In zh, this message translates to:
  /// **'暂无收藏'**
  String get favoriteNoFavorites;

  /// No description provided for @favoriteLongPressToFavorite.
  ///
  /// In zh, this message translates to:
  /// **'长按消息进行收藏'**
  String get favoriteLongPressToFavorite;

  /// No description provided for @favoriteNewNote.
  ///
  /// In zh, this message translates to:
  /// **'新建笔记'**
  String get favoriteNewNote;

  /// No description provided for @favoriteLink.
  ///
  /// In zh, this message translates to:
  /// **'收藏链接'**
  String get favoriteLink;

  /// No description provided for @favoriteEditTags.
  ///
  /// In zh, this message translates to:
  /// **'编辑标签'**
  String get favoriteEditTags;

  /// No description provided for @favoriteDeleteFavorite.
  ///
  /// In zh, this message translates to:
  /// **'删除收藏'**
  String get favoriteDeleteFavorite;

  /// No description provided for @favoriteDeleteFavoriteConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这条收藏吗？'**
  String get favoriteDeleteFavoriteConfirm;

  /// No description provided for @favoriteNoSearchResultsFound.
  ///
  /// In zh, this message translates to:
  /// **'没有找到结果'**
  String get favoriteNoSearchResultsFound;

  /// No description provided for @commonSendRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'发红包'**
  String get commonSendRedPacket;

  /// No description provided for @transferAmount.
  ///
  /// In zh, this message translates to:
  /// **'金额'**
  String get transferAmount;

  /// No description provided for @commonRedPacketCover.
  ///
  /// In zh, this message translates to:
  /// **'红包封面'**
  String get commonRedPacketCover;

  /// No description provided for @commonRedPacketType.
  ///
  /// In zh, this message translates to:
  /// **'红包类型'**
  String get commonRedPacketType;

  /// No description provided for @commonNormalRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'普通红包'**
  String get commonNormalRedPacket;

  /// No description provided for @commonLuckyRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'拼手气'**
  String get commonLuckyRedPacket;

  /// No description provided for @commonRedPacketCount.
  ///
  /// In zh, this message translates to:
  /// **'红包个数'**
  String get commonRedPacketCount;

  /// No description provided for @commonPieces.
  ///
  /// In zh, this message translates to:
  /// **'个'**
  String get commonPieces;

  /// No description provided for @commonPutMoneyInRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'塞钱进红包'**
  String get commonPutMoneyInRedPacket;

  /// No description provided for @commonRedPacketRefundNotice.
  ///
  /// In zh, this message translates to:
  /// **'未领取的红包，将于24小时后发起退款'**
  String get commonRedPacketRefundNotice;

  /// No description provided for @commonOpenRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'開'**
  String get commonOpenRedPacket;

  /// No description provided for @commonRedPacketAllClaimed.
  ///
  /// In zh, this message translates to:
  /// **'红包已被领完'**
  String get commonRedPacketAllClaimed;

  /// No description provided for @commonRedPacketExpired.
  ///
  /// In zh, this message translates to:
  /// **'红包已过期'**
  String get commonRedPacketExpired;

  /// No description provided for @commonAddTransferNote.
  ///
  /// In zh, this message translates to:
  /// **'添加转账说明'**
  String get commonAddTransferNote;

  /// No description provided for @commonYuan.
  ///
  /// In zh, this message translates to:
  /// **'元'**
  String get commonYuan;

  /// No description provided for @commonReplyWithEmoji.
  ///
  /// In zh, this message translates to:
  /// **'用此表情回复'**
  String get commonReplyWithEmoji;

  /// No description provided for @contactEditRemark.
  ///
  /// In zh, this message translates to:
  /// **'编辑备注'**
  String get contactEditRemark;

  /// No description provided for @contactSetPermissions.
  ///
  /// In zh, this message translates to:
  /// **'设置权限'**
  String get contactSetPermissions;

  /// No description provided for @profileAddToBlacklist.
  ///
  /// In zh, this message translates to:
  /// **'加入黑名单'**
  String get profileAddToBlacklist;

  /// No description provided for @contactDeleteContact.
  ///
  /// In zh, this message translates to:
  /// **'删除联系人'**
  String get contactDeleteContact;

  /// No description provided for @contactDeleteContactConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除 {name} 吗？'**
  String contactDeleteContactConfirm(String name);

  /// No description provided for @transferTitle.
  ///
  /// In zh, this message translates to:
  /// **'转账'**
  String get transferTitle;

  /// No description provided for @transferReceiverAddressLabel.
  ///
  /// In zh, this message translates to:
  /// **'收款地址'**
  String get transferReceiverAddressLabel;

  /// No description provided for @transferSelectTokenLabel.
  ///
  /// In zh, this message translates to:
  /// **'选择代币'**
  String get transferSelectTokenLabel;

  /// No description provided for @transferAmountLabel.
  ///
  /// In zh, this message translates to:
  /// **'转账金额'**
  String get transferAmountLabel;

  /// No description provided for @transferMemoLabel.
  ///
  /// In zh, this message translates to:
  /// **'备注（可选）'**
  String get transferMemoLabel;

  /// No description provided for @transferAddMemoHint.
  ///
  /// In zh, this message translates to:
  /// **'添加备注信息'**
  String get transferAddMemoHint;

  /// No description provided for @transferSendPaymentRequest.
  ///
  /// In zh, this message translates to:
  /// **'发送收款请求'**
  String get transferSendPaymentRequest;

  /// No description provided for @transferQrCodeGenerateFailed.
  ///
  /// In zh, this message translates to:
  /// **'二维码生成失败'**
  String get transferQrCodeGenerateFailed;

  /// No description provided for @transferScanQrToPayMe.
  ///
  /// In zh, this message translates to:
  /// **'扫描二维码向我付款'**
  String get transferScanQrToPayMe;

  /// No description provided for @transferMyWalletAddress.
  ///
  /// In zh, this message translates to:
  /// **'我的钱包地址'**
  String get transferMyWalletAddress;

  /// No description provided for @transferCreatePaymentRequest.
  ///
  /// In zh, this message translates to:
  /// **'创建收款请求'**
  String get transferCreatePaymentRequest;

  /// No description provided for @profileN42IdLabel.
  ///
  /// In zh, this message translates to:
  /// **'N42号：{id}'**
  String profileN42IdLabel(String id);

  /// No description provided for @commonRedPacketDefaultGreeting.
  ///
  /// In zh, this message translates to:
  /// **'恭喜发财，大吉大利'**
  String get commonRedPacketDefaultGreeting;

  /// No description provided for @commonSenderRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'{name}的红包'**
  String commonSenderRedPacket(String name);

  /// No description provided for @transferEnterValidAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的收款地址'**
  String get transferEnterValidAddress;

  /// No description provided for @transferPleaseSelectToken.
  ///
  /// In zh, this message translates to:
  /// **'请选择代币'**
  String get transferPleaseSelectToken;

  /// No description provided for @commonReceivedTransfer.
  ///
  /// In zh, this message translates to:
  /// **'收到转账'**
  String get commonReceivedTransfer;

  /// No description provided for @commonSenderSentRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'{name}发出的红包'**
  String commonSenderSentRedPacket(String name);

  /// No description provided for @commonSavedToBalance.
  ///
  /// In zh, this message translates to:
  /// **'已存入零钱，可直接转账'**
  String get commonSavedToBalance;

  /// No description provided for @commonRedPacketExpiredOrEmpty.
  ///
  /// In zh, this message translates to:
  /// **'红包已过期/已领完'**
  String get commonRedPacketExpiredOrEmpty;

  /// No description provided for @transferScanFeatureComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'扫描功能开发中...'**
  String get transferScanFeatureComingSoon;

  /// No description provided for @contactSetAsStarred.
  ///
  /// In zh, this message translates to:
  /// **'设为星标朋友'**
  String get contactSetAsStarred;

  /// No description provided for @contactAddToBlocklist.
  ///
  /// In zh, this message translates to:
  /// **'加入黑名单'**
  String get contactAddToBlocklist;

  /// No description provided for @commonClaimedYour.
  ///
  /// In zh, this message translates to:
  /// **'领取了你的'**
  String get commonClaimedYour;

  /// No description provided for @commonClaimedText.
  ///
  /// In zh, this message translates to:
  /// **'领取了'**
  String get commonClaimedText;

  /// No description provided for @commonUserTyping.
  ///
  /// In zh, this message translates to:
  /// **'{name}正在输入...'**
  String commonUserTyping(String name);

  /// No description provided for @commonTyping.
  ///
  /// In zh, this message translates to:
  /// **'对方正在输入...'**
  String get commonTyping;

  /// No description provided for @commonWaitingToReceive.
  ///
  /// In zh, this message translates to:
  /// **'待对方接收'**
  String get commonWaitingToReceive;

  /// No description provided for @commonTapToClaim.
  ///
  /// In zh, this message translates to:
  /// **'点击领取'**
  String get commonTapToClaim;

  /// No description provided for @commonHasBeenReceived.
  ///
  /// In zh, this message translates to:
  /// **'已被接收'**
  String get commonHasBeenReceived;

  /// No description provided for @commonGetLucky.
  ///
  /// In zh, this message translates to:
  /// **'领个好彩头'**
  String get commonGetLucky;

  /// No description provided for @qrcodeCameraStartFailed.
  ///
  /// In zh, this message translates to:
  /// **'相机启动失败'**
  String get qrcodeCameraStartFailed;

  /// No description provided for @qrcodeUnknownError.
  ///
  /// In zh, this message translates to:
  /// **'未知错误'**
  String get qrcodeUnknownError;

  /// No description provided for @qrcodePlaceQrCodeInFrame.
  ///
  /// In zh, this message translates to:
  /// **'将二维码放入框内扫描'**
  String get qrcodePlaceQrCodeInFrame;

  /// No description provided for @qrcodeCloseManualInput.
  ///
  /// In zh, this message translates to:
  /// **'关闭手动输入'**
  String get qrcodeCloseManualInput;

  /// No description provided for @qrcodeManualInputUserId.
  ///
  /// In zh, this message translates to:
  /// **'手动输入用户ID'**
  String get qrcodeManualInputUserId;

  /// No description provided for @commonAdd.
  ///
  /// In zh, this message translates to:
  /// **'加入'**
  String get commonAdd;

  /// No description provided for @profileSetStatus.
  ///
  /// In zh, this message translates to:
  /// **'设置状态'**
  String get profileSetStatus;

  /// No description provided for @profileVisibleToFriends24h.
  ///
  /// In zh, this message translates to:
  /// **'可被好友看到，24小时后自动清除'**
  String get profileVisibleToFriends24h;

  /// No description provided for @profileWriteStatus.
  ///
  /// In zh, this message translates to:
  /// **'写状态'**
  String get profileWriteStatus;

  /// No description provided for @profileEnterYourStatus.
  ///
  /// In zh, this message translates to:
  /// **'输入你的状态...'**
  String get profileEnterYourStatus;

  /// No description provided for @profileOk.
  ///
  /// In zh, this message translates to:
  /// **'确定'**
  String get profileOk;

  /// No description provided for @qrcodeCameraPermissionRequired.
  ///
  /// In zh, this message translates to:
  /// **'扫描二维码需要相机权限'**
  String get qrcodeCameraPermissionRequired;

  /// No description provided for @qrcodeCameraPermissionDenied.
  ///
  /// In zh, this message translates to:
  /// **'相机权限已被永久拒绝，请在系统设置中开启。'**
  String get qrcodeCameraPermissionDenied;

  /// No description provided for @qrcodePermissionCheckError.
  ///
  /// In zh, this message translates to:
  /// **'检查权限时出错: {error}'**
  String qrcodePermissionCheckError(String error);

  /// No description provided for @qrcodeInvalidQrCode.
  ///
  /// In zh, this message translates to:
  /// **'无效的二维码'**
  String get qrcodeInvalidQrCode;

  /// No description provided for @qrcodeCannotAddFriend.
  ///
  /// In zh, this message translates to:
  /// **'无法添加好友: {error}'**
  String qrcodeCannotAddFriend(String error);

  /// No description provided for @qrcodeScanQrCode.
  ///
  /// In zh, this message translates to:
  /// **'扫描二维码'**
  String get qrcodeScanQrCode;

  /// No description provided for @qrcodeCheckingCameraPermission.
  ///
  /// In zh, this message translates to:
  /// **'正在检查相机权限...'**
  String get qrcodeCheckingCameraPermission;

  /// No description provided for @qrcodeNeedCameraPermission.
  ///
  /// In zh, this message translates to:
  /// **'需要相机权限'**
  String get qrcodeNeedCameraPermission;

  /// No description provided for @qrcodeRetryPermission.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get qrcodeRetryPermission;

  /// No description provided for @qrcodeOpenSettings.
  ///
  /// In zh, this message translates to:
  /// **'打开设置'**
  String get qrcodeOpenSettings;

  /// No description provided for @groupInviteMembers.
  ///
  /// In zh, this message translates to:
  /// **'邀请成员'**
  String get groupInviteMembers;

  /// No description provided for @groupInviteCount.
  ///
  /// In zh, this message translates to:
  /// **'邀请({count})'**
  String groupInviteCount(int count);

  /// No description provided for @profileNoShippingAddress.
  ///
  /// In zh, this message translates to:
  /// **'暂无收货地址'**
  String get profileNoShippingAddress;

  /// No description provided for @profileDefaultLabel.
  ///
  /// In zh, this message translates to:
  /// **'默认'**
  String get profileDefaultLabel;

  /// No description provided for @profileNoInvoice.
  ///
  /// In zh, this message translates to:
  /// **'暂无发票抬头'**
  String get profileNoInvoice;

  /// No description provided for @profileCompany.
  ///
  /// In zh, this message translates to:
  /// **'企业'**
  String get profileCompany;

  /// No description provided for @profileTaxNumber.
  ///
  /// In zh, this message translates to:
  /// **'税号'**
  String get profileTaxNumber;

  /// No description provided for @profileConfirmDeleteAddress.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这个地址吗？'**
  String get profileConfirmDeleteAddress;

  /// No description provided for @profileConfirmDeleteInvoice.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这个发票抬头吗？'**
  String get profileConfirmDeleteInvoice;

  /// No description provided for @commonGroupOwner.
  ///
  /// In zh, this message translates to:
  /// **'群主'**
  String get commonGroupOwner;

  /// No description provided for @commonGroupAdmin.
  ///
  /// In zh, this message translates to:
  /// **'管理员'**
  String get commonGroupAdmin;

  /// No description provided for @groupSearchMembers.
  ///
  /// In zh, this message translates to:
  /// **'搜索成员'**
  String get groupSearchMembers;

  /// No description provided for @groupTotalMembers.
  ///
  /// In zh, this message translates to:
  /// **'{count}位成员'**
  String groupTotalMembers(int count);

  /// No description provided for @chatRemoveFromGroup.
  ///
  /// In zh, this message translates to:
  /// **'移出群聊'**
  String get chatRemoveFromGroup;

  /// No description provided for @groupConfirmRemoveMember.
  ///
  /// In zh, this message translates to:
  /// **'确定要将\"{name}\"移出群聊吗？'**
  String groupConfirmRemoveMember(String name);

  /// No description provided for @chatUnknownSong.
  ///
  /// In zh, this message translates to:
  /// **'未知歌曲'**
  String get chatUnknownSong;

  /// No description provided for @chatUnknownArtist.
  ///
  /// In zh, this message translates to:
  /// **'未知艺术家'**
  String get chatUnknownArtist;

  /// No description provided for @chatUnknownContact.
  ///
  /// In zh, this message translates to:
  /// **'未知联系人'**
  String get chatUnknownContact;

  /// No description provided for @chatPersonalCard.
  ///
  /// In zh, this message translates to:
  /// **'个人名片'**
  String get chatPersonalCard;

  /// No description provided for @chatSingleChoice.
  ///
  /// In zh, this message translates to:
  /// **'单选'**
  String get chatSingleChoice;

  /// No description provided for @chatMultiChoice.
  ///
  /// In zh, this message translates to:
  /// **'多选'**
  String get chatMultiChoice;

  /// No description provided for @chatEnded.
  ///
  /// In zh, this message translates to:
  /// **'已结束'**
  String get chatEnded;

  /// No description provided for @chatEndPollButton.
  ///
  /// In zh, this message translates to:
  /// **'结束投票'**
  String get chatEndPollButton;

  /// No description provided for @chatPollHint.
  ///
  /// In zh, this message translates to:
  /// **'投票发起后将显示在聊天中，群成员可以参与投票'**
  String get chatPollHint;

  /// No description provided for @chatSearchSongOrArtist.
  ///
  /// In zh, this message translates to:
  /// **'搜索歌曲或歌手'**
  String get chatSearchSongOrArtist;

  /// No description provided for @chatNoSongsFound.
  ///
  /// In zh, this message translates to:
  /// **'没有找到歌曲'**
  String get chatNoSongsFound;

  /// No description provided for @chatSongNameOptional.
  ///
  /// In zh, this message translates to:
  /// **'歌曲名称（可选）'**
  String get chatSongNameOptional;

  /// No description provided for @chatEnterSongName.
  ///
  /// In zh, this message translates to:
  /// **'输入歌曲名称'**
  String get chatEnterSongName;

  /// No description provided for @chatArtistNameOptional.
  ///
  /// In zh, this message translates to:
  /// **'歌手名称（可选）'**
  String get chatArtistNameOptional;

  /// No description provided for @chatEnterArtistName.
  ///
  /// In zh, this message translates to:
  /// **'输入歌手名称'**
  String get chatEnterArtistName;

  /// No description provided for @chatRealTimeLocationSharing.
  ///
  /// In zh, this message translates to:
  /// **'实时位置共享功能开发中...'**
  String get chatRealTimeLocationSharing;

  /// No description provided for @profileVoiceCallFeatureInDev.
  ///
  /// In zh, this message translates to:
  /// **'语音通话功能开发中...'**
  String get profileVoiceCallFeatureInDev;

  /// No description provided for @profileReportFeatureInDev.
  ///
  /// In zh, this message translates to:
  /// **'举报功能开发中...'**
  String get profileReportFeatureInDev;

  /// No description provided for @profileShareFeatureInDev.
  ///
  /// In zh, this message translates to:
  /// **'分享功能开发中...'**
  String get profileShareFeatureInDev;

  /// No description provided for @profileQrCodeFeatureInDev.
  ///
  /// In zh, this message translates to:
  /// **'二维码功能开发中...'**
  String get profileQrCodeFeatureInDev;

  /// No description provided for @qrcodeScanQrToAddMe.
  ///
  /// In zh, this message translates to:
  /// **'扫一扫上面的二维码，加我为好友'**
  String get qrcodeScanQrToAddMe;

  /// No description provided for @qrcodeSaveToAlbum.
  ///
  /// In zh, this message translates to:
  /// **'保存到相册'**
  String get qrcodeSaveToAlbum;

  /// No description provided for @qrcodeChangeStyle.
  ///
  /// In zh, this message translates to:
  /// **'换个样式'**
  String get qrcodeChangeStyle;

  /// No description provided for @qrcodeCopyId.
  ///
  /// In zh, this message translates to:
  /// **'复制 ID'**
  String get qrcodeCopyId;

  /// No description provided for @qrcodeIdCopied.
  ///
  /// In zh, this message translates to:
  /// **'已复制用户 ID'**
  String get qrcodeIdCopied;

  /// No description provided for @qrcodeMoreStylesFeatureComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'更多样式即将推出'**
  String get qrcodeMoreStylesFeatureComingSoon;

  /// No description provided for @profileBio.
  ///
  /// In zh, this message translates to:
  /// **'个性签名'**
  String get profileBio;

  /// No description provided for @profileHomeServer.
  ///
  /// In zh, this message translates to:
  /// **'服务器'**
  String get profileHomeServer;

  /// No description provided for @profileShareContactCard.
  ///
  /// In zh, this message translates to:
  /// **'分享名片'**
  String get profileShareContactCard;

  /// No description provided for @profileRemoveFromBlacklist.
  ///
  /// In zh, this message translates to:
  /// **'移出黑名单'**
  String get profileRemoveFromBlacklist;

  /// No description provided for @profileConfirmAddBlacklist.
  ///
  /// In zh, this message translates to:
  /// **'确定将该用户加入黑名单吗？你将不再收到对方的消息'**
  String get profileConfirmAddBlacklist;

  /// No description provided for @profileConfirmRemoveBlacklist.
  ///
  /// In zh, this message translates to:
  /// **'确定将该用户移出黑名单吗？'**
  String get profileConfirmRemoveBlacklist;

  /// No description provided for @profileRemarkSaved.
  ///
  /// In zh, this message translates to:
  /// **'备注已保存'**
  String get profileRemarkSaved;

  /// No description provided for @profileRemarkCleared.
  ///
  /// In zh, this message translates to:
  /// **'已清除备注'**
  String get profileRemarkCleared;

  /// No description provided for @transferReceive.
  ///
  /// In zh, this message translates to:
  /// **'收款'**
  String get transferReceive;

  /// No description provided for @transferPleaseConnectWallet.
  ///
  /// In zh, this message translates to:
  /// **'请先连接钱包'**
  String get transferPleaseConnectWallet;

  /// No description provided for @transferSendRequest.
  ///
  /// In zh, this message translates to:
  /// **'发送请求'**
  String get transferSendRequest;

  /// No description provided for @transferPleaseEnterValidAmount.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的金额'**
  String get transferPleaseEnterValidAmount;

  /// No description provided for @searchPlaceholder.
  ///
  /// In zh, this message translates to:
  /// **'搜索联系人、群聊、消息'**
  String get searchPlaceholder;

  /// No description provided for @searchEnterKeywordToSearch.
  ///
  /// In zh, this message translates to:
  /// **'输入关键词开始搜索'**
  String get searchEnterKeywordToSearch;

  /// No description provided for @searchClearHistory.
  ///
  /// In zh, this message translates to:
  /// **'清除'**
  String get searchClearHistory;

  /// No description provided for @searchNoResultsForQuery.
  ///
  /// In zh, this message translates to:
  /// **'没有找到\"{query}\"相关的结果'**
  String searchNoResultsForQuery(String query);

  /// No description provided for @searchAllResults.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get searchAllResults;

  /// No description provided for @searchInChat.
  ///
  /// In zh, this message translates to:
  /// **'在聊天中搜索'**
  String get searchInChat;

  /// No description provided for @searchContactLabel.
  ///
  /// In zh, this message translates to:
  /// **'联系人'**
  String get searchContactLabel;

  /// No description provided for @searchGroupLabel.
  ///
  /// In zh, this message translates to:
  /// **'群聊'**
  String get searchGroupLabel;

  /// No description provided for @searchConversationLabel.
  ///
  /// In zh, this message translates to:
  /// **'会话'**
  String get searchConversationLabel;

  /// No description provided for @searchMessageLabel.
  ///
  /// In zh, this message translates to:
  /// **'消息'**
  String get searchMessageLabel;

  /// No description provided for @settingsSecurityTitle.
  ///
  /// In zh, this message translates to:
  /// **'安全'**
  String get settingsSecurityTitle;

  /// No description provided for @settingsKeyBackup.
  ///
  /// In zh, this message translates to:
  /// **'密钥备份'**
  String get settingsKeyBackup;

  /// No description provided for @settingsBackupEncryptionKeys.
  ///
  /// In zh, this message translates to:
  /// **'备份加密密钥'**
  String get settingsBackupEncryptionKeys;

  /// No description provided for @settingsKeysBackedUp.
  ///
  /// In zh, this message translates to:
  /// **'已备份 {count} 个密钥'**
  String settingsKeysBackedUp(int count);

  /// No description provided for @settingsBackupNotSet.
  ///
  /// In zh, this message translates to:
  /// **'未设置备份'**
  String get settingsBackupNotSet;

  /// No description provided for @settingsRestoreKeys.
  ///
  /// In zh, this message translates to:
  /// **'恢复密钥'**
  String get settingsRestoreKeys;

  /// No description provided for @settingsRestoreKeysFromBackup.
  ///
  /// In zh, this message translates to:
  /// **'从备份恢复加密密钥'**
  String get settingsRestoreKeysFromBackup;

  /// No description provided for @settingsExportKeys.
  ///
  /// In zh, this message translates to:
  /// **'导出密钥'**
  String get settingsExportKeys;

  /// No description provided for @settingsExportKeysToFile.
  ///
  /// In zh, this message translates to:
  /// **'导出密钥到文件'**
  String get settingsExportKeysToFile;

  /// No description provided for @settingsLoggedInDevices.
  ///
  /// In zh, this message translates to:
  /// **'已登录设备'**
  String get settingsLoggedInDevices;

  /// No description provided for @settingsNoOtherDevices.
  ///
  /// In zh, this message translates to:
  /// **'暂无其他设备'**
  String get settingsNoOtherDevices;

  /// No description provided for @settingsVerified.
  ///
  /// In zh, this message translates to:
  /// **'已验证'**
  String get settingsVerified;

  /// No description provided for @settingsUnverified.
  ///
  /// In zh, this message translates to:
  /// **'未验证'**
  String get settingsUnverified;

  /// No description provided for @settingsAdvanced.
  ///
  /// In zh, this message translates to:
  /// **'高级'**
  String get settingsAdvanced;

  /// No description provided for @settingsCrossSigning.
  ///
  /// In zh, this message translates to:
  /// **'跨设备签名'**
  String get settingsCrossSigning;

  /// No description provided for @settingsEnabled.
  ///
  /// In zh, this message translates to:
  /// **'已启用'**
  String get settingsEnabled;

  /// No description provided for @settingsNotEnabled.
  ///
  /// In zh, this message translates to:
  /// **'未启用'**
  String get settingsNotEnabled;

  /// No description provided for @settingsResetEncryption.
  ///
  /// In zh, this message translates to:
  /// **'重置加密'**
  String get settingsResetEncryption;

  /// No description provided for @settingsDeleteAllEncryptionKeys.
  ///
  /// In zh, this message translates to:
  /// **'删除所有加密密钥'**
  String get settingsDeleteAllEncryptionKeys;

  /// No description provided for @settingsEncryptionNotSupported.
  ///
  /// In zh, this message translates to:
  /// **'不支持加密'**
  String get settingsEncryptionNotSupported;

  /// No description provided for @settingsNotInitialized.
  ///
  /// In zh, this message translates to:
  /// **'未初始化'**
  String get settingsNotInitialized;

  /// No description provided for @settingsBackupKeyTitle.
  ///
  /// In zh, this message translates to:
  /// **'备份密钥'**
  String get settingsBackupKeyTitle;

  /// No description provided for @settingsBackupKeyMessage.
  ///
  /// In zh, this message translates to:
  /// **'是否创建新的密钥备份？这将帮助您在新设备上恢复加密消息。'**
  String get settingsBackupKeyMessage;

  /// No description provided for @settingsBackup.
  ///
  /// In zh, this message translates to:
  /// **'备份'**
  String get settingsBackup;

  /// No description provided for @settingsRestoreKeyTitle.
  ///
  /// In zh, this message translates to:
  /// **'恢复密钥'**
  String get settingsRestoreKeyTitle;

  /// No description provided for @settingsRestoreKeyMessage.
  ///
  /// In zh, this message translates to:
  /// **'输入您的恢复密码或恢复密钥来恢复加密消息。'**
  String get settingsRestoreKeyMessage;

  /// No description provided for @settingsRestore.
  ///
  /// In zh, this message translates to:
  /// **'恢复'**
  String get settingsRestore;

  /// No description provided for @settingsExportKeyTitle.
  ///
  /// In zh, this message translates to:
  /// **'导出密钥'**
  String get settingsExportKeyTitle;

  /// No description provided for @settingsExportKeyMessage.
  ///
  /// In zh, this message translates to:
  /// **'导出的密钥文件包含您的所有加密密钥，请妥善保管。'**
  String get settingsExportKeyMessage;

  /// No description provided for @settingsExport.
  ///
  /// In zh, this message translates to:
  /// **'导出'**
  String get settingsExport;

  /// No description provided for @settingsDeviceIdLabel.
  ///
  /// In zh, this message translates to:
  /// **'设备ID: {deviceId}'**
  String settingsDeviceIdLabel(String deviceId);

  /// No description provided for @settingsDeviceStatusVerified.
  ///
  /// In zh, this message translates to:
  /// **'状态: 已验证'**
  String get settingsDeviceStatusVerified;

  /// No description provided for @settingsDeviceStatusUnverified.
  ///
  /// In zh, this message translates to:
  /// **'状态: 未验证'**
  String get settingsDeviceStatusUnverified;

  /// No description provided for @settingsLastActiveLabel.
  ///
  /// In zh, this message translates to:
  /// **'最后活跃: {lastSeen}'**
  String settingsLastActiveLabel(String lastSeen);

  /// No description provided for @settingsVerifyThisDevice.
  ///
  /// In zh, this message translates to:
  /// **'验证此设备'**
  String get settingsVerifyThisDevice;

  /// No description provided for @settingsCrossSigningAlreadyEnabled.
  ///
  /// In zh, this message translates to:
  /// **'跨设备签名已启用'**
  String get settingsCrossSigningAlreadyEnabled;

  /// No description provided for @settingsCrossSigningSetupSuccess.
  ///
  /// In zh, this message translates to:
  /// **'跨设备签名设置成功'**
  String get settingsCrossSigningSetupSuccess;

  /// No description provided for @settingsResetEncryptionTitle.
  ///
  /// In zh, this message translates to:
  /// **'重置加密'**
  String get settingsResetEncryptionTitle;

  /// No description provided for @settingsResetEncryptionWarning.
  ///
  /// In zh, this message translates to:
  /// **'警告：这将删除您所有的加密密钥。您将无法解密之前的加密消息。此操作不可撤销。'**
  String get settingsResetEncryptionWarning;

  /// No description provided for @settingsReset.
  ///
  /// In zh, this message translates to:
  /// **'重置'**
  String get settingsReset;

  /// No description provided for @settingsBackupSuccess.
  ///
  /// In zh, this message translates to:
  /// **'密钥备份成功'**
  String get settingsBackupSuccess;

  /// No description provided for @settingsBackupFailed.
  ///
  /// In zh, this message translates to:
  /// **'备份失败'**
  String get settingsBackupFailed;

  /// No description provided for @settingsRecoveryKey.
  ///
  /// In zh, this message translates to:
  /// **'恢复密钥'**
  String get settingsRecoveryKey;

  /// No description provided for @settingsRecoveryKeySaveWarning.
  ///
  /// In zh, this message translates to:
  /// **'请将此恢复密钥保存在安全的地方。您需要它在新设备上恢复加密消息。'**
  String get settingsRecoveryKeySaveWarning;

  /// No description provided for @settingsRecoveryKeySaved.
  ///
  /// In zh, this message translates to:
  /// **'我已保存'**
  String get settingsRecoveryKeySaved;

  /// No description provided for @settingsRestoreSuccess.
  ///
  /// In zh, this message translates to:
  /// **'密钥恢复成功'**
  String get settingsRestoreSuccess;

  /// No description provided for @settingsRestoreFailed.
  ///
  /// In zh, this message translates to:
  /// **'恢复失败'**
  String get settingsRestoreFailed;

  /// No description provided for @settingsPassword.
  ///
  /// In zh, this message translates to:
  /// **'密码'**
  String get settingsPassword;

  /// No description provided for @settingsEnterRecoveryKey.
  ///
  /// In zh, this message translates to:
  /// **'输入恢复密钥'**
  String get settingsEnterRecoveryKey;

  /// No description provided for @settingsEnterPassword.
  ///
  /// In zh, this message translates to:
  /// **'输入密码'**
  String get settingsEnterPassword;

  /// No description provided for @settingsExportSuccess.
  ///
  /// In zh, this message translates to:
  /// **'密钥已成功导出到服务端备份'**
  String get settingsExportSuccess;

  /// No description provided for @settingsExportNeedBackupFirst.
  ///
  /// In zh, this message translates to:
  /// **'请先创建密钥备份'**
  String get settingsExportNeedBackupFirst;

  /// No description provided for @settingsExportFailed.
  ///
  /// In zh, this message translates to:
  /// **'导出失败'**
  String get settingsExportFailed;

  /// No description provided for @settingsResetSuccess.
  ///
  /// In zh, this message translates to:
  /// **'加密重置成功'**
  String get settingsResetSuccess;

  /// No description provided for @settingsResetFailed.
  ///
  /// In zh, this message translates to:
  /// **'重置失败'**
  String get settingsResetFailed;

  /// No description provided for @callLeaveMeetingConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要离开会议吗？'**
  String get callLeaveMeetingConfirm;

  /// No description provided for @chatPokedSomeone.
  ///
  /// In zh, this message translates to:
  /// **'拍了拍「{name}」{suffix}'**
  String chatPokedSomeone(String name, String suffix);

  /// No description provided for @chatNoContactsToAdd.
  ///
  /// In zh, this message translates to:
  /// **'没有可添加的联系人'**
  String get chatNoContactsToAdd;

  /// No description provided for @chatAddMembers.
  ///
  /// In zh, this message translates to:
  /// **'添加成员'**
  String get chatAddMembers;

  /// No description provided for @chatInvitedMembers.
  ///
  /// In zh, this message translates to:
  /// **'已邀请 {count} 位成员'**
  String chatInvitedMembers(int count);

  /// No description provided for @chatInviteFailed.
  ///
  /// In zh, this message translates to:
  /// **'邀请失败: {error}'**
  String chatInviteFailed(String error);

  /// No description provided for @chatMemberRemoved.
  ///
  /// In zh, this message translates to:
  /// **'已移除成员'**
  String get chatMemberRemoved;

  /// No description provided for @chatRemoveFailed.
  ///
  /// In zh, this message translates to:
  /// **'移除失败: {error}'**
  String chatRemoveFailed(String error);

  /// No description provided for @chatRealTimeLocationShareMessage.
  ///
  /// In zh, this message translates to:
  /// **'开始共享后，对方将能看到你的实时位置，共享时长为1小时。'**
  String get chatRealTimeLocationShareMessage;

  /// No description provided for @chatStartSharing.
  ///
  /// In zh, this message translates to:
  /// **'开始共享'**
  String get chatStartSharing;

  /// No description provided for @chatLocationServiceNotEnabled.
  ///
  /// In zh, this message translates to:
  /// **'位置服务未开启'**
  String get chatLocationServiceNotEnabled;

  /// No description provided for @chatEnableLocationService.
  ///
  /// In zh, this message translates to:
  /// **'请开启位置服务以使用位置功能'**
  String get chatEnableLocationService;

  /// No description provided for @chatGoToSettings.
  ///
  /// In zh, this message translates to:
  /// **'去设置'**
  String get chatGoToSettings;

  /// No description provided for @chatLocationPermissionRequired.
  ///
  /// In zh, this message translates to:
  /// **'需要位置权限才能使用此功能'**
  String get chatLocationPermissionRequired;

  /// No description provided for @chatLocationPermissionDeniedPermanent.
  ///
  /// In zh, this message translates to:
  /// **'位置权限已被永久拒绝，请在设置中开启'**
  String get chatLocationPermissionDeniedPermanent;

  /// No description provided for @chatLocationPermissionDenied.
  ///
  /// In zh, this message translates to:
  /// **'位置权限被拒绝'**
  String get chatLocationPermissionDenied;

  /// No description provided for @chatGettingLocation.
  ///
  /// In zh, this message translates to:
  /// **'正在获取位置...'**
  String get chatGettingLocation;

  /// No description provided for @chatGetLocationFailed.
  ///
  /// In zh, this message translates to:
  /// **'获取位置失败: {error}'**
  String chatGetLocationFailed(String error);

  /// No description provided for @chatMapPreview.
  ///
  /// In zh, this message translates to:
  /// **'地图预览'**
  String get chatMapPreview;

  /// No description provided for @chatSearchLocation.
  ///
  /// In zh, this message translates to:
  /// **'搜索地点'**
  String get chatSearchLocation;

  /// No description provided for @chatRedPacketSent.
  ///
  /// In zh, this message translates to:
  /// **'已发送 {amount} {token} 红包'**
  String chatRedPacketSent(String amount, String token);

  /// No description provided for @chatTransferDefault.
  ///
  /// In zh, this message translates to:
  /// **'转账'**
  String get chatTransferDefault;

  /// No description provided for @chatTransferSent.
  ///
  /// In zh, this message translates to:
  /// **'已发送 {amount} {token} 转账'**
  String chatTransferSent(String amount, String token);

  /// No description provided for @chatPickFileFailed.
  ///
  /// In zh, this message translates to:
  /// **'选择文件失败: {error}'**
  String chatPickFileFailed(String error);

  /// No description provided for @chatFileSizeLimit.
  ///
  /// In zh, this message translates to:
  /// **'文件大小不能超过 50MB'**
  String get chatFileSizeLimit;

  /// No description provided for @chatFileSending.
  ///
  /// In zh, this message translates to:
  /// **'文件发送中: {filename}'**
  String chatFileSending(String filename);

  /// No description provided for @chatSendFileFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送文件失败: {error}'**
  String chatSendFileFailed(String error);

  /// No description provided for @chatContactCardSent.
  ///
  /// In zh, this message translates to:
  /// **'已发送 {name} 的名片'**
  String chatContactCardSent(String name);

  /// No description provided for @chatFavoritesFeature.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get chatFavoritesFeature;

  /// No description provided for @chatCouponsFeature.
  ///
  /// In zh, this message translates to:
  /// **'卡券'**
  String get chatCouponsFeature;

  /// No description provided for @chatGiftFeature.
  ///
  /// In zh, this message translates to:
  /// **'礼物'**
  String get chatGiftFeature;

  /// No description provided for @chatSharedMusic.
  ///
  /// In zh, this message translates to:
  /// **'已分享 {name}'**
  String chatSharedMusic(String name);

  /// No description provided for @chatEndPollTitle.
  ///
  /// In zh, this message translates to:
  /// **'结束投票'**
  String get chatEndPollTitle;

  /// No description provided for @chatEndPollConfirmMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要结束这个投票吗？结束后将无法继续投票。'**
  String get chatEndPollConfirmMessage;

  /// No description provided for @chatPollEndedMessage.
  ///
  /// In zh, this message translates to:
  /// **'投票已结束'**
  String get chatPollEndedMessage;

  /// No description provided for @chatConnectingCall.
  ///
  /// In zh, this message translates to:
  /// **'正在连接...'**
  String get chatConnectingCall;

  /// No description provided for @chatMuteCall.
  ///
  /// In zh, this message translates to:
  /// **'静音'**
  String get chatMuteCall;

  /// No description provided for @chatSpeakerOff.
  ///
  /// In zh, this message translates to:
  /// **'关闭免提'**
  String get chatSpeakerOff;

  /// No description provided for @chatSpeakerOn.
  ///
  /// In zh, this message translates to:
  /// **'免提'**
  String get chatSpeakerOn;

  /// No description provided for @chatCameraOn.
  ///
  /// In zh, this message translates to:
  /// **'开启摄像头'**
  String get chatCameraOn;

  /// No description provided for @chatCameraOff.
  ///
  /// In zh, this message translates to:
  /// **'关闭摄像头'**
  String get chatCameraOff;

  /// No description provided for @chatHangUp.
  ///
  /// In zh, this message translates to:
  /// **'挂断'**
  String get chatHangUp;

  /// No description provided for @chatSelectForwardTargetTitle.
  ///
  /// In zh, this message translates to:
  /// **'选择转发对象'**
  String get chatSelectForwardTargetTitle;

  /// No description provided for @chatNoForwardableChat.
  ///
  /// In zh, this message translates to:
  /// **'没有可转发的会话'**
  String get chatNoForwardableChat;

  /// No description provided for @chatNoMatchingChat.
  ///
  /// In zh, this message translates to:
  /// **'没有找到相关会话'**
  String get chatNoMatchingChat;

  /// No description provided for @chatLocationTitle.
  ///
  /// In zh, this message translates to:
  /// **'位置'**
  String get chatLocationTitle;

  /// No description provided for @chatSendButton.
  ///
  /// In zh, this message translates to:
  /// **'发送'**
  String get chatSendButton;

  /// No description provided for @chatRetryButton.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get chatRetryButton;

  /// No description provided for @chatSearchContactHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索联系人'**
  String get chatSearchContactHint;

  /// No description provided for @chatShareMusic.
  ///
  /// In zh, this message translates to:
  /// **'分享音乐'**
  String get chatShareMusic;

  /// No description provided for @chatRecentPlayed.
  ///
  /// In zh, this message translates to:
  /// **'最近播放'**
  String get chatRecentPlayed;

  /// No description provided for @chatMyFavorites.
  ///
  /// In zh, this message translates to:
  /// **'我喜欢'**
  String get chatMyFavorites;

  /// No description provided for @chatNetworkLink.
  ///
  /// In zh, this message translates to:
  /// **'网络链接'**
  String get chatNetworkLink;

  /// No description provided for @chatLocalFile.
  ///
  /// In zh, this message translates to:
  /// **'本地文件'**
  String get chatLocalFile;

  /// No description provided for @chatPasteMusicLink.
  ///
  /// In zh, this message translates to:
  /// **'粘贴音乐链接'**
  String get chatPasteMusicLink;

  /// No description provided for @chatShareMusicButton.
  ///
  /// In zh, this message translates to:
  /// **'分享音乐'**
  String get chatShareMusicButton;

  /// No description provided for @chatSelectLocalAudio.
  ///
  /// In zh, this message translates to:
  /// **'选择本地音频文件'**
  String get chatSelectLocalAudio;

  /// No description provided for @chatSupportedAudioFormats.
  ///
  /// In zh, this message translates to:
  /// **'支持 MP3、M4A、WAV、FLAC 等格式'**
  String get chatSupportedAudioFormats;

  /// No description provided for @chatSelectFileButton.
  ///
  /// In zh, this message translates to:
  /// **'选择文件'**
  String get chatSelectFileButton;

  /// No description provided for @chatPleaseEnterMusicLink.
  ///
  /// In zh, this message translates to:
  /// **'请输入音乐链接'**
  String get chatPleaseEnterMusicLink;

  /// No description provided for @chatPleaseEnterValidLink.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的网络链接'**
  String get chatPleaseEnterValidLink;

  /// No description provided for @chatSharedSong.
  ///
  /// In zh, this message translates to:
  /// **'分享歌曲'**
  String get chatSharedSong;

  /// No description provided for @chatSelectMember.
  ///
  /// In zh, this message translates to:
  /// **'选择成员'**
  String get chatSelectMember;

  /// No description provided for @chatSearchMemberHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索成员'**
  String get chatSearchMemberHint;

  /// No description provided for @chatNoMatchingMembers.
  ///
  /// In zh, this message translates to:
  /// **'未找到匹配的成员'**
  String get chatNoMatchingMembers;

  /// No description provided for @commonUnknownMember.
  ///
  /// In zh, this message translates to:
  /// **'未知'**
  String get commonUnknownMember;

  /// No description provided for @chatSelectedMessagesCount.
  ///
  /// In zh, this message translates to:
  /// **'已选择 {count} 条消息'**
  String chatSelectedMessagesCount(int count);

  /// No description provided for @chatSearchContactsOrGroups.
  ///
  /// In zh, this message translates to:
  /// **'搜索联系人或群聊'**
  String get chatSearchContactsOrGroups;

  /// No description provided for @chatVideoTitle.
  ///
  /// In zh, this message translates to:
  /// **'视频'**
  String get chatVideoTitle;

  /// No description provided for @chatLoadingText.
  ///
  /// In zh, this message translates to:
  /// **'加载中...'**
  String get chatLoadingText;

  /// No description provided for @chatVideoLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'视频加载失败'**
  String get chatVideoLoadFailed;

  /// No description provided for @chatPlayerInitFailed.
  ///
  /// In zh, this message translates to:
  /// **'播放器初始化失败'**
  String get chatPlayerInitFailed;

  /// No description provided for @chatCreatePollTitle.
  ///
  /// In zh, this message translates to:
  /// **'创建投票'**
  String get chatCreatePollTitle;

  /// No description provided for @chatSubmitPoll.
  ///
  /// In zh, this message translates to:
  /// **'发起'**
  String get chatSubmitPoll;

  /// No description provided for @chatPollQuestionLabel.
  ///
  /// In zh, this message translates to:
  /// **'投票问题'**
  String get chatPollQuestionLabel;

  /// No description provided for @chatEnterPollQuestionHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入投票问题'**
  String get chatEnterPollQuestionHint;

  /// No description provided for @chatPollOptionsLabel.
  ///
  /// In zh, this message translates to:
  /// **'投票选项'**
  String get chatPollOptionsLabel;

  /// No description provided for @chatOptionHintWithIndex.
  ///
  /// In zh, this message translates to:
  /// **'选项 {index}'**
  String chatOptionHintWithIndex(int index);

  /// No description provided for @chatAddOptionButton.
  ///
  /// In zh, this message translates to:
  /// **'添加选项'**
  String get chatAddOptionButton;

  /// No description provided for @chatPollSettingsLabel.
  ///
  /// In zh, this message translates to:
  /// **'投票设置'**
  String get chatPollSettingsLabel;

  /// No description provided for @chatSelectionType.
  ///
  /// In zh, this message translates to:
  /// **'选择类型'**
  String get chatSelectionType;

  /// No description provided for @chatSingleChoiceLabel.
  ///
  /// In zh, this message translates to:
  /// **'单选'**
  String get chatSingleChoiceLabel;

  /// No description provided for @chatMultiChoiceLabel.
  ///
  /// In zh, this message translates to:
  /// **'多选'**
  String get chatMultiChoiceLabel;

  /// No description provided for @chatAnonymousPollSwitch.
  ///
  /// In zh, this message translates to:
  /// **'匿名投票'**
  String get chatAnonymousPollSwitch;

  /// No description provided for @chatPleaseEnterQuestion.
  ///
  /// In zh, this message translates to:
  /// **'请输入投票问题'**
  String get chatPleaseEnterQuestion;

  /// No description provided for @chatAtLeastTwoOptions.
  ///
  /// In zh, this message translates to:
  /// **'至少需要2个选项'**
  String get chatAtLeastTwoOptions;

  /// No description provided for @chatConfirmWithCount.
  ///
  /// In zh, this message translates to:
  /// **'确定 ({count})'**
  String chatConfirmWithCount(int count);

  /// No description provided for @authEmailVerificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'邮箱验证'**
  String get authEmailVerificationTitle;

  /// No description provided for @authEnterValidEmailAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的邮箱地址'**
  String get authEnterValidEmailAddress;

  /// No description provided for @authVerificationCodeSentTo.
  ///
  /// In zh, this message translates to:
  /// **'验证码已发送到 {email}'**
  String authVerificationCodeSentTo(String email);

  /// No description provided for @authSendCodeFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送验证码失败: {error}'**
  String authSendCodeFailed(String error);

  /// No description provided for @authVerificationSuccess.
  ///
  /// In zh, this message translates to:
  /// **'验证成功'**
  String get authVerificationSuccess;

  /// No description provided for @authVerificationFailed.
  ///
  /// In zh, this message translates to:
  /// **'验证失败'**
  String get authVerificationFailed;

  /// No description provided for @authVerificationCodeError.
  ///
  /// In zh, this message translates to:
  /// **'验证码错误: {error}'**
  String authVerificationCodeError(String error);

  /// No description provided for @commonEnterVerificationCode.
  ///
  /// In zh, this message translates to:
  /// **'输入验证码'**
  String get commonEnterVerificationCode;

  /// No description provided for @authEnterYourEmail.
  ///
  /// In zh, this message translates to:
  /// **'输入邮箱'**
  String get authEnterYourEmail;

  /// No description provided for @authWeSentCodeTo.
  ///
  /// In zh, this message translates to:
  /// **'我们已向 {email} 发送了\n6位验证码'**
  String authWeSentCodeTo(String email);

  /// No description provided for @authEnterEmailForCode.
  ///
  /// In zh, this message translates to:
  /// **'输入您的邮箱地址，我们将发送验证码'**
  String get authEnterEmailForCode;

  /// No description provided for @commonSendVerificationCode.
  ///
  /// In zh, this message translates to:
  /// **'发送验证码'**
  String get commonSendVerificationCode;

  /// No description provided for @authResendVerificationCode.
  ///
  /// In zh, this message translates to:
  /// **'重新发送验证码'**
  String get authResendVerificationCode;

  /// No description provided for @authCanResendAfter.
  ///
  /// In zh, this message translates to:
  /// **'{seconds}秒后可重新发送'**
  String authCanResendAfter(int seconds);

  /// No description provided for @commonChangeEmail.
  ///
  /// In zh, this message translates to:
  /// **'更换邮箱'**
  String get commonChangeEmail;

  /// No description provided for @contactAddToContacts.
  ///
  /// In zh, this message translates to:
  /// **'添加到通讯录'**
  String get contactAddToContacts;

  /// No description provided for @contactAddingToContacts.
  ///
  /// In zh, this message translates to:
  /// **'添加中...'**
  String get contactAddingToContacts;

  /// No description provided for @contactAddedToContacts.
  ///
  /// In zh, this message translates to:
  /// **'已添加到通讯录'**
  String get contactAddedToContacts;

  /// No description provided for @contactAddFailedWithError.
  ///
  /// In zh, this message translates to:
  /// **'添加失败: {error}'**
  String contactAddFailedWithError(String error);

  /// No description provided for @contactAddPhone.
  ///
  /// In zh, this message translates to:
  /// **'添加电话'**
  String get contactAddPhone;

  /// No description provided for @contactAddTag.
  ///
  /// In zh, this message translates to:
  /// **'添加标签'**
  String get contactAddTag;

  /// No description provided for @contactAddText.
  ///
  /// In zh, this message translates to:
  /// **'添加文字'**
  String get contactAddText;

  /// No description provided for @contactAddPhoto.
  ///
  /// In zh, this message translates to:
  /// **'添加照片'**
  String get contactAddPhoto;

  /// No description provided for @contactGroupCountLabel.
  ///
  /// In zh, this message translates to:
  /// **'{count}个'**
  String contactGroupCountLabel(int count);

  /// No description provided for @contactAddedViaSearch.
  ///
  /// In zh, this message translates to:
  /// **'通过搜索添加'**
  String get contactAddedViaSearch;

  /// No description provided for @contactAddTime.
  ///
  /// In zh, this message translates to:
  /// **'添加时间'**
  String get contactAddTime;

  /// No description provided for @contactDoneButton.
  ///
  /// In zh, this message translates to:
  /// **'完成'**
  String get contactDoneButton;

  /// No description provided for @callWaitingForParticipants.
  ///
  /// In zh, this message translates to:
  /// **'等待参与者加入...'**
  String get callWaitingForParticipants;

  /// No description provided for @callParticipantMe.
  ///
  /// In zh, this message translates to:
  /// **'{name}（我）'**
  String callParticipantMe(String name);

  /// No description provided for @callSharingLabel.
  ///
  /// In zh, this message translates to:
  /// **'共享中'**
  String get callSharingLabel;

  /// No description provided for @callScreenSharingBy.
  ///
  /// In zh, this message translates to:
  /// **'{name} 正在共享屏幕'**
  String callScreenSharingBy(String name);

  /// No description provided for @callParticipantCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人'**
  String callParticipantCount(int count);

  /// No description provided for @callMuteLabel.
  ///
  /// In zh, this message translates to:
  /// **'静音'**
  String get callMuteLabel;

  /// No description provided for @callUnmuteLabel.
  ///
  /// In zh, this message translates to:
  /// **'解除静音'**
  String get callUnmuteLabel;

  /// No description provided for @callTurnOffVideo.
  ///
  /// In zh, this message translates to:
  /// **'关闭视频'**
  String get callTurnOffVideo;

  /// No description provided for @callTurnOnVideo.
  ///
  /// In zh, this message translates to:
  /// **'开启视频'**
  String get callTurnOnVideo;

  /// No description provided for @callShareScreen.
  ///
  /// In zh, this message translates to:
  /// **'共享屏幕'**
  String get callShareScreen;

  /// No description provided for @callStopSharing.
  ///
  /// In zh, this message translates to:
  /// **'停止共享'**
  String get callStopSharing;

  /// No description provided for @callSwitchCameraLabel.
  ///
  /// In zh, this message translates to:
  /// **'切换'**
  String get callSwitchCameraLabel;

  /// No description provided for @callLeaveLabel.
  ///
  /// In zh, this message translates to:
  /// **'离开'**
  String get callLeaveLabel;

  /// No description provided for @callParticipantsLabel.
  ///
  /// In zh, this message translates to:
  /// **'参与者'**
  String get callParticipantsLabel;

  /// No description provided for @callJoiningMeeting.
  ///
  /// In zh, this message translates to:
  /// **'正在加入会议...'**
  String get callJoiningMeeting;

  /// No description provided for @chatPollVotesFormat.
  ///
  /// In zh, this message translates to:
  /// **'{count} 票 ({percentage}%)'**
  String chatPollVotesFormat(int count, String percentage);

  /// No description provided for @chatPollParticipantsFormat.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人参与'**
  String chatPollParticipantsFormat(int count);

  /// No description provided for @commonTapToRetry.
  ///
  /// In zh, this message translates to:
  /// **'点击重试'**
  String get commonTapToRetry;

  /// No description provided for @chatDefaultRedPacketGreeting.
  ///
  /// In zh, this message translates to:
  /// **'恭喜发财，大吉大利'**
  String get chatDefaultRedPacketGreeting;

  /// No description provided for @groupAllowOthersToSearchAndJoin.
  ///
  /// In zh, this message translates to:
  /// **'允许他人搜索并加入'**
  String get groupAllowOthersToSearchAndJoin;

  /// No description provided for @groupConfirmClearChatHistory.
  ///
  /// In zh, this message translates to:
  /// **'确定要清空聊天记录吗？'**
  String get groupConfirmClearChatHistory;

  /// No description provided for @groupCreateGroupToChat.
  ///
  /// In zh, this message translates to:
  /// **'创建群聊以开始聊天'**
  String get groupCreateGroupToChat;

  /// No description provided for @groupEditGroupAnnouncement.
  ///
  /// In zh, this message translates to:
  /// **'编辑群公告'**
  String get groupEditGroupAnnouncement;

  /// No description provided for @groupEditGroupDescription.
  ///
  /// In zh, this message translates to:
  /// **'编辑群描述'**
  String get groupEditGroupDescription;

  /// No description provided for @groupEnterGroupAnnouncement.
  ///
  /// In zh, this message translates to:
  /// **'请输入群公告'**
  String get groupEnterGroupAnnouncement;

  /// No description provided for @chatErrorWithMessage.
  ///
  /// In zh, this message translates to:
  /// **'错误: {message}'**
  String chatErrorWithMessage(String message);

  /// No description provided for @groupMemberCountClickToCopy.
  ///
  /// In zh, this message translates to:
  /// **'{count}人，点击复制群ID'**
  String groupMemberCountClickToCopy(int count);

  /// No description provided for @chatMusicLinkLabel.
  ///
  /// In zh, this message translates to:
  /// **'音乐链接'**
  String get chatMusicLinkLabel;

  /// No description provided for @chatNoMediaUrlAvailable.
  ///
  /// In zh, this message translates to:
  /// **'没有可用的媒体链接'**
  String get chatNoMediaUrlAvailable;

  /// No description provided for @groupNoPermissionToEditGroupName.
  ///
  /// In zh, this message translates to:
  /// **'你没有权限修改群名称'**
  String get groupNoPermissionToEditGroupName;

  /// No description provided for @chatRedPacketTransferCannotForward.
  ///
  /// In zh, this message translates to:
  /// **'红包和转账消息无法转发'**
  String get chatRedPacketTransferCannotForward;

  /// No description provided for @authEmailAddress.
  ///
  /// In zh, this message translates to:
  /// **'邮箱地址'**
  String get authEmailAddress;

  /// No description provided for @commonEnterEmailAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入邮箱地址'**
  String get commonEnterEmailAddress;

  /// No description provided for @authEmailRecoveryHint.
  ///
  /// In zh, this message translates to:
  /// **'用于找回密码'**
  String get authEmailRecoveryHint;

  /// No description provided for @commonInvalidEmailFormat.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的邮箱地址'**
  String get commonInvalidEmailFormat;

  /// No description provided for @authOptional.
  ///
  /// In zh, this message translates to:
  /// **'选填'**
  String get authOptional;

  /// No description provided for @authResetPassword.
  ///
  /// In zh, this message translates to:
  /// **'重置密码'**
  String get authResetPassword;

  /// No description provided for @authEnterRegisteredEmail.
  ///
  /// In zh, this message translates to:
  /// **'请输入注册时绑定的邮箱地址'**
  String get authEnterRegisteredEmail;

  /// No description provided for @authSendResetCode.
  ///
  /// In zh, this message translates to:
  /// **'发送重置验证码'**
  String get authSendResetCode;

  /// No description provided for @authResetCodeSent.
  ///
  /// In zh, this message translates to:
  /// **'重置验证码已发送至 {email}'**
  String authResetCodeSent(String email);

  /// No description provided for @authEnterResetCode.
  ///
  /// In zh, this message translates to:
  /// **'输入重置验证码'**
  String get authEnterResetCode;

  /// No description provided for @authSetNewPassword.
  ///
  /// In zh, this message translates to:
  /// **'设置新密码'**
  String get authSetNewPassword;

  /// No description provided for @commonConfirmNewPassword.
  ///
  /// In zh, this message translates to:
  /// **'确认新密码'**
  String get commonConfirmNewPassword;

  /// No description provided for @commonNewPassword.
  ///
  /// In zh, this message translates to:
  /// **'新密码'**
  String get commonNewPassword;

  /// No description provided for @authPasswordResetSuccess.
  ///
  /// In zh, this message translates to:
  /// **'密码重置成功，请使用新密码登录'**
  String get authPasswordResetSuccess;

  /// No description provided for @authResetPasswordFailed.
  ///
  /// In zh, this message translates to:
  /// **'重置密码失败'**
  String get authResetPasswordFailed;

  /// No description provided for @settingsChangePassword.
  ///
  /// In zh, this message translates to:
  /// **'修改密码'**
  String get settingsChangePassword;

  /// No description provided for @settingsCurrentPassword.
  ///
  /// In zh, this message translates to:
  /// **'当前密码'**
  String get settingsCurrentPassword;

  /// No description provided for @settingsEnterCurrentPassword.
  ///
  /// In zh, this message translates to:
  /// **'请输入当前密码'**
  String get settingsEnterCurrentPassword;

  /// No description provided for @settingsEnterNewPassword.
  ///
  /// In zh, this message translates to:
  /// **'请输入新密码'**
  String get settingsEnterNewPassword;

  /// No description provided for @settingsPasswordChanged.
  ///
  /// In zh, this message translates to:
  /// **'密码修改成功，请使用新密码重新登录'**
  String get settingsPasswordChanged;

  /// No description provided for @settingsChangePasswordFailed.
  ///
  /// In zh, this message translates to:
  /// **'修改密码失败'**
  String get settingsChangePasswordFailed;

  /// No description provided for @settingsNewPasswordMustBeDifferent.
  ///
  /// In zh, this message translates to:
  /// **'新密码不能与当前密码相同'**
  String get settingsNewPasswordMustBeDifferent;

  /// No description provided for @settingsChangePasswordInfo.
  ///
  /// In zh, this message translates to:
  /// **'修改密码后，您将被登出，需要使用新密码重新登录。'**
  String get settingsChangePasswordInfo;

  /// No description provided for @settingsPasswordRequirements.
  ///
  /// In zh, this message translates to:
  /// **'密码要求：'**
  String get settingsPasswordRequirements;

  /// No description provided for @settingsSecurityNote.
  ///
  /// In zh, this message translates to:
  /// **'为了安全，修改密码后需要在所有设备上重新登录。'**
  String get settingsSecurityNote;

  /// No description provided for @settingsSecurity.
  ///
  /// In zh, this message translates to:
  /// **'安全'**
  String get settingsSecurity;

  /// No description provided for @settingsCurrentBoundEmail.
  ///
  /// In zh, this message translates to:
  /// **'当前绑定邮箱'**
  String get settingsCurrentBoundEmail;

  /// No description provided for @settingsNewEmailAddress.
  ///
  /// In zh, this message translates to:
  /// **'新邮箱地址'**
  String get settingsNewEmailAddress;

  /// No description provided for @settingsEnterNewEmail.
  ///
  /// In zh, this message translates to:
  /// **'请输入新邮箱地址'**
  String get settingsEnterNewEmail;

  /// No description provided for @settingsVerificationCode.
  ///
  /// In zh, this message translates to:
  /// **'验证码'**
  String get settingsVerificationCode;

  /// No description provided for @settingsVerificationCodeSent.
  ///
  /// In zh, this message translates to:
  /// **'验证码已发送'**
  String get settingsVerificationCodeSent;

  /// No description provided for @settingsCodeSentTo.
  ///
  /// In zh, this message translates to:
  /// **'验证码已发送至'**
  String get settingsCodeSentTo;

  /// No description provided for @settingsDidNotReceiveCode.
  ///
  /// In zh, this message translates to:
  /// **'没有收到验证码？'**
  String get settingsDidNotReceiveCode;

  /// No description provided for @settingsEmailChangedSuccess.
  ///
  /// In zh, this message translates to:
  /// **'邮箱修改成功'**
  String get settingsEmailChangedSuccess;

  /// No description provided for @settingsChangeEmailFailed.
  ///
  /// In zh, this message translates to:
  /// **'修改邮箱失败'**
  String get settingsChangeEmailFailed;

  /// No description provided for @settingsEmailSecurityNote.
  ///
  /// In zh, this message translates to:
  /// **'邮箱用于密码找回，请确保安全。'**
  String get settingsEmailSecurityNote;

  /// No description provided for @commonGoogleLogin.
  ///
  /// In zh, this message translates to:
  /// **'使用 Google 登录'**
  String get commonGoogleLogin;

  /// No description provided for @commonAppleLogin.
  ///
  /// In zh, this message translates to:
  /// **'使用 Apple 登录'**
  String get commonAppleLogin;

  /// No description provided for @commonWechat.
  ///
  /// In zh, this message translates to:
  /// **'微信'**
  String get commonWechat;

  /// No description provided for @settingsLanguage.
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageChanged.
  ///
  /// In zh, this message translates to:
  /// **'语言已更改'**
  String get settingsLanguageChanged;

  /// No description provided for @settingsBiometricLogin.
  ///
  /// In zh, this message translates to:
  /// **'生物识别登录'**
  String get settingsBiometricLogin;

  /// No description provided for @authLoginWithBiometric.
  ///
  /// In zh, this message translates to:
  /// **'使用{type}登录'**
  String authLoginWithBiometric(Object type);

  /// No description provided for @settingsBiometricLoginEnabled.
  ///
  /// In zh, this message translates to:
  /// **'生物识别登录已启用'**
  String get settingsBiometricLoginEnabled;

  /// No description provided for @settingsBiometricLoginDisabled.
  ///
  /// In zh, this message translates to:
  /// **'生物识别登录已禁用'**
  String get settingsBiometricLoginDisabled;

  /// No description provided for @settingsEnableBiometricLogin.
  ///
  /// In zh, this message translates to:
  /// **'启用生物识别登录'**
  String get settingsEnableBiometricLogin;

  /// No description provided for @settingsBiometricEnabled.
  ///
  /// In zh, this message translates to:
  /// **'已启用 - 使用生物识别登录'**
  String get settingsBiometricEnabled;

  /// No description provided for @settingsBiometricDisabled.
  ///
  /// In zh, this message translates to:
  /// **'已禁用 - 点击启用'**
  String get settingsBiometricDisabled;

  /// No description provided for @settingsBiometricNeedRelogin.
  ///
  /// In zh, this message translates to:
  /// **'请退出后重新登录以启用生物识别'**
  String get settingsBiometricNeedRelogin;

  /// No description provided for @authOr.
  ///
  /// In zh, this message translates to:
  /// **'或'**
  String get authOr;

  /// No description provided for @qrcodeCameraPermissionRestricted.
  ///
  /// In zh, this message translates to:
  /// **'此设备上的相机访问受限'**
  String get qrcodeCameraPermissionRestricted;

  /// No description provided for @authPasskeyLabel.
  ///
  /// In zh, this message translates to:
  /// **'Passkey'**
  String get authPasskeyLabel;

  /// No description provided for @authGoogleLabel.
  ///
  /// In zh, this message translates to:
  /// **'Google'**
  String get authGoogleLabel;

  /// No description provided for @authAppleLabel.
  ///
  /// In zh, this message translates to:
  /// **'Apple'**
  String get authAppleLabel;

  /// No description provided for @authSsoLabel.
  ///
  /// In zh, this message translates to:
  /// **'SSO'**
  String get authSsoLabel;

  /// No description provided for @transferAmountHintZero.
  ///
  /// In zh, this message translates to:
  /// **'0.00'**
  String get transferAmountHintZero;

  /// No description provided for @commonMatrixIdHint.
  ///
  /// In zh, this message translates to:
  /// **'@username:server.com'**
  String get commonMatrixIdHint;

  /// No description provided for @authServerAddressHint.
  ///
  /// In zh, this message translates to:
  /// **'https://m.si46.world'**
  String get authServerAddressHint;

  /// No description provided for @authEmailExampleHint.
  ///
  /// In zh, this message translates to:
  /// **'example@email.com'**
  String get authEmailExampleHint;

  /// No description provided for @authVerificationCodePlaceholder.
  ///
  /// In zh, this message translates to:
  /// **'------'**
  String get authVerificationCodePlaceholder;

  /// No description provided for @profileEnterPokeSuffixHint.
  ///
  /// In zh, this message translates to:
  /// **'输入戳一戳后缀，例如：的肩膀'**
  String get profileEnterPokeSuffixHint;

  /// No description provided for @groupAlbum.
  ///
  /// In zh, this message translates to:
  /// **'群相册'**
  String get groupAlbum;

  /// No description provided for @groupFiles.
  ///
  /// In zh, this message translates to:
  /// **'群文件'**
  String get groupFiles;

  /// No description provided for @groupImages.
  ///
  /// In zh, this message translates to:
  /// **'图片'**
  String get groupImages;

  /// No description provided for @groupVideos.
  ///
  /// In zh, this message translates to:
  /// **'视频'**
  String get groupVideos;

  /// No description provided for @groupTotal.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get groupTotal;

  /// No description provided for @groupSize.
  ///
  /// In zh, this message translates to:
  /// **'大小'**
  String get groupSize;

  /// No description provided for @groupNoMedia.
  ///
  /// In zh, this message translates to:
  /// **'暂无媒体'**
  String get groupNoMedia;

  /// No description provided for @groupNoMediaDescription.
  ///
  /// In zh, this message translates to:
  /// **'此群还没有图片或视频'**
  String get groupNoMediaDescription;

  /// No description provided for @groupDocuments.
  ///
  /// In zh, this message translates to:
  /// **'文档'**
  String get groupDocuments;

  /// No description provided for @groupNoFiles.
  ///
  /// In zh, this message translates to:
  /// **'暂无文件'**
  String get groupNoFiles;

  /// No description provided for @groupNoFilesDescription.
  ///
  /// In zh, this message translates to:
  /// **'此群还没有文件'**
  String get groupNoFilesDescription;

  /// No description provided for @groupDownloadStarted.
  ///
  /// In zh, this message translates to:
  /// **'正在下载 {filename}...'**
  String groupDownloadStarted(String filename);

  /// No description provided for @contactNoCommonGroups.
  ///
  /// In zh, this message translates to:
  /// **'暂无共同群组'**
  String get contactNoCommonGroups;

  /// No description provided for @contactNoCommonGroupsDescription.
  ///
  /// In zh, this message translates to:
  /// **'你们没有共同加入的群组'**
  String get contactNoCommonGroupsDescription;

  /// No description provided for @chatVoiceMessage.
  ///
  /// In zh, this message translates to:
  /// **'语音'**
  String get chatVoiceMessage;

  /// No description provided for @chatMessage.
  ///
  /// In zh, this message translates to:
  /// **'消息'**
  String get chatMessage;

  /// No description provided for @conversationHideChat.
  ///
  /// In zh, this message translates to:
  /// **'隐藏'**
  String get conversationHideChat;

  /// No description provided for @settingsQuickReply.
  ///
  /// In zh, this message translates to:
  /// **'快捷回复'**
  String get settingsQuickReply;

  /// No description provided for @commonTranslate.
  ///
  /// In zh, this message translates to:
  /// **'翻译'**
  String get commonTranslate;

  /// No description provided for @contactCreateTag.
  ///
  /// In zh, this message translates to:
  /// **'新建标签'**
  String get contactCreateTag;

  /// No description provided for @contactEnterTagName.
  ///
  /// In zh, this message translates to:
  /// **'输入标签名称'**
  String get contactEnterTagName;

  /// No description provided for @contactEditTag.
  ///
  /// In zh, this message translates to:
  /// **'编辑标签'**
  String get contactEditTag;

  /// No description provided for @contactDeleteTag.
  ///
  /// In zh, this message translates to:
  /// **'删除标签'**
  String get contactDeleteTag;

  /// No description provided for @contactDeleteTagConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除标签 \"{tagName}\" 吗？'**
  String contactDeleteTagConfirm(String tagName);

  /// No description provided for @contactNoTags.
  ///
  /// In zh, this message translates to:
  /// **'暂无标签'**
  String get contactNoTags;

  /// No description provided for @contactFriendPermissions.
  ///
  /// In zh, this message translates to:
  /// **'朋友权限'**
  String get contactFriendPermissions;

  /// No description provided for @contactSetChatOnly.
  ///
  /// In zh, this message translates to:
  /// **'设为仅聊天'**
  String get contactSetChatOnly;

  /// No description provided for @contactChatOnlyDesc.
  ///
  /// In zh, this message translates to:
  /// **'只能聊天，其他内容将被隐藏'**
  String get contactChatOnlyDesc;

  /// No description provided for @contactHideMyMoments.
  ///
  /// In zh, this message translates to:
  /// **'不让他（她）看我的朋友圈'**
  String get contactHideMyMoments;

  /// No description provided for @contactHideMyMomentsDesc.
  ///
  /// In zh, this message translates to:
  /// **'该好友无法查看你的朋友圈动态'**
  String get contactHideMyMomentsDesc;

  /// No description provided for @contactHideTheirMoments.
  ///
  /// In zh, this message translates to:
  /// **'不看他（她）的朋友圈'**
  String get contactHideTheirMoments;

  /// No description provided for @contactHideTheirMomentsDesc.
  ///
  /// In zh, this message translates to:
  /// **'不会看到该好友的朋友圈动态'**
  String get contactHideTheirMomentsDesc;

  /// No description provided for @contactHideMyStatus.
  ///
  /// In zh, this message translates to:
  /// **'不让他（她）看我的状态'**
  String get contactHideMyStatus;

  /// No description provided for @contactHideMyStatusDesc.
  ///
  /// In zh, this message translates to:
  /// **'该好友无法查看你的状态更新'**
  String get contactHideMyStatusDesc;

  /// No description provided for @contactNoChatOnlyFriends.
  ///
  /// In zh, this message translates to:
  /// **'暂无仅聊天的朋友'**
  String get contactNoChatOnlyFriends;

  /// No description provided for @contactNoOfficialAccounts.
  ///
  /// In zh, this message translates to:
  /// **'暂无公众号'**
  String get contactNoOfficialAccounts;

  /// No description provided for @contactFollowOfficialAccountsDesc.
  ///
  /// In zh, this message translates to:
  /// **'关注公众号，获取最新资讯'**
  String get contactFollowOfficialAccountsDesc;

  /// No description provided for @contactNoServiceAccounts.
  ///
  /// In zh, this message translates to:
  /// **'暂无服务号'**
  String get contactNoServiceAccounts;

  /// No description provided for @contactSubscribeServiceAccountsDesc.
  ///
  /// In zh, this message translates to:
  /// **'订阅服务号，享受便捷服务'**
  String get contactSubscribeServiceAccountsDesc;

  /// No description provided for @contactNoEnterpriseContacts.
  ///
  /// In zh, this message translates to:
  /// **'暂无企业联系人'**
  String get contactNoEnterpriseContacts;

  /// No description provided for @contactEnterpriseContactsDesc.
  ///
  /// In zh, this message translates to:
  /// **'企业通讯录联系人将显示在这里'**
  String get contactEnterpriseContactsDesc;

  /// No description provided for @profileCardPack.
  ///
  /// In zh, this message translates to:
  /// **'卡包'**
  String get profileCardPack;

  /// No description provided for @profileOrders.
  ///
  /// In zh, this message translates to:
  /// **'订单'**
  String get profileOrders;

  /// No description provided for @profileNoOrders.
  ///
  /// In zh, this message translates to:
  /// **'暂无订单'**
  String get profileNoOrders;

  /// No description provided for @profileOrdersDesc.
  ///
  /// In zh, this message translates to:
  /// **'你的订单将显示在这里'**
  String get profileOrdersDesc;

  /// No description provided for @profileNoCards.
  ///
  /// In zh, this message translates to:
  /// **'暂无卡券'**
  String get profileNoCards;

  /// No description provided for @profileCardsDesc.
  ///
  /// In zh, this message translates to:
  /// **'你的卡券将显示在这里'**
  String get profileCardsDesc;

  /// No description provided for @favoriteEnterTagsHint.
  ///
  /// In zh, this message translates to:
  /// **'输入标签，用逗号分隔'**
  String get favoriteEnterTagsHint;

  /// No description provided for @favoriteTagsUpdated.
  ///
  /// In zh, this message translates to:
  /// **'标签已更新'**
  String get favoriteTagsUpdated;

  /// No description provided for @favoriteForwardedContent.
  ///
  /// In zh, this message translates to:
  /// **'内容已转发'**
  String get favoriteForwardedContent;

  /// No description provided for @favoriteEnterNoteContent.
  ///
  /// In zh, this message translates to:
  /// **'输入笔记内容'**
  String get favoriteEnterNoteContent;

  /// No description provided for @favoriteNoteAdded.
  ///
  /// In zh, this message translates to:
  /// **'笔记已添加'**
  String get favoriteNoteAdded;

  /// No description provided for @favoriteLinkTitle.
  ///
  /// In zh, this message translates to:
  /// **'链接标题'**
  String get favoriteLinkTitle;

  /// No description provided for @favoriteLinkUrl.
  ///
  /// In zh, this message translates to:
  /// **'https://'**
  String get favoriteLinkUrl;

  /// No description provided for @favoriteLinkAdded.
  ///
  /// In zh, this message translates to:
  /// **'链接已添加'**
  String get favoriteLinkAdded;

  /// No description provided for @contactPhotoAdded.
  ///
  /// In zh, this message translates to:
  /// **'照片已添加'**
  String get contactPhotoAdded;

  /// No description provided for @contactEnterPhone.
  ///
  /// In zh, this message translates to:
  /// **'输入手机号码'**
  String get contactEnterPhone;

  /// No description provided for @commonConversationWithId.
  ///
  /// In zh, this message translates to:
  /// **'会话: {roomId}'**
  String commonConversationWithId(String roomId);

  /// No description provided for @commonContactWithId.
  ///
  /// In zh, this message translates to:
  /// **'联系人: {userId}'**
  String commonContactWithId(String userId);

  /// No description provided for @commonDiscover.
  ///
  /// In zh, this message translates to:
  /// **'发现'**
  String get commonDiscover;

  /// No description provided for @commonDeveloping.
  ///
  /// In zh, this message translates to:
  /// **'{title}\n(开发中)'**
  String commonDeveloping(String title);

  /// No description provided for @commonPageNotFound.
  ///
  /// In zh, this message translates to:
  /// **'页面不存在'**
  String get commonPageNotFound;

  /// No description provided for @commonBackToHome.
  ///
  /// In zh, this message translates to:
  /// **'返回首页'**
  String get commonBackToHome;

  /// No description provided for @settingsMessageNotifications.
  ///
  /// In zh, this message translates to:
  /// **'消息通知'**
  String get settingsMessageNotifications;

  /// No description provided for @settingsReceiveNewMessageNotifications.
  ///
  /// In zh, this message translates to:
  /// **'接收新消息通知'**
  String get settingsReceiveNewMessageNotifications;

  /// No description provided for @settingsShowMessagePreview.
  ///
  /// In zh, this message translates to:
  /// **'显示消息预览'**
  String get settingsShowMessagePreview;

  /// No description provided for @settingsShowMessageContentInNotification.
  ///
  /// In zh, this message translates to:
  /// **'在通知中显示消息内容'**
  String get settingsShowMessageContentInNotification;

  /// No description provided for @settingsNotificationSound.
  ///
  /// In zh, this message translates to:
  /// **'通知声音'**
  String get settingsNotificationSound;

  /// No description provided for @settingsPlaySoundOnMessage.
  ///
  /// In zh, this message translates to:
  /// **'收到消息时播放声音'**
  String get settingsPlaySoundOnMessage;

  /// No description provided for @commonVibration.
  ///
  /// In zh, this message translates to:
  /// **'振动'**
  String get commonVibration;

  /// No description provided for @settingsVibrateOnMessage.
  ///
  /// In zh, this message translates to:
  /// **'收到消息时震动'**
  String get settingsVibrateOnMessage;

  /// No description provided for @settingsDoNotDisturbMode.
  ///
  /// In zh, this message translates to:
  /// **'勿扰模式'**
  String get settingsDoNotDisturbMode;

  /// No description provided for @settingsDoNotDisturbDescription.
  ///
  /// In zh, this message translates to:
  /// **'在指定时间内不接收通知'**
  String get settingsDoNotDisturbDescription;

  /// No description provided for @settingsStartTime.
  ///
  /// In zh, this message translates to:
  /// **'开始时间'**
  String get settingsStartTime;

  /// No description provided for @settingsEndTime.
  ///
  /// In zh, this message translates to:
  /// **'结束时间'**
  String get settingsEndTime;

  /// No description provided for @settingsDeleteQuickReply.
  ///
  /// In zh, this message translates to:
  /// **'删除快捷回复'**
  String get settingsDeleteQuickReply;

  /// No description provided for @settingsEditQuickReply.
  ///
  /// In zh, this message translates to:
  /// **'编辑快捷回复'**
  String get settingsEditQuickReply;

  /// No description provided for @settingsAddQuickReply.
  ///
  /// In zh, this message translates to:
  /// **'添加快捷回复'**
  String get settingsAddQuickReply;

  /// No description provided for @settingsManageQuickReplies.
  ///
  /// In zh, this message translates to:
  /// **'管理快捷回复'**
  String get settingsManageQuickReplies;

  /// No description provided for @settingsNoQuickReplies.
  ///
  /// In zh, this message translates to:
  /// **'暂无快捷回复'**
  String get settingsNoQuickReplies;

  /// No description provided for @settingsDefaultQuickReplies.
  ///
  /// In zh, this message translates to:
  /// **'将显示默认快捷回复'**
  String get settingsDefaultQuickReplies;

  /// No description provided for @settingsWhoCanSee.
  ///
  /// In zh, this message translates to:
  /// **'谁可以查看'**
  String get settingsWhoCanSee;

  /// No description provided for @settingsLastSeen.
  ///
  /// In zh, this message translates to:
  /// **'最后上线时间'**
  String get settingsLastSeen;

  /// No description provided for @settingsHiddenChats.
  ///
  /// In zh, this message translates to:
  /// **'隐藏的聊天'**
  String get settingsHiddenChats;

  /// No description provided for @settingsMessagesLabel.
  ///
  /// In zh, this message translates to:
  /// **'消息'**
  String get settingsMessagesLabel;

  /// No description provided for @settingsAllowStrangerMessages.
  ///
  /// In zh, this message translates to:
  /// **'允许陌生人消息'**
  String get settingsAllowStrangerMessages;

  /// No description provided for @settingsReceiveMessagesFromNonContacts.
  ///
  /// In zh, this message translates to:
  /// **'接收非联系人的消息'**
  String get settingsReceiveMessagesFromNonContacts;

  /// No description provided for @settingsReadReceipts.
  ///
  /// In zh, this message translates to:
  /// **'已读回执'**
  String get settingsReadReceipts;

  /// No description provided for @settingsLetOthersKnowYouRead.
  ///
  /// In zh, this message translates to:
  /// **'让对方知道你已读'**
  String get settingsLetOthersKnowYouRead;

  /// No description provided for @settingsTypingIndicator.
  ///
  /// In zh, this message translates to:
  /// **'输入状态指示'**
  String get settingsTypingIndicator;

  /// No description provided for @settingsLetOthersKnowYouTyping.
  ///
  /// In zh, this message translates to:
  /// **'让对方知道你正在输入'**
  String get settingsLetOthersKnowYouTyping;

  /// No description provided for @settingsEveryone.
  ///
  /// In zh, this message translates to:
  /// **'所有人'**
  String get settingsEveryone;

  /// No description provided for @settingsContactsOnly.
  ///
  /// In zh, this message translates to:
  /// **'仅联系人'**
  String get settingsContactsOnly;

  /// No description provided for @settingsNobody.
  ///
  /// In zh, this message translates to:
  /// **'无人'**
  String get settingsNobody;

  /// No description provided for @settingsWhoCanSeeTitle.
  ///
  /// In zh, this message translates to:
  /// **'谁可以看到 {title}'**
  String settingsWhoCanSeeTitle(String title);

  /// No description provided for @settingsVersionInfo.
  ///
  /// In zh, this message translates to:
  /// **'版本 {version}'**
  String settingsVersionInfo(String version);

  /// No description provided for @settingsCheckForUpdates.
  ///
  /// In zh, this message translates to:
  /// **'检查更新'**
  String get settingsCheckForUpdates;

  /// No description provided for @settingsOpenSourceLicenses.
  ///
  /// In zh, this message translates to:
  /// **'开源许可'**
  String get settingsOpenSourceLicenses;

  /// No description provided for @settingsFeedbackAndSuggestions.
  ///
  /// In zh, this message translates to:
  /// **'反馈与建议'**
  String get settingsFeedbackAndSuggestions;

  /// No description provided for @settingsBuiltOnMatrix.
  ///
  /// In zh, this message translates to:
  /// **'基于 Matrix 协议构建'**
  String get settingsBuiltOnMatrix;

  /// No description provided for @settingsNoHiddenChats.
  ///
  /// In zh, this message translates to:
  /// **'没有隐藏的聊天'**
  String get settingsNoHiddenChats;

  /// No description provided for @settingsNoHiddenChatsDescription.
  ///
  /// In zh, this message translates to:
  /// **'你隐藏的聊天会显示在这里'**
  String get settingsNoHiddenChatsDescription;

  /// No description provided for @settingsUnhideChat.
  ///
  /// In zh, this message translates to:
  /// **'取消隐藏'**
  String get settingsUnhideChat;

  /// No description provided for @settingsDarkMode.
  ///
  /// In zh, this message translates to:
  /// **'深色模式'**
  String get settingsDarkMode;

  /// No description provided for @settingsFontSize.
  ///
  /// In zh, this message translates to:
  /// **'字体大小'**
  String get settingsFontSize;

  /// No description provided for @settingsBubbleStyle.
  ///
  /// In zh, this message translates to:
  /// **'气泡样式'**
  String get settingsBubbleStyle;

  /// No description provided for @settingsFollowSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get settingsFollowSystem;

  /// No description provided for @settingsAutoSwitchBySystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统自动切换'**
  String get settingsAutoSwitchBySystem;

  /// No description provided for @settingsLightMode.
  ///
  /// In zh, this message translates to:
  /// **'浅色模式'**
  String get settingsLightMode;

  /// No description provided for @settingsAlwaysUseLightTheme.
  ///
  /// In zh, this message translates to:
  /// **'始终使用浅色主题'**
  String get settingsAlwaysUseLightTheme;

  /// No description provided for @settingsDarkModeOption.
  ///
  /// In zh, this message translates to:
  /// **'深色模式选项'**
  String get settingsDarkModeOption;

  /// No description provided for @settingsAlwaysUseDarkTheme.
  ///
  /// In zh, this message translates to:
  /// **'始终使用深色主题'**
  String get settingsAlwaysUseDarkTheme;

  /// No description provided for @settingsFontSizeSmall.
  ///
  /// In zh, this message translates to:
  /// **'小'**
  String get settingsFontSizeSmall;

  /// No description provided for @settingsFontSizeStandard.
  ///
  /// In zh, this message translates to:
  /// **'标准'**
  String get settingsFontSizeStandard;

  /// No description provided for @settingsFontSizeLarge.
  ///
  /// In zh, this message translates to:
  /// **'大'**
  String get settingsFontSizeLarge;

  /// No description provided for @settingsFontSizeExtraLarge.
  ///
  /// In zh, this message translates to:
  /// **'特大'**
  String get settingsFontSizeExtraLarge;

  /// No description provided for @settingsBubbleStyleWechat.
  ///
  /// In zh, this message translates to:
  /// **'微信样式'**
  String get settingsBubbleStyleWechat;

  /// No description provided for @settingsBubbleStyleWechatDesc.
  ///
  /// In zh, this message translates to:
  /// **'经典微信气泡样式'**
  String get settingsBubbleStyleWechatDesc;

  /// No description provided for @settingsBubbleStyleModern.
  ///
  /// In zh, this message translates to:
  /// **'现代样式'**
  String get settingsBubbleStyleModern;

  /// No description provided for @settingsBubbleStyleModernDesc.
  ///
  /// In zh, this message translates to:
  /// **'简洁的现代气泡样式'**
  String get settingsBubbleStyleModernDesc;

  /// No description provided for @settingsBubbleStyleClassic.
  ///
  /// In zh, this message translates to:
  /// **'经典样式'**
  String get settingsBubbleStyleClassic;

  /// No description provided for @settingsBubbleStyleClassicDesc.
  ///
  /// In zh, this message translates to:
  /// **'传统的气泡样式'**
  String get settingsBubbleStyleClassicDesc;

  /// No description provided for @discoverVideoChannels.
  ///
  /// In zh, this message translates to:
  /// **'视频号'**
  String get discoverVideoChannels;

  /// No description provided for @discoverLive.
  ///
  /// In zh, this message translates to:
  /// **'直播'**
  String get discoverLive;

  /// No description provided for @discoverListen.
  ///
  /// In zh, this message translates to:
  /// **'听一听'**
  String get discoverListen;

  /// No description provided for @discoverWatch.
  ///
  /// In zh, this message translates to:
  /// **'看一看'**
  String get discoverWatch;

  /// No description provided for @discoverSearchDiscover.
  ///
  /// In zh, this message translates to:
  /// **'搜一搜'**
  String get discoverSearchDiscover;

  /// No description provided for @discoverNearbyPeople.
  ///
  /// In zh, this message translates to:
  /// **'附近的人'**
  String get discoverNearbyPeople;

  /// No description provided for @discoverGames.
  ///
  /// In zh, this message translates to:
  /// **'游戏'**
  String get discoverGames;

  /// No description provided for @discoverMiniPrograms.
  ///
  /// In zh, this message translates to:
  /// **'小程序'**
  String get discoverMiniPrograms;

  /// No description provided for @chatAlreadyInCall.
  ///
  /// In zh, this message translates to:
  /// **'当前正在通话中'**
  String get chatAlreadyInCall;

  /// No description provided for @commonConnectionFailed.
  ///
  /// In zh, this message translates to:
  /// **'连接失败'**
  String get commonConnectionFailed;

  /// No description provided for @chatCallRejected.
  ///
  /// In zh, this message translates to:
  /// **'对方已拒绝'**
  String get chatCallRejected;

  /// No description provided for @chatNoAnswer.
  ///
  /// In zh, this message translates to:
  /// **'对方无应答'**
  String get chatNoAnswer;

  /// No description provided for @commonClose.
  ///
  /// In zh, this message translates to:
  /// **'关闭'**
  String get commonClose;

  /// No description provided for @chatSelectContact.
  ///
  /// In zh, this message translates to:
  /// **'选择联系人'**
  String get chatSelectContact;

  /// No description provided for @chatVoteRemoved.
  ///
  /// In zh, this message translates to:
  /// **'已取消投票'**
  String get chatVoteRemoved;

  /// No description provided for @chatVoteChanged.
  ///
  /// In zh, this message translates to:
  /// **'投票已更改'**
  String get chatVoteChanged;

  /// No description provided for @chatVoted.
  ///
  /// In zh, this message translates to:
  /// **'已投票'**
  String get chatVoted;

  /// No description provided for @chatReplyTo.
  ///
  /// In zh, this message translates to:
  /// **'回复 {name}'**
  String chatReplyTo(String name);

  /// No description provided for @chatCurrentLocation.
  ///
  /// In zh, this message translates to:
  /// **'当前位置'**
  String get chatCurrentLocation;

  /// No description provided for @chatNearbyPlace.
  ///
  /// In zh, this message translates to:
  /// **'附近地点 {index}'**
  String chatNearbyPlace(int index);

  /// No description provided for @chatApproximateDistance.
  ///
  /// In zh, this message translates to:
  /// **'约 {distance}'**
  String chatApproximateDistance(String distance);

  /// No description provided for @chatAddress.
  ///
  /// In zh, this message translates to:
  /// **'地址'**
  String get chatAddress;

  /// No description provided for @chatLatitude.
  ///
  /// In zh, this message translates to:
  /// **'纬度'**
  String get chatLatitude;

  /// No description provided for @chatLongitude.
  ///
  /// In zh, this message translates to:
  /// **'经度'**
  String get chatLongitude;

  /// No description provided for @groupDescriptionUpdated.
  ///
  /// In zh, this message translates to:
  /// **'群简介已更新'**
  String get groupDescriptionUpdated;

  /// No description provided for @groupAvatarUpdated.
  ///
  /// In zh, this message translates to:
  /// **'群头像已更新'**
  String get groupAvatarUpdated;

  /// No description provided for @callDecline.
  ///
  /// In zh, this message translates to:
  /// **'拒绝'**
  String get callDecline;

  /// No description provided for @callAnswer.
  ///
  /// In zh, this message translates to:
  /// **'接听'**
  String get callAnswer;

  /// No description provided for @callIncomingVideoCall.
  ///
  /// In zh, this message translates to:
  /// **'视频来电'**
  String get callIncomingVideoCall;

  /// No description provided for @callIncomingVoiceCall.
  ///
  /// In zh, this message translates to:
  /// **'语音来电'**
  String get callIncomingVoiceCall;

  /// No description provided for @callVideoCallInProgress.
  ///
  /// In zh, this message translates to:
  /// **'视频通话中'**
  String get callVideoCallInProgress;

  /// No description provided for @callVoiceCallInProgress.
  ///
  /// In zh, this message translates to:
  /// **'语音通话中'**
  String get callVoiceCallInProgress;

  /// No description provided for @callReconnectingCall.
  ///
  /// In zh, this message translates to:
  /// **'正在重连...'**
  String get callReconnectingCall;

  /// No description provided for @callEnded.
  ///
  /// In zh, this message translates to:
  /// **'通话已结束'**
  String get callEnded;

  /// No description provided for @callFailed.
  ///
  /// In zh, this message translates to:
  /// **'通话失败'**
  String get callFailed;

  /// No description provided for @callLivekitNotConfigured.
  ///
  /// In zh, this message translates to:
  /// **'LiveKit 未配置'**
  String get callLivekitNotConfigured;

  /// No description provided for @callJoinMeetingFailed.
  ///
  /// In zh, this message translates to:
  /// **'加入会议失败: {error}'**
  String callJoinMeetingFailed(String error);

  /// No description provided for @callScreenShareFailed.
  ///
  /// In zh, this message translates to:
  /// **'屏幕共享失败: {error}'**
  String callScreenShareFailed(String error);

  /// No description provided for @profileN42BeanTitle.
  ///
  /// In zh, this message translates to:
  /// **'N42豆'**
  String get profileN42BeanTitle;

  /// No description provided for @profileNoN42Bean.
  ///
  /// In zh, this message translates to:
  /// **'暂无N42豆'**
  String get profileNoN42Bean;

  /// No description provided for @profileN42BeanDetails.
  ///
  /// In zh, this message translates to:
  /// **'N42豆明细'**
  String get profileN42BeanDetails;

  /// No description provided for @profileN42BeanDescription.
  ///
  /// In zh, this message translates to:
  /// **'N42豆是用于兑换N42内虚拟物品和服务的道具，目前可用于兑换：'**
  String get profileN42BeanDescription;

  /// No description provided for @profileN42BeanFeature1.
  ///
  /// In zh, this message translates to:
  /// **'会员专属表情和主题'**
  String get profileN42BeanFeature1;

  /// No description provided for @profileN42BeanFeature2.
  ///
  /// In zh, this message translates to:
  /// **'聊天气泡个性化'**
  String get profileN42BeanFeature2;

  /// No description provided for @profileN42BeanFeature3.
  ///
  /// In zh, this message translates to:
  /// **'红包封面定制'**
  String get profileN42BeanFeature3;

  /// No description provided for @profileN42BeanFeature4.
  ///
  /// In zh, this message translates to:
  /// **'专属昵称标识'**
  String get profileN42BeanFeature4;

  /// No description provided for @profileN42BeanFeature5.
  ///
  /// In zh, this message translates to:
  /// **'群聊特权功能'**
  String get profileN42BeanFeature5;

  /// No description provided for @profileN42BeanFeature6.
  ///
  /// In zh, this message translates to:
  /// **'云存储空间扩展'**
  String get profileN42BeanFeature6;

  /// No description provided for @profileN42BeanFeature7.
  ///
  /// In zh, this message translates to:
  /// **'视频通话美颜滤镜'**
  String get profileN42BeanFeature7;

  /// No description provided for @profileN42BeanFeature8.
  ///
  /// In zh, this message translates to:
  /// **'朋友圈背景更换'**
  String get profileN42BeanFeature8;

  /// No description provided for @profileN42BeanFeature9.
  ///
  /// In zh, this message translates to:
  /// **'VIP客服优先服务'**
  String get profileN42BeanFeature9;

  /// No description provided for @profileGotIt.
  ///
  /// In zh, this message translates to:
  /// **'我知道了'**
  String get profileGotIt;

  /// No description provided for @profileNoN42BeanRecords.
  ///
  /// In zh, this message translates to:
  /// **'暂无N42豆明细记录'**
  String get profileNoN42BeanRecords;

  /// No description provided for @profileMoodAndThoughts.
  ///
  /// In zh, this message translates to:
  /// **'心情想法'**
  String get profileMoodAndThoughts;

  /// No description provided for @profileStatusHappy.
  ///
  /// In zh, this message translates to:
  /// **'开心'**
  String get profileStatusHappy;

  /// No description provided for @profileStatusCracked.
  ///
  /// In zh, this message translates to:
  /// **'裂开'**
  String get profileStatusCracked;

  /// No description provided for @profileStatusLucky.
  ///
  /// In zh, this message translates to:
  /// **'发呆'**
  String get profileStatusLucky;

  /// No description provided for @profileStatusSunny.
  ///
  /// In zh, this message translates to:
  /// **'天气晴'**
  String get profileStatusSunny;

  /// No description provided for @profileStatusTired.
  ///
  /// In zh, this message translates to:
  /// **'累了'**
  String get profileStatusTired;

  /// No description provided for @profileStatusDaydream.
  ///
  /// In zh, this message translates to:
  /// **'发呆中'**
  String get profileStatusDaydream;

  /// No description provided for @profileStatusRushing.
  ///
  /// In zh, this message translates to:
  /// **'忙碌'**
  String get profileStatusRushing;

  /// No description provided for @profileStatusOverthinking.
  ///
  /// In zh, this message translates to:
  /// **'想太多'**
  String get profileStatusOverthinking;

  /// No description provided for @profileStatusEnergized.
  ///
  /// In zh, this message translates to:
  /// **'元气满满'**
  String get profileStatusEnergized;

  /// No description provided for @profileWorkAndStudy.
  ///
  /// In zh, this message translates to:
  /// **'工作学习'**
  String get profileWorkAndStudy;

  /// No description provided for @profileStatusWorking.
  ///
  /// In zh, this message translates to:
  /// **'搬砖中'**
  String get profileStatusWorking;

  /// No description provided for @profileStatusStudying.
  ///
  /// In zh, this message translates to:
  /// **'学习中'**
  String get profileStatusStudying;

  /// No description provided for @profileStatusBusy.
  ///
  /// In zh, this message translates to:
  /// **'忙'**
  String get profileStatusBusy;

  /// No description provided for @profileStatusSlacking.
  ///
  /// In zh, this message translates to:
  /// **'摸鱼中'**
  String get profileStatusSlacking;

  /// No description provided for @profileStatusTraveling.
  ///
  /// In zh, this message translates to:
  /// **'旅行中'**
  String get profileStatusTraveling;

  /// No description provided for @profileStatusGoingHome.
  ///
  /// In zh, this message translates to:
  /// **'回家中'**
  String get profileStatusGoingHome;

  /// No description provided for @profileStatusDnd.
  ///
  /// In zh, this message translates to:
  /// **'请勿打扰'**
  String get profileStatusDnd;

  /// No description provided for @profileActivities.
  ///
  /// In zh, this message translates to:
  /// **'活动'**
  String get profileActivities;

  /// No description provided for @profileStatusHanging.
  ///
  /// In zh, this message translates to:
  /// **'出去浪'**
  String get profileStatusHanging;

  /// No description provided for @profileStatusCheckIn.
  ///
  /// In zh, this message translates to:
  /// **'打卡'**
  String get profileStatusCheckIn;

  /// No description provided for @profileStatusExercising.
  ///
  /// In zh, this message translates to:
  /// **'运动中'**
  String get profileStatusExercising;

  /// No description provided for @profileStatusCoffee.
  ///
  /// In zh, this message translates to:
  /// **'喝咖啡'**
  String get profileStatusCoffee;

  /// No description provided for @profileStatusBubbleTea.
  ///
  /// In zh, this message translates to:
  /// **'奶茶'**
  String get profileStatusBubbleTea;

  /// No description provided for @profileStatusEating.
  ///
  /// In zh, this message translates to:
  /// **'干饭中'**
  String get profileStatusEating;

  /// No description provided for @profileStatusParenting.
  ///
  /// In zh, this message translates to:
  /// **'带娃中'**
  String get profileStatusParenting;

  /// No description provided for @profileStatusSavingWorld.
  ///
  /// In zh, this message translates to:
  /// **'拯救世界'**
  String get profileStatusSavingWorld;

  /// No description provided for @profileStatusSelfie.
  ///
  /// In zh, this message translates to:
  /// **'自拍'**
  String get profileStatusSelfie;

  /// No description provided for @profileRest.
  ///
  /// In zh, this message translates to:
  /// **'休息'**
  String get profileRest;

  /// No description provided for @profileStatusRetreat.
  ///
  /// In zh, this message translates to:
  /// **'闭关'**
  String get profileStatusRetreat;

  /// No description provided for @profileStatusHome.
  ///
  /// In zh, this message translates to:
  /// **'宅家'**
  String get profileStatusHome;

  /// No description provided for @profileStatusSleeping.
  ///
  /// In zh, this message translates to:
  /// **'睡觉中'**
  String get profileStatusSleeping;

  /// No description provided for @profileStatusCatLover.
  ///
  /// In zh, this message translates to:
  /// **'吸猫中'**
  String get profileStatusCatLover;

  /// No description provided for @profileStatusDogWalking.
  ///
  /// In zh, this message translates to:
  /// **'遛狗中'**
  String get profileStatusDogWalking;

  /// No description provided for @profileStatusGaming.
  ///
  /// In zh, this message translates to:
  /// **'游戏中'**
  String get profileStatusGaming;

  /// No description provided for @profileStatusListening.
  ///
  /// In zh, this message translates to:
  /// **'听歌中'**
  String get profileStatusListening;

  /// No description provided for @profileEditAddress.
  ///
  /// In zh, this message translates to:
  /// **'编辑地址'**
  String get profileEditAddress;

  /// No description provided for @profileRecipient.
  ///
  /// In zh, this message translates to:
  /// **'收货人'**
  String get profileRecipient;

  /// No description provided for @profileEnterRecipientName.
  ///
  /// In zh, this message translates to:
  /// **'请输入收货人姓名'**
  String get profileEnterRecipientName;

  /// No description provided for @profilePhoneNumber.
  ///
  /// In zh, this message translates to:
  /// **'手机号码'**
  String get profilePhoneNumber;

  /// No description provided for @profileEnterPhoneNumber.
  ///
  /// In zh, this message translates to:
  /// **'请输入手机号码'**
  String get profileEnterPhoneNumber;

  /// No description provided for @profileRegionHint.
  ///
  /// In zh, this message translates to:
  /// **'省/市/区'**
  String get profileRegionHint;

  /// No description provided for @profileDetailedAddress.
  ///
  /// In zh, this message translates to:
  /// **'详细地址'**
  String get profileDetailedAddress;

  /// No description provided for @profileDetailedAddressHint.
  ///
  /// In zh, this message translates to:
  /// **'街道、门牌号等'**
  String get profileDetailedAddressHint;

  /// No description provided for @profileSetAsDefaultAddress.
  ///
  /// In zh, this message translates to:
  /// **'设为默认地址'**
  String get profileSetAsDefaultAddress;

  /// No description provided for @profilePleaseCompleteInfo.
  ///
  /// In zh, this message translates to:
  /// **'请填写完整信息'**
  String get profilePleaseCompleteInfo;

  /// No description provided for @profileEditInvoice.
  ///
  /// In zh, this message translates to:
  /// **'编辑发票抬头'**
  String get profileEditInvoice;

  /// No description provided for @profileInvoiceType.
  ///
  /// In zh, this message translates to:
  /// **'抬头类型'**
  String get profileInvoiceType;

  /// No description provided for @profileCompanyName.
  ///
  /// In zh, this message translates to:
  /// **'企业名称'**
  String get profileCompanyName;

  /// No description provided for @profilePersonalName.
  ///
  /// In zh, this message translates to:
  /// **'个人姓名'**
  String get profilePersonalName;

  /// No description provided for @profileEnterCompanyName.
  ///
  /// In zh, this message translates to:
  /// **'请输入企业名称'**
  String get profileEnterCompanyName;

  /// No description provided for @profileEnterName.
  ///
  /// In zh, this message translates to:
  /// **'请输入姓名'**
  String get profileEnterName;

  /// No description provided for @profileTaxIdNumber.
  ///
  /// In zh, this message translates to:
  /// **'纳税人识别号'**
  String get profileTaxIdNumber;

  /// No description provided for @profileEnterTaxIdNumber.
  ///
  /// In zh, this message translates to:
  /// **'请输入纳税人识别号'**
  String get profileEnterTaxIdNumber;

  /// No description provided for @profileBankNameOptional.
  ///
  /// In zh, this message translates to:
  /// **'开户银行（选填）'**
  String get profileBankNameOptional;

  /// No description provided for @profileEnterBankName.
  ///
  /// In zh, this message translates to:
  /// **'请输入开户银行'**
  String get profileEnterBankName;

  /// No description provided for @profileBankAccountOptional.
  ///
  /// In zh, this message translates to:
  /// **'银行账号（选填）'**
  String get profileBankAccountOptional;

  /// No description provided for @profileEnterBankAccount.
  ///
  /// In zh, this message translates to:
  /// **'请输入银行账号'**
  String get profileEnterBankAccount;

  /// No description provided for @profileCompanyAddressOptional.
  ///
  /// In zh, this message translates to:
  /// **'企业地址（选填）'**
  String get profileCompanyAddressOptional;

  /// No description provided for @profileEnterCompanyAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入企业地址'**
  String get profileEnterCompanyAddress;

  /// No description provided for @profileCompanyPhoneOptional.
  ///
  /// In zh, this message translates to:
  /// **'企业电话（选填）'**
  String get profileCompanyPhoneOptional;

  /// No description provided for @profileEnterCompanyPhone.
  ///
  /// In zh, this message translates to:
  /// **'请输入企业电话'**
  String get profileEnterCompanyPhone;

  /// No description provided for @profileSetAsDefaultInvoice.
  ///
  /// In zh, this message translates to:
  /// **'设为默认抬头'**
  String get profileSetAsDefaultInvoice;

  /// No description provided for @profileRingtoneVibrate.
  ///
  /// In zh, this message translates to:
  /// **'震动'**
  String get profileRingtoneVibrate;

  /// No description provided for @profileRingtoneSilent.
  ///
  /// In zh, this message translates to:
  /// **'静音'**
  String get profileRingtoneSilent;

  /// No description provided for @profileVibrateMode.
  ///
  /// In zh, this message translates to:
  /// **'振动模式'**
  String get profileVibrateMode;

  /// No description provided for @profileSilentMode.
  ///
  /// In zh, this message translates to:
  /// **'静音模式'**
  String get profileSilentMode;

  /// No description provided for @profilePlayFailed.
  ///
  /// In zh, this message translates to:
  /// **'播放失败: {ringtoneName}'**
  String profilePlayFailed(String ringtoneName);

  /// No description provided for @profilePlaying.
  ///
  /// In zh, this message translates to:
  /// **'正在播放: {ringtoneName}'**
  String profilePlaying(String ringtoneName);

  /// No description provided for @profileStop.
  ///
  /// In zh, this message translates to:
  /// **'停止'**
  String get profileStop;

  /// No description provided for @profileSelectRingtone.
  ///
  /// In zh, this message translates to:
  /// **'选择铃声'**
  String get profileSelectRingtone;

  /// No description provided for @profileLoadingRingtones.
  ///
  /// In zh, this message translates to:
  /// **'加载铃声中...'**
  String get profileLoadingRingtones;

  /// No description provided for @profileNoRingtonesFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到铃声'**
  String get profileNoRingtonesFound;

  /// No description provided for @mainMessagesWithCount.
  ///
  /// In zh, this message translates to:
  /// **'消息({count})'**
  String mainMessagesWithCount(int count);

  /// No description provided for @storyViewers.
  ///
  /// In zh, this message translates to:
  /// **'浏览者'**
  String get storyViewers;

  /// No description provided for @storyNoViewers.
  ///
  /// In zh, this message translates to:
  /// **'暂无浏览'**
  String get storyNoViewers;

  /// No description provided for @storyReplyToStory.
  ///
  /// In zh, this message translates to:
  /// **'回复状态...'**
  String get storyReplyToStory;

  /// No description provided for @commonCopiedToClipboard.
  ///
  /// In zh, this message translates to:
  /// **'已复制到剪贴板'**
  String get commonCopiedToClipboard;

  /// No description provided for @commonMore.
  ///
  /// In zh, this message translates to:
  /// **'更多'**
  String get commonMore;

  /// No description provided for @commonTranslating.
  ///
  /// In zh, this message translates to:
  /// **'翻译中...'**
  String get commonTranslating;

  /// No description provided for @commonTranslatedFrom.
  ///
  /// In zh, this message translates to:
  /// **'翻译自{language}'**
  String commonTranslatedFrom(String language);

  /// No description provided for @commonTranslation.
  ///
  /// In zh, this message translates to:
  /// **'翻译'**
  String get commonTranslation;

  /// No description provided for @commonTranslationFailed.
  ///
  /// In zh, this message translates to:
  /// **'翻译失败'**
  String get commonTranslationFailed;

  /// No description provided for @commonAllRead.
  ///
  /// In zh, this message translates to:
  /// **'全部已读'**
  String get commonAllRead;

  /// No description provided for @commonReadCount.
  ///
  /// In zh, this message translates to:
  /// **'{count}人已读'**
  String commonReadCount(int count);

  /// No description provided for @commonYouRecalledMessage.
  ///
  /// In zh, this message translates to:
  /// **'你撤回了一条消息'**
  String get commonYouRecalledMessage;

  /// No description provided for @commonMessageRecalled.
  ///
  /// In zh, this message translates to:
  /// **'对方撤回了一条消息'**
  String get commonMessageRecalled;

  /// No description provided for @commonReEdit.
  ///
  /// In zh, this message translates to:
  /// **'重新编辑'**
  String get commonReEdit;

  /// No description provided for @commonWalletArea.
  ///
  /// In zh, this message translates to:
  /// **'钱包功能区域'**
  String get commonWalletArea;

  /// No description provided for @callIncomingCall.
  ///
  /// In zh, this message translates to:
  /// **'来电'**
  String get callIncomingCall;

  /// No description provided for @callMissedCall.
  ///
  /// In zh, this message translates to:
  /// **'未接来电'**
  String get callMissedCall;

  /// No description provided for @groupRemoveAdmin.
  ///
  /// In zh, this message translates to:
  /// **'取消管理员'**
  String get groupRemoveAdmin;

  /// No description provided for @chatSelectCurrency.
  ///
  /// In zh, this message translates to:
  /// **'选择币种'**
  String get chatSelectCurrency;

  /// No description provided for @chatSelectEmoji.
  ///
  /// In zh, this message translates to:
  /// **'选择表情'**
  String get chatSelectEmoji;

  /// No description provided for @chatSelectRedPacketCover.
  ///
  /// In zh, this message translates to:
  /// **'选择封面'**
  String get chatSelectRedPacketCover;

  /// No description provided for @groupSetAsAdmin.
  ///
  /// In zh, this message translates to:
  /// **'设为管理员'**
  String get groupSetAsAdmin;

  /// No description provided for @chatVideoPlaybackFailed.
  ///
  /// In zh, this message translates to:
  /// **'视频播放失败'**
  String get chatVideoPlaybackFailed;

  /// No description provided for @groupViewProfile.
  ///
  /// In zh, this message translates to:
  /// **'查看资料'**
  String get groupViewProfile;

  /// No description provided for @favoriteAddLinkComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'添加链接功能即将推出'**
  String get favoriteAddLinkComingSoon;

  /// No description provided for @favoriteNewNoteComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'新建笔记功能即将推出'**
  String get favoriteNewNoteComingSoon;

  /// No description provided for @qrcodeSaveFeatureComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'保存功能即将推出'**
  String get qrcodeSaveFeatureComingSoon;

  /// No description provided for @qrcodeShareFeatureComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'分享功能即将推出'**
  String get qrcodeShareFeatureComingSoon;

  /// No description provided for @qrcodeProcessFailed.
  ///
  /// In zh, this message translates to:
  /// **'处理二维码失败: {error}'**
  String qrcodeProcessFailed(String error);

  /// No description provided for @securityDeviceIdRequired.
  ///
  /// In zh, this message translates to:
  /// **'需要设备 ID'**
  String get securityDeviceIdRequired;

  /// No description provided for @securityVerificationStartFailed.
  ///
  /// In zh, this message translates to:
  /// **'启动验证失败: {error}'**
  String securityVerificationStartFailed(String error);

  /// No description provided for @securityVerificationFailed.
  ///
  /// In zh, this message translates to:
  /// **'验证失败'**
  String get securityVerificationFailed;

  /// No description provided for @securityVerificationFailedWithReason.
  ///
  /// In zh, this message translates to:
  /// **'验证失败: {reason}'**
  String securityVerificationFailedWithReason(String reason);

  /// No description provided for @securityEmojiMismatchRejected.
  ///
  /// In zh, this message translates to:
  /// **'验证被拒绝 - 表情不匹配'**
  String get securityEmojiMismatchRejected;

  /// No description provided for @securityWaitingForDeviceAccept.
  ///
  /// In zh, this message translates to:
  /// **'等待另一台设备接受...'**
  String get securityWaitingForDeviceAccept;

  /// No description provided for @securityVerifyDevice.
  ///
  /// In zh, this message translates to:
  /// **'验证此设备'**
  String get securityVerifyDevice;

  /// No description provided for @securityConfirmEmojiMatch.
  ///
  /// In zh, this message translates to:
  /// **'确认以下表情符号在两台设备上以相同顺序显示'**
  String get securityConfirmEmojiMatch;

  /// No description provided for @securityEmojiDontMatch.
  ///
  /// In zh, this message translates to:
  /// **'不匹配'**
  String get securityEmojiDontMatch;

  /// No description provided for @securityEmojiMatch.
  ///
  /// In zh, this message translates to:
  /// **'匹配'**
  String get securityEmojiMatch;

  /// No description provided for @securityWaitingForDeviceConfirm.
  ///
  /// In zh, this message translates to:
  /// **'等待另一台设备确认...'**
  String get securityWaitingForDeviceConfirm;

  /// No description provided for @securityVerificationSuccess.
  ///
  /// In zh, this message translates to:
  /// **'验证成功！'**
  String get securityVerificationSuccess;

  /// No description provided for @securityDeviceVerifiedTrusted.
  ///
  /// In zh, this message translates to:
  /// **'此设备已验证并可信任。'**
  String get securityDeviceVerifiedTrusted;

  /// No description provided for @securityCompareEmoji.
  ///
  /// In zh, this message translates to:
  /// **'比较两台设备上的表情符号'**
  String get securityCompareEmoji;

  /// No description provided for @securityCompareNumbers.
  ///
  /// In zh, this message translates to:
  /// **'比较两台设备上的数字'**
  String get securityCompareNumbers;

  /// No description provided for @commonTryAgain.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get commonTryAgain;

  /// No description provided for @commonDone.
  ///
  /// In zh, this message translates to:
  /// **'完成'**
  String get commonDone;

  /// No description provided for @chatExportTitle.
  ///
  /// In zh, this message translates to:
  /// **'导出聊天记录'**
  String get chatExportTitle;

  /// No description provided for @chatExportSuccess.
  ///
  /// In zh, this message translates to:
  /// **'导出成功'**
  String get chatExportSuccess;

  /// No description provided for @chatExportFailed.
  ///
  /// In zh, this message translates to:
  /// **'导出失败: {error}'**
  String chatExportFailed(String error);

  /// No description provided for @chatExportFormat.
  ///
  /// In zh, this message translates to:
  /// **'导出格式'**
  String get chatExportFormat;

  /// No description provided for @chatExportHtmlDesc.
  ///
  /// In zh, this message translates to:
  /// **'可在任何浏览器中打开的精美排版'**
  String get chatExportHtmlDesc;

  /// No description provided for @chatExportJsonDesc.
  ///
  /// In zh, this message translates to:
  /// **'机器可读的结构化数据格式'**
  String get chatExportJsonDesc;

  /// No description provided for @chatExportDateRange.
  ///
  /// In zh, this message translates to:
  /// **'日期范围'**
  String get chatExportDateRange;

  /// No description provided for @chatExportAll.
  ///
  /// In zh, this message translates to:
  /// **'全部消息'**
  String get chatExportAll;

  /// No description provided for @chatExportLastWeek.
  ///
  /// In zh, this message translates to:
  /// **'最近7天'**
  String get chatExportLastWeek;

  /// No description provided for @chatExportLastMonth.
  ///
  /// In zh, this message translates to:
  /// **'最近一个月'**
  String get chatExportLastMonth;

  /// No description provided for @chatExportLast3Months.
  ///
  /// In zh, this message translates to:
  /// **'最近三个月'**
  String get chatExportLast3Months;

  /// No description provided for @chatExportMessageCount.
  ///
  /// In zh, this message translates to:
  /// **'待导出消息'**
  String get chatExportMessageCount;

  /// No description provided for @chatExportButton.
  ///
  /// In zh, this message translates to:
  /// **'导出并分享'**
  String get chatExportButton;

  /// No description provided for @chatMediaGallery.
  ///
  /// In zh, this message translates to:
  /// **'媒体文件'**
  String get chatMediaGallery;

  /// No description provided for @chatExportHistory.
  ///
  /// In zh, this message translates to:
  /// **'导出聊天记录'**
  String get chatExportHistory;

  /// No description provided for @pdfLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'加载 PDF 失败'**
  String get pdfLoadFailed;

  /// No description provided for @pdfPageIndicator.
  ///
  /// In zh, this message translates to:
  /// **'{current} / {total}'**
  String pdfPageIndicator(int current, int total);

  /// No description provided for @mediaAll.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get mediaAll;

  /// No description provided for @mediaImages.
  ///
  /// In zh, this message translates to:
  /// **'图片'**
  String get mediaImages;

  /// No description provided for @mediaVideos.
  ///
  /// In zh, this message translates to:
  /// **'视频'**
  String get mediaVideos;

  /// No description provided for @mediaFiles.
  ///
  /// In zh, this message translates to:
  /// **'文件'**
  String get mediaFiles;

  /// No description provided for @mediaAudio.
  ///
  /// In zh, this message translates to:
  /// **'音频'**
  String get mediaAudio;

  /// No description provided for @mediaItemsCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 项'**
  String mediaItemsCount(int count);

  /// No description provided for @mediaNoMediaFound.
  ///
  /// In zh, this message translates to:
  /// **'暂无媒体文件'**
  String get mediaNoMediaFound;

  /// No description provided for @spacesTitle.
  ///
  /// In zh, this message translates to:
  /// **'社区'**
  String get spacesTitle;

  /// No description provided for @spacesCreate.
  ///
  /// In zh, this message translates to:
  /// **'创建社区'**
  String get spacesCreate;

  /// No description provided for @spacesJoined.
  ///
  /// In zh, this message translates to:
  /// **'已加入'**
  String get spacesJoined;

  /// No description provided for @spacesDiscover.
  ///
  /// In zh, this message translates to:
  /// **'发现'**
  String get spacesDiscover;

  /// No description provided for @spacesNoJoined.
  ///
  /// In zh, this message translates to:
  /// **'还没有加入任何社区'**
  String get spacesNoJoined;

  /// No description provided for @spacesExplore.
  ///
  /// In zh, this message translates to:
  /// **'探索社区'**
  String get spacesExplore;

  /// No description provided for @spacesNoPublic.
  ///
  /// In zh, this message translates to:
  /// **'没有找到公共社区'**
  String get spacesNoPublic;

  /// No description provided for @spacesJoin.
  ///
  /// In zh, this message translates to:
  /// **'加入'**
  String get spacesJoin;

  /// No description provided for @spacesSubSpaces.
  ///
  /// In zh, this message translates to:
  /// **'子社区'**
  String get spacesSubSpaces;

  /// No description provided for @spacesChannels.
  ///
  /// In zh, this message translates to:
  /// **'频道'**
  String get spacesChannels;

  /// No description provided for @spacesMembersCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 位成员'**
  String spacesMembersCount(int count);

  /// No description provided for @spacesPublic.
  ///
  /// In zh, this message translates to:
  /// **'公开'**
  String get spacesPublic;

  /// No description provided for @spacesPrivate.
  ///
  /// In zh, this message translates to:
  /// **'私密'**
  String get spacesPrivate;

  /// No description provided for @spacesSuggested.
  ///
  /// In zh, this message translates to:
  /// **'推荐'**
  String get spacesSuggested;

  /// No description provided for @spacesChannelsCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 个频道'**
  String spacesChannelsCount(int count);

  /// No description provided for @callInCallChat.
  ///
  /// In zh, this message translates to:
  /// **'通话中聊天'**
  String get callInCallChat;

  /// No description provided for @callMessagesCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 条消息'**
  String callMessagesCount(int count);

  /// No description provided for @callNoMessagesYet.
  ///
  /// In zh, this message translates to:
  /// **'暂无消息\n发送一条消息开始聊天'**
  String get callNoMessagesYet;

  /// No description provided for @callTypeMessage.
  ///
  /// In zh, this message translates to:
  /// **'输入消息...'**
  String get callTypeMessage;

  /// No description provided for @callYouSender.
  ///
  /// In zh, this message translates to:
  /// **'我'**
  String get callYouSender;

  /// No description provided for @callChatLabel.
  ///
  /// In zh, this message translates to:
  /// **'聊天'**
  String get callChatLabel;

  /// No description provided for @chatEdited.
  ///
  /// In zh, this message translates to:
  /// **'已编辑'**
  String get chatEdited;

  /// No description provided for @chatEditHistory.
  ///
  /// In zh, this message translates to:
  /// **'编辑历史'**
  String get chatEditHistory;

  /// No description provided for @chatOriginalMessage.
  ///
  /// In zh, this message translates to:
  /// **'原始消息'**
  String get chatOriginalMessage;

  /// No description provided for @chatEditedAt.
  ///
  /// In zh, this message translates to:
  /// **'编辑于 {time}'**
  String chatEditedAt(String time);

  /// No description provided for @chatViewOnce.
  ///
  /// In zh, this message translates to:
  /// **'阅后即焚'**
  String get chatViewOnce;

  /// No description provided for @chatViewOncePhoto.
  ///
  /// In zh, this message translates to:
  /// **'阅后即焚照片'**
  String get chatViewOncePhoto;

  /// No description provided for @chatViewOnceVideo.
  ///
  /// In zh, this message translates to:
  /// **'阅后即焚视频'**
  String get chatViewOnceVideo;

  /// No description provided for @chatViewOnceViewed.
  ///
  /// In zh, this message translates to:
  /// **'已查看'**
  String get chatViewOnceViewed;

  /// No description provided for @chatViewOnceExpired.
  ///
  /// In zh, this message translates to:
  /// **'已过期'**
  String get chatViewOnceExpired;

  /// No description provided for @chatViewOnceTap.
  ///
  /// In zh, this message translates to:
  /// **'点击查看'**
  String get chatViewOnceTap;

  /// No description provided for @chatAutoFaceBlur.
  ///
  /// In zh, this message translates to:
  /// **'自动模糊人脸'**
  String get chatAutoFaceBlur;

  /// No description provided for @chatAutoFaceBlurDesc.
  ///
  /// In zh, this message translates to:
  /// **'发送照片时自动模糊人脸'**
  String get chatAutoFaceBlurDesc;

  /// No description provided for @threadReplyInThread.
  ///
  /// In zh, this message translates to:
  /// **'在线程中回复'**
  String get threadReplyInThread;

  /// No description provided for @threadReplies.
  ///
  /// In zh, this message translates to:
  /// **'{count} 条回复'**
  String threadReplies(int count);

  /// No description provided for @threadReply.
  ///
  /// In zh, this message translates to:
  /// **'1 条回复'**
  String get threadReply;

  /// No description provided for @threadLatestReply.
  ///
  /// In zh, this message translates to:
  /// **'最新: {preview}'**
  String threadLatestReply(String preview);

  /// No description provided for @threadTitle.
  ///
  /// In zh, this message translates to:
  /// **'消息线程'**
  String get threadTitle;

  /// No description provided for @threadReplyPlaceholder.
  ///
  /// In zh, this message translates to:
  /// **'在线程中回复...'**
  String get threadReplyPlaceholder;

  /// No description provided for @threadParticipants.
  ///
  /// In zh, this message translates to:
  /// **'{count} 位参与者'**
  String threadParticipants(int count);

  /// No description provided for @voiceRoomTitle.
  ///
  /// In zh, this message translates to:
  /// **'语音聊天室'**
  String get voiceRoomTitle;

  /// No description provided for @voiceRoomCreate.
  ///
  /// In zh, this message translates to:
  /// **'创建语音房间'**
  String get voiceRoomCreate;

  /// No description provided for @voiceRoomJoin.
  ///
  /// In zh, this message translates to:
  /// **'加入'**
  String get voiceRoomJoin;

  /// No description provided for @voiceRoomLeave.
  ///
  /// In zh, this message translates to:
  /// **'离开'**
  String get voiceRoomLeave;

  /// No description provided for @voiceRoomEnd.
  ///
  /// In zh, this message translates to:
  /// **'结束房间'**
  String get voiceRoomEnd;

  /// No description provided for @voiceRoomRaiseHand.
  ///
  /// In zh, this message translates to:
  /// **'举手'**
  String get voiceRoomRaiseHand;

  /// No description provided for @voiceRoomLowerHand.
  ///
  /// In zh, this message translates to:
  /// **'放下手'**
  String get voiceRoomLowerHand;

  /// No description provided for @voiceRoomMute.
  ///
  /// In zh, this message translates to:
  /// **'静音'**
  String get voiceRoomMute;

  /// No description provided for @voiceRoomUnmute.
  ///
  /// In zh, this message translates to:
  /// **'取消静音'**
  String get voiceRoomUnmute;

  /// No description provided for @voiceRoomHost.
  ///
  /// In zh, this message translates to:
  /// **'主持人'**
  String get voiceRoomHost;

  /// No description provided for @voiceRoomSpeakers.
  ///
  /// In zh, this message translates to:
  /// **'发言者'**
  String get voiceRoomSpeakers;

  /// No description provided for @voiceRoomListeners.
  ///
  /// In zh, this message translates to:
  /// **'听众'**
  String get voiceRoomListeners;

  /// No description provided for @voiceRoomLive.
  ///
  /// In zh, this message translates to:
  /// **'直播中'**
  String get voiceRoomLive;

  /// No description provided for @voiceRoomEnded.
  ///
  /// In zh, this message translates to:
  /// **'已结束'**
  String get voiceRoomEnded;

  /// No description provided for @voiceRoomScheduled.
  ///
  /// In zh, this message translates to:
  /// **'已预约'**
  String get voiceRoomScheduled;

  /// No description provided for @voiceRoomApprove.
  ///
  /// In zh, this message translates to:
  /// **'批准发言'**
  String get voiceRoomApprove;

  /// No description provided for @voiceRoomDemote.
  ///
  /// In zh, this message translates to:
  /// **'移至听众'**
  String get voiceRoomDemote;

  /// No description provided for @voiceRoomHandRaised.
  ///
  /// In zh, this message translates to:
  /// **'{name} 举手了'**
  String voiceRoomHandRaised(String name);

  /// No description provided for @voiceRoomName.
  ///
  /// In zh, this message translates to:
  /// **'房间名称'**
  String get voiceRoomName;

  /// No description provided for @voiceRoomTopic.
  ///
  /// In zh, this message translates to:
  /// **'话题（可选）'**
  String get voiceRoomTopic;

  /// No description provided for @voiceRoomNoActive.
  ///
  /// In zh, this message translates to:
  /// **'暂无活跃的语音房间'**
  String get voiceRoomNoActive;

  /// No description provided for @voiceRoomConnecting.
  ///
  /// In zh, this message translates to:
  /// **'连接中...'**
  String get voiceRoomConnecting;

  /// No description provided for @usernameTitle.
  ///
  /// In zh, this message translates to:
  /// **'用户名'**
  String get usernameTitle;

  /// No description provided for @usernameSet.
  ///
  /// In zh, this message translates to:
  /// **'设置用户名'**
  String get usernameSet;

  /// No description provided for @usernameChange.
  ///
  /// In zh, this message translates to:
  /// **'修改用户名'**
  String get usernameChange;

  /// No description provided for @usernamePlaceholder.
  ///
  /// In zh, this message translates to:
  /// **'输入用户名'**
  String get usernamePlaceholder;

  /// No description provided for @usernameAvailable.
  ///
  /// In zh, this message translates to:
  /// **'用户名可用'**
  String get usernameAvailable;

  /// No description provided for @usernameUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'用户名已被占用'**
  String get usernameUnavailable;

  /// No description provided for @usernameInvalid.
  ///
  /// In zh, this message translates to:
  /// **'3-30个字符，小写字母、数字、下划线，必须以字母开头'**
  String get usernameInvalid;

  /// No description provided for @usernameReserved.
  ///
  /// In zh, this message translates to:
  /// **'此用户名为保留名称'**
  String get usernameReserved;

  /// No description provided for @usernameSaved.
  ///
  /// In zh, this message translates to:
  /// **'用户名已保存'**
  String get usernameSaved;

  /// No description provided for @usernameSearchHint.
  ///
  /// In zh, this message translates to:
  /// **'通过 @用户名 搜索'**
  String get usernameSearchHint;

  /// No description provided for @ensName.
  ///
  /// In zh, this message translates to:
  /// **'ENS 域名'**
  String get ensName;

  /// No description provided for @ensLinked.
  ///
  /// In zh, this message translates to:
  /// **'已关联 ENS'**
  String get ensLinked;

  /// No description provided for @ensResolving.
  ///
  /// In zh, this message translates to:
  /// **'正在解析 ENS...'**
  String get ensResolving;

  /// No description provided for @ensNotFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到 ENS 域名'**
  String get ensNotFound;

  /// No description provided for @tokenGateTitle.
  ///
  /// In zh, this message translates to:
  /// **'代币门控'**
  String get tokenGateTitle;

  /// No description provided for @tokenGateEnable.
  ///
  /// In zh, this message translates to:
  /// **'启用代币门控'**
  String get tokenGateEnable;

  /// No description provided for @tokenGateDisable.
  ///
  /// In zh, this message translates to:
  /// **'禁用代币门控'**
  String get tokenGateDisable;

  /// No description provided for @tokenGateAddRule.
  ///
  /// In zh, this message translates to:
  /// **'添加规则'**
  String get tokenGateAddRule;

  /// No description provided for @tokenGateRemoveRule.
  ///
  /// In zh, this message translates to:
  /// **'删除规则'**
  String get tokenGateRemoveRule;

  /// No description provided for @tokenGateContractAddress.
  ///
  /// In zh, this message translates to:
  /// **'合约地址'**
  String get tokenGateContractAddress;

  /// No description provided for @tokenGateMinBalance.
  ///
  /// In zh, this message translates to:
  /// **'最低余额'**
  String get tokenGateMinBalance;

  /// No description provided for @tokenGateTokenId.
  ///
  /// In zh, this message translates to:
  /// **'Token ID (ERC-1155)'**
  String get tokenGateTokenId;

  /// No description provided for @tokenGateChainId.
  ///
  /// In zh, this message translates to:
  /// **'链 ID'**
  String get tokenGateChainId;

  /// No description provided for @tokenGateVerifying.
  ///
  /// In zh, this message translates to:
  /// **'正在验证代币持有...'**
  String get tokenGateVerifying;

  /// No description provided for @tokenGateVerified.
  ///
  /// In zh, this message translates to:
  /// **'验证通过'**
  String get tokenGateVerified;

  /// No description provided for @tokenGateDenied.
  ///
  /// In zh, this message translates to:
  /// **'您未满足代币要求'**
  String get tokenGateDenied;

  /// No description provided for @tokenGateOperatorAnd.
  ///
  /// In zh, this message translates to:
  /// **'需满足所有规则'**
  String get tokenGateOperatorAnd;

  /// No description provided for @tokenGateOperatorOr.
  ///
  /// In zh, this message translates to:
  /// **'满足任一规则即可'**
  String get tokenGateOperatorOr;

  /// No description provided for @tokenGateRuleErc20.
  ///
  /// In zh, this message translates to:
  /// **'ERC-20 代币'**
  String get tokenGateRuleErc20;

  /// No description provided for @tokenGateRuleErc721.
  ///
  /// In zh, this message translates to:
  /// **'NFT (ERC-721)'**
  String get tokenGateRuleErc721;

  /// No description provided for @tokenGateRuleErc1155.
  ///
  /// In zh, this message translates to:
  /// **'多代币 (ERC-1155)'**
  String get tokenGateRuleErc1155;

  /// No description provided for @tokenGateRuleNative.
  ///
  /// In zh, this message translates to:
  /// **'原生代币'**
  String get tokenGateRuleNative;

  /// No description provided for @tokenGateSaved.
  ///
  /// In zh, this message translates to:
  /// **'代币门控已保存'**
  String get tokenGateSaved;

  /// No description provided for @tokenGateEnableDescription.
  ///
  /// In zh, this message translates to:
  /// **'要求成员持有指定代币才能加入'**
  String get tokenGateEnableDescription;

  /// No description provided for @tokenGateOperator.
  ///
  /// In zh, this message translates to:
  /// **'规则逻辑'**
  String get tokenGateOperator;

  /// No description provided for @tokenGateRules.
  ///
  /// In zh, this message translates to:
  /// **'规则列表'**
  String get tokenGateRules;

  /// No description provided for @tokenGateSymbol.
  ///
  /// In zh, this message translates to:
  /// **'代币符号（可选）'**
  String get tokenGateSymbol;

  /// No description provided for @tokenGateChain.
  ///
  /// In zh, this message translates to:
  /// **'区块链'**
  String get tokenGateChain;

  /// No description provided for @tokenGateTokenStandard.
  ///
  /// In zh, this message translates to:
  /// **'代币标准'**
  String get tokenGateTokenStandard;

  /// No description provided for @tokenGateDenialMessage.
  ///
  /// In zh, this message translates to:
  /// **'拒绝消息'**
  String get tokenGateDenialMessage;

  /// No description provided for @tokenGateDenialMessageHint.
  ///
  /// In zh, this message translates to:
  /// **'验证失败时显示的消息'**
  String get tokenGateDenialMessageHint;

  /// No description provided for @tokenGateVerifyTitle.
  ///
  /// In zh, this message translates to:
  /// **'代币验证'**
  String get tokenGateVerifyTitle;

  /// No description provided for @tokenGateVerifyPassed.
  ///
  /// In zh, this message translates to:
  /// **'验证通过'**
  String get tokenGateVerifyPassed;

  /// No description provided for @tokenGateVerifyFailed.
  ///
  /// In zh, this message translates to:
  /// **'验证未通过'**
  String get tokenGateVerifyFailed;

  /// No description provided for @tokenGateRetryVerify.
  ///
  /// In zh, this message translates to:
  /// **'重新验证'**
  String get tokenGateRetryVerify;

  /// No description provided for @tokenGateRequired.
  ///
  /// In zh, this message translates to:
  /// **'要求'**
  String get tokenGateRequired;

  /// No description provided for @tokenGateYourBalance.
  ///
  /// In zh, this message translates to:
  /// **'你的余额'**
  String get tokenGateYourBalance;

  /// No description provided for @tokenGateRulesActive.
  ///
  /// In zh, this message translates to:
  /// **'条规则生效'**
  String get tokenGateRulesActive;

  /// No description provided for @tokenGateDisabled.
  ///
  /// In zh, this message translates to:
  /// **'未启用'**
  String get tokenGateDisabled;

  /// No description provided for @ensNotBound.
  ///
  /// In zh, this message translates to:
  /// **'未绑定'**
  String get ensNotBound;

  /// No description provided for @liveLocation.
  ///
  /// In zh, this message translates to:
  /// **'实时位置'**
  String get liveLocation;

  /// No description provided for @stopLiveLocation.
  ///
  /// In zh, this message translates to:
  /// **'停止共享'**
  String get stopLiveLocation;

  /// No description provided for @startLiveLocation.
  ///
  /// In zh, this message translates to:
  /// **'开始共享'**
  String get startLiveLocation;

  /// No description provided for @selectDuration.
  ///
  /// In zh, this message translates to:
  /// **'选择共享时长'**
  String get selectDuration;

  /// No description provided for @groupChatFiles.
  ///
  /// In zh, this message translates to:
  /// **'聊天文件'**
  String get groupChatFiles;

  /// No description provided for @groupLinks.
  ///
  /// In zh, this message translates to:
  /// **'链接'**
  String get groupLinks;

  /// No description provided for @groupNoLinks.
  ///
  /// In zh, this message translates to:
  /// **'暂无链接'**
  String get groupNoLinks;

  /// No description provided for @chatBackground.
  ///
  /// In zh, this message translates to:
  /// **'聊天背景'**
  String get chatBackground;

  /// No description provided for @solidColors.
  ///
  /// In zh, this message translates to:
  /// **'纯色'**
  String get solidColors;

  /// No description provided for @gradients.
  ///
  /// In zh, this message translates to:
  /// **'渐变'**
  String get gradients;

  /// No description provided for @defaultBackground.
  ///
  /// In zh, this message translates to:
  /// **'默认'**
  String get defaultBackground;

  /// No description provided for @settingsFontSizeSlider.
  ///
  /// In zh, this message translates to:
  /// **'字体大小'**
  String get settingsFontSizeSlider;

  /// No description provided for @autoDownload.
  ///
  /// In zh, this message translates to:
  /// **'自动下载'**
  String get autoDownload;

  /// No description provided for @images.
  ///
  /// In zh, this message translates to:
  /// **'图片'**
  String get images;

  /// No description provided for @voice.
  ///
  /// In zh, this message translates to:
  /// **'语音'**
  String get voice;

  /// No description provided for @video.
  ///
  /// In zh, this message translates to:
  /// **'视频'**
  String get video;

  /// No description provided for @files.
  ///
  /// In zh, this message translates to:
  /// **'文件'**
  String get files;

  /// No description provided for @mobileData.
  ///
  /// In zh, this message translates to:
  /// **'移动数据'**
  String get mobileData;

  /// No description provided for @roaming.
  ///
  /// In zh, this message translates to:
  /// **'漫游'**
  String get roaming;

  /// No description provided for @storageManagement.
  ///
  /// In zh, this message translates to:
  /// **'存储管理'**
  String get storageManagement;

  /// No description provided for @totalUsage.
  ///
  /// In zh, this message translates to:
  /// **'总用量'**
  String get totalUsage;

  /// No description provided for @cache.
  ///
  /// In zh, this message translates to:
  /// **'缓存'**
  String get cache;

  /// No description provided for @other.
  ///
  /// In zh, this message translates to:
  /// **'其他'**
  String get other;

  /// No description provided for @clearCache.
  ///
  /// In zh, this message translates to:
  /// **'清理缓存'**
  String get clearCache;

  /// No description provided for @cacheCleared.
  ///
  /// In zh, this message translates to:
  /// **'缓存已清除'**
  String get cacheCleared;

  /// No description provided for @clearCacheFailed.
  ///
  /// In zh, this message translates to:
  /// **'清理缓存失败'**
  String get clearCacheFailed;

  /// No description provided for @confirmClearCache.
  ///
  /// In zh, this message translates to:
  /// **'确认清理所有缓存数据？'**
  String get confirmClearCache;

  /// No description provided for @mapView.
  ///
  /// In zh, this message translates to:
  /// **'地图视图'**
  String get mapView;

  /// No description provided for @liveLocationSharingCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人正在共享位置'**
  String liveLocationSharingCount(int count);

  /// No description provided for @minutes15.
  ///
  /// In zh, this message translates to:
  /// **'15 分钟'**
  String get minutes15;

  /// No description provided for @minutes30.
  ///
  /// In zh, this message translates to:
  /// **'30 分钟'**
  String get minutes30;

  /// No description provided for @hour1.
  ///
  /// In zh, this message translates to:
  /// **'1 小时'**
  String get hour1;

  /// No description provided for @hours8.
  ///
  /// In zh, this message translates to:
  /// **'8 小时'**
  String get hours8;

  /// No description provided for @personalCard.
  ///
  /// In zh, this message translates to:
  /// **'个人名片'**
  String get personalCard;

  /// No description provided for @downloadFailed.
  ///
  /// In zh, this message translates to:
  /// **'下载失败'**
  String get downloadFailed;

  /// No description provided for @locationExpired.
  ///
  /// In zh, this message translates to:
  /// **'已过期'**
  String get locationExpired;

  /// No description provided for @secondsRemaining.
  ///
  /// In zh, this message translates to:
  /// **'{count}秒'**
  String secondsRemaining(int count);

  /// No description provided for @minutesRemaining.
  ///
  /// In zh, this message translates to:
  /// **'{count}分钟'**
  String minutesRemaining(int count);

  /// No description provided for @hoursMinutesRemaining.
  ///
  /// In zh, this message translates to:
  /// **'{hours}小时{minutes}分钟'**
  String hoursMinutesRemaining(int hours, int minutes);

  /// No description provided for @favoriteMessages.
  ///
  /// In zh, this message translates to:
  /// **'收藏消息'**
  String get favoriteMessages;

  /// No description provided for @linksCopied.
  ///
  /// In zh, this message translates to:
  /// **'链接已复制'**
  String get linksCopied;

  /// No description provided for @noLinksFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到链接'**
  String get noLinksFound;

  /// No description provided for @roomStorageRanking.
  ///
  /// In zh, this message translates to:
  /// **'房间存储排行'**
  String get roomStorageRanking;

  /// No description provided for @downloadComplete.
  ///
  /// In zh, this message translates to:
  /// **'下载完成'**
  String get downloadComplete;

  /// No description provided for @downloading.
  ///
  /// In zh, this message translates to:
  /// **'下载中...'**
  String get downloading;

  /// No description provided for @draftSaved.
  ///
  /// In zh, this message translates to:
  /// **'草稿已保存'**
  String get draftSaved;

  /// No description provided for @voiceRecording.
  ///
  /// In zh, this message translates to:
  /// **'语音录制'**
  String get voiceRecording;

  /// No description provided for @searchLocation.
  ///
  /// In zh, this message translates to:
  /// **'搜索地点'**
  String get searchLocation;

  /// No description provided for @tapToSearch.
  ///
  /// In zh, this message translates to:
  /// **'点击搜索'**
  String get tapToSearch;

  /// No description provided for @settingsThisDevice.
  ///
  /// In zh, this message translates to:
  /// **'本设备'**
  String get settingsThisDevice;

  /// No description provided for @settingsJustNow.
  ///
  /// In zh, this message translates to:
  /// **'刚刚'**
  String get settingsJustNow;

  /// No description provided for @settingsDeviceId.
  ///
  /// In zh, this message translates to:
  /// **'设备 ID'**
  String get settingsDeviceId;

  /// No description provided for @settingsStatus.
  ///
  /// In zh, this message translates to:
  /// **'状态'**
  String get settingsStatus;

  /// No description provided for @settingsLastActive.
  ///
  /// In zh, this message translates to:
  /// **'最后活跃'**
  String get settingsLastActive;

  /// No description provided for @settingsIpAddress.
  ///
  /// In zh, this message translates to:
  /// **'IP 地址'**
  String get settingsIpAddress;

  /// No description provided for @settingsRenameDevice.
  ///
  /// In zh, this message translates to:
  /// **'重命名设备'**
  String get settingsRenameDevice;

  /// No description provided for @settingsDeviceNameHint.
  ///
  /// In zh, this message translates to:
  /// **'输入设备名称'**
  String get settingsDeviceNameHint;

  /// No description provided for @settingsDeviceRenamed.
  ///
  /// In zh, this message translates to:
  /// **'设备已重命名'**
  String get settingsDeviceRenamed;

  /// No description provided for @settingsRenameFailed.
  ///
  /// In zh, this message translates to:
  /// **'重命名失败'**
  String get settingsRenameFailed;

  /// No description provided for @settingsRemoteLogout.
  ///
  /// In zh, this message translates to:
  /// **'远程登出'**
  String get settingsRemoteLogout;

  /// No description provided for @settingsRemoteLogoutConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要登出「{deviceName}」吗？此操作无法撤销。'**
  String settingsRemoteLogoutConfirm(String deviceName);

  /// No description provided for @settingsDeviceLoggedOut.
  ///
  /// In zh, this message translates to:
  /// **'设备已登出'**
  String get settingsDeviceLoggedOut;

  /// No description provided for @settingsLogoutFailed.
  ///
  /// In zh, this message translates to:
  /// **'登出失败'**
  String get settingsLogoutFailed;

  /// No description provided for @settingsLogout.
  ///
  /// In zh, this message translates to:
  /// **'登出'**
  String get settingsLogout;

  /// No description provided for @settingsVerifyIdentity.
  ///
  /// In zh, this message translates to:
  /// **'验证身份'**
  String get settingsVerifyIdentity;

  /// No description provided for @settingsEnterPasswordToConfirm.
  ///
  /// In zh, this message translates to:
  /// **'请输入密码以确认此操作。'**
  String get settingsEnterPasswordToConfirm;

  /// No description provided for @scheduledSendTitle.
  ///
  /// In zh, this message translates to:
  /// **'定时发送'**
  String get scheduledSendTitle;

  /// No description provided for @scheduledSendInOneHour.
  ///
  /// In zh, this message translates to:
  /// **'1小时后'**
  String get scheduledSendInOneHour;

  /// No description provided for @scheduledSendTonight.
  ///
  /// In zh, this message translates to:
  /// **'今晚 (20:00)'**
  String get scheduledSendTonight;

  /// No description provided for @scheduledSendTomorrowMorning.
  ///
  /// In zh, this message translates to:
  /// **'明早 (9:00)'**
  String get scheduledSendTomorrowMorning;

  /// No description provided for @scheduledSendCustom.
  ///
  /// In zh, this message translates to:
  /// **'自定义时间'**
  String get scheduledSendCustom;

  /// No description provided for @scheduledMessageLabel.
  ///
  /// In zh, this message translates to:
  /// **'定时发送'**
  String get scheduledMessageLabel;

  /// No description provided for @scheduledMessageCancel.
  ///
  /// In zh, this message translates to:
  /// **'取消定时发送'**
  String get scheduledMessageCancel;

  /// No description provided for @chatLockTitle.
  ///
  /// In zh, this message translates to:
  /// **'聊天锁'**
  String get chatLockTitle;

  /// No description provided for @chatLockEnable.
  ///
  /// In zh, this message translates to:
  /// **'锁定此聊天'**
  String get chatLockEnable;

  /// No description provided for @chatLockDisable.
  ///
  /// In zh, this message translates to:
  /// **'解锁此聊天'**
  String get chatLockDisable;

  /// No description provided for @chatLockDescription.
  ///
  /// In zh, this message translates to:
  /// **'锁定的聊天需要通过生物识别或 PIN 码验证才能打开'**
  String get chatLockDescription;

  /// No description provided for @chatLockVerifyTitle.
  ///
  /// In zh, this message translates to:
  /// **'聊天已锁定'**
  String get chatLockVerifyTitle;

  /// No description provided for @chatLockVerifySubtitle.
  ///
  /// In zh, this message translates to:
  /// **'验证后访问此聊天'**
  String get chatLockVerifySubtitle;

  /// No description provided for @chatLockVerifyFailed.
  ///
  /// In zh, this message translates to:
  /// **'验证失败'**
  String get chatLockVerifyFailed;

  /// No description provided for @chatLockEnabled.
  ///
  /// In zh, this message translates to:
  /// **'聊天已锁定'**
  String get chatLockEnabled;

  /// No description provided for @chatLockDisabled.
  ///
  /// In zh, this message translates to:
  /// **'聊天已解锁'**
  String get chatLockDisabled;

  /// No description provided for @chatLockPinTitle.
  ///
  /// In zh, this message translates to:
  /// **'输入 PIN 码'**
  String get chatLockPinTitle;

  /// No description provided for @chatLockPinSetTitle.
  ///
  /// In zh, this message translates to:
  /// **'设置 PIN 码'**
  String get chatLockPinSetTitle;

  /// No description provided for @chatLockPinConfirmTitle.
  ///
  /// In zh, this message translates to:
  /// **'确认 PIN 码'**
  String get chatLockPinConfirmTitle;

  /// No description provided for @chatLockPinMismatch.
  ///
  /// In zh, this message translates to:
  /// **'PIN 码不一致'**
  String get chatLockPinMismatch;

  /// No description provided for @chatLockUseBiometric.
  ///
  /// In zh, this message translates to:
  /// **'使用生物识别'**
  String get chatLockUseBiometric;

  /// No description provided for @chatLockUsePin.
  ///
  /// In zh, this message translates to:
  /// **'使用 PIN 码'**
  String get chatLockUsePin;

  /// No description provided for @mediaEditorUndo.
  ///
  /// In zh, this message translates to:
  /// **'撤销'**
  String get mediaEditorUndo;

  /// No description provided for @mediaEditorRedo.
  ///
  /// In zh, this message translates to:
  /// **'重做'**
  String get mediaEditorRedo;

  /// No description provided for @mediaEditorCrop.
  ///
  /// In zh, this message translates to:
  /// **'裁剪'**
  String get mediaEditorCrop;

  /// No description provided for @mediaEditorFilter.
  ///
  /// In zh, this message translates to:
  /// **'滤镜'**
  String get mediaEditorFilter;

  /// No description provided for @mediaEditorDraw.
  ///
  /// In zh, this message translates to:
  /// **'涂鸦'**
  String get mediaEditorDraw;

  /// No description provided for @mediaEditorText.
  ///
  /// In zh, this message translates to:
  /// **'文字'**
  String get mediaEditorText;

  /// No description provided for @aiAssistant.
  ///
  /// In zh, this message translates to:
  /// **'AI 助手'**
  String get aiAssistant;

  /// No description provided for @aiAssistantWelcome.
  ///
  /// In zh, this message translates to:
  /// **'你好！我是 N42 AI 助手，有什么可以帮你的吗？'**
  String get aiAssistantWelcome;

  /// No description provided for @aiAssistantNotConfigured.
  ///
  /// In zh, this message translates to:
  /// **'AI 服务未配置'**
  String get aiAssistantNotConfigured;

  /// No description provided for @aiAssistantSettings.
  ///
  /// In zh, this message translates to:
  /// **'AI 设置'**
  String get aiAssistantSettings;

  /// No description provided for @aiAssistantClearHistory.
  ///
  /// In zh, this message translates to:
  /// **'清空对话历史'**
  String get aiAssistantClearHistory;

  /// No description provided for @aiAssistantClearHistoryConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定清空所有 AI 对话历史？'**
  String get aiAssistantClearHistoryConfirm;

  /// No description provided for @aiAssistantStopGenerating.
  ///
  /// In zh, this message translates to:
  /// **'停止生成'**
  String get aiAssistantStopGenerating;

  /// No description provided for @aiAssistantModel.
  ///
  /// In zh, this message translates to:
  /// **'模型'**
  String get aiAssistantModel;

  /// No description provided for @aiAssistantTemperature.
  ///
  /// In zh, this message translates to:
  /// **'温度'**
  String get aiAssistantTemperature;

  /// No description provided for @aiAssistantMaxTokens.
  ///
  /// In zh, this message translates to:
  /// **'最大令牌数'**
  String get aiAssistantMaxTokens;

  /// No description provided for @aiAssistantContextWindow.
  ///
  /// In zh, this message translates to:
  /// **'上下文窗口'**
  String get aiAssistantContextWindow;

  /// No description provided for @aiAssistantServiceStatus.
  ///
  /// In zh, this message translates to:
  /// **'服务状态'**
  String get aiAssistantServiceStatus;

  /// No description provided for @aiAssistantAvailable.
  ///
  /// In zh, this message translates to:
  /// **'可用'**
  String get aiAssistantAvailable;

  /// No description provided for @aiAssistantUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'不可用'**
  String get aiAssistantUnavailable;

  /// No description provided for @aiSummarize.
  ///
  /// In zh, this message translates to:
  /// **'AI 总结'**
  String get aiSummarize;

  /// No description provided for @aiSummarizeUnread.
  ///
  /// In zh, this message translates to:
  /// **'AI 总结 {count} 条未读消息'**
  String aiSummarizeUnread(int count);

  /// No description provided for @aiSummarizeLoading.
  ///
  /// In zh, this message translates to:
  /// **'正在总结...'**
  String get aiSummarizeLoading;

  /// No description provided for @aiSummarizeError.
  ///
  /// In zh, this message translates to:
  /// **'总结失败'**
  String get aiSummarizeError;

  /// No description provided for @aiRewrite.
  ///
  /// In zh, this message translates to:
  /// **'AI 改写'**
  String get aiRewrite;

  /// No description provided for @aiRewriteFormal.
  ///
  /// In zh, this message translates to:
  /// **'正式'**
  String get aiRewriteFormal;

  /// No description provided for @aiRewriteCasual.
  ///
  /// In zh, this message translates to:
  /// **'轻松'**
  String get aiRewriteCasual;

  /// No description provided for @aiRewritePlayful.
  ///
  /// In zh, this message translates to:
  /// **'俏皮'**
  String get aiRewritePlayful;

  /// No description provided for @aiRewriteProfessional.
  ///
  /// In zh, this message translates to:
  /// **'专业'**
  String get aiRewriteProfessional;

  /// No description provided for @aiRewriteAccept.
  ///
  /// In zh, this message translates to:
  /// **'使用'**
  String get aiRewriteAccept;

  /// No description provided for @aiRewriteCancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get aiRewriteCancel;

  /// No description provided for @aiRewriteLoading.
  ///
  /// In zh, this message translates to:
  /// **'正在改写...'**
  String get aiRewriteLoading;

  /// No description provided for @aiLinkSummary.
  ///
  /// In zh, this message translates to:
  /// **'AI 摘要'**
  String get aiLinkSummary;

  /// No description provided for @aiLinkSummaryAnalyzing.
  ///
  /// In zh, this message translates to:
  /// **'正在分析...'**
  String get aiLinkSummaryAnalyzing;

  /// No description provided for @chatFolderManagement.
  ///
  /// In zh, this message translates to:
  /// **'管理文件夹'**
  String get chatFolderManagement;

  /// No description provided for @chatFolderSystem.
  ///
  /// In zh, this message translates to:
  /// **'系统文件夹'**
  String get chatFolderSystem;

  /// No description provided for @chatFolderCustom.
  ///
  /// In zh, this message translates to:
  /// **'自定义文件夹'**
  String get chatFolderCustom;

  /// No description provided for @chatFolderEmpty.
  ///
  /// In zh, this message translates to:
  /// **'暂无自定义文件夹'**
  String get chatFolderEmpty;

  /// No description provided for @chatFolderCreate.
  ///
  /// In zh, this message translates to:
  /// **'创建文件夹'**
  String get chatFolderCreate;

  /// No description provided for @chatFolderEdit.
  ///
  /// In zh, this message translates to:
  /// **'编辑文件夹'**
  String get chatFolderEdit;

  /// No description provided for @chatFolderNameHint.
  ///
  /// In zh, this message translates to:
  /// **'文件夹名称'**
  String get chatFolderNameHint;

  /// No description provided for @chatFolderAll.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get chatFolderAll;

  /// No description provided for @chatFolderUnread.
  ///
  /// In zh, this message translates to:
  /// **'未读'**
  String get chatFolderUnread;

  /// No description provided for @chatFolderPersonal.
  ///
  /// In zh, this message translates to:
  /// **'私聊'**
  String get chatFolderPersonal;

  /// No description provided for @chatFolderGroups.
  ///
  /// In zh, this message translates to:
  /// **'群组'**
  String get chatFolderGroups;

  /// No description provided for @chatFolderChannels.
  ///
  /// In zh, this message translates to:
  /// **'频道'**
  String get chatFolderChannels;

  /// No description provided for @chatFolderMuted.
  ///
  /// In zh, this message translates to:
  /// **'已静音'**
  String get chatFolderMuted;

  /// No description provided for @storyAddMusic.
  ///
  /// In zh, this message translates to:
  /// **'添加音乐'**
  String get storyAddMusic;

  /// No description provided for @storyChangeMusic.
  ///
  /// In zh, this message translates to:
  /// **'更换音乐'**
  String get storyChangeMusic;

  /// No description provided for @storyBackgroundMusic.
  ///
  /// In zh, this message translates to:
  /// **'背景音乐'**
  String get storyBackgroundMusic;

  /// No description provided for @storyMusicPreview.
  ///
  /// In zh, this message translates to:
  /// **'预览 (最长15秒)'**
  String get storyMusicPreview;

  /// No description provided for @storyChooseFromDevice.
  ///
  /// In zh, this message translates to:
  /// **'从设备选择'**
  String get storyChooseFromDevice;

  /// No description provided for @storyUseThisMusic.
  ///
  /// In zh, this message translates to:
  /// **'使用此音乐'**
  String get storyUseThisMusic;

  /// No description provided for @authPasskeyNotSupported.
  ///
  /// In zh, this message translates to:
  /// **'此设备不支持 Passkey'**
  String get authPasskeyNotSupported;

  /// No description provided for @authPasskeyRegister.
  ///
  /// In zh, this message translates to:
  /// **'注册 Passkey'**
  String get authPasskeyRegister;

  /// No description provided for @authPasskeyNoRegistered.
  ///
  /// In zh, this message translates to:
  /// **'未注册 Passkey'**
  String get authPasskeyNoRegistered;

  /// No description provided for @authPasskeyRegisterHint.
  ///
  /// In zh, this message translates to:
  /// **'注册 Passkey 以实现无密码登录'**
  String get authPasskeyRegisterHint;

  /// No description provided for @authPasskeyNameYours.
  ///
  /// In zh, this message translates to:
  /// **'为 Passkey 命名'**
  String get authPasskeyNameYours;

  /// No description provided for @authPasskeyRegistered.
  ///
  /// In zh, this message translates to:
  /// **'Passkey 注册成功'**
  String get authPasskeyRegistered;

  /// No description provided for @authPasskeyDeleted.
  ///
  /// In zh, this message translates to:
  /// **'Passkey 已删除'**
  String get authPasskeyDeleted;

  /// No description provided for @authPasskeyDeleteConfirm.
  ///
  /// In zh, this message translates to:
  /// **'删除 Passkey \"{name}\"？删除后将无法使用该 Passkey 登录。'**
  String authPasskeyDeleteConfirm(String name);

  /// No description provided for @momentVisibilityPublic.
  ///
  /// In zh, this message translates to:
  /// **'公开'**
  String get momentVisibilityPublic;

  /// No description provided for @momentVisibilityPrivate.
  ///
  /// In zh, this message translates to:
  /// **'私密'**
  String get momentVisibilityPrivate;

  /// No description provided for @momentVisibilityPartial.
  ///
  /// In zh, this message translates to:
  /// **'部分可见'**
  String get momentVisibilityPartial;

  /// No description provided for @momentVisibilityExcluded.
  ///
  /// In zh, this message translates to:
  /// **'不给谁看'**
  String get momentVisibilityExcluded;

  /// No description provided for @momentUserMoments.
  ///
  /// In zh, this message translates to:
  /// **'{userName}的朋友圈'**
  String momentUserMoments(String userName);

  /// No description provided for @momentForwardTo.
  ///
  /// In zh, this message translates to:
  /// **'转发给'**
  String get momentForwardTo;

  /// No description provided for @momentForwardSuccess.
  ///
  /// In zh, this message translates to:
  /// **'转发成功'**
  String get momentForwardSuccess;

  /// No description provided for @momentSelectFriends.
  ///
  /// In zh, this message translates to:
  /// **'选择好友'**
  String get momentSelectFriends;

  /// No description provided for @momentSelectTags.
  ///
  /// In zh, this message translates to:
  /// **'按标签选择'**
  String get momentSelectTags;

  /// No description provided for @momentSelectedCount.
  ///
  /// In zh, this message translates to:
  /// **'已选择 ({count})'**
  String momentSelectedCount(int count);

  /// No description provided for @momentNoMomentsYet.
  ///
  /// In zh, this message translates to:
  /// **'暂无动态'**
  String get momentNoMomentsYet;

  /// No description provided for @momentForwardMoment.
  ///
  /// In zh, this message translates to:
  /// **'转发动态'**
  String get momentForwardMoment;

  /// No description provided for @momentAddComment.
  ///
  /// In zh, this message translates to:
  /// **'写评论...'**
  String get momentAddComment;

  /// No description provided for @momentForwardContent.
  ///
  /// In zh, this message translates to:
  /// **'[朋友圈] {content}'**
  String momentForwardContent(String content);

  /// No description provided for @momentDeleteMoment.
  ///
  /// In zh, this message translates to:
  /// **'删除动态'**
  String get momentDeleteMoment;

  /// No description provided for @momentDeleteConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这条动态吗？'**
  String get momentDeleteConfirm;

  /// No description provided for @momentComment.
  ///
  /// In zh, this message translates to:
  /// **'评论'**
  String get momentComment;

  /// No description provided for @momentWriteComment.
  ///
  /// In zh, this message translates to:
  /// **'写评论...'**
  String get momentWriteComment;

  /// No description provided for @momentLike.
  ///
  /// In zh, this message translates to:
  /// **'赞'**
  String get momentLike;

  /// No description provided for @momentUnlike.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get momentUnlike;

  /// No description provided for @momentForward.
  ///
  /// In zh, this message translates to:
  /// **'转发'**
  String get momentForward;

  /// No description provided for @momentDelete.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get momentDelete;

  /// No description provided for @momentReply.
  ///
  /// In zh, this message translates to:
  /// **'回复'**
  String get momentReply;

  /// No description provided for @momentMoment.
  ///
  /// In zh, this message translates to:
  /// **'动态'**
  String get momentMoment;

  /// No description provided for @momentLikesCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 个赞'**
  String momentLikesCount(int count);

  /// No description provided for @momentCommentsCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 条评论'**
  String momentCommentsCount(int count);

  /// No description provided for @momentNoComments.
  ///
  /// In zh, this message translates to:
  /// **'暂无评论'**
  String get momentNoComments;

  /// No description provided for @momentFailedToLoad.
  ///
  /// In zh, this message translates to:
  /// **'图片加载失败'**
  String get momentFailedToLoad;

  /// No description provided for @momentReplyTo.
  ///
  /// In zh, this message translates to:
  /// **'回复 {userName}...'**
  String momentReplyTo(String userName);

  /// No description provided for @momentNoConversations.
  ///
  /// In zh, this message translates to:
  /// **'暂无会话'**
  String get momentNoConversations;

  /// No description provided for @momentJustNow.
  ///
  /// In zh, this message translates to:
  /// **'刚刚'**
  String get momentJustNow;

  /// No description provided for @momentMinutesAgo.
  ///
  /// In zh, this message translates to:
  /// **'{count}分钟前'**
  String momentMinutesAgo(int count);

  /// No description provided for @momentHoursAgo.
  ///
  /// In zh, this message translates to:
  /// **'{count}小时前'**
  String momentHoursAgo(int count);

  /// No description provided for @momentDaysAgo.
  ///
  /// In zh, this message translates to:
  /// **'{count}天前'**
  String momentDaysAgo(int count);

  /// No description provided for @chatGroupAnnouncementHint.
  ///
  /// In zh, this message translates to:
  /// **'输入群公告'**
  String get chatGroupAnnouncementHint;

  /// No description provided for @chatGroupAnnouncementEmpty.
  ///
  /// In zh, this message translates to:
  /// **'暂无群公告'**
  String get chatGroupAnnouncementEmpty;

  /// No description provided for @chatEditNickname.
  ///
  /// In zh, this message translates to:
  /// **'编辑群昵称'**
  String get chatEditNickname;

  /// No description provided for @chatNicknameHint.
  ///
  /// In zh, this message translates to:
  /// **'输入你在群里的昵称'**
  String get chatNicknameHint;

  /// No description provided for @contactAddPhoneHint.
  ///
  /// In zh, this message translates to:
  /// **'输入电话号码'**
  String get contactAddPhoneHint;

  /// No description provided for @contactNotesHint.
  ///
  /// In zh, this message translates to:
  /// **'添加联系人备忘'**
  String get contactNotesHint;

  /// No description provided for @reportTitle.
  ///
  /// In zh, this message translates to:
  /// **'投诉'**
  String get reportTitle;

  /// No description provided for @reportReasonSpam.
  ///
  /// In zh, this message translates to:
  /// **'垃圾信息'**
  String get reportReasonSpam;

  /// No description provided for @reportReasonHarassment.
  ///
  /// In zh, this message translates to:
  /// **'骚扰'**
  String get reportReasonHarassment;

  /// No description provided for @reportReasonFraud.
  ///
  /// In zh, this message translates to:
  /// **'欺诈'**
  String get reportReasonFraud;

  /// No description provided for @reportReasonOther.
  ///
  /// In zh, this message translates to:
  /// **'其他'**
  String get reportReasonOther;

  /// No description provided for @reportSubmitted.
  ///
  /// In zh, this message translates to:
  /// **'投诉已提交'**
  String get reportSubmitted;

  /// No description provided for @reportDescription.
  ///
  /// In zh, this message translates to:
  /// **'补充说明（选填）'**
  String get reportDescription;

  /// No description provided for @qrcodeSaved.
  ///
  /// In zh, this message translates to:
  /// **'二维码已保存到相册'**
  String get qrcodeSaved;

  /// No description provided for @chatSendRedPacketInChat.
  ///
  /// In zh, this message translates to:
  /// **'请在聊天中发送红包'**
  String get chatSendRedPacketInChat;

  /// No description provided for @commonSaveFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存失败'**
  String get commonSaveFailed;

  /// No description provided for @reportSelectReason.
  ///
  /// In zh, this message translates to:
  /// **'请选择投诉原因'**
  String get reportSelectReason;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'id',
    'it',
    'ja',
    'ko',
    'pl',
    'pt',
    'ru',
    'tr',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return SDe();
    case 'en':
      return SEn();
    case 'es':
      return SEs();
    case 'fr':
      return SFr();
    case 'id':
      return SId();
    case 'it':
      return SIt();
    case 'ja':
      return SJa();
    case 'ko':
      return SKo();
    case 'pl':
      return SPl();
    case 'pt':
      return SPt();
    case 'ru':
      return SRu();
    case 'tr':
      return STr();
    case 'vi':
      return SVi();
    case 'zh':
      return SZh();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
