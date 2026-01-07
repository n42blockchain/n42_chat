// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get chatModuleInitFailed => 'Chat module initialization failed';

  @override
  String get checkNetworkRetry => 'Please check your network connection and try again';

  @override
  String get retry => 'Retry';

  @override
  String get unknownUser => 'Unknown User';

  @override
  String get walletNotConnected => 'Wallet not connected';

  @override
  String get cannotGetWalletAddress => 'Cannot get wallet address';

  @override
  String paymentRequestMemo(String requestId) {
    return 'Payment request: $requestId';
  }

  @override
  String get callServiceNotInitialized => 'Call service not initialized';

  @override
  String get alreadyInCall => 'Already in a call';

  @override
  String get meetingServiceNotInitialized => 'Meeting service not initialized';

  @override
  String get livekitNotConfigured => 'LiveKit not configured';

  @override
  String get unknownConversation => 'Unknown conversation';

  @override
  String startCallFailed(String error) {
    return 'Failed to start call: $error';
  }

  @override
  String answerCallFailed(String error) {
    return 'Failed to answer: $error';
  }

  @override
  String get connectionFailed => 'Connection failed';

  @override
  String get callRejected => 'Call declined';

  @override
  String get noAnswer => 'No answer';

  @override
  String get invalidLoginResponse => 'Invalid login response';

  @override
  String loginFailed(String error) {
    return 'Login failed: $error';
  }

  @override
  String get sessionRestoreFailed => 'Session restore failed';

  @override
  String get additionalVerificationRequired => 'Additional verification required';

  @override
  String registrationFailed(String error) {
    return 'Registration failed: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'Cannot connect to server: $error';
  }

  @override
  String get wrongUsernamePassword => 'Incorrect username or password';

  @override
  String get usernameTaken => 'Username already taken';

  @override
  String get invalidUsernameFormat => 'Invalid username format';

  @override
  String get rateLimitExceeded => 'Too many requests, please try again later';

  @override
  String get loginExpired => 'Login expired';

  @override
  String joinMeetingFailed(String error) {
    return 'Failed to join meeting: $error';
  }

  @override
  String screenShareFailed(String error) {
    return 'Screen share failed: $error';
  }

  @override
  String get answer => 'Answer';

  @override
  String get decline => 'Decline';

  @override
  String get missedCall => 'Missed call';

  @override
  String get callBack => 'Call back';

  @override
  String get incomingCall => 'Incoming call';

  @override
  String get missedVideoCall => 'Missed video call';

  @override
  String get missedVoiceCall => 'Missed voice call';

  @override
  String get passkeyNotInitialized => 'Passkey not initialized';

  @override
  String get googleSignInNotConfigured => 'Google Sign In not configured';

  @override
  String get encryptedMessage => '[Encrypted message]';

  @override
  String get sticker => '[Sticker]';

  @override
  String get groupCreated => 'Group created';

  @override
  String get groupNameChanged => 'Group name changed';

  @override
  String get groupAvatarChanged => 'Group avatar changed';

  @override
  String get groupAnnouncementChanged => 'Group announcement changed';

  @override
  String get image => '[Image]';

  @override
  String get video => '[Video]';

  @override
  String get voice => '[Voice]';

  @override
  String get file => '[File]';

  @override
  String get location => '[Location]';

  @override
  String get unknownMessage => '[Unknown message]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName joined the group';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName left the group';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName was invited';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName was removed';
  }

  @override
  String get avatarDataEmpty => 'Avatar data is empty';

  @override
  String get avatarTooLarge => 'Avatar file too large, max 10MB';

  @override
  String get uploadAvatarFailed => 'Failed to upload avatar';

  @override
  String get delete => 'Delete';

  @override
  String get notLoggedIn => 'Not logged in';

  @override
  String roomNotExist(String roomId) {
    return 'Room not found: $roomId';
  }

  @override
  String get uploadImageFailed => 'Failed to upload image';

  @override
  String get matrixClientNotInitialized => 'Matrix client not initialized';

  @override
  String get uploadVoiceFailed => 'Failed to upload voice: Cannot get MXC URI';

  @override
  String get uploadVideoFailed => 'Failed to upload video: Cannot get MXC URI';

  @override
  String get uploadFileFailed => 'Failed to upload file: Cannot get MXC URI';

  @override
  String locationWithCoords(String lat, String lon) {
    return 'Location: $lat, $lon';
  }

  @override
  String get myLocation => 'My location';

  @override
  String get pollEnded => 'Poll ended';

  @override
  String get groupChat => 'Group Chat';

  @override
  String get search => 'Search';

  @override
  String get cancel => 'Cancel';

  @override
  String get userCancelled => 'User cancelled';

  @override
  String get noData => 'No data';

  @override
  String get noSearchResults => 'No search results';

  @override
  String get tryDifferentKeyword => 'Try a different keyword';

  @override
  String get loadFailed => 'Failed to load';

  @override
  String get checkNetwork => 'Please check your network connection';

  @override
  String get networkConnectionFailed => 'Network connection failed';

  @override
  String get checkNetworkSettings => 'Please check your network settings';

  @override
  String get messages => 'Messages';

  @override
  String get contacts => 'Contacts';

  @override
  String get discover => 'Discover';

  @override
  String get me => 'Me';

  @override
  String get voiceLoading => 'Voice loading, please try again later';

  @override
  String get voiceToTextFailed => 'Voice to text failed';

  @override
  String get converting => 'Converting...';

  @override
  String get convertToText => 'To text';

  @override
  String get convertToTextTitle => 'Convert to Text';

  @override
  String get selectEmoji => 'Select emoji';

  @override
  String get frequentlyUsed => 'Frequently used';

  @override
  String get copy => 'Copy';

  @override
  String get forward => 'Forward';

  @override
  String get unfavorite => 'Unfavorite';

  @override
  String get favorite => 'Favorite';

  @override
  String get resend => 'Resend';

  @override
  String get recall => 'Recall';

  @override
  String get multiSelect => 'Multi-select';

  @override
  String get quote => 'Quote';

  @override
  String get remind => 'Remind';

  @override
  String get searchThis => 'Search';

  @override
  String get recallMessageConfirm => 'Recall this message?';

  @override
  String get youRecalledMessage => 'You recalled a message';

  @override
  String get otherRecalledMessage => 'Message recalled';

  @override
  String get reEdit => 'Re-edit';

  @override
  String get copied => 'Copied';

  @override
  String get sendMessageHint => 'Send a message';

  @override
  String get microphonePermissionRequired => 'Please allow microphone permission';

  @override
  String startRecordingFailed(String error) {
    return 'Failed to start recording: $error';
  }

  @override
  String get recordingTooShort => 'Recording too short';

  @override
  String stopRecordingFailed(String error) {
    return 'Failed to stop recording: $error';
  }

  @override
  String get releaseToCancel => 'Release to cancel';

  @override
  String get releaseToSend => 'Release to send, swipe up to cancel';

  @override
  String get holdToTalk => 'Hold to talk';

  @override
  String get send => 'Send';

  @override
  String conversationLabel(String roomId) {
    return 'Conversation: $roomId';
  }

  @override
  String contactLabel(String userId) {
    return 'Contact: $userId';
  }

  @override
  String get addFriend => 'Add Friend';

  @override
  String get settings => 'Settings';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get login => 'Log In';

  @override
  String get createGroup => 'Create Group';

  @override
  String developing(String title) {
    return '$title\n(Coming soon)';
  }

  @override
  String get error => 'Error';

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get allRead => 'All read';

  @override
  String readCount(int count) {
    return '$count read';
  }

  @override
  String get transfer => 'Transfer';

  @override
  String get pendingReceipt => 'Pending';

  @override
  String get tapToReceive => 'Tap to receive';

  @override
  String get received => 'Received';

  @override
  String get paymentReceived => 'Payment received';

  @override
  String get refunded => 'Refunded';

  @override
  String get expired => 'Expired';

  @override
  String get redPacketGreeting => 'Best wishes';

  @override
  String get n42RedPacket => 'N42 Red Packet';

  @override
  String get goodLuck => 'Get some luck';

  @override
  String get claimed => 'Claimed';

  @override
  String get allClaimed => 'All claimed';

  @override
  String get emoji => 'Emoji';

  @override
  String get love => 'Love';

  @override
  String get animals => 'Animals';

  @override
  String get food => 'Food';

  @override
  String get travel => 'Travel';

  @override
  String get activities => 'Activities';

  @override
  String get objects => 'Objects';

  @override
  String get symbols => 'Symbols';

  @override
  String get reply => 'Reply';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get edit => 'Edit';

  @override
  String get more => 'More';

  @override
  String get selectForwardTarget => 'Select recipient';

  @override
  String sendCount(int count) {
    return 'Send ($count)';
  }

  @override
  String get draft => '[Draft] ';

  @override
  String n42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get friendInfo => 'Friend Info';

  @override
  String get friendInfoDesc => 'Add friend\'s remark, phone, tags, notes, photos and set permissions.';

  @override
  String get moments => 'Moments';

  @override
  String get sendMessage => 'Message';

  @override
  String get audioVideoCall => 'Audio/Video Call';

  @override
  String get videoChannel => 'Video Channel';

  @override
  String get remark => 'Remark';

  @override
  String get remarkName => 'Remark Name';

  @override
  String get phone => 'Phone';

  @override
  String get tags => 'Tags';

  @override
  String get notes => 'Notes';

  @override
  String get photos => 'Photos';

  @override
  String get permissions => 'Permissions';

  @override
  String get chatMomentsEtc => 'Chat, Moments, Sports, etc.';

  @override
  String get moreInfo => 'More Info';

  @override
  String get commonGroups => 'Groups in common';

  @override
  String get zeroGroups => '0';

  @override
  String get source => 'Source';

  @override
  String get notificationSettings => 'Notifications';

  @override
  String get receiveNotifications => 'Receive new message notifications';

  @override
  String get showPreview => 'Show message preview';

  @override
  String get showContentInNotification => 'Show message content in notifications';

  @override
  String get notificationSound => 'Notification sound';

  @override
  String get playSoundOnMessage => 'Play sound when receiving messages';

  @override
  String get vibrate => 'Vibrate';

  @override
  String get vibrateOnMessage => 'Vibrate when receiving messages';

  @override
  String get doNotDisturb => 'Do Not Disturb';

  @override
  String get dndDescription => 'Mute notifications during specified hours';

  @override
  String get startTime => 'Start time';

  @override
  String get endTime => 'End time';

  @override
  String get privacy => 'Privacy';

  @override
  String get appearance => 'Appearance';

  @override
  String get chat => 'Chat';

  @override
  String get about => 'About';

  @override
  String get logout => 'Log Out';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get exit => 'Log Out';

  @override
  String get save => 'Save';

  @override
  String get nickname => 'Nickname';

  @override
  String get enterNickname => 'Enter nickname';

  @override
  String get signature => 'Signature';

  @override
  String get addSignature => 'Add a signature';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String saveFailed(String error) {
    return 'Save failed: $error';
  }

  @override
  String get secureDecentralizedChat => 'Secure, decentralized messaging';

  @override
  String get endToEndEncryption => 'End-to-end encryption';

  @override
  String get messagesOnlyYouCanSee => 'Messages visible only to you and the recipient';

  @override
  String get decentralized => 'Decentralized';

  @override
  String get basedOnMatrix => 'Built on the Matrix open protocol';

  @override
  String get walletIntegration => 'Wallet Integration';

  @override
  String get easyCryptoTransfer => 'Easy cryptocurrency transfers';

  @override
  String get register => 'Sign Up';

  @override
  String get agreeTerms => 'By logging in, you agree to';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get and => 'and';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get serverAddress => 'Server Address';

  @override
  String get enterServerAddress => 'Enter server address';

  @override
  String get validServerAddress => 'Please enter a valid server address';

  @override
  String connectedTo(String serverName) {
    return 'Connected to $serverName';
  }

  @override
  String get username => 'Username';

  @override
  String get enterUsername => 'Enter username';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get registerAccount => 'Sign Up';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get otherLoginMethods => 'Other login methods';

  @override
  String get emailVerification => 'Email verification code';

  @override
  String get enterServerFirst => 'Please enter server address first';

  @override
  String get passkeyNeedsServer => 'Passkey login requires server support';

  @override
  String googleLoginSuccess(String email) {
    return 'Google login success: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Google login failed: $error';
  }

  @override
  String get appleLoginSuccess => 'Apple login success';

  @override
  String appleLoginFailed(String error) {
    return 'Apple login failed: $error';
  }

  @override
  String get createAccount => 'Create Account';

  @override
  String get joinN42Chat => 'Join N42 Chat to start chatting';

  @override
  String get usernameHint => 'Enter username (letters, numbers, underscores)';

  @override
  String get usernameMinLength => 'Username must be at least 3 characters';

  @override
  String get usernameFormat => 'Username can only contain letters, numbers, and underscores';

  @override
  String get passwordHint => 'Enter password (at least 8 characters)';

  @override
  String get passwordMinLength => 'Password must be at least 8 characters';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get reEnterPassword => 'Re-enter password';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get inviteCode => 'Invite code (built-in)';

  @override
  String get filled => 'Filled';

  @override
  String get enterInviteCode => 'Enter invite code';

  @override
  String get inviteCodeHint => 'Invite code is built-in, usually no need to modify';

  @override
  String get agreeTermsFirst => 'Please read and agree to the terms and privacy policy first';

  @override
  String get iAgree => 'I have read and agree to';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get loginNow => 'Log in now';

  @override
  String get whoCanSee => 'Who can see';

  @override
  String get avatar => 'Avatar';

  @override
  String get status => 'Status';

  @override
  String get lastSeen => 'Last seen';

  @override
  String get messageSettings => 'Messages';

  @override
  String get allowStrangerMessage => 'Allow messages from strangers';

  @override
  String get receiveNonContact => 'Receive messages from non-contacts';

  @override
  String get readReceipts => 'Read receipts';

  @override
  String get letOthersKnowRead => 'Let others know you\'ve read their messages';

  @override
  String get typingStatus => 'Typing status';

  @override
  String get letOthersKnowTyping => 'Let others know you\'re typing';

  @override
  String get everyone => 'Everyone';

  @override
  String get contactsOnly => 'Contacts only';

  @override
  String get nobody => 'Nobody';

  @override
  String whoCanSeeItem(String title) {
    return 'Who can see $title';
  }

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get checkUpdate => 'Check for updates';

  @override
  String get openSourceLicenses => 'Open source licenses';

  @override
  String get feedback => 'Feedback';

  @override
  String get builtOnMatrix => 'Built on Matrix protocol';

  @override
  String get loading => 'Loading...';

  @override
  String get noConversations => 'No conversations';

  @override
  String get tapToChat => 'Tap the top right to start chatting';

  @override
  String get startGroup => 'Start Group Chat';

  @override
  String get scan => 'Scan';

  @override
  String get payment => 'Payment';

  @override
  String featureComingSoon(String feature) {
    return '$feature coming soon';
  }

  @override
  String get markAsRead => 'Mark as read';

  @override
  String get unmute => 'Unmute';

  @override
  String get mute => 'Mute';

  @override
  String get unpin => 'Unpin';

  @override
  String get pin => 'Pin';

  @override
  String get deleteConversation => 'Delete Conversation';

  @override
  String deleteConversationConfirm(String name) {
    return 'Delete conversation with \"$name\"?';
  }

  @override
  String get noContacts => 'No contacts';

  @override
  String get addFriendsToChat => 'Add friends to start chatting';

  @override
  String get contactNotFound => 'Contact not found';

  @override
  String get tryOtherKeywords => 'Try other keywords or global search';

  @override
  String get searchResults => 'Search results';

  @override
  String get newFriends => 'New Friends';

  @override
  String get chatOnlyFriends => 'Chat-only friends';

  @override
  String get officialAccounts => 'Official Accounts';

  @override
  String get serviceAccounts => 'Service Accounts';

  @override
  String get enterpriseContacts => 'Enterprise Contacts';

  @override
  String contactsCount(int count) {
    return '$count contacts';
  }

  @override
  String get recommendToFriend => 'Recommend to friend';

  @override
  String get setRemark => 'Set remark';

  @override
  String get addToHome => 'Add to home screen';

  @override
  String get sendingCard => 'Sending contact card...';

  @override
  String get contactCard => '[Contact Card]';

  @override
  String cardSent(String contact, String friend) {
    return 'Sent $contact\'s card to $friend';
  }

  @override
  String recommendFailed(String error) {
    return 'Recommend failed: $error';
  }

  @override
  String get enterRemark => 'Enter remark';

  @override
  String remarkSet(String remark) {
    return 'Remark set to: $remark';
  }

  @override
  String get openingChat => 'Opening chat...';

  @override
  String openChatFailed(String error) {
    return 'Failed to open chat: $error';
  }

  @override
  String get addContact => 'Add Contact';

  @override
  String get enterUserId => 'Enter user ID';

  @override
  String get noFriendRequests => 'No friend requests';

  @override
  String get accept => 'Accept';

  @override
  String get reject => 'Reject';

  @override
  String acceptedRequest(String name) {
    return 'Accepted $name\'s friend request';
  }

  @override
  String rejectedRequest(String name) {
    return 'Rejected $name\'s friend request';
  }

  @override
  String get noGroups => 'No groups';

  @override
  String get creatingGroup => 'Group creation coming soon...';

  @override
  String get selectFriendToRecommend => 'Select a friend to recommend to';

  @override
  String get searchContacts => 'Search contacts';

  @override
  String get noContactsFound => 'No contacts found';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get monday => 'Mon';

  @override
  String get tuesday => 'Tue';

  @override
  String get wednesday => 'Wed';

  @override
  String get thursday => 'Thu';

  @override
  String get friday => 'Fri';

  @override
  String get saturday => 'Sat';

  @override
  String get sunday => 'Sun';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(int count) {
    return '$count min ago';
  }

  @override
  String hoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String daysAgo(int count) {
    return '${count}d ago';
  }

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String minutesAgoOnline(int count) {
    return 'Online $count min ago';
  }

  @override
  String hoursAgoOnline(int count) {
    return 'Online ${count}h ago';
  }

  @override
  String daysAgoOnline(int count) {
    return 'Online ${count}d ago';
  }

  @override
  String get searchContactsGroupsMessages => 'Search contacts, groups, messages';

  @override
  String get searchError => 'Search error';

  @override
  String get searchHint => 'Search contacts, groups, and messages';

  @override
  String get enterKeyword => 'Enter keywords to search';

  @override
  String get searchHistory => 'Search History';

  @override
  String get clear => 'Clear';

  @override
  String noResultsFor(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get all => 'All';

  @override
  String get groups => 'Groups';

  @override
  String get noResults => 'No results';

  @override
  String get groupInfo => 'Group Info';

  @override
  String groupMembers(int count) {
    return 'Members ($count)';
  }

  @override
  String get viewAll => 'View all';

  @override
  String get owner => 'Owner';

  @override
  String get admin => 'Admin';

  @override
  String get invite => 'Invite';

  @override
  String get groupAnnouncement => 'Group Announcement';

  @override
  String get notSet => 'Not set';

  @override
  String get groupDescription => 'Group Description';

  @override
  String get publicGroup => 'Public Group';

  @override
  String get allowSearchJoin => 'Allow others to search and join';

  @override
  String get clearChatHistory => 'Clear Chat History';

  @override
  String get dissolveGroup => 'Dissolve Group';

  @override
  String get leaveGroup => 'Leave Group';

  @override
  String get changeGroupName => 'Change Group Name';

  @override
  String get enterGroupName => 'Enter group name';

  @override
  String get confirm => 'Confirm';

  @override
  String get changeGroupDescription => 'Change Group Description';

  @override
  String get enterGroupDescription => 'Enter group description';

  @override
  String get editAnnouncement => 'Edit Announcement';

  @override
  String get enterAnnouncement => 'Enter announcement';

  @override
  String get publish => 'Publish';

  @override
  String get clearHistoryConfirm => 'Clear all chat history? This cannot be undone.';

  @override
  String get clearAction => 'Clear';

  @override
  String leaveGroupConfirm(String name) {
    return 'Leave \"$name\"?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return 'Dissolve \"$name\"? This cannot be undone.';
  }

  @override
  String get dissolve => 'Dissolve';

  @override
  String get groupQrCode => 'Group QR Code';

  @override
  String get searchChatHistory => 'Search Chat History';

  @override
  String get groupIdCopied => 'Group ID copied';

  @override
  String tapCopyGroupId(int count) {
    return '$count members · Tap to copy Group ID';
  }

  @override
  String featureInDevelopment(Object feature) {
    return '$feature feature in development...';
  }

  @override
  String get receiverAddress => 'Recipient Address';

  @override
  String get enterOrPasteAddress => 'Enter or paste wallet address';

  @override
  String get selectToken => 'Select Token';

  @override
  String get transferAmount => 'Transfer Amount';

  @override
  String get available => 'Available';

  @override
  String get allAmount => 'All';

  @override
  String get memoOptional => 'Memo (optional)';

  @override
  String get addMemo => 'Add a memo';

  @override
  String get confirmTransfer => 'Confirm Transfer';

  @override
  String get invalidAddress => 'Please enter a valid recipient address';

  @override
  String get invalidAmount => 'Please enter a valid amount';

  @override
  String get selectTokenPlease => 'Please select a token';

  @override
  String get addressVerified => 'Address verified';

  @override
  String availableBalance(String balance, String symbol) {
    return 'Available: $balance $symbol';
  }

  @override
  String get scanningInDevelopment => 'Scanning feature in development...';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get redPacketCountMin => 'At least 1 red packet required';

  @override
  String get viewRedPacketDetails => 'View red packet details';

  @override
  String get enterTransferAmount => 'Enter transfer amount';

  @override
  String get transferTo => 'Transfer to';

  @override
  String get selectCurrency => 'Select currency';

  @override
  String get receiveTransfer => 'Received transfer';

  @override
  String fromSender(String senderName) {
    return 'From $senderName';
  }

  @override
  String get confirmReceive => 'Confirm Receipt';

  @override
  String get groupProfile => 'Group Info';

  @override
  String get viewProfile => 'View Profile';

  @override
  String get removeMember => 'Remove from Group';

  @override
  String removeMemberConfirm(String name) {
    return 'Remove \"$name\" from the group?';
  }

  @override
  String get remove => 'Remove';

  @override
  String get clearStatus => 'Clear Status';

  @override
  String get clearStatusConfirm => 'Clear current status?';

  @override
  String get statusCleared => 'Status cleared';

  @override
  String statusSet(String result) {
    return 'Status set to: $result';
  }

  @override
  String get userNotExist => 'User does not exist';

  @override
  String get userIdCopied => 'User ID copied';

  @override
  String get voiceCallInDevelopment => 'Voice call in development...';

  @override
  String get report => 'Report';

  @override
  String get reportInDevelopment => 'Report feature in development...';

  @override
  String get shareCard => 'Share Card';

  @override
  String get shareInDevelopment => 'Share feature in development...';

  @override
  String get qrCode => 'QR Code';

  @override
  String get qrCodeInDevelopment => 'QR code feature in development...';

  @override
  String get avatarUpdated => 'Avatar updated';

  @override
  String selectImageFailed(String error) {
    return 'Failed to select image: $error';
  }

  @override
  String get changeName => 'Change Name';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String genderSet(String gender) {
    return 'Gender set to: $gender';
  }

  @override
  String regionSet(String region) {
    return 'Region set to: $region';
  }

  @override
  String get setPatText => 'Set Pat Text';

  @override
  String get changeSignature => 'Change Signature';

  @override
  String ringtoneSet(String result) {
    return 'Ringtone set to: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature in development...';
  }

  @override
  String saveAddressFailed(String error) {
    return 'Failed to save address: $error';
  }

  @override
  String get myAddress => 'My Address';

  @override
  String get addNew => 'Add';

  @override
  String get addAddress => 'Add Address';

  @override
  String get addressAdded => 'Address added';

  @override
  String get addressUpdated => 'Address updated';

  @override
  String get deleteAddress => 'Delete Address';

  @override
  String get deleteAddressConfirm => 'Delete this address?';

  @override
  String get addressDeleted => 'Address deleted';

  @override
  String get setDefaultAddress => 'Set as default';

  @override
  String get fillCompleteInfo => 'Please fill in all fields';

  @override
  String saveInvoiceFailed(String error) {
    return 'Failed to save invoice: $error';
  }

  @override
  String get myInvoices => 'My Invoices';

  @override
  String get addInvoice => 'Add Invoice';

  @override
  String get invoiceAdded => 'Invoice added';

  @override
  String get invoiceUpdated => 'Invoice updated';

  @override
  String get deleteInvoice => 'Delete Invoice';

  @override
  String get deleteInvoiceConfirm => 'Delete this invoice?';

  @override
  String get invoiceDeleted => 'Invoice deleted';

  @override
  String get invoiceType => 'Invoice type: ';

  @override
  String get personal => 'Personal';

  @override
  String get enterprise => 'Enterprise';

  @override
  String get setDefaultInvoice => 'Set as default';

  @override
  String get enterTaxId => 'Enter tax ID';

  @override
  String get vibrateMode => 'Vibrate mode';

  @override
  String get silentMode => 'Silent mode';

  @override
  String playing(String ringtoneName) {
    return 'Playing: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return 'Failed to play: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'Please enter group name';

  @override
  String get selectAtLeastOne => 'Please select at least one member';

  @override
  String get fillStatus => 'Write Status';

  @override
  String get fileNotExist => 'File does not exist';

  @override
  String sendFailed(String error) {
    return 'Send failed: $error';
  }

  @override
  String get cannotOpenBrowser => 'Cannot open browser';

  @override
  String selectFileFailed(String error) {
    return 'Failed to select file: $error';
  }

  @override
  String get enterMusicLink => 'Enter music link';

  @override
  String get enterValidLink => 'Please enter a valid link';

  @override
  String get enterPollQuestion => 'Enter poll question';

  @override
  String get minTwoOptions => 'At least 2 options required';

  @override
  String get crossDeviceEnabled => 'Cross-device signing enabled';

  @override
  String get crossDeviceSet => 'Cross-device signing set up successfully';

  @override
  String setupFailed(String error) {
    return 'Setup failed: $error';
  }

  @override
  String get receiveAmount => 'Receive Amount';

  @override
  String get enterValidAmount => 'Please enter a valid amount';

  @override
  String get addressCopied => 'Address copied';

  @override
  String openItem(String content) {
    return 'Open: $content';
  }

  @override
  String get newNoteComingSoon => 'New note feature coming soon';

  @override
  String get addLinkComingSoon => 'Add link feature coming soon';

  @override
  String get deleted => 'Deleted';

  @override
  String get shareComingSoon => 'Share feature coming soon';

  @override
  String get saveComingSoon => 'Save feature coming soon';

  @override
  String get moreStylesComingSoon => 'More styles coming soon';

  @override
  String get wallet => 'Wallet';

  @override
  String get walletArea => 'Wallet area';

  @override
  String get recording => 'Recording';

  @override
  String get invalidVideoUrl => 'Invalid video URL';

  @override
  String get downloadFile => 'Download file';

  @override
  String get clearChatHistoryTitle => 'Clear Chat History';

  @override
  String get cannotUndo => 'This cannot be undone';

  @override
  String get videoCall => 'Video Call';

  @override
  String get voiceCall => 'Voice Call';

  @override
  String get leaveMeeting => 'Leave Meeting';

  @override
  String get chatDetails => 'Chat Details';

  @override
  String get viewAllGroupMembers => 'View all members';

  @override
  String get groupName => 'Group Name';

  @override
  String get groupManagement => 'Group Management';

  @override
  String get myNicknameInGroup => 'My Nickname in Group';

  @override
  String get pinChat => 'Pin Chat';

  @override
  String get strongReminder => 'Strong Reminder';

  @override
  String get setChatBackground => 'Set Chat Background';

  @override
  String get unknownFile => 'Unknown file';

  @override
  String get download => 'Download';

  @override
  String get invalidLocation => 'Invalid location';

  @override
  String get address => 'Address';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get close => 'Close';

  @override
  String get tapToCancel => 'Tap to cancel';

  @override
  String captureFailed(Object error) {
    return 'Capture failed: $error';
  }

  @override
  String get processingVideo => 'Processing video...';

  @override
  String get videoFileNotExist => 'Video file does not exist';

  @override
  String get videoDataEmpty => 'Video data is empty';

  @override
  String get videoTooLarge => 'Video size cannot exceed 100MB';

  @override
  String get sendingVideo => 'Sending video...';

  @override
  String sendVideoFailed(Object error) {
    return 'Failed to send video: $error';
  }

  @override
  String get imageFileNotExist => 'Image file does not exist';

  @override
  String get imageDataEmpty => 'Image data is empty';

  @override
  String get sendingImage => 'Sending image...';

  @override
  String sendImageFailed(Object error) {
    return 'Failed to send image: $error';
  }

  @override
  String get sendLocation => 'Send Location';

  @override
  String get selectLocationAndSend => 'Select location and send';

  @override
  String get shareRealTimeLocation => 'Share Real-time Location';

  @override
  String get shareLocationForOneHour => 'Share real-time location with friend for 1 hour';

  @override
  String get locationSent => 'Location sent';

  @override
  String get selectMessages => 'Select messages';

  @override
  String selectedCount(Object count) {
    return 'Selected $count';
  }

  @override
  String get selectAll => 'Select All';

  @override
  String groupChatCount(Object count) {
    return 'Group Chat ($count)';
  }

  @override
  String get privateChat => 'Private Chat';

  @override
  String get noMessages => 'No messages';

  @override
  String get sendFirstMessage => 'Send first message to start chatting';

  @override
  String get encryptionNotice => 'This chat is end-to-end encrypted. Only you and the recipient can read the messages.';

  @override
  String replyTo(Object name) {
    return 'Reply to $name';
  }

  @override
  String get multiForward => 'Forward';

  @override
  String get collect => 'Collect';

  @override
  String get noMembers => 'No members';

  @override
  String get memberNotFound => 'Member not found';

  @override
  String get voiceFileNotExist => 'Voice file does not exist';

  @override
  String get voiceFileEmpty => 'Voice file is empty';

  @override
  String get sendingVoice => 'Sending voice...';

  @override
  String sendVoiceFailed(Object error) {
    return 'Failed to send voice: $error';
  }

  @override
  String get messageCopied => 'Message copied';

  @override
  String get messageForwarded => 'Message forwarded';

  @override
  String forwardFailed(Object error) {
    return 'Forward failed: $error';
  }

  @override
  String get unfavorited => 'Unfavorited';

  @override
  String get favorited => 'Favorited';

  @override
  String get reactionAdded => 'Reaction added';

  @override
  String get failedMessageDeleted => 'Failed message deleted';

  @override
  String get deleteMessages => 'Delete messages';

  @override
  String deleteMessagesConfirm(Object count) {
    return 'Are you sure you want to delete $count messages?';
  }

  @override
  String noteOtherMessages(Object count) {
    return 'Note: $count messages are from others, can only delete locally.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '$count messages from you will be recalled.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return 'Recalled $count messages, deleted $localCount locally';
  }

  @override
  String recalledMessages(Object count) {
    return 'Recalled $count messages';
  }

  @override
  String deletedLocally(Object count) {
    return 'Deleted $count messages (locally)';
  }

  @override
  String forwardedCount(Object count) {
    return 'Forwarded $count messages';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return 'Forward complete: $success succeeded, $failed failed';
  }

  @override
  String get remindOnlyInGroup => 'Remind feature is only available in group chat';

  @override
  String get onlyTextSearchable => 'Only text messages can be searched';

  @override
  String searchFor(Object text) {
    return 'Search \"$text\"';
  }

  @override
  String get baiduSearch => 'Baidu Search';

  @override
  String get googleSearch => 'Google Search';

  @override
  String get bingSearch => 'Bing Search';

  @override
  String get calling => 'Calling...';

  @override
  String get connecting => 'Connecting...';

  @override
  String get ringing => 'Ringing...';

  @override
  String get inCall => 'In call';

  @override
  String collectMessages(Object count) {
    return 'Collected $count messages';
  }

  @override
  String get voted => 'Voted';

  @override
  String get endPoll => 'End Poll';

  @override
  String get endPollConfirm => 'Are you sure you want to end this poll? No more votes can be cast after ending.';

  @override
  String memberCount(Object count) {
    return '$count members';
  }
}
