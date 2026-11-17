// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class SAr extends S {
  SAr([String locale = 'ar']) : super(locale);

  @override
  String get commonRetry => 'أعد المحاولة';

  @override
  String get commonUnknownUser => 'مستخدم غير معروف';

  @override
  String get transferWalletNotConnected => 'المحفظة غير متصلة';

  @override
  String get chatCallServiceNotInitialized => 'لم تتم تهيئة خدمة الاتصال';

  @override
  String authLoginFailed(Object error) {
    return 'فشل تسجيل الدخول: $error';
  }

  @override
  String get chatCallBack => 'اتصل مرة أخرى';

  @override
  String get chatMissedVideoCall => 'مكالمة فيديو فائتة';

  @override
  String get chatMissedVoiceCall => 'مكالمة صوتية فائتة';

  @override
  String get chatCallNotAnswered => 'لم يتم الرد';

  @override
  String get chatCallDurationLabel => 'مدة المكالمة';

  @override
  String get chatVoiceCallCancelled => 'تم إلغاء المكالمة الصوتية';

  @override
  String get chatVideoCallCancelled => 'تم إلغاء مكالمة الفيديو';

  @override
  String get commonImage => '[صورة]';

  @override
  String get chatVideo => '[فيديو]';

  @override
  String get chatVoice => '[صوت]';

  @override
  String get commonFile => '[ملف]';

  @override
  String get chatLocation => '[الموقع]';

  @override
  String get chatUnknownMessage => '[رسالة غير معروفة]';

  @override
  String get commonDelete => 'حذف';

  @override
  String get chatDeleteThisMessage => 'هل تريد حذف هذه الرسالة؟';

  @override
  String get chatMessageDeleted => 'تم حذف الرسالة';

  @override
  String get profileNotLoggedIn => 'لم يتم تسجيل الدخول';

  @override
  String get chatMyLocation => 'موقعي';

  @override
  String get commonGroupChat => 'دردشة جماعية';

  @override
  String get commonSearch => 'بحث';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonLoadFailed => 'فشل التحميل';

  @override
  String get commonMessages => 'الرسائل';

  @override
  String get commonContacts => 'اتصالات';

  @override
  String get commonMe => 'أنا';

  @override
  String get commonVoiceLoading =>
      'جارٍ التحميل الصوتي، يرجى المحاولة مرة أخرى لاحقًا';

  @override
  String get commonVoiceToTextFailed => 'فشل تحويل الصوت إلى نص';

  @override
  String get commonConvertToText => 'إلى النص';

  @override
  String get chatCopy => 'نسخ';

  @override
  String get commonForward => 'إلى الأمام';

  @override
  String get commonUnfavorite => 'غير مفضل';

  @override
  String get commonFavorite => 'المفضلة';

  @override
  String get settingsResend => 'إعادة الإرسال';

  @override
  String get chatRecall => 'أذكر';

  @override
  String get commonQuote => 'اقتباس';

  @override
  String get commonRemind => 'تذكير';

  @override
  String get chatCopied => 'منقول';

  @override
  String get storySendMessageHint => 'أرسل رسالة';

  @override
  String get commonMicrophonePermissionRequired => 'يرجى السماح إذن الميكروفون';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      'تم رفض إذن الميكروفون. يرجى تفعيله في إعدادات النظام لاستخدام الرسائل الصوتية.';

  @override
  String commonStartRecordingFailed(Object error) {
    return 'فشل بدء التسجيل: $error';
  }

  @override
  String get commonRecordingTooShort => 'التسجيل قصير جدًا';

  @override
  String commonStopRecordingFailed(Object error) {
    return 'فشل في إيقاف التسجيل: $error';
  }

  @override
  String get chatReleaseToCancel => 'الافراج عن الإلغاء';

  @override
  String get chatReleaseToSend => 'حرر للإرسال، اسحب لأعلى للإلغاء';

  @override
  String get commonHoldToTalk => 'عقد للحديث';

  @override
  String get commonSend => 'أرسل';

  @override
  String get commonAddFriend => 'إضافة صديق';

  @override
  String get commonChatServiceNotConnected => 'خدمة الدردشة غير متصلة';

  @override
  String contactUserNotFoundHint(String query) {
    return 'لم يتم العثور على المستخدم \"$query\".\n\nنصائح:\n• حاول إدخال معرف المستخدم الكامل، على سبيل المثال. @username:server.com\n• التدقيق الإملائي لاسم المستخدم';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'فشل إنشاء الدردشة: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'فشل البحث: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'أدخل معرف المستخدم أو اسم المستخدم للبحث';

  @override
  String get contactSearching => 'جارٍ البحث...';

  @override
  String get contactSearchUserToChat => 'ابحث عن المستخدم لبدء الدردشة';

  @override
  String get contactMatrixIdExample =>
      'يمكنك إدخال معرف مصفوفة كامل\nعلى سبيل المثال @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'لم يتم العثور على المستخدم \"$username\".';
  }

  @override
  String get commonChat => 'الدردشة';

  @override
  String get commonSettings => 'الإعدادات';

  @override
  String get profileEditProfile => 'تحرير الملف الشخصي';

  @override
  String get authLogin => 'تسجيل الدخول';

  @override
  String get commonCreateGroup => 'إنشاء مجموعة';

  @override
  String get chatError => 'خطأ';

  @override
  String get commonTransfer => 'نقل';

  @override
  String get commonReceived => 'تم الاستلام';

  @override
  String get commonRefunded => 'ردها';

  @override
  String get commonExpired => 'انتهت صلاحيتها';

  @override
  String get chatRedPacketGreeting => 'أطيب التمنيات';

  @override
  String get commonN42RedPacket => 'N42 الحزمة الحمراء';

  @override
  String get commonClaimed => 'ادعى';

  @override
  String get commonAllClaimed => 'ادعى الجميع';

  @override
  String get chatReadAloud => 'اقرأ بصوت عالٍ';

  @override
  String get chatReply => 'رد';

  @override
  String get commonEdit => 'تحرير';

  @override
  String get chatSelectForwardTarget => 'حدد الهدف الأمامي';

  @override
  String commonSendCount(int count) {
    return 'إرسال($count)';
  }

  @override
  String contactN42Id(Object id) {
    return 'معرف N42: $id';
  }

  @override
  String get profileN42IdTitle => 'معرف N42';

  @override
  String get profileN42Bean => 'N42 فول';

  @override
  String get contactFriendInfo => 'معلومات الصديق';

  @override
  String get contactFriendInfoDesc =>
      'أضف ملاحظة الصديق والهاتف والعلامات والملاحظات والصور وتعيين الأذونات.';

  @override
  String get commonMoments => 'لحظات';

  @override
  String get commonSendMessage => 'رسالة';

  @override
  String get contactAudioVideoCall => 'مكالمة صوتية/فيديو';

  @override
  String get contactVideoChannel => 'قناة الفيديو';

  @override
  String get contactRemark => 'ملاحظة';

  @override
  String get contactRemarkName => 'اسم الملاحظة';

  @override
  String get contactPhone => 'الهاتف';

  @override
  String get contactTags => 'العلامات';

  @override
  String get contactNotes => 'ملاحظات';

  @override
  String get contactPhotos => 'صور';

  @override
  String get contactPermissions => 'الأذونات';

  @override
  String get contactChatMomentsEtc => 'الدردشة واللحظات والرياضة وما إلى ذلك.';

  @override
  String get contactMoreInfo => 'مزيد من المعلومات';

  @override
  String get contactCommonGroups => 'المجموعات المشتركة';

  @override
  String get contactSource => 'المصدر';

  @override
  String get settingsNotificationSettings => 'الإخطارات';

  @override
  String get settingsPrivacy => 'الخصوصية';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsAbout => 'حول';

  @override
  String get commonLogout => 'تسجيل الخروج';

  @override
  String get commonLogoutConfirm => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get commonSave => 'حفظ';

  @override
  String get profileNickname => 'اللقب';

  @override
  String get profileEnterNickname => 'أدخل اللقب';

  @override
  String get profileSignature => 'التوقيع';

  @override
  String get profileAddSignature => 'أضف توقيعا';

  @override
  String get commonTakePhoto => 'التقط صورة';

  @override
  String get profileChooseFromGallery => 'اختر من المعرض';

  @override
  String profileSaveFailed(Object error) {
    return 'فشل الحفظ: $error';
  }

  @override
  String get authSecureDecentralizedChat => 'المراسلة الآمنة واللامركزية';

  @override
  String get commonEndToEndEncryption => 'التشفير من النهاية إلى النهاية';

  @override
  String get authMessagesOnlyYouCanSee => 'الرسائل مرئية لك وللمستلم فقط';

  @override
  String get authDecentralized => 'لامركزية';

  @override
  String get authBasedOnMatrix => 'مبني على بروتوكول ماتريكس المفتوح';

  @override
  String get authWalletIntegration => 'تكامل المحفظة';

  @override
  String get authEasyCryptoTransfer => 'تحويلات العملة المشفرة بسهولة';

  @override
  String get authRegister => 'قم بالتسجيل';

  @override
  String get authAgreeTerms => 'بتسجيل الدخول فإنك توافق على';

  @override
  String get authTermsOfService => 'شروط الخدمة';

  @override
  String get authAnd => ' و ';

  @override
  String get authPrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get authServerAddress => 'عنوان الخادم';

  @override
  String get authEnterServerAddress => 'أدخل عنوان الخادم';

  @override
  String authConnectedTo(Object serverName) {
    return 'متصل بـ $serverName';
  }

  @override
  String get authUsername => 'اسم المستخدم';

  @override
  String get authEnterUsername => 'أدخل اسم المستخدم';

  @override
  String get authUsernameOrEmail => 'اسم المستخدم أو البريد الإلكتروني';

  @override
  String get authEnterUsernameOrEmail =>
      'أدخل اسم المستخدم أو البريد الإلكتروني';

  @override
  String get authPassword => 'كلمة المرور';

  @override
  String get authEnterPassword => 'أدخل كلمة المرور';

  @override
  String get authRegisterAccount => 'قم بالتسجيل';

  @override
  String get authForgotPassword => 'نسيت كلمة المرور';

  @override
  String get authOtherLoginMethods => 'طرق تسجيل الدخول الأخرى';

  @override
  String get authCreateAccount => 'إنشاء حساب';

  @override
  String get authJoinN42Chat => 'انضم إلى N42 Chat لبدء الدردشة';

  @override
  String get authUsernameHint => '3-20 حرفًا، حروفًا/أرقامًا/_';

  @override
  String get authUsernameMinLength =>
      'يجب أن يكون اسم المستخدم 3 أحرف على الأقل';

  @override
  String get authUsernameMaxLength =>
      'يجب أن يكون اسم المستخدم 20 حرفًا على الأكثر';

  @override
  String get authUsernameFormat =>
      'يمكن أن يحتوي اسم المستخدم على أحرف وأرقام وشرطات سفلية فقط';

  @override
  String get authPasswordHint => 'الحد الأدنى 8 أحرف';

  @override
  String get commonPasswordMinLength =>
      'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';

  @override
  String get authConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get authFilled => 'معبأ';

  @override
  String get authEnterInviteCode => 'أدخل رمز الدعوة';

  @override
  String get authAlreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get authLoginNow => 'قم بتسجيل الدخول الآن';

  @override
  String get profileAvatar => 'الصورة الرمزية';

  @override
  String get profileStatus => 'الحالة';

  @override
  String get commonLoading => 'جار التحميل...';

  @override
  String get conversationNoConversations => 'لا محادثات';

  @override
  String get conversationTapToChat =>
      'اضغط على الجزء العلوي الأيمن لبدء الدردشة';

  @override
  String get conversationStartGroup => 'ابدأ الدردشة الجماعية';

  @override
  String get commonScan => 'مسح';

  @override
  String get commonPayment => 'الدفع';

  @override
  String commonFeatureComingSoon(Object feature) {
    return '$feature قريبا';
  }

  @override
  String get conversationMarkAsRead => 'وضع علامة كمقروءة';

  @override
  String get commonUnmute => 'إلغاء كتم الصوت';

  @override
  String get commonMute => 'كتم الصوت';

  @override
  String get conversationUnpin => 'إزالة التثبيت';

  @override
  String get conversationPin => 'دبوس';

  @override
  String get conversationDeleteConversation => 'حذف المحادثة';

  @override
  String conversationDeleteConversationConfirm(Object name) {
    return 'هل تريد حذف المحادثة مع \"$name\"؟';
  }

  @override
  String get commonNoContacts => 'لا اتصالات';

  @override
  String get contactAddFriendsToChat => 'أضف أصدقاء لبدء الدردشة';

  @override
  String get contactNotFound => 'لم يتم العثور على جهة الاتصال';

  @override
  String get contactTryOtherKeywords => 'جرب كلمات رئيسية أخرى أو بحث عالمي';

  @override
  String get contactSearchResults => 'نتائج البحث';

  @override
  String get contactNewFriends => 'أصدقاء جدد';

  @override
  String get contactChatOnlyFriends => 'أصدقاء الدردشة فقط';

  @override
  String get contactOfficialAccounts => 'الحسابات الرسمية';

  @override
  String get contactServiceAccounts => 'حسابات الخدمة';

  @override
  String get contactEnterpriseContacts => 'اتصالات المؤسسة';

  @override
  String get contactRecommendToFriend => 'مشاركة الاتصال';

  @override
  String get commonSetRemark => 'تعيين الملاحظة';

  @override
  String get contactSendingCard => 'جارٍ إرسال بطاقة جهة الاتصال...';

  @override
  String get commonFileLabel => 'ملف';

  @override
  String get commonLocationLabel => 'الموقع';

  @override
  String contactRecommendFailed(Object error) {
    return 'فشل التوصية: $error';
  }

  @override
  String get profileEnterRemark => 'أدخل الملاحظة';

  @override
  String get contactOpeningChat => 'جارٍ فتح الدردشة...';

  @override
  String contactOpenChatFailed(Object error) {
    return 'فشل فتح الدردشة: $error';
  }

  @override
  String get contactAddContact => 'إضافة جهة اتصال';

  @override
  String get contactEnterUserId => 'أدخل معرف المستخدم';

  @override
  String get contactNoFriendRequests => 'لا توجد طلبات صداقة';

  @override
  String get commonAccept => 'قبول';

  @override
  String get commonReject => 'رفض';

  @override
  String get commonNoGroups => 'لا توجد مجموعات';

  @override
  String get contactSelectFriendToRecommend => 'اختر صديقًا للتوصية به';

  @override
  String get commonSearchContacts => 'البحث في جهات الاتصال';

  @override
  String get contactNoContactsFound => 'لم يتم العثور على جهات اتصال';

  @override
  String get favoriteYesterday => 'أمس';

  @override
  String get chatJustNow => 'الآن فقط';

  @override
  String get profileOnline => 'على الانترنت';

  @override
  String get profileOffline => 'غير متصل';

  @override
  String get searchContactsGroupsMessages =>
      'البحث في جهات الاتصال والمجموعات والرسائل';

  @override
  String get searchError => 'خطأ في البحث';

  @override
  String get chatSearchHint => 'بحث';

  @override
  String get searchHistory => 'سجل البحث';

  @override
  String get commonClear => 'واضح';

  @override
  String get commonAll => 'الكل';

  @override
  String get searchGroups => 'المجموعات';

  @override
  String get searchNoResults => 'لا توجد نتائج';

  @override
  String commonGroupMembers(Object count) {
    return 'الأعضاء ($count)';
  }

  @override
  String get groupMembersTitle => 'أعضاء المجموعة';

  @override
  String get groupViewAll => 'عرض الكل';

  @override
  String get groupOwner => 'المالك';

  @override
  String get groupAdmin => 'المشرف';

  @override
  String get groupInvite => 'دعوة';

  @override
  String get commonGroupAnnouncement => 'إعلان المجموعة';

  @override
  String get commonNotSet => 'لم يتم ضبطه';

  @override
  String get groupDescription => 'وصف المجموعة';

  @override
  String get groupPublicGroup => 'المجموعة العامة';

  @override
  String get commonClearChatHistory => 'مسح سجل الدردشة';

  @override
  String get commonDissolveGroup => 'حل المجموعة';

  @override
  String get commonLeaveGroup => 'مغادرة المجموعة';

  @override
  String get groupChangeGroupName => 'تغيير اسم المجموعة';

  @override
  String get commonEnterGroupName => 'أدخل اسم المجموعة';

  @override
  String get commonConfirm => 'تأكيد';

  @override
  String get groupEnterGroupDescription => 'أدخل وصف المجموعة';

  @override
  String get groupPublish => 'نشر';

  @override
  String get chatClearHistoryConfirm =>
      'هل تريد مسح سجل الدردشة بالكامل؟ لا يمكن التراجع عن هذا.';

  @override
  String get chatClearAction => 'واضح';

  @override
  String get commonChatHistoryCleared => 'تم مسح سجل الدردشة';

  @override
  String get commonDissolve => 'حل';

  @override
  String get groupQrCode => 'رمز الاستجابة السريعة للمجموعة';

  @override
  String get commonSearchChatHistory => 'البحث في سجل الدردشة';

  @override
  String get groupIdCopied => 'تم نسخ معرف المجموعة';

  @override
  String get transferEnterOrPasteAddress => 'أدخل أو الصق عنوان المحفظة';

  @override
  String get transferSelectToken => 'حدد الرمز المميز';

  @override
  String get commonTransferAmount => 'مبلغ التحويل';

  @override
  String get transferAvailable => 'متاح';

  @override
  String get transferMemoOptional => 'مذكرة (اختياري)';

  @override
  String get transferConfirmTransfer => 'تأكيد النقل';

  @override
  String get transferAddressVerified => 'تم التحقق من العنوان';

  @override
  String transferAvailableBalance(Object balance, Object symbol) {
    return 'متاح: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'أدخل المبلغ';

  @override
  String get commonRedPacketCountMin => 'مطلوب حزمة حمراء واحدة على الأقل';

  @override
  String get commonViewRedPacketDetails => 'عرض تفاصيل الحزمة الحمراء';

  @override
  String get commonEnterTransferAmount => 'الرجاء إدخال مبلغ التحويل';

  @override
  String get commonTransferTo => 'نقل إلى';

  @override
  String commonFromSender(String name) {
    return 'من $name';
  }

  @override
  String get commonConfirmReceive => 'تأكيد الاستلام';

  @override
  String get groupProfile => 'معلومات المجموعة';

  @override
  String get groupRemoveMember => 'إزالة من المجموعة';

  @override
  String get commonRemove => 'إزالة';

  @override
  String get profileClearStatus => 'مسح الحالة';

  @override
  String get profileClearStatusConfirm => 'هل تريد مسح الوضع الحالي؟';

  @override
  String get profileStatusCleared => 'تم مسح الحالة';

  @override
  String get profileUserNotExist => 'المستخدم غير موجود';

  @override
  String get profileUserIdCopied => 'تم نسخ معرف المستخدم';

  @override
  String get commonReport => 'تقرير';

  @override
  String get profileQrCode => 'رمز الاستجابة السريعة';

  @override
  String get profileAvatarUpdated => 'تم تحديث الصورة الرمزية';

  @override
  String commonSelectImageFailed(Object error) {
    return 'فشل في تحديد الصورة: $error';
  }

  @override
  String get profileChangeName => 'تغيير الاسم';

  @override
  String get profileMale => 'ذكر';

  @override
  String get profileFemale => 'أنثى';

  @override
  String chatFeatureInDev(String feature) {
    return 'ميزة $feature قيد التطوير...';
  }

  @override
  String profileSaveAddressFailed(Object error) {
    return 'فشل حفظ العنوان: $error';
  }

  @override
  String get profileAddNew => 'أضف';

  @override
  String get profileAddAddress => 'إضافة عنوان';

  @override
  String get profileAddressAdded => 'تمت إضافة العنوان';

  @override
  String get profileAddressUpdated => 'تم تحديث العنوان';

  @override
  String get profileDeleteAddress => 'حذف العنوان';

  @override
  String get profileAddressDeleted => 'تم حذف العنوان';

  @override
  String profileSaveInvoiceFailed(Object error) {
    return 'فشل حفظ الفاتورة: $error';
  }

  @override
  String get profileMyInvoices => 'فواتيري';

  @override
  String get profileAddInvoice => 'أضف الفاتورة';

  @override
  String get profileInvoiceAdded => 'تمت إضافة الفاتورة';

  @override
  String get profileInvoiceUpdated => 'تم تحديث الفاتورة';

  @override
  String get profileDeleteInvoice => 'حذف الفاتورة';

  @override
  String get profileInvoiceDeleted => 'تم حذف الفاتورة';

  @override
  String get profilePersonal => 'شخصي';

  @override
  String get groupSelectAtLeastOne => 'الرجاء اختيار عضو واحد على الأقل';

  @override
  String get chatFileNotExist => 'الملف غير موجود';

  @override
  String chatSendFailed(String error) {
    return 'فشل الإرسال: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'لا يمكن فتح المتصفح';

  @override
  String chatSelectFileFailed(String error) {
    return 'فشل في تحديد الملف: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'فشل الإعداد: $error';
  }

  @override
  String get transferEnterValidAmount => 'الرجاء إدخال مبلغ صالح';

  @override
  String get commonAddressCopied => 'تم نسخ العنوان';

  @override
  String favoriteOpenItem(Object content) {
    return 'فتح: $content';
  }

  @override
  String get favoriteDeleted => 'تم الحذف';

  @override
  String get profileWallet => 'المحفظة';

  @override
  String get chatRecording => 'التسجيل';

  @override
  String get chatInvalidVideoUrl => 'عنوان URL للفيديو غير صالح';

  @override
  String get chatDownloadFile => 'تنزيل الملف';

  @override
  String get chatClearChatHistoryTitle => 'مسح سجل الدردشة';

  @override
  String get chatVideoCall => 'مكالمة فيديو';

  @override
  String get commonVoiceCall => 'مكالمة صوتية';

  @override
  String get callLeaveMeeting => 'مغادرة الاجتماع';

  @override
  String get chatDetails => 'تفاصيل الدردشة';

  @override
  String get chatViewAllGroupMembers => 'مشاهدة كافة الأعضاء';

  @override
  String get chatGroupName => 'اسم المجموعة';

  @override
  String get chatGroupNameUpdated => 'تم تحديث اسم المجموعة';

  @override
  String get chatUpdateFailed => 'فشل التحديث';

  @override
  String get chatNoPermissionToModify => 'ليس لديك الإذن بالتعديل';

  @override
  String get chatGroupManagement => 'إدارة المجموعة';

  @override
  String get chatMyNicknameInGroup => 'لقبي في المجموعة';

  @override
  String get chatPinChat => 'دبوس الدردشة';

  @override
  String get chatStrongReminder => 'تذكير قوي';

  @override
  String get chatSetChatBackground => 'تعيين خلفية الدردشة';

  @override
  String get chatUnknownFile => 'ملف غير معروف';

  @override
  String get chatDownload => 'تحميل';

  @override
  String get chatInvalidLocation => 'الموقع غير صالح';

  @override
  String get chatTapToCancel => 'انقر للإلغاء';

  @override
  String chatCaptureFailed(Object error) {
    return 'فشل الالتقاط: $error';
  }

  @override
  String get chatProcessingVideo => 'جارٍ معالجة الفيديو...';

  @override
  String get chatVideoFileNotExist => 'ملف الفيديو غير موجود';

  @override
  String get chatVideoDataEmpty => 'بيانات الفيديو فارغة';

  @override
  String get chatVideoTooLarge => 'لا يمكن أن يتجاوز حجم الفيديو 100 ميجابايت';

  @override
  String get chatSendingVideo => 'جارٍ إرسال الفيديو...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'فشل إرسال الفيديو: $error';
  }

  @override
  String get chatImageFileNotExist => 'ملف الصورة غير موجود';

  @override
  String get commonImageDataEmpty => 'بيانات الصورة فارغة';

  @override
  String get chatSendingImage => 'جارٍ إرسال الصورة...';

  @override
  String chatSendImageFailed(Object error) {
    return 'فشل إرسال الصورة: $error';
  }

  @override
  String get chatSendLocation => 'إرسال الموقع';

  @override
  String get chatSelectLocationAndSend => 'حدد الموقع وأرسل';

  @override
  String get chatShareRealTimeLocation => 'مشاركة الموقع في الوقت الحقيقي';

  @override
  String get chatShareLocationForOneHour =>
      'مشاركة الموقع في الوقت الفعلي مع صديق لمدة ساعة واحدة';

  @override
  String get chatLocationSent => 'تم إرسال الموقع';

  @override
  String get chatSelectMessages => 'حدد الرسائل';

  @override
  String chatSelectedCount(int count) {
    return 'تم التحديد $count';
  }

  @override
  String get chatSelectAll => 'حدد الكل';

  @override
  String chatGroupChatCount(int count) {
    return 'الدردشة الجماعية($count)';
  }

  @override
  String get chatPrivateChat => 'دردشة خاصة';

  @override
  String get chatNoMessages => 'لا توجد رسائل';

  @override
  String get chatSendFirstMessage => 'أرسل الرسالة الأولى لبدء الدردشة';

  @override
  String get chatEncryptionNotice =>
      'هذه الدردشة مشفرة من طرف إلى طرف. يمكنك أنت والمستلم فقط قراءة الرسائل.';

  @override
  String get chatMultiForward => 'إلى الأمام';

  @override
  String get chatCollect => 'اجمع';

  @override
  String get chatNoMembers => 'لا أعضاء';

  @override
  String get chatMemberNotFound => 'لم يتم العثور على العضو';

  @override
  String get chatVoiceFileNotExist => 'الملف الصوتي غير موجود';

  @override
  String get chatVoiceFileEmpty => 'الملف الصوتي فارغ';

  @override
  String get chatSendingVoice => 'جارٍ إرسال الصوت...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'فشل إرسال الصوت: $error';
  }

  @override
  String get chatMessageForwarded => 'تم إعادة توجيه الرسالة';

  @override
  String chatForwardFailed(Object error) {
    return 'فشل إعادة التوجيه: $error';
  }

  @override
  String get chatUnfavorited => 'غير مفضل';

  @override
  String get chatFavorited => 'المفضلة';

  @override
  String get chatReactionAdded => 'تمت إضافة التفاعل';

  @override
  String get chatReactionRemoved => 'تمت إزالة التفاعل';

  @override
  String get chatFailedMessageDeleted => 'تم حذف الرسالة الفاشلة';

  @override
  String get chatDeleteMessages => 'حذف الرسائل';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'هل أنت متأكد أنك تريد حذف رسائل $count؟';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'ملاحظة: رسائل $count هي من الآخرين وسيتم حذفها لك فقط.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return 'سيتم استدعاء رسائل $count منك للجميع.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return 'تم استدعاء رسائل $count، وتم حذف $localCount لك فقط';
  }

  @override
  String chatRecalledMessages(Object count) {
    return 'تم استدعاء رسائل $count';
  }

  @override
  String chatDeletedLocally(Object count) {
    return 'تم حذف رسائل $count لك فقط';
  }

  @override
  String chatForwardedCount(Object count) {
    return 'رسائل $count المعاد توجيهها';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'اكتمل إعادة التوجيه: نجح $success، وفشل $failed';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'ميزة التذكير متاحة فقط في الدردشة الجماعية';

  @override
  String get chatOnlyTextSearchable => 'يمكن البحث في الرسائل النصية فقط';

  @override
  String chatSearchFor(Object text) {
    return 'بحث \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'بحث بايدو';

  @override
  String get chatGoogleSearch => 'بحث جوجل';

  @override
  String get chatBingSearch => 'بحث بنج';

  @override
  String get chatCalling => 'جارٍ الاتصال...';

  @override
  String get chatRinging => 'رنين...';

  @override
  String get chatInCall => 'في المكالمة';

  @override
  String commonFeatureInDevelopment(Object feature) {
    return 'ميزة $feature قيد التطوير...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'رسائل $count المجمعة';
  }

  @override
  String commonMemberCount(int count) {
    return 'أعضاء $count';
  }

  @override
  String groupDone(int count) {
    return 'تم ($count)';
  }

  @override
  String get profileServices => 'الخدمات';

  @override
  String get commonFavorites => 'المفضلة';

  @override
  String get profileOrdersAndCards => 'الطلبات والبطاقات';

  @override
  String get profileStickers => 'ملصقات';

  @override
  String profileStatusSetTo(String status) {
    return 'تم ضبط الحالة على: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'فشل تحميل الصورة الرمزية';

  @override
  String get profilePersonalProfile => 'الملف الشخصي';

  @override
  String get profileName => 'الاسم';

  @override
  String get profileGender => 'الجنس';

  @override
  String get profileRegion => 'المنطقة';

  @override
  String get commonMyQrCode => 'رمز الاستجابة السريعة الخاص بي';

  @override
  String get profilePoke => 'كزة';

  @override
  String get profileRingtone => 'نغمة رنين';

  @override
  String get profileDefaultRingtone => 'نغمة الرنين الافتراضية';

  @override
  String get profileMyAddresses => 'عناويني';

  @override
  String profileGenderSetTo(String gender) {
    return 'تم ضبط الجنس على: $gender';
  }

  @override
  String get profileSelectRegion => 'حدد المنطقة';

  @override
  String get profileSelectCity => 'اختر المدينة';

  @override
  String profileRegionSetTo(String region) {
    return 'تم ضبط المنطقة على: $region';
  }

  @override
  String get profileSetPoke => 'تعيين كزة';

  @override
  String get profileFriendPokedMe => 'صديق طعنني';

  @override
  String get profileExample => 'مثال';

  @override
  String get profileOnTheShoulder => 'على الكتف';

  @override
  String get profilePokeCleared => 'تم مسح كزة';

  @override
  String profilePokeSetTo(String suffix) {
    return 'تم ضبط النكز على: poked me$suffix';
  }

  @override
  String get profileEditSignature => 'تحرير التوقيع';

  @override
  String get profileIntroduceYourself => 'جملة للتعريف بنفسك';

  @override
  String get profileSignatureCleared => 'تم مسح التوقيع';

  @override
  String get profileSignatureUpdated => 'تم تحديث التوقيع';

  @override
  String get profileScanToAddFriend =>
      'امسح رمز الاستجابة السريعة أعلاه لإضافتي كصديق';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'تم ضبط نغمة الرنين على: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'هل أنت متأكد أنك تريد حل \"$name\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get authEnterValidServerAddress => 'الرجاء إدخال عنوان خادم صالح';

  @override
  String get authEnterServerAddressFirst => 'الرجاء إدخال عنوان الخادم أولاً';

  @override
  String get authPasskeyRequiresServer =>
      'يتطلب تسجيل الدخول بمفتاح المرور دعم الخادم';

  @override
  String get authLoginAgreement => 'بتسجيل الدخول فإنك توافق على';

  @override
  String get authPleaseAgreeToTerms =>
      'يرجى قراءة شروط الخدمة وسياسة الخصوصية والموافقة عليها';

  @override
  String get authRegisterFailed => 'فشل التسجيل';

  @override
  String get authRegistrationDisabled =>
      'عطّل هذا الخادم التسجيل. تواصل مع مسؤول الخادم لتفعيله.';

  @override
  String get commonReenterPassword => 'أعد إدخال كلمة المرور';

  @override
  String get commonPasswordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get authInviteCodeBuiltIn => 'رمز الدعوة (مدمج)';

  @override
  String get authInviteCodeBuiltInNote =>
      'رمز الدعوة مدمج، وعادة لا يحتاج إلى تعديل';

  @override
  String get authIHaveReadAndAgree => 'لقد قرأت ووافقت على';

  @override
  String get mainStartGroupChat => 'ابدأ الدردشة الجماعية';

  @override
  String get mainAddFriends => 'أضف أصدقاء';

  @override
  String get mainPaymentAndCollection => 'الدفع';

  @override
  String contactCount(int count) {
    return 'اتصالات $count';
  }

  @override
  String get contactAddToHomeScreen => 'أضف إلى الشاشة الرئيسية';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'أوصى بطاقة $contact ل$recipient';
  }

  @override
  String get contactEnterRemarkName => 'أدخل اسم الملاحظة';

  @override
  String contactRemarkSetTo(String remark) {
    return 'تم ضبط الملاحظة على: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'تم قبول طلب الصداقة الخاص بـ $name';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'تم رفض طلب الصداقة الخاص بـ $name';
  }

  @override
  String get commonGroupInvites => 'دعوات المجموعة';

  @override
  String commonMyGroups(int count) {
    return 'مجموعاتي ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'تمت دعوته للانضمام إلى المجموعة';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'هل أنت متأكد أنك تريد مغادرة \"$name\"؟';
  }

  @override
  String get commonLeave => 'غادر';

  @override
  String get commonRecallThisMessage => 'هل تتذكر هذه الرسالة؟';

  @override
  String get commonSavedToGallery => 'تم الحفظ في المعرض';

  @override
  String get commonFailedToSave => 'فشل الحفظ';

  @override
  String get chatSaving => 'جارٍ الحفظ...';

  @override
  String get commonShare => 'شارك';

  @override
  String get chatSaveToGallery => 'حفظ في المعرض';

  @override
  String get chatFailedToLoadImage => 'فشل تحميل الصورة';

  @override
  String get chatVideoRecordingFailed => 'فشل تسجيل الفيديو';

  @override
  String get profileRedPacket => 'الحزمة الحمراء';

  @override
  String get commonMusic => 'موسيقى';

  @override
  String get commonCoupon => 'قسيمة';

  @override
  String get commonGift => 'هدية';

  @override
  String get commonPoll => 'استطلاع';

  @override
  String get favoriteText => 'نص';

  @override
  String get favoriteLinkLabel => 'رابط';

  @override
  String get favoriteNote => 'ملاحظة';

  @override
  String get favoriteMyNotes => 'ملاحظاتي';

  @override
  String get favoriteToday => 'اليوم';

  @override
  String favoriteDaysAgoText(int count) {
    return 'منذ أيام $count';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$month/$day';
  }

  @override
  String get favoriteNoFavorites => 'لا يوجد مفضلة بعد';

  @override
  String get favoriteLongPressToFavorite =>
      'اضغط لفترة طويلة على الرسالة إلى المفضلة';

  @override
  String get favoriteNewNote => 'ملاحظة جديدة';

  @override
  String get favoriteLink => 'الرابط المفضل';

  @override
  String get favoriteEditTags => 'تحرير العلامات';

  @override
  String get favoriteDeleteFavorite => 'حذف المفضلة';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'هل أنت متأكد أنك تريد حذف هذه المفضلة؟';

  @override
  String get favoriteNoSearchResultsFound => 'لم يتم العثور على نتائج';

  @override
  String get commonSendRedPacket => 'إرسال الحزمة الحمراء';

  @override
  String get transferAmount => 'المبلغ';

  @override
  String get commonRedPacketCover => 'غطاء الحزمة الحمراء';

  @override
  String get commonRedPacketType => 'نوع الحزمة الحمراء';

  @override
  String get commonNormalRedPacket => 'عادي';

  @override
  String get commonLuckyRedPacket => 'محظوظ';

  @override
  String get commonRedPacketCount => 'عدد الحزم الحمراء';

  @override
  String get commonPieces => 'قطع';

  @override
  String get commonPutMoneyInRedPacket => 'ضع المال في الحزمة الحمراء';

  @override
  String get commonRedPacketRefundNotice =>
      'سيتم استرداد الحزم الحمراء غير المطالب بها بعد 24 ساعة';

  @override
  String get commonOpenRedPacket => 'مفتوح';

  @override
  String get commonRedPacketAllClaimed => 'ادعى كل حزمة حمراء';

  @override
  String get commonRedPacketExpired => 'انتهت صلاحية الحزمة الحمراء';

  @override
  String get commonAddTransferNote => 'إضافة مذكرة نقل';

  @override
  String get commonYuan => 'يوان صيني';

  @override
  String get commonReplyWithEmoji => 'الرد بهذا الرمز التعبيري';

  @override
  String get contactEditRemark => 'تحرير الملاحظة';

  @override
  String get contactSetPermissions => 'تعيين الأذونات';

  @override
  String get profileAddToBlacklist => 'أضف إلى القائمة السوداء';

  @override
  String get contactDeleteContact => 'حذف جهة الاتصال';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'هل أنت متأكد من أنك تريد حذف $name؟';
  }

  @override
  String get transferTitle => 'نقل';

  @override
  String get transferReceiverAddressLabel => 'عنوان المستلم';

  @override
  String get transferSelectTokenLabel => 'حدد الرمز المميز';

  @override
  String get transferAmountLabel => 'مبلغ التحويل';

  @override
  String get transferMemoLabel => 'مذكرة (اختياري)';

  @override
  String get transferAddMemoHint => 'أضف مذكرة';

  @override
  String get transferSendPaymentRequest => 'إرسال طلب الدفع';

  @override
  String get transferQrCodeGenerateFailed => 'فشل إنشاء رمز الاستجابة السريعة';

  @override
  String get transferScanQrToPayMe =>
      'امسح رمز الاستجابة السريعة ضوئيًا لتدفع لي';

  @override
  String get transferMyWalletAddress => 'عنوان محفظتي';

  @override
  String get transferCreatePaymentRequest => 'إنشاء طلب الدفع';

  @override
  String profileN42IdLabel(String id) {
    return 'معرف N42: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'أطيب التمنيات';

  @override
  String commonSenderRedPacket(String name) {
    return 'الحزمة الحمراء لـ $name';
  }

  @override
  String get transferEnterValidAddress => 'الرجاء إدخال عنوان صالح';

  @override
  String get transferPleaseSelectToken => 'الرجاء تحديد رمز مميز';

  @override
  String get commonReceivedTransfer => 'التحويل المستلم';

  @override
  String commonSenderSentRedPacket(String name) {
    return 'أرسل $name حزمة حمراء';
  }

  @override
  String get commonSavedToBalance => 'محفوظ في الرصيد، يمكن التحويل مباشرة';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'انتهت صلاحية الحزمة الحمراء/تم المطالبة بكل شيء';

  @override
  String get transferScanFeatureComingSoon => 'ميزة المسح قريبا...';

  @override
  String get contactSetAsStarred => 'تعيين كنجمة';

  @override
  String get contactAddToBlocklist => 'أضف إلى قائمة الحظر';

  @override
  String get commonClaimedYour => 'ادعى الخاص بك';

  @override
  String get commonClaimedText => 'ادعى';

  @override
  String commonUserTyping(String name) {
    return '$name يكتب...';
  }

  @override
  String get commonTyping => 'جاري الكتابة...';

  @override
  String get commonWaitingToReceive => 'في انتظار تلقي';

  @override
  String get commonTapToClaim => 'انقر للمطالبة';

  @override
  String get commonHasBeenReceived => 'تم استلامه';

  @override
  String get commonGetLucky => 'كن محظوظا';

  @override
  String get qrcodeCameraStartFailed => 'فشل تشغيل الكاميرا';

  @override
  String get qrcodeUnknownError => 'خطأ غير معروف';

  @override
  String get qrcodePlaceQrCodeInFrame => 'ضع رمز QR داخل الإطار لمسحه ضوئيًا';

  @override
  String get qrcodeCloseManualInput => 'إغلاق الإدخال اليدوي';

  @override
  String get qrcodeManualInputUserId => 'معرف مستخدم الإدخال اليدوي';

  @override
  String get commonAdd => 'أضف';

  @override
  String get profileSetStatus => 'تعيين الحالة';

  @override
  String get profileVisibleToFriends24h => 'مرئية للأصدقاء لمدة 24 ساعة';

  @override
  String get profileWriteStatus => 'كتابة الحالة';

  @override
  String get profileEnterYourStatus => 'أدخل حالتك...';

  @override
  String get profileOk => 'حسنًا';

  @override
  String get qrcodeCameraPermissionRequired =>
      'مطلوب إذن الكاميرا لمسح رمز الاستجابة السريعة';

  @override
  String get qrcodeCameraPermissionDenied =>
      'تم رفض إذن الكاميرا بشكل دائم. يرجى تمكينه في إعدادات النظام.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'خطأ في التحقق من الإذن: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'رمز الاستجابة السريعة غير صالح';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'لا يمكن إضافة صديق: $error';
  }

  @override
  String get qrcodeScanQrCode => 'مسح رمز الاستجابة السريعة';

  @override
  String get qrcodeCheckingCameraPermission => 'جارٍ التحقق من إذن الكاميرا...';

  @override
  String get qrcodeNeedCameraPermission => 'مطلوب إذن الكاميرا';

  @override
  String get qrcodeRetryPermission => 'أعد المحاولة';

  @override
  String get qrcodeOpenSettings => 'افتح الإعدادات';

  @override
  String get groupInviteMembers => 'دعوة الأعضاء';

  @override
  String groupInviteCount(int count) {
    return 'دعوة ($count)';
  }

  @override
  String get profileNoShippingAddress => 'لا يوجد عنوان الشحن';

  @override
  String get profileDefaultLabel => 'الافتراضي';

  @override
  String get profileNoInvoice => 'لا فاتورة';

  @override
  String get profileCompany => 'الشركة';

  @override
  String get profileTaxNumber => 'الرقم الضريبي';

  @override
  String get profileConfirmDeleteAddress =>
      'هل أنت متأكد أنك تريد حذف هذا العنوان؟';

  @override
  String get profileConfirmDeleteInvoice =>
      'هل أنت متأكد أنك تريد حذف هذه الفاتورة؟';

  @override
  String get commonGroupOwner => 'المالك';

  @override
  String get commonGroupAdmin => 'المشرف';

  @override
  String get groupSearchMembers => 'أعضاء البحث';

  @override
  String groupTotalMembers(int count) {
    return 'أعضاء $count';
  }

  @override
  String get chatRemoveFromGroup => 'إزالة من المجموعة';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'هل أنت متأكد أنك تريد إزالة \"$name\" من المجموعة؟';
  }

  @override
  String get chatUnknownSong => 'أغنية غير معروفة';

  @override
  String get chatUnknownArtist => 'فنان غير معروف';

  @override
  String get chatUnknownContact => 'جهة اتصال غير معروفة';

  @override
  String get chatPersonalCard => 'بطاقة الاتصال';

  @override
  String get chatSingleChoice => 'واحد';

  @override
  String get chatMultiChoice => 'متعدد';

  @override
  String get chatEnded => 'انتهى';

  @override
  String get chatEndPollButton => 'إنهاء الاستطلاع';

  @override
  String get chatPollHint =>
      'سيتم عرض الاستطلاع في الدردشة. يمكن لأعضاء المجموعة التصويت.';

  @override
  String get chatSearchSongOrArtist => 'البحث عن أغنية أو فنان';

  @override
  String get chatNoSongsFound => 'لم يتم العثور على أي أغاني';

  @override
  String get chatSongNameOptional => 'اسم الأغنية (اختياري)';

  @override
  String get chatEnterSongName => 'أدخل اسم الأغنية';

  @override
  String get chatArtistNameOptional => 'اسم الفنان (اختياري)';

  @override
  String get chatEnterArtistName => 'أدخل اسم الفنان';

  @override
  String get chatRealTimeLocationSharing =>
      'مشاركة الموقع في الوقت الفعلي قيد التطوير...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'ميزة المكالمات الصوتية قيد التطوير...';

  @override
  String get profileReportFeatureInDev => 'ميزة التقرير قيد التطوير...';

  @override
  String get profileShareFeatureInDev => 'ميزة المشاركة قيد التطوير...';

  @override
  String get profileQrCodeFeatureInDev => 'ميزة QR Code قيد التطوير...';

  @override
  String get qrcodeScanQrToAddMe =>
      'امسح رمز الاستجابة السريعة أعلاه لإضافتي كصديق';

  @override
  String get qrcodeSaveToAlbum => 'حفظ في الألبوم';

  @override
  String get qrcodeChangeStyle => 'تغيير النمط';

  @override
  String get qrcodeCopyId => 'نسخ معرف';

  @override
  String get qrcodeIdCopied => 'تم نسخ الهوية';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => 'المزيد من الأساليب قريبا';

  @override
  String get profileBio => 'السيرة الذاتية';

  @override
  String get profileHomeServer => 'الخادم';

  @override
  String get profileShareContactCard => 'مشاركة بطاقة الاتصال';

  @override
  String get profileRemoveFromBlacklist => 'إزالة من القائمة السوداء';

  @override
  String get profileConfirmAddBlacklist =>
      'هل أنت متأكد أنك تريد إضافة هذا المستخدم إلى القائمة السوداء؟ لن تتلقى رسائل منهم.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'هل أنت متأكد أنك تريد إزالة هذا المستخدم من القائمة السوداء؟';

  @override
  String get profileRemarkSaved => 'تم حفظ الملاحظة';

  @override
  String get profileRemarkCleared => 'تم مسح الملاحظة';

  @override
  String get transferReceive => 'تلقي';

  @override
  String get transferPleaseConnectWallet => 'يرجى توصيل محفظتك أولا';

  @override
  String get transferSendRequest => 'إرسال الطلب';

  @override
  String get transferPleaseEnterValidAmount => 'الرجاء إدخال مبلغ صالح';

  @override
  String get searchPlaceholder => 'البحث في جهات الاتصال والمجموعات والرسائل';

  @override
  String get searchEnterKeywordToSearch => 'أدخل الكلمة الرئيسية لبدء البحث';

  @override
  String get searchClearHistory => 'واضح';

  @override
  String searchNoResultsForQuery(String query) {
    return 'لم يتم العثور على أي نتائج \"$query\"';
  }

  @override
  String get searchAllResults => 'الكل';

  @override
  String get searchInChat => 'البحث في الدردشة';

  @override
  String get searchContactLabel => 'الاتصال';

  @override
  String get searchGroupLabel => 'المجموعة';

  @override
  String get searchConversationLabel => 'محادثة';

  @override
  String get searchMessageLabel => 'رسالة';

  @override
  String get settingsSecurityTitle => 'الأمن';

  @override
  String get settingsDeleteAccountTitle => 'حذف الحساب';

  @override
  String get settingsDeleteAccountSubtitle =>
      'تعطيل حساب Matrix هذا وتنظيف بيانات الدردشة المحلية الخاصة به';

  @override
  String get settingsDeleteAccountExplanation =>
      'يطلب هذا الإجراء تعطيل حساب Matrix نهائيًا. بعد تأكيد الخادم، يزيل التطبيق جلسة الدردشة المحلية ومفاتيح التشفير لهذا الحساب عندما يكون ذلك آمنًا. تُحفظ الحسابات الأخرى ومحفظتك. قد تحدّ الفيدرالية وسياسات احتفاظ الخادم من محو البيانات.';

  @override
  String get settingsDeleteAccountPasswordOptional =>
      'كلمة مرور Matrix، إذا طُلبت';

  @override
  String get settingsDeleteAccountServerErase => 'طلب محو بيانات الخادم';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      'اطلب من هذا الخادم الرئيسي محو بيانات الحساب حيثما كان ذلك مدعومًا. قد تبقى النسخ الموجودة على خوادم أخرى أو التي تتطلب سياسات الاحتفاظ بقاءها.';

  @override
  String get settingsDeleteAccountChooseStage => 'التحقق من حساب Matrix هذا';

  @override
  String get settingsDeleteAccountUsePassword => 'استخدام كلمة مرور Matrix';

  @override
  String get settingsDeleteAccountUseBrowser => 'المتابعة في المتصفح';

  @override
  String get settingsDeleteAccountFallbackTitle =>
      'العودة من التحقق عبر Matrix';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      'العودة من المتصفح لا تؤكد الحذف. تحقق من الطلب الأصلي لدى خادم Matrix.';

  @override
  String get settingsDeleteAccountCheckServer => 'التحقق لدى الخادم';

  @override
  String get settingsDeleteAccountRequestFailed =>
      'لم يؤكد خادم Matrix حذف الحساب.';

  @override
  String get settingsDeleteAccountPendingTitle =>
      'تنظيف الحساب المحلي قيد الانتظار';

  @override
  String get settingsDeleteAccountPendingSubtitle =>
      'مراجعة تنظيف حساب Matrix تم تعطيله سابقًا';

  @override
  String get settingsDeleteAccountPendingReadError =>
      'تعذرت قراءة سجلات التنظيف المعلّقة. اضغط لإعادة المحاولة.';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'تم تعطيل حساب Matrix، لكن التنظيف المحلي لا يزال قيد الانتظار. تبقى الحسابات الأخرى متاحة.';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      'فُتحت إدارة الحساب في متصفحك. لم يُؤكَّد الحذف في هذا التطبيق، لذا تبقى جلسة الدردشة متاحة.';

  @override
  String get settingsKeyBackup => 'النسخ الاحتياطي للمفتاح';

  @override
  String get settingsBackupEncryptionKeys => 'مفاتيح التشفير الاحتياطية';

  @override
  String settingsKeysBackedUp(int count) {
    return 'تم عمل نسخة احتياطية من مفاتيح $count';
  }

  @override
  String get settingsBackupNotSet => 'لم يتم تعيين النسخ الاحتياطي';

  @override
  String get settingsRestoreKeys => 'استعادة المفاتيح';

  @override
  String get settingsRestoreKeysFromBackup =>
      'استعادة مفاتيح التشفير من النسخة الاحتياطية';

  @override
  String get settingsExportKeys => 'مفاتيح التصدير';

  @override
  String get settingsExportKeysToFile => 'تصدير المفاتيح إلى الملف';

  @override
  String get settingsLoggedInDevices => 'الأجهزة التي تم تسجيل دخولها';

  @override
  String get settingsNoOtherDevices => 'لا توجد أجهزة أخرى';

  @override
  String get settingsVerified => 'تم التحقق منه';

  @override
  String get settingsUnverified => 'لم يتم التحقق منها';

  @override
  String get settingsAdvanced => 'متقدم';

  @override
  String get settingsCrossSigning => 'التوقيع المتبادل';

  @override
  String get settingsEnabled => 'ممكّن';

  @override
  String get settingsNotEnabled => 'غير ممكّن';

  @override
  String get settingsResetEncryption => 'إعادة تعيين التشفير';

  @override
  String get settingsDeleteAllEncryptionKeys => 'احذف كافة مفاتيح التشفير';

  @override
  String get settingsEncryptionNotSupported => 'التشفير غير مدعوم';

  @override
  String get settingsNotInitialized => 'لم تتم التهيئة';

  @override
  String get settingsBackupKeyTitle => 'مفاتيح النسخ الاحتياطي';

  @override
  String get settingsBackupKeyMessage =>
      'هل تريد إنشاء نسخة احتياطية جديدة للمفتاح؟ سيساعدك هذا على استعادة الرسائل المشفرة على جهاز جديد.';

  @override
  String get settingsBackup => 'النسخ الاحتياطي';

  @override
  String get settingsRestoreKeyTitle => 'استعادة المفاتيح';

  @override
  String get settingsRestoreKeyMessage =>
      'أدخل كلمة مرور الاسترداد أو مفتاح الاسترداد لاستعادة الرسائل المشفرة.';

  @override
  String get settingsRestore => 'استعادة';

  @override
  String get settingsExportKeyTitle => 'مفاتيح التصدير';

  @override
  String get settingsExportKeyMessage =>
      'يحتوي ملف المفتاح الذي تم تصديره على جميع مفاتيح التشفير الخاصة بك. يرجى الحفاظ عليها آمنة.';

  @override
  String get settingsExport => 'تصدير';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'معرف الجهاز: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'الحالة: تم التحقق منها';

  @override
  String get settingsDeviceStatusUnverified => 'الحالة: لم يتم التحقق منها';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'آخر نشاط: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'التحقق من هذا الجهاز';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'تم تمكين التوقيع المتبادل بالفعل';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'تم إعداد التوقيع المتبادل بنجاح';

  @override
  String get settingsResetEncryptionTitle => 'إعادة تعيين التشفير';

  @override
  String get settingsResetEncryptionWarning =>
      'تحذير: سيؤدي هذا إلى حذف كافة مفاتيح التشفير الخاصة بك. لن تتمكن من فك تشفير الرسائل المشفرة السابقة. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get settingsReset => 'إعادة تعيين';

  @override
  String get settingsBackupSuccess => 'تم نسخ المفاتيح احتياطيًا بنجاح';

  @override
  String get settingsBackupFailed => 'فشل النسخ الاحتياطي';

  @override
  String get settingsRecoveryKey => 'مفتاح الاسترداد';

  @override
  String get settingsRecoveryKeySaveWarning =>
      'الرجاء حفظ مفتاح الاسترداد هذا في مكان آمن. ستحتاج إليه لاستعادة رسائلك المشفرة على جهاز جديد.';

  @override
  String get settingsRecoveryKeySaved => 'لقد أنقذته';

  @override
  String get settingsRestoreSuccess => 'تمت استعادة المفاتيح بنجاح';

  @override
  String get settingsRestoreEmpty =>
      'لم يتم العثور على مفاتيح رسائل في هذه النسخة الاحتياطية.';

  @override
  String settingsRestoreSessions(int count) {
    return 'تمت استعادة $count جلسات مفاتيح. قد تبقى الرسائل ذات المفاتيح المفقودة مشفرة.';
  }

  @override
  String get settingsRestoreFailed => 'فشلت عملية الاستعادة';

  @override
  String get settingsPassword => 'كلمة المرور';

  @override
  String get settingsEnterRecoveryKey => 'أدخل مفتاح الاسترداد';

  @override
  String get settingsEnterPassword => 'أدخل كلمة المرور';

  @override
  String get settingsExportSuccess =>
      'تم تصدير المفاتيح إلى النسخة الاحتياطية للخادم بنجاح';

  @override
  String get settingsExportNeedBackupFirst =>
      'الرجاء إنشاء نسخة احتياطية للمفتاح أولاً';

  @override
  String get settingsExportFailed => 'فشل التصدير';

  @override
  String get settingsResetSuccess => 'تمت إعادة تعيين التشفير بنجاح';

  @override
  String get settingsResetFailed => 'فشلت إعادة التعيين';

  @override
  String get callLeaveMeetingConfirm =>
      'هل أنت متأكد أنك تريد مغادرة الاجتماع؟';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'مطعون $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'لا توجد جهات اتصال متاحة لإضافتها';

  @override
  String get chatAddMembers => 'إضافة أعضاء';

  @override
  String chatInvitedMembers(int count) {
    return 'تمت دعوة أعضاء $count';
  }

  @override
  String chatInviteFailed(String error) {
    return 'فشلت الدعوة: $error';
  }

  @override
  String get chatMemberRemoved => 'تمت إزالة العضو';

  @override
  String chatRemoveFailed(String error) {
    return 'فشلت الإزالة: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'بعد المشاركة، يمكن للطرف الآخر رؤية موقعك في الوقت الفعلي لمدة ساعة واحدة.';

  @override
  String get chatStartSharing => 'ابدأ المشاركة';

  @override
  String get chatLocationServiceNotEnabled => 'خدمة الموقع غير ممكّنة';

  @override
  String get chatEnableLocationService =>
      'يرجى تمكين خدمة الموقع لاستخدام هذه الميزة';

  @override
  String get chatGoToSettings => 'انتقل إلى الإعدادات';

  @override
  String get chatLocationPermissionRequired => 'مطلوب إذن الموقع لهذه الميزة';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'تم رفض إذن الموقع بشكل دائم. يرجى تمكينه في الإعدادات.';

  @override
  String get chatLocationPermissionDenied => 'تم رفض إذن تحديد الموقع';

  @override
  String get chatGettingLocation => 'جارٍ الحصول على الموقع...';

  @override
  String chatGetLocationFailed(String error) {
    return 'فشل الحصول على الموقع: $error';
  }

  @override
  String get chatMapPreview => 'معاينة الخريطة';

  @override
  String get chatSearchLocation => 'موقع البحث';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'تم إرسال الحزمة الحمراء $amount $token';
  }

  @override
  String get chatTransferDefault => 'نقل';

  @override
  String chatTransferSent(String amount, String token) {
    return 'تم إرسال تحويل $amount $token';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'فشل في اختيار الملف: $error';
  }

  @override
  String get chatFileSizeLimit => 'لا يمكن أن يتجاوز حجم الملف 50 ميغابايت';

  @override
  String chatFileSending(String filename) {
    return 'إرسال الملف: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'فشل إرسال الملف: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'تم إرسال بطاقة جهة اتصال $name';
  }

  @override
  String get chatFavoritesFeature => 'المفضلة';

  @override
  String get chatCouponsFeature => 'كوبونات';

  @override
  String get chatGiftFeature => 'هدية';

  @override
  String chatSharedMusic(String name) {
    return 'تمت مشاركة ‏$name';
  }

  @override
  String get chatEndPollTitle => 'إنهاء الاستطلاع';

  @override
  String get chatEndPollConfirmMessage =>
      'هل أنت متأكد أنك تريد إنهاء هذا الاستطلاع؟ سيتم إغلاق التصويت بعد الإنتهاء.';

  @override
  String get chatPollEndedMessage => 'انتهى الاستطلاع';

  @override
  String get chatConnectingCall => 'جارٍ الاتصال...';

  @override
  String get chatMuteCall => 'كتم الصوت';

  @override
  String get chatSpeakerOff => 'مكبر الصوت معطل';

  @override
  String get chatSpeakerOn => 'المتحدث';

  @override
  String get chatCameraOn => 'تشغيل الكاميرا';

  @override
  String get chatCameraOff => 'الكاميرا معطلة';

  @override
  String get chatHangUp => 'شنق';

  @override
  String get chatSelectForwardTargetTitle => 'حدد الهدف الأمامي';

  @override
  String get chatNoForwardableChat => 'لا توجد محادثات متاحة لإعادة التوجيه';

  @override
  String get chatNoMatchingChat => 'لم يتم العثور على محادثات مطابقة';

  @override
  String get chatLocationTitle => 'الموقع';

  @override
  String get chatSendButton => 'أرسل';

  @override
  String get chatRetryButton => 'أعد المحاولة';

  @override
  String get chatSearchContactHint => 'البحث في جهات الاتصال';

  @override
  String get chatShareMusic => 'مشاركة الموسيقى';

  @override
  String get chatRecentPlayed => 'الأخيرة';

  @override
  String get chatMyFavorites => 'المفضلة';

  @override
  String get chatNetworkLink => 'رابط';

  @override
  String get chatLocalFile => 'محلي';

  @override
  String get chatPasteMusicLink => 'لصق رابط الموسيقى';

  @override
  String get chatShareMusicButton => 'مشاركة الموسيقى';

  @override
  String get chatSelectLocalAudio => 'حدد ملف الصوت المحلي';

  @override
  String get chatSupportedAudioFormats =>
      'يدعم ملفات MP3، M4A، WAV، FLAC، إلخ.';

  @override
  String get chatSelectFileButton => 'حدد ملف';

  @override
  String get chatPleaseEnterMusicLink => 'الرجاء إدخال رابط الموسيقى';

  @override
  String get chatPleaseEnterValidLink => 'الرجاء إدخال عنوان URL صالح';

  @override
  String get chatSharedSong => 'أغنية مشتركة';

  @override
  String get chatSelectMember => 'اختر عضوا';

  @override
  String get chatSearchMemberHint => 'أعضاء البحث';

  @override
  String get chatNoMatchingMembers => 'لم يتم العثور على أعضاء متطابقين';

  @override
  String get commonUnknownMember => 'غير معروف';

  @override
  String chatSelectedMessagesCount(int count) {
    return 'رسائل $count مختارة';
  }

  @override
  String get chatSearchContactsOrGroups => 'البحث في جهات الاتصال أو المجموعات';

  @override
  String get chatVideoTitle => 'فيديو';

  @override
  String get chatLoadingText => 'جار التحميل...';

  @override
  String get chatVideoLoadFailed => 'فشل تحميل الفيديو';

  @override
  String get chatPlayerInitFailed => 'فشلت تهيئة المشغل';

  @override
  String get chatCreatePollTitle => 'إنشاء استطلاع';

  @override
  String get chatSubmitPoll => 'إرسال';

  @override
  String get chatPollQuestionLabel => 'سؤال الاستطلاع';

  @override
  String get chatEnterPollQuestionHint => 'الرجاء إدخال سؤال الاستطلاع';

  @override
  String get chatPollOptionsLabel => 'خيارات الاستطلاع';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'الخيار $index';
  }

  @override
  String get chatAddOptionButton => 'إضافة خيار';

  @override
  String get chatPollSettingsLabel => 'إعدادات الاستطلاع';

  @override
  String get chatSelectionType => 'نوع الاختيار';

  @override
  String get chatSingleChoiceLabel => 'واحد';

  @override
  String get chatMultiChoiceLabel => 'متعدد';

  @override
  String get chatAnonymousPollSwitch => 'استطلاع مجهول';

  @override
  String get chatPleaseEnterQuestion => 'الرجاء إدخال سؤال الاستطلاع';

  @override
  String get chatAtLeastTwoOptions => 'مطلوب خيارين على الأقل';

  @override
  String chatConfirmWithCount(int count) {
    return 'تأكيد ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'التحقق من البريد الإلكتروني';

  @override
  String get authEnterValidEmailAddress =>
      'الرجاء إدخال عنوان بريد إلكتروني صالح';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'تم إرسال رمز التحقق إلى $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'فشل إرسال الرمز: $error';
  }

  @override
  String get authVerificationSuccess => 'تم التحقق بنجاح';

  @override
  String get authVerificationFailed => 'فشل التحقق';

  @override
  String authVerificationCodeError(String error) {
    return 'خطأ في رمز التحقق: $error';
  }

  @override
  String get commonEnterVerificationCode => 'أدخل رمز التحقق';

  @override
  String get authEnterYourEmail => 'أدخل البريد الإلكتروني';

  @override
  String authWeSentCodeTo(String email) {
    return 'لقد أرسلنا رمزًا مكونًا من 6 أرقام إلى\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'أدخل عنوان بريدك الإلكتروني، وسنرسل لك رمز التحقق';

  @override
  String get commonSendVerificationCode => 'إرسال رمز التحقق';

  @override
  String get authResendVerificationCode => 'إعادة إرسال رمز التحقق';

  @override
  String authCanResendAfter(int seconds) {
    return 'يمكن إعادة الإرسال بعد ثواني $seconds';
  }

  @override
  String get commonChangeEmail => 'تغيير البريد الإلكتروني';

  @override
  String get contactAddToContacts => 'إضافة إلى جهات الاتصال';

  @override
  String get contactAddingToContacts => 'جارٍ الإضافة...';

  @override
  String get contactAddedToContacts => 'تمت إضافتها إلى جهات الاتصال';

  @override
  String contactAddFailedWithError(String error) {
    return 'فشلت الإضافة: $error';
  }

  @override
  String get contactAddPhone => 'إضافة هاتف';

  @override
  String get contactAddTag => 'إضافة العلامات';

  @override
  String get contactAddText => 'أضف نصًا';

  @override
  String get contactAddPhoto => 'أضف صورة';

  @override
  String contactGroupCountLabel(int count) {
    return 'مجموعات $count';
  }

  @override
  String get contactAddedViaSearch => 'تمت إضافتها عبر البحث';

  @override
  String get contactAddTime => 'أضف الوقت';

  @override
  String get contactDoneButton => 'تم';

  @override
  String get callWaitingForParticipants => 'في انتظار انضمام المشاركين...';

  @override
  String callParticipantMe(String name) {
    return '$name (أنا)';
  }

  @override
  String get callSharingLabel => 'المشاركة';

  @override
  String callScreenSharingBy(String name) {
    return '$name يشارك الشاشة';
  }

  @override
  String callParticipantCount(int count) {
    return 'المشاركين $count';
  }

  @override
  String get callMuteLabel => 'كتم الصوت';

  @override
  String get callUnmuteLabel => 'إلغاء كتم الصوت';

  @override
  String get callTurnOffVideo => 'قم بإيقاف تشغيل الفيديو';

  @override
  String get callTurnOnVideo => 'قم بتشغيل الفيديو';

  @override
  String get callShareScreen => 'مشاركة الشاشة';

  @override
  String get callStopSharing => 'توقف عن المشاركة';

  @override
  String get callSwitchCameraLabel => 'التبديل';

  @override
  String get callLeaveLabel => 'غادر';

  @override
  String get callParticipantsLabel => 'المشاركون';

  @override
  String get callJoiningMeeting => 'الانضمام إلى الاجتماع...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return 'أصوات $count ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return 'المشاركين $count';
  }

  @override
  String get chatNoMediaUrlAvailable => 'لا يتوفر عنوان URL للوسائط';

  @override
  String chatDownloadFailed(String code) {
    return 'فشل التنزيل: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return 'خطأ: $message';
  }

  @override
  String get chatMusicLinkLabel => 'رابط الموسيقى';

  @override
  String get chatRedPacketTransferCannotForward =>
      'لا يمكن إعادة توجيه الحزم الحمراء وعمليات النقل';

  @override
  String commonShareFailed(String error) {
    return 'فشلت المشاركة: $error';
  }

  @override
  String get commonTapToRetry => 'انقر لإعادة المحاولة';

  @override
  String get chatDefaultRedPacketGreeting => 'أطيب التمنيات بالازدهار';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'السماح للآخرين بالبحث والانضمام';

  @override
  String get groupConfirmClearChatHistory =>
      'هل أنت متأكد أنك تريد مسح سجل الدردشة؟';

  @override
  String get groupCreateGroupToChat => 'قم بإنشاء مجموعة لبدء الدردشة';

  @override
  String get groupEditGroupAnnouncement => 'تحرير إعلان المجموعة';

  @override
  String get groupEditGroupDescription => 'تحرير وصف المجموعة';

  @override
  String get groupEnterGroupAnnouncement => 'أدخل إعلان المجموعة';

  @override
  String groupMemberCountClickToCopy(Object count) {
    return 'أعضاء $count، انقر لنسخ معرف المجموعة';
  }

  @override
  String get groupNoPermissionToEditGroupName =>
      'ليس لديك إذن لتعديل اسم المجموعة';

  @override
  String get authEmailAddress => 'عنوان البريد الإلكتروني';

  @override
  String get commonEnterEmailAddress => 'أدخل عنوان البريد الإلكتروني';

  @override
  String get authEmailRecoveryHint => 'تستخدم لاستعادة كلمة المرور';

  @override
  String get commonInvalidEmailFormat =>
      'الرجاء إدخال عنوان بريد إلكتروني صالح';

  @override
  String get authOptional => 'اختياري';

  @override
  String get authResetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get authEnterRegisteredEmail =>
      'أدخل عنوان البريد الإلكتروني الذي قمت بالتسجيل به';

  @override
  String get authSendResetCode => 'أرسل رمز إعادة الضبط';

  @override
  String authResetCodeSent(String email) {
    return 'تم إرسال رمز إعادة الضبط إلى $email';
  }

  @override
  String get authEnterResetCode => 'أدخل رمز إعادة الضبط';

  @override
  String get authSetNewPassword => 'تعيين كلمة مرور جديدة';

  @override
  String get commonConfirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get commonNewPassword => 'كلمة المرور الجديدة';

  @override
  String get authPasswordResetSuccess =>
      'تمت إعادة تعيين كلمة المرور بنجاح. الرجاء تسجيل الدخول باستخدام كلمة المرور الجديدة الخاصة بك.';

  @override
  String get authResetPasswordFailed => 'فشلت إعادة تعيين كلمة المرور';

  @override
  String get settingsChangePassword => 'تغيير كلمة المرور';

  @override
  String get settingsCurrentPassword => 'كلمة المرور الحالية';

  @override
  String get settingsEnterCurrentPassword => 'أدخل كلمة المرور الحالية';

  @override
  String get settingsEnterNewPassword => 'أدخل كلمة المرور الجديدة';

  @override
  String get settingsPasswordChanged =>
      'تم تغيير كلمة المرور بنجاح. الرجاء تسجيل الدخول باستخدام كلمة المرور الجديدة الخاصة بك.';

  @override
  String get settingsChangePasswordFailed => 'فشل تغيير كلمة المرور';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'كلمة المرور الجديدة يجب أن تكون مختلفة عن كلمة المرور الحالية';

  @override
  String get settingsChangePasswordInfo =>
      'بعد تغيير كلمة المرور، سيتم تسجيل خروجك وسيتعين عليك تسجيل الدخول باستخدام كلمة المرور الجديدة.';

  @override
  String get settingsPasswordRequirements => 'متطلبات كلمة المرور:';

  @override
  String get settingsSecurityNote =>
      'للأمان، ستحتاج إلى إعادة تسجيل الدخول على جميع الأجهزة بعد تغيير كلمة المرور.';

  @override
  String get settingsSecurity => 'الأمن';

  @override
  String get settingsCurrentBoundEmail => 'البريد الإلكتروني المنضم الحالي';

  @override
  String get settingsNewEmailAddress => 'عنوان البريد الإلكتروني الجديد';

  @override
  String get settingsEnterNewEmail => 'أدخل عنوان البريد الإلكتروني الجديد';

  @override
  String get settingsVerificationCode => 'رمز التحقق';

  @override
  String get settingsVerificationCodeSent => 'تم إرسال رمز التحقق';

  @override
  String get settingsCodeSentTo => 'تم إرسال رمز التحقق إلى';

  @override
  String get settingsDidNotReceiveCode => 'لم تتلق الرمز؟';

  @override
  String get settingsEmailChangedSuccess => 'تم تغيير البريد الإلكتروني بنجاح';

  @override
  String get settingsChangeEmailFailed => 'فشل تغيير البريد الإلكتروني';

  @override
  String get settingsEmailSecurityNote =>
      'يتم استخدام بريدك الإلكتروني لاستعادة كلمة المرور. يرجى الاحتفاظ بها آمنة.';

  @override
  String get commonGoogleLogin => 'قم بتسجيل الدخول باستخدام جوجل';

  @override
  String get commonAppleLogin => 'تسجيل الدخول مع أبل';

  @override
  String get commonWechat => 'وي شات';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageChanged => 'تغيرت اللغة';

  @override
  String get settingsTranslation => 'الترجمة';

  @override
  String get settingsTranslateTextTo => 'ترجمة النص إلى';

  @override
  String get settingsTranslateDescription =>
      'حدد اللغة التي تريد ترجمة الرسائل إليها.';

  @override
  String get settingsAutoTranslate => 'الترجمة التلقائية للرسائل المستلمة';

  @override
  String get settingsAutoTranslateDescription =>
      'ترجمة الرسائل المستلمة في الدردشة تلقائيًا إلى لغتك المحددة.';

  @override
  String get settingsBiometricLogin => 'تسجيل الدخول البيومتري';

  @override
  String authLoginWithBiometric(Object type) {
    return 'تسجيل الدخول باستخدام $type';
  }

  @override
  String get settingsBiometricLoginEnabled => 'تم تمكين تسجيل الدخول البيومتري';

  @override
  String get settingsBiometricLoginDisabled =>
      'تم تعطيل تسجيل الدخول البيومتري';

  @override
  String get settingsEnableBiometricLogin => 'تمكين تسجيل الدخول البيومتري';

  @override
  String get settingsBiometricEnabled =>
      'ممكّن - استخدم القياسات الحيوية لتسجيل الدخول';

  @override
  String get settingsBiometricDisabled => 'معطل - انقر للتمكين';

  @override
  String get settingsBiometricNeedRelogin =>
      'يرجى تسجيل الخروج وتسجيل الدخول مرة أخرى لتمكين تسجيل الدخول البيومتري';

  @override
  String get authOr => 'أو';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'الوصول إلى الكاميرا مقيد على هذا الجهاز';

  @override
  String get authPasskeyLabel => 'مفتاح المرور';

  @override
  String get authGoogleLabel => 'جوجل';

  @override
  String get authAppleLabel => 'أبل';

  @override
  String get authSsoLabel => 'الدخول الموحد';

  @override
  String get authSsoNotConfigured =>
      'لم يُعِدّ هذا الخادم أي مزوّد لتسجيل الدخول عبر SSO';

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
      'أدخل لاحقة الوخز، على سبيل المثال: على الكتف';

  @override
  String get groupAlbum => 'ألبوم المجموعة';

  @override
  String get groupFiles => 'ملفات المجموعة';

  @override
  String get groupImages => 'الصور';

  @override
  String get groupVideos => 'فيديوهات';

  @override
  String get groupTotal => 'المجموع';

  @override
  String get groupSize => 'الحجم';

  @override
  String get groupNoMedia => 'لا وسائل الإعلام';

  @override
  String get groupNoMediaDescription =>
      'لا توجد صور أو مقاطع فيديو في هذه المجموعة حتى الآن';

  @override
  String get groupDocuments => 'المستندات';

  @override
  String get groupNoFiles => 'لا توجد ملفات';

  @override
  String get groupNoFilesDescription =>
      'لا توجد ملفات في هذه المجموعة حتى الآن';

  @override
  String groupDownloadStarted(String filename) {
    return 'جارٍ التحميل $filename...';
  }

  @override
  String get contactNoCommonGroups => 'لا توجد مجموعات مشتركة';

  @override
  String get contactNoCommonGroupsDescription => 'ليس لديك أي مجموعات مشتركة';

  @override
  String get chatVoiceMessage => 'صوت';

  @override
  String get chatMessage => 'رسالة';

  @override
  String get conversationHideChat => 'إخفاء';

  @override
  String get settingsQuickReply => 'الرد السريع';

  @override
  String get commonTranslate => 'ترجمة';

  @override
  String get contactCreateTag => 'إنشاء علامة';

  @override
  String get contactEnterTagName => 'أدخل اسم العلامة';

  @override
  String get contactEditTag => 'تحرير العلامة';

  @override
  String get contactDeleteTag => 'حذف العلامة';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'هل أنت متأكد أنك تريد حذف العلامة \"$tagName\"؟';
  }

  @override
  String get contactNoTags => 'لا توجد علامات حتى الآن';

  @override
  String get contactFriendPermissions => 'أذونات الصديق';

  @override
  String get contactSetChatOnly => 'تعيين كدردشة فقط';

  @override
  String get contactChatOnlyDesc =>
      'يمكن الدردشة معك فقط، وسيتم إخفاء المحتوى الآخر';

  @override
  String get contactHideMyMoments => 'إخفاء لحظاتي';

  @override
  String get contactHideMyMomentsDesc => 'هذا الصديق لا يمكنه رؤية لحظاتي';

  @override
  String get contactHideTheirMoments => 'إخفاء لحظاتهم';

  @override
  String get contactHideTheirMomentsDesc => 'لا ترى لحظات هذا الصديق';

  @override
  String get contactHideMyStatus => 'إخفاء حالتي';

  @override
  String get contactHideMyStatusDesc =>
      'لا يستطيع هذا الصديق رؤية تحديثات حالتي';

  @override
  String get contactNoChatOnlyFriends => 'لا يوجد أصدقاء للدردشة فقط';

  @override
  String get contactNoOfficialAccounts => 'لا حسابات رسمية';

  @override
  String get contactFollowOfficialAccountsDesc =>
      'اتبع الحسابات الرسمية للحصول على آخر التحديثات';

  @override
  String get contactNoServiceAccounts => 'لا توجد حسابات الخدمة';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      'اشترك في حسابات الخدمة للحصول على خدمات مريحة';

  @override
  String get contactNoEnterpriseContacts => 'لا توجد اتصالات المؤسسة';

  @override
  String get contactEnterpriseContactsDesc => 'سيتم عرض جهات اتصال المؤسسة هنا';

  @override
  String get profileCardPack => 'حزمة البطاقة';

  @override
  String get profileOrders => 'أوامر';

  @override
  String get profileNoOrders => 'لا أوامر';

  @override
  String get profileOrdersDesc => 'سيتم عرض طلباتك هنا';

  @override
  String get profileNoCards => 'لا بطاقات';

  @override
  String get profileCardsDesc => 'سيتم عرض البطاقات الخاصة بك هنا';

  @override
  String get favoriteEnterTagsHint => 'أدخل العلامات مفصولة بفواصل';

  @override
  String get favoriteTagsUpdated => 'تم تحديث العلامات';

  @override
  String get favoriteForwardedContent => 'تم إعادة توجيه المحتوى';

  @override
  String get favoriteEnterNoteContent => 'أدخل محتوى الملاحظة';

  @override
  String get favoriteNoteAdded => 'تمت إضافة الملاحظة';

  @override
  String get favoriteLinkTitle => 'عنوان الرابط';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'تمت إضافة الرابط';

  @override
  String get contactPhotoAdded => 'تمت إضافة الصورة';

  @override
  String get contactEnterPhone => 'أدخل رقم الهاتف';

  @override
  String commonConversationWithId(Object roomId) {
    return 'المحادثة: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return 'جهة الاتصال: $userId';
  }

  @override
  String get commonDiscover => 'اكتشف';

  @override
  String commonDeveloping(Object title) {
    return '$title\n(قريبا)';
  }

  @override
  String get commonPageNotFound => 'لم يتم العثور على الصفحة';

  @override
  String get commonBackToHome => 'العودة إلى المنزل';

  @override
  String get settingsMessageNotifications => 'إشعارات الرسائل';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'تلقي إشعارات الرسائل الجديدة';

  @override
  String get settingsShowMessagePreview => 'إظهار معاينة الرسالة';

  @override
  String get settingsShowMessageContentInNotification =>
      'إظهار محتوى الرسالة في الإخطار';

  @override
  String get settingsNotificationSound => 'صوت الإخطار';

  @override
  String get settingsPlaySoundOnMessage => 'تشغيل الصوت عند تلقي الرسائل';

  @override
  String get commonVibration => 'الاهتزاز';

  @override
  String get settingsVibrateOnMessage => 'يهتز عند تلقي الرسائل';

  @override
  String get settingsDoNotDisturbMode => 'لا تزعج';

  @override
  String get settingsDoNotDisturbDescription =>
      'لا تتلقى الإخطارات خلال الوقت المحدد';

  @override
  String get settingsStartTime => 'وقت البدء';

  @override
  String get settingsEndTime => 'وقت النهاية';

  @override
  String get settingsDeleteQuickReply => 'حذف الرد السريع';

  @override
  String get settingsEditQuickReply => 'تحرير الرد السريع';

  @override
  String get settingsAddQuickReply => 'إضافة الرد السريع';

  @override
  String get settingsManageQuickReplies => 'إدارة الردود السريعة';

  @override
  String get settingsNoQuickReplies => 'لا ردود سريعة';

  @override
  String get settingsDefaultQuickReplies =>
      'سيتم عرض الردود السريعة الافتراضية';

  @override
  String get settingsWhoCanSee => 'من يستطيع أن يرى';

  @override
  String get settingsLastSeen => 'شوهد آخر مرة';

  @override
  String get settingsHiddenChats => 'الدردشات المخفية';

  @override
  String get settingsMessagesLabel => 'الرسائل';

  @override
  String get settingsAllowStrangerMessages => 'السماح برسائل الغرباء';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'تلقي رسائل من غير جهات الاتصال';

  @override
  String get settingsReadReceipts => 'قراءة الإيصالات';

  @override
  String get settingsLetOthersKnowYouRead => 'دع الآخرين يعرفون أنك تقرأ';

  @override
  String get settingsTypingIndicator => 'مؤشر الكتابة';

  @override
  String get settingsLetOthersKnowYouTyping => 'دع الآخرين يعرفون أنك تكتب';

  @override
  String get settingsEveryone => 'الجميع';

  @override
  String get settingsContactsOnly => 'جهات الاتصال فقط';

  @override
  String get settingsNobody => 'لا أحد';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'من يستطيع رؤية $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'الإصدار $version';
  }

  @override
  String get settingsCheckForUpdates => 'التحقق من وجود تحديثات';

  @override
  String get settingsOpenSourceLicenses => 'تراخيص مفتوحة المصدر';

  @override
  String get settingsFeedbackAndSuggestions => 'ردود الفعل والاقتراحات';

  @override
  String get settingsBuiltOnMatrix => 'مبني على بروتوكول المصفوفة';

  @override
  String get settingsNoHiddenChats => 'لا توجد محادثات مخفية';

  @override
  String get settingsNoHiddenChatsDescription =>
      'ستظهر هنا الدردشات التي تخفيها';

  @override
  String get settingsUnhideChat => 'إظهار';

  @override
  String get settingsDarkMode => 'الوضع المظلم';

  @override
  String get settingsFontSize => 'حجم الخط';

  @override
  String get settingsBubbleStyle => 'نمط الفقاعة';

  @override
  String get settingsFollowSystem => 'اتبع النظام';

  @override
  String get settingsAutoSwitchBySystem => 'التبديل التلقائي عن طريق النظام';

  @override
  String get settingsLightMode => 'وضع الضوء';

  @override
  String get settingsAlwaysUseLightTheme => 'استخدم دائمًا المظهر الفاتح';

  @override
  String get settingsDarkModeOption => 'خيار الوضع المظلم';

  @override
  String get settingsAlwaysUseDarkTheme => 'استخدم المظهر الداكن دائمًا';

  @override
  String get settingsFontSizeSmall => 'صغير';

  @override
  String get settingsFontSizeStandard => 'قياسي';

  @override
  String get settingsFontSizeLarge => 'كبير';

  @override
  String get settingsFontSizeExtraLarge => 'كبيرة جدًا';

  @override
  String get settingsBubbleStyleWechat => 'أسلوب ويتشات';

  @override
  String get settingsBubbleStyleWechatDesc => 'نمط فقاعة WeChat الكلاسيكي';

  @override
  String get settingsBubbleStyleModern => 'الطراز الحديث';

  @override
  String get settingsBubbleStyleModernDesc => 'نمط الفقاعة الحديث النظيف';

  @override
  String get settingsBubbleStyleClassic => 'النمط الكلاسيكي';

  @override
  String get settingsBubbleStyleClassicDesc => 'نمط الفقاعة التقليدي';

  @override
  String get discoverVideoChannels => 'القنوات';

  @override
  String get discoverLive => 'مباشر';

  @override
  String get discoverListen => 'استمع';

  @override
  String get discoverWatch => 'شاهد';

  @override
  String get discoverSearchDiscover => 'بحث';

  @override
  String get discoverNearbyPeople => 'قريب';

  @override
  String get discoverGames => 'العاب';

  @override
  String get discoverMiniPrograms => 'البرامج المصغرة';

  @override
  String get chatAlreadyInCall => 'في مكالمة بالفعل';

  @override
  String get commonConnectionFailed => 'فشل الاتصال';

  @override
  String get chatCallRejected => 'تم رفض المكالمة';

  @override
  String get chatNoAnswer => 'لا إجابة';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get chatSelectContact => 'حدد جهة الاتصال';

  @override
  String get chatVoteRemoved => 'تمت إزالة التصويت';

  @override
  String get chatVoteChanged => 'تم تغيير التصويت';

  @override
  String get chatVoted => 'تم التصويت';

  @override
  String chatReplyTo(String name) {
    return 'الرد على $name';
  }

  @override
  String get chatCurrentLocation => 'الموقع الحالي';

  @override
  String chatNearbyPlace(int index) {
    return 'مكان قريب $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'حول $distance';
  }

  @override
  String get chatAddress => 'العنوان';

  @override
  String get chatLatitude => 'خط العرض';

  @override
  String get chatLongitude => 'خط الطول';

  @override
  String get groupDescriptionUpdated => 'تم تحديث وصف المجموعة';

  @override
  String get groupAvatarUpdated => 'تم تحديث الصورة الرمزية للمجموعة';

  @override
  String get groupVisibilityUpdated => 'تم تحديث رؤية المجموعة';

  @override
  String get groupChannelCreated => 'تم إنشاء القناة';

  @override
  String get groupChannelUpdated => 'تم تحديث القناة';

  @override
  String get groupChannelDeleted => 'تم حذف القناة';

  @override
  String get callDecline => 'رفض';

  @override
  String get callAnswer => 'الإجابة';

  @override
  String get callIncomingVideoCall => 'مكالمة فيديو واردة';

  @override
  String get callIncomingVoiceCall => 'مكالمة صوتية واردة';

  @override
  String get callVideoCallInProgress => 'مكالمة الفيديو قيد التقدم';

  @override
  String get callVoiceCallInProgress => 'المكالمة الصوتية جارية';

  @override
  String get callReconnectingCall => 'جارٍ إعادة الاتصال...';

  @override
  String get callEnded => 'انتهت المكالمة';

  @override
  String get callFailed => 'فشل الاتصال';

  @override
  String get callLivekitNotConfigured => 'لم يتم تكوين LiveKit';

  @override
  String callJoinMeetingFailed(Object error) {
    return 'فشل الانضمام إلى الاجتماع: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return 'فشلت مشاركة الشاشة: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 فول';

  @override
  String get profileNoN42Bean => 'لا يوجد فول N42';

  @override
  String get profileN42BeanDetails => 'تفاصيل الفول N42';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean هو رمز مميز يستخدم لاسترداد العناصر والخدمات الافتراضية في N42. متاح حاليا ل:';

  @override
  String get profileN42BeanFeature1 => 'ملصقات وموضوعات الأعضاء الحصرية';

  @override
  String get profileN42BeanFeature2 => 'تخصيص فقاعة الدردشة';

  @override
  String get profileN42BeanFeature3 => 'تخصيص غطاء الحزمة الحمراء';

  @override
  String get profileN42BeanFeature4 => 'شارة اللقب الحصرية';

  @override
  String get profileN42BeanFeature5 => 'امتيازات الدردشة الجماعية';

  @override
  String get profileN42BeanFeature6 => 'توسيع التخزين السحابي';

  @override
  String get profileN42BeanFeature7 => 'مرشحات الجمال لمكالمات الفيديو';

  @override
  String get profileN42BeanFeature8 => 'لحظات تخصيص الخلفية';

  @override
  String get profileN42BeanFeature9 => 'أولوية خدمة العملاء لكبار الشخصيات';

  @override
  String get profileGotIt => 'حصلت عليه';

  @override
  String get profileNoN42BeanRecords => 'لا توجد سجلات N42 Bean';

  @override
  String get profileMoodAndThoughts => 'المزاج والأفكار';

  @override
  String get profileStatusHappy => 'سعيد';

  @override
  String get profileStatusCracked => 'تحطمت';

  @override
  String get profileStatusLucky => 'محظوظ';

  @override
  String get profileStatusSunny => 'مشمس';

  @override
  String get profileStatusTired => 'متعب';

  @override
  String get profileStatusDaydream => 'أحلام اليقظة';

  @override
  String get profileStatusRushing => 'التسرع';

  @override
  String get profileStatusOverthinking => 'الإفراط في التفكير';

  @override
  String get profileStatusEnergized => 'تنشيط';

  @override
  String get profileWorkAndStudy => 'العمل والدراسة';

  @override
  String get profileStatusWorking => 'العمل';

  @override
  String get profileStatusStudying => 'دراسة';

  @override
  String get profileStatusBusy => 'مشغول';

  @override
  String get profileStatusSlacking => 'التراخي';

  @override
  String get profileStatusTraveling => 'السفر';

  @override
  String get profileStatusGoingHome => 'الذهاب إلى المنزل';

  @override
  String get profileStatusDnd => 'لا تزعج';

  @override
  String get profileActivities => 'الأنشطة';

  @override
  String get profileStatusHanging => 'التسكع';

  @override
  String get profileStatusCheckIn => 'تسجيل الوصول';

  @override
  String get profileStatusExercising => 'ممارسة الرياضة';

  @override
  String get profileStatusCoffee => 'قهوة';

  @override
  String get profileStatusBubbleTea => 'شاي الفقاعات';

  @override
  String get profileStatusEating => 'الأكل';

  @override
  String get profileStatusParenting => 'الأبوة والأمومة';

  @override
  String get profileStatusSavingWorld => 'إنقاذ العالم';

  @override
  String get profileStatusSelfie => 'صورة شخصية';

  @override
  String get profileRest => 'الراحة';

  @override
  String get profileStatusRetreat => 'تراجع';

  @override
  String get profileStatusHome => 'الصفحة الرئيسية';

  @override
  String get profileStatusSleeping => 'النوم';

  @override
  String get profileStatusCatLover => 'عاشق القطط';

  @override
  String get profileStatusDogWalking => 'كلب يمشي';

  @override
  String get profileStatusGaming => 'الألعاب';

  @override
  String get profileStatusListening => 'الاستماع';

  @override
  String get profileEditAddress => 'تحرير العنوان';

  @override
  String get profileRecipient => 'المستلم';

  @override
  String get profileEnterRecipientName => 'أدخل اسم المستلم';

  @override
  String get profilePhoneNumber => 'رقم الهاتف';

  @override
  String get profileEnterPhoneNumber => 'أدخل رقم الهاتف';

  @override
  String get profileRegionHint => 'المقاطعة / المدينة / المنطقة';

  @override
  String get profileDetailedAddress => 'العنوان التفصيلي';

  @override
  String get profileDetailedAddressHint => 'الشارع ورقم المبنى وما إلى ذلك.';

  @override
  String get profileSetAsDefaultAddress => 'تعيين كعنوان افتراضي';

  @override
  String get profilePleaseCompleteInfo => 'الرجاء إكمال كافة الحقول';

  @override
  String get profileEditInvoice => 'تحرير الفاتورة';

  @override
  String get profileInvoiceType => 'نوع الفاتورة';

  @override
  String get profileCompanyName => 'اسم الشركة';

  @override
  String get profilePersonalName => 'الاسم الشخصي';

  @override
  String get profileEnterCompanyName => 'أدخل اسم الشركة';

  @override
  String get profileEnterName => 'أدخل الاسم';

  @override
  String get profileTaxIdNumber => 'رقم التعريف الضريبي';

  @override
  String get profileEnterTaxIdNumber => 'أدخل رقم الهوية الضريبية';

  @override
  String get profileBankNameOptional => 'اسم البنك (اختياري)';

  @override
  String get profileEnterBankName => 'أدخل اسم البنك';

  @override
  String get profileBankAccountOptional => 'الحساب البنكي (اختياري)';

  @override
  String get profileEnterBankAccount => 'أدخل الحساب البنكي';

  @override
  String get profileCompanyAddressOptional => 'عنوان الشركة (اختياري)';

  @override
  String get profileEnterCompanyAddress => 'أدخل عنوان الشركة';

  @override
  String get profileCompanyPhoneOptional => 'هاتف الشركة (اختياري)';

  @override
  String get profileEnterCompanyPhone => 'أدخل هاتف الشركة';

  @override
  String get profileSetAsDefaultInvoice => 'تعيين كفاتورة افتراضية';

  @override
  String get profileRingtoneVibrate => 'يهتز';

  @override
  String get profileRingtoneSilent => 'صامت';

  @override
  String get profileVibrateMode => 'وضع الاهتزاز';

  @override
  String get profileSilentMode => 'الوضع الصامت';

  @override
  String profilePlayFailed(Object ringtoneName) {
    return 'فشل اللعب: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
    return 'التشغيل: $ringtoneName';
  }

  @override
  String get profileStop => 'توقف';

  @override
  String get profileSelectRingtone => 'حدد نغمة الرنين';

  @override
  String get profileLoadingRingtones => 'جارٍ تحميل نغمات الرنين...';

  @override
  String get profileNoRingtonesFound => 'لم يتم العثور على نغمات رنين';

  @override
  String mainMessagesWithCount(int count) {
    return 'الرسائل($count)';
  }

  @override
  String get storyViewers => 'المشاهدين';

  @override
  String get storyNoViewers => 'لا يوجد مشاهدين حتى الآن';

  @override
  String get storyReplyToStory => 'الرد على القصة...';

  @override
  String get commonCopiedToClipboard => 'تم النسخ إلى الحافظة';

  @override
  String get commonMore => 'المزيد';

  @override
  String get commonTranslating => 'ترجمة...';

  @override
  String commonTranslatedFrom(String language) {
    return 'مترجم من $language';
  }

  @override
  String get commonTranslation => 'الترجمة';

  @override
  String get commonTranslationFailed => 'فشلت الترجمة';

  @override
  String get commonAllRead => 'كل قراءة';

  @override
  String commonReadCount(Object count) {
    return 'قراءة $count';
  }

  @override
  String get commonYouRecalledMessage => 'لقد تذكرت رسالة';

  @override
  String get commonMessageRecalled => 'تم تذكر الرسالة';

  @override
  String get commonReEdit => 'إعادة التحرير';

  @override
  String get commonWalletArea => 'منطقة المحفظة';

  @override
  String get callIncomingCall => 'مكالمة واردة';

  @override
  String get callMissedCall => 'مكالمة فائتة';

  @override
  String get groupRemoveAdmin => 'إزالة المشرف';

  @override
  String get chatSelectCurrency => 'اختر العملة';

  @override
  String get chatSelectEmoji => 'حدد الرموز التعبيرية';

  @override
  String get chatSelectRedPacketCover => 'حدد الغلاف';

  @override
  String get groupSetAsAdmin => 'تعيين كمسؤول';

  @override
  String get chatVideoPlaybackFailed => 'فشل تشغيل الفيديو';

  @override
  String get groupViewProfile => 'عرض الملف الشخصي';

  @override
  String get favoriteAddLinkComingSoon => 'إضافة ميزة الارتباط قريبا';

  @override
  String get favoriteNewNoteComingSoon => 'ميزة مذكرة جديدة قريبا';

  @override
  String get qrcodeSaveFeatureComingSoon => 'ميزة الحفظ قريبا';

  @override
  String get qrcodeShareFeatureComingSoon => 'ميزة المشاركة قريبا';

  @override
  String qrcodeProcessFailed(String error) {
    return 'فشلت معالجة رمز الاستجابة السريعة: $error';
  }

  @override
  String get securityDeviceIdRequired => 'معرف الجهاز مطلوب';

  @override
  String securityVerificationStartFailed(String error) {
    return 'فشل بدء التحقق: $error';
  }

  @override
  String get securityVerificationFailed => 'فشل التحقق';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return 'فشل التحقق: $reason';
  }

  @override
  String get securityEmojiMismatchRejected =>
      'تم رفض التحقق - الرموز التعبيرية غير متطابقة';

  @override
  String get securityWaitingForDeviceAccept => 'في انتظار قبول الجهاز الآخر...';

  @override
  String get securityVerifyDevice => 'التحقق من هذا الجهاز';

  @override
  String get securityConfirmEmojiMatch =>
      'تأكد من عرض الرموز التعبيرية أدناه على كلا الجهازين بنفس الترتيب';

  @override
  String get securityEmojiDontMatch => 'أنها لا تتطابق';

  @override
  String get securityEmojiMatch => 'إنهم متطابقون';

  @override
  String get securityWaitingForDeviceConfirm =>
      'في انتظار تأكيد الجهاز الآخر...';

  @override
  String get securityVerificationSuccess => 'تم التحقق بنجاح!';

  @override
  String get securityDeviceVerifiedTrusted =>
      'تم الآن التحقق من هذا الجهاز وموثوق به.';

  @override
  String get securityCompareEmoji => 'قارن الرموز التعبيرية على كلا الجهازين';

  @override
  String get securityCompareNumbers => 'قارن الأرقام على كلا الجهازين';

  @override
  String get commonTryAgain => 'حاول مرة أخرى';

  @override
  String get commonDone => 'تم';

  @override
  String get chatExportTitle => 'تصدير الدردشة';

  @override
  String get chatExportSuccess => 'تم التصدير بنجاح';

  @override
  String chatExportFailed(String error) {
    return 'فشل التصدير: $error';
  }

  @override
  String get chatExportFormat => 'تنسيق التصدير';

  @override
  String get chatExportHtmlDesc => 'يمكن قراءتها في أي متصفح بتصميم أنيق';

  @override
  String get chatExportJsonDesc => 'تنسيق بيانات منظمة يمكن قراءته آليًا';

  @override
  String get chatExportDateRange => 'النطاق الزمني';

  @override
  String get chatExportAll => 'جميع الرسائل';

  @override
  String get chatExportLastWeek => 'آخر 7 أيام';

  @override
  String get chatExportLastMonth => 'الشهر الماضي';

  @override
  String get chatExportLast3Months => 'آخر 3 أشهر';

  @override
  String get chatExportMessageCount => 'رسائل للتصدير';

  @override
  String get chatExportButton => 'تصدير ومشاركة';

  @override
  String get chatMediaGallery => 'معرض الوسائط';

  @override
  String get chatExportHistory => 'تصدير سجل الدردشة';

  @override
  String get pdfLoadFailed => 'فشل تحميل PDF';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => 'الكل';

  @override
  String get mediaImages => 'الصور';

  @override
  String get mediaVideos => 'فيديوهات';

  @override
  String get mediaFiles => 'ملفات';

  @override
  String get mediaAudio => 'الصوت';

  @override
  String mediaItemsCount(int count) {
    return 'عناصر $count';
  }

  @override
  String get mediaNoMediaFound => 'لم يتم العثور على أي وسائط';

  @override
  String get spacesTitle => 'المجتمعات';

  @override
  String get spacesCreate => 'إنشاء مجتمع';

  @override
  String get spacesJoined => 'انضم';

  @override
  String get spacesDiscover => 'اكتشف';

  @override
  String get spacesNoJoined => 'لم تنضم أي مجتمعات حتى الآن';

  @override
  String get spacesExplore => 'اكتشف المجتمعات';

  @override
  String get spacesNoPublic => 'لم يتم العثور على مجتمعات عامة';

  @override
  String get spacesJoin => 'انضم';

  @override
  String get spacesSubSpaces => 'المجتمعات الفرعية';

  @override
  String get spacesChannels => 'القنوات';

  @override
  String spacesMembersCount(int count) {
    return 'أعضاء $count';
  }

  @override
  String get spacesPublic => 'عام';

  @override
  String get spacesPrivate => 'خاص';

  @override
  String get spacesSuggested => 'مقترح';

  @override
  String spacesChannelsCount(int count) {
    return 'قنوات $count';
  }

  @override
  String get callInCallChat => 'الدردشة أثناء المكالمة';

  @override
  String callMessagesCount(int count) {
    return 'رسائل $count';
  }

  @override
  String get callNoMessagesYet => 'لا توجد رسائل حتى الآن.\nأرسل رسالة للبدء.';

  @override
  String get callTypeMessage => 'اكتب رسالة...';

  @override
  String get callYouSender => 'أنت';

  @override
  String get callChatLabel => 'الدردشة';

  @override
  String get chatEdited => 'تم تحريره';

  @override
  String get chatEditHistory => 'تحرير التاريخ';

  @override
  String get chatOriginalMessage => 'أصلي';

  @override
  String chatEditedAt(String time) {
    return 'تم التعديل في $time';
  }

  @override
  String get chatViewOnce => 'عرض مرة واحدة';

  @override
  String get chatViewOncePhoto => 'عرض الصورة مرة واحدة';

  @override
  String get chatViewOnceVideo => 'شاهد الفيديو مرة واحدة';

  @override
  String get chatViewOnceViewed => 'تم المشاهدة';

  @override
  String get chatViewOnceExpired => 'انتهت صلاحيتها';

  @override
  String get chatViewOnceTap => 'انقر للعرض';

  @override
  String get chatAutoFaceBlur => 'طمس الوجه التلقائي';

  @override
  String get chatAutoFaceBlurDesc => 'طمس الوجوه تلقائيًا عند إرسال الصور';

  @override
  String get threadReplyInThread => 'الرد في الموضوع';

  @override
  String threadReplies(int count) {
    return 'ردود $count';
  }

  @override
  String get threadReply => '1 رد';

  @override
  String threadLatestReply(String preview) {
    return 'الأحدث: $preview';
  }

  @override
  String get threadTitle => 'الموضوع';

  @override
  String get threadReplyPlaceholder => 'الرد في الموضوع...';

  @override
  String threadParticipants(int count) {
    return 'المشاركين $count';
  }

  @override
  String get voiceRoomTitle => 'غرفة الصوت';

  @override
  String get voiceRoomCreate => 'إنشاء غرفة صوتية';

  @override
  String get voiceRoomJoin => 'انضم';

  @override
  String get voiceRoomLeave => 'غادر';

  @override
  String get voiceRoomEnd => 'غرفة النهاية';

  @override
  String get voiceRoomRaiseHand => 'ارفع اليد';

  @override
  String get voiceRoomLowerHand => 'اليد السفلى';

  @override
  String get voiceRoomMute => 'كتم الصوت';

  @override
  String get voiceRoomUnmute => 'إلغاء كتم الصوت';

  @override
  String get voiceRoomHost => 'المضيف';

  @override
  String get voiceRoomSpeakers => 'مكبرات الصوت';

  @override
  String get voiceRoomListeners => 'المستمعون';

  @override
  String get voiceRoomLive => 'مباشر';

  @override
  String get voiceRoomEnded => 'انتهى';

  @override
  String get voiceRoomScheduled => 'المقرر';

  @override
  String get voiceRoomApprove => 'موافقة';

  @override
  String get voiceRoomDemote => 'انتقل إلى المستمع';

  @override
  String voiceRoomHandRaised(String name) {
    return 'رفع $name أيديهم';
  }

  @override
  String get voiceRoomName => 'اسم الغرفة';

  @override
  String get voiceRoomTopic => 'الموضوع (اختياري)';

  @override
  String get voiceRoomNoActive => 'لا توجد غرف صوتية نشطة';

  @override
  String get voiceRoomConnecting => 'جارٍ الاتصال...';

  @override
  String get usernameTitle => 'اسم المستخدم';

  @override
  String get usernameSet => 'تعيين اسم المستخدم';

  @override
  String get usernameChange => 'تغيير اسم المستخدم';

  @override
  String get usernamePlaceholder => 'أدخل اسم المستخدم';

  @override
  String get usernameAvailable => 'اسم المستخدم متاح';

  @override
  String get usernameUnavailable => 'اسم المستخدم مأخوذ بالفعل';

  @override
  String get usernameInvalid =>
      '3-30 حرفًا، أحرف صغيرة، أرقام، شرطة سفلية. يجب أن تبدأ بحرف.';

  @override
  String get usernameReserved => 'اسم المستخدم هذا محجوز';

  @override
  String get usernameSaved => 'تم حفظ اسم المستخدم';

  @override
  String get usernameSearchHint => 'البحث عن طريق @اسم المستخدم';

  @override
  String get ensName => 'اسم إنس';

  @override
  String get ensLinked => 'مرتبط بـ ENS';

  @override
  String get ensResolving => 'حل مشكلة ENS...';

  @override
  String get ensNotFound => 'لم يتم العثور على اسم ENS';

  @override
  String get tokenGateTitle => 'بوابة الرمز';

  @override
  String get tokenGateEnable => 'تمكين بوابة الرمز المميز';

  @override
  String get tokenGateDisable => 'تعطيل بوابة الرمز المميز';

  @override
  String get tokenGateAddRule => 'أضف القاعدة';

  @override
  String get tokenGateRemoveRule => 'إزالة القاعدة';

  @override
  String get tokenGateContractAddress => 'عنوان العقد';

  @override
  String get tokenGateMinBalance => 'الحد الأدنى للرصيد';

  @override
  String get tokenGateTokenId => 'معرف الرمز المميز (ERC-1155)';

  @override
  String get tokenGateChainId => 'معرف السلسلة';

  @override
  String get tokenGateVerifying => 'التحقق من ملكية الرموز المميزة...';

  @override
  String get tokenGateVerified => 'تم التحقق';

  @override
  String get tokenGateDenied => 'أنت لا تستوفي متطلبات الرمز المميز';

  @override
  String get tokenGateOperatorAnd => 'يجب أن تستوفي جميع القواعد';

  @override
  String get tokenGateOperatorOr => 'يجب أن تستوفي أي قاعدة';

  @override
  String get tokenGateRuleErc20 => 'رمز ERC-20';

  @override
  String get tokenGateRuleErc721 => 'ان اف تي (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => 'الرموز المتعددة (ERC-1155)';

  @override
  String get tokenGateRuleNative => 'الرمز الأصلي';

  @override
  String get tokenGateSaved => 'تم حفظ بوابة الرمز المميز';

  @override
  String get tokenGateEnableDescription =>
      'مطالبة الأعضاء بحمل الرموز المميزة للانضمام';

  @override
  String get tokenGateOperator => 'منطق القاعدة';

  @override
  String get tokenGateRules => 'القواعد';

  @override
  String get tokenGateSymbol => 'الرمز (اختياري)';

  @override
  String get tokenGateChain => 'سلسلة';

  @override
  String get tokenGateTokenStandard => 'معيار الرمز المميز';

  @override
  String get tokenGateDenialMessage => 'رسالة الرفض';

  @override
  String get tokenGateDenialMessageHint => 'تظهر الرسالة عند فشل التحقق';

  @override
  String get tokenGateVerifyTitle => 'التحقق من الرمز المميز';

  @override
  String get tokenGateVerifyPassed => 'تم التحقق';

  @override
  String get tokenGateVerifyFailed => 'فشل التحقق';

  @override
  String get tokenGateRetryVerify => 'أعد المحاولة';

  @override
  String get tokenGateRequired => 'مطلوب';

  @override
  String get tokenGateYourBalance => 'رصيدك';

  @override
  String get tokenGateRulesActive => 'القواعد نشطة';

  @override
  String get tokenGateDisabled => 'معطل';

  @override
  String get ensNotBound => 'غير ملزمة';

  @override
  String get liveLocation => 'الموقع المباشر';

  @override
  String get stopLiveLocation => 'توقف عن المشاركة';

  @override
  String get startLiveLocation => 'ابدأ المشاركة';

  @override
  String get selectDuration => 'حدد المدة';

  @override
  String get groupChatFiles => 'ملفات الدردشة';

  @override
  String get groupLinks => 'روابط';

  @override
  String get groupNoLinks => 'لا توجد روابط حتى الآن';

  @override
  String get chatBackground => 'خلفية الدردشة';

  @override
  String get solidColors => 'الألوان الصلبة';

  @override
  String get gradients => 'التدرجات';

  @override
  String get defaultBackground => 'الافتراضي';

  @override
  String get settingsFontSizeSlider => 'حجم الخط';

  @override
  String get autoDownload => 'التنزيل التلقائي';

  @override
  String get images => 'الصور';

  @override
  String get voice => 'صوت';

  @override
  String get video => 'فيديو';

  @override
  String get files => 'ملفات';

  @override
  String get mobileData => 'بيانات الجوال';

  @override
  String get roaming => 'التجوال';

  @override
  String get storageManagement => 'التخزين';

  @override
  String get totalUsage => 'الاستخدام الإجمالي';

  @override
  String get cache => 'ذاكرة التخزين المؤقت';

  @override
  String get other => 'أخرى';

  @override
  String get clearCache => 'مسح ذاكرة التخزين المؤقت';

  @override
  String get cacheCleared => 'تم مسح ذاكرة التخزين المؤقت';

  @override
  String get clearCacheFailed => 'فشل في مسح ذاكرة التخزين المؤقت';

  @override
  String get confirmClearCache =>
      'هل تريد مسح جميع بيانات ذاكرة التخزين المؤقت؟';

  @override
  String get mapView => 'عرض الخريطة';

  @override
  String liveLocationSharingCount(int count) {
    return '$count يشارك الأشخاص الموقع';
  }

  @override
  String get minutes15 => '15 دقيقة';

  @override
  String get minutes30 => '30 دقيقة';

  @override
  String get hour1 => '1 ساعة';

  @override
  String get hours8 => '8 ساعات';

  @override
  String get personalCard => 'البطاقة الشخصية';

  @override
  String get downloadFailed => 'فشل التنزيل';

  @override
  String get locationExpired => 'انتهت صلاحيتها';

  @override
  String secondsRemaining(int count) {
    return '$count ثانية';
  }

  @override
  String minutesRemaining(int count) {
    return 'دقائق $count';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '$hours ساعة $minutes دقيقة';
  }

  @override
  String get favoriteMessages => 'المفضلة';

  @override
  String get linksCopied => 'تم نسخ الرابط';

  @override
  String get noLinksFound => 'لم يتم العثور على روابط';

  @override
  String get roomStorageRanking => 'تصنيف تخزين الغرفة';

  @override
  String get downloadComplete => 'اكتمل التنزيل';

  @override
  String get downloading => 'جارٍ التنزيل...';

  @override
  String get draftSaved => 'تم حفظ المسودة';

  @override
  String get voiceRecording => 'تسجيل صوتي';

  @override
  String get searchLocation => 'موقع البحث';

  @override
  String get tapToSearch => 'انقر للبحث';

  @override
  String get settingsThisDevice => 'هذا الجهاز';

  @override
  String get settingsJustNow => 'الآن فقط';

  @override
  String get settingsDeviceId => 'معرف الجهاز';

  @override
  String get settingsStatus => 'الحالة';

  @override
  String get settingsLastActive => 'آخر نشاط';

  @override
  String get settingsIpAddress => 'عنوان IP';

  @override
  String get settingsRenameDevice => 'إعادة تسمية الجهاز';

  @override
  String get settingsDeviceNameHint => 'أدخل اسم الجهاز';

  @override
  String get settingsDeviceRenamed => 'تمت إعادة تسمية الجهاز';

  @override
  String get settingsRenameFailed => 'فشلت إعادة التسمية';

  @override
  String get settingsRemoteLogout => 'تسجيل الخروج عن بعد';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return 'هل أنت متأكد أنك تريد تسجيل الخروج \"$deviceName\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get settingsDeviceLoggedOut => 'تم تسجيل خروج الجهاز';

  @override
  String get settingsLogoutFailed => 'فشل تسجيل الخروج';

  @override
  String get settingsLogout => 'تسجيل الخروج';

  @override
  String get settingsVerifyIdentity => 'التحقق من الهوية';

  @override
  String get settingsEnterPasswordToConfirm =>
      'أدخل كلمة المرور الخاصة بك لتأكيد هذا الإجراء.';

  @override
  String get scheduledSendTitle => 'جدولة الرسالة';

  @override
  String get scheduledSendInOneHour => 'في 1 ساعة';

  @override
  String get scheduledSendTonight => 'الليلة (8:00 مساءً)';

  @override
  String get scheduledSendTomorrowMorning => 'صباح الغد (9:00 صباحًا)';

  @override
  String get scheduledSendCustom => 'اختر التاريخ والوقت';

  @override
  String get scheduledMessageLabel => 'المقرر';

  @override
  String get scheduledMessageCancel => 'إلغاء الرسالة المجدولة';

  @override
  String get chatLockTitle => 'قفل الدردشة';

  @override
  String get chatLockEnable => 'قفل هذه الدردشة';

  @override
  String get chatLockDisable => 'فتح هذه الدردشة';

  @override
  String get chatLockDescription =>
      'تتطلب الدردشات المقفلة التحقق من المقاييس الحيوية أو رقم التعريف الشخصي لفتحها';

  @override
  String get chatLockVerifyTitle => 'الدردشة مغلقة';

  @override
  String get chatLockVerifySubtitle => 'قم بالتحقق للوصول إلى هذه الدردشة';

  @override
  String get chatLockVerifyFailed => 'فشل التحقق';

  @override
  String get chatLockEnabled => 'الدردشة مغلقة';

  @override
  String get chatLockDisabled => 'تم فتح الدردشة';

  @override
  String get chatLockPinTitle => 'أدخل رقم التعريف الشخصي';

  @override
  String get chatLockPinSetTitle => 'تعيين رقم التعريف الشخصي';

  @override
  String get chatLockPinConfirmTitle => 'تأكيد رقم التعريف الشخصي';

  @override
  String get chatLockPinMismatch => 'رقم التعريف الشخصي غير متطابق';

  @override
  String get chatLockUseBiometric => 'استخدم القياسات الحيوية';

  @override
  String get chatLockUsePin => 'استخدم رقم التعريف الشخصي';

  @override
  String get mediaEditorUndo => 'تراجع';

  @override
  String get mediaEditorRedo => 'إعادة';

  @override
  String get mediaEditorCrop => 'المحاصيل';

  @override
  String get mediaEditorFilter => 'تصفية';

  @override
  String get mediaEditorDraw => 'ارسم';

  @override
  String get mediaEditorText => 'نص';

  @override
  String get aiAssistant => 'مساعد الذكاء الاصطناعي';

  @override
  String get aiAssistantWelcome =>
      'مرحبا! أنا مساعد الذكاء الاصطناعي N42. كيف يمكنني مساعدك؟';

  @override
  String get aiAssistantNotConfigured => 'لم يتم تكوين خدمة الذكاء الاصطناعي';

  @override
  String get aiAssistantSettings => 'إعدادات الذكاء الاصطناعي';

  @override
  String get aiAssistantClearHistory => 'مسح سجل الدردشة';

  @override
  String get aiAssistantClearHistoryConfirm =>
      'هل أنت متأكد من أنك تريد مسح كل سجل دردشة الذكاء الاصطناعي؟';

  @override
  String get aiAssistantStopGenerating => 'توقف عن التوليد';

  @override
  String get aiAssistantModel => 'نموذج';

  @override
  String get aiAssistantTemperature => 'درجة الحرارة';

  @override
  String get aiAssistantMaxTokens => 'الرموز القصوى';

  @override
  String get aiAssistantContextWindow => 'نافذة السياق';

  @override
  String get aiAssistantServiceStatus => 'حالة الخدمة';

  @override
  String get aiAssistantAvailable => 'متاح';

  @override
  String get aiAssistantUnavailable => 'غير متاح';

  @override
  String get aiSummarize => 'ملخص الذكاء الاصطناعي';

  @override
  String aiSummarizeUnread(int count) {
    return 'تلخيص الرسائل غير المقروءة $count';
  }

  @override
  String get aiSummarizeLoading => 'تلخيص...';

  @override
  String get aiSummarizeError => 'فشل في التلخيص';

  @override
  String get aiRewrite => 'إعادة كتابة الذكاء الاصطناعي';

  @override
  String get aiRewriteFormal => 'رسمي';

  @override
  String get aiRewriteCasual => 'عادية';

  @override
  String get aiRewritePlayful => 'لعوب';

  @override
  String get aiRewriteProfessional => 'محترف';

  @override
  String get aiRewriteAccept => 'استخدم';

  @override
  String get aiRewriteCancel => 'إلغاء';

  @override
  String get aiRewriteLoading => 'إعادة الكتابة...';

  @override
  String get aiLinkSummary => 'ملخص الذكاء الاصطناعي';

  @override
  String get aiLinkSummaryAnalyzing => 'جارٍ التحليل...';

  @override
  String get chatFolderManagement => 'إدارة المجلدات';

  @override
  String get chatFolderSystem => 'مجلدات النظام';

  @override
  String get chatFolderCustom => 'المجلدات المخصصة';

  @override
  String get chatFolderEmpty => 'لا توجد مجلدات مخصصة حتى الآن';

  @override
  String get chatFolderCreate => 'إنشاء مجلد';

  @override
  String get chatFolderEdit => 'تحرير المجلد';

  @override
  String get chatFolderNameHint => 'اسم المجلد';

  @override
  String get chatFolderAll => 'الكل';

  @override
  String get chatFolderUnread => 'غير مقروءة';

  @override
  String get chatFolderPersonal => 'شخصي';

  @override
  String get chatFolderGroups => 'المجموعات';

  @override
  String get chatFolderChannels => 'القنوات';

  @override
  String get chatFolderMuted => 'كتم الصوت';

  @override
  String get storyAddMusic => 'أضف موسيقى';

  @override
  String get storyChangeMusic => 'تغيير الموسيقى';

  @override
  String get storyBackgroundMusic => 'موسيقى خلفية';

  @override
  String get storyMusicPreview => 'المعاينة (بحد أقصى 15 ثانية)';

  @override
  String get storyChooseFromDevice => 'اختر من الجهاز';

  @override
  String get storyUseThisMusic => 'استخدم هذه الموسيقى';

  @override
  String get authPasskeyNotSupported => 'مفتاح المرور غير مدعوم على هذا الجهاز';

  @override
  String get authPasskeyRegister => 'تسجيل مفتاح المرور';

  @override
  String get authPasskeyNoRegistered => 'لم يتم تسجيل أي مفاتيح مرور';

  @override
  String get authPasskeyRegisterHint =>
      'تسجيل مفتاح مرور لهذا الحساب. سيتم تمكين تسجيل الدخول بمفتاح المرور المستقل لاحقًا.';

  @override
  String get authPasskeyNameYours => 'قم بتسمية مفتاح المرور الخاص بك';

  @override
  String get authPasskeyRegistered => 'تم حفظ مفتاح المرور في هذا الحساب';

  @override
  String get authPasskeyDeleted => 'تمت إزالة مفتاح المرور من هذا الحساب';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return 'هل تريد حذف مفتاح المرور \"$name\"؟ ستحتاج إلى تسجيله مرة أخرى قبل استخدام تسجيل الدخول بمفتاح المرور لاحقًا.';
  }

  @override
  String get momentVisibilityPublic => 'عام';

  @override
  String get momentVisibilityPrivate => 'خاص';

  @override
  String get momentVisibilityPartial => 'الأصدقاء المختارون';

  @override
  String get momentVisibilityExcluded => 'استبعاد بعض الأصدقاء';

  @override
  String momentUserMoments(String userName) {
    return 'لحظات $userName';
  }

  @override
  String get momentForwardTo => 'إلى الأمام ل';

  @override
  String get momentForwardSuccess => 'تم الإرسال بنجاح';

  @override
  String get momentSelectFriends => 'حدد الأصدقاء';

  @override
  String get momentSelectTags => 'اختر حسب العلامات';

  @override
  String momentSelectedCount(int count) {
    return 'محدد ($count)';
  }

  @override
  String get momentNoMomentsYet => 'لا توجد لحظات بعد';

  @override
  String get momentForwardMoment => 'لحظة إلى الأمام';

  @override
  String get momentAddComment => 'إضافة تعليق...';

  @override
  String momentForwardContent(String content) {
    return '[لحظة] $content';
  }

  @override
  String get momentDeleteMoment => 'حذف لحظة';

  @override
  String get momentDeleteConfirm => 'هل أنت متأكد أنك تريد حذف هذه اللحظة؟';

  @override
  String get momentComment => 'التعليق';

  @override
  String get momentWriteComment => 'أكتب تعليق...';

  @override
  String get momentLike => 'مثل';

  @override
  String get momentUnlike => 'على عكس';

  @override
  String get momentForward => 'إلى الأمام';

  @override
  String get momentDelete => 'حذف';

  @override
  String get momentReply => 'الرد';

  @override
  String get momentMoment => 'لحظة';

  @override
  String momentLikesCount(int count) {
    return '$count يحب';
  }

  @override
  String momentCommentsCount(int count) {
    return 'تعليقات $count';
  }

  @override
  String get momentNoComments => 'لا توجد تعليقات حتى الآن';

  @override
  String get momentFailedToLoad => 'فشل تحميل الصورة';

  @override
  String momentReplyTo(String userName) {
    return 'الرد على $userName...';
  }

  @override
  String get momentNoConversations => 'لا محادثات';

  @override
  String get momentJustNow => 'الآن فقط';

  @override
  String momentMinutesAgo(int count) {
    return 'منذ ${count}m';
  }

  @override
  String momentHoursAgo(int count) {
    return 'منذ ${count}h';
  }

  @override
  String momentDaysAgo(int count) {
    return 'منذ ${count}d';
  }

  @override
  String get chatGroupAnnouncementHint => 'أدخل إعلان المجموعة';

  @override
  String get chatGroupAnnouncementEmpty => 'لا يوجد إعلان';

  @override
  String get chatEditNickname => 'تحرير اللقب';

  @override
  String get chatNicknameHint => 'أدخل لقبك في هذه المجموعة';

  @override
  String get contactAddPhoneHint => 'أدخل رقم الهاتف';

  @override
  String get contactNotesHint => 'أضف ملاحظات حول جهة الاتصال هذه';

  @override
  String get reportTitle => 'تقرير';

  @override
  String get reportReasonSpam => 'البريد العشوائي';

  @override
  String get reportReasonHarassment => 'التحرش';

  @override
  String get reportReasonFraud => 'الاحتيال';

  @override
  String get reportReasonOther => 'أخرى';

  @override
  String get reportSubmitted => 'تم تقديم التقرير';

  @override
  String get reportDescription => 'وصف إضافي (اختياري)';

  @override
  String get qrcodeSaved => 'تم حفظ رمز الاستجابة السريعة في الألبوم';

  @override
  String get chatSendRedPacketInChat => 'يرجى إرسال الحزمة الحمراء في الدردشة';

  @override
  String get commonSaveFailed => 'فشل الحفظ';

  @override
  String get reportSelectReason => 'الرجاء تحديد السبب';

  @override
  String get reportUnavailable => 'سجّل الدخول لإرسال بلاغ.';

  @override
  String get reportAccountChanged =>
      'تغير الحساب. افتح هذا البلاغ مجددًا لإرساله.';

  @override
  String get reportUnsupported =>
      'لا يدعم هذا الخادم الرئيسي البلاغات عن المستخدمين.';

  @override
  String get reportRoomUnsupported =>
      'لا يدعم هذا الخادم الرئيسي البلاغات عن الغرف.';

  @override
  String get reportRateLimited => 'بلاغات كثيرة جدًا. حاول مجددًا لاحقًا.';

  @override
  String get reportCouldNotSend => 'تعذر إرسال البلاغ. حاول مجددًا.';

  @override
  String get gameCenter => 'العاب';

  @override
  String get gameHighScore => 'الأفضل';

  @override
  String get gameScore => 'النتيجة';

  @override
  String get gameOver => 'انتهت اللعبة';

  @override
  String get gamePlayAgain => 'العب مرة أخرى';

  @override
  String get gameLeaderboard => 'المتصدرين';

  @override
  String get gamePause => 'متوقف مؤقتًا';

  @override
  String get gameResume => 'انقر للاستئناف';

  @override
  String get gameConfirmExit => 'ترك هذه اللعبة؟';

  @override
  String get gameNoScores => 'لا توجد نتائج حتى الآن';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'دمج البلاط للوصول إلى 2048';

  @override
  String get gameBlockDrop => 'إسقاط الكتلة';

  @override
  String get gameBlockDropDesc => 'إسقاط وخطوط واضحة';

  @override
  String get gameMinesweeper => 'كاسحة ألغام';

  @override
  String get gameMinesweeperDesc => 'البحث عن جميع الخلايا الآمنة';

  @override
  String get gameMatch3 => 'المباراة 3';

  @override
  String get gameMatch3Desc => 'المباراة 3 أو أكثر من الأحجار الكريمة';

  @override
  String get gameMinesweeperEasy => 'سهل';

  @override
  String get gameMinesweeperMedium => 'متوسط';

  @override
  String get gameMinesLeft => 'الألغام اليسار';

  @override
  String get gameTimeLeft => 'الوقت';

  @override
  String get gameLevel => 'المستوى';

  @override
  String get gameNext => 'التالي';

  @override
  String get gameBestTime => 'أفضل وقت';

  @override
  String get gameNewRecord => 'رقم قياسي جديد!';

  @override
  String get gameLines => 'خطوط';

  @override
  String get storyMyStory => 'قصتي';

  @override
  String get storageSmartCleanup => 'التنظيف الذكي';

  @override
  String get storageOldMediaFiles => 'ملفات الوسائط القديمة';

  @override
  String get storageLargeFiles => 'ملفات كبيرة';

  @override
  String get storageAppCache => 'ذاكرة التخزين المؤقت للتطبيق';

  @override
  String get storageSettings => 'إعدادات التخزين';

  @override
  String get storageAutoCleanup => 'التنظيف التلقائي';

  @override
  String storageAutoCleanupDesc(int days) {
    return 'يقوم تلقائيًا بتنظيف الملفات الأقدم من أيام $days';
  }

  @override
  String get storageCleanupPeriod => 'فترة التنظيف';

  @override
  String get storagePreserveThumbnails => 'الحفاظ على الصور المصغرة';

  @override
  String get storagePreserveThumbnailsDesc =>
      'احتفظ بالصور المصغرة للصور أثناء عملية التنظيف';

  @override
  String get storageWarningHigh =>
      'استخدام التخزين مرتفع. فكر في تنظيف الملفات القديمة.';

  @override
  String get storageWarningCritical =>
      'التخزين منخفض للغاية. يرجى تنظيف المساحة الحرة.';

  @override
  String storageFreed(String size, int count) {
    return 'تم تحرير $size (ملفات $count)';
  }

  @override
  String storageDays(int days) {
    return 'أيام $days';
  }

  @override
  String storageViewAllRooms(int count) {
    return 'عرض جميع غرف $count';
  }

  @override
  String get storageNoFiles => 'لم يتم العثور على ملفات';

  @override
  String get storageFilePinned => 'مثبت';

  @override
  String storageDeleteSelected(int count) {
    return 'هل تريد حذف الملفات المحددة $count؟ يمكن إعادة تنزيلها من الخادم.';
  }

  @override
  String get backupRestore => 'النسخ الاحتياطي والاستعادة';

  @override
  String get backupCreate => 'إنشاء نسخة احتياطية';

  @override
  String get backupCreateDesc =>
      'قم بعمل نسخة احتياطية من إعداداتك ومفاتيح التشفير. سيتم استعادة الرسائل من الخادم بعد إعادة تسجيل الدخول.';

  @override
  String get backupIncludeKeys => 'تضمين مفاتيح التشفير';

  @override
  String get backupIncludeKeysDesc => 'مطلوب لقراءة الرسائل المشفرة';

  @override
  String get backupPasswordProtect => 'حماية كلمة المرور';

  @override
  String get backupEnterPassword => 'أدخل كلمة المرور الاحتياطية';

  @override
  String get backupHistory => 'تاريخ النسخ الاحتياطي';

  @override
  String get backupNoBackups => 'لا توجد نسخ احتياطية حتى الآن';

  @override
  String get backupRestore2 => 'استعادة';

  @override
  String get backupDelete => 'حذف';

  @override
  String get backupDeleteConfirm =>
      'هل أنت متأكد أنك تريد حذف هذه النسخة الاحتياطية؟ لا يمكن التراجع عن هذا.';

  @override
  String get backupRestoreFromFile => 'استعادة من الملف';

  @override
  String get backupRestoreFromFileDesc =>
      'قم باستيراد ملف .n42backup من جهاز آخر أو نسخة احتياطية سابقة.';

  @override
  String get backupChooseFile => 'اختر ملف النسخ الاحتياطي';

  @override
  String get backupRestoring => 'جارٍ الاستعادة...';

  @override
  String backupCreated(int rooms, int messages) {
    return 'تم إنشاء النسخة الاحتياطية: غرف $rooms، رسائل $messages';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return 'تمت استعادة إعدادات $settings من غرف $rooms';
  }

  @override
  String backupFailed(String error) {
    return 'فشل النسخ الاحتياطي: $error';
  }

  @override
  String get backupPasswordRequired => 'هذه النسخة الاحتياطية محمية بكلمة مرور';

  @override
  String get blocGroupNotFound => 'لم يتم العثور على المجموعة';

  @override
  String blocGroupMembersInvited(int count) {
    return 'أعضاء $count المدعوين';
  }

  @override
  String get blocGroupMemberRemoved => 'تمت إزالة العضو';

  @override
  String get blocGroupAdminRemoved => 'تمت إزالة المشرف';

  @override
  String get blocGroupLeft => 'غادر المجموعة';

  @override
  String get blocGroupDisbanded => 'تم حل المجموعة';

  @override
  String get blocGroupJoined => 'انضم إلى المجموعة';

  @override
  String get blocGroupInviteDeclined => 'تم رفض الدعوة';

  @override
  String get blocGroupTokenGateUpdated => 'تم تحديث بوابة الرمز المميز';

  @override
  String get blocTransferProcessing => 'جارٍ معالجة النقل...';

  @override
  String get blocTransferCancelled => 'تم إلغاء النقل';

  @override
  String get blocTransferFailed => 'فشل النقل';

  @override
  String get blocPaymentProcessing => 'جارٍ معالجة الدفع...';

  @override
  String get blocPaymentFailed => 'فشل الدفع';

  @override
  String get groupMaxMembers => 'حد الأعضاء';

  @override
  String get groupMaxMembersUnlimited => 'غير محدود';

  @override
  String get groupMaxMembersHint => 'أدخل الحد (اتركه فارغًا لعدد غير محدود)';

  @override
  String get groupMaxMembersUpdated => 'تم تحديث حد الأعضاء';

  @override
  String get groupFull => 'المجموعة في القدرة';

  @override
  String get groupChannels => 'قنوات الموضوع';

  @override
  String get groupChannelsEmpty => 'لا توجد قنوات بعد';

  @override
  String get groupChannelsCount => 'القنوات';

  @override
  String get groupChannelCreate => 'قناة جديدة';

  @override
  String get groupChannelName => 'اسم القناة';

  @override
  String get groupChannelTopic => 'موضوع القناة (اختياري)';

  @override
  String get groupChannelDelete => 'حذف القناة';

  @override
  String get groupChannelDeleteConfirm =>
      'هل تريد حذف هذه القناة؟ سيتم فقدان كافة الرسائل.';

  @override
  String get groupBotSettings => 'إعدادات البوت';

  @override
  String get groupBotEnabled => 'تمكين بوت';

  @override
  String get groupBotWelcomeMessage => 'قالب رسالة الترحيب';

  @override
  String get groupBotWelcomeHint =>
      'استخدم \"الاسم\" كعنصر نائب لاسم العضو الجديد';

  @override
  String get groupBotConfigUpdated => 'تم تحديث إعدادات الروبوت';

  @override
  String get groupContentFilter => 'مرشح المحتوى';

  @override
  String get groupContentFilterEnabled => 'تمكين تصفية الكلمات الرئيسية';

  @override
  String get groupContentFilterReplace => 'استبدل بـ ***';

  @override
  String get groupContentFilterHide => 'إخفاء الرسالة';

  @override
  String get groupContentFilterAddWord => 'أضف كلمة رئيسية';

  @override
  String get groupContentFilterUpdated => 'تم تحديث فلتر المحتوى';

  @override
  String get chatSlashCommands => 'الأوامر';

  @override
  String get chatCommandPoll => '/ استطلاع - إنشاء استطلاع';

  @override
  String get chatCommandAnnounce => '/ إعلان - إرسال إعلان';

  @override
  String get chatCommandWelcome => '/ ترحيب - تعيين رسالة الترحيب';

  @override
  String get chatReportMessage => 'تقرير';

  @override
  String get chatReportReason => 'سبب التقرير';

  @override
  String get chatReportSpam => 'البريد العشوائي';

  @override
  String get chatReportHarassment => 'التحرش';

  @override
  String get chatReportInappropriate => 'محتوى غير لائق';

  @override
  String get chatReportOther => 'أخرى';

  @override
  String get chatReportSuccess => 'تم تقديم التقرير';

  @override
  String get spacesName => 'اسم المجتمع';

  @override
  String get spacesNameHint => 'على سبيل المثال تجار التشفير';

  @override
  String get spacesNameRequired => 'الاسم مطلوب';

  @override
  String get spacesDescription => 'الوصف';

  @override
  String get spacesDescriptionHint => 'ما هو هذا المجتمع عنه؟';

  @override
  String get spacesType => 'نوع المجتمع';

  @override
  String get spacesPublicDesc => 'يمكن لأي شخص اكتشاف والانضمام';

  @override
  String get spacesPrivateDesc => 'يمكن للأعضاء المدعوين فقط الانضمام';

  @override
  String get spacesNotFound => 'لم يتم العثور على المجتمع';

  @override
  String get spacesSearch => 'بحث في المجتمعات...';

  @override
  String get spacesMembers => 'الأعضاء';

  @override
  String get spacesNoChannels => 'لا توجد قنوات بعد';

  @override
  String get spacesLeave => 'مغادرة المجتمع';

  @override
  String spacesLeaveConfirm(String name) {
    return 'هل أنت متأكد أنك تريد مغادرة \"$name\"؟';
  }

  @override
  String get spacesDelete => 'حذف المجتمع';

  @override
  String spacesDeleteConfirm(String name) {
    return 'سيؤدي هذا إلى حذف \"$name\" وجميع قنواتها نهائيًا. لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get spacesCreateChannel => 'أضف قناة';

  @override
  String get spacesChannelName => 'اسم القناة';

  @override
  String get spacesChannelTopic => 'الموضوع (اختياري)';

  @override
  String get spacesDeleteChannel => 'حذف القناة';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return 'هل أنت متأكد أنك تريد حذف \"#$name\"؟';
  }

  @override
  String get spacesEditName => 'تحرير الاسم';

  @override
  String get spacesEditDescription => 'تحرير الوصف';

  @override
  String spacesViewAllMembers(int count) {
    return 'عرض جميع أعضاء $count';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return 'ركلة $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return 'حظر $name';
  }

  @override
  String get spacesPromoteAdmin => 'ترقية إلى المشرف';

  @override
  String get spacesDemoteAdmin => 'إزالة المشرف';

  @override
  String get spacesInviteMember => 'دعوة العضو';

  @override
  String get spacesInviteMemberUserId => 'معرف المستخدم (مثل @user:server.com)';

  @override
  String get spacesSave => 'حفظ';

  @override
  String get settingsScreenshotProtection => 'حماية لقطة الشاشة';

  @override
  String get settingsScreenshotProtectionDesc =>
      'منع لقطات الشاشة وتسجيل الشاشة';

  @override
  String get chatSelfDestructTimer => 'التدمير الذاتي';

  @override
  String get chatTimerPickerTitle => 'مؤقت التدمير الذاتي';

  @override
  String get chatTimerOff => 'إيقاف';

  @override
  String get onChainNotificationsTitle => 'الأحداث على السلسلة';

  @override
  String get onChainMarkAllRead => 'وضع علامة على كل قراءة';

  @override
  String get onChainNoNotifications => 'لا توجد أحداث على السلسلة حتى الآن';

  @override
  String get onChainNoNotificationsDesc =>
      'ستظهر هنا الأحداث من القنوات المشتركة';

  @override
  String get onChainViewDetails => 'عرض التفاصيل';

  @override
  String get chatCommandHelp => '/ مساعدة — إظهار كافة الأوامر';

  @override
  String get chatCommandPrice => '/السعر - احصل على سعر الرمز المميز';

  @override
  String get chatCommandBalance => '/التوازن - إظهار رصيد المحفظة';

  @override
  String get chatCommandChains => '/chains - قائمة بأكثر من 236 سلسلة مدعومة';

  @override
  String get chatMiniApps => 'تطبيقات';

  @override
  String get miniAppMarketTitle => 'تطبيقات مصغرة';

  @override
  String get miniAppCategoryAll => 'الكل';

  @override
  String get miniAppSearch => 'تطبيقات البحث...';

  @override
  String get miniAppFeatured => 'مميز';

  @override
  String get miniAppAllApps => 'جميع التطبيقات';

  @override
  String get miniAppNoResults => 'لم يتم العثور على أي تطبيقات';

  @override
  String get slideToPayLabel => '→ → → قم بالتمرير للتأكيد';

  @override
  String get slideToPayConfirming => 'جارٍ التأكيد...';

  @override
  String get redPacketBestLuck => 'حظا سعيدا';

  @override
  String get redPacketBestLuckCongrats => 'حظا سعيدا! لقد حصلت على أكثر!';

  @override
  String redPacketStats(int claimed, int total) {
    return 'ادعى $claimed / $total';
  }

  @override
  String get redPacketStatsTotal => 'المجموع';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 أمسكت بعلبة حمراء • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id • عنوان المحفظة 0x • name.eth';

  @override
  String get web3SearchPlaceholder => 'البحث حسب الهوية أو المحفظة أو ENS...';

  @override
  String get web3WalletAddress => 'عنوان المحفظة';

  @override
  String get web3AddressCopied => 'تم نسخ العنوان';

  @override
  String get web3Copy => 'نسخ';

  @override
  String get web3SendMessage => 'أرسل رسالة';

  @override
  String get web3SendToWallet => 'محفظة الرسائل';

  @override
  String get web3WalletOnlyHint =>
      'هذا العنوان ليس لديه حساب N42 حتى الآن. سيتم تسليم الرسالة عند انضمامهم.';

  @override
  String get web3NftAvatar => 'الصورة الرمزية NFT';

  @override
  String get web3ResolveFailed => 'فشل في حل الهوية';

  @override
  String web3EnsNotFound(String name) {
    return 'لم يتم العثور على اسم ENS \"$name\".';
  }

  @override
  String get web3NoN42AccountTitle => 'لا يوجد حساب N42';

  @override
  String get web3NoN42AccountDesc =>
      'عنوان المحفظة هذا لا يحتوي على حساب N42 حتى الآن. يمكنك مشاركة رابط دعوة N42 معهم للبدء.';

  @override
  String get web3ShareInvite => 'مشاركة الدعوة';

  @override
  String get nftPickerTitle => 'حدد الصورة الرمزية NFT';

  @override
  String get nftPickerTabPopular => 'شعبية';

  @override
  String get nftPickerTabCustom => 'مخصص';

  @override
  String get nftPickerChain => 'سلسلة';

  @override
  String get nftPickerContract => 'عنوان العقد';

  @override
  String get nftPickerTokenId => 'معرف الرمز المميز';

  @override
  String get nftPickerVerifyOwnership => 'التحقق من الملكية والمعاينة';

  @override
  String get nftPickerUseAsAvatar => 'استخدم كصورة رمزية';

  @override
  String get nftPickerPreview => 'معاينة';

  @override
  String get nftPickerNotOwned => 'أنت لا تملك هذا NFT';

  @override
  String get nftPickerInvalidTokenId => 'معرف الرمز المميز غير صالح';

  @override
  String get nftPickerEnterBoth => 'أدخل عنوان العقد ومعرف الرمز المميز';

  @override
  String get nftPickerInfoTitle =>
      'الصورة الرمزية NFT - تم التحقق منها على السلسلة';

  @override
  String get nftPickerInfoDesc =>
      'قم بربط NFT الذي تمتلكه باعتباره الصورة الرمزية الخاصة بك. يمكن لأي شخص التحقق من الملكية على السلسلة. معروض بحلقة ذهبية عبر N42.';

  @override
  String get nftPickerPopularCollections => 'مجموعات شعبية';

  @override
  String get nftPickerWalletHint =>
      'قم بتوصيل محفظة N42 الخاصة بك لاكتشاف NFTs الخاصة بك تلقائيًا عبر أكثر من 236 سلسلة.';

  @override
  String get profileBindNftAvatar => 'ربط الصورة الرمزية NFT';

  @override
  String get profileChangeAvatar => 'تغيير الصورة الرمزية';

  @override
  String get groupTopics => 'المواضيع';

  @override
  String get groupTopicsEmpty => 'لا توجد مواضيع حتى الآن';

  @override
  String get syncInProgress => 'جارٍ مزامنة سجل الرسائل...';

  @override
  String get recoveryKeyReminderTitle => 'حماية رسائلك';

  @override
  String get recoveryKeyReminderDesc =>
      'قم بإنشاء مفتاح استرداد لمزامنة الرسائل المشفرة بشكل آمن عبر الأجهزة';

  @override
  String get recoveryKeySetupNow => 'قم بالإعداد الآن';

  @override
  String get recoveryKeyRemindLater => 'ذكرني لاحقا';

  @override
  String get channelReadOnly => 'يمكن للمسؤولين فقط النشر في هذه القناة';

  @override
  String get channelSubscribers => 'المشتركين';

  @override
  String get channelVerified => 'قناة تم التحقق منها';

  @override
  String get redPacketHistory => 'تاريخ الحزمة الحمراء';

  @override
  String get redPacketSent => 'تم الإرسال';

  @override
  String get redPacketReceived => 'تم الاستلام';

  @override
  String get redPacketExpired => 'انتهت صلاحيتها';

  @override
  String get redPacketClaimed => 'ادعى';

  @override
  String get redPacketInsufficientBalance => 'رصيد غير كاف';

  @override
  String selfDestructCountdown(String time) {
    return 'التدمير الذاتي في $time';
  }

  @override
  String get messageDestroyed => 'تم تدمير الرسالة';

  @override
  String miniAppPermissionDenied(String permission) {
    return 'تم رفض الإذن: $permission';
  }

  @override
  String get aiSuggestionGasFee => 'ما هي رسوم الغاز؟';

  @override
  String get aiSuggestionDefi => 'دليل DeFi للمبتدئين';

  @override
  String get aiSuggestionSecurity => 'كيفية التحقق من سلامة العقد';

  @override
  String get aiSuggestionBridge => 'الجسور عبر السلسلة';

  @override
  String get channelDiscoverTitle => 'اكتشف القنوات';

  @override
  String get channelDiscoverSearch => 'بحث في القنوات...';

  @override
  String get channelJoin => 'انضم';

  @override
  String get channelJoined => 'انضم';

  @override
  String get channelCategory => 'الفئة';

  @override
  String slowModeCooldown(int seconds) {
    return 'الوضع البطيء: انتظر ${seconds}s';
  }

  @override
  String get addressCopyAction => 'نسخ العنوان';

  @override
  String get addressSendMessage => 'أرسل رسالة';

  @override
  String get addressViewProfile => 'عرض الملف الشخصي';

  @override
  String get sendToAddress => 'إرسال إلى عنوان المحفظة';

  @override
  String get blocAuthSendVerificationCodeFailed => 'فشل في إرسال رمز التحقق';

  @override
  String get blocAuthServerNoEmailPasswordReset =>
      'هذا الخادم لا يدعم إعادة تعيين كلمة مرور البريد الإلكتروني';

  @override
  String get blocAuthResetPasswordFailed => 'فشل في إعادة تعيين كلمة المرور';

  @override
  String get blocAuthChangePasswordFailed => 'فشل في تغيير كلمة المرور';

  @override
  String get blocAuthOldPasswordWrong => 'كلمة المرور الحالية غير صحيحة';

  @override
  String get blocAuthLoginCancelled => 'تم إلغاء تسجيل الدخول';

  @override
  String get blocAuthGoogleLoginFailed => 'فشل تسجيل الدخول إلى جوجل';

  @override
  String get blocAuthAppleLoginFailed => 'فشل تسجيل دخول أبل';

  @override
  String get blocAuthSsoLoginFailed => 'فشل تسجيل الدخول الموحّد (SSO).';

  @override
  String get blocAuthFacebookLoginFailed => 'فشل تسجيل الدخول الفيسبوك';

  @override
  String get blocAuthTwitterLoginFailed => 'فشل تسجيل الدخول إلى تويتر';

  @override
  String get blocAuthWeChatLoginFailed => 'فشل تسجيل الدخول إلى WeChat';

  @override
  String get blocAuthWeChatNotConfigured =>
      'لم يتم تكوين تسجيل الدخول إلى WeChat';

  @override
  String get blocAuthWeChatNotInstalled => 'الرجاء تثبيت WeChat أولاً';

  @override
  String get blocAuthPasswordWrong => 'كلمة مرور غير صحيحة';

  @override
  String get blocAuthEmailAlreadyBound =>
      'هذا البريد الإلكتروني مرتبط بالفعل بحساب آخر';

  @override
  String get blocAuthChangeEmailFailed => 'فشل في تغيير البريد الإلكتروني';

  @override
  String get blocAuthVerificationCodeInvalid =>
      'رمز التحقق غير صحيح أو منتهي الصلاحية';

  @override
  String get blocAuthSessionExpired =>
      'انتهت الجلسة، يرجى تسجيل الدخول مرة أخرى';

  @override
  String get blocAuthSessionIncomplete =>
      'بيانات الجلسة غير كاملة، يرجى تسجيل الدخول مرة أخرى';

  @override
  String get chatReadingMode => 'وضع القراءة';

  @override
  String get groupPoints => 'النقاط';

  @override
  String get settingsPrivacySecurity => 'الخصوصية والأمان';

  @override
  String get settingsSystemAccounts => 'النظام والحسابات';

  @override
  String get settingsNotificationPrivacy => 'خصوصية الإشعارات';

  @override
  String get settingsSenderOnly => 'إظهار المرسل فقط';

  @override
  String get settingsHiddenNotification => 'إخفاء المرسل والرسالة';

  @override
  String get settingsSmartFilter => 'التصفية الذكية';

  @override
  String get settingsEmailVerificationSent => 'تم إرسال رسالة التحقق';

  @override
  String get settingsEmailLinkInstructions =>
      'افتح رابط التحقق في بريدك الإلكتروني، ثم عد إلى هنا وأكّد.';

  @override
  String get settingsSendVerificationEmail => 'إرسال رسالة التحقق';

  @override
  String get chatLogoutKeyWarning =>
      'انسخ مفاتيح التشفير احتياطيًا قبل تسجيل الخروج، وإلا فقد تفقد إمكانية الوصول إلى الرسائل المشفرة.';

  @override
  String get settingsBiometricUnavailable =>
      'المصادقة البيومترية غير متاحة. تحقّق من التسجيل والأذونات في إعدادات الجهاز.';

  @override
  String get chatEncryptionNotReady =>
      'الاتصال الآمن غير جاهز. لم تُرسَل الرسالة. تحقق من الاتصال والتحقق من الأجهزة في كلا الحسابين، ثم أعد المحاولة.';

  @override
  String get contactRequestPending => 'في انتظار القبول';

  @override
  String get chatFriendRequestPending =>
      'لم تُؤكَّد الصداقة. تحقق من جهات الاتصال > أصدقاء جدد قبل الإرسال.';

  @override
  String contactPhotoCount(int count) {
    return '$count صورة';
  }

  @override
  String get videoPublish => 'نشر فيديو';

  @override
  String get videoGoLive => 'بدء بث مباشر';

  @override
  String get videoSelect => 'اختيار فيديو';

  @override
  String get videoLiveUnavailable => 'البث المباشر غير متاح';

  @override
  String get qrcodeAlbum => 'الألبوم';

  @override
  String get settingsSwitchAccount => 'تبديل الحساب';

  @override
  String get chatFilterUnread => 'غير مقروء';

  @override
  String get chatFilterEmpty => 'لا توجد محادثات ضمن هذا المرشح';

  @override
  String get accountAdd => 'إضافة حساب';

  @override
  String get accountCurrent => 'الحساب الحالي';

  @override
  String get accountSwitching => 'جارٍ تبديل الحساب…';

  @override
  String get accountSwitchFailed =>
      'تعذر تبديل الحساب. حاول مجددًا، أو أضف الحساب لتسجيل الدخول مرة أخرى.';

  @override
  String get accountSessionsHint =>
      'بدّل الحسابات هنا لإبقاء رسائل كل حساب وجلسته الآمنة منفصلة.';

  @override
  String get accountNoSaved => 'لا توجد حسابات محفوظة بعد';

  @override
  String get contactRequestSent => 'تم إرسال الطلب';

  @override
  String get contactRequestsIncoming => 'الطلبات الواردة';

  @override
  String get contactRequestsOutgoing => 'الطلبات المرسلة';

  @override
  String get contactRequestHint => 'يمكنك الدردشة والاتصال بعد قبول الطلب.';

  @override
  String get callReturnToCall => 'العودة إلى المكالمة';

  @override
  String get chatMessageSending => 'جارٍ الإرسال';

  @override
  String get chatMessageSent => 'تم الإرسال';

  @override
  String get chatMessageDelivered => 'تم التسليم';

  @override
  String get chatMessageRead => 'مقروء';

  @override
  String get chatMessageFailed => 'لم تُرسَل. اضغط لإعادة المحاولة.';

  @override
  String get chatMessageUnavailable =>
      'الرسالة غير متاحة على هذا الجهاز. اضغط للتحقق من خيارات الاسترداد.';

  @override
  String get contactStarredFriends => 'الأصدقاء المميّزون بنجمة';

  @override
  String get chatRecipientKeysMissing =>
      'ليس لدى هذا الصديق جلسة مشفّرة متاحة. اطلب منه تسجيل الدخول وفتح التطبيق، ثم أعد المحاولة. استخدم تبديل الحساب بدلًا من تسجيل الخروج عند تغيير الحسابات.';

  @override
  String get chatSwitchForMessaging =>
      'هل تغيّر الحساب؟ استخدم تبديل الحساب للاحتفاظ برسائلك وجلساتك الآمنة. تسجيل الخروج يلغي وصول هذا الجهاز وقد يجعل الرسائل المشفّرة الواردة غير متاحة.';

  @override
  String get aiServiceUnavailable =>
      'ملخصات الذكاء الاصطناعي غير متاحة حاليًا. حاول مجددًا بعد استعادة الوصول إلى الخدمة.';

  @override
  String aiSummarizeMessages(int count) {
    return 'تلخيص أحدث $count رسالة';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return 'انضم $joined · تمت دعوة $invited';
  }

  @override
  String contactPendingCount(int count) {
    return '$count طلب معلّق';
  }

  @override
  String get chatDraftLabel => 'مسودة';

  @override
  String get contactIndexLabel => 'فهرس جهات الاتصال';

  @override
  String get transferAssetUnavailable => 'أصل الدفع غير متاح';

  @override
  String get transferPaymentRequestUnavailable => 'طلب الدفع غير متاح';

  @override
  String get chatCatchUp => 'متابعة ما فاتك';

  @override
  String get chatCatchUpMentions => 'الإشارات';

  @override
  String get chatCatchUpReplies => 'الردود عليّ';

  @override
  String get chatCatchUpPinned => 'الرسائل المثبّتة';

  @override
  String get chatCatchUpScope =>
      'تُبحث الإشارات والردود ضمن الرسائل المحمّلة، بما فيها الرسائل المقروءة. حمّل رسائل أقدم للعثور على الردود السابقة.';

  @override
  String get chatCatchUpLoadMore => 'تحميل رسائل أقدم';

  @override
  String get chatActionPreview => 'مراجعة اقتراح التقويم';

  @override
  String get chatActionPrivacy =>
      'لن تُشارَك مع تطبيق التقويم بعد التأكيد إلا العنوان والوقت أدناه. تحقق من المنطقة الزمنية. قد يزامن حساب التقويم هذا الحدث.';

  @override
  String get chatActionTitle => 'حدث من الدردشة';

  @override
  String get chatActionSuggestion => 'اقتراح التقويم';

  @override
  String get chatUnreadAttention => 'الإشارات والردود غير المقروءة';

  @override
  String get chatScanAgain => 'المسح مجددًا';

  @override
  String get chatUnreadScope =>
      'يفحص سجل الخادم حتى علامة القراءة لديك. افتح محادثة لقراءتها؛ وحدّث لإعادة إنشاء النتائج.';

  @override
  String get chatScanIncomplete =>
      'غير مكتمل: السجل أو فك التشفير أو علامة القراءة غير متاحة. حاول مجددًا بعد المزامنة.';

  @override
  String get chatHistoryShare => 'مشاركة السجل المحدد';

  @override
  String get chatHistoryExplanation =>
      'للمشرفين فقط. حدد نصًا عاديًا ومحادثة مباشرة مشفّرة موجودة مع عضو انضم إلى المجموعة. تنشئ المشاركة رسائل تدقيق مرئية في المجموعة.';

  @override
  String get chatHistoryEnable => 'تمكين المشاركة';

  @override
  String get chatHistoryDisable => 'تعطيل المشاركة';

  @override
  String get chatHistoryPolicy => 'سياسة مشاركة سجل المجموعة';

  @override
  String get chatHistoryPolicyDetail =>
      'يمكن للمشرفين فقط المشاركة. يؤدي التمكين أيضًا إلى حصر ظهور سجل المجموعة في الأحداث بعد الانضمام. اضبط حدود الرسائل النصية أدناه وأكّد.';

  @override
  String get chatHistoryPolicySaved => 'تم حفظ السياسة';

  @override
  String get chatHistoryRecipient => 'المحادثة المشفّرة مع المستلم';

  @override
  String get chatHistoryReview => 'مراجعة الرسائل المحددة';

  @override
  String get chatHistoryMessages => 'رسائل';

  @override
  String get chatHistoryConfirmDetail =>
      'تحقق من هذا المستلم وكل رسالة ووقتها قبل المشاركة. قد يكون المحتوى قد أُرسل بالفعل حتى عند فشل النتيجة أو عدم معرفتها: تحقق من نتيجة الإرسال قبل المتابعة.';

  @override
  String get chatHistoryCompleted =>
      'تم إرسال السجل المحدد وتأكيد تدقيق المجموعة';

  @override
  String get chatHistoryPending =>
      'قيد الانتظار: تحقق من النتيجة ثم أكّد مجددًا للمتابعة. لا تُعاد مطلقًا عمليات الإرسال ذات النتيجة غير المعروفة.';

  @override
  String get chatHistoryReconcile => 'التحقق من نتيجة الإرسال';

  @override
  String get chatHistoryFailed =>
      'تعذر الإكمال. تحقق من صلاحية المشرف وسياسة المجموعة والتشفير وعضوية المستلم والرسائل المحددة. إذا بدأ الإرسال، فتحقق من نتيجته.';

  @override
  String get chatDeviceActions => 'إجراءات على الجهاز';

  @override
  String get chatDeviceActionsReview =>
      'بعد التأكيد، تُقدَّم هذه الرسالة فقط لاقتراحات إجراءات النظام التي تُعالَج على الجهاز. اختر إجراءً لفتح التقويم أو التذكيرات أو الخرائط.';

  @override
  String get chatHistoryMaxMessages => 'حد الرسائل (1–50)';

  @override
  String get chatHistoryMaxHours => 'نطاق السجل بالساعات (1–720)';

  @override
  String get chatNotifyAll => 'كل الرسائل';

  @override
  String get chatNotifyAllDescription =>
      'إرسال إشعار بكل رسالة جديدة في هذه المحادثة';

  @override
  String get chatNotifyMentions => 'الإشارات فقط';

  @override
  String get chatNotifyMentionsDescription =>
      'إرسال إشعار فقط عند الإشارة إليك أو استخدام @room';

  @override
  String get chatNotifyMutedDescription =>
      'إيقاف إشعارات هذه المحادثة على جميع الأجهزة';

  @override
  String get scheduledMessagesTitle => 'الرسائل المجدولة';

  @override
  String get scheduledMessagesEmpty => 'لا توجد رسائل مجدولة بعد';

  @override
  String get scheduledMessagesHint =>
      'اضغط مطولًا على إرسال أو الصور أو الملفات أو صورة GIF أو ملصق لجدولة رسالة.';

  @override
  String get scheduledMessageCancelled => 'تم إلغاء الرسالة المجدولة';

  @override
  String scheduledMessageCreatedAt(String time) {
    return 'أُنشئت في $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => 'لم يتم تأكيد التسليم';

  @override
  String get scheduledRecoveryCopy => 'حفظ نسخة للاسترداد';

  @override
  String get scheduledRecoveryCopyHint =>
      'تُحفظ على هذا الجهاز دون تغيير الرسائل أو إرسالها. تعرض المعاينة حتى 8,000 حرف.';

  @override
  String get scheduledRecoveryCopies => 'نسخ الاسترداد';

  @override
  String get scheduledRecoveryReset => 'إعادة ضبط قائمة الانتظار التالفة';

  @override
  String get scheduledRecoveryResetHint =>
      'حُفظت نسخة مطابقة على هذا الجهاز. هل تريد إعادة ضبط جميع الرسائل المجدولة لهذا الحساب؟ ربما أُرسلت بعض الرسائل بالفعل. ستُحفظ النسخ والمرفقات، ولن تُعاد إرسال أي رسالة.';

  @override
  String get scheduledRecoveryExportHint =>
      'يحتوي هذا الملف على نص مسودة وتفاصيل حساب غير مشفرة. لا يتضمن المرفقات. اختر وجهة موثوقة.';

  @override
  String get scheduledRecoveryImport => 'استيراد نسخة استرداد';

  @override
  String get scheduledRecoveryImportHint =>
      'احفظ هذه المعاينة كنسخة استرداد فقط. لن تتم جدولة أي رسائل أو إرسالها. المرفقات غير مضمنة. لم يتم التحقق من مؤلف الملف.';

  @override
  String get scheduledRecoveryComposerHint =>
      'أضف النص إلى المسودة الحالية لمراجعته. لن تُرسل أي رسالة. لن تُستعاد المرفقات أو الإشارات أو المؤقتات. تحقق مما إذا كانت هذه الرسالة قد وصلت بالفعل.';

  @override
  String get backupRecoverLegacyArchive => 'استعادة السجل المحلي القديم';

  @override
  String get backupLegacyArchiveWarning =>
      'لم يتم التحقق من مالك هذا السجل. انسخ غرفك فقط إلى الحساب أدناه. سيُحتفظ بالأصل.';

  @override
  String get backupOlderFiles => 'ملفات النسخ الاحتياطي القديمة';

  @override
  String get backupOlderFilesWarning =>
      'قد تنتمي هذه الملفات إلى حساب آخر. اختر ملفًا للتحقق من محتواه ومالكه قبل الاستعادة.';

  @override
  String get stickerImportTitle => 'استيراد حزمة ملصقات';

  @override
  String get stickerImportLinkHint => 'رابط حزمة ملصقات Matrix';

  @override
  String get stickerImportPreview => 'معاينة';

  @override
  String get stickerImportUnavailable =>
      'هذه الحزمة غير متاحة أو ليس لديك إذن للوصول إليها.';

  @override
  String get stickerImportCopyNotice =>
      'أضف نسخة خاصة من هذه الحزمة. الصور والبيانات الوصفية فيها غير مشفرة من طرف إلى طرف.';

  @override
  String get stickerImportFailed => 'تعذرت إضافة هذه الحزمة. حاول مرة أخرى.';

  @override
  String get stickerImportAccountChanged =>
      'تم تغيير الحساب أو انتهت الجلسة. أعد فتح استيراد الملصقات.';

  @override
  String get stickerPackSourceRoom => 'المحادثة المصدر';

  @override
  String get stickerPackImages => 'الصور';

  @override
  String get stickerPublishNotice =>
      'انشر حزمة الملصقات هذه في المجموعة المحددة. صورها وبياناتها الوصفية غير مشفرة من طرف إلى طرف. قد يتمكن من يستطيع قراءة حالة المجموعة من الوصول إليها.';

  @override
  String get stickerPublishFailed =>
      'لم يتم تأكيد النشر. تحقق من المجموعة قبل المحاولة مجددًا.';

  @override
  String get stickerPublishReceiptMissing =>
      'تم النشر، لكن لم يتم حفظ الرابط. شاركه أو انسخه قبل مغادرة هذه الصفحة.';

  @override
  String get stickerSubscribe => 'الاشتراك في التحديثات';

  @override
  String get stickerSubscribeNotice =>
      'متابعة التغييرات المستقبلية التي يجريها مسؤولو هذه الحزمة. الصور والبيانات الوصفية ليست مشفرة من طرف إلى طرف. يمكنك إلغاء الاشتراك لاحقًا؛ لن تنضم إلى المحادثة المصدر.';

  @override
  String get stickerSubscriptions => 'اشتراكات الملصقات';

  @override
  String get stickerUnsubscribe => 'إلغاء الاشتراك';

  @override
  String get stickerSubscriptionsEmpty => 'لا توجد اشتراكات ملصقات';

  @override
  String get chatAttachmentEvent => 'حدث';

  @override
  String get chatRecentMedia => 'الصور ومقاطع الفيديو الحديثة';

  @override
  String get chatRecentMediaLoadFailed => 'تعذر تحميل الوسائط الحديثة';

  @override
  String get chatRecentMediaPermission =>
      'يلزم السماح بالوصول إلى الصور لعرض الوسائط الحديثة';

  @override
  String get chatRecentMediaEmpty => 'لا توجد صور أو مقاطع فيديو حديثة';

  @override
  String get chatRecentPhoto => 'صورة حديثة';

  @override
  String get chatRecentVideo => 'فيديو حديث';

  @override
  String get chatAttachmentTip => 'إكرامية';

  @override
  String get chatAttachmentWhiteboard => 'لوحة بيضاء';

  @override
  String get chatAttachmentVideoNote => 'رسالة فيديو';

  @override
  String get chatAttachmentCode => 'شفرة برمجية';

  @override
  String get chatAttachmentShop => 'متجر';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'الحد الأقصى للاختيار: $countString';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return 'الليلة ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return 'صباح الغد ($time)';
  }

  @override
  String get a11yScrollToBottom => 'التمرير إلى الأسفل';

  @override
  String get ui3EnterMessageBeforeScheduling => 'أدخل رسالة قبل الجدولة';

  @override
  String get ui3SendCode => 'إرسال شيفرة';

  @override
  String get ui3CodeLanguage => 'اللغة';

  @override
  String get ui3PasteCodeHere => 'الصق الشيفرة هنا';

  @override
  String ui3ReminderSetAt(String time) {
    return 'تم ضبط التذكير · $time';
  }

  @override
  String get ui3RedPacketCreateFailed => 'تعذّر إنشاء الظرف الأحمر';

  @override
  String get ui3SendTip => 'إرسال إكرامية';

  @override
  String get ui3TokenLabel => 'الرمز المميز';

  @override
  String get ui3NoteOptional => 'ملاحظة (اختيارية)';

  @override
  String ui3TipFailed(String error) {
    return 'فشلت الإكرامية: $error';
  }

  @override
  String get ui3GiftNftTitle => 'إهداء NFT';

  @override
  String get ui3TokenId => 'معرّف الرمز المميز';

  @override
  String ui3NftGiftFailed(String error) {
    return 'فشل إهداء NFT: $error';
  }

  @override
  String get ui3AiAgentSubtitle => 'صِف مهمة، وافتح التطبيق المصغّر المناسب';

  @override
  String get ui3GiftNft => 'إهداء NFT';

  @override
  String get ui3GiftNftSubtitle => 'أرسل NFT إلى جهة الاتصال هذه';

  @override
  String get ui3MiniAppUnavailable => 'التطبيق المصغّر غير متاح';

  @override
  String ui3MediaItemsNotSent(int count) {
    return 'تعذّر إرسال $count من الوسائط المحددة';
  }

  @override
  String get ui3PhotosSubtitle =>
      'أرسل الصور ومقاطع الفيديو بتنسيق مناسب للدردشة';

  @override
  String get ui3OriginalImages => 'الصور الأصلية';

  @override
  String get ui3OriginalImagesSubtitle => 'أرسل الصور غير المضغوطة كملفات';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return 'تمت جدولة $filename في $time';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return 'جارٍ إرسال الصورة الأصلية: $filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return 'تمت جدولة الصورة الأصلية: $filename';
  }

  @override
  String get ui3PaymentAlreadySent => 'تم إرسال الدفعة بالفعل';

  @override
  String get ui3PaymentProcessing => 'جارٍ معالجة الدفعة';

  @override
  String ui3ChainStatus(String status) {
    return 'الحالة على السلسلة: $status';
  }

  @override
  String get ui3NotChecked => 'لم يتم التحقق';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return 'مؤكَّد: $confirmations / $required كتل';
  }

  @override
  String get ui3CopyTxHash => 'نسخ تجزئة المعاملة';

  @override
  String get ui3VerifyAgain => 'التحقق مجددًا';

  @override
  String get ui3VerifyOnChain => 'التحقق على السلسلة';

  @override
  String get ui3TransferMissingChainDetails =>
      'لا يتضمن هذا التحويل تفاصيل دقيقة عن السلسلة والأصل.';

  @override
  String get ui3ReceiptPending => 'قيد الانتظار على السلسلة';

  @override
  String get ui3ReceiptConfirmed => 'مؤكَّد';

  @override
  String get ui3ReceiptFailed => 'فشل على السلسلة';

  @override
  String get ui3ReceiptMismatch => 'تفاصيل المعاملة غير متطابقة';

  @override
  String get ui3ReceiptUnsupported => 'التحقق على السلسلة غير مدعوم';

  @override
  String get ui3ReceiptUnavailable => 'التحقق غير متاح';

  @override
  String get ui3OpenOrSave => 'فتح / حفظ';

  @override
  String get ui3UnableToOpenFile => 'تعذّر فتح هذا الملف.';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'فشلت إعادة الصياغة بالذكاء الاصطناعي: $error';
  }

  @override
  String get ui3AiShareMessagesTitle => 'مشاركة الرسائل مع الذكاء الاصطناعي؟';

  @override
  String get ui3AiShareMessagesBody =>
      'حدّد الرسائل التي يمكن للذكاء الاصطناعي استخدامها لهذا الرد. تنتهي صلاحية هذه الموافقة لطلب واحد بعد دقيقتين. يؤدي إغلاق الرد السريع إلى إلغاء النتائج المعلّقة. ولا تسمح هذه الموافقة بالمدفوعات أو التصدير.';

  @override
  String get ui3OtherParticipant => 'الطرف الآخر';

  @override
  String get ui3ShareSelected => 'مشاركة المحدد';

  @override
  String get ui3BotCommandError => 'خطأ في الأمر';

  @override
  String get ui3BotUnknownCommand => 'أمر غير معروف';

  @override
  String get ui3BotTypeHelp => 'اكتب /help لعرض الأوامر المتاحة.';

  @override
  String get ui3FilesMediaLinks => 'الملفات والوسائط والروابط';

  @override
  String get ui3ChatStorage => 'تخزين الدردشة';

  @override
  String get ui3EncryptionKeysDevices => 'مفاتيح التشفير والأجهزة';

  @override
  String get ui3EncryptionServiceUnavailable => 'خدمة التشفير غير متاحة بعد';

  @override
  String get ui3ExportLoadingHistory =>
      'جارٍ تحميل المزيد من سجل الدردشة للتصدير...';

  @override
  String get ui3ExportTxtDesc =>
      'نص عادي للملاحظات أو النسخ الاحتياطي أو مراجعة الامتثال';

  @override
  String get ui3ExportCustomRange => 'نطاق مخصص';

  @override
  String get ui3ExportStart => 'البداية';

  @override
  String get ui3ExportEnd => 'النهاية';

  @override
  String get ui3ExportSelectDate => 'اختر التاريخ';

  @override
  String get ui3FolderFilterUnreadOnly => 'غير المقروءة فقط';

  @override
  String get ui3FolderFilterMutedOnly => 'المكتومة فقط';

  @override
  String get ui3FolderFilterNoDms => 'بدون رسائل خاصة';

  @override
  String get ui3FolderFilterNoGroups => 'بدون مجموعات';

  @override
  String get ui3FolderFilterNoChannels => 'بدون قنوات';

  @override
  String get ui3FolderFilterAllChats => 'كل الدردشات';

  @override
  String get ui3Create => 'إنشاء';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return 'حذف المجلد \"$name\"؟';
  }

  @override
  String get a11yDecreaseTextSize => 'تصغير حجم النص';

  @override
  String get a11yIncreaseTextSize => 'تكبير حجم النص';

  @override
  String ui3MinutesRead(int minutes) {
    return '$minutes دقيقة للقراءة';
  }

  @override
  String get ui3TipOnChain => 'على السلسلة ✓';

  @override
  String get ui3ViewSource => 'عرض المصدر';

  @override
  String get a11yPreviousPage => 'الصفحة السابقة';

  @override
  String get a11yNextPage => 'الصفحة التالية';

  @override
  String get ui3OpenExternalLinkTitle => 'فتح رابط خارجي؟';

  @override
  String get ui3Open => 'فتح';

  @override
  String get ui3UnableToOpenLink => 'تعذّر فتح هذا الرابط.';

  @override
  String get ui3ImageUnavailable => 'الصورة غير متاحة';

  @override
  String ui3LoadImageFrom(Object host) {
    return 'تحميل الصورة من $host';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return 'إعادة تحميل الصورة من $host';
  }

  @override
  String get ui3TranslatedByN42 => 'تُرجمت بواسطة N42';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return 'ترجمها N42 من $language';
  }

  @override
  String get ui3ClearWhiteboardTitle => 'مسح السبورة؟';

  @override
  String get ui3ClearWhiteboardMessage =>
      'ستُزال جميع الخطوط لدى الجميع. لا يمكن التراجع عن ذلك.';

  @override
  String get ui3WhiteboardLive => 'السبورة · مباشر';

  @override
  String get a11yPenColor => 'لون القلم';

  @override
  String get ui3AiDescribeOcr => 'وصف بالذكاء الاصطناعي / OCR';

  @override
  String get ui3DocumentPreviewFailed =>
      'تعذّرت معاينة هذا المستند بأمان. تحقّق من الاتصال وحجم الملف (2MB كحد أقصى).';

  @override
  String get ui3AiConsentMessage =>
      'حدّد الرسائل التي يمكن للذكاء الاصطناعي استخدامها لهذا الملخص. تنتهي صلاحية هذه الموافقة لطلب واحد بعد دقيقتين. ولا تسمح بالمدفوعات أو التصدير.';

  @override
  String get ui3AiSuggestedReplies => 'ردود مقترحة';

  @override
  String get ui3AiGeneratingSuggestions => 'جارٍ إنشاء الاقتراحات...';

  @override
  String get ui3StickersEmpty => 'لا توجد ملصقات بعد';

  @override
  String get ui3StickersGet => 'الحصول على ملصقات';

  @override
  String get a11yFormatBold => 'غامق';

  @override
  String get a11yFormatItalic => 'مائل';

  @override
  String get a11yFormatStrikethrough => 'يتوسطه خط';

  @override
  String get a11yFormatInlineCode => 'شيفرة مضمّنة';

  @override
  String get a11yFormatCodeBlock => 'كتلة تعليمات برمجية';

  @override
  String get a11yFormatChecklistItem => 'عنصر قائمة مهام';

  @override
  String get a11yFormatBulletList => 'قائمة نقطية';

  @override
  String get a11yFormatNumberedList => 'قائمة مرقّمة';

  @override
  String get a11yFormatLink => 'رابط';

  @override
  String get a11yFormatTable => 'جدول';

  @override
  String get a11yFormatMeetingTemplate => 'قالب اجتماع';

  @override
  String get a11yEmojiSmileys => 'الوجوه والأشخاص';

  @override
  String get a11yEmojiHearts => 'القلوب';

  @override
  String get a11yEmojiAnimals => 'الحيوانات والطبيعة';

  @override
  String get a11yEmojiFood => 'الطعام والشراب';

  @override
  String get a11yEmojiTravel => 'السفر والأماكن';

  @override
  String get a11yEmojiActivities => 'الأنشطة';

  @override
  String get a11yEmojiObjects => 'الأشياء';

  @override
  String get a11yEmojiSymbols => 'الرموز';

  @override
  String get ui3FrequentlyUsed => 'الأكثر استخدامًا';

  @override
  String get ui3NoEditHistory => 'لا يوجد سجل تعديلات';

  @override
  String get ui3EventNew => 'حدث جديد';

  @override
  String get ui3EventTitleLabel => 'العنوان';

  @override
  String get ui3EventLocationOptional => 'الموقع (اختياري)';

  @override
  String get ui3EventDescriptionOptional => 'الوصف (اختياري)';

  @override
  String get ui3EventSend => 'إرسال الحدث';

  @override
  String get ui3EventTitleRequired => 'العنوان مطلوب';

  @override
  String get ui3EventEndAfterStart => 'يجب أن يكون وقت الانتهاء بعد وقت البدء';

  @override
  String get ui3MiniAppAgentIntro =>
      'صِف ما تريد فعله وسأفتح التطبيق المصغّر المناسب.';

  @override
  String get ui3MiniAppAgentExample => 'مثال: مبادلة ETH إلى USDC';

  @override
  String get ui3MiniAppAgentNoMatch =>
      'لم يُعثر على تطبيق مصغّر مطابق. جرّب صياغة أخرى.';

  @override
  String ui3MiniAppOpen(Object appName) {
    return 'فتح $appName';
  }

  @override
  String get ui3MusicLinkPlatforms =>
      'يدعم روابط الأغاني من NetEase Cloud Music وQQ Music وKugou وKuwo وغيرها';

  @override
  String get ui3PollMarkCorrectAnswer => 'حدّد إجابة صحيحة غير فارغة';

  @override
  String get ui3PollQuizMode => 'وضع الاختبار';

  @override
  String get ui3PollAnswerExplanationHint => 'شرح الإجابة (اختياري)';

  @override
  String get a11yCorrectAnswer => 'الإجابة الصحيحة';

  @override
  String get ui3AiSuggestions => 'اقتراحات الذكاء الاصطناعي';

  @override
  String get a11yPaste => 'لصق';

  @override
  String get a11yRefresh => 'تحديث';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      'احفظ هذا المفتاح في مكان آمن. إنه الطريقة الوحيدة لاستعادة رسائلك المشفّرة إذا فقدت الوصول إلى جميع أجهزتك.';

  @override
  String ui3SavedToPath(Object path) {
    return 'تم الحفظ: $path';
  }

  @override
  String get ui3UnknownAccount => 'حساب غير معروف';

  @override
  String get ui3UnknownHomeserver => 'خادم رئيسي غير معروف';

  @override
  String get ui3ImportRecoveryKey => 'استيراد مفتاح الاسترداد';

  @override
  String get ui3ImportRecoveryKeyDesc =>
      'أدخل مفتاح الاسترداد أو الصقه لاستعادة مفاتيح الغرف لسجل الرسائل المشفّرة.';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return 'الحساب: $account\\nالخادم الرئيسي: $homeserver';
  }

  @override
  String get ui3Import => 'استيراد';

  @override
  String get ui3InvalidRecoveryKeyFormat => 'تنسيق مفتاح الاسترداد غير صالح';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return 'تمت استعادة $restored من أصل $total مفتاح. فشل $failed مفتاح. تحقّق من الحساب والشبكة والنسخة الاحتياطية ثم أعد المحاولة. قد يبقى جزء من السجل غير قابل للقراءة.';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return 'تمت استعادة $restored من أصل $total مفتاح بنجاح';
  }

  @override
  String ui3ImportFailed(Object error) {
    return 'فشل الاستيراد: $error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return 'فشل تسجيل مفتاح المرور: $error';
  }

  @override
  String get ui3PasskeyDefaultName => 'مفتاح المرور الخاص بي';

  @override
  String get ui3PasskeyNameHint => 'مثال: iPhone، MacBook';

  @override
  String get ui3PasskeyDeleteFailed => 'تعذّر حذف مفتاح المرور';

  @override
  String get ui3TwoFactorAuth => 'المصادقة الثنائية';

  @override
  String get ui3TwoFactorOnSubtitle => 'مفعّلة — يلزم رمز من تطبيق المصادقة';

  @override
  String get ui3TwoFactorOffSubtitle =>
      'معطّلة — احمِ حسابك بتطبيق مصادقة (TOTP)';

  @override
  String get ui3ShowRecoveryKey => 'عرض مفتاح الاسترداد';

  @override
  String get ui3ShowRecoveryKeyDesc => 'اعرض مفتاح الاسترداد لنسخه احتياطيًا';

  @override
  String get ui3ImportRecoveryKeyHint =>
      'استعادة الرسائل باستخدام مفتاح الاسترداد';

  @override
  String get ui3RecoveryKeyCreateFailed => 'تعذّر إنشاء مفتاح الاسترداد';

  @override
  String get ui3TotpIncorrectCode => 'رمز غير صحيح، حاول مرة أخرى';

  @override
  String get ui3TwoFactorEnabled => 'تم تفعيل المصادقة الثنائية';

  @override
  String get ui3TwoFactorDisabled => 'تم تعطيل المصادقة الثنائية';

  @override
  String get ui3TwoFactorTurnOffTitle => 'هل تريد إيقاف المصادقة الثنائية؟';

  @override
  String get ui3TwoFactorTurnOffMessage =>
      'لن يكون تطبيق المصادقة مطلوبًا بعد الآن. يمكنك إعداده مجددًا لاحقًا بمفتاح جديد.';

  @override
  String get ui3TurnOff => 'إيقاف';

  @override
  String get ui3TwoFactorTotpTitle => 'المصادقة الثنائية (TOTP)';

  @override
  String get ui3TwoFactorIsOn => 'المصادقة الثنائية مفعّلة';

  @override
  String get ui3TwoFactorCodeRequired => 'يلزم رمز من تطبيق المصادقة.';

  @override
  String get ui3TotpStepScan =>
      '1. امسح رمز QR هذا بتطبيق مصادقة (Google Authenticator أو Authy أو 1Password…) أو أدخل المفتاح يدويًا.';

  @override
  String get ui3TotpKeyCopied => 'تم نسخ المفتاح';

  @override
  String get ui3TotpStepConfirm => '2. أدخل الرمز المكوّن من 6 أرقام للتأكيد.';

  @override
  String get ui3Enable => 'تفعيل';

  @override
  String get ui3BackupSettingsDesc =>
      'انسخ إعدادات الدردشة المحلية احتياطيًا. ستُستعاد الرسائل من الخادم بعد تسجيل الدخول مجددًا.';

  @override
  String get ui3BackupKeysSeparate => 'تُدار مفاتيح التشفير بشكل منفصل';

  @override
  String get ui3BackupKeysSeparateHint =>
      'استخدم الأمان > مفتاح الاسترداد لنسخ الوصول إلى الرسائل المشفّرة احتياطيًا.';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return '$rooms غرفة  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      'استورد ملف .n42backup من جهاز آخر أو من نسخة احتياطية سابقة. تُستعاد مفاتيح التشفير بشكل منفصل باستخدام مفتاح الاسترداد.';

  @override
  String get ui3UsernameSessionRequired => 'يتطلب اسم المستخدم جلسة نشطة';

  @override
  String get ui3SecuritySessionRequired => 'تتطلب إعدادات الأمان جلسة نشطة';

  @override
  String get ui3ConnectedAccountsSessionRequired =>
      'تتطلب الحسابات المرتبطة جلسة نشطة';

  @override
  String get ui3SystemAccounts => 'النظام والحسابات';

  @override
  String get ui3AccountIdentity => 'الحساب والهوية';

  @override
  String get ui3Accounts => 'الحسابات';

  @override
  String get ui3DevicesSessions => 'الأجهزة والجلسات';

  @override
  String get ui3Integrations => 'عمليات التكامل';

  @override
  String get ui3ConnectedAccounts => 'الحسابات المرتبطة';

  @override
  String get ui3ConnectedAccountsDesc =>
      'تكامل Telegram وWhatsApp وDiscord وجسور API';

  @override
  String get ui3SystemOverview => 'نظرة عامة على النظام';

  @override
  String ui3AccountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حساب',
      many: '$count حسابًا',
      few: '$count حسابات',
      two: 'حسابان',
      one: 'حساب واحد',
      zero: 'لا حسابات',
    );
    return '$_temp0';
  }

  @override
  String ui3DeviceCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count جهاز',
      many: '$count جهازًا',
      few: '$count أجهزة',
      two: 'جهازان',
      one: 'جهاز واحد',
      zero: 'لا أجهزة',
    );
    return '$_temp0';
  }

  @override
  String get ui3PrivacySecurityOverview =>
      'التشفير التام بين الطرفين، والحماية من لقطات الشاشة، والتحكم في الوكيل';

  @override
  String get ui3ConversationPrivacy => 'خصوصية المحادثات';

  @override
  String get ui3NetworkPrivacy => 'خصوصية الشبكة';

  @override
  String get ui3IdentityPrivacy => 'خصوصية الهوية';

  @override
  String get ui3EncryptionKeyBackup => 'التشفير والنسخ الاحتياطي للمفاتيح';

  @override
  String get ui3DevicesVerification => 'الأجهزة والتحقق';

  @override
  String get ui3ChipE2eeDefault => 'E2EE افتراضيًا';

  @override
  String get ui3ChipManualE2ee => 'E2EE يدويًا';

  @override
  String get ui3ChipSelfDestruct => 'التدمير الذاتي';

  @override
  String get ui3ChipScreenshotGuard => 'حماية لقطة الشاشة';

  @override
  String get ui3ChipIpProxy => 'IP / الوكيل';

  @override
  String get ui3ChipLinkPreviewsOff => 'معاينات الروابط متوقفة';

  @override
  String get ui3ChipPublicHandle => 'اسم المستخدم العام';

  @override
  String get a11yShowPassword => 'إظهار كلمة المرور';

  @override
  String get a11yHidePassword => 'إخفاء كلمة المرور';

  @override
  String get a11yCheckServer => 'التحقق من الخادم';

  @override
  String get ui3AuthAnonymousRegistration => 'التسجيل المجهول';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      'أنشئ حسابًا دون ربط رقم هاتف أو بريد إلكتروني. سيتم إنشاء اسم مستخدم تلقائيًا.';

  @override
  String get ui3AuthAnonymousModeOn => 'الوضع المجهول مفعّل';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      'سينشئ التطبيق اسم مستخدم Matrix عشوائيًا لك. يمكنك لاحقًا تسجيل الدخول بالحساب وكلمة المرور اللذين تم إنشاؤهما.';

  @override
  String get ui3AuthChooseLoginMethod => 'اختر طريقة تسجيل الدخول';

  @override
  String get ui3AuthSsoOpenFailed => 'تعذّر فتح صفحة تسجيل الدخول عبر SSO';

  @override
  String get ui3AuthWalletUnavailable => 'المحفظة غير متاحة';

  @override
  String get ui3ProfileSubscriptions => 'الاشتراكات';

  @override
  String get ui3ProfileBuySellCrypto => 'شراء / بيع العملات المشفرة';

  @override
  String get ui3ProfileOnDeviceAi => 'الذكاء الاصطناعي على الجهاز';

  @override
  String get ui3ProfileSetAUsername => 'تعيين اسم مستخدم';

  @override
  String get ui3ProfileAvatarStudio => 'استوديو الصورة الرمزية';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'صورة رمزية NFT / زخارف';

  @override
  String get ui3ProfileCustomize => 'تخصيص';

  @override
  String get ui3ProfileQrSubtitle =>
      'امسح الرمز لفتح هذا الملف الشخصي أو بدء محادثة';

  @override
  String get ui3PrivacyHardening => 'تعزيز الخصوصية';

  @override
  String get ui3HidePhoneNumber => 'إخفاء رقم الهاتف';

  @override
  String get ui3HidePhoneNumberDesc =>
      'إخفاء أي رقم هاتف مرتبط في صفحات الملف الشخصي على هذا الجهاز';

  @override
  String get ui3EncryptNewChatsByDefault => 'تشفير المحادثات الجديدة افتراضيًا';

  @override
  String get ui3EncryptNewChatsByDefaultDesc =>
      'بدء المحادثات المباشرة والغرف الخاصة الجديدة مع تفعيل التشفير التام بين الطرفين (E2EE)';

  @override
  String get ui3PrivateChatMode => 'وضع المحادثة الخاصة';

  @override
  String get ui3PrivateChatModeDesc =>
      'تفعيل منع لقطات الشاشة مؤقتًا عند عرض المحادثات الخاصة أو المشفرة';

  @override
  String get ui3DefaultSelfDestructTimer => 'مؤقت التدمير الذاتي الافتراضي';

  @override
  String get ui3DefaultSelfDestructTimerDesc =>
      'تطبيق مؤقت تدمير ذاتي افتراضي على الرسائل المرسلة حديثًا';

  @override
  String get ui3LinkPreviews => 'معاينات الروابط';

  @override
  String get ui3LinkPreviewsDesc =>
      'جلب العناوين والأوصاف والصور المصغرة عندما تحتوي الرسائل على روابط';

  @override
  String get ui3IpAddressProtection => 'حماية عنوان IP';

  @override
  String get ui3IpAddressProtectionDesc =>
      'توجيه طلبات Matrix ومعاينات الروابط عبر وكيل HTTP للخصوصية الذي أعددته عند توفره';

  @override
  String get ui3UseTorProxy => 'استخدام وكيل HTTP لـ Tor / Privoxy';

  @override
  String get ui3UseTorProxyDesc =>
      'استخدم نقطة نهاية وكيل HTTP محلية مثل Privoxy على 127.0.0.1:8118. توجيه Tor الأصلي عبر SOCKS5 غير مدعوم هنا.';

  @override
  String get ui3CustomProxy => 'وكيل مخصص';

  @override
  String get ui3CustomProxyDesc =>
      'استخدام وكيل HTTP أو HTTPS مخصص لحركة بيانات Matrix ومعاينات الروابط';

  @override
  String get ui3ProxyEndpoint => 'عنوان الوكيل';

  @override
  String get ui3ProxyEndpointDesc => 'عنوان وكيل HTTP/HTTPS (لا يدعم SOCKS)';

  @override
  String get ui3InvalidEndpoint => 'عنوان غير صالح';

  @override
  String get ui3CustomProxyStaysOff =>
      'يبقى الوكيل المخصص متوقفًا حتى تعيّن عنوانًا صالحًا';

  @override
  String get ui3NotificationFilterNote =>
      'قواعد الأولوية ترسل إشعارات دائمًا (متجاوزةً الكتم والإشارات فقط ووضع عدم الإزعاج). الكلمات المكتومة تمنع الإشعارات.';

  @override
  String get ui3PriorityKeywords => 'كلمات ذات أولوية';

  @override
  String get ui3PriorityKeywordHint => 'مثال: عاجل';

  @override
  String get ui3MutedKeywords => 'كلمات مكتومة';

  @override
  String get ui3MutedKeywordHint => 'مثال: سبام';

  @override
  String get ui3PrioritySenders => 'مرسلون ذوو أولوية';

  @override
  String get ui3CaseSensitive => 'مطابقة حالة الأحرف';

  @override
  String get ui3None => 'لا شيء';

  @override
  String get ui3SmartReplyTranslation => 'ترجمة الردود الذكية';

  @override
  String get ui3SmartReplyTranslationDesc =>
      'ترجمة رسائلك تلقائيًا إلى لغة المستلم قبل الإرسال.';

  @override
  String get ui3FromPhotos => 'من الصور';

  @override
  String get ui3ChangePhoto => 'تغيير الصورة';

  @override
  String get ui3RoamingUsesMobileData => 'التجوال يتبع قواعد بيانات الجوال';

  @override
  String get ui3RoamingUsesMobileDataDesc =>
      'الكشف المستقل عن التجوال غير متاح بعد، لذا يتبع التجوال حاليًا إعدادات التنزيل التلقائي لبيانات الجوال.';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return 'حذف \"$content\"؟';
  }

  @override
  String get ui3ResetToDefaults => 'استعادة الإعدادات الافتراضية';

  @override
  String get ui3ResetQuickRepliesMessage =>
      'سيؤدي هذا إلى إزالة جميع الردود السريعة المخصصة واستعادة الافتراضية. هل تريد المتابعة؟';

  @override
  String get ui3LocalLlmUnavailable => 'غير مدعوم على هذا الجهاز';

  @override
  String get ui3LocalLlmNotDownloaded => 'النموذج غير مُنزَّل';

  @override
  String get ui3LocalLlmReady => 'جاهز (على الجهاز)';

  @override
  String get ui3LocalLlmDescription =>
      'عند التفعيل والجاهزية، تعمل ميزات الذكاء الاصطناعي (التلخيص، إعادة الصياغة، الترجمة، الردود) بالكامل على الجهاز — ولا تغادر بياناتك هاتفك أبدًا. وإلا فإنها تستخدم مزود الخدمة السحابية.';

  @override
  String get ui3UseOnDeviceAi => 'استخدام الذكاء الاصطناعي على الجهاز';

  @override
  String get ui3UseOnDeviceAiDesc => 'تفضيل المعالجة المحلية عند الجاهزية';

  @override
  String get ui3DownloadModel => 'تنزيل النموذج';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      'تتطلب المعالجة على الجهاز بيئة تشغيل أصلية (Android MediaPipe / iOS Core ML). سيتم تفعيلها تلقائيًا بمجرد توفر معالج المنصة.';

  @override
  String get ui3PhotoAvatar => 'صورة رمزية من صورة';

  @override
  String get ui3AvatarStyles => 'أنماط الصورة الرمزية';

  @override
  String get ui3AvatarStylesDesc =>
      'استخدام محدد زخارف واحد للملف الشخصي ونقاط دخول الصورة الرمزية.';

  @override
  String get ui3ReplaceNftAvatar => 'استبدال صورة NFT الرمزية';

  @override
  String get ui3NftAvatarDesc => 'استخدم مقتنى على السلسلة كصورتك الرمزية.';

  @override
  String get ui3UsePhotoAvatar => 'استخدام صورة رمزية من صورة';

  @override
  String get ui3UsePhotoAvatarDesc =>
      'الاحتفاظ بالصورة الرمزية التي رفعتها وإلغاء ربط NFT.';

  @override
  String ui3AvatarStyleSet(Object name) {
    return 'تم تعيين نمط الصورة الرمزية إلى: $name';
  }

  @override
  String get ui3NftAvatarUpdated => 'تم تحديث صورة NFT الرمزية';

  @override
  String get ui3SwitchedToPhotoAvatar => 'تم الرجوع إلى الصورة الرمزية من صورة';

  @override
  String get ui3SignInToViewRedPacketHistory =>
      'سجّل الدخول لعرض سجل المغلفات الحمراء';

  @override
  String get ui3RedPacketActive => 'نشط';

  @override
  String get ui3RedPacketCompleted => 'مكتمل';

  @override
  String get ui3CardsAndPasses => 'البطاقات والتذاكر';

  @override
  String get ui3CardsAndPassesDesc =>
      'تتم إدارة بطاقات المحفظة والقسائم والتذاكر من التطبيق الرئيسي.';

  @override
  String get ui3CardPackRequiresMainApp =>
      'حزمة البطاقات تتطلب التطبيق الرئيسي';

  @override
  String get ui3OpenCardPack => 'فتح حزمة البطاقات';

  @override
  String get ui3UnableToOpenChat => 'تعذّر فتح محادثة مع جهة الاتصال هذه';

  @override
  String get ui3WalletManagedInMainApp =>
      'تتم إدارة المحفظة من التطبيق الرئيسي';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · الخطط';
  }

  @override
  String get ui3NewPlan => 'خطة جديدة';

  @override
  String get ui3MySubscriptions => 'اشتراكاتي';

  @override
  String get ui3AvailablePlans => 'الخطط المتاحة';

  @override
  String get ui3NoPlansYet =>
      'لا توجد خطط بعد · اضغط \"خطة جديدة\" لإنشاء واحدة';

  @override
  String ui3DaysLeft(Object days) {
    return 'متبقٍ $days يوم';
  }

  @override
  String get ui3SubscriptionCancelled => 'ملغى';

  @override
  String get ui3AutoRenewOn => 'التجديد التلقائي: مفعّل';

  @override
  String get ui3AutoRenewOff => 'التجديد التلقائي: متوقف';

  @override
  String get ui3CancelSubscriptionTitle => 'إلغاء الاشتراك؟';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return 'سيظل اشتراكك في $name نشطًا حتى انتهاء صلاحيته ولن يتم تجديده.';
  }

  @override
  String get ui3Subscribe => 'اشتراك';

  @override
  String ui3SubscribedTo(Object name) {
    return 'تم الاشتراك في $name';
  }

  @override
  String get ui3PlanPriceLabel => 'السعر (مثل 9.9 USDT)';

  @override
  String get ui3PlanDescriptionLabel => 'الوصف (اختياري)';

  @override
  String get ui3PlanBenefitsLabel => 'المزايا (مفصولة بفواصل)';

  @override
  String get ui3PlanPeriod => 'المدة:';

  @override
  String get ui3Monthly => 'شهريًا';

  @override
  String get ui3Yearly => 'سنويًا';

  @override
  String get ui3SaveRemarkFailed => 'تعذّر حفظ الملاحظة';

  @override
  String get ui3CopyLink => 'نسخ الرابط';

  @override
  String get ui3Connect => 'تواصل';

  @override
  String get ui3CommonTokens => 'رموز مشتركة';

  @override
  String get ui3SharedNfts => 'رموز NFT مشتركة';

  @override
  String get ui3TransactionHistory => 'سجل المعاملات';

  @override
  String get ui3CommonDaos => 'منظمات DAO مشتركة';

  @override
  String get ui3SameChains => 'نفس الشبكات';

  @override
  String get ui3ChatInitFailed => 'تعذّر تهيئة الدردشة';

  @override
  String get ui3CheckNetworkRetry =>
      'يُرجى التحقق من اتصالك بالشبكة والمحاولة مرة أخرى';

  @override
  String get ui3FromContacts => 'من جهات الاتصال';

  @override
  String get ui3FindFriendsFromContacts => 'ابحث عن أصدقاء من جهات اتصال هاتفك';

  @override
  String get ui3EnsOrDomain => 'ENS / نطاق';

  @override
  String get ui3LoadingContacts => 'جارٍ تحميل جهات الاتصال...';

  @override
  String get ui3ContactsPermissionRequired =>
      'يلزم إذن الوصول إلى جهات الاتصال';

  @override
  String get ui3ContactsPermissionMessage =>
      'للعثور على أصدقاء من جهات اتصالك، يُرجى السماح بالوصول إليها.';

  @override
  String get ui3AllowAccess => 'السماح بالوصول';

  @override
  String get ui3NoContactMatches => 'لم يتم العثور على نتائج مطابقة';

  @override
  String get ui3NoContactMatchesMessage =>
      'لا أحد من جهات اتصالك يستخدم هذا التطبيق بعد. ادعهم للانضمام!';

  @override
  String ui3ScannedContacts(Object count) {
    return 'تم فحص $count جهة اتصال';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return 'تم العثور على $count تطابقًا في جهات اتصالك';
  }

  @override
  String ui3InContactsAs(Object name) {
    return 'في جهات الاتصال: $name';
  }

  @override
  String get ui3DeletePhotoConfirm => 'حذف هذه الصورة؟';

  @override
  String get ui3InviteLink => 'رابط الدعوة';

  @override
  String get ui3ShareJoinLink => 'شارك رابط الانضمام إلى هذه الغرفة';

  @override
  String get ui3ShareRoomReference => 'شارك مرجع الغرفة مع الأعضاء المدعوين';

  @override
  String get ui3ScanToJoinGroup =>
      'امسح الرمز للانضمام إلى هذه المجموعة مباشرةً';

  @override
  String get ui3ScanToShareRoomReference =>
      'امسح الرمز لمشاركة مرجع هذه الغرفة مع الأعضاء المدعوين';

  @override
  String get ui3InviteLinkLoadFailed => 'تعذّر تحميل رابط الدعوة';

  @override
  String get ui3InviteLinkCopied => 'تم نسخ رابط الدعوة';

  @override
  String get ui3ChannelCategoryOptional => 'الفئة (اختياري)';

  @override
  String get ui3ChannelCategoryHint => 'إعلانات / المنتج / الدعم';

  @override
  String get ui3DescriptionOptional => 'الوصف (اختياري)';

  @override
  String get ui3WebhookEnable => 'تفعيل أتمتة webhook';

  @override
  String get ui3WebhookEnableDesc =>
      'أرسل أحداث انضمام الأعضاء والترحيب إلى نقطة نهاية التكامل الخاصة بك.';

  @override
  String get ui3WebhookUrl => 'عنوان URL لـ webhook';

  @override
  String get ui3WebhookSecretOptional => 'سر التوقيع (اختياري)';

  @override
  String get ui3WebhookSecretHint => 'يُستخدم لـ X-N42-Signature';

  @override
  String get ui3WebhookNotifyMemberJoined => 'الإشعار عند انضمام عضو';

  @override
  String get ui3WebhookNotifyWelcomeSent => 'الإشعار عند إرسال رسالة الترحيب';

  @override
  String get ui3WebhookTestSend => 'إرسال webhook تجريبي';

  @override
  String get ui3WebhookTestSending => 'جارٍ إرسال webhook تجريبي...';

  @override
  String get ui3WebhookTestSent => 'تم إرسال webhook التجريبي بنجاح';

  @override
  String get ui3WebhookTestFailed => 'تعذّر إرسال webhook التجريبي';

  @override
  String get ui3WebhookUrlInvalid =>
      'يجب أن يكون عنوان webhook عنوان HTTPS عامًا';

  @override
  String get ui3WebhookSelectEvent => 'اختر حدث webhook واحدًا على الأقل';

  @override
  String get ui3SensitiveDataDetection => 'كشف البيانات الحساسة';

  @override
  String get ui3Email => 'البريد الإلكتروني';

  @override
  String get ui3CreditCard => 'بطاقة الائتمان';

  @override
  String get ui3DetectEmailDesc =>
      'كشف عناوين البريد الإلكتروني في الرسائل النصية';

  @override
  String get ui3DetectPhoneDesc => 'كشف أرقام الهواتف والأرقام الدولية';

  @override
  String get ui3DetectCardDesc =>
      'كشف أرقام البطاقات والحسابات المصرفية المحتملة';

  @override
  String get ui3DetectWalletDesc => 'كشف عناوين المحافظ بتنسيق Ethereum';

  @override
  String get ui3GeneralTopic => 'عام';

  @override
  String get a11yPreviousResult => 'النتيجة السابقة';

  @override
  String get a11yNextResult => 'النتيجة التالية';

  @override
  String get ui3TryDifferentKeywords => 'جرّب كلمات مفتاحية مختلفة';

  @override
  String ui3FiltersActive(Object count) {
    return 'عوامل التصفية النشطة: $count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return 'عوامل تصفية الرسائل النشطة: $count';
  }

  @override
  String get ui3LoadMore => 'تحميل المزيد';

  @override
  String get ui3MessageFilters => 'عوامل تصفية الرسائل';

  @override
  String get ui3SenderUserId => 'معرّف المستخدم المرسل';

  @override
  String get ui3FilterType => 'النوع';

  @override
  String get ui3FilterAny => 'الكل';

  @override
  String get ui3FilterImage => 'صورة';

  @override
  String get ui3FilterTime => 'الوقت';

  @override
  String get ui3AnyTime => 'أي وقت';

  @override
  String get ui3OnlyMyMessages => 'رسائلي فقط';

  @override
  String get ui3MediaOnly => 'الوسائط فقط';

  @override
  String get ui3Apply => 'تطبيق';

  @override
  String get ui3QrStyleClassic => 'كلاسيكي';

  @override
  String get ui3QrStyleOcean => 'محيط';

  @override
  String get ui3QrStyleBerry => 'توت';

  @override
  String get ui3NfcUnavailable =>
      'NFC غير متاح أو العلامة غير مدعومة. فعّل NFC أو جرّب علامة أخرى أو استخدم رمز QR.';

  @override
  String get ui3CancelNfc => 'إلغاء NFC';

  @override
  String get ui3ReadNfcTag => 'قراءة علامة NFC';

  @override
  String get ui3HoldNearNfcTag => 'قرّب هاتفك من علامة الخدمة.';

  @override
  String get a11yFlashlightOn => 'تشغيل المصباح';

  @override
  String get a11yFlashlightOff => 'إيقاف المصباح';

  @override
  String get ui3SocialGraph => 'الرسم البياني الاجتماعي';

  @override
  String get ui3RecommendedConnections => 'اتصالات مقترحة';

  @override
  String get ui3Portfolio => 'المحفظة الاستثمارية';

  @override
  String get ui3Chains => 'الشبكات';

  @override
  String get ui3Tokens => 'الرموز';

  @override
  String get ui3NoConnectionsFound => 'لم يتم العثور على اتصالات';

  @override
  String get ui3ConnectionsHint => 'تظهر الاتصالات مع ازدياد نشاطك على السلسلة';

  @override
  String get ui3SocialGraphLoadFailed => 'تعذّر تحميل الرسم البياني الاجتماعي';

  @override
  String get ui3Similarity => 'التشابه';

  @override
  String get ui3Breakdown => 'التفاصيل';

  @override
  String get ui3TokenHoldings => 'الرموز المملوكة';

  @override
  String get ui3NftCollections => 'مجموعات NFT';

  @override
  String get ui3ChainUsage => 'استخدام الشبكات';

  @override
  String get ui3Transactions => 'المعاملات';

  @override
  String get ui3DaoMembership => 'عضوية DAO';

  @override
  String get ui3NotWeighted => 'غير مرجّح';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent% (الوزن: $weight)';
  }

  @override
  String get ui3CommonOnChainActivity => 'نشاط مشترك على السلسلة';

  @override
  String get ui3SharedTokens => 'رموز مشتركة';

  @override
  String get ui3SharedNftCollections => 'مجموعات NFT مشتركة';

  @override
  String get ui3SharedChains => 'شبكات مشتركة';

  @override
  String get ui3NoSharedTokens => 'لم يتم العثور على رموز مشتركة';

  @override
  String get ui3NoSharedNftCollections =>
      'لم يتم العثور على مجموعات NFT مشتركة';

  @override
  String get ui3NoSharedChains => 'لم يتم العثور على شبكات مشتركة';

  @override
  String get ui3SimilarityFailed => 'تعذّر حساب التشابه';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items و$count أخرى';
  }

  @override
  String get a11yGovernance => 'الحوكمة';

  @override
  String get ui3CommunityLink => 'رابط المجتمع';

  @override
  String get ui3CommunityQrCode => 'رمز QR للمجتمع';

  @override
  String get ui3CommunityQrSubtitle =>
      'امسح للانضمام إلى هذا المجتمع وتصفّح قنواته';

  @override
  String get ui3CommunityLinkLoadFailed => 'تعذّر تحميل رابط المجتمع';

  @override
  String get ui3CommunityLinkCopied => 'تم نسخ رابط المجتمع';

  @override
  String ui3KickMemberConfirm(Object name) {
    return 'ستتم إزالة $name من هذا المجتمع.';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return 'ستتم إزالة $name ولن يتمكن من الانضمام مجددًا.';
  }

  @override
  String get ui3SignInToDiscoverChannels =>
      'سجّل الدخول لاكتشاف القنوات العامة';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return 'تعذّر الانضمام إلى $name: $error';
  }

  @override
  String get ui3CategoryTech => 'تقنية';

  @override
  String get ui3CategorySocial => 'اجتماعي';

  @override
  String get ui3NoPublicChannels => 'لم يتم العثور على قنوات عامة';

  @override
  String get ui3StoriesAndFun => 'القصص والمرح';

  @override
  String get ui3SearchMusicHint => 'ابحث عن أغانٍ أو فنانين أو أصدقاء';

  @override
  String get ui3ForYou => 'لك';

  @override
  String get ui3Liked => 'المعجب بها';

  @override
  String get ui3NoLikedMusic => 'لا توجد موسيقى معجب بها بعد';

  @override
  String get ui3NoMusicStories => 'لا توجد قصص موسيقية بعد';

  @override
  String get ui3LikedMusicHint => 'اضغط على القلب بجانب الأغنية لحفظها هنا.';

  @override
  String get ui3MusicStoriesHint => 'ستظهر هنا الموسيقى المشاركة في القصص.';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · شاركها $name';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return 'تعذّر تشغيل $title: $error';
  }

  @override
  String get a11yPreviousTrack => 'المقطع السابق';

  @override
  String get a11yNextTrack => 'المقطع التالي';

  @override
  String get a11yPlay => 'تشغيل';

  @override
  String get a11yPause => 'إيقاف مؤقت';

  @override
  String get ui3Refresh => 'تحديث';

  @override
  String get ui3NearbyIntroTitle => 'اكتشف المنشورات العامة القريبة';

  @override
  String get ui3NearbyIntroBody =>
      'يُستخدم موقعك مرة واحدة على هذا الجهاز لترتيب اللحظات العامة. لا يتم رفعه أو بثّه أو عرضه للآخرين.';

  @override
  String get ui3UseMyLocation => 'استخدام موقعي';

  @override
  String get ui3NearbyUnavailable => 'ميزة \"بالقرب\" غير متاحة';

  @override
  String get ui3NoNearbyPosts => 'لا توجد منشورات قريبة بعد';

  @override
  String get ui3NoNearbyPostsHint =>
      'ستظهر هنا اللحظات العامة التي تتضمن موقعًا.';

  @override
  String get ui3NearbyDistanceNote =>
      'مسافة تقريبية · منشورات الموقع العامة فقط';

  @override
  String get ui3PublicLocationPost => 'منشور موقع عام';

  @override
  String get ui3LocationServicesOff => 'خدمات الموقع متوقفة';

  @override
  String get ui3LocationPermissionDenied => 'تم رفض إذن الموقع';

  @override
  String get ui3EnableLocationInSettings => 'فعّل إذن الموقع من إعدادات النظام';

  @override
  String get ui3CreateStory => 'إنشاء قصة';

  @override
  String get ui3CreateStoryDesc => 'انشر حالة نصية أو صورة.';

  @override
  String get ui3StoryCamera => 'كاميرا القصص';

  @override
  String get ui3StoryCameraDesc => 'انتقل مباشرةً إلى الفلاتر وتحرير الصور.';

  @override
  String get ui3MomentsDesc => 'افتح الخلاصة الكاملة والتعليقات.';

  @override
  String get ui3MomentCamera => 'كاميرا اللحظات';

  @override
  String get ui3MomentCameraDesc => 'أنشئ منشورًا واختر الوسائط فورًا.';

  @override
  String get ui3GamesDesc => 'شغّل مركز الألعاب الخفيفة المدمج.';

  @override
  String get ui3AvatarStudio => 'استوديو الصور الرمزية';

  @override
  String get ui3AvatarStudioDesc => 'زخارف وصورة رمزية NFT ولمسات للهوية.';

  @override
  String get ui3SocialGraphDesc =>
      'المتابعات والمعجبون والاتصالات على السلسلة.';

  @override
  String get ui3SocialHubHeroTitle => 'القصص واللحظات والألعاب والصور الرمزية';

  @override
  String get ui3SocialHubHeroBody =>
      'كل الميزات الاجتماعية في مكان واحد بدلًا من تشتيت نقاط الدخول بين الدردشة والملف الشخصي والاستكشاف.';

  @override
  String get ui3SocialGraphNotConfigured =>
      'الرسم البياني الاجتماعي غير مُعدّ في هذا الإصدار';

  @override
  String get ui3ConnectWalletForSocialGraph =>
      'اربط محفظة لعرض رسمك البياني الاجتماعي';

  @override
  String get ui3AvatarStudioSignIn =>
      'يتطلب استوديو الصور الرمزية تسجيل الدخول';

  @override
  String get a11yRemoveImage => 'إزالة الصورة';

  @override
  String get a11yBack => 'رجوع';

  @override
  String get ui3MiniAppConfirmTransactionTitle => 'تأكيد المعاملة';

  @override
  String get ui3MiniAppConfirmTransactionBody =>
      'يطلب تطبيق مصغّر إرسال معاملة نيابةً عنك.';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return 'فتح $name؟';
  }

  @override
  String get ui3MiniAppOpenButton => 'فتح';

  @override
  String get ui3StoryReplySendFailed => 'تعذّر إرسال الرد على القصة';

  @override
  String get ui3RedPacketDemoNotice =>
      'ظرف أحمر تجريبي — مجرد سجل داخل الدردشة، ولا يتم تحويل أي أصل حقيقي على السلسلة.';

  @override
  String get ui3RedPacketCoverClassic => 'أحمر كلاسيكي';

  @override
  String get ui3RedPacketCoverGolden => 'ذهبي';

  @override
  String get ui3RedPacketCoverPurple => 'بنفسجي';

  @override
  String get ui3RedPacketCoverOceanBlue => 'أزرق المحيط';

  @override
  String get ui3RedPacketCoverNatureGreen => 'أخضر طبيعي';

  @override
  String get ui3RedPacketCoverRosePink => 'وردي';

  @override
  String get ui3RedPacketHistoryEmpty => 'لا توجد ظروف حمراء بعد';

  @override
  String get ui3TransferMerchantQrWithAmount => 'رمز QR للتاجر (مع المبلغ)';

  @override
  String get ui3TransferMerchantQrTitle => 'رمز QR للتاجر';

  @override
  String get ui3TransferOpenAmountHint => 'اتركه فارغًا لمبلغ مفتوح';

  @override
  String get ui3FiatRampTitle => 'شراء / بيع العملات المشفرة';

  @override
  String get ui3FiatRampBuy => 'شراء';

  @override
  String get ui3FiatRampSell => 'بيع';

  @override
  String get ui3FiatRampNotConfigured =>
      'خدمة شراء/بيع العملات بالعملة الورقية غير مُعدّة';

  @override
  String get a11yPointsAddRule => 'إضافة قاعدة مكافأة';

  @override
  String get a11yGovernanceRemoveChoice => 'إزالة الخيار';

  @override
  String get a11yGovernanceCreateProposal => 'إنشاء مقترح';

  @override
  String get ui3MiniAppUpdateN42 => 'تحديث N42';

  @override
  String get ui3MiniAppOfficial => 'رسمي';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count مستخدم';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return 'لون الخلفية $index';
  }

  @override
  String get a11yStoryAdd => 'إضافة قصة';

  @override
  String get ui3StoryPostFailed => 'تعذّر نشر القصة';

  @override
  String get ui3StoryTapToSelectImage => 'انقر لاختيار صورة';

  @override
  String get ui3StoryChangeImage => 'تغيير';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return 'تعذّرت قراءة الموسيقى المحددة: $error';
  }

  @override
  String get ui3StoryDeleteConfirm => 'هل تريد حذف هذه القصة؟';

  @override
  String get ui3StoryDeleteFailed => 'تعذّر حذف القصة';

  @override
  String get ui3MomentCreateTitle => 'إنشاء لحظة';

  @override
  String get ui3MomentContentHint => 'بماذا تفكر؟';

  @override
  String get ui3MomentAddPhotos => 'إضافة صور';

  @override
  String get ui3MomentAddLocation => 'إضافة موقع';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return 'الوسائط المحددة ($count)';
  }

  @override
  String get ui3MomentClearAll => 'مسح الكل';

  @override
  String get ui3MomentClearMediaConfirm =>
      'هل تريد إزالة كل الصور/الفيديوهات المحددة؟';

  @override
  String get ui3MomentVisibilityPublicDesc => 'يمكن لجميع الأصدقاء الرؤية';

  @override
  String get ui3MomentVisibilityPrivateDesc => 'مرئي لك فقط';

  @override
  String get ui3MomentVisibilityPartialDesc => 'اختر من يمكنه الرؤية';

  @override
  String get ui3MomentVisibilityExcludedDesc => 'إخفاء عن أصدقاء محددين';

  @override
  String get ui3MomentVideos => 'فيديوهات';

  @override
  String get ui3MomentNoVideos => 'لا توجد فيديوهات بعد';

  @override
  String get a11yCallMinimize => 'تصغير';

  @override
  String get a11yCallGridView => 'عرض شبكي';

  @override
  String get a11yCallFocusView => 'عرض التركيز';

  @override
  String get ui3CallTools => 'أدوات المكالمة';

  @override
  String get ui3CallMeetingTools => 'أدوات الاجتماع';

  @override
  String get ui3CallToolsSubtitle =>
      'اضبط جودة الصوت والفيديو دون مغادرة المكالمة.';

  @override
  String get ui3CallAudioEnhancement => 'تحسين الصوت';

  @override
  String get ui3CallNoiseSuppression => 'كتم الضوضاء';

  @override
  String get ui3CallNoiseSuppressionDesc =>
      'يقلل ضوضاء لوحة المفاتيح والخلفية.';

  @override
  String get ui3CallEchoCancellation => 'إلغاء الصدى';

  @override
  String get ui3CallEchoCancellationDesc =>
      'يمنع عودة صوت السماعة إلى الميكروفون.';

  @override
  String get ui3CallAutoGainControl => 'التحكم التلقائي في الكسب';

  @override
  String get ui3CallAutoGainControlDesc =>
      'يحافظ على ثبات مستوى صوت الميكروفون.';

  @override
  String get ui3CallVoiceIsolation => 'عزل صوت محسّن';

  @override
  String get ui3CallVoiceIsolationDesc =>
      'استخدم ملف تعريف أقوى لتقليل الضوضاء.';

  @override
  String get ui3CallVideoSection => 'الفيديو';

  @override
  String get ui3CallBackgroundBlur => 'تمويه الخلفية (تجريبي)';

  @override
  String get ui3CallBlurDescReady =>
      'تم تفعيل التفضيل. يعتمد التمويه الفعلي على إطلاق معالج الفيديو.';

  @override
  String get ui3CallBlurDescSaved =>
      'تم حفظ تفضيل التمويه وسيُطبَّق عند توفر معالجة الكاميرا.';

  @override
  String get ui3CallBlurDescCameraOff =>
      'شغّل الكاميرا بعد توفر معالجة الخلفية.';

  @override
  String get ui3CallRecordingSection => 'التسجيل';

  @override
  String get ui3CallRecordingDesc =>
      'يتطلب خدمة إخراج على الخادم قبل حفظ التسجيلات.';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return 'تعذّر تحديث إعدادات المكالمة: $error';
  }

  @override
  String get ui3CallRecordingStarted => 'بدأ التسجيل';

  @override
  String get ui3VoiceRoomNotFound => 'الغرفة غير موجودة';

  @override
  String get ui3VoiceRoomEndConfirm =>
      'هل أنت متأكد من إنهاء هذه الغرفة الصوتية؟';

  @override
  String get a11yGameMoveUp => 'تحريك لأعلى';

  @override
  String get a11yGameMoveDown => 'تحريك لأسفل';

  @override
  String get a11yGameMoveLeft => 'تحريك لليسار';

  @override
  String get a11yGameMoveRight => 'تحريك لليمين';

  @override
  String get a11yGameRotate => 'تدوير';

  @override
  String get a11yGameDrop => 'إسقاط';

  @override
  String ui3StickerAddedCount(Object count) {
    return 'تمت إضافة $count ملصق';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return 'تعذّرت الإضافة: $error';
  }

  @override
  String get ui3StickerRemoveTitle => 'إزالة الملصق';

  @override
  String get ui3StickerRemoveConfirm => 'هل تريد إزالة هذا الملصق من الحزمة؟';

  @override
  String get ui3StickerRemoveFailed => 'تعذّرت الإزالة';

  @override
  String get ui3StickerRenamePack => 'إعادة تسمية الحزمة';

  @override
  String get ui3StickerPackName => 'اسم الحزمة';

  @override
  String get ui3StickerRenameFailed => 'تعذّرت إعادة التسمية';

  @override
  String get ui3StickerDeletePack => 'حذف الحزمة';

  @override
  String get ui3StickerThisPack => 'هذه الحزمة';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return 'هل تريد حذف \"$name\" وكل ملصقاتها؟ لا يمكن التراجع عن ذلك.';
  }

  @override
  String get ui3StickerDeleteFailed => 'تعذّر الحذف';

  @override
  String get ui3StickerPack => 'حزمة ملصقات';

  @override
  String get ui3StickerAdding => 'جارٍ الإضافة…';

  @override
  String get ui3StickerAddStickers => 'إضافة ملصقات';

  @override
  String get ui3StickerPackNotFound => 'الحزمة غير موجودة';

  @override
  String get ui3StickerEmptyHint => 'انقر على \"إضافة ملصقات\" لرفع الصور';

  @override
  String get ui3StickerNewPack => 'حزمة ملصقات جديدة';

  @override
  String get ui3StickerCreate => 'إنشاء';

  @override
  String get ui3StickerCreateFailed => 'تعذّر إنشاء الحزمة';

  @override
  String ui3StickerInstalled(Object name) {
    return 'تمت إضافة \"$name\"';
  }

  @override
  String get ui3StickerRemovePackTitle => 'إزالة حزمة الملصقات';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return 'هل تريد إزالة \"$name\" من ملصقاتك؟';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return 'تمت إزالة \"$name\"';
  }

  @override
  String get ui3StickerAiSticker => 'ملصق بالذكاء الاصطناعي';

  @override
  String get ui3StickerStoreTab => 'المتجر';

  @override
  String get ui3StickerMyStickersTab => 'ملصقاتي';

  @override
  String get ui3StickerNoneFound => 'لم يُعثر على ملصقات';

  @override
  String ui3StickerByAuthor(Object author) {
    return 'بواسطة $author';
  }

  @override
  String get ui3StickerManage => 'إدارة';

  @override
  String ui3StickerCount(Object count) {
    return '$count ملصق';
  }

  @override
  String get ui3StickerNoneInstalled => 'لا توجد ملصقات مثبتة';

  @override
  String get ui3StickerGetFromStore => 'احصل على ملصقات من المتجر';

  @override
  String get ui3StickerBrowseStore => 'تصفح المتجر';

  @override
  String get ui3StickerAddedToAi =>
      'تمت الإضافة إلى \"ملصقات الذكاء الاصطناعي\"';

  @override
  String get ui3StickerAddOneFailed => 'تعذّرت إضافة الملصق';

  @override
  String get ui3StickerPromptLabel => 'صِف ملصقك';

  @override
  String get ui3StickerPromptHint =>
      'مثال: قطة برتقالية سعيدة ترتدي نظارة شمسية';

  @override
  String get ui3StickerGenerating => 'جارٍ الإنشاء…';

  @override
  String get ui3StickerGenerate => 'إنشاء';

  @override
  String get ui3StickerAddToStickers => 'إضافة إلى الملصقات';

  @override
  String get ui3StickerGeneratingPreview => 'جارٍ إنشاء ملصقك…';

  @override
  String get ui3StickerGenerateEmpty => 'صِف ملصقًا ثم انقر على \"إنشاء\"';
}
