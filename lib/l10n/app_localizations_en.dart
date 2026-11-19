// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonUnknownUser => 'Unknown User';

  @override
  String get transferWalletNotConnected => 'Wallet Not Connected';

  @override
  String get chatCallServiceNotInitialized => 'Call service not initialized';

  @override
  String authLoginFailed(Object error) {
    return 'Login failed: $error';
  }

  @override
  String get chatCallBack => 'Call back';

  @override
  String get chatMissedVideoCall => 'Missed video call';

  @override
  String get chatMissedVoiceCall => 'Missed voice call';

  @override
  String get chatCallNotAnswered => 'Not answered';

  @override
  String get chatCallDurationLabel => 'Call duration';

  @override
  String get chatVoiceCallCancelled => 'Voice call cancelled';

  @override
  String get chatVideoCallCancelled => 'Video call cancelled';

  @override
  String get commonImage => '[Image]';

  @override
  String get chatVideo => '[Video]';

  @override
  String get chatVoice => '[Voice]';

  @override
  String get commonFile => '[File]';

  @override
  String get chatLocation => '[Location]';

  @override
  String get chatUnknownMessage => '[Unknown message]';

  @override
  String get commonDelete => 'Delete';

  @override
  String get chatDeleteThisMessage => 'Delete this message?';

  @override
  String get chatMessageDeleted => 'Message deleted';

  @override
  String get profileNotLoggedIn => 'Not logged in';

  @override
  String get chatMyLocation => 'My location';

  @override
  String get commonGroupChat => 'Group Chat';

  @override
  String get commonSearch => 'Search';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonLoadFailed => 'Failed to load';

  @override
  String get commonMessages => 'Messages';

  @override
  String get commonContacts => 'Contacts';

  @override
  String get commonMe => 'Me';

  @override
  String get commonVoiceLoading => 'Voice loading, please try again later';

  @override
  String get commonVoiceToTextFailed => 'Voice to text failed';

  @override
  String get commonConvertToText => 'To text';

  @override
  String get chatCopy => 'Copy';

  @override
  String get commonForward => 'Forward';

  @override
  String get commonUnfavorite => 'Unfav';

  @override
  String get commonFavorite => 'Favorite';

  @override
  String get settingsResend => 'Resend';

  @override
  String get chatRecall => 'Recall';

  @override
  String get commonQuote => 'Quote';

  @override
  String get commonRemind => 'Remind';

  @override
  String get chatCopied => 'Copied';

  @override
  String get storySendMessageHint => 'Send a message';

  @override
  String get commonMicrophonePermissionRequired =>
      'Please allow microphone permission';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      'Microphone permission has been denied. Please enable it in system settings to use voice messages.';

  @override
  String commonStartRecordingFailed(Object error) {
    return 'Failed to start recording: $error';
  }

  @override
  String get commonRecordingTooShort => 'Recording too short';

  @override
  String commonStopRecordingFailed(Object error) {
    return 'Failed to stop recording: $error';
  }

  @override
  String get chatReleaseToCancel => 'Release to cancel';

  @override
  String get chatReleaseToSend => 'Release to send, swipe up to cancel';

  @override
  String get commonHoldToTalk => 'Hold to talk';

  @override
  String get commonSend => 'Send';

  @override
  String get commonAddFriend => 'Add Friend';

  @override
  String get commonChatServiceNotConnected => 'Chat service not connected';

  @override
  String contactUserNotFoundHint(String query) {
    return 'User \"$query\" not found\n\nTips:\n• Try entering full user ID, e.g. @username:server.com\n• Check the username spelling';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Failed to create chat: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Search failed: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Enter user ID or username to search';

  @override
  String get contactSearching => 'Searching...';

  @override
  String get contactSearchUserToChat => 'Search user to start chatting';

  @override
  String get contactMatrixIdExample =>
      'You can enter a full Matrix ID\ne.g. @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'User \"$username\" not found';
  }

  @override
  String get commonChat => 'Chat';

  @override
  String get commonSettings => 'Settings';

  @override
  String get profileEditProfile => 'Edit Profile';

  @override
  String get authLogin => 'Log In';

  @override
  String get commonCreateGroup => 'Create Group';

  @override
  String get chatError => 'Error';

  @override
  String get commonTransfer => 'Transfer';

  @override
  String get commonReceived => 'Received';

  @override
  String get commonRefunded => 'Refunded';

  @override
  String get commonExpired => 'Expired';

  @override
  String get chatRedPacketGreeting => 'Best wishes';

  @override
  String get commonN42RedPacket => 'N42 Red Packet';

  @override
  String get commonClaimed => 'Claimed';

  @override
  String get commonAllClaimed => 'All claimed';

  @override
  String get chatReadAloud => 'Read Aloud';

  @override
  String get chatReply => 'Reply';

  @override
  String get commonEdit => 'Edit';

  @override
  String get chatSelectForwardTarget => 'Select Forward Target';

  @override
  String commonSendCount(int count) {
    return 'Send($count)';
  }

  @override
  String contactN42Id(Object id) {
    return 'N42 ID: $id';
  }

  @override
  String get profileN42IdTitle => 'N42 ID';

  @override
  String get profileN42Bean => 'N42 Bean';

  @override
  String get contactFriendInfo => 'Friend Info';

  @override
  String get contactFriendInfoDesc =>
      'Add friend\'s remark, phone, tags, notes, photos and set permissions.';

  @override
  String get commonMoments => 'Moments';

  @override
  String get commonSendMessage => 'Message';

  @override
  String get contactAudioVideoCall => 'Audio/Video Call';

  @override
  String get contactVideoChannel => 'Video Channel';

  @override
  String get contactRemark => 'Remark';

  @override
  String get contactRemarkName => 'Remark Name';

  @override
  String get contactPhone => 'Phone';

  @override
  String get contactTags => 'Tags';

  @override
  String get contactNotes => 'Notes';

  @override
  String get contactPhotos => 'Photos';

  @override
  String get contactPermissions => 'Permissions';

  @override
  String get contactChatMomentsEtc => 'Chat, Moments, Sports, etc.';

  @override
  String get contactMoreInfo => 'More Info';

  @override
  String get contactCommonGroups => 'Groups in common';

  @override
  String get contactSource => 'Source';

  @override
  String get settingsNotificationSettings => 'Notifications';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsAbout => 'About';

  @override
  String get commonLogout => 'Log Out';

  @override
  String get commonLogoutConfirm => 'Are you sure you want to log out?';

  @override
  String get commonSave => 'Save';

  @override
  String get profileNickname => 'Nickname';

  @override
  String get profileEnterNickname => 'Enter nickname';

  @override
  String get profileSignature => 'Signature';

  @override
  String get profileAddSignature => 'Add a signature';

  @override
  String get commonTakePhoto => 'Take Photo';

  @override
  String get profileChooseFromGallery => 'Choose from Gallery';

  @override
  String profileSaveFailed(Object error) {
    return 'Save failed: $error';
  }

  @override
  String get authSecureDecentralizedChat => 'Secure, decentralized messaging';

  @override
  String get commonEndToEndEncryption => 'End-to-End Encryption';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Messages visible only to you and the recipient';

  @override
  String get authDecentralized => 'Decentralized';

  @override
  String get authBasedOnMatrix => 'Built on the Matrix open protocol';

  @override
  String get authWalletIntegration => 'Wallet Integration';

  @override
  String get authEasyCryptoTransfer => 'Easy cryptocurrency transfers';

  @override
  String get authRegister => 'Sign Up';

  @override
  String get authAgreeTerms => 'By logging in, you agree to';

  @override
  String get authTermsOfService => 'Terms of Service';

  @override
  String get authAnd => ' and ';

  @override
  String get authPrivacyPolicy => 'Privacy Policy';

  @override
  String get authServerAddress => 'Server Address';

  @override
  String get authEnterServerAddress => 'Enter server address';

  @override
  String authConnectedTo(Object serverName) {
    return 'Connected to $serverName';
  }

  @override
  String get authUsername => 'Username';

  @override
  String get authEnterUsername => 'Enter username';

  @override
  String get authUsernameOrEmail => 'Username or Email';

  @override
  String get authEnterUsernameOrEmail => 'Enter username or email';

  @override
  String get authPassword => 'Password';

  @override
  String get authEnterPassword => 'Enter password';

  @override
  String get authRegisterAccount => 'Sign Up';

  @override
  String get authForgotPassword => 'Forgot Password';

  @override
  String get authOtherLoginMethods => 'Other login methods';

  @override
  String get authCreateAccount => 'Create Account';

  @override
  String get authJoinN42Chat => 'Join N42 Chat to start chatting';

  @override
  String get authUsernameHint => '3-20 chars, letters/numbers/_';

  @override
  String get authUsernameMinLength => 'Username must be at least 3 characters';

  @override
  String get authUsernameMaxLength => 'Username must be at most 20 characters';

  @override
  String get authUsernameFormat =>
      'Username can only contain letters, numbers, and underscores';

  @override
  String get authPasswordHint => 'Min 8 characters';

  @override
  String get commonPasswordMinLength =>
      'Password must be at least 8 characters';

  @override
  String get authConfirmPassword => 'Confirm Password';

  @override
  String get authFilled => 'Filled';

  @override
  String get authEnterInviteCode => 'Enter invite code';

  @override
  String get authAlreadyHaveAccount => 'Already have an account?';

  @override
  String get authLoginNow => 'Log in now';

  @override
  String get profileAvatar => 'Avatar';

  @override
  String get profileStatus => 'Status';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get conversationNoConversations => 'No conversations';

  @override
  String get conversationTapToChat => 'Tap the top right to start chatting';

  @override
  String get conversationStartGroup => 'Start Group Chat';

  @override
  String get commonScan => 'Scan';

  @override
  String get commonPayment => 'Payment';

  @override
  String commonFeatureComingSoon(Object feature) {
    return '$feature coming soon';
  }

  @override
  String get conversationMarkAsRead => 'Mark as read';

  @override
  String get commonUnmute => 'Unmute';

  @override
  String get commonMute => 'Mute';

  @override
  String get conversationUnpin => 'Unpin';

  @override
  String get conversationPin => 'Pin';

  @override
  String get conversationDeleteConversation => 'Delete Conversation';

  @override
  String conversationDeleteConversationConfirm(Object name) {
    return 'Delete conversation with \"$name\"?';
  }

  @override
  String get commonNoContacts => 'No contacts';

  @override
  String get contactAddFriendsToChat => 'Add friends to start chatting';

  @override
  String get contactNotFound => 'Contact not found';

  @override
  String get contactTryOtherKeywords => 'Try other keywords or global search';

  @override
  String get contactSearchResults => 'Search results';

  @override
  String get contactNewFriends => 'New Friends';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => 'Official Accounts';

  @override
  String get contactServiceAccounts => 'Service Accounts';

  @override
  String get contactEnterpriseContacts => 'Enterprise Contacts';

  @override
  String get contactRecommendToFriend => 'Share contact';

  @override
  String get commonSetRemark => 'Set remark';

  @override
  String get contactSendingCard => 'Sending contact card...';

  @override
  String get commonFileLabel => 'File';

  @override
  String get commonLocationLabel => 'Location';

  @override
  String contactRecommendFailed(Object error) {
    return 'Recommend failed: $error';
  }

  @override
  String get profileEnterRemark => 'Enter remark';

  @override
  String get contactOpeningChat => 'Opening chat...';

  @override
  String contactOpenChatFailed(Object error) {
    return 'Failed to open chat: $error';
  }

  @override
  String get contactAddContact => 'Add Contact';

  @override
  String get contactEnterUserId => 'Enter user ID';

  @override
  String get contactNoFriendRequests => 'No friend requests';

  @override
  String get commonAccept => 'Accept';

  @override
  String get commonReject => 'Reject';

  @override
  String get commonNoGroups => 'No groups';

  @override
  String get contactSelectFriendToRecommend =>
      'Select a friend to recommend to';

  @override
  String get commonSearchContacts => 'Search contacts';

  @override
  String get contactNoContactsFound => 'No contacts found';

  @override
  String get favoriteYesterday => 'Yesterday';

  @override
  String get chatJustNow => 'Just now';

  @override
  String get profileOnline => 'Online';

  @override
  String get profileOffline => 'Offline';

  @override
  String get searchContactsGroupsMessages =>
      'Search contacts, groups and messages';

  @override
  String get searchError => 'Search Error';

  @override
  String get chatSearchHint => 'Search';

  @override
  String get searchHistory => 'Search History';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonAll => 'All';

  @override
  String get searchGroups => 'Groups';

  @override
  String get searchNoResults => 'No Results';

  @override
  String commonGroupMembers(Object count) {
    return 'Members ($count)';
  }

  @override
  String get groupMembersTitle => 'Group Members';

  @override
  String get groupViewAll => 'View all';

  @override
  String get groupOwner => 'Owner';

  @override
  String get groupAdmin => 'Admin';

  @override
  String get groupInvite => 'Invite';

  @override
  String get commonGroupAnnouncement => 'Group Announcement';

  @override
  String get commonNotSet => 'Not set';

  @override
  String get groupDescription => 'Group Description';

  @override
  String get groupPublicGroup => 'Public Group';

  @override
  String get commonClearChatHistory => 'Clear Chat History';

  @override
  String get commonDissolveGroup => 'Dissolve Group';

  @override
  String get commonLeaveGroup => 'Leave Group';

  @override
  String get groupChangeGroupName => 'Change Group Name';

  @override
  String get commonEnterGroupName => 'Enter group name';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get groupEnterGroupDescription => 'Enter group description';

  @override
  String get groupPublish => 'Publish';

  @override
  String get chatClearHistoryConfirm =>
      'Clear all chat history? This cannot be undone.';

  @override
  String get chatClearAction => 'Clear';

  @override
  String get commonChatHistoryCleared => 'Chat history cleared';

  @override
  String get commonDissolve => 'Dissolve';

  @override
  String get groupQrCode => 'Group QR Code';

  @override
  String get commonSearchChatHistory => 'Search Chat History';

  @override
  String get groupIdCopied => 'Group ID copied';

  @override
  String get transferEnterOrPasteAddress => 'Enter or paste wallet address';

  @override
  String get transferSelectToken => 'Select Token';

  @override
  String get commonTransferAmount => 'Transfer Amount';

  @override
  String get transferAvailable => 'Available';

  @override
  String get transferMemoOptional => 'Memo (optional)';

  @override
  String get transferConfirmTransfer => 'Confirm Transfer';

  @override
  String get transferAddressVerified => 'Address verified';

  @override
  String transferAvailableBalance(Object balance, Object symbol) {
    return 'Available: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Enter amount';

  @override
  String get commonRedPacketCountMin => 'At least 1 red packet required';

  @override
  String get commonViewRedPacketDetails => 'View Red Packet Details';

  @override
  String get commonEnterTransferAmount => 'Please enter transfer amount';

  @override
  String get commonTransferTo => 'Transfer to';

  @override
  String commonFromSender(String name) {
    return 'From $name';
  }

  @override
  String get commonConfirmReceive => 'Confirm Receipt';

  @override
  String get groupProfile => 'Group Info';

  @override
  String get groupRemoveMember => 'Remove from Group';

  @override
  String get commonRemove => 'Remove';

  @override
  String get profileClearStatus => 'Clear Status';

  @override
  String get profileClearStatusConfirm => 'Clear current status?';

  @override
  String get profileStatusCleared => 'Status cleared';

  @override
  String get profileUserNotExist => 'User does not exist';

  @override
  String get profileUserIdCopied => 'User ID copied';

  @override
  String get commonReport => 'Report';

  @override
  String get profileQrCode => 'QR Code';

  @override
  String get profileAvatarUpdated => 'Avatar updated';

  @override
  String commonSelectImageFailed(Object error) {
    return 'Failed to select image: $error';
  }

  @override
  String get profileChangeName => 'Change Name';

  @override
  String get profileMale => 'Male';

  @override
  String get profileFemale => 'Female';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature feature in development...';
  }

  @override
  String profileSaveAddressFailed(Object error) {
    return 'Failed to save address: $error';
  }

  @override
  String get profileAddNew => 'Add';

  @override
  String get profileAddAddress => 'Add Address';

  @override
  String get profileAddressAdded => 'Address added';

  @override
  String get profileAddressUpdated => 'Address updated';

  @override
  String get profileDeleteAddress => 'Delete Address';

  @override
  String get profileAddressDeleted => 'Address deleted';

  @override
  String profileSaveInvoiceFailed(Object error) {
    return 'Failed to save invoice: $error';
  }

  @override
  String get profileMyInvoices => 'My Invoices';

  @override
  String get profileAddInvoice => 'Add Invoice';

  @override
  String get profileInvoiceAdded => 'Invoice added';

  @override
  String get profileInvoiceUpdated => 'Invoice updated';

  @override
  String get profileDeleteInvoice => 'Delete Invoice';

  @override
  String get profileInvoiceDeleted => 'Invoice deleted';

  @override
  String get profilePersonal => 'Personal';

  @override
  String get groupSelectAtLeastOne => 'Please select at least one member';

  @override
  String get chatFileNotExist => 'File does not exist';

  @override
  String chatSendFailed(String error) {
    return 'Send failed: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Cannot open browser';

  @override
  String chatSelectFileFailed(String error) {
    return 'Failed to select file: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Setup failed: $error';
  }

  @override
  String get transferEnterValidAmount => 'Please enter a valid amount';

  @override
  String get commonAddressCopied => 'Address copied';

  @override
  String favoriteOpenItem(Object content) {
    return 'Open: $content';
  }

  @override
  String get favoriteDeleted => 'Deleted';

  @override
  String get profileWallet => 'Wallet';

  @override
  String get chatRecording => 'Recording';

  @override
  String get chatInvalidVideoUrl => 'Invalid video URL';

  @override
  String get chatDownloadFile => 'Download file';

  @override
  String get chatClearChatHistoryTitle => 'Clear Chat History';

  @override
  String get chatVideoCall => 'Video Call';

  @override
  String get commonVoiceCall => 'Voice Call';

  @override
  String get callLeaveMeeting => 'Leave Meeting';

  @override
  String get chatDetails => 'Chat Details';

  @override
  String get chatViewAllGroupMembers => 'View all members';

  @override
  String get chatGroupName => 'Group Name';

  @override
  String get chatGroupNameUpdated => 'Group name updated';

  @override
  String get chatUpdateFailed => 'Update failed';

  @override
  String get chatNoPermissionToModify => 'You do not have permission to modify';

  @override
  String get chatGroupManagement => 'Group Management';

  @override
  String get chatMyNicknameInGroup => 'My Nickname in Group';

  @override
  String get chatPinChat => 'Pin Chat';

  @override
  String get chatStrongReminder => 'Strong Reminder';

  @override
  String get chatSetChatBackground => 'Set Chat Background';

  @override
  String get chatUnknownFile => 'Unknown file';

  @override
  String get chatDownload => 'Download';

  @override
  String get chatInvalidLocation => 'Invalid location';

  @override
  String get chatTapToCancel => 'Tap to cancel';

  @override
  String chatCaptureFailed(Object error) {
    return 'Capture failed: $error';
  }

  @override
  String get chatProcessingVideo => 'Processing video...';

  @override
  String get chatVideoFileNotExist => 'Video file does not exist';

  @override
  String get chatVideoDataEmpty => 'Video data is empty';

  @override
  String get chatVideoTooLarge => 'Video size cannot exceed 100MB';

  @override
  String get chatSendingVideo => 'Sending video...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Failed to send video: $error';
  }

  @override
  String get chatImageFileNotExist => 'Image file does not exist';

  @override
  String get commonImageDataEmpty => 'Image data is empty';

  @override
  String get chatSendingImage => 'Sending image...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Failed to send image: $error';
  }

  @override
  String get chatSendLocation => 'Send Location';

  @override
  String get chatSelectLocationAndSend => 'Select location and send';

  @override
  String get chatShareRealTimeLocation => 'Share Real-time Location';

  @override
  String get chatShareLocationForOneHour =>
      'Share real-time location with friend for 1 hour';

  @override
  String get chatLocationSent => 'Location sent';

  @override
  String get chatSelectMessages => 'Select messages';

  @override
  String chatSelectedCount(int count) {
    return 'Selected $count';
  }

  @override
  String get chatSelectAll => 'Select All';

  @override
  String chatGroupChatCount(int count) {
    return 'Group Chat($count)';
  }

  @override
  String get chatPrivateChat => 'Private Chat';

  @override
  String get chatNoMessages => 'No messages';

  @override
  String get chatSendFirstMessage => 'Send the first message to start chatting';

  @override
  String get chatEncryptionNotice =>
      'This chat is end-to-end encrypted. Only you and the recipient can read the messages.';

  @override
  String get chatMultiForward => 'Forward';

  @override
  String get chatCollect => 'Collect';

  @override
  String get chatNoMembers => 'No members';

  @override
  String get chatMemberNotFound => 'Member not found';

  @override
  String get chatVoiceFileNotExist => 'Voice file does not exist';

  @override
  String get chatVoiceFileEmpty => 'Voice file is empty';

  @override
  String get chatSendingVoice => 'Sending voice...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Failed to send voice: $error';
  }

  @override
  String get chatMessageForwarded => 'Message forwarded';

  @override
  String chatForwardFailed(Object error) {
    return 'Forward failed: $error';
  }

  @override
  String get chatUnfavorited => 'Unfavorited';

  @override
  String get chatFavorited => 'Favorited';

  @override
  String get chatReactionAdded => 'Reaction added';

  @override
  String get chatReactionRemoved => 'Reaction removed';

  @override
  String get chatFailedMessageDeleted => 'Failed message deleted';

  @override
  String get chatDeleteMessages => 'Delete messages';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Are you sure you want to delete $count messages?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Note: $count messages are from others and will only be deleted for you.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count messages from you will be recalled for everyone.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return 'Recalled $count messages, $localCount deleted only for you';
  }

  @override
  String chatRecalledMessages(Object count) {
    return 'Recalled $count messages';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count messages deleted only for you';
  }

  @override
  String chatForwardedCount(Object count) {
    return 'Forwarded $count messages';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Forward complete: $success succeeded, $failed failed';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'Remind feature is only available in group chat';

  @override
  String get chatOnlyTextSearchable => 'Only text messages can be searched';

  @override
  String chatSearchFor(Object text) {
    return 'Search \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Baidu Search';

  @override
  String get chatGoogleSearch => 'Google Search';

  @override
  String get chatBingSearch => 'Bing Search';

  @override
  String get chatCalling => 'Calling...';

  @override
  String get chatRinging => 'Ringing...';

  @override
  String get chatInCall => 'In call';

  @override
  String commonFeatureInDevelopment(Object feature) {
    return '$feature feature in development...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'Collected $count messages';
  }

  @override
  String commonMemberCount(int count) {
    return '$count members';
  }

  @override
  String groupDone(int count) {
    return 'Done($count)';
  }

  @override
  String get profileServices => 'Services';

  @override
  String get commonFavorites => 'Favorites';

  @override
  String get profileOrdersAndCards => 'Orders & Cards';

  @override
  String get profileStickers => 'Stickers';

  @override
  String profileStatusSetTo(String status) {
    return 'Status set to: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'Avatar upload failed';

  @override
  String get profilePersonalProfile => 'Personal Profile';

  @override
  String get profileName => 'Name';

  @override
  String get profileGender => 'Gender';

  @override
  String get profileRegion => 'Region';

  @override
  String get commonMyQrCode => 'My QR Code';

  @override
  String get profilePoke => 'Poke';

  @override
  String get profileRingtone => 'Ringtone';

  @override
  String get profileDefaultRingtone => 'Default Ringtone';

  @override
  String get profileMyAddresses => 'My Addresses';

  @override
  String profileGenderSetTo(String gender) {
    return 'Gender set to: $gender';
  }

  @override
  String get profileSelectRegion => 'Select Region';

  @override
  String get profileSelectCity => 'Select City';

  @override
  String profileRegionSetTo(String region) {
    return 'Region set to: $region';
  }

  @override
  String get profileSetPoke => 'Set Poke';

  @override
  String get profileFriendPokedMe => 'Friend poked me';

  @override
  String get profileExample => 'Example';

  @override
  String get profileOnTheShoulder => ' on the shoulder';

  @override
  String get profilePokeCleared => 'Poke cleared';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Poke set to: poked me$suffix';
  }

  @override
  String get profileEditSignature => 'Edit Signature';

  @override
  String get profileIntroduceYourself => 'A sentence to introduce yourself';

  @override
  String get profileSignatureCleared => 'Signature cleared';

  @override
  String get profileSignatureUpdated => 'Signature updated';

  @override
  String get profileScanToAddFriend =>
      'Scan the QR code above to add me as a friend';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Ringtone set to: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'Are you sure you want to dissolve \"$name\"? This action cannot be undone.';
  }

  @override
  String get authEnterValidServerAddress =>
      'Please enter a valid server address';

  @override
  String get authEnterServerAddressFirst => 'Please enter server address first';

  @override
  String get authPasskeyRequiresServer =>
      'Passkey login requires server support';

  @override
  String get authLoginAgreement => 'By logging in, you agree to ';

  @override
  String get authPleaseAgreeToTerms =>
      'Please read and agree to the Terms of Service and Privacy Policy';

  @override
  String get authRegisterFailed => 'Registration failed';

  @override
  String get authRegistrationDisabled =>
      'This server has disabled registration. Contact its administrator to enable it.';

  @override
  String get commonReenterPassword => 'Re-enter password';

  @override
  String get commonPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get authInviteCodeBuiltIn => 'Invite Code (Built-in)';

  @override
  String get authInviteCodeBuiltInNote =>
      'Invite code is built-in, usually no need to modify';

  @override
  String get authIHaveReadAndAgree => 'I have read and agree to ';

  @override
  String get mainStartGroupChat => 'Start Group Chat';

  @override
  String get mainAddFriends => 'Add Friends';

  @override
  String get mainPaymentAndCollection => 'Payment';

  @override
  String contactCount(int count) {
    return '$count contacts';
  }

  @override
  String get contactAddToHomeScreen => 'Add to home screen';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'Recommended $contact\'s card to $recipient';
  }

  @override
  String get contactEnterRemarkName => 'Enter remark name';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Remark set to: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Accepted $name\'s friend request';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Rejected $name\'s friend request';
  }

  @override
  String get commonGroupInvites => 'Group Invites';

  @override
  String commonMyGroups(int count) {
    return 'My Groups ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Invited to join group';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'Are you sure you want to leave \"$name\"?';
  }

  @override
  String get commonLeave => 'Leave';

  @override
  String get commonRecallThisMessage => 'Recall this message?';

  @override
  String get commonSavedToGallery => 'Saved to gallery';

  @override
  String get commonFailedToSave => 'Failed to save';

  @override
  String get chatSaving => 'Saving...';

  @override
  String get commonShare => 'Share';

  @override
  String get chatSaveToGallery => 'Save to Gallery';

  @override
  String get chatFailedToLoadImage => 'Failed to load image';

  @override
  String get chatVideoRecordingFailed => 'Video recording failed';

  @override
  String get profileRedPacket => 'Red Packet';

  @override
  String get commonMusic => 'Music';

  @override
  String get commonCoupon => 'Coupon';

  @override
  String get commonGift => 'Gift';

  @override
  String get commonPoll => 'Poll';

  @override
  String get favoriteText => 'Text';

  @override
  String get favoriteLinkLabel => 'Link';

  @override
  String get favoriteNote => 'Note';

  @override
  String get favoriteMyNotes => 'My Notes';

  @override
  String get favoriteToday => 'Today';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count days ago';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$month/$day';
  }

  @override
  String get favoriteNoFavorites => 'No favorites yet';

  @override
  String get favoriteLongPressToFavorite => 'Long press message to favorite';

  @override
  String get favoriteNewNote => 'New Note';

  @override
  String get favoriteLink => 'Favorite Link';

  @override
  String get favoriteEditTags => 'Edit Tags';

  @override
  String get favoriteDeleteFavorite => 'Delete Favorite';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Are you sure you want to delete this favorite?';

  @override
  String get favoriteNoSearchResultsFound => 'No results found';

  @override
  String get commonSendRedPacket => 'Send Red Packet';

  @override
  String get transferAmount => 'Amount';

  @override
  String get commonRedPacketCover => 'Red Packet Cover';

  @override
  String get commonRedPacketType => 'Red Packet Type';

  @override
  String get commonNormalRedPacket => 'Normal';

  @override
  String get commonLuckyRedPacket => 'Lucky';

  @override
  String get commonRedPacketCount => 'Red Packet Count';

  @override
  String get commonPieces => 'pieces';

  @override
  String get commonPutMoneyInRedPacket => 'Put money in red packet';

  @override
  String get commonRedPacketRefundNotice =>
      'Unclaimed red packets will be refunded after 24 hours';

  @override
  String get commonOpenRedPacket => 'Open';

  @override
  String get commonRedPacketAllClaimed => 'Red packet all claimed';

  @override
  String get commonRedPacketExpired => 'Red packet expired';

  @override
  String get commonAddTransferNote => 'Add transfer note';

  @override
  String get commonYuan => 'CNY';

  @override
  String get commonReplyWithEmoji => 'Reply with this emoji';

  @override
  String get contactEditRemark => 'Edit Remark';

  @override
  String get contactSetPermissions => 'Set Permissions';

  @override
  String get profileAddToBlacklist => 'Add to Blacklist';

  @override
  String get contactDeleteContact => 'Delete Contact';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get transferTitle => 'Transfer';

  @override
  String get transferReceiverAddressLabel => 'Recipient Address';

  @override
  String get transferSelectTokenLabel => 'Select Token';

  @override
  String get transferAmountLabel => 'Transfer Amount';

  @override
  String get transferMemoLabel => 'Memo (optional)';

  @override
  String get transferAddMemoHint => 'Add a memo';

  @override
  String get transferSendPaymentRequest => 'Send Payment Request';

  @override
  String get transferQrCodeGenerateFailed => 'QR code generation failed';

  @override
  String get transferScanQrToPayMe => 'Scan QR code to pay me';

  @override
  String get transferMyWalletAddress => 'My Wallet Address';

  @override
  String get transferCreatePaymentRequest => 'Create Payment Request';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'Best wishes';

  @override
  String commonSenderRedPacket(String name) {
    return '$name\'s Red Packet';
  }

  @override
  String get transferEnterValidAddress => 'Please enter a valid address';

  @override
  String get transferPleaseSelectToken => 'Please select a token';

  @override
  String get commonReceivedTransfer => 'Received Transfer';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name sent a red packet';
  }

  @override
  String get commonSavedToBalance => 'Saved to balance, can transfer directly';

  @override
  String get commonRedPacketExpiredOrEmpty => 'Red packet expired/all claimed';

  @override
  String get transferScanFeatureComingSoon => 'Scan feature coming soon...';

  @override
  String get contactSetAsStarred => 'Set as Starred';

  @override
  String get contactAddToBlocklist => 'Add to Blocklist';

  @override
  String get commonClaimedYour => ' claimed your ';

  @override
  String get commonClaimedText => ' claimed ';

  @override
  String commonUserTyping(String name) {
    return '$name is typing...';
  }

  @override
  String get commonTyping => 'Typing...';

  @override
  String get commonWaitingToReceive => 'Waiting to receive';

  @override
  String get commonTapToClaim => 'Tap to claim';

  @override
  String get commonHasBeenReceived => 'Has been received';

  @override
  String get commonGetLucky => 'Get lucky';

  @override
  String get qrcodeCameraStartFailed => 'Camera failed to start';

  @override
  String get qrcodeUnknownError => 'Unknown error';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'Place QR code within the frame to scan';

  @override
  String get qrcodeCloseManualInput => 'Close Manual Input';

  @override
  String get qrcodeManualInputUserId => 'Manual Input User ID';

  @override
  String get commonAdd => 'Add';

  @override
  String get profileSetStatus => 'Set Status';

  @override
  String get profileVisibleToFriends24h => 'Visible to friends for 24 hours';

  @override
  String get profileWriteStatus => 'Write Status';

  @override
  String get profileEnterYourStatus => 'Enter your status...';

  @override
  String get profileOk => 'OK';

  @override
  String get qrcodeCameraPermissionRequired =>
      'Camera permission is required to scan QR code';

  @override
  String get qrcodeCameraPermissionDenied =>
      'Camera permission was permanently denied. Please enable it in system settings.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Error checking permission: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'Invalid QR code';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Cannot add friend: $error';
  }

  @override
  String get qrcodeScanQrCode => 'Scan QR Code';

  @override
  String get qrcodeCheckingCameraPermission => 'Checking camera permission...';

  @override
  String get qrcodeNeedCameraPermission => 'Camera Permission Required';

  @override
  String get qrcodeRetryPermission => 'Retry';

  @override
  String get qrcodeOpenSettings => 'Open Settings';

  @override
  String get groupInviteMembers => 'Invite Members';

  @override
  String groupInviteCount(int count) {
    return 'Invite($count)';
  }

  @override
  String get profileNoShippingAddress => 'No shipping address';

  @override
  String get profileDefaultLabel => 'Default';

  @override
  String get profileNoInvoice => 'No invoice';

  @override
  String get profileCompany => 'Company';

  @override
  String get profileTaxNumber => 'Tax Number';

  @override
  String get profileConfirmDeleteAddress =>
      'Are you sure you want to delete this address?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Are you sure you want to delete this invoice?';

  @override
  String get commonGroupOwner => 'Owner';

  @override
  String get commonGroupAdmin => 'Admin';

  @override
  String get groupSearchMembers => 'Search members';

  @override
  String groupTotalMembers(int count) {
    return '$count members';
  }

  @override
  String get chatRemoveFromGroup => 'Remove from Group';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Are you sure you want to remove \"$name\" from the group?';
  }

  @override
  String get chatUnknownSong => 'Unknown Song';

  @override
  String get chatUnknownArtist => 'Unknown Artist';

  @override
  String get chatUnknownContact => 'Unknown Contact';

  @override
  String get chatPersonalCard => 'Contact Card';

  @override
  String get chatSingleChoice => 'Single';

  @override
  String get chatMultiChoice => 'Multi';

  @override
  String get chatEnded => 'Ended';

  @override
  String get chatEndPollButton => 'End Poll';

  @override
  String get chatPollHint =>
      'Poll will be displayed in chat. Group members can vote.';

  @override
  String get chatSearchSongOrArtist => 'Search song or artist';

  @override
  String get chatNoSongsFound => 'No songs found';

  @override
  String get chatSongNameOptional => 'Song Name (Optional)';

  @override
  String get chatEnterSongName => 'Enter song name';

  @override
  String get chatArtistNameOptional => 'Artist Name (Optional)';

  @override
  String get chatEnterArtistName => 'Enter artist name';

  @override
  String get chatRealTimeLocationSharing =>
      'Real-time location sharing in development...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Voice call feature in development...';

  @override
  String get profileReportFeatureInDev => 'Report feature in development...';

  @override
  String get profileShareFeatureInDev => 'Share feature in development...';

  @override
  String get profileQrCodeFeatureInDev => 'QR code feature in development...';

  @override
  String get qrcodeScanQrToAddMe =>
      'Scan the QR code above to add me as a friend';

  @override
  String get qrcodeSaveToAlbum => 'Save to Album';

  @override
  String get qrcodeChangeStyle => 'Change Style';

  @override
  String get qrcodeCopyId => 'Copy ID';

  @override
  String get qrcodeIdCopied => 'ID copied';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => 'More styles coming soon';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileHomeServer => 'Server';

  @override
  String get profileShareContactCard => 'Share Contact Card';

  @override
  String get profileRemoveFromBlacklist => 'Remove from Blacklist';

  @override
  String get profileConfirmAddBlacklist =>
      'Are you sure you want to add this user to blacklist? You will not receive messages from them.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Are you sure you want to remove this user from blacklist?';

  @override
  String get profileRemarkSaved => 'Remark saved';

  @override
  String get profileRemarkCleared => 'Remark cleared';

  @override
  String get transferReceive => 'Receive';

  @override
  String get transferPleaseConnectWallet => 'Please connect your wallet first';

  @override
  String get transferSendRequest => 'Send Request';

  @override
  String get transferPleaseEnterValidAmount => 'Please enter a valid amount';

  @override
  String get searchPlaceholder => 'Search contacts, groups, messages';

  @override
  String get searchEnterKeywordToSearch => 'Enter keyword to start searching';

  @override
  String get searchClearHistory => 'Clear';

  @override
  String get searchClearHistoryConfirm => 'Clear all recent searches?';

  @override
  String searchNoResultsForQuery(String query) {
    return 'No results found for \"$query\"';
  }

  @override
  String get searchAllResults => 'All';

  @override
  String get searchInChat => 'Search in chat';

  @override
  String get searchContactLabel => 'Contact';

  @override
  String get searchGroupLabel => 'Group';

  @override
  String get searchConversationLabel => 'Conversation';

  @override
  String get searchMessageLabel => 'Message';

  @override
  String get settingsSecurityTitle => 'Security';

  @override
  String get settingsDeleteAccountTitle => 'Delete account';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Deactivate this Matrix account and clean up its local chat data';

  @override
  String get settingsDeleteAccountExplanation =>
      'This requests permanent Matrix account deactivation. After server confirmation, this app removes this account\'s local chat session and encryption keys when safe. Other accounts and your wallet are kept. Federation and server retention may limit data erasure.';

  @override
  String get settingsDeleteAccountPasswordOptional =>
      'Matrix password, if requested';

  @override
  String get settingsDeleteAccountServerErase => 'Request server data erasure';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      'Ask this homeserver to erase account data where supported. Copies held by other servers or required by retention may remain.';

  @override
  String get settingsDeleteAccountChooseStage => 'Verify this Matrix account';

  @override
  String get settingsDeleteAccountUsePassword => 'Use Matrix password';

  @override
  String get settingsDeleteAccountUseBrowser => 'Continue in browser';

  @override
  String get settingsDeleteAccountFallbackTitle =>
      'Return from Matrix verification';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      'Returning from the browser does not confirm deletion. Check the original request with the Matrix server.';

  @override
  String get settingsDeleteAccountCheckServer => 'Check with server';

  @override
  String get settingsDeleteAccountRequestFailed =>
      'The Matrix server did not confirm account deletion.';

  @override
  String get settingsDeleteAccountPendingTitle =>
      'Pending local account cleanup';

  @override
  String get settingsDeleteAccountPendingSubtitle =>
      'Review cleanup for a previously deactivated Matrix account';

  @override
  String get settingsDeleteAccountPendingReadError =>
      'Unable to read pending cleanup records. Tap to retry.';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'The Matrix account was deactivated, but local cleanup is still pending. Other accounts remain available.';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      'Account management opened in your browser. Deletion has not been confirmed in this app, so your chat session remains available.';

  @override
  String get settingsKeyBackup => 'Key Backup';

  @override
  String get settingsBackupEncryptionKeys => 'Backup Encryption Keys';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count keys backed up';
  }

  @override
  String get settingsBackupNotSet => 'Backup not set';

  @override
  String get settingsRestoreKeys => 'Restore Keys';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Restore encryption keys from backup';

  @override
  String get settingsExportKeys => 'Export Keys';

  @override
  String get settingsExportKeysToFile => 'Export keys to file';

  @override
  String get settingsLoggedInDevices => 'Logged In Devices';

  @override
  String get settingsNoOtherDevices => 'No other devices';

  @override
  String get settingsVerified => 'Verified';

  @override
  String get settingsUnverified => 'Unverified';

  @override
  String get settingsAdvanced => 'Advanced';

  @override
  String get settingsCrossSigning => 'Cross-Signing';

  @override
  String get settingsEnabled => 'Enabled';

  @override
  String get settingsNotEnabled => 'Not enabled';

  @override
  String get settingsResetEncryption => 'Reset Encryption';

  @override
  String get settingsDeleteAllEncryptionKeys => 'Delete all encryption keys';

  @override
  String get settingsEncryptionNotSupported => 'Encryption not supported';

  @override
  String get settingsNotInitialized => 'Not initialized';

  @override
  String get settingsBackupKeyTitle => 'Backup Keys';

  @override
  String get settingsBackupKeyMessage =>
      'Create a new key backup? This will help you restore encrypted messages on a new device.';

  @override
  String get settingsBackup => 'Backup';

  @override
  String get settingsRestoreKeyTitle => 'Restore Keys';

  @override
  String get settingsRestoreKeyMessage =>
      'Enter your recovery password or recovery key to restore encrypted messages.';

  @override
  String get settingsRestore => 'Restore';

  @override
  String get settingsExportKeyTitle => 'Export Keys';

  @override
  String get settingsExportKeyMessage =>
      'The exported key file contains all your encryption keys. Please keep it safe.';

  @override
  String get settingsExport => 'Export';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'Device ID: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Status: Verified';

  @override
  String get settingsDeviceStatusUnverified => 'Status: Unverified';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Last active: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Verify this device';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'Cross-signing is already enabled';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Cross-signing setup successful';

  @override
  String get settingsResetEncryptionTitle => 'Reset Encryption';

  @override
  String get settingsResetEncryptionWarning =>
      'Warning: This will delete all your encryption keys. You will not be able to decrypt previous encrypted messages. This action cannot be undone.';

  @override
  String get settingsReset => 'Reset';

  @override
  String get settingsBackupSuccess => 'Keys backed up successfully';

  @override
  String get settingsBackupFailed => 'Backup failed';

  @override
  String get settingsRecoveryKey => 'Recovery Key';

  @override
  String get settingsRecoveryKeySaveWarning =>
      'Please save this recovery key in a safe place. You will need it to restore your encrypted messages on a new device.';

  @override
  String get settingsRecoveryKeySaved => 'I have saved it';

  @override
  String get settingsRestoreSuccess => 'Keys restored successfully';

  @override
  String get settingsRestoreEmpty =>
      'No message keys were found in this backup.';

  @override
  String settingsRestoreSessions(int count) {
    return 'Restored $count key sessions. Messages with missing keys may remain encrypted.';
  }

  @override
  String get settingsRestoreFailed => 'Restore failed';

  @override
  String get settingsPassword => 'Password';

  @override
  String get settingsEnterRecoveryKey => 'Enter recovery key';

  @override
  String get settingsEnterPassword => 'Enter password';

  @override
  String get settingsExportSuccess =>
      'Keys exported to server backup successfully';

  @override
  String get settingsExportNeedBackupFirst =>
      'Please create a key backup first';

  @override
  String get settingsExportFailed => 'Export failed';

  @override
  String get settingsResetSuccess => 'Encryption reset successful';

  @override
  String get settingsResetFailed => 'Reset failed';

  @override
  String get callLeaveMeetingConfirm =>
      'Are you sure you want to leave the meeting?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'poked $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'No contacts available to add';

  @override
  String get chatAddMembers => 'Add Members';

  @override
  String chatInvitedMembers(int count) {
    return 'Invited $count members';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Invite failed: $error';
  }

  @override
  String get chatMemberRemoved => 'Member removed';

  @override
  String chatRemoveFailed(String error) {
    return 'Remove failed: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'After sharing, the other party can see your real-time location for 1 hour.';

  @override
  String get chatStartSharing => 'Start Sharing';

  @override
  String get chatLocationServiceNotEnabled => 'Location service is not enabled';

  @override
  String get chatEnableLocationService =>
      'Please enable location service to use this feature';

  @override
  String get chatGoToSettings => 'Go to Settings';

  @override
  String get chatLocationPermissionRequired =>
      'Location permission is required for this feature';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'Location permission has been permanently denied. Please enable it in settings.';

  @override
  String get chatLocationPermissionDenied => 'Location permission denied';

  @override
  String get chatGettingLocation => 'Getting location...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Failed to get location: $error';
  }

  @override
  String get chatMapPreview => 'Map Preview';

  @override
  String get chatSearchLocation => 'Search location';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'Sent $amount $token red packet';
  }

  @override
  String get chatTransferDefault => 'Transfer';

  @override
  String chatTransferSent(String amount, String token) {
    return 'Sent $amount $token transfer';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Failed to pick file: $error';
  }

  @override
  String get chatFileSizeLimit => 'File size cannot exceed 50MB';

  @override
  String chatFileSending(String filename) {
    return 'Sending file: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Failed to send file: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'Sent $name\'s contact card';
  }

  @override
  String get chatFavoritesFeature => 'Favorites';

  @override
  String get chatCouponsFeature => 'Coupons';

  @override
  String get chatGiftFeature => 'Gift';

  @override
  String chatSharedMusic(String name) {
    return 'Shared $name';
  }

  @override
  String get chatEndPollTitle => 'End Poll';

  @override
  String get chatEndPollConfirmMessage =>
      'Are you sure you want to end this poll? Voting will be closed after ending.';

  @override
  String get chatPollEndedMessage => 'Poll ended';

  @override
  String get chatConnectingCall => 'Connecting...';

  @override
  String get chatMuteCall => 'Mute';

  @override
  String get chatSpeakerOff => 'Speaker Off';

  @override
  String get chatSpeakerOn => 'Speaker';

  @override
  String get chatCameraOn => 'Camera On';

  @override
  String get chatCameraOff => 'Camera Off';

  @override
  String get chatHangUp => 'Hang Up';

  @override
  String get chatSelectForwardTargetTitle => 'Select Forward Target';

  @override
  String get chatNoForwardableChat => 'No chats available for forwarding';

  @override
  String get chatNoMatchingChat => 'No matching chats found';

  @override
  String get chatLocationTitle => 'Location';

  @override
  String get chatSendButton => 'Send';

  @override
  String get chatRetryButton => 'Retry';

  @override
  String get chatSearchContactHint => 'Search contacts';

  @override
  String get chatShareMusic => 'Share Music';

  @override
  String get chatRecentPlayed => 'Recent';

  @override
  String get chatMyFavorites => 'Favorites';

  @override
  String get chatNetworkLink => 'Link';

  @override
  String get chatLocalFile => 'Local';

  @override
  String get chatPasteMusicLink => 'Paste music link';

  @override
  String get chatShareMusicButton => 'Share Music';

  @override
  String get chatSelectLocalAudio => 'Select Local Audio File';

  @override
  String get chatSupportedAudioFormats => 'Supports MP3, M4A, WAV, FLAC, etc.';

  @override
  String get chatSelectFileButton => 'Select File';

  @override
  String get chatPleaseEnterMusicLink => 'Please enter music link';

  @override
  String get chatPleaseEnterValidLink => 'Please enter a valid URL';

  @override
  String get chatSharedSong => 'Shared Song';

  @override
  String get chatSelectMember => 'Select Member';

  @override
  String get chatSearchMemberHint => 'Search members';

  @override
  String get chatNoMatchingMembers => 'No matching members found';

  @override
  String get commonUnknownMember => 'Unknown';

  @override
  String chatSelectedMessagesCount(int count) {
    return 'Selected $count messages';
  }

  @override
  String get chatSearchContactsOrGroups => 'Search contacts or groups';

  @override
  String get chatVideoTitle => 'Video';

  @override
  String get chatLoadingText => 'Loading...';

  @override
  String get chatVideoLoadFailed => 'Video load failed';

  @override
  String get chatPlayerInitFailed => 'Player initialization failed';

  @override
  String get chatCreatePollTitle => 'Create Poll';

  @override
  String get chatSubmitPoll => 'Submit';

  @override
  String get chatPollQuestionLabel => 'Poll Question';

  @override
  String get chatEnterPollQuestionHint => 'Please enter poll question';

  @override
  String get chatPollOptionsLabel => 'Poll Options';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Option $index';
  }

  @override
  String get chatAddOptionButton => 'Add Option';

  @override
  String get chatPollSettingsLabel => 'Poll Settings';

  @override
  String get chatSelectionType => 'Selection Type';

  @override
  String get chatSingleChoiceLabel => 'Single';

  @override
  String get chatMultiChoiceLabel => 'Multi';

  @override
  String get chatAnonymousPollSwitch => 'Anonymous Poll';

  @override
  String get chatPleaseEnterQuestion => 'Please enter poll question';

  @override
  String get chatAtLeastTwoOptions => 'At least 2 options required';

  @override
  String chatConfirmWithCount(int count) {
    return 'Confirm ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'Email Verification';

  @override
  String get authEnterValidEmailAddress => 'Please enter a valid email address';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Verification code sent to $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Failed to send code: $error';
  }

  @override
  String get authVerificationSuccess => 'Verification successful';

  @override
  String get authVerificationFailed => 'Verification failed';

  @override
  String authVerificationCodeError(String error) {
    return 'Verification code error: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Enter verification code';

  @override
  String get authEnterYourEmail => 'Enter email';

  @override
  String authWeSentCodeTo(String email) {
    return 'We sent a 6-digit code to\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'Enter your email address, we will send verification code';

  @override
  String get commonSendVerificationCode => 'Send verification code';

  @override
  String get authResendVerificationCode => 'Resend verification code';

  @override
  String authCanResendAfter(int seconds) {
    return 'Can resend after $seconds seconds';
  }

  @override
  String get commonChangeEmail => 'Change Email';

  @override
  String get contactAddToContacts => 'Add to Contacts';

  @override
  String get contactAddingToContacts => 'Adding...';

  @override
  String get contactAddedToContacts => 'Added to contacts';

  @override
  String contactAddFailedWithError(String error) {
    return 'Add failed: $error';
  }

  @override
  String get contactAddPhone => 'Add phone';

  @override
  String get contactAddTag => 'Add tags';

  @override
  String get contactAddText => 'Add text';

  @override
  String get contactAddPhoto => 'Add photo';

  @override
  String contactGroupCountLabel(int count) {
    return '$count groups';
  }

  @override
  String get contactAddedViaSearch => 'Added via search';

  @override
  String get contactAddTime => 'Add time';

  @override
  String get contactDoneButton => 'Done';

  @override
  String get callWaitingForParticipants =>
      'Waiting for participants to join...';

  @override
  String callParticipantMe(String name) {
    return '$name (Me)';
  }

  @override
  String get callSharingLabel => 'Sharing';

  @override
  String callScreenSharingBy(String name) {
    return '$name is sharing screen';
  }

  @override
  String callParticipantCount(int count) {
    return '$count participants';
  }

  @override
  String get callMuteLabel => 'Mute';

  @override
  String get callUnmuteLabel => 'Unmute';

  @override
  String get callTurnOffVideo => 'Turn off video';

  @override
  String get callTurnOnVideo => 'Turn on video';

  @override
  String get callShareScreen => 'Share screen';

  @override
  String get callStopSharing => 'Stop sharing';

  @override
  String get callSwitchCameraLabel => 'Switch';

  @override
  String get callLeaveLabel => 'Leave';

  @override
  String get callParticipantsLabel => 'Participants';

  @override
  String get callJoiningMeeting => 'Joining meeting...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count votes ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count participants';
  }

  @override
  String get chatNoMediaUrlAvailable => 'No media URL available';

  @override
  String chatDownloadFailed(String code) {
    return 'Download failed: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get chatMusicLinkLabel => 'Music link';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Red packets and transfers cannot be forwarded';

  @override
  String commonShareFailed(String error) {
    return 'Share failed: $error';
  }

  @override
  String get commonTapToRetry => 'Tap to retry';

  @override
  String get chatDefaultRedPacketGreeting => 'Best wishes for prosperity';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Allow others to search and join';

  @override
  String get groupConfirmClearChatHistory =>
      'Are you sure you want to clear chat history?';

  @override
  String get groupCreateGroupToChat => 'Create a group to start chatting';

  @override
  String get groupEditGroupAnnouncement => 'Edit group announcement';

  @override
  String get groupEditGroupDescription => 'Edit group description';

  @override
  String get groupEnterGroupAnnouncement => 'Enter group announcement';

  @override
  String groupMemberCountClickToCopy(Object count) {
    return '$count members, click to copy group ID';
  }

  @override
  String get groupNoPermissionToEditGroupName =>
      'You don\'t have permission to edit group name';

  @override
  String get authEmailAddress => 'Email Address';

  @override
  String get commonEnterEmailAddress => 'Enter email address';

  @override
  String get authEmailRecoveryHint => 'Used for password recovery';

  @override
  String get commonInvalidEmailFormat => 'Please enter a valid email address';

  @override
  String get authOptional => 'Optional';

  @override
  String get authResetPassword => 'Reset Password';

  @override
  String get authEnterRegisteredEmail =>
      'Enter the email address you registered with';

  @override
  String get authSendResetCode => 'Send Reset Code';

  @override
  String authResetCodeSent(String email) {
    return 'Reset code sent to $email';
  }

  @override
  String get authEnterResetCode => 'Enter reset code';

  @override
  String get authSetNewPassword => 'Set New Password';

  @override
  String get commonConfirmNewPassword => 'Confirm New Password';

  @override
  String get commonNewPassword => 'New Password';

  @override
  String get authPasswordResetSuccess =>
      'Password reset successful. Please login with your new password.';

  @override
  String get authResetPasswordFailed => 'Reset password failed';

  @override
  String get settingsChangePassword => 'Change Password';

  @override
  String get settingsCurrentPassword => 'Current Password';

  @override
  String get settingsEnterCurrentPassword => 'Enter current password';

  @override
  String get settingsEnterNewPassword => 'Enter new password';

  @override
  String get settingsPasswordChanged =>
      'Password changed successfully. Please login with your new password.';

  @override
  String get settingsChangePasswordFailed => 'Change password failed';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'New password must be different from current password';

  @override
  String get settingsChangePasswordInfo =>
      'After changing password, you will be logged out and need to login with the new password.';

  @override
  String get settingsPasswordRequirements => 'Password requirements:';

  @override
  String get settingsSecurityNote =>
      'For security, you will need to re-login on all devices after changing password.';

  @override
  String get settingsSecurity => 'Security';

  @override
  String get settingsCurrentBoundEmail => 'Current bound email';

  @override
  String get settingsNewEmailAddress => 'New Email Address';

  @override
  String get settingsEnterNewEmail => 'Enter new email address';

  @override
  String get settingsVerificationCode => 'Verification Code';

  @override
  String get settingsVerificationCodeSent => 'Verification code sent';

  @override
  String get settingsCodeSentTo => 'Verification code sent to';

  @override
  String get settingsDidNotReceiveCode => 'Didn\'t receive the code?';

  @override
  String get settingsEmailChangedSuccess => 'Email changed successfully';

  @override
  String get settingsChangeEmailFailed => 'Change email failed';

  @override
  String get settingsEmailSecurityNote =>
      'Your email is used for password recovery. Please keep it secure.';

  @override
  String get commonGoogleLogin => 'Sign in with Google';

  @override
  String get commonAppleLogin => 'Sign in with Apple';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageChanged => 'Language changed';

  @override
  String get settingsTranslation => 'Translation';

  @override
  String get settingsTranslateTextTo => 'Translate text to';

  @override
  String get settingsTranslateDescription =>
      'Select the language you want messages to be translated into.';

  @override
  String get settingsAutoTranslate => 'Auto-translate received messages';

  @override
  String get settingsAutoTranslateDescription =>
      'Automatically translate messages received in chat to your selected language.';

  @override
  String get settingsBiometricLogin => 'Biometric Login';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Login with $type';
  }

  @override
  String get settingsBiometricLoginEnabled => 'Biometric login enabled';

  @override
  String get settingsBiometricLoginDisabled => 'Biometric login disabled';

  @override
  String get settingsEnableBiometricLogin => 'Enable biometric login';

  @override
  String get settingsBiometricEnabled => 'Enabled - Use biometric to login';

  @override
  String get settingsBiometricDisabled => 'Disabled - Tap to enable';

  @override
  String get settingsBiometricNeedRelogin =>
      'Please log out and log in again to enable biometric login';

  @override
  String get authOr => 'OR';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'Camera access is restricted on this device';

  @override
  String get authPasskeyLabel => 'Passkey';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'Apple';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get authSsoNotConfigured =>
      'This server has not configured SSO login providers';

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
      'Enter poke suffix, e.g.: on the shoulder';

  @override
  String get groupAlbum => 'Group Album';

  @override
  String get groupFiles => 'Group Files';

  @override
  String get groupImages => 'Images';

  @override
  String get groupVideos => 'Videos';

  @override
  String get groupTotal => 'Total';

  @override
  String get groupSize => 'Size';

  @override
  String get groupNoMedia => 'No Media';

  @override
  String get groupNoMediaDescription => 'No photos or videos in this group yet';

  @override
  String get groupDocuments => 'Docs';

  @override
  String get groupNoFiles => 'No Files';

  @override
  String get groupNoFilesDescription => 'No files in this group yet';

  @override
  String groupDownloadStarted(String filename) {
    return 'Downloading $filename...';
  }

  @override
  String get contactNoCommonGroups => 'No common groups';

  @override
  String get contactNoCommonGroupsDescription =>
      'You don\'t have any groups in common';

  @override
  String get chatVoiceMessage => 'Voice';

  @override
  String get chatMessage => 'Message';

  @override
  String get conversationHideChat => 'Hide';

  @override
  String get settingsQuickReply => 'Quick Reply';

  @override
  String get commonTranslate => 'Translate';

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
  String commonConversationWithId(Object roomId) {
    return 'Conversation: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return 'Contact: $userId';
  }

  @override
  String get commonDiscover => 'Discover';

  @override
  String commonDeveloping(Object title) {
    return '$title\n(Coming soon)';
  }

  @override
  String get commonPageNotFound => 'Page not found';

  @override
  String get commonBackToHome => 'Back to Home';

  @override
  String get settingsMessageNotifications => 'Message notifications';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Receive new message notifications';

  @override
  String get settingsShowMessagePreview => 'Show message preview';

  @override
  String get settingsShowMessageContentInNotification =>
      'Show message content in notification';

  @override
  String get settingsNotificationSound => 'Notification Sound';

  @override
  String get settingsPlaySoundOnMessage => 'Play sound when receiving messages';

  @override
  String get commonVibration => 'Vibration';

  @override
  String get settingsVibrateOnMessage => 'Vibrate when receiving messages';

  @override
  String get settingsDoNotDisturbMode => 'Do not disturb';

  @override
  String get settingsDoNotDisturbDescription =>
      'Do not receive notifications during specified time';

  @override
  String get settingsStartTime => 'Start Time';

  @override
  String get settingsEndTime => 'End Time';

  @override
  String get settingsDeleteQuickReply => 'Delete Quick Reply';

  @override
  String get settingsEditQuickReply => 'Edit Quick Reply';

  @override
  String get settingsAddQuickReply => 'Add Quick Reply';

  @override
  String get settingsManageQuickReplies => 'Manage Quick Replies';

  @override
  String get settingsNoQuickReplies => 'No quick replies';

  @override
  String get settingsDefaultQuickReplies =>
      'Default quick replies will be shown';

  @override
  String get settingsWhoCanSee => 'Who can see';

  @override
  String get settingsLastSeen => 'Last Seen';

  @override
  String get settingsHiddenChats => 'Hidden Chats';

  @override
  String get settingsMessagesLabel => 'Messages';

  @override
  String get settingsAllowStrangerMessages => 'Allow stranger messages';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Receive messages from non-contacts';

  @override
  String get settingsReadReceipts => 'Read Receipts';

  @override
  String get settingsLetOthersKnowYouRead => 'Let others know you read';

  @override
  String get settingsTypingIndicator => 'Typing indicator';

  @override
  String get settingsLetOthersKnowYouTyping => 'Let others know you are typing';

  @override
  String get settingsEveryone => 'Everyone';

  @override
  String get settingsContactsOnly => 'Contacts Only';

  @override
  String get settingsNobody => 'Nobody';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Who can see $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Version $version';
  }

  @override
  String get settingsCheckForUpdates => 'Check for updates';

  @override
  String get settingsOpenSourceLicenses => 'Open Source Licenses';

  @override
  String get settingsFeedbackAndSuggestions => 'Feedback and suggestions';

  @override
  String get settingsBuiltOnMatrix => 'Built on Matrix Protocol';

  @override
  String get settingsNoHiddenChats => 'No hidden chats';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Chats you hide will appear here';

  @override
  String get settingsUnhideChat => 'Unhide';

  @override
  String get settingsDarkMode => 'Dark mode';

  @override
  String get settingsFontSize => 'Font size';

  @override
  String get settingsBubbleStyle => 'Bubble style';

  @override
  String get settingsFollowSystem => 'Follow system';

  @override
  String get settingsAutoSwitchBySystem => 'Auto switch by system';

  @override
  String get settingsLightMode => 'Light mode';

  @override
  String get settingsAlwaysUseLightTheme => 'Always use light theme';

  @override
  String get settingsDarkModeOption => 'Dark mode option';

  @override
  String get settingsAlwaysUseDarkTheme => 'Always use dark theme';

  @override
  String get settingsFontSizeSmall => 'Small';

  @override
  String get settingsFontSizeStandard => 'Standard';

  @override
  String get settingsFontSizeLarge => 'Large';

  @override
  String get settingsFontSizeExtraLarge => 'Extra large';

  @override
  String get settingsBubbleStyleWechat => 'WeChat style';

  @override
  String get settingsBubbleStyleWechatDesc => 'Classic WeChat bubble style';

  @override
  String get settingsBubbleStyleModern => 'Modern style';

  @override
  String get settingsBubbleStyleModernDesc => 'Clean modern bubble style';

  @override
  String get settingsBubbleStyleClassic => 'Classic style';

  @override
  String get settingsBubbleStyleClassicDesc => 'Traditional bubble style';

  @override
  String get discoverVideoChannels => 'Channels';

  @override
  String get discoverLive => 'Live';

  @override
  String get discoverListen => 'Listen';

  @override
  String get discoverWatch => 'Watch';

  @override
  String get discoverSearchDiscover => 'Search';

  @override
  String get discoverNearbyPeople => 'Nearby';

  @override
  String get discoverGames => 'Games';

  @override
  String get discoverMiniPrograms => 'Mini Programs';

  @override
  String get chatAlreadyInCall => 'Already in a call';

  @override
  String get commonConnectionFailed => 'Connection failed';

  @override
  String get chatCallRejected => 'Call declined';

  @override
  String get chatNoAnswer => 'No answer';

  @override
  String get commonClose => 'Close';

  @override
  String get chatSelectContact => 'Select Contact';

  @override
  String get chatVoteRemoved => 'Vote removed';

  @override
  String get chatVoteChanged => 'Vote changed';

  @override
  String get chatVoted => 'Voted';

  @override
  String chatReplyTo(String name) {
    return 'Reply to $name';
  }

  @override
  String get chatCurrentLocation => 'Current Location';

  @override
  String chatNearbyPlace(int index) {
    return 'Nearby Place $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'About $distance';
  }

  @override
  String get chatAddress => 'Address';

  @override
  String get chatLatitude => 'Latitude';

  @override
  String get chatLongitude => 'Longitude';

  @override
  String get groupDescriptionUpdated => 'Group description updated';

  @override
  String get groupAvatarUpdated => 'Group avatar updated';

  @override
  String get groupVisibilityUpdated => 'Group visibility updated';

  @override
  String get groupChannelCreated => 'Channel created';

  @override
  String get groupChannelUpdated => 'Channel updated';

  @override
  String get groupChannelDeleted => 'Channel deleted';

  @override
  String get callDecline => 'Decline';

  @override
  String get callAnswer => 'Answer';

  @override
  String get callIncomingVideoCall => 'Incoming video call';

  @override
  String get callIncomingVoiceCall => 'Incoming voice call';

  @override
  String get callVideoCallInProgress => 'Video call in progress';

  @override
  String get callVoiceCallInProgress => 'Voice call in progress';

  @override
  String get callReconnectingCall => 'Reconnecting...';

  @override
  String get callEnded => 'Call ended';

  @override
  String get callFailed => 'Call failed';

  @override
  String get callLivekitNotConfigured => 'LiveKit not configured';

  @override
  String callJoinMeetingFailed(Object error) {
    return 'Failed to join meeting: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return 'Screen share failed: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bean';

  @override
  String get profileNoN42Bean => 'No N42 Bean';

  @override
  String get profileN42BeanDetails => 'N42 Bean Details';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean is a token used to redeem virtual items and services in N42. Currently available for:';

  @override
  String get profileN42BeanFeature1 => 'Exclusive member stickers and themes';

  @override
  String get profileN42BeanFeature2 => 'Chat bubble customization';

  @override
  String get profileN42BeanFeature3 => 'Red packet cover customization';

  @override
  String get profileN42BeanFeature4 => 'Exclusive nickname badge';

  @override
  String get profileN42BeanFeature5 => 'Group chat privileges';

  @override
  String get profileN42BeanFeature6 => 'Cloud storage expansion';

  @override
  String get profileN42BeanFeature7 => 'Video call beauty filters';

  @override
  String get profileN42BeanFeature8 => 'Moments background customization';

  @override
  String get profileN42BeanFeature9 => 'VIP customer service priority';

  @override
  String get profileGotIt => 'Got it';

  @override
  String get profileNoN42BeanRecords => 'No N42 Bean records';

  @override
  String get profileMoodAndThoughts => 'Mood & Thoughts';

  @override
  String get profileStatusHappy => 'Happy';

  @override
  String get profileStatusCracked => 'Shattered';

  @override
  String get profileStatusLucky => 'Lucky';

  @override
  String get profileStatusSunny => 'Sunny';

  @override
  String get profileStatusTired => 'Tired';

  @override
  String get profileStatusDaydream => 'Daydream';

  @override
  String get profileStatusRushing => 'Rushing';

  @override
  String get profileStatusOverthinking => 'Overthinking';

  @override
  String get profileStatusEnergized => 'Energized';

  @override
  String get profileWorkAndStudy => 'Work & Study';

  @override
  String get profileStatusWorking => 'Working';

  @override
  String get profileStatusStudying => 'Studying';

  @override
  String get profileStatusBusy => 'Busy';

  @override
  String get profileStatusSlacking => 'Slacking';

  @override
  String get profileStatusTraveling => 'Traveling';

  @override
  String get profileStatusGoingHome => 'Going Home';

  @override
  String get profileStatusDnd => 'Do Not Disturb';

  @override
  String get profileActivities => 'Activities';

  @override
  String get profileStatusHanging => 'Hanging Out';

  @override
  String get profileStatusCheckIn => 'Check In';

  @override
  String get profileStatusExercising => 'Exercising';

  @override
  String get profileStatusCoffee => 'Coffee';

  @override
  String get profileStatusBubbleTea => 'Bubble Tea';

  @override
  String get profileStatusEating => 'Eating';

  @override
  String get profileStatusParenting => 'Parenting';

  @override
  String get profileStatusSavingWorld => 'Saving World';

  @override
  String get profileStatusSelfie => 'Selfie';

  @override
  String get profileRest => 'Rest';

  @override
  String get profileStatusRetreat => 'Retreat';

  @override
  String get profileStatusHome => 'Home';

  @override
  String get profileStatusSleeping => 'Sleeping';

  @override
  String get profileStatusCatLover => 'Cat Lover';

  @override
  String get profileStatusDogWalking => 'Walking Dog';

  @override
  String get profileStatusGaming => 'Gaming';

  @override
  String get profileStatusListening => 'Listening';

  @override
  String get profileEditAddress => 'Edit Address';

  @override
  String get profileRecipient => 'Recipient';

  @override
  String get profileEnterRecipientName => 'Enter recipient name';

  @override
  String get profilePhoneNumber => 'Phone Number';

  @override
  String get profileEnterPhoneNumber => 'Enter phone number';

  @override
  String get profileRegionHint => 'Province/City/District';

  @override
  String get profileDetailedAddress => 'Detailed Address';

  @override
  String get profileDetailedAddressHint => 'Street, building number, etc.';

  @override
  String get profileSetAsDefaultAddress => 'Set as default address';

  @override
  String get profilePleaseCompleteInfo => 'Please complete all fields';

  @override
  String get profileEditInvoice => 'Edit Invoice';

  @override
  String get profileInvoiceType => 'Invoice Type';

  @override
  String get profileCompanyName => 'Company Name';

  @override
  String get profilePersonalName => 'Personal Name';

  @override
  String get profileEnterCompanyName => 'Enter company name';

  @override
  String get profileEnterName => 'Enter name';

  @override
  String get profileTaxIdNumber => 'Tax ID Number';

  @override
  String get profileEnterTaxIdNumber => 'Enter tax ID number';

  @override
  String get profileBankNameOptional => 'Bank Name (Optional)';

  @override
  String get profileEnterBankName => 'Enter bank name';

  @override
  String get profileBankAccountOptional => 'Bank Account (Optional)';

  @override
  String get profileEnterBankAccount => 'Enter bank account';

  @override
  String get profileCompanyAddressOptional => 'Company Address (Optional)';

  @override
  String get profileEnterCompanyAddress => 'Enter company address';

  @override
  String get profileCompanyPhoneOptional => 'Company Phone (Optional)';

  @override
  String get profileEnterCompanyPhone => 'Enter company phone';

  @override
  String get profileSetAsDefaultInvoice => 'Set as default invoice';

  @override
  String get profileRingtoneVibrate => 'Vibrate';

  @override
  String get profileRingtoneSilent => 'Silent';

  @override
  String get profileVibrateMode => 'Vibrate mode';

  @override
  String get profileSilentMode => 'Silent mode';

  @override
  String profilePlayFailed(Object ringtoneName) {
    return 'Failed to play: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
    return 'Playing: $ringtoneName';
  }

  @override
  String get profileStop => 'Stop';

  @override
  String get profileSelectRingtone => 'Select Ringtone';

  @override
  String get profileLoadingRingtones => 'Loading ringtones...';

  @override
  String get profileNoRingtonesFound => 'No ringtones found';

  @override
  String mainMessagesWithCount(int count) {
    return 'Messages($count)';
  }

  @override
  String get storyViewers => 'Viewers';

  @override
  String get storyNoViewers => 'No viewers yet';

  @override
  String get storyReplyToStory => 'Reply to story...';

  @override
  String get commonCopiedToClipboard => 'Copied to clipboard';

  @override
  String get commonMore => 'More';

  @override
  String get commonTranslating => 'Translating...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Translated from $language';
  }

  @override
  String get commonTranslation => 'Translation';

  @override
  String get commonTranslationFailed => 'Translation failed';

  @override
  String get commonAllRead => 'All read';

  @override
  String commonReadCount(Object count) {
    return '$count read';
  }

  @override
  String get commonYouRecalledMessage => 'You recalled a message';

  @override
  String get commonMessageRecalled => 'Message recalled';

  @override
  String get commonReEdit => 'Re-edit';

  @override
  String get commonWalletArea => 'Wallet area';

  @override
  String get callIncomingCall => 'Incoming call';

  @override
  String get callMissedCall => 'Missed call';

  @override
  String get groupRemoveAdmin => 'Remove Admin';

  @override
  String get chatSelectCurrency => 'Select currency';

  @override
  String get chatSelectEmoji => 'Select Emoji';

  @override
  String get chatSelectRedPacketCover => 'Select Cover';

  @override
  String get groupSetAsAdmin => 'Set as Admin';

  @override
  String get chatVideoPlaybackFailed => 'Video playback failed';

  @override
  String get groupViewProfile => 'View Profile';

  @override
  String get favoriteAddLinkComingSoon => 'Add link feature coming soon';

  @override
  String get favoriteNewNoteComingSoon => 'New note feature coming soon';

  @override
  String get qrcodeSaveFeatureComingSoon => 'Save feature coming soon';

  @override
  String get qrcodeShareFeatureComingSoon => 'Share feature coming soon';

  @override
  String qrcodeProcessFailed(String error) {
    return 'Failed to process QR code: $error';
  }

  @override
  String get securityDeviceIdRequired => 'Device ID is required';

  @override
  String securityVerificationStartFailed(String error) {
    return 'Failed to start verification: $error';
  }

  @override
  String get securityVerificationFailed => 'Verification failed';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return 'Verification failed: $reason';
  }

  @override
  String get securityEmojiMismatchRejected =>
      'Verification rejected - emoji did not match';

  @override
  String get securityWaitingForDeviceAccept =>
      'Waiting for the other device to accept...';

  @override
  String get securityVerifyDevice => 'Verify this device';

  @override
  String get securityConfirmEmojiMatch =>
      'Confirm the emoji below are displayed on both devices, in the same order';

  @override
  String get securityEmojiDontMatch => 'They don\'t match';

  @override
  String get securityEmojiMatch => 'They match';

  @override
  String get securityWaitingForDeviceConfirm =>
      'Waiting for the other device to confirm...';

  @override
  String get securityVerificationSuccess => 'Verification successful!';

  @override
  String get securityDeviceVerifiedTrusted =>
      'This device is now verified and trusted.';

  @override
  String get securityCompareEmoji => 'Compare the emoji on both devices';

  @override
  String get securityCompareNumbers => 'Compare the numbers on both devices';

  @override
  String get commonTryAgain => 'Try Again';

  @override
  String get commonDone => 'Done';

  @override
  String get chatExportTitle => 'Export Chat';

  @override
  String get chatExportSuccess => 'Export successful';

  @override
  String chatExportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get chatExportFormat => 'Export Format';

  @override
  String get chatExportHtmlDesc => 'Readable in any browser with styled layout';

  @override
  String get chatExportJsonDesc => 'Machine-readable structured data format';

  @override
  String get chatExportDateRange => 'Date Range';

  @override
  String get chatExportAll => 'All Messages';

  @override
  String get chatExportLastWeek => 'Last 7 Days';

  @override
  String get chatExportLastMonth => 'Last Month';

  @override
  String get chatExportLast3Months => 'Last 3 Months';

  @override
  String get chatExportMessageCount => 'Messages to export';

  @override
  String get chatExportButton => 'Export & Share';

  @override
  String get chatMediaGallery => 'Media Gallery';

  @override
  String get chatExportHistory => 'Export Chat History';

  @override
  String get pdfLoadFailed => 'Failed to load PDF';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => 'All';

  @override
  String get mediaImages => 'Images';

  @override
  String get mediaVideos => 'Videos';

  @override
  String get mediaFiles => 'Files';

  @override
  String get mediaAudio => 'Audio';

  @override
  String mediaItemsCount(int count) {
    return '$count items';
  }

  @override
  String get mediaNoMediaFound => 'No media found';

  @override
  String get spacesTitle => 'Communities';

  @override
  String get spacesCreate => 'Create Community';

  @override
  String get spacesJoined => 'Joined';

  @override
  String get spacesDiscover => 'Discover';

  @override
  String get spacesNoJoined => 'No communities joined yet';

  @override
  String get spacesExplore => 'Explore Communities';

  @override
  String get spacesNoPublic => 'No public communities found';

  @override
  String get spacesJoin => 'Join';

  @override
  String get spacesSubSpaces => 'Sub-Communities';

  @override
  String get spacesChannels => 'Channels';

  @override
  String spacesMembersCount(int count) {
    return '$count members';
  }

  @override
  String get spacesPublic => 'Public';

  @override
  String get spacesPrivate => 'Private';

  @override
  String get spacesSuggested => 'Suggested';

  @override
  String spacesChannelsCount(int count) {
    return '$count channels';
  }

  @override
  String get callInCallChat => 'In-Call Chat';

  @override
  String callMessagesCount(int count) {
    return '$count messages';
  }

  @override
  String get callNoMessagesYet =>
      'No messages yet.\nSend a message to get started.';

  @override
  String get callTypeMessage => 'Type a message...';

  @override
  String get callYouSender => 'You';

  @override
  String get callChatLabel => 'Chat';

  @override
  String get chatEdited => 'Edited';

  @override
  String get chatEditHistory => 'Edit History';

  @override
  String get chatOriginalMessage => 'Original';

  @override
  String chatEditedAt(String time) {
    return 'Edited at $time';
  }

  @override
  String get chatViewOnce => 'View Once';

  @override
  String get chatViewOncePhoto => 'View Once Photo';

  @override
  String get chatViewOnceVideo => 'View Once Video';

  @override
  String get chatViewOnceViewed => 'Viewed';

  @override
  String get chatViewOnceExpired => 'Expired';

  @override
  String get chatViewOnceTap => 'Tap to view';

  @override
  String get chatAutoFaceBlur => 'Blur faces in photos';

  @override
  String get chatAutoFaceBlurDesc =>
      'Automatically blur faces when sending photos';

  @override
  String get threadReplyInThread => 'Reply in thread';

  @override
  String threadReplies(int count) {
    return '$count replies';
  }

  @override
  String get threadReply => '1 reply';

  @override
  String threadLatestReply(String preview) {
    return 'Latest: $preview';
  }

  @override
  String get threadTitle => 'Thread';

  @override
  String get threadReplyPlaceholder => 'Reply in thread...';

  @override
  String threadParticipants(int count) {
    return '$count participants';
  }

  @override
  String get voiceRoomTitle => 'Voice Room';

  @override
  String get voiceRoomCreate => 'Create Voice Room';

  @override
  String get voiceRoomJoin => 'Join';

  @override
  String get voiceRoomLeave => 'Leave';

  @override
  String get voiceRoomEnd => 'End Room';

  @override
  String get voiceRoomRaiseHand => 'Raise Hand';

  @override
  String get voiceRoomLowerHand => 'Lower Hand';

  @override
  String get voiceRoomMute => 'Mute';

  @override
  String get voiceRoomUnmute => 'Unmute';

  @override
  String get voiceRoomHost => 'Host';

  @override
  String get voiceRoomSpeakers => 'Speakers';

  @override
  String get voiceRoomListeners => 'Listeners';

  @override
  String get voiceRoomLive => 'LIVE';

  @override
  String get voiceRoomEnded => 'Ended';

  @override
  String get voiceRoomScheduled => 'Scheduled';

  @override
  String get voiceRoomApprove => 'Approve';

  @override
  String get voiceRoomDemote => 'Move to Listener';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name raised their hand';
  }

  @override
  String get voiceRoomName => 'Room name';

  @override
  String get voiceRoomTopic => 'Topic (optional)';

  @override
  String get voiceRoomNoActive => 'No active voice rooms';

  @override
  String get voiceRoomConnecting => 'Connecting...';

  @override
  String get usernameTitle => 'Username';

  @override
  String get usernameSet => 'Set Username';

  @override
  String get usernameChange => 'Change Username';

  @override
  String get usernamePlaceholder => 'Enter username';

  @override
  String get usernameAvailable => 'Username available';

  @override
  String get usernameUnavailable => 'Username already taken';

  @override
  String get usernameInvalid =>
      '3-30 characters, lowercase letters, numbers, underscore. Must start with a letter.';

  @override
  String get usernameReserved => 'This username is reserved';

  @override
  String get usernameSaved => 'Username saved';

  @override
  String get usernameSearchHint => 'Search by @username';

  @override
  String get ensName => 'ENS Name';

  @override
  String get ensLinked => 'Linked to ENS';

  @override
  String get ensResolving => 'Resolving ENS...';

  @override
  String get ensNotFound => 'ENS name not found';

  @override
  String get tokenGateTitle => 'Token Gate';

  @override
  String get tokenGateEnable => 'Enable Token Gate';

  @override
  String get tokenGateDisable => 'Disable Token Gate';

  @override
  String get tokenGateAddRule => 'Add Rule';

  @override
  String get tokenGateRemoveRule => 'Remove Rule';

  @override
  String get tokenGateContractAddress => 'Contract Address';

  @override
  String get tokenGateMinBalance => 'Minimum Balance';

  @override
  String get tokenGateTokenId => 'Token ID (ERC-1155)';

  @override
  String get tokenGateChainId => 'Chain ID';

  @override
  String get tokenGateVerifying => 'Verifying token holdings...';

  @override
  String get tokenGateVerified => 'Verification passed';

  @override
  String get tokenGateDenied => 'You do not meet the token requirements';

  @override
  String get tokenGateOperatorAnd => 'Must meet ALL rules';

  @override
  String get tokenGateOperatorOr => 'Must meet ANY rule';

  @override
  String get tokenGateRuleErc20 => 'ERC-20 Token';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => 'Multi-Token (ERC-1155)';

  @override
  String get tokenGateRuleNative => 'Native Token';

  @override
  String get tokenGateSaved => 'Token gate saved';

  @override
  String get tokenGateEnableDescription =>
      'Require members to hold tokens to join';

  @override
  String get tokenGateOperator => 'Rule Logic';

  @override
  String get tokenGateRules => 'Rules';

  @override
  String get tokenGateSymbol => 'Symbol (optional)';

  @override
  String get tokenGateChain => 'Chain';

  @override
  String get tokenGateTokenStandard => 'Token Standard';

  @override
  String get tokenGateDenialMessage => 'Denial Message';

  @override
  String get tokenGateDenialMessageHint =>
      'Message shown when verification fails';

  @override
  String get tokenGateVerifyTitle => 'Token Verification';

  @override
  String get tokenGateVerifyPassed => 'Verification Passed';

  @override
  String get tokenGateVerifyFailed => 'Verification Failed';

  @override
  String get tokenGateRetryVerify => 'Retry';

  @override
  String get tokenGateRequired => 'Required';

  @override
  String get tokenGateYourBalance => 'Your balance';

  @override
  String get tokenGateRulesActive => 'rules active';

  @override
  String get tokenGateDisabled => 'Disabled';

  @override
  String get ensNotBound => 'Not bound';

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
  String get settingsThisDevice => 'This device';

  @override
  String get settingsJustNow => 'Just now';

  @override
  String get settingsDeviceId => 'Device ID';

  @override
  String get settingsStatus => 'Status';

  @override
  String get settingsLastActive => 'Last active';

  @override
  String get settingsIpAddress => 'IP address';

  @override
  String get settingsRenameDevice => 'Rename device';

  @override
  String get settingsDeviceNameHint => 'Enter device name';

  @override
  String get settingsDeviceRenamed => 'Device renamed';

  @override
  String get settingsRenameFailed => 'Rename failed';

  @override
  String get settingsRemoteLogout => 'Remote logout';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return 'Are you sure you want to log out \"$deviceName\"? This action cannot be undone.';
  }

  @override
  String get settingsDeviceLoggedOut => 'Device logged out';

  @override
  String get settingsLogoutFailed => 'Logout failed';

  @override
  String get settingsLogout => 'Logout';

  @override
  String get settingsVerifyIdentity => 'Verify identity';

  @override
  String get settingsEnterPasswordToConfirm =>
      'Enter your password to confirm this action.';

  @override
  String get scheduledSendTitle => 'Schedule message';

  @override
  String get scheduledSendInOneHour => 'In 1 hour';

  @override
  String get scheduledSendTonight => 'Tonight (8:00 PM)';

  @override
  String get scheduledSendTomorrowMorning => 'Tomorrow morning (9:00 AM)';

  @override
  String get scheduledSendCustom => 'Pick a date & time';

  @override
  String get scheduledMessageLabel => 'Scheduled';

  @override
  String get scheduledMessageCancel => 'Cancel scheduled message';

  @override
  String get chatLockTitle => 'Chat lock';

  @override
  String get chatLockEnable => 'Lock this chat';

  @override
  String get chatLockDisable => 'Unlock this chat';

  @override
  String get chatLockDescription =>
      'Locked chats require biometric or PIN verification to open';

  @override
  String get chatLockVerifyTitle => 'Chat locked';

  @override
  String get chatLockVerifySubtitle => 'Verify to access this chat';

  @override
  String get chatLockVerifyFailed => 'Verification failed';

  @override
  String get chatLockEnabled => 'Chat locked';

  @override
  String get chatLockDisabled => 'Chat unlocked';

  @override
  String get chatLockPinTitle => 'Enter PIN';

  @override
  String get chatLockPinSetTitle => 'Set PIN';

  @override
  String get chatLockPinConfirmTitle => 'Confirm PIN';

  @override
  String get chatLockPinMismatch => 'PIN does not match';

  @override
  String get chatLockUseBiometric => 'Use biometric';

  @override
  String get chatLockUsePin => 'Use PIN';

  @override
  String get mediaEditorUndo => 'Undo';

  @override
  String get mediaEditorRedo => 'Redo';

  @override
  String get mediaEditorCrop => 'Crop';

  @override
  String get mediaEditorFilter => 'Filter';

  @override
  String get mediaEditorDraw => 'Draw';

  @override
  String get mediaEditorText => 'Text';

  @override
  String get aiAssistant => 'AI Assistant';

  @override
  String get aiAssistantWelcome =>
      'Hello! I\'m the N42 AI Assistant. How can I help you?';

  @override
  String get aiAssistantNotConfigured => 'AI service not configured';

  @override
  String get aiAssistantSettings => 'AI Settings';

  @override
  String get aiAssistantClearHistory => 'Clear chat history';

  @override
  String get aiAssistantClearHistoryConfirm =>
      'Are you sure you want to clear all AI chat history?';

  @override
  String get aiAssistantStopGenerating => 'Stop generating';

  @override
  String get aiAssistantModel => 'Model';

  @override
  String get aiAssistantTemperature => 'Temperature';

  @override
  String get aiAssistantMaxTokens => 'Max tokens';

  @override
  String get aiAssistantContextWindow => 'Context window';

  @override
  String get aiAssistantServiceStatus => 'Service status';

  @override
  String get aiAssistantAvailable => 'Available';

  @override
  String get aiAssistantUnavailable => 'Unavailable';

  @override
  String get aiSummarize => 'AI Summary';

  @override
  String aiSummarizeUnread(int count) {
    return 'Summarize $count unread messages';
  }

  @override
  String get aiSummarizeLoading => 'Summarizing...';

  @override
  String get aiSummarizeError => 'Failed to summarize';

  @override
  String get aiRewrite => 'AI Rewrite';

  @override
  String get aiRewriteFormal => 'Formal';

  @override
  String get aiRewriteCasual => 'Casual';

  @override
  String get aiRewritePlayful => 'Playful';

  @override
  String get aiRewriteProfessional => 'Professional';

  @override
  String get aiRewriteAccept => 'Use';

  @override
  String get aiRewriteCancel => 'Cancel';

  @override
  String get aiRewriteLoading => 'Rewriting...';

  @override
  String get aiLinkSummary => 'AI Summary';

  @override
  String get aiLinkSummaryAnalyzing => 'Analyzing...';

  @override
  String get chatFolderManagement => 'Manage Folders';

  @override
  String get chatFolderSystem => 'System Folders';

  @override
  String get chatFolderCustom => 'Custom Folders';

  @override
  String get chatFolderEmpty => 'No custom folders yet';

  @override
  String get chatFolderCreate => 'Create Folder';

  @override
  String get chatFolderEdit => 'Edit Folder';

  @override
  String get chatFolderNameHint => 'Folder name';

  @override
  String get chatFolderAll => 'All';

  @override
  String get chatFolderUnread => 'Unread';

  @override
  String get chatFolderPersonal => 'Personal';

  @override
  String get chatFolderGroups => 'Groups';

  @override
  String get chatFolderChannels => 'Channels';

  @override
  String get chatFolderMuted => 'Muted';

  @override
  String get storyAddMusic => 'Add Music';

  @override
  String get storyChangeMusic => 'Change Music';

  @override
  String get storyBackgroundMusic => 'Background Music';

  @override
  String get storyMusicPreview => 'Preview (max 15s)';

  @override
  String get storyChooseFromDevice => 'Choose from Device';

  @override
  String get storyUseThisMusic => 'Use This Music';

  @override
  String get authPasskeyNotSupported =>
      'Passkey is not supported on this device';

  @override
  String get authPasskeyRegister => 'Register Passkey';

  @override
  String get authPasskeyNoRegistered => 'No passkeys registered';

  @override
  String get authPasskeyRegisterHint =>
      'Register a passkey for this account. Standalone passkey sign-in will be enabled later.';

  @override
  String get authPasskeyNameYours => 'Name your Passkey';

  @override
  String get authPasskeyRegistered => 'Passkey saved to this account';

  @override
  String get authPasskeyDeleted => 'Passkey removed from this account';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return 'Delete passkey \"$name\"? You will need to register it again before using passkey sign-in later.';
  }

  @override
  String get momentVisibilityPublic => 'Public';

  @override
  String get momentVisibilityPrivate => 'Private';

  @override
  String get momentVisibilityPartial => 'Selected Friends';

  @override
  String get momentVisibilityExcluded => 'Exclude Some Friends';

  @override
  String momentUserMoments(String userName) {
    return '$userName\'s Moments';
  }

  @override
  String get momentForwardTo => 'Forward to';

  @override
  String get momentForwardSuccess => 'Forwarded successfully';

  @override
  String get momentSelectFriends => 'Select Friends';

  @override
  String get momentSelectTags => 'Select by Tags';

  @override
  String momentSelectedCount(int count) {
    return 'Selected ($count)';
  }

  @override
  String get momentNoMomentsYet => 'No moments yet';

  @override
  String get momentForwardMoment => 'Forward Moment';

  @override
  String get momentAddComment => 'Add a comment...';

  @override
  String momentForwardContent(String content) {
    return '[Moment] $content';
  }

  @override
  String get momentDeleteMoment => 'Delete Moment';

  @override
  String get momentDeleteConfirm =>
      'Are you sure you want to delete this moment?';

  @override
  String get momentComment => 'Comment';

  @override
  String get momentWriteComment => 'Write a comment...';

  @override
  String get momentLike => 'Like';

  @override
  String get momentUnlike => 'Unlike';

  @override
  String get momentForward => 'Forward';

  @override
  String get momentDelete => 'Delete';

  @override
  String get momentReply => 'reply';

  @override
  String get momentMoment => 'Moment';

  @override
  String momentLikesCount(int count) {
    return '$count likes';
  }

  @override
  String momentCommentsCount(int count) {
    return '$count comments';
  }

  @override
  String get momentNoComments => 'No comments yet';

  @override
  String get momentFailedToLoad => 'Failed to load image';

  @override
  String momentReplyTo(String userName) {
    return 'Reply to $userName...';
  }

  @override
  String get momentNoConversations => 'No conversations';

  @override
  String get momentJustNow => 'just now';

  @override
  String momentMinutesAgo(int count) {
    return '${count}m ago';
  }

  @override
  String momentHoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String momentDaysAgo(int count) {
    return '${count}d ago';
  }

  @override
  String get chatGroupAnnouncementHint => 'Enter group announcement';

  @override
  String get chatGroupAnnouncementEmpty => 'No announcement';

  @override
  String get chatEditNickname => 'Edit Nickname';

  @override
  String get chatNicknameHint => 'Enter your nickname in this group';

  @override
  String get contactAddPhoneHint => 'Enter phone number';

  @override
  String get contactNotesHint => 'Add notes about this contact';

  @override
  String get reportTitle => 'Report';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonHarassment => 'Harassment';

  @override
  String get reportReasonFraud => 'Fraud';

  @override
  String get reportReasonOther => 'Other';

  @override
  String get reportSubmitted => 'Report submitted';

  @override
  String get reportDescription => 'Additional description (optional)';

  @override
  String get qrcodeSaved => 'QR code saved to album';

  @override
  String get chatSendRedPacketInChat => 'Please send red packet in chat';

  @override
  String get commonSaveFailed => 'Save failed';

  @override
  String get reportSelectReason => 'Please select a reason';

  @override
  String get reportUnavailable => 'Sign in to send a report.';

  @override
  String get reportAccountChanged =>
      'Account changed. Open this report again to send it.';

  @override
  String get reportUnsupported =>
      'This homeserver does not support user reports.';

  @override
  String get reportRoomUnsupported =>
      'This homeserver does not support room reports.';

  @override
  String get reportRateLimited => 'Too many reports. Please try again later.';

  @override
  String get reportCouldNotSend => 'Could not send report. Please try again.';

  @override
  String get gameCenter => 'Games';

  @override
  String get gameHighScore => 'Best';

  @override
  String get gameScore => 'Score';

  @override
  String get gameOver => 'Game Over';

  @override
  String get gamePlayAgain => 'Play Again';

  @override
  String get gameLeaderboard => 'Leaderboard';

  @override
  String get gamePause => 'Paused';

  @override
  String get gameResume => 'Tap to resume';

  @override
  String get gameConfirmExit => 'Quit this game?';

  @override
  String get gameNoScores => 'No scores yet';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'Merge tiles to reach 2048';

  @override
  String get gameBlockDrop => 'Block Drop';

  @override
  String get gameBlockDropDesc => 'Drop and clear lines';

  @override
  String get gameMinesweeper => 'Minesweeper';

  @override
  String get gameMinesweeperDesc => 'Find all safe cells';

  @override
  String get gameMatch3 => 'Match 3';

  @override
  String get gameMatch3Desc => 'Match 3 or more gems';

  @override
  String get gameMinesweeperEasy => 'Easy';

  @override
  String get gameMinesweeperMedium => 'Medium';

  @override
  String get gameMinesLeft => 'Mines Left';

  @override
  String get gameTimeLeft => 'Time';

  @override
  String get gameLevel => 'Level';

  @override
  String get gameNext => 'Next';

  @override
  String get gameBestTime => 'Best Time';

  @override
  String get gameNewRecord => 'New Record!';

  @override
  String get gameLines => 'Lines';

  @override
  String get storyMyStory => 'My Story';

  @override
  String get storageSmartCleanup => 'Smart Cleanup';

  @override
  String get storageOldMediaFiles => 'Old Media Files';

  @override
  String get storageLargeFiles => 'Large Files';

  @override
  String get storageAppCache => 'App Cache';

  @override
  String get storageSettings => 'Storage Settings';

  @override
  String get storageAutoCleanup => 'Auto Cleanup';

  @override
  String storageAutoCleanupDesc(int days) {
    return 'Automatically clean files older than $days days';
  }

  @override
  String get storageCleanupPeriod => 'Cleanup Period';

  @override
  String get storagePreserveThumbnails => 'Preserve Thumbnails';

  @override
  String get storagePreserveThumbnailsDesc =>
      'Keep image thumbnails during cleanup';

  @override
  String get storageWarningHigh =>
      'Storage usage is high. Consider cleaning up old files.';

  @override
  String get storageWarningCritical =>
      'Storage is critically low. Please clean up to free space.';

  @override
  String storageFreed(String size, int count) {
    return 'Freed $size ($count files)';
  }

  @override
  String storageDays(int days) {
    return '$days days';
  }

  @override
  String storageViewAllRooms(int count) {
    return 'View all $count rooms';
  }

  @override
  String get storageNoFiles => 'No files found';

  @override
  String get storageFilePinned => 'Pinned';

  @override
  String storageDeleteSelected(int count) {
    return 'Delete $count selected files? They can be re-downloaded from the server.';
  }

  @override
  String get backupRestore => 'Backup & Restore';

  @override
  String get backupCreate => 'Create Backup';

  @override
  String get backupCreateDesc =>
      'Backup your settings and encryption keys. Messages will be restored from server after re-login.';

  @override
  String get backupIncludeKeys => 'Include encryption keys';

  @override
  String get backupIncludeKeysDesc => 'Required for reading encrypted messages';

  @override
  String get backupPasswordProtect => 'Password protect';

  @override
  String get backupEnterPassword => 'Enter backup password';

  @override
  String get backupHistory => 'Backup History';

  @override
  String get backupNoBackups => 'No backups yet';

  @override
  String get backupRestore2 => 'Restore';

  @override
  String get backupDelete => 'Delete';

  @override
  String get backupDeleteConfirm =>
      'Are you sure you want to delete this backup? This cannot be undone.';

  @override
  String get backupRestoreFromFile => 'Restore from File';

  @override
  String get backupRestoreFromFileDesc =>
      'Import a .n42backup file from another device or previous backup.';

  @override
  String get backupChooseFile => 'Choose Backup File';

  @override
  String get backupRestoring => 'Restoring...';

  @override
  String backupCreated(int rooms, int messages) {
    return 'Backup created: $rooms rooms, $messages messages';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return 'Restored $settings settings from $rooms rooms';
  }

  @override
  String backupFailed(String error) {
    return 'Backup failed: $error';
  }

  @override
  String get backupPasswordRequired => 'This backup is password-protected';

  @override
  String get blocGroupNotFound => 'Group not found';

  @override
  String blocGroupMembersInvited(int count) {
    return 'Invited $count member(s)';
  }

  @override
  String get blocGroupMemberRemoved => 'Member removed';

  @override
  String get blocGroupAdminRemoved => 'Admin removed';

  @override
  String get blocGroupLeft => 'Left the group';

  @override
  String get blocGroupDisbanded => 'Group disbanded';

  @override
  String get blocGroupJoined => 'Joined the group';

  @override
  String get blocGroupInviteDeclined => 'Invitation declined';

  @override
  String get blocGroupTokenGateUpdated => 'Token gate updated';

  @override
  String get blocTransferProcessing => 'Processing transfer...';

  @override
  String get blocTransferCancelled => 'Transfer cancelled';

  @override
  String get blocTransferFailed => 'Transfer failed';

  @override
  String get blocPaymentProcessing => 'Processing payment...';

  @override
  String get blocPaymentFailed => 'Payment failed';

  @override
  String get groupMaxMembers => 'Member Limit';

  @override
  String get groupMaxMembersUnlimited => 'Unlimited';

  @override
  String get groupMaxMembersHint => 'Enter limit (leave empty for unlimited)';

  @override
  String get groupMaxMembersUpdated => 'Member limit updated';

  @override
  String get groupFull => 'Group is at capacity';

  @override
  String get groupChannels => 'Topic Channels';

  @override
  String get groupChannelsEmpty => 'No channels yet';

  @override
  String get groupChannelsCount => 'channels';

  @override
  String get groupChannelCreate => 'New Channel';

  @override
  String get groupChannelName => 'Channel Name';

  @override
  String get groupChannelTopic => 'Channel Topic (optional)';

  @override
  String get groupChannelDelete => 'Delete Channel';

  @override
  String get groupChannelDeleteConfirm =>
      'Delete this channel? All messages will be lost.';

  @override
  String get groupBotSettings => 'Bot Settings';

  @override
  String get groupBotEnabled => 'Enable Bot';

  @override
  String get groupBotWelcomeMessage => 'Welcome Message Template';

  @override
  String get groupBotWelcomeHint =>
      'Use \'name\' as placeholder for new member name';

  @override
  String get groupBotConfigUpdated => 'Bot settings updated';

  @override
  String get groupContentFilter => 'Content Filter';

  @override
  String get groupContentFilterEnabled => 'Enable Keyword Filter';

  @override
  String get groupContentFilterReplace => 'Replace with ***';

  @override
  String get groupContentFilterHide => 'Hide Message';

  @override
  String get groupContentFilterAddWord => 'Add Keyword';

  @override
  String get groupContentFilterUpdated => 'Content filter updated';

  @override
  String get chatSlashCommands => 'Commands';

  @override
  String get chatCommandPoll => '/poll — Create a poll';

  @override
  String get chatCommandAnnounce => '/announce — Send announcement';

  @override
  String get chatCommandWelcome => '/welcome — Set welcome message';

  @override
  String get chatReportMessage => 'Report';

  @override
  String get chatReportReason => 'Report Reason';

  @override
  String get chatReportSpam => 'Spam';

  @override
  String get chatReportHarassment => 'Harassment';

  @override
  String get chatReportInappropriate => 'Inappropriate Content';

  @override
  String get chatReportOther => 'Other';

  @override
  String get chatReportSuccess => 'Report submitted';

  @override
  String get spacesName => 'Community Name';

  @override
  String get spacesNameHint => 'e.g. Crypto Traders';

  @override
  String get spacesNameRequired => 'Name is required';

  @override
  String get spacesDescription => 'Description';

  @override
  String get spacesDescriptionHint => 'What is this community about?';

  @override
  String get spacesType => 'Community Type';

  @override
  String get spacesPublicDesc => 'Anyone can discover and join';

  @override
  String get spacesPrivateDesc => 'Only invited members can join';

  @override
  String get spacesNotFound => 'Community not found';

  @override
  String get spacesSearch => 'Search communities...';

  @override
  String get spacesMembers => 'Members';

  @override
  String get spacesNoChannels => 'No channels yet';

  @override
  String get spacesLeave => 'Leave Community';

  @override
  String spacesLeaveConfirm(String name) {
    return 'Are you sure you want to leave \"$name\"?';
  }

  @override
  String get spacesDelete => 'Delete Community';

  @override
  String spacesDeleteConfirm(String name) {
    return 'This will permanently delete \"$name\" and all its channels. This action cannot be undone.';
  }

  @override
  String get spacesCreateChannel => 'Add Channel';

  @override
  String get spacesChannelName => 'Channel Name';

  @override
  String get spacesChannelTopic => 'Topic (optional)';

  @override
  String get spacesDeleteChannel => 'Delete Channel';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return 'Are you sure you want to delete \"#$name\"?';
  }

  @override
  String get spacesEditName => 'Edit Name';

  @override
  String get spacesEditDescription => 'Edit Description';

  @override
  String spacesViewAllMembers(int count) {
    return 'View all $count members';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return 'Kick $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return 'Ban $name';
  }

  @override
  String get spacesPromoteAdmin => 'Promote to Admin';

  @override
  String get spacesDemoteAdmin => 'Remove Admin';

  @override
  String get spacesInviteMember => 'Invite Member';

  @override
  String get spacesInviteMemberUserId => 'User ID (e.g. @user:server.com)';

  @override
  String get spacesSave => 'Save';

  @override
  String get settingsScreenshotProtection => 'Screenshot Protection';

  @override
  String get settingsScreenshotProtectionDesc =>
      'Prevent screenshots and screen recording';

  @override
  String get chatSelfDestructTimer => 'Self-destruct';

  @override
  String get chatTimerPickerTitle => 'Self-destruct Timer';

  @override
  String get chatTimerOff => 'Off';

  @override
  String get onChainNotificationsTitle => 'On-chain Events';

  @override
  String get onChainMarkAllRead => 'Mark all read';

  @override
  String get onChainNoNotifications => 'No on-chain events yet';

  @override
  String get onChainNoNotificationsDesc =>
      'Events from subscribed channels will appear here';

  @override
  String get onChainViewDetails => 'View details';

  @override
  String get chatCommandHelp => '/help — Show all commands';

  @override
  String get chatCommandPrice => '/price — Get token price';

  @override
  String get chatCommandBalance => '/balance — Show wallet balance';

  @override
  String get chatCommandChains => '/chains — List 236+ supported chains';

  @override
  String get chatMiniApps => 'Apps';

  @override
  String get miniAppMarketTitle => 'Mini Apps';

  @override
  String get miniAppCategoryAll => 'All';

  @override
  String get miniAppSearch => 'Search apps...';

  @override
  String get miniAppFeatured => 'Featured';

  @override
  String get miniAppAllApps => 'All Apps';

  @override
  String get miniAppNoResults => 'No apps found';

  @override
  String get slideToPayLabel => '→→→  Slide to confirm';

  @override
  String get slideToPayConfirming => 'Confirming...';

  @override
  String get redPacketBestLuck => 'Best Luck';

  @override
  String get redPacketBestLuckCongrats => 'Best Luck! You got the most!';

  @override
  String redPacketStats(int claimed, int total) {
    return '$claimed / $total claimed';
  }

  @override
  String get redPacketStatsTotal => 'total';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 grabbed a red packet • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id  •  0x wallet address  •  name.eth';

  @override
  String get web3SearchPlaceholder => 'Search by ID, wallet, or ENS...';

  @override
  String get web3WalletAddress => 'Wallet Address';

  @override
  String get web3AddressCopied => 'Address copied';

  @override
  String get web3Copy => 'Copy';

  @override
  String get web3SendMessage => 'Send Message';

  @override
  String get web3SendToWallet => 'Message Wallet';

  @override
  String get web3WalletOnlyHint =>
      'This address has no N42 account yet. Message will be delivered when they join.';

  @override
  String get web3NftAvatar => 'NFT Avatar';

  @override
  String get web3ResolveFailed => 'Failed to resolve identity';

  @override
  String web3EnsNotFound(String name) {
    return 'ENS name \"$name\" not found';
  }

  @override
  String get web3NoN42AccountTitle => 'No N42 Account';

  @override
  String get web3NoN42AccountDesc =>
      'This wallet address has no N42 account yet. You can share your N42 invite link with them to get started.';

  @override
  String get web3ShareInvite => 'Share Invite';

  @override
  String get nftPickerTitle => 'Select NFT Avatar';

  @override
  String get nftPickerTabPopular => 'Popular';

  @override
  String get nftPickerTabCustom => 'Custom';

  @override
  String get nftPickerChain => 'Chain';

  @override
  String get nftPickerContract => 'Contract Address';

  @override
  String get nftPickerTokenId => 'Token ID';

  @override
  String get nftPickerVerifyOwnership => 'Verify Ownership & Preview';

  @override
  String get nftPickerUseAsAvatar => 'Use as Avatar';

  @override
  String get nftPickerPreview => 'Preview';

  @override
  String get nftPickerNotOwned => 'You do not own this NFT';

  @override
  String get nftPickerInvalidTokenId => 'Invalid token ID';

  @override
  String get nftPickerEnterBoth => 'Enter contract address and token ID';

  @override
  String get nftPickerInfoTitle => 'NFT Avatar — Verified On-Chain';

  @override
  String get nftPickerInfoDesc =>
      'Bind an NFT you own as your avatar. Anyone can verify ownership on-chain. Displayed with a gold ring across N42.';

  @override
  String get nftPickerPopularCollections => 'Popular Collections';

  @override
  String get nftPickerWalletHint =>
      'Connect your N42 wallet to automatically discover your NFTs across 236+ chains.';

  @override
  String get profileBindNftAvatar => 'Bind NFT Avatar';

  @override
  String get profileChangeAvatar => 'Change Avatar';

  @override
  String get groupTopics => 'Topics';

  @override
  String get groupTopicsEmpty => 'No topics yet';

  @override
  String get syncInProgress => 'Syncing message history...';

  @override
  String get recoveryKeyReminderTitle => 'Protect your messages';

  @override
  String get recoveryKeyReminderDesc =>
      'Create a recovery key to securely sync encrypted messages across devices';

  @override
  String get recoveryKeySetupNow => 'Set up now';

  @override
  String get recoveryKeyRemindLater => 'Remind me later';

  @override
  String get channelReadOnly => 'Only admins can post in this channel';

  @override
  String get channelSubscribers => 'subscribers';

  @override
  String get channelVerified => 'Verified channel';

  @override
  String get redPacketHistory => 'Red Packet History';

  @override
  String get redPacketSent => 'Sent';

  @override
  String get redPacketReceived => 'Received';

  @override
  String get redPacketExpired => 'Expired';

  @override
  String get redPacketClaimed => 'Claimed';

  @override
  String get redPacketInsufficientBalance => 'Insufficient balance';

  @override
  String selfDestructCountdown(String time) {
    return 'Self-destruct in $time';
  }

  @override
  String get messageDestroyed => 'Message destroyed';

  @override
  String miniAppPermissionDenied(String permission) {
    return 'Permission denied: $permission';
  }

  @override
  String get aiSuggestionGasFee => 'What is Gas fee?';

  @override
  String get aiSuggestionDefi => 'DeFi Beginner Guide';

  @override
  String get aiSuggestionSecurity => 'How to check contract security';

  @override
  String get aiSuggestionBridge => 'Cross-chain bridging';

  @override
  String get channelDiscoverTitle => 'Discover Channels';

  @override
  String get channelDiscoverSearch => 'Search channels...';

  @override
  String get channelJoin => 'Join';

  @override
  String get channelJoined => 'Joined';

  @override
  String get channelCategory => 'Category';

  @override
  String slowModeCooldown(int seconds) {
    return 'Slow mode: wait ${seconds}s';
  }

  @override
  String get addressCopyAction => 'Copy Address';

  @override
  String get addressSendMessage => 'Send Message';

  @override
  String get addressViewProfile => 'View Profile';

  @override
  String get sendToAddress => 'Send to wallet address';

  @override
  String get blocAuthSendVerificationCodeFailed =>
      'Failed to send verification code';

  @override
  String get blocAuthServerNoEmailPasswordReset =>
      'This server does not support email password reset';

  @override
  String get blocAuthResetPasswordFailed => 'Failed to reset password';

  @override
  String get blocAuthChangePasswordFailed => 'Failed to change password';

  @override
  String get blocAuthOldPasswordWrong => 'Incorrect current password';

  @override
  String get blocAuthLoginCancelled => 'Login cancelled';

  @override
  String get blocAuthGoogleLoginFailed => 'Google login failed';

  @override
  String get blocAuthAppleLoginFailed => 'Apple login failed';

  @override
  String get blocAuthSsoLoginFailed => 'SSO login failed';

  @override
  String get blocAuthFacebookLoginFailed => 'Facebook login failed';

  @override
  String get blocAuthTwitterLoginFailed => 'Twitter login failed';

  @override
  String get blocAuthWeChatLoginFailed => 'WeChat login failed';

  @override
  String get blocAuthWeChatNotConfigured => 'WeChat login not configured';

  @override
  String get blocAuthWeChatNotInstalled => 'Please install WeChat first';

  @override
  String get blocAuthPasswordWrong => 'Incorrect password';

  @override
  String get blocAuthEmailAlreadyBound =>
      'This email is already bound to another account';

  @override
  String get blocAuthChangeEmailFailed => 'Failed to change email';

  @override
  String get blocAuthVerificationCodeInvalid =>
      'Verification code is incorrect or expired';

  @override
  String get blocAuthSessionExpired => 'Session expired, please login again';

  @override
  String get blocAuthSessionIncomplete =>
      'Session data incomplete, please login again';

  @override
  String get chatReadingMode => 'Reading mode';

  @override
  String get groupPoints => 'Points';

  @override
  String get settingsPrivacySecurity => 'Privacy & Security';

  @override
  String get settingsSystemAccounts => 'System & Accounts';

  @override
  String get settingsNotificationPrivacy => 'Notification Privacy';

  @override
  String get settingsSenderOnly => 'Show sender only';

  @override
  String get settingsHiddenNotification => 'Hide sender and message';

  @override
  String get settingsSmartFilter => 'Smart Filter';

  @override
  String get settingsEmailVerificationSent => 'Verification email sent';

  @override
  String get settingsEmailLinkInstructions =>
      'Open the verification link in your email, then return here and confirm.';

  @override
  String get settingsSendVerificationEmail => 'Send verification email';

  @override
  String get chatLogoutKeyWarning =>
      'Back up your encryption keys before logging out, or you may lose access to encrypted messages.';

  @override
  String get settingsBiometricUnavailable =>
      'Biometric authentication is unavailable. Check enrollment and permissions in device settings.';

  @override
  String get chatEncryptionNotReady =>
      'Secure connection is not ready. Message not sent. Check connection and device verification on both accounts, then retry.';

  @override
  String get contactRequestPending => 'Awaiting acceptance';

  @override
  String get chatFriendRequestPending =>
      'Friendship is not confirmed. Check Contacts > New Friends before sending.';

  @override
  String contactPhotoCount(int count) {
    return '$count photos';
  }

  @override
  String get videoPublish => 'Publish video';

  @override
  String get videoGoLive => 'Go live';

  @override
  String get videoSelect => 'Select video';

  @override
  String get videoLiveUnavailable => 'Live broadcasting is unavailable';

  @override
  String get qrcodeAlbum => 'Album';

  @override
  String get settingsSwitchAccount => 'Switch Account';

  @override
  String get chatFilterUnread => 'Unread';

  @override
  String get chatFilterEmpty => 'No conversations in this filter';

  @override
  String get accountAdd => 'Add account';

  @override
  String get accountCurrent => 'Current account';

  @override
  String get accountSwitching => 'Switching account…';

  @override
  String get accountSwitchFailed =>
      'Could not switch accounts. Try again, or add the account to sign in again.';

  @override
  String get accountSessionsHint =>
      'Switch accounts here to keep each account’s messages and secure session separate.';

  @override
  String get accountNoSaved => 'No saved accounts yet';

  @override
  String get contactRequestSent => 'Request sent';

  @override
  String get contactRequestsIncoming => 'Received requests';

  @override
  String get contactRequestsOutgoing => 'Sent requests';

  @override
  String get contactRequestHint =>
      'You can chat and call after the request is accepted.';

  @override
  String get callReturnToCall => 'Return to call';

  @override
  String get chatMessageSending => 'Sending';

  @override
  String get chatMessageSent => 'Sent';

  @override
  String get chatMessageDelivered => 'Delivered';

  @override
  String get chatMessageRead => 'Read';

  @override
  String get chatMessageFailed => 'Not sent. Tap to retry.';

  @override
  String get chatMessageUnavailable =>
      'Message unavailable on this device. Tap to check recovery options.';

  @override
  String get contactStarredFriends => 'Starred friends';

  @override
  String get chatRecipientKeysMissing =>
      'This friend has no available encrypted session. Ask them to sign in and open the app, then retry. Use Switch Account instead of logging out when changing accounts.';

  @override
  String get chatSwitchForMessaging =>
      'Changing accounts? Use Switch Account to keep your messages and secure sessions. Logging out revokes this device and can make incoming encrypted messages unavailable.';

  @override
  String get aiServiceUnavailable =>
      'AI summaries are currently unavailable. Please try again after service access is restored.';

  @override
  String aiSummarizeMessages(int count) {
    return 'Summarize $count recent messages';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return '$joined joined · $invited invited';
  }

  @override
  String contactPendingCount(int count) {
    return '$count pending requests';
  }

  @override
  String get chatDraftLabel => 'Draft';

  @override
  String get contactIndexLabel => 'Contact index';

  @override
  String get transferAssetUnavailable => 'Payment asset is unavailable';

  @override
  String get transferPaymentRequestUnavailable =>
      'Payment request is unavailable';

  @override
  String get chatCatchUp => 'Catch up';

  @override
  String get chatCatchUpMentions => 'Mentions';

  @override
  String get chatCatchUpReplies => 'Replies to me';

  @override
  String get chatCatchUpPinned => 'Pinned messages';

  @override
  String get chatCatchUpScope =>
      'Mentions and replies use loaded messages, including read messages. Load older messages to find earlier replies.';

  @override
  String get chatCatchUpLoadMore => 'Load older messages';

  @override
  String get chatActionPreview => 'Review calendar suggestion';

  @override
  String get chatActionPrivacy =>
      'Only the title and time below will be shared with your calendar app after confirmation. Check the time zone. Your calendar account may sync this event.';

  @override
  String get chatActionTitle => 'Chat event';

  @override
  String get chatActionSuggestion => 'Calendar suggestion';

  @override
  String get chatUnreadAttention => 'Unread mentions and replies';

  @override
  String get chatScanAgain => 'Scan again';

  @override
  String get chatUnreadScope =>
      'Scans server history to your read marker. Open a conversation to read it; refresh to rebuild the results.';

  @override
  String get chatScanIncomplete =>
      'Incomplete: history, decryption or read marker unavailable. Try again after sync.';

  @override
  String get chatHistoryShare => 'Share selected history';

  @override
  String get chatHistoryExplanation =>
      'Administrators only. Select plain text and an existing encrypted direct chat with a joined group member. Sharing creates visible audit messages in the group.';

  @override
  String get chatHistoryEnable => 'Enable sharing';

  @override
  String get chatHistoryDisable => 'Disable sharing';

  @override
  String get chatHistoryPolicy => 'Group history sharing policy';

  @override
  String get chatHistoryPolicyDetail =>
      'Only administrators can share. Enabling also restricts group history visibility to events after joining. Set the text-message limits below and confirm.';

  @override
  String get chatHistoryPolicySaved => 'Policy saved';

  @override
  String get chatHistoryRecipient => 'Encrypted recipient conversation';

  @override
  String get chatHistoryReview => 'Review selected messages';

  @override
  String get chatHistoryMessages => 'messages';

  @override
  String get chatHistoryConfirmDetail =>
      'Confirm this recipient, each message and its time before sharing. A failed or unknown result may already have sent content: reconcile before continuing.';

  @override
  String get chatHistoryCompleted =>
      'Selected history sent and group audit confirmed';

  @override
  String get chatHistoryPending =>
      'Pending: reconcile, then confirm again to continue. Unknown sends are never resent.';

  @override
  String get chatHistoryReconcile => 'Reconcile send result';

  @override
  String get chatHistoryFailed =>
      'Unable to complete. Check administrator access, group policy, encryption, recipient membership and selection. If sending started, reconcile its result.';

  @override
  String get chatDeviceActions => 'On-device actions';

  @override
  String get chatDeviceActionsReview =>
      'After confirmation, only this message is provided to the system on-device action suggestions. Choose an action to open Calendar, Reminders or Maps.';

  @override
  String get chatHistoryMaxMessages => 'Message limit (1–50)';

  @override
  String get chatHistoryMaxHours => 'History window in hours (1–720)';

  @override
  String get chatNotifyAll => 'All Messages';

  @override
  String get chatNotifyAllDescription =>
      'Notify for every new message in this chat';

  @override
  String get chatNotifyMentions => 'Mentions Only';

  @override
  String get chatNotifyMentionsDescription =>
      'Only notify when you are mentioned or @room is used';

  @override
  String get chatNotifyMutedDescription =>
      'Disable notifications for this chat on all devices';

  @override
  String get scheduledMessagesTitle => 'Scheduled messages';

  @override
  String get scheduledMessagesEmpty => 'No scheduled messages yet';

  @override
  String get scheduledMessagesHint =>
      'Long press Send, Photos, Files, a GIF or a sticker to schedule a message.';

  @override
  String get scheduledMessageCancelled => 'Scheduled message cancelled';

  @override
  String scheduledMessageCreatedAt(String time) {
    return 'Created $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => 'Delivery not confirmed';

  @override
  String get scheduledRecoveryCopy => 'Save recovery copy';

  @override
  String get scheduledRecoveryCopyHint =>
      'Saved on this device without changing or sending messages. Preview shows up to 8,000 characters.';

  @override
  String get scheduledRecoveryCopies => 'Recovery copies';

  @override
  String get scheduledRecoveryReset => 'Reset damaged queue';

  @override
  String get scheduledRecoveryResetHint =>
      'An exact copy is saved on this device. Reset all scheduled messages for this account? Some may already have been sent. Copies and attachments are kept. Nothing is resent.';

  @override
  String get scheduledRecoveryExportHint =>
      'This file contains unencrypted draft text and account details. Attachments are not included. Choose a trusted destination.';

  @override
  String get scheduledRecoveryImport => 'Import recovery copy';

  @override
  String get scheduledRecoveryImportHint =>
      'Save this preview as a recovery copy only. No messages will be scheduled or sent. Attachments are not included. The file author is not verified.';

  @override
  String get scheduledRecoveryComposerHint =>
      'Append text to the current draft for review. Nothing is sent. Attachments, mentions and timers are not restored. Check whether this message was already delivered.';

  @override
  String get backupRecoverLegacyArchive => 'Recover older local history';

  @override
  String get backupLegacyArchiveWarning =>
      'This history has no verified owner. Copy only your rooms to the account below. The original is kept.';

  @override
  String get backupOlderFiles => 'Older backup files';

  @override
  String get backupOlderFilesWarning =>
      'These files may belong to another account. Select a file to check its contents and ownership before restoring.';

  @override
  String get stickerImportTitle => 'Import sticker pack';

  @override
  String get stickerImportLinkHint => 'Matrix sticker pack link';

  @override
  String get stickerImportPreview => 'Preview';

  @override
  String get stickerImportUnavailable =>
      'This pack is unavailable or you do not have access.';

  @override
  String get stickerImportCopyNotice =>
      'Add a private copy of this pack. Its images and metadata are not end-to-end encrypted.';

  @override
  String get stickerImportFailed => 'Could not add this pack. Try again.';

  @override
  String get stickerImportAccountChanged =>
      'Account changed or session expired. Reopen sticker import.';

  @override
  String get stickerPackSourceRoom => 'Source chat';

  @override
  String get stickerPackImages => 'Images';

  @override
  String get stickerPublishNotice =>
      'Publish this pack to the selected group. Its images and metadata are not end-to-end encrypted. People who can read the group state may access them.';

  @override
  String get stickerPublishFailed =>
      'Publication was not confirmed. Check the group before trying again.';

  @override
  String get stickerPublishReceiptMissing =>
      'Published, but the link was not saved. Share or copy it before leaving this page.';

  @override
  String get stickerSubscribe => 'Subscribe to updates';

  @override
  String get stickerSubscribeNotice =>
      'Follow future changes made by this pack’s administrators. Images and metadata are not end-to-end encrypted. You can unsubscribe later; this does not join the source chat.';

  @override
  String get stickerSubscriptions => 'Sticker subscriptions';

  @override
  String get stickerUnsubscribe => 'Unsubscribe';

  @override
  String get stickerSubscriptionsEmpty => 'No sticker subscriptions';

  @override
  String get chatAttachmentEvent => 'Event';

  @override
  String get chatRecentMedia => 'Recent photos and videos';

  @override
  String get chatRecentMediaLoadFailed => 'Could not load recent media';

  @override
  String get chatRecentMediaPermission =>
      'Photo access is needed to show recent media';

  @override
  String get chatRecentMediaEmpty => 'No recent photos or videos';

  @override
  String get chatRecentPhoto => 'Recent photo';

  @override
  String get chatRecentVideo => 'Recent video';

  @override
  String get chatAttachmentTip => 'Tip';

  @override
  String get chatAttachmentWhiteboard => 'Whiteboard';

  @override
  String get chatAttachmentVideoNote => 'Video note';

  @override
  String get chatAttachmentCode => 'Code';

  @override
  String get chatAttachmentShop => 'Shop';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Selection limit: $countString';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return 'Tonight ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return 'Tomorrow morning ($time)';
  }

  @override
  String get a11yScrollToBottom => 'Scroll to bottom';

  @override
  String get ui3EnterMessageBeforeScheduling =>
      'Enter a message before scheduling';

  @override
  String get ui3SendCode => 'Send code';

  @override
  String get ui3CodeLanguage => 'Language';

  @override
  String get ui3PasteCodeHere => 'Paste code here';

  @override
  String ui3ReminderSetAt(String time) {
    return 'Reminder set · $time';
  }

  @override
  String get ui3RedPacketCreateFailed => 'Failed to create red packet';

  @override
  String get ui3SendTip => 'Send a tip';

  @override
  String get ui3TokenLabel => 'Token';

  @override
  String get ui3NoteOptional => 'Note (optional)';

  @override
  String ui3TipFailed(String error) {
    return 'Tip failed: $error';
  }

  @override
  String get ui3GiftNftTitle => 'Gift an NFT';

  @override
  String get ui3TokenId => 'Token ID';

  @override
  String ui3NftGiftFailed(String error) {
    return 'NFT gift failed: $error';
  }

  @override
  String get ui3AiAgentSubtitle => 'Describe a task, open the right mini app';

  @override
  String get ui3GiftNft => 'Gift NFT';

  @override
  String get ui3GiftNftSubtitle => 'Send an NFT to this contact';

  @override
  String get ui3MiniAppUnavailable => 'Mini app is not available';

  @override
  String ui3MediaItemsNotSent(int count) {
    return '$count selected media item(s) could not be sent';
  }

  @override
  String get ui3PhotosSubtitle =>
      'Send photos and videos in chat-friendly format';

  @override
  String get ui3OriginalImages => 'Original Images';

  @override
  String get ui3OriginalImagesSubtitle => 'Send uncompressed photos as files';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return 'Scheduled $filename for $time';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return 'Sending original image: $filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return 'Scheduled original image: $filename';
  }

  @override
  String get ui3PaymentAlreadySent => 'Payment already sent';

  @override
  String get ui3PaymentProcessing => 'Payment is processing';

  @override
  String ui3ChainStatus(String status) {
    return 'Chain status: $status';
  }

  @override
  String get ui3NotChecked => 'Not checked';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return 'Confirmed: $confirmations / $required blocks';
  }

  @override
  String get ui3CopyTxHash => 'Copy transaction hash';

  @override
  String get ui3VerifyAgain => 'Verify again';

  @override
  String get ui3VerifyOnChain => 'Verify on chain';

  @override
  String get ui3TransferMissingChainDetails =>
      'This transfer does not include exact chain and asset details.';

  @override
  String get ui3ReceiptPending => 'Pending on chain';

  @override
  String get ui3ReceiptConfirmed => 'Confirmed';

  @override
  String get ui3ReceiptFailed => 'Failed on chain';

  @override
  String get ui3ReceiptMismatch => 'Transaction details do not match';

  @override
  String get ui3ReceiptUnsupported => 'Chain verification unsupported';

  @override
  String get ui3ReceiptUnavailable => 'Verification unavailable';

  @override
  String get ui3OpenOrSave => 'Open / Save';

  @override
  String get ui3UnableToOpenFile => 'Unable to open this file.';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'AI rewrite failed: $error';
  }

  @override
  String get ui3AiShareMessagesTitle => 'Share messages with AI?';

  @override
  String get ui3AiShareMessagesBody =>
      'Select the messages AI may use for this reply. This one-request approval expires after two minutes. Closing Quick Reply cancels pending results. It does not permit payments or exports.';

  @override
  String get ui3OtherParticipant => 'Other';

  @override
  String get ui3ShareSelected => 'Share selected';

  @override
  String get ui3BotCommandError => 'Command Error';

  @override
  String get ui3BotUnknownCommand => 'Unknown Command';

  @override
  String get ui3BotTypeHelp => 'Type /help to see available commands.';

  @override
  String get ui3FilesMediaLinks => 'Files, Media & Links';

  @override
  String get ui3ChatStorage => 'Chat Storage';

  @override
  String get ui3EncryptionKeysDevices => 'Encryption Keys & Devices';

  @override
  String get ui3EncryptionServiceUnavailable =>
      'Encryption service is not available yet';

  @override
  String get ui3ExportLoadingHistory =>
      'Loading more chat history for export...';

  @override
  String get ui3ExportTxtDesc =>
      'Plain-text transcript for notes, backup, or compliance review';

  @override
  String get ui3ExportCustomRange => 'Custom Range';

  @override
  String get ui3ExportStart => 'Start';

  @override
  String get ui3ExportEnd => 'End';

  @override
  String get ui3ExportSelectDate => 'Select date';

  @override
  String get ui3FolderFilterUnreadOnly => 'Unread only';

  @override
  String get ui3FolderFilterMutedOnly => 'Muted only';

  @override
  String get ui3FolderFilterNoDms => 'No DMs';

  @override
  String get ui3FolderFilterNoGroups => 'No groups';

  @override
  String get ui3FolderFilterNoChannels => 'No channels';

  @override
  String get ui3FolderFilterAllChats => 'All chats';

  @override
  String get ui3Create => 'Create';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return 'Delete folder \"$name\"?';
  }

  @override
  String get a11yDecreaseTextSize => 'Decrease text size';

  @override
  String get a11yIncreaseTextSize => 'Increase text size';

  @override
  String ui3MinutesRead(int minutes) {
    return '$minutes min read';
  }

  @override
  String get ui3TipOnChain => 'On-chain ✓';

  @override
  String get ui3ViewSource => 'View source';

  @override
  String get a11yPreviousPage => 'Previous page';

  @override
  String get a11yNextPage => 'Next page';

  @override
  String get ui3OpenExternalLinkTitle => 'Open external link?';

  @override
  String get ui3Open => 'Open';

  @override
  String get ui3UnableToOpenLink => 'Unable to open this link.';

  @override
  String get ui3ImageUnavailable => 'Image unavailable';

  @override
  String ui3LoadImageFrom(Object host) {
    return 'Load image from $host';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return 'Retry image from $host';
  }

  @override
  String get ui3TranslatedByN42 => 'Translated by N42';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return 'Translated from $language by N42';
  }

  @override
  String get ui3ClearWhiteboardTitle => 'Clear whiteboard?';

  @override
  String get ui3ClearWhiteboardMessage =>
      'All strokes will be removed for everyone. This cannot be undone.';

  @override
  String get ui3WhiteboardLive => 'Whiteboard · Live';

  @override
  String get a11yPenColor => 'Pen color';

  @override
  String get ui3AiDescribeOcr => 'AI describe / OCR';

  @override
  String get ui3DocumentPreviewFailed =>
      'Unable to preview this document safely. Check the connection and file size (max 2MB).';

  @override
  String get ui3AiConsentMessage =>
      'Select the messages AI may use for this summary. This one-request approval expires after two minutes. It does not permit payments or exports.';

  @override
  String get ui3AiSuggestedReplies => 'Suggested replies';

  @override
  String get ui3AiGeneratingSuggestions => 'Generating suggestions...';

  @override
  String get ui3StickersEmpty => 'No stickers yet';

  @override
  String get ui3StickersGet => 'Get Stickers';

  @override
  String get a11yFormatBold => 'Bold';

  @override
  String get a11yFormatItalic => 'Italic';

  @override
  String get a11yFormatStrikethrough => 'Strikethrough';

  @override
  String get a11yFormatInlineCode => 'Inline code';

  @override
  String get a11yFormatCodeBlock => 'Code block';

  @override
  String get a11yFormatChecklistItem => 'Checklist item';

  @override
  String get a11yFormatBulletList => 'Bullet list';

  @override
  String get a11yFormatNumberedList => 'Numbered list';

  @override
  String get a11yFormatLink => 'Link';

  @override
  String get a11yFormatTable => 'Table';

  @override
  String get a11yFormatMeetingTemplate => 'Meeting template';

  @override
  String get a11yEmojiSmileys => 'Smileys & people';

  @override
  String get a11yEmojiHearts => 'Hearts';

  @override
  String get a11yEmojiAnimals => 'Animals & nature';

  @override
  String get a11yEmojiFood => 'Food & drink';

  @override
  String get a11yEmojiTravel => 'Travel & places';

  @override
  String get a11yEmojiActivities => 'Activities';

  @override
  String get a11yEmojiObjects => 'Objects';

  @override
  String get a11yEmojiSymbols => 'Symbols';

  @override
  String get ui3FrequentlyUsed => 'Frequently Used';

  @override
  String get ui3NoEditHistory => 'No edit history';

  @override
  String get ui3EventNew => 'New Event';

  @override
  String get ui3EventTitleLabel => 'Title';

  @override
  String get ui3EventLocationOptional => 'Location (optional)';

  @override
  String get ui3EventDescriptionOptional => 'Description (optional)';

  @override
  String get ui3EventSend => 'Send Event';

  @override
  String get ui3EventTitleRequired => 'Title is required';

  @override
  String get ui3EventEndAfterStart => 'End time must be after start';

  @override
  String get ui3MiniAppAgentIntro =>
      'Describe what you want to do — I\'ll open the right mini app.';

  @override
  String get ui3MiniAppAgentExample => 'e.g. swap ETH to USDC';

  @override
  String get ui3MiniAppAgentNoMatch =>
      'No matching mini app found. Try rephrasing.';

  @override
  String ui3MiniAppOpen(Object appName) {
    return 'Open $appName';
  }

  @override
  String get ui3MusicLinkPlatforms =>
      'Supports song links from NetEase Cloud Music, QQ Music, Kugou, Kuwo and more';

  @override
  String get ui3PollMarkCorrectAnswer => 'Mark a non-empty correct answer';

  @override
  String get ui3PollQuizMode => 'Quiz mode';

  @override
  String get ui3PollAnswerExplanationHint => 'Answer explanation (optional)';

  @override
  String get a11yCorrectAnswer => 'Correct answer';

  @override
  String get ui3AiSuggestions => 'AI Suggestions';

  @override
  String get a11yPaste => 'Paste';

  @override
  String get a11yRefresh => 'Refresh';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      'Store this key safely. It is the only way to recover your encrypted messages if you lose access to all devices.';

  @override
  String ui3SavedToPath(Object path) {
    return 'Saved: $path';
  }

  @override
  String get ui3UnknownAccount => 'Unknown account';

  @override
  String get ui3UnknownHomeserver => 'Unknown homeserver';

  @override
  String get ui3ImportRecoveryKey => 'Import Recovery Key';

  @override
  String get ui3ImportRecoveryKeyDesc =>
      'Enter or paste your recovery key to restore room keys for encrypted message history.';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return 'Account: $account\\nHomeserver: $homeserver';
  }

  @override
  String get ui3Import => 'Import';

  @override
  String get ui3InvalidRecoveryKeyFormat => 'Invalid recovery key format';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return 'Restored $restored of $total keys. $failed keys failed. Check the account, network, and backup, then retry. Some history may remain unreadable.';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return 'Restored $restored of $total keys successfully';
  }

  @override
  String ui3ImportFailed(Object error) {
    return 'Import failed: $error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return 'Passkey registration failed: $error';
  }

  @override
  String get ui3PasskeyDefaultName => 'My Passkey';

  @override
  String get ui3PasskeyNameHint => 'e.g., iPhone, MacBook';

  @override
  String get ui3PasskeyDeleteFailed => 'Failed to delete passkey';

  @override
  String get ui3TwoFactorAuth => 'Two-factor authentication';

  @override
  String get ui3TwoFactorOnSubtitle => 'On — authenticator app code required';

  @override
  String get ui3TwoFactorOffSubtitle =>
      'Off — protect with an authenticator app (TOTP)';

  @override
  String get ui3ShowRecoveryKey => 'Show Recovery Key';

  @override
  String get ui3ShowRecoveryKeyDesc => 'Display your recovery key for backup';

  @override
  String get ui3ImportRecoveryKeyHint =>
      'Restore messages using a recovery key';

  @override
  String get ui3RecoveryKeyCreateFailed => 'Failed to create recovery key';

  @override
  String get ui3TotpIncorrectCode => 'Incorrect code, try again';

  @override
  String get ui3TwoFactorEnabled => 'Two-factor authentication enabled';

  @override
  String get ui3TwoFactorDisabled => 'Two-factor authentication disabled';

  @override
  String get ui3TwoFactorTurnOffTitle => 'Turn off two-factor authentication?';

  @override
  String get ui3TwoFactorTurnOffMessage =>
      'Your authenticator app will no longer be required. You can set it up again later with a new key.';

  @override
  String get ui3TurnOff => 'Turn off';

  @override
  String get ui3TwoFactorTotpTitle => 'Two-Factor (TOTP)';

  @override
  String get ui3TwoFactorIsOn => 'Two-factor authentication is on';

  @override
  String get ui3TwoFactorCodeRequired =>
      'A code from your authenticator app is required.';

  @override
  String get ui3TotpStepScan =>
      '1. Scan this QR with an authenticator app (Google Authenticator, Authy, 1Password…), or enter the key manually.';

  @override
  String get ui3TotpKeyCopied => 'Key copied';

  @override
  String get ui3TotpStepConfirm => '2. Enter the 6-digit code to confirm.';

  @override
  String get ui3Enable => 'Enable';

  @override
  String get ui3BackupSettingsDesc =>
      'Backup your local chat settings. Messages will be restored from server after re-login.';

  @override
  String get ui3BackupKeysSeparate => 'Encryption keys are managed separately';

  @override
  String get ui3BackupKeysSeparateHint =>
      'Use Security > Recovery Key to back up encrypted message access.';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return '$rooms rooms  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      'Import a .n42backup file from another device or previous backup. Encryption keys are restored separately with your Recovery Key.';

  @override
  String get ui3UsernameSessionRequired =>
      'Username requires an active session';

  @override
  String get ui3SecuritySessionRequired =>
      'Security settings require an active session';

  @override
  String get ui3ConnectedAccountsSessionRequired =>
      'Connected accounts require an active session';

  @override
  String get ui3SystemAccounts => 'System & Accounts';

  @override
  String get ui3AccountIdentity => 'Account & Identity';

  @override
  String get ui3Accounts => 'Accounts';

  @override
  String get ui3DevicesSessions => 'Devices & Sessions';

  @override
  String get ui3Integrations => 'Integrations';

  @override
  String get ui3ConnectedAccounts => 'Connected Accounts';

  @override
  String get ui3ConnectedAccountsDesc =>
      'Telegram, WhatsApp, Discord, and API bridge integrations';

  @override
  String get ui3SystemOverview => 'System overview';

  @override
  String ui3AccountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accounts',
      one: '1 account',
    );
    return '$_temp0';
  }

  @override
  String ui3DeviceCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count devices',
      one: '1 device',
    );
    return '$_temp0';
  }

  @override
  String get ui3PrivacySecurityOverview =>
      'End-to-end encryption, screenshot protection, and proxy controls';

  @override
  String get ui3ConversationPrivacy => 'Conversation Privacy';

  @override
  String get ui3NetworkPrivacy => 'Network Privacy';

  @override
  String get ui3IdentityPrivacy => 'Identity Privacy';

  @override
  String get ui3EncryptionKeyBackup => 'Encryption & Key Backup';

  @override
  String get ui3DevicesVerification => 'Devices & Verification';

  @override
  String get ui3ChipE2eeDefault => 'E2EE default';

  @override
  String get ui3ChipManualE2ee => 'Manual E2EE';

  @override
  String get ui3ChipSelfDestruct => 'Self-destruct';

  @override
  String get ui3ChipScreenshotGuard => 'Screenshot guard';

  @override
  String get ui3ChipIpProxy => 'IP / proxy';

  @override
  String get ui3ChipLinkPreviewsOff => 'Link previews off';

  @override
  String get ui3ChipPublicHandle => 'Public handle';

  @override
  String get a11yShowPassword => 'Show password';

  @override
  String get a11yHidePassword => 'Hide password';

  @override
  String get a11yCheckServer => 'Check server';

  @override
  String get ui3AuthAnonymousRegistration => 'Anonymous Registration';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      'Create an account without binding phone or email. A username will be generated automatically.';

  @override
  String get ui3AuthAnonymousModeOn => 'Anonymous mode is on';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      'The app will create a random Matrix username for you. You can still sign in later with your generated account and password.';

  @override
  String get ui3AuthChooseLoginMethod => 'Choose login method';

  @override
  String get ui3AuthSsoOpenFailed => 'Failed to open SSO login page';

  @override
  String get ui3AuthWalletUnavailable => 'Wallet is not available';

  @override
  String get ui3ProfileSubscriptions => 'Subscriptions';

  @override
  String get ui3ProfileBuySellCrypto => 'Buy / Sell crypto';

  @override
  String get ui3ProfileOnDeviceAi => 'On-device AI';

  @override
  String get ui3ProfileSetAUsername => 'Set a username';

  @override
  String get ui3ProfileAvatarStudio => 'Avatar Studio';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'NFT Avatar / Decorations';

  @override
  String get ui3ProfileCustomize => 'Customize';

  @override
  String get ui3ProfileQrSubtitle =>
      'Scan to open this profile or start a chat';

  @override
  String get ui3PrivacyHardening => 'Privacy Hardening';

  @override
  String get ui3HidePhoneNumber => 'Hide Phone Number';

  @override
  String get ui3HidePhoneNumberDesc =>
      'Mask any bound phone number in profile-level surfaces on this device';

  @override
  String get ui3EncryptNewChatsByDefault => 'Encrypt New Chats By Default';

  @override
  String get ui3EncryptNewChatsByDefaultDesc =>
      'Start new direct chats and private rooms with E2EE enabled';

  @override
  String get ui3PrivateChatMode => 'Private Chat Mode';

  @override
  String get ui3PrivateChatModeDesc =>
      'Temporarily enable screenshot blocking when viewing private or encrypted chats';

  @override
  String get ui3DefaultSelfDestructTimer => 'Default Auto-Destruct Timer';

  @override
  String get ui3DefaultSelfDestructTimerDesc =>
      'Apply a default self-destruct timer to newly sent messages';

  @override
  String get ui3LinkPreviews => 'Link Previews';

  @override
  String get ui3LinkPreviewsDesc =>
      'Fetch titles, descriptions, and thumbnails when messages contain URLs';

  @override
  String get ui3IpAddressProtection => 'IP Address Protection';

  @override
  String get ui3IpAddressProtectionDesc =>
      'Route Matrix and link-preview requests through your configured HTTP privacy proxy when available';

  @override
  String get ui3UseTorProxy => 'Use Tor / Privoxy HTTP Proxy';

  @override
  String get ui3UseTorProxyDesc =>
      'Use a local HTTP proxy endpoint such as Privoxy on 127.0.0.1:8118. Native SOCKS5 Tor routing is not supported here.';

  @override
  String get ui3CustomProxy => 'Custom Proxy';

  @override
  String get ui3CustomProxyDesc =>
      'Use a custom HTTP or HTTPS proxy for Matrix traffic and link previews';

  @override
  String get ui3ProxyEndpoint => 'Proxy Endpoint';

  @override
  String get ui3ProxyEndpointDesc =>
      'HTTP/HTTPS proxy address (SOCKS not supported)';

  @override
  String get ui3InvalidEndpoint => 'Invalid endpoint';

  @override
  String get ui3CustomProxyStaysOff =>
      'Custom proxy stays off until you set a valid endpoint';

  @override
  String get ui3NotificationFilterNote =>
      'Priority rules always notify (bypassing mute, mentions-only and Do Not Disturb). Muted keywords suppress notifications.';

  @override
  String get ui3PriorityKeywords => 'Priority keywords';

  @override
  String get ui3PriorityKeywordHint => 'e.g. urgent';

  @override
  String get ui3MutedKeywords => 'Muted keywords';

  @override
  String get ui3MutedKeywordHint => 'e.g. spam';

  @override
  String get ui3PrioritySenders => 'Priority senders';

  @override
  String get ui3CaseSensitive => 'Case sensitive';

  @override
  String get ui3None => 'None';

  @override
  String get ui3SmartReplyTranslation => 'Smart reply translation';

  @override
  String get ui3SmartReplyTranslationDesc =>
      'Automatically translate your messages to match the recipient\'s language before sending.';

  @override
  String get ui3FromPhotos => 'From Photos';

  @override
  String get ui3ChangePhoto => 'Change photo';

  @override
  String get ui3RoamingUsesMobileData => 'Roaming uses Mobile Data rules';

  @override
  String get ui3RoamingUsesMobileDataDesc =>
      'Dedicated roaming detection is not available yet, so roaming currently follows the Mobile Data auto-download settings.';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return 'Delete \"$content\"?';
  }

  @override
  String get ui3ResetToDefaults => 'Reset to Defaults';

  @override
  String get ui3ResetQuickRepliesMessage =>
      'This will remove all custom quick replies and restore defaults. Continue?';

  @override
  String get ui3LocalLlmUnavailable => 'Not supported on this device';

  @override
  String get ui3LocalLlmNotDownloaded => 'Model not downloaded';

  @override
  String get ui3LocalLlmReady => 'Ready (on-device)';

  @override
  String get ui3LocalLlmDescription =>
      'When enabled and ready, AI features (summarize, rewrite, translate, replies) run fully on-device — data never leaves your phone. Otherwise they use the cloud provider.';

  @override
  String get ui3UseOnDeviceAi => 'Use on-device AI';

  @override
  String get ui3UseOnDeviceAiDesc => 'Prefer local inference when ready';

  @override
  String get ui3DownloadModel => 'Download model';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      'On-device inference requires the native runtime (Android MediaPipe / iOS Core ML). It will activate automatically once the platform handler is available.';

  @override
  String get ui3PhotoAvatar => 'Photo Avatar';

  @override
  String get ui3AvatarStyles => 'Avatar Styles';

  @override
  String get ui3AvatarStylesDesc =>
      'Reuse one decoration selector for profile and avatar entry points.';

  @override
  String get ui3ReplaceNftAvatar => 'Replace NFT Avatar';

  @override
  String get ui3NftAvatarDesc => 'Use an on-chain collectible as your avatar.';

  @override
  String get ui3UsePhotoAvatar => 'Use Photo Avatar';

  @override
  String get ui3UsePhotoAvatarDesc =>
      'Keep your uploaded avatar and clear the NFT binding.';

  @override
  String ui3AvatarStyleSet(Object name) {
    return 'Avatar style set to: $name';
  }

  @override
  String get ui3NftAvatarUpdated => 'NFT avatar updated';

  @override
  String get ui3SwitchedToPhotoAvatar => 'Switched back to photo avatar';

  @override
  String get ui3SignInToViewRedPacketHistory =>
      'Sign in to view red packet history';

  @override
  String get ui3RedPacketActive => 'Active';

  @override
  String get ui3RedPacketCompleted => 'Completed';

  @override
  String get ui3CardsAndPasses => 'Cards and passes';

  @override
  String get ui3CardsAndPassesDesc =>
      'Wallet cards, coupons, and passes are managed by the main app.';

  @override
  String get ui3CardPackRequiresMainApp => 'Card Pack requires the main app';

  @override
  String get ui3OpenCardPack => 'Open Card Pack';

  @override
  String get ui3UnableToOpenChat => 'Unable to open a chat for this contact';

  @override
  String get ui3WalletManagedInMainApp => 'Wallet is managed in the main app';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · Plans';
  }

  @override
  String get ui3NewPlan => 'New plan';

  @override
  String get ui3MySubscriptions => 'My subscriptions';

  @override
  String get ui3AvailablePlans => 'Available plans';

  @override
  String get ui3NoPlansYet => 'No plans yet · tap “New plan” to create one';

  @override
  String ui3DaysLeft(Object days) {
    return '${days}d left';
  }

  @override
  String get ui3SubscriptionCancelled => 'Cancelled';

  @override
  String get ui3AutoRenewOn => 'Auto-renew: on';

  @override
  String get ui3AutoRenewOff => 'Auto-renew: off';

  @override
  String get ui3CancelSubscriptionTitle => 'Cancel subscription?';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return 'Your subscription to $name stays active until it expires and will not renew.';
  }

  @override
  String get ui3Subscribe => 'Subscribe';

  @override
  String ui3SubscribedTo(Object name) {
    return 'Subscribed to $name';
  }

  @override
  String get ui3PlanPriceLabel => 'Price (e.g. 9.9 USDT)';

  @override
  String get ui3PlanDescriptionLabel => 'Description (optional)';

  @override
  String get ui3PlanBenefitsLabel => 'Benefits (comma separated)';

  @override
  String get ui3PlanPeriod => 'Period:';

  @override
  String get ui3Monthly => 'Monthly';

  @override
  String get ui3Yearly => 'Yearly';

  @override
  String get ui3SaveRemarkFailed => 'Failed to save remark';

  @override
  String get ui3CopyLink => 'Copy Link';

  @override
  String get ui3Connect => 'Connect';

  @override
  String get ui3CommonTokens => 'Common tokens';

  @override
  String get ui3SharedNfts => 'Shared NFTs';

  @override
  String get ui3TransactionHistory => 'Transaction history';

  @override
  String get ui3CommonDaos => 'Common DAOs';

  @override
  String get ui3SameChains => 'Same chains';

  @override
  String get ui3ChatInitFailed => 'Chat initialization failed';

  @override
  String get ui3CheckNetworkRetry => 'Please check your network and try again';

  @override
  String get ui3FromContacts => 'From Contacts';

  @override
  String get ui3FindFriendsFromContacts =>
      'Find friends from your phone contacts';

  @override
  String get ui3EnsOrDomain => 'ENS / Domain';

  @override
  String get ui3LoadingContacts => 'Loading contacts...';

  @override
  String get ui3ContactsPermissionRequired => 'Contacts Permission Required';

  @override
  String get ui3ContactsPermissionMessage =>
      'To find friends from your contacts, please allow access to your contacts.';

  @override
  String get ui3AllowAccess => 'Allow Access';

  @override
  String get ui3NoContactMatches => 'No Matches Found';

  @override
  String get ui3NoContactMatchesMessage =>
      'None of your contacts are using this app yet. Invite them to join!';

  @override
  String ui3ScannedContacts(Object count) {
    return 'Scanned $count contacts';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return 'Found $count matches from your contacts';
  }

  @override
  String ui3InContactsAs(Object name) {
    return 'In Contacts: $name';
  }

  @override
  String get ui3DeletePhotoConfirm => 'Delete this photo?';

  @override
  String get ui3InviteLink => 'Invite Link';

  @override
  String get ui3ShareJoinLink => 'Share a join link for this room';

  @override
  String get ui3ShareRoomReference =>
      'Share a room reference with invited members';

  @override
  String get ui3ScanToJoinGroup => 'Scan to join this group directly';

  @override
  String get ui3ScanToShareRoomReference =>
      'Scan to share this room reference with invited members';

  @override
  String get ui3InviteLinkLoadFailed => 'Failed to load invite link';

  @override
  String get ui3InviteLinkCopied => 'Invite link copied';

  @override
  String get ui3ChannelCategoryOptional => 'Category (optional)';

  @override
  String get ui3ChannelCategoryHint => 'Announcements / Product / Support';

  @override
  String get ui3DescriptionOptional => 'Description (optional)';

  @override
  String get ui3WebhookEnable => 'Enable webhook automation';

  @override
  String get ui3WebhookEnableDesc =>
      'Post member-join and welcome events to your integration endpoint.';

  @override
  String get ui3WebhookUrl => 'Webhook URL';

  @override
  String get ui3WebhookSecretOptional => 'Signing Secret (optional)';

  @override
  String get ui3WebhookSecretHint => 'Used for X-N42-Signature';

  @override
  String get ui3WebhookNotifyMemberJoined => 'Notify when a member joins';

  @override
  String get ui3WebhookNotifyWelcomeSent => 'Notify when welcome is sent';

  @override
  String get ui3WebhookTestSend => 'Send test webhook';

  @override
  String get ui3WebhookTestSending => 'Sending test webhook...';

  @override
  String get ui3WebhookTestSent => 'Test webhook sent successfully';

  @override
  String get ui3WebhookTestFailed => 'Failed to send test webhook';

  @override
  String get ui3WebhookUrlInvalid =>
      'Webhook URL must be a public HTTPS address';

  @override
  String get ui3WebhookSelectEvent => 'Select at least one webhook event';

  @override
  String get ui3SensitiveDataDetection => 'Sensitive Data Detection';

  @override
  String get ui3Email => 'Email';

  @override
  String get ui3CreditCard => 'Credit Card';

  @override
  String get ui3DetectEmailDesc => 'Detect email addresses in text messages';

  @override
  String get ui3DetectPhoneDesc =>
      'Detect phone numbers and international numbers';

  @override
  String get ui3DetectCardDesc => 'Detect likely bank and card numbers';

  @override
  String get ui3DetectWalletDesc => 'Detect Ethereum-style wallet addresses';

  @override
  String get ui3GeneralTopic => 'General';

  @override
  String get a11yPreviousResult => 'Previous result';

  @override
  String get a11yNextResult => 'Next result';

  @override
  String get ui3TryDifferentKeywords => 'Try different keywords';

  @override
  String ui3FiltersActive(Object count) {
    return 'Filters active: $count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return 'Message filters active: $count';
  }

  @override
  String get ui3LoadMore => 'Load more';

  @override
  String get ui3MessageFilters => 'Message Filters';

  @override
  String get ui3SenderUserId => 'Sender User ID';

  @override
  String get ui3FilterType => 'Type';

  @override
  String get ui3FilterAny => 'Any';

  @override
  String get ui3FilterImage => 'Image';

  @override
  String get ui3FilterTime => 'Time';

  @override
  String get ui3AnyTime => 'Any time';

  @override
  String get ui3OnlyMyMessages => 'Only my messages';

  @override
  String get ui3MediaOnly => 'Media only';

  @override
  String get ui3Apply => 'Apply';

  @override
  String get ui3QrStyleClassic => 'Classic';

  @override
  String get ui3QrStyleOcean => 'Ocean';

  @override
  String get ui3QrStyleBerry => 'Berry';

  @override
  String get a11yFlashlightOn => 'Turn on flashlight';

  @override
  String get a11yFlashlightOff => 'Turn off flashlight';

  @override
  String get ui3SocialGraph => 'Social Graph';

  @override
  String get ui3RecommendedConnections => 'Recommended Connections';

  @override
  String get ui3Portfolio => 'Portfolio';

  @override
  String get ui3Chains => 'Chains';

  @override
  String get ui3Tokens => 'Tokens';

  @override
  String get ui3NoConnectionsFound => 'No connections found';

  @override
  String get ui3ConnectionsHint =>
      'Connections appear as you build on-chain activity';

  @override
  String get ui3SocialGraphLoadFailed => 'Failed to load social graph';

  @override
  String get ui3Similarity => 'Similarity';

  @override
  String get ui3Breakdown => 'Breakdown';

  @override
  String get ui3TokenHoldings => 'Token Holdings';

  @override
  String get ui3NftCollections => 'NFT Collections';

  @override
  String get ui3ChainUsage => 'Chain Usage';

  @override
  String get ui3Transactions => 'Transactions';

  @override
  String get ui3DaoMembership => 'DAO Membership';

  @override
  String get ui3NotWeighted => 'Not weighted';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent% (weight: $weight)';
  }

  @override
  String get ui3CommonOnChainActivity => 'Common On-Chain Activity';

  @override
  String get ui3SharedTokens => 'Shared Tokens';

  @override
  String get ui3SharedNftCollections => 'Shared NFT Collections';

  @override
  String get ui3SharedChains => 'Shared Chains';

  @override
  String get ui3NoSharedTokens => 'No shared tokens found';

  @override
  String get ui3NoSharedNftCollections => 'No shared NFT collections found';

  @override
  String get ui3NoSharedChains => 'No shared chains found';

  @override
  String get ui3SimilarityFailed => 'Failed to calculate similarity';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items +$count more';
  }

  @override
  String get a11yGovernance => 'Governance';

  @override
  String get ui3CommunityLink => 'Community Link';

  @override
  String get ui3CommunityQrCode => 'Community QR Code';

  @override
  String get ui3CommunityQrSubtitle =>
      'Scan to join this community and browse its channels';

  @override
  String get ui3CommunityLinkLoadFailed => 'Failed to load community link';

  @override
  String get ui3CommunityLinkCopied => 'Community link copied';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name will be removed from this community.';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name will be removed and cannot rejoin.';
  }

  @override
  String get ui3SignInToDiscoverChannels =>
      'Sign in to discover public channels';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return 'Unable to join $name: $error';
  }

  @override
  String get ui3CategoryTech => 'Tech';

  @override
  String get ui3CategorySocial => 'Social';

  @override
  String get ui3NoPublicChannels => 'No public channels found';

  @override
  String get ui3StoriesAndFun => 'Stories & Fun';

  @override
  String get ui3SearchMusicHint => 'Search songs, artists, or friends';

  @override
  String get ui3ForYou => 'For You';

  @override
  String get ui3Liked => 'Liked';

  @override
  String get ui3NoLikedMusic => 'No liked music yet';

  @override
  String get ui3NoMusicStories => 'No music Stories yet';

  @override
  String get ui3LikedMusicHint =>
      'Tap the heart beside a song to keep it here.';

  @override
  String get ui3MusicStoriesHint => 'Music shared in Stories will appear here.';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · shared by $name';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return 'Unable to play $title: $error';
  }

  @override
  String get a11yPreviousTrack => 'Previous track';

  @override
  String get a11yNextTrack => 'Next track';

  @override
  String get a11yPlay => 'Play';

  @override
  String get a11yPause => 'Pause';

  @override
  String get ui3Refresh => 'Refresh';

  @override
  String get ui3NearbyIntroTitle => 'Discover nearby public posts';

  @override
  String get ui3NearbyIntroBody =>
      'Your location is used once on this device to sort public Moments. It is not uploaded, broadcast, or shown to other people.';

  @override
  String get ui3UseMyLocation => 'Use my location';

  @override
  String get ui3NearbyUnavailable => 'Nearby is unavailable';

  @override
  String get ui3NoNearbyPosts => 'No nearby posts yet';

  @override
  String get ui3NoNearbyPostsHint =>
      'Public Moments with a location will appear here.';

  @override
  String get ui3NearbyDistanceNote =>
      'Approximate distance · public location posts only';

  @override
  String get ui3PublicLocationPost => 'Public location post';

  @override
  String get ui3LocationServicesOff => 'Location Services are turned off';

  @override
  String get ui3LocationPermissionDenied => 'Location permission was denied';

  @override
  String get ui3EnableLocationInSettings =>
      'Enable location permission in system settings';

  @override
  String get ui3CreateStory => 'Create Story';

  @override
  String get ui3CreateStoryDesc => 'Post a text or photo status.';

  @override
  String get ui3StoryCamera => 'Story Camera';

  @override
  String get ui3StoryCameraDesc =>
      'Jump straight into filters and photo editing.';

  @override
  String get ui3MomentsDesc => 'Open the full feed and comments.';

  @override
  String get ui3MomentCamera => 'Moment Camera';

  @override
  String get ui3MomentCameraDesc => 'Create a post and pick media immediately.';

  @override
  String get ui3GamesDesc => 'Launch the built-in casual game center.';

  @override
  String get ui3AvatarStudio => 'Avatar Studio';

  @override
  String get ui3AvatarStudioDesc =>
      'Decorations, NFT avatar and identity flair.';

  @override
  String get ui3SocialGraphDesc => 'On-chain follows, fans and connections.';

  @override
  String get ui3SocialHubHeroTitle => 'Stories, moments, games and avatars';

  @override
  String get ui3SocialHubHeroBody =>
      'Reuse the existing social stack instead of scattering entry points across chat, profile and discover.';

  @override
  String get ui3SocialGraphNotConfigured =>
      'Social graph is not configured on this build';

  @override
  String get ui3ConnectWalletForSocialGraph =>
      'Connect a wallet to view your social graph';

  @override
  String get ui3AvatarStudioSignIn => 'Avatar Studio requires a signed-in user';

  @override
  String get a11yRemoveImage => 'Remove image';

  @override
  String get a11yBack => 'Back';

  @override
  String get ui3MiniAppConfirmTransactionTitle => 'Confirm Transaction';

  @override
  String get ui3MiniAppConfirmTransactionBody =>
      'A Mini App is requesting to send a transaction on your behalf.';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return 'Open $name?';
  }

  @override
  String get ui3MiniAppOpenButton => 'Open';

  @override
  String get ui3StoryReplySendFailed => 'Failed to send story reply';

  @override
  String get ui3RedPacketDemoNotice =>
      'Demo red packet — an in-chat record only, no real on-chain asset is transferred.';

  @override
  String get ui3RedPacketCoverClassic => 'Classic Red';

  @override
  String get ui3RedPacketCoverGolden => 'Golden';

  @override
  String get ui3RedPacketCoverPurple => 'Purple';

  @override
  String get ui3RedPacketCoverOceanBlue => 'Ocean Blue';

  @override
  String get ui3RedPacketCoverNatureGreen => 'Nature Green';

  @override
  String get ui3RedPacketCoverRosePink => 'Rose Pink';

  @override
  String get ui3RedPacketHistoryEmpty => 'No red packets yet';

  @override
  String get ui3TransferMerchantQrWithAmount => 'Merchant QR (with amount)';

  @override
  String get ui3TransferMerchantQrTitle => 'Merchant QR';

  @override
  String get ui3TransferOpenAmountHint => 'Leave empty for open amount';

  @override
  String get ui3FiatRampTitle => 'Buy / Sell crypto';

  @override
  String get ui3FiatRampBuy => 'Buy';

  @override
  String get ui3FiatRampSell => 'Sell';

  @override
  String get ui3FiatRampNotConfigured => 'Fiat on/off-ramp not configured';

  @override
  String get a11yPointsAddRule => 'Add reward rule';

  @override
  String get a11yGovernanceRemoveChoice => 'Remove choice';

  @override
  String get a11yGovernanceCreateProposal => 'Create proposal';

  @override
  String get ui3MiniAppUpdateN42 => 'Update N42';

  @override
  String get ui3MiniAppOfficial => 'Official';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count users';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return 'Background color $index';
  }

  @override
  String get a11yStoryAdd => 'Add story';

  @override
  String get ui3StoryPostFailed => 'Failed to post story';

  @override
  String get ui3StoryTapToSelectImage => 'Tap to select an image';

  @override
  String get ui3StoryChangeImage => 'Change';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return 'Unable to read selected music: $error';
  }

  @override
  String get ui3StoryDeleteConfirm => 'Delete this story?';

  @override
  String get ui3StoryDeleteFailed => 'Failed to delete story';

  @override
  String get ui3MomentCreateTitle => 'Create Moment';

  @override
  String get ui3MomentContentHint => 'What\'s on your mind?';

  @override
  String get ui3MomentAddPhotos => 'Add Photos';

  @override
  String get ui3MomentAddLocation => 'Add Location';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return 'Selected Media ($count)';
  }

  @override
  String get ui3MomentClearAll => 'Clear All';

  @override
  String get ui3MomentClearMediaConfirm => 'Remove all selected photos/videos?';

  @override
  String get ui3MomentVisibilityPublicDesc => 'All friends can see';

  @override
  String get ui3MomentVisibilityPrivateDesc => 'Only you can see';

  @override
  String get ui3MomentVisibilityPartialDesc => 'Choose who can see';

  @override
  String get ui3MomentVisibilityExcludedDesc => 'Hide from specific friends';

  @override
  String get ui3MomentVideos => 'Videos';

  @override
  String get ui3MomentNoVideos => 'No videos yet';

  @override
  String get a11yCallMinimize => 'Minimize';

  @override
  String get a11yCallGridView => 'Grid view';

  @override
  String get a11yCallFocusView => 'Focus view';

  @override
  String get ui3CallTools => 'Call tools';

  @override
  String get ui3CallMeetingTools => 'Meeting tools';

  @override
  String get ui3CallToolsSubtitle =>
      'Tune audio and video quality without leaving the call.';

  @override
  String get ui3CallAudioEnhancement => 'Audio enhancement';

  @override
  String get ui3CallNoiseSuppression => 'Noise suppression';

  @override
  String get ui3CallNoiseSuppressionDesc =>
      'Reduce keyboard and background noise.';

  @override
  String get ui3CallEchoCancellation => 'Echo cancellation';

  @override
  String get ui3CallEchoCancellationDesc =>
      'Prevent speaker feedback from re-entering the mic.';

  @override
  String get ui3CallAutoGainControl => 'Auto gain control';

  @override
  String get ui3CallAutoGainControlDesc =>
      'Keep microphone volume more stable.';

  @override
  String get ui3CallVoiceIsolation => 'Enhanced voice isolation';

  @override
  String get ui3CallVoiceIsolationDesc =>
      'Use a stronger noise reduction profile.';

  @override
  String get ui3CallVideoSection => 'Video';

  @override
  String get ui3CallBackgroundBlur => 'Background blur (beta)';

  @override
  String get ui3CallBlurDescReady =>
      'Preference is wired. Visual blur still depends on the video processor rollout.';

  @override
  String get ui3CallBlurDescSaved =>
      'Blur preference is saved and will apply when camera processing is available.';

  @override
  String get ui3CallBlurDescCameraOff =>
      'Turn on your camera after background processing is available.';

  @override
  String get ui3CallRecordingSection => 'Recording';

  @override
  String get ui3CallRecordingDesc =>
      'Requires server-side egress before recordings can be saved.';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return 'Failed to update call settings: $error';
  }

  @override
  String get ui3CallRecordingStarted => 'Recording started';

  @override
  String get ui3VoiceRoomNotFound => 'Room not found';

  @override
  String get ui3VoiceRoomEndConfirm =>
      'Are you sure you want to end this voice room?';

  @override
  String get a11yGameMoveUp => 'Move up';

  @override
  String get a11yGameMoveDown => 'Move down';

  @override
  String get a11yGameMoveLeft => 'Move left';

  @override
  String get a11yGameMoveRight => 'Move right';

  @override
  String get a11yGameRotate => 'Rotate';

  @override
  String get a11yGameDrop => 'Drop';

  @override
  String ui3StickerAddedCount(Object count) {
    return 'Added $count sticker(s)';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return 'Failed to add: $error';
  }

  @override
  String get ui3StickerRemoveTitle => 'Remove sticker';

  @override
  String get ui3StickerRemoveConfirm => 'Remove this sticker from the pack?';

  @override
  String get ui3StickerRemoveFailed => 'Failed to remove';

  @override
  String get ui3StickerRenamePack => 'Rename pack';

  @override
  String get ui3StickerPackName => 'Pack name';

  @override
  String get ui3StickerRenameFailed => 'Failed to rename';

  @override
  String get ui3StickerDeletePack => 'Delete pack';

  @override
  String get ui3StickerThisPack => 'this pack';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return 'Delete \"$name\" and all its stickers? This cannot be undone.';
  }

  @override
  String get ui3StickerDeleteFailed => 'Failed to delete';

  @override
  String get ui3StickerPack => 'Sticker Pack';

  @override
  String get ui3StickerAdding => 'Adding…';

  @override
  String get ui3StickerAddStickers => 'Add stickers';

  @override
  String get ui3StickerPackNotFound => 'Pack not found';

  @override
  String get ui3StickerEmptyHint => 'Tap \"Add stickers\" to upload images';

  @override
  String get ui3StickerNewPack => 'New sticker pack';

  @override
  String get ui3StickerCreate => 'Create';

  @override
  String get ui3StickerCreateFailed => 'Failed to create pack';

  @override
  String ui3StickerInstalled(Object name) {
    return 'Installed \"$name\"';
  }

  @override
  String get ui3StickerRemovePackTitle => 'Remove Sticker Pack';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return 'Remove \"$name\" from your stickers?';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return 'Removed \"$name\"';
  }

  @override
  String get ui3StickerAiSticker => 'AI Sticker';

  @override
  String get ui3StickerStoreTab => 'Store';

  @override
  String get ui3StickerMyStickersTab => 'My Stickers';

  @override
  String get ui3StickerNoneFound => 'No stickers found';

  @override
  String ui3StickerByAuthor(Object author) {
    return 'by $author';
  }

  @override
  String get ui3StickerManage => 'Manage';

  @override
  String ui3StickerCount(Object count) {
    return '$count stickers';
  }

  @override
  String get ui3StickerNoneInstalled => 'No stickers installed';

  @override
  String get ui3StickerGetFromStore => 'Get stickers from the store';

  @override
  String get ui3StickerBrowseStore => 'Browse Store';

  @override
  String get ui3StickerAddedToAi => 'Added to \"AI Stickers\"';

  @override
  String get ui3StickerAddOneFailed => 'Failed to add sticker';

  @override
  String get ui3StickerPromptLabel => 'Describe your sticker';

  @override
  String get ui3StickerPromptHint => 'e.g. a happy orange cat with sunglasses';

  @override
  String get ui3StickerGenerating => 'Generating…';

  @override
  String get ui3StickerGenerate => 'Generate';

  @override
  String get ui3StickerAddToStickers => 'Add to stickers';

  @override
  String get ui3StickerGeneratingPreview => 'Generating your sticker…';

  @override
  String get ui3StickerGenerateEmpty => 'Describe a sticker and tap Generate';
}
