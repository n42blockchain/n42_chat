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
  String get checkNetworkRetry =>
      'Please check your network connection and try again';

  @override
  String get retry => 'Retry';

  @override
  String get unknownUser => 'Unknown User';

  @override
  String get walletNotConnected => 'Wallet Not Connected';

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
  String get additionalVerificationRequired =>
      'Additional verification required';

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
  String get selectEmoji => 'Select Emoji';

  @override
  String get frequentlyUsed => 'Frequently Used';

  @override
  String get copy => 'Copy';

  @override
  String get forward => 'Forward';

  @override
  String get unfavorite => 'Unfav';

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
  String get microphonePermissionRequired =>
      'Please allow microphone permission';

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
  String conversationWithId(String roomId) {
    return 'Conversation: $roomId';
  }

  @override
  String contactWithId(String userId) {
    return 'Contact: $userId';
  }

  @override
  String get addFriend => 'Add Friend';

  @override
  String get chatServiceNotConnected => 'Chat service not connected';

  @override
  String userNotFoundHint(String query) {
    return 'User \"$query\" not found\n\nTips:\n• Try entering full user ID, e.g. @username:server.com\n• Check the username spelling';
  }

  @override
  String createChatFailed(String error) {
    return 'Failed to create chat: $error';
  }

  @override
  String searchFailed(String error) {
    return 'Search failed: $error';
  }

  @override
  String get enterUserIdOrUsername => 'Enter user ID or username to search';

  @override
  String get searching => 'Searching...';

  @override
  String get searchUserToChat => 'Search user to start chatting';

  @override
  String get matrixIdExample =>
      'You can enter a full Matrix ID\ne.g. @user:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return 'User \"$username\" not found';
  }

  @override
  String get chat => 'Chat';

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
  String get goodLuck => 'Good luck';

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
  String get selectForwardTarget => 'Select Forward Target';

  @override
  String sendCount(int count) {
    return 'Send($count)';
  }

  @override
  String get draft => '[Draft] ';

  @override
  String n42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get n42IdTitle => 'N42 ID';

  @override
  String get n42Bean => 'N42 Bean';

  @override
  String get friendInfo => 'Friend Info';

  @override
  String get friendInfoDesc =>
      'Add friend\'s remark, phone, tags, notes, photos and set permissions.';

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
  String get showContentInNotification =>
      'Show message content in notifications';

  @override
  String get notificationSound => 'Notification Sound';

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
  String get startTime => 'Start Time';

  @override
  String get endTime => 'End Time';

  @override
  String get privacy => 'Privacy';

  @override
  String get appearance => 'Appearance';

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
  String get endToEndEncryption => 'End-to-End Encryption';

  @override
  String get messagesOnlyYouCanSee =>
      'Messages visible only to you and the recipient';

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
  String get usernameHint => '3-20 chars, letters/numbers/_';

  @override
  String get usernameMinLength => 'Username must be at least 3 characters';

  @override
  String get usernameMaxLength => 'Username must be at most 20 characters';

  @override
  String get usernameFormat =>
      'Username can only contain letters, numbers, and underscores';

  @override
  String get passwordHint => 'Min 8 characters';

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
  String get inviteCodeHint =>
      'Invite code is built-in, usually no need to modify';

  @override
  String get agreeTermsFirst =>
      'Please read and agree to the terms and privacy policy first';

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
  String get lastSeen => 'Last Seen';

  @override
  String get messageSettings => 'Messages';

  @override
  String get allowStrangerMessage => 'Allow messages from strangers';

  @override
  String get receiveNonContact => 'Receive messages from non-contacts';

  @override
  String get readReceipts => 'Read Receipts';

  @override
  String get letOthersKnowRead => 'Let others know you\'ve read their messages';

  @override
  String get typingStatus => 'Typing status';

  @override
  String get letOthersKnowTyping => 'Let others know you\'re typing';

  @override
  String get everyone => 'Everyone';

  @override
  String get contactsOnly => 'Contacts Only';

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
  String get openSourceLicenses => 'Open Source Licenses';

  @override
  String get feedback => 'Feedback';

  @override
  String get builtOnMatrix => 'Built on Matrix Protocol';

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
  String get recommendToFriend => 'Share contact';

  @override
  String get setRemark => 'Set remark';

  @override
  String get addToHome => 'Add to home screen';

  @override
  String get sendingCard => 'Sending contact card...';

  @override
  String get contactCard => '[Contact Card]';

  @override
  String get fileLabel => 'File';

  @override
  String get locationLabel => 'Location';

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
  String get searchContactsGroupsMessages =>
      'Search contacts, groups and messages';

  @override
  String get searchError => 'Search Error';

  @override
  String get searchHint => 'Search';

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
  String get noResults => 'No Results';

  @override
  String get groupInfo => 'Group Info';

  @override
  String groupMembers(int count) {
    return 'Members ($count)';
  }

  @override
  String get groupMembersTitle => 'Group Members';

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
  String get clearHistoryConfirm =>
      'Clear all chat history? This cannot be undone.';

  @override
  String get clearAction => 'Clear';

  @override
  String get chatHistoryCleared => 'Chat history cleared';

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
  String get viewRedPacketDetails => 'View Red Packet Details';

  @override
  String get enterTransferAmount => 'Please enter transfer amount';

  @override
  String get transferTo => 'Transfer to';

  @override
  String get selectCurrency => 'Select currency';

  @override
  String get receiveTransfer => 'Received transfer';

  @override
  String fromSender(String name, Object senderName) {
    return 'From $name';
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
    return '$feature feature in development...';
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
  String get invoiceType => 'Invoice Type';

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
  String get groupNameUpdated => 'Group name updated';

  @override
  String get updateFailed => 'Update failed';

  @override
  String get noPermissionToModify => 'You do not have permission to modify';

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
  String get shareLocationForOneHour =>
      'Share real-time location with friend for 1 hour';

  @override
  String get locationSent => 'Location sent';

  @override
  String get selectMessages => 'Select messages';

  @override
  String selectedCount(int count) {
    return 'Selected $count';
  }

  @override
  String get selectAll => 'Select All';

  @override
  String groupChatCount(int count) {
    return 'Group Chat($count)';
  }

  @override
  String get privateChat => 'Private Chat';

  @override
  String get noMessages => 'No messages';

  @override
  String get sendFirstMessage => 'Send the first message to start chatting';

  @override
  String get encryptionNotice =>
      'This chat is end-to-end encrypted. Only you and the recipient can read the messages.';

  @override
  String replyTo(String name) {
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
  String get remindOnlyInGroup =>
      'Remind feature is only available in group chat';

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
  String featureInDevelopment(String feature) {
    return '$feature feature in development...';
  }

  @override
  String collectMessages(Object count) {
    return 'Collected $count messages';
  }

  @override
  String get voted => 'Voted';

  @override
  String get voteChanged => 'Vote changed';

  @override
  String get voteRemoved => 'Vote removed';

  @override
  String get endPoll => 'End Poll';

  @override
  String get endPollConfirm =>
      'Are you sure you want to end this poll? No more votes can be cast after ending.';

  @override
  String memberCount(int count) {
    return '$count members';
  }

  @override
  String get videoChannels => 'Channels';

  @override
  String get live => 'Live';

  @override
  String get listen => 'Listen';

  @override
  String get watch => 'Watch';

  @override
  String get searchDiscover => 'Search';

  @override
  String get nearbyPeople => 'Nearby';

  @override
  String get games => 'Games';

  @override
  String get miniPrograms => 'Mini Programs';

  @override
  String done(int count) {
    return 'Done($count)';
  }

  @override
  String get services => 'Services';

  @override
  String get favorites => 'Favorites';

  @override
  String get ordersAndCards => 'Orders & Cards';

  @override
  String get stickers => 'Stickers';

  @override
  String statusSetTo(String status) {
    return 'Status set to: $status';
  }

  @override
  String get avatarUploadFailed => 'Avatar upload failed';

  @override
  String get personalProfile => 'Personal Profile';

  @override
  String get name => 'Name';

  @override
  String get gender => 'Gender';

  @override
  String get region => 'Region';

  @override
  String get myQrCode => 'My QR Code';

  @override
  String get poke => 'Poke';

  @override
  String get ringtone => 'Ringtone';

  @override
  String get defaultRingtone => 'Default Ringtone';

  @override
  String get myAddresses => 'My Addresses';

  @override
  String genderSetTo(String gender) {
    return 'Gender set to: $gender';
  }

  @override
  String get selectRegion => 'Select Region';

  @override
  String get selectCity => 'Select City';

  @override
  String regionSetTo(String region) {
    return 'Region set to: $region';
  }

  @override
  String get setPoke => 'Set Poke';

  @override
  String get friendPokedMe => 'Friend poked me';

  @override
  String get enterPokeSuffix => 'Enter poke suffix, e.g.: on the shoulder';

  @override
  String get example => 'Example';

  @override
  String get onTheShoulder => ' on the shoulder';

  @override
  String get pokeCleared => 'Poke cleared';

  @override
  String pokeSetTo(String suffix) {
    return 'Poke set to: poked me$suffix';
  }

  @override
  String get editSignature => 'Edit Signature';

  @override
  String get introduceYourself => 'A sentence to introduce yourself';

  @override
  String get signatureCleared => 'Signature cleared';

  @override
  String get signatureUpdated => 'Signature updated';

  @override
  String get scanToAddFriend => 'Scan the QR code above to add me as a friend';

  @override
  String ringtoneSetTo(String ringtone) {
    return 'Ringtone set to: $ringtone';
  }

  @override
  String confirmDissolveGroup(String name) {
    return 'Are you sure you want to dissolve \"$name\"? This action cannot be undone.';
  }

  @override
  String get enterValidServerAddress => 'Please enter a valid server address';

  @override
  String get emailOtp => 'Email OTP';

  @override
  String get enterServerAddressFirst => 'Please enter server address first';

  @override
  String get passkeyRequiresServer => 'Passkey login requires server support';

  @override
  String get loginAgreement => 'By logging in, you agree to ';

  @override
  String get pleaseAgreeToTerms =>
      'Please read and agree to the Terms of Service and Privacy Policy';

  @override
  String get registerFailed => 'Registration failed';

  @override
  String get reenterPassword => 'Re-enter password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get inviteCodeBuiltIn => 'Invite Code (Built-in)';

  @override
  String get inviteCodeBuiltInNote =>
      'Invite code is built-in, usually no need to modify';

  @override
  String get iHaveReadAndAgree => 'I have read and agree to ';

  @override
  String get startGroupChat => 'Start Group Chat';

  @override
  String get addFriends => 'Add Friends';

  @override
  String get paymentAndCollection => 'Payment';

  @override
  String messagesWithCount(int count) {
    return 'Messages($count)';
  }

  @override
  String contactCount(int count) {
    return '$count contacts';
  }

  @override
  String get addToHomeScreen => 'Add to home screen';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return 'Recommended $contact\'s card to $recipient';
  }

  @override
  String get enterRemarkName => 'Enter remark name';

  @override
  String remarkSetTo(String remark) {
    return 'Remark set to: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return 'Accepted $name\'s friend request';
  }

  @override
  String rejectedFriendRequest(String name) {
    return 'Rejected $name\'s friend request';
  }

  @override
  String get groupInvites => 'Group Invites';

  @override
  String myGroups(int count) {
    return 'My Groups ($count)';
  }

  @override
  String get invitedToJoinGroup => 'Invited to join group';

  @override
  String confirmLeaveGroup(String name) {
    return 'Are you sure you want to leave \"$name\"?';
  }

  @override
  String get leave => 'Leave';

  @override
  String get saveMedia => 'Save';

  @override
  String get recallThisMessage => 'Recall this message?';

  @override
  String get messageRecalled => 'Message recalled';

  @override
  String get savedToGallery => 'Saved to gallery';

  @override
  String get failedToSave => 'Failed to save';

  @override
  String get saving => 'Saving...';

  @override
  String get share => 'Share';

  @override
  String get saveToGallery => 'Save to Gallery';

  @override
  String downloadFailed(String code) {
    return 'Download failed: $code';
  }

  @override
  String get noMediaUrl => 'No media URL available';

  @override
  String shareFailed(String error) {
    return 'Share failed: $error';
  }

  @override
  String get failedToLoadImage => 'Failed to load image';

  @override
  String get failedToLoadMoreMessages => 'Failed to load more messages';

  @override
  String get failedToSend => 'Failed to send';

  @override
  String get failedToSendImage => 'Failed to send image';

  @override
  String get failedToSendVoice => 'Failed to send voice';

  @override
  String get failedToSendFile => 'Failed to send file';

  @override
  String get failedToSendVideo => 'Failed to send video';

  @override
  String get failedToSendLocation => 'Failed to send location';

  @override
  String get failedToResend => 'Failed to resend';

  @override
  String get failedToRecall => 'Failed to recall';

  @override
  String get failedToReply => 'Failed to reply';

  @override
  String get failedToAddReaction => 'Failed to add reaction';

  @override
  String get failedToSendPoll => 'Failed to send poll';

  @override
  String get failedToVote => 'Failed to vote';

  @override
  String get failedToLoadMessages => 'Failed to load messages';

  @override
  String get callFeatureComingSoon =>
      'Voice and video call feature coming soon';

  @override
  String get cannotForwardRedPacketOrTransfer =>
      'Red envelopes and transfers cannot be forwarded';

  @override
  String get videoRecordingFailed => 'Video recording failed';

  @override
  String get redPacket => 'Red Packet';

  @override
  String get music => 'Music';

  @override
  String get coupon => 'Coupon';

  @override
  String get gift => 'Gift';

  @override
  String get poll => 'Poll';

  @override
  String get text => 'Text';

  @override
  String get link => 'Link';

  @override
  String get note => 'Note';

  @override
  String get myNotes => 'My Notes';

  @override
  String get today => 'Today';

  @override
  String daysAgoText(int count) {
    return '$count days ago';
  }

  @override
  String dateFormat(int month, int day) {
    return '$month/$day';
  }

  @override
  String get noFavorites => 'No favorites yet';

  @override
  String get longPressToFavorite => 'Long press message to favorite';

  @override
  String get newNote => 'New Note';

  @override
  String get favoriteLink => 'Favorite Link';

  @override
  String get editTags => 'Edit Tags';

  @override
  String get deleteFavorite => 'Delete Favorite';

  @override
  String get deleteFavoriteConfirm =>
      'Are you sure you want to delete this favorite?';

  @override
  String get noSearchResultsFound => 'No results found';

  @override
  String get sendRedPacket => 'Send Red Packet';

  @override
  String get amount => 'Amount';

  @override
  String get redPacketCover => 'Red Packet Cover';

  @override
  String get redPacketType => 'Red Packet Type';

  @override
  String get normalRedPacket => 'Normal';

  @override
  String get luckyRedPacket => 'Lucky';

  @override
  String get redPacketCount => 'Red Packet Count';

  @override
  String get pieces => 'pieces';

  @override
  String get putMoneyInRedPacket => 'Put money in red packet';

  @override
  String get redPacketRefundNotice =>
      'Unclaimed red packets will be refunded after 24 hours';

  @override
  String get openRedPacket => 'Open';

  @override
  String get redPacketAllClaimed => 'Red packet all claimed';

  @override
  String get redPacketExpired => 'Red packet expired';

  @override
  String get addTransferNote => 'Add transfer note';

  @override
  String get yuan => 'CNY';

  @override
  String get savedToChangeCanTransfer =>
      'Saved to balance, can transfer directly';

  @override
  String get replyWithEmoji => 'Reply with this emoji';

  @override
  String get claimedYourRedPacket => 'claimed your';

  @override
  String get claimedRedPacket => 'claimed';

  @override
  String get otherTyping => 'typing...';

  @override
  String get processing => 'Processing...';

  @override
  String get transferCancelled => 'Transfer cancelled';

  @override
  String get transferFailed => 'Transfer failed';

  @override
  String get creatingPaymentRequest => 'Creating payment request...';

  @override
  String get processingPayment => 'Processing payment...';

  @override
  String get paymentFailed => 'Payment failed';

  @override
  String get clickRetry => 'Tap to retry';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get editRemark => 'Edit Remark';

  @override
  String get setPermissions => 'Set Permissions';

  @override
  String get recommendToFriends => 'Recommend to Friends';

  @override
  String get setStarFriend => 'Set as Star Friend';

  @override
  String get addToBlacklist => 'Add to Blacklist';

  @override
  String get complain => 'Report';

  @override
  String get deleteContact => 'Delete Contact';

  @override
  String deleteContactConfirm(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get transferTitle => 'Transfer';

  @override
  String get receiverAddressLabel => 'Recipient Address';

  @override
  String get selectTokenLabel => 'Select Token';

  @override
  String get transferAmountLabel => 'Transfer Amount';

  @override
  String get memoLabel => 'Memo (optional)';

  @override
  String get enterOrPasteAddressHint => 'Enter or paste wallet address';

  @override
  String get scanInDevelopment => 'Scanning feature in development...';

  @override
  String get availableLabel => 'Available';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return 'Available: $balance $symbol';
  }

  @override
  String get addMemoHint => 'Add a memo';

  @override
  String get receiveTitle => 'Receive';

  @override
  String get walletNotConnectedTitle => 'Wallet not connected';

  @override
  String get connectWalletFirst => 'Please connect wallet first';

  @override
  String get sendPaymentRequest => 'Send Payment Request';

  @override
  String get qrCodeGenerateFailed => 'QR code generation failed';

  @override
  String get scanQrToPayMe => 'Scan QR code to pay me';

  @override
  String get myWalletAddress => 'My Wallet Address';

  @override
  String get createPaymentRequest => 'Create Payment Request';

  @override
  String get selectTokenHint => 'Select Token';

  @override
  String get amountLabel => 'Amount';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get sendRequestButton => 'Send Request';

  @override
  String get allReadReceipt => 'All read';

  @override
  String readCountReceipt(int count) {
    return '$count read';
  }

  @override
  String n42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get redPacketDefaultGreeting => 'Best wishes';

  @override
  String senderRedPacket(String name) {
    return '$name\'s Red Packet';
  }

  @override
  String get allButton => 'All';

  @override
  String get enterValidAddress => 'Please enter a valid address';

  @override
  String get pleaseSelectToken => 'Please select a token';

  @override
  String get receivedTransfer => 'Received Transfer';

  @override
  String get selectForwardRecipient => 'Select forward recipient';

  @override
  String get emojiFaces => 'Faces';

  @override
  String get emojiHearts => 'Hearts';

  @override
  String get emojiAnimals => 'Animals';

  @override
  String get emojiFood => 'Food';

  @override
  String get emojiTransport => 'Transport';

  @override
  String get emojiActivities => 'Activities';

  @override
  String get emojiObjects => 'Objects';

  @override
  String get emojiSymbols => 'Symbols';

  @override
  String get transferProcessing => 'Processing transfer...';

  @override
  String senderSentRedPacket(String name) {
    return '$name sent a red packet';
  }

  @override
  String get savedToBalance => 'Saved to balance, can transfer directly';

  @override
  String get redPacketExpiredOrEmpty => 'Red packet expired/all claimed';

  @override
  String get scanFeatureComingSoon => 'Scan feature coming soon...';

  @override
  String get setAsStarred => 'Set as Starred';

  @override
  String get addToBlocklist => 'Add to Blocklist';

  @override
  String get claimedYour => ' claimed your ';

  @override
  String get claimedText => ' claimed ';

  @override
  String userTyping(String name) {
    return '$name is typing...';
  }

  @override
  String get typing => 'Typing...';

  @override
  String get waitingToReceive => 'Waiting to receive';

  @override
  String get tapToClaim => 'Tap to claim';

  @override
  String get hasBeenReceived => 'Has been received';

  @override
  String get getLucky => 'Get lucky';

  @override
  String get cameraStartFailed => 'Camera failed to start';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get placeQrCodeInFrame => 'Place QR code within the frame to scan';

  @override
  String get closeManualInput => 'Close Manual Input';

  @override
  String get manualInputUserId => 'Manual Input User ID';

  @override
  String get add => 'Add';

  @override
  String get ringtoneClear => 'Clear';

  @override
  String get ringtonePhone => 'Phone';

  @override
  String get ringtoneClassic => 'Classic';

  @override
  String get ringtoneSoft => 'Soft';

  @override
  String get ringtoneVibrate => 'Vibrate';

  @override
  String get ringtoneSilent => 'Silent';

  @override
  String get stop => 'Stop';

  @override
  String get selectRingtone => 'Select Ringtone';

  @override
  String get loadingRingtones => 'Loading ringtones...';

  @override
  String get noRingtonesFound => 'No ringtones found';

  @override
  String get moodAndThoughts => 'Mood & Thoughts';

  @override
  String get statusHappy => 'Happy';

  @override
  String get statusCracked => 'Shattered';

  @override
  String get statusLucky => 'Lucky';

  @override
  String get statusSunny => 'Sunny';

  @override
  String get statusTired => 'Tired';

  @override
  String get statusDaydream => 'Daydream';

  @override
  String get statusRushing => 'Rushing';

  @override
  String get statusOverthinking => 'Overthinking';

  @override
  String get statusEnergized => 'Energized';

  @override
  String get workAndStudy => 'Work & Study';

  @override
  String get statusWorking => 'Working';

  @override
  String get statusStudying => 'Studying';

  @override
  String get statusBusy => 'Busy';

  @override
  String get statusSlacking => 'Slacking';

  @override
  String get statusTraveling => 'Traveling';

  @override
  String get statusGoingHome => 'Going Home';

  @override
  String get statusDnd => 'Do Not Disturb';

  @override
  String get statusHanging => 'Hanging Out';

  @override
  String get statusCheckIn => 'Check In';

  @override
  String get statusExercising => 'Exercising';

  @override
  String get statusCoffee => 'Coffee';

  @override
  String get statusBubbleTea => 'Bubble Tea';

  @override
  String get statusEating => 'Eating';

  @override
  String get statusParenting => 'Parenting';

  @override
  String get statusSavingWorld => 'Saving World';

  @override
  String get statusSelfie => 'Selfie';

  @override
  String get rest => 'Rest';

  @override
  String get statusRetreat => 'Retreat';

  @override
  String get statusHome => 'Home';

  @override
  String get statusSleeping => 'Sleeping';

  @override
  String get statusCatLover => 'Cat Lover';

  @override
  String get statusDogWalking => 'Walking Dog';

  @override
  String get statusGaming => 'Gaming';

  @override
  String get statusListening => 'Listening';

  @override
  String get setStatus => 'Set Status';

  @override
  String get visibleToFriends24h => 'Visible to friends for 24 hours';

  @override
  String get writeStatus => 'Write Status';

  @override
  String get enterYourStatus => 'Enter your status...';

  @override
  String get ok => 'OK';

  @override
  String get cameraPermissionRequired =>
      'Camera permission is required to scan QR code';

  @override
  String get cameraPermissionDenied =>
      'Camera permission was permanently denied. Please enable it in system settings.';

  @override
  String get cannotGetCameraPermission => 'Cannot get camera permission';

  @override
  String permissionCheckError(String error) {
    return 'Error checking permission: $error';
  }

  @override
  String get invalidQrCode => 'Invalid QR code';

  @override
  String qrCodeProcessFailed(String error) {
    return 'Failed to process QR code: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return 'Cannot add friend: $error';
  }

  @override
  String get scanQrCode => 'Scan QR Code';

  @override
  String get checkingCameraPermission => 'Checking camera permission...';

  @override
  String get needCameraPermission => 'Camera Permission Required';

  @override
  String get retryPermission => 'Retry';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get inviteMembers => 'Invite Members';

  @override
  String inviteCount(int count) {
    return 'Invite($count)';
  }

  @override
  String get noShippingAddress => 'No shipping address';

  @override
  String get defaultLabel => 'Default';

  @override
  String get editAddress => 'Edit Address';

  @override
  String get recipient => 'Recipient';

  @override
  String get enterRecipientName => 'Enter recipient name';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get enterPhoneNumber => 'Enter phone number';

  @override
  String get regionHint => 'Province/City/District';

  @override
  String get detailedAddress => 'Detailed Address';

  @override
  String get detailedAddressHint => 'Street, building number, etc.';

  @override
  String get setAsDefaultAddress => 'Set as default address';

  @override
  String get pleaseCompleteInfo => 'Please complete all fields';

  @override
  String get noInvoice => 'No invoice';

  @override
  String get company => 'Company';

  @override
  String get taxNumber => 'Tax Number';

  @override
  String get editInvoice => 'Edit Invoice';

  @override
  String get companyName => 'Company Name';

  @override
  String get enterCompanyName => 'Enter company name';

  @override
  String get personalName => 'Personal Name';

  @override
  String get enterName => 'Enter name';

  @override
  String get taxIdNumber => 'Tax ID Number';

  @override
  String get enterTaxIdNumber => 'Enter tax ID number';

  @override
  String get bankNameOptional => 'Bank Name (Optional)';

  @override
  String get enterBankName => 'Enter bank name';

  @override
  String get bankAccountOptional => 'Bank Account (Optional)';

  @override
  String get enterBankAccount => 'Enter bank account';

  @override
  String get companyAddressOptional => 'Company Address (Optional)';

  @override
  String get enterCompanyAddress => 'Enter company address';

  @override
  String get companyPhoneOptional => 'Company Phone (Optional)';

  @override
  String get enterCompanyPhone => 'Enter company phone';

  @override
  String get setAsDefaultInvoice => 'Set as default invoice';

  @override
  String get confirmDeleteAddress =>
      'Are you sure you want to delete this address?';

  @override
  String get confirmDeleteInvoice =>
      'Are you sure you want to delete this invoice?';

  @override
  String get groupOwner => 'Owner';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get searchMembers => 'Search members';

  @override
  String totalMembers(int count) {
    return '$count members';
  }

  @override
  String get removeFromGroup => 'Remove from Group';

  @override
  String confirmRemoveMember(String name) {
    return 'Are you sure you want to remove \"$name\" from the group?';
  }

  @override
  String get setAsAdmin => 'Set as Admin';

  @override
  String get removeAdmin => 'Remove Admin';

  @override
  String get deleteContactSuccess => 'Contact deleted';

  @override
  String get unknownSong => 'Unknown Song';

  @override
  String get unknownArtist => 'Unknown Artist';

  @override
  String get unknownContact => 'Unknown Contact';

  @override
  String get personalCard => 'Contact Card';

  @override
  String get singleChoice => 'Single';

  @override
  String get multiChoice => 'Multi';

  @override
  String get ended => 'Ended';

  @override
  String get endPollButton => 'End Poll';

  @override
  String get createPoll => 'Create Poll';

  @override
  String get pollQuestion => 'Poll Question';

  @override
  String get pollOptions => 'Poll Options';

  @override
  String optionPlaceholder(int index) {
    return 'Option $index';
  }

  @override
  String get addOption => 'Add Option';

  @override
  String get pollSettings => 'Poll Settings';

  @override
  String get anonymousPoll => 'Anonymous Poll';

  @override
  String get pollHint =>
      'Poll will be displayed in chat. Group members can vote.';

  @override
  String get searchSongOrArtist => 'Search song or artist';

  @override
  String get noSongsFound => 'No songs found';

  @override
  String get supportedMusicPlatforms =>
      'Supports music links from NetEase, QQ Music, etc.';

  @override
  String get songNameOptional => 'Song Name (Optional)';

  @override
  String get enterSongName => 'Enter song name';

  @override
  String get artistNameOptional => 'Artist Name (Optional)';

  @override
  String get enterArtistName => 'Enter artist name';

  @override
  String get shareSong => 'Share Song';

  @override
  String get realTimeLocationSharing =>
      'Real-time location sharing in development...';

  @override
  String get voiceCallFeatureInDev => 'Voice call feature in development...';

  @override
  String get reportFeatureInDev => 'Report feature in development...';

  @override
  String get shareFeatureInDev => 'Share feature in development...';

  @override
  String get qrCodeFeatureInDev => 'QR code feature in development...';

  @override
  String get scanQrToAddMe => 'Scan the QR code above to add me as a friend';

  @override
  String get saveToAlbum => 'Save to Album';

  @override
  String get changeStyle => 'Change Style';

  @override
  String get copyId => 'Copy ID';

  @override
  String get idCopied => 'ID copied';

  @override
  String get shareFeatureComingSoon => 'Share feature coming soon';

  @override
  String get saveFeatureComingSoon => 'Save feature coming soon';

  @override
  String get moreStylesFeatureComingSoon => 'More styles coming soon';

  @override
  String get confirmEndPoll => 'Are you sure you want to end this poll?';

  @override
  String get cannotVoteAfterEnd => 'No more votes can be cast after ending.';

  @override
  String get bio => 'Bio';

  @override
  String get homeServer => 'Server';

  @override
  String get shareContactCard => 'Share Contact Card';

  @override
  String get removeFromBlacklist => 'Remove from Blacklist';

  @override
  String get confirmAddBlacklist =>
      'Are you sure you want to add this user to blacklist? You will not receive messages from them.';

  @override
  String get confirmRemoveBlacklist =>
      'Are you sure you want to remove this user from blacklist?';

  @override
  String get remarkSaved => 'Remark saved';

  @override
  String get remarkCleared => 'Remark cleared';

  @override
  String get receive => 'Receive';

  @override
  String get pleaseConnectWallet => 'Please connect your wallet first';

  @override
  String get sendRequest => 'Send Request';

  @override
  String get pleaseEnterValidAmount => 'Please enter a valid amount';

  @override
  String get searchPlaceholder => 'Search contacts, groups, messages';

  @override
  String get enterKeywordToSearch => 'Enter keyword to start searching';

  @override
  String get clearHistory => 'Clear';

  @override
  String noResultsForQuery(String query) {
    return 'No results found for \"$query\"';
  }

  @override
  String get allResults => 'All';

  @override
  String get searchInChat => 'Search in chat';

  @override
  String get contactLabel => 'Contact';

  @override
  String get groupLabel => 'Group';

  @override
  String get conversationLabel => 'Conversation';

  @override
  String get messageLabel => 'Message';

  @override
  String get securityTitle => 'Security';

  @override
  String get keyBackup => 'Key Backup';

  @override
  String get backupEncryptionKeys => 'Backup Encryption Keys';

  @override
  String keysBackedUp(int count) {
    return '$count keys backed up';
  }

  @override
  String get backupNotSet => 'Backup not set';

  @override
  String get restoreKeys => 'Restore Keys';

  @override
  String get restoreKeysFromBackup => 'Restore encryption keys from backup';

  @override
  String get exportKeys => 'Export Keys';

  @override
  String get exportKeysToFile => 'Export keys to file';

  @override
  String get loggedInDevices => 'Logged In Devices';

  @override
  String get noOtherDevices => 'No other devices';

  @override
  String get verified => 'Verified';

  @override
  String get unverified => 'Unverified';

  @override
  String get advanced => 'Advanced';

  @override
  String get crossSigning => 'Cross-Signing';

  @override
  String get enabled => 'Enabled';

  @override
  String get notEnabled => 'Not enabled';

  @override
  String get resetEncryption => 'Reset Encryption';

  @override
  String get deleteAllEncryptionKeys => 'Delete all encryption keys';

  @override
  String get encryptionNotSupported => 'Encryption not supported';

  @override
  String get notInitialized => 'Not initialized';

  @override
  String get backupKeyTitle => 'Backup Keys';

  @override
  String get backupKeyMessage =>
      'Create a new key backup? This will help you restore encrypted messages on a new device.';

  @override
  String get backup => 'Backup';

  @override
  String get restoreKeyTitle => 'Restore Keys';

  @override
  String get restoreKeyMessage =>
      'Enter your recovery password or recovery key to restore encrypted messages.';

  @override
  String get restore => 'Restore';

  @override
  String get exportKeyTitle => 'Export Keys';

  @override
  String get exportKeyMessage =>
      'The exported key file contains all your encryption keys. Please keep it safe.';

  @override
  String get export => 'Export';

  @override
  String deviceIdLabel(String deviceId) {
    return 'Device ID: $deviceId';
  }

  @override
  String get deviceStatusVerified => 'Status: Verified';

  @override
  String get deviceStatusUnverified => 'Status: Unverified';

  @override
  String lastActiveLabel(String lastSeen) {
    return 'Last active: $lastSeen';
  }

  @override
  String get verifyThisDevice => 'Verify this device';

  @override
  String get crossSigningAlreadyEnabled => 'Cross-signing is already enabled';

  @override
  String get crossSigningSetupSuccess => 'Cross-signing setup successful';

  @override
  String get resetEncryptionTitle => 'Reset Encryption';

  @override
  String get resetEncryptionWarning =>
      'Warning: This will delete all your encryption keys. You will not be able to decrypt previous encrypted messages. This action cannot be undone.';

  @override
  String get reset => 'Reset';

  @override
  String get leaveMeetingConfirm =>
      'Are you sure you want to leave the meeting?';

  @override
  String pokedSomeone(String name, String suffix) {
    return 'poked $name$suffix';
  }

  @override
  String get noContactsToAdd => 'No contacts available to add';

  @override
  String get addMembers => 'Add Members';

  @override
  String invitedMembers(int count) {
    return 'Invited $count members';
  }

  @override
  String inviteFailed(String error) {
    return 'Invite failed: $error';
  }

  @override
  String get memberRemoved => 'Member removed';

  @override
  String removeFailed(String error) {
    return 'Remove failed: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      'After sharing, the other party can see your real-time location for 1 hour.';

  @override
  String get startSharing => 'Start Sharing';

  @override
  String get locationServiceNotEnabled => 'Location service is not enabled';

  @override
  String get enableLocationService =>
      'Please enable location service to use this feature';

  @override
  String get goToSettings => 'Go to Settings';

  @override
  String get locationPermissionRequired =>
      'Location permission is required for this feature';

  @override
  String get locationPermissionDeniedPermanent =>
      'Location permission has been permanently denied. Please enable it in settings.';

  @override
  String get locationPermissionDenied => 'Location permission denied';

  @override
  String get gettingLocation => 'Getting location...';

  @override
  String getLocationFailed(String error) {
    return 'Failed to get location: $error';
  }

  @override
  String get currentLocation => 'Current Location';

  @override
  String nearbyPlace(int index) {
    return 'Nearby Place $index';
  }

  @override
  String approximateDistance(String distance) {
    return 'About $distance';
  }

  @override
  String get mapPreview => 'Map Preview';

  @override
  String get searchLocation => 'Search location';

  @override
  String redPacketSent(String amount, String token) {
    return 'Sent $amount $token red packet';
  }

  @override
  String get transferDefault => 'Transfer';

  @override
  String transferSent(String amount, String token) {
    return 'Sent $amount $token transfer';
  }

  @override
  String pickFileFailed(String error) {
    return 'Failed to pick file: $error';
  }

  @override
  String get fileSizeLimit => 'File size cannot exceed 50MB';

  @override
  String fileSending(String filename) {
    return 'Sending file: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'Failed to send file: $error';
  }

  @override
  String contactCardSent(String name) {
    return 'Sent $name\'s contact card';
  }

  @override
  String get favoritesFeature => 'Favorites';

  @override
  String get couponsFeature => 'Coupons';

  @override
  String get giftFeature => 'Gift';

  @override
  String sharedMusic(String name) {
    return 'Shared $name';
  }

  @override
  String get endPollTitle => 'End Poll';

  @override
  String get endPollConfirmMessage =>
      'Are you sure you want to end this poll? Voting will be closed after ending.';

  @override
  String get pollEndedMessage => 'Poll ended';

  @override
  String get connectingCall => 'Connecting...';

  @override
  String get muteCall => 'Mute';

  @override
  String get speakerOff => 'Speaker Off';

  @override
  String get speakerOn => 'Speaker';

  @override
  String get cameraOn => 'Camera On';

  @override
  String get cameraOff => 'Camera Off';

  @override
  String get hangUp => 'Hang Up';

  @override
  String get selectForwardTargetTitle => 'Select Forward Target';

  @override
  String get noForwardableChat => 'No chats available for forwarding';

  @override
  String get noMatchingChat => 'No matching chats found';

  @override
  String get imagePreview => '[Image]';

  @override
  String get voicePreview => '[Voice]';

  @override
  String get videoPreview => '[Video]';

  @override
  String filePreviewWithName(String filename) {
    return '[File] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[Location] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[Music] $title';
  }

  @override
  String get messagePreview => '[Message]';

  @override
  String get locationTitle => 'Location';

  @override
  String get sendButton => 'Send';

  @override
  String get retryButton => 'Retry';

  @override
  String get selectContact => 'Select Contact';

  @override
  String get searchContactHint => 'Search contacts';

  @override
  String get shareMusic => 'Share Music';

  @override
  String get recentPlayed => 'Recent';

  @override
  String get myFavorites => 'Favorites';

  @override
  String get networkLink => 'Link';

  @override
  String get localFile => 'Local';

  @override
  String get musicLinkRequired => 'Music Link *';

  @override
  String get pasteMusicLink => 'Paste music link';

  @override
  String get enterSongNamePlaceholder => 'Enter song name';

  @override
  String get enterArtistNamePlaceholder => 'Enter artist name';

  @override
  String get shareMusicButton => 'Share Music';

  @override
  String get selectLocalAudio => 'Select Local Audio File';

  @override
  String get supportedAudioFormats => 'Supports MP3, M4A, WAV, FLAC, etc.';

  @override
  String get selectFileButton => 'Select File';

  @override
  String get pleaseEnterMusicLink => 'Please enter music link';

  @override
  String get pleaseEnterValidLink => 'Please enter a valid URL';

  @override
  String get sharedSong => 'Shared Song';

  @override
  String get selectMember => 'Select Member';

  @override
  String get searchMemberHint => 'Search members';

  @override
  String get noMatchingMembers => 'No matching members found';

  @override
  String get unknownMember => 'Unknown';

  @override
  String selectedMessagesCount(int count) {
    return 'Selected $count messages';
  }

  @override
  String get searchContactsOrGroups => 'Search contacts or groups';

  @override
  String get noMatchingConversations => 'No matching conversations found';

  @override
  String get videoTitle => 'Video';

  @override
  String get loadingText => 'Loading...';

  @override
  String get videoPlaybackFailed => 'Video playback failed';

  @override
  String get videoLoadFailed => 'Video load failed';

  @override
  String get playerInitFailed => 'Player initialization failed';

  @override
  String get createPollTitle => 'Create Poll';

  @override
  String get submitPoll => 'Submit';

  @override
  String get pollQuestionLabel => 'Poll Question';

  @override
  String get enterPollQuestionHint => 'Please enter poll question';

  @override
  String get pollOptionsLabel => 'Poll Options';

  @override
  String optionHintWithIndex(int index) {
    return 'Option $index';
  }

  @override
  String get addOptionButton => 'Add Option';

  @override
  String get pollSettingsLabel => 'Poll Settings';

  @override
  String get selectionType => 'Selection Type';

  @override
  String get singleChoiceLabel => 'Single';

  @override
  String get multiChoiceLabel => 'Multi';

  @override
  String get anonymousPollSwitch => 'Anonymous Poll';

  @override
  String get pleaseEnterQuestion => 'Please enter poll question';

  @override
  String get atLeastTwoOptions => 'At least 2 options required';

  @override
  String confirmWithCount(int count) {
    return 'Confirm ($count)';
  }

  @override
  String get emailVerificationTitle => 'Email Verification';

  @override
  String get enterValidEmailAddress => 'Please enter a valid email address';

  @override
  String verificationCodeSentTo(String email) {
    return 'Verification code sent to $email';
  }

  @override
  String sendCodeFailed(String error) {
    return 'Failed to send code: $error';
  }

  @override
  String get verificationSuccess => 'Verification successful';

  @override
  String get verificationFailed => 'Verification failed';

  @override
  String verificationCodeError(String error) {
    return 'Verification code error: $error';
  }

  @override
  String get enterVerificationCode => 'Enter verification code';

  @override
  String get enterYourEmail => 'Enter email';

  @override
  String weSentCodeTo(String email) {
    return 'We sent a 6-digit code to\n$email';
  }

  @override
  String get enterEmailForCode =>
      'Enter your email address, we will send verification code';

  @override
  String get sendVerificationCode => 'Send verification code';

  @override
  String get resendVerificationCode => 'Resend verification code';

  @override
  String canResendAfter(int seconds) {
    return 'Can resend after $seconds seconds';
  }

  @override
  String get changeEmail => 'Change Email';

  @override
  String get addToContacts => 'Add to Contacts';

  @override
  String get addingToContacts => 'Adding...';

  @override
  String get addedToContacts => 'Added to contacts';

  @override
  String addFailedWithError(String error) {
    return 'Add failed: $error';
  }

  @override
  String get addPhone => 'Add phone';

  @override
  String get addTag => 'Add tags';

  @override
  String get addText => 'Add text';

  @override
  String get addPhoto => 'Add photo';

  @override
  String groupCountLabel(int count) {
    return '$count groups';
  }

  @override
  String get addedViaSearch => 'Added via search';

  @override
  String get addTime => 'Add time';

  @override
  String get doneButton => 'Done';

  @override
  String get waitingForParticipants => 'Waiting for participants to join...';

  @override
  String participantMe(String name) {
    return '$name (Me)';
  }

  @override
  String get sharingLabel => 'Sharing';

  @override
  String screenSharingBy(String name) {
    return '$name is sharing screen';
  }

  @override
  String participantCount(int count) {
    return '$count participants';
  }

  @override
  String get muteLabel => 'Mute';

  @override
  String get unmuteLabel => 'Unmute';

  @override
  String get turnOffVideo => 'Turn off video';

  @override
  String get turnOnVideo => 'Turn on video';

  @override
  String get shareScreen => 'Share screen';

  @override
  String get stopSharing => 'Stop sharing';

  @override
  String get switchCameraLabel => 'Switch';

  @override
  String get leaveLabel => 'Leave';

  @override
  String get participantsLabel => 'Participants';

  @override
  String get joiningMeeting => 'Joining meeting...';

  @override
  String pollVotesFormat(int count, String percentage) {
    return '$count votes ($percentage%)';
  }

  @override
  String pollParticipantsFormat(int count) {
    return '$count participants';
  }

  @override
  String get tapToRetry => 'Tap to retry';

  @override
  String get noConversationsToForward => 'No conversations to forward';

  @override
  String get defaultRedPacketGreeting => 'Best wishes for prosperity';

  @override
  String get emojiCategoryFace => 'Smileys';

  @override
  String get emojiCategoryHeart => 'Hearts';

  @override
  String get emojiCategoryAnimal => 'Animals';

  @override
  String get emojiCategoryFood => 'Food';

  @override
  String get emojiCategoryTransport => 'Transport';

  @override
  String get emojiCategoryActivity => 'Activities';

  @override
  String get emojiCategoryObject => 'Objects';

  @override
  String get emojiCategorySymbol => 'Symbols';

  @override
  String get allowOthersToSearchAndJoin => 'Allow others to search and join';

  @override
  String get allowStrangerMessages => 'Allow stranger messages';

  @override
  String get alwaysUseDarkTheme => 'Always use dark theme';

  @override
  String get alwaysUseLightTheme => 'Always use light theme';

  @override
  String get autoSwitchBySystem => 'Auto switch by system';

  @override
  String get bubbleStyle => 'Bubble style';

  @override
  String get bubbleStyleClassic => 'Classic style';

  @override
  String get bubbleStyleClassicDesc => 'Traditional bubble style';

  @override
  String get bubbleStyleModern => 'Modern style';

  @override
  String get bubbleStyleModernDesc => 'Clean modern bubble style';

  @override
  String get bubbleStyleWechat => 'WeChat style';

  @override
  String get bubbleStyleWechatDesc => 'Classic WeChat bubble style';

  @override
  String get callEnded => 'Call ended';

  @override
  String get callFailed => 'Call failed';

  @override
  String get checkForUpdates => 'Check for updates';

  @override
  String get confirmClearChatHistory =>
      'Are you sure you want to clear chat history?';

  @override
  String get createGroupToChat => 'Create a group to start chatting';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get darkModeOption => 'Dark mode option';

  @override
  String get doNotDisturbDescription =>
      'Do not receive notifications during specified time';

  @override
  String get doNotDisturbMode => 'Do not disturb';

  @override
  String get editGroupAnnouncement => 'Edit group announcement';

  @override
  String get editGroupDescription => 'Edit group description';

  @override
  String get enterGroupAnnouncement => 'Enter group announcement';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get feedbackAndSuggestions => 'Feedback and suggestions';

  @override
  String get followSystem => 'Follow system';

  @override
  String get fontSize => 'Font size';

  @override
  String get fontSizeExtraLarge => 'Extra large';

  @override
  String get fontSizeLarge => 'Large';

  @override
  String get fontSizeSmall => 'Small';

  @override
  String get fontSizeStandard => 'Standard';

  @override
  String get incomingVideoCall => 'Incoming video call';

  @override
  String get incomingVoiceCall => 'Incoming voice call';

  @override
  String get letOthersKnowYouRead => 'Let others know you read';

  @override
  String get letOthersKnowYouTyping => 'Let others know you are typing';

  @override
  String get lightMode => 'Light mode';

  @override
  String memberCountClickToCopy(int count) {
    return '$count members, click to copy group ID';
  }

  @override
  String get messageNotifications => 'Message notifications';

  @override
  String get messagesLabel => 'Messages';

  @override
  String get musicLinkLabel => 'Music link';

  @override
  String get noMediaUrlAvailable => 'No media URL available';

  @override
  String get noPermissionToEditGroupName =>
      'You don\'t have permission to edit group name';

  @override
  String get receiveMessagesFromNonContacts =>
      'Receive messages from non-contacts';

  @override
  String get receiveNewMessageNotifications =>
      'Receive new message notifications';

  @override
  String get reconnectingCall => 'Reconnecting...';

  @override
  String get redPacketTransferCannotForward =>
      'Red packets and transfers cannot be forwarded';

  @override
  String get showMessageContentInNotification =>
      'Show message content in notification';

  @override
  String get showMessagePreview => 'Show message preview';

  @override
  String get typingIndicator => 'Typing indicator';

  @override
  String versionInfo(String version) {
    return 'Version $version';
  }

  @override
  String get vibration => 'Vibration';

  @override
  String get videoCallInProgress => 'Video call in progress';

  @override
  String get voiceCallInProgress => 'Voice call in progress';

  @override
  String whoCanSeeTitle(String title) {
    return 'Who can see $title';
  }

  @override
  String get emailAddress => 'Email Address';

  @override
  String get enterEmailAddress => 'Enter email address';

  @override
  String get emailRecoveryHint => 'Used for password recovery';

  @override
  String get invalidEmailFormat => 'Please enter a valid email address';

  @override
  String get optional => 'Optional';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordTitle => 'Reset Your Password';

  @override
  String get enterRegisteredEmail =>
      'Enter the email address you registered with';

  @override
  String get sendResetCode => 'Send Reset Code';

  @override
  String resetCodeSent(String email) {
    return 'Reset code sent to $email';
  }

  @override
  String get enterResetCode => 'Enter reset code';

  @override
  String get setNewPassword => 'Set New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get passwordResetSuccess =>
      'Password reset successful. Please login with your new password.';

  @override
  String get resetPasswordFailed => 'Reset password failed';

  @override
  String get changePassword => 'Change Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get enterCurrentPassword => 'Enter current password';

  @override
  String get enterNewPassword => 'Enter new password';

  @override
  String get passwordChanged =>
      'Password changed successfully. Please login with your new password.';

  @override
  String get changePasswordFailed => 'Change password failed';

  @override
  String get incorrectCurrentPassword => 'Incorrect current password';

  @override
  String get newPasswordMustBeDifferent =>
      'New password must be different from current password';

  @override
  String get changePasswordInfo =>
      'After changing password, you will be logged out and need to login with the new password.';

  @override
  String get passwordRequirements => 'Password requirements:';

  @override
  String get securityNote =>
      'For security, you will need to re-login on all devices after changing password.';

  @override
  String get security => 'Security';

  @override
  String get currentBoundEmail => 'Current bound email';

  @override
  String get newEmailAddress => 'New Email Address';

  @override
  String get enterNewEmail => 'Enter new email address';

  @override
  String get verificationCode => 'Verification Code';

  @override
  String get verificationCodeSent => 'Verification code sent';

  @override
  String get codeSentTo => 'Verification code sent to';

  @override
  String get didNotReceiveCode => 'Didn\'t receive the code?';

  @override
  String get emailChangedSuccess => 'Email changed successfully';

  @override
  String get changeEmailFailed => 'Change email failed';

  @override
  String get emailSecurityNote =>
      'Your email is used for password recovery. Please keep it secure.';

  @override
  String get googleLogin => 'Sign in with Google';

  @override
  String get appleLogin => 'Sign in with Apple';

  @override
  String get facebookLogin => 'Sign in with Facebook';

  @override
  String get twitterLogin => 'Sign in with Twitter';

  @override
  String get wechatLogin => 'Sign in with WeChat';

  @override
  String get wechat => 'WeChat';

  @override
  String get facebook => 'Facebook';

  @override
  String get twitter => 'Twitter';

  @override
  String get wechatNotInstalled => 'Please install WeChat first';

  @override
  String get wechatLoginFailed => 'WeChat login failed';

  @override
  String get facebookLoginFailed => 'Facebook login failed';

  @override
  String get twitterLoginFailed => 'Twitter login failed';

  @override
  String get twitterNotConfigured => 'Twitter login not configured';

  @override
  String get socialLoginCancelled => 'Login cancelled';

  @override
  String get socialLoginFailed => 'Social login failed';

  @override
  String get language => 'Language';

  @override
  String get languageChanged => 'Language changed';

  @override
  String get biometricLogin => 'Biometric Login';

  @override
  String loginWithBiometric(Object type) {
    return 'Login with $type';
  }

  @override
  String get biometricLoginEnabled => 'Biometric login enabled';

  @override
  String get biometricLoginDisabled => 'Biometric login disabled';

  @override
  String get enableBiometricLogin => 'Enable biometric login';

  @override
  String get disableBiometricLogin => 'Disable biometric login';

  @override
  String get biometricNotAvailable =>
      'Biometric authentication not available on this device';

  @override
  String get biometricNotEnrolled =>
      'No biometric data enrolled. Please set up biometrics in device settings.';

  @override
  String get biometricAuthFailed => 'Biometric authentication failed';

  @override
  String get biometricAuthCancelled => 'Authentication cancelled';

  @override
  String get biometricLockedOut =>
      'Too many failed attempts. Please try again later.';

  @override
  String get useBiometricToLogin =>
      'Use biometric authentication for faster login';

  @override
  String get authenticateToLogin => 'Authenticate to login';

  @override
  String get authenticateToEnable => 'Authenticate to enable biometric login';

  @override
  String get faceId => 'Face ID';

  @override
  String get touchId => 'Touch ID';

  @override
  String get fingerprint => 'Fingerprint';

  @override
  String get biometric => 'Biometric';

  @override
  String get biometricEnabled => 'Enabled - Use biometric to login';

  @override
  String get biometricDisabled => 'Disabled - Tap to enable';

  @override
  String get biometricNeedRelogin =>
      'Please log out and log in again to enable biometric login';

  @override
  String get or => 'OR';
}
