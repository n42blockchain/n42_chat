// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class SUk extends S {
  SUk([String locale = 'uk']) : super(locale);

  @override
  String get commonRetry => 'Повторіть спробу';

  @override
  String get commonUnknownUser => 'Невідомий користувач';

  @override
  String get transferWalletNotConnected => 'Гаманець не підключений';

  @override
  String get chatCallServiceNotInitialized =>
      'Служба виклику не ініціалізована';

  @override
  String authLoginFailed(Object error) {
    return 'Помилка входу: $error';
  }

  @override
  String get chatCallBack => 'Передзвоніть';

  @override
  String get chatMissedVideoCall => 'Пропущений відеодзвінок';

  @override
  String get chatMissedVoiceCall => 'Пропущений голосовий виклик';

  @override
  String get chatCallNotAnswered => 'Без відповіді';

  @override
  String get chatCallDurationLabel => 'Тривалість дзвінка';

  @override
  String get chatVoiceCallCancelled => 'Голосовий виклик скасовано';

  @override
  String get chatVideoCallCancelled => 'Відеодзвінок скасовано';

  @override
  String get commonImage => '[Зображення]';

  @override
  String get chatVideo => '[Відео]';

  @override
  String get chatVoice => '[Голос]';

  @override
  String get commonFile => '[Файл]';

  @override
  String get chatLocation => '[Розташування]';

  @override
  String get chatUnknownMessage => '[Невідоме повідомлення]';

  @override
  String get commonDelete => 'Видалити';

  @override
  String get chatDeleteThisMessage => 'Видалити це повідомлення?';

  @override
  String get chatMessageDeleted => 'Повідомлення видалено';

  @override
  String get profileNotLoggedIn => 'Не ввійшли в систему';

  @override
  String get chatMyLocation => 'Моє місцезнаходження';

  @override
  String get commonGroupChat => 'Груповий чат';

  @override
  String get commonSearch => 'Пошук';

  @override
  String get commonCancel => 'Скасувати';

  @override
  String get commonLoadFailed => 'Не вдалося завантажити';

  @override
  String get commonMessages => 'Повідомлення';

  @override
  String get commonContacts => 'Контакти';

  @override
  String get commonMe => 'я';

  @override
  String get commonVoiceLoading => 'Голосове завантаження, спробуйте пізніше';

  @override
  String get commonVoiceToTextFailed => 'Помилка перетворення голосу в текст';

  @override
  String get commonConvertToText => 'До тексту';

  @override
  String get chatCopy => 'Копія';

  @override
  String get commonForward => 'вперед';

  @override
  String get commonUnfavorite => 'Нелюб';

  @override
  String get commonFavorite => 'улюблений';

  @override
  String get settingsResend => 'Надіслати повторно';

  @override
  String get chatRecall => 'Відкликати';

  @override
  String get commonQuote => 'Цитата';

  @override
  String get commonRemind => 'Нагадати';

  @override
  String get chatCopied => 'Скопійовано';

  @override
  String get storySendMessageHint => 'Надіслати повідомлення';

  @override
  String get commonMicrophonePermissionRequired =>
      'Дозвольте дозвіл на використання мікрофона';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      'У дозволі на мікрофон відмовлено. Будь ласка, увімкніть це в налаштуваннях системи, щоб використовувати голосові повідомлення.';

  @override
  String commonStartRecordingFailed(Object error) {
    return 'Не вдалося почати запис: $error';
  }

  @override
  String get commonRecordingTooShort => 'Запис занадто короткий';

  @override
  String commonStopRecordingFailed(Object error) {
    return 'Не вдалося зупинити запис: $error';
  }

  @override
  String get chatReleaseToCancel => 'Відпустіть, щоб скасувати';

  @override
  String get chatReleaseToSend =>
      'Відпустіть, щоб надіслати, проведіть пальцем угору, щоб скасувати';

  @override
  String get commonHoldToTalk => 'Тримайте, щоб говорити';

  @override
  String get commonSend => 'Надіслати';

  @override
  String get commonAddFriend => 'Додати друга';

  @override
  String get commonChatServiceNotConnected => 'Служба чату не підключена';

  @override
  String contactUserNotFoundHint(String query) {
    return 'Користувача \"$query\" не знайдено\n\nПоради:\n• Спробуйте ввести повний ідентифікатор користувача, напр. @username:server.com\n• Перевірте написання імені користувача';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Не вдалося створити чат: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Помилка пошуку: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Введіть ідентифікатор користувача або ім’я користувача для пошуку';

  @override
  String get contactSearching => 'Пошук...';

  @override
  String get contactSearchUserToChat =>
      'Знайдіть користувача, щоб розпочати спілкування';

  @override
  String get contactMatrixIdExample =>
      'Ви можете ввести повний ідентифікатор матриці\nнапр. @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'Користувача \"$username\" не знайдено';
  }

  @override
  String get commonChat => 'Чат';

  @override
  String get commonSettings => 'Налаштування';

  @override
  String get profileEditProfile => 'Редагувати профіль';

  @override
  String get authLogin => 'Увійти';

  @override
  String get commonCreateGroup => 'Створити групу';

  @override
  String get chatError => 'Помилка';

  @override
  String get commonTransfer => 'Трансфер';

  @override
  String get commonReceived => 'Отримано';

  @override
  String get commonRefunded => 'Повернено';

  @override
  String get commonExpired => 'Термін дії минув';

  @override
  String get chatRedPacketGreeting => 'найкращі побажання';

  @override
  String get commonN42RedPacket => 'N42 Червоний пакет';

  @override
  String get commonClaimed => 'Заявлено';

  @override
  String get commonAllClaimed => 'Все заявлено';

  @override
  String get chatReadAloud => 'Читайте вголос';

  @override
  String get chatReply => 'Відповісти';

  @override
  String get commonEdit => 'Редагувати';

  @override
  String get chatSelectForwardTarget => 'Виберіть Переслати ціль';

  @override
  String commonSendCount(int count) {
    return 'Надіслати ($count)';
  }

  @override
  String contactN42Id(Object id) {
    return 'N42 ID: $id';
  }

  @override
  String get profileN42IdTitle => 'N42 ID';

  @override
  String get profileN42Bean => 'N42 Бін';

  @override
  String get contactFriendInfo => 'Інформація про друга';

  @override
  String get contactFriendInfoDesc =>
      'Додайте зауваження друга, телефон, теги, нотатки, фотографії та встановіть дозволи.';

  @override
  String get commonMoments => 'Моменти';

  @override
  String get commonSendMessage => 'повідомлення';

  @override
  String get contactAudioVideoCall => 'Аудіо/відеодзвінок';

  @override
  String get contactVideoChannel => 'Відеоканал';

  @override
  String get contactRemark => 'Зауваження';

  @override
  String get contactRemarkName => 'Примітка Назва';

  @override
  String get contactPhone => 'Телефон';

  @override
  String get contactTags => 'Теги';

  @override
  String get contactNotes => 'Примітки';

  @override
  String get contactPhotos => 'Фотографії';

  @override
  String get contactPermissions => 'Дозволи';

  @override
  String get contactChatMomentsEtc => 'Чат, моменти, спорт тощо.';

  @override
  String get contactMoreInfo => 'Більше інформації';

  @override
  String get contactCommonGroups => 'Спільні групи';

  @override
  String get contactSource => 'Джерело';

  @override
  String get settingsNotificationSettings => 'Сповіщення';

  @override
  String get settingsPrivacy => 'Конфіденційність';

  @override
  String get settingsAppearance => 'Зовнішній вигляд';

  @override
  String get settingsAbout => 'про';

  @override
  String get commonLogout => 'Вийти';

  @override
  String get commonLogoutConfirm => 'Ви впевнені, що бажаєте вийти?';

  @override
  String get commonSave => 'зберегти';

  @override
  String get profileNickname => 'псевдонім';

  @override
  String get profileEnterNickname => 'Введіть псевдонім';

  @override
  String get profileSignature => 'Підпис';

  @override
  String get profileAddSignature => 'Додайте підпис';

  @override
  String get commonTakePhoto => 'Зробити фото';

  @override
  String get profileChooseFromGallery => 'Виберіть із галереї';

  @override
  String profileSaveFailed(Object error) {
    return 'Не вдалося зберегти: $error';
  }

  @override
  String get authSecureDecentralizedChat =>
      'Безпечний децентралізований обмін повідомленнями';

  @override
  String get commonEndToEndEncryption => 'Наскрізне шифрування';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Повідомлення, видимі лише вам і одержувачу';

  @override
  String get authDecentralized => 'Децентралізована';

  @override
  String get authBasedOnMatrix =>
      'Побудований на основі відкритого протоколу Matrix';

  @override
  String get authWalletIntegration => 'Інтеграція гаманця';

  @override
  String get authEasyCryptoTransfer => 'Прості перекази криптовалюти';

  @override
  String get authRegister => 'Зареєструватися';

  @override
  String get authAgreeTerms => 'Увійшовши в систему, ви погоджуєтесь';

  @override
  String get authTermsOfService => 'Умови обслуговування';

  @override
  String get authAnd => ' і ';

  @override
  String get authPrivacyPolicy => 'Політика конфіденційності';

  @override
  String get authServerAddress => 'Адреса сервера';

  @override
  String get authEnterServerAddress => 'Введіть адресу сервера';

  @override
  String authConnectedTo(Object serverName) {
    return 'Підключено до $serverName';
  }

  @override
  String get authUsername => 'Ім\'я користувача';

  @override
  String get authEnterUsername => 'Введіть ім\'я користувача';

  @override
  String get authUsernameOrEmail => 'Ім\'я користувача або електронна пошта';

  @override
  String get authEnterUsernameOrEmail =>
      'Введіть ім\'я користувача або електронну адресу';

  @override
  String get authPassword => 'Пароль';

  @override
  String get authEnterPassword => 'Введіть пароль';

  @override
  String get authRegisterAccount => 'Зареєструватися';

  @override
  String get authForgotPassword => 'Забули пароль';

  @override
  String get authOtherLoginMethods => 'Інші методи входу';

  @override
  String get authCreateAccount => 'Створити акаунт';

  @override
  String get authJoinN42Chat =>
      'Приєднайтеся до чату N42, щоб розпочати спілкування';

  @override
  String get authUsernameHint => '3-20 символів, літери/цифри/_';

  @override
  String get authUsernameMinLength =>
      'Ім\'я користувача має містити не менше 3 символів';

  @override
  String get authUsernameMaxLength =>
      'Ім\'я користувача має містити не більше 20 символів';

  @override
  String get authUsernameFormat =>
      'Ім\'я користувача може містити лише літери, цифри та підкреслення';

  @override
  String get authPasswordHint => 'Мінімум 8 символів';

  @override
  String get commonPasswordMinLength => 'Пароль має бути не менше 8 символів';

  @override
  String get authConfirmPassword => 'Підтвердьте пароль';

  @override
  String get authFilled => 'Заповнений';

  @override
  String get authEnterInviteCode => 'Введіть код запрошення';

  @override
  String get authAlreadyHaveAccount => 'Вже маєте акаунт?';

  @override
  String get authLoginNow => 'Увійдіть зараз';

  @override
  String get profileAvatar => 'Аватар';

  @override
  String get profileStatus => 'Статус';

  @override
  String get commonLoading => 'Завантаження...';

  @override
  String get conversationNoConversations => 'Жодних розмов';

  @override
  String get conversationTapToChat =>
      'Торкніться вгорі праворуч, щоб розпочати спілкування';

  @override
  String get conversationStartGroup => 'Запустіть груповий чат';

  @override
  String get commonScan => 'Сканувати';

  @override
  String get commonPayment => 'Оплата';

  @override
  String commonFeatureComingSoon(Object feature) {
    return '$feature незабаром';
  }

  @override
  String get conversationMarkAsRead => 'Позначити як прочитане';

  @override
  String get commonUnmute => 'Увімкнути звук';

  @override
  String get commonMute => 'Вимкнути звук';

  @override
  String get conversationUnpin => 'Відкріпити';

  @override
  String get conversationPin => 'Закріпити';

  @override
  String get conversationDeleteConversation => 'Видалити розмову';

  @override
  String conversationDeleteConversationConfirm(Object name) {
    return 'Видалити розмову з \"$name\"?';
  }

  @override
  String get commonNoContacts => 'Немає контактів';

  @override
  String get contactAddFriendsToChat =>
      'Додайте друзів, щоб почати спілкуватися';

  @override
  String get contactNotFound => 'Контакт не знайдено';

  @override
  String get contactTryOtherKeywords =>
      'Спробуйте інші ключові слова або глобальний пошук';

  @override
  String get contactSearchResults => 'Результати пошуку';

  @override
  String get contactNewFriends => 'Нові друзі';

  @override
  String get contactChatOnlyFriends => 'Друзі лише в чаті';

  @override
  String get contactOfficialAccounts => 'Офіційні облікові записи';

  @override
  String get contactServiceAccounts => 'Сервісні облікові записи';

  @override
  String get contactEnterpriseContacts => 'Контакти підприємства';

  @override
  String get contactRecommendToFriend => 'Поділіться контактом';

  @override
  String get commonSetRemark => 'Встановити зауваження';

  @override
  String get contactSendingCard => 'Надсилання картки контакту...';

  @override
  String get commonFileLabel => 'Файл';

  @override
  String get commonLocationLabel => 'Розташування';

  @override
  String contactRecommendFailed(Object error) {
    return 'Не вдалося рекомендувати: $error';
  }

  @override
  String get profileEnterRemark => 'Введіть зауваження';

  @override
  String get contactOpeningChat => 'Відкриття чату...';

  @override
  String contactOpenChatFailed(Object error) {
    return 'Не вдалося відкрити чат: $error';
  }

  @override
  String get contactAddContact => 'Додати контакт';

  @override
  String get contactEnterUserId => 'Введіть ідентифікатор користувача';

  @override
  String get contactNoFriendRequests => 'Без запитів друзів';

  @override
  String get commonAccept => 'прийняти';

  @override
  String get commonReject => 'Відхиляти';

  @override
  String get commonNoGroups => 'Немає груп';

  @override
  String get contactSelectFriendToRecommend =>
      'Виберіть друга, якому потрібно порекомендувати';

  @override
  String get commonSearchContacts => 'Пошук контактів';

  @override
  String get contactNoContactsFound => 'Контакти не знайдено';

  @override
  String get favoriteYesterday => 'вчора';

  @override
  String get chatJustNow => 'Просто зараз';

  @override
  String get profileOnline => 'Онлайн';

  @override
  String get profileOffline => 'Офлайн';

  @override
  String get searchContactsGroupsMessages =>
      'Пошук контактів, груп і повідомлень';

  @override
  String get searchError => 'Помилка пошуку';

  @override
  String get chatSearchHint => 'Пошук';

  @override
  String get searchHistory => 'Історія пошуку';

  @override
  String get commonClear => 'ясно';

  @override
  String get commonAll => 'всі';

  @override
  String get searchGroups => 'Групи';

  @override
  String get searchNoResults => 'Немає результатів';

  @override
  String commonGroupMembers(Object count) {
    return 'Учасники ($count)';
  }

  @override
  String get groupMembersTitle => 'Члени групи';

  @override
  String get groupViewAll => 'Переглянути всі';

  @override
  String get groupOwner => 'Власник';

  @override
  String get groupAdmin => 'адмін';

  @override
  String get groupInvite => 'Запросити';

  @override
  String get commonGroupAnnouncement => 'Групове оголошення';

  @override
  String get commonNotSet => 'Не встановлено';

  @override
  String get groupDescription => 'Опис групи';

  @override
  String get groupPublicGroup => 'Громадська група';

  @override
  String get commonClearChatHistory => 'Очистити історію чату';

  @override
  String get commonDissolveGroup => 'Розпустити групу';

  @override
  String get commonLeaveGroup => 'Вийти з групи';

  @override
  String get groupChangeGroupName => 'Змінити назву групи';

  @override
  String get commonEnterGroupName => 'Введіть назву групи';

  @override
  String get commonConfirm => 'Підтвердити';

  @override
  String get groupEnterGroupDescription => 'Введіть опис групи';

  @override
  String get groupPublish => 'Опублікувати';

  @override
  String get chatClearHistoryConfirm =>
      'Очистити всю історію чату? Це неможливо скасувати.';

  @override
  String get chatClearAction => 'ясно';

  @override
  String get commonChatHistoryCleared => 'Історію чату очищено';

  @override
  String get commonDissolve => 'Розчинити';

  @override
  String get groupQrCode => 'QR-код групи';

  @override
  String get commonSearchChatHistory => 'Пошук в історії чату';

  @override
  String get groupIdCopied => 'Ідентифікатор групи скопійовано';

  @override
  String get transferEnterOrPasteAddress =>
      'Введіть або вставте адресу гаманця';

  @override
  String get transferSelectToken => 'Виберіть Токен';

  @override
  String get commonTransferAmount => 'Сума переказу';

  @override
  String get transferAvailable => 'в наявності';

  @override
  String get transferMemoOptional => 'Пам\'ятка (необов\'язково)';

  @override
  String get transferConfirmTransfer => 'Підтвердити передачу';

  @override
  String get transferAddressVerified => 'Адреса підтверджена';

  @override
  String transferAvailableBalance(Object balance, Object symbol) {
    return 'В наявності: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Введіть суму';

  @override
  String get commonRedPacketCountMin => 'Потрібен принаймні 1 червоний пакет';

  @override
  String get commonViewRedPacketDetails =>
      'Переглянути інформацію про червоний пакет';

  @override
  String get commonEnterTransferAmount => 'Будь ласка, введіть суму переказу';

  @override
  String get commonTransferTo => 'Передача в';

  @override
  String commonFromSender(String name) {
    return 'Від $name';
  }

  @override
  String get commonConfirmReceive => 'Підтвердити отримання';

  @override
  String get groupProfile => 'Інформація про групу';

  @override
  String get groupRemoveMember => 'Видалити з групи';

  @override
  String get commonRemove => 'видалити';

  @override
  String get profileClearStatus => 'Очистити статус';

  @override
  String get profileClearStatusConfirm => 'Очистити поточний статус?';

  @override
  String get profileStatusCleared => 'Статус очищено';

  @override
  String get profileUserNotExist => 'Користувач не існує';

  @override
  String get profileUserIdCopied => 'ID користувача скопійовано';

  @override
  String get commonReport => 'звіт';

  @override
  String get profileQrCode => 'QR-код';

  @override
  String get profileAvatarUpdated => 'Аватар оновлено';

  @override
  String commonSelectImageFailed(Object error) {
    return 'Не вдалося вибрати зображення: $error';
  }

  @override
  String get profileChangeName => 'Змінити ім\'я';

  @override
  String get profileMale => 'Чоловік';

  @override
  String get profileFemale => 'Жінка';

  @override
  String chatFeatureInDev(String feature) {
    return 'Функція $feature у розробці...';
  }

  @override
  String profileSaveAddressFailed(Object error) {
    return 'Не вдалося зберегти адресу: $error';
  }

  @override
  String get profileAddNew => 'додати';

  @override
  String get profileAddAddress => 'Додати адресу';

  @override
  String get profileAddressAdded => 'Адресу додано';

  @override
  String get profileAddressUpdated => 'Адреса оновлена';

  @override
  String get profileDeleteAddress => 'Видалити адресу';

  @override
  String get profileAddressDeleted => 'Адреса видалена';

  @override
  String profileSaveInvoiceFailed(Object error) {
    return 'Не вдалося зберегти рахунок-фактуру: $error';
  }

  @override
  String get profileMyInvoices => 'Мої рахунки-фактури';

  @override
  String get profileAddInvoice => 'Додати рахунок-фактуру';

  @override
  String get profileInvoiceAdded => 'Рахунок додано';

  @override
  String get profileInvoiceUpdated => 'Рахунок оновлено';

  @override
  String get profileDeleteInvoice => 'Видалити рахунок-фактуру';

  @override
  String get profileInvoiceDeleted => 'Рахунок видалено';

  @override
  String get profilePersonal => 'Особисті';

  @override
  String get groupSelectAtLeastOne => 'Виберіть хоча б одного учасника';

  @override
  String get chatFileNotExist => 'Файл не існує';

  @override
  String chatSendFailed(String error) {
    return 'Не вдалося надіслати: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Не вдається відкрити браузер';

  @override
  String chatSelectFileFailed(String error) {
    return 'Не вдалося вибрати файл: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Помилка налаштування: $error';
  }

  @override
  String get transferEnterValidAmount => 'Введіть дійсну суму';

  @override
  String get commonAddressCopied => 'Адресу скопійовано';

  @override
  String favoriteOpenItem(Object content) {
    return 'Відкрити: $content';
  }

  @override
  String get favoriteDeleted => 'Видалено';

  @override
  String get profileWallet => 'Гаманець';

  @override
  String get chatRecording => 'Запис';

  @override
  String get chatInvalidVideoUrl => 'Недійсна URL-адреса відео';

  @override
  String get chatDownloadFile => 'Завантажити файл';

  @override
  String get chatClearChatHistoryTitle => 'Очистити історію чату';

  @override
  String get chatVideoCall => 'Відеодзвінок';

  @override
  String get commonVoiceCall => 'Голосовий виклик';

  @override
  String get callLeaveMeeting => 'Залишити зустріч';

  @override
  String get chatDetails => 'Деталі чату';

  @override
  String get chatViewAllGroupMembers => 'Переглянути всіх учасників';

  @override
  String get chatGroupName => 'Назва групи';

  @override
  String get chatGroupNameUpdated => 'Назва групи оновлена';

  @override
  String get chatUpdateFailed => 'Помилка оновлення';

  @override
  String get chatNoPermissionToModify => 'Ви не маєте дозволу на зміну';

  @override
  String get chatGroupManagement => 'Управління групою';

  @override
  String get chatMyNicknameInGroup => 'Мій нік у групі';

  @override
  String get chatPinChat => 'Закріпити чат';

  @override
  String get chatStrongReminder => 'Сильне нагадування';

  @override
  String get chatSetChatBackground => 'Встановити фон чату';

  @override
  String get chatUnknownFile => 'Невідомий файл';

  @override
  String get chatDownload => 'Завантажити';

  @override
  String get chatInvalidLocation => 'Недійсне розташування';

  @override
  String get chatTapToCancel => 'Торкніться, щоб скасувати';

  @override
  String chatCaptureFailed(Object error) {
    return 'Помилка захоплення: $error';
  }

  @override
  String get chatProcessingVideo => 'Обробка відео...';

  @override
  String get chatVideoFileNotExist => 'Відеофайл не існує';

  @override
  String get chatVideoDataEmpty => 'Дані відео порожні';

  @override
  String get chatVideoTooLarge => 'Розмір відео не може перевищувати 100 МБ';

  @override
  String get chatSendingVideo => 'Надсилання відео...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Не вдалося надіслати відео: $error';
  }

  @override
  String get chatImageFileNotExist => 'Файл зображення не існує';

  @override
  String get commonImageDataEmpty => 'Дані зображення порожні';

  @override
  String get chatSendingImage => 'Надсилання зображення...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Не вдалося надіслати зображення: $error';
  }

  @override
  String get chatSendLocation => 'Надіслати місцезнаходження';

  @override
  String get chatSelectLocationAndSend => 'Виберіть місце та надішліть';

  @override
  String get chatShareRealTimeLocation =>
      'Поділіться місцезнаходженням у реальному часі';

  @override
  String get chatShareLocationForOneHour =>
      'Поділіться з друзями місцезнаходженням у реальному часі протягом 1 години';

  @override
  String get chatLocationSent => 'Розташування надіслано';

  @override
  String get chatSelectMessages => 'Виберіть повідомлення';

  @override
  String chatSelectedCount(int count) {
    return 'Вибрано $count';
  }

  @override
  String get chatSelectAll => 'Виберіть усі';

  @override
  String chatGroupChatCount(int count) {
    return 'Груповий чат ($count)';
  }

  @override
  String get chatPrivateChat => 'Приватний чат';

  @override
  String get chatNoMessages => 'Немає повідомлень';

  @override
  String get chatSendFirstMessage =>
      'Надішліть перше повідомлення, щоб розпочати спілкування';

  @override
  String get chatEncryptionNotice =>
      'Цей чат має наскрізне шифрування. Лише ви та одержувач можете читати повідомлення.';

  @override
  String get chatMultiForward => 'вперед';

  @override
  String get chatCollect => 'Збирати';

  @override
  String get chatNoMembers => 'Немає учасників';

  @override
  String get chatMemberNotFound => 'Учасника не знайдено';

  @override
  String get chatVoiceFileNotExist => 'Голосовий файл не існує';

  @override
  String get chatVoiceFileEmpty => 'Голосовий файл порожній';

  @override
  String get chatSendingVoice => 'Надсилання голосу...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Не вдалося надіслати голос: $error';
  }

  @override
  String get chatMessageForwarded => 'Повідомлення переслано';

  @override
  String chatForwardFailed(Object error) {
    return 'Не вдалося переслати: $error';
  }

  @override
  String get chatUnfavorited => 'Не додано до вибраного';

  @override
  String get chatFavorited => 'Вибране';

  @override
  String get chatReactionAdded => 'Реакція додана';

  @override
  String get chatReactionRemoved => 'Реакцію видалено';

  @override
  String get chatFailedMessageDeleted => 'Невдале повідомлення видалено';

  @override
  String get chatDeleteMessages => 'Видалити повідомлення';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Ви впевнені, що хочете видалити повідомлення $count?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Примітка: повідомлення $count надходять від інших і будуть видалені лише для вас.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count повідомлення від вас будуть відкликані для всіх.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return 'Відкликані повідомлення $count, $localCount видалено лише для вас';
  }

  @override
  String chatRecalledMessages(Object count) {
    return 'Відкликані повідомлення $count';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count повідомлення видалено лише для вас';
  }

  @override
  String chatForwardedCount(Object count) {
    return 'Переслані повідомлення $count';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Пересилання завершено: $success вдалося, $failed не вдалося';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'Функція нагадування доступна лише в груповому чаті';

  @override
  String get chatOnlyTextSearchable =>
      'Можна шукати лише текстові повідомлення';

  @override
  String chatSearchFor(Object text) {
    return 'Пошук \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Пошук Baidu';

  @override
  String get chatGoogleSearch => 'Пошук Google';

  @override
  String get chatBingSearch => 'Пошук Bing';

  @override
  String get chatCalling => 'Телефоную...';

  @override
  String get chatRinging => 'Дзвінок...';

  @override
  String get chatInCall => 'У дзвінку';

  @override
  String commonFeatureInDevelopment(Object feature) {
    return 'Функція $feature у розробці...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'Зібрані повідомлення $count';
  }

  @override
  String commonMemberCount(int count) {
    return 'Учасники $count';
  }

  @override
  String groupDone(int count) {
    return 'Готово ($count)';
  }

  @override
  String get profileServices => 'Послуги';

  @override
  String get commonFavorites => 'Вибране';

  @override
  String get profileOrdersAndCards => 'Замовлення та картки';

  @override
  String get profileStickers => 'наклейки';

  @override
  String profileStatusSetTo(String status) {
    return 'Встановлено статус: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'Не вдалося завантажити аватар';

  @override
  String get profilePersonalProfile => 'Особистий профіль';

  @override
  String get profileName => 'Ім\'я';

  @override
  String get profileGender => 'Стать';

  @override
  String get profileRegion => 'Регіон';

  @override
  String get commonMyQrCode => 'Мій QR-код';

  @override
  String get profilePoke => 'Тикати';

  @override
  String get profileRingtone => 'Рінгтон';

  @override
  String get profileDefaultRingtone => 'Мелодія за замовчуванням';

  @override
  String get profileMyAddresses => 'Мої адреси';

  @override
  String profileGenderSetTo(String gender) {
    return 'Встановлено стать: $gender';
  }

  @override
  String get profileSelectRegion => 'Виберіть регіон';

  @override
  String get profileSelectCity => 'Виберіть місто';

  @override
  String profileRegionSetTo(String region) {
    return 'Для регіону встановлено: $region';
  }

  @override
  String get profileSetPoke => 'Встановити Poke';

  @override
  String get profileFriendPokedMe => 'Друг тицьнув мене';

  @override
  String get profileExample => 'приклад';

  @override
  String get profileOnTheShoulder => ' на плечі';

  @override
  String get profilePokeCleared => 'Пок очищено';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Poke встановлено на: poked me$suffix';
  }

  @override
  String get profileEditSignature => 'Редагувати підпис';

  @override
  String get profileIntroduceYourself => 'Речення для представлення';

  @override
  String get profileSignatureCleared => 'Підпис очищено';

  @override
  String get profileSignatureUpdated => 'Підпис оновлено';

  @override
  String get profileScanToAddFriend =>
      'Відскануйте QR-код вище, щоб додати мене до друзів';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Встановлено сигнал дзвінка: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'Ви впевнені, що хочете розпустити \"$name\"? Цю дію не можна скасувати.';
  }

  @override
  String get authEnterValidServerAddress => 'Введіть дійсну адресу сервера';

  @override
  String get authEnterServerAddressFirst => 'Спочатку введіть адресу сервера';

  @override
  String get authPasskeyRequiresServer =>
      'Пароль для входу вимагає підтримки сервера';

  @override
  String get authLoginAgreement => 'Увійшовши в систему, ви погоджуєтесь ';

  @override
  String get authPleaseAgreeToTerms =>
      'Прочитайте та погодьтеся з Умовами надання послуг і Політикою конфіденційності';

  @override
  String get authRegisterFailed => 'Помилка реєстрації';

  @override
  String get authRegistrationDisabled =>
      'Реєстрацію на цьому сервері вимкнено. Зверніться до адміністратора сервера, щоб її ввімкнути.';

  @override
  String get commonReenterPassword => 'Повторно введіть пароль';

  @override
  String get commonPasswordsDoNotMatch => 'Паролі не збігаються';

  @override
  String get authInviteCodeBuiltIn => 'Код запрошення (вбудований)';

  @override
  String get authInviteCodeBuiltInNote =>
      'Код запрошення вбудований, зазвичай не потрібно змінювати';

  @override
  String get authIHaveReadAndAgree => 'Я прочитав і згоден ';

  @override
  String get mainStartGroupChat => 'Запустіть груповий чат';

  @override
  String get mainAddFriends => 'Додати друзів';

  @override
  String get mainPaymentAndCollection => 'Оплата';

  @override
  String contactCount(int count) {
    return '$count контакти';
  }

  @override
  String get contactAddToHomeScreen => 'Додати на головний екран';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'Рекомендована картка $contact для $recipient';
  }

  @override
  String get contactEnterRemarkName => 'Введіть назву зауваження';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Примітка встановлена на: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Прийняв запит $name про друзі';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Відхилено запит $name про дружбу';
  }

  @override
  String get commonGroupInvites => 'Групові запрошення';

  @override
  String commonMyGroups(int count) {
    return 'Мої групи ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Запрошено приєднатися до групи';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'Ви впевнені, що бажаєте залишити \"$name\"?';
  }

  @override
  String get commonLeave => 'Залиште';

  @override
  String get commonRecallThisMessage => 'Відкликати це повідомлення?';

  @override
  String get commonSavedToGallery => 'Збережено в галерею';

  @override
  String get commonFailedToSave => 'Не вдалося зберегти';

  @override
  String get chatSaving => 'Збереження...';

  @override
  String get commonShare => 'Поділіться';

  @override
  String get chatSaveToGallery => 'Зберегти в галерею';

  @override
  String get chatFailedToLoadImage => 'Не вдалося завантажити зображення';

  @override
  String get chatVideoRecordingFailed => 'Помилка запису відео';

  @override
  String get profileRedPacket => 'Червоний пакет';

  @override
  String get commonMusic => 'музика';

  @override
  String get commonCoupon => 'Купон';

  @override
  String get commonGift => 'Подарунок';

  @override
  String get commonPoll => 'Опитування';

  @override
  String get favoriteText => 'текст';

  @override
  String get favoriteLinkLabel => 'Посилання';

  @override
  String get favoriteNote => 'Примітка';

  @override
  String get favoriteMyNotes => 'Мої нотатки';

  @override
  String get favoriteToday => 'Сьогодні';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count днів тому';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$month/$day';
  }

  @override
  String get favoriteNoFavorites => 'Вибраних ще немає';

  @override
  String get favoriteLongPressToFavorite =>
      'Тривале натискання повідомлення до вибраного';

  @override
  String get favoriteNewNote => 'Нова примітка';

  @override
  String get favoriteLink => 'Улюблене посилання';

  @override
  String get favoriteEditTags => 'Редагувати теги';

  @override
  String get favoriteDeleteFavorite => 'Видалити улюблене';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Ви впевнені, що хочете видалити це улюблене?';

  @override
  String get favoriteNoSearchResultsFound => 'Результатів не знайдено';

  @override
  String get commonSendRedPacket => 'Надіслати червоний пакет';

  @override
  String get transferAmount => 'Сума';

  @override
  String get commonRedPacketCover => 'Червона обкладинка пакета';

  @override
  String get commonRedPacketType => 'Червоний тип пакета';

  @override
  String get commonNormalRedPacket => 'нормальний';

  @override
  String get commonLuckyRedPacket => 'Щасливчик';

  @override
  String get commonRedPacketCount => 'Кількість червоних пакетів';

  @override
  String get commonPieces => 'штук';

  @override
  String get commonPutMoneyInRedPacket => 'Покладіть гроші в червоний пакет';

  @override
  String get commonRedPacketRefundNotice =>
      'Незатребувані червоні пакети буде повернено через 24 години';

  @override
  String get commonOpenRedPacket => 'відкритий';

  @override
  String get commonRedPacketAllClaimed => 'Червоний пакет весь затребуваний';

  @override
  String get commonRedPacketExpired => 'Термін дії червоного пакета закінчився';

  @override
  String get commonAddTransferNote => 'Додати переказну записку';

  @override
  String get commonYuan => 'CNY';

  @override
  String get commonReplyWithEmoji => 'Відповісти цим смайлом';

  @override
  String get contactEditRemark => 'Редагувати зауваження';

  @override
  String get contactSetPermissions => 'Встановити дозволи';

  @override
  String get profileAddToBlacklist => 'Додати в чорний список';

  @override
  String get contactDeleteContact => 'Видалити контакт';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Ви впевнені, що хочете видалити $name?';
  }

  @override
  String get transferTitle => 'Трансфер';

  @override
  String get transferReceiverAddressLabel => 'Адреса отримувача';

  @override
  String get transferSelectTokenLabel => 'Виберіть Токен';

  @override
  String get transferAmountLabel => 'Сума переказу';

  @override
  String get transferMemoLabel => 'Пам\'ятка (необов\'язково)';

  @override
  String get transferAddMemoHint => 'Додайте пам\'ятку';

  @override
  String get transferSendPaymentRequest => 'Надіслати запит на оплату';

  @override
  String get transferQrCodeGenerateFailed => 'Не вдалося створити QR-код';

  @override
  String get transferScanQrToPayMe => 'Відскануйте QR-код, щоб заплатити мені';

  @override
  String get transferMyWalletAddress => 'Адреса мого гаманця';

  @override
  String get transferCreatePaymentRequest => 'Створення платіжного запиту';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'найкращі побажання';

  @override
  String commonSenderRedPacket(String name) {
    return 'Червоний пакет $name';
  }

  @override
  String get transferEnterValidAddress => 'Введіть дійсну адресу';

  @override
  String get transferPleaseSelectToken => 'Будь ласка, виберіть маркер';

  @override
  String get commonReceivedTransfer => 'Отримано передачу';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name надіслав червоний пакет';
  }

  @override
  String get commonSavedToBalance =>
      'Збережено на балансі, можна передавати напряму';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'Термін дії червоного пакета минув/усі заявлені';

  @override
  String get transferScanFeatureComingSoon =>
      'Незабаром буде доступна функція сканування...';

  @override
  String get contactSetAsStarred => 'Установити як із зірочкою';

  @override
  String get contactAddToBlocklist => 'Додати до чорного списку';

  @override
  String get commonClaimedYour => ' вимагав ваш ';

  @override
  String get commonClaimedText => ' стверджував ';

  @override
  String commonUserTyping(String name) {
    return '$name друкує...';
  }

  @override
  String get commonTyping => 'Введення...';

  @override
  String get commonWaitingToReceive => 'Очікування отримання';

  @override
  String get commonTapToClaim => 'Торкніться, щоб вимагати';

  @override
  String get commonHasBeenReceived => 'Отримано';

  @override
  String get commonGetLucky => 'Пощастить';

  @override
  String get qrcodeCameraStartFailed => 'Не вдалося запустити камеру';

  @override
  String get qrcodeUnknownError => 'Невідома помилка';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'Помістіть QR-код у рамку для сканування';

  @override
  String get qrcodeCloseManualInput => 'Закрити ручне введення';

  @override
  String get qrcodeManualInputUserId =>
      'Ручне введення ідентифікатора користувача';

  @override
  String get commonAdd => 'додати';

  @override
  String get profileSetStatus => 'Встановити статус';

  @override
  String get profileVisibleToFriends24h => 'Видно для друзів протягом 24 годин';

  @override
  String get profileWriteStatus => 'Напишіть статус';

  @override
  String get profileEnterYourStatus => 'Введіть свій статус...';

  @override
  String get profileOk => 'добре';

  @override
  String get qrcodeCameraPermissionRequired =>
      'Для сканування QR-коду потрібен дозвіл камери';

  @override
  String get qrcodeCameraPermissionDenied =>
      'Назавжди заборонено доступ до камери. Увімкніть його в налаштуваннях системи.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Помилка перевірки дозволу: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'Недійсний QR-код';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Неможливо додати друга: $error';
  }

  @override
  String get qrcodeScanQrCode => 'Відскануйте QR-код';

  @override
  String get qrcodeCheckingCameraPermission => 'Перевірка дозволу камери...';

  @override
  String get qrcodeNeedCameraPermission => 'Потрібен дозвіл камери';

  @override
  String get qrcodeRetryPermission => 'Повторіть спробу';

  @override
  String get qrcodeOpenSettings => 'Відкрийте налаштування';

  @override
  String get groupInviteMembers => 'Запросити учасників';

  @override
  String groupInviteCount(int count) {
    return 'Запросити ($count)';
  }

  @override
  String get profileNoShippingAddress => 'Немає адреси доставки';

  @override
  String get profileDefaultLabel => 'За замовчуванням';

  @override
  String get profileNoInvoice => 'Без рахунку-фактури';

  @override
  String get profileCompany => 'Компанія';

  @override
  String get profileTaxNumber => 'Податковий номер';

  @override
  String get profileConfirmDeleteAddress =>
      'Ви впевнені, що хочете видалити цю адресу?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Ви впевнені, що бажаєте видалити цей рахунок?';

  @override
  String get commonGroupOwner => 'Власник';

  @override
  String get commonGroupAdmin => 'адмін';

  @override
  String get groupSearchMembers => 'Пошук учасників';

  @override
  String groupTotalMembers(int count) {
    return 'Учасники $count';
  }

  @override
  String get chatRemoveFromGroup => 'Видалити з групи';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Ви впевнені, що хочете видалити \"$name\" із групи?';
  }

  @override
  String get chatUnknownSong => 'Невідома пісня';

  @override
  String get chatUnknownArtist => 'Невідомий художник';

  @override
  String get chatUnknownContact => 'Невідомий контакт';

  @override
  String get chatPersonalCard => 'Картка контакту';

  @override
  String get chatSingleChoice => 'неодружений';

  @override
  String get chatMultiChoice => 'Мульти';

  @override
  String get chatEnded => 'Завершено';

  @override
  String get chatEndPollButton => 'Завершити опитування';

  @override
  String get chatPollHint =>
      'Опитування буде відображено в чаті. Члени групи можуть голосувати.';

  @override
  String get chatSearchSongOrArtist => 'Пошук пісні чи виконавця';

  @override
  String get chatNoSongsFound => 'Пісень не знайдено';

  @override
  String get chatSongNameOptional => 'Назва пісні (необов\'язково)';

  @override
  String get chatEnterSongName => 'Введіть назву пісні';

  @override
  String get chatArtistNameOptional => 'Ім\'я виконавця (необов\'язково)';

  @override
  String get chatEnterArtistName => 'Введіть ім\'я виконавця';

  @override
  String get chatRealTimeLocationSharing =>
      'Передача геоданих у реальному часі в розробці...';

  @override
  String get profileVoiceCallFeatureInDev =>
      'Функція голосового виклику в розробці...';

  @override
  String get profileReportFeatureInDev => 'Функція звіту в розробці...';

  @override
  String get profileShareFeatureInDev => 'Поділитися функцією в розробці...';

  @override
  String get profileQrCodeFeatureInDev => 'Функція QR-коду в розробці...';

  @override
  String get qrcodeScanQrToAddMe =>
      'Відскануйте QR-код вище, щоб додати мене до друзів';

  @override
  String get qrcodeSaveToAlbum => 'Зберегти в альбом';

  @override
  String get qrcodeChangeStyle => 'Змінити стиль';

  @override
  String get qrcodeCopyId => 'Копіювати ідентифікатор';

  @override
  String get qrcodeIdCopied => 'ID скопійовано';

  @override
  String get qrcodeMoreStylesFeatureComingSoon => 'Більше стилів незабаром';

  @override
  String get profileBio => 'біографія';

  @override
  String get profileHomeServer => 'Сервер';

  @override
  String get profileShareContactCard => 'Поділитися карткою контакту';

  @override
  String get profileRemoveFromBlacklist => 'Видалити з чорного списку';

  @override
  String get profileConfirmAddBlacklist =>
      'Ви впевнені, що хочете додати цього користувача до чорного списку? Ви не отримаєте від них повідомлень.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Ви впевнені, що хочете видалити цього користувача з чорного списку?';

  @override
  String get profileRemarkSaved => 'Зауваження збережено';

  @override
  String get profileRemarkCleared => 'Зауваження видалено';

  @override
  String get transferReceive => 'Отримати';

  @override
  String get transferPleaseConnectWallet => 'Спочатку підключіть свій гаманець';

  @override
  String get transferSendRequest => 'Надіслати запит';

  @override
  String get transferPleaseEnterValidAmount => 'Введіть дійсну суму';

  @override
  String get searchPlaceholder => 'Пошук контактів, груп, повідомлень';

  @override
  String get searchEnterKeywordToSearch =>
      'Введіть ключове слово, щоб почати пошук';

  @override
  String get searchClearHistory => 'ясно';

  @override
  String searchNoResultsForQuery(String query) {
    return 'Немає результатів для \"$query\"';
  }

  @override
  String get searchAllResults => 'всі';

  @override
  String get searchInChat => 'Пошук в чаті';

  @override
  String get searchContactLabel => 'контакт';

  @override
  String get searchGroupLabel => 'Група';

  @override
  String get searchConversationLabel => 'Розмова';

  @override
  String get searchMessageLabel => 'повідомлення';

  @override
  String get settingsSecurityTitle => 'Безпека';

  @override
  String get settingsDeleteAccountTitle => 'Видалити обліковий запис';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Деактивувати цей обліковий запис Matrix та очистити його локальні дані чату';

  @override
  String get settingsDeleteAccountExplanation =>
      'Буде надіслано запит на остаточну деактивацію облікового запису Matrix. Після підтвердження сервера застосунок видалить локальний сеанс чату й ключі шифрування цього запису, коли це буде безпечно. Інші облікові записи та гаманець збережуться. Федерація й правила зберігання сервера можуть обмежувати видалення даних.';

  @override
  String get settingsDeleteAccountPasswordOptional =>
      'Пароль Matrix, якщо потрібен';

  @override
  String get settingsDeleteAccountServerErase =>
      'Запросити видалення даних на сервері';

  @override
  String get settingsDeleteAccountServerEraseDetail =>
      'Попросити цей домашній сервер видалити дані облікового запису, якщо така можливість підтримується. Копії на інших серверах або дані, які підлягають обов’язковому зберіганню, можуть залишитися.';

  @override
  String get settingsDeleteAccountChooseStage =>
      'Підтвердьте цей обліковий запис Matrix';

  @override
  String get settingsDeleteAccountUsePassword => 'Використати пароль Matrix';

  @override
  String get settingsDeleteAccountUseBrowser => 'Продовжити в браузері';

  @override
  String get settingsDeleteAccountFallbackTitle =>
      'Повернутися після перевірки Matrix';

  @override
  String get settingsDeleteAccountFallbackExplanation =>
      'Повернення з браузера не підтверджує видалення. Перевірте початковий запит на сервері Matrix.';

  @override
  String get settingsDeleteAccountCheckServer => 'Перевірити на сервері';

  @override
  String get settingsDeleteAccountRequestFailed =>
      'Сервер Matrix не підтвердив видалення облікового запису.';

  @override
  String get settingsDeleteAccountPendingTitle =>
      'Очікується локальне очищення облікового запису';

  @override
  String get settingsDeleteAccountPendingSubtitle =>
      'Перевірити очищення раніше деактивованого облікового запису Matrix';

  @override
  String get settingsDeleteAccountPendingReadError =>
      'Не вдалося прочитати записи про очікуване очищення. Натисніть, щоб повторити.';

  @override
  String get settingsDeleteAccountPendingDetail =>
      'Обліковий запис Matrix деактивовано, але локальне очищення ще не завершено. Інші облікові записи залишаються доступними.';

  @override
  String get settingsDeleteAccountManagementNotConfirmed =>
      'Керування обліковим записом відкрито в браузері. Застосунок не отримав підтвердження видалення, тому сеанс чату залишається доступним.';

  @override
  String get settingsKeyBackup => 'Резервне копіювання ключів';

  @override
  String get settingsBackupEncryptionKeys => 'Резервні ключі шифрування';

  @override
  String settingsKeysBackedUp(int count) {
    return 'Збережено резервні копії ключів $count';
  }

  @override
  String get settingsBackupNotSet => 'Резервне копіювання не встановлено';

  @override
  String get settingsRestoreKeys => 'Відновити ключі';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Відновити ключі шифрування з резервної копії';

  @override
  String get settingsExportKeys => 'Ключі експорту';

  @override
  String get settingsExportKeysToFile => 'Експортувати ключі у файл';

  @override
  String get settingsLoggedInDevices => 'Пристрої, на яких виконано вхід';

  @override
  String get settingsNoOtherDevices => 'Немає інших пристроїв';

  @override
  String get settingsVerified => 'Перевірено';

  @override
  String get settingsUnverified => 'Неперевірений';

  @override
  String get settingsAdvanced => 'Просунутий';

  @override
  String get settingsCrossSigning => 'Перехресне підписання';

  @override
  String get settingsEnabled => 'Увімкнено';

  @override
  String get settingsNotEnabled => 'Не включено';

  @override
  String get settingsResetEncryption => 'Скинути шифрування';

  @override
  String get settingsDeleteAllEncryptionKeys => 'Видалити всі ключі шифрування';

  @override
  String get settingsEncryptionNotSupported => 'Шифрування не підтримується';

  @override
  String get settingsNotInitialized => 'Не ініціалізовано';

  @override
  String get settingsBackupKeyTitle => 'Резервні ключі';

  @override
  String get settingsBackupKeyMessage =>
      'Створити нову резервну копію ключа? Це допоможе вам відновити зашифровані повідомлення на новому пристрої.';

  @override
  String get settingsBackup => 'Резервне копіювання';

  @override
  String get settingsRestoreKeyTitle => 'Відновити ключі';

  @override
  String get settingsRestoreKeyMessage =>
      'Введіть свій пароль відновлення або ключ відновлення, щоб відновити зашифровані повідомлення.';

  @override
  String get settingsRestore => 'Відновити';

  @override
  String get settingsExportKeyTitle => 'Ключі експорту';

  @override
  String get settingsExportKeyMessage =>
      'Експортований файл ключа містить усі ваші ключі шифрування. Будь ласка, бережіть його в безпеці.';

  @override
  String get settingsExport => 'Експорт';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'ID пристрою: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Статус: перевірено';

  @override
  String get settingsDeviceStatusUnverified => 'Статус: не перевірено';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Остання активність: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Підтвердьте цей пристрій';

  @override
  String get settingsCrossSigningAlreadyEnabled =>
      'Перехресне підписання вже ввімкнено';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Перехресне підписання налаштовано успішно';

  @override
  String get settingsResetEncryptionTitle => 'Скинути шифрування';

  @override
  String get settingsResetEncryptionWarning =>
      'Попередження: це призведе до видалення всіх ваших ключів шифрування. Ви не зможете розшифрувати попередні зашифровані повідомлення. Цю дію не можна скасувати.';

  @override
  String get settingsReset => 'Скинути';

  @override
  String get settingsBackupSuccess => 'Резервну копію ключів успішно створено';

  @override
  String get settingsBackupFailed => 'Помилка резервного копіювання';

  @override
  String get settingsRecoveryKey => 'Ключ відновлення';

  @override
  String get settingsRecoveryKeySaveWarning =>
      'Збережіть цей ключ відновлення в безпечному місці. Він знадобиться вам, щоб відновити зашифровані повідомлення на новому пристрої.';

  @override
  String get settingsRecoveryKeySaved => 'Я зберіг його';

  @override
  String get settingsRestoreSuccess => 'Ключі успішно відновлені';

  @override
  String get settingsRestoreEmpty =>
      'У цій резервній копії немає ключів повідомлень.';

  @override
  String settingsRestoreSessions(int count) {
    return 'Відновлено сеансів ключів: $count. Повідомлення без ключів можуть залишитися зашифрованими.';
  }

  @override
  String get settingsRestoreFailed => 'Не вдалося відновити';

  @override
  String get settingsPassword => 'Пароль';

  @override
  String get settingsEnterRecoveryKey => 'Введіть ключ відновлення';

  @override
  String get settingsEnterPassword => 'Введіть пароль';

  @override
  String get settingsExportSuccess =>
      'Ключі успішно експортовано в резервну копію сервера';

  @override
  String get settingsExportNeedBackupFirst =>
      'Спершу створіть резервну копію ключа';

  @override
  String get settingsExportFailed => 'Помилка експорту';

  @override
  String get settingsResetSuccess => 'Скидання шифрування успішне';

  @override
  String get settingsResetFailed => 'Помилка скидання';

  @override
  String get callLeaveMeetingConfirm =>
      'Ви впевнені, що бажаєте залишити зустріч?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'тицьнув $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'Немає доступних контактів для додавання';

  @override
  String get chatAddMembers => 'Додати учасників';

  @override
  String chatInvitedMembers(int count) {
    return 'Запрошені члени $count';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Помилка запрошення: $error';
  }

  @override
  String get chatMemberRemoved => 'Учасника видалено';

  @override
  String chatRemoveFailed(String error) {
    return 'Не вдалося видалити: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'Після надсилання інша сторона може бачити ваше місцезнаходження в реальному часі протягом 1 години.';

  @override
  String get chatStartSharing => 'Почніть ділитися';

  @override
  String get chatLocationServiceNotEnabled => 'Службу локації не ввімкнено';

  @override
  String get chatEnableLocationService =>
      'Увімкніть службу визначення місцезнаходження, щоб використовувати цю функцію';

  @override
  String get chatGoToSettings => 'Перейдіть до Налаштувань';

  @override
  String get chatLocationPermissionRequired =>
      'Для цієї функції потрібен дозвіл на місцезнаходження';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'Дозвіл на визначення місцезнаходження назавжди відмовлено. Увімкніть його в налаштуваннях.';

  @override
  String get chatLocationPermissionDenied =>
      'Дозвіл на місцезнаходження відмовлено';

  @override
  String get chatGettingLocation => 'Отримання місцезнаходження...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Не вдалося отримати місцезнаходження: $error';
  }

  @override
  String get chatMapPreview => 'Попередній перегляд карти';

  @override
  String get chatSearchLocation => 'Місце пошуку';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'Надіслано червоний пакет $amount $token';
  }

  @override
  String get chatTransferDefault => 'Трансфер';

  @override
  String chatTransferSent(String amount, String token) {
    return 'Надіслано переказ $amount $token';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Не вдалося вибрати файл: $error';
  }

  @override
  String get chatFileSizeLimit => 'Розмір файлу не може перевищувати 50 МБ';

  @override
  String chatFileSending(String filename) {
    return 'Надсилання файлу: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Не вдалося надіслати файл: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'Надіслано контактну картку $name';
  }

  @override
  String get chatFavoritesFeature => 'Вибране';

  @override
  String get chatCouponsFeature => 'Купони';

  @override
  String get chatGiftFeature => 'Подарунок';

  @override
  String chatSharedMusic(String name) {
    return 'Поділився $name';
  }

  @override
  String get chatEndPollTitle => 'Завершити опитування';

  @override
  String get chatEndPollConfirmMessage =>
      'Ви впевнені, що бажаєте завершити це опитування? Після закінчення голосування буде закрито.';

  @override
  String get chatPollEndedMessage => 'Опитування завершено';

  @override
  String get chatConnectingCall => 'Підключення...';

  @override
  String get chatMuteCall => 'Вимкнути звук';

  @override
  String get chatSpeakerOff => 'Динамік вимкнено';

  @override
  String get chatSpeakerOn => 'Спікер';

  @override
  String get chatCameraOn => 'Камера включена';

  @override
  String get chatCameraOff => 'Камера вимкнена';

  @override
  String get chatHangUp => 'Повісити трубку';

  @override
  String get chatSelectForwardTargetTitle => 'Виберіть Переслати ціль';

  @override
  String get chatNoForwardableChat => 'Немає чатів, доступних для пересилання';

  @override
  String get chatNoMatchingChat => 'Відповідних чатів не знайдено';

  @override
  String get chatLocationTitle => 'Розташування';

  @override
  String get chatSendButton => 'Надіслати';

  @override
  String get chatRetryButton => 'Повторіть спробу';

  @override
  String get chatSearchContactHint => 'Пошук контактів';

  @override
  String get chatShareMusic => 'Поділіться музикою';

  @override
  String get chatRecentPlayed => 'Останні';

  @override
  String get chatMyFavorites => 'Вибране';

  @override
  String get chatNetworkLink => 'Посилання';

  @override
  String get chatLocalFile => 'Місцевий';

  @override
  String get chatPasteMusicLink => 'Вставте посилання на музику';

  @override
  String get chatShareMusicButton => 'Поділіться музикою';

  @override
  String get chatSelectLocalAudio => 'Виберіть Локальний аудіофайл';

  @override
  String get chatSupportedAudioFormats => 'Підтримує MP3, M4A, WAV, FLAC тощо.';

  @override
  String get chatSelectFileButton => 'Виберіть Файл';

  @override
  String get chatPleaseEnterMusicLink => 'Введіть посилання на музику';

  @override
  String get chatPleaseEnterValidLink => 'Введіть дійсну URL-адресу';

  @override
  String get chatSharedSong => 'Спільна пісня';

  @override
  String get chatSelectMember => 'Виберіть Член';

  @override
  String get chatSearchMemberHint => 'Пошук учасників';

  @override
  String get chatNoMatchingMembers => 'Відповідних учасників не знайдено';

  @override
  String get commonUnknownMember => 'Невідомий';

  @override
  String chatSelectedMessagesCount(int count) {
    return 'Вибрані повідомлення $count';
  }

  @override
  String get chatSearchContactsOrGroups => 'Пошук контактів або груп';

  @override
  String get chatVideoTitle => 'відео';

  @override
  String get chatLoadingText => 'Завантаження...';

  @override
  String get chatVideoLoadFailed => 'Помилка завантаження відео';

  @override
  String get chatPlayerInitFailed => 'Помилка ініціалізації програвача';

  @override
  String get chatCreatePollTitle => 'Створити опитування';

  @override
  String get chatSubmitPoll => 'Надіслати';

  @override
  String get chatPollQuestionLabel => 'Опитування';

  @override
  String get chatEnterPollQuestionHint => 'Введіть запитання опитування';

  @override
  String get chatPollOptionsLabel => 'Опції опитування';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Варіант $index';
  }

  @override
  String get chatAddOptionButton => 'Додати варіант';

  @override
  String get chatPollSettingsLabel => 'Налаштування опитування';

  @override
  String get chatSelectionType => 'Тип вибору';

  @override
  String get chatSingleChoiceLabel => 'неодружений';

  @override
  String get chatMultiChoiceLabel => 'Мульти';

  @override
  String get chatAnonymousPollSwitch => 'Анонімне опитування';

  @override
  String get chatPleaseEnterQuestion => 'Введіть запитання опитування';

  @override
  String get chatAtLeastTwoOptions => 'Потрібно принаймні 2 варіанти';

  @override
  String chatConfirmWithCount(int count) {
    return 'Підтвердити ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'Підтвердження електронної пошти';

  @override
  String get authEnterValidEmailAddress => 'Введіть дійсну електронну адресу';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Код підтвердження надіслано на $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Не вдалося надіслати код: $error';
  }

  @override
  String get authVerificationSuccess => 'Перевірка успішна';

  @override
  String get authVerificationFailed => 'Не вдалося перевірити';

  @override
  String authVerificationCodeError(String error) {
    return 'Помилка коду підтвердження: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Введіть код підтвердження';

  @override
  String get authEnterYourEmail => 'Введіть адресу електронної пошти';

  @override
  String authWeSentCodeTo(String email) {
    return 'Ми надіслали 6-значний код на адресу\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'Введіть адресу електронної пошти, ми надішлемо код підтвердження';

  @override
  String get commonSendVerificationCode => 'Надіслати код підтвердження';

  @override
  String get authResendVerificationCode =>
      'Повторно надіслати код підтвердження';

  @override
  String authCanResendAfter(int seconds) {
    return 'Можна повторно надіслати через $seconds секунд';
  }

  @override
  String get commonChangeEmail => 'Змінити електронну адресу';

  @override
  String get contactAddToContacts => 'Додати до контактів';

  @override
  String get contactAddingToContacts => 'Додавання...';

  @override
  String get contactAddedToContacts => 'Додано до контактів';

  @override
  String contactAddFailedWithError(String error) {
    return 'Не вдалося додати: $error';
  }

  @override
  String get contactAddPhone => 'Додати телефон';

  @override
  String get contactAddTag => 'Додайте теги';

  @override
  String get contactAddText => 'Додайте текст';

  @override
  String get contactAddPhoto => 'Додайте фото';

  @override
  String contactGroupCountLabel(int count) {
    return 'Групи $count';
  }

  @override
  String get contactAddedViaSearch => 'Додано через пошук';

  @override
  String get contactAddTime => 'Додайте час';

  @override
  String get contactDoneButton => 'Готово';

  @override
  String get callWaitingForParticipants => 'Чекаємо на приєднання учасників...';

  @override
  String callParticipantMe(String name) {
    return '$name (Я)';
  }

  @override
  String get callSharingLabel => 'Обмін';

  @override
  String callScreenSharingBy(String name) {
    return '$name ділиться екраном';
  }

  @override
  String callParticipantCount(int count) {
    return '$count учасників';
  }

  @override
  String get callMuteLabel => 'Вимкнути звук';

  @override
  String get callUnmuteLabel => 'Увімкнути звук';

  @override
  String get callTurnOffVideo => 'Вимкніть відео';

  @override
  String get callTurnOnVideo => 'Увімкніть відео';

  @override
  String get callShareScreen => 'Поділитися екраном';

  @override
  String get callStopSharing => 'Припинити ділитися';

  @override
  String get callSwitchCameraLabel => 'Перемикач';

  @override
  String get callLeaveLabel => 'Залиште';

  @override
  String get callParticipantsLabel => 'Учасники';

  @override
  String get callJoiningMeeting => 'Приєднання до зустрічі...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count голосів ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count учасників';
  }

  @override
  String get chatNoMediaUrlAvailable => 'Немає доступної URL-адреси медіа';

  @override
  String chatDownloadFailed(String code) {
    return 'Помилка завантаження: $code';
  }

  @override
  String chatErrorWithMessage(String message) {
    return 'Помилка: $message';
  }

  @override
  String get chatMusicLinkLabel => 'Посилання на музику';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Червоні пакети та перекази не пересилаються';

  @override
  String commonShareFailed(String error) {
    return 'Не вдалося поділитися: $error';
  }

  @override
  String get commonTapToRetry => 'Торкніться, щоб повторити спробу';

  @override
  String get chatDefaultRedPacketGreeting => 'Найкращі побажання процвітання';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Дозвольте іншим шукати та приєднуватися';

  @override
  String get groupConfirmClearChatHistory =>
      'Ви впевнені, що бажаєте очистити історію чату?';

  @override
  String get groupCreateGroupToChat =>
      'Створіть групу, щоб розпочати спілкування';

  @override
  String get groupEditGroupAnnouncement => 'Редагувати оголошення групи';

  @override
  String get groupEditGroupDescription => 'Редагувати опис групи';

  @override
  String get groupEnterGroupAnnouncement => 'Введіть групове оголошення';

  @override
  String groupMemberCountClickToCopy(Object count) {
    return 'Учасники $count, натисніть, щоб скопіювати ідентифікатор групи';
  }

  @override
  String get groupNoPermissionToEditGroupName =>
      'Ви не маєте дозволу редагувати назву групи';

  @override
  String get authEmailAddress => 'Адреса електронної пошти';

  @override
  String get commonEnterEmailAddress => 'Введіть електронну адресу';

  @override
  String get authEmailRecoveryHint => 'Використовується для відновлення пароля';

  @override
  String get commonInvalidEmailFormat => 'Введіть дійсну електронну адресу';

  @override
  String get authOptional => 'Додатково';

  @override
  String get authResetPassword => 'Скинути пароль';

  @override
  String get authEnterRegisteredEmail =>
      'Введіть адресу електронної пошти, яку ви зареєстрували';

  @override
  String get authSendResetCode => 'Надіслати код скидання';

  @override
  String authResetCodeSent(String email) {
    return 'Код скидання, надісланий на $email';
  }

  @override
  String get authEnterResetCode => 'Введіть код скидання';

  @override
  String get authSetNewPassword => 'Встановити новий пароль';

  @override
  String get commonConfirmNewPassword => 'Підтвердьте новий пароль';

  @override
  String get commonNewPassword => 'Новий пароль';

  @override
  String get authPasswordResetSuccess =>
      'Скидання пароля успішне. Будь ласка, увійдіть з новим паролем.';

  @override
  String get authResetPasswordFailed => 'Не вдалося скинути пароль';

  @override
  String get settingsChangePassword => 'Змінити пароль';

  @override
  String get settingsCurrentPassword => 'Поточний пароль';

  @override
  String get settingsEnterCurrentPassword => 'Введіть поточний пароль';

  @override
  String get settingsEnterNewPassword => 'Введіть новий пароль';

  @override
  String get settingsPasswordChanged =>
      'Пароль успішно змінено. Будь ласка, увійдіть з новим паролем.';

  @override
  String get settingsChangePasswordFailed => 'Не вдалося змінити пароль';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'Новий пароль має відрізнятися від поточного';

  @override
  String get settingsChangePasswordInfo =>
      'Після зміни пароля ви вийдете з системи, і вам потрібно буде увійти з новим паролем.';

  @override
  String get settingsPasswordRequirements => 'Вимоги до пароля:';

  @override
  String get settingsSecurityNote =>
      'З міркувань безпеки вам потрібно буде повторно ввійти на всіх пристроях після зміни пароля.';

  @override
  String get settingsSecurity => 'Безпека';

  @override
  String get settingsCurrentBoundEmail =>
      'Поточний прив\'язаний електронний лист';

  @override
  String get settingsNewEmailAddress => 'Нова електронна адреса';

  @override
  String get settingsEnterNewEmail => 'Введіть нову електронну адресу';

  @override
  String get settingsVerificationCode => 'Код підтвердження';

  @override
  String get settingsVerificationCodeSent => 'Код підтвердження надіслано';

  @override
  String get settingsCodeSentTo => 'Код підтвердження надіслано';

  @override
  String get settingsDidNotReceiveCode => 'Не отримали код?';

  @override
  String get settingsEmailChangedSuccess => 'Електронну адресу змінено успішно';

  @override
  String get settingsChangeEmailFailed =>
      'Не вдалося змінити електронну адресу';

  @override
  String get settingsEmailSecurityNote =>
      'Ваша електронна пошта використовується для відновлення пароля. Будь ласка, тримайте його в безпеці.';

  @override
  String get commonGoogleLogin => 'Увійдіть за допомогою Google';

  @override
  String get commonAppleLogin => 'Увійдіть за допомогою Apple';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Мова';

  @override
  String get settingsLanguageChanged => 'Мова змінена';

  @override
  String get settingsTranslation => 'Переклад';

  @override
  String get settingsTranslateTextTo => 'Перекласти текст на';

  @override
  String get settingsTranslateDescription =>
      'Виберіть мову, на яку потрібно перекладати повідомлення.';

  @override
  String get settingsAutoTranslate =>
      'Автоматичний переклад отриманих повідомлень';

  @override
  String get settingsAutoTranslateDescription =>
      'Автоматично перекладайте повідомлення, отримані в чаті, на вибрану мову.';

  @override
  String get settingsBiometricLogin => 'Біометричний логін';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Увійдіть за допомогою $type';
  }

  @override
  String get settingsBiometricLoginEnabled => 'Біометричний вхід увімкнено';

  @override
  String get settingsBiometricLoginDisabled => 'Біометричний вхід вимкнено';

  @override
  String get settingsEnableBiometricLogin => 'Увімкнути біометричний вхід';

  @override
  String get settingsBiometricEnabled =>
      'Увімкнено – використовувати біометричні дані для входу';

  @override
  String get settingsBiometricDisabled =>
      'Вимкнено – торкніться, щоб увімкнути';

  @override
  String get settingsBiometricNeedRelogin =>
      'Будь ласка, вийдіть із системи та увійдіть знову, щоб увімкнути біометричний вхід';

  @override
  String get authOr => 'АБО';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'Доступ до камери на цьому пристрої обмежено';

  @override
  String get authPasskeyLabel => 'Ключ доступу';

  @override
  String get authGoogleLabel => 'Google';

  @override
  String get authAppleLabel => 'Яблуко';

  @override
  String get authSsoLabel => 'SSO';

  @override
  String get authSsoNotConfigured =>
      'Цей сервер не налаштував провайдерів входу SSO';

  @override
  String get transferAmountHintZero => '0,00';

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
      'Введіть суфікс тицьнути, наприклад: на плечі';

  @override
  String get groupAlbum => 'Альбом групи';

  @override
  String get groupFiles => 'Файли групи';

  @override
  String get groupImages => 'Зображення';

  @override
  String get groupVideos => 'Відео';

  @override
  String get groupTotal => 'Всього';

  @override
  String get groupSize => 'Розмір';

  @override
  String get groupNoMedia => 'Без медіа';

  @override
  String get groupNoMediaDescription => 'У цій групі ще немає фото чи відео';

  @override
  String get groupDocuments => 'документи';

  @override
  String get groupNoFiles => 'Немає файлів';

  @override
  String get groupNoFilesDescription => 'У цій групі ще немає файлів';

  @override
  String groupDownloadStarted(String filename) {
    return 'Завантаження $filename...';
  }

  @override
  String get contactNoCommonGroups => 'Немає спільних груп';

  @override
  String get contactNoCommonGroupsDescription => 'У вас немає спільних груп';

  @override
  String get chatVoiceMessage => 'Голос';

  @override
  String get chatMessage => 'повідомлення';

  @override
  String get conversationHideChat => 'Сховати';

  @override
  String get settingsQuickReply => 'Швидка відповідь';

  @override
  String get commonTranslate => 'Перекласти';

  @override
  String get contactCreateTag => 'Створити тег';

  @override
  String get contactEnterTagName => 'Введіть назву тегу';

  @override
  String get contactEditTag => 'Редагувати тег';

  @override
  String get contactDeleteTag => 'Видалити тег';

  @override
  String contactDeleteTagConfirm(String tagName) {
    return 'Ви впевнені, що хочете видалити тег \"$tagName\"?';
  }

  @override
  String get contactNoTags => 'Тегів ще немає';

  @override
  String get contactFriendPermissions => 'Дозволи друзів';

  @override
  String get contactSetChatOnly => 'Установити лише для чату';

  @override
  String get contactChatOnlyDesc =>
      'Можна спілкуватися лише з вами, інший вміст буде приховано';

  @override
  String get contactHideMyMoments => 'Приховати мої моменти';

  @override
  String get contactHideMyMomentsDesc => 'Цей друг не може бачити мої моменти';

  @override
  String get contactHideTheirMoments => 'Приховати їхні моменти';

  @override
  String get contactHideTheirMomentsDesc => 'Не бачити моменти цього друга';

  @override
  String get contactHideMyStatus => 'Приховати мій статус';

  @override
  String get contactHideMyStatusDesc =>
      'Цей друг не може бачити оновлення мого статусу';

  @override
  String get contactNoChatOnlyFriends =>
      'Без друзів, які спілкуються лише в чаті';

  @override
  String get contactNoOfficialAccounts => 'Немає офіційних облікових записів';

  @override
  String get contactFollowOfficialAccountsDesc =>
      'Слідкуйте за офіційними акаунтами, щоб отримувати останні оновлення';

  @override
  String get contactNoServiceAccounts => 'Немає сервісних облікових записів';

  @override
  String get contactSubscribeServiceAccountsDesc =>
      'Підпишіться на сервісні акаунти, щоб отримати зручні послуги';

  @override
  String get contactNoEnterpriseContacts => 'Немає контактів підприємства';

  @override
  String get contactEnterpriseContactsDesc =>
      'Тут відображатимуться контакти підприємства';

  @override
  String get profileCardPack => 'Пакет карток';

  @override
  String get profileOrders => 'Замовлення';

  @override
  String get profileNoOrders => 'Без замовлень';

  @override
  String get profileOrdersDesc => 'Тут відображатимуться ваші замовлення';

  @override
  String get profileNoCards => 'Без карток';

  @override
  String get profileCardsDesc => 'Тут відображатимуться ваші картки';

  @override
  String get favoriteEnterTagsHint => 'Введіть теги, розділені комами';

  @override
  String get favoriteTagsUpdated => 'Теги оновлено';

  @override
  String get favoriteForwardedContent => 'Вміст переслано';

  @override
  String get favoriteEnterNoteContent => 'Введіть вміст нотатки';

  @override
  String get favoriteNoteAdded => 'Примітка додана';

  @override
  String get favoriteLinkTitle => 'Назва посилання';

  @override
  String get favoriteLinkUrl => 'https://';

  @override
  String get favoriteLinkAdded => 'Посилання додано';

  @override
  String get contactPhotoAdded => 'Фото додано';

  @override
  String get contactEnterPhone => 'Введіть номер телефону';

  @override
  String commonConversationWithId(Object roomId) {
    return 'Розмова: $roomId';
  }

  @override
  String commonContactWithId(Object userId) {
    return 'Контакт: $userId';
  }

  @override
  String get commonDiscover => 'Відкрийте для себе';

  @override
  String commonDeveloping(Object title) {
    return '$title\n(Незабаром)';
  }

  @override
  String get commonPageNotFound => 'Сторінка не знайдена';

  @override
  String get commonBackToHome => 'Назад додому';

  @override
  String get settingsMessageNotifications => 'Сповіщення про повідомлення';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Отримувати сповіщення про нові повідомлення';

  @override
  String get settingsShowMessagePreview =>
      'Показати попередній перегляд повідомлення';

  @override
  String get settingsShowMessageContentInNotification =>
      'Показати вміст повідомлення в сповіщенні';

  @override
  String get settingsNotificationSound => 'Звук сповіщення';

  @override
  String get settingsPlaySoundOnMessage =>
      'Відтворення звуку під час отримання повідомлень';

  @override
  String get commonVibration => 'Вібрація';

  @override
  String get settingsVibrateOnMessage =>
      'Вібрувати під час отримання повідомлень';

  @override
  String get settingsDoNotDisturbMode => 'Не турбувати';

  @override
  String get settingsDoNotDisturbDescription =>
      'Не отримувати сповіщення протягом зазначеного часу';

  @override
  String get settingsStartTime => 'Час початку';

  @override
  String get settingsEndTime => 'Час закінчення';

  @override
  String get settingsDeleteQuickReply => 'Видалити швидку відповідь';

  @override
  String get settingsEditQuickReply => 'Редагувати швидку відповідь';

  @override
  String get settingsAddQuickReply => 'Додати швидку відповідь';

  @override
  String get settingsManageQuickReplies => 'Керуйте швидкими відповідями';

  @override
  String get settingsNoQuickReplies => 'Немає швидких відповідей';

  @override
  String get settingsDefaultQuickReplies =>
      'Відображатимуться стандартні швидкі відповіді';

  @override
  String get settingsWhoCanSee => 'Хто бачить';

  @override
  String get settingsLastSeen => 'Останній раз';

  @override
  String get settingsHiddenChats => 'Приховані чати';

  @override
  String get settingsMessagesLabel => 'Повідомлення';

  @override
  String get settingsAllowStrangerMessages =>
      'Дозволити незнайомі повідомлення';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Отримувати повідомлення від неконтактних осіб';

  @override
  String get settingsReadReceipts => 'Прочитати квитанції';

  @override
  String get settingsLetOthersKnowYouRead => 'Нехай інші знають, що ви читаєте';

  @override
  String get settingsTypingIndicator => 'Індикатор набору тексту';

  @override
  String get settingsLetOthersKnowYouTyping =>
      'Нехай інші знають, що ви друкуєте';

  @override
  String get settingsEveryone => 'Всі';

  @override
  String get settingsContactsOnly => 'Лише контакти';

  @override
  String get settingsNobody => 'ніхто';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Хто може бачити $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Версія $version';
  }

  @override
  String get settingsCheckForUpdates => 'Перевірте наявність оновлень';

  @override
  String get settingsOpenSourceLicenses => 'Ліцензії з відкритим кодом';

  @override
  String get settingsFeedbackAndSuggestions => 'Відгуки та пропозиції';

  @override
  String get settingsBuiltOnMatrix => 'Побудований на основі протоколу Matrix';

  @override
  String get settingsNoHiddenChats => 'Жодних прихованих чатів';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Чати, які ви приховуєте, відображатимуться тут';

  @override
  String get settingsUnhideChat => 'Показати';

  @override
  String get settingsDarkMode => 'Темний режим';

  @override
  String get settingsFontSize => 'Розмір шрифту';

  @override
  String get settingsBubbleStyle => 'Стиль бульбашки';

  @override
  String get settingsFollowSystem => 'Слідкуйте за системою';

  @override
  String get settingsAutoSwitchBySystem => 'Автоматичне перемикання системою';

  @override
  String get settingsLightMode => 'Світловий режим';

  @override
  String get settingsAlwaysUseLightTheme => 'Завжди використовуйте світлу тему';

  @override
  String get settingsDarkModeOption => 'Опція темного режиму';

  @override
  String get settingsAlwaysUseDarkTheme => 'Завжди використовуйте темну тему';

  @override
  String get settingsFontSizeSmall => 'Маленький';

  @override
  String get settingsFontSizeStandard => 'Стандартний';

  @override
  String get settingsFontSizeLarge => 'Великий';

  @override
  String get settingsFontSizeExtraLarge => 'Дуже великий';

  @override
  String get settingsBubbleStyleWechat => 'Стиль WeChat';

  @override
  String get settingsBubbleStyleWechatDesc =>
      'Класичний стиль бульбашки WeChat';

  @override
  String get settingsBubbleStyleModern => 'Сучасний стиль';

  @override
  String get settingsBubbleStyleModernDesc => 'Чистий сучасний стиль міхура';

  @override
  String get settingsBubbleStyleClassic => 'Класичний стиль';

  @override
  String get settingsBubbleStyleClassicDesc => 'Традиційний стиль бульбашок';

  @override
  String get discoverVideoChannels => 'Канали';

  @override
  String get discoverLive => 'Жити';

  @override
  String get discoverListen => 'Слухай';

  @override
  String get discoverWatch => 'Дивитися';

  @override
  String get discoverSearchDiscover => 'Пошук';

  @override
  String get discoverNearbyPeople => 'Поруч';

  @override
  String get discoverGames => 'Ігри';

  @override
  String get discoverMiniPrograms => 'Міні програми';

  @override
  String get chatAlreadyInCall => 'Уже в дзвінку';

  @override
  String get commonConnectionFailed => 'Помилка підключення';

  @override
  String get chatCallRejected => 'Дзвінок відхилено';

  @override
  String get chatNoAnswer => 'Відповіді немає';

  @override
  String get commonClose => 'Закрити';

  @override
  String get chatSelectContact => 'Виберіть Контакт';

  @override
  String get chatVoteRemoved => 'Голос видалено';

  @override
  String get chatVoteChanged => 'Голосування змінено';

  @override
  String get chatVoted => 'Проголосував';

  @override
  String chatReplyTo(String name) {
    return 'Відповісти $name';
  }

  @override
  String get chatCurrentLocation => 'Поточне місцезнаходження';

  @override
  String chatNearbyPlace(int index) {
    return 'Місце поблизу $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Про $distance';
  }

  @override
  String get chatAddress => 'Адреса';

  @override
  String get chatLatitude => 'Широта';

  @override
  String get chatLongitude => 'Довгота';

  @override
  String get groupDescriptionUpdated => 'Оновлено опис групи';

  @override
  String get groupAvatarUpdated => 'Аватар групи оновлено';

  @override
  String get groupVisibilityUpdated => 'Видимість групи оновлено';

  @override
  String get groupChannelCreated => 'Канал створено';

  @override
  String get groupChannelUpdated => 'Канал оновлено';

  @override
  String get groupChannelDeleted => 'Канал видалено';

  @override
  String get callDecline => 'відхилити';

  @override
  String get callAnswer => 'Відповідь';

  @override
  String get callIncomingVideoCall => 'Вхідний відеодзвінок';

  @override
  String get callIncomingVoiceCall => 'Вхідний голосовий виклик';

  @override
  String get callVideoCallInProgress => 'Триває відеодзвінок';

  @override
  String get callVoiceCallInProgress => 'Виконується голосовий виклик';

  @override
  String get callReconnectingCall => 'Повторне підключення...';

  @override
  String get callEnded => 'Дзвінок завершено';

  @override
  String get callFailed => 'Помилка виклику';

  @override
  String get callLivekitNotConfigured => 'LiveKit не налаштовано';

  @override
  String callJoinMeetingFailed(Object error) {
    return 'Не вдалося приєднатися до зустрічі: $error';
  }

  @override
  String callScreenShareFailed(Object error) {
    return 'Не вдалося поділитися екраном: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Бін';

  @override
  String get profileNoN42Bean => 'Ні N42 Bean';

  @override
  String get profileN42BeanDetails => 'N42 Bean Деталі';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean — це маркер, який використовується для викупу віртуальних предметів і послуг у N42. На даний момент доступний для:';

  @override
  String get profileN42BeanFeature1 =>
      'Ексклюзивні наклейки та теми для учасників';

  @override
  String get profileN42BeanFeature2 => 'Налаштування спливаючої підказки чату';

  @override
  String get profileN42BeanFeature3 =>
      'Налаштування червоної обкладинки пакета';

  @override
  String get profileN42BeanFeature4 => 'Ексклюзивний значок з псевдонімом';

  @override
  String get profileN42BeanFeature5 => 'Привілеї групового чату';

  @override
  String get profileN42BeanFeature6 => 'Розширення хмарного сховища';

  @override
  String get profileN42BeanFeature7 => 'Фільтри краси для відеодзвінків';

  @override
  String get profileN42BeanFeature8 => 'Налаштування фону моментів';

  @override
  String get profileN42BeanFeature9 => 'Пріоритет обслуговування клієнтів VIP';

  @override
  String get profileGotIt => 'зрозумів';

  @override
  String get profileNoN42BeanRecords => 'Немає записів N42 Bean';

  @override
  String get profileMoodAndThoughts => 'Настрій і думки';

  @override
  String get profileStatusHappy => 'Щаслива';

  @override
  String get profileStatusCracked => 'Розбитий';

  @override
  String get profileStatusLucky => 'Щасливчик';

  @override
  String get profileStatusSunny => 'Сонячно';

  @override
  String get profileStatusTired => 'Втомилася';

  @override
  String get profileStatusDaydream => 'мрія';

  @override
  String get profileStatusRushing => 'Поспіх';

  @override
  String get profileStatusOverthinking => 'Надмірне мислення';

  @override
  String get profileStatusEnergized => 'Під напругою';

  @override
  String get profileWorkAndStudy => 'Робота та навчання';

  @override
  String get profileStatusWorking => 'Працює';

  @override
  String get profileStatusStudying => 'навчання';

  @override
  String get profileStatusBusy => 'зайнятий';

  @override
  String get profileStatusSlacking => 'розхитування';

  @override
  String get profileStatusTraveling => 'Подорожі';

  @override
  String get profileStatusGoingHome => 'Йду додому';

  @override
  String get profileStatusDnd => 'Не турбувати';

  @override
  String get profileActivities => 'Діяльність';

  @override
  String get profileStatusHanging => 'Тусовка';

  @override
  String get profileStatusCheckIn => 'Заїзд';

  @override
  String get profileStatusExercising => 'Заняття спортом';

  @override
  String get profileStatusCoffee => 'кава';

  @override
  String get profileStatusBubbleTea => 'Бульбашковий чай';

  @override
  String get profileStatusEating => 'прийом їжі';

  @override
  String get profileStatusParenting => 'Виховання дітей';

  @override
  String get profileStatusSavingWorld => 'Порятунок світу';

  @override
  String get profileStatusSelfie => 'Селфі';

  @override
  String get profileRest => 'Відпочинок';

  @override
  String get profileStatusRetreat => 'Відступ';

  @override
  String get profileStatusHome => 'додому';

  @override
  String get profileStatusSleeping => 'спить';

  @override
  String get profileStatusCatLover => 'Любитель кішок';

  @override
  String get profileStatusDogWalking => 'Вигул собаки';

  @override
  String get profileStatusGaming => 'Ігри';

  @override
  String get profileStatusListening => 'Слухання';

  @override
  String get profileEditAddress => 'Редагувати адресу';

  @override
  String get profileRecipient => 'одержувач';

  @override
  String get profileEnterRecipientName => 'Введіть ім\'я одержувача';

  @override
  String get profilePhoneNumber => 'Номер телефону';

  @override
  String get profileEnterPhoneNumber => 'Введіть номер телефону';

  @override
  String get profileRegionHint => 'Провінція/місто/район';

  @override
  String get profileDetailedAddress => 'Детальна адреса';

  @override
  String get profileDetailedAddressHint => 'Вулиця, номер будинку тощо.';

  @override
  String get profileSetAsDefaultAddress => 'Встановити як адресу за умовчанням';

  @override
  String get profilePleaseCompleteInfo => 'Будь ласка, заповніть усі поля';

  @override
  String get profileEditInvoice => 'Редагувати рахунок-фактуру';

  @override
  String get profileInvoiceType => 'Тип рахунку-фактури';

  @override
  String get profileCompanyName => 'Назва компанії';

  @override
  String get profilePersonalName => 'Особисте ім\'я';

  @override
  String get profileEnterCompanyName => 'Введіть назву компанії';

  @override
  String get profileEnterName => 'Введіть ім\'я';

  @override
  String get profileTaxIdNumber => 'Ідентифікаційний податковий номер';

  @override
  String get profileEnterTaxIdNumber => 'Введіть податковий номер';

  @override
  String get profileBankNameOptional => 'Назва банку (необов\'язково)';

  @override
  String get profileEnterBankName => 'Введіть назву банку';

  @override
  String get profileBankAccountOptional =>
      'Банківський рахунок (необов\'язково)';

  @override
  String get profileEnterBankAccount => 'Введіть банківський рахунок';

  @override
  String get profileCompanyAddressOptional =>
      'Адреса компанії (необов\'язково)';

  @override
  String get profileEnterCompanyAddress => 'Введіть адресу компанії';

  @override
  String get profileCompanyPhoneOptional => 'Телефон компанії (необов\'язково)';

  @override
  String get profileEnterCompanyPhone => 'Введіть телефон компанії';

  @override
  String get profileSetAsDefaultInvoice =>
      'Встановити як рахунок-фактуру за умовчанням';

  @override
  String get profileRingtoneVibrate => 'Вібрувати';

  @override
  String get profileRingtoneSilent => 'Мовчазний';

  @override
  String get profileVibrateMode => 'Режим вібрації';

  @override
  String get profileSilentMode => 'Безшумний режим';

  @override
  String profilePlayFailed(Object ringtoneName) {
    return 'Не вдалося відтворити: $ringtoneName';
  }

  @override
  String profilePlaying(Object ringtoneName) {
    return 'Грає: $ringtoneName';
  }

  @override
  String get profileStop => 'Стоп';

  @override
  String get profileSelectRingtone => 'Виберіть Мелодія';

  @override
  String get profileLoadingRingtones => 'Завантаження мелодій...';

  @override
  String get profileNoRingtonesFound => 'Мелодії дзвінка не знайдено';

  @override
  String mainMessagesWithCount(int count) {
    return 'Повідомлення ($count)';
  }

  @override
  String get storyViewers => 'Глядачі';

  @override
  String get storyNoViewers => 'Глядачів ще немає';

  @override
  String get storyReplyToStory => 'Відповісти на історію...';

  @override
  String get commonCopiedToClipboard => 'Скопійовано в буфер обміну';

  @override
  String get commonMore => 'більше';

  @override
  String get commonTranslating => 'Переклад...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Переклад з $language';
  }

  @override
  String get commonTranslation => 'Переклад';

  @override
  String get commonTranslationFailed => 'Помилка перекладу';

  @override
  String get commonAllRead => 'Всі читали';

  @override
  String commonReadCount(Object count) {
    return '$count читати';
  }

  @override
  String get commonYouRecalledMessage => 'Ви відкликали повідомлення';

  @override
  String get commonMessageRecalled => 'Повідомлення відкликано';

  @override
  String get commonReEdit => 'Перередагувати';

  @override
  String get commonWalletArea => 'Зона гаманця';

  @override
  String get callIncomingCall => 'Вхідний дзвінок';

  @override
  String get callMissedCall => 'Пропущений дзвінок';

  @override
  String get groupRemoveAdmin => 'Видалити адміністратора';

  @override
  String get chatSelectCurrency => 'Виберіть валюту';

  @override
  String get chatSelectEmoji => 'Виберіть Emoji';

  @override
  String get chatSelectRedPacketCover => 'Виберіть Обкладинка';

  @override
  String get groupSetAsAdmin => 'Встановити як адміністратора';

  @override
  String get chatVideoPlaybackFailed => 'Помилка відтворення відео';

  @override
  String get groupViewProfile => 'Переглянути профіль';

  @override
  String get favoriteAddLinkComingSoon => 'Незабаром додайте функцію посилання';

  @override
  String get favoriteNewNoteComingSoon =>
      'Незабаром з’явиться нова функція нотаток';

  @override
  String get qrcodeSaveFeatureComingSoon =>
      'Незабаром з’явиться функція збереження';

  @override
  String get qrcodeShareFeatureComingSoon =>
      'Незабаром буде доступна функція спільного доступу';

  @override
  String qrcodeProcessFailed(String error) {
    return 'Не вдалося обробити QR-код: $error';
  }

  @override
  String get securityDeviceIdRequired =>
      'Потрібно ввести ідентифікатор пристрою';

  @override
  String securityVerificationStartFailed(String error) {
    return 'Не вдалося розпочати перевірку: $error';
  }

  @override
  String get securityVerificationFailed => 'Не вдалося перевірити';

  @override
  String securityVerificationFailedWithReason(String reason) {
    return 'Не вдалося перевірити: $reason';
  }

  @override
  String get securityEmojiMismatchRejected =>
      'Перевірку відхилено – смайли не збігаються';

  @override
  String get securityWaitingForDeviceAccept =>
      'Очікування на прийняття іншим пристроєм...';

  @override
  String get securityVerifyDevice => 'Підтвердьте цей пристрій';

  @override
  String get securityConfirmEmojiMatch =>
      'Переконайтеся, що наведені нижче смайли відображаються на обох пристроях в однаковому порядку';

  @override
  String get securityEmojiDontMatch => 'Вони не збігаються';

  @override
  String get securityEmojiMatch => 'Вони збігаються';

  @override
  String get securityWaitingForDeviceConfirm =>
      'Очікування підтвердження від іншого пристрою...';

  @override
  String get securityVerificationSuccess => 'Перевірка успішна!';

  @override
  String get securityDeviceVerifiedTrusted =>
      'Цей пристрій тепер перевірено та надійно.';

  @override
  String get securityCompareEmoji => 'Порівняйте емодзі на обох пристроях';

  @override
  String get securityCompareNumbers => 'Порівняйте цифри на обох пристроях';

  @override
  String get commonTryAgain => 'Спробуйте знову';

  @override
  String get commonDone => 'Готово';

  @override
  String get chatExportTitle => 'Експорт чату';

  @override
  String get chatExportSuccess => 'Експорт успішно';

  @override
  String chatExportFailed(String error) {
    return 'Помилка експорту: $error';
  }

  @override
  String get chatExportFormat => 'Формат експорту';

  @override
  String get chatExportHtmlDesc =>
      'Можна читати в будь-якому браузері зі стилізованим макетом';

  @override
  String get chatExportJsonDesc => 'Машиночитаний формат структурованих даних';

  @override
  String get chatExportDateRange => 'Діапазон дат';

  @override
  String get chatExportAll => 'Усі повідомлення';

  @override
  String get chatExportLastWeek => 'Останні 7 днів';

  @override
  String get chatExportLastMonth => 'Останній місяць';

  @override
  String get chatExportLast3Months => 'Останні 3 місяці';

  @override
  String get chatExportMessageCount => 'Повідомлення для експорту';

  @override
  String get chatExportButton => 'Експортуйте та діліться';

  @override
  String get chatMediaGallery => 'Медіа галерея';

  @override
  String get chatExportHistory => 'Експорт історії чату';

  @override
  String get pdfLoadFailed => 'Не вдалося завантажити PDF';

  @override
  String pdfPageIndicator(int current, int total) {
    return '$current / $total';
  }

  @override
  String get mediaAll => 'всі';

  @override
  String get mediaImages => 'Зображення';

  @override
  String get mediaVideos => 'Відео';

  @override
  String get mediaFiles => 'Файли';

  @override
  String get mediaAudio => 'Аудіо';

  @override
  String mediaItemsCount(int count) {
    return '$count елементів';
  }

  @override
  String get mediaNoMediaFound => 'Медіа не знайдено';

  @override
  String get spacesTitle => 'Спільноти';

  @override
  String get spacesCreate => 'Створити спільноту';

  @override
  String get spacesJoined => 'Приєднався';

  @override
  String get spacesDiscover => 'Відкрийте для себе';

  @override
  String get spacesNoJoined => 'Жодна спільнота ще не приєдналася';

  @override
  String get spacesExplore => 'Дослідіть спільноти';

  @override
  String get spacesNoPublic => 'Публічні спільноти не знайдено';

  @override
  String get spacesJoin => 'Приєднуйтесь';

  @override
  String get spacesSubSpaces => 'Підспільноти';

  @override
  String get spacesChannels => 'Канали';

  @override
  String spacesMembersCount(int count) {
    return 'Учасники $count';
  }

  @override
  String get spacesPublic => 'Громадський';

  @override
  String get spacesPrivate => 'Приватний';

  @override
  String get spacesSuggested => 'Запропоновано';

  @override
  String spacesChannelsCount(int count) {
    return 'канали $count';
  }

  @override
  String get callInCallChat => 'Чат під час виклику';

  @override
  String callMessagesCount(int count) {
    return '$count повідомлення';
  }

  @override
  String get callNoMessagesYet =>
      'Поки немає повідомлень.\nНадішліть повідомлення, щоб почати.';

  @override
  String get callTypeMessage => 'Введіть повідомлення...';

  @override
  String get callYouSender => 'Ви';

  @override
  String get callChatLabel => 'Чат';

  @override
  String get chatEdited => 'Відредаговано';

  @override
  String get chatEditHistory => 'Історія редагування';

  @override
  String get chatOriginalMessage => 'Оригінал';

  @override
  String chatEditedAt(String time) {
    return 'Відредаговано в $time';
  }

  @override
  String get chatViewOnce => 'Переглянути один раз';

  @override
  String get chatViewOncePhoto => 'Переглянути один раз фото';

  @override
  String get chatViewOnceVideo => 'Переглянути один раз відео';

  @override
  String get chatViewOnceViewed => 'Переглянуто';

  @override
  String get chatViewOnceExpired => 'Термін дії минув';

  @override
  String get chatViewOnceTap => 'Торкніться, щоб переглянути';

  @override
  String get chatAutoFaceBlur => 'Автоматичне розмиття обличчя';

  @override
  String get chatAutoFaceBlurDesc =>
      'Автоматично розмивати обличчя під час надсилання фотографій';

  @override
  String get threadReplyInThread => 'Відповісти в ланцюжку';

  @override
  String threadReplies(int count) {
    return '$count відповідає';
  }

  @override
  String get threadReply => '1 відповідь';

  @override
  String threadLatestReply(String preview) {
    return 'Останні: $preview';
  }

  @override
  String get threadTitle => 'Нитка';

  @override
  String get threadReplyPlaceholder => 'Відповісти в ланцюжку...';

  @override
  String threadParticipants(int count) {
    return '$count учасників';
  }

  @override
  String get voiceRoomTitle => 'Голосова кімната';

  @override
  String get voiceRoomCreate => 'Створіть голосову кімнату';

  @override
  String get voiceRoomJoin => 'Приєднуйтесь';

  @override
  String get voiceRoomLeave => 'Залиште';

  @override
  String get voiceRoomEnd => 'Кінцева кімната';

  @override
  String get voiceRoomRaiseHand => 'Підняти руку';

  @override
  String get voiceRoomLowerHand => 'Нижня рука';

  @override
  String get voiceRoomMute => 'Вимкнути звук';

  @override
  String get voiceRoomUnmute => 'Увімкнути звук';

  @override
  String get voiceRoomHost => 'Хост';

  @override
  String get voiceRoomSpeakers => 'Доповідачі';

  @override
  String get voiceRoomListeners => 'Слухачі';

  @override
  String get voiceRoomLive => 'НАЖИВО';

  @override
  String get voiceRoomEnded => 'Завершено';

  @override
  String get voiceRoomScheduled => 'За розкладом';

  @override
  String get voiceRoomApprove => 'Затвердити';

  @override
  String get voiceRoomDemote => 'Перейти до Слухача';

  @override
  String voiceRoomHandRaised(String name) {
    return '$name підняли руку';
  }

  @override
  String get voiceRoomName => 'Назва кімнати';

  @override
  String get voiceRoomTopic => 'Тема (необов\'язково)';

  @override
  String get voiceRoomNoActive => 'Немає активних голосових кімнат';

  @override
  String get voiceRoomConnecting => 'Підключення...';

  @override
  String get usernameTitle => 'Ім\'я користувача';

  @override
  String get usernameSet => 'Встановити ім\'я користувача';

  @override
  String get usernameChange => 'Змінити ім\'я користувача';

  @override
  String get usernamePlaceholder => 'Введіть ім\'я користувача';

  @override
  String get usernameAvailable => 'Доступне ім\'я користувача';

  @override
  String get usernameUnavailable => 'Ім\'я користувача вже зайнято';

  @override
  String get usernameInvalid =>
      '3-30 символів, малі літери, цифри, підкреслення. Має починатися з букви.';

  @override
  String get usernameReserved => 'Це ім\'я користувача зарезервовано';

  @override
  String get usernameSaved => 'Ім\'я користувача збережено';

  @override
  String get usernameSearchHint => 'Пошук за @username';

  @override
  String get ensName => 'Назва ENS';

  @override
  String get ensLinked => 'Пов’язано з ENS';

  @override
  String get ensResolving => 'Вирішення ENS...';

  @override
  String get ensNotFound => 'Ім\'я ENS не знайдено';

  @override
  String get tokenGateTitle => 'Токен Гейт';

  @override
  String get tokenGateEnable => 'Увімкнути Token Gate';

  @override
  String get tokenGateDisable => 'Вимкнути Token Gate';

  @override
  String get tokenGateAddRule => 'Додати правило';

  @override
  String get tokenGateRemoveRule => 'Видалити правило';

  @override
  String get tokenGateContractAddress => 'Адреса договору';

  @override
  String get tokenGateMinBalance => 'Мінімальний баланс';

  @override
  String get tokenGateTokenId => 'Ідентифікатор токена (ERC-1155)';

  @override
  String get tokenGateChainId => 'ID ланцюга';

  @override
  String get tokenGateVerifying => 'Перевірка токенів...';

  @override
  String get tokenGateVerified => 'Перевірку пройдено';

  @override
  String get tokenGateDenied => 'Ви не відповідаєте вимогам до маркера';

  @override
  String get tokenGateOperatorAnd => 'Має відповідати ВСІМ правилам';

  @override
  String get tokenGateOperatorOr => 'Має відповідати БУДЬ-ЯКОМУ правилу';

  @override
  String get tokenGateRuleErc20 => 'Токен ERC-20';

  @override
  String get tokenGateRuleErc721 => 'NFT (ERC-721)';

  @override
  String get tokenGateRuleErc1155 => 'Мультитокен (ERC-1155)';

  @override
  String get tokenGateRuleNative => 'Рідний токен';

  @override
  String get tokenGateSaved => 'Токен ворота збережено';

  @override
  String get tokenGateEnableDescription =>
      'Щоб приєднатися, учасники повинні мати маркери';

  @override
  String get tokenGateOperator => 'Логічне правило';

  @override
  String get tokenGateRules => 'правила';

  @override
  String get tokenGateSymbol => 'Символ (необов\'язково)';

  @override
  String get tokenGateChain => 'ланцюг';

  @override
  String get tokenGateTokenStandard => 'Токен Стандарт';

  @override
  String get tokenGateDenialMessage => 'Повідомлення про відмову';

  @override
  String get tokenGateDenialMessageHint =>
      'Повідомлення відображається, коли перевірка не вдається';

  @override
  String get tokenGateVerifyTitle => 'Перевірка маркера';

  @override
  String get tokenGateVerifyPassed => 'Перевірка пройдена';

  @override
  String get tokenGateVerifyFailed => 'Не вдалося перевірити';

  @override
  String get tokenGateRetryVerify => 'Повторіть спробу';

  @override
  String get tokenGateRequired => 'Обов\'язковий';

  @override
  String get tokenGateYourBalance => 'Ваш баланс';

  @override
  String get tokenGateRulesActive => 'правила активні';

  @override
  String get tokenGateDisabled => 'Вимкнено';

  @override
  String get ensNotBound => 'Не переплетений';

  @override
  String get liveLocation => 'Живе розташування';

  @override
  String get stopLiveLocation => 'Зупинити спільний доступ';

  @override
  String get startLiveLocation => 'Почніть ділитися';

  @override
  String get selectDuration => 'Виберіть Тривалість';

  @override
  String get groupChatFiles => 'Файли чату';

  @override
  String get groupLinks => 'Посилання';

  @override
  String get groupNoLinks => 'Поки немає посилань';

  @override
  String get chatBackground => 'Фон чату';

  @override
  String get solidColors => 'Суцільні кольори';

  @override
  String get gradients => 'градієнти';

  @override
  String get defaultBackground => 'За замовчуванням';

  @override
  String get settingsFontSizeSlider => 'Розмір шрифту';

  @override
  String get autoDownload => 'Автоматичне завантаження';

  @override
  String get images => 'Зображення';

  @override
  String get voice => 'Голос';

  @override
  String get video => 'відео';

  @override
  String get files => 'Файли';

  @override
  String get mobileData => 'Мобільні дані';

  @override
  String get roaming => 'Роумінг';

  @override
  String get storageManagement => 'Зберігання';

  @override
  String get totalUsage => 'Загальне використання';

  @override
  String get cache => 'Кеш';

  @override
  String get other => 'інше';

  @override
  String get clearCache => 'Очистити кеш';

  @override
  String get cacheCleared => 'Кеш очищено';

  @override
  String get clearCacheFailed => 'Не вдалося очистити кеш';

  @override
  String get confirmClearCache => 'Очистити всі дані кешу?';

  @override
  String get mapView => 'Перегляд карти';

  @override
  String liveLocationSharingCount(int count) {
    return '$count люди діляться геоданими';
  }

  @override
  String get minutes15 => '15 хвилин';

  @override
  String get minutes30 => '30 хвилин';

  @override
  String get hour1 => '1 година';

  @override
  String get hours8 => '8 годин';

  @override
  String get personalCard => 'Особиста картка';

  @override
  String get downloadFailed => 'Помилка завантаження';

  @override
  String get locationExpired => 'Термін дії минув';

  @override
  String secondsRemaining(int count) {
    return '$count секунд';
  }

  @override
  String minutesRemaining(int count) {
    return '$countхв';
  }

  @override
  String hoursMinutesRemaining(int hours, int minutes) {
    return '${hours}h $minutesмін';
  }

  @override
  String get favoriteMessages => 'Вибране';

  @override
  String get linksCopied => 'Посилання скопійовано';

  @override
  String get noLinksFound => 'Посилання не знайдено';

  @override
  String get roomStorageRanking => 'Рейтинг зберігання номерів';

  @override
  String get downloadComplete => 'Завантаження завершено';

  @override
  String get downloading => 'Завантаження...';

  @override
  String get draftSaved => 'Чернетку збережено';

  @override
  String get voiceRecording => 'Запис голосу';

  @override
  String get searchLocation => 'Місце пошуку';

  @override
  String get tapToSearch => 'Торкніться для пошуку';

  @override
  String get settingsThisDevice => 'Цей пристрій';

  @override
  String get settingsJustNow => 'Просто зараз';

  @override
  String get settingsDeviceId => 'ID пристрою';

  @override
  String get settingsStatus => 'Статус';

  @override
  String get settingsLastActive => 'Останній активний';

  @override
  String get settingsIpAddress => 'IP адреса';

  @override
  String get settingsRenameDevice => 'Перейменувати пристрій';

  @override
  String get settingsDeviceNameHint => 'Введіть назву пристрою';

  @override
  String get settingsDeviceRenamed => 'Пристрій перейменовано';

  @override
  String get settingsRenameFailed => 'Не вдалося перейменувати';

  @override
  String get settingsRemoteLogout => 'Віддалений вихід із системи';

  @override
  String settingsRemoteLogoutConfirm(String deviceName) {
    return 'Ви впевнені, що бажаєте вийти з системи \"$deviceName\"? Цю дію не можна скасувати.';
  }

  @override
  String get settingsDeviceLoggedOut => 'Пристрій вийшов із системи';

  @override
  String get settingsLogoutFailed => 'Помилка виходу';

  @override
  String get settingsLogout => 'Вийти';

  @override
  String get settingsVerifyIdentity => 'Підтвердити особу';

  @override
  String get settingsEnterPasswordToConfirm =>
      'Введіть свій пароль, щоб підтвердити цю дію.';

  @override
  String get scheduledSendTitle => 'Розклад повідомлення';

  @override
  String get scheduledSendInOneHour => 'Через 1 годину';

  @override
  String get scheduledSendTonight => 'Сьогодні ввечері (20:00)';

  @override
  String get scheduledSendTomorrowMorning => 'Завтра вранці (9:00)';

  @override
  String get scheduledSendCustom => 'Виберіть дату й час';

  @override
  String get scheduledMessageLabel => 'За розкладом';

  @override
  String get scheduledMessageCancel => 'Скасувати заплановане повідомлення';

  @override
  String get chatLockTitle => 'Блокування чату';

  @override
  String get chatLockEnable => 'Заблокуйте цей чат';

  @override
  String get chatLockDisable => 'Розблокуйте цей чат';

  @override
  String get chatLockDescription =>
      'Для відкриття заблокованих чатів потрібна біометрична перевірка або підтвердження PIN-кодом';

  @override
  String get chatLockVerifyTitle => 'Чат заблоковано';

  @override
  String get chatLockVerifySubtitle =>
      'Підтвердьте, щоб отримати доступ до цього чату';

  @override
  String get chatLockVerifyFailed => 'Не вдалося перевірити';

  @override
  String get chatLockEnabled => 'Чат заблоковано';

  @override
  String get chatLockDisabled => 'Чат розблоковано';

  @override
  String get chatLockPinTitle => 'Введіть PIN-код';

  @override
  String get chatLockPinSetTitle => 'Встановити PIN-код';

  @override
  String get chatLockPinConfirmTitle => 'Підтвердьте PIN-код';

  @override
  String get chatLockPinMismatch => 'PIN-код не збігається';

  @override
  String get chatLockUseBiometric => 'Використовуйте біометрію';

  @override
  String get chatLockUsePin => 'Використовуйте PIN-код';

  @override
  String get mediaEditorUndo => 'Скасувати';

  @override
  String get mediaEditorRedo => 'Повторити';

  @override
  String get mediaEditorCrop => 'кадрування';

  @override
  String get mediaEditorFilter => 'фільтр';

  @override
  String get mediaEditorDraw => 'малювати';

  @override
  String get mediaEditorText => 'текст';

  @override
  String get aiAssistant => 'ШІ помічник';

  @override
  String get aiAssistantWelcome =>
      'Привіт! Я помічник N42 AI. Чим я можу вам допомогти?';

  @override
  String get aiAssistantNotConfigured => 'Службу AI не налаштовано';

  @override
  String get aiAssistantSettings => 'Налаштування AI';

  @override
  String get aiAssistantClearHistory => 'Очистити історію чату';

  @override
  String get aiAssistantClearHistoryConfirm =>
      'Ви впевнені, що бажаєте очистити всю історію чатів AI?';

  @override
  String get aiAssistantStopGenerating => 'Припинити генерацію';

  @override
  String get aiAssistantModel => 'Модель';

  @override
  String get aiAssistantTemperature => 'Температура';

  @override
  String get aiAssistantMaxTokens => 'Макс жетонів';

  @override
  String get aiAssistantContextWindow => 'Контекстне вікно';

  @override
  String get aiAssistantServiceStatus => 'Статус служби';

  @override
  String get aiAssistantAvailable => 'в наявності';

  @override
  String get aiAssistantUnavailable => 'Недоступний';

  @override
  String get aiSummarize => 'AI Резюме';

  @override
  String aiSummarizeUnread(int count) {
    return 'Узагальніть $count непрочитані повідомлення';
  }

  @override
  String get aiSummarizeLoading => 'Підведення підсумків...';

  @override
  String get aiSummarizeError => 'Не вдалося підсумувати';

  @override
  String get aiRewrite => 'Переписати за допомогою ШІ';

  @override
  String get aiRewriteFormal => 'Формальний';

  @override
  String get aiRewriteCasual => 'Повсякденний';

  @override
  String get aiRewritePlayful => 'Грайливий';

  @override
  String get aiRewriteProfessional => 'професійний';

  @override
  String get aiRewriteAccept => 'використання';

  @override
  String get aiRewriteCancel => 'Скасувати';

  @override
  String get aiRewriteLoading => 'Переписування...';

  @override
  String get aiLinkSummary => 'AI Резюме';

  @override
  String get aiLinkSummaryAnalyzing => 'Аналіз...';

  @override
  String get chatFolderManagement => 'Керування папками';

  @override
  String get chatFolderSystem => 'Системні папки';

  @override
  String get chatFolderCustom => 'Спеціальні папки';

  @override
  String get chatFolderEmpty => 'Ще немає спеціальних папок';

  @override
  String get chatFolderCreate => 'Створити папку';

  @override
  String get chatFolderEdit => 'Редагувати папку';

  @override
  String get chatFolderNameHint => 'Назва папки';

  @override
  String get chatFolderAll => 'всі';

  @override
  String get chatFolderUnread => 'Непрочитаний';

  @override
  String get chatFolderPersonal => 'Особисті';

  @override
  String get chatFolderGroups => 'Групи';

  @override
  String get chatFolderChannels => 'Канали';

  @override
  String get chatFolderMuted => 'Вимкнено';

  @override
  String get storyAddMusic => 'Додати музику';

  @override
  String get storyChangeMusic => 'Змінити музику';

  @override
  String get storyBackgroundMusic => 'Фонова музика';

  @override
  String get storyMusicPreview => 'Попередній перегляд (макс. 15 с)';

  @override
  String get storyChooseFromDevice => 'Виберіть із пристрою';

  @override
  String get storyUseThisMusic => 'Використовуйте цю музику';

  @override
  String get authPasskeyNotSupported =>
      'Ключ доступу не підтримується на цьому пристрої';

  @override
  String get authPasskeyRegister => 'Зареєструвати пароль';

  @override
  String get authPasskeyNoRegistered => 'Ключі доступу не зареєстровані';

  @override
  String get authPasskeyRegisterHint =>
      'Зареєструйте пароль для цього облікового запису. Окремий вхід за допомогою ключа доступу буде ввімкнено пізніше.';

  @override
  String get authPasskeyNameYours => 'Назвіть свій пароль';

  @override
  String get authPasskeyRegistered =>
      'Ключ доступу збережено в цьому обліковому записі';

  @override
  String get authPasskeyDeleted =>
      'Ключ доступу видалено з цього облікового запису';

  @override
  String authPasskeyDeleteConfirm(String name) {
    return 'Видалити ключ доступу \"$name\"? Вам потрібно буде зареєструвати його знову, перш ніж використовувати пароль для входу пізніше.';
  }

  @override
  String get momentVisibilityPublic => 'Громадський';

  @override
  String get momentVisibilityPrivate => 'Приватний';

  @override
  String get momentVisibilityPartial => 'Вибрані друзі';

  @override
  String get momentVisibilityExcluded => 'Виключити деяких друзів';

  @override
  String momentUserMoments(String userName) {
    return 'Моменти $userName';
  }

  @override
  String get momentForwardTo => 'Переслати до';

  @override
  String get momentForwardSuccess => 'Переслано успішно';

  @override
  String get momentSelectFriends => 'Виберіть Друзі';

  @override
  String get momentSelectTags => 'Виберіть за тегами';

  @override
  String momentSelectedCount(int count) {
    return 'Вибране ($count)';
  }

  @override
  String get momentNoMomentsYet => 'Ще немає моментів';

  @override
  String get momentForwardMoment => 'Момент вперед';

  @override
  String get momentAddComment => 'Додати коментар...';

  @override
  String momentForwardContent(String content) {
    return '[Момент] $content';
  }

  @override
  String get momentDeleteMoment => 'Видалити момент';

  @override
  String get momentDeleteConfirm =>
      'Ви впевнені, що хочете видалити цей момент?';

  @override
  String get momentComment => 'коментар';

  @override
  String get momentWriteComment => 'Напишіть коментар...';

  @override
  String get momentLike => 'Подобається';

  @override
  String get momentUnlike => 'На відміну від';

  @override
  String get momentForward => 'вперед';

  @override
  String get momentDelete => 'Видалити';

  @override
  String get momentReply => 'відповісти';

  @override
  String get momentMoment => 'Момент';

  @override
  String momentLikesCount(int count) {
    return 'Подобається $count';
  }

  @override
  String momentCommentsCount(int count) {
    return 'Коментарі $count';
  }

  @override
  String get momentNoComments => 'Поки немає коментарів';

  @override
  String get momentFailedToLoad => 'Не вдалося завантажити зображення';

  @override
  String momentReplyTo(String userName) {
    return 'Відповісти $userName...';
  }

  @override
  String get momentNoConversations => 'Жодних розмов';

  @override
  String get momentJustNow => 'тільки зараз';

  @override
  String momentMinutesAgo(int count) {
    return '$countм тому';
  }

  @override
  String momentHoursAgo(int count) {
    return '${count}h тому';
  }

  @override
  String momentDaysAgo(int count) {
    return '$countд тому';
  }

  @override
  String get chatGroupAnnouncementHint => 'Введіть групове оголошення';

  @override
  String get chatGroupAnnouncementEmpty => 'Без оголошення';

  @override
  String get chatEditNickname => 'Редагувати псевдонім';

  @override
  String get chatNicknameHint => 'Введіть свій нік у цій групі';

  @override
  String get contactAddPhoneHint => 'Введіть номер телефону';

  @override
  String get contactNotesHint => 'Додайте примітки про цей контакт';

  @override
  String get reportTitle => 'звіт';

  @override
  String get reportReasonSpam => 'Спам';

  @override
  String get reportReasonHarassment => 'Переслідування';

  @override
  String get reportReasonFraud => 'Шахрайство';

  @override
  String get reportReasonOther => 'інше';

  @override
  String get reportSubmitted => 'Звіт подано';

  @override
  String get reportDescription => 'Додатковий опис (необов\'язково)';

  @override
  String get qrcodeSaved => 'QR-код збережено в альбомі';

  @override
  String get chatSendRedPacketInChat =>
      'Будь ласка, надішліть червоний пакет у чаті';

  @override
  String get commonSaveFailed => 'Не вдалося зберегти';

  @override
  String get reportSelectReason => 'Виберіть причину';

  @override
  String get reportUnavailable => 'Увійдіть, щоб надіслати скаргу.';

  @override
  String get reportAccountChanged =>
      'Обліковий запис змінився. Знову відкрийте скаргу для надсилання.';

  @override
  String get reportUnsupported =>
      'Цей домашній сервер не підтримує скарги на користувачів.';

  @override
  String get reportRoomUnsupported =>
      'Цей домашній сервер не підтримує скарги на кімнати.';

  @override
  String get reportRateLimited => 'Забагато скарг. Спробуйте пізніше.';

  @override
  String get reportCouldNotSend =>
      'Не вдалося надіслати скаргу. Повторіть спробу.';

  @override
  String get gameCenter => 'Ігри';

  @override
  String get gameHighScore => 'Найкращий';

  @override
  String get gameScore => 'Оцінка';

  @override
  String get gameOver => 'Гра закінчена';

  @override
  String get gamePlayAgain => 'Грати знову';

  @override
  String get gameLeaderboard => 'Таблиця лідерів';

  @override
  String get gamePause => 'Призупинено';

  @override
  String get gameResume => 'Торкніться, щоб відновити';

  @override
  String get gameConfirmExit => 'Вийти з цієї гри?';

  @override
  String get gameNoScores => 'Ще немає балів';

  @override
  String get game2048 => '2048';

  @override
  String get game2048Desc => 'Об’єднайте плитки, щоб досягти 2048';

  @override
  String get gameBlockDrop => 'Випадання блоку';

  @override
  String get gameBlockDropDesc => 'Краплі та чіткі лінії';

  @override
  String get gameMinesweeper => 'Тральщик';

  @override
  String get gameMinesweeperDesc => 'Знайти всі безпечні клітини';

  @override
  String get gameMatch3 => 'Матч 3';

  @override
  String get gameMatch3Desc => 'Зіставте 3 або більше дорогоцінних каменів';

  @override
  String get gameMinesweeperEasy => 'легко';

  @override
  String get gameMinesweeperMedium => 'Середній';

  @override
  String get gameMinesLeft => 'Залишені міни';

  @override
  String get gameTimeLeft => 'час';

  @override
  String get gameLevel => 'Рівень';

  @override
  String get gameNext => 'Далі';

  @override
  String get gameBestTime => 'Кращий час';

  @override
  String get gameNewRecord => 'Новий рекорд!';

  @override
  String get gameLines => 'Лінії';

  @override
  String get storyMyStory => 'Моя історія';

  @override
  String get storageSmartCleanup => 'Розумне очищення';

  @override
  String get storageOldMediaFiles => 'Старі мультимедійні файли';

  @override
  String get storageLargeFiles => 'Великі файли';

  @override
  String get storageAppCache => 'Кеш програми';

  @override
  String get storageSettings => 'Налаштування зберігання';

  @override
  String get storageAutoCleanup => 'Автоматичне очищення';

  @override
  String storageAutoCleanupDesc(int days) {
    return 'Автоматично очищати файли старше $days днів';
  }

  @override
  String get storageCleanupPeriod => 'Період очищення';

  @override
  String get storagePreserveThumbnails => 'Зберегти мініатюри';

  @override
  String get storagePreserveThumbnailsDesc =>
      'Зберігайте мініатюри зображень під час очищення';

  @override
  String get storageWarningHigh =>
      'Високе використання пам’яті. Подумайте про очищення старих файлів.';

  @override
  String get storageWarningCritical =>
      'Пам\'яті критично мало. Очистіть, будь ласка, вільне місце.';

  @override
  String storageFreed(String size, int count) {
    return 'Звільнено $size (файли $count)';
  }

  @override
  String storageDays(int days) {
    return '$days днів';
  }

  @override
  String storageViewAllRooms(int count) {
    return 'Переглянути всі номери $count';
  }

  @override
  String get storageNoFiles => 'Файли не знайдено';

  @override
  String get storageFilePinned => 'Закріплено';

  @override
  String storageDeleteSelected(int count) {
    return 'Видалити вибрані файли $count? Їх можна повторно завантажити з сервера.';
  }

  @override
  String get backupRestore => 'Резервне копіювання та відновлення';

  @override
  String get backupCreate => 'Створити резервну копію';

  @override
  String get backupCreateDesc =>
      'Резервне копіювання налаштувань і ключів шифрування. Повідомлення будуть відновлені з сервера після повторного входу.';

  @override
  String get backupIncludeKeys => 'Додайте ключі шифрування';

  @override
  String get backupIncludeKeysDesc =>
      'Необхідний для читання зашифрованих повідомлень';

  @override
  String get backupPasswordProtect => 'Захист паролем';

  @override
  String get backupEnterPassword => 'Введіть резервний пароль';

  @override
  String get backupHistory => 'Історія резервного копіювання';

  @override
  String get backupNoBackups => 'Резервних копій ще немає';

  @override
  String get backupRestore2 => 'Відновити';

  @override
  String get backupDelete => 'Видалити';

  @override
  String get backupDeleteConfirm =>
      'Ви впевнені, що хочете видалити цю резервну копію? Це неможливо скасувати.';

  @override
  String get backupRestoreFromFile => 'Відновити з файлу';

  @override
  String get backupRestoreFromFileDesc =>
      'Імпортуйте файл резервної копії .n42 з іншого пристрою або попередньої резервної копії.';

  @override
  String get backupChooseFile => 'Виберіть файл резервної копії';

  @override
  String get backupRestoring => 'Відновлення...';

  @override
  String backupCreated(int rooms, int messages) {
    return 'Створено резервну копію: $rooms кімнат, $messages повідомлень';
  }

  @override
  String backupRestored(int settings, int rooms) {
    return 'Відновлено налаштування $settings з кімнат $rooms';
  }

  @override
  String backupFailed(String error) {
    return 'Помилка резервного копіювання: $error';
  }

  @override
  String get backupPasswordRequired => 'Ця резервна копія захищена паролем';

  @override
  String get blocGroupNotFound => 'Групу не знайдено';

  @override
  String blocGroupMembersInvited(int count) {
    return 'Запрошений член(и) $count';
  }

  @override
  String get blocGroupMemberRemoved => 'Учасника видалено';

  @override
  String get blocGroupAdminRemoved => 'Адміністратора видалено';

  @override
  String get blocGroupLeft => 'Вийшов із групи';

  @override
  String get blocGroupDisbanded => 'Група розпущена';

  @override
  String get blocGroupJoined => 'Приєднався до групи';

  @override
  String get blocGroupInviteDeclined => 'Запрошення відхилено';

  @override
  String get blocGroupTokenGateUpdated => 'Токен-шлюз оновлено';

  @override
  String get blocTransferProcessing => 'Обробка передачі...';

  @override
  String get blocTransferCancelled => 'Переказ скасовано';

  @override
  String get blocTransferFailed => 'Помилка передачі';

  @override
  String get blocPaymentProcessing => 'Обробка платежу...';

  @override
  String get blocPaymentFailed => 'Платіж не вдалося';

  @override
  String get groupMaxMembers => 'Ліміт учасників';

  @override
  String get groupMaxMembersUnlimited => 'Необмежений';

  @override
  String get groupMaxMembersHint =>
      'Введіть ліміт (залиште порожнім для необмеженого)';

  @override
  String get groupMaxMembersUpdated => 'Ліміт учасників оновлено';

  @override
  String get groupFull => 'Група завантажена';

  @override
  String get groupChannels => 'Тематичні канали';

  @override
  String get groupChannelsEmpty => 'Ще немає каналів';

  @override
  String get groupChannelsCount => 'канали';

  @override
  String get groupChannelCreate => 'Новий канал';

  @override
  String get groupChannelName => 'Назва каналу';

  @override
  String get groupChannelTopic => 'Тема каналу (необов\'язково)';

  @override
  String get groupChannelDelete => 'Видалити канал';

  @override
  String get groupChannelDeleteConfirm =>
      'Видалити цей канал? Усі повідомлення буде втрачено.';

  @override
  String get groupBotSettings => 'Налаштування бота';

  @override
  String get groupBotEnabled => 'Увімкнути бота';

  @override
  String get groupBotWelcomeMessage => 'Шаблон привітального повідомлення';

  @override
  String get groupBotWelcomeHint =>
      'Використовуйте «name» як заповнювач для імені нового учасника';

  @override
  String get groupBotConfigUpdated => 'Налаштування бота оновлено';

  @override
  String get groupContentFilter => 'Фільтр вмісту';

  @override
  String get groupContentFilterEnabled => 'Увімкнути фільтр ключових слів';

  @override
  String get groupContentFilterReplace => 'Замінити на ***';

  @override
  String get groupContentFilterHide => 'Приховати повідомлення';

  @override
  String get groupContentFilterAddWord => 'Додати ключове слово';

  @override
  String get groupContentFilterUpdated => 'Оновлено фільтр вмісту';

  @override
  String get chatSlashCommands => 'Команди';

  @override
  String get chatCommandPoll => '/poll — створити опитування';

  @override
  String get chatCommandAnnounce => '/announce — Надіслати оголошення';

  @override
  String get chatCommandWelcome =>
      '/welcome — встановити вітальне повідомлення';

  @override
  String get chatReportMessage => 'звіт';

  @override
  String get chatReportReason => 'Повідомити про причину';

  @override
  String get chatReportSpam => 'Спам';

  @override
  String get chatReportHarassment => 'Переслідування';

  @override
  String get chatReportInappropriate => 'Невідповідний вміст';

  @override
  String get chatReportOther => 'інше';

  @override
  String get chatReportSuccess => 'Звіт подано';

  @override
  String get spacesName => 'Назва спільноти';

  @override
  String get spacesNameHint => 'напр. Криптотрейдери';

  @override
  String get spacesNameRequired => 'Необхідно вказати ім\'я';

  @override
  String get spacesDescription => 'опис';

  @override
  String get spacesDescriptionHint => 'Про що ця спільнота?';

  @override
  String get spacesType => 'Тип спільноти';

  @override
  String get spacesPublicDesc => 'Будь-хто може знайти та приєднатися';

  @override
  String get spacesPrivateDesc =>
      'Тільки запрошені учасники можуть приєднатися';

  @override
  String get spacesNotFound => 'Спільнота не знайдена';

  @override
  String get spacesSearch => 'Пошук спільнот...';

  @override
  String get spacesMembers => 'Члени';

  @override
  String get spacesNoChannels => 'Ще немає каналів';

  @override
  String get spacesLeave => 'Вийти зі спільноти';

  @override
  String spacesLeaveConfirm(String name) {
    return 'Ви впевнені, що бажаєте залишити \"$name\"?';
  }

  @override
  String get spacesDelete => 'Видалити спільноту';

  @override
  String spacesDeleteConfirm(String name) {
    return 'Це призведе до остаточного видалення \"$name\" і всіх його каналів. Цю дію не можна скасувати.';
  }

  @override
  String get spacesCreateChannel => 'Додати канал';

  @override
  String get spacesChannelName => 'Назва каналу';

  @override
  String get spacesChannelTopic => 'Тема (необов\'язково)';

  @override
  String get spacesDeleteChannel => 'Видалити канал';

  @override
  String spacesDeleteChannelConfirm(String name) {
    return 'Ви впевнені, що хочете видалити \"#$name\"?';
  }

  @override
  String get spacesEditName => 'Редагувати назву';

  @override
  String get spacesEditDescription => 'Редагувати опис';

  @override
  String spacesViewAllMembers(int count) {
    return 'Переглянути всіх учасників $count';
  }

  @override
  String spacesKickMemberTitle(String name) {
    return 'Удар $name';
  }

  @override
  String spacesBanMemberTitle(String name) {
    return 'Забанити $name';
  }

  @override
  String get spacesPromoteAdmin => 'Підвищити до адміністратора';

  @override
  String get spacesDemoteAdmin => 'Видалити адміністратора';

  @override
  String get spacesInviteMember => 'Запросити учасника';

  @override
  String get spacesInviteMemberUserId =>
      'Ідентифікатор користувача (наприклад, @user:server.com)';

  @override
  String get spacesSave => 'зберегти';

  @override
  String get settingsScreenshotProtection => 'Захист скріншотів';

  @override
  String get settingsScreenshotProtectionDesc =>
      'Запобігайте знімкам екрана та запису екрана';

  @override
  String get chatSelfDestructTimer => 'Самознищення';

  @override
  String get chatTimerPickerTitle => 'Таймер самознищення';

  @override
  String get chatTimerOff => 'Вимкнено';

  @override
  String get onChainNotificationsTitle => 'Події в мережі';

  @override
  String get onChainMarkAllRead => 'Позначити все прочитане';

  @override
  String get onChainNoNotifications => 'Подій у мережі ще немає';

  @override
  String get onChainNoNotificationsDesc =>
      'Тут відображатимуться події з каналів, на які ви підписалися';

  @override
  String get onChainViewDetails => 'Переглянути деталі';

  @override
  String get chatCommandHelp => '/help — Показати всі команди';

  @override
  String get chatCommandPrice => '/price — отримати ціну токена';

  @override
  String get chatCommandBalance => '/balance — Показати баланс гаманця';

  @override
  String get chatCommandChains => '/chains — список 236+ підтримуваних мереж';

  @override
  String get chatMiniApps => 'програми';

  @override
  String get miniAppMarketTitle => 'Міні-додатки';

  @override
  String get miniAppCategoryAll => 'всі';

  @override
  String get miniAppSearch => 'Пошук програм...';

  @override
  String get miniAppFeatured => 'Рекомендовані';

  @override
  String get miniAppAllApps => 'Усі додатки';

  @override
  String get miniAppNoResults => 'Програм не знайдено';

  @override
  String get slideToPayLabel => '→→→ Проведіть пальцем для підтвердження';

  @override
  String get slideToPayConfirming => 'Підтвердження...';

  @override
  String get redPacketBestLuck => 'Краща удача';

  @override
  String get redPacketBestLuckCongrats => 'Удачі! Ви отримали найбільше!';

  @override
  String redPacketStats(int claimed, int total) {
    return 'Заявлено $claimed / $total';
  }

  @override
  String get redPacketStatsTotal => 'всього';

  @override
  String redPacketGrabbedViral(String amount, String token) {
    return '🧧 схопив червоний пакунок • $amount $token';
  }

  @override
  String get web3SearchHint => '@matrix:id • 0x адреса гаманця • name.eth';

  @override
  String get web3SearchPlaceholder => 'Пошук за ID, гаманцем або ENS...';

  @override
  String get web3WalletAddress => 'Адреса гаманця';

  @override
  String get web3AddressCopied => 'Адресу скопійовано';

  @override
  String get web3Copy => 'Копія';

  @override
  String get web3SendMessage => 'Надіслати повідомлення';

  @override
  String get web3SendToWallet => 'Гаманець для повідомлень';

  @override
  String get web3WalletOnlyHint =>
      'Ця адреса ще не має облікового запису N42. Повідомлення буде доставлено, коли вони приєднаються.';

  @override
  String get web3NftAvatar => 'Аватар NFT';

  @override
  String get web3ResolveFailed => 'Не вдалося визначити особу';

  @override
  String web3EnsNotFound(String name) {
    return 'Назва ENS \"$name\" не знайдено';
  }

  @override
  String get web3NoN42AccountTitle => 'Немає облікового запису N42';

  @override
  String get web3NoN42AccountDesc =>
      'Ця адреса гаманця ще не має облікового запису N42. Ви можете поділитися з ними посиланням на запрошення N42, щоб почати.';

  @override
  String get web3ShareInvite => 'Поділитися запрошенням';

  @override
  String get nftPickerTitle => 'Виберіть NFT Avatar';

  @override
  String get nftPickerTabPopular => 'Популярний';

  @override
  String get nftPickerTabCustom => 'Власний';

  @override
  String get nftPickerChain => 'ланцюг';

  @override
  String get nftPickerContract => 'Адреса договору';

  @override
  String get nftPickerTokenId => 'Ідентифікатор маркера';

  @override
  String get nftPickerVerifyOwnership =>
      'Перевірити право власності та переглянути';

  @override
  String get nftPickerUseAsAvatar => 'Використовувати як аватар';

  @override
  String get nftPickerPreview => 'Попередній перегляд';

  @override
  String get nftPickerNotOwned => 'Ви не є власником цього NFT';

  @override
  String get nftPickerInvalidTokenId => 'Недійсний ідентифікатор маркера';

  @override
  String get nftPickerEnterBoth =>
      'Введіть адресу контракту та ідентифікатор токена';

  @override
  String get nftPickerInfoTitle => 'NFT-аватар — перевірено в блокчейні';

  @override
  String get nftPickerInfoDesc =>
      'Прив’яжіть свій аватар до NFT, яким ви володієте. Будь-хто може підтвердити право власності в мережі. Показано із золотим кільцем на N42.';

  @override
  String get nftPickerPopularCollections => 'Популярні колекції';

  @override
  String get nftPickerWalletHint =>
      'Підключіть свій гаманець N42, щоб автоматично знаходити свої NFT у понад 236 мережах.';

  @override
  String get profileBindNftAvatar => 'Прив’язати аватар NFT';

  @override
  String get profileChangeAvatar => 'Змінити аватар';

  @override
  String get groupTopics => 'Теми';

  @override
  String get groupTopicsEmpty => 'Ще немає тем';

  @override
  String get syncInProgress => 'Синхронізація історії повідомлень...';

  @override
  String get recoveryKeyReminderTitle => 'Захистіть свої повідомлення';

  @override
  String get recoveryKeyReminderDesc =>
      'Створіть ключ відновлення для безпечної синхронізації зашифрованих повідомлень між пристроями';

  @override
  String get recoveryKeySetupNow => 'Налаштувати зараз';

  @override
  String get recoveryKeyRemindLater => 'Нагадай мені пізніше';

  @override
  String get channelReadOnly =>
      'Лише адміністратори можуть публікувати дописи на цьому каналі';

  @override
  String get channelSubscribers => 'підписників';

  @override
  String get channelVerified => 'Перевірений канал';

  @override
  String get redPacketHistory => 'Історія червоних пакетів';

  @override
  String get redPacketSent => 'Надіслано';

  @override
  String get redPacketReceived => 'Отримано';

  @override
  String get redPacketExpired => 'Термін дії минув';

  @override
  String get redPacketClaimed => 'Заявлено';

  @override
  String get redPacketInsufficientBalance => 'Недостатній баланс';

  @override
  String selfDestructCountdown(String time) {
    return 'Самознищення в $time';
  }

  @override
  String get messageDestroyed => 'Повідомлення знищено';

  @override
  String miniAppPermissionDenied(String permission) {
    return 'У дозволі відмовлено: $permission';
  }

  @override
  String get aiSuggestionGasFee => 'Що таке плата за газ?';

  @override
  String get aiSuggestionDefi => 'Посібник для початківців DeFi';

  @override
  String get aiSuggestionSecurity => 'Як перевірити безпеку договору';

  @override
  String get aiSuggestionBridge => 'Перехресне ланцюгове перемикання';

  @override
  String get channelDiscoverTitle => 'Відкрийте канали';

  @override
  String get channelDiscoverSearch => 'Пошук каналів...';

  @override
  String get channelJoin => 'Приєднуйтесь';

  @override
  String get channelJoined => 'Приєднався';

  @override
  String get channelCategory => 'Категорія';

  @override
  String slowModeCooldown(int seconds) {
    return 'Повільний режим: зачекайте ${seconds}s';
  }

  @override
  String get addressCopyAction => 'Копіювати адресу';

  @override
  String get addressSendMessage => 'Надіслати повідомлення';

  @override
  String get addressViewProfile => 'Переглянути профіль';

  @override
  String get sendToAddress => 'Надіслати на адресу гаманця';

  @override
  String get blocAuthSendVerificationCodeFailed =>
      'Не вдалося надіслати код підтвердження';

  @override
  String get blocAuthServerNoEmailPasswordReset =>
      'Цей сервер не підтримує скидання пароля електронної пошти';

  @override
  String get blocAuthResetPasswordFailed => 'Не вдалося скинути пароль';

  @override
  String get blocAuthChangePasswordFailed => 'Не вдалося змінити пароль';

  @override
  String get blocAuthOldPasswordWrong => 'Неправильний поточний пароль';

  @override
  String get blocAuthLoginCancelled => 'Вхід скасовано';

  @override
  String get blocAuthGoogleLoginFailed => 'Помилка входу в Google';

  @override
  String get blocAuthAppleLoginFailed => 'Помилка входу в систему Apple';

  @override
  String get blocAuthSsoLoginFailed => 'Помилка входу в систему єдиного входу';

  @override
  String get blocAuthFacebookLoginFailed => 'Помилка входу в Facebook';

  @override
  String get blocAuthTwitterLoginFailed => 'Помилка входу в Twitter';

  @override
  String get blocAuthWeChatLoginFailed => 'Помилка входу в WeChat';

  @override
  String get blocAuthWeChatNotConfigured => 'Вхід у WeChat не налаштовано';

  @override
  String get blocAuthWeChatNotInstalled => 'Спочатку встановіть WeChat';

  @override
  String get blocAuthPasswordWrong => 'Невірний пароль';

  @override
  String get blocAuthEmailAlreadyBound =>
      'Ця електронна адреса вже прив’язана до іншого облікового запису';

  @override
  String get blocAuthChangeEmailFailed =>
      'Не вдалося змінити електронну адресу';

  @override
  String get blocAuthVerificationCodeInvalid =>
      'Код підтвердження неправильний або термін дії минув';

  @override
  String get blocAuthSessionExpired => 'Сеанс закінчився, увійдіть знову';

  @override
  String get blocAuthSessionIncomplete => 'Дані сеансу неповні, увійдіть знову';

  @override
  String get chatReadingMode => 'Режим читання';

  @override
  String get groupPoints => 'Бали';

  @override
  String get settingsPrivacySecurity => 'Конфіденційність і безпека';

  @override
  String get settingsSystemAccounts => 'Система й облікові записи';

  @override
  String get settingsNotificationPrivacy => 'Конфіденційність сповіщень';

  @override
  String get settingsSenderOnly => 'Показувати лише відправника';

  @override
  String get settingsHiddenNotification =>
      'Приховувати відправника й повідомлення';

  @override
  String get settingsSmartFilter => 'Розумний фільтр';

  @override
  String get settingsEmailVerificationSent =>
      'Лист для підтвердження надіслано';

  @override
  String get settingsEmailLinkInstructions =>
      'Відкрийте посилання в листі, потім поверніться сюди та підтвердьте.';

  @override
  String get settingsSendVerificationEmail =>
      'Надіслати лист для підтвердження';

  @override
  String get chatLogoutKeyWarning =>
      'Перед виходом створіть резервну копію ключів шифрування, інакше ви можете втратити доступ до зашифрованих повідомлень.';

  @override
  String get settingsBiometricUnavailable =>
      'Біометрична автентифікація недоступна. Перевірте реєстрацію та дозволи в налаштуваннях пристрою.';

  @override
  String get chatEncryptionNotReady =>
      'Захищене з’єднання не готове. Повідомлення не надіслано. Перевірте з’єднання й верифікацію пристроїв в обох записах, потім повторіть спробу.';

  @override
  String get contactRequestPending => 'Очікування прийняття';

  @override
  String get chatFriendRequestPending =>
      'Дружбу не підтверджено. Перед надсиланням перевірте «Контакти > Нові друзі».';

  @override
  String contactPhotoCount(int count) {
    return 'Фото: $count';
  }

  @override
  String get videoPublish => 'Опублікувати відео';

  @override
  String get videoGoLive => 'Почати трансляцію';

  @override
  String get videoSelect => 'Вибрати відео';

  @override
  String get videoLiveUnavailable => 'Прямі трансляції недоступні';

  @override
  String get qrcodeAlbum => 'Альбом';

  @override
  String get settingsSwitchAccount => 'Змінити обліковий запис';

  @override
  String get chatFilterUnread => 'Непрочитані';

  @override
  String get chatFilterEmpty => 'Немає розмов для цього фільтра';

  @override
  String get accountAdd => 'Додати обліковий запис';

  @override
  String get accountCurrent => 'Поточний обліковий запис';

  @override
  String get accountSwitching => 'Перемикання облікового запису…';

  @override
  String get accountSwitchFailed =>
      'Не вдалося перемкнути обліковий запис. Повторіть спробу або додайте його для повторного входу.';

  @override
  String get accountSessionsHint =>
      'Перемикайте облікові записи тут, щоб повідомлення та захищений сеанс кожного запису зберігалися окремо.';

  @override
  String get accountNoSaved => 'Збережених облікових записів ще немає';

  @override
  String get contactRequestSent => 'Запит надіслано';

  @override
  String get contactRequestsIncoming => 'Отримані запити';

  @override
  String get contactRequestsOutgoing => 'Надіслані запити';

  @override
  String get contactRequestHint =>
      'Після прийняття запиту ви зможете спілкуватися й телефонувати.';

  @override
  String get callReturnToCall => 'Повернутися до дзвінка';

  @override
  String get chatMessageSending => 'Надсилається';

  @override
  String get chatMessageSent => 'Надіслано';

  @override
  String get chatMessageDelivered => 'Доставлено';

  @override
  String get chatMessageRead => 'Прочитано';

  @override
  String get chatMessageFailed => 'Не надіслано. Натисніть, щоб повторити.';

  @override
  String get chatMessageUnavailable =>
      'Повідомлення недоступне на цьому пристрої. Натисніть, щоб перевірити варіанти відновлення.';

  @override
  String get contactStarredFriends => 'Обрані друзі';

  @override
  String get chatRecipientKeysMissing =>
      'Цей друг не має доступного зашифрованого сеансу. Попросіть його увійти й відкрити застосунок, а потім повторіть спробу. Для зміни запису використовуйте «Перемкнути обліковий запис» замість виходу.';

  @override
  String get chatSwitchForMessaging =>
      'Змінюєте обліковий запис? Використовуйте перемикання, щоб зберегти повідомлення та захищені сеанси. Вихід відкликає доступ цього пристрою і може зробити вхідні зашифровані повідомлення недоступними.';

  @override
  String get aiServiceUnavailable =>
      'Підсумки ШІ зараз недоступні. Повторіть спробу після відновлення доступу до сервісу.';

  @override
  String aiSummarizeMessages(int count) {
    return 'Підсумувати останні повідомлення: $count';
  }

  @override
  String groupMembershipSummary(int joined, int invited) {
    return 'Приєдналися: $joined · Запрошено: $invited';
  }

  @override
  String contactPendingCount(int count) {
    return 'Запити, що очікують: $count';
  }

  @override
  String get chatDraftLabel => 'Чернетка';

  @override
  String get contactIndexLabel => 'Покажчик контактів';

  @override
  String get transferAssetUnavailable => 'Платіжний актив недоступний';

  @override
  String get transferPaymentRequestUnavailable => 'Запит на оплату недоступний';

  @override
  String get chatCatchUp => 'Наздогнати розмову';

  @override
  String get chatCatchUpMentions => 'Згадки';

  @override
  String get chatCatchUpReplies => 'Відповіді мені';

  @override
  String get chatCatchUpPinned => 'Закріплені повідомлення';

  @override
  String get chatCatchUpScope =>
      'Згадки й відповіді шукаються серед завантажених повідомлень, зокрема прочитаних. Завантажте старіші повідомлення, щоб знайти попередні відповіді.';

  @override
  String get chatCatchUpLoadMore => 'Завантажити старіші повідомлення';

  @override
  String get chatActionPreview => 'Перевірити пропозицію для календаря';

  @override
  String get chatActionPrivacy =>
      'Лише наведені нижче назва й час будуть передані застосунку календаря після підтвердження. Перевірте часовий пояс. Ваш обліковий запис календаря може синхронізувати цю подію.';

  @override
  String get chatActionTitle => 'Подія з чату';

  @override
  String get chatActionSuggestion => 'Пропозиція для календаря';

  @override
  String get chatUnreadAttention => 'Непрочитані згадки й відповіді';

  @override
  String get chatScanAgain => 'Сканувати знову';

  @override
  String get chatUnreadScope =>
      'Історія на сервері переглядається до вашої позначки прочитання. Відкрийте розмову, щоб прочитати її; оновіть для повторного пошуку.';

  @override
  String get chatScanIncomplete =>
      'Неповні дані: історія, розшифрування або позначка прочитання недоступні. Повторіть після синхронізації.';

  @override
  String get chatHistoryShare => 'Поділитися вибраною історією';

  @override
  String get chatHistoryExplanation =>
      'Лише для адміністраторів. Виберіть звичайний текст і наявний зашифрований особистий чат з учасником, який приєднався до групи. Надсилання створить видимі повідомлення аудиту в групі.';

  @override
  String get chatHistoryEnable => 'Дозволити надсилання історії';

  @override
  String get chatHistoryDisable => 'Заборонити надсилання історії';

  @override
  String get chatHistoryPolicy => 'Правила надсилання історії групи';

  @override
  String get chatHistoryPolicyDetail =>
      'Історією можуть ділитися лише адміністратори. Увімкнення також обмежить видимість історії групи подіями після приєднання. Установіть нижче обмеження текстових повідомлень і підтвердьте.';

  @override
  String get chatHistoryPolicySaved => 'Правила збережено';

  @override
  String get chatHistoryRecipient => 'Зашифрована розмова з одержувачем';

  @override
  String get chatHistoryReview => 'Перевірити вибрані повідомлення';

  @override
  String get chatHistoryMessages => 'повідомлення';

  @override
  String get chatHistoryConfirmDetail =>
      'Перед надсиланням перевірте одержувача, кожне повідомлення та його час. У разі помилки або невідомого результату вміст уже міг бути надісланий: звірте результат перед продовженням.';

  @override
  String get chatHistoryCompleted =>
      'Вибрану історію надіслано, аудит у групі підтверджено';

  @override
  String get chatHistoryPending =>
      'Очікування: звірте результат і знову підтвердьте, щоб продовжити. Надсилання з невідомим результатом ніколи не повторюються.';

  @override
  String get chatHistoryReconcile => 'Звірити результат надсилання';

  @override
  String get chatHistoryFailed =>
      'Не вдалося завершити. Перевірте права адміністратора, правила групи, шифрування, членство одержувача та вибір повідомлень. Якщо надсилання почалося, звірте його результат.';

  @override
  String get chatDeviceActions => 'Дії на пристрої';

  @override
  String get chatDeviceActionsReview =>
      'Після підтвердження лише це повідомлення передається системним пропозиціям дій на пристрої. Виберіть дію, щоб відкрити Календар, Нагадування або Карти.';

  @override
  String get chatHistoryMaxMessages => 'Ліміт повідомлень (1–50)';

  @override
  String get chatHistoryMaxHours => 'Глибина історії в годинах (1–720)';

  @override
  String get chatNotifyAll => 'Усі повідомлення';

  @override
  String get chatNotifyAllDescription =>
      'Сповіщати про кожне нове повідомлення в цьому чаті';

  @override
  String get chatNotifyMentions => 'Лише згадки';

  @override
  String get chatNotifyMentionsDescription =>
      'Сповіщати лише коли вас згадують або використовують @room';

  @override
  String get chatNotifyMutedDescription =>
      'Вимкнути сповіщення цього чату на всіх пристроях';

  @override
  String get scheduledMessagesTitle => 'Заплановані повідомлення';

  @override
  String get scheduledMessagesEmpty => 'Ще немає запланованих повідомлень';

  @override
  String get scheduledMessagesHint =>
      'Натисніть і утримуйте «Надіслати», «Фото», «Файли», GIF або наліпку, щоб запланувати повідомлення.';

  @override
  String get scheduledMessageCancelled => 'Заплановане повідомлення скасовано';

  @override
  String scheduledMessageCreatedAt(String time) {
    return 'Створено: $time';
  }

  @override
  String get scheduledDeliveryUnconfirmed => 'Доставку не підтверджено';

  @override
  String get scheduledRecoveryCopy => 'Зберегти копію для відновлення';

  @override
  String get scheduledRecoveryCopyHint =>
      'Збережено на цьому пристрої без зміни чи надсилання повідомлень. Попередній перегляд показує до 8 000 символів.';

  @override
  String get scheduledRecoveryCopies => 'Копії для відновлення';

  @override
  String get scheduledRecoveryReset => 'Скинути пошкоджену чергу';

  @override
  String get scheduledRecoveryResetHint =>
      'Точну копію збережено на цьому пристрої. Скинути всі заплановані повідомлення цього облікового запису? Деякі могли вже бути надіслані. Копії та вкладення збережуться. Нічого не буде надіслано повторно.';

  @override
  String get scheduledRecoveryExportHint =>
      'Цей файл містить незашифрований текст чернеток і дані облікового запису. Вкладення не включено. Виберіть надійне місце для збереження або надсилання.';

  @override
  String get scheduledRecoveryImport => 'Імпортувати копію для відновлення';

  @override
  String get scheduledRecoveryImportHint =>
      'Зберегти цей попередній перегляд лише як копію для відновлення. Повідомлення не будуть заплановані чи надіслані. Вкладення не включені. Автора файлу не перевірено.';

  @override
  String get scheduledRecoveryComposerHint =>
      'Додайте текст до поточної чернетки для перевірки. Нічого не буде надіслано. Вкладення, згадки й таймери не відновлюються. Перевірте, чи це повідомлення вже було доставлено.';

  @override
  String get backupRecoverLegacyArchive => 'Відновити стару локальну історію';

  @override
  String get backupLegacyArchiveWarning =>
      'Власника цієї історії не підтверджено. Копіюйте лише свої кімнати до вказаного нижче облікового запису. Оригінал збережеться.';

  @override
  String get backupOlderFiles => 'Старі файли резервних копій';

  @override
  String get backupOlderFilesWarning =>
      'Ці файли можуть належати іншому обліковому запису. Виберіть файл і перевірте його вміст та власника перед відновленням.';

  @override
  String get stickerImportTitle => 'Імпортувати набір наліпок';

  @override
  String get stickerImportLinkHint => 'Посилання на набір наліпок Matrix';

  @override
  String get stickerImportPreview => 'Попередній перегляд';

  @override
  String get stickerImportUnavailable =>
      'Цей набір недоступний або ви не маєте доступу.';

  @override
  String get stickerImportCopyNotice =>
      'Додайте приватну копію цього набору. Його зображення та метадані не захищені наскрізним шифруванням.';

  @override
  String get stickerImportFailed =>
      'Не вдалося додати цей набір. Спробуйте ще раз.';

  @override
  String get stickerImportAccountChanged =>
      'Обліковий запис змінено або сеанс завершився. Знову відкрийте імпорт наліпок.';

  @override
  String get stickerPackSourceRoom => 'Вихідний чат';

  @override
  String get stickerPackImages => 'Зображення';

  @override
  String get stickerPublishNotice =>
      'Опублікуйте цей набір у вибраній групі. Зображення та метадані не захищені наскрізним шифруванням. Люди, які можуть читати стан групи, можуть отримати до них доступ.';

  @override
  String get stickerPublishFailed =>
      'Публікацію не підтверджено. Перевірте групу перед повторною спробою.';

  @override
  String get stickerPublishReceiptMissing =>
      'Опубліковано, але посилання не збережено. Поділіться ним або скопіюйте його, перш ніж залишити сторінку.';

  @override
  String get stickerSubscribe => 'Підписатися на оновлення';

  @override
  String get stickerSubscribeNotice =>
      'Отримуйте майбутні зміни адміністраторів набору. Зображення й метадані не захищені наскрізним шифруванням. Підписку можна скасувати пізніше; ви не приєднаєтеся до вихідного чату.';

  @override
  String get stickerSubscriptions => 'Підписки на наліпки';

  @override
  String get stickerUnsubscribe => 'Скасувати підписку';

  @override
  String get stickerSubscriptionsEmpty => 'Немає підписок на наліпки';

  @override
  String get chatAttachmentEvent => 'Подія';

  @override
  String get chatRecentMedia => 'Нещодавні фото й відео';

  @override
  String get chatRecentMediaLoadFailed =>
      'Не вдалося завантажити нещодавні медіафайли';

  @override
  String get chatRecentMediaPermission =>
      'Для показу нещодавніх медіафайлів потрібен доступ до фото';

  @override
  String get chatRecentMediaEmpty => 'Немає нещодавніх фото чи відео';

  @override
  String get chatRecentPhoto => 'Нещодавнє фото';

  @override
  String get chatRecentVideo => 'Нещодавнє відео';

  @override
  String get chatAttachmentTip => 'Чайові';

  @override
  String get chatAttachmentWhiteboard => 'Дошка';

  @override
  String get chatAttachmentVideoNote => 'Відеоповідомлення';

  @override
  String get chatAttachmentCode => 'Код';

  @override
  String get chatAttachmentShop => 'Магазин';

  @override
  String chatSelectionLimit(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Ліміт вибору: $countString';
  }

  @override
  String scheduledSendTonightAt(String time) {
    return 'Сьогодні ввечері ($time)';
  }

  @override
  String scheduledSendTomorrowMorningAt(String time) {
    return 'Завтра вранці ($time)';
  }

  @override
  String get a11yScrollToBottom => 'Прокрутити вниз';

  @override
  String get ui3EnterMessageBeforeScheduling =>
      'Введіть повідомлення перед плануванням';

  @override
  String get ui3SendCode => 'Надіслати код';

  @override
  String get ui3CodeLanguage => 'Мова';

  @override
  String get ui3PasteCodeHere => 'Вставте код сюди';

  @override
  String ui3ReminderSetAt(String time) {
    return 'Нагадування встановлено · $time';
  }

  @override
  String get ui3RedPacketCreateFailed => 'Не вдалося створити червоний конверт';

  @override
  String get ui3SendTip => 'Надіслати чайові';

  @override
  String get ui3TokenLabel => 'Токен';

  @override
  String get ui3NoteOptional => 'Примітка (необов\'язково)';

  @override
  String ui3TipFailed(String error) {
    return 'Не вдалося надіслати чайові: $error';
  }

  @override
  String get ui3GiftNftTitle => 'Подарувати NFT';

  @override
  String get ui3TokenId => 'ID токена';

  @override
  String ui3NftGiftFailed(String error) {
    return 'Не вдалося подарувати NFT: $error';
  }

  @override
  String get ui3AiAgentSubtitle =>
      'Опишіть завдання — відкриється потрібний мінізастосунок';

  @override
  String get ui3GiftNft => 'Подарувати NFT';

  @override
  String get ui3GiftNftSubtitle => 'Надіслати NFT цьому контакту';

  @override
  String get ui3MiniAppUnavailable => 'Мінізастосунок недоступний';

  @override
  String ui3MediaItemsNotSent(int count) {
    return 'Не вдалося надіслати вибрані медіафайли: $count';
  }

  @override
  String get ui3PhotosSubtitle => 'Надсилайте фото й відео у форматі для чату';

  @override
  String get ui3OriginalImages => 'Оригінальні зображення';

  @override
  String get ui3OriginalImagesSubtitle => 'Надсилати нестиснені фото як файли';

  @override
  String ui3ScheduledFileFor(String filename, String time) {
    return '$filename: надсилання заплановано на $time';
  }

  @override
  String ui3SendingOriginalImage(String filename) {
    return 'Надсилання оригінального зображення: $filename';
  }

  @override
  String ui3ScheduledOriginalImage(String filename) {
    return 'Оригінальне зображення заплановано: $filename';
  }

  @override
  String get ui3PaymentAlreadySent => 'Платіж уже надіслано';

  @override
  String get ui3PaymentProcessing => 'Платіж обробляється';

  @override
  String ui3ChainStatus(String status) {
    return 'Статус у блокчейні: $status';
  }

  @override
  String get ui3NotChecked => 'Не перевірено';

  @override
  String ui3ConfirmationsCount(int confirmations, int required) {
    return 'Підтверджено: $confirmations / $required блоків';
  }

  @override
  String get ui3CopyTxHash => 'Копіювати хеш транзакції';

  @override
  String get ui3VerifyAgain => 'Перевірити ще раз';

  @override
  String get ui3VerifyOnChain => 'Перевірити в блокчейні';

  @override
  String get ui3TransferMissingChainDetails =>
      'Цей переказ не містить точних даних про мережу й актив.';

  @override
  String get ui3ReceiptPending => 'Очікує в блокчейні';

  @override
  String get ui3ReceiptConfirmed => 'Підтверджено';

  @override
  String get ui3ReceiptFailed => 'Помилка в блокчейні';

  @override
  String get ui3ReceiptMismatch => 'Дані транзакції не збігаються';

  @override
  String get ui3ReceiptUnsupported => 'Перевірка в блокчейні не підтримується';

  @override
  String get ui3ReceiptUnavailable => 'Перевірка недоступна';

  @override
  String get ui3OpenOrSave => 'Відкрити / Зберегти';

  @override
  String get ui3UnableToOpenFile => 'Не вдалося відкрити цей файл.';

  @override
  String ui3AiRewriteFailed(String error) {
    return 'Не вдалося переписати за допомогою ШІ: $error';
  }

  @override
  String get ui3AiShareMessagesTitle => 'Поділитися повідомленнями з ШІ?';

  @override
  String get ui3AiShareMessagesBody =>
      'Виберіть повідомлення, які ШІ може використати для цієї відповіді. Цей одноразовий дозвіл спливає через дві хвилини. Закриття швидкої відповіді скасовує очікувані результати. Він не дозволяє платежі чи експорт.';

  @override
  String get ui3OtherParticipant => 'Співрозмовник';

  @override
  String get ui3ShareSelected => 'Поділитися вибраними';

  @override
  String get ui3BotCommandError => 'Помилка команди';

  @override
  String get ui3BotUnknownCommand => 'Невідома команда';

  @override
  String get ui3BotTypeHelp => 'Введіть /help, щоб побачити доступні команди.';

  @override
  String get ui3FilesMediaLinks => 'Файли, медіа й посилання';

  @override
  String get ui3ChatStorage => 'Сховище чату';

  @override
  String get ui3EncryptionKeysDevices => 'Ключі шифрування й пристрої';

  @override
  String get ui3EncryptionServiceUnavailable =>
      'Служба шифрування ще недоступна';

  @override
  String get ui3ExportLoadingHistory =>
      'Завантаження історії чату для експорту...';

  @override
  String get ui3ExportTxtDesc =>
      'Текстовий запис для нотаток, резервної копії чи перевірки відповідності';

  @override
  String get ui3ExportCustomRange => 'Власний період';

  @override
  String get ui3ExportStart => 'Початок';

  @override
  String get ui3ExportEnd => 'Кінець';

  @override
  String get ui3ExportSelectDate => 'Виберіть дату';

  @override
  String get ui3FolderFilterUnreadOnly => 'Лише непрочитані';

  @override
  String get ui3FolderFilterMutedOnly => 'Лише вимкнені';

  @override
  String get ui3FolderFilterNoDms => 'Без особистих повідомлень';

  @override
  String get ui3FolderFilterNoGroups => 'Без груп';

  @override
  String get ui3FolderFilterNoChannels => 'Без каналів';

  @override
  String get ui3FolderFilterAllChats => 'Усі чати';

  @override
  String get ui3Create => 'Створити';

  @override
  String ui3DeleteFolderConfirm(String name) {
    return 'Видалити папку «$name»?';
  }

  @override
  String get a11yDecreaseTextSize => 'Зменшити шрифт';

  @override
  String get a11yIncreaseTextSize => 'Збільшити шрифт';

  @override
  String ui3MinutesRead(int minutes) {
    return '$minutes хв читання';
  }

  @override
  String get ui3TipOnChain => 'У блокчейні ✓';

  @override
  String get ui3ViewSource => 'Переглянути джерело';

  @override
  String get a11yPreviousPage => 'Попередня сторінка';

  @override
  String get a11yNextPage => 'Наступна сторінка';

  @override
  String get ui3OpenExternalLinkTitle => 'Відкрити зовнішнє посилання?';

  @override
  String get ui3Open => 'Відкрити';

  @override
  String get ui3UnableToOpenLink => 'Не вдалося відкрити це посилання.';

  @override
  String get ui3ImageUnavailable => 'Зображення недоступне';

  @override
  String ui3LoadImageFrom(Object host) {
    return 'Завантажити зображення з $host';
  }

  @override
  String ui3RetryImageFrom(Object host) {
    return 'Повторно завантажити зображення з $host';
  }

  @override
  String get ui3TranslatedByN42 => 'Перекладено N42';

  @override
  String ui3TranslatedFromByN42(Object language) {
    return 'Перекладено N42 з мови: $language';
  }

  @override
  String get ui3ClearWhiteboardTitle => 'Очистити дошку?';

  @override
  String get ui3ClearWhiteboardMessage =>
      'Усі штрихи буде видалено для всіх. Цю дію не можна скасувати.';

  @override
  String get ui3WhiteboardLive => 'Дошка · Наживо';

  @override
  String get a11yPenColor => 'Колір пера';

  @override
  String get ui3AiDescribeOcr => 'Опис ШІ / OCR';

  @override
  String get ui3DocumentPreviewFailed =>
      'Не вдалося безпечно переглянути документ. Перевірте з\'єднання та розмір файлу (макс. 2 МБ).';

  @override
  String get ui3AiConsentMessage =>
      'Виберіть повідомлення, які ШІ може використати для цього підсумку. Цей одноразовий дозвіл спливає через дві хвилини. Він не дозволяє платежі чи експорт.';

  @override
  String get ui3AiSuggestedReplies => 'Запропоновані відповіді';

  @override
  String get ui3AiGeneratingSuggestions => 'Створення пропозицій...';

  @override
  String get ui3StickersEmpty => 'Стікерів поки немає';

  @override
  String get ui3StickersGet => 'Отримати стікери';

  @override
  String get a11yFormatBold => 'Жирний';

  @override
  String get a11yFormatItalic => 'Курсив';

  @override
  String get a11yFormatStrikethrough => 'Закреслений';

  @override
  String get a11yFormatInlineCode => 'Вбудований код';

  @override
  String get a11yFormatCodeBlock => 'Блок коду';

  @override
  String get a11yFormatChecklistItem => 'Пункт чек-листа';

  @override
  String get a11yFormatBulletList => 'Маркований список';

  @override
  String get a11yFormatNumberedList => 'Нумерований список';

  @override
  String get a11yFormatLink => 'Посилання';

  @override
  String get a11yFormatTable => 'Таблиця';

  @override
  String get a11yFormatMeetingTemplate => 'Шаблон зустрічі';

  @override
  String get a11yEmojiSmileys => 'Смайлики та люди';

  @override
  String get a11yEmojiHearts => 'Серця';

  @override
  String get a11yEmojiAnimals => 'Тварини та природа';

  @override
  String get a11yEmojiFood => 'Їжа та напої';

  @override
  String get a11yEmojiTravel => 'Подорожі та місця';

  @override
  String get a11yEmojiActivities => 'Активності';

  @override
  String get a11yEmojiObjects => 'Предмети';

  @override
  String get a11yEmojiSymbols => 'Символи';

  @override
  String get ui3FrequentlyUsed => 'Часто використовувані';

  @override
  String get ui3NoEditHistory => 'Немає історії змін';

  @override
  String get ui3EventNew => 'Нова подія';

  @override
  String get ui3EventTitleLabel => 'Назва';

  @override
  String get ui3EventLocationOptional => 'Місце (необов’язково)';

  @override
  String get ui3EventDescriptionOptional => 'Опис (необов’язково)';

  @override
  String get ui3EventSend => 'Надіслати подію';

  @override
  String get ui3EventTitleRequired => 'Вкажіть назву';

  @override
  String get ui3EventEndAfterStart =>
      'Час завершення має бути пізніше за початок';

  @override
  String get ui3MiniAppAgentIntro =>
      'Опишіть, що хочете зробити, — я відкрию потрібний мінізастосунок.';

  @override
  String get ui3MiniAppAgentExample => 'наприклад, обміняти ETH на USDC';

  @override
  String get ui3MiniAppAgentNoMatch =>
      'Відповідний мінізастосунок не знайдено. Спробуйте сформулювати інакше.';

  @override
  String ui3MiniAppOpen(Object appName) {
    return 'Відкрити $appName';
  }

  @override
  String get ui3MusicLinkPlatforms =>
      'Підтримуються посилання на пісні з NetEase Cloud Music, QQ Music, Kugou, Kuwo та інших сервісів';

  @override
  String get ui3PollMarkCorrectAnswer =>
      'Позначте непорожню правильну відповідь';

  @override
  String get ui3PollQuizMode => 'Режим вікторини';

  @override
  String get ui3PollAnswerExplanationHint =>
      'Пояснення до відповіді (необов’язково)';

  @override
  String get a11yCorrectAnswer => 'Правильна відповідь';

  @override
  String get ui3AiSuggestions => 'Пропозиції ШІ';

  @override
  String get a11yPaste => 'Вставити';

  @override
  String get a11yRefresh => 'Оновити';

  @override
  String get ui3RecoveryKeyStoreWarning =>
      'Зберігайте цей ключ у надійному місці. Це єдиний спосіб відновити зашифровані повідомлення, якщо ви втратите доступ до всіх пристроїв.';

  @override
  String ui3SavedToPath(Object path) {
    return 'Збережено: $path';
  }

  @override
  String get ui3UnknownAccount => 'Невідомий обліковий запис';

  @override
  String get ui3UnknownHomeserver => 'Невідомий домашній сервер';

  @override
  String get ui3ImportRecoveryKey => 'Імпорт ключа відновлення';

  @override
  String get ui3ImportRecoveryKeyDesc =>
      'Введіть або вставте ключ відновлення, щоб відновити ключі кімнат для історії зашифрованих повідомлень.';

  @override
  String ui3RecoveryKeyAccountInfo(Object account, Object homeserver) {
    return 'Обліковий запис: $account\\nДомашній сервер: $homeserver';
  }

  @override
  String get ui3Import => 'Імпортувати';

  @override
  String get ui3InvalidRecoveryKeyFormat =>
      'Неправильний формат ключа відновлення';

  @override
  String ui3RecoveryKeyPartialRestore(
    Object restored,
    Object total,
    Object failed,
  ) {
    return 'Відновлено ключів: $restored з $total. Не вдалося: $failed. Перевірте обліковий запис, мережу та резервну копію, а потім повторіть спробу. Частина історії може залишитися нечитабельною.';
  }

  @override
  String ui3RecoveryKeyRestoreSuccess(Object restored, Object total) {
    return 'Успішно відновлено ключів: $restored з $total';
  }

  @override
  String ui3ImportFailed(Object error) {
    return 'Помилка імпорту: $error';
  }

  @override
  String ui3PasskeyRegistrationFailed(Object error) {
    return 'Не вдалося зареєструвати ключ доступу: $error';
  }

  @override
  String get ui3PasskeyDefaultName => 'Мій ключ доступу';

  @override
  String get ui3PasskeyNameHint => 'наприклад, iPhone, MacBook';

  @override
  String get ui3PasskeyDeleteFailed => 'Не вдалося видалити ключ доступу';

  @override
  String get ui3TwoFactorAuth => 'Двофакторна автентифікація';

  @override
  String get ui3TwoFactorOnSubtitle =>
      'Увімкнено — потрібен код із застосунку-автентифікатора';

  @override
  String get ui3TwoFactorOffSubtitle =>
      'Вимкнено — захистіть застосунком-автентифікатором (TOTP)';

  @override
  String get ui3ShowRecoveryKey => 'Показати ключ відновлення';

  @override
  String get ui3ShowRecoveryKeyDesc =>
      'Показати ключ відновлення для резервного копіювання';

  @override
  String get ui3ImportRecoveryKeyHint =>
      'Відновлення повідомлень за допомогою ключа відновлення';

  @override
  String get ui3RecoveryKeyCreateFailed =>
      'Не вдалося створити ключ відновлення';

  @override
  String get ui3TotpIncorrectCode => 'Неправильний код, спробуйте ще раз';

  @override
  String get ui3TwoFactorEnabled => 'Двофакторну автентифікацію увімкнено';

  @override
  String get ui3TwoFactorDisabled => 'Двофакторну автентифікацію вимкнено';

  @override
  String get ui3TwoFactorTurnOffTitle => 'Вимкнути двофакторну автентифікацію?';

  @override
  String get ui3TwoFactorTurnOffMessage =>
      'Застосунок-автентифікатор більше не знадобиться. Пізніше його можна налаштувати знову з новим ключем.';

  @override
  String get ui3TurnOff => 'Вимкнути';

  @override
  String get ui3TwoFactorTotpTitle => 'Двофакторна (TOTP)';

  @override
  String get ui3TwoFactorIsOn => 'Двофакторну автентифікацію увімкнено';

  @override
  String get ui3TwoFactorCodeRequired =>
      'Потрібен код із застосунку-автентифікатора.';

  @override
  String get ui3TotpStepScan =>
      '1. Відскануйте цей QR-код застосунком-автентифікатором (Google Authenticator, Authy, 1Password…) або введіть ключ вручну.';

  @override
  String get ui3TotpKeyCopied => 'Ключ скопійовано';

  @override
  String get ui3TotpStepConfirm =>
      '2. Введіть 6-значний код для підтвердження.';

  @override
  String get ui3Enable => 'Увімкнути';

  @override
  String get ui3BackupSettingsDesc =>
      'Створіть резервну копію локальних налаштувань чату. Повідомлення буде відновлено із сервера після повторного входу.';

  @override
  String get ui3BackupKeysSeparate => 'Ключі шифрування керуються окремо';

  @override
  String get ui3BackupKeysSeparateHint =>
      'Скористайтеся «Безпека > Ключ відновлення», щоб зберегти доступ до зашифрованих повідомлень.';

  @override
  String ui3BackupRoomsSize(Object rooms, Object size) {
    return 'Кімнат: $rooms  $size';
  }

  @override
  String get ui3BackupRestoreFromFileDesc =>
      'Імпортуйте файл .n42backup з іншого пристрою або попередньої резервної копії. Ключі шифрування відновлюються окремо за допомогою ключа відновлення.';

  @override
  String get ui3UsernameSessionRequired =>
      'Для імені користувача потрібен активний сеанс';

  @override
  String get ui3SecuritySessionRequired =>
      'Для налаштувань безпеки потрібен активний сеанс';

  @override
  String get ui3ConnectedAccountsSessionRequired =>
      'Для пов’язаних облікових записів потрібен активний сеанс';

  @override
  String get ui3SystemAccounts => 'Система та облікові записи';

  @override
  String get ui3AccountIdentity => 'Обліковий запис та ідентичність';

  @override
  String get ui3Accounts => 'Облікові записи';

  @override
  String get ui3DevicesSessions => 'Пристрої та сеанси';

  @override
  String get ui3Integrations => 'Інтеграції';

  @override
  String get ui3ConnectedAccounts => 'Пов’язані облікові записи';

  @override
  String get ui3ConnectedAccountsDesc =>
      'Інтеграції з Telegram, WhatsApp, Discord та API-мостами';

  @override
  String get ui3SystemOverview => 'Огляд системи';

  @override
  String ui3AccountCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count облікового запису',
      many: '$count облікових записів',
      few: '$count облікові записи',
      one: '$count обліковий запис',
    );
    return '$_temp0';
  }

  @override
  String ui3DeviceCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пристрою',
      many: '$count пристроїв',
      few: '$count пристрої',
      one: '$count пристрій',
    );
    return '$_temp0';
  }

  @override
  String get ui3PrivacySecurityOverview =>
      'Наскрізне шифрування, захист від знімків екрана та налаштування проксі';

  @override
  String get ui3ConversationPrivacy => 'Конфіденційність розмов';

  @override
  String get ui3NetworkPrivacy => 'Конфіденційність мережі';

  @override
  String get ui3IdentityPrivacy => 'Конфіденційність особи';

  @override
  String get ui3EncryptionKeyBackup => 'Шифрування та резервна копія ключів';

  @override
  String get ui3DevicesVerification => 'Пристрої та перевірка';

  @override
  String get ui3ChipE2eeDefault => 'E2EE за замовчуванням';

  @override
  String get ui3ChipManualE2ee => 'E2EE вручну';

  @override
  String get ui3ChipSelfDestruct => 'Самознищення';

  @override
  String get ui3ChipScreenshotGuard => 'Захист від знімків екрана';

  @override
  String get ui3ChipIpProxy => 'IP / проксі';

  @override
  String get ui3ChipLinkPreviewsOff => 'Попередній перегляд посилань вимк.';

  @override
  String get ui3ChipPublicHandle => 'Публічне ім’я';

  @override
  String get a11yShowPassword => 'Показати пароль';

  @override
  String get a11yHidePassword => 'Приховати пароль';

  @override
  String get a11yCheckServer => 'Перевірити сервер';

  @override
  String get ui3AuthAnonymousRegistration => 'Анонімна реєстрація';

  @override
  String get ui3AuthAnonymousRegistrationDesc =>
      'Створіть акаунт без прив’язки телефону чи ел. пошти. Ім’я користувача буде створено автоматично.';

  @override
  String get ui3AuthAnonymousModeOn => 'Анонімний режим увімкнено';

  @override
  String get ui3AuthAnonymousModeOnDesc =>
      'Застосунок створить для вас випадкове ім’я користувача Matrix. Пізніше ви зможете увійти зі створеним акаунтом і паролем.';

  @override
  String get ui3AuthChooseLoginMethod => 'Виберіть спосіб входу';

  @override
  String get ui3AuthSsoOpenFailed => 'Не вдалося відкрити сторінку входу SSO';

  @override
  String get ui3AuthWalletUnavailable => 'Гаманець недоступний';

  @override
  String get ui3ProfileSubscriptions => 'Підписки';

  @override
  String get ui3ProfileBuySellCrypto => 'Купити / продати криптовалюту';

  @override
  String get ui3ProfileOnDeviceAi => 'ШІ на пристрої';

  @override
  String get ui3ProfileSetAUsername => 'Задати ім’я користувача';

  @override
  String get ui3ProfileAvatarStudio => 'Студія аватарів';

  @override
  String get ui3ProfileAvatarStudioSubtitle => 'NFT-аватар / прикраси';

  @override
  String get ui3ProfileCustomize => 'Налаштувати';

  @override
  String get ui3ProfileQrSubtitle =>
      'Відскануйте, щоб відкрити цей профіль або почати чат';

  @override
  String get ui3PrivacyHardening => 'Посилена приватність';

  @override
  String get ui3HidePhoneNumber => 'Приховати номер телефону';

  @override
  String get ui3HidePhoneNumberDesc =>
      'Маскувати прив’язаний номер телефону на екранах профілю на цьому пристрої';

  @override
  String get ui3EncryptNewChatsByDefault =>
      'Шифрувати нові чати за замовчуванням';

  @override
  String get ui3EncryptNewChatsByDefaultDesc =>
      'Створювати нові особисті чати й приватні кімнати з увімкненим E2EE';

  @override
  String get ui3PrivateChatMode => 'Режим приватного чату';

  @override
  String get ui3PrivateChatModeDesc =>
      'Тимчасово блокувати знімки екрана під час перегляду приватних або зашифрованих чатів';

  @override
  String get ui3DefaultSelfDestructTimer =>
      'Таймер самознищення за замовчуванням';

  @override
  String get ui3DefaultSelfDestructTimerDesc =>
      'Застосовувати таймер самознищення за замовчуванням до нових повідомлень';

  @override
  String get ui3LinkPreviews => 'Попередній перегляд посилань';

  @override
  String get ui3LinkPreviewsDesc =>
      'Завантажувати заголовки, описи й мініатюри, якщо повідомлення містять URL';

  @override
  String get ui3IpAddressProtection => 'Захист IP-адреси';

  @override
  String get ui3IpAddressProtectionDesc =>
      'Спрямовувати запити Matrix і попереднього перегляду посилань через налаштований HTTP-проксі для приватності, якщо він доступний';

  @override
  String get ui3UseTorProxy => 'Використовувати HTTP-проксі Tor / Privoxy';

  @override
  String get ui3UseTorProxyDesc =>
      'Використовуйте локальний HTTP-проксі, наприклад Privoxy на 127.0.0.1:8118. Нативна маршрутизація Tor через SOCKS5 тут не підтримується.';

  @override
  String get ui3CustomProxy => 'Власний проксі';

  @override
  String get ui3CustomProxyDesc =>
      'Використовувати власний HTTP- або HTTPS-проксі для трафіку Matrix і попереднього перегляду посилань';

  @override
  String get ui3ProxyEndpoint => 'Адреса проксі';

  @override
  String get ui3ProxyEndpointDesc =>
      'Адреса HTTP/HTTPS-проксі (SOCKS не підтримується)';

  @override
  String get ui3InvalidEndpoint => 'Недійсна адреса';

  @override
  String get ui3CustomProxyStaysOff =>
      'Власний проксі залишатиметься вимкненим, доки ви не вкажете дійсну адресу';

  @override
  String get ui3NotificationFilterNote =>
      'Пріоритетні правила сповіщають завжди (в обхід вимкненого звуку, режиму «лише згадки» та «Не турбувати»). Приглушені ключові слова блокують сповіщення.';

  @override
  String get ui3PriorityKeywords => 'Пріоритетні ключові слова';

  @override
  String get ui3PriorityKeywordHint => 'напр., терміново';

  @override
  String get ui3MutedKeywords => 'Приглушені ключові слова';

  @override
  String get ui3MutedKeywordHint => 'напр., спам';

  @override
  String get ui3PrioritySenders => 'Пріоритетні відправники';

  @override
  String get ui3CaseSensitive => 'З урахуванням регістру';

  @override
  String get ui3None => 'Немає';

  @override
  String get ui3SmartReplyTranslation => 'Переклад розумних відповідей';

  @override
  String get ui3SmartReplyTranslationDesc =>
      'Автоматично перекладати ваші повідомлення мовою одержувача перед надсиланням.';

  @override
  String get ui3FromPhotos => 'З фото';

  @override
  String get ui3ChangePhoto => 'Змінити фото';

  @override
  String get ui3RoamingUsesMobileData =>
      'У роумінгу діють правила мобільних даних';

  @override
  String get ui3RoamingUsesMobileDataDesc =>
      'Окреме визначення роумінгу поки недоступне, тому в роумінгу зараз діють налаштування автозавантаження для мобільних даних.';

  @override
  String ui3DeleteQuickReplyConfirm(String content) {
    return 'Видалити «$content»?';
  }

  @override
  String get ui3ResetToDefaults => 'Скинути до стандартних';

  @override
  String get ui3ResetQuickRepliesMessage =>
      'Усі власні швидкі відповіді буде видалено, а стандартні — відновлено. Продовжити?';

  @override
  String get ui3LocalLlmUnavailable => 'Не підтримується на цьому пристрої';

  @override
  String get ui3LocalLlmNotDownloaded => 'Модель не завантажено';

  @override
  String get ui3LocalLlmReady => 'Готово (на пристрої)';

  @override
  String get ui3LocalLlmDescription =>
      'Коли функцію ввімкнено й вона готова, функції ШІ (підсумок, переписування, переклад, відповіді) працюють повністю на пристрої — дані ніколи не залишають ваш телефон. Інакше використовується хмарний провайдер.';

  @override
  String get ui3UseOnDeviceAi => 'Використовувати ШІ на пристрої';

  @override
  String get ui3UseOnDeviceAiDesc =>
      'Надавати перевагу локальному інференсу, коли він готовий';

  @override
  String get ui3DownloadModel => 'Завантажити модель';

  @override
  String get ui3LocalLlmRuntimeRequired =>
      'Для інференсу на пристрої потрібне нативне середовище виконання (Android MediaPipe / iOS Core ML). Воно ввімкнеться автоматично, щойно стане доступним обробник платформи.';

  @override
  String get ui3PhotoAvatar => 'Фото-аватар';

  @override
  String get ui3AvatarStyles => 'Стилі аватара';

  @override
  String get ui3AvatarStylesDesc =>
      'Один вибір прикрас для профілю та всіх точок входу аватара.';

  @override
  String get ui3ReplaceNftAvatar => 'Замінити NFT-аватар';

  @override
  String get ui3NftAvatarDesc =>
      'Використовуйте ончейн-колекційний предмет як аватар.';

  @override
  String get ui3UsePhotoAvatar => 'Використовувати фото-аватар';

  @override
  String get ui3UsePhotoAvatarDesc =>
      'Залишити завантажений аватар і відв’язати NFT.';

  @override
  String ui3AvatarStyleSet(Object name) {
    return 'Стиль аватара: $name';
  }

  @override
  String get ui3NftAvatarUpdated => 'NFT-аватар оновлено';

  @override
  String get ui3SwitchedToPhotoAvatar => 'Повернено фото-аватар';

  @override
  String get ui3SignInToViewRedPacketHistory =>
      'Увійдіть, щоб переглянути історію червоних конвертів';

  @override
  String get ui3RedPacketActive => 'Активні';

  @override
  String get ui3RedPacketCompleted => 'Завершені';

  @override
  String get ui3CardsAndPasses => 'Картки й перепустки';

  @override
  String get ui3CardsAndPassesDesc =>
      'Картки гаманця, купони й перепустки керуються в основному застосунку.';

  @override
  String get ui3CardPackRequiresMainApp =>
      'Для набору карток потрібен основний застосунок';

  @override
  String get ui3OpenCardPack => 'Відкрити набір карток';

  @override
  String get ui3UnableToOpenChat => 'Не вдалося відкрити чат із цим контактом';

  @override
  String get ui3WalletManagedInMainApp =>
      'Гаманець керується в основному застосунку';

  @override
  String ui3CreatorPlans(Object name) {
    return '$name · Тарифи';
  }

  @override
  String get ui3NewPlan => 'Новий тариф';

  @override
  String get ui3MySubscriptions => 'Мої підписки';

  @override
  String get ui3AvailablePlans => 'Доступні тарифи';

  @override
  String get ui3NoPlansYet =>
      'Тарифів ще немає · натисніть «Новий тариф», щоб створити';

  @override
  String ui3DaysLeft(Object days) {
    return 'Залишилося $days дн.';
  }

  @override
  String get ui3SubscriptionCancelled => 'Скасовано';

  @override
  String get ui3AutoRenewOn => 'Автопродовження: увімк.';

  @override
  String get ui3AutoRenewOff => 'Автопродовження: вимк.';

  @override
  String get ui3CancelSubscriptionTitle => 'Скасувати підписку?';

  @override
  String ui3CancelSubscriptionConfirm(Object name) {
    return 'Ваша підписка на $name діятиме до завершення терміну й не буде поновлена.';
  }

  @override
  String get ui3Subscribe => 'Підписатися';

  @override
  String ui3SubscribedTo(Object name) {
    return 'Ви підписалися на $name';
  }

  @override
  String get ui3PlanPriceLabel => 'Ціна (напр., 9.9 USDT)';

  @override
  String get ui3PlanDescriptionLabel => 'Опис (необов\'язково)';

  @override
  String get ui3PlanBenefitsLabel => 'Переваги (через кому)';

  @override
  String get ui3PlanPeriod => 'Період:';

  @override
  String get ui3Monthly => 'Щомісяця';

  @override
  String get ui3Yearly => 'Щороку';

  @override
  String get ui3SaveRemarkFailed => 'Не вдалося зберегти примітку';

  @override
  String get ui3CopyLink => 'Копіювати посилання';

  @override
  String get ui3Connect => 'Зв\'язатися';

  @override
  String get ui3CommonTokens => 'Спільні токени';

  @override
  String get ui3SharedNfts => 'Спільні NFT';

  @override
  String get ui3TransactionHistory => 'Історія транзакцій';

  @override
  String get ui3CommonDaos => 'Спільні DAO';

  @override
  String get ui3SameChains => 'Спільні мережі';

  @override
  String get ui3ChatInitFailed => 'Не вдалося ініціалізувати чат';

  @override
  String get ui3CheckNetworkRetry =>
      'Перевірте підключення до мережі та спробуйте ще раз';

  @override
  String get ui3FromContacts => 'З контактів';

  @override
  String get ui3FindFriendsFromContacts =>
      'Знайдіть друзів серед контактів телефону';

  @override
  String get ui3EnsOrDomain => 'ENS / домен';

  @override
  String get ui3LoadingContacts => 'Завантаження контактів...';

  @override
  String get ui3ContactsPermissionRequired => 'Потрібен доступ до контактів';

  @override
  String get ui3ContactsPermissionMessage =>
      'Щоб знайти друзів серед контактів, дозвольте доступ до них.';

  @override
  String get ui3AllowAccess => 'Дозволити доступ';

  @override
  String get ui3NoContactMatches => 'Збігів не знайдено';

  @override
  String get ui3NoContactMatchesMessage =>
      'Ніхто з ваших контактів ще не користується застосунком. Запросіть їх!';

  @override
  String ui3ScannedContacts(Object count) {
    return 'Проскановано контактів: $count';
  }

  @override
  String ui3FoundContactMatches(Object count) {
    return 'Знайдено збігів у контактах: $count';
  }

  @override
  String ui3InContactsAs(Object name) {
    return 'У контактах: $name';
  }

  @override
  String get ui3DeletePhotoConfirm => 'Видалити це фото?';

  @override
  String get ui3InviteLink => 'Посилання-запрошення';

  @override
  String get ui3ShareJoinLink => 'Поділитися посиланням для входу в цю кімнату';

  @override
  String get ui3ShareRoomReference =>
      'Поділитися посиланням на кімнату із запрошеними учасниками';

  @override
  String get ui3ScanToJoinGroup =>
      'Відскануйте, щоб одразу приєднатися до групи';

  @override
  String get ui3ScanToShareRoomReference =>
      'Відскануйте, щоб поділитися посиланням на кімнату із запрошеними';

  @override
  String get ui3InviteLinkLoadFailed =>
      'Не вдалося завантажити посилання-запрошення';

  @override
  String get ui3InviteLinkCopied => 'Посилання-запрошення скопійовано';

  @override
  String get ui3ChannelCategoryOptional => 'Категорія (необов\'язково)';

  @override
  String get ui3ChannelCategoryHint => 'Оголошення / Продукт / Підтримка';

  @override
  String get ui3DescriptionOptional => 'Опис (необов\'язково)';

  @override
  String get ui3WebhookEnable => 'Увімкнути автоматизацію webhook';

  @override
  String get ui3WebhookEnableDesc =>
      'Надсилати події приєднання учасників і привітання на ваш ендпоінт інтеграції.';

  @override
  String get ui3WebhookUrl => 'URL webhook';

  @override
  String get ui3WebhookSecretOptional => 'Секрет підпису (необов\'язково)';

  @override
  String get ui3WebhookSecretHint => 'Використовується для X-N42-Signature';

  @override
  String get ui3WebhookNotifyMemberJoined =>
      'Сповіщати, коли учасник приєднується';

  @override
  String get ui3WebhookNotifyWelcomeSent =>
      'Сповіщати про надсилання привітання';

  @override
  String get ui3WebhookTestSend => 'Надіслати тестовий webhook';

  @override
  String get ui3WebhookTestSending => 'Надсилання тестового webhook...';

  @override
  String get ui3WebhookTestSent => 'Тестовий webhook успішно надіслано';

  @override
  String get ui3WebhookTestFailed => 'Не вдалося надіслати тестовий webhook';

  @override
  String get ui3WebhookUrlInvalid =>
      'URL webhook має бути публічною адресою HTTPS';

  @override
  String get ui3WebhookSelectEvent => 'Виберіть принаймні одну подію webhook';

  @override
  String get ui3SensitiveDataDetection => 'Виявлення конфіденційних даних';

  @override
  String get ui3Email => 'Ел. пошта';

  @override
  String get ui3CreditCard => 'Банківська картка';

  @override
  String get ui3DetectEmailDesc =>
      'Виявляти адреси ел. пошти в текстових повідомленнях';

  @override
  String get ui3DetectPhoneDesc =>
      'Виявляти номери телефонів, зокрема міжнародні';

  @override
  String get ui3DetectCardDesc => 'Виявляти ймовірні номери рахунків і карток';

  @override
  String get ui3DetectWalletDesc =>
      'Виявляти адреси гаманців у форматі Ethereum';

  @override
  String get ui3GeneralTopic => 'Загальне';

  @override
  String get a11yPreviousResult => 'Попередній результат';

  @override
  String get a11yNextResult => 'Наступний результат';

  @override
  String get ui3TryDifferentKeywords => 'Спробуйте інші ключові слова';

  @override
  String ui3FiltersActive(Object count) {
    return 'Активні фільтри: $count';
  }

  @override
  String ui3MessageFiltersActive(Object count) {
    return 'Активні фільтри повідомлень: $count';
  }

  @override
  String get ui3LoadMore => 'Завантажити ще';

  @override
  String get ui3MessageFilters => 'Фільтри повідомлень';

  @override
  String get ui3SenderUserId => 'ID користувача-відправника';

  @override
  String get ui3FilterType => 'Тип';

  @override
  String get ui3FilterAny => 'Будь-який';

  @override
  String get ui3FilterImage => 'Зображення';

  @override
  String get ui3FilterTime => 'Час';

  @override
  String get ui3AnyTime => 'За весь час';

  @override
  String get ui3OnlyMyMessages => 'Лише мої повідомлення';

  @override
  String get ui3MediaOnly => 'Лише медіа';

  @override
  String get ui3Apply => 'Застосувати';

  @override
  String get ui3QrStyleClassic => 'Класичний';

  @override
  String get ui3QrStyleOcean => 'Океан';

  @override
  String get ui3QrStyleBerry => 'Ягода';

  @override
  String get ui3NfcUnavailable =>
      'NFC недоступний або мітка не підтримується. Увімкніть NFC, спробуйте іншу мітку або скористайтеся QR.';

  @override
  String get ui3CancelNfc => 'Скасувати NFC';

  @override
  String get ui3ReadNfcTag => 'Зчитати NFC-мітку';

  @override
  String get ui3HoldNearNfcTag => 'Піднесіть телефон до мітки сервісу.';

  @override
  String get a11yFlashlightOn => 'Увімкнути ліхтарик';

  @override
  String get a11yFlashlightOff => 'Вимкнути ліхтарик';

  @override
  String get ui3SocialGraph => 'Соціальний граф';

  @override
  String get ui3RecommendedConnections => 'Рекомендовані зв\'язки';

  @override
  String get ui3Portfolio => 'Портфель';

  @override
  String get ui3Chains => 'Мережі';

  @override
  String get ui3Tokens => 'Токени';

  @override
  String get ui3NoConnectionsFound => 'Зв\'язків не знайдено';

  @override
  String get ui3ConnectionsHint =>
      'Зв\'язки з\'являться з вашою ончейн-активністю';

  @override
  String get ui3SocialGraphLoadFailed =>
      'Не вдалося завантажити соціальний граф';

  @override
  String get ui3Similarity => 'Схожість';

  @override
  String get ui3Breakdown => 'Деталізація';

  @override
  String get ui3TokenHoldings => 'Токени у володінні';

  @override
  String get ui3NftCollections => 'Колекції NFT';

  @override
  String get ui3ChainUsage => 'Використання мереж';

  @override
  String get ui3Transactions => 'Транзакції';

  @override
  String get ui3DaoMembership => 'Членство в DAO';

  @override
  String get ui3NotWeighted => 'Без ваги';

  @override
  String ui3PercentWithWeight(Object percent, Object weight) {
    return '$percent% (вага: $weight)';
  }

  @override
  String get ui3CommonOnChainActivity => 'Спільна ончейн-активність';

  @override
  String get ui3SharedTokens => 'Спільні токени';

  @override
  String get ui3SharedNftCollections => 'Спільні колекції NFT';

  @override
  String get ui3SharedChains => 'Спільні мережі';

  @override
  String get ui3NoSharedTokens => 'Спільних токенів не знайдено';

  @override
  String get ui3NoSharedNftCollections => 'Спільних колекцій NFT не знайдено';

  @override
  String get ui3NoSharedChains => 'Спільних мереж не знайдено';

  @override
  String get ui3SimilarityFailed => 'Не вдалося обчислити схожість';

  @override
  String ui3ItemsAndMore(Object items, Object count) {
    return '$items і ще $count';
  }

  @override
  String get a11yGovernance => 'Врядування';

  @override
  String get ui3CommunityLink => 'Посилання на спільноту';

  @override
  String get ui3CommunityQrCode => 'QR-код спільноти';

  @override
  String get ui3CommunityQrSubtitle =>
      'Скануйте, щоб приєднатися до спільноти й переглядати її канали';

  @override
  String get ui3CommunityLinkLoadFailed =>
      'Не вдалося завантажити посилання на спільноту';

  @override
  String get ui3CommunityLinkCopied => 'Посилання на спільноту скопійовано';

  @override
  String ui3KickMemberConfirm(Object name) {
    return '$name буде видалено зі спільноти.';
  }

  @override
  String ui3BanMemberConfirm(Object name) {
    return '$name буде видалено без можливості повернутися.';
  }

  @override
  String get ui3SignInToDiscoverChannels =>
      'Увійдіть, щоб знаходити публічні канали';

  @override
  String ui3UnableToJoinChannel(Object name, Object error) {
    return 'Не вдалося приєднатися до $name: $error';
  }

  @override
  String get ui3CategoryTech => 'Технології';

  @override
  String get ui3CategorySocial => 'Спілкування';

  @override
  String get ui3NoPublicChannels => 'Публічних каналів не знайдено';

  @override
  String get ui3StoriesAndFun => 'Історії та розваги';

  @override
  String get ui3SearchMusicHint => 'Пошук пісень, виконавців або друзів';

  @override
  String get ui3ForYou => 'Для вас';

  @override
  String get ui3Liked => 'Вподобані';

  @override
  String get ui3NoLikedMusic => 'Ще немає вподобаної музики';

  @override
  String get ui3NoMusicStories => 'Ще немає музичних історій';

  @override
  String get ui3LikedMusicHint =>
      'Торкніться сердечка біля пісні, щоб зберегти її тут.';

  @override
  String get ui3MusicStoriesHint =>
      'Тут з\'явиться музика, якою поділилися в історіях.';

  @override
  String ui3SharedBy(Object artist, Object name) {
    return '$artist · поділився(-лася) $name';
  }

  @override
  String ui3UnableToPlay(Object title, Object error) {
    return 'Не вдалося відтворити $title: $error';
  }

  @override
  String get a11yPreviousTrack => 'Попередній трек';

  @override
  String get a11yNextTrack => 'Наступний трек';

  @override
  String get a11yPlay => 'Відтворити';

  @override
  String get a11yPause => 'Призупинити';

  @override
  String get ui3Refresh => 'Оновити';

  @override
  String get ui3NearbyIntroTitle => 'Публічні дописи поруч';

  @override
  String get ui3NearbyIntroBody =>
      'Ваше місцезнаходження використовується один раз на цьому пристрої для сортування публічних моментів. Воно не завантажується, не транслюється й не показується іншим.';

  @override
  String get ui3UseMyLocation => 'Використати моє місцезнаходження';

  @override
  String get ui3NearbyUnavailable => 'Функція «Поруч» недоступна';

  @override
  String get ui3NoNearbyPosts => 'Поруч поки немає дописів';

  @override
  String get ui3NoNearbyPostsHint =>
      'Тут з\'являться публічні моменти з місцезнаходженням.';

  @override
  String get ui3NearbyDistanceNote =>
      'Приблизна відстань · лише публічні дописи з місцезнаходженням';

  @override
  String get ui3PublicLocationPost => 'Публічний допис із місцезнаходженням';

  @override
  String get ui3LocationServicesOff => 'Служби геолокації вимкнено';

  @override
  String get ui3LocationPermissionDenied => 'Доступ до геолокації заборонено';

  @override
  String get ui3EnableLocationInSettings =>
      'Дозвольте доступ до геолокації в налаштуваннях системи';

  @override
  String get ui3CreateStory => 'Створити історію';

  @override
  String get ui3CreateStoryDesc => 'Опублікуйте текстовий або фотостатус.';

  @override
  String get ui3StoryCamera => 'Камера історій';

  @override
  String get ui3StoryCameraDesc => 'Одразу до фільтрів і редагування фото.';

  @override
  String get ui3MomentsDesc => 'Відкрийте всю стрічку й коментарі.';

  @override
  String get ui3MomentCamera => 'Камера моментів';

  @override
  String get ui3MomentCameraDesc => 'Створіть допис і одразу виберіть медіа.';

  @override
  String get ui3GamesDesc => 'Відкрийте вбудований центр казуальних ігор.';

  @override
  String get ui3AvatarStudio => 'Студія аватарів';

  @override
  String get ui3AvatarStudioDesc => 'Прикраси, NFT-аватар і стиль профілю.';

  @override
  String get ui3SocialGraphDesc => 'Підписки, фанати та зв\'язки в блокчейні.';

  @override
  String get ui3SocialHubHeroTitle => 'Історії, моменти, ігри та аватари';

  @override
  String get ui3SocialHubHeroBody =>
      'Усі соціальні функції в одному місці, а не розкидані по чату, профілю та огляду.';

  @override
  String get ui3SocialGraphNotConfigured =>
      'Соціальний граф не налаштовано в цій збірці';

  @override
  String get ui3ConnectWalletForSocialGraph =>
      'Підключіть гаманець, щоб переглянути соціальний граф';

  @override
  String get ui3AvatarStudioSignIn => 'Для студії аватарів потрібно увійти';

  @override
  String get a11yRemoveImage => 'Видалити зображення';

  @override
  String get a11yBack => 'Назад';

  @override
  String get ui3MiniAppConfirmTransactionTitle => 'Підтвердіть транзакцію';

  @override
  String get ui3MiniAppConfirmTransactionBody =>
      'Мінізастосунок запитує надсилання транзакції від вашого імені.';

  @override
  String ui3MiniAppOpenTitle(Object name) {
    return 'Відкрити $name?';
  }

  @override
  String get ui3MiniAppOpenButton => 'Відкрити';

  @override
  String get ui3StoryReplySendFailed =>
      'Не вдалося надіслати відповідь на історію';

  @override
  String get ui3RedPacketDemoNotice =>
      'Демо-червоний конверт — лише запис у чаті, реальні ончейн-активи не переказуються.';

  @override
  String get ui3RedPacketCoverClassic => 'Класичний червоний';

  @override
  String get ui3RedPacketCoverGolden => 'Золотий';

  @override
  String get ui3RedPacketCoverPurple => 'Фіолетовий';

  @override
  String get ui3RedPacketCoverOceanBlue => 'Синій океан';

  @override
  String get ui3RedPacketCoverNatureGreen => 'Природний зелений';

  @override
  String get ui3RedPacketCoverRosePink => 'Рожевий';

  @override
  String get ui3RedPacketHistoryEmpty => 'Червоних конвертів поки немає';

  @override
  String get ui3TransferMerchantQrWithAmount => 'QR продавця (із сумою)';

  @override
  String get ui3TransferMerchantQrTitle => 'QR продавця';

  @override
  String get ui3TransferOpenAmountHint => 'Залиште порожнім для довільної суми';

  @override
  String get ui3FiatRampTitle => 'Купити / продати криптовалюту';

  @override
  String get ui3FiatRampBuy => 'Купити';

  @override
  String get ui3FiatRampSell => 'Продати';

  @override
  String get ui3FiatRampNotConfigured =>
      'Фіатне введення/виведення не налаштовано';

  @override
  String get a11yPointsAddRule => 'Додати правило винагороди';

  @override
  String get a11yGovernanceRemoveChoice => 'Видалити варіант';

  @override
  String get a11yGovernanceCreateProposal => 'Створити пропозицію';

  @override
  String get ui3MiniAppUpdateN42 => 'Оновити N42';

  @override
  String get ui3MiniAppOfficial => 'Офіційне';

  @override
  String ui3MiniAppUserCount(Object count) {
    return '$count користувачів';
  }

  @override
  String a11yStoryBackgroundColor(Object index) {
    return 'Колір фону $index';
  }

  @override
  String get a11yStoryAdd => 'Додати історію';

  @override
  String get ui3StoryPostFailed => 'Не вдалося опублікувати історію';

  @override
  String get ui3StoryTapToSelectImage => 'Торкніться, щоб вибрати зображення';

  @override
  String get ui3StoryChangeImage => 'Змінити';

  @override
  String ui3StoryMusicReadFailed(Object error) {
    return 'Не вдалося прочитати вибрану музику: $error';
  }

  @override
  String get ui3StoryDeleteConfirm => 'Видалити цю історію?';

  @override
  String get ui3StoryDeleteFailed => 'Не вдалося видалити історію';

  @override
  String get ui3MomentCreateTitle => 'Створити момент';

  @override
  String get ui3MomentContentHint => 'Що у вас нового?';

  @override
  String get ui3MomentAddPhotos => 'Додати фото';

  @override
  String get ui3MomentAddLocation => 'Додати місцезнаходження';

  @override
  String ui3MomentSelectedMedia(Object count) {
    return 'Вибрані медіафайли ($count)';
  }

  @override
  String get ui3MomentClearAll => 'Очистити все';

  @override
  String get ui3MomentClearMediaConfirm => 'Вилучити всі вибрані фото й відео?';

  @override
  String get ui3MomentVisibilityPublicDesc => 'Бачать усі друзі';

  @override
  String get ui3MomentVisibilityPrivateDesc => 'Бачите лише ви';

  @override
  String get ui3MomentVisibilityPartialDesc => 'Виберіть, кому видно';

  @override
  String get ui3MomentVisibilityExcludedDesc => 'Приховати від певних друзів';

  @override
  String get ui3MomentVideos => 'Відео';

  @override
  String get ui3MomentNoVideos => 'Відео поки немає';

  @override
  String get a11yCallMinimize => 'Згорнути';

  @override
  String get a11yCallGridView => 'Сітка';

  @override
  String get a11yCallFocusView => 'Режим фокусу';

  @override
  String get ui3CallTools => 'Інструменти виклику';

  @override
  String get ui3CallMeetingTools => 'Інструменти зустрічі';

  @override
  String get ui3CallToolsSubtitle =>
      'Налаштуйте якість звуку й відео, не виходячи з виклику.';

  @override
  String get ui3CallAudioEnhancement => 'Покращення звуку';

  @override
  String get ui3CallNoiseSuppression => 'Шумозаглушення';

  @override
  String get ui3CallNoiseSuppressionDesc =>
      'Зменшує шум клавіатури та фонові звуки.';

  @override
  String get ui3CallEchoCancellation => 'Ехоподавлення';

  @override
  String get ui3CallEchoCancellationDesc =>
      'Не дає звуку з динаміка потрапляти назад у мікрофон.';

  @override
  String get ui3CallAutoGainControl => 'Автоматичне регулювання підсилення';

  @override
  String get ui3CallAutoGainControlDesc =>
      'Робить гучність мікрофона стабільнішою.';

  @override
  String get ui3CallVoiceIsolation => 'Покращена ізоляція голосу';

  @override
  String get ui3CallVoiceIsolationDesc =>
      'Використовувати сильніший профіль шумозаглушення.';

  @override
  String get ui3CallVideoSection => 'Відео';

  @override
  String get ui3CallBackgroundBlur => 'Розмиття фону (бета)';

  @override
  String get ui3CallBlurDescReady =>
      'Налаштування застосовано. Фактичне розмиття залежить від впровадження обробки відео.';

  @override
  String get ui3CallBlurDescSaved =>
      'Налаштування розмиття збережено; його буде застосовано, коли стане доступна обробка камери.';

  @override
  String get ui3CallBlurDescCameraOff =>
      'Увімкніть камеру, коли стане доступна обробка фону.';

  @override
  String get ui3CallRecordingSection => 'Запис';

  @override
  String get ui3CallRecordingDesc =>
      'Для збереження записів потрібен серверний egress.';

  @override
  String ui3CallSettingsUpdateFailed(Object error) {
    return 'Не вдалося оновити налаштування виклику: $error';
  }

  @override
  String get ui3CallRecordingStarted => 'Запис розпочато';

  @override
  String get ui3VoiceRoomNotFound => 'Кімнату не знайдено';

  @override
  String get ui3VoiceRoomEndConfirm =>
      'Ви впевнені, що хочете завершити цю голосову кімнату?';

  @override
  String get a11yGameMoveUp => 'Посунути вгору';

  @override
  String get a11yGameMoveDown => 'Посунути вниз';

  @override
  String get a11yGameMoveLeft => 'Посунути вліво';

  @override
  String get a11yGameMoveRight => 'Посунути вправо';

  @override
  String get a11yGameRotate => 'Повернути';

  @override
  String get a11yGameDrop => 'Скинути';

  @override
  String ui3StickerAddedCount(Object count) {
    return 'Додано наліпок: $count';
  }

  @override
  String ui3StickerAddFailed(Object error) {
    return 'Не вдалося додати: $error';
  }

  @override
  String get ui3StickerRemoveTitle => 'Вилучити наліпку';

  @override
  String get ui3StickerRemoveConfirm => 'Вилучити цю наліпку з набору?';

  @override
  String get ui3StickerRemoveFailed => 'Не вдалося вилучити';

  @override
  String get ui3StickerRenamePack => 'Перейменувати набір';

  @override
  String get ui3StickerPackName => 'Назва набору';

  @override
  String get ui3StickerRenameFailed => 'Не вдалося перейменувати';

  @override
  String get ui3StickerDeletePack => 'Видалити набір';

  @override
  String get ui3StickerThisPack => 'цей набір';

  @override
  String ui3StickerDeletePackConfirm(Object name) {
    return 'Видалити «$name» і всі його наліпки? Цю дію не можна скасувати.';
  }

  @override
  String get ui3StickerDeleteFailed => 'Не вдалося видалити';

  @override
  String get ui3StickerPack => 'Набір наліпок';

  @override
  String get ui3StickerAdding => 'Додавання…';

  @override
  String get ui3StickerAddStickers => 'Додати наліпки';

  @override
  String get ui3StickerPackNotFound => 'Набір не знайдено';

  @override
  String get ui3StickerEmptyHint =>
      'Торкніться «Додати наліпки», щоб завантажити зображення';

  @override
  String get ui3StickerNewPack => 'Новий набір наліпок';

  @override
  String get ui3StickerCreate => 'Створити';

  @override
  String get ui3StickerCreateFailed => 'Не вдалося створити набір';

  @override
  String ui3StickerInstalled(Object name) {
    return '«$name» встановлено';
  }

  @override
  String get ui3StickerRemovePackTitle => 'Вилучити набір наліпок';

  @override
  String ui3StickerRemovePackConfirm(Object name) {
    return 'Вилучити «$name» з ваших наліпок?';
  }

  @override
  String ui3StickerRemoved(Object name) {
    return '«$name» вилучено';
  }

  @override
  String get ui3StickerAiSticker => 'ШІ-наліпка';

  @override
  String get ui3StickerStoreTab => 'Магазин';

  @override
  String get ui3StickerMyStickersTab => 'Мої наліпки';

  @override
  String get ui3StickerNoneFound => 'Наліпок не знайдено';

  @override
  String ui3StickerByAuthor(Object author) {
    return 'від $author';
  }

  @override
  String get ui3StickerManage => 'Керувати';

  @override
  String ui3StickerCount(Object count) {
    return 'Наліпок: $count';
  }

  @override
  String get ui3StickerNoneInstalled => 'Немає встановлених наліпок';

  @override
  String get ui3StickerGetFromStore => 'Отримайте наліпки в магазині';

  @override
  String get ui3StickerBrowseStore => 'Переглянути магазин';

  @override
  String get ui3StickerAddedToAi => 'Додано до «ШІ-наліпки»';

  @override
  String get ui3StickerAddOneFailed => 'Не вдалося додати наліпку';

  @override
  String get ui3StickerPromptLabel => 'Опишіть свою наліпку';

  @override
  String get ui3StickerPromptHint =>
      'напр., весела руда кішка в сонцезахисних окулярах';

  @override
  String get ui3StickerGenerating => 'Створення…';

  @override
  String get ui3StickerGenerate => 'Створити';

  @override
  String get ui3StickerAddToStickers => 'Додати до наліпок';

  @override
  String get ui3StickerGeneratingPreview => 'Створюємо вашу наліпку…';

  @override
  String get ui3StickerGenerateEmpty =>
      'Опишіть наліпку й торкніться «Створити»';
}
