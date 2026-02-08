// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class SRu extends S {
  SRu([String locale = 'ru']) : super(locale);

  @override
  String get commonRetry => 'Повторить';

  @override
  String get commonUnknownUser => 'Неизвестный пользователь';

  @override
  String get transferWalletNotConnected => 'Кошелёк не подключён';

  @override
  String get chatCallServiceNotInitialized =>
      'Служба вызовов не инициализирована';

  @override
  String authLoginFailed(String error) {
    return 'Ошибка входа: $error';
  }

  @override
  String get chatCallBack => 'Перезвонить';

  @override
  String get chatMissedVideoCall => 'Пропущенный видеовызов';

  @override
  String get chatMissedVoiceCall => 'Пропущенный голосовой вызов';

  @override
  String get chatCallNotAnswered => 'Нет ответа';

  @override
  String get chatCallDurationLabel => 'Длительность звонка';

  @override
  String get chatVoiceCallCancelled => 'Голосовой звонок отменён';

  @override
  String get chatVideoCallCancelled => 'Видеозвонок отменён';

  @override
  String get commonImage => '[Изображение]';

  @override
  String get chatVideo => '[Видео]';

  @override
  String get chatVoice => '[Голосовое сообщение]';

  @override
  String get commonFile => '[Файл]';

  @override
  String get chatLocation => '[Местоположение]';

  @override
  String get chatUnknownMessage => '[Неизвестное сообщение]';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get chatDeleteThisMessage => 'Удалить это сообщение?';

  @override
  String get chatMessageDeleted => 'Сообщение удалено';

  @override
  String get profileNotLoggedIn => 'Не выполнен вход';

  @override
  String get chatMyLocation => 'Моё местоположение';

  @override
  String get commonGroupChat => 'Групповой чат';

  @override
  String get commonSearch => 'Поиск';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonLoadFailed => 'Ошибка загрузки';

  @override
  String get commonMessages => 'Сообщения';

  @override
  String get commonContacts => 'Контакты';

  @override
  String get commonMe => 'Я';

  @override
  String get commonVoiceLoading =>
      'Загрузка голосового сообщения, попробуйте позже';

  @override
  String get commonVoiceToTextFailed =>
      'Не удалось преобразовать голос в текст';

  @override
  String get commonConvertToText => 'В текст';

  @override
  String get chatCopy => 'Копировать';

  @override
  String get commonForward => 'Переслать';

  @override
  String get commonUnfavorite => 'Удалить из избранного';

  @override
  String get commonFavorite => 'В избранное';

  @override
  String get settingsResend => 'Отправить повторно';

  @override
  String get chatRecall => 'Отозвать';

  @override
  String get commonQuote => 'Цитировать';

  @override
  String get commonRemind => 'Напомнить';

  @override
  String get chatCopied => 'Скопировано';

  @override
  String get storySendMessageHint => 'Написать сообщение';

  @override
  String get commonMicrophonePermissionRequired =>
      'Пожалуйста, разрешите доступ к микрофону';

  @override
  String get chatMicrophonePermissionDeniedPermanent =>
      '麦克风权限已被拒绝，请在系统设置中开启以使用语音消息功能。';

  @override
  String commonStartRecordingFailed(String error) {
    return 'Не удалось начать запись: $error';
  }

  @override
  String get commonRecordingTooShort => 'Запись слишком короткая';

  @override
  String commonStopRecordingFailed(String error) {
    return 'Не удалось остановить запись: $error';
  }

  @override
  String get chatReleaseToCancel => 'Отпустите для отмены';

  @override
  String get chatReleaseToSend =>
      'Отпустите для отправки, смахните вверх для отмены';

  @override
  String get commonHoldToTalk => 'Удерживайте для записи';

  @override
  String get commonSend => 'Отправить';

  @override
  String get commonAddFriend => 'Добавить друга';

  @override
  String get commonChatServiceNotConnected => 'Служба чата не подключена';

  @override
  String contactUserNotFoundHint(String query) {
    return 'Пользователь \"$query\" не найден\n\nПодсказки:\n• Попробуйте ввести полный ID пользователя, например @username:server.com\n• Проверьте правильность написания имени';
  }

  @override
  String contactCreateChatFailed(String error) {
    return 'Не удалось создать чат: $error';
  }

  @override
  String contactSearchFailed(String error) {
    return 'Ошибка поиска: $error';
  }

  @override
  String get contactEnterUserIdOrUsername =>
      'Введите ID или имя пользователя для поиска';

  @override
  String get contactSearching => 'Поиск...';

  @override
  String get contactSearchUserToChat =>
      'Найдите пользователя, чтобы начать чат';

  @override
  String get contactMatrixIdExample =>
      'Вы можете ввести полный Matrix ID\nнапример @user:matrix.n42.network';

  @override
  String contactUserNotFound(String username) {
    return 'Пользователь \"$username\" не найден';
  }

  @override
  String get commonChat => 'Чат';

  @override
  String get commonSettings => 'Настройки';

  @override
  String get profileEditProfile => 'Редактировать профиль';

  @override
  String get authLogin => 'Войти';

  @override
  String get commonCreateGroup => 'Создать группу';

  @override
  String get chatError => 'Ошибка';

  @override
  String get commonTransfer => 'Перевод';

  @override
  String get commonReceived => 'Получено';

  @override
  String get commonRefunded => 'Возвращено';

  @override
  String get commonExpired => 'Истёк';

  @override
  String get chatRedPacketGreeting => 'С наилучшими пожеланиями';

  @override
  String get commonN42RedPacket => 'Красный конверт N42';

  @override
  String get commonClaimed => 'Получено';

  @override
  String get commonAllClaimed => 'Все получены';

  @override
  String get chatReadAloud => '朗读';

  @override
  String get chatReply => 'Ответить';

  @override
  String get commonEdit => 'Редактировать';

  @override
  String get chatSelectForwardTarget => 'Выбрать получателя';

  @override
  String commonSendCount(int count) {
    return 'Отправить ($count)';
  }

  @override
  String contactN42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get profileN42IdTitle => 'N42 ID';

  @override
  String get profileN42Bean => 'N42 Bean';

  @override
  String get contactFriendInfo => 'Информация о друге';

  @override
  String get contactFriendInfoDesc =>
      'Добавьте заметку, телефон, теги, примечания, фото и настройте разрешения.';

  @override
  String get commonMoments => 'Моменты';

  @override
  String get commonSendMessage => 'Сообщение';

  @override
  String get contactAudioVideoCall => 'Аудио/видеовызов';

  @override
  String get contactVideoChannel => 'Видеоканал';

  @override
  String get contactRemark => 'Заметка';

  @override
  String get contactRemarkName => 'Имя заметки';

  @override
  String get contactPhone => 'Телефон';

  @override
  String get contactTags => 'Теги';

  @override
  String get contactNotes => 'Заметки';

  @override
  String get contactPhotos => 'Фото';

  @override
  String get contactPermissions => 'Разрешения';

  @override
  String get contactChatMomentsEtc => 'Чат, Моменты, Спорт и т.д.';

  @override
  String get contactMoreInfo => 'Подробнее';

  @override
  String get contactCommonGroups => 'Общие группы';

  @override
  String get contactSource => 'Источник';

  @override
  String get settingsNotificationSettings => 'Уведомления';

  @override
  String get settingsPrivacy => 'Конфиденциальность';

  @override
  String get settingsAppearance => 'Внешний вид';

  @override
  String get settingsAbout => 'О приложении';

  @override
  String get commonLogout => 'Выйти';

  @override
  String get commonLogoutConfirm => 'Вы уверены, что хотите выйти?';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get profileNickname => 'Никнейм';

  @override
  String get profileEnterNickname => 'Введите никнейм';

  @override
  String get profileSignature => 'Подпись';

  @override
  String get profileAddSignature => 'Добавить подпись';

  @override
  String get commonTakePhoto => 'Сделать фото';

  @override
  String get profileChooseFromGallery => 'Выбрать из галереи';

  @override
  String profileSaveFailed(String error) {
    return 'Ошибка сохранения: $error';
  }

  @override
  String get authSecureDecentralizedChat =>
      'Безопасный децентрализованный мессенджер';

  @override
  String get commonEndToEndEncryption => 'Сквозное шифрование';

  @override
  String get authMessagesOnlyYouCanSee =>
      'Сообщения видны только вам и получателю';

  @override
  String get authDecentralized => 'Децентрализованный';

  @override
  String get authBasedOnMatrix => 'На основе открытого протокола Matrix';

  @override
  String get authWalletIntegration => 'Интеграция с кошельком';

  @override
  String get authEasyCryptoTransfer => 'Простые криптовалютные переводы';

  @override
  String get authRegister => 'Зарегистрироваться';

  @override
  String get authAgreeTerms => 'Входя в систему, вы соглашаетесь с';

  @override
  String get authTermsOfService => 'Условиями использования';

  @override
  String get authAnd => 'и';

  @override
  String get authPrivacyPolicy => 'Политикой конфиденциальности';

  @override
  String get authServerAddress => 'Адрес сервера';

  @override
  String get authEnterServerAddress => 'Введите адрес сервера';

  @override
  String authConnectedTo(String serverName) {
    return 'Подключено к $serverName';
  }

  @override
  String get authUsername => 'Имя пользователя';

  @override
  String get authEnterUsername => 'Введите имя пользователя';

  @override
  String get authPassword => 'Пароль';

  @override
  String get authEnterPassword => 'Введите пароль';

  @override
  String get authRegisterAccount => 'Зарегистрироваться';

  @override
  String get authForgotPassword => 'Забыли пароль';

  @override
  String get authOtherLoginMethods => 'Другие способы входа';

  @override
  String get authCreateAccount => 'Создать аккаунт';

  @override
  String get authJoinN42Chat =>
      'Присоединитесь к N42 Chat, чтобы начать общение';

  @override
  String get authUsernameHint => '3-20 символов, буквы/цифры/_';

  @override
  String get authUsernameMinLength =>
      'Имя пользователя должно содержать не менее 3 символов';

  @override
  String get authUsernameMaxLength =>
      'Имя пользователя должно содержать не более 20 символов';

  @override
  String get authUsernameFormat =>
      'Имя пользователя может содержать только буквы, цифры и подчёркивания';

  @override
  String get authPasswordHint => 'Минимум 8 символов';

  @override
  String get commonPasswordMinLength =>
      'Пароль должен содержать не менее 8 символов';

  @override
  String get authConfirmPassword => 'Подтвердите пароль';

  @override
  String get authFilled => 'Заполнено';

  @override
  String get authEnterInviteCode => 'Введите код приглашения';

  @override
  String get authAlreadyHaveAccount => 'Уже есть аккаунт?';

  @override
  String get authLoginNow => 'Войти';

  @override
  String get profileAvatar => 'Аватар';

  @override
  String get profileStatus => 'Статус';

  @override
  String get commonLoading => 'Загрузка...';

  @override
  String get conversationNoConversations => 'Нет разговоров';

  @override
  String get conversationTapToChat => 'Нажмите справа вверху, чтобы начать чат';

  @override
  String get conversationStartGroup => 'Создать групповой чат';

  @override
  String get commonScan => 'Сканировать';

  @override
  String get commonPayment => 'Оплата';

  @override
  String commonFeatureComingSoon(String feature) {
    return '$feature скоро появится';
  }

  @override
  String get conversationMarkAsRead => 'Отметить как прочитанное';

  @override
  String get commonUnmute => 'Включить звук';

  @override
  String get commonMute => 'Без звука';

  @override
  String get conversationUnpin => 'Открепить';

  @override
  String get conversationPin => 'Закрепить';

  @override
  String get conversationDeleteConversation => 'Удалить разговор';

  @override
  String conversationDeleteConversationConfirm(String name) {
    return 'Удалить разговор с \"$name\"?';
  }

  @override
  String get commonNoContacts => 'Нет контактов';

  @override
  String get contactAddFriendsToChat => 'Добавьте друзей, чтобы начать общение';

  @override
  String get contactNotFound => 'Контакт не найден';

  @override
  String get contactTryOtherKeywords =>
      'Попробуйте другие ключевые слова или глобальный поиск';

  @override
  String get contactSearchResults => 'Результаты поиска';

  @override
  String get contactNewFriends => 'Новые друзья';

  @override
  String get contactChatOnlyFriends => 'Chat-only Friends';

  @override
  String get contactOfficialAccounts => 'Официальные аккаунты';

  @override
  String get contactServiceAccounts => 'Сервисные аккаунты';

  @override
  String get contactEnterpriseContacts => 'Корпоративные контакты';

  @override
  String get contactRecommendToFriend => 'Поделиться контактом';

  @override
  String get commonSetRemark => 'Установить заметку';

  @override
  String get contactSendingCard => 'Отправка контактной карточки...';

  @override
  String get commonFileLabel => 'Файл';

  @override
  String get commonLocationLabel => 'Местоположение';

  @override
  String contactRecommendFailed(String error) {
    return 'Ошибка рекомендации: $error';
  }

  @override
  String get profileEnterRemark => 'Введите заметку';

  @override
  String get contactOpeningChat => 'Открытие чата...';

  @override
  String contactOpenChatFailed(String error) {
    return 'Не удалось открыть чат: $error';
  }

  @override
  String get contactAddContact => 'Добавить контакт';

  @override
  String get contactEnterUserId => 'Введите ID пользователя';

  @override
  String get contactNoFriendRequests => 'Нет запросов в друзья';

  @override
  String get commonAccept => 'Принять';

  @override
  String get commonReject => 'Отклонить';

  @override
  String get commonNoGroups => 'Нет групп';

  @override
  String get contactSelectFriendToRecommend =>
      'Выберите друга для рекомендации';

  @override
  String get commonSearchContacts => 'Поиск контактов';

  @override
  String get contactNoContactsFound => 'Контакты не найдены';

  @override
  String get favoriteYesterday => 'Вчера';

  @override
  String get chatJustNow => 'Только что';

  @override
  String get profileOnline => 'В сети';

  @override
  String get profileOffline => 'Не в сети';

  @override
  String get searchContactsGroupsMessages =>
      'Поиск контактов, групп, сообщений';

  @override
  String get searchError => 'Ошибка поиска';

  @override
  String get chatSearchHint => 'Поиск контактов, групп и сообщений';

  @override
  String get searchHistory => 'История поиска';

  @override
  String get commonClear => 'Очистить';

  @override
  String get commonAll => 'Все';

  @override
  String get searchGroups => 'Группы';

  @override
  String get searchNoResults => 'Нет результатов';

  @override
  String commonGroupMembers(int count) {
    return 'Участники ($count)';
  }

  @override
  String get groupMembersTitle => 'Участники группы';

  @override
  String get groupViewAll => 'Показать все';

  @override
  String get groupOwner => 'Владелец';

  @override
  String get groupAdmin => 'Администратор';

  @override
  String get groupInvite => 'Пригласить';

  @override
  String get commonGroupAnnouncement => 'Объявление группы';

  @override
  String get commonNotSet => 'Не установлено';

  @override
  String get groupDescription => 'Описание группы';

  @override
  String get groupPublicGroup => 'Публичная группа';

  @override
  String get commonClearChatHistory => 'Очистить историю чата';

  @override
  String get commonDissolveGroup => 'Распустить группу';

  @override
  String get commonLeaveGroup => 'Покинуть группу';

  @override
  String get groupChangeGroupName => 'Изменить название группы';

  @override
  String get commonEnterGroupName => 'Введите название группы';

  @override
  String get commonConfirm => 'Подтвердить';

  @override
  String get groupEnterGroupDescription => 'Введите описание группы';

  @override
  String get groupPublish => 'Опубликовать';

  @override
  String get chatClearHistoryConfirm =>
      'Очистить всю историю чата? Это действие нельзя отменить.';

  @override
  String get chatClearAction => 'Очистить';

  @override
  String get commonChatHistoryCleared => 'История чата очищена';

  @override
  String get commonDissolve => 'Распустить';

  @override
  String get groupQrCode => 'QR-код группы';

  @override
  String get commonSearchChatHistory => 'Поиск в истории чата';

  @override
  String get groupIdCopied => 'ID группы скопирован';

  @override
  String get transferEnterOrPasteAddress =>
      'Введите или вставьте адрес кошелька';

  @override
  String get transferSelectToken => 'Выбрать токен';

  @override
  String get commonTransferAmount => 'Сумма перевода';

  @override
  String get transferAvailable => 'Доступно';

  @override
  String get transferMemoOptional => 'Примечание (необязательно)';

  @override
  String get transferConfirmTransfer => 'Подтвердить перевод';

  @override
  String get transferAddressVerified => 'Адрес подтверждён';

  @override
  String transferAvailableBalance(String balance, String symbol) {
    return 'Доступно: $balance $symbol';
  }

  @override
  String get commonEnterAmount => 'Введите сумму';

  @override
  String get commonRedPacketCountMin => 'Требуется минимум 1 красный конверт';

  @override
  String get commonViewRedPacketDetails =>
      'Посмотреть детали красного конверта';

  @override
  String get commonEnterTransferAmount => 'Введите сумму перевода';

  @override
  String get commonTransferTo => 'Перевести';

  @override
  String commonFromSender(String name, Object senderName) {
    return 'От $senderName';
  }

  @override
  String get commonConfirmReceive => 'Подтвердить получение';

  @override
  String get groupProfile => 'Информация о группе';

  @override
  String get groupRemoveMember => 'Удалить из группы';

  @override
  String get commonRemove => 'Удалить';

  @override
  String get profileClearStatus => 'Очистить статус';

  @override
  String get profileClearStatusConfirm => 'Очистить текущий статус?';

  @override
  String get profileStatusCleared => 'Статус очищен';

  @override
  String get profileUserNotExist => 'Пользователь не существует';

  @override
  String get profileUserIdCopied => 'ID пользователя скопирован';

  @override
  String get commonReport => 'Пожаловаться';

  @override
  String get profileQrCode => 'QR-код';

  @override
  String get profileAvatarUpdated => 'Аватар обновлён';

  @override
  String commonSelectImageFailed(String error) {
    return 'Не удалось выбрать изображение: $error';
  }

  @override
  String get profileChangeName => 'Изменить имя';

  @override
  String get profileMale => 'Мужской';

  @override
  String get profileFemale => 'Женский';

  @override
  String chatFeatureInDev(String feature) {
    return '$feature в разработке...';
  }

  @override
  String profileSaveAddressFailed(String error) {
    return 'Не удалось сохранить адрес: $error';
  }

  @override
  String get profileAddNew => 'Добавить';

  @override
  String get profileAddAddress => 'Добавить адрес';

  @override
  String get profileAddressAdded => 'Адрес добавлен';

  @override
  String get profileAddressUpdated => 'Адрес обновлён';

  @override
  String get profileDeleteAddress => 'Удалить адрес';

  @override
  String get profileAddressDeleted => 'Адрес удалён';

  @override
  String profileSaveInvoiceFailed(String error) {
    return 'Не удалось сохранить счёт: $error';
  }

  @override
  String get profileMyInvoices => 'Мои счета';

  @override
  String get profileAddInvoice => 'Добавить счёт';

  @override
  String get profileInvoiceAdded => 'Счёт добавлен';

  @override
  String get profileInvoiceUpdated => 'Счёт обновлён';

  @override
  String get profileDeleteInvoice => 'Удалить счёт';

  @override
  String get profileInvoiceDeleted => 'Счёт удалён';

  @override
  String get profilePersonal => 'Личный';

  @override
  String get groupSelectAtLeastOne =>
      'Пожалуйста, выберите хотя бы одного участника';

  @override
  String get chatFileNotExist => 'Файл не существует';

  @override
  String chatSendFailed(String error) {
    return 'Ошибка отправки: $error';
  }

  @override
  String get chatCannotOpenBrowser => 'Не удаётся открыть браузер';

  @override
  String chatSelectFileFailed(String error) {
    return 'Не удалось выбрать файл: $error';
  }

  @override
  String settingsSetupFailed(String error) {
    return 'Ошибка настройки: $error';
  }

  @override
  String get transferEnterValidAmount =>
      'Пожалуйста, введите действительную сумму';

  @override
  String get commonAddressCopied => 'Адрес скопирован';

  @override
  String favoriteOpenItem(String content) {
    return 'Открыть: $content';
  }

  @override
  String get favoriteDeleted => 'Удалено';

  @override
  String get profileWallet => 'Кошелёк';

  @override
  String get chatRecording => 'Запись';

  @override
  String get chatInvalidVideoUrl => 'Недействительный URL видео';

  @override
  String get chatDownloadFile => 'Скачать файл';

  @override
  String get chatClearChatHistoryTitle => 'Очистить историю чата';

  @override
  String get chatVideoCall => 'Видеовызов';

  @override
  String get commonVoiceCall => 'Голосовой вызов';

  @override
  String get callLeaveMeeting => 'Покинуть конференцию';

  @override
  String get chatDetails => 'Детали чата';

  @override
  String get chatViewAllGroupMembers => 'Просмотреть всех участников';

  @override
  String get chatGroupName => 'Название группы';

  @override
  String get chatGroupNameUpdated => 'Название группы обновлено';

  @override
  String get chatUpdateFailed => 'Ошибка обновления';

  @override
  String get chatNoPermissionToModify => 'У вас нет прав на изменение';

  @override
  String get chatGroupManagement => 'Управление группой';

  @override
  String get chatMyNicknameInGroup => 'Мой никнейм в группе';

  @override
  String get chatPinChat => 'Закрепить чат';

  @override
  String get chatStrongReminder => 'Важное напоминание';

  @override
  String get chatSetChatBackground => 'Установить фон чата';

  @override
  String get chatUnknownFile => 'Неизвестный файл';

  @override
  String get chatDownload => 'Скачать';

  @override
  String get chatInvalidLocation => 'Недействительное местоположение';

  @override
  String get chatTapToCancel => 'Нажмите для отмены';

  @override
  String chatCaptureFailed(Object error) {
    return 'Ошибка захвата: $error';
  }

  @override
  String get chatProcessingVideo => 'Обработка видео...';

  @override
  String get chatVideoFileNotExist => 'Видеофайл не существует';

  @override
  String get chatVideoDataEmpty => 'Данные видео пусты';

  @override
  String get chatVideoTooLarge => 'Размер видео не может превышать 100 МБ';

  @override
  String get chatSendingVideo => 'Отправка видео...';

  @override
  String chatSendVideoFailed(Object error) {
    return 'Не удалось отправить видео: $error';
  }

  @override
  String get chatImageFileNotExist => 'Файл изображения не существует';

  @override
  String get commonImageDataEmpty => 'Данные изображения пусты';

  @override
  String get chatSendingImage => 'Отправка изображения...';

  @override
  String chatSendImageFailed(Object error) {
    return 'Не удалось отправить изображение: $error';
  }

  @override
  String get chatSendLocation => 'Отправить местоположение';

  @override
  String get chatSelectLocationAndSend => 'Выберите местоположение и отправьте';

  @override
  String get chatShareRealTimeLocation =>
      'Поделиться местоположением в реальном времени';

  @override
  String get chatShareLocationForOneHour =>
      'Поделиться местоположением с другом на 1 час';

  @override
  String get chatLocationSent => 'Местоположение отправлено';

  @override
  String get chatSelectMessages => 'Выбрать сообщения';

  @override
  String chatSelectedCount(int count) {
    return 'Выбрано $count';
  }

  @override
  String get chatSelectAll => 'Выбрать все';

  @override
  String chatGroupChatCount(int count) {
    return 'Групповой чат ($count)';
  }

  @override
  String get chatPrivateChat => 'Личный чат';

  @override
  String get chatNoMessages => 'Нет сообщений';

  @override
  String get chatSendFirstMessage =>
      'Отправьте первое сообщение, чтобы начать общение';

  @override
  String get chatEncryptionNotice =>
      'Этот чат защищён сквозным шифрованием. Только вы и получатель можете читать сообщения.';

  @override
  String get chatMultiForward => 'Переслать';

  @override
  String get chatCollect => 'Собрать';

  @override
  String get chatNoMembers => 'Нет участников';

  @override
  String get chatMemberNotFound => 'Участник не найден';

  @override
  String get chatVoiceFileNotExist => 'Голосовой файл не существует';

  @override
  String get chatVoiceFileEmpty => 'Голосовой файл пуст';

  @override
  String get chatSendingVoice => 'Отправка голосового сообщения...';

  @override
  String chatSendVoiceFailed(Object error) {
    return 'Не удалось отправить голосовое сообщение: $error';
  }

  @override
  String get chatMessageForwarded => 'Сообщение переслано';

  @override
  String chatForwardFailed(Object error) {
    return 'Ошибка пересылки: $error';
  }

  @override
  String get chatUnfavorited => 'Удалено из избранного';

  @override
  String get chatFavorited => 'Добавлено в избранное';

  @override
  String get chatReactionAdded => 'Реакция добавлена';

  @override
  String get chatReactionRemoved => 'Реакция удалена';

  @override
  String get chatFailedMessageDeleted => 'Неотправленное сообщение удалено';

  @override
  String get chatDeleteMessages => 'Удалить сообщения';

  @override
  String chatDeleteMessagesConfirm(Object count) {
    return 'Вы уверены, что хотите удалить $count сообщений?';
  }

  @override
  String chatNoteOtherMessages(Object count) {
    return 'Примечание: $count сообщений от других и будут удалены только для вас.';
  }

  @override
  String chatMyMessagesWillBeRecalled(Object count) {
    return '$count ваших сообщений будут отозваны для всех.';
  }

  @override
  String chatRecalledCount(Object count, Object localCount) {
    return 'Отозвано $count сообщений, $localCount удалено только для вас';
  }

  @override
  String chatRecalledMessages(Object count) {
    return 'Отозвано $count сообщений';
  }

  @override
  String chatDeletedLocally(Object count) {
    return '$count сообщений удалено только для вас';
  }

  @override
  String chatForwardedCount(Object count) {
    return 'Переслано $count сообщений';
  }

  @override
  String chatForwardComplete(Object failed, Object success) {
    return 'Пересылка завершена: $success успешно, $failed ошибок';
  }

  @override
  String get chatRemindOnlyInGroup =>
      'Функция напоминания доступна только в групповом чате';

  @override
  String get chatOnlyTextSearchable =>
      'Поиск доступен только для текстовых сообщений';

  @override
  String chatSearchFor(Object text) {
    return 'Искать \"$text\"';
  }

  @override
  String get chatBaiduSearch => 'Поиск Baidu';

  @override
  String get chatGoogleSearch => 'Поиск Google';

  @override
  String get chatBingSearch => 'Поиск Bing';

  @override
  String get chatCalling => 'Вызов...';

  @override
  String get chatRinging => 'Звонок...';

  @override
  String get chatInCall => 'В разговоре';

  @override
  String commonFeatureInDevelopment(String feature) {
    return 'Функция в разработке...';
  }

  @override
  String chatCollectMessages(Object count) {
    return 'Сохранено $count сообщений';
  }

  @override
  String commonMemberCount(int count) {
    return '$count участников';
  }

  @override
  String groupDone(int count) {
    return 'Готово($count)';
  }

  @override
  String get profileServices => 'Сервисы';

  @override
  String get commonFavorites => 'Избранное';

  @override
  String get profileOrdersAndCards => 'Заказы и карты';

  @override
  String get profileStickers => 'Стикеры';

  @override
  String profileStatusSetTo(String status) {
    return 'Статус установлен: $status';
  }

  @override
  String get profileAvatarUploadFailed => 'Не удалось загрузить аватар';

  @override
  String get profilePersonalProfile => 'Личный профиль';

  @override
  String get profileName => 'Имя';

  @override
  String get profileGender => 'Пол';

  @override
  String get profileRegion => 'Регион';

  @override
  String get commonMyQrCode => 'Мой QR-код';

  @override
  String get profilePoke => 'Толкнуть';

  @override
  String get profileRingtone => 'Рингтон';

  @override
  String get profileDefaultRingtone => 'Рингтон по умолчанию';

  @override
  String get profileMyAddresses => 'Мои адреса';

  @override
  String profileGenderSetTo(String gender) {
    return 'Пол установлен: $gender';
  }

  @override
  String get profileSelectRegion => 'Выбрать регион';

  @override
  String get profileSelectCity => 'Выбрать город';

  @override
  String profileRegionSetTo(String region) {
    return 'Регион установлен: $region';
  }

  @override
  String get profileSetPoke => 'Настроить толчок';

  @override
  String get profileFriendPokedMe => 'Друг толкнул меня';

  @override
  String get profileExample => 'Пример';

  @override
  String get profileOnTheShoulder => ' по плечу';

  @override
  String get profilePokeCleared => 'Толчок сброшен';

  @override
  String profilePokeSetTo(String suffix) {
    return 'Толчок установлен: толкнул меня$suffix';
  }

  @override
  String get profileEditSignature => 'Редактировать подпись';

  @override
  String get profileIntroduceYourself => 'Предложение, чтобы представить себя';

  @override
  String get profileSignatureCleared => 'Подпись удалена';

  @override
  String get profileSignatureUpdated => 'Подпись обновлена';

  @override
  String get profileScanToAddFriend =>
      'Отсканируйте QR-код выше, чтобы добавить меня в друзья';

  @override
  String profileRingtoneSetTo(String ringtone) {
    return 'Рингтон установлен: $ringtone';
  }

  @override
  String commonConfirmDissolveGroup(String name) {
    return 'Вы уверены, что хотите расформировать «$name»? Это действие нельзя отменить.';
  }

  @override
  String get authEnterValidServerAddress =>
      'Пожалуйста, введите действительный адрес сервера';

  @override
  String get authEmailOtp => 'Код подтверждения по email';

  @override
  String get authEnterServerAddressFirst => 'Сначала введите адрес сервера';

  @override
  String get authPasskeyRequiresServer =>
      'Для входа через Passkey требуется поддержка сервера';

  @override
  String get authLoginAgreement => 'Входя в систему, вы соглашаетесь с ';

  @override
  String get authPleaseAgreeToTerms =>
      'Пожалуйста, прочитайте и согласитесь с Условиями использования и Политикой конфиденциальности';

  @override
  String get authRegisterFailed => 'Ошибка регистрации';

  @override
  String get commonReenterPassword => 'Введите пароль повторно';

  @override
  String get commonPasswordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get authInviteCodeBuiltIn => 'Код приглашения (встроенный)';

  @override
  String get authInviteCodeBuiltInNote =>
      'Код приглашения встроен, обычно изменять не требуется';

  @override
  String get authIHaveReadAndAgree => 'Я прочитал и согласен с ';

  @override
  String get mainStartGroupChat => 'Создать групповой чат';

  @override
  String get mainAddFriends => 'Добавить друзей';

  @override
  String get mainPaymentAndCollection => 'Оплата';

  @override
  String contactCount(int count) {
    return '$count контактов';
  }

  @override
  String get contactAddToHomeScreen => 'Добавить на главный экран';

  @override
  String contactRecommendedCardTo(String contact, String recipient) {
    return 'Рекомендовано карточка $contact для $recipient';
  }

  @override
  String get contactEnterRemarkName => 'Введите имя заметки';

  @override
  String contactRemarkSetTo(String remark) {
    return 'Заметка установлена: $remark';
  }

  @override
  String contactAcceptedFriendRequest(String name) {
    return 'Принят запрос в друзья от $name';
  }

  @override
  String contactRejectedFriendRequest(String name) {
    return 'Отклонён запрос в друзья от $name';
  }

  @override
  String get commonGroupInvites => 'Приглашения в группы';

  @override
  String commonMyGroups(int count) {
    return 'Мои группы ($count)';
  }

  @override
  String get commonInvitedToJoinGroup => 'Приглашён в группу';

  @override
  String commonConfirmLeaveGroup(String name) {
    return 'Вы уверены, что хотите покинуть «$name»?';
  }

  @override
  String get commonLeave => 'Покинуть';

  @override
  String get commonRecallThisMessage => 'Отозвать это сообщение?';

  @override
  String get commonSavedToGallery => 'Сохранено в галерею';

  @override
  String get commonFailedToSave => 'Ошибка сохранения';

  @override
  String get chatSaving => 'Сохранение...';

  @override
  String get commonShare => 'Поделиться';

  @override
  String get chatSaveToGallery => 'Сохранить в галерею';

  @override
  String chatDownloadFailed(String code) {
    return 'Ошибка загрузки: $code';
  }

  @override
  String commonShareFailed(String error) {
    return 'Ошибка при отправке: $error';
  }

  @override
  String get chatFailedToLoadImage => 'Не удалось загрузить изображение';

  @override
  String get chatVideoRecordingFailed =>
      'Ошибка записи видео. Пожалуйста, попробуйте снова.';

  @override
  String get profileRedPacket => 'Красный конверт';

  @override
  String get commonMusic => 'Музыка';

  @override
  String get commonCoupon => 'Купон';

  @override
  String get commonGift => 'Подарок';

  @override
  String get commonPoll => 'Опрос';

  @override
  String get favoriteText => 'Текст';

  @override
  String get favoriteLinkLabel => 'Ссылка';

  @override
  String get favoriteNote => 'Заметка';

  @override
  String get favoriteMyNotes => 'Мои заметки';

  @override
  String get favoriteToday => 'Сегодня';

  @override
  String favoriteDaysAgoText(int count) {
    return '$count дней назад';
  }

  @override
  String favoriteDateFormat(int month, int day) {
    return '$day.$month';
  }

  @override
  String get favoriteNoFavorites => 'Пока нет избранного';

  @override
  String get favoriteLongPressToFavorite =>
      'Нажмите и удерживайте сообщение, чтобы добавить в избранное';

  @override
  String get favoriteNewNote => 'Новая заметка';

  @override
  String get favoriteLink => 'Добавить ссылку в избранное';

  @override
  String get favoriteEditTags => 'Редактировать теги';

  @override
  String get favoriteDeleteFavorite => 'Удалить из избранного';

  @override
  String get favoriteDeleteFavoriteConfirm =>
      'Вы уверены, что хотите удалить это из избранного?';

  @override
  String get favoriteNoSearchResultsFound => 'Результаты не найдены';

  @override
  String get commonSendRedPacket => 'Отправить красный конверт';

  @override
  String get transferAmount => 'Сумма';

  @override
  String get commonRedPacketCover => 'Обложка красного конверта';

  @override
  String get commonRedPacketType => 'Тип красного конверта';

  @override
  String get commonNormalRedPacket => 'Обычный';

  @override
  String get commonLuckyRedPacket => 'Счастливый';

  @override
  String get commonRedPacketCount => 'Количество конвертов';

  @override
  String get commonPieces => 'штук';

  @override
  String get commonPutMoneyInRedPacket => 'Положить деньги в красный конверт';

  @override
  String get commonRedPacketRefundNotice =>
      'Неполученные красные конверты будут возвращены через 24 часа';

  @override
  String get commonOpenRedPacket => 'Открыть';

  @override
  String get commonRedPacketAllClaimed => 'Все красные конверты получены';

  @override
  String get commonRedPacketExpired => 'Красный конверт истёк';

  @override
  String get commonAddTransferNote => 'Добавить примечание к переводу';

  @override
  String get commonYuan => 'руб.';

  @override
  String get commonReplyWithEmoji => 'Ответить этим эмодзи';

  @override
  String get contactEditRemark => 'Редактировать заметку';

  @override
  String get contactSetPermissions => 'Установить разрешения';

  @override
  String get profileAddToBlacklist => 'Добавить в чёрный список';

  @override
  String get contactDeleteContact => 'Удалить контакт';

  @override
  String contactDeleteContactConfirm(String name) {
    return 'Вы уверены, что хотите удалить $name?';
  }

  @override
  String get transferTitle => 'Перевод';

  @override
  String get transferReceiverAddressLabel => 'Адрес получателя';

  @override
  String get transferSelectTokenLabel => 'Выбрать токен';

  @override
  String get transferAmountLabel => 'Сумма перевода';

  @override
  String get transferMemoLabel => 'Примечание (необязательно)';

  @override
  String get transferAddMemoHint => 'Добавить примечание';

  @override
  String get transferSendPaymentRequest => 'Отправить запрос на оплату';

  @override
  String get transferQrCodeGenerateFailed => 'Ошибка генерации QR-кода';

  @override
  String get transferScanQrToPayMe => 'Отсканируйте QR-код, чтобы оплатить мне';

  @override
  String get transferMyWalletAddress => 'Адрес моего кошелька';

  @override
  String get transferCreatePaymentRequest => 'Создать запрос на оплату';

  @override
  String profileN42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get commonRedPacketDefaultGreeting => 'С наилучшими пожеланиями';

  @override
  String commonSenderRedPacket(String name) {
    return 'Красный конверт от $name';
  }

  @override
  String get transferEnterValidAddress =>
      'Пожалуйста, введите действительный адрес';

  @override
  String get transferPleaseSelectToken => 'Пожалуйста, выберите токен';

  @override
  String get commonReceivedTransfer => 'Полученный перевод';

  @override
  String commonSenderSentRedPacket(String name) {
    return '$name отправил(а) красный конверт';
  }

  @override
  String get commonSavedToBalance =>
      'Сохранено на баланс, можно переводить напрямую';

  @override
  String get commonRedPacketExpiredOrEmpty =>
      'Красный конверт истёк/все получены';

  @override
  String get transferScanFeatureComingSoon =>
      'Функция сканирования скоро появится...';

  @override
  String get contactSetAsStarred => 'Отметить как важного';

  @override
  String get contactAddToBlocklist => 'Добавить в чёрный список';

  @override
  String get commonClaimedYour => ' получил(а) ваш ';

  @override
  String get commonClaimedText => ' получил(а) ';

  @override
  String commonUserTyping(String name) {
    return '$name печатает...';
  }

  @override
  String get commonTyping => 'Печатает...';

  @override
  String get commonWaitingToReceive => 'Ожидание получения';

  @override
  String get commonTapToClaim => 'Нажмите, чтобы получить';

  @override
  String get commonHasBeenReceived => 'Получено';

  @override
  String get commonGetLucky => 'Удачи';

  @override
  String get qrcodeCameraStartFailed => 'Не удалось запустить камеру';

  @override
  String get qrcodeUnknownError => 'Неизвестная ошибка';

  @override
  String get qrcodePlaceQrCodeInFrame =>
      'Поместите QR-код в рамку для сканирования';

  @override
  String get qrcodeCloseManualInput => 'Закрыть ручной ввод';

  @override
  String get qrcodeManualInputUserId => 'Ввести ID пользователя вручную';

  @override
  String get commonAdd => 'Добавить';

  @override
  String get profileSetStatus => 'Установить статус';

  @override
  String get profileVisibleToFriends24h => 'Виден друзьям в течение 24 часов';

  @override
  String get profileWriteStatus => 'Написать статус';

  @override
  String get profileEnterYourStatus => 'Введите ваш статус...';

  @override
  String get profileOk => 'ОК';

  @override
  String get qrcodeCameraPermissionRequired =>
      'Для сканирования QR-кода требуется разрешение камеры';

  @override
  String get qrcodeCameraPermissionDenied =>
      'Разрешение камеры отклонено навсегда. Пожалуйста, включите его в настройках системы.';

  @override
  String qrcodePermissionCheckError(String error) {
    return 'Ошибка проверки разрешения: $error';
  }

  @override
  String get qrcodeInvalidQrCode => 'Недействительный QR-код';

  @override
  String qrcodeCannotAddFriend(String error) {
    return 'Не удаётся добавить друга: $error';
  }

  @override
  String get qrcodeScanQrCode => 'Сканировать QR-код';

  @override
  String get qrcodeCheckingCameraPermission => 'Проверка разрешения камеры...';

  @override
  String get qrcodeNeedCameraPermission => 'Требуется разрешение камеры';

  @override
  String get qrcodeRetryPermission => 'Повторить';

  @override
  String get qrcodeOpenSettings => 'Открыть настройки';

  @override
  String get groupInviteMembers => 'Пригласить участников';

  @override
  String groupInviteCount(int count) {
    return 'Пригласить($count)';
  }

  @override
  String get profileNoShippingAddress => 'Нет адреса доставки';

  @override
  String get profileDefaultLabel => 'По умолчанию';

  @override
  String get profileNoInvoice => 'Нет счёта';

  @override
  String get profileCompany => 'Компания';

  @override
  String get profileTaxNumber => 'ИНН';

  @override
  String get profileConfirmDeleteAddress =>
      'Вы уверены, что хотите удалить этот адрес?';

  @override
  String get profileConfirmDeleteInvoice =>
      'Вы уверены, что хотите удалить этот счёт?';

  @override
  String get commonGroupOwner => 'Владелец';

  @override
  String get commonGroupAdmin => 'Администратор';

  @override
  String get groupSearchMembers => 'Поиск участников';

  @override
  String groupTotalMembers(int count) {
    return '$count участников';
  }

  @override
  String get chatRemoveFromGroup => 'Удалить из группы';

  @override
  String groupConfirmRemoveMember(String name) {
    return 'Вы уверены, что хотите удалить \"$name\" из группы?';
  }

  @override
  String get chatUnknownSong => 'Неизвестная песня';

  @override
  String get chatUnknownArtist => 'Неизвестный исполнитель';

  @override
  String get chatUnknownContact => 'Неизвестный контакт';

  @override
  String get chatPersonalCard => 'Контактная карточка';

  @override
  String get chatSingleChoice => 'Один';

  @override
  String get chatMultiChoice => 'Несколько';

  @override
  String get chatEnded => 'Завершён';

  @override
  String get chatEndPollButton => 'Завершить опрос';

  @override
  String get chatPollHint =>
      'Опрос будет отображён в чате. Участники группы смогут голосовать.';

  @override
  String get chatSearchSongOrArtist => 'Поиск песни или исполнителя';

  @override
  String get chatNoSongsFound => 'Песни не найдены';

  @override
  String get chatSongNameOptional => 'Название песни (необязательно)';

  @override
  String get chatEnterSongName => 'Введите название песни';

  @override
  String get chatArtistNameOptional => 'Исполнитель (необязательно)';

  @override
  String get chatEnterArtistName => 'Введите имя исполнителя';

  @override
  String get chatRealTimeLocationSharing =>
      'Отправка местоположения в реальном времени в разработке...';

  @override
  String get profileVoiceCallFeatureInDev => 'Голосовой вызов в разработке...';

  @override
  String get profileReportFeatureInDev => 'Функция жалобы в разработке...';

  @override
  String get profileShareFeatureInDev => 'Функция отправки в разработке...';

  @override
  String get profileQrCodeFeatureInDev => 'Функция QR-кода в разработке...';

  @override
  String get qrcodeScanQrToAddMe =>
      'Отсканируйте QR-код выше, чтобы добавить меня в друзья';

  @override
  String get qrcodeSaveToAlbum => 'Сохранить в альбом';

  @override
  String get qrcodeChangeStyle => 'Изменить стиль';

  @override
  String get qrcodeCopyId => 'Копировать ID';

  @override
  String get qrcodeIdCopied => 'ID скопирован';

  @override
  String get qrcodeMoreStylesFeatureComingSoon =>
      'Больше стилей скоро появится';

  @override
  String get profileBio => 'О себе';

  @override
  String get profileHomeServer => 'Сервер';

  @override
  String get profileShareContactCard => 'Поделиться контактной карточкой';

  @override
  String get profileRemoveFromBlacklist => 'Удалить из чёрного списка';

  @override
  String get profileConfirmAddBlacklist =>
      'Вы уверены, что хотите добавить этого пользователя в чёрный список? Вы не будете получать от него сообщения.';

  @override
  String get profileConfirmRemoveBlacklist =>
      'Вы уверены, что хотите удалить этого пользователя из чёрного списка?';

  @override
  String get profileRemarkSaved => 'Заметка сохранена';

  @override
  String get profileRemarkCleared => 'Заметка удалена';

  @override
  String get transferReceive => 'Получить';

  @override
  String get transferPleaseConnectWallet => 'Сначала подключите ваш кошелёк';

  @override
  String get transferSendRequest => 'Отправить запрос';

  @override
  String get transferPleaseEnterValidAmount =>
      'Пожалуйста, введите действительную сумму';

  @override
  String get searchPlaceholder => 'Поиск контактов, групп, сообщений';

  @override
  String get searchEnterKeywordToSearch => 'Введите ключевое слово для поиска';

  @override
  String get searchClearHistory => 'Очистить';

  @override
  String searchNoResultsForQuery(String query) {
    return 'Результаты не найдены для \"$query\"';
  }

  @override
  String get searchAllResults => 'Все';

  @override
  String get searchInChat => 'Поиск в чате';

  @override
  String get searchContactLabel => 'Контакт';

  @override
  String get searchGroupLabel => 'Группа';

  @override
  String get searchConversationLabel => 'Беседа';

  @override
  String get searchMessageLabel => 'Сообщение';

  @override
  String get settingsSecurityTitle => 'Безопасность';

  @override
  String get settingsKeyBackup => 'Резервное копирование ключей';

  @override
  String get settingsBackupEncryptionKeys =>
      'Резервное копирование ключей шифрования';

  @override
  String settingsKeysBackedUp(int count) {
    return '$count ключей сохранено';
  }

  @override
  String get settingsBackupNotSet => 'Резервная копия не настроена';

  @override
  String get settingsRestoreKeys => 'Восстановить ключи';

  @override
  String get settingsRestoreKeysFromBackup =>
      'Восстановить ключи шифрования из резервной копии';

  @override
  String get settingsExportKeys => 'Экспортировать ключи';

  @override
  String get settingsExportKeysToFile => 'Экспортировать ключи в файл';

  @override
  String get settingsLoggedInDevices => 'Авторизованные устройства';

  @override
  String get settingsNoOtherDevices => 'Нет других устройств';

  @override
  String get settingsVerified => 'Подтверждено';

  @override
  String get settingsUnverified => 'Не подтверждено';

  @override
  String get settingsAdvanced => 'Дополнительно';

  @override
  String get settingsCrossSigning => 'Кросс-подпись';

  @override
  String get settingsEnabled => 'Включено';

  @override
  String get settingsNotEnabled => 'Не включено';

  @override
  String get settingsResetEncryption => 'Сбросить шифрование';

  @override
  String get settingsDeleteAllEncryptionKeys => 'Удалить все ключи шифрования';

  @override
  String get settingsEncryptionNotSupported => 'Шифрование не поддерживается';

  @override
  String get settingsNotInitialized => 'Не инициализировано';

  @override
  String get settingsBackupKeyTitle => 'Резервное копирование ключей';

  @override
  String get settingsBackupKeyMessage =>
      'Создать новую резервную копию ключей? Это поможет восстановить зашифрованные сообщения на новом устройстве.';

  @override
  String get settingsBackup => 'Сохранить';

  @override
  String get settingsRestoreKeyTitle => 'Восстановить ключи';

  @override
  String get settingsRestoreKeyMessage =>
      'Введите пароль восстановления или ключ восстановления для восстановления зашифрованных сообщений.';

  @override
  String get settingsRestore => 'Восстановить';

  @override
  String get settingsExportKeyTitle => 'Экспортировать ключи';

  @override
  String get settingsExportKeyMessage =>
      'Экспортируемый файл ключей содержит все ваши ключи шифрования. Пожалуйста, храните его в безопасном месте.';

  @override
  String get settingsExport => 'Экспорт';

  @override
  String settingsDeviceIdLabel(String deviceId) {
    return 'ID устройства: $deviceId';
  }

  @override
  String get settingsDeviceStatusVerified => 'Статус: Подтверждено';

  @override
  String get settingsDeviceStatusUnverified => 'Статус: Не подтверждено';

  @override
  String settingsLastActiveLabel(String lastSeen) {
    return 'Последняя активность: $lastSeen';
  }

  @override
  String get settingsVerifyThisDevice => 'Подтвердить это устройство';

  @override
  String get settingsCrossSigningAlreadyEnabled => 'Кросс-подпись уже включена';

  @override
  String get settingsCrossSigningSetupSuccess =>
      'Кросс-подпись успешно настроена';

  @override
  String get settingsResetEncryptionTitle => 'Сбросить шифрование';

  @override
  String get settingsResetEncryptionWarning =>
      'Внимание: Это удалит все ваши ключи шифрования. Вы не сможете расшифровать ранее зашифрованные сообщения. Это действие нельзя отменить.';

  @override
  String get settingsReset => 'Сбросить';

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
  String get callLeaveMeetingConfirm =>
      'Вы уверены, что хотите покинуть конференцию?';

  @override
  String chatPokedSomeone(String name, String suffix) {
    return 'толкнул $name$suffix';
  }

  @override
  String get chatNoContactsToAdd => 'Нет доступных контактов для добавления';

  @override
  String get chatAddMembers => 'Добавить участников';

  @override
  String chatInvitedMembers(int count) {
    return 'Приглашено $count участников';
  }

  @override
  String chatInviteFailed(String error) {
    return 'Ошибка приглашения: $error';
  }

  @override
  String get chatMemberRemoved => 'Участник удалён';

  @override
  String chatRemoveFailed(String error) {
    return 'Ошибка удаления: $error';
  }

  @override
  String get chatRealTimeLocationShareMessage =>
      'После отправки другая сторона сможет видеть ваше местоположение в течение 1 часа.';

  @override
  String get chatStartSharing => 'Начать отправку';

  @override
  String get chatLocationServiceNotEnabled => 'Служба геолокации не включена';

  @override
  String get chatEnableLocationService =>
      'Пожалуйста, включите службу геолокации для использования этой функции';

  @override
  String get chatGoToSettings => 'Перейти в настройки';

  @override
  String get chatLocationPermissionRequired =>
      'Для этой функции требуется разрешение на определение местоположения';

  @override
  String get chatLocationPermissionDeniedPermanent =>
      'Разрешение на определение местоположения отклонено навсегда. Пожалуйста, включите его в настройках.';

  @override
  String get chatLocationPermissionDenied =>
      'Разрешение на определение местоположения отклонено';

  @override
  String get chatGettingLocation => 'Получение местоположения...';

  @override
  String chatGetLocationFailed(String error) {
    return 'Не удалось получить местоположение: $error';
  }

  @override
  String get chatMapPreview => 'Предпросмотр карты';

  @override
  String get chatSearchLocation => 'Поиск местоположения';

  @override
  String chatRedPacketSent(String amount, String token) {
    return 'Отправлен красный конверт на $amount $token';
  }

  @override
  String get chatTransferDefault => 'Перевод';

  @override
  String chatTransferSent(String amount, String token) {
    return 'Отправлен перевод на $amount $token';
  }

  @override
  String chatPickFileFailed(String error) {
    return 'Не удалось выбрать файл: $error';
  }

  @override
  String get chatFileSizeLimit => 'Размер файла не может превышать 50 МБ';

  @override
  String chatFileSending(String filename) {
    return 'Отправка файла: $filename';
  }

  @override
  String chatSendFileFailed(String error) {
    return 'Не удалось отправить файл: $error';
  }

  @override
  String chatContactCardSent(String name) {
    return 'Отправлена контактная карточка $name';
  }

  @override
  String get chatFavoritesFeature => 'Избранное';

  @override
  String get chatCouponsFeature => 'Купоны';

  @override
  String get chatGiftFeature => 'Подарок';

  @override
  String chatSharedMusic(String name) {
    return 'Поделился $name';
  }

  @override
  String get chatEndPollTitle => 'Завершить опрос';

  @override
  String get chatEndPollConfirmMessage =>
      'Вы уверены, что хотите завершить этот опрос? После завершения голосование будет закрыто.';

  @override
  String get chatPollEndedMessage => 'Опрос завершён';

  @override
  String get chatConnectingCall => 'Подключение...';

  @override
  String get chatMuteCall => 'Без звука';

  @override
  String get chatSpeakerOff => 'Динамик выкл';

  @override
  String get chatSpeakerOn => 'Динамик';

  @override
  String get chatCameraOn => 'Камера вкл';

  @override
  String get chatCameraOff => 'Камера выкл';

  @override
  String get chatHangUp => 'Завершить';

  @override
  String get chatSelectForwardTargetTitle => 'Выбрать получателя';

  @override
  String get chatNoForwardableChat => 'Нет доступных чатов для пересылки';

  @override
  String get chatNoMatchingChat => 'Подходящие чаты не найдены';

  @override
  String get chatLocationTitle => 'Местоположение';

  @override
  String get chatSendButton => 'Отправить';

  @override
  String get chatRetryButton => 'Повторить';

  @override
  String get chatSearchContactHint => 'Поиск контактов';

  @override
  String get chatShareMusic => 'Поделиться музыкой';

  @override
  String get chatRecentPlayed => 'Недавние';

  @override
  String get chatMyFavorites => 'Избранное';

  @override
  String get chatNetworkLink => 'Ссылка';

  @override
  String get chatLocalFile => 'Локальный';

  @override
  String get chatPasteMusicLink => 'Вставьте ссылку на музыку';

  @override
  String get chatShareMusicButton => 'Поделиться музыкой';

  @override
  String get chatSelectLocalAudio => 'Выбрать локальный аудиофайл';

  @override
  String get chatSupportedAudioFormats =>
      'Поддерживаются MP3, M4A, WAV, FLAC и др.';

  @override
  String get chatSelectFileButton => 'Выбрать файл';

  @override
  String get chatPleaseEnterMusicLink => 'Пожалуйста, введите ссылку на музыку';

  @override
  String get chatPleaseEnterValidLink =>
      'Пожалуйста, введите действительный URL';

  @override
  String get chatSharedSong => 'Поделился песней';

  @override
  String get chatSelectMember => 'Выбрать участника';

  @override
  String get chatSearchMemberHint => 'Поиск участников';

  @override
  String get chatNoMatchingMembers => 'Подходящие участники не найдены';

  @override
  String get commonUnknownMember => 'Неизвестно';

  @override
  String chatSelectedMessagesCount(int count) {
    return 'Выбрано $count сообщений';
  }

  @override
  String get chatSearchContactsOrGroups => 'Поиск контактов или групп';

  @override
  String get chatVideoTitle => 'Видео';

  @override
  String get chatLoadingText => 'Загрузка...';

  @override
  String get chatVideoLoadFailed => 'Ошибка загрузки видео';

  @override
  String get chatPlayerInitFailed => 'Ошибка инициализации плеера';

  @override
  String get chatCreatePollTitle => 'Создать опрос';

  @override
  String get chatSubmitPoll => 'Отправить';

  @override
  String get chatPollQuestionLabel => 'Вопрос опроса';

  @override
  String get chatEnterPollQuestionHint => 'Пожалуйста, введите вопрос опроса';

  @override
  String get chatPollOptionsLabel => 'Варианты ответа';

  @override
  String chatOptionHintWithIndex(int index) {
    return 'Вариант $index';
  }

  @override
  String get chatAddOptionButton => 'Добавить вариант';

  @override
  String get chatPollSettingsLabel => 'Настройки опроса';

  @override
  String get chatSelectionType => 'Тип выбора';

  @override
  String get chatSingleChoiceLabel => 'Один';

  @override
  String get chatMultiChoiceLabel => 'Несколько';

  @override
  String get chatAnonymousPollSwitch => 'Анонимный опрос';

  @override
  String get chatPleaseEnterQuestion => 'Пожалуйста, введите вопрос опроса';

  @override
  String get chatAtLeastTwoOptions => 'Требуется минимум 2 варианта';

  @override
  String chatConfirmWithCount(int count) {
    return 'Подтвердить ($count)';
  }

  @override
  String get authEmailVerificationTitle => 'Подтверждение email';

  @override
  String get authEnterValidEmailAddress =>
      'Пожалуйста, введите действительный email адрес';

  @override
  String authVerificationCodeSentTo(String email) {
    return 'Код подтверждения отправлен на $email';
  }

  @override
  String authSendCodeFailed(String error) {
    return 'Не удалось отправить код: $error';
  }

  @override
  String get authVerificationSuccess => 'Проверка успешна';

  @override
  String get authVerificationFailed => 'Проверка не удалась';

  @override
  String authVerificationCodeError(String error) {
    return 'Ошибка кода подтверждения: $error';
  }

  @override
  String get commonEnterVerificationCode => 'Введите код подтверждения';

  @override
  String get authEnterYourEmail => 'Введите email';

  @override
  String authWeSentCodeTo(String email) {
    return 'Мы отправили 6-значный код на\n$email';
  }

  @override
  String get authEnterEmailForCode =>
      'Введите ваш email адрес, мы отправим код подтверждения';

  @override
  String get commonSendVerificationCode => 'Отправить код подтверждения';

  @override
  String get authResendVerificationCode => 'Отправить код повторно';

  @override
  String authCanResendAfter(int seconds) {
    return 'Повторная отправка через $seconds секунд';
  }

  @override
  String get commonChangeEmail => 'Изменить email';

  @override
  String get contactAddToContacts => 'Добавить в контакты';

  @override
  String get contactAddingToContacts => 'Добавление...';

  @override
  String get contactAddedToContacts => 'Добавлено в контакты';

  @override
  String contactAddFailedWithError(String error) {
    return 'Ошибка добавления: $error';
  }

  @override
  String get contactAddPhone => 'Добавить телефон';

  @override
  String get contactAddTag => 'Добавить теги';

  @override
  String get contactAddText => 'Добавить текст';

  @override
  String get contactAddPhoto => 'Добавить фото';

  @override
  String contactGroupCountLabel(int count) {
    return '$count групп';
  }

  @override
  String get contactAddedViaSearch => 'Добавлен через поиск';

  @override
  String get contactAddTime => 'Добавить время';

  @override
  String get contactDoneButton => 'Готово';

  @override
  String get callWaitingForParticipants =>
      'Ожидание присоединения участников...';

  @override
  String callParticipantMe(String name) {
    return '$name (Я)';
  }

  @override
  String get callSharingLabel => 'Отправка';

  @override
  String callScreenSharingBy(String name) {
    return '$name делится экраном';
  }

  @override
  String callParticipantCount(int count) {
    return '$count участников';
  }

  @override
  String get callMuteLabel => 'Без звука';

  @override
  String get callUnmuteLabel => 'Со звуком';

  @override
  String get callTurnOffVideo => 'Выключить видео';

  @override
  String get callTurnOnVideo => 'Включить видео';

  @override
  String get callShareScreen => 'Поделиться экраном';

  @override
  String get callStopSharing => 'Прекратить отправку';

  @override
  String get callSwitchCameraLabel => 'Переключить';

  @override
  String get callLeaveLabel => 'Покинуть';

  @override
  String get callParticipantsLabel => 'Участники';

  @override
  String get callJoiningMeeting => 'Присоединение к конференции...';

  @override
  String chatPollVotesFormat(int count, String percentage) {
    return '$count голосов ($percentage%)';
  }

  @override
  String chatPollParticipantsFormat(int count) {
    return '$count участников';
  }

  @override
  String get commonTapToRetry => 'Нажмите, чтобы повторить';

  @override
  String get chatDefaultRedPacketGreeting => 'Желаю процветания и удачи';

  @override
  String get groupAllowOthersToSearchAndJoin =>
      'Разрешить другим пользователям искать и присоединяться';

  @override
  String get groupConfirmClearChatHistory =>
      'Вы уверены, что хотите очистить историю чата?';

  @override
  String get groupCreateGroupToChat => 'Создайте группу, чтобы начать общение';

  @override
  String get groupEditGroupAnnouncement => 'Редактировать объявление группы';

  @override
  String get groupEditGroupDescription => 'Редактировать описание группы';

  @override
  String get groupEnterGroupAnnouncement => 'Введите объявление группы';

  @override
  String chatErrorWithMessage(String message) {
    return 'Ошибка: $message';
  }

  @override
  String groupMemberCountClickToCopy(int count) {
    return '$count участников, нажмите для копирования ID группы';
  }

  @override
  String get chatMusicLinkLabel => 'Ссылка на музыку';

  @override
  String get chatNoMediaUrlAvailable => 'URL медиа недоступен';

  @override
  String get groupNoPermissionToEditGroupName =>
      'У вас нет прав для изменения названия группы';

  @override
  String get chatRedPacketTransferCannotForward =>
      'Красные конверты и переводы нельзя пересылать';

  @override
  String get authEmailAddress => 'Адрес электронной почты';

  @override
  String get commonEnterEmailAddress => 'Введите адрес электронной почты';

  @override
  String get authEmailRecoveryHint => 'Используется для восстановления пароля';

  @override
  String get commonInvalidEmailFormat =>
      'Введите действительный адрес электронной почты';

  @override
  String get authOptional => 'Необязательно';

  @override
  String get authResetPassword => 'Сбросить пароль';

  @override
  String get authEnterRegisteredEmail =>
      'Введите адрес электронной почты, с которым вы зарегистрировались';

  @override
  String get authSendResetCode => 'Отправить код сброса';

  @override
  String authResetCodeSent(String email) {
    return 'Код сброса отправлен на $email';
  }

  @override
  String get authEnterResetCode => 'Введите код сброса';

  @override
  String get authSetNewPassword => 'Установить новый пароль';

  @override
  String get commonConfirmNewPassword => 'Подтвердите новый пароль';

  @override
  String get commonNewPassword => 'Новый пароль';

  @override
  String get authPasswordResetSuccess =>
      'Пароль успешно сброшен. Войдите с новым паролем.';

  @override
  String get authResetPasswordFailed => 'Не удалось сбросить пароль';

  @override
  String get settingsChangePassword => 'Изменить пароль';

  @override
  String get settingsCurrentPassword => 'Текущий пароль';

  @override
  String get settingsEnterCurrentPassword => 'Введите текущий пароль';

  @override
  String get settingsEnterNewPassword => 'Введите новый пароль';

  @override
  String get settingsPasswordChanged =>
      'Пароль успешно изменен. Войдите с новым паролем.';

  @override
  String get settingsChangePasswordFailed => 'Не удалось изменить пароль';

  @override
  String get settingsNewPasswordMustBeDifferent =>
      'Новый пароль должен отличаться от текущего';

  @override
  String get settingsChangePasswordInfo =>
      'После изменения пароля вы будете отключены и должны будете войти с новым паролем.';

  @override
  String get settingsPasswordRequirements => 'Требования к паролю:';

  @override
  String get settingsSecurityNote =>
      'В целях безопасности вам нужно будет войти заново на всех устройствах после изменения пароля.';

  @override
  String get settingsSecurity => 'Безопасность';

  @override
  String get settingsCurrentBoundEmail => 'Текущий привязанный email';

  @override
  String get settingsNewEmailAddress => 'Новый адрес электронной почты';

  @override
  String get settingsEnterNewEmail => 'Введите новый адрес электронной почты';

  @override
  String get settingsVerificationCode => 'Код подтверждения';

  @override
  String get settingsVerificationCodeSent => 'Код подтверждения отправлен';

  @override
  String get settingsCodeSentTo => 'Код подтверждения отправлен на';

  @override
  String get settingsDidNotReceiveCode => 'Не получили код?';

  @override
  String get settingsEmailChangedSuccess => 'Email успешно изменен';

  @override
  String get settingsChangeEmailFailed => 'Не удалось изменить email';

  @override
  String get settingsEmailSecurityNote =>
      'Ваш email используется для восстановления пароля. Храните его в безопасности.';

  @override
  String get commonGoogleLogin => 'Войти через Google';

  @override
  String get commonAppleLogin => 'Войти через Apple';

  @override
  String get commonWechat => 'WeChat';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageChanged => 'Язык изменен';

  @override
  String get settingsBiometricLogin => 'Биометрический вход';

  @override
  String authLoginWithBiometric(Object type) {
    return 'Войти с помощью $type';
  }

  @override
  String get settingsBiometricLoginEnabled => 'Биометрический вход включён';

  @override
  String get settingsBiometricLoginDisabled => 'Биометрический вход отключён';

  @override
  String get settingsEnableBiometricLogin => 'Включить биометрический вход';

  @override
  String get settingsBiometricEnabled => 'Включено — вход по биометрии';

  @override
  String get settingsBiometricDisabled => 'Отключено — нажмите для включения';

  @override
  String get settingsBiometricNeedRelogin =>
      'Выйдите и войдите снова, чтобы включить биометрический вход';

  @override
  String get authOr => 'ИЛИ';

  @override
  String get qrcodeCameraPermissionRestricted =>
      'Доступ к камере ограничен на этом устройстве';

  @override
  String get authPasskeyLabel => 'Passkey';

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
  String get profileEnterPokeSuffixHint =>
      'Введите суффикс тычка, например: в плечо';

  @override
  String get groupAlbum => 'Альбом группы';

  @override
  String get groupFiles => 'Файлы группы';

  @override
  String get groupImages => 'Изображения';

  @override
  String get groupVideos => 'Видео';

  @override
  String get groupTotal => 'Всего';

  @override
  String get groupSize => 'Размер';

  @override
  String get groupNoMedia => 'Нет медиа';

  @override
  String get groupNoMediaDescription => 'В этой группе пока нет фото или видео';

  @override
  String get groupDocuments => 'Документы';

  @override
  String get groupNoFiles => 'Нет файлов';

  @override
  String get groupNoFilesDescription => 'В этой группе пока нет файлов';

  @override
  String groupDownloadStarted(String filename) {
    return 'Загрузка $filename...';
  }

  @override
  String get contactNoCommonGroups => 'Нет общих групп';

  @override
  String get contactNoCommonGroupsDescription => 'У вас нет общих групп';

  @override
  String get chatVoiceMessage => 'Голос';

  @override
  String get chatMessage => 'Сообщение';

  @override
  String get conversationHideChat => 'Скрыть';

  @override
  String get settingsQuickReply => 'Быстрый ответ';

  @override
  String get commonTranslate => 'Перевести';

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
    return 'Разговор: $roomId';
  }

  @override
  String commonContactWithId(String userId) {
    return 'Контакт: $userId';
  }

  @override
  String get commonDiscover => 'Обзор';

  @override
  String commonDeveloping(String title) {
    return '$title\n(Скоро)';
  }

  @override
  String get commonPageNotFound => 'Страница не найдена';

  @override
  String get commonBackToHome => 'На главную';

  @override
  String get settingsMessageNotifications => 'Уведомления о сообщениях';

  @override
  String get settingsReceiveNewMessageNotifications =>
      'Получать уведомления о новых сообщениях';

  @override
  String get settingsShowMessagePreview => 'Показывать предпросмотр сообщения';

  @override
  String get settingsShowMessageContentInNotification =>
      'Показывать содержимое сообщения в уведомлениях';

  @override
  String get settingsNotificationSound => 'Звук уведомления';

  @override
  String get settingsPlaySoundOnMessage =>
      'Воспроизводить звук при получении сообщения';

  @override
  String get commonVibration => 'Вибрация';

  @override
  String get settingsVibrateOnMessage => 'Вибрировать при получении сообщения';

  @override
  String get settingsDoNotDisturbMode => 'Не беспокоить';

  @override
  String get settingsDoNotDisturbDescription =>
      'Не получать уведомления в указанное время';

  @override
  String get settingsStartTime => 'Время начала';

  @override
  String get settingsEndTime => 'Время окончания';

  @override
  String get settingsDeleteQuickReply => 'Удалить быстрый ответ';

  @override
  String get settingsEditQuickReply => 'Редактировать быстрый ответ';

  @override
  String get settingsAddQuickReply => 'Добавить быстрый ответ';

  @override
  String get settingsManageQuickReplies => 'Управление быстрыми ответами';

  @override
  String get settingsNoQuickReplies => 'Нет быстрых ответов';

  @override
  String get settingsDefaultQuickReplies =>
      'Будут показаны быстрые ответы по умолчанию';

  @override
  String get settingsWhoCanSee => 'Кто может видеть';

  @override
  String get settingsLastSeen => 'Последний визит';

  @override
  String get settingsHiddenChats => 'Скрытые чаты';

  @override
  String get settingsMessagesLabel => 'Сообщения';

  @override
  String get settingsAllowStrangerMessages =>
      'Разрешить сообщения от незнакомцев';

  @override
  String get settingsReceiveMessagesFromNonContacts =>
      'Получать сообщения от тех, кого нет в контактах';

  @override
  String get settingsReadReceipts => 'Отчёты о прочтении';

  @override
  String get settingsLetOthersKnowYouRead =>
      'Показывать, что вы прочитали сообщения';

  @override
  String get settingsTypingIndicator => 'Индикатор набора';

  @override
  String get settingsLetOthersKnowYouTyping => 'Показывать, что вы печатаете';

  @override
  String get settingsEveryone => 'Все';

  @override
  String get settingsContactsOnly => 'Только контакты';

  @override
  String get settingsNobody => 'Никто';

  @override
  String settingsWhoCanSeeTitle(String title) {
    return 'Кто может видеть $title';
  }

  @override
  String settingsVersionInfo(String version) {
    return 'Версия $version';
  }

  @override
  String get settingsCheckForUpdates => 'Проверить обновления';

  @override
  String get settingsOpenSourceLicenses => 'Лицензии открытого ПО';

  @override
  String get settingsFeedbackAndSuggestions => 'Отзывы и предложения';

  @override
  String get settingsBuiltOnMatrix => 'На основе протокола Matrix';

  @override
  String get settingsNoHiddenChats => 'Нет скрытых чатов';

  @override
  String get settingsNoHiddenChatsDescription =>
      'Скрытые вами чаты будут отображаться здесь';

  @override
  String get settingsUnhideChat => 'Показать';

  @override
  String get settingsDarkMode => 'Тёмный режим';

  @override
  String get settingsFontSize => 'Размер шрифта';

  @override
  String get settingsBubbleStyle => 'Стиль пузырей';

  @override
  String get settingsFollowSystem => 'Следовать системе';

  @override
  String get settingsAutoSwitchBySystem =>
      'Автоматически переключаться по настройкам системы';

  @override
  String get settingsLightMode => 'Светлый режим';

  @override
  String get settingsAlwaysUseLightTheme => 'Всегда использовать светлую тему';

  @override
  String get settingsDarkModeOption => 'Тёмный режим';

  @override
  String get settingsAlwaysUseDarkTheme => 'Всегда использовать тёмную тему';

  @override
  String get settingsFontSizeSmall => 'Маленький';

  @override
  String get settingsFontSizeStandard => 'Стандартный';

  @override
  String get settingsFontSizeLarge => 'Большой';

  @override
  String get settingsFontSizeExtraLarge => 'Очень большой';

  @override
  String get settingsBubbleStyleWechat => 'Стиль WeChat';

  @override
  String get settingsBubbleStyleWechatDesc =>
      'Классический стиль пузырей WeChat';

  @override
  String get settingsBubbleStyleModern => 'Современный стиль';

  @override
  String get settingsBubbleStyleModernDesc =>
      'Чистый современный стиль пузырей';

  @override
  String get settingsBubbleStyleClassic => 'Классический стиль';

  @override
  String get settingsBubbleStyleClassicDesc => 'Традиционный стиль пузырей';

  @override
  String get discoverVideoChannels => 'Каналы';

  @override
  String get discoverLive => 'Прямой эфир';

  @override
  String get discoverListen => 'Слушать';

  @override
  String get discoverWatch => 'Смотреть';

  @override
  String get discoverSearchDiscover => 'Поиск';

  @override
  String get discoverNearbyPeople => 'Рядом';

  @override
  String get discoverGames => 'Игры';

  @override
  String get discoverMiniPrograms => 'Мини-программы';

  @override
  String get chatAlreadyInCall => 'Уже в вызове';

  @override
  String get commonConnectionFailed => 'Ошибка подключения';

  @override
  String get chatCallRejected => 'Вызов отклонён';

  @override
  String get chatNoAnswer => 'Нет ответа';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get chatSelectContact => 'Выбрать контакт';

  @override
  String get chatVoteRemoved => 'Голос удалён';

  @override
  String get chatVoteChanged => 'Голос изменён';

  @override
  String get chatVoted => 'Проголосовано';

  @override
  String chatReplyTo(String name) {
    return 'Ответ $name';
  }

  @override
  String get chatCurrentLocation => 'Текущее местоположение';

  @override
  String chatNearbyPlace(int index) {
    return 'Место поблизости $index';
  }

  @override
  String chatApproximateDistance(String distance) {
    return 'Примерно $distance';
  }

  @override
  String get chatAddress => 'Адрес';

  @override
  String get chatLatitude => 'Широта';

  @override
  String get chatLongitude => 'Долгота';

  @override
  String get groupDescriptionUpdated => 'Описание группы обновлено';

  @override
  String get groupAvatarUpdated => 'Аватар группы обновлен';

  @override
  String get callDecline => 'Отклонить';

  @override
  String get callAnswer => 'Ответить';

  @override
  String get callIncomingVideoCall => 'Входящий видеозвонок';

  @override
  String get callIncomingVoiceCall => 'Входящий голосовой звонок';

  @override
  String get callVideoCallInProgress => 'Видеозвонок';

  @override
  String get callVoiceCallInProgress => 'Голосовой звонок';

  @override
  String get callReconnectingCall => 'Переподключение...';

  @override
  String get callEnded => 'Звонок завершён';

  @override
  String get callFailed => 'Звонок не удался';

  @override
  String get callLivekitNotConfigured => 'LiveKit не настроен';

  @override
  String callJoinMeetingFailed(String error) {
    return 'Не удалось присоединиться к конференции: $error';
  }

  @override
  String callScreenShareFailed(String error) {
    return 'Не удалось поделиться экраном: $error';
  }

  @override
  String get profileN42BeanTitle => 'N42 Bean';

  @override
  String get profileNoN42Bean => 'Нет N42 Bean';

  @override
  String get profileN42BeanDetails => 'Детали N42 Bean';

  @override
  String get profileN42BeanDescription =>
      'N42 Bean — токен для обмена на виртуальные предметы и услуги в N42. Сейчас доступно:';

  @override
  String get profileN42BeanFeature1 =>
      'Эксклюзивные стикеры и темы для участников';

  @override
  String get profileN42BeanFeature2 => 'Настройка пузырей чата';

  @override
  String get profileN42BeanFeature3 => 'Настройка обложек красных конвертов';

  @override
  String get profileN42BeanFeature4 => 'Эксклюзивный значок никнейма';

  @override
  String get profileN42BeanFeature5 => 'Привилегии группового чата';

  @override
  String get profileN42BeanFeature6 => 'Расширение облачного хранилища';

  @override
  String get profileN42BeanFeature7 => 'Фильтры красоты для видеозвонков';

  @override
  String get profileN42BeanFeature8 => 'Настройка фона Moments';

  @override
  String get profileN42BeanFeature9 => 'Приоритет VIP-обслуживания';

  @override
  String get profileGotIt => 'Понятно';

  @override
  String get profileNoN42BeanRecords => 'Нет записей N42 Bean';

  @override
  String get profileMoodAndThoughts => 'Настроение и мысли';

  @override
  String get profileStatusHappy => 'Счастлив';

  @override
  String get profileStatusCracked => 'Разбит';

  @override
  String get profileStatusLucky => 'Везучий';

  @override
  String get profileStatusSunny => 'Солнечный';

  @override
  String get profileStatusTired => 'Усталый';

  @override
  String get profileStatusDaydream => 'Мечтаю';

  @override
  String get profileStatusRushing => 'Спешу';

  @override
  String get profileStatusOverthinking => 'Задумался';

  @override
  String get profileStatusEnergized => 'Энергичный';

  @override
  String get profileWorkAndStudy => 'Работа и учёба';

  @override
  String get profileStatusWorking => 'Работаю';

  @override
  String get profileStatusStudying => 'Учусь';

  @override
  String get profileStatusBusy => 'Занят';

  @override
  String get profileStatusSlacking => 'Ленюсь';

  @override
  String get profileStatusTraveling => 'Путешествую';

  @override
  String get profileStatusGoingHome => 'Иду домой';

  @override
  String get profileStatusDnd => 'Не беспокоить';

  @override
  String get profileActivities => 'Активность';

  @override
  String get profileStatusHanging => 'Отдыхаю';

  @override
  String get profileStatusCheckIn => 'Отметка';

  @override
  String get profileStatusExercising => 'Тренируюсь';

  @override
  String get profileStatusCoffee => 'Кофе';

  @override
  String get profileStatusBubbleTea => 'Чай с пузырьками';

  @override
  String get profileStatusEating => 'Ем';

  @override
  String get profileStatusParenting => 'С детьми';

  @override
  String get profileStatusSavingWorld => 'Спасаю мир';

  @override
  String get profileStatusSelfie => 'Селфи';

  @override
  String get profileRest => 'Отдых';

  @override
  String get profileStatusRetreat => 'Уединение';

  @override
  String get profileStatusHome => 'Дома';

  @override
  String get profileStatusSleeping => 'Сплю';

  @override
  String get profileStatusCatLover => 'Люблю кошек';

  @override
  String get profileStatusDogWalking => 'Гуляю с собакой';

  @override
  String get profileStatusGaming => 'Играю';

  @override
  String get profileStatusListening => 'Слушаю музыку';

  @override
  String get profileEditAddress => 'Редактировать адрес';

  @override
  String get profileRecipient => 'Получатель';

  @override
  String get profileEnterRecipientName => 'Введите имя получателя';

  @override
  String get profilePhoneNumber => 'Номер телефона';

  @override
  String get profileEnterPhoneNumber => 'Введите номер телефона';

  @override
  String get profileRegionHint => 'Область/Город/Район';

  @override
  String get profileDetailedAddress => 'Подробный адрес';

  @override
  String get profileDetailedAddressHint => 'Улица, номер дома и т.д.';

  @override
  String get profileSetAsDefaultAddress => 'Установить как адрес по умолчанию';

  @override
  String get profilePleaseCompleteInfo => 'Пожалуйста, заполните все поля';

  @override
  String get profileEditInvoice => 'Редактировать счёт';

  @override
  String get profileInvoiceType => 'Тип счёта: ';

  @override
  String get profileCompanyName => 'Название компании';

  @override
  String get profilePersonalName => 'Имя';

  @override
  String get profileEnterCompanyName => 'Введите название компании';

  @override
  String get profileEnterName => 'Введите имя';

  @override
  String get profileTaxIdNumber => 'ИНН';

  @override
  String get profileEnterTaxIdNumber => 'Введите ИНН';

  @override
  String get profileBankNameOptional => 'Название банка (необязательно)';

  @override
  String get profileEnterBankName => 'Введите название банка';

  @override
  String get profileBankAccountOptional => 'Номер счёта (необязательно)';

  @override
  String get profileEnterBankAccount => 'Введите номер счёта';

  @override
  String get profileCompanyAddressOptional => 'Адрес компании (необязательно)';

  @override
  String get profileEnterCompanyAddress => 'Введите адрес компании';

  @override
  String get profileCompanyPhoneOptional => 'Телефон компании (необязательно)';

  @override
  String get profileEnterCompanyPhone => 'Введите телефон компании';

  @override
  String get profileSetAsDefaultInvoice => 'Установить как счёт по умолчанию';

  @override
  String get profileRingtoneVibrate => 'Вибрация';

  @override
  String get profileRingtoneSilent => 'Беззвучный';

  @override
  String get profileVibrateMode => 'Режим вибрации';

  @override
  String get profileSilentMode => 'Беззвучный режим';

  @override
  String profilePlayFailed(String ringtoneName) {
    return 'Ошибка воспроизведения: $ringtoneName';
  }

  @override
  String profilePlaying(String ringtoneName) {
    return 'Воспроизведение: $ringtoneName';
  }

  @override
  String get profileStop => 'Стоп';

  @override
  String get profileSelectRingtone => 'Выбрать рингтон';

  @override
  String get profileLoadingRingtones => 'Загрузка рингтонов...';

  @override
  String get profileNoRingtonesFound => 'Рингтоны не найдены';

  @override
  String mainMessagesWithCount(int count) {
    return 'Сообщения($count)';
  }

  @override
  String get storyViewers => 'Зрители';

  @override
  String get storyNoViewers => 'Пока нет зрителей';

  @override
  String get storyReplyToStory => 'Ответить на историю...';

  @override
  String get commonCopiedToClipboard => 'Скопировано в буфер обмена';

  @override
  String get commonMore => 'Ещё';

  @override
  String get commonTranslating => 'Перевод...';

  @override
  String commonTranslatedFrom(String language) {
    return 'Переведено с $language';
  }

  @override
  String get commonTranslation => 'Перевод';

  @override
  String get commonTranslationFailed => 'Ошибка перевода';

  @override
  String get commonAllRead => 'Все прочитаны';

  @override
  String commonReadCount(int count) {
    return '$count прочитано';
  }

  @override
  String get commonYouRecalledMessage => 'Вы отозвали сообщение';

  @override
  String get commonMessageRecalled => 'Сообщение отозвано';

  @override
  String get commonReEdit => 'Редактировать';

  @override
  String get commonWalletArea => 'Область кошелька';

  @override
  String get callIncomingCall => 'Входящий вызов';

  @override
  String get callMissedCall => 'Пропущенный вызов';

  @override
  String get groupRemoveAdmin => 'Снять права администратора';

  @override
  String get chatSelectCurrency => 'Выбрать валюту';

  @override
  String get chatSelectEmoji => 'Выбрать эмодзи';

  @override
  String get chatSelectRedPacketCover => 'Выбрать обложку';

  @override
  String get groupSetAsAdmin => 'Назначить администратором';

  @override
  String get chatVideoPlaybackFailed => 'Ошибка воспроизведения видео';

  @override
  String get groupViewProfile => 'Просмотреть профиль';

  @override
  String get favoriteAddLinkComingSoon => 'Добавление ссылок скоро появится';

  @override
  String get favoriteNewNoteComingSoon => 'Новые заметки скоро появятся';

  @override
  String get qrcodeSaveFeatureComingSoon => 'Функция сохранения скоро появится';

  @override
  String get qrcodeShareFeatureComingSoon => 'Функция отправки скоро появится';

  @override
  String qrcodeProcessFailed(String error) {
    return 'Не удалось обработать QR-код: $error';
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
}
