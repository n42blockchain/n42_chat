// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class SJa extends S {
  SJa([String locale = 'ja']) : super(locale);

  @override
  String get chatModuleInitFailed => 'チャットモジュールの初期化に失敗しました';

  @override
  String get checkNetworkRetry => 'ネットワーク接続を確認して再試行してください';

  @override
  String get retry => '再試行';

  @override
  String get unknownUser => '不明なユーザー';

  @override
  String get walletNotConnected => 'ウォレット未接続';

  @override
  String get cannotGetWalletAddress => 'ウォレットアドレスを取得できません';

  @override
  String paymentRequestMemo(String requestId) {
    return '支払いリクエスト: $requestId';
  }

  @override
  String get callServiceNotInitialized => '通話サービスが初期化されていません';

  @override
  String get alreadyInCall => '通話中です';

  @override
  String get meetingServiceNotInitialized => 'ミーティングサービスが初期化されていません';

  @override
  String get livekitNotConfigured => 'LiveKitが設定されていません';

  @override
  String get unknownConversation => '不明な会話';

  @override
  String startCallFailed(String error) {
    return '通話の開始に失敗しました: $error';
  }

  @override
  String answerCallFailed(String error) {
    return '応答に失敗しました: $error';
  }

  @override
  String get connectionFailed => '接続に失敗しました';

  @override
  String get callRejected => '通話が拒否されました';

  @override
  String get noAnswer => '応答なし';

  @override
  String get invalidLoginResponse => '無効なログイン応答';

  @override
  String loginFailed(String error) {
    return 'ログインに失敗しました: $error';
  }

  @override
  String get sessionRestoreFailed => 'セッションの復元に失敗しました';

  @override
  String get additionalVerificationRequired => '追加認証が必要です';

  @override
  String registrationFailed(String error) {
    return '登録に失敗しました: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'サーバーに接続できません: $error';
  }

  @override
  String get wrongUsernamePassword => 'ユーザー名またはパスワードが正しくありません';

  @override
  String get usernameTaken => 'ユーザー名は既に使用されています';

  @override
  String get invalidUsernameFormat => '無効なユーザー名形式';

  @override
  String get rateLimitExceeded => 'リクエストが多すぎます。しばらくしてから再試行してください';

  @override
  String get loginExpired => 'ログインの有効期限が切れました';

  @override
  String joinMeetingFailed(String error) {
    return 'ミーティングへの参加に失敗しました: $error';
  }

  @override
  String screenShareFailed(String error) {
    return '画面共有に失敗しました: $error';
  }

  @override
  String get answer => '応答';

  @override
  String get decline => '拒否';

  @override
  String get missedCall => '不在着信';

  @override
  String get callBack => '折り返し電話';

  @override
  String get incomingCall => '着信';

  @override
  String get missedVideoCall => '不在ビデオ通話';

  @override
  String get missedVoiceCall => '不在音声通話';

  @override
  String get voiceCallTitle => '语音通话';

  @override
  String get videoCallTitle => '视频通话';

  @override
  String get callNotAnswered => '对方未接听';

  @override
  String get callDurationLabel => '通话时长';

  @override
  String get voiceCallCancelled => '语音通话已取消';

  @override
  String get videoCallCancelled => '视频通话已取消';

  @override
  String get passkeyNotInitialized => 'パスキーが初期化されていません';

  @override
  String get googleSignInNotConfigured => 'Googleサインインが設定されていません';

  @override
  String get encryptedMessage => '[暗号化されたメッセージ]';

  @override
  String get sticker => '[スタンプ]';

  @override
  String get groupCreated => 'グループが作成されました';

  @override
  String get groupNameChanged => 'グループ名が変更されました';

  @override
  String get groupAvatarChanged => 'グループアバターが変更されました';

  @override
  String get groupAnnouncementChanged => 'グループお知らせが変更されました';

  @override
  String get image => '[画像]';

  @override
  String get video => '[動画]';

  @override
  String get voice => '[音声]';

  @override
  String get file => '[ファイル]';

  @override
  String get location => '[位置情報]';

  @override
  String get unknownMessage => '[不明なメッセージ]';

  @override
  String joinedGroup(String senderName) {
    return '$senderNameがグループに参加しました';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderNameがグループを退出しました';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderNameが招待されました';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderNameが削除されました';
  }

  @override
  String get avatarDataEmpty => 'アバターデータが空です';

  @override
  String get avatarTooLarge => 'アバターファイルが大きすぎます。最大10MBです';

  @override
  String get uploadAvatarFailed => 'アバターのアップロードに失敗しました';

  @override
  String get delete => '削除';

  @override
  String get deleteThisMessage => '删除这条消息？';

  @override
  String get messageDeleted => '消息已删除';

  @override
  String get notLoggedIn => 'ログインしていません';

  @override
  String roomNotExist(String roomId) {
    return 'ルームが見つかりません: $roomId';
  }

  @override
  String get uploadImageFailed => '画像のアップロードに失敗しました';

  @override
  String get matrixClientNotInitialized => 'Matrixクライアントが初期化されていません';

  @override
  String get uploadVoiceFailed => '音声のアップロードに失敗しました: MXC URIを取得できません';

  @override
  String get uploadVideoFailed => '動画のアップロードに失敗しました: MXC URIを取得できません';

  @override
  String get uploadFileFailed => 'ファイルのアップロードに失敗しました: MXC URIを取得できません';

  @override
  String locationWithCoords(String lat, String lon) {
    return '位置情報: $lat, $lon';
  }

  @override
  String get myLocation => '現在地';

  @override
  String get pollEnded => '投票が終了しました';

  @override
  String get groupChat => 'グループチャット';

  @override
  String get search => '検索';

  @override
  String get cancel => 'キャンセル';

  @override
  String get userCancelled => 'ユーザーがキャンセルしました';

  @override
  String get noData => 'データがありません';

  @override
  String get noSearchResults => '検索結果がありません';

  @override
  String get tryDifferentKeyword => '別のキーワードを試してください';

  @override
  String get loadFailed => '読み込みに失敗しました';

  @override
  String get checkNetwork => 'ネットワーク接続を確認してください';

  @override
  String get networkConnectionFailed => 'ネットワーク接続に失敗しました';

  @override
  String get checkNetworkSettings => 'ネットワーク設定を確認してください';

  @override
  String get messages => 'メッセージ';

  @override
  String get contacts => '連絡先';

  @override
  String get discover => '発見';

  @override
  String get me => '自分';

  @override
  String get voiceLoading => '音声を読み込み中です。しばらくしてから再試行してください';

  @override
  String get voiceToTextFailed => '音声のテキスト変換に失敗しました';

  @override
  String get converting => '変換中...';

  @override
  String get convertToText => 'テキストに変換';

  @override
  String get convertToTextTitle => 'テキストに変換';

  @override
  String get selectEmoji => '絵文字を選択';

  @override
  String get selectRedPacketCover => 'カバーを選択';

  @override
  String get frequentlyUsed => 'よく使う';

  @override
  String get copy => 'コピー';

  @override
  String get forward => '転送';

  @override
  String get unfavorite => 'お気に入り解除';

  @override
  String get favorite => 'お気に入り';

  @override
  String get resend => '再送信';

  @override
  String get recall => '取り消し';

  @override
  String get multiSelect => '複数選択';

  @override
  String get quote => '引用';

  @override
  String get remind => 'リマインド';

  @override
  String get searchThis => '検索';

  @override
  String get recallMessageConfirm => 'このメッセージを取り消しますか？';

  @override
  String get youRecalledMessage => 'メッセージを取り消しました';

  @override
  String get otherRecalledMessage => 'メッセージが取り消されました';

  @override
  String get reEdit => '再編集';

  @override
  String get copied => 'コピーしました';

  @override
  String get sendMessageHint => 'メッセージを送信';

  @override
  String get microphonePermissionRequired => 'マイクの使用を許可してください';

  @override
  String startRecordingFailed(String error) {
    return '録音の開始に失敗しました: $error';
  }

  @override
  String get recordingTooShort => '録音が短すぎます';

  @override
  String stopRecordingFailed(String error) {
    return '録音の停止に失敗しました: $error';
  }

  @override
  String get releaseToCancel => '離すとキャンセル';

  @override
  String get releaseToSend => '離すと送信、上にスワイプでキャンセル';

  @override
  String get holdToTalk => '押し続けて話す';

  @override
  String get send => '送信';

  @override
  String conversationWithId(String roomId) {
    return '会話: $roomId';
  }

  @override
  String contactWithId(String userId) {
    return '連絡先: $userId';
  }

  @override
  String get addFriend => '友達を追加';

  @override
  String get chatServiceNotConnected => 'チャットサービスに接続されていません';

  @override
  String userNotFoundHint(String query) {
    return 'ユーザー「$query」が見つかりません\n\nヒント:\n• 完全なユーザーIDを入力してください（例: @username:server.com）\n• ユーザー名のスペルを確認してください';
  }

  @override
  String createChatFailed(String error) {
    return 'チャットの作成に失敗しました: $error';
  }

  @override
  String searchFailed(String error) {
    return '検索に失敗しました: $error';
  }

  @override
  String get enterUserIdOrUsername => 'ユーザーIDまたはユーザー名を入力して検索';

  @override
  String get searching => '検索中...';

  @override
  String get searchUserToChat => 'ユーザーを検索してチャットを開始';

  @override
  String get matrixIdExample =>
      '完全なMatrix IDを入力できます\n例: @user:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return 'ユーザー「$username」が見つかりません';
  }

  @override
  String get chat => 'チャット';

  @override
  String get settings => '設定';

  @override
  String get editProfile => 'プロフィールを編集';

  @override
  String get login => 'ログイン';

  @override
  String get createGroup => 'グループを作成';

  @override
  String developing(String title) {
    return '$title\n（近日公開）';
  }

  @override
  String get error => 'エラー';

  @override
  String get pageNotFound => 'ページが見つかりません';

  @override
  String get backToHome => 'ホームに戻る';

  @override
  String get allRead => 'すべて既読';

  @override
  String readCount(int count) {
    return '$count人が既読';
  }

  @override
  String get transfer => '送金';

  @override
  String get pendingReceipt => '保留中';

  @override
  String get tapToReceive => 'タップして受け取る';

  @override
  String get received => '受け取り済み';

  @override
  String get paymentReceived => '支払いを受け取りました';

  @override
  String get refunded => '返金済み';

  @override
  String get expired => '期限切れ';

  @override
  String get redPacketGreeting => 'お祝いメッセージ';

  @override
  String get n42RedPacket => 'N42レッドパケット';

  @override
  String get goodLuck => '幸運を祈って';

  @override
  String get claimed => '受け取り済み';

  @override
  String get allClaimed => 'すべて受け取り済み';

  @override
  String get emoji => '絵文字';

  @override
  String get love => '愛';

  @override
  String get animals => '動物';

  @override
  String get food => '食べ物';

  @override
  String get travel => '旅行';

  @override
  String get activities => 'アクティビティ';

  @override
  String get objects => '物';

  @override
  String get symbols => '記号';

  @override
  String get reply => '返信';

  @override
  String get copiedToClipboard => 'クリップボードにコピーしました';

  @override
  String get edit => '編集';

  @override
  String get more => 'もっと見る';

  @override
  String get selectForwardTarget => '転送先を選択';

  @override
  String sendCount(int count) {
    return '送信 ($count)';
  }

  @override
  String get draft => '[下書き] ';

  @override
  String n42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get n42IdTitle => 'N42 ID';

  @override
  String get n42Bean => 'N42ビーン';

  @override
  String get friendInfo => '友達情報';

  @override
  String get friendInfoDesc => '友達のメモ、電話番号、タグ、ノート、写真を追加し、権限を設定します。';

  @override
  String get moments => 'モーメント';

  @override
  String get sendMessage => 'メッセージ';

  @override
  String get audioVideoCall => '音声/ビデオ通話';

  @override
  String get videoChannel => 'ビデオチャンネル';

  @override
  String get remark => 'メモ';

  @override
  String get remarkName => '表示名';

  @override
  String get phone => '電話番号';

  @override
  String get tags => 'タグ';

  @override
  String get notes => 'ノート';

  @override
  String get photos => '写真';

  @override
  String get permissions => '権限';

  @override
  String get chatMomentsEtc => 'チャット、モーメント、スポーツなど';

  @override
  String get moreInfo => '詳細情報';

  @override
  String get commonGroups => '共通のグループ';

  @override
  String get zeroGroups => '0';

  @override
  String get source => '追加元';

  @override
  String get notificationSettings => '通知';

  @override
  String get receiveNotifications => '新着メッセージ通知を受け取る';

  @override
  String get showPreview => 'メッセージプレビューを表示';

  @override
  String get showContentInNotification => '通知にメッセージ内容を表示';

  @override
  String get notificationSound => '通知音';

  @override
  String get playSoundOnMessage => 'メッセージ受信時に音を鳴らす';

  @override
  String get vibrate => 'バイブレーション';

  @override
  String get vibrateOnMessage => 'メッセージ受信時にバイブレーション';

  @override
  String get doNotDisturb => 'おやすみモード';

  @override
  String get dndDescription => '指定した時間帯は通知をミュート';

  @override
  String get startTime => '開始時間';

  @override
  String get endTime => '終了時間';

  @override
  String get privacy => 'プライバシー';

  @override
  String get appearance => '外観';

  @override
  String get about => 'このアプリについて';

  @override
  String get logout => 'ログアウト';

  @override
  String get logoutConfirm => 'ログアウトしてもよろしいですか？';

  @override
  String get exit => 'ログアウト';

  @override
  String get save => '保存';

  @override
  String get nickname => 'ニックネーム';

  @override
  String get enterNickname => 'ニックネームを入力';

  @override
  String get signature => '署名';

  @override
  String get addSignature => '署名を追加';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get chooseFromGallery => 'ギャラリーから選択';

  @override
  String saveFailed(String error) {
    return '保存に失敗しました: $error';
  }

  @override
  String get secureDecentralizedChat => '安全で分散型のメッセージング';

  @override
  String get endToEndEncryption => 'エンドツーエンド暗号化';

  @override
  String get messagesOnlyYouCanSee => 'あなたと受信者のみがメッセージを閲覧可能';

  @override
  String get decentralized => '分散型';

  @override
  String get basedOnMatrix => 'Matrixオープンプロトコルを基盤';

  @override
  String get walletIntegration => 'ウォレット連携';

  @override
  String get easyCryptoTransfer => '簡単な暗号通貨送金';

  @override
  String get register => '新規登録';

  @override
  String get agreeTerms => 'ログインすることで、以下に同意したものとみなします';

  @override
  String get termsOfService => '利用規約';

  @override
  String get and => 'および';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get serverAddress => 'サーバーアドレス';

  @override
  String get enterServerAddress => 'サーバーアドレスを入力';

  @override
  String get validServerAddress => '有効なサーバーアドレスを入力してください';

  @override
  String connectedTo(String serverName) {
    return '$serverNameに接続済み';
  }

  @override
  String get username => 'ユーザー名';

  @override
  String get enterUsername => 'ユーザー名を入力';

  @override
  String get password => 'パスワード';

  @override
  String get enterPassword => 'パスワードを入力';

  @override
  String get registerAccount => '新規登録';

  @override
  String get forgotPassword => 'パスワードを忘れた';

  @override
  String get otherLoginMethods => 'その他のログイン方法';

  @override
  String get emailVerification => 'メール認証コード';

  @override
  String get enterServerFirst => '先にサーバーアドレスを入力してください';

  @override
  String get passkeyNeedsServer => 'パスキーログインにはサーバーのサポートが必要です';

  @override
  String googleLoginSuccess(String email) {
    return 'Googleログイン成功: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Googleログインに失敗しました: $error';
  }

  @override
  String get appleLoginSuccess => 'Appleログイン成功';

  @override
  String appleLoginFailed(String error) {
    return 'Appleログインに失敗しました: $error';
  }

  @override
  String get createAccount => 'アカウントを作成';

  @override
  String get joinN42Chat => 'N42 Chatに参加してチャットを始めましょう';

  @override
  String get usernameHint => '3〜20文字、英数字と_のみ';

  @override
  String get usernameMinLength => 'ユーザー名は3文字以上必要です';

  @override
  String get usernameMaxLength => 'ユーザー名は20文字以下にしてください';

  @override
  String get usernameFormat => 'ユーザー名は英字、数字、アンダースコアのみ使用可能です';

  @override
  String get passwordHint => '8文字以上';

  @override
  String get passwordMinLength => 'パスワードは8文字以上必要です';

  @override
  String get confirmPassword => 'パスワードを確認';

  @override
  String get reEnterPassword => 'パスワードを再入力';

  @override
  String get passwordsNotMatch => 'パスワードが一致しません';

  @override
  String get inviteCode => '招待コード（内蔵）';

  @override
  String get filled => '入力済み';

  @override
  String get enterInviteCode => '招待コードを入力';

  @override
  String get inviteCodeHint => '招待コードは内蔵されており、通常は変更不要です';

  @override
  String get agreeTermsFirst => 'まず利用規約とプライバシーポリシーを読んで同意してください';

  @override
  String get iAgree => '読んで同意します';

  @override
  String get alreadyHaveAccount => '既にアカウントをお持ちですか？';

  @override
  String get loginNow => '今すぐログイン';

  @override
  String get whoCanSee => '閲覧可能な人';

  @override
  String get avatar => 'アバター';

  @override
  String get status => 'ステータス';

  @override
  String get lastSeen => '最終オンライン';

  @override
  String get messageSettings => 'メッセージ';

  @override
  String get allowStrangerMessage => '知らない人からのメッセージを許可';

  @override
  String get receiveNonContact => '連絡先以外からのメッセージを受信';

  @override
  String get readReceipts => '既読通知';

  @override
  String get letOthersKnowRead => 'メッセージを読んだことを相手に知らせる';

  @override
  String get typingStatus => '入力中ステータス';

  @override
  String get letOthersKnowTyping => '入力中であることを相手に知らせる';

  @override
  String get everyone => '全員';

  @override
  String get contactsOnly => '連絡先のみ';

  @override
  String get nobody => '誰にも表示しない';

  @override
  String whoCanSeeItem(String title) {
    return '$titleを閲覧できる人';
  }

  @override
  String version(String version) {
    return 'バージョン $version';
  }

  @override
  String get checkUpdate => 'アップデートを確認';

  @override
  String get openSourceLicenses => 'オープンソースライセンス';

  @override
  String get feedback => 'フィードバック';

  @override
  String get builtOnMatrix => 'Matrixプロトコルを基盤';

  @override
  String get loading => '読み込み中...';

  @override
  String get noConversations => '会話がありません';

  @override
  String get tapToChat => '右上をタップしてチャットを開始';

  @override
  String get startGroup => 'グループチャットを開始';

  @override
  String get scan => 'スキャン';

  @override
  String get payment => '支払い';

  @override
  String featureComingSoon(String feature) {
    return '$featureは近日公開';
  }

  @override
  String get markAsRead => '既読にする';

  @override
  String get unmute => 'ミュート解除';

  @override
  String get mute => 'ミュート';

  @override
  String get unpin => 'ピン解除';

  @override
  String get pin => 'ピン留め';

  @override
  String get deleteConversation => '会話を削除';

  @override
  String deleteConversationConfirm(String name) {
    return '「$name」との会話を削除しますか？';
  }

  @override
  String get noContacts => '連絡先がありません';

  @override
  String get addFriendsToChat => '友達を追加してチャットを始めましょう';

  @override
  String get contactNotFound => '連絡先が見つかりません';

  @override
  String get tryOtherKeywords => '他のキーワードまたはグローバル検索を試してください';

  @override
  String get searchResults => '検索結果';

  @override
  String get newFriends => '新しい友達';

  @override
  String get chatOnlyFriends => 'チャットのみの友達';

  @override
  String get officialAccounts => '公式アカウント';

  @override
  String get serviceAccounts => 'サービスアカウント';

  @override
  String get enterpriseContacts => '企業連絡先';

  @override
  String contactsCount(int count) {
    return '$count件の連絡先';
  }

  @override
  String get recommendToFriend => '連絡先を共有';

  @override
  String get setRemark => 'メモを設定';

  @override
  String get addToHome => 'ホーム画面に追加';

  @override
  String get sendingCard => '連絡先カードを送信中...';

  @override
  String get contactCard => '[連絡先カード]';

  @override
  String get fileLabel => 'ファイル';

  @override
  String get locationLabel => '位置情報';

  @override
  String cardSent(String contact, String friend) {
    return '$contactのカードを$friendに送信しました';
  }

  @override
  String recommendFailed(String error) {
    return 'おすすめに失敗しました: $error';
  }

  @override
  String get enterRemark => 'メモを入力';

  @override
  String remarkSet(String remark) {
    return 'メモを設定しました: $remark';
  }

  @override
  String get openingChat => 'チャットを開いています...';

  @override
  String openChatFailed(String error) {
    return 'チャットを開けませんでした: $error';
  }

  @override
  String get addContact => '連絡先を追加';

  @override
  String get enterUserId => 'ユーザーIDを入力';

  @override
  String get noFriendRequests => '友達リクエストがありません';

  @override
  String get accept => '承認';

  @override
  String get reject => '拒否';

  @override
  String acceptedRequest(String name) {
    return '$nameの友達リクエストを承認しました';
  }

  @override
  String rejectedRequest(String name) {
    return '$nameの友達リクエストを拒否しました';
  }

  @override
  String get noGroups => 'グループがありません';

  @override
  String get creatingGroup => 'グループ作成機能は近日公開...';

  @override
  String get selectFriendToRecommend => 'おすすめする友達を選択';

  @override
  String get searchContacts => '連絡先を検索';

  @override
  String get noContactsFound => '連絡先が見つかりません';

  @override
  String get yesterday => '昨日';

  @override
  String get monday => '月';

  @override
  String get tuesday => '火';

  @override
  String get wednesday => '水';

  @override
  String get thursday => '木';

  @override
  String get friday => '金';

  @override
  String get saturday => '土';

  @override
  String get sunday => '日';

  @override
  String get justNow => 'たった今';

  @override
  String minutesAgo(int count) {
    return '$count分前';
  }

  @override
  String hoursAgo(int count) {
    return '$count時間前';
  }

  @override
  String daysAgo(int count) {
    return '$count日前';
  }

  @override
  String get online => 'オンライン';

  @override
  String get offline => 'オフライン';

  @override
  String minutesAgoOnline(int count) {
    return '$count分前にオンライン';
  }

  @override
  String hoursAgoOnline(int count) {
    return '$count時間前にオンライン';
  }

  @override
  String daysAgoOnline(int count) {
    return '$count日前にオンライン';
  }

  @override
  String get searchContactsGroupsMessages => '連絡先、グループ、メッセージを検索';

  @override
  String get searchError => '検索エラー';

  @override
  String get searchHint => '連絡先、グループ、メッセージを検索';

  @override
  String get enterKeyword => 'キーワードを入力して検索';

  @override
  String get searchHistory => '検索履歴';

  @override
  String get clear => 'クリア';

  @override
  String noResultsFor(String query) {
    return '「$query」の検索結果がありません';
  }

  @override
  String get all => 'すべて';

  @override
  String get groups => 'グループ';

  @override
  String get noResults => '結果がありません';

  @override
  String get groupInfo => 'グループ情報';

  @override
  String groupMembers(int count) {
    return 'メンバー ($count)';
  }

  @override
  String get groupMembersTitle => 'グループメンバー';

  @override
  String get viewAll => 'すべて表示';

  @override
  String get owner => 'オーナー';

  @override
  String get admin => '管理者';

  @override
  String get invite => '招待';

  @override
  String get groupAnnouncement => 'グループお知らせ';

  @override
  String get notSet => '未設定';

  @override
  String get groupDescription => 'グループの説明';

  @override
  String get publicGroup => '公開グループ';

  @override
  String get allowSearchJoin => '検索と参加を許可';

  @override
  String get clearChatHistory => 'チャット履歴を削除';

  @override
  String get dissolveGroup => 'グループを解散';

  @override
  String get leaveGroup => 'グループを退出';

  @override
  String get changeGroupName => 'グループ名を変更';

  @override
  String get enterGroupName => 'グループ名を入力';

  @override
  String get confirm => '確認';

  @override
  String get changeGroupDescription => 'グループの説明を変更';

  @override
  String get enterGroupDescription => 'グループの説明を入力';

  @override
  String get editAnnouncement => 'お知らせを編集';

  @override
  String get enterAnnouncement => 'お知らせを入力';

  @override
  String get publish => '公開';

  @override
  String get clearHistoryConfirm => 'すべてのチャット履歴を削除しますか？この操作は取り消せません。';

  @override
  String get clearAction => '削除';

  @override
  String get chatHistoryCleared => 'チャット履歴が削除されました';

  @override
  String leaveGroupConfirm(String name) {
    return '「$name」を退出しますか？';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return '「$name」を解散しますか？この操作は取り消せません。';
  }

  @override
  String get dissolve => '解散';

  @override
  String get groupQrCode => 'グループQRコード';

  @override
  String get searchChatHistory => 'チャット履歴を検索';

  @override
  String get groupIdCopied => 'グループIDをコピーしました';

  @override
  String tapCopyGroupId(int count) {
    return '$count人のメンバー · タップしてグループIDをコピー';
  }

  @override
  String get receiverAddress => '送金先アドレス';

  @override
  String get enterOrPasteAddress => 'ウォレットアドレスを入力または貼り付け';

  @override
  String get selectToken => 'トークンを選択';

  @override
  String get transferAmount => '送金額';

  @override
  String get available => '利用可能';

  @override
  String get allAmount => '全額';

  @override
  String get memoOptional => 'メモ（任意）';

  @override
  String get addMemo => 'メモを追加';

  @override
  String get confirmTransfer => '送金を確認';

  @override
  String get invalidAddress => '有効な送金先アドレスを入力してください';

  @override
  String get invalidAmount => '有効な金額を入力してください';

  @override
  String get selectTokenPlease => 'トークンを選択してください';

  @override
  String get addressVerified => 'アドレス確認済み';

  @override
  String availableBalance(String balance, String symbol) {
    return '残高: $balance $symbol';
  }

  @override
  String get scanningInDevelopment => 'スキャン機能は開発中...';

  @override
  String get enterAmount => '金額を入力';

  @override
  String get redPacketCountMin => '最低1つのレッドパケットが必要です';

  @override
  String get viewRedPacketDetails => 'レッドパケットの詳細を表示';

  @override
  String get enterTransferAmount => '送金額を入力';

  @override
  String get transferTo => '送金先';

  @override
  String get selectCurrency => '通貨を選択';

  @override
  String get receiveTransfer => '送金を受け取りました';

  @override
  String fromSender(String name, Object senderName) {
    return '$senderNameから';
  }

  @override
  String get confirmReceive => '受け取りを確認';

  @override
  String get groupProfile => 'グループ情報';

  @override
  String get viewProfile => 'プロフィールを表示';

  @override
  String get removeMember => 'グループから削除';

  @override
  String removeMemberConfirm(String name) {
    return '「$name」をグループから削除しますか？';
  }

  @override
  String get remove => '削除';

  @override
  String get clearStatus => 'ステータスをクリア';

  @override
  String get clearStatusConfirm => '現在のステータスをクリアしますか？';

  @override
  String get statusCleared => 'ステータスをクリアしました';

  @override
  String statusSet(String result) {
    return 'ステータスを設定しました: $result';
  }

  @override
  String get userNotExist => 'ユーザーが存在しません';

  @override
  String get userIdCopied => 'ユーザーIDをコピーしました';

  @override
  String get voiceCallInDevelopment => '音声通話は開発中...';

  @override
  String get report => '報告';

  @override
  String get reportInDevelopment => '報告機能は開発中...';

  @override
  String get shareCard => 'カードを共有';

  @override
  String get shareInDevelopment => '共有機能は開発中...';

  @override
  String get qrCode => 'QRコード';

  @override
  String get qrCodeInDevelopment => 'QRコード機能は開発中...';

  @override
  String get avatarUpdated => 'アバターを更新しました';

  @override
  String selectImageFailed(String error) {
    return '画像の選択に失敗しました: $error';
  }

  @override
  String get changeName => '名前を変更';

  @override
  String get male => '男性';

  @override
  String get female => '女性';

  @override
  String genderSet(String gender) {
    return '性別を設定しました: $gender';
  }

  @override
  String regionSet(String region) {
    return '地域を設定しました: $region';
  }

  @override
  String get setPatText => 'なでなでテキストを設定';

  @override
  String get changeSignature => '署名を変更';

  @override
  String ringtoneSet(String result) {
    return '着信音を設定しました: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$featureは開発中...';
  }

  @override
  String saveAddressFailed(String error) {
    return '住所の保存に失敗しました: $error';
  }

  @override
  String get myAddress => 'マイアドレス';

  @override
  String get addNew => '追加';

  @override
  String get addAddress => '住所を追加';

  @override
  String get addressAdded => '住所を追加しました';

  @override
  String get addressUpdated => '住所を更新しました';

  @override
  String get deleteAddress => '住所を削除';

  @override
  String get deleteAddressConfirm => 'この住所を削除しますか？';

  @override
  String get addressDeleted => '住所を削除しました';

  @override
  String get setDefaultAddress => 'デフォルトに設定';

  @override
  String get fillCompleteInfo => 'すべての項目を入力してください';

  @override
  String saveInvoiceFailed(String error) {
    return '請求書の保存に失敗しました: $error';
  }

  @override
  String get myInvoices => 'マイ請求書';

  @override
  String get addInvoice => '請求書を追加';

  @override
  String get invoiceAdded => '請求書を追加しました';

  @override
  String get invoiceUpdated => '請求書を更新しました';

  @override
  String get deleteInvoice => '請求書を削除';

  @override
  String get deleteInvoiceConfirm => 'この請求書を削除しますか？';

  @override
  String get invoiceDeleted => '請求書を削除しました';

  @override
  String get invoiceType => '請求書の種類: ';

  @override
  String get personal => '個人';

  @override
  String get enterprise => '法人';

  @override
  String get setDefaultInvoice => 'デフォルトに設定';

  @override
  String get enterTaxId => '税務番号を入力';

  @override
  String get vibrateMode => 'バイブレーションモード';

  @override
  String get silentMode => 'サイレントモード';

  @override
  String playing(String ringtoneName) {
    return '再生中: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return '再生に失敗しました: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'グループ名を入力してください';

  @override
  String get selectAtLeastOne => '少なくとも1人のメンバーを選択してください';

  @override
  String get fillStatus => 'ステータスを入力';

  @override
  String get fileNotExist => 'ファイルが存在しません';

  @override
  String sendFailed(String error) {
    return '送信に失敗しました: $error';
  }

  @override
  String get cannotOpenBrowser => 'ブラウザを開けません';

  @override
  String selectFileFailed(String error) {
    return 'ファイルの選択に失敗しました: $error';
  }

  @override
  String get enterMusicLink => '音楽リンクを入力';

  @override
  String get enterValidLink => '有効なリンクを入力してください';

  @override
  String get enterPollQuestion => '投票の質問を入力';

  @override
  String get minTwoOptions => '最低2つの選択肢が必要です';

  @override
  String get crossDeviceEnabled => 'クロスデバイス署名が有効になりました';

  @override
  String get crossDeviceSet => 'クロスデバイス署名の設定が完了しました';

  @override
  String setupFailed(String error) {
    return '設定に失敗しました: $error';
  }

  @override
  String get receiveAmount => '受取金額';

  @override
  String get enterValidAmount => '有効な金額を入力してください';

  @override
  String get addressCopied => 'アドレスをコピーしました';

  @override
  String openItem(String content) {
    return '開く: $content';
  }

  @override
  String get newNoteComingSoon => '新規メモ機能は近日公開';

  @override
  String get addLinkComingSoon => 'リンク追加機能は近日公開';

  @override
  String get deleted => '削除しました';

  @override
  String get shareComingSoon => '共有機能は近日公開';

  @override
  String get saveComingSoon => '保存機能は近日公開';

  @override
  String get moreStylesComingSoon => 'その他のスタイルは近日公開';

  @override
  String get wallet => 'ウォレット';

  @override
  String get walletArea => 'ウォレットエリア';

  @override
  String get recording => '録音中';

  @override
  String get invalidVideoUrl => '無効な動画URL';

  @override
  String get downloadFile => 'ファイルをダウンロード';

  @override
  String get clearChatHistoryTitle => 'チャット履歴を削除';

  @override
  String get cannotUndo => 'この操作は取り消せません';

  @override
  String get videoCall => 'ビデオ通話';

  @override
  String get voiceCall => '音声通話';

  @override
  String get leaveMeeting => 'ミーティングを退出';

  @override
  String get chatDetails => 'チャットの詳細';

  @override
  String get viewAllGroupMembers => 'すべてのメンバーを表示';

  @override
  String get groupName => 'グループ名';

  @override
  String get groupNameUpdated => 'グループ名を更新しました';

  @override
  String get groupDescriptionUpdated => 'グループの説明を更新しました';

  @override
  String get groupAvatarUpdated => 'グループのアバターを更新しました';

  @override
  String get updateFailed => '更新に失敗しました';

  @override
  String get noPermissionToModify => '変更する権限がありません';

  @override
  String get groupManagement => 'グループ管理';

  @override
  String get myNicknameInGroup => 'グループ内のニックネーム';

  @override
  String get pinChat => 'チャットをピン留め';

  @override
  String get strongReminder => '強調リマインダー';

  @override
  String get setChatBackground => 'チャット背景を設定';

  @override
  String get unknownFile => '不明なファイル';

  @override
  String get download => 'ダウンロード';

  @override
  String get invalidLocation => '無効な位置情報';

  @override
  String get address => '住所';

  @override
  String get latitude => '緯度';

  @override
  String get longitude => '経度';

  @override
  String get close => '閉じる';

  @override
  String get tapToCancel => 'タップしてキャンセル';

  @override
  String captureFailed(Object error) {
    return 'キャプチャに失敗しました: $error';
  }

  @override
  String get processingVideo => '動画を処理中...';

  @override
  String get videoFileNotExist => '動画ファイルが存在しません';

  @override
  String get videoDataEmpty => '動画データが空です';

  @override
  String get videoTooLarge => '動画サイズは100MBを超えられません';

  @override
  String get sendingVideo => '動画を送信中...';

  @override
  String sendVideoFailed(Object error) {
    return '動画の送信に失敗しました: $error';
  }

  @override
  String get imageFileNotExist => '画像ファイルが存在しません';

  @override
  String get imageDataEmpty => '画像データが空です';

  @override
  String get sendingImage => '画像を送信中...';

  @override
  String sendImageFailed(Object error) {
    return '画像の送信に失敗しました: $error';
  }

  @override
  String get sendLocation => '位置情報を送信';

  @override
  String get selectLocationAndSend => '位置を選択して送信';

  @override
  String get shareRealTimeLocation => 'リアルタイム位置情報を共有';

  @override
  String get shareLocationForOneHour => '友達とリアルタイム位置情報を1時間共有';

  @override
  String get locationSent => '位置情報を送信しました';

  @override
  String get selectMessages => 'メッセージを選択';

  @override
  String selectedCount(int count) {
    return '$count件選択';
  }

  @override
  String get selectAll => 'すべて選択';

  @override
  String groupChatCount(int count) {
    return 'グループチャット ($count)';
  }

  @override
  String get privateChat => 'プライベートチャット';

  @override
  String get noMessages => 'メッセージがありません';

  @override
  String get sendFirstMessage => '最初のメッセージを送信してチャットを開始';

  @override
  String get encryptionNotice =>
      'このチャットはエンドツーエンド暗号化されています。あなたと受信者のみがメッセージを読むことができます。';

  @override
  String replyTo(String name) {
    return '$nameへの返信';
  }

  @override
  String get multiForward => '転送';

  @override
  String get collect => 'コレクション';

  @override
  String get noMembers => 'メンバーがいません';

  @override
  String get memberNotFound => 'メンバーが見つかりません';

  @override
  String get voiceFileNotExist => '音声ファイルが存在しません';

  @override
  String get voiceFileEmpty => '音声ファイルが空です';

  @override
  String get sendingVoice => '音声を送信中...';

  @override
  String sendVoiceFailed(Object error) {
    return '音声の送信に失敗しました: $error';
  }

  @override
  String get messageCopied => 'メッセージをコピーしました';

  @override
  String get messageForwarded => 'メッセージを転送しました';

  @override
  String forwardFailed(Object error) {
    return '転送に失敗しました: $error';
  }

  @override
  String get unfavorited => 'お気に入りから削除しました';

  @override
  String get favorited => 'お気に入りに追加しました';

  @override
  String get reactionAdded => 'リアクションを追加しました';

  @override
  String get reactionRemoved => 'リアクションを削除しました';

  @override
  String get failedMessageDeleted => '失敗したメッセージを削除しました';

  @override
  String get deleteMessages => 'メッセージを削除';

  @override
  String deleteMessagesConfirm(Object count) {
    return '$count件のメッセージを削除してもよろしいですか？';
  }

  @override
  String noteOtherMessages(Object count) {
    return '注意: $count件のメッセージは他のユーザーからのもので、あなたにのみ削除されます。';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return 'あなたの$count件のメッセージは全員に対して取り消されます。';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return '$count件取り消し、$localCount件はあなたにのみ削除';
  }

  @override
  String recalledMessages(Object count) {
    return '$count件のメッセージを取り消しました';
  }

  @override
  String deletedLocally(Object count) {
    return '$count件のメッセージはあなたにのみ削除されました';
  }

  @override
  String forwardedCount(Object count) {
    return '$count件のメッセージを転送しました';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return '転送完了: $success件成功、$failed件失敗';
  }

  @override
  String get remindOnlyInGroup => 'リマインド機能はグループチャットでのみ利用可能です';

  @override
  String get onlyTextSearchable => 'テキストメッセージのみ検索可能です';

  @override
  String searchFor(Object text) {
    return '「$text」を検索';
  }

  @override
  String get baiduSearch => 'Baidu検索';

  @override
  String get googleSearch => 'Google検索';

  @override
  String get bingSearch => 'Bing検索';

  @override
  String get calling => '発信中...';

  @override
  String get connecting => '接続中...';

  @override
  String get ringing => '呼び出し中...';

  @override
  String get inCall => '通話中';

  @override
  String featureInDevelopment(String feature) {
    return '機能開発中...';
  }

  @override
  String collectMessages(Object count) {
    return '$count件のメッセージをコレクションに追加しました';
  }

  @override
  String get voted => '投票しました';

  @override
  String get voteChanged => '投票を変更しました';

  @override
  String get voteRemoved => '投票を取り消しました';

  @override
  String get endPoll => '投票を終了';

  @override
  String get endPollConfirm => 'この投票を終了してもよろしいですか？終了後は投票できなくなります。';

  @override
  String memberCount(int count) {
    return '$count人のメンバー';
  }

  @override
  String get videoChannels => 'チャンネル';

  @override
  String get live => 'ライブ';

  @override
  String get listen => '聴く';

  @override
  String get watch => '見る';

  @override
  String get searchDiscover => '検索';

  @override
  String get nearbyPeople => '近くの人';

  @override
  String get games => 'ゲーム';

  @override
  String get miniPrograms => 'ミニプログラム';

  @override
  String done(int count) {
    return '完了($count)';
  }

  @override
  String get services => 'サービス';

  @override
  String get favorites => 'お気に入り';

  @override
  String get ordersAndCards => '注文 & カード';

  @override
  String get stickers => 'スタンプ';

  @override
  String statusSetTo(String status) {
    return 'ステータスを設定しました: $status';
  }

  @override
  String get avatarUploadFailed => 'アバターのアップロードに失敗しました';

  @override
  String get personalProfile => '個人プロフィール';

  @override
  String get name => '名前';

  @override
  String get gender => '性別';

  @override
  String get region => '地域';

  @override
  String get myQrCode => 'マイQRコード';

  @override
  String get poke => 'つつく';

  @override
  String get ringtone => '着信音';

  @override
  String get defaultRingtone => 'デフォルト着信音';

  @override
  String get myAddresses => 'マイアドレス';

  @override
  String genderSetTo(String gender) {
    return '性別を設定しました: $gender';
  }

  @override
  String get selectRegion => '地域を選択';

  @override
  String get selectCity => '都市を選択';

  @override
  String regionSetTo(String region) {
    return '地域を設定しました: $region';
  }

  @override
  String get setPoke => 'つつくを設定';

  @override
  String get friendPokedMe => '友達がつついてきました';

  @override
  String get enterPokeSuffix => 'つつくの補足を入力（例: 肩を）';

  @override
  String get example => '例';

  @override
  String get onTheShoulder => ' 肩を';

  @override
  String get pokeCleared => 'つつくをクリアしました';

  @override
  String pokeSetTo(String suffix) {
    return 'つつくを設定しました: つついた$suffix';
  }

  @override
  String get editSignature => '署名を編集';

  @override
  String get introduceYourself => '自己紹介を一言で';

  @override
  String get signatureCleared => '署名をクリアしました';

  @override
  String get signatureUpdated => '署名を更新しました';

  @override
  String get scanToAddFriend => '上のQRコードをスキャンして友達に追加';

  @override
  String ringtoneSetTo(String ringtone) {
    return '着信音を設定しました: $ringtone';
  }

  @override
  String confirmDissolveGroup(String name) {
    return '「$name」を解散してもよろしいですか？この操作は元に戻せません。';
  }

  @override
  String get enterValidServerAddress => '有効なサーバーアドレスを入力してください';

  @override
  String get emailOtp => 'メールOTP';

  @override
  String get enterServerAddressFirst => '先にサーバーアドレスを入力してください';

  @override
  String get passkeyRequiresServer => 'パスキーログインにはサーバーのサポートが必要です';

  @override
  String get loginAgreement => 'ログインすることで、以下に同意したものとみなします ';

  @override
  String get pleaseAgreeToTerms => '利用規約とプライバシーポリシーを読んで同意してください';

  @override
  String get registerFailed => '登録に失敗しました';

  @override
  String get reenterPassword => 'パスワードを再入力';

  @override
  String get passwordsDoNotMatch => 'パスワードが一致しません';

  @override
  String get inviteCodeBuiltIn => '招待コード（内蔵）';

  @override
  String get inviteCodeBuiltInNote => '招待コードは内蔵されており、通常は変更不要です';

  @override
  String get iHaveReadAndAgree => '読んで同意します ';

  @override
  String get startGroupChat => 'グループチャットを開始';

  @override
  String get addFriends => '友達を追加';

  @override
  String get paymentAndCollection => '支払い';

  @override
  String messagesWithCount(int count) {
    return 'メッセージ($count)';
  }

  @override
  String contactCount(int count) {
    return '$count件の連絡先';
  }

  @override
  String get addToHomeScreen => 'ホーム画面に追加';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return '$contactのカードを$recipientにおすすめしました';
  }

  @override
  String get enterRemarkName => '表示名を入力';

  @override
  String remarkSetTo(String remark) {
    return 'メモを設定しました: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return '$nameの友達リクエストを承認しました';
  }

  @override
  String rejectedFriendRequest(String name) {
    return '$nameの友達リクエストを拒否しました';
  }

  @override
  String get groupInvites => 'グループ招待';

  @override
  String myGroups(int count) {
    return 'マイグループ ($count)';
  }

  @override
  String get invitedToJoinGroup => 'グループへの招待';

  @override
  String confirmLeaveGroup(String name) {
    return '「$name」を退出してもよろしいですか？';
  }

  @override
  String get leave => '退出';

  @override
  String get saveMedia => '保存';

  @override
  String get recallThisMessage => 'このメッセージを取り消しますか？';

  @override
  String get messageRecalled => 'メッセージが取り消されました';

  @override
  String get savedToGallery => 'ギャラリーに保存しました';

  @override
  String get failedToSave => '保存に失敗しました';

  @override
  String get saving => '保存中...';

  @override
  String get share => '共有';

  @override
  String get saveToGallery => 'ギャラリーに保存';

  @override
  String downloadFailed(String code) {
    return 'ダウンロード失敗: $code';
  }

  @override
  String get noMediaUrl => 'メディアURLがありません';

  @override
  String shareFailed(String error) {
    return '共有に失敗しました: $error';
  }

  @override
  String get failedToLoadImage => '画像の読み込みに失敗しました';

  @override
  String get failedToLoadMoreMessages => '追加メッセージの読み込みに失敗しました';

  @override
  String get failedToSend => '送信に失敗しました';

  @override
  String get failedToSendImage => '画像の送信に失敗しました';

  @override
  String get failedToSendVoice => '音声の送信に失敗しました';

  @override
  String get failedToSendFile => 'ファイルの送信に失敗しました';

  @override
  String get failedToSendVideo => '動画の送信に失敗しました';

  @override
  String get failedToSendLocation => '位置情報の送信に失敗しました';

  @override
  String get failedToResend => '再送信に失敗しました';

  @override
  String get failedToRecall => '取り消しに失敗しました';

  @override
  String get failedToReply => '返信に失敗しました';

  @override
  String get failedToAddReaction => 'リアクションの追加に失敗しました';

  @override
  String get failedToSendPoll => '投票の送信に失敗しました';

  @override
  String get failedToVote => '投票に失敗しました';

  @override
  String get failedToLoadMessages => 'メッセージの読み込みに失敗しました';

  @override
  String get callFeatureComingSoon => '音声通話とビデオ通話機能は近日公開';

  @override
  String get cannotForwardRedPacketOrTransfer => 'レッドパケットと送金は転送できません';

  @override
  String get videoRecordingFailed => '動画録画に失敗しました。再試行してください。';

  @override
  String get redPacket => 'レッドパケット';

  @override
  String get music => '音楽';

  @override
  String get coupon => 'クーポン';

  @override
  String get gift => 'ギフト';

  @override
  String get poll => '投票';

  @override
  String get text => 'テキスト';

  @override
  String get link => 'リンク';

  @override
  String get note => 'メモ';

  @override
  String get myNotes => 'マイメモ';

  @override
  String get today => '今日';

  @override
  String daysAgoText(int count) {
    return '$count日前';
  }

  @override
  String dateFormat(int month, int day) {
    return '$month/$day';
  }

  @override
  String get noFavorites => 'お気に入りがありません';

  @override
  String get longPressToFavorite => 'メッセージを長押ししてお気に入りに追加';

  @override
  String get newNote => '新規メモ';

  @override
  String get favoriteLink => 'リンクをお気に入り';

  @override
  String get editTags => 'タグを編集';

  @override
  String get deleteFavorite => 'お気に入りを削除';

  @override
  String get deleteFavoriteConfirm => 'このお気に入りを削除してもよろしいですか？';

  @override
  String get noSearchResultsFound => '結果が見つかりませんでした';

  @override
  String get sendRedPacket => 'レッドパケットを送る';

  @override
  String get amount => '金額';

  @override
  String get redPacketCover => 'レッドパケットカバー';

  @override
  String get redPacketType => 'レッドパケットの種類';

  @override
  String get normalRedPacket => '通常';

  @override
  String get luckyRedPacket => 'ラッキー';

  @override
  String get redPacketCount => 'レッドパケットの数';

  @override
  String get pieces => '個';

  @override
  String get putMoneyInRedPacket => 'レッドパケットにお金を入れる';

  @override
  String get redPacketRefundNotice => '24時間以内に受け取られなかったレッドパケットは返金されます';

  @override
  String get openRedPacket => '開く';

  @override
  String get redPacketAllClaimed => 'レッドパケットはすべて受け取られました';

  @override
  String get redPacketExpired => 'レッドパケットの期限が切れました';

  @override
  String get addTransferNote => '送金メモを追加';

  @override
  String get yuan => '円';

  @override
  String get savedToChangeCanTransfer => '残高に保存され、直接送金可能';

  @override
  String get replyWithEmoji => 'この絵文字で返信';

  @override
  String get claimedYourRedPacket => 'があなたの';

  @override
  String get claimedRedPacket => 'を受け取りました';

  @override
  String get otherTyping => '入力中...';

  @override
  String get processing => '処理中...';

  @override
  String get transferCancelled => '送金がキャンセルされました';

  @override
  String get transferFailed => '送金に失敗しました';

  @override
  String get creatingPaymentRequest => '支払いリクエストを作成中...';

  @override
  String get processingPayment => '支払いを処理中...';

  @override
  String get paymentFailed => '支払いに失敗しました';

  @override
  String get clickRetry => 'タップして再試行';

  @override
  String get settingsTitle => '設定';

  @override
  String get editRemark => 'メモを編集';

  @override
  String get setPermissions => '権限を設定';

  @override
  String get recommendToFriends => '友達におすすめ';

  @override
  String get setStarFriend => 'スター付き友達に設定';

  @override
  String get addToBlacklist => 'ブラックリストに追加';

  @override
  String get complain => '報告';

  @override
  String get deleteContact => '連絡先を削除';

  @override
  String deleteContactConfirm(String name) {
    return '$nameを削除してもよろしいですか？';
  }

  @override
  String get transferTitle => '送金';

  @override
  String get receiverAddressLabel => '送金先アドレス';

  @override
  String get selectTokenLabel => 'トークンを選択';

  @override
  String get transferAmountLabel => '送金額';

  @override
  String get memoLabel => 'メモ（任意）';

  @override
  String get enterOrPasteAddressHint => 'ウォレットアドレスを入力または貼り付け';

  @override
  String get scanInDevelopment => 'スキャン機能は開発中...';

  @override
  String get availableLabel => '利用可能';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return '残高: $balance $symbol';
  }

  @override
  String get addMemoHint => 'メモを追加';

  @override
  String get receiveTitle => '受け取り';

  @override
  String get walletNotConnectedTitle => 'ウォレット未接続';

  @override
  String get connectWalletFirst => 'まずウォレットを接続してください';

  @override
  String get sendPaymentRequest => '支払いリクエストを送信';

  @override
  String get qrCodeGenerateFailed => 'QRコード生成に失敗しました';

  @override
  String get scanQrToPayMe => 'QRコードをスキャンして支払い';

  @override
  String get myWalletAddress => 'マイウォレットアドレス';

  @override
  String get createPaymentRequest => '支払いリクエストを作成';

  @override
  String get selectTokenHint => 'トークンを選択';

  @override
  String get amountLabel => '金額';

  @override
  String get cancelButton => 'キャンセル';

  @override
  String get sendRequestButton => 'リクエストを送信';

  @override
  String get allReadReceipt => 'すべて既読';

  @override
  String readCountReceipt(int count) {
    return '$count人が既読';
  }

  @override
  String n42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get redPacketDefaultGreeting => 'お祝いメッセージ';

  @override
  String senderRedPacket(String name) {
    return '$nameのレッドパケット';
  }

  @override
  String get allButton => 'すべて';

  @override
  String get enterValidAddress => '有効なアドレスを入力してください';

  @override
  String get pleaseSelectToken => 'トークンを選択してください';

  @override
  String get receivedTransfer => '送金を受け取りました';

  @override
  String get selectForwardRecipient => '転送先を選択';

  @override
  String get emojiFaces => '顔';

  @override
  String get emojiHearts => 'ハート';

  @override
  String get emojiAnimals => '動物';

  @override
  String get emojiFood => '食べ物';

  @override
  String get emojiTransport => '乗り物';

  @override
  String get emojiActivities => 'アクティビティ';

  @override
  String get emojiObjects => '物';

  @override
  String get emojiSymbols => '記号';

  @override
  String get transferProcessing => '送金処理中...';

  @override
  String senderSentRedPacket(String name) {
    return '$nameがレッドパケットを送りました';
  }

  @override
  String get savedToBalance => '残高に保存され、直接送金可能';

  @override
  String get redPacketExpiredOrEmpty => 'レッドパケットの期限切れ/すべて受け取り済み';

  @override
  String get scanFeatureComingSoon => 'スキャン機能は近日公開...';

  @override
  String get setAsStarred => 'スター付きに設定';

  @override
  String get addToBlocklist => 'ブロックリストに追加';

  @override
  String get claimedYour => ' があなたの ';

  @override
  String get claimedText => ' を受け取りました';

  @override
  String userTyping(String name) {
    return '$nameが入力中...';
  }

  @override
  String get typing => '入力中...';

  @override
  String get waitingToReceive => '受け取り待ち';

  @override
  String get tapToClaim => 'タップして受け取る';

  @override
  String get hasBeenReceived => '受け取り済み';

  @override
  String get getLucky => '幸運を祈って';

  @override
  String get cameraStartFailed => 'カメラの起動に失敗しました';

  @override
  String get unknownError => '不明なエラー';

  @override
  String get placeQrCodeInFrame => 'QRコードを枠内に配置してスキャン';

  @override
  String get closeManualInput => '手動入力を閉じる';

  @override
  String get manualInputUserId => 'ユーザーIDを手動入力';

  @override
  String get add => '追加';

  @override
  String get ringtoneClear => 'クリア';

  @override
  String get ringtonePhone => '電話';

  @override
  String get ringtoneClassic => 'クラシック';

  @override
  String get ringtoneSoft => 'ソフト';

  @override
  String get ringtoneVibrate => 'バイブレーション';

  @override
  String get ringtoneSilent => 'サイレント';

  @override
  String get stop => '停止';

  @override
  String get selectRingtone => '着信音を選択';

  @override
  String get loadingRingtones => '着信音を読み込み中...';

  @override
  String get noRingtonesFound => '着信音が見つかりません';

  @override
  String get moodAndThoughts => '気分 & 思い';

  @override
  String get statusHappy => '嬉しい';

  @override
  String get statusCracked => '疲れた';

  @override
  String get statusLucky => 'ラッキー';

  @override
  String get statusSunny => '晴れやか';

  @override
  String get statusTired => '疲れた';

  @override
  String get statusDaydream => '空想中';

  @override
  String get statusRushing => '急いでいる';

  @override
  String get statusOverthinking => '考えすぎ';

  @override
  String get statusEnergized => '元気いっぱい';

  @override
  String get workAndStudy => '仕事 & 勉強';

  @override
  String get statusWorking => '仕事中';

  @override
  String get statusStudying => '勉強中';

  @override
  String get statusBusy => '忙しい';

  @override
  String get statusSlacking => 'サボり中';

  @override
  String get statusTraveling => '旅行中';

  @override
  String get statusGoingHome => '帰宅中';

  @override
  String get statusDnd => '取り込み中';

  @override
  String get statusHanging => '遊び中';

  @override
  String get statusCheckIn => 'チェックイン';

  @override
  String get statusExercising => '運動中';

  @override
  String get statusCoffee => 'コーヒー';

  @override
  String get statusBubbleTea => 'タピオカ';

  @override
  String get statusEating => '食事中';

  @override
  String get statusParenting => '子育て中';

  @override
  String get statusSavingWorld => '世界を救う';

  @override
  String get statusSelfie => '自撮り';

  @override
  String get rest => '休憩';

  @override
  String get statusRetreat => '静養中';

  @override
  String get statusHome => '在宅';

  @override
  String get statusSleeping => '睡眠中';

  @override
  String get statusCatLover => '猫好き';

  @override
  String get statusDogWalking => '犬の散歩中';

  @override
  String get statusGaming => 'ゲーム中';

  @override
  String get statusListening => '音楽を聴いてる';

  @override
  String get setStatus => 'ステータスを設定';

  @override
  String get visibleToFriends24h => '友達に24時間表示されます';

  @override
  String get writeStatus => 'ステータスを入力';

  @override
  String get enterYourStatus => 'ステータスを入力...';

  @override
  String get ok => 'OK';

  @override
  String get cameraPermissionRequired => 'QRコードをスキャンするにはカメラの権限が必要です';

  @override
  String get cameraPermissionDenied => 'カメラの権限が永久に拒否されました。システム設定で有効にしてください。';

  @override
  String get cannotGetCameraPermission => 'カメラの権限を取得できません';

  @override
  String permissionCheckError(String error) {
    return '権限確認エラー: $error';
  }

  @override
  String get invalidQrCode => '無効なQRコード';

  @override
  String qrCodeProcessFailed(String error) {
    return 'QRコードの処理に失敗しました: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return '友達を追加できません: $error';
  }

  @override
  String get scanQrCode => 'QRコードをスキャン';

  @override
  String get checkingCameraPermission => 'カメラの権限を確認中...';

  @override
  String get needCameraPermission => 'カメラの権限が必要です';

  @override
  String get retryPermission => '再試行';

  @override
  String get openSettings => '設定を開く';

  @override
  String get inviteMembers => 'メンバーを招待';

  @override
  String inviteCount(int count) {
    return '招待($count)';
  }

  @override
  String get noShippingAddress => '配送先住所がありません';

  @override
  String get defaultLabel => 'デフォルト';

  @override
  String get editAddress => '住所を編集';

  @override
  String get recipient => '受取人';

  @override
  String get enterRecipientName => '受取人の名前を入力';

  @override
  String get phoneNumber => '電話番号';

  @override
  String get enterPhoneNumber => '電話番号を入力';

  @override
  String get regionHint => '都道府県/市区町村';

  @override
  String get detailedAddress => '詳細住所';

  @override
  String get detailedAddressHint => '番地、建物名など';

  @override
  String get setAsDefaultAddress => 'デフォルトの住所に設定';

  @override
  String get pleaseCompleteInfo => 'すべての項目を入力してください';

  @override
  String get noInvoice => '請求書がありません';

  @override
  String get company => '会社';

  @override
  String get taxNumber => '税務番号';

  @override
  String get editInvoice => '請求書を編集';

  @override
  String get companyName => '会社名';

  @override
  String get enterCompanyName => '会社名を入力';

  @override
  String get personalName => '個人名';

  @override
  String get enterName => '名前を入力';

  @override
  String get taxIdNumber => '税務ID番号';

  @override
  String get enterTaxIdNumber => '税務ID番号を入力';

  @override
  String get bankNameOptional => '銀行名（任意）';

  @override
  String get enterBankName => '銀行名を入力';

  @override
  String get bankAccountOptional => '銀行口座（任意）';

  @override
  String get enterBankAccount => '銀行口座を入力';

  @override
  String get companyAddressOptional => '会社住所（任意）';

  @override
  String get enterCompanyAddress => '会社住所を入力';

  @override
  String get companyPhoneOptional => '会社電話（任意）';

  @override
  String get enterCompanyPhone => '会社電話を入力';

  @override
  String get setAsDefaultInvoice => 'デフォルトの請求書に設定';

  @override
  String get confirmDeleteAddress => 'この住所を削除してもよろしいですか？';

  @override
  String get confirmDeleteInvoice => 'この請求書を削除してもよろしいですか？';

  @override
  String get groupOwner => 'オーナー';

  @override
  String get groupAdmin => '管理者';

  @override
  String get searchMembers => 'メンバーを検索';

  @override
  String totalMembers(int count) {
    return '$count人のメンバー';
  }

  @override
  String get removeFromGroup => 'グループから削除';

  @override
  String confirmRemoveMember(String name) {
    return '「$name」をグループから削除してもよろしいですか？';
  }

  @override
  String get setAsAdmin => '管理者に設定';

  @override
  String get removeAdmin => '管理者を解除';

  @override
  String get deleteContactSuccess => '連絡先を削除しました';

  @override
  String get unknownSong => '不明な曲';

  @override
  String get unknownArtist => '不明なアーティスト';

  @override
  String get unknownContact => '不明な連絡先';

  @override
  String get personalCard => '連絡先カード';

  @override
  String get singleChoice => '単一選択';

  @override
  String get multiChoice => '複数選択';

  @override
  String get ended => '終了';

  @override
  String get endPollButton => '投票を終了';

  @override
  String get createPoll => '投票を作成';

  @override
  String get pollQuestion => '投票の質問';

  @override
  String get pollOptions => '投票オプション';

  @override
  String optionPlaceholder(int index) {
    return 'オプション $index';
  }

  @override
  String get addOption => 'オプションを追加';

  @override
  String get pollSettings => '投票設定';

  @override
  String get anonymousPoll => '匿名投票';

  @override
  String get pollHint => '投票はチャットに表示されます。グループメンバーが投票できます。';

  @override
  String get searchSongOrArtist => '曲またはアーティストを検索';

  @override
  String get noSongsFound => '曲が見つかりません';

  @override
  String get supportedMusicPlatforms => 'NetEase、QQ Musicなどの音楽リンクをサポート';

  @override
  String get songNameOptional => '曲名（任意）';

  @override
  String get enterSongName => '曲名を入力';

  @override
  String get artistNameOptional => 'アーティスト名（任意）';

  @override
  String get enterArtistName => 'アーティスト名を入力';

  @override
  String get shareSong => '曲を共有';

  @override
  String get realTimeLocationSharing => 'リアルタイム位置情報共有は開発中...';

  @override
  String get voiceCallFeatureInDev => '音声通話機能は開発中...';

  @override
  String get reportFeatureInDev => '報告機能は開発中...';

  @override
  String get shareFeatureInDev => '共有機能は開発中...';

  @override
  String get qrCodeFeatureInDev => 'QRコード機能は開発中...';

  @override
  String get scanQrToAddMe => '上のQRコードをスキャンして友達に追加';

  @override
  String get saveToAlbum => 'アルバムに保存';

  @override
  String get changeStyle => 'スタイルを変更';

  @override
  String get copyId => 'IDをコピー';

  @override
  String get idCopied => 'IDをコピーしました';

  @override
  String get shareFeatureComingSoon => '共有機能は近日公開';

  @override
  String get saveFeatureComingSoon => '保存機能は近日公開';

  @override
  String get moreStylesFeatureComingSoon => 'その他のスタイルは近日公開';

  @override
  String get confirmEndPoll => 'この投票を終了してもよろしいですか？';

  @override
  String get cannotVoteAfterEnd => '終了後は投票できなくなります。';

  @override
  String get bio => '自己紹介';

  @override
  String get homeServer => 'サーバー';

  @override
  String get shareContactCard => '連絡先カードを共有';

  @override
  String get removeFromBlacklist => 'ブラックリストから削除';

  @override
  String get confirmAddBlacklist =>
      'このユーザーをブラックリストに追加してもよろしいですか？このユーザーからのメッセージは受信できなくなります。';

  @override
  String get confirmRemoveBlacklist => 'このユーザーをブラックリストから削除してもよろしいですか？';

  @override
  String get remarkSaved => 'メモを保存しました';

  @override
  String get remarkCleared => 'メモをクリアしました';

  @override
  String get receive => '受け取り';

  @override
  String get pleaseConnectWallet => 'まずウォレットを接続してください';

  @override
  String get sendRequest => 'リクエストを送信';

  @override
  String get pleaseEnterValidAmount => '有効な金額を入力してください';

  @override
  String get searchPlaceholder => '連絡先、グループ、メッセージを検索';

  @override
  String get enterKeywordToSearch => 'キーワードを入力して検索を開始';

  @override
  String get clearHistory => 'クリア';

  @override
  String noResultsForQuery(String query) {
    return '「$query」の検索結果が見つかりませんでした';
  }

  @override
  String get allResults => 'すべて';

  @override
  String get searchInChat => 'チャット内を検索';

  @override
  String get contactLabel => '連絡先';

  @override
  String get groupLabel => 'グループ';

  @override
  String get conversationLabel => '会話';

  @override
  String get messageLabel => 'メッセージ';

  @override
  String get securityTitle => 'セキュリティ';

  @override
  String get keyBackup => 'キーバックアップ';

  @override
  String get backupEncryptionKeys => '暗号化キーをバックアップ';

  @override
  String keysBackedUp(int count) {
    return '$count個のキーをバックアップしました';
  }

  @override
  String get backupNotSet => 'バックアップ未設定';

  @override
  String get restoreKeys => 'キーを復元';

  @override
  String get restoreKeysFromBackup => 'バックアップから暗号化キーを復元';

  @override
  String get exportKeys => 'キーをエクスポート';

  @override
  String get exportKeysToFile => 'キーをファイルにエクスポート';

  @override
  String get loggedInDevices => 'ログイン中のデバイス';

  @override
  String get noOtherDevices => '他のデバイスはありません';

  @override
  String get verified => '確認済み';

  @override
  String get unverified => '未確認';

  @override
  String get advanced => '詳細設定';

  @override
  String get crossSigning => 'クロス署名';

  @override
  String get enabled => '有効';

  @override
  String get notEnabled => '無効';

  @override
  String get resetEncryption => '暗号化をリセット';

  @override
  String get deleteAllEncryptionKeys => 'すべての暗号化キーを削除';

  @override
  String get encryptionNotSupported => '暗号化はサポートされていません';

  @override
  String get notInitialized => '初期化されていません';

  @override
  String get backupKeyTitle => 'キーをバックアップ';

  @override
  String get backupKeyMessage =>
      '新しいキーバックアップを作成しますか？これにより、新しいデバイスで暗号化されたメッセージを復元できます。';

  @override
  String get backup => 'バックアップ';

  @override
  String get restoreKeyTitle => 'キーを復元';

  @override
  String get restoreKeyMessage => '暗号化されたメッセージを復元するには、回復パスワードまたは回復キーを入力してください。';

  @override
  String get restore => '復元';

  @override
  String get exportKeyTitle => 'キーをエクスポート';

  @override
  String get exportKeyMessage =>
      'エクスポートされたキーファイルにはすべての暗号化キーが含まれています。安全に保管してください。';

  @override
  String get export => 'エクスポート';

  @override
  String deviceIdLabel(String deviceId) {
    return 'デバイスID: $deviceId';
  }

  @override
  String get deviceStatusVerified => 'ステータス: 確認済み';

  @override
  String get deviceStatusUnverified => 'ステータス: 未確認';

  @override
  String lastActiveLabel(String lastSeen) {
    return '最終アクティブ: $lastSeen';
  }

  @override
  String get verifyThisDevice => 'このデバイスを確認';

  @override
  String get crossSigningAlreadyEnabled => 'クロス署名は既に有効です';

  @override
  String get crossSigningSetupSuccess => 'クロス署名の設定が完了しました';

  @override
  String get resetEncryptionTitle => '暗号化をリセット';

  @override
  String get resetEncryptionWarning =>
      '警告: これにより、すべての暗号化キーが削除されます。以前の暗号化されたメッセージを復号化できなくなります。この操作は取り消せません。';

  @override
  String get reset => 'リセット';

  @override
  String get leaveMeetingConfirm => 'ミーティングを退出してもよろしいですか？';

  @override
  String pokedSomeone(String name, String suffix) {
    return '$name$suffixをつついた';
  }

  @override
  String get noContactsToAdd => '追加できる連絡先がありません';

  @override
  String get addMembers => 'メンバーを追加';

  @override
  String invitedMembers(int count) {
    return '$count人のメンバーを招待しました';
  }

  @override
  String inviteFailed(String error) {
    return '招待に失敗しました: $error';
  }

  @override
  String get memberRemoved => 'メンバーを削除しました';

  @override
  String removeFailed(String error) {
    return '削除に失敗しました: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      '共有後、相手は1時間あなたのリアルタイム位置情報を見ることができます。';

  @override
  String get startSharing => '共有を開始';

  @override
  String get locationServiceNotEnabled => '位置情報サービスが有効になっていません';

  @override
  String get enableLocationService => 'この機能を使用するには位置情報サービスを有効にしてください';

  @override
  String get goToSettings => '設定へ移動';

  @override
  String get locationPermissionRequired => 'この機能には位置情報の権限が必要です';

  @override
  String get locationPermissionDeniedPermanent =>
      '位置情報の権限が永久に拒否されました。設定で有効にしてください。';

  @override
  String get locationPermissionDenied => '位置情報の権限が拒否されました';

  @override
  String get gettingLocation => '位置情報を取得中...';

  @override
  String getLocationFailed(String error) {
    return '位置情報の取得に失敗しました: $error';
  }

  @override
  String get currentLocation => '現在地';

  @override
  String nearbyPlace(int index) {
    return '近くの場所 $index';
  }

  @override
  String approximateDistance(String distance) {
    return '約$distance';
  }

  @override
  String get mapPreview => '地図プレビュー';

  @override
  String get searchLocation => '場所を検索';

  @override
  String redPacketSent(String amount, String token) {
    return '$amount $tokenのレッドパケットを送りました';
  }

  @override
  String get transferDefault => '送金';

  @override
  String transferSent(String amount, String token) {
    return '$amount $tokenを送金しました';
  }

  @override
  String pickFileFailed(String error) {
    return 'ファイルの選択に失敗しました: $error';
  }

  @override
  String get fileSizeLimit => 'ファイルサイズは50MBを超えられません';

  @override
  String fileSending(String filename) {
    return 'ファイルを送信中: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'ファイルの送信に失敗しました: $error';
  }

  @override
  String contactCardSent(String name) {
    return '$nameの連絡先カードを送信しました';
  }

  @override
  String get favoritesFeature => 'お気に入り';

  @override
  String get couponsFeature => 'クーポン';

  @override
  String get giftFeature => 'ギフト';

  @override
  String sharedMusic(String name) {
    return '$nameを共有しました';
  }

  @override
  String get endPollTitle => '投票を終了';

  @override
  String get endPollConfirmMessage => 'この投票を終了してもよろしいですか？終了後は投票できなくなります。';

  @override
  String get pollEndedMessage => '投票が終了しました';

  @override
  String get connectingCall => '接続中...';

  @override
  String get muteCall => 'ミュート';

  @override
  String get speakerOff => 'スピーカーオフ';

  @override
  String get speakerOn => 'スピーカー';

  @override
  String get cameraOn => 'カメラオン';

  @override
  String get cameraOff => 'カメラオフ';

  @override
  String get hangUp => '通話終了';

  @override
  String get selectForwardTargetTitle => '転送先を選択';

  @override
  String get noForwardableChat => '転送可能なチャットがありません';

  @override
  String get noMatchingChat => '一致するチャットが見つかりません';

  @override
  String get imagePreview => '[画像]';

  @override
  String get voicePreview => '[音声]';

  @override
  String get videoPreview => '[動画]';

  @override
  String filePreviewWithName(String filename) {
    return '[ファイル] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[位置情報] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[音楽] $title';
  }

  @override
  String get messagePreview => '[メッセージ]';

  @override
  String get locationTitle => '位置情報';

  @override
  String get sendButton => '送信';

  @override
  String get retryButton => '再試行';

  @override
  String get selectContact => '連絡先を選択';

  @override
  String get searchContactHint => '連絡先を検索';

  @override
  String get shareMusic => '音楽を共有';

  @override
  String get recentPlayed => '最近';

  @override
  String get myFavorites => 'お気に入り';

  @override
  String get networkLink => 'リンク';

  @override
  String get localFile => 'ローカル';

  @override
  String get musicLinkRequired => '音楽リンク *';

  @override
  String get pasteMusicLink => '音楽リンクを貼り付け';

  @override
  String get enterSongNamePlaceholder => '曲名を入力';

  @override
  String get enterArtistNamePlaceholder => 'アーティスト名を入力';

  @override
  String get shareMusicButton => '音楽を共有';

  @override
  String get selectLocalAudio => 'ローカルの音声ファイルを選択';

  @override
  String get supportedAudioFormats => 'MP3、M4A、WAV、FLACなどをサポート';

  @override
  String get selectFileButton => 'ファイルを選択';

  @override
  String get pleaseEnterMusicLink => '音楽リンクを入力してください';

  @override
  String get pleaseEnterValidLink => '有効なURLを入力してください';

  @override
  String get sharedSong => '共有した曲';

  @override
  String get selectMember => 'メンバーを選択';

  @override
  String get searchMemberHint => 'メンバーを検索';

  @override
  String get noMatchingMembers => '一致するメンバーが見つかりません';

  @override
  String get unknownMember => '不明';

  @override
  String selectedMessagesCount(int count) {
    return '$count件のメッセージを選択';
  }

  @override
  String get searchContactsOrGroups => '連絡先またはグループを検索';

  @override
  String get noMatchingConversations => '一致する会話が見つかりません';

  @override
  String get videoTitle => '動画';

  @override
  String get loadingText => '読み込み中...';

  @override
  String get videoPlaybackFailed => '動画の再生に失敗しました';

  @override
  String get videoLoadFailed => '動画の読み込みに失敗しました';

  @override
  String get playerInitFailed => 'プレーヤーの初期化に失敗しました';

  @override
  String get createPollTitle => '投票を作成';

  @override
  String get submitPoll => '送信';

  @override
  String get pollQuestionLabel => '投票の質問';

  @override
  String get enterPollQuestionHint => '投票の質問を入力してください';

  @override
  String get pollOptionsLabel => '投票オプション';

  @override
  String optionHintWithIndex(int index) {
    return 'オプション $index';
  }

  @override
  String get addOptionButton => 'オプションを追加';

  @override
  String get pollSettingsLabel => '投票設定';

  @override
  String get selectionType => '選択タイプ';

  @override
  String get singleChoiceLabel => '単一';

  @override
  String get multiChoiceLabel => '複数';

  @override
  String get anonymousPollSwitch => '匿名投票';

  @override
  String get pleaseEnterQuestion => '投票の質問を入力してください';

  @override
  String get atLeastTwoOptions => '最低2つのオプションが必要です';

  @override
  String confirmWithCount(int count) {
    return '確認 ($count)';
  }

  @override
  String get emailVerificationTitle => 'メール認証';

  @override
  String get enterValidEmailAddress => '有効なメールアドレスを入力してください';

  @override
  String verificationCodeSentTo(String email) {
    return '認証コードを$emailに送信しました';
  }

  @override
  String sendCodeFailed(String error) {
    return 'コードの送信に失敗しました: $error';
  }

  @override
  String get verificationSuccess => '認証に成功しました';

  @override
  String get verificationFailed => '認証に失敗しました';

  @override
  String verificationCodeError(String error) {
    return '認証コードエラー: $error';
  }

  @override
  String get enterVerificationCode => '認証コードを入力';

  @override
  String get enterYourEmail => 'メールアドレスを入力';

  @override
  String weSentCodeTo(String email) {
    return '6桁のコードを\n$emailに送信しました';
  }

  @override
  String get enterEmailForCode => 'メールアドレスを入力すると、認証コードを送信します';

  @override
  String get sendVerificationCode => '認証コードを送信';

  @override
  String get resendVerificationCode => '認証コードを再送信';

  @override
  String canResendAfter(int seconds) {
    return '$seconds秒後に再送信可能';
  }

  @override
  String get changeEmail => 'メールアドレスを変更';

  @override
  String get addToContacts => '連絡先に追加';

  @override
  String get addingToContacts => '追加中...';

  @override
  String get addedToContacts => '連絡先に追加しました';

  @override
  String addFailedWithError(String error) {
    return '追加に失敗しました: $error';
  }

  @override
  String get addPhone => '電話番号を追加';

  @override
  String get addTag => 'タグを追加';

  @override
  String get addText => 'テキストを追加';

  @override
  String get addPhoto => '写真を追加';

  @override
  String groupCountLabel(int count) {
    return '$count件のグループ';
  }

  @override
  String get addedViaSearch => '検索で追加';

  @override
  String get addTime => '日時を追加';

  @override
  String get doneButton => '完了';

  @override
  String get waitingForParticipants => '参加者を待っています...';

  @override
  String participantMe(String name) {
    return '$name (自分)';
  }

  @override
  String get sharingLabel => '共有中';

  @override
  String screenSharingBy(String name) {
    return '$nameが画面を共有中';
  }

  @override
  String participantCount(int count) {
    return '$count人の参加者';
  }

  @override
  String get muteLabel => 'ミュート';

  @override
  String get unmuteLabel => 'ミュート解除';

  @override
  String get turnOffVideo => 'ビデオをオフ';

  @override
  String get turnOnVideo => 'ビデオをオン';

  @override
  String get shareScreen => '画面を共有';

  @override
  String get stopSharing => '共有を停止';

  @override
  String get switchCameraLabel => '切り替え';

  @override
  String get leaveLabel => '退出';

  @override
  String get participantsLabel => '参加者';

  @override
  String get joiningMeeting => 'ミーティングに参加中...';

  @override
  String pollVotesFormat(int count, String percentage) {
    return '$count票 ($percentage%)';
  }

  @override
  String pollParticipantsFormat(int count) {
    return '$count人が参加';
  }

  @override
  String get tapToRetry => 'タップして再試行';

  @override
  String get noConversationsToForward => '転送できる会話がありません';

  @override
  String get defaultRedPacketGreeting => '金運上昇、幸福をお祈りします';

  @override
  String get emojiCategoryFace => '顔文字';

  @override
  String get emojiCategoryHeart => 'ハート';

  @override
  String get emojiCategoryAnimal => '動物';

  @override
  String get emojiCategoryFood => '食べ物';

  @override
  String get emojiCategoryTransport => '乗り物';

  @override
  String get emojiCategoryActivity => 'アクティビティ';

  @override
  String get emojiCategoryObject => '物';

  @override
  String get emojiCategorySymbol => '記号';

  @override
  String get allowOthersToSearchAndJoin => '他のユーザーが検索して参加することを許可する';

  @override
  String get allowStrangerMessages => '知らない人からのメッセージを許可';

  @override
  String get alwaysUseDarkTheme => '常にダークテーマを使用';

  @override
  String get alwaysUseLightTheme => '常にライトテーマを使用';

  @override
  String get autoSwitchBySystem => 'システム設定に応じて自動切り替え';

  @override
  String get bubbleStyle => '吹き出しスタイル';

  @override
  String get bubbleStyleClassic => 'クラシックスタイル';

  @override
  String get bubbleStyleClassicDesc => '伝統的な吹き出しスタイル';

  @override
  String get bubbleStyleModern => 'モダンスタイル';

  @override
  String get bubbleStyleModernDesc => 'シンプルでモダンな吹き出しスタイル';

  @override
  String get bubbleStyleWechat => 'WeChatスタイル';

  @override
  String get bubbleStyleWechatDesc => 'クラシックなWeChat吹き出しスタイル';

  @override
  String get callEnded => '通話終了';

  @override
  String get callFailed => '通話失敗';

  @override
  String get checkForUpdates => 'アップデートを確認';

  @override
  String get confirmClearChatHistory => 'チャット履歴を削除してもよろしいですか?';

  @override
  String get createGroupToChat => 'グループを作成してチャットを開始する';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get darkModeOption => 'ダークモード';

  @override
  String get doNotDisturbDescription => '指定時間中は通知を受け取らない';

  @override
  String get doNotDisturbMode => 'おやすみモード';

  @override
  String get editGroupAnnouncement => 'グループお知らせを編集';

  @override
  String get editGroupDescription => 'グループ説明を編集';

  @override
  String get enterGroupAnnouncement => 'グループお知らせを入力';

  @override
  String errorWithMessage(String message) {
    return 'エラー: $message';
  }

  @override
  String get feedbackAndSuggestions => 'フィードバックと提案';

  @override
  String get followSystem => 'システムに従う';

  @override
  String get fontSize => 'フォントサイズ';

  @override
  String get fontSizeExtraLarge => '特大';

  @override
  String get fontSizeLarge => '大';

  @override
  String get fontSizeSmall => '小';

  @override
  String get fontSizeStandard => '標準';

  @override
  String get incomingVideoCall => 'ビデオ通話の着信';

  @override
  String get incomingVoiceCall => '音声通話の着信';

  @override
  String get letOthersKnowYouRead => '既読を相手に知らせる';

  @override
  String get letOthersKnowYouTyping => '入力中であることを相手に知らせる';

  @override
  String get lightMode => 'ライトモード';

  @override
  String memberCountClickToCopy(int count) {
    return '$count人、クリックしてグループIDをコピー';
  }

  @override
  String get messageNotifications => 'メッセージ通知';

  @override
  String get messagesLabel => 'メッセージ';

  @override
  String get musicLinkLabel => '音楽リンク';

  @override
  String get noMediaUrlAvailable => 'メディアURLがありません';

  @override
  String get noPermissionToEditGroupName => 'グループ名を編集する権限がありません';

  @override
  String get receiveMessagesFromNonContacts => '連絡先以外からのメッセージを受け取る';

  @override
  String get receiveNewMessageNotifications => '新着メッセージ通知を受け取る';

  @override
  String get reconnectingCall => '再接続中...';

  @override
  String get redPacketTransferCannotForward => '紅包と送金は転送できません';

  @override
  String get showMessageContentInNotification => '通知にメッセージ内容を表示';

  @override
  String get showMessagePreview => 'メッセージプレビューを表示';

  @override
  String get typingIndicator => '入力中表示';

  @override
  String versionInfo(String version) {
    return 'バージョン $version';
  }

  @override
  String get vibration => 'バイブレーション';

  @override
  String get videoCallInProgress => 'ビデオ通話中';

  @override
  String get voiceCallInProgress => '音声通話中';

  @override
  String whoCanSeeTitle(String title) {
    return '$titleを見られる人';
  }

  @override
  String get emailAddress => 'メールアドレス';

  @override
  String get enterEmailAddress => 'メールアドレスを入力';

  @override
  String get emailRecoveryHint => 'パスワードの回復に使用されます';

  @override
  String get invalidEmailFormat => '有効なメールアドレスを入力してください';

  @override
  String get optional => '任意';

  @override
  String get resetPassword => 'パスワードをリセット';

  @override
  String get resetPasswordTitle => 'パスワードをリセット';

  @override
  String get enterRegisteredEmail => '登録時のメールアドレスを入力してください';

  @override
  String get sendResetCode => 'リセットコードを送信';

  @override
  String resetCodeSent(String email) {
    return 'リセットコードを$emailに送信しました';
  }

  @override
  String get enterResetCode => 'リセットコードを入力';

  @override
  String get setNewPassword => '新しいパスワードを設定';

  @override
  String get confirmNewPassword => '新しいパスワードを確認';

  @override
  String get newPassword => '新しいパスワード';

  @override
  String get passwordResetSuccess => 'パスワードが正常にリセットされました。新しいパスワードでログインしてください。';

  @override
  String get resetPasswordFailed => 'パスワードのリセットに失敗しました';

  @override
  String get changePassword => 'パスワードを変更';

  @override
  String get currentPassword => '現在のパスワード';

  @override
  String get enterCurrentPassword => '現在のパスワードを入力';

  @override
  String get enterNewPassword => '新しいパスワードを入力';

  @override
  String get passwordChanged => 'パスワードが正常に変更されました。新しいパスワードでログインしてください。';

  @override
  String get changePasswordFailed => 'パスワードの変更に失敗しました';

  @override
  String get incorrectCurrentPassword => '現在のパスワードが正しくありません';

  @override
  String get newPasswordMustBeDifferent => '新しいパスワードは現在のパスワードと異なる必要があります';

  @override
  String get changePasswordInfo =>
      'パスワードを変更すると、ログアウトされ、新しいパスワードでログインする必要があります。';

  @override
  String get passwordRequirements => 'パスワード要件：';

  @override
  String get securityNote => 'セキュリティのため、パスワード変更後はすべてのデバイスで再ログインが必要です。';

  @override
  String get security => 'セキュリティ';

  @override
  String get currentBoundEmail => '現在紐付けられているメールアドレス';

  @override
  String get newEmailAddress => '新しいメールアドレス';

  @override
  String get enterNewEmail => '新しいメールアドレスを入力';

  @override
  String get verificationCode => '確認コード';

  @override
  String get verificationCodeSent => '確認コードが送信されました';

  @override
  String get codeSentTo => '確認コードの送信先';

  @override
  String get didNotReceiveCode => 'コードが届きませんか？';

  @override
  String get emailChangedSuccess => 'メールアドレスが正常に変更されました';

  @override
  String get changeEmailFailed => 'メールアドレスの変更に失敗しました';

  @override
  String get emailSecurityNote => 'メールアドレスはパスワードの回復に使用されます。安全に保管してください。';

  @override
  String get googleLogin => 'Googleでサインイン';

  @override
  String get appleLogin => 'Appleでサインイン';

  @override
  String get facebookLogin => 'Facebookでサインイン';

  @override
  String get twitterLogin => 'Twitterでサインイン';

  @override
  String get wechatLogin => 'WeChatでサインイン';

  @override
  String get wechat => 'WeChat';

  @override
  String get facebook => 'Facebook';

  @override
  String get twitter => 'Twitter';

  @override
  String get wechatNotInstalled => 'WeChatをインストールしてください';

  @override
  String get wechatLoginFailed => 'WeChatログインに失敗しました';

  @override
  String get facebookLoginFailed => 'Facebookログインに失敗しました';

  @override
  String get twitterLoginFailed => 'Twitterログインに失敗しました';

  @override
  String get twitterNotConfigured => 'Twitterログインが設定されていません';

  @override
  String get socialLoginCancelled => 'ログインがキャンセルされました';

  @override
  String get socialLoginFailed => 'ソーシャルログインに失敗しました';

  @override
  String get language => '言語';

  @override
  String get languageChanged => '言語が変更されました';

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

  @override
  String get n42BeanTitle => 'N42ビーン';

  @override
  String get n42BeanDetails => 'N42ビーン詳細';

  @override
  String get noN42Bean => 'N42ビーンなし';

  @override
  String get n42BeanDescription =>
      'N42ビーンはN42内の仮想アイテムやサービスを交換するためのトークンです。現在利用可能：';

  @override
  String get n42BeanFeature1 => '会員限定スタンプとテーマ';

  @override
  String get n42BeanFeature2 => 'チャットバブルのカスタマイズ';

  @override
  String get n42BeanFeature3 => '紅包カバーのカスタマイズ';

  @override
  String get n42BeanFeature4 => '限定ニックネームバッジ';

  @override
  String get n42BeanFeature5 => 'グループチャット特権';

  @override
  String get n42BeanFeature6 => 'クラウドストレージ拡張';

  @override
  String get n42BeanFeature7 => 'ビデオ通話美顔フィルター';

  @override
  String get n42BeanFeature8 => 'モーメント背景カスタマイズ';

  @override
  String get n42BeanFeature9 => 'VIPカスタマーサービス優先';

  @override
  String get gotIt => '了解';

  @override
  String get noN42BeanRecords => 'N42ビーン記録なし';

  @override
  String get cameraPermissionRestricted => 'このデバイスではカメラアクセスが制限されています';

  @override
  String get passkeyLabel => 'Passkey';

  @override
  String get googleLabel => 'Google';

  @override
  String get appleLabel => 'Apple';

  @override
  String get ssoLabel => 'SSO';

  @override
  String get amountHintZero => '0.00';

  @override
  String get matrixIdHint => '@username:server.com';

  @override
  String get serverAddressHint => 'https://m.si46.world';

  @override
  String get emailExampleHint => 'example@email.com';

  @override
  String get verificationCodePlaceholder => '------';

  @override
  String get enterPokeSuffixHint => '输入戳一戳后缀，例如：的肩膀';
}
