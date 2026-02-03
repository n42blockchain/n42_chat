// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class SRu extends S {
  SRu([String locale = 'ru']) : super(locale);

  @override
  String get chatModuleInitFailed => 'Ошибка инициализации модуля чата';

  @override
  String get checkNetworkRetry =>
      'Проверьте подключение к сети и повторите попытку';

  @override
  String get retry => 'Повторить';

  @override
  String get unknownUser => 'Неизвестный пользователь';

  @override
  String get walletNotConnected => 'Кошелёк не подключён';

  @override
  String get cannotGetWalletAddress => 'Не удаётся получить адрес кошелька';

  @override
  String paymentRequestMemo(String requestId) {
    return 'Запрос на оплату: $requestId';
  }

  @override
  String get callServiceNotInitialized => 'Служба вызовов не инициализирована';

  @override
  String get alreadyInCall => 'Уже в вызове';

  @override
  String get meetingServiceNotInitialized =>
      'Служба конференций не инициализирована';

  @override
  String get livekitNotConfigured => 'LiveKit не настроен';

  @override
  String get unknownConversation => 'Неизвестный разговор';

  @override
  String startCallFailed(String error) {
    return 'Не удалось начать вызов: $error';
  }

  @override
  String answerCallFailed(String error) {
    return 'Не удалось ответить: $error';
  }

  @override
  String get connectionFailed => 'Ошибка подключения';

  @override
  String get callRejected => 'Вызов отклонён';

  @override
  String get noAnswer => 'Нет ответа';

  @override
  String get invalidLoginResponse => 'Неверный ответ при входе';

  @override
  String loginFailed(String error) {
    return 'Ошибка входа: $error';
  }

  @override
  String get sessionRestoreFailed => 'Не удалось восстановить сессию';

  @override
  String get additionalVerificationRequired =>
      'Требуется дополнительная проверка';

  @override
  String registrationFailed(String error) {
    return 'Ошибка регистрации: $error';
  }

  @override
  String cannotConnectServer(String error) {
    return 'Не удаётся подключиться к серверу: $error';
  }

  @override
  String get wrongUsernamePassword => 'Неверное имя пользователя или пароль';

  @override
  String get usernameTaken => 'Имя пользователя уже занято';

  @override
  String get invalidUsernameFormat => 'Неверный формат имени пользователя';

  @override
  String get rateLimitExceeded => 'Слишком много запросов, попробуйте позже';

  @override
  String get loginExpired => 'Сессия истекла';

  @override
  String joinMeetingFailed(String error) {
    return 'Не удалось присоединиться к конференции: $error';
  }

  @override
  String screenShareFailed(String error) {
    return 'Не удалось поделиться экраном: $error';
  }

  @override
  String get answer => 'Ответить';

  @override
  String get decline => 'Отклонить';

  @override
  String get missedCall => 'Пропущенный вызов';

  @override
  String get callBack => 'Перезвонить';

  @override
  String get incomingCall => 'Входящий вызов';

  @override
  String get missedVideoCall => 'Пропущенный видеовызов';

  @override
  String get missedVoiceCall => 'Пропущенный голосовой вызов';

  @override
  String get passkeyNotInitialized => 'Passkey не инициализирован';

  @override
  String get googleSignInNotConfigured => 'Вход через Google не настроен';

  @override
  String get encryptedMessage => '[Зашифрованное сообщение]';

  @override
  String get sticker => '[Стикер]';

  @override
  String get groupCreated => 'Группа создана';

  @override
  String get groupNameChanged => 'Название группы изменено';

  @override
  String get groupAvatarChanged => 'Аватар группы изменён';

  @override
  String get groupAnnouncementChanged => 'Объявление группы изменено';

  @override
  String get image => '[Изображение]';

  @override
  String get video => '[Видео]';

  @override
  String get voice => '[Голосовое сообщение]';

  @override
  String get file => '[Файл]';

  @override
  String get location => '[Местоположение]';

  @override
  String get unknownMessage => '[Неизвестное сообщение]';

  @override
  String joinedGroup(String senderName) {
    return '$senderName присоединился к группе';
  }

  @override
  String leftGroup(String senderName) {
    return '$senderName покинул группу';
  }

  @override
  String invitedToGroup(String senderName) {
    return '$senderName приглашён';
  }

  @override
  String removedFromGroup(String senderName) {
    return '$senderName удалён';
  }

  @override
  String get avatarDataEmpty => 'Данные аватара пусты';

  @override
  String get avatarTooLarge => 'Файл аватара слишком большой, максимум 10 МБ';

  @override
  String get uploadAvatarFailed => 'Не удалось загрузить аватар';

  @override
  String get delete => 'Удалить';

  @override
  String get notLoggedIn => 'Не выполнен вход';

  @override
  String roomNotExist(String roomId) {
    return 'Комната не найдена: $roomId';
  }

  @override
  String get uploadImageFailed => 'Не удалось загрузить изображение';

  @override
  String get matrixClientNotInitialized => 'Клиент Matrix не инициализирован';

  @override
  String get uploadVoiceFailed =>
      'Не удалось загрузить голосовое сообщение: Невозможно получить MXC URI';

  @override
  String get uploadVideoFailed =>
      'Не удалось загрузить видео: Невозможно получить MXC URI';

  @override
  String get uploadFileFailed =>
      'Не удалось загрузить файл: Невозможно получить MXC URI';

  @override
  String locationWithCoords(String lat, String lon) {
    return 'Местоположение: $lat, $lon';
  }

  @override
  String get myLocation => 'Моё местоположение';

  @override
  String get pollEnded => 'Опрос завершён';

  @override
  String get groupChat => 'Групповой чат';

  @override
  String get search => 'Поиск';

  @override
  String get cancel => 'Отмена';

  @override
  String get userCancelled => 'Пользователь отменил';

  @override
  String get noData => 'Нет данных';

  @override
  String get noSearchResults => 'Нет результатов поиска';

  @override
  String get tryDifferentKeyword => 'Попробуйте другое ключевое слово';

  @override
  String get loadFailed => 'Ошибка загрузки';

  @override
  String get checkNetwork => 'Проверьте подключение к сети';

  @override
  String get networkConnectionFailed => 'Ошибка сетевого подключения';

  @override
  String get checkNetworkSettings => 'Проверьте сетевые настройки';

  @override
  String get messages => 'Сообщения';

  @override
  String get contacts => 'Контакты';

  @override
  String get discover => 'Обзор';

  @override
  String get me => 'Я';

  @override
  String get voiceLoading => 'Загрузка голосового сообщения, попробуйте позже';

  @override
  String get voiceToTextFailed => 'Не удалось преобразовать голос в текст';

  @override
  String get converting => 'Преобразование...';

  @override
  String get convertToText => 'В текст';

  @override
  String get convertToTextTitle => 'Преобразовать в текст';

  @override
  String get selectEmoji => 'Выбрать эмодзи';

  @override
  String get frequentlyUsed => 'Часто используемые';

  @override
  String get copy => 'Копировать';

  @override
  String get forward => 'Переслать';

  @override
  String get unfavorite => 'Удалить из избранного';

  @override
  String get favorite => 'В избранное';

  @override
  String get resend => 'Отправить повторно';

  @override
  String get recall => 'Отозвать';

  @override
  String get multiSelect => 'Множественный выбор';

  @override
  String get quote => 'Цитировать';

  @override
  String get remind => 'Напомнить';

  @override
  String get searchThis => 'Поиск';

  @override
  String get recallMessageConfirm => 'Отозвать это сообщение?';

  @override
  String get youRecalledMessage => 'Вы отозвали сообщение';

  @override
  String get otherRecalledMessage => 'Сообщение отозвано';

  @override
  String get reEdit => 'Редактировать';

  @override
  String get copied => 'Скопировано';

  @override
  String get sendMessageHint => 'Написать сообщение';

  @override
  String get microphonePermissionRequired =>
      'Пожалуйста, разрешите доступ к микрофону';

  @override
  String startRecordingFailed(String error) {
    return 'Не удалось начать запись: $error';
  }

  @override
  String get recordingTooShort => 'Запись слишком короткая';

  @override
  String stopRecordingFailed(String error) {
    return 'Не удалось остановить запись: $error';
  }

  @override
  String get releaseToCancel => 'Отпустите для отмены';

  @override
  String get releaseToSend =>
      'Отпустите для отправки, смахните вверх для отмены';

  @override
  String get holdToTalk => 'Удерживайте для записи';

  @override
  String get send => 'Отправить';

  @override
  String conversationWithId(String roomId) {
    return 'Разговор: $roomId';
  }

  @override
  String contactWithId(String userId) {
    return 'Контакт: $userId';
  }

  @override
  String get addFriend => 'Добавить друга';

  @override
  String get chatServiceNotConnected => 'Служба чата не подключена';

  @override
  String userNotFoundHint(String query) {
    return 'Пользователь \"$query\" не найден\n\nПодсказки:\n• Попробуйте ввести полный ID пользователя, например @username:server.com\n• Проверьте правильность написания имени';
  }

  @override
  String createChatFailed(String error) {
    return 'Не удалось создать чат: $error';
  }

  @override
  String searchFailed(String error) {
    return 'Ошибка поиска: $error';
  }

  @override
  String get enterUserIdOrUsername =>
      'Введите ID или имя пользователя для поиска';

  @override
  String get searching => 'Поиск...';

  @override
  String get searchUserToChat => 'Найдите пользователя, чтобы начать чат';

  @override
  String get matrixIdExample =>
      'Вы можете ввести полный Matrix ID\nнапример @user:matrix.n42.network';

  @override
  String userNotFound(String username) {
    return 'Пользователь \"$username\" не найден';
  }

  @override
  String get chat => 'Чат';

  @override
  String get settings => 'Настройки';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get login => 'Войти';

  @override
  String get createGroup => 'Создать группу';

  @override
  String developing(String title) {
    return '$title\n(Скоро)';
  }

  @override
  String get error => 'Ошибка';

  @override
  String get pageNotFound => 'Страница не найдена';

  @override
  String get backToHome => 'На главную';

  @override
  String get allRead => 'Все прочитаны';

  @override
  String readCount(int count) {
    return '$count прочитано';
  }

  @override
  String get transfer => 'Перевод';

  @override
  String get pendingReceipt => 'Ожидание';

  @override
  String get tapToReceive => 'Нажмите, чтобы получить';

  @override
  String get received => 'Получено';

  @override
  String get paymentReceived => 'Платёж получен';

  @override
  String get refunded => 'Возвращено';

  @override
  String get expired => 'Истёк';

  @override
  String get redPacketGreeting => 'С наилучшими пожеланиями';

  @override
  String get n42RedPacket => 'Красный конверт N42';

  @override
  String get goodLuck => 'Удачи';

  @override
  String get claimed => 'Получено';

  @override
  String get allClaimed => 'Все получены';

  @override
  String get emoji => 'Эмодзи';

  @override
  String get love => 'Любовь';

  @override
  String get animals => 'Животные';

  @override
  String get food => 'Еда';

  @override
  String get travel => 'Путешествия';

  @override
  String get activities => 'Активность';

  @override
  String get objects => 'Предметы';

  @override
  String get symbols => 'Символы';

  @override
  String get reply => 'Ответить';

  @override
  String get copiedToClipboard => 'Скопировано в буфер обмена';

  @override
  String get edit => 'Редактировать';

  @override
  String get more => 'Ещё';

  @override
  String get selectForwardTarget => 'Выбрать получателя';

  @override
  String sendCount(int count) {
    return 'Отправить ($count)';
  }

  @override
  String get draft => '[Черновик] ';

  @override
  String n42Id(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get n42IdTitle => 'N42 ID';

  @override
  String get n42Bean => 'N42 Bean';

  @override
  String get friendInfo => 'Информация о друге';

  @override
  String get friendInfoDesc =>
      'Добавьте заметку, телефон, теги, примечания, фото и настройте разрешения.';

  @override
  String get moments => 'Моменты';

  @override
  String get sendMessage => 'Сообщение';

  @override
  String get audioVideoCall => 'Аудио/видеовызов';

  @override
  String get videoChannel => 'Видеоканал';

  @override
  String get remark => 'Заметка';

  @override
  String get remarkName => 'Имя заметки';

  @override
  String get phone => 'Телефон';

  @override
  String get tags => 'Теги';

  @override
  String get notes => 'Заметки';

  @override
  String get photos => 'Фото';

  @override
  String get permissions => 'Разрешения';

  @override
  String get chatMomentsEtc => 'Чат, Моменты, Спорт и т.д.';

  @override
  String get moreInfo => 'Подробнее';

  @override
  String get commonGroups => 'Общие группы';

  @override
  String get zeroGroups => '0';

  @override
  String get source => 'Источник';

  @override
  String get notificationSettings => 'Уведомления';

  @override
  String get receiveNotifications => 'Получать уведомления о новых сообщениях';

  @override
  String get showPreview => 'Показывать предпросмотр сообщения';

  @override
  String get showContentInNotification =>
      'Показывать содержимое в уведомлениях';

  @override
  String get notificationSound => 'Звук уведомления';

  @override
  String get playSoundOnMessage =>
      'Воспроизводить звук при получении сообщения';

  @override
  String get vibrate => 'Вибрация';

  @override
  String get vibrateOnMessage => 'Вибрировать при получении сообщения';

  @override
  String get doNotDisturb => 'Не беспокоить';

  @override
  String get dndDescription => 'Отключить уведомления в указанные часы';

  @override
  String get startTime => 'Время начала';

  @override
  String get endTime => 'Время окончания';

  @override
  String get privacy => 'Конфиденциальность';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get about => 'О приложении';

  @override
  String get logout => 'Выйти';

  @override
  String get logoutConfirm => 'Вы уверены, что хотите выйти?';

  @override
  String get exit => 'Выйти';

  @override
  String get save => 'Сохранить';

  @override
  String get nickname => 'Никнейм';

  @override
  String get enterNickname => 'Введите никнейм';

  @override
  String get signature => 'Подпись';

  @override
  String get addSignature => 'Добавить подпись';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get chooseFromGallery => 'Выбрать из галереи';

  @override
  String saveFailed(String error) {
    return 'Ошибка сохранения: $error';
  }

  @override
  String get secureDecentralizedChat =>
      'Безопасный децентрализованный мессенджер';

  @override
  String get endToEndEncryption => 'Сквозное шифрование';

  @override
  String get messagesOnlyYouCanSee => 'Сообщения видны только вам и получателю';

  @override
  String get decentralized => 'Децентрализованный';

  @override
  String get basedOnMatrix => 'На основе открытого протокола Matrix';

  @override
  String get walletIntegration => 'Интеграция с кошельком';

  @override
  String get easyCryptoTransfer => 'Простые криптовалютные переводы';

  @override
  String get register => 'Зарегистрироваться';

  @override
  String get agreeTerms => 'Входя в систему, вы соглашаетесь с';

  @override
  String get termsOfService => 'Условиями использования';

  @override
  String get and => 'и';

  @override
  String get privacyPolicy => 'Политикой конфиденциальности';

  @override
  String get serverAddress => 'Адрес сервера';

  @override
  String get enterServerAddress => 'Введите адрес сервера';

  @override
  String get validServerAddress =>
      'Пожалуйста, введите действительный адрес сервера';

  @override
  String connectedTo(String serverName) {
    return 'Подключено к $serverName';
  }

  @override
  String get username => 'Имя пользователя';

  @override
  String get enterUsername => 'Введите имя пользователя';

  @override
  String get password => 'Пароль';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get registerAccount => 'Зарегистрироваться';

  @override
  String get forgotPassword => 'Забыли пароль';

  @override
  String get otherLoginMethods => 'Другие способы входа';

  @override
  String get emailVerification => 'Код подтверждения по email';

  @override
  String get enterServerFirst => 'Сначала введите адрес сервера';

  @override
  String get passkeyNeedsServer =>
      'Для входа через Passkey требуется поддержка сервера';

  @override
  String googleLoginSuccess(String email) {
    return 'Вход через Google успешен: $email';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Ошибка входа через Google: $error';
  }

  @override
  String get appleLoginSuccess => 'Вход через Apple успешен';

  @override
  String appleLoginFailed(String error) {
    return 'Ошибка входа через Apple: $error';
  }

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get joinN42Chat => 'Присоединитесь к N42 Chat, чтобы начать общение';

  @override
  String get usernameHint => '3-20 символов, буквы/цифры/_';

  @override
  String get usernameMinLength =>
      'Имя пользователя должно содержать не менее 3 символов';

  @override
  String get usernameMaxLength =>
      'Имя пользователя должно содержать не более 20 символов';

  @override
  String get usernameFormat =>
      'Имя пользователя может содержать только буквы, цифры и подчёркивания';

  @override
  String get passwordHint => 'Минимум 8 символов';

  @override
  String get passwordMinLength => 'Пароль должен содержать не менее 8 символов';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get reEnterPassword => 'Введите пароль повторно';

  @override
  String get passwordsNotMatch => 'Пароли не совпадают';

  @override
  String get inviteCode => 'Код приглашения (встроенный)';

  @override
  String get filled => 'Заполнено';

  @override
  String get enterInviteCode => 'Введите код приглашения';

  @override
  String get inviteCodeHint =>
      'Код приглашения встроен, обычно изменять не требуется';

  @override
  String get agreeTermsFirst =>
      'Сначала прочитайте и согласитесь с условиями и политикой конфиденциальности';

  @override
  String get iAgree => 'Я прочитал и согласен с';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт?';

  @override
  String get loginNow => 'Войти';

  @override
  String get whoCanSee => 'Кто может видеть';

  @override
  String get avatar => 'Аватар';

  @override
  String get status => 'Статус';

  @override
  String get lastSeen => 'Последний визит';

  @override
  String get messageSettings => 'Сообщения';

  @override
  String get allowStrangerMessage => 'Разрешить сообщения от незнакомцев';

  @override
  String get receiveNonContact => 'Получать сообщения не из контактов';

  @override
  String get readReceipts => 'Отчёты о прочтении';

  @override
  String get letOthersKnowRead =>
      'Сообщать другим, что вы прочитали их сообщения';

  @override
  String get typingStatus => 'Статус набора';

  @override
  String get letOthersKnowTyping => 'Сообщать другим, что вы печатаете';

  @override
  String get everyone => 'Все';

  @override
  String get contactsOnly => 'Только контакты';

  @override
  String get nobody => 'Никто';

  @override
  String whoCanSeeItem(String title) {
    return 'Кто может видеть $title';
  }

  @override
  String version(String version) {
    return 'Версия $version';
  }

  @override
  String get checkUpdate => 'Проверить обновления';

  @override
  String get openSourceLicenses => 'Лицензии открытого ПО';

  @override
  String get feedback => 'Обратная связь';

  @override
  String get builtOnMatrix => 'На основе протокола Matrix';

  @override
  String get loading => 'Загрузка...';

  @override
  String get noConversations => 'Нет разговоров';

  @override
  String get tapToChat => 'Нажмите справа вверху, чтобы начать чат';

  @override
  String get startGroup => 'Создать групповой чат';

  @override
  String get scan => 'Сканировать';

  @override
  String get payment => 'Оплата';

  @override
  String featureComingSoon(String feature) {
    return '$feature скоро появится';
  }

  @override
  String get markAsRead => 'Отметить как прочитанное';

  @override
  String get unmute => 'Включить звук';

  @override
  String get mute => 'Без звука';

  @override
  String get unpin => 'Открепить';

  @override
  String get pin => 'Закрепить';

  @override
  String get deleteConversation => 'Удалить разговор';

  @override
  String deleteConversationConfirm(String name) {
    return 'Удалить разговор с \"$name\"?';
  }

  @override
  String get noContacts => 'Нет контактов';

  @override
  String get addFriendsToChat => 'Добавьте друзей, чтобы начать общение';

  @override
  String get contactNotFound => 'Контакт не найден';

  @override
  String get tryOtherKeywords =>
      'Попробуйте другие ключевые слова или глобальный поиск';

  @override
  String get searchResults => 'Результаты поиска';

  @override
  String get newFriends => 'Новые друзья';

  @override
  String get chatOnlyFriends => 'Друзья только для чата';

  @override
  String get officialAccounts => 'Официальные аккаунты';

  @override
  String get serviceAccounts => 'Сервисные аккаунты';

  @override
  String get enterpriseContacts => 'Корпоративные контакты';

  @override
  String contactsCount(int count) {
    return '$count контактов';
  }

  @override
  String get recommendToFriend => 'Поделиться контактом';

  @override
  String get setRemark => 'Установить заметку';

  @override
  String get addToHome => 'Добавить на главный экран';

  @override
  String get sendingCard => 'Отправка контактной карточки...';

  @override
  String get contactCard => '[Контактная карточка]';

  @override
  String get fileLabel => 'Файл';

  @override
  String get locationLabel => 'Местоположение';

  @override
  String cardSent(String contact, String friend) {
    return 'Отправлена карточка $contact для $friend';
  }

  @override
  String recommendFailed(String error) {
    return 'Ошибка рекомендации: $error';
  }

  @override
  String get enterRemark => 'Введите заметку';

  @override
  String remarkSet(String remark) {
    return 'Заметка установлена: $remark';
  }

  @override
  String get openingChat => 'Открытие чата...';

  @override
  String openChatFailed(String error) {
    return 'Не удалось открыть чат: $error';
  }

  @override
  String get addContact => 'Добавить контакт';

  @override
  String get enterUserId => 'Введите ID пользователя';

  @override
  String get noFriendRequests => 'Нет запросов в друзья';

  @override
  String get accept => 'Принять';

  @override
  String get reject => 'Отклонить';

  @override
  String acceptedRequest(String name) {
    return 'Принят запрос в друзья от $name';
  }

  @override
  String rejectedRequest(String name) {
    return 'Отклонён запрос в друзья от $name';
  }

  @override
  String get noGroups => 'Нет групп';

  @override
  String get creatingGroup => 'Создание группы скоро появится...';

  @override
  String get selectFriendToRecommend => 'Выберите друга для рекомендации';

  @override
  String get searchContacts => 'Поиск контактов';

  @override
  String get noContactsFound => 'Контакты не найдены';

  @override
  String get yesterday => 'Вчера';

  @override
  String get monday => 'Пн';

  @override
  String get tuesday => 'Вт';

  @override
  String get wednesday => 'Ср';

  @override
  String get thursday => 'Чт';

  @override
  String get friday => 'Пт';

  @override
  String get saturday => 'Сб';

  @override
  String get sunday => 'Вс';

  @override
  String get justNow => 'Только что';

  @override
  String minutesAgo(int count) {
    return '$count мин. назад';
  }

  @override
  String hoursAgo(int count) {
    return '$count ч. назад';
  }

  @override
  String daysAgo(int count) {
    return '$count дн. назад';
  }

  @override
  String get online => 'В сети';

  @override
  String get offline => 'Не в сети';

  @override
  String minutesAgoOnline(int count) {
    return 'Был(а) $count мин. назад';
  }

  @override
  String hoursAgoOnline(int count) {
    return 'Был(а) $count ч. назад';
  }

  @override
  String daysAgoOnline(int count) {
    return 'Был(а) $count дн. назад';
  }

  @override
  String get searchContactsGroupsMessages =>
      'Поиск контактов, групп, сообщений';

  @override
  String get searchError => 'Ошибка поиска';

  @override
  String get searchHint => 'Поиск контактов, групп и сообщений';

  @override
  String get enterKeyword => 'Введите ключевые слова для поиска';

  @override
  String get searchHistory => 'История поиска';

  @override
  String get clear => 'Очистить';

  @override
  String noResultsFor(String query) {
    return 'Нет результатов для \"$query\"';
  }

  @override
  String get all => 'Все';

  @override
  String get groups => 'Группы';

  @override
  String get noResults => 'Нет результатов';

  @override
  String get groupInfo => 'Информация о группе';

  @override
  String groupMembers(int count) {
    return 'Участники ($count)';
  }

  @override
  String get groupMembersTitle => 'Участники группы';

  @override
  String get viewAll => 'Показать все';

  @override
  String get owner => 'Владелец';

  @override
  String get admin => 'Администратор';

  @override
  String get invite => 'Пригласить';

  @override
  String get groupAnnouncement => 'Объявление группы';

  @override
  String get notSet => 'Не установлено';

  @override
  String get groupDescription => 'Описание группы';

  @override
  String get publicGroup => 'Публичная группа';

  @override
  String get allowSearchJoin => 'Разрешить поиск и присоединение';

  @override
  String get clearChatHistory => 'Очистить историю чата';

  @override
  String get dissolveGroup => 'Распустить группу';

  @override
  String get leaveGroup => 'Покинуть группу';

  @override
  String get changeGroupName => 'Изменить название группы';

  @override
  String get enterGroupName => 'Введите название группы';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get changeGroupDescription => 'Изменить описание группы';

  @override
  String get enterGroupDescription => 'Введите описание группы';

  @override
  String get editAnnouncement => 'Редактировать объявление';

  @override
  String get enterAnnouncement => 'Введите объявление';

  @override
  String get publish => 'Опубликовать';

  @override
  String get clearHistoryConfirm =>
      'Очистить всю историю чата? Это действие нельзя отменить.';

  @override
  String get clearAction => 'Очистить';

  @override
  String get chatHistoryCleared => 'История чата очищена';

  @override
  String leaveGroupConfirm(String name) {
    return 'Покинуть \"$name\"?';
  }

  @override
  String dissolveGroupConfirm(String name) {
    return 'Распустить \"$name\"? Это действие нельзя отменить.';
  }

  @override
  String get dissolve => 'Распустить';

  @override
  String get groupQrCode => 'QR-код группы';

  @override
  String get searchChatHistory => 'Поиск в истории чата';

  @override
  String get groupIdCopied => 'ID группы скопирован';

  @override
  String tapCopyGroupId(int count) {
    return '$count участников · Нажмите, чтобы скопировать ID группы';
  }

  @override
  String get receiverAddress => 'Адрес получателя';

  @override
  String get enterOrPasteAddress => 'Введите или вставьте адрес кошелька';

  @override
  String get selectToken => 'Выбрать токен';

  @override
  String get transferAmount => 'Сумма перевода';

  @override
  String get available => 'Доступно';

  @override
  String get allAmount => 'Всё';

  @override
  String get memoOptional => 'Примечание (необязательно)';

  @override
  String get addMemo => 'Добавить примечание';

  @override
  String get confirmTransfer => 'Подтвердить перевод';

  @override
  String get invalidAddress =>
      'Пожалуйста, введите действительный адрес получателя';

  @override
  String get invalidAmount => 'Пожалуйста, введите действительную сумму';

  @override
  String get selectTokenPlease => 'Пожалуйста, выберите токен';

  @override
  String get addressVerified => 'Адрес подтверждён';

  @override
  String availableBalance(String balance, String symbol) {
    return 'Доступно: $balance $symbol';
  }

  @override
  String get scanningInDevelopment => 'Функция сканирования в разработке...';

  @override
  String get enterAmount => 'Введите сумму';

  @override
  String get redPacketCountMin => 'Требуется минимум 1 красный конверт';

  @override
  String get viewRedPacketDetails => 'Посмотреть детали красного конверта';

  @override
  String get enterTransferAmount => 'Введите сумму перевода';

  @override
  String get transferTo => 'Перевести';

  @override
  String get selectCurrency => 'Выбрать валюту';

  @override
  String get receiveTransfer => 'Полученный перевод';

  @override
  String fromSender(String name, Object senderName) {
    return 'От $senderName';
  }

  @override
  String get confirmReceive => 'Подтвердить получение';

  @override
  String get groupProfile => 'Информация о группе';

  @override
  String get viewProfile => 'Просмотреть профиль';

  @override
  String get removeMember => 'Удалить из группы';

  @override
  String removeMemberConfirm(String name) {
    return 'Удалить \"$name\" из группы?';
  }

  @override
  String get remove => 'Удалить';

  @override
  String get clearStatus => 'Очистить статус';

  @override
  String get clearStatusConfirm => 'Очистить текущий статус?';

  @override
  String get statusCleared => 'Статус очищен';

  @override
  String statusSet(String result) {
    return 'Статус установлен: $result';
  }

  @override
  String get userNotExist => 'Пользователь не существует';

  @override
  String get userIdCopied => 'ID пользователя скопирован';

  @override
  String get voiceCallInDevelopment => 'Голосовой вызов в разработке...';

  @override
  String get report => 'Пожаловаться';

  @override
  String get reportInDevelopment => 'Функция жалобы в разработке...';

  @override
  String get shareCard => 'Поделиться карточкой';

  @override
  String get shareInDevelopment => 'Функция отправки в разработке...';

  @override
  String get qrCode => 'QR-код';

  @override
  String get qrCodeInDevelopment => 'Функция QR-кода в разработке...';

  @override
  String get avatarUpdated => 'Аватар обновлён';

  @override
  String selectImageFailed(String error) {
    return 'Не удалось выбрать изображение: $error';
  }

  @override
  String get changeName => 'Изменить имя';

  @override
  String get male => 'Мужской';

  @override
  String get female => 'Женский';

  @override
  String genderSet(String gender) {
    return 'Пол установлен: $gender';
  }

  @override
  String regionSet(String region) {
    return 'Регион установлен: $region';
  }

  @override
  String get setPatText => 'Установить текст хлопка';

  @override
  String get changeSignature => 'Изменить подпись';

  @override
  String ringtoneSet(String result) {
    return 'Рингтон установлен: $result';
  }

  @override
  String featureInDev(String feature) {
    return '$feature в разработке...';
  }

  @override
  String saveAddressFailed(String error) {
    return 'Не удалось сохранить адрес: $error';
  }

  @override
  String get myAddress => 'Мой адрес';

  @override
  String get addNew => 'Добавить';

  @override
  String get addAddress => 'Добавить адрес';

  @override
  String get addressAdded => 'Адрес добавлен';

  @override
  String get addressUpdated => 'Адрес обновлён';

  @override
  String get deleteAddress => 'Удалить адрес';

  @override
  String get deleteAddressConfirm => 'Удалить этот адрес?';

  @override
  String get addressDeleted => 'Адрес удалён';

  @override
  String get setDefaultAddress => 'Установить по умолчанию';

  @override
  String get fillCompleteInfo => 'Пожалуйста, заполните все поля';

  @override
  String saveInvoiceFailed(String error) {
    return 'Не удалось сохранить счёт: $error';
  }

  @override
  String get myInvoices => 'Мои счета';

  @override
  String get addInvoice => 'Добавить счёт';

  @override
  String get invoiceAdded => 'Счёт добавлен';

  @override
  String get invoiceUpdated => 'Счёт обновлён';

  @override
  String get deleteInvoice => 'Удалить счёт';

  @override
  String get deleteInvoiceConfirm => 'Удалить этот счёт?';

  @override
  String get invoiceDeleted => 'Счёт удалён';

  @override
  String get invoiceType => 'Тип счёта: ';

  @override
  String get personal => 'Личный';

  @override
  String get enterprise => 'Корпоративный';

  @override
  String get setDefaultInvoice => 'Установить по умолчанию';

  @override
  String get enterTaxId => 'Введите ИНН';

  @override
  String get vibrateMode => 'Режим вибрации';

  @override
  String get silentMode => 'Беззвучный режим';

  @override
  String playing(String ringtoneName) {
    return 'Воспроизведение: $ringtoneName';
  }

  @override
  String playFailed(String ringtoneName) {
    return 'Ошибка воспроизведения: $ringtoneName';
  }

  @override
  String get enterGroupNamePlease => 'Пожалуйста, введите название группы';

  @override
  String get selectAtLeastOne =>
      'Пожалуйста, выберите хотя бы одного участника';

  @override
  String get fillStatus => 'Написать статус';

  @override
  String get fileNotExist => 'Файл не существует';

  @override
  String sendFailed(String error) {
    return 'Ошибка отправки: $error';
  }

  @override
  String get cannotOpenBrowser => 'Не удаётся открыть браузер';

  @override
  String selectFileFailed(String error) {
    return 'Не удалось выбрать файл: $error';
  }

  @override
  String get enterMusicLink => 'Введите ссылку на музыку';

  @override
  String get enterValidLink => 'Пожалуйста, введите действительную ссылку';

  @override
  String get enterPollQuestion => 'Введите вопрос опроса';

  @override
  String get minTwoOptions => 'Требуется минимум 2 варианта';

  @override
  String get crossDeviceEnabled => 'Межустройственная подпись включена';

  @override
  String get crossDeviceSet => 'Межустройственная подпись настроена успешно';

  @override
  String setupFailed(String error) {
    return 'Ошибка настройки: $error';
  }

  @override
  String get receiveAmount => 'Сумма к получению';

  @override
  String get enterValidAmount => 'Пожалуйста, введите действительную сумму';

  @override
  String get addressCopied => 'Адрес скопирован';

  @override
  String openItem(String content) {
    return 'Открыть: $content';
  }

  @override
  String get newNoteComingSoon => 'Новые заметки скоро появятся';

  @override
  String get addLinkComingSoon => 'Добавление ссылок скоро появится';

  @override
  String get deleted => 'Удалено';

  @override
  String get shareComingSoon => 'Функция отправки скоро появится';

  @override
  String get saveComingSoon => 'Функция сохранения скоро появится';

  @override
  String get moreStylesComingSoon => 'Больше стилей скоро появится';

  @override
  String get wallet => 'Кошелёк';

  @override
  String get walletArea => 'Область кошелька';

  @override
  String get recording => 'Запись';

  @override
  String get invalidVideoUrl => 'Недействительный URL видео';

  @override
  String get downloadFile => 'Скачать файл';

  @override
  String get clearChatHistoryTitle => 'Очистить историю чата';

  @override
  String get cannotUndo => 'Это действие нельзя отменить';

  @override
  String get videoCall => 'Видеовызов';

  @override
  String get voiceCall => 'Голосовой вызов';

  @override
  String get leaveMeeting => 'Покинуть конференцию';

  @override
  String get chatDetails => 'Детали чата';

  @override
  String get viewAllGroupMembers => 'Просмотреть всех участников';

  @override
  String get groupName => 'Название группы';

  @override
  String get groupNameUpdated => 'Название группы обновлено';

  @override
  String get groupDescriptionUpdated => 'Описание группы обновлено';

  @override
  String get groupAvatarUpdated => 'Аватар группы обновлен';

  @override
  String get updateFailed => 'Ошибка обновления';

  @override
  String get noPermissionToModify => 'У вас нет прав на изменение';

  @override
  String get groupManagement => 'Управление группой';

  @override
  String get myNicknameInGroup => 'Мой никнейм в группе';

  @override
  String get pinChat => 'Закрепить чат';

  @override
  String get strongReminder => 'Важное напоминание';

  @override
  String get setChatBackground => 'Установить фон чата';

  @override
  String get unknownFile => 'Неизвестный файл';

  @override
  String get download => 'Скачать';

  @override
  String get invalidLocation => 'Недействительное местоположение';

  @override
  String get address => 'Адрес';

  @override
  String get latitude => 'Широта';

  @override
  String get longitude => 'Долгота';

  @override
  String get close => 'Закрыть';

  @override
  String get tapToCancel => 'Нажмите для отмены';

  @override
  String captureFailed(Object error) {
    return 'Ошибка захвата: $error';
  }

  @override
  String get processingVideo => 'Обработка видео...';

  @override
  String get videoFileNotExist => 'Видеофайл не существует';

  @override
  String get videoDataEmpty => 'Данные видео пусты';

  @override
  String get videoTooLarge => 'Размер видео не может превышать 100 МБ';

  @override
  String get sendingVideo => 'Отправка видео...';

  @override
  String sendVideoFailed(Object error) {
    return 'Не удалось отправить видео: $error';
  }

  @override
  String get imageFileNotExist => 'Файл изображения не существует';

  @override
  String get imageDataEmpty => 'Данные изображения пусты';

  @override
  String get sendingImage => 'Отправка изображения...';

  @override
  String sendImageFailed(Object error) {
    return 'Не удалось отправить изображение: $error';
  }

  @override
  String get sendLocation => 'Отправить местоположение';

  @override
  String get selectLocationAndSend => 'Выберите местоположение и отправьте';

  @override
  String get shareRealTimeLocation =>
      'Поделиться местоположением в реальном времени';

  @override
  String get shareLocationForOneHour =>
      'Поделиться местоположением с другом на 1 час';

  @override
  String get locationSent => 'Местоположение отправлено';

  @override
  String get selectMessages => 'Выбрать сообщения';

  @override
  String selectedCount(int count) {
    return 'Выбрано $count';
  }

  @override
  String get selectAll => 'Выбрать все';

  @override
  String groupChatCount(int count) {
    return 'Групповой чат ($count)';
  }

  @override
  String get privateChat => 'Личный чат';

  @override
  String get noMessages => 'Нет сообщений';

  @override
  String get sendFirstMessage =>
      'Отправьте первое сообщение, чтобы начать общение';

  @override
  String get encryptionNotice =>
      'Этот чат защищён сквозным шифрованием. Только вы и получатель можете читать сообщения.';

  @override
  String replyTo(String name) {
    return 'Ответ $name';
  }

  @override
  String get multiForward => 'Переслать';

  @override
  String get collect => 'Собрать';

  @override
  String get noMembers => 'Нет участников';

  @override
  String get memberNotFound => 'Участник не найден';

  @override
  String get voiceFileNotExist => 'Голосовой файл не существует';

  @override
  String get voiceFileEmpty => 'Голосовой файл пуст';

  @override
  String get sendingVoice => 'Отправка голосового сообщения...';

  @override
  String sendVoiceFailed(Object error) {
    return 'Не удалось отправить голосовое сообщение: $error';
  }

  @override
  String get messageCopied => 'Сообщение скопировано';

  @override
  String get messageForwarded => 'Сообщение переслано';

  @override
  String forwardFailed(Object error) {
    return 'Ошибка пересылки: $error';
  }

  @override
  String get unfavorited => 'Удалено из избранного';

  @override
  String get favorited => 'Добавлено в избранное';

  @override
  String get reactionAdded => 'Реакция добавлена';

  @override
  String get failedMessageDeleted => 'Неотправленное сообщение удалено';

  @override
  String get deleteMessages => 'Удалить сообщения';

  @override
  String deleteMessagesConfirm(Object count) {
    return 'Вы уверены, что хотите удалить $count сообщений?';
  }

  @override
  String noteOtherMessages(Object count) {
    return 'Примечание: $count сообщений от других и будут удалены только для вас.';
  }

  @override
  String myMessagesWillBeRecalled(Object count) {
    return '$count ваших сообщений будут отозваны для всех.';
  }

  @override
  String recalledCount(Object count, Object localCount) {
    return 'Отозвано $count сообщений, $localCount удалено только для вас';
  }

  @override
  String recalledMessages(Object count) {
    return 'Отозвано $count сообщений';
  }

  @override
  String deletedLocally(Object count) {
    return '$count сообщений удалено только для вас';
  }

  @override
  String forwardedCount(Object count) {
    return 'Переслано $count сообщений';
  }

  @override
  String forwardComplete(Object failed, Object success) {
    return 'Пересылка завершена: $success успешно, $failed ошибок';
  }

  @override
  String get remindOnlyInGroup =>
      'Функция напоминания доступна только в групповом чате';

  @override
  String get onlyTextSearchable =>
      'Поиск доступен только для текстовых сообщений';

  @override
  String searchFor(Object text) {
    return 'Искать \"$text\"';
  }

  @override
  String get baiduSearch => 'Поиск Baidu';

  @override
  String get googleSearch => 'Поиск Google';

  @override
  String get bingSearch => 'Поиск Bing';

  @override
  String get calling => 'Вызов...';

  @override
  String get connecting => 'Подключение...';

  @override
  String get ringing => 'Звонок...';

  @override
  String get inCall => 'В разговоре';

  @override
  String featureInDevelopment(String feature) {
    return 'Функция в разработке...';
  }

  @override
  String collectMessages(Object count) {
    return 'Сохранено $count сообщений';
  }

  @override
  String get voted => 'Проголосовано';

  @override
  String get voteChanged => 'Голос изменён';

  @override
  String get voteRemoved => 'Голос удалён';

  @override
  String get endPoll => 'Завершить опрос';

  @override
  String get endPollConfirm =>
      'Вы уверены, что хотите завершить этот опрос? После завершения голосование будет невозможно.';

  @override
  String memberCount(int count) {
    return '$count участников';
  }

  @override
  String get videoChannels => 'Каналы';

  @override
  String get live => 'Прямой эфир';

  @override
  String get listen => 'Слушать';

  @override
  String get watch => 'Смотреть';

  @override
  String get searchDiscover => 'Поиск';

  @override
  String get nearbyPeople => 'Рядом';

  @override
  String get games => 'Игры';

  @override
  String get miniPrograms => 'Мини-программы';

  @override
  String done(int count) {
    return 'Готово($count)';
  }

  @override
  String get services => 'Сервисы';

  @override
  String get favorites => 'Избранное';

  @override
  String get ordersAndCards => 'Заказы и карты';

  @override
  String get stickers => 'Стикеры';

  @override
  String statusSetTo(String status) {
    return 'Статус установлен: $status';
  }

  @override
  String get avatarUploadFailed => 'Не удалось загрузить аватар';

  @override
  String get personalProfile => 'Личный профиль';

  @override
  String get name => 'Имя';

  @override
  String get gender => 'Пол';

  @override
  String get region => 'Регион';

  @override
  String get myQrCode => 'Мой QR-код';

  @override
  String get poke => 'Толкнуть';

  @override
  String get ringtone => 'Рингтон';

  @override
  String get defaultRingtone => 'Рингтон по умолчанию';

  @override
  String get myAddresses => 'Мои адреса';

  @override
  String genderSetTo(String gender) {
    return 'Пол установлен: $gender';
  }

  @override
  String get selectRegion => 'Выбрать регион';

  @override
  String get selectCity => 'Выбрать город';

  @override
  String regionSetTo(String region) {
    return 'Регион установлен: $region';
  }

  @override
  String get setPoke => 'Настроить толчок';

  @override
  String get friendPokedMe => 'Друг толкнул меня';

  @override
  String get enterPokeSuffix => 'Введите суффикс, например: по плечу';

  @override
  String get example => 'Пример';

  @override
  String get onTheShoulder => ' по плечу';

  @override
  String get pokeCleared => 'Толчок сброшен';

  @override
  String pokeSetTo(String suffix) {
    return 'Толчок установлен: толкнул меня$suffix';
  }

  @override
  String get editSignature => 'Редактировать подпись';

  @override
  String get introduceYourself => 'Предложение, чтобы представить себя';

  @override
  String get signatureCleared => 'Подпись удалена';

  @override
  String get signatureUpdated => 'Подпись обновлена';

  @override
  String get scanToAddFriend =>
      'Отсканируйте QR-код выше, чтобы добавить меня в друзья';

  @override
  String ringtoneSetTo(String ringtone) {
    return 'Рингтон установлен: $ringtone';
  }

  @override
  String confirmDissolveGroup(String name) {
    return 'Вы уверены, что хотите расформировать «$name»? Это действие нельзя отменить.';
  }

  @override
  String get enterValidServerAddress =>
      'Пожалуйста, введите действительный адрес сервера';

  @override
  String get emailOtp => 'Код подтверждения по email';

  @override
  String get enterServerAddressFirst => 'Сначала введите адрес сервера';

  @override
  String get passkeyRequiresServer =>
      'Для входа через Passkey требуется поддержка сервера';

  @override
  String get loginAgreement => 'Входя в систему, вы соглашаетесь с ';

  @override
  String get pleaseAgreeToTerms =>
      'Пожалуйста, прочитайте и согласитесь с Условиями использования и Политикой конфиденциальности';

  @override
  String get registerFailed => 'Ошибка регистрации';

  @override
  String get reenterPassword => 'Введите пароль повторно';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get inviteCodeBuiltIn => 'Код приглашения (встроенный)';

  @override
  String get inviteCodeBuiltInNote =>
      'Код приглашения встроен, обычно изменять не требуется';

  @override
  String get iHaveReadAndAgree => 'Я прочитал и согласен с ';

  @override
  String get startGroupChat => 'Создать групповой чат';

  @override
  String get addFriends => 'Добавить друзей';

  @override
  String get paymentAndCollection => 'Оплата';

  @override
  String messagesWithCount(int count) {
    return 'Сообщения($count)';
  }

  @override
  String contactCount(int count) {
    return '$count контактов';
  }

  @override
  String get addToHomeScreen => 'Добавить на главный экран';

  @override
  String recommendedCardTo(String contact, String recipient) {
    return 'Рекомендовано карточка $contact для $recipient';
  }

  @override
  String get enterRemarkName => 'Введите имя заметки';

  @override
  String remarkSetTo(String remark) {
    return 'Заметка установлена: $remark';
  }

  @override
  String acceptedFriendRequest(String name) {
    return 'Принят запрос в друзья от $name';
  }

  @override
  String rejectedFriendRequest(String name) {
    return 'Отклонён запрос в друзья от $name';
  }

  @override
  String get groupInvites => 'Приглашения в группы';

  @override
  String myGroups(int count) {
    return 'Мои группы ($count)';
  }

  @override
  String get invitedToJoinGroup => 'Приглашён в группу';

  @override
  String confirmLeaveGroup(String name) {
    return 'Вы уверены, что хотите покинуть «$name»?';
  }

  @override
  String get leave => 'Покинуть';

  @override
  String get saveMedia => 'Сохранить';

  @override
  String get recallThisMessage => 'Отозвать это сообщение?';

  @override
  String get messageRecalled => 'Сообщение отозвано';

  @override
  String get savedToGallery => 'Сохранено в галерею';

  @override
  String get failedToSave => 'Ошибка сохранения';

  @override
  String get saving => 'Сохранение...';

  @override
  String get share => 'Поделиться';

  @override
  String get saveToGallery => 'Сохранить в галерею';

  @override
  String downloadFailed(String code) {
    return 'Ошибка загрузки: $code';
  }

  @override
  String get noMediaUrl => 'URL медиа недоступен';

  @override
  String shareFailed(String error) {
    return 'Ошибка при отправке: $error';
  }

  @override
  String get failedToLoadImage => 'Не удалось загрузить изображение';

  @override
  String get failedToLoadMoreMessages =>
      'Не удалось загрузить больше сообщений';

  @override
  String get failedToSend => 'Не удалось отправить';

  @override
  String get failedToSendImage => 'Не удалось отправить изображение';

  @override
  String get failedToSendVoice => 'Не удалось отправить голосовое сообщение';

  @override
  String get failedToSendFile => 'Не удалось отправить файл';

  @override
  String get failedToSendVideo => 'Не удалось отправить видео';

  @override
  String get failedToSendLocation => 'Не удалось отправить местоположение';

  @override
  String get failedToResend => 'Не удалось отправить повторно';

  @override
  String get failedToRecall => 'Не удалось отозвать';

  @override
  String get failedToReply => 'Не удалось ответить';

  @override
  String get failedToAddReaction => 'Не удалось добавить реакцию';

  @override
  String get failedToSendPoll => 'Не удалось отправить опрос';

  @override
  String get failedToVote => 'Не удалось проголосовать';

  @override
  String get failedToLoadMessages => 'Не удалось загрузить сообщения';

  @override
  String get callFeatureComingSoon => 'Голосовые и видеовызовы скоро появятся';

  @override
  String get cannotForwardRedPacketOrTransfer =>
      'Красные конверты и переводы нельзя пересылать';

  @override
  String get videoRecordingFailed =>
      'Ошибка записи видео. Пожалуйста, попробуйте снова.';

  @override
  String get redPacket => 'Красный конверт';

  @override
  String get music => 'Музыка';

  @override
  String get coupon => 'Купон';

  @override
  String get gift => 'Подарок';

  @override
  String get poll => 'Опрос';

  @override
  String get text => 'Текст';

  @override
  String get link => 'Ссылка';

  @override
  String get note => 'Заметка';

  @override
  String get myNotes => 'Мои заметки';

  @override
  String get today => 'Сегодня';

  @override
  String daysAgoText(int count) {
    return '$count дней назад';
  }

  @override
  String dateFormat(int month, int day) {
    return '$day.$month';
  }

  @override
  String get noFavorites => 'Пока нет избранного';

  @override
  String get longPressToFavorite =>
      'Нажмите и удерживайте сообщение, чтобы добавить в избранное';

  @override
  String get newNote => 'Новая заметка';

  @override
  String get favoriteLink => 'Добавить ссылку в избранное';

  @override
  String get editTags => 'Редактировать теги';

  @override
  String get deleteFavorite => 'Удалить из избранного';

  @override
  String get deleteFavoriteConfirm =>
      'Вы уверены, что хотите удалить это из избранного?';

  @override
  String get noSearchResultsFound => 'Результаты не найдены';

  @override
  String get sendRedPacket => 'Отправить красный конверт';

  @override
  String get amount => 'Сумма';

  @override
  String get redPacketCover => 'Обложка красного конверта';

  @override
  String get redPacketType => 'Тип красного конверта';

  @override
  String get normalRedPacket => 'Обычный';

  @override
  String get luckyRedPacket => 'Счастливый';

  @override
  String get redPacketCount => 'Количество конвертов';

  @override
  String get pieces => 'штук';

  @override
  String get putMoneyInRedPacket => 'Положить деньги в красный конверт';

  @override
  String get redPacketRefundNotice =>
      'Неполученные красные конверты будут возвращены через 24 часа';

  @override
  String get openRedPacket => 'Открыть';

  @override
  String get redPacketAllClaimed => 'Все красные конверты получены';

  @override
  String get redPacketExpired => 'Красный конверт истёк';

  @override
  String get addTransferNote => 'Добавить примечание к переводу';

  @override
  String get yuan => 'руб.';

  @override
  String get savedToChangeCanTransfer =>
      'Сохранено на баланс, можно переводить напрямую';

  @override
  String get replyWithEmoji => 'Ответить этим эмодзи';

  @override
  String get claimedYourRedPacket => 'получил(а) ваш';

  @override
  String get claimedRedPacket => 'получил(а)';

  @override
  String get otherTyping => 'печатает...';

  @override
  String get processing => 'Обработка...';

  @override
  String get transferCancelled => 'Перевод отменён';

  @override
  String get transferFailed => 'Ошибка перевода';

  @override
  String get creatingPaymentRequest => 'Создание запроса на оплату...';

  @override
  String get processingPayment => 'Обработка платежа...';

  @override
  String get paymentFailed => 'Ошибка платежа';

  @override
  String get clickRetry => 'Нажмите, чтобы повторить';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get editRemark => 'Редактировать заметку';

  @override
  String get setPermissions => 'Установить разрешения';

  @override
  String get recommendToFriends => 'Рекомендовать друзьям';

  @override
  String get setStarFriend => 'Отметить как важного друга';

  @override
  String get addToBlacklist => 'Добавить в чёрный список';

  @override
  String get complain => 'Пожаловаться';

  @override
  String get deleteContact => 'Удалить контакт';

  @override
  String deleteContactConfirm(String name) {
    return 'Вы уверены, что хотите удалить $name?';
  }

  @override
  String get transferTitle => 'Перевод';

  @override
  String get receiverAddressLabel => 'Адрес получателя';

  @override
  String get selectTokenLabel => 'Выбрать токен';

  @override
  String get transferAmountLabel => 'Сумма перевода';

  @override
  String get memoLabel => 'Примечание (необязательно)';

  @override
  String get enterOrPasteAddressHint => 'Введите или вставьте адрес кошелька';

  @override
  String get scanInDevelopment => 'Функция сканирования в разработке...';

  @override
  String get availableLabel => 'Доступно';

  @override
  String availableBalanceFormat(String balance, String symbol) {
    return 'Доступно: $balance $symbol';
  }

  @override
  String get addMemoHint => 'Добавить примечание';

  @override
  String get receiveTitle => 'Получить';

  @override
  String get walletNotConnectedTitle => 'Кошелёк не подключён';

  @override
  String get connectWalletFirst => 'Сначала подключите кошелёк';

  @override
  String get sendPaymentRequest => 'Отправить запрос на оплату';

  @override
  String get qrCodeGenerateFailed => 'Ошибка генерации QR-кода';

  @override
  String get scanQrToPayMe => 'Отсканируйте QR-код, чтобы оплатить мне';

  @override
  String get myWalletAddress => 'Адрес моего кошелька';

  @override
  String get createPaymentRequest => 'Создать запрос на оплату';

  @override
  String get selectTokenHint => 'Выбрать токен';

  @override
  String get amountLabel => 'Сумма';

  @override
  String get cancelButton => 'Отмена';

  @override
  String get sendRequestButton => 'Отправить запрос';

  @override
  String get allReadReceipt => 'Все прочитаны';

  @override
  String readCountReceipt(int count) {
    return '$count прочитано';
  }

  @override
  String n42IdLabel(String id) {
    return 'N42 ID: $id';
  }

  @override
  String get redPacketDefaultGreeting => 'С наилучшими пожеланиями';

  @override
  String senderRedPacket(String name) {
    return 'Красный конверт от $name';
  }

  @override
  String get allButton => 'Все';

  @override
  String get enterValidAddress => 'Пожалуйста, введите действительный адрес';

  @override
  String get pleaseSelectToken => 'Пожалуйста, выберите токен';

  @override
  String get receivedTransfer => 'Полученный перевод';

  @override
  String get selectForwardRecipient => 'Выберите получателя для пересылки';

  @override
  String get emojiFaces => 'Лица';

  @override
  String get emojiHearts => 'Сердечки';

  @override
  String get emojiAnimals => 'Животные';

  @override
  String get emojiFood => 'Еда';

  @override
  String get emojiTransport => 'Транспорт';

  @override
  String get emojiActivities => 'Активность';

  @override
  String get emojiObjects => 'Предметы';

  @override
  String get emojiSymbols => 'Символы';

  @override
  String get transferProcessing => 'Обработка перевода...';

  @override
  String senderSentRedPacket(String name) {
    return '$name отправил(а) красный конверт';
  }

  @override
  String get savedToBalance => 'Сохранено на баланс, можно переводить напрямую';

  @override
  String get redPacketExpiredOrEmpty => 'Красный конверт истёк/все получены';

  @override
  String get scanFeatureComingSoon => 'Функция сканирования скоро появится...';

  @override
  String get setAsStarred => 'Отметить как важного';

  @override
  String get addToBlocklist => 'Добавить в чёрный список';

  @override
  String get claimedYour => ' получил(а) ваш ';

  @override
  String get claimedText => ' получил(а) ';

  @override
  String userTyping(String name) {
    return '$name печатает...';
  }

  @override
  String get typing => 'Печатает...';

  @override
  String get waitingToReceive => 'Ожидание получения';

  @override
  String get tapToClaim => 'Нажмите, чтобы получить';

  @override
  String get hasBeenReceived => 'Получено';

  @override
  String get getLucky => 'Удачи';

  @override
  String get cameraStartFailed => 'Не удалось запустить камеру';

  @override
  String get unknownError => 'Неизвестная ошибка';

  @override
  String get placeQrCodeInFrame => 'Поместите QR-код в рамку для сканирования';

  @override
  String get closeManualInput => 'Закрыть ручной ввод';

  @override
  String get manualInputUserId => 'Ввести ID пользователя вручную';

  @override
  String get add => 'Добавить';

  @override
  String get ringtoneClear => 'Очистить';

  @override
  String get ringtonePhone => 'Телефон';

  @override
  String get ringtoneClassic => 'Классический';

  @override
  String get ringtoneSoft => 'Мягкий';

  @override
  String get ringtoneVibrate => 'Вибрация';

  @override
  String get ringtoneSilent => 'Беззвучный';

  @override
  String get stop => 'Стоп';

  @override
  String get selectRingtone => 'Выбрать рингтон';

  @override
  String get loadingRingtones => 'Загрузка рингтонов...';

  @override
  String get noRingtonesFound => 'Рингтоны не найдены';

  @override
  String get moodAndThoughts => 'Настроение и мысли';

  @override
  String get statusHappy => 'Счастлив';

  @override
  String get statusCracked => 'Разбит';

  @override
  String get statusLucky => 'Везучий';

  @override
  String get statusSunny => 'Солнечный';

  @override
  String get statusTired => 'Усталый';

  @override
  String get statusDaydream => 'Мечтаю';

  @override
  String get statusRushing => 'Спешу';

  @override
  String get statusOverthinking => 'Задумался';

  @override
  String get statusEnergized => 'Энергичный';

  @override
  String get workAndStudy => 'Работа и учёба';

  @override
  String get statusWorking => 'Работаю';

  @override
  String get statusStudying => 'Учусь';

  @override
  String get statusBusy => 'Занят';

  @override
  String get statusSlacking => 'Ленюсь';

  @override
  String get statusTraveling => 'Путешествую';

  @override
  String get statusGoingHome => 'Иду домой';

  @override
  String get statusDnd => 'Не беспокоить';

  @override
  String get statusHanging => 'Отдыхаю';

  @override
  String get statusCheckIn => 'Отметка';

  @override
  String get statusExercising => 'Тренируюсь';

  @override
  String get statusCoffee => 'Кофе';

  @override
  String get statusBubbleTea => 'Чай с пузырьками';

  @override
  String get statusEating => 'Ем';

  @override
  String get statusParenting => 'С детьми';

  @override
  String get statusSavingWorld => 'Спасаю мир';

  @override
  String get statusSelfie => 'Селфи';

  @override
  String get rest => 'Отдых';

  @override
  String get statusRetreat => 'Уединение';

  @override
  String get statusHome => 'Дома';

  @override
  String get statusSleeping => 'Сплю';

  @override
  String get statusCatLover => 'Люблю кошек';

  @override
  String get statusDogWalking => 'Гуляю с собакой';

  @override
  String get statusGaming => 'Играю';

  @override
  String get statusListening => 'Слушаю музыку';

  @override
  String get setStatus => 'Установить статус';

  @override
  String get visibleToFriends24h => 'Виден друзьям в течение 24 часов';

  @override
  String get writeStatus => 'Написать статус';

  @override
  String get enterYourStatus => 'Введите ваш статус...';

  @override
  String get ok => 'ОК';

  @override
  String get cameraPermissionRequired =>
      'Для сканирования QR-кода требуется разрешение камеры';

  @override
  String get cameraPermissionDenied =>
      'Разрешение камеры отклонено навсегда. Пожалуйста, включите его в настройках системы.';

  @override
  String get cannotGetCameraPermission =>
      'Не удаётся получить разрешение камеры';

  @override
  String permissionCheckError(String error) {
    return 'Ошибка проверки разрешения: $error';
  }

  @override
  String get invalidQrCode => 'Недействительный QR-код';

  @override
  String qrCodeProcessFailed(String error) {
    return 'Не удалось обработать QR-код: $error';
  }

  @override
  String cannotAddFriend(String error) {
    return 'Не удаётся добавить друга: $error';
  }

  @override
  String get scanQrCode => 'Сканировать QR-код';

  @override
  String get checkingCameraPermission => 'Проверка разрешения камеры...';

  @override
  String get needCameraPermission => 'Требуется разрешение камеры';

  @override
  String get retryPermission => 'Повторить';

  @override
  String get openSettings => 'Открыть настройки';

  @override
  String get inviteMembers => 'Пригласить участников';

  @override
  String inviteCount(int count) {
    return 'Пригласить($count)';
  }

  @override
  String get noShippingAddress => 'Нет адреса доставки';

  @override
  String get defaultLabel => 'По умолчанию';

  @override
  String get editAddress => 'Редактировать адрес';

  @override
  String get recipient => 'Получатель';

  @override
  String get enterRecipientName => 'Введите имя получателя';

  @override
  String get phoneNumber => 'Номер телефона';

  @override
  String get enterPhoneNumber => 'Введите номер телефона';

  @override
  String get regionHint => 'Область/Город/Район';

  @override
  String get detailedAddress => 'Подробный адрес';

  @override
  String get detailedAddressHint => 'Улица, номер дома и т.д.';

  @override
  String get setAsDefaultAddress => 'Установить как адрес по умолчанию';

  @override
  String get pleaseCompleteInfo => 'Пожалуйста, заполните все поля';

  @override
  String get noInvoice => 'Нет счёта';

  @override
  String get company => 'Компания';

  @override
  String get taxNumber => 'ИНН';

  @override
  String get editInvoice => 'Редактировать счёт';

  @override
  String get companyName => 'Название компании';

  @override
  String get enterCompanyName => 'Введите название компании';

  @override
  String get personalName => 'Имя';

  @override
  String get enterName => 'Введите имя';

  @override
  String get taxIdNumber => 'ИНН';

  @override
  String get enterTaxIdNumber => 'Введите ИНН';

  @override
  String get bankNameOptional => 'Название банка (необязательно)';

  @override
  String get enterBankName => 'Введите название банка';

  @override
  String get bankAccountOptional => 'Номер счёта (необязательно)';

  @override
  String get enterBankAccount => 'Введите номер счёта';

  @override
  String get companyAddressOptional => 'Адрес компании (необязательно)';

  @override
  String get enterCompanyAddress => 'Введите адрес компании';

  @override
  String get companyPhoneOptional => 'Телефон компании (необязательно)';

  @override
  String get enterCompanyPhone => 'Введите телефон компании';

  @override
  String get setAsDefaultInvoice => 'Установить как счёт по умолчанию';

  @override
  String get confirmDeleteAddress =>
      'Вы уверены, что хотите удалить этот адрес?';

  @override
  String get confirmDeleteInvoice =>
      'Вы уверены, что хотите удалить этот счёт?';

  @override
  String get groupOwner => 'Владелец';

  @override
  String get groupAdmin => 'Администратор';

  @override
  String get searchMembers => 'Поиск участников';

  @override
  String totalMembers(int count) {
    return '$count участников';
  }

  @override
  String get removeFromGroup => 'Удалить из группы';

  @override
  String confirmRemoveMember(String name) {
    return 'Вы уверены, что хотите удалить \"$name\" из группы?';
  }

  @override
  String get setAsAdmin => 'Назначить администратором';

  @override
  String get removeAdmin => 'Снять права администратора';

  @override
  String get deleteContactSuccess => 'Контакт удалён';

  @override
  String get unknownSong => 'Неизвестная песня';

  @override
  String get unknownArtist => 'Неизвестный исполнитель';

  @override
  String get unknownContact => 'Неизвестный контакт';

  @override
  String get personalCard => 'Контактная карточка';

  @override
  String get singleChoice => 'Один';

  @override
  String get multiChoice => 'Несколько';

  @override
  String get ended => 'Завершён';

  @override
  String get endPollButton => 'Завершить опрос';

  @override
  String get createPoll => 'Создать опрос';

  @override
  String get pollQuestion => 'Вопрос опроса';

  @override
  String get pollOptions => 'Варианты ответа';

  @override
  String optionPlaceholder(int index) {
    return 'Вариант $index';
  }

  @override
  String get addOption => 'Добавить вариант';

  @override
  String get pollSettings => 'Настройки опроса';

  @override
  String get anonymousPoll => 'Анонимный опрос';

  @override
  String get pollHint =>
      'Опрос будет отображён в чате. Участники группы смогут голосовать.';

  @override
  String get searchSongOrArtist => 'Поиск песни или исполнителя';

  @override
  String get noSongsFound => 'Песни не найдены';

  @override
  String get supportedMusicPlatforms =>
      'Поддерживаются музыкальные ссылки с NetEase, QQ Music и т.д.';

  @override
  String get songNameOptional => 'Название песни (необязательно)';

  @override
  String get enterSongName => 'Введите название песни';

  @override
  String get artistNameOptional => 'Исполнитель (необязательно)';

  @override
  String get enterArtistName => 'Введите имя исполнителя';

  @override
  String get shareSong => 'Поделиться песней';

  @override
  String get realTimeLocationSharing =>
      'Отправка местоположения в реальном времени в разработке...';

  @override
  String get voiceCallFeatureInDev => 'Голосовой вызов в разработке...';

  @override
  String get reportFeatureInDev => 'Функция жалобы в разработке...';

  @override
  String get shareFeatureInDev => 'Функция отправки в разработке...';

  @override
  String get qrCodeFeatureInDev => 'Функция QR-кода в разработке...';

  @override
  String get scanQrToAddMe =>
      'Отсканируйте QR-код выше, чтобы добавить меня в друзья';

  @override
  String get saveToAlbum => 'Сохранить в альбом';

  @override
  String get changeStyle => 'Изменить стиль';

  @override
  String get copyId => 'Копировать ID';

  @override
  String get idCopied => 'ID скопирован';

  @override
  String get shareFeatureComingSoon => 'Функция отправки скоро появится';

  @override
  String get saveFeatureComingSoon => 'Функция сохранения скоро появится';

  @override
  String get moreStylesFeatureComingSoon => 'Больше стилей скоро появится';

  @override
  String get confirmEndPoll => 'Вы уверены, что хотите завершить этот опрос?';

  @override
  String get cannotVoteAfterEnd =>
      'После завершения голосование будет невозможно.';

  @override
  String get bio => 'О себе';

  @override
  String get homeServer => 'Сервер';

  @override
  String get shareContactCard => 'Поделиться контактной карточкой';

  @override
  String get removeFromBlacklist => 'Удалить из чёрного списка';

  @override
  String get confirmAddBlacklist =>
      'Вы уверены, что хотите добавить этого пользователя в чёрный список? Вы не будете получать от него сообщения.';

  @override
  String get confirmRemoveBlacklist =>
      'Вы уверены, что хотите удалить этого пользователя из чёрного списка?';

  @override
  String get remarkSaved => 'Заметка сохранена';

  @override
  String get remarkCleared => 'Заметка удалена';

  @override
  String get receive => 'Получить';

  @override
  String get pleaseConnectWallet => 'Сначала подключите ваш кошелёк';

  @override
  String get sendRequest => 'Отправить запрос';

  @override
  String get pleaseEnterValidAmount =>
      'Пожалуйста, введите действительную сумму';

  @override
  String get searchPlaceholder => 'Поиск контактов, групп, сообщений';

  @override
  String get enterKeywordToSearch => 'Введите ключевое слово для поиска';

  @override
  String get clearHistory => 'Очистить';

  @override
  String noResultsForQuery(String query) {
    return 'Результаты не найдены для \"$query\"';
  }

  @override
  String get allResults => 'Все';

  @override
  String get searchInChat => 'Поиск в чате';

  @override
  String get contactLabel => 'Контакт';

  @override
  String get groupLabel => 'Группа';

  @override
  String get conversationLabel => 'Беседа';

  @override
  String get messageLabel => 'Сообщение';

  @override
  String get securityTitle => 'Безопасность';

  @override
  String get keyBackup => 'Резервное копирование ключей';

  @override
  String get backupEncryptionKeys => 'Резервное копирование ключей шифрования';

  @override
  String keysBackedUp(int count) {
    return '$count ключей сохранено';
  }

  @override
  String get backupNotSet => 'Резервная копия не настроена';

  @override
  String get restoreKeys => 'Восстановить ключи';

  @override
  String get restoreKeysFromBackup =>
      'Восстановить ключи шифрования из резервной копии';

  @override
  String get exportKeys => 'Экспортировать ключи';

  @override
  String get exportKeysToFile => 'Экспортировать ключи в файл';

  @override
  String get loggedInDevices => 'Авторизованные устройства';

  @override
  String get noOtherDevices => 'Нет других устройств';

  @override
  String get verified => 'Подтверждено';

  @override
  String get unverified => 'Не подтверждено';

  @override
  String get advanced => 'Дополнительно';

  @override
  String get crossSigning => 'Кросс-подпись';

  @override
  String get enabled => 'Включено';

  @override
  String get notEnabled => 'Не включено';

  @override
  String get resetEncryption => 'Сбросить шифрование';

  @override
  String get deleteAllEncryptionKeys => 'Удалить все ключи шифрования';

  @override
  String get encryptionNotSupported => 'Шифрование не поддерживается';

  @override
  String get notInitialized => 'Не инициализировано';

  @override
  String get backupKeyTitle => 'Резервное копирование ключей';

  @override
  String get backupKeyMessage =>
      'Создать новую резервную копию ключей? Это поможет восстановить зашифрованные сообщения на новом устройстве.';

  @override
  String get backup => 'Сохранить';

  @override
  String get restoreKeyTitle => 'Восстановить ключи';

  @override
  String get restoreKeyMessage =>
      'Введите пароль восстановления или ключ восстановления для восстановления зашифрованных сообщений.';

  @override
  String get restore => 'Восстановить';

  @override
  String get exportKeyTitle => 'Экспортировать ключи';

  @override
  String get exportKeyMessage =>
      'Экспортируемый файл ключей содержит все ваши ключи шифрования. Пожалуйста, храните его в безопасном месте.';

  @override
  String get export => 'Экспорт';

  @override
  String deviceIdLabel(String deviceId) {
    return 'ID устройства: $deviceId';
  }

  @override
  String get deviceStatusVerified => 'Статус: Подтверждено';

  @override
  String get deviceStatusUnverified => 'Статус: Не подтверждено';

  @override
  String lastActiveLabel(String lastSeen) {
    return 'Последняя активность: $lastSeen';
  }

  @override
  String get verifyThisDevice => 'Подтвердить это устройство';

  @override
  String get crossSigningAlreadyEnabled => 'Кросс-подпись уже включена';

  @override
  String get crossSigningSetupSuccess => 'Кросс-подпись успешно настроена';

  @override
  String get resetEncryptionTitle => 'Сбросить шифрование';

  @override
  String get resetEncryptionWarning =>
      'Внимание: Это удалит все ваши ключи шифрования. Вы не сможете расшифровать ранее зашифрованные сообщения. Это действие нельзя отменить.';

  @override
  String get reset => 'Сбросить';

  @override
  String get leaveMeetingConfirm =>
      'Вы уверены, что хотите покинуть конференцию?';

  @override
  String pokedSomeone(String name, String suffix) {
    return 'толкнул $name$suffix';
  }

  @override
  String get noContactsToAdd => 'Нет доступных контактов для добавления';

  @override
  String get addMembers => 'Добавить участников';

  @override
  String invitedMembers(int count) {
    return 'Приглашено $count участников';
  }

  @override
  String inviteFailed(String error) {
    return 'Ошибка приглашения: $error';
  }

  @override
  String get memberRemoved => 'Участник удалён';

  @override
  String removeFailed(String error) {
    return 'Ошибка удаления: $error';
  }

  @override
  String get realTimeLocationShareMessage =>
      'После отправки другая сторона сможет видеть ваше местоположение в течение 1 часа.';

  @override
  String get startSharing => 'Начать отправку';

  @override
  String get locationServiceNotEnabled => 'Служба геолокации не включена';

  @override
  String get enableLocationService =>
      'Пожалуйста, включите службу геолокации для использования этой функции';

  @override
  String get goToSettings => 'Перейти в настройки';

  @override
  String get locationPermissionRequired =>
      'Для этой функции требуется разрешение на определение местоположения';

  @override
  String get locationPermissionDeniedPermanent =>
      'Разрешение на определение местоположения отклонено навсегда. Пожалуйста, включите его в настройках.';

  @override
  String get locationPermissionDenied =>
      'Разрешение на определение местоположения отклонено';

  @override
  String get gettingLocation => 'Получение местоположения...';

  @override
  String getLocationFailed(String error) {
    return 'Не удалось получить местоположение: $error';
  }

  @override
  String get currentLocation => 'Текущее местоположение';

  @override
  String nearbyPlace(int index) {
    return 'Место поблизости $index';
  }

  @override
  String approximateDistance(String distance) {
    return 'Примерно $distance';
  }

  @override
  String get mapPreview => 'Предпросмотр карты';

  @override
  String get searchLocation => 'Поиск местоположения';

  @override
  String redPacketSent(String amount, String token) {
    return 'Отправлен красный конверт на $amount $token';
  }

  @override
  String get transferDefault => 'Перевод';

  @override
  String transferSent(String amount, String token) {
    return 'Отправлен перевод на $amount $token';
  }

  @override
  String pickFileFailed(String error) {
    return 'Не удалось выбрать файл: $error';
  }

  @override
  String get fileSizeLimit => 'Размер файла не может превышать 50 МБ';

  @override
  String fileSending(String filename) {
    return 'Отправка файла: $filename';
  }

  @override
  String sendFileFailed(String error) {
    return 'Не удалось отправить файл: $error';
  }

  @override
  String contactCardSent(String name) {
    return 'Отправлена контактная карточка $name';
  }

  @override
  String get favoritesFeature => 'Избранное';

  @override
  String get couponsFeature => 'Купоны';

  @override
  String get giftFeature => 'Подарок';

  @override
  String sharedMusic(String name) {
    return 'Поделился $name';
  }

  @override
  String get endPollTitle => 'Завершить опрос';

  @override
  String get endPollConfirmMessage =>
      'Вы уверены, что хотите завершить этот опрос? После завершения голосование будет закрыто.';

  @override
  String get pollEndedMessage => 'Опрос завершён';

  @override
  String get connectingCall => 'Подключение...';

  @override
  String get muteCall => 'Без звука';

  @override
  String get speakerOff => 'Динамик выкл';

  @override
  String get speakerOn => 'Динамик';

  @override
  String get cameraOn => 'Камера вкл';

  @override
  String get cameraOff => 'Камера выкл';

  @override
  String get hangUp => 'Завершить';

  @override
  String get selectForwardTargetTitle => 'Выбрать получателя';

  @override
  String get noForwardableChat => 'Нет доступных чатов для пересылки';

  @override
  String get noMatchingChat => 'Подходящие чаты не найдены';

  @override
  String get imagePreview => '[Изображение]';

  @override
  String get voicePreview => '[Голосовое сообщение]';

  @override
  String get videoPreview => '[Видео]';

  @override
  String filePreviewWithName(String filename) {
    return '[Файл] $filename';
  }

  @override
  String locationPreviewWithAddress(String address) {
    return '[Местоположение] $address';
  }

  @override
  String musicPreviewWithTitle(String title) {
    return '[Музыка] $title';
  }

  @override
  String get messagePreview => '[Сообщение]';

  @override
  String get locationTitle => 'Местоположение';

  @override
  String get sendButton => 'Отправить';

  @override
  String get retryButton => 'Повторить';

  @override
  String get selectContact => 'Выбрать контакт';

  @override
  String get searchContactHint => 'Поиск контактов';

  @override
  String get shareMusic => 'Поделиться музыкой';

  @override
  String get recentPlayed => 'Недавние';

  @override
  String get myFavorites => 'Избранное';

  @override
  String get networkLink => 'Ссылка';

  @override
  String get localFile => 'Локальный';

  @override
  String get musicLinkRequired => 'Ссылка на музыку *';

  @override
  String get pasteMusicLink => 'Вставьте ссылку на музыку';

  @override
  String get enterSongNamePlaceholder => 'Введите название песни';

  @override
  String get enterArtistNamePlaceholder => 'Введите имя исполнителя';

  @override
  String get shareMusicButton => 'Поделиться музыкой';

  @override
  String get selectLocalAudio => 'Выбрать локальный аудиофайл';

  @override
  String get supportedAudioFormats =>
      'Поддерживаются MP3, M4A, WAV, FLAC и др.';

  @override
  String get selectFileButton => 'Выбрать файл';

  @override
  String get pleaseEnterMusicLink => 'Пожалуйста, введите ссылку на музыку';

  @override
  String get pleaseEnterValidLink => 'Пожалуйста, введите действительный URL';

  @override
  String get sharedSong => 'Поделился песней';

  @override
  String get selectMember => 'Выбрать участника';

  @override
  String get searchMemberHint => 'Поиск участников';

  @override
  String get noMatchingMembers => 'Подходящие участники не найдены';

  @override
  String get unknownMember => 'Неизвестно';

  @override
  String selectedMessagesCount(int count) {
    return 'Выбрано $count сообщений';
  }

  @override
  String get searchContactsOrGroups => 'Поиск контактов или групп';

  @override
  String get noMatchingConversations => 'Подходящие разговоры не найдены';

  @override
  String get videoTitle => 'Видео';

  @override
  String get loadingText => 'Загрузка...';

  @override
  String get videoPlaybackFailed => 'Ошибка воспроизведения видео';

  @override
  String get videoLoadFailed => 'Ошибка загрузки видео';

  @override
  String get playerInitFailed => 'Ошибка инициализации плеера';

  @override
  String get createPollTitle => 'Создать опрос';

  @override
  String get submitPoll => 'Отправить';

  @override
  String get pollQuestionLabel => 'Вопрос опроса';

  @override
  String get enterPollQuestionHint => 'Пожалуйста, введите вопрос опроса';

  @override
  String get pollOptionsLabel => 'Варианты ответа';

  @override
  String optionHintWithIndex(int index) {
    return 'Вариант $index';
  }

  @override
  String get addOptionButton => 'Добавить вариант';

  @override
  String get pollSettingsLabel => 'Настройки опроса';

  @override
  String get selectionType => 'Тип выбора';

  @override
  String get singleChoiceLabel => 'Один';

  @override
  String get multiChoiceLabel => 'Несколько';

  @override
  String get anonymousPollSwitch => 'Анонимный опрос';

  @override
  String get pleaseEnterQuestion => 'Пожалуйста, введите вопрос опроса';

  @override
  String get atLeastTwoOptions => 'Требуется минимум 2 варианта';

  @override
  String confirmWithCount(int count) {
    return 'Подтвердить ($count)';
  }

  @override
  String get emailVerificationTitle => 'Подтверждение email';

  @override
  String get enterValidEmailAddress =>
      'Пожалуйста, введите действительный email адрес';

  @override
  String verificationCodeSentTo(String email) {
    return 'Код подтверждения отправлен на $email';
  }

  @override
  String sendCodeFailed(String error) {
    return 'Не удалось отправить код: $error';
  }

  @override
  String get verificationSuccess => 'Проверка успешна';

  @override
  String get verificationFailed => 'Проверка не удалась';

  @override
  String verificationCodeError(String error) {
    return 'Ошибка кода подтверждения: $error';
  }

  @override
  String get enterVerificationCode => 'Введите код подтверждения';

  @override
  String get enterYourEmail => 'Введите email';

  @override
  String weSentCodeTo(String email) {
    return 'Мы отправили 6-значный код на\n$email';
  }

  @override
  String get enterEmailForCode =>
      'Введите ваш email адрес, мы отправим код подтверждения';

  @override
  String get sendVerificationCode => 'Отправить код подтверждения';

  @override
  String get resendVerificationCode => 'Отправить код повторно';

  @override
  String canResendAfter(int seconds) {
    return 'Повторная отправка через $seconds секунд';
  }

  @override
  String get changeEmail => 'Изменить email';

  @override
  String get addToContacts => 'Добавить в контакты';

  @override
  String get addingToContacts => 'Добавление...';

  @override
  String get addedToContacts => 'Добавлено в контакты';

  @override
  String addFailedWithError(String error) {
    return 'Ошибка добавления: $error';
  }

  @override
  String get addPhone => 'Добавить телефон';

  @override
  String get addTag => 'Добавить теги';

  @override
  String get addText => 'Добавить текст';

  @override
  String get addPhoto => 'Добавить фото';

  @override
  String groupCountLabel(int count) {
    return '$count групп';
  }

  @override
  String get addedViaSearch => 'Добавлен через поиск';

  @override
  String get addTime => 'Добавить время';

  @override
  String get doneButton => 'Готово';

  @override
  String get waitingForParticipants => 'Ожидание присоединения участников...';

  @override
  String participantMe(String name) {
    return '$name (Я)';
  }

  @override
  String get sharingLabel => 'Отправка';

  @override
  String screenSharingBy(String name) {
    return '$name делится экраном';
  }

  @override
  String participantCount(int count) {
    return '$count участников';
  }

  @override
  String get muteLabel => 'Без звука';

  @override
  String get unmuteLabel => 'Со звуком';

  @override
  String get turnOffVideo => 'Выключить видео';

  @override
  String get turnOnVideo => 'Включить видео';

  @override
  String get shareScreen => 'Поделиться экраном';

  @override
  String get stopSharing => 'Прекратить отправку';

  @override
  String get switchCameraLabel => 'Переключить';

  @override
  String get leaveLabel => 'Покинуть';

  @override
  String get participantsLabel => 'Участники';

  @override
  String get joiningMeeting => 'Присоединение к конференции...';

  @override
  String pollVotesFormat(int count, String percentage) {
    return '$count голосов ($percentage%)';
  }

  @override
  String pollParticipantsFormat(int count) {
    return '$count участников';
  }

  @override
  String get tapToRetry => 'Нажмите, чтобы повторить';

  @override
  String get noConversationsToForward => 'Нет бесед для пересылки';

  @override
  String get defaultRedPacketGreeting => 'Желаю процветания и удачи';

  @override
  String get emojiCategoryFace => 'Смайлики';

  @override
  String get emojiCategoryHeart => 'Сердечки';

  @override
  String get emojiCategoryAnimal => 'Животные';

  @override
  String get emojiCategoryFood => 'Еда';

  @override
  String get emojiCategoryTransport => 'Транспорт';

  @override
  String get emojiCategoryActivity => 'Активности';

  @override
  String get emojiCategoryObject => 'Предметы';

  @override
  String get emojiCategorySymbol => 'Символы';

  @override
  String get allowOthersToSearchAndJoin =>
      'Разрешить другим пользователям искать и присоединяться';

  @override
  String get allowStrangerMessages => 'Разрешить сообщения от незнакомцев';

  @override
  String get alwaysUseDarkTheme => 'Всегда использовать тёмную тему';

  @override
  String get alwaysUseLightTheme => 'Всегда использовать светлую тему';

  @override
  String get autoSwitchBySystem =>
      'Автоматически переключаться по настройкам системы';

  @override
  String get bubbleStyle => 'Стиль пузырей';

  @override
  String get bubbleStyleClassic => 'Классический стиль';

  @override
  String get bubbleStyleClassicDesc => 'Традиционный стиль пузырей';

  @override
  String get bubbleStyleModern => 'Современный стиль';

  @override
  String get bubbleStyleModernDesc => 'Чистый современный стиль пузырей';

  @override
  String get bubbleStyleWechat => 'Стиль WeChat';

  @override
  String get bubbleStyleWechatDesc => 'Классический стиль пузырей WeChat';

  @override
  String get callEnded => 'Звонок завершён';

  @override
  String get callFailed => 'Звонок не удался';

  @override
  String get checkForUpdates => 'Проверить обновления';

  @override
  String get confirmClearChatHistory =>
      'Вы уверены, что хотите очистить историю чата?';

  @override
  String get createGroupToChat => 'Создайте группу, чтобы начать общение';

  @override
  String get darkMode => 'Тёмный режим';

  @override
  String get darkModeOption => 'Тёмный режим';

  @override
  String get doNotDisturbDescription =>
      'Не получать уведомления в указанное время';

  @override
  String get doNotDisturbMode => 'Не беспокоить';

  @override
  String get editGroupAnnouncement => 'Редактировать объявление группы';

  @override
  String get editGroupDescription => 'Редактировать описание группы';

  @override
  String get enterGroupAnnouncement => 'Введите объявление группы';

  @override
  String errorWithMessage(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get feedbackAndSuggestions => 'Отзывы и предложения';

  @override
  String get followSystem => 'Следовать системе';

  @override
  String get fontSize => 'Размер шрифта';

  @override
  String get fontSizeExtraLarge => 'Очень большой';

  @override
  String get fontSizeLarge => 'Большой';

  @override
  String get fontSizeSmall => 'Маленький';

  @override
  String get fontSizeStandard => 'Стандартный';

  @override
  String get incomingVideoCall => 'Входящий видеозвонок';

  @override
  String get incomingVoiceCall => 'Входящий голосовой звонок';

  @override
  String get letOthersKnowYouRead => 'Показывать, что вы прочитали сообщения';

  @override
  String get letOthersKnowYouTyping => 'Показывать, что вы печатаете';

  @override
  String get lightMode => 'Светлый режим';

  @override
  String memberCountClickToCopy(int count) {
    return '$count участников, нажмите для копирования ID группы';
  }

  @override
  String get messageNotifications => 'Уведомления о сообщениях';

  @override
  String get messagesLabel => 'Сообщения';

  @override
  String get musicLinkLabel => 'Ссылка на музыку';

  @override
  String get noMediaUrlAvailable => 'URL медиа недоступен';

  @override
  String get noPermissionToEditGroupName =>
      'У вас нет прав для изменения названия группы';

  @override
  String get receiveMessagesFromNonContacts =>
      'Получать сообщения от тех, кого нет в контактах';

  @override
  String get receiveNewMessageNotifications =>
      'Получать уведомления о новых сообщениях';

  @override
  String get reconnectingCall => 'Переподключение...';

  @override
  String get redPacketTransferCannotForward =>
      'Красные конверты и переводы нельзя пересылать';

  @override
  String get showMessageContentInNotification =>
      'Показывать содержимое сообщения в уведомлениях';

  @override
  String get showMessagePreview => 'Показывать предпросмотр сообщения';

  @override
  String get typingIndicator => 'Индикатор набора';

  @override
  String versionInfo(String version) {
    return 'Версия $version';
  }

  @override
  String get vibration => 'Вибрация';

  @override
  String get videoCallInProgress => 'Видеозвонок';

  @override
  String get voiceCallInProgress => 'Голосовой звонок';

  @override
  String whoCanSeeTitle(String title) {
    return 'Кто может видеть $title';
  }

  @override
  String get emailAddress => 'Адрес электронной почты';

  @override
  String get enterEmailAddress => 'Введите адрес электронной почты';

  @override
  String get emailRecoveryHint => 'Используется для восстановления пароля';

  @override
  String get invalidEmailFormat =>
      'Введите действительный адрес электронной почты';

  @override
  String get optional => 'Необязательно';

  @override
  String get resetPassword => 'Сбросить пароль';

  @override
  String get resetPasswordTitle => 'Сбросить пароль';

  @override
  String get enterRegisteredEmail =>
      'Введите адрес электронной почты, с которым вы зарегистрировались';

  @override
  String get sendResetCode => 'Отправить код сброса';

  @override
  String resetCodeSent(String email) {
    return 'Код сброса отправлен на $email';
  }

  @override
  String get enterResetCode => 'Введите код сброса';

  @override
  String get setNewPassword => 'Установить новый пароль';

  @override
  String get confirmNewPassword => 'Подтвердите новый пароль';

  @override
  String get newPassword => 'Новый пароль';

  @override
  String get passwordResetSuccess =>
      'Пароль успешно сброшен. Войдите с новым паролем.';

  @override
  String get resetPasswordFailed => 'Не удалось сбросить пароль';

  @override
  String get changePassword => 'Изменить пароль';

  @override
  String get currentPassword => 'Текущий пароль';

  @override
  String get enterCurrentPassword => 'Введите текущий пароль';

  @override
  String get enterNewPassword => 'Введите новый пароль';

  @override
  String get passwordChanged =>
      'Пароль успешно изменен. Войдите с новым паролем.';

  @override
  String get changePasswordFailed => 'Не удалось изменить пароль';

  @override
  String get incorrectCurrentPassword => 'Неверный текущий пароль';

  @override
  String get newPasswordMustBeDifferent =>
      'Новый пароль должен отличаться от текущего';

  @override
  String get changePasswordInfo =>
      'После изменения пароля вы будете отключены и должны будете войти с новым паролем.';

  @override
  String get passwordRequirements => 'Требования к паролю:';

  @override
  String get securityNote =>
      'В целях безопасности вам нужно будет войти заново на всех устройствах после изменения пароля.';

  @override
  String get security => 'Безопасность';

  @override
  String get currentBoundEmail => 'Текущий привязанный email';

  @override
  String get newEmailAddress => 'Новый адрес электронной почты';

  @override
  String get enterNewEmail => 'Введите новый адрес электронной почты';

  @override
  String get verificationCode => 'Код подтверждения';

  @override
  String get verificationCodeSent => 'Код подтверждения отправлен';

  @override
  String get codeSentTo => 'Код подтверждения отправлен на';

  @override
  String get didNotReceiveCode => 'Не получили код?';

  @override
  String get emailChangedSuccess => 'Email успешно изменен';

  @override
  String get changeEmailFailed => 'Не удалось изменить email';

  @override
  String get emailSecurityNote =>
      'Ваш email используется для восстановления пароля. Храните его в безопасности.';

  @override
  String get googleLogin => 'Войти через Google';

  @override
  String get appleLogin => 'Войти через Apple';

  @override
  String get facebookLogin => 'Войти через Facebook';

  @override
  String get twitterLogin => 'Войти через Twitter';

  @override
  String get wechatLogin => 'Войти через WeChat';

  @override
  String get wechat => 'WeChat';

  @override
  String get facebook => 'Facebook';

  @override
  String get twitter => 'Twitter';

  @override
  String get wechatNotInstalled => 'Сначала установите WeChat';

  @override
  String get wechatLoginFailed => 'Ошибка входа через WeChat';

  @override
  String get facebookLoginFailed => 'Ошибка входа через Facebook';

  @override
  String get twitterLoginFailed => 'Ошибка входа через Twitter';

  @override
  String get twitterNotConfigured => 'Вход через Twitter не настроен';

  @override
  String get socialLoginCancelled => 'Вход отменен';

  @override
  String get socialLoginFailed => 'Не удалось войти через социальную сеть';

  @override
  String get language => 'Язык';

  @override
  String get languageChanged => 'Язык изменен';

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
  String get n42BeanTitle => 'N42 Bean';

  @override
  String get n42BeanDetails => 'Детали N42 Bean';

  @override
  String get noN42Bean => 'Нет N42 Bean';

  @override
  String get n42BeanDescription =>
      'N42 Bean — токен для обмена на виртуальные предметы и услуги в N42. Сейчас доступно:';

  @override
  String get n42BeanFeature1 => 'Эксклюзивные стикеры и темы для участников';

  @override
  String get n42BeanFeature2 => 'Настройка пузырей чата';

  @override
  String get n42BeanFeature3 => 'Настройка обложек красных конвертов';

  @override
  String get n42BeanFeature4 => 'Эксклюзивный значок никнейма';

  @override
  String get n42BeanFeature5 => 'Привилегии группового чата';

  @override
  String get n42BeanFeature6 => 'Расширение облачного хранилища';

  @override
  String get n42BeanFeature7 => 'Фильтры красоты для видеозвонков';

  @override
  String get n42BeanFeature8 => 'Настройка фона Moments';

  @override
  String get n42BeanFeature9 => 'Приоритет VIP-обслуживания';

  @override
  String get gotIt => 'Понятно';

  @override
  String get noN42BeanRecords => 'Нет записей N42 Bean';

  @override
  String get cameraPermissionRestricted =>
      'Доступ к камере ограничен на этом устройстве';
}
