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
  String authLoginFailed(Object error) {
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
      'マイクの許可が拒否されました。音声メッセージを使用するには、システム設定で有効にしてください。';

  @override
  String commonStartRecordingFailed(Object error) {
    return '録音の開始に失敗しました: $error';
  }

  @override
  String get commonRecordingTooShort => '録音が短すぎます';

  @override
  String commonStopRecordingFailed(Object error) {
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
  String get chatReadAloud => '声に出して読む';

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
  String contactN42Id(Object id) {
    return 'N42 ID:$id';
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
  String profileSaveFailed(Object error) {
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
  String authConnectedTo(Object serverName) {
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
  String commonFeatureComingSoon(Object feature) {
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
  String conversationDeleteConversationConfirm(Object name) {
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
  String get contactChatOnlyFriends => 'チャット専用の友達';

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
  String contactRecommendFailed(Object error) {
    return 'おすすめに失敗しました: $error';
  }

  @override
  String get profileEnterRemark => 'メモを入力';

  @override
  String get contactOpeningChat => 'チャットを開いています...';

  @override
  String contactOpenChatFailed(Object error) {
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
  String commonGroupMembers(Object count) {
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
  String transferAvailableBalance(Object balance, Object symbol) {
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
  String commonFromSender(String name) {
    return '$nameから';
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
  String commonSelectImageFailed(Object error) {
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
  String profileSaveAddressFailed(Object error) {
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
  String profileSaveInvoiceFailed(Object error) {
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
  String favoriteOpenItem(Object content) {
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
  String commonFeatureInDevelopment(Object feature) {
    return '$feature機能は開発中です…';
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
  String get authRegistrationDisabled =>
      'このサーバーでは登録が無効になっています。有効にするにはサーバー管理者にお問い合わせください。';

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
    return 'N42 ID:$id';
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
  String get searchClearHistoryConfirm => '最近の検索履歴をすべて消去しますか？';

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
  String get settingsDeleteAccountTitle => 'アカウントを削除';

  @override
  String get settingsDeleteAccountSubtitle =>
      'この Matrix アカウントを無効化し、端末内のチャットデータを削除します';

  @override
  String get settingsDeleteAccountExplanation =>
      'Matrix アカウントの恒久的な無効化を要求します。サーバーで確認された後、安全に実行できる時点で、このアカウントの端末内チャットセッションと暗号鍵を削除します。他のアカウントとウォレットは保持されます。連合サーバーや保存ポリシーにより、データを完全に消去できない場合があります。';

  @override
  String get settingsDeleteAccountPasswordOptional => '要求された場合の Matrix パスワード';

  @override
  String get settingsDeleteAccountServerErase => 'サーバー上のデータ消去を要求';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      '対応しているホームサーバーにアカウントデータの消去を要求します。他のサーバーが保持するコピーや保存義務のあるデータは残る場合があります。';

  @override
  String get settingsDeleteAccountChooseStage => 'この Matrix アカウントを確認';

  @override
  String get settingsDeleteAccountUsePassword => 'Matrix パスワードを使用';

  @override
  String get settingsDeleteAccountUseBrowser => 'ブラウザーで続行';

  @override
  String get settingsDeleteAccountFallbackTitle => 'Matrix の確認から戻る';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      'ブラウザーから戻っただけでは削除は確定しません。元の要求を Matrix サーバーで確認してください。';

  @override
  String get settingsDeleteAccountCheckServer => 'サーバーで確認';

  @override
  String get settingsDeleteAccountRequestFailed =>
      'Matrix サーバーはアカウント削除を確認していません。';

  @override
  String get settingsDeleteAccountPendingTitle => '端末内アカウントデータの削除待ち';

  @override
  String get settingsDeleteAccountPendingSubtitle =>
      '以前無効化した Matrix アカウントの削除処理を確認';

  @override
  String get settingsDeleteAccountPendingReadError =>
      '削除待ちの記録を読み取れません。タップして再試行してください。';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'Matrix アカウントは無効化されましたが、端末内データの削除は保留中です。他のアカウントは引き続き使用できます。';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      'ブラウザーでアカウント管理を開きました。このアプリでは削除を確認できていないため、チャットセッションは引き続き使用できます。';

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
  String get settingsBackupSuccess => 'キーは正常にバックアップされました';

  @override
  String get settingsBackupFailed => 'バックアップに失敗しました';

  @override
  String get settingsRecoveryKey => '回復キー';

  @override
  String get settingsRecoveryKeySaveWarning =>
      'この回復キーを安全な場所に保存してください。新しいデバイスで暗号化されたメッセージを復元するために必要になります。';

  @override
  String get settingsRecoveryKeySaved => '保存しました';

  @override
  String get settingsRestoreSuccess => 'キーは正常に復元されました';

  @override
  String get settingsRestoreEmpty => 'このバックアップにはメッセージの鍵がありません。';

  @override
  String settingsRestoreSessions(int count) {
    return '$count 件の鍵セッションを復元しました。鍵のないメッセージは暗号化されたままの場合があります。';
  }

  @override
  String get settingsRestoreFailed => '復元に失敗しました';

  @override
  String get settingsPassword => 'パスワード';

  @override
  String get settingsEnterRecoveryKey => '回復キーを入力してください';

  @override
  String get settingsEnterPassword => 'パスワードを入力してください';

  @override
  String get settingsExportSuccess => 'キーがサーバー バックアップに正常にエクスポートされました';

  @override
  String get settingsExportNeedBackupFirst => '最初にキーのバックアップを作成してください';

  @override
  String get settingsExportFailed => 'エクスポートに失敗しました';

  @override
  String get settingsResetSuccess => '暗号化のリセットが成功しました';

  @override
  String get settingsResetFailed => 'リセットに失敗しました';

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
  String get chatNoMediaUrlAvailable => 'メディアURLがありません';

  @override
  String chatDownloadFailed(String code) {
    return 'ダウンロード失敗: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return 'エラー: $message';
  }

  @override
  String get chatMusicLinkLabel => '音楽リンク';

  @override
  String get chatRedPacketTransferCannotForward => '紅包と送金は転送できません';

  @override
  String commonShareFailed(String error) {
    return '共有に失敗しました: $error';
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
  String groupMemberCountClickToCopy(Object count) {
    return '$count人、クリックしてグループIDをコピー';
  }

  @override
  String get groupNoPermissionToEditGroupName => 'グループ名を編集する権限がありません';

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
  String get commonWechat => '微信';

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
  String get authGoogleLabel => 'グーグル';

  @override
  String get authAppleLabel => 'アップル';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get authSsoNotConfigured => 'このサーバーはSSOログインプロバイダーを設定していません';

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
  String get contactCreateTag => 'タグの作成';

  @override
  String get contactEnterTagName => 'タグ名を入力してください';

  @override
  String get contactEditTag => 'タグの編集';

  @override
  String get contactDeleteTag => 'タグの削除';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'タグ「$tagName」を削除してもよろしいですか?';
  }

  @override
  String get contactNoTags => 'まだタグがありません';

  @override
  String get contactFriendPermissions => '友達の権限';

  @override
  String get contactSetChatOnly => 'チャット専用として設定';

  @override
  String get contactChatOnlyDesc => 'あなたとのみチャットできます。他のコンテンツは非表示になります';

  @override
  String get contactHideMyMoments => '私の瞬間を隠す';

  @override
  String get contactHideMyMomentsDesc => 'この友達は私のモーメントを見ることができません';

  @override
  String get contactHideTheirMoments => '瞬間を隠す';

  @override
  String get contactHideTheirMomentsDesc => 'この友達のモーメントを表示しない';

  @override
  String get contactHideMyStatus => '自分のステータスを隠す';

  @override
  String get contactHideMyStatusDesc => 'この友人は私のステータス更新を見ることができません';

  @override
  String get contactNoChatOnlyFriends => 'チャット専用の友達はいません';

  @override
  String get contactNoOfficialAccounts => '公式アカウントはありません';

  @override
  String get contactFollowOfficialAccountsDesc => '公式アカウントをフォローして最新情報を入手してください';

  @override
  String get contactNoServiceAccounts => 'サービスアカウントがありません';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      '便利なサービスを利用するためのサービスアカウントを購読する';

  @override
  String get contactNoEnterpriseContacts => '企業の連絡先はありません';

  @override
  String get contactEnterpriseContactsDesc => '企業の連絡先がここに表示されます';

  @override
  String get profileCardPack => 'カードパック';

  @override
  String get profileOrders => '注文';

  @override
  String get profileNoOrders => '注文はありません';

  @override
  String get profileOrdersDesc => 'ご注文はここに表示されます';

  @override
  String get profileNoCards => 'カードなし';

  @override
  String get profileCardsDesc => 'ここにカードが表示されます';

  @override
  String get favoriteEnterTagsHint => 'タグをカンマで区切って入力します';

  @override
  String get favoriteTagsUpdated => 'タグが更新されました';

  @override
  String get favoriteForwardedContent => '転送されたコンテンツ';

  @override
  String get favoriteEnterNoteContent => 'メモの内容を入力してください';

  @override
  String get favoriteNoteAdded => '注記を追加しました';

  @override
  String get favoriteLinkTitle => 'リンクタイトル';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'リンクを追加しました';

  @override
  String get contactPhotoAdded => '写真を追加しました';

  @override
  String get contactEnterPhone => '電話番号を入力してください';

  @override
  String commonConversationWithId(Object roomId) {
    return '会話: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return '連絡先: $userId';
  }

  @override
  String get commonDiscover => '発見';

  @override
  String commonDeveloping(Object title) {
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
  String get groupVisibilityUpdated => 'グループの公開設定が更新されました';

  @override
  String get groupChannelCreated => 'チャンネルが作成されました';

  @override
  String get groupChannelUpdated => 'チャンネルが更新されました';

  @override
  String get groupChannelDeleted => 'チャンネルが削除されました';

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
  String callJoinMeetingFailed(Object error) {
    return 'ミーティングへの参加に失敗しました: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
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
  String profilePlayFailed(Object ringtoneName) {
    return '再生に失敗しました: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
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
  String commonReadCount(Object count) {
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
  String get securityDeviceIdRequired => 'デバイスIDは必須です';

  @override
  String securityVerificationStartFailed(String error) {
    return '検証の開始に失敗しました: $error';
  }

  @override
  String get securityVerificationFailed => '検証に失敗しました';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return '検証に失敗しました: $reason';
  }

  @override
  String get securityEmojiMismatchRejected => '検証が拒否されました - 絵文字が一致しませんでした';

  @override
  String get securityWaitingForDeviceAccept => '他のデバイスが受け入れるのを待っています...';

  @override
  String get securityVerifyDevice => 'このデバイスを確認する';

  @override
  String get securityConfirmEmojiMatch => '以下の絵文字が両方のデバイスに同じ順序で表示されていることを確認します';

  @override
  String get securityEmojiDontMatch => '一致しません';

  @override
  String get securityEmojiMatch => '一致します';

  @override
  String get securityWaitingForDeviceConfirm => '他のデバイスによる確認を待っています...';

  @override
  String get securityVerificationSuccess => '検証成功！';

  @override
  String get securityDeviceVerifiedTrusted => 'このデバイスは現在検証され、信頼されています。';

  @override
  String get securityCompareEmoji => '両方のデバイスの絵文字を比較する';

  @override
  String get securityCompareNumbers => '両方のデバイスの数値を比較する';

  @override
  String get commonTryAgain => 'もう一度試してください';

  @override
  String get commonDone => '完了';

  @override
  String get chatExportTitle => 'チャットのエクスポート';

  @override
  String get chatExportSuccess => 'エクスポートに成功しました';

  @override
  String chatExportFailed(String error) {
    return 'エクスポートに失敗しました: $error';
  }

  @override
  String get chatExportFormat => 'エクスポート形式';

  @override
  String get chatExportHtmlDesc => 'スタイル設定されたレイアウトでどのブラウザでも読むことができます';

  @override
  String get chatExportJsonDesc => '機械可読な構造化データ形式';

  @override
  String get chatExportDateRange => '日付範囲';

  @override
  String get chatExportAll => 'すべてのメッセージ';

  @override
  String get chatExportLastWeek => '過去 7 日間';

  @override
  String get chatExportLastMonth => '先月';

  @override
  String get chatExportLast3Months => '過去 3 か月';

  @override
  String get chatExportMessageCount => 'エクスポートするメッセージ';

  @override
  String get chatExportButton => 'エクスポートと共有';

  @override
  String get chatMediaGallery => 'メディアギャラリー';

  @override
  String get chatExportHistory => 'チャット履歴のエクスポート';

  @override
  String get pdfLoadFailed => 'PDFの読み込みに失敗しました';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => 'すべて';

  @override
  String get mediaImages => '画像';

  @override
  String get mediaVideos => '動画';

  @override
  String get mediaFiles => 'ファイル';

  @override
  String get mediaAudio => 'オーディオ';

  @override
  String mediaItemsCount(int count) {
    return '$count アイテム';
  }

  @override
  String get mediaNoMediaFound => 'メディアが見つかりませんでした';

  @override
  String get spacesTitle => 'コミュニティ';

  @override
  String get spacesCreate => 'コミュニティの作成';

  @override
  String get spacesJoined => '参加しました';

  @override
  String get spacesDiscover => '発見する';

  @override
  String get spacesNoJoined => 'まだ参加しているコミュニティはありません';

  @override
  String get spacesExplore => 'コミュニティを探索する';

  @override
  String get spacesNoPublic => '公開コミュニティが見つかりませんでした';

  @override
  String get spacesJoin => '参加する';

  @override
  String get spacesSubSpaces => 'サブコミュニティ';

  @override
  String get spacesChannels => 'チャンネル';

  @override
  String spacesMembersCount(int count) {
    return '$count メンバー';
  }

  @override
  String get spacesPublic => '公共';

  @override
  String get spacesPrivate => 'プライベート';

  @override
  String get spacesSuggested => '提案された';

  @override
  String spacesChannelsCount(int count) {
    return '$count チャンネル';
  }

  @override
  String get callInCallChat => '通話中のチャット';

  @override
  String callMessagesCount(int count) {
    return '$count メッセージ';
  }

  @override
  String get callNoMessagesYet => 'まだメッセージはありません。\nメッセージを送信して始めてください。';

  @override
  String get callTypeMessage => 'メッセージを入力してください...';

  @override
  String get callYouSender => 'あなた';

  @override
  String get callChatLabel => 'チャット';

  @override
  String get chatEdited => '編集済み';

  @override
  String get chatEditHistory => '編集履歴';

  @override
  String get chatOriginalMessage => 'オリジナル';

  @override
  String chatEditedAt(String time) {
    return '$timeで編集';
  }

  @override
  String get chatViewOnce => '一度見る';

  @override
  String get chatViewOncePhoto => '写真を一度見る';

  @override
  String get chatViewOnceVideo => 'ビデオを一度見る';

  @override
  String get chatViewOnceViewed => '閲覧済み';

  @override
  String get chatViewOnceExpired => '期限切れ';

  @override
  String get chatViewOnceTap => 'タップして表示';

  @override
  String get chatAutoFaceBlur => '自動顔ぼかし';

  @override
  String get chatAutoFaceBlurDesc => '写真を送信するときに顔を自動的にぼかします';

  @override
  String get threadReplyInThread => 'スレッド内で返信する';

  @override
  String threadReplies(int count) {
    return '$count が返信する';
  }

  @override
  String get threadReply => '1 件の返信';

  @override
  String threadLatestReply(String preview) {
    return '最新: $preview';
  }

  @override
  String get threadTitle => 'スレッド';

  @override
  String get threadReplyPlaceholder => 'スレッド内で返信...';

  @override
  String threadParticipants(int count) {
    return '$count 参加者';
  }

  @override
  String get voiceRoomTitle => 'ボイスルーム';

  @override
  String get voiceRoomCreate => 'ボイスルームの作成';

  @override
  String get voiceRoomJoin => '参加する';

  @override
  String get voiceRoomLeave => '休暇を取る';

  @override
  String get voiceRoomEnd => 'エンドルーム';

  @override
  String get voiceRoomRaiseHand => '挙手';

  @override
  String get voiceRoomLowerHand => '低い手';

  @override
  String get voiceRoomMute => 'ミュート';

  @override
  String get voiceRoomUnmute => 'ミュートを解除する';

  @override
  String get voiceRoomHost => 'ホスト';

  @override
  String get voiceRoomSpeakers => 'スピーカー';

  @override
  String get voiceRoomListeners => 'リスナー';

  @override
  String get voiceRoomLive => 'ライブ';

  @override
  String get voiceRoomEnded => '終了しました';

  @override
  String get voiceRoomScheduled => '予定されている';

  @override
  String get voiceRoomApprove => '承認する';

  @override
  String get voiceRoomDemote => 'リスナーに移動';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name が手を挙げました';
  }

  @override
  String get voiceRoomName => '部屋名';

  @override
  String get voiceRoomTopic => 'トピック (オプション)';

  @override
  String get voiceRoomNoActive => 'アクティブボイスルームはありません';

  @override
  String get voiceRoomConnecting => '接続中...';

  @override
  String get usernameTitle => 'ユーザー名';

  @override
  String get usernameSet => 'ユーザー名の設定';

  @override
  String get usernameChange => 'ユーザー名の変更';

  @override
  String get usernamePlaceholder => 'ユーザー名を入力してください';

  @override
  String get usernameAvailable => '利用可能なユーザー名';

  @override
  String get usernameUnavailable => 'ユーザー名はすでに取得されています';

  @override
  String get usernameInvalid => '3 ～ 30 文字、小文字、数字、アンダースコア。文字で始める必要があります。';

  @override
  String get usernameReserved => 'このユーザー名は予約されています';

  @override
  String get usernameSaved => 'ユーザー名が保存されました';

  @override
  String get usernameSearchHint => '@ユーザー名で検索';

  @override
  String get ensName => 'ENS 名';

  @override
  String get ensLinked => 'ENSにリンクされています';

  @override
  String get ensResolving => 'ENS を解決中...';

  @override
  String get ensNotFound => 'ENS 名が見つかりません';

  @override
  String get tokenGateTitle => 'トークンゲート';

  @override
  String get tokenGateEnable => 'トークンゲートを有効にする';

  @override
  String get tokenGateDisable => 'トークンゲートを無効にする';

  @override
  String get tokenGateAddRule => 'ルールの追加';

  @override
  String get tokenGateRemoveRule => 'ルールの削除';

  @override
  String get tokenGateContractAddress => '契約住所';

  @override
  String get tokenGateMinBalance => '最低残高';

  @override
  String get tokenGateTokenId => 'トークンID (ERC-1155)';

  @override
  String get tokenGateChainId => 'チェーンID';

  @override
  String get tokenGateVerifying => 'トークンの保有を確認しています...';

  @override
  String get tokenGateVerified => '検証に合格しました';

  @override
  String get tokenGateDenied => 'トークンの要件を満たしていません';

  @override
  String get tokenGateOperatorAnd => 'すべてのルールを満たす必要があります';

  @override
  String get tokenGateOperatorOr => 'いずれかのルールを満たす必要があります';

  @override
  String get tokenGateRuleErc20 => 'ERC-20トークン';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => 'マルチトークン (ERC-1155)';

  @override
  String get tokenGateRuleNative => 'ネイティブトークン';

  @override
  String get tokenGateSaved => 'トークンゲートが保存されました';

  @override
  String get tokenGateEnableDescription => '参加するにはメンバーにトークンの保持を要求する';

  @override
  String get tokenGateOperator => 'ルールロジック';

  @override
  String get tokenGateRules => 'ルール';

  @override
  String get tokenGateSymbol => '記号（オプション）';

  @override
  String get tokenGateChain => 'チェーン';

  @override
  String get tokenGateTokenStandard => 'トークン規格';

  @override
  String get tokenGateDenialMessage => '拒否メッセージ';

  @override
  String get tokenGateDenialMessageHint => '検証に失敗した場合に表示されるメッセージ';

  @override
  String get tokenGateVerifyTitle => 'トークンの検証';

  @override
  String get tokenGateVerifyPassed => '検証に合格しました';

  @override
  String get tokenGateVerifyFailed => '検証に失敗しました';

  @override
  String get tokenGateRetryVerify => '再試行';

  @override
  String get tokenGateRequired => '必須';

  @override
  String get tokenGateYourBalance => 'あなたの残高';

  @override
  String get tokenGateRulesActive => 'ルールが有効です';

  @override
  String get tokenGateDisabled => '障害者';

  @override
  String get ensNotBound => '束縛されていない';

  @override
  String get liveLocation => 'ライブロケーション';

  @override
  String get stopLiveLocation => '共有を停止する';

  @override
  String get startLiveLocation => '共有を開始する';

  @override
  String get selectDuration => '期間を選択してください';

  @override
  String get groupChatFiles => 'チャットファイル';

  @override
  String get groupLinks => 'リンク';

  @override
  String get groupNoLinks => 'まだリンクがありません';

  @override
  String get chatBackground => 'チャットの背景';

  @override
  String get solidColors => '単色';

  @override
  String get gradients => 'グラデーション';

  @override
  String get defaultBackground => 'デフォルト';

  @override
  String get settingsFontSizeSlider => 'フォントサイズ';

  @override
  String get autoDownload => '自動ダウンロード';

  @override
  String get images => '画像';

  @override
  String get voice => '声';

  @override
  String get video => 'ビデオ';

  @override
  String get files => 'ファイル';

  @override
  String get mobileData => 'モバイルデータ';

  @override
  String get roaming => 'ローミング';

  @override
  String get storageManagement => 'ストレージ';

  @override
  String get totalUsage => '総使用量';

  @override
  String get cache => 'キャッシュ';

  @override
  String get other => 'その他';

  @override
  String get clearCache => 'キャッシュのクリア';

  @override
  String get cacheCleared => 'キャッシュがクリアされました';

  @override
  String get clearCacheFailed => 'キャッシュのクリアに失敗しました';

  @override
  String get confirmClearCache => 'キャッシュデータをすべてクリアしますか?';

  @override
  String get mapView => 'マップビュー';

  @override
  String liveLocationSharingCount(int count) {
    return '$count 人が位置情報を共有しています';
  }

  @override
  String get minutes15 => '15分';

  @override
  String get minutes30 => '30分';

  @override
  String get hour1 => '1時間';

  @override
  String get hours8 => '8時間';

  @override
  String get personalCard => '個人カード';

  @override
  String get downloadFailed => 'ダウンロードに失敗しました';

  @override
  String get locationExpired => '期限切れ';

  @override
  String secondsRemaining(int count) {
    return '$count 秒';
  }

  @override
  String minutesRemaining(int count) {
    return '$count分';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '${hours}h $minutes分';
  }

  @override
  String get favoriteMessages => 'お気に入り';

  @override
  String get linksCopied => 'リンクがコピーされました';

  @override
  String get noLinksFound => 'リンクが見つかりませんでした';

  @override
  String get roomStorageRanking => 'お部屋の収納ランキング';

  @override
  String get downloadComplete => 'ダウンロード完了';

  @override
  String get downloading => 'ダウンロード中...';

  @override
  String get draftSaved => '下書きが保存されました';

  @override
  String get voiceRecording => '音声録音';

  @override
  String get searchLocation => '検索場所';

  @override
  String get tapToSearch => 'タップして検索';

  @override
  String get settingsThisDevice => 'このデバイス';

  @override
  String get settingsJustNow => 'たった今';

  @override
  String get settingsDeviceId => 'デバイスID';

  @override
  String get settingsStatus => 'ステータス';

  @override
  String get settingsLastActive => '最後にアクティブだった';

  @override
  String get settingsIpAddress => 'IPアドレス';

  @override
  String get settingsRenameDevice => 'デバイスの名前を変更する';

  @override
  String get settingsDeviceNameHint => 'デバイス名を入力してください';

  @override
  String get settingsDeviceRenamed => 'デバイスの名前が変更されました';

  @override
  String get settingsRenameFailed => '名前の変更に失敗しました';

  @override
  String get settingsRemoteLogout => 'リモートログアウト';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return '「$deviceName」をログアウトしてもよろしいですか?この操作は元に戻すことができません。';
  }

  @override
  String get settingsDeviceLoggedOut => 'デバイスがログアウトしました';

  @override
  String get settingsLogoutFailed => 'ログアウトに失敗しました';

  @override
  String get settingsLogout => 'ログアウト';

  @override
  String get settingsVerifyIdentity => '本人確認';

  @override
  String get settingsEnterPasswordToConfirm => 'このアクションを確認するには、パスワードを入力してください。';

  @override
  String get scheduledSendTitle => 'スケジュールメッセージ';

  @override
  String get scheduledSendInOneHour => '1時間以内';

  @override
  String get scheduledSendTonight => '今夜（午後8時）';

  @override
  String get scheduledSendTomorrowMorning => '明日の朝（午前9時）';

  @override
  String get scheduledSendCustom => '日付と時刻を選択してください';

  @override
  String get scheduledMessageLabel => '予定されている';

  @override
  String get scheduledMessageCancel => 'スケジュールされたメッセージをキャンセルする';

  @override
  String get chatLockTitle => 'チャットロック';

  @override
  String get chatLockEnable => 'このチャットをロックする';

  @override
  String get chatLockDisable => 'このチャットのロックを解除する';

  @override
  String get chatLockDescription => 'ロックされたチャットを開くには生体認証または PIN 認証が必要です';

  @override
  String get chatLockVerifyTitle => 'チャットがロックされました';

  @override
  String get chatLockVerifySubtitle => 'このチャットにアクセスするには確認してください';

  @override
  String get chatLockVerifyFailed => '検証に失敗しました';

  @override
  String get chatLockEnabled => 'チャットがロックされました';

  @override
  String get chatLockDisabled => 'チャットのロックが解除されました';

  @override
  String get chatLockPinTitle => 'PINを入力してください';

  @override
  String get chatLockPinSetTitle => '暗証番号を設定する';

  @override
  String get chatLockPinConfirmTitle => 'PINの確認';

  @override
  String get chatLockPinMismatch => 'PIN が一致しません';

  @override
  String get chatLockUseBiometric => '生体認証を使用する';

  @override
  String get chatLockUsePin => 'PINを使用する';

  @override
  String get mediaEditorUndo => '元に戻す';

  @override
  String get mediaEditorRedo => 'やり直し';

  @override
  String get mediaEditorCrop => '作物';

  @override
  String get mediaEditorFilter => 'フィルター';

  @override
  String get mediaEditorDraw => '描く';

  @override
  String get mediaEditorText => 'テキスト';

  @override
  String get aiAssistant => 'AIアシスタント';

  @override
  String get aiAssistantWelcome => 'こんにちは！ N42 AI アシスタントです。どんな御用でしょうか？';

  @override
  String get aiAssistantNotConfigured => 'AI サービスが構成されていません';

  @override
  String get aiAssistantSettings => 'AI設定';

  @override
  String get aiAssistantClearHistory => 'チャット履歴をクリアする';

  @override
  String get aiAssistantClearHistoryConfirm => 'すべての AI チャット履歴をクリアしてもよろしいですか?';

  @override
  String get aiAssistantStopGenerating => '生成を停止する';

  @override
  String get aiAssistantModel => 'モデル';

  @override
  String get aiAssistantTemperature => '温度';

  @override
  String get aiAssistantMaxTokens => '最大トークン数';

  @override
  String get aiAssistantContextWindow => 'コンテキストウィンドウ';

  @override
  String get aiAssistantServiceStatus => 'サービス状況';

  @override
  String get aiAssistantAvailable => '利用可能';

  @override
  String get aiAssistantUnavailable => '利用不可';

  @override
  String get aiSummarize => 'AIの概要';

  @override
  String aiSummarizeUnread(int count) {
    return '$count の未読メッセージを要約する';
  }

  @override
  String get aiSummarizeLoading => '要約すると...';

  @override
  String get aiSummarizeError => '要約できませんでした';

  @override
  String get aiRewrite => 'AIリライト';

  @override
  String get aiRewriteFormal => 'フォーマル';

  @override
  String get aiRewriteCasual => 'カジュアル';

  @override
  String get aiRewritePlayful => '遊び心たっぷり';

  @override
  String get aiRewriteProfessional => 'プロフェッショナル';

  @override
  String get aiRewriteAccept => '使用する';

  @override
  String get aiRewriteCancel => 'キャンセル';

  @override
  String get aiRewriteLoading => '書き換え中...';

  @override
  String get aiLinkSummary => 'AIの概要';

  @override
  String get aiLinkSummaryAnalyzing => '分析中...';

  @override
  String get chatFolderManagement => 'フォルダーの管理';

  @override
  String get chatFolderSystem => 'システムフォルダー';

  @override
  String get chatFolderCustom => 'カスタムフォルダー';

  @override
  String get chatFolderEmpty => 'カスタムフォルダーはまだありません';

  @override
  String get chatFolderCreate => 'フォルダーの作成';

  @override
  String get chatFolderEdit => 'フォルダーの編集';

  @override
  String get chatFolderNameHint => 'フォルダ名';

  @override
  String get chatFolderAll => 'すべて';

  @override
  String get chatFolderUnread => '未読';

  @override
  String get chatFolderPersonal => '個人的な';

  @override
  String get chatFolderGroups => 'グループ';

  @override
  String get chatFolderChannels => 'チャンネル';

  @override
  String get chatFolderMuted => 'ミュート';

  @override
  String get storyAddMusic => '音楽を追加する';

  @override
  String get storyChangeMusic => '音楽を変更する';

  @override
  String get storyBackgroundMusic => 'バックグラウンドミュージック';

  @override
  String get storyMusicPreview => 'プレビュー (最大 15 秒)';

  @override
  String get storyChooseFromDevice => 'デバイスから選ぶ';

  @override
  String get storyUseThisMusic => 'この音楽を使用する';

  @override
  String get authPasskeyNotSupported => 'このデバイスではパスキーがサポートされていません';

  @override
  String get authPasskeyRegister => 'パスキーの登録';

  @override
  String get authPasskeyNoRegistered => 'パスキーが登録されていません';

  @override
  String get authPasskeyRegisterHint =>
      'このアカウントのパスキーを登録します。スタンドアロン パスキー サインインは後で有効になります。';

  @override
  String get authPasskeyNameYours => 'パスキーに名前を付けます';

  @override
  String get authPasskeyRegistered => 'このアカウントに保存されたパスキー';

  @override
  String get authPasskeyDeleted => 'このアカウントからパスキーが削除されました';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return 'パスキー「$name」を削除しますか?後でパスキー サインインを使用する前に、再度登録する必要があります。';
  }

  @override
  String get momentVisibilityPublic => '公共';

  @override
  String get momentVisibilityPrivate => 'プライベート';

  @override
  String get momentVisibilityPartial => '選択した友達';

  @override
  String get momentVisibilityExcluded => '一部の友達を除外する';

  @override
  String momentUserMoments(String userName) {
    return '$userName の瞬間';
  }

  @override
  String get momentForwardTo => 'に転送';

  @override
  String get momentForwardSuccess => '正常に転送されました';

  @override
  String get momentSelectFriends => '友達を選択';

  @override
  String get momentSelectTags => 'タグで選ぶ';

  @override
  String momentSelectedCount(int count) {
    return '選択済み ($count)';
  }

  @override
  String get momentNoMomentsYet => 'まだ瞬間はありません';

  @override
  String get momentForwardMoment => '前進モーメント';

  @override
  String get momentAddComment => 'コメントを追加...';

  @override
  String momentForwardContent(String content) {
    return '[瞬間] $content';
  }

  @override
  String get momentDeleteMoment => 'モーメントを削除';

  @override
  String get momentDeleteConfirm => 'この瞬間を削除してもよろしいですか?';

  @override
  String get momentComment => 'コメント';

  @override
  String get momentWriteComment => 'コメントを書いてください...';

  @override
  String get momentLike => 'いいね';

  @override
  String get momentUnlike => 'とは異なります';

  @override
  String get momentForward => '進む';

  @override
  String get momentDelete => '削除';

  @override
  String get momentReply => '返信する';

  @override
  String get momentMoment => '瞬間';

  @override
  String momentLikesCount(int count) {
    return '$count の「いいね！」';
  }

  @override
  String momentCommentsCount(int count) {
    return 'コメント$count件';
  }

  @override
  String get momentNoComments => 'まだコメントはありません';

  @override
  String get momentFailedToLoad => '画像のロードに失敗しました';

  @override
  String momentReplyTo(String userName) {
    return '$userName に返信...';
  }

  @override
  String get momentNoConversations => '会話なし';

  @override
  String get momentJustNow => 'たった今';

  @override
  String momentMinutesAgo(int count) {
    return '$count分前';
  }

  @override
  String momentHoursAgo(int count) {
    return '${count}1時間前';
  }

  @override
  String momentDaysAgo(int count) {
    return '$count日前';
  }

  @override
  String get chatGroupAnnouncementHint => 'グループアナウンスを入力してください';

  @override
  String get chatGroupAnnouncementEmpty => 'アナウンスなし';

  @override
  String get chatEditNickname => 'ニックネームの編集';

  @override
  String get chatNicknameHint => 'このグループにニックネームを入力してください';

  @override
  String get contactAddPhoneHint => '電話番号を入力してください';

  @override
  String get contactNotesHint => 'この連絡先に関するメモを追加する';

  @override
  String get reportTitle => 'レポート';

  @override
  String get reportReasonSpam => 'スパムメール';

  @override
  String get reportReasonHarassment => 'ハラスメント';

  @override
  String get reportReasonFraud => '詐欺';

  @override
  String get reportReasonOther => 'その他';

  @override
  String get reportSubmitted => 'レポート提出';

  @override
  String get reportDescription => '追加の説明 (オプション)';

  @override
  String get qrcodeSaved => 'QRコードをアルバムに保存しました';

  @override
  String get chatSendRedPacketInChat => 'チャットで赤いパケットを送信してください';

  @override
  String get commonSaveFailed => '保存に失敗しました';

  @override
  String get reportSelectReason => '理由を選択してください';

  @override
  String get reportUnavailable => '報告を送信するにはサインインしてください。';

  @override
  String get reportAccountChanged => 'アカウントが変わりました。この報告を開き直して送信してください。';

  @override
  String get reportUnsupported => 'このホームサーバーはユーザーの報告に対応していません。';

  @override
  String get reportRoomUnsupported => 'このホームサーバーはルームの報告に対応していません。';

  @override
  String get reportRateLimited => '報告が多すぎます。しばらくしてからもう一度お試しください。';

  @override
  String get reportCouldNotSend => '報告を送信できませんでした。もう一度お試しください。';

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
  String get game2048 => '2048年';

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
  String get storyMyStory => '私の物語';

  @override
  String get storageSmartCleanup => 'スマートクリーンアップ';

  @override
  String get storageOldMediaFiles => '古いメディア ファイル';

  @override
  String get storageLargeFiles => '大きなファイル';

  @override
  String get storageAppCache => 'アプリキャッシュ';

  @override
  String get storageSettings => 'ストレージ設定';

  @override
  String get storageAutoCleanup => '自動クリーンアップ';

  @override
  String storageAutoCleanupDesc(int days) {
    return '$days 日より古いファイルを自動的にクリーンアップします';
  }

  @override
  String get storageCleanupPeriod => 'クリーンアップ期間';

  @override
  String get storagePreserveThumbnails => 'サムネイルを保存する';

  @override
  String get storagePreserveThumbnailsDesc => 'クリーンアップ中に画像のサムネイルを保持する';

  @override
  String get storageWarningHigh => 'ストレージの使用率が高い。古いファイルをクリーンアップすることを検討してください。';

  @override
  String get storageWarningCritical => 'ストレージが非常に不足しています。空き領域までクリーンアップしてください。';

  @override
  String storageFreed(String size, int count) {
    return '$size ($count ファイル) を解放しました';
  }

  @override
  String storageDays(int days) {
    return '$days 日';
  }

  @override
  String storageViewAllRooms(int count) {
    return '$count の部屋をすべて表示';
  }

  @override
  String get storageNoFiles => 'ファイルが見つかりません';

  @override
  String get storageFilePinned => '固定された';

  @override
  String storageDeleteSelected(int count) {
    return '選択した $count ファイルを削除しますか?サーバーから再ダウンロードできます。';
  }

  @override
  String get backupRestore => 'バックアップと復元';

  @override
  String get backupCreate => 'バックアップの作成';

  @override
  String get backupCreateDesc =>
      '設定と暗号化キーをバックアップします。再ログイン後、メッセージはサーバーから復元されます。';

  @override
  String get backupIncludeKeys => '暗号化キーを含める';

  @override
  String get backupIncludeKeysDesc => '暗号化されたメッセージを読み取るために必要です';

  @override
  String get backupPasswordProtect => 'パスワード保護';

  @override
  String get backupEnterPassword => 'バックアップパスワードを入力してください';

  @override
  String get backupHistory => 'バックアップ履歴';

  @override
  String get backupNoBackups => 'まだバックアップがありません';

  @override
  String get backupRestore2 => '復元';

  @override
  String get backupDelete => '削除';

  @override
  String get backupDeleteConfirm => 'このバックアップを削除してもよろしいですか?これを元に戻すことはできません。';

  @override
  String get backupRestoreFromFile => 'ファイルから復元';

  @override
  String get backupRestoreFromFileDesc =>
      '別のデバイスまたは以前のバックアップから .n42backup ファイルをインポートします。';

  @override
  String get backupChooseFile => 'バックアップファイルの選択';

  @override
  String get backupRestoring => '復元中...';

  @override
  String backupCreated(int rooms, int messages) {
    return '作成されたバックアップ: $rooms ルーム、$messages メッセージ';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return '$rooms ルームから $settings 設定を復元しました';
  }

  @override
  String backupFailed(String error) {
    return 'バックアップに失敗しました: $error';
  }

  @override
  String get backupPasswordRequired => 'このバックアップはパスワードで保護されています';

  @override
  String get blocGroupNotFound => 'グループが見つかりません';

  @override
  String blocGroupMembersInvited(int count) {
    return '$count メンバーを招待しました';
  }

  @override
  String get blocGroupMemberRemoved => 'メンバーが削除されました';

  @override
  String get blocGroupAdminRemoved => '管理者が削除されました';

  @override
  String get blocGroupLeft => 'グループを脱退';

  @override
  String get blocGroupDisbanded => 'グループ解散';

  @override
  String get blocGroupJoined => 'グループに参加しました';

  @override
  String get blocGroupInviteDeclined => '招待が拒否されました';

  @override
  String get blocGroupTokenGateUpdated => 'トークンゲートが更新されました';

  @override
  String get blocTransferProcessing => '転送を処理しています...';

  @override
  String get blocTransferCancelled => '転送がキャンセルされました';

  @override
  String get blocTransferFailed => '転送に失敗しました';

  @override
  String get blocPaymentProcessing => '支払いを処理しています...';

  @override
  String get blocPaymentFailed => '支払いに失敗しました';

  @override
  String get groupMaxMembers => '会員制限';

  @override
  String get groupMaxMembersUnlimited => '無制限';

  @override
  String get groupMaxMembersHint => '制限を入力します (無制限の場合は空白のままにします)';

  @override
  String get groupMaxMembersUpdated => '会員制限が更新されました';

  @override
  String get groupFull => 'グループは定員に達しています';

  @override
  String get groupChannels => 'トピックチャンネル';

  @override
  String get groupChannelsEmpty => 'まだチャンネルがありません';

  @override
  String get groupChannelsCount => 'チャンネル';

  @override
  String get groupChannelCreate => '新しいチャンネル';

  @override
  String get groupChannelName => 'チャンネル名';

  @override
  String get groupChannelTopic => 'チャンネルのトピック (オプション)';

  @override
  String get groupChannelDelete => 'チャンネルの削除';

  @override
  String get groupChannelDeleteConfirm => 'このチャンネルを削除しますか?すべてのメッセージが失われます。';

  @override
  String get groupBotSettings => 'ボットの設定';

  @override
  String get groupBotEnabled => 'ボットを有効にする';

  @override
  String get groupBotWelcomeMessage => 'ウェルカムメッセージテンプレート';

  @override
  String get groupBotWelcomeHint => '新しいメンバー名のプレースホルダーとして「name」を使用します';

  @override
  String get groupBotConfigUpdated => 'ボット設定が更新されました';

  @override
  String get groupContentFilter => 'コンテンツフィルター';

  @override
  String get groupContentFilterEnabled => 'キーワードフィルターを有効にする';

  @override
  String get groupContentFilterReplace => '*** に置き換えます';

  @override
  String get groupContentFilterHide => 'メッセージを隠す';

  @override
  String get groupContentFilterAddWord => 'キーワードを追加';

  @override
  String get groupContentFilterUpdated => 'コンテンツフィルターが更新されました';

  @override
  String get chatSlashCommands => 'コマンド';

  @override
  String get chatCommandPoll => '/poll — 投票を作成します';

  @override
  String get chatCommandAnnounce => '/announce — アナウンスを送信する';

  @override
  String get chatCommandWelcome => '/welcome — ウェルカム メッセージを設定します';

  @override
  String get chatReportMessage => 'レポート';

  @override
  String get chatReportReason => '報告理由';

  @override
  String get chatReportSpam => 'スパムメール';

  @override
  String get chatReportHarassment => 'ハラスメント';

  @override
  String get chatReportInappropriate => '不適切なコンテンツ';

  @override
  String get chatReportOther => 'その他';

  @override
  String get chatReportSuccess => 'レポート提出';

  @override
  String get spacesName => 'コミュニティ名';

  @override
  String get spacesNameHint => '例:仮想通貨トレーダー';

  @override
  String get spacesNameRequired => '名前は必須です';

  @override
  String get spacesDescription => '説明';

  @override
  String get spacesDescriptionHint => 'このコミュニティは何についてのものですか?';

  @override
  String get spacesType => 'コミュニティタイプ';

  @override
  String get spacesPublicDesc => '誰でも見つけて参加できます';

  @override
  String get spacesPrivateDesc => '招待されたメンバーのみが参加できます';

  @override
  String get spacesNotFound => 'コミュニティが見つかりません';

  @override
  String get spacesSearch => 'コミュニティを検索...';

  @override
  String get spacesMembers => 'メンバー';

  @override
  String get spacesNoChannels => 'まだチャンネルがありません';

  @override
  String get spacesLeave => 'コミュニティを離れる';

  @override
  String spacesLeaveConfirm(String name) {
    return '「$name」を終了してもよろしいですか?';
  }

  @override
  String get spacesDelete => 'コミュニティの削除';

  @override
  String spacesDeleteConfirm(String name) {
    return 'これにより、「$name」とそのすべてのチャンネルが完全に削除されます。この操作は元に戻すことができません。';
  }

  @override
  String get spacesCreateChannel => 'チャンネルの追加';

  @override
  String get spacesChannelName => 'チャンネル名';

  @override
  String get spacesChannelTopic => 'トピック (オプション)';

  @override
  String get spacesDeleteChannel => 'チャンネルの削除';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return '「#$name」を削除してもよろしいですか?';
  }

  @override
  String get spacesEditName => '名前の編集';

  @override
  String get spacesEditDescription => '説明の編集';

  @override
  String spacesViewAllMembers(int count) {
    return '$count メンバーをすべて表示';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return 'キック$name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return '禁止 $name';
  }

  @override
  String get spacesPromoteAdmin => '管理者に昇格';

  @override
  String get spacesDemoteAdmin => '管理者の削除';

  @override
  String get spacesInviteMember => 'メンバーを招待する';

  @override
  String get spacesInviteMemberUserId => 'ユーザーID (例: @user:server.com)';

  @override
  String get spacesSave => '保存';

  @override
  String get settingsScreenshotProtection => 'スクリーンショットの保護';

  @override
  String get settingsScreenshotProtectionDesc => 'スクリーンショットと画面録画を防止する';

  @override
  String get chatSelfDestructTimer => '自爆';

  @override
  String get chatTimerPickerTitle => '自爆タイマー';

  @override
  String get chatTimerOff => 'オフ';

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
      'このウォレット アドレスにはまだ N42 アカウントがありません。 N42 招待リンクを共有して始めることができます。';

  @override
  String get web3ShareInvite => '招待を共有';

  @override
  String get nftPickerTitle => 'NFT アバターを選択';

  @override
  String get nftPickerTabPopular => '人気';

  @override
  String get nftPickerTabCustom => 'カスタム';

  @override
  String get nftPickerChain => 'チェーン';

  @override
  String get nftPickerContract => '契約住所';

  @override
  String get nftPickerTokenId => 'トークンID';

  @override
  String get nftPickerVerifyOwnership => '所有権を確認してプレビュー';

  @override
  String get nftPickerUseAsAvatar => 'アバターとして使用';

  @override
  String get nftPickerPreview => 'プレビュー';

  @override
  String get nftPickerNotOwned => 'このNFTを所有していません';

  @override
  String get nftPickerInvalidTokenId => '無効なトークンID';

  @override
  String get nftPickerEnterBoth => 'コントラクトアドレスとトークンIDを入力してください';

  @override
  String get nftPickerInfoTitle => 'NFT アバター — オンチェーン確認済み';

  @override
  String get nftPickerInfoDesc =>
      '所有する NFT をアバターとしてバインドします。誰でもオンチェーンで所有権を確認できます。 N42にゴールドのリングを付けて展示。';

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

  @override
  String get blocAuthSendVerificationCodeFailed => '確認コードの送信に失敗しました';

  @override
  String get blocAuthServerNoEmailPasswordReset =>
      'このサーバーは電子メールのパスワードのリセットをサポートしていません';

  @override
  String get blocAuthResetPasswordFailed => 'パスワードのリセットに失敗しました';

  @override
  String get blocAuthChangePasswordFailed => 'パスワードの変更に失敗しました';

  @override
  String get blocAuthOldPasswordWrong => '現在のパスワードが正しくありません';

  @override
  String get blocAuthLoginCancelled => 'ログインがキャンセルされました';

  @override
  String get blocAuthGoogleLoginFailed => 'Googleログインに失敗しました';

  @override
  String get blocAuthAppleLoginFailed => 'Apple ログインに失敗しました';

  @override
  String get blocAuthSsoLoginFailed => 'SSOログインに失敗しました';

  @override
  String get blocAuthFacebookLoginFailed => 'Facebook ログインに失敗しました';

  @override
  String get blocAuthTwitterLoginFailed => 'ツイッターのログインに失敗しました';

  @override
  String get blocAuthWeChatLoginFailed => 'WeChatのログインに失敗しました';

  @override
  String get blocAuthWeChatNotConfigured => 'WeChat ログインが設定されていません';

  @override
  String get blocAuthWeChatNotInstalled => 'まずWeChatをインストールしてください';

  @override
  String get blocAuthPasswordWrong => 'パスワードが間違っています';

  @override
  String get blocAuthEmailAlreadyBound => 'このメールはすでに別のアカウントにバインドされています';

  @override
  String get blocAuthChangeEmailFailed => 'メールアドレスの変更に失敗しました';

  @override
  String get blocAuthVerificationCodeInvalid => '認証コードが間違っているか、有効期限が切れています';

  @override
  String get blocAuthSessionExpired => 'セッションが期限切れになりました。もう一度ログインしてください';

  @override
  String get blocAuthSessionIncomplete => 'セッションデータが不完全です。再度ログインしてください。';

  @override
  String get chatReadingMode => '閲覧モード';

  @override
  String get groupPoints => 'ポイント';

  @override
  String get settingsPrivacySecurity => 'プライバシーとセキュリティ';

  @override
  String get settingsSystemAccounts => 'システムとアカウント';

  @override
  String get settingsNotificationPrivacy => '通知のプライバシー';

  @override
  String get settingsSenderOnly => '送信者のみ表示';

  @override
  String get settingsHiddenNotification => '送信者とメッセージを非表示';

  @override
  String get settingsSmartFilter => 'スマートフィルター';

  @override
  String get settingsEmailVerificationSent => '確認メールを送信しました';

  @override
  String get settingsEmailLinkInstructions =>
      'メール内の確認リンクを開いてから、ここに戻って確認してください。';

  @override
  String get settingsSendVerificationEmail => '確認メールを送信';

  @override
  String get chatLogoutKeyWarning =>
      'ログアウトする前に暗号化キーをバックアップしてください。暗号化されたメッセージを読めなくなる可能性があります。';

  @override
  String get settingsBiometricUnavailable =>
      '生体認証を利用できません。端末の設定で顔や指紋の登録とアプリの権限を確認してください。';

  @override
  String get chatEncryptionNotReady =>
      '安全な接続の準備ができていません。メッセージは送信されませんでした。両方のアカウントの接続とデバイス認証を確認してから再試行してください。';

  @override
  String get contactRequestPending => '承認待ち';

  @override
  String get chatFriendRequestPending =>
      '友だち関係が確認されていません。送信前に「連絡先」>「新しい友だち」を確認してください。';

  @override
  String contactPhotoCount(int count) {
    return '写真 $count 枚';
  }

  @override
  String get videoPublish => '動画を公開';

  @override
  String get videoGoLive => 'ライブ配信を開始';

  @override
  String get videoSelect => '動画を選択';

  @override
  String get videoLiveUnavailable => 'ライブ配信は利用できません';

  @override
  String get qrcodeAlbum => 'アルバム';

  @override
  String get settingsSwitchAccount => 'アカウントを切り替え';

  @override
  String get chatFilterUnread => '未読';

  @override
  String get chatFilterEmpty => 'このフィルターの会話はありません';

  @override
  String get accountAdd => 'アカウントを追加';

  @override
  String get accountCurrent => '現在のアカウント';

  @override
  String get accountSwitching => 'アカウントを切り替え中…';

  @override
  String get accountSwitchFailed =>
      'アカウントを切り替えられませんでした。再試行するか、アカウントを追加して再度サインインしてください。';

  @override
  String get accountSessionsHint =>
      '各アカウントのメッセージと安全なセッションを分けて保持するには、ここでアカウントを切り替えてください。';

  @override
  String get accountNoSaved => '保存済みアカウントはまだありません';

  @override
  String get contactRequestSent => '申請を送信しました';

  @override
  String get contactRequestsIncoming => '受信した申請';

  @override
  String get contactRequestsOutgoing => '送信した申請';

  @override
  String get contactRequestHint => '申請が承認されるとチャットと通話ができます。';

  @override
  String get callReturnToCall => '通話に戻る';

  @override
  String get chatMessageSending => '送信中';

  @override
  String get chatMessageSent => '送信済み';

  @override
  String get chatMessageDelivered => '配信済み';

  @override
  String get chatMessageRead => '既読';

  @override
  String get chatMessageFailed => '未送信。タップして再試行してください。';

  @override
  String get chatMessageUnavailable =>
      'この端末ではメッセージを利用できません。タップして復元方法を確認してください。';

  @override
  String get contactStarredFriends => 'スター付きの友だち';

  @override
  String get chatRecipientKeysMissing =>
      'この友だちには利用可能な暗号化セッションがありません。サインインしてアプリを開いてもらい、再試行してください。アカウント変更にはログアウトではなく「アカウントを切り替え」を使ってください。';

  @override
  String get chatSwitchForMessaging =>
      'アカウントを変更しますか？メッセージと安全なセッションを保持するには「アカウントを切り替え」を使ってください。ログアウトするとこの端末の承認が取り消され、受信した暗号化メッセージを利用できなくなる場合があります。';

  @override
  String get aiServiceUnavailable =>
      'AI 要約は現在利用できません。サービスへのアクセスが復旧してから再試行してください。';

  @override
  String aiSummarizeMessages(int count) {
    return '最近の $count 件のメッセージを要約';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return '参加済み $joined 人 · 招待中 $invited 人';
  }

  @override
  String contactPendingCount(int count) {
    return '承認待ちの申請 $count 件';
  }

  @override
  String get chatDraftLabel => '下書き';

  @override
  String get contactIndexLabel => '連絡先索引';

  @override
  String get transferAssetUnavailable => '支払い資産を利用できません';

  @override
  String get transferPaymentRequestUnavailable => '支払いリクエストを利用できません';

  @override
  String get chatCatchUp => '見逃しを確認';

  @override
  String get chatCatchUpMentions => 'メンション';

  @override
  String get chatCatchUpReplies => '自分への返信';

  @override
  String get chatCatchUpPinned => 'ピン留めメッセージ';

  @override
  String get chatCatchUpScope =>
      'メンションと返信には既読を含む読み込み済みメッセージを使用します。以前の返信を探すには古いメッセージを読み込んでください。';

  @override
  String get chatCatchUpLoadMore => '古いメッセージを読み込む';

  @override
  String get chatActionPreview => 'カレンダーの提案を確認';

  @override
  String get chatActionPrivacy =>
      '確認後、下のタイトルと時刻のみをカレンダーアプリに共有します。タイムゾーンを確認してください。カレンダーアカウントによっては予定が同期されます。';

  @override
  String get chatActionTitle => 'チャットの予定';

  @override
  String get chatActionSuggestion => 'カレンダーの提案';

  @override
  String get chatUnreadAttention => '未読のメンションと返信';

  @override
  String get chatScanAgain => '再スキャン';

  @override
  String get chatUnreadScope => 'サーバー履歴を既読位置までスキャンします。会話を開いて読み、更新すると結果を再作成します。';

  @override
  String get chatScanIncomplete => '未完了：履歴、復号、または既読位置を利用できません。同期後にもう一度お試しください。';

  @override
  String get chatHistoryShare => '選択した履歴を共有';

  @override
  String get chatHistoryExplanation =>
      '管理者のみ使用できます。プレーンテキストと、参加済みグループメンバーとの既存の暗号化された個別チャットを選択してください。共有するとグループに監査メッセージが表示されます。';

  @override
  String get chatHistoryEnable => '共有を有効化';

  @override
  String get chatHistoryDisable => '共有を無効化';

  @override
  String get chatHistoryPolicy => 'グループ履歴の共有ポリシー';

  @override
  String get chatHistoryPolicyDetail =>
      '管理者のみ共有できます。有効にすると、グループ履歴の表示も参加後のイベントに制限されます。下のテキストメッセージ制限を設定して確認してください。';

  @override
  String get chatHistoryPolicySaved => 'ポリシーを保存しました';

  @override
  String get chatHistoryRecipient => '暗号化された送信先の会話';

  @override
  String get chatHistoryReview => '選択したメッセージを確認';

  @override
  String get chatHistoryMessages => 'メッセージ';

  @override
  String get chatHistoryConfirmDetail =>
      '共有前に送信先、各メッセージと時刻を確認してください。失敗または結果不明でも内容が送信済みの場合があります。続行前に送信結果を照合してください。';

  @override
  String get chatHistoryCompleted => '選択した履歴を送信し、グループの監査記録を確認しました';

  @override
  String get chatHistoryPending => '保留中：送信結果を照合し、再確認して続行してください。結果不明の送信は再送しません。';

  @override
  String get chatHistoryReconcile => '送信結果を照合';

  @override
  String get chatHistoryFailed =>
      '完了できません。管理者権限、グループポリシー、暗号化、送信先の参加状態と選択内容を確認してください。送信を開始した場合は結果を照合してください。';

  @override
  String get chatDeviceActions => '端末上のアクション';

  @override
  String get chatDeviceActionsReview =>
      '確認後、このメッセージのみを端末上のアクション提案機能に渡します。アクションを選択するとカレンダー、リマインダー、マップを開きます。';

  @override
  String get chatHistoryMaxMessages => 'メッセージ数の上限（1～50）';

  @override
  String get chatHistoryMaxHours => '履歴の対象時間（1～720 時間）';

  @override
  String get chatNotifyAll => 'すべてのメッセージ';

  @override
  String get chatNotifyAllDescription => 'このチャットの新しいメッセージをすべて通知';

  @override
  String get chatNotifyMentions => 'メンションのみ';

  @override
  String get chatNotifyMentionsDescription => '自分へのメンションまたは @room が使われた場合のみ通知';

  @override
  String get chatNotifyMutedDescription => 'すべてのデバイスでこのチャットの通知を無効にする';

  @override
  String get scheduledMessagesTitle => '送信予約メッセージ';

  @override
  String get scheduledMessagesEmpty => '送信予約メッセージはありません';

  @override
  String get scheduledMessagesHint => '送信、写真、ファイル、GIF、スタンプを長押しすると、送信を予約できます。';

  @override
  String get scheduledMessageCancelled => 'メッセージの送信予約をキャンセルしました';

  @override
  String scheduledMessageCreatedAt(String time) {
    return '作成日時：$time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => '配信が確認されていません';

  @override
  String get scheduledRecoveryCopy => '復元用コピーを保存';

  @override
  String get scheduledRecoveryCopyHint =>
      'メッセージを変更・送信せず、この端末に保存しました。プレビューは最大8,000文字です。';

  @override
  String get scheduledRecoveryCopies => '復元用コピー';

  @override
  String get scheduledRecoveryReset => '破損したキューをリセット';

  @override
  String get scheduledRecoveryResetHint =>
      '完全なコピーをこの端末に保存しました。このアカウントの予約メッセージをすべてリセットしますか？一部は送信済みの可能性があります。コピーと添付ファイルは保持され、再送信は行いません。';

  @override
  String get scheduledRecoveryExportHint =>
      'このファイルには暗号化されていない下書きのテキストとアカウント情報が含まれます。添付ファイルは含まれません。信頼できる保存先または共有先を選択してください。';

  @override
  String get scheduledRecoveryImport => '復元用コピーをインポート';

  @override
  String get scheduledRecoveryImportHint =>
      'このプレビューを復元用コピーとしてのみ保存します。メッセージの予約や送信は行いません。添付ファイルは含まれません。ファイルの作成者は確認されていません。';

  @override
  String get scheduledRecoveryComposerHint =>
      '確認用に現在の下書きへテキストを追加します。送信はされません。添付ファイル、メンション、タイマーは復元されません。このメッセージがすでに配信されていないか確認してください。';

  @override
  String get backupRecoverLegacyArchive => '以前のローカル履歴を復元';

  @override
  String get backupLegacyArchiveWarning =>
      'この履歴の所有者は確認されていません。自分のルームだけを下のアカウントにコピーしてください。元の履歴は保持されます。';

  @override
  String get backupOlderFiles => '以前のバックアップファイル';

  @override
  String get backupOlderFilesWarning =>
      'これらのファイルは別のアカウントのものかもしれません。ファイルを選び、内容と所有者を確認してから復元してください。';

  @override
  String get stickerImportTitle => 'ステッカーパックをインポート';

  @override
  String get stickerImportLinkHint => 'Matrix のステッカーパックリンク';

  @override
  String get stickerImportPreview => 'プレビュー';

  @override
  String get stickerImportUnavailable => 'このパックは利用できないか、アクセス権がありません。';

  @override
  String get stickerImportCopyNotice =>
      'このパックの非公開コピーを追加します。画像とメタデータはエンドツーエンド暗号化されていません。';

  @override
  String get stickerImportFailed => 'このパックを追加できませんでした。もう一度お試しください。';

  @override
  String get stickerImportAccountChanged =>
      'アカウントが変わったか、セッションが切れました。インポート画面を開き直してください。';

  @override
  String get stickerPackSourceRoom => '共有元のチャット';

  @override
  String get stickerPackImages => '画像';

  @override
  String get stickerPublishNotice =>
      'このパックを選択したグループに公開します。画像とメタデータはエンドツーエンド暗号化されません。グループの状態を読み取れる人がアクセスできる場合があります。';

  @override
  String get stickerPublishFailed => '公開結果を確認できませんでした。再試行する前にグループを確認してください。';

  @override
  String get stickerPublishReceiptMissing =>
      '公開されましたが、リンクを保存できませんでした。このページを離れる前に共有またはコピーしてください。';

  @override
  String get stickerSubscribe => '更新を購読';

  @override
  String get stickerSubscribeNotice =>
      'パックの管理者による今後の変更を受け取ります。画像とメタデータはエンドツーエンド暗号化されません。購読は後から解除できます。この操作で元のチャットに参加することはありません。';

  @override
  String get stickerSubscriptions => 'ステッカーの購読';

  @override
  String get stickerUnsubscribe => '購読を解除';

  @override
  String get stickerSubscriptionsEmpty => '購読中のステッカーはありません';

  @override
  String get chatAttachmentEvent => 'イベント';

  @override
  String get chatRecentMedia => '最近の写真と動画';

  @override
  String get chatRecentMediaLoadFailed => '最近のメディアを読み込めませんでした';

  @override
  String get chatRecentMediaPermission => '最近のメディアを表示するには写真へのアクセスが必要です';

  @override
  String get chatRecentMediaEmpty => '最近の写真や動画はありません';

  @override
  String get chatRecentPhoto => '最近の写真';

  @override
  String get chatRecentVideo => '最近の動画';

  @override
  String get chatAttachmentTip => 'チップ';

  @override
  String get chatAttachmentWhiteboard => 'ホワイトボード';

  @override
  String get chatAttachmentVideoNote => 'ビデオメッセージ';

  @override
  String get chatAttachmentCode => 'コード';

  @override
  String get chatAttachmentShop => 'ショップ';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '選択上限：$countString 件';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return '今夜（$time）';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return '明日の朝（$time）';
  }

  @override
  String get a11yScrollToBottom => '一番下へスクロール';

  @override
  String get ui3EnterMessageBeforeScheduling => '予約する前にメッセージを入力してください';

  @override
  String get ui3SendCode => 'コードを送信';

  @override
  String get ui3CodeLanguage => '言語';

  @override
  String get ui3PasteCodeHere => 'ここにコードを貼り付け';

  @override
  String ui3ReminderSetAt(String time) {
    return 'リマインダーを設定しました · $time';
  }

  @override
  String get ui3RedPacketCreateFailed => '紅包の作成に失敗しました';

  @override
  String get ui3SendTip => 'チップを送る';

  @override
  String get ui3TokenLabel => 'トークン';

  @override
  String get ui3NoteOptional => 'メモ（任意）';

  @override
  String ui3TipFailed(String error) {
    return 'チップの送信に失敗しました: $error';
  }

  @override
  String get ui3GiftNftTitle => 'NFT をギフト';

  @override
  String get ui3TokenId => 'トークン ID';

  @override
  String ui3NftGiftFailed(String error) {
    return 'NFT のギフトに失敗しました: $error';
  }

  @override
  String get ui3AiAgentSubtitle => 'タスクを説明して、最適なミニアプリを開く';

  @override
  String get ui3GiftNft => 'NFT をギフト';

  @override
  String get ui3GiftNftSubtitle => 'この連絡先に NFT を送る';

  @override
  String get ui3MiniAppUnavailable => 'ミニアプリは利用できません';

  @override
  String ui3MediaItemsNotSent(int count) {
    return '選択したメディア $count 件を送信できませんでした';
  }

  @override
  String get ui3PhotosSubtitle => 'チャット向けの形式で写真や動画を送信';

  @override
  String get ui3OriginalImages => 'オリジナル画像';

  @override
  String get ui3OriginalImagesSubtitle => '非圧縮の写真をファイルとして送信';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return '$filename を $time に予約しました';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return 'オリジナル画像を送信中: $filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return 'オリジナル画像を予約しました: $filename';
  }

  @override
  String get ui3PaymentAlreadySent => '支払いは送信済みです';

  @override
  String get ui3PaymentProcessing => '支払いを処理中です';

  @override
  String ui3ChainStatus(String status) {
    return 'チェーン上のステータス: $status';
  }

  @override
  String get ui3NotChecked => '未確認';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return '承認済み: $confirmations / $required ブロック';
  }

  @override
  String get ui3CopyTxHash => 'トランザクションハッシュをコピー';

  @override
  String get ui3VerifyAgain => '再検証';

  @override
  String get ui3VerifyOnChain => 'チェーン上で検証';

  @override
  String get ui3TransferMissingChainDetails =>
      'この送金には正確なチェーンとアセットの情報が含まれていません。';

  @override
  String get ui3ReceiptPending => 'チェーン上で保留中';

  @override
  String get ui3ReceiptConfirmed => '承認済み';

  @override
  String get ui3ReceiptFailed => 'チェーン上で失敗';

  @override
  String get ui3ReceiptMismatch => '取引内容が一致しません';

  @override
  String get ui3ReceiptUnsupported => 'チェーン検証には対応していません';

  @override
  String get ui3ReceiptUnavailable => '検証を利用できません';

  @override
  String get ui3OpenOrSave => '開く / 保存';

  @override
  String get ui3UnableToOpenFile => 'このファイルを開けません。';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'AI による書き換えに失敗しました: $error';
  }

  @override
  String get ui3AiShareMessagesTitle => 'AI とメッセージを共有しますか？';

  @override
  String get ui3AiShareMessagesBody =>
      'この返信に AI が使用できるメッセージを選択してください。この 1 回限りの許可は 2 分後に失効します。クイック返信を閉じると、保留中の結果はキャンセルされます。支払いやエクスポートは許可されません。';

  @override
  String get ui3OtherParticipant => '相手';

  @override
  String get ui3ShareSelected => '選択したものを共有';

  @override
  String get ui3BotCommandError => 'コマンドエラー';

  @override
  String get ui3BotUnknownCommand => '不明なコマンド';

  @override
  String get ui3BotTypeHelp => '/help と入力すると使用可能なコマンドを表示します。';

  @override
  String get ui3FilesMediaLinks => 'ファイル・メディア・リンク';

  @override
  String get ui3ChatStorage => 'チャットのストレージ';

  @override
  String get ui3EncryptionKeysDevices => '暗号鍵とデバイス';

  @override
  String get ui3EncryptionServiceUnavailable => '暗号化サービスはまだ利用できません';

  @override
  String get ui3ExportLoadingHistory => 'エクスポート用にチャット履歴をさらに読み込み中...';

  @override
  String get ui3ExportTxtDesc => 'メモ、バックアップ、コンプライアンス確認用のプレーンテキスト記録';

  @override
  String get ui3ExportCustomRange => 'カスタム期間';

  @override
  String get ui3ExportStart => '開始';

  @override
  String get ui3ExportEnd => '終了';

  @override
  String get ui3ExportSelectDate => '日付を選択';

  @override
  String get ui3FolderFilterUnreadOnly => '未読のみ';

  @override
  String get ui3FolderFilterMutedOnly => 'ミュート中のみ';

  @override
  String get ui3FolderFilterNoDms => 'DM を除く';

  @override
  String get ui3FolderFilterNoGroups => 'グループを除く';

  @override
  String get ui3FolderFilterNoChannels => 'チャンネルを除く';

  @override
  String get ui3FolderFilterAllChats => 'すべてのチャット';

  @override
  String get ui3Create => '作成';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return 'フォルダー「$name」を削除しますか？';
  }

  @override
  String get a11yDecreaseTextSize => '文字を小さく';

  @override
  String get a11yIncreaseTextSize => '文字を大きく';

  @override
  String ui3MinutesRead(int minutes) {
    return '約 $minutes 分で読めます';
  }

  @override
  String get ui3TipOnChain => 'オンチェーン ✓';

  @override
  String get ui3ViewSource => 'ソースを表示';

  @override
  String get a11yPreviousPage => '前のページ';

  @override
  String get a11yNextPage => '次のページ';

  @override
  String get ui3OpenExternalLinkTitle => '外部リンクを開きますか？';

  @override
  String get ui3Open => '開く';

  @override
  String get ui3UnableToOpenLink => 'このリンクを開けません。';

  @override
  String get ui3ImageUnavailable => '画像を表示できません';

  @override
  String ui3LoadImageFrom(Object host) {
    return '$host から画像を読み込む';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return '$host から画像を再読み込み';
  }

  @override
  String get ui3TranslatedByN42 => 'N42 による翻訳';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return 'N42 が$languageから翻訳';
  }

  @override
  String get ui3ClearWhiteboardTitle => 'ホワイトボードを消去しますか？';

  @override
  String get ui3ClearWhiteboardMessage => 'すべての描画が全員の画面から消去されます。この操作は元に戻せません。';

  @override
  String get ui3WhiteboardLive => 'ホワイトボード · ライブ';

  @override
  String get a11yPenColor => 'ペンの色';

  @override
  String get ui3AiDescribeOcr => 'AI 画像説明 / OCR';

  @override
  String get ui3DocumentPreviewFailed =>
      'このドキュメントを安全にプレビューできません。接続とファイルサイズ（最大 2MB）を確認してください。';

  @override
  String get ui3AiConsentMessage =>
      'この要約に AI が使用できるメッセージを選択してください。この 1 回限りの許可は 2 分後に失効します。支払いやエクスポートは許可されません。';

  @override
  String get ui3AiSuggestedReplies => '返信の候補';

  @override
  String get ui3AiGeneratingSuggestions => '候補を生成中...';

  @override
  String get ui3StickersEmpty => 'ステッカーはまだありません';

  @override
  String get ui3StickersGet => 'ステッカーを入手';

  @override
  String get a11yFormatBold => '太字';

  @override
  String get a11yFormatItalic => '斜体';

  @override
  String get a11yFormatStrikethrough => '取り消し線';

  @override
  String get a11yFormatInlineCode => 'インラインコード';

  @override
  String get a11yFormatCodeBlock => 'コードブロック';

  @override
  String get a11yFormatChecklistItem => 'チェックリスト項目';

  @override
  String get a11yFormatBulletList => '箇条書きリスト';

  @override
  String get a11yFormatNumberedList => '番号付きリスト';

  @override
  String get a11yFormatLink => 'リンク';

  @override
  String get a11yFormatTable => '表';

  @override
  String get a11yFormatMeetingTemplate => '会議テンプレート';

  @override
  String get a11yEmojiSmileys => 'スマイリーと人';

  @override
  String get a11yEmojiHearts => 'ハート';

  @override
  String get a11yEmojiAnimals => '動物と自然';

  @override
  String get a11yEmojiFood => '食べ物と飲み物';

  @override
  String get a11yEmojiTravel => '旅行と場所';

  @override
  String get a11yEmojiActivities => 'アクティビティ';

  @override
  String get a11yEmojiObjects => '物';

  @override
  String get a11yEmojiSymbols => '記号';

  @override
  String get ui3FrequentlyUsed => 'よく使う項目';

  @override
  String get ui3NoEditHistory => '編集履歴はありません';

  @override
  String get ui3EventNew => '新しい予定';

  @override
  String get ui3EventTitleLabel => 'タイトル';

  @override
  String get ui3EventLocationOptional => '場所（任意）';

  @override
  String get ui3EventDescriptionOptional => '説明（任意）';

  @override
  String get ui3EventSend => '予定を送信';

  @override
  String get ui3EventTitleRequired => 'タイトルを入力してください';

  @override
  String get ui3EventEndAfterStart => '終了時刻は開始時刻より後にしてください';

  @override
  String get ui3MiniAppAgentIntro => 'やりたいことを入力してください。最適なミニアプリを開きます。';

  @override
  String get ui3MiniAppAgentExample => '例：ETH を USDC にスワップ';

  @override
  String get ui3MiniAppAgentNoMatch => '一致するミニアプリが見つかりません。言い方を変えてお試しください。';

  @override
  String ui3MiniAppOpen(Object appName) {
    return '$appNameを開く';
  }

  @override
  String get ui3MusicLinkPlatforms =>
      'NetEase Cloud Music、QQ Music、Kugou、Kuwo などの曲リンクに対応';

  @override
  String get ui3PollMarkCorrectAnswer => '空でない正解を指定してください';

  @override
  String get ui3PollQuizMode => 'クイズモード';

  @override
  String get ui3PollAnswerExplanationHint => '解答の説明（任意）';

  @override
  String get a11yCorrectAnswer => '正解';

  @override
  String get ui3AiSuggestions => 'AI の提案';

  @override
  String get a11yPaste => '貼り付け';

  @override
  String get a11yRefresh => '更新';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      'このキーは安全に保管してください。すべてのデバイスにアクセスできなくなった場合、暗号化されたメッセージを復元する唯一の手段です。';

  @override
  String ui3SavedToPath(Object path) {
    return '保存しました：$path';
  }

  @override
  String get ui3UnknownAccount => '不明なアカウント';

  @override
  String get ui3UnknownHomeserver => '不明なホームサーバー';

  @override
  String get ui3ImportRecoveryKey => 'リカバリーキーをインポート';

  @override
  String get ui3ImportRecoveryKeyDesc =>
      'リカバリーキーを入力または貼り付けて、暗号化されたメッセージ履歴のルームキーを復元します。';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return 'アカウント：$account\\nホームサーバー：$homeserver';
  }

  @override
  String get ui3Import => 'インポート';

  @override
  String get ui3InvalidRecoveryKeyFormat => 'リカバリーキーの形式が正しくありません';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return '$total 個中 $restored 個のキーを復元しました。$failed 個は失敗しました。アカウント、ネットワーク、バックアップを確認して再試行してください。一部の履歴は読めないままになる可能性があります。';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return '$total 個中 $restored 個のキーを復元しました';
  }

  @override
  String ui3ImportFailed(Object error) {
    return 'インポートに失敗しました：$error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return 'パスキーの登録に失敗しました：$error';
  }

  @override
  String get ui3PasskeyDefaultName => 'マイパスキー';

  @override
  String get ui3PasskeyNameHint => '例：iPhone、MacBook';

  @override
  String get ui3PasskeyDeleteFailed => 'パスキーを削除できませんでした';

  @override
  String get ui3TwoFactorAuth => '2 要素認証';

  @override
  String get ui3TwoFactorOnSubtitle => 'オン — 認証アプリのコードが必要';

  @override
  String get ui3TwoFactorOffSubtitle => 'オフ — 認証アプリ（TOTP）で保護';

  @override
  String get ui3ShowRecoveryKey => 'リカバリーキーを表示';

  @override
  String get ui3ShowRecoveryKeyDesc => 'バックアップ用にリカバリーキーを表示';

  @override
  String get ui3ImportRecoveryKeyHint => 'リカバリーキーでメッセージを復元';

  @override
  String get ui3RecoveryKeyCreateFailed => 'リカバリーキーを作成できませんでした';

  @override
  String get ui3TotpIncorrectCode => 'コードが正しくありません。もう一度お試しください';

  @override
  String get ui3TwoFactorEnabled => '2 要素認証をオンにしました';

  @override
  String get ui3TwoFactorDisabled => '2 要素認証をオフにしました';

  @override
  String get ui3TwoFactorTurnOffTitle => '2 要素認証をオフにしますか？';

  @override
  String get ui3TwoFactorTurnOffMessage => '認証アプリは不要になります。後で新しいキーを使って再設定できます。';

  @override
  String get ui3TurnOff => 'オフにする';

  @override
  String get ui3TwoFactorTotpTitle => '2 要素認証（TOTP）';

  @override
  String get ui3TwoFactorIsOn => '2 要素認証はオンです';

  @override
  String get ui3TwoFactorCodeRequired => '認証アプリのコードが必要です。';

  @override
  String get ui3TotpStepScan =>
      '1. 認証アプリ（Google Authenticator、Authy、1Password など）でこの QR コードをスキャンするか、キーを手動で入力してください。';

  @override
  String get ui3TotpKeyCopied => 'キーをコピーしました';

  @override
  String get ui3TotpStepConfirm => '2. 確認のため 6 桁のコードを入力してください。';

  @override
  String get ui3Enable => '有効にする';

  @override
  String get ui3BackupSettingsDesc =>
      'ローカルのチャット設定をバックアップします。メッセージは再ログイン後にサーバーから復元されます。';

  @override
  String get ui3BackupKeysSeparate => '暗号化キーは別途管理されます';

  @override
  String get ui3BackupKeysSeparateHint =>
      '暗号化メッセージへのアクセスをバックアップするには、「セキュリティ > リカバリーキー」を使用してください。';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return '$rooms ルーム  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      '別のデバイスまたは以前のバックアップから .n42backup ファイルをインポートします。暗号化キーはリカバリーキーで別途復元されます。';

  @override
  String get ui3UsernameSessionRequired => 'ユーザー名の設定には有効なセッションが必要です';

  @override
  String get ui3SecuritySessionRequired => 'セキュリティ設定には有効なセッションが必要です';

  @override
  String get ui3ConnectedAccountsSessionRequired => '連携アカウントには有効なセッションが必要です';

  @override
  String get ui3SystemAccounts => 'システムとアカウント';

  @override
  String get ui3AccountIdentity => 'アカウントと ID';

  @override
  String get ui3Accounts => 'アカウント';

  @override
  String get ui3DevicesSessions => 'デバイスとセッション';

  @override
  String get ui3Integrations => '連携';

  @override
  String get ui3ConnectedAccounts => '連携アカウント';

  @override
  String get ui3ConnectedAccountsDesc =>
      'Telegram、WhatsApp、Discord、API ブリッジとの連携';

  @override
  String get ui3SystemOverview => 'システムの概要';

  @override
  String ui3AccountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count アカウント',
      one: '1 アカウント',
    );
    return '$_temp0';
  }

  @override
  String ui3DeviceCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 台のデバイス',
      one: '1 台のデバイス',
    );
    return '$_temp0';
  }

  @override
  String get ui3PrivacySecurityOverview => 'エンドツーエンド暗号化、スクリーンショット保護、プロキシ設定';

  @override
  String get ui3ConversationPrivacy => '会話のプライバシー';

  @override
  String get ui3NetworkPrivacy => 'ネットワークのプライバシー';

  @override
  String get ui3IdentityPrivacy => 'ID のプライバシー';

  @override
  String get ui3EncryptionKeyBackup => '暗号化とキーのバックアップ';

  @override
  String get ui3DevicesVerification => 'デバイスと認証';

  @override
  String get ui3ChipE2eeDefault => 'E2EE（デフォルト）';

  @override
  String get ui3ChipManualE2ee => 'E2EE（手動）';

  @override
  String get ui3ChipSelfDestruct => '自動消去';

  @override
  String get ui3ChipScreenshotGuard => 'スクリーンショット保護';

  @override
  String get ui3ChipIpProxy => 'IP / プロキシ';

  @override
  String get ui3ChipLinkPreviewsOff => 'リンクプレビューオフ';

  @override
  String get ui3ChipPublicHandle => '公開ユーザー名';

  @override
  String get a11yShowPassword => 'パスワードを表示';

  @override
  String get a11yHidePassword => 'パスワードを非表示';

  @override
  String get a11yCheckServer => 'サーバーを確認';

  @override
  String get ui3AuthAnonymousRegistration => '匿名登録';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      '電話番号やメールアドレスを連携せずにアカウントを作成します。ユーザー名は自動で生成されます。';

  @override
  String get ui3AuthAnonymousModeOn => '匿名モードがオンです';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      'アプリがランダムな Matrix ユーザー名を作成します。後から生成されたアカウントとパスワードでサインインできます。';

  @override
  String get ui3AuthChooseLoginMethod => 'ログイン方法を選択';

  @override
  String get ui3AuthSsoOpenFailed => 'SSO ログインページを開けませんでした';

  @override
  String get ui3AuthWalletUnavailable => 'ウォレットは利用できません';

  @override
  String get ui3ProfileSubscriptions => 'サブスクリプション';

  @override
  String get ui3ProfileBuySellCrypto => '暗号資産の売買';

  @override
  String get ui3ProfileOnDeviceAi => '端末上の AI';

  @override
  String get ui3ProfileSetAUsername => 'ユーザー名を設定';

  @override
  String get ui3ProfileAvatarStudio => 'アバタースタジオ';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'NFT アバター / デコレーション';

  @override
  String get ui3ProfileCustomize => 'カスタマイズ';

  @override
  String get ui3ProfileQrSubtitle => 'スキャンしてこのプロフィールを開くか、チャットを開始';

  @override
  String get ui3PrivacyHardening => 'プライバシー強化';

  @override
  String get ui3HidePhoneNumber => '電話番号を隠す';

  @override
  String get ui3HidePhoneNumberDesc => 'この端末のプロフィール関連画面で、連携済みの電話番号を伏せて表示します';

  @override
  String get ui3EncryptNewChatsByDefault => '新しいチャットをデフォルトで暗号化';

  @override
  String get ui3EncryptNewChatsByDefaultDesc =>
      '新しい個別チャットと非公開ルームを E2EE 有効で開始します';

  @override
  String get ui3PrivateChatMode => 'プライベートチャットモード';

  @override
  String get ui3PrivateChatModeDesc =>
      '非公開または暗号化チャットの表示中、一時的にスクリーンショットをブロックします';

  @override
  String get ui3DefaultSelfDestructTimer => 'デフォルトの自動消去タイマー';

  @override
  String get ui3DefaultSelfDestructTimerDesc =>
      '新しく送信するメッセージにデフォルトの自動消去タイマーを適用します';

  @override
  String get ui3LinkPreviews => 'リンクプレビュー';

  @override
  String get ui3LinkPreviewsDesc => 'メッセージに URL が含まれる場合、タイトル・説明・サムネイルを取得します';

  @override
  String get ui3IpAddressProtection => 'IP アドレス保護';

  @override
  String get ui3IpAddressProtectionDesc =>
      '利用可能な場合、Matrix とリンクプレビューのリクエストを設定済みの HTTP プライバシープロキシ経由で送信します';

  @override
  String get ui3UseTorProxy => 'Tor / Privoxy HTTP プロキシを使用';

  @override
  String get ui3UseTorProxyDesc =>
      '127.0.0.1:8118 の Privoxy などのローカル HTTP プロキシエンドポイントを使用します。ネイティブの SOCKS5 Tor ルーティングはここでは非対応です。';

  @override
  String get ui3CustomProxy => 'カスタムプロキシ';

  @override
  String get ui3CustomProxyDesc =>
      'Matrix の通信とリンクプレビューにカスタム HTTP または HTTPS プロキシを使用します';

  @override
  String get ui3ProxyEndpoint => 'プロキシアドレス';

  @override
  String get ui3ProxyEndpointDesc => 'HTTP/HTTPS プロキシアドレス（SOCKS は非対応）';

  @override
  String get ui3InvalidEndpoint => '無効なアドレス';

  @override
  String get ui3CustomProxyStaysOff => '有効なアドレスを設定するまで、カスタムプロキシはオフのままです';

  @override
  String get ui3NotificationFilterNote =>
      '優先ルールは常に通知します（ミュート、メンションのみ、おやすみモードを無視）。ミュートキーワードは通知を抑制します。';

  @override
  String get ui3PriorityKeywords => '優先キーワード';

  @override
  String get ui3PriorityKeywordHint => '例：至急';

  @override
  String get ui3MutedKeywords => 'ミュートキーワード';

  @override
  String get ui3MutedKeywordHint => '例：スパム';

  @override
  String get ui3PrioritySenders => '優先送信者';

  @override
  String get ui3CaseSensitive => '大文字と小文字を区別';

  @override
  String get ui3None => 'なし';

  @override
  String get ui3SmartReplyTranslation => 'スマート返信の翻訳';

  @override
  String get ui3SmartReplyTranslationDesc => '送信前にメッセージを相手の言語へ自動で翻訳します。';

  @override
  String get ui3FromPhotos => '写真から選択';

  @override
  String get ui3ChangePhoto => '写真を変更';

  @override
  String get ui3RoamingUsesMobileData => 'ローミング時はモバイルデータのルールを適用';

  @override
  String get ui3RoamingUsesMobileDataDesc =>
      'ローミングの個別検出はまだ利用できないため、現在ローミング時はモバイルデータの自動ダウンロード設定に従います。';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return '「$content」を削除しますか？';
  }

  @override
  String get ui3ResetToDefaults => 'デフォルトに戻す';

  @override
  String get ui3ResetQuickRepliesMessage =>
      'カスタムのクイック返信をすべて削除し、デフォルトに戻します。続行しますか？';

  @override
  String get ui3LocalLlmUnavailable => 'この端末では非対応';

  @override
  String get ui3LocalLlmNotDownloaded => 'モデル未ダウンロード';

  @override
  String get ui3LocalLlmReady => '準備完了（端末上）';

  @override
  String get ui3LocalLlmDescription =>
      '有効かつ準備完了の場合、AI 機能（要約、書き換え、翻訳、返信）は完全に端末上で動作し、データがスマートフォンの外に出ることはありません。それ以外の場合はクラウドプロバイダーを使用します。';

  @override
  String get ui3UseOnDeviceAi => '端末上の AI を使用';

  @override
  String get ui3UseOnDeviceAiDesc => '準備完了時はローカル推論を優先';

  @override
  String get ui3DownloadModel => 'モデルをダウンロード';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      '端末上での推論にはネイティブランタイム（Android MediaPipe / iOS Core ML）が必要です。プラットフォームハンドラーが利用可能になると自動的に有効になります。';

  @override
  String get ui3PhotoAvatar => '写真アバター';

  @override
  String get ui3AvatarStyles => 'アバタースタイル';

  @override
  String get ui3AvatarStylesDesc => 'プロフィールとアバターの各入口で同じデコレーション選択を使用します。';

  @override
  String get ui3ReplaceNftAvatar => 'NFT アバターを変更';

  @override
  String get ui3NftAvatarDesc => 'オンチェーンのコレクティブルをアバターとして使用します。';

  @override
  String get ui3UsePhotoAvatar => '写真アバターを使用';

  @override
  String get ui3UsePhotoAvatarDesc => 'アップロード済みのアバターを残し、NFT の連携を解除します。';

  @override
  String ui3AvatarStyleSet(Object name) {
    return 'アバタースタイルを設定しました：$name';
  }

  @override
  String get ui3NftAvatarUpdated => 'NFT アバターを更新しました';

  @override
  String get ui3SwitchedToPhotoAvatar => '写真アバターに戻しました';

  @override
  String get ui3SignInToViewRedPacketHistory => 'サインインしてお年玉の履歴を表示';

  @override
  String get ui3RedPacketActive => '進行中';

  @override
  String get ui3RedPacketCompleted => '受取完了';

  @override
  String get ui3CardsAndPasses => 'カードとパス';

  @override
  String get ui3CardsAndPassesDesc => 'ウォレットのカード、クーポン、パスはメインアプリで管理されます。';

  @override
  String get ui3CardPackRequiresMainApp => 'カードパックにはメインアプリが必要です';

  @override
  String get ui3OpenCardPack => 'カードパックを開く';

  @override
  String get ui3UnableToOpenChat => 'この連絡先とのチャットを開けません';

  @override
  String get ui3WalletManagedInMainApp => 'ウォレットはメインアプリで管理されています';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · プラン';
  }

  @override
  String get ui3NewPlan => '新しいプラン';

  @override
  String get ui3MySubscriptions => 'マイサブスクリプション';

  @override
  String get ui3AvailablePlans => '利用可能なプラン';

  @override
  String get ui3NoPlansYet => 'プランはまだありません · 「新しいプラン」をタップして作成';

  @override
  String ui3DaysLeft(Object days) {
    return '残り $days 日';
  }

  @override
  String get ui3SubscriptionCancelled => 'キャンセル済み';

  @override
  String get ui3AutoRenewOn => '自動更新：オン';

  @override
  String get ui3AutoRenewOff => '自動更新：オフ';

  @override
  String get ui3CancelSubscriptionTitle => 'サブスクリプションをキャンセルしますか？';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return '$name のサブスクリプションは期限まで有効で、更新されません。';
  }

  @override
  String get ui3Subscribe => '登録する';

  @override
  String ui3SubscribedTo(Object name) {
    return '$name に登録しました';
  }

  @override
  String get ui3PlanPriceLabel => '価格（例：9.9 USDT）';

  @override
  String get ui3PlanDescriptionLabel => '説明（任意）';

  @override
  String get ui3PlanBenefitsLabel => '特典（カンマ区切り）';

  @override
  String get ui3PlanPeriod => '期間：';

  @override
  String get ui3Monthly => '月額';

  @override
  String get ui3Yearly => '年額';

  @override
  String get ui3SaveRemarkFailed => 'メモを保存できませんでした';

  @override
  String get ui3CopyLink => 'リンクをコピー';

  @override
  String get ui3Connect => 'つながる';

  @override
  String get ui3CommonTokens => '共通のトークン';

  @override
  String get ui3SharedNfts => '共通の NFT';

  @override
  String get ui3TransactionHistory => '取引履歴';

  @override
  String get ui3CommonDaos => '共通の DAO';

  @override
  String get ui3SameChains => '同じチェーン';

  @override
  String get ui3ChatInitFailed => 'チャットの初期化に失敗しました';

  @override
  String get ui3CheckNetworkRetry => 'ネットワークを確認してもう一度お試しください';

  @override
  String get ui3FromContacts => '連絡先から';

  @override
  String get ui3FindFriendsFromContacts => '電話の連絡先から友だちを探す';

  @override
  String get ui3EnsOrDomain => 'ENS / ドメイン';

  @override
  String get ui3LoadingContacts => '連絡先を読み込み中...';

  @override
  String get ui3ContactsPermissionRequired => '連絡先へのアクセス許可が必要です';

  @override
  String get ui3ContactsPermissionMessage =>
      '連絡先から友だちを探すには、連絡先へのアクセスを許可してください。';

  @override
  String get ui3AllowAccess => 'アクセスを許可';

  @override
  String get ui3NoContactMatches => '一致する連絡先はありません';

  @override
  String get ui3NoContactMatchesMessage => 'このアプリを使っている連絡先はまだいません。招待してみましょう！';

  @override
  String ui3ScannedContacts(Object count) {
    return '$count 件の連絡先をスキャンしました';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return '連絡先から $count 件見つかりました';
  }

  @override
  String ui3InContactsAs(Object name) {
    return '連絡先の名前：$name';
  }

  @override
  String get ui3DeletePhotoConfirm => 'この写真を削除しますか？';

  @override
  String get ui3InviteLink => '招待リンク';

  @override
  String get ui3ShareJoinLink => 'このルームの参加リンクを共有';

  @override
  String get ui3ShareRoomReference => '招待済みメンバーにルーム参照を共有';

  @override
  String get ui3ScanToJoinGroup => 'スキャンしてこのグループに直接参加';

  @override
  String get ui3ScanToShareRoomReference => 'スキャンして招待済みメンバーにこのルーム参照を共有';

  @override
  String get ui3InviteLinkLoadFailed => '招待リンクを読み込めませんでした';

  @override
  String get ui3InviteLinkCopied => '招待リンクをコピーしました';

  @override
  String get ui3ChannelCategoryOptional => 'カテゴリ（任意）';

  @override
  String get ui3ChannelCategoryHint => 'お知らせ / 製品 / サポート';

  @override
  String get ui3DescriptionOptional => '説明（任意）';

  @override
  String get ui3WebhookEnable => 'Webhook 自動化を有効にする';

  @override
  String get ui3WebhookEnableDesc => 'メンバー参加とウェルカムのイベントを連携先エンドポイントに送信します。';

  @override
  String get ui3WebhookUrl => 'Webhook の URL';

  @override
  String get ui3WebhookSecretOptional => '署名シークレット（任意）';

  @override
  String get ui3WebhookSecretHint => 'X-N42-Signature に使用';

  @override
  String get ui3WebhookNotifyMemberJoined => 'メンバーの参加時に通知';

  @override
  String get ui3WebhookNotifyWelcomeSent => 'ウェルカムメッセージ送信時に通知';

  @override
  String get ui3WebhookTestSend => 'テスト Webhook を送信';

  @override
  String get ui3WebhookTestSending => 'テスト Webhook を送信中...';

  @override
  String get ui3WebhookTestSent => 'テスト Webhook を送信しました';

  @override
  String get ui3WebhookTestFailed => 'テスト Webhook を送信できませんでした';

  @override
  String get ui3WebhookUrlInvalid => 'Webhook の URL は公開 HTTPS アドレスである必要があります';

  @override
  String get ui3WebhookSelectEvent => 'Webhook イベントを 1 つ以上選択してください';

  @override
  String get ui3SensitiveDataDetection => '機密情報の検出';

  @override
  String get ui3Email => 'メール';

  @override
  String get ui3CreditCard => 'クレジットカード';

  @override
  String get ui3DetectEmailDesc => 'テキストメッセージ内のメールアドレスを検出';

  @override
  String get ui3DetectPhoneDesc => '電話番号と国際番号を検出';

  @override
  String get ui3DetectCardDesc => '銀行口座やカード番号と思われる数字を検出';

  @override
  String get ui3DetectWalletDesc => 'Ethereum 形式のウォレットアドレスを検出';

  @override
  String get ui3GeneralTopic => '一般';

  @override
  String get a11yPreviousResult => '前の結果';

  @override
  String get a11yNextResult => '次の結果';

  @override
  String get ui3TryDifferentKeywords => '別のキーワードをお試しください';

  @override
  String ui3FiltersActive(Object count) {
    return '適用中のフィルター：$count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return '適用中のメッセージフィルター：$count';
  }

  @override
  String get ui3LoadMore => 'さらに読み込む';

  @override
  String get ui3MessageFilters => 'メッセージフィルター';

  @override
  String get ui3SenderUserId => '送信者のユーザー ID';

  @override
  String get ui3FilterType => '種類';

  @override
  String get ui3FilterAny => 'すべて';

  @override
  String get ui3FilterImage => '画像';

  @override
  String get ui3FilterTime => '期間';

  @override
  String get ui3AnyTime => '期間指定なし';

  @override
  String get ui3OnlyMyMessages => '自分のメッセージのみ';

  @override
  String get ui3MediaOnly => 'メディアのみ';

  @override
  String get ui3Apply => '適用';

  @override
  String get ui3QrStyleClassic => 'クラシック';

  @override
  String get ui3QrStyleOcean => 'オーシャン';

  @override
  String get ui3QrStyleBerry => 'ベリー';

  @override
  String get ui3NfcUnavailable =>
      'NFC が利用できないか、タグに対応していません。NFC を有効にするか、別のタグを試すか、QR を使用してください。';

  @override
  String get ui3CancelNfc => 'NFC をキャンセル';

  @override
  String get ui3ReadNfcTag => 'NFC タグを読み取る';

  @override
  String get ui3HoldNearNfcTag => 'スマートフォンをサービスタグに近づけてください。';

  @override
  String get a11yFlashlightOn => 'ライトをオン';

  @override
  String get a11yFlashlightOff => 'ライトをオフ';

  @override
  String get ui3SocialGraph => 'ソーシャルグラフ';

  @override
  String get ui3RecommendedConnections => 'おすすめのつながり';

  @override
  String get ui3Portfolio => 'ポートフォリオ';

  @override
  String get ui3Chains => 'チェーン';

  @override
  String get ui3Tokens => 'トークン';

  @override
  String get ui3NoConnectionsFound => 'つながりが見つかりません';

  @override
  String get ui3ConnectionsHint => 'オンチェーンでの活動が増えると、つながりが表示されます';

  @override
  String get ui3SocialGraphLoadFailed => 'ソーシャルグラフを読み込めませんでした';

  @override
  String get ui3Similarity => '類似度';

  @override
  String get ui3Breakdown => '内訳';

  @override
  String get ui3TokenHoldings => '保有トークン';

  @override
  String get ui3NftCollections => 'NFTコレクション';

  @override
  String get ui3ChainUsage => 'チェーン利用状況';

  @override
  String get ui3Transactions => '取引';

  @override
  String get ui3DaoMembership => 'DAOメンバーシップ';

  @override
  String get ui3NotWeighted => '重み付けなし';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent%(重み: $weight)';
  }

  @override
  String get ui3CommonOnChainActivity => '共通のオンチェーンアクティビティ';

  @override
  String get ui3SharedTokens => '共通のトークン';

  @override
  String get ui3SharedNftCollections => '共通のNFTコレクション';

  @override
  String get ui3SharedChains => '共通のチェーン';

  @override
  String get ui3NoSharedTokens => '共通のトークンはありません';

  @override
  String get ui3NoSharedNftCollections => '共通のNFTコレクションはありません';

  @override
  String get ui3NoSharedChains => '共通のチェーンはありません';

  @override
  String get ui3SimilarityFailed => '類似度を計算できませんでした';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items 他$count件';
  }

  @override
  String get a11yGovernance => 'ガバナンス';

  @override
  String get ui3CommunityLink => 'コミュニティリンク';

  @override
  String get ui3CommunityQrCode => 'コミュニティQRコード';

  @override
  String get ui3CommunityQrSubtitle => 'スキャンしてこのコミュニティに参加し、チャンネルを見る';

  @override
  String get ui3CommunityLinkLoadFailed => 'コミュニティリンクを読み込めませんでした';

  @override
  String get ui3CommunityLinkCopied => 'コミュニティリンクをコピーしました';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name をこのコミュニティから削除します。';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name を削除し、再参加できなくします。';
  }

  @override
  String get ui3SignInToDiscoverChannels => 'ログインして公開チャンネルを探す';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return '$name に参加できません: $error';
  }

  @override
  String get ui3CategoryTech => 'テクノロジー';

  @override
  String get ui3CategorySocial => 'ソーシャル';

  @override
  String get ui3NoPublicChannels => '公開チャンネルが見つかりません';

  @override
  String get ui3StoriesAndFun => 'ストーリー＆エンタメ';

  @override
  String get ui3SearchMusicHint => '曲、アーティスト、友達を検索';

  @override
  String get ui3ForYou => 'おすすめ';

  @override
  String get ui3Liked => 'いいね済み';

  @override
  String get ui3NoLikedMusic => 'いいねした音楽はまだありません';

  @override
  String get ui3NoMusicStories => '音楽ストーリーはまだありません';

  @override
  String get ui3LikedMusicHint => '曲の横のハートをタップすると、ここに保存されます。';

  @override
  String get ui3MusicStoriesHint => 'ストーリーで共有された音楽がここに表示されます。';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · $name がシェア';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return '$title を再生できません: $error';
  }

  @override
  String get a11yPreviousTrack => '前のトラック';

  @override
  String get a11yNextTrack => '次のトラック';

  @override
  String get a11yPlay => '再生';

  @override
  String get a11yPause => '一時停止';

  @override
  String get ui3Refresh => '更新';

  @override
  String get ui3NearbyIntroTitle => '近くの公開投稿を見つける';

  @override
  String get ui3NearbyIntroBody =>
      '位置情報は公開モーメントの並べ替えのためにこの端末で一度だけ使用されます。アップロード、配信、他の人への表示は行われません。';

  @override
  String get ui3UseMyLocation => '現在地を使用';

  @override
  String get ui3NearbyUnavailable => '「近く」は利用できません';

  @override
  String get ui3NoNearbyPosts => '近くの投稿はまだありません';

  @override
  String get ui3NoNearbyPostsHint => '位置情報付きの公開モーメントがここに表示されます。';

  @override
  String get ui3NearbyDistanceNote => 'おおよその距離 · 位置情報付きの公開投稿のみ';

  @override
  String get ui3PublicLocationPost => '位置情報付きの公開投稿';

  @override
  String get ui3LocationServicesOff => '位置情報サービスがオフになっています';

  @override
  String get ui3LocationPermissionDenied => '位置情報の許可が拒否されました';

  @override
  String get ui3EnableLocationInSettings => 'システム設定で位置情報の許可をオンにしてください';

  @override
  String get ui3CreateStory => 'ストーリーを作成';

  @override
  String get ui3CreateStoryDesc => 'テキストや写真のステータスを投稿します。';

  @override
  String get ui3StoryCamera => 'ストーリーカメラ';

  @override
  String get ui3StoryCameraDesc => 'フィルターと写真編集にすぐ移動します。';

  @override
  String get ui3MomentsDesc => 'フィード全体とコメントを開きます。';

  @override
  String get ui3MomentCamera => 'モーメントカメラ';

  @override
  String get ui3MomentCameraDesc => '投稿を作成してすぐにメディアを選択します。';

  @override
  String get ui3GamesDesc => '内蔵のカジュアルゲームセンターを起動します。';

  @override
  String get ui3AvatarStudio => 'アバタースタジオ';

  @override
  String get ui3AvatarStudioDesc => 'デコレーション、NFTアバター、アイデンティティの装飾。';

  @override
  String get ui3SocialGraphDesc => 'オンチェーンのフォロー、ファン、つながり。';

  @override
  String get ui3SocialHubHeroTitle => 'ストーリー、モーメント、ゲーム、アバター';

  @override
  String get ui3SocialHubHeroBody => 'チャット、プロフィール、発見に散らばらず、ソーシャル機能を1か所に集約。';

  @override
  String get ui3SocialGraphNotConfigured => 'このビルドではソーシャルグラフが設定されていません';

  @override
  String get ui3ConnectWalletForSocialGraph => 'ウォレットを接続してソーシャルグラフを表示';

  @override
  String get ui3AvatarStudioSignIn => 'アバタースタジオを使うにはログインが必要です';

  @override
  String get a11yRemoveImage => '画像を削除';

  @override
  String get a11yBack => '戻る';

  @override
  String get ui3MiniAppConfirmTransactionTitle => '取引を確認';

  @override
  String get ui3MiniAppConfirmTransactionBody =>
      'ミニアプリがあなたに代わって取引の送信をリクエストしています。';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return '$name を開きますか？';
  }

  @override
  String get ui3MiniAppOpenButton => '開く';

  @override
  String get ui3StoryReplySendFailed => 'ストーリーへの返信を送信できませんでした';

  @override
  String get ui3RedPacketDemoNotice =>
      'デモ用お年玉 — チャット内の記録のみで、実際のオンチェーン資産は送金されません。';

  @override
  String get ui3RedPacketCoverClassic => 'クラシックレッド';

  @override
  String get ui3RedPacketCoverGolden => 'ゴールド';

  @override
  String get ui3RedPacketCoverPurple => 'パープル';

  @override
  String get ui3RedPacketCoverOceanBlue => 'オーシャンブルー';

  @override
  String get ui3RedPacketCoverNatureGreen => 'ネイチャーグリーン';

  @override
  String get ui3RedPacketCoverRosePink => 'ローズピンク';

  @override
  String get ui3RedPacketHistoryEmpty => 'お年玉はまだありません';

  @override
  String get ui3TransferMerchantQrWithAmount => '加盟店QR（金額指定）';

  @override
  String get ui3TransferMerchantQrTitle => '加盟店QR';

  @override
  String get ui3TransferOpenAmountHint => '金額を自由にする場合は空欄のまま';

  @override
  String get ui3FiatRampTitle => '暗号資産の購入 / 売却';

  @override
  String get ui3FiatRampBuy => '購入';

  @override
  String get ui3FiatRampSell => '売却';

  @override
  String get ui3FiatRampNotConfigured => '法定通貨のオン/オフランプが設定されていません';

  @override
  String get a11yPointsAddRule => '報酬ルールを追加';

  @override
  String get a11yGovernanceRemoveChoice => '選択肢を削除';

  @override
  String get a11yGovernanceCreateProposal => '提案を作成';

  @override
  String get ui3MiniAppUpdateN42 => 'N42をアップデート';

  @override
  String get ui3MiniAppOfficial => '公式';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count 人のユーザー';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return '背景色 $index';
  }

  @override
  String get a11yStoryAdd => 'ストーリーを追加';

  @override
  String get ui3StoryPostFailed => 'ストーリーを投稿できませんでした';

  @override
  String get ui3StoryTapToSelectImage => 'タップして画像を選択';

  @override
  String get ui3StoryChangeImage => '変更';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return '選択した音楽を読み込めません: $error';
  }

  @override
  String get ui3StoryDeleteConfirm => 'このストーリーを削除しますか？';

  @override
  String get ui3StoryDeleteFailed => 'ストーリーを削除できませんでした';

  @override
  String get ui3MomentCreateTitle => 'モーメントを作成';

  @override
  String get ui3MomentContentHint => 'いまどうしてる？';

  @override
  String get ui3MomentAddPhotos => '写真を追加';

  @override
  String get ui3MomentAddLocation => '位置情報を追加';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return '選択したメディア（$count）';
  }

  @override
  String get ui3MomentClearAll => 'すべてクリア';

  @override
  String get ui3MomentClearMediaConfirm => '選択した写真/動画をすべて削除しますか？';

  @override
  String get ui3MomentVisibilityPublicDesc => 'すべての友達に公開';

  @override
  String get ui3MomentVisibilityPrivateDesc => '自分のみ';

  @override
  String get ui3MomentVisibilityPartialDesc => '公開する相手を選択';

  @override
  String get ui3MomentVisibilityExcludedDesc => '特定の友達に非公開';

  @override
  String get ui3MomentVideos => '動画';

  @override
  String get ui3MomentNoVideos => '動画はまだありません';

  @override
  String get a11yCallMinimize => '最小化';

  @override
  String get a11yCallGridView => 'グリッド表示';

  @override
  String get a11yCallFocusView => 'フォーカス表示';

  @override
  String get ui3CallTools => '通話ツール';

  @override
  String get ui3CallMeetingTools => '会議ツール';

  @override
  String get ui3CallToolsSubtitle => '通話を終了せずに音声と映像の品質を調整できます。';

  @override
  String get ui3CallAudioEnhancement => '音声補正';

  @override
  String get ui3CallNoiseSuppression => 'ノイズ抑制';

  @override
  String get ui3CallNoiseSuppressionDesc => 'キーボード音や周囲の雑音を抑えます。';

  @override
  String get ui3CallEchoCancellation => 'エコーキャンセル';

  @override
  String get ui3CallEchoCancellationDesc => 'スピーカーの音がマイクに回り込むのを防ぎます。';

  @override
  String get ui3CallAutoGainControl => '自動ゲイン調整';

  @override
  String get ui3CallAutoGainControlDesc => 'マイク音量を安定させます。';

  @override
  String get ui3CallVoiceIsolation => '強化された音声分離';

  @override
  String get ui3CallVoiceIsolationDesc => 'より強力なノイズ低減プロファイルを使用します。';

  @override
  String get ui3CallVideoSection => 'ビデオ';

  @override
  String get ui3CallBackgroundBlur => '背景ぼかし（ベータ）';

  @override
  String get ui3CallBlurDescReady => '設定は反映済みです。実際のぼかしはビデオ処理機能の提供状況によります。';

  @override
  String get ui3CallBlurDescSaved => 'ぼかし設定を保存しました。カメラ処理が利用可能になると適用されます。';

  @override
  String get ui3CallBlurDescCameraOff => '背景処理が利用可能になったらカメラをオンにしてください。';

  @override
  String get ui3CallRecordingSection => '録画';

  @override
  String get ui3CallRecordingDesc => '録画を保存するにはサーバー側のエグレスが必要です。';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return '通話設定を更新できませんでした: $error';
  }

  @override
  String get ui3CallRecordingStarted => '録画を開始しました';

  @override
  String get ui3VoiceRoomNotFound => 'ルームが見つかりません';

  @override
  String get ui3VoiceRoomEndConfirm => 'このボイスルームを終了してもよろしいですか？';

  @override
  String get a11yGameMoveUp => '上に移動';

  @override
  String get a11yGameMoveDown => '下に移動';

  @override
  String get a11yGameMoveLeft => '左に移動';

  @override
  String get a11yGameMoveRight => '右に移動';

  @override
  String get a11yGameRotate => '回転';

  @override
  String get a11yGameDrop => '落とす';

  @override
  String ui3StickerAddedCount(Object count) {
    return '$count 個のステッカーを追加しました';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return '追加できませんでした: $error';
  }

  @override
  String get ui3StickerRemoveTitle => 'ステッカーを削除';

  @override
  String get ui3StickerRemoveConfirm => 'このステッカーをパックから削除しますか？';

  @override
  String get ui3StickerRemoveFailed => '削除できませんでした';

  @override
  String get ui3StickerRenamePack => 'パック名を変更';

  @override
  String get ui3StickerPackName => 'パック名';

  @override
  String get ui3StickerRenameFailed => '名前を変更できませんでした';

  @override
  String get ui3StickerDeletePack => 'パックを削除';

  @override
  String get ui3StickerThisPack => 'このパック';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return '「$name」とそのすべてのステッカーを削除しますか？この操作は元に戻せません。';
  }

  @override
  String get ui3StickerDeleteFailed => '削除できませんでした';

  @override
  String get ui3StickerPack => 'ステッカーパック';

  @override
  String get ui3StickerAdding => '追加中…';

  @override
  String get ui3StickerAddStickers => 'ステッカーを追加';

  @override
  String get ui3StickerPackNotFound => 'パックが見つかりません';

  @override
  String get ui3StickerEmptyHint => '「ステッカーを追加」をタップして画像をアップロード';

  @override
  String get ui3StickerNewPack => '新しいステッカーパック';

  @override
  String get ui3StickerCreate => '作成';

  @override
  String get ui3StickerCreateFailed => 'パックを作成できませんでした';

  @override
  String ui3StickerInstalled(Object name) {
    return '「$name」を追加しました';
  }

  @override
  String get ui3StickerRemovePackTitle => 'ステッカーパックを削除';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return '「$name」をステッカーから削除しますか？';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return '「$name」を削除しました';
  }

  @override
  String get ui3StickerAiSticker => 'AIステッカー';

  @override
  String get ui3StickerStoreTab => 'ストア';

  @override
  String get ui3StickerMyStickersTab => 'マイステッカー';

  @override
  String get ui3StickerNoneFound => 'ステッカーが見つかりません';

  @override
  String ui3StickerByAuthor(Object author) {
    return '作成者: $author';
  }

  @override
  String get ui3StickerManage => '管理';

  @override
  String ui3StickerCount(Object count) {
    return '$count 個のステッカー';
  }

  @override
  String get ui3StickerNoneInstalled => 'ステッカーがインストールされていません';

  @override
  String get ui3StickerGetFromStore => 'ストアでステッカーを入手';

  @override
  String get ui3StickerBrowseStore => 'ストアを見る';

  @override
  String get ui3StickerAddedToAi => '「AIステッカー」に追加しました';

  @override
  String get ui3StickerAddOneFailed => 'ステッカーを追加できませんでした';

  @override
  String get ui3StickerPromptLabel => 'ステッカーの内容を入力';

  @override
  String get ui3StickerPromptHint => '例：サングラスをかけた楽しそうなオレンジ色の猫';

  @override
  String get ui3StickerGenerating => '生成中…';

  @override
  String get ui3StickerGenerate => '生成';

  @override
  String get ui3StickerAddToStickers => 'ステッカーに追加';

  @override
  String get ui3StickerGeneratingPreview => 'ステッカーを生成中…';

  @override
  String get ui3StickerGenerateEmpty => 'ステッカーの内容を入力して「生成」をタップ';
}
