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
    Locale('zh')
  ];

  /// No description provided for @chatModuleInitFailed.
  ///
  /// In zh, this message translates to:
  /// **'聊天模块初始化失败'**
  String get chatModuleInitFailed;

  /// No description provided for @checkNetworkRetry.
  ///
  /// In zh, this message translates to:
  /// **'请检查网络连接后重试'**
  String get checkNetworkRetry;

  /// No description provided for @retry.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get retry;

  /// No description provided for @unknownUser.
  ///
  /// In zh, this message translates to:
  /// **'未知用户'**
  String get unknownUser;

  /// No description provided for @walletNotConnected.
  ///
  /// In zh, this message translates to:
  /// **'钱包未连接'**
  String get walletNotConnected;

  /// No description provided for @cannotGetWalletAddress.
  ///
  /// In zh, this message translates to:
  /// **'无法获取钱包地址'**
  String get cannotGetWalletAddress;

  /// No description provided for @paymentRequestMemo.
  ///
  /// In zh, this message translates to:
  /// **'支付请求: {requestId}'**
  String paymentRequestMemo(String requestId);

  /// No description provided for @callServiceNotInitialized.
  ///
  /// In zh, this message translates to:
  /// **'通话服务未初始化'**
  String get callServiceNotInitialized;

  /// No description provided for @alreadyInCall.
  ///
  /// In zh, this message translates to:
  /// **'当前正在通话中'**
  String get alreadyInCall;

  /// No description provided for @meetingServiceNotInitialized.
  ///
  /// In zh, this message translates to:
  /// **'会议服务未初始化'**
  String get meetingServiceNotInitialized;

  /// No description provided for @livekitNotConfigured.
  ///
  /// In zh, this message translates to:
  /// **'LiveKit 未配置'**
  String get livekitNotConfigured;

  /// No description provided for @unknownConversation.
  ///
  /// In zh, this message translates to:
  /// **'未知会话'**
  String get unknownConversation;

  /// No description provided for @startCallFailed.
  ///
  /// In zh, this message translates to:
  /// **'发起通话失败: {error}'**
  String startCallFailed(String error);

  /// No description provided for @answerCallFailed.
  ///
  /// In zh, this message translates to:
  /// **'接听失败: {error}'**
  String answerCallFailed(String error);

  /// No description provided for @connectionFailed.
  ///
  /// In zh, this message translates to:
  /// **'连接失败'**
  String get connectionFailed;

  /// No description provided for @callRejected.
  ///
  /// In zh, this message translates to:
  /// **'对方已拒绝'**
  String get callRejected;

  /// No description provided for @noAnswer.
  ///
  /// In zh, this message translates to:
  /// **'对方无应答'**
  String get noAnswer;

  /// No description provided for @invalidLoginResponse.
  ///
  /// In zh, this message translates to:
  /// **'登录响应无效'**
  String get invalidLoginResponse;

  /// No description provided for @loginFailed.
  ///
  /// In zh, this message translates to:
  /// **'登录失败: {error}'**
  String loginFailed(String error);

  /// No description provided for @sessionRestoreFailed.
  ///
  /// In zh, this message translates to:
  /// **'会话恢复失败'**
  String get sessionRestoreFailed;

  /// No description provided for @additionalVerificationRequired.
  ///
  /// In zh, this message translates to:
  /// **'需要完成额外验证'**
  String get additionalVerificationRequired;

  /// No description provided for @registrationFailed.
  ///
  /// In zh, this message translates to:
  /// **'注册失败: {error}'**
  String registrationFailed(String error);

  /// No description provided for @cannotConnectServer.
  ///
  /// In zh, this message translates to:
  /// **'无法连接到服务器: {error}'**
  String cannotConnectServer(String error);

  /// No description provided for @wrongUsernamePassword.
  ///
  /// In zh, this message translates to:
  /// **'用户名或密码错误'**
  String get wrongUsernamePassword;

  /// No description provided for @usernameTaken.
  ///
  /// In zh, this message translates to:
  /// **'用户名已被使用'**
  String get usernameTaken;

  /// No description provided for @invalidUsernameFormat.
  ///
  /// In zh, this message translates to:
  /// **'用户名格式无效'**
  String get invalidUsernameFormat;

  /// No description provided for @rateLimitExceeded.
  ///
  /// In zh, this message translates to:
  /// **'请求过于频繁，请稍后再试'**
  String get rateLimitExceeded;

  /// No description provided for @loginExpired.
  ///
  /// In zh, this message translates to:
  /// **'登录已过期'**
  String get loginExpired;

  /// No description provided for @joinMeetingFailed.
  ///
  /// In zh, this message translates to:
  /// **'加入会议失败: {error}'**
  String joinMeetingFailed(String error);

  /// No description provided for @screenShareFailed.
  ///
  /// In zh, this message translates to:
  /// **'屏幕共享失败: {error}'**
  String screenShareFailed(String error);

  /// No description provided for @answer.
  ///
  /// In zh, this message translates to:
  /// **'接听'**
  String get answer;

  /// No description provided for @decline.
  ///
  /// In zh, this message translates to:
  /// **'拒绝'**
  String get decline;

  /// No description provided for @missedCall.
  ///
  /// In zh, this message translates to:
  /// **'未接来电'**
  String get missedCall;

  /// No description provided for @callBack.
  ///
  /// In zh, this message translates to:
  /// **'回拨'**
  String get callBack;

  /// No description provided for @incomingCall.
  ///
  /// In zh, this message translates to:
  /// **'来电'**
  String get incomingCall;

  /// No description provided for @missedVideoCall.
  ///
  /// In zh, this message translates to:
  /// **'未接视频通话'**
  String get missedVideoCall;

  /// No description provided for @missedVoiceCall.
  ///
  /// In zh, this message translates to:
  /// **'未接语音通话'**
  String get missedVoiceCall;

  /// No description provided for @passkeyNotInitialized.
  ///
  /// In zh, this message translates to:
  /// **'Passkey 未初始化'**
  String get passkeyNotInitialized;

  /// No description provided for @googleSignInNotConfigured.
  ///
  /// In zh, this message translates to:
  /// **'Google Sign In 未配置'**
  String get googleSignInNotConfigured;

  /// No description provided for @encryptedMessage.
  ///
  /// In zh, this message translates to:
  /// **'[加密消息]'**
  String get encryptedMessage;

  /// No description provided for @sticker.
  ///
  /// In zh, this message translates to:
  /// **'[表情]'**
  String get sticker;

  /// No description provided for @groupCreated.
  ///
  /// In zh, this message translates to:
  /// **'创建了群聊'**
  String get groupCreated;

  /// No description provided for @groupNameChanged.
  ///
  /// In zh, this message translates to:
  /// **'修改了群名称'**
  String get groupNameChanged;

  /// No description provided for @groupAvatarChanged.
  ///
  /// In zh, this message translates to:
  /// **'修改了群头像'**
  String get groupAvatarChanged;

  /// No description provided for @groupAnnouncementChanged.
  ///
  /// In zh, this message translates to:
  /// **'修改了群公告'**
  String get groupAnnouncementChanged;

  /// No description provided for @image.
  ///
  /// In zh, this message translates to:
  /// **'[图片]'**
  String get image;

  /// No description provided for @video.
  ///
  /// In zh, this message translates to:
  /// **'[视频]'**
  String get video;

  /// No description provided for @voice.
  ///
  /// In zh, this message translates to:
  /// **'[语音]'**
  String get voice;

  /// No description provided for @file.
  ///
  /// In zh, this message translates to:
  /// **'[文件]'**
  String get file;

  /// No description provided for @location.
  ///
  /// In zh, this message translates to:
  /// **'[位置]'**
  String get location;

  /// No description provided for @unknownMessage.
  ///
  /// In zh, this message translates to:
  /// **'[未知消息]'**
  String get unknownMessage;

  /// No description provided for @joinedGroup.
  ///
  /// In zh, this message translates to:
  /// **'{senderName} 加入了群聊'**
  String joinedGroup(String senderName);

  /// No description provided for @leftGroup.
  ///
  /// In zh, this message translates to:
  /// **'{senderName} 离开了群聊'**
  String leftGroup(String senderName);

  /// No description provided for @invitedToGroup.
  ///
  /// In zh, this message translates to:
  /// **'{senderName} 被邀请加入'**
  String invitedToGroup(String senderName);

  /// No description provided for @removedFromGroup.
  ///
  /// In zh, this message translates to:
  /// **'{senderName} 被移出群聊'**
  String removedFromGroup(String senderName);

  /// No description provided for @avatarDataEmpty.
  ///
  /// In zh, this message translates to:
  /// **'头像数据为空'**
  String get avatarDataEmpty;

  /// No description provided for @avatarTooLarge.
  ///
  /// In zh, this message translates to:
  /// **'头像文件过大，最大支持 10MB'**
  String get avatarTooLarge;

  /// No description provided for @uploadAvatarFailed.
  ///
  /// In zh, this message translates to:
  /// **'上传头像失败'**
  String get uploadAvatarFailed;

  /// No description provided for @delete.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get delete;

  /// No description provided for @notLoggedIn.
  ///
  /// In zh, this message translates to:
  /// **'未登录'**
  String get notLoggedIn;

  /// No description provided for @roomNotExist.
  ///
  /// In zh, this message translates to:
  /// **'房间不存在: {roomId}'**
  String roomNotExist(String roomId);

  /// No description provided for @uploadImageFailed.
  ///
  /// In zh, this message translates to:
  /// **'上传图片失败'**
  String get uploadImageFailed;

  /// No description provided for @matrixClientNotInitialized.
  ///
  /// In zh, this message translates to:
  /// **'Matrix 客户端未初始化'**
  String get matrixClientNotInitialized;

  /// No description provided for @uploadVoiceFailed.
  ///
  /// In zh, this message translates to:
  /// **'上传语音失败：无法获取 MXC URI'**
  String get uploadVoiceFailed;

  /// No description provided for @uploadVideoFailed.
  ///
  /// In zh, this message translates to:
  /// **'上传视频失败：无法获取 MXC URI'**
  String get uploadVideoFailed;

  /// No description provided for @uploadFileFailed.
  ///
  /// In zh, this message translates to:
  /// **'上传文件失败：无法获取 MXC URI'**
  String get uploadFileFailed;

  /// No description provided for @locationWithCoords.
  ///
  /// In zh, this message translates to:
  /// **'位置: {lat}, {lon}'**
  String locationWithCoords(String lat, String lon);

  /// No description provided for @myLocation.
  ///
  /// In zh, this message translates to:
  /// **'我的位置'**
  String get myLocation;

  /// No description provided for @pollEnded.
  ///
  /// In zh, this message translates to:
  /// **'投票已结束'**
  String get pollEnded;

  /// No description provided for @groupChat.
  ///
  /// In zh, this message translates to:
  /// **'群聊'**
  String get groupChat;

  /// No description provided for @search.
  ///
  /// In zh, this message translates to:
  /// **'搜索'**
  String get search;

  /// No description provided for @cancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancel;

  /// No description provided for @userCancelled.
  ///
  /// In zh, this message translates to:
  /// **'用户取消'**
  String get userCancelled;

  /// No description provided for @noData.
  ///
  /// In zh, this message translates to:
  /// **'暂无数据'**
  String get noData;

  /// No description provided for @noSearchResults.
  ///
  /// In zh, this message translates to:
  /// **'无搜索结果'**
  String get noSearchResults;

  /// No description provided for @tryDifferentKeyword.
  ///
  /// In zh, this message translates to:
  /// **'换个关键词试试'**
  String get tryDifferentKeyword;

  /// No description provided for @loadFailed.
  ///
  /// In zh, this message translates to:
  /// **'加载失败'**
  String get loadFailed;

  /// No description provided for @checkNetwork.
  ///
  /// In zh, this message translates to:
  /// **'请检查网络连接'**
  String get checkNetwork;

  /// No description provided for @networkConnectionFailed.
  ///
  /// In zh, this message translates to:
  /// **'网络连接失败'**
  String get networkConnectionFailed;

  /// No description provided for @checkNetworkSettings.
  ///
  /// In zh, this message translates to:
  /// **'请检查网络设置'**
  String get checkNetworkSettings;

  /// No description provided for @messages.
  ///
  /// In zh, this message translates to:
  /// **'消息'**
  String get messages;

  /// No description provided for @contacts.
  ///
  /// In zh, this message translates to:
  /// **'联系人'**
  String get contacts;

  /// No description provided for @discover.
  ///
  /// In zh, this message translates to:
  /// **'发现'**
  String get discover;

  /// No description provided for @me.
  ///
  /// In zh, this message translates to:
  /// **'我'**
  String get me;

  /// No description provided for @voiceLoading.
  ///
  /// In zh, this message translates to:
  /// **'语音加载中，请稍后再试'**
  String get voiceLoading;

  /// No description provided for @voiceToTextFailed.
  ///
  /// In zh, this message translates to:
  /// **'语音转文字失败'**
  String get voiceToTextFailed;

  /// No description provided for @converting.
  ///
  /// In zh, this message translates to:
  /// **'转换中...'**
  String get converting;

  /// No description provided for @convertToText.
  ///
  /// In zh, this message translates to:
  /// **'转文字'**
  String get convertToText;

  /// No description provided for @convertToTextTitle.
  ///
  /// In zh, this message translates to:
  /// **'转为文字'**
  String get convertToTextTitle;

  /// No description provided for @selectEmoji.
  ///
  /// In zh, this message translates to:
  /// **'选择表情'**
  String get selectEmoji;

  /// No description provided for @frequentlyUsed.
  ///
  /// In zh, this message translates to:
  /// **'常用'**
  String get frequentlyUsed;

  /// No description provided for @copy.
  ///
  /// In zh, this message translates to:
  /// **'复制'**
  String get copy;

  /// No description provided for @forward.
  ///
  /// In zh, this message translates to:
  /// **'转发'**
  String get forward;

  /// No description provided for @unfavorite.
  ///
  /// In zh, this message translates to:
  /// **'取消收藏'**
  String get unfavorite;

  /// No description provided for @favorite.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get favorite;

  /// No description provided for @resend.
  ///
  /// In zh, this message translates to:
  /// **'重新发送'**
  String get resend;

  /// No description provided for @recall.
  ///
  /// In zh, this message translates to:
  /// **'撤回'**
  String get recall;

  /// No description provided for @multiSelect.
  ///
  /// In zh, this message translates to:
  /// **'多选'**
  String get multiSelect;

  /// No description provided for @quote.
  ///
  /// In zh, this message translates to:
  /// **'引用'**
  String get quote;

  /// No description provided for @remind.
  ///
  /// In zh, this message translates to:
  /// **'提醒'**
  String get remind;

  /// No description provided for @searchThis.
  ///
  /// In zh, this message translates to:
  /// **'搜一搜'**
  String get searchThis;

  /// No description provided for @recallMessageConfirm.
  ///
  /// In zh, this message translates to:
  /// **'撤回该条消息？'**
  String get recallMessageConfirm;

  /// No description provided for @youRecalledMessage.
  ///
  /// In zh, this message translates to:
  /// **'你撤回了一条消息'**
  String get youRecalledMessage;

  /// No description provided for @otherRecalledMessage.
  ///
  /// In zh, this message translates to:
  /// **'对方撤回了一条消息'**
  String get otherRecalledMessage;

  /// No description provided for @reEdit.
  ///
  /// In zh, this message translates to:
  /// **'重新编辑'**
  String get reEdit;

  /// No description provided for @copied.
  ///
  /// In zh, this message translates to:
  /// **'已复制'**
  String get copied;

  /// No description provided for @sendMessageHint.
  ///
  /// In zh, this message translates to:
  /// **'发送消息'**
  String get sendMessageHint;

  /// No description provided for @microphonePermissionRequired.
  ///
  /// In zh, this message translates to:
  /// **'请允许使用麦克风权限'**
  String get microphonePermissionRequired;

  /// No description provided for @startRecordingFailed.
  ///
  /// In zh, this message translates to:
  /// **'开始录音失败: {error}'**
  String startRecordingFailed(String error);

  /// No description provided for @recordingTooShort.
  ///
  /// In zh, this message translates to:
  /// **'录音时间太短'**
  String get recordingTooShort;

  /// No description provided for @stopRecordingFailed.
  ///
  /// In zh, this message translates to:
  /// **'停止录音失败: {error}'**
  String stopRecordingFailed(String error);

  /// No description provided for @releaseToCancel.
  ///
  /// In zh, this message translates to:
  /// **'松开取消'**
  String get releaseToCancel;

  /// No description provided for @releaseToSend.
  ///
  /// In zh, this message translates to:
  /// **'松开发送，上滑取消'**
  String get releaseToSend;

  /// No description provided for @holdToTalk.
  ///
  /// In zh, this message translates to:
  /// **'按住 说话'**
  String get holdToTalk;

  /// No description provided for @send.
  ///
  /// In zh, this message translates to:
  /// **'发送'**
  String get send;

  /// No description provided for @conversationWithId.
  ///
  /// In zh, this message translates to:
  /// **'会话: {roomId}'**
  String conversationWithId(String roomId);

  /// No description provided for @contactWithId.
  ///
  /// In zh, this message translates to:
  /// **'联系人: {userId}'**
  String contactWithId(String userId);

  /// No description provided for @addFriend.
  ///
  /// In zh, this message translates to:
  /// **'添加好友'**
  String get addFriend;

  /// No description provided for @chatServiceNotConnected.
  ///
  /// In zh, this message translates to:
  /// **'聊天服务未连接'**
  String get chatServiceNotConnected;

  /// No description provided for @userNotFoundHint.
  ///
  /// In zh, this message translates to:
  /// **'未找到用户 \"{query}\"\n\n提示：\n• 尝试输入完整用户ID，如 @username:server.com\n• 确认用户名拼写正确'**
  String userNotFoundHint(String query);

  /// No description provided for @createChatFailed.
  ///
  /// In zh, this message translates to:
  /// **'创建会话失败: {error}'**
  String createChatFailed(String error);

  /// No description provided for @searchFailed.
  ///
  /// In zh, this message translates to:
  /// **'搜索失败: {error}'**
  String searchFailed(String error);

  /// No description provided for @enterUserIdOrUsername.
  ///
  /// In zh, this message translates to:
  /// **'输入用户 ID 或用户名搜索'**
  String get enterUserIdOrUsername;

  /// No description provided for @searching.
  ///
  /// In zh, this message translates to:
  /// **'搜索中...'**
  String get searching;

  /// No description provided for @searchUserToChat.
  ///
  /// In zh, this message translates to:
  /// **'搜索用户开始聊天'**
  String get searchUserToChat;

  /// No description provided for @matrixIdExample.
  ///
  /// In zh, this message translates to:
  /// **'可以输入完整的 Matrix ID\n例如: @user:matrix.n42.network'**
  String get matrixIdExample;

  /// No description provided for @userNotFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到用户 \"{username}\"'**
  String userNotFound(String username);

  /// No description provided for @chat.
  ///
  /// In zh, this message translates to:
  /// **'聊天'**
  String get chat;

  /// No description provided for @settings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settings;

  /// No description provided for @editProfile.
  ///
  /// In zh, this message translates to:
  /// **'编辑资料'**
  String get editProfile;

  /// No description provided for @login.
  ///
  /// In zh, this message translates to:
  /// **'登录'**
  String get login;

  /// No description provided for @createGroup.
  ///
  /// In zh, this message translates to:
  /// **'创建群聊'**
  String get createGroup;

  /// No description provided for @developing.
  ///
  /// In zh, this message translates to:
  /// **'{title}\n(开发中)'**
  String developing(String title);

  /// No description provided for @error.
  ///
  /// In zh, this message translates to:
  /// **'错误'**
  String get error;

  /// No description provided for @pageNotFound.
  ///
  /// In zh, this message translates to:
  /// **'页面不存在'**
  String get pageNotFound;

  /// No description provided for @backToHome.
  ///
  /// In zh, this message translates to:
  /// **'返回首页'**
  String get backToHome;

  /// No description provided for @allRead.
  ///
  /// In zh, this message translates to:
  /// **'全部已读'**
  String get allRead;

  /// No description provided for @readCount.
  ///
  /// In zh, this message translates to:
  /// **'{count}人已读'**
  String readCount(int count);

  /// No description provided for @transfer.
  ///
  /// In zh, this message translates to:
  /// **'转账'**
  String get transfer;

  /// No description provided for @pendingReceipt.
  ///
  /// In zh, this message translates to:
  /// **'待对方接收'**
  String get pendingReceipt;

  /// No description provided for @tapToReceive.
  ///
  /// In zh, this message translates to:
  /// **'点击领取'**
  String get tapToReceive;

  /// No description provided for @received.
  ///
  /// In zh, this message translates to:
  /// **'已被接收'**
  String get received;

  /// No description provided for @paymentReceived.
  ///
  /// In zh, this message translates to:
  /// **'已收款'**
  String get paymentReceived;

  /// No description provided for @refunded.
  ///
  /// In zh, this message translates to:
  /// **'已退还'**
  String get refunded;

  /// No description provided for @expired.
  ///
  /// In zh, this message translates to:
  /// **'已过期'**
  String get expired;

  /// No description provided for @redPacketGreeting.
  ///
  /// In zh, this message translates to:
  /// **'恭喜发财，大吉大利'**
  String get redPacketGreeting;

  /// No description provided for @n42RedPacket.
  ///
  /// In zh, this message translates to:
  /// **'N42红包'**
  String get n42RedPacket;

  /// No description provided for @goodLuck.
  ///
  /// In zh, this message translates to:
  /// **'领个好彩头'**
  String get goodLuck;

  /// No description provided for @claimed.
  ///
  /// In zh, this message translates to:
  /// **'已领取'**
  String get claimed;

  /// No description provided for @allClaimed.
  ///
  /// In zh, this message translates to:
  /// **'已被领完'**
  String get allClaimed;

  /// No description provided for @emoji.
  ///
  /// In zh, this message translates to:
  /// **'表情'**
  String get emoji;

  /// No description provided for @love.
  ///
  /// In zh, this message translates to:
  /// **'爱心'**
  String get love;

  /// No description provided for @animals.
  ///
  /// In zh, this message translates to:
  /// **'动物'**
  String get animals;

  /// No description provided for @food.
  ///
  /// In zh, this message translates to:
  /// **'食物'**
  String get food;

  /// No description provided for @travel.
  ///
  /// In zh, this message translates to:
  /// **'交通'**
  String get travel;

  /// No description provided for @activities.
  ///
  /// In zh, this message translates to:
  /// **'活动'**
  String get activities;

  /// No description provided for @objects.
  ///
  /// In zh, this message translates to:
  /// **'物品'**
  String get objects;

  /// No description provided for @symbols.
  ///
  /// In zh, this message translates to:
  /// **'符号'**
  String get symbols;

  /// No description provided for @reply.
  ///
  /// In zh, this message translates to:
  /// **'回复'**
  String get reply;

  /// No description provided for @copiedToClipboard.
  ///
  /// In zh, this message translates to:
  /// **'已复制到剪贴板'**
  String get copiedToClipboard;

  /// No description provided for @edit.
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get edit;

  /// No description provided for @more.
  ///
  /// In zh, this message translates to:
  /// **'更多'**
  String get more;

  /// No description provided for @selectForwardTarget.
  ///
  /// In zh, this message translates to:
  /// **'选择转发对象'**
  String get selectForwardTarget;

  /// No description provided for @sendCount.
  ///
  /// In zh, this message translates to:
  /// **'发送({count})'**
  String sendCount(int count);

  /// No description provided for @draft.
  ///
  /// In zh, this message translates to:
  /// **'[草稿] '**
  String get draft;

  /// No description provided for @n42Id.
  ///
  /// In zh, this message translates to:
  /// **'N42号：{id}'**
  String n42Id(String id);

  /// No description provided for @n42IdTitle.
  ///
  /// In zh, this message translates to:
  /// **'N42号'**
  String get n42IdTitle;

  /// No description provided for @n42Bean.
  ///
  /// In zh, this message translates to:
  /// **'N42豆'**
  String get n42Bean;

  /// No description provided for @friendInfo.
  ///
  /// In zh, this message translates to:
  /// **'朋友资料'**
  String get friendInfo;

  /// No description provided for @friendInfoDesc.
  ///
  /// In zh, this message translates to:
  /// **'添加朋友的备注名、电话、标签、备忘、照片等，并设置朋友权限。'**
  String get friendInfoDesc;

  /// No description provided for @moments.
  ///
  /// In zh, this message translates to:
  /// **'朋友圈'**
  String get moments;

  /// No description provided for @sendMessage.
  ///
  /// In zh, this message translates to:
  /// **'发消息'**
  String get sendMessage;

  /// No description provided for @audioVideoCall.
  ///
  /// In zh, this message translates to:
  /// **'音视频通话'**
  String get audioVideoCall;

  /// No description provided for @videoChannel.
  ///
  /// In zh, this message translates to:
  /// **'视频号'**
  String get videoChannel;

  /// No description provided for @remark.
  ///
  /// In zh, this message translates to:
  /// **'备注'**
  String get remark;

  /// No description provided for @remarkName.
  ///
  /// In zh, this message translates to:
  /// **'备注名'**
  String get remarkName;

  /// No description provided for @phone.
  ///
  /// In zh, this message translates to:
  /// **'电话'**
  String get phone;

  /// No description provided for @tags.
  ///
  /// In zh, this message translates to:
  /// **'标签'**
  String get tags;

  /// No description provided for @notes.
  ///
  /// In zh, this message translates to:
  /// **'备忘'**
  String get notes;

  /// No description provided for @photos.
  ///
  /// In zh, this message translates to:
  /// **'照片'**
  String get photos;

  /// No description provided for @permissions.
  ///
  /// In zh, this message translates to:
  /// **'权限'**
  String get permissions;

  /// No description provided for @chatMomentsEtc.
  ///
  /// In zh, this message translates to:
  /// **'聊天、朋友圈、运动等'**
  String get chatMomentsEtc;

  /// No description provided for @moreInfo.
  ///
  /// In zh, this message translates to:
  /// **'更多信息'**
  String get moreInfo;

  /// No description provided for @commonGroups.
  ///
  /// In zh, this message translates to:
  /// **'我和他 (她) 的共同群聊'**
  String get commonGroups;

  /// No description provided for @zeroGroups.
  ///
  /// In zh, this message translates to:
  /// **'0个'**
  String get zeroGroups;

  /// No description provided for @source.
  ///
  /// In zh, this message translates to:
  /// **'来源'**
  String get source;

  /// No description provided for @notificationSettings.
  ///
  /// In zh, this message translates to:
  /// **'消息通知'**
  String get notificationSettings;

  /// No description provided for @receiveNotifications.
  ///
  /// In zh, this message translates to:
  /// **'接收新消息通知'**
  String get receiveNotifications;

  /// No description provided for @showPreview.
  ///
  /// In zh, this message translates to:
  /// **'显示消息预览'**
  String get showPreview;

  /// No description provided for @showContentInNotification.
  ///
  /// In zh, this message translates to:
  /// **'在通知中显示消息内容'**
  String get showContentInNotification;

  /// No description provided for @notificationSound.
  ///
  /// In zh, this message translates to:
  /// **'通知声音'**
  String get notificationSound;

  /// No description provided for @playSoundOnMessage.
  ///
  /// In zh, this message translates to:
  /// **'收到消息时播放声音'**
  String get playSoundOnMessage;

  /// No description provided for @vibrate.
  ///
  /// In zh, this message translates to:
  /// **'震动'**
  String get vibrate;

  /// No description provided for @vibrateOnMessage.
  ///
  /// In zh, this message translates to:
  /// **'收到消息时震动'**
  String get vibrateOnMessage;

  /// No description provided for @doNotDisturb.
  ///
  /// In zh, this message translates to:
  /// **'免打扰模式'**
  String get doNotDisturb;

  /// No description provided for @dndDescription.
  ///
  /// In zh, this message translates to:
  /// **'在指定时间段内不接收通知'**
  String get dndDescription;

  /// No description provided for @startTime.
  ///
  /// In zh, this message translates to:
  /// **'开始时间'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In zh, this message translates to:
  /// **'结束时间'**
  String get endTime;

  /// No description provided for @privacy.
  ///
  /// In zh, this message translates to:
  /// **'隐私'**
  String get privacy;

  /// No description provided for @appearance.
  ///
  /// In zh, this message translates to:
  /// **'外观'**
  String get appearance;

  /// No description provided for @about.
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get about;

  /// No description provided for @logout.
  ///
  /// In zh, this message translates to:
  /// **'退出登录'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要退出登录吗？'**
  String get logoutConfirm;

  /// No description provided for @exit.
  ///
  /// In zh, this message translates to:
  /// **'退出'**
  String get exit;

  /// No description provided for @save.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get save;

  /// No description provided for @nickname.
  ///
  /// In zh, this message translates to:
  /// **'昵称'**
  String get nickname;

  /// No description provided for @enterNickname.
  ///
  /// In zh, this message translates to:
  /// **'请输入昵称'**
  String get enterNickname;

  /// No description provided for @signature.
  ///
  /// In zh, this message translates to:
  /// **'签名'**
  String get signature;

  /// No description provided for @addSignature.
  ///
  /// In zh, this message translates to:
  /// **'添加个性签名'**
  String get addSignature;

  /// No description provided for @takePhoto.
  ///
  /// In zh, this message translates to:
  /// **'拍照'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In zh, this message translates to:
  /// **'从相册选择'**
  String get chooseFromGallery;

  /// No description provided for @saveFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存失败: {error}'**
  String saveFailed(String error);

  /// No description provided for @secureDecentralizedChat.
  ///
  /// In zh, this message translates to:
  /// **'安全、去中心化的即时通讯'**
  String get secureDecentralizedChat;

  /// No description provided for @endToEndEncryption.
  ///
  /// In zh, this message translates to:
  /// **'端到端加密'**
  String get endToEndEncryption;

  /// No description provided for @messagesOnlyYouCanSee.
  ///
  /// In zh, this message translates to:
  /// **'消息仅你和对方可见'**
  String get messagesOnlyYouCanSee;

  /// No description provided for @decentralized.
  ///
  /// In zh, this message translates to:
  /// **'去中心化'**
  String get decentralized;

  /// No description provided for @basedOnMatrix.
  ///
  /// In zh, this message translates to:
  /// **'基于Matrix开放协议'**
  String get basedOnMatrix;

  /// No description provided for @walletIntegration.
  ///
  /// In zh, this message translates to:
  /// **'钱包集成'**
  String get walletIntegration;

  /// No description provided for @easyCryptoTransfer.
  ///
  /// In zh, this message translates to:
  /// **'轻松进行加密货币转账'**
  String get easyCryptoTransfer;

  /// No description provided for @register.
  ///
  /// In zh, this message translates to:
  /// **'注册'**
  String get register;

  /// No description provided for @agreeTerms.
  ///
  /// In zh, this message translates to:
  /// **'登录即表示同意'**
  String get agreeTerms;

  /// No description provided for @termsOfService.
  ///
  /// In zh, this message translates to:
  /// **'《服务协议》'**
  String get termsOfService;

  /// No description provided for @and.
  ///
  /// In zh, this message translates to:
  /// **'和'**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In zh, this message translates to:
  /// **'《隐私政策》'**
  String get privacyPolicy;

  /// No description provided for @serverAddress.
  ///
  /// In zh, this message translates to:
  /// **'服务器地址'**
  String get serverAddress;

  /// No description provided for @enterServerAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入服务器地址'**
  String get enterServerAddress;

  /// No description provided for @validServerAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的服务器地址'**
  String get validServerAddress;

  /// No description provided for @connectedTo.
  ///
  /// In zh, this message translates to:
  /// **'已连接到 {serverName}'**
  String connectedTo(String serverName);

  /// No description provided for @username.
  ///
  /// In zh, this message translates to:
  /// **'用户名'**
  String get username;

  /// No description provided for @enterUsername.
  ///
  /// In zh, this message translates to:
  /// **'请输入用户名'**
  String get enterUsername;

  /// No description provided for @password.
  ///
  /// In zh, this message translates to:
  /// **'密码'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In zh, this message translates to:
  /// **'请输入密码'**
  String get enterPassword;

  /// No description provided for @registerAccount.
  ///
  /// In zh, this message translates to:
  /// **'注册账号'**
  String get registerAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In zh, this message translates to:
  /// **'忘记密码'**
  String get forgotPassword;

  /// No description provided for @otherLoginMethods.
  ///
  /// In zh, this message translates to:
  /// **'其他登录方式'**
  String get otherLoginMethods;

  /// No description provided for @emailVerification.
  ///
  /// In zh, this message translates to:
  /// **'邮箱验证码'**
  String get emailVerification;

  /// No description provided for @enterServerFirst.
  ///
  /// In zh, this message translates to:
  /// **'请先输入服务器地址'**
  String get enterServerFirst;

  /// No description provided for @passkeyNeedsServer.
  ///
  /// In zh, this message translates to:
  /// **'Passkey 登录需要服务端支持'**
  String get passkeyNeedsServer;

  /// No description provided for @googleLoginSuccess.
  ///
  /// In zh, this message translates to:
  /// **'Google 登录成功: {email}'**
  String googleLoginSuccess(String email);

  /// No description provided for @googleLoginFailed.
  ///
  /// In zh, this message translates to:
  /// **'Google 登录失败: {error}'**
  String googleLoginFailed(String error);

  /// No description provided for @appleLoginSuccess.
  ///
  /// In zh, this message translates to:
  /// **'Apple 登录成功'**
  String get appleLoginSuccess;

  /// No description provided for @appleLoginFailed.
  ///
  /// In zh, this message translates to:
  /// **'Apple 登录失败: {error}'**
  String appleLoginFailed(String error);

  /// No description provided for @createAccount.
  ///
  /// In zh, this message translates to:
  /// **'创建账号'**
  String get createAccount;

  /// No description provided for @joinN42Chat.
  ///
  /// In zh, this message translates to:
  /// **'加入 N42 Chat 开始聊天'**
  String get joinN42Chat;

  /// No description provided for @usernameHint.
  ///
  /// In zh, this message translates to:
  /// **'3-20字符，字母/数字/_'**
  String get usernameHint;

  /// No description provided for @usernameMinLength.
  ///
  /// In zh, this message translates to:
  /// **'用户名至少3个字符'**
  String get usernameMinLength;

  /// No description provided for @usernameMaxLength.
  ///
  /// In zh, this message translates to:
  /// **'用户名最多20个字符'**
  String get usernameMaxLength;

  /// No description provided for @usernameFormat.
  ///
  /// In zh, this message translates to:
  /// **'用户名只能包含字母、数字和下划线'**
  String get usernameFormat;

  /// No description provided for @passwordHint.
  ///
  /// In zh, this message translates to:
  /// **'至少8位'**
  String get passwordHint;

  /// No description provided for @passwordMinLength.
  ///
  /// In zh, this message translates to:
  /// **'密码至少8位'**
  String get passwordMinLength;

  /// No description provided for @confirmPassword.
  ///
  /// In zh, this message translates to:
  /// **'确认密码'**
  String get confirmPassword;

  /// No description provided for @reEnterPassword.
  ///
  /// In zh, this message translates to:
  /// **'请再次输入密码'**
  String get reEnterPassword;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In zh, this message translates to:
  /// **'两次输入的密码不一致'**
  String get passwordsNotMatch;

  /// No description provided for @inviteCode.
  ///
  /// In zh, this message translates to:
  /// **'邀请码（已内置）'**
  String get inviteCode;

  /// No description provided for @filled.
  ///
  /// In zh, this message translates to:
  /// **'已填写'**
  String get filled;

  /// No description provided for @enterInviteCode.
  ///
  /// In zh, this message translates to:
  /// **'请输入邀请码'**
  String get enterInviteCode;

  /// No description provided for @inviteCodeHint.
  ///
  /// In zh, this message translates to:
  /// **'邀请码已内置，通常无需修改'**
  String get inviteCodeHint;

  /// No description provided for @agreeTermsFirst.
  ///
  /// In zh, this message translates to:
  /// **'请先阅读并同意服务协议和隐私政策'**
  String get agreeTermsFirst;

  /// No description provided for @iAgree.
  ///
  /// In zh, this message translates to:
  /// **'我已阅读并同意'**
  String get iAgree;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In zh, this message translates to:
  /// **'已有账号？'**
  String get alreadyHaveAccount;

  /// No description provided for @loginNow.
  ///
  /// In zh, this message translates to:
  /// **'立即登录'**
  String get loginNow;

  /// No description provided for @whoCanSee.
  ///
  /// In zh, this message translates to:
  /// **'谁可以查看'**
  String get whoCanSee;

  /// No description provided for @avatar.
  ///
  /// In zh, this message translates to:
  /// **'头像'**
  String get avatar;

  /// No description provided for @status.
  ///
  /// In zh, this message translates to:
  /// **'状态'**
  String get status;

  /// No description provided for @lastSeen.
  ///
  /// In zh, this message translates to:
  /// **'最后上线时间'**
  String get lastSeen;

  /// No description provided for @messageSettings.
  ///
  /// In zh, this message translates to:
  /// **'消息'**
  String get messageSettings;

  /// No description provided for @allowStrangerMessage.
  ///
  /// In zh, this message translates to:
  /// **'允许陌生人私聊'**
  String get allowStrangerMessage;

  /// No description provided for @receiveNonContact.
  ///
  /// In zh, this message translates to:
  /// **'接收非联系人的消息'**
  String get receiveNonContact;

  /// No description provided for @readReceipts.
  ///
  /// In zh, this message translates to:
  /// **'已读回执'**
  String get readReceipts;

  /// No description provided for @letOthersKnowRead.
  ///
  /// In zh, this message translates to:
  /// **'让对方知道你已阅读消息'**
  String get letOthersKnowRead;

  /// No description provided for @typingStatus.
  ///
  /// In zh, this message translates to:
  /// **'输入状态'**
  String get typingStatus;

  /// No description provided for @letOthersKnowTyping.
  ///
  /// In zh, this message translates to:
  /// **'让对方知道你正在输入'**
  String get letOthersKnowTyping;

  /// No description provided for @everyone.
  ///
  /// In zh, this message translates to:
  /// **'所有人'**
  String get everyone;

  /// No description provided for @contactsOnly.
  ///
  /// In zh, this message translates to:
  /// **'仅联系人'**
  String get contactsOnly;

  /// No description provided for @nobody.
  ///
  /// In zh, this message translates to:
  /// **'无人'**
  String get nobody;

  /// No description provided for @whoCanSeeItem.
  ///
  /// In zh, this message translates to:
  /// **'谁可以查看{title}'**
  String whoCanSeeItem(String title);

  /// No description provided for @version.
  ///
  /// In zh, this message translates to:
  /// **'版本 {version}'**
  String version(String version);

  /// No description provided for @checkUpdate.
  ///
  /// In zh, this message translates to:
  /// **'检查更新'**
  String get checkUpdate;

  /// No description provided for @openSourceLicenses.
  ///
  /// In zh, this message translates to:
  /// **'开源许可'**
  String get openSourceLicenses;

  /// No description provided for @feedback.
  ///
  /// In zh, this message translates to:
  /// **'反馈与建议'**
  String get feedback;

  /// No description provided for @builtOnMatrix.
  ///
  /// In zh, this message translates to:
  /// **'基于 Matrix 协议构建'**
  String get builtOnMatrix;

  /// No description provided for @loading.
  ///
  /// In zh, this message translates to:
  /// **'加载中...'**
  String get loading;

  /// No description provided for @noConversations.
  ///
  /// In zh, this message translates to:
  /// **'暂无会话'**
  String get noConversations;

  /// No description provided for @tapToChat.
  ///
  /// In zh, this message translates to:
  /// **'点击右上角开始聊天'**
  String get tapToChat;

  /// No description provided for @startGroup.
  ///
  /// In zh, this message translates to:
  /// **'发起群聊'**
  String get startGroup;

  /// No description provided for @scan.
  ///
  /// In zh, this message translates to:
  /// **'扫一扫'**
  String get scan;

  /// No description provided for @payment.
  ///
  /// In zh, this message translates to:
  /// **'收付款'**
  String get payment;

  /// No description provided for @featureComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'{feature} 功能即将推出'**
  String featureComingSoon(String feature);

  /// No description provided for @markAsRead.
  ///
  /// In zh, this message translates to:
  /// **'标记已读'**
  String get markAsRead;

  /// No description provided for @unmute.
  ///
  /// In zh, this message translates to:
  /// **'取消静音'**
  String get unmute;

  /// No description provided for @mute.
  ///
  /// In zh, this message translates to:
  /// **'消息免打扰'**
  String get mute;

  /// No description provided for @unpin.
  ///
  /// In zh, this message translates to:
  /// **'取消置顶'**
  String get unpin;

  /// No description provided for @pin.
  ///
  /// In zh, this message translates to:
  /// **'置顶'**
  String get pin;

  /// No description provided for @deleteConversation.
  ///
  /// In zh, this message translates to:
  /// **'删除会话'**
  String get deleteConversation;

  /// No description provided for @deleteConversationConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除与 {name} 的会话吗？'**
  String deleteConversationConfirm(String name);

  /// No description provided for @noContacts.
  ///
  /// In zh, this message translates to:
  /// **'暂无联系人'**
  String get noContacts;

  /// No description provided for @addFriendsToChat.
  ///
  /// In zh, this message translates to:
  /// **'添加好友开始聊天'**
  String get addFriendsToChat;

  /// No description provided for @contactNotFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到联系人'**
  String get contactNotFound;

  /// No description provided for @tryOtherKeywords.
  ///
  /// In zh, this message translates to:
  /// **'尝试搜索其他关键词或全局搜索'**
  String get tryOtherKeywords;

  /// No description provided for @searchResults.
  ///
  /// In zh, this message translates to:
  /// **'搜索结果'**
  String get searchResults;

  /// No description provided for @newFriends.
  ///
  /// In zh, this message translates to:
  /// **'新的朋友'**
  String get newFriends;

  /// No description provided for @chatOnlyFriends.
  ///
  /// In zh, this message translates to:
  /// **'仅聊天的朋友'**
  String get chatOnlyFriends;

  /// No description provided for @officialAccounts.
  ///
  /// In zh, this message translates to:
  /// **'公众号'**
  String get officialAccounts;

  /// No description provided for @serviceAccounts.
  ///
  /// In zh, this message translates to:
  /// **'服务号'**
  String get serviceAccounts;

  /// No description provided for @enterpriseContacts.
  ///
  /// In zh, this message translates to:
  /// **'企业联系人'**
  String get enterpriseContacts;

  /// No description provided for @contactsCount.
  ///
  /// In zh, this message translates to:
  /// **'{count}位联系人'**
  String contactsCount(int count);

  /// No description provided for @recommendToFriend.
  ///
  /// In zh, this message translates to:
  /// **'推荐给朋友'**
  String get recommendToFriend;

  /// No description provided for @setRemark.
  ///
  /// In zh, this message translates to:
  /// **'设置备注'**
  String get setRemark;

  /// No description provided for @addToHome.
  ///
  /// In zh, this message translates to:
  /// **'添加到桌面'**
  String get addToHome;

  /// No description provided for @sendingCard.
  ///
  /// In zh, this message translates to:
  /// **'正在发送名片...'**
  String get sendingCard;

  /// No description provided for @contactCard.
  ///
  /// In zh, this message translates to:
  /// **'[名片]'**
  String get contactCard;

  /// No description provided for @fileLabel.
  ///
  /// In zh, this message translates to:
  /// **'文件'**
  String get fileLabel;

  /// No description provided for @locationLabel.
  ///
  /// In zh, this message translates to:
  /// **'位置'**
  String get locationLabel;

  /// No description provided for @cardSent.
  ///
  /// In zh, this message translates to:
  /// **'已将 {contact} 的名片推荐给 {friend}'**
  String cardSent(String contact, String friend);

  /// No description provided for @recommendFailed.
  ///
  /// In zh, this message translates to:
  /// **'推荐失败: {error}'**
  String recommendFailed(String error);

  /// No description provided for @enterRemark.
  ///
  /// In zh, this message translates to:
  /// **'请输入备注名'**
  String get enterRemark;

  /// No description provided for @remarkSet.
  ///
  /// In zh, this message translates to:
  /// **'已设置备注为: {remark}'**
  String remarkSet(String remark);

  /// No description provided for @openingChat.
  ///
  /// In zh, this message translates to:
  /// **'正在打开聊天...'**
  String get openingChat;

  /// No description provided for @openChatFailed.
  ///
  /// In zh, this message translates to:
  /// **'打开聊天失败: {error}'**
  String openChatFailed(String error);

  /// No description provided for @addContact.
  ///
  /// In zh, this message translates to:
  /// **'添加联系人'**
  String get addContact;

  /// No description provided for @enterUserId.
  ///
  /// In zh, this message translates to:
  /// **'输入用户ID'**
  String get enterUserId;

  /// No description provided for @noFriendRequests.
  ///
  /// In zh, this message translates to:
  /// **'暂无好友请求'**
  String get noFriendRequests;

  /// No description provided for @accept.
  ///
  /// In zh, this message translates to:
  /// **'接受'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In zh, this message translates to:
  /// **'拒绝'**
  String get reject;

  /// No description provided for @acceptedRequest.
  ///
  /// In zh, this message translates to:
  /// **'已接受 {name} 的好友请求'**
  String acceptedRequest(String name);

  /// No description provided for @rejectedRequest.
  ///
  /// In zh, this message translates to:
  /// **'已拒绝 {name} 的好友请求'**
  String rejectedRequest(String name);

  /// No description provided for @noGroups.
  ///
  /// In zh, this message translates to:
  /// **'暂无群聊'**
  String get noGroups;

  /// No description provided for @creatingGroup.
  ///
  /// In zh, this message translates to:
  /// **'创建群聊功能开发中...'**
  String get creatingGroup;

  /// No description provided for @selectFriendToRecommend.
  ///
  /// In zh, this message translates to:
  /// **'选择要推荐给的朋友'**
  String get selectFriendToRecommend;

  /// No description provided for @searchContacts.
  ///
  /// In zh, this message translates to:
  /// **'搜索联系人'**
  String get searchContacts;

  /// No description provided for @noContactsFound.
  ///
  /// In zh, this message translates to:
  /// **'没有找到联系人'**
  String get noContactsFound;

  /// No description provided for @yesterday.
  ///
  /// In zh, this message translates to:
  /// **'昨天'**
  String get yesterday;

  /// No description provided for @monday.
  ///
  /// In zh, this message translates to:
  /// **'周一'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In zh, this message translates to:
  /// **'周二'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In zh, this message translates to:
  /// **'周三'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In zh, this message translates to:
  /// **'周四'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In zh, this message translates to:
  /// **'周五'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In zh, this message translates to:
  /// **'周六'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In zh, this message translates to:
  /// **'周日'**
  String get sunday;

  /// No description provided for @justNow.
  ///
  /// In zh, this message translates to:
  /// **'刚刚'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In zh, this message translates to:
  /// **'{count}分钟前'**
  String minutesAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In zh, this message translates to:
  /// **'{count}小时前'**
  String hoursAgo(int count);

  /// No description provided for @daysAgo.
  ///
  /// In zh, this message translates to:
  /// **'{count}天前'**
  String daysAgo(int count);

  /// No description provided for @online.
  ///
  /// In zh, this message translates to:
  /// **'在线'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In zh, this message translates to:
  /// **'离线'**
  String get offline;

  /// No description provided for @minutesAgoOnline.
  ///
  /// In zh, this message translates to:
  /// **'{count}分钟前在线'**
  String minutesAgoOnline(int count);

  /// No description provided for @hoursAgoOnline.
  ///
  /// In zh, this message translates to:
  /// **'{count}小时前在线'**
  String hoursAgoOnline(int count);

  /// No description provided for @daysAgoOnline.
  ///
  /// In zh, this message translates to:
  /// **'{count}天前在线'**
  String daysAgoOnline(int count);

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

  /// No description provided for @searchHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索'**
  String get searchHint;

  /// No description provided for @enterKeyword.
  ///
  /// In zh, this message translates to:
  /// **'输入关键词开始搜索'**
  String get enterKeyword;

  /// No description provided for @searchHistory.
  ///
  /// In zh, this message translates to:
  /// **'搜索历史'**
  String get searchHistory;

  /// No description provided for @clear.
  ///
  /// In zh, this message translates to:
  /// **'清除'**
  String get clear;

  /// No description provided for @noResultsFor.
  ///
  /// In zh, this message translates to:
  /// **'没有找到 {query} 相关的结果'**
  String noResultsFor(String query);

  /// No description provided for @all.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get all;

  /// No description provided for @groups.
  ///
  /// In zh, this message translates to:
  /// **'群聊'**
  String get groups;

  /// No description provided for @noResults.
  ///
  /// In zh, this message translates to:
  /// **'无结果'**
  String get noResults;

  /// No description provided for @groupInfo.
  ///
  /// In zh, this message translates to:
  /// **'群聊资料'**
  String get groupInfo;

  /// No description provided for @groupMembers.
  ///
  /// In zh, this message translates to:
  /// **'群成员 ({count})'**
  String groupMembers(int count);

  /// No description provided for @groupMembersTitle.
  ///
  /// In zh, this message translates to:
  /// **'群成员'**
  String get groupMembersTitle;

  /// No description provided for @viewAll.
  ///
  /// In zh, this message translates to:
  /// **'查看全部'**
  String get viewAll;

  /// No description provided for @owner.
  ///
  /// In zh, this message translates to:
  /// **'群主'**
  String get owner;

  /// No description provided for @admin.
  ///
  /// In zh, this message translates to:
  /// **'管理'**
  String get admin;

  /// No description provided for @invite.
  ///
  /// In zh, this message translates to:
  /// **'邀请'**
  String get invite;

  /// No description provided for @groupAnnouncement.
  ///
  /// In zh, this message translates to:
  /// **'群公告'**
  String get groupAnnouncement;

  /// No description provided for @notSet.
  ///
  /// In zh, this message translates to:
  /// **'未设置'**
  String get notSet;

  /// No description provided for @groupDescription.
  ///
  /// In zh, this message translates to:
  /// **'群简介'**
  String get groupDescription;

  /// No description provided for @publicGroup.
  ///
  /// In zh, this message translates to:
  /// **'公开群聊'**
  String get publicGroup;

  /// No description provided for @allowSearchJoin.
  ///
  /// In zh, this message translates to:
  /// **'允许其他人搜索并加入'**
  String get allowSearchJoin;

  /// No description provided for @clearChatHistory.
  ///
  /// In zh, this message translates to:
  /// **'清空聊天记录'**
  String get clearChatHistory;

  /// No description provided for @dissolveGroup.
  ///
  /// In zh, this message translates to:
  /// **'解散群聊'**
  String get dissolveGroup;

  /// No description provided for @leaveGroup.
  ///
  /// In zh, this message translates to:
  /// **'退出群聊'**
  String get leaveGroup;

  /// No description provided for @changeGroupName.
  ///
  /// In zh, this message translates to:
  /// **'修改群名称'**
  String get changeGroupName;

  /// No description provided for @enterGroupName.
  ///
  /// In zh, this message translates to:
  /// **'请输入群名称'**
  String get enterGroupName;

  /// No description provided for @confirm.
  ///
  /// In zh, this message translates to:
  /// **'确定'**
  String get confirm;

  /// No description provided for @changeGroupDescription.
  ///
  /// In zh, this message translates to:
  /// **'修改群简介'**
  String get changeGroupDescription;

  /// No description provided for @enterGroupDescription.
  ///
  /// In zh, this message translates to:
  /// **'请输入群简介'**
  String get enterGroupDescription;

  /// No description provided for @editAnnouncement.
  ///
  /// In zh, this message translates to:
  /// **'编辑群公告'**
  String get editAnnouncement;

  /// No description provided for @enterAnnouncement.
  ///
  /// In zh, this message translates to:
  /// **'请输入群公告'**
  String get enterAnnouncement;

  /// No description provided for @publish.
  ///
  /// In zh, this message translates to:
  /// **'发布'**
  String get publish;

  /// No description provided for @clearHistoryConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要清空聊天记录吗？此操作不可恢复。'**
  String get clearHistoryConfirm;

  /// No description provided for @clearAction.
  ///
  /// In zh, this message translates to:
  /// **'清空'**
  String get clearAction;

  /// No description provided for @chatHistoryCleared.
  ///
  /// In zh, this message translates to:
  /// **'聊天记录已清空'**
  String get chatHistoryCleared;

  /// No description provided for @leaveGroupConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要退出 {name} 吗？'**
  String leaveGroupConfirm(String name);

  /// No description provided for @dissolveGroupConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要解散 {name} 吗？此操作不可恢复。'**
  String dissolveGroupConfirm(String name);

  /// No description provided for @dissolve.
  ///
  /// In zh, this message translates to:
  /// **'解散'**
  String get dissolve;

  /// No description provided for @groupQrCode.
  ///
  /// In zh, this message translates to:
  /// **'群二维码'**
  String get groupQrCode;

  /// No description provided for @searchChatHistory.
  ///
  /// In zh, this message translates to:
  /// **'查找聊天记录'**
  String get searchChatHistory;

  /// No description provided for @groupIdCopied.
  ///
  /// In zh, this message translates to:
  /// **'群ID已复制'**
  String get groupIdCopied;

  /// No description provided for @tapCopyGroupId.
  ///
  /// In zh, this message translates to:
  /// **'{count}人 · 点击复制群ID'**
  String tapCopyGroupId(int count);

  /// No description provided for @receiverAddress.
  ///
  /// In zh, this message translates to:
  /// **'收款地址'**
  String get receiverAddress;

  /// No description provided for @enterOrPasteAddress.
  ///
  /// In zh, this message translates to:
  /// **'输入或粘贴钱包地址'**
  String get enterOrPasteAddress;

  /// No description provided for @selectToken.
  ///
  /// In zh, this message translates to:
  /// **'选择代币'**
  String get selectToken;

  /// No description provided for @transferAmount.
  ///
  /// In zh, this message translates to:
  /// **'转账金额'**
  String get transferAmount;

  /// No description provided for @available.
  ///
  /// In zh, this message translates to:
  /// **'可用'**
  String get available;

  /// No description provided for @allAmount.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get allAmount;

  /// No description provided for @memoOptional.
  ///
  /// In zh, this message translates to:
  /// **'备注（可选）'**
  String get memoOptional;

  /// No description provided for @addMemo.
  ///
  /// In zh, this message translates to:
  /// **'添加备注信息'**
  String get addMemo;

  /// No description provided for @confirmTransfer.
  ///
  /// In zh, this message translates to:
  /// **'确认转账'**
  String get confirmTransfer;

  /// No description provided for @invalidAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的收款地址'**
  String get invalidAddress;

  /// No description provided for @invalidAmount.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的转账金额'**
  String get invalidAmount;

  /// No description provided for @selectTokenPlease.
  ///
  /// In zh, this message translates to:
  /// **'请选择代币'**
  String get selectTokenPlease;

  /// No description provided for @addressVerified.
  ///
  /// In zh, this message translates to:
  /// **'地址已验证'**
  String get addressVerified;

  /// No description provided for @availableBalance.
  ///
  /// In zh, this message translates to:
  /// **'可用余额: {balance} {symbol}'**
  String availableBalance(String balance, String symbol);

  /// No description provided for @scanningInDevelopment.
  ///
  /// In zh, this message translates to:
  /// **'扫描功能开发中...'**
  String get scanningInDevelopment;

  /// No description provided for @enterAmount.
  ///
  /// In zh, this message translates to:
  /// **'请输入金额'**
  String get enterAmount;

  /// No description provided for @redPacketCountMin.
  ///
  /// In zh, this message translates to:
  /// **'红包个数至少为1'**
  String get redPacketCountMin;

  /// No description provided for @viewRedPacketDetails.
  ///
  /// In zh, this message translates to:
  /// **'查看红包详情'**
  String get viewRedPacketDetails;

  /// No description provided for @enterTransferAmount.
  ///
  /// In zh, this message translates to:
  /// **'请输入转账金额'**
  String get enterTransferAmount;

  /// No description provided for @transferTo.
  ///
  /// In zh, this message translates to:
  /// **'转账给'**
  String get transferTo;

  /// No description provided for @selectCurrency.
  ///
  /// In zh, this message translates to:
  /// **'选择币种'**
  String get selectCurrency;

  /// No description provided for @receiveTransfer.
  ///
  /// In zh, this message translates to:
  /// **'收到转账'**
  String get receiveTransfer;

  /// No description provided for @fromSender.
  ///
  /// In zh, this message translates to:
  /// **'来自 {name}'**
  String fromSender(String name, Object senderName);

  /// No description provided for @confirmReceive.
  ///
  /// In zh, this message translates to:
  /// **'确认收款'**
  String get confirmReceive;

  /// No description provided for @groupProfile.
  ///
  /// In zh, this message translates to:
  /// **'群资料'**
  String get groupProfile;

  /// No description provided for @viewProfile.
  ///
  /// In zh, this message translates to:
  /// **'查看资料'**
  String get viewProfile;

  /// No description provided for @removeMember.
  ///
  /// In zh, this message translates to:
  /// **'移出群聊'**
  String get removeMember;

  /// No description provided for @removeMemberConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要将 {name} 移出群聊吗？'**
  String removeMemberConfirm(String name);

  /// No description provided for @remove.
  ///
  /// In zh, this message translates to:
  /// **'移出'**
  String get remove;

  /// No description provided for @clearStatus.
  ///
  /// In zh, this message translates to:
  /// **'清除状态'**
  String get clearStatus;

  /// No description provided for @clearStatusConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要清除当前状态吗？'**
  String get clearStatusConfirm;

  /// No description provided for @statusCleared.
  ///
  /// In zh, this message translates to:
  /// **'状态已清除'**
  String get statusCleared;

  /// No description provided for @statusSet.
  ///
  /// In zh, this message translates to:
  /// **'状态已设置为：{result}'**
  String statusSet(String result);

  /// No description provided for @userNotExist.
  ///
  /// In zh, this message translates to:
  /// **'用户不存在'**
  String get userNotExist;

  /// No description provided for @userIdCopied.
  ///
  /// In zh, this message translates to:
  /// **'用户ID已复制'**
  String get userIdCopied;

  /// No description provided for @voiceCallInDevelopment.
  ///
  /// In zh, this message translates to:
  /// **'语音通话功能开发中...'**
  String get voiceCallInDevelopment;

  /// No description provided for @report.
  ///
  /// In zh, this message translates to:
  /// **'举报'**
  String get report;

  /// No description provided for @reportInDevelopment.
  ///
  /// In zh, this message translates to:
  /// **'举报功能开发中...'**
  String get reportInDevelopment;

  /// No description provided for @shareCard.
  ///
  /// In zh, this message translates to:
  /// **'分享名片'**
  String get shareCard;

  /// No description provided for @shareInDevelopment.
  ///
  /// In zh, this message translates to:
  /// **'分享功能开发中...'**
  String get shareInDevelopment;

  /// No description provided for @qrCode.
  ///
  /// In zh, this message translates to:
  /// **'二维码'**
  String get qrCode;

  /// No description provided for @qrCodeInDevelopment.
  ///
  /// In zh, this message translates to:
  /// **'二维码功能开发中...'**
  String get qrCodeInDevelopment;

  /// No description provided for @avatarUpdated.
  ///
  /// In zh, this message translates to:
  /// **'头像更新成功'**
  String get avatarUpdated;

  /// No description provided for @selectImageFailed.
  ///
  /// In zh, this message translates to:
  /// **'选择图片失败: {error}'**
  String selectImageFailed(String error);

  /// No description provided for @changeName.
  ///
  /// In zh, this message translates to:
  /// **'修改名字'**
  String get changeName;

  /// No description provided for @male.
  ///
  /// In zh, this message translates to:
  /// **'男'**
  String get male;

  /// No description provided for @female.
  ///
  /// In zh, this message translates to:
  /// **'女'**
  String get female;

  /// No description provided for @genderSet.
  ///
  /// In zh, this message translates to:
  /// **'性别已设置为: {gender}'**
  String genderSet(String gender);

  /// No description provided for @regionSet.
  ///
  /// In zh, this message translates to:
  /// **'地区已设置为: {region}'**
  String regionSet(String region);

  /// No description provided for @setPatText.
  ///
  /// In zh, this message translates to:
  /// **'设置拍一拍'**
  String get setPatText;

  /// No description provided for @changeSignature.
  ///
  /// In zh, this message translates to:
  /// **'修改签名'**
  String get changeSignature;

  /// No description provided for @ringtoneSet.
  ///
  /// In zh, this message translates to:
  /// **'来电铃声已设置为: {result}'**
  String ringtoneSet(String result);

  /// No description provided for @featureInDev.
  ///
  /// In zh, this message translates to:
  /// **'{feature}功能开发中...'**
  String featureInDev(String feature);

  /// No description provided for @saveAddressFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存地址失败: {error}'**
  String saveAddressFailed(String error);

  /// No description provided for @myAddress.
  ///
  /// In zh, this message translates to:
  /// **'我的地址'**
  String get myAddress;

  /// No description provided for @addNew.
  ///
  /// In zh, this message translates to:
  /// **'新增'**
  String get addNew;

  /// No description provided for @addAddress.
  ///
  /// In zh, this message translates to:
  /// **'添加地址'**
  String get addAddress;

  /// No description provided for @addressAdded.
  ///
  /// In zh, this message translates to:
  /// **'地址添加成功'**
  String get addressAdded;

  /// No description provided for @addressUpdated.
  ///
  /// In zh, this message translates to:
  /// **'地址更新成功'**
  String get addressUpdated;

  /// No description provided for @deleteAddress.
  ///
  /// In zh, this message translates to:
  /// **'删除地址'**
  String get deleteAddress;

  /// No description provided for @deleteAddressConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这个地址吗？'**
  String get deleteAddressConfirm;

  /// No description provided for @addressDeleted.
  ///
  /// In zh, this message translates to:
  /// **'地址已删除'**
  String get addressDeleted;

  /// No description provided for @setDefaultAddress.
  ///
  /// In zh, this message translates to:
  /// **'设为默认地址'**
  String get setDefaultAddress;

  /// No description provided for @fillCompleteInfo.
  ///
  /// In zh, this message translates to:
  /// **'请填写完整信息'**
  String get fillCompleteInfo;

  /// No description provided for @saveInvoiceFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存发票抬头失败: {error}'**
  String saveInvoiceFailed(String error);

  /// No description provided for @myInvoices.
  ///
  /// In zh, this message translates to:
  /// **'我的发票抬头'**
  String get myInvoices;

  /// No description provided for @addInvoice.
  ///
  /// In zh, this message translates to:
  /// **'添加发票抬头'**
  String get addInvoice;

  /// No description provided for @invoiceAdded.
  ///
  /// In zh, this message translates to:
  /// **'发票抬头添加成功'**
  String get invoiceAdded;

  /// No description provided for @invoiceUpdated.
  ///
  /// In zh, this message translates to:
  /// **'发票抬头更新成功'**
  String get invoiceUpdated;

  /// No description provided for @deleteInvoice.
  ///
  /// In zh, this message translates to:
  /// **'删除发票抬头'**
  String get deleteInvoice;

  /// No description provided for @deleteInvoiceConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这个发票抬头吗？'**
  String get deleteInvoiceConfirm;

  /// No description provided for @invoiceDeleted.
  ///
  /// In zh, this message translates to:
  /// **'发票抬头已删除'**
  String get invoiceDeleted;

  /// No description provided for @invoiceType.
  ///
  /// In zh, this message translates to:
  /// **'抬头类型'**
  String get invoiceType;

  /// No description provided for @personal.
  ///
  /// In zh, this message translates to:
  /// **'个人'**
  String get personal;

  /// No description provided for @enterprise.
  ///
  /// In zh, this message translates to:
  /// **'企业'**
  String get enterprise;

  /// No description provided for @setDefaultInvoice.
  ///
  /// In zh, this message translates to:
  /// **'设为默认抬头'**
  String get setDefaultInvoice;

  /// No description provided for @enterTaxId.
  ///
  /// In zh, this message translates to:
  /// **'请输入纳税人识别号'**
  String get enterTaxId;

  /// No description provided for @vibrateMode.
  ///
  /// In zh, this message translates to:
  /// **'振动模式'**
  String get vibrateMode;

  /// No description provided for @silentMode.
  ///
  /// In zh, this message translates to:
  /// **'静音模式'**
  String get silentMode;

  /// No description provided for @playing.
  ///
  /// In zh, this message translates to:
  /// **'正在播放: {ringtoneName}'**
  String playing(String ringtoneName);

  /// No description provided for @playFailed.
  ///
  /// In zh, this message translates to:
  /// **'播放失败: {ringtoneName}'**
  String playFailed(String ringtoneName);

  /// No description provided for @enterGroupNamePlease.
  ///
  /// In zh, this message translates to:
  /// **'请输入群名称'**
  String get enterGroupNamePlease;

  /// No description provided for @selectAtLeastOne.
  ///
  /// In zh, this message translates to:
  /// **'请至少选择一位成员'**
  String get selectAtLeastOne;

  /// No description provided for @fillStatus.
  ///
  /// In zh, this message translates to:
  /// **'填写状态'**
  String get fillStatus;

  /// No description provided for @fileNotExist.
  ///
  /// In zh, this message translates to:
  /// **'文件不存在'**
  String get fileNotExist;

  /// No description provided for @sendFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送失败: {error}'**
  String sendFailed(String error);

  /// No description provided for @cannotOpenBrowser.
  ///
  /// In zh, this message translates to:
  /// **'无法打开浏览器'**
  String get cannotOpenBrowser;

  /// No description provided for @selectFileFailed.
  ///
  /// In zh, this message translates to:
  /// **'选择文件失败: {error}'**
  String selectFileFailed(String error);

  /// No description provided for @enterMusicLink.
  ///
  /// In zh, this message translates to:
  /// **'请输入音乐链接'**
  String get enterMusicLink;

  /// No description provided for @enterValidLink.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的网络链接'**
  String get enterValidLink;

  /// No description provided for @enterPollQuestion.
  ///
  /// In zh, this message translates to:
  /// **'请输入投票问题'**
  String get enterPollQuestion;

  /// No description provided for @minTwoOptions.
  ///
  /// In zh, this message translates to:
  /// **'至少需要2个选项'**
  String get minTwoOptions;

  /// No description provided for @crossDeviceEnabled.
  ///
  /// In zh, this message translates to:
  /// **'跨设备签名已启用'**
  String get crossDeviceEnabled;

  /// No description provided for @crossDeviceSet.
  ///
  /// In zh, this message translates to:
  /// **'跨设备签名设置成功'**
  String get crossDeviceSet;

  /// No description provided for @setupFailed.
  ///
  /// In zh, this message translates to:
  /// **'设置失败: {error}'**
  String setupFailed(String error);

  /// No description provided for @receiveAmount.
  ///
  /// In zh, this message translates to:
  /// **'收款金额'**
  String get receiveAmount;

  /// No description provided for @enterValidAmount.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的转账金额'**
  String get enterValidAmount;

  /// No description provided for @addressCopied.
  ///
  /// In zh, this message translates to:
  /// **'地址已复制'**
  String get addressCopied;

  /// No description provided for @openItem.
  ///
  /// In zh, this message translates to:
  /// **'打开: {content}'**
  String openItem(String content);

  /// No description provided for @newNoteComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'新建笔记功能即将推出'**
  String get newNoteComingSoon;

  /// No description provided for @addLinkComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'添加链接功能即将推出'**
  String get addLinkComingSoon;

  /// No description provided for @deleted.
  ///
  /// In zh, this message translates to:
  /// **'已删除'**
  String get deleted;

  /// No description provided for @shareComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'分享功能即将推出'**
  String get shareComingSoon;

  /// No description provided for @saveComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'保存功能即将推出'**
  String get saveComingSoon;

  /// No description provided for @moreStylesComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'更多样式即将推出'**
  String get moreStylesComingSoon;

  /// No description provided for @wallet.
  ///
  /// In zh, this message translates to:
  /// **'钱包'**
  String get wallet;

  /// No description provided for @walletArea.
  ///
  /// In zh, this message translates to:
  /// **'钱包功能区域'**
  String get walletArea;

  /// No description provided for @recording.
  ///
  /// In zh, this message translates to:
  /// **'录像'**
  String get recording;

  /// No description provided for @invalidVideoUrl.
  ///
  /// In zh, this message translates to:
  /// **'无效的视频链接'**
  String get invalidVideoUrl;

  /// No description provided for @downloadFile.
  ///
  /// In zh, this message translates to:
  /// **'下载文件'**
  String get downloadFile;

  /// No description provided for @clearChatHistoryTitle.
  ///
  /// In zh, this message translates to:
  /// **'清空聊天记录'**
  String get clearChatHistoryTitle;

  /// No description provided for @cannotUndo.
  ///
  /// In zh, this message translates to:
  /// **'此操作不可恢复'**
  String get cannotUndo;

  /// No description provided for @videoCall.
  ///
  /// In zh, this message translates to:
  /// **'视频通话'**
  String get videoCall;

  /// No description provided for @voiceCall.
  ///
  /// In zh, this message translates to:
  /// **'语音通话'**
  String get voiceCall;

  /// No description provided for @leaveMeeting.
  ///
  /// In zh, this message translates to:
  /// **'离开会议'**
  String get leaveMeeting;

  /// No description provided for @chatDetails.
  ///
  /// In zh, this message translates to:
  /// **'聊天详情'**
  String get chatDetails;

  /// No description provided for @viewAllGroupMembers.
  ///
  /// In zh, this message translates to:
  /// **'查看全部群成员'**
  String get viewAllGroupMembers;

  /// No description provided for @groupName.
  ///
  /// In zh, this message translates to:
  /// **'群聊名称'**
  String get groupName;

  /// No description provided for @groupNameUpdated.
  ///
  /// In zh, this message translates to:
  /// **'群名称已更新'**
  String get groupNameUpdated;

  /// No description provided for @updateFailed.
  ///
  /// In zh, this message translates to:
  /// **'更新失败'**
  String get updateFailed;

  /// No description provided for @noPermissionToModify.
  ///
  /// In zh, this message translates to:
  /// **'您没有修改权限'**
  String get noPermissionToModify;

  /// No description provided for @groupManagement.
  ///
  /// In zh, this message translates to:
  /// **'群管理'**
  String get groupManagement;

  /// No description provided for @myNicknameInGroup.
  ///
  /// In zh, this message translates to:
  /// **'我在本群的昵称'**
  String get myNicknameInGroup;

  /// No description provided for @pinChat.
  ///
  /// In zh, this message translates to:
  /// **'置顶聊天'**
  String get pinChat;

  /// No description provided for @strongReminder.
  ///
  /// In zh, this message translates to:
  /// **'强提醒'**
  String get strongReminder;

  /// No description provided for @setChatBackground.
  ///
  /// In zh, this message translates to:
  /// **'设置当前聊天背景'**
  String get setChatBackground;

  /// No description provided for @unknownFile.
  ///
  /// In zh, this message translates to:
  /// **'未知文件'**
  String get unknownFile;

  /// No description provided for @download.
  ///
  /// In zh, this message translates to:
  /// **'下载'**
  String get download;

  /// No description provided for @invalidLocation.
  ///
  /// In zh, this message translates to:
  /// **'无效的位置'**
  String get invalidLocation;

  /// No description provided for @address.
  ///
  /// In zh, this message translates to:
  /// **'地址'**
  String get address;

  /// No description provided for @latitude.
  ///
  /// In zh, this message translates to:
  /// **'纬度'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In zh, this message translates to:
  /// **'经度'**
  String get longitude;

  /// No description provided for @close.
  ///
  /// In zh, this message translates to:
  /// **'关闭'**
  String get close;

  /// No description provided for @tapToCancel.
  ///
  /// In zh, this message translates to:
  /// **'点击取消'**
  String get tapToCancel;

  /// No description provided for @captureFailed.
  ///
  /// In zh, this message translates to:
  /// **'拍摄失败: {error}'**
  String captureFailed(Object error);

  /// No description provided for @processingVideo.
  ///
  /// In zh, this message translates to:
  /// **'正在处理视频...'**
  String get processingVideo;

  /// No description provided for @videoFileNotExist.
  ///
  /// In zh, this message translates to:
  /// **'视频文件不存在'**
  String get videoFileNotExist;

  /// No description provided for @videoDataEmpty.
  ///
  /// In zh, this message translates to:
  /// **'视频数据为空'**
  String get videoDataEmpty;

  /// No description provided for @videoTooLarge.
  ///
  /// In zh, this message translates to:
  /// **'视频大小不能超过 100MB'**
  String get videoTooLarge;

  /// No description provided for @sendingVideo.
  ///
  /// In zh, this message translates to:
  /// **'视频发送中...'**
  String get sendingVideo;

  /// No description provided for @sendVideoFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送视频失败: {error}'**
  String sendVideoFailed(Object error);

  /// No description provided for @imageFileNotExist.
  ///
  /// In zh, this message translates to:
  /// **'图片文件不存在'**
  String get imageFileNotExist;

  /// No description provided for @imageDataEmpty.
  ///
  /// In zh, this message translates to:
  /// **'图片数据为空'**
  String get imageDataEmpty;

  /// No description provided for @sendingImage.
  ///
  /// In zh, this message translates to:
  /// **'图片发送中...'**
  String get sendingImage;

  /// No description provided for @sendImageFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送图片失败: {error}'**
  String sendImageFailed(Object error);

  /// No description provided for @sendLocation.
  ///
  /// In zh, this message translates to:
  /// **'发送位置'**
  String get sendLocation;

  /// No description provided for @selectLocationAndSend.
  ///
  /// In zh, this message translates to:
  /// **'选择地点并发送给对方'**
  String get selectLocationAndSend;

  /// No description provided for @shareRealTimeLocation.
  ///
  /// In zh, this message translates to:
  /// **'共享实时位置'**
  String get shareRealTimeLocation;

  /// No description provided for @shareLocationForOneHour.
  ///
  /// In zh, this message translates to:
  /// **'与好友共享1小时实时位置'**
  String get shareLocationForOneHour;

  /// No description provided for @locationSent.
  ///
  /// In zh, this message translates to:
  /// **'位置已发送'**
  String get locationSent;

  /// No description provided for @selectMessages.
  ///
  /// In zh, this message translates to:
  /// **'选择消息'**
  String get selectMessages;

  /// No description provided for @selectedCount.
  ///
  /// In zh, this message translates to:
  /// **'已选择 {count}'**
  String selectedCount(int count);

  /// No description provided for @selectAll.
  ///
  /// In zh, this message translates to:
  /// **'全选'**
  String get selectAll;

  /// No description provided for @groupChatCount.
  ///
  /// In zh, this message translates to:
  /// **'群聊({count})'**
  String groupChatCount(int count);

  /// No description provided for @privateChat.
  ///
  /// In zh, this message translates to:
  /// **'私聊'**
  String get privateChat;

  /// No description provided for @noMessages.
  ///
  /// In zh, this message translates to:
  /// **'暂无消息'**
  String get noMessages;

  /// No description provided for @sendFirstMessage.
  ///
  /// In zh, this message translates to:
  /// **'发送第一条消息开始聊天'**
  String get sendFirstMessage;

  /// No description provided for @encryptionNotice.
  ///
  /// In zh, this message translates to:
  /// **'此聊天已启用端到端加密。只有您和对方可以阅读消息。'**
  String get encryptionNotice;

  /// No description provided for @replyTo.
  ///
  /// In zh, this message translates to:
  /// **'回复 {name}'**
  String replyTo(String name);

  /// No description provided for @multiForward.
  ///
  /// In zh, this message translates to:
  /// **'转发'**
  String get multiForward;

  /// No description provided for @collect.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get collect;

  /// No description provided for @noMembers.
  ///
  /// In zh, this message translates to:
  /// **'没有成员'**
  String get noMembers;

  /// No description provided for @memberNotFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到成员'**
  String get memberNotFound;

  /// No description provided for @voiceFileNotExist.
  ///
  /// In zh, this message translates to:
  /// **'语音文件不存在'**
  String get voiceFileNotExist;

  /// No description provided for @voiceFileEmpty.
  ///
  /// In zh, this message translates to:
  /// **'语音文件为空'**
  String get voiceFileEmpty;

  /// No description provided for @sendingVoice.
  ///
  /// In zh, this message translates to:
  /// **'语音发送中...'**
  String get sendingVoice;

  /// No description provided for @sendVoiceFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送语音失败: {error}'**
  String sendVoiceFailed(Object error);

  /// No description provided for @messageCopied.
  ///
  /// In zh, this message translates to:
  /// **'消息已复制'**
  String get messageCopied;

  /// No description provided for @messageForwarded.
  ///
  /// In zh, this message translates to:
  /// **'消息已转发'**
  String get messageForwarded;

  /// No description provided for @forwardFailed.
  ///
  /// In zh, this message translates to:
  /// **'转发失败: {error}'**
  String forwardFailed(Object error);

  /// No description provided for @unfavorited.
  ///
  /// In zh, this message translates to:
  /// **'已取消收藏'**
  String get unfavorited;

  /// No description provided for @favorited.
  ///
  /// In zh, this message translates to:
  /// **'已收藏'**
  String get favorited;

  /// No description provided for @reactionAdded.
  ///
  /// In zh, this message translates to:
  /// **'已添加表情回应'**
  String get reactionAdded;

  /// No description provided for @failedMessageDeleted.
  ///
  /// In zh, this message translates to:
  /// **'已删除失败消息'**
  String get failedMessageDeleted;

  /// No description provided for @deleteMessages.
  ///
  /// In zh, this message translates to:
  /// **'删除消息'**
  String get deleteMessages;

  /// No description provided for @deleteMessagesConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除 {count} 条消息吗？'**
  String deleteMessagesConfirm(Object count);

  /// No description provided for @noteOtherMessages.
  ///
  /// In zh, this message translates to:
  /// **'注意：{count} 条消息是他人发送的，只能在本地删除。'**
  String noteOtherMessages(Object count);

  /// No description provided for @myMessagesWillBeRecalled.
  ///
  /// In zh, this message translates to:
  /// **'{count} 条自己发送的消息将被撤回。'**
  String myMessagesWillBeRecalled(Object count);

  /// No description provided for @recalledCount.
  ///
  /// In zh, this message translates to:
  /// **'已撤回 {count} 条消息，本地删除 {localCount} 条'**
  String recalledCount(Object count, Object localCount);

  /// No description provided for @recalledMessages.
  ///
  /// In zh, this message translates to:
  /// **'已撤回 {count} 条消息'**
  String recalledMessages(Object count);

  /// No description provided for @deletedLocally.
  ///
  /// In zh, this message translates to:
  /// **'已删除 {count} 条消息（仅本地）'**
  String deletedLocally(Object count);

  /// No description provided for @forwardedCount.
  ///
  /// In zh, this message translates to:
  /// **'已转发 {count} 条消息'**
  String forwardedCount(Object count);

  /// No description provided for @forwardComplete.
  ///
  /// In zh, this message translates to:
  /// **'转发完成：成功 {success} 条，失败 {failed} 条'**
  String forwardComplete(Object failed, Object success);

  /// No description provided for @remindOnlyInGroup.
  ///
  /// In zh, this message translates to:
  /// **'提醒功能仅在群聊中可用'**
  String get remindOnlyInGroup;

  /// No description provided for @onlyTextSearchable.
  ///
  /// In zh, this message translates to:
  /// **'仅支持搜索文本消息'**
  String get onlyTextSearchable;

  /// No description provided for @searchFor.
  ///
  /// In zh, this message translates to:
  /// **'搜索 \"{text}\"'**
  String searchFor(Object text);

  /// No description provided for @baiduSearch.
  ///
  /// In zh, this message translates to:
  /// **'百度搜索'**
  String get baiduSearch;

  /// No description provided for @googleSearch.
  ///
  /// In zh, this message translates to:
  /// **'Google 搜索'**
  String get googleSearch;

  /// No description provided for @bingSearch.
  ///
  /// In zh, this message translates to:
  /// **'必应搜索'**
  String get bingSearch;

  /// No description provided for @calling.
  ///
  /// In zh, this message translates to:
  /// **'呼叫中...'**
  String get calling;

  /// No description provided for @connecting.
  ///
  /// In zh, this message translates to:
  /// **'正在连接...'**
  String get connecting;

  /// No description provided for @ringing.
  ///
  /// In zh, this message translates to:
  /// **'响铃中...'**
  String get ringing;

  /// No description provided for @inCall.
  ///
  /// In zh, this message translates to:
  /// **'通话中'**
  String get inCall;

  /// No description provided for @featureInDevelopment.
  ///
  /// In zh, this message translates to:
  /// **'{feature}功能开发中...'**
  String featureInDevelopment(String feature);

  /// No description provided for @collectMessages.
  ///
  /// In zh, this message translates to:
  /// **'已收藏 {count} 条消息'**
  String collectMessages(Object count);

  /// No description provided for @voted.
  ///
  /// In zh, this message translates to:
  /// **'已投票'**
  String get voted;

  /// No description provided for @voteChanged.
  ///
  /// In zh, this message translates to:
  /// **'投票已更改'**
  String get voteChanged;

  /// No description provided for @voteRemoved.
  ///
  /// In zh, this message translates to:
  /// **'已取消投票'**
  String get voteRemoved;

  /// No description provided for @endPoll.
  ///
  /// In zh, this message translates to:
  /// **'结束投票'**
  String get endPoll;

  /// No description provided for @endPollConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要结束这个投票吗？结束后将无法继续投票。'**
  String get endPollConfirm;

  /// No description provided for @memberCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人'**
  String memberCount(int count);

  /// No description provided for @videoChannels.
  ///
  /// In zh, this message translates to:
  /// **'视频号'**
  String get videoChannels;

  /// No description provided for @live.
  ///
  /// In zh, this message translates to:
  /// **'直播'**
  String get live;

  /// No description provided for @listen.
  ///
  /// In zh, this message translates to:
  /// **'听一听'**
  String get listen;

  /// No description provided for @watch.
  ///
  /// In zh, this message translates to:
  /// **'看一看'**
  String get watch;

  /// No description provided for @searchDiscover.
  ///
  /// In zh, this message translates to:
  /// **'搜一搜'**
  String get searchDiscover;

  /// No description provided for @nearbyPeople.
  ///
  /// In zh, this message translates to:
  /// **'附近的人'**
  String get nearbyPeople;

  /// No description provided for @games.
  ///
  /// In zh, this message translates to:
  /// **'游戏'**
  String get games;

  /// No description provided for @miniPrograms.
  ///
  /// In zh, this message translates to:
  /// **'小程序'**
  String get miniPrograms;

  /// No description provided for @done.
  ///
  /// In zh, this message translates to:
  /// **'完成({count})'**
  String done(int count);

  /// No description provided for @services.
  ///
  /// In zh, this message translates to:
  /// **'服务'**
  String get services;

  /// No description provided for @favorites.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get favorites;

  /// No description provided for @ordersAndCards.
  ///
  /// In zh, this message translates to:
  /// **'订单卡券'**
  String get ordersAndCards;

  /// No description provided for @stickers.
  ///
  /// In zh, this message translates to:
  /// **'表情'**
  String get stickers;

  /// No description provided for @statusSetTo.
  ///
  /// In zh, this message translates to:
  /// **'状态已设置为：{status}'**
  String statusSetTo(String status);

  /// No description provided for @avatarUploadFailed.
  ///
  /// In zh, this message translates to:
  /// **'头像上传失败'**
  String get avatarUploadFailed;

  /// No description provided for @personalProfile.
  ///
  /// In zh, this message translates to:
  /// **'个人信息'**
  String get personalProfile;

  /// No description provided for @name.
  ///
  /// In zh, this message translates to:
  /// **'名字'**
  String get name;

  /// No description provided for @gender.
  ///
  /// In zh, this message translates to:
  /// **'性别'**
  String get gender;

  /// No description provided for @region.
  ///
  /// In zh, this message translates to:
  /// **'地区'**
  String get region;

  /// No description provided for @myQrCode.
  ///
  /// In zh, this message translates to:
  /// **'我的二维码'**
  String get myQrCode;

  /// No description provided for @poke.
  ///
  /// In zh, this message translates to:
  /// **'拍一拍'**
  String get poke;

  /// No description provided for @ringtone.
  ///
  /// In zh, this message translates to:
  /// **'来电铃声'**
  String get ringtone;

  /// No description provided for @defaultRingtone.
  ///
  /// In zh, this message translates to:
  /// **'默认铃声'**
  String get defaultRingtone;

  /// No description provided for @myAddresses.
  ///
  /// In zh, this message translates to:
  /// **'我的地址'**
  String get myAddresses;

  /// No description provided for @genderSetTo.
  ///
  /// In zh, this message translates to:
  /// **'性别已设置为：{gender}'**
  String genderSetTo(String gender);

  /// No description provided for @selectRegion.
  ///
  /// In zh, this message translates to:
  /// **'选择地区'**
  String get selectRegion;

  /// No description provided for @selectCity.
  ///
  /// In zh, this message translates to:
  /// **'选择城市'**
  String get selectCity;

  /// No description provided for @regionSetTo.
  ///
  /// In zh, this message translates to:
  /// **'地区已设置为：{region}'**
  String regionSetTo(String region);

  /// No description provided for @setPoke.
  ///
  /// In zh, this message translates to:
  /// **'设置拍一拍'**
  String get setPoke;

  /// No description provided for @friendPokedMe.
  ///
  /// In zh, this message translates to:
  /// **'朋友拍了拍我'**
  String get friendPokedMe;

  /// No description provided for @enterPokeSuffix.
  ///
  /// In zh, this message translates to:
  /// **'输入拍一拍后缀，如：的肩膀'**
  String get enterPokeSuffix;

  /// No description provided for @example.
  ///
  /// In zh, this message translates to:
  /// **'示例'**
  String get example;

  /// No description provided for @onTheShoulder.
  ///
  /// In zh, this message translates to:
  /// **'的肩膀'**
  String get onTheShoulder;

  /// No description provided for @pokeCleared.
  ///
  /// In zh, this message translates to:
  /// **'拍一拍已清除'**
  String get pokeCleared;

  /// No description provided for @pokeSetTo.
  ///
  /// In zh, this message translates to:
  /// **'拍一拍已设置为：拍了拍我{suffix}'**
  String pokeSetTo(String suffix);

  /// No description provided for @editSignature.
  ///
  /// In zh, this message translates to:
  /// **'编辑个性签名'**
  String get editSignature;

  /// No description provided for @introduceYourself.
  ///
  /// In zh, this message translates to:
  /// **'一句话介绍自己'**
  String get introduceYourself;

  /// No description provided for @signatureCleared.
  ///
  /// In zh, this message translates to:
  /// **'个性签名已清除'**
  String get signatureCleared;

  /// No description provided for @signatureUpdated.
  ///
  /// In zh, this message translates to:
  /// **'个性签名已更新'**
  String get signatureUpdated;

  /// No description provided for @scanToAddFriend.
  ///
  /// In zh, this message translates to:
  /// **'扫一扫上面的二维码图案，加我为好友'**
  String get scanToAddFriend;

  /// No description provided for @ringtoneSetTo.
  ///
  /// In zh, this message translates to:
  /// **'来电铃声已设置为：{ringtone}'**
  String ringtoneSetTo(String ringtone);

  /// No description provided for @confirmDissolveGroup.
  ///
  /// In zh, this message translates to:
  /// **'确定要解散群聊「{name}」吗？此操作无法撤销。'**
  String confirmDissolveGroup(String name);

  /// No description provided for @enterValidServerAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的服务器地址'**
  String get enterValidServerAddress;

  /// No description provided for @emailOtp.
  ///
  /// In zh, this message translates to:
  /// **'邮箱验证码'**
  String get emailOtp;

  /// No description provided for @enterServerAddressFirst.
  ///
  /// In zh, this message translates to:
  /// **'请先输入服务器地址'**
  String get enterServerAddressFirst;

  /// No description provided for @passkeyRequiresServer.
  ///
  /// In zh, this message translates to:
  /// **'Passkey登录需要服务器支持'**
  String get passkeyRequiresServer;

  /// No description provided for @loginAgreement.
  ///
  /// In zh, this message translates to:
  /// **'登录即表示同意'**
  String get loginAgreement;

  /// No description provided for @pleaseAgreeToTerms.
  ///
  /// In zh, this message translates to:
  /// **'请先阅读并同意服务协议和隐私政策'**
  String get pleaseAgreeToTerms;

  /// No description provided for @registerFailed.
  ///
  /// In zh, this message translates to:
  /// **'注册失败'**
  String get registerFailed;

  /// No description provided for @reenterPassword.
  ///
  /// In zh, this message translates to:
  /// **'请再次输入密码'**
  String get reenterPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In zh, this message translates to:
  /// **'两次输入的密码不一致'**
  String get passwordsDoNotMatch;

  /// No description provided for @inviteCodeBuiltIn.
  ///
  /// In zh, this message translates to:
  /// **'邀请码（已内置）'**
  String get inviteCodeBuiltIn;

  /// No description provided for @inviteCodeBuiltInNote.
  ///
  /// In zh, this message translates to:
  /// **'邀请码已内置，通常无需修改'**
  String get inviteCodeBuiltInNote;

  /// No description provided for @iHaveReadAndAgree.
  ///
  /// In zh, this message translates to:
  /// **'我已阅读并同意'**
  String get iHaveReadAndAgree;

  /// No description provided for @startGroupChat.
  ///
  /// In zh, this message translates to:
  /// **'发起群聊'**
  String get startGroupChat;

  /// No description provided for @addFriends.
  ///
  /// In zh, this message translates to:
  /// **'添加朋友'**
  String get addFriends;

  /// No description provided for @paymentAndCollection.
  ///
  /// In zh, this message translates to:
  /// **'收付款'**
  String get paymentAndCollection;

  /// No description provided for @messagesWithCount.
  ///
  /// In zh, this message translates to:
  /// **'消息({count})'**
  String messagesWithCount(int count);

  /// No description provided for @contactCount.
  ///
  /// In zh, this message translates to:
  /// **'{count}位联系人'**
  String contactCount(int count);

  /// No description provided for @addToHomeScreen.
  ///
  /// In zh, this message translates to:
  /// **'添加到桌面'**
  String get addToHomeScreen;

  /// No description provided for @recommendedCardTo.
  ///
  /// In zh, this message translates to:
  /// **'已将{contact}的名片推荐给{recipient}'**
  String recommendedCardTo(String contact, String recipient);

  /// No description provided for @enterRemarkName.
  ///
  /// In zh, this message translates to:
  /// **'请输入备注名'**
  String get enterRemarkName;

  /// No description provided for @remarkSetTo.
  ///
  /// In zh, this message translates to:
  /// **'备注已设置为：{remark}'**
  String remarkSetTo(String remark);

  /// No description provided for @acceptedFriendRequest.
  ///
  /// In zh, this message translates to:
  /// **'已接受{name}的好友请求'**
  String acceptedFriendRequest(String name);

  /// No description provided for @rejectedFriendRequest.
  ///
  /// In zh, this message translates to:
  /// **'已拒绝{name}的好友请求'**
  String rejectedFriendRequest(String name);

  /// No description provided for @groupInvites.
  ///
  /// In zh, this message translates to:
  /// **'群邀请'**
  String get groupInvites;

  /// No description provided for @myGroups.
  ///
  /// In zh, this message translates to:
  /// **'我的群聊 ({count})'**
  String myGroups(int count);

  /// No description provided for @invitedToJoinGroup.
  ///
  /// In zh, this message translates to:
  /// **'邀请加入群聊'**
  String get invitedToJoinGroup;

  /// No description provided for @confirmLeaveGroup.
  ///
  /// In zh, this message translates to:
  /// **'确定要退出群聊「{name}」吗？'**
  String confirmLeaveGroup(String name);

  /// No description provided for @leave.
  ///
  /// In zh, this message translates to:
  /// **'离开'**
  String get leave;

  /// No description provided for @saveMedia.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get saveMedia;

  /// No description provided for @recallThisMessage.
  ///
  /// In zh, this message translates to:
  /// **'撤回该条消息？'**
  String get recallThisMessage;

  /// No description provided for @messageRecalled.
  ///
  /// In zh, this message translates to:
  /// **'对方撤回了一条消息'**
  String get messageRecalled;

  /// No description provided for @savedToGallery.
  ///
  /// In zh, this message translates to:
  /// **'已保存到相册'**
  String get savedToGallery;

  /// No description provided for @failedToSave.
  ///
  /// In zh, this message translates to:
  /// **'保存失败'**
  String get failedToSave;

  /// No description provided for @saving.
  ///
  /// In zh, this message translates to:
  /// **'保存中...'**
  String get saving;

  /// No description provided for @share.
  ///
  /// In zh, this message translates to:
  /// **'分享'**
  String get share;

  /// No description provided for @saveToGallery.
  ///
  /// In zh, this message translates to:
  /// **'保存到相册'**
  String get saveToGallery;

  /// No description provided for @downloadFailed.
  ///
  /// In zh, this message translates to:
  /// **'下载失败: {code}'**
  String downloadFailed(String code);

  /// No description provided for @noMediaUrl.
  ///
  /// In zh, this message translates to:
  /// **'没有可用的媒体链接'**
  String get noMediaUrl;

  /// No description provided for @shareFailed.
  ///
  /// In zh, this message translates to:
  /// **'分享失败: {error}'**
  String shareFailed(String error);

  /// No description provided for @failedToLoadImage.
  ///
  /// In zh, this message translates to:
  /// **'图片加载失败'**
  String get failedToLoadImage;

  /// No description provided for @failedToLoadMoreMessages.
  ///
  /// In zh, this message translates to:
  /// **'加载更多消息失败'**
  String get failedToLoadMoreMessages;

  /// No description provided for @failedToSend.
  ///
  /// In zh, this message translates to:
  /// **'发送失败'**
  String get failedToSend;

  /// No description provided for @failedToSendImage.
  ///
  /// In zh, this message translates to:
  /// **'发送图片失败'**
  String get failedToSendImage;

  /// No description provided for @failedToSendVoice.
  ///
  /// In zh, this message translates to:
  /// **'发送语音失败'**
  String get failedToSendVoice;

  /// No description provided for @failedToSendFile.
  ///
  /// In zh, this message translates to:
  /// **'发送文件失败'**
  String get failedToSendFile;

  /// No description provided for @failedToSendVideo.
  ///
  /// In zh, this message translates to:
  /// **'发送视频失败'**
  String get failedToSendVideo;

  /// No description provided for @failedToSendLocation.
  ///
  /// In zh, this message translates to:
  /// **'发送位置失败'**
  String get failedToSendLocation;

  /// No description provided for @failedToResend.
  ///
  /// In zh, this message translates to:
  /// **'重发失败'**
  String get failedToResend;

  /// No description provided for @failedToRecall.
  ///
  /// In zh, this message translates to:
  /// **'撤回失败'**
  String get failedToRecall;

  /// No description provided for @failedToReply.
  ///
  /// In zh, this message translates to:
  /// **'回复失败'**
  String get failedToReply;

  /// No description provided for @failedToAddReaction.
  ///
  /// In zh, this message translates to:
  /// **'添加回应失败'**
  String get failedToAddReaction;

  /// No description provided for @failedToSendPoll.
  ///
  /// In zh, this message translates to:
  /// **'发送投票失败'**
  String get failedToSendPoll;

  /// No description provided for @failedToVote.
  ///
  /// In zh, this message translates to:
  /// **'投票失败'**
  String get failedToVote;

  /// No description provided for @failedToLoadMessages.
  ///
  /// In zh, this message translates to:
  /// **'加载消息失败'**
  String get failedToLoadMessages;

  /// No description provided for @callFeatureComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'语音和视频通话功能即将上线'**
  String get callFeatureComingSoon;

  /// No description provided for @cannotForwardRedPacketOrTransfer.
  ///
  /// In zh, this message translates to:
  /// **'红包和转账不能转发'**
  String get cannotForwardRedPacketOrTransfer;

  /// No description provided for @videoRecordingFailed.
  ///
  /// In zh, this message translates to:
  /// **'视频录制失败，请重试'**
  String get videoRecordingFailed;

  /// No description provided for @redPacket.
  ///
  /// In zh, this message translates to:
  /// **'红包'**
  String get redPacket;

  /// No description provided for @music.
  ///
  /// In zh, this message translates to:
  /// **'音乐'**
  String get music;

  /// No description provided for @coupon.
  ///
  /// In zh, this message translates to:
  /// **'卡券'**
  String get coupon;

  /// No description provided for @gift.
  ///
  /// In zh, this message translates to:
  /// **'礼物'**
  String get gift;

  /// No description provided for @poll.
  ///
  /// In zh, this message translates to:
  /// **'投票'**
  String get poll;

  /// No description provided for @text.
  ///
  /// In zh, this message translates to:
  /// **'文本'**
  String get text;

  /// No description provided for @link.
  ///
  /// In zh, this message translates to:
  /// **'链接'**
  String get link;

  /// No description provided for @note.
  ///
  /// In zh, this message translates to:
  /// **'笔记'**
  String get note;

  /// No description provided for @myNotes.
  ///
  /// In zh, this message translates to:
  /// **'我的笔记'**
  String get myNotes;

  /// No description provided for @today.
  ///
  /// In zh, this message translates to:
  /// **'今天'**
  String get today;

  /// No description provided for @daysAgoText.
  ///
  /// In zh, this message translates to:
  /// **'{count}天前'**
  String daysAgoText(int count);

  /// No description provided for @dateFormat.
  ///
  /// In zh, this message translates to:
  /// **'{month}月{day}日'**
  String dateFormat(int month, int day);

  /// No description provided for @noFavorites.
  ///
  /// In zh, this message translates to:
  /// **'暂无收藏'**
  String get noFavorites;

  /// No description provided for @longPressToFavorite.
  ///
  /// In zh, this message translates to:
  /// **'长按消息进行收藏'**
  String get longPressToFavorite;

  /// No description provided for @newNote.
  ///
  /// In zh, this message translates to:
  /// **'新建笔记'**
  String get newNote;

  /// No description provided for @favoriteLink.
  ///
  /// In zh, this message translates to:
  /// **'收藏链接'**
  String get favoriteLink;

  /// No description provided for @editTags.
  ///
  /// In zh, this message translates to:
  /// **'编辑标签'**
  String get editTags;

  /// No description provided for @deleteFavorite.
  ///
  /// In zh, this message translates to:
  /// **'删除收藏'**
  String get deleteFavorite;

  /// No description provided for @deleteFavoriteConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这条收藏吗？'**
  String get deleteFavoriteConfirm;

  /// No description provided for @noSearchResultsFound.
  ///
  /// In zh, this message translates to:
  /// **'没有找到结果'**
  String get noSearchResultsFound;

  /// No description provided for @sendRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'发红包'**
  String get sendRedPacket;

  /// No description provided for @amount.
  ///
  /// In zh, this message translates to:
  /// **'金额'**
  String get amount;

  /// No description provided for @redPacketCover.
  ///
  /// In zh, this message translates to:
  /// **'红包封面'**
  String get redPacketCover;

  /// No description provided for @redPacketType.
  ///
  /// In zh, this message translates to:
  /// **'红包类型'**
  String get redPacketType;

  /// No description provided for @normalRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'普通红包'**
  String get normalRedPacket;

  /// No description provided for @luckyRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'拼手气'**
  String get luckyRedPacket;

  /// No description provided for @redPacketCount.
  ///
  /// In zh, this message translates to:
  /// **'红包个数'**
  String get redPacketCount;

  /// No description provided for @pieces.
  ///
  /// In zh, this message translates to:
  /// **'个'**
  String get pieces;

  /// No description provided for @putMoneyInRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'塞钱进红包'**
  String get putMoneyInRedPacket;

  /// No description provided for @redPacketRefundNotice.
  ///
  /// In zh, this message translates to:
  /// **'未领取的红包，将于24小时后发起退款'**
  String get redPacketRefundNotice;

  /// No description provided for @openRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'開'**
  String get openRedPacket;

  /// No description provided for @redPacketAllClaimed.
  ///
  /// In zh, this message translates to:
  /// **'红包已被领完'**
  String get redPacketAllClaimed;

  /// No description provided for @redPacketExpired.
  ///
  /// In zh, this message translates to:
  /// **'红包已过期'**
  String get redPacketExpired;

  /// No description provided for @addTransferNote.
  ///
  /// In zh, this message translates to:
  /// **'添加转账说明'**
  String get addTransferNote;

  /// No description provided for @yuan.
  ///
  /// In zh, this message translates to:
  /// **'元'**
  String get yuan;

  /// No description provided for @savedToChangeCanTransfer.
  ///
  /// In zh, this message translates to:
  /// **'已存入零钱，可直接转账'**
  String get savedToChangeCanTransfer;

  /// No description provided for @replyWithEmoji.
  ///
  /// In zh, this message translates to:
  /// **'用此表情回复'**
  String get replyWithEmoji;

  /// No description provided for @claimedYourRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'领取了你的'**
  String get claimedYourRedPacket;

  /// No description provided for @claimedRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'领取了'**
  String get claimedRedPacket;

  /// No description provided for @otherTyping.
  ///
  /// In zh, this message translates to:
  /// **'对方正在输入...'**
  String get otherTyping;

  /// No description provided for @processing.
  ///
  /// In zh, this message translates to:
  /// **'处理中...'**
  String get processing;

  /// No description provided for @transferCancelled.
  ///
  /// In zh, this message translates to:
  /// **'转账已取消'**
  String get transferCancelled;

  /// No description provided for @transferFailed.
  ///
  /// In zh, this message translates to:
  /// **'转账失败'**
  String get transferFailed;

  /// No description provided for @creatingPaymentRequest.
  ///
  /// In zh, this message translates to:
  /// **'正在创建收款请求...'**
  String get creatingPaymentRequest;

  /// No description provided for @processingPayment.
  ///
  /// In zh, this message translates to:
  /// **'正在处理支付...'**
  String get processingPayment;

  /// No description provided for @paymentFailed.
  ///
  /// In zh, this message translates to:
  /// **'支付失败'**
  String get paymentFailed;

  /// No description provided for @clickRetry.
  ///
  /// In zh, this message translates to:
  /// **'点击重试'**
  String get clickRetry;

  /// No description provided for @settingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settingsTitle;

  /// No description provided for @editRemark.
  ///
  /// In zh, this message translates to:
  /// **'编辑备注'**
  String get editRemark;

  /// No description provided for @setPermissions.
  ///
  /// In zh, this message translates to:
  /// **'设置权限'**
  String get setPermissions;

  /// No description provided for @recommendToFriends.
  ///
  /// In zh, this message translates to:
  /// **'把他 (她) 推荐给朋友'**
  String get recommendToFriends;

  /// No description provided for @setStarFriend.
  ///
  /// In zh, this message translates to:
  /// **'设为星标朋友'**
  String get setStarFriend;

  /// No description provided for @addToBlacklist.
  ///
  /// In zh, this message translates to:
  /// **'加入黑名单'**
  String get addToBlacklist;

  /// No description provided for @complain.
  ///
  /// In zh, this message translates to:
  /// **'投诉'**
  String get complain;

  /// No description provided for @deleteContact.
  ///
  /// In zh, this message translates to:
  /// **'删除联系人'**
  String get deleteContact;

  /// No description provided for @deleteContactConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除 {name} 吗？'**
  String deleteContactConfirm(String name);

  /// No description provided for @transferTitle.
  ///
  /// In zh, this message translates to:
  /// **'转账'**
  String get transferTitle;

  /// No description provided for @receiverAddressLabel.
  ///
  /// In zh, this message translates to:
  /// **'收款地址'**
  String get receiverAddressLabel;

  /// No description provided for @selectTokenLabel.
  ///
  /// In zh, this message translates to:
  /// **'选择代币'**
  String get selectTokenLabel;

  /// No description provided for @transferAmountLabel.
  ///
  /// In zh, this message translates to:
  /// **'转账金额'**
  String get transferAmountLabel;

  /// No description provided for @memoLabel.
  ///
  /// In zh, this message translates to:
  /// **'备注（可选）'**
  String get memoLabel;

  /// No description provided for @enterOrPasteAddressHint.
  ///
  /// In zh, this message translates to:
  /// **'输入或粘贴钱包地址'**
  String get enterOrPasteAddressHint;

  /// No description provided for @scanInDevelopment.
  ///
  /// In zh, this message translates to:
  /// **'扫描功能开发中...'**
  String get scanInDevelopment;

  /// No description provided for @availableLabel.
  ///
  /// In zh, this message translates to:
  /// **'可用'**
  String get availableLabel;

  /// No description provided for @availableBalanceFormat.
  ///
  /// In zh, this message translates to:
  /// **'可用余额: {balance} {symbol}'**
  String availableBalanceFormat(String balance, String symbol);

  /// No description provided for @addMemoHint.
  ///
  /// In zh, this message translates to:
  /// **'添加备注信息'**
  String get addMemoHint;

  /// No description provided for @receiveTitle.
  ///
  /// In zh, this message translates to:
  /// **'收款'**
  String get receiveTitle;

  /// No description provided for @walletNotConnectedTitle.
  ///
  /// In zh, this message translates to:
  /// **'钱包未连接'**
  String get walletNotConnectedTitle;

  /// No description provided for @connectWalletFirst.
  ///
  /// In zh, this message translates to:
  /// **'请先连接钱包'**
  String get connectWalletFirst;

  /// No description provided for @sendPaymentRequest.
  ///
  /// In zh, this message translates to:
  /// **'发送收款请求'**
  String get sendPaymentRequest;

  /// No description provided for @qrCodeGenerateFailed.
  ///
  /// In zh, this message translates to:
  /// **'二维码生成失败'**
  String get qrCodeGenerateFailed;

  /// No description provided for @scanQrToPayMe.
  ///
  /// In zh, this message translates to:
  /// **'扫描二维码向我付款'**
  String get scanQrToPayMe;

  /// No description provided for @myWalletAddress.
  ///
  /// In zh, this message translates to:
  /// **'我的钱包地址'**
  String get myWalletAddress;

  /// No description provided for @createPaymentRequest.
  ///
  /// In zh, this message translates to:
  /// **'创建收款请求'**
  String get createPaymentRequest;

  /// No description provided for @selectTokenHint.
  ///
  /// In zh, this message translates to:
  /// **'选择代币'**
  String get selectTokenHint;

  /// No description provided for @amountLabel.
  ///
  /// In zh, this message translates to:
  /// **'金额'**
  String get amountLabel;

  /// No description provided for @cancelButton.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancelButton;

  /// No description provided for @sendRequestButton.
  ///
  /// In zh, this message translates to:
  /// **'发送请求'**
  String get sendRequestButton;

  /// No description provided for @allReadReceipt.
  ///
  /// In zh, this message translates to:
  /// **'全部已读'**
  String get allReadReceipt;

  /// No description provided for @readCountReceipt.
  ///
  /// In zh, this message translates to:
  /// **'{count}人已读'**
  String readCountReceipt(int count);

  /// No description provided for @n42IdLabel.
  ///
  /// In zh, this message translates to:
  /// **'N42号：{id}'**
  String n42IdLabel(String id);

  /// No description provided for @redPacketDefaultGreeting.
  ///
  /// In zh, this message translates to:
  /// **'恭喜发财，大吉大利'**
  String get redPacketDefaultGreeting;

  /// No description provided for @senderRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'{name}的红包'**
  String senderRedPacket(String name);

  /// No description provided for @allButton.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get allButton;

  /// No description provided for @enterValidAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的收款地址'**
  String get enterValidAddress;

  /// No description provided for @pleaseSelectToken.
  ///
  /// In zh, this message translates to:
  /// **'请选择代币'**
  String get pleaseSelectToken;

  /// No description provided for @receivedTransfer.
  ///
  /// In zh, this message translates to:
  /// **'收到转账'**
  String get receivedTransfer;

  /// No description provided for @selectForwardRecipient.
  ///
  /// In zh, this message translates to:
  /// **'选择转发对象'**
  String get selectForwardRecipient;

  /// No description provided for @emojiFaces.
  ///
  /// In zh, this message translates to:
  /// **'表情'**
  String get emojiFaces;

  /// No description provided for @emojiHearts.
  ///
  /// In zh, this message translates to:
  /// **'爱心'**
  String get emojiHearts;

  /// No description provided for @emojiAnimals.
  ///
  /// In zh, this message translates to:
  /// **'动物'**
  String get emojiAnimals;

  /// No description provided for @emojiFood.
  ///
  /// In zh, this message translates to:
  /// **'食物'**
  String get emojiFood;

  /// No description provided for @emojiTransport.
  ///
  /// In zh, this message translates to:
  /// **'交通'**
  String get emojiTransport;

  /// No description provided for @emojiActivities.
  ///
  /// In zh, this message translates to:
  /// **'活动'**
  String get emojiActivities;

  /// No description provided for @emojiObjects.
  ///
  /// In zh, this message translates to:
  /// **'物品'**
  String get emojiObjects;

  /// No description provided for @emojiSymbols.
  ///
  /// In zh, this message translates to:
  /// **'符号'**
  String get emojiSymbols;

  /// No description provided for @transferProcessing.
  ///
  /// In zh, this message translates to:
  /// **'正在处理转账...'**
  String get transferProcessing;

  /// No description provided for @senderSentRedPacket.
  ///
  /// In zh, this message translates to:
  /// **'{name}发出的红包'**
  String senderSentRedPacket(String name);

  /// No description provided for @savedToBalance.
  ///
  /// In zh, this message translates to:
  /// **'已存入零钱，可直接转账'**
  String get savedToBalance;

  /// No description provided for @redPacketExpiredOrEmpty.
  ///
  /// In zh, this message translates to:
  /// **'红包已过期/已领完'**
  String get redPacketExpiredOrEmpty;

  /// No description provided for @scanFeatureComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'扫描功能开发中...'**
  String get scanFeatureComingSoon;

  /// No description provided for @setAsStarred.
  ///
  /// In zh, this message translates to:
  /// **'设为星标朋友'**
  String get setAsStarred;

  /// No description provided for @addToBlocklist.
  ///
  /// In zh, this message translates to:
  /// **'加入黑名单'**
  String get addToBlocklist;

  /// No description provided for @claimedYour.
  ///
  /// In zh, this message translates to:
  /// **'领取了你的'**
  String get claimedYour;

  /// No description provided for @claimedText.
  ///
  /// In zh, this message translates to:
  /// **'领取了'**
  String get claimedText;

  /// No description provided for @userTyping.
  ///
  /// In zh, this message translates to:
  /// **'{name}正在输入...'**
  String userTyping(String name);

  /// No description provided for @typing.
  ///
  /// In zh, this message translates to:
  /// **'对方正在输入...'**
  String get typing;

  /// No description provided for @waitingToReceive.
  ///
  /// In zh, this message translates to:
  /// **'待对方接收'**
  String get waitingToReceive;

  /// No description provided for @tapToClaim.
  ///
  /// In zh, this message translates to:
  /// **'点击领取'**
  String get tapToClaim;

  /// No description provided for @hasBeenReceived.
  ///
  /// In zh, this message translates to:
  /// **'已被接收'**
  String get hasBeenReceived;

  /// No description provided for @getLucky.
  ///
  /// In zh, this message translates to:
  /// **'领个好彩头'**
  String get getLucky;

  /// No description provided for @cameraStartFailed.
  ///
  /// In zh, this message translates to:
  /// **'相机启动失败'**
  String get cameraStartFailed;

  /// No description provided for @unknownError.
  ///
  /// In zh, this message translates to:
  /// **'未知错误'**
  String get unknownError;

  /// No description provided for @placeQrCodeInFrame.
  ///
  /// In zh, this message translates to:
  /// **'将二维码放入框内扫描'**
  String get placeQrCodeInFrame;

  /// No description provided for @closeManualInput.
  ///
  /// In zh, this message translates to:
  /// **'关闭手动输入'**
  String get closeManualInput;

  /// No description provided for @manualInputUserId.
  ///
  /// In zh, this message translates to:
  /// **'手动输入用户ID'**
  String get manualInputUserId;

  /// No description provided for @add.
  ///
  /// In zh, this message translates to:
  /// **'加入'**
  String get add;

  /// No description provided for @ringtoneClear.
  ///
  /// In zh, this message translates to:
  /// **'清脆'**
  String get ringtoneClear;

  /// No description provided for @ringtonePhone.
  ///
  /// In zh, this message translates to:
  /// **'电话'**
  String get ringtonePhone;

  /// No description provided for @ringtoneClassic.
  ///
  /// In zh, this message translates to:
  /// **'经典'**
  String get ringtoneClassic;

  /// No description provided for @ringtoneSoft.
  ///
  /// In zh, this message translates to:
  /// **'柔和'**
  String get ringtoneSoft;

  /// No description provided for @ringtoneVibrate.
  ///
  /// In zh, this message translates to:
  /// **'震动'**
  String get ringtoneVibrate;

  /// No description provided for @ringtoneSilent.
  ///
  /// In zh, this message translates to:
  /// **'静音'**
  String get ringtoneSilent;

  /// No description provided for @stop.
  ///
  /// In zh, this message translates to:
  /// **'停止'**
  String get stop;

  /// No description provided for @selectRingtone.
  ///
  /// In zh, this message translates to:
  /// **'选择铃声'**
  String get selectRingtone;

  /// No description provided for @loadingRingtones.
  ///
  /// In zh, this message translates to:
  /// **'加载铃声中...'**
  String get loadingRingtones;

  /// No description provided for @noRingtonesFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到铃声'**
  String get noRingtonesFound;

  /// No description provided for @moodAndThoughts.
  ///
  /// In zh, this message translates to:
  /// **'心情想法'**
  String get moodAndThoughts;

  /// No description provided for @statusHappy.
  ///
  /// In zh, this message translates to:
  /// **'开心'**
  String get statusHappy;

  /// No description provided for @statusCracked.
  ///
  /// In zh, this message translates to:
  /// **'裂开'**
  String get statusCracked;

  /// No description provided for @statusLucky.
  ///
  /// In zh, this message translates to:
  /// **'发呆'**
  String get statusLucky;

  /// No description provided for @statusSunny.
  ///
  /// In zh, this message translates to:
  /// **'天气晴'**
  String get statusSunny;

  /// No description provided for @statusTired.
  ///
  /// In zh, this message translates to:
  /// **'累了'**
  String get statusTired;

  /// No description provided for @statusDaydream.
  ///
  /// In zh, this message translates to:
  /// **'发呆中'**
  String get statusDaydream;

  /// No description provided for @statusRushing.
  ///
  /// In zh, this message translates to:
  /// **'忙碌'**
  String get statusRushing;

  /// No description provided for @statusOverthinking.
  ///
  /// In zh, this message translates to:
  /// **'想太多'**
  String get statusOverthinking;

  /// No description provided for @statusEnergized.
  ///
  /// In zh, this message translates to:
  /// **'元气满满'**
  String get statusEnergized;

  /// No description provided for @workAndStudy.
  ///
  /// In zh, this message translates to:
  /// **'工作学习'**
  String get workAndStudy;

  /// No description provided for @statusWorking.
  ///
  /// In zh, this message translates to:
  /// **'搬砖中'**
  String get statusWorking;

  /// No description provided for @statusStudying.
  ///
  /// In zh, this message translates to:
  /// **'学习中'**
  String get statusStudying;

  /// No description provided for @statusBusy.
  ///
  /// In zh, this message translates to:
  /// **'忙'**
  String get statusBusy;

  /// No description provided for @statusSlacking.
  ///
  /// In zh, this message translates to:
  /// **'摸鱼中'**
  String get statusSlacking;

  /// No description provided for @statusTraveling.
  ///
  /// In zh, this message translates to:
  /// **'旅行中'**
  String get statusTraveling;

  /// No description provided for @statusGoingHome.
  ///
  /// In zh, this message translates to:
  /// **'回家中'**
  String get statusGoingHome;

  /// No description provided for @statusDnd.
  ///
  /// In zh, this message translates to:
  /// **'请勿打扰'**
  String get statusDnd;

  /// No description provided for @statusHanging.
  ///
  /// In zh, this message translates to:
  /// **'出去浪'**
  String get statusHanging;

  /// No description provided for @statusCheckIn.
  ///
  /// In zh, this message translates to:
  /// **'打卡'**
  String get statusCheckIn;

  /// No description provided for @statusExercising.
  ///
  /// In zh, this message translates to:
  /// **'运动中'**
  String get statusExercising;

  /// No description provided for @statusCoffee.
  ///
  /// In zh, this message translates to:
  /// **'喝咖啡'**
  String get statusCoffee;

  /// No description provided for @statusBubbleTea.
  ///
  /// In zh, this message translates to:
  /// **'奶茶'**
  String get statusBubbleTea;

  /// No description provided for @statusEating.
  ///
  /// In zh, this message translates to:
  /// **'干饭中'**
  String get statusEating;

  /// No description provided for @statusParenting.
  ///
  /// In zh, this message translates to:
  /// **'带娃中'**
  String get statusParenting;

  /// No description provided for @statusSavingWorld.
  ///
  /// In zh, this message translates to:
  /// **'拯救世界'**
  String get statusSavingWorld;

  /// No description provided for @statusSelfie.
  ///
  /// In zh, this message translates to:
  /// **'自拍'**
  String get statusSelfie;

  /// No description provided for @rest.
  ///
  /// In zh, this message translates to:
  /// **'休息'**
  String get rest;

  /// No description provided for @statusRetreat.
  ///
  /// In zh, this message translates to:
  /// **'闭关'**
  String get statusRetreat;

  /// No description provided for @statusHome.
  ///
  /// In zh, this message translates to:
  /// **'宅家'**
  String get statusHome;

  /// No description provided for @statusSleeping.
  ///
  /// In zh, this message translates to:
  /// **'睡觉中'**
  String get statusSleeping;

  /// No description provided for @statusCatLover.
  ///
  /// In zh, this message translates to:
  /// **'吸猫中'**
  String get statusCatLover;

  /// No description provided for @statusDogWalking.
  ///
  /// In zh, this message translates to:
  /// **'遛狗中'**
  String get statusDogWalking;

  /// No description provided for @statusGaming.
  ///
  /// In zh, this message translates to:
  /// **'游戏中'**
  String get statusGaming;

  /// No description provided for @statusListening.
  ///
  /// In zh, this message translates to:
  /// **'听歌中'**
  String get statusListening;

  /// No description provided for @setStatus.
  ///
  /// In zh, this message translates to:
  /// **'设置状态'**
  String get setStatus;

  /// No description provided for @visibleToFriends24h.
  ///
  /// In zh, this message translates to:
  /// **'可被好友看到，24小时后自动清除'**
  String get visibleToFriends24h;

  /// No description provided for @writeStatus.
  ///
  /// In zh, this message translates to:
  /// **'写状态'**
  String get writeStatus;

  /// No description provided for @enterYourStatus.
  ///
  /// In zh, this message translates to:
  /// **'输入你的状态...'**
  String get enterYourStatus;

  /// No description provided for @ok.
  ///
  /// In zh, this message translates to:
  /// **'确定'**
  String get ok;

  /// No description provided for @cameraPermissionRequired.
  ///
  /// In zh, this message translates to:
  /// **'扫描二维码需要相机权限'**
  String get cameraPermissionRequired;

  /// No description provided for @cameraPermissionDenied.
  ///
  /// In zh, this message translates to:
  /// **'相机权限已被永久拒绝，请在系统设置中开启。'**
  String get cameraPermissionDenied;

  /// No description provided for @cannotGetCameraPermission.
  ///
  /// In zh, this message translates to:
  /// **'无法获取相机权限'**
  String get cannotGetCameraPermission;

  /// No description provided for @permissionCheckError.
  ///
  /// In zh, this message translates to:
  /// **'检查权限时出错: {error}'**
  String permissionCheckError(String error);

  /// No description provided for @invalidQrCode.
  ///
  /// In zh, this message translates to:
  /// **'无效的二维码'**
  String get invalidQrCode;

  /// No description provided for @qrCodeProcessFailed.
  ///
  /// In zh, this message translates to:
  /// **'处理二维码失败: {error}'**
  String qrCodeProcessFailed(String error);

  /// No description provided for @cannotAddFriend.
  ///
  /// In zh, this message translates to:
  /// **'无法添加好友: {error}'**
  String cannotAddFriend(String error);

  /// No description provided for @scanQrCode.
  ///
  /// In zh, this message translates to:
  /// **'扫描二维码'**
  String get scanQrCode;

  /// No description provided for @checkingCameraPermission.
  ///
  /// In zh, this message translates to:
  /// **'正在检查相机权限...'**
  String get checkingCameraPermission;

  /// No description provided for @needCameraPermission.
  ///
  /// In zh, this message translates to:
  /// **'需要相机权限'**
  String get needCameraPermission;

  /// No description provided for @retryPermission.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get retryPermission;

  /// No description provided for @openSettings.
  ///
  /// In zh, this message translates to:
  /// **'打开设置'**
  String get openSettings;

  /// No description provided for @inviteMembers.
  ///
  /// In zh, this message translates to:
  /// **'邀请成员'**
  String get inviteMembers;

  /// No description provided for @inviteCount.
  ///
  /// In zh, this message translates to:
  /// **'邀请({count})'**
  String inviteCount(int count);

  /// No description provided for @noShippingAddress.
  ///
  /// In zh, this message translates to:
  /// **'暂无收货地址'**
  String get noShippingAddress;

  /// No description provided for @defaultLabel.
  ///
  /// In zh, this message translates to:
  /// **'默认'**
  String get defaultLabel;

  /// No description provided for @editAddress.
  ///
  /// In zh, this message translates to:
  /// **'编辑地址'**
  String get editAddress;

  /// No description provided for @recipient.
  ///
  /// In zh, this message translates to:
  /// **'收货人'**
  String get recipient;

  /// No description provided for @enterRecipientName.
  ///
  /// In zh, this message translates to:
  /// **'请输入收货人姓名'**
  String get enterRecipientName;

  /// No description provided for @phoneNumber.
  ///
  /// In zh, this message translates to:
  /// **'手机号码'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In zh, this message translates to:
  /// **'请输入手机号码'**
  String get enterPhoneNumber;

  /// No description provided for @regionHint.
  ///
  /// In zh, this message translates to:
  /// **'省/市/区'**
  String get regionHint;

  /// No description provided for @detailedAddress.
  ///
  /// In zh, this message translates to:
  /// **'详细地址'**
  String get detailedAddress;

  /// No description provided for @detailedAddressHint.
  ///
  /// In zh, this message translates to:
  /// **'街道、门牌号等'**
  String get detailedAddressHint;

  /// No description provided for @setAsDefaultAddress.
  ///
  /// In zh, this message translates to:
  /// **'设为默认地址'**
  String get setAsDefaultAddress;

  /// No description provided for @pleaseCompleteInfo.
  ///
  /// In zh, this message translates to:
  /// **'请填写完整信息'**
  String get pleaseCompleteInfo;

  /// No description provided for @noInvoice.
  ///
  /// In zh, this message translates to:
  /// **'暂无发票抬头'**
  String get noInvoice;

  /// No description provided for @company.
  ///
  /// In zh, this message translates to:
  /// **'企业'**
  String get company;

  /// No description provided for @taxNumber.
  ///
  /// In zh, this message translates to:
  /// **'税号'**
  String get taxNumber;

  /// No description provided for @editInvoice.
  ///
  /// In zh, this message translates to:
  /// **'编辑发票抬头'**
  String get editInvoice;

  /// No description provided for @companyName.
  ///
  /// In zh, this message translates to:
  /// **'企业名称'**
  String get companyName;

  /// No description provided for @enterCompanyName.
  ///
  /// In zh, this message translates to:
  /// **'请输入企业名称'**
  String get enterCompanyName;

  /// No description provided for @personalName.
  ///
  /// In zh, this message translates to:
  /// **'个人姓名'**
  String get personalName;

  /// No description provided for @enterName.
  ///
  /// In zh, this message translates to:
  /// **'请输入姓名'**
  String get enterName;

  /// No description provided for @taxIdNumber.
  ///
  /// In zh, this message translates to:
  /// **'纳税人识别号'**
  String get taxIdNumber;

  /// No description provided for @enterTaxIdNumber.
  ///
  /// In zh, this message translates to:
  /// **'请输入纳税人识别号'**
  String get enterTaxIdNumber;

  /// No description provided for @bankNameOptional.
  ///
  /// In zh, this message translates to:
  /// **'开户银行（选填）'**
  String get bankNameOptional;

  /// No description provided for @enterBankName.
  ///
  /// In zh, this message translates to:
  /// **'请输入开户银行'**
  String get enterBankName;

  /// No description provided for @bankAccountOptional.
  ///
  /// In zh, this message translates to:
  /// **'银行账号（选填）'**
  String get bankAccountOptional;

  /// No description provided for @enterBankAccount.
  ///
  /// In zh, this message translates to:
  /// **'请输入银行账号'**
  String get enterBankAccount;

  /// No description provided for @companyAddressOptional.
  ///
  /// In zh, this message translates to:
  /// **'企业地址（选填）'**
  String get companyAddressOptional;

  /// No description provided for @enterCompanyAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入企业地址'**
  String get enterCompanyAddress;

  /// No description provided for @companyPhoneOptional.
  ///
  /// In zh, this message translates to:
  /// **'企业电话（选填）'**
  String get companyPhoneOptional;

  /// No description provided for @enterCompanyPhone.
  ///
  /// In zh, this message translates to:
  /// **'请输入企业电话'**
  String get enterCompanyPhone;

  /// No description provided for @setAsDefaultInvoice.
  ///
  /// In zh, this message translates to:
  /// **'设为默认抬头'**
  String get setAsDefaultInvoice;

  /// No description provided for @confirmDeleteAddress.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这个地址吗？'**
  String get confirmDeleteAddress;

  /// No description provided for @confirmDeleteInvoice.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这个发票抬头吗？'**
  String get confirmDeleteInvoice;

  /// No description provided for @groupOwner.
  ///
  /// In zh, this message translates to:
  /// **'群主'**
  String get groupOwner;

  /// No description provided for @groupAdmin.
  ///
  /// In zh, this message translates to:
  /// **'管理员'**
  String get groupAdmin;

  /// No description provided for @searchMembers.
  ///
  /// In zh, this message translates to:
  /// **'搜索成员'**
  String get searchMembers;

  /// No description provided for @totalMembers.
  ///
  /// In zh, this message translates to:
  /// **'{count}位成员'**
  String totalMembers(int count);

  /// No description provided for @removeFromGroup.
  ///
  /// In zh, this message translates to:
  /// **'移出群聊'**
  String get removeFromGroup;

  /// No description provided for @confirmRemoveMember.
  ///
  /// In zh, this message translates to:
  /// **'确定要将\"{name}\"移出群聊吗？'**
  String confirmRemoveMember(String name);

  /// No description provided for @setAsAdmin.
  ///
  /// In zh, this message translates to:
  /// **'设为管理员'**
  String get setAsAdmin;

  /// No description provided for @removeAdmin.
  ///
  /// In zh, this message translates to:
  /// **'取消管理员'**
  String get removeAdmin;

  /// No description provided for @deleteContactSuccess.
  ///
  /// In zh, this message translates to:
  /// **'联系人已删除'**
  String get deleteContactSuccess;

  /// No description provided for @unknownSong.
  ///
  /// In zh, this message translates to:
  /// **'未知歌曲'**
  String get unknownSong;

  /// No description provided for @unknownArtist.
  ///
  /// In zh, this message translates to:
  /// **'未知艺术家'**
  String get unknownArtist;

  /// No description provided for @unknownContact.
  ///
  /// In zh, this message translates to:
  /// **'未知联系人'**
  String get unknownContact;

  /// No description provided for @personalCard.
  ///
  /// In zh, this message translates to:
  /// **'个人名片'**
  String get personalCard;

  /// No description provided for @singleChoice.
  ///
  /// In zh, this message translates to:
  /// **'单选'**
  String get singleChoice;

  /// No description provided for @multiChoice.
  ///
  /// In zh, this message translates to:
  /// **'多选'**
  String get multiChoice;

  /// No description provided for @ended.
  ///
  /// In zh, this message translates to:
  /// **'已结束'**
  String get ended;

  /// No description provided for @endPollButton.
  ///
  /// In zh, this message translates to:
  /// **'结束投票'**
  String get endPollButton;

  /// No description provided for @createPoll.
  ///
  /// In zh, this message translates to:
  /// **'创建投票'**
  String get createPoll;

  /// No description provided for @pollQuestion.
  ///
  /// In zh, this message translates to:
  /// **'投票问题'**
  String get pollQuestion;

  /// No description provided for @pollOptions.
  ///
  /// In zh, this message translates to:
  /// **'投票选项'**
  String get pollOptions;

  /// No description provided for @optionPlaceholder.
  ///
  /// In zh, this message translates to:
  /// **'选项 {index}'**
  String optionPlaceholder(int index);

  /// No description provided for @addOption.
  ///
  /// In zh, this message translates to:
  /// **'添加选项'**
  String get addOption;

  /// No description provided for @pollSettings.
  ///
  /// In zh, this message translates to:
  /// **'投票设置'**
  String get pollSettings;

  /// No description provided for @anonymousPoll.
  ///
  /// In zh, this message translates to:
  /// **'匿名投票'**
  String get anonymousPoll;

  /// No description provided for @pollHint.
  ///
  /// In zh, this message translates to:
  /// **'投票发起后将显示在聊天中，群成员可以参与投票'**
  String get pollHint;

  /// No description provided for @searchSongOrArtist.
  ///
  /// In zh, this message translates to:
  /// **'搜索歌曲或歌手'**
  String get searchSongOrArtist;

  /// No description provided for @noSongsFound.
  ///
  /// In zh, this message translates to:
  /// **'没有找到歌曲'**
  String get noSongsFound;

  /// No description provided for @supportedMusicPlatforms.
  ///
  /// In zh, this message translates to:
  /// **'支持网易云、QQ音乐、酷狗、酷我等平台的歌曲链接'**
  String get supportedMusicPlatforms;

  /// No description provided for @songNameOptional.
  ///
  /// In zh, this message translates to:
  /// **'歌曲名称（可选）'**
  String get songNameOptional;

  /// No description provided for @enterSongName.
  ///
  /// In zh, this message translates to:
  /// **'输入歌曲名称'**
  String get enterSongName;

  /// No description provided for @artistNameOptional.
  ///
  /// In zh, this message translates to:
  /// **'歌手名称（可选）'**
  String get artistNameOptional;

  /// No description provided for @enterArtistName.
  ///
  /// In zh, this message translates to:
  /// **'输入歌手名称'**
  String get enterArtistName;

  /// No description provided for @shareSong.
  ///
  /// In zh, this message translates to:
  /// **'分享歌曲'**
  String get shareSong;

  /// No description provided for @realTimeLocationSharing.
  ///
  /// In zh, this message translates to:
  /// **'实时位置共享功能开发中...'**
  String get realTimeLocationSharing;

  /// No description provided for @voiceCallFeatureInDev.
  ///
  /// In zh, this message translates to:
  /// **'语音通话功能开发中...'**
  String get voiceCallFeatureInDev;

  /// No description provided for @reportFeatureInDev.
  ///
  /// In zh, this message translates to:
  /// **'举报功能开发中...'**
  String get reportFeatureInDev;

  /// No description provided for @shareFeatureInDev.
  ///
  /// In zh, this message translates to:
  /// **'分享功能开发中...'**
  String get shareFeatureInDev;

  /// No description provided for @qrCodeFeatureInDev.
  ///
  /// In zh, this message translates to:
  /// **'二维码功能开发中...'**
  String get qrCodeFeatureInDev;

  /// No description provided for @scanQrToAddMe.
  ///
  /// In zh, this message translates to:
  /// **'扫一扫上面的二维码，加我为好友'**
  String get scanQrToAddMe;

  /// No description provided for @saveToAlbum.
  ///
  /// In zh, this message translates to:
  /// **'保存到相册'**
  String get saveToAlbum;

  /// No description provided for @changeStyle.
  ///
  /// In zh, this message translates to:
  /// **'换个样式'**
  String get changeStyle;

  /// No description provided for @copyId.
  ///
  /// In zh, this message translates to:
  /// **'复制 ID'**
  String get copyId;

  /// No description provided for @idCopied.
  ///
  /// In zh, this message translates to:
  /// **'已复制用户 ID'**
  String get idCopied;

  /// No description provided for @shareFeatureComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'分享功能即将推出'**
  String get shareFeatureComingSoon;

  /// No description provided for @saveFeatureComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'保存功能即将推出'**
  String get saveFeatureComingSoon;

  /// No description provided for @moreStylesFeatureComingSoon.
  ///
  /// In zh, this message translates to:
  /// **'更多样式即将推出'**
  String get moreStylesFeatureComingSoon;

  /// No description provided for @confirmEndPoll.
  ///
  /// In zh, this message translates to:
  /// **'确定要结束这个投票吗？'**
  String get confirmEndPoll;

  /// No description provided for @cannotVoteAfterEnd.
  ///
  /// In zh, this message translates to:
  /// **'结束后将无法继续投票。'**
  String get cannotVoteAfterEnd;

  /// No description provided for @bio.
  ///
  /// In zh, this message translates to:
  /// **'个性签名'**
  String get bio;

  /// No description provided for @homeServer.
  ///
  /// In zh, this message translates to:
  /// **'服务器'**
  String get homeServer;

  /// No description provided for @shareContactCard.
  ///
  /// In zh, this message translates to:
  /// **'分享名片'**
  String get shareContactCard;

  /// No description provided for @removeFromBlacklist.
  ///
  /// In zh, this message translates to:
  /// **'移出黑名单'**
  String get removeFromBlacklist;

  /// No description provided for @confirmAddBlacklist.
  ///
  /// In zh, this message translates to:
  /// **'确定将该用户加入黑名单吗？你将不再收到对方的消息'**
  String get confirmAddBlacklist;

  /// No description provided for @confirmRemoveBlacklist.
  ///
  /// In zh, this message translates to:
  /// **'确定将该用户移出黑名单吗？'**
  String get confirmRemoveBlacklist;

  /// No description provided for @remarkSaved.
  ///
  /// In zh, this message translates to:
  /// **'备注已保存'**
  String get remarkSaved;

  /// No description provided for @remarkCleared.
  ///
  /// In zh, this message translates to:
  /// **'已清除备注'**
  String get remarkCleared;

  /// No description provided for @receive.
  ///
  /// In zh, this message translates to:
  /// **'收款'**
  String get receive;

  /// No description provided for @pleaseConnectWallet.
  ///
  /// In zh, this message translates to:
  /// **'请先连接钱包'**
  String get pleaseConnectWallet;

  /// No description provided for @sendRequest.
  ///
  /// In zh, this message translates to:
  /// **'发送请求'**
  String get sendRequest;

  /// No description provided for @pleaseEnterValidAmount.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的金额'**
  String get pleaseEnterValidAmount;

  /// No description provided for @searchPlaceholder.
  ///
  /// In zh, this message translates to:
  /// **'搜索联系人、群聊、消息'**
  String get searchPlaceholder;

  /// No description provided for @enterKeywordToSearch.
  ///
  /// In zh, this message translates to:
  /// **'输入关键词开始搜索'**
  String get enterKeywordToSearch;

  /// No description provided for @clearHistory.
  ///
  /// In zh, this message translates to:
  /// **'清除'**
  String get clearHistory;

  /// No description provided for @noResultsForQuery.
  ///
  /// In zh, this message translates to:
  /// **'没有找到\"{query}\"相关的结果'**
  String noResultsForQuery(String query);

  /// No description provided for @allResults.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get allResults;

  /// No description provided for @searchInChat.
  ///
  /// In zh, this message translates to:
  /// **'在聊天中搜索'**
  String get searchInChat;

  /// No description provided for @contactLabel.
  ///
  /// In zh, this message translates to:
  /// **'联系人'**
  String get contactLabel;

  /// No description provided for @groupLabel.
  ///
  /// In zh, this message translates to:
  /// **'群聊'**
  String get groupLabel;

  /// No description provided for @conversationLabel.
  ///
  /// In zh, this message translates to:
  /// **'会话'**
  String get conversationLabel;

  /// No description provided for @messageLabel.
  ///
  /// In zh, this message translates to:
  /// **'消息'**
  String get messageLabel;

  /// No description provided for @securityTitle.
  ///
  /// In zh, this message translates to:
  /// **'安全'**
  String get securityTitle;

  /// No description provided for @keyBackup.
  ///
  /// In zh, this message translates to:
  /// **'密钥备份'**
  String get keyBackup;

  /// No description provided for @backupEncryptionKeys.
  ///
  /// In zh, this message translates to:
  /// **'备份加密密钥'**
  String get backupEncryptionKeys;

  /// No description provided for @keysBackedUp.
  ///
  /// In zh, this message translates to:
  /// **'已备份 {count} 个密钥'**
  String keysBackedUp(int count);

  /// No description provided for @backupNotSet.
  ///
  /// In zh, this message translates to:
  /// **'未设置备份'**
  String get backupNotSet;

  /// No description provided for @restoreKeys.
  ///
  /// In zh, this message translates to:
  /// **'恢复密钥'**
  String get restoreKeys;

  /// No description provided for @restoreKeysFromBackup.
  ///
  /// In zh, this message translates to:
  /// **'从备份恢复加密密钥'**
  String get restoreKeysFromBackup;

  /// No description provided for @exportKeys.
  ///
  /// In zh, this message translates to:
  /// **'导出密钥'**
  String get exportKeys;

  /// No description provided for @exportKeysToFile.
  ///
  /// In zh, this message translates to:
  /// **'导出密钥到文件'**
  String get exportKeysToFile;

  /// No description provided for @loggedInDevices.
  ///
  /// In zh, this message translates to:
  /// **'已登录设备'**
  String get loggedInDevices;

  /// No description provided for @noOtherDevices.
  ///
  /// In zh, this message translates to:
  /// **'暂无其他设备'**
  String get noOtherDevices;

  /// No description provided for @verified.
  ///
  /// In zh, this message translates to:
  /// **'已验证'**
  String get verified;

  /// No description provided for @unverified.
  ///
  /// In zh, this message translates to:
  /// **'未验证'**
  String get unverified;

  /// No description provided for @advanced.
  ///
  /// In zh, this message translates to:
  /// **'高级'**
  String get advanced;

  /// No description provided for @crossSigning.
  ///
  /// In zh, this message translates to:
  /// **'跨设备签名'**
  String get crossSigning;

  /// No description provided for @enabled.
  ///
  /// In zh, this message translates to:
  /// **'已启用'**
  String get enabled;

  /// No description provided for @notEnabled.
  ///
  /// In zh, this message translates to:
  /// **'未启用'**
  String get notEnabled;

  /// No description provided for @resetEncryption.
  ///
  /// In zh, this message translates to:
  /// **'重置加密'**
  String get resetEncryption;

  /// No description provided for @deleteAllEncryptionKeys.
  ///
  /// In zh, this message translates to:
  /// **'删除所有加密密钥'**
  String get deleteAllEncryptionKeys;

  /// No description provided for @encryptionNotSupported.
  ///
  /// In zh, this message translates to:
  /// **'不支持加密'**
  String get encryptionNotSupported;

  /// No description provided for @notInitialized.
  ///
  /// In zh, this message translates to:
  /// **'未初始化'**
  String get notInitialized;

  /// No description provided for @backupKeyTitle.
  ///
  /// In zh, this message translates to:
  /// **'备份密钥'**
  String get backupKeyTitle;

  /// No description provided for @backupKeyMessage.
  ///
  /// In zh, this message translates to:
  /// **'是否创建新的密钥备份？这将帮助您在新设备上恢复加密消息。'**
  String get backupKeyMessage;

  /// No description provided for @backup.
  ///
  /// In zh, this message translates to:
  /// **'备份'**
  String get backup;

  /// No description provided for @restoreKeyTitle.
  ///
  /// In zh, this message translates to:
  /// **'恢复密钥'**
  String get restoreKeyTitle;

  /// No description provided for @restoreKeyMessage.
  ///
  /// In zh, this message translates to:
  /// **'输入您的恢复密码或恢复密钥来恢复加密消息。'**
  String get restoreKeyMessage;

  /// No description provided for @restore.
  ///
  /// In zh, this message translates to:
  /// **'恢复'**
  String get restore;

  /// No description provided for @exportKeyTitle.
  ///
  /// In zh, this message translates to:
  /// **'导出密钥'**
  String get exportKeyTitle;

  /// No description provided for @exportKeyMessage.
  ///
  /// In zh, this message translates to:
  /// **'导出的密钥文件包含您的所有加密密钥，请妥善保管。'**
  String get exportKeyMessage;

  /// No description provided for @export.
  ///
  /// In zh, this message translates to:
  /// **'导出'**
  String get export;

  /// No description provided for @deviceIdLabel.
  ///
  /// In zh, this message translates to:
  /// **'设备ID: {deviceId}'**
  String deviceIdLabel(String deviceId);

  /// No description provided for @deviceStatusVerified.
  ///
  /// In zh, this message translates to:
  /// **'状态: 已验证'**
  String get deviceStatusVerified;

  /// No description provided for @deviceStatusUnverified.
  ///
  /// In zh, this message translates to:
  /// **'状态: 未验证'**
  String get deviceStatusUnverified;

  /// No description provided for @lastActiveLabel.
  ///
  /// In zh, this message translates to:
  /// **'最后活跃: {lastSeen}'**
  String lastActiveLabel(String lastSeen);

  /// No description provided for @verifyThisDevice.
  ///
  /// In zh, this message translates to:
  /// **'验证此设备'**
  String get verifyThisDevice;

  /// No description provided for @crossSigningAlreadyEnabled.
  ///
  /// In zh, this message translates to:
  /// **'跨设备签名已启用'**
  String get crossSigningAlreadyEnabled;

  /// No description provided for @crossSigningSetupSuccess.
  ///
  /// In zh, this message translates to:
  /// **'跨设备签名设置成功'**
  String get crossSigningSetupSuccess;

  /// No description provided for @resetEncryptionTitle.
  ///
  /// In zh, this message translates to:
  /// **'重置加密'**
  String get resetEncryptionTitle;

  /// No description provided for @resetEncryptionWarning.
  ///
  /// In zh, this message translates to:
  /// **'警告：这将删除您所有的加密密钥。您将无法解密之前的加密消息。此操作不可撤销。'**
  String get resetEncryptionWarning;

  /// No description provided for @reset.
  ///
  /// In zh, this message translates to:
  /// **'重置'**
  String get reset;

  /// No description provided for @leaveMeetingConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要离开会议吗？'**
  String get leaveMeetingConfirm;

  /// No description provided for @pokedSomeone.
  ///
  /// In zh, this message translates to:
  /// **'拍了拍「{name}」{suffix}'**
  String pokedSomeone(String name, String suffix);

  /// No description provided for @noContactsToAdd.
  ///
  /// In zh, this message translates to:
  /// **'没有可添加的联系人'**
  String get noContactsToAdd;

  /// No description provided for @addMembers.
  ///
  /// In zh, this message translates to:
  /// **'添加成员'**
  String get addMembers;

  /// No description provided for @invitedMembers.
  ///
  /// In zh, this message translates to:
  /// **'已邀请 {count} 位成员'**
  String invitedMembers(int count);

  /// No description provided for @inviteFailed.
  ///
  /// In zh, this message translates to:
  /// **'邀请失败: {error}'**
  String inviteFailed(String error);

  /// No description provided for @memberRemoved.
  ///
  /// In zh, this message translates to:
  /// **'已移除成员'**
  String get memberRemoved;

  /// No description provided for @removeFailed.
  ///
  /// In zh, this message translates to:
  /// **'移除失败: {error}'**
  String removeFailed(String error);

  /// No description provided for @realTimeLocationShareMessage.
  ///
  /// In zh, this message translates to:
  /// **'开始共享后，对方将能看到你的实时位置，共享时长为1小时。'**
  String get realTimeLocationShareMessage;

  /// No description provided for @startSharing.
  ///
  /// In zh, this message translates to:
  /// **'开始共享'**
  String get startSharing;

  /// No description provided for @locationServiceNotEnabled.
  ///
  /// In zh, this message translates to:
  /// **'位置服务未开启'**
  String get locationServiceNotEnabled;

  /// No description provided for @enableLocationService.
  ///
  /// In zh, this message translates to:
  /// **'请开启位置服务以使用位置功能'**
  String get enableLocationService;

  /// No description provided for @goToSettings.
  ///
  /// In zh, this message translates to:
  /// **'去设置'**
  String get goToSettings;

  /// No description provided for @locationPermissionRequired.
  ///
  /// In zh, this message translates to:
  /// **'需要位置权限才能使用此功能'**
  String get locationPermissionRequired;

  /// No description provided for @locationPermissionDeniedPermanent.
  ///
  /// In zh, this message translates to:
  /// **'位置权限已被永久拒绝，请在设置中开启'**
  String get locationPermissionDeniedPermanent;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In zh, this message translates to:
  /// **'位置权限被拒绝'**
  String get locationPermissionDenied;

  /// No description provided for @gettingLocation.
  ///
  /// In zh, this message translates to:
  /// **'正在获取位置...'**
  String get gettingLocation;

  /// No description provided for @getLocationFailed.
  ///
  /// In zh, this message translates to:
  /// **'获取位置失败: {error}'**
  String getLocationFailed(String error);

  /// No description provided for @currentLocation.
  ///
  /// In zh, this message translates to:
  /// **'当前位置'**
  String get currentLocation;

  /// No description provided for @nearbyPlace.
  ///
  /// In zh, this message translates to:
  /// **'附近地点 {index}'**
  String nearbyPlace(int index);

  /// No description provided for @approximateDistance.
  ///
  /// In zh, this message translates to:
  /// **'约 {distance}'**
  String approximateDistance(String distance);

  /// No description provided for @mapPreview.
  ///
  /// In zh, this message translates to:
  /// **'地图预览'**
  String get mapPreview;

  /// No description provided for @searchLocation.
  ///
  /// In zh, this message translates to:
  /// **'搜索地点'**
  String get searchLocation;

  /// No description provided for @redPacketSent.
  ///
  /// In zh, this message translates to:
  /// **'已发送 {amount} {token} 红包'**
  String redPacketSent(String amount, String token);

  /// No description provided for @transferDefault.
  ///
  /// In zh, this message translates to:
  /// **'转账'**
  String get transferDefault;

  /// No description provided for @transferSent.
  ///
  /// In zh, this message translates to:
  /// **'已发送 {amount} {token} 转账'**
  String transferSent(String amount, String token);

  /// No description provided for @pickFileFailed.
  ///
  /// In zh, this message translates to:
  /// **'选择文件失败: {error}'**
  String pickFileFailed(String error);

  /// No description provided for @fileSizeLimit.
  ///
  /// In zh, this message translates to:
  /// **'文件大小不能超过 50MB'**
  String get fileSizeLimit;

  /// No description provided for @fileSending.
  ///
  /// In zh, this message translates to:
  /// **'文件发送中: {filename}'**
  String fileSending(String filename);

  /// No description provided for @sendFileFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送文件失败: {error}'**
  String sendFileFailed(String error);

  /// No description provided for @contactCardSent.
  ///
  /// In zh, this message translates to:
  /// **'已发送 {name} 的名片'**
  String contactCardSent(String name);

  /// No description provided for @favoritesFeature.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get favoritesFeature;

  /// No description provided for @couponsFeature.
  ///
  /// In zh, this message translates to:
  /// **'卡券'**
  String get couponsFeature;

  /// No description provided for @giftFeature.
  ///
  /// In zh, this message translates to:
  /// **'礼物'**
  String get giftFeature;

  /// No description provided for @sharedMusic.
  ///
  /// In zh, this message translates to:
  /// **'已分享 {name}'**
  String sharedMusic(String name);

  /// No description provided for @endPollTitle.
  ///
  /// In zh, this message translates to:
  /// **'结束投票'**
  String get endPollTitle;

  /// No description provided for @endPollConfirmMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要结束这个投票吗？结束后将无法继续投票。'**
  String get endPollConfirmMessage;

  /// No description provided for @pollEndedMessage.
  ///
  /// In zh, this message translates to:
  /// **'投票已结束'**
  String get pollEndedMessage;

  /// No description provided for @connectingCall.
  ///
  /// In zh, this message translates to:
  /// **'正在连接...'**
  String get connectingCall;

  /// No description provided for @muteCall.
  ///
  /// In zh, this message translates to:
  /// **'静音'**
  String get muteCall;

  /// No description provided for @speakerOff.
  ///
  /// In zh, this message translates to:
  /// **'关闭免提'**
  String get speakerOff;

  /// No description provided for @speakerOn.
  ///
  /// In zh, this message translates to:
  /// **'免提'**
  String get speakerOn;

  /// No description provided for @cameraOn.
  ///
  /// In zh, this message translates to:
  /// **'开启摄像头'**
  String get cameraOn;

  /// No description provided for @cameraOff.
  ///
  /// In zh, this message translates to:
  /// **'关闭摄像头'**
  String get cameraOff;

  /// No description provided for @hangUp.
  ///
  /// In zh, this message translates to:
  /// **'挂断'**
  String get hangUp;

  /// No description provided for @selectForwardTargetTitle.
  ///
  /// In zh, this message translates to:
  /// **'选择转发对象'**
  String get selectForwardTargetTitle;

  /// No description provided for @noForwardableChat.
  ///
  /// In zh, this message translates to:
  /// **'没有可转发的会话'**
  String get noForwardableChat;

  /// No description provided for @noMatchingChat.
  ///
  /// In zh, this message translates to:
  /// **'没有找到相关会话'**
  String get noMatchingChat;

  /// No description provided for @imagePreview.
  ///
  /// In zh, this message translates to:
  /// **'[图片]'**
  String get imagePreview;

  /// No description provided for @voicePreview.
  ///
  /// In zh, this message translates to:
  /// **'[语音]'**
  String get voicePreview;

  /// No description provided for @videoPreview.
  ///
  /// In zh, this message translates to:
  /// **'[视频]'**
  String get videoPreview;

  /// No description provided for @filePreviewWithName.
  ///
  /// In zh, this message translates to:
  /// **'[文件] {filename}'**
  String filePreviewWithName(String filename);

  /// No description provided for @locationPreviewWithAddress.
  ///
  /// In zh, this message translates to:
  /// **'[位置] {address}'**
  String locationPreviewWithAddress(String address);

  /// No description provided for @musicPreviewWithTitle.
  ///
  /// In zh, this message translates to:
  /// **'[音乐] {title}'**
  String musicPreviewWithTitle(String title);

  /// No description provided for @messagePreview.
  ///
  /// In zh, this message translates to:
  /// **'[消息]'**
  String get messagePreview;

  /// No description provided for @locationTitle.
  ///
  /// In zh, this message translates to:
  /// **'位置'**
  String get locationTitle;

  /// No description provided for @sendButton.
  ///
  /// In zh, this message translates to:
  /// **'发送'**
  String get sendButton;

  /// No description provided for @retryButton.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get retryButton;

  /// No description provided for @selectContact.
  ///
  /// In zh, this message translates to:
  /// **'选择联系人'**
  String get selectContact;

  /// No description provided for @searchContactHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索联系人'**
  String get searchContactHint;

  /// No description provided for @shareMusic.
  ///
  /// In zh, this message translates to:
  /// **'分享音乐'**
  String get shareMusic;

  /// No description provided for @recentPlayed.
  ///
  /// In zh, this message translates to:
  /// **'最近播放'**
  String get recentPlayed;

  /// No description provided for @myFavorites.
  ///
  /// In zh, this message translates to:
  /// **'我喜欢'**
  String get myFavorites;

  /// No description provided for @networkLink.
  ///
  /// In zh, this message translates to:
  /// **'网络链接'**
  String get networkLink;

  /// No description provided for @localFile.
  ///
  /// In zh, this message translates to:
  /// **'本地文件'**
  String get localFile;

  /// No description provided for @musicLinkRequired.
  ///
  /// In zh, this message translates to:
  /// **'音乐链接 *'**
  String get musicLinkRequired;

  /// No description provided for @pasteMusicLink.
  ///
  /// In zh, this message translates to:
  /// **'粘贴音乐链接'**
  String get pasteMusicLink;

  /// No description provided for @enterSongNamePlaceholder.
  ///
  /// In zh, this message translates to:
  /// **'输入歌曲名称'**
  String get enterSongNamePlaceholder;

  /// No description provided for @enterArtistNamePlaceholder.
  ///
  /// In zh, this message translates to:
  /// **'输入歌手名称'**
  String get enterArtistNamePlaceholder;

  /// No description provided for @shareMusicButton.
  ///
  /// In zh, this message translates to:
  /// **'分享音乐'**
  String get shareMusicButton;

  /// No description provided for @selectLocalAudio.
  ///
  /// In zh, this message translates to:
  /// **'选择本地音频文件'**
  String get selectLocalAudio;

  /// No description provided for @supportedAudioFormats.
  ///
  /// In zh, this message translates to:
  /// **'支持 MP3、M4A、WAV、FLAC 等格式'**
  String get supportedAudioFormats;

  /// No description provided for @selectFileButton.
  ///
  /// In zh, this message translates to:
  /// **'选择文件'**
  String get selectFileButton;

  /// No description provided for @pleaseEnterMusicLink.
  ///
  /// In zh, this message translates to:
  /// **'请输入音乐链接'**
  String get pleaseEnterMusicLink;

  /// No description provided for @pleaseEnterValidLink.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的网络链接'**
  String get pleaseEnterValidLink;

  /// No description provided for @sharedSong.
  ///
  /// In zh, this message translates to:
  /// **'分享歌曲'**
  String get sharedSong;

  /// No description provided for @selectMember.
  ///
  /// In zh, this message translates to:
  /// **'选择成员'**
  String get selectMember;

  /// No description provided for @searchMemberHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索成员'**
  String get searchMemberHint;

  /// No description provided for @noMatchingMembers.
  ///
  /// In zh, this message translates to:
  /// **'未找到匹配的成员'**
  String get noMatchingMembers;

  /// No description provided for @unknownMember.
  ///
  /// In zh, this message translates to:
  /// **'未知'**
  String get unknownMember;

  /// No description provided for @selectedMessagesCount.
  ///
  /// In zh, this message translates to:
  /// **'已选择 {count} 条消息'**
  String selectedMessagesCount(int count);

  /// No description provided for @searchContactsOrGroups.
  ///
  /// In zh, this message translates to:
  /// **'搜索联系人或群聊'**
  String get searchContactsOrGroups;

  /// No description provided for @noMatchingConversations.
  ///
  /// In zh, this message translates to:
  /// **'未找到匹配的会话'**
  String get noMatchingConversations;

  /// No description provided for @videoTitle.
  ///
  /// In zh, this message translates to:
  /// **'视频'**
  String get videoTitle;

  /// No description provided for @loadingText.
  ///
  /// In zh, this message translates to:
  /// **'加载中...'**
  String get loadingText;

  /// No description provided for @videoPlaybackFailed.
  ///
  /// In zh, this message translates to:
  /// **'视频播放失败'**
  String get videoPlaybackFailed;

  /// No description provided for @videoLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'视频加载失败'**
  String get videoLoadFailed;

  /// No description provided for @playerInitFailed.
  ///
  /// In zh, this message translates to:
  /// **'播放器初始化失败'**
  String get playerInitFailed;

  /// No description provided for @createPollTitle.
  ///
  /// In zh, this message translates to:
  /// **'创建投票'**
  String get createPollTitle;

  /// No description provided for @submitPoll.
  ///
  /// In zh, this message translates to:
  /// **'发起'**
  String get submitPoll;

  /// No description provided for @pollQuestionLabel.
  ///
  /// In zh, this message translates to:
  /// **'投票问题'**
  String get pollQuestionLabel;

  /// No description provided for @enterPollQuestionHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入投票问题'**
  String get enterPollQuestionHint;

  /// No description provided for @pollOptionsLabel.
  ///
  /// In zh, this message translates to:
  /// **'投票选项'**
  String get pollOptionsLabel;

  /// No description provided for @optionHintWithIndex.
  ///
  /// In zh, this message translates to:
  /// **'选项 {index}'**
  String optionHintWithIndex(int index);

  /// No description provided for @addOptionButton.
  ///
  /// In zh, this message translates to:
  /// **'添加选项'**
  String get addOptionButton;

  /// No description provided for @pollSettingsLabel.
  ///
  /// In zh, this message translates to:
  /// **'投票设置'**
  String get pollSettingsLabel;

  /// No description provided for @selectionType.
  ///
  /// In zh, this message translates to:
  /// **'选择类型'**
  String get selectionType;

  /// No description provided for @singleChoiceLabel.
  ///
  /// In zh, this message translates to:
  /// **'单选'**
  String get singleChoiceLabel;

  /// No description provided for @multiChoiceLabel.
  ///
  /// In zh, this message translates to:
  /// **'多选'**
  String get multiChoiceLabel;

  /// No description provided for @anonymousPollSwitch.
  ///
  /// In zh, this message translates to:
  /// **'匿名投票'**
  String get anonymousPollSwitch;

  /// No description provided for @pleaseEnterQuestion.
  ///
  /// In zh, this message translates to:
  /// **'请输入投票问题'**
  String get pleaseEnterQuestion;

  /// No description provided for @atLeastTwoOptions.
  ///
  /// In zh, this message translates to:
  /// **'至少需要2个选项'**
  String get atLeastTwoOptions;

  /// No description provided for @confirmWithCount.
  ///
  /// In zh, this message translates to:
  /// **'确定 ({count})'**
  String confirmWithCount(int count);

  /// No description provided for @emailVerificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'邮箱验证'**
  String get emailVerificationTitle;

  /// No description provided for @enterValidEmailAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的邮箱地址'**
  String get enterValidEmailAddress;

  /// No description provided for @verificationCodeSentTo.
  ///
  /// In zh, this message translates to:
  /// **'验证码已发送到 {email}'**
  String verificationCodeSentTo(String email);

  /// No description provided for @sendCodeFailed.
  ///
  /// In zh, this message translates to:
  /// **'发送验证码失败: {error}'**
  String sendCodeFailed(String error);

  /// No description provided for @verificationSuccess.
  ///
  /// In zh, this message translates to:
  /// **'验证成功'**
  String get verificationSuccess;

  /// No description provided for @verificationFailed.
  ///
  /// In zh, this message translates to:
  /// **'验证失败'**
  String get verificationFailed;

  /// No description provided for @verificationCodeError.
  ///
  /// In zh, this message translates to:
  /// **'验证码错误: {error}'**
  String verificationCodeError(String error);

  /// No description provided for @enterVerificationCode.
  ///
  /// In zh, this message translates to:
  /// **'输入验证码'**
  String get enterVerificationCode;

  /// No description provided for @enterYourEmail.
  ///
  /// In zh, this message translates to:
  /// **'输入邮箱'**
  String get enterYourEmail;

  /// No description provided for @weSentCodeTo.
  ///
  /// In zh, this message translates to:
  /// **'我们已向 {email} 发送了\n6位验证码'**
  String weSentCodeTo(String email);

  /// No description provided for @enterEmailForCode.
  ///
  /// In zh, this message translates to:
  /// **'输入您的邮箱地址，我们将发送验证码'**
  String get enterEmailForCode;

  /// No description provided for @sendVerificationCode.
  ///
  /// In zh, this message translates to:
  /// **'发送验证码'**
  String get sendVerificationCode;

  /// No description provided for @resendVerificationCode.
  ///
  /// In zh, this message translates to:
  /// **'重新发送验证码'**
  String get resendVerificationCode;

  /// No description provided for @canResendAfter.
  ///
  /// In zh, this message translates to:
  /// **'{seconds}秒后可重新发送'**
  String canResendAfter(int seconds);

  /// No description provided for @changeEmail.
  ///
  /// In zh, this message translates to:
  /// **'更换邮箱'**
  String get changeEmail;

  /// No description provided for @addToContacts.
  ///
  /// In zh, this message translates to:
  /// **'添加到通讯录'**
  String get addToContacts;

  /// No description provided for @addingToContacts.
  ///
  /// In zh, this message translates to:
  /// **'添加中...'**
  String get addingToContacts;

  /// No description provided for @addedToContacts.
  ///
  /// In zh, this message translates to:
  /// **'已添加到通讯录'**
  String get addedToContacts;

  /// No description provided for @addFailedWithError.
  ///
  /// In zh, this message translates to:
  /// **'添加失败: {error}'**
  String addFailedWithError(String error);

  /// No description provided for @addPhone.
  ///
  /// In zh, this message translates to:
  /// **'添加电话'**
  String get addPhone;

  /// No description provided for @addTag.
  ///
  /// In zh, this message translates to:
  /// **'添加标签'**
  String get addTag;

  /// No description provided for @addText.
  ///
  /// In zh, this message translates to:
  /// **'添加文字'**
  String get addText;

  /// No description provided for @addPhoto.
  ///
  /// In zh, this message translates to:
  /// **'添加照片'**
  String get addPhoto;

  /// No description provided for @groupCountLabel.
  ///
  /// In zh, this message translates to:
  /// **'{count}个'**
  String groupCountLabel(int count);

  /// No description provided for @addedViaSearch.
  ///
  /// In zh, this message translates to:
  /// **'通过搜索添加'**
  String get addedViaSearch;

  /// No description provided for @addTime.
  ///
  /// In zh, this message translates to:
  /// **'添加时间'**
  String get addTime;

  /// No description provided for @doneButton.
  ///
  /// In zh, this message translates to:
  /// **'完成'**
  String get doneButton;

  /// No description provided for @waitingForParticipants.
  ///
  /// In zh, this message translates to:
  /// **'等待参与者加入...'**
  String get waitingForParticipants;

  /// No description provided for @participantMe.
  ///
  /// In zh, this message translates to:
  /// **'{name}（我）'**
  String participantMe(String name);

  /// No description provided for @sharingLabel.
  ///
  /// In zh, this message translates to:
  /// **'共享中'**
  String get sharingLabel;

  /// No description provided for @screenSharingBy.
  ///
  /// In zh, this message translates to:
  /// **'{name} 正在共享屏幕'**
  String screenSharingBy(String name);

  /// No description provided for @participantCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人'**
  String participantCount(int count);

  /// No description provided for @muteLabel.
  ///
  /// In zh, this message translates to:
  /// **'静音'**
  String get muteLabel;

  /// No description provided for @unmuteLabel.
  ///
  /// In zh, this message translates to:
  /// **'解除静音'**
  String get unmuteLabel;

  /// No description provided for @turnOffVideo.
  ///
  /// In zh, this message translates to:
  /// **'关闭视频'**
  String get turnOffVideo;

  /// No description provided for @turnOnVideo.
  ///
  /// In zh, this message translates to:
  /// **'开启视频'**
  String get turnOnVideo;

  /// No description provided for @shareScreen.
  ///
  /// In zh, this message translates to:
  /// **'共享屏幕'**
  String get shareScreen;

  /// No description provided for @stopSharing.
  ///
  /// In zh, this message translates to:
  /// **'停止共享'**
  String get stopSharing;

  /// No description provided for @switchCameraLabel.
  ///
  /// In zh, this message translates to:
  /// **'切换'**
  String get switchCameraLabel;

  /// No description provided for @leaveLabel.
  ///
  /// In zh, this message translates to:
  /// **'离开'**
  String get leaveLabel;

  /// No description provided for @participantsLabel.
  ///
  /// In zh, this message translates to:
  /// **'参与者'**
  String get participantsLabel;

  /// No description provided for @joiningMeeting.
  ///
  /// In zh, this message translates to:
  /// **'正在加入会议...'**
  String get joiningMeeting;

  /// No description provided for @pollVotesFormat.
  ///
  /// In zh, this message translates to:
  /// **'{count} 票 ({percentage}%)'**
  String pollVotesFormat(int count, String percentage);

  /// No description provided for @pollParticipantsFormat.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人参与'**
  String pollParticipantsFormat(int count);

  /// No description provided for @tapToRetry.
  ///
  /// In zh, this message translates to:
  /// **'点击重试'**
  String get tapToRetry;

  /// No description provided for @noConversationsToForward.
  ///
  /// In zh, this message translates to:
  /// **'没有可转发的会话'**
  String get noConversationsToForward;

  /// No description provided for @defaultRedPacketGreeting.
  ///
  /// In zh, this message translates to:
  /// **'恭喜发财，大吉大利'**
  String get defaultRedPacketGreeting;

  /// No description provided for @emojiCategoryFace.
  ///
  /// In zh, this message translates to:
  /// **'表情'**
  String get emojiCategoryFace;

  /// No description provided for @emojiCategoryHeart.
  ///
  /// In zh, this message translates to:
  /// **'爱心'**
  String get emojiCategoryHeart;

  /// No description provided for @emojiCategoryAnimal.
  ///
  /// In zh, this message translates to:
  /// **'动物'**
  String get emojiCategoryAnimal;

  /// No description provided for @emojiCategoryFood.
  ///
  /// In zh, this message translates to:
  /// **'食物'**
  String get emojiCategoryFood;

  /// No description provided for @emojiCategoryTransport.
  ///
  /// In zh, this message translates to:
  /// **'交通'**
  String get emojiCategoryTransport;

  /// No description provided for @emojiCategoryActivity.
  ///
  /// In zh, this message translates to:
  /// **'活动'**
  String get emojiCategoryActivity;

  /// No description provided for @emojiCategoryObject.
  ///
  /// In zh, this message translates to:
  /// **'物品'**
  String get emojiCategoryObject;

  /// No description provided for @emojiCategorySymbol.
  ///
  /// In zh, this message translates to:
  /// **'符号'**
  String get emojiCategorySymbol;

  /// No description provided for @allowOthersToSearchAndJoin.
  ///
  /// In zh, this message translates to:
  /// **'允许他人搜索并加入'**
  String get allowOthersToSearchAndJoin;

  /// No description provided for @allowStrangerMessages.
  ///
  /// In zh, this message translates to:
  /// **'允许陌生人消息'**
  String get allowStrangerMessages;

  /// No description provided for @alwaysUseDarkTheme.
  ///
  /// In zh, this message translates to:
  /// **'始终使用深色主题'**
  String get alwaysUseDarkTheme;

  /// No description provided for @alwaysUseLightTheme.
  ///
  /// In zh, this message translates to:
  /// **'始终使用浅色主题'**
  String get alwaysUseLightTheme;

  /// No description provided for @autoSwitchBySystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统自动切换'**
  String get autoSwitchBySystem;

  /// No description provided for @bubbleStyle.
  ///
  /// In zh, this message translates to:
  /// **'气泡样式'**
  String get bubbleStyle;

  /// No description provided for @bubbleStyleClassic.
  ///
  /// In zh, this message translates to:
  /// **'经典样式'**
  String get bubbleStyleClassic;

  /// No description provided for @bubbleStyleClassicDesc.
  ///
  /// In zh, this message translates to:
  /// **'传统的气泡样式'**
  String get bubbleStyleClassicDesc;

  /// No description provided for @bubbleStyleModern.
  ///
  /// In zh, this message translates to:
  /// **'现代样式'**
  String get bubbleStyleModern;

  /// No description provided for @bubbleStyleModernDesc.
  ///
  /// In zh, this message translates to:
  /// **'简洁的现代气泡样式'**
  String get bubbleStyleModernDesc;

  /// No description provided for @bubbleStyleWechat.
  ///
  /// In zh, this message translates to:
  /// **'微信样式'**
  String get bubbleStyleWechat;

  /// No description provided for @bubbleStyleWechatDesc.
  ///
  /// In zh, this message translates to:
  /// **'经典微信气泡样式'**
  String get bubbleStyleWechatDesc;

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

  /// No description provided for @checkForUpdates.
  ///
  /// In zh, this message translates to:
  /// **'检查更新'**
  String get checkForUpdates;

  /// No description provided for @confirmClearChatHistory.
  ///
  /// In zh, this message translates to:
  /// **'确定要清空聊天记录吗？'**
  String get confirmClearChatHistory;

  /// No description provided for @createGroupToChat.
  ///
  /// In zh, this message translates to:
  /// **'创建群聊以开始聊天'**
  String get createGroupToChat;

  /// No description provided for @darkMode.
  ///
  /// In zh, this message translates to:
  /// **'深色模式'**
  String get darkMode;

  /// No description provided for @darkModeOption.
  ///
  /// In zh, this message translates to:
  /// **'深色模式选项'**
  String get darkModeOption;

  /// No description provided for @doNotDisturbDescription.
  ///
  /// In zh, this message translates to:
  /// **'在指定时间内不接收通知'**
  String get doNotDisturbDescription;

  /// No description provided for @doNotDisturbMode.
  ///
  /// In zh, this message translates to:
  /// **'勿扰模式'**
  String get doNotDisturbMode;

  /// No description provided for @editGroupAnnouncement.
  ///
  /// In zh, this message translates to:
  /// **'编辑群公告'**
  String get editGroupAnnouncement;

  /// No description provided for @editGroupDescription.
  ///
  /// In zh, this message translates to:
  /// **'编辑群描述'**
  String get editGroupDescription;

  /// No description provided for @enterGroupAnnouncement.
  ///
  /// In zh, this message translates to:
  /// **'请输入群公告'**
  String get enterGroupAnnouncement;

  /// No description provided for @errorWithMessage.
  ///
  /// In zh, this message translates to:
  /// **'错误: {message}'**
  String errorWithMessage(String message);

  /// No description provided for @feedbackAndSuggestions.
  ///
  /// In zh, this message translates to:
  /// **'反馈与建议'**
  String get feedbackAndSuggestions;

  /// No description provided for @followSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get followSystem;

  /// No description provided for @fontSize.
  ///
  /// In zh, this message translates to:
  /// **'字体大小'**
  String get fontSize;

  /// No description provided for @fontSizeExtraLarge.
  ///
  /// In zh, this message translates to:
  /// **'特大'**
  String get fontSizeExtraLarge;

  /// No description provided for @fontSizeLarge.
  ///
  /// In zh, this message translates to:
  /// **'大'**
  String get fontSizeLarge;

  /// No description provided for @fontSizeSmall.
  ///
  /// In zh, this message translates to:
  /// **'小'**
  String get fontSizeSmall;

  /// No description provided for @fontSizeStandard.
  ///
  /// In zh, this message translates to:
  /// **'标准'**
  String get fontSizeStandard;

  /// No description provided for @incomingVideoCall.
  ///
  /// In zh, this message translates to:
  /// **'视频来电'**
  String get incomingVideoCall;

  /// No description provided for @incomingVoiceCall.
  ///
  /// In zh, this message translates to:
  /// **'语音来电'**
  String get incomingVoiceCall;

  /// No description provided for @letOthersKnowYouRead.
  ///
  /// In zh, this message translates to:
  /// **'让对方知道你已读'**
  String get letOthersKnowYouRead;

  /// No description provided for @letOthersKnowYouTyping.
  ///
  /// In zh, this message translates to:
  /// **'让对方知道你正在输入'**
  String get letOthersKnowYouTyping;

  /// No description provided for @lightMode.
  ///
  /// In zh, this message translates to:
  /// **'浅色模式'**
  String get lightMode;

  /// No description provided for @memberCountClickToCopy.
  ///
  /// In zh, this message translates to:
  /// **'{count}人，点击复制群ID'**
  String memberCountClickToCopy(int count);

  /// No description provided for @messageNotifications.
  ///
  /// In zh, this message translates to:
  /// **'消息通知'**
  String get messageNotifications;

  /// No description provided for @messagesLabel.
  ///
  /// In zh, this message translates to:
  /// **'消息'**
  String get messagesLabel;

  /// No description provided for @musicLinkLabel.
  ///
  /// In zh, this message translates to:
  /// **'音乐链接'**
  String get musicLinkLabel;

  /// No description provided for @noMediaUrlAvailable.
  ///
  /// In zh, this message translates to:
  /// **'没有可用的媒体链接'**
  String get noMediaUrlAvailable;

  /// No description provided for @noPermissionToEditGroupName.
  ///
  /// In zh, this message translates to:
  /// **'你没有权限修改群名称'**
  String get noPermissionToEditGroupName;

  /// No description provided for @receiveMessagesFromNonContacts.
  ///
  /// In zh, this message translates to:
  /// **'接收非联系人的消息'**
  String get receiveMessagesFromNonContacts;

  /// No description provided for @receiveNewMessageNotifications.
  ///
  /// In zh, this message translates to:
  /// **'接收新消息通知'**
  String get receiveNewMessageNotifications;

  /// No description provided for @reconnectingCall.
  ///
  /// In zh, this message translates to:
  /// **'正在重连...'**
  String get reconnectingCall;

  /// No description provided for @redPacketTransferCannotForward.
  ///
  /// In zh, this message translates to:
  /// **'红包和转账消息无法转发'**
  String get redPacketTransferCannotForward;

  /// No description provided for @showMessageContentInNotification.
  ///
  /// In zh, this message translates to:
  /// **'在通知中显示消息内容'**
  String get showMessageContentInNotification;

  /// No description provided for @showMessagePreview.
  ///
  /// In zh, this message translates to:
  /// **'显示消息预览'**
  String get showMessagePreview;

  /// No description provided for @typingIndicator.
  ///
  /// In zh, this message translates to:
  /// **'输入状态指示'**
  String get typingIndicator;

  /// No description provided for @versionInfo.
  ///
  /// In zh, this message translates to:
  /// **'版本 {version}'**
  String versionInfo(String version);

  /// No description provided for @vibration.
  ///
  /// In zh, this message translates to:
  /// **'振动'**
  String get vibration;

  /// No description provided for @videoCallInProgress.
  ///
  /// In zh, this message translates to:
  /// **'视频通话中'**
  String get videoCallInProgress;

  /// No description provided for @voiceCallInProgress.
  ///
  /// In zh, this message translates to:
  /// **'语音通话中'**
  String get voiceCallInProgress;

  /// No description provided for @whoCanSeeTitle.
  ///
  /// In zh, this message translates to:
  /// **'谁可以看到 {title}'**
  String whoCanSeeTitle(String title);

  /// No description provided for @emailAddress.
  ///
  /// In zh, this message translates to:
  /// **'邮箱地址'**
  String get emailAddress;

  /// No description provided for @enterEmailAddress.
  ///
  /// In zh, this message translates to:
  /// **'请输入邮箱地址'**
  String get enterEmailAddress;

  /// No description provided for @emailRecoveryHint.
  ///
  /// In zh, this message translates to:
  /// **'用于找回密码'**
  String get emailRecoveryHint;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的邮箱地址'**
  String get invalidEmailFormat;

  /// No description provided for @optional.
  ///
  /// In zh, this message translates to:
  /// **'选填'**
  String get optional;

  /// No description provided for @resetPassword.
  ///
  /// In zh, this message translates to:
  /// **'重置密码'**
  String get resetPassword;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In zh, this message translates to:
  /// **'重置您的密码'**
  String get resetPasswordTitle;

  /// No description provided for @enterRegisteredEmail.
  ///
  /// In zh, this message translates to:
  /// **'请输入注册时绑定的邮箱地址'**
  String get enterRegisteredEmail;

  /// No description provided for @sendResetCode.
  ///
  /// In zh, this message translates to:
  /// **'发送重置验证码'**
  String get sendResetCode;

  /// No description provided for @resetCodeSent.
  ///
  /// In zh, this message translates to:
  /// **'重置验证码已发送至 {email}'**
  String resetCodeSent(String email);

  /// No description provided for @enterResetCode.
  ///
  /// In zh, this message translates to:
  /// **'输入重置验证码'**
  String get enterResetCode;

  /// No description provided for @setNewPassword.
  ///
  /// In zh, this message translates to:
  /// **'设置新密码'**
  String get setNewPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In zh, this message translates to:
  /// **'确认新密码'**
  String get confirmNewPassword;

  /// No description provided for @newPassword.
  ///
  /// In zh, this message translates to:
  /// **'新密码'**
  String get newPassword;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In zh, this message translates to:
  /// **'密码重置成功，请使用新密码登录'**
  String get passwordResetSuccess;

  /// No description provided for @resetPasswordFailed.
  ///
  /// In zh, this message translates to:
  /// **'重置密码失败'**
  String get resetPasswordFailed;

  /// No description provided for @changePassword.
  ///
  /// In zh, this message translates to:
  /// **'修改密码'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In zh, this message translates to:
  /// **'当前密码'**
  String get currentPassword;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In zh, this message translates to:
  /// **'请输入当前密码'**
  String get enterCurrentPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In zh, this message translates to:
  /// **'请输入新密码'**
  String get enterNewPassword;

  /// No description provided for @passwordChanged.
  ///
  /// In zh, this message translates to:
  /// **'密码修改成功，请使用新密码重新登录'**
  String get passwordChanged;

  /// No description provided for @changePasswordFailed.
  ///
  /// In zh, this message translates to:
  /// **'修改密码失败'**
  String get changePasswordFailed;

  /// No description provided for @incorrectCurrentPassword.
  ///
  /// In zh, this message translates to:
  /// **'当前密码错误'**
  String get incorrectCurrentPassword;

  /// No description provided for @newPasswordMustBeDifferent.
  ///
  /// In zh, this message translates to:
  /// **'新密码不能与当前密码相同'**
  String get newPasswordMustBeDifferent;

  /// No description provided for @changePasswordInfo.
  ///
  /// In zh, this message translates to:
  /// **'修改密码后，您将被登出，需要使用新密码重新登录。'**
  String get changePasswordInfo;

  /// No description provided for @passwordRequirements.
  ///
  /// In zh, this message translates to:
  /// **'密码要求：'**
  String get passwordRequirements;

  /// No description provided for @securityNote.
  ///
  /// In zh, this message translates to:
  /// **'为了安全，修改密码后需要在所有设备上重新登录。'**
  String get securityNote;

  /// No description provided for @security.
  ///
  /// In zh, this message translates to:
  /// **'安全'**
  String get security;

  /// No description provided for @currentBoundEmail.
  ///
  /// In zh, this message translates to:
  /// **'当前绑定邮箱'**
  String get currentBoundEmail;

  /// No description provided for @newEmailAddress.
  ///
  /// In zh, this message translates to:
  /// **'新邮箱地址'**
  String get newEmailAddress;

  /// No description provided for @enterNewEmail.
  ///
  /// In zh, this message translates to:
  /// **'请输入新邮箱地址'**
  String get enterNewEmail;

  /// No description provided for @verificationCode.
  ///
  /// In zh, this message translates to:
  /// **'验证码'**
  String get verificationCode;

  /// No description provided for @verificationCodeSent.
  ///
  /// In zh, this message translates to:
  /// **'验证码已发送'**
  String get verificationCodeSent;

  /// No description provided for @codeSentTo.
  ///
  /// In zh, this message translates to:
  /// **'验证码已发送至'**
  String get codeSentTo;

  /// No description provided for @didNotReceiveCode.
  ///
  /// In zh, this message translates to:
  /// **'没有收到验证码？'**
  String get didNotReceiveCode;

  /// No description provided for @emailChangedSuccess.
  ///
  /// In zh, this message translates to:
  /// **'邮箱修改成功'**
  String get emailChangedSuccess;

  /// No description provided for @changeEmailFailed.
  ///
  /// In zh, this message translates to:
  /// **'修改邮箱失败'**
  String get changeEmailFailed;

  /// No description provided for @emailSecurityNote.
  ///
  /// In zh, this message translates to:
  /// **'邮箱用于密码找回，请确保安全。'**
  String get emailSecurityNote;

  /// No description provided for @googleLogin.
  ///
  /// In zh, this message translates to:
  /// **'使用 Google 登录'**
  String get googleLogin;

  /// No description provided for @appleLogin.
  ///
  /// In zh, this message translates to:
  /// **'使用 Apple 登录'**
  String get appleLogin;

  /// No description provided for @socialLoginCancelled.
  ///
  /// In zh, this message translates to:
  /// **'登录已取消'**
  String get socialLoginCancelled;

  /// No description provided for @socialLoginFailed.
  ///
  /// In zh, this message translates to:
  /// **'社交登录失败'**
  String get socialLoginFailed;

  /// No description provided for @language.
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get language;

  /// No description provided for @languageChanged.
  ///
  /// In zh, this message translates to:
  /// **'语言已更改'**
  String get languageChanged;
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
        'zh'
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
      'that was used.');
}
