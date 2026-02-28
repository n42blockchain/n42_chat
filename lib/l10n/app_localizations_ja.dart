// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class SJa extends S {
  SJa([String locale = 'ja']) : super(locale);

  @override
  String get commonRetry => '再試行';

  @override
  String get commonUnknownUser => '不明なユーザー';

  @override
  String get transferWalletNotConnected => 'ウォレット未接続';

  @override
  String get chatCallServiceNotInitialized => '通話サービスが初期化されていません';

  @override
  String authLoginFailed(String error) {
    return 'ログインに失敗しました: $error';
  }

  @override
  String get chatCallBack => '折り返し電話';

  @override
  String get chatMissedVideoCall => '不在ビデオ通話';

  @override
  String get chatMissedVoiceCall => '不在音声通話';

  @override
  String get chatCallNotAnswered => '応答なし';

  @override
  String get chatCallDurationLabel => '通話時間';

  @override
  String get chatVoiceCallCancelled => '音声通話がキャンセルされました';

  @override
  String get chatVideoCallCancelled => 'ビデオ通話がキャンセルされました';

  @override
  String get commonImage => '[画像]';

  @override
  String get chatVideo => '[動画]';

  @override
  String get chatVoice => '[音声]';

  @override
  String get commonFile => '[ファイル]';

  @override
  String get chatLocation => '[位置情報]';

  @override
  String get chatUnknownMessage => '[不明なメッセージ]';

  @override
  String get commonDelete => '削除';

  @override
  String get chatDeleteThisMessage => 'このメッセージを削除しますか？';

  @override
  String get chatMessageDeleted => 'メッセージが削除されました';

  @override
  String get profileNotLoggedIn => 'ログインしていません';

  @override
  String get chatMyLocation => '現在地';

  @override
  String get commonGroupChat => 'グループチャット';

  @override
  String get commonSearch => '検索';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonLoadFailed => '読み込みに失敗しました';

  @override
  String get commonMessages => 'メッセージ';

  @override
  String get commonContacts => '連絡先';

  @override
  String get commonMe => '自分';

  @override
  String get commonVoiceLoading => '音声を読み込み中です。しばらくしてから再試行してください';

  @override
  String get commonVoiceToTextFailed => '音声のテキスト変換に失敗しました';

  @override
  String get commonConvertToText => 'テキストに変換';

  @override
  String get chatCopy => 'コピー';

  @override
  String get commonForward => '転送';

  @override
  String get commonUnfavorite => 'お気に入り解除';

  @override
  String get commonFavorite => 'お気に入り';

  @override
  String get settingsResend => '再送信';

  @override
  String get chatRecall => '取り消し';

  @override
  String get commonQuote => '引用';

  @override
  String get commonRemind => 'リマインド';

  @override
  String get chatCopied => 'コピーしました';

  @override
  String get storySendMessageHint => 'メッセージを送信';

  @override
  String get commonMicrophonePermissionRequired => 'マイクの使用を許可してください';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return '録音の開始に失敗しました: $error';
  }

  @override
  String get commonRecordingTooShort => '録音が短すぎます';

  @override
  String commonStopRecordingFailed(String error) {
    return '録音の停止に失敗しました: $error';
  }

  @override
  String get chatReleaseToCancel => '離すとキャンセル';

  @override
  String get chatReleaseToSend => '離すと送信、上にスワイプでキャンセル';

  @override
  String get commonHoldToTalk => '押し続けて話す';

  @override
  String get commonSend => '送信';

  @override
  String get commonAddFriend => '友達を追加';

  @override
  String get commonChatServiceNotConnected => 'チャットサービスに接続されていません';

  @override
  String contactUserNotFoundHint(String query) {
    return 'ユーザー「$query」が見つかりません\n\nヒント:\n• 完全なユーザーIDを入力してください（例: @username:server.com）\n• ユーザー名のスペルを確認してください';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'チャットの作成に失敗しました: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return '検索に失敗しました: $error';
  }

  @override
  String get contactEnterUserIdOrUsername => 'ユーザーIDまたはユーザー名を入力して検索';

  @override
  String get contactSearching => '検索中...';

  @override
  String get contactSearchUserToChat => 'ユーザーを検索してチャットを開始';

  @override
  String get contactMatrixIdExample =>
      '完全なMatrix IDを入力できます\n例: @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'ユーザー「$username」が見つかりません';
  }

  @override
  String get commonChat => 'チャット';

  @override
  String get commonSettings => '設定';

  @override
  String get profileEditProfile => 'プロフィールを編集';

  @override
  String get authLogin => 'ログイン';

  @override
  String get commonCreateGroup => 'グループを作成';

  @override
  String get chatError => 'エラー';

  @override
  String get commonTransfer => '送金';

  @override
  String get commonReceived => '受け取り済み';

  @override
  String get commonRefunded => '返金済み';

  @override
  String get commonExpired => '期限切れ';

  @override
  String get chatRedPacketGreeting => 'お祝いメッセージ';

  @override
  String get commonN42RedPacket => 'N42レッドパケット';

  @override
  String get commonClaimed => '受け取り済み';

  @override
  String get commonAllClaimed => 'すべて受け取り済み';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => '返信';

  @override
  String get commonEdit => '編集';

  @override
  String get chatSelectForwardTarget => '転送先を選択';

  @override
  String commonSendCount(int count) {
    return '送信 ($count)';
  }

  @override
  String contactN42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get profileN42IdTitle => 'N42 ID';

  @override
  String get profileN42Bean => 'N42ビーン';

  @override
  String get contactFriendInfo => '友達情報';

  @override
  String get contactFriendInfoDesc => '友達のメモ、電話番号、タグ、ノート、写真を追加し、権限を設定します。';

  @override
  String get commonMoments => 'モーメント';

  @override
  String get commonSendMessage => 'メッセージ';

  @override
  String get contactAudioVideoCall => '音声/ビデオ通話';

  @override
  String get contactVideoChannel => 'ビデオチャンネル';

  @override
  String get contactRemark => 'メモ';

  @override
  String get contactRemarkName => '表示名';

  @override
  String get contactPhone => '電話番号';

  @override
  String get contactTags => 'タグ';

  @override
  String get contactNotes => 'ノート';

  @override
  String get contactPhotos => '写真';

  @override
  String get contactPermissions => '権限';

  @override
  String get contactChatMomentsEtc => 'チャット、モーメント、スポーツなど';

  @override
  String get contactMoreInfo => '詳細情報';

  @override
  String get contactCommonGroups => '共通のグループ';

  @override
  String get contactSource => '追加元';

  @override
  String get settingsNotificationSettings => '通知';

  @override
  String get settingsPrivacy => 'プライバシー';

  @override
  String get settingsAppearance => '外観';

  @override
  String get settingsAbout => 'このアプリについて';

  @override
  String get commonLogout => 'ログアウト';

  @override
  String get commonLogoutConfirm => 'ログアウトしてもよろしいですか？';

  @override
  String get commonSave => '保存';

  @override
  String get profileNickname => 'ニックネーム';

  @override
  String get profileEnterNickname => 'ニックネームを入力';

  @override
  String get profileSignature => '署名';

  @override
  String get profileAddSignature => '署名を追加';

  @override
  String get commonTakePhoto => '写真を撮る';

  @override
  String get profileChooseFromGallery => 'ギャラリーから選択';

  @override
  String profileSaveFailed(String error) {
    return '保存に失敗しました: $error';
  }

  @override
  String get authSecureDecentralizedChat => '安全で分散型のメッセージング';

  @override
  String get commonEndToEndEncryption => 'エンドツーエンド暗号化';

  @override
  String get authMessagesOnlyYouCanSee => 'あなたと受信者のみがメッセージを閲覧可能';

  @override
  String get authDecentralized => '分散型';

  @override
  String get authBasedOnMatrix => 'Matrixオープンプロトコルを基盤';

  @override
  String get authWalletIntegration => 'ウォレット連携';

  @override
  String get authEasyCryptoTransfer => '簡単な暗号通貨送金';

  @override
  String get authRegister => '新規登録';

  @override
  String get authAgreeTerms => 'ログインすることで、以下に同意したものとみなします';

  @override
  String get authTermsOfService => '利用規約';

  @override
  String get authAnd => 'および';

  @override
  String get authPrivacyPolicy => 'プライバシーポリシー';

  @override
  String get authServerAddress => 'サーバーアドレス';

  @override
  String get authEnterServerAddress => 'サーバーアドレスを入力';

  @override
  String authConnectedTo(String serverName) {
    return '$serverNameに接続済み';
  }

  @override
  String get authUsername => 'ユーザー名';

  @override
  String get authEnterUsername => 'ユーザー名を入力';

  @override
  String get authUsernameOrEmail => 'ユーザー名またはメール';

  @override
  String get authEnterUsernameOrEmail => 'ユーザー名またはメールを入力';

  @override
  String get authPassword => 'パスワード';

  @override
  String get authEnterPassword => 'パスワードを入力';

  @override
  String get authRegisterAccount => '新規登録';

  @override
  String get authForgotPassword => 'パスワードを忘れた';

  @override
  String get authOtherLoginMethods => 'その他のログイン方法';

  @override
  String get authCreateAccount => 'アカウントを作成';

  @override
  String get authJoinN42Chat => 'N42 Chatに参加してチャットを始めましょう';

  @override
  String get authUsernameHint => '3〜20文字、英数字と_のみ';

  @override
  String get authUsernameMinLength => 'ユーザー名は3文字以上必要です';

  @override
  String get authUsernameMaxLength => 'ユーザー名は20文字以下にしてください';

  @override
  String get authUsernameFormat => 'ユーザー名は英字、数字、アンダースコアのみ使用可能です';

  @override
  String get authPasswordHint => '8文字以上';

  @override
  String get commonPasswordMinLength => 'パスワードは8文字以上必要です';

  @override
  String get authConfirmPassword => 'パスワードを確認';

  @override
  String get authFilled => '入力済み';

  @override
  String get authEnterInviteCode => '招待コードを入力';

  @override
  String get authAlreadyHaveAccount => '既にアカウントをお持ちですか？';

  @override
  String get authLoginNow => '今すぐログイン';

  @override
  String get profileAvatar => 'アバター';

  @override
  String get profileStatus => 'ステータス';

  @override
  String get commonLoading => '読み込み中...';

  @override
  String get conversationNoConversations => '会話がありません';

  @override
  String get conversationTapToChat => '右上をタップしてチャットを開始';

  @override
  String get conversationStartGroup => 'グループチャットを開始';

  @override
  String get commonScan => 'スキャン';

  @override
  String get commonPayment => '支払い';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$featureは近日公開';
  }

  @override
  String get conversationMarkAsRead => '既読にする';

  @override
  String get commonUnmute => 'ミュート解除';

  @override
  String get commonMute => 'ミュート';

  @override
  String get conversationUnpin => 'ピン解除';

  @override
  String get conversationPin => 'ピン留め';

  @override
  String get conversationDeleteConversation => '会話を削除';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return '「$name」との会話を削除しますか？';
  }

  @override
  String get commonNoContacts => '連絡先がありません';

  @override
  String get contactAddFriendsToChat => '友達を追加してチャットを始めましょう';

  @override
  String get contactNotFound => '連絡先が見つかりません';

  @override
  String get contactTryOtherKeywords => '他のキーワードまたはグローバル検索を試してください';

  @override
  String get contactSearchResults => '検索結果';

  @override
  String get contactNewFriends => '新しい友達';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => '公式アカウント';

  @override
  String get contactServiceAccounts => 'サービスアカウント';

  @override
  String get contactEnterpriseContacts => '企業連絡先';

  @override
  String get contactRecommendToFriend => '連絡先を共有';

  @override
  String get commonSetRemark => 'メモを設定';

  @override
  String get contactSendingCard => '連絡先カードを送信中...';

  @override
  String get commonFileLabel => 'ファイル';

  @override
  String get commonLocationLabel => '位置情報';

  @override
  String contactRecommendFailed(String error) {
    return 'おすすめに失敗しました: $error';
  }

  @override
  String get profileEnterRemark => 'メモを入力';

  @override
  String get contactOpeningChat => 'チャットを開いています...';

  @override
  String contactOpenChatFailed(String error) {
    return 'チャットを開けませんでした: $error';
  }

  @override
  String get contactAddContact => '連絡先を追加';

  @override
  String get contactEnterUserId => 'ユーザーIDを入力';

  @override
  String get contactNoFriendRequests => '友達リクエストがありません';

  @override
  String get commonAccept => '承認';

  @override
  String get commonReject => '拒否';

  @override
  String get commonNoGroups => 'グループがありません';

  @override
  String get contactSelectFriendToRecommend => 'おすすめする友達を選択';

  @override
  String get commonSearchContacts => '連絡先を検索';

  @override
  String get contactNoContactsFound => '連絡先が見つかりません';

  @override
  String get favoriteYesterday => '昨日';

  @override
  String get chatJustNow => 'たった今';

  @override
  String get profileOnline => 'オンライン';

  @override
  String get profileOffline => 'オフライン';

  @override
  String get searchContactsGroupsMessages => '連絡先、グループ、メッセージを検索';

  @override
  String get searchError => '検索エラー';

  @override
  String get chatSearchHint => '連絡先、グループ、メッセージを検索';

  @override
  String get searchHistory => '検索履歴';

  @override
  String get commonClear => 'クリア';

  @override
  String get commonAll => 'すべて';

  @override
  String get searchGroups => 'グループ';

  @override
  String get searchNoResults => '結果がありません';

  @override
  String commonGroupMembers(int count) {
    return 'メンバー ($count)';
  }

  @override
  String get groupMembersTitle => 'グループメンバー';

  @override
  String get groupViewAll => 'すべて表示';

  @override
  String get groupOwner => 'オーナー';

  @override
  String get groupAdmin => '管理者';

  @override
  String get groupInvite => '招待';

  @override
  String get commonGroupAnnouncement => 'グループお知らせ';

  @override
  String get commonNotSet => '未設定';

  @override
  String get groupDescription => 'グループの説明';

  @override
  String get groupPublicGroup => '公開グループ';

  @override
  String get commonClearChatHistory => 'チャット履歴を削除';

  @override
  String get commonDissolveGroup => 'グループを解散';

  @override
  String get commonLeaveGroup => 'グループを退出';

  @override
  String get groupChangeGroupName => 'グループ名を変更';

  @override
  String get commonEnterGroupName => 'グループ名を入力';

  @override
  String get commonConfirm => '確認';

  @override
  String get groupEnterGroupDescription => 'グループの説明を入力';

  @override
  String get groupPublish => '公開';

  @override
  String get chatClearHistoryConfirm => 'すべてのチャット履歴を削除しますか？この操作は取り消せません。';

  @override
  String get chatClearAction => '削除';

  @override
  String get commonChatHistoryCleared => 'チャット履歴が削除されました';

  @override
  String get commonDissolve => '解散';

  @override
  String get groupQrCode => 'グループQRコード';

  @override
  String get commonSearchChatHistory => 'チャット履歴を検索';

  @override
  String get groupIdCopied => 'グループIDをコピーしました';

  @override
  String get transferEnterOrPasteAddress => 'ウォレットアドレスを入力または貼り付け';

  @override
  String get transferSelectToken => 'トークンを選択';

  @override
  String get commonTransferAmount => '送金額';

  @override
  String get transferAvailable => '利用可能';

  @override
  String get transferMemoOptional => 'メモ（任意）';

  @override
  String get transferConfirmTransfer => '送金を確認';

  @override
  String get transferAddressVerified => 'アドレス確認済み';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return '残高: $balance $symbol';
  }

  @override
  String get commonEnterAmount => '金額を入力';

  @override
  String get commonRedPacketCountMin => '最低1つのレッドパケットが必要です';

  @override
  String get commonViewRedPacketDetails => 'レッドパケットの詳細を表示';

  @override
  String get commonEnterTransferAmount => '送金額を入力';

  @override
  String get commonTransferTo => '送金先';

  @override
  String commonFromSender(String name, Object senderName) {
    return '$senderNameから';
  }

  @override
  String get commonConfirmReceive => '受け取りを確認';

  @override
  String get groupProfile => 'グループ情報';

  @override
  String get groupRemoveMember => 'グループから削除';

  @override
  String get commonRemove => '削除';

  @override
  String get profileClearStatus => 'ステータスをクリア';

  @override
  String get profileClearStatusConfirm => '現在のステータスをクリアしますか？';

  @override
  String get profileStatusCleared => 'ステータスをクリアしました';

  @override
  String get profileUserNotExist => 'ユーザーが存在しません';

  @override
  String get profileUserIdCopied => 'ユーザーIDをコピーしました';

  @override
  String get commonReport => '報告';

  @override
  String get profileQrCode => 'QRコード';

  @override
  String get profileAvatarUpdated => 'アバターを更新しました';

  @override
  String commonSelectImageFailed(String error) {
    return '画像の選択に失敗しました: $error';
  }

  @override
  String get profileChangeName => '名前を変更';

  @override
  String get profileMale => '男性';

  @override
  String get profileFemale => '女性';

  @override
  String chatFeatureInDev(String feature) {
    return '$featureは開発中...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return '住所の保存に失敗しました: $error';
  }

  @override
  String get profileAddNew => '追加';

  @override
  String get profileAddAddress => '住所を追加';

  @override
  String get profileAddressAdded => '住所を追加しました';

  @override
  String get profileAddressUpdated => '住所を更新しました';

  @override
  String get profileDeleteAddress => '住所を削除';

  @override
  String get profileAddressDeleted => '住所を削除しました';

  @override
  String profileSaveInvoiceFailed(String error) {
    return '請求書の保存に失敗しました: $error';
  }

  @override
  String get profileMyInvoices => 'マイ請求書';

  @override
  String get profileAddInvoice => '請求書を追加';

  @override
  String get profileInvoiceAdded => '請求書を追加しました';

  @override
  String get profileInvoiceUpdated => '請求書を更新しました';

  @override
  String get profileDeleteInvoice => '請求書を削除';

  @override
  String get profileInvoiceDeleted => '請求書を削除しました';

  @override
  String get profilePersonal => '個人';

  @override
  String get groupSelectAtLeastOne => '少なくとも1人のメンバーを選択してください';

  @override
  String get chatFileNotExist => 'ファイルが存在しません';

  @override
  String chatSendFailed(String error) {
    return '送信に失敗しました: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'ブラウザを開けません';

  @override
  String chatSelectFileFailed(String error) {
    return 'ファイルの選択に失敗しました: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return '設定に失敗しました: $error';
  }

  @override
  String get transferEnterValidAmount => '有効な金額を入力してください';

  @override
  String get commonAddressCopied => 'アドレスをコピーしました';

  @override
  String favoriteOpenItem(String content) {
    return '開く: $content';
  }

  @override
  String get favoriteDeleted => '削除しました';

  @override
  String get profileWallet => 'ウォレット';

  @override
  String get chatRecording => '録音中';

  @override
  String get chatInvalidVideoUrl => '無効な動画URL';

  @override
  String get chatDownloadFile => 'ファイルをダウンロード';

  @override
  String get chatClearChatHistoryTitle => 'チャット履歴を削除';

  @override
  String get chatVideoCall => 'ビデオ通話';

  @override
  String get commonVoiceCall => '音声通話';

  @override
  String get callLeaveMeeting => 'ミーティングを退出';

  @override
  String get chatDetails => 'チャットの詳細';

  @override
  String get chatViewAllGroupMembers => 'すべてのメンバーを表示';

  @override
  String get chatGroupName => 'グループ名';

  @override
  String get chatGroupNameUpdated => 'グループ名を更新しました';

  @override
  String get chatUpdateFailed => '更新に失敗しました';

  @override
  String get chatNoPermissionToModify => '変更する権限がありません';

  @override
  String get chatGroupManagement => 'グループ管理';

  @override
  String get chatMyNicknameInGroup => 'グループ内のニックネーム';

  @override
  String get chatPinChat => 'チャットをピン留め';

  @override
  String get chatStrongReminder => '強調リマインダー';

  @override
  String get chatSetChatBackground => 'チャット背景を設定';

  @override
  String get chatUnknownFile => '不明なファイル';

  @override
  String get chatDownload => 'ダウンロード';

  @override
  String get chatInvalidLocation => '無効な位置情報';

  @override
  String get chatTapToCancel => 'タップしてキャンセル';

  @override
  String chatCaptureFailed(Object error) {
    return 'キャプチャに失敗しました: $error';
  }

  @override
  String get chatProcessingVideo => '動画を処理中...';

  @override
  String get chatVideoFileNotExist => '動画ファイルが存在しません';

  @override
  String get chatVideoDataEmpty => '動画データが空です';

  @override
  String get chatVideoTooLarge => '動画サイズは100MBを超えられません';

  @override
  String get chatSendingVideo => '動画を送信中...';

  @override
  String chatSendVideoFailed(Object error) {
    return '動画の送信に失敗しました: $error';
  }

  @override
  String get chatImageFileNotExist => '画像ファイルが存在しません';

  @override
  String get commonImageDataEmpty => '画像データが空です';

  @override
  String get chatSendingImage => '画像を送信中...';

  @override
  String chatSendImageFailed(Object error) {
    return '画像の送信に失敗しました: $error';
  }

  @override
  String get chatSendLocation => '位置情報を送信';

  @override
  String get chatSelectLocationAndSend => '位置を選択して送信';

  @override
  String get chatShareRealTimeLocation => 'リアルタイム位置情報を共有';

  @override
  String get chatShareLocationForOneHour => '友達とリアルタイム位置情報を1時間共有';

  @override
  String get chatLocationSent => '位置情報を送信しました';

  @override
  String get chatSelectMessages => 'メッセージを選択';

  @override
  String chatSelectedCount(int count) {
    return '$count件選択';
  }

  @override
  String get chatSelectAll => 'すべて選択';

  @override
  String chatGroupChatCount(int count) {
    return 'グループチャット ($count)';
  }

  @override
  String get chatPrivateChat => 'プライベートチャット';

  @override
  String get chatNoMessages => 'メッセージがありません';

  @override
  String get chatSendFirstMessage => '最初のメッセージを送信してチャットを開始';

  @override
  String get chatEncryptionNotice =>
      'このチャットはエンドツーエンド暗号化されています。あなたと受信者のみがメッセージを読むことができます。';

  @override
  String get chatMultiForward => '転送';

  @override
  String get chatCollect => 'コレクション';

  @override
  String get chatNoMembers => 'メンバーがいません';

  @override
  String get chatMemberNotFound => 'メンバーが見つかりません';

  @override
  String get chatVoiceFileNotExist => '音声ファイルが存在しません';

  @override
  String get chatVoiceFileEmpty => '音声ファイルが空です';

  @override
  String get chatSendingVoice => '音声を送信中...';

  @override
  String chatSendVoiceFailed(Object error) {
    return '音声の送信に失敗しました: $error';
  }

  @override
  String get chatMessageForwarded => 'メッセージを転送しました';

  @override
  String chatForwardFailed(Object error) {
    return '転送に失敗しました: $error';
  }

  @override
  String get chatUnfavorited => 'お気に入りから削除しました';

  @override
  String get chatFavorited => 'お気に入りに追加しました';

  @override
  String get chatReactionAdded => 'リアクションを追加しました';

  @override
  String get chatReactionRemoved => 'リアクションを削除しました';

  @override
  String get chatFailedMessageDeleted => '失敗したメッセージを削除しました';

  @override
  String get chatDeleteMessages => 'メッセージを削除';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return '$count件のメッセージを削除してもよろしいですか？';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return '注意: $count件のメッセージは他のユーザーからのもので、あなたにのみ削除されます。';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return 'あなたの$count件のメッセージは全員に対して取り消されます。';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return '$count件取り消し、$localCount件はあなたにのみ削除';
  }

  @override
  String chatRecalledMessages(Object count) {
    return '$count件のメッセージを取り消しました';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count件のメッセージはあなたにのみ削除されました';
  }

  @override
  String chatForwardedCount(Object count) {
    return '$count件のメッセージを転送しました';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return '転送完了: $success件成功、$failed件失敗';
  }

  @override
  String get chatRemindOnlyInGroup => 'リマインド機能はグループチャットでのみ利用可能です';

  @override
  String get chatOnlyTextSearchable => 'テキストメッセージのみ検索可能です';

  @override
  String chatSearchFor(Object text) {
    return '「$text」を検索';
  }

  @override
  String get chatBaiduSearch => 'Baidu検索';

  @override
  String get chatGoogleSearch => 'Google検索';

  @override
  String get chatBingSearch => 'Bing検索';

  @override
  String get chatCalling => '発信中...';

  @override
  String get chatRinging => '呼び出し中...';

  @override
  String get chatInCall => '通話中';

  @override
  String commonFeatureInDevelopment(String feature) {
    return '機能開発中...';
  }

  @override
  String chatCollectMessages(Object count) {
    return '$count件のメッセージをコレクションに追加しました';
  }

  @override
  String commonMemberCount(int count) {
    return '$count人のメンバー';
  }

  @override
  String groupDone(int count) {
    return '完了($count)';
  }

  @override
  String get profileServices => 'サービス';

  @override
  String get commonFavorites => 'お気に入り';

  @override
  String get profileOrdersAndCards => '注文 & カード';

  @override
  String get profileStickers => 'スタンプ';

  @override
  String profileStatusSetTo(String status) {
    return 'ステータスを設定しました: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'アバターのアップロードに失敗しました';

  @override
  String get profilePersonalProfile => '個人プロフィール';

  @override
  String get profileName => '名前';

  @override
  String get profileGender => '性別';

  @override
  String get profileRegion => '地域';

  @override
  String get commonMyQrCode => 'マイQRコード';

  @override
  String get profilePoke => 'つつく';

  @override
  String get profileRingtone => '着信音';

  @override
  String get profileDefaultRingtone => 'デフォルト着信音';

  @override
  String get profileMyAddresses => 'マイアドレス';

  @override
  String profileGenderSetTo(String gender) {
    return '性別を設定しました: $gender';
  }

  @override
  String get profileSelectRegion => '地域を選択';

  @override
  String get profileSelectCity => '都市を選択';

  @override
  String profileRegionSetTo(String region) {
    return '地域を設定しました: $region';
  }

  @override
  String get profileSetPoke => 'つつくを設定';

  @override
  String get profileFriendPokedMe => '友達がつついてきました';

  @override
  String get profileExample => '例';

  @override
  String get profileOnTheShoulder => ' 肩を';

  @override
  String get profilePokeCleared => 'つつくをクリアしました';

  @override
  String profilePokeSetTo(String suffix) {
    return 'つつくを設定しました: つついた$suffix';
  }

  @override
  String get profileEditSignature => '署名を編集';

  @override
  String get profileIntroduceYourself => '自己紹介を一言で';

  @override
  String get profileSignatureCleared => '署名をクリアしました';

  @override
  String get profileSignatureUpdated => '署名を更新しました';

  @override
  String get profileScanToAddFriend => '上のQRコードをスキャンして友達に追加';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return '着信音を設定しました: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return '「$name」を解散してもよろしいですか？この操作は元に戻せません。';
  }

  @override
  String get authEnterValidServerAddress => '有効なサーバーアドレスを入力してください';

  @override
  String get authEmailOtp => 'メールOTP';

  @override
  String get authEnterServerAddressFirst => '先にサーバーアドレスを入力してください';

  @override
  String get authPasskeyRequiresServer => 'パスキーログインにはサーバーのサポートが必要です';

  @override
  String get authLoginAgreement => 'ログインすることで、以下に同意したものとみなします ';

  @override
  String get authPleaseAgreeToTerms => '利用規約とプライバシーポリシーを読んで同意してください';

  @override
  String get authRegisterFailed => '登録に失敗しました';

  @override
  String get commonReenterPassword => 'パスワードを再入力';

  @override
  String get commonPasswordsDoNotMatch => 'パスワードが一致しません';

  @override
  String get authInviteCodeBuiltIn => '招待コード（内蔵）';

  @override
  String get authInviteCodeBuiltInNote => '招待コードは内蔵されており、通常は変更不要です';

  @override
  String get authIHaveReadAndAgree => '読んで同意します ';

  @override
  String get mainStartGroupChat => 'グループチャットを開始';

  @override
  String get mainAddFriends => '友達を追加';

  @override
  String get mainPaymentAndCollection => '支払い';

  @override
  String contactCount(int count) {
    return '$count件の連絡先';
  }

  @override
  String get contactAddToHomeScreen => 'ホーム画面に追加';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return '$contactのカードを$recipientにおすすめしました';
  }

  @override
  String get contactEnterRemarkName => '表示名を入力';

  @override
  String contactRemarkSetTo(String remark) {
    return 'メモを設定しました: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return '$nameの友達リクエストを承認しました';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return '$nameの友達リクエストを拒否しました';
  }

  @override
  String get commonGroupInvites => 'グループ招待';

  @override
  String commonMyGroups(int count) {
    return 'マイグループ ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'グループへの招待';

  @override
  String commonConfirmLeaveGroup(String name) {
    return '「$name」を退出してもよろしいですか？';
  }

  @override
  String get commonLeave => '退出';

  @override
  String get commonRecallThisMessage => 'このメッセージを取り消しますか？';

  @override
  String get commonSavedToGallery => 'ギャラリーに保存しました';

  @override
  String get commonFailedToSave => '保存に失敗しました';

  @override
  String get chatSaving => '保存中...';

  @override
  String get commonShare => '共有';

  @override
  String get chatSaveToGallery => 'ギャラリーに保存';

  @override
  String chatDownloadFailed(String code) {
    return 'ダウンロード失敗: $code';
  }

  @override
  String commonShareFailed(String error) {
    return '共有に失敗しました: $error';
  }

  @override
  String get chatFailedToLoadImage => '画像の読み込みに失敗しました';

  @override
  String get chatVideoRecordingFailed => '動画録画に失敗しました。再試行してください。';

  @override
  String get profileRedPacket => 'レッドパケット';

  @override
  String get commonMusic => '音楽';

  @override
  String get commonCoupon => 'クーポン';

  @override
  String get commonGift => 'ギフト';

  @override
  String get commonPoll => '投票';

  @override
  String get favoriteText => 'テキスト';

  @override
  String get favoriteLinkLabel => 'リンク';

  @override
  String get favoriteNote => 'メモ';

  @override
  String get favoriteMyNotes => 'マイメモ';

  @override
  String get favoriteToday => '今日';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count日前';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$month/$day';
  }

  @override
  String get favoriteNoFavorites => 'お気に入りがありません';

  @override
  String get favoriteLongPressToFavorite => 'メッセージを長押ししてお気に入りに追加';

  @override
  String get favoriteNewNote => '新規メモ';

  @override
  String get favoriteLink => 'リンクをお気に入り';

  @override
  String get favoriteEditTags => 'タグを編集';

  @override
  String get favoriteDeleteFavorite => 'お気に入りを削除';

  @override
  String get favoriteDeleteFavoriteConfirm => 'このお気に入りを削除してもよろしいですか？';

  @override
  String get favoriteNoSearchResultsFound => '結果が見つかりませんでした';

  @override
  String get commonSendRedPacket => 'レッドパケットを送る';

  @override
  String get transferAmount => '金額';

  @override
  String get commonRedPacketCover => 'レッドパケットカバー';

  @override
  String get commonRedPacketType => 'レッドパケットの種類';

  @override
  String get commonNormalRedPacket => '通常';

  @override
  String get commonLuckyRedPacket => 'ラッキー';

  @override
  String get commonRedPacketCount => 'レッドパケットの数';

  @override
  String get commonPieces => '個';

  @override
  String get commonPutMoneyInRedPacket => 'レッドパケットにお金を入れる';

  @override
  String get commonRedPacketRefundNotice => '24時間以内に受け取られなかったレッドパケットは返金されます';

  @override
  String get commonOpenRedPacket => '開く';

  @override
  String get commonRedPacketAllClaimed => 'レッドパケットはすべて受け取られました';

  @override
  String get commonRedPacketExpired => 'レッドパケットの期限が切れました';

  @override
  String get commonAddTransferNote => '送金メモを追加';

  @override
  String get commonYuan => '円';

  @override
  String get commonReplyWithEmoji => 'この絵文字で返信';

  @override
  String get contactEditRemark => 'メモを編集';

  @override
  String get contactSetPermissions => '権限を設定';

  @override
  String get profileAddToBlacklist => 'ブラックリストに追加';

  @override
  String get contactDeleteContact => '連絡先を削除';

  @override
  String contactDeleteContactConfirm(String name) {
    return '$nameを削除してもよろしいですか？';
  }

  @override
  String get transferTitle => '送金';

  @override
  String get transferReceiverAddressLabel => '送金先アドレス';

  @override
  String get transferSelectTokenLabel => 'トークンを選択';

  @override
  String get transferAmountLabel => '送金額';

  @override
  String get transferMemoLabel => 'メモ（任意）';

  @override
  String get transferAddMemoHint => 'メモを追加';

  @override
  String get transferSendPaymentRequest => '支払いリクエストを送信';

  @override
  String get transferQrCodeGenerateFailed => 'QRコード生成に失敗しました';

  @override
  String get transferScanQrToPayMe => 'QRコードをスキャンして支払い';

  @override
  String get transferMyWalletAddress => 'マイウォレットアドレス';

  @override
  String get transferCreatePaymentRequest => '支払いリクエストを作成';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'お祝いメッセージ';

  @override
  String commonSenderRedPacket(String name) {
    return '$nameのレッドパケット';
  }

  @override
  String get transferEnterValidAddress => '有効なアドレスを入力してください';

  @override
  String get transferPleaseSelectToken => 'トークンを選択してください';

  @override
  String get commonReceivedTransfer => '送金を受け取りました';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$nameがレッドパケットを送りました';
  }

  @override
  String get commonSavedToBalance => '残高に保存され、直接送金可能';

  @override
  String get commonRedPacketExpiredOrEmpty => 'レッドパケットの期限切れ/すべて受け取り済み';

  @override
  String get transferScanFeatureComingSoon => 'スキャン機能は近日公開...';

  @override
  String get contactSetAsStarred => 'スター付きに設定';

  @override
  String get contactAddToBlocklist => 'ブロックリストに追加';

  @override
  String get commonClaimedYour => ' があなたの ';

  @override
  String get commonClaimedText => ' を受け取りました';

  @override
  String commonUserTyping(String name) {
    return '$nameが入力中...';
  }

  @override
  String get commonTyping => '入力中...';

  @override
  String get commonWaitingToReceive => '受け取り待ち';

  @override
  String get commonTapToClaim => 'タップして受け取る';

  @override
  String get commonHasBeenReceived => '受け取り済み';

  @override
  String get commonGetLucky => '幸運を祈って';

  @override
  String get qrcodeCameraStartFailed => 'カメラの起動に失敗しました';

  @override
  String get qrcodeUnknownError => '不明なエラー';

  @override
  String get qrcodePlaceQrCodeInFrame => 'QRコードを枠内に配置してスキャン';

  @override
  String get qrcodeCloseManualInput => '手動入力を閉じる';

  @override
  String get qrcodeManualInputUserId => 'ユーザーIDを手動入力';

  @override
  String get commonAdd => '追加';

  @override
  String get profileSetStatus => 'ステータスを設定';

  @override
  String get profileVisibleToFriends24h => '友達に24時間表示されます';

  @override
  String get profileWriteStatus => 'ステータスを入力';

  @override
  String get profileEnterYourStatus => 'ステータスを入力...';

  @override
  String get profileOk => 'OK';

  @override
  String get qrcodeCameraPermissionRequired => 'QRコードをスキャンするにはカメラの権限が必要です';

  @override
  String get qrcodeCameraPermissionDenied =>
      'カメラの権限が永久に拒否されました。システム設定で有効にしてください。';

  @override
  String qrcodePermissionCheckError(String error) {
    return '権限確認エラー: $error';
  }

  @override
  String get qrcodeInvalidQrCode => '無効なQRコード';

  @override
  String qrcodeCannotAddFriend(String error) {
    return '友達を追加できません: $error';
  }

  @override
  String get qrcodeScanQrCode => 'QRコードをスキャン';

  @override
  String get qrcodeCheckingCameraPermission => 'カメラの権限を確認中...';

  @override
  String get qrcodeNeedCameraPermission => 'カメラの権限が必要です';

  @override
  String get qrcodeRetryPermission => '再試行';

  @override
  String get qrcodeOpenSettings => '設定を開く';

  @override
  String get groupInviteMembers => 'メンバーを招待';

  @override
  String groupInviteCount(int count) {
    return '招待($count)';
  }

  @override
  String get profileNoShippingAddress => '配送先住所がありません';

  @override
  String get profileDefaultLabel => 'デフォルト';

  @override
  String get profileNoInvoice => '請求書がありません';

  @override
  String get profileCompany => '会社';

  @override
  String get profileTaxNumber => '税務番号';

  @override
  String get profileConfirmDeleteAddress => 'この住所を削除してもよろしいですか？';

  @override
  String get profileConfirmDeleteInvoice => 'この請求書を削除してもよろしいですか？';

  @override
  String get commonGroupOwner => 'オーナー';

  @override
  String get commonGroupAdmin => '管理者';

  @override
  String get groupSearchMembers => 'メンバーを検索';

  @override
  String groupTotalMembers(int count) {
    return '$count人のメンバー';
  }

  @override
  String get chatRemoveFromGroup => 'グループから削除';

  @override
  String groupConfirmRemoveMember(String name) {
    return '「$name」をグループから削除してもよろしいですか？';
  }

  @override
  String get chatUnknownSong => '不明な曲';

  @override
  String get chatUnknownArtist => '不明なアーティスト';

  @override
  String get chatUnknownContact => '不明な連絡先';

  @override
  String get chatPersonalCard => '連絡先カード';

  @override
  String get chatSingleChoice => '単一選択';

  @override
  String get chatMultiChoice => '複数選択';

  @override
  String get chatEnded => '終了';

  @override
  String get chatEndPollButton => '投票を終了';

  @override
  String get chatPollHint => '投票はチャットに表示されます。グループメンバーが投票できます。';

  @override
  String get chatSearchSongOrArtist => '曲またはアーティストを検索';

  @override
  String get chatNoSongsFound => '曲が見つかりません';

  @override
  String get chatSongNameOptional => '曲名（任意）';

  @override
  String get chatEnterSongName => '曲名を入力';

  @override
  String get chatArtistNameOptional => 'アーティスト名（任意）';

  @override
  String get chatEnterArtistName => 'アーティスト名を入力';

  @override
  String get chatRealTimeLocationSharing => 'リアルタイム位置情報共有は開発中...';

  @override
  String get profileVoiceCallFeatureInDev => '音声通話機能は開発中...';

  @override
  String get profileReportFeatureInDev => '報告機能は開発中...';

  @override
  String get profileShareFeatureInDev => '共有機能は開発中...';

  @override
  String get profileQrCodeFeatureInDev => 'QRコード機能は開発中...';

  @override
  String get qrcodeScanQrToAddMe => '上のQRコードをスキャンして友達に追加';

  @override
  String get qrcodeSaveToAlbum => 'アルバムに保存';

  @override
  String get qrcodeChangeStyle => 'スタイルを変更';

  @override
  String get qrcodeCopyId => 'IDをコピー';

  @override
  String get qrcodeIdCopied => 'IDをコピーしました';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => 'その他のスタイルは近日公開';

  @override
  String get profileBio => '自己紹介';

  @override
  String get profileHomeServer => 'サーバー';

  @override
  String get profileShareContactCard => '連絡先カードを共有';

  @override
  String get profileRemoveFromBlacklist => 'ブラックリストから削除';

  @override
  String get profileConfirmAddBlacklist =>
      'このユーザーをブラックリストに追加してもよろしいですか？このユーザーからのメッセージは受信できなくなります。';

  @override
  String get profileConfirmRemoveBlacklist => 'このユーザーをブラックリストから削除してもよろしいですか？';

  @override
  String get profileRemarkSaved => 'メモを保存しました';

  @override
  String get profileRemarkCleared => 'メモをクリアしました';

  @override
  String get transferReceive => '受け取り';

  @override
  String get transferPleaseConnectWallet => 'まずウォレットを接続してください';

  @override
  String get transferSendRequest => 'リクエストを送信';

  @override
  String get transferPleaseEnterValidAmount => '有効な金額を入力してください';

  @override
  String get searchPlaceholder => '連絡先、グループ、メッセージを検索';

  @override
  String get searchEnterKeywordToSearch => 'キーワードを入力して検索を開始';

  @override
  String get searchClearHistory => 'クリア';

  @override
  String searchNoResultsForQuery(String query) {
    return '「$query」の検索結果が見つかりませんでした';
  }

  @override
  String get searchAllResults => 'すべて';

  @override
  String get searchInChat => 'チャット内を検索';

  @override
  String get searchContactLabel => '連絡先';

  @override
  String get searchGroupLabel => 'グループ';

  @override
  String get searchConversationLabel => '会話';

  @override
  String get searchMessageLabel => 'メッセージ';

  @override
  String get settingsSecurityTitle => 'セキュリティ';

  @override
  String get settingsKeyBackup => 'キーバックアップ';

  @override
  String get settingsBackupEncryptionKeys => '暗号化キーをバックアップ';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count個のキーをバックアップしました';
  }

  @override
  String get settingsBackupNotSet => 'バックアップ未設定';

  @override
  String get settingsRestoreKeys => 'キーを復元';

  @override
  String get settingsRestoreKeysFromBackup => 'バックアップから暗号化キーを復元';

  @override
  String get settingsExportKeys => 'キーをエクスポート';

  @override
  String get settingsExportKeysToFile => 'キーをファイルにエクスポート';

  @override
  String get settingsLoggedInDevices => 'ログイン中のデバイス';

  @override
  String get settingsNoOtherDevices => '他のデバイスはありません';

  @override
  String get settingsVerified => '確認済み';

  @override
  String get settingsUnverified => '未確認';

  @override
  String get settingsAdvanced => '詳細設定';

  @override
  String get settingsCrossSigning => 'クロス署名';

  @override
  String get settingsEnabled => '有効';

  @override
  String get settingsNotEnabled => '無効';

  @override
  String get settingsResetEncryption => '暗号化をリセット';

  @override
  String get settingsDeleteAllEncryptionKeys => 'すべての暗号化キーを削除';

  @override
  String get settingsEncryptionNotSupported => '暗号化はサポートされていません';

  @override
  String get settingsNotInitialized => '初期化されていません';

  @override
  String get settingsBackupKeyTitle => 'キーをバックアップ';

  @override
  String get settingsBackupKeyMessage =>
      '新しいキーバックアップを作成しますか？これにより、新しいデバイスで暗号化されたメッセージを復元できます。';

  @override
  String get settingsBackup => 'バックアップ';

  @override
  String get settingsRestoreKeyTitle => 'キーを復元';

  @override
  String get settingsRestoreKeyMessage =>
      '暗号化されたメッセージを復元するには、回復パスワードまたは回復キーを入力してください。';

  @override
  String get settingsRestore => '復元';

  @override
  String get settingsExportKeyTitle => 'キーをエクスポート';

  @override
  String get settingsExportKeyMessage =>
      'エクスポートされたキーファイルにはすべての暗号化キーが含まれています。安全に保管してください。';

  @override
  String get settingsExport => 'エクスポート';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'デバイスID: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'ステータス: 確認済み';

  @override
  String get settingsDeviceStatusUnverified => 'ステータス: 未確認';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return '最終アクティブ: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'このデバイスを確認';

  @override
  String get settingsCrossSigningAlreadyEnabled => 'クロス署名は既に有効です';

  @override
  String get settingsCrossSigningSetupSuccess => 'クロス署名の設定が完了しました';

  @override
  String get settingsResetEncryptionTitle => '暗号化をリセット';

  @override
  String get settingsResetEncryptionWarning =>
      '警告: これにより、すべての暗号化キーが削除されます。以前の暗号化されたメッセージを復号化できなくなります。この操作は取り消せません。';

  @override
  String get settingsReset => 'リセット';

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
  String get callLeaveMeetingConfirm => 'ミーティングを退出してもよろしいですか？';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return '$name$suffixをつついた';
  }

  @override
  String get chatNoContactsToAdd => '追加できる連絡先がありません';

  @override
  String get chatAddMembers => 'メンバーを追加';

  @override
  String chatInvitedMembers(int count) {
    return '$count人のメンバーを招待しました';
  }

  @override
  String chatInviteFailed(String error) {
    return '招待に失敗しました: $error';
  }

  @override
  String get chatMemberRemoved => 'メンバーを削除しました';

  @override
  String chatRemoveFailed(String error) {
    return '削除に失敗しました: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      '共有後、相手は1時間あなたのリアルタイム位置情報を見ることができます。';

  @override
  String get chatStartSharing => '共有を開始';

  @override
  String get chatLocationServiceNotEnabled => '位置情報サービスが有効になっていません';

  @override
  String get chatEnableLocationService => 'この機能を使用するには位置情報サービスを有効にしてください';

  @override
  String get chatGoToSettings => '設定へ移動';

  @override
  String get chatLocationPermissionRequired => 'この機能には位置情報の権限が必要です';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      '位置情報の権限が永久に拒否されました。設定で有効にしてください。';

  @override
  String get chatLocationPermissionDenied => '位置情報の権限が拒否されました';

  @override
  String get chatGettingLocation => '位置情報を取得中...';

  @override
  String chatGetLocationFailed(String error) {
    return '位置情報の取得に失敗しました: $error';
  }

  @override
  String get chatMapPreview => '地図プレビュー';

  @override
  String get chatSearchLocation => '場所を検索';

  @override
  String chatRedPacketSent(String amount, String token) {
    return '$amount $tokenのレッドパケットを送りました';
  }

  @override
  String get chatTransferDefault => '送金';

  @override
  String chatTransferSent(String amount, String token) {
    return '$amount $tokenを送金しました';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'ファイルの選択に失敗しました: $error';
  }

  @override
  String get chatFileSizeLimit => 'ファイルサイズは50MBを超えられません';

  @override
  String chatFileSending(String filename) {
    return 'ファイルを送信中: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'ファイルの送信に失敗しました: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return '$nameの連絡先カードを送信しました';
  }

  @override
  String get chatFavoritesFeature => 'お気に入り';

  @override
  String get chatCouponsFeature => 'クーポン';

  @override
  String get chatGiftFeature => 'ギフト';

  @override
  String chatSharedMusic(String name) {
    return '$nameを共有しました';
  }

  @override
  String get chatEndPollTitle => '投票を終了';

  @override
  String get chatEndPollConfirmMessage => 'この投票を終了してもよろしいですか？終了後は投票できなくなります。';

  @override
  String get chatPollEndedMessage => '投票が終了しました';

  @override
  String get chatConnectingCall => '接続中...';

  @override
  String get chatMuteCall => 'ミュート';

  @override
  String get chatSpeakerOff => 'スピーカーオフ';

  @override
  String get chatSpeakerOn => 'スピーカー';

  @override
  String get chatCameraOn => 'カメラオン';

  @override
  String get chatCameraOff => 'カメラオフ';

  @override
  String get chatHangUp => '通話終了';

  @override
  String get chatSelectForwardTargetTitle => '転送先を選択';

  @override
  String get chatNoForwardableChat => '転送可能なチャットがありません';

  @override
  String get chatNoMatchingChat => '一致するチャットが見つかりません';

  @override
  String get chatLocationTitle => '位置情報';

  @override
  String get chatSendButton => '送信';

  @override
  String get chatRetryButton => '再試行';

  @override
  String get chatSearchContactHint => '連絡先を検索';

  @override
  String get chatShareMusic => '音楽を共有';

  @override
  String get chatRecentPlayed => '最近';

  @override
  String get chatMyFavorites => 'お気に入り';

  @override
  String get chatNetworkLink => 'リンク';

  @override
  String get chatLocalFile => 'ローカル';

  @override
  String get chatPasteMusicLink => '音楽リンクを貼り付け';

  @override
  String get chatShareMusicButton => '音楽を共有';

  @override
  String get chatSelectLocalAudio => 'ローカルの音声ファイルを選択';

  @override
  String get chatSupportedAudioFormats => 'MP3、M4A、WAV、FLACなどをサポート';

  @override
  String get chatSelectFileButton => 'ファイルを選択';

  @override
  String get chatPleaseEnterMusicLink => '音楽リンクを入力してください';

  @override
  String get chatPleaseEnterValidLink => '有効なURLを入力してください';

  @override
  String get chatSharedSong => '共有した曲';

  @override
  String get chatSelectMember => 'メンバーを選択';

  @override
  String get chatSearchMemberHint => 'メンバーを検索';

  @override
  String get chatNoMatchingMembers => '一致するメンバーが見つかりません';

  @override
  String get commonUnknownMember => '不明';

  @override
  String chatSelectedMessagesCount(int count) {
    return '$count件のメッセージを選択';
  }

  @override
  String get chatSearchContactsOrGroups => '連絡先またはグループを検索';

  @override
  String get chatVideoTitle => '動画';

  @override
  String get chatLoadingText => '読み込み中...';

  @override
  String get chatVideoLoadFailed => '動画の読み込みに失敗しました';

  @override
  String get chatPlayerInitFailed => 'プレーヤーの初期化に失敗しました';

  @override
  String get chatCreatePollTitle => '投票を作成';

  @override
  String get chatSubmitPoll => '送信';

  @override
  String get chatPollQuestionLabel => '投票の質問';

  @override
  String get chatEnterPollQuestionHint => '投票の質問を入力してください';

  @override
  String get chatPollOptionsLabel => '投票オプション';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'オプション $index';
  }

  @override
  String get chatAddOptionButton => 'オプションを追加';

  @override
  String get chatPollSettingsLabel => '投票設定';

  @override
  String get chatSelectionType => '選択タイプ';

  @override
  String get chatSingleChoiceLabel => '単一';

  @override
  String get chatMultiChoiceLabel => '複数';

  @override
  String get chatAnonymousPollSwitch => '匿名投票';

  @override
  String get chatPleaseEnterQuestion => '投票の質問を入力してください';

  @override
  String get chatAtLeastTwoOptions => '最低2つのオプションが必要です';

  @override
  String chatConfirmWithCount(int count) {
    return '確認 ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'メール認証';

  @override
  String get authEnterValidEmailAddress => '有効なメールアドレスを入力してください';

  @override
  String authVerificationCodeSentTo(String email) {
    return '認証コードを$emailに送信しました';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'コードの送信に失敗しました: $error';
  }

  @override
  String get authVerificationSuccess => '認証に成功しました';

  @override
  String get authVerificationFailed => '認証に失敗しました';

  @override
  String authVerificationCodeError(String error) {
    return '認証コードエラー: $error';
  }

  @override
  String get commonEnterVerificationCode => '認証コードを入力';

  @override
  String get authEnterYourEmail => 'メールアドレスを入力';

  @override
  String authWeSentCodeTo(String email) {
    return '6桁のコードを\n$emailに送信しました';
  }

  @override
  String get authEnterEmailForCode => 'メールアドレスを入力すると、認証コードを送信します';

  @override
  String get commonSendVerificationCode => '認証コードを送信';

  @override
  String get authResendVerificationCode => '認証コードを再送信';

  @override
  String authCanResendAfter(int seconds) {
    return '$seconds秒後に再送信可能';
  }

  @override
  String get commonChangeEmail => 'メールアドレスを変更';

  @override
  String get contactAddToContacts => '連絡先に追加';

  @override
  String get contactAddingToContacts => '追加中...';

  @override
  String get contactAddedToContacts => '連絡先に追加しました';

  @override
  String contactAddFailedWithError(String error) {
    return '追加に失敗しました: $error';
  }

  @override
  String get contactAddPhone => '電話番号を追加';

  @override
  String get contactAddTag => 'タグを追加';

  @override
  String get contactAddText => 'テキストを追加';

  @override
  String get contactAddPhoto => '写真を追加';

  @override
  String contactGroupCountLabel(int count) {
    return '$count件のグループ';
  }

  @override
  String get contactAddedViaSearch => '検索で追加';

  @override
  String get contactAddTime => '日時を追加';

  @override
  String get contactDoneButton => '完了';

  @override
  String get callWaitingForParticipants => '参加者を待っています...';

  @override
  String callParticipantMe(String name) {
    return '$name (自分)';
  }

  @override
  String get callSharingLabel => '共有中';

  @override
  String callScreenSharingBy(String name) {
    return '$nameが画面を共有中';
  }

  @override
  String callParticipantCount(int count) {
    return '$count人の参加者';
  }

  @override
  String get callMuteLabel => 'ミュート';

  @override
  String get callUnmuteLabel => 'ミュート解除';

  @override
  String get callTurnOffVideo => 'ビデオをオフ';

  @override
  String get callTurnOnVideo => 'ビデオをオン';

  @override
  String get callShareScreen => '画面を共有';

  @override
  String get callStopSharing => '共有を停止';

  @override
  String get callSwitchCameraLabel => '切り替え';

  @override
  String get callLeaveLabel => '退出';

  @override
  String get callParticipantsLabel => '参加者';

  @override
  String get callJoiningMeeting => 'ミーティングに参加中...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count票 ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count人が参加';
  }

  @override
  String get commonTapToRetry => 'タップして再試行';

  @override
  String get chatDefaultRedPacketGreeting => '金運上昇、幸福をお祈りします';

  @override
  String get groupAllowOthersToSearchAndJoin => '他のユーザーが検索して参加することを許可する';

  @override
  String get groupConfirmClearChatHistory => 'チャット履歴を削除してもよろしいですか?';

  @override
  String get groupCreateGroupToChat => 'グループを作成してチャットを開始する';

  @override
  String get groupEditGroupAnnouncement => 'グループお知らせを編集';

  @override
  String get groupEditGroupDescription => 'グループ説明を編集';

  @override
  String get groupEnterGroupAnnouncement => 'グループお知らせを入力';

  @override
  String chatErrorWithMessage(String message) {
    return 'エラー: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count人、クリックしてグループIDをコピー';
  }

  @override
  String get chatMusicLinkLabel => '音楽リンク';

  @override
  String get chatNoMediaUrlAvailable => 'メディアURLがありません';

  @override
  String get groupNoPermissionToEditGroupName => 'グループ名を編集する権限がありません';

  @override
  String get chatRedPacketTransferCannotForward => '紅包と送金は転送できません';

  @override
  String get authEmailAddress => 'メールアドレス';

  @override
  String get commonEnterEmailAddress => 'メールアドレスを入力';

  @override
  String get authEmailRecoveryHint => 'パスワードの回復に使用されます';

  @override
  String get commonInvalidEmailFormat => '有効なメールアドレスを入力してください';

  @override
  String get authOptional => '任意';

  @override
  String get authResetPassword => 'パスワードをリセット';

  @override
  String get authEnterRegisteredEmail => '登録時のメールアドレスを入力してください';

  @override
  String get authSendResetCode => 'リセットコードを送信';

  @override
  String authResetCodeSent(String email) {
    return 'リセットコードを$emailに送信しました';
  }

  @override
  String get authEnterResetCode => 'リセットコードを入力';

  @override
  String get authSetNewPassword => '新しいパスワードを設定';

  @override
  String get commonConfirmNewPassword => '新しいパスワードを確認';

  @override
  String get commonNewPassword => '新しいパスワード';

  @override
  String get authPasswordResetSuccess =>
      'パスワードが正常にリセットされました。新しいパスワードでログインしてください。';

  @override
  String get authResetPasswordFailed => 'パスワードのリセットに失敗しました';

  @override
  String get settingsChangePassword => 'パスワードを変更';

  @override
  String get settingsCurrentPassword => '現在のパスワード';

  @override
  String get settingsEnterCurrentPassword => '現在のパスワードを入力';

  @override
  String get settingsEnterNewPassword => '新しいパスワードを入力';

  @override
  String get settingsPasswordChanged => 'パスワードが正常に変更されました。新しいパスワードでログインしてください。';

  @override
  String get settingsChangePasswordFailed => 'パスワードの変更に失敗しました';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      '新しいパスワードは現在のパスワードと異なる必要があります';

  @override
  String get settingsChangePasswordInfo =>
      'パスワードを変更すると、ログアウトされ、新しいパスワードでログインする必要があります。';

  @override
  String get settingsPasswordRequirements => 'パスワード要件：';

  @override
  String get settingsSecurityNote => 'セキュリティのため、パスワード変更後はすべてのデバイスで再ログインが必要です。';

  @override
  String get settingsSecurity => 'セキュリティ';

  @override
  String get settingsCurrentBoundEmail => '現在紐付けられているメールアドレス';

  @override
  String get settingsNewEmailAddress => '新しいメールアドレス';

  @override
  String get settingsEnterNewEmail => '新しいメールアドレスを入力';

  @override
  String get settingsVerificationCode => '確認コード';

  @override
  String get settingsVerificationCodeSent => '確認コードが送信されました';

  @override
  String get settingsCodeSentTo => '確認コードの送信先';

  @override
  String get settingsDidNotReceiveCode => 'コードが届きませんか？';

  @override
  String get settingsEmailChangedSuccess => 'メールアドレスが正常に変更されました';

  @override
  String get settingsChangeEmailFailed => 'メールアドレスの変更に失敗しました';

  @override
  String get settingsEmailSecurityNote =>
      'メールアドレスはパスワードの回復に使用されます。安全に保管してください。';

  @override
  String get commonGoogleLogin => 'Googleでサインイン';

  @override
  String get commonAppleLogin => 'Appleでサインイン';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsLanguageChanged => '言語が変更されました';

  @override
  String get settingsTranslation => '翻訳';

  @override
  String get settingsTranslateTextTo => 'テキストの翻訳先';

  @override
  String get settingsTranslateDescription => 'メッセージを翻訳する言語を選択してください。';

  @override
  String get settingsAutoTranslate => '受信メッセージを自動翻訳';

  @override
  String get settingsAutoTranslateDescription =>
      'チャットで受信したメッセージを選択した言語に自動翻訳します。';

  @override
  String get settingsBiometricLogin => '生体認証ログイン';

  @override
  String authLoginWithBiometric(Object type) {
    return '$typeでログイン';
  }

  @override
  String get settingsBiometricLoginEnabled => '生体認証ログインが有効になりました';

  @override
  String get settingsBiometricLoginDisabled => '生体認証ログインが無効になりました';

  @override
  String get settingsEnableBiometricLogin => '生体認証ログインを有効にする';

  @override
  String get settingsBiometricEnabled => '有効 - 生体認証でログイン';

  @override
  String get settingsBiometricDisabled => '無効 - タップして有効にする';

  @override
  String get settingsBiometricNeedRelogin =>
      '生体認証ログインを有効にするには、ログアウトして再度ログインしてください';

  @override
  String get authOr => 'または';

  @override
  String get qrcodeCameraPermissionRestricted => 'このデバイスではカメラアクセスが制限されています';

  @override
  String get authPasskeyLabel => 'パスキー';

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
  String get profileEnterPokeSuffixHint => 'つつきの接尾辞を入力、例：肩を';

  @override
  String get groupAlbum => 'グループアルバム';

  @override
  String get groupFiles => 'グループファイル';

  @override
  String get groupImages => '画像';

  @override
  String get groupVideos => '動画';

  @override
  String get groupTotal => '合計';

  @override
  String get groupSize => 'サイズ';

  @override
  String get groupNoMedia => 'メディアなし';

  @override
  String get groupNoMediaDescription => 'このグループにはまだ写真や動画がありません';

  @override
  String get groupDocuments => 'ドキュメント';

  @override
  String get groupNoFiles => 'ファイルなし';

  @override
  String get groupNoFilesDescription => 'このグループにはまだファイルがありません';

  @override
  String groupDownloadStarted(String filename) {
    return '$filenameをダウンロード中...';
  }

  @override
  String get contactNoCommonGroups => '共通のグループはありません';

  @override
  String get contactNoCommonGroupsDescription => '共通のグループがありません';

  @override
  String get chatVoiceMessage => '音声';

  @override
  String get chatMessage => 'メッセージ';

  @override
  String get conversationHideChat => '非表示';

  @override
  String get settingsQuickReply => 'クイック返信';

  @override
  String get commonTranslate => '翻訳';

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
    return '会話: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return '連絡先: $userId';
  }

  @override
  String get commonDiscover => '発見';

  @override
  String commonDeveloping(String title) {
    return '$title\n（近日公開）';
  }

  @override
  String get commonPageNotFound => 'ページが見つかりません';

  @override
  String get commonBackToHome => 'ホームに戻る';

  @override
  String get settingsMessageNotifications => 'メッセージ通知';

  @override
  String get settingsReceiveNewMessageNotifications => '新着メッセージ通知を受け取る';

  @override
  String get settingsShowMessagePreview => 'メッセージプレビューを表示';

  @override
  String get settingsShowMessageContentInNotification => '通知にメッセージ内容を表示';

  @override
  String get settingsNotificationSound => '通知音';

  @override
  String get settingsPlaySoundOnMessage => 'メッセージ受信時に音を鳴らす';

  @override
  String get commonVibration => 'バイブレーション';

  @override
  String get settingsVibrateOnMessage => 'メッセージ受信時にバイブレーション';

  @override
  String get settingsDoNotDisturbMode => 'おやすみモード';

  @override
  String get settingsDoNotDisturbDescription => '指定時間中は通知を受け取らない';

  @override
  String get settingsStartTime => '開始時間';

  @override
  String get settingsEndTime => '終了時間';

  @override
  String get settingsDeleteQuickReply => 'クイック返信を削除';

  @override
  String get settingsEditQuickReply => 'クイック返信を編集';

  @override
  String get settingsAddQuickReply => 'クイック返信を追加';

  @override
  String get settingsManageQuickReplies => 'クイック返信を管理';

  @override
  String get settingsNoQuickReplies => 'クイック返信はありません';

  @override
  String get settingsDefaultQuickReplies => 'デフォルトのクイック返信が表示されます';

  @override
  String get settingsWhoCanSee => '閲覧可能な人';

  @override
  String get settingsLastSeen => '最終オンライン';

  @override
  String get settingsHiddenChats => '非表示のチャット';

  @override
  String get settingsMessagesLabel => 'メッセージ';

  @override
  String get settingsAllowStrangerMessages => '知らない人からのメッセージを許可';

  @override
  String get settingsReceiveMessagesFromNonContacts => '連絡先以外からのメッセージを受け取る';

  @override
  String get settingsReadReceipts => '既読通知';

  @override
  String get settingsLetOthersKnowYouRead => '既読を相手に知らせる';

  @override
  String get settingsTypingIndicator => '入力中表示';

  @override
  String get settingsLetOthersKnowYouTyping => '入力中であることを相手に知らせる';

  @override
  String get settingsEveryone => '全員';

  @override
  String get settingsContactsOnly => '連絡先のみ';

  @override
  String get settingsNobody => '誰にも表示しない';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return '$titleを見られる人';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'バージョン $version';
  }

  @override
  String get settingsCheckForUpdates => 'アップデートを確認';

  @override
  String get settingsOpenSourceLicenses => 'オープンソースライセンス';

  @override
  String get settingsFeedbackAndSuggestions => 'フィードバックと提案';

  @override
  String get settingsBuiltOnMatrix => 'Matrixプロトコルを基盤';

  @override
  String get settingsNoHiddenChats => '非表示のチャットはありません';

  @override
  String get settingsNoHiddenChatsDescription => '非表示にしたチャットがここに表示されます';

  @override
  String get settingsUnhideChat => '再表示';

  @override
  String get settingsDarkMode => 'ダークモード';

  @override
  String get settingsFontSize => 'フォントサイズ';

  @override
  String get settingsBubbleStyle => '吹き出しスタイル';

  @override
  String get settingsFollowSystem => 'システムに従う';

  @override
  String get settingsAutoSwitchBySystem => 'システム設定に応じて自動切り替え';

  @override
  String get settingsLightMode => 'ライトモード';

  @override
  String get settingsAlwaysUseLightTheme => '常にライトテーマを使用';

  @override
  String get settingsDarkModeOption => 'ダークモード';

  @override
  String get settingsAlwaysUseDarkTheme => '常にダークテーマを使用';

  @override
  String get settingsFontSizeSmall => '小';

  @override
  String get settingsFontSizeStandard => '標準';

  @override
  String get settingsFontSizeLarge => '大';

  @override
  String get settingsFontSizeExtraLarge => '特大';

  @override
  String get settingsBubbleStyleWechat => 'WeChatスタイル';

  @override
  String get settingsBubbleStyleWechatDesc => 'クラシックなWeChat吹き出しスタイル';

  @override
  String get settingsBubbleStyleModern => 'モダンスタイル';

  @override
  String get settingsBubbleStyleModernDesc => 'シンプルでモダンな吹き出しスタイル';

  @override
  String get settingsBubbleStyleClassic => 'クラシックスタイル';

  @override
  String get settingsBubbleStyleClassicDesc => '伝統的な吹き出しスタイル';

  @override
  String get discoverVideoChannels => 'チャンネル';

  @override
  String get discoverLive => 'ライブ';

  @override
  String get discoverListen => '聴く';

  @override
  String get discoverWatch => '見る';

  @override
  String get discoverSearchDiscover => '検索';

  @override
  String get discoverNearbyPeople => '近くの人';

  @override
  String get discoverGames => 'ゲーム';

  @override
  String get discoverMiniPrograms => 'ミニプログラム';

  @override
  String get chatAlreadyInCall => '通話中です';

  @override
  String get commonConnectionFailed => '接続に失敗しました';

  @override
  String get chatCallRejected => '通話が拒否されました';

  @override
  String get chatNoAnswer => '応答なし';

  @override
  String get commonClose => '閉じる';

  @override
  String get chatSelectContact => '連絡先を選択';

  @override
  String get chatVoteRemoved => '投票を取り消しました';

  @override
  String get chatVoteChanged => '投票を変更しました';

  @override
  String get chatVoted => '投票しました';

  @override
  String chatReplyTo(String name) {
    return '$nameへの返信';
  }

  @override
  String get chatCurrentLocation => '現在地';

  @override
  String chatNearbyPlace(int index) {
    return '近くの場所 $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return '約$distance';
  }

  @override
  String get chatAddress => '住所';

  @override
  String get chatLatitude => '緯度';

  @override
  String get chatLongitude => '経度';

  @override
  String get groupDescriptionUpdated => 'グループの説明を更新しました';

  @override
  String get groupAvatarUpdated => 'グループのアバターを更新しました';

  @override
  String get callDecline => '拒否';

  @override
  String get callAnswer => '応答';

  @override
  String get callIncomingVideoCall => 'ビデオ通話の着信';

  @override
  String get callIncomingVoiceCall => '音声通話の着信';

  @override
  String get callVideoCallInProgress => 'ビデオ通話中';

  @override
  String get callVoiceCallInProgress => '音声通話中';

  @override
  String get callReconnectingCall => '再接続中...';

  @override
  String get callEnded => '通話終了';

  @override
  String get callFailed => '通話失敗';

  @override
  String get callLivekitNotConfigured => 'LiveKitが設定されていません';

  @override
  String callJoinMeetingFailed(String error) {
    return 'ミーティングへの参加に失敗しました: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return '画面共有に失敗しました: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42ビーン';

  @override
  String get profileNoN42Bean => 'N42ビーンなし';

  @override
  String get profileN42BeanDetails => 'N42ビーン詳細';

  @override
  String get profileN42BeanDescription =>
      'N42ビーンはN42内の仮想アイテムやサービスを交換するためのトークンです。現在利用可能：';

  @override
  String get profileN42BeanFeature1 => '会員限定スタンプとテーマ';

  @override
  String get profileN42BeanFeature2 => 'チャットバブルのカスタマイズ';

  @override
  String get profileN42BeanFeature3 => '紅包カバーのカスタマイズ';

  @override
  String get profileN42BeanFeature4 => '限定ニックネームバッジ';

  @override
  String get profileN42BeanFeature5 => 'グループチャット特権';

  @override
  String get profileN42BeanFeature6 => 'クラウドストレージ拡張';

  @override
  String get profileN42BeanFeature7 => 'ビデオ通話美顔フィルター';

  @override
  String get profileN42BeanFeature8 => 'モーメント背景カスタマイズ';

  @override
  String get profileN42BeanFeature9 => 'VIPカスタマーサービス優先';

  @override
  String get profileGotIt => '了解';

  @override
  String get profileNoN42BeanRecords => 'N42ビーン記録なし';

  @override
  String get profileMoodAndThoughts => '気分 & 思い';

  @override
  String get profileStatusHappy => '嬉しい';

  @override
  String get profileStatusCracked => '疲れた';

  @override
  String get profileStatusLucky => 'ラッキー';

  @override
  String get profileStatusSunny => '晴れやか';

  @override
  String get profileStatusTired => '疲れた';

  @override
  String get profileStatusDaydream => '空想中';

  @override
  String get profileStatusRushing => '急いでいる';

  @override
  String get profileStatusOverthinking => '考えすぎ';

  @override
  String get profileStatusEnergized => '元気いっぱい';

  @override
  String get profileWorkAndStudy => '仕事 & 勉強';

  @override
  String get profileStatusWorking => '仕事中';

  @override
  String get profileStatusStudying => '勉強中';

  @override
  String get profileStatusBusy => '忙しい';

  @override
  String get profileStatusSlacking => 'サボり中';

  @override
  String get profileStatusTraveling => '旅行中';

  @override
  String get profileStatusGoingHome => '帰宅中';

  @override
  String get profileStatusDnd => '取り込み中';

  @override
  String get profileActivities => 'アクティビティ';

  @override
  String get profileStatusHanging => '遊び中';

  @override
  String get profileStatusCheckIn => 'チェックイン';

  @override
  String get profileStatusExercising => '運動中';

  @override
  String get profileStatusCoffee => 'コーヒー';

  @override
  String get profileStatusBubbleTea => 'タピオカ';

  @override
  String get profileStatusEating => '食事中';

  @override
  String get profileStatusParenting => '子育て中';

  @override
  String get profileStatusSavingWorld => '世界を救う';

  @override
  String get profileStatusSelfie => '自撮り';

  @override
  String get profileRest => '休憩';

  @override
  String get profileStatusRetreat => '静養中';

  @override
  String get profileStatusHome => '在宅';

  @override
  String get profileStatusSleeping => '睡眠中';

  @override
  String get profileStatusCatLover => '猫好き';

  @override
  String get profileStatusDogWalking => '犬の散歩中';

  @override
  String get profileStatusGaming => 'ゲーム中';

  @override
  String get profileStatusListening => '音楽を聴いてる';

  @override
  String get profileEditAddress => '住所を編集';

  @override
  String get profileRecipient => '受取人';

  @override
  String get profileEnterRecipientName => '受取人の名前を入力';

  @override
  String get profilePhoneNumber => '電話番号';

  @override
  String get profileEnterPhoneNumber => '電話番号を入力';

  @override
  String get profileRegionHint => '都道府県/市区町村';

  @override
  String get profileDetailedAddress => '詳細住所';

  @override
  String get profileDetailedAddressHint => '番地、建物名など';

  @override
  String get profileSetAsDefaultAddress => 'デフォルトの住所に設定';

  @override
  String get profilePleaseCompleteInfo => 'すべての項目を入力してください';

  @override
  String get profileEditInvoice => '請求書を編集';

  @override
  String get profileInvoiceType => '請求書の種類: ';

  @override
  String get profileCompanyName => '会社名';

  @override
  String get profilePersonalName => '個人名';

  @override
  String get profileEnterCompanyName => '会社名を入力';

  @override
  String get profileEnterName => '名前を入力';

  @override
  String get profileTaxIdNumber => '税務ID番号';

  @override
  String get profileEnterTaxIdNumber => '税務ID番号を入力';

  @override
  String get profileBankNameOptional => '銀行名（任意）';

  @override
  String get profileEnterBankName => '銀行名を入力';

  @override
  String get profileBankAccountOptional => '銀行口座（任意）';

  @override
  String get profileEnterBankAccount => '銀行口座を入力';

  @override
  String get profileCompanyAddressOptional => '会社住所（任意）';

  @override
  String get profileEnterCompanyAddress => '会社住所を入力';

  @override
  String get profileCompanyPhoneOptional => '会社電話（任意）';

  @override
  String get profileEnterCompanyPhone => '会社電話を入力';

  @override
  String get profileSetAsDefaultInvoice => 'デフォルトの請求書に設定';

  @override
  String get profileRingtoneVibrate => 'バイブレーション';

  @override
  String get profileRingtoneSilent => 'サイレント';

  @override
  String get profileVibrateMode => 'バイブレーションモード';

  @override
  String get profileSilentMode => 'サイレントモード';

  @override
  String profilePlayFailed(String ringtoneName) {
    return '再生に失敗しました: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return '再生中: $ringtoneName';
  }

  @override
  String get profileStop => '停止';

  @override
  String get profileSelectRingtone => '着信音を選択';

  @override
  String get profileLoadingRingtones => '着信音を読み込み中...';

  @override
  String get profileNoRingtonesFound => '着信音が見つかりません';

  @override
  String mainMessagesWithCount(int count) {
    return 'メッセージ($count)';
  }

  @override
  String get storyViewers => '閲覧者';

  @override
  String get storyNoViewers => 'まだ閲覧者はいません';

  @override
  String get storyReplyToStory => 'ストーリーに返信...';

  @override
  String get commonCopiedToClipboard => 'クリップボードにコピーしました';

  @override
  String get commonMore => 'もっと見る';

  @override
  String get commonTranslating => '翻訳中...';

  @override
  String commonTranslatedFrom(String language) {
    return '$languageから翻訳';
  }

  @override
  String get commonTranslation => '翻訳';

  @override
  String get commonTranslationFailed => '翻訳に失敗しました';

  @override
  String get commonAllRead => 'すべて既読';

  @override
  String commonReadCount(int count) {
    return '$count人が既読';
  }

  @override
  String get commonYouRecalledMessage => 'メッセージを取り消しました';

  @override
  String get commonMessageRecalled => 'メッセージが取り消されました';

  @override
  String get commonReEdit => '再編集';

  @override
  String get commonWalletArea => 'ウォレットエリア';

  @override
  String get callIncomingCall => '着信';

  @override
  String get callMissedCall => '不在着信';

  @override
  String get groupRemoveAdmin => '管理者を解除';

  @override
  String get chatSelectCurrency => '通貨を選択';

  @override
  String get chatSelectEmoji => '絵文字を選択';

  @override
  String get chatSelectRedPacketCover => 'カバーを選択';

  @override
  String get groupSetAsAdmin => '管理者に設定';

  @override
  String get chatVideoPlaybackFailed => '動画の再生に失敗しました';

  @override
  String get groupViewProfile => 'プロフィールを表示';

  @override
  String get favoriteAddLinkComingSoon => 'リンク追加機能は近日公開';

  @override
  String get favoriteNewNoteComingSoon => '新規メモ機能は近日公開';

  @override
  String get qrcodeSaveFeatureComingSoon => '保存機能は近日公開';

  @override
  String get qrcodeShareFeatureComingSoon => '共有機能は近日公開';

  @override
  String qrcodeProcessFailed(String error) {
    return 'QRコードの処理に失敗しました: $error';
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
  String get gameCenter => 'ゲーム';

  @override
  String get gameHighScore => 'ベスト';

  @override
  String get gameScore => 'スコア';

  @override
  String get gameOver => 'ゲームオーバー';

  @override
  String get gamePlayAgain => 'もう一度';

  @override
  String get gameLeaderboard => 'ランキング';

  @override
  String get gamePause => '一時停止中';

  @override
  String get gameResume => 'タップで再開';

  @override
  String get gameConfirmExit => 'ゲームを終了しますか？';

  @override
  String get gameNoScores => '記録なし';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'タイルを合体させて2048を目指せ';

  @override
  String get gameBlockDrop => 'ブロック落とし';

  @override
  String get gameBlockDropDesc => 'ブロックを落として行を消そう';

  @override
  String get gameMinesweeper => 'マインスイーパー';

  @override
  String get gameMinesweeperDesc => '安全なマスを全て見つけよう';

  @override
  String get gameMatch3 => 'マッチ3';

  @override
  String get gameMatch3Desc => '3つ以上の宝石を繋げよう';

  @override
  String get gameMinesweeperEasy => '初級';

  @override
  String get gameMinesweeperMedium => '中級';

  @override
  String get gameMinesLeft => '残り地雷数';

  @override
  String get gameTimeLeft => '時間';

  @override
  String get gameLevel => 'レベル';

  @override
  String get gameNext => '次';

  @override
  String get gameBestTime => 'ベストタイム';

  @override
  String get gameNewRecord => '新記録！';

  @override
  String get gameLines => 'ライン';

  @override
  String get storyMyStory => '我的动态';

  @override
  String get storageSmartCleanup => '智能清理';

  @override
  String get storageOldMediaFiles => '旧媒体文件';

  @override
  String get storageLargeFiles => '大文件';

  @override
  String get storageAppCache => '应用缓存';

  @override
  String get storageSettings => '存储设置';

  @override
  String get storageAutoCleanup => '自动清理';

  @override
  String storageAutoCleanupDesc(int days) {
    return '自动清理 $days 天以上未访问的文件';
  }

  @override
  String get storageCleanupPeriod => '清理周期';

  @override
  String get storagePreserveThumbnails => '保留缩略图';

  @override
  String get storagePreserveThumbnailsDesc => '清理时保留图片缩略图';

  @override
  String get storageWarningHigh => '存储空间较高，建议清理旧文件。';

  @override
  String get storageWarningCritical => '存储空间严重不足，请立即清理。';

  @override
  String storageFreed(String size, int count) {
    return '已释放 $size（$count 个文件）';
  }

  @override
  String storageDays(int days) {
    return '$days 天';
  }

  @override
  String storageViewAllRooms(int count) {
    return '查看全部 $count 个房间';
  }

  @override
  String get storageNoFiles => '暂无文件';

  @override
  String get storageFilePinned => '已保留';

  @override
  String storageDeleteSelected(int count) {
    return '删除 $count 个选中文件？文件可从服务器重新下载。';
  }

  @override
  String get backupRestore => '备份与恢复';

  @override
  String get backupCreate => '创建备份';

  @override
  String get backupCreateDesc => '备份设置和加密密钥。消息将在重新登录后从服务器恢复。';

  @override
  String get backupIncludeKeys => '包含加密密钥';

  @override
  String get backupIncludeKeysDesc => '读取加密消息所必需';

  @override
  String get backupPasswordProtect => '密码保护';

  @override
  String get backupEnterPassword => '输入备份密码';

  @override
  String get backupHistory => '备份历史';

  @override
  String get backupNoBackups => '暂无备份';

  @override
  String get backupRestore2 => '恢复';

  @override
  String get backupDelete => '删除';

  @override
  String get backupDeleteConfirm => '确定删除此备份？此操作不可撤销。';

  @override
  String get backupRestoreFromFile => '从文件恢复';

  @override
  String get backupRestoreFromFileDesc => '导入来自其他设备或之前备份的 .n42backup 文件。';

  @override
  String get backupChooseFile => '选择备份文件';

  @override
  String get backupRestoring => '恢复中...';

  @override
  String backupCreated(int rooms, int messages) {
    return '备份已创建：$rooms 个房间，$messages 条消息';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return '已恢复 $settings 项设置（来自 $rooms 个房间）';
  }

  @override
  String backupFailed(String error) {
    return '备份失败：$error';
  }

  @override
  String get backupPasswordRequired => '此备份需要密码';

  @override
  String get blocGroupNotFound => '群组未找到';

  @override
  String blocGroupMembersInvited(int count) {
    return '已邀请$count位成员';
  }

  @override
  String get blocGroupMemberRemoved => '成员已移除';

  @override
  String get blocGroupAdminRemoved => '已取消管理员';

  @override
  String get blocGroupLeft => '已退出群聊';

  @override
  String get blocGroupDisbanded => '群聊已解散';

  @override
  String get blocGroupJoined => '已加入群聊';

  @override
  String get blocGroupInviteDeclined => '已拒绝邀请';

  @override
  String get blocGroupTokenGateUpdated => 'Token 门槛已更新';

  @override
  String get blocTransferProcessing => '转账处理中...';

  @override
  String get blocTransferCancelled => '转账已取消';

  @override
  String get blocTransferFailed => '转账失败';

  @override
  String get blocPaymentProcessing => '支付处理中...';

  @override
  String get blocPaymentFailed => '支付失败';

  @override
  String get groupMaxMembers => '群人数上限';

  @override
  String get groupMaxMembersUnlimited => '不限';

  @override
  String get groupMaxMembersHint => '输入上限（留空表示不限）';

  @override
  String get groupMaxMembersUpdated => '群人数上限已更新';

  @override
  String get groupFull => '群已满员';

  @override
  String get groupChannels => '话题频道';

  @override
  String get groupChannelsEmpty => '暂无话题频道';

  @override
  String get groupChannelsCount => '个频道';

  @override
  String get groupChannelCreate => '新建频道';

  @override
  String get groupChannelName => '频道名称';

  @override
  String get groupChannelTopic => '频道话题（可选）';

  @override
  String get groupChannelDelete => '删除频道';

  @override
  String get groupChannelDeleteConfirm => '确认删除此频道？消息不可恢复。';

  @override
  String get groupBotSettings => 'Bot 设置';

  @override
  String get groupBotEnabled => '启用 Bot';

  @override
  String get groupBotWelcomeMessage => '欢迎语模板';

  @override
  String get groupBotWelcomeHint => '用 \'name\' 作为新成员名字占位符';

  @override
  String get groupBotConfigUpdated => 'Bot 设置已更新';

  @override
  String get groupContentFilter => '关键词过滤';

  @override
  String get groupContentFilterEnabled => '启用关键词过滤';

  @override
  String get groupContentFilterReplace => '替换为 ***';

  @override
  String get groupContentFilterHide => '隐藏消息';

  @override
  String get groupContentFilterAddWord => '添加关键词';

  @override
  String get groupContentFilterUpdated => '内容过滤设置已更新';

  @override
  String get chatSlashCommands => '指令';

  @override
  String get chatCommandPoll => '/poll — 创建投票';

  @override
  String get chatCommandAnnounce => '/announce — 发布公告';

  @override
  String get chatCommandWelcome => '/welcome — 设置欢迎语';

  @override
  String get chatReportMessage => '举报';

  @override
  String get chatReportReason => '举报原因';

  @override
  String get chatReportSpam => '垃圾信息';

  @override
  String get chatReportHarassment => '骚扰';

  @override
  String get chatReportInappropriate => '违规内容';

  @override
  String get chatReportOther => '其他';

  @override
  String get chatReportSuccess => '举报已提交';

  @override
  String get spacesName => '社区名称';

  @override
  String get spacesNameHint => '例如：加密交易者';

  @override
  String get spacesNameRequired => '请输入社区名称';

  @override
  String get spacesDescription => '简介';

  @override
  String get spacesDescriptionHint => '介绍一下这个社区';

  @override
  String get spacesType => '社区类型';

  @override
  String get spacesPublicDesc => '任何人均可发现并加入';

  @override
  String get spacesPrivateDesc => '仅受邀成员可加入';

  @override
  String get spacesNotFound => '社区不存在';

  @override
  String get spacesSearch => '搜索社区...';

  @override
  String get spacesMembers => '成员';

  @override
  String get spacesNoChannels => '暂无频道';

  @override
  String get spacesLeave => '退出社区';

  @override
  String spacesLeaveConfirm(String name) {
    return '确定要退出「$name」吗？';
  }

  @override
  String get spacesDelete => '解散社区';

  @override
  String spacesDeleteConfirm(String name) {
    return '此操作将永久删除「$name」及其所有频道，且不可撤销。';
  }

  @override
  String get spacesCreateChannel => '创建频道';

  @override
  String get spacesChannelName => '频道名称';

  @override
  String get spacesChannelTopic => '话题（可选）';

  @override
  String get spacesDeleteChannel => '删除频道';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return '确定要删除频道「#$name」吗？';
  }

  @override
  String get spacesEditName => '修改名称';

  @override
  String get spacesEditDescription => '修改简介';

  @override
  String spacesViewAllMembers(int count) {
    return '查看全部 $count 位成员';
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
  String get spacesPromoteAdmin => '设为管理员';

  @override
  String get spacesDemoteAdmin => '撤销管理员';

  @override
  String get spacesInviteMember => '邀请成员';

  @override
  String get spacesInviteMemberUserId => '用户 ID（如 @user:server.com）';

  @override
  String get spacesSave => '保存';

  @override
  String get settingsScreenshotProtection => '截图防护';

  @override
  String get settingsScreenshotProtectionDesc => '防止截图和屏幕录制';

  @override
  String get chatSelfDestructTimer => '阅后即焚';

  @override
  String get chatTimerPickerTitle => '设置阅后即焚时间';

  @override
  String get chatTimerOff => '关闭';

  @override
  String get onChainNotificationsTitle => 'チェーンイベント';

  @override
  String get onChainMarkAllRead => 'すべて既読';

  @override
  String get onChainNoNotifications => 'オンチェーンイベントはまだありません';

  @override
  String get onChainNoNotificationsDesc => '購読チャンネルのイベントがここに表示されます';

  @override
  String get onChainViewDetails => '詳細を見る';

  @override
  String get chatCommandHelp => '/help — 全コマンドを表示';

  @override
  String get chatCommandPrice => '/price — トークン価格を取得';

  @override
  String get chatCommandBalance => '/balance — ウォレット残高を表示';

  @override
  String get chatCommandChains => '/chains — 236以上のチェーン一覧';

  @override
  String get chatMiniApps => 'アプリ';

  @override
  String get miniAppMarketTitle => 'ミニアプリ';

  @override
  String get miniAppCategoryAll => 'すべて';

  @override
  String get miniAppSearch => 'アプリを検索...';

  @override
  String get miniAppFeatured => '注目';

  @override
  String get miniAppAllApps => 'すべてのアプリ';

  @override
  String get miniAppNoResults => 'アプリが見つかりません';

  @override
  String get slideToPayLabel => '→→→  スライドして確認';

  @override
  String get slideToPayConfirming => '確認中...';

  @override
  String get redPacketBestLuck => 'ベストラック';

  @override
  String get redPacketBestLuckCongrats => 'ベストラック！一番多く獲得しました！';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total 受取済';
  }

  @override
  String get redPacketStatsTotal => '合計';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 赤い封筒を受け取りました • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id  •  0x ウォレット  •  name.eth';

  @override
  String get web3SearchPlaceholder => 'ID・ウォレット・ENS で検索...';

  @override
  String get web3WalletAddress => 'ウォレットアドレス';

  @override
  String get web3AddressCopied => 'アドレスをコピーしました';

  @override
  String get web3Copy => 'コピー';

  @override
  String get web3SendMessage => 'メッセージを送る';

  @override
  String get web3SendToWallet => 'ウォレットにメッセージ';

  @override
  String get web3WalletOnlyHint => 'このアドレスはまだ N42 アカウントがありません。参加後にメッセージが届きます。';

  @override
  String get web3NftAvatar => 'NFT アバター';

  @override
  String get web3ResolveFailed => 'アイデンティティの解決に失敗しました';

  @override
  String web3EnsNotFound(String name) {
    return 'ENS 名「$name」が見つかりません';
  }

  @override
  String get web3NoN42AccountTitle => 'N42 アカウントなし';

  @override
  String get web3NoN42AccountDesc =>
      'This wallet address has no N42 account yet. You can share your N42 invite link with them to get started.';

  @override
  String get web3ShareInvite => '招待を共有';

  @override
  String get nftPickerTitle => 'NFT アバターを選択';

  @override
  String get nftPickerTabPopular => '人気';

  @override
  String get nftPickerTabCustom => 'カスタム';

  @override
  String get nftPickerChain => 'Chain';

  @override
  String get nftPickerContract => 'Contract Address';

  @override
  String get nftPickerTokenId => 'Token ID';

  @override
  String get nftPickerVerifyOwnership => '所有権を確認してプレビュー';

  @override
  String get nftPickerUseAsAvatar => 'アバターとして使用';

  @override
  String get nftPickerPreview => 'Preview';

  @override
  String get nftPickerNotOwned => 'このNFTを所有していません';

  @override
  String get nftPickerInvalidTokenId => 'Invalid token ID';

  @override
  String get nftPickerEnterBoth => 'Enter contract address and token ID';

  @override
  String get nftPickerInfoTitle => 'NFT アバター — オンチェーン確認済み';

  @override
  String get nftPickerInfoDesc =>
      'Bind an NFT you own as your avatar. Anyone can verify ownership on-chain. Displayed with a gold ring across N42.';

  @override
  String get nftPickerPopularCollections => '人気コレクション';

  @override
  String get nftPickerWalletHint => 'N42 ウォレットを接続して、236 以上のチェーンの NFT を自動検出します。';

  @override
  String get profileBindNftAvatar => 'NFTアバターをバインド';

  @override
  String get profileChangeAvatar => 'アバターを変更';

  @override
  String get groupTopics => 'トピック';

  @override
  String get groupTopicsEmpty => 'トピックがありません';

  @override
  String get syncInProgress => 'メッセージ履歴を同期中...';

  @override
  String get recoveryKeyReminderTitle => 'メッセージを保護';

  @override
  String get recoveryKeyReminderDesc =>
      '複数のデバイスで暗号化されたメッセージを安全に同期するために回復キーを作成してください';

  @override
  String get recoveryKeySetupNow => '今すぐ設定';

  @override
  String get recoveryKeyRemindLater => '後で通知';

  @override
  String get channelReadOnly => '管理者のみ投稿可能なチャンネルです';

  @override
  String get channelSubscribers => '登録者';

  @override
  String get channelVerified => '認証済みチャンネル';

  @override
  String get redPacketHistory => 'お年玉履歴';

  @override
  String get redPacketSent => '送信済み';

  @override
  String get redPacketReceived => '受信済み';

  @override
  String get redPacketExpired => '期限切れ';

  @override
  String get redPacketClaimed => '受領済み';

  @override
  String get redPacketInsufficientBalance => '残高不足';

  @override
  String selfDestructCountdown(String time) {
    return '$time後に削除';
  }

  @override
  String get messageDestroyed => 'メッセージは削除されました';

  @override
  String miniAppPermissionDenied(String permission) {
    return '権限がありません：$permission';
  }

  @override
  String get aiSuggestionGasFee => 'ガス代とは？';

  @override
  String get aiSuggestionDefi => 'DeFi入門';

  @override
  String get aiSuggestionSecurity => 'コントラクトの安全性確認方法';

  @override
  String get aiSuggestionBridge => 'クロスチェーンブリッジ';

  @override
  String get channelDiscoverTitle => 'チャンネルを探す';

  @override
  String get channelDiscoverSearch => 'チャンネルを検索...';

  @override
  String get channelJoin => '参加';

  @override
  String get channelJoined => '参加中';

  @override
  String get channelCategory => 'カテゴリ';

  @override
  String slowModeCooldown(int seconds) {
    return 'スローモード：$seconds秒お待ちください';
  }

  @override
  String get addressCopyAction => 'アドレスをコピー';

  @override
  String get addressSendMessage => 'メッセージを送る';

  @override
  String get addressViewProfile => 'プロフィールを見る';

  @override
  String get sendToAddress => 'ウォレットアドレスに送信';
}
